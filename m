Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1845C7F529C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjKVVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKVVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:32:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F62101;
        Wed, 22 Nov 2023 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700688743; x=1732224743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H/Sr2PUsoitanwqIKc8J29ushpHKfdibDYkRT/pe11s=;
  b=TgP7ZJbMyyL/hJ7F4DRHBjRe+FOcD92X69kGfsAU3kXrPszLTB09FHpz
   QW0sba8VJg1QtbPHuy1t1d8XYUy9Qm75YCCLDuqO+iPNiWUiCmVZrHarf
   RRzCBKPt4UuKaIVFFE1fa45V5lq+pV3RjCuY3z2CLqnn7HrSD+DAsZShO
   tzp58dJkbKKsl/ptjCoLY6vorKpfba7/QJRBrlLq2TqtMIAIXMv8l1YKK
   gz49r85akTpCXdgvt389TzlM2N0Aq2blt+EyaXXM6e8SD/4cpGsAzL+DO
   buqTw9i2Xr5pUeGaIC4bYUV3y80MTNl6fRqC1JwtwLyAkSZu6f3JfCfGj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396062506"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="396062506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 13:32:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833201708"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="833201708"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 13:32:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 13:32:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 13:32:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 13:32:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn011Ycj1Gym3D8GQmnm1ne+xT1KuMpdjgmVU+N7t4e8LBNHZAe/LA+CJc8nQI+WeMg4Wzx/5qHFZyqrXy3bGTe+eBCfYD5ESkSktlvW/PUtsmwW0+J1bYCS2iq8tpRSX5yn1S8+pOhHKOWLP755yCtOvKfUECZmR7Zk+jytiPb174t1uo0guc2PrR3ujgCxxKFFf3hPFCeGwajfpm5/4ESYsockKHmZ9jDHnh6577kNBrT3ZmWDogeWc2uj6XS4RPYt1bXpuO8KT0phvxokWFCzba7KtO6McKenEGIvG739ALQ+AmErNHachBuoV8SAsWplEHKyo/Lowyf0CaPLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1ey0hFO0QrTyK9JJA5qy64vPs+TGVTnAxssB1gMKbY=;
 b=C2f6LHTSuN1sv5fkYx4NMHq1ArX6XKOFNKbQWuRpO082IGkwWeUja0uxnLoeBF1ntvsuX+CJHyxx4w57ynNC++iGi/ZXYCIAeEEufIehbEgCoRB0eGLDEZEApRjoEW+8TdIj58VHpzRZmulCTmlLY9wd/KxP0GCve71R//N2hlX80DlV+yuZTymfPkcI+VZpLbzSn1Bszss48kG8j8Gns2UIzRvmKliLkoBUMR8aLxykGZLIB2UDS9ZAd6Rqwx3u+ifBuYwtIn7mqermp/Sa/XS2nwKCZUJxfPL0k3diBQMmI5X8hpjnMDt2/LROmV5isYykB8IjEujtI7CThzJbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 21:32:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:32:19 +0000
Date:   Wed, 22 Nov 2023 13:32:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linus.walleij@linaro.org>,
        <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
        <guohanjun@huawei.com>, <arnd@arndb.de>,
        <linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <cfsworks@gmail.com>
