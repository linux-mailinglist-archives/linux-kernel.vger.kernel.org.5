Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AC87A67D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjISPTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjISPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141C94
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:19:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC43C433C7;
        Tue, 19 Sep 2023 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695136775;
        bh=z8T+8uQO21bo1TZjK0Gx3AzwHZt/eRvJ0PK66t78Dk0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rl98rjfxfGMxW304yy36J+t/rhXwNZ3QF7+FuAlml8PJ2rKkx6S2Ne5mXdZi7/0y2
         gjepTHulacEElD7Im0lvhvaOV+YGbBupXQs0XOdEfyn3cChPngggGO2Z+5zzoE9p/D
         r3qUPIGEeN9Lmsed8pGh6I9b9xdIM9ijStp5Hgx1p8wv3yh6itK1FKi7SFe2hWRqGF
         DmuneK1HM0F+ZzUMTGzK9GbzbPp6rsQW8I/haUkbay1K3Y4wPvOsHW69p9kWDsz5L4
         6/pcHI9bE8IKtQG22OrqRdja7ohuNWeO4GHIz1CbZGt6NxdKmVwLf6ysuGp9Hc5Pss
         GpnnJWVG0M+Yg==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828160224.92037-1-biju.das.jz@bp.renesas.com>
References: <20230828160224.92037-1-biju.das.jz@bp.renesas.com>
Subject: Re: (subset) [PATCH v2] mfd: max8997: Simplify probe() and drop
 max8997_i2c_get_driver_data()
Message-Id: <169513677451.3263936.5967549332973612199.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 16:19:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:02:24 +0100, Biju Das wrote:
> Simplify probe() by using i2c_get_match_data() instead of
> max8997_i2c_get_driver_data() for retrieving match data from
> OF/ID tables.
> 
> 

Applied, thanks!

[1/1] mfd: max8997: Simplify probe() and drop max8997_i2c_get_driver_data()
      commit: a17eaf36319c7e209f50f3da7d5a5ebc104e5bb6

--
Lee Jones [李琼斯]

