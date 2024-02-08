Return-Path: <linux-kernel+bounces-57688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537284DC59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B6F1F21444
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB196A8DF;
	Thu,  8 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvbZJuJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DB69E1E;
	Thu,  8 Feb 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383088; cv=none; b=bxEjOPL/cgmGQFSBk9b5oU6/lR8O3WA0P2yIYyc+SAHAY9Jw5jXNcBx2hEs7N3uqV2Qcva3Q6/BnXf0qhucGSoRCv3TeJ+Y3Inf8Gz+eVoiWf7CgNOa2VmLPBvWIWjzQWDPO7NOpOFvwE3OsHJJjhlpXCx7O1gjGNGSY/gm+yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383088; c=relaxed/simple;
	bh=ktRd2dOovcX0Ic99oahaHyDmVN2NRLxsU6HjfmAYGyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9Ys5vfebW1crzYm8iC/67K6Dk2rQqDgHrC6GaU/IWMxlS9NXfcZ/1sfP6PtLqXAVRNFl/pVzMwg4sDBogYZcornXHttSPAhjUBV8FoMs9/7+FFprTBEjiVO4YSEaHVA/9PbQqVlAoP/6aHmP+GmitcSj+ZRzhOA65Oq52f6d/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvbZJuJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4BAC433F1;
	Thu,  8 Feb 2024 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707383088;
	bh=ktRd2dOovcX0Ic99oahaHyDmVN2NRLxsU6HjfmAYGyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvbZJuJM6AaMQ5MsC7wYvq7RS47K8wFLaruCx5E5m+AXu4mZDfurRajwMVTT3o21c
	 u+0iTN9DxVCGnSM34djTBYlA7AsITq3uFfMHHLxNIC0mxxlDm/fCvuIpp6qGup1YVw
	 njSuP2k3zwdObxcGZkQWrDTub2CBv5bWyD7NLbzXA6DGQVF5iojl+JLGUtFy1RbEa1
	 b+PpLGned70BoYiFzzb5gnk0JvCPgcg3s0XJdqQIhJ6GvhVZ8VoZft0sGpxtzne3dM
	 HQET+keCgWvbEQe63UTm+ckPLPAXYeEALf+pfLE9KrWwQjS1guzBDWnM4i2io4AncK
	 IpJlfcqg9F4/w==
Date: Thu, 8 Feb 2024 09:04:43 +0000
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, andy.shevchenko@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-ID: <20240208090443.GC689448@google.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>

Mark,

On Mon, 29 Jan 2024, Charles Keepax wrote:

> Including some missing headers.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Acked-by: Mark Brown <broonie@kernel.org>

You can just take this, no?

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No change since v3.
> 
> Thanks,
> Charles
> 
>  drivers/spi/spi-cs42l43.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
> index f13073e12593..16b2c6c2e006 100644
> --- a/drivers/spi/spi-cs42l43.c
> +++ b/drivers/spi/spi-cs42l43.c
> @@ -11,7 +11,9 @@
>  #include <linux/errno.h>
>  #include <linux/mfd/cs42l43.h>
>  #include <linux/mfd/cs42l43-regs.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> -- 
> 2.30.2
> 

-- 
Lee Jones [李琼斯]

