Return-Path: <linux-kernel+bounces-27340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B182EDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8720F28326D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA51B950;
	Tue, 16 Jan 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="axvu1pDV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BA1B80E;
	Tue, 16 Jan 2024 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FMhAC9013579;
	Tue, 16 Jan 2024 03:42:07 -0800
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vn1gc4648-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 03:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYBuEAMiH79+PqMTTRHP1+eA64B/3zjywYtx+j3YLcgf5HdZDk+BNIRIBwHbyYMG9bAf+zVg6HlhGo4GHA/feuvhxuVOMKf9xsVWbmGfeZW1jGlyCeraGqQfCk9IahKiSDIQL2f4tCq6qUlk86oa+kSyRumSq4yNa8LO3ce3vJ2oSXTJLBqvbVTHyBNKBSLl5nrDRQt2lWQwm0bcJ2AgFZx6ry47Q7AoiWCRrSBf/SttTZDwkSU9/qf/MPG2X8Nn6ETshriwVgXw8E6w+eVxM5Tb9xipEjKC0EsDgEEOpCh2BECFGH/m9SKRX7eMsxjdRz5mz66pGk0G9myx0egPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxVoP4ONPGVl4AaOfOvOOf1C+pL7hChM7oZSl1oWv0Y=;
 b=P+qLfGbXCTogLAl59RBnd1Y1oY0S7JjZb7kz5RPeyXitpJ+3dY5aeB9tB+UQwegxYTlBjcNcBd93Z+VfONZ1qkJCXonpV9ig3c1x6GdajIAZzFRfj1QVyoGVLUJb8mKqdlLC/QI4ocs3AOt+sGE07XHeBoz7zbAHD6S2akSWq4JcDGEkS6k9MwEnolGHn0zuUWnuJ8Fmgpw0+XLWXQmJB77dj9gua0SPQhBxvgFbFimAbril+ypw8YcEX1iJHGUxBuyfLZadaI9jytmv4UBFC9R6VrZU0QFiDOb6rc2Zf9jlH84nwdwrYMrhScJKBe5dQfhSAQbAiDgBsizLOAU2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxVoP4ONPGVl4AaOfOvOOf1C+pL7hChM7oZSl1oWv0Y=;
 b=axvu1pDV5h8O2BNxjGK+5FsswcAeybOjNEa6dLDaT46xTERrM3NB39vXxsOXNk5UuVbdAOg2cAomhWRVkKHX5z54f3eck5LWy+n9qRKVT1rLTqF1Gn8Hu8W4EmQGnEbcoLYDny/eLDIDaiEphj3bneNgvuPgWNE09DXRRaLkoE0=
Received: from PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22)
 by SN7PR18MB4031.namprd18.prod.outlook.com (2603:10b6:806:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22; Tue, 16 Jan
 2024 11:42:05 +0000
Received: from PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9]) by PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9%4]) with mapi id 15.20.7202.017; Tue, 16 Jan 2024
 11:42:04 +0000
From: "Jenishkumar Patel [C]" <jpatel2@marvell.com>
To: 'Russell King' <linux@armlinux.org.uk>
CC: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Topic: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Index: AQHaSED3tkBbnIbaJEakXSpW8Z3u47DcK5oAgAAlRCA=
Date: Tue, 16 Jan 2024 11:42:04 +0000
Message-ID: 
 <PH0PR18MB4543D1F967616763C27EBB2EEC732@PH0PR18MB4543.namprd18.prod.outlook.com>
References: <20240116055754.279560-1-jpatel2@marvell.com>
 <ZaZLuPyRa5QhRrmH@shell.armlinux.org.uk>
