Return-Path: <linux-kernel+bounces-133559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F589A598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019621C21515
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C0E174ECF;
	Fri,  5 Apr 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/wMAvMp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CD79Sj+I"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312F15EFDA;
	Fri,  5 Apr 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348516; cv=fail; b=QFe2n40knjabODEScLbSgze1FFit850xx5n4kwzIKnZKX0nvxMMLED8L7fNfTrCYJYzlP29y9dRKniEoU9tFx2+DpkchnAMXxFIA/jNtsAlNdUe0aIKgjCcyGwrU7ovAq45F62TWDk6epOHZyN6GEWpB/geMZf2inneI0PCPiew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348516; c=relaxed/simple;
	bh=Kg+IwcdZxCqpHgZCM794pRVIyQonhkkxBq+lOwXlwkM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=HDnPfP2ebCCqjgu1zrzGZZwJ2ZMANCKRNtKVgqRM4t/n9Xr4S+oZi+EWmUCkF4+KjzDlbHX94lfVQQGGqLkOs2a6+490ewVI41MUCbPNyOiPNdiZzC9iOOi9zvBnZ4HPdJnbP+ARNnk0jfVVKyHDUGpeuhjJfUSC+eR3x4tuppA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/wMAvMp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CD79Sj+I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435Jg96t003200;
	Fri, 5 Apr 2024 20:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=jghBupqZJ1T6b3taAccZ3hSHTlwlNhnMi4+y+ua+EiE=;
 b=P/wMAvMp+X6wKpkFlhzW+UuTKtM4lgnjRkffq+CiSbv9MXLUUIZEEYo6+Y3hYibkBr8v
 EW8fvFkfQlQUF6fSdkFatfym4LSjHgv8xDLfjsGUD6QDVRdZfnCZJfk0oxx6Rouu/8Ci
 /00nYyWMmyM71IcvVcxkFfOQ81X6JqjPcp0EhD2tHOvG2rBJ5Jw0xATcOQt7WE9WFXVR
 Vrn2MP4QjvSg/uoa4Y+I4q15kykQRlTlnBSfMcGg1UzfvDmjz5CB0jbIoiYEtd2RBmrd
 sW1JVNO3ooYmEecm1ofQ/25zEzZEpHGlNvBO0To+IhuYs/WcUeUa4WbYTp0FhxBfBEh1 kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyvauu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 20:21:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435Jj5pr024284;
	Fri, 5 Apr 2024 20:21:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9empmak0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 20:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF26S74G3/f9w//txSuURF/1sd81FdpHd8y0HzPPKAMnxttBxIbyLuoDcJ9Vl5aieZlxwsurqHJuOscaSTkPP6Jyo36tovdEeU8h3i6ePNMXb8RGF7rKTf88islzdoZex3nXKzKpLfETkKspyPmX6n4Y5n2fW0XIwSuY9xwoJFW8fo65CHFMQitY2SEOOQcb/Sy9IRPFvGUOYdQtmYgSQAOfd0P5Eagcu2q03nYrFAREmUeCE3rnZFpyZRypSSToL75523c7sDDtJoekmZOxyvVaqVs0IxKLFRoq9ISKwMKIFEMH8KhYsEYh0GLrQeNaSD4FYccoaS6MSlH3fJU7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jghBupqZJ1T6b3taAccZ3hSHTlwlNhnMi4+y+ua+EiE=;
 b=jigVNlALS/8yoIXtuYUpoGnQZu4jHdVjOCBsOG/wBhX+qAbr/DeziuxwpW/4N43uiveCg6f5b0Nr8aLD8Y4F++dA7mZLGyGTBJ1S2lCjEgSo3W8yVxUyW8GkJOVDII/HKgejhLVxhM9lwuu7I4m7sjjNUAJo9a2qHGeTmokvuMFeUjtHAmgmdlzJNhobbYj8saXC5f1InG7ZIApTl4Lw9vhiT33yVkcoUEKtxs3ZuH9CqGhWqpU4r8rtcYEzldVCfIVgYB4nDENJkrsdjp3nKai+E1JeAMMmWX6ZhrdEWg1MKye/rCSap/dU4QyI8gJHrgDB5dAhWnKVGk84ooICUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jghBupqZJ1T6b3taAccZ3hSHTlwlNhnMi4+y+ua+EiE=;
 b=CD79Sj+IvClni2Kpqb05kv19mI7XMbbQekPevtld+J4SZn5G13OQ08MSiKMD5EgU/BEobyI4EodYdc+cGdvzrWE8ILsAu7J5JpjhLxVgcfDNnm+UysJSAZXWLYEypSeGHthuaOEnkaS1gKZc9tLjOv8vjNNKum6/lfue63gJs2M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4153.namprd10.prod.outlook.com (2603:10b6:5:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 20:21:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 20:21:40 +0000
References: <20240402014706.3969151-1-harisokn@amazon.com>
 <20240402014706.3969151-3-harisokn@amazon.com>
 <Zgw--fHBH9kEQsi0@FVFF77S0Q05N> <87a5mb5p8p.fsf@oracle.com>
 <be986f715a9351fdecebd76c76626d6333b5a9f3.camel@amazon.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Okanovic, Haris" <harisokn@amazon.com>
Cc: "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mark.rutland@arm.com"
 <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "Blake, Geoff" <blakgeof@amazon.com>,
        "Silver, Brian" <silverbr@amazon.com>,
        "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [PATCH 3/3] arm64: cpuidle: Add arm_poll_idle
In-reply-to: <be986f715a9351fdecebd76c76626d6333b5a9f3.camel@amazon.com>
Date: Fri, 05 Apr 2024 13:22:27 -0700
Message-ID: <87cyr3y2yk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wmWC2pHCYtYmebVzBf763aDCIaR8moI0f7yiUQvq8RXg0Bxjkt+Y+UHA5r7nBv3iSJXwc5w9iFCJnOd7nq49TLXVKVhsAni0/QeFWVi89uQ6PgJBprbOzuLSaGDcHv8CmaOwjGe4EY+MrCiRjTlEsVIhko67nZJcJijWNo6ZyGWvXnQ2qXlPsOGkvaq47bmcqlF9/RN8UEQhxhZu5lT8GabEBDCVqoxvrxwcNNSxRXBP84TLXoHc/t3GdrfeDvZ3f8O8O+zmaOfyz25lEeO6v9NXvnOnfFAWbD+CUry9lIJgb8u6LRHBeAw6FKEjmA887bZbZitFUIJTgIqejoZ98USJS354UAbzq8UHfvq7kmIPBJ6PekPm7DpyMZ418RfGKw28SgObgNmdsTL8yV4CvztKkTqRLwMjMIsbkzIuv4+2OhhKJ6fpYLan6i5bA4EKQ/hGE8r3QjjngkTIK5OXY56JMIf6/BWymnHb6qL6e3za1f+txwlTd+Z7ti+kumMJp2p/QdzDN5O1NPExxm89TtLaAEDFT8n+hQ9c3l2yBTcT5GM7hLaV41f6bJ7Tn60sPR8GYpqrEzO19Ex+FcgoBOJjBfOeglY29Dta+9br/4ufswUEvQ12fXj9tif98hve
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bv8SPHBQbajO+uFtEPZozU05UmG+zNtk/X+E/rsNhoL0pMDFxieXpAln1kj1?=
 =?us-ascii?Q?gJpJErXVtyOlscNmLQ56cauC21Hs2luPEuIZczv0xvQmG0g25kEjccKWsIcg?=
 =?us-ascii?Q?w3j4eVD96I/W5XODvaPTPIdOwL1SIXGtW+SARXT1QmmTYrskHSszacRwJ8zh?=
 =?us-ascii?Q?wGokgJ6J1Qeh5Z8mdXfPfxI9Y8gatAL9jQisx/6j04pV4fWUKkrzrFk3Q9fG?=
 =?us-ascii?Q?SrkeS6XMb6PvBWJaRk50dIxEDX9Ranh23grRVouWMIIwCYxf7Cj9DrF8Lg7W?=
 =?us-ascii?Q?1am/rP7nHPpEuJTF6EcbpKizAKckWuLXf6p0kdKZuCvIi0gIrsIjmz9DXlvo?=
 =?us-ascii?Q?mUZUhi0b6yliBBLxXYdaSP05qNlwWPowuEvoF1NLGmE4Y7lWfkgxmFWJjqUQ?=
 =?us-ascii?Q?8/Ws9yzhRHbBsiLcSuHD6Zls46LAQ9aCS2MGPJP4C8sbPxpFhgRoaqFpfsOx?=
 =?us-ascii?Q?uqc28NOduORa/2baRxbLGBxSCKrs8Zmz2NpK117oip8zwprQy5I5tckbSMck?=
 =?us-ascii?Q?eDDHXJT5D/IE8aeNh/DjoZbd4y+wx0MQBZNhBgX0ThOysWbKgsUdcBTE5KW9?=
 =?us-ascii?Q?DncFbRj8xkW6Gf6gxVuHCIaMLmeF1DyZvX9HhB4C3WaJzd4iSV0RXi0fzjuB?=
 =?us-ascii?Q?hwplgy4VZrG/eqrhpvT0sc/e50ZpX5BQxyTcvL9D/Qsta6+is8uOZpRqQokn?=
 =?us-ascii?Q?pItIUeaL2YZuxXXMJZyVFoE9LH/MprOhhINBtKNnkqhjkjHqKeDa+dM5P1LM?=
 =?us-ascii?Q?eLSzzLBde5B4KF+tLa2TKefwAfYsoeoozbHi/wvNr33erF0tArDmDayxQ8KO?=
 =?us-ascii?Q?p22oIVqzxXRFAH5BGAb0zMpPPcX7nPvcLH67cf6+bp5OgMZxuRd5geLTwiwl?=
 =?us-ascii?Q?TjsM/wlonS+SE+a7LqHa8kODphy+rhaZkA2z7sg+XA4luAswOkvLWXHYhY8i?=
 =?us-ascii?Q?bQ5qGKNuz+ttjZitO3ywwAH1fETKE/E0vCJouPkPsbJJ1WjATdpiD2oZMWkt?=
 =?us-ascii?Q?Sdrk17/K9Ka7fhMfRF6WT0WRT1ztlRXjrVqawRiZ1zzDG4Tgc1uVn5mdT+yZ?=
 =?us-ascii?Q?/ryzh/zTp/fs5bd2fbIdR7bcC1vHZfZhn8f9JZGLoWOoRRESLuaB/Z8PmPuX?=
 =?us-ascii?Q?HPc86XP9zgdhnwWDTM+3aUwhi/wSIHyQqyktP9rP3P3qj3ks1VSYql3aMW74?=
 =?us-ascii?Q?Igc6p8Puh1VNOKPooVe5UMsmU9UGttdqqyk9euFpfHwL0rweCn9cZtsgdc6l?=
 =?us-ascii?Q?6h5OPSZXBhhL3rkEhLxWubqIEI//tPjHkkffXeIKgLqvGPJYS7XRd0/M6Usf?=
 =?us-ascii?Q?M2jVhC+K1OrIh+7CnjFvb/yiVSwEdESGgKTDJYFhHtqpDSmtSWIrnRF6MvUU?=
 =?us-ascii?Q?lQLtu9SVbLwxy5Bs7SuCqSVsaUMlUsPhXKZkiVcrjKXBVCbFGuj8dYL+g9Vu?=
 =?us-ascii?Q?ez6ysjd91kkkk3T3UHoAxBmuiGmYraKNU7GvDdzL6/GBXxz1z3MLmpFB3gm4?=
 =?us-ascii?Q?1JIQxhUL2Yf5rwWHeKLdztoTIodFYcHGrQU0jhznu257w3w6+Z93MaE+jeyX?=
 =?us-ascii?Q?oXjtEmG63n5yHR8bSXfCklaBVOaRKXeHUSXrFAmai9LbQ80/q7iLurGOCHJV?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IioV72DUuGhPGXYZIjB8LS+xFfFS93i1NuMSIFvDe8f47H4Tn6qWrnpVTHV/vmq3KOLPtF4ABuqIzhY3N96dV1/klVdA/lak/I67zpwxVsfIiPF/TTriR0fqU3b/M1V0SsNo9AXRejPOO4Uzfw1RQ+J4jiRcKOttkXROT4tM3Yks/AwZCLicsRyjeLTrDQmutnuTdoUlCzz9fUeZ/uRer1ER8nVPiIxDNplwktCEC/FtBNYcxaoJcqJbJWh7gJcdx5LtloHBnO39pcMaGRDOcalKX5kfY/QrWO6pNL2Xy68p8Cioyv4MU9Em0vWXdJIXy0UaJzaY200xZJxHG8dFSXEKOLeIBCnohvBIFVdd1jAkEwCWkslhxlG7cLkDdzX8Xpknbw+OqTh66IMUrXF93tLfbZCb5z1UhG1P5mqQsHv36pUOAc2iqxcky9rqDpDYA0+e2NrQjwNXYho5IDlb0KGQqUPjBbjHCGOW2Qp1acVDODz3+detmRJUFJMQH7ZRUWlGgX0Mhlz470ztBlfkpMJwLqgWsNgF6Fqe7e0m2dVLApxDAgDRTN7YDHCHH4Pl4ZBAQ58dTKw8xrpwJ8o/EUG0Tf8Sc3nmdI+X2J9HpA4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afd4645-1e78-475f-58cc-08dc55ae00c3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 20:21:40.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+XYJtJVe2Qc9R6Qil3DLvQ0CIBcjbtrayOIKLPvli74BfZDfNUQSk684tLj2LXKqzE29nnxI5KdRxWO+m+DzHGWeuk7F/Lr6vXvcE3eZpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_23,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050144
X-Proofpoint-GUID: IqjR2dwu-dX57y2tMZSrWYGNr0l_MKz7
X-Proofpoint-ORIG-GUID: IqjR2dwu-dX57y2tMZSrWYGNr0l_MKz7


Okanovic, Haris <harisokn@amazon.com> writes:

> On Tue, 2024-04-02 at 16:17 -0700, Ankur Arora wrote:
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you can confirm the sender
>> and know the content is safe.
>>
>>
>>
>> Mark Rutland <mark.rutland@arm.com> writes:
>>
>> > On Mon, Apr 01, 2024 at 08:47:06PM -0500, Haris Okanovic wrote:
>> > > An arm64 cpuidle driver with two states: (1) First polls for new
>> > > runable
>> > > tasks up to 100 us (by default) before (2) a wfi idle and awoken
>> > > by
>> > > interrupt (the current arm64 behavior). It allows CPUs to return
>> > > from
>> > > idle more quickly by avoiding the longer interrupt wakeup path,
>> > > which
>> > > may require EL1/EL2 transition in certain VM scenarios.
>> >
>> > Please start off with an explanation of the problem you're trying
>> > to solve
>> > (which IIUC is to wake up more quickly in certain cases), before
>> > describing the
>> > solution. That makes it *significantly* easier for people to review
>> > this, since
>> > once you have the problem statement in mind it's much easier to
>> > understand how
>> > the solution space follows from that.
>> >
>> > > Poll duration is optionally configured at load time via the
>> > > poll_limit
>> > > module parameter.
>> >
>> > Why should this be a configurable parameter?
>> >
>> > (note, at this point you haven't introduced any of the data below,
>> > so the
>> > trade-off isn't clear to anyone).
>> >
>> > > The default 100 us duration was experimentally chosen, by
>> > > measuring QPS
>> > > (queries per sec) of the MLPerf bert inference benchmark, which
>> > > seems
>> > > particularly susceptible to this change; see procedure below. 100
>> > > us is
>> > > the inflection point where QPS stopped growing in a range of
>> > > tested
>> > > values. All results are from AWS m7g.16xlarge instances
>> > > (Graviton3 SoC)
>> > > with dedicated tenancy (dedicated hardware).
>> > >
>> > > > before | 10us  | 25us | 50us | 100us | 125us | 150us | 200us |
>> > > > 300us |
>> > > > 5.87   | 5.91  | 5.96 | 6.01 | 6.06  | 6.07  | 6.06  | 6.06  |
>> > > > 6.06  |
>> > >
>> > > Perf's scheduler benchmarks also improve with a range of
>> > > poll_limit
>> > > values >= 10 us. Higher limits produce near identical results
>> > > within a
>> > > 3% noise margin. The following tables are `perf bench sched`
>> > > results,
>> > > run times in seconds.
>> > >
>> > > `perf bench sched messaging -l 80000`
>> > > > AWS instance  | SoC       | Before | After  | % Change |
>> > > > c6g.16xl (VM) | Graviton2 | 18.974 | 18.400 | none     |
>> > > > c7g.16xl (VM) | Graviton3 | 13.852 | 13.859 | none     |
>> > > > c6g.metal     | Graviton2 | 17.621 | 16.744 | none     |
>> > > > c7g.metal     | Graviton3 | 13.430 | 13.404 | none     |
>> > >
>> > > `perf bench sched pipe -l 2500000`
>> > > > AWS instance  | SoC       | Before | After  | % Change |
>> > > > c6g.16xl (VM) | Graviton2 | 30.158 | 15.181 | -50%     |
>> > > > c7g.16xl (VM) | Graviton3 | 18.289 | 12.067 | -34%     |
>> > > > c6g.metal     | Graviton2 | 17.609 | 15.170 | -14%     |
>> > > > c7g.metal     | Graviton3 | 14.103 | 12.304 | -13%     |
>> > >
>> > > `perf bench sched seccomp-notify -l 2500000`
>> > > > AWS instance  | SoC       | Before | After  | % Change |
>> > > > c6g.16xl (VM) | Graviton2 | 28.784 | 13.754 | -52%     |
>> > > > c7g.16xl (VM) | Graviton3 | 16.964 | 11.430 | -33%     |
>> > > > c6g.metal     | Graviton2 | 15.717 | 13.536 | -14%     |
>> > > > c7g.metal     | Graviton3 | 13.301 | 11.491 | -14%     |
>> >
>> > Ok, so perf numbers for a busy workload go up.
>> >
>> > What happens for idle state residency on a mostly idle system?
>> >
>> > > Steps to run MLPerf bert inference on Ubuntu 22.04:
>> > >  sudo apt install build-essential python3 python3-pip
>> > >  pip install "pybind11[global]" tensorflow  transformers
>> > >  export TF_ENABLE_ONEDNN_OPTS=1
>> > >  export DNNL_DEFAULT_FPMATH_MODE=BF16
>> > >  git clone https://github.com/mlcommons/inference.git --recursive
>> > >  cd inference
>> > >  git checkout v2.0
>> > >  cd loadgen
>> > >  CFLAGS="-std=c++14" python3 setup.py bdist_wheel
>> > >  pip install dist/*.whl
>> > >  cd ../language/bert
>> > >  make setup
>> > >  python3 run.py --backend=tf --scenario=SingleStream
>> > >
>> > > Suggested-by: Ali Saidi <alisaidi@amazon.com>
>> > > Reviewed-by: Ali Saidi <alisaidi@amazon.com>
>> > > Reviewed-by: Geoff Blake <blakgeof@amazon.com>
>> > > Cc: Brian Silver <silverbr@amazon.com>
>> > > Signed-off-by: Haris Okanovic <harisokn@amazon.com>
>> > > ---
>> > >  drivers/cpuidle/Kconfig.arm           |  13 ++
>> > >  drivers/cpuidle/Makefile              |   1 +
>> > >  drivers/cpuidle/cpuidle-arm-polling.c | 171
>> > > ++++++++++++++++++++++++++
>> > >  3 files changed, 185 insertions(+)
>> > >  create mode 100644 drivers/cpuidle/cpuidle-arm-polling.c
>> > >
>> > > diff --git a/drivers/cpuidle/Kconfig.arm
>> > > b/drivers/cpuidle/Kconfig.arm
>> > > index a1ee475d180d..484666dda38d 100644
>> > > --- a/drivers/cpuidle/Kconfig.arm
>> > > +++ b/drivers/cpuidle/Kconfig.arm
>> > > @@ -14,6 +14,19 @@ config ARM_CPUIDLE
>> > >        initialized by calling the CPU operations init idle hook
>> > >        provided by architecture code.
>> > >
>> > > +config ARM_POLL_CPUIDLE
>> > > +    bool "ARM64 CPU idle Driver with polling"
>> > > +    depends on ARM64
>> > > +    depends on ARM_ARCH_TIMER_EVTSTREAM
>> > > +    select CPU_IDLE_MULTIPLE_DRIVERS
>> > > +    help
>> > > +      Select this to enable a polling cpuidle driver for ARM64:
>> > > +      The first state polls TIF_NEED_RESCHED for best latency on
>> > > short
>> > > +      sleep intervals. The second state falls back to
>> > > arch_cpu_idle() to
>> > > +      wait for interrupt. This is can be helpful in workloads
>> > > that
>> > > +      frequently block/wake at short intervals or VMs where
>> > > wakeup IPIs
>> > > +      are more expensive.
>> >
>> > Why is this a separate driver rather than an optional feature in
>> > the existing
>> > driver?
>> >
>> > The fact that this duplicates a bunch of code indicates to me that
>> > this should
>> > not be a separate driver.
>>
>> Also, the cpuidle-haltpoll driver is meant to do something quite
>> similar.
>> That driver polls adaptively based on the haltpoll governor's tuning
>> of
>> the polling period.
>>
>> However, cpuidle-haltpoll is currently x86 only. Mihai (also from
>> Oracle)
>> posted patches [1] adding support for ARM64.
>>
>> Haris, could you take a look at it and see if it does what you are
>> looking for? The polling path in the linked version also uses
>> smp_cond_load_relaxed() so even the mechanisms for both of these
>> are fairly similar.
>
> Hi Ankur,
>
> I agree, except for that small bug in exit condition, your haltpoll
> changes fundamentally do the same thing:

Yup. Will address that bug and a few other things in the next version.

>> @ int __cpuidle poll_idle(...
>> -            if (!(ret & _TIF_NEED_RESCHED))
>> +            if (ret & _TIF_NEED_RESCHE
>
> I'll follow up with another patch for AWS Graviton when your team is
> finished.
>
> Do you have a rough ETA of when your changes will land in master?

That I guess would be determined by the maintainers, but I should be
able to send it out the coming week.

Thanks
Ankur

>>
>> (I'll be sending out the next version shortly. Happy to Cc you if you
>> would like to try that out.)
>
> Yes, please do!
>
> Thanks,
> Haris Okanovic
>
>>
>> Thanks
>> Ankur
>>
>> [1]
>> https://lore.kernel.org/lkml/1707982910-27680-1-git-send-email-mihai.carabas@oracle.com/
>>
>> >
>> > > +
>> > >  config ARM_PSCI_CPUIDLE
>> > >      bool "PSCI CPU idle Driver"
>> > >      depends on ARM_PSCI_FW
>> > > diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> > > index d103342b7cfc..23c21422792d 100644
>> > > --- a/drivers/cpuidle/Makefile
>> > > +++ b/drivers/cpuidle/Makefile
>> > > @@ -22,6 +22,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=
>> > > cpuidle-ux500.o
>> > >  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>> > >  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>> > >  obj-$(CONFIG_ARM_CPUIDLE)           += cpuidle-arm.o
>> > > +obj-$(CONFIG_ARM_POLL_CPUIDLE)              += cpuidle-arm-
>> > > polling.o
>> > >  obj-$(CONFIG_ARM_PSCI_CPUIDLE)              += cpuidle-psci.o
>> > >  obj-$(CONFIG_ARM_PSCI_CPUIDLE_DOMAIN)       += cpuidle-psci-
>> > > domain.o
>> > >  obj-$(CONFIG_ARM_TEGRA_CPUIDLE)             += cpuidle-tegra.o
>> > > diff --git a/drivers/cpuidle/cpuidle-arm-polling.c
>> > > b/drivers/cpuidle/cpuidle-arm-polling.c
>> > > new file mode 100644
>> > > index 000000000000..bca128568114
>> > > --- /dev/null
>> > > +++ b/drivers/cpuidle/cpuidle-arm-polling.c
>> > > @@ -0,0 +1,171 @@
>> > > +// SPDX-License-Identifier: GPL-2.0
>> > > +/*
>> > > + * ARM64 CPU idle driver using wfe polling
>> > > + *
>> > > + * Copyright 2024 Amazon.com, Inc. or its affiliates. All rights
>> > > reserved.
>> > > + *
>> > > + * Authors:
>> > > + *   Haris Okanovic <harisokn@amazon.com>
>> > > + *   Brian Silver <silverbr@amazon.com>
>> > > + *
>> > > + * Based on cpuidle-arm.c
>> > > + * Copyright (C) 2014 ARM Ltd.
>> > > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > > + */
>> > > +
>> > > +#include <linux/cpu.h>
>> > > +#include <linux/cpu_cooling.h>
>> > > +#include <linux/cpuidle.h>
>> > > +#include <linux/sched/clock.h>
>> > > +
>> > > +#include <asm/cpuidle.h>
>> > > +#include <asm/readex.h>
>> > > +
>> > > +#include "dt_idle_states.h"
>> > > +
>> > > +/* Max duration of the wfe() poll loop in us, before
>> > > transitioning to
>> > > + * arch_cpu_idle()/wfi() sleep.
>> > > + */
>> >
>> > /*
>> >  * Comments should have the leading '/*' on a separate line.
>> >  * See
>> > https://www.kernel.org/doc/html/v6.8/process/coding-style.html#commenting
>> >  */
>> >
>> > > +#define DEFAULT_POLL_LIMIT_US 100
>> > > +static unsigned int poll_limit __read_mostly =
>> > > DEFAULT_POLL_LIMIT_US;
>> > > +
>> > > +/*
>> > > + * arm_idle_wfe_poll - Polls state in wfe loop until reschedule
>> > > is
>> > > + * needed or timeout
>> > > + */
>> > > +static int __cpuidle arm_idle_wfe_poll(struct cpuidle_device
>> > > *dev,
>> > > +                            struct cpuidle_driver *drv, int idx)
>> > > +{
>> > > +    u64 time_start, time_limit;
>> > > +
>> > > +    time_start = local_clock();
>> > > +    dev->poll_time_limit = false;
>> > > +
>> > > +    local_irq_enable();
>> >
>> > Why enable IRQs here? We don't do that in the regular cpuidle-arm
>> > driver, nor
>> > the cpuidle-psci driver, and there's no explanation here or in the
>> > commit message.
>> >
>> > How does this interact with RCU? Is that still watching or are we
>> > in an
>> > extended quiescent state? For PSCI idle states we enter an EQS, and
>> > it seems
>> > like we probably should here...
>> >
>> > > +
>> > > +    if (current_set_polling_and_test())
>> > > +            goto end;
>> > > +
>> > > +    time_limit = cpuidle_poll_time(drv, dev);
>> > > +
>> > > +    do {
>> > > +            // exclusive read arms the monitor for wfe
>> > > +            if (__READ_ONCE_EX(current_thread_info()->flags) &
>> > > _TIF_NEED_RESCHED)
>> > > +                    goto end;
>> > > +
>> > > +            // may exit prematurely, see
>> > > ARM_ARCH_TIMER_EVTSTREAM
>> > > +            wfe();
>> > > +    } while (local_clock() - time_start < time_limit);
>> >
>> > .. and if the EVTSTREAM is disabled, we'll sit in WFE forever
>> > rather than
>> > entering a deeper idle state, which doesn't seem desirable.
>> >
>> > It's worth noting that now that we have WFET, we'll probably want
>> > to disable
>> > the EVTSTREAM by default at some point, at least in some
>> > configurations, since
>> > that'll be able to sit in a WFE state for longer while also
>> > reliably waking up
>> > when required.
>> >
>> > I suspect we want something like an smp_load_acquire_timeout() here
>> > to do the
>> > wait in arch code (allowing us to use WFET), and enabling this
>> > state will
>> > depend on either having WFET or EVTSTREAM.
>> >
>> > > +
>> > > +    dev->poll_time_limit = true;
>> > > +
>> > > +end:
>> > > +    current_clr_polling();
>> > > +    return idx;
>> > > +}
>> > > +
>> > > +/*
>> > > + * arm_idle_wfi - Places cpu in lower power state until
>> > > interrupt,
>> > > + * a fallback to polling
>> > > + */
>> > > +static int __cpuidle arm_idle_wfi(struct cpuidle_device *dev,
>> > > +                            struct cpuidle_driver *drv, int idx)
>> > > +{
>> > > +    if (current_clr_polling_and_test()) {
>> > > +            local_irq_enable();
>> > > +            return idx;
>> > > +    }
>> >
>> > Same as above, why enable IRQs here?
>> >
>> > > +    arch_cpu_idle();
>> > > +    return idx;
>> >
>> > .. and if we need to enable IRQs in the other cases above, why do
>> > we *not*
>> > need to enable them here?
>> >
>> > > +}
>> > > +
>> > > +static struct cpuidle_driver arm_poll_idle_driver __initdata = {
>> > > +    .name = "arm_poll_idle",
>> > > +    .owner = THIS_MODULE,
>> > > +    .states = {
>> > > +            {
>> > > +                    .enter                  = arm_idle_wfe_poll,
>> > > +                    .exit_latency           = 0,
>> > > +                    .target_residency       = 0,
>> > > +                    .exit_latency_ns        = 0,
>> > > +                    .power_usage            = UINT_MAX,
>> > > +                    .flags                  =
>> > > CPUIDLE_FLAG_POLLING,
>> > > +                    .name                   = "WFE",
>> > > +                    .desc                   = "ARM WFE",
>> > > +            },
>> > > +            {
>> > > +                    .enter                  = arm_idle_wfi,
>> > > +                    .exit_latency           =
>> > > DEFAULT_POLL_LIMIT_US,
>> > > +                    .target_residency       =
>> > > DEFAULT_POLL_LIMIT_US,
>> > > +                    .power_usage            = UINT_MAX,
>> > > +                    .name                   = "WFI",
>> > > +                    .desc                   = "ARM WFI",
>> > > +            },
>> > > +    },
>> > > +    .state_count = 2,
>> > > +};
>> >
>> > How does this interact with the existing driver?
>> >
>> > How does DEFAULT_POLL_LIMIT_US compare with PSCI idle states?
>> >
>> > > +
>> > > +/*
>> > > + * arm_poll_init_cpu - Initializes arm cpuidle polling driver
>> > > for one cpu
>> > > + */
>> > > +static int __init arm_poll_init_cpu(int cpu)
>> > > +{
>> > > +    int ret;
>> > > +    struct cpuidle_driver *drv;
>> > > +
>> > > +    drv = kmemdup(&arm_poll_idle_driver, sizeof(*drv),
>> > > GFP_KERNEL);
>> > > +    if (!drv)
>> > > +            return -ENOMEM;
>> > > +
>> > > +    drv->cpumask = (struct cpumask *)cpumask_of(cpu);
>> > > +    drv->states[1].exit_latency = poll_limit;
>> > > +    drv->states[1].target_residency = poll_limit;
>> > > +
>> > > +    ret = cpuidle_register(drv, NULL);
>> > > +    if (ret) {
>> > > +            pr_err("failed to register driver: %d, cpu %d\n",
>> > > ret, cpu);
>> > > +            goto out_kfree_drv;
>> > > +    }
>> > > +
>> > > +    pr_info("registered driver cpu %d\n", cpu);
>> >
>> > This does not need to be printed for each CPU.
>> >
>> > Mark.
>> >
>> > > +
>> > > +    cpuidle_cooling_register(drv);
>> > > +
>> > > +    return 0;
>> > > +
>> > > +out_kfree_drv:
>> > > +    kfree(drv);
>> > > +    return ret;
>> > > +}
>> > > +
>> > > +/*
>> > > + * arm_poll_init - Initializes arm cpuidle polling driver
>> > > + */
>> > > +static int __init arm_poll_init(void)
>> > > +{
>> > > +    int cpu, ret;
>> > > +    struct cpuidle_driver *drv;
>> > > +    struct cpuidle_device *dev;
>> > > +
>> > > +    for_each_possible_cpu(cpu) {
>> > > +            ret = arm_poll_init_cpu(cpu);
>> > > +            if (ret)
>> > > +                    goto out_fail;
>> > > +    }
>> > > +
>> > > +    return 0;
>> > > +
>> > > +out_fail:
>> > > +    pr_info("de-register all");
>> > > +    while (--cpu >= 0) {
>> > > +            dev = per_cpu(cpuidle_devices, cpu);
>> > > +            drv = cpuidle_get_cpu_driver(dev);
>> > > +            cpuidle_unregister(drv);
>> > > +            kfree(drv);
>> > > +    }
>> > > +
>> > > +    return ret;
>> > > +}
>> > > +
>> > > +module_param(poll_limit, uint, 0444);
>> > > +device_initcall(arm_poll_init);
>> > > --
>> > > 2.34.1
>> > >
>> > >
>>
>>
>> --
>> ankur


--
ankur

