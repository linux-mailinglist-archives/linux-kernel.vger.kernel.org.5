Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A763C75796D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjGRKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGRKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:44:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B11BB0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:44:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0ABCE2187A;
        Tue, 18 Jul 2023 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689677075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XC5py8Zlku7xhCnY6D+T1PyW+KIeh9DbXR4W+ur5DSo=;
        b=AH6zNZepyaUpzypRYvKmoC9SGHF/JO6Z/DSclAUEVLlZdHfEPtsrL8FTSAMLL11yekB9wc
        NCCvcgRdqZXemUwiNCSD7Puta0aU5KriFSG4StENSLU4P20llieE2fHaoIS78Hzb+ZM8OP
        9loUcNaErCWWWe5Ne6qp0p6SVFaIOuw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5ECE82C142;
        Tue, 18 Jul 2023 10:44:34 +0000 (UTC)
Date:   Tue, 18 Jul 2023 12:44:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 0/7] various cleanups
Message-ID: <ZLZtEfW1tZOTH53O@alley>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-17 21:52:00, John Ogness wrote:
> Hi,
> 
> This is v3 of a series providing some cleanup in preparation
> for the threaded/atomic console work. v2 is here [0]. This
> series provides useful cleanups independent of the
> threaded/atomic work.
> 
> Changes since v2:
> 
> - "NMI safety" patch split into 3 patches: console_unblank,
>   keep non-panic CPUs out, do not lock console on panic flush.
> 
> - console_unblank() aborts if there are no consoles implementing
>   an unblank() callback. This check is performed before taking
>   the console lock.
> 
> - Commit messages and comments updated to mention the details
>   discussed in the v2 feedback.

The patchset looks ready for linux-next. I am going to push it
into printk/linux.git, branch rework/misc-cleanups.

I'll wait a day or two. I think that there is only very small
chance that anyone else would do a review.

Best Regards,
Petr
