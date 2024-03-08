Return-Path: <linux-kernel+bounces-97165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31085876655
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50381F20EF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3FF4597E;
	Fri,  8 Mar 2024 14:25:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61888BEF;
	Fri,  8 Mar 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907954; cv=none; b=auDddQ6QlPVVupYjJmbVxGXsWRE+ffDPSFhzG4QGeI6ggGI5WzX41DbfnFO5fKFi6x/7ffRgTxlfXvnIY90c//1yety/XZzF7NU+R8EX/MxMjJTVl7TFyXG2Zxi/hWYkj/bQb03ZwVCzOiEbdzMkk2rolBLqFrsQPEBr6c1/cBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907954; c=relaxed/simple;
	bh=mAC+4ej7DrcSMbXBjoEZjocQGNkjds5CH7pc+Qy5KD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azt+aMUZdVJrC19SsSD9+A0GVA+DdcQMic/MPq++GaCT6aR5++l3AGD2Pd5Xy1omcLCjzqiPMS6Tx2OIWMk7kODyYeXlC/3y3t37mj4NbqPvh8UOikdpd88lFgsq0IsxDSk0sMervBzhY2wz5NKO87ieW9i2YI4eNtb1Bn9ph0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8EDFC15;
	Fri,  8 Mar 2024 06:26:28 -0800 (PST)
Received: from e130802.arm.com (unknown [10.57.14.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E68CD3F762;
	Fri,  8 Mar 2024 06:25:48 -0800 (PST)
Date: Fri, 8 Mar 2024 14:25:45 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: Add corstone1000 external system device
 node
Message-ID: <20240308142545.GA199646@e130802.arm.com>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-3-abdellatif.elkhlifi@arm.com>
 <ZesCyIpRgi1EkixF@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZesCyIpRgi1EkixF@bogus>

Hi Sudeep,

> > +		extsys0: remoteproc@1a010310 {
> > +			compatible = "arm,corstone1000-extsys";
> > +			reg = <0x1a010310 0x4>,
> > +				<0x1a010314 0X4>;
> 
> 
> As per [1], this is just a few registers within the 64kB block.
> Not sure if it should be represented as a whole on just couple
> of registers like this for reset.
> 
> [1] https://developer.arm.com/documentation/101418/0100/Programmers-model/Register-descriptions/Host-Base-System-Control-register-summary

The Host Base System Control registers are not specific to the External System processors. They are various registers with different purposes.

Only 4 registers matter for the remoteproc feature:

    - The External system 0 reset control and status registers: EXT_SYS0_RST_CTRL, EXT_SYS0_RST_ST
    - Same for the the External system 1: EXT_SYS1_RST_CTRL, EXT_SYS1_RST_ST

So, mapping the whole Host Base System Control area doesn't make sense for the remoteproc feature
and exposes registers that are not related to the External Systems to the driver.

By the way, the latest document we are referring to is [1].

[1]: https://developer.arm.com/documentation/102342/0000/Programmers-model/Register-descriptions/Host-Base-System-Control-register-summary

Cheers,
Abdellatif

