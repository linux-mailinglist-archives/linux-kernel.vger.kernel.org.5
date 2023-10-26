Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E406F7D83F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbjJZNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJZNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D25D55;
        Thu, 26 Oct 2023 06:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJnDfMnSZ7rlp5mzxo6kTf4q+vqz6wP2Y00pfsxNlfSqHcMrYvguFNGsSoddLHAeNQOoSqGRlojsT6s36aySwSOIXN33BQKzz2T+BNphhe7EbYBbPlVto2Xs8NIJTkAgiGVp8eA+Qx5khuZcE8Xbd9ZX+40wVaFPRlzfP1Dwlb6uLtyIrT4lmU+3rhlo5/fWgT7l5bm8YXyijiLfKBU/b0VaNleULdEGENjuNu1DEnKSUFqqZA4uSu7FfFCtDHChAKWcSH4769n7u4lBeNGeApeyr6K5Tbb1MCh0Ea38pqRR1vW5mM9qPoi2vZ3p5A2gOmR2qZ2DNbmyrbJ5ZgQYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1iB3evqeb7DePzb+B0TCoSuDZy04T8MeCjFYh1ejHo=;
 b=D+toviA/hce8DpCxG6VYx+F8Ac7tWdLbN9AG0/NRW/M6CVAvOOpzi7pJkwHv7pwwIUgL+kgl3T/4/NiXh9JO2T9J4s/PLDYcEzwx4VLcU6n+bciuRexmXaWpxnvgTExz8fK6WLEubNdnT2ELGBJKKqHmt2vKT2fEBkKPZ/kL0/xfanlUt3AlaELhcbfAKkxHhjHPCLQ3sxHJ1EgNP5X4c7RZz4kHkx1XzydcuPEFYSpqZ2TAdKIlX3os5i6vrJvmDYNzQaDFKT/if+Unyu78TZRE6FvGw4kakpKZc3yz8AkV32xrP0LnAbSqT515F0m7A+idwFc6uymj1yl7TsbYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1iB3evqeb7DePzb+B0TCoSuDZy04T8MeCjFYh1ejHo=;
 b=3zpl88ofll9GNWFvaTzhp3rRIXMVBaoFV/hxvC2VZ9Gq2pMu4fVwVFAsXQVJySuzHhJpE5uHnGH1zAYVyW1N0g2PMry00I7IhkPfK8WxR1XRE8cEnieSHD96B2NpF2UL5AJwzxTJkFqFMp4NJjMhgnRum/aTbS3nd92A3yqvkeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 13:55:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:55:30 +0000
