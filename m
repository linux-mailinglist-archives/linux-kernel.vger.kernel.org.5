Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78B57CEF34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjJSFnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjJSFmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:42:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDA185
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697694112; x=1729230112;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Oh6fStvYzFSqaqp+135tfGNKQ5tmUQM8Q+ZlH0YkRz8=;
  b=jlq9/mjO/dxd6fCuFP95unZGgFf/D0umeJQZXHNnnaGwpzTCOgkRiraf
   NqBudWG/2ORA3pUaecEm1v1JrfuyWVQWVK7rTyGcIZp/X5rfN+oOz8W6p
   II7BQTjv+R1/3YlyShNfWoJnmefWHtsXUKdiEJ4F+T+7o4IFFec/AjIJL
   tcW/+nHz7zbH3Ysuh9WOifrv+in6JjvhrVCXpC3j6p7fzpxKSEY6roVJB
   xWBFFReRPzNhaF6rIe83mPguZ8UAm/3IQxGvHoLJfwm2wKNsTNGTq9FoO
   8w5O+jID7pgY4KL9OwqVhkrZB1GdOd8Lm05Ww/fQfLL+TKWCXmRbt7WcL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389038636"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="389038636"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:41:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750385885"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="750385885"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 22:41:49 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 22:41:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 22:41:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 22:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJKxbI7mIDqRe8lMDMMD5nqygtnSRN5SrnaIgR7hTo2dlX/eVIIEKpdOcrUhtl/py5Zj25z9Qgp48gsJcK9otFgdZNJ41xbTL4iV4OPzVrjwn1opPlGfVa9qaYTb1FeUSlv8MH5w8lfI1v1aCbAtNAwo8oULWE5yvuuU7r4u72HjiwHI2hA7LEvZ2rPoCBLc3ZBQ6mX9kdKRmbosqs6oR5sGjal0AGP8au2+NC5/AcCkN4n4bKUY5EnXccZFhne95ox/71FIoeypLaujHDOkcWv+OYXRGIqsJceH+iAYD58oKIVhi6itmwd77H2sh8vphE+0YBgR02Mho6+4VyECHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19sMNAk2k5UIPuB+ERa/4sK1HZlMrczPm8rl2wtRP40=;
 b=nwnenSqF12o7QlMyqPpT77U/fRVWSA1RjlqspULNmzS+IkHyYzXXVGPEDsh8DKo0I8Si+X8hge12EqnUWEBJpyxETrrvYNZCBZHKPQ4yP6OJQkmdpheIG2T9greT+eoj2CzQzSyfEkyg7aHOSETfCv97ZZCJOrTD2snB60aCJuuvJ7jBe+N5Zv7VzkdcxXYqFY2e9E9/7eLpO/iv54K0x0ld2WPfW7JaVUHHU0r9h/pKjpmngx7zHWMSu4oquGReQtmkloHBOLPl/0FaGUvQG2GvNyhfjHeUpEYGea+H74/DiMpi9DAG7b67l/08OXpwffS6JPoAAfyB3maiMCWYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 05:41:38 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Thu, 19 Oct 2023
 05:41:38 +0000