In-Reply-To: <ZaZLuPyRa5QhRrmH@shell.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhdGVsMlxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTNmNDI3Nzc2LWI0NjQtMTFlZS1iYTJlLTAwMjI0ODZiODBmOVxhbWUtdGVzdFwzZjQyNzc3OC1iNDY0LTExZWUtYmEyZS0wMDIyNDg2YjgwZjlib2R5LnR4dCIgc3o9IjE3MzQiIHQ9IjEzMzQ5ODc4OTE5Njg0MzkwMCIgaD0ib0d6SXpFTldWT3J2N3grN3BFSDdpb0UwK29vPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSEFBQUFCOHl3VUVjVWphQWVyaVZtL3c3WFJtNnVKV2IvRHRkR1lBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQkFBQUF2REJPdWdBQUFBQUFBQUFBQUFBQUFBPT0iLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4543:EE_|SN7PR18MB4031:EE_
x-ms-office365-filtering-correlation-id: 7926a54e-bed1-4e4d-ab9f-08dc16882990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rpq111DWWQft1o+nx8ZFk61jR0ezTJz9oTHRCM5RTH2nKkSFOyNGcB9rvCXrJVdtru5lL2apuR9/iQU0C0wUuLru2/V0g8W/NiR+ElZTdNogsKWfuRz2ziCvTc6hkUWbDOFPBsJrk6K16txOuwwa1FhKEawXaXJnOdMkiNEpOQ+LRY9FZuuo1sdHOlV7DhBUs9H6gcrGGBLTXm50hc9hYYcs2Zg6wV1LGzxvOBZ7bbfg+0nMKl7AG1DQMAvvGoz/O2Qo+g25E9mYgPJlBGLKAQfApCfqajA6Bx+0b5tdXgceHRb8qVF9pp0x7miXT52cka5qSDoJWYOu41AbLuPwTRtFQdYuZ+Byz1H/PGeGvlbxc8ujIuzp6645+fbDDLYev2OQTEXX10EjhYxBHOQxe6w8B2R8CAB6PVdYoQAQrVCl0H0garlgbImMT9d/+onErx/Ozk2jgZ6FGF2gukX2FgkGIYZO5Vhb+dJlURxrR0FLDZqj57JjS7UAs4eadGfJxKAJLRKJXc67yy5tf08+IjSYB4KPp/HejhxCzYvYv0XYrSGqySxgy+WYzQA1ir3ML+ALw6X+oyp159yDp74d5J81Ym2LctaIdLPhFursEZ0LxGDi+BMLualdphxg+0y1cxP3Bf2nMssLHhADo/2+Lw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4543.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(52536014)(4326008)(5660300002)(2906002)(9686003)(53546011)(71200400001)(6506007)(7696005)(26005)(64756008)(66446008)(66476007)(66556008)(6916009)(66946007)(316002)(76116006)(8936002)(8676002)(966005)(478600001)(41300700001)(86362001)(38070700009)(33656002)(38100700002)(122000001)(83380400001)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KdwBH/oDI2sWyTfKsNbe0Sf5dWUK065X0zgxI/IB71Kdtoi9vN5F24Vruea6?=
 =?us-ascii?Q?Q/lYQEkY5i7KKjlxMhCXrRMVstzcWLonXOrRawaX37UArxpt9UNlM5ZeFfY3?=
 =?us-ascii?Q?nyfKlh4/z1sozw/U0CQMpQPt95mEGy/yOZtyXcDrEjE0Ad1HksECmStcn1U2?=
 =?us-ascii?Q?loF5TZP1sQ1UDbE5TElOSIpDFNC5hov8qM1+6jtQZSE4w1scEB7RyFl8W8t6?=
 =?us-ascii?Q?5q6nWJAfeYZnytsOgR35JQEaheS1bqFOvpxjUW7/RkM6u9O+/VtlbUCTkafX?=
 =?us-ascii?Q?9B83MKqSoiW+GMdqOZsgbb1jj2dDAgmF++kf85MXVUlJ5i8VsF1NsPtUQpS6?=
 =?us-ascii?Q?Qf3bX32AJbwznpyxJGNfB/ZbpNM4wTla0S1KXNrUuxRGcXIitWzJ9sMgroKW?=
 =?us-ascii?Q?lTi7ue/0ZHHj4r6ii/n2NU62WOy9g4Ppp4GU1NsgcnKV0HG7eeVuhD5/9MT0?=
 =?us-ascii?Q?sUTVCynKCCm9v9QTt1z+Jov1eBs4j2snEuxI81M2mMwGtCM7DPbOxakLpFZj?=
 =?us-ascii?Q?KHkAbVHTXj/QNYl0eSsB7hpktyy8DyY+UNN8qpb6zM7vQaueXB7UpTQOGhR0?=
 =?us-ascii?Q?mFphw0g0QxDkkIoikCI1na2VdZyNaoi2IImCbvfbxxY6M1w+0vU4K+briViu?=
 =?us-ascii?Q?8rR5N5CjVzWtCa+9fw4gyn7FY61fkhdrwwZX75W3pJ9yyc39ebTjfjdkeIad?=
 =?us-ascii?Q?9SBfu5+MYVzcXOIAnNf/mKaOkB6L55x9n9zzrX+Yv30Rf6/DLduosYCYGzH4?=
 =?us-ascii?Q?kA9QIzR/liN+uu3jdlqar87Klbv9WHACqahN1MmMRTPcoh2ReA5kquCJTkTO?=
 =?us-ascii?Q?fGdQrRY1rc3cPgpcUcuYzfPyHcbCG5QHXXiOjJ+AQzpxdTdrxHcbhhPxH0UP?=
 =?us-ascii?Q?8YpbMySxw5Pg0trAkLberv23BO8pmV32uIh/Mmjk39LPCflUFU3oMPiXcGWK?=
 =?us-ascii?Q?PIWdA9kuCAhP/djjMi6/lTkRoDDkLqxtFG2i0QFYPYojxP+bA70Xui4GlK29?=
 =?us-ascii?Q?LDkTkdrALWynwiFUaYx3FdhvibI1tVSwOU3AgVKrHsdlxtVAkdc8GXgDJer5?=
 =?us-ascii?Q?vJbs/RZ+Q5zBLQJr2P1SlJliHER1tbcQM4MsdUd2KE49rsCnk7km3qlC1zkm?=
 =?us-ascii?Q?T8nlBQqaIRW3Tfydpv+7ghaQ6QNCSGkZacluJd9O+91mpGKyRFnGcb07dWTf?=
 =?us-ascii?Q?mNHzghx7aPGTSmQAEjVOKh1gJXXMxkI+qmILdl09FgNvaBOXk36jLijzrOMz?=
 =?us-ascii?Q?+XnAg2AO6Lp9TJmaFyFB1N7iiLHsLJlWWXVnhy2siDTldJaBZa/Np/o69rrX?=
 =?us-ascii?Q?4eAbgUy6bqVt5Fm2oKlosl56PhkvfsK2KxD2akNYEuPnRJX6nvqJ7BBtcBP6?=
 =?us-ascii?Q?jBwNSJ2z3C3VC/8RQHm7hWUpkRUVMH/7ICVzVSlC2Z8i4JHDUd484GK55gA8?=
 =?us-ascii?Q?yx2AeG7YoXphqCGov1zg7+VzQkUSPQFDXf7h56RVK3NjZSuYG6VnfzPy4tO/?=
 =?us-ascii?Q?ixwlDwpsz+UaV2FaTMFGjgf2QfEL/yyTb8GTqTpLvlSK6EcOl34HKuuQWgZn?=
 =?us-ascii?Q?yQK58MHb0/gotZlNLiI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4543.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926a54e-bed1-4e4d-ab9f-08dc16882990
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 11:42:04.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBPfpEU+g/fe31/kbf0nSbgEer7meJmhHWgQoegpXvLZ+8R47iWqeCKJvRGIUrdWLVwZm9NM/zmBYF0Nr0KBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4031
X-Proofpoint-ORIG-GUID: Ze_tEQE3jd-gUxZQAvakRhmP9gTojz2j
X-Proofpoint-GUID: Ze_tEQE3jd-gUxZQAvakRhmP9gTojz2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02



