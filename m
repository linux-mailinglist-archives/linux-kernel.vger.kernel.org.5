Return-Path: <linux-kernel+bounces-17983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372C5825653
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC721C21D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E22E414;
	Fri,  5 Jan 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="kUDQnBZr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4C12E3F8;
	Fri,  5 Jan 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405Cg5XQ032535;
	Fri, 5 Jan 2024 07:08:23 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3veaw01mh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 07:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6XvwStz7dEO90Nwo1cSYCs3dVq+gn54PwQ5B4mys+yBq0k8iwvhKhMg7epU6vpEflENf5mhVjOjR9lcFUj7koSKD5yYl+1ixs2f5UbcWU9R85rZjq98MEbT1Sc+ye0Pd6wDtnjh60Gdi+BLMNu+q/IACwqVD3VDbU4D+O+uXz9EXYCz4iCaNr0Wy7MzUlIDU5DJoU0RZwT3TsIuEC5gUUxchJYGhGGHs6HFgif3lEXqa3cnINTY7gGRxqkySFJuUWqEm/eAJagkyIdLw+N3aNVqNhrRkvliew+D5BVEbink9lM7MxsERc7u9NT8YEmfPHQVT0HJoxjSfuRDygPadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTh41LncTEx4xgfwTgat09bhjszOhvGqrolVqkLaw8s=;
 b=R8UrH14mmoNSOpexOWAEvDCOr2eg1Tv05kzLOUFtMmFY1Tc07gsqlJpiPSnkJ0NfD4sH+5c9tAzqh+4bjol1DWIilt+GaYl75M2ffd6IwY53ZwYNBacWTIIXLKtDekISYNESFB5Ma4GIMoMzFLqB51og9M7iWS6xHZDe4RzxKgb5/FCDElkWn41mfC0HhUe6GP0YXqsXawPblHB++aV+hlP1qiQfKWB+KBkMqMflDEKZUMR0QqMZeuRJ0zmaWgnu22ooHIixcweIpiJdtWDJ2ZA/6Ule+5nNC7qB3yFXtz+Skbs0VqLIo+F13IX6t9tqulV6jR6r/ZArJEDyv1cHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTh41LncTEx4xgfwTgat09bhjszOhvGqrolVqkLaw8s=;
 b=kUDQnBZrFyEekDAS63hBU7G5edFd+G4Lgj6yrYSOtlGLrXNDxzQMCxZ4Gyt+j3loTujvcT8uDIDziItlJY6hlTybfOSPYSBj13ltsQtfLlwEpK1sGIb6XHWYMo31XRaDIfJvQe6CWxz69YEDmfhlxwiDk9g3VKOnfGkvuBP9HhI=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SN7PR18MB3887.namprd18.prod.outlook.com (2603:10b6:806:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.9; Fri, 5 Jan
 2024 15:08:20 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9%3]) with mapi id 15.20.7181.009; Fri, 5 Jan 2024
 15:08:18 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>, Vimlesh
 Kumar <vimleshk@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com"
	<mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
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
Thread-Index: AQHaNaXX1bcgGLi5HEmdzaZKEl99WrDKNr0AgACszRCAAD9AAIAAQ9OQ
Date: Fri, 5 Jan 2024 15:08:18 +0000
Message-ID: 
 <PH0PR18MB47342CA6504103E68348AE96C7662@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231223134000.2906144-1-srasheed@marvell.com>
 <20231223134000.2906144-7-srasheed@marvell.com>
 <20240104130016.47bc1071@kernel.org>
 <PH0PR18MB473450986CAA852218F225F0C7662@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20240105110508.GU31813@kernel.org>
