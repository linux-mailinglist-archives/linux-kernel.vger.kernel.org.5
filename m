Return-Path: <linux-kernel+bounces-43492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B28414B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7731BB22DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055F157E60;
	Mon, 29 Jan 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="vGjrVOYq"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EDB156967;
	Mon, 29 Jan 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561635; cv=none; b=LUYc7ODiDzxTajtRZF0f8jkwhvt/VuB7/k4zk2cm1v0WqSsWzL+CfEGNmKsLY1l9rOmfEx5uwNc6IiX3G5QnDovMgIjV9t7l/vnN3bHpOwuE2sGmV2HEh5sri00m1LoSmg4Z7JX5whq1Gp6yxJTfz+HP8GsSt3xIJCaLZbVf93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561635; c=relaxed/simple;
	bh=nEjyZHEGpRJL0+zy08rgYVHyls7/S7js1fkWuJqu/Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmHNAzXI2OkYiwhv4e1An92jOzlGY6gHk8OzWJw1KQtLydHdsUr7TneFu01+jIV/hklgLXycrzO+4NCGT+UiYZT4VMd4QmuP2LRbnBs8M9yVixsNd6HoRxm2N1urS+XbQ/jx8YasLQPOBqraamJe8+h1ahh0w/veOuepOoPcthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=vGjrVOYq; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nEjyZHEGpRJL0+zy08rgYVHyls7/S7js1fkWuJqu/Ig=; b=vGjrVOYqWojCP1MneYHbWGxJz7
	8Bss/7zI7yVepYSkzBvunYLQXyjOfGZECow7oPCS2EQLtCYaFBsNVOtdXftene+iQEWlX5oUgAZbR
	uUh1gsWBEGVzW2hGe1p2KddXdDSjyUkQnUC3lrl7rwQ+vlMUnle3JbowUJ0Q/MxNsNQuQou2H5XqM
	YmHu2Nn2v7BZWuEpXa2y3UQ/LtTJy6uLFM8ncI5B9aSzkdvdacXzi2cuEWUb7anL4JHu9K0DtcDyY
	gve79lC//WsLZWcJ+JZc36tGvLKkPEdaR1fug4NuV1yAGjAglAO4lZVDIde7vI9ErEC+0OfjXvKBq
	a1dw45cg==;
Received: from p200300c2070939001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:709:3900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rUYda-008sHn-Q3; Mon, 29 Jan 2024 21:53:50 +0100
Date: Mon, 29 Jan 2024 21:53:48 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [RFC PATCH v2 3/3] gnss: Add driver for AI2 protocol
Message-ID: <20240129215348.05fe6f7f@aktux>
In-Reply-To: <1cc869a6-8547-4c5b-b39d-10f4a3e11dff@molgen.mpg.de>
References: <20240128173352.2714442-1-andreas@kemnade.info>
	<20240128173352.2714442-4-andreas@kemnade.info>
	<1cc869a6-8547-4c5b-b39d-10f4a3e11dff@molgen.mpg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 08:53:27 +0100
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Andreas,
>=20
>=20
> Thank you for your patch.
>=20
>=20
> Am 28.01.24 um 18:33 schrieb Andreas Kemnade:
> > Add a driver for the Air Independent Interface protocol used by some TI
> > Wilink combo chips. Per default, send out just NMEA to userspace and tu=
rn
> > on/off things at open()/close() but keep the door open for any
> > sophisticated development regarding the AI2 protocol by having a kernel
> > parameter to turn it into raw mode resembling /dev/tigps provided by so=
me
> > TI vendor kernels. =20
>=20
> It=E2=80=99d be great, if you could add the name the kernel parameter *ai=
2raw*,=20
> and also document at least one of these vendor kernels.
>=20
> Could you give a high level overview of the driver design?
>=20
basically I rely on the hci_ll stuff for doing wakeup and initializing
the firmware. So I queue up there another sort of TLV construction besides
the Bluetooth packets using the hci_dev infrastructure and offload all the
GNSS specific handling to a platform subdevice.
So in raw AI2 mode, the input is just en/decapsulated into GPS_CH9_OP_READ/=
WRITE
packets and sent/recv via the hci queuing system (gnss_recv_frame() / ai2_s=
end_frame()).

On top of that in NMEA mode, proper intialization is done at
open()/close(). The commands are in ai2_compose_frame() prepared by adding
checksums, escaping any occurance of 0x10 and adding start/end markes()
In the rx path, the mechanism works the other way round and if the packet
is an NMEA report it is sent to userspace.

> What device did you test with?
>
As said in 0/3 I am testing with an Epson Moverio BT-200 containing
a WL1283.

Regards,
Andreas

