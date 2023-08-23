Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A33784F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjHWDnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjHWDnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CAE4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692762175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTjPxZw7WNaTCVVVAXqTDOYogHD7bNJ5OsZh/R8fNes=;
        b=FuOHYFp78sVybED+4zN810Efz5UoVYwoxzZawCUUIJe1rjYndoUZWeYzU1rLs1i97GOI9r
        +B5gpkjIPIYkZ4KEqveg73lunOpqAyvEkxUjnnosHjZ2iKbUs/r4fgiOBaNCgMOudWHdxX
        p0m/NwFDYppmid6bHMEr31j4P5ZFS10=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-SssndY-JOXu4AsLOsh443g-1; Tue, 22 Aug 2023 23:42:53 -0400
X-MC-Unique: SssndY-JOXu4AsLOsh443g-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26fb3f2edc9so259980a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692762172; x=1693366972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTjPxZw7WNaTCVVVAXqTDOYogHD7bNJ5OsZh/R8fNes=;
        b=Bfdol2kOGgl5y7JYaTI9J+3gSONsD3NDQmsYAagp7Gj96Ef0syGVYyCiEbNNZRvQi8
         76bbAUamVAvqhBd00QDfdB8vS8QJZMsSpOBrR9lmwToR69ExDl3/BB9IoDg+Q7o7oVru
         gYOP+7Fjy7pHXH0cr/iwsLhqXSWZy/bM7OH9d8uI/W1WXNXROpvb2hJKySqG/6FKjwWy
         YSM5HAuDbjefHzMZN6dLj+1DYtcjBVmnFBtgs2tsnpu5VpLZ85bq9I1QV3cudTnQCrtD
         ofKCXqYWjycoE4Qfw+xz/Go0kvdLOQLORbp1IUWDKIDUL5JQhdmtVL8O09wb94Jf3gSy
         omSw==
X-Gm-Message-State: AOJu0YyyHipsLhX/AE4og8qPj7BDQ0yNXVRi6pvE6OMQaU1pgQDafogF
        iLeW1d36hGgF4LMe1Rt50ovLS5v5dJAJ/LGvWSHQhClzkhDAgPiQBeSbrqYeqIuy4NpHCOZ2N/9
        zTr1xE4jy/FJkTDedSdeKeK2sSxLEf/Nf3IcFykhujlhbFifaDmE=
X-Received: by 2002:a17:90b:3ec7:b0:26d:19f3:ecb9 with SMTP id rm7-20020a17090b3ec700b0026d19f3ecb9mr7395777pjb.48.1692762172399;
        Tue, 22 Aug 2023 20:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrUrR/PNGh4AhU7u9sjqSdZkN2FfdIKgNq+EAOpSr3tCNAkVFKGCr0I2LXvsxVymrJB4EksP9iNHlBlUpu8Lk=
X-Received: by 2002:a17:90b:3ec7:b0:26d:19f3:ecb9 with SMTP id
 rm7-20020a17090b3ec700b0026d19f3ecb9mr7395768pjb.48.1692762172100; Tue, 22
 Aug 2023 20:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-5-yukuai1@huaweicloud.com> <CALTww2-mH7SW3Dz0DOd+NyBpZAZzB8r50UCBOkMipNtV4VxWTw@mail.gmail.com>
 <941be671-0d33-ef3a-8e81-d89af66b38a4@huaweicloud.com>
In-Reply-To: <941be671-0d33-ef3a-8e81-d89af66b38a4@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 23 Aug 2023 11:42:41 +0800
Message-ID: <CALTww29j+xQ2y+0eSutuNUDEVfoPaHmS3BDPNdg+wxDNOrHGKw@mail.gmail.com>
Subject: Re: [PATCH -next v3 4/7] md: factor out a helper rdev_removeable()
 from remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:45=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/08/22 18:19, Xiao Ni =E5=86=99=E9=81=93:
