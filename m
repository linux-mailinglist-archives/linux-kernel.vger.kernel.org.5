Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181A7990F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbjIHUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbjIHUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:25:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3499C;
        Fri,  8 Sep 2023 13:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3166C433D9;
        Fri,  8 Sep 2023 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694204720;
        bh=oICsfMZ9zcXdQx62GRWHsb78WN87mQZ6kdZzxuWVlLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=np5QNcHV6ppednrPrSrut4jUIvhZmjh9Lq6RR+Nrh/bGli/5LDm1RlRcXjMRsm4Py
         EfEu5ZFnSIC3b+Q10BR6WL8HDgCG9xo7AGZBRLuzQj6HDZ7YlODM6YEhtZV8BL0OiJ
         aKEwlTeEoZFaRB+3ghwOMPP0jcy2qUuY7sW+aQgmuizAZ04gtmueUaYgBl3UwKDEz4
         28PqxY2kNf3cOY2CYRBXObrAH8gViWaNrIv+lx5d8rB6zmZB+C1QfEnpUqnm3XP689
         LTU+qgjaSGSjEgG7/9cggBZJ9906x3l0VYT1BOWzPc2XxjpZlz90BzZ/LBv4NAoh4i
         e6UY8w8aOOO/w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-502a7e1bdc7so267139e87.0;
        Fri, 08 Sep 2023 13:25:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YxsB8Sglk0lI/2Loq8lo4Qf1cxvCy8iDQUtQUBKM2Yb3vQU9N2j
        Mj31ssxRB1nT0NLul5/h3zGyYQMyq9W5UwqVxAU=
X-Google-Smtp-Source: AGHT+IFfBSYL+XX4tBhb29IpCYv+gn37nS694W+gRm2KIccPnRUcRy+AaCekwP01g8GK9+U5N6kYLYqIjbsC4lbAvCw=
X-Received: by 2002:ac2:57c7:0:b0:500:9839:b13a with SMTP id
 k7-20020ac257c7000000b005009839b13amr2102297lfo.66.1694204718841; Fri, 08 Sep
 2023 13:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev> <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
 <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
 <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
 <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com> <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
 <20230831085057.00001795@linux.intel.com> <CAMz9Wg8bhCG=qSLia943dwr=LV7Kum=bZPq2s_2coV6a_bmDeA@mail.gmail.com>
 <20230906122751.00001e5b@linux.intel.com> <43b0b2f4-17c0-61d2-9c41-0595fb6f2efc@huaweicloud.com>
 <20230907121819.00005a15@linux.intel.com> <cffca94f-5729-622d-9327-632b3ff2891a@huaweicloud.com>
 <3e7edf0c-cadd-59b0-4e10-dffdb86b93b7@huaweicloud.com> <20230907144153.00002492@linux.intel.com>
 <513ea05e-cc2e-e0c8-43cc-6636b0631cdf@huaweicloud.com> <20230907170940.00002fe4@linux.intel.com>
In-Reply-To: <20230907170940.00002fe4@linux.intel.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 13:25:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5t3e2VmhktCLDMV90KBKYzzyB_oVXbJ+J11_4ZydeR9Q@mail.gmail.com>
Message-ID: <CAPhsuW5t3e2VmhktCLDMV90KBKYzzyB_oVXbJ+J11_4ZydeR9Q@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, AceLan Kao <acelan@gmail.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
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

