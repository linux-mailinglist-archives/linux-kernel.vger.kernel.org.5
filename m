Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349F7F60F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbjKWODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbjKWOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:02:59 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468B1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:03:05 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ac376d311aso8955587b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700748185; x=1701352985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks4NgGWTRdOYTAWFkBw8ls2lopTY/knpPpxWc0eVjoY=;
        b=iPr0udDvMrnJdNyWiJ7V+SAybczUTCLS2Q2AfJXnJCl/3wXxE8u20Ku5ig86V6S28w
         b8r63DTBsBXGllgR4IXcohAH4B5/fsbFQu24OemxiHx0Sz76qp3j64ODNH2SVtY8C4BU
         m/tfzqa6ssmQf0N20ggvIwwXMshoPO8odLgWTpI8u+5ojLUjDuxZInQlnB48G2HMEMw2
         3nAOM/PLOTI5VvuI1Q/qqBjuvgIgG5Z+yJWlT8mjvQPHEtOImyN5WpW9DMuePE7hna+b
         SBSBRP9geuFWpRcWvPx7OvWIYrs1cVMtUU88/na+brxjYQez/JQAZBG7gsIvnj8wQvqw
         2Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748185; x=1701352985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks4NgGWTRdOYTAWFkBw8ls2lopTY/knpPpxWc0eVjoY=;
        b=sXb+jQN1G7nfl3We3W0m9FAamLd3bI9XtRX09COJXNeTqOvOEfNHQDH5h0MoJ/092E
         osdi6qPysYl+sSHggjy4N/ZQQwsG/j++IimrugbC8k+RsWFgxbGfU1qUgiVtVfLuMROS
         WixvKUHC1VkPzDR9UcjFKcE9o80kbS47wCKIB5dNjw8Ig/I8W1+ufkXwDCLGrFHmjs4L
         NLenSGSdQu4UykKqFqZnVZsG478jwiCY7Fy9oU/zWdhYNV5FML0LIig+24iYg4GIsq+a
         GVlazQQy4yUCJpX+8WdWzO18QNBowRLNIi8HasqW40t9AA2RAVs+lqFbjA0EqceHmcZ0
         Nj6w==
X-Gm-Message-State: AOJu0Yx4dtbTSzyNHCUebn3+sxfW1cd/qy7PQCxLm71pfT70WyNeK7ZD
        QY1coqav3X3eZktGNCN9bMhnzlFLi/9srA3TaRU8vA==
X-Google-Smtp-Source: AGHT+IFeSEGxpikKOaXB3asFlkH9hGTW6XLBLwkVFeX0TjwdUJ7Wr4g3A78xPkh92BHyjfhhWrmud0z7maI1MIusWd0=
X-Received: by 2002:a81:430a:0:b0:5cc:c649:85e7 with SMTP id
 q10-20020a81430a000000b005ccc64985e7mr3982399ywa.26.1700748184870; Thu, 23
 Nov 2023 06:03:04 -0800 (PST)
MIME-Version: 1.0
References: <00000000000029fce7060ad196ad@google.com>
In-Reply-To: <00000000000029fce7060ad196ad@google.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 23 Nov 2023 09:02:53 -0500
Message-ID: <CAM0EoM=20ATLfrRMGh-zqgx7BrHiyCUmiCYBX_f1ST69UFRfOA@mail.gmail.com>
Subject: Re: [syzbot] Monthly net report (Nov 2023)
To:     syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 8:12=E2=80=AFAM syzbot
<syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com> wrote:
>
> Hello net maintainers/developers,
>
> This is a 31-day syzbot report for the net subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/net
>

Hi,
Could you please Cc the stakeholders for each issue (especially when
there is a reproducer)? Not everybody reads every single message that
shows up in the kernel.

cheers,
jamal

> During the period, 5 new issues were detected and 13 were fixed.
> In total, 77 issues are still open and 1358 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref  Crashes Repro Title
> <1>  3878    Yes   KMSAN: uninit-value in eth_type_trans (2)
>                    https://syzkaller.appspot.com/bug?extid=3D0901d0cc75c3=
d716a3a3
> <2>  892     Yes   possible deadlock in __dev_queue_xmit (3)
>                    https://syzkaller.appspot.com/bug?extid=3D3b165dac1509=
4065651e
> <3>  860     Yes   INFO: task hung in switchdev_deferred_process_work (2)
>                    https://syzkaller.appspot.com/bug?extid=3D8ecc009e206a=
956ab317
> <4>  590     Yes   INFO: task hung in rtnetlink_rcv_msg
>                    https://syzkaller.appspot.com/bug?extid=3D8218a8a0ff60=
c19b8eae
> <5>  390     Yes   WARNING in kcm_write_msgs
>                    https://syzkaller.appspot.com/bug?extid=3D52624bdfbf27=
46d37d70
> <6>  373     Yes   INFO: rcu detected stall in corrupted (4)
>                    https://syzkaller.appspot.com/bug?extid=3Daa7d098bd6fa=
788fae8e
> <7>  249     Yes   INFO: rcu detected stall in tc_modify_qdisc
>                    https://syzkaller.appspot.com/bug?extid=3D9f78d5c664a8=
c33f4cce
> <8>  240     Yes   BUG: corrupted list in p9_fd_cancelled (2)
>                    https://syzkaller.appspot.com/bug?extid=3D1d26c4ed77bc=
6c5ed5e6
> <9>  172     No    INFO: task hung in linkwatch_event (3)
>                    https://syzkaller.appspot.com/bug?extid=3Dd4b2f8282f84=
f54e87a1
> <10> 154     Yes   WARNING in print_bfs_bug (2)
>                    https://syzkaller.appspot.com/bug?extid=3D630f83b42d80=
1d922b8b
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>
