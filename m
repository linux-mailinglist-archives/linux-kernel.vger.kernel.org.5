Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8A78F670
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347944AbjIAAn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 20:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIAAnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 20:43:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B33E55;
        Thu, 31 Aug 2023 17:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693529001; x=1725065001;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Q7f3lKajOUtnexOV7dYq4+JZxJ9ERTDLEr3z8ooqxw=;
  b=NCT/4iyHqEDVUuktfWHOaiXz0mutALZFRA9php3LhsQFHoyQApOG31SX
   pf538GNKhUItGEsncETkyKymSNZTJ43QBlHYkmEiqQYSDTcfY57/HroVt
   AX8/ucVx4TOJQHyyG+GjdG9l8IT7XA+4Gfd40WWjTDtBUWzKGQfFSVCkA
   nvShDOFqULt9Ejr2aZLBHWJFvoHNURe/n0IScM8d6yvf+s5zyemJwUJKn
   dGw03iZXr9JpXdBhd65UuHGDA5XjsQZdTIe22/DHQE/Y14UCcn6PYEIDY
   FIxTDCsx+28tDns5sTAYW0MlcZ9bnfF5sLD/d9cXrxioovvj3pYOsvdJ8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462467623"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="462467623"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 17:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769001187"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="769001187"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 17:43:20 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 17:43:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 17:43:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 17:43:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4+kYT0QnGHrIlq9ZGx2r4cFCk7JMn52bX5AKWV3IB+Bm/4WOgikRrMRueXAW0SraDqm0Xnz5yEbBfq22nRcdinOEBMOys8cAKVemr/MpUJ9xvaHS0R4RDt+4EqDaT/yn0aSu/7NydaBPhZFz3OmwvUlL3tPyp+tsbMnrohFUvyC3R51n2K42n9EtUjKvlMSQcpb4+R8DNGUTy7SwfB10TRnEXFkYuxcOJdotfb63qn2KvIiCmqOGd54/DW/gAly2wM0iSbQbH3ofwzcsvLvln4w4ggiHY2Hsm8BBRtAD8xuGA2fNJJvfYGPR34QzOFyYyGl4ui5k1sakF2NrwOuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43N0apWpybC5IHGmtjARDQxa2s74lO488mTjAXbZfZ4=;
 b=k1gxrMFla63hEiYNl9xmZ/spdMotsjphFQTwhLXqArqoH+9izPl73jLKB2jFmuS8VbuhWV6jDEXfdfjSt6SDq9G5Aa1/mw2FcDUVLpdgYuTN571oobUzlJGCF8RIWOOOqPyuVxn7PpMM42l6B2KR2KcpdS+qed74AEOvBQnxgTgUnnVDaIXRjzOn9yMV8TK+PDQpUBUvzmrz2dn/iAhp1DNRMQ8Imk5QVtnrLQZ6CnV7Az5LVn0jjN9FL157Pk+AiYPAInZQ+SjTKl83G2aa2nZcezZQqdhEv5ll/zUhwaIjADakpbAfqhUbqNO/EAL5l4MYwI6lZt6Dy3a4CM+yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SN7PR11MB6602.namprd11.prod.outlook.com (2603:10b6:806:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 00:43:10 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::6d2:5c23:7cd9:6582]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::6d2:5c23:7cd9:6582%7]) with mapi id 15.20.6745.021; Fri, 1 Sep 2023
 00:43:10 +0000
