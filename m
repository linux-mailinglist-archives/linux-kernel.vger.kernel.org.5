Return-Path: <linux-kernel+bounces-39786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C27983D611
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715361C267D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9512C548;
	Fri, 26 Jan 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3GHN50V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CFD1C2A6;
	Fri, 26 Jan 2024 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706258598; cv=none; b=dSk9Fv7LhUeoc2RJHxxBzt+ZLSQ/SZSGW44M9vTiJu7GBz6qjcwZre+nStUDATttwo6KbnfatzP+ell4saA5/Dt+rfvn6QFzBXD44a9Q+XTjSSJi7nkZEV4hhzOSSJeQtMWyo8Xime9xstHmnQRzcrp0vQ0NV6f7w6jKhr/UnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706258598; c=relaxed/simple;
	bh=oF5B98tG35oUypgTR8kLKZMFEniob38hECdwFh7l1QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJv+h7TZWTqtEc8qeuJx/LH7O6nHRkjLx5sONVj+btuhUSHlKupaFwO+Rh4Lk6eOnQ3KDFitcca7jEJNnZMWdRav+1lnpsdmmfV4CI7n32jTARC2c1K7L/euTnyc9YuYnNcq5YuHNrgxnuR7Gj770TB4w8RqiSbDjztyVbPWraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3GHN50V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D4C43390;
	Fri, 26 Jan 2024 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706258597;
	bh=oF5B98tG35oUypgTR8kLKZMFEniob38hECdwFh7l1QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3GHN50VuE1DHNfCijXJC7+XCojgFCv2Nw+68NOngbB7oeLYFAyR/QpNPDD6Opuiu
	 lhdOSkh7lOsjYGr+aI3qY6V671pKlUvyIGsOuGGzyYUVJqxsqBPeUEM1Fn0q/6ZB74
	 7X9xC/3zvNK0i84Y+C1CnBLXYC5GbkCuPOHd4GYBTQvZEqICAAIw4X5Usf3A9CjHbZ
	 KIajHUBfH1QnMC1fYx7trdyBOcQDIC4d/NSP/WgI2yRE5A0APmazNjcdXny6AjnTJn
	 pVjdwC8U3nFwSpLEpfJ5qRo1bZ79o43izJldYZNv0wpeH3EORSUq45F1b2H2zPSddc
	 SyhrXixVM0K/Q==
Date: Fri, 26 Jan 2024 08:43:09 +0000
From: Lee Jones <lee@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
	chanho61.park@samsung.com, semen.protsenko@linaro.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
Message-ID: <20240126084309.GM74950@google.com>
References: <20240122225710.1952066-4-peter.griffin@linaro.org>
 <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org>
 <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
 <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
 <04411aaf-6f2c-4f43-83b4-aa0741ccd25f@linaro.org>
 <20240125114606.GA1327902@google.com>
 <CAGETcx8r_+_B0S3VJ6_66+dgAOusN_pt_=pmgoa-r8TUY7quPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8r_+_B0S3VJ6_66+dgAOusN_pt_=pmgoa-r8TUY7quPA@mail.gmail.com>

On Thu, 25 Jan 2024, Saravana Kannan wrote:

