Return-Path: <linux-kernel+bounces-9908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4481CD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46BD1F2154F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3224B5A;
	Fri, 22 Dec 2023 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="LNIKYppQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBC24A09;
	Fri, 22 Dec 2023 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM18cL7013901;
	Fri, 22 Dec 2023 08:33:21 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v3ntrw4qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 08:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkxmUpYxx68o3QTWwdesTKla1rB+11TzIjJqUbx+76A/APZZi1S7MPPuO951rOOVPzRr4wkQm8xoxZ7bLU/mflV6uUnQKWnxXVGDHjrkRy9DKxD/ZhAQGPYnRVPVK8nESvHwq/l5V7wvT0lpZLjA6dqZc+VR1EL6uSQRlBt+jB/YSYjMc4Uetrwr4dHpYukO2Tj8FkLNHyL90mJt6zo/wc+h37VO+fUrEXVbyWvQGJpvtiGJuM/RqQ5l/xbZRPIkOGK2a6aTRLEYX4vs6wQNEOHkTb7mYu5dyXa3yazu7tpWVVEHU2XQqmZAEkGYQJ98YWbZt1Vv62P2D4t9YXMqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5NrphJvCLyQ/NDmmNvuRl+RKD10kFAsIh7btJ+Gxt8=;
 b=UZ8zYMDhcz6OBaSS/HQiivZY8UHA9pyfBVmgi50UtwT8GLElo1UGa2QeNnqz6RKByLKBg98u3WBRwnSV6pf3WuOVhc74Y84Ht0ylb2DF6l9f2eIJrcX6Zi2TpGQ6GUB5NU+y9QfsIY1b/6Hwe5bJacFx/YoOJP6XiZGHHmgLX75YCWifxRNzCcq09QbtQk4nLnar5Mr2BADV/84cYm0y1ZyjA+vvZ3OPDi/V7PoSyP/DuEWwR5wx6nLYqa/1qIqVogJCjctHOVPgoRwiqLohnMhL8xoKQJMrgLroEJjHLXK15ixRxoSeVlzic8qVkWfe68u6gjB6WR1aDRf63g+eWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5NrphJvCLyQ/NDmmNvuRl+RKD10kFAsIh7btJ+Gxt8=;
 b=LNIKYppQ89RMvl4FlOlMxqbO7pwXJrIJPDq4lMcvOEnwqHIQ0wTzw6zsoOXCMGfLto/DsD7AO9tyDIFk7EA+vVI7iyp5DmLxzF0+0tezt0s3ftA9dLCPT3XJyu9QgK+ylebqcCF//+7dCdAAyr67t0NS1KZrLdQET7/3pPUb2NQ=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SA0PR18MB3694.namprd18.prod.outlook.com (2603:10b6:806:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.10; Fri, 22 Dec
 2023 16:33:19 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9%3]) with mapi id 15.20.7135.008; Fri, 22 Dec 2023
 16:33:19 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
        Sathesh B Edara
	<sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "wizhao@redhat.com"
	<wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Satananda Burla <sburla@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v1 4/8] octeon_ep_vf: add Tx/Rx ring
 resource setup and cleanup
Thread-Topic: [EXT] Re: [PATCH net-next v1 4/8] octeon_ep_vf: add Tx/Rx ring
 resource setup and cleanup
Thread-Index: AQHaM/A/9U7l3gj46UylAz3my4xwv7C1SIMAgAA4G3A=
Date: Fri, 22 Dec 2023 16:33:18 +0000
Message-ID: 
 <PH0PR18MB4734C94753260D2C92849419C794A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231221092844.2885872-1-srasheed@marvell.com>
 <20231221092844.2885872-5-srasheed@marvell.com>
 <20231222131012.GG1202958@kernel.org>
