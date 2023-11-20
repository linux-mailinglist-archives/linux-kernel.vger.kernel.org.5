Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D27F2029
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjKTWXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTWXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:23:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389697;
        Mon, 20 Nov 2023 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700519025; x=1732055025;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C4+i/0yKz9L3g91nygDL+hLXfW76NBhVrFdWPuVP+jg=;
  b=AEkKrXt7EiCormi630k89tEsP2WqPGVHERDnoPGqrm3NLECu3bGDK4GG
   9OCMjZ4MYzKN0XTppPRehNDdKZwgFE8A3ac43UjC6wIDuzAtSie3FFA6o
   p5dVBG4YYiukDvQledSVqxITXB3ax4No5e6G7XlNKzDLAXdzTH2CbnKs9
   XXsMi1LtywZocwtUC9DnnZw32CzRLhftU2LoZrcsN6rnh8sVpSaqanmZp
   5tq6pDOyzHzj3uZgW75Iijvg+KTepXDHaOiuYw7ykQFIk+oOoZUIZkaN+
   oARjstwWTIKomIydr5RFjjZcp/dG2kmoOwaEp/0MpfYdeu9WGqkJDzg/W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422820772"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="422820772"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742856365"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="742856365"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:23:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:23:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:23:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:23:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:23:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzC5ToaovPK3jE50doZEBA6C+uufigxpYZw7n8Z2+WdHBJQ/TVE49Gmdu6V1jDP6lGpplwAK+C/9tibkMzkQYumPQpsQbFpNrUsiA1ty3YFrVXqnreeaqBdNfdyGvb2p9u8Q9lShYANPk6gI+/EMw1J/tHOsPHP+0I1O3AOXmxgK3qIUTMk6ZH03V3pvj5MffsVQqZZ0DCjutZqjDWrpJ8pw7vPT2klUo7T+TYJi7NdP/Ia1ndzdlMb8LFJeqcCb14QrtTnETxtq698B4QC9bokr63MW132XIRGmH+Qp4SF/9t+p5JWiMTGMAs0S7bDpnvWgL6Sk+/W9rQNXEQ5vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA7ICDMmHCiE1IyK4X8vPv95R2DDAm02XDzIC+nUrS4=;
 b=EruZtkCmfZQlt43v++P/bq367prEeyhHp5krjUZ+cSvCo7UCptay0W30Abm0uzkp567j5/OQDypRioU1ul8GCs7NHMj/vTt4s68HJ0X6YVfSQlHfEWqxSwe28XD0B8VeC2zZL2HlF4rHnBVvR5kw/ictSFJMYKThqSXtcGgBN9jk9gKnrQiZUz0/CBE7i0fR0nPDZL+qrkQ4MAunh7qDkv1aqoEfDZZg6Bocy226N5WdDpX2/PrpZnyEX3D5GEcbAC7qEowgLFC/JCl1Syx9myUuiosGxNfoX56SmZ7bMxw/25mD2rUH23hFC/R8prkXPQLCyJuqKbeaN5kr4g06RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7797.namprd11.prod.outlook.com (2603:10b6:930:76::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 22:23:30 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:23:30 +0000
Message-ID: <3fb83b18-c9cc-42f6-813b-c5cfa526e91c@intel.com>
Date:   Mon, 20 Nov 2023 14:23:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Content-Language: en-US
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
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-7-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-7-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4379f6b0-48e6-447c-ea12-08dbea17532b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ie6u6qB6tZVbQ4IwOcBoMMesMyu0/DqcU/AnSFT3YYfDbElCp8WbXdJtPrCJk7N2nnXkKtSquqBY1QgPu4EorwMcYhO5S8o9O+nitGLxO1c8ejc3EZaRYHJ03GDx1IxG8njEvOto5fu/tpNJE3Zws0Wg4We6gv6zSaR6v30m/ciIOv+kdG0EXsFe477n47FoH+eZpxGId/wioMWEBTqqHGYcWKy3hYA5OramwZDYu0iOAmrfMNkKPknY7erjoZM2h0Lj7Rjr1xXjKYarEfuNn5xgwUCqtx/x2a24tfAl2m5xSuY+HiKWHb552vDRjALaRJc0j8KxUAamiJurG+/tsjh8tt/vVVs3fKpc7HjTmTtbmICNg0Ny/QUb3LcRM1QH3Vgb9NTuFAZwVSljuu5qiaDNxxjYGYj1QZoNbup1bQGYYKffP5bHMVC7z0xXHIXnD4jJeHeKuAzOn/eFT+OKIPMpKqwz2vdlytdt+0exMYs9FQQTCOb1jnMs/jbqqpKCpvkdyS4NnhPNRZ6iXPM5F9598N0OvhawRZ3tbhhMGygF/cmBP8drzlkjGyClyYRlJ0Yt8lZV0V4BreuVp1Tpg8yFRj9KGpZHEsz9cjVuyYFbObh1ndV7QnMJJunQQPH0IcaHAE1J0CBXqLCeq+ctWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(53546011)(6512007)(26005)(41300700001)(4326008)(8676002)(8936002)(38100700002)(7416002)(2906002)(44832011)(5660300002)(478600001)(6486002)(6506007)(110136005)(66476007)(66556008)(66946007)(54906003)(316002)(36756003)(31696002)(86362001)(82960400001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1ySC94UG5BZXFOVS9NeEJ1MlV0L3JFVzgrY0lXNXA5NitDWmNQR0FpNkpa?=
 =?utf-8?B?MDlDb290emZDMWhYcFQrYndwcGp3YVhTYkVCck1GZ1NRVFNOK0x2M0k3VlZE?=
 =?utf-8?B?SXdqaG9MR0MzRHdEbEIxb3hYSEN5VGpRMGFvZHpZT3RodkJNTmgwWm5mZ0hB?=
 =?utf-8?B?SWhPQjkzR096SnBQWTBqYW8xSHJjdG5xeFRSd0JEYXcvMnRBMVo4alZtVWMv?=
 =?utf-8?B?N0dpMklGc21aM3NIQWhlL3pSa1pmUWR4LzFPMEY5UEpBUURyOFlmTVhhVUtY?=
 =?utf-8?B?NGhkM1gvMkYybzB1M0dTc3YzdWJDT0dIYkpRS2xiYmtLc1N1MkdRaEVrQmdV?=
 =?utf-8?B?VGdEY0d6WkI1K0JMeU15eU5PWG9aQzVNaVZ5d2JGVlNXL0xwTlFTcDZtTmpi?=
 =?utf-8?B?MmpxTlVwdDg2U09LcHJmNkJWbm1EbDJyeW9zb1drNDZmSGRlLzYwM0svblI0?=
 =?utf-8?B?dnFwSUZ3RHV1YjByUFR2RXNJM1JpODJMNmRsN04waVpYUCtLK2ZIa2RpUFpR?=
 =?utf-8?B?SElSb3VBd2dHUloyZm9hQVJ2NDFrdEV2RU8zcnJ6Z1ZtK3I4TmJTTlpORjdI?=
 =?utf-8?B?L1RBSTZCK0NhSUdGS2pmb1hPOGIzcEs1S0h5ZnlCTHBwOWhUVkQyOFNZYUpB?=
 =?utf-8?B?ZUVDMlNMcWt6cDJCQlo1a29KdXB1ZlkyaEpucVRLNE12K2FPTUlYTnNpSmRC?=
 =?utf-8?B?TlpaNVUyTVVhcEU0WCtjMVVjVnZSNTBzVFM0RmthSUh1M0dXZ1BOd0VrcXEx?=
 =?utf-8?B?MlVTbDhnZXFhSWsrSTg4bEhHZkhYdXpyVnZza0V4ZktyQzk2NEdhQkloYm5w?=
 =?utf-8?B?WndpRnVNYzQ1bUJoNDZzN0FYOWFpTTBGdnB0ZDMvMVhuT0dhY0Vpa2o4SEhr?=
 =?utf-8?B?QkplNmUyZDRoVU4wVkhqUlNXOE4xQWtkS01VeWpwcWlxcHJQY3Q0T25kMWor?=
 =?utf-8?B?Y0Q1a2V6TXA4THhSTENJTHIyVThDMW50dkNSYzFLMURHdWM0VFY4eWRCak1S?=
 =?utf-8?B?SDVZZ2NreW9qWDEzdzlhUUcxeldqdmxmSU1MQmorWTU2UEJQR0tTZ1h6dUxr?=
 =?utf-8?B?SThLUklWWGlhWVRSZ0JLZHJjM3ZmQzhQdUhrSjVhZk5MRTNKdHludUtiQTd4?=
 =?utf-8?B?YnJCRDZpUXBQYkh5MWhKTUYrQmQ1ZU1XWGNDUm9pK1JyMFJmMjZjM1B6dWFl?=
 =?utf-8?B?OTVWT21SYnpFNEhja3NBOWJXSHhpVWtBcitIRkVRZ2ZOMXh3WW9QZnZ6dUVm?=
 =?utf-8?B?QmRxcXFzOFJ2Zk8zZGNNQ1g0NU9xSWE4SHNCR2oxaTdwN05rWFNKbmFhSDZV?=
 =?utf-8?B?MHZBNno1YTgzQWxyYVp2anpwNDE1TjRjNE5MUjVLV3plbDdaS2FXMS9sM0Ur?=
 =?utf-8?B?NXBacHJvRS91M3pYQUtTK2tmcURaNHZxT3NEUUVyQ2V5R3dnczZBYTlvbnFQ?=
 =?utf-8?B?M1ZsalJTMWpBY2txemZXTUJpM05zZjRaWUR2NjZDVUNCOFlSZ0RqSzRTa2oy?=
 =?utf-8?B?VmtxbEJVYzdZNFF2RUV1QlEyVVJzaW9yMGozTnducTZETkdvYXFjeE1MWFFr?=
 =?utf-8?B?ZVpabGpmU0c3cTlWU2F1d1JWbElrMTEyQkZwSFByckQ4VmVWSzJ5dUplT0JK?=
 =?utf-8?B?ZGVKOHVKajhnNVp0bVJ0Y1FtdFI1TVVGVVRZa0FNeTVwbXNYbVM2UmJadVRq?=
 =?utf-8?B?MDNVakNXM0N1ZEJDcjJOWVZEajZOWEtQY2UxeDJQTWtrSUJLU2M3SzRyL1Ev?=
 =?utf-8?B?b1VsMjZnTCtzZTNZbzk4MGhOdkM4RUVMR1BhUFNLN1dPQ0JtYXZzaFRTUG4y?=
 =?utf-8?B?bHNQY1oyN0Y3Ymw3TVh1NUJGRTlDMlFyRWNsVWZRN0VGOU4xVjhUMGpjV3hw?=
 =?utf-8?B?WTVvTzI1YW9Ndnc4c3Y1dzh5REJVLzR0ektPS2VER1Z1TWxRNUJPL3lOUGdD?=
 =?utf-8?B?SU5QdiswclNVcHFJbk9hRWUvZSszVGo4ZWw4K2U3N09ZcWovck5LLzJqbHor?=
 =?utf-8?B?dU9KMWQ4c2FYM2MvWEh3Skl5SUNpNVloaEo1eWQ2dmRBZTQ4bTNZbzFVQzZW?=
 =?utf-8?B?c0FFYkpOV0dDdjBZT1BaWTl5OGVjV0dJeUozazVzUEViSDNMZnVzMDJwR2ky?=
 =?utf-8?B?dytGVHZVa2FhdEltaklUOHJWQkp6M1VjTURrV3hJeVZKUXF0RGNUMEJpSElO?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4379f6b0-48e6-447c-ea12-08dbea17532b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:23:30.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjY7Koo9XqL7mo79IzhG2Sv+PBdgXOQ7UO88yLi1Qi/WI51wb4MEQtn4JVHEPA0owhpRJAg5mJ4tckRvpRpPPHEcg+hRvDNgf755lM1IdXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> and memory controllers on a socket into two or more groups. These are
> presented to the operating system as NUMA nodes.
> 
> This may enable some workloads to have slightly lower latency to memory
> as the memory controller(s) in an SNC node are electrically closer to the
> CPU cores on that SNC node. This cost may be offset by lower bandwidth
> since the memory accesses for each core can only be interleaved between
> the memory controllers on the same SNC node.
> 
> Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
> to track L3 cache occupancy and memory bandwidth. There is an MSR that
> controls how the RMIDs are shared between SNC nodes.
> 
> The default mode divides them numerically. E.g. when there are two SNC
> nodes on a socket the lower number half of the RMIDs are given to the
> first node, the remainder to the second node. This would be difficult
> to use with the Linux resctrl interface as specific RMID values assigned
> to resctrl groups are not visible to users.
> 
> The other mode divides the RMIDs and renumbers the ones on the second
> SNC node to start from zero.
> 
> Even with this renumbering SNC mode requires several changes in resctrl
> behavior for correct operation.
> 
> Add a global integer "snc_nodes_per_l3_cache" that will show how many
> SNC nodes share each L3 cache. When this is "1", SNC mode is either
> not implemented, or not enabled, but all places that need to check
> it are updated to take appropriate action when SNC mode is enabled.
> 
> Code that needs to take action when SNC is enabled is:
> 1) The number of logical RMIDs per L3 cache available for use is the
>    number of physical RMIDs divided by the number of SNC nodes.
> 2) Likewise the "mon_scale" value must be divided by the number of SNC
>    nodes.
> 3) The RMID renumbering operates when using the value from the
>    IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
>    counter, code must adjust from the logical RMID used to the physical
>    RMID value for the SNC node that it wishes to read and load the
>    adjusted value into the IA32_QM_EVTSEL MSR.
> 4) The L3 cache is divided between the SNC nodes. So the value
>    reported in the resctrl "size" file is divided by the number of SNC
>    nodes because the effective amount of cache that can be allocated
>    is reduced by that factor.
> 5) The "-o mba_MBps" mount option must be disabled in SNC mode
>    because the monitoring is being done per SNC node, while the
>    bandwidth allocation is still done at the L3 cache scope.
>    Trying to use this feedback loop might result in contradictory
>    changes to the throttling level coming from each of the SNC
>    node bandwidth measurements.
> 

