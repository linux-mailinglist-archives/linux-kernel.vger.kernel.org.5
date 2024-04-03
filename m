Return-Path: <linux-kernel+bounces-130276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45D897641
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A1B1F2B1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63A8152188;
	Wed,  3 Apr 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhnEHUTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1A153BCF;
	Wed,  3 Apr 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164620; cv=none; b=FHVQt1c3PzUhx5g12JHIchCOkt+bj7SIK3InDoM0uxosFGiwXoKdDGwbU8blA1TSJgJffujb4iPS4klqq7txt/5o3DeaGb1X8bDeM4HXkDdxGb/cQmcuxXM8se3gCR1E0dZH3Drmw7HoLyxNGtSGwhC5SBaa1JP4qoBeMMTFN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164620; c=relaxed/simple;
	bh=5IR++65FlHu01isFQjZhfdhp3KWxn+RRSi/SkhjyoCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1CC6SIGIL4vm1TnzRoRtWOa7KGVGdHyygkOyFf2J596aUFBDlTCJwiTw0LdsTo53QUjBP8TDH3gvVXL0qFMiqaY4CnlP6cQd4kt8uAWSl7izUoxMitFx1PqBS5OzIVcBRosKzeAUmll0VOPNMVTMpPZ0mmbraChgGZHQTvwgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhnEHUTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38BC433F1;
	Wed,  3 Apr 2024 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164619;
	bh=5IR++65FlHu01isFQjZhfdhp3KWxn+RRSi/SkhjyoCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhnEHUToenowUMHc5izmmF0gkGcEyLNaISwSPjnOMg520ayyheT4/geJrmwRWvdra
	 zegsuX2X0ZhTGeHFiq6TuS/1zF/mRfDq+V1hUrc/ZLlo88qMxp9gXQiCcJLDSOgjQs
	 iSlBBCNcFpE7FCYfOQoGS20D1EnLh8E3/FfpvcShzp7CYmjWdPcvtfNzQNsHLJFDKT
	 9WURIeaOKU21946bpaGNKEbpDHyqOrgYErOx/Khm7Wxqzjp6cREtEGHVcyYVrNmBIf
	 pNFkwSRVcJ1nUHqoma3PIJ0WUcFDIO61zM8eO2hw2RahgRIFFuouwcYzRI9fiIAF/l
	 306sp4TlGhnWA==
Date: Wed, 3 Apr 2024 12:16:57 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Reimelt <alexander.reimelt@posteo.de>
Cc: konrad.dybcio@linaro.org, devicetree@vger.kernel.org, pvorel@suse.cz,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
	robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add LG G4 (h815)
Message-ID: <171216461463.4018435.3466905061314737419.robh@kernel.org>
References: <20240403104415.30636-1-alexander.reimelt@posteo.de>
 <20240403104415.30636-2-alexander.reimelt@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403104415.30636-2-alexander.reimelt@posteo.de>


On Wed, 03 Apr 2024 10:43:29 +0000, Alexander Reimelt wrote:
> International variant of the LG G4 from 2015.
> 
> Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


