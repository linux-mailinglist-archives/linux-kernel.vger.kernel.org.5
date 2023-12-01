Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D788005FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377872AbjLAIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:41:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF4E196;
        Fri,  1 Dec 2023 00:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeBmWJYevvrdbFFmsT9RvjccYpTLatzxeZ0Q54y9NqjEudCraO/fJyZV+ogkH94AWRxseHdMZBz5MJS4GPAv7T2c7dmcubsxoJIY8NmqYPYjUcp+L2u+a/bEy7UEXdQDB81TX+VsG9VVp1+J5ZZkIORlem/e/KhwP0BUdL9iCBV9E5u5LmK6P4rrZoKoAx5QcRORB+4QBcRZLhi2i58gHDQ62D58vrxEBltCHyMIw6GIBTqJT7amNn3h9LTZrFCfeo++sHG1vrIZ9Tut56dMRPAkYfuc3s5fxT/f779r4exYN9gRnxC6RR+7gjzkvO0nBO+JVrnGLpQxbKN+KLGy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmtM3OtNI4uJqR8bmazznn9KDgVOBJLGQHPJ8F0PFG8=;
 b=Bi013bqDs/18VMPfloWjYH1WzD08M8LIokdr5//mZO1BUNbYzNhPAECzIa2CYbcdi+UA9zxrc/nFgt9m41fSjTZYNhIgWuxQp8iUR4aaxtyqh05SfsXWI3rpwNhdlnnpBndAgUSuFTgwSiONdq1BKqGQsVOuRP/mCepS0gDO9IKFfgKztmpWWTEXwrgjI07IAIkpUBtKRYYlmlUIHgRo7TjYl9XnKlX7dqdHlEmJD6ilDdYJw86AZhfhS1sVyTK/R47dD6p2cOgkOpS7cozWd1wTf4DQSvRSl/0+fwRUYwaZSVr4qCJCOHTPrbp8gCb7uLLngc2z81PbVIdu4OrHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmtM3OtNI4uJqR8bmazznn9KDgVOBJLGQHPJ8F0PFG8=;
 b=esHcHm1yefZCv687OncccitYokIApQQyezK1ZKCoGpsWFYzyQkPiBaTzynU7ILaVqbDUMxWO34o5WtcRA5synmGK/rp154XS45yMkkJB9mRXI180pPBwEp6Xov8lmTvCBlUBaGDKof10rgGxl5ig23DyHWaj1NDC2F4L9qO7p1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 08:41:04 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::8a26:c139:11bc:ebf0]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::8a26:c139:11bc:ebf0%7]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 08:41:04 +0000
Message-ID: <896cb26a-0c31-40ff-b2d6-9e2aaead8ce6@amd.com>
Date:   Fri, 1 Dec 2023 14:10:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122144814.649823ac@canb.auug.org.au>
 <813f3aa2-3449-7264-fa54-eaafd9981add@amd.com>
 <20231128091351.2bfb38dd@canb.auug.org.au>
 <001021e0-2262-49c8-89d0-c0d0720ca313@embeddedor.com>
 <402fc89f-96ff-4f64-ad6d-aaa7ecc284e7@embeddedor.com>
