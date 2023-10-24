Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB357D45BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjJXCxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJXCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:53:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FE10C9;
        Mon, 23 Oct 2023 19:52:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BDDC433C8;
        Tue, 24 Oct 2023 02:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698115973;
        bh=h2jUiV7w+D+V0ICMSRwNT/8tXnMjazXjCxp+F0zEHlU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lZRf15BSKSvTuXFMZbFDZSLqWwYcdtInuPJX5XboARnS8dJ6tfDyv2VDVUrWtp9Ev
         An3lIMqO8hmY7bxQx9Q244Vglh+Somw1tyRLQ3KXOHpY6Ll8HpNT5kRnCVE/1QiHs+
         z/ByvOoTR8c22da8D+oeVtgGydwMP1JgDz8kilqwpTSIKa2UBHx24LgvFOgrOKn1xT
         +a9OUvqdQYjoy3HMMvQmRS8zwmMHEjb7rQi3xpgo2091fXiemOc6uyR09Wxof0gpm1
         zn8N3GqnW+LjETeFaJTqRrxdc8D1J9zUElD98j+qUtibf6nU2KJdlUqvMSmZ/+n8l6
         yHUFynsj/hk8g==
Message-ID: <283d18028590d57025e5654d18b8b5b7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
References: <20231019124914.13545-1-angelogioacchino.delregno@collabora.com> <CAGXv+5H0rUajeU-i8nYyV2xWFQTnzqxioZCCyyP_RZXKqmcugQ@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8186: Change I2C 4/5/6 ap clocks parent to infra
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, chun-jie.chen@mediatek.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Oct 2023 19:52:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2023-10-19 22:06:35)
> On Thu, Oct 19, 2023 at 8:49=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Fix the parenting of clocks imp_iic_wrap_ap_clock_i2c{4-6}, as those
> > are effectively parented to infra_ao_i2c{4-6} and not to the I2C_AP.
> > This permits the correct (and full) enablement and disablement of the
> > I2C4, I2C5 and I2C6 bus clocks, satisfying the whole clock tree of
> > those.
> >
> > As an example, when requesting to enable imp_iic_wrap_ap_clock_i2c4:
> >
> > Before: infra_ao_i2c_ap -> imp_iic_wrap_ap_clock_i2c4
> > After:  infra_ao_i2c_ap -> infra_ao_i2c4 -> imp_iic_wrap_ap_clock_i2c4
> >
> > Fixes: 66cd0b4b0ce5 ("clk: mediatek: Add MT8186 imp i2c wrapper clock s=
upport")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
>=20
> I'm curious about what led to discovering this error?
>=20

Is that an acked-by?
