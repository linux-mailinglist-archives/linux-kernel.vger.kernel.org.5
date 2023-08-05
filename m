Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2778770CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 03:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHEBGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 21:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHEBGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:06:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529CC5249
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 18:06:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a7768f1dso223342885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691197593; x=1691802393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9nXyLSKlKDuUv7VJNfF6qvF+1BUCc5KK6MJ3lKMdxY=;
        b=aUwo21adxNhts1FI6P2qHSPV+p0bQFy+AVXKarONqtMm86XWxkCeXSeCRN5rVOkbuA
         U9xu3v9w8K8eVl+8jZUOqrqfCHUny7KfanQvYPi1lJj5UnIuPwU2bBaexSN4P/CiStKM
         Q04LTz5qK5imoj1roocTbgXo95ivHHkcbkfr4yII/5eubPfs8VLuc99/bOLp5VICKq+l
         kJ0hzHB1Moy0QCkOK7RoLAULbNhhHbdlMhXQ/JWxfdDf2RMT/G8sPy/SfAyX6ujpFsBs
         63FGq+adFIALmXtAt9wp8tA4MpkrRo5mr6xvzVMi8NdUsh/Ti6Hx/XABGLcNKVhvW9IT
         o4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691197593; x=1691802393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9nXyLSKlKDuUv7VJNfF6qvF+1BUCc5KK6MJ3lKMdxY=;
        b=OzFYjQ275zp70wCMrBxJRP/DAkA1THp8UbnuNpJH4P9qvB0ttmSR7t/SVByp0GVQdA
         HNyJIQhTfOSkFdgjxKimFO9KBPjmqacy0Dl5PNRKRBpoMfydOVrR/hLdeFn5E4PZ3VxO
         ab83xeYfeHJF1bJLmuelJ6+j7Hog2TCWic+90C0wHZ1Y5KItb5aTR4LnJVtM17TbMeWw
         BIqAzRzo7cPMeyHnMClP3Y8rXMokl7IySq50FJa1OduWeJCV0INfk8XgV3I6c/JzQjDY
         mMxA4jbN+hG2eos/ZhabfXyivvC3RY/PW7kkN5gYrOeVs/RmZ2QMP3VgS3oSbpJZ2BGp
         PRDQ==
X-Gm-Message-State: AOJu0Yy+1M4NF3h8+JP7JE0Dmt/LVZ1yaw8nmAtF6MFXiECmQVsuQeao
        Veqp1W2mVIkhTvvUV5pySLGbvnJLDwBmTSVGSd9CckvE2inWO2J+l58=
X-Google-Smtp-Source: AGHT+IGeI3aXL1BSqCSVQSPUC8HxCVhgOILs3RxiXsM7zZQNEZNHfkFdUoN4/MsbrHKtqT5U8IWBJIqb2DgGz4WHyls=
X-Received: by 2002:a05:620a:4628:b0:76c:9fdb:faed with SMTP id
 br40-20020a05620a462800b0076c9fdbfaedmr4192886qkb.35.1691197593186; Fri, 04
 Aug 2023 18:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com>
 <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
 <CAJuCfpGWGsh2BRgwcJ7oVHnqZfrtiesvhzomK0ZmxE_KK=R7FA@mail.gmail.com>
 <CAJuCfpG6BBP+fjV9oyBx3SNiKhiafPzM9vV9bx_goO2aZzAptg@mail.gmail.com> <CAGudoHFrDG6-u-XXEmQoPS2CJ2Wpo4ETwhXc2R=jy78RSYw-Zg@mail.gmail.com>
In-Reply-To: <CAGudoHFrDG6-u-XXEmQoPS2CJ2Wpo4ETwhXc2R=jy78RSYw-Zg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 18:06:22 -0700
Message-ID: <CAJuCfpHYBqULvwNELO3Gkc0bkKDV7VJxMjvBru4zaAz4WKQNhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 5:49=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On 8/5/23, Suren Baghdasaryan <surenb@google.com> wrote:
> > On Fri, Aug 4, 2023 at 5:26=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com>
> > wrote:
> >>
> >> On Fri, Aug 4, 2023 at 5:15=E2=80=AFPM Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >> >
> >> > On Fri, 4 Aug 2023 at 16:25, Mateusz Guzik <mjguzik@gmail.com> wrote=
:
> >> > >
> >> > > I know of these guys, I think they are excluded as is -- they go
> >> > > through access_remote_vm, starting with:
> >> > >         if (mmap_read_lock_killable(mm))
> >> > >                 return 0;
> >> > >
> >> > > while dup_mmap already write locks the parent's mm.
> >> >
> >> > Oh, you're only worried about vma_start_write()?
> >> >
> >> > That's a non-issue. It doesn't take the lock normally, since it star=
ts
> >> > off with
> >> >
> >> >         if (__is_vma_write_locked(vma, &mm_lock_seq))
> >> >                 return;
> >> >
> >> > which catches on the lock sequence number already being set.
> >>
> >> That check will prevent re-locking but if vma is not already locked
> >> then the call will proceed with obtaining the lock and setting
> >> vma->vm_lock_seq to mm->mm_lock_seq.
> >
> > The optimization Mateusz describes looks valid to me. If there is
> > nobody else to fault a page and mm_users is stable (which I think it
> > is because we are holding mmap_lock for write) then we can skip vma
> > locking, I think.
> >
>
> mm_users is definitely *not* stable -- it can be bumped by
> get_task_mm, which is only synchronized with task lock.

Ugh, you are of course correct. Poor choice for saying no new users
(threads) can appear from under us.

>
> However, the other users (that I know of ) go through the mmap
> semaphore to mess with anything which means they will wait for
> dup_mmap to finish (or do their work first). I would be surprised if
> there were any cases which don't take the semaphore, given that it was
> a requirement prior to the vma patchset (unless you patched some to no
> longer need it?). I would guess worst case the semaphore can be added
> if missing.

No, the only mmap_lock read-lock that is affected is during the page
fault, which is expected.

>
> What is guaranteed is that if the forking process is single-threaded,
> there will be no threads added out of nowhere -- the only thread which
> could do it is busy creating one in dup_mmap. If multithreaded
> operation of the forking process was the only problem, that's it.
>
> >>
> >> >
> >> > So no extra locking there.
> >> >
> >> > Well, technically there's extra locking because the code stupidly
> >> > doesn't initialize new vma allocations to the right sequence number,
> >> > but that was talked about here:
> >> >
> >> >
> >> > https://lore.kernel.org/all/CAHk-=3DwiCrWAoEesBuoGoqqufvesicbGp3cX0L=
yKgEvsFaZNpDA@mail.gmail.com/
> >> >
> >> > and it's a separate issue.
> >> >
> >> >           Linus
> >
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>
