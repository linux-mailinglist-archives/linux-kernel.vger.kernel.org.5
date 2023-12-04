Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E07803EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbjLDUDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:03:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F834C4;
        Mon,  4 Dec 2023 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701720227; x=1733256227;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YHi95oHStKsBPWj1tHt+YgR1+aD6p2mBUvdVEkRJRR0=;
  b=akkSM7TvoPlDuXtQS9JKId6ZD5ihT6XJka/aDz+Z2RV6hG/ynMvURKzN
   4vpcKxPfzSfuHAfeG/B8LeRlkTYkOPPGjwIXrkD65B0El350VN9OzwSWr
   JUNFg6/qMHm7I9YH0ivRUztAGD6/OH7xaWveAGC4NisXjRWJgmgFCUmZ+
   OwmXI22GTd3PdrnOTwQAOzYoc9hze8tTwld8QJqo/iV2WnRKIK9D46TCX
   5m2qiplZu72NZyAwe+GncDIGi0GRB+hMWKim7x2VVo2cnlKYrov/6Q8YO
   /5u0nu1Rw2EVXjg3SS2Wac2gNFEteDoQTWb40Cl4XwtWlp4iEw5ExEBTY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="378817374"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="378817374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 12:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914555260"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="914555260"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 12:03:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 12:03:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 12:03:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 12:03:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeT3t6bBUTf08LSFzlQycBGwgwuTB731o/Xuf1qvSQ4MOkR/nM5O7qPstvNk6HkWj655HK8aytXLvC2lhyCsPNBAQyK5MzdojGywjO0EiK0XWLNceVmRvDf3ZN67OVdZE2bx4ymBZ7vgPqRAAGzHVIAtBlzJuA6vKPpnnX5y/WeUI+6z/cE+FpYXuzr1zVyNO4VBSVGPnXcS9NCPKf2dEQTEd1/RCq0aTdg/W3twavhdiRdsgAaM/41W7J/OIgq+5ZE2/+q3BZecEEUneNQCNF9uOhDOOqZlzheew/ifnRxDm+UU1zqWrAf1hGYpGSw5eIQpxopRrF06PWK+Pe2aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gihy40wToNlciqmK0fGYKwtMvuW5VX8JysSVTANGHt4=;
 b=EpXI8+z5eUXM9BeuAx9J48T+T14iUQVqv2lDnMzgO8aL4oauSoRkQEZJqA+UTkZBMjv0sozIUJ2K5piqLGKyW50fuWkJartArjN5HJDkBn7BSpDd9OunMoTXU1Paif25zUBRyJCM6kqlCbAjG+qH7NirvynEBVbnGuqzcyCZSpnQxVFFjcWuFsmkNkDoOXqPIc2JhEfAxntQvFUiF8b5TQ3uqw9v4CeY1mvgYuWFTZVhC2V/w7ybFUPhl3gTgbeMdRpo3CQUoFBPhXBrTXnAkyktWIZ6y5d9NOP0N06h4l8HumEtaJb9p0+u6K5uv+/ghu7MmFcl2sSrjAUSse/Umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Mon, 4 Dec 2023 20:03:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 20:03:25 +0000
