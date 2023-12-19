Return-Path: <linux-kernel+bounces-4875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 753B4818336
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A091F24C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB18511739;
	Tue, 19 Dec 2023 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xhOG91mJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC33125BA;
	Tue, 19 Dec 2023 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HumKtbiKIfFHrBPVNrFTgLhx7trezpEQ8NbEqgG2bzvJAmv7KflWSRO/FieMxgpUjkLNQzX7ufcfcynAyHhHk/gF2JQKiZ/c0PViacYXxmKbo9TZ0b83AwXBJnMSsAwETPNwIwlxFT3Zk8rjntjleQtsZG461RIxcBYOvt21RwjwMW0J7oZFK+AcNZibnDRdEsqqfv49fed+LDL/J2ZSJtKiPd2lgaBd+VW0KejGQnz2Wjaqon1a8cmgufWBuMrketPtKwROBY1F58MKDgBQK84kSIke12Tk8JCyM2c7CBhLfheo6JzU8uX+FCQXjVuahnArSmL6JAAqCuLCeBYhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2dogx6MfGUqmuhBsqSMEiFzJTjmdkAXc2v6CKmdJDc=;
 b=DtuWo7kAoqYiT1WT9yowwswU8BfAW2Vez57ZUgGAIvum8W2LNMDvwcNseysD4i4r+VZCzm1nMWL6ohJtSYBftlzO64qmAFoemcNXfbgX5RtJQB5FTcR1kHYxHpJqsV6XabRdETfb9LYrhFekfXeFNTOzjrfuDqy1jvmlsWYaLjdoW82rEwuXYh2Wcr6Jo5Zdm2eZbymPYflONxYAe/qsDws4qKftLYVIV/GLD/9EDNGZh3eBWwJdKy6SJNP05wGBtQesD1U5DjdNSikcmUbRqp79Ixl3Dvo5DspO4o+IX1e/9eyXmQPNVzm4vdl3U5FykY4M4c0mFrrJjvqHBS3AjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2dogx6MfGUqmuhBsqSMEiFzJTjmdkAXc2v6CKmdJDc=;
 b=xhOG91mJxmsFYt8xBI90aZmwQ8Q0OmunCJeI2sm+ImOKgYXwmGp0BGYN+kZtqx2zNhHiZkEYf2IhexYqUlDRpJycqK//mtDLjymQVFTVIovpPWcwSupzHl7iXXcRzqyJ6RoCf6gxqbDzcejSiCN7TJGWI4aeh1Pi3ejdYS73e+xrZn6vqXk2R9qtmh3WxZmix0kI58r6bcE/YO/T6jMHIl20gyphM8EB7bZ5tuD5SOjxzU7dTPaj0+gNlvq8yCoPQdmwXlUgS7uAeSJ2ziFg8CVCCky+DRhDDxkuWC/MnFlWq5aycJV6wmNXfDZsnmg/BxBW6cTmdaC+MXI+oSKj9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 08:18:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:18:22 +0000
