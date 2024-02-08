Return-Path: <linux-kernel+bounces-57823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D284DDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E491F23F34
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55026BB46;
	Thu,  8 Feb 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBtX0iMH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bgcR2/B9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2052628C;
	Thu,  8 Feb 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386943; cv=fail; b=P4FLaYl9rrlG9Ib7SqFUxs7C7+KCBMxbOvtIL1Si3l6iSOSlVJr9P+C5TFRow5vYNLwNg0ZppK/0YBA2/kw8aJnygBqP3gsOP9xniWJql4kEEepNfiIvPcgmdUHBwJI37F0t+ztc9RB6h+DsjULXCClP+pZF+thKy2Oj20TBnNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386943; c=relaxed/simple;
	bh=v7gFEOQwZsrO0bviEI/zP5cTc7aaeEXLHEGyw+g6CBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gc2zPKHysjrGpdhnq6BcwYvz7ENkGEZHaccjnTsbQJ3k+1bjKVA8I98Xsyf+hGnvMRr9Y4FYPYWXh+sQZweAlwn6pjiePNBKbEBJiijdJV5M1YaAq5cIYpEZhrVFP1DB84Im5X1L04K4gM1+LtqAO4Gz9MDMqbG3tIa4QtDqTW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBtX0iMH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bgcR2/B9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418901Z4015742;
	Thu, 8 Feb 2024 10:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Sx+On8/R+1yMUHmhvbHnLlT5+w/tQxUJ/atTyAeKjn0=;
 b=hBtX0iMHiDHdXjgrh9ax8s4GkFYXT+UhIhTXqTeWzv/abvnee8QOjHRs/zFT1OH/ImH9
 5ueHbRcCJT3DMTsb3RkdGm+OA7Sp/Tm4UXyJOUOf8v7VjwPx3LlsZ1LEInhyt4N1Sboh
 0q/PlsVc3ldsKQnXvwzaz5Q9Jds9cvTE3slP+ACvNPbUvHBM2H5o53gi9EsZGJNohMUV
 XcNATjB64TNH2/WUc8aFB5XNmNnsIUTVksiPfuadnLSo6WFTnwMpEVUwzMuBeolwzkDs
 9z+7BqqICinAL3OLVECGbvniRadMgiGYdARkCo9SIO3Em0OJwXg5eiC7i9gBqEiW78FP JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbkyy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:08:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4189W5xJ039531;
	Thu, 8 Feb 2024 10:08:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxa56wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8HlJLsLHuJ/SX4HP6E7GPoefGFBKadtsB3s59JXOsGr6axZUydI8eqscCig7WPuqdWLWedaYr86wPVj7SFMS9MP+MbEXGcFYHz7XuIhRJhBCStt7RmgIRFx7ltLpY80XLwiPhfOVvP2n1HQgJPBSRRfLac2FPv2n2HTM2FWi1j/pIeoqkzEYxBxbBAUAQB+5kxueHs5F+9flzq3ws6mvV++DOxFbCKdWAwyrt3giYFi/ildyORFLdhtl1nT8fhRzJIGfEHwpBC23+RecidluHdVSsn+bvV1ite/IS4TpcfIhzL0gcHFvR6crMEFbS2x0SlDSD5Hao/4WuJzKtQSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx+On8/R+1yMUHmhvbHnLlT5+w/tQxUJ/atTyAeKjn0=;
 b=TjgdHshzkklXtNR/Wl/wlcCZDFOWxD+e334/R8A2ygnuxwwysFkGUooz3CNjNDhL6xwRR7+jbH+VhqFFITWnEOrnITTHFMtwe5QyiGZE+vGoo4qqlqXMfWz/ELZCbwQLf8UPbkaQ72jcKHn02TusbY0LrkovpBWIQ3ABp/PFkrabX6byai9S1QXy4TTnZRlvRHYE/0KwxDNftgZEcNnsTNboxTgfxrzRD8zmSnsZgzjZDZSqSMPFyWTb6MZBTpAozk9KMffkOLDrEGWnbroqwrfmEQpj7rSfeyPk+sLhknvu1Tbwwc4GDOHXuHFjbHXvZWQ8aISg36/Gqz74bHl5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx+On8/R+1yMUHmhvbHnLlT5+w/tQxUJ/atTyAeKjn0=;
 b=bgcR2/B9GdyMaBM3R0GlfUHaa4+26X5S8pPH9mWey71yieMEU8UzvMRZUwxxU9pfxrr3xfpZgqAGSb7WlSW7i4yDIhn8E7WJXy7p0bnnBmgquUREFKICa5HY6b2wXW404qnJ//TB4mH0U2gfWblqwmdBdp0rtOjiufLvi2Y4Jo8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7545.namprd10.prod.outlook.com (2603:10b6:208:491::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 10:08:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 10:08:14 +0000
