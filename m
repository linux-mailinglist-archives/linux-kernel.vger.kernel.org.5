Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571CD7E9F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjKMPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjKMPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997F1A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699887968; x=1731423968;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=JkhT4KqMlZNcnzF0pYokIwpzx5Z5xSgqxweZxNAtxQU=;
  b=l47pbK6PB49cQ8j+JnNHNhJw1DkFJlHPzu1TSDtt/8iy28HUtH3S0A2r
   IUJhTr2cv3tZOnIvjnskpkSvvfBnSPXJr0MalmOq8uqQ+QaLwrmxOhspS
   fkA6ShIOJVzianVz03Acpt1TzD+W8qxDA8oDqYhQH6sixW9H58RYsvh+L
   1SKRUni5rd5MnSMwz076Jgg/FNy32u3LF4G+m75LJrsjdwVmugWq84bCZ
   1Dz76181MzW8vvS0AVjku3oikPY0qB/LmfbLZ3xgL8O1HRW73NMzEzG56
   830H4dvvB3ZhFw1WhMOQ01PA8sTaSjzaJz6xqyry7zxPUCkm8hJjKV4H1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="387614563"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="387614563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793457303"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793457303"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 07:06:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 07:06:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 07:06:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 07:06:05 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 07:06:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3kUlzz0c86sSiHKAfV4rfaD87IL+6CMrnFNEsr9jlTE5EKUUrirIV5o3yHDLU7xNNsPkbJLbuPVLlSP5dnYhJPs67WknAs+XAdtMHd0WWHcVct2cXePZXHz9NoPa6ym/70w3AJaH8BVhhOjcGcwbNrGdsm/LEO+1ntxBqA4yqAmX7SWxbMurN8UQcaM752iS0aBAyHeXU56ZwG8rg4lG/4ed5gUrMkYLrKomjY5DDANPzwlidnelin7e/2Fq3BmfURxtZ10su8xVCFQXxvTUZvlrwd8oQ8TKgYUHjuN0g8ulQYV0qZTal8o++bSDXLWwHU1l+lNi/PJ/HRQxk62hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3zvQtvyZA5qqcYnGTGGYklaDrVGWa3mhjS84KDFYrE=;
 b=lwOeWJCz/dERLM0ngNY4kzA0hP56Q040IxLPNaoUWf6cs8S4/aCZ81wibkdZJI+rzGmbgS9uvQCikCG6eKAUzt7c7YibL0ZjEDV8x4D1vIqwFVbJjdwA4wds6jzU8Za9orsegnujmDqQ9M3Ze88QZpavjBICnluQBu47P53GIETOShkcKPDjkl7AokcLPcnaj5Ww4A9/6RNiO225bhFAKdqoPkHMW0SUVBySFpUJlNXc6EV48k1ddeF7NvE+f1Wrdbzz2RJQ/SkjpudeeQakfnlK8I0jbG3bA6i5FFYYo4PlBOcGBra7V0tDNmjxN8zOUaOSvyYXgMhWkhZEuT4FHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:06:02 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:06:02 +0000
Date:   Mon, 13 Nov 2023 23:05:49 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, <bristot@kernel.org>,
        Phil Auld <pauld@redhat.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <202311132217.2a9a4aac-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0909b0-a8dd-4aab-e7e6-08dbe45a0cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udg9OLGnuSE2Ah0l4/J9KBM/ZlXk+H7lsVqaVHaIs0Sez4+rVA7hA+ucXlWyYpBogYztsa6QDZtTivSCltOmKSFfryLkpTEB+jtO3mZ8dq7dnnsYv3u2hakHHkku/zfm/Pe63OKbwM5zHUAcy38Q9UG7cxxEoRTiRlcR5IoUpwEnwrcWLco4IFinwX3Wa4UI0LwPAgKy7RrCqFYSYvBnbForFFQHEuww8C14Z0ZVUJz3glC58CB2BIOzbLoBDLdll8RMSIe3CzdqvT/X2+QIT3pnGvQ5kpYSjO6G/kjdS4sMtd1d2aDsPnEUt3WS91mym7WbwcoYof0WY/TKU5v7s3g2A5tgHUbLaGZKQd8uoiR7Pp0X0FfqwPYEgxRcWannhqA7WT1V8RpOoCWv8bKW1gCJ1ORfsiKq8J6+m8SCmU2P+H+BxSkY4wRmpVoBkSR9iptF1n70Ma4G2uaKd5knLp3nZJ+uPZ2y/4pWuTnM1XO2U44VjQMKBe92HsLMo9hnOk7BJ5Yc+bXxwRbdo7Paj0GoKG3CLH1QrMtoMF+yo8Aa3+Pnk6Tx/p+ky38Lh0Ma9uDRxbE1FL961e4x1IAmWcZmccReGzcY/+uDZYwJ2ztaKO1gSodfJ32OL0It1M0x3kOnzZ3tut19fISRcpWJ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(2906002)(30864003)(83380400001)(38100700002)(86362001)(36756003)(82960400001)(6666004)(4326008)(8676002)(8936002)(966005)(6486002)(478600001)(45080400002)(6506007)(41300700001)(66556008)(66946007)(316002)(54906003)(6916009)(66476007)(7416002)(5660300002)(2616005)(6512007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iSjeiRvh6UrhrpWdSB7JhYaGtoIxsQy7WwmAt4ignnX0uRoh3LKvs5o9gmFl?=
 =?us-ascii?Q?4ZJC/vKPJs75slFzidzGxtmbIgvTZrM9M9ZeyqPE9uKZOvQmuYwcTyWg4omi?=
 =?us-ascii?Q?g1dlotDZxhKQIQduMN63te55Y3ui26c3nXlYBc/p9wcHCiYB/G7c9P4GgYsM?=
 =?us-ascii?Q?tvgvLogb+uYT8xKw7v0QypQ212ASlYvSD8yEJeUIGj+I966rJyvmCDFNkDsz?=
 =?us-ascii?Q?VqK82QW1xTUDgNMTwPPQI1WKL8uQra3QibZVxaptYoHOJo3OF/+MoPc2rpwH?=
 =?us-ascii?Q?NeENE0AQWNGTUwWqY28T1z08eEfoTX6n2lJVrvlsLarTT/eXtKwkAUFl9/St?=
 =?us-ascii?Q?KVQw0H6jbcyVMnr5jXy6B8+VNUQ61eyWkkGQZqpzUKSYGcHIzXEnst8ne7yS?=
 =?us-ascii?Q?nRXppevmopWwziDumJLUqriRzjdx05hTSKSIOhobBg5SxdHFFXez1557iGSf?=
 =?us-ascii?Q?07DN7TmFEhiWvHmt5eYxGa4q0FfCdiTA52pY9rqMQ49eKUTIwoKshTrTDcbv?=
 =?us-ascii?Q?cOjaDqKHhXImIIzZZXh5+6bL4IWxcEJdJMPvO62GtGrv9u7mMYd4qwm92gaW?=
 =?us-ascii?Q?cGRQxQ9CGbHGoBvNFW15YFSTxuI0TFvGpreBDkYDezSyev6SEDQwdLsL27go?=
 =?us-ascii?Q?Czo4P+3yrZzPENpbkL7YDOUt0XdqCWcXpeAjd1blFDQxN5bZoW+xI2vLYIEA?=
 =?us-ascii?Q?K/9FQaThrv1Z+aGonL+sNSJ6DTDBE+Z8XHpq0eKgrSDDL/LA52TLsDcd3o3v?=
 =?us-ascii?Q?Eb9XicwR4w+5e0rU8SC+5YtYlIFbS3pYid6Mm+0qm1X31k1JnyuAXD9+BUah?=
 =?us-ascii?Q?SDTdLhZ5JtC6pSK7GDOIuE8oJtsJPXuZ95TDZPsEkt+2T8dLECu79WaK9o5F?=
 =?us-ascii?Q?g3Ss/2cgCnwcagfYWM4u5ntNNsQm22Uu/Imz7wIoN7YqzP283178Gczy3dfI?=
 =?us-ascii?Q?Lm+qgynkj/jQ9/MKDOvhvchAbjKALdpG2sWHFi02jOCn4Y7uISAGv/VAPq6I?=
 =?us-ascii?Q?0/aXClKXxfz3JrbcO7gfPj894jelSc4iYqiAIjzdd2vKHUF0jcLZRhYvOo/r?=
 =?us-ascii?Q?Q2GMnOvYNr1nyefVHYAznI1aY0W6lX4L4gbd+Pqj0AtWBPeYaaXMXjd5IlY1?=
 =?us-ascii?Q?05YBzOgKkm8Fs92keGgeSmB09IZo6rRVaiKCsKbSYwMOSX2oNxwNyYVKtsRU?=
 =?us-ascii?Q?OYwItZhelJ9qELqBQlwp0eOfwvMYBXtxPg/dKwGQYBNi4QUY40avArvo+ZH+?=
 =?us-ascii?Q?7Aaf9DUl1M29L70j8kSZ6UVfr9jS5SXT5VHSuh6NZpa2vgjPzH13yZ8t/k+M?=
 =?us-ascii?Q?NOlzmWTIUWnL7v3WSAQbD7pQwBFnl5dfgInHeGKCjSz9SRUchTOn47LrImbd?=
 =?us-ascii?Q?hrAracprKDaMM9DudRNMl8rOewMgYqPRBpKMT/H/XnUb4lA4DWWmtf7ZFV9V?=
 =?us-ascii?Q?TRJIDBmFTrKBFNO5sa2QzJVUs55EhuiR7cRsJKYnbHyk2zdusQ075uAJGLMn?=
 =?us-ascii?Q?kuFBRzisccBxRlMeWRdbfPVOvknypqox6fpfEbsNZUC008ikjFIa/FZgc/pg?=
 =?us-ascii?Q?Zul1JaSn7JnQbIg4BNmvg2OhbHLB8NSgPrB9hotLMx77fWtEjUDXLhKAMK/L?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0909b0-a8dd-4aab-e7e6-08dbe45a0cd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:06:02.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eevdAnRfQfO4gtN79MxqcdtoXB0NZHeQ5hSdwglRe3UN4DmjyUuAz1oIEP95yIHKvmd6a/A8dNgdX6HW0vDag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/deadline.c:#enqueue_dl_entity" on:

commit: dea46af8e193ed4f23c37123bfd4a825399aedfe ("[PATCH v5 6/7] sched/deadline: Deferrable dl server")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/sched-Unify-runtime-accounting-across-classes/20231104-201952
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 984ffb6a4366752c949f7b39640aecdce222607f
patch link: https://lore.kernel.org/all/c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org/
patch subject: [PATCH v5 6/7] sched/deadline: Deferrable dl server

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-9
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue does not always happen in our tests (show 9 times out of 20 runs),
but keeps clean on parent.

6f69498ee58c052e dea46af8e193ed4f23c37123bfd
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          45%           9:20    dmesg.RIP:enqueue_dl_entity
           :20          45%           9:20    dmesg.WARNING:at_kernel/sched/deadline.c:#enqueue_dl_entity




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311132217.2a9a4aac-oliver.sang@intel.com


[   59.623267][    C0] ------------[ cut here ]------------
[ 59.627229][ C0] WARNING: CPU: 0 PID: 1 at kernel/sched/deadline.c:1803 enqueue_dl_entity (kernel/sched/deadline.c:1803 (discriminator 1)) 
[   59.627229][    C0] Modules linked in:
[   59.627229][    C0] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T  6.6.0-rc7-00090-gdea46af8e193 #1
[   59.627229][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 59.627229][ C0] RIP: 0010:enqueue_dl_entity (kernel/sched/deadline.c:1803 (discriminator 1)) 
[ 59.627229][ C0] Code: 8e 74 ed ff ff 45 84 f6 0f 85 fd 08 00 00 48 8d b5 08 d8 ff ff 48 8d 95 c8 ee ff ff 4c 89 ff e8 40 f8 01 00 e9 50 ed ff ff 90 <0f> 0b 90 e9 9b ec ff ff 48 8d bd 1c d8 ff ff 48 c7 c3 40 fa 1f 00
All code
========
   0:	8e 74 ed ff          	mov    -0x1(%rbp,%rbp,8),%?
   4:	ff 45 84             	incl   -0x7c(%rbp)
   7:	f6 0f 85             	testb  $0x85,(%rdi)
   a:	fd                   	std    
   b:	08 00                	or     %al,(%rax)
   d:	00 48 8d             	add    %cl,-0x73(%rax)
  10:	b5 08                	mov    $0x8,%ch
  12:	d8 ff                	fdivr  %st(7),%st
  14:	ff 48 8d             	decl   -0x73(%rax)
  17:	95                   	xchg   %eax,%ebp
  18:	c8 ee ff ff          	enterq $0xffee,$0xff
  1c:	4c 89 ff             	mov    %r15,%rdi
  1f:	e8 40 f8 01 00       	callq  0x1f864
  24:	e9 50 ed ff ff       	jmpq   0xffffffffffffed79
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	e9 9b ec ff ff       	jmpq   0xffffffffffffeccd
  32:	48 8d bd 1c d8 ff ff 	lea    -0x27e4(%rbp),%rdi
  39:	48 c7 c3 40 fa 1f 00 	mov    $0x1ffa40,%rbx

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	e9 9b ec ff ff       	jmpq   0xffffffffffffeca3
   8:	48 8d bd 1c d8 ff ff 	lea    -0x27e4(%rbp),%rdi
   f:	48 c7 c3 40 fa 1f 00 	mov    $0x1ffa40,%rbx
[   59.627229][    C0] RSP: 0000:ffffc90000007d28 EFLAGS: 00010092
[   59.627229][    C0] RAX: dffffc0000000000 RBX: ffff8883aec00418 RCX: 1ffffffff096d168
[   59.627229][    C0] RDX: 1ffff11075d80078 RSI: 0000000000000020 RDI: ffff8883aec003c0
[   59.627229][    C0] RBP: ffff8883aec003c0 R08: ffff8883aec004f0 R09: ffff8883aec00500
[   59.627229][    C0] R10: 0000000000000000 R11: ffffffff873fba8f R12: ffff8883aec00414
[   59.627229][    C0] R13: 0000000000000020 R14: ffff8883aebffa58 R15: ffff8883aec003c0
[   59.627229][    C0] FS:  0000000000000000(0000) GS:ffff8883aea00000(0000) knlGS:0000000000000000
[   59.627229][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   59.627229][    C0] CR2: ffff88843ffff000 CR3: 0000000004e70000 CR4: 00000000000006b0
[   59.627229][    C0] Call Trace:
[   59.627229][    C0]  <IRQ>
[ 59.627229][ C0] ? __warn (kernel/panic.c:673) 
[ 59.627229][ C0] ? enqueue_dl_entity (kernel/sched/deadline.c:1803 (discriminator 1)) 
[ 59.627229][ C0] ? report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 59.627229][ C0] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 59.627229][ C0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 59.627229][ C0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 59.627229][ C0] ? enqueue_dl_entity (kernel/sched/deadline.c:1803 (discriminator 1)) 
[ 59.627229][ C0] ? update_rq_clock (kernel/sched/core.c:765 kernel/sched/core.c:750) 
[ 59.627229][ C0] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 59.627229][ C0] ? sched_clock_tick (kernel/sched/clock.c:270 kernel/sched/clock.c:426 kernel/sched/clock.c:412) 
[ 59.627229][ C0] dl_task_timer (kernel/sched/deadline.c:1193) 
[ 59.627229][ C0] ? pick_task_dl (kernel/sched/deadline.c:1174) 
[ 59.627229][ C0] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 59.627229][ C0] ? enqueue_hrtimer (kernel/time/hrtimer.c:1722) 
[ 59.627229][ C0] ? kvm_clock_read (arch/x86/include/asm/preempt.h:95 arch/x86/kernel/kvmclock.c:80) 
[ 59.627229][ C0] ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:292 (discriminator 4) kernel/time/timekeeping.c:388 (discriminator 4) kernel/time/timekeeping.c:2320 (discriminator 4)) 
[ 59.627229][ C0] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 59.627229][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 59.627229][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14)) 
[   59.627229][    C0]  </IRQ>
[   59.627229][    C0]  <TASK>
[ 59.627229][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 59.627229][ C0] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
[ 59.627229][ C0] Code: 83 c7 18 e8 ca 80 74 fd 48 89 ef e8 82 18 75 fd 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 93 55 69 fd 65 8b 05 54 1a 66 7c 85 c0 74 0a 5b 5d c3 e8 30 63
All code
========
   0:	83 c7 18             	add    $0x18,%edi
   3:	e8 ca 80 74 fd       	callq  0xfffffffffd7480d2
   8:	48 89 ef             	mov    %rbp,%rdi
   b:	e8 82 18 75 fd       	callq  0xfffffffffd751892
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq 
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti    
  25:	bf 01 00 00 00       	mov    $0x1,%edi
  2a:*	e8 93 55 69 fd       	callq  0xfffffffffd6955c2		<-- trapping instruction
  2f:	65 8b 05 54 1a 66 7c 	mov    %gs:0x7c661a54(%rip),%eax        # 0x7c661a8a
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq   
  3d:	e8                   	.byte 0xe8
  3e:	30                   	.byte 0x30
  3f:	63                   	.byte 0x63

