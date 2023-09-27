Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2784F7AFE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjI0IWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjI0IVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:21:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50561BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695802904; x=1727338904;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+yLGsW4Tujb5/1mGR4GRxGwbzbhgsqNJ4T5Mrkzp7AE=;
  b=G4WsOoQBch10OdrvySeguM4yW1TJhB7sHP8CTLQrpKtawTRJPswU57S4
   FrhDI6IPR+mH5gllzd5i5WRxZm9Qgruy1k4KrThZJuuWfLxIIeEz41L4y
   ejILb32F9/+xluSHKMjW1AR8yGm91aCcoxYvcyPUoz+9gjkuN9+WTANjy
   3Rw8BemOyP9GuBJD/zWtDKKc5F/aVAA6KJyb9azoummamuXs82Pjhmf9s
   hLD8EdNlj6hqak1oUl2MSegVwwKu5yuAeAMgGSmLACi6hj4jCtkxr0GSb
   7DuLTDt2E0JKd4KA8NCkQQpns+77/8An5CZfPWkyb7ubj01WSMz8BwizV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="468048826"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="468048826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892518517"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="892518517"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:20:36 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:21:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:21:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6STi66ur8bCcS0Lq/noPRsZ5tckrGawCwzAoXOypzWgaxSnSaXavm4NqninZyvmPlwZi2FOmV2TCpgZzsPRuSQfyUjhI/uU2PkJgRGXk5T4yjCIYWSIsXTtObJ4G5udg2NJbGx4qWEJSUawJp1ByoKo3nKz7ix8zjnLqOv4kAWsim3c3mYfyraLMwArCDnh2/BReNMUC+vaxJkHqme0FcYv2z+oDVFJpHI9I5CaPAcJxREqR5hAgZXYzF88tqcpplI7LVQBRfhKPy2YJlW4BXBYCQjdtmUE1jufoLO4B3r5C6brVGoSlgvYq1phYuUdijjaeMlTTn/1rOTv7DYoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl+WCCsTjn5khTZytSVYa7T1mHQehEu5LYfrct/tHVo=;
 b=EG/cJ7xf6R+VcjlbuZYMijS+HaRXnjLoGs6NzShibOjdpiS+50yaPvh+7WSV0uDIm2G40d/CVaG95m1MkNiKLX6V3EaqV+1pWc7mVXFry20WE6fg8VTiU9j6g/Z1wKvtaN8b9VZ/qGJCBMaoYmgVxl4j/+WQKRZZLRZ9xcC+4VP8gDDr7B9cE+8dqGJTkJdDxE8HGeR1srh1i2HYG399FRXN2cZ9nioN8XO1oE1GbA19OLl4pMdIYVFsXZV64ZgoNlhXquTacoWAgE5fDzMnZuWSsBBkS4GZFRfC9gLPhTnoN4AZsfHkHixDQF1073AhDpwRx8wRNomTvW53qa4r+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 08:21:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 08:21:30 +0000
Date:   Wed, 27 Sep 2023 01:21:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Thomas Fossati <thomas.fossati@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 2/6] configfs-tsm: Introduce a shared ABI for
 attestation reports
