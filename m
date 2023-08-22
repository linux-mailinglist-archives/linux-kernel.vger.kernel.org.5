Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD09783D90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjHVKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHVKHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E3CC1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692698790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTCXOZTKWlBtgR3TiOF1G26BD/6V7FvJx/9Suzf/Oc8=;
        b=jMRkZTkU+A9mBK6ugSTqP8Th5OoK4Ec4yW0Yw1xWYGBpbgnMu9afuF90Bz8QIUBn9RYNHe
        Xa0iaQ8zWCbXY+/y4B8ETgz/m5Y3TJzBDhVH9TEn1nOFTIn9/T3zrgQ4oQgoNe2tNC2RQ3
        inrVUk7Oje1VrAL6W5Ac9haMlAMl47M=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-TUdZYefCMLCUPyRy9CQKWA-1; Tue, 22 Aug 2023 06:06:29 -0400
X-MC-Unique: TUdZYefCMLCUPyRy9CQKWA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f49625bffso2378202a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698788; x=1693303588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTCXOZTKWlBtgR3TiOF1G26BD/6V7FvJx/9Suzf/Oc8=;
        b=Ex3mSpitpQ70LxduQhkHVvckUDDv9FfzGZaWRBtLzDCTXgnDL5UQXuEpzSXeVO2yMS
         PYvfFabPfDUuyVdrRZm5zCIbF2i2l5H4wP0Nuu7zwI1JyinSVOyptzCUixwp3j6wg3M+
         GVK7eN1X+XEBqVlI5/NHeV2vAD3mIewsWcuXMGCAcdTzFX4c4pBIaBpkR2iDSNbbJTgr
         J7fwyaP+d4Wm2GQZV7lkiQ5JdcC53P2auoK+QzIkzvMJUMJUNyxrAm5kwW/JDcpDHS7F
         mCuSkrxqqdgFxPCdDsz2qAjAokaUw1rh1Ibq4/le3Oy7UJM7e4kGYsE4OU/jHQoR/1lh
         G9pA==
X-Gm-Message-State: AOJu0YykzTuRDLy+fZGCgQrOXFPxf/iVNVz7iEF6abzUiqswInsFRScm
        8IrF7KQa8+1Dlfx0Wfsk12rsFB/Nfwpej1v6EagvYfFWk08RPQfCS0EjvGBkvkOsI71bRMsNtaU
        cVZuFT6WHc8IlpUxPg6spBEOyZRFRIqHtDpgJ3kJ3
X-Received: by 2002:a17:90a:6c01:b0:262:ba7f:30cd with SMTP id x1-20020a17090a6c0100b00262ba7f30cdmr5951019pjj.31.1692698788026;
        Tue, 22 Aug 2023 03:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ih15dx7UEER54HYcyFQ/f5Z5OJgACYYaHpKoHSaIrCZPcA37bKoALopiqPe1QeOHVgAad4/1tZEZtdvbL2Y=
X-Received: by 2002:a17:90a:6c01:b0:262:ba7f:30cd with SMTP id
 x1-20020a17090a6c0100b00262ba7f30cdmr5950998pjj.31.1692698787718; Tue, 22 Aug
 2023 03:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com> <20230820090949.2874537-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230820090949.2874537-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 22 Aug 2023 18:06:17 +0800
