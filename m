Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D067CD536
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjJRHHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjJRHHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:07:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC22C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697612852; x=1729148852;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=FbVtG+C+V+UdC2vYvL4O3JTlx34lcqxDJaPWM/0gARI=;
  b=bSZQ1/JiJnni+kDJODvn8bLwinYetsDmJG8pYkSBi+BTr6Toa5GhGW+G
   ZREaHqVvbGh1aISS3MO7lPfblh5nu85/5WNcJHqQXajMr0/8/e0wxK2Qa
   P9H7lKd/G14+VmNV9K7lpIL9Q+H3WnG7BN4hA66Hle7KAlm6MjPMFDv8r
   HyjLyKRgtl+8w9xYjvBwQdFNjsJytDUOiy95kyB011gWV9erMSVFfMPC/
   GmqYdTm61fAofZfMLf+C5X+IIq1E1RUw9PqeMfV9qfui91tt9EtOoG8lm
   HO/0CBcagmYIV4zRY3YosX1YkgLgIIxQ06XwPnYNuZWmD7VK5PNurp9ba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365305831"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365305831"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="880106880"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="880106880"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 00:07:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:07:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:07:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 00:07:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 00:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDEWBXMEjG42D56ZHFkuR0VX9qJkbyR3OD7j8wvVxDwfHPLMilJBpe9xNWL5hoqdMyImvJF/ySwwa9LSqOrjAkupci6b1rlsCUBbNsnO4Ne9EW4V+F/nr/IvX9MP27RrdvJFspwaktiVt3HIineznup3NMcq6CaaA2ZSPCkawMPdWOfMTCwI0JCgdrDeZ+XgVfaYd6hA1cu2Wkeu/N5WoJ5fSbnvBnHBlQy0EJ2DYJyc/lYFXmIdpQW29xuuobCYEPyQOIfD4cFR0P+Dy5yg2pPPDcXX1nQL5juPHP5bVmVcGbVEX7lcA7zVBWIzfHfRdqr8z1gc0L52qvVSEZyJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQdp/u6bJFbtHQsg4dPG8v5gTsmbhCxIA6N1X9qmhEo=;
 b=jEssxLC31G35eIE/djpGLNmLXGudx90TIIwTZum1aekPknwhWMiFWOpLEKvzjfLKkfao4zmMaV8nrSdGn7OrGzu6CFA51YQj2o1im1ZbfjuI+sEcagsFhDYSAAskarA9ds/ft2fAMhhh+Ct+nBvp9xFEZPn4yPm3tQ1G0ucT3j2Vm7IA62kwWcKj1qGfMwJmlGPS9mAH0gLXqTRQqPnhcEAbgF4zz5v84ftxUt+EfFo4K0h6sk29M+a+xKKz2BwrthrRUP+w0qqHY8+moK8BBhUxS4fm1P42NQFWh5Jz34zP4eTUfNqWhjGm6XcrdaKilhh2f+jmL6wSuA4hHdrQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 07:07:29 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Wed, 18 Oct 2023
 07:07:29 +0000
Date:   Wed, 18 Oct 2023 15:07:20 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Max Kellermann <max.kellermann@ionos.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [drivers/char/mem]  1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
Message-ID: <ZS+EKPJA+BMhM0yO@xsang-OptiPlex-9020>
References: <202310172247.b9959bd4-oliver.sang@intel.com>
 <2023101759-front-ember-6354@gregkh>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101759-front-ember-6354@gregkh>
