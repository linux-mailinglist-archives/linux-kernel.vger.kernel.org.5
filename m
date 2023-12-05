Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0F8055C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442160AbjLENYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442148AbjLENYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:24:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA119B;
        Tue,  5 Dec 2023 05:24:05 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63EB16607295;
        Tue,  5 Dec 2023 13:24:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701782644;
        bh=rgRJciFYZdx6+hvDmrRnGxCF5Q5fpD4IdOikLohD9Lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y36ItO/Uz92rvBlyZxPWhCjRVz3ezKxV7Ls0/mghuKCZNXB+miwat3BBrJ0ZY2SaI
         MkWfAgDexzA56mOGyyRS0zQ1/eRbvc1/gaNrLBeOKiyvHsClL3KVcD3+ALVylxxhqQ
         eTvSeNtA4TYAhzqzzVwwFN+KbAPHubm5OTww9SVUJ25zxWFbgEZfhL3fJ0S6MjphsJ
         a9AA/Td7teCqL3zDdEAU3P5Koa0PP4AG4PyoSyptqJEWpDAGv2ljw7YUF59YlpAKR4
         f04Q46UHs1588E7mcihW8lIqhc4BFgxyZTOL3BkfsMrelP6q2QBTcnfh3ij6YB1fIl
         X6rgz3udWo4fQ==
Message-ID: <e85cc03e-616f-4d72-8234-f65741047df5@collabora.com>
Date:   Tue, 5 Dec 2023 14:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: mediatek: extend number of tuning steps
Content-Language: en-US
To:     =?UTF-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20231130061513.1296-1-axe.yang@mediatek.com>
 <20231130061513.1296-3-axe.yang@mediatek.com>
 <27313484-10a9-4a2f-93b1-9b5ce04ad9c6@collabora.com>
 <a419295339c8126150c1e393fcc4cb6a232f07b5.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <a419295339c8126150c1e393fcc4cb6a232f07b5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/23 03:02, Axe Yang (杨磊) ha scritto:
