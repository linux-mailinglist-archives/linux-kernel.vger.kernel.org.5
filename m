Return-Path: <linux-kernel+bounces-6460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8093A81994E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B98A2870C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECB14F7F;
	Wed, 20 Dec 2023 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O+Cvo459"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71404168A9;
	Wed, 20 Dec 2023 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9D5CE0002;
	Wed, 20 Dec 2023 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703056639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBi+8NL7aE/XRZED3MqrIc3p9l2z2kSeWHJGCwCuiVU=;
	b=O+Cvo4591OIgVVq6asdrH1hS+zDMLhGXgs8JiEiI+QlBo98Rt8fCd8S7GN1yPJ0VcRdLwl
	3v6KfKW+HKekpuGvj5BQwcK/ziuf/22EMCZR6+kxNRODklgpAPWvePigutFecov13JmxKt
	GIEld6cfo0cokWr4WVsNWqPD4LQUisg0qLCgaFoPRsyeKTmKV7yfvTA3+fh4QGQm6HCvEt
	be1geQbgJzIU3rKhwYtSZtM1NIDwM8m74BraPimkr7ime7QvmUpdUnRvevL0S2PMBT/nG4
	Vo0VVUfL8eqRCLyeUFMaXAT4EikQ9IumiBibwslHrjpYD7eBpMS/TJF+NKdd4g==
Date: Wed, 20 Dec 2023 08:17:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem
 helpers
Message-ID: <20231220081717.0afc17f3@xps-13>
In-Reply-To: <1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
	<20231219174025.15228-3-zajec5@gmail.com>
	<2023121929-salami-pessimist-c943@gregkh>
	<1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Tue, 19 Dec 2023 19:16:37 +0100:

> On 19.12.2023 19:13, Greg Kroah-Hartman wrote:
> > On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote=
: =20
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver le=
ss
> >>     mtd dependent
> >> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells =20
> >=20
> > Shouldn't this be 2 different patches? =20
>=20
> I used to maintainers complaining my patches are too small and not the
> other way ;) I think it happened two or three times with mtd subsys.

A single patch may be too small if it's alone and we don't see the big
picture, otherwise I have no issue with small patches, do I? Anyway, in
this case I don't mind the patch being split or kept like this, just
keep my R-by applied to both if you do indeed split.

Thanks,
Miqu=C3=A8l

