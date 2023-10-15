Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BC87C97BF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjJOC6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJOC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:58:42 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412ED9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:58:40 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ac9573274so3452427276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697338719; x=1697943519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CpZg+05OMwJ+gQ99ZXpacpKbXKDEgLrLJyWaBuOM4Y=;
        b=HVL8Z31g8VBkGYnTdHLb5K6qmEqP88bAzA4yb7n0rBN5X2zeZ2R1kAF1Jm4zU9dp8i
         VZMaariFiP5rHWC7S9JzvD6EjlmHJcOqNAaDvPlsLXukObQOzmUGK14v5/M+Jz6j9uTJ
         wMGbMcUHvfKpWZQksw8DHa7+tg0/0YycOPPe/Sr7OKgD2yD/DBARppAXYkanEKaMaYRC
         IttHCZwcly35kXAa8SllhtF2oj8r/vUg263WUCdWbEoiP4ZSvU400z4IaF6RjB0o/O1h
         U0Um9GSVw507FSHZTRA0mbMVvVTJVfZ433f+N4b41XL0hFe640jXyEWFvSHpl7JClwa0
         8XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697338719; x=1697943519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CpZg+05OMwJ+gQ99ZXpacpKbXKDEgLrLJyWaBuOM4Y=;
        b=sxicUEYXSifdD0KLFnmbTTOdhP1UI+pqN24u8cStavtRnLS+VTKwDDkieWJAkuxFiB
         A4+pAtgkVa+HYXpHr67pjPEuwzTsYSZ1WOIPUaowiIowhGSTMb5g5zQlivF1/YVfY+/c
         11NiJr3jjFviJSt624jiw5YjXxohny6boQceT4s+TiV2U39Xf7Pb/xHeE7k7vSddQwqu
         cjlJVtNVDWCQiCJzaBFmNwNtP1hT34UxUO+mdSBqXZx6Dl4DO/PNgzz8DTEGklxuMZJz
         AflOBhJsx/qq8NHALxWqv8Qre4rfA95+HJ1o6RPpv97aJbpA2H0e7uWnE7Zrsp+7sfuf
         hXMw==
X-Gm-Message-State: AOJu0YxQMIhLVftj9fUYYsG3Vm8FSFzzRYlHC4l2KBFv5GJC33eFJ/Jf
        22FhsJN9Ypo3I4pbity/FlT+X/uF7ndP0Q==
X-Google-Smtp-Source: AGHT+IGXBoP8cpTY/3Xf5Q1I4i/Bn7pKBvxQKa9UjDpLujsokJZqzVKNCdRKJzh8r/xwawN9nnjgDQ==
X-Received: by 2002:a25:1102:0:b0:d62:a199:fb18 with SMTP id 2-20020a251102000000b00d62a199fb18mr27098872ybr.60.1697338718823;
        Sat, 14 Oct 2023 19:58:38 -0700 (PDT)
Received: from localhost ([2607:fb90:3e2c:8023:e145:ae9d:cf98:1574])
        by smtp.gmail.com with ESMTPSA id b84-20020a253457000000b00d9a4aad7f40sm1626789yba.24.2023.10.14.19.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:58:38 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:58:36 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v5 0/8] bitmap: cleanup bitmap_*_region() implementation
Message-ID: <ZStVXLWoWwDinETO@yury-ThinkPad>
References: <20230925023817.782509-1-yury.norov@gmail.com>
 <ZSA5UlF8e7DRxuqp@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSA5UlF8e7DRxuqp@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, if no objections, moving this to bitmap-for-next.

On Fri, Oct 06, 2023 at 09:44:04AM -0700, Yury Norov wrote:
> Ping?
> 
> On Sun, Sep 24, 2023 at 07:38:09PM -0700, Yury Norov wrote:
> > bitmap_{allocate,find_free,release}_region() functions are implemented
> > on top of _reg_op() machinery. It duplicates existing generic functionality
> > with no benefits. In fact, generic alternatives may work even better
> > because they optimized for small_const_nbits() case and overall very well
> > optimized for performance and code generation.
> > 
> > This series drops _reg_op() entirely.
> > 
> > v2: https://lore.kernel.org/lkml/20230811005732.107718-2-yury.norov@gmail.com/T/
> > v3: https://lore.kernel.org/lkml/20230815233628.45016-2-yury.norov@gmail.com/T/
> > v4: https://lore.kernel.org/lkml/20230829023911.64335-1-yury.norov@gmail.com/T/
> > v5: - fix bitmap_release_region() implementation;
> >     - address nits for commits comments.
> > 
> > Yury Norov (8):
> >   bitmap: align __reg_op() wrappers with modern coding style
> >   bitmap: add test for bitmap_*_region() functions
> >   bitmap: fix opencoded bitmap_allocate_region()
> >   bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
> >   bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
> >   bitmap: replace _reg_op(REG_OP_ISFREE) with find_next_bit()
> >   bitmap: drop _reg_op() function
> >   bitmap: move bitmap_*_region() functions to bitmap.h
> > 
> >  include/linux/bitmap.h |  63 ++++++++++++++++++-
> >  lib/bitmap.c           | 140 -----------------------------------------
> >  lib/test_bitmap.c      |  24 +++++++
> >  3 files changed, 84 insertions(+), 143 deletions(-)
> > 
> > -- 
> > 2.39.2
