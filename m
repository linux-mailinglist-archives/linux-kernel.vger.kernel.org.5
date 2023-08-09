Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222A6776668
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjHIRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjHIRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:25:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCAB0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691601906; x=1723137906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mcom2QqE7Mi7+AxOnRZRpJBS+k7UqxOCaURV49wi7D4=;
  b=GfqS89oP+XF9Yuyrs3V4sWsDsI2fdBtKT3dZfwKEVeLYgWn2bkclBYM1
   yxTfdGwcpN68KpncZkI1XmzqDFbH47+ebOw275yi2XQ0AS+JkFn2TdlPY
   r0tGAhdSkm4bqVRTPUwdycUhMON8UgmXeMhVVsJdZ0F1aLbvpQK3/FOtY
   6sGAvCVhn65zA6BtPl+OQuJ+zgKydHj3tM/+fCpTU2qw/+2Fa3b5To2iq
   vBgfsdeMg+Eos31UzMMWUR3Ir0G90F7ICEfmwGxQCsYiVlZ0aEss07hjt
   JHgVonhhYEkPCILLu0usRMlaCoTRrqybKdd5yvYxniuS7OiRIZy2maULV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361312895"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361312895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 10:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="905743897"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="905743897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2023 10:23:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 10:23:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 10:23:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 10:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCZRF/LWvK4tGqlKrTgFF24XAgH3OerBXtPaqHNESkseQTyOZQ3PgQToO9DRqjQKN3ka8+26QrAM3AaZ8jvz6Ueu0XENcK9mLwTymjOOPJccbV7Y+cNBhG+laqKiOuhYEaLQsQxTWKO9arGObfd/M0BggUc0YEOY0ksLQqVzBVWoxUGkWXc7KtbxmuoG3H664TOUcKS5ibkhd5fm0KfhCF9nlX60FG/r0S1M5wzJB0t7AQdjDW6xLyfdQDVH7UDOHTzEQp60Zu61tpxBCEOWixR3TiYgU7oXZpnm873fUCP4O3Uc0WPTAVziWipL36juuQP8psPVVf4oX0gDwUMk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+S8jBL+MgYwnnJ08HGJPaiH6iOq+7zQFUwLNHZ3b4E=;
 b=H1yGJTQZpBFlie4MauDJ6Xqi9PZqYxFoWP/gPvvf3xJLoCeAEBYdNVQJPDxSLzcxELX3I0E/C0wQDnT94U/yy2KK7cSpCNiDj9EevxVeztvzr6UhafWwM3G7pzrCexJ9Ube1JFZthAWEtu8pW4ytqMzv05PBLJG30JjPm0tCZY48fyL21S9lkG78i4eaV78TmrG808N+l0cFUOPCRMUrFQ1MQ2bkctuybiT+9y2s6B8UDV27h8hgpK3HRyxzXjrtpiqVrFOqq8oZlL0+hl0Tfm06/o1UfM6KoVxzi/3v3IxhV2UWcqmt7o79HFjOo5mLJH1sA3KsdzZ2cQcrO6m2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 17:23:42 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::64e5:1afd:a48:29ad]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::64e5:1afd:a48:29ad%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 17:23:42 +0000
Message-ID: <7dbcad27-8454-751b-cdbe-4b755e2533a0@intel.com>
Date:   Wed, 9 Aug 2023 10:23:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch 00/53] x86/topology: The final installment
Content-Language: en-US
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC:     <andrew.cooper3@citrix.com>, <andy@infradead.org>,
        <arjan@linux.intel.com>, <dimitri.sivanich@hpe.com>,
        <feng.tang@intel.com>, <jgross@suse.com>,
        <kan.liang@linux.intel.com>, <kprateek.nayak@amd.com>,
        <linux-kernel@vger.kernel.org>, <mikelley@microsoft.com>,
        <paulmck@kernel.org>, <peterz@infradead.org>, <ray.huang@amd.com>,
        <rui.zhang@intel.com>, <tglx@linutronix.de>,
        <thomas.lendacky@amd.com>, <x86@kernel.org>
