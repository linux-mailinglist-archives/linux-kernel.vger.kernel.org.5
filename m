Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C307FD00A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjK2Hlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjK2Hlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:41:49 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378CB1710;
        Tue, 28 Nov 2023 23:41:55 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5mUE4021197;
        Tue, 28 Nov 2023 23:41:27 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3unn86add3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 23:41:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQoP5DzTvfvwmAvMWl462C8zFyugkatJfal1ufj3u07I9x2lio1KE/2+uEaop5qASLuL+x02g1Ho18bLWfTPBRoY88ZMUuAOQeE7AVPHDcaPQwKo5/KwKCsyJL6e/QyxpqmbtX81760GeYg0GK5mpCzIRUoWiPUshbjoF7w4dpE7kQPdhflaIEMB1TuhuJMRLls67qnkacc9y6rHmavyuZYtDLLCnG0X2KsEdpBOM9mdnDs4nCr61KIAyY9v2OIY+3AN9dvzvVjzjR4c9EyCOJd7NEQo0HtVcS2eSgi5Gj2uGaokyrQ/cvsQiHwIwVsPLv3Fs0Xdx5M1aQ/sazo+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BaE7QkwAblCRYm9VTTxoxy1aPDmzfvw5hOLRwsuCHA=;
 b=Y1HX4ZN0cndRHv7RtjWOcvXwm11gJRMZ9ZVmmFF977sm0L+5OZv8wjqAzvdk5AroKN6/BWn6SfVfK++bVXyk3mhcl+Av1emr5p70ch03vSFxDWaWuhgVhuG33xV78V7noB5LgxVkzJuXnsAmMq4UbfpqgjbwrIgfqZW/kQIz06ElMwTFoL7xH0iijc3mgEedQbctATsf2gqLfSwXqZzOyAOe1NR/ahhGYA9xoCLJUzbIySSgQJCltPwRWFYdJ8toCA+d2bYyYiErQgFmNf7Un8JUs6QWSvKRmtPI2PMEW4tPqCcKSVtKImqfT1mdLe/Jvdjq8FrIs/vw34PHnA4V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BaE7QkwAblCRYm9VTTxoxy1aPDmzfvw5hOLRwsuCHA=;
 b=N7XDvxLRCUZc0aAwsQSdqC6r8bj7hPlFhenwzuLEx1AlGt90q+qqv5E0TiAmpcj8Q5TI6ynFoLy6T1jIR3JZzPgYUbDj/2HaAb3Rk9PMphxDqsyFFCN+8LN2gAJbeDpJYlOONej3PCWgyijCBlDn09/7hWJ7W21TDSEURA3hlZQ=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by MN2PR18MB3591.namprd18.prod.outlook.com (2603:10b6:208:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 07:41:24 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::9db8:8487:fecc:c862]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::9db8:8487:fecc:c862%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 07:41:23 +0000
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
Thread-Index: AQHaIWU9yr1UOWxDQke0cEhQKWxs3rCOwMEAgAIjrqA=
Date:   Wed, 29 Nov 2023 07:41:23 +0000
Message-ID: <BL1PR18MB424884AB9E0D8E8BF4AD1926DB83A@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20231127190857.1977974-1-enachman@marvell.com>
 <20231127190857.1977974-4-enachman@marvell.com>
 <35f98bc2-dc26-4441-8ed3-1ecce582d0d2@lunn.ch>
