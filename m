Return-Path: <linux-kernel+bounces-149362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72C8A9016
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F11F221C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBB5244;
	Thu, 18 Apr 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQTzRdaE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="USyE8ZrM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E3817;
	Thu, 18 Apr 2024 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400554; cv=fail; b=P7j7ReyZ6RsIRq0uSmcEgxcx7PQf7/I3SSOcbGjj/wbqkbeCUCEmDfSU0rmXgTOFUzr0GQg9Yux6Vj4GdS5qHj6AoI2Ojao4qwzF+ZSWmUiMfvQWrHMeAC834pqHy2XBmjKV7n45xF5ymagbpawaUEznMiDXazp1WWh6A8it/nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400554; c=relaxed/simple;
	bh=6YmkxSwLoJSBnhNAO20+fvIOZLassIb9K9oGnL4BQ58=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=axZm/Co4ef+hErohWn3iOBuWBvAiLcgTPb9gnZf7M84Zi/2awbW8HNy3vlSZ/+hPiOJ7SSDMuG4GMMaCdP9hXFYHgKGEV30kR3msGPbEmXSgvXTxG1f/j2ecdIHrTE+3ACreOj5iVp2nrfYRtr/bQewz9iJ3iEoJgdcQYkCBnKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQTzRdaE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=USyE8ZrM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HM4UD1009525;
	Thu, 18 Apr 2024 00:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=PnkEoeGPhR8cjo+FyybQq7dk8DAh/0EuTSqvxNic2PY=;
 b=gQTzRdaEhUPOpFto6F+3OgDjM4fXdlesiBZoMFQaV/D0PKXIXWRjBdl4aemxIVkOJwjV
 zv92//oElqOmgzllU4JTTzmXpnWZN8Om/LqeswgPFtSxPcb2N0oxz/s4qG5MUuV43Xfy
 Ugi1LMrJT5cpg79Dp+UPUPiCfudJgSnF/6abw/kXjSxmtwwF8rZLc/kyTxQCj0B3XOi8
 MU6pb6LmiaWLof3iaM0oVPkfWODMhsTt9ub8LE38W7SKGcjINBhM4kSzY+nxIbHWn9zE
 Dbf97lMDmD7AGiIU+6DcFP5icx1z6GwyLQpsIM5L3zm0M2A2IAZvtzcjc1NxaSXLWSxH CA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv94xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 00:35:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I0Xx4F005105;
	Thu, 18 Apr 2024 00:35:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggfwj3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 00:35:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWUWdA7+Tf6fg/76z3q+2q2JRkTRs2SGwmARPI1jVfrwLOxesRjumvVpM69n/bdtMPfGRueS8jJLPkZiBpGgxOaUPpSllrS/eDOUE9Xo/2itQ0kXNyWAsXJYZ1XsVMdWZVny0HT0Moa9vhZvZUrg7p4jLPoaylgnAMW//WIcI+n+a8NCobEwRliGRfwvkkNxiyNlFP/ywFvTZrbAu95FkpvUOQs2OkcRm6yf4h8l/pNByGFpIQJbS2OyS43T/rZGW5kz6dKnKuKM4N5gmFW3WIhp7joT25gVzjI7ETtoXST8zlVAndBZAhqDG82C7lry6yGZuj2LU8tHrsqBU9uslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnkEoeGPhR8cjo+FyybQq7dk8DAh/0EuTSqvxNic2PY=;
 b=iGUwBZait869Mu21gk1ZUcPiOpCdHuRnY5jYZtC0PMTa+Bba+ewtQvI7OPj55FDMyId2pKnIp3YIen2+Xu+QCO42lS4YVF3xj9YcQZ4STFbbugiFH3fY7+U/CiXVgIfmaOCXT/kQ+RS32t3osvg49yXXd26JKMYdBGhIMWpmL6nrbVuNP6Me+qM5IpU2JjKo4WLsK6q4sGmmAklUKyWBhykVg2sr4CoMEhwKcwzXYou1U3Q3c7Iq4ciPY+hdMZNX8Y+zkxoPlL6esNGnnlh4DFNd9auLU/E/1G6JyEw/QewXvTsRyKmK8M0U4aI/Dm/Uc1/TYo/r8iVpevInbAV9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnkEoeGPhR8cjo+FyybQq7dk8DAh/0EuTSqvxNic2PY=;
 b=USyE8ZrM5PAZK1UFBlDfuD0IJIXFsb5esxSA9KGfI61y35xdDFQCaDdb2bxuzS6vsi4yJGK1x9b0GjPSx1X2EiFoNgzwN2wKogEBMGDLFO0M0CGa2YGeN1Q1Buxqat+DWdhr9k8rFcWJAgQrlt2SnGsKv5pj51zDSFt1bbahTno=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 00:35:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Thu, 18 Apr 2024
 00:35:17 +0000
