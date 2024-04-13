Return-Path: <linux-kernel+bounces-143488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F9D8A3A16
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D57284096
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F54C83;
	Sat, 13 Apr 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUo68NGr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SSI1/u1C"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA52F56
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971243; cv=fail; b=Tf0V/pgtbSm+E2yl9/Re+R+glIX5Elt7FXYJdbfK6aQ2pMe8k6YI8LV+NToy2HBL1f1yK8jg18FjsV5Weaw2yQ2S2nChxPDx/jc0tEVtvfQmKx6Uj/M1rLskCOICCL9PZqtiWYe8rW24kTm1QwcmuXlrG/pFDF6rW7U4SOKt6vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971243; c=relaxed/simple;
	bh=dfSSp6YIdFxydqKADIoPWgDnF2oewVZ8cVWdfBUZdcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=if4Xvyd6znicKTtbvx+CZbFkO52RBv1R/WhpJMiGggzSUkLgPizs8OPKs0ffzFR373NqLbvggY7eyujOZzhr3JFxs7M+9dbw9sQIvIamHeE0lWLuyJOcKAGVQp5BnUHfYz+i1UK6MXhX0+lPQas9maYCmchieHFWyvVap0u3FV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eUo68NGr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SSI1/u1C; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CNhDF2000670;
	Sat, 13 Apr 2024 01:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dfSSp6YIdFxydqKADIoPWgDnF2oewVZ8cVWdfBUZdcU=;
 b=eUo68NGrz9/DrGxIXRez54tyu0nBzHPOqI5Ta8GxC6neG3Wp0yG2g0mnEW94wFDYpFdq
 QtxNnd4ekSCHa0/BS3s/k2cmYqcz7cfibxDKEmNjU9rt4QNuBB8D5aVfaAbULEJX+mE9
 QK6vvjRmPSYMMLRL+1xpDbdra2cdfamvWCyNbkcOm5uBESFFjQorT5+zZ4m2wr0kffMe
 fSbPMazqiFtlMOxGi4+/RZj4bX58FbehCIXVztbqrTcL8Xnhg0CTBiSJSt0zP/PJKWUm
 26njzN66DytWB6xObCMTlZneYF/dYPpbrq/IrCx99UHfj2fDQPVcmoakb0p7ws+SVODw Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xed4jut7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 01:17:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43D0Mesw010655;
	Sat, 13 Apr 2024 01:17:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubp4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 01:17:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQWUIhtjvuZEvOfSB9RwdlK4zKacYbVtjz5nSxv/apKoIri0NVU5J8/qCPa3+3a0EYiMvm6Db4R06aIgkk0ccP1qOb2RiRx5g9WbDuHN9nUzTIIzldljYDePlxdKLpC+62RiTkvmXOmp6PJ5KwaTUxJlLJRejbPis5XEH6gtD74eAfZFmYKK2D3P+qx/usy2IZby+ZdU8/+TmqTVByFO7rtLdCIKniYRcvvuVkdA4GRFb7pSWSEnDTJGNg7GvWC2sDyWEfA76H4vU2FicTG6qX5HVzbs5JgxiGLMPJJAwu4w3FnHa4MvSq9L5bIqWaUHlUADzKusv+TB4IS7fZORjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfSSp6YIdFxydqKADIoPWgDnF2oewVZ8cVWdfBUZdcU=;
 b=b/ShWlH32iczEoeKfSz14L1wuPo6i4ngl4dVqvDFOIZxBIRj70bCCCbxnvvCnZTmm3tlqM6FdgIlpyM/qbvc251HM+RETb2Q8LRajtDRweOP1Zi16zOVEZwA8wj6SadxgtGhzewYhprShurekiBv9oBat4t+efhJqe7ZnzuV1Wkc4sp6S62ciGzOYtek8MGKDiiKwh8ZdTkfBfKhDxmSRUIlk7nRFvTd5ifVAtb9yHf2MssbWGtPw0jnzSJyzMQscNQAUGuegvvCqMU1DHUxOcaRB5KiPlN1xQprhkeBausC2VcVqCETS+j+r15gYwZShr5tnA0tSLSgu6Zc13pE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfSSp6YIdFxydqKADIoPWgDnF2oewVZ8cVWdfBUZdcU=;
 b=SSI1/u1C7Pg3YwZI/jXMlc6ujiIMWUNF9HsUK+p31Baq2GJsbFWbIaIyXt4sZMlLgudaZYeUx4mmkyor/Pu9yU3jiYAL92GFiK69U+WYEJJLNN28bwmNGaPJY7MuVfPqMzg7FbrcB+2Xbk/fT6O6m8ek3sI7DxWmI3Zba4Daeek=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by SA2PR10MB4619.namprd10.prod.outlook.com (2603:10b6:806:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Sat, 13 Apr
 2024 01:17:05 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7409.042; Sat, 13 Apr 2024
 01:17:05 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        "Christoph Lameter (Ampere)"
	<cl@linux.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com"
	<iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
Thread-Topic: [PATCH] slub: limit number of slabs to scan in count_partial()
Thread-Index: AQHajRo7EKwBny8QaEyLi7YCcsTiFbFlZkoA
Date: Sat, 13 Apr 2024 01:17:05 +0000
Message-ID: <5552D041-8549-4E76-B3EC-03C76C117077@oracle.com>
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <1207c5d7-8bb7-4574-b811-0cd5f7eaf33d@suse.cz>
 <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com>
In-Reply-To: <e348dfcd-6944-4500-bf84-c58b8c2e657f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB6379:EE_|SA2PR10MB4619:EE_
x-ms-office365-filtering-correlation-id: 3d16800d-ef77-49e1-e2c5-08dc5b576e59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KZSBWZ46KGvsUcupyYNyPGqvpquosgpihzY9f1kvdhwecM/3cunZY1KPinW78d0M9Bj2ngvBdxPiOAmNfmdDt4gMaz/plU8QOG7ZxYRcj9aIPZFeigC84gEUqOLN22UWOMHXRg9E0lQ1kvUDf47mtQwytfVOU6nEhE/1yk6Aj7UlJ0f/YOHze/MfcMl7yQ4fYPdKYvz5TQ5SGqRyLJu2dQBgXevRJfXUgKBotSdM84LdB/SBfTpfLebGT1T3Q4Sh5pNx0WWuHSbFAV/O7/JgzInPzNZODEPoLLvZ41LAkF2u1NjGUUNLyTpEA5gcAu5aAz3uwbZ1aP4j1WN0pe8asvex6cJdQ3+foL+uFMZuUi2FmTecjYxh9zjksqI8pShhz6MJU+IeBgGpNwe5/LvqKhA35LnNkH2MuBeyvp7cMcmVXdFuX/ur4kEnw1AUZsyD7a5Hv70hJV/m9ehzRZuH9nSBBueFrZbruVX3it5V2US5M4PBKHLjA5xWuinC1BSt4Nyz5+2xMASCJ3N3daLyJ2XL9tKv/qJVBm76zd8izFz2x6UEMQ9kRXzBDMEixv304xLXriMD1smFykrBLXdWggn02Suh7IvOt6O6uqNRCiG1ri0iBnjW2m3iaIKW+dmaxCXZBfcWHhh0h+f9Ao8e0uQyNjiChbjOMZmof7UzV0maUo8DMDowHRBYRNcRAHySNEoQGDN2oEqrFqiwbZD8uNxLCiLenBgETp+1qaYjSl0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?czhLRWxLQ0JHQnZIM2I4b1RibEhBdzl2OWJkRndna0FYc2w2eWEwYWpYNkVC?=
 =?utf-8?B?akROUmFoYXVMazRJQWlZeUZmeXUzazVBV0pWblZZajY0VENlcmNISVpCSlpJ?=
 =?utf-8?B?bC9PSFNQejlyKytaNWdqbm9MQ3pxUVRZdjBudUFOTWtjMUFhZXVDMTg1RDd0?=
 =?utf-8?B?enN4RDV5WDgySVhKYzBwZUUva1krZUJlSnVtMkJzamw0a3JXOStSaTdVZ0F0?=
 =?utf-8?B?TmpuYUkyeVU0K2lRakVySmhiSHJPVERmNWdYTFVod0doLzM2d0EzRUZPRjdM?=
 =?utf-8?B?NjBXaVBwUW1WVmxxaGZSS29qZWhSQW8zY1J5NExVa0tTVXpNbTUxL0JIZWRU?=
 =?utf-8?B?MTJGR2RXL2ZnQmF1NU5ZVTEvUGh2a2didGQ5TzA4OWZObExaYlhvOWFmbVFP?=
 =?utf-8?B?NGtodHVlK1YvZWNDdEZDTmd2YUlCTlVpY3d0UlM2T0tJellwZ2ZSR21hcndI?=
 =?utf-8?B?U2N6TU1GYmJzUEJSUldjcy9KMTlxKzk2V0cvdEN0Z0daZlhqUCtZUDYxR1pB?=
 =?utf-8?B?ZnF6SVNXMW8zOGc3aDdRR2tHOFJRL0REa1B6a1FGZ3Vwam5aWXQrMFEybzJa?=
 =?utf-8?B?MSsyVGdZUVZyMXczb2szTlNFNFFHbWZyRWJtWXNGZVpDTkdyRnowZzB5Ky90?=
 =?utf-8?B?NVlCWS9iaS9UR0ZFRkZHVDNoMVhhYXdlZGZNRFg2L0U0UGtkNGZ1NTBDay80?=
 =?utf-8?B?NkpodFkvRzRxN00rSDhJUVYvZUJvSUxxU1JyT3ljTW43TktRQXc2dFppUUND?=
 =?utf-8?B?bkRjU1ZsUEVnaUhyWGM0VEIySE85aFlNdzlQTW14Z09BLzVKeklCd0NrNHVa?=
 =?utf-8?B?VWpsRWtFdDNrZlJIeWVreU4rSzBaU20rcUkvejdUWXpQYTdDZ3A2SHpzcmUy?=
 =?utf-8?B?Qy90aUxJNTY0TXBHeUVWVXpQODdJek8xc0l1SER5Wk9oRC9zUGUyb0JQS3lt?=
 =?utf-8?B?MmpXMXczb3V4S2NkQm14K2NjbVpTZGMwc0hqcVlkSnl4RUN4NjJBQWJ4ajFY?=
 =?utf-8?B?Tk1tSUozaWN4RHp6Z1dYMWxMZ1ZDKzVubkYzbnMvekEvZEJXcDA1ekN3ZnhU?=
 =?utf-8?B?R1o4bzkxVTF2ejFraXFjV2RIeGM4TzRZcVNHOXUzWERCaWptOWQ1dEgxRVBm?=
 =?utf-8?B?c1BIUDd2Vi93REZoR1NGbVRFbkRNTVRNMlpZMjc1WUFFSVdmb2VHci9SbHFL?=
 =?utf-8?B?SWY1WUxFUjVBVmZFeHc1d2d0MFBDa2xwZmpiMXJyQytESUtIb1hCQXhTdWox?=
 =?utf-8?B?azFIZDVCL2xtM21xdmNzSE5wNmw4a1pja1ZjMkE3MWpySkt1bGZweHVFTEI2?=
 =?utf-8?B?OEd1T0s4S0F0MFcwa3AvMU5ORFFJU3FJY0NlWnN4aE85OXhuVDFoaVd1ZlBn?=
 =?utf-8?B?Tm1EdTV6QWpaZGo3Tmc4QXhteUJOb3hQVm1jQzRPYzlwc3hSeitzRkdmVmtX?=
 =?utf-8?B?R25OV2d2UEhTc2pwWWFXaFd0MlVtTEd3cTUvaXJjQlJwTDk5dFJaSzM3aVI5?=
 =?utf-8?B?Y2NVdWhlSHZYdGFVMjZ5NmZ1M2N5YmZzVWJ0OS9KRkduYjVEazhYY29QOUEx?=
 =?utf-8?B?bEJJV3lvR1M4bm5WRWRpaEs4ckxObXpLSitoMXdESFZvL1pTTUR4SjNSYWtK?=
 =?utf-8?B?eVN6WWdhTURSWUxxZmN3L0MzSk5tem4vNi9MbThFdFZvOU12dzF5ZGl4YldG?=
 =?utf-8?B?TGh6N3M5bFdyem9aOUJPSTE4cFFOKytscldnS2lCYkhoMlhFaC92dlVLcWNn?=
 =?utf-8?B?REg0T2hTa3NkSW5kZzJlQmd3TXJrdUdFN285R2VIY2RCWHZXOUxGUWl6bm9K?=
 =?utf-8?B?dUV5QUlKMmJta0JYRnJTUHRTRnhXUGw2cEZhZ3RpbmxsUFJ3NUpScWtqM01K?=
 =?utf-8?B?TUVmbG1jWDFzaUlKMm1rdzBZU0t0dTBnQ3dXRzd2L2ZYN0dKYm1QbVp3Rmsv?=
 =?utf-8?B?bUNHakhGR202aVpUZEtmOFJhWmlFblBQQy9VSkdtMlJPdzA1UCtsUTNlaytH?=
 =?utf-8?B?KzdPUmxqNWlxbitzNTc1dUZhSDF6dE9RUnVxR2JUZG5waXFKRW42UGoxRkNj?=
 =?utf-8?B?VFlpM043WWFWYVJOczVoTWIzTEtmTUlCc3N6OHV3MUVrYkVwQjZTVGRYUE5V?=
 =?utf-8?B?QXNTRjg0SlBSY3NiZ1VHbXcrVDR6Wmt4US91RVFpVW9vRUJxS1lkUVMyRkY5?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <954D20C813D4A04184BAC65532B568DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	b5Ix7f24xwxoFp6thb9Z+X2MVMIBoC8Z0T1tFrezcCZPenCuEoBV1c+Oe/KrcrW7TKLTCEIEnJOnOSgDyjSUBkYeND31wKx0llY80Sq9dfCA4BVnn5eTRq3IYgVLX8YgtbX8aXkZBsZmXl3M//1ZpUV0oB71QhXw4hggnXeOv4rQF2He2+tEBwAzpC4pBi5Vbj06rXIlrpUE6xPgYi3Tc07XujDd2xO3TgEiqoikzYpt4JwTgHbpQXDxg25qq97zF7gozMUM2ukxS31iWnjrlGIL3K8ErYfaN5kZc4iRI2CfKOHg402XQml+xPXP+lVCEqlk/kl7zK3dmOaYy6wafnkKQMxEPrUMG7zC4C+IEl//PZQ9QEcWoj+vjjWE1pv1TnW6n43yXkZ8Nf0SzC8mchr9p1CbvEKliuhB4mBRr66Ozl3dA7iPhfKmUtGpNV20FvJXYbW3D8ittbVJK/7HUb9U0oBxD1W9rCeT9RYP46Y3rB7045pWWzEDok9AJ5VDCwFQ04p+QZEWaAB622pwYaMX89sUuIJzbS2ZPTKTGooG+MhFhD3WqE/Ol2djFbfqlR+gLHvpJPcx6OvmWBTIsDN7cXti+TiLbFM1pC9OU8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d16800d-ef77-49e1-e2c5-08dc5b576e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 01:17:05.1208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYL7PGsVfdmZFrGKErhN0qTp5G2jUwAZ0V3z9TG8LXq19mhL51JrT1n/IKCf+oNuPB/EMW15vHAqBda/yQ+w3KpZUgLi0Md62rTZ5nJmdyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404130007
X-Proofpoint-GUID: e7_MYdL8qKaMFTtjABr6KjnEH2kxrMkE
X-Proofpoint-ORIG-GUID: e7_MYdL8qKaMFTtjABr6KjnEH2kxrMkE

DQo+IE9uIEFwciAxMiwgMjAyNCwgYXQgMTo0NOKAr1BNLCBKaWFuZmVuZyBXYW5nIDxqaWFuZmVu
Zy53LndhbmdAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA0LzEyLzI0IDE6MjAgUE0sIFZs
YXN0aW1pbCBCYWJrYSB3cm90ZToNCj4+IE9uIDQvMTIvMjQgNzoyOSBQTSwgSmlhbmZlbmcgV2Fu
ZyB3cm90ZToNCj4+PiANCj4+PiANCj4+PiBPbiA0LzEyLzI0IDEyOjQ4IEFNLCBWbGFzdGltaWwg
QmFia2Egd3JvdGU6DQo+Pj4+IE9uIDQvMTEvMjQgNzowMiBQTSwgQ2hyaXN0b3BoIExhbWV0ZXIg
KEFtcGVyZSkgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIDExIEFwciAyMDI0LCBKaWFuZmVuZyBXYW5n
IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gU28sIHRoZSBmaXggaXMgdG8gbGltaXQgdGhlIG51bWJl
ciBvZiBzbGFicyB0byBzY2FuIGluDQo+Pj4+Pj4gY291bnRfcGFydGlhbCgpLCBhbmQgb3V0cHV0
IGFuIGFwcHJveGltYXRlZCByZXN1bHQgaWYgdGhlIGxpc3QgaXMgdG9vDQo+Pj4+Pj4gbG9uZy4g
RGVmYXVsdCB0byAxMDAwMCB3aGljaCBzaG91bGQgYmUgZW5vdWdoIGZvciBtb3N0IHNhbmUgY2Fz
ZXMuDQo+Pj4+PiANCj4+Pj4+IA0KPj4+Pj4gVGhhdCBpcyBhIGNyZWF0aXZlIGFwcHJvYWNoLiBU
aGUgcHJvYmxlbSB0aG91Z2ggaXMgdGhhdCBvYmplY3RzIG9uIHRoZSANCj4+Pj4+IHBhcnRpYWwg
bGlzdHMgYXJlIGtpbmQgb2Ygc29ydGVkLiBUaGUgcGFydGlhbCBzbGFicyB3aXRoIG9ubHkgYSBm
ZXcgDQo+Pj4+PiBvYmplY3RzIGF2YWlsYWJsZSBhcmUgYXQgdGhlIHN0YXJ0IG9mIHRoZSBsaXN0
IHNvIHRoYXQgYWxsb2NhdGlvbnMgY2F1c2UgDQo+Pj4+PiB0aGVtIHRvIGJlIHJlbW92ZWQgZnJv
bSB0aGUgcGFydGlhbCBsaXN0IGZhc3QuIEZ1bGwgc2xhYnMgZG8gbm90IG5lZWQgdG8gDQo+Pj4+
PiBiZSB0cmFja2VkIG9uIGFueSBsaXN0Lg0KPj4+Pj4gDQo+Pj4+PiBUaGUgcGFydGlhbCBzbGFi
cyB3aXRoIGZldyBvYmplY3RzIGFyZSBwdXQgYXQgdGhlIGVuZCBvZiB0aGUgcGFydGlhbCBsaXN0
IA0KPj4+Pj4gaW4gdGhlIGhvcGUgdGhhdCB0aGUgZmV3IG9iamVjdHMgcmVtYWluaW5nIHdpbGwg
YWxzbyBiZSBmcmVlZCB3aGljaCB3b3VsZCANCj4+Pj4+IGFsbG93IHRoZSBmcmVlaW5nIG9mIHRo
ZSBzbGFiIGZvbGlvLg0KPj4+Pj4gDQo+Pj4+PiBTbyB0aGUgb2JqZWN0IGRlbnNpdHkgbWF5IGJl
IGhpZ2hlciBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBsaXN0Lg0KPj4+Pj4gDQo+Pj4+PiBrbWVt
X2NhY2hlX3NocmluaygpIHdpbGwgZXhwbGljaXRseSBzb3J0IHRoZSBwYXJ0aWFsIGxpc3RzIHRv
IHB1dCB0aGUgDQo+Pj4+PiBwYXJ0aWFsIHBhZ2VzIGluIHRoYXQgb3JkZXIuDQo+Pj4+PiANCg0K
UmVhbGl6ZWQgdGhhdCBJ4oCZZCBkbyAiZWNobyAxID4gL3N5cy9rZXJuZWwvc2xhYi9kZW50cnkv
c2hyaW5r4oCdIHRvIHNvcnQgdGhlIGxpc3QgZXhwbGljaXRseS4NCkFmdGVyIHRoYXQsIHRoZSBu
dW1iZXJzIGJlY29tZToNCk4gPSAxMDAwMCAtPiBkaWZmID0gNy4xICUNCk4gPSAyMDAwMCAtPiBk
aWZmID0gNS43ICUNCk4gPSAyNTAwMCAtPiBkaWZmID0gNS40ICUNClNvLCBleHBlY3RpbmcgfjUt
NyUgZGlmZmVyZW5jZSBhZnRlciBzaHJpbmtpbmcuDQoNCj4+Pj4+IENhbiB5b3UgcnVuIHNvbWUg
dGVzdHMgc2hvd2luZyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBlc3RpbWF0aW9uIGFuZCAN
Cj4+Pj4+IHRoZSByZWFsIGNvdW50Pw0KPj4+IA0KPj4+IFllcy4NCj4+PiBPbiBhIHNlcnZlciB3
aXRoIG9uZSBOVU1BIG5vZGUsIEkgY3JlYXRlIGEgY2FzZSB0aGF0IHVzZXMgbWFueSBkZW50cnkg
b2JqZWN0cy4NCj4+IA0KPj4gQ291bGQgeW91IGRlc2NyaWJlIGluIG1vcmUgZGV0YWlsIGhvdyBk
byB5b3UgbWFrZSBkZW50cnkgY2FjaGUgdG8gZ3JvdyBzdWNoDQo+PiBhIGxhcmdlIHBhcnRpYWwg
c2xhYnMgbGlzdD8gVGhhbmtzLg0KPj4gDQo+IA0KPiBJIHV0aWxpemVkIHRoZSBmYWN0IHRoYXQg
Y3JlYXRpbmcgYSBmb2xkZXIgd2lsbCBjcmVhdGUgYSBuZXcgZGVudHJ5IG9iamVjdDsNCj4gZGVs
ZXRpbmcgYSBmb2xkZXIgd2lsbCBkZWxldGUgYWxsIGl0cyBzdWItZm9sZGVyJ3MgZGVudHJ5IG9i
amVjdHMuDQo+IA0KPiBUaGVuLCBJIHN0YXJ0ZWQgdG8gY3JlYXRlIE4gZm9sZGVycywgd2hpbGUg
ZWFjaCBmb2xkZXIgaGFzIE0gZW1wdHkgc3ViLWZvbGRlcnMuDQo+IEFzc3VtaW5nIHRoYXQgdGhl
c2Ugb3BlcmF0aW9ucyB3b3VsZCBjb25zdW1lIGEgbGFyZ2UgbnVtYmVyIG9mIGRlbnRyeQ0KPiBv
YmplY3RzIGluIHRoZSBzZXF1ZW50aWFsIG9yZGVyLiBUaGVpciBzbGFicyB3ZXJlIHZlcnkgbGlr
ZWx5IHRvIGJlIGZ1bGwgc2xhYnMuDQo+IEFmdGVyIGFsbCBmb2xkZXJzIHdlcmUgY3JlYXRlZCwg
SSBkZWxldGVkIGEgc3Vic2V0IG9mIHRoZSBOIGZvbGRlcnMgKGkuZS4sDQo+IG9uZSBvdXQgb2Yg
ZXZlcnkgdHdvIGZvbGRlcnMpLiBUaGlzIHdvdWxkIGNyZWF0ZSBtYW55IGhvbGVzLCB3aGljaCB0
dXJuZWQgYQ0KPiBzdWJzZXQgb2YgZnVsbCBzbGFicyBpbnRvIHBhcnRpYWwgc2xhYnMuDQoNCg==

