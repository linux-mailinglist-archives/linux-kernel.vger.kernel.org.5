Return-Path: <linux-kernel+bounces-4861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67410818307
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6B31C23813
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9C125BD;
	Tue, 19 Dec 2023 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VEmFlOPm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83E125DD;
	Tue, 19 Dec 2023 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPgti7lcT1uCVzLY56IFQ1JbnStdaUPQlGgePXNxmz1CbQ3Ywucz+t7zkjAw3z7JC+YXp/27l04xY/wKSJNq0ONRyXMmex+cjWB/ukxxnBpjfiWT1ZeaxSd9ygPwnty0EpnxDrmtR1HTkz6MFVbSxxEGsTrO1pniIwWc7zgtRGPgaqjRC6lw+6a9c5XzMWQsbik4Dmw7CxZr40CIQSiB/8xQ5mrqJa4wR9MhpEx4P9sF6+LECmQtOTPxroEbDOI9lTmf/3Ti5wXuH83IfdQoztdF9wm1ZNMwbyUUfxTJsr0Yvhz0p02D39TeqTkeXtCxnZ+aV2cT9rATpOKMi5sypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8sofBc7Q0Npb1ViBMUD7NsuNFJLoHgb9shcnuNOqoo=;
 b=PVBsw21+5zpGB2aBAc06D58eD7RSeWOEKByVWJP7UKbbqQGDroJFQSDqGttCxN+c9Yd/ZFzRbY9zEAzzOjkimMIAX88Hx2rJJKmqG8SgwvfORug7f6GO2mc0baDXIdEEdUWykAM6gy/h6FOPQVwyu0DpZrgG0HoKXV1oJcXYYuZW1S1uxhPoK65+HeSozKp8ofsecP9uQvmcRp+l+jrXN57mU8lSWgAuv5eIi4BcFccFgwP3QuPzmb7TUA+lnuC7SEacgg8eWV9TrsyZvAHncjsO9uxfGkHOZ3AXloZ3JQq2GkLWJqYEghzEV6LiJCbzMAMDjGvppfOTfqzywJN52w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8sofBc7Q0Npb1ViBMUD7NsuNFJLoHgb9shcnuNOqoo=;
 b=VEmFlOPm0Mwtkf1XY+CNRC09yIm71gSyQTT133V9IIU3Mw3l0ZRFaTp2KHqHy1ozVYj46Yi5EPQl5D1M+MysGpTuZVtN8zh8YHbjHh4hhRaVT/gYzVl6IiNddFwOca0l2exnOuuUEARVPI6k5xmkFRMSxTs1S/Tcy9qWuhDPQdaeuB92MyfS3WeIA0bS/obnF5ZAqMHQXp5sn7pIe7Y1fE9hrgjQcobVPLrEiIS8vsDapSCORGFy4Z3WWHLjFFjK2W97oniCE18rQob4UNYqMVXcNvo3DCSEiXePgppfrMQxNAGmeNGXb/omhdqUEizx0Mw0x5SPaiHitAX++usD7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 08:06:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 08:06:36 +0000
