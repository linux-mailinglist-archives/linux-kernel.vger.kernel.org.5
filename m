Return-Path: <linux-kernel+bounces-142431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BE8A2B77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F31C22D51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16D0524A6;
	Fri, 12 Apr 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRQS+MxU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V5qLDRHI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE212502B7;
	Fri, 12 Apr 2024 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915077; cv=fail; b=ZleMHmXp1NYQMMQzNv/sL4Zu1BdWeU5VP5ayuB4qk8mas444k+9ZlnhC6Buy1qGTpqzlfPPdoND/FqqsXAKwlZZ38TplwERpmB9PPcTBlPxgEEQl4dxD8A6DDfKERLyUpedP7O1QHuEMc89UoAnFUSpX9GH0jJgYv0FIy+irVFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915077; c=relaxed/simple;
	bh=zL4CF/EWcL49YZg9LEnK2CsxTrSbqcAjJicscdW7lPY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Auo0K81vzkXErEpXOpocWmAtldLFYNmf8DyEg2eNqE5wMr4+Us7wVt+mIfmUWNCWDmZWfoWa2aKm8ZK7CWiDzwn13iF63XuQPH7rNsoUTlXCftDz+mEjn5XODAKGiGhI/N1B2RgSMGFi3GKSl1fszZckn8XkZbhIoDKu6/jKfgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nRQS+MxU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V5qLDRHI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C945uT015335;
	Fri, 12 Apr 2024 09:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=76Nciijzji6o9ohlMaSSSpjuWGsVkjutxgYypsmazjo=;
 b=nRQS+MxUzudh1PlG7JPOFKU4VI5YhQqCxC07ucDW8+2pKjtD5Yaq6sniLZrlJq7T48P2
 OjWUQZNdBE9SocXft2yJ57WNwWWl9FVeZdTDTR5qtLNg4TRp83BuCIapDC5kQ4nO3Tin
 QExn9rx0nj0dZainoEHZsnxsHuZrf8eC347/dac3AZj5Guor0vuSacA3sTU3DzvBfLZN
 2lxW+GNZgBKDe9w3LW888m0vD0oDYLxq3qykknsDjWOM/mqKW86fVgpdXYoz9v5jCdgr
 h8B0i6+CalBXn2av0QqujUYzrpXIx+/m9FCk/s7z/Cu19XGyFQe9e/GjtxVTdtYQfje3 Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtfba87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 09:44:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C8DJLI003030;
	Fri, 12 Apr 2024 09:44:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuh1m97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 09:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EohQE7wL9rCar+twimxxA/E9JodjdTQGKI0vKKL5EbQUlCc5rZ/k9/1QX5JCmIkIZ/6GZypCcqFzbgZ73653+x85ITXmzIHitju42LDiBCdgaqcCU9fakbC3+c5kCWabI6EIM8MmpEOMHI5Ps9A9jNK2kHwuzo12oInhqmXDGRIHpn2lQJ/ug6chl3AB1289hKc9R4D6XIw6eULkYsZ5mgsjAymHYKFrd68VcmIadV/RTlg8HWuzaibu+KVEFu9dJsNeI2lEdREc6WjOJY0ZK+RQvpwonemEv44TSLow9sgBHnIGfRAD5LsFicAENTznW5IV5UnuL0lqUv8HHH525w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76Nciijzji6o9ohlMaSSSpjuWGsVkjutxgYypsmazjo=;
 b=l2DAZdILaodt5icio5IHRFYxXzuvX8Fdi8T39Ak/L8zO/SrdxE15ZyZNFU3C5QxoD6RPkaPyrwOkf3k3CaFIKNW3kLTTYvaP4UDelR6PnFSmz7wg2tClVLQwbk2Z+w5HffVTUE35kDzoxt8CSG3rg/4L6Ws94mLpUNaMR/jj2aHlob0PW3a+npeIb82o1oOK/1ONBTdJl+IkM3B2hV4B5ywXF+ajuWZpNZpdYxn1Okjuox8MYXvgmbCPSu0NCtzL2TbZOt3gPOjPgQcf3P6LmxY4Rd3k0GnJLzkOYW4mpwBDKoLGVIeIAlpRypqxf7ifVb1EIFiiRFpep+aKryNj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76Nciijzji6o9ohlMaSSSpjuWGsVkjutxgYypsmazjo=;
 b=V5qLDRHI33Jch+lOi/8Nmx4YtwgN8fDTJ9Luf5H4vE5jrgEUDHA+oJireOV6Orteo0hFDBpuhpt5D1ixog/jQmflMLdnXfhbCROq9Cf8GYwrkHlxR9Q0ss/QaWUE6rvrdTfNQulQd4VY4z83nyKKlGdcMEaZz0KT2Ba14rRD6zg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 09:44:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 09:44:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com
