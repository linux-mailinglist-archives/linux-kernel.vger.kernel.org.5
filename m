Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B207FC194
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345044AbjK1Q6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjK1Q6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:58:52 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072DD6;
        Tue, 28 Nov 2023 08:58:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b34c5d7ecdso207893539f.0;
        Tue, 28 Nov 2023 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190738; x=1701795538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fI/LznoECWCqcF0gUCTmOAEWgm3bqBRaqsoNP6NJb0=;
        b=YvLWilmzQsaW2jRY1xeZ/WOZF4rqXq7SLpyW9iD4htL5d2Zu98YcjsWprbzRJawKWN
         4UVTEsH6N3gsob3hUFlHGqo4oOxMBJ3bcyCZqR/yswAmyxtyCLr1eA/MshAL3tTrq/VI
         VY3/UhGFSc3XvSpMrsXLQ9SNOFN/iGi/PuJZb59I2cFbUj5WoCaNEUUIul8X3z8TWLqi
         KbAz7jXSBVaAO/V/v5LC1saKUuXhCsJi0/RFEZKVwkp47CbRiupkCfO52O5vT/CFXH2O
         PFGxlLWsklWCud8FjvUwPgC7hllQo3mnQWVgc8pyqMXV2l0dzyp69UYLr9xYQU737ai9
         aUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190738; x=1701795538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fI/LznoECWCqcF0gUCTmOAEWgm3bqBRaqsoNP6NJb0=;
        b=l9qmxeGifIBhft6s/wgIP5B7LPyq02vvT8Eaj97L7DCNixfnpxZakxZ/Y9VtDseczF
         Wa6iw6GgoEvjTuNXKeGA+mJBfFmGRN8djDlUuhqrepHko+VBvomNTECmYy2s45y1lWnn
         AJK2sMZ5CFcS9Zz7UNAC3QVKaNWdpHAQ6/9RTN3SvHkbJbOLCO/Vjr9/aBNE6u2EEqHR
         O30hWJx12ps9WGg3gSKhowps4xldGPPMZpqoVVtZXFfZ86Z5sAsc26X1HBlIbiBi1Sn2
         dh+Q76A7sR2gpATv9cHRAMY6j5XRc9pZ+hXVKDXEUloAGZGFKCOJeGDuYHy6D9Z39xoS
         xuCg==
X-Gm-Message-State: AOJu0YxVyaZuPvlg8OdVnqLz2o1gZg/yoH3mAPzEfodFf+IoIyJvIauJ
        0MT+INnmbIrbQjjrUKLquPhMfCttNs8IDS9GpIM=
X-Google-Smtp-Source: AGHT+IHnsz1sdC0tq9NnxI0ceiNpHLvCP/gAZY/typAxLv95pCgArj+vZFNUBd3rEY5RkZ9BfVXhaODco8rR03ngRmQ=
X-Received: by 2002:a6b:6d18:0:b0:79f:99b6:63 with SMTP id a24-20020a6b6d18000000b0079f99b60063mr13394697iod.9.1701190738383;
 Tue, 28 Nov 2023 08:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20231127193703.1980089-1-nphamcs@gmail.com> <20231127193703.1980089-3-nphamcs@gmail.com>
 <ZWW1IG0Mv3r0m4mp@tiehlicka> <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
In-Reply-To: <CAKEwX=OGtkqWys9VM9EBScoCdAjSdfPjEkvoY7_u9udDZBFFpw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 28 Nov 2023 08:58:47 -0800
Message-ID: <CAKEwX=PnjGwSCceZw5H_hPUx9cxAqoUVw2QnAX=q3wVbHTpeAQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] memcontrol: allows mem_cgroup_iter() to check for onlineness
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Tue, Nov 28, 2023 at 8:53=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Nov 28, 2023 at 1:38=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Mon 27-11-23 11:36:59, Nhat Pham wrote:
> > > The new zswap writeback scheme requires an online-only memcg hierarch=
y
> > > traversal. Add a new parameter to mem_cgroup_iter() to check for
> > > onlineness before returning.
> >
> > Why is this needed?
>
> For context, in patch 3 of this series, Domenico and I are adding
> cgroup-aware LRU to zswap, so that we can perform workload-specific
> zswap writeback. When the reclaim happens due to the global zswap
> limit being hit, a cgroup is selected by the mem_cgroup_iter(), and
> the last one selected is saved in the zswap pool (so that the
> iteration can follow from there next time the limit is hit).
>
> However, one problem with this scheme is we will be pinning the
> reference to that saved memcg until the next global reclaim attempt,
> which could prevent it from being killed for quite some time after it
> has been offlined. Johannes, Yosry, and I discussed a couple of
> approaches for a while, and decided to add a callback that would
> release the reference held by the zswap pool when the memcg is
> offlined, and the zswap pool will obtain the reference to the next
> online memcg in the traversal (or at least one that has not had the
> zswap-memcg-release-callback run on it yet).

I forgot to add, but as Andrew had pointed out, this is quite a niche
use case (well only zswap is using it specifically). So I have decided
to keep the original behavior for mem_cgroup_iter(), and added a
special mem_cgroup_iter_online() that does this. All the current
mem_cgroup_iter() users should not see any change. This is already in
v7 of this patch series:

https://lore.kernel.org/linux-mm/20231127234600.2971029-3-nphamcs@gmail.com=
/




>
> > --
> > Michal Hocko
> > SUSE Labs
