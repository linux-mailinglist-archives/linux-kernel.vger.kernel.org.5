Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231D7FD831
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjK2Ndo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjK2Ndm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:33:42 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4159FB0;
        Wed, 29 Nov 2023 05:33:47 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATDUfc4009083;
        Wed, 29 Nov 2023 05:33:32 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3una4dntd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 05:33:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwbSpuXnQXZ+zDEdyuF+6e0RrNaSs+XAN/JHvORNjLaRe+dEB1IBUClW4Za7n1Z6I1UcfLyF+LHTYFv8XEIPH/0RoPlSuy3tYstraYENKowd5a3G86DOdgwUHYm9Et8OysamtkzIoM3n6esNlzMqOyyTfpXwk/gzVWQadyedQm+Kco+aPkNmiskwbgIgGs+VM1xHHTB/XbbZswsDEkbuhZ/QsGGchRbD81t4BvEncBwYYC1YpbWVuKrRK0rwjri/+fn31joAB1/jGHU/E3Hp2EGOynabSXRTNu6WFbhloHSyNpdAW/HtHemBYzMlf2BEkmatOm95guHMSwo6EUzQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGIZm64XrPGUvS4dBPByFEAOcNxFzOzCwhg60QIo0MI=;
 b=mQXSavisA04m7oi13fkAPOT1GVXmj5u0z8MfEWudQxQXwYzdosgaiuHAzvNB/vWew+wBzuaRnLW4RuGLlGsbMF8fO0PiiMhBhXJ4Y2wurtYlA7QNqbWjxnyFXiqLurjB689l1dXY1L1Xf2FVrUzt00OXenf7SZJeHoVF5ptkmlhaPsKFBcop1XEXIm4RzK/Ls8kMlo+ZrZTrGj79gdHmptghMRB/WZrjr901FCw9o5qlCoNkYxNf3SAWY3Z3/cEpvczX370uPlMkGYbRIEcqeLkTS9dWd1PhOmqpfScg9rPWA0pu2uorHDeBDn0Yj+O+bHc5Gapfec5E8qBb00R3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGIZm64XrPGUvS4dBPByFEAOcNxFzOzCwhg60QIo0MI=;
 b=IlYrGF3YLfErYeFgNnse10U5weZlW/YhuNVPtfJQDxSYEMQYL+Vl8Gqq3swLoaBXqlW5klX30pL2RB1mBrKZ07XlJxr4Ju4OFW5vm+DgwvclOyPzXy+PT+TvArROb52py10iODV1xqLlpu7BzfUyJYSh735NaFWn6NXjGxkc740=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by MW4PR18MB5133.namprd18.prod.outlook.com (2603:10b6:303:1b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:33:29 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632%6]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 13:33:29 +0000
From:   Elad Nachman <enachman@marvell.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "mrkiko.rs@gmail.com" <mrkiko.rs@gmail.com>,
        "chris.packham@alliedtelesis.co.nz" 
        <chris.packham@alliedtelesis.co.nz>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Yuval Caduri <cyuval@marvell.com>
Subject: RE: [EXT] Re: [PATCH v6 3/3] arm64: dts: cn913x: add device trees for
 COM Express boards
Thread-Topic: [EXT] Re: [PATCH v6 3/3] arm64: dts: cn913x: add device trees
 for COM Express boards
Thread-Index: AQHaIWU9yr1UOWxDQke0cEhQKWxs3rCOwMEAgAIjrqCAAGPtAIAAAPCQ
Date:   Wed, 29 Nov 2023 13:33:29 +0000
Message-ID: <BN9PR18MB42518F800E98ECCB94D620B6DB83A@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20231127190857.1977974-1-enachman@marvell.com>
 <20231127190857.1977974-4-enachman@marvell.com>
 <35f98bc2-dc26-4441-8ed3-1ecce582d0d2@lunn.ch>
 <BL1PR18MB424884AB9E0D8E8BF4AD1926DB83A@BL1PR18MB4248.namprd18.prod.outlook.com>
 <349b4240-8e5c-4afb-ace8-913f213a537f@lunn.ch>
