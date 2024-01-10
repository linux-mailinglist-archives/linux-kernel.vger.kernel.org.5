Return-Path: <linux-kernel+bounces-22784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A1D82A2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389DB1F224D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03A75025E;
	Wed, 10 Jan 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Su7T/iwf"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AF50258
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0RAptYqY4eS6nQsQ+5GLEOaxICFOWFh88kSt8jjhvpxO4TIkIpkUhJ3sMubzq6lBdHM8jAMi7eoGty8umU5xQWXaxi6tVmzxER+W7s80NpMscbK0Bhc2EHTqeIjTd6VQll6DSrTgRz2iYtGb72WCXGn7cUv0KbbO+3mIt8qpnChjvfpSsMJwFF9QlILgX927Vy3tXy/sj7h++7uvEZjumwqnW6FuKSLtGGEdH8RSVxSsy4EYMkS4c8ZQCw2JAvTB8rtIL6nr9KHwuUxhuWxZ4fAy/aHii6Y65hPdVdWeGMGoA8EmrzlG+JTSvgoqKMuDsGytiKmGAe4bDrUAstoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFxFSaSnjiPayojv/lF6m8jM95XcjU4j2tHvfhxlSxw=;
 b=mN++/CKNxwJ1N9ZhxRsoBKhgqzEFU81Lf1qeKUDnGxaPz9M8CkwBnKq4+tyhGoerrsrC88YWyHGxRVS9EdO9lmh5F+W0GXl0Hj0ChFI+gARn047ZWpdR9is68W+WfL+JmVtBoElnGRTCweaPEdX2/1KaSJqp2TdSNE/pttJS/3kMkCvNJ2Qh9GFaL19Begsep4N+5n6uLVhuLJAeRieKrqV+4xKnQzEUuRsggpqnPk6mNFeMl5WbPUDFxG2iUComT/Ua3bCRJ0m1/UF1u62dCiO2mQF89iWuqE6F98dAz5IqceEFWqJaUPc128L2uFl2KmJA2nWtdzsGxuxlt5wj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFxFSaSnjiPayojv/lF6m8jM95XcjU4j2tHvfhxlSxw=;
 b=Su7T/iwfTLHSDoyH0lot/mdnIIRkd/VaquUSzdKcF+WpvtpLhALQnjuq5E0fIRya7BtSlN1POF0kgUKIRShu5D4JinDclsyDbt/0Mxb52qw3EvErV32DdeCyLwuCk5rjXcFtm4JPjcXb2OIJSbMlB+W3LFiNNfGZke9yjMDa9sY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 20:47:59 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 20:47:59 +0000
