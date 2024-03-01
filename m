Return-Path: <linux-kernel+bounces-87729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146186D846
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F891C209B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D40631;
	Fri,  1 Mar 2024 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KYZ7d4Ro";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DA7NHelm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EBA629
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252218; cv=fail; b=Fh/CStnURd7KhW0NupTHurHPtd9y+N2/7bPxkyok/ToBYFGuDwL8qU9GGKr8U/cWwnFgnAZXDQ2G5YuPXOmKP3XgXU0LisHexpVZBwjptDsWY1n3niE8upvukZbh+i9XYyBry7zbZBW/9DSGURIeQkPoDffTCuitC+LrT3nz7Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252218; c=relaxed/simple;
	bh=FeZ32QuvIc2NyvdSqRIM5Kt0IWA/V8T4V+s0NfcUcoI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aeX2/12b+9HhJNs6AzN7SggsQw2fGnNx0PcNJ1xMTAFr+QApeOjcqL6nMboeCxHAV4hWKLxr8VHumVC+8G0ugrw4VSqpGz7DSanHvtjz0L7azTLdEEjIeoOtWmUejGKlEbdndK6zYVRjoEpg7kws74215ZBd+0NUf/FWlWICEr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KYZ7d4Ro; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DA7NHelm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNBVrx004398;
	Fri, 1 Mar 2024 00:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=eXdWGR/QsUTpTg9spkJcjDlCt6LQ8/2HgnBWvcR/vEQ=;
 b=KYZ7d4RoMC9eK4V6ei0qWwAnVH8uispXq8vXHcGz7MNu7Fs78VLIH4SgTd1Sx25Cvad0
 ErSaIA6tsMV+QhoAy2cseoRS+zj17Z0shZsiwH8chAUSr26IDG3qtNhox8iUjpkRoO7r
 kQ478RPTRijsG7iIhHHtjiBZuuI3FgHJUEk2SnedhZS81C9vCoqeCmJLQ6Q/kj/NeTDU
 MGsOdiC4uS1VUgtlOn62+nejxhMZN9dOfdwo5zk/bXCJ8DPGH+7ADEpHDnO8SmDFtcTG
 aenpM1C6YFs49nkDcJZzM7GsBI6otPsrAKR20WfH0RLzCzANcJ89tMWg7qlHXxfNZOBL FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vf61m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 00:16:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TNug98004681;
	Fri, 1 Mar 2024 00:16:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq713yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 00:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTkS4i73pLYqtNTa4uplFbmlRXdnZmKRqUkEAFzRqT9ZVs3mw685w+1O4xrBgvoRYSORz2qaIt/B0gjHr/Qkz5NdKF15K6t0gyNrpYzz6uZS5JFIdvMa4azTCWUaQI+RJnA5t1vVN231yUey0PnlTurIK4ZneI77s47ldLuFz6MW2tNa3wQYob8ROEKUdgvszdGmHa8R2r1Y2HsAePriC6fLvCr27kuzic5L174XWR3cJSIeX0TjkunH7a5dmM3Rk0Ghv9+2qcnbzvpPCUDVg+Atzs1Y3E/tP77jRLwR3NvPXFAPKAUKtRbQcZgtFRD5cCnbUm+NByEQfuBP4t/gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXdWGR/QsUTpTg9spkJcjDlCt6LQ8/2HgnBWvcR/vEQ=;
 b=TPmsOGQWDBSDIUPgEg3XHdfYYii4yRgDneSDBGshA9mikKCeroQQteQBbwCA8kGtVALty6uTJ3/7N08JYSY9Y//VJzKHB3IubZrKcQpcrQ7wuYQOv5kzb8hCLZUJXsqWiQZEi3vuGrtuLKoBBmBx+Kci/fQfDahjDflBO14ZYUxMhk1KoPefJVEP3iHnaNT0i5fy/mhXHLmBdX8DKJ1jOfKSMnWhP+LKmz0QY4ojUBzspSrAynsqL9PS4CxAOWDmcBN4eBddly2oiCcLZ0XtHiSpUjx69vR90UwsXscQyvwuImgiUKTqjvEiIaSnVkcf+0L45yS/cLoifnUaj3Dieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXdWGR/QsUTpTg9spkJcjDlCt6LQ8/2HgnBWvcR/vEQ=;
 b=DA7NHelmayQ3ZjL8nFXwKu+NTs/OO695g87r2HdxnmNmf1A8g1VIqGDSfMbImX/ylm+UN/xF5er1b/EdhP60i6uKoEAC2tyCCfmGzk8TcU4na+DXg9f73KLxXRU8jJjwNqEwlQ4qGef0uUz8F5nc4chN4U3gn3UY8NgHpd8YsoY=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BLAPR10MB4867.namprd10.prod.outlook.com (2603:10b6:208:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 00:16:33 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::8156:346:504:7c6f%6]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 00:16:33 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
