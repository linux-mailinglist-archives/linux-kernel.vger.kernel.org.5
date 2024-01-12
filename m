Return-Path: <linux-kernel+bounces-24428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75082BC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1281D1F26276
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782754FB1;
	Fri, 12 Jan 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sRmvq4Hu"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2021.outbound.protection.outlook.com [40.92.102.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7833061;
	Fri, 12 Jan 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjP2Dl2eedcpRhimDuCoJ8gVMx77UYgH9L5jEX521fMeuvYXcZcSj+5qL4PUisIkMPiaf7B09L1Xa2C2BWX3uW6BUU+zOCkHa8j159qYblRK77wR+YjkTEwNVNWMRgHOK5Y6YSgh1W8/RTRqx/62CEsmH3S2sthhKLIi/DN7W2OmefxX1PsxMji2fgPS0xgIO2ZuhtA9KfKLHZedLABmRltSedFSnurJuRU8jYCf+meiCYqSmzCc6dQI39wHkBbqihffZSVJC37XGEUPfQGK0lLFAV1ILIbEOwCS/S6e2N+6CRH6+2RJW+TMMrJTIQanoE1cgxT6pKOB0BzoUiS2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUzhEnFR+92kajQgAPVLJZPtcIZOuIAYDs3ZJ8mkkm0=;
 b=NrH8W49WrMgtOPJPzfQOnZ3SvV8ZhFREaTyDd8EfZF2MMJDPjw7bdZM8nMaoGxEq6a5wzWeEJOjsOlMK5X7ZZFQs54JenQHdD9cx4pCLjRpdwuJqLHCezN9WPOC3D6NQr5p/h1XFYauGowiGk0rTTL3BvIVBbsZHgvCVz3E7sk6qBMHcOvxw334zUvH+VxrtaKBjOV6x4VvuZdZ0xup4AFZMtGF1jA4rt68TdoDvoGEHetU3MErdGZdoPEO9UMbuiE/+IncZcPXmUGeIlMV/zhWalHkXN+HKGWUJr/YX8V46E64HrOwlvrIH8b06h/B/1ZJEKg2xCG9bFaxV9vyuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUzhEnFR+92kajQgAPVLJZPtcIZOuIAYDs3ZJ8mkkm0=;
 b=sRmvq4Hu+hGvKIt5OJ/derbL6eToNh30+jABIqRlxBBR6Fa0fO/PwyG7zJ5yT+1sxscDnYeqk1M/7NZkqBZq+HArlrvhwfalprLJdciVH/FriRUEwG5u6Agzk5SRJqOluVFfAHXhpsSfXSY3fggpwPmi6n6hH6Agw/dhtTCmig8/GmpTDteggP2yy4zXcmk661z5O1mx1IxQ0ErVr3cg9N0wORiLlQzuXNAS1RqQiMav95/cD1DiAIO43yyDzZAOG9bkPOjbsYHymgiTzJa52lqFAALc2N8Sc5CNRfemeyDO8nEaH+7ttB+9dx0xStK4KGS8Oo8E+E8rXWxYAnRCjQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1505.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 08:35:11 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 08:35:11 +0000
Message-ID:
 <MA0P287MB2822A18C53C4EDDEB2DAF42CFE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Jan 2024 16:35:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
