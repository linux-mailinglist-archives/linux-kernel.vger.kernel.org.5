Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B57DC056
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJ3TYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJ3TX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:23:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E5A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698693836; x=1730229836;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgSEz5OK9Heuwb51+0blepZqa2wyLxMDpRjVrJcIn+s=;
  b=VL4Twsk1J560yWav7tpjotXqq/bJIWhmrD6TLG6nQM/cqbCgYWd8BIP/
   9EFLhH44IZDbULpXnh7TX9zQwdwqjK1evjaxKHBE9Bku629IvKkg0XxiL
   W/X4/bbQDtWp7JNCqzQv5g9rl2C9gAfdW1dLIs/UgW9ic/c3iB1RfDdRR
   v+yJy3yHUAD2xjE6pdjNjIG9slEYP64Q+4jM4lqQs8fUQ/wgfylgIBQ8o
   WO54YCdHF8lcetggJuP5Ctl7Ef0iribbTEAwCmbklP36Zh/9Rv3WUT8mC
   6qDnUB2pBRJ8zR+9M6k3hfyatAUmC275wU2AhwhCrN0uEI5bZO+xgNWB1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="368354372"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="368354372"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 12:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795348788"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="795348788"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 12:23:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 12:23:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 12:23:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 12:23:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 12:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDT/T6YKymFbg/YVasrRZqahJIp6tiYrc8TWtj+IthlfYsFjSADT0j+JVYpMEuKSKebDV3Nzb399/3EpVZ/py5tsSvQfqjiWz1KA9zh9YVZDRblItZsKsG9vSNOHLLCO6EU3twCcjwxtmTO2ClI6odgTMV286zMHXZkjUDfMziN/hqDjzyOPwT6d3wGmHCDq/M6DsiXMD1sWmmp6D+jcLcg7CiQ6urOq/20IlWWlH+OdHzOX1X1o1iiLfSRLUwuPmEidZS9zZ/jX1GNLD3SYv8G593AY2XTUlQe/1qh7FWKwMt7DPGiycMPQ8dBuWoHfndJz9a6JV+gRCuuZniwvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3giQMfr6i4//teyjaacjmVg9kg5hlgCh2bH+h10zbw=;
 b=ejBIYyAxwugPC81rAJess1yimxgbUtCjSGuKpUSdMytrTUxw/Rtmfg61YRjNf3CAwVGZd643xm+lOyQUGGJzZdZo2Km948qKAklPL0kiiCUuQM5zOQ18cysAbTIESR0j8gJc2hdskco6EEeaST5UWyLkBPq/ZkGRNjFkRp+J67IU+8b0D0yPztvRqlrLcK2xCxRHPNQI0/oTptNIi8Nha+QoclogjUv57PKg7KC/BTL+ke+tH4XjyWnIiXrKYNhos8br0aLpeduwcfKLgt0LqhnBWxtQj+I/LLLA27B360vXuDa4PiRSOAD5mOffgXgz44PvS0wKwrLOe3ZUTuuVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 19:23:53 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019%3]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 19:23:52 +0000
Message-ID: <754f3c29-cfac-243c-d280-0cc84ed36ccb@intel.com>
Date:   Mon, 30 Oct 2023 20:23:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] ALSA: hda: intel-dsp-cfg: Use AVS driver on
 SKL/KBL/APL Chromebooks
