Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB407D459D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJXCgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJXCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:36:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB49310CB;
        Mon, 23 Oct 2023 19:36:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433D4C433C8;
        Tue, 24 Oct 2023 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698114988;
        bh=/ntFqWlZOSrFN5h7F1g134fKEDXkzE06VefnG5D/BsU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SjMEhmLbasRCbIKduAKjjoLFEdtMpFGf+wznDfM1nf0UOqX9SmYLGs7/tITkFw+x+
         57JYGG+Iw9xKCC24RBXi7H4jDZ03WgYHhWVqsIAvOTRxug4uSNoCCHN1a1ZhMLYVyP
         A9t+JzGrhu91tFCzxbbwCb7v71NQ9lLnWXYRVdJJlr4ww60a4MpoLw56aycu3ShTxF
         T/LqlreDIK9ElLj8MB0ZVzD6IuG1SbJM5pIRnK6PfTrFvkjLZOnPbx5xv+kLyBDTsI
         lxZ4c1Gz2dB2wIQj4K6MT59ABFd7KkpUe7Q2WoNdkHiKnnorHMYd0722hHnKgsTxfF
         P9NHpUJibW1dg==
Message-ID: <05698f7e76734125ad06c52b9fc495fe.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230909162047.41845-1-biju.das.jz@bp.renesas.com>
References: <20230909162047.41845-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] clk: si5351: Simplify probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 19:36:26 -0700
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

Quoting Biju Das (2023-09-09 09:20:47)
> The driver has an OF match table, still, it uses an ID lookup table for
> retrieving match data. Currently, the driver is working on the
> assumption that an I2C device registered via OF will always match a
> legacy I2C device ID. The correct approach is to have an OF device ID
> table using i2c_get_match_data() if the devices are registered via OF/ID.
>=20
> Simplify probe() by replacing ID lookup table for retrieving match data
> with i2c_get_match_data().
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied to clk-next
