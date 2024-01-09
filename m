Return-Path: <linux-kernel+bounces-20423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D928827EA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E4285A77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2F947A;
	Tue,  9 Jan 2024 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NAUIRdaH"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8009449;
	Tue,  9 Jan 2024 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aapsN7nMJijFfrwtbnXEMg7pgZ543JYvNwjF788W4gr8uX+W6lEAqrvrt15SBYd5z5JlAAc7PT0BC0Pz4XM2naomy9MZA7Gsw0Ujb3BBKtceTlDqsJ+WEvQ7ZpRipOsSamw+BGgUgeP+U333Qk+cjGCCZqXVNuj8GXyZyxKz3/sv9l63rFME5G/d5v11iZJh9VBkrSGeluYVkFy9/2U8wBdGb735fQa0PCDUzvEYeCZ3EUy+yP5RN7wP+L9RJkhYt335IaX+PWMsETU3jxQx9ERQGLNcIfOtGSGXpyXp3jIVTeQIPCRZphDOgtq1yl6pVfCfGnLNUJ+ho3tfl5KGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrMdY7pdlivRbYWzJhWqVMAJL46XWsVF1WS5aibMyM0=;
 b=mVj5sQFXtRb28wVUVXAiw7wM67tYuZW/nCeJQlP7FLghEuWY6jxKQrhW0ylAvksJsaMYHA6F3jgMbdlZh/7vhsT3tc1f4BEU+4nE8JwELvgMghZ974zkoMKDroimu/FqVxsYEWioxjoukPCd+L7eAIwElp/Q6CaocqS2FffJVmF8N76X9sTl8tHGtwroPyeFBQgR/crJlTK44ptpETFkRP2xc06vOPH0gs+qCSerLKiD/EEA2R2m49yJujoE3CoZI4U53uWpL1xf4Ky+VHmlAiXdqanyWK9gi/TeV+KEYwUiQw/VltVDjw9Gq5lN1ZJg3yHQaH2fHJ/HlNhaCcT2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrMdY7pdlivRbYWzJhWqVMAJL46XWsVF1WS5aibMyM0=;
 b=NAUIRdaHER7cO/Hz/ho2y/M4oh2194cMugae6Yk8O/6hl7FgWFEjSZcJ0phbiSbSoytT3xPWY8dn0aQ8iURHAJBnuP2p+4Z2kcBIW0J9boFjUlC2qGgKZ3xXgdDsDkc+sakBeRsiOltVlzsa1JiSBb6xMwGznl/VooT/+qSRZDBrJI7rAuAjXTiVeHZsihcgAbyIwXvbuSaVBy0MzGpOe2XuQbTbn1RG/vRz2itH2LlnUXEN72fsz30K+sazFuFX66qyMhKZdnUb+eAp3kpeQ+HRJXZT/ppNHsjU0l8TsOKvXVVv6/sQ581GpevZupn6eQwmNryTZrVtGRHN6oBlpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AS8PR08MB8636.eurprd08.prod.outlook.com (2603:10a6:20b:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 06:05:32 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::72c4:98fc:4d1b:b9ba%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 06:05:32 +0000
Message-ID: <124218d0-80c8-4971-8ba4-1ebaf0a5fb1f@virtuozzo.com>
Date: Tue, 9 Jan 2024 14:05:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@openvz.org
References: <20240108085232.95437-1-ptikhomirov@virtuozzo.com>
 <202401091351.CqYRoau7-lkp@intel.com>
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <202401091351.CqYRoau7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0031.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::19) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AS8PR08MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a431a1c-dc02-4fbc-abc1-08dc10d8fd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NX/6Fwvfa88dShOoKzA072P4j/HW2hfqccXsCPV/qBF5s4za6+cMjyRBYOctcg0LbobTLU4RmAbyN03RiuXT/XRfWvlKXSkWcnqv18dnEWbuRjFNu2KUbAm/GiltgHb4sH/WqIxHK2UEc5cd1n7MoXJJ9+I4EFO5eaYewVj7ccqrU9HrF7O3kbakMWuJpbIH1Rum4E8HcjpqNDUsqIwDg7AlnuAYleV+Ti89QQs0kOylGDlit+jAlLGvAZ0X8K0CblmRIajG763wX418bIHzzRUkCkChhRRpNH4bk9Z+GDk7PG9BwxSvOLm5BkrfiGSoGuzwe8JckwHT7hr+nlYZ5QGxY7opcbkrcPfDTCWdYKpdnbbSPDHqQNersvKon0WqvROsAqqiLjWpP+iiIQ6VaGrqeCbDudAg9xMKdErum8yTZ/A853lRWqD6yQt6wIJIUNoGGa0gT3Wclz8ZiFMSfeY1KEN0wfetmI8b8MS2qaT/WzjyHAnDc426PwEPec9TRe9iY7jJndTFkPYSvD2fDvkbIbMQruOTSJeC2nIhqBoMBybFgy/Mgfzc07U14AI/PPkq8DOaclaLWf9f8PMWzoyABLy0jOvvw6fuFTM38OQqaz63i2UsBJpNUSteMX099WwABByiM1DHpyBa3yAiGKs+O0HiIYXs8vOuHrcQD3Fo8Qj+i9uC3ZW7gm30hx1f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(366004)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(53546011)(2616005)(107886003)(38100700002)(8676002)(8936002)(4326008)(5660300002)(2906002)(966005)(6486002)(6506007)(6666004)(478600001)(110136005)(66476007)(66556008)(316002)(66946007)(41300700001)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEZJYThiNVBCeWpuTUM2aEZGenpQNE9PU0ZLWDJySTZKRzVRWVovS0xZT0lI?=
 =?utf-8?B?bTlYeVJheFBMdlBXTWtrbUMvb2Yxb1NJOVk3bFp6Vnl6V0RSb3p5SmZzY3NL?=
 =?utf-8?B?UkcyZzUxMElXVWt6a3g3aTJBek9PRlUrMUd1eXRhbDhxL3dSWVlJbHo2bnEw?=
 =?utf-8?B?TEFNTWppbEhiRUJuV2piV2lNRGdHSlZzY21yZWRibGs5c2hyMkFwUUY1Lzln?=
 =?utf-8?B?OG1Qa3l2ejhJdURUVWpNcW1YVTJwRFlXTFcxOGtGdlZnUkhkWFhKUEFNaEQx?=
 =?utf-8?B?Q251REhEWHYwZk5iSlNFTkxtQUtSYlRWT0dQOVFxSjljdG1rRFcxNEdsU2Va?=
 =?utf-8?B?Sk1tSnF0ODZ2ZVB1WmZIMis2SVIrV0lsaTZocWhjZXQzRXNrTEY0aGZpS1M3?=
 =?utf-8?B?ZWlpWDZoNEtpR2ZvbDdocVova09WTXR3L205U1crNVBHZmVJNCtYa1FLUTVy?=
 =?utf-8?B?c3FCVXNwS0xzUjlQc3BubEgyOUxrZzhPTG9VUlhpSHZ1Vng3WU9aTy9kYS8x?=
 =?utf-8?B?L2FqWjlPaDY0NjZHRFZXekpyeTg5UCtzL2VuSGNrVDF6LzFjMmt6UzFjYTM3?=
 =?utf-8?B?eXRnTWphRlJWSExMR2xUZEZoMm95ZVJjS05NODRSZHlQbEtTdFFVdzEzeG16?=
 =?utf-8?B?UnZjaU9LZHJ1RmtPbTZRaURzdEtwSkRXSnk1RXBpR3pMR2tvVVB5dG80NU00?=
 =?utf-8?B?NmdZUlZJaHV5NTlucVd0YmdqWklIcDlZWTBDbXVYNHducjJwRnlFZ1RvUzMr?=
 =?utf-8?B?UisySDhXMjl5NEh1OUwyRkZXajdUeC9BZlVLb29temZpenlWT0Zhczg0T0l6?=
 =?utf-8?B?VWtNMVZnYkV1OFlRRCtrVlVFVlJsM1Z1ZjZXOXF1UHRuYjByeUM5Um93ZGNS?=
 =?utf-8?B?cnJZcFZhWGhpUmRDM0NpU1FqVURZLzBkSE5oQUZ2WnB2T2pYQVNnbFpPQjNv?=
 =?utf-8?B?WllLR1NxL3VTRElGY2dVR3NqMVE2WWhIQmtWVkxQRDRBeUN0TGx3cG50UGh0?=
 =?utf-8?B?YVdKRWJ0MXA1RGVKVTZ5dVk2WTVtR0tOZURqeHUrN3Rva2dZVEhTWVdzdy96?=
 =?utf-8?B?bWtXamdqbXNzVDAvNUs0ZkYrdGViNnhmZXRKMUJEbEZTUnlqcEFDWHp3TmVI?=
 =?utf-8?B?QnVnTzMxdHdBS3laWmp1YjJRTTFxRXIxTlRjNlNOZHdidllsenA5ZlpoYTNh?=
 =?utf-8?B?RURjczRhNFFUd1pCVUxPUm1QSUFpRHk4TjROTEl0Wk5ZV0pTaWVuSFQ4L3dz?=
 =?utf-8?B?aXlVVW5nYnBrYUdKblM0Si9nU0hQb0MxZ1NBMHVtNHRaOU1Kd1NEL0FTL0dI?=
 =?utf-8?B?UllhMy9PMDZDRlFrQlhsdFRmKzh6YVY4aEZiLytmZGdhUTc4S3lad3QwQlFB?=
 =?utf-8?B?dlFaWmM3amk4dW5aeDVZMlJxTG9ZVk41NFVSY2M4N1FwTTBhb1hyWGVJSmE3?=
 =?utf-8?B?NUlSQ2d1clZaNWNQUmUvUElTcUFhS3ByYTkyb0YwdTRrUHJ1ZG5CUk1nVWJh?=
 =?utf-8?B?aUVLMit3UnFDR0MvUlJLNnh5cmdNSzlYVnZHdmt2MWVuY1MxMS9DVlNXNW5N?=
 =?utf-8?B?b005bmh3VkJ1V1dqRS9hZkRqSEhZNG8waUhyVUZ2RUJteUwyN1k5ZXBKUGJu?=
 =?utf-8?B?WmNERDREblZzd0FLcTljM0JVNUhNWHlGQXhJUkR5WStvdW52RHl3eFV3RlM5?=
 =?utf-8?B?cEIrVlNKUUxSZHJxdjdyc29vRWVaUWRhZ0dBckxxWklhdHhLUUxGTnU4SE9S?=
 =?utf-8?B?a3FJOTQ3QTJnVjZyb2RhUVBtQndycFR6YUxOUjBkd3JyVVBFOU9EM2FuMU1R?=
 =?utf-8?B?Q3dQamU1N2RTdWNuMFpiOGRIY1JWZDZrQmJnUUNNN2FkQlJrUkN3azRQR0xN?=
 =?utf-8?B?VVlDL3Azb1hjVUZSNFFIMG9XeGVCTVU1a0lmbWs1a2IzQ0tmSGttN3N4UWdX?=
 =?utf-8?B?T3E0Q2RsK2R6VDFPL3pCcGY2VGs0ZTh4OThEM2paV3YyWkQ1MTg2akp2VzFy?=
 =?utf-8?B?L2JCQVViTUtpUUZjdjBqekNWWUd5YkdwQzdJK3pDZkhEeFVScy9TQVN2TG9o?=
 =?utf-8?B?Z3hEdnV3ZEtRaVUwY0xzSXRZYzVjVzdLcVBYMUFYaUp3MktSeTdHaWhCdk0v?=
 =?utf-8?B?RGJhZzRkdmd1ekJKUkI5MUJTWEdiMWJaS1lIUXNQb3o2RFZwRXVXMzhUa2Q0?=
 =?utf-8?B?cUpUN2lGZGhKUmZyOEh3dG5pQXlpZG41Wno4WUtiWmdXYStsYzBmZ3IzdkRK?=
 =?utf-8?B?VnFUeWtZSGlGR3E3RDd5d2FvUUd3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a431a1c-dc02-4fbc-abc1-08dc10d8fd0a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 06:05:32.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyjunYUs+xejpDABDG8igb5V5t3rgFedqVZ/Wa8Dyip0jijlIlf4hvMtK7aR8uwQVYkejApCVRpfCRybxzalt8+gNiSm/pIE6gC3dwp0LNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8636

