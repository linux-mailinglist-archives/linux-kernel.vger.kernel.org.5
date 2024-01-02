Return-Path: <linux-kernel+bounces-14562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B324821EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF61C2246B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462214A9C;
	Tue,  2 Jan 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2H668tkc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BF14267;
	Tue,  2 Jan 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0phb525lTR6h4LmiRU4WVzjb5B3wL7XqeskiH39cRvEXxQuj0hLI66pQg6AzoGg6zUtPV+4D3oBU/gQUiZyv7byJk0BmmVkVkWKr/WBcjUadVcvBA6nHoF1/fbeo+Xx4mpRC2QBTi7D8Z4tH3TTLH1jyxbt4PoB6+36CmHSwTUuSEfwVgVnCOM/mP+9TZqZIuiHyGhEPpGp+Q7wcuZsyo6J+pusTknkXSrEugYKcd3v2iqzsErQIVlmP0BueRMR7nUxzGmz3PWvFkhwbZ3j5NGADhtE5UfBYbulNOuyWplRMblbL2wBs8Ia4d8vjuaarWpZ6/OYYFd1c1OPgW3Axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImdnEgFY5VqzIXmKA+Ko3rpML+TH/+XBq0/nLZ2Sjts=;
 b=Be7rLE/Izp4EKqQs+dKVf9YqnZ+A4+7PRStkIxICgEiZfNx09nk9TETV10RPTA0P7aMYyYl3mRi+HP0SQX1staMm/nLAO+UgHKVe9bgWR9B0Cst24x9wYpKPUuSf+djAHJHIZKPoeL7RvsOdWmbbk4j9czZ+ht5OB6b6esQQsHkcU4bONjfOqShwqHO9eaQ+9kuhBDNs8ozKpzDFzObPz17ILFh2qQKVvy1EDihahYECTmoSoqE+QDhsnG2por3ZKuqeWHFgGheKusotEDCi/bZF6T3/91BeUwwcDpLVrsp7Ug9vsTnMJl6FWkJoyXWMXYs9yCMRtlHyUzBHNPSOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImdnEgFY5VqzIXmKA+Ko3rpML+TH/+XBq0/nLZ2Sjts=;
 b=2H668tkcqZheF27ehoy63PUjDfmUh6dLeudIiKGil7GvyDJAHEhEHkMd3RJqK8WchgQcHkCYh1p7FooX11P3cNTB71Hx8oYCyM+Ih7jtuYzEs9Z4Z3QaEuuU2ryZ7LjvTz6vtLw2/VyXnXLfDCgcnT/SlUPy9yoq9Pi2RPduHIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:441::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 15:32:46 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:32:46 +0000
