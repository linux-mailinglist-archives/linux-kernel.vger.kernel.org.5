Return-Path: <linux-kernel+bounces-54719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCDF84B2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE31F24429
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5312F38C;
	Tue,  6 Feb 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="H6tjc3Kv"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C615C90C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216876; cv=fail; b=Nzdu8Yx6m8ylQ2JIBDF8zyZh7sK+o+7NmtVjOjqLcCVI0gzJoGsGOA89H0CQsyOF4fBLFdKL5RzISTRwPspULdaTZseQ4bqcVKZeAm0bijBVxLJvktSAeE0BJEVxShPLKL383RiEzHlC5K93vymZBrUgGBUDzgCR1499SA+taEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216876; c=relaxed/simple;
	bh=bi0FU0aFW+nbjyKwnKbjmH1t5uyXkN4e6pldXDVfMLY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLU6rTGSpEDsvy6rNfJfO4+2W+3b29I1ITPvJvSUJbphI9wboZk8bo8ZQWWS26hs1b+U+lYPMtbgt23LgWKkIQXh7Knjofex/BeuhlFQrJ53Bur97w5XG4T36kV8iM2UBZyYvXbUN1SpjgcmCNpppRMdKeBdpLef6lIfrg51WfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=H6tjc3Kv; arc=fail smtp.client-ip=18.185.115.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.181.221])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id E2A5C1000134E;
	Tue,  6 Feb 2024 10:54:25 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1707216853.877000
X-TM-MAIL-UUID: aded6416-59c6-4bf1-8ab5-eee3535444a7
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D631210045519;
	Tue,  6 Feb 2024 10:54:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjjYFcWODQtxLQm4ESDtTSMxwvte0+If5Z9bAbKZsive0YxbCh5+rJenXj+WFoc1YsQV24g5gTTL/SVu0qLCUuPgOIzTG6+CQ81K7ec186ORNtnstx5r8myPu8lAoawwuzfjm8/7jLmE9rhjfAwElJNerHyE4q5dhzFuTAkU4UpvELv0SGfUZ7IIwSiZSGPmFmS0TQzZ0yh4GMuTQgTSENqp5zRMKRjnCuSJ+XEQXCVXQlO5ipuJj5oWjFWCyl7FtmBK4ZQ9OTL+3gcJzapUxJn6U0/kfDwueFG+lB99vSwmSUKDZm4/dWQEEniWXw9hoLljCPaLBAWwPep6aWC9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WTxzAU2ONlG4E8vJbc1k2X7FnbztFlMsp2ycB0rALU=;
 b=P9S6Uw894Jp6mVk6nmSG+Z8jjvLH2SUZAwp4QS42og7CgTCA0DiGTY5QDfD6n3K0iEWu7Q4lbh7JZVkdq3whcKAXMAVwJejtormJ2wJwtPtbuZUDJtziOilymOSavExFZDP1E5G+TxiZMkpEGAoBzpRx+j1x5n2kKjxbLntsxUk6LxeK2enlLVQ3LMIAoHy59cx2jlnRvaKEJZ8RMwwF9A+38fcT/p82ZHhcKbqJ5h8DUgrvcglgVYfuDiIT39iqK1RwlZhg1o6U64q3SIiCKGEheX/znfkgxbuAyhAHfvtK/v2agiEYduYB9szAvaXjc8aIhf4gBvg5Ekw02e2Uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e25f9bc4-4155-4b55-bebd-48ae18fe856b@opensynergy.com>
