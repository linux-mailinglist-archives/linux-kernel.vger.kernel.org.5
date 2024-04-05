Return-Path: <linux-kernel+bounces-133309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A289A211
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887FDB24F37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FD171073;
	Fri,  5 Apr 2024 16:07:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFE16FF4B;
	Fri,  5 Apr 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333228; cv=none; b=HAg/woXQGGOu35PtMgNzTJurDrIgEHo3nD2UJtd6AlBsReHoURdplEbRuV7UcEGMOu7CAIjFux/HzqD49uadzsauRvdeD/jqVp6q0F8qigf3AeUBHoEKu13wUz+vM8DaKhmJWykoGY88f+rVzGLwuCs/m0+p7JspLuCI8LnAWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333228; c=relaxed/simple;
	bh=9qVgXbGbN6ujtySIPhcvDBQPt7o17WIPa/+XgWBHJek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckQNjMeyYpuBMhmBVu3/z58sMZN2P0P8Wlkeiz9YJFUJjCrsRj11Gqv2hR5X0p2vPQ9GZyFaVxst6HDSbQLexnDnwwyZnTQIGips79joFuhfBiVM+yWFoGBURpvfmZdJgaFEXL1l4/wbftmSzaA0skFW9T3SQbMvADcvO1oNruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A1C6FEC;
	Fri,  5 Apr 2024 09:07:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A79673F64C;
	Fri,  5 Apr 2024 09:07:03 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:07:00 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAhpMNv8Agl4vCZ@bogus>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
 <ZhAe9oFz9wLQi4de@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAe9oFz9wLQi4de@smile.fi.intel.com>

On Fri, Apr 05, 2024 at 06:55:34PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 04:47:19PM +0100, Sudeep Holla wrote:
> >
> > Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
> > practice only.
>
> 	git grep -lw ENOTSUPP
>
> utterly disagrees with you.
>

/me more confused. Though I haven't dig deeper to chech how many of these
EOPNOTSUPP uses are intended for userspace.

$git grep -lw ENOTSUPP | wc -l
713
git grep -lw EOPNOTSUPP | wc -l
2946

> > What if we change the source/root error cause(SCMI) in this
> > case and keep GPIO/pinmux happy today but tomorrow when this needs to be
> > used in some other subsystem which uses EOPNOTSUPP by default/consistently.
>
> This is different case. For that we may shadow error codes with explicit
> comments.
>

Sure as along as that is acceptable.

> > Now how do we address that then, hence I mentioned I am not 100% in agreement
> > now while I was before knowing that this is GPIO/pinmux strategy.
> >
> > I don't know how to proceed now 🙁.
>
> KISS principle? There are only 10+ drivers to fix (I showed a rough list)
> to use ENOTSUPP instead of 100s+ otherwise.
>

Again I assume you are referring to just GPIO/pinmux subsystem right.
As the number of occurrence of EOPNOTSUPP in the kernel overall is quite
large.

I was thinking of changing the SCMI error map from EOPNOTSUPP to ENOTSUPP,
but for now I think it is better to just handle the mapping in the pinmux
part of SCMI that pinmux subsystem interacts with. In future if more
subsystem expect ENOTSUPP, then we can change it. I hope this aligns with
KISS principle as we are just fixing for the case that is know to cause
issue rather than changing all probably regressing and then having to
fix them all.

Thanks for the time and explanation.

--
Regards,
Sudeep

