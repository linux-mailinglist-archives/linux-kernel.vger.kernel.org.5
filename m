Return-Path: <linux-kernel+bounces-19182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756A826965
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD3C1F216AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED01B66C;
	Mon,  8 Jan 2024 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gESezSnz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6FB665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704702332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZTv9nbes+UUv6ydUaDBh+0jRRVdETkIFavswDy7m5g=;
	b=gESezSnzLQ++EcmmORs8Xw7RVyySirLfgYj9kGu+9QJMT2PKoPZnZnR5tdFVr8PWQbsWxd
	dguMmYyMFNqoD98BmOnB2h1v76uqgO5IA+SjY+aZ7oeZre5DYmOBfjy6AHjvBWfjCVq5EU
	9djF4HbotoJ8QQqI9d7r8INvDVWoD4I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-0CaYMRCVOrmpV6T-XdDqtg-1; Mon, 08 Jan 2024 03:25:26 -0500
X-MC-Unique: 0CaYMRCVOrmpV6T-XdDqtg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78130939196so50381485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702325; x=1705307125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZTv9nbes+UUv6ydUaDBh+0jRRVdETkIFavswDy7m5g=;
        b=dwPCvDRwyQP5ZFh+a9pVnrWjE28gBBE9aC6GXJtLJnh1A1tgGsAfyd9S+yLHFMtcYV
         WS9C1DOWQNTIqUV3KYlYs9Vj3pLcJr394R+KjoK6IEpfbRHQkFbNxLYu2gv68jsY0vrH
         o9H44WRvMnGZfr+i2zDuz8N3db+6/LroxH3IELBSML2zh1oBeCD4Wwkmu2+JE6Lob6s6
         hexAKUhtV83vU9A102ivkbaKebgYv12ah4/yy9WfeQDzE7uuPw53ZY5Q5muhU4Wc1LFf
         WjJ1r9gWrbG7OiZKfKWX1Ug1YPdB1q7G5ii+MijPlDa6uZh8CEdtBDEhdKVw9w/E0Z7L
         u2rg==
X-Gm-Message-State: AOJu0YxZKquhad6Tbf535jJTR4j7RIOIUDjVmBi0GAR5JGmyTHpuEalk
	+3mALzdnePdUgaQH6bNRK0ygP1wtVAcLn0+JENzyQU6FhyxkMZJntb23rdSelt/XIb3Eg29tZ+p
	wBMHt/cru/6nqOtBP0nL1fj5zB+AXJu9/LdXoLYnS
X-Received: by 2002:a05:620a:288e:b0:783:c16:7a16 with SMTP id j14-20020a05620a288e00b007830c167a16mr6043900qkp.1.1704702325676;
        Mon, 08 Jan 2024 00:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfw9fsaBrvtnrSiGzHe6+3DxQpSVdE63JJD/cnb6iJsbp5EFyBmCe5Ck8H1SRExu3t2tyTDQ==
X-Received: by 2002:a05:620a:288e:b0:783:c16:7a16 with SMTP id j14-20020a05620a288e00b007830c167a16mr6043890qkp.1.1704702325367;
        Mon, 08 Jan 2024 00:25:25 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c28-20020a05620a135c00b007831a3aaa0bsm1087803qkl.110.2024.01.08.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:25:25 -0800 (PST)
Message-ID: <3d0e251f0d58f1f8266074973644160d831fa462.camel@redhat.com>
Subject: Re: [PATCH 1/2] platform_device: add devres function region-reqs
From: Philipp Stanner <pstanner@redhat.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,  Mark
 Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Laurentiu Palcu
 <laurentiu.palcu@oss.nxp.com>, David Gow <davidgow@google.com>, Shawn Guo
 <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 08 Jan 2024 09:25:22 +0100
In-Reply-To: <5k75ed3czl6rqzkykl7xc4dbyih2frunoor4ypfqxx7yzfs2vd@6ieg4dewtgxf>
References: <20240105172218.42457-2-pstanner@redhat.com>
	 <20240105172218.42457-3-pstanner@redhat.com>
	 <5k75ed3czl6rqzkykl7xc4dbyih2frunoor4ypfqxx7yzfs2vd@6ieg4dewtgxf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi

On Fri, 2024-01-05 at 20:11 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Jan 05, 2024 at 06:22:18PM +0100, Philipp Stanner wrote:
> > Some drivers want to use (request) a region exclusively but
> > nevertheless
> > create several mappings within that region.
> >=20
> > Currently, there is no managed devres function to request a region
> > without mapping it.
> >=20
> > Add the function devm_platform_get_resource()
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/base/platform.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 37
> > +++++++++++++++++++++++++++++++++
> > =C2=A0include/linux/platform_device.h |=C2=A0 2 ++
> > =C2=A02 files changed, 39 insertions(+)
> >=20
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 10c577963418..243b9ec54d04 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -82,6 +82,43 @@ struct resource *platform_get_mem_or_io(struct
> > platform_device *dev,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(platform_get_mem_or_io);
> > =C2=A0
> > +/**
> > + * devm_platform_get_and_resource - get and request a resource
>=20
> This function name is wrong.
>=20
> > + *
> > + * @pdev: the platform device to get the resource from
> > + * @type: resource type (either IORESOURCE_MEM or IORESOURCE_IO)
> > + * @num: resource index
> > + * @name: name to be associated with the request
> > + *
> > + * Return: a pointer to the resource on success, an ERR_PTR on
> > failure.
> > + *
> > + * Gets a resource and requests it. Use this instead of
> > + * devm_platform_ioremap_resource() only if you have to create
> > several single
> > + * mappings with devm_ioremap().
> > + */
> > +struct resource *devm_platform_get_resource(struct platform_device
> > *pdev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0unsigned int type, unsigned int num, const char
> > *name)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *res;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D platform_get_resourc=
e(pdev, type, num);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!res)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
>=20
> From devm_platform_get_resource I'd expect that it only does
> platform_get_resource() + register a cleanup function to undo it.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (type & IORESOURCE_MEM)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0res =3D devm_request_mem_region(&pdev->dev, res-
> > >start, res->end, name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (type & IORESOURCE_I=
O)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0res =3D devm_request_region(&pdev->dev, res->start,
> > res->end, name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
>=20
> So this part is surprising. IMHO your function's name should include
> "request".

Yes, that sounds very correct to me. I'll address that in v2


Thx for the feedback,

P.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!res)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EBUSY);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return res;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_get_resource);
> > +
> > =C2=A0#ifdef CONFIG_HAS_IOMEM
> > =C2=A0/**
> > =C2=A0 * devm_platform_get_and_ioremap_resource - call
> > devm_ioremap_resource() for a
>=20
> Best regards
> Uwe
>=20


