Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0027AF465
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjIZTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjIZTst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:48:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD71C0;
        Tue, 26 Sep 2023 12:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxho+rOENwtvQfFTtx1uf04Bp8hiBWjgado/wp2DuUHsEVOzg2tb8UzF4y6FGSbZjqUmuLYVutncSXA0V2XTzVSccBUx4/fjTEfWcJYU/zkkpJahW9OjtzX4lfyEhNmG08G2eVOGZUixkAWNUo4INd/+B6Go8yTicxRPjDqz0aIIhA0PHnp75QuA9zb+X14SELkKmLO3lT2RReAjSmg5kmMRohkj3IuxHdA6n/ejJr5l646g10k94fZBBKiLBq19zvoZrKnd/gqpvBRgpjt51bEqzdzi04SSqq6uwy1LQqfY9/L1dr+JXvxY2/SeuRajq1gSrjvPy0YTHgEWtiwD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YT+le9jGPhcAo/60U74LO92l1R0mclsx6AGDieUAm8=;
 b=ab/+WUJDg0l8A8rFhlJ5m3JsPGEB/xZdoSZOOcKP7r329f04Qna8Sonoh49/DdfJnrKujifdI9z8tk8VkSlb1C0ANnJn/oBeC2R9nwl7liCW6HZe/iiLhcbLuiUnUCmUEDpyrvNFz8S83nwNphZ6iT2fHpq1j1CbNBQRCwmzZUqCfb7CwaYOPD81dLxW3I53ISXOCWqj5eFfbhMnCW7nTpou8Yl48aBnHz31SNN1RpdK7LUO9Ddi0NtwppVcgZNxvv0km+7Cqq6a5HeiK2W6kR4rbpY5eHxjC4y9ojf6JCPGMgjEmKObubMPf80tNnQ/ZGF1rV1hX9MHcC2ZukoDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YT+le9jGPhcAo/60U74LO92l1R0mclsx6AGDieUAm8=;
 b=R8xxXvtUfe/7ZSZe+Na+4UtKu0oRyl1pki/OVZyWLRjVkgjGOgP49XxdprwIczfTXutOf05rHg2vvWuCcuKCCESyRNUbYXpNE8WHHInsoMUI2RxKwmwVtWMOsudaKTW/vLpXKNe6CYsZYGnOCF6CrCxh+Qts2V8LFhoFbD+P+KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 19:48:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 19:48:40 +0000
