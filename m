Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7365079CCC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjILKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjILKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:02:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946610D8;
        Tue, 12 Sep 2023 03:02:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06D516607321;
        Tue, 12 Sep 2023 11:02:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694512974;
        bh=9w8C1A352AuElc/pOzF1lPILdDSxHTkOpqu5jgnNssQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VwX0lnzJntgotJhhkzx+NR2cMwrzIYn72iWaYEmKcVpJOj+WDBA1RsE5TnyBErCKm
         lgugCZixc2LenshfZeSw5rvALmGLDQ2s3wuE7jI6g0A+5wDViRMKWOf30ruWE0EqbF
         Kfn3+8d8W+wzIgZcVY6biRV1G5XOMFAfLzecZP6xf/1tigGpSeJHrdoJUcPoaI2DGa
         HqqBafzGbyl2K7PN3s5n1iThP5x08Zm3vS1r1htp8XIyHfT3UmqrYTTiH3yc8WTpB8
         dgv0CC4NiZMM8N2tS7vInsJ8vV2yHZy0o5g9dmTp5XhDHgU7CublAvIQsiMs96wWHl
         MrmSvBxjebbgQ==
Message-ID: <1e049cee-a921-a6e4-f6a0-d39c6fbf2a24@collabora.com>
Date:   Tue, 12 Sep 2023 12:02:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] clk: mediatek: clk-mt6797: Add check for
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
 <20230912093407.21505-3-jiasheng@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230912093407.21505-3-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/09/23 11:34, Jiasheng Jiang ha scritto:
> Add the check for the return value of mtk_alloc_clk_data() in order to
> avoid NULL pointer dereference.
> 
> Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


