Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FF809C98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjLHGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:50:12 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4571718;
        Thu,  7 Dec 2023 22:50:17 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4258b8632f4so11814061cf.2;
        Thu, 07 Dec 2023 22:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702018217; x=1702623017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W/C51mLK1kgvI/bws60M7cH6+CKLSsVJCZbbwKDgSE=;
        b=X2aBX8BxvGKk7hjp6mysTsJkn3ufPyNNHG5kQFe4QuQWNQeUcno11x10LsEOxvyyOH
         KsoijIdpm92vGYcBqzNYTrzKRsRL0MxptrfhmL5KKWRc4HrgkOcSk+RrwMTuCdgs7rbw
         2x7OIy6pSo7eaZdDOD7mQfr6uKiKMeUrnixRlr/gWhxCPCFMA6IcSEKjOgRIjg06sBIZ
         baRDd5fnBKsYZ00U9uLYQRe8cKs8v+kf0Vsw6i5kqLbl2yKAMHZBhOTmIImKZEWYyKTM
         YUducFeZYM2wk6VhWCG7ChgnrLIZ3UbHoKzwz/g4B32HrHELlHA8KpcgRwO6a76V2OKR
         G5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018217; x=1702623017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W/C51mLK1kgvI/bws60M7cH6+CKLSsVJCZbbwKDgSE=;
        b=ng3+kai8hlrhQkzRazJuxJIejm1Mpogxw5OENlw865JEZMiVTqnSlrGZB8FgoWV8Zb
         Y/KDsHDtMgk1I/3ZOCRDXdYrBJjBvNFwUMmE4obJ71aDFzeZ/TDZKz+RgAjmICES6O6g
         GnwBsdAkYXCMMHBtir3/7GDdHWx292zf0tiUG0/xd1ntYoeteYfyU8wVi0bbmAz5gKgx
         8H+rCrxlrunmchNIW45Eqi7YV21tt8XvzWDOciu8wkEzZxVlEtQdlPYcon7pH1i1IdbP
         bO64+Uv+Zo+J/jdmb+L115+B0bJv2OLaXRX5kxG9fmxTuxODG4Uu2WH/mRbfpQC8jq9x
         KLpg==
X-Gm-Message-State: AOJu0YwLhl6pReNkFmpnIzO6hC8BqIIuV2EC79XSIZ/FPxcz6RpcZnwQ
        l15b338HQX2KvoQpE70s8zzDQH3GtnKxAxXKuTNxZHfuz4JqZ+qb
X-Google-Smtp-Source: AGHT+IGIltqtAcNShcCo6eT4DniFUNHIqfU9CIGVMyLJAXwOjKANnX6SnI5O10qDyRrzUrgijxF3zZDqHweOHoY/Els=
X-Received: by 2002:a05:6214:164e:b0:67a:a721:d78e with SMTP id
 f14-20020a056214164e00b0067aa721d78emr3621241qvw.116.1702018216892; Thu, 07
 Dec 2023 22:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20231206115355.4319-1-laoar.shao@gmail.com> <2023120644-pry-worried-22a2@gregkh>
 <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
 <2023120724-overstep-gesture-75be@gregkh> <CALOAHbAbU8At_iPVCiz9M8=jiGQ_BYFupCbVwsm=d9te85pAyg@mail.gmail.com>
 <2023120704-conducive-junkman-2e3f@gregkh> <CALOAHbBUu-oa_wb-PCBdn+vs1k1ZddGhVJg2UuVx912wGWoLkQ@mail.gmail.com>
 <2023120856-empathy-debtless-06b2@gregkh>
In-Reply-To: <2023120856-empathy-debtless-06b2@gregkh>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 Dec 2023 14:49:39 +0800
Message-ID: <CALOAHbBKSrAKvYMTthkUfe7cL_yQ7cm6xtqbtS99_R5asXTKJw@mail.gmail.com>
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

On Fri, Dec 8, 2023 at 1:36=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Dec 07, 2023 at 08:36:56PM +0800, Yafang Shao wrote:
> > On Thu, Dec 7, 2023 at 8:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Dec 07, 2023 at 07:59:03PM +0800, Yafang Shao wrote:
> > > > On Thu, Dec 7, 2023 at 6:19=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Wed, Dec 06, 2023 at 10:08:40PM +0800, Yafang Shao wrote:
> > > > > > On Wed, Dec 6, 2023 at 9:31=E2=80=AFPM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> > > > > > > > After upgrading our kernel from version 4.19 to 6.1, certai=
n regressions
> > > > > > > > occurred due to the driver's asynchronous probe behavior. S=
pecifically,
> > > > > > > > the SCSI driver transitioned to an asynchronous probe by de=
fault, resulting
> > > > > > > > in a non-fixed root disk behavior. In the prior 4.19 kernel=
, the root disk
> > > > > > > > was consistently identified as /dev/sda. However, with kern=
el 6.1, the root
> > > > > > > > disk can be any of /dev/sdX, leading to issues for applicat=
ions reliant on
> > > > > > > > /dev/sda, notably impacting monitoring systems monitoring t=
he root disk.
> > > > > > >
> > > > > > > Device names are never guaranteed to be stable, ALWAYS use a =
persistant
> > > > > > > names like a filesystem label or other ways.  Look at /dev/di=
sk/ for the
> > > > > > > needed ways to do this properly.
> > > > > >
> > > > > > The root disk is typically identified as /dev/sda or /dev/vda, =
right?
> > > > >
> > > > > Depends on your system.  It can also be identified, in the proper=
 way,
> > > > > as /dev/disk/by-uuid/eef0abc1-4039-4c3f-a123-81fc99999993 if you =
want
> > > > > (note, fake uuid, use your own disk uuid please.)
> > > > >
> > > > > Why not do that?  That's the most stable and recommended way of d=
oing
> > > > > things.
> > > >
> > > > Adapting to this change isn't straightforward, especially for a lar=
ge
> > > > fleet of servers. Our monitoring system needs to accommodate and
> > > > adjust accordingly.
> > >
> > > Agreed, that can be rough.  But as this is an issue that was caused b=
y a
> > > scsi core change, perhaps the scsi developers can describe why it's o=
k.
> > >
> > > But really, device naming has ALWAYS been known to not be
> > > deterministic, which is why Pat and I did all the driver core work 20=
+
> > > years ago so that you have the ability to properly name your devices =
in
> > > a way that is deterministic.  Using the kernel name like sda is NOT
> > > using that functionality, so while it has been nice to see that it ha=
s
> > > been stable for you for a while, you are playing with fire here and w=
ill
> > > get burned one day when the firmware in your devices decide to change
> > > response times.
> >
> > I agree that using UUID is a better approach. However, it's worth
> > noting that the widely used IO monitoring tool 'iostat' faces
> > challenges when working with UUIDs. This indicates that there's a
> > significant amount of work ahead of us in this aspect.
>
> That indicates that iostat needs to be fixed as this has been an option
> that people rely on for 20+ years now.  Or use a better tool :)

The issue arises when a disk contains multiple partitions, such as
/dev/sda1 and /dev/sda2. In this case, using 'iostat -j UUID' can only
display 'sda' since only its partitions possess UUIDs. Uncertain how
to address it yet.

--=20
Regards
Yafang
