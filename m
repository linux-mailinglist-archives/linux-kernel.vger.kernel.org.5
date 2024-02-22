Return-Path: <linux-kernel+bounces-77259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943068602A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68501C23177
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C577514B82B;
	Thu, 22 Feb 2024 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZBo44i4/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I5N0qaue"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6E14B823;
	Thu, 22 Feb 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630085; cv=fail; b=AUs4aLBEtDSWp1ipX3kyqP/Owx4grCgHVye6K2r37WhUEGv7hB+OQxc/eSZYoacGppH81armAvv97iS2OwK0pv4/+WPmD2C2h29hrIlJol4OjFUZIc3L65Q4JXyOzLVw9nJzGpxJhLlVL2GhdgI6mjeGhI3c9T/5BmVDnDW03Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630085; c=relaxed/simple;
	bh=wEiyNtkmC5JletE39x/MG+ob1cpa/2qJdyQFEesIAnM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUpm+/HY5vHNkXiP27Mev/kAnNtgUGi8GDh67o0XSB1PygK9LcNlxw3sOuCBox+X+tKUQ1qX4wpq9ulVlOmD1USG80rAN8TJfZ0gqlD1Ju6c18p73FMBqxSt+iFSVHMYkmMH0cIlW8R5DuFaKs/bBAvWawsgdVcG+6xeA9I99Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZBo44i4/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I5N0qaue; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQWjF013954;
	Thu, 22 Feb 2024 19:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=tUNP5ZWCVQ2z/kUoWZ19rdaLgDa+h2UjArt+jNXjum4=;
 b=ZBo44i4/Jjipn8Qh7z+DZmZHQC9CuRZLek/NHWVQRNSQhq5898u7Ip47sTpxK9Nxq8tX
 uJ66VqxhaeZsr4iYAzcacLU9B+bCJfSQ40HrAL+lFEu+k3v1rqe9PhMRtAGjnXODKwuk
 eU6nZIdliZXKW6H7ihQXblGFvl8EMicyEdlzkVnpEB1an4caXQ7NnqY9MX94+JWVYbYa
 ovvvF+zs6sHcl5X+YLnDu8kfGb7JwCL8UercePfj3B1f21mBfnjSS5WK6613kkOpUgxl
 M2OjHl50lv+nAUVozFajAvXf6FszJUtnC9DUN9IB/slTurQABngiUwH5VWOjSOZZxnjg Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw5cnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:27:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MJMMhq037722;
	Thu, 22 Feb 2024 19:27:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b4bvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJOHrHPs6o9k4RvzRnzpan+wO6i5ci9sUi13Hi1p4sdnaJlXs+McKcboeAnn7S5zt9gdGaV3KJMMnWzv8L2yDIjGDZj7WscBvuwTp4RA1854/SR2UZSFrhuSbOp2ZF2QHnARiSQowSfJEgr+/2h53XAcWgKtcoK+wMjo7RtK/hScYHSUHKW+IWQTIVeyBQcbvU5KGx5OlDElSjYIKrN5nsOaC6SNdo/HmCGBuXMNVpKzUMnUacv4QwB1HvBagIwY+PmMF0weHSfyFYo5leUfs5rAgMc321HwpYhvXnKYf+1a+EJK5C2WtDXhDGL5IgxnljMFrnQSxTBjtYiJQYNKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUNP5ZWCVQ2z/kUoWZ19rdaLgDa+h2UjArt+jNXjum4=;
 b=HqHaMbCUfP5nu7cShAa9wjJK9/0kyV2A05nS3mncuvcjDJL4QSs2LszJJudsxZISDJFs4Xt1l6mdYcgnlD3ds4ClmRKTW6a52HeNlq9JEpL+xtbE51l0sAjnvouTE9J2ypco51jjIai5ZS8RlIax8yoV+HW89fSXn2e+i5DsiLHF5FUXEO5SgAsAdEv4uQekh4eKQPsVdnQ/p/HoiLtzz0dlDfiT4ah+sx4PY5Zd/Sshz9gTS+3bCcRHHBi8TwoSTQiAOFHF2WEyJ8etBuXmnBF3RKIfZm761oD6bOH5UKlfiqq35Bn6FdwSZcaZR5241AkY+q+PzKHVTLBl/a/3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUNP5ZWCVQ2z/kUoWZ19rdaLgDa+h2UjArt+jNXjum4=;
 b=I5N0qaueAvbcaZZmW+yTYFxHiNqEcEn3bRzB7IuUZb4zd3GYFPA4EQokulWiby3FuTtbUeybgoj+ytBYB+wPpEtfSRX5KKDeOY69UU1BY5c7JHToK57VqYwk1qBv6xuzJubEbcMzcPjOEhD0eOicfxRgSmDvT8z/j0YBPF9JDmE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 19:27:49 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 19:27:48 +0000
