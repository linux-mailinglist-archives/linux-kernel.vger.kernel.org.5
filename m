Return-Path: <linux-kernel+bounces-100099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103598791C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797331F209AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CAB78679;
	Tue, 12 Mar 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dMayLCae";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j/v1ofui"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59878660;
	Tue, 12 Mar 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238694; cv=fail; b=IBGPO9odqZhJ/bo7ZDIketeUKba8pEZYgBEF017dEJe+qwenFmc63zvkG5qFl4/yPFhgM6idVSTnqFYhlok1uM3IVVL9w3xJ9bupDzdkGV0OuRGzinC39Nqr9EDT+G99k9eDpm2reuOTBZuJkwPg7ZWuy2oGhn66JzprUZzEuX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238694; c=relaxed/simple;
	bh=1oA3qJpCZmAbiu4drsJvp9iV/fzBHdEFiIFkLftq3OQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uT3T9hUkY3g/AHyilvHtF1NZ6bmkpi2ge8nnWZ6AQods4Li4g2R30wsfFpRRXm919VysiJDe09RJvYrdN4503DXvR2lYa089S4lS/TPk6zDG6V1MdbQYIqt+yK9xxFvHKZFO2Ve4wTGmQsZIyEhLvQEwTIMnQ8lQxnhYO5kGTKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dMayLCae; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j/v1ofui; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42C7ZSwu021790;
	Tue, 12 Mar 2024 10:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kjiFui7cizFtbCpps41NJdEuNKxB7AAyTPmrOY+7VEU=;
 b=dMayLCaeyVq4rE3T3te08sQGnYcszr3CupxBiPowensj89VcRdNdV69Jzl71LJQqm8RX
 mfHN6yw4GLzjPnEDLIm1jsq2FcjFuTmS85seMsPk2huDN5/fxxmFRYoh6jDCfK1q/VBL
 XrGNtvu3ktlqoEIZaFDpTmtkjMluSQnQpoDoscOmrEo84K8BYCaEGXadC+xH33LntXW9
 IEMbT/9dnAC/TFFRBT5YW5MMi3de06Oy6NtDosq5m0bgVErnC0OgBWsf9Xzx/KhnL+xv
 V9YGiJrgACKBudJt+aXJOFGF5NRepbQe0oDO3CV6mlRhuyw33rtITcNYmwG1/zcN0oS1 uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3wnds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 10:17:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42C9RWDg033810;
	Tue, 12 Mar 2024 10:17:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre76rb33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 10:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6QYP1K3uQfgu+7ZDBKAC3dS6VMC8bJoB5mMcJMjBCie/Urmku2V4qj2AgxOuLAFaHJxcLy3hCnkZspcIxa1N+P60gI0xAvtS0S4SgZrs45KuDk9jIXQv/8z4xCVyTP8KRcZi+LNrojTZIWeUHY7uDdSAyRvO0CX6GTeG0Am3yB9W87RvvGBW04uIJDrZDHYhnaiUkO/lj5dRsBl/rBQ4co3lLpxLtIQq1Yy+p5sIiu41rEgWCv+jnXC95tEm1Q6HGudB3rQuXQM4eaOQDtsq8l/JdvEBOZ+kcHjL+NMMm49CpS7kgIySDLCdW0t+DrRF8QlWaAxeZl41ge+n8fyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjiFui7cizFtbCpps41NJdEuNKxB7AAyTPmrOY+7VEU=;
 b=nBOa96Aadby52KNi70+a20mjisr2YkJ5raqjM9qNm8+xu/GVYVNRjUJJ4zhrJP2JrbxkyDToEO8Dyi9XFk3ILHu+jawG9vSQ5wbg54q42Z3iVCvLajLe2jAl1ZP448fSM+mOnaC7iRzWvDwu9dY4Ws74C9AHrJT9zP4iCnmM0JfUq4d98wkxiRZnh/MLcwUhifK/Tw/wJP9JKSf+J5E3YRNqcTw4jpEie3khVHP4lFtUxox/0j01w+RZMCVu5/5JeiY3Ylju/1QeynZzsLz8LYRapuUJ+R8Y0gVaMu9CdCsxne6y/Zl33/wGhFVGgNAYhtsUOPygr5D3Ovc7YOARhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjiFui7cizFtbCpps41NJdEuNKxB7AAyTPmrOY+7VEU=;
 b=j/v1ofuiRfhJ7MWacnzmUPiIaFfmS3qxsXzFhVRZaF8hlGp42RAG7CQA0Xp0QV6WevaqGyXYhgwgVew2VdvJx2Zi+HoL7554F/bwiz8dvRwMWJgWNIbb1kwIY3lhrrFVDldj6YG35ifuaDYfJ9qV1DP4a1k6Slf49ryjA44P5Ek=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 10:17:55 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 10:17:54 +0000
