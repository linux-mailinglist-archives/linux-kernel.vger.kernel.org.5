Return-Path: <linux-kernel+bounces-38542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C873583C143
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4251C229EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FE3172D;
	Thu, 25 Jan 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNChhATk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940B376E0;
	Thu, 25 Jan 2024 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183174; cv=none; b=N1JQ/hWLqBhAzO+3VeANBBmpGFnEWr2K+au+bsoFkzi8PtNBIf/mb3bP2pK+kVwjt8mtnRx1kKfu/vpwBn8wpNhvU0nDFoFpcWA8VHZ6PjrbdErgKPbh0CRNYlNuePM8wnMWIEhgpj5/N7lviLGEu0NFDUPOXOrP+aZJFhvrJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183174; c=relaxed/simple;
	bh=zT7UuuLPgK03PoMVnPSeikhPiQ2VY8XDljDQ6fuzGjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWlHAslqFkttjUf6nxlWy73gO5uq241s8pyBbRGD67TjwCuKyKQNBG17yCdL+g3gVxyxAAQN7GuYEOR1smCe04M4NIq6HooAdJT9BYFdc9asXXy1g2NN4Tov5RcWzZfUmkAV09f7E3bGg/H48EziLDUfBtdIZCbQ3g/VPiqnqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNChhATk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844FFC433F1;
	Thu, 25 Jan 2024 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183174;
	bh=zT7UuuLPgK03PoMVnPSeikhPiQ2VY8XDljDQ6fuzGjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNChhATkM652SseRl9tRO4D0GLx0NUKgWDj0I3E84pbIsDKfCFfZVG2cgOEKzRwU2
	 biQmMGlE8x3jViaqrgaWBn16vjZwdcI7X8NmJ9/KDsi3wEKIEL1ewQOfluszMPzXsi
	 Db5YjwJMS+e0h633Zr1NtrQ4VeCKzdmEaAuDetOCgqM6KUsvucoX6sqbxv1xZr0IbJ
	 IzCsetVR1lUv5WG73SgFuQZWLKuTM7uqDgLAmDTUo0ih8l1BihyOxexlS+2JyQSxH8
	 C1sG0zUtc+QnA7R5BCuhPSDG0eUsl5lK2/Fx2RCxXQlGdmFBQ1XOmI7Hgf0R6VYKRs
	 VJMwAOFMrxvcw==
Date: Thu, 25 Jan 2024 11:46:06 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>,
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
Message-ID: <20240125114606.GA1327902@google.com>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org>
 <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org>
 <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
 <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
 <04411aaf-6f2c-4f43-83b4-aa0741ccd25f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04411aaf-6f2c-4f43-83b4-aa0741ccd25f@linaro.org>

On Thu, 25 Jan 2024, Krzysztof Kozlowski wrote:

> On 24/01/2024 22:27, Saravana Kannan wrote:
> > On Tue, Jan 23, 2024 at 10:27 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 24/01/2024 04:37, Saravana Kannan wrote:
> >>> On Tue, Jan 23, 2024 at 10:12 AM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 23/01/2024 18:30, Peter Griffin wrote:
> >>>>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
> >>>>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> >>>>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> >>>>>>>       if (ret)
> >>>>>>>               return ret;
> >>>>>>>
> >>>>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> >>>>>>> -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> >>>>>>> -                                             "samsung,syscon-phandle");
> >>>>>>> -             if (IS_ERR(wdt->pmureg))
> >>>>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> >>>>>>> -                                          "syscon regmap lookup failed.\n");
> >>>>>>
> >>>>>>
> >>>>>> Continuing topic from the binding: I don't see how you handle probe
> >>>>>> deferral, suspend ordering.
> >>>>>
> >>>>> The current implementation is simply relying on exynos-pmu being
> >>>>> postcore_initcall level.
> >>>>>
> >>>>> I was just looking around for any existing Linux APIs that could be a
> >>>>> more robust solution. It looks like
> >>>>>
> >>>>> of_parse_phandle()
> >>>>> and
> >>>>> of_find_device_by_node();
> >>>>>
> >>>>> Are often used to solve this type of probe deferral issue between
> >>>>> devices. Is that what you would recommend using? Or is there something
> >>>>> even better?
> >>>>
> >>>> I think you should keep the phandle and then set device link based on
> >>>> of_find_device_by_node(). This would actually improve the code, because
> >>>> syscon_regmap_lookup_by_phandle() does not create device links.
> >>>
> >>> I kinda agree with this. Just because we no longer use a syscon API to
> >>> find the PMU register address doesn't mean the WDT doesn't depend on
> >>> the PMU.
> >>>
> >>> However, I think we should move to a generic "syscon" property. Then I
> >>> can add support for "syscon" property to fw_devlink and then things
> >>> will just work in terms of probe ordering, suspend/resume and also
> >>> showing the dependency in DT even if you don't use the syscon APIs.
> >>>
> >>> Side note 1:
> >>>
> >>> I think we really should officially document a generic syscon DT
> >>> property similar to how we have a generic "clocks" or "dmas" property.
> >>> Then we can have a syscon_get_regmap() that's like so:
> >>>
> >>> struct regmap *syscon_get_regmap(struct device *dev)
> >>> {
> >>>         return syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> >>> }
> >>>
> >>> Instead of every device defining its own bespoke DT property to do the
> >>> exact same thing. I did a quick "back of the envelope" grep on this
> >>> and I get about 143 unique properties just to get the syscon regmap.
> >>> $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
> >>> 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
> >>> 143
> >>
> >> Sorry, generic "syscon" property won't fly with DT maintainers, because
> >> there is no such thing as syscon in any of hardware.
> > 
> > Then why do we allow a "syscon" compatible string and nodes? If the
> 
> To bind Linux drivers.
> 
> > "syscon" property isn't clear enough, we can make it something like
> > gpios and have it be <whatever>-syscon or have syscon-names property
> > if you want to give it a name.
> 
> This could work.

I'm not opposed to this idea.  The issue you'll have is keeping the
kernel backwards compatible with older DTBs, thus this solution may only
be possible for newly created bindings.  More than happy to be proven
wrong here though.

> >>> How are we making sure that it's the exynos-pmu driver that ends up
> >>> probing the PMU and not the generic syscon driver? Both of these are
> >>> platform drivers. And the exynos PMU device lists both the exynos
> >>> compatible string and the syscon property. Is it purely a link order
> >>> coincidence?
> >>
> >> initcall ordering
> > 
> > Both these drivers usr postcore_initcall(). So it's purely because
> > soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as
> 
> Oh... great :/.

Agree.

Even using initcalls for ordering is fragile.  Relying on the
lexicographical order of a directory / filename structure is akin to
rolling a dice.  It would be far nicer if you are able to find a more
robust method of ensuring load order e.g. dynamically poking at
hardware and / or utilising -EPROBE_DEFER.

-- 
Lee Jones [李琼斯]

