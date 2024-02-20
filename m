Return-Path: <linux-kernel+bounces-73517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E105585C3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961A42862FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7712AAEC;
	Tue, 20 Feb 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AI4Pv5j/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0pUr2Mk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954F127B5B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454024; cv=fail; b=lGzMQeln/+wND+gl1IOKDp9sh2dSZEo/hpR5NRr6oQdtOM0EJnV5XFxp9gb21EoM1qkVauShtaHpR0Odq+Cl0DE28dYycyGPB1follMp9oOo7pGJXPygJORv3XtFKzBFcwO+EjD02vnslXtUw3K+VJ7OI8Mtbnk8CXYzy5A16+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454024; c=relaxed/simple;
	bh=dXaNBXjAp+8scM6sggtcglVaS4h2V6nhSxUkPJ6Dg34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f5vJ6z6sBcUhh4cb0crIHwkZoZNzwgXAgYxxUGn1TH2oHtbgCY1gUQFQKNPJzpZbz6cqkCq9xvCRaY4pFYVQyTUD+acBeMqIpjF9vUrsdt+RVtGrn+09ct/hxqkXthO6+eOHfiopurKJd9DrOD40hES4gjaGgNpMMKfPSwbA7uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AI4Pv5j/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0pUr2Mk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe4OG015895;
	Tue, 20 Feb 2024 18:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oKccIRrR+X6ssuIP0viSme3eI5xXyassBiojHUK0dx0=;
 b=AI4Pv5j/obuuW/MOuL4XSLfuhfa6ruCA5e04HjW1y+A96ep9vnWBwXaOtXDOFQVkzcOO
 bFifc/lCZDRti/V0o+4ivYWdKYntKR8vkfx3u9MopshAE0LPo2pJkpey8K++SVm+MV35
 btD0h7FRalxmwRT3WVYXubtg0j1vzYrMFNU8iaad5X4A3ozwxHsZe5CxcRx0E0NIrMH/
 AegBpSruvtI1ZobP+c+Hftrl0HtBPcL15It1pavbYyFCSatIxf2A+OOiuQjUnDUSzB/R
 8MiTQC4UjRqJrOvRkHQWbFfGVmbyZuQ6A6OXrYFZFZo4UvIYzTPTkDm6E/fvlTSoz+xd rQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7efhfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:33:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KHTjcB013026;
	Tue, 20 Feb 2024 18:33:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87pv57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:33:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3UoHzE05U8aqznKLWeLEoNiJ9Atpn1F37ZwaOfE4RitP3npxAjf+1FcTfxyXaVzmmFQWlsqr2B3zveQpbrpbdaplDwMgCfQLsP7A2o264gKn3Km512cxE6YMvNyVvwkADWnXPXYsuBuANSsOys0kbKQRXt5xw4LZti2SCvJIxV6gDcopWhdqfwgCRzM1E+H85HzZMY1fquMprKxeYe9tGUEXwZmvZB5YL46hwCn5I9Z9xRUDM4mGLBl6EhA8o5X0IyUPEaSCeqxZact3rX+kwts7pRAoQfHr14Y5cW21DdioXriEMX2AX0/9VnlWv4UhZY/gHGE8kidQf/VqBOsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKccIRrR+X6ssuIP0viSme3eI5xXyassBiojHUK0dx0=;
 b=K6RFAZCkQ8hqnJGbkENBKpsNkjCy1LT7z4wA4s5FaMZLKbvQ8N8t6igqYMMQ9x6lwptqrUXOPtTsuOyc7gAA2pzcErdI3hQb70MAH2lPXClruhSizfJ9WD8LWuLHz5B+7NKjlkn+FlR/JXsjGKjtZtJoTZgZcjT4qU9T6OGlj57O1tnVOAuoO4yNsm2YLD3+u6gm9AX+vamxpSeS8kaq60gJxAGAUnIbme+/VYvEZwSd4HRBewIurglszOiOUNPjYMOquKyAI1qNJuLxHZ56vSDbx1xHxPADSatpMxO4/quHrvBtQ0aHV5Jbq2mWdqa/Hn4yqp7VaEm3oOJj/bn5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKccIRrR+X6ssuIP0viSme3eI5xXyassBiojHUK0dx0=;
 b=V0pUr2MkPcyXXUV5Ft44DIM6r+Gkgh6Sg5QvKSTF0XXW1sLVlsPxD63EOuHYsknyWCi+PFirneHqeNwXg2SUNitueUBgpQHc36jP3s02t4Ezlhsos2MfWnC89IuE8VWVM9R5bEAghUfOHysxP4CJjgN8Z4euzeQmQ5XXhzylZSI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 18:33:11 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:33:11 +0000
