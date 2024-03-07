Return-Path: <linux-kernel+bounces-95766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F4787523D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33791C21C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D4127B7C;
	Thu,  7 Mar 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BwetML2N"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F81E866;
	Thu,  7 Mar 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822849; cv=none; b=CzhSNNu3G//HmmsL+vKxnMi1gLBYw3FYE0fix9zBlL4ZDuE8r2TLiTg10g6vaH/7LXTrHK07LVbGqkX6ZsMzkhaT45+qX9qajyTJELNHEOcgW0NbEPZB8MlVl0Q3xhu6ffeEp64eRLf3oNwwVG2nFxo3tVgmi2dpNig0Gd4YVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822849; c=relaxed/simple;
	bh=Km2LqwgcdVVDZyJtk6ImV9GP5lvaIR2i3Xbk0PN+jYk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=NMTn4I05fLl8FugjmNKC9nFibK8FEkZYPIzvJqKJ08x/jqnMnhChHMy4XshVfRv2Q/CSSQssmeWG4qlIBFMsE+GbWC+7ps6zb2fpVYdcsl0Tfa2gcLO4cggqMp1BSzd2Zh9nMgf4xZde2+tCWlRjfckBUYu7BEs6Z5du0uwiXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BwetML2N; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A8681C000C;
	Thu,  7 Mar 2024 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709822843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km2LqwgcdVVDZyJtk6ImV9GP5lvaIR2i3Xbk0PN+jYk=;
	b=BwetML2Nvuxg3humKkkGofoQSPzBvCFAr3106R7KsRbVuH95a8R3iv32qZfqvW3hP1N/bU
	QftFWxf0kZmTZqAZ14iNng5XmOj46xH7JwF1PGrUQXPa3PRbxTA2yviKPDqxdZIjgAVf6d
	vgwGwNsamireV7q6t9GjpudPj18/oW6Oo2W70U0MFchAZT1FkTYS4cwnBsyqfurtg5u+fO
	tpONToan2coljFio+GwUqS/Lckl7HhAbEy6XGEobh52HN67rkgo7C3/mNmSEwDAuIaMzUu
	zB2kqhqRXi29lyzlGSoeDhfcBpyuk0MNtUtJ4fA9+YGQ1b73Osi+lT56zb5Vpw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 15:47:21 +0100
Message-Id: <CZNLM1VYID7L.1PVM0H06E6TBO@bootlin.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Kevin
 Hilman" <khilman@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>,
 <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
To: "Roger Quadros" <rogerq@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Chen" <peter.chen@kernel.org>, "Pawel
 Laszczak" <pawell@cadence.com>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 5/9] usb: cdns3-ti: pass auxdata from match data to
 of_platform_populate()
X-Mailer: aerc 0.15.2
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-5-5ec7615431f3@bootlin.com>
 <bc361325-1510-4fe0-a7ee-bc5be0a1b4cc@kernel.org>
In-Reply-To: <bc361325-1510-4fe0-a7ee-bc5be0a1b4cc@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Mar 7, 2024 at 1:38 PM CET, Roger Quadros wrote:
>
>
> On 07/03/2024 11:55, Th=C3=A9o Lebrun wrote:
> > Allow compatible to pick auxdata given to child platform devices.
> >=20
> > No compatible exploits this functionality, just yet.
> >=20
>
> This patch could be merged with Patch 7 so we know exactly how auxdata
> is used?

Indeed. I liked splitting. Previous revision had it as a single patch.
I can revert.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


