Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3479CCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjILKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjILKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:02:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180FE6B;
        Tue, 12 Sep 2023 03:02:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9404D6607320;
        Tue, 12 Sep 2023 11:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694512968;
        bh=KFTpQC/A7VUsLib15J+EGZdvXTKuNhYXeMQivKrdSI4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f7lQ+rcyz1WTNWJSyX9xaVR2Svj4OKgMcYb3LA7VfhJ9aeVtWS/v2TdbfyqX2tqPl
         LuuS5QZGx8DMh7e52XLiMDQedv1dGOBTLSa+5TEmTnlhH01gRt1fBMmkHvoXEGV2ll
         W44qPWb1U7nE1tzd6w+Ni68URPxJOU+3oYcBDBYqC+MSy+0ZMF71HDT46mXuk8IKsi
         kWunlPSBN7I5f/IElZBVIJBQ86q0I3e+9JdtGC378XbsMNaQngc1DyLdNoUxrMuYgg
         k+KCk71MVIA5XEJ866e6+zlVZIuRlXIzlJXhBmhftm68h+K8K74Ttc/J74heAfk6Tg
         45g98LuUy0Ipg==
Message-ID: <caff237f-0f84-81df-e866-e49034261f9c@collabora.com>
Date:   Tue, 12 Sep 2023 12:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/5] clk: mediatek: clk-mt7629-eth: Add check for
 mtk_alloc_clk_data
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        msp@baylibre.com, amergnat@baylibre.com, frank.li@vivo.com,
        robh@kernel.org, owen.chen@mediatek.com, mars.cheng@mediatek.com,
        macpaul.lin@mediatek.com, cw00.choi@samsung.com,
        u.kleine-koenig@pengutronix.de, wendell.lin@mediatek.com,
        luca.ceresoli@bootlin.com, kevin-cw.chen@mediatek.com,
        ryder.lee@mediatek.com, wenzhen.yu@mediatek.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230912093407.21505-1-jiasheng@iscas.ac.cn>
 <20230912093407.21505-4-jiasheng@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230912093407.21505-4-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/09/23 11:34, Jiasheng Jiang ha scritto:
> Add the check for the return value of mtk_alloc_clk_data() in order to
> avoid NULL pointer dereference.
> 
> Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