Cc: bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] scsi: sd: Only print updates to permanent stream count
Date: Fri, 12 Apr 2024 09:44:07 +0000
Message-Id: <20240412094407.496251-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0437.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d00b949-d5e8-497d-0016-08dc5ad52504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RECQbmDq3cTRsvN3BU64L/iznQKdJtvdX2wHBgPq97zIbpgb+wEC+Ls0Q6a1i08NZCR+XrrrT4dXHO+h5zqHOsRGDHVN1ZrmlQXC/OMmReDMIYSrF76neY9TxcdPwJcvDI9LhDn/3oZ7j/TFnhyWSaE3Y+yr/9nwjIlvC4PtWJiQYJ1mCwhjIC65Z51JWVRcsBh5qcQbS1BCjOJ1ZNI3oc8E1BGXBdQg/0v/Lb+vKfHzIuzWM+XVgVaC/VJ1c+Mhwn2qSfkD3MZp/2h2RQnWwvBCWpNL5qX79CVqUrW0xCNYDX4HlJ8jQTb/UEBt8cmy7SO6j2w4BSQyKZP/hQ/Tnu5GvCyl4frgCNmRjzPeUtYOpAxUdtRjJofXI67zN2O6Y+WuuIIBPh11WtVrCOHYRo634Dcfs2ZPbx48ZyW77uewM4rvkfMDFbBRK+LHT1luVL5u6e2TOqEMREgtQLZi90f1ipxewVIItCpH35R9lq2THwk563YI1aKejUQhyXlCkekTGpbFH8g9vB92YroZugt6nf7NjPVFiyVwiw4b+VCSNaaAwtRx9Bd70oD4WGnjyBX+5CnIC2QZEVt0tRz2JagN5HDfUv5zDc+eusQIL9un3so08sPP7RaDAkBHUgTKzFrXg4a/3n0uxh+TEs5TbgVv+oeuygfGQCYiCxRGHyE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DAT67qdjZkxHDcD+ULSE5bL5aj5ImugYNzBj7v0ZF8p0cMvVm6/QI3RnWoC9?=
 =?us-ascii?Q?4xEcacN6iEBURyu3XHK5qYscZ04R1nU1c0I4luzKefXmHkSswhnTBHEEJdGq?=
 =?us-ascii?Q?lb8nHWcoiEXUhlWaVU+zaxRCUS08c9nVjQUiIWE228HHEfQSkdAcCYkrraAr?=
 =?us-ascii?Q?2nItrdYHhFp2jqlg0tSbWVrFX/sVObrHkACnqTMbNjlnPbts8Floj7NPBivL?=
 =?us-ascii?Q?QHQkUwwOwI/tNF4ytHuCFhufDV/+NuoDCY21GNkYbQ6iDe+nw+3PwL0nyWfM?=
 =?us-ascii?Q?4GCfSTsV6a1ySxlqbfQPv4iVFvCkbDppFwvMKHcNl6GoZKixrB1FvUorN+By?=
 =?us-ascii?Q?BdRAXVthOpbaS1Q8vgUqRjZEQyfxe/TAWHV3K3pA8VaQye6GbukdbnpiPuUt?=
 =?us-ascii?Q?yIy60jHFzAYbxYyJvQ1DKxvoeEFraOASeEwkXwkwAOVN4C3BAE18oouipF0E?=
 =?us-ascii?Q?k09bnNs46CGOwNHjAorHb8D4IoB8lFma7o7tmKntLQ75QxC+PlzHXzgAX/1P?=
 =?us-ascii?Q?qpHK7jwdAuGLPB+4YODRnwrS4/PNPtMQ9cKH3uGqtHsrV2MCPuw+mvOGwFpD?=
 =?us-ascii?Q?nVMZhOvaeVIfReySm5DumDphV64TlL3iM1Br3w3Iv4XBiL7v9PZ580Dx7v68?=
 =?us-ascii?Q?zLe78lB7sSEHkU5UqO1uL+O/YtfkSNV38uVIi/1cN9XO2LeeVjtutR4c6CDW?=
 =?us-ascii?Q?c55i4oI96YEUx0sSHBxHlkpKOcoqCfuBPjIsn/h/7+2ztvHiO/DQ1dkHt0cL?=
 =?us-ascii?Q?n5/OuWGND3xfri64ivKW/IM6agQ+bsyltn8fAbstAmq9DiJ9JWuJTmlFDLzA?=
 =?us-ascii?Q?vJZt88pVfcQwDPTy8qwPCWi6lL+PY2pug13J7yA3pJYnihMZn4/fdde+EWh3?=
 =?us-ascii?Q?ji9oB2eiNYtH+xzXBumNiYSJaLYyJWJNtE9hhH/SDqJF60Qh9uyqF9NdED3R?=
 =?us-ascii?Q?C2Aa2l1/ejjgMA/zcTXT7uelh5zbM89/qBksegarMhmQrI0RvyXrWPRq11J6?=
 =?us-ascii?Q?UVjVe3wrOXoGh1CS6LYwIp8QPNmjdW/rs/vZUrEYH84xERalOq7I2Mt7bnNV?=
 =?us-ascii?Q?hydgnWMZJg/O1QDiKV5tOr7ELhN7MF6/JjN2PuBn5RvjyEfiHQuaxTvYgr3p?=
 =?us-ascii?Q?mnOK/VL0vXKiWX7IcPFzPexVdXqkePgV7j7iJiCeTL8oT3mzE0AbSJE8yNna?=
 =?us-ascii?Q?saXE4/FtAeNGiccMlmv+v+ra2LW6gvoLjoGtlv6m4GI5aUXSwpoC2Y8hoLZ1?=
 =?us-ascii?Q?z2mk8E36Z/uANxgdrbo/BTJcwIisNRfh2bMocljDjwdujXj8Gyh81+QIBM+K?=
 =?us-ascii?Q?klErKZZdjxMyI4VCg6LmqXRVo2ijLs5uRr6r0t+wGzH2QUOgfzH0/9tIm0xU?=
 =?us-ascii?Q?s9alqlngzfhgDmLnAsZS3VZFIxjcac9IwYaR+Foh7cOKNVSOXPT1yG1giu9H?=
 =?us-ascii?Q?Spe0v0UFKgn5DF4A9lYy0GCXw413lMONUis5cOJJf8POn2IpeklaHlXHathI?=
 =?us-ascii?Q?LnGl+2T1OF8twFDdo/a7q3YSqmOzQbTO4Ju84Sttmrtdc5OY83P6o6OS2qoH?=
 =?us-ascii?Q?4Lfmy8VdZbcmQ7TQLrKuPzUoTXbYeDddMFGGTHh6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ch38+WhtTtcWpfue+l56ihJUo35ASpLgya4vFudG+nYOTv31mD85Sttx6Ocb8ZBNCWIHcTN4pFCU+/jTvRMK/EfCtv+p5W5lb37/wmd+0mkbIfKJmJn2mzeveSwalTXUmMgIlb4RHhX2ICD/hp+dlEPwdXPBhJZ++hKajz3HovZQHfNAqIyuMjWTKNHbRYuuPxRku6AvIGz6Eo/jQs+ss0UqB5xka8Hg6S4rRRdrJjY66FebQmWf/NlrGLU21c0H/7w8Wy5hp1TXBuIPL/ArY2VEBgiZ9eB2+mnS8sZH0dZrsKhVCvLANg77t0NmtuQowyaTnIVy8C4Tygejb1umuLPLT+5ktpWDRMaoyb7nf3Wvh4YuzKeKNrtxGXkGzyyvjl7qyJp2+xu9Tdcn72ScCl5/cPzIhLhW/qV3AHhwa77ktD6xTmukC5DHRozYNiC1cIBbBG+jcLErWbilFXxfQs08J6nRQz9zf523KYemc3WfYeIUTaGx7Zk5k8vlfTv8+4Do1rYEqUTms+DojLCP+QrohSaCZNM+flTWxK8f+YcOoHCwexUGfR0bSFRdjvvwa2OSgzFGlaFZu0SSZdSFyNPPC/ZMjAj1mSPpdVxdYkY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d00b949-d5e8-497d-0016-08dc5ad52504
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 09:44:27.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pYfuOvqmFZNyn4ycH27xAPPiajYaX/k5aFWqbKEuriM44jgt+kmHB2jsZWVKaKfnL8xZQNWm1qOay6wmV8DTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120070
X-Proofpoint-GUID: l-kcL12-HztZ_gH1lVcmbUs3Oax480Nx
X-Proofpoint-ORIG-GUID: l-kcL12-HztZ_gH1lVcmbUs3Oax480Nx

