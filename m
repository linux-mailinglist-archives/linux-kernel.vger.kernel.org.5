Return-Path: <linux-kernel+bounces-87755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6C86D88D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC17B22E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CF92B9DD;
	Fri,  1 Mar 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oxuL0ijv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CpnRB5Ei"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACFB3232;
	Fri,  1 Mar 2024 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255515; cv=fail; b=g8VvZs7tvRsE8OZsos0RGq53elKrPFU5Vnt0Wp1BbWDizbnZW0P/N6VY8b14yByAyWNZhnkt8DbWFR57/L6VkGLKV0JkD0DR9TmnVMTXnoibJcAs9UfBnY3n0JIzkLF80WqO8OCK7CVOKHLNG5ezuNvxai8ZrOjdbksmnhPjYX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255515; c=relaxed/simple;
	bh=ubT5vn54CRe2ToVp8tIuALMRVYAPqdHYqwRYdXAJqIY=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=mL2pTZWfELQxGYBVZxUDnDpS/ABDJqJfuYK9IgyWj1VAJEEfy/rJ8+u1QrJkK4xckmoVwKPIuU0Aj2MEANnnBnCXImMoTRfrhqueJrO7vc7VdXeSuxsBjC18mULnM2n8rlDbpDj49OQm/Q+sWLmnrAjQCSNcolT4J7GF5nQODnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oxuL0ijv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CpnRB5Ei; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4210hol3012335;
	Fri, 1 Mar 2024 01:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=5Gf+aWGTNupAuj13n8eWQRuRG2xV+UXF8r0lKE8BlQM=;
 b=oxuL0ijvVYsyk5aPrXjOxvn6Nk5au3bwhb/5SzwOAuXA09f1+H1zI8x2ef5dpUMx+6+V
 cS8hE4bQx5HXP0IPlk0vj+qEGNUqMUWq3lFkYw5gl/LjW1VgCZnw5XOUvCAiOx5c0lhn
 NBxVmAeq1TGjyz2hpesaTpF0pGVBZ+82pnWAgzogEAbFspkd8RUG1awXMSTZu/tyc/bS
 A48B18fZ8BiVILNOdcsUo2ClX0IF925ZGl5KTukxGgLvCgqPJ4cZlR5kA6o+Q9FtHjox
 rIFP5CsGrUW8FQTLIHk3+m05Nh8NAtYRO0ehgqJ5dsuYsJxdpDW6CUxrFXr/BBQOEUWn 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdqgya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:11:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4210mtUF022341;
	Fri, 1 Mar 2024 01:11:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wbty6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 01:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRkLFiCHKUPV63+0gXUAQRLBjAHKAQZ97RHIt9YjP0sCgQiyujVJm/4jEuwJh7rET42VCVq1zmxn7XLhZ7PW1b8gf6GiN81L9OUutf+Yi2ajCLmiL+jl2MUfmzkbItpdZx5WWvgdKIytpXhUN3VhUhK7T9UQll8QnY+xgVUWe1ys/syGjbIRsE1aZK2adRWDh/gf7THaNjvVgXPKpqfMIdIefHMzg/sdEihAAuxgntnFhEIRx1JQ90n/A/jiMrxMohk/r8ss5F8J+Dhh4lxdbAkqRRJuAxqwi0YGMwnwfkcqvGt3rJ/dXDIQmowIIVIh1amICBZS0HB907jJ5zsYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gf+aWGTNupAuj13n8eWQRuRG2xV+UXF8r0lKE8BlQM=;
 b=Amp32RcO8HFMaIGgnYpWIWfJ5dssWER4DDMolouG2eGVtxBR65GIiTHZvsVEOcKJ543sU06Gn9dzGjEtYmF+uwMAT4VGGyUyu4SyHO7tF+8y+60YTkMwMS9dGKLOdOg8xOz3arSizHevK9UmVyen8tHXKMWs0hZH/PZdYfFCuPvHeisrnqU9xlixNtaz5CIKWaRN5rkCnxlhFj5m1J86SwV8wyGdBlGVjbMzBFNmfyQaqKwrGV/AdMvs7rkdUdXL0OpW7KuL9uQMiYq+0XsrPr/fsXx2w0pdVN6jpdVQzVv0Z2x0w2yZ6xN+fJyrz4NwdRuTcfwI7J2bkn5pFvVmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gf+aWGTNupAuj13n8eWQRuRG2xV+UXF8r0lKE8BlQM=;
 b=CpnRB5EiV8FrkQLhk82TGI9NiNioX2RkjU8Lr7BMcDLfsEQ+abJq3UxbEDJ3msd2eO7RcfrCAuTdJPR5JUs8zmA9taOSFfYa/upmUarj0OTBDkx2ye7NjEx7tIDxobUKPaX5phb8U3m8hAfJYY7y54nxOBD3eBBaSoO9iY7nrSU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Fri, 1 Mar
 2024 01:11:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 01:11:37 +0000
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        syzbot
 <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
        bvanassche@acm.org, emilne@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, martin.petersen@oracle.com,
        nogikh@google.com, syzkaller-bugs@googlegroups.com, tasos@tasossah.com,
        usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH] USB: usb-storage: Prevent divide-by-0 error in
 isd200_ata_command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1frxazrgx.fsf@ca-mkp.ca.oracle.com>
