Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084237D9896
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbjJ0Mlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbjJ0Mla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:41:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2111.outbound.protection.outlook.com [40.107.20.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B7DE;
        Fri, 27 Oct 2023 05:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU+xA2977Vb6ferH0CkRzGqIs5ZppI1YJBVSUayMCcuVW3Nmt2SyJjtzGildSZCTPFbWhGNxVr4sTpY1a0mF+NkyG6Nv+NoyC6D7hepXoDFYHoinPYmGVeeF4nLXuni3hCB91bqaix0nAE2uZzVIC6EpR2UR8Xw00I8URBki4QWvQIofmFlo5uHFhpDhHEdcA5n6aAoAEpTzU7uUillzl/W1b6X3chEsMUWVKrqx5vI8EpX9rbxzMgxrH5FPfsYDLsVtbToa2Onio/5r2qrXLtk82W+eJGrDKN0ED9o2xJhh9kkt8BBhRDriCmMenT7NSZgc53TKT5PALgnII3CMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy1IyN1qGx1tnAs9vhsmG9RkW9Ek2LlyjeiYzEfkyQo=;
 b=LPIDY2iLla4uGCA+W59eQ3JC5xYLAr5niPsSJcGEpW48hkD2OgEqkGRkTNIcD2fHLpGontdGYNE+tuAs5EYXVInNijUsKepT4XE3VBQrmF7HYPG3W+S/dgFxXWFdep8rLLdtDvp8sHA8JcskiaGYBlz9osWrFVj5q9eBXJdXhOqRGstvDJKm4y18gXtZebeVJZkSZlTq/VwpO5IXkku5r947oJ6BYECdPjwe8P9qdYj/DrkeKVCTiOhg2FhkKHZC/p/nQf3VD4Z8WJQr/RoZsqxheeH8KgKhK9Z2jqZYFY4jorgEzWsq/DZ226zZ0Jlg1fworiYtWGsgZ2gtklCwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy1IyN1qGx1tnAs9vhsmG9RkW9Ek2LlyjeiYzEfkyQo=;
 b=GNCjyhEir1paUV6WcASmPa/sgoaLQ/tQ3EyLhtz6V5HV0yA/NLx9+gNJuSyD+JwpLOLwKMrW7xH7dWGS9VUhMDpAzEJuFglVP8ghlLWJa8qmMueBMv/HkSJ6WVEr28M/dKd6pPMj5j/n2OjBQeitaS6mHBJMzIgSHcTWuXdr99E=
Received: from DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::10)
 by DB9PR10MB5690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 12:41:23 +0000
Received: from DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b9ed:5aac:1984:3013]) by DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b9ed:5aac:1984:3013%2]) with mapi id 15.20.6907.025; Fri, 27 Oct 2023
 12:41:23 +0000
From:   "Stoll, Eberhard" <eberhard.stoll@kontron.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        =?iso-8859-1?Q?Leonard_G=F6hrs?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: AW: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Topic: AW: [PATCH 1/4] spi: Add parameter for clock to rx delay
Thread-Index: AQHaCCByhlFLq4Q3qUiFonGDuLJz8bBcrx+AgACFHbCAAFIEAIAAAyig
Date:   Fri, 27 Oct 2023 12:41:23 +0000
Message-ID: <DB9PR10MB8246A77EE4E7140E845D82FAF1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
References: <20231026152316.2729575-1-estl@gmx.net>
 <20231026152316.2729575-2-estl@gmx.net> <20231027005643.4b95f17e@xps-13>
 <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
 <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
