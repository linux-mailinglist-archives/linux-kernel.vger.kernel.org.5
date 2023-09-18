Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B247A453F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbjIRI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjIRI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:57:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02232C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:56:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38C6D6607038;
        Mon, 18 Sep 2023 09:56:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695027417;
        bh=9BQdC/JHkHcdOqMH85ztpqyqjqMwin/967MJsdBXVpk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GjhmQ/oT89hKNZL51q4P1v5TzHe7qLIabTL366gJs7IMO6eF2+ppo1lUDnicxG6d7
         J6sQwSYRh0PCvqBkt1RogueXr5PlpLz+dLtt+HoUxat03wS5dmtM+3Ji4su8by/MTp
         POUDWq/bUCfggy4rFiCMF1pC5KAyGpaRCTS6RnnWmzA/FFQ6CJiWMW2NNs16prEHXR
         HM0f/K6PlMtgU2HEwu+AFsZZZAjsYzfc6cWGhE8z+tEKV1MrHa1y81LmAGoo2++ZkZ
         /yICq5aXagG4iGLjulIHPlbWhxfn63RxDn2g52Qs+blFm8OHvdI9ktc3s1rD+8amGB
         m7yC+84dq4/mA==
Message-ID: <6e37b93f-7806-8d50-d169-12171a2b29ae@collabora.com>
Date:   Mon, 18 Sep 2023 10:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/1] drm/mediatek: Add missing plane settings when async
 update
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230918070028.17915-1-shawn.sung@mediatek.com>
 <20230918070028.17915-2-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918070028.17915-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 09:00, Hsiao Chien Sung ha scritto:
> Fix an issue that plane coordinate was not saved when
> calling async update.
> 
> Fixes: 920fffcc8912 ("drm/mediatek: update cursors by using async atomic update")
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


