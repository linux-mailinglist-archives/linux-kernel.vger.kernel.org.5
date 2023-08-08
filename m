Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911E7746FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjHHTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjHHTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:07:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102CD24F9;
        Tue,  8 Aug 2023 09:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrbY1puNCpcc2wkyUQCHMXCA9WglWn8wWJr6xBxxQS64m1ZUzefTX1lvby0P0MdRzBGp0Y126i2StYbHx93GQAOwiPI+qLM5m0yWQDDdVFL0OG+MTDMoIHc/92A6DOqGPdijjb+338VfdFF0r0Pwd/fd9kP+Nc52G1PmZGoVkItYdXpfvzSQeuBsn5aZeyykmXRhMhhOgbvNWxqFSydec+aUGdpuUJ1MC+Tu6wBJ/5qSrjzbIaHjbkvrEB0n5L2O9nQk5+/npJahUL9Hh9/eCvS33d3UjTXsfUXwRad6iegQUNpVoiTqg4XovLQyipJP3ZhOnHm0H2MgWv2u8Ki8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtOSgELKMQV12VyldJRPxa1f1D8zAaFOBIxtAgoVUKc=;
 b=edJ5vbWS9bfTXwQ2DCBN/j7CWxTvqt0adLtSNvxGp6zP/6cjLw+yqOqkVRtZNkwFWIPFA1yro2GrX3IRkNKnGqNmMrA3dsJ3XARMm0bgxsXIx4hN7D1pXXZWJteRJmKS1Ob1m2myPqZX5ZU1+7CF3gWf/qzAiSIf/bLIN56b7/ykYnAGav6LuMWWGRHow3eYFMP4YkLhrpFblu8EolF+Beidv9GgsykR3e/RFK1qv/kX8M/I6BgUs/RHs9sR6PWe1oSpmrImhRlle8Nj741r9txVPQbUu8UMEcToyd4sGX+0cgEEWT0WzI+HSOT+rjwkzYCl+q1mlnbSa5wQkm6mdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtOSgELKMQV12VyldJRPxa1f1D8zAaFOBIxtAgoVUKc=;
 b=Dnm2sqDuKo/JrkZP1fUbTqwJApIzEx10D4vm5ivaPrWBqZA6jxRBxdhwR8BhLpO8TCnTGlPbXFq6EqGa9TXG6P8otEEofAauzGuGoQLU9RmUKliFWbuJAUW3tPsaCf0wf+64nQNFQ5YbWe6S+L2Q8H164bJy7A9FnjneJvW3ui8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 16:29:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:29:24 +0000
