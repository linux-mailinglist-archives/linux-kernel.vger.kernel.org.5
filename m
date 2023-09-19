Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91D07A60B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjISLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjISLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:07:46 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405FBE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:07:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578afd8b46cso611168a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695121646; x=1695726446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hsdGjQZGnP/Hgbj+isSRCEfwtgkvdGEZgfqlQov6O6g=;
        b=mOi0WJ/2QRv7JGjWYd1/CDX911VSXRR3wUBnJdDyWzNSICeyqxXDKCZ/vJGgf9H7zB
         N04ePpX0pbuVoC29ADDNhEpj0AVi6HIi4/EzMLnnx2X4qA1ghub5lgKrUMjGTpUNYrR1
         uSG6l6xUTWkwAoeC/6kMxNLsw49oPC8ADWTEuLPh6ES9MvYgxSyfMbvOtUCM+6x3fCW6
         JS0BR+eO+bdUzVDjAtVSHp0RG32aHro3ZSDC3JDtxmVwhlZKhc+pdG63glR8ZbA7cWy9
         LOIZK2wro13WClSAN/frxtCs7c934CcmN5VDv4zcRJeFa+09d87IJmMaCeO/EjdU0BUf
         c0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695121646; x=1695726446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsdGjQZGnP/Hgbj+isSRCEfwtgkvdGEZgfqlQov6O6g=;
        b=eiyAHpyJXevKMAecpiLgcxL+1cJ5Xc6nRckYtuY2A1yY9iizNl64+joCKPY8WN20LJ
         WI6MbD4XQform30HriIfsCeKTPHCCZb3/7Qyh1RkTb3w8h/2ekUx5If44eonckBHxj/w
         ao6oRaOsjfnLHaDO1yyd4Ky2eVRDgQvHC3c6n8S1N/Ri+X79JHPy5BB6ABw6rx9nEibR
         MvN/u88vroxybe0VMNJaOdHyg+twjQjdUOIUH1tFlFSYUYBc8oPD31cdxsxe78F9G+qj
         Shgu7wwir3zyW/ybJsPuFdRiFpWuHlAMFphpj5x80pb+xSP351MDI6oXKRaYnRAuevGu
         bQ7w==
X-Gm-Message-State: AOJu0YwesS7reaGPvpkOar1jfy2Yq8gn83WEhYyvk2P0lkeB2IIXmdSl
        2/APKyINHPKYPM9tnG5UgOSSwt0Iv5EML4wlEqyVeg==
X-Google-Smtp-Source: AGHT+IEqV3rAGeUMd9XYB//AVpAjXOCe2sj8rwL3pSAMvmQKe1yXtlqOvCzhfuPwDqzf2LTW/BEap8fm1SYbtT2vCrU=
X-Received: by 2002:a17:90a:fd98:b0:274:686d:497b with SMTP id
 cx24-20020a17090afd9800b00274686d497bmr10019600pjb.27.1695121645629; Tue, 19
 Sep 2023 04:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230915093649.435163-1-anshuman.khandual@arm.com> <20230915093649.435163-3-anshuman.khandual@arm.com>
In-Reply-To: <20230915093649.435163-3-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Sep 2023 12:07:14 +0100
Message-ID: <CAJ9a7Vh_vJihzSx1zsK9Qv4iEv414WH245N3j2c3bhYNkm5SJQ@mail.gmail.com>
Subject: Re: [PATCH V5 - RESEND 2/3] coresight: etm: Make cycle count
 threshold user configurable
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 10:37, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Cycle counting is enabled, when requested and supported but with a default
> threshold value ETM_CYC_THRESHOLD_DEFAULT i.e 0x100 getting into TRCCCCTLR,
> representing the minimum interval between cycle count trace packets.
>
> This makes cycle threshold user configurable, from the user space via perf
> event attributes. Although it falls back using ETM_CYC_THRESHOLD_DEFAULT,
> in case no explicit request. As expected it creates a sysfs file as well.
>
> /sys/bus/event_source/devices/cs_etm/format/cc_threshold
>
> New 'cc_threshold' uses 'event->attr.config3' as no more space is available
> in 'event->attr.config1' or 'event->attr.config2'.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c   | 2 ++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 +++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 5ca6278baff4..09f75dffae60 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -68,6 +68,7 @@ PMU_FORMAT_ATTR(preset,               "config:0-3");
>  PMU_FORMAT_ATTR(sinkid,                "config2:0-31");
>  /* config ID - set if a system configuration is selected */
>  PMU_FORMAT_ATTR(configid,      "config2:32-63");
> +PMU_FORMAT_ATTR(cc_threshold,  "config3:0-11");
>
>
>  /*
> @@ -101,6 +102,7 @@ static struct attribute *etm_config_formats_attr[] = {
>         &format_attr_preset.attr,
>         &format_attr_configid.attr,
>         &format_attr_branch_broadcast.attr,
> +       &format_attr_cc_threshold.attr,
>         NULL,
>  };
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index c01455bb1caf..044aed25979b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -644,7 +644,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>         struct etmv4_config *config = &drvdata->config;
>         struct perf_event_attr *attr = &event->attr;
>         unsigned long cfg_hash;
> -       int preset;
> +       int preset, cc_threshold;
>
>         /* Clear configuration from previous run */
>         memset(config, 0, sizeof(struct etmv4_config));
> @@ -667,7 +667,12 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
>         if (attr->config & BIT(ETM_OPT_CYCACC)) {
>                 config->cfg |= TRCCONFIGR_CCI;
>                 /* TRM: Must program this for cycacc to work */
> -               config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
> +               cc_threshold = attr->config3 & ETM_CYC_THRESHOLD_MASK;
> +               if (!cc_threshold)
> +                       cc_threshold = ETM_CYC_THRESHOLD_DEFAULT;
> +               if (cc_threshold < drvdata->ccitmin)
> +                       cc_threshold = drvdata->ccitmin;
> +               config->ccctlr = cc_threshold;
>         }
>         if (attr->config & BIT(ETM_OPT_TS)) {
>                 /*
> --
> 2.25.1
>

Reviewed-by: Mike Leach  <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