Message-ID: <95fc35a2-2f19-4ba5-ad3a-7d7ae578289c@amd.com>
Date:   Thu, 26 Oct 2023 08:55:27 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <CALPaoCj72V=o60tqsFMRzaeUw-1+rN7pyhsdCyVEV=0tN_CZ7A@mail.gmail.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCj72V=o60tqsFMRzaeUw-1+rN7pyhsdCyVEV=0tN_CZ7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d4e0fd-01c5-47ab-9219-08dbd62b3750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bgkrBk69yB8y9JJUaQr4fS9CSq0qE+U51DKuXWN6Qg6HQXs7FKy2qcv1rh1uNlq/VsGSAHyke3HAh7b60ntrVITAVMRmAspTdocjLniYWyZl8UxW6yeCxw9pU6ggDGmaToTMQMDtqdvflqUNRW1hbuXF0kBhLBP8qtFikKNpPI2/QBMYIHdDWNFl1Q6laW9ZDHnpFgI4Q9BzpHPedP664lYylIWjYZzmSp0R5na9gqxv0yEPk4+E37GLaMgW+pSACqs61kitop5eothio0zp2Sm759pf6R35NC+Xj/9soRlJ/bzdmc6/qTq+Goai6YevHgBYMnKFZ8GdhG3ZA4929nbjmb7ERfSlpvZc7c13r21lyQ3Tgi+euskn6gTmTZP3nEPVoY4nHUMjib5kLDcEotMxVZBzeZ6NcXSyu+JOVUUp6YrnDWuIT5F/mFXy/isMkL7/roUJUjZ1G2YJ4jUUD4aohxwoPQ83Kr1ltxA531z5i6dUTby1hKOOe9SORUQWdnGobAT3OntidtbfrkUc2TCn8IJt8FsKMDPqecS7XaAOV/fL5dmwIZrBBNcPxcbe0mTYgmC4fANxYZUV9+cFy2bQw9sTDcuwbtCRz5fNAdbfqVbqo+DQoZ0sjygRXXmHvXajcKmpDbAssGC6aG1Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(86362001)(41300700001)(38100700002)(6506007)(54906003)(316002)(66476007)(66556008)(66946007)(6666004)(478600001)(110136005)(6512007)(53546011)(6486002)(3450700001)(966005)(83380400001)(31696002)(36756003)(5660300002)(2616005)(8676002)(4326008)(7416002)(8936002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ttMTdQV1JMY2dBR0lqaXhRd2dHT01vVXFQdXJGNWFYU0YvM1dUczVzRUtP?=
 =?utf-8?B?SHYzZnZCYjQxZFJOZDdQZ0tJdlZGV0l1SlkvZDE2SHZ5QVZGOGdDYmFHeFRV?=
 =?utf-8?B?NGVrcTR2TVVWUy9XWnRmRDJtQWRxaTIrdjhxUDFZWlp3bG02aDBRdWEyMElK?=
 =?utf-8?B?Y2gvU2dMQUI3cWVDdWwvT0pYczU2VzNCUVBRNUl1QWh0cTVPMmJyZmM2M2lj?=
 =?utf-8?B?YUFxSWxWSkhJVkJrd0psbnNVdEo0cDVweHZOKzVHOEV5dk1TSGVtWTVBQXZ3?=
 =?utf-8?B?ZWtGa3lWNFkxS2EwRFk2c3VON3hYcjRlQUtjb2FqMHhMOWNSYitTUkx2V3FW?=
 =?utf-8?B?V1l6RHRQa1QyaWVJUFFtYml4ZlhpSEV1d1RubTg5UXVXZ2d1K2dWVVVsek5M?=
 =?utf-8?B?YURSdEIvUXBLVG9KNUtMbnBKQlBtZGJrUEhuWWVoSXFJSFZBcGhHaSt6NnZY?=
 =?utf-8?B?KzRqNm9RQzljWDRVTVVybm11R3pOTG43ZXcybkhkcXNDajhCODllbkQ5aURO?=
 =?utf-8?B?TWpiV3hla0NVQUw0U1BTQk00dERvb05ZaVJnV2FENFk1VzZNNFllWFJhMFJK?=
 =?utf-8?B?ditBa0JvMXpYeGdueWhGVEg4OXRXM1lzeTJkNCtSTDd6YzBxdFREcHpYQ2hW?=
 =?utf-8?B?WkZKS3UrTk0xNldMZWsvdUFMViszVEhCaUtOdGZ6ZTc2UUxPS3p3eWFZSCs4?=
 =?utf-8?B?K05ZRXdyQ3JyaUlvbmhxbS82dW1xZXZaNlZrdmlJVCtBRFMzTUVMa3NRNmNa?=
 =?utf-8?B?TEMxcnpLWXMyamZvUUU2RG5kVVk4Tm9NSmNOa1djRnE2MmlDRFhYZXN0TFdW?=
 =?utf-8?B?bzRzMkc3eFZ4YkEyR0I2MFZvN2srVDhBYmYyVy9GVUNMQlNTRzA1R0F4a3Fj?=
 =?utf-8?B?dTJycXZLdEhtOEpWQlJ1eS9GbkVVRHNyajFWUnowRzFhVkFCQUxRWGluVUI4?=
 =?utf-8?B?TEE4cEJwUU5rUG0rM3JSWTF6T21ZRytpRFlQWldmdUErdVlhSDBrNUxST05S?=
 =?utf-8?B?bG1SRksvdXVQanpaZGZLVUFad2VqMjZ6SitGaTYwbXZScTZYT2thRFpVWDBI?=
 =?utf-8?B?NHVpdzBSTExodU1pRHJXOThFSkRWK2RTSzFhQjgrVnBFS2pBUHQyRk53MjNy?=
 =?utf-8?B?NnpYeEV6Z2VNN3VQckYzSlZGYUovT3VEcmtMOEQrZjlNUVEyZnV4VjE3R1VN?=
 =?utf-8?B?WGhMVjNVczlhNFpYSW5Ca3dJd3ZQL2t3SzA0SnZybWs2REFXaXJaT0pIRnA3?=
 =?utf-8?B?ZWR5bGwzVzVJaFdFdFg1S01Xb2l5SnY4RTZKZWVuU2RodnVQa3Iyb1k1SE9U?=
 =?utf-8?B?OEg1UjY0NHp6SW1NNnYzdWd3WUZBME9QVndtQ1puRVlETUZRSkV0Q3hvNHVt?=
 =?utf-8?B?UFEwNDk2VFZDSXltRXNzSTQzQ3RYZ3lqNFdIZ1FoMXFJV2FUZ01INnhiU3I5?=
 =?utf-8?B?Kzg4OEpXeGd6YngvM29Eb1Nlb2pCcjhqZHdwUS9TcHU4TkJyK3Mrb0crMnVu?=
 =?utf-8?B?akNacjdITGJ5SVYrTXphbHBkMkdTWFhpK1NUNlRHT0h4Q1BGV3BKYUE1UkRz?=
 =?utf-8?B?QzA5YTh5UzRXcHBuMDhTZW15U0pDS1hoZWdQT09tR2hZUTdJblhkYisvdlB6?=
 =?utf-8?B?ZWtNKzZwMTdLKy9RZExQbXBxNEhld0F3SGh0d0JEL1lOV0ZveVdReElISHlG?=
 =?utf-8?B?VzY4cFlwNmFyWU92aklvekdOaGV1R0lmQkF6K2x3ZG9yckU1akpIZC83aWc1?=
 =?utf-8?B?KzJ0cWFjS3k4NFkyRTNCODE1WSthT2RHZXQwQjNYUXY5ZG1aaURSZG1ZWXNH?=
 =?utf-8?B?czJPVkNyNHpvY0RsU1dlMzdPbHJzYjdERndqQjJJaUNGYnRDNVZWREttUkZZ?=
 =?utf-8?B?NnVUMVNzSWdKWkMyNlVqSG5OUzBKK2paMWpvLzl1ZDNmNWJyUVVRVld1cHgy?=
 =?utf-8?B?bjZJY2Vaek1ybVF1YlBidHNBekhZbjVGTnFibXY4MGFHZTQ4MkRFRzZ3T2xn?=
 =?utf-8?B?WlJPVDZEVHd6T21rdk8wQUVXcmlRd2U4d3ZXc1h2Z0o4dFIycTVwN0tINjRX?=
 =?utf-8?B?aDlDamNNUElhSktQYXg5UVpDYkVXSWpDYVlIY0NJWkJmU0FWY3lGaXlybEVj?=
 =?utf-8?Q?Kuyw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d4e0fd-01c5-47ab-9219-08dbd62b3750
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:55:30.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5dM8WVrz8H7xdabOmy9jAteyvPhcECUI6RuhA5oyI9Lb1cOc5hEpzNHlEciXTKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/25/23 16:06, Peter Newman wrote:
> Hi Tony,
> 
> On Wed, Oct 25, 2023, 21:38 Tony Luck <tony.luck@intel.com> wrote:
>>
>> On Wed, Oct 25, 2023 at 02:46:53PM +0200, Peter Newman wrote:
>>
>>>> +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int rmid)
>>>> +{
>>>> +       if (is_mbm_local_enabled())
>>>> +               return &dom_mbm->mbm_local[rmid];
>>>> +
>>>> +       return &dom_mbm->mbm_total[rmid];
>>>> +}
>>>
>>> That looks very similar to the get_mbm_state() function I added to
>>> this same file recently:
>>>
>>> https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.com
>>>
>>> I think the name you picked is misleadingly general. "local if
>>> available, otherwise total" seems to be a choice specific to the mbps
>>> controller. I think these functions should be reconciled a little
>>> better.
>>>
>>
>> Peter (and Babu, who made the same point about get_mbm_state().
>>
>> Do you want to see your function extended to do the "pick an MBM event?"
> 
> What I meant was I think it would be enough to just give the function
> you added a name that's more specific to the Mbps controller use case.
> For example, get_mba_sc_mbm_state().

I actually liked this idea. Add a new function get_mba_sc_mbm_state. That
way we exactly know why this function is used. I see you already sent a v2
making the event global. Making it global may not be good idea. Can you
please update the patch and resend. Also please add the comment about why
you are adding that function.
-- 
Thanks
Babu Moger
