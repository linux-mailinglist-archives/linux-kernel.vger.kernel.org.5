Return-Path: <linux-kernel+bounces-7877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36581AE97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAC1C22CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A611737;
	Thu, 21 Dec 2023 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jl61Hau0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CgmJw5wn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B3D29B;
	Thu, 21 Dec 2023 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL3wvuG004167;
	Thu, 21 Dec 2023 05:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zRo+MCPAxROx46eV5IabBCzVz/6aIQhuUURO4Cltp8M=;
 b=Jl61Hau0nCBdS8ewBk8ee9jO4YUeb9x3W9xm3Jf+Za61/zCRozpgvtiH7zOgLDWT1McO
 2j87HBqFeo3t0VV//ji5C5hV9bqnC2QmWGBR/JVuTF3G6KvQ/nmGNn8lm45Ew+rb2AWj
 u0jQXbsXOAOL39dVWoU3ExRqh4QxaesOgwK3XcsTwDgLHEETHmUuKe4shWc3A9vOasDl
 kmMOAzlkh/WQIGlkFEiVzG/9Kw3heWsndmX5sx+d6E9Z4S+iLJNvXz5nCQjzRH0LbXCL
 +aL3QvQ67jSaisvzFlFYKR0LXrEsnR+nodySnfG3G4oq+4v7U8NyMgIFLd11Ujjsf6Nn qw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13guj3me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 05:59:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL5GxvZ001665;
	Thu, 21 Dec 2023 05:59:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12ba1cvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 05:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYFifKYFV9XgAURRICEiqp3jPx48h911QJAOLhferZ5bTEqmLaITIF/7xWF7GQhwuskI6zFBm9oBpijenr29zMPsUFy0BAY5Yj8Gp5puPnXTtKN8i0+MJw779lyUmirUcMigGyk2nqukCLD3YEvkWd8MtjnaSIE1KpYw/HEkO2NpenH7pyn2Ptms6hhulUbGsXUxPU6rpbb+KikSstZyGYlcyBKt5Vl7pXxoqj6vswjQHGeXfXSzlY0pyjFkEfFANb/0QpSMIOjpZ4EkBs/P0AgDzXFO2nywYAD3U4pQwbGcK3iVh04f2WJwcVgeSg8VsiJ3m2OFrFIiQ/ZuzaSX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRo+MCPAxROx46eV5IabBCzVz/6aIQhuUURO4Cltp8M=;
 b=EVvDlyQqFdmcu+su26qnGQ7XmdeiCIO3W7H1+CytgJXObRNhXFdh+H45LzSLsBsS+R5gz+DK4N6FINBz94uMzfEU6+3MmfBhNyspq2yX4rigKBf3IZjHnaxfl+0+kNbZXEAELGBYO9drNcCuNHoSW6e4EktZxKQwbby3lLClh2Jtsw5gbWN12qeHQDPnRrm8qhbYb+PSaW+fBn6+9QrRg6MHLqJU/CuG1uECaKjGusCI69Id/+BB0urfu8qF1Zqw4B/WEydkCDsaFSg7QaF3bJ+aDfe0xCPPT7rpZ9cc2H3rGa3Kq1pVTmIzhkOArHM3w8KG2Q/9fl1RCNoGLsg0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRo+MCPAxROx46eV5IabBCzVz/6aIQhuUURO4Cltp8M=;
 b=CgmJw5wnzCO36SIh79iOwW6IDCDiOAVDjYEwRVbood5HU4NIcWklqLgFlrpzLN3LcK65tVj+P+T7GkA5fFKwOMQlqKBQw3YDWGpNDBH8UutEa8iJewNc+S2BK5Kc/mWSTmVYLgauIi7zWxqUcwKeQzzPdI7hh3y51QjXaXOH5iM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB7012.namprd10.prod.outlook.com (2603:10b6:510:272::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 05:59:26 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 05:59:26 +0000
Message-ID: <b55dc12b-0cd3-4f56-803e-4b26f1117c91@oracle.com>
Date: Thu, 21 Dec 2023 06:59:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] docs: Include simplified link titles in main page's
 index
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao <bilbao@vt.edu>,
        Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl
 <aliceryhl@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231211005442.95457-1-bilbao@vt.edu>
 <87o7erqxhm.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <87o7erqxhm.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH7PR10MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: b20d8403-72c2-439a-d945-08dc01e9fcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0UadsZPU+XhDKGzgZtvxMntRmDfYOH3Gocg2hk517S+oVWHKoNdCxrSQlNFsNWjIgcFuoYTFku45XouA2e+wdaBHg+Hx08LC6I2Fyhhe3CtpgmKGLEUM4vbjVnaMNcluEYKaB8sX+A9wkywGoELlYDP/28jh32KZi/dwF3u8y6VeM+cj4iNL9/PdFKQHYN93fxiFkf3cXr9ipY1FfxXnnLEXzy1GsXrksjmNO1VvG9Sg+h1qNp2v/i+kJmQCIb9pc7WB829LuOnq1kIr5U6p1w0Kfj5Lr4rdpyEDIhtE89PeLCiGdqV3iiNS6GSOIgD+kW+hyz2gD55JWnKyVEucCxwprgyA+vxl3JGKAHUY4ah46/mAgXQa+OS+fdWxt5C59t0RKLkn1/mrT3I4yskzaomeTWO/TNrOURKxbn+gVYkkzmE47BXqYrWki3R2TrD0jqqgxP3gB+KIM2/ew9vhumdEscJl6uHPxrSQTnTDUB1e8M4iYu8bwC08HrNr5ZwKUqzCjRdkSGoenLhaUFopCPkrXARBiYGR9cO0PhgLbyVrvu2twqrrGG7Xd8UnID8nfq61imTFB3KQ3hHF1MHw3t2w0I+qRd8w2+GpknlZugqvCPJx9FFYXUs6VNaIbtoSuiJM39p36KiNIrKrYjmTJg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(66556008)(66476007)(110136005)(7416002)(54906003)(5660300002)(6506007)(44832011)(8676002)(8936002)(4326008)(2906002)(66946007)(53546011)(6666004)(6512007)(26005)(6486002)(966005)(41300700001)(31696002)(86362001)(36756003)(2616005)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b1dyT3puMzI3UDgzN2FJYjc3QjV4aitMeGVpK0xybHVFN3g3Rm53MjFvRkNz?=
 =?utf-8?B?RTlyclR3d1pLNWlNRkMzSllPckxaZjU2TC8xZm5BTS9lQWFPQU4rcGx5NUl2?=
 =?utf-8?B?eFRjeTFQNGdhdHpRanhrQlpRaHVzYWJjUCtSMEFJMXFPNFJCQm1WcHFCMGcv?=
 =?utf-8?B?My83aU5VSXdWVWJ6bzR1QjMxOFZCQm1HYkpwdW96eTZ4VlhJbnBaSnk2anMy?=
 =?utf-8?B?dkpzTE1mMmQ2OUdIeXI1TlpYOUJ1ZkdPRnVvMG5aek53WjVKdVVuQ1hOSDY5?=
 =?utf-8?B?VEZBVWp3NjR3ZEdFdktIYThwR3p6endFMmMzL0tkd1lNSDd4LzNjcUZHR21K?=
 =?utf-8?B?YkZGaEpHRnFqRDg4UUVQN285MCt5eW8yOUFzdjZWK1REc3p5RXRDbkpwSHZY?=
 =?utf-8?B?b3VrdEVqblpkYkxJL2d5eVlPWjZvTHRBL3UvVWhZWi9LT043T1BZaGNsblFk?=
 =?utf-8?B?Mk11eGdZTmlLd0xzNWUvN25EWUZTTEtwaHhxVjlKdmc0cTJkWDdnc2JPTENv?=
 =?utf-8?B?TXRiWXVuN3JYNm13QllNQ3lQdjFnOVpBZUJHMEVRZWVBcUhGU1FRVjZQT1JE?=
 =?utf-8?B?aDY3Tys3UzF5eW5RYThacUJiRDc3N0ZjVjF4bGVUSWVKQjJkRWgzd2dXRHRK?=
 =?utf-8?B?Q2JVSjJDeEY1V1Y2OHZzVTdjZVZzSm90SzVtNVJCODYrMWNiOVVLQ1N1VzJi?=
 =?utf-8?B?RGVNT3JXRHgveGhkcjFRMUxwUnV4ZHJGbkpoWFZOK21kcFJHeDFZKzJTbWFR?=
 =?utf-8?B?NDFZRDBMOTZsYjZCUWFXOWVEWEhPVzJDbzBScFljcENnNC9JWXFHQ3ZyMkVa?=
 =?utf-8?B?WTNneVBjblA2R3lwUnJKTkdtUDBlVkI4ZllhWkF4SlprZUQyQ3p2T0wxcEZX?=
 =?utf-8?B?SWxOMWEwbHFpY2FmbU5qakR6UUM5WUU5UWZ4a3E4UklMYVZFaEhTaVJ4KzM4?=
 =?utf-8?B?NUVGL203R3hsZGxEU2J5WkxLdTlaei9kdVMyM1VudHRUZ3hsdzJYalZkMEZP?=
 =?utf-8?B?enpUMVF2WlZwbnd6VjBiNGp1dWlXMGlpVlZmcyttdWp1emVVa2RETkhQUXht?=
 =?utf-8?B?NWRza1ZZMnBhOVFVWWZ0QmJZUWk0bklzZ2RaV1o3VjZDalR5a3JEbDRSSEZZ?=
 =?utf-8?B?WHErTmZyemJpWEdtUkJibmEvaVBGK3U3WGNiUXY5eDkyVUFiWjRMRzR5ZHlB?=
 =?utf-8?B?NGFzRGR2WW9SajVaeVlHY01tNjI3cldDM2UrcmR3WnlqL29TSjQvUUdPY0lL?=
 =?utf-8?B?eGpLcUlFaFl0YTZmbk5oQzFhSzg4V2ZUNDBEVXhZZ1ExZy9Vdk5tREpiWStn?=
 =?utf-8?B?ZlJ3alVTSW8rYnEvMURSeUlqSkpGUzkrOXZBOWhjY0JlUXhPU1RvakVyMllR?=
 =?utf-8?B?bzF2ZC9JSDdqZHoyTnI0Wkp5MlV5UzJMa0h0Q3ZqU3Jkb2lkVFVTM1Q5SUJj?=
 =?utf-8?B?VnRJVXJkWkVQTzhJa1M3WEdwcmdsalQ2b0lRRGtTRzJHL2dmQXhVNjBrYkMx?=
 =?utf-8?B?VjR2eWdsSDhyMmYxd2lHUnBXTlBSMCtTN0t0NW5vZ3daRkc0TTZKZkN4OFFt?=
 =?utf-8?B?VXh2bDdSQ1h1YndtY0dWSTBENk1MeDhOWTArSVJGa2FkbGtNOE0yVEJQU2lK?=
 =?utf-8?B?L3VVREcyWTRDNk5yZjlMcGEyRDNDY3ZFeU9qbElCQXRBK0RWM01OM1JaeXNm?=
 =?utf-8?B?VTBSSVZOOGJrcVdVUjBHVVExdnFobFF3WEY5dzZUTTBLMkxBa1hEMkhTK2Ru?=
 =?utf-8?B?eEREVEx0blJBVVZCL2IxdVZzQTBsR3hkK0srRlhOYlBqTnltV3hhb3MrUXBn?=
 =?utf-8?B?TEZlZlJqWFdrY09XYnRLTjkwSEhmZTdKRWNEaFVQYkIrRjg3SlkvNTdtWE9E?=
 =?utf-8?B?d1ovYUJ2NGxDVG44cENOT2ZlUi8vaDlzcHFLNGVhYTU4ak0xaXIrcnl0RER3?=
 =?utf-8?B?cVR0N0FaWjRQQW52eVVQZis2YU5VVFNBNUVybU1ncmRXanRncHl5dXRjZHds?=
 =?utf-8?B?QWl0eWk2OWVuR2VhRjBqOHJsNm5uU2VseE9OZG9kVVprdnZ1aTRhVUg1dm1h?=
 =?utf-8?B?clRHYzBDb1pPSlAyU21CVU82N2xtY2JkbStta3cyUG5PelhVTmNYWkk4Qkpy?=
 =?utf-8?B?bTZ5VGlpYWlQdG84bjJwV1hYUFB5Sm1jTmJkUjFHTnhNTFdGaElINXdpTk1Z?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Zoh7REWfCF3VsPDUJ0ue4JDLZGtQifa3XJg2Qm0Vo4+mB/kiKcgmFMt8Fps2pHrwN8HcSx0n5g+FBs6E2lrja0R0UcH5oGTuBFsSl8P59flhy91MjEt1MwUCQv1bseHqIn3kbAvIaD1r8n85vVissLxnRbZa5hAtk1mRxbCsINOJnBKbe3Rh6FnT0GjhN2Bw4CgrdJD4fRyfzLAa+5yFCFHX4Ru9kzNdk7JEbMSVktsm+e82Wft/6lQnS76I1QSsCLHB32PRdeEXCWXIA57MWwhpZM4cFfd80c6kkozwZp5xIbpMigs5rMwz66ZMMWvzqnJ8UdFpHlE4RDeZ+00vKZLjtepyEtTZSikLZgaGif5UlwdVTqdPxtFOQZZS/qeq/evnlfX6Y0Q7PPTbLYEDSouti+mdPCgpYtFmIaVuoXmG+Psj8joCgk+xU9pisKztTEr5DjxyRyw1C0DkBBOHRq3coLsJGqMmQ1hEV3JjDpY5fq/DrCPuQsGdS0V0ZRCEPc264wc9AHZuQt81ebhcSJWkQ1yMQ+VmQvUc1GkdrZO5T0lvKoLbmSOQwc2aqfDUY0NqNBfuZz1pUtMkSKHMOFQ4cG5qh5sUWoOCDPL53oE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20d8403-72c2-439a-d945-08dc01e9fcee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 05:59:26.4823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um55xCyvCxj/+mim4kJo3ciVBtn1E+qMoByzyvaFKYmkE73vWerPyYXzoi5XpXFTis4e3XBsmMW50Kvy2nUlmX77zSYBpoJsn1flDhtPwdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_02,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210042
