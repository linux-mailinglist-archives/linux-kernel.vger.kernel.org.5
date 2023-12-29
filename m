Return-Path: <linux-kernel+bounces-13116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DA81FFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956E11C2185D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEB31172D;
	Fri, 29 Dec 2023 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tJgbxEeD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D9711711;
	Fri, 29 Dec 2023 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703858886; x=1704463686; i=wahrenst@gmx.net;
	bh=kDWH8Tx1ru2DGIhftcF+Di1qtXkh3Pa/f4fJ6S+NIS4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tJgbxEeDpdF01PhXxSxYxfQL9RLWJBG5f6JGeg62cKnDCrQgErUcnYO/cpSYue0c
	 KdCxiTKnGcQdv+37NIBDm6xd03E8DvKvMvphsUD2H2uRkTv8dQwz8gXjXU2k7/3f6
	 WVgqMIIuKzTACcBX27Rnkoeno1F+kjZxHEOeuZYCIcA0Jh2rOCEzl7BVcu+QANQQB
	 hz1cU3lYB/ztjm3Sw7oAAO5u+5qVKNFlTN3nj2tHTsUyBxdmMhReTVJfNZrcg34eX
	 M/UfESNgBHO9fVBGb0vCuozL9180FgJ6TMVptj2WscbQuGNmd84SQj7E1Ke/+/ziz
	 5/AGjPidtKzIM+vIhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1r6PFb3bQc-013cCT; Fri, 29
 Dec 2023 15:08:05 +0100
Message-ID: <4e3a0328-0ae7-40fa-b37d-16b661e28a1e@gmx.net>
Date: Fri, 29 Dec 2023 15:08:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231227170919.8771-1-othacehe@gnu.org>
 <20231227170919.8771-3-othacehe@gnu.org>
 <d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net> <87plypqi2d.fsf@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <87plypqi2d.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qu4gBhHxXa9H5O+2ubUz1y27MeYBfrBzfQyOQiLpHK3X77DhpqU
 yP26AgY9yHzki4VTjGP5Mq2XhOolxYt6eekLqkdJMPi8pfs8UFHS1A3PA2Hhn0dIZW/lhyW
 KPLJifj4JRTP7CsOJra1XpiKvrFQZQTiNoGdfNw6M4LlqIV/OImN5Nvcq9ZYIvBvRlUK6jY
 hxMHLeEbPbHbZb9rtLN9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x8uTtUQkO5c=;KnDIxyxuuGR1LdlLLLvoQqmJXLw
 NVvS8chYXspy1GWnsJ+gS97V3zof++jD8kVICb2N3bReHWCQQMLPhtkejngfk8PZzPbzD9Xpg
 7xvRE+Il9s3Estp+/jswEnj1ZIge+8DwRyPFwkQpJInuwX19t+n/qHpuPxtKX4c7t13oq2h3u
 ctO4Pbc6tXC71ritKeUV7uET857SlKsl3fqLOL86wZfsXH7CQJ/8r01MxxA/o5TXnC4Eqzvm9
 VRBNsvCCdlb5X89Nb5vebaePbSWEi1E4DXuyPeOZqT2uwXF882yu+oSJTGqREzePfoShFyGKN
 aZKAQsiZjH/5v8D7bec828Rxek3wbp+E3C85FSCpwTeyDU4U5ao/8xeJ+fUkHYmDbPr4UMCMa
 biDc6EiIJx2tELH6DWJR6z+FSwmxDLuBOBQtBqR4FkdHdvXnNJH66MS5YvTBpzPLZk9ocT6j/
 wGTWw67xghqnUcLnfYAnGgIHmGdzguDFnIU6Pm6Gv+D8iMM8ESIr66M44bdH4aFyvux0R+ndP
 4yKMmOXGR4ZnM6bsr0pF8CekZLff+o9He7MGzH27/C5rwebnDcvzvGC5Pnm4esGaJYTlquB1w
 r+VTLDKQbfiNoqkDgwrOub5WeQKQI+UIMgEav8TrYef7LQWS/a65r9oKkWMz97PJZpXryHxUp
 KNnuCqi7qv0Y7dcMJU/A3/AeIgSDlXs5xXnuQTMsqwj61qw7LG3YUSsoyHhjzrmTa8eLw7X0f
 8w3imXDGzAkdZ8P7ns/8fo82TmjpQ/E2h7zPIJquIH3fhBPBVeheiI3YxU/vryFmjV9OTC9O6
 qPCrFyfE9SSt6TwVKnOnQSxvBn7XW3MktZgsd53fv9kdLCY5d6ywHScHaTzmt2FRa1q0mEKzt
 obKSZKd3GnuWp5eCt8EDwTy5/c1cOmY1+GtqU1UuY0c0dTkV3Ru7eq6jNOPebuk8pm2tjkvkD
 jNSeEhUFDryl65dPIMRsZSITAx+wGr2kzcXs40Q7bJtrSUuz

Hi Mathieu,

Am 29.12.23 um 14:00 schrieb Mathieu Othacehe:
> Hello Stefan,
>
>> there are neither gpio-line-names defined for this GPIO expander nor th=
e
>> SOC. Are there no GPIOs which can be accessed from userspace?
> The carrier board schematic is here:
> https://www.variscite.com/wp-content/uploads/2023/01/symphony-board_VAR-=
SOM-MX93.pdf
Thanks this helps.
>
> All the pin headers are mapped to specific functions. On the other,
> already mainlined device-trees, that are based on the same "Symphony"
> carrier board, there are however gpio-keys for three buttons:
>
>
> 	gpio-keys {
> 		compatible =3D "gpio-keys";
>
> 		key-back {
> 			label =3D "Back";
> 			gpios =3D <&pca9534 1 GPIO_ACTIVE_LOW>;
> 			linux,code =3D <KEY_BACK>;
> 		};
>
> 		key-home {
> 			label =3D "Home";
> 			gpios =3D <&pca9534 2 GPIO_ACTIVE_LOW>;
> 			linux,code =3D <KEY_HOME>;
> 		};
>
> 		key-menu {
> 			label =3D "Menu";
> 			gpios =3D <&pca9534 3 GPIO_ACTIVE_LOW>;
> 			linux,code =3D <KEY_MENU>;
> 		};
> 	};
>
> I can add that in v5.
yes please.

I also saw in the other Symphony DTS a LED for heartbeat. Is it usable, to=
o?

According to the datasheet the SOM expose 7 UARTs, but only the debug
UART is enable. What is the reason for this?

Btw the commit log mentions a Wifi (via SDIO?) and audio interface. This
is currently not supported by Linux?

Thanks
>
> Thanks,
>
> Mathieu


