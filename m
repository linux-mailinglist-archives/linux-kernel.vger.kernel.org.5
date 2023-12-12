Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7680F74B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjLLT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbjLLTlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:41:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EB0A6;
        Tue, 12 Dec 2023 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702410117; x=1733946117;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vIWEtOl4Uah8SXwm6r6/k3M+wS2Pt4Yd4dbZ3qtxOTc=;
  b=C6pOAmIEKNkFp7/BZXCzQwFxYjK3zxDnPiuSGvYc0jyPvAigqlHpbY4a
   jhGQIOCRRhAaSc4ExFqdRLQT1148sr1jhsyhjAMZIkZfHVA2JNIgEVWKI
   PWp1nugug6wh0+HSfq9QycifNYdxo0LZSByrQ7QUZEkO4ysJA4mtAbCmo
   1lt4wbZFz7KmmhI4jpBTrza3XLTsuip6fN4zW0R7ZFsJdArMSIFvyKiKK
   WFOa1zh9FC3je8YI31lgHI7vJ5EN6142+yAAuOeFhuUuZDsvwDL8+ddMS
   X8pArrVjtIDCAegfJEgYfe2PqYoJPCE0WxHXuf7jTmiAxFAEDl+vC9OOK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1699542"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1699542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 11:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864332592"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864332592"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 11:41:55 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 11:41:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 11:41:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 11:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvcQhUByucUQxsrCEp++waU1KaE5jDmPxo7vRnPeqCV8Mafss+xECMkcDmJdFAihqV+P6M2AUTzhFGTuGvia0Lv1S4l3kgZRL0+MJlDyu2YgFlz/8h3ibf16pk+ctkZVpTjQVPW/VBSHsNJ9c4JWSysp7hh+WIdHfiJjM6DbTq7QqFkWgWNTphWqDWlDGT2B1xxsntNnc8ERRp1lnOuSOXG3JJ1jN1YzusAotX7CMzJP0gXJfr1Z+ThEShV255BsCmbGK0hhD3vo3yHFNknLaWE57EYeNx8FoPIzczou2VG26iY1U5IKwYJ3D33kC+SH892wZf6OJtpFqOR8q+lyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZWNeBADV+qgMEDdakW6iBB5r3Luk3LfuKDwf3a7mPc=;
 b=U+LZYyYI1hpQP0FaHPNG2LVkaNKN2WIHaYnsUI5xDmE9hG/Zba/P697PybMdBoJJ+xD1Zs6HbL2LO8s5Q2tL+bZ6K+iRmVJXcpWAp+wqaWUt6+X/72j7oXLKwvOlzzeMJkHtppOl7Zne75cGO1xoOEr7Zyf3ZjYzLdBcxew780WufYT/2xYI7lX+2B0v/lQKsvTTnL4FwuXJlxaRbaVrGddYUo7Kfd9fkDrKebptpahwK7AWQ5KtKdRmYvftP1ULJvRV4ZM2zq0tcpfAPTdp2/IQQLdadf6gmfNBFWu5jtDEcXReW6dCB95l9ajeUlQYNr6Ga8LZg8cDxA2zfLLX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 19:41:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 19:41:53 +0000
Date:   Tue, 12 Dec 2023 11:41:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Joao Martins" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 2/3] dax/bus: Introduce guard(device) for
 device_{lock,unlock} flows
