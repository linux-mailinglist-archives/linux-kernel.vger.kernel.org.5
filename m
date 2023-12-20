Return-Path: <linux-kernel+bounces-6736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31702819CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53651F2A892
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B8A21102;
	Wed, 20 Dec 2023 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCNyA3Bc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C46210F6;
	Wed, 20 Dec 2023 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc95f1102eso515821fa.1;
        Wed, 20 Dec 2023 02:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703067756; x=1703672556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRmWXSIwM0XGZafsEN4uRYb9SZntd9nJS61bvL/+JvY=;
        b=CCNyA3BcpcUohdD59/0McAAK1boyzBPoN77VXIX5eRSqE60EXw4jh7JsQIDz0ON06M
         qL4t2XkchH4vY3a3h9zLBr3fYJeQMVaJ9NRA87cu9Gtb0oUcUu1LuBqW8kYSf+8KjmF9
         NVVcIMfClTZbKBjnD5Mqz2QoeEGjGXTjJ8/eLYL70RGSnjjUuUhIPhv2SLeh09JH2tDx
         +WiCDVnC/WczKw0y7GdRFyCHY2LTZgUzL43tV+4oGeGMSa5QXgJMSU1+2mR+Me4+UzU0
         j4st2DFIkFvkB7NXswKe53ygdpb0fV61nio4695CH1J46LWRYwC/P24GOLC3EpMYP2uc
         wT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067756; x=1703672556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRmWXSIwM0XGZafsEN4uRYb9SZntd9nJS61bvL/+JvY=;
        b=EACEIbF+kXZ6zu6XQ8EYjSv4LRgdHqsoA5rt4DuRsggzaBjaS6kSxAF+2L1wuwEONN
         HJ3Buc6XljZVzhjqwJ863wfDQZnmGdAiN0u4g3Tj2ldFk0anRyb1bcCaVkJtSwVbNacL
         /NGr8fhcuKYyTGlvQe7YrQBca2KL7z3if/fTpbZ9LuvHBv/4z6i9thA0Y8D3EYGyTJz8
         q97rGddrlFxchiZG7QKATJ1IzW1/QTKxk0n8MfLfyFmu/MYdDT5mQ/Ln4as4QsjeIUnG
         cZQ1iiu3OsNppdaIkMvWnSFKxZ9sYZgFUrZqCI1CLsRDkhycoKwxK2NSMt1syyzq1Hmt
         p69A==
X-Gm-Message-State: AOJu0YypJfmKyMCYfecd0h7oA6tH9IQeazD9OtdxIWIkdfyrzniqhQop
	VFyccw+zA8be2w2ZAEqEMV3G1YRB3Rhiuk26Vb8=
X-Google-Smtp-Source: AGHT+IFY1slTVVLg/kbuaZtj7R0eekl2SVbWCQXZ6Kx7su0RuehkbtHINgeFQCz4RTm8+g5CORjNhBOlmQuMg07uytE=
X-Received: by 2002:a2e:9683:0:b0:2cc:68c6:305 with SMTP id
 q3-20020a2e9683000000b002cc68c60305mr2078790lji.81.1703067755538; Wed, 20 Dec
 2023 02:22:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com> <CAF8kJuNzFcBRW=2CbgG=seA=CNgyzD8DNXNY02uy0HUsLbg9JQ@mail.gmail.com>
In-Reply-To: <CAF8kJuNzFcBRW=2CbgG=seA=CNgyzD8DNXNY02uy0HUsLbg9JQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 20 Dec 2023 18:22:17 +0800
Message-ID: <CAMgjq7A8MLxvON9EVrKPqurdw2Ozq-JcPnk4c5jB3c5F-vOLvw@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Chris Li <chrisl@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, yosryahmed@google.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, hughd@google.com, corbet@lwn.net, 
	konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, david@ixit.cz, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=89 07:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Minchan,
>
> On Mon, Dec 11, 2023 at 2:55=E2=80=AFPM Minchan Kim <minchan@kernel.org> =
wrote:
>
> > > > 3) Android has some fancy swap ideas led by those patches.
> > > > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@k=
ernel.org/
> > > > It got shot down due to removal of frontswap. But the usage case an=
d
> > > > product requirement is there.
> > > > +Minchan
> > >
> > > This looks like an optimization for zram to bypass the block layer an=
d
> > > hook directly into the swap code. Correct me if I'm wrong, but this
> > > doesn't appear to have anything to do with per-cgroup backend control=
.
> >
> > Hi Johannes,
> >
> > I haven't been following the thread closely, but I noticed the discussi=
on
> > about potential use cases for zram with memcg.
> >
> > One interesting idea I have is to implement a swap controller per cgrou=
p.
> > This would allow us to tailor the zram swap behavior to the specific ne=
eds of
> > different groups.
> >
> > For example, Group A, which is sensitive to swap latency, could use zra=
m swap
> > with a fast compression setting, even if it sacrifices some compression=
 ratio.
> > This would prioritize quick access to swapped data, even if it takes up=
 more space.
> >
> > On the other hand, Group B, which can tolerate higher swap latency, cou=
ld benefit
> > from a slower compression setting that achieves a higher compression ra=
tio.
> > This would maximize memory efficiency at the cost of slightly slower da=
ta access.
>
> That is a very solid usage case. Thanks for sharing this swap backend
> usage story. It goes beyond my original memory.swap.teires idea as
> well.
>
> We can have some zram specific knobs to control what compression
> setting is using. Moving data between different compression settings
> would be an interesting topic. It might fit the swap.tiers usage model
> as well. I am just thinking it out loud. Maybe define different
> compression settings as different tiers and then allow the cgroup to
> enroll into one of the tiers list.
>

This is very similar to our usage, easy to implement too. Actually,
now ZRAM already supports multiple compression streams, so if each
memcg just provides an extra knob to record the compression level
(1-4), ZRAM can decide which compression stream to use when the page
reaches ZRAM, just by checking pages memcg. It's limited to 4 levels
but enough for most cases.

