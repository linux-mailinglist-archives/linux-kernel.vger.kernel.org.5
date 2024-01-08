Return-Path: <linux-kernel+bounces-19296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E4826B05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5D9282364
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786BB12B8F;
	Mon,  8 Jan 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ogh3DhXb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C1A11CB0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704707138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqxtqmVQFTbAQHnUnqvy9W7SxC7kiZQC9RYNbL1/SN8=;
	b=Ogh3DhXbbRXEoGAAwdkMlLoXTQHrg4Vo5JPWAUa2vmIINh77vj2QXMnRLYVUz1Vm3cPU/9
	slOx5wxBR3ONdVK98sg9Ts+UovF21LkTp55lSkMtnoaxpFPwCuUDVkht+SFfDkNoYNS8ne
	Qfbg3gaZyUbfv9Unj3gqEyYgG2qGcKY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-mY5Ga3W4OpWFgdLC5OsDBA-1; Mon, 08 Jan 2024 04:45:37 -0500
X-MC-Unique: mY5Ga3W4OpWFgdLC5OsDBA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4299dfcdc0fso60881cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704707135; x=1705311935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqxtqmVQFTbAQHnUnqvy9W7SxC7kiZQC9RYNbL1/SN8=;
        b=GWZZt9uMetbHbSND8i2dyx4hEfEy6o+eZG+vFl0qsJOwetKQsSNbpEmu135rkAdxAi
         CgK5iXG4tsfb4RrBaeBEBI+Q2d0mO8DOUijOMQ1i8miqQ8WBA+LIJiym26QHT5+IkOj5
         spwFky5g61ji/9RHW7Eau+wkEPgjWBYEmpjLIDO9/irmsYmCoB2DR0S+WRlX1mbvxt3J
         vCJf5Gou2Mh4iGKun1C3ojj23RWDxWxZ8+/holzfldCaqqYtsJfoJ329E/uYWUaBCvFI
         NrvqbhzNXHycAWvgw9V9F9NrKlAckK/xSNbvqQloSWpTBXF3Hyh+zhbn0qM7HDuF0JEC
         tfrw==
X-Gm-Message-State: AOJu0YwpGafRbPsZ2NVRa+bCTdKeT/kQLITbmfUzesD/1wbzzUqVs0wD
	LV8ql+9bgFtYUKP+HeOg2lVjJPBDWRFu/c2X52MBGDnsyegn6ymad2EW/v1+y1oSg+oPBPoUFcm
	VZHrfnr7wnxob8vmYb77qTn4/VpAJd6WE
X-Received: by 2002:a05:6214:f29:b0:681:7ea:793b with SMTP id iw9-20020a0562140f2900b0068107ea793bmr1815920qvb.2.1704707135693;
        Mon, 08 Jan 2024 01:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF8vpbq+ypVZASjEe2WryjdgrP22ZWA/dGlza8qOORveTvR0ZxEbRZuAu7U0tcbTm1kEaxvw==
X-Received: by 2002:a05:6214:f29:b0:681:7ea:793b with SMTP id iw9-20020a0562140f2900b0068107ea793bmr1815902qvb.2.1704707135434;
        Mon, 08 Jan 2024 01:45:35 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id w5-20020a0cff05000000b0067f635da89esm2724421qvt.124.2024.01.08.01.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:45:35 -0800 (PST)
Message-ID: <404aea6b7bb7874064153044f04f3b8f6fccb97b.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] platform_device: add devres function region-reqs
From: Philipp Stanner <pstanner@redhat.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, Lucas
 Stach <l.stach@pengutronix.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team
 <linux-imx@nxp.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai
 <tiwai@suse.de>,  David Gow <davidgow@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Date: Mon, 08 Jan 2024 10:45:31 +0100
In-Reply-To: <hywkbwwwkddbd5vye366bhz64dlpet4chv3kzwfu5dx6rvvix6@2jnk3xx6vfiy>
References: <20240108092042.16949-2-pstanner@redhat.com>
	 <20240108092042.16949-3-pstanner@redhat.com>
	 <hywkbwwwkddbd5vye366bhz64dlpet4chv3kzwfu5dx6rvvix6@2jnk3xx6vfiy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 10:37 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Philipp,
>=20
> the Subject is incomprehensible (to me). Maybe make it:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_device: Add devm=
 function to simplify mem and io
> requests
>=20
> ?
>=20
> On Mon, Jan 08, 2024 at 10:20:42AM +0100, Philipp Stanner wrote:
> > Some drivers want to use (request) a region exclusively but
> > nevertheless
> > create several mappings within that region.
> >=20
> > Currently, there is no managed devres function to request a region
> > without mapping it.
> >=20
> > Add the function devm_platform_get_resource().
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
> Still the old function name -'

ACK. Monday morning...

>=20
> Other than that I indifferent if this is a good idea. There are so
> many
> helpers around these functions ...

Around which, the devres functions in general? There are, but that's
kind of the point, unless we'd want everyone to call into the lowest
level region-request functions with their own devres callbacks.

In any case: What would your suggestion be, should parties who can't
(without restructuring very large parts of their code) ioremap() and
request() simultaneously just not use devres? See my patch #2
Or is there another way to reach that goal that I'm not aware of?


P.

>=20
> Best regards
> Uwe
>=20
>=20
>=20


