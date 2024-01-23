Return-Path: <linux-kernel+bounces-34619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888F838402
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB97296F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D166B2E;
	Tue, 23 Jan 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hRFcule5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1Dmvm22"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194C657B3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975226; cv=fail; b=D+InA4G84OMiCpnnZTX9hf9qNyGe3q3xSLAJZJYhaWOyKr4K4NuLkZpVjaUsJ8yenwAiL+wf9f5Ihvm7OhFeTGRwr5PPz/fyHsGFNIroZUsUjd9LBNjxGn8Lwcz+6se1KrmsFUR6WNHSntXDUFPbSKgG3QvK4LlXwrcOIMWZuLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975226; c=relaxed/simple;
	bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMxqIUFr7RIRO96LrrTs4l3ZCaHmMn0hSv7S5JUARR74pCkyuhhft5GLRIWNpxpJ8AQuzX0CJHIFmNobz1Q0hV3K7zzyWwl/1M77XmZ23+I5TkKKtsubEEt/j01AegrBC9BSLfb65Z09U15Iz/i72T1bAjEw0aFgY8EhO1KxIIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hRFcule5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1Dmvm22; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N19U8B007154;
	Tue, 23 Jan 2024 02:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=hRFcule5v5exFsIa0O5kPI1ieGkZVhWw+kb6nN1Oz5FAmWSYLLVkuCjvKFTdc3gfqvB0
 zPZqLR8BeNbqgZKb6NSCIEJLRi9UHw08DqIPpNy1mhOrB5x62islGRE23ZsGNZINyxyB
 WBqoJtpsJI5UO1h4xoz8/xeqcvgCMiYjy4gxPAvr7omvVVNITqja7QSML4qogX6QA0jO
 FVWWiK2ZQxD9Gr4MbWfuPnU5/4CRJqfMPptMA2DPdle6/HcIVDKnTPBV3ZDIVhaUZRxb
 1gYG+r0tcAlO2p36AKoroMIhfFp3+/RyeAe6qAq2m2OUN4OupCYjpoz778CJgg4kxAOH qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ann4hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:00:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N10wVV016230;
	Tue, 23 Jan 2024 02:00:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q3ae0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 02:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrbBfDjnUe5nTzrQ/3XxJ59VQJno4wKXcLBLjVjk1wrAIGKJrMlZ9F4ECM9VfFonAKDapo37z8ZP48JHaEKLSZ8DhLlhcYR8tBBWu1Deg979qnx5tG2e3XzAh5VTyocN0ljJ2G9nxOtOVQw6uJsDXzWpahmgH4wfU0Mjd8okyV1fC7CMm5YBDM364w8N3p6h4HEWXTl7E04NFC8vqemBWZ7OEjrchKS0SDvn8MC/RNdNmS9w8/CUMkABBeNPO7jRFcDPXn2S8GsVKSSFDchb1YRkiBfQMuDul8bJdt66eb1ohmSexsUH2Ekb5NtvSdvn7WkwgiXUFNlHSR5YqH3Krw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=VERSMA7T5Ly3P85+05zEyqjYqNrY+JJyyUTIoGchcAFQ/fPlpWqVFHufIuVmBr8ENgvE7kozsL0lyhiwKYCZ7AgO21dmNUp33gwDIw1eplZiJvbJg0Df8vQ0585YEqSJisoajQat7tU6QBeVUfVcRAexdUKIbU7gS2bZfnA6nZtm9vIZi+He/K08NHZuuzaETDIOAUY7+5Li46IymcOgeGfIKMO43Zv0NPo7KOXpTZJYXAZWn+1PuUdiF2eR2LvczeVI8ouAqsApNHrVzLp704BSR4kENhYnCeS1Dv3YiO2XcyzTm2QLsurNmxFG7CIjcN/3xjhf16073wvqH4UuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkxpV7U/7zkBXJ6tz/5AcG8jb4nMux8AZdU4OA8QWDI=;
 b=O1Dmvm222/du+K2zPF13QBnqERjPC+MW4KggrommGQ++a0xbUNtcYJ0Gkbs+lYRJhKPG6HpJiHZscxIunaYZKjGQ0T3+eW0RAodNXD/otn/OMXu3b5lk7U1qu7X4Jhz4bmkrl6Ddss3+jSL6x8gwK3nxhLZjT1bQUrpB9ls3EtA=
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 02:00:12 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::328a:88d2:1e74:fb50]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::328a:88d2:1e74:fb50%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 02:00:12 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "muchun.song@linux.dev"
	<muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Thread-Topic: [PATCH] Hugetlb pages should not be reserved by shmat() if
 SHM_NORESERVE
