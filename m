Return-Path: <linux-kernel+bounces-19918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4038276A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900001C2234D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870656779;
	Mon,  8 Jan 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="BFGy6wtc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277556773;
	Mon,  8 Jan 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408Fh7Nm029129;
	Mon, 8 Jan 2024 09:47:28 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vf78n5u1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:47:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBSDdS9XU5Xak0p3zarbJYOfZtiSbsS00UUzj7Zff2iGc2RbGaDGA7AIhH78dyOr+l7S2Y2ZZkm9TJ97481kXTHv2G5kc5C25XaJ2s5Wj0aZ40F0rkYS4SBOgbk34+SROS0lCZLmgKpLZh0mjApCpdtwgQTSDrU2qxr34dZj+Bxcoe0qb1dyJHYLRgvbjZRdtGQcgOjDeaiw6THXuHR8hK54A3axi5J05wUuEEL/X9r4hsHyg3ohzg8r7jtNyuykMHsG1qNGYbUErRwKZKbIVSsPP3+6pV97UAkbhfzk5Oqw0YOFUkSUCNLSBXTCNjm4q3UYgXSqQhYUh05MaUxtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN31gCy/PduEVSPOYBapxZUdYpzdBDvhoJzwLdiFx90=;
 b=PXrc84zojfuwP152gt4hxjHCulPY+ITK8cBdYqJ/Th2OhzQKUvMqqwhXNHNX9fO0q8YH66pARSJVxWWT5uCSEaVH+M7I+ogAmxynhEk0x6ldbvPfcZfCcEGsWrQCuqN0VCT/sEkxeDXt3B0wuPaygYesHli4xqoUi3xTgjQ16QsKb2pJK7qfyNdbMxiSUwJYnt2wfmQk+apRnflU3HhfWdDwBBbt0ISERnHfbqfP6TSGOjiCdoCffqfCSMeK2OtATt4QWux2xPiftSwYECCO58d27mKibOPiE9kAIaLpSNN6moB+TZ0GjLyxHFQabx7Xa8XVBreGqYlB1Dkesrn8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN31gCy/PduEVSPOYBapxZUdYpzdBDvhoJzwLdiFx90=;
 b=BFGy6wtcS3Uts1rOeeYDWeEPGs8w2mkF8D4DSw0w2RzwTNVYAnqwPE9UB6UJ3w518bOM0d9iGTbN6mFWpNB8WqJrJBINOsdcMiJbOQnwRsMQ8Wmt2O3trDMENoW/RsyAUmqG6Mpr/ce/btZbJXM/+wF3cNn+xJlpH6/q0cTQlrk=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by BY3PR18MB4529.namprd18.prod.outlook.com (2603:10b6:a03:3b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14; Mon, 8 Jan
 2024 17:47:24 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632%6]) with mapi id 15.20.7181.014; Mon, 8 Jan 2024
 17:47:24 +0000
From: Elad Nachman <enachman@marvell.com>
To: Conor Dooley <conor@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
Thread-Index: AQHaQX3VP+0+HUIapEqUlXjf5E6jabDQKXQAgAAIUMA=
Date: Mon, 8 Jan 2024 17:47:24 +0000
Message-ID: 
 <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240107152557.3561341-1-enachman@marvell.com>
 <20240108-zoning-tactical-20501dccfac1@spud>
