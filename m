Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374177E421
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbjHPOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbjHPOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:40:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2E2723
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196801; x=1723732801;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5rxvprWplEIWXkI2Nd8DkrqhlC4JuhbRLxznsDM0rss=;
  b=J+s+rX36S/zDTYZ6AeGYrKjXtmaZMdsWfA3pASZ/l3u3sIamBUPs0u28
   51icrePU0F/DNaxikovO0/lRIz+2GjjUppqZvT6vZn0pLV22oZwX2MGpe
   5YaAxoHXeV6Wt7Ns6w3tg8vtgm92bdse1EDx0ndEHlCf5sG0OyefjpKBd
   xGRIMc8WaeHuFiKY7bYuYGK/8EP1aJE9AUNR7goFWAC8QnygIAoEF8lHK
   adqXV9xrdPmZYKXPYa10dN11aSUt7V2lrjGYfYv3VXftWXhXS2eRgOrUi
   ikvp/vZKQqR5tnP3HN6d8f0+nnJFCN/zmdDhkBWlsrVA5XpZn0ekGuc9M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438898567"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="438898567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711134810"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="711134810"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 07:39:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 07:39:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 07:39:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 07:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfBk8PXE9eUKMqzS6cVhZjiHcClRI8nYZP5JPksRNswprwCbRsEA5Vqwy064nW8KV3+PiFdgArKR6R+gIU2+5rOIS6avy9T0oY1vCmFQ26rIrE56F1Aaxwtd0MaVG4oV6Dw67oqc+uZTUl+7gJnl2dAayilg7j4YFor1qbTIZahHNN13kX02/fiFBxcWNJZYBuzxr62I35Ws2Kq7+QvWu6+cDw9SIKkcc4CaYwk7AerzT7KDByvY7BPg/y6ehYXIquECRXkYSifp+fX9G4GJZWvP2Axlw7yy1AsFnKh2McRcSwZVPCeBH/IFfgx0e3A1m7HEy3fvffKzrE+DOA9j6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0BzY5HkWAs4jy575RUg5F6SO8GhRpPrzVEkwEESrw4=;
 b=fk/bNPJnhjwy+XhkEgYUTNXFSudhZK5rsy/ZZdWjhGrq8iN+JINDz1asz+Q1fzCWYdFa+4mV6Am7wiMkL9hxsZFd+3RzngoRF/7nD76b9MnQ2BD2VRoNtHNCLnmu0O3lS1//PwI82lORDhZXPizFToLxLX1NfwvsjHS2EQnjwpZIROf6k2Yv+64aB39SMoyqmDYXzHPdOYsJaaWHIomlCUrK7HBnTZm2cMHcPxZTSsJOwxBHwegkLlWQ9IVuYx9pa09C+z7USATQHoqSge0XllYf1/85TYJbCpQLQIxgcYflVnyvcwKWKLsTo6Ys9/xroR67a6ucKqEHdwPgSh3Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:39:16 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::589b:22b8:e509:c001]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::589b:22b8:e509:c001%4]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 14:39:16 +0000
Date:   Wed, 16 Aug 2023 22:39:04 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Yujie Liu <yujie.liu@intel.com>, kernel test robot <lkp@intel.com>,
        "Kees Cook" <keescook@chromium.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Conor Dooley <conor@kernel.org>
