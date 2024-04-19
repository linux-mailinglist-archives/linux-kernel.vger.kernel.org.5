Return-Path: <linux-kernel+bounces-151401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD808AAE50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E10B215D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEE84D35;
	Fri, 19 Apr 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="DJ1Tf+Wq"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30933839EB;
	Fri, 19 Apr 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713529059; cv=none; b=kyS1H5u0lTQYQTHU3JB7XV8UQTsQg1ezSPgkVoM60k1PpVcw2yHajoOAdyDvHyO8BIivt0/pHvStBygHAiuKDRBlkPgjyt4q9lIBsSpOXfSpHvDprjzJYztdUrPlT5ZKX2MOm83wveLGFHJiDi2qrp+dZt6RDQq6NIW4SXXT1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713529059; c=relaxed/simple;
	bh=HKU6lUFEObWAacDnO6tCiubDjoYhRfStCJJRtUuqz0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsw3N8mcB1BQTVXBvr/NeP1LxG0CQ42kQS4Ny2IoqEOMyV+tkS0xWBDUiC4F8vJ6Hd9BFpvDPzQkPmJX+PNySbH8exgJk/qVR5E/o6apBtAJTpfd2gPGQ9V93h9YticWo437bI8/R8WmhMNFdJXH1lT/HMX3PIQ+n1cZZscM1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=DJ1Tf+Wq; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1713529049; x=1714133849; i=parker@finest.io;
	bh=zjXiCeJOhApVkHhy6q6UaYGTLYoMq1CAu9WyY+sDNVA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DJ1Tf+WqQEEYXR+vSaPf3bLV1bPpoyPuyVksY8xkQjyCHoEdj51uhVyvg0ylONoj
	 P2WuR56/uToW0MQaxzxwnfVSg/tygn7eD2fZ6JfRCOx+JWXf3nMAblzh5bnTEw/Nm
	 ojgbBCs3heXJXCaFS/X/FrqiqIFFEkK7l+lvoFmNwzyzoT5G6IGRB87Ryrig6GzRi
	 bRPsMrQWDsVXrwEP/9v24VvxLhxw7JPWF0ioBf7LahKS7K7WSqoSUdyHi9g1VBIot
	 GIA5eteN1vlv6cShLt/tHdJNzDAsuhQWI7LYtHWQT0niu6pYxziUyXQ4NrclvGd/f
	 oQdUMIsaRYFs+xLeKA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Md62J-1sWr5G0piF-00aEhF; Fri, 19 Apr 2024 14:17:29 +0200
Date: Fri, 19 Apr 2024 08:17:27 -0400
From: Parker Newman <parker@finest.io>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Parker Newman
 <pnewman@connecttech.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 4/4] serial: exar: change port_type ternary line
 wrapping
Message-ID: <20240419081727.435437d0@SWDEV2.connecttech.local>
In-Reply-To: <379d43bd-d5eb-4877-8781-888c82821bb8@kernel.org>
References: <cover.1713452766.git.pnewman@connecttech.com>
	<0081b6a7bbe1ad6ce114132f9ee86677a761de6d.1713452766.git.pnewman@connecttech.com>
	<379d43bd-d5eb-4877-8781-888c82821bb8@kernel.org>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pwfBs002sJE5UlCclVc2gvJmpJV4N23LzQuZngqiPQGkyr43Hm9
 0w+6Ea25o/Pb91LwlQ6PZ9u7Fyu7bR+WLY/VXlfCUaLa//VDgWBA+dixLzI7u69H8euyARn
 s9+ZRMkPxY6weoKJ5HplNHKOOS3qpOiT1Scl+yCGcMyQV3elEm5gD0/7kDaW6qOxd+wpVwu
 MGlyxgJlIg4X2O7kcM9Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lvffdMyJ6rI=;3x/ki+/JYMfzigA6OjZQS5lxRx7
 t7CewaI8psr1Qtsj9JHgNXvVjT/Zxwl6z++Ga6+pzuXNIDNhhLbU8q3OnUljgclBliRFVz0iz
 BGqo//nSLxPQAJ1ZTzqaL3O+tqHn4myNDJOze+QjXifq2npjvo/f03Cpsh2ftaqj4n33EskKt
 Yj5uzWeCgXipUlQH72F280vvLi/QRFBGGpC7QaWxFOA9VxQZpg0DO00Gyr6nbDgihwdN/hwYd
 yngjPDNjahFNHYcKIqKg4Jk1OUPNHnW5Qd+bqzXHvz6Y7/gSdvfEEYMsCPNAiy3j4gugqW1s6
 Pd84Z8B1HI00A17boqdLxxWAcylQj8TqfOl1CwE8fIPCuimBq+hHLV09C+alw8BfpreSaNAx+
 nUjfu1acZk6qgRnrJjxiybweZhX0lZS/2zf2BCN0tzRXWBgQIonKRSk+Bzktw754AZKSkqxvh
 IeGfsGB8+9xuUn5dIQRkxohYd+H0F+INZQbCV9cGHoVEXNTH8+/DNdHgRruu6cdYlpW6NTwx5
 UBnDQhQm+7TsQn3Y3TJFk6bSkPeWeLMQCrR4hPSoL2RxGBBSGxOOKbfGEcvezM4TTLTcreRWn
 Yy9WMZC9HEnVnOmcI24JyTC1WxRoM0VboBBtv429mPWK8lsSpxHXYYSqlmKc7elZuw5JC/i4i
 vCtfGNqlusQEsMUvOEjRiFERgSpnhFE6Iqqni4EeZuVgMRr1fgAaWkK28zLxZeWqCAJ0jQ/f2
 V4UQg87BIxVc8THBiYP9K2nLhd3SVG5thMvyXTPIqv1cM8vPfHPlr4=

