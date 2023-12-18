Return-Path: <linux-kernel+bounces-3874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CC817489
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF54B1C2497B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E944A3D574;
	Mon, 18 Dec 2023 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmpq8qu/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE453A1A8;
	Mon, 18 Dec 2023 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5533ca9cc00so1743304a12.2;
        Mon, 18 Dec 2023 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911601; x=1703516401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dpJ4wqz5tsoHUF96iO+zvC5cixng0FOvma4pqbpbEw=;
        b=Tmpq8qu/HPDd2MRuWDGUT3/T4SWWYhnSb+Hq6e0KB5aIcxjPTi+SLdXe/eZLX6Zfin
         7tEXAxdGlDwTqkvX21yiTNEd1jDU/qyFFGsdcJzevLq/6bVacJ1r56GNXrailiYyxJxX
         66ZO88+u0gwcweU69yewApqiI/LPTAN4K1PGa6cXihEACJsK4TVXpn6W53T0q30rv17G
         O+n3RKNMw6ra4jcM3BfsIuxuGZusmkvYs/SFKI0SgxhFUiZyF8N/zOCwCFuLgUwprfbK
         sBLGWtmsGDBMROmfgEUVeaK9BA83TWt4vU3gpz/10pWBPe/6Rd3NGBqQOgp3WzosrMiv
         G+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911601; x=1703516401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dpJ4wqz5tsoHUF96iO+zvC5cixng0FOvma4pqbpbEw=;
        b=p47UEa1cOe6lD74YjmZJYEGmSz7vGxHdCDHjI5L5ItKXA/OSmF0GvMy2fylBPubF4R
         6bzs2q7Kk034KaQpEO33HYHpU7wOjxi5e51VyLvhn5onBD7mCvGjfFwYS18wnvdRk138
         KgLgWukJiE1zcJymhhLvCfScoILSheiwUA0/obhvKJaTj9Q9kGj3rQU7yNQohekQ0Q8O
         c33vbA0qpKqPWeZr0iPGfWW+LkhlmnLf6a17c8R8d7siwmWgtbP+A6/FLEIxsE/kdSGq
         fU0L/RP/TaI7y5uArvr6l2g77Ev1QaoybMlLWB6nBXk0/gzN7rC/frVjn/TEqKNQnK9k
         iG+Q==
X-Gm-Message-State: AOJu0Yw1aQeNE5NjDDZTSH3QNtDs8Zu7/PxeP3Orge5GU60ux8u/Hyuh
	74N7P2dmiijX5SicOZmTC3Gfhg4uUSMT7jUth/4=
X-Google-Smtp-Source: AGHT+IGvOIIEyYt7gsSQ0l9nkVHf/NVx2B3tEbVTX1I+ABBxJBnmeFubN0VM50ayuWh/gcBi2y8RMMovpIMPe0fSvSA=
X-Received: by 2002:a17:906:3f0f:b0:a22:fb3f:7a67 with SMTP id
 c15-20020a1709063f0f00b00a22fb3f7a67mr4488123ejj.150.1702911600551; Mon, 18
 Dec 2023 07:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218115802.15859-1-lukas.bulwahn@gmail.com> <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
In-Reply-To: <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Mon, 18 Dec 2023 15:59:49 +0100
Message-ID: <CAKXUXMyiMMOF79Wbe+xcL2yAXM8+9j_qJhCM0tn-o-hYeY=-ZQ@mail.gmail.com>
Subject: Re: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com, 
	SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 2:18=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Mon, 2023-12-18 at 12:58 +0100, Lukas Bulwahn wrote:
>
> Dunno, I'm not super involved with this but ...
>
> > +++ b/drivers/bcma/Kconfig
> > @@ -1,12 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -config BCMA_POSSIBLE
> > -     bool
> > -     depends on HAS_IOMEM && HAS_DMA
> > -     default y
> > -
> >  menuconfig BCMA
> >       tristate "Broadcom specific AMBA"
> > -     depends on BCMA_POSSIBLE
> > +     depends on HAS_IOMEM && HAS_DMA
>
> [...]
> >  config BRCMSMAC
> >       tristate "Broadcom IEEE802.11n PCIe SoftMAC WLAN driver"
> > -     depends on MAC80211
> > -     depends on BCMA_POSSIBLE
> > +     depends on HAS_IOMEM && HAS_DMA && MAC80211
> >       select BCMA
>
> to me it kind of seems more obvious for example in this case to say
> "depend on BCMA_POSSIBLE and select BCMA" rather than open-coding the
> BCMA dependencies both here and in BCMA? Now granted, they're rather
> unlikely to _change_, but it still seems more obvious?
>

Okay, I see. Well, if that kind of pattern is the preference, then the
code as-is makes sense. The pattern just starts to become obscure when
the dependencies of multiple drivers are the same and we start writing
"BCMA_POSSIBLE || SSB_POSSIBLE", but the dependencies are the same
anyway.

Let us see what others think.

Lukas

