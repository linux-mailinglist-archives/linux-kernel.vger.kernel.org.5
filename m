Return-Path: <linux-kernel+bounces-121292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C488E4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14BB1C2908E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3471448E0;
	Wed, 27 Mar 2024 12:40:28 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10EC1327F4;
	Wed, 27 Mar 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543227; cv=none; b=Q/gNXsFYBRmUHC/1RP7Mew+t02VmwN1LfJcfYYobhmwvH7lATQCFlfFFX0jWmK5aPoqzYVrSwau6o5Um3aogOllbUe06rUP2YF2VrvUe0CIJtoRODWS9fX1+eKb84Rw74wd/z8KZNjEykHdMae6Dr1uNwQroyzC9H4dar/gwUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543227; c=relaxed/simple;
	bh=CTTAq3BkhgMsFNfaZctwV7dwPAN7MSkPKrtMZ4zwGFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGumNKWONYBnhHTFnHBMf5qg67jFMAG738AkVKLtdc9MiAJ9tXkXXwy70JTF9Tj8PAAaeNlPwQkE79SVZ6SipADKswXF2Cc6fsN5vyEctrovw6XHV3Ahcr1tzXTO8KxLLzioBrJnhYRSBGIqFvMxpLYtQ2ARjewY5LyiK1Pr6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id F19C3101A8A5; Wed, 27 Mar 2024 13:40:15 +0100 (CET)
Date: Wed, 27 Mar 2024 13:40:15 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add VEPU121 to rk3588
Message-ID: <ZgQTrwOUtdZ1nRs0@desktop>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-4-linkmauve@linkmauve.fr>
 <a60f6017-bd19-431e-8cff-7d73f6f114fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vIGEYjDZeTRTEtgU"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a60f6017-bd19-431e-8cff-7d73f6f114fe@linaro.org>
Jabber-ID: linkmauve@linkmauve.fr


--vIGEYjDZeTRTEtgU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Mar 21, 2024 at 09:15:38AM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> > The TRM (version 1.0 page 385) lists five VEPU121 cores, but only four
> > interrupts are listed (on page 24), so I’ve only enabled four of them
> > for now.
> > 
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 80 +++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > index 2a23b4dc36e4..fe77b56ac9a0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -2488,6 +2488,86 @@ gpio4: gpio@fec50000 {
> >  		};
> >  	};
> >  
> > +	jpeg_enc0: video-codec@fdba0000 {
> > +		compatible = "rockchip,rk3588-vepu121";
> > +		reg = <0x0 0xfdba0000 0x0 0x800>;
> > +		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		clocks = <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
> > +		clock-names = "aclk", "hclk";
> > +		iommus = <&jpeg_enc0_mmu>;
> > +		power-domains = <&power RK3588_PD_VDPU>;
> > +	};
> > +
> > +	jpeg_enc0_mmu: iommu@fdba0800 {
> > +		compatible = "rockchip,rk3588-iommu";
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).

Even on master I get an exception about this unresolvable file:
referencing.exceptions.Unresolvable: cache-controller.yaml#

Yet it seems to be present in only three files, all of them unrelated to
the rockchip board I’m interested in (it seems), so I’m not sure what to
do about that.

The full stack trace is attached.

> 
> Best regards,
> Krzysztof
> 

-- 
Link Mauve

--vIGEYjDZeTRTEtgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="CHECK_DTBS=y W=1"

% make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CHECK_DTBS=y W=1 rockchip/rk3588-rock-5b.dtb
make[1]: Entering directory '/home/linkmauve/dev/linux'
  DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb
Traceback (most recent call last):
  File "/usr/lib/python3.11/site-packages/referencing/_core.py", line 417, in get_or_retrieve
    resource = registry._retrieve(uri)
               ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 111, in _warn_for_remote_retrieve
    request = Request(uri, headers=headers)  # noqa: S310
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 322, in __init__
    self.full_url = url
    ^^^^^^^^^^^^^
  File "/usr/lib/python3.11/urllib/request.py", line 348, in full_url
    self._parse()
  File "/usr/lib/python3.11/urllib/request.py", line 377, in _parse
    raise ValueError("unknown url type: %r" % self.full_url)
ValueError: unknown url type: 'cache-controller.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/lib/python3.11/site-packages/referencing/_core.py", line 667, in lookup
    retrieved = self._registry.get_or_retrieve(uri)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/referencing/_core.py", line 424, in get_or_retrieve
    raise exceptions.Unretrievable(ref=uri) from error
referencing.exceptions.Unretrievable: 'cache-controller.yaml'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 144, in main
    sg.check_dtb(filename)
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 89, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 77, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
  File "/usr/lib/python3.11/site-packages/dtschema/dtb_validate.py", line 33, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file):
  File "/usr/lib/python3.11/site-packages/dtschema/validator.py", line 413, in iter_errors
    for error in self.DtValidator(sch,
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 371, in iter_errors
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_keywords.py", line 386, in if_
    yield from validator.descend(instance, then, schema_path="then")
  File "/usr/lib/python3.11/site-packages/jsonschema/validators.py", line 419, in descend
    for error in errors:
  File "/usr/lib/python3.11/site-packages/jsonschema/_legacy_keywords.py", line 423, in unevaluatedProperties_draft2019
    evaluated_keys = find_evaluated_property_keys_by_schema(
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/_legacy_keywords.py", line 399, in find_evaluated_property_keys_by_schema
    evaluated_keys += find_evaluated_property_keys_by_schema(
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/jsonschema/_legacy_keywords.py", line 342, in find_evaluated_property_keys_by_schema
    resolved = validator._resolver.lookup(ref)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/site-packages/referencing/_core.py", line 671, in lookup
    raise exceptions.Unresolvable(ref=ref) from error
referencing.exceptions.Unresolvable: cache-controller.yaml#
make[1]: Leaving directory '/home/linkmauve/dev/linux'

--vIGEYjDZeTRTEtgU--

