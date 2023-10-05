Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98C7BAAE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjJET6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjJET6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:58:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80080FE;
        Thu,  5 Oct 2023 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696535880; x=1728071880;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOjDcUeOQk665LE1/XDRzxkFi0icPknuTUznx+OfTsc=;
  b=HdaHjnw3Yily86TAhlPb1KAYCOE6Mwgjryr3v2MO/Sbpq1nHqwlHpBLK
   s0BPAmgxPde6loNmv7exW7WcdqgSUJ2v02SJhydhh1dd++awhDSQib0+n
   y8PViCqn9qzR2LltB1qvALe8UVz86Z3KlnExpJ1j3Y1e8PrZEcay3pu9m
   8iJBx+TikVAr/i6UQC9bSYoZwtP8PjynJS4VOcP/RUeU0qDANiZO71bnr
   Wi4hVXg0Zao2JcIF9J78BIzTLrQ1AXWfCSzWZC0rPbpBMJ0lLR96w7gzH
   SJt8OpuSluukpYJ6JSVPvfr9przGwm1sK6YGlf5QUh2A3zyVV+eWDbfBY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="382476287"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="382476287"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868064586"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868064586"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 12:58:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 12:57:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 12:57:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 12:57:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 12:57:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQZDGuyH6OZqPDrRBRWcgwPi2ikGjeani3sthX75JNLY0alRJpghRNg410CoUvCiTrVXMrZZSFbSqzFx33o7YIQhgkdNteN8tYAen5YUOnTrw4wQgw5lwGdx6ictrHF7efGeinYJo58wYs85b/MdSw2LscwqMdc4NaHYBNSGTrfMnU36NoNRNptQKl7Cudkf7P9KtcgoRJjWvmjtYDVTk7srwP1+wNomydQI/Px+xGphdyIFiAkEsCrb6t0CYyVDqHCno/Uw3gZky/pnn3o1KbQVI6VPYjlIT8KaF+dO3798sqND40oDRlT9PdLn9TjQXeZ2TK5nKoMgm+I4VMAfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5sqK3TkbWAviKAmUur2df1O/3SVIziNB3qpV34lp7g=;
 b=mtF+D85YRGoRNO0Nk7NUEaLqF1yFZr6UTpu9bbm8olCJigjv/sGMIHsMIVGihIqZTYRR/5rY0YCL2Y5xPirTdSCdBY8j+Lp9yNXrMrOUwdGmLNecKnhFLYRFUJRR4UO8WbOS+kPdHXArI8l6kXnTQSdsFmo+tNsZjNf6YDfr18CzpnJUxfv9QI6L0YuPsQ8GVqk92hiEkSJpb+8b3rbC5X2jV7xYVsc2RWPPjcjH8p00Ocssm4LeAw2sjecr+CWgwgpRorSRXiQ4R3j7+wyaq4SYqMAZQGNcZDelOLcexc9dTftY3ADRPn8Aped+BbmKQCtgBnT4z13g5fSS76vhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 19:57:57 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::d953:d24:ec21:f853]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::d953:d24:ec21:f853%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:57:57 +0000