In-Reply-To: <20240105110508.GU31813@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SN7PR18MB3887:EE_
x-ms-office365-filtering-correlation-id: 38a79a17-69fa-4246-12ca-08dc0e00267a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8iv9W+RXUqGTCjkUzlw8Xvh+1zLHzq8uPkYS71RL603h0B/BLWTclDoK7WQtxM0K+lgmH+mh65dQ4ZhaafaH3JsvsE6rDhheFGzXYdMw5Uab7ckcgDvGOOKO+hbnRZh/NNLB+Rtw1cQSIT+Wgu6Pa6iFTP2Prawn59PeHM3tVY1QygjJ75FvLLylgrsXJ9VLiOF9bpq3WkcmCyj8sznROnUCzYapm889sAvkdnJC1zVxD+oIs4QFSS7sJxxTLqOCt89FbSCo+dT5zwsTsPfZngOHiHIe31GL4twxfNEysQEM0E6Qlta4HQlorzrSYWx0B4ncwjqYAUGYs6UPvyNjloZYl/S0e5wVx+0gSNYr04aF0qbUEs5vX9+DyCfRlkx6VUM6fVqiSKrSn6T141CPW0NUYSd2ab9XnuI5UKepL0MG3B7JWUXNdpnxL5yFODVpZ1eik2voDG8t5B4YvJy3rH0aCX28im+I5u+yJI+7NhZoI/0uydSkpFHbszQMjeXMFsnkBST90qdPXwmRKCj9hN38Eds5qodMbg7lrGCI+N0WbSGNfvC5GMVrbYpuOkPsxIPU/L0xSOyZEAR0nVy0JJs+mmk7WEtx3dfEamt8llVk6sEn1Ijd+SxXKmWeGyDD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(9686003)(53546011)(38100700002)(26005)(122000001)(316002)(5660300002)(8936002)(8676002)(52536014)(4326008)(7416002)(2906002)(66556008)(66446008)(6506007)(7696005)(71200400001)(54906003)(6916009)(64756008)(66476007)(478600001)(41300700001)(76116006)(66946007)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?NvVB0fr84G3FD3nQjqw4jMEpkI5r0S7FctuIujRqkdBrgGAsgHPBBbSA1fSm?=
 =?us-ascii?Q?GJZhUXcKwOSJxSKYd5DvBw4QQu94h8M4JSi9QtxD1JUfWV9u57CQLq7ebiEW?=
 =?us-ascii?Q?wyuNhlzsCUtH8aTbl8hFLN9IGGRFwXjzO25l6vfmTDi9u43OkD2iBQ65pyD+?=
 =?us-ascii?Q?kKqYImNyFiNoxmjRR1wG3572ctG9a+tIrnz+YJw9N5OpBJq5skRv/xgbEUGB?=
 =?us-ascii?Q?P0SQZGVziCxjn88Q+XEpPlXIb+Ti8FoHdskLlKLdZHun9a9IukYh8jqf5mzU?=
 =?us-ascii?Q?C2I/CoJ5PTDGgWfUdrJlp0NWYTiWrkutmfqXrTYOfjMq3+2RoLUkaU/UXR3I?=
 =?us-ascii?Q?PNmvr4HzqU9v6DV3hr+TogMdebPbOT53bZ/yMwu4nO0Kxmaj1pqR/NYafOIw?=
 =?us-ascii?Q?7NcDrCN81IbFV6yWRn12ockgdNp+b6tq+1hAZrSsatzNhxS9WB7NzkHIoN8l?=
 =?us-ascii?Q?D4QpsW+6Anmb6mpWkewnISUorOKcs0hTn5i1FgwXQRDn/Uw+JgqgGKUCLcYY?=
 =?us-ascii?Q?hgT/pqO2LymgAEhkcfGU+xp8/wnuDGYxaLExv3HTmOV+z0bAGG6eMXQo7ESS?=
 =?us-ascii?Q?DRUVSziuTb1hwUUs6mZt3FOhDxoR/VZ9MkmIRLbGLLWrkdUOThtzz66qswPS?=
 =?us-ascii?Q?597hQl0FTlQZeH7ky7Aw3kysI1Eiu2woin2b3YIVmF1VTCwXejt9dX0fEZO/?=
 =?us-ascii?Q?WLn+fbxMNb1+s/E6y8wu6PqVQ/BheAXBgUbtoB480VLbuLy3nSPXg3zjRTRo?=
 =?us-ascii?Q?xxz/DPkYg9sypkan3c3GWsUaT4GrPbf9kQIUfPUxziWt0OwM6GjCBzl2crql?=
 =?us-ascii?Q?dSwlvu7M0V3e4D3StjB5ocEil1hnumY6nB3fqgOaF+/6Ep7lv9ZxNns6jAJo?=
 =?us-ascii?Q?fUxtw+9UDUi59TWoZ4jbrQRhfyM5R2KljGt1XqKZo7WHTld4QQ4q4n1y3S9Y?=
 =?us-ascii?Q?w5o/7ZDgX57DSfyXP7x34KSJv0NQD72ddySK3XA8DYLqfhaR4E2QSZqDFHwr?=
 =?us-ascii?Q?KBEK98I1FEoaSBSe+58kN0XU5io4FOsBjwhJy6eZm/HkPgMWL2IIFVHpVw6J?=
 =?us-ascii?Q?DbMTcSdRb10mRXnx+ezr7ixAWMLwz9zTxHLTjz5mvr3kwS3oynw7xDEyrsZz?=
 =?us-ascii?Q?ePYekMRuHxfuGTo22nyY3eAnAR3VmnHuTZrv9UkZOkzMFUWioytS8MT42PFi?=
 =?us-ascii?Q?grfRiP36Qgf/otpLD76rpGODWd7tT6Xt77f5/ktaCNn9I3CTJIny45C/fK78?=
 =?us-ascii?Q?YdVZBpnomgYofdtZIZCNjIMbvpKxkh3niTB4piCAqa0jv23NoKxcCu3fHAnf?=
 =?us-ascii?Q?hBN7SnmkAzAqE2+3namK3VP9nE0R2oNzIZARlfJfpeHrf4mCvog07Ts6fCKP?=
 =?us-ascii?Q?2PAt75IoDVcONff1f5SrXo+F0av1I2/mYM3AsaNtoDqtXR0m7iwVt6bXO+OF?=
 =?us-ascii?Q?tfeYWu+gVvYWSaX5J0ZOnlic4N5EXhEBbQ7TEmMMox6Pib5DgzTVdpEBelWY?=
 =?us-ascii?Q?q7mTh6AlqBwUjX5zEUVTkWXk2M66b2ieYih007ScAtt0v+ywbu+Y988MeOHh?=
 =?us-ascii?Q?wj3tqEPShEWNmPfv9PjLMagsTtajkW8hS3pbujtB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a79a17-69fa-4246-12ca-08dc0e00267a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 15:08:18.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGKwWLyMIzV6RyBlhKf0TfjVlnHiX1JpDSEeoJAbEnp4TKsD5gjM7b/cDmy1Q1TOtNScp7XaVbSVsxNM8pIE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3887
