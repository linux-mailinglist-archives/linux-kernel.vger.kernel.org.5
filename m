Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5557F3602
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjKUSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjKUSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:34:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D5BCB;
        Tue, 21 Nov 2023 10:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBXPerE+gAi0cGARAIMTWW7IlbkT8WSSE6CIf28qZKTHM91QpefAQYhBBFsf5QRXZU+vVztdCs+61splstvmd12HYXlaqfPwMDyzeZFSwXiLFPjoGeti6JvGlhQbizCIAbrW9XM4eOoun63kZT/P6sxdqjj9mJgN4Pyu59DcRIVzfA8EsbHyVnAR1j/4c+9wH/RgTjLpgkknsO39KQlYGLYbP2ErJjPvN1T3HLdq7Hw1FsILGPkBaCYHreHNrf77szeP/1FuHTlZTEG4uMMLsyORo3sfDwgyVQWx0elNkZ9CgqEEW37ucUruq4mhOeDuRbm1/fpRs9OtptzK0nmljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgVramYVHNXHg+P/aTYoHolJg3xDYfAB/e/aLi5bvO0=;
 b=gsErkT+tub5WuVD5YkZBiYeXWRMsg4cW+AZnj4qB+OFTlTAmyYTbX4Moe1kQY1mh0lTstx0pSThYdOMJM2+7DxFg0uC+RrP1LDhE3zvoYk1hhfa86GVmG7C+KTlV3ukWJo9xvb/Iae7hGYfGIZQSgAJC5wWE9rN72csDkha8hxBQDHuW9JzLjM4ydJFNhoP2ZeEPEhFX64W0fc+XCX5yjWGaaBfCotikE8J53pF9n7jEKzkwJN08Rme1zp52z3cAdyMA4tyRDJMMIuceuqp5tVrwCG+iuuFdrPg0CCMoXikdOXrmll/SzEMcnhFoNMQO+7De8mUdvjW4amfpli19AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgVramYVHNXHg+P/aTYoHolJg3xDYfAB/e/aLi5bvO0=;
 b=r/ezeevHAbeTm+rvNvNIVUSsoSY+0ppJ6vRetllZ9go9Sd2k5Wozx6YmyH3aRVsHX3ZO4yR/7mtDYcJfy83XBOBLGrxjYVaGZl/23XDUplcKUTnw+VPEBRakW3UZyLlOP+zkFP9GS8uKKllYzKs5d0xWjx4Qga621isrcZ+wj2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 18:33:57 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::54bf:1f5c:daa8:e1f1]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::54bf:1f5c:daa8:e1f1%2]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 18:33:57 +0000
