Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77488779862
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjHKUPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjHKUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:15:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31453593;
        Fri, 11 Aug 2023 13:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5YmxT6l+Y+zfmOTkz60kT0Jg/5Sf3vsx9QO0ArHiVh/iVOnzF87rgr3vbortnxfd9D6GvuVEq1Le8HSfBdJTMZran7KJwaPgJIT4iXBBfbH0Y2yYJfX0H/WGLUtNNHncsDzJCixtSD5C8ibEzKw7nkQyYEge0d02PPKnMc6MhPSXiYKmbnR0DSv672ViCqEyNnhSzSl8V1/2+wRsiU/OFyezmCm/6gImW4NidR+qS6pp/nuB8oLxIFAM7oSTBl8VCpDXtgvDiGt+hHV/nLjJXnOZr9V7SEF8sTJIX0MTpN2Mmb+TC6vCqVH8KmxjaIhEX7YHoagaDc1OFLytv4k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/FPp5K2dO8nVVDRvWi6xM2sKLhYl1JwPtNEqQmezv0=;
 b=dL7LcJROp3XEKtCW7+UoCDPGmWZB7cRJuvYiDF2ijkePjP2S6+7DAMEndo6C2873ySwjoB2wxkaGWpgrNduEGfFIvcE03f/j3SALw/E8BXbVLqmNrYeAjznBUyyt31E5U+MuN9Lw8vgOnlS5ztAuh0etl28l1zjMnsr2VcxRRuPMIlpOj9Po7wuS1zVSMzWM9EscZN0BZ7oEW+e9tPg49i4sIaXCEmvGx1W5DNb1782OLyIJGEQoW368SS0eWLFnzieVZP2cxnfJog5pbem50KfmlPRu3DjnXyD5uO2b1PcpCw6uEaVZqDL9sld3u0sbsnRgooCCfFmDl0g4ZKLwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/FPp5K2dO8nVVDRvWi6xM2sKLhYl1JwPtNEqQmezv0=;
 b=pk/AetEjiSCTFmfo/pBr7lgb0ka5IlCsYEI9irqiwCafNmA4sIrY7mIcYKzkJO4iBCLvp/JqhlaDJd4ay/Pv0WfG+anRGfN2CYw8ma3Zgj0KBlfkGf5f7k+knDxhQeb7hZUIjF9wSJ1yrqDJY0SKOxWipnfIpjPdwKfYALGANSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5370.namprd12.prod.outlook.com (2603:10b6:610:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 20:15:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 20:15:36 +0000
Message-ID: <07632753-39b6-126e-bedc-d6b3851dca35@amd.com>
Date:   Fri, 11 Aug 2023 15:15:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
 <168980891501.1619861.11056885467637617879.stgit@bmoger-ubuntu>
 <41c166e8-d6a2-7be8-1d4e-6b2b1cc62f2a@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <41c166e8-d6a2-7be8-1d4e-6b2b1cc62f2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a658fb4-7125-473b-886a-08db9aa7b97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 272c22+kUNxoBDEUcS585k81P1y6HhHHVRUQfmY9qBUuyG6FOLEdvMH5Sg2OCSLbU8iKP409fvNGgE4uo5IXeFMLZAY153hjLTuGi5N9h9HABAse+MKrzAwCuGWQjuQx93xqw7gJOWypJvxoYneQDrKcLch4Dm6pdsMWhbGL8PvOHm2pBk+2UiXPu7XKOKLsUafxk7qg0oDP3wfnBwrA9X2wd1lrgxLI1mKSsapKaDEb7G2WGTDgZNqouoEtLmI9+JM1NtfdFPxEQciwO5wqDvuEZe1aAQgnV72Vru/2UvzIqst7+aYhq4OSNr7LhI33SmXFrRSvALchqMnl+tHm6NtMbxAUZ9qYKbcC9UDNUJsDjiYJoRVD1ZDrLuAs2tKiwFklGQx8DtWkSj3SGRu7Zdw22J2dVRcqzRF88REWD4ox0atN30IfQdM96Uh6la+8yqbfNPRkaNR1LqLXdVLhSGaK2sqB7iBHCaaafGVzgmLtkK2Wb4tWoy6Xyu5kXMcrlB/vCG54xwllt+GN3qxEtioPjZES4TUA5bCu3YpS11+EsOC7Md+UfMzOBx2IPE+PGljP/GyezdqM1efnEJcLf99CHrv60r9/ab4ssKR6r4EaG+D1Q7bNh8I1PJJ3+THJskpQGDXv543K/wvq6PPbww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(136003)(366004)(346002)(186006)(1800799006)(451199021)(36756003)(2616005)(6666004)(5660300002)(38100700002)(8676002)(4326008)(8936002)(6512007)(31686004)(86362001)(31696002)(478600001)(7406005)(7416002)(3450700001)(66476007)(66946007)(26005)(66556008)(2906002)(53546011)(316002)(41300700001)(6486002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aytUUFdqcmYzVVdRUjRUVCtjMVppL1ZoOWI1ZVlXMTZTc01vNUsxTHl0UTky?=
 =?utf-8?B?dWNpSFVpWFVsZmxaQ0d4c3ZpTmdzRWFXL3F0TVNNSDEyYmQvQTdyOUF5RXRN?=
 =?utf-8?B?eVN4R2tRTENvc1k2ZlVoQXBMSXdhSUFsczdNbDY5VXVqaHFhVXJOMFlvMnFL?=
 =?utf-8?B?YWsxQUhDdndWeXpWVjZrajliNmY4ZUhxc1E4SFpzQ1Q0Z1M0Q1FJMC93aDdJ?=
 =?utf-8?B?VjR2K0tGQ1d2cUFIaEtWQUVFUVI3MHFXdnVaVm1iNkE3amxIV1ZBaXcrejNj?=
 =?utf-8?B?b0dlZUVtNFc2djl2eTJZMUpXUUNDQTN2K1Vac3RmdU9ubEpzcExlVERJS1lM?=
 =?utf-8?B?NzdFNVIwT0RXYnZpOFEyVldWNlB2R0wvaHR5dTBlUysxaGNWalF0Tzl2cVY2?=
 =?utf-8?B?elNDK09CMVNldjd4S1REUWtnL0QvRjNucVpzZTRJNHhMeXhVeVV1eUNrd2wr?=
 =?utf-8?B?TjFIVWtUY2x1TzNLR2JwK2FWZUdCeHZoMFp1TVI1QmVlUS9kTDc2WEZrSE40?=
 =?utf-8?B?S1hMdnlPZFp5UEIwazVxRHU3WGpnaFJnWFdoR1dWOGVIK0xIU3VWWnM2aXlB?=
 =?utf-8?B?VmprdlZEZ1l0TkNFN2NESFliWUZ6TnEyMHdVU0FGc1lmRGg0bFJOSU9hQkR3?=
 =?utf-8?B?VkwrWHExRVRNUFdvTlZvQ3NUS2NtK1RzdFd2eFVWWmpMNi8zMGtadDRsWUpO?=
 =?utf-8?B?Y3ZQZHR1c2FPWWNOM2JGUW5kcWhscko0KzZDS1BWK1NXTnd2NjRwd3JpR1pz?=
 =?utf-8?B?eDd5VFkweHQwbVJOampPYWROSW9KejlRQXZ2eGZrUVJiNGwrWERhZXVlNk1I?=
 =?utf-8?B?Ti9penIvWU5SYU8yM21MOE9leHM1azBGdkljeXd6MDFQQjlVb0xBOUV6Z1Ru?=
 =?utf-8?B?anZhUG0zSW95SnJWcDBxaUw1TkQzTGZHUXZOajkwM21HRnJJZHZlbEJVcFdH?=
 =?utf-8?B?cHJvVVhWclRqanVoN2pYNmlXZ2lOZDM2dU9ZaFJTcDJoMC9CTXZzZzBZN2pP?=
 =?utf-8?B?SmpQVU1neVZzN2pHUDlaQjlsR1lTREw1UTQ1QkYyZzFyL2QycjMrZDNuMVNl?=
 =?utf-8?B?eENwY2dSN201SGRCdTNteDhvZzIzaFYyNTg2Q09XbVVoaitrNDZKZVViYkxF?=
 =?utf-8?B?Uy9FQVdRdVYweUxYWGpobGcySVFMUVFmdGd4VWhVemZsUXFFb2EvVmtvZVZu?=
 =?utf-8?B?UGNLVzJmeEhEbmFiUGtpaWpDQ05uaVVDVWxnUUFKVGhWUWREdlRuUkVERTMx?=
 =?utf-8?B?VTNVUFhyT1pXUzQ4enZYbWVyMERQWXBaaEpBdEcrVWRUSWJLaUx2MkhHN1Nx?=
 =?utf-8?B?VUttME83M2hFbWFzcUVabjdXZWtxOC91bWM2azFIdTVuL01nZDZxY3d2UXBk?=
 =?utf-8?B?UUh4VmdVM1BFKzRzVUU2RXExMWVIWnVPSXljdEJxVEgycjdSZGNKUE4xTkls?=
 =?utf-8?B?eEtLRFUwSTByK2U3V1EwU25PNC9IbFFwWU9Bb1Bzczk0TzV6bkhoODdCeWdM?=
 =?utf-8?B?dmgxc0tEUDJNcjVrV3dnMm9PRlRHaDZlUXhGTXk0RW1jUEdSeis4Yk9WUlJE?=
 =?utf-8?B?dm1zNVFWazBaSXgwMXVnTkw4ZkhFWVlxZlU0V09aZFA3czYwc0RKK0NvcjFr?=
 =?utf-8?B?ZEo3T3NDcGZGcytRUlViUVRhQm5nblJabUg3SnBXVnFyMUtMbURHVGNjSWRH?=
 =?utf-8?B?TlNNK29jZ09reS9RdmI3cmxKUkk5VHFJM1VZeTgrWUFCME5hdWtCa0R1MC9r?=
 =?utf-8?B?YTYrY2VnS085L0ZUQm1PZWNsZ1RDYTRXa2pEWEYrc3Ywd3UzV0drcHUrZUds?=
 =?utf-8?B?MDM2TnpwKzl4cHBNdEJGbUgycW1hcUVicXRFUTd6OXhFWVZnaVhDQmJGdEM5?=
 =?utf-8?B?algrL215UUZmQnczUVlVc3BjcUVvY08yV3R5MXdFVE1ValoreUR6MmltdFpQ?=
 =?utf-8?B?QTNlVnBJZlFXVmVDR0s4ZklvR3kzQ2o1M0hLOUMvbm10TXNuMVdISGpDaTJT?=
 =?utf-8?B?RmF2Zk1QYWVyRVc2aUlhOC9nOE5ZMzY2U2k1RDloeTBHazAzaG9uSGpSTjlp?=
 =?utf-8?B?WXJVSmdlZ01TbEpOZEg2TzEyYkJGSGNRSFpIMUR0WVpYYTJTeE5uVDViU3dQ?=
 =?utf-8?Q?kchI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a658fb4-7125-473b-886a-08db9aa7b97e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:15:36.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xptpXHxbmvO/t93FHXW2Nc0KyBolFzivTS6kS0z7mRCGHA1N41rG5+ul37EL8Pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On 8/4/23 15:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/19/2023 4:21 PM, Babu Moger wrote:
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_INFO
>> + *	--> <info> directory
>> + *		--> RFTYPE_TOP_INFO
>> + *		    Files: last_cmd_status
>> + *
>> + *		--> RFTYPE_MON_INFO
>> + *		--> <L3_MON> directory
>> + *		    Files: max_threshold_occupancy, mon_features,
>> + *		           num_rmids, mbm_total_bytes_config,
>> + *		           mbm_locat_bytes_config
> 
> mbm_locat_bytes_config -> mbm_local_bytes_config
> 
>> + *
>> + *		--> RFTYPE_CTRL_INFO
>> + *			--> RFTYPE_RES_CACHE
>> + *			--> <L2,L3> directory
> 
> Should this be "directories"?
> 
>> + *			    Files: bit_usage, cbm_mask, min_cbm_bits,
>> + *			           num_closids, shareable_bits
> 
> Based on the hierarchy presented the files mentioned here may be expected
> to be associated with RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE.
> For accuracy it may be better to move num_closids one level higher so
> that it is only associated with RFTYPE_CTRL_INFO?

Missed this earlier. Sure.

> 
>> + *
>> + *			--> RFTYPE_RES_MB
>> + *			--> <MB,SMBA> directory
> 
> directories?
> 
>> + *			    Files: bandwidth_gran, delay_linear,
>> + * 			           min_bandwidth, num_closids,
> 
> Please remove space before tab for a clean checkpatch.pl run.
> 
>> + *			           thread_throttle_mode
>> + *
>> + *	base (root) directory structure
> 
> Since "base" refers to more than the root directory I think this can
> just be "base directory structure".
> 
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>> + *	    Files: cpus, cpus_list, tasks
>> + *
>> + *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)
>> + *	    Files: mode, schemata, size
>> + *
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>>
>>
> 
> Reinette

-- 
Thanks
Babu Moger
