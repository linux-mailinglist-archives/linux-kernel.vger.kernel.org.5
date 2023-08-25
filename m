Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25F787DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjHYCrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbjHYCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:47:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98741AD;
        Thu, 24 Aug 2023 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692931650; x=1724467650;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7/eU6LCogg4B6LrASrIYfMxPAbimWZ7SSwMlk/FETRs=;
  b=cevs5+FMcUXG0KSyLdp8s66fYVfNDkcAAG7MSSnJRF/o0iGyRMQgFkF/
   v3/yjQbUTrpFGsNuEua8IVygkubKWf3lqK3XYwr3+Z4bncNI2VqhB+B8s
   mTCQeqfOuPdXgEm/P14DlWJVpm/eWFQQPXIyqCEUpDigtH/SGfL1bun1x
   rRmq0r85PkKd9JrsTSRwRm6ATk1LRuk1bHmFn5Pw7OmZoLLnXnLXsNyLS
   YSzV/TTMTuZ77ww8UJUPvNgJTPmElnIzSQi8HQ2+3Ux91aZf6xUPdXW1q
   Uco+si99oUu7IkvF4PYaLPj6W9L2wS4GuhQ09wrBO/9G9kLbr5DzzSGXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="460977743"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460977743"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 19:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="807375694"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="807375694"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2023 19:47:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 19:47:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 19:47:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 19:47:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 19:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ43ijnjij1x91nGpyir6DLFt657BMjJ5I7pwu/3Y01IKSBIwf9BwDsKvHlK2QGpv0l/0GDom406Sj1ur1fTd3iJXGDfHTiLhWkEnVumyHV5IvnqEvGEyHIPKMoaGCiq+rGvxBsbq28fVnLPyJbJm1nxyb6c3BR8biWSFGdI87mVQCcf4oqhrse5P/minIME//ifQpfwp70iLlKcbqwjBfTb+xaHChVM8j7yjlQc48TvIb+0XnXODhFDmjVhjG2EGvT4Ir2bcfeIZ73WMm3aL95utyct5iqQpkLYAmqZHxzmoa5B55AddhnHLDIfKSkyQk1f3zk1XklfzPKz3sMaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcqEaGdsd95CT5VJ0aGzpHFwhTnIKjZaer/m5luI72o=;
 b=MoqS2j1YgYIzuJEVhYWf4ejhJ/VO/7y5ziobgkyJ79sPd81WMrH+RFGw2yQ5azQ59tHAirTcAJUKUNJWtUKF/GyEEcHpNosYfcfri8VSld4igqamvVGbzUzsjvhM4b0Wze2CcdeZNC9s1510U4DbDxhK4mBLycsHDh439P5Vj61dk1ytFuwA4Tpu36ww+P69V/w2q+7DKNhfkuGrr94Dx22vG8Xu32a7zbSXVQ/cMlVyBQLY3ED81/PafQlgLRPqYzlF7nVG0CiSBlU0Db2zY6eLkKG78OdFYH4w/VShxSGrg+YWbM/Yhtub8Qsb44u/lx7UX6PkcaDA4y/jBSd0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 02:47:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:47:26 +0000
