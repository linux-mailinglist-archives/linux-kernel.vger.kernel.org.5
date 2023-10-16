Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E67CB62C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjJPWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:04:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8C9B;
        Mon, 16 Oct 2023 15:04:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E17C433C7;
        Mon, 16 Oct 2023 22:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697493888;
        bh=Zu8r+UFNm3vd5emenr5/jPt+Q2RIuOTafj17uJohU+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=SDJ3m32h5Fq72f4xV1Mgs/ZVsIsG4MjIHRKKj/QV8CAZ77CUIzbBiFEqi2QnZz0yR
         NspIuMLPXzPeHhLFILOZ/UehXr7pIloHyDcr42gnrgPlmqSJDZkDIjy2Q7yeU23lDM
         vqH8+YmU4V0GTZPZKHMl5Ti64omHBT0tydfkyFNp5vjbevwRvEhPT1agkRuiY55d7l
         y0UoOCnk0XhVXZJy82x+htxUg081xzhEJPlEAGCzgYRlnXfyQm9BoOrCR45U9lcOAI
         75huKhqZ9nLcNvR4a1FUSkcT7U1IPqlSbU5087htRSiXfsgTVEPPljFoEJQYuUWq7d
         6RI2mMc7nuG9w==
Date:   Mon, 16 Oct 2023 16:04:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2][next] clk: visconti: Fix undefined behavior bug and
 add bounds-checking coverage
Message-ID: <cover.1697492890.git.gustavoars@kernel.org>
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

This small series aims to fix an undefined behavior bug in
`struct visconti_pll_provider` and add bounds-checking
coverage at run-time for flexible-array member `hws`
in `struct clk_hw_onecell_data` when accessed throught
`struct visconti_pll_provider`.

Changes in v2:
 - Mention -Wflex-array-member-not-at-end in the changelog text.

v1:
 - Link: https://lore.kernel.org/linux-hardening/cover.1697076650.git.gustavoars@kernel.org/

Gustavo A. R. Silva (2):
  clk: visconti: Fix undefined behavior bug in struct
    visconti_pll_provider
  clk: visconti: Add bounds-checking coverage for struct
    visconti_pll_provider

 drivers/clk/visconti/pll.c | 6 +++---
 drivers/clk/visconti/pll.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1

