Return-Path: <linux-kernel+bounces-126522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46AC89390A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D8C2818A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6BDDCD;
	Mon,  1 Apr 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rkQF+VlW"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D832F3A;
	Mon,  1 Apr 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960740; cv=fail; b=R9mVXzwj5pkC1OVjmiJfTt5f6nAC14iomrDIqa3t4BnF93XFqRd0+EKyp2+ylMlps2tjIffwjNOyYhDDEJbCq/Vud1tqxGDDlvFMB6SPt2fWkwYS1BIEzhy0lPGKwtwUQhxvcaykHRGGG7Q998dv4jIKRmM8rW9dmCI3+RsHS04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960740; c=relaxed/simple;
	bh=PUIbA9BOPm7Q+N+WIq/+7JOhTXf7Yqvge5eHH6BUdLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eKwV++9hlzSfHJSQN4vRJWB0kMdXk2UpsKj1JHC6DY6YNtWVBUQy77Iltj/a28j6XJ9gUooQUJrK40TqNdvYIJt+B7jZqdz4Ri1Up3L9pLRSFu+2QaNhViVw5NJ07qWRBb4hSwARv6p3c6XR2pZSUPhsTVinE7cUgjDGh4fJmwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rkQF+VlW; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4318D9Kh003499;
	Mon, 1 Apr 2024 01:38:50 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x7kkcguwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 01:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdTOuAIXTPBI1AUP8VmyU6NBd3k7nlpAbFaJzF60trOCNC0T7gX0P0PZD+gvrSIOLhUoVjlA78g4pWd3uOdCdKaZgJXEMKreHDC/qdn4cJMWLNShEc6FLsKIBzKEM4J+fnunPY/s7u3NVGpIPhCnXAKXJMmksFISSvQy5pp39cGJyEQ9dnxA00b2Kch406otuy0m5EFoOiPIutT135wS3KqclhK6Dfe16Z0Oa59HC5KmuAORYE+7A5Fux42Yw5WqpgD3bbcwr/nnky1rAWg6kq3Dcxsor3LP/EH/dDBMRKpk5d4MgZ4xrAIrLOavr0OqC4z9UHayWvd+tuP274rsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWK4O9pzEHr+EDNTx5EvJlr2ck4BVNQVhpABG2ecaMQ=;
 b=nZJ59L/Wl/K9OzRkK5V+sypjaLZ3fU1AxJP07IKVGF9DJC/rkZ2OfYgW07OJeu2fjJ7Qo+CeDOrHeLC3+QX5/+RoYbEXFio2FdZYytAwAJCIdnuO3ozdwzYEjbqpzucpwqDpEuue8VxrqNFZLAnWwJx4T9nXyDDkm3f2kFtR1OgPPy00zdMFVjjdufq1QdG1+HqWzGfdDkiSfCLUj92B3hNcG9oZKP/ZdvGHIbYqiO5BbJ7GKbK/ERZ6HnmlwXK8z5Z2kuDPtYAe0lKmDAgMe5Js7b9GXEcuE7+gmjczz6KpbUBLxxak3PBkc0wOxYhrRHbWdPL26LwbcBy/iggWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWK4O9pzEHr+EDNTx5EvJlr2ck4BVNQVhpABG2ecaMQ=;
 b=rkQF+VlWKHzXLH8gRvEe8yLWvC8RAvWyEhu+0jGEfCAMjWC+hJ98EwaOBZHMLhsiwCL6NjaeouKxuQmLogTQpdjIkLofR1IP5xP/kKpMsqU/QwFIBdfuhk20oO8wUCb9J32lrRNygaYraN4mb0OSil57oMoCUGqYmkMYTnMDesg=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by CO1PR18MB4809.namprd18.prod.outlook.com (2603:10b6:303:ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 08:38:46 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::d068:f07:a59b:eb2f]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::d068:f07:a59b:eb2f%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 08:38:46 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: ] Re: [net-next Patch] octeontx2-af: map management port always to
 first PF
Thread-Topic: ] Re: [net-next Patch] octeontx2-af: map management port always
 to first PF
Thread-Index: AQHahBADL0TiP64nPEWg/DZao7Q9dg==
Date: Mon, 1 Apr 2024 08:38:46 +0000
Message-ID: 
 <PH0PR18MB4474061FA888A03A74CE2D5DDE3F2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240327160348.3023-1-hkelam@marvell.com>
 <20240328145819.GN403975@kernel.org>