Date: Tue, 6 Feb 2024 11:54:10 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v3 1/8] x86/tsc: Fix major kernel-doc warnings for tsc.c
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, "Dong, Eddie" <eddie.dong@intel.com>,
 "Hall, Christopher S" <christopher.s.hall@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240201010453.2212371-1-peter.hilber@opensynergy.com>
 <20240201010453.2212371-2-peter.hilber@opensynergy.com>
 <2b482c41-4eb0-4a49-a425-469b05d63018@infradead.org>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 xsDNBFuyHTIBDAClsxKaykR7WINWbw2hd8SjAU5Ft7Vx2qOyRR3guringPRMDvc5sAQeDPP4
 lgFIZS5Ow3Z+0XMb/MtbJt0vQHg4Zi6WQtEysvctmAN4JG08XrO8Kf1Ly86Z0sJOrYTzd9oA
 JoNqk7/JufMre4NppAMUcJnB1zIDyhKkkGgM1znDvcW/pVkAIKZQ4Be3A9297tl7YjhVLkph
 kuw3yL8eyj7fk+3vruuEbMafYytozKCSBn5pM0wabiNUlPK39iQzcZd8VMIkh1BszRouInlc
 7hjiWjBjGDQ2eAbMww09ETAP1u38PpDolrO8IlTFb7Yy7OlD4lzr8AV+a2CTJhbKrCJznDQS
 +GPGwLtOqTP5S5OJ0DCqVHdQyKoZMe1sLaZSPLMLx1WYAGN5R8ftCZSBjilVpwJ3lFsqO5cj
 t5w1/JfNeVBWa4cENt5Z0B2gTuZ4F8j0QAc506uGxWO0wxH1rWNv2LuInSxj8d1yIUu76MqY
 p92TS3D4t/myerODX3xGnjkAEQEAAc07cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbSA8
 cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT7CwQ4EEwEIADgCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXXd8PQAKCRAiPT9iQ46MN1PT
 C/4mgNGlWB1/vsStNH+TGfJKt3eTi1Oxn6Uo0y4sXzZg+CHXYXnrG2OdLgOa/ZdA+O/o1ofU
 v/nLKki7XH/cGsOtZ6n3Q5+irkLsUI9tcIlxLCZZlgDPqmJO3lu+8Uf2d96udw/5JLiPyhk/
 DLtKEnvIOnn2YU9LK80WuJk7CMK4ii/bIipS6WFV6s67YG8HrzMKEwIzScf/7dC/dN221wh0
 f3uUMht0A7eVOfEuC/i0//Y+ytuoPcqyT5YsAdvNk4Ns7dmWTJ8MS2t2m55BHQnYh7UBOIqB
 BkEWLOxbs2zZnC5b/yjg7FOhVxUmSP4wU1Tp/ye+MoVhiUXwzXps5JmOuKahLbIysIpeRNxf
 B8ndHEjKRl6YglPtqwJ45AF+BFEcblLe4eHk3Gl43jfoBJ43jFUSkge9K7wddB2FpaXrpfwM
 KupTSWeavVwnjDb+mXfqr4e7C4CX3VoyBQvoGGPpK/93cVZInu5zV/OAxSayXt6NqZECkMBu
 mg7W7hbcQezOwM0EW7IdMwEMANZOEgW7gpZr0l4MHVvEZomKRgHmKghiKffCyR/cZdB5CWPE
 syD0QMkQCQHg0FUQIB/SyS7hV/MOYL47Zb+QUlBosMGkyyseEBWx0UgxgdMOh88JxAEHs0gQ
 FYjL13DFLX/JfPyUqEnmWHLmvPpwPy2Qp7M1PPYb/KT8YxQEcJ0agxiSSGC+0c6efziPLW1u
 vGnQpBXhbLRdmUVS9JE390vQLCjIQWQP34e6MnKrylqPpOeaiVSC9Nvr44f7LDk0X3Hsg3b4
 kV9TInGcbskXCB9QnKo6lVgXI9Q419WZtI9T/d8n5Wx54P+iaw4pISqDHi6v+U9YhHACInqJ
 m8S4WhlRIXhXmDVXBjyPvMkxEYp9EGxT5yeu49fN5oB1SQCf819obhO7GfP2pUx8H3dy96Tv
 KFEQmuh15iXYCxgltrvy9TjUIHj9SbKiaXW1O45tjlDohZJofA0AZ1gU0X8ZVXwqn3vEmrML
 DBiko3gdBy7mx2vl+Z1LJyqYKBBvw+pi7wARAQABwsD2BBgBCAAgAhsMFiEE4+UwmTdY2H45
 eYsEIj0/YkOOjDcFAl13fD0ACgkQIj0/YkOOjDfFhwv9F6qVRBlMFPmb3dWIs+QcbdgUW9Vi
 GOHNyjCnr+UBE5jc0ERP3IOzcgqavcL5YpuWadfPn4/LyMDhVcl5SQGIdk5oZlRWQRiSpqS+
 IIU8idu+Ogl/Hdsp4n9S8GiINNwNh5KzWoCNN0PpcrjuMTacJnZur9/ym9tjr+mMvW7Z0k52
 lnS9L+CRHLKHpVJSnccpTpShQHa335c5YvRC8NN+Ygj1uZL/98+1GmP1WMZ6nc1LSFDUxR60
 cxnlbgH7cwBuy8y5DBeCCYiPHKBglVIp5nUFZdLG/HmufQT3f4/GVoDEo2Q7H0lq3KULX1xE
 wHFeXHw4NXR7mYeX/eftz/9GFMVU29c72NTw8UihOy9qJgNo19wroRYKHLz1eWtMVcqS3hbX
 m0/QcrG9+C9qCPXVxpC/L0YLAtmdvEIyaFtXWRyW7UQ3us6klHh4XUvSpsQhOgzLHFJ1Lpfc
 upeBYECJQdxgIYyhgFAwRHeLGIPxjlvUmk22C0ualbekkuPTQs/m
