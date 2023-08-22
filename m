Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85C3783A51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHVHIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjHVHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:08:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F381D19E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692688088; x=1724224088;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eQvgv9jsXXaZFiVTOWOjiNJcZwjfNR6MjKjtdxSdaio=;
  b=Lecn/V25ptbZHnCj9E5IA5iBLeycDymjUeC10fCHj1uBn3NSjiu+9d20
   NC1UDQUKTqQKV/fDOKZLX9aaPalCoMK6E0dZ6qhXGxFlHP4wp0eyp+7aN
   gKMNEa3vIP9Hrn5M8UZNT6vjjmqfMOq+Gk8xKAuxLArZS3t8dXYv3ttRj
   KuX6YJuDNVSpX2r35+p94eoCXMQETTVp/eWpk0oEBfB4fb7rc7CdOWEEG
   94D3FE87B5Cp5l2wCjaAEKBtUfMdYzY/yO/CIBwjZuJ/6KRgcKcky/ueG
   jq6f+GTTK3n6T43Ge9rQFTbZgXQVKNl6+AaNIu60P04KgkurJjNoYM/0T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376532612"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="376532612"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859790682"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="859790682"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 00:08:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 00:08:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 00:08:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 00:08:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 00:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/71c8qCD6afrEKYxFd4KlfDwdyA6WDkKDqT6L+SjH7OR/x6SFfL2BmUf6PD/S2M4VaC6GYdyren1AIXDZF4D3kUpkNiq65KU1pFdltyd2tzBUg7JhMUccF3dznyESgbL3ODYE1udqld045llXSAObmz/oQndUYJrOMAiFhkeeczb4xzSV9bRjj7eSbsAsdNCBgTwblZD0OM7JEMBoQRUXXOHkuk7hWi4wSzd0y4AxiiRXQQZOdgO0b0yINrBePt2NiGaQLndj8SpEgfX2zkNhskwKD+pwptvtruLJ1sQLKqpROJTYj09R2EOWVY3ypTSkIWTv/wPzKoh1OWaGsVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Y+V+OAReVuz8W9Yc1T9CJJAYMIeXNzt534AY9MSo8=;
 b=bAF52iRjBRWyQgYMe0giHaYjSPcueFZiC797gKoOa1YCAxJ+u8dyoQXQvg7DE1lD+ZmxniQJcFd9K2ZFdFwGqj6Hjghwv14yHZ6Y4tcUGGB3zWS+Cq02FPSPB/AjTRNtJrLV6wTYYYWbd7H2fEl9uvHEskABXkT3lVutrRj0k12GLC4KWGSRMYmHaY+UWjQqCO7X5TwowYe8YTn/Rcr7vatQZP8eEilqTbe4kgP8EAwCXnIC+xetLhR4XwvPNiyxIm4CS1NgV+Q0Wnzk1xr9hLdKgtA1Bs3xBYe5gWN1ZaGYoLsuk95Mu+kGAk5Bpg8/LnWCdI1ltC8M5CoJ9xnlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 07:08:01 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:08:00 +0000