Message-ID: <6513e6079a427_91c1e294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570182987.596431.14062417344858914481.stgit@dwillia2-xfh.jf.intel.com>
 <c3d347a7-58d6-4830-aad4-d354b83f0704@linux.intel.com>
 <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+1=6yfmLXJbZu7Gd7cp_HOAbmHwx54aPgozWKBikWwZSYTOZw@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:303:dd::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 1194e3ff-53ef-425e-158e-08dbbf32c08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXexzX7VV9sS1roHgEawhGShZtRwixAXCCQsiZ1pgJM6c80g1QWpqnr6u6MBPgPxW68Q1AfVjtutRQN4wTYOnoBXktSKk6coVT2fzR+sMvofuAuECT9uBfJzWlZq9K6fu6AsMx/Tpchw5/HKZPyA8bWroqbBdf88hjz6SPi0/n9YaBV/VR7y20IOWxRb/IqTi/Tk+QGRRy1nsOObbMnItBFMVZyLJjyOwP6ZteOjjO+fzy6iea04lGju1vVRV/DOPnLwLGcSxzzBwjo3N2CVhZMvQundqkc/copgPAevJVAzC7+wYDMoIHY1SmAfd1oJvXXlMuKxheJlqqIUlNTPe3ixPyuVF6zH8xxLRRn4OmteeV/emG/L+eUpXuvsuCPTxZpOWkY+ltaUZ9/Er/zFPOKxLOuY8IsKvV/SXZ7RV+2pVttI8STUEutH7qFp73qkwqqt4iGkmZdz42TdhemFQi/MevjTQ3k8od8SlljD70zIjJczm7W5EMGkgQ0xURVmPnq1f2LwZj+Ntsp4/a5QwRFs5m54wCu/Sd52pf0Lr1AD248Rs5e5WXtykyuf6A7zS2Trpm+55kc7RrHpkZh3FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(26005)(8936002)(5660300002)(4326008)(8676002)(9686003)(6486002)(53546011)(6512007)(82960400001)(478600001)(41300700001)(110136005)(6666004)(6506007)(316002)(54906003)(66946007)(66476007)(66556008)(86362001)(2906002)(38100700002)(4744005)(966005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGt/EsURtWwJz6C8Sr7LogUZl66b51mPq7w085GAmQ4tPxffd283nb9zwN8G?=
 =?us-ascii?Q?VcuKNF42mjBMTXvK/NfH+N2Wm8Q09TlLrjI7ZRrKM0RlN8jHFFl60kPy/xfh?=
 =?us-ascii?Q?yQ8HFsAkNjQUVrv57t/nNtf1+Tj4akx5cvXp+q7CUDE/8M7orc36BLkFvfOD?=
 =?us-ascii?Q?3riPKlG8mx2DQDjnvP5N+RNQPzJJJZ379FUNZy4znMItF08CG9GQM4/c7jUu?=
 =?us-ascii?Q?gRLzqnNGpX08SkZ+bNl3VglmdwjLEfW9HgaDNlLlU9hlCg7UX4J7+KOff7o6?=
 =?us-ascii?Q?D3HhnDkygomKHydXiwQyLQlj4c4uB+9Jiras7LUyYSwUsDGfN7ja05zumb2f?=
 =?us-ascii?Q?WFXEtktHAK7BsQIWxoa/ofGKitbTzhkc/xehOIw5/FQWXy5gA074GLXjOIE0?=
 =?us-ascii?Q?0uIQuQdLLkOFBNJGmEBhBP6J4zmrVA1hSWB4HV5waUDO8dOavp4FotlTbwF4?=
 =?us-ascii?Q?fkoiWMWpbmjEy0MyhCc/w6DLThk2VI0lnxw0k1696Dfa47T86yWXWVTlbRb3?=
 =?us-ascii?Q?sC907vROD4ZY+TpIa9CQBGpotmgasKzYjyqBd303MPsDpmwWidx+o+GjnCZT?=
 =?us-ascii?Q?kqGOHSU1Kr37NPKq/+Z3YHNkXt3JDFrSsVFppYKW8xMIEI6Mx1snFt9N3uqt?=
 =?us-ascii?Q?GeBmB/m420n/nS+C93xyc5ZPcpAcs/k0/FUsVAO45+OwqyDUIkh7ehhYIs5p?=
 =?us-ascii?Q?a17LWiUTf5ZW3m8fTAvZA9C+tPXN5UzSNAXxZhk5HRdUZnGS6pUX1FIYY9Xb?=
 =?us-ascii?Q?zUcvf21dkl+fI/J/BBOHow/sMWhqSR4aTZBLjd6R/vp9DvblIQi3JUFiLKDc?=
 =?us-ascii?Q?qFoJrJX0L9czHxHiBArPop0+GPhnWs9Je73lu2zxXeavvPzkwkoKdRYL9Ddd?=
 =?us-ascii?Q?i+52H6RUnVgucxHzlQaiT+fCk6fAgH6KNHSL4StijPJpDqDFYBVmZK1rpq+X?=
 =?us-ascii?Q?UdrcuY6ksMzBV1r8Fw9eNH9rwbwRMSu0dvzwvo2tYBnVaSFbKpoepz6i7lFx?=
 =?us-ascii?Q?b+yi/1azRkB7YnQIu+3Pd0mGIpmOAl6+OCDypFS2tiJirheuKyEglhrik7mR?=
 =?us-ascii?Q?CoRvCTPAHe1XV/F+1bzx0GmS+51pSK2PFpKxv8ArDnODGbwxF739lDFgpP9A?=
 =?us-ascii?Q?s8W3syZMtUN7vj1KmZHdYVcbwe/tleb5ddTrgPEJ8dmQqlPzATQBbIdXGNuF?=
 =?us-ascii?Q?uHl6qB7P2+bOIuj7qvSEvkovQ4ZlMPs7iAIp6vrR5/SjHfD7gFOAAts08F7Y?=
 =?us-ascii?Q?tlNorK6SIDpwaHfZ/1S148Gbvyw0ox7ExIOFjaldGfLz8B8mEl7JrxA0o34p?=
 =?us-ascii?Q?TuSodINA+4MJvRwLuBl+miKh3IISMqb3QN0+GVH8QPyqyODYSsf2JcdDDG3r?=
 =?us-ascii?Q?yOtKIu5x3C18aqX6m28Vej2h2ofmABhgHDdpReOcD51lxiz5e8WhwztiOaJd?=
 =?us-ascii?Q?JHwLJ1YW8VliNFnx4esMUxTldjv2/ykB5AuAC8ORZphinmchFwCg9QmdDlcS?=
 =?us-ascii?Q?n5HRdLCTgW+xtFZ+n/ybNKLbR0+5sWx2CKH3tBjF1WM3+k/9Ej/H+ZN58cns?=
 =?us-ascii?Q?SvxPJU4dRP9BeQkGhzDBAMK8TFUtBKth6H7HbDVw54z0NssLE+lt/v6KVWzS?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1194e3ff-53ef-425e-158e-08dbbf32c08f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:21:30.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG4qaVQkq+3PTuzfWt0bRe66mUKL00jhJgBjJbG03imO5YxWNEwz+GFZYBxViCN2q3epFhbY6Q60DiZsd8SUEgKtuRA0fDfvqK5QOF0IUS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5617
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

Thomas Fossati wrote:
> Hi Dan,
> 
> > On 9/25/2023 9:17 PM, Dan Williams wrote:
> > > +++ b/include/linux/tsm.h
> > > @@ -0,0 +1,63 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __TSM_H
> > > +#define __TSM_H
> > > +
> > > +#include <linux/sizes.h>
> > > +#include <linux/types.h>
> > > +#include <linux/device.h>
> > > +
> > > +#define TSM_INBLOB_MAX 64
> 
> I guess @inblob is supposed to (possibly) accommodate nonces from a
> challenger, correct?
> If so, 64 bytes may not be enough for attesters that produce
> EAT-formatted reports -- see [1], and [2].
> 
> [1] https://www.ietf.org/archive/id/draft-ietf-rats-eat-21.html#section-4.1-5
> [2] https://github.com/ietf-rats-wg/eat/pull/421/files

Hmm, but 64-bytes is the hard limit of the supported platform
implementations.

It can be expanded when/if those platforms expand the
size of the supported user data, or another configfs-tsm backend arrives
that needs that capability.
