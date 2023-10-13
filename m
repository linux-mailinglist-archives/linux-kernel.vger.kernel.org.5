Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548EE7C8F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMVlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMVlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:41:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751FB7;
        Fri, 13 Oct 2023 14:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUqUrd4QFaPWfNhqlkHtgVUk5U150Vh3h6wNli3ZHaqXaNQr7XzPQ3QB7kbfb7UN6P8wDX05LTmcYjbjF78UAmTS3eAx2ekIoyLty64ly33UkEF66UwIuwrYdq/IsAmnpCA8fsC18jZ9be8Uamc6oFuUE8AFsu9p67Y00wQPQaCQCK/W0xmex2gMh0JTrDRtpFVQ7TKEVPDscxy7ojYx8DIU7xDRwy9WMYYP4on7tQtD0aQDymWTU2BIBJz8qirKNfY5vwnTU0z3VwdP1734ZR5ZctA+YZkZPFzpIMwWzfzhZp7D9YRp25JipjVWKZal6TRsuN4/44G9ERl9VYyq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MsuZjM84Msi++e4uwHjsDda5j+uy/uFRdsEDVvSwN0=;
 b=ggl1UMB6Li4Sgt1b8B87z0g1CjtrrTJVnmKd0Gcuuue9zsesxcx30Nr6K9ORLqAqP1E/e5kNYphRtFHXoy2uGSk1Lvbu7zm8f+Cn3O05LtFKbjGQLCl8W63Hal3Xz8q4/pADtuxnp1kkUAm+dDfjjFTGRQ8Tllb1yN7aZVR3stHwQEOxdeIh55PTfK6a92vF7TxoQIR0E+kDxc6LQfqjahdX7RXhKX68Rp+bpGMvq+Qxg24WqaS5looNAZRQYd3CIy9WHE4NRLDsPVgp7aCUckSHwwo1tce5tZzb9z7sOgy+52J+WHsJfWdMfTb2gzyyRvLUfkpklEn3n1XthfTIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MsuZjM84Msi++e4uwHjsDda5j+uy/uFRdsEDVvSwN0=;
 b=y1dUwSqZ4VSrWKxUg+qp7i6qqYJAPsF2mCk7UMM/+4p6TyF/qUOc4kT6PmknayxJ1gi3W7nEfAE2kotaJEV08hSPEO6KyWII06MPDR2XerSmGsm2uwdplpI1gcPFGJXF2tRVierfkpQpakq+dRgiWpFIWx0fG6Hv2Qsyi/LH8TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Fri, 13 Oct 2023 21:40:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 21:40:57 +0000
