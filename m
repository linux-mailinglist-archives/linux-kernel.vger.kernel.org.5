Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB578A524
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjH1FVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjH1FVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA3510D;
        Sun, 27 Aug 2023 22:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4897614D1;
        Mon, 28 Aug 2023 05:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3872BC433CB;
        Mon, 28 Aug 2023 05:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693200061;
        bh=o6Ew4a0egDJtKNJrPTRM1TAOKdBDuhOU8FHng0duLm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qmu2T2IGU5q9w6osl2nWee8D+zK0LFTcjjQJ9RUrNsZn6H0XJn+j2eKmEXbI2tg0A
         QRW3kuTqnRvuyi94TFbPtJFoJ3U9/cR58you9KUZho72uUVJoutEOe1u183xFCpXDy
         mKLo3MywRQdiVyp/0XFPNiz7Z2L2NNcjUFbr7r6g8snehhjRtnpAzwNcW26u4hj/ek
         3vkaE2/VpsW6jtndr4iFRp5h6NFCV1DcGpRyNu6Ek+B+KL8eeyBuhsvZHdbsHPokdu
         C35ZfO+QyTuwjxpgbla4S/9QbcGwlEhG/lzBWSd5LPAn4xM/2NrK7vpzR2mRXzTepM
         PBZDvSqL43YhA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500bb392ab7so499141e87.1;
        Sun, 27 Aug 2023 22:21:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxdykk55/59OC6quoFio5qTIv9+VuUuVE9ayi8Su2T1qavSrk0E
        IjlBBreYQSl7/m/XcmoEVp1txDK0FKuJHm5Np0k=
X-Google-Smtp-Source: AGHT+IGSiwRimUgdAKIu1ItKmlOorMF/6CiiBLR9d2vv+IpXl2kMYbgzKLtAlVnQtaWAZpctEPrzR4zzrKlmkI8HkVI=
X-Received: by 2002:ac2:5f8c:0:b0:500:a00e:1415 with SMTP id
 r12-20020ac25f8c000000b00500a00e1415mr7175934lfe.35.1693200059126; Sun, 27
 Aug 2023 22:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com> <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
 <CAPhsuW6cSLqwRVO_EpFyimvc7hgi1rb3T8-NA+stHdwrqrScBA@mail.gmail.com>
 <20230822083923.00007fb6@linux.intel.com> <CAMz9Wg8KE1rDkSaQnUTJ5ikzH7YGGYbkLM3AcrVue3=JgK+14w@mail.gmail.com>
 <35130b3f-c0fd-e2d6-e849-a5ceb6a2895f@linux.dev> <CAMz9Wg_zKSJ2vL=r2zAtLBOv4GSMT63+ZQGXfYTjVJsE+DLQGA@mail.gmail.com>
 <CAPhsuW6W0XgFjH1zNC+EFYjujd4smEiWs+-nYCWQ+KaFmbuvkg@mail.gmail.com> <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
In-Reply-To: <CAMz9Wg9y52iuxJRSQFC2N5Katt72v-o=JvEjegJt-MwORmw9tQ@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 27 Aug 2023 22:20:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
Message-ID: <CAPhsuW7XEy4q3XR389F7CUvXvJ=0JR0QkMOr4LU03avT0erAfg@mail.gmail.com>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     AceLan Kao <acelan@gmail.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AceLan,

Thanks for running the experiments.

On Fri, Aug 25, 2023 at 9:32=E2=80=AFPM AceLan Kao <acelan@gmail.com> wrote=
:
[...]
> >
> > Could you please run the follow two experiments?
> >
> > 1. Confirm 12a6caf273240a triggers this. Specifically:
> >    git checkout 12a6caf273240a =3D> repros
> >    git checkout 12a6caf273240a~1 =3D> cannot repro
> Yes, I'm pretty sure about this, that's my bisect result and I just
> confirmed it again.
> I also tried reverting 12a6caf273240a and the issue is gone.