To: Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240110-untoasted-underfed-fe81479506f6@spud>
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240111-jolly-prize-930931cc648a@spud>
 <MA0P287MB28229BCC9EA83507B99A9F3BFE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240112-overhead-disallow-8c2a4b97c36c@wendy>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240112-overhead-disallow-8c2a4b97c36c@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [QYCvGXN62KQDz23u836fR2J+ZxV5k+9P]
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <1410d7e2-1e46-4a27-b574-881fec8fd214@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccf027b-97a2-4ff4-6d59-08dc13496415
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KyYSoabDyfJZD2K+jkaKuMThzWcBn2OdCisAA7oJuIzS12WYMHEECheHYN3H/uUTliSMFxSav9mqevb8vC/81jTKQOLnuPAG45fHIcKMwxsTYvlB00nWQ2+y8rJI5cVerEAAu1QmQXra7ycXrRr2UoezEkvvc9MXT/AOpCkRhkxd86Ehndvk04vMq6CyOEvHQJsdF8apxszn+IN4DbdKSHzK0q5FXo3SR+nn3XHzWTH81SKsKRO27ZHyh8B4ZNzDapxE342QDG2WT/j7qHR7IfOn3Wm9tMdJlm2OpcYeJDyAyuugwVYPWS2pjWE7JKQCbidRNoXGVC/dzQC84wYTA119aF8sJ5OtUCXQnQGCovyJMOuKD+SdnzHGdO4UBGc9nEls5qdD7nnEjhIfKODYdEVOpkX/++QX2ud5GL+ecCVXwAkOLHqcN7tPL+ariImaPoA9Rj6Hy9n6ArckAMsxR2iKzCrI6kpphSRHAtgCx0N8peKWCe91MY5pP0Hi0ue6QwwVwG8979LZ3k4pA5vLhP09fl7CGtxfkHe/SqHzQ3M+JrAz0t24N2xTO0UAQ6oW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFJtYWFjMUtSQnZqWTJod0NPY2gvMnlLd2szMGRDWXJJTHhVWGRvM1FRV2RM?=
 =?utf-8?B?eGVOb3IwZGljaUx0UTB5ZFdkRWhRbHBjdEltS081cEdGMHdGM3JOU1hFV01U?=
 =?utf-8?B?SXVTWXhjWWZ1bnFzYVhuekFpTFdsZDk2cU5jY3JyV2FuT25ZRkZNWWQvNUNZ?=
 =?utf-8?B?bXZ2Wk5JVFBJK3BZa3hqMGUyakZWUE1QTXpWQkVhVTdsZGordHdzTUN0elRV?=
 =?utf-8?B?QklKaHQ0dlYwNWZTaE1qUnJ0QkpFQWFaUzROWE1EOFRBVG00ZHl0MHVsbmZO?=
 =?utf-8?B?Vm1KRkJmQkJ2WW5yc2NJTG5tcVpPc2hHblFWS0Q1MzhabWtTL1FiTUhPcktN?=
 =?utf-8?B?eVhlQ05vQmhVOEovKzRycGRZTjdXeUZDOEdSS01FbVJLN3RXRzJjTmh6RXFE?=
 =?utf-8?B?UEt3czN3R2tvYzF6TVlqZkFTd29UTUNIcWkwVkNVUjVmVUw0eEpDWFlXVEV0?=
 =?utf-8?B?NVJGckZkWXVqTGRTaFB1V1B3M0xwQlBnV3VHaTA4cE45aTBwK2VqNmNncHp0?=
 =?utf-8?B?YVl6bGdaMWFsbXRPSUZKc2RFRWkzbUYyN0g4RTBjU3k2QjVXY1ROMkVtYUhS?=
 =?utf-8?B?bnJ2OG1NTy9sdnFzdzNWcHo5dkdXNHFNSHdSM3oyV2JwQUc1TWd2TENuOEZN?=
 =?utf-8?B?SXBFeXhlcVJsREkycFRhU1FJbkFxYlI4SnNHUXkyRFVkQ2hQczBsYmNjN0tT?=
 =?utf-8?B?emdpS0lkTTJvLzQ4WGZTZ1dUejRCajJZTU5sV3hmWE1Fd1JHTTUrYVpUYzJl?=
 =?utf-8?B?bmZWQTg1L2dTUnVtbHdOOFpjYlUwUENxcUtpTUV3aENoZVB3cnhaRFBEYTNK?=
 =?utf-8?B?REdyTlVXQXAyV1MycVZiWmhxNm1IRkZJdEJPQkg1Q3dOZ0dNdkd6eHd3d29t?=
 =?utf-8?B?UGN5bEZBMWNkZTVScWtWNlBWRVdXdHJxU24vM0RSZ0FXWHYxSzRvTGFySUVF?=
 =?utf-8?B?S0ZTcXBsT0c0ZExkRzdGY1B6OWxBUVVTdDVOa3puN0VRRlVMWThSRnFwV212?=
 =?utf-8?B?M2ZFZTdIRlJ4dVZTYm42RVZVcHRvY21MSzVMVjJkU2tnY1VKTjMwTEhpeElP?=
 =?utf-8?B?VTFIWTB2QXlqVGZ5dENYNUdMeHE0SDlEV2Iva0FGZmd5Q2VTcnc2blRvOG1G?=
 =?utf-8?B?QkV1YllvWFJuNkZidVVLdTNtSlRNMnFqNW8yYkNuTkpaZ0wrcFNrbGNvQmZN?=
 =?utf-8?B?dC9NajFRWHJxUnRaVzR3U1dLU0xwKy9IWDE2bFgyNTIvcy9uYkJBSittRzNk?=
 =?utf-8?B?UjljMDNzNGZpTFNIOU0yeW1pTEw3a1pPREJXVlZIUlI5QU1QcUNCK21WVDFl?=
 =?utf-8?B?ZVE3WXhyV3NoTitiUGdUZ0ZnRnhsdXppVGYyNzZFMERQaG1lZ3hQN0ZldDlS?=
 =?utf-8?B?REpESi91ZkxtL1o1TXV5WTdtempmcXhaZWh6N0YyZ0hPRSsrV0paU0d2TWZl?=
 =?utf-8?B?czBjR3cyZ3pXZmNscWtSWDhEVDNXS1ZZNEhsazgwV3kxWGVuWU9RdFJsZHJW?=
 =?utf-8?B?THpRdEtnejRBc3hncU56cEtKMmVZTU9LY05JQjRRcmxqTm1TMGk4QXlwRm1p?=
 =?utf-8?B?eVYyQitFbWVXRk9BME02cTFlaEw4WSs0MjdkR2RDN3liekRqNEhzZFBoUWhv?=
 =?utf-8?Q?HWSy4TMAOcbqgOpFLXG4mLDm1nEhNucln0QETO8JhZiE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccf027b-97a2-4ff4-6d59-08dc13496415
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 08:35:11.5741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1505