Thread-Index: AQHaTLmwlElGBPi+U025BxoFJNM3mLDmphyA
Date: Tue, 23 Jan 2024 02:00:12 +0000
Message-ID: <EAA37C24-41E0-40DB-9EBB-D207C581DC8F@oracle.com>
References: <1705713472-3537-1-git-send-email-prakash.sangappa@oracle.com>
 <20240121143207.299f0d3df52ac746224dacd8@linux-foundation.org>
In-Reply-To: <20240121143207.299f0d3df52ac746224dacd8@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR10MB2629:EE_|BY5PR10MB4196:EE_
x-ms-office365-filtering-correlation-id: 23084ad1-7317-480a-8891-08dc1bb70932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qEU9gm8gGQi2GqNT5qnCKdLOha3M9r0wT8shTgj6aScZBWMmq4auHvCWuTWpF85l490xwpGil2/KFkZM2/mdipqKYxb7LPRVi8jcEYY9oNdSRVwgEvAd0qxdMxfcOHg8UmHfdFf6ICTagPGWD5OEw8jrdTDjwF8lb6oxakybOJbnMvumjZCBrhUMOkiViQm4gCneVHlP7d7fRgvZRpYDsgU1scm61spHrKNEidLOCwb9V/brNuYUtvnOHayHqfHa55KCbKl7AMMbQ1jTWFFTZB5dtCffEw/+PlurrEntxwMQyTzGttPQOHtnfGJ/vsIc9XdwicQ9ZqRIyCjWc4D7PnlNRV+y//ytAS0bMwGQ1Bh0eI4RJ6hvHsY4pyKWcXyixI8Dbimimps9p5CUofHLrrwfGFjBZpJ0E4Zd8HCZcWUgPWFemK3e5G/uWcdxkwYVrVYc5F7W2KPJXVof7w6I3hyMEjIxuAGGgx0i+7CNhEkhAG3T5TScYpJC0KeXBRuAaDC9v6V70BvwXhBRJfc0bdpgARHMV8KMPV/vl/5+B76kImLZzeuqFnU0Vl3F1/uSYiv1GcEM9fe677OZ+tmhz18pU/08iSc6sbf++NDj4pU/lR1G2VN+KbpVv0YJLXSYkImHSnEFrpfAHKKSNfrZ/g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38070700009)(478600001)(64756008)(8936002)(4326008)(44832011)(54906003)(76116006)(316002)(66946007)(86362001)(66446008)(6916009)(66556008)(6486002)(107886003)(71200400001)(2616005)(2906002)(26005)(6506007)(36756003)(8676002)(5660300002)(6512007)(53546011)(66476007)(41300700001)(33656002)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eDkvYTh3cnJkVHhmeDdEU0hBc3pZWUVSSHpxdGNQb0t4Z3JXLy81T0x4N0xL?=
 =?utf-8?B?d2VwZEl6WFd2TWlkM2sxRkJ4MzVxcVg2TTN3TmN6YURpVmJmbW9oVGNzVThs?=
 =?utf-8?B?YTZKNjYzNTJWV2tkM0ZGdk9UcTk5Ti9OVWxldStFVmMxdzFiVnVoT1czL0N5?=
 =?utf-8?B?NG5RSWV4THZrMklUdDNDNy9GdFR1dXZHWkJHM0E3SWZsVEtTaEcvbEE5eWtI?=
 =?utf-8?B?cm0vTmloN2pqcHpPdnBTWWZKL09BaVR6MmRiWnpGYzZaOFpkb0FRVUk1OUlO?=
 =?utf-8?B?Rmo0bEpXU2ROcWk1YlZ4OUJFaFdYemhEcm14ekI0VGcxMFlyWTZ0dWVqL1Ex?=
 =?utf-8?B?ZnFrbUpPS0czY1hxcUNhTWxFY1VmODhVVklsVGR4M0NuMHBjM3ptbmlMZ2c0?=
 =?utf-8?B?QjdtR0JRWVh4VWRZalBidHhGUzRONXdtRWtuNUE5TGkvb25lazJrTWsydHRK?=
 =?utf-8?B?Vm5KNjJLcHZ1WW1LeWZ0T0pnSko3c0RFVWlzU1RlYlRoVGk5VVZZc2FtRVQ2?=
 =?utf-8?B?bkRIVjdRZi91QmhtYTZhUDQ5QkhSMDN0Z3RiRnZ6UnRkYzNIVk1BcXE1Z0kw?=
 =?utf-8?B?eG9RMUJ1SnZ4Z05sNTVsUkJUc2JmblBJWGQ0bHkxK1JqNm1pWStBbzFZVWNp?=
 =?utf-8?B?ODRLK0tDK0JyZ2p3eEpwbVYyN1NVbTZlZk0xeXpuS1V1U0RPZEgrRm96ZFB3?=
 =?utf-8?B?UDNwTnVpTjdIRlhCYWFqclUzZFRFUTVMcjUrZysrU3lyOUMyaTZwL1FhRTlU?=
 =?utf-8?B?MDhnY0JUUzdiMC9HNjdtUXlOUEZMNmRmTUhUUmkwMnNoZnJoTXBuelUrNVo2?=
 =?utf-8?B?T1pmNGFZekFNQnNUMkRXNUoxNFQ2SHVWMTB2cDlYQXFPbkVIbTJpSS9OLzgz?=
 =?utf-8?B?RTFGQTNyNWZsVW0rcWFxNi9wNmU3bXF2Ynh3bndneER6LzQ4cWhqcXVSKzJr?=
 =?utf-8?B?aFhEa1VCVlBtTkJ5SWh4aVZXUGdUblgzeGNtWWNiTk9HRmNYdTFZc0xIYmFi?=
 =?utf-8?B?eExTZUFuSUlrRCthRFlBbG02NVRsWEZwQVJpY0owT0VOWE10QjQwWk1jRldx?=
 =?utf-8?B?K0ltTGxXTGIyMFMzVkwzb2J3VEJKU1dVa2Y3SkJ6bFNJNUlleDVxcHhZby9Q?=
 =?utf-8?B?RC9xclkzVWQ2R2ZPN0xhczAxMnlvci9PZkI2d3gvQlN1bGRJeFdFRm9Cem1O?=
 =?utf-8?B?RnFWZitvazgzTUdCeDJGY1NTQlB0M0NSZ2N0YzhqbzFIZzQ5cXB4WHpoYnFt?=
 =?utf-8?B?ZHFBQ3lreDdxdTBwVjJsdUJBWUpmZWpIdUdzOEI1eVM1MEhZYnVDaWJKcU1v?=
 =?utf-8?B?aDdYV1p6UE5hRGxmU0VRNnpDUGpocHNiRnh4TGpGdVRibFkvU1BFSVZkUlZV?=
 =?utf-8?B?aXRaRm9OWjc2TkltSnBHMVdJbi9LcmUrMzk3U2M1RGo5Z1I4ZUFqMDBGZ0g2?=
 =?utf-8?B?ZlFzWFZRbm9vaDZvdnFCeG9YQmtYcmRiN3hWVm0wekhDbDdlOFdtbzFoc2FJ?=
 =?utf-8?B?dGV4eHNhcG9EdFdEbmFocnZHdXZrdU1BUGNvSEc2ZnMvQW1kTmI3WHB6Y1dy?=
 =?utf-8?B?SmIrQU9WZlBaYzdIYUNyR0pMRVU5VkV4cnY5ZDFwS1U4OTR6a1kwNXNWK3BL?=
 =?utf-8?B?YVMrcHVUNGw5QVUxMzM3a2h0Smg4N0w3WXB0dTdORHBrYWxJR3Y0a2Y5NVNB?=
 =?utf-8?B?Nk1MY1IrRUZ0VTNTcmd0R2crYkFwbktHMmhQaTN0ZURiQitXaStIdlUydUpF?=
 =?utf-8?B?RkJZdXc2cGIvR3Q4ellSVlJUUkx4Vjg3T0k0eWVQQjB5dXpLaFVCZXBNdlNW?=
 =?utf-8?B?YmkxU2VhWXFCVzVzQzllblN0RGU4OW55SzB4dlQvTDRubW9OMFZ6UnI0VzVM?=
 =?utf-8?B?YkRKZGZCRGNOWkNEY2l6dkJnZjl5V0lUL0RNQkFqUlo0dUowRGlsSTYwQiti?=
 =?utf-8?B?YjRYalZ0eTNxRXczcWdFdUkzcXlRWEpYVFFjTHpUWnZSQTZjMlpxTWdMU0lp?=
 =?utf-8?B?Tjh2UnhxWCtJdVpxTHlaVWNsTENnWkQ0RkdKMmRONXR2eUkzOU1QZVNTWTgv?=
 =?utf-8?B?Y0YxSDVad2p1aUJBQUlVYngvU2NEdlQwTy9SYjZzVExCb2Z1QUdtZTZoWGxJ?=
 =?utf-8?B?bEJYYnpNczBFQXlpU3NWZlpCVTdTR1NOeitOSVFDRDBOZGpJY2FpcGJDV0E0?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E82002994B8F904F941255107D745F74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ls10MOTU13EOQ02eP0QhpViSkQoiRykifI9xiClvWODJ447GGdEMIq5vJqpaqpozG4zSwx2/t4BablSSguizZUgB4aCZ2mbTgqrAr1+tdg9DMWygdJroOUVQzsO3T4fLD+FcSVY8JROOXeGMtmSIbhpbM73Hsll08vdbKffsZobsXBAykyOrBNCHdGotObGUEb5FaWpuxPwR7r3puQFWjPaGraaJz16A9an53x9Tjs6CEZskpWv3MF4EVVdcdZyWARCwxF/M8JBOD9RFKhfWD4hGFbdCBv0kH/vSM+lDhN6k04rIviuyLMCEYVatWDlhQTh//CbOyZjieKpIh3sbSt3T4xCU+qq9sgPaMC3wcQ+Xn3E8ofnW+Ki7sR3ewb4KhkPpZaLXqfPA0zgDw/jBYneyArFqC/00yVWHw/9FjfSQWcM/k6yo/9dbcHgGH3GSW/5iueFr2Ad3K91gzWrYDFtWvOR13SMw5BooqJCRVublWCoYGGS2hYkf/piturl2ZmTS8qKJuelXVzwR0l14hsrhsbNMocY/2+GDUFZI5NsNlyr/jIQmLMS4UDLs4lnIKuoM9VpVamqNIpBGc1UyL3WW5LwVWOp0bR5FmNOydhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23084ad1-7317-480a-8891-08dc1bb70932
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 02:00:12.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vR1fsC3rybTTxqdNemNAmIKXNafa5hSK7LQAwM00OUrRtY+H8Rj+2p3Ah8R7KJHaiTZzTwAZeXNSAiDiFkiTRq24ncw4Bu63JviYi5HPgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=953
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230011
X-Proofpoint-GUID: BakEJguPzsN2LEpR5_BEdXP8MDlM6X3k
X-Proofpoint-ORIG-GUID: BakEJguPzsN2LEpR5_BEdXP8MDlM6X3k

