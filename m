Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1657A60AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjISLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjISLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:07:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780351733
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:06:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578cc95db68so3234a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695121587; x=1695726387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+z6CWyEuDsHy6cJM7H1wCDvrxtpnfWLUKRjtBTGVGLo=;
        b=VhK12LbDhyE8s04x2ovGGPEeHntPRtCDComffpgx/8wdsZfGE1yjVZfrqpHZFMmMp7
         mNJTThFMIaHikbbIoOGFK5lXyA6pk4QsKwtnksIaWrHh7YhPYF1zcmdNSgwdbTzN4nEN
         T0mML78dllb4UUP7E8d5fOGtrvvx3ocFDNRjm/cO/MhUB0hykXZZYIgIaePcsq4MCdqt
         vuKiSrB6hPl72I0ljAo0sClJlBIFpahpJhAejHnTrQy497J/wL/6UG+kJp2a8K6fJp+C
         MvhluEAYNdGiV9ph7B2unwj/YOzpJVoSNZ5PItzmKJA+HfqoQhOTR+Dv5vIiTzjGULwY
         qWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121587; x=1695726387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z6CWyEuDsHy6cJM7H1wCDvrxtpnfWLUKRjtBTGVGLo=;
        b=uo6rH4JuO+Ed2/iEaDEbAJ1steuIQvl6MoYzzMLILgTHJTyW8210ppLt9/1aG5NKWD
         CgTEDpcQtMnjT4Kyu16ksg/GY0/pIdN9tul6siaCZ7LL1KcfICR4oBEVBl05rh48Ssxf
         v70bECaRyW86GU3tuBY4OgWkQ8m+KnoO+jMLZoi6uB58hdxSZnhMUIkE7B0wDID4XPLt
         AbztJxbxO+NC//o7Q1a8XNnBqrXFcwEsCl1Nu6R4RrQb7HDxzPCcgx+7gbTwSpAsZlGj
         ZgooYzE4TZxrz3x+qHbK+nXu0Ac99cxLbFPqcd2a3YuoPyWRU/5c28eIAXfmQ/fB0Hsz
         u1sg==
X-Gm-Message-State: AOJu0Yygga2P6RDH51iJc+ofMqpjtL7Ewj9198AzJzczZgDK1DexG7iy
        MHzavh7tI3fTmCiE/nDPEmNKBqQ+Y5SAApXypJaxCQ==
X-Google-Smtp-Source: AGHT+IG2D7JZA1DWvRmxU9hlS5CJknY/LEjAfyXMotOyYZKJglhQwJdsYGoGUFNM0tWY90fcJpgQLV48QRwPH1MuI2o=
X-Received: by 2002:a17:90a:ba88:b0:276:7683:70f6 with SMTP id
 t8-20020a17090aba8800b00276768370f6mr3893003pjr.33.1695121587429; Tue, 19 Sep
 2023 04:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230915093649.435163-1-anshuman.khandual@arm.com> <20230915093649.435163-2-anshuman.khandual@arm.com>
In-Reply-To: <20230915093649.435163-2-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Sep 2023 12:06:16 +0100
Message-ID: <CAJ9a7VghAjdKU90NoR4VfAr+dr2GmzrwNCT23jzKMpdiwNzd-Q@mail.gmail.com>
Subject: Re: [PATCH V5 - RESEND 1/3] coresight: etm: Override TRCIDR3.CCITMIN
 on errata affected cpus
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 10:37, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This work arounds errata 1490853 on Cortex-A76, and Neoverse-N1, errata
> 1491015 on Cortex-A77, errata 1502854 on Cortex-X1, and errata 1619801 on
> Neoverse-V1, based affected cpus, where software read for TRCIDR3.CCITMIN
> field in ETM gets an wrong value.
>
> If software uses the value returned by the TRCIDR3.CCITMIN register field,
> then it will limit the range which could be used for programming the ETM.
> In reality, the ETM could be programmed with a much smaller value than what
> is indicated by the TRCIDR3.CCITMIN field and still function correctly.
>
> If software reads the TRCIDR3.CCITMIN register field, corresponding to the
> instruction trace counting minimum threshold, observe the value 0x100 or a
> minimum cycle count threshold of 256. The correct value should be 0x4 or a
> minimum cycle count threshold of 4.
>
> This work arounds the problem via storing 4 in drvdata->ccitmin on affected
> systems where the TRCIDR3.CCITMIN has been 256, thus preserving cycle count
> threshold granularity.
>
> These errata information has been updated in arch/arm64/silicon-errata.rst,
> but without their corresponding configs because these have been implemented
> directly in the driver.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst   | 10 ++++++
>  .../coresight/coresight-etm4x-core.c          | 36 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index e96f057ea2a0..8f1be5da68b7 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -115,6 +115,10 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A76      | #1490853        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A77      | #1491015        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
> @@ -125,6 +129,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-X1       | #1502854        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
> @@ -133,6 +139,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1349291        | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-N1     | #1490853        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
> @@ -141,6 +149,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-V1     | #1619801        | N/A                         |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-600         | #1076982,1209401| N/A                         |
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 77b0271ce6eb..c01455bb1caf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1150,6 +1150,39 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
>         drvdata->trfcr = trfcr;
>  }
>
> +/*
> + * The following errata on applicable cpu ranges, affect the CCITMIN filed
> + * in TCRIDR3 register. Software read for the field returns 0x100 limiting
> + * the cycle threshold granularity, whereas the right value should have
> + * been 0x4, which is well supported in the hardware.
> + */
> +static struct midr_range etm_wrong_ccitmin_cpus[] = {
> +       /* Erratum #1490853 - Cortex-A76 */
> +       MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 4, 0),
> +       /* Erratum #1490853 - Neoverse-N1 */
> +       MIDR_RANGE(MIDR_NEOVERSE_N1, 0, 0, 4, 0),
> +       /* Erratum #1491015 - Cortex-A77 */
> +       MIDR_RANGE(MIDR_CORTEX_A77, 0, 0, 1, 0),
> +       /* Erratum #1502854 - Cortex-X1 */
> +       MIDR_REV(MIDR_CORTEX_X1, 0, 0),
> +       /* Erratum #1619801 - Neoverse-V1 */
> +       MIDR_REV(MIDR_NEOVERSE_V1, 0, 0),
> +       {},
> +};
> +
> +static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
> +{
> +       /*
> +        * Erratum affected cpus will read 256 as the minimum
> +        * instruction trace cycle counting threshold whereas
> +        * the correct value should be 4 instead. Override the
> +        * recorded value for 'drvdata->ccitmin' to workaround
> +        * this problem.
> +        */
> +       return is_midr_in_range_list(read_cpuid_id(), etm_wrong_ccitmin_cpus) &&
> +              (drvdata->ccitmin == 256);
> +}
> +
>  static void etm4_init_arch_data(void *info)
>  {
>         u32 etmidr0;
> @@ -1214,6 +1247,9 @@ static void etm4_init_arch_data(void *info)
>         etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
>         /* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
>         drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
> +       if (etm4_core_reads_wrong_ccitmin(drvdata))
> +               drvdata->ccitmin = 4;
> +
>         /* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>         drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
>         drvdata->config.s_ex_level = drvdata->s_ex_level;
> --
> 2.25.1
>
Reviewed by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
