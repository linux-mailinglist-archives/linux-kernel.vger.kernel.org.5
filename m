Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030557D904B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjJ0Ht0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJ0HtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:49:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E010A;
        Fri, 27 Oct 2023 00:49:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B91A66071F1;
        Fri, 27 Oct 2023 08:49:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698392960;
        bh=Er+OOdHx8cqMGoyhVTFB/h3ZeQ5UpwzOAINq1iZlNLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M63W0c8d6DK7x4LW4zyjIjII746ijWuH/1ezuv/K4K+nH7aQE6DLRqsgmuFA7I0Y3
         71APbBnTVGs0PTjje78/VwpX3GOKrGPgpyWPAZ4hQZE2wXvrJCuVsrlrGn21TgZLCe
         j9EWvRpL1pUpq21H/9dqH/bkFqAcIarSLs0tOh/PuNNgYyaCZbcdXwA0OcbvYLdTbn
         EkvyG6n2oYetTalfwyjHnRmYahgAqk99UfllpMBWAaj1ln2f9QW3EtRoPzvfNKDEEt
         /3OQKzcSgYNijy3AJquk6n/T6+ZcKMSfAQdJ/gd84gQ/PCA24GzFmhxVZq6oRRtow5
         +btqrh59MTglA==
Message-ID: <b8b2ff9d-293d-4e21-b3b2-92b456b8f7c4@collabora.com>
Date:   Fri, 27 Oct 2023 09:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8188: probe vpp with
 mtk_clk_simple_probe()
Content-Language: en-US
To:     =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <20231026113830.29215-1-yu-chang.lee@mediatek.com>
 <a7321404-0c8f-430c-b14c-7ffc9e4fc5d7@collabora.com>
 <aeb71e4321637fdebd414acf58480e520afd2b15.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <aeb71e4321637fdebd414acf58480e520afd2b15.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/10/23 09:42, Yu-chang Lee (李禹璋) ha scritto:
> On Thu, 2023-10-26 at 13:45 +0200, AngeloGioacchino Del Regno wrote:
>> Il 26/10/23 13:38, yu-chang.lee ha scritto:
>>> switch to the common mtk_clk_simple_probe() function for all of the
>>> clock drivers that are registering as platform drivers.
>>>
>>
>> So VPPSYS0 and VPPSYS1 aren't dependant on MMSYS anymore?
>>
>> Like this, it doesn't look like this will ever work fine, so if you
>> want
>> that to happen, you must provide a good explanation, and then, since
>> MT8188
>> and MT8195's VPPSYS are practically the same, you should also convert
>> MT8195
>> to do the same, and make sure that everything works as expected
>> before sending
>> a commit upstream.
>>
>> Please, explain.
>>
>> Thanks,
>> Angelo
>>
> Hi Angelo,
> 
> Thanks for your time and timely feedback. I don't find mt8188-vpp1 and
> mt8188-vpp0 in mtk-mmsys.c. and thought probed them with
> mtk_simple_probe(), refer to your comment on in this patch
> "clk:
> mediatek: Switch to mtk_clk_simple_probe() where possible", will be a

Just to clarify: mtk_clk_pdev_probe() is mtk_clk_simple_probe() for
pdev, nothing more and nothing less :-)

> good idea. On the other hand mt8195 does have dependency on MMSYS, so I
> don't think the same change work on mt8195.
> 

Ok, then that's simply because MT8188 MDP3 is not upstream yet: that's going to
happen, meaning that MT8188 will have the same mmsys dependency as MT8195 soon.

Sorry, this commit is not valid. NACK.

Thanks!
Angelo

