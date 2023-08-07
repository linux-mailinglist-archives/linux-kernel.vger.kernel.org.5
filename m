Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B36772677
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjHGNsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHGNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:48:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702792;
        Mon,  7 Aug 2023 06:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IspSmBEB9AlOipFr3b7tW6UPvsRIOQoRe/JSnwemWJ5eUsHgcAGB5XuU3mwDLBlvZSjL0HT7FG7XKJIjU2Wkr6+cwvc1SxTz83V5FIvnPIkiAGR74LcLEhOJ1NXHpiuUC3YvmIgu10lWP21JFv7sRmLdls4dUGjOOtgCAiFogJMUL08Zj6RGyOQxE7fzi7leLwkIkjoSkcmQKXgbOlVXiB7jENAQ+E8JuJ/cRO52gNDbKadna/hXRrUiTdB3T8jM4Sc4zbAp4oxguuqKDSmU3kves1OUidALKEPvPysAIlwd/gdWpgcKWD9mMUa5xWw8NWu16JT4E2dA29eVU3LqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BytISkmjpAH6KfmsJgR78EKVLtJcJDEV2niyn1qBqcI=;
 b=GZCg1lbPzVA23TdsQYSEuD7c6SNrf9ZCIiKlDKD3GtUB+UIQGNMp4UOkW6hx5NscWACmDGu/9j4BJ0j2KY5osfSEh1hl84ya8NIfW8C92pRD6IQRUo8iIRh67hk5rW+EBIdOtFNsyZOiAurSAuefK+v9njGvUOc6mN12Ou7LGYQHdt0UNCJZ+VrzAsvxzd3nZMUm4rjjfjG658uuM2tgSezgizCMY6jlh09Ifvfo0DomyfXli3IRUkzc4PSVG1IczSck0etJfOmrNRy3rNJEMLomz49wbiW8VAcAlJkKPzVlchDVmHHNTl0DuRdPzGh+r8EfsoHybL0mzuN5OjxKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BytISkmjpAH6KfmsJgR78EKVLtJcJDEV2niyn1qBqcI=;
 b=YnocewIz0yBEr5MUpT3LSbgi36YLyVvwLzDP5KTGmHfKMc/pLIxwju1iELUWvKLho4+htGzoW8d+KpPjSxyWyWQaISluPzwwJDMch/tAcdBQ0wVBSDkDPzYObtmVLhG0vxPaHmsrxqiJkiJ5HZouNzcZ9VAh7WmVPsTTAxGwHaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 13:48:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 13:48:06 +0000