The latter part of this changelog stopped being in imperative mood.
To reduce confusion I slightly reworked it below to address the
parts I noticed. I often get it wrong myself so please check again.

	Add a global integer "snc_nodes_per_l3_cache" that shows how many
	SNC nodes share each L3 cache. When "snc_nodes_per_l3_cache" is "1",
	SNC mode is either not implemented, or not enabled.

	Update all places to take appropriate action when SNC mode is enabled:
	1) The number of logical RMIDs per L3 cache available for use is the
	   number of physical RMIDs divided by the number of SNC nodes.
	2) Likewise the "mon_scale" value must be divided by the number of SNC
	   nodes.
	3) The RMID renumbering operates when using the value from the
	   IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
	   counter, adjust from the logical RMID to the physical
	   RMID value for the SNC node that it wishes to read and load the
	   adjusted value into the IA32_QM_EVTSEL MSR.
	4) Divide the L3 cache between the SNC nodes. Divide the value
	   reported in the resctrl "size" file by the number of SNC
	   nodes because the effective amount of cache that can be allocated
	   is reduced by that factor.
	5) Disable the "-o mba_MBps" mount option in SNC mode
	   because the monitoring is being done per SNC node, while the
	   bandwidth allocation is still done at the L3 cache scope.
	   Trying to use this feedback loop might result in contradictory
	   changes to the throttling level coming from each of the SNC
	   node bandwidth measurements.

> Reviewed-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

(same comment as previous patch about commit tag ordering)

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
