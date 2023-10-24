Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225F77D4587
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJXCdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:33:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB588E5;
        Mon, 23 Oct 2023 19:33:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A34AC433C7;
        Tue, 24 Oct 2023 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114819;
        bh=VHcurXXSVkvkAK2DzgY2dDmLC7I9sifMTFd/DQGKmkg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r/snLQnTJ95Wlg+c22LIo09Tx2/flpcOel9RGgxnIL6oaazo1K2PRRJN97/p4PhWH
         9sushNZI0lpCZx5zTSd+Rs3uhu2XFc5dLExoJdFyR2eoKB8dEgRDCuencGJv94y50m
         3dzCHo0VFEG/OaNQBQGcQ4hXo9zayZmZIwvdls/w6Aizpm5749/qLN2xi6D/oRUvUH
         xP3/KHAQXdZQZfsyyCxkSMO4orlzXamCa0j4TL6gSSaa7mP8KrbR8M6rhWh8I+TeLG
         zZt0AfyUltYk/qaHaHvccUNBQdpvJv36OkXp1bg0LC2/X+ZGm0CuwgpO9DR0Gcb3Mf
         vqgu+IW873RPQ==
Message-ID: <c63250265a1a4509675f8791756c064b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909152847.16216-1-biju.das.jz@bp.renesas.com>
References: <20230909152847.16216-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: si521xx:  Use i2c_get_match_data() instead of device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:33:37 -0700
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

Quoting Biju Das (2023-09-09 08:28:47)
> The device_get_match_data(), is to get match data for firmware interfaces
> such as just OF/ACPI. This driver has I2C matching table as well. Use
> i2c_get_match_data() to get match data for I2C, ACPI and DT-based
> matching.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
