Return-Path: <linux-kernel+bounces-111943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3A887313
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F081283910
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F1664D5;
	Fri, 22 Mar 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r48PI8dm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE065E03;
	Fri, 22 Mar 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132045; cv=none; b=J4P+PtwMiGLbCokD6Guzom1sNt1TUqTmsFpkK3QRTADdOCYCc6Vbu7ZbQsm5r5KvyUVTnhs8yu3LCIXCew7jb3Qf7Rr+KF+hFt/sGs6f2g+xq1YARp+Tr4ZVvu9oDPpK7lOLdyuQ3RhgKkSEVN589N5e+zWb/x0R7mPslnHF1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132045; c=relaxed/simple;
	bh=KdUPhEB4GX59wa/Dam1DH90VdQKKW2JpaS9TlBZ2j1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW7kRgA7bF0i1POcBXIiAZCkRaM0OQdSpF8SZW64w0+KS99kYGvF52P2YNb0ugwH9H5jIhJxE0sbUuSnJXLLxE+S8DvjfXJBYnxGGYX0RFGJJWX+XXVJ8RM1G2li2oYT5LcBXigRFMPvzd0G2W8EoAIiIh4fR31dYeJ7w4iK6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r48PI8dm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dy3pQ9tsRblmVlWIxN7k7bKK1R7o3EQe6wvNzDLkr+E=; b=r48PI8dmdIPatdP6KyPfNq6uPm
	AD/RoOL/3AwTC5s07HTx5y7fLyPjbeMfUklRR91pE3bw5VjFXYr6n3L/boBiPLmOYYiVo/aCzvCe/
	vtPq/TTmg8S0FsIEWUfwJzBwL2EE3RvV7+hvWreJu3qweoaG0tCwBLJoVISZ7siAGRB4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnjbl-00AyiE-P8; Fri, 22 Mar 2024 19:27:13 +0100
Date: Fri, 22 Mar 2024 19:27:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Message-ID: <5935fc9b-9190-422d-813a-b7a6a26e3244@lunn.ch>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
 <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
 <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
 <8ad64d2e-2be9-4d59-907b-669fdedc3695@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad64d2e-2be9-4d59-907b-669fdedc3695@solid-run.com>

On Fri, Mar 22, 2024 at 06:14:38PM +0000, Josua Mayer wrote:
> Am 22.03.24 um 16:38 schrieb Josua Mayer:
> > For the discrete PHYs, the generic LED code can make use of the
> > hardware offload support to read back the hardware configuration and
> > configure itself to match. The switch code is missing hardware offload
> > at the moment. So it cannot read back the current
> > configuration. However, it is simple code to add, and the discrete
> > code is a good example to follow.
> I have prototyped this on top of your patch-set, supporting offload
> for a single mode.
> It works as explained by you - first after boot-up the LEDs
> are executing their default function autonomously.
> 
> When I set trigger netdev, I can see offloaded property is 1,
> and when I enable extra bits offload turns off.
> 
> 
> For Clearfog Base I have added the requested LED descriptions,
> it should be ready now.
> 
> The Pro version I could
> 1) submit new version with only phy leds
> 2) wait (not preferred)
> 3) submit new version with an separate patch adding switch leds
> (can hold of ack on it till the fait of your patch-set becomes clear)

You probably need to wait whatever. We are in the merge window. Many
maintainers don't accept patches during these two weeks. They want you
to submit against -rc1 once it is released. And there is no rush. The
next merge window is not for another 7 weeks or so. Gregory will
accept patches for mvebu for around 5 of those weeks.

       Andrew