Message-ID: <2bd23e6d-66ca-14fc-6b0b-14ed7fd5c5f2@intel.com>
Date:   Thu, 5 Oct 2023 12:57:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/9] IFS support for GNR and SRF
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
 <19a7d055-bb19-f3e3-1447-7238d14a2138@intel.com>
 <41f82af1-d08d-8f6-e642-93abf8531fc8@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <41f82af1-d08d-8f6-e642-93abf8531fc8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To DM6PR11MB3771.namprd11.prod.outlook.com
 (2603:10b6:5:13f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|SA1PR11MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a6068f-bc26-4ac4-5fd6-08dbc5dd5e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JEl/28DWETksJeA2VcsiuvUtUN6LaLjcFijFVU6fbam+ISg5bdlMGHaVMw+S7v4GXdW3Lu0Jy2elPObkr/0NBlbn9/01SFotyMi7HYYidZY/nXuJDZAndSc8i72ZlVvqxaBiD5/GsO6d1i4u1UsU/5VT6P8+C8j3KTx6fO3HoWKc3zUw5rQPMIecMIBVcb4pcnFwI51xbtJ7FxQTkmRDmUbYgx2VJEM6zYO5uQ3DsSiG68EpAGgx7RSwvp8sH2wys+jaDOB7RiOZVaNiyczhhCJjD+VnWvJr0x4pl+s+1ePuyacv7CXo2vwWQa/xN+KpR4xx5Z6K2slUzinEEItRY1y1gPEvzJ1ojqb9jwlvutUNQlNHk9uGjHYT5NnY/Ts0BnGCViX7jdAq2q64RMjnTBa2rpJlJ90iLYLph4sLg5laHJAZIskay2PuV5demgjJ4iVU7YAazh7kPk289oeNYUSN8oraesY52Nv0cVACENuc9mq3m8u7Yx0X+s9lth3hq6AgcY0s8Mb6QkOWWafF0PG1P89O2Sf2ArgDX//d8pILhPrdnVXvBP72HKtJ/xyVhl3cIuE3gY0kYlIOTwQ7trfXoQ8L4eV8SaT9N4Ci0me2NEhn9s7gzJH5O30+qFMd7KXHstKjuHmgqDz0Jzn9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8676002)(41300700001)(66556008)(4326008)(8936002)(54906003)(38100700002)(316002)(66946007)(66476007)(478600001)(5660300002)(82960400001)(6506007)(7416002)(53546011)(6666004)(83380400001)(66574015)(6916009)(2616005)(26005)(6512007)(6486002)(2906002)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhOdDR6RlJVbmNXcnM0aUZERkRQTCt6KzhURTA5QmdJWUR1bXJGeXh3aEND?=
 =?utf-8?B?SGM0ejlWNjF3RWNtSVlzZjQyWDdPNmRwRTlJSExDeWdzVU5pSFQ1UGEyVEgx?=
 =?utf-8?B?WEp2TzZweEV1eU1QWXFBWjJQbWRoWFF5Ky9zVXQxSVJxdG9qaGR0OTBZS1FD?=
 =?utf-8?B?dlVwR3RKQk16bjJvWGhkOWJxSlNCK0Y1UTg1YlVTL1p1TENGRXI5eFpzaVox?=
 =?utf-8?B?NjBHbDgyYmpDSVRjZGJiaHIrc25jWEdweThXSThIZXdwZ1krUXIvOXhNSldQ?=
 =?utf-8?B?MEcxWEZEQUxUVGdJcFVEQlk3YnNzVEhsb2RwY25rODJNQ3Q2THE3R1gzYTly?=
 =?utf-8?B?YjZpWkNhR3k1QktEUXpJL0NxWXlGQjRscm9nMmtqc3J1cU9TRlk2V2xONjVQ?=
 =?utf-8?B?bUNHaHp0ZFU3NlljakU2ZHNBalROQitFVkNyWDQzaVVsR0xwSnM4QWkvcDdQ?=
 =?utf-8?B?SDRaUlZpc1JPUjAwb3Vqa2IwazdJUGdUNWRxUEF6UjBxYzdHMVNwUjdlb3Vi?=
 =?utf-8?B?UmtuQVlMSE1KWHhGMS8rQ3RxWHZsQXpXNkdYd3FNN2R1d21SKzRnNE1LVGdo?=
 =?utf-8?B?UXNMdHNITTFFS1Zmb014UFFYRHBCWWV4ZUxkMnRDUG1wdVkvamVWQmM3alA1?=
 =?utf-8?B?NWJydGIva3dWZWcvWUxhNU0wbURYdXpJNGdDUlRaQzlSVnBWUkwwN1FFWmxJ?=
 =?utf-8?B?MjQvaUY4RE1tQVRiN0p3TUpYRE1LbHYxb3JidmIvZUp6cnpvYWZEUEdSaXFr?=
 =?utf-8?B?S2hyY0JCN3JFbldmRFR4V1JrWWo0T1IycjhvRkxlRlhXdTU2aVYzYmQwQjJ6?=
 =?utf-8?B?MkxndUZQZWxkTVFlSWNMYVdZNUxBMkxoY3RBdmFmRFg5KzZ0eFBxVCtqTzhk?=
 =?utf-8?B?dTVBWnhoMEY4YUZFQXB1V0lCQWtyOW5INXY3dUkrWmMvMkNCSnEyaTV3R2o0?=
 =?utf-8?B?RVRGUXFGUVdSN2FBQ1BKV0ZCbjJLT3htL2h4SzVrbEFOQU5KUWpDLzdiNHJO?=
 =?utf-8?B?eWRLaXB3M0ErVnhZVm1YNGJIeVVtMm5LSHExVFd0d2tlRjFiQTIyZGtITHNt?=
 =?utf-8?B?MFFPeFpkeDFVRzc1Y1dDcllpak1PL1VLUXNoM09ydlNKZjlVbnFld1dqd3hR?=
 =?utf-8?B?ak9Zd1Nqb3pyN0dQanY2SDUrRFZKcmhFVng5NXFlUEtJS3JwdHcyaEtwdjdB?=
 =?utf-8?B?Z3N6dTlwNi9ETWp4bzcwSjRqOUFzVXhzcSsvdmlQK2RUVlZmaFZmZEUyUDN6?=
 =?utf-8?B?a0dqeDJKOEJDdVlyaldYUGN5VXpRWk1STEN6TG03elpjNjEyUk1RVGxFYzAy?=
 =?utf-8?B?Q1NSTDBTVEpvanlZaWI1MlZwRnBLTStGNkwzanpMNmNVc2FVQU1lU0F4czR5?=
 =?utf-8?B?YU9LVktHeldsY0ZMK0dtdDJxM2pCTExWeEhPUGZvVHVwNVBhL0FoZkdRUmlE?=
 =?utf-8?B?L2w2QmFjSmNHSHpMRE1OOVlBMEJQcEhSVzJvV1BPZXg1RWtGUzV5Tko0Tk8x?=
 =?utf-8?B?UzJVQ0xJamlkUDNDSXo0UCt4ekEvc21ZNE1rWXNWb0JlN002eFFFMEJCY1U3?=
 =?utf-8?B?OHBWclFhcmJlZ29XTzUvSWhkK2REOGQ5YzVWUVlHOFo5U3ZZVTBvM0J1ZkZx?=
 =?utf-8?B?OXVYdUE5OEVWMUMxRVBoNEpyUTI5b3NQcGFoNXJaaXN5NHJtUmpPeWtPdGFz?=
 =?utf-8?B?OCtEUnBsNk53ODljTkFwWlMzWXlzRjlvU251Zk9OajlMcXNhdjBBVVpaMnBp?=
 =?utf-8?B?RUl1MXlIRVB2cllYQlkwTXg0OWIyZlZPUFc2SmdoSm1mOUdhcm01a0QxSFFp?=
 =?utf-8?B?Wm9hY0ZxK2MyeUxjdHJ5Ukh5cFQxZU9CbjJURTNjUkJLMHRDZzByWVZKMEgv?=
 =?utf-8?B?T1puUFF4TU1VNkp0UkFWRGIwa1BVdDZnY2xqdE45akkwblJtWndMY3pDRlY2?=
 =?utf-8?B?ZHZjZm1qcWJvcnNJWUNON3pOQ3RRellkalhBc1l1WEJxZkZVelNBMEFXcEtG?=
 =?utf-8?B?MGs5VUZRODBPaGhsMmk2ZmgzQXU4eUxvTUQ1cXhDenBsM1FwQk50cTJxaGhV?=
 =?utf-8?B?RlloZ21Yem1YRHpXaWpuQ0I1RnJsQTI3NlY3QXZTdXRwbnhTdVhlUFJrMWlL?=
 =?utf-8?B?UkF6QldvaC8yV1VZRnp0RVlNcS85Wm1Ld2ZPOU53QkVmSmdJN3VvbTY3QzU4?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a6068f-bc26-4ac4-5fd6-08dbc5dd5e6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:57:56.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v1dVzLmsyE3Ij0DJgdpaINGgIllvODP4cipcxaIp8eJQInQTAkHcPVE96gd49HvgJ59xC3+kFsB5O7HYxMRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 3:51 AM, Ilpo Järvinen wrote:
> On Wed, 4 Oct 2023, Joseph, Jithu wrote:
> 
>>
>>
>> On 9/29/2023 1:24 PM, Jithu Joseph wrote:
>>> Changes in v3
>>>    Ilpo Jarvinen
>>>     - Added Reviewed-by tags wherever provided
>>>     - In function validate_ifs_metadata() (patch 6)
>>>         - Add != 0 to next line for clarity
>>>     - In function ifs_load_firmware() (patch 5)
>>>         - return -EINVAL instead of -BADFD
>>>     - In function ifs_test_core() (patch 4)
>>>         - initialize activate.gen0.rsvd = 0
>>>         - use if instead of conditional operator
>>>     - alignment change in ifs_scan_hashes_status_gen2 (patch 3)
>>>
>>
>> Since the suggested changes from v3 are minimal, I am sending just the 3 modified patches
>> in this v3 thread itself.
>>
>> Hans let me know if you want me to send a v4.
> 
> I'm taking care of 6.7 cycle (or begun from -rc3 onwards to be precise), 
> not Hans.

Thanks for doing this

> 
> Please send a full v4 please because I want to give lkp an opportunity to 
> test the whole series (even if I think the patches look okay).
> 

Sent the v4 series

Jithu
 
