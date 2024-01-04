Return-Path: <linux-kernel+bounces-16692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98389824282
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C79C1F255D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15742233B;
	Thu,  4 Jan 2024 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQgVeIV5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18821A1D;
	Thu,  4 Jan 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkqbJvXSY6Bci0lq4cGSnaviqEOe4BLoKO9Khsfjkz90XvM0AEb9k1TeY4Ej4SlRK/D7XbV4QRV2HwelKbztxq8jTMvTa0lI/nXzsBBDvojC2ovI6tdnKt9c6ubiX5br5meKzV3UuBa9FyBQPavOLCQvg8Why8OxAlYOs//0AvbQMPoP+Kn8MFiCoPxiETQa1AdWzkzO0t3XQPaxTNNYkFaNeaIgjO0wizSUwqKys2z2kzz4hCy3DHE/i5kAeGtGw1Ymv3Hk6knzfEXr4/q6ZJ6zWAPqrV3tExtZryxVKHxxu+0nDicfZ3pKGLsoUpXeZJBa6wwjJloARaC3QfQIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsYTgCAlZ1I1yLHzHlJEf2msCsKNeiMxMLGiMXAdHVs=;
 b=j7K61kNqcbfJxanHhuZEvQjGQF5WAbMle1fKxiK+3ullcJvRI4pKrfEwlAkqfxQucL9qJfumhP1LrmUJoUzDteh0LPHueqj1IibZVlUeSGtOhrsxJ4rkqB3u9JqEiZVMP1Q1IySzmxlWvGRKe8ibH6hZeXnDSD2El8Xr6UWgKBZBuBbQtnpCbbwpqACY1PBfdUxmjnV0/WwUZQSR8hzlXD4XCE+TedhSShJ5GxrVCBVkhYZWO4qBEVRHMO/boEwJmyR03FHDGCQhFiYlB0oc+Z2mxMRO63TAbtgI4/nDgo+mem4WcNexe7wxwa6kipMqT3Ua5UY0394L2GYbx0upBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsYTgCAlZ1I1yLHzHlJEf2msCsKNeiMxMLGiMXAdHVs=;
 b=iQgVeIV5b+fRd0fTX6G4YW8N9LKXP8fmM//G6mkuol5Jnhh9hSH1UcOnPkbRby8AAfvhhWGGqajeRo65m346w0ctvpBdFIbrfBIMO4ysQeFv+sGNPX2O6fBOaJe9Qx4edlyZfrG6e2T90VtHIH7KLK/69qwABBLBwCkzfqk+fH8=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 13:12:27 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::55f7:70c6:e4d8:cf09]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::55f7:70c6:e4d8:cf09%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:12:27 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
CC: "git (AMD-Xilinx)" <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Pandey, Radhey Shyam"
	<radhey.shyam.pandey@amd.com>, "Goud, Srinivas" <srinivas.goud@amd.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>, "manion05gk@gmail.com"
	<manion05gk@gmail.com>
