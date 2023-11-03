Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633B7E0AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjKCVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:43:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524051AA;
        Fri,  3 Nov 2023 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699047805; x=1730583805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9yYNWPtPxCQFKSuCUM/8ypb4iP3rtYm7hYsLPe2Lr5A=;
  b=f+zK+SNTnMiuypN+qBYrdLiBlkEUlGZDcHpKcImqgcj34efwzCo04Ip/
   sYPLYQpMxnwv/G1AGuXSKEcjVm6A9++56mViVvuz4H8xBkaz+EI8gEeyO
   UYB+z7qf/8S3am3hdP0jg6lZS4sOa15MadkObEVebo9gpgvI8Tq5qBKqO
   IjdBTQIbLRyowZlsevjYUFGvSmy47KYDncppbMli0BqIG/igYx5vK+Y2x
   NYLXlooFkFNljZOit4cvcbqMoHD2835plPgOn7lsevsfSM4CS4/sO4kiF
   5AyJXK207mLA5XNh28BOoH7QAqg4HiCMdjrPoSEW+469HLTzDtVxxwpOZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="7659648"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="7659648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 14:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="755284255"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="755284255"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 14:43:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 14:43:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 14:43:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 14:43:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 14:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqwvFuWwJITPqHnylkYt3mEWltlRkBd7UjExa3sqRrrn2wkRNqXGFUEJY18U0+u/vSI5grrvE4n/HrE6xs/mX25JVcFSdqf/fUW7STsP4JHFCMarNT2iTNFVrS5j+zr5gVsiweX6D7WMC8vBEgaw1LIgGAp2LqrKqbL+ixSF+I51PiBnOVsxYtORMonzuShCR1+IfK4sQMNKUJ1u+xbBjEvj60iYgEteE4xyckO6vXt0A/x99ZJyTAyjl0PaPwYaP0Jw1iMFn2/npsnkrSVP0iX2bhZ4aGvf5kejOr7G7cbOUmmwfVhlBJXjXeQL4gRVtTrq8aOov5uaRqS+hvABwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENfnxhT3IGOtbJuHz2wWs6yHFGvUtZEkqMQQgCi2SDg=;
 b=X7fvtHqg95BlDXX4pRKxQKvcVLAB/UVVjFottKeRL/iL53Z6S22MODksS4mg6y0xU0NIW1GeZzEy74z0FjtlWUh7gz6XVwC3wOqahyX+Nfc51Zf+X8qT7qZbavH7tN0im8TcSNybAy/vaS5OhwrMDZ+7W7WF+CxBLCzDRLglpxnDePKBKqtxOnyQM+yzDX+hTrpMvDRT/v0YJkGy6MRRIcZQGSx3SvYgYKKZiVPNqackZn6M+w+pRTpxvEuV9IxhjgcXiPZ9/BVteP8Ahi0IT3cJZiOVRUXZcNdEpCdwvT/kb04RHF6degbpIlrhTp92u7uwCckC1ePjP19dv2nqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 21:43:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 21:43:18 +0000
