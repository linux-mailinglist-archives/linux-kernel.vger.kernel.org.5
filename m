Return-Path: <linux-kernel+bounces-2902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC24816402
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CD61C21F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED741FDF;
	Mon, 18 Dec 2023 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atcXSOoJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3F1FA3;
	Mon, 18 Dec 2023 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a233354c74aso187444566b.1;
        Sun, 17 Dec 2023 17:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702862699; x=1703467499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJJJcnW9NIcj4bkD41Zw66nJEJBPkvnjleD0Bm4wmV0=;
        b=atcXSOoJnO1v9LDEBP1YbCBUilwPvzMPi/V8cfDbtplkGVYrjJ7ZwDMBcRajaY/23J
         0Yz42zpNHWpskzu6maXrs8hFdkUjW03+8AlFAnatsAOj3vTwBKMTJISQApjdjathCcFR
         /oUwjZTtAAHhVNBG70CxeU7mBABkOjDUDN+s0s225tGzEtzRKFZUIg+8pvXOIPiK4KSj
         IGyhHO6an+eeixM6sObUBCJhlIxHCR7j0Wq6heWzgku88sDRRYnvZhtHqTtWRsryuGP2
         qRMGabsJvzAaTWZcuG0S2F5N3CksKIhwLLYXHmL2WlBvi8CalGIw2OY4M/6P1FAOkWEX
         vUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862699; x=1703467499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJJJcnW9NIcj4bkD41Zw66nJEJBPkvnjleD0Bm4wmV0=;
        b=STz7ott7itVvbSEDUSQfEt1A7vnt6b+vY2iPSOskI2t2UO5AD37QCWhpU4XhxuE1pr
         0f9zY9zq1mhokp9PSwWi1ou2gGtvyznV1zQNYoG3y9+3dASk1gNScZBaIxS/PoiGsUg5
         Muu96SCzc6C4SSk5LpkToUYJiCWmH3g9HTAAJJu5HKtD389MjoxLzDbG8d/7APRFCZtR
         cFWZ5g/rbP6KsaZFA3A8vZUQ0fIBOIQv4CFplZmGJwIUO1qVQhiSnWXsDEp3EWZ9uZRu
         mZiQQhWTj/CTgEPQKz94KjiZB0Zma/60J9D4J/OrRZId+ojJg9Fb5r4Fsi5P9cXw8Jfj
         8Viw==
X-Gm-Message-State: AOJu0YxS91dgIiNtZCmSylOtYE2qR/weud4SlxdxbEM/zjo9W7KsJAKz
	Dlc+pC18hS0Iwd+wwJZUVUVz41mwR0mfMTMZc0M=
X-Google-Smtp-Source: AGHT+IHbg0CMMmZq/61mfQueTu6x41ayxb++hfJoDxIAB3Ftw962nG0mh1/NajwLubZfxcdjXMLfo0JEK2QKbhvP/pM=
X-Received: by 2002:a17:907:280f:b0:a1f:4d21:301a with SMTP id
 eb15-20020a170907280f00b00a1f4d21301amr16094009ejc.13.1702862698999; Sun, 17
 Dec 2023 17:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
 <20231213104216.27845-1-hongyu.jin.cn@gmail.com> <20231213104216.27845-2-hongyu.jin.cn@gmail.com>
 <ZXnir8x6127EW7Gp@redhat.com>
In-Reply-To: <ZXnir8x6127EW7Gp@redhat.com>
From: Henry King <hongyu.jin.cn@gmail.com>
Date: Mon, 18 Dec 2023 09:24:54 +0800
Message-ID: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] block: Fix bio IO priority setting
To: Mike Snitzer <snitzer@kernel.org>
Cc: agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk, ebiggers@kernel.org, 
	zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com, 
	hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mike Snitzer <snitzer@kernel.org> =E4=BA=8E2023=E5=B9=B412=E6=9C=8814=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Dec 13 2023 at  5:42P -0500,
> Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:
>
> > From: Hongyu Jin <hongyu.jin@unisoc.com>
> >
> > Move bio_set_ioprio() into submit_bio():
> > 1. Only call bio_set_ioprio() once to set the priority of original bio,
> >    the bio that cloned and splited from original bio will auto inherit
> >    the priority of original bio in clone process.
> >
> > 2. The IO priority can be passed to module that implement
> >    struct gendisk::fops::submit_bio, help resolve some
> >    of the IO priority loss issues.
> >
> > This patch depends on commit 82b74cac2849 ("blk-ioprio: Convert from
> > rqos policy to direct call")
> >
> > Fixes: a78418e6a04c ("block: Always initialize bio IO priority on submi=
t")
> >
> > Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> > Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> > Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
>
> Would be nice to get this block core fix upstream ASAP independent of
> your various DM changes.
dm modification depends on block modification to have effect, so it is
reviewed together.
>
> Please simplify this patch's header like was requested in review of v4:
> https://patchwork.kernel.org/project/dm-devel/patch/20231212111150.18155-=
2-hongyu.jin.cn@gmail.com/
ok, i will send the header=E3=80=82