On Thu, Sep 7, 2023 at 8:24=E2=80=AFAM Mariusz Tkaczyk
<mariusz.tkaczyk@linux.intel.com> wrote:
>
> On Thu, 7 Sep 2023 20:53:30 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> > Hi,
> >
> > =E5=9C=A8 2023/09/07 20:41, Mariusz Tkaczyk =E5=86=99=E9=81=93:
> > > On Thu, 7 Sep 2023 20:14:03 +0800
> > > Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > >
> > >> Hi,
> > >>
> > >> =E5=9C=A8 2023/09/07 19:26, Yu Kuai =E5=86=99=E9=81=93:
> > >>> Hi,
> > >>>
> > >>> =E5=9C=A8 2023/09/07 18:18, Mariusz Tkaczyk =E5=86=99=E9=81=93:
> > >>>> On Thu, 7 Sep 2023 10:04:11 +0800
> > >>>> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > >>>>
> > >>>>> Hi,
> > >>>>>
> > >>>>> =E5=9C=A8 2023/09/06 18:27, Mariusz Tkaczyk =E5=86=99=E9=81=93:
> > >>>>>> On Wed, 6 Sep 2023 14:26:30 +0800
> > >>>>>> AceLan Kao <acelan@gmail.com> wrote:
> > >>>>>>>    From previous testing, I don't think it's an issue in system=
d, so I
> > >>>>>>> did a simple test and found the issue is gone.
> > >>>>>>> You only need to add a small delay in md_release(), then the is=
sue
> > >>>>>>> can't be reproduced.
> > >>>>>>>
> > >>>>>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> > >>>>>>> index 78be7811a89f..ef47e34c1af5 100644
> > >>>>>>> --- a/drivers/md/md.c
> > >>>>>>> +++ b/drivers/md/md.c
> > >>>>>>> @@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *di=
sk)
> > >>>>>>> {
> > >>>>>>>           struct mddev *mddev =3D disk->private_data;
> > >>>>>>>
> > >>>>>>> +       msleep(10);
> > >>>>>>>           BUG_ON(!mddev);
> > >>>>>>>           atomic_dec(&mddev->openers);
> > >>>>>>>           mddev_put(mddev);
> > >>>>>>
> > >>>>>> I have repro and I tested it on my setup. It is not working for =
me.
> > >>>>>> My setup could be more "advanced" to maximalize chance of reprod=
uction:
> > >>>>>>
> > >>>>>> # cat /proc/mdstat
> > >>>>>> Personalities : [raid1] [raid6] [raid5] [raid4] [raid10] [raid0]
> > >>>>>> md121 : active raid0 nvme2n1[1] nvme5n1[0]
> > >>>>>>          7126394880 blocks super external:/md127/0 128k chunks
> > >>>>>>
> > >>>>>> md122 : active raid10 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0=
]
> > >>>>>>          104857600 blocks super external:/md126/0 64K chunks 2
> > >>>>>> near-copies
> > >>>>>> [4/4] [UUUU]
> > >>>>>>
> > >>>>>> md123 : active raid5 nvme6n1[3] nvme4n1[2] nvme1n1[1] nvme7n1[0]
> > >>>>>>          2655765504 blocks super external:/md126/1 level 5, 32k =
chunk,
> > >>>>>> algorithm 0 [4/4] [UUUU]
> > >>>>>>
> > >>>>>> md124 : active raid1 nvme0n1[1] nvme3n1[0]
> > >>>>>>          99614720 blocks super external:/md125/0 [2/2] [UU]
> > >>>>>>
> > >>>>>> md125 : inactive nvme3n1[1](S) nvme0n1[0](S)
> > >>>>>>          10402 blocks super external:imsm
> > >>>>>>
> > >>>>>> md126 : inactive nvme7n1[3](S) nvme1n1[2](S) nvme6n1[1](S)
> > >>>>>> nvme4n1[0](S)
> > >>>>>>          20043 blocks super external:imsm
> > >>>>>>
> > >>>>>> md127 : inactive nvme2n1[1](S) nvme5n1[0](S)
> > >>>>>>          10402 blocks super external:imsm
> > >>>>>>
> > >>>>>> I have almost 99% repro ratio, slowly moving forward..
> > >>>>>>
> > >>>>>> It is endless loop because systemd-shutdown sends ioctl "stop_ar=
ray"
> > >>>>>> which
> > >>>>>> is successful but array is not stopped. For that reason it sets
> > >>>>>> "changed =3D
> > >>>>>> true".
> > >>>>>
> > >>>>> How does systemd-shutdown judge if array is stopped? cat /proc/md=
stat or
> > >>>>> ls /dev/md* or other way?
> > >>>>
> > >>>> Hi Yu,
> > >>>>
> > >>>> It trusts return result, I confirmed that 0 is returned.
> > >>>> The most weird is we are returning 0 but array is still there, and=
 it is
