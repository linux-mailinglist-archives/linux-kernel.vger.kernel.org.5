Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA47F0869
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjKSTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:08:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC0F2;
        Sun, 19 Nov 2023 11:08:52 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a93b7fedb8so118728539f.3;
        Sun, 19 Nov 2023 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700420932; x=1701025732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQzML+5J+6LxzG9Fex5fRKa0VePfb5Ddx26BaYmrHCA=;
        b=PZvhQO1NHKeMwZsF5gZZTrCOtkpAWUAOtJ9ueIvVjR2KWg7+NZ+yCedcS81lbq9xNC
         jnzkY9ZcQ887o609P8J+9EZH+/XwNWjMR+DJV4d3CBix398tvNeI+dk7tsWfWK0sLDaz
         Z2A6vSqJukQfLUxouoCobzOAXnWijXsYuuUXto6/vYcFIixYmIor408lXWW3/KfjvAxj
         ezefHuPQdNHPwrs+/2rUUaUn8wWbAqvn+ETL0QBORDVvpiGTTmKhWIpsYm2KldOdN7S0
         2qJQ+TP1RRocCAEHTyAWTavU6Ht6aIf/c6WWlK8wkxt9rl2iXv1kgrRtushMiY1QoL57
         Cv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700420932; x=1701025732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQzML+5J+6LxzG9Fex5fRKa0VePfb5Ddx26BaYmrHCA=;
        b=SniWhIwskc+DTLO0xmKeZz9jLTGA11YCe9LlxEbUnWYKMpVpNXEMsTij5883bw4vR7
         Q2gFrsLyTM0hq4yJSZ9TaKxdssVSpcxM76LMSOLR0PqSVonXO7Uh/jYwPQ9E/3a17cyu
         lOFvA8y3BaGZAu6+GCbIqXTl2xHmfLztyUwtHoRkWDZvbUmXpIsmnK4rlSOECSZJD7h3
         pL1AwL1FLKpR1j9n8z2yyukvt+UPmHEaQH3c7ME21vdFbOh6gjmRfg0D9K61AkjJc6Ro
         3tqYNLHUuZNZMNnXp7F7krwWfaOFGiy7qrWNTv6iVhwwoV9siCrq14bTf4QT+1bwatmc
         jodw==
X-Gm-Message-State: AOJu0YwNuk9MlgwtwaZ9lLvoLByeqN6fWXukYBWu7BLXNNMJSSfQ16Ju
        /ACrTwR+ySu7raKc1EWL9YcRw+9rCMyQFTjvvDM=
X-Google-Smtp-Source: AGHT+IEsxXc8j1vNk2wzUhI2MwkVl4JoRBQMiCHSc/SRo54/BdSmwA+l73Tw54qMmS39qO6iTVlV75vgZVtQ8tcv5b0=
X-Received: by 2002:a05:6602:3145:b0:7a2:dee5:84b6 with SMTP id
 m5-20020a056602314500b007a2dee584b6mr5948252ioy.21.1700420932030; Sun, 19 Nov
 2023 11:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
 <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
 <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com> <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
In-Reply-To: <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sun, 19 Nov 2023 11:08:40 -0800
Message-ID: <CAKEwX=NdFjemcmf27PVpgHpVHWQEo19KfApepWJBRYeyVCWvCw@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, Hugh Dickins <hughd@google.com>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 1:39=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Sat, Nov 18, 2023 at 11:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
> > Hmm how about this - in the future, we support the following
> > options:
> >
> > 1. zswap.writeback =3D=3D 1: no limitation to zswap writeback.
> > All backing swap devices (sorted by priorities?) are fair game.
> >
> > 2. zswap.writeback =3D=3D 0: disable all forms of zswap writeback.
> >
> > 3. zswap.writeback =3D=3D <tiers description>:  attempt to write to eac=
h
> > tier, one at a time.
>
> We can merge the zswap.writeback as it is for now to unblock you.
>
> For the future. I think we should remove zswap.writeback completely.

I'm a bit weary about API changes, especially changes that affect
backward compatibility. Breaking existing userspace programs simply
with a kernel upgrade does not sound very nice to me.

(although I've heard that the eventual plan is to deprecate cgroupv1
- not sure how that is gonna proceed).

Hence my attempt at creating something that can both serve the
current use case, while still remaining (fairly) extensible for future
ideas.

>
> Instead we have:
>
> swap.tiers =3D=3D <swap_tier_list_name>
> swap.tiers =3D=3D "all" all available swap tiers. "zswap + swap file".
> This is the default.
> swap.tiers =3D=3D "zswap" zswap only, no other swap file. Internally set
> zswap.writeback =3D 0
> swap.tiers =3D=3D "foo" foo is a list of swap devices it can use. You can
> define your town custom swap tier list in
> swap.tiers =3D=3D "none" or "disabled" Not allowed to swap.

swap.tiers =3D=3D "none" or "disabled" means disallowing zswap as
well, correct?

>
> "all", "zswap", "none" are reserved keywords.
> "foo", "bar" etc are custom lists of swap tiers. User define custom
> tier list in sys/kernel/mm/swap/tiers:
> ssd:zswap,/dev/nvme01p4
> hdd:/dev/sda4,/dev/sdb4

I don't have any major argument against this. It just seems a bit
heavyweight for what we need at the moment (only disabling
swap-to-disk usage).

I'll let other people weigh in about this of course.
Johannes, how do you feel about this proposed API?

>
> That would define two custom tiers. "ssd" can use zswap then /dev/nvme01p=
4.
> The exact name of the "swap.tiers" and tiers name are open to suggestions=
.
>
> >
> > The first two are basically what we have for this patch.
> > The last one will be added in a future patch.
> >
> > This is from the userspace perspective. Internally, we can modify
> > memcg->writeback to be a pointer or a struct instead of this bool.
> > (as you suggested).
>
> Internally I would suggest memcg->swaptiers, the write back name is
> somewhat confusing. As your patch indicated. It has two situation:
> 1. shrinking from zpool to real swapfile. The write back is appropriate h=
ere.
>  2. zswap store failed (compression ratio too low, out of memory etc).
> The write back is confusing here. It is more like writing through or
> skip.
>
> >
> > This way, the API remains intact and backward compatible
> > (and FWIW, I think there are still a lot of values in having simple
> > options for the users who have simple memory hierarchies).
>
> swap.tiers can be simple. For example, you can modify your patch to
> "swap.tires =3D=3D zswap" to
> set zswap.writeback bool to 0 for now. Most of your patch is still re-usa=
ble.
>

I'm less concerned about internals - that is always up to changes.
I'm a bit more concerned with the API we're exposing to the users.

> I think we should discuss if we want to keep zswap.writeback in the
> future because that would be some code undeletable and functionally
> overlap with swap.tiers

This is a fair point.

>
> Chris
