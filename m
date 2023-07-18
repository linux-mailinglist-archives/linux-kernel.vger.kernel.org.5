Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44261757AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGRLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGRLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:47:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A702EC;
        Tue, 18 Jul 2023 04:46:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E15E11FD9E;
        Tue, 18 Jul 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689680817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvlklvtONHr0p2dIcB/wc1pp8l9Qv079OQx/Y7nRns8=;
        b=sDQEONRmEIYGEOnQrdtcB+IrlzkNibChApO/LPwlRhGRUhgWCCbM3RfWjEzfcqDRfWoDHD
        lDPmaZrQ7AJp7qWhI4Q8Y4xx0YvQq1PrOMKgtSEsmabOgSGCUfxljMgo3pWxoriBqCmnaO
        CXYDTrsUvsqyFQ7/cc8DQH0aWDgE5aQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6959F2C142;
        Tue, 18 Jul 2023 11:46:57 +0000 (UTC)
Date:   Tue, 18 Jul 2023 13:46:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] docs: printk-formats: Treat char as always
 unsigned
Message-ID: <ZLZ7sGuf1yZoSihJ@alley>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
 <20230703145839.14248-2-andriy.shevchenko@linux.intel.com>
 <ZLFrC4Ocu7DvKuco@alley>
 <ZLFyG4MtulHnJcnw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFyG4MtulHnJcnw@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-14 19:04:43, Andy Shevchenko wrote:
> On Fri, Jul 14, 2023 at 05:34:35PM +0200, Petr Mladek wrote:
> > On Mon 2023-07-03 17:58:39, Andy Shevchenko wrote:
> 
> > PS: I am going to queue both patches for 6.6. They are not
> >     urgent to be added in the -rc phase.
> 
> Sure, works for me.

JFYI, both patches have been pushed into printk/linux.git,
branch for-6.6-vsprintf-doc.

Best Regards,
Petr
