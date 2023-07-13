Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4C751FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjGMLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjGMLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:14:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD95AA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:14:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 914386607037;
        Thu, 13 Jul 2023 12:14:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689246886;
        bh=F1i+SwhIPLo5pHuaYsaZeydF8C9QVQZ9zzDTvGn7X90=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kjLEPN/aPb5ZfsiDrbSiwZpvOKvHUWBkHroyv20TZEhqr06zyhmTJAwHoq6fr7nr+
         lWtrct015bxNmNF/yEAJ3/dgDks39FZzOIN7cxLMXeSGMFPWH19cWck/LbR19JrLCE
         e1yCJqMo6IbKVuuQY0060ago8UgSZty1BuIxCq5/Sht0X9T2AEEAlVCe9uo8T4Dura
         AbW1206f2qd5J/uvsbURYWKcejVhu6Eims5FuXkUeYflAkQ2RUh2jlyiwlOUeehCKB
         IV6ndMTUzNFPvrzmW1LnwyKGmuXJXGoI0dYVu9Yrjb8qmQRfQD++vXXYv+MA9m+vE4
         SihyFwwd0Cl7w==
Message-ID: <d93e0a7b-7ee8-62ad-cf96-985ee5a8d432@collabora.com>
Date:   Thu, 13 Jul 2023 13:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] drm/mediatek: mtk_dpi: Simplify with
 devm_drm_bridge_add()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
 <20230412115250.164899-2-angelogioacchino.delregno@collabora.com>
 <CAC=S1nivzyX9+3EBtAG5dPmy-c6je74zmY68AXjyFvV2Pigqgg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAC=S1nivzyX9+3EBtAG5dPmy-c6je74zmY68AXjyFvV2Pigqgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/07/23 09:55, Fei Shao ha scritto:
> Hi Angelo,
> 
> On Wed, Apr 12, 2023 at 7:53 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Change drm_bridge_add() to its devm variant to slightly simplify the
>> probe function.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dpi.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 948a53f1f4b3..2d5f3fc34f61 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -1090,11 +1090,12 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>>          dpi->bridge.of_node = dev->of_node;
>>          dpi->bridge.type = DRM_MODE_CONNECTOR_DPI;
>>
>> -       drm_bridge_add(&dpi->bridge);
>> +       ret = devm_drm_bridge_add(dev, &dpi->bridge);
>> +       if (ret)
>> +               return ret;
> 
> And also drop the drm_bridge_remove() call in mtk_dpi_remove()?
> 

Yes. V2 will drop that.

Cheers,
Angelo

> Regards,
> Fei
> 
>>
>>          ret = component_add(dev, &mtk_dpi_component_ops);
>>          if (ret) {
>> -               drm_bridge_remove(&dpi->bridge);
>>                  dev_err(dev, "Failed to add component: %d\n", ret);
>>                  return ret;
>>          }
>> --
>> 2.40.0
>>
>>
> 