In-Reply-To: <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB8246:EE_|DB9PR10MB5690:EE_
x-ms-office365-filtering-correlation-id: c0044cc0-d289-4167-4e62-08dbd6ea074e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRiZCAZxfk9hR5hKbdlDFHdQSF9C4XC1JWBL5iB0afV7tUxtaQ37FcwDjE6lJzJFofeqsnMRhpx+tXbS0liARFb5nUaEkeqsDTDFi4Khe8vJNI1sUb63FTCGpB90r9UPc4VdCVc1q1Wjt+I3GevSaBfMDkPQ8AT2tcT3VOllPkqj9uRz66/m/Giu1YAqqNUmhmu8w+lBWxq1EXBqz/UEJdci/AMPaOnJEz3yCS9060MGJW9JAQ8IKO/cKS3Q8uP/hEBSkSvfIInGd2nB9qDjsmtXvmPttSaocx7Wg0yNYqKubBI6lSPlnhA1qO7gpWuTfRGAKLJ2xj5Pr/ngh6Pocfy/WZL5ZG+1B/MUeYu1fxynUdd3Bbiwj8x1XuiZcKvNHCdaPvKhunMkqwvMsXBFO9BqetwM4glgMxj09E28LCwbQBGU3N9SEnN/pbheSQa/XccjpZfBWrRK1dSujweXGZO6Nc/tx8LE55FLVWCiGMkvHSH28b9EpUQZ8SPX6qQxWjDq9sMmhaaf7UPCUEzdc2x7+qbe1wJp05a7tc0siFmK8bHwnUA6ok/7XNBxBo/U1mMSzZkHYn/htjZi3xDLdu05arOTOsMVmjiyBCsMGw57KPyzeNb9d/3W3HbJpOzF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(9686003)(122000001)(55016003)(5660300002)(38070700009)(8676002)(8936002)(4326008)(6506007)(66556008)(66946007)(66476007)(76116006)(54906003)(64756008)(66446008)(6916009)(316002)(478600001)(7696005)(71200400001)(52536014)(86362001)(38100700002)(33656002)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/EL1TkmJzP35g4sFBRzrQCfZJ97uF+phvxDK+rIIVkXCKubhNUmOxlyjBW?=
 =?iso-8859-1?Q?jUAaceYenG6xwo39sH8rOzNKHrxBvCDcVMc+JCJRfyfFfg8TN1GB8CtiOp?=
 =?iso-8859-1?Q?pFqnOS9OyXzy8/CDbaEHDvg9isYA1Op1fFRxEwl1pzDaffXmgr8xmP3sKz?=
 =?iso-8859-1?Q?ZjORC/P2lclvMV95cs/sJnQ8n9ycHxZBiH+NHHEGyBkYnAhWHpTkHh4lX3?=
 =?iso-8859-1?Q?QFfh7qalpuAFrZN5vuB8fEZfLQaFPDvsUaUNGizmHxF2y8Rk4hzVRSMQoo?=
 =?iso-8859-1?Q?GSXu8ssyndPF0dj6QYc4Pnbw4KH78AcxotE7gfVDXtooYt+HyxKlRrHVJo?=
 =?iso-8859-1?Q?xhq/yVmRK2k8wtkPc5H0ZYI1uz2ntS5dKU7Oi5cPuFSivOYA/o4GOBhwth?=
 =?iso-8859-1?Q?mqCRCungp8VZsgGkC/Fx8+OJ2harBIR3q8nXbdHskLmauWADbg9CQNF2FB?=
 =?iso-8859-1?Q?MI/t1SXFGzm/+FZK2M+Wl3jn76jQCy1EXc6Ho2Vhcg+mPhFh20fnzXId8c?=
 =?iso-8859-1?Q?zoULM9NCTWI5lwRmx1KPY/8RI73nYoCzmfeK0/HwO4WrjsmXOBX4iv1Z28?=
 =?iso-8859-1?Q?71vd57/Xu6BvCMsawa4Od2MrroEGV90hArqywaX4BwBX/c5p0DuO4BccU2?=
 =?iso-8859-1?Q?i5B9nIImDJP3HUhPD8qxZK5ET2mTnDvW5bt2xJDEb5cjnFUGPu+j36OnKd?=
 =?iso-8859-1?Q?DYnBFvz9EtNNCHNVydnvANClX1YaI7HeaAhFaRQcawF3BmPBmbsirHupSf?=
 =?iso-8859-1?Q?ZhpTzp6UcnwOCMor6KkRzoz0V2/WRJeUXCZessWW27a1LSaQ96mvPvC3C1?=
 =?iso-8859-1?Q?xQcBsAGhE7fUCRIrYr9W0+4DOf527BruwkjXbUb+t8H6YtSKqtLC4SfEyc?=
 =?iso-8859-1?Q?kUVPwPKhbwQ2J3eBikfhjRLOnbJlUGt6EPYfwnvI+0pqY/4XBFw3HNQD4+?=
 =?iso-8859-1?Q?3NUePXJoN1WD8usIi5z1IYqi+LymTvhIESHrYgewjxVeMFVTH1zBd1dDhv?=
 =?iso-8859-1?Q?S+FQw8DZFzG4P+f+I2f5bCosSSljHO6EfwDgPcfXvAOmnxDRqYh3FDAvmt?=
 =?iso-8859-1?Q?MyjDQkqoZjKunQBMbI3HGbuuRhAqff94lWVwK/PftO77WiS/UVFQKa844B?=
 =?iso-8859-1?Q?yu9diXtv4XtmuoGFVjI/UGNY1OGG+AnwKiZkJVE9KTsxH/sV9Q1+Yr2oQM?=
 =?iso-8859-1?Q?crgIfXJarHHcje6mU/CkC389NZHHwjRp6C6s25lP0ilFKfxtLU6bDYoug8?=
 =?iso-8859-1?Q?GC+pTPLxHKfCv4QGOum4tz+t2GpACAV0AzHvJIGZVEtitz3tGzwnIIDUCF?=
 =?iso-8859-1?Q?/G9Yco6ISVNa/UQrae4+tOOk0EMEYzM0FYiED6i8Orrn7HeeOPSb1WaUd/?=
 =?iso-8859-1?Q?UHZrmq9ru9jt/LojbCC0esb7nLawUYep7ciBxdcJ4YSgWh7V6j4eVmILfs?=
 =?iso-8859-1?Q?05EX0XT3uc2VVYmUWGrSN3N3v3pISBtQKUhxTIvHZM981kuSW4WatndHB/?=
 =?iso-8859-1?Q?AfvbFvS21MFWA6NNIMOyjfQ+TfDOMIAwAnne/IrdzrdSJkdhA+830yazHq?=
 =?iso-8859-1?Q?yfbdLSrYbdu209dlBEkh8sFNes2D0uaQS40likFmrdfEqn4+7m0jOWA1Qn?=
 =?iso-8859-1?Q?sMPWziX3mZuBULcO7uCHoKnxM3eujDy9R1YkOfNq2VxbaTn880E1pGwJI/?=
 =?iso-8859-1?Q?zLjbBnmBXojyIjihsJq+cH5vaTHggC1Fp2tM6Q3hfk96e8Y2z4yZ2/PHj/?=
 =?iso-8859-1?Q?9QVg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c0044cc0-d289-4167-4e62-08dbd6ea074e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 12:41:23.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtZiI4cIVTSiD5m9D3Ibhbq+l44rNNe4mNocBXdWUQ93lXBYrv3oeixHLX/0j0Q4r6T3WOeiuVswOueDNHN14PU19RZqwjXccQgzSDUrd1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > > Can you be more specific? I am wondering how big the need is.
