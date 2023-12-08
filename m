Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF0809D09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjLHH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjLHH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:26:36 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8B10EB;
        Thu,  7 Dec 2023 23:26:40 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-425860bf009so11298441cf.2;
        Thu, 07 Dec 2023 23:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702020400; x=1702625200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKMRNNf5g971llj5MVaEOR4JpZefrzMwTG0/nexkKIw=;
        b=mvvIDyQHwZiJB/ykT0thR6g2Ux2p0gAQKFPG8lsakpW6jIh96ECVvXSio1JwNlNi0Y
         EziUBQhd328jEfzg38/VU/4TNe0cs71fiAHgRDSS17MqZsw/hOOXmT3EICzomeL/wRni
         cfkCTuXZbu6RpfP91+V5Hm/tfTXcqN1PjiSn2NdJhpdrf3nUm/K3oc+GBoehbmKWT+7q
         Ngy+OQTYHhP5io9kZGZEDw6Z1oTsfmFQqAylo+CQIVf4HG+sinHwMWXUvjwRccW28FMx
         wBGKGMP4e8UA4vAqDmbahO91SrehPrjIiDHrGFQPnynTDn/XmTwrkBEUZl8NPCpnNrkO
         8LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702020400; x=1702625200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKMRNNf5g971llj5MVaEOR4JpZefrzMwTG0/nexkKIw=;
        b=iuk175/+Vp9xlf0ZZ/hwSGHomg1jA0X0ifr3+HlrP6qfG4Tx/cfvGYoxZFk8QQ4f2u
         XSafTrnE4X7ndskApPbok1sy5XHyAbX76YYiUKAezsjly3YECzoWx0ZmeA2swWiBvuCc
         LvDPuOs1B82g+6SZxIpXn7gE1DF+nT29TlyoeOU8nWT0SbdLJ1LQ1zVzlwtLM79e8Ncq
         HAuh85Ddk9XhZVQI3o68er1bZQwXRCDzWdGu/lNHY3rflgwF+KyeXReh/8WF/6PaZuac
         7a6v4pL4MZdUmag6DQtOPFYApCfh1WhuK+gf5cJBxO8KriEvF0h0HaIjoVj6UkIlSZ4Z
         wjWw==
X-Gm-Message-State: AOJu0YxI5IEUlQU2bncyD79rtJiIBcKzlUNa6tX05dj1bbmzXIzHPEFR
        OTFCDOLgesvKGuDlXfppN6/McrjLuYuDVJfrdrr4/OTSItFun3LN
X-Google-Smtp-Source: AGHT+IG5ZykvBkaSEDyaJqhGcoQ5Cksdt+N7PxR3C++4JE7qe7Tiec4s1QYoe6J/3gRMtOAqOLQscUgtAqSYXqrxLd4=
X-Received: by 2002:a05:6214:29e5:b0:67a:a721:cae6 with SMTP id
 jv5-20020a05621429e500b0067aa721cae6mr4544706qvb.71.1702020399929; Thu, 07
 Dec 2023 23:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20231206115355.4319-1-laoar.shao@gmail.com> <2023120644-pry-worried-22a2@gregkh>
 <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
 <2023120724-overstep-gesture-75be@gregkh> <CALOAHbAbU8At_iPVCiz9M8=jiGQ_BYFupCbVwsm=d9te85pAyg@mail.gmail.com>
 <2023120704-conducive-junkman-2e3f@gregkh> <CALOAHbBUu-oa_wb-PCBdn+vs1k1ZddGhVJg2UuVx912wGWoLkQ@mail.gmail.com>
 <2023120856-empathy-debtless-06b2@gregkh> <CALOAHbBKSrAKvYMTthkUfe7cL_yQ7cm6xtqbtS99_R5asXTKJw@mail.gmail.com>
 <2023120814-failing-trio-7c8b@gregkh>
In-Reply-To: <2023120814-failing-trio-7c8b@gregkh>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 Dec 2023 15:26:03 +0800
Message-ID: <CALOAHbChDgndDu2ZoWeSgwo+W2Hi020soyxo0=qgk7EtdqgwYw@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter driver_sync_probe=
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
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