> > >>>> stopped again in next systemd loop. I don't understand why yet..
> > >>>>
> > >>>>>> Systemd-shutdown see the change and retries to check if there is
> > >>>>>> something
> > >>>>>> else which can be stopped now, and again, again...
> > >>>>>>
> > >>>>>> I will check what is returned first, it could be 0 or it could b=
e
> > >>>>>> positive
> > >>>>>> errno (nit?) because systemd cares "if(r < 0)".
> > >>>>>
> > >>>>> I do noticed that there are lots of log about md123 stopped:
> > >>>>>
> > >>>>> [ 1371.834034] md122:systemd-shutdow bd_prepare_to_claim return -=
16
> > >>>>> [ 1371.840294] md122:systemd-shutdow blkdev_get_by_dev return -16
> > >>>>> [ 1371.846845] md: md123 stopped.
> > >>>>> [ 1371.850155] md122:systemd-shutdow bd_prepare_to_claim return -=
16
> > >>>>> [ 1371.856411] md122:systemd-shutdow blkdev_get_by_dev return -16
> > >>>>> [ 1371.862941] md: md123 stopped.
> > >>>>>
> > >>>>> And md_ioctl->do_md_stop doesn't have error path after printing t=
his
> > >>>>> log, hence 0 will be returned to user.
> > >>>>>
> > >>>>> The normal case is that:
> > >>>>>
> > >>>>> open md123
> > >>>>> ioctl STOP_ARRAY -> all rdev should be removed from array
> > >>>>> close md123 -> mddev will finally be freed by:
> > >>>>>      md_release
> > >>>>>       mddev_put
> > >>>>>        set_bit(MD_DELETED, &mddev->flags) -> user shound not see =
this
> > >>>>> mddev
> > >>>>>        queue_work(md_misc_wq, &mddev->del_work)
> > >>>>>
> > >>>>>      mddev_delayed_delete
> > >>>>>       kobject_put(&mddev->kobj)
> > >>>>>
> > >>>>>      md_kobj_release
> > >>>>>       del_gendisk
> > >>>>>        md_free_disk
> > >>>>>         mddev_free
> > >>>>>
> > >>>> Ok thanks, I understand that md_release is called on descriptor
> > >>>> closing, right?
> > >>>>
> > >>>
> > >>> Yes, normally close md123 should drop that last reference.
> > >>>>
> > >>>>> Now that you can reporduce this problem 99%, can you dig deeper a=
nd find
> > >>>>> out what is wrong?
> > >>>>
> > >>>> Yes, working on it!
> > >>>>
> > >>>> My first idea was that mddev_get and mddev_put are missing on
> > >>>> md_ioctl() path
> > >>>> but it doesn't help for the issue. My motivation here was that
> > >>>> md_attr_store and
> > >>>> md_attr_show are using them.
> > >>>>
> > >>>> Systemd regenerates list of MD arrays on every loop and it is alwa=
ys
> > >>>> there, systemd is able to open file descriptor (maybe inactive?).
> > >>>
> > >>> md123 should not be opended again, ioctl(STOP_ARRAY) already set th=
e
> > >>> flag 'MD_CLOSING' to prevent that. Are you sure that systemd-shutdo=
wn do
> > >>> open and close the array in each loop?
> > >>
> > >> I realized that I'm wrong here. 'MD_CLOSING' is cleared before ioctl
> > >> return by commit 065e519e71b2 ("md: MD_CLOSING needs to be cleared a=
fter
> > >> called md_set_readonly or do_md_stop").
> > >>
> > >> I'm confused here, commit message said 'MD_CLOSING' shold not be set=
 for
> > >> the case STOP_ARRAY_RO, but I don't understand why it's cleared for
> > >> STOP_ARRAY as well.
> > >>
> >
> > Can you try the following patch?
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 3afd57622a0b..31b9cec7e4c0 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -7668,7 +7668,8 @@ static int md_ioctl(struct block_device *bdev,
> > fmode_t mode,
> >                          err =3D -EBUSY;
> >                          goto out;
> >                  }
> > -               did_set_md_closing =3D true;
> > +               if (cmd =3D=3D STOP_ARRAY_RO)
> > +                       did_set_md_closing =3D true;
> >                  mutex_unlock(&mddev->open_mutex);
> >                  sync_blockdev(bdev);
> >          }
> >
> > I think prevent array to be opened again after STOP_ARRAY might fix
> > this.
>
> I didn't help. I tried much more:
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0fe7ab6e8ab9..807387f37755 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -608,7 +608,7 @@ static inline struct mddev *mddev_get(struct mddev *m=
ddev)
>  {
>         lockdep_assert_held(&all_mddevs_lock);
>
> -       if (test_bit(MD_DELETED, &mddev->flags))
> +       if (test_bit(MD_DELETED, &mddev->flags) || test_bit(MD_CLOSING,
>   &mddev->flags)) return NULL;
>         atomic_inc(&mddev->active);
>         return mddev;
>
>
> Issue is still reproducible. I was shocked so I removed clearing MD_CLOSI=
NG:
>  out:
> -       if(did_set_md_closing)
> -               clear_bit(MD_CLOSING, &mddev->flags);
> +       //if(did_set_md_closing)
> +       //      clear_bit(MD_CLOSING, &mddev->flags);
>
> Still reproducible. Then I found this:
> @@ -6177,7 +6179,7 @@ static void md_clean(struct mddev *mddev)
>         mddev->persistent =3D 0;
>         mddev->level =3D LEVEL_NONE;
>         mddev->clevel[0] =3D 0;
> -       mddev->flags =3D 0;
> +       //mddev->flags =3D 0;
>         mddev->sb_flags =3D 0;
>         mddev->ro =3D MD_RDWR;
>         mddev->metadata_type[0] =3D 0;
>
> Issue not reproducible. I can see in log that attempt to stop device is n=
ot
> repeated.
>
> Well, with the change of using time-sensitive lock in mddev_put we need t=
o
> ensure that we can still can remove mddevice so setting and preserving
> MD_CLOSING is reasonable for me. I will combine this into patches tomorro=
w.
>
> Yu, really appreciate your help! Glad to heave you here.

Thanks to everyone for looking into this tricky issue and running various t=
ests!

Mariusz, please let me know if you need any help with the patch. Hopefully =
we
can fix this soon.

Thanks again,
Song
