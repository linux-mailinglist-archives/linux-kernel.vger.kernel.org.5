Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F97C6295
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjJLCOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjJLCOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:14:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF198;
        Wed, 11 Oct 2023 19:14:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75749C433C8;
        Thu, 12 Oct 2023 02:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697076888;
        bh=c3G3HVGvGIs8FEY0jb1ba95NJxbK+CEvkZgGlWn3Ck8=;
        h=Date:From:To:Cc:Subject:From;
        b=WjwYMpdrkWZm3vLulM3RsDQKQum6qGR9K0uqFhKd8F01NZVWAXktIY/Ko1CBeT8x8
         WRGwXIXVZTewXpB417CEpj+b0DiWl/L3YO9qkTKxPqNc+7WSO2RbwneUFB0xADWeVS
         Sd2Lb2J6A+YeGMh7EWLkGT8gQL3wYsLIn7K56oUXa5CVDow7lWGriOTyJ7hZmicXec
         gkEiDUJ3QwyH1VXFLYl5jHxtGwgwml6rTE+zvqyZ7HoR3GyuPYdUuycvPrvbWnjuCj
         iXgydgtZP/O7gLo0q6vFbFZIQFHpQfziccSsoFGUsrXAlCKvMnVH++uCGSbnbyItyd
         N8lANoTEHuT2A==
Date:   Wed, 11 Oct 2023 20:14:44 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] clk: visconti: Fix undefined behavior bug and add
 bounds-checking coverage
Message-ID: <cover.1697076650.git.gustavoars@kernel.org>
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

