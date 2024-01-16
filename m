Return-Path: <linux-kernel+bounces-27358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24B82EEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B18B22D02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B11B96D;
	Tue, 16 Jan 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqvvj/84"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFB18EB4;
	Tue, 16 Jan 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLVA/0T6RyC+ybS5QZbm1VzODi/tvJIdbPxusTcTBH28U+x78t21O6JnSnBAxUoQN6AAMwTXjtu7gdLmO+rRHu8hVmSE7THwII/olZKTfMhcIk0290Ry8GErUqtQaqiCn+jec3W1k6W6X2W5sT9/OKSIkqWsmJpZ/R1RxqCuR7UvKVdOmYsebYxDFFcrIjC3GETmIAV2/asqM454KvVdQaqbI+SzN9tJ6ROnFsmS80M+RrBIv//Cw+3r3tMNTBVehyig35zUASpvIY40dF4NI+tdAPOjOwTvcHpG0p7g8fVOa7hnhXp0h+tWWjisktl6EGdWVbKnDfKHeeL9k/vwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bztLICWznR7oGlrybIFHMKwaLphzO4NLHzPKy1O+G7c=;
 b=ZFmk/KRP+v8noRZpMG1j+oIrmzdJazivzzI0ubvYD/uSmeMoYQKsljKG5WFZovbdeW/YX39HO+izT0Lya6E+UodF35g2NhEETw1rbTYwJ8TqIkXPN5riWFSJviXNmd91l0Zo7ROJC5e59HB1wvSi0t6JipRqYlxdpOtTI262tWJ3uv/kc/ufHYB6CX1MFcQvw5i1u1bKyiIfLzEC/UOhZwy/lS0Ov+xOGgmj63e+gxSzgqzLgibzpMy6znZT5ib0bsGUq4vBwYFfw64SHSt/2PMT7egHStX5FEOs3vNCbLL6V9mlA/7TgMWMKmOldW98MPal3XM0fIwXAkGRH8yM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bztLICWznR7oGlrybIFHMKwaLphzO4NLHzPKy1O+G7c=;
 b=iqvvj/84po3Q3shMLbySnJQT2dZSd/PViV9MYi7TJEzopSK6AFMzzGXdPATUUULPRm8HBbYbFcZ5R8Z2ecOGlQinfjMpzCz6cbTEhB23rh4Z+c224LNeWuSr5R9I22JdIpUu1NWV90Sv7JJVnyrk3KjC8nS4wpLYAOCk0pqvdC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Tue, 16 Jan 2024 12:04:37 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 12:04:37 +0000
