Return-Path: <linux-kernel+bounces-11732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07AB81EAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675FC1F21A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29AE1FCA;
	Wed, 27 Dec 2023 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSSmyvb/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE961C10;
	Wed, 27 Dec 2023 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fc6eb9075so11894405ab.1;
        Tue, 26 Dec 2023 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703636644; x=1704241444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1/nYX+7PfnxFP1GbQRd5jf/AiTY0zlq2oe42XbsGqk=;
        b=hSSmyvb/GVdnIIo6q376d914zmNqUMindSEzWeJnZv9GmoAIOT5I9+y46xA0MZiFof
         x+m38sDpUfaikdPPyd9MY4dFKXBqtMhRrKKvY5ytRmIoJgw3kDmpfAvggCgnQvpZpabb
         L3i6NOJWiu48rpEpaT9VYWjm+WVT991B8hZbAWB68a0m0V7BLbXp86UsUYOfggzteMJf
         A8jVLJWhlHKV28ShDPnlox2UeOjFMSF62IMOvScxh4YP4oCIIMH9zVBJYehsPhXhy1A8
         G/r83Hj5k9zKlhy+GSFiVteA0AYiHYhRV5Y+J8ZBCBnqg5gAbcqOghBZHCOYwUPEM/S9
         o5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703636644; x=1704241444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1/nYX+7PfnxFP1GbQRd5jf/AiTY0zlq2oe42XbsGqk=;
        b=vY7ucJsNBQUmzFcz21k2XPJQHjEs4X47+W+tW7J3vmIHxgzarUwGOd4kPjiSqtmNQT
         uSFf6ubzaWEOaFzHWqltKQybQ1T92hBtHXI7squl09AIYpsVYfMgFcEFd16BzcazGh8q
         +PNrzCKOqwwrCq+cevimJ2WgQVnZBTCWYjV5ors1pLHykOhV5kL2wFmEuWy7VH/4qYer
         Uc8ikcV8ITuRKG0CTmmRJiPInIC5aO315t/8cKDtUsSleWRC0Xf85Bk5yS/efmOuGLfY
         Xxt2wK8xag/WYybnbBe4wd1StUL0IsUpA8gHpaVi6Y40zBj8eFACGh8JGvkSN+UivhxV
         S2aQ==
X-Gm-Message-State: AOJu0YzWgiDqcH4YO1gj0IzaK5bzDrY7YSV1ovasxeGLMsiH4ErwDBGn
	e5oq8tV3ip/ErcRp0kDS+Da+asoe9ypVsjrgQP8=
X-Google-Smtp-Source: AGHT+IGuTKisXUiMOmZKUL4G9n7mRVKtWWUb7widyKTMjydhJZ6lSGJaqfeebsVOc/XK/opx9kAlbEcxjaSNoSewU+c=
X-Received: by 2002:a05:6e02:214d:b0:35d:6241:194b with SMTP id
 d13-20020a056e02214d00b0035d6241194bmr5005557ilv.2.1703636644003; Tue, 26 Dec
 2023 16:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com> <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
In-Reply-To: <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Dec 2023 16:23:53 -0800
Message-ID: <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Chris Li <chrisl@kernel.org>
Cc: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 3:30=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Again, sorry I was looking at the decompression side rather than the
> compression side. The compression side does not even offer a safe
> version of the compression function.
> That seems to be dangerous. It seems for now we should make the zswap
> roll back to 2 page buffer until we have a safe way to do compression
> without overwriting the output buffers.

Unfortunately, I think this is the way - at least until we rework the
crypto/compression API (if that's even possible?).
I still think the 2 page buffer is dumb, but it is what it is :(

