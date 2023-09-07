Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA6797685
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjIGQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjIGQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:11:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84364173B;
        Thu,  7 Sep 2023 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694102904; x=1725638904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m1P2baN8nZyjCiL3ndEL0JEwwmsFBewjlIFZhg/7h2g=;
  b=lIiBsYuDAvkCYLJ1jlO7VrjtTxAxe/S2FHQMKDrXRSKItJWOoXRlQJYg
   gZbt2jteE2iLWeZCv4IPft+wYu+ptRcBkTO3uhWbEtcIgnja+VVUog+Em
   PxRdROYGbb8Z5F3FA0XsyVJvtexojKxa5YsRIP6Nu0oU02rHK/8/O6QK4
   bXYwLi7A0XlkVm43uOS+xSqANVc8guNhIowjgG7RoUXT4mKe0GwClmxa9
   mOabdeSWsWhuo4gUoYLIHIE3Ne9hcx4oz/Mx5jnXv7nV+KjW5qfrkdwlU
   iSwGwFzLSR1aPcYU51QOp4Tgb5/0z6xZDr65YWyABLXamrtnP2Shn78Mb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380061965"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="380061965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 05:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="832150751"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="832150751"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 05:42:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 05:42:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 05:42:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 05:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ5bp9vl+enxV3V0e3So/zpY5phpppfYUrVPgJU+cyWUW3YLq6O1AHRTyvWBHCR1zcuGRMg5jUQ6Jx3+U59Uib90Vskezw3ScNof0Jr4PQYkjzzSlaNaXDQ2ZZ7jkyrHFXc133Yi2bildzlQGX96WRwKmAwglav4scZUDCDKkXwmHspEopLARdp/WjgtfOMHniyU12AqH9X1p2hMWVUPyX4Va60gVL0eiy3i40mNpgOxDUajWf/smlvCpA6MyN6ZrDZXKOnbxRsZnxSalps/ywGdRBMoydDdZ6wuruZDF4JndG0yzkfb1m5dYlRRnm4llNlLllhDzRf+lxQ3NJp3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9cm6eYZWUJSD9mzkvQALkKAwbtYcl43t0aSOo8uWoU=;
 b=adL5W4f6M93+q4YyjrXPmRhpfOwvmBT5SD1nICBRlkQKiSEg52KlyAh/o4WO8CWBOg8Vnsqxvg4O07/24XpQVpaU7zByzxr8sLT3ezjsKbPhAvkUIoTSXWJ5Abte5o2dpbSm2ay5GUZjxVdYa4YWGPzKkjQQN2BfJJUGO4rCcZltD8Jr59tKkWuUSCzcpB39hcMos3QjkJZE3864ZjDaH+Fmycfl/eNH6l8BD03ljTP1sq8h5PGGM5jD9kIOngOOQlbnqKmKVpa1BtVE591PnqGbLAYsX3CAj8aOzFzk/kEI0LSijDQy0ID9vKJX1GBLkY05JYAV0gPu3pkHx2k3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Thu, 7 Sep
 2023 12:42:25 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 12:42:25 +0000
Message-ID: <c4838e77-5688-10a0-8a3e-cf1dda12237c@intel.com>
Date:   Thu, 7 Sep 2023 06:42:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
Content-Language: en-US
To:     <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <ivecera@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <jesse.brandeburg@intel.com>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <anthony.l.nguyen@intel.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20230906141411.121142-1-poros@redhat.com>
 <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
 <e461ea2d6134c0f3cfd765d53d6a2228c1bb3677.camel@redhat.com>
