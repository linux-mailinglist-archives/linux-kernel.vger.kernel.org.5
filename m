Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E3750F92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjGLRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjGLRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:23:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9C10C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:23:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f96d680399so10900975e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689182583; x=1689787383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XPaxsksQJ1TH6iZEGOUjk8TgWOqMia45twF/E2He4DE=;
        b=Z80mvnG823CbpEvanfATB6fSBt9Y0OEy0oKSZYTLVjDlVO/aWjj8Wk2tb9VqYEU0Iw
         GuLkqv2UAXclv/5WEkc+8uR3uT+vanC8IChXwGaDEkySLOlJ80HPL3/gwHjq0BA4Uczi
         LXyOg0+agBXPBCGsUcYsY15+sdIeUoS1JyC0U4xr3oX2MDsCyB0inKZUzRipetu3PvnZ
         IfiQhODECE6jw5NbEce2RsLGugS7cNWGeditPOIGGC7s9XlcNGHtMfJAij+yKSg6qAwV
         JeLMy99cXrS53UeUrf02zVEFBIkBTS94CjmSX0EbZ7qS+HcLpY2VzpMVH98/QuDPKOGc
         dE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689182583; x=1689787383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPaxsksQJ1TH6iZEGOUjk8TgWOqMia45twF/E2He4DE=;
        b=he3yJm1f+3csyxsolXlUj9Yd76TQqZcBY6K7OID7eRDqB4t1V+qu42O4CO0r7JClt6
         uvfWI1DFrZHBPcr7YG5B8jHTQeRjdmifNkLeJW8rxvz+eAFoBATm7E6a/RzJktevprHd
         nYzcqG1qhfsGloXTuRbjkSzkqN6/noh1eLmjh6p4M+WPmaPgBYkNlqPMaDoZnJsskkpm
         V5YnF2xLkmzkgWf/sAQppHbavBsWLGkU7vIiNORW0kJmG5/DvPihYgOI6WdssUIMo1XX
         WbDmt/rX1+dicGUWr+JFGkGkajLRNd0I8PVbeDY1WEyWyr81pWSHBCEV/Oc2vsrirSIT
         Zcjg==
X-Gm-Message-State: ABy/qLbQfdAeecFuiUy1tFGUZg4CV/j06o+y7b3dEyynk9clJ3IJI1e6
        c8AJQ7dN1/nbUBQj5Wlj00Nx7w==
X-Google-Smtp-Source: APBJJlGIZtbg43PJ+1uxHAV+h9svTZSPCEN2YoXLV3LMGXeS2aVo8OZgH6vyuK1ny6pAopBcAE9ihg==
X-Received: by 2002:a05:6512:36c5:b0:4fb:8f79:631 with SMTP id e5-20020a05651236c500b004fb8f790631mr15483556lfs.46.1689182583538;
        Wed, 12 Jul 2023 10:23:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l15-20020ac2554f000000b004fb87638fc4sm796860lfk.19.2023.07.12.10.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 10:23:03 -0700 (PDT)
Message-ID: <be734fa0-1b16-0dad-6205-d1f1acb1f179@linaro.org>
Date:   Wed, 12 Jul 2023 20:23:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 14/14] scsi: ufs: qcom: Add support for scaling
 interconnects
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-19-manivannan.sadhasivam@linaro.org>
 <107aad9f-40c0-f32b-9f74-6c82ee6785bf@linaro.org>
 <20230712164114.GH102757@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712164114.GH102757@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 19:41, Manivannan Sadhasivam wrote:
