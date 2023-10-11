Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5187C5F23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJKVbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:31:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9BA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:31:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210BC433C8;
        Wed, 11 Oct 2023 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697059904;
        bh=lLHvRjO2hpj6pfzRBw60Ir1FexEK3IHfQeGlLMPq+4E=;
        h=Date:From:To:Cc:Subject:From;
        b=ZcXMT7cdPU4QNv5ttgsv97XAMjAfmVuVEAbVODHGFQjnWw+lb/9oJKAPsfVWxNoJ4
         Dst9SlHBU/71FSEfMXNT1iSKRAreG9Q9pdk+Wb7210cW7RQiEmORknUqAaQ8iwEChA
         SsS1Y+yXvqcs5MMdJYKTMOUhWKdNIpKWLpXWbNBoKHF3o8xAuTzHdjwMXZzc3vznVM
         ocWqF5UR74AHCj2Oz2PcrG9GSSCqspGKTQKSHuM6BY39tV47XihKOZiE2Q06zOvKW2
         ndCqI9Qr++/pkvXdvCyveNhjP9QyISXmhlGe32uysv2o1tmUINKAJbUnIVRSRWrGkm
         OJ4WFterEyTuQ==
Date:   Wed, 11 Oct 2023 15:31:40 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] Fix undefined behavior bug and add bounds-checking
 coverage
Message-ID: <cover.1697059539.git.gustavoars@kernel.org>
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