Message-ID: <be93c772-d400-4105-b05a-735ed7365730@oracle.com>
Date: Tue, 12 Mar 2024 15:47:44 +0530
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW2J1Zy1yZXBvcnRdIFBlcmZvcm1hbmNlIHJlZ3Jl?=
 =?UTF-8?Q?ssion_with_fio_sequential-write_on_a_multipath_setup=2E?=
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Paul Webb <paul.x.webb@oracle.com>,
        "nicky.veitch@oracle.com" <nicky.veitch@oracle.com>,
        =?UTF-8?B?6YKi5LqR6b6ZIChZdW5sb25nIFhpbmcp?= <Yunlong.Xing@unisoc.com>,
        =?UTF-8?B?6YeR57qi5a6HIChIb25neXUgSmluKQ==?= <hongyu.jin@unisoc.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <5ce2ae5d-61e2-4ede-ad55-551112602401@oracle.com>
 <d8f391eab8d64d9b9d2d3349b438dfb6@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <d8f391eab8d64d9b9d2d3349b438dfb6@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ff7a00-1e1e-437e-4dde-08dc427dae86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yn7KwR18FVxP0VUFD+pevuejpYFfEV/q6hcox4TZ9kH4TKmwpMRFrUbHyouu8miMuH/oK+wPUrK9hInm0DB/qKcPgYX+BSiUcaSCbB4wW+hgkcXN6dCdHSFledkXEdkpoNV/zwhknmBoPmWuNVYcGU1munwjsSBgF/1zewmwlGOB187e0pE4kp0vQgzNOUIdFo06PgQzHvKhwCo/ebjM48DIX+FdCogYMQMJUwLDMy897dygnpDsLFpq8DE/2Zo2B3KFiWLVD+r6oQWzalgD12KQr+x8HEtIQmrL99ifbkEu5ZT6N50OLsA4sVO63Blmo5UO00QQPMuM6B2Izv0m9dWnnjURM4vlSS5bMq480/VtnVFk6/+1wzZWrExJTHZZZCVmfcET5kcUxpNWHsqpCCatbi2XBINNU4U/FiT5omLPK0RGin7esfk419h+8lpTmb/vRTLbhFt3vle5AWOEwSHo+Df2t246a+UAL2q9ASvW2FoE97kFR4j8D/xrbPzb2cnTWdezJLQQ3XBkVE0agw3cgrqKr24lfl2ByLdBXsvkOW4M+oOd46dp2f89O9O7npObfsF/1YfDRfxFgaEfWQIuwo/blLmTDijBeT55J6gN+Gznco6cG2BN/B90ivMmcwsRjukVlknulG9rkCox0A7IixebvRdmblXR1Q/6rGY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnpTc0pTSDFNWld0T2ZCY0w3Wm1tb2swNjczTzFJLy9JR0RrNkpiMnRCU0tZ?=
 =?utf-8?B?QjNLUVFuMzJ1ajBCa2NHUDRuZXgxeXNDVlpGbjJNZTFYZW52SW92WUVqSVJo?=
 =?utf-8?B?MzFlMzhadUJiaEx3NXZNeHBQUmdhN001dnJnZFArK2V3NUVHa2F2YW9LMUl0?=
 =?utf-8?B?emNzTm12ZU1sUVBVRGY1MjVhUG5lZFZrcVN1OW42S0JVQ2RUcldSTzFSWnZY?=
 =?utf-8?B?ZWVzTHBFZjZDWkVaN1Q0aFZpQ2pXOGJPZ0RsdWZxVDV2T2tRc3dOY3RlREQw?=
 =?utf-8?B?eUxXR2FJOUhtRlJrYW1BOEFFY0swS29nZEpCYStCU0FOMzYrdlZncHFYc2Zi?=
 =?utf-8?B?LzgzS0NMdXprREdCek1aaDRWb1RHQ2swbGlycGszdjIxQ1l4VU1zT2hHMjhK?=
 =?utf-8?B?cGlJMmgxNXd0RTBRbDhCY2lNK3oydG9nTFVVRTl6MkJDYVQ5dXdHVzJPdFFF?=
 =?utf-8?B?VmFCMXViL2gzclg1QWErYXhOS2RnUGF4SVJyOWFDa294T0srK3JpYVN2dDNT?=
 =?utf-8?B?MEdUNnFFbkhHOTZOOE9jbGY4UkxBQjV1dE1VTW9YRlZSTS94UUQxZm9BWSs1?=
 =?utf-8?B?cHdyd0dIOEMwTjNRU3hyL1hoOGE3YlJySFU1akRDZStUMHZPc3ZHODZGME9K?=
 =?utf-8?B?V0VZSmZqVGw3ck5laVhJSlZRaE5pWkl6L3crYUd6UzFPcnp5bGErSllobTV1?=
 =?utf-8?B?YnVzN1BZOFpKNi9RNTIzdlNJYUlCai94NWlheHlGNUlVRi9oSjR6c0IyQjUx?=
 =?utf-8?B?OWxaSzM3UlFTVkRkbXdOQ0xqM0llN0RkdHdFQ2hRU3hwM0p6ZnNHRkQ3NnVG?=
 =?utf-8?B?MHZRbElHdEdJMnI4eGNwbGVNRkJsSElqcWwxWlVpTXd0K2FFSkg5U1c2ZS9D?=
 =?utf-8?B?SmZ5YjFiblk1KzJkSlBjenJvVGoxMytSK015eTV6WXZvaU55cUVQbXk5Q0xn?=
 =?utf-8?B?Z2d1RWpabWU1bFhTR2VmaWd5R0l4eWZRcUUraVRreXU0VGMvemhyRnRXTDFo?=
 =?utf-8?B?U1k1U1dnVi9ZUHl6OThST3BoYUR2WlF2WjZDWTFFY2dCRGpVOTQwMGJ3MWlV?=
 =?utf-8?B?NXpad2pnZGxzQVRaNFkzYU1sVXlDcjB0dExuV1V1bFNGTXV0QVF4TnRXdGgz?=
 =?utf-8?B?b3dDMXo2WWtvV2tOZzNNTmRmdkc0ekxveHN6RUxVN2JuTGY3K0VxL3IyYXY3?=
 =?utf-8?B?RlFQVTE3MjVjR3hmZnllbFV1ZEg1SzJPcnNkeTJOZUVEckFNWkNMQytaeXN0?=
 =?utf-8?B?QVRnNEhha3JFV0dXRjRWU1FXeE5Vb3EydmxNM3k1NDlLb0U2bjl1YlllNnNY?=
 =?utf-8?B?MGk3UXRaYysvZEVYdWhqSUhCUHlobDlCR0hRbFhTUWd5T0YzNXRiMkZsdkNp?=
 =?utf-8?B?aGZKN1B1cnZxeE4raWdWanJvQU9LNTkvdnRwWDZaZ1ZNT3JQNmliUnBYNzhI?=
 =?utf-8?B?NzZIcjFoYkxLK3JYT1EzRk9sS3RJdzh6ZXZsVmFUdWxSMFQwSCs0UGZTZTNy?=
 =?utf-8?B?cVltYUhRR3dTaTQ4TC9oR09EbnFEbmRKWjZqN21QR2l2eUpLeVJDZHR3KzhX?=
 =?utf-8?B?QnlWbDU3TzIrYk9FTkpsdjMzVjA0c1ZBZWZBWWFCQU5HazYveXJpeFpNcUZY?=
 =?utf-8?B?MkxxamFFWm8rbWJVcDBIS2Y2YWFvTTdmbEdnc3MrdmNJdnk0L1h3UnJsR0hr?=
 =?utf-8?B?blpwa2pvaXN2d2dQd1lLZEUvejlKUDRlenljQ2JNOWEvVHlsa1o4RGtUc3dU?=
 =?utf-8?B?dWZGcGxhUHpzcllybGZsZTRkREpBMThzN0RrNVAvazRvSFNZLytIVlJraDlG?=
 =?utf-8?B?aG1JYlBSaFkwejdMaEZYaEJOSzh2U3J4KzZ1RU5NV0hMeHlpcGd5blZrbjN5?=
 =?utf-8?B?OU1FbndRUE5vellhenoxcy9IQ01pY2F0TTRqZldBZUZ0b2ZBbytFbDM5TFZZ?=
 =?utf-8?B?ZmNZVU5pek9lOUJId3hOYWl5Z0ZTRXhRdloyS3lUOThFb0M5UWJ6RUh0dTN2?=
 =?utf-8?B?dmpQYTNoZWJRUFlRakNWaTV0YmFQbzZXYUZUemppMTN4QlZ1K1VWRjF5YThn?=
 =?utf-8?B?eTZQQkdOWENrRWlCVTVZSmZqR2cvUXh1Mk04U2RvSUlEeDRQMG9FakVJTVV3?=
 =?utf-8?B?aUJEZVQyUHphaWxtTGlBUlJnMTFrditYcmJraHdsaUc3M2hscVRmaUJJc2lG?=
 =?utf-8?Q?E89eP426pzwIYqsXp7Tff1Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cWxxm+sihooYfMp/vBfjYj+mzNYJ6Kd6nxUUEbBzYI5TG+Np2kIkCbd1DW/kIiyg2/8HVC3eV/UwITgaP4QqGH98dZ0nG0Bv4RNTJznhjgJgEWZN8H21oNkQJ1wRu5UZMit9+JPnEdU5JtMI2myxIBJwpIfir7gP2r3PwkDfVcRUfSIiIOdwljJlMJNO70Hqn5oNtCTUmXG+GjBGe4WdtsSFF/nQVRkRfZc6P8KYk0S+s+km+9I2Aiyd0i0PlrHI/kUyGUOLFL8TnELJJylgc8lLfxwmgMMBtLeKkTno3epkEDEfUSFAbgrbQP1/nWFXpMcV6aDkfXO90NMzGY/IS3uaaObGOlicvV6BBCYyuGQ7sDtKMmdLlguaO/vjXF5sFHNPKC/ROWyW4cry452sD2QCZozPXAlFpvukduh3OyvORe9FaJ7XDYcwdlJ41cn0vRC7Mj+uAOb6aqK5EURNaYSs+MdXTq2ewlWlWpXIdu9Y0TxslktcKE5EjAkFuzH2X6aFHii9Fe+DhtYvIxbWU/pmCxpno43lQyqisCps0Rj8pScMR0KAri8osjw2x7J2tLJwjeBGyJ00Ud1cgC8aU9EhNMur2Hp/zLkLbXsBg6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff7a00-1e1e-437e-4dde-08dc427dae86
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 10:17:54.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bhyRGYzmnmmAHNMIiC3K7pHBxxPF3Jwh2u2SKhVGMy7RrV6dOeHj7Q1685CoJy2GZsRbsHyjGd2hklbVv2Ck0nYFipVelbxOUqqILBPNgfRDdFz53kxPUshoGI0lWMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120078
X-Proofpoint-GUID: w33nHzGpSeVqzQeh7bJduLTlp1g35GUA
X-Proofpoint-ORIG-GUID: w33nHzGpSeVqzQeh7bJduLTlp1g35GUA

