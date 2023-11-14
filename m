Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2C7EB7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjKNUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjKNUdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:33:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4F7F1;
        Tue, 14 Nov 2023 12:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699993987; x=1731529987;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=HKNLBVi/uu5buORnrJ40SoCVcpO7bot+2hpeBuTdJq8=;
  b=nSyzurO8IIA8A8vri0yXqzgaCpyWel3F1evpqfrH3v577PVEgma8fGX7
   m64GuCOAItoTK/hNHx8odwA/yzdCa29tQm9t2I2prkXmi2Q0qryseHJF0
   vlyf0bB8ZdI68NTNWPOxRnpE+T/j3rbdSk9aQLrxMLTJCmZhVyrryjC+L
   q6enrjKXKKORfwuzxRUpEaoEN8RZIoxqPpwc9m94nQZxI3ugC+4T3K4dt
   E4S6ZUTkg1DjMs356wnC0Y7DiVEMGDrejEZ2tR+ByK6mk5Mslap8CTF76
   rBLs803BOUiD9cOcpA4OD4DO0OfY0QqQNRAOUdoNq+msXJwpw/8UMTD7S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="476962218"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="476962218"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 12:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12911543"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 12:33:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 12:33:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 12:33:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 12:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6iBHBW9YZ88APemq5gA6CVmneH3LfuxegeDWI/z5Il90nuBZeFcvjF3q+nI79+uhRxTzibPFzSmn1lD08VG8qPJkPelnniCj0F6/OMY6lIjm6vtcDmswUanL4ESQkI6VzHRQ+4bi5kNSi0xYaVjfI7OKQTdult3QaRZrj++zLZu6TCnNaGxJEjeMFBFjdzh3PiV75dp7XQX0DSSbAdtyysNBAgu5Fq8gV6agrw6xJA+My7zloeIrbBPVJzPSqbbLRXRdpnsMclo17cCaKOy6qd3LAz2rZzvkV0IOM6/Bv1TrFL6/yt0UZg6c3gF85a8GvZuvNBux1Uv2EFJpagybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn65o72jiVA/avvWlfunqrMek4hRBxmxhvug6uR0wXo=;
 b=CXh2qpojt6gfmesh2ldStTzAJaYzWt6GkP3ueCXNTMczC8b6Wmw4vfKwJnWI0bthtZeVEfriWGmSnS8eo87PYVpFo4OHF/Gd8PjwbX65AV5xeAR0Qf7N/8yLvDtW79ynu1xV1JdHp+/vbsQyoS+almFXWVGhF8SOjn6gQ9nlUP6sT5B/WhkSkWGTWbM6Lf8a97/UsqUzC7kX4Lh2Y/mP7s0NvnK8uiKvbYYWpnz/pqqkk5GBMuQQCjExNZ/eoQtB+tya61iazRMFdTlBaAfTuajfITtOTHrJ8KhVHjXdMewWzku6i9Zrob80Fp3nXhGPBE+ZdMwabDtKVNxXgm79Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 20:33:03 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 20:33:03 +0000
References: <20231113163029.106912-1-johnathanx.mantey@intel.com>
 <20231114194616.GG74656@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From:   Johnathan Mantey <johnathanx.mantey@intel.com>
To:     Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>, <sam@mendozajonas.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events
 to the NCSI controller
Date:   Tue, 14 Nov 2023 12:20:52 -0800
In-Reply-To: <20231114194616.GG74656@kernel.org>
Message-ID: <87bkbwvzwn.fsf@intel.com>
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA2PR11MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 75602151-09bd-4a37-376f-08dbe550e692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CBVLa/PP5pzbisMkqbFrXDld+4tmCe0DzPDXAo6lMquJTt7rLXsb4M6aWu8J0i5HUkDSAqAhJ1fPRNsvad/WV1ju7S48Aoae5KpiTGu4Yhsacio2LJvVPQXZLOlP2gIazjzbHxxCgBuEhMh+BT5fpuUxFefbVEgFn+cNNmOt68Ek7a2GNHY34XYscH7uGTLgeXQ3VKJPBfO3nwLkjqa9/i+SNSoS7M7mFkcO/LP6TMePiC3CxUh6+OEGecjHUB97MXM4ejZEPsMBeYbmimKBO81L9JUeQV18btzlyM2GKT6rqXd/H8l5RE1Gfn2/01xwnnsvOZVRlSWrw5H3ZDSr8NeasOV8/FUlSf9Ic+FGike1ICw7VC+2UCUDPtPUxM8IpdYzuRzbZ0VJwzxZkXRgRwREjBYnwxSrGwNijq/OCBJp1VPXWkVuCTx3sTPkpsg4Ck830aDM+BPopD6feRjwd4Gfb7m55mNy+jZHxu39wBFyAdbblU4pDuf1wq2Gph4LR7EcXiWdP5duXYczmAkvKYyIsGOcVC3VDYvjtevWnw8Ts038meyvkPTyo9ZZTEr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(83380400001)(82960400001)(86362001)(36756003)(41300700001)(6666004)(38100700002)(4326008)(8676002)(8936002)(6506007)(478600001)(6512007)(316002)(6486002)(6916009)(66476007)(66946007)(66556008)(5660300002)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/qAihkHRXVg8awInlrbB+yjFFmsX0SHKrLcJrjSCMkpO4HdWp0exGzE8fEk/?=
 =?us-ascii?Q?vRVmfUkaLzImqvp2zVc7z3e4vgNfCwL/D4jtfftUr+oGRcIxx6uR+tdGKWGl?=
 =?us-ascii?Q?lRwU83zD2dXy+JyJxG5o88Cj08sAz+HMPvaOriBeT3B/JYQMMwm0ls/Rd8Pw?=
 =?us-ascii?Q?DPHFzkV7ac4WeWylCXTp3xFkdvAy4fyOPLG95Blc+ElJptKDbOiai3JDMNIA?=
 =?us-ascii?Q?fLnK8wBdzj/6aDBdvoCUOtFMh40nRXxmhi7rD/b6150xN9B23lycz1OzaB3H?=
 =?us-ascii?Q?W0fADBWKdjaRelU2DVp9JDJ1enrCrAaafGur/dO/0RMRxKdc+xq7AsL3luK/?=
 =?us-ascii?Q?d2ETPW/GErSm/odqbX2+LUG/DqdanFuiA2SNpk2VhcBoiTUalNf1R4bIGGvL?=
 =?us-ascii?Q?Fbe6EZoIaMXiqU4VlnolWT2WBKsH7etHdEE7vJ/3+PsZ/YRZNiWrC5FT0hnb?=
 =?us-ascii?Q?6xTuj/uVWekInbXPfHOnR94jUl0k6uKI0m8M3O1pdudYOrciMZEdEOXlZzdv?=
 =?us-ascii?Q?Hg29PqJuAXFt5/JTwmE/s905JpP9HQT5MtyFcYmbwBS3+QVykqDnB7Ctxs6h?=
 =?us-ascii?Q?B2rAJo4kYVm0PKmaKBJ+ZGRb37pUbpBDt7FZaOJgYXyOTMEBMUuxJcvGz4cP?=
 =?us-ascii?Q?3dtGgRzOC+k7dksHch0WZv+Rj/7bG+ORJ94sE8UwBe/rgEKRGVxqiBn50eMB?=
 =?us-ascii?Q?yCXUPPZw1y8wu5HboYja8xVQyoVLpbcILhjfvZ4mjiDJPRmYr4nHZYD1Dcj6?=
 =?us-ascii?Q?J67ssl4pdCzESizOblC+Rn0v0yRyjkkC8d+F/cif1jDF4MSmvN4+Acn1llrD?=
 =?us-ascii?Q?7ldTzk72sQW0sTkqe58mtqMb394/wr7ZHGHyWsYh1wd6AtoeRcsV8470BEEm?=
 =?us-ascii?Q?17Rs4v8Fn4Q4imxjTwXTxlifR2a9am723xofRFMdOrwNfZLyJY8HpbnbPRrz?=
 =?us-ascii?Q?xyJI1veirSswm4TtRUkEiVKvv0J0soIF7d029ZDeItKH/mIvEJKW/axNIYHN?=
 =?us-ascii?Q?FNX9UA5+jxt4HrGqfrcE3ZXntvZPT9wzjkJ7yIdDgFElC8c7XXRbCL8Yb4Dj?=
 =?us-ascii?Q?vIOYB4mKYZiWApVLXvOKnn6NW3Kvm/b6TbPW8IaR8B/oEkNqWz7TONYupjEH?=
 =?us-ascii?Q?UmVb96PwpWM90sDZ6a8r9qmFuIVYRiwNKKTCyiCD4nRzVCkD63xmSBDTlgJp?=
 =?us-ascii?Q?hgOlVV89ayeEH+2plrRQ9XiOAZ861EPg0ln+TW9R5r7zX2pZvvkdSrVi7auZ?=
 =?us-ascii?Q?eoHbvfdwlh2aIANJAr7JGVOTdzSOGIjUjKePuXQAOyXrr336m0o+iijegHAz?=
 =?us-ascii?Q?Cyl43nFoGKEL/6ATD10JFB1qAIjkDzjnbpLfHWLOSO6JGPZSrZloGZCjGve1?=
 =?us-ascii?Q?D6nmmujr7DE9VmUEpGgIpq1Ndsa2byhB3nRETb735U3Wgot+MnmYmBlcE/MR?=
 =?us-ascii?Q?G8J0SbVqV2w0Ce3rtJD/kLBpn/8/vmrwRy8ISpNoO7BrFUrFwNoHA6f6a3hl?=
 =?us-ascii?Q?PPnwnKkFUkj+1VlyO5EcS2xP3RYq66RDtcdnXI68pA8oHaBfWWZ7tX6zrkvT?=
 =?us-ascii?Q?kjGlxpKrqlBucVUAgg5G9eVLXuxM9D2R+TZWgbwlnlXgEdFiDRxq33N/vTNz?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75602151-09bd-4a37-376f-08dbe550e692
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:33:03.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfSI+gLgNkKXlzE3XTeu3Hszh0PE2VaPYN60wMRNIo73Kr0wJC+f5sxX8jwuTnjkE5eWF3svq7JH+GpTn789fWGquMk4+rvupI/8hx4+FZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Simon Horman <horms@kernel.org> writes:

