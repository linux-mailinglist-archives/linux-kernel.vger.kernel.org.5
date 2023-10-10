Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26547C03E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjJJS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjJJS4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:56:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB81B93;
        Tue, 10 Oct 2023 11:56:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A3BC433C8;
        Tue, 10 Oct 2023 18:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964212;
        bh=Kfg6W1o5GY/gdJRUqS6uOzCj8+OvbwvifdKKhp+HQuM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Bkt0cta2tvH0ovRyUvC5KeSoVi19QTsjPmHfjddmlDDMaM1En3qXb8ElbfyTYFHji
         1qfs0K/F1cn8XZpKROokyw7t2Mw0i/3J+6pCkhhbz3NvDRQZ3S6g/IIC1No5iMvyeG
         ExUzEnSxMnzbE2ppV/C6H5XDMijfTp1V2hwAxwxIRX4gQI53yeZ8BD4TGm3zB/cGHp
         DsTHZpIa+g9MWOqk1OwwSigi3N3yEDYBxozh6TywPECSo06gCNZUBeRzNvdxVrFbFY
         X5ilCfYwkFyuUulzzowOsT2lSCBq63JKWnLvMsLsMQy3KQ4AY2n5z3tMWAd7JvFpIt
         VX3lJeCbE2/Jw==
Message-ID: <7b764568ea372f0a947798fb3c2dac75.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231009114514.120130-1-arnd@kernel.org>
References: <20231009114514.120130-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: imx: imx8: build base support for scu clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Abel Vesa <abelvesa@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 10 Oct 2023 11:56:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2023-10-09 04:44:55)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There is now a dependency on a function from the clk.c file, so
> this also needs to be built:
>=20
> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_c=
lk_probe':
> clk-imx8-acm.c:(.text+0xbf0): undefined reference to `imx_check_clk_hws'
>=20
> Fixes: d3a0946d7ac9a ("clk: imx: imx8: add audio clock mux driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Is this another https://lore.kernel.org/r/20230921093647.3901752-1-abel.ves=
a@linaro.org