Hi Zhiguo,


On 07/03/24 08:25, 牛志国 (Zhiguo Niu) wrote:
> Hi Harshit Mogalapalli
> 
> What is the queue_depth of queue of your storage device?
> In the same test conditions, what are the the results of sequential reading?
> 

Thanks for the response.

Queue depth of the storage device is 254.
					
And here are sequential read data:

6.8-rc7: 2 block devices with multi-path:
----------------------------------------
Run status group 0 (all jobs):
    READ: bw=448MiB/s (470MB/s), 448MiB/s-448MiB/s (470MB/s-470MB/s), 
io=263GiB (282GB), run=600311-600311msec

Disk stats (read/write):
     dm-1: ios=418480/0, merge=642066/0, ticks=143492597/0, 
in_queue=143492597, util=98.28%, aggrios=287904/0, aggrmerge=0/0, 
aggrticks=71063414/0, aggrin_queue=71063414, aggrutil=86.71%
   sdf: ios=575809/0, merge=0/0, ticks=142126829/0, in_queue=142126829, 
util=86.71%
   sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
     dm-12: ios=422296/0, merge=667474/0, ticks=143680598/0, 
in_queue=143680598, util=98.95%, aggrios=288787/0, aggrmerge=0/0, 
aggrticks=71153453/0, aggrin_queue=71153453, aggrutil=86.72%
   sdae: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
   sdg: ios=577574/0, merge=0/0, ticks=142306906/0, in_queue=142306906, 
