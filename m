Return-Path: <linux-kernel+bounces-80320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE964862D61
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390BCB20CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADAD1BC23;
	Sun, 25 Feb 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="4Pk6DKq9"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D21B951;
	Sun, 25 Feb 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899422; cv=none; b=aki6gR1h3nXU9vB6LfAo5dwOHN0hDmSuAxTK2nv4y64fd759NXBU/Lx/PowISIwEqPGIRXU80Y0qf7Nc9vofAiONrRwO62dB5NRDO1Dx0hBi9CzhSGsrLAHcQE8772JnMUR5QeNNgt1VZOhNnpto8ixFlzGrwhLlyNNVVtXpSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899422; c=relaxed/simple;
	bh=jeHQpRe/PYPkHOWH1dZb/CPMqdHQRIz2YV5ogvkCEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBPN/lKRIUq2ESZUiklGY5yB3o/6vdH+02YhGgmYnXvly7RLKpmgSzNp3Q9FovNipp27trvMkBCbDDLZydf28GdhQnP9xX1Lo2GSBQWymWYEyDwV88gs1iRbTm7HD7KO/0PsRbBuwsF1jdSIlOFJB94kG0vVpQct8exQHgXfKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=4Pk6DKq9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jtRdD2QDrxEQ5SkxqPR80IXjR4gRCZhQicNpQyc6IxA=; b=4Pk6DKq9GdrESGEpYij+gIu4Ei
	grrJBfLAyNUh6SS3kbeX3NEvVZyx8Y36pDSZABuWovkoIdvAZNqhbL/8sJmeNSkCT1bSN8hwyBo+L
	agDg7LK+sdjBp0AAYEIzvGg9/Qak/uPVkbLsACKnhRHgDl5eslxl0F5nvbR/asXONY8U+9cmNHztu
	9flYlxvY1KSlwo9utWlzCnoZPPnkCNZoyhM0E4pehlcoLVSTD9QX5TVfbZymOekBjH31XxZ5FkVQR
	uy0z5bEk5TUeJ7W4cS1cSWC3Ze8v6mBdEPPKDLqZZPW4BTkaQ0xldzRVSrU3z0JPLStJ5cNEQ/YLY
	MND02/5Q==;
Received: from p200301077700b1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:b100:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1reMni-009mAU-BQ; Sun, 25 Feb 2024 23:16:50 +0100
Date: Sun, 25 Feb 2024 23:16:47 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [RFC PATCH v2 3/3] gnss: Add driver for AI2 protocol
Message-ID: <20240225231647.3abdf378@aktux>
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

Hi Paul,

I have left out one thing to answer.

On Mon, 29 Jan 2024 08:53:27 +0100
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> > +	ret =3D ai2_send_frame(ai2dev, skb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	msleep(200); =20
>=20
> I=E2=80=99d be great if you added a comment, why this long delay is neede=
d.

Well, I am just a bit paranoid, s/msleep/wait_for_completion_timeout/ and
complete() on some ack would probably improve this. I just hesitated to add
something like this until I have the feeling that I do not need to turn the
driver upside-down.

Regards,
Andreas