In-Reply-To: <349b4240-8e5c-4afb-ace8-913f213a537f@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|MW4PR18MB5133:EE_
x-ms-office365-filtering-correlation-id: f84c05fa-e5a0-4dfe-85ac-08dbf0dfc630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1I9gObhC7/K2t51QIP17+Gs90Xt0zRwZmw/qy5OxXF8QieA+yrZv95maNxsWTDLH/AC8b6Td7ntv2Nqai1a8AAij3uCPSTRyj3BqDCtQNBXRFvExMQbC3809mqFnJ3A4S7qVoRmyAX+mf0vJqdwoL5jkvmA7OhPCvNPhxEORHk3pn/JUKsAgvEbgXK5OB/c1VVfwldpi0Mn6NPW5z6Viso0NyI1UdRs8Jq/9pCI+2aSGkMnONJCzq6DgrRFv6s/Khz9XCXHEcndraQcOybQosOI7652wy8zPWhZaP7xDNb1gp8dBzfgdRbnsDdfSo5difajYZvXuUlyNxXL37KBMwn/38px1zW/EXI8tRfkrb4IJXELVht/3pemKZgCGX320F2woIJ2e1cbG5i2g6QCdLc01+TbquyaCF4mOBK4d/NR3GUpIH99e/yMJBn3DpUkl0oznj4/O4Zsy6x1NI0D4YrgoK2O9ncjWiXPmjRQaYp0zPpMk99vHTdFaXZEjcS1rD9MliacT5tJMSSNlte8Lc/BGOyXbFf4GViYslD5N0DOtYTQGv+EkjHNErxXeI7s4qo0WEV7uFsvs+Tndrswp1ywgl/94F+N3cdWbRFRsOx9TegCYGn+K4ZhqM9V/7Q6nfknCnRNHZXIEsPgaQ2s3zM5Hn2YeYO4q6U230r8T7D8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(55016003)(122000001)(38100700002)(83380400001)(2906002)(86362001)(5660300002)(8936002)(52536014)(8676002)(4326008)(6916009)(316002)(7416002)(66556008)(66446008)(66476007)(64756008)(54906003)(66946007)(478600001)(71200400001)(41300700001)(7696005)(6506007)(9686003)(33656002)(76116006)(53546011)(26005)(38070700009)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4I7lieRz1cpoa88EeSpg3ppBAPkJfBAL45GHTp2xA+++CmjF7X2IYt6eGN9t?=
 =?us-ascii?Q?RSzQ9alcjpQKvQKro9Dlb6lqlL05CrJPaCnyWlWhqaBlIAm+ei6loZhRfzqK?=
 =?us-ascii?Q?KZrLLncDrwFeNWyraZLthhlv6N7HYDcwQHCsh6rhio6Am2T497OIiASMQ3lI?=
 =?us-ascii?Q?K7/4Bp4ZklhHyqEV6wUA3vuK1pqvUFe1NR7U0B0/kM6JOvx8PnvY0jC/Bh2P?=
 =?us-ascii?Q?dQn8FNYJp/jFEjviThMg6yN8ulvA4ltO43NyJSc+8YkWY2VlvDKKgfVlmuDL?=
 =?us-ascii?Q?Kgolb+RJY1Rhtkaho3ZhOB1W7RWw8OSGxO6NXsVtyy+JOyjoap6+OJSOovuB?=
 =?us-ascii?Q?cag5MI2fTF8siKfrpuVLoHyA0V2bdB70ulY9qvy3CiVtfdYGJs7kUmpVNLOV?=
 =?us-ascii?Q?yjkDhtcw7XDheouYLTCbc+iqKg6AGLfhlbQZ6nognN9GIgqAKWkwjtfWdq87?=
 =?us-ascii?Q?MwxFmfQZHjEI3NMRiMfdgsXGebkiT1ir61+n/wzZ4qtz5hX4gv+JrOKelJMX?=
 =?us-ascii?Q?0R53Hx/nUL+4c4fTgEtKqlZr8XWQX4dHsGZglMf9P/nyCKjpMPp8pm/nkfNT?=
 =?us-ascii?Q?vWKmzvoMUqksWi2WaEk8OxDqEWz0DlQIqD75bZFFMLe1pm+569uU+A0THw2Q?=
 =?us-ascii?Q?9IrPBh4s25MrNMib+hq5uv4UKHw/xsPIMKRWt2VZOBaKenz+EYQndoufIsW+?=
 =?us-ascii?Q?KCAcXrQT7bT4xi2V1TqMjedYGA9mUGJK8SIB6DDk0MtnkCihMYWRlHRAL4pm?=
 =?us-ascii?Q?0ymEIFOihRntNEyG6nLQBTqwzcE/OY8ynrvZaG+q0rEi/BBuFzCoxxJ2lQZn?=
 =?us-ascii?Q?JgbgBMc58WmN9lOBaBwRzqhagGiBY2xp9Mjjd6gyPV3oT0vyvQnIbf6tPQ5Y?=
 =?us-ascii?Q?52j6WbhpyqamxPV+ogeHGjwvozyApvG4HHd9XNzC+cxNHy4YvGfkZTQ6RkdX?=
 =?us-ascii?Q?G/x1Xeuw6Wqa/Q7ZxfeXFFzqTiPZS/ILZ/1ttOSHS0BBXQizJb10MPaLJvat?=
 =?us-ascii?Q?k97yzlnrg9CwCqmhVhIHxHuIrNTSvOKRYtYAaMe4WaJUmCEKMgVtBpDJByFE?=
 =?us-ascii?Q?Dgu0neWRDISAelpiPQieWpZ2NXKFOuMv9ah35gM42So0+tQDMgMkpRXkS4lc?=
 =?us-ascii?Q?BHJY8QdEOXw+f/fV81LdeLjdD1jzJds4o2wVETET6deWmgFEEnVK1Nmwzlz2?=
 =?us-ascii?Q?y/hFrta2tzIZ18cnpQhyRyk1jD/wl5UaJBPSgACQoBvIOQbe+RUYSj8xoc9X?=
 =?us-ascii?Q?WIuBIZ5nT2FlyEXU/jOTEvqBgA4S31qqmf43lH5EdML0K+xkG8VGZA6j6YPN?=
 =?us-ascii?Q?ODP6kh14gx/FrMmVKbn/+QhT4pfS4ZcKEEuTtKr+IQFGQucTSMGMoGO/8nj8?=
 =?us-ascii?Q?1ESzhzmPTVEG1gB7NY+wY5aNMRBqep+DM0Dt4CZlN7brJuD+B87pEhbZIrKf?=
 =?us-ascii?Q?AXf3f0AZUXaAXD44ZP37e0nrFYHqjIKwVTnve0QMnSJr3qZCTRkXjWlvkWki?=
 =?us-ascii?Q?6BfERTOEj+tY7O02JKcwdsWf0f/Lg7w0pbWS0xogWMxCzbqDdp8H6OQDEsI0?=
 =?us-ascii?Q?laC2O5C9iDgmicNJbKVdSitbKCc9vuzw2K56aBqq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84c05fa-e5a0-4dfe-85ac-08dbf0dfc630
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 13:33:29.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+g5UgbdogRTf/2exSm4016f+Xef+NxAF5BATJNPyUZOG7M+5l2KG1ItD5lUVXUkzMR2jbYGUEidNZ6MbKfsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5133
X-Proofpoint-GUID: 8gXtJE5trFyrLq1A-v0kmQmRAIYn4vHE
X-Proofpoint-ORIG-GUID: 8gXtJE5trFyrLq1A-v0kmQmRAIYn4vHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_11,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, November 29, 2023 3:12 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; pali@kernel.org; mrkiko.rs@gmail.com;
> chris.packham@alliedtelesis.co.nz; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Yuval Cadur=
i
> <cyuval@marvell.com>
> Subject: Re: [EXT] Re: [PATCH v6 3/3] arm64: dts: cn913x: add device tree=
s for
> COM Express boards
>=20
> > > Now i'm confused. What does rd mean?
> > >
> > > I would expect RD mean Reference Design, and that is the complete
> > > device in its box.
> >
> > AC5X RD can either work as you would expect, as a complete standalone
> > box using the internal CPU, or you can move the switch on the back of t=
he
> > box to "external" mode, and connect via an external cable a kit which w=
ould
> > allow it to use an external CPU COM Express module, mounted on top of a=
n
> > interposer kit.
> >
> > >
> > > Yet, here you have RD for the carrier?
> > >
> > > The box itself is called cn9131-ac5x-carrier?
> > >
> > > This makes no sense to me.
> > >
> > > Maybe i'm understanding this all wrong, and its the carrier which
> > > you are producing a reference design for? The CPU module does not
> > > really matter? I
> >
> > So in this case, once the switch is set to external as explained above,=
 the
