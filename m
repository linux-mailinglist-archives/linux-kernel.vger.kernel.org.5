Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22A78F0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjHaPxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHaPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:53:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0558E1A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:53:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so111995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693497221; x=1694102021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK7M1ac0azHbIKsERuqG1whTBc/rkSw7isk98dGDoSQ=;
        b=fjeX2UxHk2v4SNtxVXf6xcFvtqrXJCiJst6ZNDFgzp6ebs6hhLUsO7zL0wJI2fImUJ
         T21K50l+qlqRfLH6BAGAWzsHyg0vwh4U3ykHF/vtxVfDH3f2v+SDyvO+WjCuE24aL7KT
         Ju9g7bxdrd35ZE51zxJN+t9SeD7QE4qNmx8IIuzdBRBdQJRVkx8rKPay1eO9VNu2Ms5v
         Hhe0vh7rcUvvQbG/vHYzbZLvOABlgqKLBiYhh/lV9ZwQv8Jdpuv5mIgYa6xJ5VOQ066w
         rF+zPMWlkrnTcH/YZvHzr2r9uALmIRHGJasTNneF9aGo8n77njoivjW1CjOHZLc9JMxF
         30gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693497221; x=1694102021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK7M1ac0azHbIKsERuqG1whTBc/rkSw7isk98dGDoSQ=;
        b=EsSoiM3JIPfow/KTbrHY0mkjEuz6LfUAINgVxKtJYtB/JlgvkDa0YI+oUzZiMbGEXm
         eEFnx1ZLpnTgwUpMveP/L4iESmNB8PcM6k3Up5CFg40uwzNCeJHVqx/S0BuUt9GYoDeG
         umVcYYHsOuSJ7BZTVdBfH8xBC0esTWS39bZq9XVACaHxSHqxz8MQ3aF/kS9LOwc1H2/G
         Uj1/BvXZrGOd/UvTOVRzmZ9eQuU8qa+SJ9NTwzMV0IzAg3T6FOALUVYn0tV8VtPlWU8l
         rD+4RVZXfoCYeQ9BV5HmoF4/yNnuXtITzG9xeCh0ZYqv8vS3/UUX8K/GZfZjl3Vm9DHR
         w00A==
X-Gm-Message-State: AOJu0YwXq/0UExjCFL/a+6TmXVLkC/YyQz9WZlnXDadTw5ZwP56RnjTl
        /DTgev/2GKzqSlCYW2d8TMnKNy+cDxDkD6sx7XF1tA==
X-Google-Smtp-Source: AGHT+IGQjEqDdRkxQS6STwtxbPTDYA2QIlcgakej4/AELxLs2x7dLjdAKAc0ZmAwxu8MBAP5bn67O6+G7SpsUFS/nWs=
X-Received: by 2002:a05:600c:364f:b0:3fe:f32f:c57f with SMTP id
 y15-20020a05600c364f00b003fef32fc57fmr173594wmq.0.1693497221383; Thu, 31 Aug
 2023 08:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZPCfeaBrzF433cWE@smile.fi.intel.com> <000000000000c5ab74060438a6f8@google.com>
 <CANp29Y5GFuGe9=kBp-xmTb8tesLY4oAjewZ5c_31jmf8+AocBQ@mail.gmail.com> <ZPC0GTe3yc9Kl8uh@smile.fi.intel.com>
In-Reply-To: <ZPC0GTe3yc9Kl8uh@smile.fi.intel.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 31 Aug 2023 17:53:29 +0200
Message-ID: <CANp29Y62czRE-U=a0=ak0AkUv7vKZSECY9pnm74jEAuHRL1sxA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] general protection fault in netdev_register_kobject
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     syzbot <syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 5:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 31, 2023 at 04:15:23PM +0200, Aleksandr Nogikh wrote:
> > #syz dup: general protection fault in nfc_register_device
>
> Thanks!
>
> Maybe you can improve it to
> 1) drop those prefixes by itself;

Yeah, I've just thought about it too when I was correcting the command.

> 2) explain better in the quick help below what "exact" means.
>
> Also is it possible to test just patches without repository?
> Can you add this feature when you simply submit a message ID
> to it and it uses lore.kernel.org for the patch or series?

Thanks, these are good suggestions!
The first one is easy to do (we actually already support that
internally, so only a small change is needed), the second one is a bit
trickier, but I'll look into that.

>
> > On Thu, Aug 31, 2023 at 4:13=E2=80=AFPM syzbot <
> > syzbot+d2c31705e468a347e6db@syzkaller.appspotmail.com> wrote:
> > > > On Thu, Aug 31, 2023 at 12:05:53AM -0700, syzbot wrote:
>
> > > > #syz dup: [syzbot] [kernel?] general protection fault in
> > > nfc_register_device
> > >
> > > can't find the dup bug
> > >
> > > >
> > > >> If you want to undo deduplication, reply with:
> > > >> #syz undup
> > > >
> > > > --
> > > > With Best Regards,
> > > > Andy Shevchenko
> > > >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