Message-ID: <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
Date:   Fri, 3 Nov 2023 14:43:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231026200214.16017-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0258.namprd04.prod.outlook.com
 (2603:10b6:303:88::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 724f1f20-0fe4-4db4-b3db-08dbdcb5e48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3OWADJpHWaZVJ2Yt9gzGYTHlCVfBHDpDDg3HmiE2xkd8j6Dh1BsZGVM+DSY9ym02ENPj6JN199E8h9HA8G5ZgHgsNjsMH0HaQJdktfHAJZhUtmENGtlOnrQJtQPWwsKJT6dpr079neniKkW12jSvR3n4mKCt89at3aOWct5xYrz2OA1SMygCkSKXATeuMGNcC9SJfgVjnJjzpiiYOULjWawTgGyS4xPtPKjSE+RSXQzi5HY0G1vadpCaQFqQpQy9nOadeL/bOO0clBg1P2JY6syYvZLMTwpuDpj6eRVQ8oxtEJzuf1V/lhSMEHyAeIDcGzfi1jmvXHZGotyauq5mfVifOWglD76XxfQ2Nwqa2or/ykDHqjP7U9tEtCkPl5dL9F6X2UOV3QwlyObhL5cE9k6wNxOrdnQQvh3zReYulMgE5T1LT0eq7GBEeDXWfOVjXAEDjQ+fzT5WrXGoILzyzwhgaJ/Tc/gmWs0geOq+yr6hLewwFAy6tyOwv5RnNIjhLZL3u9y1L0p5GK5E7P5D7cGWEsTxzFYKw+6gu69MwW85gVRIveTni0Hek7sA3DsgTZ+JpIJXKltCl3H711zDwZMR8rjTWO6TE11++tCWxjhhUIixWMnEPvwuvMrUv9md6Qxo2OdFyGuKzcc4pECGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82960400001)(7416002)(54906003)(110136005)(66946007)(316002)(66556008)(66476007)(36756003)(26005)(44832011)(38100700002)(6512007)(6486002)(31686004)(41300700001)(478600001)(2616005)(83380400001)(4326008)(8936002)(53546011)(31696002)(8676002)(6506007)(2906002)(86362001)(5660300002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9teGFFWnB4Y2h5TUNiTWlEOU90amtLMTRsVUFocE5BdzI5bnVSb1VVVGRH?=
 =?utf-8?B?eWJqRFk2bC95OGpRY3FnRHZsOFZCSERvbWdiSHN4eG4rNktzVE1oZDBFMGYz?=
 =?utf-8?B?M3hKSWVib1B4dk43UHpQYzJGTExNamYxMUNFZ0tSR2N0OEI3ektvTUs3TXo5?=
 =?utf-8?B?VkVzRzd3ZUgwVHNMZUV3STNKbGl4R09vcFBvSVRXWWtQQkJaa3AyTEZ6NkNv?=
 =?utf-8?B?b2NtSnhVVDBNMExicHk2dkpjSVZuMGlYZmVUbHRSTXJXTFFQdndRSGFrS1p6?=
 =?utf-8?B?UmYvdHZWajFremM3YjQ3SFlKYTAxZXN4N0k4NEFrVW1zVGsxdDM5NjNKMlJM?=
 =?utf-8?B?ZXRUOEI0djNCb0k1SW9xaTBhdUJtT3JLVllXWnpTYlJIdSs0RWJKc0xYZnZG?=
 =?utf-8?B?WlVEZmEyenhoRXRIU1JKMTc2YWw2eElrbGpPamV6QXZQUkVudnkzYUhuSXd4?=
 =?utf-8?B?NTlVZ3lacW5SdlJBT1kzYWsrQ2dBMUFvUE9TNStxbG1pSHZzZUVNT0pxYVRF?=
 =?utf-8?B?SmVJbVZLakRlRUltNGtPcXJqVUVvUzRSZ2pHcUFNNmJ0ZG90UHZZYXEzeUNP?=
 =?utf-8?B?UGNJaG9rYmpPQnh0VXJDVld4cHRKdFlpWXhDWEFTT0toK29sNCsvMHFIbExI?=
 =?utf-8?B?L0crOGd6ODFIUG1DZkZmanJ1U1liQ0dWdTBKekpBWEtuQ1JGL1FrY0NGamNu?=
 =?utf-8?B?SVJuQjZBczdTamppNVpuQ2IyLzRMdU1VbElrODFLQ1lreE1sTmx5ODFaTnFT?=
 =?utf-8?B?dVE0eENaenA4TnhzMEtLbEoxRkpNZ21hRXYzRmZxTXYzR1FobG1pbGNITWJJ?=
 =?utf-8?B?ZVNqcTg3Q2FPR2duVXpJaVl6dWdxWGdBWVkxa1hNTG5JVGNreTdqMVBWQU4z?=
 =?utf-8?B?ZFBBT0JQS085dFBYNWhJeHN1SnV2eURZVWNFOVFoL0RYRWtyNVNORkRkeUVH?=
 =?utf-8?B?aEt4TVZYWE05cmV5NGtTUGV2UXZLM01UOU15aXpHR1E4TkNkelViNFdnMU0w?=
 =?utf-8?B?b01TNHBMVzFSRzE5cGQ0UWJNT0RndWtSU2xvVmpuVzluTFF3VnB3SDRwVWdM?=
 =?utf-8?B?aFFhR3NrV25lY29lUG9XR3FaaWhIZTV3cDdEU1piRCtmNUhDOFEvczRzbzN6?=
 =?utf-8?B?d2NNUHlGR2MxWCtqL0plcVF0U2lXMkxUZjhvQW9OYVR1YVVVUm9rZFpXd2JO?=
 =?utf-8?B?MFovYUk3Nkc2b2FkbWtlSjJ5ZzNKVTAxcmtKZkdRMU52RTh4YStEWUVvSjhj?=
 =?utf-8?B?UExac3lmOFZQVDhSaWlwWUpHWGZvTkdOcWJmdWNZNDB2RFJ3eGFKTFRJa21U?=
 =?utf-8?B?Qm5XVU9iU3NQS2gxUWZjQ1lkak5iRldSbXd4a2RCMW16UXVNZmMwSjVoTkNz?=
 =?utf-8?B?R0swa3pYTERzTFgxVEVKSzZQRTBoTkgvN21iT21MQVc4cWljVmdOZ20vVnVn?=
 =?utf-8?B?aFZjVEJydzlGaFB6eSt1a3lsMXNkZVc3aUI5Zm83bzNXNHVyOHNleFBQQTdp?=
 =?utf-8?B?QS93STduWTZqaEJZWkFyWWRtYWRCNFU4eEIyRTJmL2tsSkFKOGMyVFV0bmxq?=
 =?utf-8?B?eklNYUtvejd3VjNZdTdrblFTS045c3Y5Yy96d2graW9BTWRkSkYxUTh2TFZK?=
 =?utf-8?B?SmdZRGJmdG1JTUFhNTlzOXk5MFRCc2xZZDhIbVlIeW51TVpRRDMxZkgyR0t0?=
 =?utf-8?B?VEk5OXp0dzdVeWNwZU5TS0JrSWJWbEsyTElaWEk0eVUyL2prR1VFZklLeWx4?=
 =?utf-8?B?MEtXem1xSm80VUd6Zmg0OWJLS3ZrYTVhUmRvaCtFVjNhOGRYNUlpeGhjTGVS?=
 =?utf-8?B?VGE0VmRRZEdRUzZaQktIMk1JYVoyb0JaMG1GNXg5Y3VYdCtZZG03b2x3cklu?=
 =?utf-8?B?OEZNSGlKK2k4VDErUlVITjRYSlk1djdhbGVVVnhkUUZWcmsyeGU1cjA3cTlw?=
 =?utf-8?B?NGVzMmtpN3FrMGdrVFdrVUNmWXhxa3VJMk5zdGE5SWxKbHZCMVp0ZDNuSVpD?=
 =?utf-8?B?MVdLdENiaWxyemNIdDRnclg4NGhhQkJiUmtoZ0RmYnA4eGliaWFJZVM5Qmls?=
 =?utf-8?B?bTgrVEJheGRKbzRJcDZHYzBPVHQwdk9DVXFpRENXRVdIcXpnbmt3WlBpOE1i?=
 =?utf-8?B?eENBSXlUVkorU0ZpWVBkQUNVeXBUS3BqTEYyMm5QamdGTUhIejhRaXdXK2Fu?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 724f1f20-0fe4-4db4-b3db-08dbdcb5e48f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 21:43:18.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkCSI4CQxJETcVTithQ9y4/YJ514MPU2R/+mgIUK4oanPdawYoe4UBwWbN5R6631lmxOfK2gcjAoeHAONT7NW6zKxCLPIWzELIHNUhEqARo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/26/2023 1:02 PM, Tony Luck wrote:
> On Intel the various resource director technology (RDT) features are all
> orthogonal and independently enumerated. Thus it is possible to have
> a system that  provides "total" memory bandwidth measurements without
> providing "local" bandwidth measurements.

This motivation is written in support of Intel systems but from what I
can tell the changes impact Intel as well as AMD.

> 
> If local bandwidth measurement is not available, do not give up on
> providing the "mba_MBps" feedback option completely, make the code fall
> back to using total bandwidth.

It is interesting to me that the "fall back" is essentially a drop-in
replacement without any adjustments to the data/algorithm.

Can these measurements be considered equivalent? Could a user now perhaps
want to experiment by disabling local bandwidth measurement to explore if
system behaves differently when using total memory bandwidth? What
would have a user choose one over the other (apart from when user
is forced by system ability)?

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> Change since v2:
> 
> Babu doesn't like the global variable. So here's a version without it.
> 
> Note that my preference is still the v2 version. But as I tell newbies
> to Linux "Your job isn't to get YOUR patch upstream. You job is to get
> the problem fixed.".  So taking my own advice I don't really mind
> whether v2 or v3 is applied.
> 
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 ++++++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..29e86310677d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -418,6 +418,20 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>  	return 0;
>  }
>  
> +/*
> + * For legacy compatibility use the local memory bandwidth to drive
> + * the mba_MBps feedback control loop. But on platforms that do not
> + * provide the local event fall back to use the total bandwidth event
> + * instead.
> + */
> +static enum resctrl_event_id pick_mba_mbps_event(void)
> +{
> +	if (is_mbm_local_enabled())
> +		return QOS_L3_MBM_LOCAL_EVENT_ID;
> +
> +	return QOS_L3_MBM_TOTAL_EVENT_ID;
> +}

Can there be a WARN here to catch the unlikely event that
!is_mbm_total_enabled()?
This may mean the caller (in update_mba_bw()) needs to move
to code protected by is_mbm_enabled().

One option to consider is to have a single "get_mba_mbps_state()"
call (similar to V1) that determines the eventid as above and
then calls get_mbm_state() to return a pointer to mbm_state in one
call. Starting to seem like nitpicking but I'd thought I'd mention it
since it seemed a way to have V1 solution with request to use
get_mbm_state() addressed.

> +
>  /*
>   * mbm_bw_count() - Update bw count from values previously read by
>   *		    __mon_event_count().
> @@ -431,9 +445,11 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>  {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
> +	enum resctrl_event_id mba_mbps_evt_id = pick_mba_mbps_event();
>  	u64 cur_bw, bytes, cur_bytes;
> +	struct mbm_state *m;
>  
> +	m = get_mbm_state(rr->d, rmid, mba_mbps_evt_id);
>  	cur_bytes = rr->val;
>  	bytes = cur_bytes - m->prev_bw_bytes;
>  	m->prev_bw_bytes = cur_bytes;

It should not be necessary to pick the event id again. It is available
within the struct rmid_read parameter. 

Reinette
