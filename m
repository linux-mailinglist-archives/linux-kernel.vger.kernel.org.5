Return-Path: <linux-kernel+bounces-103476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61B87BFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052932840E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1973503;
	Thu, 14 Mar 2024 15:24:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9327318A;
	Thu, 14 Mar 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429859; cv=none; b=b+1A9dGutak+tlz6a3WUAlxuG44CthLSuox/u1ItZQpsX9T9CUs4kAfi5typisWN1xgidfUUuxXCL9MFADIoMSoxbZ/BvgUyAblfaNGmRJ8sGoL0UgrBqIJAxLdKB3auua960l7Q1XJ+9NabYYqssDRqex/2eFOq2yALsANyCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429859; c=relaxed/simple;
	bh=6eveKoWYldzGiAn5SPTjlVpxToz0c47bJr2mMs5nx6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdKLimxiHs6nmdGx/GtCQkepTNiW4qQMLh+sllatkjwfIrtfC2cg22s69TflWph3lt730Kk3rwY8jX0y8RcmObS0algxB+2wAja83W5IYqZOo57Qwi0O4yAwEj2gom7PQEG82PUC9eYFlvde40pvUspqFt4+3LzwDfLsyZj6bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E4401007;
	Thu, 14 Mar 2024 08:24:53 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA7FB3F762;
	Thu, 14 Mar 2024 08:24:14 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:24:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <ZfMWnIr6gf5xu2UB@bogus>
References: <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
 <20240313171756.GA82165@e130802.arm.com>
 <ZfMPS+qn0lh5IrS7@p14s>
 <ZfMQyJWTh15P7Ru3@bogus>
 <20240314151653.GA40443@e130802.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314151653.GA40443@e130802.arm.com>

On Thu, Mar 14, 2024 at 03:16:53PM +0000, Abdellatif El Khlifi wrote:
> Hi Sudeep,
>
> On Thu, Mar 14, 2024 at 02:59:20PM +0000, Sudeep Holla wrote:
> >
> > I think Robin has raised few points that need clarification. I think it was
> > done as part of DT binding patch. I share those concerns and I wanted to
> > reaching to the same concerns by starting the questions I asked on corstone
> > device tree changes.
>
> Please have a look at my answer to Robin with clarifications [1].
>

Yes I did take a look at the response but am not convinced yet. I have
responded to you email with other details which I want to be explored.
I don't think we need to rush to add the *foundation driver* as you call
before the bindings are defined well.

--
Regards,
Sudeep