In-Reply-To: <20240108-zoning-tactical-20501dccfac1@spud>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|BY3PR18MB4529:EE_
x-ms-office365-filtering-correlation-id: 883a91ec-4195-4639-626b-08dc1071df47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vfrRvupVeivhfUBSLnRVfoSZX7AkeEx6ujpeFEEBVDcj0sf2EyBK/Ot88oxzhb9cSLVbyBwtCaLGR7tqbd3pcpCbp7VLgh28HSp1VcAn30zdv51LC8a8ZgfsuEy6cX0b77Yu0LaSwQlMTYZU4GXrzgL10vOKKFAHO63tAcK1d01P1cn3PfUvHpGxmadHZtsQoit5to14YEdxIsK2IG5++UTHEKhZ61Hoapk7JUzprDnTDlfMCMx9gp5fq2FDBXCrVZJ7rr6sUAYjnCn7mR47K05SWw+23yJbYDf84rJ4ny+STgjo4pwpJrmyZZ6IhV49bYZqbcoiBiQKmQ+kXEPNco2XuGxtjqUI/eEVydyJYU0po7wea3StUeKrNoCvNjW+TtxbJTsH0+wIitOlfwtAT49aIFvwGrXTP2DK8Xhe/flEEqwEzdCJG8umzVwvnuEcm47P79PDZC/YKO8OSZu2Z+wQHuCe6QiabZsazUoTGp0xduwsbKy24agc8ManXJN7zv1bIMEbVDWAheKKaaCFJSRkzgkKi3F/dIn6FJ+tCUsq5l5Q3FzzND8vYZ91WJgNLjO4utz8VpTWxtcuFv+yV19e1P2umizMUJmjYmIGtz8Nh8U080+XiotrpXHl5Xmo/lsX1Q7y+3vneVeffkugUg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(38070700009)(86362001)(55016003)(6506007)(9686003)(7696005)(53546011)(71200400001)(316002)(4326008)(52536014)(966005)(478600001)(26005)(66946007)(66556008)(66476007)(66446008)(76116006)(64756008)(6916009)(83380400001)(54906003)(33656002)(8936002)(8676002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?udVK4FPHe8ArnD8BYOdZui1K+QgAc3tNVSaoEj1gzLn2srObsY075NqKr2/B?=
 =?us-ascii?Q?BB3AIO9iOYOMHIa6R7RnEUi02QwrO9LBlzZkQS5flRqg0qsJ2m9JGwwAW+Cz?=
 =?us-ascii?Q?/Ebfs+V1l6SzZEmo6jOFoo8Rz53FT+sFih8+r8SlJg1Ky53763VVodUNx7Tc?=
 =?us-ascii?Q?+vIdnPzB0QpbHQPOR+rNjmWk5fqp9A3813dyCwI+Ty22JVKYHI10WAwFmfli?=
 =?us-ascii?Q?xH3kDYz7Pj0AMul/kig2DzuRlb+WCtwmqIO4J5YpWrjGD+66XtGVizSPh1qJ?=
 =?us-ascii?Q?ObYNzkN9vldXxac4vWOYy7jlBhD1AmDeUXE4YO1ce+iu7lv+GIp8809P2dwl?=
 =?us-ascii?Q?I4ALfmUBTJiWWSKVERyT2ewFERx/tqUxImcRjfers3gLET+4c3fp6yeJAL24?=
 =?us-ascii?Q?j6QWYSjscNAuZxu6bE4p9Q9bfzcsecslOV2HqSjQQhq+dLRKjABzRUWB3kLA?=
 =?us-ascii?Q?Oh27LDwm2zC3qgLXwnu/zef7/1v5ZXlmqDr+fTZ4gMPJGdOhDKw4oWPDJlVV?=
 =?us-ascii?Q?RC5nc+P4GCW0R1VsekVALm+q1g65JlIQwUahFede9uQtZnUvWh6WMU3TLnZz?=
 =?us-ascii?Q?2OVpkn052JA1r8FY6SQAVWrtiasHMRswMjeSzLVDcpVgtjp5P+NgyU37YZar?=
 =?us-ascii?Q?xyr2CjO6umdsVKY+XdCaCPnNChTlU+Og3C/f5bplkZhAK3Nbwctbgqdm2JVs?=
 =?us-ascii?Q?i06njWfvEUZWl+fUcH0w6RJ0/6i3sVsOw2BAiNLK2KnJneLR7yhRkl5NXCKX?=
 =?us-ascii?Q?6tPRbfOD/u7igLn2vzlBq1MH0dwgCHBBhQFg+b3MxAnPyNbrxKJ4Jvis5QG6?=
 =?us-ascii?Q?de7onhHnvpCSo7J5pE884BBGvn0PDnkiKZjyJ8IKvDM9AjX/jJSKggxiK5rf?=
 =?us-ascii?Q?xSZ0xrGO2v43izolhBLIBCXVzZcLcHdOJfD1htT3PQMzdGV7biSRNZF7dE51?=
 =?us-ascii?Q?yGyBcGnU50tK3ccNRheczLDJ3+IN8Ei3lm6TE+FrYbb/WMgzCAVBZw36eog9?=
 =?us-ascii?Q?FUg3Fn43hTpE7SwjwGl7HHJfUZMNAL3K8IblSYdOH4F/aTv1i/0bHkXT8TVK?=
 =?us-ascii?Q?TktNQL8szjpHlpWmZHSr5NtohMnAzCpU2PizptKkxBY0Tzu2AZ8uI+PDV7Yg?=
 =?us-ascii?Q?z5gktu0c8IXwtUd4P9oGKYG4tAaV35O65UMnbpbbz8QQwBH8EaD9oTH/y8uX?=
 =?us-ascii?Q?wKZ6vRIZ5LgD78QFPNOT9ILVg8SGyAZlxFbVq7EXxkTUB4+JpkFPzfDJSqyX?=
 =?us-ascii?Q?dY4I2pwbAd2t6jfhbfM0pV6GZJy0MMu+XCIi4wn2FkIICSrzbq6gn3FU1kCn?=
 =?us-ascii?Q?X2NzuJsHBGkt9zmafh2CcRumedSP7gwhG7JQAvOBmZ0weUhPnN8YKDso5j/W?=
 =?us-ascii?Q?sMb5gtFb98KDALgbYMmuHQ+7N6bj1rxjzMjIkVB/7GK2ugTWIbctlSUYwdS9?=
 =?us-ascii?Q?WuJdrn6FYDXyItM0sohqu74xGhOep1U4jrD9YEfJtFNXwCi1Z9mRPSjyw87W?=
 =?us-ascii?Q?LFo0GJFVew6W6qO2jVISGqY8EnS+4X8WDRZWuCsMgM25c0IjU1EMCqt1kvh6?=
 =?us-ascii?Q?vVOB+M3iDZo3bW1/35VDlYyTSSFZua5BEgHF8wm7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883a91ec-4195-4639-626b-08dc1071df47
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 17:47:24.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hE9EsXcpTWKrXUX6cINcPNXlvo9dj4X6iCH32+PtGfiUrKS2atJgfhtQpC91lmMVD4YjMEYLUrqolGuflV1d8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4529
X-Proofpoint-ORIG-GUID: AeT2zlNWvbOVril_FFN1obxSae-ZW3PL
X-Proofpoint-GUID: AeT2zlNWvbOVril_FFN1obxSae-ZW3PL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, January 8, 2024 7:15 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> >
> > Add Marvell ac5 device tree bindings to generic EHCI.
> > This compatible enables the Marvell Orion platform code to properly
> > configure the DMA mask for the Marvell AC5 SOC.
> >
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
>=20
> Maybe I am dumb, but I don't understand how this does what the commit
> message says. There's no fallback to generic-ehci or any other compatible
> that is already understood by the driver.
>=20
> What am I missing?

Following guidance by Andrew Lunn on my mmc patchset, I have split the patc=
hset
Into a single patch for dt-bindings review and another for USB driver revie=
w.

The USB driver patch utilizing this new dt bindings compatible string is he=
re:

https://patchwork.kernel.org/project/linux-usb/patch/20240107163307.3677347=
-1-enachman@marvell.com/

>=20
> > ---
> >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > index 87986c45be88..2ed178f16a78 100644
> > --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > @@ -77,6 +77,7 @@ properties:
> >            - const: usb-ehci
> >        - enum:
> >            - generic-ehci
> > +          - marvell,ac5-ehci
> >            - marvell,armada-3700-ehci
> >            - marvell,orion-ehci
> >            - nuvoton,npcm750-ehci
> > --
> > 2.25.1
> >

Elad.

