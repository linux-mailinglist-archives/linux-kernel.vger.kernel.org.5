Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478258118F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjLMQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjLMQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:16:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21824DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:16:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCE7C433C9;
        Wed, 13 Dec 2023 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484187;
        bh=nO/Afdb1MQKBEbsD0Fg8t6VLdNzw0l4HZRWVO9Xe1jk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YEnh6kWZVMSxojQd7SFu7l2lTpqmRjiQF4Vge6kQ1wOxYB1ku/1bP3LytqpqAFLbz
         h743XU7UCLaUZ5W2RdDjD/ipVd7Z48mrFjqRXiuFqwBnQDgCss5JVtHUmDSQ4swxsE
         2ms+RHTAK1VwmRKb2oCnQLTSck1WALJLXwpQsHjzJPB7Zilv+EwJKwz4D2aGzk1wE9
         7SVKz2DM9ZcjsqpqN29xr3EVXb9nFlK/tzRwDa6glGzhJI0gfNsu8HCow4Omo0a1f8
         ajKBfOtMzhqwUr+O3Gqu43gmM3CU74zDpNdUY2OPvl2W9dPkiMSer5JZuBTwMfeS13
         XmAv5+SHJsP8Q==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20231212214536.175327-1-arnd@kernel.org>
References: <20231212214536.175327-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] leds: sun50i-a100: avoid division-by-zero
 warning
Message-Id: <170248418423.1005780.5339514949375553684.b4-ty@kernel.org>
Date:   Wed, 13 Dec 2023 16:16:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 22:45:22 +0100, Arnd Bergmann wrote:
> When CONFIG_COMMON_CLK is disabled, e.g. on an x86 randconfig compile test,
> clang reports a field overflow from propagating the result of a division by
> zero:
> 
> drivers/leds/leds-sun50i-a100.c:309:12: error: call to '__compiletime_assert_265' declared with 'error' attribute: FIELD_PREP: value too large for the field
>         control = FIELD_PREP(LEDC_T01_TIMING_CTRL_REG_T1H, timing->t1h_ns / cycle_ns) |
> 
> [...]

Applied, thanks!

[1/1] leds: sun50i-a100: avoid division-by-zero warning
      commit: f969d75a0218da32c40dd4940bd430b0530433cf

--
Lee Jones [李琼斯]