In-Reply-To: <20240328145819.GN403975@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|CO1PR18MB4809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5DIpk5/oB27e+nh2QEjByO418s7V/hcq3XeCKzi9aYt1Ik5S5H/0hY9apZ9Pr6apO/gWKGchNLE03ya5cXuk+RtjuBcH/evSfIqyQn0BtUCD2WA6+KwKamSP+h1CObZQd6rdN4oq4UlkhHwyWQ3uXUfKy2vtos2xGCUIgLVmYQosrdhPOFs7fDXMJa8de1h9ylaQWzSsfcxP4bvN+7dKkKGN41sJHp0pg4QZpijH82dOXoyNj+1QSZXyaryfqAlcezdUHsa5e/+QBcL7UvvqwdS2jFc9vKaSiEVRvckMKjPaKH+XM2NqNq8IL4sMk8A1Ur64HusnecMZgQwU7tT6LXxqVt5UI1fwUxh9zKmCWpPKS1ZzrkVLqlq/725EuWQ0NealzW4WGB0g8T9oi/bgpfkt2lN8SQmhvv62rkOmjvnFALbV5fr3ow3Env8luDF+Q9JmZS7iSRMcukhXvs69mEjf6DtAFhfBytl6Nb5OLCg4O508Lr+0rg/otYBWPHYLPAghv0BodwwYBVp/oHPG4ySF/RRx9XU33B0cKadzPGUx7daPUybq5bL/zynVfqB7dP+MUJv2czOIikTSLIBMIL5IJ7dPZJJhsZdGKHcfcJHr4MmtMppOBwdV4CFMPGcZI9Q2UR+YZ2SBykzR2uldvOe5sSGH3tUEDzjQlnpTY4g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pnuW7mZu2mn0zQKwR4gfQdPKWYlNvDS9RFIcrgmEYqnI2Yt9UGPaXgKXurkI?=
 =?us-ascii?Q?HRHnV2hHyOjXmef9iru9u/h82bEqhKZknuvC5P/HxxzhQS3N1jkFJhAuds1H?=
 =?us-ascii?Q?ByAl41hZd/eIqYo4N+hs4ZJZumvNV4XGK7pYHFCfeRUnprXEHuN+GmgjEo2N?=
 =?us-ascii?Q?8xJ1T+/kWyKJR2nPJ9FxhSKsU2k56OH8hksAb8DveAiELB921iyIabySEoBl?=
 =?us-ascii?Q?p1qHzhEH7WQZRTikcSQIBUA+J8NtpTArXgvSgWVLlB2v4JF0TODyOWCMIrbY?=
 =?us-ascii?Q?WYbK3CKq/D0vhQim4DKJc7+GCLZI0lrs5bcrKeCxkNQcSJkOginATZ+QpcNm?=
 =?us-ascii?Q?GdNDMUqUEYxkB6hlneHcOw2BWdx65MtY+3vQKIvskde0qGke556E1+9RGQIB?=
 =?us-ascii?Q?zY36vBfDiC9gvD+KBAUYKTOTfBaZXZo2XawWh2QEweP6Qnedmed5phghXlzI?=
 =?us-ascii?Q?TJQx8FKVkWkXIstc/Z5Qhg6BhWKdog8pXtcYn4poG1OKgnqo6HDhBJj6ggsF?=
 =?us-ascii?Q?GDUVCEJCD1qUGJctNqpSnCMzVlCwHUkRk+EGRsyI4hCz+vJ2Q0of9iKpH27k?=
 =?us-ascii?Q?Bko6/nKPc+4ZMSzrtEyw0pqnme7LMLy0Tqv7j/zTMvciFoEyKLi3DB713h1e?=
 =?us-ascii?Q?m2NV0HHaZWPrOPx299Hde2Np/NNK3vvF5WrF9twNIizvUMtV4g5t2EzcwSoA?=
 =?us-ascii?Q?lWYV32qpP6SsOo6MRl9p7GyOshXdZ6IYcYR3i18tOkireFtRh8phA3GTqOCj?=
 =?us-ascii?Q?OnnXiJk18Lysr6AC3+sAg8Y1OmEalqvtuals2hKPjSIKKFdRtGCE0ZT0g2EY?=
 =?us-ascii?Q?8wQqqLgdZjZqX1ejisQeuv7m/Koh/enbXwR718sq+dCz9So3hZxI9cU+8Jqn?=
 =?us-ascii?Q?NgJuXMcyLLI0pK2SUfUxLTLi+uV+D7YE1uvxuKbxQn+VHzSwoijHotTHppHv?=
 =?us-ascii?Q?MYZAaS7b1F4+gnHndpQ0ZQaql7ButQV+7UihJ066ngtjPeCtl3gNKeNHdtOT?=
 =?us-ascii?Q?7Df1A+fI6S8wneATzcmKU6MEq+OPxuDawn/vdJeHzrVWS/W4O9jPQyxzbEcq?=
 =?us-ascii?Q?5cNefSuf/TI1dP+cL40mPy02CmUWeClArx5gOeM8PwA+3tKQRXoWsk3XDU/k?=
 =?us-ascii?Q?UftWbs98fZMgsyMgzzDcZ2P+zaSSE1Nu6hf3DrMiK/35D9jQE2CYfI4VdLQP?=
 =?us-ascii?Q?pUyZB1HNOfK0Rb4ZaK39BWjR8tqbRr2JYEkqaNv4wCSmMEz573SctFtGz0Bz?=
 =?us-ascii?Q?6J4KVSMG9cunvUeC9MPMOKorfkpKao7S26tbfnW6P7VhKCtdyaOEbli/td60?=
 =?us-ascii?Q?UAqonhfFz1t9d0b3sYhjKhfHCKisMe2fQP3x4YOYh/c8oYq6QLR6PpOa1iN8?=
 =?us-ascii?Q?UB3eQQXjzLF5ofpFXtfU7Rj5AyCfL06/IQldsOa8Gs5N28SV4D8fK3SgGR0C?=
 =?us-ascii?Q?IdX+gOTuEiOjxaeZAMcI3MC/BvVpx0Jb9/Q0smq5O5Ng+5vKFCfRN3zYOx0y?=
 =?us-ascii?Q?6XCu34SWDmnBKoZxGcHvEymoRoWfPEa2MeifMVya4KdRerC3EgXUT97GhhCt?=
 =?us-ascii?Q?ZSJbt/ZHXNCIc7Ee2d4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883dfa61-47d1-4179-49f1-08dc52272584
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 08:38:46.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwWcCRUBpvDLJ4TZoTtBaxQtowz36hku/hKse3id5PQWon+p/y0iHqs93Jk5I3rFq7ibVSoLi7baAh+8Hb6a3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4809
X-Proofpoint-GUID: WNa7aTWDX4HJmdq7VYaUwKtfnPeFFSrK
X-Proofpoint-ORIG-GUID: WNa7aTWDX4HJmdq7VYaUwKtfnPeFFSrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_05,2024-03-28_01,2023-05-22_02