Subject: RE: [PATCH V7 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Topic: [PATCH V7 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Index: AQHaMZbXztsYOdRYPkK03puucNQXpbC5826AgA9RPwA=
Date: Thu, 4 Jan 2024 13:12:26 +0000
Message-ID:
 <DM4PR12MB6109206C0D67567698745CD18C672@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
 <20231218094415.2503672-4-manikanta.guntupalli@amd.com>
 <4d8031d25ac3d38ef1807896fe9a6a9f@vanmierlo.com>
In-Reply-To: <4d8031d25ac3d38ef1807896fe9a6a9f@vanmierlo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SJ1PR12MB6100:EE_
x-ms-office365-filtering-correlation-id: df2ef217-1c5e-4f26-6b53-08dc0d26cc76
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7QC0dEtSFbJvJunumVMTgnxJs76uxsDOhcBn9nlqHwhTL1wEqoTMv/hu4leMTU0+iA94cmNpZcrKDqRwbZ4S0/JH88Jh41ezQjnDNbb3ChhJsHmLjsNzynwsRK99woFLJ2YxzNa4xJxqdPTMucOyQ4q5Dpg88/r4XmlYUdhXbfFb1eAFVCpPTmwrg3QGcFRAWn6xNzkocaZLhy65THUWQUnOSdsgMYhdcfQJ2j8Xb7CITU0tcalHH7QzUD57w3ffIEWEA+A088v/ZeIr96QUaJLDw40bfYTe51xRhwrTt9om7wj0hxv7E7466EBVx0ExLeWKlrP5xNQofoiGeIYCw5H2bkUaQ8Gi+1r6lKHNhe23IvtQ70en0t7cQ+nfhF75CXFPGSfORgqYviV8OVJquDcsS5ta1jDsBTWj8jUS3oVOzAQ9wQJs68C3EfvzASe5J1wBhhR+keGYySleLqsfarrN1aIA2bRUmZ5bpjilKKLR82qB9tUOf2zvkizdKUD+e9XL3Yxmx4jqO5I6VmDvhFVvr+pf4JcwcTKln05mwun5PGu8CovYikptyW35v2TN7kbX2d/koLGYaLdC9LR63B4umyBdRXA5kLMvPo1cL7U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(53546011)(71200400001)(9686003)(6506007)(478600001)(7696005)(83380400001)(966005)(7416002)(4001150100001)(41300700001)(30864003)(2906002)(66476007)(66556008)(316002)(8936002)(66946007)(66446008)(54906003)(52536014)(76116006)(38070700009)(4326008)(64756008)(8676002)(5660300002)(6916009)(38100700002)(122000001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ilERIItX7uargZ6sUPLtOstCBrmYKcFnn6/TrVwoLpUvHMOMGRovt1iKyqjF?=
 =?us-ascii?Q?0QDBpwnbUHfl1db63o73bc8Cao4O5027jyOrvX4eKSotCt1rdYAfLZ/pXgrz?=
 =?us-ascii?Q?tpXGy/Ljp2iCHVnycnq2bhfx9BdTlHn2sXXyjbBZZwfjKG9RmDQ8RW9PEoZz?=
 =?us-ascii?Q?T3Ao1cWFj1zbNE4QuVbxm1Rk+fPPNIMo/0Ezm+y7Wib3ymKeuaGf49hj45wR?=
 =?us-ascii?Q?FHJMLAnjaezws9yhTJFk3kz6Ww0xKbjQqsjsVPjCByRG0O08grK1ndNIAUmb?=
 =?us-ascii?Q?NO8iRA1jZ91ybNeL5xcWw7ei1nYsejmRISAU+Z+l3s+7n8N2wJ5f54GlD2MS?=
 =?us-ascii?Q?lu5AMWbQlTgWwuiJtsHb6jlAr7Z5pCpqHBDgf0KHPj8JEqbU1tycxNAEz6mj?=
 =?us-ascii?Q?nQSSlkf7AbVB53IcOFKP1h1NncSNSmdORbK5ltLjeLb1f/CEnbqbhHMH8mrA?=
 =?us-ascii?Q?CdXwfP4Ts7pljfVxQAmr1amljGw9ANfHw71T9F3s1mjb2RRonfWIxRq9nmqd?=
 =?us-ascii?Q?200o/75LRe3n28IpbsgmMICQ4IJVEsBdgjWHLKvZAZhc7cCFX2giy8dxUEKK?=
 =?us-ascii?Q?2XR1xsvspTv/Xhr16iz96enVRApYVo2vcMEoQ58UNqjYO0bcW/wOoMaVDQ59?=
 =?us-ascii?Q?qwgM6iqQv7GwsH2asJenxO5MhLbYnXd1iu0/iBdQIfQb2SZ+DVdYe6xnyIVu?=
 =?us-ascii?Q?B/RHWKHbpKJUfyZxOOWXVNsHK5kO1zh3pzB/zcScFwq57yW5XL0pCFlSKpu1?=
 =?us-ascii?Q?SXR7uJZeTrpZQs/wGmcQp1/5UwWs4vdVldb/CpXJhpf0t0BQdaowmi2KoY9G?=
 =?us-ascii?Q?y5C4hhjBcS+uC1CwgVUCJA6d/SQ0KiLadwjmavzj9yic+X6tQvLDG+HR69UF?=
 =?us-ascii?Q?X41MYoDovWs799eWTxU+fIszda4NaIPI4c5pk9xuz01f6O+OfHdq5imzM6J5?=
 =?us-ascii?Q?pIAOnNoIeBWjFOZPGm1vrMWcxUOddavm7AbMwP/1wwo5a0q0jLUMomOcvONk?=
 =?us-ascii?Q?eSbojXw0Ppyy0lk46ajgZL4hFNVJpRw5ySFgjaQI6HvxmV98YMTGw2bnKpYZ?=
 =?us-ascii?Q?G25EPOc9XhccPlLyt4Cp8kmRiXNLzRecH70I8HMY9xlHFuy/okUetA9xPYa/?=
 =?us-ascii?Q?r8BCy8DZXvC/PnBsY2i5Q3Rv4RDbJPH9Die0MARQfBnJBMHzEkOd6l0XY0Cw?=
 =?us-ascii?Q?KuSrov8QUfefnoL4ZUzb0Q5lPWu1mMJGAX9PK3l4AlMbTAzXBGY+XzvFkVk/?=
 =?us-ascii?Q?3KSvGPdReRQbh3UpqbeAAVNME1m4TwVHoTZXIjngjI2f65E+LeRmCtSxmnMj?=
 =?us-ascii?Q?gR88RALUp7zA1I9zOKhRyp/8wV1xyqsr6LjnDMIaiWHJQP9Ab30VbelO+LQ4?=
 =?us-ascii?Q?x8k4eFzXYwBQbI1UEpnckDebhzFpNB2tonuMGy1njnJ9YydO6A5NwmeCJd5l?=
 =?us-ascii?Q?TRqk3vSfaB7XcwoALu03XBMrb1A1SZ1n93VW1LwgqW23R85iYwWMBLzn7rTy?=
 =?us-ascii?Q?ceqP0bRPc0dt6tgfpndfEw4jPrTcZaH+VQY2x6tQdBBxl7TJ0kcOJZ/Qgnga?=
 =?us-ascii?Q?7Ajx3ZGR4ug9S81bz+E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2ef217-1c5e-4f26-6b53-08dc0d26cc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 13:12:26.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Z0UGoXfqR7bq+ei/Hcp0MNaqRZm9rP34JgwKSa5cMAWHR2xRPsbb3bhgsHOGlzRLr9L9NcvqNcHnXOTKRwwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

Hi,

> -----Original Message-----
> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
> Sent: Monday, December 25, 2023 5:40 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; gregkh@linuxfoundation.org;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; linux-serial@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Pandey, Radhe=
y
> Shyam <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> Subject: Re: [PATCH V7 3/3] tty: serial: uartps: Add rs485 support to uar=
tps
> driver
>=20
> Manikanta Guntupalli wrote on 2023-12-18 10:44:
> >  drivers/tty/serial/xilinx_uartps.c | 222
> > +++++++++++++++++++++++++++--
> >  1 file changed, 213 insertions(+), 9 deletions(-)
> >
> > @@ -203,10 +209,22 @@ struct cdns_uart {
> >  	struct notifier_block	clk_rate_change_nb;
> >  	u32			quirks;
> >  	bool cts_override;
> > +	struct gpio_desc	*gpiod_rts;
> > +	bool			rs485_tx_started;
> > +	struct timer_list	timer;
>=20
> start_tx_timer
We will fix.
>=20
> > +	struct timer_list	stop_tx_timer;
>=20
> struct hrtimer maybe?
We will fix.
>=20
> >  };
> >  struct cdns_platform_data {
> >  	u32 quirks;
> >  };
> > +
> > +struct serial_rs485 cdns_rs485_supported =3D {
> > +	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> > +		 SER_RS485_RTS_AFTER_SEND,
> > +	.delay_rts_before_send =3D 1,
> > +	.delay_rts_after_send =3D 1,
> > +};
> > +
> >  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> >  		clk_rate_change_nb)
> >
> > @@ -305,6 +323,55 @@ static void cdns_uart_handle_rx(void *dev_id,
> > unsigned int isrstatus)
> >  	tty_flip_buffer_push(&port->state->port);
> >  }
> >
> > +/**
> > + * cdns_rts_gpio_enable - Configure RTS/GPIO to high/low
> > + * @cdns_uart: Handle to the cdns_uart
> > + * @enable: Value to be set to RTS/GPIO  */ static void
> > +cdns_rts_gpio_enable(struct cdns_uart *cdns_uart, bool
> > enable)
> > +{
> > +	u32 val;
> > +
> > +	if (cdns_uart->gpiod_rts) {
> > +		gpiod_set_value(cdns_uart->gpiod_rts, enable);
> > +	} else {
> > +		val =3D readl(cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +		if (enable)
> > +			val &=3D ~CDNS_UART_MODEMCR_RTS;
> > +		else
> > +			val |=3D CDNS_UART_MODEMCR_RTS;
> > +		writel(val, cdns_uart->port->membase +
> CDNS_UART_MODEMCR);
> > +	}
> > +}
> > +
> > +/**
> > + * cdns_rs485_tx_setup - Tx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_tx_setup(struct cdns_uart *cdns_uart) {
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
> > +		cdns_rts_gpio_enable(cdns_uart, 1);
> > +	else
> > +		cdns_rts_gpio_enable(cdns_uart, 0);
>=20
> Maybe simply:
> 	bool enable =3D cdns_uart->port->rs485.flags &
> SER_RS485_RTS_ON_SEND;
> 	cdns_rts_gpio_enable(cdns_uart, enable);
We will fix.
>
> > +
> > +	cdns_uart->rs485_tx_started =3D true;
> > +}
> > +
> > +/**
> > + * cdns_rs485_rx_setup - Rx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_rx_setup(struct cdns_uart *cdns_uart) {
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> > +		cdns_rts_gpio_enable(cdns_uart, 1);
> > +	else
> > +		cdns_rts_gpio_enable(cdns_uart, 0);
>=20
> Same here
We will fix.
>=20
> > +
> > +	cdns_uart->rs485_tx_started =3D false; }
> > +
> >  /**
> >   * cdns_uart_tx_empty -  Check whether TX is empty
> >   * @port: Handle to the uart port structure @@ -579,6 +646,44 @@
> > static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,  }
> > #endif
> >
> > +/**
> > + * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
> > + * @t: Handle to the timer list structure  */ static void
> > +cdns_rs485_rx_callback(struct timer_list *t) {
> > +	struct cdns_uart *cdns_uart =3D from_timer(cdns_uart, t, timer);
> > +
> > +	/*
> > +	 * Default Rx should be setup, because Rx signaling path
> > +	 * need to enable to receive data.
> > +	 */
> > +	cdns_rs485_rx_setup(cdns_uart);
> > +}
> > +
> > +/**
> > + * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
> > + * @t: Handle to the timer list structure  */ static void
> > +cdns_rs485_tx_callback(struct timer_list *t) {
> > +	struct cdns_uart *cdns_uart =3D from_timer(cdns_uart, t, timer);
> > +
> > +	uart_port_lock(cdns_uart->port);
> > +	cdns_uart_handle_tx(cdns_uart->port);
> > +
> > +	/* Enable the TX Empty interrupt */
> > +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase +
> > CDNS_UART_IER);
> > +	uart_port_unlock(cdns_uart->port);
> > +
> > +	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
> > +	    uart_tx_stopped(cdns_uart->port)) {
> > +		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);
>=20
> You really should not do this here. This belongs in
> cdns_uart_handle_tx() which
> is also called from the TXEMPTY handler. And make sure TXEMPTY is true an=
d
> on top you also must account for the time it takes for the last character=
 to
> leave the transmitter including the stopbit.
>=20
> See also em485 code in 8250_port.c:
> 	stop_delay =3D p->port.frame_time + DIV_ROUND_UP(p-
> >port.frame_time, 7);
>=20
> > +		mod_timer(&cdns_uart->timer, jiffies +
> > +			  msecs_to_jiffies(cdns_uart->port-
> >rs485.delay_rts_after_send));
> > +	}=20
We will fix.
>
> Should you not stop the stop_tx_timer in case it is still running when a =
new
> transmission is requested?
>=20
We will fix.
> > +}
> > +
> >  /**
> >   * cdns_uart_start_tx -  Start transmitting bytes
> >   * @port: Handle to the uart port structure @@ -586,6 +691,7 @@
> > static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
> > static void cdns_uart_start_tx(struct uart_port *port)  {
> >  	unsigned int status;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> >  	if (uart_tx_stopped(port))
> >  		return;
> > @@ -604,10 +710,40 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >
> >  	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_ISR);
> >
> > -	cdns_uart_handle_tx(port);
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (!cdns_uart->rs485_tx_started) {
> > +			timer_setup(&cdns_uart->timer,
> > +				    cdns_rs485_tx_callback, 0);
>=20
> On a single line
We will fix.
>=20
> > +			cdns_rs485_tx_setup(cdns_uart);
> > +			mod_timer(&cdns_uart->timer, jiffies +
> > +				  msecs_to_jiffies(port-
> >rs485.delay_rts_before_send));
> > +		} else {
> > +			if (!timer_pending(&cdns_uart->timer))
> > +				mod_timer(&cdns_uart->timer, jiffies);
> > +		}
> > +	} else {
> > +		cdns_uart_handle_tx(port);
> >
> > -	/* Enable the TX Empty interrupt */
> > -	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IER);
> > +		/* Enable the TX Empty interrupt */
> > +		writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IER);
> > +	}
> > +}
> > +
> > +/**
> > + * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for
> > rs485.
> > + * @t: Handle to the timer list structure  */ static void
> > +cdns_rs485_stop_tx_callback(struct timer_list *t) {
> > +	unsigned int regval;
> > +	struct cdns_uart *cdns_uart =3D from_timer(cdns_uart, t,
> > stop_tx_timer);
> > +
> > +	cdns_rs485_rx_setup(cdns_uart);
> > +
> > +	regval =3D readl(cdns_uart->port->membase + CDNS_UART_CR);
> > +	regval |=3D CDNS_UART_CR_TX_DIS;
> > +	/* Disable the transmitter */
>=20
> Why do you want to do this?
To disable Tx when cdns_uart_stop_tx() called in Rs485 case and this part o=
f code runs in separate thread in RS485 case.
>=20
> > +	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
> >  }
> >
> >  /**
> > @@ -617,11 +753,19 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >  static void cdns_uart_stop_tx(struct uart_port *port)  {
> >  	unsigned int regval;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> > -	regval =3D readl(port->membase + CDNS_UART_CR);
> > -	regval |=3D CDNS_UART_CR_TX_DIS;
> > -	/* Disable the transmitter */
> > -	writel(regval, port->membase + CDNS_UART_CR);
> > +	if ((cdns_uart->port->rs485.flags & SER_RS485_ENABLED) &&
> > +	    !timer_pending(&cdns_uart->stop_tx_timer) &&
> > +	    cdns_uart->rs485_tx_started) {
> > +		mod_timer(&cdns_uart->stop_tx_timer, jiffies +
> > +			  msecs_to_jiffies(cdns_uart->port-
> >rs485.delay_rts_after_send));
>=20
> Why try to adhere to the rts delay here? The original code doesn't seem
> to care
> if the fifo is still filled either. Or was it already broken?
>=20
> I did not yet find out exactly when this struct uart_ops .stop_tx is
> called.
As per kernel documentation, " the tty layer indicating we want to stop tra=
nsmission due to an XOFF character."
https://docs.kernel.org/driver-api/serial/driver.html

>=20
> > +	} else {
> > +		regval =3D readl(port->membase + CDNS_UART_CR);
> > +		regval |=3D CDNS_UART_CR_TX_DIS;
> > +		/* Disable the transmitter */
> > +		writel(regval, port->membase + CDNS_UART_CR);
> > +	}
> >  }
> >
> >  /**
> > @@ -829,6 +973,12 @@ static int cdns_uart_startup(struct uart_port
> > *port)
> >  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
> >  		cpu_relax();
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		timer_setup(&cdns_uart->stop_tx_timer,
> > +			    cdns_rs485_stop_tx_callback, 0);
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +	}
> > +
> >  	/*
> >  	 * Clear the RX disable bit and then set the RX enable bit to enable
> >  	 * the receiver.
> > @@ -888,6 +1038,7 @@ static void cdns_uart_shutdown(struct uart_port
> > *port)
> >  {
> >  	int status;
> >  	unsigned long flags;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> >  	uart_port_lock_irqsave(port, &flags);
> >
> > @@ -903,6 +1054,11 @@ static void cdns_uart_shutdown(struct uart_port
> > *port)
> >  	uart_port_unlock_irqrestore(port, flags);
> >
> >  	free_irq(port->irq, port);
> > +
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		del_timer_sync(&cdns_uart->timer);
> > +		del_timer_sync(&cdns_uart->stop_tx_timer);
> > +	}
> >  }
> >
> >  /**
> > @@ -1032,7 +1188,7 @@ static void cdns_uart_set_mctrl(struct uart_port
> > *port, unsigned int mctrl)
> >  	mode_reg &=3D ~CDNS_UART_MR_CHMODE_MASK;
> >
> >  	if (mctrl & TIOCM_RTS)
> > -		val |=3D CDNS_UART_MODEMCR_RTS;
> > +		cdns_rts_gpio_enable(cdns_uart_data, 1);
>=20
> First passing 1 here is wrong. It should be 0.
> Also there is no call with the opposite value here.
>=20
> But this call could modify the MODEMCR register however its result is
> immediately overwritten in the lines below with a wrong value in val.
> Keep as-is and maybe add the following instead:
>=20
> +	if (cdns_uart->gpiod_rts)
> +		gpiod_set_value(cdns_uart->gpiod_rts, !(mctrl &
> TIOCM_RTS));

GPIO is active high, so need to pass 1 for gpio case and to make native rts=
 line high in native rts case need to write 0 to rts bit of MODEMCR that we=
 are handling in cdns_rts_gpio_enable() as below:
        if (cdns_uart->gpiod_rts) {
                gpiod_set_value(cdns_uart->gpiod_rts, enable);
        } else {
                val =3D readl(cdns_uart->port->membase + CDNS_UART_MODEMCR)=
;
                if (enable)
                        val &=3D ~CDNS_UART_MODEMCR_RTS;
                else
                        val |=3D CDNS_UART_MODEMCR_RTS;
                writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
        }

>=20
> >  	if (mctrl & TIOCM_DTR)
> >  		val |=3D CDNS_UART_MODEMCR_DTR;
> >  	if (mctrl & TIOCM_LOOP)
> > @@ -1455,6 +1611,37 @@ MODULE_DEVICE_TABLE(of,
> cdns_uart_of_match);
> >  /* Temporary variable for storing number of instances */
> >  static int instances;
> >
> > +/**
> > + * cdns_rs485_config - Called when an application calls TIOCSRS485
> > ioctl.
> > + * @port: Pointer to the uart_port structure
> > + * @termios: Pointer to the ktermios structure
> > + * @rs485: Pointer to the serial_rs485 structure
> > + *
> > + * Return: 0
> > + */
> > +static int cdns_rs485_config(struct uart_port *port, struct ktermios
> > *termios,
> > +			     struct serial_rs485 *rs485)
> > +{
> > +	u32 val;
> > +	unsigned int ctrl_reg;
> > +
> > +	if (rs485->flags & SER_RS485_ENABLED) {
> > +		dev_dbg(port->dev, "Setting UART to RS485\n");
> > +		/* Make sure auto RTS is disabled */
> > +		val =3D readl(port->membase + CDNS_UART_MODEMCR);
> > +		val &=3D ~CDNS_UART_MODEMCR_FCM;
> > +		writel(val, port->membase + CDNS_UART_MODEMCR);
> > +		/* Disable transmitter and make Rx setup*/
> > +		cdns_uart_stop_tx(port);
> > +	} else {
> > +		/* Disable the TX and RX */
> > +		ctrl_reg =3D readl(port->membase + CDNS_UART_CR);
> > +		ctrl_reg |=3D CDNS_UART_CR_TX_DIS |
> CDNS_UART_CR_RX_DIS;
> > +		writel(ctrl_reg, port->membase + CDNS_UART_CR);
>=20
> Why would you disable the transmitter and receiver here?
It was added as part of below review comment [1], please let me know what y=
ou recommend.
" this function is expected to be able to also turn RS485 off."

[1] https://lore.kernel.org/all/7919791e-f52f-eb35-ead-deea90cbe8@linux.int=
el.com/
>=20
> > +	}
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cdns_uart_probe - Platform driver probe
> >   * @pdev: Pointer to the platform device structure
> > @@ -1597,9 +1784,23 @@ static int cdns_uart_probe(struct
> > platform_device *pdev)
> >  	port->private_data =3D cdns_uart_data;
> >  	port->read_status_mask =3D CDNS_UART_IXR_TXEMPTY |
> CDNS_UART_IXR_RXTRIG
> > |
> >  			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
> > +	port->rs485_config =3D cdns_rs485_config;
> > +	port->rs485_supported =3D cdns_rs485_supported;
> >  	cdns_uart_data->port =3D port;
> >  	platform_set_drvdata(pdev, port);
> >
> > +	rc =3D uart_get_rs485_mode(port);
> > +	if (rc)
> > +		goto err_out_clk_notifier;
> > +
> > +	cdns_uart_data->gpiod_rts =3D devm_gpiod_get_optional(&pdev->dev,
> > "rts",
> > +							    GPIOD_OUT_LOW);
> > +	if (IS_ERR(cdns_uart_data->gpiod_rts)) {
> > +		rc =3D PTR_ERR(cdns_uart_data->gpiod_rts);
> > +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional
> failed\n");
> > +		goto err_out_clk_notifier;
> > +	}
> > +
> >  	pm_runtime_use_autosuspend(&pdev->dev);
> >  	pm_runtime_set_autosuspend_delay(&pdev->dev,
> > UART_AUTOSUSPEND_TIMEOUT);
> >  	pm_runtime_set_active(&pdev->dev);
> > @@ -1618,6 +1819,8 @@ static int cdns_uart_probe(struct platform_device
> > *pdev)
> >  		console_port =3D port;
> >  	}
> >  #endif
> > +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> > +		cdns_rs485_rx_setup(cdns_uart_data);
> >
> >  	rc =3D uart_add_one_port(&cdns_uart_uart_driver, port);
> >  	if (rc) {
> > @@ -1646,6 +1849,7 @@ static int cdns_uart_probe(struct platform_device
> > *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +err_out_clk_notifier:
> >  #ifdef CONFIG_COMMON_CLK
> >  	clk_notifier_unregister(cdns_uart_data->uartclk,
> >  			&cdns_uart_data->clk_rate_change_nb);
>=20
> Kind Regards,
> Maarten Brock

Thanks,
Manikanta.

