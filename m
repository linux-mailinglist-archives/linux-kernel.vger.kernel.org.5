Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF8807875
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442777AbjLFTRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbjLFTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:17:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE1D46;
        Wed,  6 Dec 2023 11:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhEEBnTBI+MBN0cKP7shXlPL6ppWr/QEZkPMqZRhwlrCSd4rFRlwUOlKstbFPgIGMOk66Ux7vguOjBKeD/Sv50VPqhVKL+vQRmAF38XuuteyWc0Xyv0zOU0UuyMNQWYDsSWGqCBX6I5IAi6mUlShDKU4XP5CVQ+Gx7nFMwvla4McZegomWi6JPAn3ImAUWBVSmJLAiNEhwGflLetVzfkFD3GJtleFgKxx0QrURvs8CBNK/Onso48yIKSxRkM0r03IeTxF9YDpOcXS/TuCgb9i1MNilS2f6tmOr2FlTPimkAMsQW8hj7Ajg2zWEXqdGdOxldxfP+nnMY9kmUa60CDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPMdyZalGGvSjjVcvOYautshIl643f1vqkav+STgSF0=;
 b=N78nRThDdwf1zh83TEQ+3X95Z+pZHFsWNtzDJ8J2bjBbxzqjhb8xD7DRBCsNU6puoL6pnD32z7/Covnei0SmLKh8LqjAOiNpNHyHwGgWez+VC8aK0JA8ekD0jMIfb++ZsGMamRfXO7Xw4hphtl5lFLhIwyrVBDrIMV6GLuOY8yhGxTykbXhK7TsvQ4aNHzBo/BAGhepkosMPCFqmmObIgRPsizEPO0c6lNWktQzm6CQUZ+V7HhJYB960HirztM/46fQtwFMlNjs5DQ41EuzJDNdf5l1/QHCgZFAqEnZqUC9HnoWpeP7dy7lSCg+8NSdBw8yruAGIf/rfZ9EmWE+Grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPMdyZalGGvSjjVcvOYautshIl643f1vqkav+STgSF0=;
 b=422xvqN/9N48dnpBIVPad9LYp0OZtHPoKtM58fq1ZLuWUg1XjRQkSCx1VCqkXEHhsSvrvXjygM/qnxscaZ/sV7FxxaA2IMN1MiIQF+7wzszIQ9AGxlK/7NC4H6y3kJNx0R2NdRFH73QycvyweqraDg6ZtODuvPXB49sT5Nyk0Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM3PR12MB9328.namprd12.prod.outlook.com (2603:10b6:0:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:17:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 19:17:39 +0000
Message-ID: <ca471e43-b7ef-40f6-b0b3-3c79aa3a0d61@amd.com>
Date:   Wed, 6 Dec 2023 13:17:35 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
 <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
 <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
 <19e3fd3d-a2ec-4c8e-aa47-44f8f41b569b@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <19e3fd3d-a2ec-4c8e-aa47-44f8f41b569b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0023.namprd18.prod.outlook.com
 (2603:10b6:806:f3::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM3PR12MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1557bab3-51b0-4918-6e09-08dbf69002e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PyyyMqsLpT8uuogtxDdFk4EWGBjEA8o2SCeszmEXMZjNTZX12uoIl+VyKjB3WZt2AMUtbcOHBeLU9JqA/AUMtosVt0NG/y1RY+hqa5/b34SEQFLjsGb7cnKZLPcoLyhifE0FAIsi4hLK6pKG3Gt5K6HgV/uJKWAC328sbiEyqDBnffQ9X2nK3xhBtMkZoNYd7XUPD50Ij7ZfgRuWc3G6DOCUdulFDPWFM6elsOQ9fszOrvtJpbFKJEzpPEoGFnIzAkC3J1lI+bdUGGSrtBVOzPAlwawNkC7ckrp6ze7yAFdCE/dNwsdDw3mhRizdGj2El3dBNKKsuPDM4zUzUqwIKdi6ahCfROtX5hWm5X0vl2HGA5LgHz8TmE0vu3iPTxylHcKQeAqK98GzlnzZAdmaoSNv8DlMpJzEWvUcirmpxWkwVmrTnCu5WNQGbuxqRAU2wLHtByPiObnJlCoUw4xIw/OB1oruo28/mqq3FpkId+kldeoRP1mHzr5BS+W9UBFw/4j4Mu+HLZqwBNgG+CcnQOM4fqdqRZ2MwS0OX6wZZ0TdcCD1Z/o0jM9NPhY2j/bZ8l3GjoewXebWLr64zDgpUbOxqTEy9e53FwFz2rycH++h9gzAIdcU0AzJbORrcXFO21KxdNsP8Q+7ionHfpL2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(478600001)(6506007)(6512007)(53546011)(8936002)(2616005)(6486002)(26005)(6666004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(3450700001)(38100700002)(7416002)(31696002)(36756003)(2906002)(5660300002)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YksxRFM5b2tqQ1MyQzIyeUVqYlRFVzNHNmZmd2luN3BHNTA0QS9hUlBCekdH?=
 =?utf-8?B?Q3owTUdMS0FoUGpBNSt1bDEyWXptTHJra2xzUnlWWVRpb2x2clRRWlhJSUVH?=
 =?utf-8?B?dzhhVmNXK0J0SXlNaENLRVUzNjJzK0o1UVhxTzd5ZzJPalpFc05zcVpSbEhK?=
 =?utf-8?B?VnkxMVhaWlU0dC9qMG5yMlc4Z3dDTk1QZ3orSUlURGJhaGkxaEhKbDRZSXkx?=
 =?utf-8?B?U0hTVEpNZkVlN3kwQW1QdDR5aDRnbmxuZWlVL2VJU2FySUo1N0dPSE1xdVFE?=
 =?utf-8?B?TkRPQlVXcUl1TFFYN05SMTBXZWFUVHpRdjZJM0tRVm0rSE9tRXRUM1cyUDFO?=
 =?utf-8?B?L2lXelJaRlRRNmV2T2I2emd1Y3NhVlpsam5oUkpJdDhsZWdBQkoxVDFuNTVV?=
 =?utf-8?B?bm5zV25OVzltVU5uWk5VUmNGZHhDNXA4Z3YyWU03V0VVOWdxQ3oxS3ZIWDQv?=
 =?utf-8?B?KzdTL1F3L1dodDROYm5lUmwyZW85b1NhVDB5SzZ6T3ppVGpNU1dXa3o4dnlO?=
 =?utf-8?B?WEducG5TYTBER2xLTFkwTkNwVDloc00yWXpxd2xIVnFjc2NyNktnZ1MzWUsv?=
 =?utf-8?B?N2tHdklDK0dBcVo0VVF5OUhDYWIzSUJlUzVmM2xScHl4b1EyN1Yvd0hOdzds?=
 =?utf-8?B?RHliRUU3OFBnbVpWSXJaT2RaVXpQN0hmcktaWWxTNXlMZm0venphV1Brd0pE?=
 =?utf-8?B?b0lNYXEzWldQSDRVRiszYW9qYThCakVpUW1rckxER2xPbmY2cytlVDE4cTBq?=
 =?utf-8?B?dWVyeVFFZjBXbVdkcTQxYVVTcGNqUkJkU0haRlVpUHZaaW9TUHpjL2FjaTVz?=
 =?utf-8?B?TVVyRW00YkZQUElOZTA0NUlCUXplaFBRV0p3bkY3RVNsVi9vZndmZHR2R1Av?=
 =?utf-8?B?ekN6UVhYbW9RSld5SmpSNzRCTkxTR1pMaWY1UlJnS2MyaUdBS095ZFozZ09k?=
 =?utf-8?B?K1doZmVKRDF3K1pHQ1EwQlNJbFBSVU1zcldKZTVZVEFHSXgxaFpkeGFpcEs3?=
 =?utf-8?B?cTI2b0NWSjRvSmpYYlVQbHVpUFdLVHEwUjgxOHNabTNTVjdxK2lOODRzcCts?=
 =?utf-8?B?eVhoMHJVd3p3K1F3d0p4RnZqZEhlakVsbmJpSWhUVUZPZi9KWjFNQjRyeFlN?=
 =?utf-8?B?ck1lTFVsRHU4eTNmL3VhZExKT0JyaXhlOXNzdW5JTTJXeEJWcHdwampUb1Ba?=
 =?utf-8?B?ZVBpeWpuN1VUcGQ1RWlweVU4cytDS1MxT3drdEFIMi92eUp3MkZxNjFVY1JC?=
 =?utf-8?B?SDMzQjJ6YkI4OUFQbURKM1dwRnNwVFNOUlZBWjZFUTM5RCtPQi9PbzlGbm9p?=
 =?utf-8?B?RW41OE9nYVJMVTdYZ3ZwK1VpUGRlallRYXZwMjU1QytYRTlBbEVLWXhYaGZn?=
 =?utf-8?B?ZFdPL2FyZDFYc2NzZkVoSHFHbFQ2MGdCa1pBMExaOXUrZ1Y5diszVzBVREFa?=
 =?utf-8?B?bmM1am1QbjFKWjUvMWxhTzN0QU1uK3ZNbEt5aHRhbHlSeDduRHVHSStFNXhG?=
 =?utf-8?B?Nkl6bFRlWnZjaFB5SEZtNHArNDAzRnBabmRyb0xEeEYwa1hIYXBIT1hCWVFX?=
 =?utf-8?B?dGRRc3A2SXdPTmppR0U2a3ozU2lpS09BN1ZFYXJtOW8yZ2ZibTlwN0dlM3ht?=
 =?utf-8?B?QkNYR2dPUVF5YXFaeXZpV1dvZjArM3FtODZjTURoeVBKWG9aeHV0Q1Z2SG40?=
 =?utf-8?B?U3FRUWhjMmJDNCtYYzRNcExqOVZWWk1SbWtrNFJVdWJDL2RMZlJXTjdPTlZt?=
 =?utf-8?B?U3lrckFZZFFzdGZ6OUVNUytyOG81N2xRa2huUzZLVW1nSUZiZlhjNkk3OEN4?=
 =?utf-8?B?dm1wcDVCYWthQ0pyeENEa1NNc2x6Um8rcG9TNWZGRkFqWGFHd215QWEralhV?=
 =?utf-8?B?Z1krUjB3YkJONXA1ckhUOFZ0alcwWFpTU1JJOWl5TVZIR29CNm1jTkR2Rkxv?=
 =?utf-8?B?LytrcGcvandBM3Zia09FVHRHTkROaXpzSEZLNWZHaDYrUnQ5czdNV0Mvd2JK?=
 =?utf-8?B?RGpQak5NeTdlYk5oRkpVQTY3dHpQRE1SV09PZ3BPTkVqYTNLQ2lyZ1djNmlo?=
 =?utf-8?B?RGZMVUZZbldLeEJvNlF2Wkc2by9ZT2FQUlY0a3JqRXRVcnp1V1M3V1VsWE5Y?=
 =?utf-8?Q?CrKE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1557bab3-51b0-4918-6e09-08dbf69002e3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:17:38.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw81akBGrTcsarttQaffEVfFKvFhuzMQzP1GekwOC8F9t8Eux7Nf1ZuZ7B2RGn5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9328
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/6/23 12:32, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/6/2023 9:17 AM, Moger, Babu wrote:
>> On 12/5/23 17:21, Reinette Chatre wrote:
>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
> 
> ...
> 
>>> Comparing with supported bits would be an additional check, but what does
>>> that imply? Would it be possible for hardware to have a bit set that is
>>> not supported? Would that mean it is actually supported or a hardware bug?
>>
>> No. Hardware supports all the bits reported here. Like i said before
>> wanted to remove the hard-coded value.
> 
> The size of the field in the register is different information from what
> the value of that field may be.

Yes. it could be.

> 
> 
>>
>>>
>>>>  }
>>>>  
>>>>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>>>> @@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>>>>  	int ret = 0;
>>>>  
>>>>  	/* mon_config cannot be more than the supported set of events */
>>>> -	if (val > MAX_EVT_CONFIG_BITS) {
>>>> +	if (val > resctrl_max_evt_bitmask) {
>>>>  		rdt_last_cmd_puts("Invalid event configuration\n");
>>>>  		return -EINVAL;
>>>>  	}
>>>
>>> This does not look right. resctrl_max_evt_bitmask contains the supported
>>> types. A user may set a value that is less than resctrl_max_evt_bitmask but
>>> yet have an unsupported bit set, no?
>>
>> I think I have to make this clear in the patch. There is no difference in
>> the definition. Hardware supports all the events reported by the cpuid.
> 
> I'll try to elaborate using an example. Let's say AMD decides to make
> hardware with hypothetical support mask of:
> 	resctrl_max_evt_bitmask = 0x4F (no support for Slow Mem).
> 
> What if user attempts to set config that enables monitoring of Slow Mem:
> 	val = 0x30
> 
> In the above example, val is not larger than resctrl_max_evt_bitmask 
> but it is an invalid config, no?

Yes. It is invalid config in this case.

How about changing the check to something like this?

if ((val & resctrl_max_evt_bitmask) != val) {
                rdt_last_cmd_puts("Invalid event configuration\n");
  		return -EINVAL;
   }
-- 
Thanks
Babu Moger
