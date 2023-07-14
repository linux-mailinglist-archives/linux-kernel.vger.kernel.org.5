Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D039753EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjGNPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjGNPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:34:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F32D65;
        Fri, 14 Jul 2023 08:34:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A0CE1F747;
        Fri, 14 Jul 2023 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689348876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qpt38PHCvH1PYxKF1S/2ifvJ7rlxqY6oGXpjj/yrRQ=;
        b=Bxmyo29G3CeHdMsihgqFGEgalsaDWpJeUs8J8+vO2TnZQSRl+3R5J9eRW5VjDU6J89RDNH
        JdZq4NtTOHiztH4srpclRKheQM8JGLuwvw5DVmiiILXHUyLWcgoI5cBpmRd2JBDgezDzqs
        /c2Hr3pS0ZnHiMZBcbOrqjUHdGDQK1c=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D1E5B2C142;
        Fri, 14 Jul 2023 15:34:35 +0000 (UTC)
Date:   Fri, 14 Jul 2023 17:34:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] docs: printk-formats: Treat char as always
 unsigned
Message-ID: <ZLFrC4Ocu7DvKuco@alley>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
 <20230703145839.14248-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145839.14248-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-03 17:58:39, Andy Shevchenko wrote:
> The Linux kernel switched to have char be equivalent to usigned char.
> Reflect this in the printk specifiers.
> 
> Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to queue both patches for 6.6. They are not
    urgent to be added in the -rc phase.