Subject: Re: error: A dwo section may not contain relocations
Message-ID: <ZNzfiHjWIndfP63P@rli9-mobl>
References: <202308090204.9yZffBWo-lkp@intel.com>
 <CAKwvOd=c94gknBq7TUsQEyC095+1iRW540=xD3zRkf3+Q4vn5Q@mail.gmail.com>
 <ZNSWMgFF529bGy14@yujie-X299>
 <CAKwvOd=DC9Ws0+77=6d2M5TqnU=ygCV8HonHKMF7LzzL67z8VQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=DC9Ws0+77=6d2M5TqnU=ygCV8HonHKMF7LzzL67z8VQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 276684d8-b2c1-4a8e-52da-08db9e66910d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVCTRN4oPWOXn7y1wX9E4PHSi8CqZnQxXk/mJq+U0XBn0Aup2ax1WD5No86IjFB9Vt7ojeA5rQG65IGDpfY+au+Zmw5ZIoHVSwCiKHdTOHzHCVc2y73vrWeVs++JMyvxoDIkha0Dl2ovZ4iUI/dxZOUjjZppOw2qtzE/hQLQDQKJ1flAej0WDa+oKOIM4fpGLjBHlBgujWNIgYh/COoYSU5TWi12wD9CsheDtP7f+r3946sDLaBUyQuAC/hB5O5wUTPaBnTunLzG2SVi3Ozt85xJ4KGIU6wwqKPYV03YZVS8D3F6b1C3bd6c7LLwDdGu1mHVv1q4ylcGoy4iHzAE3lQ8GXZuz+bT5h7Aq6N/vgMRzFa94WbdnAI+WJcsA+2iuth5Zivgss1xjaaaoQhtOz1KEPd0BD5VShQsNyvSQC2vc93aJlkSJ66le9TRlaPk1sOWlpFEiLJFqGlz2JUgtp1XSr6/lrwbbmfMx80gB7TUteURZzHeVFgU4MQUKlCfuZfaBEAJ3T/hZdVKvmgtKQJHYVRrRoa5rCsXpTLFvQBgUpwXqh95GpNQO4nddIKXsvELLH7hL7QB81hXIa1uHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(44832011)(38100700002)(8676002)(4326008)(8936002)(33716001)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(9686003)(6512007)(53546011)(6506007)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cksrNnh6TEJVMTgvT0gwUWMzNHA3amQyNEsrMmdrR1ZwVUUvWmo5RnF2Ym1P?=
 =?utf-8?B?QkFIemtHWElGTkpoeEZCZ0JSd3p1bUxLOS9aR3VwdHRnTVN4ckFkalhseWVD?=
 =?utf-8?B?T0Q2TGxueVpSb3FyZHpMMjBSeE5oQVEvMWVsM3VMdDdoVzhhOFFMeTJlMksz?=
 =?utf-8?B?WStvKzBPYXM0M2oxZy9WUUM3d29tOTQ3RGhDL0RxOFBneUhJZVJPN2gwR2p2?=
 =?utf-8?B?WEdaelhZMHIrTFJ4c3pFb2dJK0QwQzNLZjNlWENYZUMzYzNGYktGbDErNkRX?=
 =?utf-8?B?cE9qdUxVOG1vaWFaRGp5cG54OU9WbVcxY1RWOWNrMElrSDJxNXJUK0EwRDFm?=
 =?utf-8?B?Rm4ydGZ2dlcvUXRRUFowRzZpek81Sml6eVJzeng2K2NLRmdlOFpRVHVMMWVH?=
 =?utf-8?B?NGhodUtRQzFEOGlGcDJWejF5MGhlYi9FTERqVWpJU2RYQzhKMW1TenBMYUg5?=
 =?utf-8?B?YXlleDBZN2gyWHBsMlVjSlV1bGhwNVg4VVZCS21iRlE3TVBWWGN0dDd1dEdr?=
 =?utf-8?B?SUx3RHltN2hZQ3lCQ3BZMEp3bDNIaFdjbDh4YUpXaTA4YkJwNVBCN1I0RkNU?=
 =?utf-8?B?cWVGSUlKNE5PS2RVTlcvblpXcHFVazNDajAvTFltQnFJcTY3NVFUeGJ5UU90?=
 =?utf-8?B?U1hJR0hFY2lieVdtK1lhbVMwWWNLaFNaaStYSHg1THZzdkptMm4xMXZoU2VX?=
 =?utf-8?B?dHpJLzBIMi82RTVIbERvM1pXRHRFaTJyL3NCZk1ya3JOVkZpdFFOQnBxaHlY?=
 =?utf-8?B?WUN2d21aYVQ5aHlMc3dTVVE4RjVYNmx1Ui9qd1VsZ1RSWEhuL2dIWTZpOCs2?=
 =?utf-8?B?MHVEcC92c3hSVlR2NUl1a0xrZis2TTZtVTVCQjd6NlpNelowV1VUc01XR3F5?=
 =?utf-8?B?VWJsR1NQLzA1V2RJa1IrQmp0ZXJPcE5JVmZPMERkN2pOMWp4bnYxY3hUYi9s?=
 =?utf-8?B?aVdYcEkxWHB3ZE94RzA0MFdGaUErWVhHZUtlMmlMbFg5T2ZFVUNFbVFjMUti?=
 =?utf-8?B?ZnVtQ1hnU1dqZnBJa1NxRncyc3hQdHhvSHNFZWtVZitWbjFyelhJZTJhTUV1?=
 =?utf-8?B?RktZSVJ0NXgwMWZ2QVpJQjFiVjhBWENmbGZpRGZZVjJWS0dwczRrdnJJdUNj?=
 =?utf-8?B?L1d5eENiK01lekZ5MG9VU3luYmJDeVA0Q1NCSVJJZm0zQnlxZWpQK1RWeVlq?=
 =?utf-8?B?cXVOdWlPYXNvTzlKZDIrVzNiODUxY04rOFNpc3ZMWHo5QlV0VmFkNFkwbHZQ?=
 =?utf-8?B?QVV3ZkVHNGtoRGNNVkFpdkF4SmRqdmNWcVRrVmNzTDFiZmpvVnc3SGdUK08v?=
 =?utf-8?B?K2ZlQlJ3OEZWNFVmbFN1MTMveUIzWG5ITE02cUdOM0dJbHBVaXhqWkgvM3FN?=
 =?utf-8?B?SDB0WEpJTjBaMWtCK0JxQm16c0VtQ1RpV2d6UjdvUGM2bVVmY0pZMUN0ZGhY?=
 =?utf-8?B?ZmNyU1c0aEV5S3JwajhLdjRLUXRTQUZCWW9PdEEwcWNYN3ltNEZGOWVBMWhT?=
 =?utf-8?B?NkVTZU9Xa2pETEFCSlg1TzhEL2xPeFd5V2NsUTNrcWdsdUJYb0FYOHd6VmlO?=
 =?utf-8?B?OEMzUWJQQzhSV2lhcWRUYUhvcTZkQTJ3SXgxUGdXc3VBUUVPTGg0ek9vTkVh?=
 =?utf-8?B?YXhEMFlZNDg1akhyYjlTUitqU0VEek54WGFzeVhaSmJqSkQ3ZUhMVEx5bDk2?=
 =?utf-8?B?NzlLMzgxWTMwMEVJdDdFdVZMaFhQRzdBbHhTU0p6RmdiLzNwUkovRzJ1RTJO?=
 =?utf-8?B?cXBrQTZhY0ExZE83SDNNWVcxUml2eUYwSXZEZ3FPbzhlcHBvRmF2Mnl1UEVD?=
 =?utf-8?B?U2VmSy9mK1pRMGVJTjJRN3hNdzJ0ZjVPd1Y1QXdVdEQ4b1hnUzRtaDVaRHdZ?=
 =?utf-8?B?MzZLbHhoYzdicFhJNjc2VExadG5zRGxLNnFpS0g0aG1lZk5ob1dSMXppWDFj?=
 =?utf-8?B?WExiR3NGUEZjMTI3UmpMUU1ZbHI1ZmE0b1VUVTA5a1JGRDNRUHZUSmpPQUg0?=
 =?utf-8?B?QWJzODN2SnlmV0NjQjM2OG8rVmxBelpETVpYQ0pNcWVCQVo3bFVyRGM4OWpW?=
 =?utf-8?B?NGdkSlRKM3ZqSzNlUXpZNXVmdjIva3FOMEpZL2xnZlRhelNnclZSN3F4cVRS?=
 =?utf-8?Q?xLqO9KDQ7Wm5o6h+lBJ78STqO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 276684d8-b2c1-4a8e-52da-08db9e66910d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:39:16.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3V1wbv6b/vVya5raZUawocI7sdcOqPnmLq3E1JUUodLQVIdnCD8SGVE5tZy0H6gN9+QszqKOD+x9c/GGyQuIeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
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

