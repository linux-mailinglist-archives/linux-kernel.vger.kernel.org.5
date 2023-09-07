Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067BB797AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbjIGR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbjIGR65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E67211C;
        Thu,  7 Sep 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109517; x=1725645517;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHa2isBNY8NCc8TgUnH8Hj+JtkoH9ieMz/XfvCm2ldY=;
  b=L9DbZEeMh1Y28VrDC1Q4uIRpNxDSmjN4yGlSk47EBqSyGRP5MDea4fmq
   Uc56p46vD2C9J78iuhRI2qGailL4iWA/ltqS1buYBeFol8CJvdUnUTm2y
   R+VDavJJZp/mPMC7BfR1dO/kGO9mqNST2lJzDXlYWTkMBKhO9ByWO4my0
   0A1YyQdPQI+h1lQt+I3eaNTnYU5BLNU8A5EDf9IfGkLAPhDjrtrTrPHDt
   Fo/bcwR1VG6EKWm+N4+WAbagoAg1oiji3/DYjuN/ODwQ3u7NyoD7PXyKk
   izsGxp02B6Eu9SgPVcS0z+3WPCaw7NPS1CRWDrG71dD32h7vXygLdX9dC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="367632652"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="367632652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="832211526"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="832211526"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.139.35])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 08:09:45 -0700
Date:   Thu, 7 Sep 2023 17:09:40 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     AceLan Kao <acelan@gmail.com>, Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Message-ID: <20230907170940.00002fe4@linux.intel.com>
In-Reply-To: <513ea05e-cc2e-e0c8-43cc-6636b0631cdf@huaweicloud.com>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev>
 <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
 <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
 <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
 <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com>
 <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
 <20230831085057.00001795@linux.intel.com>
 <CAMz9Wg8bhCG=qSLia943dwr=LV7Kum=bZPq2s_2coV6a_bmDeA@mail.gmail.com>
 <20230906122751.00001e5b@linux.intel.com>
 <43b0b2f4-17c0-61d2-9c41-0595fb6f2efc@huaweicloud.com>
 <20230907121819.00005a15@linux.intel.com>
 <cffca94f-5729-622d-9327-632b3ff2891a@huaweicloud.com>
 <3e7edf0c-cadd-59b0-4e10-dffdb86b93b7@huaweicloud.com>
 <20230907144153.00002492@linux.intel.com>
 <513ea05e-cc2e-e0c8-43cc-6636b0631cdf@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 20:53:30 +0800
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
>=20
> =E5=9C=A8 2023/09/07 20:41, Mariusz Tkaczyk =E5=86=99=E9=81=93:
> > On Thu, 7 Sep 2023 20:14:03 +0800
> > Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >  =20
> >> Hi,
> >>
> >> =E5=9C=A8 2023/09/07 19:26, Yu Kuai =E5=86=99=E9=81=93: =20
> >>> Hi,
> >>>
> >>> =E5=9C=A8 2023/09/07 18:18, Mariusz Tkaczyk =E5=86=99=E9=81=93: =20
> >>>> On Thu, 7 Sep 2023 10:04:11 +0800
> >>>> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> >>>>    =20
> >>>>> Hi,
> >>>>>
> >>>>> =E5=9C=A8 2023/09/06 18:27, Mariusz Tkaczyk =E5=86=99=E9=81=93: =20
> >>>>>> On Wed, 6 Sep 2023 14:26:30 +0800
> >>>>>> AceLan Kao <acelan@gmail.com> wrote: =20
> >>>>>>>  =C2=A0 From previous testing, I don't think it's an issue in sys=
temd, so I
> >>>>>>> did a simple test and found the issue is gone.
> >>>>>>> You only need to add a small delay in md_release(), then the issue
> >>>>>>> can't be reproduced.
> >>>>>>>
> >>>>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>>>>>> index 78be7811a89f..ef47e34c1af5 100644
> >>>>>>> --- a/drivers/md/md.c
> >>>>>>> +++ b/drivers/md/md.c
> >>>>>>> @@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *disk)
> >>>>>>> {
> >>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mddev *m=
ddev =3D disk->private_data;
> >>>>>>>
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(10);
> >>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG_ON(!mddev);
> >>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&mdd=
ev->openers);
> >>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_put(mddev=
); =20
> >>>>>>
> >>>>>> I have repro and I tested it on my setup. It is not working for me.
> >>>>>> My setup could be more "advanced" to maximalize chance of reproduc=
tion:
> >>>>>>
> >>>>>> # cat /proc/mdstat
> >>>>>> Personalities : [raid1] [raid6] [raid5] [raid4] [raid10] [raid0]
> >>>>>> md121 : active raid0 nvme2n1[1] nvme5n1[0]
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7126394880 blocks supe=
r external:/md127/0 128k chunks
> >>>>>>
> >>>>>> md122 : active raid10 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 104857600 blocks super=
 external:/md126/0 64K chunks 2