Message-ID: <6e891e6f-a673-4eba-97ee-736e302094dd@siemens.com>
Date: Tue, 19 Dec 2023 09:18:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ti: iot2050: Factor out arduino connector
 bits
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <202d324ab0aa3728c8f846d31bedcbaba14aebdd.1702917360.git.jan.kiszka@siemens.com>
 <10f300d6-8a1a-4363-a16e-8337da8525d1@linaro.org>
 <f4b16dc6-1063-40d4-b68e-1eef9db32829@siemens.com>
 <e8cdfbb4-920e-4d3c-94ea-be24a7e21d57@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e8cdfbb4-920e-4d3c-94ea-be24a7e21d57@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: f281e8c1-5344-41fa-be3b-08dc006b10ac
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TdhcALyY4zvq7VnZc5sTvDOGx6XEYHNEqn1zIrwtHawgewqqkWVNiDVvuushSfc/MCFTC0kmz6GuABuGF/mKHyEY+cPTuMR4NzaHvVLP2Tx3k5oNSAaDvNfeJhc+LhI1Y3M+Cuf639UFcPJB6rWTWBQHmDGBLVsJUX17qsiAuIJjQWdJi12HiEyMePDGocJTF7XFo7L8YGvo4i/8VwcopQ0lfG4hayaQfPFCg49BqlSTJ1onJhoq8NND1ywTsEKGDKtAK+2EowQG20DbVfVg9dGsTdiO4KX11qHz9fJIVt7vlGfMNak2+0LxRJMI52K9pSJP97OnDEybzAOBz0y3DXMHGrRi4gm9h6gW64njlVaLfASoTabtV+Dfnzr0GTtiVmsE1RJ2jV/0agzHr52MhK5hhaWTq+zqbrA0LbHble6j8wPP1ZOmqExczSt6NgIK/3K30EjXiFW1WqNxOKIUUr+J0uanf4kfTNx9PzuTI9ZGM0BxOky5i20gT60vx2rDfN2F5eRLRd7VfAqcxlaoE2BmJSQFTsSFT/n4OEn1x7Mc1C7Kjeahwvawha/VvtzbDLPnTDd0MLe1cLvBrT33whFQaI1Z2sRXc2BUBMVEJznW3oIhmMpaO4P0dQAw+tpgyVatXc8PreB/oi9v4Pc3sw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(83380400001)(2616005)(107886003)(110136005)(66476007)(316002)(38100700002)(478600001)(6486002)(966005)(26005)(53546011)(44832011)(8936002)(4326008)(8676002)(6506007)(31686004)(6512007)(7416002)(5660300002)(2906002)(86362001)(82960400001)(36756003)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVhnLy9Ra3lJTmRPVi8xRUVXQW5QRHNxS2hTMkY2Z0FBYXRqTTkzdzhUeThi?=
 =?utf-8?B?UUVhU1ZRaHZKVW8vaXYzL2tMbWNKdzdUalNxSk1hT1pjQ2JIV1lBcHptcklr?=
 =?utf-8?B?OC9GUUVIeUEyam42Y3J6WlRuaWJ4cGx6MGh6aEtWUjBUTkJabTVTRGJsQVl1?=
 =?utf-8?B?eXVVTlFsQlZaMy9EaGJ0amxqUTBXOUVTdEg1cXZzazBQVFNMYWhnL24vUkZT?=
 =?utf-8?B?WWdQTWoyajBBcHU5MVpZUmJmT3YrUnVGTnhzWE5RZlV6UG5PYnNJS2hQdzNz?=
 =?utf-8?B?VXZKVWJySVlVTFBxVGYzTzZzL1JOQWw4bzNDalhrWWhyQ0xHSlZ2aEFjeHJq?=
 =?utf-8?B?M3l5NXIrTmRuZzBVaHhQSlFDOVhuZ1N5M0JKZ0xwL3RNRHMzK2lrL2hYNUhD?=
 =?utf-8?B?bVBlMnRkZlJaMUptaEVQZ1BZNEtFSHU3b1pQVWhMSGRjUHBTeUZ1NjFsemhK?=
 =?utf-8?B?cjFWVTVNQlA4SFFFTFVZNi9kb1NycUJrck9KL0JKVi9LazduQkt6Z2UvUzBj?=
 =?utf-8?B?ajBCUm5SWlgySjQ0SWgwY0FTUitmbHRLRjJKd1hHelAyamE2ejhRRFdyQW04?=
 =?utf-8?B?MGxTTzJJUThEd0tZS0tyTGpNVnJkQjZEK1diN1pxeUFBSW1DYkQrUGVqalhV?=
 =?utf-8?B?V0o2TGpUVXZmS2NHZENFdExCNEJGT0hjbk1neGd3ajFMaUh2emNqeFhjajB5?=
 =?utf-8?B?OHhGT05JRWZwNEtLMlRkMmN6b2haN3JmRDJ0YyszUmhlSHZFU3plZVVZRXVo?=
 =?utf-8?B?M0hqc09KWjNuVkJqUXhPWE5NbVRsYWdiRGpvZXM1d2xsSlMweG5MblpNcjBt?=
 =?utf-8?B?RVFVbjhnTUhYS1ArSHl2YnZpRGVnU1dnUTFZVU9keUE0emFmYzh2bHpLUHBU?=
 =?utf-8?B?SDVOQWxBc0FqRDlybjFHbDN4S0tHTHRBUitNRXQ1SGFoUFhGVTFyTXhWdHl0?=
 =?utf-8?B?MDhybkVySjNNZ1RUZC9KSi9RRGEzUVJTVGZIeTU2OTZaajdyeTJFckF2U2lj?=
 =?utf-8?B?RzhKSXBqcXhyS1RJRVMvZGF0L2JJa3U0aUVqZjl3R1dlV0g4RUgya2hLU1ZG?=
 =?utf-8?B?dDNIcFFKYTBQbzJVbnBSQXdYbVA1T3JMbzhOTlZjTk02MmFYUFR3TDI1L0FZ?=
 =?utf-8?B?dE84MzZvQm53czhLdnRyZ1lZSDRRMDRZVFdWelpMMTJ3RWFiRDMrYjRHc2gy?=
 =?utf-8?B?VE0zNDFBeXJCS3BGdnNQWVU0RXNYODlja1hMYkYzOXllakltK3k3ZUV1VUdi?=
 =?utf-8?B?Z1F2blFvQnJsZlVueVNjR1IzQnlHZ1ZmT3BoaTdTZFlJZ25TMEJobHcxRWRz?=
 =?utf-8?B?aWpJZmkzS1lRMEtpV0x5bjNURGVxSWs4WVRpb3hESVpCUUtuTU56QWJqS0tn?=
 =?utf-8?B?c0ZWbG5rMkNia1VpdUhXM3RBTnpPMDNjOUc3NW5HU2F0dWFvaU01cFBtcEVk?=
 =?utf-8?B?SjcrRVJ6Q25TNDFhS0wyd3dvWU9PTUxMaW1WRWJCRlJtNkloVm01ZGp3QTFt?=
 =?utf-8?B?cFNSN2FEVUNzMTZtRk5mY1ZGQ2JacHQ1SnZlNUtjckhBWDRQK0JHR0ZsSDU5?=
 =?utf-8?B?U1paaExrd3FUL0JLY1R6ajFIZGhuak40dWNlaVRuc1EvT2JOTUlhU1dVMWN4?=
 =?utf-8?B?WDVwNXNobldmSm9ZTVFzSm05SGJvWWJyTkpNbExpaHd0ZjRsNkRhbjFHMmxX?=
 =?utf-8?B?R1FuU2RsT0Vuc3M4UHRNdEltdWRGZ1pHb283bXBHOFl3RmhxTTdHd2ducnBB?=
 =?utf-8?B?aHdKQWgzcmkyVzREZHJ0RXNZWWxXNUNQVndCRkFPcFAxU3NoRk9yRFFFY012?=
 =?utf-8?B?MkJjL2JPdGJvQ01ON3JVRkZLbThmT0R4NkV3T3NobStCMlZGMlI4RWt0eUJH?=
 =?utf-8?B?TVhSSGZsTlQ4RFBXbTZNRGJFcVJldWNyT0JzYXcvMjRiaVdWWGxMd0dzTVp4?=
 =?utf-8?B?dnRMUnZRTW53azFIYzc4Zm4rSjB1dTRUUjU4VDdBcW9sUVlKTXpES0xmMkZB?=
 =?utf-8?B?ajFFN2VmT2FQWHJZbkVrUVYxZmJRRldqb1NCVXEyL1dhQ1Z1ckZ0OXI5b1VC?=
 =?utf-8?B?bGhDZTYyOTNpT20yMDBidG84NmJ6V013MnAyRXg0Zkg2b2tTVGhyZG8xdHVV?=
 =?utf-8?Q?7NIzzRr/nvTjHtzEgJFAGRNC0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f281e8c1-5344-41fa-be3b-08dc006b10ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:18:22.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35pkqoIlAawHQ/zud9G6VWMXO9s4YKGuEt2XMllgBGj8bQiLbZ8P7c9y2JOWboyGxnGTw798ZRuTjaWWcXi2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5144

