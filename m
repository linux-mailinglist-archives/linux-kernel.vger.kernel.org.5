Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC277F8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351846AbjHQOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351865AbjHQOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:22:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7908830E6;
        Thu, 17 Aug 2023 07:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMQCkW+i565E4BOfXG3CzI+ow2wZ/V65fsdXRccMA75itg5UV0Zma9aAGtQCBNY9mcI5YLvTPvstt0MXTk9cFYj00KxlhPH0boetiYFu01HuSsyGg8L0GJm5UQjdnKa4zdxZVZd2iOrPRqc+Y2WFT9s5abDT/40aFx44JnqMvM4ojjotV7RbLVK2Bb6z1YrUwbvm0sQWvjbyJaKLs9+cwT/wq1MyRBBdJH1Rn6kJt1cqAuMgFWJrHikI5xU5L3KWBQqpLJ4fLngOzQRuyHZ2+YltEiXNhgtz1TAJSIUZdWvAK+YcBk9YwVWRteksqgO5/QF9+t9+H2rtlQfHDHKAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cpieBlBXW9ACR/P7ZUKIqhCeLSiGw246jM8nK6wHg4=;
 b=QfUcHJswXgjKvrwJ1zADfgQlYvgnnJrkg1XvZLQ4h+iws0aC841s53pLvyYwDF45lvzOvkcI96n1QqGlaw9JgbFuiaTsTewN61x+Si7EommIQq1Dp9Upxpazad3jrvRHcgBgLM/YKlC7uszn2Sm/6jdoQ5RiKWY59qkzKi3kQHXhXD6LT0V/6GzZaAJZmIyGGjngpI6DZt3ZOoRogPCdsC7yBTM9u/fuDEikCexaSQSSrXmoB5Hty8M2PC2hlnVW3lLh3CUz2oKDNA6TT10wF8lv5rxq/Ds+NI2RA3ANrMOFHXjEb5ie/Bt6aXjfkZ3mpkpyt8Ao+7OlQCNclrjrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cpieBlBXW9ACR/P7ZUKIqhCeLSiGw246jM8nK6wHg4=;
 b=WsoL1Eg4B8GHfp+ezlGTVi7l4+QKaK/gIFRIILIQc1lQQJB5Jb5sDCdnVbisqj8yaJRCiwOFHmI+MD8sBxF632PwLIWHPKxRxEHnd13R68CeZZ2cPsqjoUk/VLad78E/GKXFUoxY+ecfZkOW8CwByQLcsumL/4sEGoMu5dNvX2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 14:22:38 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:22:38 +0000
