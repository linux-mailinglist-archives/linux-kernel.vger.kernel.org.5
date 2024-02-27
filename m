Return-Path: <linux-kernel+bounces-84051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2186A1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497F01F2E2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E314F9E5;
	Tue, 27 Feb 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VdoGQLe4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KxR3lt8i"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BB14F987
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069252; cv=fail; b=JOGs93MzB3IMNEIl+KIYM2Ib9fC6QbnD995uuqZCT7NlHGr2ZJ2f3snSWOvfpS58HYsbNlEh1v4JtM+E7SC+1NWSP0c0nKKl2JeKgNRczjCmJmGaZT74Fv68Ee2X82RilyOPEy0UooIV6YdPBAFL7Itrgek8id97tPC8VaSxVVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069252; c=relaxed/simple;
	bh=n3dHndz0xdv3p7VF6FJU3gmlbWpc+QMqewQ0s/C4p+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dW/P8rXay9/ujjviI3bks1rQfD72eMZRhxUPvcmjAyOp3+HQ/QKfRFjbBjZ8jXnOZBk9YqwahPENJpooMSr4sZidFslgm4O3od7HIwnVbTA7GF1eguZuLn9HhHyFRDf5wc1mMjaqEQB7fNas/85WpKov7Oq7xCeLMSigNum+Gug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VdoGQLe4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KxR3lt8i; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKJOAa003486;
	Tue, 27 Feb 2024 21:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Om3t4NtDhbORwtD+VwzEhzBDkF0w2TgJHa/hQ6O0F/0=;
 b=VdoGQLe4ikvL60jEMeGA0KzveB1qJy6irBtDt9qIViRrUdpsb3ozxPLu6ASo38Vh1/cK
 yxasNHiXAXpeCJQRsg/RTowo0MggXnAm2ecWi/19LdYg62FkWGyKsh7kqbpgGcz6NCbu
 VuDR4Q0RJLMNewP47lGelOJxg9Y+PsUBY5mdZdUsNQCmcNg7U1yOONJoni00R3DKETwZ
 no58xiY0epOKOEFdXiHsJByuHbr+PCimiNjGMoJDOdV3HsDoJ4LU4mg7FOJZkpCQhYxn
 rhQ+lERlVRm5qhg+rfyAz+PwDZAnv8esTq147GBfwsbzHNzRkufpPicVKmkOa+uHNq3c NA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccgghe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:27:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKVIRN022403;
	Tue, 27 Feb 2024 21:27:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w84ka7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjh60mwYte/Gl35ZFABnf8YIQnPbDrLGxvdcHZM13kb7WhmwER55kit8CyDnog0bFgiLHlYwri1NrbIeqrkSQsjNqrxm90Obn8uUsE32X86YgDg3Z9Mz6+cnRi4mSjRvQO4yCWFYAsK1Dr9ojzcFYvTG5H33rTGQ6/B9wSlETeY4pAmJNun0wCOYarB4zZjzJDoa47NTpaozj+NT7Yv7yLxoa45zNG+zviD33zlRayUURsYaAtq1vAl22qa0AgzpT9o2A08/PEaxg3ZDuEZK2S4eSFkbGc3qhqoBmfgzMfKZIGQLVoIlY+LofkNMIu3ODNUAheSy3dNuXgjWUtjP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om3t4NtDhbORwtD+VwzEhzBDkF0w2TgJHa/hQ6O0F/0=;
 b=gqevt93B98FdDkyZCFf6w3YQ2Qfl6MznxCg+lxas0PBmxrkS7FXpFNX1M7ofJMY+6a41YIc7E4TiYTUGtqwD+3zadscBDfJ6fDNYGUP/kFOWtyY9zPm6sFH6Sk7KDOlku1FUw630AaOnI32ckHkChDr91HLZ1QHen2HYijWQ8wRsW6SA2+oWHbYz7DqXpjkokC2pVZpb/XeKsuRI+4PXuEcBDQFCTLUqvrZ1PgWFMFnGI3R8B8e34Rd3Gu4jNsbtGLdYXBWMLsNG4Edhti9RK9QJM+mPkAK6B6xJ29//H7xP4OHS0YhzQfSiCp5WL3deTp1tDTct2fjjBFaoP5m23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om3t4NtDhbORwtD+VwzEhzBDkF0w2TgJHa/hQ6O0F/0=;
 b=KxR3lt8iC29a45IvvtuTI8BLDkAmU+lvts6DjDTLOzjntU2CG7d2Ri+V29g75uckBj6zh8DpyX1TDNkWC2INI828UnRSMqDj5bQiHDYkDxMgeq3mPFfvqIzsQTD9SOG17hLoBT4Tx0od3RAT7Yejhs4I8zxa3h4IhtygqDW1vRc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS7PR10MB7154.namprd10.prod.outlook.com (2603:10b6:8:da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 21:27:00 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec%4]) with mapi id 15.20.7292.036; Tue, 27 Feb 2024
 21:27:00 +0000