In-Reply-To: <20231222131012.GG1202958@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SA0PR18MB3694:EE_
x-ms-office365-filtering-correlation-id: 4ba6ec61-0f0a-4fac-77fc-08dc030bb4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ia70tHg4vFmg0ejtO0Ua09zNBL428fO1oOnAWBU2z5mKIw2Yx8KNswWDyukcBeUfIGWqJ5ZMK1ahFnddOCvT2BtRNR/5rdp4S97NVkTryvscQ+BOAXeC3QobLZwp/MWra+IZfTGuDUZu5vMyfngCk1R9wdpG4966LojV4bhQ7l8PRT4MbKfXrrFYBBN9AAYEN+QOd1WmgSTREEE4XZ4dLyFJBgrAn/vFB3aziu0KPbusW3v9McOkYBt5H9m2RjlO979xU+D7Lj8BeeQnv+QLXTXyArfQ2wn1sU1D+23ScMpdTRxCfHNXAvtRarDjXUaOUGoakd/Jrj8m8AzTASjmKsRk+hZ7OI8AjKazVLBJjNB3IAUB4sDnCEo0WP2DD1/m6fR5sBJaoT7WtHSli8jhOZ032Wj1RpeYjN2BUMAScozZZkRtzMFj55VqHjjkdReBd3X8Y9XqeZV+posH14PE9dGJk3/A5tN7IOgJGh5F5JQb1shxHhRf2yJkG5GUz+brCSm4h+Zm4LGVys9/ThWhfQ2OoouUm1QPpPhJUEJUetiPisqkRhkZHuT7dUgyf1hcPj2xKQzKYWUWoeDVEX3c/OND1jzd5xCL+Do/1Jyup/rNqKR6xm2iMbzvKuPJxS9H
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38070700009)(33656002)(86362001)(8936002)(5660300002)(9686003)(52536014)(4326008)(8676002)(7696005)(6506007)(71200400001)(2906002)(4744005)(55016003)(26005)(6916009)(316002)(54906003)(64756008)(66446008)(83380400001)(76116006)(7416002)(66946007)(66476007)(66556008)(478600001)(38100700002)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KNbDEO3AhOCkRTnfhhjv+xs3Q3SA975zkHK3DI1zSUVnlvQEE31iR3qGpmhw?=
 =?us-ascii?Q?Enu/Bcr9YEbj9C7jOb+w6MOaQzS4/9SdHRnceqt7wwo66OTQeZeDmUYHyzEC?=
 =?us-ascii?Q?SQ+izfegUjoO67k9WQ/XbMA1k5PGkPVB/TjumLDWiZdf5yAU4R5i6OwPjSNz?=
 =?us-ascii?Q?54pi2OYuSe3ABkc79wq8g4s1r29h81iHNtZ/2P0Ng/VtF/igQ9acaS03hrkH?=
 =?us-ascii?Q?dIjUMKoGG6ujB9KFieoRuedbj3cDcAVjhoQuNWVkQbdzN4DwozsWhSk6PXyc?=
 =?us-ascii?Q?9FIRBoFYIZ3ZMy+VCs3PxR1KuyEVU7SoagVlf0MeFaVZGToawhUy+Ldqzqy0?=
 =?us-ascii?Q?xapYxVW4UPYzdHqZmM7TVmh0TX5oFwdQkSxhRCCPHk+GVqy6pYlosC9vQJjt?=
 =?us-ascii?Q?l0yqoJDyhql1g/3f2xe617Myuy6OqgXCadbeIbPpsjtdGX8TZYZLoSHKFtA5?=
 =?us-ascii?Q?dek1D9WYxA7nYZFeXSGy/6oCgWMLPhUbsZJe7a1QFFgLj5O5cGyiTawCKZWP?=
 =?us-ascii?Q?NpbWOz8K7vmcKv3vEvxnUhSaUXRN8y+yq929ZSIY3p23yRFOINjjKrwWdAAR?=
 =?us-ascii?Q?5/DTsoIJtulXA73Nsnnh309zz0KkKF1ZsEqqRZr7aPNrdn0cbnhNSYFkD039?=
 =?us-ascii?Q?s4ok0xBGb1aB/iJrAYzpZ4ZoFjsOGNfEgYbL14u2IUVkmjji0xuPg1oQpoWy?=
 =?us-ascii?Q?lniqSzG/z/vqPN+ARGFkbHMbit8n92eCm/SDEEJLEBBbeAZw9rDUmch3NmSa?=
 =?us-ascii?Q?c9eOhO543N8KpwvA5zZcP9q8eAo0RPX7dtw38efvDYskE+UZ+GOYAKGXY7KI?=
 =?us-ascii?Q?C90Awh/VX7LxMtEdewwZwHNqgKqjmRO/VuHLYgumyFlVvmbWTDpC/5ppBKY3?=
 =?us-ascii?Q?kSL72q23KuGjEEpHgY8Ip09+bKokZ/bBVnytQ+ly51yci/uLQmYC2r/NywIZ?=
 =?us-ascii?Q?L0iwBiSE9/OvQ7RTpItduyU3WSQY5KtBVOZmon6Tz8X8HqfePgE57A/279qu?=
 =?us-ascii?Q?0+mpahfZ06eQ8rqOqyTRRhcYzkpyB0LkbrSbYQJprE6FtsZ07MCNlUVD45C9?=
 =?us-ascii?Q?X8wsYNKzEuoHiBmEFh93Wd0OohujzztlIkZs3Z0z6A4aPYVRs05N5PT2iqFr?=
 =?us-ascii?Q?VL4xtHSH0SIdzj5fefuZ671srO/YAl/eIEVKfVL4l+AT/lJqB0lbd9xgp061?=
 =?us-ascii?Q?oE0pp5z8vBySfCDj9ku3AQrYww5PEOrn46WXqHnxYG+aPmuJf/2Inl10I2gs?=
 =?us-ascii?Q?y+uyKYSlqhMiAqth45EgmblKsBJbO22bxCoAx+wriobRE88C/QY5CfkKPQqq?=
 =?us-ascii?Q?S/mKiAHXV82wMLwbYSHCdhWj02li1U2nNEo3gt2g2qRVkSOySkpkJ+q9cqKQ?=
 =?us-ascii?Q?1t2GXUl4alrLDhtzGuHcuQM3y2L2Q2sswc6EjdAcs33h3uNr1LX/7coBFMYh?=
 =?us-ascii?Q?XEQMYhApI81mH5tADn9JkygiGgJ90mnEq+qDgESmSTjMMpywex+jwFmsRjJi?=
 =?us-ascii?Q?s/QJdv30YO7p24sEDdq5WtKFis7J9qusPgSGAayCZRzOYSMRo/S/F1fOOUik?=
 =?us-ascii?Q?Vh7F9j0/i+W6ilHdaHvbG/ErRG1ohy6c7IC7p3kJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba6ec61-0f0a-4fac-77fc-08dc030bb4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 16:33:18.9656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeSbMjAZsy/gjLmxyRdLQuoE9FMGFVcpnp04Cf7FbmLUSS3XrzdQx0ixbkZAkB/ttjQjWz2zL8bNKOPDU4Hs5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3694
X-Proofpoint-GUID: 4k1jOUlXMF18SFjPOawfjmB454CqfH4e
X-Proofpoint-ORIG-GUID: 4k1jOUlXMF18SFjPOawfjmB454CqfH4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

> Hi Shinas,
>=20
> some minor feedback from my side which you might consider addressing
> if you have to respin the series for some other reason.
>=20
+
> > +	oq->buff_info =3D (struct octep_vf_rx_buffer *)
> > +			vzalloc(oq->max_count *
> OCTEP_VF_OQ_RECVBUF_SIZE);
>=20
> nit: There is no need to cast the return value of vzalloc()
>=20
> 	oq->buff_info =3D vzalloc(oq->max_count *
> OCTEP_VF_OQ_RECVBUF_SIZE);
>>....
> > +	if (iq->buff_info)
> > +		vfree(iq->buff_info);
>=20
> nit: vfree can handle a NULL argument, so  there is no need to protect it
>      with a if condition
>=20

Thanks for the input. I'll wait for feedback from others a little while lon=
ger and then address these in the next version.

