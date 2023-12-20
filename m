Return-Path: <linux-kernel+bounces-6523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6FC8199EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A41286D50
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3D171DC;
	Wed, 20 Dec 2023 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VOh2HStA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFECF18625;
	Wed, 20 Dec 2023 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDC7RlkMHadWg9ubod1KXqDokY4BU9baOESL3L3LP+VPTtxueNwM+XSoF3zJ+80xYqkXkKc3UH2y2Fbhlh4F+AkSu5v0G4bR0xRDqSXs+g1HoH66O4fbaxYsD0Y1e5ReUzFvBA+4PD8JzmbidZhTlcwRU9jV9PCFgkoIYgvfyP3RRvCbuaUwxabcbX+RBtGQ3Fi7jSVvcWFUJe3/wWYfF4fJfYYY6IT0OcJzVeD3wFhCm/ASV+MUdagBd4KFJrjt2AnY2NOciVTlTC7+fB8nBf2OSmN3QUfZ0j9MqzZQHZ8lyEM2sTWd0MVfQ1u5fIDJuGYHpZeOMjq4GHKQxjF2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNKwxNo3qAOkHn9PMjGeNL/UaZGfqR21jnWoo09taNU=;
 b=D2t6BgNAKUo0TwPPj7ojr/FbXdiBdmC+20iBNC0oz6KYKI3IS3J7UHJD0cQFpnlNh+zZwcK5fJJ0C60gbhz++P3DsyQnDczPM3j3WLjZ3RWJKl63fndZJiyobhs2xU++G+0SgwcutTl4nKv1kMFg/1XfBbDSfLmy6gaRvcZBfo1DtKgd+P6VD452ZlTp/F5ZgUTaB+lzAkelSBud77fj7oTUpy02NiJvJQIn8buyDzKMNc+ftXcEWhoNXHnT0Is1LLXpAriOIAOPdm+Dir4LqPZHAks+6QfDDJxjTWIj4jGfx/K//s0YXi1TL5RueQ4s8hQFD0vXsNXir1WH4SjGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNKwxNo3qAOkHn9PMjGeNL/UaZGfqR21jnWoo09taNU=;
 b=VOh2HStA1xOHfS1DYnRKbLH3vVyxwpSnoQtdpSODrIKC1JBqc5mULkqjB+LdOuZDQASbR0pBt2phqzJwkgS5Lupt+0psQ8MmgNsxBWTwVscg30E/tK+yQpSWxVdT+lrbXdXmRGi/EpSs8DUzNdaMRsQf5M1TSvuhg6mWNtkIABg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 08:01:41 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:01:41 +0000
