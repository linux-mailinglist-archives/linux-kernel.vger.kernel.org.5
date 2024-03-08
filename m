Return-Path: <linux-kernel+bounces-97116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA158765B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D01C21710
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D561DA5F;
	Fri,  8 Mar 2024 13:55:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713D1C693;
	Fri,  8 Mar 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906108; cv=none; b=V1hur+mCO3oCQW/i6kf2ZxapviKcoAzKD3hUSNBVOOAUZkZLaReSCv1Qe+9OYwirxWpAlmz49mAbezO2MAd+Kf+uwIRKDV4VUObV/AgvvTjQ8CzvsRFKnD3J8Zp3ItiG000UEgLZV8e/ipW+ibeJyZ3NO/naSpmkDvj4aTcsi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906108; c=relaxed/simple;
	bh=gpe31UXeX7bcdJyL7trsKR/X8oxuIkkTElqB+1EPXoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4cYJRXZedOzBJz02ORgixXvi8Fd+wNdoBBMw9QEoiMrYK41DPysfhk0ImQHHvFZIuOZP39EuVYhsJ9e2xW2uoVNf0EAJROkhK38QPW5TqRsg7VoA4eTLkxyuAJvdryZl1il6eDzozCck6ZZk4qIibNswha0bS04gWxKwcHgG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22596C15;
	Fri,  8 Mar 2024 05:55:43 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.14.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34A953F762;
	Fri,  8 Mar 2024 05:55:03 -0800 (PST)
Date: Fri, 8 Mar 2024 13:54:59 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Message-ID: <20240308135459.GA193849@e130802.arm.com>
References: <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <9fcebf32-a3da-49ab-b3d9-9450fb7e1985@linaro.org>
 <ZesEjbl4IITA4Yie@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZesEjbl4IITA4Yie@bogus>

Hi Krzysztof, Sudeep,

> > > diff --git a/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> > > new file mode 100644
> > > index 000000000000..322197158059
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> > > @@ -0,0 +1,69 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/remoteproc/arm,rproc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Arm Remoteproc Devices
> > 
> > That's quite generic... does it applied to all ARM designs?
> > 
> 
> Nope, it is platform specific. It can't just generically be referred as
> Arm Remoteproc for sure.

Thank you guys.

The file names and the documentation will reflect that it's
an Arm Corstone SoC. Work in progress.

Cheers,
Abdellatif