Date:   Tue, 22 Aug 2023 15:07:48 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Feng Tang" <feng.tang@intel.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZORexC0xTjm1LlWA@chenyu5-mobl2>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
 <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
 <20230816123716.GI980931@hirez.programming.kicks-ass.net>
 <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <ZN7EyZ+BLfjEJTWJ@chenyu5-mobl2>
 <ZORaUsd+So+tnyMV@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZORaUsd+So+tnyMV@chenyu5-mobl2>
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH8PR11MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: e1388203-ca8e-4637-51cb-08dba2de8555
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eWnCuMI07Q8+dX39omlGg8D39g+a42I+cXFWgoXBM7wY+s+WzNPXQ1pYQTtcXt53Qnqzcl6uXw+Ygy9FCKiRvtUHItT2HvmpWawRGdPpXswZZf+0lBaZa4buoYgKfQ3G59A6TZHI9ftJ+ATjyWFAGA1D8wSIZ5dK2rFT4XPTd5vrRV4NyuC8T14RzfXWNEh8q0kEQ6bC9RRIff4lfVFLPynoYmGfqC/n2temLxLtq3SqbWMNBj9MeJHJyPZc0jatxLkpBn141F0db99crrCZNQWrStiicv4/U3qkloLbhq+UUwCj2Rf/k/zDmU0WoVglXzazzWFBtNSlx1GPaPO5yvSFiH98T5Q4rW8ScVoLbdHwS4rqxC9rbUlDqdevXjBS544ppgUS8VM5jD1MHTxMblRkEg83NqBmot+pCfn1WBQAkkqU2FgJS3zth1cx7VuAReekJlH7Nqlf9fu6Gqnh9zbTQCxy4kcRoxU8S8JnpculWq1vJtaU5G3SWZsvrLfdG6twDtOKBukIiE7aTJHTDAeh/2YSqC84NyxFBtT2Ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(66556008)(66476007)(54906003)(4326008)(5660300002)(8936002)(316002)(8676002)(41300700001)(66946007)(4744005)(110136005)(966005)(53546011)(478600001)(6486002)(6506007)(6666004)(6512007)(9686003)(107886003)(26005)(83380400001)(33716001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BnDchKtSKoVIJ3jC2nu+SubXJ3ywtGlGcsDjn1Ah769S06Ac5ZXWJ5N1N4iq?=
 =?us-ascii?Q?MwWdXBspFvJ/7lXPkdYzCi0YuBb97XUvJrPkcaP3AlY4huH5Fb2KPdTNKPvP?=
 =?us-ascii?Q?Ad9eVNsE63M/vmt/waK3+83XexRgRmBwLkwo0uLVEHfVNSeZD5E4yDo1D7HB?=
 =?us-ascii?Q?I4fUIdh6oWnBKAedtLfepTsjaDbqhB12xdiOa+y3KFcyMQ9wMeMTM8o6FcHF?=
 =?us-ascii?Q?NN9/tk+tPsvkk5H3zbErfWH1mmA+58yaGlDamoJDUHNGphcklenD2ZDNuE4w?=
 =?us-ascii?Q?P2e+GHHoPGzaFiVFuV/8X7vHjBSniIrS1u2yoy21fzk58qrWQinK5OuLcYo8?=
 =?us-ascii?Q?XegsGEYYnT3Kn7RVraVXTm3wttAIB7QVR2UoezQuNUbEApiar/n/llZ2ypoW?=
 =?us-ascii?Q?zB4qTb9Ro5yDU7rjwY6m8oYasdNNRZvhxtSNbBXcgygEH982k+AqmrLAuZcy?=
 =?us-ascii?Q?Lw1P3G5iyqbqi8lVhbuwK7zu8avBnwTwAiU2H+CLQ3Kgq0eW4gEQKqVjZX/B?=
 =?us-ascii?Q?C/LrzsgMDcEDpmmHO+66g0dYv1xmwpgiJbIfagAJAgYu08l19EhIUJLoh8Ex?=
 =?us-ascii?Q?zhLE3u7P0xgEfvnEa3c7Dr42W3Z5t7hbfkI1GYV3M2EpQEP1SL+fBM58VEnv?=
 =?us-ascii?Q?xJrnwK54HkJBuM9Nt9xjysX7mPtcR9a/sHBnXz/ObDzwb0UiDHnVxs3J3ctg?=
 =?us-ascii?Q?oCOAmoNiW3j4tfWQfb6B0LautTxhln0kXQk+fuVx38397MdbATKdWBQ/nQu5?=
 =?us-ascii?Q?MWc/GllC+PuU2y8l9GxHwSZNFW7lzCFoZbZuJEDKOuSs0Cv3K3/Qm91+8mVF?=
 =?us-ascii?Q?Iw0EaUGS92k5rGZ+avJOHXO7Q0xis6NFcNFYQciD5sD3VD1wyoguBp3NSARb?=
 =?us-ascii?Q?U7UDicDjb4zFJbHzdvXg1KdCfapgQa7kKi0gjrao3czpIOQH+nia29xSMW7V?=
 =?us-ascii?Q?FZs+pMfxfRKe8jdvkm/bKsaR8k7q/e23vCxZNe3Pxwnfqs5QMiYHlhg0VADe?=
 =?us-ascii?Q?e/3Nhwe0rBq8fVAvhbAmKw5DY9yo2UgWrksKPNdQAzsYFfeqDKSeCKKOGRCd?=
 =?us-ascii?Q?zdDnQdxDpJKOspZelkFQ5GKaWrVwuWwjMPwkZQedOwwjrq8HjGwwOOlquv+1?=
 =?us-ascii?Q?j0YmPRB4rwW1MepSDXmYNXtQ20YsinymSvBGvva4WbExb0xGiYm21iSNWym6?=
 =?us-ascii?Q?mxbCiICCaGCaAoEseKbUn2pnKbVk5Es0KkCLqtYunp5EzFjYPA+tLn3UizLm?=
 =?us-ascii?Q?/ZejjlMjLkdiQLYtE3MB2MOESMSt4AxCsPEP8oFpKiqEwboU5/H1W9IpePcf?=
 =?us-ascii?Q?Jf3txI9h7tBdC9oQclNIIn6FsW+tzQ/3c6Hpt0HPCs21x7ggnIsQujZudIUb?=
 =?us-ascii?Q?T3XYYdy2+eC+NfAkthpf1tyWhznC8JHxP9qYHai/3I8slsSHAmpS1eg0hl4g?=
 =?us-ascii?Q?uAVGbxOY7klvilroZuyIKTsioFof5JTeqV7knLm6OapYh+/Mec35QFVKcAVm?=
 =?us-ascii?Q?dN6nNJrlAS1Tx3933jp8+PiNx22muYl0Ds1So5VwqFVSh+08QaW1fSgM0fty?=
 =?us-ascii?Q?lmcAIDVMQcT0wpK2i19E7y019KknmBAtmCEnr3pF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1388203-ca8e-4637-51cb-08dba2de8555
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:08:00.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNvgBHKeC6og68+X+jOaE0rZNEQJcUP6QOLewoc3kzVmRFtYfFCzudWC4x2fG0CB2TQ6krVChpj5qPqdJLECAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-22 at 14:48:50 +0800, Chen Yu wrote:
> Hi Peter, Mike,
> 
> On 2023-08-18 at 09:09:29 +0800, Chen Yu wrote:
> > On 2023-08-16 at 15:40:59 +0200, Peter Zijlstra wrote:
> > > On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:

[snip...]

> Reducing the spinlock contention could help improve the situation.
> Feng Tang told me that there is a discussion on the LKML related to high
> slub spinlock contention[2]. And Feng provides a hack patch which

The discussion is at
https://lore.kernel.org/all/ZL+R5kJpnHMUgGY2@feng-clx/

thanks,
Chenyu
