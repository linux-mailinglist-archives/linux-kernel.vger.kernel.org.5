Return-Path: <linux-kernel+bounces-124348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE589160C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6326E1F22C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8A52F89;
	Fri, 29 Mar 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="faX1Qdso"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107045962;
	Fri, 29 Mar 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704600; cv=fail; b=n/QZhWCmkwPCzAiFM0QA6uVg9nXEyUpLoRkyjmGbtZJd37OmBVzXhA42niKRog4moctARvhdtEmE0hPACREZSEz2h4TZy0fdGtIvxl37jvxFueKm++sYZIGrGHpzE5cAWHuiKjGOHTdQMd0dmbBUFoMp0N9junb9rqWjJ6Eok2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704600; c=relaxed/simple;
	bh=NX+rZxB7I6PJtELFrcJv+diNSyBnF4yVQqPdd+XZd7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D07W5/FS5x83ZP9GzKJvXC0uVxFNwPVV0m6EXFW0PYZdv920pT0f3/gmYQoElz9iTnRi5XUaKMw0gYU2rO3aRQiFv0zIxBQ6ns3nb2tjZv5SAD2IrW5j8pynb9mJM62KtBfK9l4Q78TYH76MQUmW8EWLoOo3b3W8s2j/Yei+tLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=faX1Qdso; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5ss9A001797;
	Fri, 29 Mar 2024 02:29:36 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5qw8rjyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 02:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSgKkvcouvKl14dKkt65W9zT9VuLuUOv+0VMDBto3uTnsMMn0JZnpXEr6c8g5/9/iU7HYHhhtItq4IfUAA60CLG9j3Y61HgtTj/OfGQsNUDtK4VyXoTz/qG03zcfe0dp7hZmbsAU+zabfN6RFS1WviNscGUQsVvYIZoEvvSajLy2pWwOqw4/eg6ZFurgkRNM67jF7ya9IewhXXTF8if109zozszw52Nt62tX8detRKsM/lFNnxd6tVWqnMSzjDHjkJ8aSHJ6NZA4hynOXKIFYhZWakC2zJt8c7Wp1uhNF6KlhwWpNwZU6H+c11WkFLwGVetlQpBge+AOe4CpWsJdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ek/g8zArGGwjsFc0bLgdhbN8/6KouZTxqFnc9Bnjbg=;
 b=XvIMZ41zbbMIZ3hFxtawa1707XToRiMMR49y67mKTu1mlboW1oUckoXStLE9XV+5XXV4r3V0vrWEz7uBCsCYSoe0f09Ri74Z9o3wNGtObvbMudxfJ8KJmQrfhDcAJXi7509QbxBWTd5EcaWWSmoSc7A3LKdwm+15yWguta+YuV73UQtZExM8M8ke5OECUUlKxZYThfmXkKspzOPavPm0B5wrjaDlJyBD1OiTQeW/bujVbiuL/Y6Div9smFMZ02EXfvDqGk/5KjlH1gwrEDA7df5bv6ONqxX+prkIapau2ss5W2vlpCn7Y7bmRbTqpP3UYYUgX6B7K4r5zKxasU0yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ek/g8zArGGwjsFc0bLgdhbN8/6KouZTxqFnc9Bnjbg=;
 b=faX1Qdsoaadr0XPUME9H1HsNNh7vL3FsXtGzy7wMM66ypxJo9F+vjz688dr86s/r6KkKrBKPf7fr5b5rc/K3dyZkglhzoir+eHh+jD7Y8NUddgETQUy6CeOAiiInZvZbYuseBlXAn/S5BrBFfgu6xU6l/ygM+eF5SZ9gWrenYkQ=
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com (2603:10b6:a03:55a::21)
 by SA3PR18MB5346.namprd18.prod.outlook.com (2603:10b6:806:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 09:29:32 +0000
Received: from SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58]) by SJ2PR18MB5635.namprd18.prod.outlook.com
 ([fe80::317:8d8c:2585:2f58%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 09:29:32 +0000
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller"
	<davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet
	<edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean
	<olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss
	<arun.ramadoss@microchip.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Willem de Bruijn
	<willemb@google.com>,
        =?iso-8859-1?Q?S=F8ren_Andersen?= <san@skov.dk>
Subject: RE: [PATCH net-next v1 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Topic: [PATCH net-next v1 5/9] net: dsa: microchip: add support for
 different DCB app configurations
Thread-Index: AQHagbub4O0Qub60dEaQVElP78i+Cw==
Date: Fri, 29 Mar 2024 09:29:32 +0000
Message-ID: 
 <SJ2PR18MB56358EDD37EA961C7004CB27A23A2@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
 <20240328160518.2396238-6-o.rempel@pengutronix.de>
In-Reply-To: <20240328160518.2396238-6-o.rempel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR18MB5635:EE_|SA3PR18MB5346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 uImvJRrduVNlXyzFHWD+MO35apWJQwL+xScrwCNbBwBdDpi4lWTzfxqBU23a6vikncNmjhUns6vHg++/7ADAtKzuV2V7dYSpsjQDnoX+yMBxtGw9ucXn521cyFbL7JpkHtT45KKUYM9g9tZBz/vya7GfpzvxUZLWkQYeOjEupJUAVdugeHqwQnqq8z35zw4E1Zobcy+7B80JGvcyxAHYTl7z15ykY2y7L/YXHk6Je9lUMsKGuH7NUAmfVM2RRUrAfeVhS1s6aqlgsO/edjaVlqZP4CLAzC9dGtwp2wOCjzztmx9oBMiqdWFx8pjgizfwtCFwUoW8W4YwJE8lkA5i945Ayjld6eUhcvEKFlG1it3qDuGPC+UqVlqSLPG5qWmijb4zhwRI8pyxVdXOEGKS1ssXEDatPbDPQdQ7VH3ftLtq1FouoHHh8ppT/9UxySShR+i2IELmwDW5Id5vQlrngr9n0BQHuw3sY+Fc/c2R4/mrOmvwDSZBR/Hi/P31hAFLfk8Iy2igkXQ7X7IrDpcBjNNXi2sY1U9hCmwax2KTyJOFOjzQc4s98pj8K8gbuiX+GK4B+aXwG5ENWJmbP5KC4mhYjFvQTwdssvh1+aPJXclub3yD5Ci/T3Yi2Wp/eLM8b0mssyWMwiR9jmX+ROOLrb58SaxvjXivyRakyz2+tzPH8dWHXo8KLXh3Wv/dM6mTaGDrdgI7uRpgynpkQylkTg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR18MB5635.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?am0gsYWJOKPmPBimrrAOcwJM4XGq0CwCPF+imQ2cToBJy2F1TADWUsm9SB?=
 =?iso-8859-1?Q?qRM9zxm63uzkM5htKtnzC9h6Rir4sb5rMxIjrNOKvtS3FgFF93rY7vf5cH?=
 =?iso-8859-1?Q?oG9m/3gSa/qEnNMngdbhDBV7JayZ9xUCAdyT7l4lm5SZvHQ2NflsjVtLWm?=
 =?iso-8859-1?Q?bccOykqQX6xlaUD0Ghbs1+n1IkNQBlVVYTQ3fpuCH5aGjZyhr/QpPziejQ?=
 =?iso-8859-1?Q?ifyHl3HIa/slZTd9zMd6CtUKg8MSp8Hhl+Zl1f4eG/ANg6VwzZK6blrjnY?=
 =?iso-8859-1?Q?GlOJJMD4JIhPQrI9Ndt6y9QnoD6CeZahyfNDcmrvObP0k7m2UZdJMUeSAT?=
 =?iso-8859-1?Q?1NaopsPfNqv0lww+gKvZ6tR7QsrcZ6sm82cbRH81zh59rkn5C27B6vphR3?=
 =?iso-8859-1?Q?Ni+ZnHDtpb84kpi5zrfmc4/ubEnx0dlGhv+2JUaPfduf6VJpa2J4L7sADR?=
 =?iso-8859-1?Q?lqFZJMD1SrNisvwh0e70z/WfF+V0MzsV0Ksnypmob1BW3dVUwRCbWuCf2J?=
 =?iso-8859-1?Q?zgRfp5sLkyYYiTnunAt1LGZ06u7fy1K61ZLY75idOM9vB2jHYAMLVVOr9y?=
 =?iso-8859-1?Q?gUNQAaV282DJR8gIe83pfesN4o7BTcaJ7h4gpoYtzmvCBpXqggFEPQFBbd?=
 =?iso-8859-1?Q?NA/0Lc5RnYVHHsVLMkBB0BsSN81EAiVWRpo3Nq5voyatnW/LNmg22gsBKx?=
 =?iso-8859-1?Q?jZFsMvH5lASk3DQ4V4VGkZnBTrO9Vkqk1jxSY4wxXoYVO3hMfgSAfQXLAa?=
 =?iso-8859-1?Q?wifF9V9gXGuLOmEjm9BxeR23GtIor0CRtmtRmnMQKBqLSbUdFoOTKt7smY?=
 =?iso-8859-1?Q?QwTuTVOsh1evgIWhvOspKH2sxJ6mJ9bgCyWmQo2Bz81e8OB3UPJop3bBts?=
 =?iso-8859-1?Q?vjr2sAKfe+8opkm9ZOZEOQ7U97gH5GCVhnoJpyuDDxSvm0uugDmtOkrtnv?=
 =?iso-8859-1?Q?4K3vI8TiqGsK7XSfVYuEA339l6TcCllXSLBKnLeqEAcIabK9LjncTJA8+s?=
 =?iso-8859-1?Q?0NkbiOsp/eGVuUOeRC6JtpEJkfSXiyEr9/SXvl3EUdcE63THRqci3QTqHS?=
 =?iso-8859-1?Q?5fr0qOsg1ROAbJBdpoP43uDaC+Cya1Gaqy/t4KwvzTggSGyZcvH5Hs/Hvl?=
 =?iso-8859-1?Q?5kbAebm8mq1nnSkL5GJDy8AAGL8JvviFohuyibGAgi7hjo9JT8IZp5z6sM?=
 =?iso-8859-1?Q?aAyBQbyWkGnm2OzIfwnD99NzjAokmC25oaHu91LQxSUfOUMTfG6UUcDEcv?=
 =?iso-8859-1?Q?H3ydaWr/KuF5JCoC+KSEfdJlAu0v7uosluk15gA9f11VDa2HCMXs+3X44e?=
 =?iso-8859-1?Q?aslIhRr8WDu5MKYZ7rSWkF/bBoKcN9Pi1YXwr5coUGlhmWusNz+3YGcLyE?=
 =?iso-8859-1?Q?0+04wTzkIPonSm0dnf71n2gin/pgwSt5o/Jt5dIMNXP7uC3valKKqQC4ii?=
 =?iso-8859-1?Q?5oyes/KzS+4OC5X2/wbxke+TeuXUBfk7/4zgc4qAOJZqGe5UiYtva5tcUV?=
 =?iso-8859-1?Q?7jrCxQssGC2xcfOZMcPBt77xmy6/llmFNXolrCLpEMZpgX+41pCd2WZ8nI?=
 =?iso-8859-1?Q?DJuf/PV9SsQBpeIEDhZYcGgIl2tnYTnmrvT6m8NmuGoID+LQjCw+CQ4EY7?=
 =?iso-8859-1?Q?6w5G1P7mtw6peNnmPdHxRo1CuG9zVh9OHC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR18MB5635.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e626d9-aef2-4222-cdfb-08dc4fd2bdbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 09:29:32.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv92Urp3GtIyimZz0Dc19b0wSKspCsSI256t3FGlPBP1iBQ+0+eII5j8eUlsYxJolr5SrmMafPKWMLX/U09T8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5346
X-Proofpoint-ORIG-GUID: 8Ps92DVVSi0xv0WFnyUkSXkKuMfBgqxV
X-Proofpoint-GUID: 8Ps92DVVSi0xv0WFnyUkSXkKuMfBgqxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_08,2024-03-28_01,2023-05-22_02


> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Thursday, March 28, 2024 9:35 PM
> To: David S. Miller <davem@davemloft.net>; Andrew Lunn <andrew@lunn.ch>;
> Eric Dumazet <edumazet@google.com>; Florian Fainelli <f.fainelli@gmail.co=
m>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Vladim=
ir
> Oltean <olteanv@gmail.com>; Woojung Huh <woojung.huh@microchip.com>;
> Arun Ramadoss <arun.ramadoss@microchip.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de; linu=
x-
> kernel@vger.kernel.org; netdev@vger.kernel.org;
> UNGLinuxDriver@microchip.com; David Ahern <dsahern@kernel.org>; Simon
> Horman <horms@kernel.org>; Willem de Bruijn <willemb@google.com>; S=F8ren
> Andersen <san@skov.dk>
> Subject: [PATCH net-next v1 5/9] net: dsa: microchip: add support
> for different DCB app configurations
>=20
> Add DCB support to configure app trust sources and default port priority.
>=20
> Following commands can be used for testing:
> dcb apptrust set dev lan1 order pcp dscp dcb app replace dev lan1 default=
-prio 3
>=20
> Since it is not possible to configure DSCP-Prio mapping per port, this pa=
tch
> provide only ability to read switch global dscp-prio mapping and way to
> enable/disable app trust for DSCP.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/dsa/microchip/Kconfig      |   2 +
>  drivers/net/dsa/microchip/Makefile     |   2 +-
>  drivers/net/dsa/microchip/ksz_common.c |  12 +-
>  drivers/net/dsa/microchip/ksz_common.h |   5 +
>  drivers/net/dsa/microchip/ksz_dcb.c    | 533 +++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_dcb.h    |  21 +
>  6 files changed, 573 insertions(+), 2 deletions(-)  create mode 100644
> drivers/net/dsa/microchip/ksz_dcb.c
>  create mode 100644 drivers/net/dsa/microchip/ksz_dcb.h
>=20
> diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microchi=
p/Kconfig
> index 394ca8678d2ba..c1b906c05a025 100644
> --- a/drivers/net/dsa/microchip/Kconfig
> +++ b/drivers/net/dsa/microchip/Kconfig
> @@ -4,6 +4,8 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
>  	depends on NET_DSA
>  	select NET_DSA_TAG_KSZ
>  	select NET_DSA_TAG_NONE
> +	select NET_IEEE8021Q_HELPERS
> +	select DCB
>  	help
>  	  This driver adds support for Microchip KSZ9477 series switch and
>  	  KSZ8795/KSZ88x3 switch chips.
> diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microch=
ip/Makefile
> index 49459a50dbc81..1cfba1ec9355a 100644
> --- a/drivers/net/dsa/microchip/Makefile
> +++ b/drivers/net/dsa/microchip/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON)	+=3D ksz_switch.o
> -ksz_switch-objs :=3D ksz_common.o
> +ksz_switch-objs :=3D ksz_common.o ksz_dcb.o
>  ksz_switch-objs +=3D ksz9477.o ksz9477_acl.o ksz9477_tc_flower.o  ksz_sw=
itch-
> objs +=3D ksz8795.o  ksz_switch-objs +=3D lan937x_main.o diff --git
> a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index cf81739d91dae..ea2d6f8d381bc 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -28,6 +28,7 @@
>  #include <net/switchdev.h>
>=20
>  #include "ksz_common.h"
> +#include "ksz_dcb.h"
>  #include "ksz_ptp.h"
>  #include "ksz8.h"
>  #include "ksz9477.h"
> @@ -2371,6 +2372,10 @@ static int ksz_setup(struct dsa_switch *ds)
>  		goto out_ptp_clock_unregister;
>  	}
>=20
> +	ret =3D ksz_dcb_init(dev);
> +	if (ret)
> +		goto out_ptp_clock_unregister;
> +
>  	/* start switch */
>  	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
>  			   SW_START, SW_START);
> @@ -2698,7 +2703,7 @@ static int ksz_port_setup(struct dsa_switch *ds, in=
t
> port)
>  	 * there is no need to do anything.
>  	 */
>=20
> -	return 0;
> +	return ksz_dcb_init_port(dev, port);
>  }
>=20
>  void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state) @=
@ -
> 3950,6 +3955,11 @@ static const struct dsa_switch_ops ksz_switch_ops =3D =
{
>  	.port_setup_tc		=3D ksz_setup_tc,
>  	.get_mac_eee		=3D ksz_get_mac_eee,
>  	.set_mac_eee		=3D ksz_set_mac_eee,
> +	.port_get_default_prio	=3D ksz_port_get_default_prio,
> +	.port_set_default_prio	=3D ksz_port_set_default_prio,
> +	.port_get_dscp_prio	=3D ksz_port_get_dscp_prio,
> +	.port_set_apptrust	=3D ksz_port_set_apptrust,
> +	.port_get_apptrust	=3D ksz_port_get_apptrust,
>  };
>=20
>  struct ksz_device *ksz_switch_alloc(struct device *base, void *priv) dif=
f --git
> a/drivers/net/dsa/microchip/ksz_common.h
> b/drivers/net/dsa/microchip/ksz_common.h
> index 1bedd240cbbe4..4f48a8347e5de 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -621,6 +621,11 @@ static inline bool ksz_is_ksz88x3(struct ksz_device
> *dev)
>  	return dev->chip_id =3D=3D KSZ8830_CHIP_ID;  }
>=20
> +static inline bool is_ksz8(struct ksz_device *dev) {
> +	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev); }
> +
>  static inline int is_lan937x(struct ksz_device *dev)  {
>  	return dev->chip_id =3D=3D LAN9370_CHIP_ID || diff --git
> a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb=
c
> new file mode 100644
> index 0000000000000..527bf10d35dd3
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz_dcb.c
> @@ -0,0 +1,533 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2024 Pengutronix, Oleksij Rempel
> +<kernel@pengutronix.de>
> +
> +#include <linux/dsa/ksz_common.h>
> +#include <net/dsa.h>
> +#include <net/dscp.h>
> +#include <net/ieee8021q.h>
> +
> +#include "ksz_common.h"
> +#include "ksz_dcb.h"
> +#include "ksz8.h"
> +
> +#define KSZ8_REG_PORT_1_CTRL_0			0x10
> +#define KSZ8_PORT_DIFFSERV_ENABLE		BIT(6)
> +#define KSZ8_PORT_802_1P_ENABLE			BIT(5)
> +#define KSZ8_PORT_BASED_PRIO_M			GENMASK(4, 3)
> +
> +#define KSZ88X3_REG_TOS_DSCP_CTRL		0x60
> +#define KSZ8765_REG_TOS_DSCP_CTRL		0x90
> +
> +#define KSZ9477_REG_SW_MAC_TOS_CTRL		0x033e
> +#define KSZ9477_SW_TOS_DSCP_REMAP		BIT(0)
> +#define KSZ9477_SW_TOS_DSCP_DEFAULT_PRIO_M	GENMASK(5, 3)
> +
> +#define KSZ9477_REG_DIFFSERV_PRIO_MAP		0x0340
> +
> +#define KSZ9477_REG_PORT_MRI_PRIO_CTRL		0x0801
> +#define KSZ9477_PORT_HIGHEST_PRIO		BIT(7)
> +#define KSZ9477_PORT_OR_PRIO			BIT(6)
> +#define KSZ9477_PORT_MAC_PRIO_ENABLE		BIT(4)
> +#define KSZ9477_PORT_VLAN_PRIO_ENABLE		BIT(3)
> +#define KSZ9477_PORT_802_1P_PRIO_ENABLE		BIT(2)
> +#define KSZ9477_PORT_DIFFSERV_PRIO_ENABLE	BIT(1)
> +#define KSZ9477_PORT_ACL_PRIO_ENABLE		BIT(0)
> +
> +#define KSZ9477_REG_PORT_MRI_MAC_CTRL		0x0802
> +#define KSZ9477_PORT_BASED_PRIO_M		GENMASK(2, 0)
> +
> +struct ksz_apptrust_map {
> +	u8 apptrust;
> +	u8 bit;
> +};
> +
> +static const struct ksz_apptrust_map ksz8_apptrust_map_to_bit[] =3D {
> +	{ DCB_APP_SEL_PCP, KSZ8_PORT_802_1P_ENABLE },
> +	{ IEEE_8021QAZ_APP_SEL_DSCP, KSZ8_PORT_DIFFSERV_ENABLE },
> };
> +
> +static const struct ksz_apptrust_map ksz9477_apptrust_map_to_bit[] =3D {
> +	{ DCB_APP_SEL_PCP, KSZ9477_PORT_802_1P_PRIO_ENABLE },
> +	{ IEEE_8021QAZ_APP_SEL_DSCP,
> KSZ9477_PORT_DIFFSERV_PRIO_ENABLE }, };
> +
> +/**
> + * ksz_supported_apptrust[] - Supported apptrust selectors and Priority =
Order
> + *			      of Internal Priority Value (IPV) sources.
> + *
> + * This array defines the apptrust selectors supported by the hardware,
> +where
> + * the index within the array indicates the priority of the selector -
> +lower
> + * indices correspond to higher priority. This fixed priority scheme is
> +due to
> + * the hardware's design, which does not support configurable priority
> +among
> + * different priority sources.
> + *
> + * The priority sources, including Tail Tag, ACL, VLAN PCP and DSCP are
> +ordered
> + * by the hardware's fixed logic, as detailed below. The order reflects
> +a
> + * non-configurable precedence where certain types of priority
> +information
> + * override others:
> + *
> + * 1. Tail Tag - Highest priority, overrides ACL, VLAN PCP, and DSCP pri=
orities.
> + * 2. ACL - Overrides VLAN PCP and DSCP priorities.
> + * 3. VLAN PCP - Overrides DSCP priority.
> + * 4. DSCP - Lowest priority, does not override any other priority sourc=
e.
> + *
> + * In this context, the array's lower index (higher priority) for
> + * 'DCB_APP_SEL_PCP' suggests its relative priority over
> + * 'IEEE_8021QAZ_APP_SEL_DSCP' within the system's fixed priority scheme=
.
> + *
> + * DCB_APP_SEL_PCP - Priority Code Point selector
> + * IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point
> +selector  */ static const u8 ksz_supported_apptrust[] =3D {
> +	DCB_APP_SEL_PCP,
> +	IEEE_8021QAZ_APP_SEL_DSCP,
> +};
> +
> +static const u8 ksz8_port2_supported_apptrust[] =3D {
> +	DCB_APP_SEL_PCP,
> +};
> +
> +static const char * const ksz_supported_apptrust_variants[] =3D {
> +	"empty", "dscp", "pcp", "dscp pcp"
> +};
> +
> +static void ksz_get_defult_port_prio_reg(struct ksz_device *dev, int *re=
g,
> +					 u8 *mask, int *shift)
> +{
> +	if (is_ksz8(dev)) {
> +		*reg =3D KSZ8_REG_PORT_1_CTRL_0;
> +		*mask =3D KSZ8_PORT_BASED_PRIO_M;
> +		*shift =3D __bf_shf(KSZ8_PORT_BASED_PRIO_M);
> +	} else {
> +		*reg =3D KSZ9477_REG_PORT_MRI_MAC_CTRL;
> +		*mask =3D KSZ9477_PORT_BASED_PRIO_M;
> +		*shift =3D __bf_shf(KSZ9477_PORT_BASED_PRIO_M);
> +	}
> +}
> +
> +/**
> + * ksz_port_get_default_prio - Retrieves the default priority for a port=
 on a
> + *			       KSZ switch
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number from which to get the default priority
> + *
> + * This function fetches the default priority for the specified port on
> +a KSZ
> + * switch.
> + *
> + * Return: The default priority of the port on success, or a negative
> +error
> + * code on failure.
> + */
> +int ksz_port_get_default_prio(struct dsa_switch *ds, int port) {
> +	struct ksz_device *dev =3D ds->priv;
> +	int ret, reg, shift;
> +	u8 data, mask;
> +
> +	ksz_get_defult_port_prio_reg(dev, &reg, &mask, &shift);
> +
> +	ret =3D ksz_pread8(dev, port, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	return (data & mask) >> shift;
> +}
> +
> +/**
> + * ksz_port_set_default_prio - Sets the default priority for a port on a=
 KSZ
> + *			       switch
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number for which to set the default priority
> + * @prio: Priority value to set
> + *
> + * This function sets the default priority for the specified port on a
> +KSZ
> + * switch.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio)
> +{
> +	struct ksz_device *dev =3D ds->priv;
> +	int reg, shift;
> +	u8 mask;
> +
> +	if (prio >=3D dev->info->num_tx_queues)
> +		return -EINVAL;
> +
> +	ksz_get_defult_port_prio_reg(dev, &reg, &mask, &shift);
> +
> +	return ksz_prmw8(dev, port, reg, mask, (prio << shift) & mask); }
> +
> +/**
> + * ksz_get_dscp_prio_reg - Retrieves the DSCP-to-priority-mapping
> +register
> + * @dev: Pointer to the KSZ switch device structure
> + * @reg: Pointer to the register address to be set
> + * @per_reg: Pointer to the number of DSCP values per register
> + * @mask: Pointer to the mask to be set
> + *
> + * This function retrieves the DSCP to priority mapping register, the
> +number of
> + * DSCP values per register, and the mask to be set.
> + */
> +static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,
> +				  int *per_reg, u8 *mask)
> +{
> +	if (ksz_is_ksz87xx(dev)) {
> +		*reg =3D KSZ8765_REG_TOS_DSCP_CTRL;
> +		*per_reg =3D 4;
> +		*mask =3D GENMASK(1, 0);
> +	} else if (ksz_is_ksz88x3(dev)) {
> +		*reg =3D KSZ88X3_REG_TOS_DSCP_CTRL;
> +		*per_reg =3D 4;
> +		*mask =3D GENMASK(1, 0);
> +	} else {
> +		*reg =3D KSZ9477_REG_DIFFSERV_PRIO_MAP;
> +		*per_reg =3D 2;
> +		*mask =3D GENMASK(2, 0);
> +	}
> +}
> +
> +/**
> + * ksz_port_get_dscp_prio - Retrieves the priority for a DSCP value on a=
 KSZ
> + *			    switch
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number for which to get the priority
> + * @dscp: DSCP value for which to get the priority
> + *
> + * This function fetches the priority value from switch global
> +DSCP-to-priorty
> + * mapping table for the specified DSCP value.
> + *
> + * Return: The priority value for the DSCP on success, or a negative
> +error
> + * code on failure.
> + */
> +int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp) {
> +	struct ksz_device *dev =3D ds->priv;
> +	int reg, per_reg, ret, shift;
> +	u8 data, mask;
> +
> +	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
> +
> +	/* If DSCP remapping is disabled, DSCP bits 3-5 are used as Internal
> +	 * Priority Value (IPV)
> +	 */
> +	if (!is_ksz8(dev)) {
> +		ret =3D ksz_read8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL,
> &data);
> +		if (ret)
> +			return ret;
> +
> +		/* If DSCP remapping is disabled, DSCP bits 3-5 are used as
> +		 * Internal Priority Value (IPV)
> +		 */
> +		if (!(data & KSZ9477_SW_TOS_DSCP_REMAP))
> +			return
> FIELD_GET(KSZ9477_SW_TOS_DSCP_DEFAULT_PRIO_M,
> +					 dscp);
> +	}
> +
> +	/* In case DSCP remapping is enabled, we need to write the DSCP to
> +	 * priority mapping table.
> +	 */
> +	reg +=3D dscp / per_reg;
> +	ret =3D ksz_read8(dev, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	shift =3D (dscp % per_reg) * (8 / per_reg);
> +
> +	return (data >> shift) & mask;
> +}
> +
> +/**
> + * ksz_init_global_dscp_map - Initializes the global DSCP-to-priority
> +mapping
> + * @dev: Pointer to the KSZ switch device structure
> + *
> + * This function initializes the global DSCP-to-priority mapping table
> +for the
> + * switch.
> + *
> + * Return: 0 on success, or a negative error code on failure  */ static
> +int ksz_init_global_dscp_map(struct ksz_device *dev) {
> +	int reg, per_reg, ret, dscp;
> +	u8 data =3D 0;
> +	u8 mask;
> +
> +	/* On KSZ9xxx variants, DSCP remapping is disabled by default.
> +	 * Enable to have, predictable and reproducible behavior across
> +	 * different devices.
> +	 */
> +	if (!is_ksz8(dev)) {
> +		ret =3D ksz_rmw8(dev, KSZ9477_REG_SW_MAC_TOS_CTRL,
> +			       KSZ9477_SW_TOS_DSCP_REMAP,
> +			       KSZ9477_SW_TOS_DSCP_REMAP);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ksz_get_dscp_prio_reg(dev, &reg, &per_reg, &mask);
> +
> +	for (dscp =3D 0; dscp < DSCP_MAX; dscp++) {
> +		int ipv, shift;
> +
> +		/* Map DSCP to Traffic Type, which is corresponding to the
> +		 * Internal Priority Value (IPV) in the switch.
> +		 */
> +		if (!is_ksz8(dev)) {
> +			ipv =3D ietf_dscp_to_ieee8021q_tt(dscp);
> +		} else {
> +			ipv =3D
> ieee8021q_tt_to_tc(ietf_dscp_to_ieee8021q_tt(dscp),
> +						 dev->info->num_tx_queues);
> +		}

No need for braces for single statement.

> +		shift =3D (dscp % per_reg) * (8 / per_reg);
> +		data |=3D (ipv & mask) << shift;
> +
> +		if (dscp % per_reg =3D=3D per_reg - 1) {
> +			ret =3D ksz_write8(dev, reg + (dscp / per_reg), data);
> +			if (ret)
> +				return ret;
> +
> +			data =3D 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz_apptrust_error - Prints an error message for an invalid apptrust
> +selector
> + * @dev: Pointer to the KSZ switch device structure
> + *
> + * This function prints an error message when an invalid apptrust
> +selector is
> + * provided.
> + */
> +static void ksz_apptrust_error(struct ksz_device *dev) {
> +	char supported_apptrust_variants[64];
> +	int i;
> +
> +	supported_apptrust_variants[0] =3D '\0';
> +	for (i =3D 0; i < ARRAY_SIZE(ksz_supported_apptrust_variants); i++) {
> +		if (i > 0)
> +			strlcat(supported_apptrust_variants, ", ",
> +				sizeof(supported_apptrust_variants));
> +		strlcat(supported_apptrust_variants,
> +			ksz_supported_apptrust_variants[i],
> +			sizeof(supported_apptrust_variants));
> +	}
> +
> +	dev_err(dev->dev, "Invalid apptrust selector or priority order. Support=
ed:
> %s\n",
> +		supported_apptrust_variants);
> +}
> +
> +/**
> + * ksz_port_set_apptrust_validate - Validates the apptrust selectors
> + * @dev: Pointer to the KSZ switch device structure
> + * @port: Port number for which to set the apptrust selectors
> + * @sel: Array of apptrust selectors to validate
> + * @nsel: Number of apptrust selectors in the array
> + *
> + * This function validates the apptrust selectors provided and ensures
> +that
> + * they are in the correct order.
> + *
> + * This family of switches supports two apptrust selectors:
> +DCB_APP_SEL_PCP and
> + * IEEE_8021QAZ_APP_SEL_DSCP. The priority order of the selectors is
> +fixed and
> + * cannot be changed. The order is as follows:
> + * 1. DCB_APP_SEL_PCP - Priority Code Point selector (highest priority)
> + * 2. IEEE_8021QAZ_APP_SEL_DSCP - Differentiated Services Code Point
> selector
> + *   (lowest priority)
> + *
> + * Return: 0 on success, or a negative error code on failure  */ static
> +int ksz_port_set_apptrust_validate(struct ksz_device *dev, int port,
> +					  const u8 *sel, int nsel)
> +{
> +	int i, j, j_prev, found;
> +
> +	/* Iterate through the requested selectors */
> +	for (i =3D 0; i < nsel; i++) {
> +		found =3D 0;
> +
> +		/* Check if the current selector is supported by the hardware */
> +		for (j =3D 0; j < sizeof(ksz_supported_apptrust); j++) {
> +			if (sel[i] !=3D ksz_supported_apptrust[j])
> +				continue;
> +
> +			found =3D 1;
> +
> +			/* Ensure that no higher priority selector (lower index)
> +			 * precedes a lower priority one
> +			 */
> +			if (i > 0 && j <=3D j_prev)

j_prev is uninitialized. It may contain garbage value.

> +				goto invalid;
> +
> +			j_prev =3D j;
> +			break;
> +		}
> +
> +		if (!found)
> +			goto invalid;
> +	}
> +
> +	return 0;
> +
> +invalid:
> +	ksz_apptrust_error(dev);
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * ksz_get_apptrus_map_and_reg - Retrieves the apptrust map and
> +register
> + * @dev: Pointer to the KSZ switch device structure
> + * @map: Pointer to the apptrust map to be set
> + * @reg: Pointer to the register address to be set
> + * @mask: Pointer to the mask to be set
> + *
> + * This function retrieves the apptrust map and register address for
> +the
> + * apptrust configuration.
> + */
> +static void ksz_get_apptrus_map_and_reg(struct ksz_device *dev,
> +					const struct ksz_apptrust_map **map,
> +					int *reg, u8 *mask)
> +{
> +	if (is_ksz8(dev)) {
> +		*map =3D ksz8_apptrust_map_to_bit;
> +		*reg =3D KSZ8_REG_PORT_1_CTRL_0;
> +		*mask =3D KSZ8_PORT_DIFFSERV_ENABLE |
> KSZ8_PORT_802_1P_ENABLE;
> +	} else {
> +		*map =3D ksz9477_apptrust_map_to_bit;
> +		*reg =3D KSZ9477_REG_PORT_MRI_PRIO_CTRL;
> +		*mask =3D KSZ9477_PORT_802_1P_PRIO_ENABLE |
> +			KSZ9477_PORT_DIFFSERV_PRIO_ENABLE;
> +	}
> +}
> +
> +/**
> + * ksz_port_set_apptrust - Sets the apptrust selectors for a port on a K=
SZ
> + *			   switch
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number for which to set the apptrust selectors
> + * @sel: Array of apptrust selectors to set
> + * @nsel: Number of apptrust selectors in the array
> + *
> + * This function sets the apptrust selectors for the specified port on
> +a KSZ
> + * switch.
> + *
> + * Return: 0 on success, or a negative error code on failure  */ int
> +ksz_port_set_apptrust(struct dsa_switch *ds, int port,
> +			  const u8 *sel, int nsel)
> +{
> +	const struct ksz_apptrust_map *map;
> +	struct ksz_device *dev =3D ds->priv;
> +	int reg, i, ret;
> +	u8 data =3D 0;
> +	u8 mask;
> +
> +	ret =3D ksz_port_set_apptrust_validate(dev, port, sel, nsel);
> +	if (ret)
> +		return ret;
> +
> +	ksz_get_apptrus_map_and_reg(dev, &map, &reg, &mask);
> +
> +	for (i =3D 0; i < nsel; i++) {
> +		int j;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(ksz_supported_apptrust); j++) {
> +			if (sel[i] !=3D ksz_supported_apptrust[j])
> +				continue;
> +
> +			data |=3D map[j].bit;
> +			break;
> +		}
> +	}
> +
> +	return ksz_prmw8(dev, port, reg, mask, data); }
> +
> +/**
> + * ksz_port_get_apptrust - Retrieves the apptrust selectors for a port o=
n a KSZ
> + *			   switch
> + * @ds: Pointer to the DSA switch structure
> + * @port: Port number for which to get the apptrust selectors
> + * @sel: Array to store the apptrust selectors
> + * @nsel: Number of apptrust selectors in the array
> + *
> + * This function fetches the apptrust selectors for the specified port
> +on a KSZ
> + * switch.
> + *
> + * Return: 0 on success, or a negative error code on failure  */ int
> +ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int
> +*nsel) {
> +	const struct ksz_apptrust_map *map;
> +	struct ksz_device *dev =3D ds->priv;
> +	int reg, i, ret;
> +	u8 data;
> +	u8 mask;
> +
> +	ksz_get_apptrus_map_and_reg(dev, &map, &reg, &mask);
> +
> +	ret =3D ksz_pread8(dev, port, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	*nsel =3D 0;
> +	for (i =3D 0; i < ARRAY_SIZE(ksz_supported_apptrust); i++) {
> +		if (data & map[i].bit)
> +			sel[(*nsel)++] =3D ksz_supported_apptrust[i];
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ksz_dcb_init_port - Initializes the DCB configuration for a port on
> +a KSZ
> + * @dev: Pointer to the KSZ switch device structure
> + * @port: Port number for which to initialize the DCB configuration
> + *
> + * This function initializes the DCB configuration for the specified
> +port on a
> + * KSZ switch. Particular DCB configuration is set for the port,
> +including the
> + * default priority and apptrust selectors.
> + * The default priority is set to Best Effort, and the apptrust
> +selectors are
> + * set to all supported selectors.
> + *
> + * Return: 0 on success, or a negative error code on failure  */ int
> +ksz_dcb_init_port(struct ksz_device *dev, int port) {
> +	int ret, ipv;
> +
> +	if (is_ksz8(dev))
> +		ipv =3D ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
> +					 dev->info->num_tx_queues);
> +	else
> +		ipv =3D IEEE8021Q_TT_BE;
> +
> +	/* Set the default priority for the port to Best Effort */
> +	ret =3D ksz_port_set_default_prio(dev->ds, port, ipv);
> +	if (ret)
> +		return ret;
> +
> +	return ksz_port_set_apptrust(dev->ds, port, ksz_supported_apptrust,
> +				     ARRAY_SIZE(ksz_supported_apptrust));
> +}
> +
> +/**
> + * ksz_dcb_init - Initializes the DCB configuration for a KSZ switch
> + * @dev: Pointer to the KSZ switch device structure
> + *
> + * This function initializes the DCB configuration for a KSZ switch.
> +The global
> + * DSCP-to-priority mapping table is initialized.
> + *
> + * Return: 0 on success, or a negative error code on failure  */ int
> +ksz_dcb_init(struct ksz_device *dev) {
> +	int ret;
> +
> +	ret =3D ksz_init_global_dscp_map(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/drivers/net/dsa/microchip/ksz_dcb.h
> b/drivers/net/dsa/microchip/ksz_dcb.h
> new file mode 100644
> index 0000000000000..254c0e7bdafca
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/ksz_dcb.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2024 Pengutronix, Oleksij Rempel
> +<kernel@pengutronix.de> */
> +
> +#ifndef __KSZ_DCB_H
> +#define __KSZ_DCB_H
> +
> +#include <net/dsa.h>
> +
> +#include "ksz_common.h"
> +
> +int ksz_port_get_default_prio(struct dsa_switch *ds, int port); int
> +ksz_port_set_default_prio(struct dsa_switch *ds, int port, u8 prio);
> +int ksz_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp);
> +int ksz_port_set_apptrust(struct dsa_switch *ds, int port,
> +			  const unsigned char *sel,
> +			  int nsel);
> +int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int
> +*nsel); int ksz_dcb_init_port(struct ksz_device *dev, int port); int
> +ksz_dcb_init(struct ksz_device *dev);
> +
> +#endif /* __KSZ_DCB_H */
> --
> 2.39.2
>=20