Message-ID: <812de9fa-ad55-2d5c-6d15-a95bfd0181ae@amd.com>
Date:   Thu, 17 Aug 2023 09:22:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 5/8] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178459367.1147205.14975628669652538089.stgit@bmoger-ubuntu>
 <42d034d1-1fed-8d3f-a2aa-b9dcc5ea1243@intel.com>
 <1178bf68-f355-1509-0849-b740d2906bae@amd.com>
 <a8a9bfc6-1574-1a75-7cae-87e5349e94e5@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a8a9bfc6-1574-1a75-7cae-87e5349e94e5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:5:14c::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a45a885-f531-4842-4ce9-08db9f2d689f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WTroTa7xS5+KtHe994wBSoWiJMdA7jPiDkinrwaIHd+ZwXiZ1XuxMaNt6fbpm1/53DBzEaLNw3LZTSAba2HegtCDx92kf5fD7Hus+dd6Rd1CxVP/VKHjvtBkloZAyvmu0jLvuXXkupeZ39QeNjMPJCuSmTvE5wewmeUO/Vwn1+LcBMpJhc+MHdnmLbhVFlpWkieO3EVRlkgGP36ef4uTNJ1NecwnRmAMr2rTI/GOGGw4f0Z45DF4ZMwtqk9JkZIUjGANbeCODJ0SAE5Q9KgWGVbcrOJJ7rCjv93wPF2xkZIErLBG5VhsIqPXOG5lki9z2dCeg2/rLMZx4UyqYaw9mND23Ow5Jp0DvieG2pyt920Al2tknTlIdBKcnIMT8tfkEjjpW9aTnK1z85gfM85qqHsX5ESth4H6xRkJkajkWX7e1P02j277/YWLvRMGHXK/OJgnuyy4UWtkUbErXnhFFiuzhpDlGBJpkp6FGzEYBgk3QKAhJ+nZ12wZDfPo4x2aRc1fQYQD93MdsK6+I63GTJRjIPSVKcbpzDpHWYvVVfzF03J7QUxuI7PgMjszCiFTDHoUDDRLbxaNhQI+H0MT6ffkift5sJWa4eXLFkHZv9fwVn0u/SBB6FRmf/FiacFkXOAfhc6iUhg7axe5nyTZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(3450700001)(83380400001)(26005)(7406005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZBY1J1d1I5clEvQys0U05pdHlWMytTUHJvQmRBQkdETjMxdm9pdDI3dzV0?=
 =?utf-8?B?NVpoa1NScURWRFNURUVMM2syajRmTGwyTWpabzRvWjBGay9Sd3JKTXg0QU1m?=
 =?utf-8?B?Z2s3aWQzcW8vWVhpOG1ZUmptUnlzVnJJNnhjclYzSVM3OWJYbG0wR1VKVjBO?=
 =?utf-8?B?S2s0ZzlWYkxKYVMrV2ZGYytuQm9Yb2VtSW9HRjNLNld0bEk4ek1POEZDVTJ6?=
 =?utf-8?B?R280cit1aFVBOGhTSStZNENpNEpBb0RiaCtwWGc2K0oweFdMRzNwYWtINDBj?=
 =?utf-8?B?WmNEc3JBMzVLV2hUTWdzdDQxWUR1M2phSjlPakV5ZEthRzYxRmlVMmxjNkll?=
 =?utf-8?B?ZmlBRHd6OWVrMW1kN2VLcm9MbEs5dEZLa1hWRjl4QmNMN1loRzN5NG9JeWR1?=
 =?utf-8?B?Y2ZZTzV6NWQ5UmpKUm5yN2tOWlJxamt5VUNkd0ZCR09lZmpuUGRKVkN0OHQz?=
 =?utf-8?B?TnA2V041d3VHbXgzeVBXMEdQOWdzb2JrQmNkYWh5NDcyVk5Cd1RZeUMrbzhO?=
 =?utf-8?B?RVhJeDRIWkFZd2xQMnNRVzhjSmhkSEFRdmhlcEUxQzMxMVhLNDNqK3Z6UW1M?=
 =?utf-8?B?Y08zRGY2RmxlTTlZLzVpbk42ZFNQemhIOXczL3Z5T0xuMjVZNUlMRGUyTGhC?=
 =?utf-8?B?aE1FaEVET2pvMitSM2Z0cFN6NGFiY0tZVkFnUEJUS1dYZ1BXdldVS2tDdnBK?=
 =?utf-8?B?a2VLazNzckEyMHlHZFl5aUtPZk5jUHJrSENLaTJBVVk0Rkd3dVErUG9JZXRx?=
 =?utf-8?B?cFYvNEpxUDRXZERzeTlkWWZZQUtnSUdjM2NnVURHbldjUlFtWXNaT0dxSExL?=
 =?utf-8?B?dVZOdythWVBJTXZhVnd2VkErbmljOGFDNnpkS3JCOUoxbzZyc3hXaTFNZ3VK?=
 =?utf-8?B?TDZ4TFpseElXMDU4QWdCcXFUN0RMNEN6MWZzTldRaFpoUlQ2c25wNFhCeEty?=
 =?utf-8?B?dDlkSnBRSWZuSk4yUldpdXZNQ1dnMHhlK25UMkRwVHZLTU05VGJ3bW1QajJB?=
 =?utf-8?B?MnU2VS9pWUNqME42b2xWSDJjckxOUndINURPc1NORzRpTFArcTU3NUdiWTVM?=
 =?utf-8?B?dmN0L3d4L2ZXRllobEFWb3AwVERWc1pMMzlrRGc1czlBK0xmamxqL3M4Yk1J?=
 =?utf-8?B?WVlQcWwrN24yK3pVbVgxdG0vZ0ZHR0djTjRpekFuKzR4bkpqMEkySlJBUmJB?=
 =?utf-8?B?c3ZmRUVSQ2k3elBpeGZiN2NEejJQRS9nR1k0Q0llbWRZMGMyVkEyc2d0Q1ov?=
 =?utf-8?B?NkFpL29aTzduTllJUGxDRGI3dUdxZWRwUmQ4MUxlR0dSYlNtcGg3eTBFcDUw?=
 =?utf-8?B?clQvTUk5dExHS2NQTk45MlE1WThueUVIU3MwZWFQL1FPaVRlWXMxaU80M21T?=
 =?utf-8?B?YXdyaTloRFlOdnMxUkV1amRiSHAzQlNydkxBQmM2L0p6clFlS1NZbGlJVTF1?=
 =?utf-8?B?Y0ZpdGJrMXBSWG16cFN4OEYxNk1uUTFMWTBDMWdDYUNac1dJU2JBQld2VGZB?=
 =?utf-8?B?S3ZmVnVuOU9qK1JQb1RsQUYxa0hDdnYwV2N0SGNnZlc0NXRZQmtNUnphNWJ3?=
 =?utf-8?B?em5qZDNqVXl5YXgwRTU2bkgxbGs3eXE2K3RSa0pkRVBhbzU5TGxmcHZ6VEl1?=
 =?utf-8?B?SmxIWkp1TFBEWkRSQUdzVEUvMXhRL2VSVVhTRGd5aWFuRWNzb3hmNndxbGFk?=
 =?utf-8?B?RUJkR1dDQ2xpdU1lakU4UDU4L0MzdlEyeHJrNjRHZm9sUlFyVUc2VUM1dDdX?=
 =?utf-8?B?OEQ4aEM4eXFPWGdwcXkrWDJ5SW81aDB0VlduWEwwRURwSTBiTzFGNk5BVTM2?=
 =?utf-8?B?ejRsNFVuSjR2TzZSQ1BDclJPOTliRkprRjBXSXZmSjNmUkRqd24veWhGMGVC?=
 =?utf-8?B?b0dYWUdEdTJaaU90akdqajlKNDdwOUJlL0srTFY2eFZ1T0l6YWIwZTRvWTNj?=
 =?utf-8?B?OWRnUDA2T0R2Y0x5RGRub1M2YmUvb1IzRG9ZanVxWCtnTEJxVjBMZS9EM0Rr?=
 =?utf-8?B?bEtqUENoTlRzb0tTQWRRbStHc2FwY1gzYVZ1MllZdlVYUEVtZjY4a29oVUl6?=
 =?utf-8?B?OHlVMkcrNXRPam5kS3F4STFxVHF4MjlKdkdDT1kzekp3WkpGK1BMQXJZZVhN?=
 =?utf-8?Q?ZjTM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a45a885-f531-4842-4ce9-08db9f2d689f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:22:38.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVvUEZj1lMgzU5WW4pB2W7A9PaVDPMmrdv95n9wcf8CDfNVaIDz3N7TPmbTaO1vY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/16/23 14:07, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/2023 11:17 AM, Moger, Babu wrote:
>> At rdt_kill_sb() the fs context is already freed. But, we can call
>> rdt_disable_ctx() with no parameter. We will have to depend on other
>> parameters to free the enabled features. We can use the same call both in
>> rdt_get_tree() (the failure path above)  and in rdt_kill_sb().
>>
>> The function rdt_disable_ctx will look like this.
>>
>> +static void rdt_disable_ctx(void)
>> +{
>> +       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
>> +               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> +
>> +       if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>> +               resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>> +
>> +       if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
>> +               set_mba_sc(false);
>> +}
>>
>>
> 
> This looks good to me. I think this will end up making
> cdp_disable_all() unused so it may be candidate for removal as part
> of this change.

Yes. We can remove  cdp_disable_all() at part of this patch.
-- 
Thanks
Babu Moger
