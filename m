Return-Path: <linux-kernel+bounces-54584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DE84B11F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71C91F24CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C8312D15F;
	Tue,  6 Feb 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Iw4KdpID"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145477C089;
	Tue,  6 Feb 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211512; cv=none; b=s8tXVOM95qlbpsY9ypTr5WqxLbbTBMf4uHWpXt4hbkt8YUyh8vrasBCCSmNZY11WQpI13PrX/zFtK9MPCmlNFLPWg2woZ/e2zzPJnxehFu1QO0CG2tq1jBxnWR9FwEOcq2/9tuWdMLPGJoM3aE67kGCbcLXmPflQTjxso/YWSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211512; c=relaxed/simple;
	bh=riKlsk6DpHbTsX/xEYw4fkuGAFJRzfFBHy5xenHiV9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMHdN9s69Q8KPRf6ZhEjFbSR/vE3iDWEs9rNQiVIpxFCgoI2h8/MQEacLs9+5H6zCCR1HNveMYUUCd6QoQOB9CKwpKtwWDh7tJqwzyBKKx+pydY0wr6PGFoSiVzCE2oVuiJnInkhZLfP5cNbsBKtk9VLocG9vyJ4tDEsTKKvITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Iw4KdpID; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56FAE20009;
	Tue,  6 Feb 2024 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707211507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riKlsk6DpHbTsX/xEYw4fkuGAFJRzfFBHy5xenHiV9w=;
	b=Iw4KdpIDslEDAAsEdPCzzvsVRq1AoSGBy/Iei8CbkA2o1EFI0wSDi9kDiGUDXjxRS2GWIt
	vqBWBXNKlcGulSAIbG50DQcFusf6tUIh5tw6YgRJS087tE4QEzZ+W10030xlPMNvl2HQJH
	M+DrESUwaHV6Zk1ofs5zNM0GBng3nh6q5McKIy1UKA+E3BGbz3iGjrlQDIPe6owgKXi+fc
	lBdL+4RCZW0GlQQ5iSia53vwAdT0MKeUk2zst11d/ChM57H9hjCpzwv8LFH2cXR9wYEZEf
	tHILslCnTsAg/W5fVVALFkG93WwvscrQUcfE0um2DpDr5eiEG1yE8D7Z5DwgvQ==
Date: Tue, 6 Feb 2024 10:25:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Bo Liu <liubo03@inspur.com>, alex.aring@gmail.com,
 stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
Message-ID: <20240206102503.760ecb64@xps-13>
In-Reply-To: <CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
References: <20240202064512.39259-1-liubo03@inspur.com>
	<20240202085547.46c81c96@xps-13>
	<CAK-6q+jnZOkSAM8_BQH=CaQhfCQwm0P+segZ+0E6oLeX=BhLHQ@mail.gmail.com>
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

Hi,

aahringo@redhat.com wrote on Mon, 5 Feb 2024 14:42:09 -0500:

> Hi,
>=20
> On Fri, Feb 2, 2024 at 2:56=E2=80=AFAM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
> >
> > Hi Bo,
> >
> > liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:
> > =20
> > > The maple tree register cache is based on a much more modern data str=
ucture
> > > than the rbtree cache and makes optimisation choices which are probab=
ly
> > > more appropriate for modern systems than those made by the rbtree cac=
he. =20
> >
> > What are the real intended benefits? Shall we expect any drawbacks?
> > =20
>=20
> I doubt it has really any benefits, only the slowpath is using regmap
> to set some registers. Maybe if you change phy setting frequently it
> might have an impact, but this isn't even a path considered to run
> fast.

Ok, thanks Alex for the info; in this case I'm fine:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

