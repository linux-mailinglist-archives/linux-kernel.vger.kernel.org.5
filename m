Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98098757EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjGROBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjGROAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:00:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBE170E;
        Tue, 18 Jul 2023 07:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kONNpFfKxWX1nvDndg2gFmu/dcPRtSQvpbxtRqoBcVPCs8W2KX+BYSZQgAYzaXmYE1544xfQDhhu8u9Gm2qyxDUZFOgzT3Bum9IuJbllaKHJbzNtQFS2Z/mjHJSCKInxPg/1uz9LG+MdYcVROqJ8M3zlS0JCawjpFBN7ebvKuBXagINYc5nH4miMw6cqtBnHdQosYKw7qaFYCpja51cmzWutN2ZmDjiTjpasjvH6YucHmrkdGro3eYDCvOcDJYUaEkfYQBAi9XIf+gHetXg7IxtzqNTYAqNFAI3saXjpP8yH2IAt+EmgAbb7Og0FHWBiRQrhKUWLgZpJfY9HC+WCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlKDGBgg8n3lzsa1apvlsgMvaw3NMAO1kxD/F3WVsbk=;
 b=XG20DGUatG0Y3VBy5hrgfr50j3RTXobAjdcTRhWW0XZOd2NSBf38cVh8tmmvoMGsR0x8EDNGGagRxd9kEchFDHU1Z06twGcBBU8AiY/2k9AN7R82rQpQf6O8YGjehryaeB/1cOX+jp83Rg/uINU89dFM5vToZrn6pgiPy0AVbjOEZ/T/baSBHShN+hUEBw3GXi0QEmlCXS9XUdkdSflp9qjaADEIrLRLNyPcm0z7vgx2HfGKvmWzoEplXVCeL/wIz4gPJtj8wMaaEG70VChB+e9SLZUzXG/sPxKJ1wE9XRyTdKjoR/yjNpwVuCTpwLUDSWKZluFnW0J7tDa6mS3DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlKDGBgg8n3lzsa1apvlsgMvaw3NMAO1kxD/F3WVsbk=;
 b=4roAWtEij97NYv4Z9MTXZIbzYmPEONXSuS84EgnevryOaKy23fdZHHjhCnWwA2QBYZ2fk/3aiXY8Am3QFpO3JYS9pyM+M7Sk0urhx8Xf/jhZObUOYFvuUhB/gb1cPZco3lAfORrQaRP48CmhVgZ545JNWcn3c5o4rGbrfl6ujwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 13:59:49 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:59:49 +0000
