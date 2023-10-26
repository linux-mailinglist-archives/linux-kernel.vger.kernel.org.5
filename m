Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD837D8C13
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJZXHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjJZXHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:07:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236AE1AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:07:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4299FC433C8;
        Thu, 26 Oct 2023 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698361636;
        bh=CYaD5thrrYF+oIA4zbwvjMlcGLx2EFnQLheWT/5+biQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2n+WbG31SI/9VHGVuacH06YrqmnA6TOVx6Ivw8oZQyZtXDcvRib1aHasDg17PKJTI
         9DmOuUoWPYMEYRRkpwcgsGabNO7cGzsL732EKcDHhJx32M8Mq/dwRByUf+p/huXZng
         RD5Qb5dl5SSwAo1hrB7lBu0ssrCNwiLlT+UeSbLY=
Date:   Thu, 26 Oct 2023 16:07:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] fix for
 "lib/stackdepot: allow users to evict stack traces"
Message-Id: <20231026160715.ea74f79dea9960b8ff46d077@linux-foundation.org>
In-Reply-To: <20231026223340.333159-1-andrey.konovalov@linux.dev>
References: <20231026223340.333159-1-andrey.konovalov@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023 00:33:40 +0200 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Commit "lib/stackdepot: allow users to evict stack traces" adds another
> user for depot_fetch_stack, which holds a write lock. Thus, we need to
> update the lockdep annotation.
> 

We're at -rc7, which is rather late to be merging material such as this
patchset.  Please resend it all after -rc1 and include this fixup,
thanks.