Date: Thu, 22 Feb 2024 14:27:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Message-ID: <20240222192746.cb65qvtmhaikfeko@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
References: <20240222165549.32753-2-vbabka@suse.cz>
 <20240222185642.rmnp76oquu5wfo6c@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222185642.rmnp76oquu5wfo6c@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f51f54e-4fd1-40e2-cff8-08dc33dc5ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	//0VRgmNCfHU5RXhWex3s9g9fK3Q3icdGLostXFtD9WCuJUVgDQkH7kIzp5GXJ+uZx4ufHEZkwDUvXb9LrjDDYnbDq7E2K1WL2rKmSTiuZX3YbcMIyNtf08kE0kH5wuUCAT+WWe6nFR83RQa9pIIWPc3L80q7KgBaiYZwYff12F7w3kaAPopJrJd2fibrF5N7p2NkVo7f3CE237Dtgter9AYu4z8DIpcklo9Hu3oMW0cGPmZYLQKPpx/5MDRChHpXPdbWvgQ3r/zYys2sowAJrnN5DrpDxsx+a1tJkZMv2FaO46Lz+jFmeDBJh5K2JaJcr9iIyQ8E8pp7cWQRTx7QoRv29eSqQX0rjZtapVpcw2WjnTo/N9Wywyc3viCa4ApCG/HRRhgKtml8wr8zmLBkSN0VBwlpEcT4VJxx7ghQmC3kURPsoimFv4T+/ivLKjMohJdV5wZX6bj8eIL1Gsn3aZKkOSA0idLFPDowCRfwxt2A7oM3As7yR8bYgilF0gUZ5/KFRyUmj7iF4WGFq2gKTYC5zJtNKFULpE/PnAEw3s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hf2z2kN6BQdeXPtC6RCo91WHlNpYZmxshQvya/EP8kwrK70l/verJ77JbHa1?=
 =?us-ascii?Q?JVujtDjWcKA7d5++/mg4Qlz3uJnaou+JQQvsQ76aphoMgs2tlfRg3RrbY5sG?=
 =?us-ascii?Q?vv9Ax+WMwLELJJHBGkdf+Gddkb7j3efQ59LnqBBLdRS/UtQXGetfh5+ykIhJ?=
 =?us-ascii?Q?xS51woa6UT0f1it+Ryj/DmPZ9H65ygxGVeQz9f7hzR7srCqq73cygiGefEbn?=
 =?us-ascii?Q?formrdAnBJHS51PLqkc5oqsyyzAh/fVpoFi0Tfn1C+3XzA9JgKO8CkRSzNSH?=
 =?us-ascii?Q?ZdFqFIJ/RrUWwFQoMhYSUhKsJjvJeRoTtjQ6Nou/uIC2AaF1w8yT1+D0/djm?=
 =?us-ascii?Q?H67C/0ylfKns0bh4xM2tTnWPRN7EZjpmwOMDXvXXJsBjtV5OBx9wRp2FE6D7?=
 =?us-ascii?Q?cSH+DVnHEvM7VbxVsrI692h3Uo1J6/lMsLTOTc1pJLJK1Ay08J/q1amoY1n5?=
 =?us-ascii?Q?AAIPDiWxw5/u9L2zJa8OBsI+yYCEeN8o2CSp4OO/BmEveLp5KMn88PdtFBMQ?=
 =?us-ascii?Q?S3nxT4BZcJKVjR65mEWy2ODXjQ3r7NtQx++B3sQENAfSkFJWgqJ0s+lqP7Vi?=
 =?us-ascii?Q?LYnY7xxPo2S+tw8Jps3kjCFlOGci+AJrQ3b82HipFfNuoqe8MRb+fO5aprKd?=
 =?us-ascii?Q?MI9rwLUgls4togTCaeN9/LPIDurjnYbBsyAdXsTRf8y1cuEcTe0i9Dznve/n?=
 =?us-ascii?Q?uRMuVWWXfHp6khLpbqT0FtWMOK52MyfDXB0DZkGG+kW1DEkFPesCyel+GnX/?=
 =?us-ascii?Q?oCTRYyCFcljwc0Owxc1OLBWpCFSm2c0jaomztUD0qXv/giv4gKMpIrLA8EAo?=
 =?us-ascii?Q?9IYBoDOn7YQatNSm9ZjR5o0nFLuAcMnlYn6TQiX3/robcvguYsCCMAgudTL1?=
 =?us-ascii?Q?HeM09Mt8/WA18aJd3L49rOhNzDi0guy1SJR9A/SScB6gC0K2gG3HAFzv0M9m?=
 =?us-ascii?Q?cmFZocF1WIcpOJ3jE48soEevDdPQZuIl2ZTGynADIjU/mV2vLkwWj84XSyUU?=
 =?us-ascii?Q?Ysh0Wpuzq8+VkJVoxn+nLqPwkq1a9pxq1F7XlEiHJwYrF3X/kLxhPp3KltAu?=
 =?us-ascii?Q?3ox5foJe9izGCUPW30KjdSIow9juhIEIJdz9Wh1X6cYbIWpSdom5hFIDQpA/?=
 =?us-ascii?Q?Cmch97ik/iviJ5VPDbk4MLoIxgdGuUylrZ3GZrSJXMSw7pgT7hfOxYypuCNI?=
 =?us-ascii?Q?9onVNSzHJt/duWXQnvYYmt082z19iPrxFNKN1lP0RquPZgpXAP43sfQN/jdP?=
 =?us-ascii?Q?ITV/UNfVmAguHlWGO+hX7n4+aF3uGiANJ+oEbPnRsxNb8XSNdjm0yn6rw6t+?=
 =?us-ascii?Q?4+U4ePwCBXotIH2+WEj7j6ZkgqdOzUpEThjGqwryu080Jw/zvU196CTAsRZG?=
 =?us-ascii?Q?JuMoRAZtWcB1tyxY20a2fdh1+mHRL+geAspUuEEBWP61CVsa0QeiA29FaYlR?=
 =?us-ascii?Q?yiN8QlN3KKSAmPLhSw5iHuycXcK+4HoY2ta/QAmyTGqjdPtWUobgcQo3oaMe?=
 =?us-ascii?Q?O/73IuYHgvye8Wp9BqWMmYVjXOqknjIdKHf11gBIHazOh29a1g+XYIIuVhp7?=
 =?us-ascii?Q?vt1h6hnmprXIAQhmomO2uurwCwsvxFVmDeTIwyzJxINjmVE5LUwPci6KOHl7?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R82EFkpcpcIa2LFxbzuamxd+DY7wZwj3g/IHQ9VX/u5MXP0Op89x0mQ4+6vNGcvTQEtLtC0ZQRaWzcp8iErP997PcBwzgg4cN6WaC+w3YAJ7Ps+u3SN2R6L21SQH9JLBB0BIWdB2b/qhKkRqzPNs7ABSCqn9aAagIY5KYT87V0feufrhtmaTcOgXHnu1iLpsms2yfRiamFdWWWEu2RSuzXikDNJw5/0RdxSqPhQShVHOcU3nm9YRGvNGSj8fikxcdIThAxQum3MDQr7BZYWJ57xc2nyjBpS1rOaez3w4XMY2Tsz+bvGk0OeNy/4a1UhUo4ePsi4X9qNbCLbFKfm6y2JUei0mOpLvTQxlazSTUXhadbYNKearAgSM8w0cPoGtJcTrkWTQG7FHo/NF208lbMjcyMLsQMUXCk7k3SkGyI1BHjrqxeVV414ej4rOnP1+iZc8DWEHgnqb/icwuak1IYnAs/8Z7wlKKmdg1FycoWO+yqMyJaiT2EiFO/5VPIWh/UAFKtkSdy72jRcENAV+YKmKKQ1kpl3bHDrikgjdrbKTjCDbgqQJsoLDl0vAWcA8zvRfAB6vvLtgesP8ICDP5d30AmD+fhUW5qy9wQyolJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f51f54e-4fd1-40e2-cff8-08dc33dc5ab7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:27:48.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhnsMJM2qPpmxEDLuAXdG+DtsWXLhGXexU63aSJuaYjq9JWDypxg9Eu3eI0iOCRbOg3MmCg8hj3fx01Uft+9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=834
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402220152
X-Proofpoint-GUID: UFWIyIylH3Mf4agbYpfDIB3WWcUP8zo8
X-Proofpoint-ORIG-GUID: UFWIyIylH3Mf4agbYpfDIB3WWcUP8zo8

