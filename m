Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D157799A34
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjIIRNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjIIRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:13:34 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E0D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 10:13:28 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id f1WNquSRRamq0f1WNqSB7z; Sat, 09 Sep 2023 19:13:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694279606;
        bh=PGRrRWS8LvFpm8TAIu7Dr4Mq4RBNyDM7x2koZeqiqv0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dotV6GzyPUPgaeghjs0wZ3iM6kbhQFBzSJIjRqcC9FRETk4vS+tpIvwZ3CrT4vX6W
         Vlhxk203G2NKTCUiGhcogwylf+k0iXzX1bFQQRZiNp8pdh48Y1alPn9PQ2SfpOrxld
         keg0Q7hgiB/WNiApyGYdT8nLdTmilhHkJpOm4NoItlfNmcTiRs3XGkaCDV44kb0bvN
         vzbjdWo+Y6tNm1+3dAbafNxHNi1qltjpXoCteU38jzCIpskJcRFvM/P4TtMjRwCYDL
         2/bubVugGHAEhSUX/lu7KILKXBW3l9VV7562z3/J2RblIDZs+e6q/U2lxyjLD8QaoC
         7Pjy/BqyKs3Kw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Sep 2023 19:13:26 +0200
X-ME-IP: 86.243.2.178
Message-ID: <1923f5dc-9cbe-e2bb-f9a6-5687dfa2faff@wanadoo.fr>
Date:   Sat, 9 Sep 2023 19:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] cpufreq: qcom-nvmem: add support for IPQ8064
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, ansuelsmth@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ilia.lin@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, nm@ti.com, rafael@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, vireshk@kernel.org
References: <20230909165739.1036263-1-robimarko@gmail.com>
 <20230909165739.1036263-3-robimarko@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230909165739.1036263-3-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/09/2023 à 18:56, Robert Marko a écrit :
> From: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> IPQ8064 comes in 3 families:
> * IPQ8062 up to 1.0GHz
> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> * IPQ8065/IPQ8069 up to 1.7Ghz
> 
> So, in order to be able to support one OPP table, add support for
> IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
> opp-supported-hw can be correctly used.
> 
> Bit are set with the following logic:
> * IPQ8062 BIT 0
> * IPQ8064/IPQ8066/IPQ8068 BIT 1
> * IPQ8065/IPQ8069 BIT 2
> 
> speed is never fused, only pvs values are fused.
> 
> IPQ806x SoC doesn't have pvs_version so we drop and we use the new
> pattern:
> opp-microvolt-speed0-pvs<PSV_VALUE>
> 
> Example:
> - for ipq8062 psv2
>    opp-microvolt-speed0-pvs2 = < 925000 878750 971250>
> 
> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Robert Marko <robimarko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes in v3:
> * Use enum for SoC version
> * Dont evaluate speed as its not fused, only pvs
> 
> Changes in v2:
> * Include IPQ8064 support
> ---
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 68 +++++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index ba9e1d60e5b5..3d93b511db86 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -35,6 +35,12 @@ enum ipq8074_versions {
>   	IPQ8074_ACORN_VERSION,
>   };
>   
> +enum ipq806x_versions {
> +	IPQ8062_VERSION = 0,
> +	IPQ8064_VERSION,
> +	IPQ8065_VERSION,
> +};
> +
>   struct qcom_cpufreq_drv;
>   
>   struct qcom_cpufreq_match_data {
> @@ -208,6 +214,62 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>   	return ret;
>   }
>   
> +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	int speed = 0, pvs = 0, pvs_ver = 0;
> +	int msm_id, ret = 0;
> +	u8 *speedbin;
> +	size_t len;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	if (len != 4) {
> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> +		kfree(speedbin);
> +		return -ENODEV;
> +	}
> +
> +	get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver, speedbin);
> +
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)

Missing kfree(speedbin);?

It is freed above and in the normal path, but not here.

(or a new label at the end of the function and a goto. If done this way, 
it can also be used to the test above)

> +		return ret;
> +
> +	switch (msm_id) {
> +	case QCOM_ID_IPQ8062:
> +		drv->versions = BIT(IPQ8062_VERSION);
> +		break;
> +	case QCOM_ID_IPQ8064:
> +	case QCOM_ID_IPQ8066:
> +	case QCOM_ID_IPQ8068:
> +		drv->versions = BIT(IPQ8064_VERSION);
> +		break;
> +	case QCOM_ID_IPQ8065:
> +	case QCOM_ID_IPQ8069:
> +		drv->versions = BIT(IPQ8065_VERSION);
> +		break;
> +	default:
> +		dev_err(cpu_dev,
> +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> +			msm_id);
> +		drv->versions = BIT(IPQ8062_VERSION);
> +		break;
> +	}
> +
> +	/* IPQ8064 speed is never fused. Only pvs values are fused. */
> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
> +		 speed, pvs);
> +
> +	kfree(speedbin);
> +	return ret;
> +}
> +
>   static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>   					     struct nvmem_cell *speedbin_nvmem,
>   					     char **pvs_name,
> @@ -257,6 +319,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>   	.genpd_names = qcs404_genpd_names,
>   };
>   
> +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> +	.get_version = qcom_cpufreq_ipq8064_name_version,
> +};
> +
>   static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>   	.get_version = qcom_cpufreq_ipq8074_name_version,
>   };
> @@ -403,7 +469,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>   	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>   	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },

