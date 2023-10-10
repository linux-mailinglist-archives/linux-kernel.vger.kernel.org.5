Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40247BFD86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjJJNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjJJNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:32:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD6A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696944724; x=1728480724;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pMxeNgO5QD2ThIPpaexK0BakbfU82f6Pj/nySPVKkpo=;
  b=Hh3tzfUsTBWjMhKLg9y4iQcLR5WCMxbREkbsTJ+9nOG1dSOhyzc7Ekcx
   IiHuCLZyOhbnawl+dGDoDBRbNzre0P2d+sB8o2I7R1pWE172XAZLWIji8
   Cz3D2sYTe8ywzkmLdrKpWbnKye1l4Eedk6OtvDnHB8+mME7j7r/wa3zVD
   mPwT7kahmfRUIpWYfX7xJWt2ehUhS35EsLFxowGhjfWqFcegXUdb7AxZI
   z0JDYNvw21WFkFhh23TriJ+3gILvx8zM1kxuPc1o602jfTmNg4GljUM/I
   3GMLM41aVCB6oeEUyVmYLpyqJryYDs61fQrHOzuhaDQ6y/Mo9OURlVehD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="470660738"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="470660738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897194910"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="897194910"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 06:30:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 06:32:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 06:32:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 06:32:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7iJHBJF8wwU4u9H2KVc4fhEn0IRrMEDnU+PYNFhAio3HHxoUbv+JA9aMxb0LgUo8FW5FrZGMAVEEU7NWSo2gZp0g4ermaJ9b3w/Tma0KLzj0Ayfgf2Y5Mtz7OSndxqdmdEgcexwRsO58hzY1l1wnCUCV9IV6DHotTXTPsP2TykmC4TsoplYcRPGjQhPjF553fWEW5XOJihs0KI3z8Q0YLGjHxG/soROm5TlIkXzUf243VYwC8DUhKoMol8pZalhIf9yKHp7CW+QNbLz0MwQjqX4nVCtqX1TJ1qsUSrx5MDJxuzv/ajsG8PiCqq/Bwl0maPSYlxruttlp8NtWZBJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwFG/twXmGUds47sVudkIlb7xWhaHmUEs/VhJnATBT8=;
 b=KeE/ys2fvDW1+qqcqVL55+ws6eo5SLABYCYLqf5KpN6OYGN63eb96rc+ccrtrp1corPulhUO6FEjkURVEYhwH6g/LgIWLz8RNzL/zxy6Jc0oqCy4jqtm70T7LNCY4QK8SDVFpv3dUspxaKzR85FInDaSCu1PIzg9NuMN7SNsWlH2om5AdHFs9vv7J3nCbPzVjoqlOensc15jc8eooUWhXqXwOiLDr3A+7tD5wqvNdHW0291UQae8+zuzquWxuUnBgRuTxtnkg0YURW7uMOtXQzek8kkMaHvA9Fn1JtHH6HfUX+63QPcnIWEn59WDVhte0Lsg+7/DUIpCOiUFLkErpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 13:31:58 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Tue, 10 Oct 2023
 13:31:58 +0000
Date:   Tue, 10 Oct 2023 21:31:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     David Howells <dhowells@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Christian Brauner <christianvanbrauner@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [brauner-vfs:vfs.iov_iter] [iov_iter]  376fdc4552: last_state.OOM
Message-ID: <202310101622.31e71d6d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:820:d::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: a955538b-3f5b-4b20-9ff6-08dbc9954722
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l3NC+/eD1jRbZRRIouc9QiIZTcOM1xm+cIrvnObqOEHSC5kbuBkaQ9MyzuEIGWnHwMYNRdsQYEO0ygPLCjXosNaEbQEaENLXASVAX5mM9lhCwKSLWFIzHXiD4dz+aaGpNk10PWd9rbibwqbDIXHTBpMOJl9CbXQ3ilnkAiL5G/wge9gWgYLDAo6NT/hxyPS9aHGgHmIA0wLSYr9i2NTdjb3Co0CJuFzzOQFVnwLX+tmijgCXiQquKMgeWSsJ42stb/syS5VTiHSqaavY+vEfcm7AlBUZdt7AKu2Q09xYRFzR738ZsKLId6qDk19RdBSuW4eE0FN/4Xguronjo6VlkzQiNyXL1ONSWOjRr9NfNp3ZlLuc+12uhHR108bZ+B5dV/FPNFtxGEqIhB/4U6teb1J0bdelVkQVTABUnS4xMjBwb+UHQrkadnCpqveX7t8Dxeca6d6QUDQGCYmK7vHLs84MHMi63WSNVdJ6AiCG0IYb9Sjum4r7RRC4xnse+9dIzVxwybxo4wunabHu5xqzF9Uk9hZ4cHIXDTgY1i0/0/MZBUnJOup8d5gvD4ZiRopAWNOAZQEUIbE6w2AI3HiFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(66899024)(5660300002)(2616005)(6506007)(1076003)(107886003)(6916009)(54906003)(316002)(66476007)(7416002)(26005)(66946007)(66556008)(4326008)(8676002)(6666004)(41300700001)(966005)(2906002)(30864003)(6486002)(478600001)(83380400001)(40140700001)(36756003)(38100700002)(82960400001)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eE0rzY8FyM4r2mG+GT5s6+3t8FpuMN0JlQvxFM7SwoAzm69dqgGxslhQwd3Z?=
 =?us-ascii?Q?Z4S6plIOYcvjAawaty0yotdpg6CwAUcd/tZTgsf8oTN58SZeFjDMxIUHhvpI?=
 =?us-ascii?Q?tQk3sbGcbvfJR/f7EPdiTYNCaOWp2Gb2qRK8MbDUj8bCVBnw5gckHBJyK5iG?=
 =?us-ascii?Q?KiWkn5l4mIv1iF+1KuWZOwDBeSUKbm8iNVVOPQ5/cR5uNBfLEQemFK04BWvF?=
 =?us-ascii?Q?NBmLY57qC6fgQ0Zsvfxrs4G/agpb+6a8uTdf1O1H+o5lC8NyIc+rJhNWCjWq?=
 =?us-ascii?Q?/EbWpSFcQ/dgATQVHxHh2uaY+1JD31AkGvVdDbqa3O8+Zb7JKbxAv/oTfeR6?=
 =?us-ascii?Q?ny1BkJMtPhPZhSFpotmDTKAvSXnWji3q6mbZLquIfnYXhHUyZsQ610kzJ8D8?=
 =?us-ascii?Q?bpkUWej1HLgiUVIJcVno1t2sayjRe0PGkxmZXwV+FnBKfNTZXxRpY+mIXNe4?=
 =?us-ascii?Q?hZZbHUE17GJHe5dL2xv83NL4w+qjyUB+BpbESH/wrc6ekrA5ugh9BQhw6O1T?=
 =?us-ascii?Q?VXcIwKDQY/6lbCJrnpO/Av8r5W36bwnZmr9CNGBNJLngpydEyn00edq3uts1?=
 =?us-ascii?Q?bNXy0n13LF/j2a3EN1z02dgMYmODR91XVJ8YqF8oQKLPw/QPtHVtfdApcM8f?=
 =?us-ascii?Q?uQ260zIHxc4/u7l61v1x70XejZWbEyX1KGQhqs9cC1ZVdx/uKgEV0HghIde1?=
 =?us-ascii?Q?+Rkl9dRjtbNKTGi6iVtwiGu5h/GNI4XVp6+IkQ9Pe6g57bq4dLFWsynL7OhQ?=
 =?us-ascii?Q?meq1AwzWdUMRXMpgS1ucc3m6edJmzTCPK/GNIPbdW28rzjMxH5vnItDJjrmK?=
 =?us-ascii?Q?J1wTREqiWjTcV9DD1rmruJUGtkz7JVyRYv5xgLoK9Aj9R5P6sj7023v+WfNC?=
 =?us-ascii?Q?oWodEYPozP0tVn4GZGJSYxdfFRlPLXCpzOdojQnj87X5R+7AQFS/oP3fevc/?=
 =?us-ascii?Q?MAHV+gfWj3n6H0tjDQAFss9Ws9zV/6b7iH2PIJcFaUFgIyaMRV4/3KvwzltR?=
 =?us-ascii?Q?blVxZfo0ARyH4b937rvniE1SxqrpQfJ1utiTRDoOl5LeIDfNMdUnK4rVaCda?=
 =?us-ascii?Q?c+XULq+S6RFiQ8NeuFKYgfbyKDoh374lh0648r+dBneRghqWjxfCyfw+zXYe?=
 =?us-ascii?Q?jw081R10dFNh8XeOePpPRWdjA7AFhuAVSRugvWprYZDrlxQPkb8QONF4xmXJ?=
 =?us-ascii?Q?mOYqX5r9L1nk6yLg/3IJwH6HbXL2vudtCsB5dymFArO2qQVoCSv2TlKKUnF2?=
 =?us-ascii?Q?Hz37rjG3nutQddYjXaMjB4pkE1ltWnawmPI87MtXAZ/6QOUCxO5YURpD4+64?=
 =?us-ascii?Q?2wv+KTAT1fVDSZlyxMFBW+xNV0n2Vwg4j4HJx8gKM1T5xv+Vxxry21C8W252?=
 =?us-ascii?Q?l5TpKQnrZR8g7LpWRbTd6MndAf9FYhhIEm6mIoYIkUwzCuxnXHXdbhRmCGT6?=
 =?us-ascii?Q?iSclW9V0cqvYWTAOmhvKiysLuFvFv1XMXvyc3b3qLbS5VN4hLtkbM6n789/h?=
 =?us-ascii?Q?Xx/PQ80T490ihDGnmL9VPl2mi5GcuZQ9nqltpayv0AnZ8LQlr/8FMAjhVKwf?=
 =?us-ascii?Q?CQh5r0HfVDKt6S7teI4W328POOaEBFl4ffM11UEfuGrEw5rqZb8rdY7AT++T?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a955538b-3f5b-4b20-9ff6-08dbc9954722
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:31:58.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teZU/v4NklLjAgyhh1j3Jesreklg8xS2/zddXGrMisPqQwwnV1uGEXqU6y1zmm6HIY/puILNIEn61M6Skn4DzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "last_state.OOM" on:

commit: 376fdc4552f1ec23677fd7321ff5f7a208bd9eb9 ("iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()")
https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.iov_iter

[test failed on linux-next/master 33b64befb1a28bca3f5a9ed9807d2f87e976c63a]

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-04
	nr_groups: 5

test-description: Trinity is a linux system call fuzz tester.
test-url: http://codemonkey.org.uk/projects/trinity/


compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310101622.31e71d6d-oliver.sang@intel.com



[  218.519632][ T7791] trinity-c4 invoked oom-killer: gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=500
[  218.521337][ T7791] CPU: 0 PID: 7791 Comm: trinity-c4 Tainted: G        W        N 6.6.0-rc2-00008-g376fdc4552f1 #1 75cb4084668096873a4da81c5b2fd1231af43beb
[  218.523040][ T7791] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  218.524361][ T7791] Call Trace:
[  218.524861][ T7791]  dump_stack_lvl+0x72/0x90
[  218.525505][ T7791]  dump_stack+0xd/0x10
[  218.526097][ T7791]  dump_header+0x42/0x460
[  218.526729][ T7791]  ? ___ratelimit+0x6b/0x110
[  218.527418][ T7791]  oom_kill_process+0x69/0xf0
[  218.528091][ T7791]  out_of_memory+0xb8/0x2c0
[  218.528736][ T7791]  __alloc_pages_slowpath+0x829/0xa20
[  218.529607][ T7791]  __alloc_pages+0x2b5/0x300
[  218.530249][ T7791]  __folio_alloc+0x15/0x20
[  218.530882][ T7791]  shmem_get_folio_gfp+0x351/0x640
[  218.531750][ T7791]  ? irqentry_exit+0x39/0xa0
[  218.532419][ T7791]  shmem_write_begin+0x4b/0xd0
[  218.533075][ T7791]  ? fault_in_readable+0x70/0xc0
[  218.533772][ T7791]  generic_perform_write+0xb5/0x200
[  218.534492][ T7791]  shmem_file_write_iter+0x78/0x80
[  218.535199][ T7791]  do_iter_readv_writev+0xee/0x130
[  218.535892][ T7791]  do_iter_write+0x75/0x150
[  218.536524][ T7791]  vfs_writev+0x82/0x250
[  218.537139][ T7791]  ? exit_to_user_mode_prepare+0xa2/0x1c0
[  218.537918][ T7791]  ? syscall_exit_to_user_mode+0x41/0x60
[  218.538687][ T7791]  ? do_int80_syscall_32+0x5d/0x80
[  218.540140][ T7791]  do_writev+0x67/0xf0
[  218.540721][ T7791]  __ia32_sys_writev+0x17/0x20
[  218.541376][ T7791]  do_int80_syscall_32+0x53/0x80
[  218.542042][ T7791]  ? __ia32_sys_alarm+0x58/0xa0
[  218.542691][ T7791]  ? __ia32_sys_alarm+0x58/0xa0
[  218.543354][ T7791]  ? exit_to_user_mode_prepare+0xa2/0x1c0
[  218.544085][ T7791]  ? syscall_exit_to_user_mode+0x41/0x60
[  218.544822][ T7791]  ? do_int80_syscall_32+0x5d/0x80
[  218.545517][ T7791]  ? do_int80_syscall_32+0x5d/0x80
[  218.546220][ T7791]  ? sysvec_call_function_single+0x26/0x30
[  218.546996][ T7791]  entry_INT80_32+0x108/0x108
[  218.547664][ T7791] EIP: 0xb7f18092
[  218.548207][ T7791] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
[  218.550566][ T7791] EAX: ffffffda EBX: 00000117 ECX: 011227b0 EDX: 00000001
[  218.551538][ T7791] ESI: 0000f000 EDI: 2493800c EBP: 000000e8 ESP: bfa72c68
[  218.552406][ T7791] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[  218.553502][ T7791] Mem-Info:
[  218.554011][ T7791] active_anon:773 inactive_anon:619045 isolated_anon:0
[  218.554011][ T7791]  active_file:10 inactive_file:382 isolated_file:64
[  218.554011][ T7791]  unevictable:87071 dirty:0 writeback:0
[  218.554011][ T7791]  slab_reclaimable:8235 slab_unreclaimable:12508
[  218.554011][ T7791]  mapped:11138 shmem:584383 pagetables:326
[  218.554011][ T7791]  sec_pagetables:0 bounce:0
[  218.554011][ T7791]  kernel_misc_reclaimable:0
[  218.554011][ T7791]  free:22215 free_pcp:122 free_cma:0
[  218.559177][ T7791] Node 0 active_anon:3092kB inactive_anon:2476180kB active_file:40kB inactive_file:1728kB unevictable:348284kB isolated(anon):0kB isolated(file):0kB mapped:44552kB dirty:0kB writeback:0kB shmem:2337532kB writeback_tmp:0kB kernel_stack:1088kB pagetables:1304kB sec_pagetables:0kB all_unreclaimable? yes
[  218.562603][ T7791] DMA free:11428kB boost:0kB min:80kB low:100kB high:120kB reserved_highatomic:0KB active_anon:0kB inactive_anon:3924kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[  218.565709][ T7791] lowmem_reserve[]: 0 515 2843 2843
[  218.566468][ T7791] Normal free:77240kB boost:0kB min:2864kB low:3580kB high:4296kB reserved_highatomic:0KB active_anon:0kB inactive_anon:444420kB active_file:40kB inactive_file:1668kB unevictable:8708kB writepending:0kB present:745464kB managed:622688kB mlocked:0kB bounce:0kB free_pcp:240kB local_pcp:240kB free_cma:0kB
[  218.569877][ T7791] lowmem_reserve[]: 0 0 18623 18623
[  218.570654][ T7791] HighMem free:192kB boost:0kB min:512kB low:3744kB high:6976kB reserved_highatomic:0KB active_anon:3092kB inactive_anon:2027732kB active_file:0kB inactive_file:0kB unevictable:339576kB writepending:0kB present:2383752kB managed:2383752kB mlocked:3216kB bounce:0kB free_pcp:248kB local_pcp:248kB free_cma:0kB
[  218.574073][ T7791] lowmem_reserve[]: 0 0 0 0
[  218.574727][ T7791] DMA: 1*4kB (M) 0*8kB 0*16kB 1*32kB (M) 0*64kB 1*128kB (M) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (U) 2*4096kB (M) = 11428kB
[  218.576418][ T7791] Normal: 662*4kB (UME) 434*8kB (UME) 497*16kB (UME) 290*32kB (UME) 116*64kB (UE) 45*128kB (UME) 23*256kB (UME) 14*512kB (UME) 3*1024kB (ME) 2*2048kB (E) 5*4096kB (M) = 77240kB
[  218.578665][ T7791] HighMem: 2*4kB (U) 3*8kB (UM) 2*16kB (UM) 2*32kB (U) 1*64kB (M) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
[  218.580281][ T7791] 671109 total pagecache pages
[  218.580943][ T7791] 786302 pages RAM
[  218.581477][ T7791] 595938 pages HighMem/MovableOnly
[  218.582192][ T7791] 30852 pages reserved
[  218.582769][ T7791] 0 pages cma reserved
[  218.583337][ T7791] Tasks state (memory values in pages):
[  218.584065][ T7791] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  218.585258][ T7791] [   4192]     0  4192     9791     1711    45056        0          -250 systemd-journal
[  218.586711][ T7791] [   4205]     0  4205     4826     1184    20480        0         -1000 systemd-udevd
[  218.587982][ T7791] [   4241]   103  4241     1957      928    16384        0             0 rpcbind
[  218.589205][ T7791] [   4244]     0  4244     1433      672    16384        0             0 cron
[  218.590439][ T7791] [   4245]   105  4245     1960     1024    16384        0          -900 dbus-daemon
[  218.591671][ T7791] [   4255]     0  4255     6714     1210    28672        0             0 rsyslogd
[  218.592856][ T7791] [   4257]     0  4257     3379     1536    24576        0             0 systemd-logind
[  218.594137][ T7791] [   4294]     0  4294      635      384    12288        0             0 rc.local
[  218.595340][ T7791] [   4299]     0  4299      636      384    12288        0             0 lkp-bootstrap
[  218.596555][ T7791] [   4302]     0  4302      635      160    12288        0             0 lkp-bootstrap
[  218.597798][ T7791] [   4304]     0  4304      666      416    12288        0         -1000 lkp-setup-rootf
[  218.599125][ T7791] [   4307]     0  4307     1084      416    16384        0             0 sleep
[  218.655851][ T7791] [   4315]     0  4315     3326     1760    20480        0         -1000 sshd
[  218.657036][ T7791] [   4316]     0  4316     1096      416    16384        0         -1000 tail
[  218.658257][ T7791] [   4317]     0  4317    18758    17312    81920        0         -1000 sed
[  218.659421][ T7791] [   4318]     0  4318     1096      416    16384        0         -1000 tail
[  218.660609][ T7791] [   4319]     0  4319    17272    15904    77824        0         -1000 sed
[  218.661767][ T7791] [   4385]     0  4385      681      448    12288        0         -1000 run-lkp
[  218.668218][ T7791] [   4390]     0  4390     1096      448    16384        0         -1000 tail
[  218.669418][ T7791] [   4391]     0  4391     1096      416    16384        0         -1000 tail
[  218.670649][ T7791] [   4392]     0  4392     1096      448    16384        0         -1000 tail
[  218.671830][ T7791] [   4413]     0  4413      637      416    12288        0          1000 trinity-group-0
[  218.673112][ T7791] [   4426]     0  4426     1142      480    16384        0             0 dmesg
[  218.678519][ T7791] [   4428]     0  4428     1952      736    16384        0             0 vmstat
[  218.679644][ T7791] [   4433]     0  4433      642      384    12288        0             0 meminfo
[  218.680824][ T7791] [   4442]     0  4442      642      352    12288        0         -1000 oom-killer
[  218.684283][ T7791] [   4445]     0  4445      637      352    12288        0             0 watchdog
[  218.688855][ T7791] [   4455]     0  4455      222      128     8192        0             0 wait
[  218.690069][ T7791] [   4464]     0  4464     1120      416    16384        0             0 cat
[  218.691224][ T7791] [   4469]     0  4469      675      352    12288        0             0 gzip-meminfo
[  218.692462][ T7791] [   4471]     0  4471      222       32     8192        0             0 wakeup
[  218.693640][ T7791] [   4474]     0  4474      222       32     8192        0             0 wakeup
[  218.699181][ T7791] [   4481]     0  4481     1120      384    16384        0             0 cat
[  218.700343][ T7791] [   4498]     0  4498      609      288    12288        0             0 time
[  218.701484][ T7791] [   4502]     0  4502     1087      416    16384        0             0 tee
[  218.702718][ T7791] [   4505]     0  4505      637      384    12288        0             0 trinity
[  218.703887][ T7791] [   7569]     0  7569      637      225    12288        0             0 trinity
[  218.705052][ T7791] [   7570]     0  7570     1085      416    16384        0             0 sleep
[  218.706238][ T7791] [   7572] 65534  7572     9171     6560    57344        0             0 trinity-main
[  218.707449][ T7791] [   7787] 65534  7787     9168     5188    61440        0           500 trinity-c0
[  218.708652][ T7791] [   7789] 65534  7789     8856     5857    61440        0           500 trinity-c2
[  218.709839][ T7791] [   7790] 65534  7790     9087     5319    61440        0           500 trinity-c3
[  218.719541][ T7791] [   7791] 65534  7791     9612     5383    61440        0           500 trinity-c4
[  218.720763][ T7791] [   7792] 65534  7792     8208     5503    61440        0           500 trinity-c5
[  218.722024][ T7791] [   7794] 65534  7794     9780     5863    65536        0           500 trinity-c7
[  218.725926][ T7791] [   7809] 65534  7809     9390     6341    61440        0           500 trinity-c1
[  218.727209][ T7791] [   7855] 65534  7855     9605     6760    65536        0           500 trinity-c6
[  218.728330][ T7791] [   7921]     0  7921      222      128     8192        0         -1000 wait
[  218.729374][ T7791] [   7957]     0  7957      222      128     8192        0             0 wait
[  218.730495][ T7791] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),task=trinity-group-0,pid=4413,uid=0
[  218.732135][ T7791] Out of memory: Killed process 4413 (trinity-group-0) total-vm:2548kB, anon-rss:128kB, file-rss:1536kB, shmem-rss:0kB, UID:0 pgtables:12kB oom_score_adj:1000
[  218.753318][ T4319] Killed
[  218.753343][ T4319] 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231010/202310101622.31e71d6d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

