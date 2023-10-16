Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6217C7CA10E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJPHzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:55:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A559AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:55:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F7A56607285;
        Mon, 16 Oct 2023 08:55:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697442907;
        bh=Hw/1U1YBl+D02Eq2vlklAKGEowzhCs7qY+uoAbH7NQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mGufDXs98MhuhzR+u3zf2PtniyqEwDciCV/Nzd2JHBNs/vsRNZrcECmmpYdiUoEk0
         ml0xwaR2Y7J9Y5B90BokwGr4JxbJxZvc/cE6vkdcJ5Iuy/OsUvEUN/qzYyPpx4S9RD
         W3716ERYdtNQ6iucVEyDbS1V62+/m2GAEMtPjMfdDS82aBz9WCrSpMYWXcbVTbMX96
         PPqdS7Xz3gupbI0Tg8SoIc66Brbe6nmhrJQtDgCc3MBqtqOtPXHd53209EmTf3jJjl
         VZO3wFrAoxcP+6t7eP1PwRCmulTmLhNp89j940cHO93H56J1+307T8s/JkmsG0NoZu
         zaJzLdZQxL2QA==
Message-ID: <5b843706-8ec3-6de6-de24-ddde5349db57@collabora.com>
Date:   Mon, 16 Oct 2023 09:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v11 06/16] drm/mediatek: gamma: Use bitfield macros
Content-Language: en-US
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20231012095736.100784-1-angelogioacchino.delregno@collabora.com>
 <20231012095736.100784-7-angelogioacchino.delregno@collabora.com>
 <3399bf15a6e3d3d4ed5228c858b06c7b28b40aea.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <3399bf15a6e3d3d4ed5228c858b06c7b28b40aea.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/10/23 06:00, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Thu, 2023-10-12 at 11:57 +0200, AngeloGioacchino Del Regno wrote:
>> Make the code more robust and improve readability by using bitfield
>> macros instead of open coding bit operations.
>> While at it, also add a definition for LUT_BITS_DEFAULT.
> 
> When I apply, I would remove the description of LUT_BITS_DEFAULT.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Sorry for forgetting about removing that from the commit description after
removing it from the code.

Thanks for removing it while applying, that simplifies my workflow.

Cheers,
Angelo