util=86.72%

Throughput Results:
READ:470:3582:0



6.8-rc7+ Revert : 2 block devices with multi-path:
-------------------------------------------------
Run status group 0 (all jobs):
    READ: bw=462MiB/s (484MB/s), 462MiB/s-462MiB/s (484MB/s-484MB/s), 
io=271GiB (291GB), run=600298-600298msec

Disk stats (read/write):
     dm-1: ios=421574/0, merge=692148/0, ticks=143444547/0, 
in_queue=143444547, util=99.19%, aggrios=288316/0, aggrmerge=0/0, 
aggrticks=71080370/0, aggrin_queue=71080370, aggrutil=87.08%
   sdf: ios=576633/0, merge=0/0, ticks=142160740/0, in_queue=142160740, 
util=87.08%
   sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
     dm-12: ios=432589/0, merge=672001/0, ticks=142976262/0, 
in_queue=142976262, util=99.03%, aggrios=293051/0, aggrmerge=0/0, 
aggrticks=70886007/0, aggrin_queue=70886007, aggrutil=87.03%
   sdae: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
   sdg: ios=586102/0, merge=0/0, ticks=141772015/0, in_queue=141772015, 
util=87.03%

Throughput Results:
READ:484:3695:0


On an average over 4 iterations:

on 6.8-rc7 : 3571
on 6.8-rc7 + revert : 3634

