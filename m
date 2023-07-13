Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99301751F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjGMLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGMLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:13:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043D211C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:13:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5CD96607048;
        Thu, 13 Jul 2023 12:13:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689246813;
        bh=Km3zinC5aU6POQuC6Ok3uEJbGy3j4WpICpPik1AklyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G0zbayyLnyvN9v0jhGQjJRNbQD4LPKfLRKp1ZzhPFNamgbcftpyJaGqiqewcKwiux
         ew4ueWCbmcRQQKDvrDLsTKh8iB6EL/A/HCzHi3xo4nefACTMynB0zJbdydvp/ayL7M
         h+PwfNWJEb6qAJSdh3Ygyf2OwhPH/m+1TpYHZgr9MslNJPTLbWpBZ9IwbHmNX91jv3
         jMT8yCZvKVdKwCALuoiHpWz1sGrjIewa/oYV82FsH6h11d4AFBtpaZwGUijvFWjlOh
         FyqgG6m3fGA0/GCV2za1GTYKrdNcICz2F1p0oCMKuRDen5eadwFAQZhKdCm46CLWXU
         c2JodVlqMeuuA==
Message-ID: <0b45eae2-4081-febe-d062-6475d67a59cf@collabora.com>
Date:   Thu, 13 Jul 2023 13:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] drm/mediatek: mtk_dpi: Switch to
 devm_drm_of_get_bridge()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230412115250.164899-1-angelogioacchino.delregno@collabora.com>
 <20230412115250.164899-4-angelogioacchino.delregno@collabora.com>
 <CAC=S1nhePNeKY=q3XofzPcbwvyonz-bSuSLDNgsKx088qB3ZJA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAC=S1nhePNeKY=q3XofzPcbwvyonz-bSuSLDNgsKx088qB3ZJA@mail.gmail.com>
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

Il 13/07/23 10:24, Fei Shao ha scritto:
> Hi Angelo,
> 
> On Wed, Apr 12, 2023 at 7:53 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Function drm_of_find_panel_or_bridge() is marked as deprecated: since
>> the usage of that in this driver exactly corresponds to the new function
>> devm_drm_of_get_bridge(), switch to it.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dpi.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> index 6be65ea21f8f..9025111013d3 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
>> @@ -1063,10 +1063,9 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>>          if (dpi->irq <= 0)
>>                  return -EINVAL;
>>
>> -       ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>> -                                         NULL, &dpi->next_bridge);
>> -       if (ret)
>> -               return ret;
>> +       dpi->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
>> +       if (IS_ERR(dpi->next_bridge))
>> +               return PTR_ERR(dpi->next_bridge);
> 
> The original code doesn't print any log so it's probably fine, but
> given you're already at it, perhaps you want to also make use of
> dev_err_probe() here?
> devm_drm_of_get_bridge() can also pass -EPROBE_DEFER from its wrapped
> drm_of_find_panel_or_bridge(). Furthermore, that will make the code
> visually align with your previous patch.
> 
> But that's just optional, and since this patch works anyway,
> 
> Reviewed-by: Fei Shao <fshao@chromium.org>
> 

Thanks. Yeah it's a good idea to add an error print... since I will have
to anyway send a v2, I'll add it.

Cheers,
Angelo

>>
>>          dev_info(dev, "Found bridge node: %pOF\n", dpi->next_bridge->of_node);
>>
>> --
>> 2.40.0
>>
>>
> 

