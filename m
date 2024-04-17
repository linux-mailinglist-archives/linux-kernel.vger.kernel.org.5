Return-Path: <linux-kernel+bounces-147951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAED8A7BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390221C21B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF519524D9;
	Wed, 17 Apr 2024 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rnuBPc1x"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E4524BB;
	Wed, 17 Apr 2024 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331087; cv=fail; b=KSaUctlwTwamKqaGCKzWJK83u402RL2OWmV9t9qX04UyNe5C2KicHvFNNgR21ax4289Pk5z4MIL95FCzUzfZTXlbNC5Ch1kJ7LTMusW8jGFsAH7S9gccT91N16R8u+c0dtklHAwhMxQU8QUO7XD/RyJquYmuEiwpxncPeq4oAXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331087; c=relaxed/simple;
	bh=JkTGdJcqlk70H29MOGq/zKZOnrOAS6qXzu5rxzcDdZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhLwDZrI8Ixkv3o4vJkdaWzyDjGYa/r/zHNOQl4QdcM99iKopR/jsMnf59MVYjpOrmBrNuttv87g+fVM3xsZUervlNh7t5EZVrctKCCWKJOJNpZ+9VegvPJQhbICOY5nT1KZRhTe1eGa58KVN2MCKU6+RZZhhu6iQYwix26IAGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rnuBPc1x; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GK1vJa017006;
	Tue, 16 Apr 2024 22:17:52 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xhfdn50b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcFn0aIXoyuW9bcaIfFfsqlBcMB3CbHCmVTYWDXH1FmW3h6CdGVCoX3m0BoxYIprEO+G/eMBx70+/YdCRJIzl21p77NYaJskYZkxgeYNFgi+cfdkIdkBYBzPsRXAZmLTXJ0hQc2IAG9VCHZfQHLTqSBIClYyKWGgu278lAfntPfezKdmWR9xoMGdQG1LBIr0wg1HT8jgPT96D9I6zw1xzCbFN80SVdH19GoZBbPzL8ukIuDmXM+dGkvtcnbnYIAuPTKYxe9fQFedRsnVhPO8qR69ynyJzft0mj8wk32hv1P3+eirPyAIx3Nys7VivQ/Ivkd+nFgNCRLkl0lG0srWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6EpYmwBJS6wtsL/X6jS63nAZcdOwbiWNMlmP7/MWr4=;
 b=n8IXaORs+NSHJQsnE89Z6gAc4+Sc1G+ftcPYLRhYbHfeyyUznkSrCK02hbfdNxGk3SBQo8NSdlw5y3x7CVH58r3VZ+xQdgVd66H0mJVkhyxFUufUk2xUN+7OTerOI2Q9BU9wIaGACRKz9IY11dCicT1bi46Amzymm/wngJ2VDFYf9ucieWGctpiFWSb0vbm3qW2zOjfydWDH+PPcHBQzbDKrtjrUP4lrW28/UwaBwj4upFSEylwy78Oxbi6dkFRswqco0LiRUBeX90REAvu5zHfzwt2bKE4+mAWXauZDpFVhQlriqhJYWgaWG7719eXn61qa06s9ImUmuSMlUNBhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6EpYmwBJS6wtsL/X6jS63nAZcdOwbiWNMlmP7/MWr4=;
 b=rnuBPc1xZupE4kdCOw325jKYiZI5lG+lfXCj7KJDrXkVLui81K1i86cjqrArRRfUa+NMhuyereJXcApkhAuAaMWBzlHi6uqw49J3JcEcWexryTU+/2+DhkKalr24P51hSeyCE8pEasPd/G19z/j8CQYEjdgXhf2Xy0898V2wESo=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB5815.namprd18.prod.outlook.com (2603:10b6:510:16b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 05:17:49 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 05:17:49 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Topic: [net-next PATCH] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Index: AQHakIaWlkZ9Gh8L9EajC5AeXoKhZA==
Date: Wed, 17 Apr 2024 05:17:49 +0000
Message-ID: 
 <BY3PR18MB47071C9FB7E516063668825EA00F2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240414105830.678293-1-saikrishnag@marvell.com>
 <20240416102236.GH2320920@kernel.org>
In-Reply-To: <20240416102236.GH2320920@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB5815:EE_
x-ms-office365-filtering-correlation-id: 33a7f982-dfdf-4e17-9fe8-08dc5e9db949
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Cln/WiqpdCSMZHGhXoFQRMN9DsA8+FHJY/oUo8edGWSpmNabbyWr2V4STWhvpgA+WEwOyWtDEvUMAadr7wATfUzwXX9lwa8qBiyjD8kR+CiHHWNkUh0bBMltpZIwBAOFOgwkGZlIzM/OfNQ0iRUFHLWaikxqg/8whLiMD7l+wqh4sKOxPvtWQphhZ/JcJ/ax0FHiajKBI7E3DCv+ZOxWKVX1412C+nz0jRHB02rncb4DTaAvxor1JKbi0cc0WqKL02p9wUkk6MW1/mYuotQlTP+9+u7iNPnIJJulBBGQ3CcR0heQ82i0xo9gL+cdl4k5AIp6dmLhj7okU3tkGAbmzqn8uIlohxQr/12puU/05s6iD0bveLngij2zLPzCiGiY1p13Ig5Clx2w7UCz3fyr+19rM2yNusboeqOD7ixzu4ULdQGdLor+O/wlgXG6mSOPh07pFPYE6mO1q2KX3veURborXEk9zk6rfC3y9BdVft6ir+HVWlNE9ouK1R+InszNpOPhQP3r+HnPSh90/Jv8LYd0O5nU1h6oHgOYo8EuB9y0AbflwycuBhubVj9uOTGr1KJTUYHjK6DWxEhMJJC7vw5cTka9SEIDw0pwOnnFQVwp90harwrgDTWuilmaE4uiVYJAZQS2HMHghc9E/jupRVUjk88J1eO3Q5g3B7mXRCkQ+7l5dYfpAHIpGOfEWEjxVLaQUC7KfKu+h68rQfA7Rg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?An6QCV09SQKZGWSyTq287fNuVXaJCNgfOGBw2Q/bGqr8T1cVpRq+fWQWAjCp?=
 =?us-ascii?Q?DQvMQgP+l26NRJDzTk8WY3x2inEOynKjVikelmnAoLB6krZdYRHMtEJ1mg0d?=
 =?us-ascii?Q?HUhfdlIxMrMoZct6rJY/AYCmLexevB2ZQ4drph7OeLC7WVqNDJtEKjzFNbgZ?=
 =?us-ascii?Q?gRfnatIw3VP67FZpwfp1P5akf21myZuvL4c+5GGf1HZmqKW8waVSMeTD1hh9?=
 =?us-ascii?Q?KDx5HPGHvicIjkAoTak9Qf/ttttydzWCSlN7+oSK1frAFGFEutYm/1bIsr5D?=
 =?us-ascii?Q?S1rG2Fa/xFM5edvrUIrq8+vZxCKFZpoVXPleuvQo5MEnABH5OAoI80Mh+OTh?=
 =?us-ascii?Q?bPS7ac/cWLc6JIAX0aQPTZSye+xRwF2fy4/9zM+g7zzC1Qk37Fgi7FoSLIvd?=
 =?us-ascii?Q?Itc/49PqlVlhnF6JlahAiXR794JZ0f+S8ZG4W+B6FFZwnMuX5UIu3q/5HfLe?=
 =?us-ascii?Q?ilYvv/G2sxLn+q6PCUaczu+5BiLsJvzpKPBjjeUBRDpxCJvnK8YW/XRDAMIR?=
 =?us-ascii?Q?GXMNwQtk8PG2mKc+t1GWmnxSe/k7DQtFle05prH1LoipMFSlyFVqANYyrh/B?=
 =?us-ascii?Q?SsAoxgmQRW0JwQ6VEPilpN2NU2E15hcJlS0CzU8E/njxlKSifs4dLjPRRdJ4?=
 =?us-ascii?Q?3SycNmK76XUZD4bRMS8+1o3pcpvM/DRJUuFNa5fo87xOkYgjNoIXN65El3Ye?=
 =?us-ascii?Q?WRGsyjvburOi1qpQZHZVpHXmTCnduaruZqkLbCtkLaso0zw6vRGY35/QiZki?=
 =?us-ascii?Q?EeYKrfeOLHOfC7z/8lGEhE/EADf3il4A/fO14EwubuJ/xA/1bJYgZ72joEMG?=
 =?us-ascii?Q?QlzYKsERLoyYIoweU/PI6zBBvhodoxqSxukkuYhZu/tNXQmnO1VgsGWV9pI6?=
 =?us-ascii?Q?aKNbWZwZKzvBMBkrppR3vBt+cxmB8gYOaD29MlHyEIY0/B3ULQH/cZpxXpTR?=
 =?us-ascii?Q?O6dvfRJbON8KaRZ5vb7bgg4/gB2lJFGJwxxBWM+k4uXk4QumJoJFDHPkO218?=
 =?us-ascii?Q?WJ/G27WNHzXAR/vl6AhCnkodgFxbOL0wNx48rLHmK7W7B80nZ1loghY/LYMG?=
 =?us-ascii?Q?pTyOHX06xqHQnw2BrwqBmUrmh2S4luLrSOZn2a2S+bSegHsr6MwI341xjPgV?=
 =?us-ascii?Q?jYh99d7r0Vtzs8k1GZnLPiZzIlOo2ThmYUDiE4IGX9zbap1zoOovEvpefG20?=
 =?us-ascii?Q?v6u7Ba3pOoHZY96ATiVGCahWqkSlj02ayf6mFO1bWYIp72ZxJg+H3wJGDwsr?=
 =?us-ascii?Q?A8pKlpHj+wrd+EhIso4dsm180/7R8Ws5GFkWpdhAbS9UkmvgY03W78sSWDwR?=
 =?us-ascii?Q?fTPpjvLCTeyHBnsRr5u3Nd3YCc2qn+xxPHdY6lOg/lFnoOSjR/nGUkZ8Wt3T?=
 =?us-ascii?Q?GGcXEuRbdUfzfj0fzUlwY5H25qpsqzYUfd9GHZxjPcGZF/nCaajcyAX5mkMh?=
 =?us-ascii?Q?2gV33SUORkk5ghowoMXLFk5uvogrwxmoYvwGDjq5bUbH//YUTFA8S8y59W7N?=
 =?us-ascii?Q?uf2RRB8fZTOYZ/lhPEBqDFhg4PjFAHc8qNs7Ycbd2fD2GZRvsNrhj5Niu5aK?=
 =?us-ascii?Q?U7ohn7/qFmREpzp0pchZi75NPdFqghz9v4J334vx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a7f982-dfdf-4e17-9fe8-08dc5e9db949
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 05:17:49.0978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVa/X++mTw6LrHHOd07DqzPUDbAznkth73XXIgQZWUeesdIg/+U7IjAjCZCuCP8JMwZqqFBZleMZ2yQ8R6IDzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5815
X-Proofpoint-GUID: Z6b7AvIeGQrXprujbyjV8tQOWn94CTN_
X-Proofpoint-ORIG-GUID: Z6b7AvIeGQrXprujbyjV8tQOWn94CTN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_04,2024-04-16_01,2023-05-22_02


> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, April 16, 2024 3:53 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Subbaraya
> Sundeep Bhatta <sbhatta@marvell.com>
> Subject: Re: [net-next PATCH] octeontx2-pf: Add ucast filter
> count configurability via devlink.
>=20
> On Sun, Apr 14, 2024 at 04:28:30PM +0530, Sai Krishna wrote:
> > Added a devlink param to set/modify unicast filter count. Currently
> > it's hardcoded with a macro.
>=20
> Hi Sai,
>=20
> I think it would be nice to provide a sample devlink command in the patch
> description, as you did for:
>=20
> 2da489432747 ("octeontx2-pf: devlink params support to set mcam entry
> count")
>=20
> > Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Ack, yeah.. missed to add example command. Will do in patch v2.

>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> > b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
>=20
> ...
>=20
> > +static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
> > +				     struct devlink_param_gset_ctx *ctx) {
> > +	struct otx2_devlink *otx2_dl =3D devlink_priv(devlink);
> > +	struct otx2_nic *pfvf =3D otx2_dl->pfvf;
> > +
> > +	if (!pfvf->flow_cfg) {
> > +		ctx->val.vu8 =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	ctx->val.vu8 =3D pfvf->flow_cfg->ucast_flt_cnt;
>=20
> nit: perhaps this could be more succinctly expressed as follows
>      (completely untested!):
>=20
> 	ctx->val.vu8 =3D pfvf->flow_cfg ? pfvf->flow_cfg->ucast_flt_cnt : 0;

Ack, Will submit changes with patch V2.

>=20
> > +
> > +	return 0;
> > +}
>=20
> ...