References: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
 <20230809165019.85611-1-qiuxu.zhuo@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230809165019.85611-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f382546-b2a0-4350-faa7-08db98fd6083
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUk59kUWgz0qoqoXnGB87mplOzl27TQ+esniI92tKiqQmZuds/+dbfXUiPRPzHI9t5fJ1wD3eTvqDHXIEPOfTwp4cez/fGei+ubHbjZw2Jn2GfsK/Hsfs+zlBlrZVQBkgqIErMsoQtq1QzB8yZQo5WQUgl8maXhsKQ4vvIqDe2AgL3bP6DnaCBgket2wwvVr/6pAoeJ2XcGdQrVihr9nU1cO2CFb+SjSF+jgQXa9MPPXu4673Q9TgyolTV9Crug2VWI485/hgc1E0x25CXQBO1dNc7dXRCYo/RxPaizfcNgZI/RKlf5CYXUp8Y0JsuyqEjM68Pz9b/GICS3MMC6XbI7EgBW4HqF6gWyuK9xuxQRs2oUI0mkpLSV4s7k0iSzem0ReHgGR6+nWZ3ErsARwUC0+lMH5RIyJk9KV4jtQrca0Prx54ZhlPBcu304coYqU3Xgi7K0XU+oyjJOt1ayNhf9UBK/Kwx3GP8q7fHa4PM5FhFcti+VBJs0ISVI5ksrLDtfRPdMmmgw6IZTPQf0pNc1DOciaOeIXdAznDd7xm8K0GyJ5ZRcF5TxubndH335F455NT5tMfT3ysuslBqakNgpWUskBH4TyvFTZ0ga/6x2M9JqmgIvxKVj6HbVhratQJsDobz3Ymb2H13sJyjEUlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(376002)(136003)(186006)(451199021)(1800799006)(31686004)(478600001)(6486002)(37006003)(6512007)(6666004)(66556008)(53546011)(66476007)(26005)(66946007)(316002)(6636002)(4326008)(36756003)(83380400001)(31696002)(2906002)(5660300002)(2616005)(86362001)(82960400001)(6506007)(38100700002)(6862004)(41300700001)(8936002)(7416002)(44832011)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC95WDl2UERpRHVPQ1NualM2NFhKMVpCeFJpcWx4cWNUYzBqZTFpS0xocXlF?=
 =?utf-8?B?cW1GaUJEa05aNlAzV2JtWm9WNWpodk5nbGQraDFFWkhCQ00rdVU5aFY0b1cv?=
 =?utf-8?B?U0ZHSjJNZy9XNkF4NFBGK3NTS2I1UEFwWkk4ZWVDZUJxYU05bUNGK2VITXBm?=
 =?utf-8?B?OHNXNVlkZzlvb1dvQjlFbEZ4L05qZytOeDg5ajBZa09jaXc1M0RrczRyblBM?=
 =?utf-8?B?UkcwVit3V1daZzF3Z0ZIZVhDZjNSTWc1Q2lBL21SNXhPa0hzbjdnWjJHY1U5?=
 =?utf-8?B?NkRVbXE0OGU4S2lUMlVmMjV4WEJpOEJTOUpZZU1HUzdLank4TFZFWTZ2eFVs?=
 =?utf-8?B?SEp6RnNLVytUbURtSDF4TlN3Ylg5Q0kvZzhkWDVSOWdwT3kwMGlUSWNvWXhK?=
 =?utf-8?B?SzV5MEx3aWZyZ0VNaG5XRElGa09LaUN3bm1WaVRkWFlmUG8rQTh0b1J5NVI3?=
 =?utf-8?B?SWp4RjBuSzJSVGdKcTlXS0xnTlZYbFhLWU9yTE1RRWozcFJTUGRwenVUckxO?=
 =?utf-8?B?SVFWaWo4WHdadXhFSEoxdnFramlBUGZrSXgyTnN4YllIaTE3MkZCODF6VHpk?=
 =?utf-8?B?UkJYZ2hqSlh3YUdpNmF5WG5yUERlTDZ1MEFROCtWTFpLcjdnMVFocDlzWTBS?=
 =?utf-8?B?RkZvYnFwQzF3d2tFRWh6S0lCMWpWeHlUOXJjSm5vTWV6OVBFTU1vbkhUaFlU?=
 =?utf-8?B?RHRKTHFFSlplZW1aeElEQm1KYlZ2ckxRMWQ4aDl1SGpSdmJjVlp3UHlGZStZ?=
 =?utf-8?B?VHJKR1dWUDhEZGhWSXIrSDZ6VWo3QUExVmdnWlNobzZiNVNBWGM5dHB0NGFa?=
 =?utf-8?B?dHZlUmw4dVM5cDRVUnJDMlhFNGNaTTZkV1Bma1JFYzBtT1VvV2UyUWJ4R2Vm?=
 =?utf-8?B?ZW1uZzNuQ0JPdFBIelJEbzc3R01DbnR5eTFERGoxclNCZ2sxaWtjMWRVb0lT?=
 =?utf-8?B?QTNoQ0E2KzErK05qWkhaVjlJR0JjTTltVDUvdnpJd2Y3SW9WUVFmbmh1Ny9B?=
 =?utf-8?B?NWd0UFdnWG16Z2ZQeXhZUlVlclo5aytWZ3YzRnFuVE9Dd0JBM0NsSjhGL2FN?=
 =?utf-8?B?eEF6cTZwOTVBZjQwTE9ydTl0THVmZTZNYlMydVlXVmQ3QWRjWnM5ZVFWSmJu?=
 =?utf-8?B?WFVFTHBpaUdzQXFac2VXKzNib0ErektVdUcwUEx3RHYvR016Y2M2VmlDWjZa?=
 =?utf-8?B?K2c0S0JSejZsN2VtNzFYRlB2endZb2R0T2k3QU1oNG9nQkY0T21xRTNOMSsz?=
 =?utf-8?B?T0NIdFMxVjRyY3VLZ2t5NVYzQVNsRU5XeVVJOGtldzAyNXNnOWVKcWFFUlFG?=
 =?utf-8?B?Uk00OHIvNjdoWXlxc05ibmY2Z1RnK1Rybk9NeU53WHZERlpsVGw5cnlxaVhn?=
 =?utf-8?B?RVozYm9DSkV1SXA2ZktIclBCcXdheG5sNElMdVFabFRZUExSemU1TmpsT1h3?=
 =?utf-8?B?dEJLNEQweVNPL1YwTTk1WU9PK3NHRml5Z0IvWVpIRlR2MGFKOHRDdHFLQTEr?=
 =?utf-8?B?bWs5a1lRNDB1YVNha2JhTzJLTDN4dC80VUxYWVlhYkVWYnFIdHFaQVoyd3pY?=
 =?utf-8?B?Y3R1SDZXREJmVEQrd1NJQ1lLWXJ6QU1NT3FYa3ljeHNtVVl1TkNZNVNyWnJB?=
 =?utf-8?B?MnVVOVhoc09nSUw4cU52eHJXdGhyRDErTTBLakdOaFowcFdUWXpYQWN2NmJv?=
 =?utf-8?B?UFFXRWpxSnF0bmtqcUpaaDliZXBZVkNkWUYxa1NEZ2RRV1ovMHd1c2Nqa2Ji?=
 =?utf-8?B?S3grWGJZSFd4OHMrL2ozN0hZU290SHNiV2FiYmE5dGdMZmVVUFBubXNveVFW?=
 =?utf-8?B?RDcxRXhsQzJZSGQ5Y2ZieEF4Q3I5RVNrcjZla2ZiRXVySnAwZVJ3V3paYTVL?=
 =?utf-8?B?OW9zVDVTcVdLeTNSSWljd1dPcExWVzNpcmgyeGdYOGhIVzJlMnhUcUlQbUpm?=
 =?utf-8?B?cHdJQUxLWDJISGR0b29ubVVVN0krQnZVRjlMQ1FzbUU4blhkL3R5eS9ZUnU0?=
 =?utf-8?B?UDcxWnkrRjU0aEl3blM3T3kyRVpEbkpyQ1Y5WGRtWGhtSGJJY3U3bnRYNHYy?=
 =?utf-8?B?cTZMR3dyVGd5d1ZrYnlYdW5NR1BOV0Rlc1ZrTjhZV2xsNUlZM0dzUk1mN1dV?=
 =?utf-8?Q?DSU4dY6J6mhsuvXX6l3CjfhWG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f382546-b2a0-4350-faa7-08db98fd6083
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 17:23:41.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUalqiRUiF+YEzBrlAA+RWz0cJyL7N1SAxjn0TPhO0P8txljecLPnkseloVyVxiTMeGN4zhxbVxYFLUlGKZgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiuxu,