Date:   Fri, 25 Aug 2023 10:47:17 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [of] 74df14cd30:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <ZOgWNekYYNlIfds0@xsang-OptiPlex-9020>
References: <202308241628.feb8dbbf-oliver.sang@intel.com>
 <CAL_JsqKFhsEMO9=rTRDiO=3CD1jOK4QuUDnKM+bSDgrYHSZHNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKFhsEMO9=rTRDiO=3CD1jOK4QuUDnKM+bSDgrYHSZHNA@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d65572-15cd-4e80-4a60-08dba5159d6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzfs2Ht6Nb2R8XuppcAVRc7FnZUKPpeMsa1vj1k3ewOmQwSwtKSVykeoHn2T4TaPWZjHcshEuz9sk8mqvo4NC6efwNaz7ealIolMhdhtlcw660JsQaXY++cwoZOA8zrtWvEGl6LN1j+rdswgdPnyd5AN2efqldREddKV9ReGI1PV62VufNXb64SSmPdROPesuXLGS9njvyI8kLcGvSgzGviqZATe1G/bC7dvM/5K+B8Bgtwcto4uucV1R8JbT+CtA+MLLefS+r96evA0AiS5GNg7BwOsj3zOP0XVrxdmhlUXGqW8XdNHc2wX+b7LAwaD8SGnnc+Z2CNNlSyIcEm9Q2olVDXaydPuus0d47tl7azup8yHfyJyoeHoxR5Ei9SMJ/iWOtUC5k/+xorm5KkcylHayLFpDuQy81X2V9Nqj//HllopnxxVwnvypq+R2zLkAroCyQhIdZJqayj9eimxxcO1m8kAx+a9KIt3jSI1toU8zFrjXGOHPTSTxFz2/LDhHbcAQu09VtZ6dXKJrP0FaID4LV0I6CkgxXwoNS0N6/VarZkXLH0YBOCxeTHKYmJlxa1GMAFUl3HJ8TqAERGyZikaALJ5hTvIVu77AuxxmvwkI7sh6Mldeez+TuGd4B9aWVKFGIVcGFMOgbLkoityHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(4326008)(8676002)(8936002)(33716001)(41300700001)(53546011)(6486002)(6506007)(316002)(6666004)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(966005)(2906002)(30864003)(45080400002)(107886003)(5660300002)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNMS2VqZ2x0VG9SN3dVUG5GNjVLTENLQjNkbHNXb0Q4ODEwaHJKSFVJRXVh?=
 =?utf-8?B?aHdLZ1l5MFJNdzhCYTcrNFNzSXdzY3hKZDlzQTdhK2F4ME9CcDVsK08wL3Vh?=
 =?utf-8?B?aXNxZ0lhVnlUeHNVaUJyK1Z0cXJLNllQTndVMjYzN011TXRvRHNYMEUrdUpx?=
 =?utf-8?B?WnRZc2V6bkxLNldMRU9Kb2NabFYzSjdwOVpUSmZDTGdXMGZ2M2F3cGxlZVdy?=
 =?utf-8?B?WEd0MSs2QkJhQ25iWUtRcTNEZUJXRDhiK1hmR0s1dGJ2Q3ljemp5M2RrSEFr?=
 =?utf-8?B?dXdhY3NOdXY4UXNQZ09laFNSeTl6MUptRWtCN24wdVRDT0ZNNmxDU045emJN?=
 =?utf-8?B?b0JqVEJXa2hpcWZmK014bS9yTnRIbXVGWHNKZDN6TlFxanVHMFRIelcxSU12?=
 =?utf-8?B?MHBaaHNzRnliZHJFbnBiRU9vTnBvbUplbE1LVFhXWEVPRVRYdDZ5WG9ITkM1?=
 =?utf-8?B?dmVUcy80VStnd25hRlBSd0ZrUmVncGJ4S2FLZldTcGp3dmNxR3lBTlVuTzRS?=
 =?utf-8?B?Wmo2ZjFRKzI1ei83UE1jaGZJMXlLWEFoaGJRY0lHQXNsWS8rd1NxZzFhTjQx?=
 =?utf-8?B?VDB0RFh4L2NObkY1ZElNV2tYcHQxNWtOU1V1RHdBZ2NJMXRRSHhiWHQvQmFN?=
 =?utf-8?B?QlJWdWgvNzE0UFRJNCtlUXNWUU9qVXU3VHhHZTdhWEVZZVZ4VWQ3V1B0OHpH?=
 =?utf-8?B?clUxMFR3YzZCbzRUWUZiaFdpUHBzajZNc3dhdmp5c2ExeG1LNEZqWkJRQUll?=
 =?utf-8?B?ZFlJa3YvWXhMVC9JNEhlREd5WTkyanFFMG9uangzc1Zkd2tONHErNjVlV2k2?=
 =?utf-8?B?cjYySy9KWnYxQS9HNm52WThOVVd1NWtNcExORlV1RitUeCtYZTJrdFp3akNV?=
 =?utf-8?B?N1l6REtZR2FqTXNMcWgzMG9vUnB1d0M2NEVZdTJ1SlVCOU1KYTBsK0VRajlk?=
 =?utf-8?B?M3FvNG1idVJpeHplVzZaK0M1NEpURWtNSjNsMjVSeWNYNGpRME1LWVpTazlW?=
 =?utf-8?B?L3hrcWRJSHZITThybC9aeWNSa0IxdGJKME82Z1pib0xUdFVOUXV6NHV0Y2Nx?=
 =?utf-8?B?Nm9GYWV2cHVaTVdQcUpFU1dMWjZaUXBPMVBsZzk1cFByQkZManZmVHFJN2E0?=
 =?utf-8?B?RWMyOWRCWDBxdFlBU25abUdQWXFFc3BqL3YwQUdmaXZCNzhLREo2UWZkUkRr?=
 =?utf-8?B?eGtkT3dDakp2SGJOeStPbG5TTThZMU9GbjkvdUZkMjBTQXFHSjJ0eHhNYXMy?=
 =?utf-8?B?TWNsWENUY2FyOVRFZzlZUElvTURPMy9MU0h4QVl2bjVqOVFFSllYM3NNekRJ?=
 =?utf-8?B?VWdmTnVtNUV3UUhXWjVCdTJiNkRnTE1leCtyU2RkbXFIUjdJVjFCK2R0MFdZ?=
 =?utf-8?B?VmcvSHlvNlJVRzkwakhDOElwREZDdWhqNjA4eGQvUWovcWk4MU9wbU9Nbmlv?=
 =?utf-8?B?NCs3S2R3MTZoNUJ6blk1Mnlob0JMTE1ZY3U2RjZzeEloNytjS2pzK1NsbTlT?=
 =?utf-8?B?TEoydS9FWFFRejZ6SUpFRGFSRUwvME5TY05za1NRTEtqdFZiNTVNMDcvckpr?=
 =?utf-8?B?dnJjQXRrWTI0Q3FjWlpoT1pKSlE1Vmc2Z3RYN1NlZFVjS1ZmT1lLS29xMDlH?=
 =?utf-8?B?VDBTWkYreTdMQkl1WUR0cG5Pd254QW41WDJzNDRuMkJneWtYNU5IZ0tZNGl1?=
 =?utf-8?B?Zmh6cDVvOEEvcmIwOHFBUVU0UTRiSkNDR2cyaXdKbEhOeUJPVGZ4b1R6N3Fo?=
 =?utf-8?B?NzRudlpBQTFVaHpiMmY2RmxwY0VCc2lTWG9Zd2RpOEtKbER1VjRVTS8vVW9q?=
 =?utf-8?B?WHQ4dUl1eUtDOHpRTUJkNkJINGdaMTkvWWswREU4VUlXMm9rZFFsZ3pHb3BT?=
 =?utf-8?B?K3RkcmQwN3k3ZmQvejhlL2h1UUgrVUxBMUI1SlBKa0JtWG9zVzlralhQMTdW?=
 =?utf-8?B?SXROR0VWV0RGWm92RDNuRnoxYUZZOEFRbEtSRlZ4bk1lUFBvcGR4ZkVoZ0ZQ?=
 =?utf-8?B?UmdMMkxhZTF2eTVEV0gzaEpLRElNbXJ5YmlpRlBTak1vYjFSTVdZOTBwOUgr?=
 =?utf-8?B?YVN1UENKNVRyTytMeVNML1VjOFpUNUtqZzErRlFhUU00Zit5V3pxYWZ0Z2NR?=
 =?utf-8?B?OW9GKzdxbUtUbzV4UWtWUnRnQ3hSbXphbUp0MVI5cTF2K2xYd04vRGIxdDlN?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d65572-15cd-4e80-4a60-08dba5159d6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:47:25.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Flvqj8VLFDPmWw8Pa7w9B71PSZoI8s/LrUdnleEz8rypYYqNyop1spMIvKusC8LXuts+SOB/YadC/RMpdcps2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Rob Herring,


