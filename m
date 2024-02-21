Return-Path: <linux-kernel+bounces-75650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467C985ECD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA5B25441
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E859128808;
	Wed, 21 Feb 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxXitSgc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lOgzXNrc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51428A35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557820; cv=fail; b=E8MPsSNm7YoMGwo6xlfMMcxsC6M4INDWlnz/nd/Z0ZBv2rphah8txQn+2rNJR5HuBhgj3AEd0hSDW0TMrSTkFVlULNKq4zokVaVSXfZ4HuKx2m8Y8cZPtBmALPWM3gOyx59CLdtOcBt70ZEMsoPDh3NkxkzG7Toss9uqGthZcMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557820; c=relaxed/simple;
	bh=6Gafvn6eiAYEdn33y0vuW4hrjGHHvxBkblsaK18BuBM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=HOWo0HceotFArqwrH+59h+AD88xjcJvD33iCF/J19gRG+utjv6+kQ0cHPJ4fwCpBi+s6IuzSpjVB+zkrhlsMooSZ8Xfc1QZw8eWSXrx/ho+qwkNkMr8jQk26OAbKJB4T47/A7vqTGCulk2pmHAmeT8g1MCo/S6lbCakKjbDsajY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxXitSgc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lOgzXNrc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJSpm6021262;
	Wed, 21 Feb 2024 23:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=USKxBDHG82APyBK4BQfFEfm6RVainLy1GuZ2cm6GTNc=;
 b=SxXitSgc0z5g+npUXH4ajKTALD5RZhPUAJKLgPlC01EBGFy3QRYeDQb/SNLtbve5Kf2v
 7mee5i81xwDKIePjslWtrrhTLQpfHLD8biX0kaMHTn1wFKab6tfdhG1Qy9W3gYX19BIV
 8wAS7ZZ4zQ3UCJLV182Vy0MuHFOx+f1NOHKJsBJFKu9cllu1njbiRf/nDrwTuv3HXB8s
 qZ8yYxcta0hoNqzJv10heokol+EUsEO41/QITVGeGBLJrvGoQhlfmh2bTa19SXc4ODcw
 1ZJT6NqI4Ek+ywUlP+FfSZxUMZAglwbnTzho60/SdDbxqhEdOXRd6n0Z8S4fk2X0UQ+j sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud38g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 23:22:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LLwnYT013263;
	Wed, 21 Feb 2024 23:22:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89rb98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 23:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUEG2ZpM2gkBFCZcp6/w2H0vswhGXzRs1EDr3PTYTkQVb5URg9tnvQQgrawHYwat8CZ4tiB1c6HBywGJeKYg6W+7SoQALeleGUHd3EO2X5XscQiZZ3Xwnlrwm/ZTHHoEfQq23YDTFxDgMW7mPaLibQv8ODB3M7HD0bYPJZxy9YEzmk8sC05w6LM5ybA1/S98dtVZm8Sk5+b6sWNr0dCSwZhAKUJEScoBhE2ARZnFQGvAhBoc+Vilc2wFkvEFmlPMGpmUNvsWe7qrw7GBE6Ylu1pBwMqZkvMCM9QkRuHx0pAJ6vwfhdBs5xPFBQsi0YmWV7h+Fd0D41Mqk8tbPvVwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USKxBDHG82APyBK4BQfFEfm6RVainLy1GuZ2cm6GTNc=;
 b=ORhFqGwG1ndruwm4u8MDkqIL82eByHr/+wHsC/qLTakmeSgrX2PB43Wj7NMhXKcwfg1vVrytPKH5EHCULMX0bsvmMNjFSj8UhOoV9/sFzdKxQ5NMEPCwnNGZe1IZyzERid1J1RgQZrM21qA+bWHBHnNi07VKortm/A4ttUNDk+66d19BiTUJ+hKBS0nZdPzwSCJxz2LiQwVw5qBxG2e+0Ig5cCZS5jKZ1GGz+ijgkNi2wnPumseO+SYvvPjFR1PO5zqye7dDEvJlxEskuNjdh8dbyFqFfknljIFU1KbMdPr7niMDxdAWJA4/6UbSNO8WPFY72dZcCrlVuFelOvtq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKxBDHG82APyBK4BQfFEfm6RVainLy1GuZ2cm6GTNc=;
 b=lOgzXNrcHLZYKPgbWPUyzw97qTjXCk3xO662mNPVin1Cdr41/DH9Vtwqsua28SS+b64QQZj0zyiBIpT13P8qmWQHCAqKHHp7mOtW7SQHyCmyPSjeOUZNFQ3pQbTPE0R+nou/FC+Q2ZM097sp7WeY6svojqE8sv6s8x40CQcxk8w=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7905.namprd10.prod.outlook.com (2603:10b6:610:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 23:21:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 23:21:58 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-30-ankur.a.arora@oracle.com>
 <20240221164334.6f8c69e8@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
In-reply-to: <20240221164334.6f8c69e8@gandalf.local.home>
Date: Wed, 21 Feb 2024 15:22:20 -0800
Message-ID: <87bk89e72r.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f190bb-4b7b-45bf-86dd-08dc3333e638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/fTHkzV473zuGdWESFonn3awOsnEH8oJRWhREizcx4CPFjFULMuLJGB+fNCl0Gw+lgtgAyc/R+BGA4YmRrgOJEiFJf4u+8v8iSlYXU4eZXfNyMQRb1s0xvct4u/91rTgbMbEmixOPYxREDJ96h2IuRw2+ibkTOIpGUo9AblclexlsEk1kdA26OHr3jtpZbLABWf5+gH00y6IXv8rBDr4td9fPselLTjjIOHjQkSVth9msj6xGokRyCGSZddBocxFW6cCRB/+ultWDLOFh2OA772LxMUSY+zUZLHkxQdl2mM1k7M65figKsRDLwqVSCHkA9Ex3OOJkWc1e142rKISc0V+xZFVmc6tOmdRZLYxEzvnYL1MId/Uqbz4UWSGa28DACSj2WeXNCoxm6yMdsJnyQSBgRsphJkfwVvBo93Ef7LBC+XyNxQFz3S8V+UkJ+av316R5UpKolexrj+YPO/AF/IT351ENKeoxkW2emtLcZmWGWbNpeNGob8Ik28JPnhe9/YwGUdZbz+A9rug/V8QQA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EacYmOCCgVFnxqH1PP24BXNXZFCrSjH32l4SMUhN26Ko+rDdcA7AAM7U3YY1?=
 =?us-ascii?Q?DtcAzCo7d9wHF2HehEtsB+6l5p9XriSORBHyutmXYdzZHlMiqf3lJJAalTur?=
 =?us-ascii?Q?82Q0ogRffuSEBUVZOTHpPTaMY32qz+CDn7iQyX1DP9i6fMD7Vn3ItOdTxgtN?=
 =?us-ascii?Q?VKAxwFkYSBYOmqJO119iACWKtsIFZABPQAKVms63wHfVcOxm4iDRd+/d31qG?=
 =?us-ascii?Q?WFt0vx/X534mZi/1gNE2FzXxqSGBF7sEWOTeL0TNal+BFaDFQRsmQgSwJEsb?=
 =?us-ascii?Q?2GoDVnfkIhy8ZBTbJQpskZMxl/wu7MtrUOcTaKhn2BfiQ2NHl/noa8/6V0fx?=
 =?us-ascii?Q?OZRlXtGhpEWi+ab1aakci9djqASbg3aHYVqBVZJlh7xfQLUMAEjhNpV5iZIF?=
 =?us-ascii?Q?EEmgLfX8WUXgS/1nA4n+jPNHi+20vTx5MFi59RKGBMHWPRbS1kIOEGFqbRPs?=
 =?us-ascii?Q?AZ3fD5J6KsV1qdAv3kBxp/U9FF10m4dPcWtEoLgV5tA8Y0LbwMqfMy1IiAhu?=
 =?us-ascii?Q?GdjdKlDaL9XLfLeFfhuNCjuuRxy0oCRDcR2I36xu/tSIovekrugNnAIu8gAg?=
 =?us-ascii?Q?G0/heGaEKKrCfhTz4mGO4Qo9suu8oJP2szNfR1AMKStXXv/mWhs5Le84jzks?=
 =?us-ascii?Q?iew1/782GBJDivQYdykrXc3IJvoadBQPJO7jhRfVMWgGHorSKTTgUAymZ4W0?=
 =?us-ascii?Q?eM9b+HM1f1uJxmGNPiIGCspjuSHg40yCL85zjsX6hVnfNtBoL6j573Sb6Qvj?=
 =?us-ascii?Q?/wEG+7oq4Pn1+XHeu5q7KZtE/e72uW9b1kh1ESbOCguEaB8X1swBNpNCG08M?=
 =?us-ascii?Q?Njg6LvRvN7y7oFHrWzyI61Set03ArD7RSTLsscu0plc23hFXajQ9hKwLZZln?=
 =?us-ascii?Q?RnbuSpVGDkN+pfODRKodG9666uXD1gnK1R+KP2SQB/8pShfjx42PPquUQzqB?=
 =?us-ascii?Q?WCV8TiSl4nsuvM/fJsDIa6R6mMY0KPXZ4VHXQxWOLx5ivhrGDtBeyMyaFif1?=
 =?us-ascii?Q?bp+lTYVXQeYhGXojvx0HHQEtHq+IO2NoHyKwmJkiZMEFe4QFnGkeNvKaChNE?=
 =?us-ascii?Q?OUOjol50zaicHrIQonuFhv2F4swBoHE+fEh+JkNSMSbdMnlqVYW0wwvZA1ww?=
 =?us-ascii?Q?hcPFV24oshcotc/AoIut3g9qfNV89IB77uXDZTIXA5Cxmdqh0pdJL7Qo/2va?=
 =?us-ascii?Q?A3EA3pHaTDSecQNYIxyJGvOBPreu3sikTo5JMEmNU3rbmQgVKhk+YhK8fINF?=
 =?us-ascii?Q?qZbVzAqnRudHWgoIvgRNW4AbgbRMV0dxo1zAwN1dBLRzMxoT/H3dgUUe77+/?=
 =?us-ascii?Q?ThAre4/lcv8GrVh3n75UFdtltmouFAlJLCGHUfpyz3BRcU+7dqoz5p9eQSOQ?=
 =?us-ascii?Q?Q4x1OJ9E7mjscInqTHkUvkMczGlcXpOzXBYnFSXKUqSu+rJFt9iOjG902tV+?=
 =?us-ascii?Q?+f7IxW3SAbcj8ZDhfrosQq0UF+K9JT3l2KVnPmR20eK3iyepOkAHxODxRU1P?=
 =?us-ascii?Q?c8/MMq4h2K6XZGKyRLAcHL4MdN1NPAd1SKudDhiqNTrJ//mYpIwhte+oscTb?=
 =?us-ascii?Q?CbQDBbmT36oMyLyig1k/XiadmgLYLlGJaQ27njWcUFkj+2EFT04A07sPYT1V?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FeTVkF2m2nGdOYtTjDWonRj5UipRTIFTBE0ZjLCLn9HiPc9bY7r8xX6dwHXkeKF24QCXYBy1jRnQcdOz2Hwh1z8T+uTnbVMhf3JN46umGSNt28Fc1EGUduknAIlPrRtKXHnqYkTt+CJY7mJINEpYWbxHjMoiitydfVVg0rwPhzSxlJuMc+zWoN1JYS1a641HtChaqPXz7J6K5cChavTkB246+f/OoNphtXff6YF4gaY9QMh6g1/wKZO0aRxTwZyflc0H/FNE/sDx9yScEot2ma2coNHTbb4tlRCXj3NTwGtprtsgWcBUQTwn6RgN3wn5+TgJflCOsT5PmBysTRO4inkqocPAJlRlNf6uJ6cYdgsuvinXu1yWuGUiS+s2Os2zjYGeJpjbjy7l3kipAyLNQKS6TJBIhZos7VMtMboSlnmYr79dE9RNRjOIJ6pzffMtpz4Avg+EbIvKBWy46t+PegT/3pCnmFMdLPlSoGf9n+MLX+WmckwAE6ovy4psjZCJ/rojQu8CXKqy/ZoD3YfcMlHCxuQrOsW66tce8vH6ioRXDCHHk46Knm9nF4lH3+4gNYWrZ05bnbRniRYu1sjyt+pXvdvxtTqzPqR6xrRd7AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f190bb-4b7b-45bf-86dd-08dc3333e638
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 23:21:58.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uenem81nIkeH/TB0gjLsZzxkuDG2lF1M0gDBUcn2aKcRFxNykLARa53u5sL9FG1v35Srrkss8LiE8Mrchgk8qxu67wbEmwsHJqdyisxoaG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=763 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210184
X-Proofpoint-GUID: BF-Nf6UrmGgKkq0p0u6rCbsn2sb5f7FL
X-Proofpoint-ORIG-GUID: BF-Nf6UrmGgKkq0p0u6rCbsn2sb5f7FL


Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 12 Feb 2024 21:55:53 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Document various combinations of resched flags.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  Documentation/trace/ftrace.rst | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>> index 7e7b8ec17934..7f20c0bae009 100644
>> --- a/Documentation/trace/ftrace.rst
>> +++ b/Documentation/trace/ftrace.rst
>> @@ -1036,8 +1036,12 @@ explains which is which.
>>  		be printed here.
>>
>>    need-resched:
>> -	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
>> +	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>> +	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
>> +	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>> +	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
>>  	- 'n' only TIF_NEED_RESCHED is set,
>> +	- 'l' only TIF_NEED_RESCHED_LAZY is set,
>>  	- 'p' only PREEMPT_NEED_RESCHED is set,
>>  	- '.' otherwise.
>>
>
> I wonder if we should also add this information in /sys/kernel/tracing/README
> so that it is easier to find on a machine.

Yeah, there is a problem with the discovery. Seems a little out of place
in tracing/README though.

How about something like this? Though this isn't really a model of clarity.

    --- a/kernel/trace/trace.c
    +++ b/kernel/trace/trace.c
    @@ -4292,7 +4292,7 @@ static void print_lat_help_header(struct seq_file *m)
    {
            seq_puts(m, "#                    _------=> CPU#            \n"
                    "#                   / _-----=> irqs-off/BH-disabled\n"
    -                   "#                  | / _----=> need-resched    \n"
    +                   "#                  | / _----=> need-resched  [ l: lazy, n: now, p: preempt, b: l|n, L: l|p, N: n|p, B: l|n|p ]\n"
                    "#                  || / _---=> hardirq/softirq \n"
                    "#                  ||| / _--=> preempt-depth   \n"
                    "#                  |||| / _-=> migrate-disable \n"


Also, haven't looked at trace-cmd. Anything I should be sending a patch
out for?

Thanks

--
ankur