Just rescanning a partition causes a print similar to the following to
appear:
[    1.484964] sd 0:0:0:0: [sda] permanent stream count = 5

This is bothersome, so only print this message for an update.

Fixes: 4f53138fffc2b ("scsi: sd: Translate data lifetime information")
Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 58fdf679341d..65cdc8b77e35 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3120,6 +3120,7 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 {
 	struct scsi_device *sdp = sdkp->device;
 	const struct scsi_io_group_descriptor *desc, *start, *end;
+	u16 permanent_stream_count_old;
 	struct scsi_sense_hdr sshdr;
 	struct scsi_mode_data data;
 	int res;
@@ -3140,12 +3141,13 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 	for (desc = start; desc < end; desc++)
 		if (!desc->st_enble || !sd_is_perm_stream(sdkp, desc - start))
 			break;
+	permanent_stream_count_old = sdkp->permanent_stream_count;
 	sdkp->permanent_stream_count = desc - start;
 	if (sdkp->rscs && sdkp->permanent_stream_count < 2)
 		sd_printk(KERN_INFO, sdkp,
 			  "Unexpected: RSCS has been set and the permanent stream count is %u\n",
 			  sdkp->permanent_stream_count);
-	else if (sdkp->permanent_stream_count)
+	else if (sdkp->permanent_stream_count != permanent_stream_count_old)
 		sd_printk(KERN_INFO, sdkp, "permanent stream count = %d\n",
 			  sdkp->permanent_stream_count);
 }
-- 
2.31.1


