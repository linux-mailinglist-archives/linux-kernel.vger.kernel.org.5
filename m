Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26537CB636
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjJPWHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjJPWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:07:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4B9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:07:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5349C433C7;
        Mon, 16 Oct 2023 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697494026;
        bh=KbRjPe/m0vYV7NLiB44bDbiYy0uwlThE07mcdMR+BYE=;
        h=Date:From:To:Cc:Subject:From;
        b=G0SFAe0HOZaPrCWs7giuy1vldA7AUDxIQ4C7EljfclACFsXNAA/Fo2q3M6VTSMHXX
         UqFxCFgfZRlXr5PZygNSIiOoLdAIkp0Lih/JF/0KIVKzGgDTt2FU1L+BFYh1Vqb8gB
         tj7WmqzKJL8qybTMRsl4WGwvjSuLR2UT1aGbTgnRjtE5IvORWB1zmS2MeBGSmq5Ocn
         jlx6HdqOGqbZiRTPEK5dvTRfYKDadWhGt0izuzu+CPdcx4SUIjG2QevWytHB7fPMbD
         gT1U378Zdk2rCjkyuvC3I5r/LLE3HhHQlhjjJUjZ8DinXgHghg3mE2fKxZQMGkVNdP
         5TkHHrCRktu3w==
Date:   Mon, 16 Oct 2023 16:07:03 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2][next] clk: socfpga: Fix undefined behavior bug and
 add bounds-checking coverage
Message-ID: <cover.1697493574.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.

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