* Liam R. Howlett <Liam.Howlett@Oracle.com> [240222 13:56]:
> * Vlastimil Babka <vbabka@suse.cz> [240222 11:56]:
> > When debugging issues with a workload using SysV shmem, Michal Hocko has
> > come up with a reproducer that shows how a series of mprotect()
> > operations can result in an elevated shm_nattch and thus leak of the
> > resource.
> > 
> > The problem is caused by wrong assumptions in vma_merge() commit
> > 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
> > mergeability test"). The shmem vmas have a vma_ops->close callback
> > that decrements shm_nattch, and we remove the vma without calling it.
> > 
> > vma_merge() has thus historically avoided merging vma's with
> > vma_ops->close and commit 714965ca8252 was supposed to keep it that way.
> > It relaxed the checks for vma_ops->close in can_vma_merge_after()
> > assuming that it is never called on a vma that would be a candidate for
> > removal. However, the vma_merge() code does also use the result of this
> > check in the decision to remove a different vma in the merge case 7.
> > 
> > A robust solution would be to refactor vma_merge() code in a way that
> > the vma_ops->close check is only done for vma's that are actually going
> > to be removed, and not as part of the preliminary checks. That would
> > both solve the existing bug, and also allow additional merges that the
> > checks currently prevent unnecessarily in some cases.
> > 
> > However to fix the existing bug first with a minimized risk, and for
> > easier stable backports, this patch only adds a vma_ops->close check to
> > the buggy case 7 specifically. All other cases of vma removal are
> > covered by the can_vma_merge_before() check that includes the test for
> > vma_ops->close.
> > 
> > The reproducer code, adapted from Michal Hocko's code:
> > 
> > int main(int argc, char *argv[]) {
> >   int segment_id;
> >   size_t segment_size = 20 * PAGE_SIZE;
> >   char * sh_mem;
> >   struct shmid_ds shmid_ds;
> > 
> >   key_t key = 0x1234;
> >   segment_id = shmget(key, segment_size,
> >                       IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
> >   sh_mem = (char *)shmat(segment_id, NULL, 0);
> > 
> >   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);
> > 
> >   mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
> > 
> >   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
> > 
> >   shmdt(sh_mem);
> > 
> >   shmctl(segment_id, IPC_STAT, &shmid_ds);
> >   printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);
> > 
> >   if (shmctl(segment_id, IPC_RMID, 0))
> >           printf("IPCRM failed %d\n", errno);
> >   return (shmid_ds.shm_nattch) ? 1 : 0;
> > }
> > 
> > Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in mergeability test")
> > Reported-by: Michal Hocko <mhocko@suse.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/mmap.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d89770eaab6b..a4238373ee9b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -954,10 +954,19 @@ static struct vm_area_struct
> >  	} else if (merge_prev) {			/* case 2 */
> >  		if (curr) {
> >  			vma_start_write(curr);
> > -			err = dup_anon_vma(prev, curr, &anon_dup);
> >  			if (end == curr->vm_end) {	/* case 7 */
> > +				/*
> > +				 * can_vma_merge_after() assumed we would not be
> > +				 * removing prev vma, so it skipped the check
> > +				 * for vm_ops->close, but we are removing curr
> > +				 */
> > +				if (curr->vm_ops && curr->vm_ops->close)
> > +					err = -EINVAL;
> > +				else
> > +					err = dup_anon_vma(prev, curr, &anon_dup);
> >  				remove = curr;
> 
> This separates the check for potentially merging previous to a later
> failure case.  Would it be better to check:
> 	if (curr && curr->vm_ops && curr->vm_ops->close)
> 
> and not set merge_prev = true, ie we cannot merge with the predecessor?
> 
> That way we would exit as merge_prev == false.
> 
> We would have the added benefit of not having to look at merge_prev &
> merge_next case with this vm_ops->close in mind (case 1 and 6).. because
> I'm pretty sure we can currently get to case 6 in this way:
> 
> merge_prev = true
> check for merge_next.. can_vma_merge_before(next...);
> is_mergeable_vma(next.... , true);
> if (true && next->vm_ops && next->vm_ops->close) /* Fine for next.. */
> 
> Remove curr by case 6 without checking curr->vm_ops &&
> curr->vm_ops->close
> 
> If I am correct, then are we blaming the right commit?

I am not correct.
The file check will ensure the same ops, so the file and ops must match.
As long as both are checked on one VMA then it will work as required.

> 
> Perhaps we should just fail earlier when we find a curr with the close
> ops?

I'd rather fail earlier, but it's not a big deal.

> 
> >  			} else {			/* case 5 */
> > +				err = dup_anon_vma(prev, curr, &anon_dup);
> >  				adjust = curr;
> >  				adj_start = (end - curr->vm_start);
> >  			}
> > -- 
> > 2.43.1
> > 

