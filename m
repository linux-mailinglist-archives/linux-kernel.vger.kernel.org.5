Return-Path: <linux-kernel+bounces-86238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A4486C295
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285B91C22F92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88434779E;
	Thu, 29 Feb 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VBmtnGys"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E844C8C;
	Thu, 29 Feb 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191923; cv=none; b=r8TfFrcvEYtlIm9zV5NhUm/kbsCrkVLyt3kVCbK/cNcwSVK3YrbJ3OE3SwcI2WMGwvHJTZuVRL3C11R+yFC/1B86+tCs6kXy0vHz2WmcZH3tJ63sq923FT8ukK1GZF8Mey44atyvyNogDdqF4TXSa/lkjzx5F72D1o0iiawuZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191923; c=relaxed/simple;
	bh=EHPwMRslysMH/6pBpniolRdwostS5lFMS+gutCk9a6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoznthfpiGt/8R3zZayGnNuspEk93gZOki+ubPl4mJYgplMs/2IV3mzSPcjt0UEql5kIyGPL+iV1lHDDfX0QtYwPJOM+yziTq9a1cmOF9NfYllnQG5ebQo2UZkq5CKJ/lZFa5x6Vpe9sSleFrn4lcRcMqp4oKVxJhV2iKnlcRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VBmtnGys; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19AC5E0002;
	Thu, 29 Feb 2024 07:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709191918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zp3g25JeuYR2V66Ei5s5q+BW/ugjiuni4LeJDlsxyMQ=;
	b=VBmtnGyszrpBELAenQD0+WWuLUQQIyvFJ2vrZ6e6QFxRbvA3fQKzuL1A06oTATq+i3m0B1
	inCMvJTCp1osw/oOxYQAHwqRfCoakwhl3RFwU2Ajk+lfr426gwgdddW09hfH1QvyGgUvJY
	PUQXhcgSlhv4vb1rxiG2c91hV7yU89QMezJXnNPaQfd1cAvCFuXiXVHINi+XvlNhgeKlQe
	VpuqeWZCE0hZQzXS+wvPXS3LXy3f2ii2n87bHpZ5zD/y0Wnz+7q3TLQYeBDADBxDvWPCOV
	cKxY2jLeD7YSd53+9nAZUld+Gcrh/8CJXjkixiV/tvKito3FsEJuv7rNbC2pDA==
Message-ID: <c1b17410-b403-4c3a-9c00-de8f2b2b2fa7@bootlin.com>
Date: Thu, 29 Feb 2024 08:31:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-leds@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-7-bastien.curutchet@bootlin.com>
 <a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Andrew,

On 2/27/24 17:18, Andrew Lunn wrote:
> On Tue, Feb 27, 2024 at 10:39:45AM +0100, Bastien Curutchet wrote:
>> The PHY is able to use copper or fiber. The fiber mode can be enabled or
>> disabled by hardware strap. If hardware strap is incorrect, PHY can't
>> establish link.
>>
>> Add a DT attribute 'ti,fiber-mode' that can be use to override the
>> hardware strap configuration. If the property is not present, hardware
>> strap configuration is left as is.
> How have you tested this? Do you have a RDK with it connected to an
> SFP cage?

I did not test fiber mode as my board uses copper.

My use case is that I need to explicitly disable the fiber mode because 
the strap hardware is
misconfigured and could possibly enable fiber mode from time to time.


Best regards,

Bastien


