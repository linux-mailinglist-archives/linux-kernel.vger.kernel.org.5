Return-Path: <linux-kernel+bounces-117027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B988B3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949BEB3C500
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68815B11D;
	Mon, 25 Mar 2024 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WkfoJOQV"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C515ADA4;
	Mon, 25 Mar 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370539; cv=fail; b=ZPG4WWuGJdcY4Qsq05N3CziSoWn32GYGlgh5ZQo8tnhf9LyNm2vDZhI58eS47p07/WRKfJi+muQJpjvrfI6bZuM461aaEn0txDe5ObOddoTP8vCiSn9/2W1wJB8TCdWmB5/lWqxUwEqVmuJP1NhdOXEWcsNjViVD8jPtLhtqwRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370539; c=relaxed/simple;
	bh=ukwneb6zF5Ne54UyD8aDvAGP0U2myLn9dnzSXb5SFyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YK4f2Qtqev4J7zjptraNNT4DrePns8e22Pmt6DdcAspVp/22hTs9MxMuqE+rqnYjJ8aOBbTHu30HxE3OlGlXmID09W8zBO69JDCYPFnenhBi54nbwVXBHClMs5y71SRRwyvLKmXKlFoTogXtN7EPV+Ty8T+4rYPD2Owu6LGXeyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WkfoJOQV; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PBk7Zo002352;
	Mon, 25 Mar 2024 05:42:08 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x38pbr7hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2kPhzCLC0GweDJvM62+qXkBMzjS3DoF3WiVj0aSqacJcb8ycOPksIhIzoBtneqZyOoxG3FZuzQOCzxLgntme0gGWNwM61hwHyrvw1CKuMCjLrkg8stOr1ClqsBvFbZ3rBBHfmQk2tcls6sb7vi6S3GZ40Fdol7RoFAMuARVRj9HT9r+TeHL0dsvAU2L6BWyYak022Z5YV3Q5RRFFdePDam48gtMH21mXzaGDa7jjeqsY1yoaqTrtg3R5SN7awXRbXv/GhLnuy240bdz5mjwiHhlQE2WYxTasFQv90gbXUnn9iF8vXx0zu3B4xQGb2gD5cpxCg4d7AhfFMVPUDE6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukwneb6zF5Ne54UyD8aDvAGP0U2myLn9dnzSXb5SFyI=;
 b=mLlCmp4HCzc8nnlfUa8bnaxRe1vYUGXGoUf4boErna+k8OQX1bBO2WDj/cD5m7+6N7gleR5n5AFrgn/aLDTTvPEFYAQtXPfscAJChCDVHqFFRnnq5RfPJXxmdjVO1yfnA0V51+aVm4S7zcEJ6msq6rpDvTAs/Jmo2ljVvViWRmiGEujKfJmVLk11t8qlM/CBPF677RvJpDr7LGtJSWaf13zdSF6WUYjdBlymjQEJcKKef/RvL0PHOfsBmxRSKRiSKTOYr3gqtJFNqkREA8jnxoxY8ve/eUbTE67AXpH9FQO5pda/S8EL5CyGCztfWmQbO8/syNqnzfLJ3Iju3cMq1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukwneb6zF5Ne54UyD8aDvAGP0U2myLn9dnzSXb5SFyI=;
 b=WkfoJOQVGs6+PC1oAX6Ea9dKjGKoxe3377ClzcMgY6bqfkiD0ctjwRHbsYT/rmCM3ZEJ5IqTQxIRDjYeHL9csJiCB88Ium+Mc0noUPIBr6A4NJsHLTfTLW9AW+miH4d4vUWAqmy0ignq1ImcpzbUWUR4F/bpvYa8wufPfZhqqeQ=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by SN4PR18MB4855.namprd18.prod.outlook.com (2603:10b6:806:21f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 12:42:05 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5087:a566:c473:1fef%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:42:05 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Su Hui <suhui@nfschina.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: Sai Krishna Gajula <saikrishnag@marvell.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 1/2] octeontx2-pf: check negative error code in
 otx2_open()