> On Fri, 2023-12-01 at 10:02 +0100, AngeloGioacchino Del Regno wrote:
>> Il 30/11/23 07:15, Axe Yang ha scritto:
>>> Previously, during the MSDC calibration process, a full clock cycle
>>> actually not be covered, which in some cases didn't yield the best
>>> results and could cause CRC errors. This problem is particularly
>>> evident when MSDC is used as an SDIO host. In fact, MSDC support
>>> tuning up to a maximum of 64 steps, but by default, the step number
>>> is 32. By increase the tuning step, we are more likely to cover
>>> more
>>> parts of a clock cycle, and get better calibration result.
>>>
>>> To illustrate, when tuning 32 steps, if the obtained window has a
>>> hole
>>> near the middle, like this: 0xffc07ff (hex), then the selected
>>> delay
>>> will be the 6 (counting from right to left).
>>>
>>> (32 <- 1)
>>> 1111 1111 1100 0000 0000 0111 11(1)1 1111
>>>
>>> However, if we tune 64 steps, the window obtained may look like
>>> this:
>>> 0xfffffffffffc07ff. The final selected delay will be 44, which is
>>> safer as it is further away from the hole:
>>>
>>> (64 <- 1)
>>> 1111 ... (1)111 1111 1111 1111 1111 1100 0000 0000 0111 1111 1111
>>>
>>> In this case, delay 6 selected through 32 steps tuning is obviously
>>> not optimal, and this delay is closer to the hole, using it would
>>> easily cause CRC problems.
>>>
>>> You will need to configure property "mediatek,tuning-step" in MSDC
>>> dts node to 64 to extend the steps.
>>>
>>> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
>>> ---
>>>    drivers/mmc/host/mtk-sd.c | 155 ++++++++++++++++++++++++++-------
>>> -----
>>>    1 file changed, 107 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>>> index 97f7c3d4be6e..4cd306b3b295 100644
>>> --- a/drivers/mmc/host/mtk-sd.c
>>> +++ b/drivers/mmc/host/mtk-sd.c
>>> @@ -252,12 +252,16 @@
>>>    
>>>    #define MSDC_PAD_TUNE_DATWRDLY	  GENMASK(4, 0)		/*
>>> RW */
>>>    #define MSDC_PAD_TUNE_DATRRDLY	  GENMASK(12, 8)	/* RW */
>>> +#define MSDC_PAD_TUNE_DATRRDLY2	  GENMASK(12, 8)	/* RW */
>>>    #define MSDC_PAD_TUNE_CMDRDLY	  GENMASK(20, 16)	/* RW */
>>> +#define MSDC_PAD_TUNE_CMDRDLY2	  GENMASK(20, 16)	/* RW */
>>>    #define MSDC_PAD_TUNE_CMDRRDLY	  GENMASK(26, 22)	/* RW */
>>>    #define MSDC_PAD_TUNE_CLKTDLY	  GENMASK(31, 27)	/* RW */
>>>    #define MSDC_PAD_TUNE_RXDLYSEL	  BIT(15)   /* RW */
>>>    #define MSDC_PAD_TUNE_RD_SEL	  BIT(13)   /* RW */
>>>    #define MSDC_PAD_TUNE_CMD_SEL	  BIT(21)   /* RW */
>>> +#define MSDC_PAD_TUNE_RD2_SEL	  BIT(13)   /* RW */
>>> +#define MSDC_PAD_TUNE_CMD2_SEL	  BIT(21)   /* RW */
>>>    
>>>    #define PAD_DS_TUNE_DLY_SEL       BIT(0)	  /* RW */
>>>    #define PAD_DS_TUNE_DLY1	  GENMASK(6, 2)   /* RW */
>>> @@ -325,7 +329,8 @@
>>>    
>>>    #define DEFAULT_DEBOUNCE	(8)	/* 8 cycles CD debounce */
>>>    
>>> -#define PAD_DELAY_MAX	32 /* PAD delay cells */
>>> +#define PAD_DELAY_HALF	32 /* PAD delay cells */
>>> +#define PAD_DELAY_FULL	64
>>>    /*---------------------------------------------------------------
>>> -----------*/
>>>    /* Descriptor
>>> Structure                                                     */
>>>    /*---------------------------------------------------------------
>>> -----------*/
>>> @@ -461,6 +466,7 @@ struct msdc_host {
>>>    	u32 hs400_ds_dly3;
>>>    	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104
>>> */
>>>    	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
>>> +	u32 tuning_step;
>>>    	bool hs400_cmd_resp_sel_rising;
>>>    				 /* cmd response sample selection for
>>> HS400 */
>>>    	bool hs400_mode;	/* current eMMC will run at hs400 mode */
>>> @@ -1615,7 +1621,7 @@ static irqreturn_t msdc_cmdq_irq(struct
>>> msdc_host *host, u32 intsts)
>>>    	}
>>>    
>>>    	if (cmd_err || dat_err) {
>>> -		dev_err(host->dev, "cmd_err = %d, dat_err =%d, intsts =
>>> 0x%x",
>>> +		dev_err(host->dev, "cmd_err = %d, dat_err = %d, intsts
>>> = 0x%x",
>>>    			cmd_err, dat_err, intsts);
>>>    	}
>>>    
>>> @@ -1780,10 +1786,20 @@ static void msdc_init_hw(struct msdc_host
>>> *host)
>>>    				     DATA_K_VALUE_SEL);
>>>    			sdr_set_bits(host->top_base + EMMC_TOP_CMD,
>>>    				     PAD_CMD_RD_RXDLY_SEL);
>>> +			if (host->tuning_step > PAD_DELAY_HALF) {
>>> +				sdr_set_bits(host->top_base +
>>> EMMC_TOP_CONTROL,
>>> +					     PAD_DAT_RD_RXDLY2_SEL);
>>> +				sdr_set_bits(host->top_base +
>>> EMMC_TOP_CMD,
>>> +					     PAD_CMD_RD_RXDLY2_SEL);
>>> +			}
>>>    		} else {
>>>    			sdr_set_bits(host->base + tune_reg,
>>>    				     MSDC_PAD_TUNE_RD_SEL |
>>>    				     MSDC_PAD_TUNE_CMD_SEL);
>>> +			if (host->tuning_step > PAD_DELAY_HALF)
>>> +				sdr_set_bits(host->base + tune_reg + 4,
>>
>> `tune_reg + 4` is a different register, please define it.
>>
> The tune_reg is not a fixed register address, it is defined in
> compatible structures. So using the offset here will make the code more
> consise. The offset of registers related to 64 steps tuning is fixed
> relative to 32-steps tuning regsiter, the offset is always 4.
> 
> However. using the magic number '4' here directly is not ideal. I think
> I can improve this part of code by defining '4' as a macro. What do you
> think about it? If you insist on redifning the registers, I can do it,
> but it will make the code a bit more complex than it is now.
> 
> 
>> Also, I can't find this in MT8192, MT8195 - as those bits seem to be
>> undefined,
>> so, which SoCs are actually compatible with this change?
> 
> Sorry, which bits are you talking about?
> This change compatible for all SoCs. In fact, MSDC has always supported
> 64 step tuning.
> 
> 

Sorry, found it under a slightly different name. Nevermind.

>>
>>
>>> +					     MSDC_PAD_TUNE_RD2_SEL |
>>> +					     MSDC_PAD_TUNE_CMD2_SEL);
>>>    		}
>>>    	} else {
>>>    		/* choose clock tune */
>>> @@ -1925,24 +1941,24 @@ static void msdc_ops_set_ios(struct
>>> mmc_host *mmc, struct mmc_ios *ios)
>>>    		msdc_set_mclk(host, ios->timing, ios->clock);
>>>    }
>>>    
>>> -static u32 test_delay_bit(u32 delay, u32 bit)
>>> +static u64 test_delay_bit(u64 delay, u32 bit)
>>>    {
>>> -	bit %= PAD_DELAY_MAX;
>>> -	return delay & BIT(bit);
>>> +	bit %= PAD_DELAY_FULL;
>>> +	return delay & BIT_ULL(bit);
>>>    }
>>>    
>>> -static int get_delay_len(u32 delay, u32 start_bit)
>>> +static int get_delay_len(u64 delay, u32 start_bit)
>>>    {
>>>    	int i;
>>>    
>>> -	for (i = 0; i < (PAD_DELAY_MAX - start_bit); i++) {
>>> +	for (i = 0; i < (PAD_DELAY_FULL - start_bit); i++) {
>>>    		if (test_delay_bit(delay, start_bit + i) == 0)
>>>    			return i;
>>>    	}
>>> -	return PAD_DELAY_MAX - start_bit;
>>> +	return PAD_DELAY_FULL - start_bit;
>>>    }
>>>    
>>> -static struct msdc_delay_phase get_best_delay(struct msdc_host
>>> *host, u32 delay)
>>> +static struct msdc_delay_phase get_best_delay(struct msdc_host
>>> *host, u64 delay)
>>>    {
>>>    	int start = 0, len = 0;
>>>    	int start_final = 0, len_final = 0;
>>> @@ -1950,28 +1966,28 @@ static struct msdc_delay_phase
>>> get_best_delay(struct msdc_host *host, u32 delay)
>>>    	struct msdc_delay_phase delay_phase = { 0, };
>>>    
>>>    	if (delay == 0) {
>>> -		dev_err(host->dev, "phase error: [map:%x]\n", delay);
>>> +		dev_err(host->dev, "phase error: [map:%016llx]\n",
>>> delay);
>>>    		delay_phase.final_phase = final_phase;
>>>    		return delay_phase;
>>>    	}
>>>    
>>> -	while (start < PAD_DELAY_MAX) {
>>> +	while (start < PAD_DELAY_FULL) {
>>>    		len = get_delay_len(delay, start);
>>>    		if (len_final < len) {
>>>    			start_final = start;
>>>    			len_final = len;
>>>    		}
>>>    		start += len ? len : 1;
>>> -		if (len >= 12 && start_final < 4)
>>> +		if (!upper_32_bits(delay) && len >= 12 && start_final <
>>> 4)
>>>    			break;
>>>    	}
>>>    
>>>    	/* The rule is that to find the smallest delay cell */
>>>    	if (start_final == 0)
>>> -		final_phase = (start_final + len_final / 3) %
>>> PAD_DELAY_MAX;
>>> +		final_phase = (start_final + len_final / 3) %
>>> PAD_DELAY_FULL;
>>>    	else
>>> -		final_phase = (start_final + len_final / 2) %
>>> PAD_DELAY_MAX;
>>> -	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
>>> +		final_phase = (start_final + len_final / 2) %
>>> PAD_DELAY_FULL;
>>> +	dev_dbg(host->dev, "phase: [map:%016llx] [maxlen:%d]
>>> [final:%d]\n",
>>>    		delay, len_final, final_phase);
>>>    
>>>    	delay_phase.maxlen = len_final;
>>> @@ -1984,30 +2000,68 @@ static inline void
>>> msdc_set_cmd_delay(struct msdc_host *host, u32 value)
>>>    {
>>>    	u32 tune_reg = host->dev_comp->pad_tune_reg;
>>>    
>>> -	if (host->top_base)
>>> -		sdr_set_field(host->top_base + EMMC_TOP_CMD,
>>> PAD_CMD_RXDLY,
>>> -			      value);
>>> -	else
>>> -		sdr_set_field(host->base + tune_reg,
>>> MSDC_PAD_TUNE_CMDRDLY,
>>> -			      value);
>>> +	if (host->top_base) {
>>> +		if (value < PAD_DELAY_HALF) {
>>> +			sdr_set_field(host->top_base + EMMC_TOP_CMD,
>>> PAD_CMD_RXDLY,
>>> +				      value);
>>
>> This goes up to 92 columns, and it's fine, so fits in one line and
>> it's more
>> readable like that.
>>
>> I know that's not your fault, but since you're actually touching
>> those lines
>> it's a good occasion to also do that (not only here) :-)
>>
> Sure, will update this part in v4, and thanks for your meticulous
> review.
> 

Thank you!
Angelo

