Return-Path: <linux-kernel+bounces-22863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34D82A446
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EF61F238EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BB4F88B;
	Wed, 10 Jan 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="VbsyDy0u"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2127.outbound.protection.outlook.com [40.107.14.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365744EB55
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfSFCornNbozWo9JdTSYk3/zDy7dQWUtJMfZ0U5++Ae6qTBsbC2h6fi/jNgtNRRrEMXG32cdVHHyF0+7BErq8fW0fDuZw0jnPzkkvMx9l45uoP5272IGejL72XrKRvOBYICLZhXM/QcgX02hBNx7am+xudfyy06VT1DO9nmi87eOgzYruq/Mkfn38s1GtsgQmmPO4CK4/TP34vIjhv7mCIylvh9phQtC4o8/yxclnDeTBkd16PpoQmwy6fAqjjAMVKqvmLE1SbiJmhOZW4aCGVRtOVzaqiJ1oxhnZFjItp2e+awNTxmOVKnvvQ3CajOBgNKj1KshqdZqTbUbmfpXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cSqXJb2lbMqwBkYqN+FKElvfBCK9qJAIO2sWdxfuMA=;
 b=jzQtpPD+2DBpNS4ga7dCOO0fLbuUIAaJmuNP+Fx1VjyLGJN00BLY9PLTx41OIgQK33xgtNPERMgwhDm9keJa+W710gz2hD9y+PzPNYzYNKcnX366GutFHeu+Jc5QhlriFWuZaKRi+taATRMNjfFHPBN1k8TrxjTVQV1RENi/XztOJXFaMXmuEbpnfqYbUe849IumF5xpPVEtaqUn9FqJrTok8YVrW8OV7uK6FWHFMnOCBWhLGhOGoE8ozfO+eyfdkMu0XRAFwRgrtrY3hNbkCLIetbc/s8d4PQK843Momp2aAfwwFi94oJypaEjoreKeOBWXcJBLR+rouHuXEw/nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cSqXJb2lbMqwBkYqN+FKElvfBCK9qJAIO2sWdxfuMA=;
 b=VbsyDy0uW0E8C+cY6wghTZgrdKu+lGaQoiFemjxPYPIYxx6S6LJadTsd2rn+K62FR+nI6Zp5YcSVnfNsBfb9U6Htp9ICMJo5LJ4l90termBvJS0rwLH1Ei6qhUWtYlQ1rOZtSpRvwBUKfH+d0G6ZLBHUu2W5K084hl6xwqxPwrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB5853.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 22:52:41 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 22:52:41 +0000
Message-ID: <ace8c8db-ff33-465f-9415-dfcb1c522f4f@prevas.dk>
Date: Wed, 10 Jan 2024 23:52:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Content-Language: en-US, da
To: Rafael Aquini <aquini@redhat.com>
Cc: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org,
 tj@kernel.org, jiangshanlai@gmail.com, hirokazu.yamauchi.hk@hitachi.com,
 ddouwsma@redhat.com, loberman@redhat.com, raquini@redhat.com
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
 <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
 <ZZ8RtfKCmOQqj5KC@optiplex-fbsd>
 <f5ded466-cbe1-4a46-b042-1c65839c9e02@prevas.dk>
 <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <ZZ8a1RvwpDZvwfg9@optiplex-fbsd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d24539-0bdb-4d3c-1bf8-08dc122eda09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tY4tPCIc/sCTFyi+4x8JaU0DrNVizuwj44ZcYy1yB3SESSwaDJTtiaavqN8f9PeJP91//gdK7Vzw7VM7yvWGnF1TEXke7lJCYwwExqEHVY6+9xDTSIyC8MD+g7yGPo3oLYKY07vUJ/E5IN0nBdRORVJipeFjCcyGggjLxfhsNGtPr+WX2dr1cGYYXjJwuAx67t7CtsNPmogbFUH3i/5oHVNkPFkbMJaXjl5vt+BdO46Bo1/toYjo5Dl2k6FRKmFcKWFrjbveT7SZ8ZdGubt+Nd7C+ify4NGYkLdq99kSEC18w1RUr23tfyAc0g6teSYQl1Rx+TSjAxybGOKUxbia7kQtIdevRuYwMQSAKcDI14SazKvgRVaFKIcukU1e+utGgS66DB2Nm+geqdAcZ/0fuMsDdgGU106xml0lGm1L6P3pvpWJTeoDSxB/KIJTIoIQNEYZ/En7OCROxaJYokLrgoY8t/zAxq2AWn8kj+ACiePwjp49eFiqCO+tFWhiXVWWgLd0acm8Y3cGZZv+YWdWKQHDn3GaPchDmIvcLulOQUH6amWGcONX/RVFdP25KpqO6pfNuxFZruwLvpOlQS2VA4EFroztTjFdE0PSgNU9L4GrQs6B7dgAcBtZielCagCS/3uFFF/pw6RaBk4+WarnxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(5660300002)(41300700001)(26005)(83380400001)(478600001)(6486002)(44832011)(2616005)(38100700002)(31686004)(6512007)(6666004)(6506007)(31696002)(8936002)(8676002)(8976002)(4326008)(36756003)(86362001)(6916009)(66556008)(66946007)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUNHRXkwYlkxRGdrbTFRc3h6TFhhOHpVQzg4emhiQm04dHhBMWpMYTFHUWoy?=
 =?utf-8?B?WnRUR1lmYmxCRDIvanBpcUpNVHZiN0tEVFNacnNDZDVZdXVkcGM4Z0ovZnpo?=
 =?utf-8?B?anpJcFp0OS9uRzFiZEp4Q3NPdjUrcTcrVTZ0bm5YOUpZQ1F2WXpnZ2N1OVJo?=
 =?utf-8?B?TlJ0L09CSXBwdzlhaVE0WDI0d0RpQTUwdjNIWDEvd2pEdHBnQmIrM294RVdW?=
 =?utf-8?B?cC90Z3JSa1ZqaHBrYmhDYmg2UTJJT1dZQU5vZ0RuRGdQRmxsZC9acXd0d1pw?=
 =?utf-8?B?UmFHcFlHREF5UHFremFIV05TRnBTSHVaaTVlTDVqbDRUZlpZdzJIdGpKNkhh?=
 =?utf-8?B?Q0VvTU5Jd3V4MkkwR3ZVM2QyVFptM3dUd0dkdVZKNkdweUZsdzhSQlM5eXgw?=
 =?utf-8?B?RjUzelE4SFZWalpnWFZLdEtEUVFVTjkzcjNHbXovMEZIRWZqRm1lRUo2VWY3?=
 =?utf-8?B?YXVmNDkzcGRYSTFQZkNUQVNMRzJyMHNXVGdnVWVHZFlDQUI3blh3ZHBMUFlZ?=
 =?utf-8?B?bkdiYjdtZXVCYk0yNnFucmZ1YVIxZndBTXYxRURlOGlBbFdOZEJkUytHWTBT?=
 =?utf-8?B?eEw0KzdDTEExUFVSc1UySzlaU1RveGZ4cEdhM1BjRUJLQmJZdEVRMWluNzRB?=
 =?utf-8?B?ak9hN1NyQlZxTGlxRDEwU0ZIZ3daVS9GNm5GK0NnR3BFdUFIMXQ4Rkl5Wm5z?=
 =?utf-8?B?TFJONGVoRFBSRUVqUnpWa2VKVnUvcnlXMTFVaUNVWFdlVWpTRXFtMWlEZksr?=
 =?utf-8?B?c0NVdEFidVVTcUtVbHlTd0FwNXBRb3V0V2ZLZ0ZRdWpjdTQ2WDBPTnBPRi9a?=
 =?utf-8?B?VXNPcHN2OXVLQzQxTFFncTlKczZZMkJ0cHkzblErRXhuUW5WK0ozcnM2SkY4?=
 =?utf-8?B?VlVCQmdMSTQ2cFpQTm44QmV4ZG1jNG1hRkdEMTR2ZkFQYWZlaEFmZXZZNFZu?=
 =?utf-8?B?YitGUVpXTGd4b09aRmVTNGdxYTJKNWJ4bmhsUkVaaW91L21nMDFtc29qV0JR?=
 =?utf-8?B?R2s1U0t0Uy9QOW1qYStEVEt3R2ZWdGptalV2MkNtdm9VaDRRa3N4b0hwbWZN?=
 =?utf-8?B?RTgzMGIvOVBIZ2c3cjNMVlpDcTViNWdPZEd0b3pGQjNVcng5NDFDVlpyWG5H?=
 =?utf-8?B?M0tJaXl4cUl5LytCRStGaWFPcVRqN2JGOEl1UUVzZmFaMU1Eci8xblJMQkRY?=
 =?utf-8?B?Vkh6WXVQaHBtOTJTV3oxSnVsTXRKRUZmd1JUbEFVZHVhd2xpbmZ3d2M1VjVZ?=
 =?utf-8?B?U1hnVTdSZUZoUWo1QXRWZ0JGVlRnK3F3Ym5yeUVrR0g4NHpMN3pudVdvTGpp?=
 =?utf-8?B?RjdMdjlqMWhWQUpYUy9VamNtaUExSTBzTmpSMkFGSm5uZmJaOTNTUFlSLytx?=
 =?utf-8?B?U2xueE9NZjFETG1zS05DNFMwNUhINzJMWVB3MDIrWGVUTGQ4YXZtUUduSjJL?=
 =?utf-8?B?aXQ0YmJPbGo2QjdUeGdqMjQ5YmJDRnBnVml4S3V1OXlkbGptaXIreHFYS0hO?=
 =?utf-8?B?S0hFTDl4Tm9nYm1hemVGeVRNVlN5cGViU0hxR0lQaVJSU3hVbFNSeXRZR1o0?=
 =?utf-8?B?QWdXS0dMSUh4aWhuSGNDRk5jL0NFeFdFNHlhbWpyNE1xOW5rVyt0N0hJNDla?=
 =?utf-8?B?Vk9XUTg0OXNwWXEreVZXYUF4bHlsVnpNVVhhUHBGWFNnQmxSRm56ZmV1OU5M?=
 =?utf-8?B?eVIzK1hIZ1RDbDlndjFxb014SnZVVUE5UG05ZWxMN1VHdk5GQ2ZaRkpaK1ZP?=
 =?utf-8?B?ZklMc2xTeFVJSUY1TUFFWFloN083OGNYdVpVWTJLcGhtZ0RtM3V0bVRHUGNv?=
 =?utf-8?B?azJUT0l0NEVoZEh2cDRBR3plOGhCSHFkR0hsMzllRmw3L3pFYUlZNzBzSGx1?=
 =?utf-8?B?NWMxaUE2Z0tLTTMzQjVrSWZLVnBCOEN6ZVNxeEV1d0R5Vkx5US9uZW0rakVT?=
 =?utf-8?B?QzcwQ09XazZDTlJYSVlaM3MwRlByY1QwbFkrM1hLNXR5OWlOMW0rcS9SeEdJ?=
 =?utf-8?B?UDZoc1dUTGxHSGc5KzR0QStjMENWSlIvcnFyWGJUUld5RHBZeFJsbDk2aFN6?=
 =?utf-8?B?Q05hVTJJMEZ5NGtSVm5qYm5DU2RJS0NqMXZqenJGa0k4Z2JPa0F2R0FjRHlC?=
 =?utf-8?B?NHBBVkxJSGRBd2F5V2JVTXFUUXlrUUZ5c050bmlzZmpib082MDRpYVNSdnVl?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d24539-0bdb-4d3c-1bf8-08dc122eda09
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 22:52:41.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkO7/v4uJNPnIR5xp9fwOw411004JmDEk4CvTEZG64X4o+yX5X+QM45j7a49A5eiJ5jg4t3z/UV5THsFX4CjTNSKwT+ttRuZ9VDakxaodGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5853

On 10/01/2024 23.31, Rafael Aquini wrote:
> On Wed, Jan 10, 2024 at 11:06:22PM +0100, Rasmus Villemoes wrote:
>> On 10/01/2024 22.52, Rafael Aquini wrote:

>>> The extra vsnprintf call is required because the return of the existing 
>>> vsnprintf() is going to be already capped by sizeof(wq->name).
>>
>> No, it is not. vsnprintf() returns the length of the would-be-created
>> string if the buffer was big enough. That is independent of whether one
>> does a dummy NULL,0 call or just calls it with a real, but possibly too
>> small, buffer.
>>
>> This is true for userspace (as required by posix) as well as the kernel
>> implementation of vsnprintf(). What makes you think otherwise?
>>
> 
> this snippet from PRINTF(3) man page
> 
> RETURN VALUE
>        Upon successful return, these functions return the number of characters 
>        printed (excluding the null byte used to end output to strings).
> 

Assuming we have the same man pages installed, try reading the very next
paragraph:

 The functions snprintf() and vsnprintf() do not write  more  than  size
 bytes  (including the terminating null byte ('\0')).  If the output was
 truncated due to this limit, then the return value  is  the  number  of
 characters  (excluding the terminating null byte) which would have been
 written to the final string if enough space had been available.   Thus,
 a  return  value  of  size or more means that the output was truncated.

How else would you even expect the vsnprintf(NULL, 0, ...) thing to work?