Message-ID: <091884b4-d479-9b24-013c-8d5dd9eb4ecd@amd.com>
Date:   Tue, 8 Aug 2023 11:29:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 7/8] x86/resctrl: Introduce "-o debug" mount option
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980893967.1619861.7249871216790436466.stgit@bmoger-ubuntu>
 <68d6d4a4-80e4-2aa5-409f-0e2744c20e88@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <68d6d4a4-80e4-2aa5-409f-0e2744c20e88@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e8054d-3960-4f15-1309-08db982ca073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z5O883orKw/5IxUoseddp6hxnZ2ooBEoDrBFaovHoyGFgGH7qOvAeqOB2lRRqWNj4WLKYBmfTyr98AvIJH3jU2kjIhMBTmzzf7gJU6kc0O0mvZnHeQivkY/rmQiH8KWhYr/JCQYOIv2U1hYYeh8DSldY8H7k8rdC7Z8RxFYTvVulzGcjHPz8Z6p2xmcvvC41savKzt9HYaFAEP7kCMwsaNmGZSgnbO/46LoyGV4wWYBRkKOJG8LZuDmvuZnG6Ir4yTlhRopy5mt5FowEZasIA02W9bkgovZ6xNd3woRIWIE6XsK8Syl8PF0UI97eNZOqWAkg4D5/b1vsRcaFrbIlRvdwYRY1OviU5JeLPW6Ku/pUJ95IHkl2/mU0Wrvo2SYpxVBbEPaE+umShxGabkE6NWZC3dXO70I5YezOv8qwhOoKcFcMhhzzuSZh7NhPkEIneyoKhVc3H9esA5beA2+eam3fsSmq818b/E6WeEXEt0G7PGpkj/sg5Uff8rktqDPMPPRliP7GVdQN7ns3MMo1y4uysUs/ifEobVV6vONUPZXWNw9wJ40Fpn43r7JxPMihJX1L8gjgGfuqr4On8gidR1jyYFuckH6/6VD9CnMVc2BvwckIhmd0kCDZfxTvoyH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(186006)(1800799003)(2616005)(86362001)(6486002)(966005)(6666004)(478600001)(31696002)(6512007)(26005)(36756003)(6506007)(53546011)(2906002)(41300700001)(3450700001)(4744005)(8936002)(7416002)(8676002)(5660300002)(7406005)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxQUVJHUTduMFRYenIrNm4xSnRuZWwzaXo4NEZxQ2I2cXZacjU2M2pvRnh5?=
 =?utf-8?B?QkJjMEFINk4vdXBTdlUzUjZXanJwb3A5ZnJOK1AzZHNHU2M4aTRXbjVDN1Vv?=
 =?utf-8?B?dFhFTGRuS3c5cm9vbjJsU3VmMU1GalpnTHQ5UFZPZkpiNExDWVBRTy9lU0ZU?=
 =?utf-8?B?NE1BdzQ2aFJnWXJWTGdRS0lBZ1BBK21hT3I4MmxqMWNsRlNLWDd5VXM3T0Fr?=
 =?utf-8?B?WVRBc1JFVTlHOERHNE1ESGNhTGtqWWVDbldHM29ybzFiVEVPWHdZSW5ha0s1?=
 =?utf-8?B?djBLdzZXZXVXZXNUT2RGcjg5aW03QVQzcGYvQSt0WjZjbkNObzQ2KzN6NS9n?=
 =?utf-8?B?ZTVNS3dQZTUrckFzSGhPL09xNTB3dS9mR3JCWjFybTYvM1o3Tmp3U2paeXNY?=
 =?utf-8?B?Q0tiQm1mTGZhZFo5YVVEUi83eVNIS2FkMUdVMG9GRmFsZjIwcVlvZmUvTDJT?=
 =?utf-8?B?dU5qMFN0U3BjaUpCd3crektBWjlFMS9iY2dDOEVRVmsxa2YvVUNFZVU4dSsv?=
 =?utf-8?B?NlRSdUkvZ0x3MEcrMjBPbUpmTkhGVXVpdDl3aThiSm9YZlNYc09KOVBNaVl6?=
 =?utf-8?B?Z0RPT2NzTldjUVdPaExlZ3ladGJqR25CNzMyU0Foc3hBUnhsWllTeVlad0t0?=
 =?utf-8?B?UktUWFU4TUpjSEZmemZKZDN3WXJLMk1MdkNXeG14TVhRTjFWOXZpM2lrY2tF?=
 =?utf-8?B?SWVxZ2lSVDBZSmo0Z3N3c21IMlM1S1ArU2ZwajlhZjVlTTFzeGU4Rkg1UlIy?=
 =?utf-8?B?UjZjYlFLLzJKeFBZWDlldzd0ZFZWRmRNaFgvOXJGenNld0pDYkRhMnphMjBX?=
 =?utf-8?B?NWM0ZjQzODNsNzdLVFlLY1RYa1Z2azcxUytOZXNTRTloVGxNSngrR3Fqd25Z?=
 =?utf-8?B?aFcwYlBQVjA5ZkRzaFZWdmxHTmFuUjE1bmxKcUpQaHZwaDUySEJsUGZtRzI1?=
 =?utf-8?B?VHVHZlAyczNkVnhUYmxPcFpvamY3T0NsVHF6ZlJLL3Vta25GbGhtb1VkV0oy?=
 =?utf-8?B?c0c2WmFlNVMwMXdrUHBOclBqMFVlM2FCWEl5b05XdWk3WXJyM1A3T21qSVZ3?=
 =?utf-8?B?Mzh0aTVaM3BNUUZmY1BoQlBvK0U3QnAzWEZSUmFUOEhzMDVucXp0R3RBWFI4?=
 =?utf-8?B?cnluamJLK0FuS0lPUTdsWXJnMXBOTUZQSnF2RDhUbDZZOUxlSUxYZzVwUHRa?=
 =?utf-8?B?SDVwdnRXSzFpdGtKZ3VReVY3SzNSc2VydXF5aE1XeGc3NXVDMGlTakZoemhz?=
 =?utf-8?B?d3B1VlNQQ2RIVS9VV0c2dHJOSGtFeGFUajR2VmZFbzFsY2hiWW5BZUV0SExZ?=
 =?utf-8?B?ZVh2VkV5K3hwL2gxTXhJU2hidVlkMFhIWHc2ZitKVUN6NElrM1craG13TkNQ?=
 =?utf-8?B?Ri9xMndoclphMTl2bDlJV3J2SDdKSFZOblVYdWFRMDZubVJxRld2aEZsd3JH?=
 =?utf-8?B?dVNtMGlWbldzaUJNTkJDR3QrUkNOUWE0ZDA4WldqZ2tIZEQ1RVNlOGpqbFdt?=
 =?utf-8?B?blJ3RjVUU1VaaWhDalJSU2RLSWVtbTJ0akRZMkVzY2hFb0RsTU0yRmRWdlN1?=
 =?utf-8?B?VjNNcG0xL1ZmM3lIWTMyRXgzem9YMnhuYml2RFNVZ05lajRETHcrQklNMXZp?=
 =?utf-8?B?RXZvaUY4a2I0eFg2bHpvOTdjcGlpOHR0NGNiN1J6SmQxcVBFSWF4SEp5bEdU?=
 =?utf-8?B?VStNcWxzamdjUTEvSVJSbFdSUWlWaEY5K3F6YWN2T2JBMzhtSUFNSDJQTGlo?=
 =?utf-8?B?anNwYlBUVkV3akxIdHluY05UY1hIdXZYSnAybSsvdUJJUDBvdzVQeWgyTFJh?=
 =?utf-8?B?aXpjNlRBYXZwNC9ISE1RWkoxVTV1NTNFbTZqTHB4YllyMExaTFBhelRsM2tx?=
 =?utf-8?B?a1JQTWVkV1RVNTRkbXdRZksvNDZVR1RuM3NFTFNKVmVIRjQyaUw2UUNxblRW?=
 =?utf-8?B?UEM0MlNON0ZvUXVPNDBHcFVkR3hiM2FZaUd1QmxiV1drY0ZISFdReGY0RStM?=
 =?utf-8?B?b0dxbTM3aldiQjBLTFhuVnVLaWZSdmwyVXh2cWtKa084eWtPTFArZ1Q3TWdS?=
 =?utf-8?B?UnVQdUVhaktWNnkzTm1qUnJBbDNYZ1ArR1pJSmN6WjJWbVk0U1A4M2krWWtW?=
 =?utf-8?Q?Rrog=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e8054d-3960-4f15-1309-08db982ca073
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:29:24.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdE6NNr/5PIRBN3aUPV9a+Z9CZmeWZDeh5dBhLpPUGwwe6C9nW4m/OYnkz+OLEbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/4/23 15:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/19/2023 4:22 PM, Babu Moger wrote:
>> @@ -2591,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)
>>  out_schemata_free:
>>  	schemata_list_destroy();
>>  out_ctx:
>> +	if (ctx->enable_debug)
>> +		resctrl_debug = false;
>>  	if (ctx->enable_mba_mbps)
>>  		set_mba_sc(false);
>>  	cdp_disable_all();
> 
> These changes are a red flag to me. Developers still need to
> do what patch #4 was aiming to prevent.

I think you meant patch 5 (x86/resctrl: Unwind the errors inside
rdt_enable_ctx).

I can take care of this unwind part in rdt_disable_ctx() and call it here.
https://lore.kernel.org/lkml/9fd70ef3-ca90-65e3-4746-7d574bdd159b@intel.com/#t

Hope that is what you meant.

-- 
Thanks
Babu Moger
