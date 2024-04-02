Return-Path: <linux-kernel+bounces-127699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDAB894FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A2AB24679
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420B5A4CB;
	Tue,  2 Apr 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/+63Goc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50859B56;
	Tue,  2 Apr 2024 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052696; cv=none; b=Jw4uD73lA+bw16drP+pp2/qg7J3AIXGjX3sNZC4R0OeJfw+oK0XtPIxFvowNH0hbOSIiawPF3IcOSjnJhybosxme7+l67+LDbGRC7oclNEj2KksyX5IKpgO7zQQ/caRJ9Dyaq+33YZBJm+4NNPf4w1wn20ZReFiMOa43uS5XgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052696; c=relaxed/simple;
	bh=Os6fVasxSxEfgD/AHz8TpcoCEaHcsoZy8kQLOOFg1WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSa+C98n/PtHaLbqYhY85pr7JJNP5Z09iOdjbxWUhT4sZ4+Wwr2w+hkMHypdR06lnZ/LmG7WbwcirxGLsEXroQi78bUx4x2cMoiGeFTRxoEYhid76KV3J3XRdE0LQYRDHAunnN2LFJd3ccqEZ+YNYONgKMMgqhwBf+ysdTiulbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/+63Goc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712052696; x=1743588696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Os6fVasxSxEfgD/AHz8TpcoCEaHcsoZy8kQLOOFg1WY=;
  b=c/+63GocKgkaI/NXOKB3G9PRLC3FARZxpcV35wYCGQrsIJwa04fQGwAJ
   2uZKILm31DjZq97K/iafJZQ5dLiWHJZHIz3I0F8u9qLDdlXx3Q1384QRp
   /UwTNyMxAPrkQQUtGxeFOlrQg5jNsaww2iVX+xMJsbhASecSciA35eOPs
   DuDGVsLzP9qI6qy/koBOSsvoFVJ8UWCeoPU7PozZrOjt0U052WWLSzrWU
   qLF0GCtjw8jvB2TxWbQo4nazScqmZMnnoFW68nU7nBOrU9G1oWQWmEc+/
   0IaFjlTo+DTadH7S8tA3iW3lEMLw4iRvtay47EvlDxrRRodAVwJZNkF/+
   A==;
X-CSE-ConnectionGUID: PuEvKoqDQbaByrsBJhRPPg==
X-CSE-MsgGUID: aL//v1bgQRiYfLln+lif7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24669991"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24669991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="937083267"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="937083267"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2024 03:11:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Apr 2024 13:11:31 +0300
Date: Tue, 2 Apr 2024 13:11:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: nvidia: drop driver owner assignment
Message-ID: <ZgvZ07U+DFcPATII@kuha.fi.intel.com>
References: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>
 <20240327174609.519252-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174609.519252-2-krzysztof.kozlowski@linaro.org>

On Wed, Mar 27, 2024 at 06:46:09PM +0100, Krzysztof Kozlowski wrote:
> Core in typec_altmode_register_driver() already sets the .owner, so
> driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/nvidia.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/nvidia.c b/drivers/usb/typec/altmodes/nvidia.c
> index c36769736405..fe70b36f078f 100644
> --- a/drivers/usb/typec/altmodes/nvidia.c
> +++ b/drivers/usb/typec/altmodes/nvidia.c
> @@ -35,7 +35,6 @@ static struct typec_altmode_driver nvidia_altmode_driver = {
>  	.remove = nvidia_altmode_remove,
>  	.driver = {
>  		.name = "typec_nvidia",
> -		.owner = THIS_MODULE,
>  	},
>  };
>  module_typec_altmode_driver(nvidia_altmode_driver);
> -- 
> 2.34.1

-- 
heikki

