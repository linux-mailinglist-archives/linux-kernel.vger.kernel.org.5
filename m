Return-Path: <linux-kernel+bounces-130987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D190989819C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0927B1C22631
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B53548FA;
	Thu,  4 Apr 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eREUNBs9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A12F32;
	Thu,  4 Apr 2024 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213287; cv=none; b=vCFf8OjhwyiNe4LVJdn2BF0bGZiE091lKef4xPZOUdEGS4MBpFbqe/QkfHgEtlNouqxHon3vjd91M+K/D4Xn4BIe0mfCUxugj2Uz3/xFGY1kQY4mB0D1vulFi15+LNKgzsXJHO3pIFYc0d8SDC3e4ROfIlpDProsBU0f9r+ZSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213287; c=relaxed/simple;
	bh=xOAqqA97rFiRnhyENeB1oh2EAjPFrezmlS/8ZhaH9qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0XHBwq9y1OOYb6onhsSb/7UCNsXFFay6uFLgZuDVVagZCNcHMEgnqLJtX7c3Z5bPhRiEgMsvjnYJRMEAL+YRDl8EMFdwwoJG0T/PEevW/jUTswYeQLXD7ZAwMmagS+RjEop4TmQyEJydKcPd0yZH2G7YR+jagFdM6ruyWM8NKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eREUNBs9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712213286; x=1743749286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOAqqA97rFiRnhyENeB1oh2EAjPFrezmlS/8ZhaH9qc=;
  b=eREUNBs9zXos/lmStkTFhFEhR2gk6KubhEce+E20UQpjLBlzgMzdLfZ/
   U9KMAlOk8DORDgZsH4IDDwV6T4bB0EQSvm0+7roN7hUC4z0N4yfJ0K77M
   NW+ZO1MefzFRRStmk81peCGTlgG4mXcmhUYcU3S6XFotrRvSIlKzsGoiw
   p04cPldg5jRycr3CwWk5Jz6QP2d4XFToUb0TJ7+jJ5dadV8Q72lxQ8Pi0
   v7hL3RAcT7UJt47/BKrm+AntAxWRfAvyKl6PEiMYmzpCixUNsckbJ++1t
   hpZiLRJXML9bVMr5qfJiAVeEnDalBrbUDfEXIImNtGfv1irGEGfLx9s6e
   A==;
X-CSE-ConnectionGUID: OH3nJK0HQr29KGB19cvAdA==
X-CSE-MsgGUID: 1qnQN/6hQHWAVdzD6Lgx8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11309344"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="11309344"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:48:05 -0700
X-CSE-ConnectionGUID: qEMawpElS4SNkIN6lS+AMg==
X-CSE-MsgGUID: iuFyfbxPTwmWr+oLESktDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18663740"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:48:01 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 17CB911F855;
	Thu,  4 Apr 2024 09:47:58 +0300 (EEST)
Date: Thu, 4 Apr 2024 06:47:58 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 22/25] dt-bindings: media: imx258: Add binding for
 powerdown-gpio
Message-ID: <Zg5NHqX2KmvOXf01@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-23-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-23-git@luigi311.com>

Hi Luigi,

On Wed, Apr 03, 2024 at 09:03:51AM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> Add powerdown-gpio binding as it is required for some boards
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> index c978abc0cdb3..33338139e6e8 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
> @@ -36,6 +36,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  powerdown-gpios:
> +    description:
> +      Reference to the GPIO connected to the PWDN pin, if any.

The sensor datasheet does not mention this one so I presume this is
unrelated to the sensor. Could it be for GPIO regulator control instead?

> +
>    reset-gpios:
>      description: |-
>        Reference to the GPIO connected to the XCLR pin, if any.

-- 
Regards,

Sakari Ailus

