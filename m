Return-Path: <linux-kernel+bounces-137064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA389DBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839431C22D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300C12FB23;
	Tue,  9 Apr 2024 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLgNLTwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59F75809;
	Tue,  9 Apr 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671966; cv=none; b=k8kBrYNkVUohi4ZzxIWrSDP25KwEL5/gvCLsOx49LV3oyKXPU1NG40oLe33oSzk4Zc5YnAtn6+JGedeZlVHw/QNGV/F8+dUdYaJxBXy5iplqI70dkszvQ7wJW8sQwrSMcJ3nZIVHUHRNnJ4sjrGUAYy1M8JwQTGQ9vvgRbMMHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671966; c=relaxed/simple;
	bh=xBaTzncPkClWKcZ+0gQSXyy6lR2MO8ejKBgQTVMKrdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgoExPM3NH99V/Mh9qIbWoG2KqjAuvCt/xgbyevctMpnSZ1FhwdWgk2GqsRJH21Khsgy7YSnbRtJRI6L6x8aBUqkrDyurO4LiIYi0pfRoBoSPjxTnvZ1C+REaerGwjMLXeauwBUTpYLYu8qA/dJRI2O9n8KG77GYGCay0Ipuo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLgNLTwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE1C433F1;
	Tue,  9 Apr 2024 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671965;
	bh=xBaTzncPkClWKcZ+0gQSXyy6lR2MO8ejKBgQTVMKrdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLgNLTwOIsjL7F9gQSD2PD33d5tjOWWzin3psRbAe8fyNJ1v0N6zrkEtWx1TUTB2T
	 TLlsFwJY2mAAD1z0AQ/2sIudZjbeNsSV6wLVUUyps3YuIsU0T2SH3Mtd5k9pfgGsd2
	 hvJHqsjqL/RXnrytvDItq6INGePuqTDYVcGeL9bqFH9rphZCDxQ0h5Ic2n4GENhitH
	 LMZmN0dV1QoBNHv65HgiONuhDqg+x4+UmpmlPZDmHgZ3SK5PKkMd4xxd5XEhD3ZHdB
	 X9PqZhMVd3kGgR5rcSB6N89JJRegDdV3gefwEV4aJ4kA7Faxyy9zNarYpmydrQmewe
	 hxs8v0Xp5Bf0g==
Date: Tue, 9 Apr 2024 09:12:43 -0500
From: Rob Herring <robh@kernel.org>
To: git@luigi311.com
Cc: mchehab@kernel.org, devicetree@vger.kernel.org,
	linux-media@vger.kernel.org, shawnguo@kernel.org,
	jacopo.mondi@ideasonboard.com, phone-devel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	sakari.ailus@linux.intel.com, conor+dt@kernel.org,
	imx@lists.linux.dev, pavel@ucw.cz, dave.stevenson@raspberrypi.com,
	s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 18/25] dt-bindings: media: imx258: Add alternate
 compatible strings
Message-ID: <171267196134.1104703.16459951254766815081.robh@kernel.org>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-19-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-19-git@luigi311.com>


On Wed, 03 Apr 2024 09:03:47 -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> There are a number of variants of the imx258 modules that can not
> be differentiated at runtime, so add compatible strings for the
> PDAF variant.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


