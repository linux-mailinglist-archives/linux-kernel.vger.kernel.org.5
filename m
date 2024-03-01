Return-Path: <linux-kernel+bounces-88915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF0386E853
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9B81C2462C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3E39FED;
	Fri,  1 Mar 2024 18:21:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554536135;
	Fri,  1 Mar 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317283; cv=none; b=l/ndrz4bAydQwg6wG3S4uioV+fh5BosJnwUAiFBw4+/YW9Yc6xriS9yjZmoQRpYhtTin2kXObw2cPElqXUN36vKiTvKq4+P+INXhRIt6gs24Zpa0HtnpyfrdhCVaj6CMSRbKNT7qGFsiQQa9Rc1hd9v5/okWW7N6ra3Aw3EZai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317283; c=relaxed/simple;
	bh=IHdIjCmUgXA8Llv9SkHjWKb+O4OeZfzQcVuzHUCV/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioIqInFIJdfVtcQ4uRFvsxjE1KVthI1CzY75bZukzmj6q0TMrRXsoh7FjlEdH0vNQ52C8BF15wadhRvjYJ09/XPb2k8Xoo8cnrBUTUtUAlTEkeqJa3yO5IMbXmKSO4sNLXdHcMuYB13kZdNWv7jd85UJZ5PM84Jmk5HlGAy5eqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14572107"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14572107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914022145"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914022145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:21:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rg7VS-000000091lC-02JF;
	Fri, 01 Mar 2024 20:21:14 +0200
Date: Fri, 1 Mar 2024 20:21:13 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pavel@ucw.cz, lee@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7-segment LED
Message-ID: <ZeIcmVuhX9MzPV7R@smile.fi.intel.com>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301014203.2033844-3-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 02:42:01PM +1300, Chris Packham wrote:
> Add bindings for a generic 7-segment LED display using GPIOs.

..

> +  segment-gpios:
> +    description:
> +      An array of GPIOs one per segment. The first GPIO corresponds to the A
> +      segment the last GPIO corresponds to the G segment.
> +    minItems: 7
> +    maxItems: 7

As we discussed, put the ASCII art here to be sure everybody on the same page
what 'a' - 'g' are and I would put 'dp' as well for the better understanding of
the possible configurations (it doesn't mean you have to support it).

..

Either way this will require an Ack by DT maintainers.

-- 
With Best Regards,
Andy Shevchenko



