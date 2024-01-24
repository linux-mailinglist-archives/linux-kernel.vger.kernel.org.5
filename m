Return-Path: <linux-kernel+bounces-37559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F084083B1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E71C2348F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EF131E35;
	Wed, 24 Jan 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="j9mgSg72"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE112AAC0;
	Wed, 24 Jan 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122729; cv=none; b=K5RWsKYdg2rswrk5PxtGh2ZoCXbNCH1vYGjQevU1EkraTqCQckuCVdSgNYjSvLXoZe8ntjes2Xg2MGTeyUITpRSnL/Zboch2rpwWfmZ57v91W0z6JO65T6l7FCdqaunqdU3HbJ+wAOxqA5NSBNH9V9UEMCvRUiye1csq8+LssFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122729; c=relaxed/simple;
	bh=idpivWfwh0y0q2Kq4FzfMntFi5dUXTuAC4flqOAXS3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLScr/prbAMHVJkHxfcsEaC/5QJUFbFXcWef3kN7SfYpuFLMrZgUMXl5f7b2kWcM40LrNCYVTFKIPoFFVQFgRJlmEQzfcpGLPtPgS2U2fLDAFg+fZHXSP7qkdRPUctrv5MuNPU6O9kDZnF+P9LR4BH0UtFmGSRd/1fZR7Yaejgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=j9mgSg72; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 087C31C0076; Wed, 24 Jan 2024 19:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706122718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idpivWfwh0y0q2Kq4FzfMntFi5dUXTuAC4flqOAXS3s=;
	b=j9mgSg72l5T6vbfY+R9izxsUIOURfKlNIzDD5yoBUEJ7PEpZ34psQdIIbBt2QaboxYLFA2
	c2FyiPuQ+7mD0zLnsn5GsbcRq2BUSNWxATbUcP7K5WOLIflJHe64UmJsx0jBiYMLd645B5
	8XS2d/1q05d6Nu6qmNoDQlwjcBjpLKI=
Date: Wed, 24 Jan 2024 19:58:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add front/back cameras
Message-ID: <ZbFd3uLhTnapk_lv@ucw.cz>
References: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123214729.2852346-1-andrej.skvortzov@gmail.com>

Hi!

> Pinephone has OV5640 back camera and GC2145 front camera. Add support
> for both.

Thanks for doing this. I'm currently fighting with kexec on pinephone
(it crashes as soon as I pass dtb) so I did not test this, but hw
description looks fine.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