> >>>>>> near-copies
> >>>>>> [4/4] [UUUU]
> >>>>>>
> >>>>>> md123 : active raid5 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2655765504 blocks supe=
r external:/md126/1 level 5, 32k chunk,
> >>>>>> algorithm 0 [4/4] [UUUU]
> >>>>>>
> >>>>>> md124 : active raid1 nvme0n1[1] nvme3n1[0]
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99614720 blocks super =
external:/md125/0 [2/2] [UU]
> >>>>>>
> >>>>>> md125 : inactive nvme3n1[1](S) nvme0n1[0](S)
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10402 blocks super ext=
ernal:imsm
> >>>>>>
> >>>>>> md126 : inactive nvme7n1[3](S) nvme1n1[2](S) nvme6n1[1](S)
> >>>>>> nvme4n1[0](S)
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20043 blocks super ext=
ernal:imsm
> >>>>>>
> >>>>>> md127 : inactive nvme2n1[1](S) nvme5n1[0](S)
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10402 blocks super ext=
ernal:imsm
> >>>>>>
> >>>>>> I have almost 99% repro ratio, slowly moving forward..
> >>>>>>
> >>>>>> It is endless loop because systemd-shutdown sends ioctl "stop_arra=
y"
> >>>>>> which
> >>>>>> is successful but array is not stopped. For that reason it sets
> >>>>>> "changed =3D
> >>>>>> true". =20
> >>>>>
> >>>>> How does systemd-shutdown judge if array is stopped? cat /proc/mdst=
at or
> >>>>> ls /dev/md* or other way? =20
> >>>>
> >>>> Hi Yu,
> >>>>
> >>>> It trusts return result, I confirmed that 0 is returned.
> >>>> The most weird is we are returning 0 but array is still there, and i=
t is
> >>>> stopped again in next systemd loop. I don't understand why yet..
> >>>>    =20
> >>>>>> Systemd-shutdown see the change and retries to check if there is
> >>>>>> something
> >>>>>> else which can be stopped now, and again, again...
> >>>>>>
> >>>>>> I will check what is returned first, it could be 0 or it could be
> >>>>>> positive
> >>>>>> errno (nit?) because systemd cares "if(r < 0)". =20
> >>>>>
> >>>>> I do noticed that there are lots of log about md123 stopped:
> >>>>>
> >>>>> [ 1371.834034] md122:systemd-shutdow bd_prepare_to_claim return -16
> >>>>> [ 1371.840294] md122:systemd-shutdow blkdev_get_by_dev return -16
> >>>>> [ 1371.846845] md: md123 stopped.
> >>>>> [ 1371.850155] md122:systemd-shutdow bd_prepare_to_claim return -16
> >>>>> [ 1371.856411] md122:systemd-shutdow blkdev_get_by_dev return -16
> >>>>> [ 1371.862941] md: md123 stopped.
> >>>>>
> >>>>> And md_ioctl->do_md_stop doesn't have error path after printing this
> >>>>> log, hence 0 will be returned to user.
> >>>>>
> >>>>> The normal case is that:
> >>>>>
> >>>>> open md123
> >>>>> ioctl STOP_ARRAY -> all rdev should be removed from array
> >>>>> close md123 -> mddev will finally be freed by:
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0md_release
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 mddev_put
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(MD_DELETED, &mddev->flags) =
-> user shound not see this
> >>>>> mddev
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(md_misc_wq, &mddev->del_=
work)
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0mddev_delayed_delete
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 kobject_put(&mddev->kobj)
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0md_kobj_release
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 del_gendisk
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 md_free_disk
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mddev_free
> >>>>>    =20
> >>>> Ok thanks, I understand that md_release is called on descriptor
> >>>> closing, right?
> >>>>    =20
> >>>
> >>> Yes, normally close md123 should drop that last reference. =20
> >>>>    =20
> >>>>> Now that you can reporduce this problem 99%, can you dig deeper and=
 find
