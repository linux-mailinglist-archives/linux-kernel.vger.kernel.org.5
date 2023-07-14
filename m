Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB93753EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjGNPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjGNPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:32:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23512D68;
        Fri, 14 Jul 2023 08:32:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F7C6220C0;
        Fri, 14 Jul 2023 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689348750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmSFBb5OFJ5K5sBgwsiT/oJXYv5qez6bBN26pQ9yw28=;
        b=WMd3gNb0Qxh8IsH6S/CZhv0jNE54FqJzsHwdY6Z/Q0QMzgGgxsoHpM4OJ4RQIpQK6rJtAt
        +EfjHGB1yOlR45kicYtjJOEhjC1hsT5MDoXXrrigMtWJnsWPIe1+nv/4ASuaSoJuZKSDrJ
        YoRRy7Wmw98uLZftcbAt+W02s+5AevQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2861B2C142;
        Fri, 14 Jul 2023 15:32:30 +0000 (UTC)
Date:   Fri, 14 Jul 2023 17:32:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 1/2] docs: printk-formats: Fix hex printing of signed
 values
Message-ID: <ZLFqivvdbzFnAAgY@alley>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-03 17:58:38, Andy Shevchenko wrote:
> The commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]") obviously missed the point of sign
> promotion for the signed values lesser than int. In such case %x prints
> not the same as %h[h]x. Restore back those specifiers for the signed hex
> cases.
> 
> Fixes: cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Makes sense. %d would print the same (small) negative number even when
casted do int. But %x would always add more "ff"s up to 4 bytes.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