Message-ID: <CALTww28ikBeeP+8Q=CS2iWd07rRM7QrvNk+yfE9OGV1De5=_Qw@mail.gmail.com>
Subject: Re: [PATCH -next v3 3/7] md: delay choosing sync action to md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Before this patch, for read-write array:
>
> 1) md_check_recover() found that something need to be done, and it'll
>    try to grab 'reconfig_mutex'. The case that md_check_recover() need
>    to do something:
>    - array is not suspend;
>    - super_block need to be updated;
>    - 'MD_RECOVERY_NEEDED' or ''MD_RECOVERY_DONE' is set;
>    - unusual case related to safemode;
>
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>    md_check_recover() will try to choose a sync action, and then queue a
>    work md_start_sync().
>
> 3) md_start_sync() register sync_thread;
>
> After this patch,
>
> 1) is the same;
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>    queue a work md_start_sync() directly;
> 3) md_start_sync() will try to choose a sync action, and then register
>    sync_thread();
>
> Because 'MD_RECOVERY_RUNNING' is cleared when sync_thread is done, 2)
> and 3) and md_do_sync() is always ran in serial and they can never
> concurrent, this change should not introduce any behavior change for now.
>
> Also fix a problem that md_start_sync() can clear 'MD_RECOVERY_RUNNING'
> without protection in error path, which might affect the logical in
> md_check_recovery().
>
> The advantage to change this is that array reconfiguration is
> independent from daemon now, and it'll be much easier to synchronize it
> with io, consider that io may rely on daemon thread to be done.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 73 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0cb9fa703a0c..561cac13ff96 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9293,6 +9293,22 @@ static bool md_choose_sync_action(struct mddev *md=
dev, int *spares)
>  static void md_start_sync(struct work_struct *ws)
>  {
>         struct mddev *mddev =3D container_of(ws, struct mddev, sync_work)=
;
> +       int spares =3D 0;
> +
> +       mddev_lock_nointr(mddev);
> +
> +       if (!md_choose_sync_action(mddev, &spares))
> +               goto not_running;
> +
> +       if (!mddev->pers->sync_request)
> +               goto not_running;
> +
> +       /*
> +        * We are adding a device or devices to an array which has the bi=
tmap
> +        * stored on all devices. So make sure all bitmap pages get writt=
en.
> +        */
> +       if (spares)
> +               md_bitmap_write_all(mddev->bitmap);
>
>         rcu_assign_pointer(mddev->sync_thread,
>                            md_register_thread(md_do_sync, mddev, "resync"=
));
> @@ -9300,20 +9316,27 @@ static void md_start_sync(struct work_struct *ws)
>                 pr_warn("%s: could not start resync thread...\n",
>                         mdname(mddev));
>                 /* leave the spares where they are, it shouldn't hurt */
> -               clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -               wake_up(&resync_wait);
> -               if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -                                      &mddev->recovery))
> -                       if (mddev->sysfs_action)
> -                               sysfs_notify_dirent_safe(mddev->sysfs_act=
ion);
> -       } else
> -               md_wakeup_thread(mddev->sync_thread);
> +               goto not_running;
> +       }
> +
> +       mddev_unlock(mddev);
> +       md_wakeup_thread(mddev->sync_thread);
>         sysfs_notify_dirent_safe(mddev->sysfs_action);
>         md_new_event();
> +       return;
> +
> +not_running:
> +       clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> +       mddev_unlock(mddev);
> +
> +       wake_up(&resync_wait);
> +       if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
> +           mddev->sysfs_action)
> +               sysfs_notify_dirent_safe(mddev->sysfs_action);
>  }
>
>  /*
> @@ -9381,7 +9404,6 @@ void md_check_recovery(struct mddev *mddev)
>                 return;
>
>         if (mddev_trylock(mddev)) {
> -               int spares =3D 0;
>                 bool try_set_sync =3D mddev->safemode !=3D 0;
>
>                 if (!mddev->external && mddev->safemode =3D=3D 1)
> @@ -9468,31 +9490,14 @@ void md_check_recovery(struct mddev *mddev)
>                 clear_bit(MD_RECOVERY_INTR, &mddev->recovery);
>                 clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>
> -               if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recov=
ery) ||
> -                   test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
> -                       goto not_running;
> -               if (!md_choose_sync_action(mddev, &spares))
> -                       goto not_running;
> -               if (mddev->pers->sync_request) {
> -                       if (spares) {
> -                               /* We are adding a device or devices to a=
n array
> -                                * which has the bitmap stored on all dev=
ices.
> -                                * So make sure all bitmap pages get writ=
ten
> -                                */
> -                               md_bitmap_write_all(mddev->bitmap);
> -                       }
> +               if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recove=
ry) &&
> +                   !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>                         queue_work(md_misc_wq, &mddev->sync_work);
> -                       goto unlock;
> -               }
> -       not_running:
> -               if (!mddev->sync_thread) {
> +               } else {
>                         clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>                         wake_up(&resync_wait);
> -                       if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -                                              &mddev->recovery))
> -                               if (mddev->sysfs_action)
> -                                       sysfs_notify_dirent_safe(mddev->s=
ysfs_action);
>                 }
> +
>         unlock:
>                 wake_up(&mddev->sb_wait);
>                 mddev_unlock(mddev);
> --
> 2.39.2
>

I like the idea. Thanks for the effort.

Reviewed-by: Xiao Ni <xni@redhat.com>

