Return-Path: <linux-kernel+bounces-56201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31984C745
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114D8B26097
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A700225D6;
	Wed,  7 Feb 2024 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YkR73cNX"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDF21A02;
	Wed,  7 Feb 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297910; cv=none; b=EdtgOxGtTaLAkAvlgcW+xHbQ/ifyKiaTOrjq1LPN5qmvs9ZJqLB0Jw0yI+52P4dY0lsM67Fal19dI9/XwxxA98n6Che7C8meKDm6Dt0EfeCBGIimh3ApJrXuwJwxeZCT3DtPFfrzcjuBqCgzUCQNWxwADdIQO4u46aD1klpcvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297910; c=relaxed/simple;
	bh=MrbS0krXS6N/3hUWJYw0+iH5cIV0uUP4RwB9p1PsZyY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=jdOyqZgylV8iRe+9TPzwSwI7h3lDYHXrDM61ecWxKFp5y620TrALc2E3cRrWW9iJwRDBKoDcO1r24VWF+i3ifeoZY2+hLNTy3o34BCT5pWEUtXcOmPMQhwmwwhZ3S+wGZkVT+YornEV5t6xwuX0nJsWUEu4lXg+Qv9PM+4bFOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YkR73cNX; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5B411BF20E;
	Wed,  7 Feb 2024 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707297905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di64ZOAM2vLdH5tMcZJ9KySFYkZaryOSE9QANqo+8Xs=;
	b=YkR73cNXxVMV5BqFbB3cMJhSluPN4dCyXsKjrQii/NFgBBYamvFpsc0EvD0pTt4urHrJmv
	gJzQUQu0AyQZn1OGsu24bxGAPqMByuI8TaDJ/cXrf3ZDenfQQ/9JRFBOgGd33aln4V29d5
	FqKf3/ceWdQ5QnF7ZO/DVgur9008eSLzJlY6Stg8C7wiF798ok31a6AhSFlUgqx3z86PPX
	EkJxqjU7I73NUVnoVxoK7wwouhzb14KCTYlDLCsjvcgsrs921t+Tp1uL6AV5sdmu6hdK51
	uhb+Ectjhj5m6uQ16JfgntRqp+zBY7EpyftpZRa011+q11N4zBjPNxoUAarVQg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Feb 2024 10:25:04 +0100
Message-Id: <CYYQLHM3DXP6.3D4QG8IH7C4KE@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v2 1/4] spi: cadence-qspi: put runtime in runtime PM
 hooks names
Cc: "Mark Brown" <broonie@kernel.org>, "Apurva Nandan" <a-nandan@ti.com>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Dhruva Gole" <d-gole@ti.com>
X-Mailer: aerc 0.15.2
References: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
 <20240205-cdns-qspi-pm-fix-v2-1-2e7bbad49a46@bootlin.com>
 <20240207083333.jqghhzihzwz5yeeq@dhruva>
In-Reply-To: <20240207083333.jqghhzihzwz5yeeq@dhruva>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Feb 7, 2024 at 9:33 AM CET, Dhruva Gole wrote:
> On Feb 05, 2024 at 15:57:29 +0100, Th=C3=A9o Lebrun wrote:
> > Follow kernel naming convention with regards to power-management
> > callback function names.
> >=20
> > The convention in the kernel is:
> >  - prefix_suspend means the system-wide suspend callback;
> >  - prefix_runtime_suspend means the runtime PM suspend callback.
> > The same applies to resume callbacks.
> >=20
> > Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support"=
)
>
> Not sure if it's a bug as such since there's no functional change other
> than renaming.

I see where you come from. I'll fix it when/if there is a second revision.

[...]

> No objections as such,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Thanks!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