> On Wed, Jul 12, 2023 at 04:22:51PM +0300, Dmitry Baryshkov wrote:
>> On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
>>> Qcom SoCs require scaling the interconnect paths for proper working of the
>>> peripherals connected through interconnects. Even for accessing the UFS
>>> controller, someone should setup the interconnect paths. So far, the
>>> bootloaders used to setup the interconnect paths before booting linux as
>>> they need to access the UFS storage for things like fetching boot firmware.
>>> But with the advent of multi boot options, bootloader nowadays like in
>>> SA8540p SoC do not setup the interconnect paths at all.
>>>
>>> So trying to configure UFS in the absence of the interconnect path
>>> configuration, results in boot crash.
>>>
>>> To fix this issue and also to dynamically scale the interconnects (UFS-DDR
>>> and CPU-UFS), interconnect API support is added to the Qcom UFS driver.
>>> With this support, the interconnect paths are scaled dynamically based on
>>> the gear configuration.
>>>
>>> During the early stage of ufs_qcom_init(), ufs_qcom_icc_init() will setup
>>> the paths to max bandwidth to allow configuring the UFS registers. Touching
>>> the registers without configuring the icc paths would result in a crash.
>>> However, we don't really need to set max vote for the icc paths as any
>>> minimal vote would suffice. But the max value would allow initialization to
>>> be done faster. After init, the bandwidth will get updated using
>>> ufs_qcom_icc_update_bw() based on the gear and lane configuration.
>>>
>>> The bandwidth values defined in ufs_qcom_bw_table struct are taken from
>>> Qcom downstream vendor devicetree source and are calculated as per the
>>> UFS3.1 Spec, Section 6.4.1, HS Gear Rates. So it is fixed across platforms.
>>>
>>> Cc: Brian Masney <bmasney@redhat.com>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/ufs/host/ufs-qcom.c | 131 +++++++++++++++++++++++++++++++++++-
>>>    drivers/ufs/host/ufs-qcom.h |   3 +
>>>    2 files changed, 133 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>> index 8d6fd4c3324f..8a3132d45a65 100644
>>> --- a/drivers/ufs/host/ufs-qcom.c
>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>> @@ -7,6 +7,7 @@
>>>    #include <linux/time.h>
>>>    #include <linux/clk.h>
>>>    #include <linux/delay.h>
>>> +#include <linux/interconnect.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of.h>
>>>    #include <linux/platform_device.h>
>>> @@ -46,6 +47,49 @@ enum {
>>>    	TSTBUS_MAX,
>>>    };
>>> +#define QCOM_UFS_MAX_GEAR 4
>>> +#define QCOM_UFS_MAX_LANE 2
>>> +
>>> +enum {
>>> +	MODE_MIN,
>>> +	MODE_PWM,
>>> +	MODE_HS_RA,
>>> +	MODE_HS_RB,
>>> +	MODE_MAX,
>>
>> MODE_MIN and MODE_MAX seem to be unused
>>
> 
> No, they are used in the driver.

Ack, missed that. Will comment inline.

> 
>>> +};
>>> +
>>> +struct __ufs_qcom_bw_table {
>>> +	u32 bw1;
>>> +	u32 bw2;
>>
>> Please consider:
>>
>> s/bw1/mem_bw/
>> s/bw2/cfg_bw/
>>
> 
> Ok.
> 
>>> +} ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
>>
>> I'd say, these +1's are slightly confusing and unnecessary.
>>
> 
> These max values itself are used in the table. Without adding 1 to them, we will
> end up with out of bounds access.



> 
>>> +	[MODE_MIN][0][0] = { 0,		0 },	/* Bandwidth values are in KB/s */
>>
>> I'd say, this becomes impossible to check. Can you please structure it?
> 
> What do you mean by "impossible to check"?
> 
>> Either by inclusion:
>>
>> [MODE_PWM] = {
>>    [1] = {
>>       [1] = { .. },
>>       [2] = { .. },
>>    },
>>    // etc.
> 
> Now, this seems confusion to me. The existing table looks fine IMO.

Fine with me then, your call!

> 
>> };
>>
>> Also, do we have defines for gears? Can we use them instead of indices?
>>
> 
> There are defines for the gears but not for lanes. So I ended up using numbers
> for simplicity.

My suggestion would be to use them for gears at least. Then it becomes 
cleaner (and maybe will solve some of my other comments).

