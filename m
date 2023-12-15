Return-Path: <linux-kernel+bounces-452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9573181414D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F149284445
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9C6AD9;
	Fri, 15 Dec 2023 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="o3fE8TcR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7F63A6;
	Fri, 15 Dec 2023 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id EF824403BF;
	Fri, 15 Dec 2023 10:29:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1702618164; bh=wJhGZlFfjScpdy3VQmLDEEdsC0w0gtsbyZa72g/IvsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3fE8TcRvkhGpHFeYdMIue4Mt4Kudw+bq2DbbqgM7ZhrtJqW+H7RIx4T0uuhp+X53
	 NAEbsqOJ6AGxLt7Rk+zbNR18lceA04szHgpiSXNGo3qpkjtacX1Z5qoKQ3FgMGAmFK
	 ZbMOWI9CiVYcEKla9G9w6WDc5kgaBR89pQfbderarbz9C1Cn9hsvhXTf9I/JZw/wLy
	 +sVXB+w1ZHDcF4W4Ck3cPm3AVlquMGrzczT+ELzy9wR+pn/vLFqVyXTgPunOQOLFsJ
	 QwQPJO8T+cPDeoTWieDsysBljdx1OCBep3ZvzIlvFQ+WIhMHWmVyL0AuzumCvtCtBT
	 4QvoIXfXN4iQA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 15 Dec 2023 10:29:22 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: Add Acer Aspire 1 EC
In-Reply-To: <20231214220210.GA988134-robh@kernel.org>
References: <20231212-aspire1-ec-v2-0-ca495ea0a7ac@trvn.ru>
 <20231212-aspire1-ec-v2-1-ca495ea0a7ac@trvn.ru>
 <20231214220210.GA988134-robh@kernel.org>
Message-ID: <207edefe4e8eac9679cd8966d28820cd@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rob Herring писал(а) 15.12.2023 03:02:
> On Tue, Dec 12, 2023 at 05:49:09PM +0500, Nikita Travkin wrote:
>> Add binding for the EC found in the Acer Aspire 1 laptop.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  .../bindings/power/supply/acer,aspire1-ec.yaml     | 67 ++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
>> new file mode 100644
>> index 000000000000..1fbf1272a00f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/acer,aspire1-ec.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/acer,aspire1-ec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Acer Aspire 1 Embedded Controller
>> +
>> +maintainers:
>> +  - Nikita Travkin <nikita@trvn.ru>
>> +
>> +description:
>> +  The Acer Aspire 1 laptop uses an embedded controller to control battery
>> +  and charging as well as to provide a set of misc features such as the
>> +  laptop lid status and HPD events for the USB Type-C DP alt mode.
>> +
>> +properties:
>> +  compatible:
>> +    const: acer,aspire1-ec
>> +
>> +  reg:
>> +    const: 0x76
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  acer,media-keys-on-top:
>> +    description: Configure the keyboard layout to use media features of
>> +      the fn row when the fn key is not pressed. The firmware may choose
>> +      to add this property when user selects the fn mode in the firmware
>> +      setup utility.
>> +    type: boolean
> 
> Besides the naming, this isn't really a property of the EC, but really 
> part of the keyboard layout. It seems you just stuck it here because 
> this is part of the specific device.
> 

The EC on this device is also a keyboard controller, but the keyboard
part has a dedicated i2c bus with hid-over-i2c. Since this is the
"management" bus of the same device, I decided that it fits here.

> It is also hardly a feature unique to this device. I'm typing this from 
> a device with the exact same thing (M1 Macbook Pro). Actually, all 3 
> laptops I have in front of me have the same thing. The other 2 have 
> a Fnlock (Fn+ESC) though.  On the M1, it's just a module param which I 
> set as persistent. Though I now wonder if the Fnlock could be 
> implemented on it too. Being able to switch whenever I want would be 
> nice. That would probably have to be in Linux where as these other 
> laptops probably implement this in their EC/firmware?
> 
> What I'm getting at is controlling changing this in firmware is not a 
> great experience and this should all be common.
> 

You may be right, however my goal here is to support the original
firmware feature that is lost when we use DT.

This is a WoA laptop with UEFI/ACPI and, as usual for "Windows"
machines, there is a setting in the firmware setup utility ("bios") to
set the fn behavior. But it works by setting an ACPI value, and for
Snapdragon devices we can't use that now.

Long term I want to have a EFI driver that would automatically
detect/load DT and my plan is to handle things like this (and i.e. mac
address, different touchpad vendor, etc) there. Thus I'm adding this
property already, as an equivalent of that weird acpi bit that original
firmware sets.

If we only provide a module param, the "intended by OEM" way of setting
the fn mode will be broken, and one would need to know how to write a
magic special config file to set a kernel module param. I think it's not
the best UX. (and just adds to the silly "arm/dt bad, x86/uefi/acpi
"just works"" argument many people sadly have)

If you think I shouldn't use DT to pass this info, feel free to say so.
I will drop this property and see if there is something else I can do
to still support this without relying on Linux cooperation.

Looking forward to your opinion,
Nikita

> Rob

