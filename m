Return-Path: <linux-kernel+bounces-160604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D468B3FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290FFB221A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDA182AE;
	Fri, 26 Apr 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhSQ6sJV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70146A4;
	Fri, 26 Apr 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158694; cv=none; b=nPo2y/dVvjIqF+OvXSeBftwrqDnsJVo7aUNIOmebyvJDp/Fg+Z7TxLsktAv3TF6qiq6TmucgQp0IvUrFsREVWop2aW5RnZuBgYyGI8Amm1MptHOO+XKC71DkSgL5XLBY8pMvXf/1LcEdioDmFSwmMjJnHMeFNakwK4KDqF6OWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158694; c=relaxed/simple;
	bh=XUdr7nZ1LWSQx5wvYOHZw265cdc3ykPmcH+6/9UHKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QryEn/wKYBpm5EtW7K74rcswkHww0asKF7J8xA1SC/GzbckSie7q0eNxdKzwBNqX7oBQvnqKHj92C6f5X8O3DQe9eHdT8iDBml0kzAy8YySJHLtUOW+pUj4aNWlb8PZbFAgQ8HJbvEmVHbUzad+LMpWefhI9lDdDZoYqImjl5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhSQ6sJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6489CC113CD;
	Fri, 26 Apr 2024 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158693;
	bh=XUdr7nZ1LWSQx5wvYOHZw265cdc3ykPmcH+6/9UHKPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhSQ6sJVIPWNk2Tlq8ZyUWJAXvcEksEoqwroEyfWhYQPAi5oSSW4O7Cyx7j61DCcv
	 rKoX3fOtSlHVSPIXWIB53HsNJx3ehmrD2LOpONQF68yeBRT9M4+nWS8oGiFExejdYP
	 KDqXbRpVJQOp1HQTeykhB1EREirY0q1pVlY0uy4VSb1nGnvr7oXr4HClH3K5oORxkS
	 3518oOHGy1cjg4rn8dH9pRowzQABkONLuFSAcmp8tOAwNUcUmUsxy44LwWimq7HT0A
	 IXdnqv1i37F/Zpkm1fXgCg6IoRh/UdKUDNDMvBbfDij/fLNYMeOzuqgCth3t0lpYjp
	 k93dzeLg7LoiQ==
Date: Fri, 26 Apr 2024 14:11:30 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, bvanassche@acm.org,
	James.Bottomley@hansenpartnership.com, willmcvicker@google.com,
	saravanak@google.com, tudor.ambarus@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, martin.petersen@oracle.com,
	krzk+dt@kernel.org, linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, avri.altman@wdc.com
Subject: Re: [PATCH v3 1/6] dt-bindings: ufs: exynos-ufs: Add gs101 compatible
Message-ID: <171415865280.2674676.16238135633423140947.robh@kernel.org>
References: <20240426122004.2249178-1-peter.griffin@linaro.org>
 <20240426122004.2249178-2-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426122004.2249178-2-peter.griffin@linaro.org>


On Fri, 26 Apr 2024 13:19:59 +0100, Peter Griffin wrote:
> Add dedicated google,gs101-ufs compatible for Google Tensor gs101
> SoC.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../bindings/ufs/samsung,exynos-ufs.yaml      | 38 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


