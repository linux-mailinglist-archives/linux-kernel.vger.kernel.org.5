Return-Path: <linux-kernel+bounces-33263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC492836795
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABF31C21DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45456776;
	Mon, 22 Jan 2024 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m60pKGml";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xOxg2WM5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250955E57;
	Mon, 22 Jan 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935517; cv=fail; b=eI8qD3lXS9Y68dE+Re7p/JOeSBzp5Bau+g/7AJHFKEaCxzokwzEpLPWp0q4g3XQlWfAjDEEp8SvxpggBDMunCXjWSzLRFBPwFcN+J1zamd8+cRR8MD/0iEhM4nyKwqAyXVWniYyWwVUYV2qpKk5TkpyzoMFPWhdInHXO89XJfAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935517; c=relaxed/simple;
	bh=Te3U1bOVy0wQ8jrHnLaCaXDRh34N3N1ncnF1y3MpMSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bnfx7CTBntIgoR9J9TkE4extw4984oeNCl6Ur0IWaeW0T8xHck4DBxz4baI9vOHElLra6ApoKDfATMX/e7iw+ecQrUSpA6JkZ+AFi5LcqBR9YsSnTyDDFO/YCiZRRBYAn3AjE8pkj2rbXAbZvXhFrachjQJ7cUxUUrUlnGzHH+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m60pKGml; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xOxg2WM5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MAZFaD008546;
	Mon, 22 Jan 2024 14:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7XOtOUJbUvwMEjgZNJUyrfG6Fv2tEoTZeO4lRjHiTeg=;
 b=m60pKGmlWR28G96CnkT76/+mF981Cas6lwnvQEG+BZLE9SLWqPkq+eAJtSKr2PXpv23h
 kiIBTNZIM2ySRKoFEPUZuufRjOUeXXLWdLFWHdfnnv90kd91y15yRkmMRdZrrjTayOMn
 UR6zfwovW8R2n3RhFIb49aJNVmLISMIC147G2CeNEcjgEq8Rked/oJOt2b+n35mgi3Ai
 6mjm4zP+Odfqti0e9luPoUouIwfAsrEgje5HaC+6V0bd2vxIVz/Eqhrrr1xa0IflFSQJ
 2HjDdNagJkNP0Ax5HiTnXFemfB0bViIfwBi6p2P63V3bukbUyzYWD7kelytkJfUdfx6R qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7abusax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 14:58:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40MDrtlm004287;
	Mon, 22 Jan 2024 14:58:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32p9bkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 14:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4ZOHTugMd9rUoMCijE85S++/dGPK4YaDJ97jZ7cJrkgCwjn+YklOJ0pRkbq7ev9IHJp04tmEJ1ybV0eei0EXST3oudpSR2QiNa7KIXuleDx/z8RRhA0DDzfjZr8Kbgl5JJaw9lYK2hYygQwusxIdBLYOV0IrOluKdb84Ra7NYHAGJcAClLVq4/DysXIfWUfaBVJ3OxiZT3z5Lh63K1ALHktl+X8n/lBhfDh1aRLAUPQyNS6yuScgtuu4c6GMqIkQPM708Ok2b/zfFI0fXTXHan9lzAtj4N1r/VZviv9yi/GGGrOE+AZUZuDyy0NVN7QDhQXPk0qwaYKB1dvgHuUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XOtOUJbUvwMEjgZNJUyrfG6Fv2tEoTZeO4lRjHiTeg=;
 b=EzWRNxiRY3/uxLdQG8XvEQijNiVWcNB6symVzac1zSUNfl2ZICTxb/pasG02XPCWaT0EZA4IsE2CnlT8WXweDu8GRZjkZqfJ482SM0BHokqbMU6ugi7G+b70I4FSvrgIs4IVh7sSeEsnC47zyrt6BPCywQqLOYCbTjuUL8ZCV7cSBsmdUUwA1XOOZrwDCqkPHeSPps9bvkEyNCYJD7XUYFnehpAG1FfCRW8+cTrZ5JV/yK6UMZ1bKQlRkekuTN8vWyxzfXTyMe6JJN+Z7LIykXyZfnOfiIB/oULxdUJreo3IUcHRVC9RGVaDbwGFNYcdoYOCsjivYi07IzVIMyn4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XOtOUJbUvwMEjgZNJUyrfG6Fv2tEoTZeO4lRjHiTeg=;
 b=xOxg2WM5NFCft8wAHl+Sn4M8bUHc7kQ3WvJv8nf0TLexFckufCoFnupb2UzhDYK7+vf1ba69svdQeYyRlXAr07RANNrg+YmOXnIckrCsgF4ZAuiwIhxT6WBhnMz7pp61N+IkeGjS0k/ybPCgY8TL5JImKY6lN4rwTdkcjYNiT0s=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Mon, 22 Jan
 2024 14:58:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:58:18 +0000
