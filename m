Return-Path: <linux-kernel+bounces-58522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B784E78C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F661F26379
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE286AD7;
	Thu,  8 Feb 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBupX1nZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234C84FBD;
	Thu,  8 Feb 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416225; cv=none; b=Iw9ssOwUqL1ra9/z0YAz1fWdzgyMPHh9M1gmrfutUzu+JQ1rGZRjUarhh9GM59NBnL+lJuCKSexPhuNY2auaK7uzYw+z1Q87V8KIR6fj2elCOFlgJ0I0/uWd2Qd7Xq+a+4Dtk3/4x3jkqtDfCP9Kn1ioOpTEVa5vHES0doMseQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416225; c=relaxed/simple;
	bh=CCGL2Pl/BCg3YNBXmBuwxZ7UZxA+L40il8xtdEW8TZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2YCDxdutTuHKcVv5HgKAud6dW3gxX/dfnUEwRru8c2YBLouoKcDs2/1omY5LBF9o3M1kNuvDLIiKEafSznbDczJuee8wJCfnJdwOKr8tY5981EwO+DKT26cl308LYmUbTV5BQGwBbnqwGCiOlyXOmcvcRoVS9uyco4Rvwfj5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBupX1nZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707416223; x=1738952223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCGL2Pl/BCg3YNBXmBuwxZ7UZxA+L40il8xtdEW8TZM=;
  b=nBupX1nZfCmIP/IMKj+uGNoGArEoSA4Tr5VTW0MxNq5+jE1+ssfypmgK
   szLSuyleFJURzBmC5sCiuSo/eiSQgBKyYYJUXd3lXwdQZhzbttKaL8vjk
   BYaHVMc8yeGfhkO6HVtToRTyWssRhtO6txEopkQGgbhIqbq81IXw81fMn
   olIEfinGfSkuYz6vAH55KIsljihRsG1wnufoRTRRslxCqvDhML5p+LjG9
   Bf72L+5Y8M08clxtpnKRYs2P7xze9vm7LOxaMrX/BqSJqPt75OL8B09F6
   NfWZopdP5vncV1z2HPkBrjNZg6Mk19on1bNn9pasq9qAjtxauQEqJHfQM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1440135"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1440135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910459977"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910459977"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:16:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8xE-00000002wkn-2bXG;
	Thu, 08 Feb 2024 20:16:56 +0200
Date: Thu, 8 Feb 2024 20:16:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <ZcUamOqKUuA-ahRY@smile.fi.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
 <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>
 <20240208-chute-bacteria-75425bd34dc9@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-chute-bacteria-75425bd34dc9@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 05:50:51PM +0000, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 06:58:57PM +0200, Andy Shevchenko wrote:
> > Add initial device tree documentation for Maxim MAX6958/6959.
> 
> Why "initial"? Are there elements this display that you've not
> documented yet? 

s/documented/implemented/

There are features of the hardware that may need additional properties.

> > +title: MAX6958/6959 7-segment LED display controller with keyscan
> 
> > +properties:
> > +  compatible:
> > +    const: maxim,max6959
> 
> Where's the max6958's compatible? I don't see it in your driver either.

For now, see above, there is no need. Moreover, there is no need at all
as we have autodetection mechanism. I don't see why we should have two
compatible strings just for the sake of having them.

> It seems that the max6959 has some interrupt capabilities that are not
> available on the max6958, so a dedicated compatible seems suitable to
> me.

So, please clarify the DT's p.o.v. on the hardware that can be autodetected.
Do we need to still have different compatible strings? What for? I don't
see the need, sorry for my (silly) questions.

-- 
With Best Regards,
Andy Shevchenko



