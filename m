Return-Path: <linux-kernel+bounces-31629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A774833195
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1671C22C24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5135916C;
	Fri, 19 Jan 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXNx4Ijx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141721E48E;
	Fri, 19 Jan 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707154; cv=none; b=D+eVO16eTUFLJkE6/LOvZZcBzZqRdMCzhTlwsR5r2hb2vbUVJiFzjisBY5cIRsuouaTLTa0NRfmnedoTNUcthyuYByxx2gt984H+WBGGTzCwj9PfX24P8HoXXBLvgnys/FDUMvAP1zI4y4wBsIzp5q1bck2dBua8Ywdaz3BIPBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707154; c=relaxed/simple;
	bh=0njnpt+axtxNz55+YBb6DRGhAstP7ROSY1y8ZGxyMYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNPCWgLmx/C+4WJd51y/sSjdHVeneFvFFQ5PdRDoTwA+c32IoWAwtOPA2hD6OAQhJEHGgKVZzZtNpWHdZWVcRXc1c+tD7gfFu+K0ir8ejWbN+k1vLe8ZVOr3tWdOTaRDUO+Igqah/Rk4mHvlWxnFF2uRGHlxUEp2xLi6d/oKmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXNx4Ijx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E681C433F1;
	Fri, 19 Jan 2024 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707153;
	bh=0njnpt+axtxNz55+YBb6DRGhAstP7ROSY1y8ZGxyMYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXNx4IjxStlOSl6cCEUs5p74oQm2K/C9FtBsTFIwE1sYXlWA5rpF2UQlm8B5pKGmP
	 hVdPHLeWEn6plevX6SykFB7TBmsIHwclB3ixC1cYqFrkbO5WATNV3ELg41/nIi/3DP
	 4Vp5ZVO1XYGEq00yGQyHNWug5VDWR3VIvpALDCs8HwX3T42/EylEkPgHRLZV2fxzYe
	 aWNTn9IzyeTHK13xO03eZba8+xG/RC/sANUhEKHYr90VCmptLROLfYewzBoe3IR1Gj
	 eBzF9CG5nEc/afr/XupJK5Gb4QxNjzdgW75GEDzU+ihqPPzRSUWTQomHsO0z4zoLqA
	 pFQqiD7BXQP3Q==
Date: Fri, 19 Jan 2024 17:32:31 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: fpga: Convert fpga-region binding to yaml
Message-ID: <20240119233231.GA1290941-robh@kernel.org>
References: <4d87561dcbfab9e4818d7ad99caf89938774a839.1705491050.git.michal.simek@amd.com>
 <20240117214722.GA3176505-robh@kernel.org>
 <1aa2c865-3a9b-441a-ba61-b551f3f7a832@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa2c865-3a9b-441a-ba61-b551f3f7a832@amd.com>

On Thu, Jan 18, 2024 at 01:34:16PM +0100, Michal Simek wrote:
> 
> 
> On 1/17/24 22:47, Rob Herring wrote:
> > On Wed, Jan 17, 2024 at 12:30:58PM +0100, Michal Simek wrote:
> > > Convert the generic fpga region DT binding to json-schema.
> > > There are some differences compare to txt version.
> > > 1. DT overlay can't be described in example that's why directly include
> > > information from overlay to node which was referenced. It is visible in
> > > example with /* DT Overlay contains: &... */
> > > 
> > > 2. All example have been rewritten to be simpler and describe only full
> > > reconfiguration and partial reconfiguration with one bridge.
> > > Completely drop the case where fpga region can inside partial
> > > reconfiguration region which is already described in description
> > > 
> > > 3. Fixed some typos in descriptions compare to txt version but most of it
> > > is just c&p from txt file.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>

[...]

> > > +additionalProperties: true
> > 
> > Why? This should only be used if another schema is going to include this
> > one. That's not the case here.
> 
> In v2 we discussed this with Krzysztof. I used pattern properties from
> simple-bus.yaml in v2.
> 
> https://lore.kernel.org/all/b2dd8bcd-1e23-4b68-b7b7-c01b034fc1fe@linaro.org/

You didn't answer his question. You just picked up 
'additionalProperties: true' which is easy because it avoids 'problems'.

His question was is this a common schema referenced by other schemas? If 
so, then use 'additionalProperties: true'. But it is not. You've 
defined exactly what 'compatible' must be and that means it can't be a 
common schema.

> 
> > 
> > 'type: object' would be acceptable here as that says only nodes can be
> > added.
> 
> What do you think should be patternProperties in this case?

You are the one with FPGAs, what do you need?


> I played with it a little bit but all nodes with @ are likely object type.

'@' is only allowed in node names, so it's more than just likely.

> But what to do with others?
> There are nodes as you see in examples like fixed-factor-clock nodes which
> are also object type.

Then the node names can be anything and you should use what I suggested.

> Standard property like firmware-name or encrypted-fpga-config are coming via
> overlay for sure. Others are not permitted. That's why others then listed
> properties likely must be type object. Is there an elegant way to encode it?

Sorry, I don't follow. You should list every possible property, then the 
only thing left are nodes and my suggestion covers them. If there's a 
pattern to the node names, then you can use patternProperties.

> > > +
> > > +examples:
> > > +  - |
> > > +    /*
> > > +     * Full Reconfiguration without Bridges with DT overlay
> > > +     */
> > > +    fpga_region0: fpga-region {
> > 
> > Drop unused labels.
> 
> Actually it is kind of used. I kept it to be able to reference something in
> comment below.

Okay. Kind of outside the scope of examples and schema as I mentioned.


> > > +      compatible = "fpga-region";
> > > +      #address-cells = <1>;
> > > +      #size-cells = <1>;
> > > +      fpga-mgr = <&fpga_mgr0>;
> > > +
> > > +      /* DT Overlay contains: &fpga_region0 */
> > > +      firmware-name = "zynq-gpio.bin";
> > > +      gpio@40000000 {
> > > +        compatible = "xlnx,xps-gpio-1.00.a";
> > > +        reg = <0x40000000 0x10000>;
> > 
> > This example implies this is a translatable address, but the lack of
> > 'ranges' in the parent prevents that. In turn, that means unit-addresses
> > should be accepted in the parent node name as well.
> 
> v1 contains ranges property and it was removed based on Krzysztof comment
> that fpga-region has no unit address that's why ranges shouldn't be used.
> 
> https://lore.kernel.org/all/c3c92468-a1db-498b-b4a2-7926b84cb5ea@linaro.org/

Plain "ranges;" does not have a unit-address. But really, you should 
allow a non-empty ranges too and therefore allow for a unit-address.

Rob

