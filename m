Return-Path: <linux-kernel+bounces-96954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9887638B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8370FB21F53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4D5B5B3;
	Fri,  8 Mar 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gqfv0dN8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="acezTuEk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC525645E;
	Fri,  8 Mar 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898271; cv=fail; b=IRaHDFdXbDIbe3sUPDtHgaOqcLMlrY1/dOb4odcNe0NxeJOJe4XZzgK4r3XbtsUP2L7paMYn/ye7wWN4bB93ATiIh2EH0kZCD8pTm2BwvLoUIX0aEiFncQo4aGl3Sw2egPL69GlgkVO2eJ0vVXZZ7YW7TnTCAwyy8HgZTd+Bssc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898271; c=relaxed/simple;
	bh=pEzEHiPBUz97xspaDcmRTKTNqsySLTs9El07cO3+dyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OAzmf+CLrVN/OK/ynagFnqDQeydyQv1i3IckDbJlWNU21aCnQnVO0cUh3Ye6mRtjvn4PO53nJn3DnfcfgZV6STi3gTooQiHvOpL4RWe6TRbOThPBcR1nhW9o+vCeaidNx3zuBvJpIQBPYBy6cysBG+olK3bSZJLG0/nbs+r1qHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gqfv0dN8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=acezTuEk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Aht0r003610;
	Fri, 8 Mar 2024 11:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xcfHQnq+xdD7FZj+odiBiRBumssajAccWZPEPADKf4c=;
 b=Gqfv0dN8f14HK3PzkGZtWuQtRlbfYWdurmvHHNyqjzIesKBhbTp+rjpEKy4A9tC4d1My
 2Pg7regjHLoiViapTpAgfSJMCDV54Ji3+jgdiI/Q6HU/XTvZLRerUB/eEYbsyMRmCVFc
 QE+tUBZJHH59w6uJZxXJoxfKkFMN55SCpnmVtMy6OHjvC1J5LGHkwqTrH62U8wACyYln
 g69UR9SByRCb3be3a6tSvvnUbBF9H3WSpnGgg8VG5IYRvZ6jpVvHCrEauq/MjpeJEgdh
 rvyjPcOpqv9C43s4WAfwuPdbkYHoPKRFUUqGyYlgpau1haA9ectj4sbszgm4pcd4Yl7O 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw4emh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:44:12 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428BQQoq032047;
	Fri, 8 Mar 2024 11:43:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcn4th-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 11:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWRh6/1rShwo20HwUrvCT0mWsbav9KbBiWbF0IhHptytn3YNPM5w15mpTYnANlKZQgcBQ+V1sGKlX91ByDWIaNOkfpPdEuyJvM/WMxYXzD56IcZaEpHpgSeUCLfH1kQDttcIcztCAux9C2R6BZIpveZ8nqVgZ+Ua3VV9oMG6Aq1dNEJ7y6aNLHNo69RY3RpAkvzmQsw9HiWr7FLnxL4GQ7kqUptRW7QrQRgETDKDc3py9Q1ViE6u0Bsx9V5XLt03ftr/WUeTKgokIwVhTBFFqiMRlSh/ljCqmydO+r6uwHW89+pCGHwamaT9Qas0GujLsT8or/ukuIElGivtO6tvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcfHQnq+xdD7FZj+odiBiRBumssajAccWZPEPADKf4c=;
 b=oAQTzJGzk+nJNnGphX8qQtQ8kVeJ7e3O2WBofc+JxiG/PelMeeGKBDcDijdL3pRSjPlyRgHenAzWYvUp7zu1m5MA1JNLrinBbgjOBSEnVN4NG6WeSLOFZi+YXHDV4qGGDf+Q1D6JIs5C5MnVXNS+wO0YzIH08u8fRqlZ+JLNcNV8cdSmxtSY+u7zyvctqnV0S1wsrbK1D6w6xV4Z6W4PhyNEn9/wi3KZCuxRg2bkFQ3ZsXyyjz4jQrIaUgDyl+HdoaxBMNdYnC6wXDLkSoVvEiqWtWw/hDDnv1w/Ncr1PAT+P1Cumj5pjatvqQqw4uZgCMJ4uFoqXMXVP8f+Tii4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcfHQnq+xdD7FZj+odiBiRBumssajAccWZPEPADKf4c=;
 b=acezTuEkv8LpO8EjWUrP7r+zlSYbxJ1MDmIWInrmDUpdgXSna6LY1PNPYfuVAcF8S8AyYS92RoflCIZ0qojPhuP863Qn/+j+ijwsqpkyi4MVz8dfmaWIIBJINrsUNqCDmkmWVfDzLD+QxCROfr7c4M+shiMI5qwh7Sjw/n3VuvU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4595.namprd10.prod.outlook.com (2603:10b6:303:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 11:43:50 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 11:43:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: jejb@linux.ibm.com, martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, dlemoal@kernel.org, ipylypiv@google.com,
        cassel@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 4/6] scsi: aic94xx: Use LIBSAS_SHT_BASE
