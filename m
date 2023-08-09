Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4977634D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjHIPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjHIPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:05:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A2B4;
        Wed,  9 Aug 2023 08:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9KIVVvPIc9CBOTHH9U+5Ai7FX+Te57teXNate7nB562wofwsguPUvi/jdM/ciB3nI3/FPlc626HnowHcXIF1P7Ni7e3ubBIBK3VqdNP9jlhIuR3SB3dxVrQsIhtDED1xwUp2l+oiyJ0Ld5QrrT+S2Jc3XwfszfA0T7ujEaUfPeODMK2tj5ss3NBKAC7NlQuAyYn0pGjctLbI4Syi9OAPa7bk76u6fsooryCv0RV2fwOWjHlUS/NWL9rFlinDTAmqCCxc1WS2RJdqXhpDTAXiFjkbIScl6qqvMaThLrwyaZIlxAb0E+fW+IjlYTJOwURsuf7ydMtDoHNSKfkqT0EUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvEgbWhR2j2tGmDlAX9xZI5sNuB5sYuO7yso6BGdEHM=;
 b=LqvVKVqcnfWcrDc18sXEV14/hIETKW9uw96YHuw7GEQMzQO+jiITIzdc+LESdXmEaycJaRM1xAXkMJ5I92qb8wmgtiBrpsz1G1ILfz4bIdj5LCHsNsWQdVPv5VxS7KCCVv5+xKNejNe4VErMPbgrPadDGBzy9slCRkiX1BB2PtpJInSWyzHrBMrRoz2ioClvjAlPYrRHccYbbUEyc08IUbcDQwktBLcYrlEtDx1i0q+PPL6g5veUFTJF/hUQL7CAHcwUceZiekGlmzEX+AqC14bBBqo3+yBcORXQzAEPd8zLIRkGHD19ET1NOWCWUwQQO/3LVdQGSaCoclc02iTbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvEgbWhR2j2tGmDlAX9xZI5sNuB5sYuO7yso6BGdEHM=;
 b=e+Kf0iHQHEqbBmv+IzVlQCnpy+/GB6oyTuB77AjwNMjS2JSp/Nqa/3AVZfclikqVS4Kunejo7+lE0iocAMp3KpNaaao9GUq246oJM5l3djuLO2SzWN5643Q++l1sQltx0EYmB3rJW21iPVxgjmbXwzEwNvb9JxCuS9KkhY2v/Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Wed, 9 Aug
 2023 15:05:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:05:54 +0000