Message-ID: <0285bbec-7152-4f54-94a3-45ce265a3ebe@intel.com>
Date:   Mon, 4 Dec 2023 12:03:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
 <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
 <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60839F92B1C15A659CD32478FC86A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc221d2-f7c5-4f32-8674-08dbf504132d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlFDZKX9kUQ4mh6vXDXi56yMkE5gi3PGdaSgXpeNXZD9iMuu7X91Rty+AOHDblap+2j0HSExA0YNPMAZH6+nAv0ucguG7AvNZhKKCF214JeHbaT23N+bQQTKlbPKGmrN9v+JQrJ+0VJ+/SsYoecIZOL6xew3vhqIgHH4BMT/wE0E/HrtZwVGdqEhexNDLhjQr7pDxZv8ZY69KbjEKQ8hTXqJ1BLlkhHXg83CM6Ooc8vUaENCArlS6dzNpXRwsP3249JUKHh0bST5tK2G7p6tqO39g1CK4K8SKpgIlCL0ePT9Ntp6IvtrVAAgfpCeQA+hLoEmcEv0axKFbrk8Nu9rzWYU8kDpnVsCs+3ZjqmjTtTg6pQzx3AfkP4BnC/WSO8IfLhY/EqsgsbR6gKMiOvGHII/KtksZ7lbrQeJbrs3E8UmWmdX7w2HDdc76SfqqBIdYkjwaSfk23bycIC4KFHj1fkc0HXfIbs8rD+iX6ZemSiVlYevU6FNIUmUaV8XCW876tuPBqDDeHuHq8ecRT0wsV5Dv2Xo1TsQEVGmfwTsPlaC28G2KFtvfJyjFmGLqBk/S6pjFvO0Ccrx+DipyTB/YAmkQ/P5tVdSTnzjxJxQXtwW0Jt9EQQ/VpMLURkWUsisF2CikuAf9LEFph4ymddWxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6486002)(4326008)(31686004)(44832011)(8936002)(8676002)(66946007)(6506007)(41300700001)(2616005)(54906003)(110136005)(66476007)(66556008)(26005)(7416002)(5660300002)(6512007)(2906002)(53546011)(316002)(86362001)(82960400001)(31696002)(38100700002)(478600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzR4dE5MeFRLb1FqZDE0djd6STdFQm9vdXpkc1VkWlBrNUsxSDJJRW5BajNk?=
 =?utf-8?B?RzYrWDJHQWZFc3lOUWpxajgrWDczYlVlbFBwR0QrSlU3WHFBaWxrc2tOdzkz?=
 =?utf-8?B?K2s2cFpJMmtObkVjZWx4NisvTW1qODNObEFnTCtONFd2QzZGNE9iRWdRWXM0?=
 =?utf-8?B?Tzk3eDVsc3l0TUF4TXVEN1pnUnJxNlF0UXcyWXlBUnhsZi96eUduQUJJejNV?=
 =?utf-8?B?NXBrTllkWWt5WEhRQUs3NU42UGdiczNybHM3T2RxZmRnSUtuMmRMdmJuVGgz?=
 =?utf-8?B?WUVYWCt3R2NSWHhJc3RKYXFkdXRyelhCRWFzdmJKOTgyd0laa1AvTGN1cUtr?=
 =?utf-8?B?Uy9Gbnl4VElFcDk3QktBZ1VveUg3azVjQW4vMDk1NzN6ZEJxbmJUM3BXbjQ4?=
 =?utf-8?B?V3FRUHM1K254b2paM3pqcUQ0Z3ZGYmZ6OHV4SGVFTC82T1dIdzdRV0ZUbUoz?=
 =?utf-8?B?R3FMYWt2Z2Fpc0FaY3ArZWJRMGVic0Z5R3NVQXZWckVUcEhmbW80TUlINmFF?=
 =?utf-8?B?RTcyMWFvakd5MUJuSStkeDN5TGZlYlVDOGZoS0h6SUMyay9FR1NCZjRXbE1w?=
 =?utf-8?B?TjhlNWtrU2RzRjZtUFNxc0xXbHpyaFRqa0gzRkF1a1AwS2dwdk9xelQvK0g4?=
 =?utf-8?B?ZFhaajFmeE1Dbmg0Qi9tZVo3OVdNNGRRNklJWTNLTmMwV3JWRkdwTitEVGRL?=
 =?utf-8?B?M2x5c1JINWdtMURYR2JVa0t0bDhUUExKN25jNTlUSjFoM3JNYUtITkxLK0Z0?=
 =?utf-8?B?Zk85WEZXNGdzN0U0cDBldktTMEMycnFiNDVlc0g5SjZqcmhKbGJ5RmFHRDBZ?=
 =?utf-8?B?Z2NTMW9ZOXpaek1LVExjTGRTSUEvNHI3R21hMHZIeERtSEpoblBnRFd0N1N5?=
 =?utf-8?B?WGEyaFB4ZGp0eSt5dkxob0Q0emdNYmlxVGJBMEZVWHRZQ0FNYjBHTTJ1N3pQ?=
 =?utf-8?B?K1lidHdIeEEvR1JRblNpNTVCbkhaZjdhSFdKQXI2TFVQZDNEZjgyQUMxaktj?=
 =?utf-8?B?UGhwbk9mM0JxbkVKUWZPMGpmbmZHQjIrUG9qTjBYYXc4RVE2SEZacnkxYU9z?=
 =?utf-8?B?SzZCVm9FVVluVWp1bDdHWDM0dFVaM1dVbDlRSmt1bTdGeU1CTmlvN04yTlQ5?=
 =?utf-8?B?aURxWStiUk1KZ1dpbnlSQmI2UWdiblZJaDdVN2lLZmgwamlpMEpwTDdFU0ZH?=
 =?utf-8?B?MS8rRDlSbVZQUkJSRUFqN1JSTlVJWkxIMk0zZjlBc1MvVEFVVHRoMFNXbWVa?=
 =?utf-8?B?MFo2WHAyWjhON0UrRE9YLzcyUTV3WUhuV0xueFRBQjkwa0VKWm9iWDRKYkVP?=
 =?utf-8?B?b0dzbFRXVjFLcStmK1hzRSt0UGFiVlNHOFBVZjNLM0cvcys4OTg1TWMrMFZp?=
 =?utf-8?B?NnlmNWpIcGtPVXhzZVRsckxXNWY0RThydFNtbzlOY0F2RUtQeFNmTm83Q3pP?=
 =?utf-8?B?aHlqTXlQYWFKRDgxdTVwMUNLTmd5UFlPOENlZXVqbWN1V0ZmU1p4VU1xclFJ?=
 =?utf-8?B?Y3NheEc1YjA3cG1NUWhoUW5HbDMyQmlDRDAzaUZvdnUvNFVwMUF6L2NuREVP?=
 =?utf-8?B?L1dGZEc0K3g5RTB3NloxTmxGcHVIeDFTQWtvZWNobS9zWk93VG54SVpnZDIv?=
 =?utf-8?B?QW1jdW1kUEg4RTU4czAzNThKUXpzR0tMYktGZ0FmWmpLQi9oZWlsVTV1VXlM?=
 =?utf-8?B?Q2c4VW9XOE9YcVRINHk1cEdKYjhmd2sraXc0TUY2RHBqeHgrREg3QjFEdDBB?=
 =?utf-8?B?ZzVJdFdDUXpBQTdhcW9aSXVGUC9kWUl3K0lZb0k1ZHhXZW5weXUvS1RNR0U4?=
 =?utf-8?B?WGc3ZHNaUXBqWXEyRlZvdGFxOTAyYTd1NnpZZHhsWUhpMXlJaDREVGN5WGQ2?=
 =?utf-8?B?VnVuRWtBa0RMaUxUL3R6Ykp1R0wrS3RwRkNVWXBGdHF5dTg4WkhiMlRuQ1Ux?=
 =?utf-8?B?VGNoSGZGMUhvMEI2SVpWb2hHMWNjeEs2TUE3dklaN2FJMGZYYjBCWldBOFc5?=
 =?utf-8?B?SWpSZWNFZGpKTlluK0lhTVEvd1VlUFRseDY0ZzdBVUJtemFRQTJUTFJTNUx4?=
 =?utf-8?B?RGJWdjFSNWdHZEhHTjU2cmdsSDJ2NFJFUmQxUDZBcUlacTFwUHVMTzdIb1l2?=
 =?utf-8?B?dXc1WkpUZzEvUG1VeGE5elFKUVdVRlVrNk14eFBRVEU4YmpRbXRZRG1hanVE?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc221d2-f7c5-4f32-8674-08dbf504132d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 20:03:25.5358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gv+hWHRpaQ6VCVDX0hu1rgOveHyaFL31zzQIwj5lb2LUCVdVMz1FQnOquG5f/ZFbQVCSbNBmolubZVydkS76nQ9OS9jzhTxXPOkavWTetU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
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

Hi Tony,

On 12/4/2023 11:45 AM, Luck, Tony wrote:
>> Yes. I saw the thread. Even then I feel having two similar options can
>> cause confusion. I feel it is enough just to solve the original problem.
>> Giving more options to a corner cases is a overkill in my opinion.
> 
> The "original" problem was systems without "local" bandwidth event. I
> wanted to give a way for users of mba_MBps to still have some way to
> use it (assuming that "total" bandwidth event was present).
> 
> Reinette suggested that some people might want to use "total", even
> on systems that support "local". I firmly agree with that.  It is easy to
> construct scenarios where most bandwidth is to a remote node. using
> "local" event will do nothing to throttle in these case. I'm not at all sure
> why "local" event was picked. There's nothing in the LKML threads to
> give clues.
> 
> I proposed a mount option "total" as a modifier to be used in conjunction
> with "mba_MBps". Reinette said it was too generic. Her suggestion was
> to add "mba_MBps_total" to be used instead of "mba_MBps".

No, it cannot be used instead of "mba_MBps". My intention was for it to be
in addition to existing "mba_MBps" since taking "mba_MBps" away would be
considered breaking user space ABI.

Even so ...

> 
> Is that where I should have gone, instead of "mba_MBps={local|total}"?

While I did propose "mba_MBps_total" (in addition to "mba_MBps") I do
recognize your comment that a new key of mba_MBps_event does give more
flexibility if different events become available in future. Emphasis is
on "different" since I do not believe the parsing can support multiple
events and thus mba_MBps_event cannot be treated as a general bucket for all
mba_sc options, just different events guiding the feedback loop.

"mba_MBps" must be kept and having it continue to use local bw as default,
but total bw on systems that do not support local bw seems appropriate,
(which is what this patch does).

Reinette