Date: Fri,  8 Mar 2024 11:43:37 +0000
Message-Id: <20240308114339.1340549-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240308114339.1340549-1-john.g.garry@oracle.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4595:EE_
X-MS-Office365-Filtering-Correlation-Id: b466ec34-3f1a-47be-259a-08dc3f65061a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I6tLLr3em2dgXnNOLvmT5mTP0RCK+WPKswIK9AAp5hEzBHOP+i+UZRVSnZuDCqNMbWOGyeT61Vbw0IFarAU3efizZIWBas8Bkl2QpZtZQek971Zop3DJA23DSSDltV2XZZDo2IazHJ3ehyrBMgyisGK2KJLDWFC1hMuScS9NcxqpYsMMf+LF4x6SCctXfprs+3dTe1oIYuEnmg+4SJ5SAfLR5gYFvPEGouKTLqi/I8wiJYtujhH9PNZhykfQWiyDuTIqT8QjrB8bpNnzustS1DtH3s6QhU0c4vMhuaiUT4aNJ+bLmtyffS4mBGkx7mc1Vb2RwCQM5Sr7b16HwEN7faezPWllx8OKjFAxl5mnSw0gmC61/mdLqLkcF5KmI3oUV3NIRZmFliKDoAKsqJdiLPpMVjpL3dE3TBViAvJzOMWCBxHyyV9QFB34tc/L0fnQLLu/YI8et9zEn54Cedtn3tzg3YbjUILCfaG09K+yK8GtlcsPgu2pCg24ZEdL37YiAl23JnXSrQuREhcmY9QxSq6KYoaWK6ockMEqgCCrIY64deV5eVvCkRpAa//706Vk1mrEBV4olJrI6/8xyYpw8/deAP1TRrwGhq+8OWfsRd4gvhg51i1M+4R6LzZ5ODgBN/Wba4pWSQDom3iJIQZTM1Czf8wEfhzBsIngVrcZa18=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ktizAJvzR73OhARsi6nDB9aWkGJSM35Vp8DjppVlDQ9DN2N19ltBWTTyX4J2?=
 =?us-ascii?Q?5q/QgBaevvEt/W4XtJE+Ag4sMy/X5bCnf/6T7aVhdcwPHz8crsjuFd6zNA0O?=
 =?us-ascii?Q?pcbdy6ZdSn530HLJCpjtVYqCSXSsJEBUBoIQxjsnkzoC1GXGPlgZ0CGj1RQz?=
 =?us-ascii?Q?0WcG3zUb4cus004HQh2V9q+eaM3NrbcEgo7Qct2PP6vvnmofT86ECNl6EnVk?=
 =?us-ascii?Q?zs30yaX+kDk5rV8fItcpUOUwRgzTsXZbi/ukquD/vrU167laqSvYAXdGuBW+?=
 =?us-ascii?Q?NbPvQG638QJH60m7emdX3qifMa1rva+RcVoqePuPOCJKtvrkgKvzn1OEsxvt?=
 =?us-ascii?Q?vQGA832JZTeWkTcYKyOPSfhgJCdKm97Wnmak3TACTABj/W6Gz8Hb8rbyKxNP?=
 =?us-ascii?Q?CqWNFSnSe8dvWdird95k2lwKVsNpMA3pHIn2G3oJKfm4dSBW3kukEUyPrCNO?=
 =?us-ascii?Q?/F8ZatiMttmGyE2aotvUD3i03vfONhxkOSGF0pyndTXWoj2XUUwYpgGbVBCh?=
 =?us-ascii?Q?l2O1sRXzyZRTGrmu1mRIsiB8IhkvhsJFIaPFKc3+UQplTQN6BMcZW8LSOa3V?=
 =?us-ascii?Q?BK3Ynv+SzeMpOsTxulpBogfgvYCJwEiDf6/3gO400pK/F3dVKNCwbGsburfo?=
 =?us-ascii?Q?RsfGh1zTXYcYgemZHgCl3bVjvlJufXEOQ17Eln/5x+QSqae8BvT8LUMUbxb8?=
 =?us-ascii?Q?LReWpDDZX5y9IAaEC0sYwdNsMsc/VqiYHNg1cPzm/UyeBVXWL7TNyPgQmyH8?=
 =?us-ascii?Q?HjkR1ccU1DL+/OmS8xovhgdikC+V2xfzFtDSY5R7HCJKQCNkf8mNOmTZVYSY?=
 =?us-ascii?Q?M98unwfxTXhLD/DQ3/pa2ZYrEfuYdr3EOdRcOEwJUtoN71hlB4GBFqlyqe8n?=
 =?us-ascii?Q?EyK3/mgO7QuLNx//nOAuBA0eBNJWY24Fplnx9LDLssX2FPiTOSgBlNGya3VF?=
 =?us-ascii?Q?8HnXiUY7NF5lBQz0PnyW/MoPIWjNpgLnEyw9+SXVJlXzGmIcBE5Zd8hBCJ48?=
 =?us-ascii?Q?p+QZjJINBM6cxXE/XxfJXIxJrLU8g6X4pDV3zam/5O6ju7EKNcjKnV6xbD3p?=
 =?us-ascii?Q?2uLopkDplOeE2Mg4q3Z648J/0IgTCfuVY2VXI6eGSnPar2YzxGjBaHCsfVIb?=
 =?us-ascii?Q?fZbbxPlOeZLx9+k/M2bUvMOwhQiHaSq9dERkE4cj08IqFRW0HSpM5NXz94Yr?=
 =?us-ascii?Q?Y1xvoNHEaYPUqYCR3BW9RyoW9wnppppfF7bF9tVGxFYvNdOLYvD3zkmDc64z?=
 =?us-ascii?Q?qDbg1JWtA/Bq/z32VgVi6/zBCAJKWRJjk+aJf1XNVMUuWCutb7wv57GhHBfq?=
 =?us-ascii?Q?3M/zV76rFgtr+o9RCqzz6ieadoa+PwFZNk2CvOmlHmqKsZjEi5VLt1bqKtoU?=
 =?us-ascii?Q?LxdXUO4HOUO0QF6pAFSftPDnGHlM6LpJ/UydMdhYW0ar+Mh4Iu7oDplmxz6S?=
 =?us-ascii?Q?KOknIfCLW9aUna93oQ3QZxebrW9YI+D7xEiPn5IzQ3w5B3ZlaoCspwPh31Az?=
 =?us-ascii?Q?svuIb55MKtXtV+CKwOSbdol6QLQeJ6LKhLHlI7GitYqeJQmflZeoLmQWQHHN?=
 =?us-ascii?Q?0LbhGDD84a4NkMHW+boubDOV0c9lTUhci2Za4lbszi81zKzS4llFG3Zx9dx2?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KtKa0CMafXr70jtcWybUc62evGVWM+17VWyJ60kv2NncoG8PdcXyCIsvuHdI3jUJtWiredtp6x2YpkyLMF6t5p+8Ml3qu1PTD6mCnUF5E+BtStE+5W/KdK6WhWjlA6noDM3ilGaD/W1irhd+Qqs4pl0Y6HW7Kndq/lPXNP06oRLE4vMH+R4w/bNgiWUl6T1r+pqBWknnRTIOeBteA7PpQPtoT2Cy5oVsOghaQrbMBHTRI4Hhon7gvTlbd/pn9bTZ8zbqwy813bZ3o6wQzxrblF52C09uWXGyV1B45ysI5x+014eut9AENJn+4IhuQHsd7IWRs0XV5mika3foAEYtv1f6NODREqa3BhYiKLP1QwBuc8RWKZ2MpCaKUWSBD8Lkud6BCyFTFze9Fjjh4weJOunAD4WGZQFCGbjcFaWyYbWkUZxuq3mOllZkJV5Vmr6w/ZVgbyLq92uE672WcLiMMNntsODUEjhD56cVzKksxKF7rJjpNwpX0H5AGy65YiaIgfYR3nirJPDG6kC5YFwUmoLVIsgsd6K2iGAJFeGznAdFrFy2qiVSKGGKNJ8kAZJqCfUhiuU5sEP/s1A41Vd1fDHErGhf8LoHOTN2ORvrx9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b466ec34-3f1a-47be-259a-08dc3f65061a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 11:43:50.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIKsfjLHfjaMWxS+gt6rziv85MhlLMo1PhDoi/WAvGXIA90vAONJ3wqzfIjJHA+av46GrterJBXiXGeI0rNyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080093
