Return-Path: <linux-kernel+bounces-36155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5E839C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702C91C21394
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204053E14;
	Tue, 23 Jan 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knFiS+ei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A86537E4;
	Tue, 23 Jan 2024 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049807; cv=none; b=LtaRAgb1kgun0Qa7LNQzYVCdLq9WcZyQzCBBKLYjRU9QkksCxAp1z+ayr04tSLTqTNngovp2wuUQk7mBfDKhy99VN6smN6I9ZDcU+dDg71GrQH7v26UlkDA4AFPdiGYuQ/Yk1IT8gBDarEK2kuG9kg/pmNV8Lq0nj+j3ytRR8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049807; c=relaxed/simple;
	bh=OZ+avPulNNisVb7nIuTgyy31n+guDcyVHhHC4vVCTik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8NTqwXN1qi9Acv5z83bowCms3xOUMvSBlChNNkwrKMPKlVBmWdKVpMA0kZKu5Ou5ZbvpccLopPEt9XL1/KOF9WovJt3p0B3GMzKnV6xRwL1t+vEAdqQLtfoXnyZtPqGvugHpPBP6Kq3kP5dMTRqUyPWp1J16xxYyMiKmVP3JAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knFiS+ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A3C433C7;
	Tue, 23 Jan 2024 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706049806;
	bh=OZ+avPulNNisVb7nIuTgyy31n+guDcyVHhHC4vVCTik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knFiS+einGgUrPzfkPnTaPoUq2xcsI9VXuTrwTmxVfuEHPua8Dz+ORgpHeU9/np1Q
	 SeyEj6blGzq1OXkZ8K2JE2leSz0gRcl88CpS32bGggNtuE+S5Z3NYnTj5vKhmFmm5c
	 PRW4QFjNCeFTKqGvD2k5QgVO07arVLWIlN7QwcTa9dx38JGnCjvCDYpafEDluoEaIC
	 PqPdNXKQNTqaqnAJhNwVadHhAuKBxqhM4PmtlnQEm8usfgAjRd8lXea8S1aKyhMaJZ
	 4Tx7GfpTpdo6z1Jf270T9er5Nqvk1t8Q9JO2O+gO4LX+NHhKGZ3jcRbYqmdctN8dXo
	 KdotvPM66vx5Q==
Date: Tue, 23 Jan 2024 16:43:24 -0600
From: Rob Herring <robh@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI
 bus addressing
Message-ID: <20240123224324.GA2181680-robh@kernel.org>
References: <20240122173514.935742-1-robh@kernel.org>
 <BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR18MB4251944C1AE34057DACD7556DB742@BN9PR18MB4251.namprd18.prod.outlook.com>

On Tue, Jan 23, 2024 at 09:59:46AM +0000, Elad Nachman wrote:
> 
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, January 22, 2024 7:35 PM
> > To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [EXT] [PATCH net-next] net: marvell,prestera: Fix example PCI bus
> > addressing
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > The example for PCI devices has some addressing errors. 'reg' is written as if
> > the parent bus is PCI, but the default bus for examples is 1 address and size
> > cell. 'ranges' is defining config space with a size of 0. Generally, config space
> > should not be defined in 'ranges', only PCI memory and I/O spaces. Fix these
> > issues by updating the values with made-up, but valid values.
> > 
> > This was uncovered with recent dtschema changes.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/marvell,prestera.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > index 5ea8b73663a5..16ff892f7bbd 100644
> > --- a/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > +++ b/Documentation/devicetree/bindings/net/marvell,prestera.yaml
> > @@ -78,8 +78,8 @@ examples:
> >      pcie@0 {
> >          #address-cells = <3>;
> >          #size-cells = <2>;
> > -        ranges = <0x0 0x0 0x0 0x0 0x0 0x0>;
> > -        reg = <0x0 0x0 0x0 0x0 0x0 0x0>;
> > +        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> > +        reg = <0x0 0x1000>;
> >          device_type = "pci";
> > 
> >          switch@0,0 {
> > --
> > 2.43.0
> > 
> 
> This yaml has a mix-up of device P/N (belonging to AC3, BC2) and PCIe 
> IDs (belonging to AC3X, Aldrin2)
> Looks like a part of the yaml was updated, and another part was not
> 
> There is a reference here of actual usage of prestera switch device:
> https://github.com/dentproject/linux/blob/dent-linux-5.15.y/arch/arm64/boot/dts/marvell/accton-as4564-26p.dts

That doesn't match upstream at all...

> 
> So actual ranges and reg could be used instead of made up ones.
> 
> But the actual real life dts places the prestera at the top level of 
> the dts, not under pci.
> 
> I am not aware of any dts/dtsi using such kind of switch node under 
> pcie node, similar to the example given in the yaml file, and did not 
> manage to find any under latest linux-next for both arm and arm64 dts 
> directories (please correct me here if I am wrong).

Don't know. It seems plausible.

> 
> So the question here is if this pci example really necessary for the 
> prestera device, or can be removed altogether (which is what I think is best to do).

Miquel's commit adding indicates such devices exist. Why would he add 
them otherwise?

Anyways, I'm just fixing boilerplate to make the PCI bus properties 
valid. Has nothing to do with this Marvell device really.

Rob

