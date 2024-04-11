Return-Path: <linux-kernel+bounces-141389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E44E8A1D98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8881F25B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA71E793D;
	Thu, 11 Apr 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9CbdXB7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bYwLSJor"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FF1E7948
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855628; cv=fail; b=N47mYTBXezpeHzw6H46RigYY2GfLbvkGdkSZma9MRIUezAfazbd3qZb7CzkE1MbQby86W/0ZRtn0lhJq6CJpwWA9NU4lRrEEUtoFy+Ct82ub9woY/cvfyNYKG0FdXmrrfp8BpMiQkonwZPKiF3Ifs307LGphM+Pkf4c6UkD39b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855628; c=relaxed/simple;
	bh=rskj3K81tw8x9duuLUalHxMUhxU71xvR5brEGbcWvfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ObM4YPsVolgS5wPuB1MElspC85j4QS0u75lkV3HE0x0uETrr3R+1nP4EUawTbhxpHaH7EU+L15TClWemAmKFNkULhHFRRU7bNjEC+l12pLeZ/ssM4vGisA71RFwF8Et6ZzFIqEk3/fOnJ8ZE3Yld3opxzh3ijMtogluSr1zZsNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9CbdXB7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bYwLSJor; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BH3CqA008766;
	Thu, 11 Apr 2024 17:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=QMmvnWhaYla5tId2DAPugC+ta8u2qjMfiq7ZG6F4nas=;
 b=m9CbdXB7LX59jEOqWdsS80vQceXCIADr8oGpVhgrn1G5+KIntAld3JaiofiR/YmfxXup
 CBMHkNui9cvH8QjPruKBVNlDC1ZYL9qDY2Bf7nOT4b8DcOx97x/9bcfx16jCb86IMUfe
 ys2o2ZPADuz/8MJxZ1Vc0s1WukHO53h46MH/A8sz5LvlyD1/8M9IrPt6S41MNdBKoCvu
 XVPYplBW1uWR3c6MQTgOWi+aZh49jXQY1kA/rvVXgfukZyOuWmmrY8LWHMtlc+PiMS/P
 EIrXYmieN+g6KTcSTOpr9adwl+GocDqiUfxo0OgC+k468hJI5+nVRpFDYIAaejHdNsNK OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawact5fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:13:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGF9eN010535;
	Thu, 11 Apr 2024 17:13:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu9twyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 17:13:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQI3Lcuqcg7zTBJtjIYA4O5DtENhcBbnfUyAYAuspgSc7bTNdhAJwTyALfiCieaC3YFleb7Hvir9hI8y+Ty7/RD/CFD76dpqAw26RAZHUDb9fYhscMVAJr/USdOmN9kBIVvEObvAn6XgvaBmmN9gXAl1oWVi8l9YAHCIiWXxKRMK+b5Q/AeUCzMxyLQ0qUCjGt4AstMszKAcKka6lDqH2Z0NqxcmlaIrbhwBGGY/YigubtsoRWrP3BmCmLzJoBsrL/xtc7dexrdoKLihMTMIj/Y5Hi3kXC9Ycm1HR3LxXHXHVM9fWVTsNuehUcBTueb/4GlGzR4uVLoZZt3CY0St5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMmvnWhaYla5tId2DAPugC+ta8u2qjMfiq7ZG6F4nas=;
 b=FvuTc2uICfYCGMAOr7VrcYPAjdGlFD1dZq7vj8kqUTmakUYOu98vWrpsxRFcAwA75B3UiTOW5B9MQmeJji18EWKSkgkJ2JXNriS8hFbZ+3o/mO6ErCqSdWWPc0UdjPpfeeA3c0Q1d8XVwsIXp98wSDvaeOiHeWwoGf8XATTolizRJQry+Hp/d6jJ62eG1sqTSDFLK+4BIxjkK3GGdLdSSJoOlNnudilqzCLex3jLcZU/CRbeoFoTVywgg0uQUk+YVOypDw4stT734LSfa7jR1sF1FNvO31DVWvOpLkcaTe9jfCTcZKCJ3FsKtCnEDii1rhgTvLCGDvKkiraWcASx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMmvnWhaYla5tId2DAPugC+ta8u2qjMfiq7ZG6F4nas=;
 b=bYwLSJorLQ3WHeop6xVUFj/jFE0KmQXcmCU8WfM5STfDsDgo1BtmB6EC/nt7V4nTa6dOey37ewNh5Xox1b+TuD9ZHgP6AXw4BwVXpQb9ayb/RnVYEfP6+bUotG3xKl0+Mmlgd4u/KEX9BG5WtGi1P1OoF/6lrGd3vpcovruT/Hw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB6947.namprd10.prod.outlook.com (2603:10b6:8:145::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:13:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 17:13:20 +0000
Date: Thu, 11 Apr 2024 13:13:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <20240411171319.almhz23xulg4f7op@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
References: <20240410170621.2011171-1-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410170621.2011171-1-peterx@redhat.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: cddcc3b3-76f2-4388-0a96-08dc5a4ab011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U058j8hWlWVtADy75DOEYuyUekFw5KXb6ttvVim2REEBEo4/zTVreeIqMO1gzD4IknN64lakWA1HIBtJGyJqx2ch0dhfwJ+evBpcUUluZb1wBrRWYqc8V2NDe+5fa2SBTHm2trPEyW3G6Hg+tHXal1i6Gv9p02QX2Edk0URuwksmZyopSnjlAY+Lw9KPkAfjtcD978gnJj0h9yWeARiNheAku6f7ELKDvaDtRQJZRs0YNfzM7y9lYv5N1X5eK8ggujWDqr3WaYGV+x01MGg+6qVO8Kfn/bK57D2Tw/zte3dZyKdrEG86k4oHJ+OBFIrzYvId7oq67//Ihmc29YltjSuS6BmaSj6Iuuhgl2ciWBn6YhwYMlBFj047hrJrP48Yf+BgB+xQWM2UZWECC9agxNL+wwYFypFkr43pTG8fDhPVkLlm2SXX9ka9Nsb2jWNqWSp5d4z+MQ4biFifKmj9BRetJzI9cH9wS2ivhVMU138GU3BJRedFVyT4AgPTD/noeR4orp3H5P26NdA73+DfBL+lybNsOv3anzYXgVN1MJyPbFSBnR9VAcoFV1UEPST0Om7eDdxo01Vu+EY+vdtCOp0oC0hAdGqtj1e/pFEOYGxDbJMt7BUodjorN53c9ZrNdLFd/TNTErfxzGX+kwg6KtX6lW6S91V+1dB7DOrHc7Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZQgQUSJh1fkQ+FUwmj/riZDKg5TNCgoPdu+//JYbc/LuJURWJhwqTvDG21hD?=
 =?us-ascii?Q?7fJan2L9nb38DezJnNuxWDt10jCNiqGQUpuoAwXO00Rxlp2rN1+5QqZyh7Wg?=
 =?us-ascii?Q?CEWd8EJhYErC+r3hQ1Q//r2qg6pEw43HOGqogagaYqtOb/3mivFZUYvpebUZ?=
 =?us-ascii?Q?D9IAfb+SE53IAEBl/QBNukWEZ/Dti2zzkTolekEF9Dy9ulyY82sUq1Rcg4yh?=
 =?us-ascii?Q?TGXS8Utg84Sd3KzAZjYpXEPWYdcs2BhQ9n3Wh449hhYWBPS62Btt75XT7zya?=
 =?us-ascii?Q?X+cXYeny0NewfxLrHmZNa3oq1p1Npzxwfy1POja1ss5LT0/d5MMN6EjWUedE?=
 =?us-ascii?Q?/XraZj3sj5t5z724f5ImnZrjfvkV/pMaVYy5lNJmx6crQOCW+K53ah7Vq8nj?=
 =?us-ascii?Q?uLq3+m18ic93U2Q3K3WahzMWuD0+H0UorZ5t820LbG5HxRPtuxVIiDW69/+2?=
 =?us-ascii?Q?BT6c70wQGoiHp/BCs64Hs2bTBpEqNbgrfT6CYO6+i5rOvGhL50uioNLlSZPf?=
 =?us-ascii?Q?ZT1A7ErgB+zuAvLpkR5/yLy6a+e9mkIsMsBoLECygbyFIJ+PAZf9I/iWv7UI?=
 =?us-ascii?Q?a15MV6x1yleKSejPNRJZRtIFKANtHIXkpyfoZqLY3CEkRKZS8SACwKNgfdsv?=
 =?us-ascii?Q?KQSMVs2Sk0AUc3JYSTJo+q2nm3JnblDCXF2QaF25Gko5PLw3ryBCc1cdR2cR?=
 =?us-ascii?Q?rMX2D7kRvHTohIJvFPHm+FvFnElUZkkbdqewa5PlSep0G42s7uWOUvIS2qrg?=
 =?us-ascii?Q?ReYoozC9YFgI8BpkrWAug6sGIg5VXFP+GcH/fpQOTxHBInldcPHcGHr92613?=
 =?us-ascii?Q?GycJqUhn9Drs/f6ssx/ESARjnmmDY44AFOU8vpxmKfqrGFDPUn+/SHProbA7?=
 =?us-ascii?Q?9xdKMiLLMlh2tCHWeGgQh0iR+XG1Okpy6wIsMu1Di6NpYAOU1zrlPhyTjedK?=
 =?us-ascii?Q?N0gF1xfQanCPHh/6uBfJPZ5VC5V3SIbQvUnjnl6OZW6w70A3h9MgYlrkWmIp?=
 =?us-ascii?Q?MUOWHf5Y/P4Co4A8MAnal4quCBrDB52vH/tLSCLuyNa9Lze0TBkK0JHuitkj?=
 =?us-ascii?Q?M8BrJhKhJrZMIuil7d/omzepZPeTu7QtDTzucsjtg9nzSUKd304RV2FqU2MJ?=
 =?us-ascii?Q?PyfZsbOLUssYaZ/C/OGTTgYjez00zOV1ZAVB5FgjffI8KtMYzCctvwmK0X0i?=
 =?us-ascii?Q?Y0g6Lt+qsLpNVFH+FJb1qHFZqDUEzr44iS+n/5qYebNS0SU+6DYS7JBzeuK6?=
 =?us-ascii?Q?UKL2EgWy2FNRtld5I7qb81DYZdrAKSZiUEhzpOdKdkaDeUZL1neEP2zAQVUB?=
 =?us-ascii?Q?ZAlC9Hf4xvz0FzpyOrC75JUiGyRq6KmPkTPgRALwI8TEOzIFS7bo7bkfYGC9?=
 =?us-ascii?Q?H/JNY0TxtfljHMhYR+NcQRShvxYnrgRQKXH8lQptCnE8SqWk5vPzZ082sWwd?=
 =?us-ascii?Q?3VZSsStQSQu2O5N1NwnbiP5jjLdrUONoOUaHRo40cKMwq2DDXp1vihmH2Awz?=
 =?us-ascii?Q?dKh7LaR0Mqsn1sDsI6S7Z8Aqp+chNEyXhBgX15ktbFkVzogI5+QGcEk7HtqQ?=
 =?us-ascii?Q?r2VM+m6rMyyK1+G5PTxANjNGI0m+KTjURf6TtcPS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+9IqSoN6QQrEQDffCaJ8KL6KKHgKbDvA3uhSzsGSc7znQgV9CUZPqXRk013OID6Bj0gl1PluWgc1wzVbPTA0akJeXh4cH3WjOvIyBdekko87mJCBWRCoHaGsqRrFLksHOw12qrbtNFUSicn+Gh/q8lDccpzez/GSBYXE3vjRn3b8vZMB4RHXhJW+i8lFKTCS0cB3b/KrmIr7e7+LzyVjgsJrN5x9bDPTBDA1Qp6xPibPQjTe32MqAKQHLx6fCkVrnHvIGyD4Iy7SKrF9lHY0nk2jfBqWMVdPnoVdfxGeipGLDV6Pb7WSIxylX0wUL7c5afLTPde3my1NpGYRKoGZTnUpgcJCc2o5p1y9VK4174r6xTU8e7x+DLxWOAHGJnI8lyTiM/hk7kPam8KEu6pPmnsIjLuCeTdhsC8ZPSFzJf3cGsx1uXlHO3sdbxDRRAFNFijKmTHh9HAggaTlJkrfQ6h8+ls7+ky5cXp3OXmktNJqFnt9pbHh23x2ZskKIZp1gLHTWtatHDO4pLpPhH4Pomqojl09ZM1L+ffIQkhTljddF+69cjMVIazza0emK7csQ8YpWjqbczLVXz/KDvNk7Dv5juoP81wcKXRWaUxTCiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddcc3b3-76f2-4388-0a96-08dc5a4ab011
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:13:20.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moc3JOry8qN4Vf/d50VMVBCoSmw7DibUlzexPrAP1cqf5guSfp40P2lJ6VLFpUaZfFzCb5RREnB92O1zSWY14g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110125
X-Proofpoint-GUID: 2f1RwA5d_hzliCM1aolTaP_JjjaIDKGt
X-Proofpoint-ORIG-GUID: 2f1RwA5d_hzliCM1aolTaP_JjjaIDKGt

* Peter Xu <peterx@redhat.com> [240410 13:06]:
> anon_vma is a tricky object in the context of per-vma lock, because it's
> racy to modify it in that context and mmap lock is needed if it's not
> stable yet.

How is it racy in your view?  There isn't a way to get in a situation
where its state isn't certain, is there?

> 
> So far there are three places that sanity checks anon_vma for that:
> 
>   - lock_vma_under_rcu(): this is the major entrance of per-vma lock, where
>     we have taken care of anon memory v.s. potential anon_vma allocations.

Well, not exactly.  Single vma faults vs potential modifications beyond
one vma (including uses of adjacent vmas with anon_vmas)

> 
>   - lock_vma(): even if it looks so generic as an API, it's only used in
>     userfaultfd context to leverage per-vma locks.  It does extra check
>     over MAP_PRIVATE file mappings for the same anon_vma issue.

This static function is in mm/userfaultfd so, yes, it's not generic -
the name is generic, but I didn't see a reason to hold up the patch for
a static name that is descriptive.  It's static so I'm not concerned
about usage growing.

I would expect such a check will eventually need to be moved to common
code, and then potentially change the name to something more
descriptive.  This seems premature with a single user though.

> 
>   - vmf_anon_prepare(): it works for private file mapping faults just like
>     what lock_vma() wanted to cover above.  One trivial difference is in
>     some extremely corner case, the fault handler will still allow per-vma
>     fault to happen, like a READ on a privately mapped file.

What is happening here is that we are detecting when the virtual memory
space is stable vs when the vma is stable.  In some cases, when we need
to check prev/next, then we need to make sure the virtual memory space
is stable.  In other cases, the vma is all that matters to the operation
and so we can continue without stopping anyone else from modifying the
virtual memory space - that is, we are allowing writes in other areas.

> 
> The question is whether that's intended to make it as complicated.  Per my
> question in the thread, it is not intended, and Suren also seems to agree [1].
> 
> So the trivial side effect of such patch is:
> 
>   - We may do slightly better on the first WRITE of a private file mapping,
>   because we can retry earlier (in lock_vma_under_rcu(), rather than
>   vmf_anon_prepare() later).
> 
>   - We may always use mmap lock for the initial READs on a private file
>   mappings, while before this patch it _can_ (only when no WRITE ever
>   happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
>   read fault with per-vma lock.
> 
> Then noted that right after any WRITE the anon_vma will be stablized, then
> there will be no difference.

In my view, the anon_vma is always stable.  During a write it is
initialised.

>And I believe that should be the majority
> cases too; I also did try to run a program, writting to MAP_PRIVATE file
> memory (that I pre-headed in the page cache) and I can hardly measure a
> difference in performance.
> 
> Let's simply ignore all those trivial corner cases and unify the anon_vma
> check from three places into one.  I also didn't check the rest users of
> lock_vma_under_rcu(), where in a !fault context it could even fix something
> that used to race with private file mappings but I didn't check further.

This change will increase mmap semaphore contention.  I'd like to move
to a more common structured layout, but I think we need to find a way to
do this without failing the lock_vma_under_rcu() more frequently.  In
fact, we need to be looking for ways to make it fail less.

The UFFD code is more strict on what is acceptable for a per-vma lock
[1].  This user has a restriction that will decrease the benefits of the
per-vma lock, but we shouldn't make this case the common one.

As I'm sure you are aware, the page fault path is the most common path
for using per-vma locks and should minimize taking the mmap lock as much
as possible.

I don't think we should increase the lock contention to simplify the
code.

Thanks,
Liam

[1] https://lore.kernel.org/lkml/CAG48ez0AdTijvuh0xueg_spwNE9tVcPuvqT9WpvmtiNNudQFMw@mail.gmail.com/