On Thu, Aug 24, 2023 at 07:59:17AM -0500, Rob Herring wrote:
> On Thu, Aug 24, 2023 at 3:42 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_lib/refcount.c:#refcount_warn_saturate" on:
> >
> > commit: 74df14cd301a1433947077e79ce2c610654a32e7 ("of: unittest: add node lifecycle tests")
> 
> Perhaps that is the unittest which has a test to generate the WARN?
> Not enough context from the log. It should be preceded by EXPECT
> statements.

we supplied full dmesg as:
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20230824/202308241628.feb8dbbf-oliver.sang@intel.com

from dmesg, before WARNING:
[   70.409388][    T1] ### dt-test ### pass of_unittest_platform_populate():1264
[   70.411108][    T1] ### dt-test ### EXPECT \ : platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
[   70.411126][    T1] platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
[   70.415857][    T1] ### dt-test ### EXPECT / : platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
[   70.415863][    T1] ### dt-test ### pass of_unittest_platform_populate():1275
[   70.420244][    T1] ### dt-test ### pass of_unittest_platform_populate():1279
[   70.422692][    T1] ### dt-test ### pass of_unittest_platform_populate():1285
[   70.428237][    T1] ### dt-test ### pass of_unittest_platform_populate():1307
[   70.430049][    T1] ### dt-test ### pass of_unittest_platform_populate():1307
[   70.432540][    T1] ### dt-test ### pass of_unittest_platform_populate():1317
[   70.434467][    T1] ### dt-test ### pass of_unittest_platform_populate():1317
[   70.436416][    T1] ### dt-test ### pass of_unittest_lifecycle():3032
[   70.438044][    T1] ### dt-test ### EXPECT \ : OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node
[   70.438049][    T1] ### dt-test ### pass of_unittest_lifecycle():3057
[   70.442557][    T1] ------------[ cut here ]------------
[   70.443874][    T1] refcount_t: addition on 0; use-after-free.
[   70.445250][    T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:25 refcount_warn_saturate+0x7a/0xd9

later:
[   70.593100][    T1] ---[ end trace 0000000000000000 ]---
[   70.685082][    T1] ### dt-test ### EXPECT / : OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node
[   70.685088][    T1] ### dt-test ### EXPECT \ : ------------[ cut here ]------------
[   70.687788][    T1] ### dt-test ### EXPECT \ : WARNING: <<all>>
[   70.689644][    T1] ### dt-test ### EXPECT \ : refcount_t: underflow; use-after-free.
[   70.691083][    T1] ### dt-test ### EXPECT \ : ---[ end trace <<int>> ]---
[   70.693049][    T1] ### dt-test ### pass of_unittest_lifecycle():3077
[   70.696236][    T1] ### dt-test ### EXPECT / : ---[ end trace <<int>> ]---
[   70.696241][    T1] ### dt-test ### EXPECT / : refcount_t: underflow; use-after-free.
[   70.697816][    T1] ### dt-test ### EXPECT / : WARNING: <<all>>
[   70.699801][    T1] ### dt-test ### EXPECT / : ------------[ cut here ]------------
[   70.701315][    T1] ### dt-test ### EXPECT_NOT \ : ------------[ cut here ]------------
[   70.703176][    T1] ### dt-test ### EXPECT_NOT \ : WARNING: <<all>>
[   70.705142][    T1] ### dt-test ### EXPECT_NOT \ : refcount_t: underflow; use-after-free.
[   70.706679][    T1] ### dt-test ### EXPECT_NOT \ : ---[ end trace <<int>> ]---
[   70.708730][    T1] ### dt-test ### pass of_unittest_lifecycle():3094
[   70.712030][    T1] ### dt-test ### EXPECT_NOT / : ---[ end trace <<int>> ]---
[   70.712035][    T1] ### dt-test ### EXPECT_NOT / : refcount_t: underflow; use-after-free.
[   70.713786][    T1] ### dt-test ### EXPECT_NOT / : WARNING: <<all>>
[   70.715744][    T1] ### dt-test ### EXPECT_NOT / : ------------[ cut here ]------------
[   70.717285][    T1] ### dt-test ### pass of_unittest_lifecycle():3120
[   70.720780][    T1] ### dt-test ### pass of_unittest_lifecycle():3121
[   70.722425][    T1] ### dt-test ### pass of_unittest_check_tree_linkage():270
[   70.724083][    T1] ### dt-test ### pass of_unittest_check_tree_linkage():273
[   70.725918][    T1] ### dt-test ### end of unittest - 221 passed, 0 failed

not sure if they are helpful?


> 
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linux-next/master e3f80d3eae76c3557b3c9b5938ad01c0e6cf25ec]
> >
> > in testcase: boot
> >
> > compiler: gcc-7
> > test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202308241628.feb8dbbf-oliver.sang@intel.com
> >
> >
> > [   70.442557][    T1] ------------[ cut here ]------------
> > [   70.443874][    T1] refcount_t: addition on 0; use-after-free.
> > [ 70.445250][ T1] WARNING: CPU: 1 PID: 1 at lib/refcount.c:25 refcount_warn_saturate (lib/refcount.c:25 (discriminator 3))
> > [   70.447754][    T1] Modules linked in:
> > [   70.448750][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                TN 6.2.0-rc1-00057-g74df14cd301a #1 fcca16d7341229f468256f53411c1bbb3612d6fc
> > [   70.451836][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 70.454292][ T1] EIP: refcount_warn_saturate (lib/refcount.c:25 (discriminator 3))
> > [ 70.455655][ T1] Code: c6 05 3e 40 ed c3 01 e8 5d 62 97 ff 0f 0b eb 76 80 3d 3d 40 ed c3 00 75 6e 68 f0 5a 54 c3 c6 05 3d 40 ed c3 01 e8 3f 62 97 ff <0f> 0b eb 58 80 3d 3c 40 ed c3 00 75 50 68 1c 5b 54 c3 c6 05 3c 40
> > All code
> > ========
> >    0:   c6 05 3e 40 ed c3 01    movb   $0x1,-0x3c12bfc2(%rip)        # 0xffffffffc3ed4045
> >    7:   e8 5d 62 97 ff          callq  0xffffffffff976269
> >    c:   0f 0b                   ud2
> >    e:   eb 76                   jmp    0x86
> >   10:   80 3d 3d 40 ed c3 00    cmpb   $0x0,-0x3c12bfc3(%rip)        # 0xffffffffc3ed4054
> >   17:   75 6e                   jne    0x87
> >   19:   68 f0 5a 54 c3          pushq  $0xffffffffc3545af0
> >   1e:   c6 05 3d 40 ed c3 01    movb   $0x1,-0x3c12bfc3(%rip)        # 0xffffffffc3ed4062
> >   25:   e8 3f 62 97 ff          callq  0xffffffffff976269
> >   2a:*  0f 0b                   ud2             <-- trapping instruction
> >   2c:   eb 58                   jmp    0x86
> >   2e:   80 3d 3c 40 ed c3 00    cmpb   $0x0,-0x3c12bfc4(%rip)        # 0xffffffffc3ed4071
> >   35:   75 50                   jne    0x87
> >   37:   68 1c 5b 54 c3          pushq  $0xffffffffc3545b1c
> >   3c:   c6                      .byte 0xc6
> >   3d:   05                      .byte 0x5
> >   3e:   3c 40                   cmp    $0x40,%al
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0:   0f 0b                   ud2
> >    2:   eb 58                   jmp    0x5c
> >    4:   80 3d 3c 40 ed c3 00    cmpb   $0x0,-0x3c12bfc4(%rip)        # 0xffffffffc3ed4047
> >    b:   75 50                   jne    0x5d
> >    d:   68 1c 5b 54 c3          pushq  $0xffffffffc3545b1c
> >   12:   c6                      .byte 0xc6
> >   13:   05                      .byte 0x5
> >   14:   3c 40                   cmp    $0x40,%al
> > [   70.460090][    T1] EAX: 0000002a EBX: edf25dfc ECX: 00000000 EDX: 00000001
> > [   70.461715][    T1] ESI: ffffffff EDI: edf20140 EBP: c5803c98 ESP: c5803c94
> > [   70.463395][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
> > [   70.465280][    T1] CR0: 80050033 CR2: 00000000 CR3: 04312000 CR4: 000406f0
> > [   70.466949][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   70.468627][    T1] DR6: fffe0ff0 DR7: 00000400
> > [   70.469791][    T1] Call Trace:
> > [ 70.470624][ T1] kobject_get (lib/kobject.c:630)
> > [ 70.471657][ T1] of_node_get (drivers/of/dynamic.c:37)
> > [ 70.472723][ T1] of_fwnode_get (drivers/of/property.c:866 (discriminator 4))
> > [ 70.473833][ T1] fwnode_handle_get (drivers/base/property.c:822)
> > [ 70.475019][ T1] fwnode_get_nth_parent (drivers/base/property.c:686)
> > [ 70.476273][ T1] fwnode_full_name_string (lib/vsprintf.c:2091 (discriminator 3))
> > [ 70.477560][ T1] device_node_string (lib/vsprintf.c:2143)
> > [ 70.478752][ T1] ? sched_clock_cpu (kernel/sched/clock.c:364)
> > [ 70.479932][ T1] ? __lock_acquire (kernel/locking/lockdep.c:3746 kernel/locking/lockdep.c:3799 kernel/locking/lockdep.c:5055)
> > [ 70.481114][ T1] pointer (lib/vsprintf.c:2452)
> > [ 70.482112][ T1] vsnprintf (lib/vsprintf.c:2800)
> > [ 70.483212][ T1] vprintk_store (kernel/printk/printk.c:2241)
> > [ 70.484369][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
> > [ 70.485663][ T1] ? sched_clock (arch/x86/kernel/tsc.c:254)
> > [ 70.486742][ T1] vprintk_emit (kernel/printk/printk.c:2338)
> > [ 70.487814][ T1] vprintk_default (kernel/printk/printk.c:2369)
> > [ 70.488983][ T1] vprintk (kernel/printk/printk_safe.c:51)
> > [ 70.489980][ T1] _printk (kernel/printk/printk.c:2382)
> > [ 70.490957][ T1] of_node_release (drivers/of/dynamic.c:343)
> > [ 70.492067][ T1] kobject_release (lib/kobject.c:677 lib/kobject.c:704)
> > [ 70.493179][ T1] kobject_put (include/linux/kref.h:65 lib/kobject.c:721)
> > [ 70.494272][ T1] of_node_put (drivers/of/dynamic.c:49)
> > [ 70.495302][ T1] of_unittest (drivers/of/unittest.c:3060 drivers/of/unittest.c:3650)
> > [ 70.496497][ T1] ? of_unittest_changeset (drivers/of/unittest.c:3605)
> > [ 70.497818][ T1] do_one_initcall (init/main.c:1306)
> > [ 70.498945][ T1] ? rcu_read_lock_sched_held (kernel/rcu/update.c:125)
> > [ 70.500257][ T1] ? trace_initcall_level (include/trace/events/initcall.h:10)
> > [ 70.501552][ T1] ? kernel_init_freeable (init/main.c:1378 init/main.c:1395 init/main.c:1414 init/main.c:1634)
> > [ 70.502817][ T1] kernel_init_freeable (init/main.c:1378 init/main.c:1395 init/main.c:1414 init/main.c:1634)
> > [ 70.504101][ T1] ? rest_init (init/main.c:1514)
> > [ 70.505225][ T1] kernel_init (init/main.c:1524)
> > [ 70.506294][ T1] ret_from_fork (arch/x86/entry/entry_32.S:770)
> > [   70.507381][    T1] irq event stamp: 2968680
> > [ 70.508481][ T1] hardirqs last enabled at (2968679): kmem_cache_free (arch/x86/include/asm/irqflags.h:29 arch/x86/include/asm/irqflags.h:70 arch/x86/include/asm/irqflags.h:130 mm/slab.c:3581 mm/slab.c:3605)
> > [ 70.510605][ T1] hardirqs last disabled at (2968680): vprintk_store (arch/x86/include/asm/preempt.h:27 (discriminator 3) kernel/printk/printk.c:2061 (discriminator 3) kernel/printk/printk.c:2221 (discriminator 3))
> > [ 70.512664][ T1] softirqs last enabled at (2968660): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:415 kernel/softirq.c:600)
> > [ 70.514774][ T1] softirqs last disabled at (2968651): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147)
> > [   70.516984][    T1] ---[ end trace 0000000000000000 ]---
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20230824/202308241628.feb8dbbf-oliver.sang@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> 