> > On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> There are no functional changes, just to make the code simpler and
> >> prepare to delay remove_and_add_spares() to md_start_sync().
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 33 +++++++++++++++++++--------------
> >>   1 file changed, 19 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 561cac13ff96..ceace5ffadd6 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -9153,6 +9153,22 @@ void md_do_sync(struct md_thread *thread)
> >>   }
> >>   EXPORT_SYMBOL_GPL(md_do_sync);
> >>
> >> +static bool rdev_removeable(struct md_rdev *rdev)
> >> +{
> >> +       if (rdev->raid_disk < 0 || test_bit(Blocked, &rdev->flags) ||
> >> +           atomic_read(&rdev->nr_pending))
> >> +               return false;
> >> +
> >> +       if (test_bit(RemoveSynchronized, &rdev->flags))
> >> +               return true;
> >> +
> >> +       if (test_bit(In_sync, &rdev->flags) ||
> >> +           test_bit(Journal, &rdev->flags))
> >> +               return false;
> >> +
> >> +       return true;
> >> +}
> >> +
> >>   static int remove_and_add_spares(struct mddev *mddev,
> >>                                   struct md_rdev *this)
> >>   {
> >> @@ -9166,11 +9182,7 @@ static int remove_and_add_spares(struct mddev *=
mddev,
> >>                  return 0;
> >>
> >>          rdev_for_each(rdev, mddev) {
> >> -               if ((this =3D=3D NULL || rdev =3D=3D this) &&
> >> -                   rdev->raid_disk >=3D 0 &&
> >> -                   !test_bit(Blocked, &rdev->flags) &&
> >> -                   test_bit(Faulty, &rdev->flags) &&
> >> -                   atomic_read(&rdev->nr_pending)=3D=3D0) {
> >> +               if ((this =3D=3D NULL || rdev =3D=3D this) && rdev_rem=
oveable(rdev)) {
> >
> > There is a small change with the original method. Before this patch,
> > it checks the Faulty flag when setting RemoveSynchronized and it
> > checks RemoveSynchronized and "!In_sync && !Journal". I'm not sure if
> > it's right or not.
>
> Yes, there is a small change. After a second thought, I think it's OK
> to leave the code to set RemoveSynchronized where it is for now, because
> it'll be removed later. I don't need to bother factor out a common code
> to set RemoveSynchronized and call hot_remove_disk().

This will be easier for review, thanks.

>
> By the way, once refactor of mddev_suspend() is done, then access to
> rdev from fastpath will be replaced from:
>
> rcu_read_lock()
> ...
> rcu_read_unlock()
>
> to:
>
> md_array_enter()
> // grab 'active_io', 'active_io' will probably be renamed
> ...
> md_array_exit()
>
> That's why I said RemoveSynchronized will be removed.

:) I'll try to understand it in your following patches.

Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> >>                          /* Faulty non-Blocked devices with nr_pending=
 =3D=3D 0
> >>                           * never get nr_pending incremented,
> >>                           * never get Faulty cleared, and never get Bl=
ocked set.
> >> @@ -9185,19 +9197,12 @@ static int remove_and_add_spares(struct mddev =
*mddev,
> >>                  synchronize_rcu();
> >>          rdev_for_each(rdev, mddev) {
> >>                  if ((this =3D=3D NULL || rdev =3D=3D this) &&
> >> -                   rdev->raid_disk >=3D 0 &&
> >> -                   !test_bit(Blocked, &rdev->flags) &&
> >> -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
> >> -                    (!test_bit(In_sync, &rdev->flags) &&
> >> -                     !test_bit(Journal, &rdev->flags))) &&
> >> -                   atomic_read(&rdev->nr_pending)=3D=3D0)) {
> >> -                       if (mddev->pers->hot_remove_disk(
> >> -                                   mddev, rdev) =3D=3D 0) {
> >> +                   rdev_removeable(rdev) &&
> >> +                   mddev->pers->hot_remove_disk(mddev, rdev) =3D=3D 0=
) {
> >>                                  sysfs_unlink_rdev(mddev, rdev);
> >>                                  rdev->saved_raid_disk =3D rdev->raid_=
disk;
> >>                                  rdev->raid_disk =3D -1;
> >>                                  removed++;
> >> -                       }
> >>                  }
> >>                  if (remove_some && test_bit(RemoveSynchronized, &rdev=
->flags))
> >>                          clear_bit(RemoveSynchronized, &rdev->flags);
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>

