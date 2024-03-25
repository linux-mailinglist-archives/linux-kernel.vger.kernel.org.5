Return-Path: <linux-kernel+bounces-117924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28B88B15A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4E81FA2F22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEAA45037;
	Mon, 25 Mar 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+ugn3mC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HpWGxsSU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE01CA9C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398434; cv=fail; b=PVeirfZEToL4ZGHlJUp4KQ4yHImsUZXr947toh4752Y5WgL9C6B61KK2xrA+4LX4tHvy1fzlb24Zpqhi5/NAhqicEZplHUbKhvCO8+Z2GJv6n+bEZFvCEvNWsKr5P/l/lDRLY8sp1EmsuAc+doQ94OV8wzi82VdYblsE/gFWF1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398434; c=relaxed/simple;
	bh=n6xCqiyKKphXJG1C21bwpUgEQ5cAadJketM0zJ1mSiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dsmo+esiXPCtb6jdWOVTMOr73e2z8eNWy2WHUyskEh7jYY3Rra0H4loFP0ix5BgzfjCPjiSB0tIinknU1ItkxYiUT6a4WN80ORDtvNRL8YeoiJ0Q4xXys0mcf+/po01UIKeRE6v057WxyqDUqphkNqxsxUgcgwvnRuulCposSKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+ugn3mC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HpWGxsSU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PKQwIh002928;
	Mon, 25 Mar 2024 20:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=UL6WfFDXoQ4aUnSID0wxqpmuzjfTWJczkMW2wwe7iew=;
 b=R+ugn3mCc8eLUK73mMgNc7BLSGMPc5sahtrrq7qfrGaCYU4PaNxxd/UlU9ylGlL5ISKb
 0uh1J86Z8lw1i8gu3JcLmkuaD3aLMP8My4xezPQYXMpeeqmP0f+Aam1NrmxovFtrp9tc
 ecTBSbl82QAdpuRtRMRgMAGgTEPislFcPwn3b3P7kaRoEgvBI9X17x78acS6oDYnxTGD
 isy4KB6os5lWXO8e4bP5b/+ZqkO94T6yaQaIw6vvTIz7jCrreRWMa3Cr9F+wXMYmnWgi
 41y/BEdE0bfAkY1rT1Ve/UZzxSoSt6cO/lcmJZkxJ5WG1TR7CpuXciHV2aStM75bSZ9y TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dumrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:26:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PKFT2X006893;
	Mon, 25 Mar 2024 20:26:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhc9qys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 20:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF7bU3zo/sh1eOAyBqyCwOJzzVH4eUOj9O8PpV86LwtZoZa1eKczdWNGa/OW6Yf/YPqKhZfnNRAI3xb0UGvEB32HzI3o+u+dWWnm4p6DXVbSSPVgOmBILGXTs3FkbYiMSw58RIDvb2cA6/Ku4tYMclH2FjEqHP6zZ8hPy+sGHBkNYrAGE7Mna8Ecf15hzWDApmTmpJihGyPbud8n/0zmQtoj/onjZSihu3IO+XMbsERvEFub6eSSZ69Xkez4kOajG/02VlLbv/jeo1zfRa+APjctaCZSqEsjruzGanBjCDvgQBZEdzXS3y45w79Sc83g0cK09k8DF7sjEv61+w71Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UL6WfFDXoQ4aUnSID0wxqpmuzjfTWJczkMW2wwe7iew=;
 b=XWk0VWNAvUUwt3FelCD5mpkJWylczObjtW8TtwxqJbNMqMe8UEpV7JO/oAlJKfBwLGfYYUtSUo6XqnaNewphLM30njpnIgW9cQkiitN2eEv8devk904a/ZVDUcY1JOOgIx+X9qQ/mM8+nOuHaQT966XqueDPeVPG2J0tht3vh4DI0QHw0AuRSeoZ9WJJKq2g3OArpJboU59Pl71vNfDb55izahyg3SZIvrnNztctg4vGP/uhWWRYiL0/9b+n9nE2yXDtAmj9rRctkYRJO3o466IOToqfNc/fushUN8944kiu9LMRr78Yd1kgysHfqUXH4qwMMpPBXOmqH0m3oVpc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UL6WfFDXoQ4aUnSID0wxqpmuzjfTWJczkMW2wwe7iew=;
 b=HpWGxsSUDyxWcyhh+uOe9WPTurKbzJlpxnjpOGg7qp1kqolohXdssc/pyou75wjbYZ2xYVfiJfRp6jsTAupVmtbmBNKyIsa9UDNrWtcipLPpGF9LRZlZotyteylosjhocu+eQBbY36OaRGwcrKnh5BllgcGsdbbAqyj2MP5UBsQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 20:26:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 20:26:50 +0000
Date: Mon, 25 Mar 2024 16:26:48 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Helge Deller <deller@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Yajun Deng <yajun.deng@linux.dev>, vbabka@suse.cz, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] mm/mmap: convert all mas except mas_detach to
 vma iterator
