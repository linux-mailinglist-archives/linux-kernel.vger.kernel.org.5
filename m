Return-Path: <linux-kernel+bounces-23443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2782ACC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BFC2830B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D565414F85;
	Thu, 11 Jan 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bidjNwGL"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3215495;
	Thu, 11 Jan 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfYDzyiwlZgHESy4QC0c+yyRE4skg9doCEBn04J78GUa9jqbPjlCKktpls5SbaiKt7abgVMrK+PxFdlAbTb5AnimWQUsDvWhIPQiPmaL1NPb2W+hbdjZtvImkkBHe/0vaG/iFk4fv2DjPsjyqa710KgoGmLYjMumV3V7sTrR7GnUpUXhQqL8a7/ULRTbVDTcK15k8+cOdtJAMIjQh4ZMRlfgFRSFqcnUfwUQ2v+1PSUmjYqzgUI2D6PAUIWitQekp5SwNblWTspfe6d0Ok1z9xRXzYR7mhh70hWq2eaGZHJXYf25oIYYcJoCO8S2u69Cg/ouorXBdoMTI3/6z0PyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feFnhXmmUkfRwQIuRzX+f4jUUoyaDTp0wWqHklLtzj0=;
 b=SvbJ9akcezJB3teSiUujDhA/KYXQ/DFNoTqQkEpC85xuNXPc59FdwytGT2cIqep8vp8Xh4b2nuj3FU+YLx7n/cwTT7jyyp3BIk60sTk3D+9ycPkLHYbGzYZ7ZLzWVU6K+ECsuQ4VfpX1nfDk6i8XSvFT80qF5yGlz1NfV+oJTy6ur/UXir5LccsJraZpnGZHDTngQ6P6pmwZwfh/2WqJzaxamHpZtXkHH2tQmqxlbGQiFmm1rw/UnLzRMvGaM2X5YaVRHlDNNON72Jm0klxMF2d9O2cJBTK3yrlmnx7qDDygVEy+cx1WadWGZ11zG09xoacRb8XHO3PrsLzmSd7Raw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feFnhXmmUkfRwQIuRzX+f4jUUoyaDTp0wWqHklLtzj0=;
 b=bidjNwGLBZtwKQx3Xof8ttW+YNC+2fts3gCA7ltbUFi3qsiCrhjxspfXm7Gh3HWogyjZTZdXR6PgrtFoVTnNBQ77kctgpzmxZaYnXIf2C7WbSMTap5HyCx0UOt5HxX3x6B5XlsFWhDxBKJlbpMdLz+epu8GiKS5uOvnzsaGk6yg=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Thu, 11 Jan
 2024 11:03:01 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::55f7:70c6:e4d8:cf09]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::55f7:70c6:e4d8:cf09%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 11:03:01 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Maarten Brock <m.brock@vanmierlo.com>
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
Subject: RE: [PATCH V8 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Topic: [PATCH V8 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
Thread-Index: AQHaQ7XiS3JlQKeyPkyNWVRI+b0HXrDTDYcAgAFWUjA=
Date: Thu, 11 Jan 2024 11:03:00 +0000
Message-ID:
 <DM4PR12MB610984B234E4EEC5F17528E98C682@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
 <20240110111107.3645284-4-manikanta.guntupalli@amd.com>
 <6302479f8f991c98d55b2f887c0f356f@vanmierlo.com>
In-Reply-To: <6302479f8f991c98d55b2f887c0f356f@vanmierlo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|PH7PR12MB6636:EE_
x-ms-office365-filtering-correlation-id: fcb0b436-7bd6-425c-1088-08dc1294e06f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O1CzZCRbzgzXSxnS11uel6sbY2NXB8q5stIMMJVP76FXDkNvRCyrztq1oToMPZPHGvGW2OPvRp6SgymwBELw+oIlfB4Jf4f5p1VwibrHcZJEqV9GGoMgTFRcamchcucVDJmXrKQXr17WOI74fVhbP0iHGTnfSiirLJrlshBxwoSPGqsF3Tw9CDuomvIf7B/Rp7fK2wV2m0l4jQHqY1DWRwDWHcarpeTVu0lco1M1epRihSoXiAQga/gpAwTGAznZZgZgnhG4SvFUAegmi8eyhJwhM7MBIczwKn35Ua44SVrNPjMXu8Jau4oK/jEPR5pe8sUB1aGM/zYlgkjp3ltOEKhP+LgK5TQOZaeuQfRT9dOT7CvSQ0caO+oV0dIuxQ7W0Gosz5U8AvgdBOr6x2EoS4OTcH1hS1OrBlEtwzQRI4dm3FmMhtn/T6b3ApTyJnvUd2fOhV3Kv1FVIVpDORCMrk0WeshbetjuNW29xNLhmRkwtNDiz1ymbw6M8bAeHLJHJTre+XpCo9hrE0BcUBl9Gd/u200WRY8aITp+3YcZrAt54c82RnWBaAxrtCK+qE7lctfwYsVrWf/6MAvdW7dZ92ZHEH/kwQkMuFB6cLZEnYViLRt0uwAKUEq9oddVWgk7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(71200400001)(478600001)(7696005)(9686003)(53546011)(6506007)(26005)(38070700009)(122000001)(38100700002)(30864003)(33656002)(86362001)(41300700001)(76116006)(83380400001)(5660300002)(7416002)(66476007)(4326008)(52536014)(8676002)(316002)(66946007)(66446008)(2906002)(66556008)(8936002)(64756008)(6916009)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7LTtXMNQmcOHVkP3IhQnFR2CXlSsAk3d2jny528F8GDWmEEzbqXA23ub+cvL?=
 =?us-ascii?Q?xMLHmciFswzE48N8zCBrO1TYTOB5hyWPbTMDUHK5e2gm/oPsYGFM+wAeoUD2?=
 =?us-ascii?Q?0kDtzKMeEMRwj0EfHB+xmh0xR7ooBxy6qAM5DmuFjqru0r1s+TLObl92kHBr?=
 =?us-ascii?Q?TCfhrQIqn1GRs7On0qrNFtJo3ApqNnpCnmor++x66dy9D4mCeKfJL/frg+v3?=
 =?us-ascii?Q?n/OkXKiuSdZN8LGD7lPx+IlImsMagfwL8LZk+Bmp2/YeuuN6HNda0KX/EOoh?=
 =?us-ascii?Q?U0K0lbnv0RuNL0Pm6vXG0BjZhkue0MYVJLQ0ZquasZo8oKFEErHvYfuJzY71?=
 =?us-ascii?Q?A8tbMwl7iktUrHXMuYIAbYPtoZ3e/8rjXyPE8UTZyfZ2drL5bfjAYRzmPXV3?=
 =?us-ascii?Q?lVU6CJQ40uTyQwpiAk33uHE5SkHECv+5bmcf9jmAX8XI7lAdJP1kO+s6rGXV?=
 =?us-ascii?Q?u3eJn44vf+/X+HkgndxAMxOFqhLg+G5FvaUArZrutqQgGN7oR/mZ9zjm0IPs?=
 =?us-ascii?Q?Jjz9mbCUDyTE8nkRwQVcBAxeOooZAabk6ynLXEW+E9orVbJZLDu/JifFMLmn?=
 =?us-ascii?Q?m03zPK4FyW/Kj4xeIm6sISAOYzNhxNvNgrleo8EfNUtnhU3LU1BHl3KajsGM?=
 =?us-ascii?Q?RHdqtSuRbyrE/Xqf6z53/7uuY4eYrrOKnCXVAh6ctbEtnPe3gAp4D1uBI8sv?=
 =?us-ascii?Q?rXPhM+4kuxjCJ3kPBZNJX5AiPSXqeMJlxf4vIapBJ6NI7ID8ieXp3LyLM7ID?=
 =?us-ascii?Q?Fr8dktNDaIER/CkXfXbeoi1cqcYdKATQxjtdx+kr+XOzPGNbEAlfQXnLkWGS?=
 =?us-ascii?Q?Dd3U1d9CucBxFNRe1yvJiY4f+N1OQJRpKeSCutQM8aqgihXf2aIbLYcCRyDw?=
 =?us-ascii?Q?lDSkT0+PMURCtLUdAJ5gl7OTIo9LdZoUgK8B+V0/hU30FPoJUWmt/2ETDJXC?=
 =?us-ascii?Q?gTBikKWx53jCqLMtddlcb4CvphBPE143Ixox81+ab6UkxexL7o9pATz/pk8F?=
 =?us-ascii?Q?zxIEyWKJL/GaD1UVYZ2twdAw5ujHSxmxoPvybPeRncmHyYRJV+hw2dCvj4nh?=
 =?us-ascii?Q?uXkTds43VCfIfIBg3kngJs7mQLsVMVBMWx2YvkgDlKUHqyXaoWoywIodYXB8?=
 =?us-ascii?Q?/Iu7HycigW4hXvEc8AV66Om0pPLYZqxoAuxETaxUoQdPSpDJnsFZlR/XRq6F?=
 =?us-ascii?Q?xf9IOciTJlpBWDcwDJ3c5K8krAhNjQqZ2pKEgswu2qHdq4whnqQiayxmZPZZ?=
 =?us-ascii?Q?8HFr00+2xQHgFtGcN0aMsHa4phxk2JRR16PGULg+vLNWiislv11+g0B1gfHJ?=
 =?us-ascii?Q?lIMXbcZfu6Ku+IPXR+HBKHsx+mjA7E4s4Bd93nJI2wEsgjxmSNt6/HQ7Nkrl?=
 =?us-ascii?Q?c7I9R79hDXSN2JQBGaU7HJs+LOYJeSS/b2yxZadDBT6kG2oyZV4v6GLKZ/Gs?=
 =?us-ascii?Q?gz62ZU5BNFnqmirWyB31WbgWV6Tb4dbt3URi5cY4tZdq0AkbE8wX53k4EBtf?=
 =?us-ascii?Q?aAWlG0/nhPVbiGfnodUCk00+Vx7arlXuE9OIDMWyvxEQ+t7B8m6gGXJtK3oQ?=
 =?us-ascii?Q?UBr17CkBBIHLviNEt8k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb0b436-7bd6-425c-1088-08dc1294e06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 11:03:00.9269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QfmtUPH0kSU+4Was6pr/zTPPo5kht2G7CWqubfk1kdcCgZW5JYXt6q6PZxlR0NAWPfCFrTZBvDDTpfiMyPSog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636

Hi,

> -----Original Message-----
> From: Maarten Brock <m.brock@vanmierlo.com>
> Sent: Wednesday, January 10, 2024 7:10 PM
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
> Subject: Re: [PATCH V8 3/3] tty: serial: uartps: Add rs485 support to uar=
tps
> driver
>=20
> Manikanta Guntupalli wrote on 2024-01-10 12:11:
> > Changes for V8:
> > Use hrtimer instead of timer list.
> > Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
> > Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
> > Add cdns_calc_after_tx_delay() to calculate required delay after tx.
> > Add hrtimer setup in cdns_rs485_config().
> > Move enable TX Empty interrupt and rs485 rx callback scheduling part
> > to cdns_uart_handle_tx().
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 241
> > ++++++++++++++++++++++++++++-
> >  1 file changed, 233 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/tty/serial/xilinx_uartps.c
> > b/drivers/tty/serial/xilinx_uartps.c
> > index aafcc2179e0e..3247fd3e91fd 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -193,6 +195,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-
> 255");
> >   * @clk_rate_change_nb:	Notifier block for clock changes
> >   * @quirks:		Flags for RXBS support.
> >   * @cts_override:	Modem control state override
> > + * @gpiod_rts:		Pointer to the gpio descriptor
> > + * @rs485_tx_started:	RS485 tx state
> > + * @tx_timer:		Timer for tx
>=20
> start_tx_timer ?
We are using tx_timer before TX start and after TX done.
>=20
> > + * @stop_tx_timer:	Timer for stop tx
> >   */
> >  struct cdns_uart {
> >  	struct uart_port	*port;
> > @@ -203,10 +209,22 @@ struct cdns_uart {
> >  	struct notifier_block	clk_rate_change_nb;
> >  	u32			quirks;
> >  	bool cts_override;
> > +	struct gpio_desc	*gpiod_rts;
> > +	bool			rs485_tx_started;
> > +	struct hrtimer		tx_timer;
> > +	struct hrtimer		stop_tx_timer;
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
> > +	bool enable;
> > +
> > +	enable =3D cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND;
> > +	cdns_rts_gpio_enable(cdns_uart, enable);
> > +
> > +	cdns_uart->rs485_tx_started =3D true;
> > +}
> > +
> > +/**
> > + * cdns_rs485_rx_setup - Rx setup specific to rs485
> > + * @cdns_uart: Handle to the cdns_uart  */ static void
> > +cdns_rs485_rx_setup(struct cdns_uart *cdns_uart) {
> > +	bool enable;
> > +
> > +	enable =3D cdns_uart->port->rs485.flags &
> SER_RS485_RTS_AFTER_SEND;
> > +	cdns_rts_gpio_enable(cdns_uart, enable);
> > +
> > +	cdns_uart->rs485_tx_started =3D false; }
> > +
> >  /**
> >   * cdns_uart_tx_empty -  Check whether TX is empty
> >   * @port: Handle to the uart port structure @@ -320,6 +387,37 @@
> > static unsigned int cdns_uart_tx_empty(struct uart_port *port)
> >  	return (status =3D=3D CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;  }
> >
> > +/**
> > + * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
> > + * @t: Handle to the hrtimer structure  */ static enum
> > +hrtimer_restart cdns_rs485_rx_callback(struct hrtimer *t) {
> > +	struct cdns_uart *cdns_uart =3D container_of(t, struct cdns_uart,
> > tx_timer);
> > +
> > +	/*
> > +	 * Default Rx should be setup, because Rx signaling path
> > +	 * need to enable to receive data.
> > +	 */
> > +	cdns_rs485_rx_setup(cdns_uart);
> > +
> > +	return HRTIMER_NORESTART;
> > +}
> > +
> > +/**
> > + * cdns_calc_after_tx_delay - calculate delay required for after tx.
> > + * @cdns_uart: Handle to the cdns_uart  */ static u64
> > +cdns_calc_after_tx_delay(struct cdns_uart *cdns_uart) {
> > +	/*
> > +	 * Frame time + stop bit time + rs485.delay_rts_after_send
> > +	 */
> > +	return cdns_uart->port->frame_time
> > +	       + DIV_ROUND_UP(cdns_uart->port->frame_time, 7)
> > +	       + (u64)cdns_uart->port->rs485.delay_rts_after_send *
> > NSEC_PER_MSEC;
> > +}
> > +
> >  /**
> >   * cdns_uart_handle_tx - Handle the bytes to be Txed.
>=20
> s/Txed/transmitted
We will fix.
>=20
> >   * @dev_id: Id of the UART port
> > @@ -328,6 +426,7 @@ static unsigned int cdns_uart_tx_empty(struct
> > uart_port *port)  static void cdns_uart_handle_tx(void *dev_id)  {
> >  	struct uart_port *port =3D (struct uart_port *)dev_id;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >  	struct circ_buf *xmit =3D &port->state->xmit;
> >  	unsigned int numbytes;
>=20
> I recommend to also check uart_tx_stopped() for disabling the TXEMPTY
> interrupt.
We will fix.
>=20
> -	if (uart_circ_empty(xmit)) {
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +		/* Disable the TX Empty interrupt */
> 		writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IDR);
> 		return;
> 	}
>=20
> > @@ -347,6 +446,16 @@ static void cdns_uart_handle_tx(void *dev_id)
> >
> >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> >  		uart_write_wakeup(port);
> > +
> > +	/* Enable the TX Empty interrupt */
> > +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase +
> > CDNS_UART_IER);
> > +
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
> > +	    (uart_circ_empty(xmit) || uart_tx_stopped(port))) {
> > +		cdns_uart->tx_timer.function =3D &cdns_rs485_rx_callback;
> > +		hrtimer_start(&cdns_uart->tx_timer,
> > +
> ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)),
> > HRTIMER_MODE_REL);
> > +	}
> >  }
> >
> >  /**
> > @@ -579,6 +688,21 @@ static int cdns_uart_clk_notifier_cb(struct
> > notifier_block *nb,  }  #endif
> >
> > +/**
> > + * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
> > + * @t: Handle to the hrtimer structure  */ static enum
> > +hrtimer_restart cdns_rs485_tx_callback(struct hrtimer *t) {
> > +	struct cdns_uart *cdns_uart =3D container_of(t, struct cdns_uart,
> > tx_timer);
> > +
> > +	uart_port_lock(cdns_uart->port);
> > +	cdns_uart_handle_tx(cdns_uart->port);
> > +	uart_port_unlock(cdns_uart->port);
> > +
> > +	return HRTIMER_NORESTART;
> > +}
> > +
> >  /**
> >   * cdns_uart_start_tx -  Start transmitting bytes
> >   * @port: Handle to the uart port structure @@ -586,6 +710,7 @@
> > static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
> > static void cdns_uart_start_tx(struct uart_port *port)  {
> >  	unsigned int status;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> >  	if (uart_tx_stopped(port))
> >  		return;
> > @@ -604,10 +729,38 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >
>=20
> Maybe add comment here that the following clears the interrupt flag.
We will fix.
>=20
> >  	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_ISR);
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (!cdns_uart->rs485_tx_started) {
> > +			cdns_uart->tx_timer.function =3D
> &cdns_rs485_tx_callback;
> > +			cdns_rs485_tx_setup(cdns_uart);
>=20
> Move cdns_rs485_tx_setup() out of this if clause to make sure DE is
> always active.
In bulk transfer case, start_tx get called multiple times. If we move cdns_=
rs485_tx_setup() out of this if clause, every time DE will be pulled high.
This changes were added on Lino Sanfilippo suggestion.

>=20
> > +			return hrtimer_start(&cdns_uart->tx_timer,
> > +					     ms_to_ktime(port-
> >rs485.delay_rts_before_send),
> > +					     HRTIMER_MODE_REL);
> > +		} else {
> > +			if (hrtimer_get_remaining(&cdns_uart->tx_timer))
> > +				hrtimer_cancel(&cdns_uart->tx_timer);
>=20
> You intend to stop the timer for cdns_rs485_rx_callback() here, but...
> What if the tx_timer is started for cdns_rs485_tx_callback()?
We will fix.
>=20
> > +		}
> > +	}
> >  	cdns_uart_handle_tx(port);
> > +}
> >
> > -	/* Enable the TX Empty interrupt */
> > -	writel(CDNS_UART_IXR_TXEMPTY, port->membase +
> CDNS_UART_IER);
> > +/**
> > + * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for
> > rs485.
> > + * @t: Handle to the timer list structure
> > + */
> > +static enum hrtimer_restart cdns_rs485_stop_tx_callback(struct hrtimer
> > *t)
> > +{
> > +	unsigned int regval;
> > +	struct cdns_uart *cdns_uart =3D container_of(t, struct cdns_uart,
> > stop_tx_timer);
> > +
> > +	cdns_rs485_rx_setup(cdns_uart);
> > +
> > +	regval =3D readl(cdns_uart->port->membase + CDNS_UART_CR);
> > +	regval |=3D CDNS_UART_CR_TX_DIS;
> > +	/* Disable the transmitter */
> > +	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
> > +
> > +	return HRTIMER_NORESTART;
> >  }
> >
> >  /**
> > @@ -617,11 +770,21 @@ static void cdns_uart_start_tx(struct uart_port
> > *port)
> >  static void cdns_uart_stop_tx(struct uart_port *port)
> >  {
> >  	unsigned int regval;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> > -	regval =3D readl(port->membase + CDNS_UART_CR);
> > -	regval |=3D CDNS_UART_CR_TX_DIS;
> > -	/* Disable the transmitter */
> > -	writel(regval, port->membase + CDNS_UART_CR);
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		if (cdns_uart->rs485_tx_started)
> > +			hrtimer_start(&cdns_uart->stop_tx_timer,
> > +
> ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)),
> > +				      HRTIMER_MODE_REL);
>=20
> Why do you want to wait here? Should disabling the transmitter not be
> enough?
> My guess and hope is that it will result in the current transmission
> running to
> completion and then fire the TXEMPTY interrupt which will then start the
> timer for
> cdns_rs485_rx_callback(). I see no need for a separate timer here.
We will fix.
>=20
> > +		else
> > +			cdns_rs485_stop_tx_callback(&cdns_uart-
> >stop_tx_timer);
> > +	} else {
> > +		regval =3D readl(port->membase + CDNS_UART_CR);
> > +		regval |=3D CDNS_UART_CR_TX_DIS;
> > +		/* Disable the transmitter */
> > +		writel(regval, port->membase + CDNS_UART_CR);
> > +	}
> >  }
> >
> >  /**
> > @@ -829,6 +992,9 @@ static int cdns_uart_startup(struct uart_port
> > *port)
> >  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
> >  		cpu_relax();
> >
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
> > +		cdns_rs485_rx_setup(cdns_uart);
> > +
> >  	/*
> >  	 * Clear the RX disable bit and then set the RX enable bit to enable
> >  	 * the receiver.
> > @@ -888,6 +1054,7 @@ static void cdns_uart_shutdown(struct uart_port
> > *port)
> >  {
> >  	int status;
> >  	unsigned long flags;
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> >
> >  	uart_port_lock_irqsave(port, &flags);
> >
> > @@ -903,6 +1070,11 @@ static void cdns_uart_shutdown(struct uart_port
> > *port)
> >  	uart_port_unlock_irqrestore(port, flags);
> >
> >  	free_irq(port->irq, port);
> > +
> > +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> > +		hrtimer_cancel(&cdns_uart->tx_timer);
> > +		hrtimer_cancel(&cdns_uart->stop_tx_timer);
> > +	}
>=20
> Should you not do this much earlier in this function?
We will fix.
>=20
> >  }
> >
> >  /**
> > @@ -1032,7 +1204,7 @@ static void cdns_uart_set_mctrl(struct uart_port
> > *port, unsigned int mctrl)
> >  	mode_reg &=3D ~CDNS_UART_MR_CHMODE_MASK;
> >
> >  	if (mctrl & TIOCM_RTS)
> > -		val |=3D CDNS_UART_MODEMCR_RTS;
> > +		cdns_rts_gpio_enable(cdns_uart_data, mctrl & TIOCM_RTS);
>=20
> Move this out of the if clause so the gpio can also get cleared.
> On top of that it should be inverted.
> But if there is no gpio defined this call will create a glitch on the
> RTS pin.
> cdns_rts_gpio_enable() can set CDNS_UART_MODEMCR_RTS to lower the
> RTS
> pin and
> then val will clear CDNS_UART_MODEMCR_RTS again leaving the RTS pin
> high.
> I suggest to use this instead:
> 	if (mctrl & TIOCM_RTS)
> 		val |=3D CDNS_UART_MODEMCR_RTS;
> +	if (cdns_uart->gpiod_rts) {
> +		gpiod_set_value(cdns_uart->gpiod_rts, !(mctrl &
> TIOCM_RTS));
We will fix.
>=20
> >  	if (mctrl & TIOCM_DTR)
> >  		val |=3D CDNS_UART_MODEMCR_DTR;
> >  	if (mctrl & TIOCM_LOOP)
> > @@ -1455,6 +1627,42 @@ MODULE_DEVICE_TABLE(of,
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
> > +	struct cdns_uart *cdns_uart =3D port->private_data;
> > +
> > +	if (rs485->flags & SER_RS485_ENABLED) {
> > +		dev_dbg(port->dev, "Setting UART to RS485\n");
> > +		/* Make sure auto RTS is disabled */
> > +		val =3D readl(port->membase + CDNS_UART_MODEMCR);
> > +		val &=3D ~CDNS_UART_MODEMCR_FCM;
> > +		writel(val, port->membase + CDNS_UART_MODEMCR);
> > +
> > +		/* Timer setup */
> > +		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC,
> > HRTIMER_MODE_REL);
> > +		hrtimer_init(&cdns_uart->stop_tx_timer,
> CLOCK_MONOTONIC,
> > HRTIMER_MODE_REL);
> > +		cdns_uart->tx_timer.function =3D &cdns_rs485_tx_callback;
> > +		cdns_uart->stop_tx_timer.function =3D
> &cdns_rs485_stop_tx_callback;
> > +
> > +		/* Disable transmitter and make Rx setup*/
> > +		cdns_uart_stop_tx(port);
> > +	} else {
> > +		hrtimer_cancel(&cdns_uart->tx_timer);
> > +		hrtimer_cancel(&cdns_uart->stop_tx_timer);
> > +	}
> > +	return 0;
> > +}
> > +
> >  /**
> >   * cdns_uart_probe - Platform driver probe
> >   * @pdev: Pointer to the platform device structure
> > @@ -1597,9 +1805,23 @@ static int cdns_uart_probe(struct
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
> > @@ -1618,6 +1840,8 @@ static int cdns_uart_probe(struct platform_device
> > *pdev)
> >  		console_port =3D port;
> >  	}
> >  #endif
> > +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> > +		cdns_rs485_rx_setup(cdns_uart_data);
> >
> >  	rc =3D uart_add_one_port(&cdns_uart_uart_driver, port);
> >  	if (rc) {
> > @@ -1646,6 +1870,7 @@ static int cdns_uart_probe(struct platform_device
> > *pdev)
> >  	pm_runtime_disable(&pdev->dev);
> >  	pm_runtime_set_suspended(&pdev->dev);
> >  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > +err_out_clk_notifier:
> >  #ifdef CONFIG_COMMON_CLK
> >  	clk_notifier_unregister(cdns_uart_data->uartclk,
> >  			&cdns_uart_data->clk_rate_change_nb);
>=20
> This is getting big and some modifications are not rs485 related.
> I suggest to split them and get those applied first.
> My first modification would be to add support for the rts gpio.
We will fix.


Thanks,
Manikanta.

