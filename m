Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7FC7D45A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjJXCjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXCjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:39:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB310E7;
        Mon, 23 Oct 2023 19:39:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8072C433C8;
        Tue, 24 Oct 2023 02:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698115155;
        bh=piXga/OrS0AqCVY619AqIoM6NsxZNT/IHIFGfSBWc2s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RPxi7wcqnY8LcO1ZIDRv4+bsr5+wVrMCClH4kYOo5aGeCoMim30S8nV9uY+aadeAv
         jCkJYMN/0ShFpO3zdk9h5Xk6dIIx1ZNgyH5SgY/knaOX7lIFXNhmN1YoD5DrO8ezyI
         WijLnADpmpItzhq9R9RPeWyDbZmgsrB4eGIrFg5LRZM2sbv/ct3YnlgM798c9VyrMg
         5QKlQ1+m8tnuSkLBGZfbaN2O6diVZMXNjmgmjhM7ZvzATWaX4VXloxdFScMCSJUgw9
         TJsaC0YXy3p/+Ww5SuVlsRx2ryUCLNm2qK5NvmXLrGL4MT2WvtHouurJt3m94kKmPO
         r9WM80xheYyYw==
Message-ID: <f039e5c9c373710218dfd1e96a89d7b1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909150516.10353-1-biju.das.jz@bp.renesas.com>
References: <20230909150516.10353-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: cdce925: Extend match support for OF tables
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:39:13 -0700
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

Quoting Biju Das (2023-09-09 08:05:16)
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>=20
> Unify the OF/ID table by using struct clk_cdce925_chip_info
> as match data for both these tables and replace the ID lookup table for
> the match data by i2c_get_match_data().
>=20
> Split the array clk_cdce925_chip_info_tbl[] as individual variables, and
> make lines shorter by referring to e.g. &clk_cdce913_info instead of
> &clk_cdce925_chip_info_tbl[CDCE913].
>=20
> Drop enum related to chip type as there is no user.
>=20
> While at it, remove the trailing comma in the terminator entry for the OF
> table making code robust against (theoretical) misrebases or other similar
> things where the new entry goes _after_ the termination without the
> compiler noticing.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
