Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8378523B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHWIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHWIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:03:08 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7606E54;
        Wed, 23 Aug 2023 01:02:59 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-570f6c17c55so863167eaf.2;
        Wed, 23 Aug 2023 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692777779; x=1693382579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g14GglRm7VWRbdV00ofdv6PJGfaBY+quP/bNcyeNtZs=;
        b=ZXMCyqJDKk6L53d/N6CGdv5riZzpGlsffdUMNyQ7N3qffZGrPRpGeZ34Btf3tchQ6Q
         slUCPHIzYyrD1WVPs/OOzZz1+e3GSj4R53eVSspHZSPOEIZiMrpJbkGySP1LcK+g1VAV
         f8VJ18t5cLTbxJ2zL+Xhn6VH3MwjDCtJ1/dcyDILUer09yfxS9u8SMIPtCDnBfrfndVQ
         ADaPE8OKrBXI97U09DYkUlSKPGHbCXVGa+j8CAFuq4ia2YM9UL0oyyQyvPCcVD8z65JO
         g/MTanfbOo/Ec6lQYMFY2mwhWCH/vX2r1+82KQL3W8Ghhdhdj71tnnzgAGt4EnEMSPSj
         DzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692777779; x=1693382579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g14GglRm7VWRbdV00ofdv6PJGfaBY+quP/bNcyeNtZs=;
        b=fLTeJc+gQlXDPLCkOSm7OqTC+m0aQG0jXy0+rHwoY8G/5QUX2P3xjiQnhyZTzLvHia
         M92nDJ6cZdiooRWUMy71dOQR/CqPqYke8HTfWisyOwGhnBFo9rFA24dm9jz3snXFDSqe
         oWRVq6SkCQC1ckX3dkiTsOkg1aAjHxuOI96Rq+1dq7573LugATr+9+kotZpdjM/tTvrD
         mO3sj0SRwUsXVc4r0CnCGXiZwQNetDRgvP4UI7ojRsLEB6OZi9j49HCabbRR10w2tMU/
         X0ZCT8AECbuXDWfJ6Ogd937UfMY3jnsZa5NnQAcNR7kXX/g4I0Tnw/D/Yt7XjjLTwCNy
         FPCg==
X-Gm-Message-State: AOJu0YyItD81dU6OPeIQLQpl3YL3b9Puh1KxjqtrmDfFjrmc/UczD2Mw
        FESE+hBkagV8gDBQA5uK5b1JK1B5tKfrnXjn6KXsoQT1Fb9eMw==
X-Google-Smtp-Source: AGHT+IFsMZGkUbmqLpb9ZAXeV1hCzx/oldxSzXIqnl+HAsiT96HvVdH9Lgaaaz1J+sJmoKWz6b2jJoG6XO5YEzGJ1bQ=
X-Received: by 2002:a05:6870:ac24:b0:1bf:cb11:c97e with SMTP id
 kw36-20020a056870ac2400b001bfcb11c97emr13187264oab.52.1692777779092; Wed, 23
 Aug 2023 01:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
 <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
 <20230822083923.00007fb6@linux.intel.com> <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev>
In-Reply-To: <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev>
From:   AceLan Kao <acelan@gmail.com>
Date:   Wed, 23 Aug 2023 16:02:46 +0800
Message-ID: <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Song Liu <song@kernel.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guoqing,

Guoqing Jiang <guoqing.jiang@linux.dev> =E6=96=BC 2023=E5=B9=B48=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Acelan,
>
> On 8/22/23 16:13, AceLan Kao wrote:
> >>>>> Hello,
> >>>>> The issue is reproducible with IMSM metadata too, around 20% of reb=
oot
> >>>>> hangs. I will try to raise the priority in the bug because it is va=
lid
> >>>>> high- the base functionality of the system is affected.
> >>>> Since it it reproducible from your side, is it possible to turn the
> >>>> reproduce steps into a test case
> >>>> given the importance?
> >> I didn't try to reproduce it locally yet because customer was able to
> >> bisect the regression and it pointed them to the same patch so I conne=
cted it
> >> and asked author to take a look first. At a first glance, I wanted to =
get
> >> community voice to see if it is not something obvious.
> >>
> >> So far I know, customer is creating 3 IMSM raid arrays, one is the sys=
tem
> >> volume and do a reboot and it sporadically fails (around 20%). That is=
 all.
> >>
> >>>> I guess If all arrays are set with MD_DELETED flag, then reboot migh=
t
> >>>> hang, not sure whether
> >>>> below (maybe need to flush wq as well  before list_del) helps or not=
,
> >>>> just FYI.
> >>>>
> >>>> @@ -9566,8 +9566,10 @@ static int md_notify_reboot(struct notifier_b=
lock
> >>>> *this,
> >>>>
> >>>>           spin_lock(&all_mddevs_lock);
> >>>>           list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs=
) {
> >>>> -               if (!mddev_get(mddev))
> >>>> +               if (!mddev_get(mddev)) {
> >>>> +                       list_del(&mddev->all_mddevs);
> >>>>                           continue;
> >>>> +               }
>
> My suggestion is delete the list node under this scenario, did you try
> above?
Still no luck, the patch doesn't work, the sympton is the same.

>
> >>> I am still not able to reproduce this, probably due to differences in=
 the
> >>> timing. Maybe we only need something like:
> >>>
> >>> diff --git i/drivers/md/md.c w/drivers/md/md.c
> >>> index 5c3c19b8d509..ebb529b0faf8 100644
> >>> --- i/drivers/md/md.c
> >>> +++ w/drivers/md/md.c
> >>> @@ -9619,8 +9619,10 @@ static int md_notify_reboot(struct notifier_bl=
ock
> >>> *this,
> >>>
> >>>          spin_lock(&all_mddevs_lock);
> >>>          list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) =
{
> >>> -               if (!mddev_get(mddev))
> >>> +               if (!mddev_get(mddev)) {
> >>> +                       need_delay =3D 1;
> >>>                          continue;
> >>> +               }
> >>>                  spin_unlock(&all_mddevs_lock);
> >>>                  if (mddev_trylock(mddev)) {
> >>>                          if (mddev->pers)
> >>>
> >>>
> >>> Thanks,
> >>> Song
> >> I will try to reproduce issue at Intel lab to check this.
> >>
> >> Thanks,
> >> Mariusz
> > Hi Guoqing,
> >
> > Here is the command how I trigger the issue, have to do it around 10
> > times to make sure the issue is reproducible
> >
> > echo "repair" | sudo tee /sys/class/block/md12?/md/sync_action && sudo
> > grub-reboot "Advanced options for Ubuntu>Ubuntu, with Linux 6.5.0-rc77
> > 06a74159504-dirty" && head -c 1G < /dev/urandom > myfile1 && sleep 180
> > && head -c 1G < /dev/urandom > myfile2 && sleep 1 && cat /proc/mdstat
> > && sleep 1 && rm myfile1 &&
> > sudo reboot
>
> Is the issue still reproducible with remove below from cmd?
>
> echo "repair" | sudo tee /sys/class/block/md12?/md/sync_action
>
> Just want to know if resync thread is related with the issue or not.
Probably not, we can reproduce the issue without resync, just feel
it's easier to reproduce the issue, so I put the command in my script.

>
> > And the patch to add need_delay doesn't work.
>
> My assumption is that mddev_get always returns NULL, so set need_delay
> wouldn't help.
>
> Thanks,
> Guoqing



--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
