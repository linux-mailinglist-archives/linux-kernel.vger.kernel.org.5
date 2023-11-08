Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B707E533F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjKHKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjKHKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:24:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19CA1BD4;
        Wed,  8 Nov 2023 02:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiQWrSkQMru0Zftjvpytdy28aP73SwICKo7PEh8PKzPbu4aVwd1TWnKcIY+MSR/EiW6QYH+chZpGlUnX3sZ4n6u/OA3heQ7euLWegILzNJnEygX/IisGOERd+JflCzdYnRln5VRZHR9lpgZpPzv+v6p4qcrhNOGrb9Bx6uyfq1VB6RubDBnKRyKxtdoR4AX8UnTEWFy2EfFVY1m5GvoXMpd4GEyYM1sJsy/+dIuVfqrQ+2D9GxxAUF7NNxYVe7Bu9GZJhV8NIDYcZAw9jVJI09XDd2KNdRXECM53mCqfgzbp2O4pW5OeRc4gHVCUIR5QcOM9xTAPrUEa7HGtjLTjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8pUVidsV3NJ7tIc2EmnLurc7ZcTQXNT5byMQpTV5oA=;
 b=lFJnjpurwNTwDi4PfOsYP0z9ITdMJtlZn2p8fjcbCHbNXVvUNko/ANCPED7iI2QPxrcCm1Ob/B3zxq5Dn+ufeJutnE60Iwn8pITBSPHVe5i4Re2ci10a3WjFUj1Xx5weTdGG3t6CntPUBApFl3hblcbz//WRS/sZEyUGQdVMscjbSg9QzhBGKFnNAX9IyYK/OcknmsiX1LXI9Z54+ErYr3hyDfq0ZbjRJJp3Z3uwxJlN+PwemBIwMtvFEgN+qywGKnB5urkWKGB0Zq0+YpC9neDlygVSlKj6uq5No2IPyRso9NdW8b48RGm4u45BOrDO6PN55wAyZRVa5UBnEI8MDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8pUVidsV3NJ7tIc2EmnLurc7ZcTQXNT5byMQpTV5oA=;
 b=nlxgLU1+w5cqLO4zM5jbgPeA0B3tBGEV6JvdpVhrQIorsugRRuQ4MWTe1mcZ+o6Gsh4Bk6s8rHQC+eANO3NYQ51FNSr6qPoe+skWUwpku5DvEVjhf/C7QUruni+npb0+zwKvklQh42WRXo4a6Y0Gge52GJcAxb1fod36xNT5Fho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:24:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 10:24:34 +0000