Almost there is no regression on sequential-read while there is a 
significant regression in sequential write


Thanks,
Harshit
> Thanks!
> -----邮件原件-----
> 发件人: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 发送时间: 2024年3月7日 2:46
> 收件人: 牛志国 (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>; bvanassche@acm.org; Jens Axboe <axboe@kernel.dk>; linux-block@vger.kernel.org
> 抄送: LKML <linux-kernel@vger.kernel.org>; Ramanan Govindarajan <ramanan.govindarajan@oracle.com>; Paul Webb <paul.x.webb@oracle.com>; nicky.veitch@oracle.com
> 主题: [bug-report] Performance regression with fio sequential-write on a multipath setup.
> 
> 
> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> Hi,
> 
> We have noticed a performance regression in kernel with fio sequential write job.
> 
> Notes and observations:
> ======================
> 1. This is observed on recent kernels(6.6) when compared with 5.15.y, the bisection points to commit d47f9717e5cf ("block/mq-deadline: use correct way to throttling write requests") 2. Reverting the above commit improves the performance.
> 3. This regression can also be seen on 6.8-rc7 and a revert on top of that fixes the regression.
> 4. The commit looks very much related to the cause of regression.
> 5. Note that this happens only with multi-path setup even with 2 block devices.
> 
> Test details:
> ============
> (A) fio.write job
> 
> fio-3.19 -- fio version
> 
> [global]
> ioengine=libaio
> rw=write
> bs=128k
> iodepth=64
> numjobs=24
> direct=1
> fsync=1
> runtime=600
> group_reporting
> 
> [job]
> filename=/dev/dm-0
> [job]
> filename=/dev/dm-1
> 
> Each disk is of 600G size.
> 
> (B) Test results
> 
> 6.8-rc7: 2 block devices with multi-path
> -------
> 
> job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 128KiB-128KiB, ioengine=libaio, iodepth=64 ...
> job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 128KiB-128KiB, ioengine=libaio, iodepth=64 ...
> fio-3.19
> Starting 48 processes
> 
> job: (groupid=0, jobs=48): err= 0: pid=6164: Wed Mar  6 17:58:33 2024
>     write: IOPS=1884, BW=236MiB/s (247MB/s)(138GiB/600319msec); 0 zone resets
>       slat (usec): min=2, max=540462, avg=25445.35, stdev=24181.85
>       clat (msec): min=9, max=4941, avg=1602.56, stdev=339.05
>        lat (msec): min=9, max=4973, avg=1628.00, stdev=342.19
>       clat percentiles (msec):
>        |  1.00th=[  986],  5.00th=[ 1167], 10.00th=[ 1250], 20.00th=[ 1368],
>        | 30.00th=[ 1435], 40.00th=[ 1502], 50.00th=[ 1569], 60.00th=[ 1636],
>        | 70.00th=[ 1703], 80.00th=[ 1804], 90.00th=[ 1955], 95.00th=[ 2140],
>        | 99.00th=[ 2869], 99.50th=[ 3239], 99.90th=[ 3842], 99.95th=[ 4010],
>        | 99.99th=[ 4329]
>      bw (  KiB/s): min=47229, max=516492, per=100.00%, avg=241546.47, stdev=1326.92, samples=57259
>      iops        : min=  322, max= 3996, avg=1843.17, stdev=10.39,
> samples=57259
>     lat (msec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.02%
>     lat (msec)   : 500=0.06%, 750=0.14%, 1000=0.93%, 2000=90.41%,
>   >=2000=8.42%
>     fsync/fdatasync/sync_file_range:
>       sync (nsec): min=10, max=57940, avg=104.23, stdev=498.86
>       sync percentiles (nsec):
>        |  1.00th=[   13],  5.00th=[   19], 10.00th=[   26], 20.00th=[   61],
>        | 30.00th=[   68], 40.00th=[   72], 50.00th=[   75], 60.00th=[   78],
>        | 70.00th=[   87], 80.00th=[  167], 90.00th=[  175], 95.00th=[  177],
>        | 99.00th=[  221], 99.50th=[  231], 99.90th=[  318], 99.95th=[15680],
>        | 99.99th=[17792]
>     cpu          : usr=0.08%, sys=0.16%, ctx=1096948, majf=0, minf=1995
>     IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%,
>   >=64=199.5%
>        submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>   >=64=0.0%
>        complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%,  >=64=0.0%
>        issued rwts: total=0,1131018,0,1127994 short=0,0,0,0 dropped=0,0,0,0
>        latency   : target=0, window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>     WRITE: bw=236MiB/s (247MB/s), 236MiB/s-236MiB/s (247MB/s-247MB/s), io=138GiB (148GB), run=600319-600319msec
> 
> Disk stats (read/write):
>       dm-0: ios=50/533034, merge=0/27056, ticks=16/113070163, in_queue=113070180, util=100.00%, aggrios=43/266595, aggrmerge=0/0, aggrticks=156/56542549, aggrin_queue=56542706, aggrutil=100.00%
>     sdac: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
>     sde: ios=86/533191, merge=0/0, ticks=313/113085099, in_queue=113085413, util=100.00%
>       dm-1: ios=5/534381, merge=0/36389, ticks=240/113110344, in_queue=113110584, util=100.00%, aggrios=7/267191, aggrmerge=0/0, aggrticks=153/56543654, aggrin_queue=56543807, aggrutil=100.00%
>     sdf: ios=14/534382, merge=0/0, ticks=306/113087308, in_queue=113087615, util=100.00%
>     sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
> 
> Throughput Results:
> WRITE:247:1884:0
> 
> 
> 6.8-rc7+ Revert : 2 block devices with multi-path
> -------
> 
> job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 128KiB-128KiB, ioengine=libaio, iodepth=64 ...
> job: (g=0): rw=write, bs=(R) 128KiB-128KiB, (W) 128KiB-128KiB, (T) 128KiB-128KiB, ioengine=libaio, iodepth=64 ...
> fio-3.19
> Starting 48 processes
> 
> job: (groupid=0, jobs=48): err= 0: pid=6104: Wed Mar  6 18:29:13 2024
>     write: IOPS=2518, BW=315MiB/s (330MB/s)(185GiB/600339msec); 0 zone resets
>       slat (usec): min=2, max=923472, avg=6789.22, stdev=20329.20
>       clat (msec): min=4, max=6020, avg=1212.68, stdev=714.90
>        lat (msec): min=4, max=6020, avg=1219.47, stdev=718.40
>       clat percentiles (msec):
>        |  1.00th=[  203],  5.00th=[  309], 10.00th=[  384], 20.00th=[  535],
>        | 30.00th=[  709], 40.00th=[  911], 50.00th=[ 1133], 60.00th=[ 1334],
>        | 70.00th=[ 1519], 80.00th=[ 1754], 90.00th=[ 2198], 95.00th=[ 2601],
>        | 99.00th=[ 3171], 99.50th=[ 3608], 99.90th=[ 4329], 99.95th=[ 4597],
>        | 99.99th=[ 5134]
>      bw (  KiB/s): min=12237, max=1834896, per=100.00%, avg=413187.52, stdev=6322.04, samples=44948
>      iops        : min=   48, max=14314, avg=3186.68, stdev=49.49,
> samples=44948
>     lat (msec)   : 10=0.01%, 20=0.01%, 50=0.09%, 100=0.02%, 250=2.28%
>     lat (msec)   : 500=15.45%, 750=14.26%, 1000=11.83%, 2000=42.52%,
>   >=2000=13.55%
>     fsync/fdatasync/sync_file_range:
>       sync (nsec): min=10, max=76066, avg=57.85, stdev=299.52
>       sync percentiles (nsec):
>        |  1.00th=[   13],  5.00th=[   14], 10.00th=[   15], 20.00th=[   16],
>        | 30.00th=[   17], 40.00th=[   20], 50.00th=[   28], 60.00th=[   47],
>        | 70.00th=[   65], 80.00th=[   80], 90.00th=[  103], 95.00th=[  175],
>        | 99.00th=[  237], 99.50th=[  241], 99.90th=[  262], 99.95th=[  318],
>        | 99.99th=[16512]
>     cpu          : usr=0.06%, sys=0.07%, ctx=531434, majf=0, minf=728
>     IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%,
>   >=64=199.6%
>        submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%,
>   >=64=0.0%
>        complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%,  >=64=0.0%
>        issued rwts: total=0,1511918,0,1508894 short=0,0,0,0 dropped=0,0,0,0
>        latency   : target=0, window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>     WRITE: bw=315MiB/s (330MB/s), 315MiB/s-315MiB/s (330MB/s-330MB/s), io=185GiB (198GB), run=600339-600339msec
> 
> Disk stats (read/write):
>       dm-0: ios=0/246318, merge=0/493981, ticks=0/142584585, in_queue=142584586, util=99.17%, aggrios=6/181454, aggrmerge=0/0, aggrticks=112/70608689, aggrin_queue=70608801, aggrutil=84.92%
>     sdac: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
>     sde: ios=12/362908, merge=0/0, ticks=224/141217379, in_queue=141217603, util=84.92%
>       dm-1: ios=0/233211, merge=0/538097, ticks=0/142579042, in_queue=142579043, util=99.15%, aggrios=8/174475, aggrmerge=0/0, aggrticks=128/70654686, aggrin_queue=70654814, aggrutil=85.20%
>     sdf: ios=16/348951, merge=0/0, ticks=256/141309372, in_queue=141309628, util=85.20%
>     sdad: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%
> 
> Throughput Results:
> WRITE:330:2518:0
> 
> (C) performance difference:
> 
> That is roughly a 33.65% performance change, this is reproducible on higher number of block devices as well.
> 
> 
> 
> Thanks to Paul Webb for identifying this regression and sharing the details.
> We will be happy to test any patches to check the change in performance and also follow any suggestions.
> 
> 
> Thanks,
> Harshit