Content-Language: en-US
From:   "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <402fc89f-96ff-4f64-ad6d-aaa7ecc284e7@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::14) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: b243c2ba-eb91-4a68-c4ea-08dbf24940fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuneZl2xuXhteiCHT2IOwmQqo74SruhfWhPosy+X/m1dXYZs+QCgbA2wIN2//q7CLLfQFZ/99TOM/gY/nqwJ1iAFULGmGchpCynomnd5uhEtcIdw8EI8aYBo/Rigt6wDYyVt3NVvWc+pTUqxrj3ekXeGghBnKWnbPcXI3W+vAnfCM1yF4xU2HOAgcsET/wJEciqSXu/kF1G0OZZhJzlWWRSXxFoGL26Ucuklm9dXu1nrnNI4LgKNXxWdKjHQPlX+fR6eT9cJmh+A9MN/JGlQ59CSHhdOStu8IGwk+SICBNMYgZMQ9jCBj+Hi1X8SbqkgbiTEmjGEQD5TQ12OGV/NkaR8OM7F54GdcDp/PQ7TdHSC8PS1bpR0f3O+fAjpiBCXKoTQsJfQSczaez/XaRzbxvrverWc6m/qb7/47FfTToV15BY49PsEfAhk9JA8QWl8RtpcvYz4zVnDiQzS8D2KvQtQFDHziRI7Cc5vG1NLjW9pZ5fJMCIs/dlO1Ub9ZGZobM07iMhtZtcnW/3QUnOr2e2ECDp0xyvkEOL5SsuMhcM/jCCmNxGbY35BOV9RFgBpmnGFvqBjFriiqPKuBWmWq75Q2XGVCq/WmEtoMRFC1j2+dvblWcVTJrcffuYnKsgt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(478600001)(6512007)(966005)(53546011)(26005)(6486002)(6506007)(6666004)(83380400001)(2906002)(4744005)(54906003)(5660300002)(41300700001)(66556008)(66946007)(66476007)(110136005)(316002)(8936002)(8676002)(4326008)(31696002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZS9GbWthN3V4N2ovZnpERWdmdDZzak9vRmRCWmNUWFRuNE9QSHpTcjZ1Z21n?=
 =?utf-8?B?bDY0WkVGRWhscnI4bDU0dGVnZ2VQeWRBZlBtR1Z5ZDYyRVNjWlkzYU1ndEph?=
 =?utf-8?B?VW0zY1VQbjgwYW1iOUlqSE1DK1VrQWIzOWZOTnVaUGpMZmJWQS9FZlBMM1pX?=
 =?utf-8?B?aWpFSmZMUERpcHRMM0tjSUhxanNIbDlsRVlQVjRxS0ZPQXg4NTlpZ2ZWcVVV?=
 =?utf-8?B?ZlpyUHhOa1NKM2hsUjFWL0NST1NPcWZoZDdjWUhJNmVQQWFuOWt6R1B6RnIr?=
 =?utf-8?B?M2JpWU9xdHM1OCtWWnNRcnl3WHdmY1BxRHAyTlUvNDNUdE1DYTFCUHkza3dC?=
 =?utf-8?B?c2JlbjkxcXFHQm5wdlNqTjYwaHlHTkxkOVpNQ2lUZVRGV3VHL1Q4NXd5QjlP?=
 =?utf-8?B?TmxSWTlUckFoOFhPUXZiTnRKbjJwMjArdjJjUmNydTNpaGVmVkRtdDNNVG1O?=
 =?utf-8?B?V0xSa2tTNngxVkNub0xRWVlIa2ZtOGRVazFrdk5rSXZZcStlTHlsdTVPMkZZ?=
 =?utf-8?B?dXR3ZllncFBsY0VlOHNFTG43OWo2ZGVDUHYxYmdrWVZpS0FZMW95Q3dMWXJn?=
 =?utf-8?B?VHZFeDdUUmN1cm8yS0tldzcrdmNnRnA1aElqaWlBOGx0SDZVbC9NdUFLNEJX?=
 =?utf-8?B?NVFwWXREWC92OWJId2JPekpZV3VicXVIS2owTlFBR0dBKzZ2cEdBNFdsL2N4?=
 =?utf-8?B?RkgxdlgwYkQ4Nm5DK1ZRUXg0RFZhREVyMTBsWmR6YVNjNENQanBEa2N4RlY0?=
 =?utf-8?B?bTF4Z1pFdGY5TndHWWFWTmY0b2xNdzMxeXc5ZGZpaUhQZVZoTTAyT1NLOHh3?=
 =?utf-8?B?VEllWWREc0tvd1ZBbTY0L1dGOGRvbUszWHZTSndJMUFVbXNqVXBhR1VyaCtQ?=
 =?utf-8?B?dW5mbjYxY1lLZWs4VFlhTEhuYkY1Smx4RGNMT3YrblR0S0RJQmVBYVNXRjlr?=
 =?utf-8?B?WTEveU8ramxlRnp3YjkzU0ppcVJiL1pJL1pHUmNBRnJHaklhak5nWk5pTDVm?=
 =?utf-8?B?dkN3LzlXSnhTQ3hmZk9aYlFWVzRjZzVUTVRaMWswZkd6TXh1ZVM2alYxNlZC?=
 =?utf-8?B?N0JuQlZiTGNMdStvOUgyS1IySzhPTUUwQktRdG5wVWJFVDF5aVBzeE1LUW01?=
 =?utf-8?B?RkJmR3VlV2pQbDBYL2ZGUEpCUWRtdG9IQnJ1N1Q1b0l2STNqWStDc2QrakIr?=
 =?utf-8?B?a1ZGZnRDa29YZlREYzY2NjhRRVMvNHJOVGxtK2pzNCtFQzJRY1prdnNpV0Zn?=
 =?utf-8?B?Z1VZb0llYS9YUmVWSGEwU005cDZGVWdNY3piK0U0WVhVRmh1Vy92TjZzc0Vo?=
 =?utf-8?B?cDVpQVFGUnNjYlpaR2g2WFBHQXlWSDcvR2VvSUswTm0rYTBPRVZobWlMcnlF?=
 =?utf-8?B?NDRtY0VWL0RkZDc3ckNXQmwyb3FyU3RlMVltS0FnWmRIUHc3NDkzd2RYaTRh?=
 =?utf-8?B?RHgxZEVvQXc2N3RQcW9KSWFoeEU0Rld3SlppTlM4ZzNYWUt6TE0vVmhsU0FI?=
 =?utf-8?B?QjZSMFp3dUNvQS96Wmx5YkpScFFKNlRCSFhydGhmQkNzaVA2K0Y1YXRubFN5?=
 =?utf-8?B?Zk0wZDhZRnM1eWtCRDRJSG5IcFN6dmc1OHlsL1lGTnZDb2lzMnVJajAwTm5v?=
 =?utf-8?B?YWpic1BvN0lEUDJKUk05Vm5oQmpFOEdiUmdMQU5ERW5JSnRyQStIYk5CK016?=
 =?utf-8?B?L3UycmJQRzNWY29JenQ5bU9TUjlUSWxYT2NONmlnd0JnNS9zQXdwZkRubi9W?=
 =?utf-8?B?alc0Sjd1eERhNFQ2OWJuR2lQZUxEdlZCRENEZnh0Z0VYZGI5VTJLOXFQNUdY?=
 =?utf-8?B?N2JCd0RHVDJXY1ovdGxaai9xYlVHbjZXRTMyN3RMNG8ycDk2VGg0Y2hnMXps?=
 =?utf-8?B?anRQMjF3RUNwU2ZGczZWSlNoNERJaEdscVZGV2ZyZWxsMVpOVlh1dVh3dHE2?=
 =?utf-8?B?aEFteGJYYUZXMVJzbW1pbTZPQXhHM1FWN2gydjdMUUJBZHVPaXFNOEQwMmIz?=
 =?utf-8?B?WUdUL0JxWUZzQURYK2pTZ2gycDRUZXRYdit2UVdZT21PcUFzUXVXcGlVa3dC?=
 =?utf-8?B?Z001VHdKRUkxcGs1WEV3ZWpFMFRkaUJxY3hEYnlxTFF5TitUOHJTcDNrQzRD?=
 =?utf-8?Q?rG5G9NEyUGKArjl9Lnkxsi8ow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b243c2ba-eb91-4a68-c4ea-08dbf24940fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:41:04.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93HrHLtEnz1DeP2tU7owaYf32r+2LjUGua65V/6bPt0sZ/Y0c8QAJgYWFKtAWeZlmf2IIk7/I7hxOHj6/g8z3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/2023 3:24 AM, Gustavo A. R. Silva wrote:
> Hi Stephen,
> 
> On 11/28/23 15:11, Gustavo A. R. Silva wrote:
>> Hi Stephen,
>>
>> On 11/27/23 16:13, Stephen Rothwell wrote:
>>> Hi Gustavo,
>>>
>>> On Wed, 22 Nov 2023 10:21:27 +0530 "Aithal, Srikanth" 
>>> <sraithal@amd.com> wrote:
>>>>
>>>> @Gustavo I see you have mentioned it as gcc issue. I was not hitting 
>>>> this until yesterdays linux-next build. I am on latest gcc which 
>>>> RHEL 9.x provides,
>>>> gcc --version
>>>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>>>
>>> Given that gcc 11 is a provided compiler on RHEL 9, can you not add
>>> -Wstringop-overflow for that compiler, please.
> 
> Done:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?h=for-next/kspp&id=617ab3c357d2ebdfff0e1a090c46f2f3f29b45e2
> 
> Thanks!
> -- 
> Gustavo
> 
Thank you, next-20231201 builds well on gcc 11.4.1
Tested-by: srikanth.aithal@amd.com
>>
>>
>> Sure thing. Working on that. :)
>>
>> -- 
>> Gustavo
>>

