Return-Path: <linux-kernel+bounces-155826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422DC8AF7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9366BB27CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B51422B7;
	Tue, 23 Apr 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="aoKEJdyi"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7413D510;
	Tue, 23 Apr 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902030; cv=none; b=MaruLUpTvxIyEntN5D0UPuXgF53nDZkWFSeV98p5nBYUYeIwI4W+qTwdbRBuSBB2JdZxw4Rdpeop8VpvD3CpyIeE7QQzDMUSBGQIg6lajvIiKFPS7rSpA86/HmatbrF+9iwPdizkRuSiYTQ4LPbT951vk4y54k4bCToiWKbpC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902030; c=relaxed/simple;
	bh=qfwhjJMFKdQZeALDm5qJB5ehGn+6Ra+DsPPuaufJ2fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTbQ5FI5g5ZMSez18KwitrqxinSU2OL9P0J923NbJfHrHAWKmDbIOwTapNzoFVjgARupkTs49XHmAibE8SNlViZdRFDXmLDfX+QdqsurG5UZNmDsr0P6xWghwOx/ooIbBkPaq8mWwlgz/DC0tSZl0QwFUwmYYsu3qRtSJ9Jd7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=aoKEJdyi; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713902001; x=1714506801; i=wahrenst@gmx.net;
	bh=qfwhjJMFKdQZeALDm5qJB5ehGn+6Ra+DsPPuaufJ2fs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aoKEJdyiVcdK4Hga9n1bxyxEhYvRtKXqesQowwm3/crdbvHaTfqOVIsjAaF15FuO
	 7IvKmA07ax7PXUt8eKyNYAt8rRG4ZyLvrFVFmGpqakIZhqa9gfyHSQQK7prSw6hyW
	 pMPCp4Eez2mtQrGu0TS/FtH9JwjDcYky7n/nHYe/CW1bUC76X0y+WjKzgTYUTSvWC
	 dKmeZG4sBkJjefbPJ+mCw4BEl4s5OBTyDt0pZHpMR9+nAlf1JRUn6hU7auqVUAPE2
	 5hvRm5Iy8klz6mvukCOgxVlgIoAQz+TQc0OtWqsJ9sVzRcJ7UBzAhkOHJtcEpuDmi
	 /So3ocFFD/SztKyTpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1siQ8Q2xjX-0114b6; Tue, 23
 Apr 2024 21:53:21 +0200
Message-ID: <709b1988-40e5-4f2b-a4a9-045e744708e2@gmx.net>
Date: Tue, 23 Apr 2024 21:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm: dts: bcm2711: Describe Ethernet LEDs
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Andre Przywara <andre.przywara@arm.com>, Nick Hawkins
 <nick.hawkins@hpe.com>, Michal Simek <michal.simek@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Paul Barker <paul.barker@sancloud.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240423191500.1443636-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240423191500.1443636-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zkadWaOzduyBYGPWrts7cz3buqCll6KflBcBIOMFoMSCKO6NKoG
 luBq23T/wMZNEOIyYvQKIbGowbLnyRUiDC993IKWfvlcV9aX5vbjDlQlAj9KzWn0Yh5eBM8
 LKfqCoOaGuaprgsW5shZbPUksIRVOO7j4MUxMAwcJ0p83nbet4tGfuCWHbCskrqKT7lPnS1
 GawEI6nutmr0SUryQM0dQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+/x7emDlsRw=;6tyhClKk7HNZgPhgWSQarCu0aV8
 HyArJw+pFbdAePSIeveLHT8KOUiTVOULbCPR6AaZNxrvUW89+A4R3JXdHzNvrCyg+VxV2R0KL
 r8AyERhG/2xTxxlEN/5fxF1y3eUPNN8n87TvtnfN4/cr6+ZcJGMmbXus+YbGMP/6H6V0kLGEW
 SbK6klPg2XTBSNVUc6fvTPhlg08Hc44lzKjHlsJ+2awwkfpG4nRg9nyl+tilEAWJoFJTf62g3
 GbNbi4jQlaaZV8PBPk5II+GenHjnklDD08aOs9xGqv2KFigzD3GImRPHZ/ta4RWq42PxEHeA8
 /Gxtlj5p833nO2SPFEhkSgTO9WxN4HDFVHQQV43/RLmZxB6QLITil49KuURLpxykIhu2pdDFe
 Ok2UktwLYT2rVbzw1cum91bbbK5DCj/Y6uu+xcE9rG+bFiyO3/I5UGZhkctmEzY08uxPcBveJ
 29zEYhGBDY5PPAjhdX3DS5jvTW+om3qTMmp7jycUpLMzWmoNGL78kPizqGz9jx9hH4bpeuGwo
 /seXIAYDoD+xRbo87vxDEgFZ5pt3sbUUeNHcAI8d8XWYSHH6vkmQkvRRZxY9O1gLC8iAzK8vx
 yY+QQcMHGNs7gTsEzFV502UTMQvvUVOefyLnSMXJcni8F0kMVaLz61P2bEH+FgRMGVepoJ+IR
 RHuW17XtFOtNHDACrG7efhv6ANrKwmBp+sAC93j8K6dQFcRRxjPBTzgZZEjttPJucHpKDafBT
 tTrr/UxxLTdQhad5paTskXDFPWAH9TRiDvBvTC0hcpqJJ3fnHhU8XCTDj704B9vfqx1pujBIJ
 e5WqCf3/SVRWpdpLzFZk5r6eaBOGjzwUJqx209j9pP/44=

Am 23.04.24 um 21:14 schrieb Florian Fainelli:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board. The Raspberry Pi 400 board does not
> include RJ45 connector LEDs so the 'leds' node is deleted accordingly.
>
> The Ethernet PHY LEDs are numbered in the PHY package/pin list from LED1
> through LED4, however their address within the LED registers function
> selector is 0-indexed.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>


