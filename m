Return-Path: <linux-kernel+bounces-6346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12981977C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D1B2884BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7880DBE64;
	Wed, 20 Dec 2023 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID58M14q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC1BDF7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9WrZt2uNhtNYFIXv3cFXVd3+GtJdXG5iynZg0EOskg=;
	b=ID58M14qelHWpdQW6xLtFbgAfWg7SNb176SsevazIDt6Eo/idxZlJD4A2jACPQZm5xjh7r
	wYGuBabzmmCl7jm+0d13O4IoMzf0NPA16urVX7b8kcfWCYDC6FBMM/eH1K2LVPiB4zY6kE
	OjZ0xILo30blag4VkVyuJEcgZTkfKdc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-18CZG1jGPSSSFt7QqQ9SKQ-1; Tue, 19 Dec 2023 23:01:20 -0500
X-MC-Unique: 18CZG1jGPSSSFt7QqQ9SKQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6da66541ac5so3442690a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044880; x=1703649680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9WrZt2uNhtNYFIXv3cFXVd3+GtJdXG5iynZg0EOskg=;
        b=Yg2W2gmIjy74hl4HpFCBlzWS/1QZG8VeMFvPS9xAcJA+1P3U2+VyvRE3WBbll1R05O
         5oZLB93tY/ERD7mYUIMLKzoOP0GSn4BK6AvFLElPIVs4UlNCoQsolRoo2S9fcJDd9rzy
         xMbcZ1wzUZzqGiBCvcehNa9488BrPmsl9dlV8/5FaPVBR8Wor4lfIEGEaRXdvsWVviEG
         deELQ330kf1dtrysm3tKnyoJYtMA2iehIbwSrVrrf5NIzAHAaOkq3UPRQu9RhXzjjmMY
         +6BUysANFEacynXSo/BeLyusA/ruhojJX7pEQJEqdOG4+u+6POz3IDElCm7BzfHM6yaW
         e9rg==
X-Gm-Message-State: AOJu0YyPz4tDPBSrTjcptYMjctiBY9sf4tbw3aw/YyLmvhql2lZlCnA6
	QSFLK3bxW7bZL3sO/wyGwu0R7DZefztymaUksAjkJa5duWMW0my0Wkqsl6BYl19EcjYzy2pCaNq
	SykL/0efWTdlFWF3DcRTZfeDzw3yKP04ArY0wOfox
X-Received: by 2002:a05:6830:111a:b0:6db:a784:e63c with SMTP id w26-20020a056830111a00b006dba784e63cmr1226581otq.52.1703044880074;
        Tue, 19 Dec 2023 20:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKXTTVHkTHwzTIJp3S44KEnYn52QSYOGCVLEeAMGeoIdjhsZpD4pvK8iU+DlF3o79kgP3L8OwSOJhybMg0H+A=
X-Received: by 2002:a05:6830:111a:b0:6db:a784:e63c with SMTP id
 w26-20020a056830111a00b006dba784e63cmr1226573otq.52.1703044879855; Tue, 19
 Dec 2023 20:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7b0ef1eabd081f1c7c894e9b11de01678e85dee.1666293559.git.christophe.jaillet@wanadoo.fr>
 <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
In-Reply-To: <72a89724-9dad-499a-a0ed-ad9d046d235d@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:01:08 +0800
Message-ID: <CACGkMEtHy4GxGEQyL9EThK11wHTH=JS44gM+A41gsWSSg9e=QQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Fix an error handling path in eni_vdpa_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 5:14=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 20/10/2022 =C3=A0 21:21, Christophe JAILLET a =C3=A9crit :
> > After a successful vp_legacy_probe() call, vp_legacy_remove() should be
> > called in the error handling path, as already done in the remove functi=
on.
> >
> > Add the missing call.
> >
> > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >   drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni=
_vdpa.c
> > index 5a09a09cca70..cce3d1837104 100644
> > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > @@ -497,7 +497,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >       if (!eni_vdpa->vring) {
> >               ret =3D -ENOMEM;
> >               ENI_ERR(pdev, "failed to allocate virtqueues\n");
> > -             goto err;
> > +             goto err_remove_vp_legacy;
> >       }
> >
> >       for (i =3D 0; i < eni_vdpa->queues; i++) {
> > @@ -509,11 +509,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >       ret =3D vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
> >       if (ret) {
> >               ENI_ERR(pdev, "failed to register to vdpa bus\n");
> > -             goto err;
> > +             goto err_remove_vp_legacy;
> >       }
> >
> >       return 0;
> >
> > +err_remove_vp_legacy:
> > +     vp_legacy_remove(&eni_vdpa->ldev);
> >   err:
> >       put_device(&eni_vdpa->vdpa.dev);
> >       return ret;
>
> Polite reminder on a (very) old patch.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> CJ
>


