Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FE813A77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573217AbjLNTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 14:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNTGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 14:06:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFAB112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702580800; x=1734116800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tpbOeoAf86Pf+5FT93PptmiPfv8DJmpW0lDAFrpeHG0=;
  b=ixKW0fKWYYfbZ9D1O+2uXnmwlYF4nIksvPDbuxx8wTp9d5XceGCuv4js
   LkQjlTMNgTlckxbC+CkO/SO8rMWAQm62fxKo+vUnGmfsSt9N0Un59XrZL
   Yaq5mkVS78PqqYje0fJbJX9SSvu0kz7nkBirdpjrvYBhpmPNHvFKjXR3s
   XcPv+DEPk/CuDzMdS/PDV9iqWZKWKQILFeZSDfNapVlwzRrSZpVqqehIM
   Fh3aL3azEGsQfLiFPg5aTjsUd+8bzEIeG9HlB2oBJhLs7bA/8goyENNFy
   SK2GzwRb+FTCQEeSG/0yZYFZXQdQbSzYy3ZuIMx6SGH6TdGi96baS52WQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16725428"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="16725428"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105839159"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="1105839159"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 11:06:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 11:06:11 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 11:06:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 11:06:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 11:06:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdnJWEvbLaorsCM16uygFdWx6tx38WLsOLU6jSAa/aqW3d80ql9ZAaz36yhkqfFMtmb0cT5OLwEhjcNdQkesBQGayOJhno4LsOcnAITpP65qdjH+WUm7IV/H4nnm+5FG3ajGOKjP8CAcdaFAcklMsgsYJeNFPGAuNf2qZr7o5Qb39Ow841RubP/BUAacWEGYs5E8tLea7u/pyU6RdJDN7kiLlLrApYi5dBKKr3apdSv7L7GW9OKeoM2ETk5hpZZFDTjXjsMoHyWSLk1FcO0CuhomD/XaOX15bhOAnVQrrQJTOhGq2r4Fomtlbec67LMnTS1HAvjhVpwn8K2AsOhu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlDPIi+kQuiQwP8zRu4q7d7DmyZntQjqXGX5P7N62T4=;
 b=b/y1okkHXUw/CS1LnFippQ6LtvKzLQIE+O842tMAk6SoeGUPGrOjM98lkkxZNmIpuDMK29pUikMrb0L/tOjDu8KE5lyJoDRSFw6T2V4CaVdvyTOM8ce22xvbhjRC9pePS4eVsdxa8b3uRG34i2bYE12MG8V3T1yJ3G0HCLHbCa7qMSiP2ThwW0hW5uwnq8WM5avOqj150+mNY9qHBL6TlVnuG0nwUE4XFLZ7QHe+af3SoRCsVSMNBtk8G+PUUu0ZprvvypJXsvJhO1RyOKNyrSvQRbrqsrEjjiKQrSSaMZ262KjJG7t4KYpfMTR1FYrWXYOxEQme16lhbgroU+mflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5466.namprd11.prod.outlook.com (2603:10b6:408:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 19:06:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 19:06:08 +0000
Message-ID: <c53872e2-1d2e-44b3-80f1-e39fb0a7330d@intel.com>
Date:   Thu, 14 Dec 2023 11:06:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-3-james.morse@arm.com>
 <208c3ade-a8c3-41cc-b136-4ab9b7e938e5@intel.com>
 <bd3afbfd-3372-cac9-600e-ace19ddd3199@arm.com>
 <cddbbbae-599b-42c0-abe1-4ca74d5ce36c@intel.com>
 <a5ef6b40-a9b3-5338-a12a-6a4540cda861@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a5ef6b40-a9b3-5338-a12a-6a4540cda861@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5466:EE_
X-MS-Office365-Filtering-Correlation-Id: 19101992-a2ee-4bac-75a6-08dbfcd7ba64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VK5ffjpmskz3mrCIXjYAtPXZKyC/wJoNExSXEIWO7UPvKYlF7Je76kQncc/vZY3yTsJ/ngif6ulkdjJRR5lmEmdoNCiAGQorm0v+HPrp2BkEF5KCMOzr8eZuKW+0gBazmvNQYDjo4k0mNuxFWutgyqmXiKRCRYhFd12dZL/JQJ6QbL5ZpVWsh4hsVPHRL1mWxT4WYWEqxI2zo9KmSCerLUZZua974yprQ5gs/mDXMdCAuheXbxztpM/rJ+++tUo2SJGW5iEF8K1rXG/ogubJYJSz1yzzGHDROPSLbLeXuZi0M/X2lvxL7m432J4zBUsnCngLpA0/+6JkTkX6EQVC95iD4KhG3Pa4Nx40JoO8HBmxwbiLDcr9dj5M6W0Lu4b3qZiuZurvjTk07JF9hrq0ao07dVe6FWzFjQX8Fl6F1wSp7xjVGkOEAR+6oLO7quwbu67hpK0uBeqTWtovXWsKU0Yv5bOkJ9n48TSkOwOWadT8F3XEbuxUpB9qxGtzj9BXoQ4cFZ/u7CWV0jZbCP/70KfJ0mNs8BZmh256VBY3wrmExbboQDnjkycKpoiiUi6nq9HReY3GnhG5ij7i5C0f+5B2OfnPQBDunPeVY+VlwYUdMbS1Ez3qK157gKXllX8D9ESIbJWcegRjSLWx0TbX8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(86362001)(82960400001)(36756003)(31686004)(31696002)(6506007)(53546011)(478600001)(6666004)(26005)(83380400001)(6486002)(66556008)(4326008)(44832011)(54906003)(66946007)(66476007)(6512007)(316002)(8936002)(2616005)(8676002)(41300700001)(5660300002)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2sraXl3ODlic3cvYUFESEUxWGRoM3F2S3FlNXpDQnZlb1dyUlV1VkdCRERP?=
 =?utf-8?B?M2kwbUlPUVU4NjF3Q2N0ZldHblJaM09LeThHMVlzTjNYMWhFN0RkNmVlYnhr?=
 =?utf-8?B?cHRxYjUyTGtSWW9oZ1d0Y0hJVFloU0ZLQ2JoWUkwLzZMVnVzcUZCVzdQZ3NS?=
 =?utf-8?B?TXg5U3BtbnJZVUgyQ1diemdNd3VadG9xWS9BeVEyc0YvbWovRDVuekpiNmRh?=
 =?utf-8?B?dGNPdDNlemlQNElnaS9IN1krYUVqbGNRVnUxK0RSSWhkRGlLd0kvMVdveTBk?=
 =?utf-8?B?bTRZUGtsSXkzMkFFbWVvblZVRG04TW9rUHdTTVBLK0g1aXZBMVVxZFhUSm1w?=
 =?utf-8?B?RlJ1OW9EQ1FlaUVpK3BBcnZqYm5henpOZVV6YVlXWDQ4MGY4YVdZMCt3alpr?=
 =?utf-8?B?VGdacW82Q0FDeGdKc0ZFakNUbCtGMlN3MHRRNXFhQjc4Umw1SEVUTUQ0TkV2?=
 =?utf-8?B?TzhCSGNUNWdpMzFDTFlYdFU0NmhPRjJTSFp6dG50Y0Uvd21WZGdaMjNEYjBN?=
 =?utf-8?B?dldoblFjdTd1UGI4TUdrOGMwaC9RR2xiQzloMWhzNkFXblFRRzNoR2NBRW13?=
 =?utf-8?B?UDdDVEpMdU9iQ2lLeFVieTNtY1ZMck4razl4WEVobE9HWTJDaHRvVVpHR3ZS?=
 =?utf-8?B?TElnYmtTejNxUnlBV3BYYmZiY1lGY1JUbXVoZFE0a3k0dWJ1dSsxMGVaR2o3?=
 =?utf-8?B?eTExdktQRHI3dGlnMzNQYnNnTEE3QXl0NWNSSC9LZXRleDhCTkFZLy9kOVJO?=
 =?utf-8?B?MTN0dWVCS29FTzNUU3NLUjF5c1FSNThqTDUwa1VMdlIzVElScFdkZEtmcE80?=
 =?utf-8?B?c2R3VEtNazFna0g2R1lUMDA0MEJwZGtNZzdYcXZRUlpvTERtcC9wbTFjaHJo?=
 =?utf-8?B?WTFxb3ZsVy9ITkVYaTFid3RkaldPUkFkK0FOWmFqM0s4RFdUajgzWk14QzE0?=
 =?utf-8?B?RGlUd2R2ak5sM2k5SWoxQ2FRSEg4NVRIOXZYTU1zK2ozNC9DZk9USmNRTVFV?=
 =?utf-8?B?RmN6QlhBKzBNSGpEZmVoRTlCWlJxQW5PSnRpS1dBY1ZudXZRVnZEb0pHUFlm?=
 =?utf-8?B?M1M4Qy9KSjI3UFdQYzJMbkliS3UxdjVhTTBLT09FR3JxV1hRYWw5dU9razlL?=
 =?utf-8?B?Q28ySGRXczcwa2FkbTJJbklDeEZaVDhOQWhYa1ROSlpHVkFaSDkvMnBwTkFI?=
 =?utf-8?B?WjMySzZReFVub2J0UWZuZ3VWV0F5dmFrV2kzMXVuaDhHSDQ2NThvSGx3S2RX?=
 =?utf-8?B?bCtxeVdjSWxCdlVmUHhiMVk3M0pXOG5CVkhROXR3dzZTeHFuSElHVVdEZmlP?=
 =?utf-8?B?L0RPeSt5aC84Z3grTi90UWVsMkNFTWFEQmhsQk40WHUyUk4vR0NYLzBHN2wx?=
 =?utf-8?B?dE9EZ1k0R1ZpUXh4aGlGYndPMHRWdnFZVTZKdWlBMHlSVVIwbHpxckVYUU9x?=
 =?utf-8?B?Tk1aZ05kMUZ1TVFWYTZlcnRvQVVRSDNNcnVmTE9VMTAvMlBQTEZZM2taSzFu?=
 =?utf-8?B?LzdtaTYraDJZb0h5elYxclpPNVM1bllQRE5OTjEzQkNGMko3RCtmM2N3Zkl0?=
 =?utf-8?B?bzNsRXZ5aTliWHRMZnJmSHE4dUdWQTdsTDRsenJKQWtDOUxxY1lFeVVqeHlI?=
 =?utf-8?B?Y3lXZ2FwK1NhQUFWTFk5aWVFYytKOURlY3RmREtCMERRTE5NRzhweHRodEVl?=
 =?utf-8?B?aXNaZmdBeGZXcFd2eDV3WWR4b2dKc3JNclBYaE9RZnFzVVNPZm9wcVpmV2NB?=
 =?utf-8?B?Y3h3RkhTSnczeEU5aFNxYUFzNFpjSzd6VER4SVRCQXN6YmYwUzVENytlRnJV?=
 =?utf-8?B?Wm1seDFmL0pnT3NsZEpHaWVHeXd0bWQreExYcHBQMmtsMUpmS1JOTW44eUNU?=
 =?utf-8?B?QkxMTFNqM3RrRXduM0tSWWZVVWpiRGwwSmVWbWN1TXNUb3ZNeDdrcExpeWY1?=
 =?utf-8?B?dkk4T0RETW5nV3l2NEZMajB3b3N0b0FXcjI0b1pUTmlXNjM5Rm10aXNud3Vo?=
 =?utf-8?B?a0puQVdVZlZxVmdnb01ZWmx2ckUwNVJlUnBzS0I0dms3WG1mdG4wZDhjZjdN?=
 =?utf-8?B?MEt5Z1VybEh6SExob3VPb0F1MkoyV255aU96RmRBamEzUmJMT3ZSRDNJemVI?=
 =?utf-8?B?bVBabnFJMjFyTzNyeVRmSEtaRmpaQXZlV0d2Rk0yUStwVnV4ZjlQNnR6U2Fi?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19101992-a2ee-4bac-75a6-08dbfcd7ba64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 19:06:07.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWxyT2193EDifhAkHRXRwKb3erx3Hh301SvuzqebvRHQkuJ3bme/0xbOyLDaekQiI7GWVSofhvD8fa7rfSeLyoJKqff2wZP4xxIl4caETBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/14/2023 10:28 AM, James Morse wrote:
> Hi Reinette,
> 
> On 13/12/2023 23:27, Reinette Chatre wrote:
>> Hi James,
>>
>> On 12/13/2023 10:03 AM, James Morse wrote:
>>> On 09/11/2023 17:39, Reinette Chatre wrote:
>>>> On 10/25/2023 11:03 AM, James Morse wrote:
>>
>> ...
>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> index 19e0681f0435..0056c9962a44 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>>>> @@ -992,7 +992,13 @@ late_initcall(resctrl_late_init);
>>>>>  
>>>>>  static void __exit resctrl_exit(void)
>>>>>  {
>>>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>>> +
>>>>>  	cpuhp_remove_state(rdt_online);
>>>>> +
>>>>> +	if (r->mon_capable)
>>>>> +		rdt_put_mon_l3_config(r);
>>>>> +
>>>>>  	rdtgroup_exit();
>>>>>  }
>>>>
>>>> I expect cleanup to do the inverse of init. I do not know what was the
>>>> motivation for the rdtgroup_exit() to follow cpuhp_remove_state()
>>>
>>> This will invoke the hotplug callbacks, making it look to resctrl like all CPUs are
>>> offline. This means it is then impossible for rdtgroup_exit() to race with the hotplug
>>> notifiers. (if you could run this code...)
> 
>> hmmm ... if there is a risk of such a race would the init code not also be
>> vulnerable to that with the notifiers up before rdtgroup_init()?
> 
> Nope, because this array is allocated behind rdt_get_mon_l3_config(), which ultimately
> comes from get_rdt_resources() in resctrl_late_init() - which calls cpuhp_setup_state()
> after all this init work has been done.
> 
> (cpu hp always gives me a headache1)

Right. My comment was actually and specifically about rdtgroup_init() and attempting to
understand your view of its races with the hotplug notifiers in response to your comment about
its (the hotplug notifiers) races with rdtgroup_exit().

The current order of state initialization you mention and hotplug notifiers needing the
state is sane and implies to expect an inverse order of teardown.

>> The races you mention
>> are not obvious to me. I see the filesystem and hotplug code protected against races via
>> the mutex and static keys. Could you please elaborate on the flows of concern?
> 
> Functions like __check_limbo() (calling __rmid_entry()) are called under the
> rdtgroup_mutex, but they don't consider that rmid_ptrs[] may be NULL.
> 
> But this could only happen if the limbo work ran after cpuhp_remove_state() - this can't
> happen because the hotplug callbacks cancel the limbo work, and won't reschedule it if the
> domain is going offline.
> 
> 
> The only other path is via free_rmid(), I've not thought too much about this as
> resctrl_exit() can't actually be invoked - this code is discarded by the linker.
> 
> It could be run on MPAM, but only in response to an 'error interrupt' (which is optional)
> - and all the MPAM error interrupts indicate a software bug.

This still just considers the resctrl state and hotplug notifiers.

I clearly am missing something. It is still not clear to me how this connects to your earlier
comment about races with the rdtgroup_exit() code ... how the hotplug notifiers races with the
filesystem register/unregister code.

> 
> I've only invoked this path once, and rdtgroup_exit()s unregister_filesystem() didn't
> remove all the files. I anticipate digging into this teardown code more once the bulk of
> the MPAM driver is upstream.
> 
> 
>> I am not advocating for cpuhp_remove_state() to be called later. I understand that
>> it simplifies the flows to consider.
>>
>>>> but I
>>>> was expecting this new cleanup to be done after rdtgroup_exit() to be inverse
>>>> of init. This cleanup is inserted in middle of two existing cleanup - could
>>>> you please elaborate how this location was chosen?
>>>
>>> rdtgroup_exit() does nothing with the resctrl structures, it removes sysfs and debugfs
>>> entries, and unregisters the filesystem.
>>>
>>> Hypothetically, you can't observe any effect of the rmid_ptrs array being freed as
>>> all the CPUs are offline and the overflow/limbo threads should have been cancelled.
>>> Once cpuhp_remove_state() has been called, this really doesn't matter.
> 
>> Sounds like nothing prevents this code from following the custom of cleanup to be
>> inverse of init (yet keep cpuhp_remove_state() first).
> 
> I'll put the the rdt_put_mon_l3_config() call after rdtgroup_exit()...

thank you

Reinette