> >>>>> out what is wrong? =20
> >>>>
> >>>> Yes, working on it!
> >>>>
> >>>> My first idea was that mddev_get and mddev_put are missing on
> >>>> md_ioctl() path
> >>>> but it doesn't help for the issue. My motivation here was that
> >>>> md_attr_store and
> >>>> md_attr_show are using them.
> >>>>
> >>>> Systemd regenerates list of MD arrays on every loop and it is always
> >>>> there, systemd is able to open file descriptor (maybe inactive?). =20
> >>>
> >>> md123 should not be opended again, ioctl(STOP_ARRAY) already set the
> >>> flag 'MD_CLOSING' to prevent that. Are you sure that systemd-shutdown=
 do
> >>> open and close the array in each loop? =20
> >>
> >> I realized that I'm wrong here. 'MD_CLOSING' is cleared before ioctl
> >> return by commit 065e519e71b2 ("md: MD_CLOSING needs to be cleared aft=
er
> >> called md_set_readonly or do_md_stop").
> >>
> >> I'm confused here, commit message said 'MD_CLOSING' shold not be set f=
or
> >> the case STOP_ARRAY_RO, but I don't understand why it's cleared for
> >> STOP_ARRAY as well.
> >> =20
>=20
> Can you try the following patch?
>=20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3afd57622a0b..31b9cec7e4c0 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -7668,7 +7668,8 @@ static int md_ioctl(struct block_device *bdev,=20
> fmode_t mode,
>                          err =3D -EBUSY;
>                          goto out;
>                  }
> -               did_set_md_closing =3D true;
> +               if (cmd =3D=3D STOP_ARRAY_RO)
> +                       did_set_md_closing =3D true;
>                  mutex_unlock(&mddev->open_mutex);
>                  sync_blockdev(bdev);
>          }
>=20
> I think prevent array to be opened again after STOP_ARRAY might fix
> this.

I didn't help. I tried much more:
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0fe7ab6e8ab9..807387f37755 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -608,7 +608,7 @@ static inline struct mddev *mddev_get(struct mddev *mdd=
ev)
 {
        lockdep_assert_held(&all_mddevs_lock);

-       if (test_bit(MD_DELETED, &mddev->flags))
+       if (test_bit(MD_DELETED, &mddev->flags) || test_bit(MD_CLOSING,
  &mddev->flags)) return NULL;
        atomic_inc(&mddev->active);
        return mddev;


Issue is still reproducible. I was shocked so I removed clearing MD_CLOSING:
 out:
-       if(did_set_md_closing)
-               clear_bit(MD_CLOSING, &mddev->flags);
+       //if(did_set_md_closing)
+       //      clear_bit(MD_CLOSING, &mddev->flags);

Still reproducible. Then I found this:
@@ -6177,7 +6179,7 @@ static void md_clean(struct mddev *mddev)
        mddev->persistent =3D 0;
        mddev->level =3D LEVEL_NONE;
        mddev->clevel[0] =3D 0;
-       mddev->flags =3D 0;
+       //mddev->flags =3D 0;
        mddev->sb_flags =3D 0;
        mddev->ro =3D MD_RDWR;
        mddev->metadata_type[0] =3D 0;

Issue not reproducible. I can see in log that attempt to stop device is not
repeated.

Well, with the change of using time-sensitive lock in mddev_put we need to
ensure that we can still can remove mddevice so setting and preserving
MD_CLOSING is reasonable for me. I will combine this into patches tomorrow.

Yu, really appreciate your help! Glad to heave you here.

Thanks,
Mariusz
