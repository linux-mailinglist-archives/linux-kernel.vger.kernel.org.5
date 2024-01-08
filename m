Return-Path: <linux-kernel+bounces-19939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683A82771C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4BDB21032
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98354BD8;
	Mon,  8 Jan 2024 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hj0zXgHc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452E4123F;
	Mon,  8 Jan 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4089s45Y012088;
	Mon, 8 Jan 2024 10:15:54 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vgetxhgr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 10:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVscSe2kzc4F6nPIl/CFFz70/dkqjuVANmuBZeqeRugF3AM4iBovDJtdf9FZKZ+xgKkEODNIeBNvtTVPlwK+TDlg/KP1alADPPoCnqGquDjFxE1Avn7Sr44oTvMhiS/uWNIjxCNcCtVSxcfFltOKXoc8WBXCz9HqzTFb8Ch2uJkCAgAQK9jaFGthc2kmdMQ371d4dGF+KLLsshIF74bhBX0TpVvlK8e2fk5KAlTYhv3/yaPbFJargS45OGdXtvXIsRZV36suCeuubL264DdR06qcE6mOR3DR2NO1kyAur7N5PAvbNl8ce9UgQvlmw+QVDo9mUpRj0VHXba0IuY40dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY32tX6pcLe+1JhR1KfaAzUQBbMHXkDrpcN4GU5Uj5k=;
 b=denHk2uldgdSd31NZXZqz6yJZexK8ctUgj/SfP9EpCcbJ7c1uyrd8ik/5KimCcNksF+EMo2NSdOeik0sPBYLyhUqxT7amUZL5vAffrR9DYxB+cy4sgP2HhL0OY/fm33ZE4zB4cX1PfuZc5SO/xhNFy1nTPQuwGVn09iDhrLGNsihRlREogM856q6O0Mqtf0gf2c5WQXnj7Og5v0OiAVhRrV7FNcb4V3O69frBUS3/l9fB87Q7U5r/rJEkkowfmFqviDZFUjE8k28WZ11wtxrLjSGuNFcrVvR9t6wIzuq4SbwhcN/fyFeHVY8JOqaG2v77FZJAmZ9dtdn0YuLMtIE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY32tX6pcLe+1JhR1KfaAzUQBbMHXkDrpcN4GU5Uj5k=;
 b=hj0zXgHcLfc4DvHZ8Br1Ey42dghTEr9sH0TL3eLsA9WlwdtP5TW5A1FjDsf+PdUSOu/YrWtTAhu9Fp+pMl9lyCgkEzeqTvcBq+7feTC27m5K37epVxj7XHvkjQGS5knIH7sDpoL28nxKbqk7zYbLuFQs8kVGLr/iSo3pZNy+BgA=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by PH0PR18MB4409.namprd18.prod.outlook.com (2603:10b6:510:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14; Mon, 8 Jan
 2024 18:15:51 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632%6]) with mapi id 15.20.7181.014; Mon, 8 Jan 2024
 18:15:51 +0000
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
Thread-Index: AQHaQX3VP+0+HUIapEqUlXjf5E6jabDQKXQAgAAIUMCAAASlAIAAA88g
Date: Mon, 8 Jan 2024 18:15:51 +0000
Message-ID: 
 <BN9PR18MB42513EDDDA454FA50249205BDB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240107152557.3561341-1-enachman@marvell.com>
 <20240108-zoning-tactical-20501dccfac1@spud>
 <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240108-chariot-thinner-7a86808a0571@spud>
