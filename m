Return-Path: <linux-kernel+bounces-85429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A358C86B5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DE51F27561
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DE12DD9B;
	Wed, 28 Feb 2024 17:22:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347A6EF01;
	Wed, 28 Feb 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140957; cv=none; b=myVhRlZIsc6NkRltcfNg86aoIydomgWd5Vplg+4bKlpUGZ6r/Lj2yXqw2Y6c2hM+S+WHoOvh63hE7QmRtP6i0BshkHkDtsmzvQIP06LZvPp9FRU7axmH1RVeEKuz8A4et6pVrBmor6Jx/DwsofvskK5PBkLbhf11ugaXi9cafNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140957; c=relaxed/simple;
	bh=SFvOWcPRYo2Lp/S4Uk1XoDCn8ACB3qkyl4DrAo0XEaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SD1uOH7yxNcngFkdYagbhQGRiJcfoPXXsrcXIESUkmmYan1T72CCTccF+E4G2HBnopoEVXaeC6qEZmSfgrEPawismiX/E7W4rWBjRyiHEsKAe5q6ctxVQlSyFZ2QPb+ITjngI5FcVaf7l8yDO3McJjAQjHvkOe1errN6ViZSxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3719070"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3719070"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956076"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956076"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:22:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rfNdS-00000008HWT-3mFq;
	Wed, 28 Feb 2024 19:22:26 +0200
Date: Wed, 28 Feb 2024 19:22:26 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"javierm@redhat.com" <javierm@redhat.com>,
	"robin@protonic.nl" <robin@protonic.nl>,
	"lee@kernel.org" <lee@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Message-ID: <Zd9r0lcnSuKFEsZF@smile.fi.intel.com>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vdi2c=s_z9wwxWzVcL+4tx5ZnXymbiN4O1FS+D3kz5vqw@mail.gmail.com>
 <34b89a56-ab43-4d44-86f3-604e5be29db3@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34b89a56-ab43-4d44-86f3-604e5be29db3@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 01:53:08AM +0000, Chris Packham wrote:
> On 28/02/24 13:03, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 11:22 PM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:

..

> >> +  segment-gpios:
> >> +    description:
> >> +      An array of GPIOs one per segment.
> > This is a vague description. Please explain the order (e.g., LSB =
> > 'a', MSB = 'g'), use of DP (optional?), etc.
> >
> >> +    minItems: 7
> > maxItems?

> I plan on saying maxItems: 7 (more discussion below)

..

> >> +    led-7seg {
> > Probably it should be more human readable. DT people might suggest
> > something better.
> >
> >> +        compatible = "generic-gpio-7seg";
> >> +        segment-gpios = <&gpio 0 GPIO_ACTIVE_LOW
> >> +                         &gpio 1 GPIO_ACTIVE_LOW
> >> +                         &gpio 2 GPIO_ACTIVE_LOW
> >> +                         &gpio 3 GPIO_ACTIVE_LOW
> >> +                         &gpio 4 GPIO_ACTIVE_LOW
> >> +                         &gpio 5 GPIO_ACTIVE_LOW
> >> +                         &gpio 6 GPIO_ACTIVE_LOW>;
> > Dunno how to handle DP. Either we always expect it to be here (as
> > placeholder) or with additional property.
> 
> My current plan was to ignore it. As you see it my later patch I'm 
> (ab)using DP as a discrete gpio-led with a different function.

FWIW, I have _no_ indicator _without_ DP. So, my statistics is towards enabling
DP as a part of 7-segment displays.

> We could either a separate dp-gpios property or set maxItems to 8. Right 
> now the driver won't do anything with either option.To actually do 
> something in the linedisp driver we'd need to have a new character map 
> that includes the extra LED.

Yeah, we can leave it open for now.

> >> +    };

-- 
With Best Regards,
Andy Shevchenko



