Return-Path: <linux-kernel+bounces-136108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6289D016
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C401F24DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD74EB58;
	Tue,  9 Apr 2024 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I79m4cYA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yeq7tDe2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071A4E1A8;
	Tue,  9 Apr 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627827; cv=fail; b=J5zaiRs17xDYORp7lnGMqeBmBd+Mam8FdRwr+fhxSEyxDj8IgIA88UB5WuAlokyT9O1PjhL52zhApOwuAkZv/J0HQsf+PRWhj3HMqxpFCwTl+tC1A1UGupaEZHkdH+pChRPnSSBQNsRE9lEgSZeKHVZKvkkFeKyYvDLFMbZ12sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627827; c=relaxed/simple;
	bh=+3jTXOitVjcaHyTMbXrw+ZWRdYT/zZBfD2QCQgEatWk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=b7iFQP9eukxoQo6Tywfjc9iozNvLS+Rae61Ob1M4Pbal8v9vG7Fd6YB+sU+VE9fojdKxDjsVMWwSf/yWXLg5Lreh+re7dlr9HyG3t3J7KWAee+ZnVR/p9RKpSIAD8fH/Ms8JxDEb8tOIKVgHGF2l81p+CLREL0zBn4/ZMCLl+LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I79m4cYA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yeq7tDe2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438Lmmwx007701;
	Tue, 9 Apr 2024 01:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=L9q/0X7sCc95KEWDLxN4vs8wWFXXepyy5RzSLK4bio4=;
 b=I79m4cYAspFY39ozviCHhkP3CfL93MXkqyi7Bf1dQsHu2gzzjSuweGdgt+ZvNAZUE8qK
 fSbPgmWsrA20oS472rqiE3t5LP+3JqJkRnTbi1oJ/dXianh4lmhxTNB3UMCELoM6QBnj
 lkB9efpZpYt4+H5f4yySmhBHQphHv5LKkYZyPnCf2K0/Z7L1zBYbEcJgVaNXPriasW6D
 Hp9i0g5WABcP5i/c8E4+xLJyM83nO23mnR7gaOPeyqhAN7XwiK0EvoOC9A5x85nxFhb1
 2kePfENrtnwasYUdWilqur5VVjc75cvhS2RxvAhZXhp5o8G9PB1YCkZH/KkWOmbEhjQz Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0um2xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 01:57:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438MjQFq010526;
	Tue, 9 Apr 2024 01:56:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu680p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 01:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev7a4TJ6dZewMwJ1Mywc5WL8tjIkUWilrEoMcTomD7J8GOMNYdHv8liXqMfrmTfFQIKQDK9SjGja+Iki8Ig4brm0CPVGpwgthPyYyLg2JBPhPGiw9LGRUqDuF/L7vmt7ugJCRRf+OVIqSHTHU8qgjiNAsIU0bBA55fBNmscKw/PnmOIKQiF1iGMZKhyrYD5sWS4ZQocUU0iwk8yolYhO9lWkrW/jrZKgPEV23L+YwobyQ5Lw7sgnfXbxz4owlD52s57ll4GmA6iLfKn6GXA84K3D/xlQ6exQYLmgKwFw/fGkvrUdGnQMV3BDf22u6KvzXiIm6HUweJTlSF8fwuhj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9q/0X7sCc95KEWDLxN4vs8wWFXXepyy5RzSLK4bio4=;
 b=HFuLcdhMyHdYIQnDHEI/PfjqjmNcQONhMQc2YRc0A7+uUcwTlCJQ1Lwy5I8K6q5i/YLA/1CyKT/EDsp7iaeBLTBkfJOFmI4LdrK9bl+5lIoOYUJCGoAWmVCuORTkPXvampSDY85o2VLPMAwN3K4nsR+u1InRJE0OkIMf6MlQmWO+R3XhC7YzOi7FUK++KLIHg2J3pzQf67hQq636pwpGCuwzgF9vgXY/85K8yzYQlwreDGB5UiP6C6FbprepMLfNl75NpG1gBR11JUkXpBOAwjDDGPHzosjfLzFaqVxsIKze17j+W01ODazSBJbqzSdYbffsIdNGhGZC7l9HZPHGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9q/0X7sCc95KEWDLxN4vs8wWFXXepyy5RzSLK4bio4=;
 b=yeq7tDe2z3nIH1KC+xBV06Knv6Sc5dKTVQR+GPAIXF07XPi9n4NDlDs4fhEvmuwdw6h0ULyTmrjnur8HCh1Vc/efHURHy187KOcu4em/T7EAd60eLKaZXxVfL+S17aXLt+mMSjzv1NQW3IkMgBOO9ojZAd8xQfi4Iz6JKOEDd5U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 01:56:57 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:56:57 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: FlashPoint: remove redundant assignment to
 pointer currTar_Info
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240406155029.2593439-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Sat, 6 Apr 2024 16:50:29 +0100")
Organization: Oracle Corporation
Message-ID: <yq1v84rnvs2.fsf@ca-mkp.ca.oracle.com>
References: <20240406155029.2593439-1-colin.i.king@gmail.com>
Date: Mon, 08 Apr 2024 21:56:53 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5711:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yrAifKTg9rnTwc3PEc0KImFSiScTkjcU1//4CrRZn9F01yfd9wReY6hA1JNpZuBTvHSMrXm3IX5vgcbSgbyunkCjIdsSO6dyYCm6uTKgoBNyjavY1+Ni8/7bVVfDNeXTiHhO28Xej/VHVgpj3grAWROnSlJ4wmKqCfFQZwUYX0N41tMmKZFMUVjZOh2knSHumhkQRr7SjIfDw/DVI1xHXookPIOgYr4E4n2jEjZambWCUEIewce8M/jvIrtFqmkfsvXj9jRXrYu8pmkCurj2SigS2pJtKKxp4l2ozi49m2/ktX89gvU56t9/oNWKYJlswYRQ7p8tbWms5VW1g1bttRJtPWveHcai34GvTteJge4f9PICrt5c2Ff2VPeeqg0mCea6sQ27DAg5beurHtvnHJWYBk6oJkycpy7VyRZiilzfTzsypZaWnJCfr2/8meCVUbDMzDlS2fkO9yjCMcDbRGxgYSXh+oSjEhI79PuQz8fCMCZYE+3BXSHkZOE+of6SAm7LjBDCepXvwM9EBv86zVY+hJy9Bh3J4MDs1+91bcK4rsMM1wdroe0y2jRxVXKiPJnq6Oz/yHQkVlNs0B/e7X7AHSDptZ1WYasEolcugCz3PUvU6F6pQiesiN7rIQDJ0Al+2yqkZCjVNNhwd4vwUsOORGwOqMdgOALn4bkR1y8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rPb2dfZJwFwmAjwB/SbtO+Xahwa+eKcoao/ifoE+Y8UMb8QKJsLfZriegWic?=
 =?us-ascii?Q?73n4juGUYIpEs0gEIWFsNkhFnFkZaA7JWZKABvIiXvmjNfANo7Widg6GlqCb?=
 =?us-ascii?Q?MDCfAwc5ipSVwl6iJ2UzoZFHdD+l+EwuBRvyKdM/cOA2ZfvSbUkQKUoJBS15?=
 =?us-ascii?Q?bUNJTmGlfOcobJcqAQSb86pXOaiI+S9avuJ25kMKrGw644CtYppE6Wane2s4?=
 =?us-ascii?Q?CsjOQL/UTv9+ApixaGdaIGyn3U7zzBjgx37cUJc6JpyXJ55Mop46gUOK5YzM?=
 =?us-ascii?Q?VG2RLaVfNgLdteJN3n9QKkB4yqdINmQT6TwuEdDeEL1O2Cb7gKLYfMr9IwPo?=
 =?us-ascii?Q?+1ZPvUU8Rc2k7sdaSSCBWcg9Eit1jehQYgRC61JiKl+UmwnMbmvuUSqbKFGM?=
 =?us-ascii?Q?VSKYtYdYWL6lGbV6w6QK2WT3/yRhhGtyrES6z31DHXrAyx/gVDhWbEj3xZ6C?=
 =?us-ascii?Q?yU6hq2sg7DWU+VV5R9zNpKvW65ZBQ+HIvCj+69Q4aT7t6yVbw8NWP42eH6r5?=
 =?us-ascii?Q?z8Bu7rnPYVagksQ5L8jvBwq2xkaVgn7chgzkIjqFip47rxnWGwBsQH2xathD?=
 =?us-ascii?Q?WBpq1iAGyIMJNJF27sgRU8zKNVrk9wg9ssWSKVjzod9PYuMe44Q2GbfjVHr3?=
 =?us-ascii?Q?F+xWruI7SAWDzXSSOE1xWtf1F1PWXXBEMttGut2v6V4xifcShAhDHDTv1ZCY?=
 =?us-ascii?Q?peIVCNdXOoxvh72ItMIkbaumCvI0mBXnx+WlGaxJ5smTbqarrPGXUwtHI1mz?=
 =?us-ascii?Q?ZSygjCShNk+TiNh7KHTxZmmGtUMpevUkIWcvf0z97e3DU09IzBB/uNdT5Tvj?=
 =?us-ascii?Q?jYJ2rEjglo8c5JWmkyq4P3BqGwReklYevLEb2MEgESOQOerFULFNCTm1/p8M?=
 =?us-ascii?Q?98vKBfwfMvLcVIdqu1FOVuxwQEElp7kZNU+hepTixI2xdc9Z18Zd9VKPwinV?=
 =?us-ascii?Q?U4UiOdLHy3NCv2eY7ULGOlvdxrjWVlzA6ke/l44seUqdBF0KuOi1djTkcLTz?=
 =?us-ascii?Q?2kMAoWyfGknR6LdSMPhYtZGLd96mmcVhhdm8XebiSHgbNskVzeit2SMbHzcw?=
 =?us-ascii?Q?T7bazhJ5SO2SPQ202cJ0A50uie6oy+vioGNBaR9jwqGv4ZFcUSZo16t0hOIp?=
 =?us-ascii?Q?vnRTgGr5BnFujxvbJ9bdlYWFPs8NMKe/qAYjHkfLgM8WkuwtqUpNtKLO83So?=
 =?us-ascii?Q?Gok8F8bemqNhlS0Q8D7HleDcWVHI2q0Wy584QshwfCPkAWlBQpPd1+WRCOoT?=
 =?us-ascii?Q?5erTNQ5neMCB0Xy13ziKYiNs7RfMed6slA7n+/EfNSHHM5KwUqRm2WHvtrh9?=
 =?us-ascii?Q?EkXphIEFaX+fYX6HjflWJxVrF5wOXfo1+ptGMF7IRKuYQX2JpU31wtrAfpbU?=
 =?us-ascii?Q?XTT2NHb/P5tcNtGQm5q0HwtHEsn+CjG17js0L7+t3fwmt5Dr6ZTFSF8QYTHD?=
 =?us-ascii?Q?+/qO4AGgw9z92a1fcStTCcy3UNbvD+NOHT/iJb4YzP0DQDF6d+In3I+9pxX2?=
 =?us-ascii?Q?2IoUWHNH1TEDS00n0ev75uG6Vrl9nA2UlWt4fBnX4j1Kiw6tGcpFauZ9ddhd?=
 =?us-ascii?Q?6ChDNKiGP+27kn+bopz76abNCQWQjqJ1nKeehkJmNhY2Gl+LVJUGWWauMgd6?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NOcCwE3yMWL+KizsKFg7MSjQS488wWW2r+jMtek3f0PL65GjOyIWYeL3kR+XP4MmP71m/+SHpgicvRypPUr1Vp1CuYUcslmiS6hcpS+x8ha8PHpgtGfSJUdS1xeElRXUCBb1UadLxCEr6pbqCbbbL22fVW0fDpuiYUTZhg6JTV1Z0h2gGFDxuievwv5Erwiko6POucauL/nNrnPcJOHrhEyUFVGJ4ZJB8F+20lXgv2Jkx4idMH5JwMHztwwg88hkvbxN5x4EavebhAaF5bSe7WbfAhw1HPkMKanv2ANbFcluJFW6SDouSdfjlhrxlvl12T2z/KepMWNekaP42mjdSJwz+8iSMH1podPPxjYkYSP5H1H6B/2gZ/CzG+nd4WjtXeezr3OEMPmxxxTw5PVsO2JxYWLDenagftD8INTblDcDYGvrHmd/H6CtW3JRp8CL71DRBP+u+kqF4V6Wa379wjygk4fQoA+J/V8AQpqFVwaxCF9jerhuNLb+9SjUJVxXEKfO1ulS2WGo+pzTG1OJDI0DI4bxRRmmB4MaS2Crp70jIpzFvYdwN2tf/OYiZzeq6e3AsysZ7DVlhCCQ7vpQiKrYsnwg7X3qyUbFoXJ1phA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789651a-08de-4ade-6a1e-08dc58385681
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 01:56:57.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c//ioqf3MTwRy6ppyuZ1VfsqI8GQ5KTtC8v8mYNdTRqcrTUh+aLmsPWZAlu9nmBD4wE9QpkuyV32yOsPgnF5UKAXVHvyw+drPm/OYqLnNFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090009
X-Proofpoint-GUID: SjMFgn7tOoITT279chNHxto4VNFzGS1R
X-Proofpoint-ORIG-GUID: SjMFgn7tOoITT279chNHxto4VNFzGS1R


Colin,

> Pointer currTar_Info is being assigned a value that is never read, it
> is being re-assigned a few lines later in the start of a following
> do-while loop. The assignment is redundant and can be removed.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

