Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00851808821
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379377AbjLGMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379450AbjLGMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:37:33 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814310C4;
        Thu,  7 Dec 2023 04:37:33 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so1063563276.0;
        Thu, 07 Dec 2023 04:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952653; x=1702557453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql+oBPOXDNEG6plVxyM0Mzn/UJqHZjnpIyxQVr0Ix5M=;
        b=Cakf8bzM2W5Mo8kSr9Dw7ZpOl+ykvIQPiqg44H7LCWwkrdocFFaYQrxiOhPH0IswpF
         N9pezU+QLN1LLjGXgiqUwW8L0Lz1lVHFV6tYaLeWKTI61hM35BafiW5eqmYE4XolFRtD
         JJxJFmdEllu3htDin/6OiEuZZJj44AWCsTzOqWXZR7GPXGbmIzbzxY/Zms7ijyWczNWG
         xl7qV4ykNBjxwtmS8aGqNv2pHAyDTKHLqZdV7C531YMo1osbYcHY3iee83vWAVG8fc7J
         NOU8waeAuqZq/SnyO4W18mC5jtM878iIDpz4hQVopBRz8flaqJVelQCYhID3K5jVfvH3
         RhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952653; x=1702557453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql+oBPOXDNEG6plVxyM0Mzn/UJqHZjnpIyxQVr0Ix5M=;
        b=LELgqz2NWBZvCR4QXJqRubGmY4g96iRbssV/XTNDYnGCDvdpX2blJgsRQjA2FxKpMW
         wGJfCBORGlea3jyDM4mxOUgJb1NfB5wh8ajKDQR1C59GDPdMI8Nj9Xj6F86oyCRoW15j
         FjhiQDqH5uv1lGZgDriA6fNkVUB/9gip96oZ5ZQU8/jUuAfESzUIV83asXDjhDh7r0DB
         kuDsUfvg77ELertCtkN+la1ABWS+YLFesjw2XKeG8JQIrQi/FTl67/lfFS5SEmG4UOEs
         z5cIKlv2WcYPTuzeZhm7lG0phmUbXQ2s2QWDeflOkzpoM3q0CppndBp1wbozxbFPBAfO
         b/6A==
X-Gm-Message-State: AOJu0Yz0qSVL5Mvm3RBva284cioiENzPyS71Gsg5v2ihosRO83zGuA7d
        9X+7Z4b1ndSl7/NDL0zOX+5hTZH1SEPqM4x4QAc=
X-Google-Smtp-Source: AGHT+IFN0upuXvlSPoheSAIXEN0hPT9OgHIEj2D9aFgtXp214WKQncHU+HlDo4f+gdo0CM4KLiuomX4mbAtQEEYnkAc=
X-Received: by 2002:a25:db8f:0:b0:db7:dad0:60f2 with SMTP id
 g137-20020a25db8f000000b00db7dad060f2mr1923076ybf.127.1701952653034; Thu, 07
 Dec 2023 04:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20231206115355.4319-1-laoar.shao@gmail.com> <2023120644-pry-worried-22a2@gregkh>
 <CALOAHbDtFKDh7C0NYeZ0xBV1z3AsNBDdnL7qRtWOrGbaU7W9VQ@mail.gmail.com>
 <2023120724-overstep-gesture-75be@gregkh> <CALOAHbAbU8At_iPVCiz9M8=jiGQ_BYFupCbVwsm=d9te85pAyg@mail.gmail.com>
 <2023120704-conducive-junkman-2e3f@gregkh>
In-Reply-To: <2023120704-conducive-junkman-2e3f@gregkh>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Dec 2023 20:36:56 +0800
Message-ID: <CALOAHbBUu-oa_wb-PCBdn+vs1k1ZddGhVJg2UuVx912wGWoLkQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: Introduce a new kernel parameter driver_sync_probe=
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, rafael@kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
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

On Thu, Dec 7, 2023 at 8:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Dec 07, 2023 at 07:59:03PM +0800, Yafang Shao wrote:
> > On Thu, Dec 7, 2023 at 6:19=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 10:08:40PM +0800, Yafang Shao wrote:
> > > > On Wed, Dec 6, 2023 at 9:31=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Wed, Dec 06, 2023 at 11:53:55AM +0000, Yafang Shao wrote:
> > > > > > After upgrading our kernel from version 4.19 to 6.1, certain re=
gressions
> > > > > > occurred due to the driver's asynchronous probe behavior. Speci=
fically,
> > > > > > the SCSI driver transitioned to an asynchronous probe by defaul=
t, resulting
> > > > > > in a non-fixed root disk behavior. In the prior 4.19 kernel, th=
e root disk
> > > > > > was consistently identified as /dev/sda. However, with kernel 6=
.1, the root
> > > > > > disk can be any of /dev/sdX, leading to issues for applications=
 reliant on
> > > > > > /dev/sda, notably impacting monitoring systems monitoring the r=
oot disk.
> > > > >
> > > > > Device names are never guaranteed to be stable, ALWAYS use a pers=
istant
> > > > > names like a filesystem label or other ways.  Look at /dev/disk/ =
for the
> > > > > needed ways to do this properly.
> > > >
> > > > The root disk is typically identified as /dev/sda or /dev/vda, righ=
t?
> > >
> > > Depends on your system.  It can also be identified, in the proper way=
,
> > > as /dev/disk/by-uuid/eef0abc1-4039-4c3f-a123-81fc99999993 if you want
> > > (note, fake uuid, use your own disk uuid please.)
> > >
> > > Why not do that?  That's the most stable and recommended way of doing
> > > things.
> >
> > Adapting to this change isn't straightforward, especially for a large
> > fleet of servers. Our monitoring system needs to accommodate and
> > adjust accordingly.
>
> Agreed, that can be rough.  But as this is an issue that was caused by a
> scsi core change, perhaps the scsi developers can describe why it's ok.
>
> But really, device naming has ALWAYS been known to not be
> deterministic, which is why Pat and I did all the driver core work 20+
> years ago so that you have the ability to properly name your devices in
> a way that is deterministic.  Using the kernel name like sda is NOT
> using that functionality, so while it has been nice to see that it has
> been stable for you for a while, you are playing with fire here and will
> get burned one day when the firmware in your devices decide to change
> response times.

I agree that using UUID is a better approach. However, it's worth
noting that the widely used IO monitoring tool 'iostat' faces
challenges when working with UUIDs. This indicates that there's a
significant amount of work ahead of us in this aspect.


>
> > > > While reverting to synchronous probing could ensure
> > > > stability, it's worth noting that asynchronous probing can potentia=
lly
> > > > shorten the reboot duration under specific conditions. Thus, there
> > > > might be some resistance to reverting this change as it offers
> > > > performance benefits in certain scenarios. That's why I prefer to
> > > > introduce a kernel parameter for it.
> > >
> > > I don't want to add a new parameter that we need to support for forev=
er
> > > and add to the complexity of the system unless it is REALLY needed.
> >
> > BTW, since there's already a 'driver_async_probe=3D', introducing
> > another 'driver_sync_probe=3D' wouldn't significantly increase the
> > maintenance overhead.
>
> Any new code adds maintenance overhead and complexity, so you have to
> justify it's existance especially when you are not going to be the one
> maintaining it :)

Understood.


--=20
Regards
Yafang