Subject: [PATCH v2 1/1] x86/split_lock: add the source of exception to warning logs
Date: Thu, 29 Feb 2024 16:15:01 -0800
Message-Id: <20240301001501.35592-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::48) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BLAPR10MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: 580b40fd-3050-4c3d-6822-08dc3984d9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0p04lllEXPMa/zZPqQ504n7lT5+cFaMKFl03kfiirKtSp2lhxS0Hztog3/HopCWv/yh+kisG8kXP+/kn9IB70OsD7tLksfFx8bBOw2ruiszshGP9ZYgUBZbROAy2Q0XdfL5hkPjgrLeabdJvHp7Za4EciEjh7GALkdkDp3kTHHno/D4ZSh57cJIYxtpgrER17WlYCpiP5vwJeXJ2+6ClYqHGsAm02rx5ERGgtLlsO7kWKui85IZh1zmvh3h+GOH+hFzKZmUXwzL8IAcg5Uz0pVXpiJxDP0XfWT3EF5pvMrTWRq3jK59eG7f3m9VAhjMphGtoibJ4vtMA1uYDXR2SX66319XIQ9Jmv2dMclc0OLAODrto3UtR27UEp88zL+Wzr1J49gmV7sWqkLzSWRl00M822YcSXij6o0bABSoo8BklM3f5yNxQDa06Up2kaOsP1+YIvAUGVoJ3cJmxzZ2tGdAoqJB4BMVEIGyQoaTrKiRCxqpOYY0U3cAExliuPnw5mf8HIyu6/qEYNNbqBfffGn5NFI2UHbvsUuUDnsYNQKtnIyIHKV7SAyBOhjRFxdCk3ygKbKjKfOJ27VUbvwCGefqP4PZvIO88lGt7lIUW7WPqYNUPZRFFuI9CeNT6T+bhXFdPWCIU6RgSVzVP2x0EcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QtTIrEYEeXETAiowvgWLig6HJqNLdkYkWUApPOq+1FlrlTwzqTXGrBQb2+V0?=
 =?us-ascii?Q?988qVTX9srJDZt3Hm1/Yw+l+35ctAY7PJpfuPMsL+WR8j1mc1459JqWxWVO7?=
 =?us-ascii?Q?tcZWDZOO2Q+WAp2ktu/lqfriebyZdU/JaCoMigswHcTHgqFGLDoqclU59zXb?=
 =?us-ascii?Q?tnMfNorKryiK0UpN1tPYb8uAVJ9O4tbAzveWoWWwwNYpSCiyV+aKqy/bQRCR?=
 =?us-ascii?Q?U5/Yyl2gTHLtPH5jIx7oauFOHGv7FAfHhEVFpdLSX8/OyKz/4kBGDJyLnat2?=
 =?us-ascii?Q?cIDsbzHK94ws0Hhfb2haOQgdzc0eigiqop3/eECbhkQkFqkPQmzM5WxlrFLU?=
 =?us-ascii?Q?azGnfZUlrrp6jaJb4+jb8weR0DWPl9Qm7cFovUtd17Q79Tkfp72m6ctBRefg?=
 =?us-ascii?Q?IoXccgggg08s46EtXPGf3Pn0OWchlAHEzKnbuqHjN4EU1+B6UNRPokCZPmZY?=
 =?us-ascii?Q?g6mAVTS9ReaW1rrw4hGMDb/ZY9kyEJ7RLPMFZg16YuKtEieUl494u/6w7rpO?=
 =?us-ascii?Q?9zLCwYL63i5NpJ4Y9adnE2sbN8XiX7SrdxxGKFBgLOerh1YlaALvnJhrgMN/?=
 =?us-ascii?Q?MnoWZ9l2BA6Yf7vNEksWgjBafhKgD6SMGaZ6v7E9IjR8zUPDxkMiLihR8Rnw?=
 =?us-ascii?Q?w3SD4t1ijNKpippo14M1XMRgEHqa2V0/SeJcrcXpNSJigcZ3uxO+fZa/qEkc?=
 =?us-ascii?Q?h41wXvOd2qrAmOCysj0X9yW8Lzr6UYSTUcJ64QYy4aIlfA8IF/+jh/SL743J?=
 =?us-ascii?Q?cMbiM0zLcMey+E4TU7ejUYIE3fpB8q02qn4VIiKCEhwybqsJyIlf2oJt9cx5?=
 =?us-ascii?Q?OQUUZ7sb/HoVWjQoj+aUHDy2fiYgUDpMXFeKhRDxFdhgzWAayHa+rD9IN6DQ?=
 =?us-ascii?Q?l1I7dXCacSwBYyQRA4T7MnbMlK20s/PzC0rn3BOgfQrRKVQp4QvNLY3/Krz8?=
 =?us-ascii?Q?K/v54Mk81Fzi9yKghjoPLvM9/tvodd0qJFrZrzcFSzdJg1MBHKqOVZAi/KvT?=
 =?us-ascii?Q?JCIF3fdsUAOIByQlIV+iZzbqshjS2tBADBwq2T4pLfdKktcKk1GyBB+PCiS8?=
 =?us-ascii?Q?uyory9jy/6qJrZb/pkaQq7RBGJJpOcKM87hmDHy5otMrC65s5yN8yjEDV2tY?=
 =?us-ascii?Q?AISMoY+V9XmCrtaMnw7AV7M8b9gcGzIGqkigPAIYhBvtqVYnCYHic/JBHsQk?=
 =?us-ascii?Q?SL9De3fs3jZ0JfUwLVfBrZV9GTnwGH2THdpCJsH9z+GFA7kEiGyKV4J35E+t?=
 =?us-ascii?Q?7zsiwynhIYVId3MJsdLlgKLI0kjuGeyCU/XyvVSUWVv3BKyz7kHaqdHrLziw?=
 =?us-ascii?Q?l5MJMOSN+yP0UYpti1jJOV+M92DBz0Oc6VR3GiCZ67+LaK8lWDXQBs/PL3Fy?=
 =?us-ascii?Q?bXJOf9nHyQyTcKQfIbl+BE+ldrMUlewllLkY1QRPPsvHKFeTA0E5+hwSwjDs?=
 =?us-ascii?Q?d+iywb+g6HWAkoTjotg/EZ73ZZV/AGK15htqja+G1I2iD5Z1UknZH2qZ9jdC?=
 =?us-ascii?Q?4aHAEFXcDMPB9BrbAGZa3c3nY88kq3uBUKXVU+X44qEQWpyC/SimCiEAvxxm?=
 =?us-ascii?Q?o+W6g671I3edKZ5GSgl0jGG8k5ShKcblC/CSPScH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dctfZafhV+dscLM79fuAcPcm9bVP9954l+ilK9TrwmyCPD2ECfSo/5g3wVTrCRBWjomV/cxN4Se1OEJsPdbFpy6dG56PXUL5zj2fTx0zi6efvQfTre5iDS1wfCHOBWDGb8wTx74+eTkXOtsjJ70Wfeb+GcF5DqHmPGty9UlGqTuV0vmjAagJVDoX3cQq9P+5fm1J3oRVk4K2MIJqtUZmUH+B44NkBLE/JoseFvhUvepCPm9bxTwWedE1awSBdzAyAyF3p2yY0LiIKjgc0uqdbvIH1YtakNB23cOcQj6TMSIcvN/UK5G3CYYGJploGnyHeyDQcplfjiYTQyuGYWza2kxYQM8xm6mMySl89ThhqsHU2x/o6sC2td64lKr/jnYWghaDhYCXItl0uQxXO8NHml51GoJhG4YYx2ko0HJkqkO4Om8jh5BITpEhidgTecd282AemRlLM0taS+OcC9GlVx+TyCnFKJQKOPsvTdZfOMVYzc/Wd6EAvnOfCw71nHavW56Ud84ngpDs3E8gm4IrEl4UOGQoZWSsD72gcqKtyIb476HEy9Rw75hAlO2bSf0PndBmhvpjn7gGm3zcEVtN7b1DRwNj1XaM5vPTfMyfRTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580b40fd-3050-4c3d-6822-08dc3984d9fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 00:16:33.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWKyT99c3nhql3mUi/NYXEL0EtRBJCP9FkVRzB/pvdypV0sOrvzIOffYpViE8LrZuVnOTaerZG5s/fTMjanvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010000