Message-ID: <1feb69af-06e4-4cfe-a4ea-8dc583742f6e@amd.com>
Date: Wed, 20 Dec 2023 09:01:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: xilinx: Add support for K26 rev2 SOMs
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <6673abb84e542c2841cece9336571f97b19882fe.1702995908.git.michal.simek@amd.com>
 <1afdcd25-d001-4523-be0d-2bf2c9e1d7a6@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1afdcd25-d001-4523-be0d-2bf2c9e1d7a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0061.eurprd03.prod.outlook.com
 (2603:10a6:803:50::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: f69ffa4b-bad2-4e63-387f-08dc0131e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MitEKaLnbgB8aVHx3XbVmXIQLcXPUZi84hXRxJQxwfCdscScgKmCRpZgwEEFw0scLJid1rgzuaACAhdnOddx724tn9yvKSyl/wClMYwwlRacKyIzb5OXNFm+MC6mga2oI/37BA1DwctAZXJUSzHUUKc6SLsvfPFoc0apTfQcrLtHankRFwoQ5dsubaZgl9jJgw4xlDxnw2eSv1H8Kv0ruwy5cMf07O1u8mpnd8Pu1gc6RzmrESuxRUCQbLk8KoZuyn72laKaqbCnstYzShB+YyzG9tH4g+mbKX8kO1NTeojnEi6YSb0UbOfoksDRL7iNHCQQqzfii2VgnqEXiXMMvGY3ygtLZ+GiTn0HAq7VwFPSlRTDH3anUPEJKAZB6XabHkLk3r8g4ShPU2uWVRDKyhEF8qjhWrZuwRDHeYqV0VKlEoORV3dMICcxXL7faqv2Wxa/u7eW6QpOCtVMwR7UGM0YOJIE7iP1EWX1biqBxXzXptaA/bm20DGw7SsSU4qXS+ZjXsyx/cSwwIQI5JTU98Yvpi33WlTYhxEzahOGLqHGHoEAOco8OurDFthQJIIcWD6kqCyDrivBIT5ANCNZJFXV6D890WfjRDcrdgA1MJznEtXih6vAu2oyeBsYmC8uxmXZ8wEhII4HDmPWLrRx4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(7416002)(2906002)(31696002)(41300700001)(86362001)(36756003)(38100700002)(6486002)(26005)(478600001)(66556008)(66946007)(54906003)(66476007)(316002)(2616005)(53546011)(6506007)(6666004)(31686004)(6512007)(44832011)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxGbVV2aG11clR0VFVyQWxzUlFaQUg4QUQwVTB3cTJ5aGQ2Rjl4RlhVc1hv?=
 =?utf-8?B?SUZTclkyNlgrVW5TS2FJY1c3T3phQmpQT29KVFBXT0N5N09VVElJSWlvM2dF?=
 =?utf-8?B?VkFRa0tmM0FKdjJKd3dQVHRoT1RxNXFKKzhFUEhHWWZ5NGtNVmtpcTM5cTJp?=
 =?utf-8?B?VDR6a3NwYmVIL2hDcGVoaGpvbUFQcjJwdTZXWlBpUTdFazJrOXJZRE1rVWRX?=
 =?utf-8?B?WEszZS8rbnE3cnRnUC9nY1YrdUljVjhaemcvMTRBWWc5UkRRMEYrbFk4andZ?=
 =?utf-8?B?RVIzRWFseFNWajM5azBzMmlLak9oeXB6TkJnQTdBQ1RSeWhCbGlndUpMYU5s?=
 =?utf-8?B?WVJrOG5mS0drTHRDcEtoYitiSFUrK0NhQW9zVXBITmU4UjhmLzZVTVo2NWlw?=
 =?utf-8?B?L0VaZFRtSzJ2RlFkeGd3WHlKeS9BdnlwVXNhZ1pna2xyY1JVbXBTK1hMNHFH?=
 =?utf-8?B?Y0dmQUtaT2VadFdlN0svRzEybUIvdjg3a3dpSjN1UFZEREpHdG5vckhOdXpu?=
 =?utf-8?B?MGFYWjY1bEp3QjRzVlhpZFJmenFvdkQySjNRWFZvR2luRTdzMmhHRFVHZ0Fz?=
 =?utf-8?B?bkZ5RVkxUXNNK2tDcWZoU0VoUlRjTmgzVDJTbnphOUVsQjVtTStEaG9DMVNq?=
 =?utf-8?B?cmZWdndKbC9rclBMSXlGa0hBVXZsUkszZCtlYSt5WGFXSSsvaDZCWHcxWWZX?=
 =?utf-8?B?ZUJYYWJwTGQzOEUwdFcwM2UybnhqS2VJOTVkVVpsTmxYL2J2L0Y2Q2llamJV?=
 =?utf-8?B?T1JCMjZYM2NoeG5tdmFQWWVTaGYyNUNKaXNRNWNYRnVrdHJ2S2ExV05KV1Ur?=
 =?utf-8?B?SUpLc3ZnbWZZcjdjdlFHeW5oclVyVmdLWm1mb29wTGhaU0NuRUNhS242TzVJ?=
 =?utf-8?B?czdmbTl6SXgrSlpCS3hUZVRIMTlJRGpXLy9GcmtyK2QrcGRkRHhQSW9JenQv?=
 =?utf-8?B?eWkrSXJMaDNUMW5WRXFSaUtqUDBzeStWNVBTRXFzS013ZER3TUJvRHIwUTNB?=
 =?utf-8?B?K1RrbmUyK0NzY1dLeWFWTXpKa2VwbHNnZ1oxd25jUDF3OEdYalpJUXl5aFB1?=
 =?utf-8?B?QW5wMTNyYzc3OHVSVDg5Q3lGWE0vUytvclQ2S0Zvc3lIa09YTjVLMmVwc1FZ?=
 =?utf-8?B?KzVhUEQ4QTMyNnUwaVhWZVpBdit5TnYvYVpXL0YwNFBPUW12RUZTQUNkMU5t?=
 =?utf-8?B?ZlFQaGtmRnNSSTRjbGg3Mk1FeHFpNmxFaSsxQVFPdERVck1vbmNzRlJuRkRk?=
 =?utf-8?B?VzRpbk1wUy9OSnllc0wwU3Nrc0syb3hEOCtTRlR0NWVDOG1tVlpZY1JQOFcx?=
 =?utf-8?B?cHhncHgrRXN5ak5yaVV4dkdFMjlnNjVvMzVBalJvTWpnV2FrckRDMEp6bTFw?=
 =?utf-8?B?Vi8xNGVVZkJrVzIvTjVrRzdsVkU4VTN4MnBsRFFaNDErRWdaZkZnS2drOVpZ?=
 =?utf-8?B?Y1lSQkt6dllSd2lkM2ZPTThQVUFQSWQ2OHlKVDZKNmtOcmZ5dkNaOERTZGRW?=
 =?utf-8?B?TkNOd0NsMFJaeWF4WjZEalVySEM2MExjY21tbGp5bTNiUDBzU21ZbDl5d0RE?=
 =?utf-8?B?QktrR1NNM1A3QURjT3RNVGdFRXZOUklvNnltWlcySzZicXFZTWVML0dtem56?=
 =?utf-8?B?UFg0QWZHS0RrQm1BUzBZSGd2ZzVuRlVVdElwU28rN2RlUXVVeVJqZmI0MERo?=
 =?utf-8?B?bG1BbDRLcjhmeW9NNEovYm0xY3luMGdPb0JTcmdyN0VVTVBzYjd0bGcxQ1dO?=
 =?utf-8?B?TU9zcys4cjZyRGpKU0Z1dDNuWE53VjdYRGZ6TTdxNXZUV3FsZlBTVlR6SjM4?=
 =?utf-8?B?dkpIUGZGdVo5ODV5ekVmNmNWaSs3b1l6Sm9ETXRiL2F2Wjl2TVZ0K243cmZw?=
 =?utf-8?B?N3lod1R1VzlqTUlNQkMzaWtscW9sZGZ2c0d6b21Dc3c4RXlUZlFiK1BzVGNT?=
 =?utf-8?B?UFZGNmNjdmcrbzZ3Wk43MVVTN2JtNWRhZmpQVnhiRmFhL0lZajE3UFlYWW1a?=
 =?utf-8?B?d0c3eUVyV0hTT2gzWmQ0S3lwMXI4R1E5SEozQ0pMeG04OWZuNHMybnRvRDZH?=
 =?utf-8?B?NGloSUxCK0V3RE5ZSDZZVVZIL08wZ1BldEM1aWVqMk0xelBuV2E5QkUrZ2lz?=
 =?utf-8?Q?9HFzxdYXm3nKoyQOj2OwE5cJA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69ffa4b-bad2-4e63-387f-08dc0131e643
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:01:41.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJM/QFpPCdTQ5rzhho+BaBHpBHhlID5IAGZgMPdzSxbzjrRx6EChEHEmk8Fknmhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828



On 12/20/23 08:55, Krzysztof Kozlowski wrote:
> On 19/12/2023 15:25, Michal Simek wrote:
>> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
>> it in model and compatible properties which are parsed by user space.
>> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
>> improvement done via an additional filter in the GreenPak chip.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> index d4c0fe1fe435..62617e1ea74f 100644
>> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
>> @@ -118,6 +118,7 @@ properties:
>>   
>>         - description: Xilinx Kria SOMs
>>           items:
>> +          - const: xlnx,zynqmp-sm-k26-rev2
>>             - const: xlnx,zynqmp-sm-k26-rev1
>>             - const: xlnx,zynqmp-sm-k26-revB
>>             - const: xlnx,zynqmp-sm-k26-revA
> 
> You are changing existing list of compatibles, so all devices with
> "rev1" will fail the checks. Is it expected?

That's a good point. I have actually never have a need to support older 
combination from validation perspective.
Let me play with it and see how it will look like to support all older 
combinations.
That would very much apply to almost all other records in this file.

Thanks,
Michal



