Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B27F5B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjKWJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKWJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:32:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535ADD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:32:39 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ce5b72e743so108695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700731959; x=1701336759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg2oX9GVI0kS/noOuJCQjC9JixpUFNyRl5zhQzr8FOM=;
        b=PvNmGO2nOx0eclcNXcpegW62Y3wfg+mrhlxMLriRogxqOLEsu1/Vkqsf4jrsDi3rRv
         yLiWkykqYfaHd4nqEuR0AKf95cohOKXFQ5zBtq7sgz41Y+t/djZtiS0k3/uM6A68Eo1e
         s7lIrZ0qH0zjM/hRoXaKkx248uVQoEg7thhhagCyHOLsAbeBcN5rNLRKsZj+/yTdMBUQ
         CeiEL977NYMPdvPnbtMmi6Euf4x8rVEZ11a71TMbpCbUEf6PPK7eLn6UjC4BsheYBlSi
         me/mWO6nPJb1Cn6iGaoVh2xY1cSZ/0Zt/KK8VW01Es7Cwg+lfKs10qf9O7Irv7DK5qQ7
         JR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700731959; x=1701336759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg2oX9GVI0kS/noOuJCQjC9JixpUFNyRl5zhQzr8FOM=;
        b=TZSpTpU+FayxRqYr2e4l74WEqMuRFjFI8nL5P4cslCtMrYNMxXpwz/ZUTa7I5m/OSX
         I1MM7kPiSh4dhUDwaoLG8VOj7Ys3WWhBFqfcwGyJhBKJGedxq7sfsSF2bI+ezQfbFIAt
         vhlC2FCybkRAVXgDQVaR4wuLgNeiF4YXM3vnmU/2f3neXsIe71V0eUk2wTtUeAdl2G7h
         kPAk6N1X+nSk6I67UwFs2jUuTyDSeHBMiOFwAx/C0ZTRJIeJqBpZThkZWVu9X5lelOtB
         lH3H46TBg+oDnkwpFSKN7LlDsPW60buDRw8Zop6xwcMDR00ZXVEy/+yCZ0Z2tVFUI21j
         MmEw==
X-Gm-Message-State: AOJu0Yy22a+nx0mBZ2OglOyaCoSunmsqIus/4vtUXMqKx3wjnXzkLxt8
        QbX7SgBGdrJXxTC2XnOaKPZlyFlZ797WfZASqhRaKg==
X-Google-Smtp-Source: AGHT+IEVA1wv/X7Ck9L/Fo/SledU+PyhSbpPMagAeGLNdxr8mHH0XrGC/g/LdyNjQ3tDc1P1sJ4xT9sTfj1k8QokvuM=
X-Received: by 2002:a17:902:b782:b0:1cf:89e2:4960 with SMTP id
 e2-20020a170902b78200b001cf89e24960mr141262pls.6.1700731958610; Thu, 23 Nov
 2023 01:32:38 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLyCRyK4qpS2X8ssA6yxCDtEWR3dSsee2Lm6VCQUyD07VQ@mail.gmail.com>
 <2023112332-award-fanciness-2bcf@gregkh>
In-Reply-To: <2023112332-award-fanciness-2bcf@gregkh>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 23 Nov 2023 10:32:26 +0100
Message-ID: <CANp29Y6ge-AhM+Byt3imGOpctRsgWiqBN-reuKvOJAzxBsTYLw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] general protection fault in joydev_connect
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     xingwei lee <xrivendell7@gmail.com>,
        "syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com" 
        <syzbot+786b124fe4ce4dc99357@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 9:55=E2=80=AFAM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 22, 2023 at 07:55:50PM +0800, xingwei lee wrote:
> > Hi. I have reproduced this bug with repro.txt and repro.c below:
> >
> > repro.txt
> > r0 =3D openat$uinput(0xffffffffffffff9c, &(0x7f0000000500), 0x802, 0x0)
> > ioctl$UI_DEV_SETUP(r0, 0x405c5503, &(0x7f0000000080)=3D{{0x0, 0xffff,
> > 0x3}, 'syz0\x00'})
> > ioctl$UI_DEV_CREATE(r0, 0x5501) (fail_nth: 51)
>
> You are using fault injection, which, by it's very name, causes faults :)

But those injected failures (that do not break the kernel, but just
emulate an error returned from a function that should be expected to
sometimes return an error) still should not lead to general protection
fault panics, shouldn't they?

--=20
Aleksandr

>
> Can you reproduce it without causing faults in the kernel?  And if so,
> can you create a patch to fix this?
>
> thanks,
>
> greg k-h
>
