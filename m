Return-Path: <linux-kernel+bounces-10423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984681D43E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088E01F21944
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF327D520;
	Sat, 23 Dec 2023 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="ObBGU/k0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB910D2F8;
	Sat, 23 Dec 2023 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703338861; x=1703943661; i=linosanfilippo@gmx.de;
	bh=Nx79P5r9ZG4XWH364YUty3qUZDD0HnQKSxhIi0fdzVw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ObBGU/k0yLfyAmsvhGxGA6b6Z6FZad/JaBqfmGqD7e9cMCG3T3havj6uOd2KGhBa
	 9FsFtcdjG19AuqBzK9Bhu45DTjcsF2jHvbYjcd5HyfkMDVQqPEKvSQeKRhOmuaDHX
	 B9izGzWPCnSZ8tcux+fJttbOSsklHkogyiz2QZCeV1oEDjh2Dd6AbzYcMqYa/SeRn
	 VhUtBDbbGSXoLJzTMntVFzNzOrkhUB4vDOPHadJd90BpCsbEIfFshuMSBRimDWE2g
	 USo9rMSaZW5MwP+1xCZ1PVvVRmsAP9fH8TxYaGW8FdSlw55zU6fxERMfgJxrmohWt
	 GR5IC43bHcsbGDOfCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.31.30]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Daq-1rNf1Q34XY-006dXe; Sat, 23
 Dec 2023 14:41:00 +0100
Message-ID: <0ec4c423-3d18-4a29-b78e-938366ece117@gmx.de>
Date: Sat, 23 Dec 2023 14:40:58 +0100
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
 Lukas Wunner <lukas@wunner.de>
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
 <20231221155305.GA13673@wunner.de>
 <f41f5ddcb52140b6a579043a5abce751@dh-electronics.com>
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <f41f5ddcb52140b6a579043a5abce751@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pDuxbI2WkztYdDHTvdtbHa9gMg0Ipu6a+RUE+KnN0eUnEFwvrZz
 tmCBZhBatoxG2hFNFv63J2fl9h1CGuqKcr5Fz4EpVV3f5JAeGjod4y+A6QPXiOTvpSYbI8H
 jsJkSEIEIaSoPy8rrkpuIuWfVH+vQCMZ82jVhWCwlYs5nNW1/byjjSKoUOEv+YfvXR1/WOM
 907n0Fv35z6j0Xj4f6OUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CQfeTTCeB3M=;7DSS5miEAD5mnX//uy0ojZCR59n
 zZ5cq5Zy2SEPcDK8m7g8nSs8nC/6sfz/YAd4WKPORlryUE+mgIkaW/3vpmz+n4Jh72WAdHA6s
 ge/D0R4QTt30vEQ4hjt2yULSMdZAul4Z4T8LOgBV5Cdvlfz1zQ8uY5LSWjFF4jMIcaTh5UCvt
 7RXhGm2VaWYYCyWwGOJmV32H2O+bSKMk7aAi/+Qc+hfu6utbRxUUeeIhrdsRIflbWZJw6baQu
 uyttVQbgtOCMrOYeeAktPrssiKADZBkErmBXQzMHenbpuqMfUnENV6FpNDgqdPcMVOwWEap6k
 AP/0CHnpJ3clcpuR7e3Sia4qq46FbnE8IfDc0O4t5nNyWNOfp14fXjDhXvdLVJC3/aRU8ARwe
 8zoKFMq8WfsoZfSDbGVlie1SanabLVgPlGjdjVO9xFW/naVbA6JBWlBJ/8fKZ32VP3/BsTSJH
 E5er+RcEwVP66PHgJRClJrB4rMbp4WDRRq7MEiW8QROLBR4l+giU5VWL0Zse/n2Mb9qGhOBwO
 bVi3HNU5JAcoW660SXneTSjTIK88IV4GR5Z0CEkpW+pqeHQyVaPemFyrtgMX7Xq9Mc5Mn9zQD
 083j2edxz135yvf+Alsgr8V03rHCDtSpmdgRBsQLs2hSVIvi9/uREN2KzaTYPlr7n7sJevGIo
 dfXAL1BrQUG4WqokO3KgoUkw5xp6bEClhCI5RKP/FeCJp7shRx3rMX6ADMFFSox1MPBX+bHKd
 rHX17jDwvmtmmSPZnkFQjEeJuirq95sz/4YE8gtSKAYEm1uJe61lw0f1w3OV7LNEC9sPRY6TM
 pl2Ojufbo45lcndQ0SC6rpnOxuvmMYB2my/S6a3DIfjRVnRR+wGipIpNfG/dEtSrnlW1LnSSm
 z6BRaVfdUY6fwpZlOTWANGmV9bR3/1aKs17sTjySd4OB2YpRxaVGAscxtihmxW2XmspGNwtEp
 ejNZNg==



On 23.12.23 13:49, Christoph Niedermaier wrote:
> From: Lukas Wunner [mailto:lukas@wunner.de]
> Sent: Thursday, December 21, 2023 4:53 PM
>>
>> On Thu, Dec 14, 2023 at 01:41:47PM +0000, Christoph Niedermaier wrote:
>>> I will summarize the current situation from my point of view, maybe it=
 helps:
>>>
>>> RS-232:
>>>   - Full Duplex Point-to-Point connection
>>>   - No transceiver control with RTS
>>>   - No termination
>>>   - No extra struct in use
>>>
>>> RS-422:
>>>   - Full Duplex Point-to-Point connection
>>>   - No transceiver control with RTS needed
>>>   - Termination possible
>>>   - Extra struct serial_rs485 needed if termination is used
>>>  =3D> RS-422 can be used in RS-232 operation, but if a termination sho=
uld be
>>>     switchable the RS485 flag has to be enabled. But then also transce=
iver
>>>     control will be enabled. Not a very satisfying situation.
>>
>> Well why don't we just allow enabling or disabling RS-485 termination
>> independently from the SER_RS485_ENABLED bit in struct serial_rs485?
>>
>> Just let the user issue a TIOCSRS485 ioctl to toggle termination even
>> if in RS-232 mode and use that mode for RS-422.
>>
>> Looks like the simplest solution to me.
>
> Sounds not bad. The termination should only depend on whether the GPIO i=
s
> given or not.
>
> Irrespective of this, I think the Linos idea of an RS-422 mode is not ba=
d.
> This allows you to take care of special features that were previously
> overlooked. For example, hardware flow control can be switched off so th=
at
> this does not cause any problems.
>

Also note, that RS232 and RS422 may NOT always be the same from driver per=
spective.
Take a look at 8250_excar.c for example. That driver has to configure the =
hardware
accordingly when switching from RS232 to RS422 (see iot2040_rs485_config()=
).

While a SER_RS485_MODE_RS422 flag set by userspace could work to switch to=
 RS422, I
still think that the cleanest solution would be another ioctl TIOCSRS422 w=
ith a
parameter like

struct serial_rs422 {
       __u32   flags;
#define SER_RS422_ENABLED              (1 << 0)
#define SER_RS422_TERMINATE_BUS        (1 << 1)
	__u32 	padding[7]
};

The SER_RS485_MODE_RS422 flag could still be used internally as a hint to =
the driver.
That solution would also be expandable if needed. I planned to send a patc=
h that implements this
as a RFC to the mailing list (maybe in the next few days).

Regards,
Lino