Subject: RE: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
Message-ID: <655e7361d6ce_b2e8294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1133de-cf29-43df-c2fd-08dbeba28173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yn7/ujIUv9awNIKLRYbDe7OTjDy5dGu4LPrMI7Zhtdsl2zgieAs4IEppvtJpPe7XgnJgek18+iCQz1hznffOWOAZJYIe0C8roSWmdeUL1Ou1Yjn1qs8IOzfWa1fXk+vRN4Dxh4og+2XzWWK/eKpFObjKVpwH4+PH/a13aIQXTgpuUK4RscLNIrzPz2C4S5/jU5C8CqGD3k8CG383dh6i+H/XCdIQWF97yTRyGxwdYXsdFF95yeJ8sHEWQZiQAAYgn18tW8rUDWoOB+MqGqs+RQtBsTWZuZvbBj7zHLFQzA7UiIFGHK0c/C5h8aG9YCM6DgxPvwJG8ZbutxrdcU/oDVuTpu3VGMa20tRC98zhoN+aLxUq+SaDD50iXpPDEqxgyrbyuRyVOAr6PLlVddZeFog9kOqdLlG4Czpm4+1C1R608AzSxKp3/jr+TaVzMZ93v/iofeMqXhamwDL51ggUGkWliOF7yIuUukROOT+Al3T5hM77tkny3TfSCSWIwv34Zk//YlEIMxi5Q+hQftgzcqtQrTVV0MTT/BbD5DLWKKmCNt33nUhpYH+XTAoezifIpmY8ls+WZD9Q7o3A9JMBQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(41300700001)(7416002)(5660300002)(6512007)(9686003)(82960400001)(26005)(6506007)(4326008)(8936002)(8676002)(66946007)(83380400001)(6486002)(478600001)(86362001)(316002)(66556008)(66476007)(966005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09Gd9wU+uqX0jlocPTw4fY7I3N8JWJT5Y2EMb2AONELibiOFrzA3W3+aWOnb?=
 =?us-ascii?Q?QziMJDak1k6jkOCG2l+HVeaGsAOwSfEPkAPRjYEz+glMRMiHZP19zFV0JGDV?=
 =?us-ascii?Q?gTLLnQkDZlKkcGwZSRhkseLJbUIfYIRDNsBN6CQC2PBOQ/asMfFmrWbwawm/?=
 =?us-ascii?Q?g0wo1GAlHR++ilR4e5S6fVD6EjeFk1Tszqbl8ieFrhK0A5yI4LOgUvu13LNi?=
 =?us-ascii?Q?nF6R8qlkUT8yXgTBrrfV2LXB8Vf/is6Iv/OkA96LtuQYvUaPk4Wb0a+zHXZs?=
 =?us-ascii?Q?LUbg+3ZRAdm9AiFLTMghmU0ODeDSBaiugwoBYskDMo53d5CYmEaTSZWU0zIK?=
 =?us-ascii?Q?VInRw019jbmPskUNQKrIa8lW/MORzLWhp7SuV1W+PRkmhsWHUoGI3LQEMelA?=
 =?us-ascii?Q?rePEXwM21HdSQaYbQP1DZoth0By7wdQtoTIV769x2P93EkQfwv1fNTCApz+v?=
 =?us-ascii?Q?tWueLaIXduEGECfRBGosnBca4QOrEVtGoHLZuUdPKaOMPsx21rSrQ0Ff19tT?=
 =?us-ascii?Q?hqOlUt2U+SOB64VpEtl0f/wvFOkeLu+smUVvP9HhoGvdFwzeW27s1OVH1Xaw?=
 =?us-ascii?Q?07d/ijLV7Y51rbDMbDd9akVwweS3shahGW2kVXOMJzXA/HDx3OwQhSuLnAWc?=
 =?us-ascii?Q?irNZw2FAQefelPgVqDhwqnkHQAcnHgoiquzcMW2ZpgZZiHnyixWEeOHVJgMg?=
 =?us-ascii?Q?8fo88l7fbMv5jhI7NKoeqleP+D4tsYs8ADKfV9dug0spdQMuxro0Y80oMcvB?=
 =?us-ascii?Q?12rR1pU4asyzUqLaOGgSbVRsaxyHobDx8kIMyD7nTWkLTF2pj9TfGEswUyBw?=
 =?us-ascii?Q?rWOlvqXziL66CsV60a7h8La0ZcX23Ur+QHAfVrqLCtDAyja9K2dMXieIRc38?=
 =?us-ascii?Q?erAwZj7Gb04tNStzLDXikXidpRe9O4BPGFl5z+Eaxiif28cP94WjspCQdMXP?=
 =?us-ascii?Q?B2iqn3ha1UuJt65vhuB8Fbel/C4D97Ck9rRbCeD1NlebGnpxGAv+IkhRxfkA?=
 =?us-ascii?Q?9b7qwjnNUCFo75+jYXVKvBPSJGVCgXdzY0lXXnFYvmxkGJq3QT0yde059KiA?=
 =?us-ascii?Q?CgUMYlceh0vTA/pjVSFNPmQMXg9NyVUlXKs9RL+otDY0GJklJDlsTqXXhSek?=
 =?us-ascii?Q?2r15JJnaO8ziHryHg8kqXSaN6RIO10NvATcqTUmxdYcPGKVp9xGRiP7y4tmM?=
 =?us-ascii?Q?D2BEgD0/STkYqmg9UK2xDRoVjqaRMd8uNuoUu0iCCT7BMUPurCmV5Wr8TCRI?=
 =?us-ascii?Q?8GnCYmmKd4aUrJOJb4gH2Bc5POKkxL8GMfNt42YMcMODJNYanKVC34QDBfje?=
 =?us-ascii?Q?T/9zAqW5RZaoPptQPMgFcunn6gi7jSLAd/qOUqp4ggsAWJ89/y684IOIzsBp?=
 =?us-ascii?Q?365xOnjeVCda3iQHs08OO3rywoq49xuGXsH6FCy1pcrzZFMwsRxezoAMjNhY?=
 =?us-ascii?Q?0AFBxv54WQ/ZsYoBeCNIZQ1p1AP21azsOuHAkPRsHBP9EzzROoDUYPpnCODW?=
 =?us-ascii?Q?FOJaiwI7XsaeLcUlJCtFG1s/TprnATkXuYCAaLMCsCw8TyzukelsVb3hGQZC?=
 =?us-ascii?Q?ef7jSCmgDuM7mhjDYFVOa7EAnfYnsz1Z5DyJbJwwXGJNyHxLtu5Kw1tynxX/?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1133de-cf29-43df-c2fd-08dbeba28173
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:32:19.3904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XAb1t8nV9Jt8nA1R5NjkP1tDOlBaDtI9V97UGmtfy9rJaV7i4+t/VTZjEifM6sZNHzAbt//Q2v1xR79uAfiZuLwEN4nJgn5QkRFoDzqMNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
> 
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
> 
>   CC      arch/arm/kernel/irq.o
>   CC      kernel/sysctl.o
>   CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                  from ../include/linux/fw_table.h:29,
>                  from ../include/linux/acpi.h:18,
>                  from ../include/linux/irqchip.h:14,
>                  from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>   218 | #error Unknown target environment
>       |  ^~~~~
> 
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
> 
> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to below
> the linux/mutex.h. Remove the two includes in fw_table.h. Replace
> linux/fw_table.h include in fw_table.c with linux/acpi.h.
> 
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Closes: https://lore.kernel.org/linux-acpi/20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org/
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

It concerns me that neither linux-next nor 0day robot exposure reported
this problem.

Does ARM32 require manual compilation coverage these days or was this
just a series of unfortunate events that the build bots missed this?