X-Proofpoint-ORIG-GUID: 9Di4all0MaoQ5sJfRqXPG9JjhOA-7vzn
X-Proofpoint-GUID: 9Di4all0MaoQ5sJfRqXPG9JjhOA-7vzn

On 15/12/2023 16:47, Jonathan Corbet wrote:
> Carlos Bilbao <bilbao@vt.edu> writes:
> 
>> The general consensus is that the documentation's website main entry point
>> and its sidebar leave room for improvement.
[...]
> Meanwhile, I'm pondering on this patch, would like to know what others
> think.  Carlos nicely put up some comparison images for us:
> 
>    https://github.com/Zildj1an/linux-kernel-docs-compare/blob/main/comparison.png

FWIW, I like it, but I would suggest these changes:

Driver implementation API -> Driver APIs
Testing -> Testing guide
Hacking -> Hacking guides
User-space tools -> Userspace tools
User-space API -> Userspace APIs
CPU Architectures -> CPU architectures

I know "user space" is technically two words, but the one-word form is
MUCH more prevalent in the kernel, for example if you check the mainline
log you'll see something like:

$ git log --grep 'user.*space' | grep -o 'user.*space' | sort | uniq -c 
| sort -g | tail -n 3
    3135 user-space
    7835 user space
   26917 userspace

I think it makes sense to pluralize API -> APIs in most places, so e.g.
"Core APIs", "Driver APIs", "Userspace APIs". Just to emphasize that
these are really collections of disparate APIs (e.g. workqueues is one
API, linked lists is another, etc.).


Vegard

