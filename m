Return-Path: <linux-kernel+bounces-111744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBC887049
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C28A281AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485F56B80;
	Fri, 22 Mar 2024 16:05:30 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AC50249;
	Fri, 22 Mar 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123530; cv=none; b=fHveUWzMCOoLeCL4q8P65JfO5psBC1tfpUz0jgvMRLDyOdvK4pHhm+dlvZzLKVsbjCMpH9OrNnrddipfGa9s564YYsFjZBAQw79e++PQ/XKVZ0HC+k6j+h4STJefMyAZ8qgvdnkgAZNiWetiT/Xs9lKMJdHXNtF3P07PoHObpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123530; c=relaxed/simple;
	bh=IV+OAjI9wnnxfMCGrBCAD3gzlO25uVV33QSEA4X33AM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oaCKmfTb37XAcaAgXh3fy9IVC/iL1cqc94jT95vMjZPQtFgA9IphRY6W0ywK00PD4ttqgdHGQoQNVYgw8d0U+PMEzR5K8acKAzRMsia6tve7SkiEb5z5dUVYC9qHN2MixSzpBvts5EG1Y8wZncYLxhX+u1i1ngaqshFwVpF0ipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6223C6450948;
	Fri, 22 Mar 2024 17:05:19 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id apiN5osYyNZi; Fri, 22 Mar 2024 17:05:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F245161F0A9F;
	Fri, 22 Mar 2024 17:05:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EYt00MZaZPo2; Fri, 22 Mar 2024 17:05:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id B6A4B61F0A9D;
	Fri, 22 Mar 2024 17:05:18 +0100 (CET)
Date: Fri, 22 Mar 2024 17:05:18 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <2125862147.90778.1711123518626.JavaMail.zimbra@nod.at>
In-Reply-To: <Zf2qQSRWYDzKd4--@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org> <20240219120156.383a1427@xps-13> <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at> <ZdvV1KABu_UCSL7B@makrotopia.org> <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at> <Ze5uUyUuEDBM3p43@makrotopia.org> <1196553263.78350.1710887478387.JavaMail.zimbra@nod.at> <Zf2qQSRWYDzKd4--@makrotopia.org>
Subject: Re: [PATCH v7 7/7] mtd: ubi: provide NVMEM layer over UBI volumes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: provide NVMEM layer over UBI volumes
Thread-Index: tOfo7y+yLt5SSiGVRI1o4gXoH7tsLw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> So: hold my beer, I'll be back shortly ;)
>=20
> If anyone has better ideas on how to utilize support for raw NAND or the
> OneNAND controller in QEMU in a device-tree environment which actually
> works, that'd be great. Obviously I don't care about other peripherals
> like Bluetooth and all the complicated stuff of the N80x...

Speaking of "hold my beer", maybe we can hack something into nandsim
to act like a device tree attachable device?
In theory, device tree is also available on x86 and other non-embedded arch=
s.

Thanks,
//richard

