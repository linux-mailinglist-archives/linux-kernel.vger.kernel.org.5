Return-Path: <linux-kernel+bounces-19173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAFC82691C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA89B21263
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F749463;
	Mon,  8 Jan 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="doPE/VF5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF99465;
	Mon,  8 Jan 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMNntXYRR7alZtJECr6OMCRfTWj4AGhwxSWnTOf6DVRCfNrc9uQHdxzM3qmMTFAftIyEkDPR1Z40geRnb4EN/cennwjbqgTWKkLbO0NPg9aRqGdHdPKVNACqxQZ1j6SAeZPFnUsFPGGAqMvPNPTtJU0pTtpEwK5hAL1zfx3y/F/n+aIUXzZyQlmgcdQKYyT+0DmuXgaBiWGx29SI7a+LpPj6N8EvM+Tt40G8IG+AwrmoHsbnGKJ79mfLUiZGdUM6M5heNm7nxAv+px9Dr/AmAveVcHWU0OeqbxuDfLq239mNK5/7Aw203du/8vZ0ijj6rz3HLHTWVyX4xCzTC0S1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F50Zi4KIiZ8XhXjXThyV4dJ+8MpF9gV8d/qE9NKrQs=;
 b=oIRLXgGE45md/2h4HHavI5NyTPalaPDwOzIqu/I5ExRkykDRd0kWrBcbfHv6m47NfNQxruhkO9PtVQ/nHykJaYYBnsF2BS3XgzSJ8OVTa90EZ9/ICBQp1SFCNDlVbq1eZWeBriRgSvzQAhPoZfFR8JpoBtjXQDZMkfaabhSd9w6PHFwO76hAjseBxs2dYcyNuIlHqhwGL10rAPTWistR95usFZShqYsvmaJewY2VtzO1muJS/gzCw9lx/LOWq334qokUD2PUp5TDuR9TcqwC+x1ypLF5QujRL5tmurPoKk5Q+n8fUbVUCEZMG2k1WTbYBz0sZr3C7hbgVG/z+ETBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F50Zi4KIiZ8XhXjXThyV4dJ+8MpF9gV8d/qE9NKrQs=;
 b=doPE/VF5O8TLnWtqGiKRyjeXsU1vHa+DiJyzhaxtRD/CV9ukmx2U5rcOHwMVUp/kgE2rizj9KgKOHbB999FJu52eEE1sesBL8kaOvaDixc9SCCjr+6Fz4XUO/o+yOzkeJ9O70c4KakXDq8rw2jV4xS4VwIVS636JbpTHxKAVyFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:12:46 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:12:46 +0000