> >
> > In our case it's a QSPI NAND chip (Winbond W25N02KV). This device
> > can operate at 104MHz SPI clock. But it also has a tCLQV value of 7ns.
> > The tCLQV value limits the SPI clock speed for this device to 2x7ns
> > (if it is not adjustable in the SPI controller) which is approximately
> > 70MHz.
> >
> > Without the ability to set the tCLQV value, the SPI clock has to be
> > limited to 70MHz in device tree for this bus.
> >
> > In our case the Winbond W25N02KV chip is a replacement of an
> > older chip. The older chip can operate at 104MHz and does not
> > have the tCLQV restrictions as this new one.
> > The new chip is mostly is better than the data sheet and meet the
> > timing requirements for 104MHz. But on higher temperatures
> > devices fail.
> >
> > In device tree QSPI NAND chips are configured by a compatible
> > property of 'spi-nand'. The mtd layer detects the real device
> > and fetches the properties of this device from the appropriate
> > driver.
> >
> > So for our case (boards containing the old and new chip) we well
> > have to reduce the SPI clock for the entire QSPI bus to 70MHz, even
> > for the elder chips which can operate well also with 104MHz.
>=20
> So, to me sounds like device tree source issue. I.e. you need to provide
> different DT(b)s depending on the platform (and how it should be).
> The cleanest solution (as I see not the first time people I trying quirks=
 like
> this to be part of the subsystems / drivers) is to make DT core (OF) to h=
ave
> conditionals or boot-time modifications allowed.

We don't talk about device tree modifications on boot time!

Currently the SPI NAND chips are not fully configured in the device
tree data. Today a QSPI NAND is represented by an abstract 'compatible' ent=
ry
of 'spi-nand' in device tree. Which can be seen as something like a 'spi-na=
nd'
bus with autodetection of the connected chips.

Therefore there is no way to reference a QSPI NAND chip directly, it's
auto-detected by the framework. There is also currently no possibility to
set the tCLQV parameter for a single SPI CS line.

Some parameters for the SPI NAND chips are already provided only by
the fitting chip driver (e.g. flash layout, banks, variants of the command
set of the device, ...). With this patchset it's now possible to provide al=
so
the tCLQV data for this chip.

IMHO a autodetect system does not make much sense if you have to provide
parts of the chip configuration also in device tree. The framework should
detect the chip and fetch the operation parameters either from the chip
itself or from a chip driver which provides the required configuration sett=
ings.

Best Regards,
Eberhard
