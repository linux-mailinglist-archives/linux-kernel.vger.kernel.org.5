Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5D793540
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbjIFG0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjIFG0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:26:50 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52337198;
        Tue,  5 Sep 2023 23:26:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3aa1c046659so2420220b6e.0;
        Tue, 05 Sep 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693981605; x=1694586405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErdPFLTMod3y/pNAne+tsP9dD0YCjH/oJHYz8O637l0=;
        b=C2xZ1bgqGrxpzMwEmbytMkTj0JeoHOcQ8hs1pFlilCJbjYPLhfyyrUSyDYQ7AjKfE4
         Tl2zA1R6hsYgaP1vERA0VIi+YzMC/OkPdssr6uXDzsxx7F5uUxxB1mh+dxSeyIj/6cLq
         9LSayy/93Hfg2/Gvsx/O59MV8q+P+PWP2+v9PlxTu5NAICxpGIPSW0DzFOJq8/c3ommI
         08i/DcJwqHMParf6FEJQiTW0riaezxMV3IL9QRx+wepCc4C2BpWjjopbNJirvRasCeQ9
         JjPGTm9Uq9li3oGv29fZtwlgtdYKWFg/3cOTGfXtLLskKjbEdXhMoB4m14Bez4zeJy0b
         b/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693981605; x=1694586405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErdPFLTMod3y/pNAne+tsP9dD0YCjH/oJHYz8O637l0=;
        b=HJXNXXP1oqSpYk83OOoOUNaKubIGYN367lr5V7846xS2SIr++wo7ffXVyAEvPSzy2q
         eT+qpzrxW69Tne6uyaHOSNWkAEzkNJ+zOU6vXpff6q7QUDlaZ4xorKfweExz16CC0+mZ
         ypTx6d78u7U3KcTOLzdA0ILa4aY0rW1gEDlmn9NWTH5G5wjqmQoynu5+3kfu6YydE06R
         0B2YKdYFYM26vyBZADAohkRdtOpNRPjLHd+u5qi7hGTuV0DdHwyPGi04WtFvUaALsmHG
         Wv91jNetzPoBYfnsKq3/baqfzIojA0Hf6wZRUe0FBNabUHmLjzh6nfgQm190HNL+Fz1E
         7ucA==
X-Gm-Message-State: AOJu0Yy7BB19cqty9fDveCL32PFgZcMbF2F2sDZscciCK4QrQJ3t9Mno
        CSflgAUph3a9fxWBNSZHipbeqEb7xyHiEu4FLwM=
X-Google-Smtp-Source: AGHT+IEwYA35K8lZxrq5nof/g18OJVXn0gRSQas4u4GgOBidMg6tPzz1//00EYpLXigCCOHvzRV5bWSyxVWZKFGv4aM=
X-Received: by 2002:a05:6358:906:b0:13e:bd8d:c2a7 with SMTP id
 r6-20020a056358090600b0013ebd8dc2a7mr2815809rwi.5.1693981605014; Tue, 05 Sep
 2023 23:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
 <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
 <20230822083923.00007fb6@linux.intel.com> <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev> <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com>
 <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
 <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
 <354004ce-ad4e-5ad5-8fe6-303216647e0c@huaweicloud.com> <03b79ab0-0bb0-ac29-4a70-37d902f9a05b@huaweicloud.com>
 <20230831085057.00001795@linux.intel.com>
