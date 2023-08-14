Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1934F77B5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjHNKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjHNKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:03:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6DF101;
        Mon, 14 Aug 2023 03:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F8C630C6;
        Mon, 14 Aug 2023 10:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9188EC433C7;
        Mon, 14 Aug 2023 10:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692007382;
        bh=2baMMu10BTlNnRlxChQfVIeEOTLRrj+HEavQv1/cdkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mD+eO47ww0TjWGYkWoRRgmlJgZGJpk8k/6//YxxKruk1Xm8RqwiwHwWWN6pgMiwJF
         u1BV6xCM0wF+476kJxKKWCnI1wqEaZoRbbf0dZSW3z0TpThf71DZCAy2Upsmzuv1ch
         CtrDU6EHpRBjbXkb/dZajgD2E3fCYYTntS18wyYZ8wXwsSt6yQiYhntWHgpY02imp3
         p6O2UEFDUX1fPjMi09gmBBTPqsvbKjklsUn823pHm10K5nBJMyzZjISD9XjauRmQcF
         a1c5enC8uzSiM68KWJqqHnp3nEkyvv+e1WhxkAYT9/ez/ss6A+IZYu1n2T34I2J5kb
         RjV91UQsBIQPw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so6660617e87.0;
        Mon, 14 Aug 2023 03:03:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSITZtIZcDMNQgFY7Tjj6/Tz/tq386K01G936V4038YqmhGkq9
        W0cmViy3Iy65PvGyqUopo+nlR74IvuZHlkEX1WU=
X-Google-Smtp-Source: AGHT+IEioZDUAppLUKgxk9zLKuOj7vrg5iTnjd/frXnKrVo9ytuRU76uz08sWmD3r1FEcWHAXAo7oHMogeDhKSDg774=
X-Received: by 2002:a05:6512:3b08:b0:4fe:82c:5c8a with SMTP id
 f8-20020a0565123b0800b004fe082c5c8amr7285763lfv.58.1692007380508; Mon, 14 Aug
 2023 03:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132426.2688608-1-yukuai1@huaweicloud.com> <20230803132426.2688608-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230803132426.2688608-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Aug 2023 18:02:46 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5m0bzO_FKw4VxE9S4KK6p7EZaffX+ZoYJZ6VGZQrf1hQ@mail.gmail.com>
Message-ID: <CAPhsuW5m0bzO_FKw4VxE9S4KK6p7EZaffX+ZoYJZ6VGZQrf1hQ@mail.gmail.com>
Subject: Re: [PATCH -next 01/13] md: remove rdev flag 'RemoveSynchronized'
To:     Yu Kuai <yukuai1@huaweicloud.com>, NeilBrown <neil@brown.name>,
        NeilBrown <neilb@suse.de>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Neil

RemoveSynchronized was added by Neil not too long ago. I wonder whether
we still need it in some cases (large raid10 losing a large set of disks).

Thanks,
Song