Message-ID: <6578b77dc911e_22601629440@iweiny-mobl.notmuch>
References: <20231212-vv-dax_abi-v4-0-1351758f0c92@intel.com>
 <20231212-vv-dax_abi-v4-2-1351758f0c92@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212-vv-dax_abi-v4-2-1351758f0c92@intel.com>
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 2015c629-ecb9-4e04-e064-08dbfb4a640b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqOxw8peDe0jXpXjJ9emtx1HKDF8Bv1fBM6HUxNa0OQ1mBZGKr/YRv2YDTL2zQG+9o/2l+5JDqmBbKKdin/0Mv3ZnGP+njIE8P6W81iBwPBdDqPNjesolitJcYBx19gN8p0jO+9mokih6oEzENaBnaoSyJF+404/QnZSh7YKyiNcRLJ12bjsHq7aZhvhE3VnYxxiyLU958LJwIkdbbU1Za0wpXoyJkLY5741y7vn65KFpw7BNN+zG+o6yLCopLJaLAMzBYVmYXfcbmwjcLERdKi8IiZrPiL4iv7n7U2DyYqeba0S1AAe9gg1ZdAc+5ginkDlNyZbolulLcRPE1acQkGmG8V/BKWhRmkmu7F2ZQdGG+x0yCBzAsUs+i/EXAki844yr6fFibWJN5ob7/mS4YfKNh4aSNR+i1pscX6fCPWgc3eg0Wn4sroCXkZ9Ox85fQUIVPyQaeBDcgS6LCYhBmPQFgALq6QXjpKXeligmQuSxAuDGm/mFlW9yZVzmB7vfnjCXOh/9hFmJyC+jCHLV0CnDiykulw6ZHJrOiBYYZOj+BUX6TDjbjpdD07U1cXm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(9686003)(6512007)(6506007)(5660300002)(26005)(44832011)(6636002)(54906003)(66946007)(66476007)(66556008)(4744005)(6486002)(2906002)(83380400001)(82960400001)(86362001)(478600001)(41300700001)(8936002)(8676002)(4326008)(110136005)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzAstGTQ5qJ2+HhC94uA9P+WWtwwrG2H51TINnXchz4CthHDlzwDO/7XpnK9?=
 =?us-ascii?Q?IW4z8DZ3mccChm/muw80nt1lIj8Mb1+ic/T069E0/UB6m70VX7gvtCaDSztU?=
 =?us-ascii?Q?Jwiineag2XXnKE0Ehza7I1SrcuAX62wJeiclTkS+Rx9OqeQNUXpWAayy9+5G?=
 =?us-ascii?Q?kQb6F6cCuGSFKBw2SmVdGlxW6rGUNFA9gAw3/iCEPHe50E/qiNpC0yQzJxnM?=
 =?us-ascii?Q?MCggMLRwORQCKebUhqZNoEj4z7WlLetkhUcqlnpuxldCvTxok1+SIH11RIrb?=
 =?us-ascii?Q?/BZ6xmxS8wTk/XVpOIScfhoB0C/6BsFrHe3RohkNJU5EA2PGCPiipCpbvDDa?=
 =?us-ascii?Q?oUdYGsQzOpst55jQ88RhrbUsyGULJxfJxrtWBssQc35dypW9bHXbJ2mCLH6v?=
 =?us-ascii?Q?Zazeu+iBkfvhN0jJzfBazLK1ndbmR5XuZfhh4WiwzPrS3n6ZJe56xyyeKmBv?=
 =?us-ascii?Q?SzItL+y9RPV2ZUcaIQk+xUgOLC243BdAKlkBFKa06EljFwNtcUBF5sC9DdKh?=
 =?us-ascii?Q?AAb2+LBBs96uqD2jPDi47qIj5asbEMAtUYOk2KlWiUXln8uYK7W6ujMVko3s?=
 =?us-ascii?Q?RuYc4ZQFAHtQIzrKfu9zx4nhFNbEG2i/uROSpLvNIkwvtOx8FXsqdUN9L8Ns?=
 =?us-ascii?Q?9A8VQE12N2fVzaNrgKnBI0Yz1Hr3h8lBKKP82m8Gjrp/kji/nVWACDl0hbfp?=
 =?us-ascii?Q?0tyOw3N0iJM31LE/I6ZM8rjY64EVeRZQUUgsmpYBE9VWkPcLFfaU+78HUstH?=
 =?us-ascii?Q?tNeBpMNxUtqHyvkx77GILNDqc0S0pRESaJkf5N9eaT13QNbJjLh1Dps60oJ3?=
 =?us-ascii?Q?FcHR9iThBy4Y0OXwCQMsROWAO9CirGffKbxyPeYlBt/7RVNKda22IEORelK1?=
 =?us-ascii?Q?Lw//FUTDCdbqUXotX3lyqzwUyuAEWf14UfUqECz21jB5DWQ1EzI5oss9IDjp?=
 =?us-ascii?Q?84JSqSmNU4MT/sS0IgdVz65ZZSDp4Rj/ZRjomKVndtB5wynHhJEHc1d9tLG6?=
 =?us-ascii?Q?jgl05G2OMmb5vj8RWcFQMmyddk0wShWD8KMHbMiRjOprO8Wb0z2dhBVlaBcS?=
 =?us-ascii?Q?bZ51agyUGYIvRfcYWf3GeJhXvMMwOwBp54uvyx3InFtnEIwGSN753umb1xgC?=
 =?us-ascii?Q?udqbb1Pu1AAhUJOFDLFntVCf8lbskeBGTgTzM46O6z9FdK54nO3mB4DIUfZz?=
 =?us-ascii?Q?tq1tGrti5NeYEGwBVJTI2pryjPgsu/iClV/fHwgZQPmxAFn93sm1uLlWHsXy?=
 =?us-ascii?Q?jMLzhdcQ6ab1Aq58PardA8aa8m/gJDlVFWf0XP3U2FB22tPDmOyFWKToYLei?=
 =?us-ascii?Q?APrn//p/c1CoqkzTuW4iBZhik1rE59uqssJyDUgVP86rYOr3DTgtgbL7sgzH?=
 =?us-ascii?Q?7NshOWDq2HatdHmBJYpycImfe3Sii/KXJ0ez2Y02UV3tH7kFm7ar7iVUsqyE?=
 =?us-ascii?Q?1aWfdkNYcNAQ03aQ3/LN5czMb4gW4Iic5JnYrptI1FacOvWaGPFtMX1NVIyy?=
 =?us-ascii?Q?flTjQhXsFgY4LWM6xwPmSfPVmiCktZiE0ZuXet9e9cvQUjNXXjRkqYi02V0F?=
 =?us-ascii?Q?zWK1iP22PGbFsFyHYi6ocUZlyNRpN1rDHCU+tbGv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2015c629-ecb9-4e04-e064-08dbfb4a640b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:41:52.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PlcqWNjKBzigE+EWEaUxwMd5bejkKAU+6eNdmVONoq6Pxm4LLCx1rPAdy7lvkHunfu4WkDKQiIouI+r8GvZV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
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

Vishal Verma wrote:
> Introduce a guard(device) macro to lock a 'struct device', and unlock it
> automatically when going out of scope using Scope Based Resource
> Management semantics. A lot of the sysfs attribute writes in
> drivers/dax/bus.c benefit from a cleanup using these, so change these
> where applicable.
> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