The log doesn't match my guess. Specifically:

[  420.068142] systemd-shutdown[1]: Stopping MD /dev/md123 (9:123).
[  420.074718] md_open:md123 openers++ =3D 1 by systemd-shutdow
[  420.080787] systemd-shutdown[1]: Failed to sync MD block device
/dev/md123, ignoring: Input/output error
[  420.090831] md: md123 stopped.
[  420.094465] systemd-shutdown[1]: Stopping MD /dev/md122 (9:122).
[  420.101045] systemd-shutdown[1]: Could not stop MD /dev/md122:
Device or resource busy

For a successful stop on md123, we reach the pr_info() in md_open().
For a failed stop on md122, the kernel returns -EBUSY before that
pr_info() in md_open(). There are some changes in md_open() in
the past few release, so I am not quite sure we are looking at the
same code.

Therefore, could you please help clarify:

1. Which base kernel are you using?

From the log, you are using 6.5-rc7-706a74159504. However,
I think we cannot cleanly revert 12a6caf273240a on top of
6.5-rc7-706a74159504. Did you manually fix some issue in the
revert? If so, could you please share the revert commit?

2. If you are not using 6.5-rc7-706a74159504 as base kernel, which
one are you using?

Thanks,
Song

>
> >
> > 2. Try with the following change (add debug messages), which hopefully
> >    shows which command is holding a reference on mddev->openers.
> >
> > Thanks,
> > Song
> >
> > diff --git i/drivers/md/md.c w/drivers/md/md.c
> > index 78be7811a89f..3e9b718b32c1 100644
> > --- i/drivers/md/md.c
> > +++ w/drivers/md/md.c
> > @@ -7574,11 +7574,15 @@ static int md_ioctl(struct block_device *bdev,
> > blk_mode_t mode,
> >                 if (mddev->pers && atomic_read(&mddev->openers) > 1) {
> >                         mutex_unlock(&mddev->open_mutex);
> >                         err =3D -EBUSY;
> > +                       pr_warn("%s return -EBUSY for %s with
> > mddev->openers =3D %d\n",
> > +                               __func__, mdname(mddev),
> > atomic_read(&mddev->openers));
> >                         goto out;
> >                 }
> >                 if (test_and_set_bit(MD_CLOSING, &mddev->flags)) {
> >                         mutex_unlock(&mddev->open_mutex);
> >                         err =3D -EBUSY;
> > +                       pr_warn("%s return -EBUSY for %s with
> > MD_CLOSING bit set\n",
> > +                               __func__, mdname(mddev));
> >                         goto out;
> >                 }
> >                 did_set_md_closing =3D true;
> > @@ -7789,6 +7793,8 @@ static int md_open(struct gendisk *disk, blk_mode=
_t mode)
> >                 goto out_unlock;
> >
> >         atomic_inc(&mddev->openers);
> > +       pr_info("%s:%s openers++ =3D %d by %s\n", __func__, mdname(mdde=
v),
> > +               atomic_read(&mddev->openers), current->comm);
> >         mutex_unlock(&mddev->open_mutex);
> >
> >         disk_check_media_change(disk);
> > @@ -7807,6 +7813,8 @@ static void md_release(struct gendisk *disk)
> >
> >         BUG_ON(!mddev);
> >         atomic_dec(&mddev->openers);
> > +       pr_info("%s:%s openers-- =3D %d by %s\n", __func__, mdname(mdde=
v),
> > +               atomic_read(&mddev->openers), current->comm);
> >         mddev_put(mddev);
> >  }
> It's pretty strange that I can't reproduce the issue after applied the pa=
tch.
>
> I tried to figure out which part affect the issue and found when I
> comment out the pr_info() In md_release(), the issue could be
> reproduced.
>
> --
> Chia-Lin Kao(AceLan)
> http://blog.acelan.idv.tw/
> E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
