Return-Path: <linux-kernel+bounces-98338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D317877895
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE30728187A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A423A29C;
	Sun, 10 Mar 2024 21:17:30 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E233A1DA;
	Sun, 10 Mar 2024 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710105450; cv=none; b=VgBx6r1/n4uvk8otn+j/WjfkzNmnnEgoFrA+iiI/m28aNzL9b4WZg3/cINxEOz8CMg47PHYprmi396cMm82kJpCytF76jAUW3Icteuc97k8j6dajflG3g1ZmUZIn4/ZUJmcJuAcQeHbr4hy+MzOXQLyarir1CTzjeBu5dxOBkV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710105450; c=relaxed/simple;
	bh=jh0Bg9u2cEU/kuFQ89GZ8ssWpyF6wQ3Yl8hM4/OfJ3Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JHBuu69L5sEARnnny/LWoMj80fxqmORF4HCBU941KUrqKcIYKXphfOlRdigH+dflr4kECRhFkkZg+r4Fi0us4TLLiEV9hzsDL+c9WLqPWtrXr89uvVeD/G2YT4o09RRCvl3e7XiK1mPGZ/mtp9FogrooCfl+GKD3ILj/Ue4r7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D7A79644CE9B;
	Sun, 10 Mar 2024 22:17:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QPqD6-Gs5_lr; Sun, 10 Mar 2024 22:17:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4B97C644CE9C;
	Sun, 10 Mar 2024 22:17:18 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hPYilfTa8vD1; Sun, 10 Mar 2024 22:17:18 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0F7A0644CE64;
	Sun, 10 Mar 2024 22:17:18 +0100 (CET)
Date: Sun, 10 Mar 2024 22:17:17 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1754825522.38834.1710105437883.JavaMail.zimbra@nod.at>
In-Reply-To: <ZdvV1KABu_UCSL7B@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org> <82ceb13954f7e701bf47c112333e7b15a57fc360.1702952891.git.daniel@makrotopia.org> <20240219120156.383a1427@xps-13> <1209094181.98490.1708899174329.JavaMail.zimbra@nod.at> <ZdvV1KABu_UCSL7B@makrotopia.org>
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
Thread-Index: 16y/pO9tIckbepFtGo93wkKFo34z8w==

Daniel,

----- Urspr=C3=BCngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
>> Finally(!), I had enough time to look.
>> Thanks for addressing all my comments form the previous series.
>> Patches applied.
>=20
> It's an enourmous coicident that you are writing just now that I found
> a sizeof(int)-related problem which triggers a compiler warning when
> building the UBI NVMEM provider on 32-bit platforms. I was just about
> to prepare an updated series. Literally in this minute.
> Should I still send the whole updates series or only the final patch
> (as the necessary change is there) or a follow-up patch fixing the
> original patch?

I have just merged your fixup patch. So all good.

>>=20
>> I have only one tiny request, can you share the lockdep spalt
>> you encountered in ubi_notify_add() regarding mtd_table_mutex
>> and ubi_devices_mutex? The solutions looks okay to me, but
>> if you have more details that would be great.
>=20
> I will setup a test build to reproduce the original warning and
> let you know shortly.

Any news on that?

BTW: Is there a nice way to test this with nandsim in qemu?
I'd love being able to test all ubi attach code paths on my test setup.

Thanks,
//richard

