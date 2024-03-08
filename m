Return-Path: <linux-kernel+bounces-97004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA77876451
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7781F281A58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC35786E;
	Fri,  8 Mar 2024 12:29:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E656456;
	Fri,  8 Mar 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900949; cv=none; b=Ab0m2mOPit7Lhmzs1O+8R5UaW9W2gqqAEf7tySQm+v/p0RqR92OyXfHL5XBpVrbivfUuTN+z469lDhZD4HtVOP6Qe+kCM3BK2Uj2EOkXZkIW09JpiA5PIDULPWzX8lwT1bsR9z4VD2hbwP9knc0ffpj6kPhQCd1gljIz1PBVuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900949; c=relaxed/simple;
	bh=J1WQUOExGT2BUFKbzdvuQXj04tR/Nr0MoFLS79WMU+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugFfHJA72BDA8B94uM48OvsXPVOIf1L0JLzjtze3tJ2QHR7SfP5s+CgG17GdbXSe/LUeOmpCgPN57HabGlVUsFhcVbnmrv1YMsWEMhnYYNfSCptxcuKzXSBAZnKMwpfWqhkMmHgXnKpnx1y9mc56FiqpigbhFR56WwM1iybkkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 002B0C15;
	Fri,  8 Mar 2024 04:29:43 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0520F3F73F;
	Fri,  8 Mar 2024 04:29:03 -0800 (PST)
Date: Fri, 8 Mar 2024 12:29:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: abdellatif.elkhlifi@arm.com, Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
Message-ID: <ZesEjbl4IITA4Yie@bogus>
References: <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <9fcebf32-a3da-49ab-b3d9-9450fb7e1985@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fcebf32-a3da-49ab-b3d9-9450fb7e1985@linaro.org>

On Fri, Mar 01, 2024 at 08:30:43PM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2024 17:42, abdellatif.elkhlifi@arm.com wrote:
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > 
> > introduce the bindings for Arm remoteproc support.
> > 
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > ---
> >  .../bindings/remoteproc/arm,rproc.yaml        | 69 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> 
> Fix order of patches - bindings are always before the user (see
> submitting bindings doc).
> 
> >  2 files changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> > new file mode 100644
> > index 000000000000..322197158059
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/arm,rproc.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/remoteproc/arm,rproc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Arm Remoteproc Devices
> 
> That's quite generic... does it applied to all ARM designs?
> 

Nope, it is platform specific. It can't just generically be referred as
Arm Remoteproc for sure.

-- 
Regards,
Sudeep