Date: Mon, 22 Jan 2024 09:58:16 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: avoid duplicate variable init in
 mast_spanning_rebalance()
Message-ID: <20240122145816.unmy537vtaqflhfu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122102000.29558-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122102000.29558-1-lukas.bulwahn@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 7373f1ca-e5a2-4900-b5ec-08dc1b5a91d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GydpTpJIxAXygf0f0v7oqazANcKsJBd7yh3qKRMYeB6YFCLWAo3HuZAwIsK/0tAyv7p6hksf1sJ0o9sCgcwYHOSO1y/GAYZWLfLmXVCQOBIvTQNkq05+EKAZ2UuYp7A+AcmcIMmJ67hU1KZ11i69luSyi20smX9mYejAPFvbKuw2n+OwSPdU5ieXZdb2fdIFzWzRTsuoTHFrTHnPV770Hn2Zr9ig5lmrQkd6Az1SMgxHoICBd7st5a4W5xT6Om78eEd+/dKEEa1z4qicvK2LMNRMsyjCROeg3rFfUXwCT0jUwPrtVesyGFMotk/R/DcLsNVwcIapSwrH1sEVZ2EfwVOiPEKtGJBCF02C3YBCYMjrYl3hWVQ2s+EIxcXI6c0V8g4hz2cngoQbU+q3h3YM4hVnlnxFeRuY85T1IXMRe7nswatruMzsV8YbCOeOkRGfMFxXlPCii76YESfUPLKWCrpIz2nr2wvWOc1p7aw/+M/lbfFCNpTqkzc7RjrSOmXSVBwBOG62dByDp/OSr5SvlxFsTPi1A/Z9SKxDY88XkUXgJ0WeDNKgH7xJb4msnpVD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(86362001)(9686003)(8936002)(8676002)(4326008)(38100700002)(1076003)(26005)(6512007)(6506007)(66476007)(6916009)(316002)(66946007)(66556008)(6486002)(5660300002)(33716001)(478600001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pn8vUaXFpLZ9TF2FccVL2eJPwQUC8Jm0Ori0Za3p7zXqHSVYnoApxfTz5Sqz?=
 =?us-ascii?Q?5Ml1eXfP05FID9gwwhmT6tY8KIP6u5k1BLBFexa5EIdEEDFsHnvZnxl3Uf/H?=
 =?us-ascii?Q?NLgQQsPJV6+wLNyMhEg+rKoHb4xTcwUqaeNqVd5gvF7i6GGbzFXGjwIdR3FD?=
 =?us-ascii?Q?L3gA883QKbMU93ZtTxxQEAHTE+1kbcWyW2JfHwvyJwzGHzj5PUssi8WaFDDD?=
 =?us-ascii?Q?1FAEK+fdtlGxhKG9qmior5heZJZ3CFcNHJhSqnAqtjDLa/XTwnoM01pW3V/f?=
 =?us-ascii?Q?WwOoy4jgGb6Xk6Ksor9F0nS3rwU+R8a/R811B4rDuX9twFnKsSj+gDslgAtc?=
 =?us-ascii?Q?5CKHj1At+13HiUWDdmc8mA5PV1cSXf8ujbADREvZiMft2Avbo6ZAlwuL/NqH?=
 =?us-ascii?Q?/EdP7Ck+QovUKWIZBeqasbthWiVqfA7fUpWgZB1uOweFJYVAgOz0Q3gjFRJW?=
 =?us-ascii?Q?6L6boGDFf6uD4/dJ8rYN/8TlPO9vtiXw/NVMfqdiG7nv4Ed18+ycl2mmrIN7?=
 =?us-ascii?Q?KsZNU6KqESQz/R2XZo3w5Xj9fkT7IQlH/VHEHcX8sWuXeRnxOjyXvNLF5bhr?=
 =?us-ascii?Q?tXYEX1elmk4WWu8qHbfnxOaeq5dLoAZMFnToV2AxJFCOlndfWRhHNq1C68F2?=
 =?us-ascii?Q?loePPwijMSrzwAZ2xS+x0eQZ5kE7crtoXhDWdt6NC9m98hID9pAwGujaO6+i?=
 =?us-ascii?Q?8h9pvNeRoTLEXHlrnqHwL6pHmtettHagJhtcKyA3itPmC642b6cU1QcZKD3b?=
 =?us-ascii?Q?I6eDG001UfctV7ztES/Yzm28kYYXf4WbHxuagQFwDST2773S6JNvY35shW5I?=
 =?us-ascii?Q?NY9WXhNtsKiJ26j+JmZ9Bl4jxrNJ/u9GTRSsZUQ95w83qClDuSdMakCGBO4I?=
 =?us-ascii?Q?GGM1r82gAAww2e2TGuoaxHtVVR10DXZNPRF0KKypLaiX//RDNJ2RjTHpxIsT?=
 =?us-ascii?Q?mdyxN6ylDgpinNJ1ZbW+tr0BgDBigpzNqKOmHybsURlmyU9EobaLSlVD0JPL?=
 =?us-ascii?Q?390FwglmTZSzvnTFulK+tyJVg0IEZ8+oNLp0Uy9CLZDs1Ih1cuVH1Kq6Pske?=
 =?us-ascii?Q?o/TTJPBZNwSnADDh/KPZQeVw/nYpucgBwbVzV5LdqDhojC1YC8nURLfVAhG8?=
 =?us-ascii?Q?a/gDiOXSjS4p0LKxVJWxRP3KZ/KHRJr0G7dz2RdPw2KsWFtu6vO+LMTzIfLO?=
 =?us-ascii?Q?YhHUnq5Ro4U2jRwZuKR7mjhfFDZ0r/+K9qlQATZUkfUaZB8Edna43VHFrt1u?=
 =?us-ascii?Q?EvlP0c/+3uxzda25pREh52TBU4pA8WyLRk88ydOLsb1pPdk7qUOt9MFPjSD+?=
 =?us-ascii?Q?2QE31y7jOoBYkrMQ0bBNAOkWfPMon2hVQc2A9mt8yAZsHnWl1c1VaQohNbmu?=
 =?us-ascii?Q?u+g/pWpgbnowg7r66OnsHTbtHzFJrKvCrUXRAD71aKpM7T1qlETrkIuL23qw?=
 =?us-ascii?Q?9vfAzNqDHdfEpqGN6ext51sPjunxe0amZT8sEIG8R39p+NhVrQdJ3KDxVFbm?=
 =?us-ascii?Q?ooRH5caF373p2JUTXPoEdSnHbOJh6r6rRFo34ANXuCRq34qof7uQinczJ6dp?=
 =?us-ascii?Q?rCWU0ykxD/3VulTEuYgSd86H4XC20Ftrtdt9AMus?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	adSCpGZXI0yGb3aKtdCPx0ndyRAHl11ZYkRVzFsSodM3gOdrNzC1wbozxrtBWPW83/WmcirjrBPAXc4SW6vQDi14bZ3H4yTbwcUcMsbA9dRXMGViaAz1F3MXEK77Zkg1umBInEqY10bR5k1yfbCIjl4ddpBKvzsTcrCq5Rir96o/VU+1/3qsZW7ay8dh3vzkAZCbjw24TBIarhjeXLr8ZULMeqVyScSa8yhbAvNeuMWMe8D9FHwopF7K9L7sDv7FPUla4hoc/i3X0ZQ0N6W0tRc4L2dz3TdDzKBH4FN0ybikv4s9r3qWUDXHQnRI55mLxJn7PACrUgQOketDoWz2cHdT0VwaWL+g8dOwqCiOT0V0nh73Cuq7811QpNdlOtcmwGkd7v6CX4AUi6wyua+I/73a0doT5Rgb9riLbEpfcu7GRFkAhaZYIweZfij9GLbXy8RLHGrSjyYKD6bDWZH0bOgnheediJsj3iQ1Q/CZo06SDfQf6QKjQlLbBb24YYoznq1oqHuHQpmDZA5+R0o+GJEAAe+9it27QAm6v6SCSb94MBq7fr3VJpnz38fEdvEgMXuaHkTJf/k9WI564MpSGvBCHL5M91bggns+nHMedTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7373f1ca-e5a2-4900-b5ec-08dc1b5a91d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:58:18.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnKOl8Fh+Kr8tpzmtG6LhWI5DSITOEcP0u6/MJAT66iw7yT49lR4Phfxp1PEEL5z8ZK3YGLvQdue2JlyG1tTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220102
X-Proofpoint-GUID: fE-YOL2dUeQt03jrMcjj-Njs5j7CSH8W
X-Proofpoint-ORIG-GUID: fE-YOL2dUeQt03jrMcjj-Njs5j7CSH8W

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [240122 05:22]:
> The local variables r_tmp and l_tmp in mast_spanning_rebalance() are
> already initialized at its declaration; there is no need to assign the
> value again.
> 
> Remove the duplicate initialization of {r,l}_tmp. No functional change.
> Due to common compiler optimizations, also no change to object code.

Hello!

Thanks for this patch and well stated change log.

> 
> This issue was identified with clang-analyzer's dead stores analysis.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7b161802860b..82fb5195c235 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2271,8 +2271,6 @@ bool mast_spanning_rebalance(struct maple_subtree_state *mast)
>  	struct ma_state l_tmp = *mast->orig_l;
>  	unsigned char depth = 0;
>  
> -	r_tmp = *mast->orig_r;
> -	l_tmp = *mast->orig_l;
>  	do {
>  		mas_ascend(mast->orig_r);
>  		mas_ascend(mast->orig_l);
> -- 
> 2.17.1
> 