Hi Simon,

Thanks for the review, see inline=20

> On Wed, Mar 27, 2024 at 09:33:48PM +0530, Hariprasad Kelam wrote:
> > The user can enable or disable any MAC block or a few ports of the
> > block. The management port's interface name varies depending on the
> > setup of the user if its not mapped to the first pf.
> >
> > The management port mapping is now configured to always connect to the
> > first PF. This patch implements this change.
> >
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
>=20
> Hi Hariprasad and Sunil,
>=20
> some feedback from my side.
>=20
> > ---
> >  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
> >  .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 60 +++++++++++++++----
> >  2 files changed, 53 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > index eb2a20b5a0d0..105d2e8f25df 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > @@ -638,7 +638,10 @@ struct cgx_lmac_fwdata_s {
> >  	/* Only applicable if SFP/QSFP slot is present */
> >  	struct sfp_eeprom_s sfp_eeprom;
> >  	struct phy_s phy;
> > -#define LMAC_FWDATA_RESERVED_MEM 1021
> > +	u32 lmac_type;
> > +	u32 portm_idx;
> > +	u64 mgmt_port:1;
> > +#define LMAC_FWDATA_RESERVED_MEM 1019
> >  	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
> >  };
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > index 72e060cf6b61..446344801576 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> > @@ -118,15 +118,40 @@ static void rvu_map_cgx_nix_block(struct rvu
> *rvu, int pf,
> >  		pfvf->nix_blkaddr =3D BLKADDR_NIX1;
> >  }
> >
> > -static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
> > +static bool rvu_cgx_is_mgmt_port(struct rvu *rvu, int cgx_id, int
> > +lmac_id) {
> > +	struct cgx_lmac_fwdata_s *fwdata;
> > +
> > +	fwdata =3D  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
> > +	if (fwdata->mgmt_port)
> > +		return true;
> > +
> > +	return false;
>=20
> nit: I think this could be more succinctly expressed as:
>=20
> 	return !!fwdata->mgmt_port;
> ACK, will fix in V2.=20

> > +}
> > +
> > +static void __rvu_map_cgx_lmac_pf(struct rvu *rvu, int pf, int cgx,
> > +int lmac)
> >  {
> >  	struct npc_pkind *pkind =3D &rvu->hw->pkind;
> > +	int numvfs, hwvfs;
> > +	int free_pkind;
> > +
> > +	rvu->pf2cgxlmac_map[pf] =3D cgxlmac_id_to_bmap(cgx, lmac);
> > +	rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] =3D 1 << pf;
>=20
> This isn't strictly related to this patch, but here it seems implied that=
 pf is not