Message-ID: <485d0685-646c-44b8-823a-49870e109103@amd.com>
Date: Mon, 8 Jan 2024 09:12:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: fpga: altera: Convert bridge bindings to
 yaml
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <3100bbc4723643ec1ec7d4548e9ab353c856b564.1704470663.git.michal.simek@amd.com>
 <e738a64f742982bba6c7a8ea3cbc660f81316d2b.1704470663.git.michal.simek@amd.com>
 <ZZuoTG2wdXQvLlAa@yilunxu-OptiPlex-7050>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ZZuoTG2wdXQvLlAa@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0139.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::23) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e3d7f8-d144-4de2-2d17-08dc102198b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	14HMK5cPWE8399kmQEfIOq75qVQy6mffR0tKzr8O+8sy6hRzSu2TbQoFlME+twfWyVgJWSK1nFKROABu/jN7wqXNLIMyl3nz1TfkIZHr+FE2o76rBTXcF583hXgRCsUTE6MCh4TgkxWkt4FlZjC31KakyuLY+WEvkKziyXPOzLe5Q1oE8u806hvRBtl9NlkcBRMyWKzGNajiISDdmpaSO4IZfAfDSpOzrXnuwa0fQ1Ct5IJQKdku1wF006kaZmShxmQB6DoShZiDMO0eyyRPaX3vbJ6vIEtwr88/Y0aundnwWjciwXgW87FzUjFuE+4mOcTWyRBeoh3xH6ptLOCsRe2Iqge3hecoQPPdpYr5bziaxdKFpSldRDGHrhuKGHEVpPEkReKLeIcUO13g2zOsF+bmgHWy+OpSk+Y02EGaAu+Wo/uYYL9oQCyHEoMY6T2tBdpTr9H2aQEbt2moaDoA+JshKzbH70vivBHmkKp5CLGsNhx4AOF6hDX4fOXrUJNMUzbN+E9ecF3pTIqNyQ246asgkrayBudWtBDw/L5HNonoKeDVwwbpnGKpfGZeZRJahdmwlNWjdIWrX/VktjATXPGqvquGvm5zUhK2R+CsvpEnTJdi39UPBBk9AgsjQL/5tKhdfcRR3jMJ0v/F8UUgZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(2616005)(26005)(6486002)(53546011)(6506007)(966005)(6512007)(6666004)(478600001)(38100700002)(36756003)(86362001)(31696002)(31686004)(83380400001)(2906002)(7416002)(5660300002)(8936002)(8676002)(66556008)(66476007)(66946007)(316002)(54906003)(6916009)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGluelc3QzlRcEZCZjJxRjlJaTQrbEVFc3RhNUU2R3lvKzV6Vk1LMkR1S3Zn?=
 =?utf-8?B?Uk9wT2Z4S2QxUm9BQlNOWHJwejlJd1IrTWVQUVE3M1NWc0diYU5RakE4dXhM?=
 =?utf-8?B?Yi9lSzhtaXVnY0orYTVHNThmVkJxTkNMUUdzczlnd2c3Q3poVDZyNmtxRnBV?=
 =?utf-8?B?dDdIRlhtNEJlSWdoYmxUK1RKcHB6NnVaYVNEREZZdkZNZEdTWEZTT1YyeTZ6?=
 =?utf-8?B?RTJOREFzRHd2ZHFWNDdJOXluY3hDTU9qS3pxWXdiVWVWRmVGSTUycStBbjls?=
 =?utf-8?B?c1BkWENtbzQzbzJzRFlYMXpGbm1VTkc0Qm9EcmpnVkNqT3k0amZQQkNRSCtD?=
 =?utf-8?B?THpOR2pPVDZiZFpCZldmUFJ3Um83RWpRQXB4eXh3aHIzY0RpczFhcWg0azJI?=
 =?utf-8?B?dW50M3lPSE1Nam42WnFlZDZqRDhkQk1GWUhLY0VWNkMxSE10dU5UcnBnT0cx?=
 =?utf-8?B?eGQ1VDE4VUhBSnRTNTFHTjhDYWYwV3V3TGd1b0FndWN1VmZYV0ZjN2oxZ01V?=
 =?utf-8?B?c0JqT3VZUTJJNmJseFcyTHM4ZU1hNzlnSjFNMkgxSEFHTTRJb3JaNk8vZHlQ?=
 =?utf-8?B?YkY0ZWJvUUt3QWVMUDhiZldmcXpnTDFNQjMxMXU2dkdxem1rWFZsM0hJUGdS?=
 =?utf-8?B?RWJSSWhnemNzWDR3MlNMc1VKc0EyVjlKeXRFZXNmV3Y1SUZsZFE3elRwYWRW?=
 =?utf-8?B?bktOdXg5L1Z4UzhMSFRnMGRmb1VmY09uOVJMbnZ0VC90Tmo1VGMwbzRpWW5a?=
 =?utf-8?B?aGhJaURYdXV4L01KUXlJbkI1dytabG9MeTlUV3ZpS0hJU1pJSUFWT1BKUFFx?=
 =?utf-8?B?UEF4N2o1cVZtb1ZoeVAzOXhJVytlTGdUMHZVVFZ1c09RUEZXQlJWdHhOWjdx?=
 =?utf-8?B?RXpIa1FUR3pXYTBBZ0xoK0ZaY3QxRzZRNVM1UFE5MXljMzNpYlJMUWJYUURl?=
 =?utf-8?B?MGwwSlNiNFVjZWhTYTRoWlBsWDFoQVF2SkhCejlHTkxVVjFLalNYZndweS81?=
 =?utf-8?B?U0xUUEdqTGZrck50S3lLbGZFTmx2TE5lSGFJaFkyQm0wcjZPaDZNd3VySVVj?=
 =?utf-8?B?UUY4UEdLT05LMUlpa05tdmdSTWY0NkJDdFhFMUNDNHpTbjdkTVBkeHdCV3Zl?=
 =?utf-8?B?dkI2UEJmcFd5eHYzSXluTHRlQUZzcUI1SzNnNFUxeGozTTF2UmxrZWRMd2Vs?=
 =?utf-8?B?NHRveGlsbWFYb29uSlBTZlBRUGZIN3VLNGFzR0VBVlhrbFhkaFgweU1ESFZU?=
 =?utf-8?B?d3N1cWlwRGkySk0xalpkTlVxTEdKc3QwVVo5OGVXb2JJOGhHakR1aDFuYXps?=
 =?utf-8?B?KzZuZjR3UlBqK2wyRmxXYU9mdDAxQUMvZTd6SXhIVHR2a09kMzMvaUVtTFla?=
 =?utf-8?B?WE9FNFpZamhsczVpdGpKMXRTVGpLNkdJbXhGZTRlNUxOcm5Sc3pOUERTTEUv?=
 =?utf-8?B?UC81cVBMNnMra3JEMDhhNE9FWXViUTZpdnFyRHpOSTFvNHNGRFVFOGcvbzVI?=
 =?utf-8?B?Tkg0RW9hQjhkcGYzQlNBeDlDRmxtaUt6T0xEREJHYndmcHR4TzU3V1hiaFJi?=
 =?utf-8?B?OWtpNnlsZy9LVzBXY1cwR2poWDJYYVRaYTBsT0pRdUU5N3ZqS0dtUG1lOHY4?=
 =?utf-8?B?eHFucDlMVlg0UTZMd2VuMitPSHpGUWtJNVRQMzNBdG1XSm16Y296c2pxd3hE?=
 =?utf-8?B?ZEVxZXM3QWxMY085VG9KaElMMHdrWk1XTEg3UU9MRE9jRWRZWHRuU24xQ1B3?=
 =?utf-8?B?bHQ0WGJ0RWdnM2RtTUVpQXVNd2VYQlJYalo5NllOMS9iTjlkb0RYb3Vvb2pF?=
 =?utf-8?B?M29CMXhwUXhlZGRPbTZzZ0QyVkljM21RcHQ3NEtKbGtNQ0s1bXArTmdHTnNi?=
 =?utf-8?B?YmVRcTFqRTlhVUlCdzZ4TW42N1dNUGJWOHQ4MDEvTTIrZlY4bHBwTTJpQTNs?=
 =?utf-8?B?T045SEZYcFJCLzBKekdlRm1JOWRZMnJXY1M0Y0IyUHd5YVVhWjlGQ1ZsZVk0?=
 =?utf-8?B?Y3VnSUVyRVZwRUVsOWZhTFNYUWc4ek5VcDh5bEFyUHJIajJ1Vk5JekVreTQv?=
 =?utf-8?B?U05FNjhDNU5uRExPU2phWDJuTDRuTDVsUVpLRllwT29oNmlOYzJNdnAxSkFr?=
 =?utf-8?Q?TKqXt1TEYXPyxZRzxAmIhzQdW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e3d7f8-d144-4de2-2d17-08dc102198b2
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:12:46.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNTuYNecamoiIE9bC0voo/9su16njlJiSOnttZAGAAZG/wJlSy1WElJOZiNAFngw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935