Message-ID: <5636c840-5385-8d30-0b23-fdee91e90136@amd.com>
Date:   Wed, 22 Nov 2023 00:03:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch] thunderbolt: Add quirk to reset downstream port
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
References: <20231121174701.3922587-1-Sanath.S@amd.com>
 <2023112111-shelf-deeply-6a03@gregkh>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <2023112111-shelf-deeply-6a03@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 35aca5bd-eee6-4e5b-0191-08dbeac06c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agJV+0OHSITmzURNfvVUUXZBCG/cFu9V0HCH05FldJj5EjAo+grOtoauYWW+NyTtLA+ZlVXIWkfk4I3Wn2dlShWZ+np7eDrjryUDuKRmRdQMreGbXyGIT4A3BPXNqGx9ZA7dlWk9OCwRYBdfaKgKnca54MJMmzvkUaLgGtB1MCUTMcYCw8sDKmAYbLtMm+7MLiI4jNNYynl1ehQuzpF82G8Y4OOhKdxtnfLzdwR3gWz4ygDeEZGv4zgRunPZKcQTEQoIdQIMJQJcUhw43hZs2oA1YXih42dqhJjl4J+9bEhH1Aqr0e7mOGV2uq7fT36zoRYRzGhRxZZeHD2/Nedvm3BioN/0I2kwwMJT8md+gkWA+612QDqOcr2QgF1xSRBgvzqfMmujPUt+e89Lt7NbXLPoFYsND4D2W9Do4REjXMPCC8kEi7frJyP6UmKP0eyPR8YsgbTVJIjo19QBApntzRDyxEDY7rFWs4cvWzDOCuUhe7sxLlKOQSh3YwS646Pw3goSGBcYuN22FYgojSkHgtxB2v5FAEKvY1pkaO8qgg+QGbLkbNn/HdhDNlp5xqVxmDSSbCfrLYCMNbJjtlUmGKgh2LpQBflrur/ct6Eq3rqoWne4iHrzqRqPC79nITx3ZJkx8mhRq6g0tL6BogY9Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(53546011)(6506007)(6512007)(41300700001)(83380400001)(26005)(36756003)(8936002)(8676002)(4326008)(4744005)(5660300002)(478600001)(6486002)(31696002)(2906002)(31686004)(66946007)(38100700002)(6666004)(6636002)(110136005)(66556008)(316002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VJY1NDYmx4MUREaWtyMlhRRHRTR0NQRHhIWm41bWlxZmpoeGtubldEZFd3?=
 =?utf-8?B?M2hHd0p5elNpdFNiaEhITFpHZHRWQlpZV0J4NDJCWWQ5OVI3Z1RvWkxnUk9K?=
 =?utf-8?B?MG9wZW1ZWEdUNTN5eXNSOURFR2FxbEZWT01vckczNHNiSEhoaDRxUFYxTFh3?=
 =?utf-8?B?RUgzdmNTZVB4SzA0RkdHRXZYVHlIWVAxYzZ2ekVCMUx5NzdmenVNWEJEanhN?=
 =?utf-8?B?bEFGaGt4Z3BjMW9FU0EwY29YS2U3K1ZjTDNZeGkxTk1hcHpRS2U0aHVVME56?=
 =?utf-8?B?YlBpRWJmYUJwN2VYRFRwWUxKSSs4Qnl1RUtVUEFyRWJSOFRqVkkzdllxZU1R?=
 =?utf-8?B?T0ZpaGY4ZEF5NHF2OE9EUTB5WHM3cFlTNE9wREFObmxESnU5ZklFRWpheG9n?=
 =?utf-8?B?OTd0U3NpWC95RFQyUkJ0UG5qTTVFbjMyNmZVRU1wQmFZbWJMS29pQnZRNjRx?=
 =?utf-8?B?U0w5dzE0YzhRcVg1TlRvZDUyMkIvZG95c2Nxd1lTWXE0T2g0REdmeHVUZzdm?=
 =?utf-8?B?RDRReC8yYXV0aGxPWlFweWYyaTRnczNKZjd6THpwSk1tYnJoeXEyc0NVdXZk?=
 =?utf-8?B?ZVM5MC9Zd2xnQ3NiTEF2UHA0aFJQRW1nUHBhQllqT1JSTEJLZitmRy9iSDNY?=
 =?utf-8?B?TnRpRnpuLzhTUk5BMktIY29KOXVPRXpYSTQ0bmE2YnhtWG5ITDREdUtVYS9Z?=
 =?utf-8?B?c3NHMUpacmZaR3V2aHR6elcvc2lQb1VHbjUrZnJOU2xKa3FEZE9SWGFZRTJm?=
 =?utf-8?B?bnFNVStUTU5JNzN6T0dXYmhHcjlMbUQyUzJxVGRkV3VreWFzT2xNVExmaGpq?=
 =?utf-8?B?TUNQKzBPVGRGVkxqaklsRjh3cFNXeXJzeCsrQTlRc2hTM0JRRXRVR2VQRUNX?=
 =?utf-8?B?bGNPQ3FLRlJTeWFnb25ZeFRmNk9oQkx0M1hRMk8vUEwyK3dvUVNMTXF4WHBw?=
 =?utf-8?B?UXlJZmZ1Vk1EV25YVlp6U0RnRGFUTE1Ca1JmcFNLSm0zNjVFRDFORlUzRDVM?=
 =?utf-8?B?a1FLTTIyTGtPOXlYT0ppUndGai9kQ21wSzBWZ3JzVWJhOXcyWUwrTkZhVmxY?=
 =?utf-8?B?MDlsYnRHNFM1dXRNeHBnelNvZE5wZnA3OEJxbXh5ZndyaTNiSlNnUVFyVFJv?=
 =?utf-8?B?MEFUenlVUm1HTmF4QUxCODlGMTJZRW5MY2xzd3lGQmtsU05jV3ZMMmhvUFc4?=
 =?utf-8?B?YXl1QXdWWFpoeEVGUVMrSW14NEhrV3hLUlltc2NwbTg5dTVpMnlSNXJONEt0?=
 =?utf-8?B?b1ZiL3JDeFkyRERCdzZLMWFXK21yL05neUJQWDhkV0w4NUpUMWl5LzF6QWhE?=
 =?utf-8?B?UWI3NlRtWlNtRVZWQ09jU1R1bk5sY1NibWl1UUZKQ2RtdFBRcmx4dWxpUGpl?=
 =?utf-8?B?N1RzT2VNWlRvZ0E0N0NUckJQdmdQQjZXRlJwaXlCRWdvVWZOYWtUNkF4Ni96?=
 =?utf-8?B?Q3E4ekpPbHpXaUNPbTRpRW5FejFGcUwrQmpIc1VXc2RZMy9tUWlUMW9aLy9u?=
 =?utf-8?B?WWpkcGtnaGVBVTIyYVVTMW11VUFzV3VpeU1wQzB5d21pdHB5QkN4bUtydXhQ?=
 =?utf-8?B?VGk2Nm42QjZaN1FZcWZ4TXBId2pGazd5bTZ6YnZnMTY0aWhqTWpkOVNDS1E5?=
 =?utf-8?B?RnZIK292RjYxR09KT1d0WERUTUd0NXZpQStOZEtKV3B6aTZIYS9tRFRVa0xI?=
 =?utf-8?B?eHJsNTFvbzlkZ2I5a2lEWk1KbmlxeDdEVFRESzJJdm16MkxScEcrdFlhSlRL?=
 =?utf-8?B?SUluRW5DWmNrdENpYUZFQ1V6c00yNkYvK2YrK0x5RTJNenpzYXhreGpwSTIw?=
 =?utf-8?B?dVZ2M1pEeHVnWE5tRjI4bFJ2V2J1SXpnZDJybHEveHdENmlLWnZ2OTc1NGhN?=
 =?utf-8?B?RitjYW9xZDdjeHE1MUo4ZWxrWjlRTW0vZ0JPTGk2ZUdLN3VEcTdiaU5XZ05i?=
 =?utf-8?B?akdvNW9pUW9DS2I2ZklvYU56SGhRdithbDdlYkJ2MlNDa0FwWndrKzcxYjk0?=
 =?utf-8?B?dWhYeTdRWlMwazRWdG42TnVNYVBXbm9VU016ZGZUUlN1bGJ0N3EzWG1RNWpw?=
 =?utf-8?B?Rnp4MlRiZ2JBbzFEcWxEY21NRWZSdFhlQVpPckV0aHZpOENtalNvcHkycDVJ?=
 =?utf-8?Q?QzI9B33CcPPPSmfNcTPkDKZOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35aca5bd-eee6-4e5b-0191-08dbeac06c07
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 18:33:57.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv+FeblfqEmP+TQRXHqBgu58h3+bRU0EMWr84MtVWBzcDzjGOWQB4Z7G0EpzXGGEbdTDBjMHOysBw55Qt/BtDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/2023 11:34 PM, Greg KH wrote:
> On Tue, Nov 21, 2023 at 11:17:01PM +0530, Sanath S wrote:
>> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
>> very minimal buses for PCIe downstream ports. This results in
>> failure to extend the daisy chain.
>>
>> Add quirk to reset the downstream port to help reset the topology
>> created by boot firmware.
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
Fixes: e390909ac763("thunderbolt: Add vendor specific NHI quirk for 
auto-clearing interrupt status")
>> Cc: <stable@vger.kernel.org>
> What commit id does this fix?
>
> thanks,
>
> greg k-h
>
