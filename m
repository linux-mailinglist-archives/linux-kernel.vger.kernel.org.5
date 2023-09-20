Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD47A8875
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjITPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjITPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:33:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E17C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:32:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c4084803f1so204255ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695223974; x=1695828774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdCXdOQ9nj5NwvgTMa99A9hiNmoB51uuqq4nZAsFZLE=;
        b=FeTZkTZdgdvRK/xj3j8MB8V24yzekAdGAfDIc57WwHHWJtL3W7ujOaZz9TIiYqNEX6
         opM/R5craN7khWrPzDeWrDtxfR0sEIur51bhztTqX6ck3MX/E9HSYP0riSgtBo1zRQ/9
         ehDXpuJaJ8oNZEHp3znugADCSEUpUqShQFGT25D7Sy1TaiUyXTXIG/ZGF0pgas/b33K1
         tKbVJpBJXCZd5vkOXdygxjGwaL/f59Yh0D/dpXhPrZJoq8A6NljIij1Bial6N5zPDccF
         Druib8Qz9qiSGugOHDY48kKjx55p1kR7H2QPBJVf2aU5U+aeUbnmzaRJQGPEtef0dOJI
         Zd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223974; x=1695828774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdCXdOQ9nj5NwvgTMa99A9hiNmoB51uuqq4nZAsFZLE=;
        b=i8PgkY0dXp1B+wmLd9U8xlp+TxZ4mWcreteo8de3X95Uz5OKPltpMS2HICsYUKNYmp
         O5pxGSQ/2VD0I4s1pCNwdUjQQA50EXkWyNHJfgL//cke2QkguEeB0Tj2Ou+dcGbUwksY
         4ne6MNd/9hm6IAoaIap8AP/8CXwTskYiCOhZgWVHPSMYHsaM6SNtiOYCZma5jgJ6COEq
         NT8M6HWx4WTnsqkdBKiyAJLsiyzD6DX/StHfDRR8FunLBvdKzPfjGqJpAI7hCTxR/wMT
         oBgCFmjBFgjxt39FHAvMGW5+jp3XsSdtxQS/JvLkhNTb47m+uAVY0PwDmllEp+mrEUT2
         fgtQ==
X-Gm-Message-State: AOJu0YxFpaSaxxGmtQevxI0N1GuV7N3U2vqhpqD8VvuwSm2k/eejPYCP
        3TOwsD6HQMK7adbA50jRWQn9LvnclDbJxy0W6oq2EQ==
X-Google-Smtp-Source: AGHT+IG7jHv9mEJ9vDwu2rKaq8OA4qZgGZVHORBp0NC00eAtSWOs7zP67eILIjgFXrRNttx39BoMwKPfmWcjEmZ73Bs=
X-Received: by 2002:a17:903:41c7:b0:1c4:21fe:2823 with SMTP id
 u7-20020a17090341c700b001c421fe2823mr181043ple.13.1695223974038; Wed, 20 Sep
 2023 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191040.964416434@linuxfoundation.org> <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz> <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz> <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
 <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
In-Reply-To: <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Sep 2023 08:32:42 -0700
Message-ID: <CALvZod7E_Jm9y+40OKtLs5EFA0ptKGjoe2BU58SY29pUiPc93g@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop kmem.limit_in_bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 6:47=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 20-09-23 15:25:23, Jeremi Piotrowski wrote:
> > On 9/20/2023 1:07 PM, Michal Hocko wrote:
> [...]
> > > I mean, normally I would be just fine reverting this API change becau=
se
> > > it is disruptive but the only way to have the file available and not
> > > break somebody is to revert 58056f77502f ("memcg, kmem: further
> > > deprecate kmem.limit_in_bytes") as well. Or to ignore any value writt=
en
> > > there but that sounds rather dubious. Although one could argue this
> > > would mimic nokmem kernel option.
> > >
> >
> > I just want to make sure we don't introduce yet another new behavior in=
 this legacy
> > system. I have not seen breakage due to 58056f77502f. Mimicing nokmem s=
ounds good but
> > does this mean "don't enforce limits" (that should be fine) or "ignore =
writes to the limit"
> > (=3Ddon't event store the written limit). The latter might have uninten=
ded consequences.
>
> Yes it would mean that the limit is never enforced. Bad as it is the
> thing is that the hard limit on kernel memory is broken by design and
> unfixable.  This causes all sorts of unexpected kernel allocation
> failures that this is simply unsafe to use.
>
> All that being said I can see the following options
> 1) keep the current upstream status and not export the file
> 2) revert both 58056f77502f and 86327e8eb94 and make it clear
>    that kmem.limit_in_bytes is unsupported so failures or misbehavior
>    as a result of the limit being hit are likely not going to be
>    investigated or fixed.
> 3) reverting like in 2) but never inforce the limit (so basically nokmem
>    semantic)
>
> Shakeel, Johannes, Roman, Muchun Song what do you think?

I think the safe option would be to revert 86327e8eb94 for now and put
pr_warn_once even for the read of kmem.limit_in_bytes? We can retry
86327e8eb94 in a year or so.

However personally I would prefer option 1. Also I don't think
reverting  58056f77502f would give any benefit.
