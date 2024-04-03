Return-Path: <linux-kernel+bounces-130004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96605897311
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EACB2A60C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF4148FE5;
	Wed,  3 Apr 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P6tM/4IA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89114389D;
	Wed,  3 Apr 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155887; cv=fail; b=NgtVOD778hkNjyTJMYQsyhQw43+UKUGpmpmNmpAiXtxMX9SjDTK44aPczshxX1m88OFm4JLX90qNOaH3QqxMHQVKCHeZ8fEbAwwWHjDdFxNlCRdXG9eHnRUDhijjj/o2z48rYmexBccQBONW+MwejMbychnIwvEgngqQzkCgpnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155887; c=relaxed/simple;
	bh=arjlbPRNLQnFsL78wHfdDhtI4J0CE7VOnYRlp+8SlIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CO+GC588Za9pHtibeAVDXlAQg3EQBYbQdodhik8Vq+Iy2fzmQUlu4pNLkDm0hHAlzZcHNDtsj1Nfq+ExdZMP71lkjML4LrcCavI9UbSS86QKs5gXTGX3BrOGHw2ZAkWCByN9SDxr7i+o4h3iYQLVN8HTxOVH9OM7HEem9ydLBtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P6tM/4IA; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433BcUw7012299;
	Wed, 3 Apr 2024 14:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=MLgThT5vzxfBu9PODEoAJv9CrDN9hNLvvM3ZtakMhzA=; b=P6
	tM/4IA2qeiH9TfLx1wSYIJGGrYIETnPCmLe6eWTSBBAIDO47+49bU7sQ31VDQd0B
	4gisQNzIUiig70EbwSoAkRjjoJF23JnfibmysfEWmoEQgSRfDGd+JI9Lxge7bkiX
	7M+ZpvwGOu42L6K3vdOOyxU4QVpqLe1TVtmRl+3dSa92JSjKeqbSeFepWza1rVpT
	aZcyjAk4z188SK6OaURzBXO+5FAzzLZJ9Gyyd8m2WtxTC3l+CxZEBalGcPzn8Pq6
	TcpdgNHUILjWCbYvQbKOaieGEc7/pv+aZPg4dgaZJrcX8/Zf1p8jAxamFtDn2tX9
	N+cT9QxvfzzyvGMzLTdQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x93pw8xhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 14:51:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duydZb2gu6+6JpyTfjtpJxTgNZoyBexLw2lvV69WqTF5vggnF3cBCOHnUBRAz2RFbQUmKzl6+pwySfNNRTmLh+aT+mM/+AAO8c9eQWqPWLRiS6nR0uC4+HB/IeUpMGHIECKy4C/SLx2YCCdWn6vr4jgXnIpg/zMl67IinTm2bmcY4bWHbaEKCaHstDR5dOYAJlxhK+LAOGxzB9YayE0pKINI2HkYjsBepl0Hj56QacBE3vKC5uSvjSSjpEG855fHl/WdxdHX0Gxj0KiyJI5/wAfLxvrbvMa1kYu6OpAiASsz6c//yAloo7dmciJoaywbStyzh5EqSUen/N/MJcA7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLgThT5vzxfBu9PODEoAJv9CrDN9hNLvvM3ZtakMhzA=;
 b=AG0Cwe6DCxMopx2lDNdLPXNaxQdvTvqoD9eEYnm2cn2EAPvry7VSxKyoTO61yCFXv9qc0J3sPMjroH7gJHcuZ4eugf5Ba1Fi5H75X0TEdhQdRIAUH1HNMhUhTETlZikIsdcPT4Dzr0PDUYWuy7hzMx5XzGZgwPVp5jnG8TutD6EzOGjIgbPEgXzTvsar4FNmWvrXDGIU8Jzlq3nAkKdd0oT1j99r2qZYqc5PPV1zEBnC3LVSqTkYGPcdGycag1coIye2VCEouPZO9/Zj0MSOTcG22Nbv5d1Vfd2kvUCiL1GCbFVsntMFTokIVIcMrKPKRV3inLGe4RVyoqo9ujJJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by PH7PR02MB10025.namprd02.prod.outlook.com
 (2603:10b6:510:2ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 14:51:18 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::1aac:6291:50e5:4242%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 14:51:17 +0000
From: Brian Cain <bcain@quicinc.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Arnd
 Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Topic: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
Thread-Index: AQHahcpVFLymayp/+ESCyghLOHlzDbFWoRog
Date: Wed, 3 Apr 2024 14:51:17 +0000
Message-ID: 
 <CH3PR02MB10247296630FC062F4E3DE2FDB83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
 <20240403132447.719833-2-schnelle@linux.ibm.com>
In-Reply-To: <20240403132447.719833-2-schnelle@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|PH7PR02MB10025:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fesvqX+ygJgIw6H5ten3ICCg7SctL2yv2agOcFHvOjHeoeYjn4LQ4X1VkPcUuCZLd08332zwbx1aYgEWk8EBe3YL4CPeUjH3j9U+9bm0Rf3+wLFksAf9H9kZSEU8C6Zoyx67lM8j3kBExbxt59LV1sawq0xcGeUUWD2SIy0U04A2XS9t0yvEe5IfceQylV63ko44QtftV+wR9EyMwAEOMvlDSpvqFoJ7L2pRvg4Z8m5IQLt9jqVTHjr9URkwMdNNHRyslafdYQCdUhnZJhcXe4bmabMbvQEa9w7prZf9aW6jaaGR1LEmRzQCaGjnpaSYv3MY9S0FA7YutCj7YMCwMvGp9W5e3L9kMRSxoe4enF6T6imo89yZ641LjzP1jDLKvVvf0Kkipd7i+qNzERUNdGGgnLBAfYH6fTSs7liI5guPyl9qDMKq2qPYCBePVnqQ9IX3kFy5M4kWJzoDpuo8/DyG2AlVTj85zZvIuvChvOFPQPfzpfGTKzeKJQO+xHMB7PzFSKaSiWTkoz9d2kkTpAThWuj58UcjjeO43S9LKqAb6HJv1IFNN2c2FqMTbuC/X8e44bwWMqT9elSBssEptoZq3r3cBwdqieBkecPDlafraM1QQQAbMvxWrPH9bKCiL02P0uJiDTS3uXo5alfsvfi/1N+qt+sH+isYrSzPQYE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Xa3F/xd+RsIIp7IRwVFfH2Fi29TnGvsTpf9Xg9Y/clQr2BMByanu+96y5J6j?=
 =?us-ascii?Q?etTye57qZuW0jDJwFodf+0Tz0oWJZS/0KSJwfmIRhSOszSdCSF8VtRWu+L8R?=
 =?us-ascii?Q?buH3RjkHCf7YqqXCeGoRKpQaLE2l3BpI6DMaFR7pwXzFgEcOGMCmjvtuq5f2?=
 =?us-ascii?Q?1PHS65XPWsyfXCiI5C6l1yMX9jYifqbTBtes8jog7KKa4qNeg+4e3r8ORZg9?=
 =?us-ascii?Q?5CMeFoUcPoRaAjbNTslhlJIlvHAbNDkx2PR9xf07g5lbD+ekwbq4cLdmo2VO?=
 =?us-ascii?Q?TYqLknqXRl+Ab7kEIb4dGm9VNVkQ+hjommx+acpQFehh2DKF4MF7UbMVxVDb?=
 =?us-ascii?Q?7oyfFQu1JX1tKjorvrlyyzdVC71ylT4MrpTNwxrrftOl6Cwg+4hoUjMKc+QZ?=
 =?us-ascii?Q?CS7MqCmDhABMMeVHJgawM7TrCAADYVrGau6WkT/xarerm5pHbou0lH0SWtPt?=
 =?us-ascii?Q?1FH3+Mp8G8hvXTCV9J9YlCDFPIvlB/b+bdVRfcmmzBVdM54atpYFB6NIkk1t?=
 =?us-ascii?Q?wf+le90aYLf/itgeM3PdrUNqqV+Z4B3Ub08LdjVTUG4188/oN+EpL8MF17I4?=
 =?us-ascii?Q?E2q3G8oOnC1QOedLuK3o+hI0qbEsitXH6amPFH0ff8uJtOIJMQNahyzRFnwS?=
 =?us-ascii?Q?KTsoAW4IJuvIBUr4PgBSO3vz4YDcfWFH6e3voVwD1UXAjBKPn59P8P+rXf4P?=
 =?us-ascii?Q?wFsOtXHSPjVP4vK+ianTXPC84uZEhGwgI4HaxcG5mMAwnoYjjhdoYwMt1w+V?=
 =?us-ascii?Q?1U703VmbddY9N5Bw0i4s43VPjiEvQsEK29iOTC0hbmtH8+3ypbM0+j4QsIor?=
 =?us-ascii?Q?mE4PjsoGCM0rJQBZ85IikxgYVysK3iYpZe8j7XCLhXunxWUpvA5k3Baxga8q?=
 =?us-ascii?Q?j6+AHwHgOIIB/ynDWN1espqIatUJX09AV6pvXu32n17qsKuydXAQwKYpWq++?=
 =?us-ascii?Q?H4NW6p1Q3mXHjSyLujGWqQJDMmQprK4RR+lgJ6aQZbTVL1f0bEe1Yof0kJPj?=
 =?us-ascii?Q?DCK7e6TZ7cn09gM7pR7Zxlp75ROpSebpAvhdBpQTD7pH4wLzDfog7pUzDV3w?=
 =?us-ascii?Q?zeOsAtz+aVRQA3xzjL2w/zGlDiXKp39o5TrxlH9cu1AVbDQRgdgPFnXWdc45?=
 =?us-ascii?Q?CMqXSCSZDxJDx0PKWpS9QaklDSe1atDPnCauuKgJxfm/uNDS1bDq8HmRirap?=
 =?us-ascii?Q?BtMcXYcfQO5OfqjTkxuFi3/6+0cHStiepj/x+lX2AeRT9sOw1zPYMSx3ZF8B?=
 =?us-ascii?Q?/lJbRPWTBFMcj5L2zlBtFPsLUjsNeO1p6/RWxWeuU2fq4dS+mEwOhfFYiwbB?=
 =?us-ascii?Q?9xz6hX+mILGmRJrADnFvaBqZ0xNPfn1qLtQIMR8Le2YkpEm8/1oC1cYR3/U6?=
 =?us-ascii?Q?4u3yWjIZEwogsRWpAFyPhB11k+IGSmwER9MS4P0sFfCkQyIUW1M0cf7Pp4GZ?=
 =?us-ascii?Q?U8wwJXIf2t7ZVG6aQq/rAQnqyfqXJ6oNV7Cg68xcFYaqHEsHXDjLw8f7ws1n?=
 =?us-ascii?Q?Pbrflm8KgKOvZYNHC/FSSIrW9YbzXWdUszF5//rpzYhYYjDz8HQoyKD9LOa4?=
 =?us-ascii?Q?qFOHxLmPPNwZkZKXvC0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zuX3/kz8pVfH4akIL4BtCYk8I3nQ2dRrDB5kg9LqCENdd49C9NwN9iC6CcX3j+t3ml+9FFB1rxODnFPYV3pejDN7JGfsjRzS48lX2YGu4HrV8JllDiW7hFZRXBBkWUgczD7E0p2fjKetzQNzRDgo5n/35xKpS48LL/lbQAVCOHsR/ikLu4VGuZtRgS4rMT7Oc/gETwht4aveKolwjZVeoB0vTomtEvBIWZ1YQpg1vJ0nh3nPv8Kr5roc/UyPFj9Lrdncc/JtTjLLvwmTxAE94WjAmHMZPIU7WR6Mtr3wjKNqv96y7mm0epEesMHeU5ADmlRpu6543m2QsZR8TQXxbNevc+Snn4BDwHxYaMplv9GEo6W5G2ga0Ed4rMIvfGZBP6M3qNTzJdCNqWkwFo45wS/fS+kR+s0dEj6Gm7vqNOH+PXk7pH33tffSDmRg+9cPiNzqvcVg8w/DIQWeGFc+fYvMwu9lWVHKq/VC6RGi3dFhcABofxPkAM+uFulYVgoNx9ARaXT4LXTlxcx7IbmT+MEqBIkkY66PwLJOjPjkw3gnWrIYr+elbNEeVhROoTB3B5Lt+pdPMtpE7qTQ+gDCcNHZa6TXC+F0Oe6zYNrIUaYSNZ2GX9BqWRx+TFuWfNlq
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bee248-3e7d-439b-b5ba-08dc53ed846e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 14:51:17.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frmBjjWCpw4dFBeGhPWRbfvlmya0IPg4wU3RhGvjw4TrHgBERPmtuYkYKzbxg58YuL/A8nHArYhDKBXpK+wUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-GUID: MwVgmc3CxWNH7ANheeUJPkYt_xqS8B0S
X-Proofpoint-ORIG-GUID: MwVgmc3CxWNH7ANheeUJPkYt_xqS8B0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_15,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=560
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404030102



> -----Original Message-----
> From: Niklas Schnelle <schnelle@linux.ibm.com>
> Sent: Wednesday, April 3, 2024 8:25 AM
> To: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org; Arnd Bergmann <arnd@kernel.org>;
> Heiko Carstens <hca@linux.ibm.com>; linux-kernel@vger.kernel.org; Niklas
> Schnelle <schnelle@linux.ibm.com>
> Subject: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
> HAS_IOPORT support
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and friends at
> compile time. As hexagon does not support I/O port access it also
> the GENERIC_IOMAP mechanism of dynamically choosing between I/O port
> and
> MMIO access doesn't work so don't select it.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  arch/hexagon/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index e233b5efa276..5ea1bf4b7d4f 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -31,7 +31,6 @@ config HEXAGON
>         select HAVE_ARCH_TRACEHOOK
>         select NEED_SG_DMA_LENGTH
>         select NO_IOPORT_MAP
> -       select GENERIC_IOMAP
>         select GENERIC_IOREMAP
>         select GENERIC_SMP_IDLE_THREAD
>         select STACKTRACE_SUPPORT

Reviewed-by: Brian Cain <bcain@quicinc.com>

> --
> 2.40.1


