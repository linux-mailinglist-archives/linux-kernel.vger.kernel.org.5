Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD07A7F775D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbjKXPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKXPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:12:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444DC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:12:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so2868a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700838751; x=1701443551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quAfw52oJT3Iu4f4DiSuO7KlI7QjDDj//SV/3y1fuKM=;
        b=jjWdRf+JaAQYJf+lfA+Nh/8IGDDbOvHOe1vRhvRkOyQq16CWk+BPwgPpe5l0zRVjog
         ltzhqba8Ug3LHf0ZXvez8RqUkAZefC8knq2JoX6uGjIT0VY/krpd5wDnmv2tQ1FNEj6I
         4/lgryle1puSCMEEt5yu/i6UIXbld9GSdx1Pna+U2lBJM13NzHZ7Mr8ZAgU4p0rTwU3x
         WL2AIkhxZf5nVmJZy6byLZuFxSIkBdyTIcWgv90kG7p1yNrCKRA10ktZoVRQ8/1pNUul
         XSynh1mtlBuK4i4IdZFxYqOTd8k8qtyt52ifsxPbAGU1cHMXGY7SPkTb5CScsJPmHYv/
         IF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838751; x=1701443551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quAfw52oJT3Iu4f4DiSuO7KlI7QjDDj//SV/3y1fuKM=;
        b=PWF0o+CWIAThg61kw0etiR6GA5ax/JG1gdKsCmBkeRBtUewK+YtwiqYqGfeioMC6KX
         k93pjD9664xqn/eVQp0vZRPJrCKIPF4HjUavgc8KIV98t9kH2ert8LPT57MdZB2w1cGl
         GeIHzkDzqPmxzQ0XMQZur29alS3rM1CztO1PfrBz+zBMV+rN/cT2V8BmnWPoFJXvqgKv
         Ts92BZ+8A3LY4qX3QMNjdzw1houYDLnfV1sAmHujbFrbjqsmjH+EjOw3VYjE4puKSrsA
         apIPh4WnNhaQQCkZUFfx5kBb9pVRa5PIZtE3CvMdQGfJ4WndSVAeef3yqSmNiEKvPfFX
         f3Xw==
X-Gm-Message-State: AOJu0Ywbl2vFpzvECqdabtRwc7M/o27sx5c3FUnfOAVuyaqSyFVGHEhk
        o+D+UyZJAonaSLh55bU6fkifzye3csbju/t4ntyNVQ==
X-Google-Smtp-Source: AGHT+IGr8o2vaGk4g6YM40MXMmczEWY89+5Ocxwtmih7cxA00JkoD3KjvhIVDs7wYG8aG9O+PyZcv4bA2VWF5pkkUBw=
X-Received: by 2002:a05:6402:11c6:b0:54a:ee8b:7a99 with SMTP id
 j6-20020a05640211c600b0054aee8b7a99mr112274edw.0.1700838751574; Fri, 24 Nov
 2023 07:12:31 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
 <000000000000258ac60606589787@google.com>
In-Reply-To: <000000000000258ac60606589787@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Nov 2023 16:11:54 +0100
Message-ID: <CAG48ez2UkCR7LMaQfCQVLW4VOZG9CuPDMHG7cBtaAitM=zPBCg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
To:     amir73il@gmail.com,
        syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM syzbot
<syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail=
.com
>
> Tested on:
>
> commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_wri..
> git tree:       https://github.com/amir73il/linux.git ovl_want_write
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d10ffa68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb54ecdfa197f=
132
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d8901756d1=
cbba1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40

It looks like the fix was submitted without the Reported-by tag, so
syzkaller doesn't recognize that the fix has landed... I'll tell
syzkaller now which commit the fix is supposed to be in, please
correct me if this is wrong:

#syz fix: ovl: do not encode lower fh with upper sb_writers held
