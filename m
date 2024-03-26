Return-Path: <linux-kernel+bounces-119713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF388CC54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5011F82F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C713D28F;
	Tue, 26 Mar 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA6SgSHV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02713CC60;
	Tue, 26 Mar 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478856; cv=none; b=ePTvPUIXctcFqHhNwbtLYptJE57QzW8CRvJUfyPvA1htz2Ch5/03qYYQVM9RansNaPR9oU8cIpMnwH5oWRYEQu53SzRDeo5iGO8rKHGbMB/J5jJM8/IOu2U0/gseF9F/Mk2I4omB8JyY/wl2n6LZgDNm85fev8R17QXBzvFS1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478856; c=relaxed/simple;
	bh=8FHSNGxQm7QBTQTAwc2r5ZwdqOJ+94idlj4A8yLD6bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=herKU3nKv7Hpn8GB8a6cmuhY+RHsSrGUua2FeK7CsG46XLRD2DGjDvTKaqZnmINIu9q7Mr9gdFAEwbX2SrjACjoc8HwiexPfoqWWh4wIXcO6ADJRZNU2X28hslKm+OtW/i/L8GFbTyQ0aPt1zqIgjzUSd33Rkhh7Pwf9QdFrf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA6SgSHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891AFC433C7;
	Tue, 26 Mar 2024 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711478855;
	bh=8FHSNGxQm7QBTQTAwc2r5ZwdqOJ+94idlj4A8yLD6bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA6SgSHVS7EZzjbf3Ox2Dx9xuEj43jIL1s/GhxNT8VyRalMPP+IZ0U5SVf7hXbRiZ
	 odonEeY/joyiungjBc4WQnT8w2r7PuxR0ZeK6EbPOxcmdcnRZHb3XWIveaoH8ugz0E
	 7p+h2NTehRuJvXuun7mmbzP6+QfOGwA0T9oNoKyOMRyebViTUQXXm2IE0CZ1ucovqW
	 HX+hP1bt3jV28HbtaD5BW6Kg+cbdWrUWsUSv563DvPoY1IOaveU+tS8YOxPYuqOvVT
	 +mcEX0utAoHVihwq0ZRQaGxq+3VfOv2BxxULN6DIFA2vU68LS1l0Sy7btcxRimHYaE
	 mVboKkibluQaw==
Date: Tue, 26 Mar 2024 13:47:33 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: rtc: nxp,lpc1788-rtc: convert to
 dtschema
Message-ID: <171147885251.3182791.7036006082588130342.robh@kernel.org>
References: <20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com>
 <20240325-rtc-yaml-v2-4-ff9f68f43dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325-rtc-yaml-v2-4-ff9f68f43dbc@gmail.com>


On Mon, 25 Mar 2024 22:10:11 +0100, Javier Carrasco wrote:
> Convert existing binding to dtschema to support validation.
> 
> This is a direct conversion with no additions.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
>  .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


