Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327D75EE92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGXJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjGXJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:00:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A02210F9;
        Mon, 24 Jul 2023 02:00:06 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-767ca28fb32so224453185a.1;
        Mon, 24 Jul 2023 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189205; x=1690794005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfEU2ZBwaAPSdHcxYxp7PZGApqbwJO+Vmtwst6/ID84=;
        b=glTr1mipvYA7wtVO4+xo/elfVcJjXMQ/oHe/E2B4y+ZWYyDtkhqIzwd/S3TgoGNfQM
         Q8SyuyohY3WlPcj/x8SnZv45xB5TjquFb8S9ygF0ZkGEkuqHOGHVEzcBtxBL1MrhTE8f
         2hSoz98bFVs/ZCyOsshYz/znMgDAw0n0KL89pfzt/8v1W4yzzj/UlD8SGIaUqiKh0XXw
         ca4xoWXHhItVCoj8qXnTgdIn/DaT1ioI3L8IFamDJfc0eclh77YPboOaMdHtlFMdVMIK
         FaeGip+xKdWMwJP9YhaCyadXL74KfvxrURieCh6CU7k1LZ7v9kRYy5ZZMKDTamp02M34
         9aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189205; x=1690794005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfEU2ZBwaAPSdHcxYxp7PZGApqbwJO+Vmtwst6/ID84=;
        b=Z5m1Fr8P0PT2xIQGNnxZWhvDGfKIlCPybVjC3x/BXESb2LYF/UcEits76t0VjelsRc
         V0PLUvY8RvOixmDBF9me360TnNIoBMW5Q5X6x4Kks/OZhg/da4/3OAgO7ob7JycwaQ9D
         R0VXZJdGYKQBu03/m7R5KwSYwiISXmuJJ/v+sQdnlTN2M+J02Mo9BzSlrKSQ1nk74U7/
         fwBYd27ZiETnb+MYMAxGuFIG8iUnthFLwowqAbTqWn7/PF/nUTHxnIQ6sNTrxCoc9kta
         M9kNf28DX4owSRBp+0pqzdWidoi4LWCn9lRBfepLGuyCKABzIS0x2/7E/WMKAqlJb/SX
         cOTQ==
X-Gm-Message-State: ABy/qLbb6DMI5JPh1yWoFsBg+OyegwogY70ULF+RY128hfPAbCy6+FNc
        rWlJQpnfjMaJriVpZ5IvJixJvqxwfFk458APPnw=
X-Google-Smtp-Source: APBJJlERPnFHbfM46a4EJdlo8+ably5AK2+z95PzXveSn6jWe15gykiKsKpe/JajBWA9cDxhZ5Kw/lN5nU0958rD0vk=
X-Received: by 2002:a05:620a:4405:b0:767:82e8:eb7a with SMTP id
 v5-20020a05620a440500b0076782e8eb7amr7825847qkp.17.1690189205279; Mon, 24 Jul
 2023 02:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
 <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop> <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
 <31070aab-8665-44c4-8950-0631a777ef44@paulmck-laptop> <CAM7-yPSn8ietAJ8NKb0-VHDQhkHs73u--KFmO3rpTPUvcFuMvA@mail.gmail.com>
 <CALm+0cWeZnMUk8Lj_nF3Htd14czGcT_Yt71nVwJdGhTECQOAWg@mail.gmail.com>
 <CAM7-yPR2jG=4MkBF1+=f8KUNqmSopq3yTTfWN6YvLcmJjpq8Hw@mail.gmail.com> <CALm+0cX9h8mxiXNZQm4kOnijAyNug8PqF-eXpMT96f6U1YGLWQ@mail.gmail.com>
In-Reply-To: <CALm+0cX9h8mxiXNZQm4kOnijAyNug8PqF-eXpMT96f6U1YGLWQ@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Mon, 24 Jul 2023 09:59:54 +0100
Message-ID: <CAM7-yPSA8E-35w3O=1FLf+=9ax+E1T+eTAfwCscAgzWN2T4Htg@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Z qiang.

> Maybe this "start new gp"  note misunderstood you.
> For built with CONFIG_RCU_STRICT_GRACE_PERIOD=3Dy and CONFIG_PREEMPT=3Dn =
kernels=EF=BC=8C
> if the gp kthread start a new GP before we exit the RCU read critical sec=
tion,
> and just before we call rcu_report_qs_rdp() in
> rcu_read_unlock_strict(), at this time if the clock irq
> happens and find that the "rcu_seq_current(&rnp->gp_seq) !=3D
> rdp->gp_seq" is true in rcu_pening(),
> will trigger RCU softirq and find that the rcu_seq_new_gp(rdp->gp_seq,
> rnp->gp_seq) is true,
> will  set rdp->cpu_no_qs.b.norm is true. when we return from the
> softirq and call rcu_report_qs_rdp()
> in rcu_read_unlock_strict(), find that the rdp->cpu_no_qs.b.norm is true.
> so there is a situation where the rdp->cpu_no_qs.b.norm is true.

Thanks for making me out from my misunderstanding..!
and even the not in STRICT_GRACE_PERIOD,
old grace period's qs could be reported though rcu_gp_kthread start new gp
by first rcu_report_qs_rdp, will be clear soon by continuous rcu_report_qs_=
rdp
which is triggered by interrupting before the first rcu_report_qs_rdp.

Many thanks..!

And sorry to make noise...!
