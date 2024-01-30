Return-Path: <linux-kernel+bounces-45082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD058842B80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EA01F26170
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38743157031;
	Tue, 30 Jan 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgkb0wBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725991292DB;
	Tue, 30 Jan 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638405; cv=none; b=VfHkn6H6yzUneDE/TUQVDOPF7cMNUtYfyL4u2qH9iscTo+NKsqUnJRi+6nDT/FJnGFtutxKyubbU/IEjfspUshCkCyYl9PyRDUX3pprFgoQo4s+IWQSVSpCGNL3E3h9HofN7vVVhTisLr02k7aToKJhKEcikP0es+EXCo1ooW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638405; c=relaxed/simple;
	bh=tvb6k0t50n+XwnKfJ0/ZnnU9tJS9kWB+9f5a4l0aPGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHbChy9MLi8phvUevQIxXkSndEVHSjlL/oZCYi8hCkeoI+SjA1M7/EAAVSNlxoKysHgBl87ZaGqzZ22WGPCJLo3Ak53kCkcyRErHBwDPcslxCtIaEIxxkhJwcPbRMwl/O5O9sBg/bQaiC7HCY3oJXJqUyey6A/4Iyl4VlBHekr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgkb0wBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89652C433C7;
	Tue, 30 Jan 2024 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706638404;
	bh=tvb6k0t50n+XwnKfJ0/ZnnU9tJS9kWB+9f5a4l0aPGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgkb0wBW35JPQhOvoprJ5i6MGC1/cO6mUu0OQ8i3/IjxgmeSsZ2XgUgiDPAWFDORX
	 fllBj2iiO0Li0X2xPRTsGuoG11bFoSupI2HHRbQxVvLTjBA+TbfZ8s1cCKHZviI0ca
	 lYQ1gedydbSDG8JDt/cuWMC3FsfEQtLK0LbOMcAPp2aFVJXC4S4EMYMUTAUdLAJxMp
	 Jwc4eFUTYdUKF6jjpBPF7zTYfhd0WhEAg1PnrJzeMLMtUNE5sZFFbmGTEF0ovlFSd5
	 +SfwoidLU5nO0+f9TyS9WZfhQhIKHYKX5M3j9aaIVmGV79zUO//1g12+nz+VahY3cb
	 iiX6foTCrwqOw==
Date: Tue, 30 Jan 2024 12:13:22 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <20240130181322.GA2079185-robh@kernel.org>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-video-lumpiness-178c4e317f5a@spud>

On Wed, Jan 24, 2024 at 05:59:00PM +0000, Conor Dooley wrote:
> On Wed, Jan 24, 2024 at 12:47:14PM -0500, Frank Li wrote:
> > On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> > > On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > > > From: Ran Wang <ran.wang_1@nxp.com>
> > > > 
> > > > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > > > (or its control signal) will turn on immediately on related Root Hub
> > > > ports. Then the VBUS will be de-asserted for a little while during xhci
> > > > reset (conducted by xhci driver) for a little while and back to normal.
> > > > 
> > > > This VBUS glitch might cause some USB devices emuration fail if kernel
> > > > boot with them connected. One SW workaround which can fix this is to
> > > > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > > > host mode in DWC3 driver(per signal measurement result, it will be too
> > > > late to do it in xhci-plat.c or xhci.c).
> > > > 
> > > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > index 203a1eb66691f..dbf272b76e0b5 100644
> > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > @@ -273,6 +273,13 @@ properties:
> > > >        with an external supply.
> > > >      type: boolean
> > > >  
> > > > +  snps,host-vbus-glitches:
> > > > +    description:
> > > > +      When set, power off all Root Hub ports immediately after
> > > > +      setting host mode to avoid vbus (negative) glitch happen in later
> > > > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> 
> nit: "will return to"
> 
> > > > +    type: boolean
> > > 
> > > Why do we want to have a property for this at all? The commit message
> > > seems to describe a problem that's limited to specific configurations
> > > and appears to be somethng the driver should do unconditionally.
> > > 
> > > Could you explain why this cannot be done unconditionally please?
> > 
> > It depends on board design, not all system vbus can be controller by root
> > hub port. If it is always on, it will not trigger this issue.
> 
> Okay, that seems reasonable to have a property for. Can you add that
> info to the commit message please?

But if vbus is always on, then applying the work-around would be a NOP, 
right? So you could just apply this unconditionally.

Rob

