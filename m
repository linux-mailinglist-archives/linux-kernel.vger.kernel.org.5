Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD77B7F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbjJDMrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJDMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:47:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7393
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:47:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696423645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxfpFrbNjpGxH0rUlsK0dUkA9MNGDZCaJm0WRC/xi3w=;
        b=NWIDR0cmRLi0HG5LQ9V6pc+rp2vJXhKE6e0pe6z+/SNLA+bIM/ds3euTwIuayl1TWbMFgB
        iHRqArWr17X10674jULw9WAgzmV64JdbOoAztH1/j6mnb07gJM03ZDkKAlq4Et90aopbPH
        UYDO9GC8R/eBVzSrrqb6vZh29h3IlKe6SQRLATW5KW546B8+fyIkgPG+g8yRzEEckOkfqi
        AtpRmiV4XfKcN5nhAro8TTreSkNudUeEhRocZahQxZgUBwvw2tUyMhmi1YgJuM+2+O+Y+h
        JqyvfMMCs+ZfA5k9BNuZo4+MPPxBJyPmbkRS9kSFpPeOknFG1+U+qXx7z2XZ6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696423645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxfpFrbNjpGxH0rUlsK0dUkA9MNGDZCaJm0WRC/xi3w=;
        b=s1/N6x97Lt4Bjlg7/g909saIkdp+euixcBFGxwZRS0Pw48O7m6CITlppN6h7ixp5jA7SAB
        RP9Rz2l5E9hSQ8AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH printk] printk: flush consoles before checking progress
In-Reply-To: <ZR1dBAOMmMUNgY6Q@alley>
References: <20230929113233.863824-1-john.ogness@linutronix.de>
 <ZRrAFS3cELj1DDN2@alley> <87h6n64rcs.fsf@jogness.linutronix.de>
 <ZR1dBAOMmMUNgY6Q@alley>
Date:   Wed, 04 Oct 2023 14:53:23 +0206
Message-ID: <87h6n6y2p0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-04, Petr Mladek <pmladek@suse.com> wrote:
> Are you going to prepare them or should I?

Really it was your version that we are taking. I suppose you should post
them and I can review them.

Also, the Closes tag probably should just be on the lock/unlock patch.

John
