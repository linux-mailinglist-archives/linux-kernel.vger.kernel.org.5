Return-Path: <linux-kernel+bounces-81136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0F8670CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ADD28CF06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767059B53;
	Mon, 26 Feb 2024 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="p3IRZnxf";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lbbkSU6T"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83411EB23;
	Mon, 26 Feb 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942318; cv=none; b=McmFbvY0tC4o6A1kXFIHI+J2MhO+wqptf+iP3Gn4gRcNaKaER+hlHsgd+z2RPMVBZUwGr8phWnGTkDdfDTG19Kwi5XJ5zRmnkr0JB6qPX/t20Qbl9rNsMLVmZ/sYR4lehW79Qv0O2mNi8zc9n6OR3vgP6z3iPtdoa6HnT71a8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942318; c=relaxed/simple;
	bh=/FqJlwO4HhiqdkOMLE28w4KSlJDTesC5Lg2W9QEnznY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODymdoMfazxo511YWal2vdl2x13uCJ5KT/3R3ystndV/DV+AZjRP+qxSTyGLn0eO5J1uXh2+ILdEZ4dy1RJta56NAb0g3DU+EELR3TE0ayiRG1ZrzhG4Zsib20IPxDCkoIH5UN24K/B0nUyO2YD9UBoyQaVzGuW0tDRjgcjUHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=p3IRZnxf; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lbbkSU6T; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708942316;
	bh=/FqJlwO4HhiqdkOMLE28w4KSlJDTesC5Lg2W9QEnznY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=p3IRZnxf04YywA9yOAt94SHpGuoPlkX2yTY1X8D0bC+pAYhvzhhIpIMCZy+Ki7qzr
	 QpC7GQwDzrMcLELadGRMEXnptm24iH5u/P5nJmF9g+zHuK1Qhks/7w52Z/KxtPvfFK
	 DmMNaC1OKR33N7F7pzer8cenPyNZQBUCw6eq1xTY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 063741280599;
	Mon, 26 Feb 2024 05:11:56 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id QC0roj-h_XGp; Mon, 26 Feb 2024 05:11:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1708942315;
	bh=/FqJlwO4HhiqdkOMLE28w4KSlJDTesC5Lg2W9QEnznY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=lbbkSU6TwLNPTeFszSwjmRYg0qSz6lsn14R/1skXOq1N77lslD65E3Hh1xSK40haF
	 wzSSlZ7dcFirYkBZkMrTJyrO1c8xZS4iVbB0m8Hkp3jDXJO2qDU9WTziNgBcOO8gZ5
	 JINKl8HBpgh453D6bS6SlU6sjI0gcZOv1HhcYw8U=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C8A24128032D;
	Mon, 26 Feb 2024 05:11:53 -0500 (EST)
Message-ID: <3bae009a24a55902d93e4055ecd13f9f54cdbb37.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>, Peter
	Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Date: Mon, 26 Feb 2024 17:11:51 +0700
In-Reply-To: <CZEWILFMZ5L1.2TCZXVS7GTDKZ@suppilovahvero>
References: <20240226062245.2279635-1-jarkko@kernel.org>
	 <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>
	 <CZEWILFMZ5L1.2TCZXVS7GTDKZ@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-02-26 at 11:26 +0200, Jarkko Sakkinen wrote:
> On Mon Feb 26, 2024 at 8:49 AM EET, James Bottomley wrote:
> > On Mon, 2024-02-26 at 08:22 +0200, Jarkko Sakkinen wrote:
> > > Add TPM driver test suite URL to the MAINTAINERS files and move
> > > the
> > > wiki
> > > URL to more appropriate location.
> > > 
> > > Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> > > Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: linux-integrity@vger.kernel.org
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  MAINTAINERS | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index bf77be03fb2b..6380c1109b86 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11947,6 +11947,7 @@ M:      Mimi Zohar <zohar@linux.ibm.com>
> > >  L:     linux-integrity@vger.kernel.org
> > >  L:     keyrings@vger.kernel.org
> > >  S:     Supported
> > > +W:     https://kernsec.org/wiki/index.php/inux_Kernel_Integrity
> >                                              ^
> >                                          Missing L
> > 
> > James
> 
> Thanks! I'll fixup that.
> 
> "linux-tpmdd-test" is the suite that I'm using to test your patch
> set. It has swtpm integrated. I wonder if there was easy to way to
> tweak swtpm to emulate "interposer", i.e. reset its state while it is
> running (preferably not by restarting it).

The way I do it is to use a qemu patch

https://lore.kernel.org/qemu-devel/20231004184219.6594-1-jejb@linux.ibm.com/

which allows qemu to connect to the mssim (or ibmswtpm2) TPM over an
inet socket which means I can execute TPM commands from the host (like
resetting the TPM) as well as the guest and snoop the TPM traffic.

James