Message-ID: <f4b16dc6-1063-40d4-b68e-1eef9db32829@siemens.com>
Date: Tue, 19 Dec 2023 09:06:32 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <10f300d6-8a1a-4363-a16e-8337da8525d1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b81630-2b72-4f17-e408-08dc00696bd5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IuZNvto3HfEVORGLRV7FIl5esqJGs237T3RkQ2CdodLHVbFVGhSCI9AZgiiLzUTdX7Tz0vGffY4Z1+/xAIBHIYR++EwLIH/dyNHpn7spLW1Hu1ekIQWjEQW49SRq6MwANE7GpiFGXYPg1Z6bBKg9GrGlXpPyt1zOX1uPIXr1RsU/+EdCaBiQMbV7tFfjNHdWyCNutZsfNmO4neRz6VShMYJyMVREBq7FiPpVb/fiKxFTlkBDZs26VCQWyNYEtrPeVrIHC9guEQzzmkMa0NCUdhz4vnyWFpe5wIiwQdRn2PWf5SLgQeTY8F/7FGFo8LHNzsA0pNZow4kIgxxFl3ZCYcWRCFXoJKPJl2rj6ITGmd8n3506uefTYb37E63iL7hZsSQ9AV6QDpFGaSpFu2AnaweBI/hy3GrLS2bbcT8qlHOYPqBnSjn0FtGmfTgIMguYrYjKZzYHCbxbtfrs9gHO5VpKRMKCZ5QLPugVA735U9yt8u0NWCn0zRsxlmZvk+KY2/OCtWplx+QbDoQ3WDEnMod9beC+FKySwrdYGhqfghSEc64QZA0xvWzTTJx7qC0+bJCLAjfVhMGtG02/ERt8WQ+TOQM/PFhu62reWxUgk+KZ1u2nQy1oluhK+RW5zkO2JnCLXpn/8ONu9oVOlwYSLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(2616005)(107886003)(6666004)(53546011)(6512007)(44832011)(5660300002)(8936002)(6486002)(41300700001)(7416002)(8676002)(6506007)(478600001)(2906002)(83380400001)(316002)(110136005)(4326008)(66556008)(66946007)(66476007)(31696002)(86362001)(82960400001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmlnZVNxeWNJcWhMSHh0SWQ3RTc0WEV2djQ1S3M5VDkzQ0pXM3BlS1RvYlVY?=
 =?utf-8?B?TGorZElRNytSaFRnNk9aQ2ZuZEsxZ0cyNUswZlNTSEJOSnFpeityeVFqS2Fp?=
 =?utf-8?B?ZmhhYjFMajJURFdqQ2d1WXcreXVhK2JZc2g5QnZ6Nk16SHlFRlBjNWdXZW1P?=
 =?utf-8?B?SnEvUUNEZGdWS3BZbGhqandKNVRsK0NwQ3ZVa0M4QlVkVmpPWWg2QWJGUXVQ?=
 =?utf-8?B?OEJjVkpqMnp4bllKcWhnMTVqMlUzQTF0dVpNWUQ4c1RFTm1pZ0xGSmNkdDdS?=
 =?utf-8?B?TUNtNlJDUlBaVElrMGM4QzE4U2s3blZqMTZVcG52NzFFSnFQY3NMeTg2Q21E?=
 =?utf-8?B?OXJ3Zi83MjJEVEhFUVJ1TnI5SzJ3NUwrSlhrcHI5alBYdHVteW44akpMbW56?=
 =?utf-8?B?ajFrQjYyYWZ3RlhNWXVLQWxhQy85V0NWaDR3QVpHeDE1ZThScTliQ2IrUmNB?=
 =?utf-8?B?WnJkWHRvMTE5WmdVWjF5RzduWXYzSEttREdZRHpOZTdQSkVIVnNMb0N4NStR?=
 =?utf-8?B?L0tGekJQZ1JWZ0s3cmNzY28zSWJGSTJ3SldVTTJSVnN0TXF0WElOeXFpWTk2?=
 =?utf-8?B?UVdubk1qR1NHbmxwOENqekYwbVJ2dkQwdGs0cm5VZ1lJSzlkSVFsWFJkd0Uv?=
 =?utf-8?B?MVdKOGhsWWY5YWpBV2hSbE5UaXYveXE2SmxNaDJmQUZXa2VuYmtnWUQ5V2FW?=
 =?utf-8?B?MkVCcXFkaHZjTExxdHBHTDZWSEdrb0w2OVpYUTNialdmQlB5TWpWV2pJK0NO?=
 =?utf-8?B?YVR6OTc4ZUlxRDJLd2sxTHBvSWk4aFVnL29wOFpHVFhxeWtYTURYS2NHUDVS?=
 =?utf-8?B?TjhXUUU0TGhwZWpqenBJb0syQ1FSdVdFZ0xqR2FKcjViVVdSLzhwbXVMRHZ3?=
 =?utf-8?B?dkpZcUpGVFJYWW0vTW1qTXp3dVVoVVFENmRwbFgwSUM5Kzc1Tk9VTGM0MStm?=
 =?utf-8?B?blhaWVlyZW5RRmNFM1BYRHRlWUhlbGwwZWs0MCthK3k2c3pBdnpXMCtSTlo0?=
 =?utf-8?B?N3dvNXJxeTY3N2NRMm9GSXBKUldTM1E3dHpHL243T1hvUWxoQ0RyQ0xhNVVK?=
 =?utf-8?B?Sjh1aVdIc3cwakdJYmNoSWdxdkU5YmJMUndLdTRBd0diLzRIRVdmR25PNVY5?=
 =?utf-8?B?b21TYThJcE5ZbnNEUG5Qa1grS3o2cTNNaWdGdDJsZXJYVGE0TFFnWjVaelY0?=
 =?utf-8?B?T0Z5bjROc0tBYi9YV0srNlVpQXErVEVQcVEwWkI1dk9GTG9hVGpiRUo1NThl?=
 =?utf-8?B?RFFJR3NVbmZvS0QxdDhZeHdFbnhVRGJYUUFWQmpuYmtXRE5Jcy9FTzhtZFdO?=
 =?utf-8?B?N3Yya3pScWx3ZEtncWVXa3dEV2V6eGlxV1hPc0tqbmFjTmJCd0tQK21PYUI1?=
 =?utf-8?B?bU5RNnVoOGhONXNkYkErV3M0bUo5TnBGNUZsVWNkcDlrNTJhU3FObnBBTGZV?=
 =?utf-8?B?QlE4ZnNtR09adE54MEZhak1ERDFYdSt6bjRyR251MCtSc0hQZzQzVVNpVmMx?=
 =?utf-8?B?VS8xR1VBamVkcXRUcXRUZk1jeHo0bHJyTHR4Z3JWRWtJY2c5dDlxakVkOUI5?=
 =?utf-8?B?ZmFuNVJ4V2U4RGJDT21RR0R6SE0yRTlyRHpQQjNIQ1ZmVUkyQzdaRjJUQXpn?=
 =?utf-8?B?eEJrRE9JM2QyVVF2N0NpWVRWRmJsYmhzb1VielI2ZlJJRjk1WXJDUjRjanR4?=
 =?utf-8?B?NXZ0Z3JyeU0ydG91THFaWDhZK1FWbFdqdmtMUjFnZFE2VXRMVmxjeUpuZW5Q?=
 =?utf-8?B?ekt0bWh4QXlsdFMrMzZmdFpxV283cUNXdHJkUzEzdXI5UU5sNHFWa1NDUytR?=
 =?utf-8?B?TkxmYlk3Qmo2WlJnMGxiYXVmdysxN3QvZ2tXWUYxSjFXbmFPUzNBVFpSYUNB?=
 =?utf-8?B?ZWdmRUJUT1hoRWsxL1hKOFVQVTU5M1VlS0QrTThMTTVWM05Ga2tWYUthTzZO?=
 =?utf-8?B?ODdIUHhZOC94eEhMUkpDTGF2K1k3NXBHOFFvV2NHRGJPUlV2UWNqRXExQWF5?=
 =?utf-8?B?RW9NRGdPQlMyV3VIK3JyQVYycTBPQjkyY2JNYitFU29lOCt2SlpnbmhscW5H?=
 =?utf-8?B?aVF1TGF3cERjc2krS2xRYjIvZUJkaDc4bTBtRHhURGNoUU13YkV1SnpuYWtB?=
 =?utf-8?Q?u74nfvqGKoQcRCSbBMRD+zufo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b81630-2b72-4f17-e408-08dc00696bd5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 08:06:36.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pauaW3FeQLTP4QEW+X7rP/OPnbnXbI/9rJOFwfVVbfJclx1CdWiQT4e8ruuhLW2teCkiXT5D2g1bb6kFLBt15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6625

On 19.12.23 08:51, Krzysztof Kozlowski wrote:
> On 18/12/2023 17:35, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> A new variant is to be added which will not have a arduino connector
>> like the existing ones. Factor out all bits that are specific to this
>> connector.
>>
>> The split is not perfect because wkup_gpio0 is defined based on what is
>> common to all variants having the connector, thus containing also
>> connector-unrelated information. But this is still cleaner than
>> replicating this node into all 4 variants.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
> 
> Please use proper -B/-M/-C arguments so code movements will be detected.
> 

Those are in place but have no impact, likely because the source file is
still ~700 lines after the shuffling.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


