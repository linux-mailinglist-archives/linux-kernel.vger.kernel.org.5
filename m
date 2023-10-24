Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E267D456B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJXCU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXCUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:20:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4AEA;
        Mon, 23 Oct 2023 19:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFDFC433C8;
        Tue, 24 Oct 2023 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114022;
        bh=qHFLDEl/5h5NDJ2DKT7apAOR/E+2WF1tok1bPg1QJzE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DhxjRn0CqvsNqrIgvbgk87C2Hy+mTnx8SQ7/T+a1G4OqW5UFCd62uBf97MBu7lGwM
         qy7dGKNTtvtSpBsBqoW0DO3siX2NBhobpu69r2k+fsEdug2q/W7LkLJJLKTU8WD89X
         g6OapBxRpaz8hjf4Z2fcUD7/Rwh2apTLmIE2+Jkk+j8dsXmX/xx0b2Eb++/8C6R4YS
         EtW9UXxcP7fpk00jsEYeKHRwpTfiQboMEhbXRX6WPrJdT6Zy7vq3a0sNjRPS6U+7NC
         tGkGHjBoAHB6PHcN8gshpR8zV361YyPQUd9KJ1bcygp6ibOTltir0VqvX4p6euM5FD
         Mdi+2/eAqD7rA==
Message-ID: <28dc00c3f15f3023e0d963eff2333e13.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
References: <1669569799-8526-1-git-send-email-badolevishal1116@gmail.com>
Subject: Re: [PATCH v5] Common clock: To list active consumers of clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        mintupatel89@gmail.com, vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>
To:     Vishal Badole <badolevishal1116@gmail.com>
Date:   Mon, 23 Oct 2023 19:20:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vishal Badole (2022-11-27 09:23:19)
> This feature lists the clock consumer's name and respective connection
> id. Using this feature user can easily check that which user has
> acquired and enabled a particular clock.
>=20
> Usage:
> >> cat /sys/kernel/debug/clk/clk_summary
>                       enable  prepare  protect
>                                                                          =
 duty  hardware                            Connection
>    clock               count    count    count    rate   accuracy phase  =
cycle    enable   consumer                         Id
> -------------------------------------------------------------------------=
-----------------------------------------------------
>  clk_mcasp0_fixed         0        0        0    24576000          0     =
 0  50000     Y   deviceless                     of_clk_get_from_provider
>                                                                          =
                  deviceless                     no_connection_id
>     clk_mcasp0            0        0        0    24576000          0     =
 0  50000     N      simple-audio-card,cpu           no_connection_id
>                                                                          =
                     deviceless                      no_connection_id
>=20
> Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vimal Kumar <vimal.kumar32@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> ---

Applied to clk-next