> AC5X RD becomes part of the carrier solution.
> > This is a development/reference solution, not a full commercial solutio=
n,
>> hence it has the flexibility to be configured in different modes of oper=
ation.
>=20
> O.K, now this make more sense. Please expand the documentation, in
> particularly the carrier, explaining how it can be used, and the .dts fil=
e about
> it giving a complete system, but again the carrier is the focus.

Will add comments on the dts and dtsi files on the next patch version.

>=20
> Is the internal CPU open? Or is it a black box which only Marvell Firmwar=
e
> can use? I'm just wondering if we will need another .dtsi file describing=
 the
> internal CPU, and a .dts file which includes both the carrier and the int=
ernal
> CPU .dtsi to give an image you can boot on the carrier?

When the board boots in the internal (standalone) CPU mode, the following d=
ts, which is
Already upstreamed, is to be used to boot Linux on the internal, standalone=
 CPU:

arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts

When the board boots in the external CPU mode, the internal CPU
is disabled, and only the switch portion of the SOC acts as a PCIe end-poin=
t,
Hence there is little use to describe a CPU which is disabled.

In this mode, the AC5X RD carrier portion only provides a non-CPU PCIe end-=
point to the
COM Express CPU module (in this case, containing the CN9131 CPU).
There is no CPU booting in this mode on the carrier, only on the COM Expres=
s
CPU module.
What runs the Linux is the CN9131 on the COM Express CPU module,
And it accesses the switch end-point on the AC5X RD portion of the carrier =
via PCIe.

This is briefly documented (will elaborate further in next patch version) i=
n the following file covered in the patch:
arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi

>=20
> 	Andrew

FYI,

Elad.
