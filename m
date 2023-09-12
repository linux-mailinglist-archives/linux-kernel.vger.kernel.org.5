Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC4179CCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjILKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjILKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:02:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B3AE64;
        Tue, 12 Sep 2023 03:02:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD253660731E;
        Tue, 12 Sep 2023 11:02:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694512961;
        bh=KFTpQC/A7VUsLib15J+EGZdvXTKuNhYXeMQivKrdSI4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MWjR5HVJefu2d4j7QZ0QOiJcsTAnJWDAsEhh96ZUoKmFmE85LCwH4TZiwnt328dGv
         q3MAI7VoMfghswBvo4j8oz+XvpY1nRW1m5LQI3DKbo3iUSDyR2JR961AFoSWJE5sNs
         +bQoFCHrGVvtNmcrwlfpPwZ40mT32rRu+yvNJWf+AoDK/0aOHrU2DklbjZIf19O42U
         Tais/Ygi8W1NYC/qUPa/L/XGSzPSOUOfKIeOxSEy6mPA8uBq/6LptDEH9SY6tRhafY
         It7g9YntFnTIAULfP29C9jywUuz0+LIvmayOhqjzxf96XWiKgixbI1xMJcOKFxCKWM
         aDeo2JBarstdw==
Message-ID: <250a4a3a-cc70-7541-aa49-ec15b8d3e122@collabora.com>
Date:   Tue, 12 Sep 2023 12:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 5/5] clk: mediatek: clk-mt7629: Add check for
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
 <20230912093407.21505-5-jiasheng@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230912093407.21505-5-jiasheng@iscas.ac.cn>
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


