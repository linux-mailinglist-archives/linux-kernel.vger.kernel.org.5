Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461B7C6F73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjJLNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjJLNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:40:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BABE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:40:47 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so1006022276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697118047; x=1697722847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWX5tt3/fEojNkaEPWtc/0gykTdUYUAR2PmqnDHr3L4=;
        b=rpnNsCA/O0k+esKHvpeg+Xk2P0v0zXZx/e+eBDlc6XizooRj3lIlZ2gnZD8r+nylxf
         0FTh5hy/jLxNd4/kp9DH9XgPtGzT9tgcgWwnxvaxk0+G6olLfHU6WaR46bYUTgeNNZC6
         lvLBf3AFpJWPkhThTh4NYRKGJIDQVRtMwysQ1jGavp3AlHzcmR7Vlyk8jLPNunBl4d7S
         FRqb8WuDvNaIBLSPM5mRYEOjNnJPaljlzkmgPuhQo0B/FGASC5H4VWkM32ToX+HK+sTe
         61V/utRnrr5+xwUM7W0pkzp+JwLzevoeP6h18rT/cx+hnsHj5jEgM7nX3zOU5M7Z/WFh
         B1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118047; x=1697722847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWX5tt3/fEojNkaEPWtc/0gykTdUYUAR2PmqnDHr3L4=;
        b=YFakgdOp90sub1toe9WDJJeEMMYTBUE8/iJ7C/DST0Ixlc9gCg4O6oiQBayA7KL7LS
         kvyJEefiePuDrwQ8IyaDzBZcHpA41xml2HuggLLtlUFA5H+HUJYNKe7F5qxKi4GqtBXs
         cxWJEXJ0yivlOL7O4gSr3o8AEdXpV8BMvFxtghh6gsVN8FRN0eLOoFw65wFxgEyJVKAh
         hhcWvDu5bj7UNg+BSkBxnS3nzodRxpln0+BUw6d+bM7qZAVCqeTck4twUjUtE1F9lgrB
         NlY1NLUtkXUAo12q8gvWrBF9vZR7BfQ8dhwUZ+qLUHb2GnVRxDbsZmgEKL8xqId1oG8c
         pp2Q==
X-Gm-Message-State: AOJu0YwU8WP/uBpOpJBxQh0MLRFGVGhoY1bzNRbIv4Dt4pNnN9XqdwyK
        57GNmU+IhkNAWzcngj4xtnhl/RkbFbdU4qsefTZlWToy/+BeaZ/3
X-Google-Smtp-Source: AGHT+IHf2c1fx1fae8XO1U4oA4b3yMPQpEFeBgY+IJ5T2OSnSjTVL+UZ1YlOvCB4lmWoB1I4Xuv5aTLTpfRKUURssMg=
X-Received: by 2002:a5b:342:0:b0:d88:a049:e901 with SMTP id
 q2-20020a5b0342000000b00d88a049e901mr22435592ybp.7.1697118046853; Thu, 12 Oct
 2023 06:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com> <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com> <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
 <a82d7e877dc041d4be5e0ef38c2da406@realtek.com> <CAPDyKFo59Q3dmUJU-hJ++=k0uwx2KxamW9KckDX=O_CA84O1_g@mail.gmail.com>
 <a533dde76d2d4345b85cd060a8e403db@realtek.com>
In-Reply-To: <a533dde76d2d4345b85cd060a8e403db@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Oct 2023 15:40:10 +0200
Message-ID: <CAPDyKFp3sbbQmKiV6NnuWnPmpfuyWzRBTuYJaWx_7oTLLsXdaA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 07:36, Ricky WU <ricky_wu@realtek.com> wrote:
>
> Hi Ulf Hansson,
>
> Can I know what is this patch status or has some concern on this patch?

Didn't you read my earlier replies?

Kind regards
Uffe

