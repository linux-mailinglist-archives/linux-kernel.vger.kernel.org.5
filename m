Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD167D887F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJZSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:42:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C710A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:42:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso17198901fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698345774; x=1698950574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMgObftLxZ0/iptHapd2/YKZ8W4OQcuVi9EXheReHJU=;
        b=JBBrSCxBinB22yJIYzpipzlnM13q9IdMJHyZufqCIPZSOYRLu2vK38b8EnaUqRRB2x
         6U57h4ejTrfGe7CuSaR2mPkOwKuQ2uo2Qkn6raELLelysrAWrQsPAtdNfJV0hTwEu0Un
         PP64OLX1Zqz6NX+fFIRAW2cf0fRM0M0DKT/BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698345774; x=1698950574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMgObftLxZ0/iptHapd2/YKZ8W4OQcuVi9EXheReHJU=;
        b=hskCzgMX6FfkwZ82TqU80vk7/h+2vZiqCTmt0imr8dn+5z5QwTTp+aXWMCIlat6HaB
         pNhcsCaaQW0UgElLXjEs4MniGQkJruOLOI1QvlWT0bSeEwzcCiQhZfBEy4jodVtURp/8
         fMWVz4yr4ec3cZZ4Fk4LsOh2L5Q+aqw/IdjMo2zPLFCfSZopUmueOrdcPeadqR5xDVvW
         4E5sTFUyAclIHef6vAcDa2CuKePwbIZSxBF6HejwMbtDMmgZntlu0isWdHONHlvDVLH9
         pasqSQTYJrIwudeE/izwbvDHeupDwmrrcbc2ULkJEAQ7tKSw06ZKn3QEo6vp4ebSJiQ/
         jITg==
X-Gm-Message-State: AOJu0YyIZoJsVOm9WU5QpbJwBZka8vK82muiKsfHi9s0Ej/XFaJbt7F+
        5arkxT39eG87QLTz71Fzw+4MnAbEEq16Xkq6/wH3iw==
X-Google-Smtp-Source: AGHT+IGAEqwLotSkbL1bzkSCyweY1u8Il9iX22IFnA7Jv8IdQx9RrXaA6dScjrZbO7OIrkAbrYs9sg==
X-Received: by 2002:a05:6512:39c8:b0:507:ae8b:a573 with SMTP id k8-20020a05651239c800b00507ae8ba573mr208574lfu.51.1698345774422;
        Thu, 26 Oct 2023 11:42:54 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c24-20020a056512075800b005079ff16d9fsm3090439lfs.138.2023.10.26.11.42.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 11:42:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso17198551fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:42:53 -0700 (PDT)
X-Received: by 2002:a05:6512:1289:b0:507:aa44:28fc with SMTP id
 u9-20020a056512128900b00507aa4428fcmr150667lfs.53.1698345772939; Thu, 26 Oct
 2023 11:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231020102901.3354273-1-mszeredi@redhat.com> <20231020102901.3354273-2-mszeredi@redhat.com>
 <3ab474953c734d0bbf0177bf5d208799@AcuMS.aculab.com> <CAOssrKd2tO9a18qEUPnxnoWzD0WSvT2G7_kcJr=uunCd1xKXYA@mail.gmail.com>
In-Reply-To: <CAOssrKd2tO9a18qEUPnxnoWzD0WSvT2G7_kcJr=uunCd1xKXYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Oct 2023 08:42:35 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com>
Message-ID: <CAHk-=wgy8p4is8ApEQCT5NS7XFb+NXeo-TKz7jRRZVksLLBSrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] add list_for_each_entry_del()
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 23:52, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Something like this?
>
> - list_for_each_entry_del(entry, head, member))
> + while (list_del_first(entry, head, member))
>
> This allows the compact loop condition, and I always hated having to
> pass the type to list_*entry()...  Disadvantage being that the
> assignment is now implicit (just as with all the list iterators).

So I have two issues with this.

One is purely syntactical: I would be personally happier if any new
list iterators kept the declaration of the iterator internally to
itself.

IOW, instead of

        struct request *rq;

        list_for_each_entry_del(rq, list, queuelist) {
                ...

we'd move on to modern C which allows declaring variables in for loops
(so they aren't visible outside the loop), and turn it into

        list_for_each_entry_del(struct request, rq, list, queuelist) {
                ...

which would then behind the scenes turn into

        for (struct request *rq; rq = list_del_first(list, queuelist); ) {
                ...

or something. None of these "we have stale 'rq' variables outside the
list" things.

(Of course, I realize that people then sometimes intentionally use
those stale variables outside the list by breaking out of the loop in
the middle, but it's ugly)

That said, the *second* issue I have with this whole
list_for_each_entry_del() is that it seems a bit mis-designed. You
have two cases:

 - you want to unconditionally delete everything

 - you might want to have a condition on it and break out early

and the first one is often better dealt with by first moving the list
to a private list head (presumably using list_splice_init()), and then
iterating the private list head instead. That can avoid having to hold
a lock over the whole loop (or dropping it and re-taking it), for
example.

And that *second* case would presumably want to use
list_for_each_entry_safe(), and then do the "list_del()" at the _end_
of the loop, not at the beginning?

Hmm?

I guess the "delete the whole list" is the simple case you want to
deal with, and people who can use a private list to avoid locking
already do the list_splice_init() thing separately (or create the
private list as a separate phase, to also deal with the "I'm not going
to delete everything" issue).

                 Linus
