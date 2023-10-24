Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51ED7D4596
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjJXCgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJXCfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:35:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983C10D9;
        Mon, 23 Oct 2023 19:35:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EFAC433CA;
        Tue, 24 Oct 2023 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114941;
        bh=Q5OM8zqw2zTU56yqEkXyN/h5VL/CRznzcuemWZ4Rs7M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hs2b5UDqeY393JE+uSBUAt7n+HPyEIt+z2MOBLqksFSaPzbRimYeg36SYSh+owlz/
         PDxevHw8dqQi3C8Xeh2mF97D8a3uORuooqWjoWSFyubnNmkgLs0UAwmx/t8HQnqkwk
         v1mk79YQhGXrrYVSsm7C8PREE1d6Le1Rya1N3HsUeTwfLJghDSJWz+TzTk/5qhZscP
         SdCGQeXS9nWcZM1D590CFYXw5nJ60hJVi1lo+VMp5QchM+OEWXcpTPf25i6G1eiWcE
         kSfE9oHwfACs9biD5tj7ovtBnxppLIddvsR+rTTdnrJ0Mk85XQiodiFxRSQddqeqEe
         L3TfzyizRiP8A==
Message-ID: <961ca9d413ac51ff26d59f5190c8970e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909155418.24426-1-biju.das.jz@bp.renesas.com>
References: <20230909155418.24426-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: clk-si544: Simplify probe() and is_valid_frequency()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:35:39 -0700
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

Quoting Biju Das (2023-09-09 08:54:18)
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>=20
> Unify the OF/ID table by using max_freq as match data instead of
> enum si544_speed_grade and replace the ID lookup table for
> the match data by i2c_get_match_data(). This allows to simplify both
> probe() and is_valid_frequency().
>=20
> Drop enum si544_speed_grade as there is no user.
>=20
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
