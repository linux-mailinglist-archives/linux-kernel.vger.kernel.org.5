Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40247CED5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjJSBQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjJSBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:16:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F7128;
        Wed, 18 Oct 2023 18:15:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A740C433C9;
        Thu, 19 Oct 2023 01:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678158;
        bh=vUZhWZ79erjaSfTdxeE1JrWVoFRWDI4ePY0o4tnzh4k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=L/G2JhJiPncfUI1xC2WHpYTY0V/5L5EB1arbw5x9xUF3Ba+mMrrFgXkbRyfkZemwQ
         zNenLyhDdqc2Khc2oiMpEm7A/B5tB5Q5JXgM+pOAClOIiXJb++rCTrQj4tQe1K+7x1
         Fa6yqsLlagskWj1JPKPwqk57W/o6oDlOQfoGUopfETFzgLXkeJLnNqHWdJDam/dDhf
         CMZsIDSObLj1iFFz82jn46SUwnkxpaFYk6IwR6MJ9rKuoLbcEPhTk2r0i6OUXviTRb
         qLdnbsAWjaesorOB4bq1tAtAacRbzGq2FJO/y7+e1NTr2yDqI6DmrRMBbQM+qcFvIF
         ikS4aVZFwhLtA==
Message-ID: <73db73cf73cb14cf9d526a9fec7d1344.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912093407.21505-4-jiasheng@iscas.ac.cn>
References: <20230912093407.21505-1-jiasheng@iscas.ac.cn> <20230912093407.21505-4-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH 4/5] clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data
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
Date:   Wed, 18 Oct 2023 18:15:56 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiasheng Jiang (2023-09-12 02:34:06)
> Add the check for the return value of mtk_alloc_clk_data() in order to
> avoid NULL pointer dereference.
>=20
> Fixes: 3b5e748615e7 ("clk: mediatek: add clock support for MT7629 SoC")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Applied to clk-next
