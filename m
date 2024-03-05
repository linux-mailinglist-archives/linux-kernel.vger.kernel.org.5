Return-Path: <linux-kernel+bounces-92652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F349D8723AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8992A1F25392
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A1128831;
	Tue,  5 Mar 2024 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5ADZWo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E35128380;
	Tue,  5 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654733; cv=none; b=bg1sepjFoima2RxWfiDHV/qBzkn2gUbjKQ9ra362O6BYzdaFHsrEScWXrClWKEbx/lnH9TxLbNv6Rtswry2qHK73++m/s3gphRZpj+r3kLSVxXeuTu7UkJOleiP6xzZzSNS8jkEyuvdg/SSUqAZZTVFTOqCdVz28vKGcjTDJn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654733; c=relaxed/simple;
	bh=IQPsWViO6Wz0aOKZ/rMD99dL2lwwQMH2r+ucjDQ6N2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/T+dVMqoJL6d/hSUH1Ne5l7TDo/VQVjhnLgyDNeKmMBGzIufqO+yfrPOaMxkS4LZmWKeICM9ZLBgu4NgNa1lR07nOQ8cZYWS+0aS15AX17jRw5MkERHf2pqEvZzFqnhBUL7OAo8joVMCohaHFaZhAzUoVJIXii+qkLD19fG62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5ADZWo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7C8C433F1;
	Tue,  5 Mar 2024 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709654732;
	bh=IQPsWViO6Wz0aOKZ/rMD99dL2lwwQMH2r+ucjDQ6N2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5ADZWo0SeyXMIi5JqoJ9ekgNPswVFS4sil7pMMSXb7PhGXDyYp+nGfZ+lo2iPP0F
	 h6nG440N8JU4Zyg7GN21isEEn2W+ETf9njHpZblpvqcMMjn04cL9YANRtwEEN5Ao2i
	 GFKEgFEWteMNnqHHuEne55GM4a3koN/kvjqX8cuCsSumbkiXMTiyhfUpWXEF+qoXZI
	 A0GHLAn2KZVdZgcv2HqV9OPzUWe8aZc+2TRlWK78jBSfHr5gKDHUOS7y0SCQxP9ZVA
	 ebAUbBHy99xeR6mNTx2gBi8Pj3iP5GaH2DUlFXtt1S/Is+ScGNfvdIDNoAPR9strpx
	 cEszG+VK8314A==
Date: Tue, 5 Mar 2024 16:03:55 +0000
From: Simon Horman <horms@kernel.org>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ansuelsmth@gmail.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3] net: phy: qca807x: fix compilation when
 CONFIG_GPIOLIB is not set
Message-ID: <20240305160355.GO2357@kernel.org>
References: <20240305142113.795005-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305142113.795005-1-robimarko@gmail.com>

On Tue, Mar 05, 2024 at 03:20:33PM +0100, Robert Marko wrote:
> Kernel bot has discovered that if CONFIG_GPIOLIB is not set compilation
> will fail.
> 
> Upon investigation the issue is that qca807x_gpio() is guarded by a
> preprocessor check but then it is called under
> if (IS_ENABLED(CONFIG_GPIOLIB)) in the probe call so the compiler will
> error out since qca807x_gpio() has not been declared if CONFIG_GPIOLIB has
> not been set.
> 
> Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403031332.IGAbZzwq-lkp@intel.com/
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v3:
> * Target net-next tree
> Changes in v2:
> * Reduce the code indent level

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


