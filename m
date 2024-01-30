Return-Path: <linux-kernel+bounces-44787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AC842766
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BAB28401D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0807E766;
	Tue, 30 Jan 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hdAwoaf1"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E77CF08
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626827; cv=none; b=fBX/3Yh/ikXaBvrX6hrcN0O13Trw6K3ZMxwoXuM+pJ5IcYojpejG1HpXbVjTWuIjJzZU7daLdPwAWMQeAJiwEVzBswtJyUWGUZqRWd75hZf/GvVxu6HAaQADiocZyb17S1VSw0/uucmS6i0axuVlYa9t8vIxWHpKkjfeBQSWnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626827; c=relaxed/simple;
	bh=efSG7SSvYuTZmaIZe1rT07IPTrpLnxs1P3jW8v0XLtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sm4/zTCpdLaD/QAp+d9PhKj9+fR44kfQXwMbIjfkp6+v5iuy2nQOvUv6vOQd93TTEY/jIIvgF2gPILSILStUjFMkmav1O313Ii121QEAXBZch8I4YiJcoTOnvrx3RFCWBZjDnTipoP/eRBtQeDRGzdwcEv/85wapzXQ1qvDWY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hdAwoaf1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F1BA1C000F;
	Tue, 30 Jan 2024 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706626823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efSG7SSvYuTZmaIZe1rT07IPTrpLnxs1P3jW8v0XLtI=;
	b=hdAwoaf1yqqfueCdiJ3rQuvOKterIxAoxcJRv529yjB24HPJCGH+LfD0Yakjqi7IophcKc
	H2mb0uKAUpNsHQlFYha8G+8l7326TVVPXdueWR7FTeGag8a6QdlzkspgjyoEKua7c9CzlS
	KAvOTp47z2/j7VHMRmBpa4cgm7DkguDBaOOVD/SYA/aXhfCboQRpLhO0w7OBdkIyPq9wBU
	lB4HllvFP5Z0UJ9yG09ZDbb4HtKqlWxArB09xio/mW/NHtCsIC6toDyJfnSlYQFQ1b3alU
	SSjXwjt7/e4/y3POEZlpw4UYJopVsvBd86drrjDDLEeLSEfHRU76FA05yoK1Xg==
Date: Tue, 30 Jan 2024 16:00:21 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "michael@walle.cc" <michael@walle.cc>, "rafal@milecki.pl"
 <rafal@milecki.pl>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "luca.ceresoli@bootlin.com" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] nvmem: core: add fixed-layout declaration
Message-ID: <20240130160021.70ddef92@xps-13>
In-Reply-To: <d568b3e2-0305-4041-9f6a-8375b5c497b2@leica-geosystems.com>
References: <20240111152849.3649549-1-catalin.popescu@leica-geosystems.com>
	<20240111164145.39255eac@xps-13>
	<d568b3e2-0305-4041-9f6a-8375b5c497b2@leica-geosystems.com>
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

Hi Catalin,

catalin.popescu@leica-geosystems.com wrote on Mon, 29 Jan 2024 15:29:31
+0000:

> Hi Miquel,
>=20
> Now, that "specific" layouts are considered like drivers and rely on=20
> NVMEM_LAYOUTS to populate the nvmem cells (layouts.c), I guess it's not=20
> possible anymore to consider "fixed-layout" as a normal layout that=20
> should be treated the same way than any layout. Unless, we move=20
> "fixed-layout" under drivers/nvmem/layouts.

That would be the relevant approach, yes.

> But, this also means that=20
> "fixed-layout" won't be supported anymore out-of-the-box (by nvmem core)=
=20

That would not be acceptable indeed.

> and will require additional kernel configuration change.

This would presumably be manageable however.

No pressure if you don't feel like you could carry that task, it's not
longer trivial.

Thanks,
Miqu=C3=A8l

