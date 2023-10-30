Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E17DB24B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 04:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjJ3Dea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 23:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3De1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 23:34:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045897
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:34:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507ad511315so5806609e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698636863; x=1699241663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGS4hNCMCGzlmos7YQoGqMipr4zcr59AwUfz4i9isKs=;
        b=lgQg8hy8VcC5SDgENxGApCWjtSwcas/rnSmRYhovuysMROytW2bJOGMLYbGzsInzHI
         U3qZlNxCrIJ1yWAMkhxTyXA/82n4ywu9p01BZaxp9zfVBRxwKSujikiSULLLCSQZIkrK
         wRiI8sZhEt10IbtQghas6RcvvT/dSsHXASWyOSKG/DBHnX35CswxzhxmXQ6O4uw19JUY
         Dj5FGOdCzWi10k9zX++1BmilbDeRLTe7HjG6LcGHNLXuI/PY/gRsrr+8i9PoV7e5FR5l
         BunzF5CHPVYf0tI0iNU3P2QzrHpjzyHhPnuIe++VeELnsEzSouVwwxGelImu+nnOJawY
         OziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698636863; x=1699241663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGS4hNCMCGzlmos7YQoGqMipr4zcr59AwUfz4i9isKs=;
        b=oO6kElM/0UtBXz200RroTUghd5e8UcgnOhYaOdogx4eU3uBYJsFbR6R7rYfvvXn9Ae
         bq1jf2gJ6Gm5iQvjfxwEmIK4fmPg2zK7R9tr7OPoYQSU0rN3K4fyWWeyNtqAOf9nJDU/
         5tDwbzdZaMG6KMQqWULLszNApa5z1+105hOxt2jL4R48i1JBzmcUgKmKA02/c/I6Zxzd
         FpVijovp++GcCMuJaCOXjRyIgDYRgfiVeZlt5S+RoPJVByPwj4/V1IvRG7wAzRGpH44b
         PRLB9zkI4z8UkTeG6IfMT9qszNQWz34Ts+/gtuuSC0FbtH6+LbR9u61DFX0nHyBGeetG
         cZdg==
X-Gm-Message-State: AOJu0YxwIwZjd04bWoCi2MJPY8EtQR5B19IoZKQKqtp4WaNHe0/AzhQw
        oMdjX6FwHg+3fvZzgq5i81iyeB2zFgm/iCR/+SmNTw==
X-Google-Smtp-Source: AGHT+IHDk0ZTQwDTQgg/afhMScBDrQXQzC/zS5Jz4d5p7lDgec2dt8Qrsdi+0/JMMaupJKq1ZCybuQW1Ygh6bb9ELHc=
X-Received: by 2002:a05:6512:2244:b0:500:9a45:62f with SMTP id
 i4-20020a056512224400b005009a45062fmr8329638lfu.8.1698636862700; Sun, 29 Oct
 2023 20:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231025095248.458789-1-hezhongkun.hzk@bytedance.com> <CAKEwX=P+c3kSKx3Ptz2PxHJfGGxyV5uO8gK41kDjkYV9ytcP6w@mail.gmail.com>
In-Reply-To: <CAKEwX=P+c3kSKx3Ptz2PxHJfGGxyV5uO8gK41kDjkYV9ytcP6w@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Mon, 30 Oct 2023 11:34:11 +0800
Message-ID: <CACSyD1MxxhAGFQL4aq7DKNdROdtOs1Mj6R-EsxbPfr=JdVEzeg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] zswap: add writeback_time_threshold
 interface to shrink zswap pool
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Nhat=EF=BC=8C thanks for your time.

> My original concern with this approach (i.e regarding what value should b=
e
> used, and how frequent should userspace trigger this time-based writeback
> mechanism) still stands.
>
> If I'm a user of this feature, how would I figure out how long should an =
object
> lie dormant in the zswap pool before it is highly likely to be a cold obj=
ect?
> Users have no clue what the access time stats look like, what is its
> distribution,
> etc., and will have to somehow guesstimate this based purely on their kno=
wledge
> of the program's memory access patterns (which, in many cases, are intent=
ionally
> abstracted away).
>
> It's rather hard for users to know what value of cutoff makes sense, with=
out
> extensive experiments on a realistic workload.

I understand your concern, and it is indeed a problem. There are
currently too few
contexts in which this feature is used, and determining the threshold
is very difficult.
So I have a new idea to show the lie dormant time distribution through
a new patch,
as you mentioned above.Based on this time distribution, users can make bett=
er
choices.

>
> If I may ask, how do you use this feature internally? You don't have to
> reveal any NDA-breaking details of course, but just a rough idea of
> the kind of procedure to determine sensible threshold values will
> help your case and the future user of this feature a lot.
>

As you mentioned, we decide this threshold based on the knowledge of the
program's memory access patterns and the multiple test results for differen=
t
business models=EF=BC=8Cjust an experience value.
So  the patch to show the lie dormant time distribution should be valuable.

>
> nit: looks there's a double space between time and will?
>

Oh, got it, thanks.

> > +
> > +          The zswap can be swapout and save memory in userspace proact=
ively
> > +          by writing writeback_time_threshold in second.
>
> I think we should include a bit more details in this config option descri=
ption.
> Feel free to just recycle details from the commit log of course, but at l=
east
> there should be something along the line of:
>
> When this is selected, users can proactively trigger writebacks by writin=
g a
> value to the writeback_time_threshold file. The pages whose last access t=
ime
> is older than this value will be written back.
>
> (please beautify that paragraph if you use it).
>

Thanks  a lot for your description. I will add it.

>
> Do you have any experimental results/benchmarks that show
> the wins from this approach?

OK,  Add it for next time.
>
> Writing back cold pages from zswap is a good idea from a
> theoretical and philosophical POV, but all sort of things could go
> wrong, especially if we write pages that turn out to be needed
> later on. Some experimental results would be nice.

Thanks, i will add a new patch to show the last acccesed time distribution
and add experimental results.