Date: Tue, 27 Feb 2024 16:26:57 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jane Chu <jane.chu@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v6 6/8] hugetlb: have CONFIG_HUGETLBFS select
 CONFIG_PADATA
Message-ID: <k4c7ztr5istcahrygczpqmaz5zp2ejiipiziqdi7cmw7vo6h4c@jjtuw4blhyu4>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-7-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140422.393911-7-gang.li@linux.dev>
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS7PR10MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b81d8f9-1c2a-43c8-e978-08dc37dad59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OSo6nl6VHvtqzdulmBVrVjEegDYqTOMYpDAaEQnYf5/2KleRdP72g0nr+h3iKbKb4Qpywb6cjHNQdJ6NcDH7XtIpMkVHbbVj545PCn5qsOBuVouK+r0umYlJ3h22L1ElGyuwshAT2Wic1o8jRB9PbZEPEd7vF1rydJ3cWsUWWSmteLmApjxEk6aSabOXleVjf/QS7gD9vKpXBhHgUe1TCFFLTR+wcjhUa46rhhz1FQ8OkKyaGOVFxJl6wZ8tgJXi4XqaCQi8rgkd639iDq9ag5z+VJpUjvPP+Pjyv/jI1dj1iJsS+kZ80wZ0+s81o+VU1pga8yoCMxcDwXeNEbusl6/UEZJtT6K8NHozKNkg2hFy+D3fTdK+qy9CIqykCWZpsw5z2B3gL+yRFtxEV+XJNYdowt/mn07fr6/ermK9YzT5J9AkCS72AEsrjSjKQZmy8/yY0bX6Kc0xzl0J5YQc/vWUkpzpE87m5WyBHQfdgx44auiM17dy5xEZaVuwN2SCA0dQxF8MHJldNXpeuVwA/9hD+nViClBlEWOv4Kuyte1zZS5dc4pd35MjP1cxsTZONpJunHybRL94lOYiZI+18LC+l8SC/Ize3XNGk0TW37hYTVUxtBnxOkKaQQ+zvJmwAqYpNEt0ROWKUhrs2o1W9g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CKg8+Yw1ILpQt0VzK20ZJllvn2NQaQjafOCzTZ5mf3IGjsxfLOV+fCxpBLAr?=
 =?us-ascii?Q?AHAOwFFK6L7Ayu7qsMGlYY5X/gvyt1suffoi4M/0S5+G7zMglq4e+XqNYXah?=
 =?us-ascii?Q?LnEAV3yjH+Aq9ZPvdnCklGgEiKTd8t7CcgzZtXSgxzKYVI7V8RZ2B33Kj8Bg?=
 =?us-ascii?Q?nbRcRHHjVgM4kWtFAvb9lXC+qDwSGBgwjcu/BzCQadlAZtweyqY0WygOEt8T?=
 =?us-ascii?Q?lc+x+FZT4f1F/a5PwS952W+XfMlNnncJ0VB6aVyyfZEMSeluywYMWK5B+Y4y?=
 =?us-ascii?Q?D0zNJ44GKcG+h+Q/RTZ3vNrg/inftiqIQKTUlFpmtmnFgEO8wszIQE56t6JC?=
 =?us-ascii?Q?less81NrYw3S5ainN0u0PJe0cdSqxYSFnTeuuu3SW/6RlDw0NG/bKcOJ6Jul?=
 =?us-ascii?Q?eJ6JZii/UqYGxdrbf/mNJVecEMzEw0CydHY9S2DbFQiUHz4dS94uOQ4VPvtp?=
 =?us-ascii?Q?a5jRcdTvNaX4S76VwAOhQcA0wo61ZvPBIk5DQrc/L6TPgz6aygZhT57Jfznk?=
 =?us-ascii?Q?FHJegZeWE8PLR/fKuUf7coQwMqdwMGUVniWoCGyyg107ZWvgQKskQItJt9o8?=
 =?us-ascii?Q?ikU6vCkBF3ncCZY1p0ZOvrnA/kDPfw76MKsIax0lFpHefYtWZjo9HrfsY2Kh?=
 =?us-ascii?Q?8YACbJG8OhiFhw98D7hU8CDAAifIyOJxXympqP6sCEvNxaMLb7GCxzvRbD3V?=
 =?us-ascii?Q?NhlrMBFzoD1PBTayldek18gdMzntA0MdH/aH4S9gewwO9xnpNPcoCYxbUFso?=
 =?us-ascii?Q?CkWybqCAMVwyV6nrJeExnPhqMQ79xtmkWiMXioiHBruhRGiEskKwC8hdm2DT?=
 =?us-ascii?Q?SKbaS8aMRHqm/WVWOXy6pIoB+OnpRhOMW5QEVSOkiBQovzYGKBjnsYTd4TQt?=
 =?us-ascii?Q?XQub4yfYVMXShfPYBht26E3WGKXdTuvYldGZ6Z9DgSRUz7l2yknMq/BCTMoV?=
 =?us-ascii?Q?M9H9aP1o+jaISt2q4cgA1pthnkI9/7xK/m5RzE2ISV3028o6CE98ZTsAG7BU?=
 =?us-ascii?Q?xiIVHkWSXmVRQfBQFMSwOmh4WB87Omsk3l1IN9OyylIUBUKaF9RIKYTKSrx3?=
 =?us-ascii?Q?XCrSCg2sYU9naJGbWuDX+8uj33r4YG8h46tflH/fAVocJRXpHGBNaaZsHbBr?=
 =?us-ascii?Q?jdRnSnUQt6Fy+a1KYhpKYHvD+7lyS4xdsqNIZdDoqGugrWFX24R2Pw63+shM?=
 =?us-ascii?Q?b6jPOCwOWN1U2wOvbqSAcU2qi+zWtg7PSk4LZSGtkUVU7RHWcB+Hq3boWe0a?=
 =?us-ascii?Q?otdHSR1sjAzT+HJdU3AI/n+0jT1IbLfhqexsg9lI81DbPFDbRCFT2vOuaSP1?=
 =?us-ascii?Q?ZkHiHsD4OLn+4viJmuSOYlY0z9GKfoa7VVO0BtIlozg9+BiLUwFPejq4sgHI?=
 =?us-ascii?Q?sdhnxvgTikAFTHzqfX/YYlib52r/aKAT5cLx4Ef5nTQmqis/H7XewQ2soJch?=
 =?us-ascii?Q?dCRnib8q6BG72KafcI40WIVwfhdd30v66PXH63lUlaxET1K4TXOIJAGKZUZj?=
 =?us-ascii?Q?Kug5UPi4K4zbT294VK9oX8ZPX0pTWQGkxnUWE6s8P5y2ZGYSdbZzhQuSA7Mn?=
 =?us-ascii?Q?MxPumYXiuuzdqOCDllGqBX/YTW1mf/M8Ykg6PxNA5f2SWMw6RYS9WNoWqHbD?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6q6G4kcClqGeoCUdHAht2IdxjHREdlXpwC2x9tZE//Bpw+fvqPpzxEZs6JixLnZNsZQT+QeYHDL+SQt97HkyfLQJ4mAckXb6tu8IDF2WBN72lY3XX8TjK9W6IdvAPsRHVZcqXXznRBSsLo/8sM67fP2XEoq8SjXGwWALBZvOjIc8HUKRsuCLaqglG7X5jBHkk125mk0NKRXNK7HFE6Pjlnf6y1aZfh2CeXWDMuwbAdNDnTBmn8zOIuWDuLTE0+kjwnF33Ms0B/Ly6CluhWGDkfwhUQnTzLQKx/rWkHNwRuymneYhcXx+dLnPm5F8//hwm4sk7mPkl0x3KWsOuFf/+jDOjVcdTKFHiGWEHaK3/cSvyVjg7aLhJhQ+fxb03HGoLa505Ya+CSZiPgWAojWpbhsjm7hZPJLFznPcEyG8iHMf98pbiWakXzHfhRU4Jh7QYFD5eOXcgXfSMy1MboR9THWuMibneGd31wjvrLVm0cdH7Tzilx6V5JuBPHTgn9tbb5tOndVyF2pp8spq4r8cubJT8sN7DjAxP7DBjP2yvXnU9gHO+/9mbgO9M27/Gu2WscyiaSJZrNg4DyziMMWEm393uU1L0AHFS+3zxUfEwlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b81d8f9-1c2a-43c8-e978-08dc37dad59a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:27:00.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yg8cy7AZ99JAUjfm+dzU6iQDrTPultFqDoINyasH9WRPJ5/0ON9mYhiCQIwNKoumyokMqxCCVAmvuC9OcYkKtTVGUBP+ORusL1bZ+vPxM7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_09,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270164
X-Proofpoint-ORIG-GUID: 8RyXsJt6c1nmsVb-LqdEc8C5D6t53Mwa
X-Proofpoint-GUID: 8RyXsJt6c1nmsVb-LqdEc8C5D6t53Mwa

On Thu, Feb 22, 2024 at 10:04:19PM +0800, Gang Li wrote:
> Allow hugetlb use padata_do_multithreaded for parallel initialization.
> Select CONFIG_PADATA in this case.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

> ---
>  fs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 89fdbefd1075f..c0b9599bf8e3a 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -262,6 +262,7 @@ menuconfig HUGETLBFS
>  	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>  	depends on (SYSFS || SYSCTL)
>  	select MEMFD_CREATE
> +	select PADATA if SMP
>  	help
>  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>  	  ramfs. For architectures that support it, say Y here and read
> -- 
> 2.20.1
> 

