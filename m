Return-Path: <linux-kernel+bounces-3885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0648174B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3CD1C2499F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3242392;
	Mon, 18 Dec 2023 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m28TP9DS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD13D577;
	Mon, 18 Dec 2023 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a23566e91d5so155376266b.0;
        Mon, 18 Dec 2023 07:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911847; x=1703516647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6foNHtyZRIJvWBTng3wISgU2MfZKVaXRv3N1MNnrMQ=;
        b=m28TP9DSddRi5til0MsICR6zvrahO27MrcAlHQ9YSGssvofIAGhz/UCiu0tiaTjg0Q
         3xpGwLuZIALP+XnWPB1dgBMUNQ4dq5mXKN4QKjGQdIjij4pvMMvH1BiwfHqulKbAlPuK
         Pf3D8BBGCV+zlTDS05y4EqFFU40EFtZOBEKfzsUq9MuBBb91k9ii71U1WsdGAU0tDObs
         U7tWS5gIq2lJm45HkHR/cmCbaXxNtiI5i4g3/X3dY4vEDW58uSLCq9Z1+sL3K+/voQ+v
         aWqCiZ2m1VjEsUxY2nQDLbCgwhsuNF1T9PBtRtUHOLSZb0iDVmYDNqZaIp96NKoTpW2P
         U7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911847; x=1703516647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6foNHtyZRIJvWBTng3wISgU2MfZKVaXRv3N1MNnrMQ=;
        b=KsLv0ksuERdHNSvD+Bk+ZYfkE+j2cTWE+h8QIVYoSj9ev3yvpG24GWM4a7Z9WS3p55
         Gf5BD4oa0dN1YD8M1Fpm5gPIOLpZ+R/fYNBGcR+2rOTsIrF9MLkFPtMMorQ62JSqVm8k
         sYNNKngn9WcAqVEP4dZz2PU3XiZTRhofd+gNlYJx3IRT2EJGMBrT0zQIIrXgSdAeX9W3
         BOq/g1/ZL4FdN+lFQKN4PLwbdQt5WuDZCTdMDKaSsiUx1kFuZfGGcWHegHxbrrms33DR
         vbY2jpAjEnXbC8hK2ldTMKGwp1s6gul+wJ84yHQzCSnGD1mi57RtVORROIlzAVPQkDGp
         Xc/w==
X-Gm-Message-State: AOJu0Yw5v+JXaXtPJBLlcg+2MKA/rCF09l8Gqy8HPqwYqhDeo6o5UeJK
	XlXhXHP/GEqVvHhwANgO94qHFeI6nAgZi4nY064=
X-Google-Smtp-Source: AGHT+IGpphjTUnAqLE+hQAj1yH6sXJlSe/0XhogaISq5mrc01gwsmD6+HxIIpJz2iD0xeckt1xV5LbaknP1N/+M7VSo=
X-Received: by 2002:a17:906:b203:b0:a19:a19b:424a with SMTP id
 p3-20020a170906b20300b00a19a19b424amr5114987ejz.181.1702911846667; Mon, 18
 Dec 2023 07:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218115802.15859-1-lukas.bulwahn@gmail.com>
 <26207725d5025318b831dd5a5feca67248aaa221.camel@sipsolutions.net> <87o7ensgjv.fsf@kernel.org>
In-Reply-To: <87o7ensgjv.fsf@kernel.org>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Mon, 18 Dec 2023 16:03:54 +0100
Message-ID: <CAKXUXMxh3rM8da9kJG_=Sy8fQqqf7f8xXaHDHPLvpvRiYg1e5w@mail.gmail.com>
Subject: Re: [PATCH] bcma,ssb: simplify dependency handling for bcma and ssb drivers
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com, 
	SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:59=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Johannes Berg <johannes@sipsolutions.net> writes:
>
> > On Mon, 2023-12-18 at 12:58 +0100, Lukas Bulwahn wrote:
> >
> > Dunno, I'm not super involved with this but ...
> >
> >> +++ b/drivers/bcma/Kconfig
> >> @@ -1,12 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >> -config BCMA_POSSIBLE
> >> -    bool
> >> -    depends on HAS_IOMEM && HAS_DMA
> >> -    default y
> >> -
> >>  menuconfig BCMA
> >>      tristate "Broadcom specific AMBA"
> >> -    depends on BCMA_POSSIBLE
> >> +    depends on HAS_IOMEM && HAS_DMA
> >
> > [...]
> >>  config BRCMSMAC
> >>      tristate "Broadcom IEEE802.11n PCIe SoftMAC WLAN driver"
> >> -    depends on MAC80211
> >> -    depends on BCMA_POSSIBLE
> >> +    depends on HAS_IOMEM && HAS_DMA && MAC80211
> >>      select BCMA
> >
> > to me it kind of seems more obvious for example in this case to say
> > "depend on BCMA_POSSIBLE and select BCMA" rather than open-coding the
> > BCMA dependencies both here and in BCMA? Now granted, they're rather
> > unlikely to _change_, but it still seems more obvious?
>
> I was thinking the same. Lukas, is there a specific reason why you want
> to change this or this just something you noticed by chance?
>

I just noticed this by chance---well, I was wondering what these
config symbols were doing in my kernel build configuration (they are
actually in every config). While reading through the code, I was
confused on what the dependencies were trying to tell me, as the
config symbols and conditions seemed to repeat over and over in
different places.

I thought it was worth a clean up and this was the patch I came up
with in the end.

Lukas