Thread-Topic: [EXTERNAL] [PATCH 1/2] octeontx2-pf: check negative error code
 in otx2_open()
Thread-Index: AQHafocejEkZK72mrkOj39rY0uPDDrFIZiIA
Date: Mon, 25 Mar 2024 12:42:05 +0000
Message-ID: 
 <CO1PR18MB4666EC4FB52BAF4A1A8EA021A1362@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240325073549.823832-1-suhui@nfschina.com>
In-Reply-To: <20240325073549.823832-1-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|SN4PR18MB4855:EE_
x-ms-office365-filtering-correlation-id: b43c63f0-2803-4284-7af1-08dc4cc8fa00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Gxif2egC8ErRonMZusUGUSVrt5htOj6kLcSvYw1QPTieE3bzDG8D8Ks4DZ44HukBWRxe6oK4T3UeeTaQSDCJQ7dhhUrU6YShvTKEebXpj6+5CkFAPh56/lpxXTFZn/5LP0XgA1DK06W2U6WpmchxJ63VjXgqQgv18EhTPNCxOXx3fxE16Tp953r54yy/sO8TC5FMYCwcF1Y3ZTzl3A5HxHpzjATYOURq5zMMt6Zbq+22MmHGyk0mBftmOTdFX3t4MMJLMISCDMpn22Edb5icVjeBiyQ7xyMn4AQMmmDfrrWXA/jNvqNBSYzyS9a56rxIWjohQhyNgqdhPVYm414Ch5vWvqkvQ5Vr2ouhM3bc2hag6BZU3bchkOyVw1VuK37iMdYa345PEY/rN4hz1vi1unSYDEKVdc9l/irSnojArjV+pitlBB4xeQiSqDutLsgachyvZPsi9TIdWN9PXx6XcbXwO9/nUVaRdVDsvJyjq5KLfoqWzcLnhYmiF/3NvNgIF5wZMR02mJyemYkYbukQx3aQ6ccGWrnvvP1R0UzOB5pJ7tqZSGYWIR1EdvoH2o9Xg3j7fVTp7T+ofh60THx0Q4QKbMUkZtbZQcaForgaLHcLQasj0lU5UMLJWsUL8WMeRgCtgz4KVpydRAxqbUm3JOlcr58t/jNSwkrniEk+kTMtfEHyWfMEV3uvUZSuoOPbsPzrtl8f38e7dxFWaS7TrQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wd7dmSaiBT+GAZtuHBGG/od/rxLaVx/MhiMHwXM7K3WBjRhuCILHFei4ZnSE?=
 =?us-ascii?Q?q5e2IskCHH6M4Kn84xcOR4iIprs+LZ6EEcFXKQh7VeclxNPATb1Ec16g3GeJ?=
 =?us-ascii?Q?+gjydJwGWaocNXqx296+P/m6Dzt9rI8q73mRf/nH3accIXkoCWGrCQYZkRBv?=
 =?us-ascii?Q?B8X7n+vZQBr/Y6cJ6H7a7U4NGSiREyN0Ng9yqDRIpYYYlHyLfBnyjKXbARPB?=
 =?us-ascii?Q?Ht1vKES/BpkQ6u+5F8jCBCiF8MmZS5uRUHBnbWTPsVa2/ax/s68695I3gWfN?=
 =?us-ascii?Q?6g1gwM4IUFkqJagiHF2ljbL4bz3HgI6upWYwrqaBvRZE5QAwV3Ku6OJ08zV1?=
 =?us-ascii?Q?eTFJwUjieujlz7l1mOpARSDyJm6koO/oZf+CLXcdOpPbpFfV61a/2l7cxo9E?=
 =?us-ascii?Q?mMcgnLH/u0yC6AI9LdIwg+haqEUJGKWTpGIwUtY2gRM3fA1HJiejVa916+NN?=
 =?us-ascii?Q?unuzREPmqwezZtRVU5p/ay6D8bEMZHwQ6eRXPNs9BQtHaAaMXDIyZtucHteG?=
 =?us-ascii?Q?cJqDGBEtTXi7iccq6IoqIkwDp2KCmj7Pg76pQGC+/9vpaSeVaMrb8pLPL1Jw?=
 =?us-ascii?Q?7HdFyDOslvDrBXZvlW1W13RFKinn1bujHOkI0eTHtAwyto3xzP/sOftkRwHF?=
 =?us-ascii?Q?4G3jbX311FTvWv2d3Yt5B8YXjFi6fqFZM6e5GEuDnJFQaGwq7jSZaqz2i/dB?=
 =?us-ascii?Q?zKJXWXMXFvIi2j51SsKTXXgZJQPSmC422suSGJIIw0pB2TX6nwhw1QgkfBn3?=
 =?us-ascii?Q?dqFOQ/RSrJXY7wGUuza8gTTsS3tHSM3sGZX/QE5izEyUXvPEmSKP6WBXY9H+?=
 =?us-ascii?Q?MG91TR8hgYqQj+GQqQNL+ix5m51fWaNVX+rdEwCowwXplrE7v1xwWaG2HCit?=
 =?us-ascii?Q?trf6kvx+tRqkareTGczYLsEEAvVk3xxGBMYCMNO+KSHXHXCHxkeO/zjkSMOA?=
 =?us-ascii?Q?kOkA1+RBwsuAlWJqfC/JV9XS/EWnZ70Yw/bl73LptT9tzsqLIYk78VdgzRq4?=
 =?us-ascii?Q?2s+PAPPc+I5OKhnNshUONOeq7EIcK2sUqebR/4itCJhb3Z6PD/xomtbLnuqT?=
 =?us-ascii?Q?v65HfOg9/C63150lD8FeWjsCGBiLs/hde8da2Rxn8nG6uG5StvxyEpa/vQve?=
 =?us-ascii?Q?zWf5IWUA86OjELCcRrVgH2sJjhLHEs7sdDzXVTD/tHRf9O1e1IwLp9eS5WZe?=
 =?us-ascii?Q?cNOWYfc1Jyhx5zil/9TM2n1o2rb/EZrkMMBo5QWupgEmooprefjdQK5nyeZz?=
 =?us-ascii?Q?PGXBF2JCgeTUuo3sWsHwvIPDq9GFL3jEVa8tuU52ZIjp751p6vBfiypodmwn?=
 =?us-ascii?Q?D+zRdiudUhZLXGHgRnt80vCwYdj5NKUzeQYx8Go3j04Y2TldgavYPk9Smn3/?=
 =?us-ascii?Q?WZZuTsPiaNtY7JPsJAain8Sycgeg4oLwGx2rhG7ZCMWzXWK9prF2yaU+Q95R?=
 =?us-ascii?Q?DKOcHkZOp6NehyPuTZnftaxj+ArzjTSb5q/JlYs1fM5CW9gI28pOzPI/6koe?=
 =?us-ascii?Q?9NM1P2Eq1cmg9agyi4MLbZLaa3OPfAn52C5cYWhUkS8baKTykhxHPAMGLQ?=
 =?us-ascii?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43c63f0-2803-4284-7af1-08dc4cc8fa00
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 12:42:05.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3Wl3Blj/XaoHHoZyOU9jU5QSjdrcr90Ij+K+PlpSUzVx/AxO6q7zzk/K0Q22Wpy9JOePI+VOF3rzYmFIuExCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4855
X-Proofpoint-GUID: pGJt-F_25vXM5sZ03ASdEZGRoKFTtgll
X-Proofpoint-ORIG-GUID: pGJt-F_25vXM5sZ03ASdEZGRoKFTtgll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02



>-----Original Message-----
>From: Su Hui <suhui@nfschina.com>
>Sent: Monday, March 25, 2024 1:06 PM
>To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com
>Cc: Su Hui <suhui@nfschina.com>; Sai Krishna Gajula
><saikrishnag@marvell.com>; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
>Subject: [PATCH 1/2] octeontx2-pf: check negative error code in
>otx2_open()
>
>otx2_rxtx_enable() return negative error code such as -EIO,
>check -EIO rather than EIO to fix this problem.
>
>Fixes: c926252205c4 ("octeontx2-pf: Disable packet I/O for graceful exit")
>Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