X-Proofpoint-GUID: fnA4DPxSlZsWtXAEqtthAVbhPmKRTGeN
X-Proofpoint-ORIG-GUID: fnA4DPxSlZsWtXAEqtthAVbhPmKRTGeN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Thanks Simon for the comments. Will update in v3

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, January 5, 2024 4:35 PM
> To: Shinas Rasheed <srasheed@marvell.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Haseeb Gani <hgani@marvell.com>; Vimlesh Kumar
> <vimleshk@marvell.com>; Sathesh B Edara <sedara@marvell.com>;
> egallen@redhat.com; mschmidt@redhat.com; pabeni@redhat.com;
> wizhao@redhat.com; kheib@redhat.com; konguyen@redhat.com;
> Veerasenareddy Burru <vburru@marvell.com>; Satananda Burla
> <sburla@marvell.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>
> Subject: Re: [EXT] Re: [PATCH net-next v2 6/8] octeon_ep_vf: add Tx/Rx
> processing and interrupt support
>=20
> On Fri, Jan 05, 2024 at 07:26:14AM +0000, Shinas Rasheed wrote:
> > Hi Jakub,
> >
> > Thanks for the review!
> >
> > > > +	rx_done =3D octep_vf_oq_process_rx(ioq_vector->oq, budget);
> > >
> > > You should not call Rx processing if budget is 0 at all, please see
> > > NAPI docs. Looks like the function may try to refill Rx buffers with
> > > budget of 0.
> > >
> > If budget is zero, octep_vf_oq_process_rx just wouldn't try to query hw=
 for
> packets. Also since by then, the refill count should have been less than =
refill
> threshold, if not it only flushes free buffers back to the ring, (and tel=
l hw that
> there are more free buffers available which have been processed from mayb=
e
> previous calls - but this seems unlikely and should have been flushed at =
that
> time).
> >
> > > > @@ -114,8 +158,8 @@ static int octep_vf_setup_oq(struct
> octep_vf_device
> > > *oct, int q_no)
> > > >  		goto desc_dma_alloc_err;
> > > >  	}
> > > >
> > > > -	oq->buff_info =3D (struct octep_vf_rx_buffer *)
> > > > -			vzalloc(oq->max_count *
> > > OCTEP_VF_OQ_RECVBUF_SIZE);
> > > > +	oq->buff_info =3D vzalloc(oq->max_count *
> > > OCTEP_VF_OQ_RECVBUF_SIZE);
> > > > +
> > >
> > > bad fixup squash?
> > >
> > Sorry, I didn't understand. Can you explain?
>=20
> I think he means that this change seems to make a minor update
> to code introduced in a previous patch of this series, and thus should
> be squashed into that previous patch.

