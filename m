Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB47F5943
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjKWHd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKWHdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:33:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4010C;
        Wed, 22 Nov 2023 23:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700724808; x=1732260808;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KFnT+3ZOcxIo0opmuG6dG12wC5L8YFGBuIeAXAf23bY=;
  b=ImdjScD8yBwdbYyo49Ot8N1/fz0kBEeupn5W89Iijh6FJDxn7ziAueHk
   yiomkzQxGUZaOio4iPWFmjIjfYiUIji53V+5hZ1rNBdxoQx+7BfUFPKvy
   6XT1ZbOZ94SOBYCHeXJXV5igQRyC3tLKo8w7hCgPbvSfe58haS510u5AJ
   m+JZtHWX+OZqYW98VUQHnv5e618hd0Tp0kVXeEgcAMJTUjjIcqjDSbmmO
   cV68QC4CyVe/QAUiicPNB+gA8c16TMblpYpG1htd+ooYlcJ52ukyFIu48
   qAiNE6AiJHjvHp0LyNraLXmXMKdG6kw2BXBHc4YBmxOCOf6mlK/WDQgen
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458711809"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="458711809"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8566101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 23:33:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 23:33:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 23:33:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 23:33:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZFe0GQJ0q7WCJHI7u9JWUv/1YwBoXw1O8pahWrYEm2eehreTr90pL8b39QSd195d+LTyCL9vhUmzipi9pmLP54x694bo7EgB2QB1rYDMPZGdVr5O7WP7B6EHdTqtBr8yFNy3x6FKIgpSlV5pyOKyWJd3aQi6uBqttEP/M4VxQYfGpkAmQ17xyfq0GuigGWwp1j2ZBnj6ffhADAhqPp6dbtw6UGTwtlILQFMAtKnTWDP9gOstdkRaJAyQjbl57+JcmKPn3YdQR+jL0ZPwavX22WbkEXfrZDoSRqEiIOJiekDV3JAh9ve7N9jVCRiPoaXLqYFjRFA80LgUi5i8phBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqIekfbYCgDnjx3lYAQIEmWMhHsGCkTsm6zm99SvEgc=;
 b=XqFjZlOt8bp7PBB5YGXAA+fUW+jLi1fM7H/7adc0wyE5rbfZFvQsYdJxmq4gx1mehFO27JrL/H7d4EZXO0QuOlpRj/TDku553+mNDyGtQjwDq26c2ifW9tuOWr94zyr6nNdx4sic9gs3wtDOUNYDmB3xLHy55rg30NmaKIhSaPy+8zGZLqwtiIA5dgAsE8jB7KGSbVMd4flV+/xJtnoTUWFAlxJ2w2MS5DJoiZf5ANO5oYkYER/HQhYH8q7G+mO6n7ozTktYun564dGlYlGykv2BjcGeZ5dbCs16oA3NPyUsUG2BwwnXru4CsGkogkoJJVRCvUt68vH2N7+4Rvrvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 07:33:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Thu, 23 Nov 2023
 07:33:20 +0000
Date:   Thu, 23 Nov 2023 15:33:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [wifi]  97c19e42b2:
 hwsim.dpp_qr_code_chan_list_unicast2.fail
