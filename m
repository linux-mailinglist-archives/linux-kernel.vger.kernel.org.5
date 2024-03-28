Return-Path: <linux-kernel+bounces-122334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048D88F559
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913561C2936C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD712577B;
	Thu, 28 Mar 2024 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="G2OD3wfV"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AE15EA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592732; cv=none; b=OgjNCw8letcdvIFNYKI6Oaxi6j0CmZROeS5zu1PazMflRABhR35X6uSdh8Y2jFRTfGhE2oeDMekUgISp0hw4t7pulGX5MTeQS1vk42KgZAQhUcxglp8Nb/qzT3DHwe1IeROWj6i1rFtwV61BScJXXZHM96iWq7qE5ZMSogxM45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592732; c=relaxed/simple;
	bh=F+2PBUITY1EMreS647dj+r5aRdhFyJY4oSvc7+Zjjm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3HRn7ogMI88MfAAhBHLtVSzRKwQtyxr0xKBFgwBPsWiAim36VcOcCNfJHYk8xeqnFe/ZmtFfBDuPSk6x0I3AsOHJx3DASEwFpCY3HlUMAlPigUmGNNFMneoi+IFjv2N58qoPAJJMIboXMkEodDWHJW8w8VybDQBMc7FRH+M/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=G2OD3wfV; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Thu, 28 Mar 2024 13:21:21 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1711592727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVrUwsE3K2gkHszUejGPBHKGdhDZo6IS90T9be1UVRk=;
	b=G2OD3wfVYM0ss3YS0/hftkRoFZurKH//5tklL8kaS1+kbz7cV9JwDJQEkjafN9YyOYVga7
	iAtKt0h33dl4cqSGD9SpSVTKa5a2HZFKJDwhvXdHdu1Yg7PgnU5u12HM9DNO8jaFkGLDZ/
	l9XiKSjm9JUd8hL3hHyG4+jDBX2AueMmetrPawbPGyroTIuOvJ57QrH3B6qjM0jWZT8sQI
	YPCpwn8je+YSB8wN/v/oXVTFgKH7oL468NXorJ23NSdPiuRDKz32jVPRoh6x2/wi9MavwN
	1doruKSlm1g2UntpnxUDvOn5+QJWriuYDpi/056MOyPWY/gjhSTeMT/JE5WaMg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sunxi: sun4i-i2s: Enable 32-bit audio formats
Message-ID: <ZgTUIWh8qXH_7oxQ@titan>
References: <20240326-sunxi_s32-v1-1-899f71dcb1e6@jookia.org>
 <23447395.6Emhk5qWAg@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23447395.6Emhk5qWAg@jernej-laptop>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 08:53:32PM +0100, Jernej Škrabec wrote:
> I wish it would be that simple. SUN4I_FORMATS is cross section of all I2S
> variants that are supported by this driver. If you check A10, you'll see that
> it doesn't support S32.
> 
> If you want to add support for S32, you'll have to add new quirk for each
> variant.

Yes, A10 doesn't support it. But it should error out in hw_params due to
get_sr not supporting 32-bit, no?

> 
> Best regards,
> Jernej

John.

