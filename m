Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C180B1D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjLIDLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjLIDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:11:39 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEAA6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 19:11:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cebbf51742so1712299b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 19:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702091505; x=1702696305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUZMYMUJoJGrEcJzr6eG+ynn8J0NFaizgn7jPk/SOKs=;
        b=M+4E13IrSIuv6UUAWzgBVtuW7LYz799KNvBAELL0zmqG4KenyhRCMI654OYk/THU6L
         +QaDyAWj8p+66CqZeSYZ4hjzjIcsPXBj4c8UajObvHZy9QOaMUDCCCK6rEtyrCivXSas
         QzlYJiOjr9xcslHLyT0OT39igWrxRVp0X7snEKMR8RRW+gIX/69n9b6tOkHUl5A/eh2h
         wMr+wQWQaWc/TNKZomMXpLwi2VfEsrJY2wTMFB2iHY/exikY+aWtT1jOHbnbX4YaDq7S
         KMzY4qqS/L+kCBCIBRcvyhKl73cjrnM2jIrOPKR4/SPYOfBXh1RxsxsEQu2XQz0ae0Kc
         uDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702091505; x=1702696305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUZMYMUJoJGrEcJzr6eG+ynn8J0NFaizgn7jPk/SOKs=;
        b=cLQPRAtOiduxqHh2fG66PuNl7bSOHZk7qJ6WO8+HoFhra729dpqUYn8zi7YWW39oul
         vZB8Im9O2njnBzZAlOSLzVVa1RDH0AQcoV8Va7JqMBfChextgDr8aLVT6fAOlT561R39
         vfIGSEmuL1IFSR8ajUrz0tZY7LAPMeo8zmLH/vmKaxfxwlSlhkCDaHJeFq10+4t3ke84
         tqPSpgilKYrMsqFi1jfgLnWvQSlSBouc9CB6e1KIvH+BBsM8xw8rqVu1tYBnbW7L2CcA
         i1zAjx/HnKdV5bzwwmcvAaPM0qliAY663cxtZOHuNDfGsDJeViSuWboL1GcjQb77YTNy
         pdhg==
X-Gm-Message-State: AOJu0YzcS/7Rz90TxG1sRbazNIH2W3JT8CtV/lKSFnVKzqN7X/6Ax5Vm
        usOoCMEQXQnVKCMSJsX4uT2LMfdxgfzaabqF1CM=
X-Google-Smtp-Source: AGHT+IF+drXWqQX/MHYPMVPQqV+talpJ8o0lHKtQLFcTXFok5Wtffea/MAn09e7QEacdvMduUX1KpxJQ8JM+LnLcHY4=
X-Received: by 2002:a05:6a00:2354:b0:6cd:d67f:7cb with SMTP id
 j20-20020a056a00235400b006cdd67f07cbmr2358008pfj.16.1702091505191; Fri, 08
 Dec 2023 19:11:45 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLyHJjv7bZ3CcXo4zAxZ-o49FO9OsWpQrY4tTLNqCbA4Mw@mail.gmail.com>
 <87o7f0qslm.ffs@tglx>
In-Reply-To: <87o7f0qslm.ffs@tglx>
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Sat, 9 Dec 2023 11:08:41 +0800
Message-ID: <CABOYnLzNSp+ESUEtSFYfKbS=RS9XdQM=4uECpqbsdkTiv4scNg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in alarm_handle_timer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com,
        jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, tglx.
I reprduce this bug with
linux-next commit:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?id=
=3Deff99d8edbed7918317331ebd1e365d8e955d65e
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D61=
991b2630c19677
the same configuration as the syzbot dashboard:
https://syzkaller.appspot.com/bug?extid=3Df2c4e7bfcca6c6d6324c.

However, I do not entangled the information and just try to generate
repro.c with the configuration provided by syzbot dashboard.
When I try the repro.c in the lasted upstream commit:
f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e, it can't crash the kernel at
all. Should I assume this bug was fixed by the mainline?

Thanks!
Best Regards
xingwei Lee

Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2023=E5=B9=B412=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=85=AD 05:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 05 2023 at 10:07, xingwei lee wrote:
> > Hello
> > I reproduced this bug with repro.c
>
> Which bug?
>
> What happens if you run this and what's the potential deadlock?
>
> Lot's of information missing here including the kernel version ...
>
> Thanks,
>
>         tglx