Message-ID: <5a26431a-22bd-43f7-a9bc-d167fb8fc32c@amd.com>
Date:   Wed, 8 Nov 2023 11:24:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <20231107-expensive-jitters-92e454f77ea8@spud>
 <8b17622b-de1a-4075-9527-8755f5e4dc14@amd.com>
 <20231108-five-womankind-6ee2462c93b9@spud>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231108-five-womankind-6ee2462c93b9@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:803:104::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 17908d63-b3e6-48a7-5082-08dbe044e6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxKycSk5GgqxbWlbDittDoLsoHdm8JIGqnmQDZZZEJqOilHZPuXo5RhygxU1fSWEFjPjLWvO8MrY2wnv+vcM9bnEes6XLNzMHFh7l7jHb2q08XROcukAi6LHowEhynkxkrS2oULSRh5nQ4uLpBYW9UIEKESGi+MckqJB65V+81LFDIN0LtMFE2nUCBqubdYkS5h+9Bd9iln0VpzWPWBRXeSY+gSH/nJLXOk/RUidV7MCB1G3pC2ubqjcOHlTOUma6HOOsF16YD/uOioSfOrIij8a/QtoT1LZ2ELmzSNRj/ozhNQaKtXUMYlbYsn0/PZ53A/6J69gWczcKgzdalDCwjc7Ja27nI/3iQZKFRredh1COCwgmLCjVjN0sjOs6n5n8sc2iLIXd1TS9DuUMv4R0yDU0VFVevcdiyQcqY2UWW5N9bRO9S1fqqerpKpw790TJvtu5Mz90dXQHqr0X2oqBPWaObs5tsE7miRqfjYc03xYbQ1PZ6LCuJ/mfAC30k2TX7G+gnULJ5b4cQv0HOsT7tNIF/KANUJ2+iRmmDN6+oOBwQg/Vb4LfXmGwH70qqdo8xoRVe5uHaUIDJNcxr0PAHNSeT6sHIZ6b51tnNpBdEId171Lgn18k5QUsYBhOFlwsHb0lqhHir4/orjNDmDuIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(31696002)(2906002)(86362001)(8936002)(316002)(54906003)(6916009)(66946007)(66556008)(4326008)(44832011)(8676002)(36756003)(66476007)(41300700001)(6506007)(26005)(2616005)(53546011)(6666004)(6512007)(38100700002)(31686004)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uld3M2x0RjJHbjY1Y1VSdk1mWllsVGVXTmt4YkJNYi9Xc1RpSjhpc2M4SFJ0?=
 =?utf-8?B?STNOMmRma2hWUC9TK2VvcWhEaU16NTU3cXNIcUNjSnZmRUlLTklwWEkrdDZz?=
 =?utf-8?B?MXY3bmprMFVGVU9YN0FKY3pvbVVmc1dPa0FhWEQxdHJRUkNrOHFILzJ3a2Jo?=
 =?utf-8?B?YWlUNVdGTzFwU0ZrU0h3WkZWd2lNNW5Ecm5YWWVTMVRCYU1jemZ6LzBtYTJl?=
 =?utf-8?B?ZWNEdXdwQ3RJclRZRzRmdmUrSGJNZ2VrYk0vSUR1QjZ4ckRKNE1JMnN0TFVj?=
 =?utf-8?B?T3hNTFc4dGNGb1EyMXdhMktrVms0OU10ZS9FRTM3Zzc4RUdVbTBJV1dpU0xi?=
 =?utf-8?B?L3owT0JQNE10VDJDMkdhQ0VlYytPOVFEZGVQYzlUVy9DbHljb3NWcjhYUXN0?=
 =?utf-8?B?WUlSVjRLNFJrN3NnK29JWkdBWkEwdDFMcTBEZTNHazdNcmxxa2N6cS9NUU1r?=
 =?utf-8?B?c3J5WTBaeFdNLzl0VW9CZXNDZTIwc2FFOGZ2Y0RYWFo1aTI2WW1yNWpUeDA5?=
 =?utf-8?B?cDZtOHNNekxQZVEySTA2VEZPdmRkWmVxQnJqRWZrUWdUUnZFRGJpWGxBQnBM?=
 =?utf-8?B?dnp5b0poekFXQk41dEEydnBVUVIxeXlpRDdmNkd5c3Y5eHJ5OG9aWkRsSGtj?=
 =?utf-8?B?NGFsZVVSSXA2TWpKbDJPcTY3WkZENzBveWsyNDVHOFhHM1ZhMzFyQU9YYUk0?=
 =?utf-8?B?cmcweHg0UkU3YWlIMzgwN0daRFY3Rmg4eHU1bkV6blJvK1cyd1JOK0tzR29H?=
 =?utf-8?B?RE51MzVLQ0JIc1ZNZVpoeEx3UDFhNlRJTU1MYUlSbWpEZVlkdDd0ejNjcjMw?=
 =?utf-8?B?NU9XMTlNcWlPQ2NsMnU5YlBOayt6ei9aQlVOT2dMY3kxMWFXZmsrTU9qK2Fm?=
 =?utf-8?B?YlpZWStiaWFJbFBKUDBFeHN0aUZKdDRSdy8wSzRkaGVqM3NYWUd1Yll1T0RV?=
 =?utf-8?B?M05DcUIySHNiZkhuSzErM04rTmM4dHN6NG1TcDc5MFNhQldwZEpBaTA3TWtI?=
 =?utf-8?B?R1dvNjFNVUhWclRaa0IrQ0g5eVJQemI0TmNidThEaEtsTVpvWEpwS24vMjRQ?=
 =?utf-8?B?QWRKemVlcHlqa015cWxYc3RPbjRXb0NrUnJSUjVtNGtHV05nR3lXWDJrcjl2?=
 =?utf-8?B?RDV1ajg0YU54Y0Y4alFMcFlVMEo4TGRSamhnTDdBQUo2RXk1OU9lL25SZ1Mz?=
 =?utf-8?B?bGgrdmswYTZVQlNXNjRiaHoxc2lZdW80L29lSy9WNVdXZW1zQUdvN2ZtT3Nt?=
 =?utf-8?B?cDlVVHNiVVZFQ0pXOGZkL0dyZ3hsZkp4cG0wUVFDdmhlZm13dTZFSzgrVW1Z?=
 =?utf-8?B?eVJjc3crdWk0MWhrakljbzdKdE84anhiTCtiaUlLVHcxUi9WY2RwRW4rOXJo?=
 =?utf-8?B?bm5nUEpQVFI2TmRGOGFodkNCRGRtbHQ3RHN2Zm1qV2FVazNZVlBHSkltUElT?=
 =?utf-8?B?NHBkOVBkbDhqRUNaWHB0T3AxbTRtcWNLbWRDTFRnQks3K3ZHdHZKWHpwU3FM?=
 =?utf-8?B?MDBVMm9DaHhSQjB5eFJlVUlVOGs5OWJubkYrQXFDWEdCRllOdVRPU3RPWGpV?=
 =?utf-8?B?TTU1NnpIa2w0ZGxJb0poZWhldlltVzNIR2FwM3dkUFo0eDByVEl1VE5MTzJu?=
 =?utf-8?B?bWZYRHVDVk4wckRVcCtqeXprV21MMTRNSWJ1NVVDcHRBNURzUUYwblRldFJL?=
 =?utf-8?B?dHBCRW0xQmlWQjRkdkxjQk9JejdZMkE0VWZwci9uRzhxNTNRSWZPRUlXdnZO?=
 =?utf-8?B?cENkYXNLOWs2SXREWGdlM1FGWmlXQk1GNlRMbTZ2UXFSVGY5cVRyTVdmUlhN?=
 =?utf-8?B?a2FYa29IeDVpSW1Ec2dTcXJ3cnd6bktCNVdQaEwzc0w2aHBvMVd3OEc3UUZx?=
 =?utf-8?B?dWZBVEJONkwzWjNBcTBvUTczYkkrcjcrQkV6YWViMUQ1TGRVdWk3aXkweUhx?=
 =?utf-8?B?cXBsK3p4MTRiRnkveUcvdDZTSXNocEJ1a1o5VER1WEZsRlZUWmRKajg1b0RM?=
 =?utf-8?B?MlAwUVpBanJpaWU4R3ExU1dNMEpGSTFPQWZISjgrV2RDTUt6d3dCQWFIZTFX?=
 =?utf-8?B?b3UxZlVlaUVUNmsxdndEYmxteTJoUkk0YkRUMm1lT3VYUml0ODlPZFc4cUg3?=
 =?utf-8?Q?ayJxNYKfTc0TjEN3tGyODlACh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17908d63-b3e6-48a7-5082-08dbe044e6ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:24:33.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cckPI2ww8FjkkcDdVliHZkLB/LhdZ32XFO9KZLlGvK3yiqyC4ngkixZGQUtHFodw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 11:12, Conor Dooley wrote:
