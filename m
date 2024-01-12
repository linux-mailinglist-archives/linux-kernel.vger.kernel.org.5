Return-Path: <linux-kernel+bounces-24423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDD82BC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1BA1F26078
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4935D8F2;
	Fri, 12 Jan 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZrmsPGJb"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2091.outbound.protection.outlook.com [40.92.103.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB525D8E0;
	Fri, 12 Jan 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8YpJRzh9wOXr1Jn5CoB/HzEtWvEFSsDJTUN9NkjBAONpLUdDC7y1XM2RAVY7A5/xJqj7G+lVncCx1MGs9v0AuDUqlz9bs4K2L+D9P5d2phtTueI57inJAxkv/o07WKgLCwdc/D7krMYg9NJYAFQSNOSnJxKxKfwnzeEAbAC2BlUFKTb66a1MD53YhMrp635DckLJADixSi1NuV+zCHwXrNXIi4yTyb99fVcAqbtbhWc5SgCYC9pb0JpdPwatmLOQldofW/DAjtMASFbh0FsKNVbRu1L8JIPhIbq+36iBpo21pHBH1dv+ghyt17bOtbX6FnmtDR4hidEfY+0kJPsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaTJdTg3B12wrLgbWoklTTxqPQ7XQJLsmTt/80ssg0Y=;
 b=Nog92v51G29dQLGTzjVGbdxUWfV1lU2snZkfWALRsaZKGjn9tVFpLtLR11I4B1O+BKet7hbxiuCKjXjXh9IvhaZfQq5OUoSxOBom0iRM6abIcrXuTVmlViqdsUO9U2OcQygxMhT6u64AKrxJiiM6CwG+HUKfXIX+5fSocNZG863bo9BMjau/FXoeiPDl/0Y4ZOMzw5tk2n+VcrSlSp+HDgotH/U/9j57dB6yIrDupJVVGdPM2IqRMJGlYU+zhQRu/V97k00m4uH8+9h6z3mIouFvJhGSFQdbbe6NbWS9OXRoUpRXA9jzGz+HHQv10uyMMBrHahdW6lT4BY9Elp+ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaTJdTg3B12wrLgbWoklTTxqPQ7XQJLsmTt/80ssg0Y=;
 b=ZrmsPGJb75h/5NxvGHTMjLQPcTw/uyqjbw1k9NTGaQvOvXHvMbMxz93befVKwW7EdI+4N2qgcWUk0yQ2IR3k6+zniUjMJGyCWuJ/lHkt4Y0Au0xB4+MEjq+oo4VcqoprhwzNk/5acNfJBBboHtcapBgmwZqYYlHF43yCYjdku9RzY/zHpZZ7Qfu1l7PueZwwgTWHGvGLlq8EGD5t08Pb9lYY23pPkMpG/iyZPRlmjvUQsMnvS9BPOdFfXHLynCDOSiek9faimKC5jcfNOkeaUleKd4Sjz0rfYi8hwxUMv1NffznxBbNJB7pjmYJCX8x0bfwv/UPPxw3L5t17YSc4ng==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1503.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 08:27:38 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 08:27:38 +0000
Message-ID:
 <MA0P287MB282243605EB9824657607192FE6F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 12 Jan 2024 16:27:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