X-Proofpoint-ORIG-GUID: C7-OSEhjETJ73KhUHT2GPSJVl5tjS1p1
X-Proofpoint-GUID: C7-OSEhjETJ73KhUHT2GPSJVl5tjS1p1

Use standard template for scsi_host_template structure to reduce
duplication.

Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_init.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 8a3340d8d7ad..53fe68124ff4 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -24,6 +24,7 @@
 
 /* The format is "version.release.patchlevel" */
 #define ASD_DRIVER_VERSION "1.0.3"
+#define DRV_NAME "aic94xx"
 
 static int use_msi = 0;
 module_param_named(use_msi, use_msi, int, S_IRUGO);
@@ -36,29 +37,11 @@ static int asd_scan_finished(struct Scsi_Host *, unsigned long);
 static void asd_scan_start(struct Scsi_Host *);
 
 static const struct scsi_host_template aic94xx_sht = {
-	.module			= THIS_MODULE,
-	/* .name is initialized */
-	.name			= "aic94xx",
-	.queuecommand		= sas_queuecommand,
-	.dma_need_drain		= ata_scsi_dma_need_drain,
-	.target_alloc		= sas_target_alloc,
-	.slave_configure	= sas_slave_configure,
+	LIBSAS_SHT_BASE
 	.scan_finished		= asd_scan_finished,
 	.scan_start		= asd_scan_start,
-	.change_queue_depth	= sas_change_queue_depth,
-	.bios_param		= sas_bios_param,
 	.can_queue		= 1,
-	.this_id		= -1,
 	.sg_tablesize		= SG_ALL,
-	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
-	.eh_device_reset_handler	= sas_eh_device_reset_handler,
-	.eh_target_reset_handler	= sas_eh_target_reset_handler,
-	.slave_alloc		= sas_slave_alloc,
-	.target_destroy		= sas_target_destroy,
-	.ioctl			= sas_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl		= sas_ioctl,
-#endif
 	.track_queue_depth	= 1,
 };
 
-- 
2.31.1