On Thu, Aug 3, 2023 at 9:27=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> When multiple rdevs are removed from array in remove_and_add_spares(),
> which is only possible from daemon thread(user can only remove one rdev
> through ioctl/sysfs at one time), the flag is used to avoid calling
> synchronize_rcu() multiple times for each rdev.
>
> However, remove rdev from daemon thread really is super cold path, while
> removing n rdevs, it doesn't matter sync rcu n times or just one time.
> Hence remove this flag and make code simpler.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md-multipath.c | 15 +++++++--------
>  drivers/md/md.c           | 26 ++------------------------
>  drivers/md/md.h           |  5 -----
>  drivers/md/raid1.c        | 15 +++++++--------
>  drivers/md/raid10.c       | 15 +++++++--------
>  drivers/md/raid5.c        | 15 +++++++--------
>  6 files changed, 30 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
> index d22276870283..9e4ddd5240cd 100644
> --- a/drivers/md/md-multipath.c
> +++ b/drivers/md/md-multipath.c
> @@ -258,14 +258,13 @@ static int multipath_remove_disk(struct mddev *mdde=
v, struct md_rdev *rdev)
>                         goto abort;
>                 }
>                 p->rdev =3D NULL;
> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -                       synchronize_rcu();
> -                       if (atomic_read(&rdev->nr_pending)) {
> -                               /* lost the race, try later */
> -                               err =3D -EBUSY;
> -                               p->rdev =3D rdev;
> -                               goto abort;
> -                       }
> +
> +               synchronize_rcu();
> +               if (atomic_read(&rdev->nr_pending)) {
> +                       /* lost the race, try later */
> +                       err =3D -EBUSY;
> +                       p->rdev =3D rdev;
> +                       goto abort;
>                 }
>                 err =3D md_integrity_register(mddev);
>         }
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index a3d98273b295..cd7ac1dee3b8 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9155,7 +9155,6 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
>         struct md_rdev *rdev;
>         int spares =3D 0;
>         int removed =3D 0;
> -       bool remove_some =3D false;
>
>         if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>                 /* Mustn't remove devices when resync thread is running *=
/
> @@ -9165,28 +9164,9 @@ static int remove_and_add_spares(struct mddev *mdd=
ev,
>                 if ((this =3D=3D NULL || rdev =3D=3D this) &&
>                     rdev->raid_disk >=3D 0 &&
>                     !test_bit(Blocked, &rdev->flags) &&
> -                   test_bit(Faulty, &rdev->flags) &&
> +                   !test_bit(In_sync, &rdev->flags) &&
> +                   !test_bit(Journal, &rdev->flags) &&
>                     atomic_read(&rdev->nr_pending)=3D=3D0) {
> -                       /* Faulty non-Blocked devices with nr_pending =3D=
=3D 0
> -                        * never get nr_pending incremented,
> -                        * never get Faulty cleared, and never get Blocke=
d set.
> -                        * So we can synchronize_rcu now rather than once=
 per device
> -                        */
> -                       remove_some =3D true;
> -                       set_bit(RemoveSynchronized, &rdev->flags);
> -               }
> -       }
> -
> -       if (remove_some)
> -               synchronize_rcu();
> -       rdev_for_each(rdev, mddev) {
> -               if ((this =3D=3D NULL || rdev =3D=3D this) &&
> -                   rdev->raid_disk >=3D 0 &&
> -                   !test_bit(Blocked, &rdev->flags) &&
> -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
> -                    (!test_bit(In_sync, &rdev->flags) &&
> -                     !test_bit(Journal, &rdev->flags))) &&
> -                   atomic_read(&rdev->nr_pending)=3D=3D0)) {
>                         if (mddev->pers->hot_remove_disk(
>                                     mddev, rdev) =3D=3D 0) {
>                                 sysfs_unlink_rdev(mddev, rdev);
> @@ -9195,8 +9175,6 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
>                                 removed++;
>                         }
>                 }
> -               if (remove_some && test_bit(RemoveSynchronized, &rdev->fl=
ags))
> -                       clear_bit(RemoveSynchronized, &rdev->flags);
>         }
>
>         if (removed && mddev->kobj.sd)
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8ae957480976..b25b6d061372 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -189,11 +189,6 @@ enum flag_bits {
>                                  * than other devices in the array
>                                  */
>         ClusterRemove,
> -       RemoveSynchronized,     /* synchronize_rcu() was called after
> -                                * this device was known to be faulty,
> -                                * so it is safe to remove without
> -                                * another synchronize_rcu() call.
> -                                */
>         ExternalBbl,            /* External metadata provides bad
>                                  * block management for a disk
>                                  */
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 23d211969565..acb6d6542619 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1859,15 +1859,14 @@ static int raid1_remove_disk(struct mddev *mddev,=
 struct md_rdev *rdev)
>                         goto abort;
>                 }
>                 p->rdev =3D NULL;
> -               if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -                       synchronize_rcu();
> -                       if (atomic_read(&rdev->nr_pending)) {
> -                               /* lost the race, try later */
> -                               err =3D -EBUSY;
> -                               p->rdev =3D rdev;
> -                               goto abort;
> -                       }
> +               synchronize_rcu();
> +               if (atomic_read(&rdev->nr_pending)) {
> +                       /* lost the race, try later */
> +                       err =3D -EBUSY;
> +                       p->rdev =3D rdev;
> +                       goto abort;
>                 }
> +
>                 if (conf->mirrors[conf->raid_disks + number].rdev) {
>                         /* We just removed a device that is being replace=
d.
>                          * Move down the replacement.  We drain all IO be=
fore
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 7704a4c7f469..64dd5cb6133e 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -2247,15 +2247,14 @@ static int raid10_remove_disk(struct mddev *mddev=
, struct md_rdev *rdev)
>                 goto abort;
>         }
>         *rdevp =3D NULL;
> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -               synchronize_rcu();
> -               if (atomic_read(&rdev->nr_pending)) {
> -                       /* lost the race, try later */
> -                       err =3D -EBUSY;
> -                       *rdevp =3D rdev;
> -                       goto abort;
> -               }
> +       synchronize_rcu();
> +       if (atomic_read(&rdev->nr_pending)) {
> +               /* lost the race, try later */
> +               err =3D -EBUSY;
> +               *rdevp =3D rdev;
> +               goto abort;
>         }
> +
>         if (p->replacement) {
>                 /* We must have just cleared 'rdev' */
>                 p->rdev =3D p->replacement;
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4cdb35e54251..37d9865b180a 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8267,15 +8267,14 @@ static int raid5_remove_disk(struct mddev *mddev,=
 struct md_rdev *rdev)
>                 goto abort;
>         }
>         *rdevp =3D NULL;
> -       if (!test_bit(RemoveSynchronized, &rdev->flags)) {
> -               lockdep_assert_held(&mddev->reconfig_mutex);
> -               synchronize_rcu();
> -               if (atomic_read(&rdev->nr_pending)) {
> -                       /* lost the race, try later */
> -                       err =3D -EBUSY;
> -                       rcu_assign_pointer(*rdevp, rdev);
> -               }
> +       lockdep_assert_held(&mddev->reconfig_mutex);
> +       synchronize_rcu();
> +       if (atomic_read(&rdev->nr_pending)) {
> +               /* lost the race, try later */
> +               err =3D -EBUSY;
> +               rcu_assign_pointer(*rdevp, rdev);
>         }
> +
>         if (!err) {
>                 err =3D log_modify(conf, rdev, false);
>                 if (err)
> --
> 2.39.2
>
