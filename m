Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBD877066A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjHDQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHDQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4091994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B97616C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1A8C433C7;
        Fri,  4 Aug 2023 16:55:37 +0000 (UTC)
Date:   Fri, 4 Aug 2023 12:55:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/4] lib/vsprintf: Declare no_hash_pointers in a
 local header
Message-ID: <20230804125534.6324f731@gandalf.local.home>
In-Reply-To: <CANpmjNO5p5shpVoo1BLi9QzBc0Q0TSdfz-tUCrtgQj_ogHKx5w@mail.gmail.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
        <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
        <CANpmjNO5p5shpVoo1BLi9QzBc0Q0TSdfz-tUCrtgQj_ogHKx5w@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 10:38:22 +0200
Marco Elver <elver@google.com> wrote:

> > +++ b/lib/vsprintf.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LIB_VSPRINTF_H
> > +#define _LIB_VSPRINTF_H
> > +
> > +extern bool no_hash_pointers;
> > +
> > +#endif  
> 
> It seems odd to create such a local header and then refer to it from
> other subsystems.
> 
> What's the downside of just putting this into the new
> include/linux/sprintf.h? If someone wants to access this variable,
> they will one way or another.

 +1

-- Steve
