Return-Path: <linux-kernel+bounces-1735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F48815359
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903361C222B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966618EC2;
	Fri, 15 Dec 2023 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="hXhOymDR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E18EC1;
	Fri, 15 Dec 2023 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702678425; x=1703283225; i=linosanfilippo@gmx.de;
	bh=C06XXkJK7IZiZ0MT6MWFhD5Flfb1WACPBxOdMeCa4xw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=hXhOymDR1W83ZjnKPjT5KlB+DYtmkxBITeBaeFrNw3mHr6qzH3Khl0+cqN8CKApY
	 eICFT/Hfydvt+M1uJ3vEi7gBLY71ttn2QuglHIIjmcF6hX431d5a342M+79Sb1TF5
	 CuiFiLq1jyobFh6a3pbM4oNPn13q9DUYGo2lxLfVfuAGNnI44den2Ixyk5UmNy/Fe
	 Z3wRSvfdYM5xj6LNZPP9aE1SQDqZfXzOXU+pkj1JLQrspU/1dhhzOo4/86E1iLb+t
	 2vr24ANbuDwTkJ6tVh6mU3PVCeF29Rfr8MZ2cDbLmtIcLcjS43ldAwUehhaIdKTRB
	 jzmmtOPj+D92jfuG/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.1.150]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oBr-1rQRZ60MAH-00wlzn; Fri, 15
 Dec 2023 23:13:45 +0100
Message-ID: <1b0af20c-8a2c-46ba-ab2e-d598b65fd0c1@gmx.de>
Date: Fri, 15 Dec 2023 23:13:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "brenda.streiff@ni.com" <brenda.streiff@ni.com>,
 Tomas Paukrt <tomaspaukrt@email.cz>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
 <ed087928-43ac-42bc-8e4d-d1632db451b9@gmx.de>
 <cc59c5bb16574073ba8b2bf9bc59bc7c@dh-electronics.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <cc59c5bb16574073ba8b2bf9bc59bc7c@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DPmv0J/k0HzTMbwTgxlSJfkOv4Ktn/RCfR7VD9yMFQAhDj2mM7o
 uxQHhjhrdmjTZh75hXxE0RbAq9ucl7RIgehxEi6jO72FJUTlYyA/nHRfX3gshPGfjFdE0zl
 RdO9rHODzl6delVvUFGVCVwZtTAygSdqXQCv4OnDp3K2RVrH5MfscljgRxE3StmFRzStyNZ
 qtsuUKm0S1QJ2VQS7lhJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oiUTxF7LW/I=;01gP3CrURX/RACgl6u/hm4kcUjB
 hahsEkwwPDj+bL+6RFpCqdSOUCMivMkVRTBxjBXCIpVDk1YnsY+Qjxcy//vsoC+Fuyuqjyg+v
 qys9FiGDbQ89zVmGl1KNGvYJPEvh5RZg5vYP0H7Nsey1UEc1HlBBYjoS05d3ZdIc52hyElBcV
 F5mFo2FWQrG46ObwtdsfjyLUIlrwH7TezyA571sUx9KGzIezsqUaA9YYjynVF1GyEI3YINU7b
 AC6J9RN2XGw4VKmwucifG5nRw5f0UUrLD1hjxx4HSY+CsEhu2VNKzhM54ibNLHdLlGrrPhdKE
 MRxNxhw2RbHzm+/AT6w6PpoqqMu7qXXdzbyCVm+R5SsrU8jQGtff3+YWXEPin8wk6oP3OlmcE
 J4QesO1qu3rXpFfJrSiOLrQ5bCLwDFNdHQgpmCdJUQLHUCqolHoLVM1QdfJ0DABd6htQAu3cW
 zhOxhcoPwIPTNIjmz/6xeAyN2z3l+m6DwalMwJOgPB+CBuToATIWQnX27UzTFssebTyZUjxx2
 16GkjF0VJoJd3xds1LamQOO2IsMBZbUzNNnSP+TG9p+WornZE4JROYNx5MmcnCZPfr9+TDV+U
 irRGE0Fhnq7Wh0HzB/qBsTopr0QuD2TGrr4HMoLF5XLsciKf6HGfi0XOSo9nocpLhWPo99wwA
 E/OpdfmVOv9lbVZXHCW6oqQuzJZEZGR/4YKDK+ey1m0pDCVwxEkc1bI8bp1y4mGHv/nAupOMJ
 qx0Lh7VhUH6cdjXVj/v9+MBwCj4eiVJvX9OoNbNciq8YitBz9C2bIPVgAh8vCmzRAxPIKmGIu
 nol3VT+rJrVGUJww/OC5nUxPZc14pR1ptI/0c/C8JXWSKHPv8LzElce8R/ZsivwvNbiQEQCty
 5lcomLZeIUOkfD1ESG549A9alZgv7lPHXJN0Qx86feWx88VXOIELXqVyGCE7HmWivFT4tTq0y
 ji57uA==

Hi Christoph,

On 14.12.23 15:50, Christoph Niedermaier wrote:

>
> I think we don't need to distinguish, because for a full duplex RS-485
> transceiver also needs RTS control. For example look at the full duplex
> RS-485 transceiver ADM3491E [1]. It's a full duplex transceiver (A/B and=
 Z/Y)
> that has DE (Driver enable) and DI (Driver Input) pins for controlling T=
X. I
> think the RS-485 master doesn't need it. The DE pin could also be set
> permanently high. But if we have more than one RS-485 slaves it's needed=
 to
> avoid blocking of each other on the receiving wires of the RS-485 master=
.
>

Thanks for the explanation. So while still needed for the slaves, in case =
of the
RS485 master the RTS control is not needed, right? Is this something that =
userspace
should be able to configure? It could be set by clearing both the RTS_ON_S=
END and
RTS_AFTER_SEND flag (only if the driver supports this special RS485 mode, =
of course).

Regards,
Lino



