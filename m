Return-Path: <linux-kernel+bounces-35625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD5839453
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C841F23441
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B0664A99;
	Tue, 23 Jan 2024 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yr7s6hlS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aFhNyn5C"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2C612EC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026178; cv=fail; b=qWcUaBPLhFn8WLEtJI0y65cfDBFWYYycTYxYKPHhNmkTMb7bg4757JxysqJJBi8uXE788s3LolVOYhboGxy7E/PRCdMOkbAb1lJFUzap7gx3+a4m1Rcu9C3d32gmMQXeqibtoU8GYQhP4c17ZjDePvTHAn6qU8xVTBIQ5TdgCsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026178; c=relaxed/simple;
	bh=1TgJaxZatgg3/1vNQtN0+ef9Cr/0/hm91qwMQ4gDNbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nsjr7o35fYpOmaRHliuANRkppH4lfHkt//lvaJBEaDUS7X4Rh6+4tJDWGiAdfF4gjM0lL/01pkMrYqtw85M8Uhz7bmFpwQPYj/+0hm/nvhl2WUO5zMtsjZsLAjYDs6A/HT1Dif+Aw3MEHmRuxKYPfzkQktbGALj+UJDm8UI0qN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yr7s6hlS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aFhNyn5C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NE4253019500;
	Tue, 23 Jan 2024 16:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=raWuhNVcGS/U6bhVOWYgSMCS55Mp9qMrqhhBLAlnxeA=;
 b=Yr7s6hlSQiSTgiX69faUW3GsOyp/BIlcbxfq3Xok79xHrPG028pxyscBBUkoaRDz5gQF
 dwFPzLl+JLFUi/6U55YwYEXC/dYofgI4fcjijJbsxM0NwQU73MReLnLaA5eCdPxHapam
 JY5gBSeo+uTVCZOllYFsFAiHuoJdoipII3ELBQ6KpdZaLrR2Wn352pV4jgeYvs7x7qjs
 F5ys1s+bQ9wVqvbdyDGFiyc63mxBk0E2aBai45vOM0amgvD7OLF/5L3IMy1lHIeffqg8
 JqJB7zUV5A9zLJYtBXuLjnsA6/QoM+gsx2ao/uR38nIB4n/pwkH1wy7xD5YKQhrJVR1J Jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cweq4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 16:09:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NF8xZU014367;
	Tue, 23 Jan 2024 16:09:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371h10g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 16:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncwW94/S3ne5hFSJuoUm4Wi7Qz45jeDMIJWphOofRWki+T3XgF4WDOMEhGgLEC9txW462+s9MwNkggUW03QYev9UmhKqi1GLFMdjWnPjlYUIC3D/RSVJVT9yZ0jkWCYemasOsTWn57NxpzJ6mhZ6uMaliEGRZ7dnxuA0tKkeLwsdNJTRWxRbY/3vf8UnK5HwyvkVbUfMN+tocDC+Ypn1HlSnouPMnrfIPC7SclQKLuWMtFXf5EE3AWRVY8dM15UAN8WuZC9uxpTTaDAIrJYgPEsHDCb3P9/KHc1WMJFAt4/s6kosARqLJC2sdRV249NMH/ne23GO/UmcuydtOHvcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raWuhNVcGS/U6bhVOWYgSMCS55Mp9qMrqhhBLAlnxeA=;
 b=LMP4jc5btZ7ULtOq4fiy6xQn64RmApi5/JkoT/HCbE6+R1s12Wfa3q48oRE4nKUhRBDNjpLaWDlmL6rXngVChfNyw37TDYQ4JMdmGAaiVW+SYZmkre4FEW933coEUyFoI6PtXeIuLdlXZrMUlqKz5B75YRGJPVOybQj4uwkAUjKQIkYzmDdzyiV7B1bjhmZvS4UL/LNMxXdUO7wgoaAcuhpksoTK8/8a4/lKd+SMuv1DBd/LLaApksuw8kdqBuqPUrofrnQh+rfK/J2kt5gha7/RJdle+8QlejV/GqTYGDyxvROAdlG+gNzim/s7byNpHEPRdv8XybGgvypm8M5RjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raWuhNVcGS/U6bhVOWYgSMCS55Mp9qMrqhhBLAlnxeA=;
 b=aFhNyn5ChF9d5mirZI2QL3GhrRWxf1IegQf2r9rOR5QATDHDAaMs35X1izif5ndOl1Y5EvVGdGMMVAJHA9xlq3gwF296/3GIreWPPlZk/FWyvJkUVHbwtuYh5uGzwsqysnDebv0D+pbc+VtV7jrrqSIPmKykBolnRg4uB5W9iTo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB5047.namprd10.prod.outlook.com (2603:10b6:408:12a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:08:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 16:08:57 +0000
Date: Tue, 23 Jan 2024 11:08:55 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/mmap: simplify vma_merge()
Message-ID: <20240123160855.k7fhmlb7cfhdel5t@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>
References: <20240118082312.2801992-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118082312.2801992-1-yajun.deng@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: 7674e494-02d7-4dda-7400-08dc1c2d9aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hB6mbeCiBzpB1dLLXWQLaASnhA3WicghK2Sl1wHkfIQDm7+idq7Rn8kTuruFJ3mhI8eU6f5Zc+uONLs+96HgogSyTKoiDOZwKHlQE9kv3yKfkAH4pbVbdgX8/Usjy9AwseVGBNrXFiHbCXtU0BBm65HmQIMqLqz7yN0QAvaczpyk60G5dVzAS5ECscQ9PXRpICRm0nN4UwY157nNltfBE5NCs0QNCvnUcH0w7E0OL1TU2Ii4oUaE7uHZmcd6HJEY3UA+fiAB+nAAP62BMzobSyosXh57JuycCoca2EFlQm2qckFtopZ5+41YMB6LPLOx9g38lmkAkS8zH35FdN1MI4AfJZwDScE+14+LQh8uHoijZPA6BjWIfV/fF84Z9LF65GPmDBC1GAWNJHCmdCVVxTFVjAaMKXRS3gJodgcauNGeTwH/8F6eZ2W0Q0QS5wxrxl2HUQb25TO/ur4yxcGlJb7nm7T6ry6CYnPNp79+aachjZKfk1c/oQuWV54VAm6AXDuDtklxBsdtgGpKEJUdKt+xpr9opwTOJaT2s0268IMO+1z0l9VAOFKvT4ajwivf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(5660300002)(8676002)(8936002)(7416002)(33716001)(4326008)(2906002)(9686003)(478600001)(6512007)(6506007)(26005)(1076003)(54906003)(316002)(6916009)(66476007)(66556008)(66946007)(6486002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h1pIS4agqwrML8ydCguxgRtvvQEYQMAML4MHg3cFLEnRhX3TiRW2f3ut2jP1?=
 =?us-ascii?Q?xhhQyiZ/rVEtY8If21GWuuJjFpyP24hcrxSrZCIdjr64Kksg3CfJj4gGogrm?=
 =?us-ascii?Q?esBDhN2R4jk1xpc7QdJgmQ1rSukKVH1+KLF+CAOiM6HBclOLg4QPXBCPM6tG?=
 =?us-ascii?Q?rwhN/3S8mK2LtV62PXqICoOfDHijsyQtvDc7Otjw6/ydVvtqj9DtrzutyNyF?=
 =?us-ascii?Q?gUczb6bS/yIh8U3vbGLbj1P0H/MgZc9rWnPQZkgNO4lE2NyTfBbWFrrF9IFj?=
 =?us-ascii?Q?WLkgNbkecj68pfEeGVZMpJNMFKC8wJJMXwv2JUUQ91kds7GX8i/O+kO+UCh4?=
 =?us-ascii?Q?3M9uGZN5WkFvSqVRvIE1HIEnHdiRvrqEbixGVJfvlgATNdoS4kjEnyjObUjz?=
 =?us-ascii?Q?wfkwnAKw/tdshNRbt43R5k27ffpY3su3qlNHOJtMnRS60zFHVJZL0dQOikWl?=
 =?us-ascii?Q?cAlm8IeUZk4Wg3tcdGlJGqT3W5NGvAwithms4zGqEP9my7Q5ScCzjObOpqfO?=
 =?us-ascii?Q?kPt4Om9mKfr+FFesozhFPuqQ25lMz9gga4VmhCsj5HvwNG0jGkE3T/qzuFQC?=
 =?us-ascii?Q?poeYhzGKPZOb+hFGZi0WB/Ur0SuQX5Awwmxs53fWvhbYJur8s0hlJnRmb4fg?=
 =?us-ascii?Q?VOwb0jcrTvHj8X3RGLxPpde3ysJmcnbN21/kaIETUKWJZmpirrykyal79MMN?=
 =?us-ascii?Q?zbjMhYRl6p5MS6pKRFoxVCY65WVKxFTaSo4uY9hfzToNSXsm7AXxf9/NNYYA?=
 =?us-ascii?Q?QiTwaXx+fBwDyaxDgjX3DbPD+btHQkw5ZB7dpuuiUGSYr5kHsAhs0undEJnh?=
 =?us-ascii?Q?XW5jiRnIZkzRLHe8w9CzrH5OpJiQcpg0xzZlWOKup2zbMDr8e+uGSFmW+AKt?=
 =?us-ascii?Q?VCrprWLRDJibpVPbCD42WeVPGnatz0DHUy70FdH9m54bfZzEI3YOy3N72swl?=
 =?us-ascii?Q?fJk82LW8tO4b13pi3lMpsicXj854cAJgwpyWCpUsOMSfUyVXXOL8roDVWpqb?=
 =?us-ascii?Q?YEIO2Z8lsfEbCiI4N0O7JkiNqGVhyibR7E0tTdIDCjk14/GRGX03qE8Dg8yu?=
 =?us-ascii?Q?FP8Z4UYkvtyPyA8OoO5fd9jnlZtFBacRagrRrZR4N3KHXYOCWfogJ7B/vrOI?=
 =?us-ascii?Q?I04kbglQMEpslnvLLJNSWBNC7V+dsaq+F95m0eAjvV2cXjhdRj4e0F1eraTB?=
 =?us-ascii?Q?pOf+N9PCrbgVTPI4530SenNdr1Mlaaq/CnJW7yqHyUR3rOBmRQWeSmGJAuz4?=
 =?us-ascii?Q?Qsnq3neNS0C5fE+aAV/b/ZcVR4b1dxquX4pW4d7lYymDc0sD3zy/uZWw5YiG?=
 =?us-ascii?Q?Z+SOdkRCLdLOGUkDVBSk+ZeSZK2esiDzrQa4hKLw+YtVoTC4cooC7jIphdKS?=
 =?us-ascii?Q?5wfe2VGr3e1++0aZubvKBijgJ985/Wp6kBeJqnIYpGDsTSxVUVZPiWJFC2tZ?=
 =?us-ascii?Q?BPSJNYod3BEoDKTR0BaxPaf7fsZaLyY05WzWq/LF7CD1/SlUqp/0+OUCTm32?=
 =?us-ascii?Q?GUvRPbpc69stMB9RMqVKhstFiqoOzwWV3xmOoKOJo+F+yKnyG/1CkM7DmYbm?=
 =?us-ascii?Q?j32nWtJQtD4uTkXEgDC/qqWTyOi14ZoL3d38vf+H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KFQRMuYHeA+0Ee9tD4G5jDCvv1JGB2U7bdACnf+y9LW9br1GcjVWni1mkCNLfohMjYMxuRucjeQNMmFbwSVAquVtbHUu/OS3DU8kqyl+rK7m0aQWabGmllCJW7F9R0BxIRBTuOiHtKBs/+ItQ6PkWvHaBIDYmxWhJFc9Qguwku57pLv/A6iTdp70c/wV36mUMsehr6In46CTGuYOiG+2Wfwa3W9qS++A9TagWnkbnRGcjm/xsVI1pbbi4zAISCicGlUcgQVU8mGjyQH54j4XLsDgqLZjXunGjP1i9uPGDdTQrdDt+yJoXBKq8CiCydu4wMciVoSFfqlAO4EDnJIB6w5HAVYBa8o6XUoUJP5YXR/2lLDBLDN9ZnoCtESMUsgn39WyPpT4CqkxRDKwG9k3mOte93ljj575xGJLWM+2ZWH/RpthgDwkICsRVT2aBhrEptDNVHw7UDQ8AYiNQ4k2plHfJIYU8b7RA++gyEHVG2fOw66mNdampnZhnBOSTmdXO0qGESj5Ippa/tg9P6WEOt97hfMINzOxK7zX10Li/iqpdGlt8ZzgSBBiao8a+kNrwEbQpFcoKbMj9hWw0k8/vKWP5RTKY8r1l+TrzSg50s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7674e494-02d7-4dda-7400-08dc1c2d9aa3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:08:57.4724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOltY0wVhsfrhFAu4mo2tzoeaumRNvJkKy3N5LPSOv1cGn8oBmsZhsdV/OBdYVcAMJ+5gtAe5cmC05+6pGfDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_09,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230118
X-Proofpoint-ORIG-GUID: TBmpBM018up79fkqhCQOpzSKlfIGoy1Q
X-Proofpoint-GUID: TBmpBM018up79fkqhCQOpzSKlfIGoy1Q


Adding to the Cc list, because it's vma_merge().

* Yajun Deng <yajun.deng@linux.dev> [240118 03:23]:
> These vma_merge() callers will pass mm, anon_vma and file, they all from
> vma. There is no need to pass three parameters at the same time.
> 
> We will find the current vma in vma_merge().

It sounds like you are adding a search for current to vma_merger(), but
you are removing that part in your patch, so it's odd to say this here.

>If we pass the original vma
> to vma_merge(), the current vma is actually the original vma or NULL.

What do you mean original vma?  The source of the anon_vma, vm_mm, etc?
If so, the 'original' vma could be prev (shifting boundaries in case 4
and 5 in the comments).  I think "vma that was the source of the
arguments" would be more clear than "original vma".

> So we didn't need to find the current vma with find_vma_intersection().
> 
> Pass vma to vma_merge(), and add a check to make sure the current vma
> is an existing vma.

How could it not be an existing vma?  It is dereferenced, so it exists.
Do you mean a vma in the vma tree?

I think this is all to say that we can pass through the vma to figure
out if curr == NULL, or if it's vma directly.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  mm/mmap.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 49d25172eac8..7e00ae4f39e3 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -860,14 +860,16 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   *      area is returned, or the function will return NULL
>   */
>  static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> -	   struct vm_area_struct *prev, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, struct anon_vma *anon_vma, struct file *file,
> -	   pgoff_t pgoff, struct mempolicy *policy,
> +*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> +	   struct vm_area_struct *curr, unsigned long addr, unsigned long end,
> +	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
>  	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
>  	   struct anon_vma_name *anon_name)
>  {
> -	struct vm_area_struct *curr, *next, *res;
> +	struct mm_struct *mm = curr->vm_mm;
> +	struct anon_vma *anon_vma = curr->anon_vma;
> +	struct file *file = curr->vm_file;
> +	struct vm_area_struct *next = NULL, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
>  	struct vma_prepare vp;
> @@ -889,13 +891,12 @@ static struct vm_area_struct
>  		return NULL;
>  
>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> -	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
> +	if (prev == curr || addr != curr->vm_start || end > curr->vm_end)
> +		curr = NULL;

It would be nice to have comments about what cases this logic covers,
because reverse engineering it is a pain.  And we have to do it every
time a change occurs in the function, even when we are the ones who
wrote the statement.  I think we can all agree that this function is
painful, but it's improving and thanks for joining.

>  
>  	if (!curr ||			/* cases 1 - 4 */
>  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> -		next = vma_lookup(mm, end);
> -	else
> -		next = NULL;		/* case 5 */
> +		next = vma_lookup(mm, end); /* NULL case 5 */

Ah, maybe put the comment about case 5 being null on a different line.
I thought you were saying the vma_lookup() will return NULL, not that it
was initialised as NULL above.  Change the wording to something like
"case 5 set to NULL above" or "case 5 remains NULL".

>  
>  	if (prev) {
>  		vma_start = prev->vm_start;
> @@ -919,7 +920,6 @@ static struct vm_area_struct
>  
>  	/* Verify some invariant that must be enforced by the caller. */
>  	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));

Why did you drop this?  I understand you moved basically all of it to an
if statement above, but it's still true, right?  Considering the
trickiness of the function I'd like to keep it if there's no one who
feels strongly about it.

>  	VM_WARN_ON(addr >= end);
>  
..

To increase the chances of actually finding an issue, I would suggest
splitting this into two patches:

1. Just passing through vma.
2. The logic changes to remove that find_vma_intersection() call.

By the way, what are the performance benefits to this change?  It's not
without its own risks - this function has caused subtle bugs that
persisted for several releases in the past and it'd be nice to know what
we are gaining for the risk.

Thanks,
Liam

