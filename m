Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0C78FC15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349100AbjIALHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjIALHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:07:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D210F0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:07:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so49355e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693566453; x=1694171253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF7QmbvYJUWyLTiiJZH0vAH9wqTPWy/RK++Y8NS9peY=;
        b=sY2Yso6INJTujb0ok9vq2vBaA7pLmnW9+8b3Oei5dSltHlsjjS6mDYjWhwsMzW7s66
         4Oyz5SmkgM585vL7fDG9aSMUmDUiK/nuXQBbYahFB2lmDMpg9n4T11baKxFLSUFFboNd
         tkliXVnB7gnCML8blEh7kr6X/HFyY1PacwjSVcoGhyEsLbHZSWr+EhHwCbyznwN2zLQd
         eErwXa0VduwZ1pskP7ksBYrMrwEk8AzCn8vNU+HnqMRAx1U5uoS/XRE4/t1b68qjYIf+
         ug9mfjDzsL8Ikfml477jSxcuEpWr4UbDwPvK8ZxvAdo9463XS0vxIZG2agl16orWj9hO
         hmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566453; x=1694171253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF7QmbvYJUWyLTiiJZH0vAH9wqTPWy/RK++Y8NS9peY=;
        b=ZzVqEtcgYq23bnGAKXz7ejAwfPRauDcVkHiMfsWGIKc7nPMp40Jc6aDxWA5MvYcjP/
         zQabuLtoP1Ve/d6F4b87r+JvzBGYQExG8Dz4BnjmqqCi+iaGxIddNIlfCc/IcMNNK7LU
         JunOqp6RRN1411Re+rQw4nP+UU5cMfrSxsi4AvO6u4dR7qI60VvPO7v0QO0a+fR0YY5p
         C0v8w2rPd/MQ+f4kZIwpVDW5jPuXIReW71Sc6RGWOTpEDanex6nNXbVPzt9Mmv8NoWrW
         1R2fRigLXXLhsZoPTXf/8ZP8o0gaoeHQH5JhOl5BdEH3LYXI3ROu9z+y/Zd8hbXuLG6Q
         XpoA==
X-Gm-Message-State: AOJu0YxgkrNqrRcayyoCi9fOWxi0OUohhoB0Z6uzaY0jLDwjzKGj948L
        ygWgk3li5IRIanVX+eZxwTYzJl0lomvZO1CX7zkhH16yXRGLN5iCG6CMkA==
X-Google-Smtp-Source: AGHT+IEko/ujs9GkS9oO5Tp3CX3QCsCTDzB1tdH/41M/YlHp6EdTK7Xx/Ixze8gzx9pu752jBCSd38w9DXkyTrS9n2U=
X-Received: by 2002:a05:600c:4886:b0:3fe:cd3a:ef92 with SMTP id
 j6-20020a05600c488600b003fecd3aef92mr123311wmp.6.1693566452937; Fri, 01 Sep
 2023 04:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZPCfeaBrzF433cWE@smile.fi.intel.com> <000000000000c5ab74060438a6f8@google.com>
 <CANp29Y5GFuGe9=kBp-xmTb8tesLY4oAjewZ5c_31jmf8+AocBQ@mail.gmail.com>
 <ZPC0GTe3yc9Kl8uh@smile.fi.intel.com> <CANp29Y62czRE-U=a0=ak0AkUv7vKZSECY9pnm74jEAuHRL1sxA@mail.gmail.com>
 <ZPDA1Z8Hwq3jdvgh@smile.fi.intel.com>
In-Reply-To: <ZPDA1Z8Hwq3jdvgh@smile.fi.intel.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 1 Sep 2023 13:07:20 +0200
Message-ID: <CANp29Y5Bq1fo8pFWGxKT9NTNW_-C6vf=A_hUKG2BJey5JRrO1g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] general protection fault in netdev_register_kobject
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 6:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 31, 2023 at 05:53:29PM +0200, Aleksandr Nogikh wrote:
> > On Thu, Aug 31, 2023 at 5:39=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Aug 31, 2023 at 04:15:23PM +0200, Aleksandr Nogikh wrote:
> > > > #syz dup: general protection fault in nfc_register_device
> > >
> > > Thanks!
> > >
> > > Maybe you can improve it to
> > > 1) drop those prefixes by itself;
> >
> > Yeah, I've just thought about it too when I was correcting the command.
> >
> > > 2) explain better in the quick help below what "exact" means.
> > >
> > > Also is it possible to test just patches without repository?
> > > Can you add this feature when you simply submit a message ID
> > > to it and it uses lore.kernel.org for the patch or series?
> >
> > Thanks, these are good suggestions!
> > The first one is easy to do (we actually already support that
> > internally, so only a small change is needed), the second one is a bit
> > trickier, but I'll look into that.

FTR I've just sent two PRs:
1) Support `#syz test` without arguments -- in that case, syzbot
checks out the latest commit on the fuzzed branch.
2) Parse all kinds of email titles in `#syz dup`.

I'll deploy them soon.

>
> JFYI:
> 20230828145824.3895288-1-andriy.shevchenko@linux.intel.com
>
> Can be used for testing.
> So I like to write
>
> #syz test patch: 20230828145824.3895288-1-andriy.shevchenko@linux.intel.c=
om

Thanks for the idea!
I've filed https://github.com/google/syzkaller/issues/4182

The biggest problem is to figure out the command syntax that'd also
let us specify the tree on which to apply the patch. Or to restrict
the patch testing to either apply the patch from lore on top of the
fuzzed tree or to accept repo/branch/patch explicitly.

>
> The responses can be (among others?):
> 1/ tested and test results;
> 2/ not found.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
