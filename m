Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAADC7A9F52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjIUUU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjIUUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:20:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5BD469A2;
        Thu, 21 Sep 2023 10:14:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E5B766072AC;
        Thu, 21 Sep 2023 12:17:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695295031;
        bh=5QZOgiLgPuj65gBIxllEBQ8UoAChCrqYN69GWaV+yPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YIkKEXQn5t4jCUZXXcgaqsS6xgzmWls+xt48pRl4jotoNXPsxnwU8UlPasMZ765an
         paCIZCGBBoLI4DEJ39pIm/BPJa5zGDs7y7m9WKcShrDe4EOA4RNkvOxQNpinMY+Ktw
         MopSXw+sp9/afzvJNgoKPhm5XLMOad5TLwgwcpOdaIXyodmGRAtQYNKAifssIrrK/5
         ZGsptSM+8tnUHNHK1obP3UP/remTXxWWsSC2TytAPZMAjkot5qpiBZpPjIVztfajzd
         e/+RRAGceAq9iYKuU15E3FuXrbDtHqsSMIJEdwHWdRAdeVz7dIEkbqK0/5TIHlGEud
         60+XAyr3xGh9g==
Message-ID: <fb716cdf-12eb-8d85-3b9d-b1d5e5aee212@collabora.com>
Date:   Thu, 21 Sep 2023 13:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/4] thermal/drivers/mediatek/lvts_thermal: add mt7988
 support
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230920175001.47563-1-linux@fw-web.de>
 <20230920175001.47563-5-linux@fw-web.de>
 <eb6cc1dd-1df9-3b68-1f72-d536189c7b4d@collabora.com>
 <F68F7C77-BB1E-4D9F-B760-9B35DE3693C5@fw-web.de>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <F68F7C77-BB1E-4D9F-B760-9B35DE3693C5@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/23 12:39, Frank Wunderlich ha scritto:
> Am 21. September 2023 09:54:35 MESZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 20/09/23 19:50, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>   
>>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>>> index c2669f405a94..8fd1dc5adb16 100644
>>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>>> @@ -82,6 +82,8 @@
>>>    #define LVTS_GOLDEN_TEMP_DEFAULT	50
>>>    #define LVTS_COEFF_A_MT8195			-250460
>>>    #define LVTS_COEFF_B_MT8195			250460
>>> +#define LVTS_COEFF_A_MT7988			-204650
>>> +#define LVTS_COEFF_B_MT7988			204650
>>>      #define LVTS_MSR_IMMEDIATE_MODE		0
>>>    #define LVTS_MSR_FILTERED_MODE		1
>>> @@ -89,6 +91,7 @@
>>>    #define LVTS_MSR_READ_TIMEOUT_US	400
>>>    #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
>>>    +#define LVTS_HW_SHUTDOWN_MT7988		105000
>>
>> I would simply reuse the definition of LVTS_HW_SHUTDOWN_MT8195....
> 
> Hi angelo,
> thanks for review.
> 
> Imho it should be separated...if someone thinks it needs to be changed later it will be changed not only for mt8195...a generic name can also cause problems if the next soc has different value.
> 

Okay, I don't really have strong opinions against that anyway.

Cheers
Angelo

>>>    #define LVTS_HW_SHUTDOWN_MT8195		105000
>>>      #define LVTS_MINIMUM_THRESHOLD		20000
>>> @@ -1269,6 +1272,41 @@ static int lvts_remove(struct platform_device *pdev)
>>>    	return 0;
>>>    }
>>>    +/*
>>> + * LVTS MT7988
>>> + */
>>> +
>>
>> Please remove this big comment block, that's not needed.
> 
> Ok,i drop the comments (maybe except the wed one where the name in technical document (i used for constants) does not point to wed function.
> 
>>> +static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] = {
>>> +	{
>>> +		.cal_offset = { 0x00, 0x04, 0x08, 0x0c }, //918,91C,920,924
>>
>> This 918,91c,etc comment is not necessary
>>
>>> +		.lvts_sensor = {
>>> +			{ .dt_id = MT7988_CPU_0 }, // CPU 0,1
>>
>> If you want to retain those comments, you shall use the right style.
>>
>> { .dt_id = MT7988_CPU_0 }, /* CPU 0,1 */
>> { .. } /* CPU 2,3 */
>> { .. } /* Internal 2.5G PHY 1 */
>>
>> etc
>>
>>> +			{ .dt_id = MT7988_CPU_1 }, // CPU 2,3
>>> +			{ .dt_id = MT7988_ETH2P5G_0 }, // internal 2.5G Phy 1
>>> +			{ .dt_id = MT7988_ETH2P5G_1 }  // internal 2.5G Phy 2
>>> +		},
>>> +		.num_lvts_sensor = 4,
>>> +		.offset = 0x0,
>>> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
>>> +	},
>>> +	{
>>> +		.cal_offset = { 0x14, 0x18, 0x1c, 0x20 }, //92C,930,934,938
>>
>> comment not needed
>>
>>> +		.lvts_sensor = {
>>> +			{ .dt_id = MT7988_TOPS_0}, // TOPS > +			{ .dt_id = MT7988_TOPS_1}, // TOPS
>>
>> The dt_id definition already says "TOPS", this comment is not needed.
>>
>>> +			{ .dt_id = MT7988_ETHWARP_0}, // WED 1
>>> +			{ .dt_id = MT7988_ETHWARP_1}  // WED 2
>>
>> Same comment about the format; /* WED 1 */
>>
>>> +		},
>>> +		.num_lvts_sensor = 4,
>>> +		.offset = 0x100,
>>> +		.hw_tshut_temp = LVTS_HW_SHUTDOWN_MT7988,
>>> +	}
>>> +};
>>> +
>>> +/*
>>> + * LVTS MT8195
>>> + */
>>
>> Please also remove this big comment block, it's not needed.
>>
>> Apart from that, this patch looks good; v3 will be the golden one :-)
>>
>> Cheers,
>> Angelo
>>
> 
> regards Frank



