Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7977D45F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjJXDaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjJXDaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1FBC;
        Mon, 23 Oct 2023 20:30:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ECBC433C7;
        Tue, 24 Oct 2023 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698118206;
        bh=m6aDnL/Wqs3CWj+B9Tf1lfn61pxuZpDr4pD8/+/qlYU=;
        h=Date:From:To:Cc:Subject:From;
        b=KHQ7sKHWH31O7ePKffnaxCnVkIz59sZ3XmACN8pX5LJL4JtG/MNhKzN+yVNF3EgW6
         AmJ+IFocfqLTCC6Fh/ts9yYtDVaQZw74pQbwCiEKE9zrh34V1qZ/CzFsgfoZxdBU6t
         wTpubIFUGFIDzWGG3+tP3RAhVw96PBGPhXeLCVb9203pOWTzz1kIcZG1hELthejFk/
         as0abOc2kbA9ZGw1Zr0EB5K+Qp5sLhXxdKy8UVEHQ4iFYng2TEpgNoaetKACHqGUgF
         sxS6W4+McVWZ3McNqhlnRvKV+F7vHrwuSs1Lhd2ffHhRRoMD0+Ctq6g5L8EqMZQ4Zw
         ZrM3wq4/kJ0FA==
Date:   Mon, 23 Oct 2023 21:30:03 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 0/2][next] clk: socfpga: Fix undefined behavior bug and
 add bounds-checking coverage
Message-ID: <cover.1698117815.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to fix an undefined behavior bug in
`struct stratix10_clock_data` and add bounds-checking
coverage at run-time for flexible-array member `hws`
in `struct clk_hw_onecell_data` when accessed throught
`struct stratix10_clock_data`.

Changes in v3:
 - None, really. Just Cc linux-clk@vger.kernel.org this time.

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.
 - Link: https://lore.kernel.org/linux-hardening/cover.1697493574.git.gustavoars@kernel.org/

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1697059539.git.gustavoars@kernel.org/

Gustavo A. R. Silva (2):
  clk: socfpga: Fix undefined behavior bug in struct
    stratix10_clock_data
  clk: socfpga: agilex: Add bounds-checking coverage for struct
    stratix10_clock_data

 drivers/clk/socfpga/clk-agilex.c    | 12 ++++++------
 drivers/clk/socfpga/clk-s10.c       |  6 +++---
 drivers/clk/socfpga/stratix10-clk.h |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.34.1

