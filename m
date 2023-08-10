Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D490B7782D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHJVtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJVtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:49:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC6ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691704185; x=1723240185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BmcXpR9VwB29jaRHzWk9dWuuuBe/7RlmjCu+HqcMkWY=;
  b=j8szJ6P7Do6AbER0xn9JooQoiTkN/YZIHYPw4xUdXRv0VJsmF2vsO4db
   OVJhPgiOETqKGQRrQTqEp4+nV+TEC1sXhHBzcVmR0zQzXT2w0iJHQucPR
   ppQVckEUUNRVESwmGTlC20SwlMpViY8oUIyn1LCm0yD2SEo9s1r602flq
   +P+qi0GJ62f08s8P4c6cAp/aEXYrdc2OAA/BUAneE0rKFHvPYm881Tnlp
   kOQpPW4BLoqxirD6+zdWX1k+0lBMG46hXTZKfXg2Kd1j3rybrDwjrLR+Q
   5Dkj2cZPAgFFfmRAEin3yqhgc+5C85gMuLWVNrx0Ws5K8Eg+XFonN0/N8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351136470"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="351136470"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 14:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682267658"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="682267658"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 14:49:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 14:49:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 14:49:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 14:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqHsLv7s3j/s2oBJpjxjkr7TZvyYK2wg3ZN1DZ/7jzWfJItwCTVnZN1k8pDNok+JrcuwQ+dfehSo+BlXCcPVx99KhsBGp4iuVsgGlOaq79R9LHtsFndXgpaNxYzWiJaYnnppgH736F0a5+zKSckEU+orDSzQFyUdQeK5c7APWI23XkjutpphmK+b6Jt/cMpOcfX9fuI6DO+0uVJz+CH7k+mQK/b9XeLyeyKmU77b46wgS/T6YAp5GFg1XxvrG808PJyTVv2QqZPlGI1u6DMN9oDCLeFXiXcS/IQN1hQxOAI1utO6146PKZ+TIoLJnVss1iVa8Kfqq9apc3cJAz7b0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjTKC2nFlq3d3+YcZjEOEQ52lOOTxq2HbJyzs5YGmdI=;
 b=TYKBt8o5oQnbrZ1nudVDbfaEgIHXqyVNmrvp5NrO5A6XMOCeBB+5EHyFB4y70agOdueyN3eJ0evgIsCz1pfd7QWQtZo+8rw3u2du1z4S20KfzVSF+Gzysof8oygkuTUsJxgZ//jWsQ8eAsnHM8PhAcQyYjd/eLEUqk6O5DyYkgRgUy17vzWmgRDbBxgRZeeWPU0WET8w5fmBvBPX9al7OY1h4iPBSlavAeEjl2z0dGRwrHhqTCf3BbKzH20oLTafYXOAUFkM6iAlyeKAUbf5obSg4PRNuiFM5ckrazIvNjxJxf5ulPVHmyZNbapSRTWR6O5HMco3P7e7EijU9uRGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN7PR11MB6677.namprd11.prod.outlook.com (2603:10b6:806:26b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:49:42 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:49:42 +0000
