Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A478C50F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjH2NVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjH2NV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:21:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55168CD4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:21:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693315278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J9H7M9XMjhvvD7b7RGsxuBf2U1CpqFqkcJhtm7QThA=;
        b=GBIbeA3EhWI2dO+sGuTuZDgN4Gxe/oAFGuIJsZ4wj+bbJMN4s8ykkVt0xechjUQoPUDP8r
        7u6FQQ268z96rETWJdFS5KWyfQ7vDY+OzFKBPzYUjGOI/Q5BWFE3fRpfZkwG8H1bUBfgzb
        guC0NFxyMUnZCqmZ0pnCi/fIa2/Q+N02+pXvRpB0DZ0FG+ghL37Ofpz+mtGZD5mA1Nf4+k
        qLhX6+v2d4e7x/D2wpiKShQJW/lUXNT4nlEUvrIuc2qq+Ybh5nh/otTUUwFRZ7fQv2+AX1
        sjR/A9c/z0rr22iY8rzKfTnjTVNcMPWpU7OXC4ITVV/nZKG9jAbuaym0TEQDhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693315278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9J9H7M9XMjhvvD7b7RGsxuBf2U1CpqFqkcJhtm7QThA=;
        b=uCG3TsFL52CCT5XDT1IkzqC/ShozwnnCJw7DLjsjaSLRbnancTQLUVlZ6h3kwWwlml3Bzl
        EA/GnhkjT9YCN7Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 0/8] wire up nbcon consoles
In-Reply-To: <ZNY-IhuJJMZuFAHz@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <ZNY-IhuJJMZuFAHz@alley>
Date:   Tue, 29 Aug 2023 15:27:17 +0206
Message-ID: <877cpernle.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-11, Petr Mladek <pmladek@suse.com> wrote:
> Nit: Is there still any chance to rename this to kernel/printk/nbcon.c ?

Sure. Will do for v3.

> I am sorry that I did not suggested this earlier. I think that
> we should have omitted the "printk_" prefix even for
> the "ringbuffer.*" files.

For the ringbuffer I actually wanted "printk" everywhere to make it
clear that it is not a generic ringbuffer. The struct is actually named
"printk_ringbuffer".

John
