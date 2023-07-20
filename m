Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F12A75ABE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGTKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGTKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:25:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0810D4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:25:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdd14c1fbfso975017e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689848709; x=1690453509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZEJjo1kzQSvDVQkBL4GlrzESVg5phFtB0BOvDLNf0Q=;
        b=ecrAkg4qQhLI424S/0ir5Zx3XEnGrP9SQR4uF4SYHFsupjg/5+AnR8NBgLE4VChoIY
         23KqPDXzGPS8Uxx0Zz40E3HeTwZ/vuAhi1TnW/kPp7hPILBWOp/oiqlX9DJC0Ha+fVKY
         Plrg5leA3g4sh0bEsJy0mBuUgp7BFp9f7gnfB8kwYw0Xhu/hBftjaIlO9kX7VqsfjZfa
         fkyFUkMogiZYyhOl4Z1S39mYMVf191KVtlhqDeMaVIACyhF//g9MehM8h+5z6cLu2UTP
         Xzv+0BO4jFCuodMnY3Hfi/cQUJ3ISGnmgE5Gulf8Fc2Jskjt6JKx9dc6KSEu8Uhf+4KK
         MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689848709; x=1690453509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZEJjo1kzQSvDVQkBL4GlrzESVg5phFtB0BOvDLNf0Q=;
        b=ZvO3/9BxM4B+TMv8i9wMKtYIDztO7BQpNY2M7HAdf5tYqlr7O8G4HGmVySWD5N7Wnl
         keSK3PNGJkoBpsjSoqgMBru4o2RjIv7+GR7FE6ZSg8y/bJKg7IYVJ3CYMtceVSf6NCRw
         NGE3wViIo76N5iYrhFH30hPOURWiom3CVce3Z7kRU8KIPyFKgr0TGQWHSIYwelSq1gbR
         G0zrtxngJHdteEqzkva+xPW3gtVe71yAQIB5S2vYIxluKTRH1/UDFz19eaNyTmHE/Jcp
         JbVhRnAilCBN/lBfQr9nbb4OgpZGvtalW/FmH2Z9fwTYwQhaNbXFVL1QwKgmtBhIHI6B
         blRg==
X-Gm-Message-State: ABy/qLamLiUasTfVYDeaYvVTWDr3tANIMzsLoDx6NYgNhw7FnsAjnicP
        1BC68wmfRE4RdsF0c/MBCDrpT1XaWtXpYGfKCOo0zYEY
X-Google-Smtp-Source: APBJJlHG5v4TuE/QtX8uGcx6+UqxprXMYyd89LjRKHPp7xU/5flM7ZkKlLVtzBAv5aOO+Fw+VG6TIH9E2tacKTkN3GU=
X-Received: by 2002:a05:6512:31cc:b0:4f9:92c7:4026 with SMTP id
 j12-20020a05651231cc00b004f992c74026mr2294107lfe.1.1689848708880; Thu, 20 Jul
 2023 03:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com>
In-Reply-To: <CAKZGPAOYPp3ANWfBWxcsT3TJdPt8jH-f2ZJzpin=UZ=-b_-QFg@mail.gmail.com>
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Thu, 20 Jul 2023 15:54:56 +0530
X-Google-Sender-Auth: QTokIRvnb7k_xs_burmWy6oAXnU
Message-ID: <CAKZGPAOY9uxvSTuta+4a41=GGqTxus8YDcv54T7iAL9P-fj_+w@mail.gmail.com>
Subject: Re: Question on sched_clock
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Arun KS <getarunks@gmail.com>, peterz@infradead.org,
        pmladek@suse.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing maintainers

On Wed, Jul 19, 2023 at 10:36=E2=80=AFAM Arun KS <arunks.linux@gmail.com> w=
rote:
>
> Hi,
>
> Kernel=E2=80=99s printk uses local_clock() for timestamps and it is mappe=
d to
> sched_clock(). Two problems/requirements I see,
>
> One, Kernel=E2=80=99s printk timestamps start from 0, I want to change th=
is to
> match with actual time since boot.
> Two, sched_clock() doesn=E2=80=99t account for time spend in low power
> state(suspend to ram)
>
> Could workout patches to modify these behaviours and found working in
> my system. But need to hear expert opinion on why this is not done in
> the upstream.
>
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 68d6c1190ac7..b63b2ded5727 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -190,7 +190,10 @@ sched_clock_register(u64 (*read)(void), int bits,
> unsigned long rate)
>         /* Update epoch for new counter and update 'epoch_ns' from old co=
unter*/
>         new_epoch =3D read();
>         cyc =3D cd.actual_read_sched_clock();
> -       ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> rd.sched_clock_mask, rd.mult, rd.shift);
> +       if (!cyc)
> +               ns =3D cyc_to_ns(new_epoch, new_mult, new_shift)
> +       else
> +               ns =3D rd.epoch_ns + cyc_to_ns((cyc - rd.epoch_cyc) &
> rd.sched_clock_mask, rd.mult, rd.shift);
>         cd.actual_read_sched_clock =3D read;
>
>         rd.read_sched_clock     =3D read;
>
> @@ -287,7 +290,6 @@ void sched_clock_resume(void)
>  {
>         struct clock_read_data *rd =3D &cd.read_data[0];
>
> -       rd->epoch_cyc =3D cd.actual_read_sched_clock();
>         hrtimer_start(&sched_clock_timer, cd.wrap_kt, HRTIMER_MODE_REL_HA=
RD);
>         rd->read_sched_clock =3D cd.actual_read_sched_clock;
>  }
>
> Regards,
> Arun
