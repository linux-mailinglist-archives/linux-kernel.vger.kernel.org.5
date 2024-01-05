Return-Path: <linux-kernel+bounces-17545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA1824F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FC82857DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B7D1EB45;
	Fri,  5 Jan 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Tv9QXSBJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA1200AC;
	Fri,  5 Jan 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4052qL6V025149;
	Thu, 4 Jan 2024 23:26:19 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ve9c7gn4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 23:26:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+EiEk1stNJ69CFnfsEceSe+t2Vb2UgUHy1vf3jM+na5EOTNffnJjqxCntD+KvZESHz5vrHYa7HeSAEvgEMxyJtAZ1ArrUWSa+DFIxqShbtazHvfrkRJoxciQ4uoVSVfbSNCjIHFm/ap8/UC88ay2yjVp+5wu8wIGJDRbrsiIBDfMaCLX8XKpd5LaAgQqoucAuBL+IviKf3pNvWevcTaE716jiqVSoX1qToABauzDkmzJQNJhblNqSXbXH8yCGp1LnbAUA4/DbQVo10yYhkmere0kBhA/mXjflSK4mgzFFTN24zMNOBOo8E4WFacsm+/dEnD2kZcZuoGIxY8UzXrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laaUTZxEppN/DfiWuV1H2KueZlB32uBZhj/kw3aNEkA=;
 b=QO1xiXVGc06PTRGE0fsUEC/H9fcnpmCK5WdrM8wJ98WOG3Ud5TMOh5WJFLmZegehEfnRp3micIhkfj4gbzwcQGtXtLdR36nVjYrHFR6q7txDrcADwKFM5r/0k1YxZZjljjACiXyVMaqLEPXXi7qACrm+0iHndqHAph01IIAi8kmd4zSgTDYHOUyvKaH/NQiTrD3qzgt4SWIkQQx//l+fQ27XU32GVDh4fJ68S4qkSac3f1/tx8oNtbqYzvkvX1xdoUqOjZqh5Dg7wJmRs8cQk9Fh2pOyrfA37SI5339tn7DyIMIMAIrOqQbnwjdCWZ4Ccy95GOjTFGng7lZN5OAX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laaUTZxEppN/DfiWuV1H2KueZlB32uBZhj/kw3aNEkA=;
 b=Tv9QXSBJYqSnwS4z4CCM1TAfbFeSIsTQpMzRhcNXdMjC65vyV7++enA2s7zDJDGxLsc4pqnOfwX0ZPIqe9gteM0gDbGkHcseklzMcWN2MicXJwDrQu1GSEDMdV1K8558ltvdzVsNwYFXmZqfXoDY0vp4U/5oAJBjovloT/i13uU=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by PH7PR18MB5308.namprd18.prod.outlook.com (2603:10b6:510:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 07:26:15 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9%3]) with mapi id 15.20.7181.009; Fri, 5 Jan 2024
 07:26:14 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
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
        "horms@kernel.org" <horms@kernel.org>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v2 6/8] octeon_ep_vf: add Tx/Rx
 processing and interrupt support
Thread-Topic: [EXT] Re: [PATCH net-next v2 6/8] octeon_ep_vf: add Tx/Rx
 processing and interrupt support
Thread-Index: AQHaNaXX1bcgGLi5HEmdzaZKEl99WrDKNr0AgACszRA=
Date: Fri, 5 Jan 2024 07:26:14 +0000
Message-ID: 
 <PH0PR18MB473450986CAA852218F225F0C7662@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231223134000.2906144-1-srasheed@marvell.com>
	<20231223134000.2906144-7-srasheed@marvell.com>
 <20240104130016.47bc1071@kernel.org>
