Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4D75662C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGQORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGQORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCD31BCD;
        Mon, 17 Jul 2023 07:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56C56108D;
        Mon, 17 Jul 2023 14:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91EEC433C7;
        Mon, 17 Jul 2023 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689603412;
        bh=TR980lv7Vb0E31av0d0J7WcCVxuuDRv28rDvU650wpY=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=Lum3I2apBOzxL1TokrWM3nbkwBu430wgrqGCYgS/aByDlfQ6rYgkzLpRUQly9EwdU
         leQaRVgo/Y+6yFxj6FG21eMqd4JiaxcjJLQzQmmkfPT+r9UZHcu5NQNb1Q2XRmvvLa
         3NFJGCQtw4Pd+3yNqVmlUut5eabCzXyf6yowRfbuf51mgfJEJFGlEE/GCwL4okvXCG
         1IqdCC2KtFB8S1V9jyxPaja25hK9HlAK7ZjpG3IwPJD85TCFvyEzmDXyGGeUrWndX5
         GkzdWEq5bA8IVXW6W1GJdu5roSpOxSMHzEN04fHfArcAA54fEaGdScy/dhdD7mddDg
         LYbSZESICB4Dw==
Message-ID: <e281ed77c9c10213d6f44b2067c59367.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 14:16:49 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Subject: Re: [PATCH v4 11/11] clk: sunxi-ng: a64: select closest rate for
 pll-video0
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-11-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-11-04acf1d39765@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Roman Beranek" <me@crly.cz>,
        "Samuel Holland" <samuel@sholland.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 15:34:35 +0200, Frank Oltmanns wrote:
> Selecting the closest rate for pll-video0 instead of the closest rate
> that is less than the requested rate has no downside for this clock,
> while allowing for selecting a more suitable rate, e.g. for the
> connected panels.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