In-Reply-To: <20240108-chariot-thinner-7a86808a0571@spud>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|PH0PR18MB4409:EE_
x-ms-office365-filtering-correlation-id: aeaf429c-ded4-44a9-3935-08dc1075d8b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /xfbtZIsHnD85hz+GlZZWbSUqYrOKiOa0gN/haFfcNFWqBVG6B7OlJbuAcLbSnJc2SaaJJ9KSSIvXi/867pwsxYQP1gMh0+itPvxsnjwnUv39CiIpsoKfTEd+/ZcH4QYC86fBS4UfzSXo530ODRJRlqTiUzAw0MvAAF9MKVehyNEo7rPRM8iEQhN+kY4nbEYA6nNCYVT657WXFyHl7Q5FeWHzD3Ae1YAWtmxRIzrSVU6tkpsWrgUZoAYNyhC5WjESqNaiTcpgaINnwTCZPxV8Ml/+LEIocTSrp8xagfqs0MG2ejK/DY6zEaV6MuabdkSR/+bNYMijxsDLFna1d/VVICK6oveTCUTwJgFp22tgUBx06sZfEt2yT3dfiP8SemMHhsQ4NOxV3xHkbGlPws4vnhT6COiZi3hrwRJwd5m+MLWZnWiE+cpD39WZxur9syBJQhiD7ONnAV4JQifd/V0T+XvCHtQr06ghtBq6HN8DzJLurmh6Jd4t+I/F9ROVeaJbcaiXztKQ6yX+NVAxBUzrktnxrkLLQPRoZYf5AozvdvbRpPHkBMLdQuRsnrUd3XqY+47+tEEue7NtgYAGH1cuPw74sD0rJIshD4cO8IimvR5RYjxx8eNO3f9cK+hLKEWoMjJ3vq3i/rH9VwrHkaDMw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39850400004)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(966005)(52536014)(64756008)(76116006)(66446008)(6916009)(83380400001)(54906003)(26005)(66946007)(66476007)(66556008)(53546011)(71200400001)(7696005)(9686003)(6506007)(4326008)(316002)(33656002)(8676002)(8936002)(5660300002)(2906002)(41300700001)(38070700009)(38100700002)(122000001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/N3ktLklnrCRSHPdoxiR5SHKUaM3/PgACvgohMxFhBCT5f4OugbmXdlNHSSL?=
 =?us-ascii?Q?fGKZNB1YVDc9fNonsS7FtkLTEanN7UljlfctHUOvFfcEQ0PgmvBoOZqOCr/+?=
 =?us-ascii?Q?0wgZpLfMyiXcqn6pAfnFm1jauzYCuk6zCqCKw7iuYsjxi4J+WBo+BFa956Ub?=
 =?us-ascii?Q?meTexbhEUvFiON8QGSyB+iGDdeInPLl0Iyv6ztWLwOYibDssRnCZQE50DHuL?=
 =?us-ascii?Q?2WHurW0GLAgf9jHsLjYjRnqJcOeaZl/7fDHhjW1g0voK+CIdkQIS4nI9Hv6m?=
 =?us-ascii?Q?IOJKR+gBiEn71NMkUWQeEfFCXnTKDFGwXe3KzNZk8SoRhef9eRsXJlIQPib3?=
 =?us-ascii?Q?3UEXZzN1Crsb2035QB6KJXa16F8AeYQzHfJsdTU/MhffNyuQ7czKxJsipqeR?=
 =?us-ascii?Q?jumHVszWUqgoliZlMBuZBr/zACKlwHc+YpJ20yoH+Gsl44gqe1WVAPdqkXG5?=
 =?us-ascii?Q?L0GqHias2cLdwBp6BEvBPs4A+aPpniISLT53rzLZlp2iCmgX+6HrVSq1/vEb?=
 =?us-ascii?Q?h/oVVai6YTusOaMO2w9tB35T0i3Lfuvic6VjpC4OZa0LM1zSf9IkmY24YRqR?=
 =?us-ascii?Q?2fTPU73kn2HcJlXSc8gljX7saNKEUVfGumceJmGecVxOK4ILlMyXGyo2gjDR?=
 =?us-ascii?Q?rWqcXl6WyRdFDFr5yvq4Khi+A9915hAT8MwFLBnOLfduwy6WGK15Yx3tCrtg?=
 =?us-ascii?Q?cG+7JIAcKFjtgfkPYGZKIrHeXAoPB5cclcd8w2II/Eda2laJpywc/5n4z3ME?=
 =?us-ascii?Q?rz6CZ3oouI0TmbXXfHOim42r2pkNU0sYtboDFBC0UKGocPseyxMu6nvAulDV?=
 =?us-ascii?Q?zMWlv2tr9lC7jBK8MkgVWQGSt/gXVd9flzhKjjV+/rlqEBlmqtyVl2ojV8nn?=
 =?us-ascii?Q?a8q8kfZhmNYk1LC0FCE4IhKj68W2u1XSlWYyjIxDK6x7WAqDe+N+mmnfcKgK?=
 =?us-ascii?Q?GLLOZle7YVMTmn0EyECJbBsXCYlkFf+jfZt7yP02KLJH9ZgFbUG98NU5jCRM?=
 =?us-ascii?Q?Nkezz7dYE4BiXrYlpn7/I8ttLr40Dct1IffO4vDQw8O3UyDBcydN3kNzBlfD?=
 =?us-ascii?Q?Tjep3pCUC6jQppgg8vqdllALkMz4CnsF+S6bnjuCG2nsxXXPaBQyDGYFSN0L?=
 =?us-ascii?Q?7t8ie+MplgjjUMRW04Qe46ON1i01lMFAlzcQUJ+2rmzQJZ/iB/g2GQf9A94P?=
 =?us-ascii?Q?d3PVedzvqhpI/uCDdEkeRl1FYMIqR/VWp8G1djGBC/BIjDj5en00MRXLbgs/?=
 =?us-ascii?Q?DCobvVMN7xoAYUPvIhhNCvEBi4Ode1XxCnfMcfa+v3TL0DmDLIw6GK+3wkRU?=
 =?us-ascii?Q?M6P4z7rpVQKHTQxGKy8kw80XU50ZM47HYxNK2v8ZF6fXh2DyRpZgoxnnQ8o/?=
 =?us-ascii?Q?87T9jloC1wniGX/opHoFW7UBhrSUT0I6L4MiWbneVZ2RJvSrMFJJJpppTBdA?=
 =?us-ascii?Q?DFt0Y9IZGwIAC5YwYBAfjQMZC8KXXYbuIsA3dHRo9ryQ4qs27Bw/+JhToW72?=
 =?us-ascii?Q?2KXogEo/ipPxtMbTm2T94yjd7SPbgcToQdIczqQ/vA7ijx0Zhvc/Ph/s3Mep?=
 =?us-ascii?Q?t226lRzQp6wthFKXAZSSZnejItvN9uXPa8R7tPym?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaf429c-ded4-44a9-3935-08dc1075d8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 18:15:51.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ECKiU4sk9YwHvRwzf5rEejzqVcJkdFDsG0xn9WklRSI13iMXdPL02JAalkcH0Bm2qPkxAjAugHXGs5+CFdf2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4409
X-Proofpoint-GUID: maxn0hWB4wuIub9UgVELeQwhKEwgiMIP
X-Proofpoint-ORIG-GUID: maxn0hWB4wuIub9UgVELeQwhKEwgiMIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, January 8, 2024 8:01 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
>=20
> On Mon, Jan 08, 2024 at 05:47:24PM +0000, Elad Nachman wrote:
> >
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Monday, January 8, 2024 7:15 PM
> > > To: Elad Nachman <enachman@marvell.com>
> > > Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> > > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> > > devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > -- On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
> > > > From: Elad Nachman <enachman@marvell.com>
> > > >
> > > > Add Marvell ac5 device tree bindings to generic EHCI.
> > > > This compatible enables the Marvell Orion platform code to
> > > > properly configure the DMA mask for the Marvell AC5 SOC.
> > > >
> > > > Signed-off-by: Elad Nachman <enachman@marvell.com>
> > >
> > > Maybe I am dumb, but I don't understand how this does what the
> > > commit message says. There's no fallback to generic-ehci or any
> > > other compatible that is already understood by the driver.
> > >
> > > What am I missing?
> >
> > Following guidance by Andrew Lunn on my mmc patchset, I have split the
> > patchset Into a single patch for dt-bindings review and another for USB
> driver review.
>=20
> I don't understand that advice. dt-bindings should (almost) always be wit=
h
> the driver. Otherwise you just confuse people like me.
>=20
> Perhaps Andrew meant sending dt*s* patches separately from the driver &
> bindings?

The rational was different people making the actual merge, into different i=
ntermediate git REPOs, before mering into linux-next.

>=20
> Cheers,
> Conor.
>=20
> >
> > The USB driver patch utilizing this new dt bindings compatible string i=
s here:
> >
> > https://patchwork.kernel.org/project/linux-usb/patch/20240107163307.36
> > 77347-1-enachman@marvell.com/
> >
> > >
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > index 87986c45be88..2ed178f16a78 100644
> > > > --- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
> > > > @@ -77,6 +77,7 @@ properties:
> > > >            - const: usb-ehci
> > > >        - enum:
> > > >            - generic-ehci
> > > > +          - marvell,ac5-ehci
> > > >            - marvell,armada-3700-ehci
> > > >            - marvell,orion-ehci
> > > >            - nuvoton,npcm750-ehci
> > > > --
> > > > 2.25.1
> > > >
> >
> > Elad.

Elad.