Message-ID: <202311231403.9eb0b714-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: c014b390-b44a-46b8-bffd-08dbebf676d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vw+swSR6yQkeFc0Wo003bYUN6ZqtlOo0aWa+GKWEHK7aF1JdIC04cTH1UaXKnT8t28RyFHaIbeV/ReT8C/2XoNg7Hwi0crOJ8E1cuuKZrs6CsqYo9QnxdPk4mQunArvylU+ut95igs4+1rWDD/tH/2K7OU/TYNeW7ChSWAkNkSJ2vesggmYdB4G+LXHC6COki+xguZJnfWOWMwU2PcDe1fPKkBCYzrJTeJ+s8vspzZ46QOPAunA8bC5h8sLNUN0Gq106GOvsZFJwpFi62/eVm11QFlZ5lX4V9qnVuuuHol7DNUjF3RRv/iwRkyg6OUgsmiLiKOrf4jUZedGxx98Ff7SkE+fiH3ySSFhz9IvaPVLrZvShvTVeBEBYpllg4u+OJ0ZCBctwt1Qm02kqMiaAtJrNdqOxwlWsPr8Dd03MYq0AObcm4QVykOXi6KAYZ5piaaOvbu0UFrcxvBrzi4meP4pRiDW74sV6tcgpmLusQWXD/jjGXhS/xL7cy33dNaz++2MkKzY515YPkRHvlte2PkBw8zLq8QnfnDf9X8nqBZVI8X5JzJHIu4n02Eh7tzD0AIPLl0LcZGTWBnhc+oXrDa6Om32w1ZE4/rbON2pScBXRkxqejNgrw8VickHgpxBD1fMZOhMye5OzIIAOkArjkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(5660300002)(38100700002)(26005)(1076003)(83380400001)(82960400001)(6666004)(107886003)(316002)(6506007)(6512007)(2616005)(6862004)(6636002)(4326008)(66556008)(66946007)(66476007)(37006003)(8676002)(8936002)(41300700001)(4001150100001)(966005)(6486002)(478600001)(36756003)(2906002)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oMtJuEs+TSDsrN1WVjU7iCY4aTlUPMyfLBnOKv6BHndJYRV7xsJ1PhOl8EQp?=
 =?us-ascii?Q?92QNSMhIXForVcYSw3zfZ3aBucJYktu9MyjZ2ESdZD4u2lSAim85hHI5EZc6?=
 =?us-ascii?Q?7vLbYbCULzUaFt13L9A6Hfp2Z6GsB2nXxNRf3Tll51lpPvyf3NWXcabgH+fQ?=
 =?us-ascii?Q?L0m8kpvtUsNKf4Una/DMysa91DzU/p0o+wrRF6UaeGokh9qEdVkofbZvUUUa?=
 =?us-ascii?Q?+qCkqMA7+gtkWLtY66phi+U88c7UC8HIgA0AYhcTPqIY4JT+Z2sugmma78lF?=
 =?us-ascii?Q?u3GwI7jn7Lm3amf7SsZmMc1h6hQUplm876bg9TEmawdb66QnQsMWtLMjmYms?=
 =?us-ascii?Q?S+vtP/AgY2QsQOpOVMzTfVkJbUhqtGz3h6frDLdioCKTB4CjahRUI6PZkaIk?=
 =?us-ascii?Q?2nCzZrmIqxTlO4fUh2ZkuIPRZSxYerOh462iiZm7UNuAI1HlDWIIjeAjILlM?=
 =?us-ascii?Q?g+eOmBh+CWig5i+AaQ3W9SB6rOecZgiGb3FossTBa2j9w5MZbecGn9R+b26Q?=
 =?us-ascii?Q?ISTviiHfW01alqdrVivYtOVI/yliqRqfBkulwYBaM5IxY3Do4SH8+rZhDdvD?=
 =?us-ascii?Q?3AIusOMDMkzWnCTBiWEATHYPXj4+hUpTzCON50KaKuYhJ2dj5fETOsluUf6i?=
 =?us-ascii?Q?BHViUVw4vn27h/RcX3LjPUU0+cNR4cgxkDl3XhzRCS3B3wsuR8qSjCj3S9ld?=
 =?us-ascii?Q?7j+42C0T8x8jiATBc288qkJM8LaQOgEG5Mz4XVKwNexIReJz9Q7vfZdUHWIv?=
 =?us-ascii?Q?uM0Oc8JTx+8qeEr+OcHw+O9ahvwm/qf6b6jelpmOJEWIbkaQVQ11uS8vpd6Z?=
 =?us-ascii?Q?mU7bsgkvJmH9+yE7k44P4QXtbCOStUFIyrk71tdWTRSxHYLkMR/FA9NMs4+Q?=
 =?us-ascii?Q?KRUpEUhCpEvDpvpjx+leCjPLToEi8Rs6+/GzlH6NEkElTFAI05SCFCkYSdJE?=
 =?us-ascii?Q?vAN3lWjqh9izj8i2i1aD2NOZpGa7pt2jG74RupaOG0Hi9/m5i1kxEuIZU5QW?=
 =?us-ascii?Q?TzFNtTKacIOcw7bIH/7dJB6QInxlVgxEdlrs2zXmWFLw8JUpyVDqTvUjDKvs?=
 =?us-ascii?Q?afVH5jPml2Lac+tEWOXsf9KeqFIAd1ZRgIEtpXUKCc/FTZjtupIYShPUMBnA?=
 =?us-ascii?Q?uwMWvHtbfVza4xl06ub9Whzx/WRrPjSRu1RP5Zot6/j5CBcbgOpt0vMOE1im?=
 =?us-ascii?Q?Du4CylTSOrOtaBSjEOeR1Eo1o+Q/Bvf5MkkVjee4cHS9fjDP+HSaxNPuq1G1?=
 =?us-ascii?Q?DZYvyrAUTD2cdoz08asz02I2TY0gJjFrhyDxjepkUusDX0FmPGdlClonEW1c?=
 =?us-ascii?Q?LA3FBdrXhEYvkCwhnNVZWf5VWB1YCmqu4zg2afGdrg7VGeB1ZQgdny4yQoza?=
 =?us-ascii?Q?1gWkRUwk1FEry57eg1msklyxZukdiBHWvAzrc56sRLRfHnUVBQqIIOeLCSbv?=
 =?us-ascii?Q?F7Zye3CwpzFm6ujVsYmE76V5ExZGTsDsUgCnnA5GhNPAYXzTNRc97ixo8miS?=
 =?us-ascii?Q?zbq+dsItZYhvQrs9J2+HZOXyyLyMOJ+s8zN3+fiBf59Zlcp+EEKloJ6Zk+7S?=
 =?us-ascii?Q?r38dBz3pEvoTuVTMN9kSNr+1cpqKX2tOGEjo6s86Pi5vJWxUoTjNoBvSt5TP?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c014b390-b44a-46b8-bffd-08dbebf676d4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 07:33:19.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa81Q9qH17GW+TS90oZMb9BM+o89UC21kcr6CmRxAesg2qoxkej+/V/1Gwzhv1vfsGIZBYNwkXnICjIh563R7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Johannes Berg,