On 19.12.23 09:12, Krzysztof Kozlowski wrote:
> On 19/12/2023 09:06, Jan Kiszka wrote:
>> On 19.12.23 08:51, Krzysztof Kozlowski wrote:
>>> On 18/12/2023 17:35, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> A new variant is to be added which will not have a arduino connector
>>>> like the existing ones. Factor out all bits that are specific to this
>>>> connector.
>>>>
>>>> The split is not perfect because wkup_gpio0 is defined based on what is
>>>> common to all variants having the connector, thus containing also
>>>> connector-unrelated information. But this is still cleaner than
>>>> replicating this node into all 4 variants.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
>>>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
>>>
>>> Please use proper -B/-M/-C arguments so code movements will be detected.
>>>
>>
>> Those are in place but have no impact, likely because the source file is
> 
> In place as what?
> 
>> still ~700 lines after the shuffling.
> 
> The original file has 720 lines, so if you move 750 (!) of them, I can

The original file has 1446 lines - I should have noted that this goes on 
top of [1] which is already pending for 6.8 in Nishanth's tree, sorry.

Jan

[1] https://lore.kernel.org/lkml/cover.1699087938.git.jan.kiszka@siemens.com/

> hardly believe the rename cannot be detected. You are basically moving
> 90% or 95% of file, so this must be represented with proper diff.
> 
> Your patches do not apply on next, neither on master, so it is tricky to
> check.
> 
> How do you expect us to review it? Compare line by line?
> 
> Best regards,
> Krzysztof
> 

-- 
Siemens AG, Technology
Linux Expert Center