Message-ID: <20240325202648.ogekznob5vsayd6k@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yajun Deng <yajun.deng@linux.dev>, vbabka@suse.cz,
	lstoakes@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20240325063258.1437618-1-yajun.deng@linux.dev>
 <20240325115308.f6344233a27f1633f642f888@linux-foundation.org>
 <5dc6860f-df05-457c-8b78-067f276e423b@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc6860f-df05-457c-8b78-067f276e423b@gmx.de>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0330.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jGk292/V9Yk5i5FnUHfGZSj3UDUFwlvFe+k8CrN8p4Fhu0splyV7s0/zcKcSqY4XO6rru74KSoMed/2uCQIti88rDgVXvway/O6bdifORE5z03rOqYDSjA1dMZgufn491yHJjbkbrpK5Yvo4e+M0ui4EgLXiFemWatAvndRFcgM269huSDPFMP4jwwA6ssnJZYh2X4IHXmdVLsk3mzy5rb0dKyuJ49cRBs9WT6txlgnrs+d6PtfaehXROxxrJ6WNpOYB4hJRkgco/bAILiL3GEkjD2QfcWnT0gEoAfZdArrX0FDlWG9oYRgxgeOKajfqz7Pg+A6YeSFPDwI0YUKbkCz+O1hGle4F7o3HGYXN3hYNO/ogTDB2A3CVGhia91rBpoAx0lA341DC/kwl4/bwrWMG6zz5khSumt/UAisS4ytZbetcxNGKBfex02k+Naqgo048hfBlutD6wxKJAJDP3LtaETgTIy2sGd0pqobUVAEUXL+VO280/W9GWwPfLzUfFf3QQ26dnt2cTvgXIEiEdJu3CIpQdgBNsNfsSM+jyJyuryoUz+bFjN1k9IuqQURkroTRuk0XazECjcpZk6pU965IRa7beSb0Pfw5IOMHCI6IG8ZIvPyc/crUHg/8Q+P/n3MDX5hUGuwxDwhDJUsdnzf6tHWkvCgYbDQd8aEB10w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eY6zb/eV+xbIB4uA7LkovTCCH/cJM/ePzHAx5lH9pPYIhwSF3oWmhizTGtL/?=
 =?us-ascii?Q?eY7Jhe860gJlMjtEGIUA0iZjzx83OjB/O1mfNQ3adovuT6QkCVjWOkrWhFJ5?=
 =?us-ascii?Q?pqECWZTDWhGlxGlLoVfhJ21BieVbucUWaBQ6lmie9a/zu90d3jb/EckEm2I+?=
 =?us-ascii?Q?eTjQKsw6O9FspuIWtKPFR6uhV7OseMIELKMaWHcYXCcySAdQP0siT2XqA+DC?=
 =?us-ascii?Q?5+Mp04ILN3IhClmGsILN8HyAiRZzo5bsGLVouvi6SLo7pQ72NzTO/YkHw/G8?=
 =?us-ascii?Q?ZGFa0qceOMUaSo+BBCb1pnOK2CrlrhQsthLlhuqS8OvxEtZ+5HdQePVTJ3Vv?=
 =?us-ascii?Q?fY6arGmMxD1eHlYiK6d9K9sHdCEzofebSep0MGao7c5QYT9a9Q889UzcXFlQ?=
 =?us-ascii?Q?J9rE7ibG6NhY0lZx4glws7tiv+LuCR4iWARIESgqkPrwYfR3oYX2qO3ctiBP?=
 =?us-ascii?Q?nQV3job0STg3Ow6JZMFg9CnOIUk75BvgANQ/7AZUO8sOqC8nSvBT8JXU2oHg?=
 =?us-ascii?Q?CkdDzLHRl0o9ZqWmUuwiBcu2rvz4PtYM5H3wKjpJKwmpxF+6sd6ZWdnrbDHB?=
 =?us-ascii?Q?4N3rYQg0mTait+P4zdR5JjZY2E3AHnt+y68Vz7cS0LkWws4Glgr4oTyMiOed?=
 =?us-ascii?Q?MlF0Lc82ROs/AM3hZI9nxJjp28IvrdkgmpB8VdPYL59rERElWtDcGNYF9ZiJ?=
 =?us-ascii?Q?NXCh2EsbmlmwfPVM222I2S5K++tGtxdjIdH8SelxSMHz9+pRSgsE+cYB1by4?=
 =?us-ascii?Q?8emLhA+zvnY4HfOOi/dTm1d5EGZe4Fr9kQy15y5w8+aaDbspN10fmMvWYd1q?=
 =?us-ascii?Q?NNkRGKL6PDIGLV+T0peaJRoflTLhSNd24vCJYPxSRTZfyvhvTI0mla9aYMep?=
 =?us-ascii?Q?3KapzU1VMBERhWvotjxHHP8a5+6Ha56+iJej6HSdIG+XgINfV29UMREK8kEp?=
 =?us-ascii?Q?fhG57Fg/ZRSEuHQH2vEl9wb5g9myyVXR1wjGVf/rPaJoRWlJ9KeukQvV+wBl?=
 =?us-ascii?Q?y3P3ZdQWbS9nHIl8aHAkoYyXe0P2iTauoScfzCmb+faSiwkYUdqz+/9Vzgy9?=
 =?us-ascii?Q?Qd0yomWFesqqReoJPHJrHD5df5isq1pOSS7rQv+tvZTrhJvCM0fJKiqNo66v?=
 =?us-ascii?Q?YwLPj/INfq9QmefBADgLcn1GaDhdS5sjxprYndPeXfFiE4or2IYuetSTZHg4?=
 =?us-ascii?Q?NFn9TgWrmUU/0xc5Pskz8UFoBMB3fhhwDvOx90ZgO6FjDHtIJDExh/bc0b0P?=
 =?us-ascii?Q?TdsPSiPT92v/Vsrr8Am8/35y8WrxQc4kIUGpplVgNV/lMtjTHTBUetgVQ9/y?=
 =?us-ascii?Q?L9jdfb0A/Uxh9va2JfmRc98HeoilIIbk/9EHbMmlrXewwWVG5Zt6Iw9WQD/4?=
 =?us-ascii?Q?YmS1n5pT0w4EOvybqt5CEtNcbE7Blf71UhpDWlD6ugzybByHVveZ5JkkuueE?=
 =?us-ascii?Q?ikPTfZeuUVMBGkQPLTBLVCx5R2SXKvD2ImEXUGQ1peOo5rUtM6H9MbS4Pt/k?=
 =?us-ascii?Q?Ak7gGLNW0XRh8rOcSCoF9lTHisdzNndTZXGgzfDcIkwESOiq3g/YyMjCN1no?=
 =?us-ascii?Q?MuaFpofc8G+rJVk43HyvPqKmHWSYSPW9o1+yrfz0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fl+5/ZaRDkdb4w9TuD6AdeKedR7R8cdbRMy4Yraf0SeCS/47aYCjA+OyyYgq5ZS1q4iYscLJnC5rPsxITBGqV3kCHutc+REXkJwUKeMB+JMnwDiloDLH4Hgs0/nW/OGMcKPx6pp5Ct+91oWW92gD7DmxFSUheL9WGyvv8zH5Fika9aod8srYTBM42S0lz75FTikQKWTONZYClhFJfZwYqL6sfxskvwFmF0N2qOtw+g64xkFWxHs3Hdn2Ahreg9Ce71WY/u4dSPzucPXupCyL0xSOgjzB1V3WyVO5HfWoQRJH3XgL0Vw+OzeOCOWPF2VhlYAtaHj0qQdJMVc/5i76NwpfE3cmWkXH+TSy8e3rGnEkPMlNSU1KD/Toad9KFSoC6inlRPKjmF4b88rwdrIgyPGEjO4l9nL5XpjkhqYIbzSTeRy+BoFP5m7GT35WN13NzixYEp8LTM6mygmnNzhEDYQq1q0hZxD9XXybvNpvDV6GRCWlcKDNURV3zvOptxV8BT+ePMNBbJZcGOUZVS6wLZNh2K71MlwnUSxJMqbk5zBUV+088fgbr0F0ES8PQ2VM4pd1eJ+J3eYiA7fUvW9nb8WjzO3EHc8A04UOvK4kcVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ae3e18-30d2-4eb4-8b5b-08dc4d09e6b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:26:50.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O+DMZCdzPEQ9082wjOBeRTNUucGML2n4kPnPKujVITHS53EBUT0q3GfsvCRlENu4JLAkPuUfPrPiH37LIC6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_19,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250125
