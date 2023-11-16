Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF27EDBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjKPGnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:43:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A3182;
        Wed, 15 Nov 2023 22:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700116999; x=1731652999;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xkjq9RcUkfyvlx1PH+DCXTw02wHNYn9jQE/xzcQc7SY=;
  b=AEVtCJ0KMVoIxPsDiJdyPoYwyeXCjdY2pdZlxR+GepQp1fIlyUawr+Q/
   ZUE2cPdN2Vre1v/FpEK6D45q7WGStT91aIdpA1XciOIRBHBEhBoyZTy6i
   p1dLeNZ2IMfVU6Q4aS5Bq2GGoVLbBBch0SuRRsTS0unTOn04LuJg0v8rM
   gxzbyz8jYsdT4QviRI2SktvrB53ICSm1nKnbeWUztZcCFvMrxcV0DDJLx
   K/vu0JpBou1Nsl0AuJohwth6jTL56QLJNxM+5ngFFn0VNBHm+scDyaQQ7
   qoBDGD7H3jhP4oQNkfOKaFOIGLNBeyoQjhL5ZKelh9eqiXpa+XdmOetCA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393879735"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="393879735"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 22:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="13019409"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 22:43:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 22:43:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 22:43:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 22:43:18 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 22:43:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl/TJ9YbygVMxE7+7x9jBMoH+NDwljbOiACNuPdMYifTw5N6woCiqEuBA2xJ4lbQ35rOD6OI4zJgtFPZFQzVN4Sk6SyxLCNnHIWoStr6ViFq6yUZbpVYRki3d1wt3DrCtlxm8dvtvxiGCgf7p+beHxUXD6DZMYvC90Se5jaIbnWvVrcCr1NLX2M6XWgLCOCgr82CdavnOLJ/YwhhwDxDPMBvk+m3bAE7hsOMGAiYY+DUsU9EDu6F37AqMS2+bVEmPPGbuaaZt68d4lmSs00qfgxl+xaxCIBt8PMfmw8DMMDhsNrxKR9N962Qp3v6RLQKAT7zDieqnow8UlakySbT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoiSzwg+J5aOtXs1CgSU9+SWH0IYjdymsJDeB2jGVhw=;
 b=lDd35fEMSw+wWqjwxaWdoyHR+WuX0mpFigme/8Smup4NKIu5jZgJ0ebxYI0VTGHHpJlKn4f4+20272L2F/EyjfJJeqkzmb5Vf/wJkCEGsn98KdZTl7iBmG/A0aImkK1Fw+7PwTLrSp7yodwoC6XH8U4I2WZLwr1/s1gYcAioHVY+U6FQ3uIHAC+CPYh+ZfL4Abd2S/vCTHQ/k5BTJezig+FPCmM4f3Zfk/M2xu4Dji/boqvw8PIJ8CylDx6HnaeESItqHd69R8GyfG6dC8o8q3Q2ewfEEQIMGlP/dRIZViuobHZHZnvKo/PSROkUE2EwbOeK0nBWdthy98U+DRcAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 06:43:09 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 06:43:09 +0000
Date:   Thu, 16 Nov 2023 14:42:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Pedro Tammela <pctammela@mojatatu.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [selftests/tc]  d227cc0b1e:
 kernel-selftests.tc-testing.tdc.sh.fail
Message-ID: <202311161129.3b45ed53-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::21)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW4PR11MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: ffed89fc-6edf-4879-6ac8-08dbe66f4bfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1o/4rFdXRzdywq24895BHMyibMHKvpxa0VTxS20NBfxR2p30bIhHHb88I9RAamvL77cu/eEGpbrzZHElqYT2qxaYBb3U60c6sItMFBSG+ZXvzv+/cuumpyMtleLXeOUI7eUCBZodpUShoh8c8rLBqZoD6VjaaSLHT3ansNddsVm6fMk+7kYd63NVR7RE47c7vvcpX5TBpxsSejPJ9bLWNYdprJCAnaHlaD2nm3rt2alW+0W3wP41gFXWUPtCM27xgMpqwBoub2jYSNvMSLyaKMz+imZf4/LWbxlANAxtJKVIrp4VSy+NhKuYQaZpDkLq/yGbMZsExz93F8cRex83/8kG5klWfXGLPI18v6y4vEzVY6XSlTh3GHE9Tb4TTRd4vg0LPefxEhKCN9syECs+e4Fk3x4uBTSjgB3eUye2BRSmu/3quDFo7SMct/ikLsWL07QGW1afog3YNYn31nvSJAJMQ7iSJO9XnELkqK3uX8CT3OoygQSTtq40EM55uMdPUr+DbftP9Js6+CPhaC4uBXI/ArQgPRaU0/PiB/inyfxmmncpuAkyv1SK6PmqKfjZtyR5zGWfvRQkytkcgCuhuHyCuyAoOwWb7KsU6j7RVZI7FW4/b3dmlrDPz8Su9Ar6WPXVuFShwJAdi8UVcNoSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(66476007)(54906003)(66556008)(316002)(6916009)(83380400001)(66946007)(38100700002)(82960400001)(8676002)(8936002)(4326008)(4001150100001)(6486002)(966005)(478600001)(36756003)(6506007)(6666004)(86362001)(5660300002)(2616005)(107886003)(1076003)(2906002)(26005)(41300700001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQI0M0Ov5RApKlEdSUpUGMIszLZQwk1ro0xnwqGYIaD2nxgvkor3I3I/OFUL?=
 =?us-ascii?Q?WGwZj70zXKvev6a0Xrish4Su7h/s20tkY75ewPCjiriMyLEg6+C4jjekPLsa?=
 =?us-ascii?Q?ajfhlb0vJ0d+/NCrvNf77tTI6yQoxZ3RZQoNQh8qNAKWmf2w3vgtCxhWtZZ9?=
 =?us-ascii?Q?aJNgo+XcD/n7aB0peOnFwe83WGh+G3KNTRnelQhZZZgCNBKZfrBtW60vGRX6?=
 =?us-ascii?Q?MVhhEM605/ytMggSJfWnw9sx4On38ATfQE6DsYt9Feqgdf/TK0//BbT4NFf5?=
 =?us-ascii?Q?CV0H8yHz9UcvuVNZuw12qWmxUfmHFHwa2xzZZO7E5Fdg4Xbi57aSUY2r2B1B?=
 =?us-ascii?Q?678F6klcNopbHRQTCI3EC3tNdr47ca7LqLFbzuCvdTHbdeFn2E2OJQ/rTaKY?=
 =?us-ascii?Q?fHv24t0bAj/OONyivkgH2GPj2oZrhAP2z5gUM+fFQKLzzfPZApIvRDWSzwyQ?=
 =?us-ascii?Q?uxD1OUp5s8exChi9AWETYaevrNryO9D6uEz3i1+fsuCrMAw1/flPKvha8GX/?=
 =?us-ascii?Q?1SvphFDcio3t+pT7V2o6FihbXoITEMIT15hXPGCR1Uwey5HqV1bRW6W4tYvM?=
 =?us-ascii?Q?hIKoBen35TwWaTmJ8D0BpbnOT1X0tXKp8pO7mw0p5lCrovJYtfLe8uieWp2W?=
 =?us-ascii?Q?oftabpSXvcavEuwLCmFW5lMmsnVqeHSSICtmnxJURcxX9TkYVOi0y2gpCRc1?=
 =?us-ascii?Q?2BEySUbhJoBY/6CwZYP9y21saH1jDumTyepiy0XWwTjZyZ2krDb34kvlwVWL?=
 =?us-ascii?Q?5zmqUoGcjHE1YqT5pBkYUxlnA43g6BxS9OaDm44VVlXsnbINWpOy657WqmrV?=
 =?us-ascii?Q?ufREXCOUY+gHz6XQB+eFKAclkkK6WDyNuHcTXQhor8Yvdu9JAUjTY+j9ylsu?=
 =?us-ascii?Q?ir0eKwNTNZypO6yA4eu2xmKiGbSpy5Ju68wBEAVLCbymH4zZOYUnUrHfRqMx?=
 =?us-ascii?Q?3kt479aFDcrSjX7VVkLo+k+o5G1D0mrLldRSgx9UJ6oQuXFeUiH4NTN63T9E?=
 =?us-ascii?Q?XlvV4Bfltrd3uVqcdCSVf1SPTxV1F6f2lGOcXj+G+97kDN8Cp07aH1wUqUbx?=
 =?us-ascii?Q?tj3VMZFXICOgP8lTY7NwGV1nalJyevo6s3t5RSek7gSBUY1UCJdxJE/j4NJO?=
 =?us-ascii?Q?bsUWDuEqUGJfwlU2MI2dF18bGUrklwR1usBKKdfhzE3zvviOeABw5UNxMeOO?=
 =?us-ascii?Q?TyBgECt4e//Ogitq6tz7Zcoq50wJNT3qQyIRAmaHbQgpgKthXfSi0NwQntil?=
 =?us-ascii?Q?b7Gx+o2VJX4umZe0Bra3a4LiHsZ4+EsiLGF3dwbJRWo3C7P+44/fomuHwq6a?=
 =?us-ascii?Q?XXHjfVB/AJSWwxID0OgNypiCOznV1RVeX4bt5efU01zOADZ/78AocVxbt3ix?=
 =?us-ascii?Q?XwDVg4m36BIdbtr1CGXUm8LlJXWQkI8HSKAVBI1YTmfRgmLoIEyV/xpb5HKC?=
 =?us-ascii?Q?cj8jFAuslYJ8zsSnjOcuxGAhaMDu20z+mno9g3G8t/e4TjO1YdTQgFEHQ+cx?=
 =?us-ascii?Q?Meh+247pVmJPXxuCXoWBIHARgIWB+LnM6h+2Hz/DlFV1A0USVZiAlaHQhG6f?=
 =?us-ascii?Q?uU6GQg5e7vHPMGkjJx0s4YlSEuMyHRsce1mIw2Ptgu2hiqm7fAxrCi4GuBiG?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed89fc-6edf-4879-6ac8-08dbe66f4bfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 06:43:09.7401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzOgqbMoxC3398wG3EGr/5/sIIKgn1NilsHrk4migXW2uRx0jFxHguDW0jVLYDLkVEL8GVdTJFw1RHYW+dMvhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Pedro Tammela,

we reported
"[linux-next:master] [selftests/tc]  d227cc0b1e: kernel-selftests.tc-testing.tdc.sh.fail"
in
https://lore.kernel.org/all/202310251624.5ce67bed-oliver.sang@intel.com/
when this commit is in linux-next/master

now we noticed this commit is in mainline, and we observed same issue.

we noticed test can pass upon parent commit, looks like:

# timeout set to 900
# selftests: tc-testing: tdc.sh
# considering category actions
#  -- scapy/SubPlugin.__init__
#  -- buildebpf/SubPlugin.__init__
#  -- ns/SubPlugin.__init__
# Setting up namespaces and devices...
# Test d959: Add cBPF action with valid bytecode
# Test f84a: Add cBPF action with invalid bytecode
...
#
ok 1 selftests: tc-testing: tdc.sh

but after this commit, seems test cannot start as below details.
want to consult if there is any prerequisite to run
    kernel-selftests.tc-testing.tdc.sh
after this commit?


Hello,

kernel test robot noticed "kernel-selftests.tc-testing.tdc.sh.fail" on:

commit: d227cc0b1ee12560f7489239fc69ba6a10b14607 ("selftests/tc-testing: update test definitions for local resources")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 8728c14129df7a6e29188a2e737b4774fb200953]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: tc-testing



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311161129.3b45ed53-oliver.sang@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607
2023-11-15 20:15:35 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-11-15 20:15:35 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-11-15 20:15:35 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_ATM= of tc-testing/config
LKP WARN miss config CONFIG_PTP_1588_CLOCK_MOCK= of tc-testing/config
2023-11-15 20:15:39 make -j36 -C tc-testing
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
clang -I. -I/include/uapi -idirafter /opt/cross/clang-4a5ac14ee9/lib/clang/17/include -idirafter /usr/local/include -idirafter /usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include -Wno-compare-distinct-pointer-types \
	 -O2 --target=bpf -emit-llvm -c action.c -o - |      \
llc -march=bpf -mcpu=probe  -filetype=obj -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing/action.o
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
2023-11-15 20:15:44 make quicktest=1 run_tests -C tc-testing
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
TAP version 13
1..1
# timeout set to 900
# selftests: tc-testing: tdc.sh
#
not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 900 seconds
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231116/202311161129.3b45ed53-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

