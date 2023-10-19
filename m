Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21557CED27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJSBGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:06:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC7B8;
        Wed, 18 Oct 2023 18:06:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFB4C433C7;
        Thu, 19 Oct 2023 01:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697677580;
        bh=64x4DMR9WJmGdd362zblo6FJofeDBwyFBwAvoTeE+tM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H3xlOcCmbdfrlbStbX7qyC2+1tccKl62m4RuhR3aw0fTjilSG2GVcd0X525VfIZmE
         +xT5CC+IDOJnZgVyNv0SL3dvY6/AS85SchslrFjKl4xE+52nrmneSe0sKr9AUxcmHJ
         eDArIfn6EjfAKc2cfBVPe4F1iXZMzEVMI+Rz5mQXFOz5BPg/WYPEafdQom8gHDEgDr
         Sghg/CZnnEkVwFzXnB+0+9mirKKR+2eUoLUb+xbWwOcH2imPxClCkK1mSwCTyK9cxX
         kW8ZEzVkjTBUk9vmkCUsS4coo7tmQhD01QxDXO3odcq4XT8UIXzkdPY7pg7J6qEiAo
         kAl1oCjttcG6g==
Message-ID: <0da1eb8c9b8ef294309c1027896c409b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230923133127.1815621-1-j.neuschaefer@gmx.net>
References: <20230923133127.1815621-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH] clk: npcm7xx: Fix incorrect kfree
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Wed, 18 Oct 2023 18:06:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2023-09-23 06:31:27)
> The corresponding allocation is:
>=20
> > npcm7xx_clk_data =3D kzalloc(struct_size(npcm7xx_clk_data, hws,
> >                            NPCM7XX_NUM_CLOCKS), GFP_KERNEL);
>=20
> ... so, kfree should be applied to npcm7xx_clk_data, not
> npcm7xx_clk_data->hws.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