On 1/8/24 08:46, Xu Yilun wrote:
> On Fri, Jan 05, 2024 at 05:04:31PM +0100, Michal Simek wrote:
>> Convert Altera's bridges to yaml with using fpga-bridge.yaml.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   .../fpga/altera-fpga2sdram-bridge.txt         | 13 ----
>>   .../fpga/altera-fpga2sdram-bridge.yaml        | 34 ++++++++++
>>   .../bindings/fpga/altera-freeze-bridge.txt    | 20 ------
>>   .../bindings/fpga/altera-freeze-bridge.yaml   | 41 ++++++++++++
>>   .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 -----------
>>   .../bindings/fpga/altera-hps2fpga-bridge.yaml | 63 +++++++++++++++++++
>>   6 files changed, 138 insertions(+), 69 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>>   create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
>>   create mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
>>   create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>> deleted file mode 100644
>> index 5dd0ff0f7b4e..000000000000
>> --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>> +++ /dev/null
>> @@ -1,13 +0,0 @@
>> -Altera FPGA To SDRAM Bridge Driver
>> -
>> -Required properties:
>> -- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
>> -
>> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>> -
>> -Example:
>> -	fpga_bridge3: fpga-bridge@ffc25080 {
>> -		compatible = "altr,socfpga-fpga2sdram-bridge";
>> -		reg = <0xffc25080 0x4>;
>> -		bridge-enable = <0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>> new file mode 100644
>> index 000000000000..a3f3fe2729f2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/altera-fpga2sdram-bridge.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Altera FPGA To SDRAM Bridge
>> +
>> +maintainers:
>> +  - Xu Yilun <yilun.xu@intel.com>
>> +
>> +allOf:
>> +  - $ref: fpga-bridge.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: altr,socfpga-fpga2sdram-bridge
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Is the 'reg' required? I didn't see it in original txt.

you tell me. It was in example that's why I made it mandatory.

> 
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    fpga-bridge@ffc25080 {
>> +        compatible = "altr,socfpga-fpga2sdram-bridge";
>> +        reg = <0xffc25080 0x4>;
>> +        bridge-enable = <0>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
>> deleted file mode 100644
>> index 8b26fbcff3c6..000000000000
>> --- a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
>> +++ /dev/null
>> @@ -1,20 +0,0 @@
>> -Altera Freeze Bridge Controller Driver
>> -
>> -The Altera Freeze Bridge Controller manages one or more freeze bridges.
>> -The controller can freeze/disable the bridges which prevents signal
>> -changes from passing through the bridge.  The controller can also
>> -unfreeze/enable the bridges which allows traffic to pass through the
>> -bridge normally.
>> -
>> -Required properties:
>> -- compatible		: Should contain "altr,freeze-bridge-controller"
>> -- regs			: base address and size for freeze bridge module
>> -
>> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>> -
>> -Example:
>> -	freeze-controller@100000450 {
>> -		compatible = "altr,freeze-bridge-controller";
>> -		regs = <0x1000 0x10>;
>> -		bridge-enable = <0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
>> new file mode 100644
>> index 000000000000..4a89e3980669
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/altera-freeze-bridge.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/altera-freeze-bridge.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Altera Freeze Bridge Controller
>> +
>> +description: |
>> +  The Altera Freeze Bridge Controller manages one or more freeze bridges.
>> +  The controller can freeze/disable the bridges which prevents signal
>> +  changes from passing through the bridge. The controller can also
>> +  unfreeze/enable the bridges which allows traffic to pass through the bridge
>> +  normally.
>> +
>> +maintainers:
>> +  - Xu Yilun <yilun.xu@intel.com>
>> +
>> +allOf:
>> +  - $ref: fpga-bridge.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: altr,freeze-bridge-controller
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    fpga-bridge@100000450 {
>> +        compatible = "altr,freeze-bridge-controller";
>> +        reg = <0x1000 0x10>;
>> +        bridge-enable = <0>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
>> deleted file mode 100644
>> index 68cce3945b10..000000000000
>> --- a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
>> +++ /dev/null
>> @@ -1,36 +0,0 @@
>> -Altera FPGA/HPS Bridge Driver
>> -
>> -Required properties:
>> -- regs		: base address and size for AXI bridge module
>> -- compatible	: Should contain one of:
>> -		  "altr,socfpga-lwhps2fpga-bridge",
>> -		  "altr,socfpga-hps2fpga-bridge", or
>> -		  "altr,socfpga-fpga2hps-bridge"
>> -- resets	: Phandle and reset specifier for this bridge's reset
>> -- clocks	: Clocks used by this module.
>> -
>> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>> -
>> -Example:
>> -	fpga_bridge0: fpga-bridge@ff400000 {
>> -		compatible = "altr,socfpga-lwhps2fpga-bridge";
>> -		reg = <0xff400000 0x100000>;
>> -		resets = <&rst LWHPS2FPGA_RESET>;
>> -		clocks = <&l4_main_clk>;
>> -		bridge-enable = <0>;
>> -	};
>> -
>> -	fpga_bridge1: fpga-bridge@ff500000 {
>> -		compatible = "altr,socfpga-hps2fpga-bridge";
>> -		reg = <0xff500000 0x10000>;
>> -		resets = <&rst HPS2FPGA_RESET>;
>> -		clocks = <&l4_main_clk>;
>> -		bridge-enable = <1>;
>> -	};
>> -
>> -	fpga_bridge2: fpga-bridge@ff600000 {
>> -		compatible = "altr,socfpga-fpga2hps-bridge";
>> -		reg = <0xff600000 0x100000>;
>> -		resets = <&rst FPGA2HPS_RESET>;
>> -		clocks = <&l4_main_clk>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
>> new file mode 100644
>> index 000000000000..f8210449dfed
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.yaml
>> @@ -0,0 +1,63 @@
> 
> Is the License identifier also needed?

yes it is. Will add in v2. Checkpatch didn't catch it. :-(

Thanks,
Michal