Message-ID: <109990fa-fb67-48e2-6424-37ce47cf68f7@amd.com>
Date:   Tue, 18 Jul 2023 15:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
 <5c45d89b-00c5-a330-2e1f-b99043736527@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <5c45d89b-00c5-a330-2e1f-b99043736527@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4ed501-5d74-4e4d-5706-08db87973ffb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PR/DmYu6PVlJsIzxkYHYc2oNKHCPFQaIxrT9srzdsymkGiRfJjfDw9AtwfkEqxFgp7ItPjo+TEqwqPKXu1mXLFAbmdEEuZO6d9Of/3KS70lSGfUd2wdJfk8MIPFub01kOpz5PCqAVEVvU9GG73qa5d6AhJyrFAmpz0jyD9eNGifXypQ3C3626enL5cpf4c5QgMpK29Kd/2apc6r5rhM/P3i+Q1sdndNiz+PPUc2ZLLtE97Ls3wpwgccTkXq6gx7BvbSuAdcxY5bNZb/avUuyVPVAN68KO+Ma1KHKrc0wbgSolAVfeegdYmsb9Fz0sMxlvE77g//uVCspKp0kqvAdi+W7TA2/N2HQczZ4gkJJyFQjjiRDpVXpYZOkWk1OmJ9QzSR9bog6JP2d8uShqxo8Mk3z2EulmFiljoFGNaNrcw8rCkDDM0dziufmAIHaqiC24Lch8XTTWDZVlOcRh08uL5bNatHgXVXYqiX/g4Cr4Y/Ct6ezBNFsw3+yUQ4XvJn1kKB+oeO2Cy3UNf6A8wRxOHhLL08umLX1XUCAvM+LKhPoSQJ3ybpdQc9hv+U7lBr/V5obdzQ+baB1Y+w4q7b89LIqVCRi+rg8o/+FkA6OAMAzKpQW8ay/Km9aR1Qf2nb+qxetUtvAbZJXj3jvxug2pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(15650500001)(110136005)(83380400001)(26005)(6512007)(966005)(6506007)(53546011)(6486002)(86362001)(31696002)(6666004)(36756003)(186003)(2616005)(478600001)(2906002)(6636002)(4326008)(66556008)(66476007)(316002)(5660300002)(66946007)(44832011)(8676002)(31686004)(8936002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2dOWXcwSFF3ZUdkN2JLaVFvaWlZaDRJaWFsM2lpN3JnU1RTZTNYaVdaSk9F?=
 =?utf-8?B?TjZzMndMQVZ5TmZHVGlzK090Z3FuQXJhNHg3bnp6UEhLcTVoZlVzRnZ3ejgz?=
 =?utf-8?B?aXVZOEtQUWxSaE8zUktGZkNmVmNUc1FKOE9GQXRKc1BlRXRHa2ZpY09YOGNH?=
 =?utf-8?B?eGRmVWEyUnZFQWV3S0tLdWxxSmhQVVlUNTNuaXg1VTBTd2NMVHhXSHZ2U0NM?=
 =?utf-8?B?V2RFQmgzd1lMQkJ4aHFxcS9sUVRVcmh5T1hyTWdGcWhmblg0MzQ2Tkhrbmkx?=
 =?utf-8?B?Rkhqd3dvalR5Q3hHMzdSd3lvMXlvYW9pdXpkNGJuVGlwMDV3MUdyS1pVekEx?=
 =?utf-8?B?dzVVRVAyZ3hFSDJlekE5VXMzSnpoV0ZpSFRRMjVEdjhVM09pVFRmT29qL2FX?=
 =?utf-8?B?TFZsbEZBOTJTVmtzTFQwNno3TnZKTDNDdlk4eDBkWXJWdy8waXExTDdYMnVT?=
 =?utf-8?B?MXVMTXhpZWxuTWU0dGdEdFNteFlLZFY3SnkxTEFvZkN6M3QwS3prQXFoanY5?=
 =?utf-8?B?RDhlcU5EVk1CZ3AreDJhOXBjd0FiNEJucW80S2EwazlITFZIRnUrZzNESmVC?=
 =?utf-8?B?bE5aeUEwY3grR2tTZ1dHcTNzZHk0a2tkaUZvVG5iY05SZStUMERQczBBNFlQ?=
 =?utf-8?B?ZDQxejdiRjZ0MEZtR2ROZXNLckErMzQ3VmtVbGhJVU1NUkpuUXB2RGVBZE1y?=
 =?utf-8?B?MXhIYS9BRzY2ZHMvOWpXZUhrQ21YRWtTZzJndWNDOFRCM3JULzJlU0pqZ1VC?=
 =?utf-8?B?dEpoc2gxalVNckF4MWROS3lmQy8yY3BVR2duL0J6SWRJNUVEWmk1d1Y1UFE0?=
 =?utf-8?B?Sk05RVlveCt3TUdTSkZWVGt6Si9vNG16Slp5cDB4OXY2c1M2N0RTcG1pZ2xC?=
 =?utf-8?B?cjMyc2VPa1NORVFYbU5WM2RlcWN6R2lUaWs3aERDUVBqRld0alBTYnFBMFI2?=
 =?utf-8?B?dWtZZWpFYkIxTWRLY2VTVlUzQzhGUG1WcFJEbjJEWHc2Z3BqQlRtcytnemdJ?=
 =?utf-8?B?dkNQd1pSS2lObDVIZm5tUU0zK1hQSWV2aUFqZXdLQ1pMM2lOMWsvcmFDMld4?=
 =?utf-8?B?WlNwOHQ5cUREQU1vQUVRRHg0MzRyRzhyTU1JZjFJVGxNL3dFVXNOUDhrbC9K?=
 =?utf-8?B?ZGVZTlZkYU9lQk5IaWxjQ2JWdUgwMUdzdEk1TTBLSkIxY2ZqdkpZZG9CVFlj?=
 =?utf-8?B?bngzNU93RjVEZG13VDJlWjlsY1o0TitqOXdyRXdkaFFPNzEzbmwwNzB1Nkty?=
 =?utf-8?B?SzNWNW9uMXQ5TmRQWnpuRlNDZ3cxelZVMEZwc0g5MlgweXhTSlFFdXErLysx?=
 =?utf-8?B?TVdQaWdWRUN6S2ZibTBFZXp3Mk5xblpDeE4vV0x3QnZBRlJjUXBYd1o2eDc3?=
 =?utf-8?B?ZHhEemJzbm53Z3kwdEVEbUNnR01xSkZscVp6OG9xWWJCRWpMc0MwdEpJczd1?=
 =?utf-8?B?WTNXWmcxOE81c2YwV3oxRG9sUnlQL1hnS2ZEdjA3MEQvdkIzYTdPU2IxVStk?=
 =?utf-8?B?VVIraUgzNG4zS1N4K09taDNuRGRGTGVmeFdmdUFWeENrOE5hU0V2R3BaU1hx?=
 =?utf-8?B?cTh2MmRJaTkra0FXY3pjNkRJL1BvNWpydzdIb21tMGtUT1hXTHhxc2xsUG1Y?=
 =?utf-8?B?SE5ac08weXd4V0R5RmtVMU5aSEN4RXJYWm4wZFhDRndjUElSSFV6OE5XKzlT?=
 =?utf-8?B?ak1SQUkwbmYvMXBRM2JDUUhqdWUxNklVWkxzQ25xMzZ5SEJRSElXTGFPbzJO?=
 =?utf-8?B?ajZRWTFRcmhMZ05FV1lJY0VBbEdYM2Rqb0VVL3BnZHF5WHoxbDB6SWtLVDhj?=
 =?utf-8?B?K0RybC9tRmk4SXdiSTdHWUFyMHpzN3NJY3VlYmkvOFN3aXJya3pWV2x2aHd2?=
 =?utf-8?B?VnE0bXk1aG9sRVFQb05abzY0Y1dzSFhicHBtYnhVcjNQd01VcjJ4em02L1ZR?=
 =?utf-8?B?L1VTUEk0c3lYOGpENFNTNXBwNXFEeWFZVHhlckhETGZZdFFTTGtWdG1EUmEy?=
 =?utf-8?B?eFBDNHpzR05maEtCQlRabmlTbUpOWlJCS0hKN1JRV3dEUGlKVThWNTZmYW5C?=
 =?utf-8?B?bnV5YmlncStJSWhSK2lCN0J5YXptbThvSlRKWGVySVd5bUU1b1VFTld3aWpj?=
 =?utf-8?Q?c4Ab0D+4hjub4Sk39MVj10E7u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4ed501-5d74-4e4d-5706-08db87973ffb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:59:48.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIHTBwpBVj6IZ1P3eKzyfJ2SmPOj8cHw2HjtqaD6rVtFzcRdDGeynx5MLyztWSse
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 15:21, Krzysztof Kozlowski wrote:
> On 18/07/2023 15:20, Krzysztof Kozlowski wrote:
>> On 18/07/2023 15:11, Michal Simek wrote:
>>>>>
>>>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>>>> core but it is up to drivers.
>>>>
>>>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>>>> and have representation in Linux driver. You do not need to define
>>>> anything virtual in the bindings.
>>>
>>> Not sure how you define ID itself. But HW doesn't know ID. HW knows only
>>> register which you can use to perform the reset. It is not really 128bit
>>> register where every bit targets to different IP.
>>>
>>> And this is SW-firmware interface like SCMI reset driver.
>>>
>>> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
>>> Their Linux driver is asking for nr_reset via firmware call which can be
>>> different for different SOC and that's fine and I have no problem with it.
>>> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different
>>> SCMI server implementation can map it differently.
>>
>> Sure, and all this points to: no need for bindings.
>>
>>>
>>>
>>>>> In our case that IDs are coming from firmware and driver itself is just matching
>>>>> them.
>>>>
>>>> So they are the same as if coming from hardware - no need for IDs.
>>>
>>> It is hard to say what hardware here exactly is. From my perspective and I am
>>> not advocating not using IDs from 0 to max, it is just a number.
>>>
>>> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to
>>> reach my goal which is reset QSPI IP.
>>>
>>> If you think that we should use IDs from 0 to max NR I am happy to pass this
>>> message to PM team and we should extend any SW to do translation between.
>>
>> When we talk about IDs and bindings, we mean IDs meaningful to Linux.
>> Whatever is ignored by Linux and passed to anyone else - hardware or
>> firmware - is not a ID anymore from bindings point of view. It's just
>> some value.
> 
> And just some proofs:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/reset/xlnx-versal-resets.h?h=v6.5-rc2
> $ git grep VERSAL_RST
> Results: No users.

I know this. I should likely submit one DT for Versal to start to use it.

Thanks,
Michal

