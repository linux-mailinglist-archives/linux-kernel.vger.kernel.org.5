Return-Path: <linux-kernel+bounces-8763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699381BBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A991F24A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA9955E7A;
	Thu, 21 Dec 2023 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VUTZMoY6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BsNH0uPU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43123539EF;
	Thu, 21 Dec 2023 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLFPu4X027779;
	Thu, 21 Dec 2023 16:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dUdWrFDqjPPmYxgrSFrj+Fi1UL6mMrvYyvREiZxu35A=;
 b=VUTZMoY61Ysex6SA/IUEnilN/ID1ZE6mZsUmP7sFCNMBflxeeFp5mfdT48pJPyEfTka0
 mvS6o1f8mk6aPQWbMc8g2jGjytDEVV92NP79DbKWyGCdJ3w6dRGJPXqT1QHeD7jptsrP
 xOH8UfGTNiwB71tuqAjsBS+hZ8xve8cvYkhg3b9F1csc9/FVQCXv2jTTBi9na55ra4aL
 HuW28FPluP99/q1kjKo3Go+oqXhh0RNibm+zRo5RH6c0DrK+NXhRLieJUp7xGR1Dp1Fr
 qnsRegsB6x+j4JWVl2jHRUEv1umTd0Wx3KIyeyZTkxW/mJahSlJ5s/W5dCkdEy40rR+N Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12tcbe5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 16:26:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BLGGq7I020011;
	Thu, 21 Dec 2023 16:26:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3v12bhdwny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 16:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4X8eeH9T+y77RkjBWyt2fSkiHT2xmbw+/K0g3b8h4gm2YlzpTMJ1Oouimbv2vCK6ehtVjcLE5FVQMcU54IOLMIiQ734K2D7HHYUeWihpTb63g/XaPXtDfwlqObGfWkvoOVgIUsO2XFGnCU0q1CDjO4lCLGQMBiFKnqYu4WQDkhCH/tSUqH/qHZsaay74SDmsOgFv23krpXb1T2cyqdwq2GDk+knrzRnyECguP0rS+Ovq0jqc/jFAfoWrh5AgF6glVVyOtDREOi/TNs/Z+pMrQ/SkeXI5Ae9AoaqER6nXR6vYbrH4qpbluyZWrsnF7O/lah4GxKoSS2j+kS9yw8xCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUdWrFDqjPPmYxgrSFrj+Fi1UL6mMrvYyvREiZxu35A=;
 b=LxgzthFv8HwM2xX69Wt9FxzZWNHwfDbqfUrj0TZVidDGOVl5AZiNO7ON86GPxeqWy/hf1POWNmM5dgk4N8wE1/30c4rxc5+hPKVS5EpuWhnFtZT86Z2msqCWHEun9nO9jSD5B3FT7l51TmvCBKynK+KXBdRRZ/6DCrp2Pf38qt/urDFaj/PI1Vdl6BMwGu3cRQ8P9iufEFO+1Dd1i7rC489pNITUgcnbfOcsWL4Y4PZ6YQW/4S3C42ZNlbkooVsNvHMfpxpriBmsF2v6zq2EZO4Wvll9Q6VbfbSi9MA4iWXkT3fk8gz3jh/YBt7fuB8Z4n0mUoYYt8I6opXS7nBMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUdWrFDqjPPmYxgrSFrj+Fi1UL6mMrvYyvREiZxu35A=;
 b=BsNH0uPUvSem3XOJx2Yj9JiRk9j6ZyCWWwat3ZFc7azkPrhKG2m42TUIIiK0dgl8HMZWheA9NND9Z6B3S/r1551tqrpPT6ABarcdlTMYqwEuDi61ZW+8HeHjw1jXhid8RC1XvuQIO/LPP7PDthZokuSkIORgZID9tEe265b++6E=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB4776.namprd10.prod.outlook.com (2603:10b6:510:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 16:26:54 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:26:54 +0000
Message-ID: <aa6ad7d3-f484-4239-9f83-e89199da2909@oracle.com>
Date: Thu, 21 Dec 2023 17:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-doc@vger.kernel.org
References: <20231214070200.24405-1-rdunlap@infradead.org>
 <875y0zqvjr.fsf@meer.lwn.net>
 <93e1b9fa-c447-4f7d-9dc7-825ebe9e1cde@oracle.com>
 <877cl7a8gh.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <877cl7a8gh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0012.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::17) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH0PR10MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3fc076-4225-49dc-85dd-08dc0241a522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dGczAUiqUgxmpVhwgoWfildAvLYqXtuBzVr5M8pEJZnSEs6ZuKIYdiLQqIwxdyyujblSP8dX16mQyE0K5L6ZtDtfiMGDX0q8kRV6zjWn+4Bcw8D06qVU86EDVQ0nBrVN1wf6aB2A9hCf3C+x4h8VvuBuCEBWE5J4QM570e/2DePjcnN0CHaJnN+q+bxwaEeOlGikpTT/9Dj5q0Oj5YwlU7XasbOcB0vypsyERAma9ROggPl2M0DnTNJRN1D4zLf60Isv0ddcaBjWhaWdOE6yDCmqUVVq5DoKdRRvPL2XDXO1G4X4XxLqvaWxe5GME4eYHjMvrE+YBqXj+oq21Fsqb93JeYXakpMKGBBbkve1dJpLaIoNvv+3VHF16xBf+LhKMCSwrqvjLLNpa1kEJ+f9AoCVb99a2vgXVgNBypBaXhm3RHU3YFWyRLxI3RGQ14+5tmOcFF1VIxOFVtMTtDO5Mhm8KOguYXWneVKgZC4KnWPFjdZRMa79YPjCWZBDXHkBxpFMyxOVJGTW3O0wTnfvcg0vQzjqEbkloR0APiDtUqni11/FpTHZBQ1xUAHG+53UiG+dm9VtlUNOPkPJdUmCIpYOPpkSUSWtspOaXIBut7zOiOdM1ennI5cHirHII+aihi3tBV+db9dwU92yddM8XiPw+BFlzt/a3cTK2XCcbmdnczfo2UG2j3owBUodtxw4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(83380400001)(26005)(966005)(6666004)(6512007)(6506007)(53546011)(5660300002)(44832011)(2906002)(6486002)(41300700001)(478600001)(8676002)(4326008)(66946007)(66476007)(8936002)(316002)(66556008)(110136005)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUZWa0VnZEVLeUxEYXRic2hBTGdBRzlpTnovWGsvZVdkdkdPU0poZ20vaSt3?=
 =?utf-8?B?cjdFTS9IOTI1cEFnck5iY2I0ZGpJYnp6NUdxNGwvQ2IvTWd1OTFzelh6dExU?=
 =?utf-8?B?NmxuWGlvWlFVdTRVUDRCRDR0Mm92U2NJcnhCQVVMNWZBclVPaXk1cTg0U2F4?=
 =?utf-8?B?V2pFUGpYMXgrTENxOThlUkxZTW5FOHEzM3MycmdETUpBS2dLS0lvbnV6c2xT?=
 =?utf-8?B?bXJVRVdvQyt1ZitKeFB4eUU2Z2F1aS93bGVCdHNCdWhpTEo2Tm8vNTBCU2pF?=
 =?utf-8?B?RXpzMmhNVXFnendzUnF0MDY5ZFlCMjBFNm5uL1hWN1FyUW1LL2tKUkVkZU9G?=
 =?utf-8?B?Ym9iQ1IybzJNSnFQRitUYzRpMThtRUVmb3dvTlh5ck9PaXpKZStxYXl5cnZ1?=
 =?utf-8?B?UGIydSs5U3ZGcEJ6WFpxWXM0Y1hzZnZKYkxXaGp4d3FES2pGekcrRGplYVAz?=
 =?utf-8?B?ZjZwT1RFTTNTNFdsMzV0UjliQTN1SDg3bC9XMGxnRVp1bVhQeitvNXd6alQz?=
 =?utf-8?B?dit3eUZ0dEdXOTBhVm9DSlRkMC8rR0Z2OEZrRG8wSytLYnFHbVBHMTl0eW1o?=
 =?utf-8?B?N0dDVlQ0dFZzb3lMR2NFbDFxOXlRMTBQVURZMjE4bGdmTkpLbm5kUXhzS1Bu?=
 =?utf-8?B?dEJES3JBenNBKytCVkxiSEkzalM1SnVaQTZ3eElQZ1lRUTZJc2FGZ2N6U010?=
 =?utf-8?B?ekdjWE1nMEFyOCtrZXVzb0dUaWdMam5nMmpSREVDU0E1YkMvVFJrYUFobnpj?=
 =?utf-8?B?Rm8rdFIrUWZ6RmVjeXpKNTdxcUMzeTUxTjl3L0FUQXNrZEs3TFM0ZmJSZm9B?=
 =?utf-8?B?UVRrWjVyUlp4QVBnQkNxVlF2a0RQUDBDT0dHN24xb2M0Z0pBZDNFRFBuRkIz?=
 =?utf-8?B?NHlCWm14VjgrcWdSay8zOU5lbE94a1JwT1EreHkwUDB4Mlg0VG1YU1lPWnc3?=
 =?utf-8?B?R255eFM0d1kzZTFqNVhUeEZ6eStxdzlxdjBQSUJNUUVBbFVza3lXZXU5Y0pS?=
 =?utf-8?B?VGtoSGdmd0JKdE9LU1VoVjBXMEVOeUgrWGxDUUk5aGhwbjhFQmNMRGdqendv?=
 =?utf-8?B?QWhrQkZING9WNGRKQzRadFNPQ0xrWTJ0OFgyaFYxcWkxS0JHZWFYN25rdDVV?=
 =?utf-8?B?enhWSkVqRlI4OHZZV0VndGF0Sm9QUFprU3pkeUtBUmE0eGRBMkRMemFzOUt3?=
 =?utf-8?B?dDBDdE5YUGdGTHd2NUhLcUNBM1hvV1AyTlB6aWZLK1p3bFdaWTE2OHRybEU2?=
 =?utf-8?B?d1RTRWgvenAxU0tHNDMyYm9BcUVjRlFXZXhjeFpNTFRvYkV3NWJNZ0cwRElH?=
 =?utf-8?B?amtBam1YMmxrczlNdktNdVp5VXBmejVjU3VyY1dlMVEveXNRcythanVBd25m?=
 =?utf-8?B?OXJNN1lTc0ZyQWJDWjJIdEVIZVBFOVRXcXV1bENzbHZ6L2JyNWhpOFVaOFd1?=
 =?utf-8?B?cXdqLzlDaEg0ak5tZ29YSTRoNzZKeUNLTS9qeUc2eW02REpoYUpXOFFBaS9Z?=
 =?utf-8?B?STdNdTlZdG9CY3QreDlpdGh3eEppNnJNdStjQ2F2UHhRNXNjSXVDS1dGQ3Iw?=
 =?utf-8?B?T3RTVncyNHpObVpyVkduYWJ4aEFrcnVnZjFsZjVVS0RkWHFXUHNjcS9jTC9a?=
 =?utf-8?B?M2dCTUtXcFNBQ3plczc5dU92WmpLajEzNjVJS29JbFhkZ3V0R0NVaDMxdDBQ?=
 =?utf-8?B?dXBOQ21SREM4bXNqVDVTOEdhUjBEN3l1Snk4eEdRZ3A0RlhaUkVsVGpWTXJ5?=
 =?utf-8?B?T1NyM2pnVEtoaXgxRlE1bjlCNmQzOUJoNTZJbklPZmRjZE4rcjVLeTVPTVRv?=
 =?utf-8?B?dm5JdjlmellWR283dkJHbG5uNVpiUi8vNFdvejFwZFNVUnRKUENudThybnA0?=
 =?utf-8?B?MHN1NUU0Ti9kYVdMS0V4ZDJRYkV1RjJHaG04Z0ZwcGsvaFREYjdyeUNlRzg4?=
 =?utf-8?B?R0JOT1VNTzd6MnlncDJraEQrLzRGOFcxQXUvRTNud0srL1hyTnppYXZlbTJH?=
 =?utf-8?B?MkZua1htWTUrc1ozaENQWTFQRGV3WXJCbXAxVjZuRng5MzNoYk9paG9mVGtS?=
 =?utf-8?B?eHgyUmxFNHBhc1V2NTBmQnlWTTNrRzFSbmFPSU1rY3I3SFV0ejh0UDFra2l1?=
 =?utf-8?B?Q2Y2bDFTQldKc3BHU3dhdytmVmpmaGhDc0VXSXdqL2hzdHlQVENrMzBqY1hJ?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	39GSnsOAQOo0ThpLpY7coYXF3iCchkxvy2nk641umbkKj3+rTvWYfCX2pHXi9hngMZ6cczvAxfAaEMKndopOAvhh0uFlLVYIwOQfNQDj14bLqRrEf0WZRF/xCJTdc3wkXQLMfjlm25f05xWiTHRSp0z9u+jSYWEuk3ge5nPegMufrYvtBHFTUGi2XCctZI3sizkLCFlj5PSHQpaMrVdMsCkXdMC/nXVEVrEZt4DkZxbzfzQs/wr4UYAHPxIPyKCKS4ibnIeUWzn66pzoaHfDECPnyIfJweLrC3uxi/R5q8qaCOsSt4ZZoWccS8KbXosiqmdYsbcaHwznt5yvKjstZ8Low34dKceJ+trtNpbWoQI7q2HgYPwaadm5pw1TlYNPk4YUhHjZoCHIsmLB3hbexloXmfUdCfxOptpjSPcYf/pSe3tQn98pAwd1uGTqMUg6XhE1ny1VAUh8fKzQZp6NSEnvEp+rKQW3CWeOXQAFgxq0fLNPXfcyVkHJm2OxNqHPKTn+57e0EtMuxkAFU4lMJEQU0i5Y30fJ6tNkLE1V2wgHb1nDD7vdXymra/DLl/lKUeWfA44DTDppE3R7htqo+EXu9exUr0X3KWIUh+ePDCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3fc076-4225-49dc-85dd-08dc0241a522
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:26:54.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLnp5WBH5dz1x3NQmaxftz7aehSTZuLdT5PmGVxR8oHjUUBnArTGcydwlrjAnBpGkm37upW5myA3AZru0DQGGGGyiL0Ik7diZMq7StlZdfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_09,2023-12-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312210124
X-Proofpoint-ORIG-GUID: TD1yA_4r_UeqhBLvBxViZAg3jwp410wJ
X-Proofpoint-GUID: TD1yA_4r_UeqhBLvBxViZAg3jwp410wJ


On 21/12/2023 16:20, Jonathan Corbet wrote:
> It's mostly done; I've gotten it down to under 200 and sent patches to
> make the changes.  Randy is working on it too, I know.  It's not always
> just deletion, but the fixes are usually pretty straightforward.

Ah, cool. Will leave it to you, then.

>> On a related note, it might be useful to have some kind of "status page"
>> somewhere on the web for the docs where you can see a list of unresolved
>> documentation warnings in mainline/docs-next/next without having to do a
>> local build first (as a way to solicit contributions).
> 
> I suppose, but how do you know you've properly addressed the warning if
> you don't do a build afterward?  I don't see that saving a whole lot of
> effort, but maybe I'm missing something?

You would definitely have to do local builds too, it's just about
raising awareness of remaining issues and lowering the barrier for
drive-by contributors to picking something to work on. I can only speak
for myself but I find it easier to go look at a list of known problems
than initiating a docs build and waiting for it to come back.

Syzbot has monthly per-subsystem reports now (since ~March, AFAICT):

https://lore.kernel.org/all/0000000000007fbf7a060cc67998@google.com/

A monthly email is maybe even better than what I suggested.

Anyway, I'll try something out, we can see how it works.


Vegard