DQoNCj4gT24gSmFuIDIxLCAyMDI0LCBhdCAyOjMy4oCvUE0sIEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAxOSBKYW4gMjAyNCAx
NzoxNzo1MiAtMDgwMCBQcmFrYXNoIFNhbmdhcHBhIDxwcmFrYXNoLnNhbmdhcHBhQG9yYWNsZS5j
b20+IHdyb3RlOg0KPiANCj4+IEZvciBzaGFyZWQgbWVtb3J5IG9mIHR5cGUgU0hNX0hVR0VUTEIs
IGh1Z2V0bGIgcGFnZXMgYXJlIHJlc2VydmVkIGluDQo+PiBzaG1nZXQoKSBjYWxsLiBJZiBTSE1f
Tk9SRVNFUlZFIGZsYWdzIGlzIHNwZWNpZmllZCB0aGVuIHRoZSBodWdldGxiDQo+PiBwYWdlcyBh
cmUgbm90IHJlc2VydmVkLiBIb3dldmVyIHdoZW4gdGhlIHNoYXJlZCBtZW1vcnkgaXMgYXR0YWNo
ZWQNCj4+IHdpdGggdGhlIHNobWF0KCkgY2FsbCB0aGUgaHVnZXRsYiBwYWdlcyBhcmUgZ2V0dGlu
ZyByZXNlcnZlZCBpbmNvcnJlY3RseQ0KPj4gZm9yIFNITV9IVUdFVExCIHNoYXJlZCBtZW1vcnkg
Y3JlYXRlZCB3aXRoIFNITV9OT1JFU0VSVkUuDQo+PiANCj4+IEVuc3VyZSB0aGF0IHRoZSBodWdl
dGxiIHBhZ2VzIGFyZSBubyByZXNlcnZlZCBmb3IgU0hNX0hVR0VUTEIgc2hhcmVkDQo+PiBtZW1v
cnkgaW4gdGhlIHNobWF0KCkgY2FsbC4NCj4gDQo+IFRoYW5rcy4NCg0KU2VudCBhIHYyIHBhdGNo
IHdpdGggc2xpZ2h0bHkgbW9kaWZpZWQgZml4Lg0KDQo+IA0KPiBXaGF0IGFyZSB0aGUgdXNlcnNw
YWNlLXZpc2libGUgZWZmZWN0cyBvZiB0aGlzIGNoYW5nZT8NCg0KVGhpcyBpcyBhIGJ1Zy4gRm9s
bG93aW5nIHRlc3Qgc2hvd3MgdGhlIGlzc3VlDQoNCiQgY2F0IHNobWh0Yi5jDQojaW5jbHVkZSA8
c3RkbGliLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2lu
Y2x1ZGUgPHN5cy9pcGMuaD4NCiNpbmNsdWRlIDxzeXMvc2htLmg+DQojaW5jbHVkZSA8dW5pc3Rk
Lmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCg0KI2RlZmluZSBTSE1TWiAoMTAqMTAyNCoxMDI0KQ0K
I2RlZmluZSBTS0VZIDQxMzIxMjM0DQoNCmludCBtYWluKCkNCnsNCmludCBzaG1mbGFncyA9IDA2
NjAgfCBJUENfQ1JFQVQgfCBTSE1fSFVHRVRMQiB8IFNITV9OT1JFU0VSVkU7DQppbnQgc2htaWQ7
DQoNCnNobWlkID0gc2htZ2V0KFNLRVksIFNITVNaLCBzaG1mbGFncyk7DQoNCmlmIChzaG1pZCA8
IDApDQp7ICBwcmludGYoInNobWF0OiBzaG1nZXQoKSBmYWlsZWQsICVkXG4iLCBlcnJubyk7DQpy
ZXR1cm4gMTsNCn0NCg0KcHJpbnRmKCJBZnRlciBzaG1nZXRcbiIpOw0Kc3lzdGVtKCJjYXQgL3By
b2MvbWVtaW5mbyB8IGdyZXAgLWkgaHVnZXBhZ2VzX+KAnSk7DQoNCnNobWF0KHNobWlkLCBOVUxM
LCAwKTsNCg0KcHJpbnRmKCJBZnRlciBzaG1hdFxuIik7DQpzeXN0ZW0oImNhdCAvcHJvYy9tZW1p
bmZvIHwgZ3JlcCAtaSBodWdlcGFnZXNfIik7DQoNCnNobWN0bChzaG1pZCwgSVBDX1JNSUQsIE5V
TEwpOw0KDQpyZXR1cm4gMDsNCn0NCg0KDQojIHN5c2N0bCAtdyB2bS5ucl9odWdlcGFnZXM9MjAN
CiMuL3NobWh0Yg0KQWZ0ZXIgc2htZ2V0DQpIdWdlUGFnZXNfVG90YWw6ICAgICAgMjANCkh1Z2VQ
YWdlc19GcmVlOiAgICAgICAyMA0KSHVnZVBhZ2VzX1JzdmQ6ICAgICAgICAwDQpIdWdlUGFnZXNf
U3VycDogICAgICAgIDANCkFmdGVyIHNobWF0DQpIdWdlUGFnZXNfVG90YWw6ICAgICAgMjANCkh1
Z2VQYWdlc19GcmVlOiAgICAgICAyMA0KSHVnZVBhZ2VzX1JzdmQ6ICAgICAgICA1IDwtLQ0KSHVn
ZVBhZ2VzX1N1cnA6ICAgICAgICAwDQoNCj4gDQo+IEJhc2VkIG9uIHRoYXQsIGlzIGEgLXN0YWJs
ZSBiYWNrcG9ydCBkZXNpcmFibGU/DQoNCkkgdGhpbmsgc28uIFRoZSBpc3N1ZSBpcyByZXByb2R1
Y2libGUgb24gb2xkZXIga2VybmVsIHZlcnNpb25zLiBSZXByb2R1Y2VkIG9uIHY0LjE4DQoNCj4g
DQo+IEFuZCBjYW4gd2UgcGxlYXNlIGlkZW50aWZ5IGEgc3VpdGFibGUgRml4ZXM6IHRhcmdldCBm
b3IgdGhpcz8NCg0KU2hvdWxkIGl0IGJlIG1lbnRpb25lZCBpbiB0aGUgcGF0Y2g/DQoNCi1QcmFr
YXNoDQoNCj4gDQoNCg==

