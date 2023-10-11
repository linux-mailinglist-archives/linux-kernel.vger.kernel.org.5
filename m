Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28F7C5022
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjJKKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjJKKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:30:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB094
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020239; x=1728556239;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nlsTfiXKPQPHw8msThPv0xS5ykRfx3RRLrj+ZA2wZG4=;
  b=Hi58YiRQUTFz/ijFJqowZpm+r97HmDiIwcbPjmf7rKSTeWb1sjBQAtf+
   mnGr5HIDha+02/fgMuunD3dNk8a7Y0JxZKxoMf8iG1JSFTAM9Yc67sGJ8
   79t15XJDCSwMTHFz11r2Q5Vn9BtG81N7VPtRBkHiU1V5zETNZIgpbFSZC
   UXSssIUX5mIg2wD/YLK8ZKVTOHYLYa69LfOndw7zbNxLByqwf6Z+Un0I3
   pwIBJohUuROILp0QavZKgLsX3wiGKfwCKNUoK3bCCBInYE70YI12NyjwX
   a7vwNJO9G+4cJh4x7Rt9UqIhzrbwFLLkI4WfTW3mnbNYNT3oGJERzRaFD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="381875559"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="381875559"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="870095102"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="870095102"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 03:30:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:30:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:30:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 03:30:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 03:30:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX03wVAJf2wsooGeqH2Bn5OqEybiIWEAnqdigXnX96oxEQVXX4hbIRsR3omO9jXu5MDk1s1iEu3F57TkfjL5Qbyi8fsDXX2FIIhnAFcU/L9FHicoYn5xHkVUeE13SYuTW6kfQWWsk7KowvoHOJNfuCmnH2gCsEVMZis/dVuHBHGKIYuc/HdF6t0H8KbKq4KRdbP60JSDMPIUIYqBO84HCf3N1zt9Sde9DRnnGTuPk06a3LhfVsBZ4Vq6fAQvbU/rim2EYZcg6/dDGe3BbSWows2gWn20rzVstNaQlfhGAkZ2kW5wXr2DnNPFPe1oVKnHBkPTRCcm3XNDOT+ZAozLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcBNuppeNluhl9On8isrDngbRd4t0wsG+cYi0Xn+8vQ=;
 b=YLNTS6s/Gal71r8Q/ck1E9BWV+hrobyT5fU8IZVLe2JD/LC/WNjyKmKcFqoIVT/xA5WHpb8YxwoaTOFQo/mR4iPDtHnt1Vfj7CyBMpTXtyMAFHXUZJ/Zrsbf+q+PP1AS76d98nPqF4vo58OGcaYiL6kwPMGon/wbDU1sb3R9XSRLMFwjcOuWoVK0tsRpyAmsgu/K/gaPo6DIinqB06DalcM9DtaKivO0uhHV8aHW9VuX175CeN9p29+n5zVNCSB+fNTTsXQpROmoNpV16OfEsiB9S8ykS1YVa1ie24hIlu1pSovUJTEhC6OdAZ1ddbX8vc5LUSUjtJRlac3njdBcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 10:30:36 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 10:30:36 +0000
Date:   Wed, 11 Oct 2023 18:30:24 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Phil Auld <pauld@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Tim Chen" <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] sched/fair: Use printk_deferred instead of printk in
 pick_eevdf()