In-Reply-To: <35f98bc2-dc26-4441-8ed3-1ecce582d0d2@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|MN2PR18MB3591:EE_
x-ms-office365-filtering-correlation-id: bc65aec5-11a6-419a-e2c3-08dbf0ae9642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5MSi5WZU9DPEjr+9NbZ0TD/aUMX+Yj4XV1Z1fudlQ34/VIJXKYKfu2oegkq21XrP/6oc3i9Hl9pYh0rYJjilRd3NwxxiKF6f6jjv4ceBomU+LLGXN7wbq9Yl5EOOd0bF5WNAjHREHa+TEADrYfotMVRdAAvsJZRe1/cADfBWUIA78o6g6fk7DIhNJpN1tPOiTzEXScF3vPw3n0GpmrklC59O3UqDQzoaiXhaR0Cyr7FZSYc6uNlmo4JzDnf1EOsGe8JhzATAJG1xE+oxRjom3TSOU24ZEU+crFDHwaAstsbz8ejvBZCdd289Y9t2dmWY0xXNXtNWpw8LXbkMC7i7aRgoPPdR7aW6eZSkDwBLIvg409qVNcFMTTg+b6fwwOqO8oHCoVh0VpksLQToW7LuHyd0SHPSSb2RrWn6kF6Uivp8EuLqx93FgzrRsrnCrK21SiDF2HJLXPNc4yUbC2hw0GpRYOw8ypeH0fcObrrgFphBsh8sgnzWs2TWckXH3xmAUPYd0R9BSg1h37p6ILFPTIC+yHqhqeS7ou1wMy2tAXtMqSQwREGQMbmTwKtSMTEGJONsmI6al/Fw1AnMLHF3P4q+6fSBTKup4CcPyi5l7Y1wxYQYhPzki+x6lbJkdQc5gxO8AObbe3hn8QVjNbUR97MYbiCbF8PoHoLR2l1Kes=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(55016003)(122000001)(38100700002)(83380400001)(2906002)(86362001)(5660300002)(8936002)(52536014)(8676002)(4326008)(6916009)(7416002)(76116006)(316002)(66556008)(54906003)(66946007)(66476007)(66446008)(64756008)(478600001)(71200400001)(41300700001)(7696005)(6506007)(9686003)(33656002)(53546011)(38070700009)(26005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gO2pec0bL9YhR+3jMcw/E6MNfM3cctL+XbPVeFdHzk4ydPUk5pbqIQ/zI9pC?=
 =?us-ascii?Q?lWm6Xe+UqhY2CWK1sLFZRxzxNVa9nLxOxL7dYyHAI9rM4o0YLwF0GMIXMOrj?=
 =?us-ascii?Q?NjoExDZ5FAl3VslckmR6BVHR5XsXu02jEEYjz1z1rPf0nlIZ1J3PM+2Jpsc3?=
 =?us-ascii?Q?k3e/5koaVRht9ZUiBxihG80Iq+aYoc0+3FegZT0kUF3X0TwOCNnHRvBtvMfw?=
 =?us-ascii?Q?6tnsybvlf/NSuK5HS2PsSONkAvpRU9Jh1RRTshUQXTjyNhHkcviPhQlsz/Q/?=
 =?us-ascii?Q?UM68o//kUAhz2oAa4okBNgt67YG9M3rcSjaz07pz7aOJB9+TKeevNNODK1HG?=
 =?us-ascii?Q?ogClSJNfCsHQIAr436fZgRMOhUWBxXC+L30nQrTZwUEE/cc4o5VPdAMlQIua?=
 =?us-ascii?Q?XDvEflvrgGKaLYAwMrrvMmtNCE4KzydImtbSHPJgNreJRdGxJxE+iv1dPqmY?=
 =?us-ascii?Q?IeG+J5aG93xIpQiCcKlMji6EJMz0f7/kFncUB81mp8kGO6SdK2uL7PAkweoq?=
 =?us-ascii?Q?M4aqTeZZ3pcCjsodMlg898SBJ1nL5T6XXh5BkqBPrBDWFX0/fr09Anyi55BR?=
 =?us-ascii?Q?ns/DGDXCS5SS4bZDfccjLNc7Jw1uiWnH5I4lKq/RCcjv9WCwJDOh1dXdSslk?=
 =?us-ascii?Q?1wLPXAl1RSlLzQpd2fEE9upxNK2w70PT07DWSDGvP9dX+y+Kzq3RRrgViaD7?=
 =?us-ascii?Q?t1QEmkojTkUmiRhJj7K+w6sI79VTG9APAv8vq1lCnGiRO+hmdzuz9FeboFPk?=
 =?us-ascii?Q?aeaabq8r0eYq7ofGY35WWlylnGT/oLex6NUz1jIFj54dpD4MZ9Cn7bb92xNE?=
 =?us-ascii?Q?q/h/sOj19qtD8+ELHyUSK0a0aUffy2FL4oWwhOWE6wNA+CC7jUKcu1rfmxWu?=
 =?us-ascii?Q?IJiX3dFTdKi3zUI9wcCt2hDnhTfXih75oB+YcWD3P8TxKqR7v58Qbu2vucu8?=
 =?us-ascii?Q?bfv2AZTnBfXEwHMjhzgUJzC0shAYnKOUMY24/kT3UEKnHVo0rVrXsbaI1Npy?=
 =?us-ascii?Q?2x319rtd0AsUJylTuFnzFdcZowvTGFAR7tMQJSwCStZCAGFYaLl/fRTYIsIE?=
 =?us-ascii?Q?7Fz+mUNPIa5SuGs6iQzEc9tlVEaNiMLs1inDUs0LlRidk3u7mnj6d/fwKEgn?=
 =?us-ascii?Q?hhE54PSEBFSaYnqcG6WUNSE5hoFRP/uzRPbgwmkCMIaK2K9pCOfC+8nwYOSc?=
 =?us-ascii?Q?VXsm99fRUZ7nZZzYdh6kOcclhe6EYLC2RyX2o71iTSWWHXir7VbPS7TP1A6Q?=
 =?us-ascii?Q?WlmtcgzSmYwUO9c8jiumZa8D9iQaMKu3+zxz0iJ9kCxRe7IaM6SAqpBn4/0H?=
 =?us-ascii?Q?iEk1nd4jyKa84AS4DJHj1YoHymfXh0kbAM2992gjurUEBbS39yDe1CSZp3yW?=
 =?us-ascii?Q?Yb65gPNo6KchaaSMbjDlXz6oOT8Rii/qIFMFjew/kPaMmQDqrgHz5ZKDehMj?=
 =?us-ascii?Q?UQ1YdwTIKq0HY+H/pnVOyfPqxIAnNWU509uFz8dHjBruLoBIKQFjdPKwnkCQ?=
 =?us-ascii?Q?o/CCmswFWFU8Snb2VnaUe/22SFSzHZ09wacvWPYckEC2YX/BFwkfNCMJc6rr?=
 =?us-ascii?Q?TD5xYZpXp/KmYP7wnMLW08N4uk88VqcKJSF8yhVo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc65aec5-11a6-419a-e2c3-08dbf0ae9642
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 07:41:23.8548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRLDAvomYslmADBKW/IfdP5JT4yKq/pYUqxXXdqlnaPIqhEjutbFQfH5CeQ2mqOFwk+jBBdYrXIDQ4vNIn0+jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3591
X-Proofpoint-ORIG-GUID: zdu0_jzv2QHtCsw9XBeRX_J8XeH8-eQ3
X-Proofpoint-GUID: zdu0_jzv2QHtCsw9XBeRX_J8XeH8-eQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_05,2023-11-27_01,2023-05-22_02
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
> Sent: Tuesday, November 28, 2023 12:34 AM
> To: Elad Nachman <enachman@marvell.com>
> Cc: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; pali@kernel.org; mrkiko.rs@gmail.com;
> chris.packham@alliedtelesis.co.nz; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Yuval Cadur=
i
> <cyuval@marvell.com>
> Subject: [EXT] Re: [PATCH v6 3/3] arm64: dts: cn913x: add device trees fo=
r
> COM Express boards
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> > +++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2023 Marvell International Ltd.
> > + *
> > + * Device tree for the AC5X RD Type 7 Com Express carrier board,
> > + * Utilizing the CN913x COM Express CPU module board.
> > + * This specific board only maintains a PCIe link with the CPU CPU
> > +module
> > + * module, which does not require any special DTS definitions.
> > + */
> > +
> > +#include "cn9131-db-comexpress.dtsi"
> > +#include "ac5x-rd-carrier.dtsi"
> > +
> > +/ {
> > +	model =3D "Marvell Armada AC5X RD COM EXPRESS type 7 carrier
> board with CN9131 CPU module";
> > +	compatible =3D "marvell,cn9131-ac5x-carrier", "marvell,rd-ac5x-
> carrier",
> > +			"marvell,cn9131-cpu-module", "marvell,cn9131",
> > +			"marvell,armada-ap807-quad", "marvell,armada-
> ap807";
>=20
> > diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
> > b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
> > new file mode 100644
> > index 000000000000..fd45d5582233
>=20
> > +/ {
> > +	model =3D "Marvell Armada AC5X RD COM EXPRESS type 7 carrier
> board";
> > +	compatible =3D "marvell,rd-ac5x-carrier";
>=20
> Now i'm confused. What does rd mean?
>=20
> I would expect RD mean Reference Design, and that is the complete device =
in
> its box.

AC5X RD can either work as you would expect, as a complete standalone box u=
sing the internal CPU, or you can move the switch on the back of the box to=
 "external" mode, and connect via an external cable a kit which would allow=
 it to use an external CPU COM Express module, mounted on top of an interpo=
ser kit.

>=20
> Yet, here you have RD for the carrier?
>=20
> The box itself is called cn9131-ac5x-carrier?
>=20
> This makes no sense to me.
>=20
> Maybe i'm understanding this all wrong, and its the carrier which you are
> producing a reference design for? The CPU module does not really matter? =
I

So in this case, once the switch is set to external as explained above, the=
 AC5X RD becomes part of the carrier solution.
This is a development/reference solution, not a full commercial solution, h=
ence it has the flexibility to be configured in different modes of operatio=
n.

> could use any off the shelf ComExpress 7 SOM. The bits you are trying to =
sell

Basically, yes. We have it validated versus few x86_64 system in our labs.

> are on the carrier? But since you are Marvell, you don't want to recommen=
d
> using an AMD ComExpress board when you happen to also have CPU

To the best of my knowledge, we did not validate specifically against AMD C=
OM Express solutions.
Since some of these modules utilize non-standard implementation of the COM =
Express standard (for example, few AMD CPUs do not have 10G signals, hence =
few AMD COM Express designs drive PCIe signals via the 10G-KR Ethernet pins=
 of the COM Express standard), it is up to the customer, if he chooses to u=
se such module(s), to validate them against the Marvell AC5X RD, acting as =
carrier via the interposer kit.

> module which would work? But the CPU is not really the point of this, its=
 the
> carrier?

We have tested and validated a complete reference/development solution comb=
ining CN9131 Com Express CPU module, interposer kit and AC5X RD as carrier.
We only push to upstream solutions which we have validated in the lab, henc=
e we push device tree files for the combination tested - specific CPU and s=
pecific carrier.
Customers are free to use other COM Express CPU modules, but they will have=
 to validate them by themselves, to account for any deviation from the COM =
Express standard.
After that, if they wish, they can choose to go for the process of upstream=
ing their device tree files by their own, like we chose.

>=20
> 	Andrew

FYI,

Elad.
