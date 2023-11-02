Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BEB7DFD27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377564AbjKBXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377540AbjKBXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:02:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F23133
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:02:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698966137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4K8GcKPMg1l7I7ydczQsb56F6VjOqgbkWkY8LNrHXww=;
        b=b4Ymsx1Lrq6r/q3oPB1S2FkFoaT7dT18V0YoIgzzYYPXzE0sFk1ZPBwx5t7JzBg27B3yFX
        +LMEp3P6W2OCS04XZhaW5ingKoONxIlkXY4LrBbtseSmJTzvab8eoQX7oUONRmN7yg6sro
        6QnOpI9WmpsJV8KFvnUW2Yg5vPpwQPwAgEHUXWkIx7tpYx2J2VMBVgzNDz92gyJbZocesc
        km+29k6OWR+ajDmsc/Y36TA37Li4hJGEsRFkpUImdn4MqQJsBuUJK0hhZtanvakRedVsAR
        5bORyMo60YbqQ+taGSm5HnvGJ5DxF36miOe+UoASrEdgKNzqMUC+MB2fjgkgWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698966137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4K8GcKPMg1l7I7ydczQsb56F6VjOqgbkWkY8LNrHXww=;
        b=G2L7O6unvJTEYFdzaCjOBVWd1ZCad9+sEDp5bxuzqwkRYRnqoFPcvKBrZpG08e/kMIeBUi
        2rTK25grHEgIRtAg==
To:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 6.7
In-Reply-To: <ZUPM1ZD6Q3mNOPaS@alley>
References: <ZUPM1ZD6Q3mNOPaS@alley>
Date:   Fri, 03 Nov 2023 00:02:16 +0100
Message-ID: <877cmzlpxj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 17:22, Petr Mladek wrote:
> Thomas Gleixner (7):
>       printk: Add non-BKL (nbcon) console basic infrastructure
>       printk: nbcon: Add acquire/release logic
>       printk: nbcon: Add buffer management
>       printk: nbcon: Add ownership state functions
>       printk: nbcon: Add sequence handling
>       printk: nbcon: Add emit function and callback function for atomic printing
>       printk: nbcon: Allow drivers to mark unsafe regions and check state

TBH, I'm truly surprised to still see my name there as the author.

I definitely authored the early revisions and was influential on the
design, but comparing the final result to my initial hacked up POC
patches does not really reflect that.

It's probably too late to correct that, but I nevertheless want to make
it clear that:

   John Ogness and Peter Mladek have been the ones who sorted out the
   details and really should be those who get the credit.

Kodos to John and Peter for making this work!

Thanks,

        Thomas
