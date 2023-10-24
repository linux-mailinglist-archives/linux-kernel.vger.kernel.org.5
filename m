Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F527D459F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjJXCjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjJXCi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:38:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4410E;
        Mon, 23 Oct 2023 19:38:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A7EC433C8;
        Tue, 24 Oct 2023 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698115110;
        bh=BLAd6gTx1iuzo/h4jYfc87V+EX4iiNpqySH5+O3AwCA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XITxCeLMW5Y7+vmuVAqgqyvOyeoOXEFdXycPwuOcMYKIINKAoevSwstM+Uhy99ScJ
         CUMF0RwSFEI9h9KKjhcKgR5mUcQEy5vNy6CPEYnhlF41xyj1dRMapQatjoN5v+WN4Y
         gywPwvPExB47myrYIxmG8oCzl956R4Iw/en+cRi44JkY9Q/Y/udA8RYCe4sKfTQCbF
         2zbDW/kwf0jrhSg6lmr59ql81w0Vk2ahW14ctH/jftcoZYrARVZTt3wc0AY5wIyONy
         roTL9ryjjOGOpkl+tO6kWaSwvPMnUoKWD0ie4tcQhDgXbHZMeUbzBmoYYp5N8+Rd90
         6GkGoFsbPItRQ==
Message-ID: <44e42cafc7a20083b139a6bb40628a1a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909164738.47708-1-biju.das.jz@bp.renesas.com>
References: <20230909164738.47708-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: si570: Simplify probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:38:28 -0700
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

Quoting Biju Das (2023-09-09 09:47:38)
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>=20
> Unify the OF/ID table by adding struct clk_si570_info as match data
> instead of clk_si570_variant and replace the ID lookup table for
> the match data by i2c_get_match_data(). This allows to simplify
> probe().
>=20
> Drop enum clk_si570_variant as there is no user.
>=20
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