That problem happens because the patch is not ready to handle the lack 
of CONFIG_BRIDGE_NETFILTER (as Eric already mentioned earlier in this 
thread).

On 09/01/2024 13:38, kernel test robot wrote:
> Hi Pavel,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> [also build test WARNING on net/main linus/master horms-ipvs/master v6.7 next-20240108]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/neighbour-purge-nf_bridged-skb-from-foreign-device-neigh/20240108-165551
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240108085232.95437-1-ptikhomirov%40virtuozzo.com
> patch subject: [PATCH] neighbour: purge nf_bridged skb from foreign device neigh
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240109/202401091351.CqYRoau7-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401091351.CqYRoau7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401091351.CqYRoau7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     net/core/neighbour.c: In function 'neigh_purge_nf_bridge_dev':
>     net/core/neighbour.c:392:29: error: implicit declaration of function 'nf_bridge_info_get' [-Werror=implicit-function-declaration]
>       392 |                 nf_bridge = nf_bridge_info_get(skb);
>           |                             ^~~~~~~~~~~~~~~~~~
>>> net/core/neighbour.c:392:27: warning: assignment to 'struct nf_bridge_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       392 |                 nf_bridge = nf_bridge_info_get(skb);
>           |                           ^
>     net/core/neighbour.c:395:43: error: invalid use of undefined type 'struct nf_bridge_info'
>       395 |                 if (nf_bridge && nf_bridge->physindev == dev) {
>           |                                           ^~
>     cc1: some warnings being treated as errors
> 
> 
> vim +392 net/core/neighbour.c
> 
>     382	
>     383	static void neigh_purge_nf_bridge_dev(struct neighbour *neigh, struct net_device *dev)
>     384	{
>     385		struct sk_buff_head *list = &neigh->arp_queue;
>     386		struct nf_bridge_info *nf_bridge;
>     387		struct sk_buff *skb, *next;
>     388	
>     389		write_lock(&neigh->lock);
>     390		skb = skb_peek(list);
>     391		while (skb) {
>   > 392			nf_bridge = nf_bridge_info_get(skb);
>     393	
>     394			next = skb_peek_next(skb, list);
>     395			if (nf_bridge && nf_bridge->physindev == dev) {
>     396				__skb_unlink(skb, list);
>     397				neigh->arp_queue_len_bytes -= skb->truesize;
>     398				kfree_skb(skb);
>     399			}
>     400			skb = next;
>     401		}
>     402		write_unlock(&neigh->lock);
>     403	}
>     404	
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.

