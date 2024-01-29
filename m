Return-Path: <linux-kernel+bounces-43476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BB841463
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FE51F235E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35804153BC4;
	Mon, 29 Jan 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hjh4Q8+U"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B32241E9;
	Mon, 29 Jan 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560471; cv=none; b=I1jxGb+EDJ76Lz3q9eHrsceb8bYk4eKGSWtjeWt81bd3C36eJQB4ucOMSrKP0UxW2NvlJVySmxBAixvmBpkiWg78PLp9SOZvrOkhAP6TddLQEUWpMi7DlqzTfGS76fOuiNk4TsDg6l7NWtiTJUIXsU4VYqBjVlKJ3BC0H7cgIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560471; c=relaxed/simple;
	bh=RTzuqnmngPY/OIwUOShwFsqce0TD1wiEUlgbjjROOj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRVKIEAf/ycJGVonJu9TCQ4e7abYdFu016EkYMQ7KunOgQ7kYa+aN+4WPWAVCAxCKZYKVym/HhlbKNbYSoNWreLWJ2dek4pW9bTWfkiA+gY3pCUr8fb7SHNfxfmmWpae5Kr4oO3zWaItVY08EHiM0teYMalRWrwQIQGEZYMQAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hjh4Q8+U; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RTzuqnmngPY/OIwUOShwFsqce0TD1wiEUlgbjjROOj0=; b=hjh4Q8+UsRsAyyTpXDotmMsBb5
	4X7Kn/3OU3V4eXMp15WwfQKJI9neYg8x6qA5lMcumbsw7ugyFdnm1jrWwzn8CPJnm48Y4LCELxmC+
	88HU3HPvhusQzmvqLXsyLXGz+DKYtvfGFNrii+FusRY+osHRHzl1UmNIDErZlz/3SWAcioIXzjn1y
	bD3hs+jwNbOIGF4RG/XQNsJKlqrPc+SKZ4T5YW0uFByKWjb92Fe6ucoSSOAIoGf/hVRplH/qfCm7s
	wryEyi/mE4n7dPIDrU2DBn+0VtU+GdTH61CQ8vqRHDHMfHow0aBupTGa03AnnDwp3WR/2sXUjBB4z
	nCbM6gcw==;
Received: from p200300c2070939001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:709:3900:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rUYKh-008sGD-OZ; Mon, 29 Jan 2024 21:34:19 +0100
Date: Mon, 29 Jan 2024 21:34:16 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [RFC PATCH v2 1/3] gnss: Add AI2 protocol used by some TI combo
 chips.
Message-ID: <20240129213416.61f86524@aktux>
In-Reply-To: <c8af1073-22ed-4c14-be85-67632d82a3fa@molgen.mpg.de>
References: <20240128173352.2714442-1-andreas@kemnade.info>
	<20240128173352.2714442-2-andreas@kemnade.info>
	<c8af1073-22ed-4c14-be85-67632d82a3fa@molgen.mpg.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 29 Jan 2024 08:40:58 +0100
Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Andreas,
>=20
>=20
> Thank you for your patch. I think Linux Bluetooth patches need to be=20
> have Bluetooth as the prefix for the commit message summary/title. Also,=
=20
> it=E2=80=99d be great if you removed the dot/period at the end of the com=
mit=20
> message summary/title.
>=20
well, it is not a Bluetooth patch, although sent in a series with a Bluetoo=
th
patch included, so having Bluetooth as th prefix just does not make any sen=
se.

Regards,
Andreas