Message-ID: <3e2c2def-e7d6-458f-81b3-ab666b41ad21@oracle.com>
Date: Thu, 8 Feb 2024 10:08:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, nathan@kernel.org, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
 <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com>
 <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAK7LNASfTW+OMk1cJJWb4E6P+=k0FEsm_=6FDfDF_mTrxJCSMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 1284bc53-1623-4de5-f79c-08dc288ddd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BE4jd8u7U6V7uVGHproBBmkucskjKZbW95LaFtILjbLOTh//UyrPuR+nou1RDChDWgzkDDU3hXL2kjGvVNLus/I1VcGpOg0rWT34CwhjznRPj2cfgQDCAeeF+Vw4NOcnlyr6p9PJUbwdbGazHRT51uIw4VIny3QoAvcQSTxyUJPQqREh19sUm5QOG2AzqpRcCgIXayLASXtWdTFCWhquUav6Sq4suvqILryoXLQ4ZG/Q4bMbfyNwC4VABlfFSWf++xJpsgg22zhugUUicvUvnoDNHIQ9M+ALE4O2EGO9Dy3mVEHA18RCkBOp16At5C+9Wo38PZ1H7NcLNzTdfmvkLIVz6kFNiOHCLGmDN4IO6jyC9It+XJHtdSfpYXu+VY0DbMoYGjXZccAqLqFspTBrpfRiX1UmaUsZK/+VTYjvojaXcnRrXfOW1XpXgF97oOwZHM0TNJs4dpdtqZl3ojRGbBBC9nZTUxwbFd/n9tWVvrPthyW+aBHrWETGAnml4EHJ3riGcQzX0vdEECOqap++b2TG8JGJ5CLgwA6ovIdLoqAPvukNS78va6JSjPPcF50U
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(6916009)(41300700001)(8936002)(31696002)(4326008)(8676002)(2616005)(86362001)(7416002)(6666004)(5660300002)(478600001)(6506007)(36916002)(6486002)(53546011)(36756003)(6512007)(66556008)(26005)(66946007)(66476007)(83380400001)(2906002)(31686004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVUzWXVOM1lBb1Zub2xKOG50ZnM0UEdFZnV2aW9US01pTlUzNVlMbHZBZCsv?=
 =?utf-8?B?SG5oeEZKV3JhRDBPWkErOUZxYm1ZTGRKUkd5dWdsbWhzeWZKckxlRlJ5MVlQ?=
 =?utf-8?B?OFRHZ3VWY3FNajBKUUNjMUhoeGhCczRsZlBrQ29lMnV5ZzBocmF6T2R6SGEv?=
 =?utf-8?B?V2NKZEZhbndEMXRPdHFMazdRaVMxNkFxNlFubnlDU0lpbzQybHcrVjVFVlhO?=
 =?utf-8?B?RXRid1ZIM3ljQm9TWmRFNFJmMXNXSC9IeFc1ZlZIaDVwaVpqdkFBMXhiSUxJ?=
 =?utf-8?B?RXJ5REpFQk5mNHVzNXordk52VGs4emFMUkdsdjhxM29GRUx0aC9hdmt4SjMw?=
 =?utf-8?B?UkxkMm5mZ1Q4OE96akc1clpqMVIzMWNhVTJZU2dsWWdjREtQK3BweXo5c1Jm?=
 =?utf-8?B?a3JRR1B3allQMkFDWjR3Y0NQUDdiNDFKUWFvbjJMVnRlMkJiT0NrZENFWWND?=
 =?utf-8?B?RXBObHI2Qi9JYU5VQytCVEtFRUJNa3BYd2VLbTNCbTRKLzgrbTlzVkZNM2hN?=
 =?utf-8?B?dGEwMXgrNEtONTlJVGxieGlBVkxia0d3YnYzNU5ROFk1Qk1xei8zaWU1cXpv?=
 =?utf-8?B?TXdXSXBueno0ZWFxMFZZRjBCdjF6QTRvcXlsUEpRL3RFOWdDajhwQ1VoLzQ0?=
 =?utf-8?B?VTdJSk1aTXpOcFl4VVRVc3pZdmFKV1ZMb1NpejNQdlhnTEF5TXFGbjdhYTU3?=
 =?utf-8?B?dnZGNUhLUEhEY1lONFUweVo3SURhNU5qTVdEQTN6YXJpUmd0eXUvWTdnTnEr?=
 =?utf-8?B?RDRqZXFtWjB1ZDRlWjRTS1UyQUN6WU1sUkdXOUhNVHdKOHUrZkQ5VGpmQWky?=
 =?utf-8?B?VHZiSVlGRG1pZTFMcTBnRUtXS2xqSEtJck9KazQ3RWpDdGxZQzRtdktxbU0z?=
 =?utf-8?B?bTl4WWlWZjB0Z3JzRTZRZ2V5SmFtZGlva081aUNCbzQ1Q3NZWmt0V1Z0SGZR?=
 =?utf-8?B?bFJMUjVFWEpQR01pQlV1eXZuQjZGbUNsZUtDS2lWaWN0NWIyY3Awd013YlpT?=
 =?utf-8?B?KzlpRWlkUjM2MFgvYlVOOC81NzA1MEVScUFEeEx6YkdwaEpXREkwdjF1c0pz?=
 =?utf-8?B?VVFFNmFyVnd0WktwS3JubWx0cHZPVHB3YzE5aHNMR1FlQ3BGUDZPdjJaL3FH?=
 =?utf-8?B?WG82MEM4STh3U1dkVXZ3MjZYYnFkbTdueWhoNzk0b0JVUTlrY2YzcVRhUnNO?=
 =?utf-8?B?OFByMkViMTJyOU1SeG5QYUcvbjBTUnhQb0dxUmNDSytjalJKcG8rTUNrbU9N?=
 =?utf-8?B?VzRPNUE3RmYrTG5kUVhzWk1rSnBJUGJmWlpYMk1MT281RWVNTzlkeldneE9R?=
 =?utf-8?B?ZjB6VW80TmFhTkdndVZGeUN2YUxrclpJcXR3OWUvVkMxMko2bkpPL0hyWElT?=
 =?utf-8?B?WDFlZ1FVT3lFaUY5anRuL2Z3NWVTZURjUW9VRHh1RHJqUndObW9WZGt2elFU?=
 =?utf-8?B?c01aalFQUmdVdUZxd25lQW1CY3pJWjQvRGk1WE05eHZtaXdKOEpDOTFpVEY1?=
 =?utf-8?B?SWhvQWVzSFNrOXlSbGRjNEVOUFZpdWVzYlN2U3YwWHc0d0ljU3ZVR1VZT3FO?=
 =?utf-8?B?ZWNOVFJMQlE3SFdZM1ZTdEdtMVBuUzJUOFU0MWt1MUN6RFF1cWd3QS9JK0x3?=
 =?utf-8?B?QVFRckgzS2F2SWwwOVF0VktNbzQ4emcralNtS2dXVm9SeVFwVVB3OTY4aDE1?=
 =?utf-8?B?bDh4RkhPY2pCdHoxWHpoL3dzZDVsTk9XSEVWUWpGQWxPNEU5aDV2SDEwTGxN?=
 =?utf-8?B?cUI4QnIzN0hzYnlRWVhFZ1QwdC9sRWE4ZGxVTlA0RURtbFpieWMyZTVDcndV?=
 =?utf-8?B?dzRSMDF1aWQydzFIVGZVSndqeFA2bzVwcXcwcU9RSHl4NGt4OXdRbVYwa3l4?=
 =?utf-8?B?R1gxdE42a3RxSjFxcnEvOVVGdnpkbU9GUE15Vzg1OGVZbWdZWXlvNFBMMUhh?=
 =?utf-8?B?d25sV090OERRVFl3OHYyV1l5UmtxaVN4TkV1SkpybUxqODZ1MVI1VVh1VzFr?=
 =?utf-8?B?aHdtRDI1L2NsUnJodEo0VGJHM0Z1TjhwTWpqWU1lZWxWTUZXQWtJYzFWREhX?=
 =?utf-8?B?Y00vQitXSWExUkhvVFdTT3Q0ajhIanY0WTBLSXF2bCtJNmVSelZWTWdKSmdH?=
 =?utf-8?B?dS84VldUblRyRnkvTDN2dmNoNmgwSTlHMjdoZXIweXRqUUgvUnIxQWNhOXFQ?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xIZ7fd2mCLRZTpye5npv/N2NuH/ow2m+rdDAtVujVH5kGraWLnQaH3+p0T6B08xYDyyt2Pda0plvNE72xAtO/nfN1UYE7//u+CpxB1wNCmsuuB9Co5l62Si+MB2dQgIBNzmiBVW6ztAfr8R1ll+ru245g1lOjv1qIQZX8nI49nji1Lc3aoGZ/r7qx0o8ouzLQ1pHG1/uv1cYPmyn6dUI4qXVJptLJbnDOk7HO430wpmUBfvu2QHCtHPOjSlSdAk7sh21hDyTbHFFyBsd8vrbO/6Q7puRNbnEHOpWB03rgB3p1Y/JAqbf6tfpJ8LIG+xQYCMh6SNA9Tjl9xhbeSB7qBftlGYik0xIBMC/zdcNFQ1GQzFBccf2tY2kLoUzh2X8JuMy3lj6fHuGGx33bIeoqJesMVK2R2lMhnwVC2syTTjTKPxWa2ctDb86uo2ORG01V+8Gw0u2GejPDtzlXnNEpovADom2FZ+Aep7I9UV9DWkrJxvsokCUJplrDqVGGwdKwX2alXME/ihHP05sVp89AalrTa2vk8SszdzLPPp6bokIIegbtI/a8oDy3Toyj+oW1Fqt1A/C3saTNzm5+B7rzlwLmPH/Ky2OZHXtKAd87Zs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1284bc53-1623-4de5-f79c-08dc288ddd25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:08:14.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ6D5uKaYPJhuRtwIUCa5sxHXuvZOQKSJpewKv0PHHwQczs4kC1O9OQEMaxIEDHxABBP7nO9E6Kp+zzu7Mepsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080053
X-Proofpoint-GUID: FksGEgrOWUpdDHoplmvNS-umbnPlQ2fB
X-Proofpoint-ORIG-GUID: FksGEgrOWUpdDHoplmvNS-umbnPlQ2fB

On 05/02/2024 23:10, Masahiro Yamada wrote:
>>> I think what you can contribute are:
>>>
>>>    - Explore the UTS_RELEASE users, and check if you can get rid of it.
>> Unfortunately I expect resistance for this. I also expect places like FW
>> loader it is necessary. And when this is used in sysfs, people will say
>> that it is part of the ABI now.
>>
>> How about I send the patch to update to use init_uts_ns and mention also
>> that it would be better to not use at all, if possible? I can cc you.
> 
> OK.
> 
> 
> As I mentioned in the previous reply, the replacement is safe
> for builtin code.
> 
> When you touch modular code, please pay a little more care,
> because UTS_RELEASE and init_utsname()->release
> may differ when CONFIG_MODVERSIONS=y.
> 

Are you saying that we may have a different release version kernel and 
module built with CONFIG_MODVERSIONS=y, and the module was using 
UTS_RELEASE for something? That something may be like setting some info 
in a sysfs file, like in this example:

static ssize_t target_core_item_version_show(struct config_item *item,
		char *page)
{
	return sprintf(page, "Target Engine Core ConfigFS Infrastructure %s"
		" on %s/%s on "UTS_RELEASE"\n", TARGET_CORE_VERSION,
		utsname()->sysname, utsname()->machine);
}

And the intention is to use the module codebase release version and not 
the kernel codebase release version. Hence utsname() is used for 
sysname and .machine, but not .release .

Thanks,
John