Message-ID: <2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com>
Date:   Thu, 31 Aug 2023 17:43:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-9-babu.moger@amd.com>
 <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
 <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
 <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
 <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SN7PR11MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9131c5-d857-4673-c6b4-08dbaa846a92
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKllh7lg50eqDl7Az0Q70dqhbf9ej/PLV2ylqG4LfrutkJ1W2rP5tX3l5SAmH99+DK2KQmY4/otLptqHBQbZZu+krEpOfS6zXqYwLbZbBnhLINWjDenXl7Ytn/PH0M2MVY3jVv3IkxhZauRzEdWVAFVzAvARoovvrsY5/OvYumRyrS0GvGya7P5rR3fzOkESzZHoHybnDgv6gyHb1f7p1cz2AZ0mcI21v5wtjwkPpV7+2ruoE8l3PpPwvGO0R6WoPqIiB5QQQOqAzKoWvRdvKFWE6r9hPbTNUvIl4I/REC4O22UXx0bMaQbm5HXWpx+pgg4egDLenakT15u4YUQN8WBQmfDRbrQyghRZwccQnn2LmnFvPvGdDjTu4vV81RB17m6sKE5s//JP+B3cooHelAm0+0dVURqnK8P0x9M3QWPBX89qqKcsU7m+comb0lB7AnwhHcECgEsBcMv1x6TduyjFudT/R92HdpCXRFGPrdUg4MFuywXZIk0rtSadmhLs5LkfKcFkTj4KnHGHxAk9/oYCapBpDzgST9TMNBbt1IcCJYHb7C9vXO/thhLNYRql3yUxW2L0dAMt5gWfY74dHdc8vYkrGiBCE17yB5MSxX1K9Kg6KpIQvXtzCHaAsWYhcugDESguwoiyW7/lIJmk5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(1800799009)(186009)(451199024)(6486002)(6506007)(6666004)(6512007)(53546011)(478600001)(83380400001)(2616005)(26005)(2906002)(7406005)(7416002)(44832011)(66476007)(66556008)(316002)(41300700001)(66946007)(5660300002)(4326008)(8676002)(8936002)(36756003)(31696002)(86362001)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdjN0V5R3BPYkNDemoreVhNV2lRSDdhT2lMMVI5QWUwRXN6b3I4RldBTVJP?=
 =?utf-8?B?QjZBZjRqVVFDM1hxYllwNUVwMzRudlI4YUN3NDR1UThmamMrTTlZa3pmUllk?=
 =?utf-8?B?d2cvRlIxcjFoVGVWZnpEb1pHdEVyK1ZYNmQ3NTd5emdHU01TcWNOWHFIYVdG?=
 =?utf-8?B?c3Q1MGp4U2RWSHord3BTRFYwYXZsbE42WmF5ZkxCMENOa1lUbDdNMkUxenpw?=
 =?utf-8?B?VmozL1N1dlpFR1FwNU9ZdkwvN0ZHeTNnZllQbVN3WkJmVmFHUThleUtPMmdu?=
 =?utf-8?B?U25JUW14ZDBZN0grLzY3NWFEeldJanhTd045bUFYSVdsNDRBMkJyQnFsWGFN?=
 =?utf-8?B?Z0VpZFgrSngvUk5HNWZvZ2NRTXVMNjYvNnd3Ym5oc2ZNTWR5MUVpa1h2cUl1?=
 =?utf-8?B?TVBJUVRvVUtUQXJGeTNUVUdjNHA1aUdkaU5NWmNYWnZoRVdGcC9tNytLRUps?=
 =?utf-8?B?SHJNdmZXNjZhQTJrZmtGaGVHR2tuQk9XV0hiNkVuc0xyNlJVeVFWUXNhR0sw?=
 =?utf-8?B?WXRGSlVlcXp6RDVmOFRPWFA0azEvelcrTWZFU2FkY3M4TUxQSDQyeVh5cFdw?=
 =?utf-8?B?VUY5Q0ZVWUMvTDFZMEVIRzZGT0M0am5mcWd2bHRYMUZra0grNnJTV3JqS3Uy?=
 =?utf-8?B?V0h4aVNBQml4bnN1V1QyZFhCQTQwSWV6bnFSLzQwbXlIOGQrSG9TWi9jc29N?=
 =?utf-8?B?a1lKM0VNcTVaQVZwdDYwc0h0Zll5VzFQNURzcTVhdTNMVkFKYXlPaTM3MW5X?=
 =?utf-8?B?S1MxWjV1S1FQcFhjMk5pdVJ1dnp6eWI4Y3BmZGxPS2RKQm5wZm42a3JkUnBK?=
 =?utf-8?B?U0kvUFNyRTZLQzlBREhyd3JVbEFjblFPVVJFZi92S2c4M1hGUld1VjIwZ3Vy?=
 =?utf-8?B?SzlpQ1lWUitNMmJ1TU5aUFMxLzBteFFsZWdIcm9kUzhYVXZMczNBVy9kdEtm?=
 =?utf-8?B?emI4SjFqTHduK1dzL2g2aUNYekpCZjRxa0JBZkdXY2lRd2czTDkxOUYzeXRs?=
 =?utf-8?B?ODcrME5KTnVTcG9yWkNCYjZad3lQOS9rS04rVm1hbkJnMnZDSUY2Zm1URjRW?=
 =?utf-8?B?V3YwNG92YWs2anNWNUJKd3NIVnlHell0NEZCNFVsOGZ6YUJ6SGNGMmZwZXFO?=
 =?utf-8?B?amtIZEJDcTJlWnlrUlRlZFJ6NENwcmlZZXpsZEY0MmhyWmltSjBTUjhiU1I5?=
 =?utf-8?B?ZWhBZmFlMmxYQm1sVi9mTk5zK0EyVTlLM1hQZ2k4NWZFSnNmOVdDRTRLMFFG?=
 =?utf-8?B?RGU1dXRuQVh1U2RpMUFxNGRWZGxVS0I2WGhaSGpHWUNGaDRqOCtzU21IQkZz?=
 =?utf-8?B?MUswRmFSSElRK2Jzd3BBbzdTRFkzbXc3bE45T1pFVzE4cXZZWjBrSTNNbHln?=
 =?utf-8?B?K3hOTHZpRnBxNVp6WW96dk9rWHBueVk2S3ZoSGxPbVkrS2Q3Z21QVVlHZnZY?=
 =?utf-8?B?Q2ptZTBZTElUK3FPdEhlaVBoODVKMm9URHo4ZWw4U1FRNy9MZ3krYjBqNUpE?=
 =?utf-8?B?blNEWmFDOVFKdndheWpnaTluVWJUZ3F0L2dXdWNOMitQQ1BTNk9mMnBqcGow?=
 =?utf-8?B?Q3orZ3dla3ZIMVN5ZlMxcHZuWmsxYXB6RVhsUFhsRzM1K20xTTVuMEZoWC9Y?=
 =?utf-8?B?N29oTUJWMC9VRlhDbE44YUM5WnZGU0NJdkFSdkx6ak9IWThoYUpMcUE2V0VB?=
 =?utf-8?B?ZFlDRUNSbG9aRjdDNjZHckxNb0kvZG41WGx2TlBnQ1VaZy9UeXhJYmJvZ1B1?=
 =?utf-8?B?bTkyQVd4UHRQc3dPWGVtOWIzRFM3RUZ1VjhUYkZ0V3B1Z1hmQWlSQUlISUZX?=
 =?utf-8?B?QXRFQXpVYVZHRWErejh0MTNwYVpDajFmOTVZRng5b2l2S216T2pHOWFrVkJt?=
 =?utf-8?B?U1JoWjY2VTIrZTJibVpFMVh3RGlqWllDWWRPTVlNRDNOOFA3d2dlalZjMXRa?=
 =?utf-8?B?SUFBSUF3cmF2YnFjRGZLeWdGZUppYkZtSzlNbFZ1WVRPc2FxdkpGMFBzeHJj?=
 =?utf-8?B?SkErUkN2a0RQN2VxMHMwT1RVemlRTkdSME5sLzY2QlVhWlF2WTg3U01wM0Ro?=
 =?utf-8?B?M0RzY2Yyd05uaFpFSnV1TXdibHllUmNWQk0zOU9QTUpTZDdud0VSNE9MakNy?=
 =?utf-8?B?bkRoaHJqUVdPTlpPTzhVcmhUWHFabUdsY3A0NDkrV3U4ak42UkhWQVp0Zi9W?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9131c5-d857-4673-c6b4-08dbaa846a92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 00:43:10.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UajYntM8Ljk6yasVAvLC5Xgh1PPNMXpwkz9W355UNVesEQutPKAPaGDkEfVHBKE8BzGza5GYmhrFWGfra1PGDBP3AK8nRzBw9IKIQf7AO5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/31/2023 4:58 PM, Moger, Babu wrote:
