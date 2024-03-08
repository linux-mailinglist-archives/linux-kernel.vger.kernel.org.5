Return-Path: <linux-kernel+bounces-96546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DB875DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409B228362B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A79364B8;
	Fri,  8 Mar 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="kbw+DRvI"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B32D634;
	Fri,  8 Mar 2024 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709878197; cv=fail; b=Tw72/woBbAgiVzdLBiOs8ihmbEybr1kAYox5nPHAg524dcN3LcsrJjJ30ao5r87T4WjCmn6+a4XVBjuJQvSwtP3xlAOXOLLDSnHEQsFyqMPSxqPNUA9X8HBlDWTApM6gcEYe1WsNELvhR6KWECRheNXGrSlz/ZfX88UhCqfo+EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709878197; c=relaxed/simple;
	bh=4OdMWdCtkHEPk6Ck5qrdzwYnqvl7EpKtaWQ69h7DAcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5GOEo2w9QE3H/SB8z6sxngYlL+MRQm9cc9SUskgPPKjaw7itkmN1fxtdggFQ33mDGklWZWz8gbfbCZKFV57wX/RQ4pMBx58tv1nQ7J5BIomM9R2Hda3bYWLWCBFCOfV/euMYiAdP2WCIGIvpCcy8TiIKfdU7Zy8zWC+bcUjR80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=kbw+DRvI; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427JDd1C020847;
	Thu, 7 Mar 2024 22:09:41 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wqkj5squs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 22:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/84CexH2cKb4z9dzipVOfIW2tlSpPhNui3LMA+k2yPowYrkySnbIqHtMnbFGfBx7R4EXiUjyJ2dycJ0g5IYTBVP/Pyt4nhhJgnUi155ORMafXKn8HrvfgoPE8wzjya91oksHIwguw7GkvmOCRtSl4YRdkObrxH8AW8B+Pq7Cqw+aWryf9PKgSGLDq0tfjHD2hyr1n+QonzNshjnv/CzP6PRFUphX2F7dC1N3i2k1bwN8ajjRfCrTBzLnl40MBeP6xEq7UuD0ZLK1MfJ+GJesq6Jc7n4J574rBFxU0mrpw7TuolK96n9gvJUGwPEVcJGEVVRTCPIJqK/OZR+twyBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JVAtw+3+0MEvJFMqFq1CP1B8W/To1yvkCx9lSWBmvE=;
 b=dI3E5jexzVHEQ+9vBQLjDuHTRxfjmtMVi0c9jBWUDTBnIpeQDZoHNR3WgbaHknbAOBA0985HYGoxfr5RbZLV/XX0JcbCR274MKulbFftA8Xkpxb4n4j3tPCYfd/Q/RUnR1iK/NdNzwDs0D0JYVI8199Y6J046KX/OR71P53g8GRkN44ZEKa7sZPefWNT82kDvZJ5+0DtoFZ7xxfsnA98d2gGxhL7TPEeal/EC1eUpGkob99Bi03ecc2VJ7I8wTEvB+hCZcLbRUOBfLhUkqwcloEuXSZL5eHNyHd5UZ32xsdOT5bFq8kagmSJWxZx+kdzkuXB/cNTqBCvW3S6unZ2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JVAtw+3+0MEvJFMqFq1CP1B8W/To1yvkCx9lSWBmvE=;
 b=kbw+DRvIv41lebAERPcOkykCtWV8+RAOHiYbuGAQS7pTxogn88OPzkFzvck4qdxbpYnSNcFyJjSIeRIS4bHVJX3GQ0JsCq6bcP86DP8SZi80evdf3HkXyXXxbkPylh0SkCy4OO6tl7eTxLpYcdvvbMFf9/CxcdOE1pdeRuw2mrI=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by CH3PR18MB5891.namprd18.prod.outlook.com (2603:10b6:610:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 06:09:36 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 06:09:36 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Reset MAC stats during probe
Thread-Topic: [net-next PATCH v2] octeontx2-pf: Reset MAC stats during probe
Thread-Index: AQHacR8yKrGa4MnfIU24yGWkdxB9Xw==
Date: Fri, 8 Mar 2024 06:09:36 +0000
Message-ID: 
 <BY3PR18MB470736FBC23588BE63656D50A0272@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240305082707.213332-1-saikrishnag@marvell.com>
 <20240307204725.4dddcc9d@kernel.org>
In-Reply-To: <20240307204725.4dddcc9d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|CH3PR18MB5891:EE_
x-ms-office365-filtering-correlation-id: ec77cb5b-13a2-4c2c-2533-08dc3f365510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x08ehUBWBRy7kttkl6l3YalsnA1R1cgCEZ+vV8J151yo6PsdQsYRPHegNP7y8cyqd0LQl5n0thuy9J1elruQPbJxun4bsCInDWmD6FTdEqAHQjbY5al0mW/n2oJDOnrA8AWStwVseVRf1w0lCercWXdv/1GMDETHSNb2k3oMca2jSbkflC2TtlCBAnGmI7J/HYfkDkDitR2LSejbsKSb0iU9PZvMMv7Od9JZ04YDCn+5GEgR4zuG1ytN9CeW9+mFIDz3zc/xVyAdpmdxPXH6qbhSjNfWET5kg13EHaUmGs/2BUP2Rgp0+YCQxZyAqXoE/SIqAIDXScVMKiygWyLgd6ESzIRITrIUB04oyuZdRC5NsM2A5WdBYJXEJFEUzTXemkng6TfNNb5ri6hE6F1jSImgX8aQqbVCveueYYCnSXqhqB89px+Mr2S10yQs4TeVdMJlgg4pwZ32mnDIkgF9/9jwkSpTFJrrlzWoZH/Lw55hPVIFZW11kVo4VkB1KIsyOtq4utDH4YNIH/kGrqJUHJ9PF/+ueFSnD6ZU5jOr7G82UwdZK+21j8W9CBEcXWCiEsL+ZFDJ0KXQYw612OddGNMOe/eYdGzhpqOuYukC2HdFVKQKZATVQoe3MM8jiil4jhwxUWFx8iRvE7Al7OuLf50Nc57o3FMYbPcUIH6p6Ru/vsjDbueXc8N/i7PxJaCbUc/tEqqKDvZCk0xKniT5yg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?dNrhgE7m+plqBd8WWefrVu0CvVehf9q8E1BBrMVOj1LAFUiuGVpEaeJMOUm3?=
 =?us-ascii?Q?mj6oAyWnX9dmmgUnwbq320HjK+nLde7SLFZApjxcYF2Uc75MuEJgEqkIrNUS?=
 =?us-ascii?Q?bR+AquZWJu3seVU6cDrFu/zkpMGFAUTnKgqhJCFO/f23WA9BJACLoirvwO44?=
 =?us-ascii?Q?DrC2YVXE/VTVjmKyQt8jo9UR/gzXSAfR0YAVaj+ridupWmdljxludUmZNHo5?=
 =?us-ascii?Q?M7H2/ar7gZHu0m3JxkAU7XyQD3RvqOQKL0qS/0WGmQRt1AfA85n9DNcND8pQ?=
 =?us-ascii?Q?+lK0Bl1wJXVmkio+Jkem1GM7IgByoRNdC4Jt4+83YBdrEtWg/RVUbVNJ7n2h?=
 =?us-ascii?Q?O3dP+cU2peL8Lr3V9ZzkIMZrLQDGxj63gy3gL6qpaUkOUa6/KkLfI7yzEh5+?=
 =?us-ascii?Q?uViQnpLXytbpxyDfuWTH6aMCR3YZsBKqQe5m16GI2dSDiAPXrvDeMka+EJ2V?=
 =?us-ascii?Q?G9FJFv7TFE/Pwib8+LRJ4Rysp1fkxzdmud9KVYK7lQHcHHsa5cPI4AqhJg+n?=
 =?us-ascii?Q?o5eUDiyt8KNXbov7vyU2rilnaorzRlwHWzAwyqizZFkNYrW+aXHcsrRw6PgI?=
 =?us-ascii?Q?EgHHrmYIDWZUE5wgrP8ee65hSUDMtA6UcE9uxNRfWlp0F2LiACjnqxicL0cT?=
 =?us-ascii?Q?J32YJY7ntO23Hx8CWoI11Rselw/UoWc1q6Jsi4aLmsMsh2ChIMdZ8SsrzWns?=
 =?us-ascii?Q?j0r0D3H8a7UAA9P+jx3jLmwf2Vhpg5mikAV6jFLJ6EOW/1j60yMX5pgt5Le2?=
 =?us-ascii?Q?LxuWxVSbi8K1ELKpAIzssq+b53H7O6IMH13PA1xTsCrCIshphluhmB5tCZjK?=
 =?us-ascii?Q?cqK/TrHLklvxzBqJo42uoICnJ/PFxPoB7qB/zei2lSRbhsmQwoKl0XTz/kUm?=
 =?us-ascii?Q?S02LJH3MgNqIpD63kIWmUGHk1MJPpcobCEeLlTWW1EGv/YlwC+6gjTS66Ym9?=
 =?us-ascii?Q?6NrEcG+iTApU3AfTJRJczMuRlYoUibeHPbR0LSmRUJ3GpBeq07vQf3KeyOzP?=
 =?us-ascii?Q?dP895775WAJZbsx62TJwFj/jsBg3epDKJ6AlTmHViEM0HF4XayWlWwZpZhX1?=
 =?us-ascii?Q?gKdQ0v9jsfqtw0GT65zkVt3pzFXlgCQukMMS4ll89VOJ4MLhAm76ZKNCEwF+?=
 =?us-ascii?Q?p8aH7cuy87u6Y+xe69BBnv6Bcy/N7H3VzlmMyVx+KPPBCZ27WWHOh2aLyGJF?=
 =?us-ascii?Q?RG4tdTtn9clzPZpkT6XrUMk+lnsQJ0shBvCfGgdEy2NmEcccK3KmlnVig+M/?=
 =?us-ascii?Q?fApCALfTkV0FNFgO5ckZ/aana7fx53raHeo8EvD3D++inHQZsQKxsXfUIM+l?=
 =?us-ascii?Q?b0DbSyuaxuvfeAGbAKXGyoS5iHpLIrYAhfc6+SeibVunme6T2EwbdJl3HM0n?=
 =?us-ascii?Q?nohDfALGZdVW5wJLzg4B0wdrRma9ZDHCbdkZ3Mx+iAT8c/0SF7e8VrOfWlMs?=
 =?us-ascii?Q?4ybliY9oZqqfUeLXMSconKzMOJKz2I/XUAKifHECfj+8zD4CbXfRrvMRdEYM?=
 =?us-ascii?Q?vN1g5eOfrW1FXO4UP8RqsL4ltQIBFjZyZ4d4jBem5sXg/W6V1yxgsl6taLI1?=
 =?us-ascii?Q?w8i6Z7dEP320PrEx+9ynP6m3g1svniwFQx757CV8?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec77cb5b-13a2-4c2c-2533-08dc3f365510
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 06:09:36.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLnzZVKlBUhZvxzQBU/JsPVYDQDP2yT8vOZPOOzmDmC5bFVvPjZGd5mEPjmjCslNz+2cfwDnUqW4m/M4yThTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5891
X-Proofpoint-GUID: 0sZj_jbExxvolHwAUKUSrNbU1u8nI-Fe
X-Proofpoint-ORIG-GUID: 0sZj_jbExxvolHwAUKUSrNbU1u8nI-Fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_04,2024-03-06_01,2023-05-22_02


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, March 8, 2024 10:17 AM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri Gouth=
am
> <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2-pf: Reset MAC stats
> during probe
>=20
> On Tue, 5 Mar 2024 13:57:07 +0530 Sai Krishna wrote:
> > +int otx2_reset_mac_stats(struct otx2_nic *pfvf);
> >
> >  /* RVU block related APIs */
> >  int otx2_attach_npa_nix(struct otx2_nic *pfvf); diff --git
> > a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > index e5fe67e73865..a91f5b7e84c6 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> > @@ -1124,6 +1124,24 @@ static int otx2_cgx_config_linkevents(struct
> otx2_nic *pf, bool enable)
> >  	return err;
> >  }
> >
> > +int otx2_reset_mac_stats(struct otx2_nic *pfvf) {
> > +	struct msg_req *req;
> > +	int err;
> > +
> > +	mutex_lock(&pfvf->mbox.lock);
> > +	req =3D otx2_mbox_alloc_msg_cgx_stats_rst(&pfvf->mbox);
> > +	if (!req) {
> > +		mutex_unlock(&pfvf->mbox.lock);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	err =3D otx2_sync_mbox_msg(&pfvf->mbox);
> > +	mutex_unlock(&pfvf->mbox.lock);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL(otx2_reset_mac_stats);
>=20
> Why the export? I see only one call to this function and it's right below=
.

Ack, Will remove this export and submit patch V3

>=20
> >  static int otx2_cgx_config_loopback(struct otx2_nic *pf, bool enable)
> > {
> >  	struct msg_req *msg;
> > @@ -3048,6 +3066,9 @@ static int otx2_probe(struct pci_dev *pdev,
> > const struct pci_device_id *id)
> >
> >  	otx2_qos_init(pf, qos_txqs);
> >
> > +	/* reset CGX/RPM MAC stats */
> > +	otx2_reset_mac_stats(pf);
> > +