X-ClientProxiedBy: KU1PR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:802:19::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed42c18-d9e4-4dbf-5889-08dbcfa8e3e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7yxjR0UVaQNLXb+PqFz6/A/XJa4APoVHMDk1Ap9BeO1vTUuU+Bycx8FS+LNIoibtz7enalqLB3xT1w8fki1raSpfTlcYSdy6hGKAMAiZxR6pbEJquluJF+5NZB6cQwZQ9pipFT0/67dMRzGzGCithZfgH4RUS/8xWND5R9n72ZuXLnwNwZPT+P1Rm/SZc2voFPN3RELKD/BHw6mIHswwky/9U6hn58NFz3UZO1EaBhLhEeZvpRsAVY0fPpN3NHQfzcgeSqqzu2C6/GoG0OQioY7xBWStTBECzYis30wKXWSLkpQ9l/UTom4o9UcZJgjXM+Pzb/VI+QuQun1tF7SZPopc/JjfE1aWdxhSDxIkEJXZgdp9MTFaQKh0Y4OCVbfXAsaS7HQGCM60r6nezAwaSADiSz0mzduM1lRNbbG5fkSaTbRc8ygkYBzGZJQ24cQ39J6cm0zmi3vNzmR/hif1D5OinLqXe1Rm7Dg9WXEMd+ThtygkXrIpKsyz/eJE2+VXg5dzXb5kABs4qrhvJ908b7khSo5aZEQ8uIkuIv+7EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(83380400001)(2906002)(82960400001)(86362001)(26005)(38100700002)(107886003)(6512007)(6666004)(6506007)(6486002)(966005)(9686003)(66946007)(66476007)(54906003)(316002)(6916009)(66556008)(8676002)(44832011)(8936002)(5660300002)(4326008)(41300700001)(33716001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?c76C7dDrxLoH0VfjJKozhv12275kyI7lRjZLdnhNdUChAUEimZuXhz0oAB?=
 =?iso-8859-1?Q?Eiz2jf3IEclfxK5St/YYt5GPdwrBPytRuI9VbvXXxFBBoFjNyuhbMMCgYe?=
 =?iso-8859-1?Q?smSumxz5aUISZIvopX02Ek6m4u5hLUJHXIQck6KutdoVoM64Q2PDPaWCrT?=
 =?iso-8859-1?Q?HmvMxE4zAUP7ALhBJQi6x0sZNMLf12FD8ENs8JFjtVGpKsi/uMn5XaA/EW?=
 =?iso-8859-1?Q?oE03Qd7OU4mg0q8t/3EJHarVkfkV0UsyDrft8xfBwz00o25KfGwDhi1dkg?=
 =?iso-8859-1?Q?wqqjl0+iwb6Q+UfLYfMPbwfIkNel/keoOsHcf3LcVfiufxCCtAwuBaE8TI?=
 =?iso-8859-1?Q?PMsHuj3iym7GWWd9paMz1qPLYVhbw4vpoCMp7Z8abg0bY3Zu1CFupkZCco?=
 =?iso-8859-1?Q?jNiQ/L/6oBgoghL44kDEvCnKi3C5Nv/DKm3W6oFKVFFvM+OOChjzeDT8U/?=
 =?iso-8859-1?Q?gujABli9i8KOXGpSxMo2ICldMnxF7jXGd6HlM/9XchvZx2lcK0N7lqiB26?=
 =?iso-8859-1?Q?YbhnKd0XCwwAbP2/sktcYz1nTADgpUUGxQakV0HCcLI6S4rTCBQrtWe0Bm?=
 =?iso-8859-1?Q?XGVgiQWjvSZNZfBbie3FD3a3k4T87wi0YkeJ+BJJlYxBlo9P3HrXPE1i1b?=
 =?iso-8859-1?Q?yfpCsMPRDkyjBqYVJUOm+O2+0x0iUbN5PSfkNLBQQ2v/SEIIrryQ1uen0i?=
 =?iso-8859-1?Q?Qvb/RyJlEagbym1GLArxYAXJvQeqaEu3qNN4iB0WW/DyFXHV3AVEgjUCnS?=
 =?iso-8859-1?Q?5O5nVeN2QnGC5YZsRYJZDf79UsZVJlFam+wpT7N6gFAYt1d0/IgWNkaoDh?=
 =?iso-8859-1?Q?CxXJS5LgWz6E8T/gdvGq+tjYLUfw/zAo6xCjvpZ7TEqVcgLO0VOcds7L/y?=
 =?iso-8859-1?Q?aByGWtqHy4cvMa1hyCeW3DPuwB956RcKlCr/6aiCXehY1tQoEkVY+lH3mn?=
 =?iso-8859-1?Q?HzNS/KFoJf9pha4pGvq38ci8ldbK1bZT8ij01PPh7LgoyiAkXoJbKHIbNp?=
 =?iso-8859-1?Q?ehPWgN5oS7NPfnp9qDKDh2u54qkvwKYtj433PDdNq8j22Jt3irwhLgbeZS?=
 =?iso-8859-1?Q?gzS9EliEVtjNVdzNHzlZOSU3WhW7NiUaQbXlb/OcA+6FsRg3X0EoeYHkaF?=
 =?iso-8859-1?Q?z3x0FUg00fiLr/HBKYpjkKpKwKrO4jUtmJUYgfOyu69bHIzZ4hc93VwDb/?=
 =?iso-8859-1?Q?TB4fB4Jof/2nyRJvQ8Gu8Bb6kZhC7VdHQiD1i9E8y3gnnWTOWvPajodH/h?=
 =?iso-8859-1?Q?LgOdofXp8opBIx5Nq9xO9zSV9xny8uO5AwBzc3liGfz23g85w6aYR5zngz?=
 =?iso-8859-1?Q?pJE9GMGL4AHZvcDJaDCqb57sU2RHKkRDZ1cXe+idF66t0t9h/9X3WCN2Ik?=
 =?iso-8859-1?Q?aXdWlCSAotLXhjUk51Tjlh5P/MVMgtNyH3mrHwbdOJchfH184rIJ+rIFhO?=
 =?iso-8859-1?Q?TFT59+EXKFWHhPYViLH3o0wYQdMi5PjmgxdLgOnCXhHvfPShqsbtvJDVBS?=
 =?iso-8859-1?Q?44YMb97cXFfK8bBhlWQeoUDbCGMyHw9IkwnrVCaROmqpf7SdHG07bt4oA5?=
 =?iso-8859-1?Q?E9dyuF/GuRR8ZXnDzDbZhn+PVjjdTTyvLLIJzWGpmpyXtRZpz/bALVzKV9?=
 =?iso-8859-1?Q?FVPBGxhqLLJ+E7ZgfnN9YQrfltjVOJ75B3g4r0DHKdi1BmHOyh3lZEqw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed42c18-d9e4-4dbf-5889-08dbcfa8e3e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:07:29.1236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLKVV2wMntHSF/mHTZzMg2wQn+kOUC5eoI7dDVgvG0/+N6yfuDz7xw7XMvTOODHxz2gaNbsTorRVKgugh2Exaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Greg Kroah-Hartman,

On Tue, Oct 17, 2023 at 06:56:56PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 11:06:42PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a -99.8% regression of stress-ng.splice.ops_per_sec on:
> > 
> > 
> > commit: 1b057bd800c3ea0c926191d7950cd2365eddc9bb ("drivers/char/mem: implement splice() for /dev/zero, /dev/full")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > testcase: stress-ng
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> > 
> > 	nr_threads: 100%
> > 	testtime: 60s
> > 	class: pipe
> > 	test: splice
> > 	cpufreq_governor: performance
> > 
> > 
> > In addition to that, the commit also has significant impact on the following tests:
> > 
> > +------------------+-------------------------------------------------------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.splice.ops_per_sec 38.9% improvement                                       |
> 
> So everything now goes faster, right?  -99.8% regression means 99.8%
> faster?

let me clarify.

our auto bisect captured this commit as 'first bad commit' in two tests.

Test 1:

it found a (very big) regression comparing to parent commit.

19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  12433266           -99.8%      22893 ±  3%  stress-ng.splice.ops_per_sec

the detail data for parent in multi-runs:
  "stress-ng.splice.ops_per_sec": [
    12444442.19,
    12599010.87,
    12416009.38,
    12494132.89,
    12286766.76,
    12359235.82
  ],

for 1b057bd800:
  "stress-ng.splice.ops_per_sec": [
    24055.57,
    23235.46,
    22142.13,
    23782.13,
    21732.13,
    22415.46
  ],

so this is much slower.

the config for this Test 1 is:
testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:
	nr_threads: 100%
	testtime: 60s
	class: pipe
	test: splice
	cpufreq_governor: performance


Test 2:

this is still a stress-ng test, but the config is different with Test 1
(the bare metal machine config, and stress-ng parameters):

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
parameters:
	nr_threads=1
	testtime=60s
	class=os
	test=splice
	disk=1HDD
	fs=ext4
	cpufreq_governor=performance

Test 2 shows a big improvement:

19e3e6cdfdc73400 1b057bd800c3ea0c926191d7950 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    171798           +38.9%     238710 ±  4%  stress-ng.splice.ops_per_sec

the detail data:
for parent:
  "stress-ng.splice.ops_per_sec": [
    173056.44,
    172030.08,
    171401.68,
    171694.23,
    171001.19,
    171606.93
  ],

for 1b057bd800:
  "stress-ng.splice.ops_per_sec": [
    244347.89,
    259085.63,
    231423.88,
    232897.93,
    226714.77,
    237792.34
  ],


there are monitoring data such like perf data in original report. FYI

> 
> thanks,
> 
> greg k-h
