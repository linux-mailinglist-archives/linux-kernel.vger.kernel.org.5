Return-Path: <linux-kernel+bounces-68900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF58581A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB6628A006
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC112F5AB;
	Fri, 16 Feb 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FB+uXG6s"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312F12A158;
	Fri, 16 Feb 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098286; cv=none; b=vDjIc+6Kb4yenvqgJNqr427r2/YzDDFgggVJ5RfHK9YkYSHOW7BRGg9w6bLbj6OX2HOWKxxZksRLeklogUb6178drF7SQol+V3bOsjEF2gmFvet2KYY298/5BVlHKtHUBmEnvtGsnpwFVv4SJmcgmvEYon5qQF7giwezBCKScws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098286; c=relaxed/simple;
	bh=e4ljz734j8K5IeryaDf+QcV32Hc7o/1BPmaP92RLzYE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mPXvw9zsrgeQKhCk+7xd67ER23bfD0bDOlQ3pXuZxvbcNO88RlrMlns6ZuynaPtibmHHwhlvKviXYc9j9t6ndkj1e75ofSnI18M4IpvvL4lVXzMrR6IzQJKSkbeLUUT03XmPFi0sd4om7PxtXmbNyufhZK88bjdrp5GKycbwOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FB+uXG6s; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AEE21C0006;
	Fri, 16 Feb 2024 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708098280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLOKIfLa2Fcau86133DO8zv6SnmDWIf1Ivv0kU6coAI=;
	b=FB+uXG6szCFB3RugpF1ZTfMUVw4QkzOfnYrqIos0AHclW+DR3KgszWL4UciL10wLj1nxoz
	4uX1jPwDE64+9mE27wgjguQO3O62vz6T2SRYu18qtN50FZ+zcyECCiWfbeqlVBijZASUgA
	1hdyH9Gj466bgdNxlnGbpi9ovUYBDWBeKC2TKY3J9Efm+CJ2Dog84RJ1CkVJL7afYYZstR
	0ku+SzWVa5RLCWS/qoabYg/cjdwwCQxDtMT3cHGGZci+tKp3L1N/QmMHzB8PJZK+D2bueE
	T6s3rf5+BTQZi8r+KICySJMzFoZuQmffr+TcWvOyHg/Q9mokoTP2ucoIDSRMjA==
Message-ID: <be23b24e-5de1-400d-84fa-cf5b25e72a19@bootlin.com>
Date: Fri, 16 Feb 2024 16:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
 <20240130085935.33722-2-bastien.curutchet@bootlin.com>
 <dc81a307-3541-47e2-9c72-d661e76889bf@lunn.ch>
Content-Language: en-US
In-Reply-To: <dc81a307-3541-47e2-9c72-d661e76889bf@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Andrew,


Thank you for your feedback.

On 1/30/24 14:34, Andrew Lunn wrote:
>> +  ti,led-config:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 3]
>> +    description: |
>> +      If present, configures the LED Mode (values defined in
>> +      dt-bindings/net/ti-dp83640.h).
>> +      LED configuration can also be strapped. If the strap pin is not set
>> +      correctly or not set at all then this can be used to configure it.
>> +       - 1     = Mode 1
>> +        LED_LINK = ON for Good Link, OFF for No Link
>> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
>> +        LED_ACT = ON for Activity, OFF for No Activity
>> +       - 2     = Mode 2
>> +        LED_LINK = ON for Good Link, BLINK for Activity
>> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
>> +        LED_ACT = ON for Collision, OFF for No Collision
>> +       - 3     = Mode 3
>> +        LED_LINK = ON for Good Link, BLINK for Activity
>> +        LED_SPEED = ON in 100 Mb/s, OFF in 10 Mb/s
>> +        LED_ACT = ON for Full Duplex, OFF for Half Duplex
>> +       - unset = Configured by straps
> Please look at have the Marvell PHY driver supports LEDs via
> /sys/class/leds. Now we have a generic way to supports LEDs, DT
> properties like this will not be accepted.
Ok I'll use /sys/class/leds
>> +
>> +  ti,phy-control-frames:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +    description: |
>> +      If present, enables or disables the PHY control frames.
>> +      PHY Control Frames support can also be strapped. If the strap pin is not
>> +      set correctly or not set at all then this can be used to configure it.
>> +       - 0     = PHY Control Frames disabled
>> +       - 1     = PHY Control Frames enabled
>> +       - unset = Configured by straps
> What is a control frame?
I'm not an expert on this but it seems that if the PHY's Serial Management
interface is not available, it is possible to build PCF (PHY Control Frame)
packets that will be passed to PHY through the MAC Transmit Data 
interface. The
PHY is then able to intercept and interpret these packets. Enabling it 
increases
the MII Transmit packet latency.
You'll find details in §5.4.6 of datasheet 
[https://www.ti.com/lit/gpn/dp83640]
>> +
>> +  ti,energy-detect-en:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description: |
>> +      If present, Energy Detect Mode is enabled. If not present, Energy Detect
>> +      Mode is disabled. This feature can not be strapped.
> Please use the phy tunable ETHTOOL_PHY_EDPD. There are a few examples
> you can copy.

Ok I'll do that also, thank you.


Best regards,

Bastien


