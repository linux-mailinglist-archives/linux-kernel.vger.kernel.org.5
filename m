Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD87CED58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjJSBPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjJSBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:15:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18AE126;
        Wed, 18 Oct 2023 18:15:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D96C433C8;
        Thu, 19 Oct 2023 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678147;
        bh=RqMBWNCIh+JHdtsaQoOyxVWv5G9F/rNE6ydRXBBW4eE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XRJupeUCZSn2Xn0tVlPHJrNYEVxlkFU0cHZ2uxVavzHgMwrjMYrmv3vfKDue952ek
         MyQi6Sqmn4ZWHHk82aCqaF1Rrf39jSbJ91sZW4C7xNepgHaCfVj7xt8mAvgHPPzrFz
         uKfqxZJ13NtuPQYMKkWeNrWEpYDU1y1dfO220WH7ZQfJfXquuQ3SSCNNEwrX/g4yh9
         FNaydZMXlqtLCVWcZrPXuS+40R/kZmJ/R5MtazImrXznUMVlnzWMQH7I/s96NyPvNA
         sDDSuTeNSzcAZNnoT43rBIFk5xchXumJNPDDs4/p8vx6ia1jhRhtmHtOkialCNCr/X
         JiLcCjkdUR58w==
Message-ID: <63f772d70abf27dcbeabba6a13f26a4f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912093407.21505-3-jiasheng@iscas.ac.cn>
References: <20230912093407.21505-1-jiasheng@iscas.ac.cn> <20230912093407.21505-3-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH 3/5] clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, amergnat@baylibre.com,
        angelogioacchino.delregno@collabora.com, cw00.choi@samsung.com,
        frank.li@vivo.com, kevin-cw.chen@mediatek.com,
        luca.ceresoli@bootlin.com, macpaul.lin@mediatek.com,
        mars.cheng@mediatek.com, matthias.bgg@gmail.com, msp@baylibre.com,
        mturquette@baylibre.com, owen.chen@mediatek.com, robh@kernel.org,
        ryder.lee@mediatek.com, u.kleine-koenig@pengutronix.de,
        wendell.lin@mediatek.com, wenst@chromium.org,
        wenzhen.yu@mediatek.com
Date:   Wed, 18 Oct 2023 18:15:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiasheng Jiang (2023-09-12 02:34:05)
> Add the check for the return value of mtk_alloc_clk_data() in order to
> avoid NULL pointer dereference.
>=20
> Fixes: 96596aa06628 ("clk: mediatek: add clk support for MT6797")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Applied to clk-next