Message-ID: <36bff484-f41a-4eed-bcd6-a96539b905b8@amd.com>
Date:   Mon, 7 Aug 2023 09:48:07 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        avadnaik@amd.com
Subject: Re: [PATCH v1 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models
 00h-1Fh and 40h-4Fh
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>, bp@alien8.de,
        linux@roeck-us.net, x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
 <20230706171323.3722900-4-avadhut.naik@amd.com>
 <e5b0063a-ae41-41ab-b3a7-2084dfa7f816@amd.com>
 <1606f9f9-5d5a-788d-b058-ec218fb73712@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <1606f9f9-5d5a-788d-b058-ec218fb73712@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:408:142::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ef88c8-07a8-45a5-abed-08db974ced90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feORX1bqtSOi/6m8IK+VT0xtuVBD4sE9pC+wxVWLACzourijJrz3x7zb3Dpb3PlG02W79m4DxdyafZVVPRwqlvIXQ3dhBNo3GZ+xfbfSm37ZBnpCVM4nWQBBKAMHWaw1bIFhptXMeFHCFIxmM+6g0v4E6qeuc2cwJKDpGVsjIMeIBxmCy0qYD4UV0QMaGYPu38ZGdX9RlpVqT6LHe8U28z39mGcSLGoFOsRxTdGx8GhIgEqUGyZ++yq4mibD4RpO1ptznEvc7FiUXsXhSYlLScSfEdIjcNjBgP01IZCPZzAb4CbNcGhefl82UER0ywSS9ZPaOW3hydiienpsaXeFXbaafjYlAVB+GpPPmdOFtqSorZu/LcUBATBmx4b/dGN0U51ZF9CxC7pwr6PHcrXWOzvhohvlzoHP5hEUf/cqlpVIW0fbHT055kHIWL0UL8rVjt+YOBRljQVsNO2YPNTS1KWWUTBwQNbZa0D5CNOnzz/n2QfOyHwged0Qs0ZxjIuFtSkAi5Tn20yVice77mfhPR7/d08LyJcN/VwFqpKGU/mKrWonSoPrmn7vUqN+ibSq3JszTHKQ90CA8ecVS+iAMVohO7WT1uXVRDExY3WotwgbSgGgrJlTGuqg2kYf7j6a1oCIinuGbFz0XpWhj7heVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(41300700001)(26005)(2906002)(5660300002)(31686004)(44832011)(83380400001)(8676002)(4744005)(8936002)(2616005)(86362001)(316002)(31696002)(6506007)(53546011)(110136005)(38100700002)(6486002)(66556008)(66476007)(66946007)(478600001)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OCtGeG9lMHc3dTgrSTdyOURtL1p6MDkxTkNPR2ZkdWxOeko0bit3T1EvVjBx?=
 =?utf-8?B?VVc4bTFweU1lVE52eVh0dE9mYlEwSjVDRGxqNlRjd1RqWGx4ZnBrWmN3VEdu?=
 =?utf-8?B?UmV6Nnp2OXZUdFJncjBYRDZ2cmJlakpKSXY4eXpiK2RrdHBaY1poaHZIbWZx?=
 =?utf-8?B?ekVPMW5mVHZBYWk2SjdOSW82VVJueE41OGc5R01NSmpRbUVaQ2N5ZHFtOFhO?=
 =?utf-8?B?UGNVdTFGbHdIMzdSNUR1RmN4Y3phRzVGY3gzaTVKTktiMTdJSmszdkJVQSs3?=
 =?utf-8?B?S09adGFwd2k5cHM5ME5KdjdYQWlmOWNQZ3l2RGprbDIzSVUwd3NQZFhzUzJl?=
 =?utf-8?B?d3l2bXExRnZ4WVJuN2gybTM0bHk2aCtDQ1ROZExiU2tCZDlmcHpFNnNNQW00?=
 =?utf-8?B?dGErYytPR3A4SnFWYmFRS1YybXk5bzhWaTJiZUI2Y09YNTJSbkxLOU5EZ1k3?=
 =?utf-8?B?ZWs5b0U3ZmswdEVBc3A1NkJCbnVSNHYrckRFczJMTG9wNFhhSFBDVDF2SXhs?=
 =?utf-8?B?MXlYVHN4Vkt6ZVRUNnVJRmV5Wlk1YXhQQ2Z6Y1NXV2psa3dzY1dLcmVYMGla?=
 =?utf-8?B?SjZMODlyei82SWpsV2ZUSWNTRkQxb1JIZW1meWs0aXd2bTNFU1BCUUZMQXdO?=
 =?utf-8?B?enlvTFhHK1A5S0xKSnhYQ0dFM0dDS0V0bU9vS1B1NXlsRzk4Z0lXMzhlRkM2?=
 =?utf-8?B?YzFZQ1BDY1MzYjk0NGw3N0hmTU9saDZDa1ovWDNtV3JUZHU1VHJiM3V5L21h?=
 =?utf-8?B?Yi82WTEzS1ZSVzZmY0xVS1VQYlBvcWd1TEpacGx3Q3NNY244ZTI4bFVWQjdq?=
 =?utf-8?B?NlJuMmpNTGpRNUVKRVN1d215MUcrZWR2Vy9tMitDdHlPdWlYZWJlekdJMHBh?=
 =?utf-8?B?TlI5a0FlLzRjaVNrM1NwRWQ5aVVNNmFmTDlSK3krUUFsSUNUdE10QkZaSWNT?=
 =?utf-8?B?ZXZXcDJDN2RPamdZcmd5L3BTSU1DNVcvem11cC81aHhjTC93NXFpSTNwLzVY?=
 =?utf-8?B?a1diT2hLUHdkNXBvellYZWUvdS9vSWNXQmVLaWFQbXJIRU5zU2JBYVFtSmlq?=
 =?utf-8?B?QmhvNVVKSzVoVUxtbk93UXJzRzBqSHc0dGhLbXhuS2prbmg0ek90NTFlb2xK?=
 =?utf-8?B?UTd0alRFNTEzTGR3Zm1NMjRmeVhMaEFnblpRclpROVFuVXdDR3ZudVFTVnVM?=
 =?utf-8?B?dHA4VlRGT05kaDZpVXdMWEtBck14NXl1Y0xFM3QzbkJEeXNMVkVORzJWelho?=
 =?utf-8?B?eE1vQmZPeTZYSVh2eEtiVWFiSjV5bVArU2g3V2tIbkdRRHFkSWZQRVJJR1RM?=
 =?utf-8?B?V0RlV3lYS0JiNWtvakJVWG02NHAxMStHVVV6U1F2SWEvSGtCY3N4bERPYlBx?=
 =?utf-8?B?cGVPTHUyZ0VkbS85TDBBeFdUcU93ZmoxMVhkamwwZ0RsSEJnUVVvVXFSdmlB?=
 =?utf-8?B?SzJuYnJPaURrcUJwTkV5eHlodEZZSFUydkorVjB1VHZQSmUrbDFYVlRVK2Ja?=
 =?utf-8?B?ei92b3BjNmxQaFVSK1VXbmVrVkYzN28wdXIyVHJ6VnAwTml0ZVh1RkNMY0g2?=
 =?utf-8?B?d3Z2OE9icFMrczRWSmpVbGovRFA1UjFGcFZPemI0UGRHUjg1aXlDQkdsWER6?=
 =?utf-8?B?aXBXWDRUblBuNFI0N0hVakR3UXFuRjBlU01uUDB5Vkw2OGFpemx6TGRWWDEv?=
 =?utf-8?B?ZXhxT1lHWVBWemE2UkdSeGNrd0dZa2czZC9ranFTVHFYaCtCQmhjYWpFcmlr?=
 =?utf-8?B?N3dzZ2pKaGNDRTREWEdOL05qZis3WjlUaHRQaXdNaXhEcXVLbG8vQjZKR2N1?=
 =?utf-8?B?SjFrdzhnbmVveHowbG9ieFBrQW5zd0FjeG9oczRPWHhPQ1NFWkxRMVpidlRt?=
 =?utf-8?B?NWd3TXh5QVVqSjkzWUYweWlkT1dDNyt5TWJneHRjMzNmZlBMRS9oUWR2Y2Iy?=
 =?utf-8?B?NjBWdVUycHJsUnJrOFpCY2d2dnNMbm83RHhvV1NLeFNidWkxVHBsTDg4RWg4?=
 =?utf-8?B?aWpMb1dyL2ZrZHEvTVpRODFtVE45RUhXYjZVK1EyMUdyS1o1Lzh0NVVQNHFT?=
 =?utf-8?B?b2tGQnpTRkhOTkxLdjJ2anpGREpsSE5zbVpsMDhoYVF1VFF0ZGdkZm1HZ2gv?=
 =?utf-8?Q?xZ05ttM3A/3prhjWVsPO0n4xb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ef88c8-07a8-45a5-abed-08db974ced90
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 13:48:06.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m9f/P6Y3D8ioPVDGNMazDpUdrrA6PDsRmWrEV0NiDgcZHRMyNbwb4v14oNgvugBJ7+pZ1b3Y3BucIAD1um70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2023 12:03 PM, Limonciello, Mario wrote:
> 
> 
> On 8/3/2023 7:25 PM, Yazen Ghannam wrote:
>> On 7/6/2023 1:13 PM, Avadhut Naik wrote:
>>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>>
>>> Add the necessary support in the module for AMD's new Family 1Ah-based
>>> models 00h-1Fh and 40h-4Fh.
>>>
>>
>> The first patch in this set adds PCI IDs for models starting at 20h. 
>> And this patch adds support for models 40h-4Fh.
>>
>> Can you please elaborate on the discrepancy?
>>
>> Thanks,
>> Yazen
>>
> 
> Model 40h-4fh shares some of the same design as some other platforms.
> 
> The root port ID PCI_DEVICE_ID_AMD_19H_M60H_ROOT and DF_F3 ID 
> PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 covers it.

That's fair. Can these details be included in the commit message?

Thanks,
Yazen