we reported
"[linux-next:master] [wifi]  97c19e42b2: hwsim.dpp_test_vector_p_256_b.fail"
in
https://lore.kernel.org/all/202309251502.aa08a357-oliver.sang@intel.com/

now we noticed the commit is already in maineline, and we found more issues.

for this one, still not always happen, we observed 19 times failure out of
30 runs, while parent keeps clean.

730538edc8e0eb14 97c19e42b264e6b71a9ff9deea0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          63%          19:30    hwsim.dpp_qr_code_chan_list_unicast2.fail

below detail report FYI.


Hello,

kernel test robot noticed "hwsim.dpp_qr_code_chan_list_unicast2.fail" on:

commit: 97c19e42b264e6b71a9ff9deea04c19f621805b9 ("wifi: mac80211: move offchannel works to wiphy work")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master eff99d8edbed7918317331ebd1e365d8e955d65e]

in testcase: hwsim
version: hwsim-x86_64-717e5d7-1_20230720
with following parameters:

	test: dpp_qr_code_chan_list_unicast2



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311231403.9eb0b714-oliver.sang@intel.com

group: group-25, test: dpp_qr_code_chan_list_unicast2
2023-11-22 09:35:12 export USER=root
2023-11-22 09:35:12 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2023-11-22 09:36:08 ./start.sh
2023-11-22 09:36:10 ./run-tests.py dpp_qr_code_chan_list_unicast2
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START dpp_qr_code_chan_list_unicast2 1/1
Test: DPP QR Code and 2.4 GHz channels (unicast 2)
dev0 displays QR Code
dev1 scans QR Code and initiates DPP Authentication
DPP authentication did not succeed (Responder)
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 531, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4581, in test_dpp_qr_code_chan_list_unicast2
    run_dpp_qr_code_chan_list(dev, apdev, True, 2417,
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4617, in run_dpp_qr_code_chan_list
    wait_auth_success(dev[0], dev[1], timeout=timeout, configurator=dev[1],
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_dpp.py", line 4878, in wait_auth_success
    raise Exception("DPP authentication did not succeed (Responder)")
Exception: DPP authentication did not succeed (Responder)
FAIL dpp_qr_code_chan_list_unicast2 5.345945 2023-11-22 09:36:17.829496
passed 0 test case(s)
skipped 0 test case(s)
failed tests: dpp_qr_code_chan_list_unicast2
2023-11-22 09:36:17 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231123/202311231403.9eb0b714-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

