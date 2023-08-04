Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413F76FB45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHDHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHDHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:35:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BD4ED7;
        Fri,  4 Aug 2023 00:34:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B6D366071B9;
        Fri,  4 Aug 2023 08:34:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691134489;
        bh=MXbusVUsaCgkKBWlp45fgfQiAF4swbRrk9BMMk9IFdM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mq+OvgPmNdNb5U2BdRb7h+9YCFOmonTNcfmb6SEl352eZJBvgy6lCgJADLaU+XCtl
         WufTLrs/KPODEoOh3DGPz9FIquGjpms8x2+u4HGNluiFQy/JrGOsaW0moyx2K8blAl
         JRfCTTMp7PR1d0+L5mRmITZVBr/LPiCA2/YqiNIiCP5yBBhG87GX9+s9G+INO61gKD
         TjAD5qYOFB4GT/3YJSjTUq1C4JCpvfrlzuQtkupYu2xcXhWDpBPvZSEBXn2FYyNDFG
         Oa+COXPZh0UOqoai2z7nwKLu28ihrwj5lLmHfr5deUKt0wiAz8w+nH8EegePDa7fTO
         D8DPraXxpCHPQ==
Message-ID: <52744f4c-9344-d49a-755a-cc7f7962bc9e@collabora.com>
Date:   Fri, 4 Aug 2023 09:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Content-Language: en-US
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-5-jstephan@baylibre.com>
 <0430ddab-6a6c-9fa3-95bd-05ce8ac5b94f@collabora.com>
 <iq7jffjeaejdfb26a4ysjgjzuopov4ji2ecgzmv4563tdveaep@hh2gzgzkbdzj>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <iq7jffjeaejdfb26a4ysjgjzuopov4ji2ecgzmv4563tdveaep@hh2gzgzkbdzj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 11:53, Julien Stephan ha scritto:
> On Mon, Jul 03, 2023 at 02:21:17PM +0200, AngeloGioacchino Del Regno wrote:
> ..snip..
>>> +
>>> +	mtk_cam_init_cfg(&cam->subdev, NULL);
>>
>> mtk_cam_init_cfg() returns an integer, and this is probably because you expect
>> it to get logic to fail: in that case, check the result of that call here,
>> otherwise, make that function void.
>>
> 
> Hi Angelo,
> 
> mtk_cam_init_cfg returns an int because it should match v4l2_subdev_pad_ops->init_cfg prototype..
> 
> mtk_cam_init does not fail, always return 0, so I though it would be ok
> to discard the return value here. What do you think?
> 

Right, I was thinking to make a void __mtk_cam_init_cfg(), but as an afterthought
it's just better to leave it as it is, let's go with your solution.

Cheers,
Angelo

>>> +
> 
> ..snip..
> 
>>> +	unsigned int bpp;
>>
>> Can we get any format that uses a billion bits per pixel? :-P
>>
>> u8 bpp;
>>
> 
> I am preparing the driver for futur upgrades.. in a billion years ;)
> 
> Cheers
> Julien