> On Wed, Nov 08, 2023 at 11:06:53AM +0100, Michal Simek wrote:
>>
>>
>> On 11/7/23 22:18, Conor Dooley wrote:
>>> On Tue, Nov 07, 2023 at 12:09:58PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 11/6/23 18:07, Conor Dooley wrote:
>>>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
>>>>>> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
>>>>>> It is hardware compatible with classic MicroBlaze processor. Processor can
>>>>>> be used with standard AMD/Xilinx IPs including interrupt controller and
>>>>>> timer.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>>
>>>>>>     .../devicetree/bindings/soc/amd/amd.yaml      | 26 +++++++++++++++++++
>>>>>
>>>>> Bindings for SoCs (and by extension boards with them) usually go to in
>>>>> $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
>>>>> different?
>>>>
>>>> I actually found it based on tracking renesas.yaml which describes one of
>>>> risc-v board. No problem to move it under bindings/riscv/
>>>
>>> That one is kinda a special case, as it contains arm/arm64/riscv.
>>
>> If they are kinda a special case then what are we?
>> All AMD/Xilinx platforms(ZynqMP/Versal/Versal NET) can have
>> arm/arm64/riscv/microblaze cpus(riscv/microblaze as soft cores) in the same
>> board (IIRC I have also seen xtensa soft core on our chips too).
> 
> That would be an argument iff you had all of those in a single file, not
> when you only have a single compatible for a riscv "soc" in it.

But DT (compare to System DT) is all the time describing system from cpu point 
of view. Or are they describing all that 3 different cpus via the same DT?

Thanks,
Michal
