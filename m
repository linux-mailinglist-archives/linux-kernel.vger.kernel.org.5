Return-Path: <linux-kernel+bounces-636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A412D8143E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C853B1C227DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3041802E;
	Fri, 15 Dec 2023 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLt7RenB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IMP/dHyQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEE1798E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMHNAt009640;
	Fri, 15 Dec 2023 08:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=h02hCTaiBPvLo8hJwZM0wdgjG1FjBslzmndPtjVUm7I=;
 b=jLt7RenBB269QYgMoUPuHza9QbuS3DSZNLDbXi68eaCYSEEloy3bH2t+AL6BOTSohi/h
 cz1B1V/WJP1L8He2JbngeZfV/tKJgHGNpLtCC1FRjC9Ix6hua21mZcuX8UAwQVGl+9fs
 FnsdhvYS/JejVcCUZLb8SEsiMJ+qa0VAFYy5uCZX/N3v3lUK6CA2u/LwW1bhldZvKwRo
 ogVXWdCSOCGR0e8vyNXaicTaFkj0F1vC5YZZ64ACDRFfoh4EF15Tab8oCBsaDGoqpVt0
 kAIjEqsJOK9I3yqpSssuS4sQVNTSBNmd2V4O+d4jzIByimuQ5bZmophNG/00Y1Z7Q0Qm +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuucvcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 08:48:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF6fa0b008248;
	Fri, 15 Dec 2023 08:48:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbfem1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 08:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObKVuvYrzo4NN3KtavMLymv6hdmXHyQ56YrReWZWG3NB12UXqHTkkRS5loVzwyBHKCgrdd2fkAaKUS6exINlZDnObcivopoQ+0l4/S1pWfHHCRd9FwGwHBSpHnlS5pRPsnBc3RxYKLKikR2+jNxlr7uV6fFGXKroLKFQZjDveMgIbZZmK88af1jXSeJrZf9U+egtICLVFAEXKXBwatZmiQkNU0d1oD1cMx9L3jGv1TjVtLM/fURKHy9LmnaeiRFy8+4EUZYKMLiNpYIiy6r9nEckDAR4yBHGYBmsWYh96KqwQb+/hjbT9oZx+xxla0sF/tIGOqZsiJVRf5MIj3ENPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h02hCTaiBPvLo8hJwZM0wdgjG1FjBslzmndPtjVUm7I=;
 b=YUa+Zxvat2REc6sDrgPq9OjOUUkBLo5L0obV/JxNn6TuXHEFzgnOf3AZeVvn1d6hm3FvFOKgqZtSKsjXAI/2inxkQsMFNTBSxwHC+Bj8YEPQzo4Nl43F5gFX+8XrFsnq6AbTWvVk/ySyujsZSTaK3BzQhBQB7hJfJmRhdozj7UJPoJETftoD08BFSchPjnHiZQ/eOwyFNiIz6meaEcuNlNQG177Ezky/op/NzkIafIX7+HigDtbrg0r1i1CWMt8HEM4Jvwu907Vs1ZIWsOaw/DuWwuFFYaVLRfO4pDgA1i1SPf5IwTYnx9uBCqpa4QK99edXkbYJjuI9wPP2HLI9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h02hCTaiBPvLo8hJwZM0wdgjG1FjBslzmndPtjVUm7I=;
 b=IMP/dHyQjr+mpoJCpr1DDzcmP4xlzIqey68YFyUE8o0EZlUg85KJsU6zpcMGhgtTbv/j526o03fTplT+7UZic7zYQbRsRFnz2l3nQlHmv5bFRgDgVUgoQ5NHEiVeFmPr4WAWkKOLj/zgXBfYLkWH0oXirWhjsPcdyUKToNCG9ME=