To: Conor Dooley <conor.dooley@microchip.com>
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
X-TMN: [epeMN3zhYM4oTnqhGvcLMZ0RAL63rvUA]
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <db25cd73-fe54-4e91-95fd-56e4245fa5d7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1503:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e12402e-6dd9-432d-b69c-08dc13485618
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bHqlMV4dkZUPbIklg9fH3lB9tsb6j158qVzwf+0NjlTnixHeS8MSOoFBYfCpOE3kikGZtbpzwrG0vJmqeJY92OkolswdQPgvyV4K7b6fVFbBPUNCSXMSfj8pBr2YcxAF2CjqTVTIySVorkIPtPALQueOgrDia7CjYLqDzcgqa9VL1DGd8bm82//BnqsEV98hGV77AvDlDHVz8Zjufub8Sy6q+42tupn2jL+C0Tvc58QIk3jjla9IK+PiOA84ViedPXal0lVp7vgvuLvdn99vskLs85GmtjyIYY5v+DEbwiQoWLjJYvNl/1jzJjJEgpnoTe02U+gLpEzyxaQB2qDINZKASpDfO9ITZk2tsP3Wpl0XL7u1cq5P0M7q1auqWRDUHjHPGWu8u5z7N4btUlJAnJtEusa+MI6deXkhkW9US0maGox6d7blG9F/M7xp4Skfmke69Ul077JwLLo7ScGnPxbhBqJqOowdtwZ0vcOTOhqkmmFW1a3hOW+fPDOgaOQIsDKqvxDQN1DGWybOZoGKg44rs+DEObxMX6BxVx5HqsJ6We5SEJz47/2L6YXaDfDm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBpUWNtZ1o1QUZJblA3SmM3S016NFpIZTVtZUhtQ2Q5bFhQK3FuR3pmWDJa?=
 =?utf-8?B?elovU2lJY1M3U1BDc0ZjMFhoQVJLTGdhVUNaRlhoaHJlZWFheUlvUDFyZ1Ix?=
 =?utf-8?B?bWt2R0Y3UGNMUjh0SjlqMG9FUS9XdEJDOG1ZY2lIQlkwNldNUVJIai9NaHBq?=
 =?utf-8?B?a0JHMmJYRUNQNHovcGFpR01FK1RYODZaSXNyRXRic0lycXVpU0UwazVabGwy?=
 =?utf-8?B?OXBrVWRtd21La1NGTUIzS3loRnBuTk5UMnN1T0hkOXJqY2J1TUVvaG9vaGJI?=
 =?utf-8?B?dm15TjRCQzFTd24yVEUwMXg2MWorUmtNdXpUWXpHQ1owVlVGNlQxbldtelM4?=
 =?utf-8?B?MmFWNXpKdkFMVWt1bWlFZkorVnhOczFaakdld3FjeVBJcVZEZUJWU2JmMHJ0?=
 =?utf-8?B?Z2xsektic21EalB2UWlLVmpIa1hFbFkxYjJxV1RwZE9pVDVWcDRncEd6YTdY?=
 =?utf-8?B?Ym5hb1NhZ2pIZVZ4QkU5R3FUYW5DbkFOdDdmR1g2bytFTCtaYnF4K0NMWjJ2?=
 =?utf-8?B?UytReUQvTHFRbHJ6TUtKZGptOVJPMXhaNDd6MG1ZNVZKSVlSeXgrQW1PZ2tK?=
 =?utf-8?B?NHBVM3BxQnVpQkRqL01QOXlGOGdxNXNMRnh1T0t4YXpqRkVxbFJyWDVrUHdz?=
 =?utf-8?B?TWtpV0FBZEhFUEJNMVFINDhUOVpUaG1oTGJTRmZkcklMc3dLVmdWMi9oOUcv?=
 =?utf-8?B?THFOYzJ0ekgycG9kWXIyZXFZRnBiN2NYY2Y3VkcrQmxTTHRYUUhCU1NRYWlD?=
 =?utf-8?B?N040a3BYODUrK0d3MUVxQ1BGREJiMlFWMUo2Q1RHNjl6UU16NlFwcWhha25U?=
 =?utf-8?B?WXZnamxINXgwUCtNWUNsWGxtKytMQTEvM1BqK1NvNkUrZjB4Ny9EZ0Y3cVVG?=
 =?utf-8?B?UmJPUTJHWDAwUFpBa1g5eENMc3pQOUQreU1QVmFEVk80a1lIY01vSTF6L05X?=
 =?utf-8?B?UytKa0Q2YnR4RmtuZTZDTnRoNWdJekhDQ1A1THRHak5JM0dRMGdlUC9Bbng5?=
 =?utf-8?B?dTlZWnNnSGdvU3YwWjg2dFErNGVWRVFqMmZTZlVnNjQ3Q0ZSSVZLN1lCWlV3?=
 =?utf-8?B?WTNFT1REMkJwVndocUFKdVEyd3dsSnF0b24vM2RYZ25YeDY3Y2l5TFJEVUFh?=
 =?utf-8?B?dzJIVEVGaHVucjRNWmZ0OENFa29hdkh5TWF3bDU1cDB3cDU3VWdoNWJiZDV0?=
 =?utf-8?B?VmVzbjEzQTEwdHY5WlNkVFlVcXk1ZVU1QXUrSnFXTFNnZ1kvRXFYcnRpcVln?=
 =?utf-8?B?VGxjN0VyMXI3cVZxdDNaOHcxQWplOEVOeThJNmk0VkErNTFpSlVWNndnNnUr?=
 =?utf-8?B?RmZrdExzZ3h3THo5Vi91SGR4UFRFcktoWUF3OGVvR1hoN1RxdXE4UmhIWXZp?=
 =?utf-8?B?UUM5VlNTRGlOY1VmVlJjS3dmSElnV0ZRWG9rbDFES01iZWRSOTV4aDQzejZW?=
 =?utf-8?B?dURwcENXN05YSTllb1lmamttV25SK092ODh2NXRiUy85YXYzclowWUh6N0pj?=
 =?utf-8?B?VlV0WDRTb28xa2FMVmY2MjdET1VtRm11ei9lSkY5TjdJdGdGNllOWUQwNFhz?=
 =?utf-8?B?RHFrWTdrN0FpY0gwSzdPNUtDdlJXMnIya2tMaGpQVzE3em5MZmNVdWUxdzkv?=
 =?utf-8?Q?gi3dAwc0D8lQJ79MSVCnuE+qnKCyozqNhLYVjO73peOQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e12402e-6dd9-432d-b69c-08dc13485618
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 08:27:38.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1503


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

Um, seems that we need to define two clock-controllers to output their 
own clocks respectively. Thank you for your patient guidance, let me 
re-cook the code.

Regards,

Chen

> Cheers,
> Conor.