In-Reply-To: <2b482c41-4eb0-4a49-a425-469b05d63018@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::29) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEVP281MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d4af2f-2bf3-419c-9899-08dc2701f3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ILFYS7D3WyIa0kzEDuE/AaV7bW6PNvI50F2ZL9ORlkGVKp+ntLP1Z2JZSiPAOkW536zz/vs5bAXf986/cDkj4tC0XbqeHkFA1VMtdtamQ1DHFHMWlt7TgQ9Od918CHXTFYty3t8mLlxK3T0JdlY6AaPZJf7/1HoPpUnDw+rK+3RyXxp8Lh18ZV/ywJEl4myYqfVyz7D1VWWgViTQdppTGe+ufIK75z6s5RDLTLY1vl+ACnFCYzWZ7yn8Zf5XSXsC5SKpFwiMUz+rWANxOi2CZGLAVwVpildWmxLCRFgrXc6Zudmbw7PyESBhvsO42yn31FjLeNzdz0bBaq+h3iexRSgAWrC5z0YSZ+ZPOsogCcKSrHkAOUqnNcIjcS3mBSLReBuYdUxrXFPKdCGCYTkhBP1eGh1r62L5sR1Wrz3/s8piUYTDFQZOtIfaRdaABJ/fcFjeVtcbXN2gthI7ntR/wqr22+Iyw8jtPMqbfFkSbcdusMRLImzvVOy5lRKHEVQfCWeJcpqllxSq+WI08cZz4wVfyEg3ue2HOK3UXeHcQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39840400004)(230922051799003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(966005)(31696002)(86362001)(478600001)(53546011)(4326008)(36756003)(8936002)(44832011)(8676002)(7416002)(2906002)(5660300002)(316002)(66556008)(66476007)(42186006)(66946007)(54906003)(83380400001)(38100700002)(2616005)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpMUUJ4aitJSGMvMVlNK2tEMCtBeC9UV093WWhGQnh0TFJHSS95c2R2eCto?=
 =?utf-8?B?Z3cySDB3TUJSL3pWcHZTTnB0TXo3Tmw2M09wUWNwbHdnbHcvK0hMUEhtK1pr?=
 =?utf-8?B?V096cU9kcGdIYmdJbkRHbWtvM05XUDNza0cwVmpOZTRvQitRc013cEh1Z29p?=
 =?utf-8?B?aWI4dVZqOG9IQ25sdlE0Y3MyUlFXcis4NTdPMi9UWkdRMjFrSTNGVjhUY0lK?=
 =?utf-8?B?R2N1QVY0dzNKNFZ4ZFprTzduRStCZXppeW5NODZheEVSQ1FGZlZvM3ZjeXVH?=
 =?utf-8?B?RHdvOWhYaHNxOEErY3BrNWJBc2FtZTBSeHd4SEdJSXVQb0xnbnFmSm5rSVgz?=
 =?utf-8?B?d0pubktwcExrUG5KS2lvdWhNSDh5WVI5ZlNoYnJvVFp6cnFZdzV1UmozSk9i?=
 =?utf-8?B?bHE3T2sxTlRYVS9yQ2RmZGxSOXpEUSsvbXBXVXh3elc3VWk4c3VQRXg3YXRv?=
 =?utf-8?B?SXBVelAvdVRVVlJ1aGRtalhwbEI5Rm9EUjRRdXhxMVRoL3dpZzgxQ3lHQSt6?=
 =?utf-8?B?YTRuK2NLTHpGcEFOZVBHaUxFeFExVVZWQjFtaStPTXFWMlRrcS9hYXB1SlRy?=
 =?utf-8?B?cDVrUHdFZE5OYnJGSFRJQkNoazJOczB2WU5xblRkUmpwSlEyV2JMdU94T21v?=
 =?utf-8?B?TXJkbXp4TkJkaGc4akNQKytqMnJyc1RmQlJLR2p2bXFxZzJqUzJXNWJLaFZw?=
 =?utf-8?B?bzdYQ2tnY21GYmIrY3UzdTREaDZpaU4zN005enRJTEJacGtSL1RwVGxRSFNF?=
 =?utf-8?B?QVpGcEwzMlF1OEJOWVhlUEF6SnN4aEZGNW1oZUhkOEdxV0JlcFpidWdnNG9O?=
 =?utf-8?B?RnJabkREM082NG4yVE1HODBoc2QxZWVUOVVnUWJEekhMS1NtTExhbU9wZ3Vy?=
 =?utf-8?B?L25JMnpCbU1sa0cvZ0VsTENxSzJCVVV6NHNsL1JZK3E3c1NpVWhvWU1LcEhn?=
 =?utf-8?B?MUw2bkRiTS9BSmZRT1cvak9leXRGaDZLc2FnaHVOWUdqdE84eGZhMS9RbEIv?=
 =?utf-8?B?eVRQaitjSmZDRnRpTlNBQzdSRU9MTDJvcFdQVDkzMkZvQWNCbkc3MkNWcmdL?=
 =?utf-8?B?VkJqSTRsbDZGYzRNTGkrM2srUnlKZGd2NWlDNElObFlGcFR6dUxrL2ZSSncx?=
 =?utf-8?B?Z1F0Q2NRcSttQVN6c3AyKzUxOWlkemVGQi9GS1BwVnhsVjhJZjhrai81djdT?=
 =?utf-8?B?dEcwNGhBWjFzN1FyZVI5OHE3NmxYdjFLS0gwaHZsUHcyTWpLenRhT3pGcmFZ?=
 =?utf-8?B?TTVIUDM5aTRHMEJYSmdmblAwOXZQdWpGb2pqRTdsL29IeEY2TmRRTWF0a2ZQ?=
 =?utf-8?B?eTR2V3RoSWpiWTRYRFBoNllMNXQ2YTBtNDdDOHA2ZUtVcWxxSnV5alJick1H?=
 =?utf-8?B?NkJRb1pXU01TeWtCc0tUK1FFV1FvTmoxeTFEZFdTMnpDV1Q1RS9ET3NwTlZD?=
 =?utf-8?B?TEJkRzdtV2tkelJkWmNtWlZ4T3ZReEtYMWFjVnhiTllRQjcrSGFmQS9BN0FV?=
 =?utf-8?B?aFN3TEMyamthMDNMZXo3bXhhcDAwa3JSS1NaYXh4ZGI5cUI0OHlHajY5REdt?=
 =?utf-8?B?dzJtUkJUMFRFTGtxaERldzZ4U0VZeXE4TStTZElJVXc3dlgxcGdHMitZcm14?=
 =?utf-8?B?bVVzeWc2V3pIQk9MMEJhRkQzTjB3QUxVam1qV0RFc0pkTWFhRG9nVTZQMWZN?=
 =?utf-8?B?bmtpcnBOeThqRGNBTENab2xaM2dTeStGYjhPUHgyV3VCcHRBMEVLTFBERFdj?=
 =?utf-8?B?b1lCckxuSFpjcmtSVkVTSDk3WFdqekdBcy9ET3gxNkFCWndHaVBsRDZma3VC?=
 =?utf-8?B?b3lRNjdqMXp0YzlzdFFmbHo3Tjg0bnF3OTRTT2NEVEZ0dkJpaEozcnczaUla?=
 =?utf-8?B?RklnZDZONnBoS0xkbG9aUXd2WWVaekdXNG4vNkpYT2tNeUxEOGluaGxHRk05?=
 =?utf-8?B?NDlXQXB1NHpnWkNEVGx5S2E3MHV3bFZNeWlmd0t3QnRQWlR2UWNIQUI1b21w?=
 =?utf-8?B?b3pSVE5JRmpYQUlCTkRXV1YxK1ZkYUdSelIwUXVaTTVjNjRvUThPQkpsS3Fr?=
 =?utf-8?B?c21yZHBxak1Bc044T3c5dW0zYk1VaE5pQ25xcEN6SUh5Y0tLcmtLUExaUzZM?=
 =?utf-8?B?RXNxWEVYazFXNEZrYmVpMG1BM2lTbkQyandQOEQwczJZQzNsZExNYVZ0WFRR?=
 =?utf-8?Q?lkoKBgPBCy4JbKEkik5Gw1wSsf1uCHnI/LYYFDQjC+9s?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d4af2f-2bf3-419c-9899-08dc2701f3a8
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:54:11.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9Y36aNCoIxPKHAQwfW+WOQBxspJy9UCBDascWBmtNFdkz01pyOyi1PY/ojP8MrgwK0WY+4jDPNx06LW7ijO0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3598
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28170.006
X-TMASE-Result: 10--8.865700-4.000000
X-TMASE-MatchedRID: QfHZjzml1E+bG8qWlzo5YAw4DIWv1jSVbU+XbFYs1xILDzQJD3kt0DRG
	JnoK3ysiyPQBWVTJESeq72W7KGNM53V2KXA5dled/SFb4+LsKix1cj4F9+ou5FHuXiHskLMTfnb
	8wbu8AC4kpXju9gUp3EaC9D0efVcRsYeVnDqLhJUCQiwb26pJ7mtxVUHuXeM7hE17EBM1S6KFnA
	ueumBAmAA06mG6LmqtslIYUbhyaL1VIf0MK//JfsVNAYApHGPk2j7jyCKpnCcSCDdzAMeX/Wp2V
	XUuZsR8bBkbaojY4Gya4ymjlcrDbznxJqun3snzbkV4e2xSge5lMbL5Y+yg37VL3kNpr07Vrqah
	je1eKUveGbLAfCA/HmA7bUFBqh2V
X-TMASE-XGENCLOUD: dd0fb2f9-6eeb-4c57-a4d7-29746ee4da8e-0-0-200-0
X-TM-Deliver-Signature: 16B3938E841BD9C6FCC18377233DBCB8
X-TM-Addin-Auth: Uw2EHpSjO2FH6cJr6E/TKPugL0WmStbtQl+UsTR7E79Z5uLsJxFKDkQX/pg
	9hGSMU8pq0MIHBjKqZNIvse6qrF3uKTyXeZbdN/NAAocA1JloP6s4z8hUq2VFXA5649IEsTs8J5
	HG+FmdMY8HFJZTlpYs2IS9R5KGBw9IT7WYhRyJF6uc3Erm4799IfN9eInOP3DVbpIcqTtsUvivt
	sj4ZUV9m8OEPOHTwUBpzcF9UeN0sH4g6q0aSBxj4x2MN3AX1svynAWKhppfJ9BkBqFFYieT3UcH
	yW/LCjAsh6e2MM0=.DaFltaZjw0gwqYkzk4amhYHP9xegPLFBphFXMDgviQ/0oRMlL9cm3bj57i
	yz13ij+GdmTOscrRKJQ/CA//CQ739f/RsGoPJfxdV0rYFnGGa7F+qxrDAA014Y0eP3JWUM9sd2d
	knp8zlslCM/iGAEfJ2LMqYwDD9FnIhTQvfklgbfLY4zpCjG6LdS2mwRV7U1AyeOMZmAVNHyFyGP
	En0fYQxFHt4s/XGuVuF8IOYHbGhQRjJmJZWzClNylF3FQw7CZKYUKB84MvUnPmoYBdh6QM8qsyb
	zbGMh+I4FmZFKU+Ru0QWbwBnsIt7zM+2KT/kmvoWG8/mk85ExTy2p3CXbPA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1707216865;
	bh=bi0FU0aFW+nbjyKwnKbjmH1t5uyXkN4e6pldXDVfMLY=; l=1494;
	h=Date:From:To;
	b=H6tjc3KvyqPIzlWyEUeZeImUvF8gH97AW+ZqmIAXenGalUuCwzrXUMicjTRSuMRQ4
	 eDV5xFt2RDzans5Gh2/GYuptbiwHiL6iUoHNtuGSf9iFdEW7zocGsR4HzaRtoQmotl
	 1bIQQFE0EmgVrUxEbF6T1uFcXyB1cd6UUjcVeFN61VVP5qPsP1X1XZh1f8wA6M3NAs
	 2Hl/6nYF0wFjzVDPrAHVPCdcjet8WNZXi53y1ws7ZW++ow5bRgYK5UxxBC0kfG46RY
	 zRZ9Ul94IyIqUEHAryDOTX38Etb+lpU8c45yT0Lg5v+hHyZWRB4r2oppNTSLK8FHij
	 2kN8QGUOg5sYQ==

On 01.02.24 05:52, Randy Dunlap wrote:
> 
> 
> On 1/31/24 17:04, Peter Hilber wrote:
>> Fix the kernel-doc warnings which show up with default arguments for tsc.c:
>>
>> 	$ ./scripts/kernel-doc arch/x86/kernel/tsc.c >/dev/null
>> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
>> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
>> 	arch/x86/kernel/tsc.c:1373: warning: Function parameter or struct member 'work' not described in 'tsc_refine_calibration_work'
>>
>> The first two warnings stem from members of the convert_art_ns_to_tsc()
>> return type (struct system_counterval_t). For convert_art_ns_to_tsc(),
>> the return type members are documented like parameters.
>>
>> Since these members are already documented with the struct
>> system_counterval_t definition, remove the redundant documentation for
>> convert_art_ns_to_tsc(). This resolves the first two warnings.
>>
>> Fix the third warning by appending a ':' instead of a '-' to the '@work'
>> documentation parameter.
>>
>> Suggested-by: Simon Horman <horms@kernel.org>
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> 
> Hi,
> or this way:
> 
> https://lore.kernel.org/lkml/20231221033620.32379-1-rdunlap@infradead.org/

Thanks for the link! I did not see your patch, I think I could add it to my
patch series instead of my patch.

Best regards,

Peter


