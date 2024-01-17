Return-Path: <linux-kernel+bounces-29422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC558830E05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33243B22687
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ACF25569;
	Wed, 17 Jan 2024 20:31:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA725638;
	Wed, 17 Jan 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705523512; cv=none; b=cOzzuLiUp2zuUQsmA39NeDqNtkk6pop6WL9R6Ueos3pAWuxKCwmeTOvOZp3JAyMU/NgNds6+gy9ftM0KBdvWT5ed9JBEVvxoZrgpD4LAuUWowfefG5Dt9yQPEE6NNqKu5GuP49kx9df51jbUn3VrW4x6HEFj+DYlItA06oDZsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705523512; c=relaxed/simple;
	bh=q25+NSI1+z71AjKViJgDRfzGgWgKq/JnN467gAc5EMc=;
	h=Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=cLei64FnW7RrcqFN2N5yILrLpfOBDwdjwSPs7SpfCQhXiFr241oH3d8rnOWDZsqnFY/f96KVB4tYXaPwm7djMn2+x80gVTpgCkBhWQ+s77md7gEdl0/okAAHoBOPlk9VFZ5Y+Nl2DN7O9tDr3R9/erKjmylrnRwEdKouO1DpVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F84711FB;
	Wed, 17 Jan 2024 12:32:34 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B7E63F766;
	Wed, 17 Jan 2024 12:31:46 -0800 (PST)
Date: Wed, 17 Jan 2024 20:31:43 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	andersson@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Message-ID: <Zag5L9j8-oCebKFm@pluto>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
 <3325c6ea-ca30-40ee-83ba-c489dc9964b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3325c6ea-ca30-40ee-83ba-c489dc9964b1@linaro.org>

On Wed, Jan 17, 2024 at 09:15:40PM +0100, Konrad Dybcio wrote:
> 
> 
> On 1/17/24 18:34, Sibi Sankar wrote:
> > From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > 

Hi,

a few early remarks, I am gonna look at this better next week.

> > SCMI QCOM vendor protocol provides interface to communicate with SCMI
> > controller and enable vendor specific features like bus scaling capable
> > of running on it.
> 
> "QCOM protocol" sounds overly generic, especially given how many
> different vendor protocols have historically been present in
> QC firmware..
>

I was going to raise the same point :D, usually the name identifies the
aim of the protocol (and the vendor also in this case)

> > 
> > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > Co-developed-by: Amir Vajid <avajid@quicinc.com>
> > Signed-off-by: Amir Vajid <avajid@quicinc.com>
> > Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> 
> So, this is another 0x80 protocol, different to the one that has
> been shipping on devices that got released with msm-5.4, msm-5.10
> and msm-5.15 [1][2]. They're totally incompatible (judging by the
> msg format), use the same protocol ID and they are (at a glance)
> providing access to the same HW/FW/tunables.
> 
> I'm not sure if this can be trusted not to change again.. Unless
> we get a strong commitment that all platforms (compute, mobile,
> auto, iot, whatever) stick to this one..
> 
> That said, the spec (DEN0056C) says that protocol IDs 0x80-0xff
> are: "Reserved for vendor or platform-specific extensions to
> this interface.". So if perhaps there's a will to maintain
> multiple versions of this, with a way to discern between them..
> 

Just recently we had a discussion with some other vendor about this
possible clashing of vendor protocols numbers between different
vendors/platforms, especially if aiming to just push all in defconfig.

The basic idea to solve this, which I am going to post shortly in
the next weeks, was to add a way to define and register your protocol
number associated with a vendor identifier(s) of some kind, since
vendor/subvendor/firmware versions are advertised by the Platform
and are retrieved via Base protocol at probe time upfront;
this way it 'should' be feasible to compile in any existent vendor
protocol but allow at run-time only the registration with the SCMI core
of the protocols whose vendor identity matches that of the identity
advertised by the running firmware....

..still not sure which of the IDs to use vendor/subvendor and still
not have really experimented with this...so any feedback welcome.

This would rule out, anyway, the capability of solving number clashes
within the same vendor.

Thanks,
Cristian