References: <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
	<000000000000102fe606127a67f6@google.com>
	<b1e605ea-333f-4ac0-9511-da04f411763e@rowland.harvard.edu>
Date: Thu, 29 Feb 2024 20:11:35 -0500
In-Reply-To: <b1e605ea-333f-4ac0-9511-da04f411763e@rowland.harvard.edu> (Alan
	Stern's message of "Thu, 29 Feb 2024 14:30:06 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4ddcb8-9a4f-48a7-bce5-08dc398c8b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v150zFjdMrCjtwMWZhWdcMUB/VKLHk/8JW9ngj/hikX32/yk/nFtY/rcvPh4K1lbJ5C9PoysrFzG/DumxFJH2xDUJax24bhudYbwvkmSrwcjJWyOYc8ialhBzH3f8rgm2Rk2H7ZuYTp7avWJJZ/7FqxFCJeGn8IZW6K4Fii9iIgsYkDxzSqMTVJGsy2Nfq32bqIxoOiBF0+wqugN5h5nEjzee/2n1bn66MFVljh+eBHKyTgCEiUckxqgjLbeavwOgeGuWOabONwvN9hiHEn0FjPtzehzj6o/XQfyyjKa/WCpYbPk8dMFc/ytbdNs31LrPsy6TNFG+RFDCnmE5yOKUpoUT+XhykmTXR2Ew1ipvsj0TsXYn/Gog92FK47DTHnR2Fuoqe2b3tXxGrnQktvik9BejaVmr3q6wWrqMVcbOgJFjFXkLQx4KNVPkXaQGFHQNjM1H1nwtFkahQTHar5dBiLyTU5vmdeMuXu2kmKtlMpi09sni4DYeP0S3jdrfRN0tsNwmyo4NjYVyCXT1jBcfoa6moJeVkQH/sLf3jGnOIEpGK3KsSuwJbs39aYNNO/nB1WXA2Bg0tE6NVs+KMomCRFFKfZUliQxkxyuKdd/QJmB7bwwwgzIB+kXG34M3dorL9aHOFYWURPpJ+C/3evcOA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yy8ChXUUo5yDdR8xz+7ovcAxLZcuwU1+GDypOcktuVL+0AsGDdOm++1chCtb?=
 =?us-ascii?Q?8EaSTfrgWtIeTBMBTUjGMJw/IvXwgeEDaSK6YokdeSavFwCgyTO2lpnwpnQ3?=
 =?us-ascii?Q?VvyrKAvkllbcC7o5O4O7RDASxzm5YmhKwZl5e0IL5gLT2sUgLrOf8g0Z3BgO?=
 =?us-ascii?Q?LRiusQ9dCWGaJO43DYm8/tKt4bpmJz1v6JSztcEwPw1dv+o+Q8I5pLqmWDGe?=
 =?us-ascii?Q?RoffiOciVliFih1jHZzfts//y6aKLqywCns14XDYCbBg8rwvHQ0/ojxwEWYl?=
 =?us-ascii?Q?mBsZhRDOmIcSyzaEpogXJwzGGJBIf17HGnLXTgRiqIDrjJjEdexu2N3sdfjd?=
 =?us-ascii?Q?i5tiJnv0xike46OYnZtW5hRMXel/vHBsWZlelf+eZpVo54MsnVX1OXZr6Y1F?=
 =?us-ascii?Q?7cJN1KT2U89R/+7CMo7Hcyz/EvX4Kw/8vsfsHzZyNnajPs1AYFuZanfADQAD?=
 =?us-ascii?Q?S27GWJVgjM0pKFXPS/3mhpsEJYDdX5DzKlKTHs4+2m8nrKXMxnd60K9WvOjH?=
 =?us-ascii?Q?dR93nxGBD+M/c5KoAabDnX4L3iCdjSemHtsFhQnCSJESbHeZG1lfWLqfLr2o?=
 =?us-ascii?Q?VGYTdvSCAG2oxkypmAC1Wwgm+Ftz+e1DqtsNhjQtLLwk0OqE9KpO9AYmeNBc?=
 =?us-ascii?Q?4OslzsF6XeQeQ9x64wFLOUnHO0I+xc57EW3jfVp1ithKlRsJL3I7JtuiE1FN?=
 =?us-ascii?Q?14Pwh43j69taPPZg3bh/Hoso1dmhZYi/LmsuVvQ3r8lRROweX85qrqrNVbRA?=
 =?us-ascii?Q?Unu8Rib0ta7CWbQNeIVzMYfkJStGgrxYGKOTIc7nGe2FF5R4Metywb/wH6XX?=
 =?us-ascii?Q?RxsRHnRw3XtilWTmqaWc26bNxLA4dVL/aCS74rpXTaAVYcK4lQzVL4LHnL5m?=
 =?us-ascii?Q?aqT8Uucr3ZhOQ/t4Omr4c4d6O5DAkkWCAxwQvRhGRARXU3LjkI5RlmQAPInd?=
 =?us-ascii?Q?W6lsOSE/moALeNMMChgKKoZYT4UlMoFxUqFB164b5Kev5j+p6YrkoKAZJuDg?=
 =?us-ascii?Q?Obc/ZFMb7esxNSDD+b1uLG+hEUyd0eNCWzAjPCheBhG0l3nvQFoyKilx0nev?=
 =?us-ascii?Q?9YMs8cb5u3owQFXBX5UREGe5LbQR68s28YN7o2gVGLJcQkEYpVH29IDYkP7m?=
 =?us-ascii?Q?VMBoo9Z1b7hT+GtybEt3alDj/n+WgJRo3ULgakDe36QiWV23lDfVOr56LPTW?=
 =?us-ascii?Q?Bh+KihlhQv/5KnPi3gWZbFvAgoZNJHza9YHy2Eq4sHbB+vKZ1fzG0LuTHBSO?=
 =?us-ascii?Q?W9PLHLJD/iOSI0lhbeqFLVWNA4rFcg1YErWTX+SV6HDen2uR0jH6paAUaSrq?=
 =?us-ascii?Q?Ttotlmbn+cpIwgCuki6KA/2u3AV19GGrcymoBaB4nbKo8fW2MPU8H6eSCqJi?=
 =?us-ascii?Q?ABFRczezuB2C4B8Yt8v3UJIzVOQS4T3euEzwxWMJuaGqxIFNM+y6WZRZEAvD?=
 =?us-ascii?Q?4DwRvyCTv6QiezvpL2Ca6JP7u0kKiuI4O4rh1WHy1zINsnoWARbiPRCzub/e?=
 =?us-ascii?Q?rqec+JKqlEkMk3SmdcD7Bvn6CQuNEM9BO/kcPXDGHDm3GF03jTtha7OEDe99?=
 =?us-ascii?Q?H/1KgBDBECykAN7/Ld9LrxYWzq79y1PrwZDmf/4kW+k4ImpdXUQ0hGyOKQAQ?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TfSO8SgLuMVCULvgjOC9f0teWjUKOvkOcXJIpbSsGNH+ml4SD4twMxVZk39CEckFPZLmb5nTYRZfUVPnXMpMuwHoTYIGBvJd/jwK7ZxGufk5YTDsWQsHd2PtKXS+pZJ+pPni7bd3k1jqu5SjUqyq8mRiNO/sy3IsjhnWmuounv/8GP1TlxcdMh2Z52/wtzP7YGNEZeAJsbILiscmkkC6wx6JQ5dsNPGU6iLddD/3E5gG/fJb8nM44n7Xs7fGkvCJfZad7tQdKHoxvEdQcwgmSOZ/9PK1Hcy8xs47OUNOWtoIaS/S7/oblcGZX8RYVnS9wOC7X22Dvqytin28YM7hlwcnU9aHaDQklV8aEIus/up8ljTXJy34PHOq0ZmZJVoCEpDwzpKhMIyAJOfvtvFNAsjYnibKLMx7DutN5TZC03R16GaQlkiiZ4/cJadw7Gp6gWsbvz32l+sn7pqQaVeQtLAf90rSILzdFZ8hnq06R/JVbUmvStU/CxK+r+RM2ikTSp/XPByxDJAFrXi0c4Ok3S5va/ghqLySYqGU2GNYgmx5h1tBC8wPuXGOvtV8AFyvs4Qs46swnaspDAgdOBi9XIwR5izl4/Q9QazWBnzmM0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4ddcb8-9a4f-48a7-bce5-08dc398c8b65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:11:37.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBV5JodMi1uYUFpmDzqDTxafZdhteBhIad+lMjp4UjdjV7JZkyxxjYkvwcv2wOKewS/7i0kNYdzjh4HEP6ULxlnfk+KVD+Quop0czYOJt1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_07,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010008
X-Proofpoint-ORIG-GUID: rcESslzUhW-pClFl5dDdAd7yMk7Hx6Dy
X-Proofpoint-GUID: rcESslzUhW-pClFl5dDdAd7yMk7Hx6Dy


Alan,

> The isd200 sub-driver in usb-storage uses the HEADS and SECTORS values
> in the ATA ID information to calculate cylinder and head values when
> creating a CDB for READ or WRITE commands. The calculation involves
> division and modulus operations, which will cause a crash if either of
> these values is 0. While this never happens with a genuine device, it
> could happen with a flawed or subversive emulation, as reported by the
> syzbot fuzzer.

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

