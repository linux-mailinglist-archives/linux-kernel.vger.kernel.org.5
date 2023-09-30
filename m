Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03D7B4462
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 00:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjI3WOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjI3WOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 18:14:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F51CF;
        Sat, 30 Sep 2023 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=v7APsD/u2oxKfmW91znSSbsDyTPJD7vIhjjteG0qDkE=; b=LF9+YNXA2KLFkZ+c0iFzAflQ/r
        T+wvUZDIlPflcLcqYpq0rgNblhoZScTM28ulq8FBTtQ8TYr5Mjr5/fbrTGFYhR4SRkm03bYZh8A8B
        dnI7AH0EcAX57gnXEeQfGV1uv78ySoFpJoPhHE2dNr7AGBJaM5CL9SrS/rfRg92rFyu3rFGb5jOo1
        0jYi0KLI9BaFwdclG+mdhJlFRdZ2f5HMHTlee7c2MfkToibc0Ix26B8+U/CeJpet3EnRlZpWQw39r
        n8uP/uCE1xLVUvpHAiQlKKykCo7mTxXNKSqzcgBg7NgWGBI1VCcq9nmRjqYyZqEQG7a/CGmxQADz7
        atA/zidg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmiEH-00AAxS-25;
        Sat, 30 Sep 2023 22:14:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH] clk: linux/clk-provider.h: fix kernel-doc warnings and typos
Date:   Sat, 30 Sep 2023 15:14:26 -0700
Message-ID: <20230930221428.18463-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of "Structure".

Fix multiple kernel-doc warnings:

clk-provider.h:269: warning: Function parameter or member 'recalc_rate' not described in 'clk_ops'
clk-provider.h:468: warning: Function parameter or member 'parent_data' not described in 'clk_hw_register_fixed_rate_with_accuracy_parent_data'
clk-provider.h:468: warning: Excess function parameter 'parent_name' description in 'clk_hw_register_fixed_rate_with_accuracy_parent_data'
clk-provider.h:482: warning: Function parameter or member 'parent_data' not described in 'clk_hw_register_fixed_rate_parent_accuracy'
clk-provider.h:482: warning: Excess function parameter 'parent_name' description in 'clk_hw_register_fixed_rate_parent_accuracy'
clk-provider.h:687: warning: Function parameter or member 'flags' not described in 'clk_divider'
clk-provider.h:1164: warning: Function parameter or member 'flags' not described in 'clk_fractional_divider'
clk-provider.h:1164: warning: Function parameter or member 'approximation' not described in 'clk_fractional_divider'
clk-provider.h:1213: warning: Function parameter or member 'flags' not described in 'clk_multiplier'

Fixes: 9fba738a53dd ("clk: add duty cycle support")
Fixes: b2476490ef11 ("clk: introduce the common clock framework")
Fixes: 2d34f09e79c9 ("clk: fixed-rate: Add support for specifying parents via DT/pointers")
Fixes: f5290d8e4f0c ("clk: asm9260: use parent index to link the reference clock")
Fixes: 9d9f78ed9af0 ("clk: basic clock hardware types")
Fixes: e2d0e90fae82 ("clk: new basic clk type for fractional divider")
Fixes: f2e0a53271a4 ("clk: Add a basic multiplier clock")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 include/linux/clk-provider.h |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff -- a/include/linux/clk-provider.h b/include/linux/clk-provider.h
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -74,7 +74,7 @@ void clk_hw_forward_rate_request(const s
 				 unsigned long parent_rate);
 
 /**
- * struct clk_duty - Struture encoding the duty cycle ratio of a clock
+ * struct clk_duty - Structure encoding the duty cycle ratio of a clock
  *
  * @num:	Numerator of the duty cycle ratio
  * @den:	Denominator of the duty cycle ratio
@@ -129,7 +129,7 @@ struct clk_duty {
  * @restore_context: Restore the context of the clock after a restoration
  *		of power.
  *
- * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
+ * @recalc_rate: Recalculate the rate of this clock, by querying hardware. The
  *		parent rate is an input parameter.  It is up to the caller to
  *		ensure that the prepare_mutex is held across this call. If the
  *		driver cannot figure out a rate for this clock, it must return
@@ -456,7 +456,7 @@ struct clk *clk_register_fixed_rate(stru
  * clock with the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
- * @parent_name: name of clock's parent
+ * @parent_data: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  * @fixed_accuracy: non-adjustable clock accuracy
@@ -471,7 +471,7 @@ struct clk *clk_register_fixed_rate(stru
  * the clock framework
  * @dev: device that is registering this clock
  * @name: name of this clock
- * @parent_name: name of clock's parent
+ * @parent_data: name of clock's parent
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
@@ -649,7 +649,7 @@ struct clk_div_table {
  * Clock with an adjustable divider affecting its output frequency.  Implements
  * .recalc_rate, .set_rate and .round_rate
  *
- * Flags:
+ * @flags:
  * CLK_DIVIDER_ONE_BASED - by default the divisor is the value read from the
  *	register plus one.  If CLK_DIVIDER_ONE_BASED is set then the divider is
  *	the raw value read from the register, with the value of zero considered
@@ -1130,11 +1130,12 @@ struct clk_hw *clk_hw_register_fixed_fac
  * @mwidth:	width of the numerator bit field
  * @nshift:	shift to the denominator bit field
  * @nwidth:	width of the denominator bit field
+ * @approximation: clk driver's callback for calculating the divider clock
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
  *
- * Flags:
+ * @flags:
  * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
  *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
  *	is set then the numerator and denominator are both the value read
@@ -1191,7 +1192,7 @@ void clk_hw_unregister_fractional_divide
  * Clock with an adjustable multiplier affecting its output frequency.
  * Implements .recalc_rate, .set_rate and .round_rate
  *
- * Flags:
+ * @flags:
  * CLK_MULTIPLIER_ZERO_BYPASS - By default, the multiplier is the value read
  *	from the register, with 0 being a valid value effectively
  *	zeroing the output clock rate. If CLK_MULTIPLIER_ZERO_BYPASS is