In-Reply-To: <20230831085057.00001795@linux.intel.com>
From:   AceLan Kao <acelan@gmail.com>
Date:   Wed, 6 Sep 2023 14:26:30 +0800
Message-ID: <CAMz9Wg8bhCG=qSLia943dwr=LV7Kum=bZPq2s_2coV6a_bmDeA@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> =E6=96=BC 2023=E5=B9=B48=
=E6=9C=8831=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:51=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, 31 Aug 2023 10:28:44 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> > Hi, Acelan,
> >
> > =E5=9C=A8 2023/08/28 21:50, Yu Kuai =E5=86=99=E9=81=93:
> > > Hi,
> > >
> > > =E5=9C=A8 2023/08/28 13:20, Song Liu =E5=86=99=E9=81=93:
> > >> Hi AceLan,
> > >>
> > >> Thanks for running the experiments.
> > >>
> > >> On Fri, Aug 25, 2023 at 9:32=E2=80=AFPM AceLan Kao <acelan@gmail.com=
> wrote:
> > >> [...]
> > >>>>
> > >>>> Could you please run the follow two experiments?
> > >>>>
> > >>>> 1. Confirm 12a6caf273240a triggers this. Specifically:
> > >>>>     git checkout 12a6caf273240a =3D> repros
> > >>>>     git checkout 12a6caf273240a~1 =3D> cannot repro
> > >>> Yes, I'm pretty sure about this, that's my bisect result and I just
> > >>> confirmed it again.
> > >>> I also tried reverting 12a6caf273240a and the issue is gone.
> > >>
> > >> The log doesn't match my guess. Specifically:
> > >>
> > >> [  420.068142] systemd-shutdown[1]: Stopping MD /dev/md123 (9:123).
> > >> [  420.074718] md_open:md123 openers++ =3D 1 by systemd-shutdow
> > >> [  420.080787] systemd-shutdown[1]: Failed to sync MD block device
> > >> /dev/md123, ignoring: Input/output error
> > >> [  420.090831] md: md123 stopped.
> > >> [  420.094465] systemd-shutdown[1]: Stopping MD /dev/md122 (9:122).
> > >> [  420.101045] systemd-shutdown[1]: Could not stop MD /dev/md122:
> > >> Device or resource busy
> > >
> > > I see that:
> > >
> > > systemd-shutdown[1]: Couldn't finalize remaining  MD devices, trying =
again.
> > >
> > > Can we make sure is this why power off hang?
> > >
> > > Because in my VM, power off is not hang and I got:
> > >
> > > systemd-shutdown[1]: Could not stop MD /dev/md1: Device or resource b=
usy
> > > systemd-shutdown[1]: Failed to finalize MD devices, ignoring.
> > >>
> > >> For a successful stop on md123, we reach the pr_info() in md_open().
> > >> For a failed stop on md122, the kernel returns -EBUSY before that
> > >> pr_info() in md_open(). There are some changes in md_open() in
> > >> the past few release, so I am not quite sure we are looking at the
> > >> same code.
> > >
> > > By the way, based on code review, looks like md_open never return
> > > -EBUSY, and I think following is the only place can return -EBUSY bef=
ore
> > > md_open() is called:
> > >
> > > blkdev_open
> > >   blkdev_get_by_dev
> > >    bd_prepare_to_claim
> > >     bd_may_claim     -> -EBUSY
> > >
> > > Acelan, can you add following debug patch on the top of Song's patch
> > > and reporduce it again? Hope it'll confirm why stop array failed with
> > > -EBUSY.
> > >
> >
> > I saw your reply:
> >
> > https://lore.kernel.org/all/CAMz9Wg9VXJzZkKWCosm0_=3DRz6gG9r3pCMrhvBZQV=
CQb8i0kd-w@mail.gmail.com/
> >
> > But I didn't recieve you emails, please reply to me through this email
> > address: yukuai3@huawei.com. yukuai1@huaweicloud.com is just used for
> > sending, and I always missing emails from huaweicloud.com, my apologize
> > for this inconvenience, I have to do it this way due to my company
> > policy.
> >
> > There is something interesting on test result:
> >
> > At first, md122 is the root device, I guess this is why I can't repoduc=
e
> > this problem in my local VM.
> > [   14.478619] systemd-gpt-auto-generator[585]: md122p3: Root device
> > /dev/md122.
> > [   14.481823] block md122: the capability attribute has been deprecate=
d.
> >
> > Then, before trying to stop md122, following log shows that md122 is
> > still mounted:
> > [ 1368.369926] [3462]: Remounting '/' read-only with options
> > 'errors=3Dremount-ro,stripe=3D128'.
> > [ 1368.396287] EXT4-fs (md122p3): re-mounted
> > 6d53dc8e-3f45-4efa-bc0e-4af477fac217 ro. Quota mode: none.
> >
> > And since then, there is no log aboug md_open(), which means no one
> > ever open md122 since this remount.
> >
> > At last, there are lots of log shows that md122 can't be opened
> > exclusively:
> > [ 1368.812952] md122:systemd-shutdow bd_prepare_to_claim return -16
> > [ 1368.819189] md122:systemd-shutdow blkdev_get_by_dev return -16
> >
> > Which indicate that md122 is still mounted, and systemd-shutdow can't
> > stop this array. This behaviour looks correct to me, because rootfs
> > can't be umounted while systemd-shutdown is still running.
> >
> > However, there are some questions I don't have answers for now, I'm not
> > familiar with how systemd works:
> >
> > 1) In the normal case that raid is root device, how can systemd-shutdow=
n
> > make progress and how is rootfs unmounted?
>
> Thanks for digging into!
>
> In that case systemd-shutdown should skip this device. It should be umoun=
ted by
> dracut. systemd-shutdown implements naive way to try stop MD devices, sim=
ple
> ioctl(fd, STOP_ARRAY, NULL).
> We are expecting failure if resource is still mounted.
>
> Here dracut code:
> https://github.com/dracutdevs/dracut/blob/master/modules.d/90mdraid/md-sh=
utdown.sh
>
> Ohh, it is ubuntu so it is handled by initramfs-tools not by dracut, but =
I hope
> you will find it useful for the future.
>
> and system-shutdown:
> https://github.com/systemd/systemd/blob/main/src/shutdown/shutdown.c#L483=
C7-L483C7
>
> When the functionality in systemd-shutdown was fixed by me, I asked if we=
 can