Code starting with the faulting instruction
===========================================
   0:	e8 93 55 69 fd       	callq  0xfffffffffd695598
   5:	65 8b 05 54 1a 66 7c 	mov    %gs:0x7c661a54(%rip),%eax        # 0x7c661a60
   c:	85 c0                	test   %eax,%eax
   e:	74 0a                	je     0x1a
  10:	5b                   	pop    %rbx
  11:	5d                   	pop    %rbp
  12:	c3                   	retq   
  13:	e8                   	.byte 0xe8
  14:	30                   	.byte 0x30
  15:	63                   	.byte 0x63
[   59.627229][    C0] RSP: 0000:ffffc9000001fbb8 EFLAGS: 00000206
[   59.627229][    C0] RAX: 0000000000000006 RBX: 0000000000000200 RCX: ffffffff812e2631
[   59.627229][    C0] RDX: 0000000000000000 RSI: ffffffff83eaa940 RDI: 0000000000000001
[   59.627229][    C0] RBP: ffff88812d07ed00 R08: 0000000000000001 R09: fffffbfff0e7f757
[   59.627229][    C0] R10: fffffbfff0e7f756 R11: ffffffff873fbab7 R12: 0000000000000000
[   59.627229][    C0] R13: 0000000000000246 R14: ffff888195a701a8 R15: ffff88812cd23350
[ 59.627229][ C0] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4655 (discriminator 3)) 
[ 59.627229][ C0] dma_fence_signal (drivers/dma-buf/dma-fence.c:327 drivers/dma-buf/dma-fence.c:476) 
[ 59.627229][ C0] wait_backward (drivers/dma-buf/st-dma-fence-chain.c:621) 
[ 59.627229][ C0] ? find_gap (drivers/dma-buf/st-dma-fence-chain.c:603) 
[ 59.627229][ C0] ? __cond_resched (kernel/sched/core.c:8521) 
[ 59.627229][ C0] __subtests (drivers/dma-buf/selftest.c:106 (discriminator 1)) 
[ 59.627229][ C0] ? kmem_cache_open (mm/slub.c:2479 mm/slub.c:4232 mm/slub.c:4560) 
[ 59.627229][ C0] ? __sanitycheck__ (drivers/dma-buf/selftest.c:92) 
[ 59.627229][ C0] ? kmem_cache_create_usercopy (mm/slab_common.c:351) 
[ 59.627229][ C0] dma_fence_chain (drivers/dma-buf/st-dma-fence-chain.c:708) 
[ 59.627229][ C0] st_init (drivers/dma-buf/selftest.c:141 drivers/dma-buf/selftest.c:155) 
[ 59.627229][ C0] ? udmabuf_dev_init (drivers/dma-buf/selftest.c:154) 
[ 59.627229][ C0] do_one_initcall (init/main.c:1232) 
[ 59.627229][ C0] ? trace_event_raw_event_initcall_level (init/main.c:1223) 
[ 59.627229][ C0] ? parameq (kernel/params.c:171) 
[ 59.627229][ C0] ? strcpy (lib/string.c:83 (discriminator 1)) 
[ 59.627229][ C0] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1547) 
[ 59.627229][ C0] ? finish_task_switch (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1390 kernel/sched/core.c:5129 kernel/sched/core.c:5247) 
[ 59.627229][ C0] ? rest_init (init/main.c:1429) 
[ 59.627229][ C0] kernel_init (init/main.c:1439) 
[ 59.627229][ C0] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:104 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202) 
[ 59.627229][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 59.627229][ C0] ? rest_init (init/main.c:1429) 
[ 59.627229][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[   59.627229][    C0]  </TASK>
[   59.627229][    C0] irq event stamp: 842784
[ 59.627229][ C0] hardirqs last enabled at (842783): irqentry_exit (kernel/entry/common.c:436) 
[ 59.627229][ C0] hardirqs last disabled at (842784): sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074) 
[ 59.627229][ C0] softirqs last enabled at (842772): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 59.627229][ C0] softirqs last disabled at (842761): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:622 kernel/softirq.c:644) 
[   59.627229][    C0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231113/202311132217.2a9a4aac-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

