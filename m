Return-Path: <linux-kernel+bounces-86567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4986C723
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906C6286729
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364F79DD1;
	Thu, 29 Feb 2024 10:43:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65B65194;
	Thu, 29 Feb 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203379; cv=none; b=LXUJkXc7qNpf27hOvsMcRgaIYaSNSjTlBo/FM9RLw3HoOTmx1ck7nIDMHC75Dyq2iVt8CLj5d0LsHRdTzohfZlmHuNVUuv+LutH140bdc8sFboqbiraq3UswW2xf9NHI6Pa4DGRz+J+w+adZ3hYd67pSAqj9SvKW6gvocSqVUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203379; c=relaxed/simple;
	bh=JNouPdoVTEuTE81LBouWmA9FUxL2uN52fZs47yUEGEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGn2UY/gtaHCkpwbIp4oPcEupt4CVqipqsA4guwLa0I/rZdM3SqDNZLXxP7LSvAhEdZiUTFhTNckBmpRZlXSH6WmdZmxfGAdJchxhQ1HFNC+5sJomd4+VlPWZVsblJdBiOGX/61vEvLEa2TTQJ6AylP1CdIq5l2cWXImUeeJxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21121092"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21121092"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978666"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:42:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rfdsH-00000008dzn-2oMr;
	Thu, 29 Feb 2024 12:42:49 +0200
Date: Thu, 29 Feb 2024 12:42:49 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, ojeda@kernel.org,
	tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl,
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Message-ID: <ZeBfqTKVLp1YsJJG@smile.fi.intel.com>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <20240228140423.GA3307293-robh@kernel.org>
 <CAHp75VfW0Q7At+JnyWGXP3d=2dfWADRiQ-Z97B2JcZio3A_tyw@mail.gmail.com>
 <CAMuHMdWgytkANQ19=pSfG7Jpddo7Htgp2P=p7EAVmpWYuGPmCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWgytkANQ19=pSfG7Jpddo7Htgp2P=p7EAVmpWYuGPmCg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 10:23:15AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2024 at 3:58 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Feb 28, 2024 at 4:04 PM Rob Herring <robh@kernel.org> wrote:
> > > On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:

..

> > > > +  segment-gpios:
> > > > +    description:
> > > > +      An array of GPIOs one per segment.
> > > > +    minItems: 7
> > >
> > > How does one know which GPIO is which segment?
> >
> > I believe we need just to agree on this. Since anybody can shuffle
> > GPIOs in the DT, there is no need to support arbitrary orders. And
> > naturally 'a' is bit 0, 'g' is bit 6, 'dp' bit 7 if present.
> 
> Note that there are no bits involved at this level, only GPIO specifiers.

Right, I meant the sequence in the array of GPIOs in the DT.
I implied that it maps 1:1 to the real bits in HW (in some cases).

-- 
With Best Regards,
Andy Shevchenko