> 
> - Mani
> 
>>> +	[MODE_PWM][1][1] = { 922,	1000 },
>>> +	[MODE_PWM][2][1] = { 1844,	1000 },
>>> +	[MODE_PWM][3][1] = { 3688,	1000 },
>>> +	[MODE_PWM][4][1] = { 7376,	1000 },
>>> +	[MODE_PWM][1][2] = { 1844,	1000 },
>>> +	[MODE_PWM][2][2] = { 3688,	1000 },
>>> +	[MODE_PWM][3][2] = { 7376,	1000 },
>>> +	[MODE_PWM][4][2] = { 14752,	1000 },
>>> +	[MODE_HS_RA][1][1] = { 127796,	1000 },
>>> +	[MODE_HS_RA][2][1] = { 255591,	1000 },
>>> +	[MODE_HS_RA][3][1] = { 1492582,	102400 },
>>> +	[MODE_HS_RA][4][1] = { 2915200,	204800 },
>>> +	[MODE_HS_RA][1][2] = { 255591,	1000 },
>>> +	[MODE_HS_RA][2][2] = { 511181,	1000 },
>>> +	[MODE_HS_RA][3][2] = { 1492582,	204800 },
>>> +	[MODE_HS_RA][4][2] = { 2915200,	409600 },
>>> +	[MODE_HS_RB][1][1] = { 149422,	1000 },
>>> +	[MODE_HS_RB][2][1] = { 298189,	1000 },
>>> +	[MODE_HS_RB][3][1] = { 1492582,	102400 },
>>> +	[MODE_HS_RB][4][1] = { 2915200,	204800 },
>>> +	[MODE_HS_RB][1][2] = { 298189,	1000 },
>>> +	[MODE_HS_RB][2][2] = { 596378,	1000 },
>>> +	[MODE_HS_RB][3][2] = { 1492582,	204800 },
>>> +	[MODE_HS_RB][4][2] = { 2915200,	409600 },
>>> +	[MODE_MAX][0][0] = { 7643136, 307200 },
>>> +};
>>> +
>>>    static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
>>>    static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
>>> @@ -789,6 +833,51 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_qcom_host *host, bool enable)
>>>    	}
>>>    }
>>> +static int ufs_qcom_icc_set_bw(struct ufs_qcom_host *host, u32 bw1, u32 bw2)
>>> +{
>>> +	struct device *dev = host->hba->dev;
>>> +	int ret;
>>> +
>>> +	ret = icc_set_bw(host->icc_ddr, 0, bw1);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = icc_set_bw(host->icc_cpu, 0, bw2);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to set bandwidth request: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct __ufs_qcom_bw_table ufs_qcom_get_bw_table(struct ufs_qcom_host *host)
>>> +{
>>> +	struct ufs_pa_layer_attr *p = &host->dev_req_params;
>>> +	int gear = max_t(u32, p->gear_rx, p->gear_tx);
>>> +	int lane = max_t(u32, p->lane_rx, p->lane_tx);
>>> +
>>> +	if (ufshcd_is_hs_mode(p)) {
>>> +		if (p->hs_rate == PA_HS_MODE_B)
>>> +			return ufs_qcom_bw_table[MODE_HS_RB][gear][lane];
>>> +		else
>>> +			return ufs_qcom_bw_table[MODE_HS_RA][gear][lane];
>>> +	} else {
>>> +		return ufs_qcom_bw_table[MODE_PWM][gear][lane];
>>> +	}
>>> +}
>>> +
>>> +static int ufs_qcom_icc_update_bw(struct ufs_qcom_host *host)
>>> +{
>>> +	struct __ufs_qcom_bw_table bw_table;
>>> +
>>> +	bw_table = ufs_qcom_get_bw_table(host);
>>> +
>>> +	return ufs_qcom_icc_set_bw(host, bw_table.bw1, bw_table.bw2);
>>> +}
>>> +
>>>    static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>>    				enum ufs_notify_change_status status,
>>>    				struct ufs_pa_layer_attr *dev_max_params,
>>> @@ -852,6 +941,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>>    		memcpy(&host->dev_req_params,
>>>    				dev_req_params, sizeof(*dev_req_params));
>>> +		ufs_qcom_icc_update_bw(host);
>>> +
>>>    		/* disable the device ref clock if entered PWM mode */
>>>    		if (ufshcd_is_hs_mode(&hba->pwr_info) &&
>>>    			!ufshcd_is_hs_mode(dev_req_params))
>>> @@ -981,7 +1072,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>>>    	switch (status) {
>>>    	case PRE_CHANGE:
>>> -		if (!on) {
>>> +		if (on) {
>>> +			ufs_qcom_icc_update_bw(host);
>>> +		} else {
>>>    			if (!ufs_qcom_is_link_active(hba)) {
>>>    				/* disable device ref_clk */
>>>    				ufs_qcom_dev_ref_clk_ctrl(host, false);
>>> @@ -993,6 +1086,9 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>>>    			/* enable the device ref clock for HS mode*/
>>>    			if (ufshcd_is_hs_mode(&hba->pwr_info))
>>>    				ufs_qcom_dev_ref_clk_ctrl(host, true);
>>> +		} else {
>>> +			ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MIN][0][0].bw1,
>>> +					    ufs_qcom_bw_table[MODE_MIN][0][0].bw2);

With MODE_MIN values being initialised to 0, can we use the value 
directly instead? You are not defining the whole table for MODE_MIN anyway.

>>>    		}
>>>    		break;
>>>    	}
>>> @@ -1031,6 +1127,34 @@ static const struct reset_control_ops ufs_qcom_reset_ops = {
>>>    	.deassert = ufs_qcom_reset_deassert,
>>>    };
>>> +static int ufs_qcom_icc_init(struct ufs_qcom_host *host)
>>> +{
>>> +	struct device *dev = host->hba->dev;
>>> +	int ret;
>>> +
>>> +	host->icc_ddr = devm_of_icc_get(dev, "ufs-ddr");
>>> +	if (IS_ERR(host->icc_ddr))
>>> +		return dev_err_probe(dev, PTR_ERR(host->icc_ddr),
>>> +				    "failed to acquire interconnect path\n");
>>> +
>>> +	host->icc_cpu = devm_of_icc_get(dev, "cpu-ufs");
>>> +	if (IS_ERR(host->icc_cpu))
>>> +		return dev_err_probe(dev, PTR_ERR(host->icc_cpu),
>>> +				    "failed to acquire interconnect path\n");
>>> +
>>> +	/*
>>> +	 * Set Maximum bandwidth vote before initializing the UFS controller and
>>> +	 * device. Ideally, a minimal interconnect vote would suffice for the
>>> +	 * initialization, but a max vote would allow faster initialization.
>>> +	 */
>>> +	ret = ufs_qcom_icc_set_bw(host, ufs_qcom_bw_table[MODE_MAX][0][0].bw1,
>>> +				  ufs_qcom_bw_table[MODE_MAX][0][0].bw2);

If this is a static value, can we define it separately? You don't have a 
full gear/lanes enumeration anyway.

>>> +	if (ret < 0)
>>> +		return dev_err_probe(dev, ret, "failed to set bandwidth request\n");
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    /**
>>>     * ufs_qcom_init - bind phy with controller
>>>     * @hba: host controller instance
>>> @@ -1085,6 +1209,10 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>>>    		}
>>>    	}
>>> +	err = ufs_qcom_icc_init(host);
>>> +	if (err)
>>> +		goto out_variant_clear;
>>> +
>>>    	host->device_reset = devm_gpiod_get_optional(dev, "reset",
>>>    						     GPIOD_OUT_HIGH);
>>>    	if (IS_ERR(host->device_reset)) {
>>> @@ -1282,6 +1410,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>>>    				    dev_req_params->pwr_rx,
>>>    				    dev_req_params->hs_rate,
>>>    				    false);
>>> +		ufs_qcom_icc_update_bw(host);
>>>    		ufshcd_uic_hibern8_exit(hba);
>>>    	}
>>> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
>>> index 6289ad5a42d0..dc27395ecba1 100644
>>> --- a/drivers/ufs/host/ufs-qcom.h
>>> +++ b/drivers/ufs/host/ufs-qcom.h
>>> @@ -206,6 +206,9 @@ struct ufs_qcom_host {
>>>    	struct clk *tx_l1_sync_clk;
>>>    	bool is_lane_clks_enabled;
>>> +	struct icc_path *icc_ddr;
>>> +	struct icc_path *icc_cpu;
>>> +
>>>    #ifdef CONFIG_SCSI_UFS_CRYPTO
>>>    	struct qcom_ice *ice;
>>>    #endif
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry

