Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAABC7B58FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbjJBRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbjJBRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:00:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B1D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696266022; x=1727802022;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tjo3K1fOgHjdVt1smkaQ9xZjCOqLWjnvUTz02ttQXc4=;
  b=Gh+eoz/CcyO1GcFoHfCrY/DGvfsbMkbviuogjwUXOTMvouhV71j3NsiO
   TlGtS1/f0FD6qExzrcjpUEsCwWzZaSscPSnokVpmZ9pb7miSb1CkL3yEu
   w3ZVhih7HyP2jHYRrwfq+3optQNnrW99mYXMw9Gn4LLN9ulOfyBkQRgoz
   kTskhdjK18tJ2vEhZdy9EXBgCvIipwaNHLBIZJsBw1GJwzWEG10hACl+t
   r9TxOZlth0qPT3LF7yfazxNUuLB6ALBHOB5I8F+s04njrhOrT8jYl88i5
   q7kszy14YdfEmIeyQNFqOq7GWTEEJ+uzACBNNvuLXx7SForyS0T2my1MD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385509132"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385509132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 10:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="820942613"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820942613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 10:00:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 10:00:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 10:00:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 10:00:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 10:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgbp9cyQ4CLN1Hu5zJOWDBVkg18ATbf/CLOtdGOTZ1B8bHpCTFVXaG/2NtxUHo26/FFqouL1NHGLY3ehweQkk1+x4IsW7VwNfpdfwFONLyxDAEDq+reoAChhKstY1PrOL9fx+/DYi4VITtBx4lCy27Jm7XQYczII7hqltD6pRNrH7c7MqvBw5FBPJllASMCuPFN0RKdQ2fSHCDakCn2clH4Vh5nKPzrmVePHKqrJAXsGbwfSZDdtO4asPgHcqEwGmfntR0L8u43IyJmbHKe2tmhP43VNcwlAWAVQ+j6d4M9wj5AwMst6dQ/zrbrEgEZ0vRVVLxmhI1YI64JDIcWCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDxIWAPTeOGU55Ho8WqDRnOSOafZIdSGa2z4ulXzGM4=;
 b=g0Ri+xuZAI7IsGroLGggGW3cZ6SZlMpErWoKYQEJIcnZwg8AUEsxggJWdhqJNagYUPl1FZd28J64UM7l2kg3LGeG0sBnBH+jgUDhyNfNkdU/PmpAgezl75xGxZxsyMliI3lvk3TqSPoMQzAQLexdeZssVqnuug//TIeNgnG12y2ns3hyPub1uogZnf5284dwwQD1N638nOggNpKrMrdT9T1rpDHUbC7AERP50VBY/2r6ccT8W7EV+oGgn6+pZPoztlbwNOIv59LNLg+nsrH740MN5tulJoQ2F7w9t+hPYXcoZH+VlHaQxAQ0dNcgHZdkX2bdp9J6rjL53PbOh029dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 17:00:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 2 Oct 2023
 17:00:16 +0000
Message-ID: <9606020e-c322-fb6a-a6ca-96ade7aecf17@intel.com>
Date:   Mon, 2 Oct 2023 10:00:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: f96788c4-06a1-4f57-bddc-08dbc3690d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxc4Tj0pnTTpwcjh74z7GXBEuNL1DZWRyltXhNwFob7KF+NAqi4zCgrSDzhvA9gzDFE3/bWqo4DJmSYqC0HNX0TJr+k3KJtZ3kZnTq4Zx42A+uWyCWWWAM0FhYWBMkS+mxN7mg4awVpt3F49Zqu6e0xLrTvsS/K/zYOZ9T/CodvSgqgDhZRwMdX5YyiQFRR8hZEgdZNaZ/BMS1Z/pTlMgQPemiRrQArjFVl5+LHOYFxTVeha4qPLG0O03A6MM9Gp+pKX7ORJ1Bt903zt5+9xNt5Tvairo3joEIXXhfwN3a2vEt3wZP6n/G0r48+HNHP7o1OJVxE+K8XdR5M1/Pm30YwRZ3ho9aGefwJ8nR66hD0BtR9sr7zlNFecH22sU4dtUJC/dYsZaLm+eNpe9NTHWx7o5Y94F1DSA0rMNP3NxXj6Wgw+mQYy3D5NTan8FvdQL7AGEPacM0YbQberJ549pZT+KCMuZWJoL4ePvBlUmfprcG5F7cppCAc19qQC4hxIq8lFmRN3x6su9Sul6KV95BXcYZ9tllMml5FECvkra7gNTO1pGXKLPkzxMvO2TmvnVW4tI7K6lKLOCs6hnGL6dVXqdXjEv8+JmHQmuPJX6CoKqKk4zcaYsge5eV0ndRlTO99XVJsLh01uqFgEOeosRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(7416002)(2906002)(4744005)(36756003)(86362001)(31696002)(82960400001)(54906003)(66556008)(66946007)(38100700002)(316002)(2616005)(41300700001)(53546011)(6486002)(66476007)(6512007)(26005)(4326008)(8676002)(8936002)(478600001)(966005)(6506007)(6666004)(31686004)(5660300002)(83380400001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlViOUJLTUl2RyttVjZidUVQNlpZREd4b0N6VDF1UTlSQUppQS9ha3pjNnk1?=
 =?utf-8?B?RFUwOVhNQ3A0NGFaSVplRW9VN3NHZ2ROdkluNXJ5cUlMOHFOV0R1eGVpeTcw?=
 =?utf-8?B?Y0dJQy9IdjFVVVczNXFSNER2K3pTemFuL0ZLaUFvQmIwVVBSYU1XOEZYS0V3?=
 =?utf-8?B?d1pFR0FGMWhCUVg5cUpPZlVsSWFQQ3FEdFV4UGVPQ3gxNXRxYnNwTTVaKzA0?=
 =?utf-8?B?SFRtSllRL1ZCRTAvM09WSit4TDc3aUIwM2RxMWlPRkxuWUZBMjJBSVdic25N?=
 =?utf-8?B?R1dETk9yV25NeDRoNUExc0loZzAzM1ViOWo5OWxiTlBxdk1EVDlKZHNEbC9r?=
 =?utf-8?B?NUJnWXE1eXhIMTVzSlM1dG8zK0tyT0xXMVoyQzYxcU02RkxHYWJIMU9iMDIw?=
 =?utf-8?B?c0dVSUlQZ3paVjNnU2NpNTIxVGk5cFBXS0UvdzVTNVAyczRveHZxTUVtSTRw?=
 =?utf-8?B?eno5eUlyUE5SL0JkRi9VYXBkUkZoUExqbkNmekRnb3k4aVltWGw3QkpMcWE5?=
 =?utf-8?B?SXBMMlJKV0NYdUhONFpDUjM3elBKRUFLdjQxendocnBWS3hpSlAzQ2Q3YlFN?=
 =?utf-8?B?c2lLL2lPL1Q0amh6L2d1YlgvWXloR3RqNmN3RURjTjdZVHR4ZjFKSnU5SUNQ?=
 =?utf-8?B?VFVsbVpSYmtjSGRENVF5KzVueHJENndBbHV0WXpwTEljdFdvTlUwZlJqSUxv?=
 =?utf-8?B?S09DS0dFMWFmOTVseWtpcUx4T0hCTFZ6MGJjMmlmT1RMUC8rQmdCN05sa0Fw?=
 =?utf-8?B?WWwzYkVic1hIaFJQVUwwS0xJclcvbVk2Szl0bk1SSlFyYmFsdVdYbkpISjdr?=
 =?utf-8?B?MDRmWmI2TTdacHBobUVGNGFqRU1vTk9kaDFydVhkdTRwU3UvNVRxWXlIWnRX?=
 =?utf-8?B?ZFBnZVlIMHV3ZlArMUw3cHJDUVJXT3d6d3dUZ0FIK0JDakRuZ0JFTkRSa2lT?=
 =?utf-8?B?dlgzQThaMXVxallMVjRCV0hLTGd5TG1zL1FYR1h0bmpFa3EyL0hBUy8ya0c1?=
 =?utf-8?B?SGVzbE0zMndlL1p2elYrSTFBK3VZeEo4cTBjWU4xT1prOVk1VE0rV3g3NExS?=
 =?utf-8?B?ajNqUE9oNVYrcXN2R3RSNmprZ1FkRHFEdkt4TnNHS3E0YTFZaFlLaUdzZVl6?=
 =?utf-8?B?STlaU0xiK3YvQU5RekFGWDZud015bGdMTDdzRnVhUko1N3Q4T2RzMXJwU0pI?=
 =?utf-8?B?WUhTZ2JHSlBSNTZVa1JXNUVYdEJxRFordlJpOFFMZ3JhN05vZVc1SVlsc3VN?=
 =?utf-8?B?eHQzUEV3MTBmWCtKMHZVVEV0MWdDRHV2R3F4NTZRZXA2emJTUTFrdm5Bc1Z6?=
 =?utf-8?B?VU11Mlc0UjNXU0E1dFRKbXR6Q1IwRHF0QzYzeXhjRHVVNDJwN3NYblJCRk8w?=
 =?utf-8?B?Tm5sTGNoa1Jib3FlWHVwZXBxb1M4WE02Szd1TVdGRjFCSk9XQlpSSjk2OHdM?=
 =?utf-8?B?bm1tVkxiTHE3U2FYTnNwQ0NCd0M4YUR6cVdtU081UHQ4TnVZSFdqRWliRmZF?=
 =?utf-8?B?OGVnNjBtNFdhTGxwZm9vekV5MTdRSGhRVHVjMnlrZWhpMHRBcmFOSGxZM2JM?=
 =?utf-8?B?NWpCTjMvNXdIRzQzVFBPS1A0WXgxOXhLbDQxUVB3Yzh3b2dCK1kra0NGclQ4?=
 =?utf-8?B?RC9kWllhR3BzdG43UEN4czJTSXdySWVicWEwSzVXWklWcFBObldVK1ZLWXVz?=
 =?utf-8?B?Z1ZJUG5nN2FtUm9CcmpDM01zNEpYRFVidEc2akdIb3F4Y1h6dGZvQ3BZeUxu?=
 =?utf-8?B?RzhQaFBFVkRSdEtld3RkaWNrRWdRb2EwVzZZSjFRdnUzQTk3ak9iTmhqR2N3?=
 =?utf-8?B?dGFpSnZETUtnYytjTUFGM2lmTG5lK242bmN0WTJlMGIvaUYrMGxkenR1VGQ0?=
 =?utf-8?B?Y0NHVysvWStzUkFJbnNmeVhUQVp4SnkxejNUL3VFZVk2WDh1RGo5clNrcXV5?=
 =?utf-8?B?S0IxRlRPeTN6NWJFTGkxZEdjZDkzb2FTdnJwYWRXUUxpNUhTaDNWRmVKNEtP?=
 =?utf-8?B?dE8wM1loay9Ka0NhUGdja0lwNXFDZmR2YnpQQ3JrbnRrTGowV1NqQTI5eGFQ?=
 =?utf-8?B?YW1aUkZpSXFqTzNVZkhiL25GZ215VGx2ZWJjSkJjRjV3UWt5SEdxdmhmbUZM?=
 =?utf-8?B?dmNxbi9Yc3NJRm5JdDVnYnlOUzdvL2JZTHNzUlh1Q21Ra1U5Qy9WM1lxSWQy?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f96788c4-06a1-4f57-bddc-08dbc3690d62
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:00:16.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXzPbBrdSCp4hw8iwHtP3KDbuSW+T0tKrTVJetYWP/uwCWqEvJy912PBpQ4n/o2hiL4A5L7T1QAN78ihU1/alv2NoY479ybc62B71pqU+90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..a2158c266e41 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3867,6 +3867,11 @@ int __init rdtgroup_init(void)
>  
>  void __exit rdtgroup_exit(void)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	if (r->mon_capable)
> +		resctrl_exit_mon_l3_config(r);
> +
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");

You did not respond to me when I requested that this be done differently [1].
Without a response letting me know the faults of my proposal or following the
recommendation I conclude that my feedback was ignored. 

Reinette 

[1] https://lore.kernel.org/lkml/1ccd6be5-1dbd-c4a5-659f-ae20761dcce7@intel.com/