Message-ID: <08546f36-9f88-4fd9-ba4e-5d6ee21cd60f@amd.com>
Date: Tue, 2 Jan 2024 16:32:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: serial: Describe ARM dcc interface
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <9d7e85914eb1cdb313b28cb019093a84dd9b4773.1703167505.git.michal.simek@amd.com>
 <de6370c5-5cd1-409a-8716-99dd7738d30d@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <de6370c5-5cd1-409a-8716-99dd7738d30d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:803:118::15) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd64eff-a298-4825-cd1a-08dc0ba8120d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ciIQ3lbEqDu7T2MdtMn/5a1evgImK39xpXL4yeHQYOaT5F70CXwPDmTVhNTzTTepvSKYaI0kCmhxz9QwXFqvEzaqeUde/dI4G7zqYlDMSHYL4xl4PRCeJVGQi9uLLK5qH/XH1TD6QuNnhJRkw/SIJ5GpVGthEcvdwWfVKPYlQpN+eyqdtoxXU1Mam/61FFVhUgBt3bD1oN8rEALllk4HQDZOxvWhhV+M5RO7LB3USOuhJWeFC3p6i3RLUS5a5x43niwQhIXhjsotBViNj9cjC7zY3IivzkYxjl4K0yayZk3qlHvsYleJ4mFoc61WDyQ0e/cpjFuAr72fhq31IE2eqLq5kpQx6uWL9fRtKa+ZXYopc6vvXdxzZKu7Ku1tbfaj8ASxoOEuMK4OWzy2RpdH1hfrjuJTFVr0qj8hVV/9OjHpeDQZJu5pdMaANovUohOQICqozdCKR90m+mn1kr2mpSD4DsUr8ngp2WDY76gnYBDMZCTMy43GZnxFfsPwQKKlYhd4MwjkveYcx/7QNvdaURsB04uk1lle+ScTwqAVYgvzxZsDFx4NjY5iVd3NxQa0eWP5kPoazTMuXACFRXY502xDFWvcN+huY+1sbzC0tunpNA3mciizHHOfyv6XUdET
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(31686004)(86362001)(31696002)(26005)(2616005)(6512007)(6506007)(53546011)(6666004)(54906003)(8936002)(8676002)(6486002)(966005)(316002)(478600001)(4326008)(66946007)(66556008)(66476007)(41300700001)(44832011)(2906002)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2VpeFVoZC94MXE0MFlJRldJSlBXWjc0WjRFQ1NwTXhrVm1IeEhWMUw4WFdM?=
 =?utf-8?B?cEYvS0plZ3JYVklqczNhMS9Od1lTcGQraGtsbWdrbDhqcXd2WUFTdVZlTnp1?=
 =?utf-8?B?SUhjSll6OFJyV0duQXRsK09WeTVQcTVUZjJZaVVNS3hsK0p2RldFd0NvMEoz?=
 =?utf-8?B?aHR5ZUw3dksrd1lOSU9iUDZTWlVTa2wzcGJkOVRxeHRIL1ZKcWVWZStvU1Rt?=
 =?utf-8?B?N3Z4MDZsRm1TLzhhTllmazl4bnM2ZFNKQkpOQUZyd3dVQk5nMmRSWngrb3Nq?=
 =?utf-8?B?Q2I3YmIzYTF0dmRnTi9JdXRmS0ZwSFpac3UyVEtQZDdHR2gyODNFOU5lV2VT?=
 =?utf-8?B?ak5IbXZVMTZ5eUdwUjE1MCt1Wkp1V0tuTUl1MWpDb29yRnc5aWFtbEUrY3dw?=
 =?utf-8?B?QlFNUzhZSlNyTnlkMDlXQUNmZ0pucWN3Wk1UQjRGRTluZWk2aThrUWVEYUJh?=
 =?utf-8?B?czRMK2xjMzVaZDVzT045MC9oOTRseG5wWFZseDN6Ukt4NHBXS1pJdWV0aFps?=
 =?utf-8?B?Z01IQWxPZDZBajhpWjhYRmw0Unk4WDlnYXNlMHNpdm1WdWc0MG5HcE1meDNX?=
 =?utf-8?B?cHQ0TU01RHNXZXZYODg4aGw2Zk5OeFY3aER0RTZFcXNBOW1VMkFqU1VCY3I2?=
 =?utf-8?B?WVlUcnVoSkx5K3pUc0c0dDZGUUMwbzYyS0ljbnprVmE0dHJMTFBkV2I1VHpl?=
 =?utf-8?B?MVVUTEZmOWRuOEgvaWY0eHVPNGRpM3QxQkxwUDV5Um42YXFoUURCOWdicnky?=
 =?utf-8?B?Wk5LbWhVeXBOZWJ3N3UvMkh0TE5LQ2NQZ1VyeFNIUXNMLzVWREU4eWh3UWxV?=
 =?utf-8?B?YzFueDYrcWxBVUJrUmRSUzVNK0ZjZXZudExRbTU5ME0yZThyOFZETVVVREFG?=
 =?utf-8?B?Um9jeVJFbWdUVWNUcXM2WWNDcndqRkt4TWNDbWc3YXhRQ28zTVhMTit3cTNj?=
 =?utf-8?B?dEQxbllJbHZ5a0Y0U0hSQXZKSkU4eW5zNldtVk9HTjVodnBoY1lvcWYvQWpn?=
 =?utf-8?B?N2FSa29hQmo3eElqOFozLzBCa3V3cEdZUVdPQ1QvK2sxTS9xR1ZYN1FDNkpG?=
 =?utf-8?B?SXhocnRyZzlqSzdTa2o1endRUm9mc05xWGdLYmtSYUdpU0EraXdxeTIwbzVD?=
 =?utf-8?B?QTFZbDB2eS9TSHEzSUpKczdpQmM4MXdjVm1EVngxUlYzbzUrbGp5cW9jWS9O?=
 =?utf-8?B?OFZabk5YaUZrbHV0UDlLRldDaFduYmY5K0pjdmpiN09BRm5acjRxQ0ptL0Z0?=
 =?utf-8?B?RDlpK1BONHdNSDE4RXpwTC9nQlJXaDlSaWhFYlNDbVNQSXVSTnhTaUZqOGdI?=
 =?utf-8?B?UU9KU1lUOCtxU2Y1N1FraThqamVnc01iZCtpSVNOSnlOS0R3aGN3QlQrUnRp?=
 =?utf-8?B?WVM0RGxaWkQxOTQxRlR4bnVEcGxPTE5ub1pwSGNya2ZCS05CM2ttU29CV0h4?=
 =?utf-8?B?YmFRWkJCanQwNzNzZWJZRW5HOWp5U3BPZ042RmtVNExtTzkxSnZBME5TOUpm?=
 =?utf-8?B?ekFnMHZiUGJ6WjNmOWs2YWJnc2dPTUJTa2dib0RQdmtMb0l1Zk04TWk5azhS?=
 =?utf-8?B?dGY2S1Y4L2tyQ0NTVnNQOHZtYzFCblA4Y1NOa2F6TVoveXA4V1RkVEVJR1hq?=
 =?utf-8?B?Q1FxZmV5Snd0MTRMMzNXYkt2c2lmT01UUFNXTkMwV3ZuZGFRVWJ2eUVmSkRY?=
 =?utf-8?B?VUowTHJQSytoSkprM1Q2UStkWERHQTBiNGJJSWQ3cTJDVGhmT3prNU00RVJx?=
 =?utf-8?B?UGY3enI1Ymc4em1DUHhLV2szdVdrbEhMb0tBelpPY3BzSWJjYVRoNk9HL1Fq?=
 =?utf-8?B?VWpONFVQTlFsNFJWMmI4RWpHRmlkV29neXpaZmlUUGJlMUt0R3ZVUEI0b2gr?=
 =?utf-8?B?TmQ2WU8rMVN5M0FOdXN4YVFneHIvYkc2b0FxaTBSblNkV2N5b0V5QS9Eb0gz?=
 =?utf-8?B?SXdONXZqbzRtWVUwMXBveFF0Qm8vMzA5T1JoQWRxTG83T1hmelVERUZMU1Mx?=
 =?utf-8?B?Rm5GN21vRDBCUTBxY1VYNXNudExZYko2R1h5cjM1NzIxZnpKNWhEenJmUjVG?=
 =?utf-8?B?WUNzZW54UTFLQzdSRmE2ZDV1SzRhK1Znc21nN1padllzOS9ScFBRdTNWZlpx?=
 =?utf-8?Q?apfGSZcDSePziypfNOKqFqJI8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd64eff-a298-4825-cd1a-08dc0ba8120d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 15:32:46.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H39OwYL7UHRQrsGVCwa53xxLD9XJCeH1YD4+NTcnFtM3abbcL8+L+LuzzGRULRE/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529



