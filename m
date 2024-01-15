Return-Path: <linux-kernel+bounces-25729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C582D50A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD61C211CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE156FB6;
	Mon, 15 Jan 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYVeSxhj"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31666FA1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so494718266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705307219; x=1705912019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwFP484EL/42mEA8eP3U7iCZLLGzI7yfwJRI9zN584M=;
        b=DYVeSxhjFzxDNYgA8lkpIacieQSXGTUr1abf+1vJWPrmrcy7XCFNPraoD4y7mhQeQo
         2fWLXfc2qqv2/tnyD9zhl5T6AoZDugsEjJYZeXrIzAC15CDUCSx3Of6VEQgezgEKWNlM
         WGSWM7yTay8+7wWkufvhHt6BmjSunad2wOgB/xjzr2WLA1rSIgyyQMuynoXev+f94Lf6
         aVMebctPK+RKEYHnc2zpnsBPsqMd0RVxF+e8sBOn2FJD0f1Q6EJa20k12u9ws7ie1z24
         hmrtanyE58uQeI3PTnIPxAzbOeYWsLNCzPkWbI8Xq0qQGdgh/U18u1Ckjn1/5Ptrf/pb
         8lIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705307219; x=1705912019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XwFP484EL/42mEA8eP3U7iCZLLGzI7yfwJRI9zN584M=;
        b=Yxx3v8lQzeoIJo6P/Ld6dUtUMNtlJTxh96Enk+6CFwYIENXmGky4NqqoJF3N+ic5g4
         4BOD5no7zWA1JvruX1ebwCoJvJzbIfu/HHXrs7qSpxg6zYAo9dxc/BCAG3WFZDFW6+qp
         ACNpi4dp63nZoiWCFl5B/DM4MKprLkU4FehWadN6aIEmNlBKEGx9HNhpw3bo1wykPNP6
         AHK8KXJxyFIgyC4jmIQHZ+d716ZE4mN+SO334PemTbc8K9Ni4W2r6r+s8QOX9s9U/vKI
         eiKHxLuwUzPHUIwBGMu/PjXvB2ePneugY7zlhKB29K+1eYHYqCInox3d5WycHD/O5MX/
         jU8Q==
X-Gm-Message-State: AOJu0YyOajk8QnrS0spSK9d4BoxcuUMCJeJfW67nFNe/2AuGoUzxrhSV
	FsfCKIeT3ors2dt5UYmxnpA+juMFK7tc1YMMpxdtmqvfVIG9aQ==
X-Google-Smtp-Source: AGHT+IF4k1vq/KWZ/UThsgPFVJPprdVcyL3s0TAS6ZWzFuWcDmGKlFdr94xCGFOqT/9hdzR7N9CZn4dOFhklG8DmJ60=
X-Received: by 2002:a17:907:740e:b0:a26:9829:1f84 with SMTP id
 gj14-20020a170907740e00b00a2698291f84mr2033034ejc.116.1705307218905; Mon, 15
 Jan 2024 00:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115075425.108134-1-meir6264@Gmail.com> <15008951-9c0d-4bf8-8bc6-a639a6726105@moroto.mountain>
In-Reply-To: <15008951-9c0d-4bf8-8bc6-a639a6726105@moroto.mountain>
From: meir elisha <meir6264@gmail.com>
Date: Mon, 15 Jan 2024 10:26:47 +0200
Message-ID: <CAHdEp8-APpMA-m7kUjMPF0a9NXaBSTjVJn4UJepv=RUn4w=8Cg@mail.gmail.com>
Subject: Re: [PATCH] Staging: rtl8723bs: rtw_ieee80211: Remove extra space
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. Thanks for your reply! sending v2 patch.

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=D7=
=B3, 15 =D7=91=D7=99=D7=A0=D7=95=D7=B3 2024 =D7=91-10:01 =D7=9E=D7=90=D7=AA=
 =E2=80=AADan Carpenter=E2=80=AC=E2=80=8F
<=E2=80=AAdan.carpenter@linaro.org=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Mon, Jan 15, 2024 at 09:54:25AM +0200, Meir Elisha wrote:
> > Fix checkpatch warning: please, no space before tabs
> >
> > Signed-off-by: Meir Elisha <meir6264@Gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/s=
taging/rtl8723bs/core/rtw_ieee80211.c
> > index 30e7457a9c31..cfa994835008 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> > @@ -1036,7 +1036,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwo=
rk)
> >       struct HT_info_element *pht_info =3D NULL;
> >       struct ieee80211_ht_cap *pht_cap =3D NULL;
> >       unsigned int            len;
>                     ^^^^^^^^^^^
> How about we delete these as well.
>
> > -     unsigned char   *p;
> > +     unsigned char *p;
> >       __le16 le_cap;
>
> regards,
> dan carpenter
>

