Return-Path: <linux-kernel+bounces-47763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218B084527C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5681F23A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392D159574;
	Thu,  1 Feb 2024 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJazJQD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E751586D3;
	Thu,  1 Feb 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775328; cv=none; b=XsoWrh/1oocE3sGsZTlMEIE94sCeIWoBVkhDc4RIZM0i4LZZBLo6pbxoxE1QuQfB83RXgXWzka3B1PzOVefarngqSqtTPt7iG+NyY0OU0sDZEpFuMlQ78D5A8FabP+wHaU0GZd6L/90AIrU0my1DJAsCdc4OWbeP36yij6MWkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775328; c=relaxed/simple;
	bh=kkm9m85BchBsg8gyaeBqfM19x9yX2lcmT5vikkpEihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKgA3hCTsJs9R/OOyJ8MwBC8G9110B6QaOaSb5VBVrtT/PvG/dUR1W1qlbMqRCTgEyzZ/6y5yXJXkYgbU+AhYNaEWyIMDeEqR3WIphj72wOE9CMsksy69uYiFvk8gOh8hTJZnmhphZjMKDCjJaxZYJBEc1DG8sFimRrbOPgfkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJazJQD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383F0C433F1;
	Thu,  1 Feb 2024 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706775328;
	bh=kkm9m85BchBsg8gyaeBqfM19x9yX2lcmT5vikkpEihs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJazJQD5szwbMpJjuDL/t7jXeKWf6+Ijqym93J1qnpgke0tVyOxVGhkhGQFkiGNMs
	 ttaJMhC3XyipqNfXK08pO9FnS61CrIyGPPBH4wVfW/bJuM7EsOaH045gKDD/TMzJvQ
	 R11u5YQ6YkJeqv5I1kqMnS9GOBmnbyLp1wdhVro6D1B10HLyGxrpILn3YsmL3Y9Wel
	 wGBTYcn+Qh5DdzVM5V76DhXN3LnA5AhGZqMFPY6AJvQw7R8pDsNA8jsXTF48Ue0DNO
	 kyhpohL1nC3ewZJARLrTUVm5OZJnTB3RbyhMnxekBaRtcSEITFl9uy0Qv2u2qtE5sq
	 U/+pdea5NfSnQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rVSEL-000000005lV-1gxB;
	Thu, 01 Feb 2024 09:15:29 +0100
Date: Thu, 1 Feb 2024 09:15:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <ZbtTIYFzMVLMxb10@hovoldconsulting.com>
References: <20240129-x13s-touchscreen-v3-0-c4a933034145@quicinc.com>
 <20240129-x13s-touchscreen-v3-1-c4a933034145@quicinc.com>
 <ZbfYzyHaNmjJyNpY@hovoldconsulting.com>
 <20240131202239.GA2222869-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131202239.GA2222869-robh@kernel.org>

On Wed, Jan 31, 2024 at 02:22:39PM -0600, Rob Herring wrote:
> On Mon, Jan 29, 2024 at 05:56:47PM +0100, Johan Hovold wrote:
> > On Mon, Jan 29, 2024 at 08:47:47AM -0800, Bjorn Andersson wrote:
> > > Some I2C HID devices has a reset pin and requires that some specified
> > > time elapses after this reset pin is deasserted, before communication
> > > with the device is attempted.
> > > 
> > > The Linux implementation is looking for these in the "reset-gpios" and
> > > "post-reset-deassert-delay-ms" properties already, so use these property
> > > names.
> > 
> > > +  post-reset-deassert-delay-ms:
> > > +    description: Time required by the device after reset has been deasserted,
> > > +      before it is ready for communication.
> > > +
> > > +  reset-gpios: true
> > 
> > Hmm, for the third time, it seems you ignored my comment that you need
> > to remove the comment about these properties from the driver as part of
> > this series.
> > 
> > 	/*
> > 	 * Note this is a kernel internal device-property set by x86 platform code,
> > 	 * this MUST not be used in devicetree files without first adding it to
> > 	 * the DT bindings.
> > 	 */
> > 	if (!device_property_read_u32(dev, "post-reset-deassert-delay-ms", &val))
> > 		ihid_of->post_reset_delay_ms = val;
> 
> DT devices should have a specific compatible that gives enough detail to 
> handle this delay or *any* other power sequencing requirement.
> 
> OTOH, we've already got one other delay property, what's one more. Sigh.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Right, and I guess we could do this now before this new property gets
more use. Who knows if those delays are actually correct or may need to
be tweaked down the line.

Apparently we only have one specific i2c-hid compatible in the kernel
(and it's not yet used by the driver).

Johan

