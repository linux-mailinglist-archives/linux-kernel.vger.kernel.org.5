Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC4759EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGSTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCF1BCF;
        Wed, 19 Jul 2023 12:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC57617DA;
        Wed, 19 Jul 2023 19:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A476EC433C8;
        Wed, 19 Jul 2023 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689796262;
        bh=+UIZJuew3LXED+YxrmGBHpLYD5/jx6ezttAhPttbvwY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XiSvgTN0j4HVfMmSRBCX1GBvawpDxYI4LbS4Sb+C3nCpL9PsaA/m236d792tFESJW
         09QdKD47NY/1dtA54ykc70E9uROioQZ6GzO6pmr44Lmn1lbRzduBNfQp4Ut/b26X6c
         MjCgc1nP6zXPs5+9DyyJzYZaCJMaGjYOayWDnxs3hmm1IPJSFtHHzKgN+/cfA4y7v5
         fyKtaMeqkaKszGiCm9xb3I4GbbBpd6OkNh4qMN2xS8a69AD+Xu7EdFqJWO9rV/B8OO
         xrsjU98XzM2PkvXBbw5z0dxOsLyeNhajz2fbfp9ItyEit0eCMQ7+PmyXGZeQ7Q3U60
         XF7tMJJ2uSq6A==
Message-ID: <959d395c63a60c4bff156b2f121811ad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <085541814ebe2543cb7e8a31004c0da3e7d5b6eb.1688760111.git.christophe.jaillet@wanadoo.fr>
References: <085541814ebe2543cb7e8a31004c0da3e7d5b6eb.1688760111.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: starfive: Simplify .determine_rate()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 19 Jul 2023 12:51:00 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-07-07 13:02:18)
> jh71x0_clk_mux_determine_rate() is the same as __clk_mux_determine_rate(),
> so use the latter to save some LoC.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
