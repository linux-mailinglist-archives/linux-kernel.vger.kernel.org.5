Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D777D83C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbjJZNnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:43:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39448BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdwMx56NOnep+OvwPAUOoNRr6wd/FWNgADOSgasyyNQlxBkk9IBZb0Odcj2CrtfrwDX7VR29Bnrq0uqeUWJBXodrwdGf3RwWsehnQA4PBIMDX4XV8JYDlfvV4xzo4j3i4RVy1iEEEOcao2bFOJb6Z3N9nhEIwgd5UlGRZ+uHpAp59IO74o9pF8VYJ65jALv49owYJ7syB4oI02eE1DnlqicsbWG+tLTkg7fvhdwlPhSDCtgO4atUWPHXtTCr4HGa8EWXoE+HKD9rOVE3nbgo64pFSzICN8SqaaiDj2a0cFyMRA3uGu8Nrpb2fJrGd+LBQ0+wt+i88vETmELcUHdTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E7rxbrdAI9psMB5AEqymjug5IZdFAwnwj8LaN+WZng=;
 b=PBgRZ+BKD2yqWDbCbdy62I58N/PzkRRfdx2XQW+PeEgNETFfM9FH6rk49c8cHcPQgz8wR0/h19rzrg4Zbc5F5KgH3N16+hwVwCTzo7oTBMm9O+aLcNX+j19eF+P/CZYO4MWisU+gT+8lDyf40kTdOfZ8K8QVFDuzjL1kEIJ8PfbqwV8QvDkWnP/QljbgjYjKzsAV+nIwhdoAxaxzhunYycS/B7PSTQsD0C+dIH2D3KOOZqj3C84Po3phwEBB2BYN2vG1vmFTU+Mm0vavcvVrkmkveKw/IEAq2dD/95ZtYVzX27IRrDT2SMqBdl8+oJJOarm9VaAQBdiEM6g8eBcJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E7rxbrdAI9psMB5AEqymjug5IZdFAwnwj8LaN+WZng=;
 b=T+bv0Dr5DcQUFFfFGIhKidB79i2PRpYfY8jAm5r3oCoMTmTsBQpZZ6w/1tQ1YW3ZY/zzECCDGUj1RDRaW2Wd0SEA+L/X6+teRXc+YoW/ltzEy1cQfCuhcZSgxcbVmYHTtAwFE+nk5GV03nnCZkxYpQuX1jzxbVDRkMdtajWk5o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:43:41 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021%7]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 13:43:41 +0000