Message-ID: <3d0b98e7-9aeb-3a97-9861-707ed7a1db69@amd.com>
Date:   Tue, 26 Sep 2023 14:48:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <ceff3d3a-92a2-2e67-76a1-da5639f91162@amd.com>
 <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60838A29873FAAA50C9E9536FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:4:ad::41) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c01d4e-74b5-41a0-b095-08dbbec99552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC0wFl6znd7NFgmNGH/9CCOBdFoYL5wlDbH34EPVokHOEmG4BZJR2q4Fpmfl8DDAaNDWo1yg3+HNphhU4sI6H3OEorv7tHJqgw+fQkX/dXgkfrXFvYLo7AqEnLj577T3/o4G43wUo38kBY6vkRD/Ku2vvYgYyouV4pbw+t5Y+Yn6tekJ4H6sLqVB2K4F/EDwiaiZ0kUgCxXcQD/QnNpXK0xRrn8de2/1Y3SWuInQP9Y8E3/nvsVz4vqfy5TqKBfNRVUrN8RBQXtF/WJSeUrlJ1vVglXs26GIQLBaEjI8UgPdGSS4EKqy0ehhkXylJcH8aFMISmHgb2r3qlSwpzR0zSMq1LZGRMBi08Mus85Xu8FaKIPZSe1OEfe5AnN/YfNhYJMnrQrCcfxtUMnQDoWNwqEPPse+g4a7pdPxWitfXegaZJ1gAdQuGjqRkO0t9peo+/j/z4zmkUXD1VvSkFTL3im1Vn2Bae7z7BoQqc4QuacynnLIWS0AVrhrVqUibNOqjsavOxU8lTW9ga9PmY9FORNGBOeSylQP3MAgUnXwz1e6uNk+1Og3Knf7ReozOieILxOebHQT0K34nCKecq1TgY3z8GDClu6KKHUKpmi09lgSqzdHWcAWC/5SuHedjLKCFaX7gAgQqLOyNzFBeYp7srbg51XOuSCMBQLFOs5j4hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(66476007)(2906002)(31686004)(3450700001)(7416002)(41300700001)(5660300002)(8676002)(8936002)(110136005)(4326008)(66556008)(66946007)(6486002)(478600001)(6666004)(6506007)(6512007)(26005)(2616005)(53546011)(316002)(54906003)(31696002)(921005)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RjVkZpemRyMHFTcUN1N244clZDQTdBRDFqclpTM3FIQlgyVnJHeWNTbTVu?=
 =?utf-8?B?cXkybXdzTWVYQjVZMmQ5ekl3TTNMeU5sd2FnTEJpQmpJdm01UDZUYlg4M3V4?=
 =?utf-8?B?Q2MrRzFNeldVNk1TM0lQTUhSd09FV1Z5Mm0vejZHRVFqU3ZaNnQ3ckRqaVp4?=
 =?utf-8?B?UHBDNnlDemFQV1lHeDgzSjdDQUU0UGhCR1ZMNnl0U21OYm9sdjVpbWNFaVdK?=
 =?utf-8?B?aWVqcmt3SW4xVzRTZERyOWdscGlha2NlbXpXMWNLTnNEZWZxS2pGN0xzZ2JJ?=
 =?utf-8?B?ZjIwS3ZKQ01oaFZ6TXVtSVBsRU9xRFk1UEVoQzROYnVQdmZiNHkzZ3JKVURX?=
 =?utf-8?B?RGZ6dUk5Zmd0a0JQZFN6Z0JBWldLTkd4RFlZaVBoL1phdHpmZmNNbHNSME83?=
 =?utf-8?B?NXMzMnlBalNEcnBQMGhtYit6bTlqZ3k0UEEwSHR3bFpRdUM1NXVCRlVVcUxG?=
 =?utf-8?B?RC9HWU9VamZLbzN0YWZ6Z3QvV2NVbHRoWnZJR0lkMU1GdW9PclVnMGQrWStK?=
 =?utf-8?B?VmFWMGdOS0Z1NmdzcVNKS0ZrVUxFOWJ4c1BmbXBsRE8zUUR3RVBNUEI2SjJ4?=
 =?utf-8?B?MWwvZ3hNV3AwYWpGS2dPMDhteFlCQW93UnFMRmdaVC9wVTlQbFJmOEd6TjFj?=
 =?utf-8?B?YmtIVnRUSk10bDIrZHc4TkVLOUVYbmErVHFadFpFaVd4eFZ2aE83MUZKWXVZ?=
 =?utf-8?B?dGhBYUErbm45OW9FamE1ZStNN0tRTXpyYisyUXVNYU5CYndGcWw1dWJOK0d0?=
 =?utf-8?B?VlU0UmNZSHdOc3M5R0lsUWNLb0d5Y1M5S2hKTW1JQ2tXeVV0bWVkTU1nYXA5?=
 =?utf-8?B?azhUUDhaRGRPdFpnN1FPOE9qaE9QWm9lYXpWeXhNUm4vNDBDWElJMThMOEZh?=
 =?utf-8?B?NGN2OTdtVUErOXJDM1hKYW9rdFNKT3lwN0hXejVWS0JYekVIRHBkSWV3WWVs?=
 =?utf-8?B?bS9GZmVtUTZid1FRQkI1WEVrVElSWm9QbjExRWFZc1FMaXJkSTc3dm1oU2Rt?=
 =?utf-8?B?cWF0V3V4dGE4Zm15c1JQbEN6NGtGRVNRWVBYQmVQOW15TzA1UzRUSFBwbGll?=
 =?utf-8?B?YU9oOFJyV0s4L2U5YWFNWGgzRjFOSmI0UjNxeUhudVhscmN2eDd0Vkd6UWYz?=
 =?utf-8?B?RDJmQVE2VDA2emVNNFJ2NndTajd4NTFHck5mTThKWlE5Q29YNWZ5Y2J3cEdD?=
 =?utf-8?B?T3RkYkZ1YzVzUUxISlJMN3B4SEc4NTlza0EzVDdFcjhsTGIxSDcxNjhJcWxR?=
 =?utf-8?B?UE9aZndIOHBuaG9wY2NpbHJkVTRpV2owVElpRWEzL0VnR3lPZU5uRFpybElq?=
 =?utf-8?B?Um1PQkpUZmtPSWpTRlRWTWFUeThqWUdLdmZUdm9iNWlYTkJKeVdJdzhjR1ZI?=
 =?utf-8?B?aTBaQnk4eDRHWnZ0bmM1QzdjMzZ4dzNMR2gralk1Z1J1OVlsUmdLdk4zVi9t?=
 =?utf-8?B?T2F2MFhCWUNOWGhDaVdYL0xHbFlwR1ZaVEdYU0tJNTBqTlRmWTZuYUJWeG1O?=
 =?utf-8?B?WkVHeElRSWh6Y2wvN2RHSHlqR1RKeXhrd0k3dk1KYlhJbFdCMUMxZ2M4VzUz?=
 =?utf-8?B?a2V1YzlXVWMydFZWOW11SEc1UUwzaHhOWWwrZjZ0VWY4SXU2RnpCRlNzNTBK?=
 =?utf-8?B?eVpDaVVGYjM1YlJxWVFSVzhlUjc4YTFYTEFSWWtZcklwR0IzL1B5OFp6WHpx?=
 =?utf-8?B?VmNHb3RGSUYxTXJtdjBvVm1HemUrQm9ET2V2UlpmUU05VHY4RnRNdmorNTB0?=
 =?utf-8?B?QmlXRERHV1haNERKazR4Wk9MVGRldDBuTG0zd3g0NXVkSldBcFB0V2V2cmgw?=
 =?utf-8?B?Zk01c25sWm01alo5eFVnYkIwYjBLRCtUUlI4UDhCVlR2dVBDK1BVNDkyaFgy?=
 =?utf-8?B?QjN3YVdldUUrSjBueU1YdlBQUC9VQXhlbmJFRkcxUTU0dGl0VTRlL1JJWVlM?=
 =?utf-8?B?Q21NdzRIWG1xZGRDaXZ6VUhUbUw5L3VnOTczdWR3eWMrM0FvWFpTdmtXL1Fv?=
 =?utf-8?B?Zk9WZHhuU2ZqelEzcEIrWlNsNzZ0cXhNbkRhMWk4L3BsOTgwZEFvZDE0V3po?=
 =?utf-8?B?UFlMZlExN1Q2NC85UjZReUVqNStjWVhLQjlzNmlHcGJPL0k2QmFyLzdxWFVI?=
 =?utf-8?Q?30Xo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c01d4e-74b5-41a0-b095-08dbbec99552
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:48:40.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAMqICmkeGxGvn7BuVtp4H8Ll8CSo09BLx3VbQXanovai3F/lrh/ne3tGPVY65R4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 14:40, Luck, Tony wrote:
>>> +#include <linux/mod_devicetable.h>
>>
>> I didn't see the need for this include.
> 
> struct x86_cpu_id is defined in this #include file.

Actually, the file <asm/cpu_device_id.h> already includes the above file.

> 
>>> +static void snc_remap_rmids(int cpu)
>>
>> While adding the new functions, i see that new function names start with
>> resctrl_ prefix.  However, we are all not very consistent. Can ypu rename
>> this function to resctrl_snc_remap_rmids?
> 
> I try to put a subsystem prefix on any global symbols to avoid random
> conflicts in other parts of the kernel. But I'm less sure of the value for
> static functions and variables that are only visible inside a single ".c"
> file.
> 
> If it must have a prefix, should it be "intel_" rather than "resctrl_" to
> indicate that it is an Intel specific function?

If you add it it should be resctrl_.

Thanks
Babu
> 
> 
>>> +static __init int get_snc_config(void)
>>
>> Same comment as above.
> 
> Same answer.
> 
> 
> Reinette: Any opinions on these?
> 
> -Tony

