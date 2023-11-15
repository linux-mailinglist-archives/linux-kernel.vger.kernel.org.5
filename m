Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7B7EC82A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjKOQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKOQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:09:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E825383;
        Wed, 15 Nov 2023 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700064560; x=1731600560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0N32gvo+Ks4wrlquOF163DAeWWLeUMQVCLZli6qaKAE=;
  b=Pv1WvHkHyroSKVJBNyXh8X0bhApBZIqMnaSq0zpepg3C+GlHgdBIMQ3Z
   zuFajysPOlx9AFWBPVx+u7uHFWFVHrYpm+97Og0Z+AkUurgI4hYITXLWp
   jl7+rZkfP6IUX1ERTLmAzO6t1E7fAes+OqDz1JdoxLR9z9QflZcpWkMqZ
   tYaHTCU1+6zvUxLf/LGjGBLX2NDy65udo+rea7uHD9Z8bc4mCCzww6tmO
   0ZW3j22WBLVAfs9vbYppeEqsLZhkHa7nZfsFd9jYqUgfTRpAdRZH2D0k0
   ouiuBMFRY2F5vY1Vs30hj+Es3Gwvb/Q7VDSp7asGV1trJXEZ8hzvmvwsM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9540756"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="9540756"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 08:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012311790"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="1012311790"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 08:09:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 08:09:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 08:09:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 08:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXbfkFc8aPrHm5TMTbLVRMHISwA+RxavkH6Pj011/wWZ0i1znRf3wfJxBe1z9Cfrq5JP8fEUzTozCXpQ2p1CniOWvItvfeXiwarKmjEwJ9F5reY/Wgcl90BPaGbrjiYIPjIENoZvrzKgrhdQGtkQTWXBlTJq0HojU81ah96VwDxrSUGAco2RwmXmgRpCb0G5AJU0RPCLem3yccOpzP6P/keYaa9/q2fWl87LeVTZO3LVZu4ZzMCC7fmK/Z83xrE6excUv55EbmLDQEOSnwB8Z+ijeUdN3XLkWUcbVQwlALr5mWvnfbT7SoivKeFMhFSKTXFenImchyXievFAdHbcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLwd33R0uKn1P0z1Dk2+JWrFv1GJ8ThrDaLoeZFosH8=;
 b=igRL59U9QUxbQJdNUEqH/Bh4tZPW1nsMtDEILn2fFjuonIhQpfcYlFNzJnXI99wTdyKNcOAxA+ipDA/7KSR04V/Rb659NAX+FWih9OKhFDiS1WWuQdqvyNQRDZ/H5BTFvKV5ePbNcETF5L6S2rfDFklL0vVUnTD0RiA6s44q3WKUd1BgN0KQCFxtOPhQ31PCQD6ejld10ktqeVZOiMhVPLnREvsNzt9RddbRvPY2Gh+L97TvggBtlXEKvAqeJVR9vcyw4pBKU2GMFkgu3eUBOSQpegx4FIXfo+8+B1D/yC7mZiR0Kv6RgXNW1PVpvinGjgpg4qXT2Ib9gjO0pthOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 16:09:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 16:09:15 +0000
Message-ID: <b6a6409e-5f13-4f7e-835a-c9e3653a7ad5@intel.com>
Date:   Wed, 15 Nov 2023 08:09:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
 <ZUqo+MsEQi2Xc/pO@agluck-desk3>
 <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
 <SJ1PR11MB6083F3355446B7879177A1FBFCAFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083F3355446B7879177A1FBFCAFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:907:1::39) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4049cc-e3c1-4b2e-48ed-08dbe5f5371e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAeQaO1QUZJci4h+ECocy2m720a11Bh9wGt7CGguYAD2nWyrZcxnyiQ7e495oGk7ppAwxbqR7NJSOz1WbtxIZ7FdnHEApgtXWNuP1tb26s2a5zUzRunskzJBwHF3cAKHIV4QrCD+KtZRKMkvEcvvrp43+YmyTY/KlouwFtfo2CsPH2nfhOeLtC3Gm1Xubk83b3x+Q9+DLF8iLR8LwzQLuZuHJ94xGUaeIrHJPqbKTkZpeBAcrSkEWFlkCjx9zwxYl4742LLCCP5FeJeOOBQ80YMClpphx7AzGuvKP8hpdRyXuIhsCM/Wq63Sb3DPcwopV2AetefxdVKOdl0oujmvcMEoq+n2YjENG2Tfllz4B3s7z0X+MuQ8tg4y/3PiGEcjBUWTPhlGMA+lA8b8vx4wPCG03M1EJE3h/0NXUVc7SfvszZgF6fwz2BVnqIV7tPcs5AlpkRy0xy/WEHKv57vXGhM/Rd1F8cEU+oJWxeSmoEpygqU4nSCIzRIAlhkWw106IbNx9f8Kb1vcSr65I4GiBVBXkMoNaeU39fNWbfhHcNqmtTU1qdNcfRylYxWCsxgWY+MeCKcfZuqZr+bxmQYCwG6A175CXa+q8AxRBbJrMmlnt7A5jOUBihviXYbMbKg5CJlzoaweOGphsgIFyjvcOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(36756003)(38100700002)(6636002)(7416002)(6506007)(5660300002)(31696002)(53546011)(2616005)(316002)(4326008)(6862004)(37006003)(8676002)(54906003)(8936002)(66556008)(6512007)(66476007)(66946007)(26005)(44832011)(82960400001)(86362001)(83380400001)(478600001)(6486002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW43bmFsRFFTWWFzcitUa3owUXQxd2RzN1hzbDFzazZxU2NHZ1dtZy9EdWQw?=
 =?utf-8?B?b3QydUFWR21Oelk2MVlQSW5QZ2hnQ1YyelM1bTAzZ0xOU3pyMUxHbVF3bGoz?=
 =?utf-8?B?TjBOY3FSZ05wTGZ6akpvL0ZmdjhySk5vMXdnaTVSQ1Baemd5UEU1MnExL28y?=
 =?utf-8?B?bEZMeFRac2VqbmMwV01YM2NweFQvY2xNb1JVRVFxdUZiUno3WWpURUFVdkVQ?=
 =?utf-8?B?U21SdGdqcGxMSFpQTVhncjY0eGQ2REZlblltQmoxZGMxSlgrZ2dnUS9XSmti?=
 =?utf-8?B?QUxNaW1JdU81ampmR2N0Y1orSVF5Mmw4ZlFIeUErYjlna0FoeTVva1pCRExq?=
 =?utf-8?B?SmF5SGVpdTAxYVFOQnlLdkJPdklRWDYrR1MzZjl5d0RUWkZOY0Nya2ZoY0hz?=
 =?utf-8?B?Ym9hQ2tjdS9sMWREWVo3TGFOTG9jSXVaYmQ5ODZYZnBuOUhWeWNtbEpvOWlI?=
 =?utf-8?B?c1NYZkZWbGl6WUtKbW5waFJzVnhPa0FrM3g5Y3dINFovU0xUNVNqeE5tVHVy?=
 =?utf-8?B?emR3MDhNbmZCZklNNkFRNTZDZmFxbk9DQmdmYlFjcnZHUlZaRXpmNXdBUnhZ?=
 =?utf-8?B?Mk9veUk1bkhNc243Wlh6N1FDdzRReVoxQkJ6UWMxOFduNWhLdGV4NEJ0UkZu?=
 =?utf-8?B?RHdwdXk1bkNCcjFuZjI4ODNuV0pvaG5MblNReGlQNTZGWkkvS28zZGdmQ1VT?=
 =?utf-8?B?M2Nyc3Y0WUhEaDJqdjgxT0M4cGRUWElGYll2N3RrQmNWUXhwQXd5TTZJYmJj?=
 =?utf-8?B?bnM0ajlTV1BtN05kRitjbVVSNGZRYy95MXVJNlBqbkpJdXpXUVJ0UVFVa3J0?=
 =?utf-8?B?OGw0ekZoL2xVV1VMRU1KMG9sU2J5ZE1PYVFZNnJrcUozdUdla2FOaWwraE5p?=
 =?utf-8?B?WmNiK3VCcThMR0VOYU1KQlR4VjNMakJsUGxDWUp5NGxjbW0rZ0FvSERwQUc0?=
 =?utf-8?B?VTFIMzM3ZG1sM09zTnByLzJDSmtoREh4S0ZucU40U1VIYy9iQ0RESk5zUElU?=
 =?utf-8?B?azFOd3pydlRzKzBORHZPSk5zTUFUV2xNMXhDTjhXMHMyUnBacVBzb1VsbzRM?=
 =?utf-8?B?SWUxeU1aMDVMV1o0dDBvUEZCdVdlZjV5K2F3dWNVSkc3YW9Ba0hGajVmdndh?=
 =?utf-8?B?TzBpdjBndGQwNzRJSlRINnNZOGtpZllLRWNjcEoxbUFIZWdlSXJ5UWZWZzls?=
 =?utf-8?B?WFV0QlZpWThEVUordlJvVGo1c3RudjdaWEhwVWg4VWhaQit3WUN1VjQ1N0kz?=
 =?utf-8?B?VTFXNFBWVmsxNTNkQ2RNa1ROUXNIL3FWQXRHNlFIN1gwMHc5QktSK0RrMXNz?=
 =?utf-8?B?ZWxNVW03cWdWTldVQjYxM285TjYrVDdQQnFwNWY3TjlvTy9PSlkvbU9laG93?=
 =?utf-8?B?YzErb080TzBWS1BiQ3hrM1VnZDUzK0FVZFFWSUlYSStmRXNBNy8xSGFhUUNa?=
 =?utf-8?B?OHFXRk52Ymd6SUp2R1lzZksvd1Y2ZzZNYzdDbHdmaFhCb1FhTWJKYkRhdytS?=
 =?utf-8?B?ZFRlUXVJdDg5OGRNY1pKNkJFNmR6c2cybDVQMTJ0RHdXVVNrQ0dDT0t3bHp1?=
 =?utf-8?B?S2wrNEsybDhNWEl3dmFEMzBEYjNOaURIOFF1S1RLL1lXNWhobTZ1Y2IrOUVD?=
 =?utf-8?B?dHJMRWpsRDFJeVU3TndNalRpeXpMWkdnL3dLM2FqY3JDL0Z6Zk84T05yUkdG?=
 =?utf-8?B?Ym9sTmNXdFdmYllSRDMzZGZaV3YxYlZ6bVJQelExNk5za0p5WVV5UFRVUlFM?=
 =?utf-8?B?bis0M0pOS29TYmg3WTdad1pocjhjYk9uNXhjR1ZKc2lKS3ZTdXJJNWpUd0Np?=
 =?utf-8?B?a3E3Wkx3dUwxN3JxdzlpWVRKMmZlQXNIK2hQTlJ2MkhONnhBeGtoVWpQYjJw?=
 =?utf-8?B?aFVvVHVYZEtQdVd2R1N6VndmU2Q1M0xodmVXOVhpUkd3NXp4V3RCS1ZQZW9Q?=
 =?utf-8?B?ZzJmM0dnQUp5NkxIV3FOTEFxYm94c2c1Y0dYSGRzUXVuVmhTRXNLOG41YlND?=
 =?utf-8?B?dzQ4eDBhNDMzdWI4ZkJNVTBmY2xwKy9RWUg4c01YYUdtZnBJcGtHRmtLSjN2?=
 =?utf-8?B?MWhObktScUtmb0t6eG4yVlRRZHkyN0pGRTM0WGhReU91bmFoUmV4QThqaXpQ?=
 =?utf-8?B?aEJnaUJQZXk1dkp1TGVlM3VHZ0xVU3BjUXlFV1h1ZURXWE8wOW5tMjdDWEE4?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4049cc-e3c1-4b2e-48ed-08dbe5f5371e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:09:15.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWj7aKoQm9G7c5xpQGC8rzR6Segm+whStzYhZ6+E5Duh3pcpctCFGxfH2bKYytvx20n9lzigSgJFN98zRQPLOCvRgEZe6myP9XfNQ7E6OCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/9/2023 1:27 PM, Luck, Tony wrote:
>>> Maybe additional an mount option "mba_MBps_total" so the user can pick
>>> total instead of local?
>>
>> Is this something for which a remount is required? Can it not perhaps be
>> changed at runtime?
> 
> In theory, yes. But I've been playing with a patch that adds a writable info/
> file to allow runtime switch:
> 
> # ls -l /sys/fs/resctrl/info/MB/mba_MBps_control
> -rw-r--r--. 1 root root 0 Nov  9 10:57 /sys/fs/resctrl/info/MB/mba_MBps_control
> ]# cat /sys/fs/resctrl/info/MB/mba_MBps_control
> total
> 
> and found that it's a bit tricky to switch out the MBM event from the
> state machine driving the feedback loop. I think the problem is in the
> code that tries to stop the control loop from switching between two
> throttling levels every second:
> 
>         if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
>                 new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
>         } else if (cur_msr_val < MAX_MBA_BW &&
>                    (user_bw > (cur_bw + delta_bw))) {
>                 new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
>         } else {
>                 return;
>         }
> 
> The code drops down one percentage step if current bandwidth is above
> the desired target. But stepping back up checks to see if "cur_bw + delta_bw"
> is below the target.
> 
> Where does "delta_bw" come from? Code uses the Boolean flag "pmbm_data->delta_comp"
> to request the once-per-second polling compute the change in bandwidth on the
> next poll after adjusting throttling MSRs.
> 
> All of these values are in the "struct mbm_state" which is a per-event-id structure.
> 
> Picking an event at boot time works fine. Likely also fine at mount time. But
> switching at run-time seems to frequently end up with a very large value in
> "delta_bw" (as it compares current & previous for this event ... and it looks
> like things changed from zero).  Net effect is that throttling is increased when
> processes go over their target for the resctrl group, but throttling is never decreased.

