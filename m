Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619677D459B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjJXCgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjJXCgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:36:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F069CD7C;
        Mon, 23 Oct 2023 19:35:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88730C433C8;
        Tue, 24 Oct 2023 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114958;
        bh=aRmpAwJKi69d4QAtIptDIRLr7n12/Xv3AXM+IN26NCg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=guIATA1CxrkJm6/RdbmKpvpGGiKkJwRv4Q0DEll5p4b2eMH6tgxOwd6WURjx5nM6g
         kz1cLQdRbyyB6Pkaun1VW9BOVEJmXqt+2sn3P6bIOF2MDJk+nmV0odj8DSL+yV3QAt
         7we3eU3WC9/wbmGcv9BkVIm7hYozIuomeji6NgK4BQEBOwhvOjaFYyps6za9fr4bR3
         WSbpj3ww+IYCWE89q4kS5NVSJJBewD7htDxSiGqa4g+zJtHoYs26TZzPo60u8wsMbQ
         2CT/s7xQKsY0G5bJgEuYHxR/r18ATiPvZL7L+7MVt5OtKmOelDO47fiIEaHvmm9irj
         nj6c6H1z2reeg==
Message-ID: <f6653424f52f4fb1c8b2c6755b2fb0d7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909160218.33078-1-biju.das.jz@bp.renesas.com>
References: <20230909160218.33078-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: rs9: Use i2c_get_match_data() instead of device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:35:56 -0700
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

Quoting Biju Das (2023-09-09 09:02:18)
> The device_get_match_data(), is to get match data for firmware interfaces
> such as just OF/ACPI. This driver has I2C matching table as well. Use
> i2c_get_match_data() to get match data for I2C, ACPI and DT-based
> matching.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
