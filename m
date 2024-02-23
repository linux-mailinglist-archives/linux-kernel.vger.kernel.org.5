Return-Path: <linux-kernel+bounces-77769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20964860A09
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E0A1F2329A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2C11716;
	Fri, 23 Feb 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7Nay0L/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2EB653;
	Fri, 23 Feb 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663950; cv=none; b=ZusYrZ0np9krfJ9ohjL5XR8sAIG506StdADWesDRHQMne2UunoRsGp3xOXXvZxR6kSNydSR15y9Y2kPbInqsOWg5+R/hxs85FXaPckFUZ5BzLm3KREKkDtd/R/1fu94BlhPWdthrMWPzvuyVHHom3maBT5EfW09RTt9nG7yvU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663950; c=relaxed/simple;
	bh=nVZFDFDaVv/qqXq+znUTcPJ+GfF1Pq4SIsLHaObRCUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuwRp/DxlEYtqg37HSJsfO/H+xqpujUhwusaoiUFndGqygIZCt8RwittpYTF3Tho862zSuiZDoSNbOAT2T3dzQZDrmSE4tkKDgxRNH2IMrFMzHrXAyYM5tQ6yS1iPzXNEEJH402Jq8LnwUp/Bc+D4TXh9c0IAqLr5XPmo+wb6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7Nay0L/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91221C433F1;
	Fri, 23 Feb 2024 04:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708663949;
	bh=nVZFDFDaVv/qqXq+znUTcPJ+GfF1Pq4SIsLHaObRCUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7Nay0L//08naRYKIoJDTIBZ/JuHkL7iir/uq2GkrBmiSOYg3KXavnNMlluJWNA3H
	 U8ifD8oU6n9ragExcYyUUhx9d2p75NyAnYMnCGHeTb5gtgd7Os9/gmseipnlrczAem
	 kSC+NrQXgNFCmykOEkZ9NlsNh0KHJ7a6ii7gBe16phCY2qwJAtxXKX30a5k9OwnaHB
	 enHnzC7aDV19Cq9XNlJ/G4pQ/MHQc3hE98vJ2EDCm9IFp09/nHIYchxcJhnsBFdrAx
	 ekr/xcue17JCzsRFxDsHyec8RTFRESfjW1hnPIp91pTarp+0nN8zjpLKWoBi2oV4dc
	 AF31UYi1QWIBA==
Date: Thu, 22 Feb 2024 21:52:27 -0700
From: Rob Herring <robh@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
Message-ID: <20240223045227.GA4017491-robh@kernel.org>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
 <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
 <20231214220210.GA988134-robh@kernel.org>
 <207edefe4e8eac9679cd8966d28820cd@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <207edefe4e8eac9679cd8966d28820cd@trvn.ru>

On Fri, Dec 15, 2023 at 10:29:22AM +0500, Nikita Travkin wrote:
> Rob Herring писал(а) 15.12.2023 03:02:
> > On Tue, Dec 12, 2023 at 05:49:09PM +0500, Nikita Travkin wrote:
> >> Add binding for the EC found in the Acer Aspire 1 laptop.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> ---
> >>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 67 ++++++++++++++++++++++
> >>  1 file changed, 67 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> >> new file mode 100644
> >> index 000000000000..1fbf1272a00f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
> >> @@ -0,0 +1,67 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Acer Aspire 1 Embedded Controller
> >> +
> >> +maintainers:
> >> +  - Nikita Travkin <nikita@trvn.ru>
> >> +
> >> +description:
> >> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
> >> +  and charging as well as to provide a set of misc features such as the
> >> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: acer,aspire1-ec
> >> +
> >> +  reg:
> >> +    const: 0x76
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  acer,media-keys-on-top:
> >> +    description: Configure the keyboard layout to use media features of
> >> +      the fn row when the fn key is not pressed. The firmware may choose
> >> +      to add this property when user selects the fn mode in the firmware
> >> +      setup utility.
> >> +    type: boolean
> > 
> > Besides the naming, this isn't really a property of the EC, but really 
> > part of the keyboard layout. It seems you just stuck it here because 
> > this is part of the specific device.
> > 
> 
> The EC on this device is also a keyboard controller, but the keyboard
> part has a dedicated i2c bus with hid-over-i2c. Since this is the
> "management" bus of the same device, I decided that it fits here.

So there's also a hid-over-i2c DT node? Then why wouldn't you put this 
there?

> 
> > It is also hardly a feature unique to this device. I'm typing this from 
> > a device with the exact same thing (M1 Macbook Pro). Actually, all 3 
> > laptops I have in front of me have the same thing. The other 2 have 
> > a Fnlock (Fn+ESC) though.  On the M1, it's just a module param which I 
> > set as persistent. Though I now wonder if the Fnlock could be 
> > implemented on it too. Being able to switch whenever I want would be 
> > nice. That would probably have to be in Linux where as these other 
> > laptops probably implement this in their EC/firmware?
> > 
> > What I'm getting at is controlling changing this in firmware is not a 
> > great experience and this should all be common.
> > 
> 
> You may be right, however my goal here is to support the original
> firmware feature that is lost when we use DT.
> 
> This is a WoA laptop with UEFI/ACPI and, as usual for "Windows"
> machines, there is a setting in the firmware setup utility ("bios") to
> set the fn behavior. But it works by setting an ACPI value, and for
> Snapdragon devices we can't use that now.
> 
> Long term I want to have a EFI driver that would automatically
> detect/load DT and my plan is to handle things like this (and i.e. mac
> address, different touchpad vendor, etc) there. Thus I'm adding this
> property already, as an equivalent of that weird acpi bit that original
> firmware sets.
> 
> If we only provide a module param, the "intended by OEM" way of setting
> the fn mode will be broken, and one would need to know how to write a
> magic special config file to set a kernel module param. I think it's not
> the best UX. (and just adds to the silly "arm/dt bad, x86/uefi/acpi
> "just works"" argument many people sadly have)

But it always works, it is just a question of what is the default mode 
and I, as a user, want to decide that, not the OEM. And I want to change 
it at run-time, not reboot into BIOS to change it.

I wasn't suggesting you do a module param either. That's still specific 
to the module. Something like a sysfs file would be nice:

echo 1 >  /sys/class/input/input1/fnlock


> If you think I shouldn't use DT to pass this info, feel free to say so.
> I will drop this property and see if there is something else I can do
> to still support this without relying on Linux cooperation.

Not saying no to being in DT, but if it is, it should be a common 
property because it is a common thing on all laptops.

Rob

