Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9791F7D2F89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWKOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWKOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:14:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E462DA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:14:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29C11660708F;
        Mon, 23 Oct 2023 11:14:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698056082;
        bh=MxExbhPEmRnX1oZHQ8dpqIbO6ZBxZpcKiSBVYh9I8qE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ZDoSbWz8VwrfWDv1AdKAK5HqmMgZ3jaEXesZiPRJlHKW32qnlL+PLwmStj1xN/1gf
         mTF1RL9EPMGogD3qzPHnT+xAprCUxujTFVIo0mK4h9XJ0wGFVXQIRx7dmCSRVIcWnK
         moCcVhaxelvceh7KcjOc8Q0g0Q1T9WiA1VkHWCDog0LDKEysJUQVx9H7hyASQ3gDcZ
         fjs1+pNCfFk4ziuFwOYkBIwvmyIhNoMi4dNWYtjODtCwDvftdim8l4LVVLjkKhrFQZ
         ieDyDnF8kXfPVNCk0rb/r7K0w2S0jKy+io19rSgIGXNXwrvHq7B7Ili0fz6WnKR31V
         L0Ze6sDnGIZ3A==
Message-ID: <64a04871-7671-40c8-9b70-f2d9c7d5be32@collabora.com>
Date:   Mon, 23 Oct 2023 12:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-7-jason-jh.lin@mediatek.com>
 <72277a7e-83a6-4947-8f2a-4881aa8ac766@collabora.com>
In-Reply-To: <72277a7e-83a6-4947-8f2a-4881aa8ac766@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 11:50, AngeloGioacchino Del Regno ha scritto:
> Il 23/10/23 06:37, Jason-JH.Lin ha scritto:
>> Add CMDQ driver support for mt8188 by adding its compatible and
>> driver data in CMDQ driver.
>>
>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> 
> Please fix the commit title...
> 
> mailbox: mtk-cmdq: Add support for MT8188 mailbox
> 
> Regards,
> Angelo
> 

I just noticed that the secure mailbox driver will need quite a few versions
before reaching a somewhat acceptable state, so I'd also consider sending this
commit separately from the secure cmdq series, as this is simply adding the
support for mt8188.