> Best Regards,
> YuChang
> 
>>> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
>>> ---
>>>    drivers/clk/mediatek/clk-mt8188-vpp0.c | 14 +++++++++++---
>>>    drivers/clk/mediatek/clk-mt8188-vpp1.c | 14 +++++++++++---
>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/clk/mediatek/clk-mt8188-vpp0.c
>>> b/drivers/clk/mediatek/clk-mt8188-vpp0.c
>>> index e7b02b26fefb..18fffa191ee1 100644
>>> --- a/drivers/clk/mediatek/clk-mt8188-vpp0.c
>>> +++ b/drivers/clk/mediatek/clk-mt8188-vpp0.c
>>> @@ -96,6 +96,15 @@ static const struct mtk_clk_desc vpp0_desc = {
>>>    	.num_clks = ARRAY_SIZE(vpp0_clks),
>>>    };
>>>    
>>> +static const struct of_device_id of_match_clk_mt8188_vpp0[] = {
>>> +	{
>>> +		.compatible = "mediatek,mt8188-vppsys0",
>>> +		.data = &vpp0_desc,
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +
>>>    static const struct platform_device_id clk_mt8188_vpp0_id_table[]
>>> = {
>>>    	{ .name = "clk-mt8188-vpp0", .driver_data =
>>> (kernel_ulong_t)&vpp0_desc },
>>>    	{ /* sentinel */ }
>>> @@ -103,12 +112,11 @@ static const struct platform_device_id
>>> clk_mt8188_vpp0_id_table[] = {
>>>    MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp0_id_table);
>>>    
>>>    static struct platform_driver clk_mt8188_vpp0_drv = {
>>> -	.probe = mtk_clk_pdev_probe,
>>> -	.remove_new = mtk_clk_pdev_remove,
>>> +	.probe = mtk_clk_simple_probe,
>>>    	.driver = {
>>>    		.name = "clk-mt8188-vpp0",
>>> +		.of_match_table = of_match_clk_mt8188_vpp0,
>>>    	},
>>> -	.id_table = clk_mt8188_vpp0_id_table,
>>>    };
>>>    module_platform_driver(clk_mt8188_vpp0_drv);
>>>    MODULE_LICENSE("GPL");
>>> diff --git a/drivers/clk/mediatek/clk-mt8188-vpp1.c
>>> b/drivers/clk/mediatek/clk-mt8188-vpp1.c
>>> index e8f0f7eca097..f4b35336d427 100644
>>> --- a/drivers/clk/mediatek/clk-mt8188-vpp1.c
>>> +++ b/drivers/clk/mediatek/clk-mt8188-vpp1.c
>>> @@ -91,6 +91,15 @@ static const struct mtk_clk_desc vpp1_desc = {
>>>    	.num_clks = ARRAY_SIZE(vpp1_clks),
>>>    };
>>>    
>>> +static const struct of_device_id of_match_clk_mt8188_vpp1[] = {
>>> +	{
>>> +		.compatible = "mediatek,mt8188-vppsys1",
>>> +		.data = &vpp1_desc,
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +
>>>    static const struct platform_device_id clk_mt8188_vpp1_id_table[]
>>> = {
>>>    	{ .name = "clk-mt8188-vpp1", .driver_data =
>>> (kernel_ulong_t)&vpp1_desc },
>>>    	{ /* sentinel */ }
>>> @@ -98,12 +107,11 @@ static const struct platform_device_id
>>> clk_mt8188_vpp1_id_table[] = {
>>>    MODULE_DEVICE_TABLE(platform, clk_mt8188_vpp1_id_table);
>>>    
>>>    static struct platform_driver clk_mt8188_vpp1_drv = {
>>> -	.probe = mtk_clk_pdev_probe,
>>> -	.remove_new = mtk_clk_pdev_remove,
>>> +	.probe = mtk_clk_simple_probe,
>>>    	.driver = {
>>>    		.name = "clk-mt8188-vpp1",
>>> +		.of_match_table = of_match_clk_mt8188_vpp1,
>>>    	},
>>> -	.id_table = clk_mt8188_vpp1_id_table,
>>>    };
>>>    module_platform_driver(clk_mt8188_vpp1_drv);
>>>    MODULE_LICENSE("GPL");
>>
>>


