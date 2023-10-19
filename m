Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD17CF4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbjJSKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbjJSKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:17:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D7311D;
        Thu, 19 Oct 2023 03:17:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B35136607322;
        Thu, 19 Oct 2023 11:17:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697710635;
        bh=0P71wcdmZeNDRgq2k3g+efA5oDtGoggSn0l1TpQZ17k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ttpn6UU4pcVlAK9qmpH2/G52og116jTuzlfzkXrQlp+kr/iFMn+jZ7pj3wdRYK4Uk
         DGRUSWSidFaLwUL7IObs7lYi43ktQUdnUwE8/L63vPmpT6TYRg7Z9dlf5AbyGus2fs
         abwR9bFieb8jZpsER4FUP1W3sck4RS53F0T2jrobMfN5BY+JAyS/s2kFWN9d5J5t3u
         z6KAbfY6K8NNxU11N7LqnGC0T03FhbnfaE0lYNeN2dWW672oOPcpFtgzCqFDdFGmQK
         5FDEeeXbRAsIuHfLUOAjhLUbLscwsaa24tySuE1e2ajXuZcBSI5tYd/9QE9TCpqskn
         Zqtu4MHWRPdFw==
Message-ID: <0fd83158-5f7c-4f0b-95ff-5857668ab9e8@collabora.com>
Date:   Thu, 19 Oct 2023 12:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/24] drm/mediatek: Remove ineffectual power
 management codes
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
References: <20231019055619.19358-1-shawn.sung@mediatek.com>
 <20231019055619.19358-16-shawn.sung@mediatek.com>
 <5a059ca0-fcb7-4730-a0d8-29103fb71d54@collabora.com>
 <2313a4b08f57ab24b48a13a31845eed7e0ab042d.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2313a4b08f57ab24b48a13a31845eed7e0ab042d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/10/23 11:52, Shawn Sung (宋孝謙) ha scritto:
> Hi Angelo,
> 
> On Thu, 2023-10-19 at 11:07 +0200, AngeloGioacchino Del Regno wrote:
>> Il 19/10/23 07:56, Hsiao Chien Sung ha scritto:
>>> Display modules will be powered on when .atomic_enable(),
>>> there is no need to do it again in mtk_crtc_ddp_hw_init().
>>> Besides, the DRM devices are created manually when mtk-mmsys
>>> is probed and there is no power domain linked to it.
>>>
>>> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC
>>> MT8173.")
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>> ---
>>>    drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 18 +++---------------
>>>    1 file changed, 3 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> index bc4cc75cca18..c7edd80be428 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
>>> @@ -6,7 +6,6 @@
>>>    #include <linux/clk.h>
>>>    #include <linux/dma-mapping.h>
>>>    #include <linux/mailbox_controller.h>
>>> -#include <linux/pm_runtime.h>
>>>    #include <linux/soc/mediatek/mtk-cmdq.h>
>>>    #include <linux/soc/mediatek/mtk-mmsys.h>
>>>    #include <linux/soc/mediatek/mtk-mutex.h>
>>> @@ -362,22 +361,16 @@ static int mtk_crtc_ddp_hw_init(struct
>>> mtk_drm_crtc *mtk_crtc, struct drm_atomic
>>>    		drm_connector_list_iter_end(&conn_iter);
>>>    	}
>>>    
>>> -	ret = pm_runtime_resume_and_get(crtc->dev->dev);
>>> -	if (ret < 0) {
>>> -		DRM_ERROR("Failed to enable power domain: %d\n", ret);
>>> -		return ret;
>>> -	}
>>> -
>>
>> Are you really sure that writes to DISP_REG_OVL_xxx and others in
>> other modules,
>> called by the .layer_config() callback, can be successfully done on
>> an unpowered
>> and/or unclocked module, on all MediaTek SoCs?
>> This looks a bit odd.
> 
> Not sure if I get your point correctly. We removed this PM API because:
> 
> 1. mtk_crtc_ddp_hw_init() is called by mtk_drm_crtc_atomic_enable(),
> and the new inline function mtk_ddp_comp_power_on() is called before hw
> init, we can make sure the power is on before configuring the hardware.
> 
> 2. The device "crtc->dev->dev" here is assigned by the probe function
> of mtk-mmsys, which will be look like "mediatek-drm.auto.13", and this
> device is not linked to any power domain.
> 

Thanks for the clarification. In this case:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>>>    	ret = mtk_mutex_prepare(mtk_crtc->mutex);
>>>    	if (ret < 0) {
>>>    		DRM_ERROR("Failed to enable mutex clock: %d\n", ret);
>>> -		goto err_pm_runtime_put;
>>> +		goto error;
>>>    	}
>>>    
>>>    	ret = mtk_crtc_ddp_clk_enable(mtk_crtc);
>>>    	if (ret < 0) {
>>>    		DRM_ERROR("Failed to enable component clocks: %d\n",
>>> ret);
>>> -		goto err_mutex_unprepare;
>>> +		goto error;
>>>    	}
>>>    
>>>    	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
>>> @@ -426,16 +419,13 @@ static int mtk_crtc_ddp_hw_init(struct
>>> mtk_drm_crtc *mtk_crtc, struct drm_atomic
>>>    
>>
>> ...because you could otherwise just call pm_runtime_put() here,
>> instead of removing
>> the pm_runtime_resume_and_get() call, which is something I would
>> advise to do.
>>
>> Regards,
>> Angelo
>>
> 
> Thanks,
> Shawn


