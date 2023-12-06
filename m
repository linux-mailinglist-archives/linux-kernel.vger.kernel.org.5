Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780F5806BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377645AbjLFKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377549AbjLFKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:19:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FAF109;
        Wed,  6 Dec 2023 02:19:37 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E879B6607326;
        Wed,  6 Dec 2023 10:19:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701857975;
        bh=IovYJ01Jivwam/qxWADM1HZ4UJMjvtHVmaPsaZqxoro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ge3ih24jaH9Ox/URbczBLz2DRMrZfkSWyobDWXa7+PBzEUH+zpDgasWrLMUcfbvEh
         h8tLwHEsOaQwlpVUWSj1AhstZRO8M17dTwROBWz0kfnZ8AU+oxIC+NUDb5visZyE03
         NTslxdBQkMfXjXEe7rbrY0EsI6BfKxdg6+/4wJSc7zOH5G41z4C5CW6FkbhM9JR7Wp
         tAQVenJg98xI841kHPBZJW2YvYSzK8HZhMFcme/UIS2GFO7laGznCkZsl7OWECq7WM
         Q1EyFeH1N7G15Ua6YS6oFaMkPzYUZcn1r3JJUdRlcrzqXnsk1WBGcyce5I875U32ka
         0shhZLA2THLkg==
Message-ID: <449b9678-e3c2-4410-ac80-c50a1a25cc06@collabora.com>
Date:   Wed, 6 Dec 2023 11:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] media: mediatek: vcodec: Drop VA check against
 mtk_vcodec_mem_free()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231113123049.4117280-1-fshao@chromium.org>
 <20231113123049.4117280-5-fshao@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231113123049.4117280-5-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/11/23 13:26, Fei Shao ha scritto:
> Now mtk_vcodec_mem_free() handles the VA-is-NULL case without generating
> excess error log, so we don't need to check that every time before using
> it in the driver.
> 
> Remove all the unnecessary if branches against mtk_vcodec_mem_free().
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

For the reasons explained in patch [3/4], I'd prefer to keep those checks.

Cheers,
Angelo