On 12/22/23 09:20, Krzysztof Kozlowski wrote:
> On 21/12/2023 15:05, Michal Simek wrote:
>> Debug Communication Channel (DCC) provides the way how to pass data between
>> target CPU and host via JTAG interface. Every CPU has own interface for
>> communication via dbgdtrtx_el0 and dbgdtrrx_el0 registers.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> This communication interface is used for flash programming on Xilinx
>> SOCs from U-Boot.
>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/serial/arm_dcc.c
>>
>> ---
>>   .../devicetree/bindings/serial/arm,dcc.yaml   | 30 +++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/arm,dcc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/serial/arm,dcc.yaml b/Documentation/devicetree/bindings/serial/arm,dcc.yaml
>> new file mode 100644
>> index 000000000000..fd0589356617
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/arm,dcc.yaml
>> @@ -0,0 +1,30 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/arm,dcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ARM DCC (Data communication channel) serial emulation
>> +
>> +maintainers:
>> +  - Michal Simek <michal.simek@amd.com>
>> +
>> +description: |
>> +  ARM DCC (Data communication channel) serial emulation interface available
>> +  via JTAG can be also used as one of serial line tightly coupled with every
>> +  ARM CPU available in the system.
>> +
>> +properties:
>> +  compatible:
>> +    const: arm,dcc
>> +
>> +required:
>> +  - compatible
> 
> no allOf: with $ref to serial.yaml? Does it differ somehow?

Valid one could be only nodename format and maybe label.
Others are not relevant. But if that's fine I can also add it.

Thanks,
Michal


