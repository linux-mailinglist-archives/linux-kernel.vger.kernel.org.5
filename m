Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C17A6629
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjISOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISOHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:07:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C269E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:07:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2AC433C7;
        Tue, 19 Sep 2023 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695132454;
        bh=ZTXNrtYa8riMmojioy/I4uX0bECsCiu0juxJ9glnwSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVMJwim0uanWA/5J9CPoF1aTAlrvv9HvZ8bfJ7Wlizr3c5qmljiLpYtuWvTrPowlX
         MOl5L72MuQwJG5EmGD3yR/xzxsB18WqpEBWdWsY025MT6Pxuu0cM/nHaLXee8ETLe8
         sJRZwZHrNnmzVtR3g90lKbqJnAJTqfAd3f7YQGDNb8e3oF4O74g10CXgcIj4y93t0H
         Sf2tKZbfcorbWLePrkbKRzjnwrSMR3wb3FxYfknGd+4ARKzXMoJUCe8BaIJouMTd0e
         fj9AWt7WkttafBVcJ+3GlElFXdDDy/IRzuk4tXZY13jURgdW2L9HQ1l9rQ32GBLp0N
         nH5GOWnYdtUVg==
Date:   Tue, 19 Sep 2023 15:07:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH for-v6.6] mfd: cs42l43: Use correct macro for new-style
 PM runtime ops
Message-ID: <20230919140729.GV13143@google.com>
References: <20230919110320.1388527-1-u.kleine-koenig@pengutronix.de>
 <20230919135835.GT13143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919135835.GT13143@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Lee Jones wrote:

> On Tue, 19 Sep 2023, Uwe Kleine-König wrote:
> 
> > From: Charles Keepax <ckeepax@opensource.cirrus.com>
> > 
> > The code was accidentally mixing new and old style macros, update the
> > macros used to remove an unused function warning whilst building with
> > no PM enabled in the config.
> > 
> > Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Link: https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com/
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Lee Jones <lee@kernel.org>
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello Linus,
> > 
> > this patch was submitted on August 22 already, but -rc2 is still
> > unfixed. This makes allmodconfig builds on (at least) s390 and m68k
> > fail.
> > 
> > Lee who should normally send this fix to you seems to be swamped in
> > other work and asked: "If anyone wants to submit this directly to Linus
> > before -rc1, please, be my guest."
> > 
> > Voilà, I'm Lee's guest now :-)
> 
> Thanks Uwe.

If Linus a) communicates an issue with this or b) doesn't pick it up
for a week, I'll add it to my mfd-fixes branch and submit a formal
pull-request.

-- 
Lee Jones [李琼斯]
