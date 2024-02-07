Return-Path: <linux-kernel+bounces-56268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E402984C822
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2214C1C21489
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EA324A19;
	Wed,  7 Feb 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQv7rCyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A125241EC;
	Wed,  7 Feb 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299887; cv=none; b=AB2JlL8WAKwJJDnnZKOjVe4BIbEmBhqAnkC4cZt1dVXCHLSx17S9Vs5suVh7/PfvhQ3YQVYcFxerWpCypB28IBDZC776jkKdpaHvodpuytV+VZIgSg8CvhKhRRTTmJ+4iAUL1XijTnPzzhJK8H4m3HvcC5Qha2xUz+C3vB927n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299887; c=relaxed/simple;
	bh=wV4t+TSND3aQwWB//g0FpRipGWaFuN/cSUTO/bj6Lfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Figxoz632BDeRAO8mRYABKCa+I3bl+oygajNFxDxI/TWd9PJKz5L12IqlaYX6UnlfZyQbyFNz7nl4wtmq0ul/U5YZ8MjULKQClZjrj4bRewaIY851VwR0pF/yReGlrGkoJDoja4FAbHmed71PaY8n104LPnYlbNxjmpI5b7rXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQv7rCyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CAFC433F1;
	Wed,  7 Feb 2024 09:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707299886;
	bh=wV4t+TSND3aQwWB//g0FpRipGWaFuN/cSUTO/bj6Lfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQv7rCyY3Lpq/ls6oq1P/7fnZ2CWi96WgiX0PDRmDhFbw4ZkVlM5RV6YWh15aRasR
	 p/3HRNangZPfyyJ6aAU7ZAewYrH092dNzML+xjm8+YYPwwQvceNlrV9Jj1UyUw7vDz
	 W6LhnWpWLgPxNKx3wlNXtGOwbiFWI9la7kImNPSg=
Date: Wed, 7 Feb 2024 09:58:03 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, broonie@kernel.org,
	andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com,
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
Message-ID: <2024020741-repaint-nastiness-9f8d@gregkh>
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-2-tudor.ambarus@linaro.org>
 <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
 <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>

On Wed, Feb 07, 2024 at 06:20:56AM +0000, Tudor Ambarus wrote:
> 
> 
> On 2/6/24 18:02, Sam Protsenko wrote:
> > On Tue, Feb 6, 2024 at 2:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> >>
> >> The driver uses u32 and relies on an implicit inclusion of
> >> <linux/types.h>.
> >>
> >> It is good practice to directly include all headers used, it avoids
> >> implicit dependencies and spurious breakage if someone rearranges
> >> headers and causes the implicit include to vanish.
> >>
> >> Include the missing header.
> >>
> >> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> > 
> > Not sure if Fixes tag is needed here.
> 
> We have already talked about this. If a patch that causes the implicit
> include to vanish is backported to stable, it will reveal the missing
> header here and will result in backporting this patch as well.

So worry about this then, not now.

> So, as a
> good practice let's allow this patch to be queued to stable, it will
> avoid possible compilation errors.

"possible" does not mean "needed".

Please only tag stuff that you know is needed, if the stable developers
break things, they can fix it up when it happens.

Adding .h includes is not a fixes: thing unless it actually fixes
something in Linus's tree, otherwise it's an abuse of the tag.  Please
don't do that.

thanks,

greg k-h