> On 8/31/23 12:42, Reinette Chatre wrote:
>> On 8/30/2023 4:19 PM, Moger, Babu wrote:
>>> On 8/29/23 15:14, Reinette Chatre wrote:
>>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>>
>>>> ...
>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> index 2fae6d9e24d3..3fa32c1c2677 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>> @@ -296,9 +296,15 @@ struct rdtgroup {
>>>>>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>>>>   *	    Files: cpus, cpus_list, tasks
>>>>>   *
>>>>> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>>> + *		    File: mon_hw_id
>>>>> + *
>>>>
>>>> This does not look right. I think mon_hw_id should have RFTYPE_MON
>>>> (more below).
>>>
>>> I am not sure about this (more below).
>>>
>>>>
>>>>>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>>>>>   *		    Files: mode, schemata, size
>>>>>   *
>>>>> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>>> + *			    File: ctrl_hw_id
>>>>> + *
>>>>>   */
>>>>>  #define RFTYPE_INFO			BIT(0)
>>>>>  #define RFTYPE_BASE			BIT(1)
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 94bd69f9964c..e0c2479acf49 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>>>>> +				struct seq_file *s, void *v)
>>>>> +{
>>>>> +	struct rdtgroup *rdtgrp;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>> +	if (rdtgrp)
>>>>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>>>>> +	else
>>>>> +		ret = -ENOENT;
>>>>> +	rdtgroup_kn_unlock(of->kn);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>>> +			      struct seq_file *s, void *v)
>>>>> +{
>>>>> +	struct rdtgroup *rdtgrp;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>> +	if (rdtgrp)
>>>>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>>>>> +	else
>>>>> +		ret = -ENOENT;
>>>>> +	rdtgroup_kn_unlock(of->kn);
>>>>> +
>>>>> +	return ret;
>>>>> +}
>>>>> +
>>>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>>>  
>>>>>  /*
>>>>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>>>>  		.seq_show	= rdtgroup_tasks_show,
>>>>>  		.fflags		= RFTYPE_BASE,
>>>>>  	},
>>>>> +	{
>>>>> +		.name		= "mon_hw_id",
>>>>> +		.mode		= 0444,
>>>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>>>> +		.seq_show	= rdtgroup_rmid_show,
>>>>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>>>
>>>> I missed this earlier but I think this also needs a RFTYPE_MON.
>>>> Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
>>>> have the flags of the two new files look too different?
>>>
>>> We have two types of files in base directory structure.
>>>
>>>  if (rtype == RDTCTRL_GROUP)
>>>                 files = RFTYPE_BASE | RFTYPE_CTRL;
>>>         else
>>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>>
>>> 1. RFTYPE_BASE | RFTYPE_CTRL;
>>>    Files for the control group only.
>>>
>>> 2. RFTYPE_BASE | RFTYPE_MON;
>>>    Files for both control and mon groups. However, RFTYPE_MON is not used
>>> for any files. It is only RFTYPE_BASE.
>>>
>>> Because of the check in rdtgroup_add_files it all works fine.
>>> For the control group it creates files with RFTYPE_BASE | RFTYPE_CTRL and
>>> RFTYPE_BASE.
>>>
>>> For the mon group it creates files with RFTYPE_BASE only.
>>
>> This describes current behavior because there are no resctrl
>> files in base that are specific to monitoring, mon_hw_id is the
>> first.
>>
>> This does not mean that the new file mon_hw_id should just have
>> RFTYPE_BASE because that would result in mon_hw_id being created
>> for all control groups, even those that do not support monitoring
>> Having mon_hw_id in resctrl for a group that does not support
>> monitoring is not correct.
>>
>> You should be able to reproduce this when booting your system
>> with rdt=!cmt,!mbmlocal,!mbmtotal.
> 
> You are right. I reproduced it.
> 
>>
>>>
>>> Adding FTYPE_MON_BASE will be a problem.
>>>
>>
>> Yes, this change does not just involve assigning the RFTYPE_MON
>> to mon_hw_id. As you describe mkdir_rdt_prepare() does not take
>> RFTYPE_MON into account when creating the files. Could this not just
>> be a straightforward change to have it append RFTYPE_MON to the flags
>> of files needing to be created for a CTRL_MON group? This would
>> support new resource groups and then the default resource group
>> would need to be taken into account also. What am I missing?
>>
> 
> It is not straight forward. We have have to handle few more things.
> 1. Base directory creation.
> 2. Mon directory creation after the base.
> 

heh ... these are not a "few more things" ... these are exactly
the items I mentioned: "base directory creation" is taking into account
the default resource group and "mon directory creation after the
base" are the changes needed in mkdir_rdt_prepare() where RFTYPE_MON
is appended to the flags.

> I got it working with this patches.  We may be able to clean it little
> more or we can split also.

I think it would make things easier to understand if there
is a separate patch that adds support for files with
RFTYPE_MON flag.

> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 3fa32c1c2677..e2f3197f1c24 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -318,6 +318,7 @@ struct rdtgroup {
>  #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
>  #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
>  #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)
> 
>  /* List of all resource groups */
>  extern struct list_head rdt_all_groups;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e0c2479acf49..1f9abab7b9bd 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1874,7 +1874,7 @@ static struct rftype res_common_files[] = {
>                 .mode           = 0444,
>                 .kf_ops         = &rdtgroup_kf_single_ops,
>                 .seq_show       = rdtgroup_rmid_show,
> -               .fflags         = RFTYPE_BASE | RFTYPE_DEBUG,
> +               .fflags         = RFTYPE_MON_BASE | RFTYPE_DEBUG,
>         },
>         {
>                 .name           = "schemata",
> @@ -2558,6 +2558,7 @@ static void schemata_list_destroy(void)
>  static int rdt_get_tree(struct fs_context *fc)
>  {
>         struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +       uint flags = RFTYPE_CTRL_BASE;

I assume that you may have just copied this from mkdir_rdt_prepare() but
I think this should rather match the type as this is used (unsigned long).

>         struct rdt_domain *dom;
>         struct rdt_resource *r;
>         int ret;
> @@ -2588,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)
> 
>         closid_init();
> 
> -       ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +       if (rdt_mon_capable)
> +               flags |= RFTYPE_MON;
> +
> +       ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>         if (ret)
>                 goto out_schemata_free;
> 
> @@ -3336,6 +3340,9 @@ static int mkdir_rdt_prepare(struct kernfs_node
> *parent_kn,
>         else
>                 files = RFTYPE_BASE | RFTYPE_MON;
> 
> +       if (rdt_mon_capable)
> +               files |= RFTYPE_MON;
> +

Is this not redundant considering what just happened a few lines above?

>         ret = rdtgroup_add_files(kn, files);
>         if (ret) {
>                 rdt_last_cmd_puts("kernfs fill error\n");
> 
> 

Reinette
