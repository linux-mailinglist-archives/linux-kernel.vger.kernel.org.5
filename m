Return-Path: <linux-kernel+bounces-112723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5948B887D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C1B1F21332
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136151864D;
	Sun, 24 Mar 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCaqs4Q0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AADB17BC7;
	Sun, 24 Mar 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292923; cv=none; b=qGXsEdQU6nlmHKVnN5X8wSZjlqplxD2FK+vVNVoKAO1m+jJu7T9Y+i0uS8wOkXgvWXcuNqKGTYqd/GphzX9xtIbutiAVd+DnWoiyhagEPIh94l7rbW+tu9vvvMxLUXj+gz8JYrLsl+pO89kwie77OtAswFFtuq4R6TBnINpMY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292923; c=relaxed/simple;
	bh=jbSdBHS0w1eaicjduO3/4ltPjzKnV2+4/Gm18hBir+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijRQ4lNHlL173oHqBqQ71u+nL5SGXr/O+duF+MwDOia0Qu6RBmViSJOjmLidbjca2gomZpGR0c7pH1wvZQjAp+aZPP1Tb5IpTyLv9nhCQd5gS514DzTSy+NOvP4XSmL/pUxdEZhN3lsa4TWJEG0EyQ9WBT2c7flkKRhCw9bQrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCaqs4Q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7ADC433C7;
	Sun, 24 Mar 2024 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711292923;
	bh=jbSdBHS0w1eaicjduO3/4ltPjzKnV2+4/Gm18hBir+0=;
	h=Date:From:To:List-Id:Cc:Subject:In-Reply-To:References:From;
	b=CCaqs4Q0v54OS/qibjDzeR5rnTLCeMB5BEWL9FOQOm8nUsrsP4agxz9UeijgZT7BG
	 4MKSbYfhrQ29CGt+4vnpliHU74QTU5qGLG+bJ0dnax0OIzumnGe5d79tXGVUDVMCwA
	 SUnGl4wT7Kx7SgjiwWQGT8hc1XE8NU7wy5/lvXLsYw1SyVT+Lk0Y7KoBDoIr+Sq5kz
	 G3RLG4eMVQAo0e9iXkjKdxwniW2P5X8xhO9Ro3uHGyprv5IKfuJrfyJjlUyZ06toot
	 J/zg4uC6SCjy+mHbaghEESneDQeaLg4J7rdI5mJb4e8SPi2cU5WxgujzdHnBylvUEu
	 2BTwaVwc1gecg==
Date: Sun, 24 Mar 2024 16:08:28 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jonathan.Cameron@huawei.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, andrzej.hajda@intel.com, arm@kernel.org, arnd@arndb.de,
 bamv2005@gmail.com, brgl@bgdev.pl, daniel@ffwll.ch, davem@davemloft.net,
 dianders@chromium.org, dri-devel@lists.freedesktop.org,
 eajames@linux.ibm.com, gaurav.jain@nxp.com, gregory.clement@bootlin.com,
 hdegoede@redhat.com, herbert@gondor.apana.org.au, horia.geanta@nxp.com,
 james.clark@arm.com, james@equiv.tech, jdelvare@suse.com,
 jernej.skrabec@gmail.com, jonas@kwiboo.se, linus.walleij@linaro.org,
 linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, maarten.lankhorst@linux.intel.com,
 mazziesaccount@gmail.com, mripard@kernel.org, naresh.solanki@9elements.com,
 neil.armstrong@linaro.org, pankaj.gupta@nxp.com,
 patrick.rudolph@9elements.com, rfoss@kernel.org, soc@kernel.org,
 tzimmermann@suse.de
Subject: Re: [PATCH v5 08/11] devm-helpers: Add resource managed version of
 debugfs directory create function
Message-ID: <20240324160828.7f873a96@thinkpad>
In-Reply-To: <69264f8a-a113-4d49-b8a6-fb9e858584e4@wanadoo.fr>
References: <20240323164359.21642-1-kabel@kernel.org>
	<20240323164359.21642-9-kabel__6885.49310886941$1711212291$gmane$org@kernel.org>
	<f7c64a5a-2abc-4b7e-95db-7ca57b5427c0@wanadoo.fr>
	<20240323222506.4ffbdd71@thinkpad>
	<69264f8a-a113-4d49-b8a6-fb9e858584e4@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 Mar 2024 10:21:28 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 23/03/2024 =C3=A0 22:25, Marek Beh=C3=BAn a =C3=A9crit=C2=A0:
> > On Sat, 23 Mar 2024 22:10:40 +0100
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >  =20
>=20
> ...
>=20
> >>>    static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct devi=
ce *dev)
> >>>    {
> >>> -	pvt->dbgfs_dir =3D debugfs_create_dir(dev_name(dev), NULL);
> >>> +	pvt->dbgfs_dir =3D devm_debugfs_create_dir(dev, dev_name(dev), NULL=
);
> >>> +	if (IS_ERR(pvt->dbgfs_dir))
> >>> +		return PTR_ERR(pvt->dbgfs_dir); =20
> >>
> >> Not sure if the test and error handling should be added here.
> >> *If I'm correct*, functions related to debugfs already handle this case
> >> and just do nothing. And failure in debugfs related code is not
> >> considered as something that need to be reported and abort a probe fun=
ction.
> >>
> >> Maybe the same other (already existing) tests in this patch should be
> >> removed as well, in a separated patch. =20
> >=20
> > Functions related to debugfs maybe do, but devm_ resource management
> > functions may fail to allocate release structure, and those errors need
> > to be handled, AFAIK. =20
>=20
> I would say no.
> If this memory allocation fails, then debugfs_create_dir() will not be=20
> called, but that's not a really big deal if the driver itself can still=20
> run normally without it.

debugfs_create_dir() will always be called. Resource allocation is done
afterwards, and if it fails, then the created dir will be removed.

But now I don't know what to do, because yes, it seems that the debugfs
errors are being ignored at many places...

>=20
> Up to you to leave it as-is or remove what I think is a useless error=20
> handling.
> At least, maybe it could be said in the commit log, so that maintainers=20
> can comment on it, if they don't spot the error handling you introduce.
>=20
> CJ
>=20
> >=20
> > Marek
> >  =20
>=20


