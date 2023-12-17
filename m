Return-Path: <linux-kernel+bounces-2612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43010815F74
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0007E282BF5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C774438D;
	Sun, 17 Dec 2023 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P78yriM8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C42374CA;
	Sun, 17 Dec 2023 13:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E22DC433C7;
	Sun, 17 Dec 2023 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702819892;
	bh=ALp9/9f0txG4FMxlU/u1nEfS+4f4LKu9JESa7bHHH7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P78yriM8EXtFLn7GdBVidKVrrnG4zQat53WdB7LY40S1mCJhumQfQyuBNcbBPNy6y
	 topLRmfYbnUsZiNcHwFMRBOKCFOyKxcmeYQEaUioqbDsAGDE/UXP+lDoopJ45oqJCk
	 JxVznpAs5if3+bolAR0Iek+xvsf1sQSKtW0WSc5sPkUDd+YG+ZrFKocSwFoEeiYpKD
	 fiYomzNwmkCL2EMsgaQ8eYSQ0ra8x6nel+CknYp0CMknE1TLnjDUzppeMl+K7LzJOn
	 wR/yg2qptA43HbKlQZCRr32jwvJqHV9A9oHo2hSsc1KQQnjyIWbWYl4q+QEoA5b87s
	 oa1VlhGfqSHGA==
Date: Sun, 17 Dec 2023 13:31:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linus.walleij@linaro.org, brgl@bgdev.pl,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231217133112.0054ef56@jic23-huawei>
In-Reply-To: <ZXsVgVzcK6Om4td_@smile.fi.intel.com>
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
	<20231212104451.22522-2-mitrutzceclan@gmail.com>
	<20231214123029.000002f1@Huawei.com>
	<375bf803-a5d5-4778-938a-b8218b116375@gmail.com>
	<ZXsVgVzcK6Om4td_@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 16:47:29 +0200
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Dec 14, 2023 at 02:57:35PM +0200, Ceclan Dumitru wrote:
> > On 12/14/23 14:30, Jonathan Cameron wrote:  
> > > On Tue, 12 Dec 2023 12:44:36 +0200
> > > Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:  
> 
> ...
> 
> > >> +		ret = fwnode_property_match_property_string(child,
> > >> +							    "adi,reference-select",
> > >> +							    ad7173_ref_sel_str,
> > >> +							    ARRAY_SIZE(ad7173_ref_sel_str));  
> 
> > >> +  
> 
> Redundant blank line.
> 
> > >> +		if (ret < 0)
> > >> +			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> > >> +		else
> > >> +			ref_sel = ret;  
> > > Simpler pattern for properties with a default is not to check the error code.
> > > 
> > > 		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> > > 
> > > 		fwnode_property_match_property_String(child, ...
> > > 
> > > so only if it succeeds is the value overridden.  
> > 
> > Where exactly would the value be overridden, the function does not have an
> > argument passed for the found index. The function is written to return either
> > the found index or a negative error.
> > 
> > The proposed pattern would just ignore the returned index and would always
> > leave ref_sel to default. Am I missing something?
> > 
> > I can see in the thread where it was introduced that you proposed:
> > "Looking at the usecases I wonder if it would be better to pass in
> > an unsigned int *ret which is only updated on a match?"
> > 
> > But on the iio togreg branch that was suggested I could the function on, it
> > does not have that parameter.  
> 
> Yeah, with the current API we can have one check (no 'else' branch):
> 
> 		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> 		ret = ...
> 		if (ret >= 0)
> 			ref_sel = ret;
> 
Yeah. I was clearly lacking in coffee or just being an idiot that day!

> But your approach is good to me.
> 
> ...
> 
> It's always possible to change prototype, and now of course is the best time
> as all the users are provided in the single tree. That said, patches are
> welcome if this is what we want. (My proposal was to return index in case of
> no error, but at the same time leave it in the returned code, so it will be
> aligned with other match functions of fwnode.
> 
> But this in either way will complicate the implementation. And I don't find
> critical to have if-else in each caller as some of them may do something
> different on the error case, when option is mandatory. In such cases we
> usually don't provide output if we know that an error condition occurs.

I'm fine with it being as it is.  Was just having a slow brain day.

J
> 