> On Mon, Nov 13, 2023 at 08:30:29AM -0800, Johnathan Mantey 
> wrote:
>> This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.
>> 
>> The cited commit introduced unwanted behavior.
>> 
>> The intent for the commit was to be able to detect carrier 
>> loss/gain
>> for just the NIC connected to the BMC. The unwanted effect is a
>> carrier loss for auxiliary paths also causes the BMC to lose
>> carrier. The BMC never regains carrier despite the secondary 
>> NIC
>> regaining a link.
>> 
>> This change, when merged, needs to be backported to stable 
>> kernels.
>> 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
>> 
>> Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events 
>> to the NCSI controller")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
>
> Hi Jonathan,
>
> thanks for addressing my feedback on v2.
>
> So far as addressing a regression goes, this looks good to me.
> But I do wonder what can be done about the issue that
> the cited commit was intended to address: will this patch 
> regress things
> on that front?

Unfortunately the original issue will reoccur. I'm not sure which 
behavior is worse. What's been present for the lifespan of the 
ncsi driver, or this new issue I've introduced. In both instances 
a cable unplug causes undesirable behavior. I'm going to 
investigate solving this for Intel's specific use case ATM. NCSI 
has numerous modes in which it can be configured. I don't have a 
good feel for how to generalize the code given the side effect 
introduced by my change.

>
> ...


-- 
Johnathan Mantey