-----Original Message-----
From: Russell King <linux@armlinux.org.uk>=20
Sent: Tuesday, January 16, 2024 2:56 PM
To: Jenishkumar Patel [C] <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com; davem@davemloft.net; edumazet@google.com; ku=
ba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger=
kernel.org
Subject: [EXT] Re: [PATCH 1/1] net: mvpp2: clear BM pool before initializat=
ion

External Email

----------------------------------------------------------------------
On Mon, Jan 15, 2024 at 09:57:54PM -0800, Jenishkumar Maheshbhai Patel wrot=
e:
>  static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)  {
>  	enum dma_data_direction dma_dir =3D DMA_FROM_DEVICE;
>  	int i, err, poolnum =3D MVPP2_BM_POOLS_NUM;
>  	struct mvpp2_port *port;
> =20
> +	if (priv->percpu_pools)
> +		poolnum =3D mvpp2_get_nrxqs(priv) * 2;
> +
> +	for (i =3D 0; i < poolnum; i++) {
> +		/* Make sure about the pool state in case it was
> +		 * used by firmware.
> +		 */
> +		mvpp2_bm_pool_cleanup(priv, i);
> +	}

	/* Clean up the pool state in case it contains stale state */
	for (i =3D 0; i < poolnum; i++)
		mvpp2_bm_pool_cleanup(priv, i);

Doesn't need quite as many lines!

I will address the comments in v2

--
RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DweFk2fYEO0yNIZAlSXwm82u5QM08YlNJaQ39RhfTtUo&m=3D2U4cWAQSanajVfFvpZbZd=
hHMcQ4rsCILgPZ1Nk_k-CE3HMuIv3y5IPWQ4KgdJgAG&s=3DIbrApY-e2TWgCw8YQJc7W48jpUG=
y29BTy_MfcTkwQ8I&e=3D
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