Message-ID: <b9e88e33-7276-1930-5d85-9bbd740f06c8@amd.com>
Date:   Thu, 26 Oct 2023 08:43:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
 <29564bbe-b7a0-fcc5-47ee-093a032a11b6@amd.com>
 <15e8b03ef471514d9347e8bffba4fdfa1ef4f3d7.camel@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <15e8b03ef471514d9347e8bffba4fdfa1ef4f3d7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:806:22::9) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 240e19b4-e88d-43c3-efa9-08dbd62990ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 287pjVxYUv3is5opt00qNGsGqIC2O7KYP0J1XVQIVdgwLVCpcP0KdD7Lsw9IKWmTT5ayY82mmmVwrNNWGjoz66G9nlO5TWBvyR7caeER1rUaTp60vHrfp5QtOuJ7MtmlEcdll/Wv4ppkUrDN4srR1s5Z2ZAcNm9yD7RQDiNgI+tMbVYHffCekPjGglfvcoRMtwISO8pd8AQHJSC5iWlIKUxYCSGbSSBZ2qB2wKsVthNPm7wz1hljJnc0Fgl6jog2/tgJN1qhbQmmLzAOxIt5sKBWdV9aW/CVtLmQcu5MZHArrAjeqy/i5o2icFiNtA5Q0qPl+p62/coxJjAtsPjHZSC+utujtTUChRFcigV8QY2gu4xTW84kSTRp8PBnAOy55DllCyjhU0oOuZstLCW+MdP4ZF8WJ0zqg7+3uGwReQhnUKd23b7hT1HOzIgkAysSeci7GmPFBt9k6ZZI3N6is5m8/QswseGJhflyNzXfA9V3ADLPaKnDYZp1Vfzd8hDO5d9suGdfYQyjGMswMnBSPhNT/56ee7EFf5AUsfwYslg9m16Bc4rBUcbnQyLli4TYk4dzj+FdnHXSpl19u99uQDmCICEbpC/OCua33VgYSsRaKNiyiZ+rExmzhvzTj2huYcDn/Tir8iXJL6L6XHI6KBMCsLPLnM3qj3QERflQ/IU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(8936002)(4001150100001)(8676002)(83380400001)(7416002)(6486002)(31696002)(53546011)(31686004)(5660300002)(41300700001)(6512007)(6666004)(86362001)(6506007)(316002)(478600001)(110136005)(26005)(921008)(2616005)(38100700002)(36756003)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlJZHdMZ2lteWJRNG1iMm04dkNmZk9mUFFoa1hici96dXhOb2xuMTRCbUZz?=
 =?utf-8?B?alFNdVZaME9SWWV0d1lWQUVjU29JZjJxRVF6YitlSFJpQlhOdU1Fd3dOR0Z1?=
 =?utf-8?B?Nndld0NjQTh4TUJlTUphY2wvUmQ4VHlJUVkyNmloRi9wcm1PNnQ5L3ArR2ZH?=
 =?utf-8?B?ZzBQUjZpNGVwS2NzdVN1eFVpSjNYeGRYWHhUaVBhcFUvQy9xSkdCdWFVZVJa?=
 =?utf-8?B?bnhXTUxKbTBnSXNIKzVpY2JEWUtLbVdUUVZQY2ZOejFabmxHZSttd3c0VURt?=
 =?utf-8?B?M1dxQnNYZ3FBNnVLdHowTmpZaWpVd3o3SUorbTdHRHJha1llRE1xSGVQdmhH?=
 =?utf-8?B?VlpZc2oxS2l2T0pNMFFMMHR5R1cydGFYRzRvaHFvNXdIUXJ6Q052LzdHVVls?=
 =?utf-8?B?V2NDeTR6Y0xlZTJQRWZkZWZVTkZmU290Uy9mN2ZmN3NTSTVJWlVyS3VONHl0?=
 =?utf-8?B?UjYrR3BCWE53WEcvWGtLOEM1bnBTdW0xVTNGMURzcXpDSGw1V0JUcllOU1Nm?=
 =?utf-8?B?S05xQjZpMkdkbXQwcHp4eDhBMFZhMVZxOFpkZW1WR1pjaTdBTU9zMWxoWTZ4?=
 =?utf-8?B?TytkRm1aNHVYOGl0aFZFcThmNU8zM08wWFlkdG9DcVVVYVlIa2JhelNlU1Av?=
 =?utf-8?B?WEI3M0s3TVNYdTRLZ0JDUVlyYzFPYlhZWEtMM0FjVS8zOGFsQ0ZtRWdWamJC?=
 =?utf-8?B?ZHhESk5HMzFJZnZFQ1pFbFpnQ1RScmRFaDZRQm05b2ticWZzcWFSU0RLcmk0?=
 =?utf-8?B?a1FsUDNzb3UvN0lRVSswREVETEdOeW1YSTVRMmVVN1NSN0IyQnU0SVg5NHlS?=
 =?utf-8?B?a2RMbXNxWENSSEQvVEVxd0sydnpnelJFanM0bXhiK0U2WjFPcHpoSkNiNkk3?=
 =?utf-8?B?aHROZGE1VVdSR0tiVWlYaUxmTUpNenJ2eHAvYXY0STM2czlrNjJLREVYWU1E?=
 =?utf-8?B?OVRUdmIxS044ekhGbjJQUFhXbk40VkZsVzFPYk5Tb00rdWx5c1lBQ0JNSE96?=
 =?utf-8?B?N3dwZ2NGSjB4WDlaa3IyRWl2Uml3RXh1dWhCd1R4OHdxakNWMm14SEVtWUdW?=
 =?utf-8?B?V2toYU4wSE1DQisycTcycjh0TDJLbDFUU0RJQ3ZyVE9abXBPVVJxTG9qSWd1?=
 =?utf-8?B?eno1ZW1WWS9TMGpKSXZKeGlkVFVlTW1ROVd3Smh2amtpTFRmYUpxYkNZZXo1?=
 =?utf-8?B?dlUrSkFZTVZFRFZDS0RubkVOQVVyU01ac09HRUdzaXhZRysyajhEU3p1NW9Y?=
 =?utf-8?B?QTZOU0I2UTdSKzBla1l3QndKUTVPeHFvSVErRndta0lHdnhnRU1NczNDZys1?=
 =?utf-8?B?YUxzRVJuWHMrM1RONG54eXMwZ0dWNktNS012b2hZbmNZUzBQRkpKdWkyT25F?=
 =?utf-8?B?S3VhSk1nSmlsYWNpNU5qb00ySy9qWk1MTHJncGZyUFllM3hQMlpHM2twVW9Y?=
 =?utf-8?B?Sk1wMi9Sc29XNkNHMVJiRDdoSWJxUldaZkdJQTBMbnJXZjF1bmNnQzd6aTNx?=
 =?utf-8?B?Q002c2xFclNYWjl1MWpVWEdTTjBxQ29JTHA3SWNFSDRaQnVMT0piSzgwckI4?=
 =?utf-8?B?cXJBbGVDbzhzSllpZEhIUnd5Y0hvd0dFS2ZKRU9wQjNvVEpYUFQxSHk5SFd6?=
 =?utf-8?B?dHVva1RtTEF0eStXU0N4KzREa3phM1ljUlhSVHpJaldGZXR1RlE4MXZsY3R6?=
 =?utf-8?B?RDVpNzhuM1pTRzg2MjJMSFhsczF3LzNqZWsrZHAxY0V5NkRydHdJcDNSbURN?=
 =?utf-8?B?L2Irc1E1ZEVCYXlNRWhqZTcxd0syL1pKTENmK0RldWpHQkd3b1FiU2JkWXlu?=
 =?utf-8?B?U2xyYXR6eDYxa2xqWC92NEZhVlVqdDVYNnZnSkR0dHJRdnZuOWhuU2J4SkZR?=
 =?utf-8?B?bFVta1BxL3dJUG1tSEpRK25vMjd5VmJjeFNDellHSHFmUUFSRHI4YmZKaFRw?=
 =?utf-8?B?T0xHVEkyb0t4MlZUV2NRUk1UeEduRmRoS0p1WFlyQXFEWDh6SDhhZXhpeU4r?=
 =?utf-8?B?LzhPc20xREU0WU5BN1lPTC9IbUE4eTF5a1I4cmQ1QWJScUNaKytCOUJtV2I4?=
 =?utf-8?B?NkprdExqQ1FSQzRwWlFsTXVVTHE2RExsNHdLeDA1cUYvR0h2MHVNV1Z1RHYv?=
 =?utf-8?Q?EeGL/w9ty5tMtdft2bPyXFYHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240e19b4-e88d-43c3-efa9-08dbd62990ea
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:43:41.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTHnbNibd8w4IDpn7YbV5fH0FnpRur7vwlso2vxo6d0U1zb/CMra+sDwzoi9YUMEtOoQcomDjzauzTtHhWx4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 20:45, Edgecombe, Rick P wrote:
> On Wed, 2023-10-25 at 13:03 -0500, Tom Lendacky wrote:
>>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Thanks!
>>>
>>
>> Under SEV, when making a page private/encrypted and the hypervisor
>> does
>> not assign the page to the guest (encrypted), but says it did, then
>> when
>> SEV tries to perform the PVALIDATE in the enc_status_change_finish()
>> call,
>> a nested page fault (#NPF) will be generated and exit to the
>> hypervisor.
>> Until the hypervisor assigns the page to the guest, the guest will
>> not be
>> able to make forward progress in regards to updating or using that
>> page.
> 
> Yea, mismatches between guest page tables and EPT/NPT can be trouble
> for TDX as well.
> 
>>
>> And if the hypervisor returns an error when changing the page state,
>> then,
>> yes, the guest will terminate.
> 
> I guess those callbacks could be changed to return an error after all
> these fixes then, if you want.

Probably not necessary as we will want to terminate the guest in these 
situations and having it here in this one area is easier than checking all 
of the call sites.

Thanks,
Tom
