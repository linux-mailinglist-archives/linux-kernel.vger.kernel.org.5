Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB279D6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbjILQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjILQyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:54:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1B170A;
        Tue, 12 Sep 2023 09:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMN6HUF/96Z8Bh9Os3QGHL2x9vuJEoa/6F+xhYTDj6P7MsHC8g8OGE8B6two2b2ibpqqKISFNR2SOFav/zqkWUU84FbhBIho1AZ7Fd6j/7thCVJ/YOcOkxKnJFKAVah4UXu61i2bD4odEAbGVRf952a7TdG8AVHdUi48N3E2CMfhdmHmTKNQ6hIHBk/uatOZ/3Mb0IycefZI0em3eIygqZBdo3P7tp4uC1xf8jyZbw5NQAy6IF7XQ6s97z/uc0JlQnJ+i9P++HWyXYzSd/jQDc6898VcuYj9iBDGVPucpyhcRTNhHlh5FwYoimUUumlrqSi6y7RA/7WIywAusbXV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA2ie6yf6GqgX/8hFFHKWHr1sBpNsvRAavgb7pLouH8=;
 b=T6Hpj3mqCpUYwmfq2uuQBaKKyA4eIaLjMTmiXQ7uNhAXrvB/ZKOYV01qnYNC0jxlolyaSDA/M5IQb+LzTsrwvZHDJHwnwWctnlu9e+jGKfiN5Rka5aAM8O7OCa2qi3VbKA2XAySz264tRxrZs73FuOVw3bAC4SWMzcepK0ODm3+5rYcEW3hW/gRvjQXEMJjcR/t/ca+Zte73/PIIt2rovFinsbLTscuuJLuA9lAbT5MoDByIU+i7qWcovMdkTKRJwUbma7Nnpk8EQMpsRqvoaQdc/0GLS/OGXfFrcw3BWjKh5lswW/PRxOKPhrujFn+EpzI8+eLAbDljdcq1UTDjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA2ie6yf6GqgX/8hFFHKWHr1sBpNsvRAavgb7pLouH8=;
 b=hjXtF0wE5YBCz40Mv0YcSFA89DcE0PVfzyg++xTx6WalYRh615jFF9Wob/1qrjI5zMLlp+xgSwYNRl1gcX2UqVawfawObK95rzZCwJg1KEFQNX/f8qlMIe7w1cgdsB4D/taAfY/V9xLbfJr+JDkcTzKPygys63aUkA3eKlszzmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 16:54:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 16:54:44 +0000