Conor and Krzysztof,

Just a quick question, due to I am planning to change the binding files 
you have reviewed,  should I remain your signature of “Reviewed-by" or 
remove it in next patchset?

On 2024/1/12 15:42, Conor Dooley wrote:
> On Fri, Jan 12, 2024 at 08:08:15AM +0800, Chen Wang wrote:
>> On 2024/1/12 0:58, Conor Dooley wrote:
>>> On Thu, Jan 11, 2024 at 04:00:04PM +0800, Chen Wang wrote:
>>>> There are four types of clocks for SG2042 and following are where their
>>>> control registers are defined in:
>>>>
>>>> PLL：all in SYS_CTRL
>>>> DIV: all in CLOCK
>>>> GATE: some are in SYS_CTRL, some others are in CLOCK
>>> When you say "some", do you meant some entire clocks are in SYS_CTRL and
>>> some entire clocks are in the CLOCKS? Or do you meant that for a given
>>> clock, some registers are in SYS_CTRL and some are in CLOCK? It's the
>>> first option, right?
>> It's the first option.
> Then the gate clocks that are fully contained within SYS_CTRL are
> outputs of SYS_CTRL and gate clocks fully contained within CLOCK are
> outputs of CLOCK. You should not use a phandle to SYS_CTRL from the
> CLOCKS node so that you can pretend they are part of CLOCKS just because
> that makes writing your driver easier. That said, obviously you can
> share the routines for turning the gates on and off etc.
>
> Cheers,
> Conor.