Message-ID: <db2a7eec-e42b-dd77-9651-cdcb76d57098@amd.com>
Date:   Fri, 13 Oct 2023 16:40:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-11-babu.moger@amd.com>
 <272769bf-6fcc-4e25-8223-88b1775dc487@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <272769bf-6fcc-4e25-8223-88b1775dc487@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:806:127::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 19509cdf-0801-492a-5120-08dbcc351577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqotcXsn5Qkl6KPmbq/s+zQ/V7lsVOfBi702I27CgCIOjPBJhgNvEZkPB8zFAYWmfFrHgMOIV4GWHSKAEzf8Kq8Bs0oLG1FjOvhPQXKgPi9jfqzDnk+yJKtMTQ/lah2gMomx/3YIQ5HSo3nHZj1zqxL89CV5z/pYW21LSpRWDZWIN56B0gM40nqsZEbAsPrq2hwIlzLDRXCztB2zNIh65cJG9yaQcpiqnSXr8ZGV43bLvX99JhD91QLAi6JiycvQPOmRu1q4jUS6bCmqwr+7E1E/4mLHYpPKk83FUC2awLZwBX65H4hYdYmOoHl9VdU4u7WBmNtlPTYuG4Mq4N82NpFTfBpF/HpnKnXdWZc9f9T57UIo4+vS4Dh5mEY2jlLm+Rj/Rp6PKFJd9ya76lJAoGYvA8OI1oKRiNZgxXmUPBnoiTFl/Tp8TpG1U2azJ0MoiDawfnvw73CRqVUxTHQG+KNejiQ+nqwNXvTk5G1eD9BUN0xnueeoi46kiqfShdwRN+w0hBNb/L5KuT7n4gicYUa3iZmJeVppBcROodsSOBkkCrtKh9xvn4+y7y5b2QUplCt2dCQn1kuSNu6YILwMqeNuTxhd8Vq/hCYjT+LJZJINOuddLV3syqE9vEOltKncQVInPYIjIidGX4X7lTXS2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(5660300002)(41300700001)(2906002)(8936002)(4326008)(8676002)(31696002)(4744005)(7406005)(7416002)(6486002)(2616005)(478600001)(53546011)(6666004)(6506007)(6512007)(36756003)(26005)(66556008)(38100700002)(66476007)(316002)(66946007)(110136005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRQNDZIZERLSWxHZ2N4ZlBWSzBBSG4yUzNraEQ4bjNuU3dDOXNSbE15c2FB?=
 =?utf-8?B?MFM1Q1FPM25XYThidi96STRwT2FvQlFDL0RXdE9nM0VQU1I2bW1zOG1Zdzd6?=
 =?utf-8?B?Qk40QlZjSUVpeGxWVHM3MnQwS0JDQnB2SU5RWEg0NlJiUVhCenlzazJHY3ln?=
 =?utf-8?B?UUR3WG9vTjJJZmFDUWY2ZHZIbVZINmF6Vkt5N2hSdXZTcTF2RUI3c1FhSWdQ?=
 =?utf-8?B?U25oMFpMU2tzVEJaQkx6ZllXL2JFL25IVy96NFBHNlpzcVdrMC9kQnB3T09l?=
 =?utf-8?B?SWgvZ29nWWVFVW9haGhLSjkvMXNhWmVCcWtYcEthQ0hIbkUxVlJRTXBTNUJT?=
 =?utf-8?B?MkhXWmVTK0Q4bFFlZE9KeGY3MlYybmNNR05kU1Z5aVVaeEVzNW5QZmtXSU5h?=
 =?utf-8?B?eXRyVHlnMU1OQTJDeDl6Q2t2UTFkbzIrelhJMUY3QnhkdjZwcXdHdW4vZ3VO?=
 =?utf-8?B?Y0YxUkttM1hZM1VjcDNrM29hSFlHdytnM0xUdXFFMVZLSmVFTzVpL1VIeCtS?=
 =?utf-8?B?OEVaMDdFK3JNWlRjT2FSNG5NemUvMVpHMnBsOENUY1VURHI5K245cTUwbDU4?=
 =?utf-8?B?U3NkSld5d01DVE4vNlowckFtbW1GSzdxN2kyVFY0OThwVEdsR2d5THlKY2dK?=
 =?utf-8?B?N1FZNzFWdk9VL3NXR1htSlJPWFlaMlVRMkpWbnh5a1ZxM1NjUDR1VU5rNTBk?=
 =?utf-8?B?SUl1Y1V4UmZHMndOeWFkRENhNG1sSVJHby9oeFhtZ1hsUWl4NXkxUUNEVDNs?=
 =?utf-8?B?dzByTW9KSFIvdXBNMXZ3YmVESVNMQjFMdU85cGJWU3U5M3dKSllCNVo2dG9I?=
 =?utf-8?B?a3hkMkhVSkJ1Z1IzK1dGNkNHcitaTHp2ZW96NWtvV3Z2YndVek9ycUhQY3ho?=
 =?utf-8?B?aWxXbUlpYUxzVTh1Wk9PZHBxRHkrRWZnbSsvWmZOeGs1c0Z5TU50aG1WV0xE?=
 =?utf-8?B?bWdDOFN4WjBhTCtUek5ZZlQwaG81T05rcjc3eElSVkdtUVlwVzZQbnVGRi8v?=
 =?utf-8?B?S1NRdnp1c0JQZzBwZFVqRHRFUFJTcjl1bHRqSUM1QlQ0azhiZ3FXMzlMZEhw?=
 =?utf-8?B?aGdrYmc4RkxaMEZQanE1UENpTmxTR3NXM1BCS0M3NGQ5R3Q5Y3NrWlBNQWNE?=
 =?utf-8?B?UmVlUzI5YWVua3pnK1Q5WGhONTM3MWZta2d2ME9RY0t4cmJoQmdJYlV2eUV6?=
 =?utf-8?B?M0ZGYWNxYi9uVFV2S3EzYmZLcEFSWkdSUmwwN1VRWGpQajcxTmtNdXJGVzJl?=
 =?utf-8?B?Yk1Wd2VGbTA0aDlkZ2x4Wld6SzJlZFFNREt1bjNLUXd6b0FFQUNBUStmS2Zr?=
 =?utf-8?B?ZVQ5NE5WZk1pNnlVOFpRaklDcjhOVlUwU3ZmY1diOUJTNHIvY25SbmwrTmdn?=
 =?utf-8?B?MXV3cGtRdjN4MkltRm4zdkdaNlVIdnZsYW5qVmhsVUJ4UjFDb1Z2Y0FZM25u?=
 =?utf-8?B?bFVCamVGM1ZhVmhPU2c5NlNhQ1FKT1ZlRkJnQkp1NVBJRExFUUNsQ1lHcTV3?=
 =?utf-8?B?RlVOYVhocHV0VVphY2NuT2xtU1lOdVdRZklKREFLWDZ5bUg3cHhuNTdIbjV4?=
 =?utf-8?B?QXRhVVZvTHk2V3JzMlJzT1laeFNHenBnOHBadjcrTW9WT25VREhleXB5SEpT?=
 =?utf-8?B?TUJmbkh5NkIwY3ZwZEJPRlRSWUlLUmZsZWtDNVJ3cFp5a2I1dHQyRXNqMFNM?=
 =?utf-8?B?bUFaZlNSam9JNDMxNW1sMWl0UDdRaDM1M1Vab0xtdDNFTEFVZWwrS29kOUlw?=
 =?utf-8?B?ODdqbTNHTmNTakVtcmh0c2JueUhrdlh2UnBscWNTQllRZUQvd2xBSzloYTV5?=
 =?utf-8?B?SWFOMGhZcXh2VzBvdE1oelNVMFYxVmpGY0VyalVCRHY0MnN5VkdiNW1UN3JM?=
 =?utf-8?B?WVJXNG9GTTN2MnlpdzFscDJBamFjbEpiUUh2TVZPY3ZpaXM1Y2FTcmpkeVZU?=
 =?utf-8?B?QnFOTGxuOWdJcURrL3VLYUU1MENRa2U5Yk84WXZMRFNZN0pLL2RLRWJyamhX?=
 =?utf-8?B?TFlUQ1phZWtuK29ubFZHdnRPZSswa0grbG9pTlBvMUJ0MXJXUzUvQlRORFdV?=
 =?utf-8?B?emY3OExjK0tzRW9Mcys1eDZlVjFQNXFjZW9aNWlaRVVDS3hsaHV6NnNKVkpa?=
 =?utf-8?Q?5RM8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19509cdf-0801-492a-5120-08dbcc351577
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:40:56.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2ZPBRQmu+F4/4SQVu5kDRELIplVp/bcztN9+cVGfjxCm2PMbOse1cDqWfQkHrjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/13/2023 4:24 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/13/2023 1:26 PM, Babu Moger wrote:
>
>> @@ -440,6 +444,14 @@ RESCTRL filesystem has two main components
>>   		-> RFTYPE_CTRL (Files for CTRL group)
>>   		   Files: mode, schemata, size
>>   
>> +		-> RFTYPE_MON (Files for MON group)
>> +
>> +			-> RFTYPE_DEBUG (Files to help resctrl debugging)
>> +			    File: mon_hw_id
>> +
>> +		-> RFTYPE_CTRL (Files for CTRL group)
>> +		    Files: mode, schemata, size
>> +
>>   			-> RFTYPE_DEBUG (Files to help resctrl debugging)
>>   			   File: ctrl_hw_id
>>   
> Something went wrong during creation of this patch. Notice that the
> "RFTYPE_CTRL" at the top is duplicated in the new changes and that
> the "RFTYPE_MON" changes were inserted in the wrong place.

Yes. Thanks for pointing that out.

Will check.

Thanks

Babu