> On Thu, Jan 25, 2024 at 3:46 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 25 Jan 2024, Krzysztof Kozlowski wrote:
> >
> > > On 24/01/2024 22:27, Saravana Kannan wrote:
> > > > On Tue, Jan 23, 2024 at 10:27 PM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 24/01/2024 04:37, Saravana Kannan wrote:
> > > >>> On Tue, Jan 23, 2024 at 10:12 AM Krzysztof Kozlowski
> > > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > > >>>>
> > > >>>> On 23/01/2024 18:30, Peter Griffin wrote:
> > > >>>>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
> > > >>>>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> > > >>>>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> > > >>>>>>>       if (ret)
> > > >>>>>>>               return ret;
> > > >>>>>>>
> > > >>>>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> > > >>>>>>> -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > > >>>>>>> -                                             "samsung,syscon-phandle");
> > > >>>>>>> -             if (IS_ERR(wdt->pmureg))
> > > >>>>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> > > >>>>>>> -                                          "syscon regmap lookup failed.\n");
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> Continuing topic from the binding: I don't see how you handle probe
> > > >>>>>> deferral, suspend ordering.
> > > >>>>>
> > > >>>>> The current implementation is simply relying on exynos-pmu being
> > > >>>>> postcore_initcall level.
> > > >>>>>
> > > >>>>> I was just looking around for any existing Linux APIs that could be a
> > > >>>>> more robust solution. It looks like
> > > >>>>>
> > > >>>>> of_parse_phandle()
> > > >>>>> and
> > > >>>>> of_find_device_by_node();
> > > >>>>>
> > > >>>>> Are often used to solve this type of probe deferral issue between
> > > >>>>> devices. Is that what you would recommend using? Or is there something
> > > >>>>> even better?
> > > >>>>
> > > >>>> I think you should keep the phandle and then set device link based on
> > > >>>> of_find_device_by_node(). This would actually improve the code, because
> > > >>>> syscon_regmap_lookup_by_phandle() does not create device links.
> > > >>>
> > > >>> I kinda agree with this. Just because we no longer use a syscon API to
> > > >>> find the PMU register address doesn't mean the WDT doesn't depend on
> > > >>> the PMU.
> > > >>>
> > > >>> However, I think we should move to a generic "syscon" property. Then I
> > > >>> can add support for "syscon" property to fw_devlink and then things
> > > >>> will just work in terms of probe ordering, suspend/resume and also
> > > >>> showing the dependency in DT even if you don't use the syscon APIs.
> > > >>>
> > > >>> Side note 1:
> > > >>>
> > > >>> I think we really should officially document a generic syscon DT
> > > >>> property similar to how we have a generic "clocks" or "dmas" property.
> > > >>> Then we can have a syscon_get_regmap() that's like so:
> > > >>>
> > > >>> struct regmap *syscon_get_regmap(struct device *dev)
> > > >>> {
> > > >>>         return syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> > > >>> }
> > > >>>
> > > >>> Instead of every device defining its own bespoke DT property to do the
> > > >>> exact same thing. I did a quick "back of the envelope" grep on this
> > > >>> and I get about 143 unique properties just to get the syscon regmap.
> > > >>> $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
> > > >>> 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
> > > >>> 143
> > > >>
> > > >> Sorry, generic "syscon" property won't fly with DT maintainers, because
> > > >> there is no such thing as syscon in any of hardware.
> > > >
> > > > Then why do we allow a "syscon" compatible string and nodes? If the
> > >
> > > To bind Linux drivers.
> > >
> > > > "syscon" property isn't clear enough, we can make it something like
> > > > gpios and have it be <whatever>-syscon or have syscon-names property
> > > > if you want to give it a name.
> > >
> > > This could work.
> >
> > I'm not opposed to this idea.  The issue you'll have is keeping the
> > kernel backwards compatible with older DTBs, thus this solution may only
> > be possible for newly created bindings.  More than happy to be proven
> > wrong here though.
> 
> You are right about backwards compatibility. Technically, we might be
> able to fix up the DT at runtime (by keeping a list of those 143
> property names) to maintain backward compatibility, but I'm not
> suggesting that.
> 
> We can leave the existing ones as is, but we can at least use the new
> property going forward to make dependencies easier to track and handle

Automatic tracking and device linking sounds like a worthwhile endeavour.

> -Saravana

I nearly stopped reading here.

> > > >>> How are we making sure that it's the exynos-pmu driver that ends up
> > > >>> probing the PMU and not the generic syscon driver? Both of these are
> > > >>> platform drivers. And the exynos PMU device lists both the exynos
> > > >>> compatible string and the syscon property. Is it purely a link order
> > > >>> coincidence?
> > > >>
> > > >> initcall ordering
> > > >
> > > > Both these drivers usr postcore_initcall(). So it's purely because
> > > > soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as
> > >
> > > Oh... great :/.
> >
> > Agree.
> >
> > Even using initcalls for ordering is fragile.  Relying on the
> > lexicographical order of a directory / filename structure is akin to
> > rolling a dice.  It would be far nicer if you are able to find a more
> > robust method of ensuring load order e.g. dynamically poking at
> > hardware and / or utilising -EPROBE_DEFER.
> 
> Let me dig in to see if all the existing examples of listing syscon in
> compatible AND have a different driver that needs to probe it always
> list syscon as a secondary compatible string. In that case, we might
> be able to make the syscon driver only match with the device it it's
> the first entry in the compatible string.

If using clever or non-obvious means by which to ensure correct
ordering, I would suggest putting in place very obvious
documentation/commentary verbosely describing the aim and method.

-- 
Lee Jones [李琼斯]

