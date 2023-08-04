Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07975770666
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjHDQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHDQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB99749EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1D6620AA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 16:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81431C433C8;
        Fri,  4 Aug 2023 16:54:52 +0000 (UTC)
Date:   Fri, 4 Aug 2023 12:54:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/4] lib/vsprintf: Declare no_hash_pointers in a
 local header
Message-ID: <20230804125450.384788b2@gandalf.local.home>
In-Reply-To: <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
References: <20230804082619.61833-1-andriy.shevchenko@linux.intel.com>
        <20230804082619.61833-2-andriy.shevchenko@linux.intel.com>
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

On Fri,  4 Aug 2023 11:26:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 197430a5be4a..fb28c6abd58e 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -19,6 +19,7 @@
>  
>  #include <asm/kfence.h>
>  
> +#include "../../lib/vsprintf.h"
>  #include "kfence.h"
>  

Ug, I hate "../../" includes. Can we have this in one of the main header
files?

-- Steve
