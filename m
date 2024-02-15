Return-Path: <linux-kernel+bounces-67641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0A856E65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E833F1F2249F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085213AA4F;
	Thu, 15 Feb 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bke1hc0m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wq03oi7G"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548013474F;
	Thu, 15 Feb 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028080; cv=fail; b=ncBGmfn7Tt2lKVGakoatUHjYbUAu7DWuxTdWW1v7saYGgBaTUVLF86wnX1t/qyoNBZrDMcZf+OiPpO98xbHnt0eKLYw8mMp0ytuJG77G4EVtkyAucgBUDSN7SwjcQRMzvHOOJGd+Uu3toNaouCT6ssHvcWF1ftnj9CBX0Lpus7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028080; c=relaxed/simple;
	bh=fIfUdP8Be55p2zfnlDtWgB1Z4D3TqErMtnMPJNCk8Vc=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=R3AA2ncyXJCxjMlhIjuxE5weWQ7zu2JnHB4yqVRgYlixKbdP8Yhwj4V+xH5T/koRSSht5FmSDCQCZiMx/CAS10zc3SlSmcYwrdnwK8KQo5GjH4RvJgLTyuxLB++kc1GG0hHj2iSrvAk4yI7WvdXQtrJ/gn9ppZvWJ2nUIlixd3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bke1hc0m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wq03oi7G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSsjA030976;
	Thu, 15 Feb 2024 20:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=3zOgTwG78ilgLyySUOmK7CydOT8zgcCVVlFRNGt78/Q=;
 b=bke1hc0mjRMJchm/99RZ1CBUBBP1vgPfqgF+NwrM24uB7Kr/DiHNRPpySYf8eOMP5yh6
 MnTEArYrnGeRlGbnlGlILpDUZUmzxU1Uv/9kaCIQiy02MoW3r3Ylr3p5hs0LaYsdXBEk
 cIxV9EnlZa4qyjiY5E4IQAGwyjkdH6jeLcVv6MnxWbBQOwEK98L3qsJ10uOP2+Hdxc/d
 r6NVlo2KY5dmNZP1Uy/Dkd8dEySVEQDXtdcm/Z99JsPJ0qm2w8Ddy4JMhBhc0h0uvo6C
 /Go0DNrP+gw8l1/OKCI8EjsvZqOQ2eaRIvZA0brrt8tdEl83QZN0nWDCAnrHkgj3k9yY sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301k61u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:14:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FIhJun031555;
	Thu, 15 Feb 2024 20:14:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb2fwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYhSAlqJT03vQVmwLmfS636HvvlrvvwqOtvZuK3meX6CR2IE7cADDTgW9uPtnlYLELXncnh6mXIWqRiKacvNhtFtxY9yyvpowP8a4VJ5bW8ddHZEyjJbzXcQ1MvQlKYHACyKByPH0CbD/y2yBqiopg/O3n2X70YAoadH0MVcJalg1Bh/JJAfxUaZHuxKqa4M2G7i0RV7rEiHVylsKhggZ1LDECepkx4E/iV4WHrK67smW/6Bn3djh0bOdgq1UYJR/V88CEF8gnNuGP0Dwvgtpwn9tfyUumaufTMBJmExjq5SHSpsNAa38XqMLf3yuu9iMQvrqOwgSqM5GDT2/ZF18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zOgTwG78ilgLyySUOmK7CydOT8zgcCVVlFRNGt78/Q=;
 b=UpzsirmyCWzYNSY1O39NyFLorvqE7iinAM2d5Q86fL6PVeGxM4riiWT78EN7HPVJFtx5+u6yrZNazDWyJkn0CMeBOE8lcpGdVw6I7Y6gxocjumBCPf6nCb0LbKfofG+nM+uboua9rJwFy/+P9H5YhPqj71MZj+FFdDbFfLNKdpDxkyuG1RiAvqdAqJrq8MpbZyURNyZhFcng+5t/rF1OsLA49/l1lqypgdqaM0JMSKZ0F6G1gbp65g3+f4rmg3szpWmOLsA2Mhar/YpRp6zxMeVVKN/mGB8fk4qCN2w4dGpvY0dLaYQ4SXl2lssKXoLvOXyb8wl0zienRmJoNXadkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zOgTwG78ilgLyySUOmK7CydOT8zgcCVVlFRNGt78/Q=;
 b=Wq03oi7GGn6aV48qf/8pL6szHJnKgCjMvVJzSdXBcbDRYVpMnAf7leiZgYuwmbGBGat5uQeKuQQ12nANo97VPIMdp52k1uV5/X6CxFyDkRm17btZB9i/bK6dIX5TsUthyLMNkTcFKvUExcFGppQ1I08NP6O6/b/Pe2Lq7ismBKg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 20:14:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 20:14:32 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Michael Reed <mdr@sgi.com>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: qla1280: remove redundant assignment to
 variable mr
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf1teb8f.fsf@ca-mkp.ca.oracle.com>
References: <20240215153533.2067413-1-colin.i.king@gmail.com>
Date: Thu, 15 Feb 2024 15:14:30 -0500
In-Reply-To: <20240215153533.2067413-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Thu, 15 Feb 2024 15:35:33 +0000")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8672938f-a793-4739-9e8f-08dc2e62b8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d1S2uqNj2A9ZAra+gf7ngPRTySpR+4GWTlTKVYAf9jroyOMQzG/NRCGmbqlzxFDmWMVl1EgH2fW1cNvyx4WhKn53NQtLM+yWvCZb0QmMnmkRoigmTcXEN04tIBOcJ1qAGUuU+NwtiFa/kpFcgEukWhiwyts4GVzd6LXhXRN39pHjLGOvA28llNBV3tjTBP8nJ0wqj0WGuzltGBthiYrClHf7iJOYVyhi2jTquubtFxlQaooHwsGxWBTlGqE9Am8i31adfZ7tEh2pW0uglFt5i7PcXONAuB3PP094pHq7itjUOj4R+aRmLO6TWcloTK/ZmRJTyI39NSp/1eqA4oOq0P1+dSHLCb5htaxZVOEJhXFklTyxiC9+ykDGxfGWaqTxNaGxUzuCNTegiwDb/AQMWVMGAqZnfRfVJLiMozHoFlCuHKsr4gRiSm8rzfthJZNYKZAoCuS/BJAjgAxfSnrMd5NMI4zOCcwX3GSUVJc4sRY0Vz5B+HO63dq0N0i7AFdZ7b0YlySW6PzG88+kfg0VaTL0ZQT5erIt5FPWPpil9on50ws/jWEFDEgSKbvvp8bO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(4326008)(478600001)(66946007)(8936002)(41300700001)(6486002)(8676002)(6506007)(66476007)(5660300002)(6512007)(6916009)(26005)(66556008)(316002)(36916002)(86362001)(558084003)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CxFbKKKUbaf0da8+cIzUEVb5muFsyek8s0mpuZpxs7X8COK8UeE4jJ9oFhxZ?=
 =?us-ascii?Q?diF0fGm/OadZ1jYi+3hhJak4J0MSflG69lUjqFZxwcczNKBo+DBFhBcoMMKc?=
 =?us-ascii?Q?2+yzSMfUfU8WL12G5VbuNuOcDdS0O2DiLuoiqTbC7ovMS7DdSknRq2V/2zJ2?=
 =?us-ascii?Q?lp18Aso43gBPkokD76ZZ884Wf5sHl9OpJ9DIWQKgG459qtL07F+rpDePR5he?=
 =?us-ascii?Q?cAZER+yguipNTpAjT2snE0bGyGom4+UOf3eHn0RGPLOb0gkQZZsNBUJNIEBK?=
 =?us-ascii?Q?bEvGZ3iBNsFuhLkruWiyAGU54ywfuroPi5hLg/lyHQVjhzpeRUFAVq2odFkQ?=
 =?us-ascii?Q?RlLIIiKrJm47GDAVEIhzENAEwpELaMB9hcjZ7wVBo30XJxotG5E8veqMDGYj?=
 =?us-ascii?Q?DibjiAMzQRrO1gI1wkcYVfHrjymr8gEm+bEGo8eX/D7jv2/6g6iA5INWGmsT?=
 =?us-ascii?Q?SKvgNzyfDP/X8BiqyimyNUxwTQrl12iZzB9MbQBvPHGN0q4HQkAenUaVLY7j?=
 =?us-ascii?Q?BUM6+akWZTnO9nhILpJpxoRLBxhoITE6J24Gg8jXNagl/SvvpY+x04lOjD53?=
 =?us-ascii?Q?C6jn9XpBU+ygM/dJA3rl0NY1PZRJJAQ00wul7ebxfart//K1qLSAWKSBjRxv?=
 =?us-ascii?Q?c4R9b0xJH6+D3xBUVVzE1Y37jRLvOq/PXDLys+UDBh5FbUIa1pJHCmgX0ikR?=
 =?us-ascii?Q?2VE+lhx6EKjdKx0szjif3f4l4Bpf+F986nrXJjR4wxUDIgyYZuVfRpT7bwVL?=
 =?us-ascii?Q?Aph3qLiMK0tJmTPKYjAF2PSNZNqX46n8PUayo6jIP3w1ORxk0SCSUmnQ2XJS?=
 =?us-ascii?Q?gG50feAKZ4jt2oKI/FtcAZ1UKcPrm0wksM6NRN4A9Mp0d0ZukvvI+SHR5tz4?=
 =?us-ascii?Q?2WSeTLCWZvSf0jBmN2rGXBxutsmcPB3qADNQKlq1QwW92jHmNpb/GxIujoYp?=
 =?us-ascii?Q?5TlczUs9QVJ5mX+JnBTQ5Yf45QndeP3e8hCQoREMdBBkeEIBgX/e/P4lKJOW?=
 =?us-ascii?Q?i1wGi/i01LullrDdzWOm7fqM+f5eUs2C7S+BBxPlzXJf6ZWUoQkpjmABoQaS?=
 =?us-ascii?Q?JCwxhhb+is9qL7R/hJOy4FyN5SBK61ahgVacw0WaPsRI3CvZCMAgr3tkdE7O?=
 =?us-ascii?Q?gQgrmG8A3MaHCsHMS3HJ0zmduhjrJaaTjZaxO9Fh2a/GzR4TuX6kgX6xLT5T?=
 =?us-ascii?Q?AXLbyG+n1ZEEFwe07RbMKV+NKfzpoAo7NUrRtEyTrRsqzZyCwrr/bESAD7Ke?=
 =?us-ascii?Q?5Y2CBVWWoKPWe6fm2uYr3hX8yC5vO12RRSmfy91Z7uSlO72UDNI7tuUXADVy?=
 =?us-ascii?Q?CHjL35sVvS0M2pJtPJGl1PlwNIX4afDKYPNEdtxuvL0r5stcw3OxSX3asQOG?=
 =?us-ascii?Q?bSHaIFYmohYFSGLSjKoacIJEhdbtTgMvK7PtWXaCz04fhYosIwr2Ue103oy+?=
 =?us-ascii?Q?txWHPYnYxRHW5SmWid9skw4DmJfHoVSgjQaKtZA1v+6pDwVkNECLfUvyzGDj?=
 =?us-ascii?Q?lEsBJExtM7PFiXizAAtFvrMi6ARAM5iKFcszxPV7y0TYJVJXkU+Mgk/f6CUi?=
 =?us-ascii?Q?wq/lh/03H8PbwKRMxFaY29pgZ9f4eq3gjkIIEZvsNGL9+TnAwj+Jh3v4wzx9?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rf0dbXPSuNaV+Gn1hVHF9vvL6ickmRCtdEnnuGvRDEpFPMsiTnto7xCxGPB/7ilzEA0x+fz/K5bAlIod94UKN6YZBc5ZnMCBuYMgnjIFQzfRpkiYPaIFmBDw+4Q4tOPTk1Ch08VKvGdraMgKAKjejdXlwZRRZKME1b1Ky58sOTUBtXSN8HSHsHHFhaG1n+6PwOkxahd4sATuk8wGvjDqvKH4zjRHyeEUrLPborHJxAnroL5x3jXILFneNZmq109lhFUTm7IKc8vFPHmo6rK7DSkcK9pVzJShv3YjO/dH9G65DPickZHy+XqcRSSKhfpnON1wAjAB5lpb3SQ4fDa/xeBsKUjynevO6aPPmH1hMQ+t8DTXz46YgBv0c+ris4sfXDicc+DKUSoAUbxqE5OcY4oDhIJpVGKGrnomwAZhcIVsSM0BmcwfTsRh4krTTw3zf6cAZkyvp2XoGCRD4UHHCvy+0mWTxFhwdFa7Tgvk5ZkrrD7rrzW2w0Q33e+jk+E4K0q/e2rNaxnJZXZD8Z+LLD7RVXfhjLiZBKQvKZ5B0PHa/07WH1B/SthTUxVYc/9Kt3EXhd1KJvQJPMQy6zKGbVIPkt4ckuJs2LRyBbXIqzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8672938f-a793-4739-9e8f-08dc2e62b8b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:14:32.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3JNqiltUDblXJXtLdAhrsoGLsrregeLRZ5CXwH0m7Kk261Fn6GviAdeelAe8OvXEnXUggFcR9jUb6NcpfT1VViCc7nZKGpA9p5rvW40p48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150163
X-Proofpoint-GUID: CdBpNEcL81EEryconFm4yHqumiFPi04t
X-Proofpoint-ORIG-GUID: CdBpNEcL81EEryconFm4yHqumiFPi04t


Colin,

> The variable mr being assigned a value that is never read, the assignment
> is redundant and can be removed.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

