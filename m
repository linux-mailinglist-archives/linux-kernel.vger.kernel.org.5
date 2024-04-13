Return-Path: <linux-kernel+bounces-143829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B38A3DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308F81F2162B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792E4AEC8;
	Sat, 13 Apr 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="KyCr+azv"
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDA481BA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713028428; cv=none; b=QYmp0dl5BY0w7Lb/ceFWDxOEgIvst15fWWuR81bXe6ucnCUFlYNT0tptCPCphbFyWGELmIcXNxt/C7XPod8BQ6N+vNEgxpzI/e+jdI8SSLSuIVj073XXko/QJW7EMMICpIMAXN+Lxht5pRQlwsYTSlRyjmto2+EW8Stu+J+1ML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713028428; c=relaxed/simple;
	bh=IVys/OiNau2OwJaLogqS6aOLz32wgJUF4Aiij97BK7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eurH5nuuamq/MmW5DuQ0erUq0Sf34VCGCLKjXaojzZzmdfyIaGeWg9iXWz5hqK4ZdCegOfmpPsse4F/v1+2Eu+p2SW7h0XINn51r+68m41XldEqjm6Maan87Ua9+1VCiBkAvsPk8ofAVXVDAwtX1GWe2V50bwDpA/ASv1ncNnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=KyCr+azv; arc=none smtp.client-ip=62.149.158.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.26.8])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vgtdrfT9rM2Q6vgterM8lW; Sat, 13 Apr 2024 19:10:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713028235; bh=IVys/OiNau2OwJaLogqS6aOLz32wgJUF4Aiij97BK7s=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=KyCr+azv28uuA8I7oOf+sQfh3PKzO8LX1VI2yqJurHQhoaiPg7GXAOnDxu6iCqFKr
	 ezYHXoxV2iXiieykkKY9L9MP9unI06z3KuSC+5n7aeSvEW23clU2hW1EqOXVcmuuqd
	 lt2HjmvmOcOCvOyWaXACZgTnhn3spurIs2H4klZlrreQ8QiJLC/AF3JCNeM5jNrYwa
	 qvBJSQ3B1qgSYOP8c1Rjyu6UIKsihFw42wK7MY6Dvn4y91pzxCuAFvKQviVa/3sVds
	 ojf+U61RxKh/CkD0l6CSZClxMhNQzFdrJX6dqS+nBKLc0/8Kl4M9seB+Jx/CsnCLLP
	 NV3Pkh/83nllA==
Date: Sat, 13 Apr 2024 19:10:33 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B
 warm reset property
Message-ID: <Zhq8ibYrZH05/AQt@engicam>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org>
 <ZhjhCvVNezy9r7P4@engicam>
 <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org>
X-CMAE-Envelope: MS4xfKq1b6hvFtKreRQ6dwzzBYaCof8q+mOwvcHOyjN6qdlRBeO7CC54ocwz3MMSSwDiw5RBvNhaq40l3tLrV4K/rdlCrxdJZ1FvBh5LHyJu2PYCU+40xZzq
 mxxhaS/zhznl9DMGvH/VpwzYSvtqHDfY2+26MBOgPWT5Cm/5XzrFTgiRuuNxyjUpgjz0enliP7p96fHyxrkLkgIBuAFDpd81EIFTOQlTQSdTEdAUAodckqKO
 m8cSBQcErTUBsqO2M1Te4B73M1MxTIddCzRFlVQRGUKeNVzxMBgiUEaZdn7ZGc4G+E+kL5mw/KmsnReu9OcQFJTMRvCjb3c4K+Qowl7cuHOvhbBjIRpAmfkS
 jHfyx/Urx67u3cZiaf2nOB5AEseIKN66ir1JwQNo5utUircvftn2F0b4GiLdKmfoHcaRUxnbrH0h1d1ysX92Nn4wkJL4W9fCkIoBBvdin6C43QLVnK5myM5u
 s4AzYf+LUWmFVjWK

Dear Krzysztof,

Il Sat, Apr 13, 2024 at 12:58:35PM +0200, Krzysztof Kozlowski ha scritto:
> On 12/04/2024 09:21, Fabio Aiuto wrote:
> > Dear Krzysztof,
> > 
> > Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
> >> On 11/04/2024 18:58, Fabio Aiuto wrote:
> >>> Add property to trigger warm reset on PMIC_RST_B assertion
> >>>
> >>
> >> That's rather vague and does not tell me much why this is supposed to be
> >> board level configuration. It sounds more like a debugging feature:
> >> during development you want to retain memory contents for pstore etc.
> >> Then I could imagine this should be turned runtime, e.g. via
> >> sysfs/debugfs, because for example you want to start inspecting a
> >> customer's device.
> > 
> > thanks, I spent too few time writing this commit log and I apologize
> > for that. I was thinking about something like:
> > 
> >     The default configuration of the PMIC behavior makes the PMIC
> >     power cycle most regulators on PMIC_RST_B assertion. This power
> >     cycling causes the memory contents of OCRAM to be lost.
> >     Some systems needs some memory that survives reset and
> >     reboot, therefore add a property to tell PMIC_RST_B is
> >     wired.
> > 
> > The actual configuration is made at probe time, anyway we need
> > to override the default behavior of the pmic to get a warm reset
> > everytime the PMIC_RST_B pin is asserted and this property tells
> > us that "something is wired to that pin" and "it has to behave
> > that way on pin assertion". Our use cases do not meet the need
> > of further runtime configuration change.
> 
> What is the use case?

I just have an external power button connected to that pin, it works
either with warm reset and cold-reset-except-ldo12. Moreover the default behavior
is cold reset and not reset-disabled. Anyway I thought it was useful for other
people to add a property selecting behavior for that pin too as was done for
WDOG_B. That's why I mainly duplicated the logic. If there is a pin adding a
reset source it's a good point to provide a way to access the register bits
related to this signal.

> 
> Sorry, you did not bring any further argument why this is board
> specific. And please don't explain how probing works, but address the
> problem here: why type of reset is specific to board design. To me it is
> OS policy.
> 

Why reset type is specific to board design? I'm sorry but I don't know
what you mean, as said my intention was to enlarge the number of configurable
bits in pca9450 register space hoping this would be useful for someone.

All I can say is that is specific to board design for the same reason the
wdog_b- reset type was specific to board design.

Thank you for your time,

fabio

> Best regards,
> Krzysztof
> 