Message-ID: <2f0efed5-f9f3-4a5c-9fd4-a4837cada298@prevas.dk>
Date: Wed, 10 Jan 2024 21:47:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue.c: Increase workqueue name length
Content-Language: en-US, da
To: Audra Mitchell <audra@redhat.com>, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, jiangshanlai@gmail.com, hirokazu.yamauchi.hk@hitachi.com,
 ddouwsma@redhat.com, loberman@redhat.com, raquini@redhat.com
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240110202959.249296-1-audra@redhat.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240110202959.249296-1-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d3654b-7dae-4d43-283a-08dc121d6e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cgEtOREyzWrd+++LVvZLoX0tIbZcrMyx5t7tY8nfJBnSPBGTDgnb1055bh7UT7o+qbPzMmZz7Pm0c+OKFKoy0PpcexOPWC9Y9c/fuWtCCy+XSEWBO1tb1wd8wypcnqMkvEsuL6ZStySbA6eCB7Spo3QfZ7zciKHDJlhlLlehP/BfOXq3KA6tn8FbHwWfuEzJoOOSw9u5PS8cbqSNF33UWDKc9uw5IV+16RvFEgBCfkzl3L64ULMYKrBl9F92r0c6e7nwpqK4twsN1ZXf8GGaP34wOUybQwy4Kb8cwHxv3fTq671AhjPr+Mz4pz6t8XQ2ht5Mkitn0KsCpILbecQ8gdJpU4q7JouvOxAagAm780WXLxXmrpoCB5wE+mOFz4i96orMDk1Xpv/3QV7izVmYluT7m5ynSNKc0e+Xrof2OW0jhDLOfHjVSesuoOWFVrXfBhhHNWUPl2SrEnUv9yjs8zLe+ytj6D+2xnAL7TGMyYlJrAuLMsSpGBb1JFXzIlTOiwPyLX4pIUYCYNvBs1kaXHpajAu+nPOfzCiUudhC8BcXplaR4pma/jacVV8jS6YExFbOlCyyjYZ8bx+YnDux7FUZGVbFrYWsO63fEakMpPCyIZ5yRal38mJn50QwIufJ9m7rOj/b3w7IzjmjcSuxKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39850400004)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66946007)(36756003)(6512007)(6486002)(478600001)(6666004)(31696002)(86362001)(6506007)(5660300002)(2906002)(8936002)(8676002)(8976002)(66556008)(66476007)(316002)(44832011)(4326008)(41300700001)(83380400001)(38100700002)(31686004)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVZGN0JaV2Y5cXBVOVE0dG9LWEhPcE1rK3B1WTNjQUpXeWtUd0lPbHpmS2tE?=
 =?utf-8?B?MlpncTJTSVdqY3BzYUVvaVMvbkQ4QnF0RThsTkMzaXJDNWRZZTFtZ3RvM1Ex?=
 =?utf-8?B?TEplUS9ObVJjS0RES3VTM0k5Ujl1Y1lTVks1NFNoWGRkRWhUVFVjZFBYZUR2?=
 =?utf-8?B?UEVJVWFYNzBha0J4SGtIeENnKyt6b0lyeExjZEEzKzBaWGFsMkN1UHdOQTZJ?=
 =?utf-8?B?Vzg0YzZQa1YzcEhhU1M3QXVBVExubGZBK2JvNjdUQTc1R09xcEZHcGFNcEVN?=
 =?utf-8?B?Sk1OZitvVmpJNGhOV2hXZ1ZwL01ydUV6SEQvYmlTY0RpYzVBZkMrT2dlTXVm?=
 =?utf-8?B?NVN2Tm9DZEdHek0wTkRhSTIweUdRYkpnNXk2aHAvUHNwSzJJZjRNWDNoOTkv?=
 =?utf-8?B?THo3c2RLRnFLdnhBZkJSemtEYVZnbHNJOFk4MzdoL3J0UFAvRm4rZE5Kck9J?=
 =?utf-8?B?NlpONnUwM2hCazhaNE41MmVvVEtEWjBSbkRtbUZkRWxoU3kxTlI2RGZFenhr?=
 =?utf-8?B?QzQzU2M0eWxUb1lNc1JNQjFVYXJPN2VGQ0dvWVQvc0sxcWc2eFQzR3g3bmRL?=
 =?utf-8?B?SDJvRnRnN3hleTEzajV6RzIyUSs2M3lvaHRUWDdJWThrZTVZczdUV3lFR1lC?=
 =?utf-8?B?amUwTmFKcFo5ZWJwc1Q3UVMzTWQ4ZVR1aGxJSlVxRmRjc1Fab21KUCt1REdn?=
 =?utf-8?B?bkUydjRpQ1h1c01sT2luNDNSajlVUDJFeGJhaVBDMUlXMm4xZnhpQTVjeDA3?=
 =?utf-8?B?dHZVc2l4VFNhVG5EQ2VOSHp4bVVTeUR0TVpMODA2MC9xYVFFR0ovbFdTRHZV?=
 =?utf-8?B?SmovbDl2aWdkU3M2U0xmWndsS1dsODh1aFY2M05pSTZaRWhSY3R1dTdzekZL?=
 =?utf-8?B?L3FDRXlPWFpCTnNUQ2hvQjR4K082RUtYS2lqOXdvVEw0WStxN1JKMk93V3JR?=
 =?utf-8?B?NGw2UG9ydGlSNEVXT3ZnbSsxbGlYQUlaTFBPTHh6NFdDeHZMSjJmam9aenBC?=
 =?utf-8?B?L29DdTJaRFJjclZ5am03eUpNQUgyM2o3Z1ltZkNTUmtQV0k0QjFBNk52YWJL?=
 =?utf-8?B?cCtRNm5WTFFzbHhXZXBQeE94dmFnQ2Jta0F3VTF2bFpWU3pkMjVyN1pHWjl5?=
 =?utf-8?B?K3lSNzFGVkt4VFdXYkdXRGh1eW5KdHloRG9LWVFQOU1abUpZdnVVTXV4MEZy?=
 =?utf-8?B?OXU3K3Q2NEJhdHl0bkxNVTJDTW50L2N1U1dmTjdzTWt0YWRaTmh0VTFEamZv?=
 =?utf-8?B?Wm5YWmxuTE5XRUZKMnlDa0RNbFZiVlAzY0tOWWlEM21ZRFZweW5PbXdVTnEw?=
 =?utf-8?B?RlRWVkt0ME9SZjM0ZkQ2WHNkaUdPVU42TjUyejZsSmRiQ3FJMTlGd2huMVh2?=
 =?utf-8?B?ZzN1T1RCUTRzcHgyeHdPbEFuM1F6RllVSEhCdmFGQmlob3h0eUEvMEJwNzhW?=
 =?utf-8?B?M0N6dStqSU1zOVpEU3NGbWs2QnM2WWVmV2pIK21jUFFBOXlEVGJoSWwyQ054?=
 =?utf-8?B?eTJQR3M4bWEzRmtHVVBMcnFVQk92dDNEelFTYXJNb0djZlRQWFMxQkRZWnp5?=
 =?utf-8?B?NEJQenhlR3QrMitrTmpZTnE1dEp5RnB2d0hpbmIvY2haN1VHbjQ3LzFKdlhF?=
 =?utf-8?B?R1hydXdjY2pMdWxCcVJEdXp3WTBXSE5HTTJOQkZ3Q25uSUJ4R3FScFNEY3kz?=
 =?utf-8?B?cjJjRDE2WnlKc0ZoamlnUmU5TkNQRCthYTE3dU4yb0E0M0c4cVNXcWNPbThG?=
 =?utf-8?B?bXpyVnNsQitpdUd6T2o2SzZOdmp0ckU0QzB3V2d6TlBCakxTNTJSS2ZHeGlt?=
 =?utf-8?B?WE1mUFM3dHFMYnJENUREOUdEMUlxRlZFSlQzL1N3VUNHOFBEQ3RraE9MRkFj?=
 =?utf-8?B?aVJVTG5uY1o1WXRGYXJmRm9SRm5RTmF2Z01QMTUwdzJ3ait5RXlSVHRHb1lu?=
 =?utf-8?B?bnNGWWtycGgyZlZxR09HYTVaOUxROUNvekkvdlcxclEraXA0dlZHQmYrR1RY?=
 =?utf-8?B?OFMxSmpLNHdIOGFkUkRxbjViUTg0ME1nTWl3R3g2T2dIUkRwVUoza05JcWgv?=
 =?utf-8?B?ZnA2c0VoZklnOFF6TW1UaG9vczA0UlFjRWF4YXk0NGpwdjFFSjVTMVhkV1ZZ?=
 =?utf-8?B?bnplTTdPemk1L2pXeHlqZVBUU2J4OTRRQklzTHBHd3cvMkUvcHhraTdKWFR2?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d3654b-7dae-4d43-283a-08dc121d6e3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 20:47:59.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2d9VYm1eMJtOYKvK6wyJcwbW4gPJWXa9Arm2w+tRapnP/VKS4TL7jETKDjoajlSLVYINVmZZF+7SiXQr5UHCaibjb932bsywSRD4Vp1DdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7002

On 10/01/2024 21.29, Audra Mitchell wrote:

> @@ -4663,9 +4663,10 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  					 unsigned int flags,
>  					 int max_active, ...)
>  {
> -	va_list args;
> +	va_list args, args_copy;
>  	struct workqueue_struct *wq;
>  	struct pool_workqueue *pwq;
> +	int len;
>  
>  	/*
>  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> @@ -4692,6 +4693,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	}
>  
>  	va_start(args, max_active);
> +	va_copy(args_copy, args);
> +	len = vsnprintf(NULL, 0, fmt, args_copy);
> +	WARN(len > WQ_NAME_LEN,
> +		"workqueue: wq->name too long (%d). Truncated to WQ_NAME_LEN (%d)\n",
> +		len, WQ_NAME_LEN);
> +
> +	va_end(args_copy);
>  	vsnprintf(wq->name, sizeof(wq->name), fmt, args);

Eh, why not just _not_ throw away the return value from the existing
vsnprintf() and do "len >= sizeof(wq->name)" to know if truncation
happened? There's really no need need to do vsnprintf() twice. (And yes,
you want >=, not >).

Oh, and definitely not WARN,  pr_warn() or pr_warn_once() please.

Rasmus