Message-ID: <ZSZ5QE/r6GD5mOEf@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231010032541.339606-1-yu.c.chen@intel.com>
 <20231010075928.GA377@noisy.programming.kicks-ass.net>
 <20231010122600.GA477540@lorien.usersys.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010122600.GA477540@lorien.usersys.redhat.com>
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d95be6-626a-4d0c-d237-08dbca451b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRBu7IPmBYcHbX0OKsTg/IzFWIwpGUXZbdCDVjXvw13je6blaNh/ydv5SpRRyKXZYROcQKl8zMpfMra9sG7w4Eox65Tcm2zr9ZmBPx/+HLhfHtlzfpM4pYJ7BQRY3jEmSc8DdqHmJwt+/jX2n38OtyMETFkCqUSBGvoH+usKYZm4G1ZUq9qBdjr6wk3Nqa5vBbokV2ruH7F9k8bI0VwOcr3hOrKtO7wWrY3Alesk4ncnYNhOJqd9DAqKjjO2oaY6GX/JJHJFFBVBcun18eKwbbAH97g/lJgmyw/fYNhnskWbxGSx3AlI1+WvQ+yB0So3pdagucOMs3e76joNw+zdV3zXiEyR+xRpcaE7BJt7anaMzxhbpM4Iz3ZmehP761HbfyeZkrtC0OopTViU4GCpBlioL6gNTi+hchxnKGgJcvw7gZCCSiQHsqSkHn+qT1zORSxuziGablrcMmCHTP0iGxg/mVYO6BFw24/kqmv580SakrjNh9akq4H8k5F2SVFf4XZpf4ljkZQOYeFmmSQil20tbUNbadrzIgle6T3dskPbQS8s682lP+oGV3Xo0Yyj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(54906003)(38100700002)(6486002)(5660300002)(41300700001)(4326008)(8936002)(66476007)(6916009)(8676002)(4744005)(86362001)(53546011)(2906002)(6506007)(83380400001)(4001150100001)(6512007)(6666004)(26005)(478600001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWnxEU3efBGYiLIqZgowcpyo2L5rBpJ3RzTV6feGSuxoeRYWriwOPdCZjUxA?=
 =?us-ascii?Q?roGCPZlH/IBuIN5ofOMjTkx8iQNcYP+f7niXtaKi5Jx8j6tTYh48IRHew8SX?=
 =?us-ascii?Q?iu1tOFmeI4Dcd4klls2PTwQGvIhZpRDJ0ufG8HOXxHuSpYLQOI6byY6akpgv?=
 =?us-ascii?Q?XxS2AHnyfNp/uTxzO0o6FFisBUGEuBDEo8VyeXzwhWhtzYHw4Jo0mKslGPlP?=
 =?us-ascii?Q?GeqnN/qfmHL2CdjPf+fhLPwN1DemtjsUGqDCUdCKmyiHRG5iHMVXmZfNrNMN?=
 =?us-ascii?Q?WEc2ru08nm285Ptvtkzu04MmJa/wtwrv4shGtmQML+LUAFp5F4G3+sej7ly+?=
 =?us-ascii?Q?hmYdf38RjKrbMmsoBSn2PwrC6kqW7iYWYm4RHR7W0bKNn3pZXgdS6ZbbxT8r?=
 =?us-ascii?Q?KCTQUoXRDFLPt4h+dFFCVIuJnQxvh5CDN23AmRf+kYduaTbyL1pVGNJeUX9s?=
 =?us-ascii?Q?JQXr/r9o5mGqX96qwRsHNaW3q/yWPTizjSiQqxpc8lVszxulyVV3gLTgxmO6?=
 =?us-ascii?Q?amfIv1o3ybR0h+dAsN1XP3Jxy94x145q1nZZCDuWGNLu7ocqR7PXBbOcQHY8?=
 =?us-ascii?Q?EKplEGI8YBhB8md8mSlbacqG3QM3pG80K2pY8tbrCxJbLfYyWiMU/Wec7JHo?=
 =?us-ascii?Q?AbiClYOQfbs5cKkG+2SPkcveJBEsZN8bWBNH3krkoiRg0CMwHoAY6mlETruk?=
 =?us-ascii?Q?fuSEB27aEHSpI4e961V+uifuX0Q3eTgzgFvTre0UD22od7p2T9llAFqKLqUS?=
 =?us-ascii?Q?U/p2KJtyXDhCwI/4J6sNLdEsqhEKKQy6N9oQ4AdW+tJW41dM/wHjUXfZ9/hN?=
 =?us-ascii?Q?XaFLItUFpQEG44o+st4CSA9CE4WJsOopfMPyRP6PIFyQQ8THIfc9AcLiSlcF?=
 =?us-ascii?Q?u1ppRLxt/Nt/sKuys1ggqb/GB9MGASZ+Qfqtjdu0iE64lXIN8ANv/EV30K+w?=
 =?us-ascii?Q?2adx0ge5wQGijsuXWcS/QlV/lnQUwMkM/KVW7JSmZpfFO1zcvHTVjNHl6tF0?=
 =?us-ascii?Q?9DP5Cn6oK2NgV4xRl5OmHjG+s21NDVKEacqF37gF7VI+nedd3sVMv8/O/XIU?=
 =?us-ascii?Q?Lp4psy/jFixXMLta/RUvq/CVGlW9HL2XdYWx6wIwHnYIDi0ADc+fYz9Hf4ge?=
 =?us-ascii?Q?FYs7UQzb0LOsCHfu6G1Y8zp1eOCpIxe6nXjdmzIVholYj4Sb2bW8XNFFf6tI?=
 =?us-ascii?Q?Gg3EgZ4FqfOp8aKXhiunNKL3lN43HViaA4Qudd0pfh+XSNWpZ6fLC9hfz0NW?=
 =?us-ascii?Q?FqcWB6OpjIJ2TIF7uivMOa/eAH+SRxBn8+KU0Vy69uWM84hTksZa004sK5lS?=
 =?us-ascii?Q?gmLZ8lf+2p+TEOelDblJumTOKYLexjfD0kenPHJiRHmwf1yhvMQ7aGYfp7yB?=
 =?us-ascii?Q?xGF3PJv3WtsnguTyhxIqyL8xdz130keUG7YimjUeWVCPP+6uT1TEC/8tuZqx?=
 =?us-ascii?Q?fYAiF6ihOdkB2LDh9VHPtw05i6BcRM5aym3bta+x7Ztljj3l7L1E/7Sr+MoS?=
 =?us-ascii?Q?LJATSVOj32eQu8xSOvhBmyyi2ACrrt29G0kuQhZSuMybr11zGjSP72xCMsLm?=
 =?us-ascii?Q?90ES/XSwsQMtH6YbV0KCoBlrZ2oZG9z9/Hd1eb2H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d95be6-626a-4d0c-d237-08dbca451b7d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:30:36.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUug9kUztJR7UqSudTlHl09TSX+U+Sd938ecb31POlq/7JY6DEU+1Qonz2ToaKYK82oC7YJ4xE2tRztltdlxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
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

On 2023-10-10 at 08:26:00 -0400, Phil Auld wrote:
> On Tue, Oct 10, 2023 at 09:59:28AM +0200 Peter Zijlstra wrote:
> > On Tue, Oct 10, 2023 at 11:25:41AM +0800, Chen Yu wrote:
> > > When no eligible entity is found in pick_eevdf(), it has to pick
> > > the entity with smallest vruntime. This indicates a potential issue
> > > and scheduler will print this error.
> > > 
> > > However this printk could introduce possible circular locking issue
> > > because when the code path reaches here with the rq lock held, the
> > > printk could trigger further scheduling which loops back to the
> > > scheduler.
> > > 
> > > Use printk_deferred() to defer the console write from current context
> > > to the irq work in the next tick.
> 
> Chen: I was not actually suggesting you make this change, just answering your
> question about printk/rq lock.  You don't need to put that line in there.
>

Phil,

Sorry for misunderstanding that, and thanks again for your guidance.

thanks,
Chenyu