Received: from DM6PR10MB3564.namprd10.prod.outlook.com (2603:10b6:5:17b::26)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 08:48:12 +0000
Received: from DM6PR10MB3564.namprd10.prod.outlook.com
 ([fe80::8eed:6b59:2786:1ac2]) by DM6PR10MB3564.namprd10.prod.outlook.com
 ([fe80::8eed:6b59:2786:1ac2%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 08:48:12 +0000
Message-ID: <1610bab2-78fd-4010-9f50-486952f942e6@oracle.com>
Date: Fri, 15 Dec 2023 00:48:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: remove redundant lru_add_drain() prior to
 unmapping pages
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
 <ZXuJKAInbgtuSU9b@casper.infradead.org>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <ZXuJKAInbgtuSU9b@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To DM6PR10MB3564.namprd10.prod.outlook.com
 (2603:10b6:5:17b::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3564:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b3b93-d479-4762-a7c0-08dbfd4a91eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qx/YA35ao5JC9MLQh3m0uot8/lO8ZdjLuoVubUtEQSv4Gro8gx75ei8yoM/O+tzr1fAe2WYUgEfaKxdDAC7bHGwvxCTJD+dWic910SrPaQ7anzTVAK7vuEXWovO+7s+rSu045qG4hXiqVE0T8SAb9rOKoQOWvyzN9iI/0TJcjjs8jCRdsiY7QJE3gIYf4xmsVWQahaaUgGrNOuFACgWARDMAhpGu8JvO7UpTv7hCkVOQwBPQANUkp6JJ11fjF5bNdEMp88IaddZ4Ug3HLVyCZhB32TBva4GfN9JKZrMmTH7kE4PHXP4yNeA35ZmECeXdfKp/g8sC2DfRrdWpvcSS1rp0GF2Aq+RMv7Txo1+3NHq4ijZvlSnSGGzW1THaBdKIv9THk9PMeVdy4FP6fx4PflhHggHWsd2oSZBmSDcwVGWjaY9rABRyAd1LYn5uMaYi7dDA/hLH/mHAH0QotZSTZkA2EOBKvyIdvJ0PiTZXSLLJB/G4I1Gg3PCboLhnKHeSJfMSa62+ICsBgV+fhe+myfVDFc64+pR22T9u6XLvnWiWroDBlAR1eAvrxTteglz/0gGxwM+jnelNSm+h161vrMtGAYywvJkrjHEer2w/wc0vuOctVhLY1jgnHJqIuw7rkS5V8Y9ihsTUdj1zlCDC/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3564.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(8676002)(4326008)(5660300002)(2906002)(6486002)(478600001)(6512007)(6506007)(53546011)(66476007)(6916009)(316002)(66556008)(66946007)(41300700001)(38100700002)(31686004)(31696002)(86362001)(36756003)(83380400001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWsxVEJrNkk5Y2RJKzR0a29wdGJhK2RoaDJFZmhxUnVQcnNOV1MvdHh0QXJL?=
 =?utf-8?B?VGo4cFhNMVFuQkx3b2ZyeGFpWG8vV08vNWUxNlpOa0o3aVRDV0twQlB6bTlC?=
 =?utf-8?B?amdSQUt2KzRybkl0TDJJaVZzZVphQXJwWFl0L3NaNngwM0ZySDRxUjJPaFIw?=
 =?utf-8?B?b1c2TmMvdjJ0dHRtQmp4UysvRWZoaWM3NVNxdWVmVnc2QTVycEgrUjhabjBU?=
 =?utf-8?B?V3RMZVA5aGtMOXJqQnd3TzJ1bkM5b3pkU0hKZEE1TGZSZ1lvZ2pTRDJIazBC?=
 =?utf-8?B?Zm1OblpaR2hLNnBuQU4rZzJpZUwzak1YRnRWTm5mdzlLVGhWTHNFRkJ1SHdL?=
 =?utf-8?B?SU4zZnU5dUFzS1RybHorYVRZUGpDK0dhMmJDU1NVUlptRkIwM1RLeDdVSEw4?=
 =?utf-8?B?YWpBNE5IMnc4ZGpyYmdHRlgydkdvTDlFRTZaV29OUVRQYm9XK1BvV2F4SGVP?=
 =?utf-8?B?cE5HL2lUUDVlcE0rNlZpanVjNnpwbGQ5NU5oU3h4WEllYlFtelF2czNwNzhR?=
 =?utf-8?B?RmxQZ29KblNRQzRhVzVvc0pobFhqWTRuTU5oZ20xZjJUK0hieks4OURsR2hm?=
 =?utf-8?B?c2dHNy9ud3l2UFN4cDRGbXBUS3lNZFg0UmpBRDlZaVRvT2wxbmprZDhnbXUx?=
 =?utf-8?B?SkRNY2s4SGFhTGdSbUhFakNYRThoR2xhOTI3aDFRRGIyckh3bHdyZ0tVT0JP?=
 =?utf-8?B?N05SbUNKaXd0enE2bFRuWFBVV3l5RmZpVWkrVEtoeG9UaWRaM2NBQzNJUHdx?=
 =?utf-8?B?UFZCVEZVbEREdGJRN3VPaktMWGZqbVlSVkJyVDZ2bGVMRzhLekREVkdBb3Z0?=
 =?utf-8?B?Z0VWeFRUR1FQUDl1cDRFa0NacnpNSFh5NmR6V09KcUMwY0F3N1huOXNxaHpq?=
 =?utf-8?B?V0N3d2NFSGk5dHF2QXNob21hRDFnUFFBbEwxVFd0c21hS3U4Vll0b2hUeGwy?=
 =?utf-8?B?aU5XeWZ1T3FENGxkRWJUQ0svbXFvZHRqbzhjZ1FNWkFSTTlpdHBLYUl4ODFs?=
 =?utf-8?B?L3pDb3BmWlZRZ3Y2RFlQRUh4QnFsLzFGdmluU2VMcmRVNTEwdWtwb1hzV3Nl?=
 =?utf-8?B?cEZoUzBUeUVuSjRaNnlkRXE5L2NYZkdiUktZY1NvWlB2TS9yWC93bGEyT0RX?=
 =?utf-8?B?OXF2RG1oQXZQWmVGcXNKeENSK3R2a2lueFFSUktONW1TMUtCZWNIaERKSXdG?=
 =?utf-8?B?dzAzcjVLSWJtSCs1TkFTMCttU29oTzQ4dTJkbGRCUEExTloyZEJYdDVpMjNn?=
 =?utf-8?B?dlBFbEhKWUhkbmJVOE5QYVpVT29PZ2pMcGtGNGpVWFZYTnRla0l2eXZ1bXJ2?=
 =?utf-8?B?NUM2RWJFTXVZMDI5emErRDF2VldpcElKWCtZUkxXMjlBaU5RTFdsR011cmg0?=
 =?utf-8?B?YTBqZ1N0cENZS0ZqMkwwdkREdFFTNTNVSWowem5RbWhnZ3d0TForajVpbFRI?=
 =?utf-8?B?UEJLRll4M3QxQisyTk1sUnpiYThhK09JaWdiWGdOSzJEN3d4aXVpM3AyYXlm?=
 =?utf-8?B?dVhZbDVCLys1V0trZUxJTXJGK0FTc2dzK3RSWE9La251Q0dzZFk0NjF5YnFI?=
 =?utf-8?B?Q1FvSmgyZmtwQzB3VWlCRlJ1NUlzcEVsa2VCTXlIc0I4amZQZlMvK0JuSTM0?=
 =?utf-8?B?dDBVeFZWSkYrR3llNGlmMEZWQ0RHK3RHbC9OeEVWMHppaU5XV3F3RWlZeUFG?=
 =?utf-8?B?ZEpheENBOHJXUXBnWWZOOXdqbVBsY1VMbjdBK0lHZXovUjIwaTBONGx2TkZC?=
 =?utf-8?B?anFEZi9hOU9LRWZNNWFXWkVuVDFoSlNVMDg2TjhaSVVVMmY4N0tmMjYvS1VY?=
 =?utf-8?B?U1hHQmpodHlYZ0VHaHRyNkdvQWVTSEZoU0FKTzZxNlZDYVNYQnJTK2tYNkdV?=
 =?utf-8?B?cDVnR0kvOVB5dEx1VDhWMU5pYkhHWTRnOVBINHo5Q3FSendEL2lqWFpWNGx2?=
 =?utf-8?B?eUFEQWlqSHpGK3VTKzk5aHV3bklTeGpUWTlLcXQ0UXZzWEN1TGdIcFhNRVF5?=
 =?utf-8?B?WHJEbFhSemtRMmRKcUtMZnBCWjAra242V0pzRmppZVllVXhpZ00zcG9Ta3pZ?=
 =?utf-8?B?QTZPWU82NUtGYWdaQkhRTDU0emVxTTMxTEM4N1pMSEYyc1RMazgzZmRqSG9E?=
 =?utf-8?B?WVQ2aWg2VCtyZVhlR2NZTjdBUkRTUnpQUGhZM2VTdFJCaDUwOXlWUG1rQjhJ?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	88XXwEJH6eV9HQ6hSA0N4KctoC39TBE+kBXgK+xyvBZnckWrJYBH12n5db/PaYfxx0ZHf47urGE2Xk22rGq3B3Af7l6BE2ebueQRxq8xCYzeTJP1BkyLAsdpsvzog57BGpLMfhy2z+LkTX5dY35ngg4lnJbJjWtA9ikVX4c0HL0zkMQzewBG+i8ZwxgpiBd5hu2fE1fGEM2SXr5y4gwJJ+9BTZFk0E92tcV9v2fvSNYl1qHlrpJw6A3EGmuxn5+pHHs/LoRvmTUJNGa6xT0hBL8VsNFQeC6DobsNUbfIsNhHPA/EFAknzKb5jefXQRH8AXH88+mS7Xq2cjBMV2dv2hLuOHbt7xPtRE0NsfoTUDWnmovDV+d1D8MXAa9/dY/OyCgg8tmtPrCquQHRwtS0TWCQ23XO/mtr/bGNO3iZ9NGIY+h9eOUihzdwSvZ7+gAlUkIeOg6gQ5kpsPEkk0B48oLLMDGY+2bQdmc4V9CI2qTCQHWYHX8fFQCl9N1e6aRXzKzGmmcJbyirzyt8Pkf6SQaDKEIrB4zWDTAawh+l32KqLPQ9XqgQmGYAS1SPMNSqdDJgkMdcuBuC4FVycXdWd9mPaJc/1f2Eop7FuqEsLjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b3b93-d479-4762-a7c0-08dbfd4a91eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3564.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 08:48:12.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g25BQxNPwqaMTBvzt9NQBovKbkFpdwf6iBiGtjvZG087ghHuuNhQLHH6OZnR3TGAnPt2qwR4wSfTuNf7fMTlbQZsA2omdM60uaH72IxQsWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150057
X-Proofpoint-GUID: 692s1ez15y7BvNvG66KwDjc0TmoFDHjK
X-Proofpoint-ORIG-GUID: 692s1ez15y7BvNvG66KwDjc0TmoFDHjK

On 12/14/23 3:00 PM, Matthew Wilcox wrote:
> On Thu, Dec 14, 2023 at 02:27:17PM -0800, Jianfeng Wang wrote:
>> When unmapping VMA pages, pages will be gathered in batch and released by
>> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
>> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
>> which calls lru_add_drain() to drain cached pages in folio_batch before
>> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
>> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Remove lru_add_drain() prior to gathering and unmapping pages in
>> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>>
>> Note that the page unmapping process in oom_killer (e.g., in
>> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
>> redundant lru_add_drain(). So, this commit makes the code more consistent.
> 
> Shouldn't we put this in __tlb_gather_mmu() which already has the
> CONFIG_MMU_GATHER_NO_GATHER ifdefs?  That would presuambly help with, eg
> zap_page_range_single() too.
> 

After looking at different use cases of tlb_gather_mmu(), I feel it is
questionable to move lru_add_drain() into __tlb_gather_mmu(). There are
two use cases of tlb_gather_mmu(): one for unmapping and releasing pages
(e.g., the two cases in mmap.c); the other one is to update page table
entries and flush TLB without releasing pages (e.g., together with
mprotect_fixup()). For the latter use case, it is reasonable to not call
lru_add_drain() prior to or within tlb_gather_mmu().

Of course, we may update tlb_gather_mmu()'s API to take this into account.
For example, we can have tlb_gather_mmu_for_release() for the first case
and tlb_gather_mmu() for the latter. I'd like to have your opinion on this.
Thanks!

>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/mmap.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1971bfffcc03..da0308eef435 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -2330,7 +2330,10 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>>  	struct mmu_gather tlb;
>>  	unsigned long mt_start = mas->index;
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	tlb_gather_mmu(&tlb, mm);
>>  	update_hiwater_rss(mm);
>>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
>> @@ -3300,7 +3303,10 @@ void exit_mmap(struct mm_struct *mm)
>>  		return;
>>  	}
>>  
>> +	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
>> +#ifdef CONFIG_MMU_GATHER_NO_GATHER
>>  	lru_add_drain();
>> +#endif
>>  	flush_cache_mm(mm);
>>  	tlb_gather_mmu_fullmm(&tlb, mm);
>>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>> -- 
>> 2.42.1
>>
>>