>
> Ricky
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, February 10, 2022 10:57 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block =
rw
> >
> > On Thu, 10 Feb 2022 at 07:43, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Sent: Monday, February 7, 2022 7:11 PM
> > > > To: Ricky WU <ricky_wu@realtek.com>
> > > > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi
> > > > block rw
> > > >
> > > > [...]
> > > >
> > > > > > > > >
> > > > > > > > > Do you have any suggestion for testing random I/O But we
> > > > > > > > > think random I/O will not change much
> > > > > > > >
> > > > > > > > I would probably look into using fio,
> > > > > > > > https://fio.readthedocs.io/en/latest/
> > > > > > > >
> > > > > > >
> > > > > > > Filled random I/O data
> > > > > > > Before the patch:
> > > > > > > CMD (Randread):
> > > > > > > sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -t=
hread
> > > > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G
> > > > > > > -name=3Dmytest -bs=3D1M -rw=3Drandread
> > > > > >
> > > > > > Thanks for running the tests! Overall, I would not expect an
> > > > > > impact on the throughput when using a big blocksize like 1M.
> > > > > > This is also pretty clear from the result you have provided.
> > > > > >
> > > > > > However, especially for random writes and reads, we want to try
> > > > > > with smaller blocksizes. Like 8k or 16k, would you mind running
> > > > > > another round of tests to see how that works out?
> > > > > >
> > > > >
> > > > > Filled random I/O data(8k/16k)
> > > >
> > > > Hi Ricky,
> > > >
> > > > Apologize for the delay! Thanks for running the tests. Let me
> > > > comment on them below.
> > > >
> > > > >
> > > > > Before(randread)
> > > > > 8k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=
=3Dmytest
> > > > > -bs=3D8k -rw=3Drandread
> > > > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 8192B-8192B, (W) 8192B-8=
192B,
> > > > > (T) 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D16.5MiB/s (17.3MB/s), 16.5MiB/s-16.5MiB/s
> > > > > (17.3MB/s-17.3MB/s), io=3D1024MiB (1074MB), run=3D62019-62019msec
> > Disk
> > > > stats (read/write):
> > > > >   mmcblk0: ios=3D130757/0, merge=3D0/0, ticks=3D57751/0, in_queue=
=3D57751,
> > > > > util=3D99.89%
> > > > >
> > > > > 16k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=
=3Dmytest
> > > > > -bs=3D16k -rw=3Drandread
> > > > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=
=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D23.3MiB/s (24.4MB/s), 23.3MiB/s-23.3MiB/s
> > > > > (24.4MB/s-24.4MB/s), io=3D1024MiB (1074MB), run=3D44034-44034msec
> > Disk
> > > > stats (read/write):
> > > > >   mmcblk0: ios=3D65333/0, merge=3D0/0, ticks=3D39420/0, in_queue=
=3D39420,
> > > > > util=3D99.84%
> > > > >
> > > > > Before(randrwrite)
> > > > > 8k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M
> > > > > -name=3Dmytest -bs=3D8k -rw=3Drandwrite
> > > > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 8192B-8192B, (W) 8192B-=
8192B,
> > > > > (T) 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >   WRITE: bw=3D4060KiB/s (4158kB/s), 4060KiB/s-4060KiB/s
> > > > > (4158kB/s-4158kB/s), io=3D100MiB (105MB), run=3D25220-25220msec D=
isk
> > > > > stats
> > > > (read/write):
> > > > >   mmcblk0: ios=3D51/12759, merge=3D0/0, ticks=3D80/24154,
> > > > > in_queue=3D24234, util=3D99.90%
> > > > >
> > > > > 16k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M
> > > > > -name=3Dmytest -bs=3D16k -rw=3Drandwrite
> > > > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=
=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >   WRITE: bw=3D7201KiB/s (7373kB/s), 7201KiB/s-7201KiB/s
> > > > > (7373kB/s-7373kB/s), io=3D100MiB (105MB), run=3D14221-14221msec D=
isk
> > > > > stats
> > > > (read/write):
> > > > >   mmcblk0: ios=3D51/6367, merge=3D0/0, ticks=3D82/13647, in_queue=
=3D13728,
> > > > > util=3D99.81%
> > > > >
> > > > >
> > > > > After(randread)
> > > > > 8k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=
=3Dmytest
> > > > > -bs=3D8k -rw=3Drandread
> > > > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 8192B-8192B, (W) 8192B-8=
192B,
> > > > > (T) 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s
> > > > > (13.0MB/s-13.0MB/s), io=3D1024MiB (1074MB), run=3D82397-82397msec
> > Disk
> > > > stats (read/write):
> > > > >   mmcblk0: ios=3D130640/0, merge=3D0/0, ticks=3D74125/0, in_queue=
=3D74125,
> > > > > util=3D99.94%
> > > > >
> > > > > 16k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=
=3Dmytest
> > > > > -bs=3D16k -rw=3Drandread
> > > > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=
=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >    READ: bw=3D20.0MiB/s (21.0MB/s), 20.0MiB/s-20.0MiB/s
> > > > > (21.0MB/s-21.0MB/s), io=3D1024MiB (1074MB), run=3D51076-51076msec
> > Disk
> > > > stats (read/write):
> > > > >   mmcblk0: ios=3D65282/0, merge=3D0/0, ticks=3D46255/0, in_queue=
=3D46254,
> > > > > util=3D99.87%
> > > > >
> > > > > After(randwrite)
> > > > > 8k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M
> > > > > -name=3Dmytest -bs=3D8k -rw=3Drandwrite
> > > > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 8192B-8192B, (W) 8192B-=
8192B,
> > > > > (T) 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >   WRITE: bw=3D4215KiB/s (4317kB/s), 4215KiB/s-4215KiB/s
> > > > > (4317kB/s-4317kB/s), io=3D100MiB (105MB), run=3D24292-24292msec D=
isk
> > > > > stats
> > > > (read/write):
> > > > >   mmcblk0: ios=3D52/12717, merge=3D0/0, ticks=3D86/23182,
> > > > > in_queue=3D23267, util=3D99.92%
> > > > >
> > > > > 16k:
> > > > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -=
thread
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M
> > > > > -name=3Dmytest -bs=3D16k -rw=3Drandwrite
> > > > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=
=3D1
> > > > > result:
> > > > > Run status group 0 (all jobs):
> > > > >   WRITE: bw=3D6499KiB/s (6655kB/s), 6499KiB/s-6499KiB/s
> > > > > (6655kB/s-6655kB/s), io=3D100MiB (105MB), run=3D15756-15756msec D=
isk
> > > > > stats
> > > > (read/write):
> > > > >   mmcblk0: ios=3D51/6347, merge=3D0/0, ticks=3D84/15120, in_queue=
=3D15204,
> > > > > util=3D99.80%
> > > >
> > > > It looks like the rand-read tests above are degrading with the new
> > > > changes, while rand-writes are both improving and degrading.
> > > >
> > > > To summarize my view from all the tests you have done at this point
> > > > (thanks a lot); it looks like the block I/O merging isn't really
> > > > happening at common blocklayer, at least to that extent that would
> > > > benefit us. Clearly you have shown that by the suggested change in
> > > > the mmc host driver, by detecting whether the "next" request is
> > > > sequential to the previous one, which allows us to skip a
> > > > CMD12 and minimize some command overhead.
> > > >
> > > > However, according to the latest tests above, you have also proved
> > > > that the changes in the mmc host driver doesn't come without a cost=
.
> > > > In particular, small random-reads would degrade in performance from
> > > > these changes.
> > > >
> > > > That said, it looks to me that rather than trying to improve things
> > > > for one specific mmc host driver, it would be better to look at thi=
s
> > > > from the generic block layer point of view - and investigate why
> > > > sequential reads/writes aren't getting merged often enough for the
> > > > MMC/SD case. If we can fix the problem there, all mmc host drivers =
would
> > benefit I assume.
> > > >
> > >
> > > So you are thinking about how to patch this in MMC/SD?
> > > I don't know if this method is compatible with other MMC Hosts? Or
> > > they need to patch other code on their host driver
> >
> > I would not limit this to the core layer of MMC/SD. The point I was try=
ing to
> > make was that it doesn't look like the generic block layer is merging t=
he
> > sequential I/O requests in the most efficient way, at least for the eMM=
C/SD
> > devices. Why this is the case, I can't tell. It looks like we need to d=
o some more
> > in-depth analysis to understand why merging isn't efficient for us.
> >
> > >
> > > > BTW, have you tried with different I/O schedulers? If you haven't
> > > > tried BFQ, I suggest you do as it's a good fit for MMC/SD.
> > > >
> > >
> > > I don=E2=80=99t know what is different I/O schedulers means?
> >
> > What I/O scheduler did you use when running the test?
> >
> > For MMC/SD the only one that makes sense to use is BFQ, however that ne=
eds
> > to be configured via sysfs after boot. There is no way, currently, to m=
ake it the
> > default, I think. You may look at Documentation/block/bfq-iosched.rst, =
if you
> > are more interested.
> >
> > Kind regards
> > Uffe
> > ------Please consider the environment before printing this e-mail.
>
