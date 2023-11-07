Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E607E4BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjKGW0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjKGW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:26:22 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C6811D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:26:19 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so6150599276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 14:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699395979; x=1700000779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P47oP5oJdX239v0Nrd4No23LS5nQiYUst7cUzSyZkWM=;
        b=YL7+k/sIH+TQ1u1F84N+7nvG/zYa/plGWcMjb4m2jVm/ZRLdZ5/TlhuWYXwati4mgI
         AyTBr+0mdjaY3dVKojfGpLG39z7z301O54rF6BDInTQgH6DwZOjdrCxiTWIoMHZMSMuO
         lLSYsLrvbI/neU35gFo9blbAfzHpw0ocd5ED84czDzpwPxUTAP8hiEXB75TV3iwOcHs+
         zT/4XdWAfdjdLlINKvZEuCfGPWpPzDPdXpRcTX8Z73UJHY4Whk7zKTixeaaAb7Mpkany
         kulYV/FK1UtJRhbazrJi7OlT7Efkn/hdoFyea1+CSTsnTaoRTqPwaRdiMDuPpfGiN+El
         drmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699395979; x=1700000779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P47oP5oJdX239v0Nrd4No23LS5nQiYUst7cUzSyZkWM=;
        b=Wvn+L0iurgYRaNZzj6i+xvltp8V088vlZfnjwkUYe/5FO8SsUba3XHFjSqr/Ohicx/
         JKa2e59pIqAPrmnclg3B26AhO41YAD7cK7YBtcLLS1ozK0AYewwv5VRGX15A8UA6fKtE
         QLSC0BMyY/dkuTza3CZ2yYxvLUY8O+jPdkdXKf74YAUi11HAd/hsRMAK9Cs9V9nqe1u1
         JrRPSMxnpFjfru6vWY2ZwYBeq59Q9sPBUClwYHFBbxbpSLdG/C7h81e6tyCLB8cBRC90
         uHe1GIjvqGUQd2V8YX3kXri8MDbKXKRPIhZw5szZ6y7+HGy5I76UwMNLuaMzNV3jrIQ+
         c+Bg==
X-Gm-Message-State: AOJu0YxKY/c/78emXEQIfNX4yjUr5SJhhvpA46H9FDG1KW3qsQmdU3tU
        oQ+uFhJ4NltZ66FxN0+O31RPLElVmGZdLekHBM9G
X-Google-Smtp-Source: AGHT+IH/Fn/yDcwnDW/rO1rffsYvX8N5x+vHXxSrkV6C5ZNLoauwhJGiHSIGh3pqDi5+MdSqb19v/SnYw4S/KNvQjRU=
X-Received: by 2002:a25:730a:0:b0:d9c:2a9c:3f4f with SMTP id
 o10-20020a25730a000000b00d9c2a9c3f4fmr116243ybc.62.1699395978963; Tue, 07 Nov
 2023 14:26:18 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cfe6f305ee84ff1f@google.com> <000000000000a8d8e7060977b741@google.com>
 <CAHC9VhTFs=AHtsdzas-XXq2-Ub4V9Tbkcp4_HBspmGaARzWanw@mail.gmail.com> <b560ed9477d9d03f0bf13af2ffddfeebbbf7712b.camel@huaweicloud.com>
In-Reply-To: <b560ed9477d9d03f0bf13af2ffddfeebbbf7712b.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Nov 2023 17:26:08 -0500
Message-ID: <CAHC9VhSH-WED1kM4UQrttJb6-ZQHpB0VceW0YGX1rz8NsZrVHA@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>,
        jack@suse.cz, jeffm@suse.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:03=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2023-11-06 at 17:53 -0500, Paul Moore wrote:
> > Hi Roberto,
> >
> > I know you were looking at this over the summer[1], did you ever find
> > a resolution to this?  If not, what do you think of just dropping
> > security xattr support on reiserfs?  Normally that wouldn't be
> > something we could consider, but given the likelihood that this hadn't
> > been working in *years* (if ever), and reiserfs is deprecated, I think
> > this is a viable option if there isn't an obvious fix.
> >
> > [1] https://lore.kernel.org/linux-security-module/CAHC9VhTM0a7jnhxpCyon=
epcfWbnG-OJbbLpjQi68gL2GVnKSRg@mail.gmail.com/
>
> Hi Paul
>
> at the time, I did some investigation and came with a patch that
> (likely) solves some of the problems:
>
> https://lore.kernel.org/linux-fsdevel/4aa799a0b87d4e2ecf3fa74079402074dc4=
2b3c5.camel@huaweicloud.com/#t

Ah, thanks for the link, it looks like that was swallowed by my inbox.
In general if you feel it is worth adding my email to a patch, you
should probably also CC the LSM list.  If nothing else there is a
patchwork watching the LSM list that I use to make sure I don't
miss/forget about patches.

> I did a more advanced patch (to be validated), trying to fix the root
> cause:
>
> https://lore.kernel.org/linux-fsdevel/ffde7908-be73-cc56-2646-72f4f94cb51=
b@huaweicloud.com/
>
> However, Jeff Mahoney (that did a lot of work in this area) suggested
> that maybe we should not try invasive changes, as anyway reiserfs will
> be removed from the kernel in 2025.

I tend to agree with Jeff, which is one of the reasons I was
suggesting simply removing LSM xattr support from reiserfs, although
depending on what that involves it might be a big enough change that
we are better off simply leaving it broken.  I think we need to see
what that patch would look like first.

> It wouldn't be a problem to move the first patch forward.

I worry that the first patch you mentioned above doesn't really solve
anything, it only makes it the responsibility of the user to choose
either A) a broken system where LSM xattrs don't work or B) a system
that will likely deadlock/panic.  I think I would rather revert the
original commit and just leave the LSM xattrs broken than ask a user
to make that choice.

--=20
paul-moore.com