From:   Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <e461ea2d6134c0f3cfd765d53d6a2228c1bb3677.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|LV2PR11MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e127c9-3a7f-4175-c545-08dbaf9fe393
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbauTf2XGMpbmCsTF41WcpX6haMo7nSBNSr2c44EU9bEqmKNARcQ7XdgL5TcFF83Wl+vLYLnzzuGLCeikmhNDQuw1gHnNciNxUe5R0HHu/1JvQ2zMZ6C3hAFNoUN3nfKeXIzZ8sEgZTtp1MfXNV2rSN0B0eGAkIAOP+6nWBm1wJK83bjxTGZdU7ZGwtRBhmRSLmhVgjvbetrR42L/Bff+H/DWs6IfJSl+RxE2Vn0xZ+yodLs8JHU1Dyc1S9kcc+yzV9/olaWjU35akkSRbKonHh4J6n0dKdDH4AemIfP8AybUZcIafEV4Rs2WOe2e/ezev959so2nzRWSlsy7qqD6y3zoukAcqnxEMtOXoabyyb77XfVROXZbWMU/OCfVgRTXGte/UbraclzT5DVd5kr1Q+2qcICSwMXcyBqSjr1xXxDXglv4BUKc3OB4NPIl/z8QaapOwN9fyJmR+r/OVXJGGPJdoDXmlr1QJoguAkTZqVi+0KOpWu/hmfPo8k1RBHmF13r7t2H13vb/+VFJMLJdZNFCZ9rfPLh8CRY3bw7zyjdsr3Q2G44uilz7GgCCjKx3HGVZJvSmxX8bNMeL6uZM4SxCM3s5qs2rxZWb3eXnL8wSeLNsSp6v5XEXKW0a9jGNHNutu0zVR2tuORBNVn7KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(1800799009)(186009)(451199024)(41300700001)(6486002)(53546011)(6666004)(6506007)(82960400001)(83380400001)(38100700002)(2616005)(6512007)(26005)(31696002)(66556008)(2906002)(36756003)(86362001)(316002)(66476007)(66946007)(478600001)(31686004)(44832011)(5660300002)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQ1MTA2NktrVXl2QkJPbjVKZ3dUKzBSTzUzbURHUEdVSDlMTGM5OUlKU2hm?=
 =?utf-8?B?YW0yTGFza1NCRzRaRDc5cmhSejg1bEl0TXBqa0w1cmFWQWprb3lPeTQvZHpG?=
 =?utf-8?B?b0g0aWQxZlQ2RGg1eWVvbE5UQWJIdUY2TTFRUGo3b0N2UnFRaFlwbytvOGtR?=
 =?utf-8?B?eTBWTVMzblFZcE91QkthK3l3TWNqc1djU0dMVUx1TTNxcFo0SDlkNitDZDQx?=
 =?utf-8?B?aFZ6dVJkSDRDTVN2cXFlc0hyZm8vYU1nK1ZxMGx4ZEdXSUJsY2I4TEVkTlFW?=
 =?utf-8?B?SEN3cGVMNEhjNzdubTB2L1NvTzhBUU5vVDZWM3hqc0VlL0FOMnpCM3JjUDZs?=
 =?utf-8?B?aEJvUDk0VUtuQTkxd1h1WmdLaWxzaFQ2bXVuRVBZN0MzL1gvR21EWEhIUlc3?=
 =?utf-8?B?RVlMa01vY1V0UlZFc1RNMjhJUGtpbFpRdjlSUTZoMk1HcTJRSVpJajA2VHZ0?=
 =?utf-8?B?am10ZURFbUpseUFuV3J3NlhINFNhSmpLZzRnUk04RDM2MkVmbzdjMzRoa3Ar?=
 =?utf-8?B?S0RWeDJiUjRES3IyWXhxeitGMGt6YWJNZlF3OEhzWFlKNHlLN0oxZDc5R3Bj?=
 =?utf-8?B?ZEpRVHY5alVGU0hXWmRYTGVTM2Z6VnBHcnNFeXBXTUpTbWZ1dnMvMnc1WWxR?=
 =?utf-8?B?cDZNRGlrd284dVoyQW80cERPLy9uVzMxRFJuL0I5Z0QwOERXK0RqR1VhaWJv?=
 =?utf-8?B?dFIzZzk3a1JsOGRZdVN5WkZlc2hOZnFpN2ViNUpxUW8rN0pLK25mWkpVS0pz?=
 =?utf-8?B?STFUWW1SMVMyNzdMY0lqdXVFeDJtNzlvelpORXVpUlBvWFZPTDc2UVlFL2Qy?=
 =?utf-8?B?QWhQY2pXQXhPQ2RWeU04VDAyQkNJc0xzWjFTRzlMRlhnZlg3Z05oUThwSGtB?=
 =?utf-8?B?UTNGeFpTZHVURzE4YWlyUTZaL0Q0NmQ3WnhMSEFrVlJOWXcrd1hIc1FKWkkz?=
 =?utf-8?B?RUdyV29yUGlKa21ybFJYdUdTL1VEUjRlcjhwRjkxa2ZnT0Y0OEVEV1ZxZE0y?=
 =?utf-8?B?Tzk3V1pNYTdrTDQwTzRHTUFSazNUK0F1QmF0Rm1OZGZjVmJueUtJRkl3SHZq?=
 =?utf-8?B?VWJ1aWVtSFIxYlpGclU3UmpPbXd3RURMLzZYWnFPL3ErOG9iUmlBNTNOM3Q4?=
 =?utf-8?B?eEZvUk56NENuS1ZLTG1WWW9SK2d0L3JJK1RqRWdZK3dwSVhVMEJLcXFUVEgx?=
 =?utf-8?B?Sk5YSVg5ZWpaK0lzMTFqSElUTUZqMTBPblBZSkVDdGcxMncyOXN6RjRsZTht?=
 =?utf-8?B?d2VlVms3ZnRJLzhEQjJXTk1hNWlLMjRmS01WRU90TlhMRTVjTWVCWXlueUxF?=
 =?utf-8?B?QmMyc0wxSlpRTCtva1FoWEFUZFdzaDlsNVhjQnVFNGdvTmUxNEtWUnpIaDdZ?=
 =?utf-8?B?cVJSMGp2S2RoY0xJbm1xUUJxZVJzUHJjVGF6UnREaGVuK2tncURRY3JNSkZE?=
 =?utf-8?B?UWUzYVNPRm54Nk40aUQ5OEFTT25ESWJIdDgwdG1jSmtYdkpaUGw3NjZwclFq?=
 =?utf-8?B?Umpiakd6NVdhWmRvUkJCYmFUWFZ6MEpJZmdQbjRVUzNic2pZS3FzZ0pXYmlB?=
 =?utf-8?B?eTVaeGxLeDd6T0k2SVl0UmhoeVVhMFhmUm9WNzNzZ0NFdG1rNGpQQ3psOUxP?=
 =?utf-8?B?WkgxSHl1ZjdCNHY0amJ4WStCcFFFTTlrZnpseUw5dXBMa29UeUZrNWlkRWJm?=
 =?utf-8?B?ZWs5Rm5QSHZ4eG5VU3lsUG5INnlRcjF5RmpMNlNod0RoQlRacjZmeGd2WTBO?=
 =?utf-8?B?dkVycUdzRHFaUnFMaERJUk9VM3VFNTl5WjZRSWZEWlF1cTJWVFBBd2FjblFQ?=
 =?utf-8?B?bnB3SXJiemNSYzhpVTRwVjBYcFhlTVlzb3RSb3h6dXptd1dhSHZkZmdaTXN0?=
 =?utf-8?B?K3IyZjRTdG1jdUdDU3A5WVZRSzFwa1FPRnJSdUw2aWkxMTJtL1U0UUJSRlZh?=
 =?utf-8?B?cWtiUG1sdVJ5NEJaQ1g2RlBmeEo1SzhqN3VRN1dHS3NHMjgycFNzZXVQM2pr?=
 =?utf-8?B?WHN5bUJ1YlJkTStJUUFCV2ZVa0IxdGtGcml0N0ZRSTA0SEdGV0lrWlJxTFR6?=
 =?utf-8?B?bnN6ek9RL1JLbGNYc0hIT1N1ejhpQUlGU2hCWlp4NXR2ak51aSs2bWJKaFpx?=
 =?utf-8?B?MXdoWjgvbHA3Zi9WOXd2VTBJVzd0bi9qN1JUY0JBQ2lUTE9ndEpTMTJQcm9Y?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e127c9-3a7f-4175-c545-08dbaf9fe393
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 12:42:25.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVZx/3FJQVMRS+irRv/qnTAiyazPIn0n2rXk9+IpvNNeMVHFnHW1MR1UmDBmdFDZlNdcNF8jpzjykABIkqdpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-09-07 01:01, Petr Oros wrote:
> Ahmed Zaki píše v St 06. 09. 2023 v 09:32 -0600:
>> On 2023-09-06 08:14, Petr Oros wrote:
>>> Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately
>>> schedule watchdog_task. Helper will be used in cases where it is
>>> necessary to run aq requests asap
>>>
>>> Signed-off-by: Petr Oros <poros@redhat.com>
>>> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
>>> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
>>> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>> ---
>>>    drivers/net/ethernet/intel/iavf/iavf.h         |  2 +-
>>>    drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
>>>    drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++------
>>>    3 files changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
>>> b/drivers/net/ethernet/intel/iavf/iavf.h
>>> index 85fba85fbb232b..e110ba3461857b 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf.h
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
>>> @@ -521,7 +521,7 @@ void iavf_down(struct iavf_adapter *adapter);
>>>    int iavf_process_config(struct iavf_adapter *adapter);
>>>    int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
>>>    void iavf_schedule_reset(struct iavf_adapter *adapter, u64
>>> flags);
>>> -void iavf_schedule_request_stats(struct iavf_adapter *adapter);
>>> +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64
>>> flags);
>>>    void iavf_schedule_finish_config(struct iavf_adapter *adapter);
>>>    void iavf_reset(struct iavf_adapter *adapter);
>>>    void iavf_set_ethtool_ops(struct net_device *netdev);
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
>>> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
>>> index a34303ad057d00..90397293525f71 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
>>> @@ -362,7 +362,7 @@ static void iavf_get_ethtool_stats(struct
>>> net_device *netdev,
>>>          unsigned int i;
>>>    
>>>          /* Explicitly request stats refresh */
>>> -       iavf_schedule_request_stats(adapter);
>>> +       iavf_schedule_aq_request(adapter,
>>> IAVF_FLAG_AQ_REQUEST_STATS);
>>>    
>>>          iavf_add_ethtool_stats(&data, adapter,
>>> iavf_gstrings_stats);
>>>    
>>> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> b/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> index 7b300c86ceda73..86d472dfdbc10c 100644
>>> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
>>> @@ -314,15 +314,13 @@ void iavf_schedule_reset(struct iavf_adapter
>>> *adapter, u64 flags)
>>>    }
>>>    
>>>    /**
>>> - * iavf_schedule_request_stats - Set the flags and schedule
>>> statistics request
>>> + * iavf_schedule_aq_request - Set the flags and schedule aq
>>> request
>>>     * @adapter: board private structure
>>> - *
>>> - * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task()
>>> will explicitly
>>> - * request and refresh ethtool stats
>>> + * @flags: requested aq flags
>>>     **/
>>> -void iavf_schedule_request_stats(struct iavf_adapter *adapter)
>>> +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64
>>> flags)
>>>    {
>>> -       adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
>>> +       adapter->aq_required |= flags;
>>>          mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
>>>    }
>>>    
>> There are other places where the helper can be used without
>> functional
>> changes, e.g. iavf_add_fdir_ethtool() , iavf_replace_primary_mac()
>> and
>> couple of other places. In all of them, mod_delayed_work() is called
>> after setting the AQ flag. For the sake of consistency, can you use
>> the
>> helper there too?
> These two commits is fixes for issue -> net. But on
> iavf_add_fdir_ethtool and iavf_replace_primary_mac is mod_delayed_work
> called after spin_unlock_bh ->
> looks like no functional chages but i would like be sure and better
> will send this to net-next. Are you ok with this?
>
It is usually better to use the helper in the same commit that 
introduces it, but no problem. I am OK with sending this later to next.

Thanks,

Ahmed