X-Proofpoint-ORIG-GUID: gJ03k5Sp79oHw3ulk6xOUPD03xxEY1oO
X-Proofpoint-GUID: gJ03k5Sp79oHw3ulk6xOUPD03xxEY1oO

* Helge Deller <deller@gmx.de> [240325 16:24]:
> On 3/25/24 19:53, Andrew Morton wrote:
> > On Mon, 25 Mar 2024 14:32:58 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:
> > 
> > > There are two types of iterators mas and vmi in the current code. If the
> > > maple tree comes from the mm structure, we can use the vma iterator. Avoid
> > > using mas directly as possible.
> > > 
> > > Keep using mas for the mt_detach tree, since it doesn't come from the mm
> > > structure.
> > > 
> > > Remove as many uses of mas as possible, but we will still have a few that
> > > must be passed through in unmap_vmas() and free_pgtables().
> > > 
> > > Also introduce vma_iter_reset, vma_iter_{prev, next}_range_limit and
> > > vma_iter_area_{lowest, highest} helper functions for using the vma
> > > interator.
> > > 
> > 
> > I assume Liam's earlier request still applies?
> > 
> > : Helge,
> > :
> > : Yajun has changed code that affects parisc with this patch, which hasn't
> > : been tested.
> > : ...
> > : Can you make sure that the expand_upwards() still functions on parisc?
> 
> Oh, I didn't noticed that request earlier.
> Anyway, I now tested this patch on top of 6.9-rc1, and the kernel still
> boots up nicely on parisc and as such expand_upwards() seem to work as before.
> So, you may add:
> 
> Tested-by: Helge Deller <deller@gmx.de> # parisc

Thanks Helge!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>