In-Reply-To: <20240104130016.47bc1071@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|PH7PR18MB5308:EE_
x-ms-office365-filtering-correlation-id: d260bd4e-4e2f-4871-6eec-08dc0dbf99b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0WhC2Y0Sz0ZpoQ8Emt0cSwSwJn/Vpo8vBF8Yab4plhsLhcK9EK5UDclymwcJHuqnaJT3Q88bKWnJbdd1eRby+0z9Lzr1Do3A2T25bHfUxOT9eTufWfFUgbjHsnOYHdSdfw5JFBjiLVpeSC1skrrR9VnDyxJOaQYRNVXHB4CiYqOdzloN/PQgbPeMOfJQRAagC5He2dH/2l6lEq2neWmgyFAerifx/CPYcTmIX3hryEUOOdv7aOtdBQUVJkiwNjVFgNlzZ/sCWwMa63KMnIxDQj//rbhZCmW6R48+sqcnAFHCV7JA05ddDqNEnelGpii9Pk+oJ9wzBCPn5ZAll6ZBwOwMHdEZU+Oz/KbAvSHO5wWLvvJgbv6VI/XFSiUSmhebWKfLlcZvgfuEQWdPxDAz8308npnpBTv/2tmFjkTiBDyHHzwr6GIWpYbc8KdmqUIlUfgY34LSrUhcPc+imAhlB/T2eZ+OjuuCOroll6rHHs1CwrEdpDtJeJvVSYSan++QRHOC4w2u3ZTtHzXj1qyS1yQnTJDsAujveV78plWZmGGjIkeevjia4yUcweyAXbH5dAmQKB/Zcjesxe0KhHZfTFoAajaG8RcpJSELaPFx47oiL+GgC8+aoNEEWXpdnhwo
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(9686003)(26005)(71200400001)(6506007)(7696005)(5660300002)(4326008)(52536014)(8936002)(2906002)(7416002)(478600001)(122000001)(64756008)(6916009)(66476007)(66946007)(54906003)(66556008)(41300700001)(316002)(66446008)(76116006)(8676002)(86362001)(38070700009)(38100700002)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?m2DqRRJYODEPugSMJT5ZaB0RKBpYBRse77q+0IfcHo8ljGYXdlfAc4awpkkD?=
 =?us-ascii?Q?Y9p2yhpNkavUTMETd3p94f8Bch6NNhJsLl4hUDqAhCwB2Mb/sqU962BHUeow?=
 =?us-ascii?Q?FGuNocayrFRZRIMj6jL5YF5p4Rx24qB6e/hruyi0K+/Gcej5w9uf0/9tFKUy?=
 =?us-ascii?Q?MN8p7EtyYfh4pVXRuY+npas6fzKinYZZSbmu0ffVO+aBMuP5WfW42/2BhiA1?=
 =?us-ascii?Q?bVd/LFfgI9KAd02zYKNMEcOhlyZUZ/ZhFKG0swaqrow+s27Zku60dexpXNvx?=
 =?us-ascii?Q?Gz4BofDqjPsj92JDK+CdPVm+AjYoB8qFqdzwFToAaCP7aXrL75b6yTGB4S4a?=
 =?us-ascii?Q?V0frgooWJAEDxXRjKIEZIeVPjXl53nf9fU90whnh9at6aUkT9tUYQlE/Adlj?=
 =?us-ascii?Q?VDnuk0Yg86aZdt6tBRXuN5NoIxepc//Ef5oaN4W9h4RvYu8Idh417/EWwi1L?=
 =?us-ascii?Q?vUWX2w5nrl+JSVHswmPP4TnoH3LKR6P/7TMCZGSBsdk9H9CImqJocg3m9RYl?=
 =?us-ascii?Q?RiWFHWpMva6860vE96ShfJ0W/wcKNMPmPDKRk5QCBSmMSnAfYjvKR6MnZG5o?=
 =?us-ascii?Q?OuX+1JREH6PTpSzSgAEmT0F1Z3tk+X3PHnIRedAt+y7cCBjzGYZv+g38W6k3?=
 =?us-ascii?Q?7FiLePTlbe2mC5Ow/PidTP+FtIyAAIDNyfgROFSDpdZj2EMwDQdgalwXz51G?=
 =?us-ascii?Q?6vD5w7kks6ZRir8GTVNA4I54LuWt24v709VARZVQAAIKSopr6q/emf6NWuqv?=
 =?us-ascii?Q?LTrdkfgEyiEDZAzqLmuaTWtXu/11IFGyFl4gZGVis5gmkGPKKm7zTaESbCFd?=
 =?us-ascii?Q?vvNPqtJv+Dh0XV+xK9buPdUacsfX/a7z4KEAF6+qWGzd9HUpQi0WMfSS90zn?=
 =?us-ascii?Q?5f7S1O29tQktBOA/bFaNftVIFhqrkb1l04+eTHsKGywfO6Jo9PugP+Cc37mq?=
 =?us-ascii?Q?i40yp44gzKav37llEGL7Rf5GMs3d4ODBgCpWBcfi+UcvA6SEYCpYj+zjWxI0?=
 =?us-ascii?Q?jlv/NisIkt2NpU3OaMiXGW0EqKsYiIxFlC7paBzBholdsIpG1EHTj1I8fnqi?=
 =?us-ascii?Q?F5gKgqEUR4xRcpo2vmibcNWDXVOokwHy9qsVHvd779SS5P5Knt0Hm0boOJKQ?=
 =?us-ascii?Q?hHcRLqTnSd2sSChVbvuH5rAH0xnRMw8BEvwinqTXJ19W0JobXeNYQxyS9h75?=
 =?us-ascii?Q?Erp3PbFpT+ThOQ9jGCKbjNJ1IzZwu7hnjRPQ55CZUPsZisE+akT2wNB57yUK?=
 =?us-ascii?Q?KzO9JumubFlfk2UwcXoJsEw6TLWbkmvOlHk/twKQAgIZBH1/lTCbZURE3vbE?=
 =?us-ascii?Q?JGqKG4u1keDcGCxbhIqsguCi6FBVUgakTE8siuYX8qbHSYiObDxSonvzULld?=
 =?us-ascii?Q?f5ZWSmPNTIzVKnxu5UI/M+frs597/JH+A9jubEkktz1rPl8OqEvVv8lEvU8W?=
 =?us-ascii?Q?OTvAe8zA7gKkuVLlKfxIEOik7kkghS4sZyl2AI7ZeVyjIMs4TFXEt4m/SGmd?=
 =?us-ascii?Q?8BqNNwCzSGg3mpsyGyoody39e7Nn1RPHra6WCU1fJn7R/2Bc5XpkW0lsQunG?=
 =?us-ascii?Q?v9T8fwiCkxNfABCRDrJSu+wLk5Sbha/sy7+eVO05?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d260bd4e-4e2f-4871-6eec-08dc0dbf99b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 07:26:14.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MosjrfrRRhT17BTFbvH9nD8V9lRTJyJnMfdapid+PiL5gxQuXm+QQA2iWUDrPbqQkeBqWEXizVla9HMX08SKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5308