Date:   Thu, 10 Aug 2023 14:49:39 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 28/30] x86/microcode: Handle "offline" CPUs correctly
Message-ID: <ZNVbc7qy8k49Dwhi@araj-mobl.amr.corp.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.562016788@linutronix.de>
 <20230810204605.GF212435@hirez.programming.kicks-ass.net>
 <ZNVNibrpZ9bJLok7@araj-mobl.amr.corp.intel.com>
 <20230810210511.GH212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810210511.GH212435@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: MW4PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:303:8e::17) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SN7PR11MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 530f146d-7c01-40a0-9132-08db99ebb44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/uo4aoz8mqDL7I/Be1MepCIJM9SgKR/5/uEtKR0Cz/XYmEUqg6c42F/OU+8K2gIIj1TVXQjemPT+ZFxVorgqx2Hch9pQzp22A0VEwclGIYOH9Rdec6tgYi0nCud261EXso/RIgAiVwkGg21AvdX2MnsGxeC7og4rawkqou8CwX1Y23xLybVc2B0fBI1Aw2gl92pYxfosFTY5xiHm1R72Iy46FRu1NS336fxDcXWhKCgFivCW2EP5AsHiU/xj9ZZy8bY+PrRjE4TABpUx0hbtAsvU0zHk1Hfi7AKwyg/6GVGNwE7ydSM0EkApgt2RzqOQZvg5hsP1zFdOG0F8dDZ8AUDbXvJXrlRNmMWPPPuifRdo6CvYfiFI6tQeDfrXTkK7u8usvr/Hbap8QBAjsWtjEWNdZVmS1Omkb6d+uFmy2Ij7jfXLv9O/DgGbu3ooqKE8QTx4stqX4tZ0nsepDYNJjEidkJbDAiXPbfp1hAPITdBRkJULLjx97ngEqM7jI1bJx0yocp/0mYJN22ANMZJkpoHfOwiSpaaQNaGvd0zXVpQ69Yb5+AH0GZBcptWvyAN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(1800799006)(186006)(451199021)(38100700002)(478600001)(6916009)(66476007)(66946007)(66556008)(4326008)(316002)(54906003)(41300700001)(5660300002)(44832011)(8676002)(8936002)(82960400001)(6512007)(6666004)(6506007)(26005)(2906002)(86362001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sNP1SvZUX3GGSjc3xf3Bxakktr0qiq6gZfLwiNj3P0B7jyRPxoGW2kf4iNfY?=
 =?us-ascii?Q?n3YX5MnMpIOmG9ZIxj1dvPtnAihVN2yCS12x/bYQ3e5uvRRGyoEclPUfmEVy?=
 =?us-ascii?Q?T/sCSlNTOpVb28rNRrhrJeECVCmNkDV6HKiutRXguJ3KYVKlIXlBR1X6FHfX?=
 =?us-ascii?Q?63JukJKRRhnmNKpp9RBb8DY6VGGfI0JOdPcC1QMplgogznj1gUZ9hLt0yBKL?=
 =?us-ascii?Q?O+Ha1MRr0XpTONa2Y1hsFXsSlSG7olFzVf0KeQFlaVGvljWHMcYe36NV3pIy?=
 =?us-ascii?Q?C/tygAIt/PPsZ3VObvVB726XHAiVNqTFtKExJxsIi5JfC5A6huDU29Zfzxxu?=
 =?us-ascii?Q?rU4tcztF8zsGOVC9O+h4Fla1kRXDEY8JtJZ85xTB/LAC6+Spkyy17Z/DmVTW?=
 =?us-ascii?Q?/nTojQKQd3LjumwS/u878KKNAGn1o540X4dIb2T6pedI1iMUVkJEHZcL/Rgx?=
 =?us-ascii?Q?dSdMQsqxElqZ77i1IH45x/i23rwZgSPvzPSxZLY1ANlv90IC1k/BFnvfy9XX?=
 =?us-ascii?Q?SSTCv+07x2i+4bYS/ZXPAa8wmko0w6gbfp2YIhABMH2Villvk5nILKlQbAcx?=
 =?us-ascii?Q?V10NYKlmFOEKue0V9tSiJo6vMpvMcnzWUpiyoU+odWhd3UkdWlohkzxLnq2H?=
 =?us-ascii?Q?/za+w/k1mQKMQI9/oy/Gb8iKz5qlmIv5tJT2Ae7UYlnXzWXH+3xWmEd/Bvxn?=
 =?us-ascii?Q?bEWCxAfIp/cVrKLlsCExvVSHZJTFROnxW5Qglr3Y1XH7dU2PodhvuxkkjeyO?=
 =?us-ascii?Q?0mFAn8Zvco+npyIfCtYzstZJZvGZ0Crh7VIzYe8wyMn2fEAXjTDDfLf1A8pE?=
 =?us-ascii?Q?pD1TRFzSndV/lBAjwRxDyk+GbfC9J961sBf8BAli6H+Ebwe0pIpBIcMZdVOd?=
 =?us-ascii?Q?2YcMhBb8kdfbtwXNtdQGHbxR6vgCEUlGWDrmsmL4rekhHMp4L2v0PMlttN5l?=
 =?us-ascii?Q?8kbuIW+bPpzhUqMhoFZuzmlyu87KIt3lyhXM+9+SQ7BG1BDBnBVnT7qNdYvU?=
 =?us-ascii?Q?pycVAf3+794IBbnrxxlHixIBxP+6ahFtwQ9IlgzQJC6JFz52u0anZwUVJGYC?=
 =?us-ascii?Q?Gw/QOjR1R6T3m1M0X5wDqriN4+6gz397Zo9nDtvUrrskBuhXdmJPJt1um+X9?=
 =?us-ascii?Q?HdiySeHE+bh5H6K0o1kzydREuuL9/wAQ5JX1aJhIIgy3jSLHHkYZAh7uNBfZ?=
 =?us-ascii?Q?p6NjvwT1uuaHqQhT+HnxRD2uNAYTs7FqgdEzcKTnELwTgfiC1kgR2b90JZcJ?=
 =?us-ascii?Q?oTtDuqttBSEW11pfVN99Z1Qb+RTZvCSG3TRhg5vE6GuU7xqp8mCRwUcdWC/U?=
 =?us-ascii?Q?+3RwoBahmmIqKFfFqQYEdMyb3+/W60PjGHrq+/9WdlT0vRy+ZIJa0pnrjXm1?=
 =?us-ascii?Q?mej7Pe65saG3pGp5f4Uqq8fJL+pqri/KFVierqqLOrJiOTVrsd+Al6P1PoHQ?=
 =?us-ascii?Q?5wdMZNQ0z/Wpb+xQ4h6Cj8P9G6pgPQuxqmm/X9w1U41vwYpZ52iluS1CwfVo?=
 =?us-ascii?Q?AX205DQs4nM8SRKz4Mz0ObLua4/XzqchlVXDbiSTWUYq330lj4O/xEAoSuko?=
 =?us-ascii?Q?W1zP8M9w6rqHiMKW8d55THXfkz6ZrZ39dnNpD1YG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 530f146d-7c01-40a0-9132-08db99ebb44c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 21:49:42.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCSGq98xWJIwLN5+iZNJihDxobNV+EMMQHYYWwciZNivAC2C9fEb/y4TLeeN9/+fPJR8bjejrQyydoccK9k4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6677
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

On Thu, Aug 10, 2023 at 11:05:11PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 01:50:17PM -0700, Ashok Raj wrote:
> > On Thu, Aug 10, 2023 at 10:46:05PM +0200, Peter Zijlstra wrote:
> > > On Thu, Aug 10, 2023 at 08:38:07PM +0200, Thomas Gleixner wrote:
> > > 
> > > >  	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
> > > > +		/*
> > > > +		 * Offline CPUs sit in one of the play_dead() functions
> > > > +		 * with interrupts disabled, but they still react on NMIs
> > > > +		 * and execute arbitrary code. Also MWAIT being updated
> > > > +		 * while the offline CPU sits there is not necessarily safe
> > > > +		 * on all CPU variants.
> > > > +		 *
> > > > +		 * Mark them in the offline_cpus mask which will be handled
> > > > +		 * by CPU0 later in the update process.
> > > > +		 *
> > > > +		 * Ensure that the primary thread is online so that it is
> > > > +		 * guaranteed that all cores are updated.
> > > > +		 */
> > > >  		if (!cpu_online(cpu)) {
> > > > +			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
> > > > +				pr_err("CPU %u not online, loading aborted\n", cpu);
> > > 
> > > We could make the NMI handler do the ucode load, no? Also, you just need
> > > any thread online, don't particularly care about primary thread or not
> > > afaict.
> > 
> > Patch 25 does that load in NMI. You are right, we just need "a" CPU in each
> > core online. 
> 
> Patch 25 does it for online CPUs, offline CPUs are having a separate
> code path:
> 
>   microcode_nmi_handler()
> 
> vs
> 
>   microcode_offline_nmi_handler()

Since the code enforces all primary CPUs to be ONLINE, the secondaries are the
other thread of the same core. So they automatically get the update when
primary does it. 

The secondaries are parked in NMI just to avoid the risk of executing code
that might be patched by primary.

Or maybe you had something else in mind. 