On Fri, Dec 8, 2023 at 3:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Dec 08, 2023 at 02:49:39PM +0800, Yafang Shao wrote:
> > On Fri, Dec 8, 2023 at 1:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Dec 07, 2023 at 08:36:56PM +0800, Yafang Shao wrote:
> > > > On Thu, Dec 7, 2023 at 8:12=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Thu, Dec 07, 2023 at 07:59:03PM +0800, Yafang Shao wrote:
> > > > > > On Thu, Dec 7, 2023 at 6:19=E2=80=AFPM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 06, 2023 at 10:08:40PM +0800, Yafang Shao wrote:
> > > > > > > > On Wed, Dec 6, 2023 at 9:31=E2=80=AFPM Greg KH <gregkh@linu=
xfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wro=
te:
> > > > > > > > > > After upgrading our kernel from version 4.19 to 6.1, ce=
rtain regressions
> > > > > > > > > > occurred due to the driver's asynchronous probe behavio=
r. Specifically,
> > > > > > > > > > the SCSI driver transitioned to an asynchronous probe b=
y default, resulting
> > > > > > > > > > in a non-fixed root disk behavior. In the prior 4.19 ke=
rnel, the root disk
> > > > > > > > > > was consistently identified as /dev/sda. However, with =
kernel 6.1, the root
> > > > > > > > > > disk can be any of /dev/sdX, leading to issues for appl=
ications reliant on
> > > > > > > > > > /dev/sda, notably impacting monitoring systems monitori=
ng the root disk.
> > > > > > > > >
> > > > > > > > > Device names are never guaranteed to be stable, ALWAYS us=
e a persistant
> > > > > > > > > names like a filesystem label or other ways.  Look at /de=
v/disk/ for the
> > > > > > > > > needed ways to do this properly.
> > > > > > > >
> > > > > > > > The root disk is typically identified as /dev/sda or /dev/v=
da, right?
> > > > > > >
> > > > > > > Depends on your system.  It can also be identified, in the pr=
oper way,
> > > > > > > as /dev/disk/by-uuid/eef0abc1-4039-4c3f-a123-81fc99999993 if =
you want
> > > > > > > (note, fake uuid, use your own disk uuid please.)
> > > > > > >
> > > > > > > Why not do that?  That's the most stable and recommended way =
of doing
> > > > > > > things.
> > > > > >
> > > > > > Adapting to this change isn't straightforward, especially for a=
 large
> > > > > > fleet of servers. Our monitoring system needs to accommodate an=
d
> > > > > > adjust accordingly.
> > > > >
> > > > > Agreed, that can be rough.  But as this is an issue that was caus=
ed by a
> > > > > scsi core change, perhaps the scsi developers can describe why it=
's ok.
> > > > >
> > > > > But really, device naming has ALWAYS been known to not be
> > > > > deterministic, which is why Pat and I did all the driver core wor=
k 20+
> > > > > years ago so that you have the ability to properly name your devi=
ces in
> > > > > a way that is deterministic.  Using the kernel name like sda is N=
OT
> > > > > using that functionality, so while it has been nice to see that i=
t has
> > > > > been stable for you for a while, you are playing with fire here a=
nd will
> > > > > get burned one day when the firmware in your devices decide to ch=
ange
> > > > > response times.
> > > >
> > > > I agree that using UUID is a better approach. However, it's worth
> > > > noting that the widely used IO monitoring tool 'iostat' faces
> > > > challenges when working with UUIDs. This indicates that there's a
> > > > significant amount of work ahead of us in this aspect.
> > >
> > > That indicates that iostat needs to be fixed as this has been an opti=
on
> > > that people rely on for 20+ years now.  Or use a better tool :)
> >
> > The issue arises when a disk contains multiple partitions, such as
> > /dev/sda1 and /dev/sda2. In this case, using 'iostat -j UUID' can only
> > display 'sda' since only its partitions possess UUIDs. Uncertain how
> > to address it yet.
>
> Then use one of the other many other unique ids that are in /dev/disk/
> today.  You have loads of things to choose from:
>         $ ls /dev/disk/
>         by-diskseq  by-id  by-label  by-partlabel  by-partuuid  by-path  =
by-uuid
>
> You have a plethera of choices here, use whatever works best for your
> systems.  This is a userspace decision to make, not a kernel one, as
> this is a policy choice of yours.
>

Indeed, there are alternative methods besides using UUIDs. This
example serves to highlight that UUIDs might not cover all scenarios,
similar to other IDs listed under /dev/disk/.

--=20
Regards
Yafang
