Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670717E6281
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 04:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjKIDJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 22:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKIDJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 22:09:04 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93511269E;
        Wed,  8 Nov 2023 19:09:02 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a683bd610dso14820739f.1;
        Wed, 08 Nov 2023 19:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699499342; x=1700104142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm2K3rsZVkBARWD83CScKZj3mi6JLbGspKfGu8tGAo0=;
        b=bOTo+p7gHRJ5/s4RL5mEf4uk5wAlkBNbIwXMB3AWue7mbKZ121zKR/EV1kVd1YYTLe
         xN8Kh/BTX7ISFbZh77SFc5iFk6gMHJlWa9fQ03fXTIlAhRhImbqpxtOMx/K6wdNMg5im
         PsEOst0dX8B0FgL0TySFVpZkv0p47fTZ7K9LncCYlEpbhjCILuoa6+xjUBTuWzY9NmqN
         T+/ypsPRAJFN3BIHnA10tUxARjv42+R+T1sWEe8BAr0MnND26ko935+eMk2RdcZ/QYnv
         CwaLJ52mjsNU6OouTz7kTHyi7DiFyOqXKmcxudZVasCSs0BoHE4zfaY867QpFDJCzM8J
         fvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699499342; x=1700104142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm2K3rsZVkBARWD83CScKZj3mi6JLbGspKfGu8tGAo0=;
        b=ntiXE2R0TmJhzpgT8FdDsnHtcF0Jyqh2LtGnGGFldQqETpVgy3d8aGCoCQeg/IGKDd
         5qJtpiRSlkFJgPFA7ZcIBpcXcB68PTzo8+QwrdEsNHWmfrE12T8PBpipGx0rclKgZXR/
         +4nQHTryFMBFG3PnV0G1KR1nlHDrtxBFeCULLBBFhFi1xvjOqKyARi9LEvztzhMsbPRd
         uWCosswO7qP+gpWkfyWmRVqccjGjPHUgY/WGEzcRB2uJuTiSSLKOgMXsowyawuWRPmGe
         X3QTxzLlgRp5s9W/z+FpscMuK6+UQBC01rAt73seghzX2BeYU1UF0oqInBrh+57Ctje3
         G+9Q==
X-Gm-Message-State: AOJu0Yy/TVG9nas/oL5tIelUHXFXvmCRzsnZ4i4KS4DKGyZ8sOtjl2l+
        oLNJJyNREgHA/wo/q6k3Ob3YRoLwM0c17ValNhY=
X-Google-Smtp-Source: AGHT+IEs1xKUjGfuAvj54SEziWA66fE65fl1xhY3ldsYrxOi51MgEw2rd2WrRqrWEH1WysLGgBl6ej9/UZ+7M9AxJ6o=
X-Received: by 2002:a6b:5915:0:b0:7a9:b1c9:665a with SMTP id
 n21-20020a6b5915000000b007a9b1c9665amr522951iob.6.1699499341812; Wed, 08 Nov
 2023 19:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20231102234236.1784543-1-nphamcs@gmail.com> <CAJD7tkapfHVvF1KCm4iUDWGP0n5zV3GBcNAGDiYNHrpuODPPqQ@mail.gmail.com>
 <CAKEwX=MunYMKQXsV58vBXROKnJFDhViCpQgC7RnrLExa_U=n2g@mail.gmail.com> <CAF8kJuPgWjim82+HmEgkkWrDNwi2co-3ay-35fjoLb8-k9rNXQ@mail.gmail.com>
In-Reply-To: <CAF8kJuPgWjim82+HmEgkkWrDNwi2co-3ay-35fjoLb8-k9rNXQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 8 Nov 2023 19:08:50 -0800
Message-ID: <CAKEwX=Pvf4wj6HrtFvqgWQghsAmOpYnU=1S3b0iMePBQdP_i7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 6:41=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhant,
>
> On Fri, Nov 3, 2023 at 12:24=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > >
> > > Would it be more convenient if the initial value is inherited from th=
e
> > > parent (the root starts with true)?
> > >
> > > I can see this being useful if we want to set it to false on the
> > > entire machine or one a parent cgroup, we can set it before creating
> > > any children instead of setting it to 0 every time we create a new
> > > cgroup.
> >
> > I'm not 100% sure about the benefit or have a strong opinion one way
> > or another, but this sounds like a nice-to-have detail to me, and a rel=
atively
> > low cost one (both in effort and at runtime) at that too.
> >
> > Propagating the change everytime we modify the memory.zswap.writeback
> > value of the ancestor might be data race-prone (and costly, depending o=
n
> > how big the cgroup subtree is), but this is just a one-time-per-cgroup
> > propagation (at the new cgroup creation time).
>
> I think Yosary was suggesting inheriting the initial value from
> parents. That is just one level look up when you create the new
> cgroup, using the parent value as default. No recursive.
> What you described above seems different to me. I understand what you
> are suggesting is that writing to the parent cgroup will recursively
> write to all child cgroup.
> >
> > Can anyone come up with a failure case for this change, or why it might=
 be
> > a bad idea?
>
> I would suggest against recursive changing value behavior.
> What if you want the parent but also want the child to keep its value
> not changed? Every change to the parent will have to go through the
> child to flip it back.
> Inherit from the parent seems fine.
>
> Chris

Hi Chris,

I've actually sent out a new version of the patch series implementing
(what I believed to be) Yosry's suggestion. Feel free to take a look!

https://lore.kernel.org/all/20231106231158.380730-1-nphamcs@gmail.com/

Here, I was actually agreeing with you - recursive propagation would
not be a good idea.

Best,
Nhat