On 8/9/2023 9:50 AM, Qiuxu Zhuo wrote:
>> Debugfs
>> -------
>> # cat /sys/kernel/debug/x86/topo/cpus/39
>> online:              1
>> initial_apicid:      39
>> apicid:              39
>> ...
> 
> Did you convert the output formats of 'initial_apicid' and 'apicid'
> from hexadecimal to decimal in your testing? It was really coincidental
> that if the output values were '39' in hexadecimal for the CPU '39'
> in decimal :-).
> 

I didn't convert the output formats. That is purely coincidental or some
trick by firmware developers to avoid alphabets in the hexadecimal APIC IDs.

I have now modified the print as shown below which generates the
following output:

> pr_info("Register 0x%03x as CPU %d is_present %d\n", apic_id, cpu, present);


CPU topo: Register 0x000 as CPU 0 is_present 1
CPU topo: Register 0x002 as CPU 1 is_present 1
CPU topo: Register 0x004 as CPU 2 is_present 1
CPU topo: Register 0x006 as CPU 3 is_present 1
CPU topo: Register 0x008 as CPU 4 is_present 1
CPU topo: Register 0x010 as CPU 5 is_present 1
CPU topo: Register 0x012 as CPU 6 is_present 1
CPU topo: Register 0x014 as CPU 7 is_present 1
CPU topo: Register 0x016 as CPU 8 is_present 1
CPU topo: Register 0x018 as CPU 9 is_present 1
CPU topo: Register 0x020 as CPU 10 is_present 1
CPU topo: Register 0x022 as CPU 11 is_present 1
CPU topo: Register 0x024 as CPU 12 is_present 1
CPU topo: Register 0x026 as CPU 13 is_present 1
CPU topo: Register 0x028 as CPU 14 is_present 1
CPU topo: Register 0x030 as CPU 15 is_present 1
CPU topo: Register 0x032 as CPU 16 is_present 1
CPU topo: Register 0x034 as CPU 17 is_present 1
CPU topo: Register 0x036 as CPU 18 is_present 1
CPU topo: Register 0x038 as CPU 19 is_present 1
CPU topo: Register 0x001 as CPU 20 is_present 1
CPU topo: Register 0x003 as CPU 21 is_present 1
CPU topo: Register 0x005 as CPU 22 is_present 1
CPU topo: Register 0x007 as CPU 23 is_present 1
CPU topo: Register 0x009 as CPU 24 is_present 1
CPU topo: Register 0x011 as CPU 25 is_present 1
CPU topo: Register 0x013 as CPU 26 is_present 1
CPU topo: Register 0x015 as CPU 27 is_present 1
CPU topo: Register 0x017 as CPU 28 is_present 1
CPU topo: Register 0x019 as CPU 29 is_present 1
CPU topo: Register 0x021 as CPU 30 is_present 1
CPU topo: Register 0x023 as CPU 31 is_present 1
CPU topo: Register 0x025 as CPU 32 is_present 1
CPU topo: Register 0x027 as CPU 33 is_present 1
CPU topo: Register 0x029 as CPU 34 is_present 1
CPU topo: Register 0x031 as CPU 35 is_present 1
CPU topo: Register 0x033 as CPU 36 is_present 1
CPU topo: Register 0x035 as CPU 37 is_present 1
CPU topo: Register 0x037 as CPU 38 is_present 1
CPU topo: Register 0x039 as CPU 39 is_present 1

Sohil