Content-Language: en-US
To:     Brady Norander <bradynorander@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <2f5ffc3b-01be-413d-843e-8654d953f56f@gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <2f5ffc3b-01be-413d-843e-8654d953f56f@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7c5dee-0f11-4498-5469-08dbd97dc034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBtGsUxzNMrvB/9t3CD7iblc7cfkbS3YwF6gFRozSV1pXsNLeLLvXGZFssq4bo41t06/LfxQarpg34ljt36rlP6Nt00SXoUgpJmQyRowEtN9LVeHYVZ8mPZMafzVYF0F8zsFpSnTp/N516q59axvhY1RtA/OqSU/gexrFtV1hOf5qgKSZEoXW0JDjdweWvBOisARAqnKqzWyp1jXSFGJHGu2dDpucqKVhG0bwkuIb7IMExaaO0QFkU1z6ANSH+rjIrPmfUcPCB+CpVu3yeh/FUrlZOibRsx7WQ6iNaQcUkkr//NN0GpdeTkcUHNgGTuDZyljp+JxphuJ24ew2kS7NvjFqbor4xTu1W+qiInsRXlTH3RCUZR/CefIO4+3zMoQwIXZCCPDSKUrcZC1keWnaLt4Cv7oj/m0vHzJW2UPTit+54W2T4XHL7CsXAu1ScPFdlnNcdpPs+DyduiL1p4CQrY5MSNVujYqQyVnHEjfO6SqvO0oIAoSH4UkJW8aScmAwZDVDJ/8VWknihZjn/1F0LYddNDu55Jv00JtHXK94gPzPKVRqz5rLCcOhCd7CXhCtrlA+4NioRa2zRK8MFKQUPB1+RCfSg4DR+L1v3XZdOUpvz3ruBAGqc2QGAsQzx2WG5k+brSunKqHslUlnfZZWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4001150100001)(31686004)(6512007)(2616005)(26005)(38100700002)(31696002)(86362001)(82960400001)(36756003)(2906002)(83380400001)(6486002)(478600001)(53546011)(6506007)(6666004)(4326008)(8676002)(8936002)(54906003)(316002)(66476007)(66556008)(966005)(5660300002)(44832011)(66946007)(41300700001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhGWFZzV1JvOFdSaUJXNDY1QXVVeURoSXhjR3FVajcrQkpacXBXTmNTVDVR?=
 =?utf-8?B?dUFSblN0N1B1RDM4S0NyOEpvYTl0NGlUMnFJNzBVTnpnN29wdVpyNkZvY1Ji?=
 =?utf-8?B?ZVpacDBwbmhNK2ErTWxrMC9KRTQ2TTNNUHZBWXpiblFTKzJCY3gvdVc0eHJn?=
 =?utf-8?B?YXNXRDJtcVZKVi9uTldGNG41Qk1rVnhSWmk4UVJZbDg4aDVYNitqS2NrSkhl?=
 =?utf-8?B?S0FHSndjWjBSVnJPaHdEc3FXSDJ0c29DSDhUMXRTby8wNDZ2ZDFRb2VsTlVO?=
 =?utf-8?B?VUpjV004QzF5OENaeWc1SjBidGEzSC9IWE5nV1NtaGYxUmg4UndxbmtIS29Z?=
 =?utf-8?B?MWJhU3Z2THpJSmoyL1dqRlZ0QXlON1ozUisva0loeU1yUkFEKzFmcktGb2ZS?=
 =?utf-8?B?L01EZ3hmWjVRSHhJenljYVFRU0ZDaW1CZGU1UW5paC9wYjdrNGJzQi9uUGxX?=
 =?utf-8?B?bDhRalc1MjNpdnlXNS9MS0tUR0F6SEc2bTNHR0sxc2lQNFBzelFWbnR0SnNK?=
 =?utf-8?B?Z3NzWUYxd1prdmtPYXN5Mmh2VjV5MmxOM2tqeHgxNXJiV1hqOHNuenlob05G?=
 =?utf-8?B?VldLS3lkVUErdWcxZWNuRE5xRmp4ZmVGWmlhRGhyTEsvZ2c4R0xXa3RFZTdu?=
 =?utf-8?B?b3o1M1VPcldyNzdvQjJWVTdyT2FPbDdzN0U5Qk9PSXB1OG9nSUFmMitRa25k?=
 =?utf-8?B?TytadUJZaDREcjJqaERFOWxJTmU3blZkRTdyNU9tdjVMVHQrc29kazNRbFJn?=
 =?utf-8?B?QzJFNFhYOE5tcFBPRXp5ZTVVQnlXOEdHekNMTVdlckZFYlI5ME5jc3FydzJL?=
 =?utf-8?B?a3Z3eHZ5OC96dkdKZTVGWWw5VVN6Tk9Rcnl6a1A5bGFJNG0zMnM1bDBlWDVT?=
 =?utf-8?B?L1IwekU5VzhxdVJZNUtmV0ZUMWxWU2M3R2hWYmMxME9ETmRqUTZGcmQ1MTAx?=
 =?utf-8?B?eVAranduTWhJV0d2bFV6a1VueWtXTFBCdnhTWjI4OVAyRU0xbUNrYnhUNGpD?=
 =?utf-8?B?MlljeVlJWmhkVEd2bXVMaDMraVF5b0Q4M0E3ajVzUnJqYTlzRERVdVpGemZp?=
 =?utf-8?B?OWhER05EdWJrMlBidHpQdjJGSlY5blVQUitHQkdGR2NCd1BJR0JpcEhIYUNU?=
 =?utf-8?B?N1FvSFN3ZmoraVBidHkxQ3MxSXNZSlFiT1E0TzdwY1JTb2Y5cjViQUVJR3Yx?=
 =?utf-8?B?c3h4TFA4WEZvRWYyMmJLRWdaeVMwVzVmTDZqbXNWc1h6VFoxRHNSd0RpcXlh?=
 =?utf-8?B?Nm9kVjlmU3FhZmhScDlVOFRqb1JkRnZsZXlqbkhBU0k1TnJQTklSbFR6bkV3?=
 =?utf-8?B?Tm1zdmtHd2cvOVB3Qi8wTTByeHU0ZldCNDJpeUZYZkdGa1pUY0JmNkRhTDlt?=
 =?utf-8?B?MUcwVmhYd0hnNDhWSnVVclFuUVNGdHJRVjB1Vi9WdHJ3NjBiRmVHV1NjM3A0?=
 =?utf-8?B?blZBUGRFNitrZ1V3TmMvbThLWkJkdDZKK1lJdTFHYzNxaytJZ3B5YytHeHhm?=
 =?utf-8?B?a0tkSFYvR3hMK2pCWHF0SW5VMFdXVFZ1TlkzUmtmNWRaUGlXMk5PSE0xNVVP?=
 =?utf-8?B?bmpJZE9jSTNLL3pLMEJxRGN3Y1d4Um02S212ZXJFaVhWbGZtR3JRbTBjNmVo?=
 =?utf-8?B?ZVhvK1VDeEdUZU1hc2lNWk55T0tUY3Ird1Frenlrc1kwYkN6c2drSFM0d09t?=
 =?utf-8?B?eFVwNTUxS0J2QnN1czA3elUwNVNBbkVtTHRJY3ptN0xPOGhUNDlkblY1WXZs?=
 =?utf-8?B?S2lTZVFLaElrYnRURFpYZWYzVVd4d2JYK1Q1QmdDeVc4ZTVBUDgyTHhueUF0?=
 =?utf-8?B?VEZTQUlJOFdPWGVqbElGVWJwYzVQZDBiaWZuOHl6TmZscHpQeGQvM0l0YlB5?=
 =?utf-8?B?OFgraVRBWCtOMXgrL2ltakFXRWhVRTBMTzdmOTBRem1oQTJ2U3M4RWNVNEhp?=
 =?utf-8?B?dDhOaDZTYjBmV0poL1hXZitrcDB6Lzk0MU93OXZPeklxUHFmd1VXa09pVk9D?=
 =?utf-8?B?VGVZLzBwbW1LZWhCZ1FsRGpGMlVMREp2b3NFeHBOeGp2RlhwV1BCeGtsREJ0?=
 =?utf-8?B?Tkg3a3d1TDY0OWw3cUduQ1FKZVFSS2FxTGVldHZUTmlnSTg1QXNRaTkvQnJJ?=
 =?utf-8?B?UkxwcDBTeVBBR0IxbDdTdUsvOW4wUlVOdUQxcmxWNE5Ya2MyaVcvYmZZQUEz?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c5dee-0f11-4498-5469-08dbd97dc034
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 19:23:52.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djQUWsCA2xBKAWEVT6MTVVe/d4BivfR3r93ubXB+fBU4h84PzbS/AjxXEc32u1U1oYq/mGLoZkQWMK9+DZxte7uya7x5Pb9sjbeA5f/gDQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 7:58 PM, Brady Norander wrote:
> The legacy SKL driver no longer works properly on these Chromebook
> platforms. Use the new AVS driver by default instead.

Hello,

Thank you for the patch. The code looks fine but it will cause backward 
compatibility problems on driver <-> topology line which I'd like to avoid.

There's an ongoing discussion regarding 24/32 format support for HDAudio 
drivers which is currently incorrect for all Intel AudioDSP drivers. 
Until the discussion is finished I'd like to avoid switching. While the 
avs-driver deprecates the skylake-driver since v5.4, the topology file 
package is not yet part of any official distro release.

I've high hopes to finish the process by the end of November. That 
means: driver code gets updated to properly represent 24/32 format AND 
the avs-topology-xml repo [1] receives equivalent update making it a 
candidate for distro integration. I'll bump this patch once the process 
concludes.

[1]: https://github.com/thesofproject/avs-topology-xml

Czarek