X-Proofpoint-GUID: _NjwxSDkmYDSgbFshS5raqs3pgYh-pUZ
X-Proofpoint-ORIG-GUID: _NjwxSDkmYDSgbFshS5raqs3pgYh-pUZ

Currently to trigger split lock exception at the guest side will print the
below to host logs.

"x86/split lock detection: #AC: CPU 1/KVM/65886 took a split_lock trap at
address: 0x401173"

Although it is more likely the split lock exception is from the guest side,
differentiate if it is from the guest side, or the host userspace
VMM (e.g., QEMU).

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  - Pass the string rather than bools (suggested by Dave Hansen)

 arch/x86/kernel/cpu/intel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..26e45d9a66f2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1155,14 +1155,14 @@ static int splitlock_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
-static void split_lock_warn(unsigned long ip)
+static void split_lock_warn(unsigned long ip, const char *from)
 {
 	struct delayed_work *work;
 	int cpu;
 
 	if (!current->reported_split_lock)
-		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
-				    current->comm, current->pid, ip);
+		pr_warn_ratelimited("#AC: %s/%d (%s) took a split_lock trap at address: 0x%lx\n",
+				    current->comm, current->pid, from, ip);
 	current->reported_split_lock = 1;
 
 	if (sysctl_sld_mitigate) {
@@ -1194,11 +1194,11 @@ static void split_lock_warn(unsigned long ip)
 bool handle_guest_split_lock(unsigned long ip)
 {
 	if (sld_state == sld_warn) {
-		split_lock_warn(ip);
+		split_lock_warn(ip, "guest");
 		return true;
 	}
 
-	pr_warn_once("#AC: %s/%d %s split_lock trap at address: 0x%lx\n",
+	pr_warn_once("#AC: %s/%d %s (guest) split_lock trap at address: 0x%lx\n",
 		     current->comm, current->pid,
 		     sld_state == sld_fatal ? "fatal" : "bogus", ip);
 
@@ -1237,7 +1237,7 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
 	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
 		return false;
-	split_lock_warn(regs->ip);
+	split_lock_warn(regs->ip, "user");
 	return true;
 }
 
-- 
2.34.1


