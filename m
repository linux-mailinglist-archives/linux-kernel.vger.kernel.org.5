Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0075A0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGSVkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSVku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBFE1FCD;
        Wed, 19 Jul 2023 14:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EEBD61841;
        Wed, 19 Jul 2023 21:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA20C433C7;
        Wed, 19 Jul 2023 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689802848;
        bh=TaLerVSG9EvBBPGx6SsQ3R1J0acVBnahUF0b+A53yz8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oqxGijWDGdJ4wRhwBHYjDBAVISHRzmGigrT79or5dg5v5tWZFV7Jk80KW2atVR1gj
         RXEbf9aiEHea3KkpxvsAhDSBfNjsRloB3q29awBRqpX1b3aWOUqdaBPyGI2ULgXwtx
         /G+pc9GiQOIGlSQudHaBiZKAsdR5MGcxO9mJrOTIOQzg5e+SahkpCSCXv6m/rthxaH
         BL08kEwsVHEk0JhjEO3fcTySrNGENktWM3qGxE4IN6Yqr681l5el8FcFO0U7uuorRA
         sx7mm0oJCmdVyTpDdXAK4vsmdoau6ybEMT6ud9VChG/GUl2cB/kNVyFlYED3MsIjcl
         U7mbjR8IOVvtw==
Message-ID: <f3252bddf5ade38ce9bbda74bc352aa1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230712102246.10348-1-duminjie@vivo.com>
References: <20230712102246.10348-1-duminjie@vivo.com>
Subject: Re: [PATCH v1] drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Minjie Du <duminjie@vivo.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jul 2023 14:40:45 -0700
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

Quoting Minjie Du (2023-07-12 03:22:46)
> The function clk_register_pll() may return NULL(in line 149) or ERR_PTR
> (in line 131).
> Fix: make IS_ERR_OR_NULL() judge the clk_register_pll() function return.
>=20
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---

Applied to clk-next