Message-ID: <8b41cc35-65bc-436a-ba7a-c09f02496326@amd.com>
Date: Tue, 16 Jan 2024 13:04:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: firmware: versal: add versal-net
 compatible string
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sebastian.reichel@collabora.com, shubhrajyoti.datta@amd.com,
 naman.trivedimanojbhai@amd.com, jay.buddhabhatti@xilinx.com,
 nava.kishore.manne@amd.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <1705406326-2947516-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1705406326-2947516-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:803:1::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 269cc5b1-0bd4-4d68-54c3-08dc168b4f57
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zh/8eh5u4fH9Q24tMWb2BpzM0iazL4PPlcPwcejHztdjAG1TGXFKhViHp36J8lM1FvHb/2lWm6Om7202VWDiB6MIYhzVu8DFZJgW5tN5PV8mj0AKiiWlZJiCQdG7meaaHGMHCXm3rBaCiRlLo9QsMCED9hZybjwVV/jHFLUckWd8XVKwOCANq17WlFtFanYTIQzHwIVyo8TFHlYzsI+4uX/bXc32cCTYQYdjyDBKnfvcFL2xKVK0FE5bsCpBSDH/4CH2CeDVi4o3NC3wQvezAqr/06GGC3zjLthQXnS7NHivfTvw6ePjqUp0vZGpJnmIEEa8pqw4w1Y2sViS1ZEi0NiEtWSU2YFypXldYlIIp+jLD5373Zb4vvM7GD4oMKenVBf3aEwf1Y7yHCFB2h2cnjLtScFk6nqKl1nuvZ3dzO5UfuUs/fc05kg7sy0lFlj+wZBTv22NKPBuCBqMs5WdIw6q4+2h/fTed4ituPEzQ2/Feq7ZL+/mkDTPY4p4NH4OqAjawBPExOpyUvRUT81JRdThTPGlYbQb5TQxg3liF20rUkjPcHox6sY3meWVumVJgLagE77BhGcv23RHQmzh1nnQO/8a6zhzabtfzWteDBpGKOrNpt51ayDReSsJe1KVIw33gsYyvxPpBbpjAEpeeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(2906002)(5660300002)(36756003)(31696002)(86362001)(41300700001)(6512007)(6636002)(316002)(2616005)(66476007)(66946007)(66556008)(478600001)(6486002)(6666004)(53546011)(6506007)(83380400001)(44832011)(26005)(4326008)(8676002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0lUV0ZVTXRQSzA4NnRxOE52b0pDNHhrdFZBa29rRmdJellSQkpxODNxSlJT?=
 =?utf-8?B?ME05S3ovQ3VHWVA3QmFocElCeGpMNUU4akFBTVZBb3cyVmxlYnE1MlpBOE5X?=
 =?utf-8?B?WGlNRGRsVmtVSHh4U2w4Q2szNk8xdHVrbnNFcndpeEZ4cGFQQk56L3E1VWla?=
 =?utf-8?B?WVVrSWpKL1pFOGdzRWtPZFFUb0MrUlAzU3VxSFhxQWNLaXpFSHBBdFo3OWtU?=
 =?utf-8?B?RFc2VzhrZkt5OWRER3IzaTFIcVhDVmkzdzBkTFphQmtYRXR1eXdKYVVVRjJx?=
 =?utf-8?B?N3pvNUZ5dUpPM2I3S0F2OEppZGlQZGl3dDAxbWVuTkFVYlNpSmxhSTNwK0dr?=
 =?utf-8?B?bDRCUkN3djRmd1k5RWNhemhEZnA2Z3dIbGM3WlFEMWRPV3dDZmFpN1BuTGFN?=
 =?utf-8?B?Wmlva2h4eVpjMW4xNFFoWmpnSE1uYmNaYW9VOUthdHpLQUhsWFlIbE1QdXVl?=
 =?utf-8?B?VDdaR0orRmxCR0FVZ2FSRVRKdmdkWE9PLzNvTU4zTHkyWVI4UUpuWVJtT2tW?=
 =?utf-8?B?elY0RjYyRlZ3eVZDM1FFYWE2L3YycVdCbmkxZ3g4VWVxN3pwY0V4Qjg3d2Va?=
 =?utf-8?B?M1ArWDhGYUtzaU5ZTlRDNlB6Vk1DT0dYL3hZeStDMlJpRDBGdk84cFozRmhG?=
 =?utf-8?B?a2NFWHhjWnpEQzVsWmZWTGxJTStheGVzL0kzalk4cFdPdnlYTmpxVlYxTzVL?=
 =?utf-8?B?c2RkZTM2QjRPWWdJUmZ6QkNwbWhvSTQwTEh5bTJnS1NtSW50UHVnc1RlMGhR?=
 =?utf-8?B?UFRaeHp1elJZS2RZeG1FWUhEVlZnVitNMmwvRS9HSWF6SkFIMEhheEUyNC9s?=
 =?utf-8?B?VTJCVkNHZGU3RDNCYmJqZkV2TWs5Qm1rVkFoMmhKWEoxRHZNQVNxWWo0Q0lo?=
 =?utf-8?B?MTNPWVF5OGF5NW4xNXNxMUdLWWpDenNiRDFxeGM2Y3BLTjlIWnVUODljK1Vm?=
 =?utf-8?B?YXJxTGZVdW1TTU5PcERJc2p1cUUwVFZyNitNU25QUkJsang0dXA2bCs1c2tp?=
 =?utf-8?B?bFJjQmU2Nmc4QjBoR1BUM2JQQXdkbk1KeWVZclZwd3ZBQ2lzVWx6WWdzV2pJ?=
 =?utf-8?B?d0c0R3YzK0UvN3FXTjRSWDNmeG1WbldxalJ6Q1JXMDEvUlFtdHJnZTZDT0VN?=
 =?utf-8?B?d1l6QXlFVmtZMG5vOWZidlE1SStjdWZqaWlEYkppU2VVYWJnaDg3WVJ0Tjls?=
 =?utf-8?B?L1NLdGNLa0hxWTFBR2h2U1F2cmN1VnB2bEFFMzRKMlM0eExWanNqOTNlT042?=
 =?utf-8?B?THpHL2ZKdTZyamdsdi9OalZNd005eVVRMWlJRXgxQUdnVGlrVEhad0dLUk51?=
 =?utf-8?B?d0FsbC8wYTVFOFNzZ2pIZXEzcDZVd1pvSm1UeVF3LzA5V2V5dEljbEUrS08r?=
 =?utf-8?B?WXNtZk9ibVZoWGhoWW5zS0Z1MjV6MXkyNmZJTzZqMTVwVmxUcVQwNGxuaG82?=
 =?utf-8?B?UWg0Q2RoZVh2RGtyOTA0K0VvQ1ZUQWw1eXVaMS95UDJoTlh6eStkSTMyMHRB?=
 =?utf-8?B?MFJOeHBZYnJZc1prRjlIYXFYTWE0YUNYY251SCtQNEVsZE94dS9aR3FkbWVN?=
 =?utf-8?B?RElQWW9TeHZPVGpsRFVicHFvblFZVWl6eVNqTWtrWGdWdE1VYUxRUTBuY3Jo?=
 =?utf-8?B?YnRpcDRPR2svRUpLTVpBWkZsOC9EamxSb2ZJbG9DZVBXZ0IxcElrclFVdS9a?=
 =?utf-8?B?NHR2c2pvZFVXR3N0bXhOcVI4elk5dDBVRUk5VFVZRzIyZTgwOHhVZmdoVzMy?=
 =?utf-8?B?NCtTWHNzb1dhYnFyajRWT1FPYnFQeWJMQVBmWWRseXVyajhGa0NtOXhPbnFX?=
 =?utf-8?B?V01LWUVXNUx4RHFTUHREVmdINXUxVGt0NmpqZmZ3ZGM0eDdTWWRRRUVJZ3Rv?=
 =?utf-8?B?Rng2V0ZoclpjbzJmQ2FZTUhGNGxDWVh4NUVSYk1naEpMVE1qcENlWEN3R0ox?=
 =?utf-8?B?TmFBUUoyVTdBMFROQkQ5VUZwb2o1K1lESGtTbExxUkdOYXI4RXVXVmtLU2FV?=
 =?utf-8?B?MUwwTGZsZ2RoZmNjWERmaVRPV3MrNUt6cVMrYUZBaEErYWNuSzhpVW1jcVNI?=
 =?utf-8?B?NDIrNE1peXc5ZnJCanNwMnVCODI3Uy8xTjgwaWtMd1F6aERkYWI3eUNMTkEz?=
 =?utf-8?Q?2ljBw3J2rV7v25dOPEXI1AZMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269cc5b1-0bd4-4d68-54c3-08dc168b4f57
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 12:04:36.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SepU54jqzMV46Cu/T2p4S5fJjX0Yj9/i8RMyWF6DL8kOHdQlhAY0sDVaQ4UkZdNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204



On 1/16/24 12:58, Radhey Shyam Pandey wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
> 
> Add dt-binding documentation for Versal NET platforms.
> Versal Net is a new AMD/Xilinx SoC.
> 
> The SoC and its architecture is based on the Versal ACAP device.
> The Versal Net device includes more security features in the
> platform management controller (PMC) and increases the number of
> CPUs in the application processing unit (APU) and the real-time
> processing unit (RPU).
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes for v2:
> - Add Krzysztof acked-by tag.
> ---
>   .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml      | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index 8e584857ddd4..cd9fbbb62552 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -26,6 +26,12 @@ properties:
>         - description: For implementations complying for Versal.
>           const: xlnx,versal-firmware
>   
> +      - description: For implementations complying for Versal NET.
> +        items:
> +          - enum:
> +              - xlnx,versal-net-firmware
> +          - const: xlnx,versal-firmware
> +
>     method:
>       description: |
>                    The method of calling the PM-API firmware layer.

I will start to collect all of these xilinx specific patches when rc1 is tagged.

Thanks for reminder,
Michal

