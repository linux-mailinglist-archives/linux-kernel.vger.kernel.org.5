Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1E7727D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjHGObn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjHGObl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:31:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4BAA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:31:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 04FCF21AD5;
        Mon,  7 Aug 2023 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691418699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fOeICDyT7K2QTKRJ6MV/fDafXjEn/AufQ8OCjlhJmc=;
        b=puqzPyxhDS8ihrRf7XaMDxl1YL8jIPCi/Ga1d289a63yhac0KgN5cQaEGTMDjJJXoTqFlz
        upyj4HIHL5ISq9mQ8GCQDEshQyCEwPXxCKW2USu/qL8RndfTxybR14Ob4/BR0WJ+9gPiA1
        OE2/xx3GVn9eTxXE6xVB4hj3bcPNYPA=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E5292C142;
        Mon,  7 Aug 2023 14:31:38 +0000 (UTC)
Date:   Mon, 7 Aug 2023 16:31:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Message-ID: <ZNEASXq6SNS5oIu1@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-08-05 20:50:25, Andy Shevchenko wrote:
> Sorting headers alphabetically helps locating duplicates, and
> make it easier to figure out where to insert new headers.

I agree that includes become a mess after some time. But I am
not persuaded that sorting them alphabetically in random source
files help anything.

Is this part of some grand plan for the entire kernel, please?
Is this outcome from some particular discussion?
Will this become a well know rule checked by checkpatch.pl?

I am personally not going to reject patches because of wrongly
sorted headers unless there is some real plan behind it.

I agree that it might look better. An inverse Christmas' tree
also looks better. But it does not mean that it makes the life
easier. The important things are still hidden in the details
(every single line).

From my POV, this patch would just create a mess in the git
history and complicate backporting.

I am sorry but I will not accept this patch unless there
is a wide consensus that this makes sense.

Best Regards,
Petr
