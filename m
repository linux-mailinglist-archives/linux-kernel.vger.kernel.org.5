Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5B7BFD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjJJNeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjJJNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:34:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF612B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:34:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c1807f3400so69203401fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696944847; x=1697549647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3ufIXJTPDUi37xaLcqz/JBb6qC8rajJx6bDQbsS0J0=;
        b=ElIIARZi+gjhG5QuyVguoYsd8Apv1+991gibzG3e6XtnvwBQuWni0ctTDtF6P6IfKX
         cMKIMdMeM7Fa0o1qLt6UaqufAcFtIgB137r4MDUNZLoWQ0ctgenGWe9rg6jQrcDvnCvC
         +XVUpaejSva0sR3d7+3IKq9XygWUpSe8TyEPHTv27I4E3ci4Z/+LNfowWDxQ16oacQDJ
         GSbIMNEXIjNLaEy1b10MKpKhnaEmdSO97bqmE8JgzmVvBYmgM/xTrJme2bFR/ChnKqqK
         6ysJrjPjs+8thv7pb7Es4RLCuJf42jZVDfuCjXRGLPqZZn6aJ/JbVzKB5ihDge5BHdu3
         mO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944847; x=1697549647;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3ufIXJTPDUi37xaLcqz/JBb6qC8rajJx6bDQbsS0J0=;
        b=ubSIpxK50GvTHgTA+P4W8IHxZEGxbEh55lus6fnVmIANzAUTd7+JudnqP/p+mnoYsC
         FtuBtIg8ILU9Fs1/UZDPKN+1PNxZfmzjCEJKw7LRHCsgpCSygiRef0tqxY966JBAGlG7
         OhaWWUnFxKhNbdihrsYrhYsU0r0yrE7MvN+ZSs/FaYVin4u3Ut6jF9+72uRDkWtAkVSt
         +L6guaCCfcsNPQ+4pN0Ut6w8MDRrM0PsK/+YqNvvTwWz8OHe680/S5UF9WSxeN/G5bcZ
         VvxSBbPBQBXLTB2OtdhfoUVbqnkUHzBAAKdlfeK4yGFE1SoknomQpqUgl67L1sLNdVUr
         bibg==
X-Gm-Message-State: AOJu0YzGFjxIkNk5YTJ8ke+4TYxSszZXcWmxnP+cNnCzN0vdsKSAyR59
        RFfi46oDm6WmQM83LAPs+xacNCZ3ajcBq2/USu8=
X-Google-Smtp-Source: AGHT+IHVlEd6wxtkukWJ4E28XaOUeg+7a2DayqjOWtQGYvIOrLbjENhKkn7cfLUU3G4liOCJKbax5w==
X-Received: by 2002:a2e:90c3:0:b0:2c0:172b:dc2b with SMTP id o3-20020a2e90c3000000b002c0172bdc2bmr11490692ljg.14.1696944846944;
        Tue, 10 Oct 2023 06:34:06 -0700 (PDT)
Received: from [172.30.204.192] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id e9-20020a2e8189000000b002c12630e4d3sm2452017ljg.127.2023.10.10.06.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:34:06 -0700 (PDT)
Message-ID: <d0714c75-e827-4bbc-a854-59004cab2563@linaro.org>
Date:   Tue, 10 Oct 2023 15:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] cpufreq: qcom-nvmem: add support for IPQ8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230930102218.229613-1-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230930102218.229613-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 12:21, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v4:
> * Add support for IPQ8174 (Oak) family
> 
> Changes in v3:
> * Use enum for SoC versions
> 
> Changes in v2:
> * Print an error if SMEM ID is not part of the IPQ8074 family
> and restrict the speed to Acorn variant (1.4GHz)
> 
>   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 45 ++++++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2016d47889c0..157c91b9962c 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -180,6 +180,7 @@ static const struct of_device_id blocklist[] __initconst = {
>   	{ .compatible = "ti,am62a7", },
>   
>   	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,ipq8074", },
>   	{ .compatible = "qcom,apq8064", },
>   	{ .compatible = "qcom,msm8974", },
>   	{ .compatible = "qcom,msm8960", },
Generally this lands in a separate commit, but I guess since Viresh 
takes changes to both of the files, it's even better..

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