Message-ID: <5b3c306a-059d-479f-8ad0-c914de8a2def@amd.com>
Date:   Wed, 9 Aug 2023 11:05:51 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
 <a64fe3ad-cb2a-3816-fefe-700433926492@redhat.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <a64fe3ad-cb2a-3816-fefe-700433926492@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0795.namprd03.prod.outlook.com
 (2603:10b6:408:13f::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: a34185ca-e9c0-4311-bef9-08db98ea20c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQyVtr5xbxECU7llVfE4bHWJGzfBKRJYD2X1if1/Iblk35nEy0BjF2GVP/o60VrmwlsstJjmVvJ5VBVgXdFOXMw+UX4qT9MS0kchJMivdyKBaTqFaRFWsF92/5eR3ePLE3hTL9DZKrCzxTujE6sHP6dR9xvpI5wfImUXZdGFikcTNw9TqPOyJO9oj7Dqam/iSTHYLgZZgI8T76eMOK5bqL29r+Z5uwZWIk3LVj0AQuVrpejaSzoj3mIIAq+lGcFCJ1VdM5NXfyZUw68rASdw6tA9tcgOvnpY+6LPa9WVs7JDjU309t94Wj9wmZGuEihl9bw5U5YEisFhVIcQhH4RGCpx2Ho4hR41XvSR/IGBRQ0ZludwMoh3Cc2oCPFxqVOSSYcHisQuH6Xi/iburJi34RO8NADBWYsEzdYgFQTSPDw0S8w7snH1AlQJ6wmYQICwFZCr1sxDvXu1LZQpuCNVB4f1taQB/H0S1S10hnGzef+JLrMniMEjL9h/K3djJr3NiNcPCc/n8Aps0v4+r7Y5FwIOQ2gr6R8sk988JBveXcUxZ5DKSDCz5E2htvhDnDQbAyQQ6aWptkYhH/n2tgM/toVVQOzhE17NZNSuyFxZCkTfVNV1GPjxzYCJPTWxnJIj4ql+kY+LV9xmVPK4wfFlCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(1800799006)(451199021)(186006)(2616005)(36756003)(6512007)(4326008)(6486002)(53546011)(6666004)(6506007)(86362001)(38100700002)(316002)(66556008)(66946007)(110136005)(31696002)(478600001)(66476007)(41300700001)(26005)(8676002)(2906002)(8936002)(44832011)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2k4UXJpS0pJL284dUsyTUVaT2JuMlpYSTV2bmhkZTQrT2JXWStoMXJ1dzdY?=
 =?utf-8?B?U3ZYUStUSGFjUG1mak40K1lTeTVvTmR4VjcrVFdkUW5HeEtMVHRPczdLUXF5?=
 =?utf-8?B?Tm1UY3FnUWdHVW9GRzkwVVdoZTBhOUQycXVCanhVc3djMkhZcTh0T09Wd0N0?=
 =?utf-8?B?cW85ZjZSZ2poelVGYWhaNVUxRmRDSWE3L0gwMDdQdjE4RmlFZnpqMnJHU0tH?=
 =?utf-8?B?OERiTlFjSmFUQ3AzN3JQdEdEYXNYK21ISnQ1dWVzdmhvaXVvSHRKM2x3aWgw?=
 =?utf-8?B?dXlmTkZMYnNvclIwZTN0ZVA0QlRrdG5WUWNvaEx3NnUxckNLTWhoeERuM3o4?=
 =?utf-8?B?eERTWFRzakVJbnVTVkNVRjRtWFh2OW5tWUNKRklHUE9HTXp5eGNYSVhGRXNO?=
 =?utf-8?B?R3duUnNkOTdDR2FqTTNmSjdPdUhvbEdUUktSaTJ0dExFTFB3a2ZVNURmTmox?=
 =?utf-8?B?RXhscFVCdGNXMGJyTVNhOFlzc3ZMemNBNXlOdG5odTYranRvY21NOVp3UVdl?=
 =?utf-8?B?REZRZXFBVkJNc0xWTVlYUDBPcDMyUXp6UWJEVS93V1lDWWRxeEtLV1NsQ3FZ?=
 =?utf-8?B?TjhQRWc5Y0JzQy96N2dpTk5qK05FU085NmpjemFIQTdWM3N0WG9wVVVOcHR2?=
 =?utf-8?B?TENHOW42djdzUXBtNDF4Y0g1SUc0aGdDa25NdERFdGcySWl5K1Y5RjloOXBW?=
 =?utf-8?B?bmVKdHVkYUZkSmlzRlVtRGp3T2pNVE9sdmQ1blB3bHhWbVFFZ0d6RlFBSncz?=
 =?utf-8?B?QmpqTGc5UzZYY28wTTBBaVVzUzhzVWM5K0IvS0RoQjFwbDJ6cWZ3cnBIb3o0?=
 =?utf-8?B?V3k4b1JBK2RSQnBSMGU3dHp3UTlzS3hMOERYRlNXYmVZS3JneHlyWXJYenZH?=
 =?utf-8?B?R2c3ZlFld0NZVmxUdml4YjFOWjh5TFRMekVJSjdmc2YrQkExRllvWnErYXZQ?=
 =?utf-8?B?bXRrMGFEa0g5ZjVseTJlN3AvV1RmcC8rZUt6THMvdFNzWmdzbEVtREJOMGlT?=
 =?utf-8?B?TFROcVBsYzZtblpwSUNSWWY2RTJZTktzSE1URG5BMnI2SWI3MHl0ZTlLREc0?=
 =?utf-8?B?SlFGd0lDV2YxR3NEU04wQWZna2YwRzR1cHY4UU5RaURGVnhQU1pYOTZ5VlNn?=
 =?utf-8?B?dWZlWWs2eXk2SzF4KzNPaG11Q0pzZlZMa3JqcVFJemdHbHZvTHV5aElWS3lq?=
 =?utf-8?B?YysxNGNiZ0VyTklicGQ5d0pOc1YvNjFkNzFtdFI1R3FMcVNrc2Nra0w1cHRs?=
 =?utf-8?B?OXVaV0x3N1pMR2lTZVhIVS9GOFpqT1BRYk1ycHFod0duaHBoc1FNS01JMjN4?=
 =?utf-8?B?WHhQTWpMQWlaM0psWUxESWRtVXFuWWgrQ2ZRMUZsRTRFY2pSd3J4TUhhK1ZQ?=
 =?utf-8?B?SnlGOG1JMzU4T01jdU9UWnp3RG9ueVFzdkZBcHBvSWRJSFlzYitaVW1tZGFS?=
 =?utf-8?B?cThQMU5qU2prTTkzS2lHSUhFdDNyUzhURXBCeVRvQXYvOEV1UEtkbGczM0dw?=
 =?utf-8?B?UE8reHRtQk9MbEhERloxRG9la3NEdnhtb3lrdE5MYkQrcjdHU3Rkay84aGFy?=
 =?utf-8?B?OHk2TFIwS2V5cmFObFdOMFV0QTRtQ0d4SEwyODBGL2hpSkxVSHBXc3VENklo?=
 =?utf-8?B?eUk3RisxL2ZKeFgwSHZ3N0hSbkFoMU9nVDVlcEJXeEs1cU41ZEFIYnZzYU03?=
 =?utf-8?B?S3ZRdHlZTHQwd0lyZVk2RWsySVJqemxSakNFRXJqL0JpWTN5dTFXcGNuWldX?=
 =?utf-8?B?Z0tpVHFUZ0dqSTJzbWdDNERPSXphSitoL0ErbFJtamFxNlhvOFlOWTdEK3Nq?=
 =?utf-8?B?bFdmb0hXMWRkeVVtMjJRT09UaisvSHhadURPb2VyVEZBTUFnb3cvZnVYQll4?=
 =?utf-8?B?ZXBqTTFpZjVmQ3BQUS85Z2VabFlZQ3ZzSTF1MGgrYkk5ekdLS2VMRjYzTFFP?=
 =?utf-8?B?MkxDZlpmL2p3VGh4MkdzbCtyR1NlKzVrN0ZQd1FXc2xoY095d3Z6VDFCWnE0?=
 =?utf-8?B?NXpleFg1ZzBzekQ0TUZGK04vcC9PK3dDakNNUDZreGt2cEt1VndUd2pYYU9X?=
 =?utf-8?B?QStDWXlPVk1YZUpWSHFBM2hOSXRrai9GNlM0aXQwU0EybWs5NVVxc1ZFVi9t?=
 =?utf-8?Q?xVsfAs4BE2VO3iDS/+feqRQfZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34185ca-e9c0-4311-bef9-08db98ea20c2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:05:54.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqnBolqYANG0vKLAtwYk5NS3dYpguZ1/gcN8cDVRnjEk3piZywbJBgybrN/wpldIHfOPcOAPso034ftDAZWIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 10:38 AM, Hans de Goede wrote:
> Hi,
> 
> On 8/8/23 16:07, Yazen Ghannam wrote:
>> On 8/8/2023 8:10 AM, Borislav Petkov wrote:
>>> On August 8, 2023 5:17:33 AM GMT+02:00, "Limonciello, Mario" <mario.limonciello@amd.com> wrote:
>>>> Given it's 'library code' to be used by a bunch of things and also want to be able to use a module, what about putting it in lib/?  There's plenty of library code there as tristate.
>>>
>>> It is x86-specific so not in there. Also, it might be used by multiple things so you want it as a separate "translation" service which is called by other modules.
>>>
>>
>> There are modules in arch/x86, so I guess that's not an issue (not sure what I was thinking).
> 
> Right, I think arch/x86 makes sense.
> 
> As for putting this under drivers/platform/x86/amd as initially suggested. That means that any code which wants to select this because it needs the functions also must select X86_PLATFORM_DEVICES, so IMHO it is better to put it in another place.
> 

Good point, and thanks for your feedback!

Thanks,
Yazen

