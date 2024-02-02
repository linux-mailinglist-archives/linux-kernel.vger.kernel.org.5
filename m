Return-Path: <linux-kernel+bounces-49575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EA846C34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD9B30ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A577F2D;
	Fri,  2 Feb 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AvLo5nUK"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131C77F10
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865969; cv=none; b=mmkkNoloIGptz7EO8DdushciB5Rx4MB4RfjVVf4DzhwhrMyT33h+NiadI0Z9bFfhSOk5zV1GEHRWQMybX6epQx+dDShko95fvdeQb2gm2c24TC0hIQTLLBL779PoPEFircGeeTiJsS0qCnjE6U76pq3EIC4tY7rHqsKdO/0QZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865969; c=relaxed/simple;
	bh=2efg9wk2C4VI6y/ULepSR89HvTsqcQDUyUZlb+CaPD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlznGs+nAqBNgrfMRCqURMQqvQQ+w2F76/5hSuUF4GJUh7rqQfJozCYafpURgsNXqAKF8ausGYDb4iM3jn2pr4kvH453+BDYG+su/KP5Q430nSlZm7vO8v8Jmm4FaQoQvlcZ8nqaKNdhNtnK4kcYmm/yHHdsOtowe3OMgsR8IKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AvLo5nUK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58138E000A;
	Fri,  2 Feb 2024 09:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706865965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2efg9wk2C4VI6y/ULepSR89HvTsqcQDUyUZlb+CaPD0=;
	b=AvLo5nUKWxkD6+kvpqxMZ7XPPJNIO/PQWzhBM+K1am2dN8AncVyUrW9Q+of0m0It9WxzPC
	JQWlqgnbPzFhVzgroizK4cB7b+ISJOn8xe4LVookunZzYBFILVGpUZRvjdnXH7ILgFcTWc
	PS68lOBl36Q1nGcNbH+ninf58TsT7puu2NI3Ti1GLbOR8VcOyrZxQ4U4XieWdfxM+oQRTA
	m/73zQNtfMeM+37E/jn5glv+AsGGmkKxdZWQ0lr9jTJDPcOXJX0I61KwseCtKmg5NY6k+i
	d6/Th743wUg3UFEp+i0PY7josLuEQx54VcpWDImFD/md1uGpQ/lrSHP+0bgGnw==
Date: Fri, 2 Feb 2024 10:26:01 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com,
 nicolejadeyee@google.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <20240202102601.70b6d49c@xps-13>
In-Reply-To: <20240202105522.43128e19@eldfell>
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
	<20240201-yuv-v1-2-3ca376f27632@bootlin.com>
	<20240202105522.43128e19@eldfell>
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

Hi Pekka,

pekka.paalanen@haloniitty.fi wrote on Fri, 2 Feb 2024 10:55:22 +0200:

> On Thu, 01 Feb 2024 18:31:32 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
>=20
> > Change the composition algorithm to iterate over pixels instead of line=
s.
> > It allows a simpler management of rotation and pixel access for complex=
 formats.
> >=20
> > This new algorithm allows read_pixel function to have access to x/y
> > coordinates and make it possible to read the correct thing in a block
> > when block_w and block_h are not 1.
> > The iteration pixel-by-pixel in the same method also allows a simpler
> > management of rotation with drm_rect_* helpers. This way it's not needed
> > anymore to have misterious switch-case distributed in multiple places. =
=20
>=20
> Hi,
>=20
> there was a very good reason to write this code using lines:
> performance. Before lines, it was indeed operating on individual pixels.
>=20
> Please, include performance measurements before and after this series
> to quantify the impact on the previously already supported pixel
> formats, particularly the 32-bit-per-pixel RGB variants.
>=20
> VKMS will be used more and more in CI for userspace projects, and
> performance actually matters there.
>=20
> I'm worrying that this performance degradation here is significant. I
> believe it is possible to keep blending with lines, if you add new line
> getters for reading from rotated, sub-sampled etc. images. That way you
> don't have to regress the most common formats' performance.

While I understand performance is important and should be taken into
account seriously, I cannot understand how broken testing could be
considered better. Fast but inaccurate will always be significantly
less attractive to my eyes.

I am in favor of making this working first, and then improving the code
for faster results. Maybe the line-driven approach can be dedicated to
"simpler" formats where more complex corner cases do not happen. But
for now I don't see the point in comparing performances between broken
and (hopefully) non broken implementations.

Thanks,
Miqu=C3=A8l

