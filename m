Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3376B808738
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379147AbjLGL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:59:34 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA509AA;
        Thu,  7 Dec 2023 03:59:40 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5cece20f006so6246377b3.3;
        Thu, 07 Dec 2023 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701950380; x=1702555180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzcrn9pBVNf1FVU0YoFLtUh482zBFVsR0jyYJt8y9LY=;
        b=H3RJ6O/MTJurKk4YIhJHX/arJEb8Sd5OhlguLRN3FUR2gdsLCbWhPj6qZFbJAvuape
         alYkVDvWaYHUriWy2dSbzaicC50f+NTrqbj0OZ1nByw+TW4dMveJ0JYPyjhfqXRrwoB2
         V4lV64CkMv/vBvtKVvCvMnQPrcKGt17Bt9rajI0p3DnwIfZE4yrzeZGfp29lbAZqkpNO
         w52ihKAM9GjnHno9DgG5hnX8WdhOy2VubDIs/CMkYkVmy4gq2vxLfbil/spnrOQyWh1a
         sbxKUkJ8hpaVLi0NgUTRd8133edadzNAS/eHcb89Y4mTcELCo08Wn3QapXp4//3Oa0j/
         /Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950380; x=1702555180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pzcrn9pBVNf1FVU0YoFLtUh482zBFVsR0jyYJt8y9LY=;
        b=OFIwkuntYA8zqGZrYw1jiibexbEoNg/m2WyN2nKCLOEhFeJkL8s4ABxSmQ9zSijxV6
         3w0a9Jmk4hMoJDMpxSmckrpd7LqW8aDTd2FrGyT4mVjfyD1hkb4xEMWflMsfb30RN/ft
         bRnnQgLtqR1bAosjC0iteceNMrUiJ6B5A0mAKk7YalnUTH0E9fp3wfkfSSJFjhQ0DdN/
         9H3ZQPJeywKmn28A1Htw1yxzkBhq8WrhXJ8cy8kvFxTc0NPREpVBojR567NFSd17/lo+
         METBiQ3Y5yi54L4KCrLFp7Xqym5N9kDf4fN9TP4yoX5KnhX1ZB7C66iPk4ozz//YRpN8
         /TDw==
X-Gm-Message-State: AOJu0Yxk+cPYTBWSv5yUq6BUaQ6Bh235bQdefltfibaygUJpaBh2OWZq
        fnunJp/uxOQlVVtm30drNC8N1uFTdN6eV4SMrx0=
X-Google-Smtp-Source: AGHT+IEwU2Oa17ghfxEIDVSxGWej/Ung3dJ4wEwQtQtgqzDx1OcoWa6L51OU26eN6kYON1gZ8dLXhswa4QnAchx52HU=
X-Received: by 2002:a25:aae6:0:b0:db7:dacf:6fd4 with SMTP id
 t93-20020a25aae6000000b00db7dacf6fd4mr1806203ybi.92.1701950379950; Thu, 07
 Dec 2023 03:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20231206115355.4319-1-laoar.shao@gmail.com> <2023120644-pry-worried-22a2@gregkh>
 <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com> <2023120724-overstep-gesture-75be@gregkh>
In-Reply-To: <2023120724-overstep-gesture-75be@gregkh>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Dec 2023 19:59:03 +0800
Message-ID: <CALOAHbAbU8At_iPVCiz9M8=jiGQ_BYFupCbVwsm=d9te85pAyg@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter driver_sync_probe=
To:     Greg KH <gregkh@linuxfoundation.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 6:19=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Dec 06, 2023 at 10:08:40PM +0800, Yafang Shao wrote:
> > On Wed, Dec 6, 2023 at 9:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> > > > After upgrading our kernel from version 4.19 to 6.1, certain regres=
sions
> > > > occurred due to the driver's asynchronous probe behavior. Specifica=
lly,
> > > > the SCSI driver transitioned to an asynchronous probe by default, r=
esulting
> > > > in a non-fixed root disk behavior. In the prior 4.19 kernel, the ro=
ot disk
> > > > was consistently identified as /dev/sda. However, with kernel 6.1, =
the root
> > > > disk can be any of /dev/sdX, leading to issues for applications rel=
iant on
> > > > /dev/sda, notably impacting monitoring systems monitoring the root =
disk.
> > >
> > > Device names are never guaranteed to be stable, ALWAYS use a persista=
nt
> > > names like a filesystem label or other ways.  Look at /dev/disk/ for =
the
> > > needed ways to do this properly.
> >
> > The root disk is typically identified as /dev/sda or /dev/vda, right?
>
> Depends on your system.  It can also be identified, in the proper way,
> as /dev/disk/by-uuid/eef0abc1-4039-4c3f-a123-81fc99999993 if you want
> (note, fake uuid, use your own disk uuid please.)
>
> Why not do that?  That's the most stable and recommended way of doing
> things.

Adapting to this change isn't straightforward, especially for a large
fleet of servers. Our monitoring system needs to accommodate and
adjust accordingly.

>
> > This is because the root disk, which houses the operating system,
> > cannot be removed or hotplugged.
>
> Not true at all, happens for many systems (think about how systems that
> run their whole OS out of ram work...)
>
> > Therefore, it usually remains as the
> > first disk in the system. With the synchronous probe, the root disk
> > maintains a stable and consistent identification.
> >
> > >
> > > > To address this, a new kernel parameter 'driver_sync_probe=3D' is i=
ntroduced
> > > > to enforce synchronous probe behavior for specific drivers.
> > >
> > > This should be a per-bus thing, not a driver-specific thing as driver=
s
> > > for the same bus could have differing settings here which would cause=
 a
> > > mess.
> > >
> > > Please just revert the scsi bus functionality if you have had
> > > regressions here, it's not a driver-core thing to do.
> >
> > Are you suggesting a reversal of the asynchronous probe code in the
> > SCSI driver?
>
> For your broken scsi driver, yes.
>
> > While reverting to synchronous probing could ensure
> > stability, it's worth noting that asynchronous probing can potentially
> > shorten the reboot duration under specific conditions. Thus, there
> > might be some resistance to reverting this change as it offers
> > performance benefits in certain scenarios. That's why I prefer to
> > introduce a kernel parameter for it.
>
> I don't want to add a new parameter that we need to support for forever
> and add to the complexity of the system unless it is REALLY needed.

BTW, since there's already a 'driver_async_probe=3D', introducing
another 'driver_sync_probe=3D' wouldn't significantly increase the
maintenance overhead.

> Please work with the scsi developers to resolve the issue for your
> hardware, as it's been working for everyone else for well over a year
> now, right?

The SCSI guys are added to this mail thread.

I'm uncertain whether it's possible to add SCSI kernel parameters
selectively. If that's not feasible, we'll need to maintain the
following modification in our local kernel:

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e934779..8148d12 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -607,7 +607,7 @@ static void sd_set_flush_flag(struct scsi_disk *sdkp)
                .name           =3D "sd",
                .owner          =3D THIS_MODULE,
                .probe          =3D sd_probe,
-               .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
+               .probe_type     =3D PROBE_PREFER_SYNCHRONOUS,
                .remove         =3D sd_remove,
                .shutdown       =3D sd_shutdown,
                .pm             =3D &sd_pm_ops,




--
Regards
Yafang