To: Kees Cook <keescook@chromium.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Charles Bertsch
 <cbertsch@cox.net>,
        Justin Stitt <justinstitt@google.com>,
        Bart Van
 Assche <bvanassche@acm.org>,
        Andy Shevchenko <andy@kernel.org>,
        Sathya
 Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
 <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit
 Saxena <sumit.saxena@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Himanshu Madhani
 <himanshu.madhani@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/5] scsi: Avoid possible run-time warning with long
 manufacturer strings
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <202404171035.BDFF28D@keescook> (Kees Cook's message of "Wed, 17
	Apr 2024 10:35:47 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ttjzecfv.fsf@ca-mkp.ca.oracle.com>
References: <20240410021833.work.750-kees@kernel.org>
	<202404171035.BDFF28D@keescook>
Date: Wed, 17 Apr 2024 20:35:15 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 619584b9-1c4b-4524-35e8-08dc5f3f6b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Rm9+TOT/KHBeHg01AiYucuh+q0sntqOeRrzK1oHD8Bki7aueBotXg5GBCE5o/aH5aWM2aV2+cJxoRuZ09b+Wa3CevLvI504IIo5UIyENK4PKC4hkGN5yLY+TWJG4GtfTp/YJK3rjhTazwD1Ql3JXVyYsWG/5xtLLmfwUzOFBW1VvueNx2KYtZvoeHQ8BHSMzpK8K3c9/+ddaVbOYQ3z1mgI3ybdI5MGh4qxtiuIaXqL8XzA0CUrV7R72jfcTRB/y3Sf++SG9jsAc/cV/zVQ1RbZRyQHPC6m7YO3Q3UjRhAfZzB+j7SzTyjmH9zlmdxRenZGNQu7L9OsZ06GCOO8I+oLEdaVdEMuPp9S0P2O4x1tRZELUVuVaR+w5qDH2h5H5qNO0iIqgLQBfnc0WHObZ3CuW2SvpvEuDQeIzcPiapeZ8MObQNrDg9FqCl9LjUlvg9EEFkFm8KP60MqckI5fLRHJm6xF5osO48NbtTdbRUsgWHLbbPfaKw+kBiF9xxdMA1+NdLKv3WxlOMSb0+GapMJtLuZIKmMt+IDSmzP245Zk0zHvLI6uPp9eyk6To1JYYdYVJmzOCk5RGfluLz6pgTfZ2MUI8nqs49zQF0nNUYtqM6sN+kXfAdegJ537C9OtvIz3ceMCVvPaLiilNyw3y6MHHQlTJPQSbRjEMu8fNxuAS0TTM6nMTyAP0MLAxUvrSeLXWC1WbKqlfW9yw3H3g0Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ygyUvnhsnjf6+Wrjts9YueOOaBd1qVvSTSaxY3Fv6jNXTpwTmXbG8ImIlvCA?=
 =?us-ascii?Q?ZFtRh8s5PZ79hsgSxevo5RaRFuJ8IBahsCvheJ2wBMde/hgYhaMlZWk9YG8T?=
 =?us-ascii?Q?XH6OOCL6wvjqF2i99G6EpndHOiFNQ1zKxjAsxnCLg8vQc6eVXMWJQIj4abIx?=
 =?us-ascii?Q?IQqb2l0Dw76zMJw3CEKg6pyPdv0hFJLmw/nEkYXOmyt9rS8dBVpwe82bJjZT?=
 =?us-ascii?Q?nn2qxpX2S1G1hWBfdZmoFvMFw8xekZIUOqEcUY0k3ALWCwOzuHmovk0F89Dg?=
 =?us-ascii?Q?RJHi3iB+4Eccktf+u97eQsuDnWp6nz1m0MPPEWPNVdNuXUQH0GiNsUomy7ea?=
 =?us-ascii?Q?7QKEoIduwOfaYVZkg96e/ffAMc9tewM7OehhXGNWYixw+l5dQyjFpQbm7KIO?=
 =?us-ascii?Q?gVPrO7SlROUHzXMzxrErJbJ/rcna1jzMmrVXigm5c9Af3NeEqcJ1w7MhxF9x?=
 =?us-ascii?Q?APi4zw9d3D0+ctz+SvqsF8S/DUn37HigUzU5dQu9XrUigME6TntJ95ICagtD?=
 =?us-ascii?Q?W1oGHaICFxuu4bzKycETZ0ikj8DKfFGX9Lvcb58aO1FfMoa85f69u3x8K/Ph?=
 =?us-ascii?Q?9Y1ks9ORD3W7elQ7PkPvFDh6uCi2AN5lQWrAsR63jikNcXBJ04+y9YbOEj1i?=
 =?us-ascii?Q?/6/SRvQCJ5AoS5zf85/t2YR1yg1bpHDAEZm8tW3N5KFNLiKOuGgcFF7UNLO4?=
 =?us-ascii?Q?wvgNkl9itK7MjNY8FvepRJjNEH1/GgDoF+6oKS1Uw4yAX6qQkqnRRLXeS3x+?=
 =?us-ascii?Q?5PSeAc5okPYv53Sm6mj6fIEswj8jUO/4o0z+OaHxZzBKksm4fDuZc6290Wg4?=
 =?us-ascii?Q?choT+5n5uMqGnUYOvJ/AhNNmLFITCrA9BdNMl825ZTul5jj9tVYu3yPYcXnK?=
 =?us-ascii?Q?4rZINL0J9uf5TJN9zE1TfwWb2d/rDaMgnm7yCXNzlLW6ClRcj6eqEs7qmLu9?=
 =?us-ascii?Q?J12pLqJXwtyjrEk0HT2V3271zNtOiKpDDCIyCsHBZx/sydsyg6qj91/KeO2w?=
 =?us-ascii?Q?Oo5o97ZsbAqztLmWyFv7DsKXhR2KOY8kLiGf11DkB9uSXJdvtUVeFAi/x1+R?=
 =?us-ascii?Q?9FZW1D+zHfHjmsaPBop4ktYzQZ2MmMs022EH8i42N27Pyw9EMuy8ImEzoB8h?=
 =?us-ascii?Q?7QjbiMqpmkSGkbS8OM16LeUhsv9ZvrVqprjZ0uvLlwdLLTYAPZgjk0xjiNoa?=
 =?us-ascii?Q?7o8MClt1lhQywGtNsofPaTqUy3ctuDy8zXHBgZkac4sAXSFRa4saMFJNDbSM?=
 =?us-ascii?Q?b25e2YSwE1KxXkGgZ+vMGY3tMlAg6W93IIAi1exXrkneqBOVfV2OdcDiQMaw?=
 =?us-ascii?Q?pljx6ee0/zCYZ29iZ4mpk2A2rkjboeVZ5TvdaGkR5y4ypyHUI+tDrPimNuaz?=
 =?us-ascii?Q?918vZbHe/7yl6CldkE6WjYV0yGdHYP449Rbbgiy8BVG9veAHEIRxx26utIce?=
 =?us-ascii?Q?9+GuarBZZlDMs4eN/ndIk8NIPK3ltrWvHoy//HIX1axNDZOkTjXVTXoOUbsI?=
 =?us-ascii?Q?d08QNe7K+XlpTjGb8TzXhAz88ByymQ3V7tHZH91tnmWZBu/MM7+7RcffkBW5?=
 =?us-ascii?Q?p3yFUyTpaXXC0CRO+QpO5r96eafCxoItAaXR8btIt8VsqgZhvNDC7exopxY/?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qk1MbkqVsmp/dJRCQmCVoWGdQWFrijRhIujXrnzuhNV++yTQM08NAuLz/UP28K1HF7+ZGrDEYkjHn5My7V8yzrEly5T6o8VqmGDTekayok2o8YUihkXXvjUQTfvMcXuPXr97U+ogED/NB83+4Pxk0uw5jOJMwBY7TGCYOa6Q8ipNp+0JCZNdrVfHee3QKKeH0Sf0DBSZT7oPWZvljAWqUy/JKfq1KN9z6/wRzEx1SbnvVenOVODpLrGPUnU3LcO/1KCGNieJOKh38bAKKTtoexQKmHE/e9HbBI65lI1ylTrtgb0Yl2FOqCcrcPyrbvQEWnjqTXZAKFw/GhXI5/GeHkQxHX+ZnIETl5myyZ7tOsDxLfbsEqq+h7KVhR/MkLF8vFcs4fhLuXB17bw4pn6ugGScH3B0IT7iGQmb/D0yzuqrVzcosYJB8YF4delRTP+dwakHaEFfYibIvbW0p7mdXd5/LGptJaGvatjdoYuczCNzDMPrgmvePIjcbiq9TqJlV10h/4N6NE2Qjzc4SvKVXUSXbEsKNcGzL9rgF4EqVkhVo16wpur+KJ7f4k9wqOHSlPnRA78zJe0tAALyK4pGclkPChDqiytPxAGgCbtV1/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619584b9-1c4b-4524-35e8-08dc5f3f6b92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 00:35:17.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yent+Lnk/ptArS2LEK5ZeZF8REwHonJ6eo6rmZwaYCmVaYGZ3kNX3nY466j2twPlVZllzP7kpCHg/vMNPqysIgpPpBmBCJcBruP1pggYpvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=931 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180002
X-Proofpoint-ORIG-GUID: zSnjforsdS7HmlhjS64SI92nzOe1g723
X-Proofpoint-GUID: zSnjforsdS7HmlhjS64SI92nzOe1g723


Hi Kees!

>> This series fixes all 4 of the instances I could find in the SCSI
>> subsystem.
>
> Friendly ping. Can the SCSI tree pick this up, or should I take it
> through the hardening tree?

It's on my list of series to review. Have a couple of fires going right
now.

-- 
Martin K. Petersen	Oracle Linux Engineering