X-Proofpoint-GUID: Vslqs7rXUzxF4fv_S_TgB9rYWs4SPfyn
X-Proofpoint-ORIG-GUID: Vslqs7rXUzxF4fv_S_TgB9rYWs4SPfyn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Hi Jakub,

Thanks for the review!

> > +	rx_done =3D octep_vf_oq_process_rx(ioq_vector->oq, budget);
>=20
> You should not call Rx processing if budget is 0 at all, please see
> NAPI docs. Looks like the function may try to refill Rx buffers with
> budget of 0.
>=20
If budget is zero, octep_vf_oq_process_rx just wouldn't try to query hw for=
 packets. Also since by then, the refill count should have been less than r=
efill threshold, if not it only flushes free buffers back to the ring, (and=
 tell hw that there are more free buffers available which have been process=
ed from maybe previous calls - but this seems unlikely and should have been=
 flushed at that time).=20

> > @@ -114,8 +158,8 @@ static int octep_vf_setup_oq(struct octep_vf_device
> *oct, int q_no)
> >  		goto desc_dma_alloc_err;
> >  	}
> >
> > -	oq->buff_info =3D (struct octep_vf_rx_buffer *)
> > -			vzalloc(oq->max_count *
> OCTEP_VF_OQ_RECVBUF_SIZE);
> > +	oq->buff_info =3D vzalloc(oq->max_count *
> OCTEP_VF_OQ_RECVBUF_SIZE);
> > +
>=20
> bad fixup squash?
>=20
Sorry, I didn't understand. Can you explain?



