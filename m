Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB618042B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjLDXk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjLDXk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:40:27 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C615102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:40:33 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so22594961fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701733231; x=1702338031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cb3BI/rsKzc7Vb5XxK5mF0t710SsUEXm0jO9+FTts=;
        b=dWXZXzFT/LKvykOTuMeODGO1NAVXOhunKmpek1b+333GX2iWqTUOWhZGjxgd35oeoZ
         0M2RCMbZSQVDMwGBJh9S8auR0jEZhbMFa/SS8jS4///qGwbjzaDXIAXG/x5B+xKvFXxY
         IudhTDHj+rRgW3eEaF084e+cfsotQkiI8fafk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733231; x=1702338031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8cb3BI/rsKzc7Vb5XxK5mF0t710SsUEXm0jO9+FTts=;
        b=U9y3yvn35iF8xoPoYzcs9+W/kg6n3iTR3tM4cOnXAwOhl6Q+6Sk0JTrKCq10/RXint
         2O6VMyVBsqLPGrCTRhD88g+dV2707hkpqbf9IESA398PEg+Oc+coioPDa7krrX40r/DJ
         vqgCp0kwZlT1OskEuFXLVkWZM4ucGUJJX41tsjuVY6URHbsTtRyiJHuCIrNoESzn/pfq
         I8NEaifPJdRvCaZelJ0UYJbJ286FyoWzuopN4z42iBhkaGp/jkWQkzNN5PM/dz0137Mc
         XuXQD4E/BLlXrkIAqWBKx/baazT2lNSiUrzSQ8hJZ27ctH3MzT9tfEj7WEvnVVSUFhWC
         yZ2A==
X-Gm-Message-State: AOJu0YxTDq32DhlB2KPjf3SVgz8fNpmP6e1pg6uAhBxJg+9aklqPDjj9
        fTvkJfNq6GNbot0cklll4RpJIeAeKYKrZsgP6upeEWoj
X-Google-Smtp-Source: AGHT+IFlCvQdv8qDwsJ4hagxxNJsjF0Fp8/EouJ4DLB+P10tnrLleC1+PTdfnA+O3VBQ7irH9Hwedg==
X-Received: by 2002:a05:6512:39cc:b0:50b:e4a7:7986 with SMTP id k12-20020a05651239cc00b0050be4a77986mr3019085lfu.124.1701733230767;
        Mon, 04 Dec 2023 15:40:30 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7ce15000000b0054afcab0af2sm329885edv.59.2023.12.04.15.40.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 15:40:30 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so11405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 15:40:30 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:40a:4c7d:f300 with SMTP id
 r18-20020a05600c35d200b0040a4c7df300mr517677wmq.6.1701733229952; Mon, 04 Dec
 2023 15:40:29 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org> <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
In-Reply-To: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 4 Dec 2023 15:40:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
Message-ID: <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Eric Dumazet <edumazet@google.com>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org=
> wrote:
> >
> > We are seeing cases where neigh_cleanup_and_release() is called by
> > neigh_forced_gc() many times in a row with preemption turned off.
> > When running on a low powered CPU at a low CPU frequency, this has
> > been measured to keep preemption off for ~10 ms. That's not great on a
> > system with HZ=3D1000 which expects tasks to be able to schedule in
> > with ~1ms latency.
>
> This will not work in general, because this code runs with BH blocked.
>
> jiffies will stay untouched for many more ms on systems with only one CPU=
.
>
> I would rather not rely on jiffies here but ktime_get_ns() [1]
>
> Also if we break the loop based on time, we might be unable to purge
> the last elements in gc_list.
> We might need to use a second list to make sure to cycle over all
> elements eventually.
>
>
> [1]
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23=
ef09bb4b0db53b4
> 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>  {
>         int max_clean =3D atomic_read(&tbl->gc_entries) -
>                         READ_ONCE(tbl->gc_thresh2);
> +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
>         unsigned long tref =3D jiffies - 5 * HZ;
>         struct neighbour *n, *tmp;
>         int shrunk =3D 0;
> +       int loop =3D 0;
>
>         NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>
> @@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>                         if (shrunk >=3D max_clean)
>                                 break;
>                 }
> +               if (++loop =3D=3D 16) {
> +                       if (ktime_get_ns() > tmax)
> +                               goto unlock;
> +                       loop =3D 0;
> +               }
>         }
>
>         WRITE_ONCE(tbl->last_flush, jiffies);
>
> +unlock:
>         write_unlock_bh(&tbl->lock);

I'm curious what the plan here is. Your patch looks OK to me and I
could give it a weak Reviewed-by, but I don't know the code well
enough to know if we also need to address your second comment that we
need to "use a second list to make sure to cycle over all elements
eventually". Is that something you'd expect to get resolved before
landing?

Thanks! :-)

-Doug