> make it configurable- Lennart disagreed so there is now way to disable it=
 now.
>
> > 2) How does this scenario related to commit 12a6caf273240a.
>
> I'm unable to reproduce it on Redhat, Ubuntu is on the way now.
> I'm starting to be convinced that it could be related with initramfs-tool=
s but
> I cannot prove this theory yet. I need to reproduce the issue first.
>
> Thanks,
> Mariusz
> >
> > I must read systemd source code to get answers, and it'll be appreciate=
d
> > if someone has answers.
> >
> > Thanks,
> > Kuai
> >
> > > diff --git a/block/bdev.c b/block/bdev.c
> > > index 979e28a46b98..699739223dcb 100644
> > > --- a/block/bdev.c
> > > +++ b/block/bdev.c
> > > @@ -789,8 +789,11 @@ struct block_device *blkdev_get_by_dev(dev_t dev=
,
> > > blk_mode_t mode, void *holder,
> > >          if (holder) {
> > >                  mode |=3D BLK_OPEN_EXCL;
> > >                  ret =3D bd_prepare_to_claim(bdev, holder, hops);
> > > -               if (ret)
> > > +               if (ret) {
> > > +                       pr_warn("%s:%s bd_prepare_to_claim return %d\=
n",
> > > +                               disk->disk_name, current->comm, ret);
> > >                          goto put_blkdev;
> > > +               }
> > >          } else {
> > >                  if (WARN_ON_ONCE(mode & BLK_OPEN_EXCL)) {
> > >                          ret =3D -EIO;
> > > diff --git a/block/fops.c b/block/fops.c
> > > index eaa98a987213..2d69119c71f6 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > > @@ -587,8 +587,11 @@ static int blkdev_open(struct inode *inode, stru=
ct
> > > file *filp)
> > >
> > >          bdev =3D blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(f=
ilp),
> > >                                   filp->private_data, NULL);
> > > -       if (IS_ERR(bdev))
> > > +       if (IS_ERR(bdev)) {
> > > +               pr_warn("%pD:%s blkdev_get_by_dev return %ld\n",
> > > +                       filp, current->comm, PTR_ERR(bdev));
> > >                  return PTR_ERR(bdev);
> > > +       }
> > >
> > >          if (bdev_nowait(bdev))
> > >                  filp->f_mode |=3D FMODE_NOWAIT;
> > >
> > > Thanks,
> > > Kuai
> > >
> > >>
> > >> Therefore, could you please help clarify:
> > >>
> > >> 1. Which base kernel are you using?
> > >>
> > >>> From the log, you are using 6.5-rc7-706a74159504. However,
> > >> I think we cannot cleanly revert 12a6caf273240a on top of
> > >> 6.5-rc7-706a74159504. Did you manually fix some issue in the
> > >> revert? If so, could you please share the revert commit?
> > >>
> > >> 2. If you are not using 6.5-rc7-706a74159504 as base kernel, which
> > >> one are you using?
> > >>
> > >> Thanks,
> > >> Song
> > >>
> > >>>
> > >>>>
> > >>>> 2. Try with the following change (add debug messages), which hopef=
ully
> > >>>>     shows which command is holding a reference on mddev->openers.
> > >>>>
> > >>>> Thanks,
> > >>>> Song
> > >>>>
> > >>>> diff --git i/drivers/md/md.c w/drivers/md/md.c
> > >>>> index 78be7811a89f..3e9b718b32c1 100644
> > >>>> --- i/drivers/md/md.c
> > >>>> +++ w/drivers/md/md.c
> > >>>> @@ -7574,11 +7574,15 @@ static int md_ioctl(struct block_device *b=
dev,
> > >>>> blk_mode_t mode,
> > >>>>                  if (mddev->pers && atomic_read(&mddev->openers) >=
 1) {
> > >>>>                          mutex_unlock(&mddev->open_mutex);
> > >>>>                          err =3D -EBUSY;
> > >>>> +                       pr_warn("%s return -EBUSY for %s with
> > >>>> mddev->openers =3D %d\n",
> > >>>> +                               __func__, mdname(mddev),
> > >>>> atomic_read(&mddev->openers));
> > >>>>                          goto out;
> > >>>>                  }
> > >>>>                  if (test_and_set_bit(MD_CLOSING, &mddev->flags)) =
{
> > >>>>                          mutex_unlock(&mddev->open_mutex);
> > >>>>                          err =3D -EBUSY;
> > >>>> +                       pr_warn("%s return -EBUSY for %s with
> > >>>> MD_CLOSING bit set\n",
> > >>>> +                               __func__, mdname(mddev));
> > >>>>                          goto out;
> > >>>>                  }
> > >>>>                  did_set_md_closing =3D true;
> > >>>> @@ -7789,6 +7793,8 @@ static int md_open(struct gendisk *disk,
> > >>>> blk_mode_t mode)
> > >>>>                  goto out_unlock;
> > >>>>
> > >>>>          atomic_inc(&mddev->openers);
> > >>>> +       pr_info("%s:%s openers++ =3D %d by %s\n", __func__,
> > >>>> mdname(mddev),
> > >>>> +               atomic_read(&mddev->openers), current->comm);
> > >>>>          mutex_unlock(&mddev->open_mutex);
> > >>>>
> > >>>>          disk_check_media_change(disk);
> > >>>> @@ -7807,6 +7813,8 @@ static void md_release(struct gendisk *disk)
> > >>>>
> > >>>>          BUG_ON(!mddev);
> > >>>>          atomic_dec(&mddev->openers);
> > >>>> +       pr_info("%s:%s openers-- =3D %d by %s\n", __func__,
> > >>>> mdname(mddev),
> > >>>> +               atomic_read(&mddev->openers), current->comm);
> > >>>>          mddev_put(mddev);
> > >>>>   }
> > >>> It's pretty strange that I can't reproduce the issue after applied
> > >>> the patch.
> > >>>
> > >>> I tried to figure out which part affect the issue and found when I
> > >>> comment out the pr_info() In md_release(), the issue could be
> > >>> reproduced.
> > >>>
From previous testing, I don't think it's an issue in systemd, so I
did a simple test and found the issue is gone.
You only need to add a small delay in md_release(), then the issue
can't be reproduced.

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78be7811a89f..ef47e34c1af5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7805,6 +7805,7 @@ static void md_release(struct gendisk *disk)
{
       struct mddev *mddev =3D disk->private_data;

+       msleep(10);
       BUG_ON(!mddev);
       atomic_dec(&mddev->openers);
       mddev_put(mddev);