Message-ID: <2d6eb068-f326-7397-bf0d-d47fea01f199@amd.com>
Date:   Tue, 12 Sep 2023 11:54:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 5/9] x86/resctrl: Unwind the errors inside
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-6-babu.moger@amd.com>
 <b22da35c-ceeb-7116-b33d-4e596980bf80@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b22da35c-ceeb-7116-b33d-4e596980bf80@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:806:f2::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 996c4cbe-8bf6-4851-1c97-08dbb3b0f715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBzqpmxg/vrQwOjgELuL3zeGWy1P440k2c4LEXbC+FZX41XeFnfJm2IhO6YO3QuNCby7GTQa6ov8LAlEXGomwpkm9GuzaTVN4IMOsHPGO5nbr/TqAFHSPtsIrviJbgVYZR6jcIV+nPTleSf7GKiDJo/JtMAFL1EDl+HjiL+/ofjDqDumPqw0zNfNpz3MxzLntvaT23ZuO5WpuhIGqlDZi8aobiiq0B1R073I7QPQxkus8Rsr9nvvDrSd3brHXnwFesP5Wr/mNzb+utaUuD8NpUR0wsnAzOtT9cGrfNRvo3k9q/7x0rTUzPv59KUhA1rZMuk8kLAp97ySfFsYn3kRGZV84VTkKqkqGeqVM22OLok4wtmkNroThdX5oKCE3meBZE/ywE7kUFKK+VTdDYIVQYSZgGWik7sBIyC2t1JwDgcO3igfT1/b7BvN2kOGxckhOBJj04Gog2HVFYC9aTjH3Di5A8xCqs8aFKZkvXjPTy4uTl3ifbkD2mj/i5DnLsehyYf7H6fGjt7/7iFS8sHwwO1KNtviaLMkRbNqJQ+odgq+DXRyKlJUeHKxIsyd5TFUM1VjPS8ky25x2OErD/65LNkvrPCaXnNH1ws4pzr/KXcGNZlAs5tuFBLvBb4c/jdoujTqqMv0nqQ0hipTM5G15A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199024)(1800799009)(186009)(31696002)(2906002)(6506007)(2616005)(86362001)(3450700001)(53546011)(83380400001)(26005)(6486002)(7416002)(7406005)(6512007)(38100700002)(6666004)(36756003)(478600001)(5660300002)(4326008)(31686004)(41300700001)(8676002)(66476007)(316002)(8936002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5SbUFkYVhVSWVMVWZBOGZBbVdMdTZiWHg5c2djYU1vUThLYldUU1grU05p?=
 =?utf-8?B?R0poNHhDM1Q5eFJYZDV0dnVLYWlBc29HeDlLZ1RSTWtRM1NtOENDS0dINCtr?=
 =?utf-8?B?djlvcGJ0ZUhabmdMUENFcUZEQlovTTdlQUg5eVVCWUk5eU42N3prVmlTd3lZ?=
 =?utf-8?B?QUdmS0VvS2JnU0ZYRlRjMS9XTGtXNXVYd1h4SFJTN0FwZ1RUa1Mya2xtblNp?=
 =?utf-8?B?M3N1RThOYVk5Q0p3L2VkeStMN0dGa2U3RnhCdDlTK2tTUjR6SE16c2FNQ2tp?=
 =?utf-8?B?QjFGL216WFFWMEVUbGVlS25LbDg3ZmVXL1p0cWNibkFUY1AyellmQWkyVnk0?=
 =?utf-8?B?MkcvNGZsT25QOElvRjhvTks0Z3llSWd2cnpjWEN4YTdwZHZtZExzZ3Z1YnVW?=
 =?utf-8?B?Qk01ZkJmK3JnL0ozQzVTd2FaL2lmaVppa1lBdlZMQjMvN0x4SVBJT2l1TXF4?=
 =?utf-8?B?NkNZb0xZdUJ0M3U2UjkxTXVTL0lKMDdEZWJWdHVjbzUyWVBxcFdlMzQ3akZy?=
 =?utf-8?B?aVRGVTZpTFNVUXI4eEFuOEhuclk1djE5UGNZNGxvOFU2NFB5K1hJVmdzY3pz?=
 =?utf-8?B?Rks3am9SWkU5WldqZG5iV25LT09DU2MweCtNSndnZ0M3VndwWElNWml5V2Zh?=
 =?utf-8?B?dnZ4ZlFvYmF3OFpaREVtOWdQNGpSQVRZSFZpVUUrbzQ5ZFp2Ym1MdVo4V3Fn?=
 =?utf-8?B?MTZsZFhxSll1cHl4NmJ0OHhzYVVHR212eWwrYWVRT2t5K3JPTWlTR096UWJX?=
 =?utf-8?B?VU5vZXpPMnRWZGJwYm53VUZTaTRGbVl1MXVVdFl6ZzRxR3RCUmlHaDJoZkFz?=
 =?utf-8?B?RktJZ0lIV1U2RkhIcEVUMmRxbHFNTVpkK3RMcHJUdnJxMGZMMllqeURuRGFy?=
 =?utf-8?B?c1RFaHRMWjkwZjdWOEZqeDlKZ2RtMGxSaWRPWFZoUlFQY0JqSDBxdHgzcEhL?=
 =?utf-8?B?WlBaN2hsQno4YTJKMGpjUmgyZE52SWF5aFlsTW56VjZRdGdtV1Fxc0pnQy9a?=
 =?utf-8?B?QW9wbjBhVGhWNTVHcTRibkEvQU5sR0Rod3UvdEJCeWw5N2dza2xONS8wRFV3?=
 =?utf-8?B?NG13N0ZjK3ZSeGxPd3RDWndoWmNteFd0Y2gxUXI0bWhpd3dXaVNZaHNiQnA1?=
 =?utf-8?B?Q0tQQmM3bW5tYkE1ODhkQXRGakhWMW42YkRyTXd5Vis4WStZYkpSOFFNOW02?=
 =?utf-8?B?Wjg5M1Q2SmwveU4rdWRIQ0IyTTVmMWovWnRRZ1FGTXpTRjJYd1VPZDhQZWdo?=
 =?utf-8?B?YmNHenVRdExTcFlLTHdUY2Y3dDJhYW4rbTFrUzBzblpxdzR6eUpyckZhbzFK?=
 =?utf-8?B?RFowWldFU0ZLWmI2bVQwL0p0bmxjNmV0S0pCOVFVM0VPTVNlM0luemhheVMw?=
 =?utf-8?B?T0g1QmZ0SFA0VXJpK3ZQSWhydEJDWWFqOWY0Nk5PZWwxMzN5ZkJYbzZZQkc2?=
 =?utf-8?B?ZFhTZHZuLyt5WG9nZ0lsUmpTSDdJTSswT1owdFJQdzVqam1paXlOMU9ZT2tF?=
 =?utf-8?B?V0paL2FBQjgwblp2a2U0S2FaaWIzTEljMFFOaU1jeEtoWHhsb01jTUpwaHFO?=
 =?utf-8?B?a1ZwdnZQVE51dEQwYURLVXFwSSsyb2NlV0VTMW1WWTl4NkN5MVJxeHFvRjlo?=
 =?utf-8?B?T3YvcHl6QWVxM0FHNzl2VmJ5aXJGTXFuODR0am9COWxTRVZodTJWZU1iQWgr?=
 =?utf-8?B?UmROU3ZkeVVtdWg4WXc3N21kMkJ6REtISmNHVWhteFNNMTJSSVgrVmUwQWdQ?=
 =?utf-8?B?eFUvRU5xK1hNZWw5RzBnVlpqT01HekcrVlAreUlMSjBEeWIrQVpUREdQWFNU?=
 =?utf-8?B?QXozWUpCOGVsb2I2TWQ5b1NoUEFUMVhzdG5XMHEzdCtKYUg1Ym5WbE10K1BB?=
 =?utf-8?B?ZWprKzFKbVA3L0M4TzNndG9qKzFNN1Z2OEhMbE94enVHQVFOcThlT0czMEJv?=
 =?utf-8?B?YVRBRE45cGhEdTVDZ0VnRW5WZy8vL2ltTHM2QkFTV3dlOERBREJ1RkUvQ2hJ?=
 =?utf-8?B?bnEvaksrelh6SThYL21zWURFMTF2NWl3Vkx4LzZya0QrZUdmc3E3enFENkdv?=
 =?utf-8?B?MWJJdHdwQXFud2VjWnRXOFNicEdPenNEVlpHMU95bE1BWENJT1RTMjROUUs0?=
 =?utf-8?Q?IV6c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996c4cbe-8bf6-4851-1c97-08dbb3b0f715
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:54:44.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE5qHac18rFi3YtsgNLOX9btH52SK8dWY33TqFh2w5EzykfVfZbQLTpnQxryAiIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/11/23 17:58, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/7/2023 4:51 PM, Babu Moger wrote:
>> rdt_enable_ctx() enables the features provided during resctrl mount.
>>
>> Additions to rdt_enable_ctx() are required to also modify error paths
>> of rdt_enable_ctx() callers to ensure correct unwinding if errors
>> are encountered after calling rdt_enable_ctx(). This is error prone.
>>
>> Introduce rdt_disable_ctx() to refactor the error unwinding of
>> rdt_enable_ctx() to simplify future additions. This also simplifies
>> cleanup in rdt_kill_sb().
>>
>> Remove cdp_disable_all() as it is not used anymore after the refactor.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> This is one of the patches that received a change that was not
> mentioned in cover letter nor in a patch specific list of changes.

Yes. My bad.

> 
> Having a list of changes within each patch in this area is
> helpful in reviews.
> 
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 55 ++++++++++++++++----------
>>  1 file changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 35945b4bf196..34cb512be1de 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2290,14 +2290,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>>  	return 0;
>>  }
>>  
>> -static void cdp_disable_all(void)
>> -{
>> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
>> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>> -}
>> -
>>  /*
>>   * We don't allow rdtgroup directories to be created anywhere
>>   * except the root directory. Thus when looking for the rdtgroup
>> @@ -2377,19 +2369,44 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>>  			     struct rdtgroup *prgrp,
>>  			     struct kernfs_node **mon_data_kn);
>>  
>> +static void rdt_disable_ctx(void)
>> +{
>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>> +
>> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>> +
>> +	set_mba_sc(false);
>> +}
> 
> Could you please remove the empty line following each call?

Sure.

> 
> With the above change you can add:
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
-- 
Thanks
Babu Moger
