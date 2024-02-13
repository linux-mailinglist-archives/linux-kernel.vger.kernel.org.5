Return-Path: <linux-kernel+bounces-64177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F094853B38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029762898E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3D60B94;
	Tue, 13 Feb 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="n2tBm63M"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F860263;
	Tue, 13 Feb 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852978; cv=none; b=bg7Ip6XIdYRo7dfou0uOrZM5KIA5k/vnKjSa7NgEsRR/a6CXkK6QbRgMswkvgFVFuHVHKWw3adwFTy06zEHoxqYlwqaV3yI0R63ezpqSCXkEVvitH0okex/21bwipIQLKBJyNoKRPSVfceLAsf1Ex+zxFfyX0w+wG9lNuGnzIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852978; c=relaxed/simple;
	bh=d7K2JQulCuhpnm56OWHlm77lVRR8659PaC63yui03SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umfTJCdi7n9OFUsAStcxCCGVK0emlNqTv2pvBFHbmGu4AsjI+m2iqnKEivDxna9WiGaNcmy5CM3UAwlJgUEltPZ6UNbP8x/Zxn0tad/OWc9hBbkeBeSGi6bD07iPG1wX/XpN4mBbyzatt3NyWH5HT7X4EUZ/WrH3eQ47UvvnqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=n2tBm63M; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eT8/BFgimu3HSsjaK7aAfhbdMsoZx19Yyb187hpoUJ8=; b=n2tBm63M5QFHlcpMTWOGDXk9Cp
	fDFJHXpK8edY+o4kBSSuO00IculrrCK2RwfVcWoSzvmkgEimLrIwP6Q8oq3lC6QRLVVYtors1gdaS
	hRcbGxPOp1SfSwebpbbPp07UHm8XCUyKezklGKguD0P+WKY+btE7BCDcf+N4+FoP8jNb3IGV7cf0u
	5r9nlv+Dhlf0e0x8d9iXyh3NsA8ySt2VO4GEG+oN6hy4k6JBTzqNCocuz/Re7PGs9/3Ex2MKAHmYK
	6OTMOVANrOeakpoEc1QyHFet1ZyOf3IggRDAJZZ8QCMvdeg/njmVTEJVkvkrVn7edBGirjb0UXw9V
	4MolsIQA==;
Received: from p2003010777002c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:2c00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rZyKH-009PSB-H1; Tue, 13 Feb 2024 20:20:17 +0100
Date: Tue, 13 Feb 2024 20:20:15 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Adam Ford <aford173@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Tony
 Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com,
 =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>, robh@kernel.org,
 hns@goldelico.com
Subject: Re: [RFC PATCH v2 3/3] gnss: Add driver for AI2 protocol
Message-ID: <20240213202015.08a0a3ad@aktux>
In-Reply-To: <CAHCN7x+rfwNeb+xOnLmQR78MQVDwGOOEHqnEceJcDkMrRJtE5Q@mail.gmail.com>
References: <20240128173352.2714442-1-andreas@kemnade.info>
	<20240128173352.2714442-4-andreas@kemnade.info>
	<CAHCN7x+rfwNeb+xOnLmQR78MQVDwGOOEHqnEceJcDkMrRJtE5Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 07:57:10 -0600
Adam Ford <aford173@gmail.com> wrote:

> On Sun, Jan 28, 2024 at 11:34=E2=80=AFAM Andreas Kemnade <andreas@kemnade=
info> wrote:
> >
> > Add a driver for the Air Independent Interface protocol used by some TI
> > Wilink combo chips. Per default, send out just NMEA to userspace and tu=
rn
> > on/off things at open()/close() but keep the door open for any
> > sophisticated development regarding the AI2 protocol by having a kernel
> > parameter to turn it into raw mode resembling /dev/tigps provided by so=
me
> > TI vendor kernels.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
>=20
> I am still trying to find a GPS antenna for the Logic PD board I have,
> but it occurred to me that the kit that I have used may require
> special GPS firmware.  Are you using any special firmware in the radio
> in conjunction with these driver patches or are you using the standard
> bts files?
>=20
Just
https://github.com/TI-ECS/bt-firmware/raw/master/TIInit_10.6.15.bts

I removed one command (by setting type to commment) regarding some clock
configuration.

Well, maybe you see NMEA without antenna, maybe you get an error message
because the module "feels" the absence of an antenna...

Regards,
Andreas