Date:   Thu, 19 Oct 2023 13:41:30 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Max Kellermann <max.kellermann@ionos.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
Message-ID: <ZTDBih32BX9+RnU5@xsang-OptiPlex-9020>
References: <202310172247.b9959bd4-oliver.sang@intel.com>
 <CAKPOu+_T8xk4yd2P4KT4j3eMoFqwYmkxqDHaFtv4Hii5-XyPuA@mail.gmail.com>
 <CAKPOu+87SC1Gk7vgRC4dmBYQ4REqeEq0seFqTwngPSe=z9pn=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+87SC1Gk7vgRC4dmBYQ4REqeEq0seFqTwngPSe=z9pn=Q@mail.gmail.com>
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CY5PR11MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f910ca-736d-484c-a36b-08dbd066101f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyyuDnjTjX8ahFdJfFXPivewgJLOT0su27lX3HHoL8HO8345+olWtoJ272jhmeWOYNXWQNbArwDAcNcxbfdUbTAiyWTuLHMGq+7H7jGhakvXPhgpfQTSYx6ceX1OLZcQ7rWSHvxbLpdNVdn7xNpeBiUtG/0ww5XQS3XeM8In4GLD0ZuMVClaaAXgd1+aEArcs1G/2AhTd/6GDgJdimOcrYiy1mLoZUbCQUa4jtyjdOIFIlwKvITGfcWqdj+HyQ8NEJDUk2HpM+GSXxgkXHKOa4h1tkiVMqCmV12Tz+Dh2dCKQjFJGY0tCSme9UUFlVbfVRBgXkkA1mB9bWqcbt9nOQRFZ3bMVg0Rwm6CkfQt26IkrrJvfd7FXr/Ks6V0o5UxqWN0/xavSqtFezOQg8fXdvY6iryBUPYnzHOZVoKj/zRPSQfHrVljHBNP5pEFLtUfd7SucARfymSbyY/s5q/YTuVJOEddX8kVnaRFomICUWHeCbL7BPKazfqe7pG0j1VFCj8wV35DJHFA5LI+oMfJ00TXrYFeJIP6cwmW/UL9okipCkNZBEquADENF0VvERLS50/r1EsoqpOjPHdNqSs9Hmt40jbx/bg3vyPrNxcrPCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(44832011)(86362001)(2906002)(30864003)(4326008)(41300700001)(66946007)(66476007)(8676002)(54906003)(316002)(6916009)(66556008)(33716001)(82960400001)(107886003)(26005)(83380400001)(5660300002)(38100700002)(9686003)(6666004)(6512007)(53546011)(6506007)(8936002)(478600001)(966005)(19627235002)(67856001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThFanBYVW1vaTVCaGdsaXpFdE9lbmNMb3diUzk2YXRmSmUrcjg5TGxrZFhY?=
 =?utf-8?B?R2FOcDlSb1dkM2gvRmtuZ3Rubklnd1FCVVR5NEVFazJaZnZYQnRRU0dyby85?=
 =?utf-8?B?VDNmZWF6b1RoMG56TGEyY1hsYUpoaEY4LzNIVnpwVDl2ejU4aWJWdFI3YkJ1?=
 =?utf-8?B?dC9hOUgxemtQZ0dpVkpBdHcyd24yVUpuVjdxdUpSNEtEbFlTa0daVWRjMTd0?=
 =?utf-8?B?cjVEZ3paMkxGUmhiaUhUaytqWldRSzV1a3JnMGh6SmtHclR5blhTakxUc3ZH?=
 =?utf-8?B?OGVabThxMllQelpyZWxZYnIrTmh2QXFEajVsWmNROG42NXNpMy9jKzJZZTh1?=
 =?utf-8?B?NzRRZ2lLemtBSkRCQWx0V0xBT1paU3JKL0UzSTNzTUUyM3gra3lrR0hSS2RR?=
 =?utf-8?B?Tm80YmJMMm1PMjN6QmZleHlGOGpzdUROUHo1emFSRlJHNGQ2Qm1SL3hvNFp0?=
 =?utf-8?B?Z21zVlowdEkxYkRpQ3c4Z0c0dHd3NFBXSCs0c2VsbExYc01DVzZFQ2RPMUtY?=
 =?utf-8?B?b1BOUEtQcktUL0ttSlZudWlzeDlaM01Mc21XVTA2Z05NSXVBclZvTnhhaFFm?=
 =?utf-8?B?cVZ4bE91SWF2Wm9Vai84MkwvKzc3bDhvYlBGa1plZy9rVjgzbXRJWkN0cnZL?=
 =?utf-8?B?bWF3TWhzbW9wcC9NTzhOeko3eHFLZkJESWx0Vm1UQ3JBam5uMlEvVStMRXhE?=
 =?utf-8?B?UzhXS2l2Q1pIWnpEVXBuNE9jSDAvM2pyOXM5RjVvTmN0dnpGYzljcmZnUm1N?=
 =?utf-8?B?WUh1WDRwUUkrZFRxWWpDM1RVNUhVOG81clJFU1hlMWtyZkhUdkllcHNyZm0v?=
 =?utf-8?B?NGlXY21CZFkrRUNXcEd4UUQyRk42MTBjRlhjS2NoRmQ3VEo0RWcxVGErZDJy?=
 =?utf-8?B?eXB2bjZ5cEszMSsxNnNVVjhJN29qdkp5SXVpM1hORUZhT1VqVHBDME5NWVlB?=
 =?utf-8?B?ZmVqT2VDd0R1V2N3Yno2SlkyQ3lsL3I3bU8xYWJYM3ppZWFzZGVYNXM5KzlQ?=
 =?utf-8?B?cE5UeHFXdWoweVBwNDdlK0xadXkrVDEzUERYclFsb3pDaUlhMnYzSVVTVEhE?=
 =?utf-8?B?U3drVEg3Q09mdm5ocE95TWg5c2xpQW1NVDBVK1FTdnpWOW01aFg0VGVtVmxO?=
 =?utf-8?B?MjJGTlVGT2t2cXRaQWI4Vm5aTFZZakFhSHpJdFlxTnd6TEdUQ0d6a0ppNVgr?=
 =?utf-8?B?RVRjNXN2alRIbFI3WjRrM1RJVEpUampXakJHUVdUUE04WWVvTDJxY0JrTnYw?=
 =?utf-8?B?MzRkakwwdWQ3NUJQa241RllWZG9KSzBwRURnM2xTbGVKMWJ3QTU5UFh5VGNC?=
 =?utf-8?B?NWt6WmRXd1AwbU1rQ0l5WjNRb1dpOWorWStqVkhyZThTYmd5SEVnSk5YZTdV?=
 =?utf-8?B?d1R2VzU5cW9QbE5ldVpvQU1PaTFaQTRkSGtJUktvWjRBeVE4Nkp0aERmRi9G?=
 =?utf-8?B?MS85VFY4dGlPbWc2RGFud1piOHlDYktNeUFraW96KzJpcmxjOEt5QlMyZENN?=
 =?utf-8?B?ejQrSE5XbEd5NGVoRWZlN1VLY1BWVm5rTUw1RS9vem96ZXBMTlJ4d2kzc3Bj?=
 =?utf-8?B?dWlMT29nYUkxR1B5TFBSd2p5SzhGWU11cGVTdTNJbEdrajZZREVTNVBrTTYv?=
 =?utf-8?B?Ti90OUZCWVMzQVlqZmZRK0kzUjIrZklZckx0cTFWNXExRWhXQS9DekRUVTdM?=
 =?utf-8?B?YVFxVmhIMWJCOFpjRjVmYmxmR3J1T1hLZHltQURaenRVenU5dXRib0pWSCtw?=
 =?utf-8?B?bzlLa2JHbkltRi9tK0RhZFJSWEhyUmxBMXN2anhDWmgxMGRSQlVaUTUzRzUy?=
 =?utf-8?B?S29VbGtxb25aazBEMG5JYk9vNk91SFM2TXFkK21uNFBZYmZkN2J4V2VBd2hJ?=
 =?utf-8?B?aVVzODJzSjlCN1E4RFZweUFETTRNSmZnMERvakxYTHA3WlFJek5YUG0vOU5X?=
 =?utf-8?B?VDd3aVlGNnJKUUFTTGFCK0NtNWZyV1ZxQWF1ZW4wa1RCaklaTm9ueVJuRHRq?=
 =?utf-8?B?QXVtM3RHSzRmdm95M2pGU2hPaDhlUERNc3FDOVdRMEd3NjdYWDNEeUJCWmJr?=
 =?utf-8?B?b3R4VFZJZHd1am5KM3A2dFQ1aGljTUxtbEZqNTlUSTlPWVJGc0x4RmgrejFI?=
 =?utf-8?B?dkw5T0p0SWVkZkpVL2EwZEE3MWdEbWxrR2FwWklabVc1Z3BIT010MG8rdnRN?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f910ca-736d-484c-a36b-08dbd066101f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 05:41:38.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XJgwXnQZGmGhsOUKlLS/p4sMddqDrv1fsjknSeUrzxpzGwqyM4kxh9a3tKaBN+PDc5ujEasgFd58+4lfFVHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Max Kellermann,

On Wed, Oct 18, 2023 at 01:12:27PM +0200, Max Kellermann wrote:
> On Wed, Oct 18, 2023 at 12:21 PM Max Kellermann
> <max.kellermann@ionos.com> wrote:
> > I think this might be caused by a bug in stress-ng, leading to
> > blocking pipe writes.
> 
> Just in case I happen to be right, I've submitted a PR for stress-ng:
> https://github.com/ColinIanKing/stress-ng/pull/326
> 

we tested with this commit, and noticed a big improvement now.

19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
 7.861e+08 ±  2%    +167.9%  2.106e+09        stress-ng.splice.ops
  12886325 ±  2%    +167.9%   34526248        stress-ng.splice.ops_per_sec


detail comparison with more monitor/perf data as below FYI



19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
 2.464e+09            +0.0%  2.464e+09        cpuidle..time
   2495283            +0.4%    2504203        cpuidle..usage
    116.23            +4.4%     121.32        uptime.boot
      8523 ±  2%      +7.7%       9178        uptime.idle
     49.76 ±  2%     +10.2%      54.85        boot-time.boot
     26.14            -0.1%      26.13        boot-time.dhcp
      5927 ±  2%     +11.0%       6580        boot-time.idle
     28.99            +0.0       29.02        mpstat.cpu.all.idle%
      0.93            +0.0        0.94        mpstat.cpu.all.irq%
      0.01 ±  3%      -0.0        0.01 ±  5%  mpstat.cpu.all.soft%
     63.59           -10.6       52.95        mpstat.cpu.all.sys%
      6.47           +10.6       17.08        mpstat.cpu.all.usr%
    487.00 ±  2%     -99.5%       2.50 ± 20%  perf-c2c.DRAM.local
      3240 ± 11%     -96.8%     103.00 ±  3%  perf-c2c.DRAM.remote
      5244           -97.0%     156.00 ±  9%  perf-c2c.HITM.local
    432.50 ± 20%     -85.2%      64.00 ±  7%  perf-c2c.HITM.remote
      5676 ±  2%     -96.1%     220.00 ±  9%  perf-c2c.HITM.total
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
 4.611e+08 ±  2%    +129.2%  1.057e+09        numa-numastat.node0.local_node
 4.613e+08 ±  2%    +129.1%  1.057e+09        numa-numastat.node0.numa_hit
     78581 ± 47%     -63.1%      28977 ± 42%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
 3.259e+08 ± 10%    +223.5%  1.054e+09        numa-numastat.node1.local_node
 3.264e+08 ± 10%    +223.0%  1.054e+09        numa-numastat.node1.numa_hit
     53882 ± 68%     +92.0%     103462 ± 12%  numa-numastat.node1.other_node
     31.28            +0.0%      31.29        vmstat.cpu.id
     62.75           -17.0%      52.11        vmstat.cpu.sy
      6.39 ±  2%    +159.7%      16.59        vmstat.cpu.us
      0.03            +0.0%       0.03        vmstat.io.bi
      4.00            +0.0%       4.00        vmstat.memory.buff
   3047892            -0.5%    3032948        vmstat.memory.cache
 2.256e+08            +0.0%  2.257e+08        vmstat.memory.free
     88.34            +0.0%      88.37        vmstat.procs.r
      3238 ±  2%      +5.1%       3402 ±  4%  vmstat.system.cs
    185280            +0.9%     186929        vmstat.system.in
     63.19            -0.1%      63.15        time.elapsed_time
     63.19            -0.1%      63.15        time.elapsed_time.max
      9701            +3.3%      10026 ±  6%  time.involuntary_context_switches
      0.00         +5e+101%       0.50 ±100%  time.major_page_faults
      4096            +0.0%       4096        time.maximum_resident_set_size
     11594            -2.1%      11347 ±  2%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
      9176            +0.0%       9180        time.percent_of_cpu_this_job_got
      5280           -16.7%       4397        time.system_time
    518.57          +170.2%       1401        time.user_time
      1723 ±  5%      -4.8%       1640        time.voluntary_context_switches
 7.861e+08 ±  2%    +167.9%  2.106e+09        stress-ng.splice.ops
  12886325 ±  2%    +167.9%   34526248        stress-ng.splice.ops_per_sec
     63.19            -0.1%      63.15        stress-ng.time.elapsed_time
     63.19            -0.1%      63.15        stress-ng.time.elapsed_time.max
      9701            +3.3%      10026 ±  6%  stress-ng.time.involuntary_context_switches
      0.00         +5e+101%       0.50 ±100%  stress-ng.time.major_page_faults
      4096            +0.0%       4096        stress-ng.time.maximum_resident_set_size
     11594            -2.1%      11347 ±  2%  stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
      9176            +0.0%       9180        stress-ng.time.percent_of_cpu_this_job_got
      5280           -16.7%       4397        stress-ng.time.system_time
    518.57          +170.2%       1401        stress-ng.time.user_time
      1723 ±  5%      -4.8%       1640        stress-ng.time.voluntary_context_switches
      1839            -0.0%       1839        turbostat.Avg_MHz
     70.90            -0.0       70.86        turbostat.Busy%
      2600            +0.0%       2600        turbostat.Bzy_MHz
   2460348            +0.4%    2470080        turbostat.C1
     29.44            +0.0       29.46        turbostat.C1%
     29.10            +0.1%      29.14        turbostat.CPU%c1
     71.00            -3.5%      68.50        turbostat.CoreTmp
      0.16 ±  3%    +163.6%       0.44        turbostat.IPC
  12324057            +0.9%   12436149        turbostat.IRQ
      0.00          +177.1      177.10        turbostat.PKG_%
    158.50 ± 19%     -68.1%      50.50 ±  2%  turbostat.POLL
     71.00            -3.5%      68.50        turbostat.PkgTmp
    362.06           +10.4%     399.82        turbostat.PkgWatt
     30.42 ±  2%      -7.5%      28.14 ±  3%  turbostat.RAMWatt
      1996            +0.0%       1996        turbostat.TSC_MHz
    180394            -5.7%     170032        meminfo.Active
    179746            -5.8%     169377        meminfo.Active(anon)
    647.52            +1.1%     654.95        meminfo.Active(file)
     80759            +1.3%      81828 ±  4%  meminfo.AnonHugePages
    403700            -0.4%     401890        meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
   2929930            -0.5%    2915714        meminfo.Cached
 1.154e+08            +0.0%  1.154e+08        meminfo.CommitLimit
   1544192            -1.7%    1518156        meminfo.Committed_AS
 2.254e+08            -0.5%  2.244e+08        meminfo.DirectMap1G
  11029504 ±  9%      +9.5%   12079104 ±  8%  meminfo.DirectMap2M
    148584 ±  3%      -0.7%     147560 ±  6%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
    437427            -1.1%     432672        meminfo.Inactive
    437032            -1.1%     432286        meminfo.Inactive(anon)
    394.91            -2.4%     385.42        meminfo.Inactive(file)
    112746            -0.5%     112232        meminfo.KReclaimable
     24941            -1.2%      24647        meminfo.KernelStack
     74330            -8.9%      67748 ±  5%  meminfo.Mapped
 2.246e+08            +0.0%  2.247e+08        meminfo.MemAvailable
 2.256e+08            +0.0%  2.257e+08        meminfo.MemFree
 2.307e+08            +0.0%  2.307e+08        meminfo.MemTotal
   5077046            -0.8%    5036202        meminfo.Memused
     11.18            +0.0%      11.18        meminfo.Mlocked
      9587            -0.4%       9551        meminfo.PageTables
     59841            -0.0%      59837        meminfo.Percpu
    112746            -0.5%     112232        meminfo.SReclaimable
    259649            -0.4%     258517        meminfo.SUnreclaim
    213290            -6.7%     199078        meminfo.Shmem
    372396            -0.4%     370750        meminfo.Slab
   2715599            -0.0%    2715599        meminfo.Unevictable
 1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
    263718            -0.2%     263313        meminfo.VmallocUsed
   5528890            -0.4%    5504303        meminfo.max_used_kB
     34163 ±  4%     -72.1%       9514 ± 86%  numa-meminfo.node0.Active
     33835 ±  5%     -71.9%       9514 ± 86%  numa-meminfo.node0.Active(anon)
    328.00 ±100%    -100.0%       0.00        numa-meminfo.node0.Active(file)
      5064 ±  2%    +774.4%      44282 ± 53%  numa-meminfo.node0.AnonHugePages
     76171 ± 15%    +150.5%     190797 ± 29%  numa-meminfo.node0.AnonPages
    144806 ±  4%     +90.9%     276438 ± 23%  numa-meminfo.node0.AnonPages.max
   2743966           -96.1%     107423 ± 93%  numa-meminfo.node0.FilePages
     81560 ± 15%    +140.2%     195891 ± 28%  numa-meminfo.node0.Inactive
     81366 ± 15%    +140.8%     195891 ± 28%  numa-meminfo.node0.Inactive(anon)
    193.88 ±100%    -100.0%       0.00        numa-meminfo.node0.Inactive(file)
     82587 ±  3%     -65.1%      28849 ± 11%  numa-meminfo.node0.KReclaimable
     12151 ±  3%      +3.6%      12587        numa-meminfo.node0.KernelStack
     45176           -70.4%      13392 ± 18%  numa-meminfo.node0.Mapped
 1.279e+08            +2.0%  1.305e+08        numa-meminfo.node0.MemFree
 1.317e+08            +0.0%  1.317e+08        numa-meminfo.node0.MemTotal
   3753848           -67.2%    1232426 ±  4%  numa-meminfo.node0.MemUsed
      2133 ±  7%    +123.3%       4762 ± 43%  numa-meminfo.node0.PageTables
     82587 ±  3%     -65.1%      28849 ± 11%  numa-meminfo.node0.SReclaimable
    139456 ±  7%      +3.7%     144548        numa-meminfo.node0.SUnreclaim
     39137 ±  6%     -62.4%      14718 ± 59%  numa-meminfo.node0.Shmem
    222043 ±  3%     -21.9%     173397 ±  2%  numa-meminfo.node0.Slab
   2704307           -96.6%      92704 ± 99%  numa-meminfo.node0.Unevictable
    146360            +9.7%     160589 ±  6%  numa-meminfo.node1.Active
    146040            +9.5%     159934 ±  6%  numa-meminfo.node1.Active(anon)
    319.52 ±100%    +105.0%     654.95        numa-meminfo.node1.Active(file)
     75819           -50.3%      37670 ± 52%  numa-meminfo.node1.AnonHugePages
    327658 ±  3%     -35.5%     211208 ± 26%  numa-meminfo.node1.AnonPages
    411864           -34.8%     268684 ± 16%  numa-meminfo.node1.AnonPages.max
    186229         +1408.1%    2808443 ±  3%  numa-meminfo.node1.FilePages
    356143 ±  3%     -33.5%     236972 ± 24%  numa-meminfo.node1.Inactive
    355942 ±  3%     -33.5%     236586 ± 24%  numa-meminfo.node1.Inactive(anon)
    201.03 ±100%     +91.7%     385.42        numa-meminfo.node1.Inactive(file)
     30163 ± 10%    +176.4%      83380 ±  4%  numa-meminfo.node1.KReclaimable
     12792 ±  2%      -5.7%      12061        numa-meminfo.node1.KernelStack
     29717           +84.0%      54689 ±  2%  numa-meminfo.node1.Mapped
  97713848            -2.5%   95230678        numa-meminfo.node1.MemFree
  99034676            +0.0%   99034676        numa-meminfo.node1.MemTotal
   1320827 ±  5%    +188.0%    3803997        numa-meminfo.node1.MemUsed
     11.08            +0.8%      11.18        numa-meminfo.node1.Mlocked
      7406           -35.4%       4784 ± 41%  numa-meminfo.node1.PageTables
     30163 ± 10%    +176.4%      83380 ±  4%  numa-meminfo.node1.SReclaimable
    120178 ±  8%      -5.2%     113955        numa-meminfo.node1.SUnreclaim
    174414            +5.8%     184508 ±  4%  numa-meminfo.node1.Shmem
    150341 ±  5%     +31.3%     197335 ±  2%  numa-meminfo.node1.Slab
     11292 ± 29%  +23126.1%    2622894 ±  3%  numa-meminfo.node1.Unevictable
      8464 ±  5%     -71.9%       2380 ± 86%  numa-vmstat.node0.nr_active_anon
     82.00 ±100%    -100.0%       0.00        numa-vmstat.node0.nr_active_file
     19043 ± 15%    +150.4%      47693 ± 29%  numa-vmstat.node0.nr_anon_pages
      2.47 ±  2%    +774.4%      21.62 ± 53%  numa-vmstat.node0.nr_anon_transparent_hugepages
    685997           -96.1%      26858 ± 93%  numa-vmstat.node0.nr_file_pages
  31983370            +2.0%   32613637        numa-vmstat.node0.nr_free_pages
     20344 ± 15%    +140.7%      48968 ± 28%  numa-vmstat.node0.nr_inactive_anon
     48.47 ±100%    -100.0%       0.00        numa-vmstat.node0.nr_inactive_file
     12155 ±  3%      +3.5%      12579        numa-vmstat.node0.nr_kernel_stack
     11313           -70.4%       3351 ± 18%  numa-vmstat.node0.nr_mapped
    534.37 ±  6%    +121.2%       1182 ± 42%  numa-vmstat.node0.nr_page_table_pages
      9790 ±  6%     -62.4%       3682 ± 59%  numa-vmstat.node0.nr_shmem
     20646 ±  3%     -65.1%       7212 ± 11%  numa-vmstat.node0.nr_slab_reclaimable
     34863 ±  7%      +3.6%      36135        numa-vmstat.node0.nr_slab_unreclaimable
    676076           -96.6%      23176 ± 99%  numa-vmstat.node0.nr_unevictable
      8464 ±  5%     -71.9%       2380 ± 86%  numa-vmstat.node0.nr_zone_active_anon
     82.00 ±100%    -100.0%       0.00        numa-vmstat.node0.nr_zone_active_file
     20344 ± 15%    +140.7%      48968 ± 28%  numa-vmstat.node0.nr_zone_inactive_anon
     48.47 ±100%    -100.0%       0.00        numa-vmstat.node0.nr_zone_inactive_file
    676076           -96.6%      23176 ± 99%  numa-vmstat.node0.nr_zone_unevictable
 4.613e+08 ±  2%    +129.1%  1.057e+09        numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
 4.611e+08 ±  2%    +129.2%  1.057e+09        numa-vmstat.node0.numa_local
     78581 ± 47%     -63.1%      28977 ± 42%  numa-vmstat.node0.numa_other
     36516            +9.5%      39989 ±  6%  numa-vmstat.node1.nr_active_anon
     79.88 ±100%    +105.0%     163.74        numa-vmstat.node1.nr_active_file
     81923 ±  3%     -35.5%      52807 ± 26%  numa-vmstat.node1.nr_anon_pages
     37.02           -50.3%      18.39 ± 52%  numa-vmstat.node1.nr_anon_transparent_hugepages
     46577         +1407.4%     702118 ±  3%  numa-vmstat.node1.nr_file_pages
  24428660            -2.5%   23807665        numa-vmstat.node1.nr_free_pages
     89004 ±  3%     -33.5%      59154 ± 24%  numa-vmstat.node1.nr_inactive_anon
     50.26 ±100%     +91.7%      96.35        numa-vmstat.node1.nr_inactive_file
      2.86 ±100%    -100.0%       0.00        numa-vmstat.node1.nr_isolated_anon
     12795 ±  2%      -5.7%      12060        numa-vmstat.node1.nr_kernel_stack
      7452           +83.7%      13693 ±  2%  numa-vmstat.node1.nr_mapped
      2.77            +0.0%       2.77        numa-vmstat.node1.nr_mlock
      1852           -35.5%       1193 ± 42%  numa-vmstat.node1.nr_page_table_pages
     43623            +5.8%      46134 ±  4%  numa-vmstat.node1.nr_shmem
      7540 ± 10%    +176.4%      20844 ±  4%  numa-vmstat.node1.nr_slab_reclaimable
     30045 ±  8%      -5.2%      28488        numa-vmstat.node1.nr_slab_unreclaimable
      2823 ± 29%  +23126.1%     655723 ±  3%  numa-vmstat.node1.nr_unevictable
     36516            +9.5%      39989 ±  6%  numa-vmstat.node1.nr_zone_active_anon
     79.88 ±100%    +105.0%     163.74        numa-vmstat.node1.nr_zone_active_file
     89005 ±  3%     -33.5%      59154 ± 24%  numa-vmstat.node1.nr_zone_inactive_anon
     50.26 ±100%     +91.7%      96.35        numa-vmstat.node1.nr_zone_inactive_file
      2823 ± 29%  +23126.1%     655723 ±  3%  numa-vmstat.node1.nr_zone_unevictable
 3.264e+08 ± 10%    +223.0%  1.054e+09        numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
 3.259e+08 ± 10%    +223.5%  1.054e+09        numa-vmstat.node1.numa_local
     53882 ± 68%     +92.0%     103462 ± 12%  numa-vmstat.node1.numa_other
     54.00 ±  5%      -0.9%      53.50 ±  6%  proc-vmstat.direct_map_level2_splits
      3.00 ± 33%     +33.3%       4.00 ± 25%  proc-vmstat.direct_map_level3_splits
     44945            -5.8%      42350        proc-vmstat.nr_active_anon
    161.88            +1.1%     163.74        proc-vmstat.nr_active_file
    100932            -0.5%     100476        proc-vmstat.nr_anon_pages
     39.43            +1.3%      39.96 ±  4%  proc-vmstat.nr_anon_transparent_hugepages
   5606101            +0.0%    5607117        proc-vmstat.nr_dirty_background_threshold
  11225910            +0.0%   11227943        proc-vmstat.nr_dirty_threshold
    732499            -0.5%     728939        proc-vmstat.nr_file_pages
  56411216            +0.0%   56421388        proc-vmstat.nr_free_pages
    109272            -1.1%     108084        proc-vmstat.nr_inactive_anon
     98.73            -2.4%      96.35        proc-vmstat.nr_inactive_file
     24948            -1.2%      24644        proc-vmstat.nr_kernel_stack
     18621            -8.8%      16973 ±  5%  proc-vmstat.nr_mapped
      2.79            +0.0%       2.79        proc-vmstat.nr_mlock
      2397            -0.4%       2386        proc-vmstat.nr_page_table_pages
     53338            -6.7%      49779        proc-vmstat.nr_shmem
     28186            -0.5%      28057        proc-vmstat.nr_slab_reclaimable
     64909            -0.4%      64625        proc-vmstat.nr_slab_unreclaimable
    678900            -0.0%     678899        proc-vmstat.nr_unevictable
     44945            -5.8%      42350        proc-vmstat.nr_zone_active_anon
    161.88            +1.1%     163.74        proc-vmstat.nr_zone_active_file
    109272            -1.1%     108084        proc-vmstat.nr_zone_inactive_anon
     98.73            -2.4%      96.35        proc-vmstat.nr_zone_inactive_file
    678900            -0.0%     678899        proc-vmstat.nr_zone_unevictable
     24423 ± 26%      -5.7%      23043 ±  3%  proc-vmstat.numa_hint_faults
     14265 ± 34%     -24.4%      10782 ± 31%  proc-vmstat.numa_hint_faults_local
 7.877e+08 ±  2%    +168.0%  2.111e+09        proc-vmstat.numa_hit
     18.00            +0.0%      18.00        proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  7.87e+08 ±  2%    +168.3%  2.111e+09        proc-vmstat.numa_local
    132463            -0.0%     132440        proc-vmstat.numa_other
      8701            -0.9%       8621 ± 36%  proc-vmstat.numa_pages_migrated
     86479 ± 18%      +4.5%      90373        proc-vmstat.numa_pte_updates
     79724            -3.4%      77014        proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
 7.868e+08 ±  2%    +167.8%  2.107e+09        proc-vmstat.pgalloc_normal
    458741            -0.9%     454690        proc-vmstat.pgfault
 7.867e+08 ±  2%    +167.8%  2.107e+09        proc-vmstat.pgfree
      8701            -0.9%       8621 ± 36%  proc-vmstat.pgmigrate_success
      0.00          -100.0%       0.00        proc-vmstat.pgpgin
     18188 ±  4%      +4.5%      19011 ± 22%  proc-vmstat.pgreuse
     48.00            +8.3%      52.00 ±  7%  proc-vmstat.thp_collapse_alloc
      0.00         +5e+101%       0.50 ±100%  proc-vmstat.thp_deferred_split_page
     24.00            +2.1%      24.50 ±  2%  proc-vmstat.thp_fault_alloc
      7.50 ± 20%     -33.3%       5.00 ± 40%  proc-vmstat.thp_migration_success
      0.00         +5e+101%       0.50 ±100%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      3341            +0.0%       3341        proc-vmstat.unevictable_pgs_culled
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_mlocked
      3.00            +0.0%       3.00        proc-vmstat.unevictable_pgs_munlocked
      0.00          -100.0%       0.00        proc-vmstat.unevictable_pgs_rescued
    778368            -0.6%     773760 ±  2%  proc-vmstat.unevictable_pgs_scanned
      0.57 ±  7%     -97.9%       0.01        perf-stat.i.MPKI
 2.375e+10 ±  2%    +162.1%  6.225e+10        perf-stat.i.branch-instructions
      0.16            -0.0        0.15        perf-stat.i.branch-miss-rate%
  21671842          +104.9%   44401835 ±  3%  perf-stat.i.branch-misses
     22.10 ±  8%      -8.8       13.35        perf-stat.i.cache-miss-rate%
  69187553 ±  4%     -98.4%    1092227 ±  2%  perf-stat.i.cache-misses
 3.089e+08 ±  3%     -96.9%    9661190        perf-stat.i.cache-references
      2950 ±  2%      +5.4%       3110 ±  5%  perf-stat.i.context-switches
      1.97 ±  2%     -61.7%       0.75        perf-stat.i.cpi
    128091            +0.0%     128117        perf-stat.i.cpu-clock
 2.389e+11            +0.0%   2.39e+11        perf-stat.i.cpu-cycles
    181.78            +3.3%     187.70        perf-stat.i.cpu-migrations
      3442 ±  4%  +10605.2%     368536        perf-stat.i.cycles-between-cache-misses
      0.00 ±  2%      -0.0        0.00 ±  3%  perf-stat.i.dTLB-load-miss-rate%
    201135 ±  7%     +67.1%     336024 ±  4%  perf-stat.i.dTLB-load-misses
 3.456e+10 ±  2%    +160.5%  9.003e+10        perf-stat.i.dTLB-loads
      0.00            -0.0        0.00        perf-stat.i.dTLB-store-miss-rate%
     67306           +81.9%     122399        perf-stat.i.dTLB-store-misses
 2.203e+10 ±  2%    +163.6%  5.806e+10        perf-stat.i.dTLB-stores
  1.19e+11 ±  2%    +165.2%  3.156e+11        perf-stat.i.instructions
      0.53 ±  2%    +150.1%       1.33        perf-stat.i.ipc
      0.06 ± 42%     -25.0%       0.04 ± 59%  perf-stat.i.major-faults
      1.87            -0.0%       1.87        perf-stat.i.metric.GHz
    147.49 ± 10%     -46.3%      79.15        perf-stat.i.metric.K/sec
    629.80 ±  2%    +160.8%       1642        perf-stat.i.metric.M/sec
      4806 ±  2%      -1.4%       4738        perf-stat.i.minor-faults
     82.79           +15.8       98.54        perf-stat.i.node-load-miss-rate%
   7729245 ±  3%     -95.9%     318844        perf-stat.i.node-load-misses
   1661082 ± 13%     -99.7%       4701        perf-stat.i.node-loads
     96.66           -34.3       62.40 ± 12%  perf-stat.i.node-store-miss-rate%
   8408062 ± 18%     -97.8%     187945 ± 15%  perf-stat.i.node-store-misses
    266188 ±  3%     -65.0%      93251 ± 22%  perf-stat.i.node-stores
      4806 ±  2%      -1.4%       4738        perf-stat.i.page-faults
    128091            +0.0%     128117        perf-stat.i.task-clock
      0.58 ±  7%     -99.4%       0.00 ±  2%  perf-stat.overall.MPKI
      0.09            -0.0        0.07 ±  3%  perf-stat.overall.branch-miss-rate%
     22.45 ±  8%     -11.5       10.98        perf-stat.overall.cache-miss-rate%
      2.01 ±  2%     -62.3%       0.76        perf-stat.overall.cpi
      3460 ±  4%   +6240.4%     219417 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.00            -0.0        0.00 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.00            -0.0        0.00        perf-stat.overall.dTLB-store-miss-rate%
      0.50 ±  2%    +165.2%       1.32        perf-stat.overall.ipc
     82.39           +16.2       98.57        perf-stat.overall.node-load-miss-rate%
     96.84           -30.2       66.67 ± 12%  perf-stat.overall.node-store-miss-rate%
 2.342e+10 ±  2%    +162.0%  6.137e+10        perf-stat.ps.branch-instructions
  21165789          +105.8%   43553577 ±  3%  perf-stat.ps.branch-misses
  68249764 ±  4%     -98.4%    1074701 ±  2%  perf-stat.ps.cache-misses
 3.049e+08 ±  3%     -96.8%    9783139 ±  2%  perf-stat.ps.cache-references
      2875 ±  2%      +5.9%       3044 ±  5%  perf-stat.ps.context-switches
    125960            +0.0%     125967        perf-stat.ps.cpu-clock
 2.356e+11            -0.0%  2.356e+11        perf-stat.ps.cpu-cycles
    178.88            +2.4%     183.17        perf-stat.ps.cpu-migrations
    210651 ±  2%     +79.6%     378309 ±  4%  perf-stat.ps.dTLB-load-misses
 3.408e+10 ±  2%    +160.4%  8.875e+10        perf-stat.ps.dTLB-loads
     66365           +83.5%     121783        perf-stat.ps.dTLB-store-misses
 2.173e+10 ±  2%    +163.5%  5.724e+10        perf-stat.ps.dTLB-stores
 1.173e+11 ±  2%    +165.2%  3.111e+11        perf-stat.ps.instructions
      0.06 ± 42%     -28.5%       0.04 ± 60%  perf-stat.ps.major-faults
      4733 ±  2%      -1.8%       4649        perf-stat.ps.minor-faults
   7629849 ±  3%     -95.8%     317156 ±  2%  perf-stat.ps.node-load-misses
   1639040 ± 13%     -99.7%       4598        perf-stat.ps.node-loads
   8293657 ± 18%     -97.8%     185047 ± 16%  perf-stat.ps.node-store-misses
    263181 ±  4%     -65.4%      91130 ± 22%  perf-stat.ps.node-stores
      4733 ±  2%      -1.8%       4649        perf-stat.ps.page-faults
    125960            +0.0%     125966        perf-stat.ps.task-clock
 7.465e+12 ±  2%    +165.5%  1.982e+13        perf-stat.total.instructions
      1912        +56665.9%    1085563 ± 99%  sched_debug.cfs_rq:/.avg_vruntime.avg
     12690 ±  4%  +11390.8%    1458273 ± 98%  sched_debug.cfs_rq:/.avg_vruntime.max
     53.23 ± 19%  +21837.0%      11676 ± 99%  sched_debug.cfs_rq:/.avg_vruntime.min
      2780        +14828.8%     415155 ± 99%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.12 ± 25%    +125.0%       0.28 ± 55%  sched_debug.cfs_rq:/.h_nr_running.avg
      2.00 ± 50%     -50.0%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.36 ± 18%      -2.2%       0.35 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
      1.88 ± 99%    -100.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.avg
    240.81 ± 99%    -100.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.min
     21.20 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.left_vruntime.stddev
     10324 ± 83%     -63.3%       3793 ± 36%  sched_debug.cfs_rq:/.load.avg
   1078332 ± 96%     -97.0%      32285 ± 35%  sched_debug.cfs_rq:/.load.max
     96021 ± 93%     -93.6%       6192 ± 13%  sched_debug.cfs_rq:/.load.stddev
      2211 ± 65%     -78.0%     486.43 ± 56%  sched_debug.cfs_rq:/.load_avg.avg
     88390           -66.2%      29873 ± 48%  sched_debug.cfs_rq:/.load_avg.max
     12036 ± 36%     -71.4%       3445 ± 59%  sched_debug.cfs_rq:/.load_avg.stddev
      1912        +56666.1%    1085563 ± 99%  sched_debug.cfs_rq:/.min_vruntime.avg
     12690 ±  4%  +11390.8%    1458273 ± 98%  sched_debug.cfs_rq:/.min_vruntime.max
     53.23 ± 19%  +21837.0%      11676 ± 99%  sched_debug.cfs_rq:/.min_vruntime.min
      2780        +14828.7%     415155 ± 99%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.12 ± 25%    +125.0%       0.28 ± 55%  sched_debug.cfs_rq:/.nr_running.avg
      2.00 ± 50%     -50.0%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.36 ± 18%      -2.2%       0.35 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
    410.09 ± 82%     -91.8%      33.57 ± 17%  sched_debug.cfs_rq:/.removed.load_avg.avg
     44892 ± 97%     -98.3%     768.00 ± 33%  sched_debug.cfs_rq:/.removed.load_avg.max
      4035 ± 93%     -96.1%     155.41 ± 25%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     28.03 ± 15%     -49.5%      14.16 ± 11%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    525.00           -25.4%     391.50 ± 32%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    110.15 ±  8%     -39.5%      66.68 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     28.02 ± 15%     -49.5%      14.16 ± 11%  sched_debug.cfs_rq:/.removed.util_avg.avg
    525.00           -25.4%     391.50 ± 32%  sched_debug.cfs_rq:/.removed.util_avg.max
    110.13 ±  8%     -39.5%      66.68 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      1.88 ± 99%    -100.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.avg
    240.92 ± 99%    -100.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.min
     21.21 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.right_vruntime.stddev
    280.12 ±  2%     +38.8%     388.72 ± 34%  sched_debug.cfs_rq:/.runnable_avg.avg
      1243 ±  8%      -0.3%       1239 ± 11%  sched_debug.cfs_rq:/.runnable_avg.max
    321.04 ±  3%      +5.1%     337.27 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.avg
      0.11 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.max
      0.01 ±100%    -100.0%       0.00        sched_debug.cfs_rq:/.spread.stddev
    278.43 ±  2%     +39.2%     387.54 ± 34%  sched_debug.cfs_rq:/.util_avg.avg
      1242 ±  8%      -0.2%       1239 ± 11%  sched_debug.cfs_rq:/.util_avg.max
    319.84 ±  3%      +5.2%     336.35 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
     29.61 ± 17%    +203.8%      89.96 ± 64%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    826.50            -9.4%     748.75 ± 10%  sched_debug.cfs_rq:/.util_est_enqueued.max
    120.67 ±  8%     +22.4%     147.72 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    847909            +3.7%     879071        sched_debug.cpu.avg_idle.avg
   1049554 ±  4%      -4.7%    1000000        sched_debug.cpu.avg_idle.max
      4595 ± 24%    +177.9%      12771 ± 65%  sched_debug.cpu.avg_idle.min
    238818 ±  5%     -14.5%     204207        sched_debug.cpu.avg_idle.stddev
     52188 ±  2%     +38.6%      72309 ± 21%  sched_debug.cpu.clock.avg
     52194 ±  2%     +38.6%      72316 ± 21%  sched_debug.cpu.clock.max
     52179 ±  2%     +38.6%      72300 ± 21%  sched_debug.cpu.clock.min
      3.53           +12.7%       3.98 ±  9%  sched_debug.cpu.clock.stddev
     52058 ±  2%     +38.4%      72031 ± 20%  sched_debug.cpu.clock_task.avg
     52183 ±  2%     +38.3%      72170 ± 20%  sched_debug.cpu.clock_task.max
     44318 ±  2%     +44.9%      64224 ± 23%  sched_debug.cpu.clock_task.min
    694.52            +1.2%     702.85        sched_debug.cpu.clock_task.stddev
    446.71 ± 17%    +204.4%       1359 ± 63%  sched_debug.cpu.curr->pid.avg
      4227           +14.3%       4831 ± 12%  sched_debug.cpu.curr->pid.max
      1253 ±  8%     +21.9%       1528 ± 13%  sched_debug.cpu.curr->pid.stddev
    500332            -0.1%     500000        sched_debug.cpu.max_idle_balance_cost.avg
    542508 ±  2%      -7.8%     500000        sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
      3742 ± 28%    -100.0%       0.00        sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ±  2%     -16.8%       0.00 ± 16%  sched_debug.cpu.next_balance.stddev
      0.12 ± 26%    +140.0%       0.28 ± 55%  sched_debug.cpu.nr_running.avg
      2.00 ± 50%     -50.0%       1.00        sched_debug.cpu.nr_running.max
      0.35 ± 19%      +0.3%       0.35 ±  5%  sched_debug.cpu.nr_running.stddev
      1738 ±  2%     +26.0%       2190 ± 18%  sched_debug.cpu.nr_switches.avg
     45570            -8.1%      41889 ± 27%  sched_debug.cpu.nr_switches.max
    135.50 ± 15%     +65.5%     224.25 ± 32%  sched_debug.cpu.nr_switches.min
      4624 ±  2%      +6.1%       4908 ±  9%  sched_debug.cpu.nr_switches.stddev
     52184 ±  2%     +38.6%      72304 ± 21%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
     50954 ±  2%     +39.5%      71075 ± 21%  sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
     53048 ±  2%     +38.1%      73236 ± 20%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_base_slice
  25056823            +0.0%   25056823        sched_debug.sysctl_sched.sysctl_sched_features
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      0.00          +3e+99%       0.00 ±100%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      0.01 ± 22%      +5.6%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±100%     +57.1%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 17%     -35.3%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.01            +8.3%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 17%     -17.6%       0.01        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ±  7%  +2.3e+05%      15.16 ± 99%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ± 11%      +0.0%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ±  4%     +19.0%       0.01 ± 36%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00        +1.5e+99%       0.00 ±100%  perf-sched.sch_delay.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      6.18 ± 34%    +245.2%      21.34 ± 43%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 14%     -14.3%       0.01        perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 20%     -20.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 26%    +163.2%       0.02 ± 56%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ±  5%     -29.4%       0.01        perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00        +1.5e+99%       0.00 ±100%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cgroup_kn_lock_live
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.00        +6.5e+99%       0.01 ±100%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
      0.01 ±100%     -55.0%       0.00 ±100%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.02 ± 60%     -43.3%       0.01 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 16%      -8.3%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 52%    +170.6%       0.02 ± 82%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.tty_wait_until_sent.tty_port_close_start.tty_port_close
      0.01 ±  7%      -7.7%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±  5%     +10.5%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±  7%     -30.8%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2.74 ± 98%     -96.6%       0.09 ±  2%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00          +3e+99%       0.00 ±100%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
      0.01 ± 48%     -44.4%       0.01 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ±  2%     -34.3%       0.01 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±100%     +75.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 33%     -66.7%       0.01        perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.01           +29.2%       0.02 ± 22%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  3%     -11.1%       0.01 ±  8%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.02 ± 17%  +2.9e+06%     500.11 ± 99%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ± 11%      -2.9%       0.02 ± 27%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.05 ± 47%    +740.6%       0.45 ± 95%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 15%     +26.9%       0.02 ± 21%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00        +1.5e+99%       0.00 ±100%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      1002            +0.1%       1003        perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±  3%     -51.5%       0.01        perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  5%     -47.1%       0.01 ± 22%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 30%    +303.8%       0.05 ± 73%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.02           -56.8%       0.01 ±  5%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00          +8e+99%       0.01 ±100%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cgroup_kn_lock_live
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.kthread.ret_from_fork.ret_from_fork_asm
      0.00        +6.5e+99%       0.01 ±100%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
      0.02 ±100%     -80.9%       0.00 ±100%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.00 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_killable.__kthread_create_on_node
      0.52 ± 96%     -78.6%       0.11 ±  9%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 37%     -48.9%       0.01 ±  4%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      2.51 ± 99%    +119.0%       5.51 ± 99%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.tty_wait_until_sent.tty_port_close_start.tty_port_close
      0.03 ± 29%     -43.5%       0.02 ± 31%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 25%      +4.2%       0.01 ± 12%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.02 ± 40%     -67.6%       0.01        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    801.97 ± 99%     -99.5%       4.00        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.56 ± 54%     +65.6%       0.93 ± 18%  perf-sched.total_sch_delay.average.ms
      1300 ± 23%     -22.8%       1003        perf-sched.total_sch_delay.max.ms
    225.44           -25.2%     168.57 ± 47%  perf-sched.total_wait_and_delay.average.ms
      4145           +57.2%       6518 ± 43%  perf-sched.total_wait_and_delay.count.ms
      4925           -24.5%       3720 ± 31%  perf-sched.total_wait_and_delay.max.ms
    224.88           -25.5%     167.64 ± 48%  perf-sched.total_wait_time.average.ms
      4925           -24.5%       3720 ± 31%  perf-sched.total_wait_time.max.ms
      0.00       +1.4e+100%       0.01 ±100%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
     11.94            -6.7%      11.14 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ±100%     -23.1%       0.02 ±100%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.00       +1.4e+100%       0.01 ±100%  perf-sched.wait_and_delay.avg.ms.__cond_resched.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
    435.70 ± 14%     -70.3%     129.43 ±100%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    799.59            +0.0%     799.59        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    562.97 ± 11%     -11.2%     500.03        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    743.65            +3.8%     772.28 ±  5%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.78 ± 52%     +37.1%      40.81 ± 25%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.45 ±  3%     -21.9%       0.35 ±  3%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 16%     -31.2%       0.03 ±  5%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    283.17            +2.5%     290.38 ±  7%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    536.23 ±  6%     +14.6%     614.32 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    291.41 ± 30%     +26.4%     368.24        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +9.8e+100%       0.10 ±100%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00       +5.9e+104%     592.95 ±100%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
    145.35 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
    115.31 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.83 ± 11%    +855.9%       7.95 ± 92%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.62            -0.0%     453.57        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      8.16 ±  7%    +109.7%      17.11        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    669.80            -2.3%     654.65 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 14%     -64.3%       0.00 ±100%  perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    461.67            +4.7%     483.54 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00       +1.4e+103%      14.00 ±100%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
    768.00            -8.3%     704.50 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     11.00 ±100%     +68.2%      18.50 ±100%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.00       +2.4e+103%      24.00 ±100%  perf-sched.wait_and_delay.count.__cond_resched.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
     10.00 ± 40%     -60.0%       4.00 ±100%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.00            +0.0%       5.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      8.00           -25.0%       6.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     37.00            -8.1%      34.00 ±  2%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.50            -6.8%      82.50 ±  5%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    123.50 ±  2%      -8.1%     113.50 ±  2%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    691.50           -28.9%     491.50 ±  7%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    245.00            -2.2%     239.50 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.50 ±  6%      -4.4%      21.50 ±  2%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     23.50 ± 44%     -44.7%      13.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00         +3e+105%       2964 ±100%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00         +5e+101%       0.50 ±100%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
      1.00 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      1.50 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
     88.00            -8.0%      81.00 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     20.00            +0.0%      20.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    610.00 ±  7%     -52.8%     288.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    971.00 ±  2%      -9.2%     881.50 ±  7%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     36.50           -57.5%      15.50 ±100%  perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open
    282.00 ±  6%      +5.9%     298.50 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00       +2.9e+100%       0.03 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
      4925           -25.4%       3673 ± 33%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ±100%     -23.4%       0.02 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.00         +3e+100%       0.03 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
      2045 ± 45%     -75.6%     498.97 ±100%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    999.52            +0.0%     999.53        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1000           +76.9%       1769 ± 43%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
    984.18           +63.5%       1609 ± 24%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.77 ±  6%     -12.9%       1.54 ± 20%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.30 ± 37%     -54.2%       0.14 ± 16%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1533 ± 30%     +30.7%       2004        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1000           +54.6%       1547 ± 35%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1258 ± 60%     -60.3%     499.99        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +1.1e+101%       0.11 ±100%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00       +5.9e+104%     592.95 ±100%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
    290.69 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
    249.99 ±100%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      2.86 ± 19%  +21211.2%     608.43 ± 99%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    505.00            -0.1%     504.50        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    512.50 ± 19%      -8.4%     469.51 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2568 ± 19%     -39.3%       1560 ± 31%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 40%     -83.8%       0.00 ±100%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2722 ±  5%     -17.7%       2241 ±  5%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00         +3e+100%       0.03 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
      0.03          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.00       +2.8e+100%       0.03 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.copy_splice_read.splice_file_to_pipe
      0.02 ± 29%     +58.3%       0.04 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
     11.94            -6.7%      11.14 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.05 ± 21%     -36.0%       0.03 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.04 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.00         +3e+100%       0.03 ± 52%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_file_to_pipe.do_splice.__do_splice
      0.06 ± 43%     -45.4%       0.04 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      0.06 ± 16%     -65.3%       0.02 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice
      0.00       +2.6e+100%       0.03 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
    435.69 ± 14%     -70.3%     129.43 ±100%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    799.58            +0.0%     799.59        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.47 ±  2%     -24.3%       1.87 ±  3%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    562.96 ± 11%     -11.2%     500.03        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    743.64            +1.8%     757.11 ±  7%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.77 ± 52%     +37.1%      40.81 ± 25%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.44 ±  3%     -22.9%       0.34 ±  4%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.04 ± 16%     -31.2%       0.03 ±  5%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.42 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00         +1e+101%       0.10 ±100%  perf-sched.wait_time.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
    276.99            -2.9%     269.04 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.92 ±  7%     -13.9%       2.52 ± 10%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    536.22 ±  6%     +14.6%     614.32 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    291.40 ± 30%     +26.4%     368.23        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +9.6e+100%       0.10 ±100%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00       +5.9e+104%     592.95 ±100%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
    145.35 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      1.10 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
    115.30 ±100%    -100.0%       0.01 ±100%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.01 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      0.82 ± 10%    +872.5%       7.94 ± 92%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.61            -0.0%     453.57        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      8.15 ±  7%    +109.7%      17.09        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9.38 ±100%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.tty_wait_until_sent.tty_port_close_start.tty_port_close
    669.79            -2.3%     654.65 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.48 ±  2%     -24.3%       1.88 ±  3%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ±100%      +0.0%       0.00 ±100%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    458.93 ±  2%      +5.3%     483.45 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00       +5.1e+100%       0.05 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
      0.07          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.00       +4.6e+100%       0.05 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.copy_splice_read.splice_file_to_pipe
      0.05            -8.4%       0.04        perf-sched.wait_time.max.ms.__cond_resched.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      4925           -25.4%       3673 ± 33%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.23 ± 72%     -79.1%       0.05        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.07 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.00       +1.1e+101%       0.11 ± 60%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_file_to_pipe.do_splice.__do_splice
      0.23 ± 75%     -63.8%       0.08 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_from_pipe.do_splice.__do_splice
      0.16           -73.6%       0.04 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice
      0.00       +5.5e+100%       0.06 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
      2045 ± 45%     -75.6%     498.96 ±100%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    999.51            +0.0%     999.52        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.95 ±  2%     -24.3%       3.74 ±  3%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            -0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1000           +76.9%       1768 ± 43%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.__x64_sys_exit.do_syscall_64.entry_SYSCALL_64_after_hwframe
    984.18           +63.5%       1609 ± 24%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.75 ±  6%     -35.0%       1.14 ±  5%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.30 ± 37%     -54.2%       0.14 ± 16%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.06 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.00         +1e+101%       0.10 ±100%  perf-sched.wait_time.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      1059            +0.0%       1059        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.99            -9.9%       4.49 ± 11%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1000           +54.6%       1547 ± 35%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1258 ± 60%     -60.3%     499.98        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +1.0e+101%       0.10 ±100%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.usleep_range_state.ipmi_thread.kthread
      0.00       +5.9e+104%     592.95 ±100%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu._ipmi_destroy_user
    290.68 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_connector_destroy_workfn
      1.10 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.fsnotify_mark_destroy_workfn
    249.99 ±100%    -100.0%       0.01 ±100%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__wait_rcu_gp.synchronize_rcu
      0.02 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr
      2.33 ±  2%  +25962.4%     608.43 ± 99%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    504.99            -0.1%     504.50        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    512.49 ± 19%      -8.4%     469.50 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    105.74 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.tty_wait_until_sent.tty_port_close_start.tty_port_close
      2568 ± 19%     -39.3%       1560 ± 31%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.97 ±  2%     -24.3%       3.76 ±  3%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ±100%     -45.0%       0.01 ±100%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2720 ±  5%     -17.6%       2241 ±  5%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     51.54           -51.5        0.00        perf-profile.calltrace.cycles-pp.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
     51.45           -51.4        0.00        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe.do_splice
     51.12           -51.1        0.00        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe.splice_from_pipe
     53.42           -50.0        3.44        perf-profile.calltrace.cycles-pp.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice
     54.16           -49.1        5.02        perf-profile.calltrace.cycles-pp.splice_from_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
     48.88           -48.9        0.00        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe
     68.02           -28.8       39.20        perf-profile.calltrace.cycles-pp.do_splice.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
     69.56           -25.6       43.96        perf-profile.calltrace.cycles-pp.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     73.24           -18.1       55.15        perf-profile.calltrace.cycles-pp.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     75.82           -13.2       62.66        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     10.86           -10.9        0.00        perf-profile.calltrace.cycles-pp.write
     77.52           -10.1       67.40        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.splice
     10.10           -10.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      9.96           -10.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      9.72            -9.7        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      9.44            -9.4        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.60            -8.6        0.00        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.62 ±  3%      -5.6        0.00        perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put
      4.94            -4.9        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.pipe_write.vfs_write.ksys_write.do_syscall_64
      3.58            -3.6        0.00        perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages.pipe_write.vfs_write.ksys_write
      1.74            -1.7        0.00        perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_pages.pipe_write.vfs_write
      1.19 ±  5%      -1.2        0.00        perf-profile.calltrace.cycles-pp.memcg_account_kmem.uncharge_batch.__mem_cgroup_uncharge.__folio_put.__splice_from_pipe
      1.14 ±  3%      -1.1        0.00        perf-profile.calltrace.cycles-pp.memcg_account_kmem.__memcg_kmem_charge_page.__alloc_pages.pipe_write.vfs_write
      0.97 ±  3%      -1.0        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.pipe_write.vfs_write.ksys_write
      0.94            -0.9        0.00        perf-profile.calltrace.cycles-pp.page_counter_try_charge.try_charge_memcg.__memcg_kmem_charge_page.__alloc_pages.pipe_write
      0.86            -0.9        0.00        perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.75 ±  2%      -0.8        0.00        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.pipe_write.vfs_write
      0.74            -0.7        0.00        perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write.ksys_write
      3.48 ±  7%      -0.6        2.84        perf-profile.calltrace.cycles-pp.mutex_unlock.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.54 ±  4%      -0.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.pipe_write.vfs_write.ksys_write.do_syscall_64
      0.54            -0.5        0.00        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.copy_page_from_iter.pipe_write.vfs_write
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_trylock.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice
      2.18 ±  2%      +0.1        2.33        perf-profile.calltrace.cycles-pp.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.free_unref_page_prepare.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.kill_fasync.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.security_file_permission.vfs_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__kmem_cache_free.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.splice_pipe_to_pipe.do_splice.__do_splice
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.__cond_resched.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.security_file_permission.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      0.95 ±  3%      +0.6        1.58        perf-profile.calltrace.cycles-pp.free_unref_page.__splice_from_pipe.splice_from_pipe.do_splice.__do_splice
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.get_pipe_info.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      0.00            +0.8        0.75        perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_splice_read.splice_file_to_pipe.do_splice.__do_splice
      1.60            +0.8        2.40        perf-profile.calltrace.cycles-pp.mutex_lock.pipe_double_lock.splice_pipe_to_pipe.do_splice.__do_splice
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.stress_splice_looped_pipe
      0.62 ±  5%      +0.9        1.54        perf-profile.calltrace.cycles-pp.stress_splice
      0.00            +1.0        1.02        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.splice
      0.00            +1.1        1.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.splice
      0.26 ±100%      +1.2        1.44        perf-profile.calltrace.cycles-pp.stress_splice_flag
      0.00            +1.3        1.26 ±  2%  perf-profile.calltrace.cycles-pp.__fdget.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +1.3        1.26        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.__alloc_pages_bulk.copy_splice_read
      1.88            +1.3        3.17        perf-profile.calltrace.cycles-pp.pipe_double_lock.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.66            +1.3        1.96        perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.00            +1.3        1.33        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
      0.63 ±  3%      +1.3        1.96        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.splice
      0.00            +1.4        1.38        perf-profile.calltrace.cycles-pp.iov_iter_zero.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice
      0.00            +1.4        1.40        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.copy_splice_read.splice_file_to_pipe.do_splice
      0.00            +1.6        1.62        perf-profile.calltrace.cycles-pp.read_iter_zero.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.00            +1.7        1.68        perf-profile.calltrace.cycles-pp.__fsnotify_parent.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      0.00            +1.7        1.71        perf-profile.calltrace.cycles-pp.__kmalloc.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      0.00            +1.8        1.84        perf-profile.calltrace.cycles-pp.get_pipe_info.__do_splice.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.71 ±  4%      +1.9        2.60        perf-profile.calltrace.cycles-pp.stress_mwc1
      0.00            +1.9        1.91        perf-profile.calltrace.cycles-pp.vfs_splice_read.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.00            +1.9        1.93        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe
      1.10 ±  2%      +2.3        3.38        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     11.77 ±  3%      +2.4       14.20        perf-profile.calltrace.cycles-pp.splice_pipe_to_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      0.00            +2.8        2.85        perf-profile.calltrace.cycles-pp.__alloc_pages.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe.do_splice
      0.00            +3.3        3.31        perf-profile.calltrace.cycles-pp.__alloc_pages_bulk.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice
      2.16 ±  4%      +4.1        6.25        perf-profile.calltrace.cycles-pp.__fget_light.__x64_sys_splice.do_syscall_64.entry_SYSCALL_64_after_hwframe.splice
     86.87            +7.0       93.85        perf-profile.calltrace.cycles-pp.splice
      0.00            +9.1        9.13        perf-profile.calltrace.cycles-pp.copy_splice_read.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice
      0.00           +12.8       12.75        perf-profile.calltrace.cycles-pp.splice_file_to_pipe.do_splice.__do_splice.__x64_sys_splice.do_syscall_64
      6.26 ±  3%     +12.8       19.04        perf-profile.calltrace.cycles-pp.__entry_text_start.splice
     51.47           -51.3        0.14 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     51.56           -51.2        0.38        perf-profile.children.cycles-pp.__folio_put
     51.18           -51.2        0.00        perf-profile.children.cycles-pp.uncharge_batch
     53.46           -49.9        3.58        perf-profile.children.cycles-pp.__splice_from_pipe
     54.20           -49.1        5.12        perf-profile.children.cycles-pp.splice_from_pipe
     48.92           -48.9        0.00        perf-profile.children.cycles-pp.page_counter_uncharge
     68.27           -28.3       40.02        perf-profile.children.cycles-pp.do_splice
     69.98           -24.7       45.28        perf-profile.children.cycles-pp.__do_splice
     86.38           -22.2       64.19        perf-profile.children.cycles-pp.do_syscall_64
     87.75           -20.1       67.69        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     73.60           -17.6       55.98        perf-profile.children.cycles-pp.__x64_sys_splice
     11.11           -11.1        0.00        perf-profile.children.cycles-pp.write
      9.76            -9.8        0.00        perf-profile.children.cycles-pp.ksys_write
      9.49            -9.5        0.00        perf-profile.children.cycles-pp.vfs_write
      8.68            -8.7        0.00        perf-profile.children.cycles-pp.pipe_write
      5.73 ±  2%      -5.7        0.00        perf-profile.children.cycles-pp.propagate_protected_usage
      3.62            -3.6        0.00        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      2.36 ±  4%      -2.4        0.00        perf-profile.children.cycles-pp.memcg_account_kmem
      4.98            -2.0        2.94        perf-profile.children.cycles-pp.__alloc_pages
      1.74            -1.7        0.00        perf-profile.children.cycles-pp.try_charge_memcg
      0.94            -0.9        0.00        perf-profile.children.cycles-pp.page_counter_try_charge
      0.89            -0.9        0.00        perf-profile.children.cycles-pp.copy_page_from_iter
      0.76            -0.8        0.00        perf-profile.children.cycles-pp._copy_from_iter
      0.58            -0.6        0.00        perf-profile.children.cycles-pp.copyin
      0.56 ±  4%      -0.6        0.00        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.54            -0.5        0.00        perf-profile.children.cycles-pp.__wake_up_common_lock
      0.47            -0.5        0.00        perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      4.18 ±  6%      -0.5        3.71        perf-profile.children.cycles-pp.mutex_unlock
      0.37 ±  2%      -0.4        0.00        perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.33            -0.3        0.00        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  3%      -0.3        0.00        perf-profile.children.cycles-pp.__count_memcg_events
      0.26            -0.3        0.00        perf-profile.children.cycles-pp.alloc_pages
      0.26            -0.3        0.00        perf-profile.children.cycles-pp.file_update_time
      0.24 ±  2%      -0.2        0.00        perf-profile.children.cycles-pp.uncharge_folio
      0.97 ±  3%      -0.2        0.75        perf-profile.children.cycles-pp._raw_spin_trylock
      0.22 ±  2%      -0.2        0.00        perf-profile.children.cycles-pp.inode_needs_update_time
      0.18 ±  2%      -0.2        0.00        perf-profile.children.cycles-pp.__fdget_pos
      0.12            -0.1        0.00        perf-profile.children.cycles-pp.memcg_check_events
      0.09            -0.1        0.00        perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.09            -0.1        0.00        perf-profile.children.cycles-pp.policy_node
      0.08            -0.1        0.00        perf-profile.children.cycles-pp.timestamp_truncate
      0.08 ±  6%      -0.1        0.00        perf-profile.children.cycles-pp.__wake_up_common
      0.29 ±  3%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.29 ±  3%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.29 ±  3%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.29 ±  3%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp.do_idle
      0.28            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.06            -0.1        0.00        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.26            -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.26            -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.26            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.26            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.14 ±  3%      -0.0        0.14        perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.10 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.35 ±  2%      +0.0        0.35 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.25            +0.0        0.25        perf-profile.children.cycles-pp.scheduler_tick
      0.14 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.perf_event_task_tick
      0.28            +0.0        0.28        perf-profile.children.cycles-pp.tick_sched_handle
      0.28            +0.0        0.28        perf-profile.children.cycles-pp.update_process_times
      0.30 ±  3%      +0.0        0.31 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.02 ±100%      +0.0        0.05        perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.should_fail_alloc_page
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.splice_write_null
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid_or_report
      0.07            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.splice_from_pipe_next
      0.06 ±  9%      +0.1        0.15        perf-profile.children.cycles-pp.__page_cache_release
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.iov_iter_bvec
      0.06            +0.1        0.18        perf-profile.children.cycles-pp.__list_del_entry_valid_or_report
      0.00            +0.1        0.12        perf-profile.children.cycles-pp.kmalloc_slab
      0.07 ± 14%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.wait_for_space
      0.00            +0.1        0.14        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.1        0.14        perf-profile.children.cycles-pp.pipe_lock
      0.08            +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.rw_verify_area
      0.08 ±  6%      +0.2        0.23 ±  4%  perf-profile.children.cycles-pp.get_pfnblock_flags_mask
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.fsnotify_perm
      0.12 ±  4%      +0.2        0.32        perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.kfree
      0.00            +0.3        0.27        perf-profile.children.cycles-pp.memset_orig
      0.16 ±  6%      +0.3        0.46        perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.3        0.32        perf-profile.children.cycles-pp.generic_pipe_buf_release
      0.18 ±  5%      +0.4        0.54 ±  2%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.20 ±  2%      +0.4        0.58        perf-profile.children.cycles-pp.splice@plt
      0.22 ±  2%      +0.5        0.68 ±  2%  perf-profile.children.cycles-pp.pipe_unlock
      0.24 ±  4%      +0.5        0.74        perf-profile.children.cycles-pp.pipe_clear_nowait
      0.43            +0.5        0.97        perf-profile.children.cycles-pp.apparmor_file_permission
      0.78 ±  3%      +0.6        1.34        perf-profile.children.cycles-pp.rmqueue
      0.30 ±  5%      +0.6        0.87        perf-profile.children.cycles-pp.kill_fasync
      0.00            +0.6        0.58        perf-profile.children.cycles-pp.__kmem_cache_free
      0.30            +0.6        0.89        perf-profile.children.cycles-pp.rcu_all_qs
      0.34            +0.7        1.03        perf-profile.children.cycles-pp.__fdget
      0.98 ±  3%      +0.7        1.68        perf-profile.children.cycles-pp.free_unref_page
      0.45 ±  6%      +0.7        1.14        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.46 ±  3%      +0.7        1.19        perf-profile.children.cycles-pp.stress_splice_looped_pipe
      0.54            +0.8        1.30        perf-profile.children.cycles-pp.security_file_permission
      0.46 ±  2%      +0.8        1.28        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      1.00 ±  3%      +1.0        1.98        perf-profile.children.cycles-pp.get_page_from_freelist
      0.58 ±  3%      +1.0        1.60        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.86 ±  5%      +1.4        2.21        perf-profile.children.cycles-pp.stress_splice
      0.00            +1.4        1.40        perf-profile.children.cycles-pp.iov_iter_zero
      0.81            +1.4        2.22        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.84 ±  2%      +1.4        2.25        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.95            +1.4        3.37        perf-profile.children.cycles-pp.pipe_double_lock
      0.73 ±  4%      +1.5        2.20        perf-profile.children.cycles-pp.stress_splice_flag
      0.00            +1.5        1.50        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.85            +1.5        2.38        perf-profile.children.cycles-pp.__cond_resched
      4.48            +1.6        6.08        perf-profile.children.cycles-pp.mutex_lock
      0.86 ±  4%      +1.7        2.52        perf-profile.children.cycles-pp.stress_mwc1
      0.00            +1.7        1.66        perf-profile.children.cycles-pp.read_iter_zero
      0.00            +1.8        1.79        perf-profile.children.cycles-pp.__kmalloc
      0.85 ±  3%      +1.8        2.66        perf-profile.children.cycles-pp.get_pipe_info
      0.00            +2.0        1.95        perf-profile.children.cycles-pp.vfs_splice_read
      0.32            +2.2        2.48        perf-profile.children.cycles-pp.__fsnotify_parent
      1.57 ±  2%      +2.8        4.37        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     12.04 ±  2%      +2.9       14.98        perf-profile.children.cycles-pp.splice_pipe_to_pipe
      0.00            +3.4        3.36        perf-profile.children.cycles-pp.__alloc_pages_bulk
      2.44 ±  4%      +4.2        6.68        perf-profile.children.cycles-pp.__fget_light
      3.46 ±  3%      +5.9        9.32        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     86.88            +6.9       93.80        perf-profile.children.cycles-pp.splice
      4.12 ±  4%      +7.0       11.08        perf-profile.children.cycles-pp.__entry_text_start
      0.00            +9.3        9.29        perf-profile.children.cycles-pp.copy_splice_read
      0.00           +12.9       12.88        perf-profile.children.cycles-pp.splice_file_to_pipe
     43.14           -43.1        0.00        perf-profile.self.cycles-pp.page_counter_uncharge
      5.69 ±  2%      -5.7        0.00        perf-profile.self.cycles-pp.propagate_protected_usage
      2.27 ±  4%      -2.3        0.00        perf-profile.self.cycles-pp.memcg_account_kmem
      0.86            -0.9        0.00        perf-profile.self.cycles-pp.page_counter_try_charge
      0.78 ±  2%      -0.8        0.00        perf-profile.self.cycles-pp.try_charge_memcg
      0.64 ±  5%      -0.6        0.00        perf-profile.self.cycles-pp.uncharge_batch
      4.08 ±  6%      -0.6        3.49        perf-profile.self.cycles-pp.mutex_unlock
      0.57            -0.6        0.00        perf-profile.self.cycles-pp.copyin
      0.54 ±  4%      -0.5        0.00        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.48            -0.5        0.00        perf-profile.self.cycles-pp.pipe_write
      0.46            -0.5        0.00        perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.46            -0.5        0.00        perf-profile.self.cycles-pp.vfs_write
      0.37 ±  2%      -0.4        0.00        perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.32            -0.3        0.00        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.30 ±  3%      -0.3        0.00        perf-profile.self.cycles-pp.__count_memcg_events
      0.27 ±  7%      -0.3        0.00        perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.26            -0.3        0.00        perf-profile.self.cycles-pp.write
      0.94 ±  3%      -0.3        0.68        perf-profile.self.cycles-pp._raw_spin_trylock
      0.22 ±  2%      -0.2        0.00        perf-profile.self.cycles-pp.uncharge_folio
      0.18 ±  2%      -0.2        0.00        perf-profile.self.cycles-pp._copy_from_iter
      0.14 ±  3%      -0.1        0.00        perf-profile.self.cycles-pp.alloc_pages
      0.13            -0.1        0.00        perf-profile.self.cycles-pp.copy_page_from_iter
      0.11            -0.1        0.00        perf-profile.self.cycles-pp.__wake_up_common_lock
      0.10            -0.1        0.00        perf-profile.self.cycles-pp.inode_needs_update_time
      0.10 ±  5%      -0.1        0.00        perf-profile.self.cycles-pp.ksys_write
      0.09            -0.1        0.00        perf-profile.self.cycles-pp.memcg_check_events
      0.07            -0.1        0.00        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.07            -0.1        0.00        perf-profile.self.cycles-pp.timestamp_truncate
      0.06 ±  9%      -0.1        0.00        perf-profile.self.cycles-pp.__wake_up_common
      0.12 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.acpi_safe_halt
      0.05            -0.0        0.02 ±100%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.02 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.file_update_time
      0.02 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.policy_node
      0.10 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.07            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__mem_cgroup_uncharge
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__list_add_valid_or_report
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.pipe_lock
      0.06 ±  7%      +0.1        0.15        perf-profile.self.cycles-pp.splice_from_pipe_next
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.iov_iter_bvec
      0.06 ±  9%      +0.1        0.14        perf-profile.self.cycles-pp.__page_cache_release
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__folio_put
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.kmalloc_slab
      0.06            +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.rw_verify_area
      0.06 ±  7%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.05            +0.1        0.16        perf-profile.self.cycles-pp.__list_del_entry_valid_or_report
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.wait_for_space
      0.00            +0.1        0.12        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.06 ±  7%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.get_pfnblock_flags_mask
      0.10            +0.2        0.27        perf-profile.self.cycles-pp.aa_file_perm
      0.08 ±  5%      +0.2        0.26        perf-profile.self.cycles-pp.splice@plt
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.fsnotify_perm
      0.10 ±  4%      +0.2        0.30        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      0.00            +0.2        0.21 ±  4%  perf-profile.self.cycles-pp.kfree
      0.13            +0.2        0.36 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.14 ±  3%      +0.2        0.37        perf-profile.self.cycles-pp.free_unref_page
      0.12 ±  4%      +0.2        0.37 ±  2%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.2        0.25        perf-profile.self.cycles-pp.memset_orig
      0.00            +0.3        0.26        perf-profile.self.cycles-pp.read_iter_zero
      0.14 ±  3%      +0.3        0.40        perf-profile.self.cycles-pp.__fdget
      0.13            +0.3        0.40        perf-profile.self.cycles-pp.pipe_unlock
      0.16 ±  3%      +0.3        0.45 ±  2%  perf-profile.self.cycles-pp.kill_fasync
      0.00            +0.3        0.30        perf-profile.self.cycles-pp.generic_pipe_buf_release
      0.16 ±  3%      +0.3        0.48        perf-profile.self.cycles-pp.pipe_clear_nowait
      0.30 ±  3%      +0.3        0.62        perf-profile.self.cycles-pp.apparmor_file_permission
      0.00            +0.3        0.32        perf-profile.self.cycles-pp.vfs_splice_read
      0.21            +0.4        0.60        perf-profile.self.cycles-pp.rcu_all_qs
      3.76            +0.4        4.15        perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.4        0.42        perf-profile.self.cycles-pp.__alloc_pages_bulk
      0.22 ±  6%      +0.4        0.65        perf-profile.self.cycles-pp.get_page_from_freelist
      0.26            +0.4        0.68        perf-profile.self.cycles-pp.splice_from_pipe
      0.44            +0.5        0.91        perf-profile.self.cycles-pp.__splice_from_pipe
      0.29 ±  3%      +0.5        0.78        perf-profile.self.cycles-pp.__alloc_pages
      0.28            +0.5        0.78        perf-profile.self.cycles-pp.pipe_double_lock
      0.29            +0.5        0.78        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.28            +0.5        0.79        perf-profile.self.cycles-pp.rmqueue
      0.00            +0.6        0.55        perf-profile.self.cycles-pp.__kmem_cache_free
      0.00            +0.6        0.58        perf-profile.self.cycles-pp.splice_file_to_pipe
      0.35 ±  8%      +0.6        0.93        perf-profile.self.cycles-pp.stress_splice_looped_pipe
      0.44 ±  5%      +0.7        1.13        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38 ±  2%      +0.8        1.16        perf-profile.self.cycles-pp.stress_splice_flag
      0.48 ±  4%      +0.8        1.33        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.00            +0.9        0.92        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.54            +0.9        1.48        perf-profile.self.cycles-pp.__cond_resched
      0.50 ±  2%      +1.1        1.58        perf-profile.self.cycles-pp.get_pipe_info
      0.72 ±  9%      +1.1        1.83        perf-profile.self.cycles-pp.stress_splice
      0.62 ±  3%      +1.1        1.76        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.70            +1.2        1.90        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.68 ±  4%      +1.3        1.97        perf-profile.self.cycles-pp.stress_mwc1
      0.00            +1.4        1.38        perf-profile.self.cycles-pp.iov_iter_zero
      0.84 ±  2%      +1.4        2.25        perf-profile.self.cycles-pp.syscall_return_via_sysret
      4.14            +1.5        5.62        perf-profile.self.cycles-pp.splice_pipe_to_pipe
      0.00            +1.5        1.50        perf-profile.self.cycles-pp.copy_splice_read
      0.94 ±  2%      +1.6        2.56        perf-profile.self.cycles-pp.do_syscall_64
      1.15 ±  5%      +2.0        3.12        perf-profile.self.cycles-pp.__entry_text_start
      0.32 ±  3%      +2.1        2.42        perf-profile.self.cycles-pp.__fsnotify_parent
      1.46 ±  3%      +2.3        3.73        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.23 ±  2%      +2.5        3.72        perf-profile.self.cycles-pp.__x64_sys_splice
      1.22 ±  3%      +2.5        3.76        perf-profile.self.cycles-pp.__do_splice
      1.20 ±  2%      +2.8        3.95        perf-profile.self.cycles-pp.do_splice
      2.29 ±  3%      +4.0        6.26        perf-profile.self.cycles-pp.__fget_light
      3.35 ±  3%      +5.7        9.03        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.66 ±  2%      +6.7       10.31        perf-profile.self.cycles-pp.splice
      2491 ±  2%      -8.4%       2283 ±  3%  slabinfo.Acpi-State.active_objs
     48.86 ±  2%      -8.4%      44.77 ±  3%  slabinfo.Acpi-State.active_slabs
      2491 ±  2%      -8.4%       2283 ±  3%  slabinfo.Acpi-State.num_objs
     48.86 ±  2%      -8.4%      44.77 ±  3%  slabinfo.Acpi-State.num_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.active_slabs
     36.00            +0.0%      36.00        slabinfo.DCCP.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCP.num_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.active_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.active_slabs
     34.00            +0.0%      34.00        slabinfo.DCCPv6.num_objs
      2.00            +0.0%       2.00        slabinfo.DCCPv6.num_slabs
    272.00 ±  5%      +0.0%     272.00 ±  5%  slabinfo.RAW.active_objs
      8.50 ±  5%      +0.0%       8.50 ±  5%  slabinfo.RAW.active_slabs
    272.00 ±  5%      +0.0%     272.00 ±  5%  slabinfo.RAW.num_objs
      8.50 ±  5%      +0.0%       8.50 ±  5%  slabinfo.RAW.num_slabs
    208.00            +0.0%     208.00        slabinfo.RAWv6.active_objs
      8.00            +0.0%       8.00        slabinfo.RAWv6.active_slabs
    208.00            +0.0%     208.00        slabinfo.RAWv6.num_objs
      8.00            +0.0%       8.00        slabinfo.RAWv6.num_slabs
     69.46            -9.5%      62.90 ± 10%  slabinfo.TCP.active_objs
      4.96            -9.5%       4.49 ± 10%  slabinfo.TCP.active_slabs
     69.46            -9.5%      62.90 ± 10%  slabinfo.TCP.num_objs
      4.96            -9.5%       4.49 ± 10%  slabinfo.TCP.num_slabs
     39.00            +0.0%      39.00        slabinfo.TCPv6.active_objs
      3.00            +0.0%       3.00        slabinfo.TCPv6.active_slabs
     39.00            +0.0%      39.00        slabinfo.TCPv6.num_objs
      3.00            +0.0%       3.00        slabinfo.TCPv6.num_slabs
    120.00            +0.0%     120.00        slabinfo.UDPv6.active_objs
      5.00            +0.0%       5.00        slabinfo.UDPv6.active_slabs
    120.00            +0.0%     120.00        slabinfo.UDPv6.num_objs
      5.00            +0.0%       5.00        slabinfo.UDPv6.num_slabs
      1845 ±  7%      +1.0%       1865 ±  6%  slabinfo.UNIX.active_objs
     61.53 ±  7%      +1.0%      62.18 ±  6%  slabinfo.UNIX.active_slabs
      1845 ±  7%      +1.0%       1865 ±  6%  slabinfo.UNIX.num_objs
     61.53 ±  7%      +1.0%      62.18 ±  6%  slabinfo.UNIX.num_slabs
     21238            +5.8%      22466        slabinfo.anon_vma.active_objs
    548.62            +6.0%     581.43        slabinfo.anon_vma.active_slabs
     21396            +6.0%      22675        slabinfo.anon_vma.num_objs
    548.62            +6.0%     581.43        slabinfo.anon_vma.num_slabs
     30177            -2.6%      29406        slabinfo.anon_vma_chain.active_objs
    473.61            -2.2%     463.15        slabinfo.anon_vma_chain.active_slabs
     30310            -2.2%      29641        slabinfo.anon_vma_chain.num_objs
    473.61            -2.2%     463.15        slabinfo.anon_vma_chain.num_slabs
     90.00 ± 11%     +11.1%     100.00 ± 20%  slabinfo.bdev_cache.active_objs
      4.50 ± 11%     +11.1%       5.00 ± 20%  slabinfo.bdev_cache.active_slabs
     90.00 ± 11%     +11.1%     100.00 ± 20%  slabinfo.bdev_cache.num_objs
      4.50 ± 11%     +11.1%       5.00 ± 20%  slabinfo.bdev_cache.num_slabs
    800.00 ±  4%      -4.0%     768.00        slabinfo.bio-120.active_objs
     12.50 ±  4%      -4.0%      12.00        slabinfo.bio-120.active_slabs
    800.00 ±  4%      -4.0%     768.00        slabinfo.bio-120.num_objs
     12.50 ±  4%      -4.0%      12.00        slabinfo.bio-120.num_slabs
    693.00 ±  9%      +3.0%     714.00 ±  5%  slabinfo.bio-184.active_objs
     16.50 ±  9%      +3.0%      17.00 ±  5%  slabinfo.bio-184.active_slabs
    693.00 ±  9%      +3.0%     714.00 ±  5%  slabinfo.bio-184.num_objs
     16.50 ±  9%      +3.0%      17.00 ±  5%  slabinfo.bio-184.num_slabs
    128.00            +0.0%     128.00        slabinfo.bio-248.active_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.active_slabs
    128.00            +0.0%     128.00        slabinfo.bio-248.num_objs
      2.00            +0.0%       2.00        slabinfo.bio-248.num_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.active_slabs
     51.00            +0.0%      51.00        slabinfo.bio-296.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-296.num_slabs
    168.00            +0.0%     168.00        slabinfo.bio-360.active_objs
      4.00            +0.0%       4.00        slabinfo.bio-360.active_slabs
    168.00            +0.0%     168.00        slabinfo.bio-360.num_objs
      4.00            +0.0%       4.00        slabinfo.bio-360.num_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.active_slabs
     42.00            +0.0%      42.00        slabinfo.bio-376.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-376.num_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.active_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.active_slabs
     36.00            +0.0%      36.00        slabinfo.bio-432.num_objs
      1.00            +0.0%       1.00        slabinfo.bio-432.num_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.active_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.active_slabs
    170.00            +0.0%     170.00        slabinfo.bio_post_read_ctx.num_objs
      2.00            +0.0%       2.00        slabinfo.bio_post_read_ctx.num_slabs
     32.00            +0.0%      32.00        slabinfo.biovec-128.active_objs
      2.00            +0.0%       2.00        slabinfo.biovec-128.active_slabs
     32.00            +0.0%      32.00        slabinfo.biovec-128.num_objs
      2.00            +0.0%       2.00        slabinfo.biovec-128.num_slabs
    352.00 ± 18%     +22.7%     432.00 ± 11%  slabinfo.biovec-64.active_objs
     11.00 ± 18%     +22.7%      13.50 ± 11%  slabinfo.biovec-64.active_slabs
    352.00 ± 18%     +22.7%     432.00 ± 11%  slabinfo.biovec-64.num_objs
     11.00 ± 18%     +22.7%      13.50 ± 11%  slabinfo.biovec-64.num_slabs
     56.00            +0.0%      56.00        slabinfo.biovec-max.active_objs
      7.00            +0.0%       7.00        slabinfo.biovec-max.active_slabs
     56.00            +0.0%      56.00        slabinfo.biovec-max.num_objs
      7.00            +0.0%       7.00        slabinfo.biovec-max.num_slabs
    204.00            +0.0%     204.00        slabinfo.btrfs_extent_buffer.active_objs
      3.00            +0.0%       3.00        slabinfo.btrfs_extent_buffer.active_slabs
    204.00            +0.0%     204.00        slabinfo.btrfs_extent_buffer.num_objs
      3.00            +0.0%       3.00        slabinfo.btrfs_extent_buffer.num_slabs
     39.00            +0.0%      39.00        slabinfo.btrfs_free_space.active_objs
      1.00            +0.0%       1.00        slabinfo.btrfs_free_space.active_slabs
     39.00            +0.0%      39.00        slabinfo.btrfs_free_space.num_objs
      1.00            +0.0%       1.00        slabinfo.btrfs_free_space.num_slabs
    101.50 ± 14%     +14.3%     116.00        slabinfo.btrfs_inode.active_objs
      3.50 ± 14%     +14.3%       4.00        slabinfo.btrfs_inode.active_slabs
    101.50 ± 14%     +14.3%     116.00        slabinfo.btrfs_inode.num_objs
      3.50 ± 14%     +14.3%       4.00        slabinfo.btrfs_inode.num_slabs
    269.45 ±  6%      +6.7%     287.45        slabinfo.btrfs_path.active_objs
      7.48 ±  6%      +6.7%       7.98        slabinfo.btrfs_path.active_slabs
    269.45 ±  6%      +6.7%     287.45        slabinfo.btrfs_path.num_objs
      7.48 ±  6%      +6.7%       7.98        slabinfo.btrfs_path.num_slabs
    253.50 ±  7%      +7.7%     273.00        slabinfo.buffer_head.active_objs
      6.50 ±  7%      +7.7%       7.00        slabinfo.buffer_head.active_slabs
    253.50 ±  7%      +7.7%     273.00        slabinfo.buffer_head.num_objs
      6.50 ±  7%      +7.7%       7.00        slabinfo.buffer_head.num_slabs
      8066 ±  7%      -5.4%       7628        slabinfo.cred_jar.active_objs
    192.07 ±  7%      -5.4%     181.62        slabinfo.cred_jar.active_slabs
      8066 ±  7%      -5.4%       7628        slabinfo.cred_jar.num_objs
    192.07 ±  7%      -5.4%     181.62        slabinfo.cred_jar.num_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.active_slabs
     39.00            +0.0%      39.00        slabinfo.dax_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.dax_cache.num_slabs
    117830            -1.7%     115870        slabinfo.dentry.active_objs
      2856            -1.6%       2809        slabinfo.dentry.active_slabs
    119957            -1.6%     117994        slabinfo.dentry.num_objs
      2856            -1.6%       2809        slabinfo.dentry.num_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.active_slabs
     30.00            +0.0%      30.00        slabinfo.dmaengine-unmap-128.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-128.num_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.active_slabs
     64.00            +0.0%      64.00        slabinfo.dmaengine-unmap-2.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-2.num_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.active_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.active_slabs
     15.00            +0.0%      15.00        slabinfo.dmaengine-unmap-256.num_objs
      1.00            +0.0%       1.00        slabinfo.dmaengine-unmap-256.num_slabs
     12558 ±  2%     +26.9%      15930 ±  9%  slabinfo.ep_head.active_objs
     49.06 ±  2%     +26.9%      62.23 ±  9%  slabinfo.ep_head.active_slabs
     12558 ±  2%     +26.9%      15930 ±  9%  slabinfo.ep_head.num_objs
     49.06 ±  2%     +26.9%      62.23 ±  9%  slabinfo.ep_head.num_slabs
    864.17 ±  7%     -12.2%     758.50 ±  2%  slabinfo.file_lock_cache.active_objs
     23.36 ±  7%     -12.2%      20.50 ±  2%  slabinfo.file_lock_cache.active_slabs
    864.17 ±  7%     -12.2%     758.50 ±  2%  slabinfo.file_lock_cache.num_objs
     23.36 ±  7%     -12.2%      20.50 ±  2%  slabinfo.file_lock_cache.num_slabs
      5586 ±  2%      +0.4%       5607        slabinfo.files_cache.active_objs
    121.45 ±  2%      +0.4%     121.91        slabinfo.files_cache.active_slabs
      5586 ±  2%      +0.4%       5607        slabinfo.files_cache.num_objs
    121.45 ±  2%      +0.4%     121.91        slabinfo.files_cache.num_slabs
     22890            -1.9%      22452        slabinfo.filp.active_objs
    376.06 ±  2%      -0.0%     375.89        slabinfo.filp.active_slabs
     24067 ±  2%      -0.0%      24056        slabinfo.filp.num_objs
    376.06 ±  2%      -0.0%     375.89        slabinfo.filp.num_slabs
      2797 ±  9%     -21.0%       2210 ±  7%  slabinfo.fsnotify_mark_connector.active_objs
     21.86 ±  9%     -21.0%      17.27 ±  7%  slabinfo.fsnotify_mark_connector.active_slabs
      2797 ±  9%     -21.0%       2210 ±  7%  slabinfo.fsnotify_mark_connector.num_objs
     21.86 ±  9%     -21.0%      17.27 ±  7%  slabinfo.fsnotify_mark_connector.num_slabs
      8723            -1.7%       8577 ±  3%  slabinfo.ftrace_event_field.active_objs
    119.50            -1.7%     117.50 ±  3%  slabinfo.ftrace_event_field.active_slabs
      8723            -1.7%       8577 ±  3%  slabinfo.ftrace_event_field.num_objs
    119.50            -1.7%     117.50 ±  3%  slabinfo.ftrace_event_field.num_slabs
    168.00            +0.0%     168.00        slabinfo.fuse_request.active_objs
      3.00            +0.0%       3.00        slabinfo.fuse_request.active_slabs
    168.00            +0.0%     168.00        slabinfo.fuse_request.num_objs
      3.00            +0.0%       3.00        slabinfo.fuse_request.num_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.active_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.active_slabs
     98.00            +0.0%      98.00        slabinfo.hugetlbfs_inode_cache.num_objs
      2.00            +0.0%       2.00        slabinfo.hugetlbfs_inode_cache.num_slabs
     84504            -0.1%      84410        slabinfo.inode_cache.active_objs
      1661            -0.2%       1658        slabinfo.inode_cache.active_slabs
     84715            -0.2%      84560        slabinfo.inode_cache.num_objs
      1661            -0.2%       1658        slabinfo.inode_cache.num_slabs
    182.50 ± 20%     +20.0%     219.00        slabinfo.ip_fib_alias.active_objs
      2.50 ± 20%     +20.0%       3.00        slabinfo.ip_fib_alias.active_slabs
    182.50 ± 20%     +20.0%     219.00        slabinfo.ip_fib_alias.num_objs
      2.50 ± 20%     +20.0%       3.00        slabinfo.ip_fib_alias.num_slabs
    212.50 ± 20%     +20.0%     255.00        slabinfo.ip_fib_trie.active_objs
      2.50 ± 20%     +20.0%       3.00        slabinfo.ip_fib_trie.active_slabs
    212.50 ± 20%     +20.0%     255.00        slabinfo.ip_fib_trie.num_objs
      2.50 ± 20%     +20.0%       3.00        slabinfo.ip_fib_trie.num_slabs
    102444            +0.2%     102635        slabinfo.kernfs_node_cache.active_objs
      1600            +0.2%       1603        slabinfo.kernfs_node_cache.active_slabs
    102444            +0.2%     102635        slabinfo.kernfs_node_cache.num_objs
      1600            +0.2%       1603        slabinfo.kernfs_node_cache.num_slabs
      4579 ±  6%     -10.6%       4093 ± 10%  slabinfo.khugepaged_mm_slot.active_objs
     44.90 ±  6%     -10.6%      40.13 ± 10%  slabinfo.khugepaged_mm_slot.active_slabs
      4579 ±  6%     -10.6%       4093 ± 10%  slabinfo.khugepaged_mm_slot.num_objs
     44.90 ±  6%     -10.6%      40.13 ± 10%  slabinfo.khugepaged_mm_slot.num_slabs
     12242            -1.3%      12080        slabinfo.kmalloc-128.active_objs
    193.24            -1.2%     190.91        slabinfo.kmalloc-128.active_slabs
     12367            -1.2%      12218        slabinfo.kmalloc-128.num_objs
    193.24            -1.2%     190.91        slabinfo.kmalloc-128.num_slabs
     50881            +0.6%      51173        slabinfo.kmalloc-16.active_objs
    199.00            +0.5%     199.99        slabinfo.kmalloc-16.active_slabs
     50944            +0.5%      51198        slabinfo.kmalloc-16.num_objs
    199.00            +0.5%     199.99        slabinfo.kmalloc-16.num_slabs
      8518            -1.0%       8434        slabinfo.kmalloc-192.active_objs
    202.82            -1.0%     200.82        slabinfo.kmalloc-192.active_slabs
      8518            -1.0%       8434        slabinfo.kmalloc-192.num_objs
    202.82            -1.0%     200.82        slabinfo.kmalloc-192.num_slabs
      6877            -0.7%       6829        slabinfo.kmalloc-1k.active_objs
    216.60            -1.1%     214.30        slabinfo.kmalloc-1k.active_slabs
      6931            -1.1%       6857        slabinfo.kmalloc-1k.num_objs
    216.60            -1.1%     214.30        slabinfo.kmalloc-1k.num_slabs
     11098            +0.1%      11111        slabinfo.kmalloc-256.active_objs
    176.92            -0.5%     175.96        slabinfo.kmalloc-256.active_slabs
     11322            -0.5%      11261        slabinfo.kmalloc-256.num_objs
    176.92            -0.5%     175.96        slabinfo.kmalloc-256.num_slabs
      5325            -0.4%       5305        slabinfo.kmalloc-2k.active_objs
    338.52            -0.4%     337.16        slabinfo.kmalloc-2k.active_slabs
      5416            -0.4%       5394        slabinfo.kmalloc-2k.num_objs
    338.52            -0.4%     337.16        slabinfo.kmalloc-2k.num_slabs
     53093            -1.3%      52419        slabinfo.kmalloc-32.active_objs
    415.41            -1.3%     409.98        slabinfo.kmalloc-32.active_slabs
     53172            -1.3%      52477        slabinfo.kmalloc-32.num_objs
    415.41            -1.3%     409.98        slabinfo.kmalloc-32.num_slabs
      2048            +0.6%       2060        slabinfo.kmalloc-4k.active_objs
    259.69            +0.3%     260.39        slabinfo.kmalloc-4k.active_slabs
      2077            +0.3%       2083        slabinfo.kmalloc-4k.num_objs
    259.69            +0.3%     260.39        slabinfo.kmalloc-4k.num_slabs
     21135            +1.8%      21522        slabinfo.kmalloc-512.active_objs
    332.32            +2.0%     338.86        slabinfo.kmalloc-512.active_slabs
     21268            +2.0%      21687        slabinfo.kmalloc-512.num_objs
    332.32            +2.0%     338.86        slabinfo.kmalloc-512.num_slabs
     54000            -0.3%      53842        slabinfo.kmalloc-64.active_objs
    844.55            -0.3%     841.89        slabinfo.kmalloc-64.active_slabs
     54051            -0.3%      53881        slabinfo.kmalloc-64.num_objs
    844.55            -0.3%     841.89        slabinfo.kmalloc-64.num_slabs
     86635 ±  2%      -0.8%      85976        slabinfo.kmalloc-8.active_objs
    174.83            -0.7%     173.64        slabinfo.kmalloc-8.active_slabs
     89515            -0.7%      88901        slabinfo.kmalloc-8.num_objs
    174.83            -0.7%     173.64        slabinfo.kmalloc-8.num_slabs
      1279            +0.3%       1283        slabinfo.kmalloc-8k.active_objs
    322.16            +0.4%     323.51        slabinfo.kmalloc-8k.active_slabs
      1288            +0.4%       1294        slabinfo.kmalloc-8k.num_objs
    322.16            +0.4%     323.51        slabinfo.kmalloc-8k.num_slabs
     28911 ±  2%      +0.5%      29046        slabinfo.kmalloc-96.active_objs
    706.20 ±  2%      +0.9%     712.75        slabinfo.kmalloc-96.active_slabs
     29660 ±  2%      +0.9%      29935        slabinfo.kmalloc-96.num_objs
    706.20 ±  2%      +0.9%     712.75        slabinfo.kmalloc-96.num_slabs
      1216           +10.5%       1344 ±  4%  slabinfo.kmalloc-cg-128.active_objs
     19.00           +10.5%      21.00 ±  4%  slabinfo.kmalloc-cg-128.active_slabs
      1216           +10.5%       1344 ±  4%  slabinfo.kmalloc-cg-128.num_objs
     19.00           +10.5%      21.00 ±  4%  slabinfo.kmalloc-cg-128.num_slabs
      4187 ±  3%      +0.9%       4224 ±  9%  slabinfo.kmalloc-cg-16.active_objs
     16.36 ±  3%      +0.9%      16.50 ±  9%  slabinfo.kmalloc-cg-16.active_slabs
      4187 ±  3%      +0.9%       4224 ±  9%  slabinfo.kmalloc-cg-16.num_objs
     16.36 ±  3%      +0.9%      16.50 ±  9%  slabinfo.kmalloc-cg-16.num_slabs
      5777            -0.3%       5760        slabinfo.kmalloc-cg-192.active_objs
    137.55            -0.3%     137.15        slabinfo.kmalloc-cg-192.active_slabs
      5777            -0.3%       5760        slabinfo.kmalloc-cg-192.num_objs
    137.55            -0.3%     137.15        slabinfo.kmalloc-cg-192.num_slabs
      4473            +0.4%       4493        slabinfo.kmalloc-cg-1k.active_objs
    139.81            +0.4%     140.42        slabinfo.kmalloc-cg-1k.active_slabs
      4473            +0.4%       4493        slabinfo.kmalloc-cg-1k.num_objs
    139.81            +0.4%     140.42        slabinfo.kmalloc-cg-1k.num_slabs
      1056 ±  9%      +9.1%       1152        slabinfo.kmalloc-cg-256.active_objs
     16.50 ±  9%      +9.1%      18.00        slabinfo.kmalloc-cg-256.active_slabs
      1056 ±  9%      +9.1%       1152        slabinfo.kmalloc-cg-256.num_objs
     16.50 ±  9%      +9.1%      18.00        slabinfo.kmalloc-cg-256.num_slabs
      1806            -1.0%       1788 ±  2%  slabinfo.kmalloc-cg-2k.active_objs
    112.93            -1.0%     111.76 ±  2%  slabinfo.kmalloc-cg-2k.active_slabs
      1806            -1.0%       1788 ±  2%  slabinfo.kmalloc-cg-2k.num_objs
    112.93            -1.0%     111.76 ±  2%  slabinfo.kmalloc-cg-2k.num_slabs
     16717            -3.8%      16088        slabinfo.kmalloc-cg-32.active_objs
    130.61            -3.8%     125.69        slabinfo.kmalloc-cg-32.active_slabs
     16717            -3.8%      16088        slabinfo.kmalloc-cg-32.num_objs
    130.61            -3.8%     125.69        slabinfo.kmalloc-cg-32.num_slabs
      1444            +0.5%       1451        slabinfo.kmalloc-cg-4k.active_objs
    187.69            +1.2%     189.94        slabinfo.kmalloc-cg-4k.active_slabs
      1501            +1.2%       1519        slabinfo.kmalloc-cg-4k.num_objs
    187.69            +1.2%     189.94        slabinfo.kmalloc-cg-4k.num_slabs
      8224            +0.8%       8288        slabinfo.kmalloc-cg-512.active_objs
    128.50            +0.8%     129.50        slabinfo.kmalloc-cg-512.active_slabs
      8224            +0.8%       8288        slabinfo.kmalloc-cg-512.num_objs
    128.50            +0.8%     129.50        slabinfo.kmalloc-cg-512.num_slabs
      2795            -1.6%       2749 ±  4%  slabinfo.kmalloc-cg-64.active_objs
     43.67            -1.6%      42.96 ±  4%  slabinfo.kmalloc-cg-64.active_slabs
      2795            -1.6%       2749 ±  4%  slabinfo.kmalloc-cg-64.num_objs
     43.67            -1.6%      42.96 ±  4%  slabinfo.kmalloc-cg-64.num_slabs
     64713            -0.3%      64518        slabinfo.kmalloc-cg-8.active_objs
    126.39            -0.3%     126.01        slabinfo.kmalloc-cg-8.active_slabs
     64713            -0.3%      64518        slabinfo.kmalloc-cg-8.num_objs
    126.39            -0.3%     126.01        slabinfo.kmalloc-cg-8.num_slabs
     42.43 ±  6%      +3.6%      43.94        slabinfo.kmalloc-cg-8k.active_objs
     10.61 ±  6%      +3.6%      10.98        slabinfo.kmalloc-cg-8k.active_slabs
     42.43 ±  6%      +3.6%      43.94        slabinfo.kmalloc-cg-8k.num_objs
     10.61 ±  6%      +3.6%      10.98        slabinfo.kmalloc-cg-8k.num_slabs
      1627            -7.9%       1498 ±  2%  slabinfo.kmalloc-cg-96.active_objs
     38.75            -7.9%      35.68 ±  2%  slabinfo.kmalloc-cg-96.active_slabs
      1627            -7.9%       1498 ±  2%  slabinfo.kmalloc-cg-96.num_objs
     38.75            -7.9%      35.68 ±  2%  slabinfo.kmalloc-cg-96.num_slabs
    448.00 ± 14%     +14.3%     512.00        slabinfo.kmalloc-rcl-128.active_objs
      7.00 ± 14%     +14.3%       8.00        slabinfo.kmalloc-rcl-128.active_slabs
    448.00 ± 14%     +14.3%     512.00        slabinfo.kmalloc-rcl-128.num_objs
      7.00 ± 14%     +14.3%       8.00        slabinfo.kmalloc-rcl-128.num_slabs
    147.00 ± 14%     +14.3%     168.00        slabinfo.kmalloc-rcl-192.active_objs
      3.50 ± 14%     +14.3%       4.00        slabinfo.kmalloc-rcl-192.active_slabs
    147.00 ± 14%     +14.3%     168.00        slabinfo.kmalloc-rcl-192.num_objs
      3.50 ± 14%     +14.3%       4.00        slabinfo.kmalloc-rcl-192.num_slabs
      8069            +1.1%       8162        slabinfo.kmalloc-rcl-64.active_objs
    126.23            +1.0%     127.53        slabinfo.kmalloc-rcl-64.active_slabs
      8078            +1.0%       8162        slabinfo.kmalloc-rcl-64.num_objs
    126.23            +1.0%     127.53        slabinfo.kmalloc-rcl-64.num_slabs
      1547 ± 22%      -4.3%       1481 ±  3%  slabinfo.kmalloc-rcl-96.active_objs
     36.86 ± 22%      -4.3%      35.27 ±  3%  slabinfo.kmalloc-rcl-96.active_slabs
      1547 ± 22%      -4.3%       1481 ±  3%  slabinfo.kmalloc-rcl-96.num_objs
     36.86 ± 22%      -4.3%      35.27 ±  3%  slabinfo.kmalloc-rcl-96.num_slabs
      1056 ±  9%     +12.1%       1184 ±  8%  slabinfo.kmem_cache.active_objs
     16.50 ±  9%     +12.1%      18.50 ±  8%  slabinfo.kmem_cache.active_slabs
      1056 ±  9%     +12.1%       1184 ±  8%  slabinfo.kmem_cache.num_objs
     16.50 ±  9%     +12.1%      18.50 ±  8%  slabinfo.kmem_cache.num_slabs
      1242 ±  7%     +10.3%       1370 ±  7%  slabinfo.kmem_cache_node.active_objs
     19.50 ±  7%     +10.3%      21.50 ±  6%  slabinfo.kmem_cache_node.active_slabs
      1248 ±  7%     +10.3%       1376 ±  6%  slabinfo.kmem_cache_node.num_objs
     19.50 ±  7%     +10.3%      21.50 ±  6%  slabinfo.kmem_cache_node.num_slabs
     25810 ±  2%      -1.9%      25322        slabinfo.lsm_file_cache.active_objs
    154.80 ±  2%      -1.7%     152.13        slabinfo.lsm_file_cache.active_slabs
     26316 ±  2%      -1.7%      25862        slabinfo.lsm_file_cache.num_objs
    154.80 ±  2%      -1.7%     152.13        slabinfo.lsm_file_cache.num_slabs
     21081            -1.6%      20753        slabinfo.maple_node.active_objs
    335.68            -1.5%     330.72        slabinfo.maple_node.active_slabs
     21483            -1.5%      21165        slabinfo.maple_node.num_objs
    335.68            -1.5%     330.72        slabinfo.maple_node.num_slabs
      3229            -0.2%       3221        slabinfo.mm_struct.active_objs
    134.56            -0.2%     134.24        slabinfo.mm_struct.active_slabs
      3229            -0.2%       3221        slabinfo.mm_struct.num_objs
    134.56            -0.2%     134.24        slabinfo.mm_struct.num_slabs
      1224 ±  8%      +0.0%       1224 ±  4%  slabinfo.mnt_cache.active_objs
     24.00 ±  8%      +0.0%      24.00 ±  4%  slabinfo.mnt_cache.active_slabs
      1224 ±  8%      +0.0%       1224 ±  4%  slabinfo.mnt_cache.num_objs
     24.00 ±  8%      +0.0%      24.00 ±  4%  slabinfo.mnt_cache.num_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.active_slabs
     34.00            +0.0%      34.00        slabinfo.mqueue_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.mqueue_inode_cache.num_slabs
      1024            +0.0%       1024        slabinfo.names_cache.active_objs
    128.00            +0.0%     128.00        slabinfo.names_cache.active_slabs
      1024            +0.0%       1024        slabinfo.names_cache.num_objs
    128.00            +0.0%     128.00        slabinfo.names_cache.num_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.active_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.active_slabs
      7.00            +0.0%       7.00        slabinfo.net_namespace.num_objs
      1.00            +0.0%       1.00        slabinfo.net_namespace.num_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.active_slabs
     46.00            +0.0%      46.00        slabinfo.nfs_commit_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_commit_data.num_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.active_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.active_slabs
     36.00            +0.0%      36.00        slabinfo.nfs_read_data.num_objs
      1.00            +0.0%       1.00        slabinfo.nfs_read_data.num_slabs
    348.54 ±  5%      -7.2%     323.55 ±  2%  slabinfo.nsproxy.active_objs
      6.22 ±  5%      -7.2%       5.78 ±  2%  slabinfo.nsproxy.active_slabs
    348.54 ±  5%      -7.2%     323.55 ±  2%  slabinfo.nsproxy.num_objs
      6.22 ±  5%      -7.2%       5.78 ±  2%  slabinfo.nsproxy.num_slabs
    180.00            +0.0%     180.00        slabinfo.numa_policy.active_objs
      3.00            +0.0%       3.00        slabinfo.numa_policy.active_slabs
    180.00            +0.0%     180.00        slabinfo.numa_policy.num_objs
      3.00            +0.0%       3.00        slabinfo.numa_policy.num_slabs
      5104            +0.3%       5118        slabinfo.perf_event.active_objs
    208.93            +0.5%     209.90        slabinfo.perf_event.active_slabs
      5223            +0.5%       5247        slabinfo.perf_event.num_objs
    208.93            +0.5%     209.90        slabinfo.perf_event.num_slabs
      8986 ±  3%      -0.4%       8953        slabinfo.pid.active_objs
    140.41 ±  3%      -0.4%     139.90        slabinfo.pid.active_slabs
      8986 ±  3%      -0.4%       8953        slabinfo.pid.num_objs
    140.41 ±  3%      -0.4%     139.90        slabinfo.pid.num_slabs
      7933            -0.4%       7904 ±  2%  slabinfo.pool_workqueue.active_objs
    124.43            +0.0%     124.45 ±  2%  slabinfo.pool_workqueue.active_slabs
      7963            +0.0%       7965 ±  2%  slabinfo.pool_workqueue.num_objs
    124.43            +0.0%     124.45 ±  2%  slabinfo.pool_workqueue.num_slabs
      6762            +0.6%       6804        slabinfo.proc_dir_entry.active_objs
    161.00            +0.6%     162.00        slabinfo.proc_dir_entry.active_slabs
      6762            +0.6%       6804        slabinfo.proc_dir_entry.num_objs
    161.00            +0.6%     162.00        slabinfo.proc_dir_entry.num_slabs
     17426            -2.5%      16992        slabinfo.proc_inode_cache.active_objs
    379.09            -2.5%     369.55        slabinfo.proc_inode_cache.active_slabs
     17437            -2.5%      16999        slabinfo.proc_inode_cache.num_objs
    379.09            -2.5%     369.55        slabinfo.proc_inode_cache.num_slabs
     34728            -0.1%      34679        slabinfo.radix_tree_node.active_objs
    621.22            -0.3%     619.51        slabinfo.radix_tree_node.active_slabs
     34788            -0.3%      34692        slabinfo.radix_tree_node.num_objs
    621.22            -0.3%     619.51        slabinfo.radix_tree_node.num_slabs
    332.50 ±  5%     -15.8%     280.00        slabinfo.request_queue.active_objs
     14.50 ±  3%     -10.3%      13.00        slabinfo.request_queue.active_slabs
    507.50 ±  3%     -10.3%     455.00        slabinfo.request_queue.num_objs
     14.50 ±  3%     -10.3%      13.00        slabinfo.request_queue.num_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.active_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.active_slabs
     46.00            +0.0%      46.00        slabinfo.rpc_inode_cache.num_objs
      1.00            +0.0%       1.00        slabinfo.rpc_inode_cache.num_slabs
      1504 ±  2%      +0.0%       1504 ±  2%  slabinfo.scsi_sense_cache.active_objs
     24.50 ±  2%      +0.0%      24.50 ±  2%  slabinfo.scsi_sense_cache.active_slabs
      1568 ±  2%      +0.0%       1568 ±  2%  slabinfo.scsi_sense_cache.num_objs
     24.50 ±  2%      +0.0%      24.50 ±  2%  slabinfo.scsi_sense_cache.num_slabs
      9104            -0.7%       9038        slabinfo.seq_file.active_objs
    133.89            -0.7%     132.92        slabinfo.seq_file.active_slabs
      9104            -0.7%       9038        slabinfo.seq_file.num_objs
    133.89            -0.7%     132.92        slabinfo.seq_file.num_slabs
     23757            +0.4%      23842        slabinfo.shared_policy_node.active_objs
    279.50            +0.4%     280.50        slabinfo.shared_policy_node.active_slabs
     23757            +0.4%      23842        slabinfo.shared_policy_node.num_objs
    279.50            +0.4%     280.50        slabinfo.shared_policy_node.num_slabs
      5808 ±  2%      -2.0%       5694        slabinfo.shmem_inode_cache.active_objs
    141.66 ±  2%      -2.0%     138.90        slabinfo.shmem_inode_cache.active_slabs
      5808 ±  2%      -2.0%       5694        slabinfo.shmem_inode_cache.num_objs
    141.66 ±  2%      -2.0%     138.90        slabinfo.shmem_inode_cache.num_slabs
      3258            +0.4%       3270 ±  2%  slabinfo.sighand_cache.active_objs
    217.31            +0.4%     218.09 ±  2%  slabinfo.sighand_cache.active_slabs
      3259            +0.4%       3271 ±  2%  slabinfo.sighand_cache.num_objs
    217.31            +0.4%     218.09 ±  2%  slabinfo.sighand_cache.num_slabs
      5256 ±  4%      -2.2%       5139 ±  2%  slabinfo.signal_cache.active_objs
    187.78 ±  4%      -2.3%     183.54 ±  2%  slabinfo.signal_cache.active_slabs
      5257 ±  4%      -2.3%       5139 ±  2%  slabinfo.signal_cache.num_objs
    187.78 ±  4%      -2.3%     183.54 ±  2%  slabinfo.signal_cache.num_slabs
      6952            +1.0%       7023        slabinfo.sigqueue.active_objs
    136.31            +1.0%     137.71        slabinfo.sigqueue.active_slabs
      6952            +1.0%       7023        slabinfo.sigqueue.num_objs
    136.31            +1.0%     137.71        slabinfo.sigqueue.num_slabs
    554.58            +5.9%     587.36 ±  7%  slabinfo.skbuff_ext_cache.active_objs
     13.20            +5.9%      13.98 ±  7%  slabinfo.skbuff_ext_cache.active_slabs
    554.58            +5.9%     587.36 ±  7%  slabinfo.skbuff_ext_cache.num_objs
     13.20            +5.9%      13.98 ±  7%  slabinfo.skbuff_ext_cache.num_slabs
      8971            +1.6%       9118        slabinfo.skbuff_head_cache.active_objs
    140.18            +1.6%     142.47        slabinfo.skbuff_head_cache.active_slabs
      8971            +1.6%       9118        slabinfo.skbuff_head_cache.num_objs
    140.18            +1.6%     142.47        slabinfo.skbuff_head_cache.num_slabs
      6109 ±  4%      +9.5%       6692        slabinfo.skbuff_small_head.active_objs
    119.79 ±  4%      +9.5%     131.23        slabinfo.skbuff_small_head.active_slabs
      6109 ±  4%      +9.5%       6692        slabinfo.skbuff_small_head.num_objs
    119.79 ±  4%      +9.5%     131.23        slabinfo.skbuff_small_head.num_slabs
      3252 ±  4%      +9.1%       3547        slabinfo.sock_inode_cache.active_objs
     83.40 ±  4%      +9.1%      90.95        slabinfo.sock_inode_cache.active_slabs
      3252 ±  4%      +9.1%       3547        slabinfo.sock_inode_cache.num_objs
     83.40 ±  4%      +9.1%      90.95        slabinfo.sock_inode_cache.num_slabs
      1469 ±  8%      -2.6%       1431 ±  4%  slabinfo.task_group.active_objs
     28.82 ±  8%      -2.6%      28.08 ±  4%  slabinfo.task_group.active_slabs
      1469 ±  8%      -2.6%       1431 ±  4%  slabinfo.task_group.num_objs
     28.82 ±  8%      -2.6%      28.08 ±  4%  slabinfo.task_group.num_slabs
      2331            -3.8%       2244        slabinfo.task_struct.active_objs
      2334            -3.8%       2245        slabinfo.task_struct.active_slabs
      2334            -3.8%       2245        slabinfo.task_struct.num_objs
      2334            -3.8%       2245        slabinfo.task_struct.num_slabs
    299.10            +6.4%     318.17 ±  5%  slabinfo.taskstats.active_objs
      8.08            +6.4%       8.60 ±  5%  slabinfo.taskstats.active_slabs
    299.10            +6.4%     318.17 ±  5%  slabinfo.taskstats.num_objs
      8.08            +6.4%       8.60 ±  5%  slabinfo.taskstats.num_slabs
      2369            +1.9%       2415        slabinfo.trace_event_file.active_objs
     51.50            +1.9%      52.50        slabinfo.trace_event_file.active_slabs
      2369            +1.9%       2415        slabinfo.trace_event_file.num_objs
     51.50            +1.9%      52.50        slabinfo.trace_event_file.num_slabs
      1585 ±  2%      +1.2%       1603        slabinfo.tracefs_inode_cache.active_objs
     31.70 ±  2%      +1.2%      32.07        slabinfo.tracefs_inode_cache.active_slabs
      1585 ±  2%      +1.2%       1603        slabinfo.tracefs_inode_cache.num_objs
     31.70 ±  2%      +1.2%      32.07        slabinfo.tracefs_inode_cache.num_slabs
    116.34            +0.0%     116.34        slabinfo.tw_sock_TCP.active_objs
      1.94            +0.0%       1.94        slabinfo.tw_sock_TCP.active_slabs
    116.34            +0.0%     116.34        slabinfo.tw_sock_TCP.num_objs
      1.94            +0.0%       1.94        slabinfo.tw_sock_TCP.num_slabs
    111.00            +0.0%     111.00        slabinfo.uts_namespace.active_objs
      3.00            +0.0%       3.00        slabinfo.uts_namespace.active_slabs
    111.00            +0.0%     111.00        slabinfo.uts_namespace.num_objs
      3.00            +0.0%       3.00        slabinfo.uts_namespace.num_slabs
     32868            -1.8%      32279        slabinfo.vm_area_struct.active_objs
    750.95            -1.8%     737.25        slabinfo.vm_area_struct.active_slabs
     33041            -1.8%      32439        slabinfo.vm_area_struct.num_objs
    750.95            -1.8%     737.25        slabinfo.vm_area_struct.num_slabs
     42944            +0.7%      43254        slabinfo.vma_lock.active_objs
    423.60            +1.0%     427.95        slabinfo.vma_lock.active_slabs
     43207            +1.0%      43651        slabinfo.vma_lock.num_objs
    423.60            +1.0%     427.95        slabinfo.vma_lock.num_slabs
    201997            -0.2%     201641        slabinfo.vmap_area.active_objs
      3612            -0.2%       3605        slabinfo.vmap_area.active_slabs
    202318            -0.2%     201897        slabinfo.vmap_area.num_objs
      3612            -0.2%       3605        slabinfo.vmap_area.num_slabs