> negative and <=3D 63, as
> rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] is only 64 bits wide.
>=20
> So firstly I wonder if pf should be unsigned
>=20
> > +	free_pkind =3D rvu_alloc_rsrc(&pkind->rsrc);
> > +	pkind->pfchan_map[free_pkind] =3D ((pf) & 0x3F) << 16;
>=20
> Here pf is masked off so it is not more than 63.
> But that seems to conflict with the assumption above that it is <=3D 63.
>=20
> If there is a concern about it being larger, it should be capped in the f=
or loop
> that calls __rvu_map_cgx_lmac_pf() ?
>=20
     Max PF value is from 0 to 63  will address  proposed change in V2.
> > +	rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
> > +	rvu->cgx_mapped_pfs++;
> > +	rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
> > +	rvu->cgx_mapped_vfs +=3D numvfs;
> > +}
> > +
> > +static int rvu_map_cgx_lmac_pf(struct rvu *rvu) {
> >  	int cgx_cnt_max =3D rvu->cgx_cnt_max;
> >  	int pf =3D PF_CGXMAP_BASE;
> >  	unsigned long lmac_bmap;
> > -	int size, free_pkind;
> >  	int cgx, lmac, iter;
> > -	int numvfs, hwvfs;
> > +	int size;
> >
> >  	if (!cgx_cnt_max)
> >  		return 0;
> > @@ -155,6 +180,24 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
> >  		return -ENOMEM;
> >
> >  	rvu->cgx_mapped_pfs =3D 0;
> > +
> > +	/* Map mgmt port always to first PF */
> > +	for (cgx =3D 0; cgx < cgx_cnt_max; cgx++) {
> > +		if (!rvu_cgx_pdata(cgx, rvu))
> > +			continue;
> > +		lmac_bmap =3D cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
> > +		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx)
> {
> > +			lmac =3D cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu), iter);
> > +			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac)) {
> > +				__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
> > +				pf++;
> > +				goto non_mgmtport_mapping;
> > +			}
> > +		}
> > +	}
> > +
> > +non_mgmtport_mapping:
> > +
> >  	for (cgx =3D 0; cgx < cgx_cnt_max; cgx++) {
> >  		if (!rvu_cgx_pdata(cgx, rvu))
> >  			continue;
> > @@ -162,14 +205,9 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
> >  		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx)
> {
> >  			lmac =3D cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
> >  					      iter);
> > -			rvu->pf2cgxlmac_map[pf] =3D cgxlmac_id_to_bmap(cgx,
> lmac);
> > -			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] =3D 1
> << pf;
> > -			free_pkind =3D rvu_alloc_rsrc(&pkind->rsrc);
> > -			pkind->pfchan_map[free_pkind] =3D ((pf) & 0x3F) <<
> 16;
> > -			rvu_map_cgx_nix_block(rvu, pf, cgx, lmac);
> > -			rvu->cgx_mapped_pfs++;
> > -			rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvfs);
> > -			rvu->cgx_mapped_vfs +=3D numvfs;
> > +			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac))
> > +				continue;
> > +			__rvu_map_cgx_lmac_pf(rvu, pf, cgx, lmac);
> >  			pf++;
> >  		}
> >  	}
>=20
> There seems to be a fair amount of code duplication above.
> If we can assume that there is always a management port, then perhaps the
> following is simpler (compile tested only!).
>=20
> And if not, I'd suggest moving the outermost for loop and everything with=
in it
> into a helper with a parameter such that it can handle the (first?) manag=
ement
> port on one invocation, and non management ports on the next invocation.
>=20

Management ports might not be available on all devices,  we will go with op=
tion2.

    Thanks,
    Hariprasad k

>  static int rvu_map_cgx_lmac_pf(struct rvu *rvu)  {
>  	struct npc_pkind *pkind =3D &rvu->hw->pkind;
>  	int cgx_cnt_max =3D rvu->cgx_cnt_max;
> -	int pf =3D PF_CGXMAP_BASE;
> +	int next_pf =3D PF_CGXMAP_BASE + 1;
>  	unsigned long lmac_bmap;
>  	int size, free_pkind;
>  	int cgx, lmac, iter;
> @@ -158,10 +167,20 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
>  	for (cgx =3D 0; cgx < cgx_cnt_max; cgx++) {
>  		if (!rvu_cgx_pdata(cgx, rvu))
>  			continue;
> +
>  		lmac_bmap =3D cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
>  		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx)
> {
> +			int pf;
> +
>  			lmac =3D cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
>  					      iter);
> +
> +			/* Always use first PF for management port */
> +			if (rvu_cgx_is_mgmt_port(rvu, cgx, lmac))
> +				pf =3D PF_CGXMAP_BASE;
> +			else
> +				pf =3D next_pf++;
> +
>  			rvu->pf2cgxlmac_map[pf] =3D cgxlmac_id_to_bmap(cgx,
> lmac);
>  			rvu->cgxlmac2pf_map[CGX_OFFSET(cgx) + lmac] =3D 1
> << pf;
>  			free_pkind =3D rvu_alloc_rsrc(&pkind->rsrc);

