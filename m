Return-Path: <linux-kernel+bounces-47060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32E8448BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A71C2315A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D673FE47;
	Wed, 31 Jan 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haYT871A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A733FB39;
	Wed, 31 Jan 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732562; cv=none; b=WFDnkWc6ttFN3ZH78qQZ2uPdbB0xSCQpA6w6m6NPJc4X7D/43uV84W1T93G1hHBOfO2rnXQJx6lYCZ9zgrAgpn9YDUkGsZLT6OJymdd3qqbCBUwW+lGPU5M3tUHlYsUUqj9RfWrOpiep47uDjhnXengD9pC58C4/z1yYhnZweeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732562; c=relaxed/simple;
	bh=qd/w5Bcuf2svgiEaBng8uEFP+/hQ9TBMaFzh70vee4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE8yRuXDbY9LH46wHXExqWSItrARwazGCgo8N6UwOemZaFaSzvpGjPI/wSuy3vulUL5IMVHPuoqOPbWzEhNrXb8BcjxZaPGLjMPyNTS+29dopY32Y7S/jKInlMs0MIiReM60N0K1F0zP7hD7oxM05DE2ENXFrFdVP7N5krkDykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haYT871A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FABC433F1;
	Wed, 31 Jan 2024 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732561;
	bh=qd/w5Bcuf2svgiEaBng8uEFP+/hQ9TBMaFzh70vee4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haYT871AjlVRcMjGMJ5jr8i6K3lktJn5RibSXPsjUf+1fm+UTvAmvdLV7GIPk+i7z
	 p1UXFNdz/xYWIwO5FaL60DFz56gNy0yYD2jHq6aDAiuh1RJPILXSHEwz0AjbpgURxK
	 nbzeLCsifWDlIJ2UM6G0LSSQvI3wLMU6L3dp69Y0ZyXM9HAXAHWeM2+wJKOUs1fkor
	 TbN0keNBgCc2jRipyt0wwM+5H4og0RqwNIGz10eH+i55CaWgFv5tO0JH6CW08iBZeA
	 U74JjuOwK6M3YwdKrOT5hscZuOWwrfKYWPPIDVs0FmMlbcW4KKLXcDyKMd0O+QmnSy
	 RjtfPZ3G+GfhA==
Date: Wed, 31 Jan 2024 14:22:39 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: Document reset-related
 properties
Message-ID: <20240131202239.GA2222869-robh@kernel.org>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
 <20240129-x13s-touchscreen-v3-1-c4a933034145@quicinc.com>
 <ZbfYzyHaNmjJyNpY@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfYzyHaNmjJyNpY@hovoldconsulting.com>

On Mon, Jan 29, 2024 at 05:56:47PM +0100, Johan Hovold wrote:
> On Mon, Jan 29, 2024 at 08:47:47AM -0800, Bjorn Andersson wrote:
> > Some I2C HID devices has a reset pin and requires that some specified
> > time elapses after this reset pin is deasserted, before communication
> > with the device is attempted.
> > 
> > The Linux implementation is looking for these in the "reset-gpios" and
> > "post-reset-deassert-delay-ms" properties already, so use these property
> > names.
> 
> > +  post-reset-deassert-delay-ms:
> > +    description: Time required by the device after reset has been deasserted,
> > +      before it is ready for communication.
> > +
> > +  reset-gpios: true
> 
> Hmm, for the third time, it seems you ignored my comment that you need
> to remove the comment about these properties from the driver as part of
> this series.
> 
> 	/*
> 	 * Note this is a kernel internal device-property set by x86 platform code,
> 	 * this MUST not be used in devicetree files without first adding it to
> 	 * the DT bindings.
> 	 */
> 	if (!device_property_read_u32(dev, "post-reset-deassert-delay-ms", &val))
> 		ihid_of->post_reset_delay_ms = val;

DT devices should have a specific compatible that gives enough detail to 
handle this delay or *any* other power sequencing requirement.

OTOH, we've already got one other delay property, what's one more. Sigh.

Acked-by: Rob Herring <robh@kernel.org>

Rob

