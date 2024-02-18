Return-Path: <linux-kernel+bounces-70427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF52859799
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6F1F21481
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E176D1A6;
	Sun, 18 Feb 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="jR35gko6"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225D1E48A;
	Sun, 18 Feb 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269544; cv=none; b=WCOMWBE1BLQ9TOM2EvWhlmmHSqvi+DqjoEJYNLM80w+yezfe3n+vekMOsovnN+dQKGthiFDjNnowYq3E5bjlSyBKakYpLTGeVi8/CPGalBkUUTdTc+CnFIpmluxY5grnbCmLBUzuDZ2hNFWttYC3UxQJEWMBr8rihZ+nYTaMj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269544; c=relaxed/simple;
	bh=dHAGCgeVmGjm43yn4Gqxh+5WsKjJyWWIZnh1ext83uM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:Subject:To:
	 References:In-Reply-To; b=pnWq5XG+zYx5loX37zAO5A+hY3/DGaxvFWnOSx3afVwaQwTyAJC6BolwXdUeOamQrs5F+eAYX0cfLD0c8JKPPWi/CluytK5vXmCMLKtKxQKkv5IB6oshNNAg/17ykTBjuSNmwuJAXnEJEwwUmtk4TMTqD0Dgo7hfaqK1WXHfE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=jR35gko6; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 7B0142807E0;
	Sun, 18 Feb 2024 16:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1708268977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAxZkLmX1aRHRUsZ0ExGlhAyhq9nsWkycT8rOvRVdsU=;
	b=jR35gko6R0Gi7XNdojRdFa5sTNjDxzgE8LriPPgFpACmMlg5qfwiU5T2JrgbSIqhVDxpYo
	I1lkkmwo7c9tx+KGWuv2n2Fd9y1lPIUeOLIXPSlE5BQr8qvJ3MTLBWNw1QEe0Tymwxpd7T
	Lwyg69c5f7FQ1wcGo4p+8wZik0daxw4=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 415C24570C6;
	Sun, 18 Feb 2024 16:09:37 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Feb 2024 16:10:10 +0100
Message-Id: <CZ8ATPJTOA3U.2QJSJY50EX2YH@gimli.ms.mff.cuni.cz>
From: "Karel Balej" <karelb@gimli.ms.mff.cuni.cz>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Lee Jones" <lee@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, <linux-input@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: mfd: add entry for Marvell
 88PM886 PMIC
To: "Rob Herring" <robh@kernel.org>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
 <20240211094609.2223-2-karelb@gimli.ms.mff.cuni.cz>
 <20240215142052.GA4180777-robh@kernel.org>
In-Reply-To: <20240215142052.GA4180777-robh@kernel.org>

Rob Herring, 2024-02-15T08:20:52-06:00:
> >  .../bindings/mfd/marvell,88pm88x.yaml         | 74 +++++++++++++++++++
>
> Filename should match the compatible.
>
> In general, drop the 'x' wildcard.

By "in general", do you mean for the drivers code also?

As I have mentioned in the commit message for the driver, the other
device is very similar and if the support for it was ever to be added
(which I personally currently have no interest in), I believe it would
make sense to extend this driver. Is it then still prefered to call it
all just 88pm886 now?

> > +properties:
> > +  compatible:
> > +    const: marvell,88pm886-a1

So the file should be called marvell,88pm886-a1.yaml, correct? Again, is
it prefered to call it like this even if the other revision could
eventually be added (again, I am not interested in that right now
personally)? I mean, if I was implementing support for both revisions
right now, it would make sense to name it just marvell,88pm886.yaml, no?

Thank you, kind regards,
K. B.