Date: Tue, 20 Feb 2024 13:33:09 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] MAINTAINERS: add memory mapping entry with reviewers
Message-ID: <20240220183309.al3vj2y37eafvbqh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
References: <20240220064410.4639-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220064410.4639-1-lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e82f288-f87b-4556-8ee2-08dc32426423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/QzMsHDG75zhTDR5aTjuEl8RDyoUAqGxYqXCBTb/eHij9Qo0XFd7gbUKSAeaOTRxPpPdkZLauyWiYRr8ckFOu7aw9UNKxjoJ4pXpNfoutmXLp0xLZ/OQh1G+4HO9XVePa37HI/Rm1E8WhMMDtqonhdQDfqWEff3CRFRqtH7w0V2pFFEa3CB48L2D3vw/PuhKR5/Be2XhZ+VU2O7skteYEeMv/FtNhy140MEcD2oMxbtVQR09+reNSzEE9Y7Ppo5Ql26b+TXWZ6AaqzP22WZE2vTifDpV/Ti2iD2wj4CLRmHmxdGxUBouU2TxIS2jSbdICY/cl9V4sjdi8wV5qn3PdHkhOyg1PRyGsBtK2k4opgUHcNxn9I0ceRhN8v5VG2ECTXitpfs969SKbMCwbyY7VmKY8fiv9xQTpH0AcWZpEjaRvdy6oehb/Bs+OUfrD9pYXd3cptR5KrHKinaMQ69JK4vzm9/8/A2AkXTvTAeia4LO6Q7hXmntmnYxAJ7dh2EU8Ob8lfz+gwJ9Mjxwpx1jtQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wtCPP01ktEsbDguf6sO3bH3mzLni9wJKETc7pV13GHR+3IBRh4/6FkrDXbGw?=
 =?us-ascii?Q?dwFkk69rf7faYyszVybq2Frek+jyRnZhon1lQO0PleFiX7IoQ2Hsc328g0dD?=
 =?us-ascii?Q?sqWM/Dx9j9RRHUHv8J7fMVuS/rMfXCE/A36skUe1868zLg/tHwyu5jP678s6?=
 =?us-ascii?Q?O+g6TYf7F/YLDLOYlS15SLbU5hqOudMVTIARDAFiqWI4j7FF9KwnvjAqbjZd?=
 =?us-ascii?Q?EtiJtS0gaGSQvnkAJ9o4ZTZ/RHFml9AA3GKUOBlD11MqcH3F8xEBWJYvv2Kn?=
 =?us-ascii?Q?2h8Ja8pEifDm/dKOlXAG6c+cCG3wTNQoTMPGMvnN2sFB2cuTGNae56phxmp/?=
 =?us-ascii?Q?Kq5lWmwTT1oBZCCvEqp3rfwiQxnkRPPKh6HgIG8rcI+kdL30a/agnR8RkX5P?=
 =?us-ascii?Q?A+1GAVaZSAF+H9oTwV9418k8STLctR8MAo5XwMJAjEBpZG+6Skfm8ykGo4sc?=
 =?us-ascii?Q?DG8B2b4JMfBKxdEm3WFiA7J7y8S7W+XwvibIqi2WuSCnkWXJnbJZatEVkeAj?=
 =?us-ascii?Q?sXCmVcyC4ApcTrKpHGWGC0TNautTI3fn5izdMe4s7ebuPRQIy793iDbMkZ4I?=
 =?us-ascii?Q?EdoZg5yo5L33M9dOmfaMbaTskSRe8pMM8bOybOXY1cSWEqr5fnpm43S/2zC4?=
 =?us-ascii?Q?4VIGTpdeqW90yG5UpxTe2CbINppTuLPWEmWWQjq4ah4I7U6/cvUHeWenNhkL?=
 =?us-ascii?Q?mGoND1xXdbyRhFtPPKNxgjfGX9llZzjmZk/ePy/K3E1BqwKY07ZovJptAuXN?=
 =?us-ascii?Q?3IjI8GxILcCEbRka/Yfy+Lf9HEKfwl/wviy8lsir2aNcAKyHwV009xPZ0qB9?=
 =?us-ascii?Q?oQgqekEVCzmBJixkp2NtyyYSJubDKXBCy6sjZL03mY2JyJthDQ7NLcrKmD7H?=
 =?us-ascii?Q?pGmOaPsKYbPGqVNDxWhJvSAqynkcsz8IJhu6djyVOtxVUAs4yXn3qgpCoGRL?=
 =?us-ascii?Q?KZgav5MIyJ439DUUWdriQW4TmS1FYsyPA3dQIFoTj0yxxhTXa8Ua8QkSkZ2w?=
 =?us-ascii?Q?mMWGSMCzrFKk1MglSbbqKq9LSeuIf9/8gl6dRAKN5PkOVwKPWWW5AFu37CAv?=
 =?us-ascii?Q?4q6kstUphUEcSV3DtQCYStVC0C0YSrF8yVwHbGnoNGojUowcyrUM5e3VwQoo?=
 =?us-ascii?Q?Cb7UppFzAGHmuhQO3KnoEg56RqiJYjDCsW/vOMMcT8GjANrqT336ioahBK/S?=
 =?us-ascii?Q?UF7yQ3+BzDupLnlgC0LvYqadgZ9j3MYg0qgIdLCHz0D71lFfmXGfnqt8H1PZ?=
 =?us-ascii?Q?DqVfuCsPybEq7vNTP/iNu+lccneHHjr7X4KHXDqawM7PdoYQg7hkXeJDTyPO?=
 =?us-ascii?Q?SsPgeSE3jL9Jn8XDI1CL+0ytssiZfL4J2Coyyw3Fo/aFSF58Pff5X8LkGX/o?=
 =?us-ascii?Q?EHOpk/KHlPDlTRdjOLx10xk2t/fDTd6TdVj4xM8cJwdxRHLMPBjOlh+rSmbg?=
 =?us-ascii?Q?iVOOJ5ss4pxhcWAsOucDolbESr/Pr7W623tXoQ2iVnN7MWGuEeIBNkglQOXy?=
 =?us-ascii?Q?mLuEwykz25L2ob5jtwtug9BuDQ/Igk+rgsqKdb/zQo2E4VpX9JdGKAMIqZyt?=
 =?us-ascii?Q?XMDBCjZI8lhnrLbAa+Vq7/13RiVNCLZyiKTyPmlIM+oNuFCYQYFgDZKb6IgU?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H8cdrGWzrB7y0gZ1EUbtLS0dZSAxpdA9Z1EEkyCmsg8Y/h4JfgDwVxArgzMWCkkA1LHS5SDZMcOdJY9T2k9djsL6iRBGRTcKi9F/m3ExikJyLmcPP9KhPZvF4u8+bVIzgAEzb7BYJKyw7rm1Sa/VkccKKIYRCRUuCykZOk+6Y2CO6AZBGY261RB0/RUiwLCGZ+QgPEUrzK/3MeH2nqLtmf0tZdnPap6nOL96varoLdOrD22ZyUZpv8hcsg54b3QUHVNrysfmmS0tUBqWZHTAKDbQVEp6Egvqc25o0K9A3G6cwyyRNKVizkhUV6y47CSfQabYsHahsK+/mNxZZCi9J9uKPPXcomMP1scUHmM8r71XHjwX8aAxzHRDS897tD5Gcv2tnOQw6Cn4+AW373pxqzUkIH8X9BA2gdDBi3WmXT0PtAxntHyuy/0Q/JefpG/10AD8Eauu2KbKP2WAfHBj6CD6bcGYLhzjB+QQ0Lm+Q80s/l/PFez7cddueH7h5CDnohb6I1jRQaeIXw2JrxbWqsmqKJXd/WufgBDb0kbZtWbI/mO7TiUWn0IpWH56fw00GPN2EMekPjY2e8Q6/FWPS82T1uJ9/SN3Dck/H8I2lmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e82f288-f87b-4556-8ee2-08dc32426423
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:33:11.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zMgriyEIDCbZwmYboy8CC9HzUWl1KWJkSVM4H0Jzr7YijDRjm1UmgzP51Nes99yhytxut7NO/GD63Lk5lAOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200134
X-Proofpoint-GUID: TJcU25z8RywJhrMmPqFme6-ob365TNBC
X-Proofpoint-ORIG-GUID: TJcU25z8RywJhrMmPqFme6-ob365TNBC

* Lorenzo Stoakes <lstoakes@gmail.com> [240220 01:46]:
> Recently there have been a number of patches which have affected various
> aspects of the memory mapping logic as implemented in mm/mmap.c where it
> would have been useful for regular contributors to have been notified.
> 
> Add an entry for this part of mm in particular with regular contributors
> tagged as reviewers.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b6c5c92e49db..129a237b7880 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14121,6 +14121,17 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
>  
> +MEMORY MAPPING
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Lorenzo Stoakes <lstoakes@gmail.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	http://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/mmap.c
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> -- 
> 2.43.2
> 