On Mon, Aug 14, 2023 at 03:13:25PM -0700, Nick Desaulniers wrote:
> On Thu, Aug 10, 2023 at 1:04 AM Yujie Liu <yujie.liu@intel.com> wrote:
> >
> > Hi Nick,
> >
> > On Tue, Aug 08, 2023 at 12:46:00PM -0700, Nick Desaulniers wrote:
> > > On Tue, Aug 8, 2023 at 12:02 PM kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   02aee814d37c563e24b73bcd0f9cb608fbd403d4
> > > > commit: f9b3cd24578401e7a392974b3353277286e49cee Kconfig.debug: make DEBUG_INFO selectable from a choice
> > > > date:   1 year, 5 months ago
> > > > config: riscv-randconfig-r001-20230808 (https://download.01.org/0day-ci/archive/20230809/202308090204.9yZffBWo-lkp@intel.com/config)
> > > > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > >
> > > FWIW, I wasn't able to reproduce with the provided config and
> > > clang-17.  Perhaps this is a bug for older clang releases (the bot
> > > tested with clang-14).
> >
> > Thanks for this info. We re-tested with various versions of clang.
> > clang-14 throws this error, while clang-15/16/17 have no problem in this
> 
> Oh, interesting data point.
> 
> Ok, I've filed https://github.com/ClangBuiltLinux/linux/issues/1914 to
> track this.
> 
> Will bisect llvm to find when this was fixed.
> 
> Then we will fix kconfig for the split debug info.
> 
> > case. We will consider adjusting our compiler coverage and remove the old
> > clang-14.
> 
> Documentation/process/changes.rst lists our minimal support for
> clang-11+.  It's still useful to have clang-14 builds.

Got it, we will keep clang-14 running, and ignore this specific
error.

> 
> >
> > Best Regards,
> > Yujie
> >
> > > > reproduce: (https://download.01.org/0day-ci/archive/20230809/202308090204.9yZffBWo-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202308090204.9yZffBWo-lkp@intel.com/
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > > >> error: A dwo section may not contain relocations
> > > >    fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > > >    20 errors generated.
> > > >    make[2]: *** [scripts/Makefile.build:288: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1 shuffle=3686795728
> > > >    make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
> > > >    make[1]: *** [arch/riscv/Makefile:120: vdso_prepare] Error 2 shuffle=3686795728
> > > >    make[1]: Target 'prepare' not remade because of errors.
> > > >    make: *** [Makefile:219: __sub-make] Error 2 shuffle=3686795728
> > > >    make: Target 'prepare' not remade because of errors.
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests/wiki
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> > >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 