This is not clear to me. Would the state not also start from zero at boot and mount
time? From what I understand the state is also reset to zero on monitor group creation.

> 
> The whole heuristic seems a bit fragile. It works well for test processes that have
> constant memory bandwidth. But I could see it failing in scenarios like this:
> 
> 1) Process is over MB limit
> 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
> 3) Process blocks on some event and uses no bandwidth in next one second
> 4) Next poll. Linux computes delta_bw as abs(cur_bw - m->prev_bw). cur_bw is zero,
>     so delta_bw is set to full value of bandwidth that process used when over budget
> 5) Process resumes running
> 6) Linux sees process using less than target, but cur_bw + delta_bw is above target,
>    so Linux doesn't adjust throttling
> 
> I think the goal was to avoid relaxing throttling and letting a resctrl group go back over
> target bandwidth. But that doesn't work either for groups with highly variable bandwidth
> requirements.
> 
> 1) Group is over budget
> 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
> 3) Group forks additional processes. New bandwidth from those offsets the reduction due to throttling
> 4) Next poll. Linux sees bandwidth is unchanged. Sets delta_bw = 0.
> 5) Next poll. Groups aggregate bandwidth is fractionally below target. Because delta_bw=0, Linux
>    reduces throttling.
> 6) Group goes over target.
> 

I'll defer to you for the history about this algorithm. I am not familiar with how
broadly this feature is used but I have not heard about issues with it. It does
seem as though there is some opportunity for investigation here.

Reinette

