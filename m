Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E480783A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378762AbjLFS5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjLFS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:57:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E88F135
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:57:07 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso1438015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701889025; x=1702493825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziRU2FnN4POMxpTQvqS7/l9aFbYDIfKx6N/Y5jodgA8=;
        b=YFGSboD2WDgQZSZ9kt55DiEtbQCu3KBwgvwIbSeLMzQRBp3BW39D6NzEu2uzta3h82
         371YptCROA6BFj04+OycpHJs2sM5LAkes8C2c+64C+zOMXgsqOawnokxd+157VnIlbCe
         8Qg/KdtXHK4bBI23P+1Zy5rSP+5yBrRfdFWY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889025; x=1702493825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziRU2FnN4POMxpTQvqS7/l9aFbYDIfKx6N/Y5jodgA8=;
        b=Y+FRI8J2rZXnbvE8biG75mITD7KnZ3ukKXF0cm2j9Qjt+5QNx8MdQ3ojkZr6uCA1gy
         lvImw6TKFhNJ/BEPisGwB52N8yqZjN56XV8ngGL/7wOmpZ9CbH5uLdxzv9lYiDtH858D
         8StZ3AEGDLFRQskDlFxeBBi8VHOQAmj9kKPyCpjYIPA0qSQYN+H4L/fvaLxNQkeHaFl9
         NYd1p7ufPzA6vcQXgNzrJcRqinMxl+0Zn7gCEak4U7wLkGoOkZCVfn+jMi1q3t4J4SEb
         gCe/Un3KcxqtBNdhFk2tWtwyy79Eo/XUF7qkp7bahIPsthlTYqcZYfpaptLudI+k+Hur
         Xt7A==
X-Gm-Message-State: AOJu0Yxkcr3LSXXUSZcxdFxj6UZlKAO4opNV87SlcPit01UAUfpbv2P8
        Sb+iylibi9OBdheIDAcNuHM8lxUjx6VO99F5RZGoV0MV
X-Google-Smtp-Source: AGHT+IE9FOeFsYz/ziUbZBq+Qy8tZeSNrxgsQ6ikIqUKQy0uTldhiWi2jb1aFozlRML2GRY9wMVPKw==
X-Received: by 2002:a05:600c:190e:b0:408:37aa:4766 with SMTP id j14-20020a05600c190e00b0040837aa4766mr977720wmq.5.1701889025704;
        Wed, 06 Dec 2023 10:57:05 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709066bca00b00a1dc4307ecfsm283573ejs.188.2023.12.06.10.57.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 10:57:05 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso1227a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:57:05 -0800 (PST)
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr125503edc.6.1701888584617; Wed, 06 Dec
 2023 10:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
 <20231206093917.04fd57b5@hermes.local> <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
In-Reply-To: <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Dec 2023 10:49:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Message-ID: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     David Ahern <dsahern@kernel.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 6, 2023 at 9:51=E2=80=AFAM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/6/23 10:39 AM, Stephen Hemminger wrote:
> > On Wed,  6 Dec 2023 03:38:33 +0000
> > Judy Hsiao <judyhsiao@chromium.org> wrote:
> >
> >> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> >> index df81c1f0a570..552719c3bbc3 100644
> >> --- a/net/core/neighbour.c
> >> +++ b/net/core/neighbour.c
> >> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tb=
l)
> >>  {
> >>      int max_clean =3D atomic_read(&tbl->gc_entries) -
> >>                      READ_ONCE(tbl->gc_thresh2);
> >> +    u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> >>      unsigned long tref =3D jiffies - 5 * HZ;
> >>      struct neighbour *n, *tmp;
> >>      int shrunk =3D 0;
> >> +    int loop =3D 0;
> >>
> >>      NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
> >>
> >> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *t=
bl)
> >>                              shrunk++;
> >>                      if (shrunk >=3D max_clean)
> >>                              break;
> >> +                    if (++loop =3D=3D 16) {
> >
> > Overall looks good.
> > Minor comments:
> >       - loop count should probably be unsigned
> >         - the magic constant 16 should be a sysctl tuneable
>
> A tunable is needed here; the loop counter is just to keep the overhead
> of the ktime_get_ns call in check.

From context, I'm going to assume you meant a tunable is _NOT_ needed here.=
 ;-)

-Doug
