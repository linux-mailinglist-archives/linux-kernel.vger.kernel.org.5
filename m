Return-Path: <linux-kernel+bounces-20674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA7E828357
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01361C25174
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9833CF8;
	Tue,  9 Jan 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+lFp5EM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668235EFC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704793082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ky5q4Lye4xDM1EU7ISSxxpSTjWDC6pdqfZjOsW+ZzgY=;
	b=L+lFp5EMAHkSe5GhHIXcs3Tv3nYVkO5pjnVtd6zNOg+1HV379WH4At7S95gB73imojxpQ9
	lqdnr4hjqopfz+lZv6rzKLJLy7u3GzV174gW34HO21h6tqxWy4VlEVjEDQ80p4gIDSRbPG
	EfakmV85qIr4L7x5zq5h0iugi2SQgV8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-llCnPQgNNVC6Qc2zUdI76w-1; Tue, 09 Jan 2024 04:38:01 -0500
X-MC-Unique: llCnPQgNNVC6Qc2zUdI76w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4299cbf080bso2699111cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793080; x=1705397880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky5q4Lye4xDM1EU7ISSxxpSTjWDC6pdqfZjOsW+ZzgY=;
        b=sYHBqlcQL9RisvoRRu90bH6rH9kOJssiZWXYErxYgZgXuxhkPSH/2BYEgcm+F4bRam
         j/EPfZvR6WpYto5aeNP89qYlxuumNogx5ird4gZ6Pnstpfp+ajsjFR50X1w4ZeY/6ftY
         9yZchtcmu0aeFV7mRqNwN578NfOWposh4yqXzt/T7GJ2GlPm/0WIoLg/O7MXRnHcc0K8
         VaADNJbXkfmNHeygb53r4FTrgr3HlhNdWlR4pgzNijhECLTjq2vQjTm3Y3aQovhIyma5
         U7phhGi5L1+jT/F0JkouWw0EjnssFCDgwNBZqH36xPLh5GS1bSX4OlSwPYxIeM6zVoJ+
         FWYg==
X-Gm-Message-State: AOJu0Yw/fqq4BKfx/BQ6KPUQf2M/YHAJaZ76nM62avHK6jkZSBF5M2zS
	03NUZAlpD9yIY0NzmShiozPhdOyWMrbIa4BwcYEBqKw6z7BCgLxF/TsqPfJWtbxxSZEApGBIZaf
	E72vDmBArs9qYt563kMDGt2ZSxyhDe8vs
X-Received: by 2002:ac8:7e96:0:b0:429:7bf4:f6df with SMTP id w22-20020ac87e96000000b004297bf4f6dfmr11145563qtj.4.1704793080548;
        Tue, 09 Jan 2024 01:38:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7DZjLgo1mS+4fbiobPrucDM8xf3Zq3INpPYhYQwz3yTpWNUvJ5BzG6Y3jQpGhehseYzzM4w==
X-Received: by 2002:ac8:7e96:0:b0:429:7bf4:f6df with SMTP id w22-20020ac87e96000000b004297bf4f6dfmr11145547qtj.4.1704793080276;
        Tue, 09 Jan 2024 01:38:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84808000000b0042987870887sm708466qtq.10.2024.01.09.01.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:38:00 -0800 (PST)
Message-ID: <da747c7ca3424cfa5a0d7ecf1733dc1a7303a9ee.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] platform_device: add devres function region-reqs
From: Philipp Stanner <pstanner@redhat.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Mark
 Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,  Thomas
 Zimmermann <tzimmermann@suse.de>, Laurentiu Palcu
 <laurentiu.palcu@oss.nxp.com>, David Gow <davidgow@google.com>,  Shawn Guo
 <shawnguo@kernel.org>, David Airlie <airlied@gmail.com>, Pengutronix Kernel
 Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Lucas
 Stach <l.stach@pengutronix.de>
Date: Tue, 09 Jan 2024 10:37:56 +0100
In-Reply-To: <ixywpvuwlhdpv6szvssipy2ygjhzdvt6nrbcppy4yx5ix5b3is@pq7s6hpse2ni>
References: <20240108092042.16949-2-pstanner@redhat.com>
	 <20240108092042.16949-3-pstanner@redhat.com>
	 <hywkbwwwkddbd5vye366bhz64dlpet4chv3kzwfu5dx6rvvix6@2jnk3xx6vfiy>
	 <404aea6b7bb7874064153044f04f3b8f6fccb97b.camel@redhat.com>
	 <ixywpvuwlhdpv6szvssipy2ygjhzdvt6nrbcppy4yx5ix5b3is@pq7s6hpse2ni>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Yo!

On Mon, 2024-01-08 at 12:46 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Jan 08, 2024 at 10:45:31AM +0100, Philipp Stanner wrote:
> > On Mon, 2024-01-08 at 10:37 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Other than that I indifferent if this is a good idea. There are
> > > so many
> > > helpers around these functions ...
> >=20
> > Around which, the devres functions in general? There are, but
> > that's
> > kind of the point, unless we'd want everyone to call into the
> > lowest
> > level region-request functions with their own devres callbacks.
> >=20
> > In any case: What would your suggestion be, should parties who
> > can't
> > (without restructuring very large parts of their code) ioremap()
> > and
> > request() simultaneously just not use devres? See my patch #2
> > Or is there another way to reach that goal that I'm not aware of?
>=20
> This wasn't a constructive feedback unfortunately and more a feeling
> than a measurable criticism. To actually improve the state, maybe
> first
> check what helpers are actually there, how they are used and if they
> are
> suitable to what they are used for.
>=20
> Having many helpers is a hint that the usage is complicated. Is that
> because the situation is complicated, or is this just a big pile of
> inconsistency that can be simplified and consolidated?

I thought about that and tend to believe that you are right in this
case. The reason being that there'd be very few callers to such a
wrapper.
We have the functions for doing pure requests and pure ioremaps, so
that should be sufficient.

I think we can do sth like this in the rare cases where someone needs
to request without (immediately) mapping:


struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
{
	struct platform_device *pdev =3D to_platform_device(dev);
	int ret;
	struct resource *res;
	struct dcss_dev *dcss;
	const struct dcss_type_data *devtype;
	resource_size_t res_len;

	devtype =3D of_device_get_match_data(dev);
	if (!devtype) {
		dev_err(dev, "no device match found\n");
		return ERR_PTR(-ENODEV);
	}

	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(dev, "cannot get memory resource\n");
		return ERR_PTR(-EINVAL);
	}

	res_len =3D res->end - res->start;
	if (!devm_request_mem_region(pdev->dev, res->start, res_len, "dcss")) {
		dev_err(dev, "cannot request memory region\n");
		return ERR_PTR(-EBUSY);
	}


And then do the associated devm_ioremap()s where they're needed.


So I'd 'close' this patch series and handle it entirely through my dcss
patch-series.

Thx for the feedback

P.


>=20
> Also I think there are helpers that take a resource type parameter
> (as
> your function) and others hard code it in the function name. Maybe
> unifying that would be nice, too.
>=20
> Best regards
> Uwe
>=20