On Fri, 19 Apr 2024 08:07:50 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 18. 04. 24, 17:36, Parker Newman wrote:
> > From: Parker Newman <pnewman@connecttech.com>
> >
> > Change line wrapping of ternary operators in
> > cti_get_port_type_xr17c15x_xr17v25x() for better readability.
> >
> > Old example:
> >
> > 	port_type =3D port_num =3D=3D 0 ?
> > 			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> >
> > New:
> > 	port_type =3D port_num =3D=3D 0 ? CTI_PORT_TYPE_RS232 :
> > 				CTI_PORT_TYPE_RS422_485;
>
> This is worse IMO. Ilpo suggested a bit different alignment. But still..=
.
>
> > Based on feedback from:
> > Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6b=
e83161288@linux.intel.com
>
> You should have CCed the author.
>
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >   drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++----------
> >   1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/=
8250/8250_exar.c
> > index 10725ad0f3ef..a76b4e5bab4e 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -741,19 +741,19 @@ static enum cti_port_type cti_get_port_type_xr17=
c15x_xr17v25x(struct exar8250 *p
> >   		break;
> >   	// 1x RS232, 1x RS422/RS485
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> > -		port_type =3D port_num =3D=3D 0 ?
> > -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		port_type =3D port_num =3D=3D 0 ? CTI_PORT_TYPE_RS232 :
> > +					CTI_PORT_TYPE_RS422_485;
>
>
> Well, could you initialize port_type =3D CTI_PORT_TYPE_RS232? And here d=
o
> only:
> if (port_num > 0)
>      return CTI_PORT_TYPE_RS422_485;
> ?
>

I like this idea I will move to that. Thanks.

>
> >   		break;
> >   	// 2x RS232, 2x RS422/RS485
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> > -		port_type =3D port_num < 2 ?
> > -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		port_type =3D port_num < 2 ? CTI_PORT_TYPE_RS232 :
> > +					CTI_PORT_TYPE_RS422_485;
>
> And so on.
>
> >   		break;
> >   	// 4x RS232, 4x RS422/RS485
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> > -		port_type =3D port_num < 4 ?
> > -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		port_type =3D port_num < 4 ? CTI_PORT_TYPE_RS232 :
> > +					CTI_PORT_TYPE_RS422_485;
> >   		break;
> >   	// RS232/RS422/RS485 HW (jumper) selectable
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
> > @@ -789,13 +789,13 @@ static enum cti_port_type cti_get_port_type_xr17=
c15x_xr17v25x(struct exar8250 *p
> >   		break;
> >   	// 6x RS232, 2x RS422/RS485
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> > -		port_type =3D port_num < 6 ?
> > -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		port_type =3D port_num < 6 ? CTI_PORT_TYPE_RS232 :
> > +					CTI_PORT_TYPE_RS422_485;
> >   		break;
> >   	// 2x RS232, 6x RS422/RS485
> >   	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> > -		port_type =3D port_num < 2 ?
> > -			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		port_type =3D port_num < 2 ? CTI_PORT_TYPE_RS232 :
> > +					CTI_PORT_TYPE_RS422_485;
> >   		break;
> >   	default:
> >   		dev_err(&pcidev->dev, "unknown/unsupported device\n");
> > --
> > 2.43.2
> >
>


