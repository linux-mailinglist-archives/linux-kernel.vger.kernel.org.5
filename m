Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011037ACBFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjIXVJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:09:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633FFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:09:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so680192266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695589763; x=1696194563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PK9B/a+9XoUp2ByomEHDN5NzNDhYbPOPMXwcRixUaIw=;
        b=G7qYmCy1UBcWZ3k5HJeb/73NeD3CfLwnQo5QzhJiozAgGYpBUSHAKn7XirojJmGOLg
         VZQ+Rbav3kgXs0o+TF14wyBkRan8kfiWLEdHvY4mJ0RnJEycgiWZTAOi7t+M1qioQj1M
         d3S6T6t0mw/cf2zZ6hauh1T42AsDgDRKnpVQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695589763; x=1696194563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK9B/a+9XoUp2ByomEHDN5NzNDhYbPOPMXwcRixUaIw=;
        b=qJWA2Rrp49iogeGwc3W6xvJAWZIKDVleoyE7mEIWz/RMbmiXNWGym3W3FvOA3uIa3/
         EfBHWQx1NaeuwcA2fNtcoHTPbuAQKMd1v/aXLmDVv+vKk3SWtm3nKlq1o36vRDGqj+jq
         B8hkJk/5829LftQlkNsHn7DTYlzLwkihUk92WtzjPpIOmDl39fKTlHUR87iLU1bN6e6i
         kLNyqXW0ICUWKEFv7ACc5h37ggJiEGCI+f8QmBB2fGTy/qhAKSyf/i0EU1QXPWEAp0sh
         5ylYADtzFmCWr1WDKK4pBj9RTjDZxvyi5pU8HGvGlg/1QT1BHWlDXzmhxQMC23FlFUhd
         9n/w==
X-Gm-Message-State: AOJu0YwO4dbBMYX06uZirRRDbH6mR9HMx/6b06O6+GQKzrFtftbLrauj
        MNgMNICjoJnTCGCqtPEkr6K4hVxKSIJYIkeeqlU1mw==
X-Google-Smtp-Source: AGHT+IEX6BYWdYNBLF1m7RXXPUFYN2Fn8lqsDz5XZXai2aKTXIQUqtiknAZNo2YpMoUucUscertRmQ==
X-Received: by 2002:a17:906:8445:b0:9ae:73ca:bbae with SMTP id e5-20020a170906844500b009ae73cabbaemr4157027ejy.62.1695589763125;
        Sun, 24 Sep 2023 14:09:23 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id gu20-20020a170906f29400b009ad8796a6aesm5393095ejb.56.2023.09.24.14.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 14:09:22 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-530ce262ab2so5727655a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:09:21 -0700 (PDT)
X-Received: by 2002:a05:6402:c18:b0:533:c55f:582a with SMTP id
 co24-20020a0564020c1800b00533c55f582amr3715428edb.27.1695589761441; Sun, 24
 Sep 2023 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230923191420.10c42e4f@rorschach.local.home>
In-Reply-To: <20230923191420.10c42e4f@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Sep 2023 14:09:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=aOhPAJn-E8T+GofoBeCtXuoEXZcw6A009MO4s3mNAA@mail.gmail.com>
Message-ID: <CAHk-=wh=aOhPAJn-E8T+GofoBeCtXuoEXZcw6A009MO4s3mNAA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for 6.6-rc2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sept 2023 at 16:14, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Fix a bug in eventfs where reading a dynamic event directory (open) and then
>   creating a dynamic event that goes into that diretory screws up the accounting.

Honestly, I'm getting more and more convinced that you just need to
stop this eventfs stuff.

This is just *incredibly* ugly:

  /*
   * This just sets the file->private_data back to the cursor and back.
   */
  static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
  {
        struct dentry_list *dlist = file->private_data;
        int ret;

        file->private_data = dlist->cursor;
        ret = dcache_readdir(file, ctx);
        dlist->cursor = file->private_data;
        file->private_data = dlist;
        return ret;
  }

I guess it works by the f_pos locking magic, but by christ is this
ugly beyond words.

Honestly, now, are the eventfs changes *really* making up for this
kind of continual "this is crazy" garbage? We had the whole "this is
undebuggable" discussion, now there's stuff like this.

Were people even *aware* of the f_pos locking, or did this just happen to work?

And that's entirely ignoring the disgusting thing that is that
"allocate an array of every dentry we looked at" issue. Which honestly
also looks disgusting.

I beg of you: think hard about just reverting all the eventfs changes
that moved away from using dentries natively, and instead started
doing these *incredibly* hacky and ugly things.

Really.

               Linus
