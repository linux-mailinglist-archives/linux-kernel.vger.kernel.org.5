Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7024C802379
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbjLCLvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:51:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5FDC4;
        Sun,  3 Dec 2023 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701604286; x=1733140286;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rv22i3N0Lo7E8wSslL/gLw+DgEldu+5iD48dSwHC1Ww=;
  b=FWFozFK3s+DN40lQ0f5PuFp9pQ7gVb0CUGQEgR/wbKplrQdeEwcpfNUk
   osGHVdUuXtNh2F8m3SDsgdb2Hd6hWigMPuN1C+Bu6k9olp1BT2puqkiD2
   s40/N8XX7bGBzI2HkVu17ab30OnJmfSIUlzeQXUJyuEnavWKHqcNw+BKD
   w+6Xds8STsDpWFw4mwpGBJaL6hFNOfVmrBw63/Gqf1GjjB0TJz8qlsFo1
   U00MbQSjY/wOQW/CaxgMU3ltz5TD69+8YpEKHPwe7NgDnBmFOwy/L574/
   lXCTwf8dBOepu+7ij6hyfWGxq4uMOHHIzp39h5ZB6HJUS0QBeA4qfzv0v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="682405"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="682405"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 03:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="893700744"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="893700744"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 03:51:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 03:51:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 03:51:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 03:51:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRIyf3k8ClPylbgnoxhbNL4Uxs9uWmfGFefii9ZINYg6aY0HrybAiakr+pSdFp1EajKT/l8Sw+GjSOPXM9VAx/0GkoPVGHs8FdvzNPEb8+0BU484/oDHbQBagPJp3HLK1ceWsCaluJj8MtXG4zhSkAxB5Nel10hNCVh7F+5a/skumKC3llPoHQm7m7OdrYAVgNPe13nfyhpztTnE6wdjHCnoadJn1T/NoVcRMHLoQZD4A7vbrfxn0xz7r/TVndhPhXr2PlNscGRyMw5uMD5PskK2maQHwK0/FLfPbAbA8QbkGHBwXZUGKr06AhOiHEnbdhgkqXqxRdhynUZUaE5TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUEfeWIhgYPzotkvAL8Z4o2JnXf735kakhAcyaASlPs=;
 b=l1WkDEEHyMI5aArGwoI+ZIRM7pBuEUybMQFV0w2/rpsqsCPKFONsSq+qFvfydWFz2VKq7UxE6Gm7g2Qawm3UzEF+NpW+IxarlRXL0KmTt6MasGEP12vt+pIvIMUUh2g2+DSkqTUOZk3sL3IgZVEshOchAYLvOE9DJ4XaNIVavf2Mu75y1jNEj/s9HsBp10xKekjYWn6UIGWh/KMGlF0h589lHFM2S+hyXXkXT0TaN0tU7poi62nLQnvU832hKRqBdyXmtjGM0gvyeDJib31eJJrfmb9gXdt3lY24VDQFKkyqp+8PwnNfLkb/Be9MiftTuymZWvEL8qU8GPIMhtZJYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SA1PR11MB6784.namprd11.prod.outlook.com (2603:10b6:806:24c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 11:51:23 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 11:51:22 +0000
Date:   Sun, 3 Dec 2023 19:45:30 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Yu Kuai <yukuai1@huaweicloud.com>,
        Edward Adam Davis <eadavis@qq.com>,
        "syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com" 
        <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "yukuai (C)" <yukuai3@huawei.com>, <andreyknvl@google.com>,
        <balbi@kernel.org>, <heng.su@intel.com>
Subject: Re: [PATCH next] trace/blktrace: fix task hung in blk_trace_ioctl
Message-ID: <ZWxqWjwPft3sG12Y@xpf.sh.intel.com>
References: <00000000000047eb7e060b652d9a@google.com>
 <tencent_6537E04AAC74F976B567603CEB377A96FA09@qq.com>
 <5116cbb4-2c85-2459-5499-56c95bb42d16@huaweicloud.com>
 <20231202170743.7557e7b5@rorschach.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231202170743.7557e7b5@rorschach.local.home>
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SA1PR11MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: d4baadd5-704d-4334-ebc4-08dbf3f62bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zm+PHYbCi8iKdYYKOSFoWcdqnZpKV+4XBC6V9PVWGFpp1yWluIaH7qJ6oSVbk1FcSYxePr8OIs+ejEaTG2kdSIqpjElqFd6azxQqBtfEJzS6RvgtvWPuBvcTp97BV+n/BCpE/gsAyWTbfQT3vUWAC8q1dYWd6L1XWpoTu+VoyqkQ7WzZXb5VzubDhWM4u90MfhUcNI6xYK0k0QSEgPwLjQm1IHRJkRONSB/DsrAl2VH4GiiZfvsjCQIURkHumZu3MZv7+0ke+0fgpbiTKSdY0B6/Xy2gqcAPjWVuKDURt1cbfI+/b/7gSplOQ9kjdSq4/UYAV6QZOe2MxZYxsCtR2uYB+psRVTxxR0ES2TxEe6/aTyfxH+iv6DgQe5L8vwOafjuE2M/gQZ3y/YHbD3KoOjWUxD1SQiKPV3Fm7puWqrqxCQrdvzit1xRTYyJqJrtMMVh4VchoWkmJK5PQ6dJOb1s5IZeLtR7Odja9xOR8nVMLJz8y6jFT33B0CV6B0oXr6Y2Kzo0E2VaGRGGeFkN1TSAXYwQ9wjh0Al8jBLBiF4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(2906002)(478600001)(86362001)(966005)(6666004)(4326008)(54906003)(316002)(8676002)(8936002)(107886003)(6506007)(53546011)(6512007)(83380400001)(26005)(7416002)(5660300002)(6916009)(66476007)(66556008)(66946007)(44832011)(38100700002)(82960400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE80QXZpR2lPanJlT3NLRHZBV3dJYjRwM0Y5b2NPN2N5ZDQ1VnlscXVkVDRE?=
 =?utf-8?B?L0Z3U1d4bU1EWmlWSnFLdlUwSVl4cnNLQmM2WHRYVS8yUkNJUmdqb1BlVm5X?=
 =?utf-8?B?Nm0rdDJwNlA4UXVzb0E0MVJVR2d3UFZyTy95OEpCUitvZUQ0YWRUcnYrUFpk?=
 =?utf-8?B?RDJ4QVhRcC9GS3crYW1SU0REUWhUdkVTT2dWTUFpWmR0QjB1YVpwVURCK2pz?=
 =?utf-8?B?bFFvVFZRQ3lvc1VNVndwRFVrYTNJdkpEbTNFZ0V1ZURJNTV4K0lXTjYwV2Zh?=
 =?utf-8?B?QlE3Uzg5OEYvaFNucjR4ZkdFQVNWa2JueU16Q1kxTExEbHNhWkExOFA5L0FF?=
 =?utf-8?B?SGdHRWF5ZWhEbDllR3NCbTN0MzBOQ29iMUlTSzJUY2JLOHFGOTUwZlVrNmN0?=
 =?utf-8?B?UVZ5QnlxWHR6ZnFvZW93N3E5ck11WHdUQUg2QStNS0tYWHBoUkVnaDJlRWcv?=
 =?utf-8?B?em1OSjlRbU9ISnZwWDdHYUJEdWR2WForV25rOFVBRzFJK2NDZDR4T20wTXZC?=
 =?utf-8?B?SzVaSkp6c1lVU2g1RmZ0UFVNeFcyaHNjS2x6OVY0cHZOTVRwclZtK3hRQlJX?=
 =?utf-8?B?TFlJNEVYQndKa2ZUS3FVU0N6L1ZNNzJ3dVpZOXA2QUc1dm1heWpCS2FXSVhF?=
 =?utf-8?B?ZWxUeVBzWUJzSmV5QS9LUzZqOUJiMGNnMkJseDZnRERzQkRrTGhRNUE4RFFx?=
 =?utf-8?B?VlVnOFFrZXFPYWpoWXduQVdjczlFYjVjRkRaOG1kbzdLNnRhOENkQXJ0M0Zu?=
 =?utf-8?B?OGxLcHhabVB6MTUyN1JySGdiN0hZWXpLYjIyVStZbXRGSlhWQWg5WVhWVjYy?=
 =?utf-8?B?aHVJWGIyMkFUUXZqQzltQTRETm9STFhIcmpCTEZ3V0UybWVMeUdXL2p6VjZI?=
 =?utf-8?B?VlBHVHpwYzJmbTRBdkNDVDFLQjltc2J6c2JQdlVLcURQaENEekwvaElxL0tK?=
 =?utf-8?B?WDZOL1E4WVp3WVZKZEwyY2k5TGZOandjSVdySFZxWFFlNnBmcVM4MUIrQWtQ?=
 =?utf-8?B?MjZyZXIwRHkwemwxdXRPaXJ5M0Z2UmpwSmYyb1NuemYrVXgxK29pVG5ISmZF?=
 =?utf-8?B?V3ZSSFV3MGVudDhBRmNJbnF0Zlo5cnU2TU9QSmh2SVNkV3RoUURBYjJhRkY2?=
 =?utf-8?B?V1B0Ty96b2JRUWNhMW5yMi9oNnFueW92K3YzRURFSm1wY0dIUjJud0Q0Y0dU?=
 =?utf-8?B?YW5yYXJyN1JSc2h4RGdxRiswMlNDbEF5ZndxdjFUK2tSYkVkQWJQSGxLeXdI?=
 =?utf-8?B?WTFabFlHUEwwNVZmNXIvN0JqaFJZayt2T1JJTmF3UlZna2licFFaUDVrN3Nu?=
 =?utf-8?B?OXZZS1FqNXRsQ0hKNGdacHZHYWdQSXdHb2hHbTM1cHVVWkZXZXFjV2kvTXRv?=
 =?utf-8?B?L3lBYU5hOG5kNDh0Z25oVXlmRnRwNU1qbzlrVUI5SFpSckszUzRQSXpoR0Vh?=
 =?utf-8?B?REEyNm9OdzczZllqWW9VSlJLL1hSVE45T0ZSRy9MVHRrekFjN0RjWmw2SnRF?=
 =?utf-8?B?c0IyWTY1bWhyaWtiNXRlVlZFb1NuVjVaZEZjQVo0bHhyWGIvRGtGVE80TUlL?=
 =?utf-8?B?WDNsbFlQMTdnekM2WUJoYkRFeEJpL3kraDljdkJCeTV5Smx3SDFEcFVFbGhR?=
 =?utf-8?B?eWtMc1hJY09rNlgyOU13dlZNRmJxNDVtdldLdENWenpxRVJERjdSUTRyQWNs?=
 =?utf-8?B?b2xiZXdaRkF0TWg3UmZJb29PWEdtOHBKQTBSeTkzdXd5U1F2Q2ZKZHdrZlpU?=
 =?utf-8?B?ckRMUHNIMUxVWnFpRzhWc0dnMjZPNGdBaktXWGhIZDR0RDc4cXN5T1ljZi93?=
 =?utf-8?B?d2VCMnRlbG0vaFpsb1NOR05kV2RRMExDTkQ1TUtWRUVibUZEYU03Z2ZFT0Rk?=
 =?utf-8?B?WFRQTEJieDM4UlpOK0tnTGwzZjY0MXZzSU53OEFBamdJVFNHNldQWHFLRVZl?=
 =?utf-8?B?S0lUeEtqTmhmWnRXYktISnVPcWhyZnJjdis1WkFkM04zWVNtdWxFbGVnNEI0?=
 =?utf-8?B?ZmtoMGNGRjdzbW1xUFc1Q3ROelpNNUtkZzc0bG5keDhuR0NaWnJPd3h0eGM0?=
 =?utf-8?B?TzFaRS9Ud3ZLa0djMXB0cWZ6VnlYNjllTi94T3phRFBMOWczTXB1TjU5cUpm?=
 =?utf-8?Q?T/Wpu2x8ku9entqi3rStACbLT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4baadd5-704d-4334-ebc4-08dbf3f62bbd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 11:51:22.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kppsK8hNX+aN7v8TxIzCakECyEkw9f77ut+h+Sos/dPeECirm4I9oPIDbajp2iKtkCb9z4mdwCHAPO/ARsvJTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6784
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

Hi,

On 2023-12-03 at 06:07:43 +0800, Steven Rostedt wrote:
> On Sat, 2 Dec 2023 17:19:25 +0800
> Yu Kuai <yukuai1@huaweicloud.com> wrote:
> 
> > Hi,
> > 
> > 在 2023/12/02 17:01, Edward Adam Davis 写道:
> > > The reproducer involves running test programs on multiple processors separately,
> > > in order to enter blkdev_ioctl() and ultimately reach blk_trace_ioctl() through
> > > two different paths, triggering an AA deadlock.
> > > 
> > > 	CPU0						CPU1
> > > 	---						---
> > > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> > > 	mutex_lock(&q->debugfs_mutex)			mutex_lock(&q->debugfs_mutex)
> > > 
> > > 
> > > The first path:
> > > blkdev_ioctl()->
> > > 	blk_trace_ioctl()->
> > > 		mutex_lock(&q->debugfs_mutex)
> > > 
> > > The second path:
> > > blkdev_ioctl()->				
> > > 	blkdev_common_ioctl()->
> > > 		blk_trace_ioctl()->
> > > 			mutex_lock(&q->debugfs_mutex)  
> > I still don't understand how this AA deadlock is triggered, does the
> > 'debugfs_mutex' already held before calling blk_trace_ioctl()?
> 
> Right, I don't see where the mutex is taken twice. You don't need two
> paths for an AA lock, you only need one.
> 
> > 
> > > 
> > > The solution I have proposed is to exit blk_trace_ioctl() to avoid AA locks if
> > > a task has already obtained debugfs_mutex.
> > > 
> > > Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")
> 
> How does it fix the above? I don't see how the above is even related to this.

I bisected this issue and the following fix information is more accurate:
"
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
"

All the bisected info is in link: https://github.com/xupengfe/syzkaller_logs/tree/main/231203_140738_blk_trace_ioctl

Acked-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks!

> 
> -- Steve
> 
> > > Reported-and-tested-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >   kernel/trace/blktrace.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
