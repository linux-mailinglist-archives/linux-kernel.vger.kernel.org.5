Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DBF7C8BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJMQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjJMQid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:38:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5EBE;
        Fri, 13 Oct 2023 09:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697215112; x=1728751112;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j8FmNrMPHlJAhp/aePSPnxOvzGlHfvRk5POO82dYXEo=;
  b=EjROPCy5uD3WY6oSaNjLS1eZvyCr0REN5L5fMJAgcSY5T4VDbf5t/0pS
   hbn5VTG9Ey6eZrIBcGA1yxPy0dft+124SS8GUUHCY4ex9bB5Kv2/fXO+/
   Jmksq1ENZ+6j+HgDBdxDwLn5kNS1FEgfl2xwQYJm5HQP/ie9TWCR8gm9u
   3W/nP1FS9isUDjsy2R66moVvXRJeINnJ5jtmpcALvhNKWCeGoKzvPtq1A
   UyCqEhTqCLmSYRiwAeOPi3Z06+v34iMhteEETBUdMj2E6G51k4MjTHMTF
   aiIbXOQpjyUwIkc8/Q3hmeV3i0+mzNknFIC+efzxd7vKCRhgZHNiUj1V4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="384086503"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="384086503"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="1002004626"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1002004626"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:38:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:38:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:38:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:38:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m88xlDL3ax7m762JjfXzcmR75zSQfMP2o090DbhD/EJyunu/GeXGfY7z0u5c+wSzfuj1qi6E05HhJRLT5NNBbhNOn6sF43v9Drcrs9di0ogFeoZfjk0hq/dE14XPDNsvl/rR8d/rZ4eKGaqirB25nKhiyrYbamexU+O2enKdIUfsXCrdiz/ItqR19kb6KVVpis5LrfO+3q2vob3BBtKFZOaEBPO1m4N+Ws0Z5Sy8p7G3blDeTAK/+b0zoYvntEsuoWTVqpmNhY4POtk3Ho1/KrPoxhhgfwz+xGI+CTvNMIb3yNq99agJV5G+PWo/XExt00+sve3nTS2HiJqcGZYGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvfmC19FKfAFF4J1oYOYbkaNgR8dfQvDkAPax1BfwlM=;
 b=GmEj8cPr3keYKihAALSOKGTCAaHZeZyGkPN2x227yzJzcpFyO1qwVBTHF6iCydMzpPgHKE8L4Pn1oCP21rmdv8+hjCgJDbHUlQUc7qPT0Nvx/R9SvqSvLvkMX49gGzNbmU0MMA831ZPApl8F87fBznpPw60eKVcD4jgOmvX6wNdPgNFxSQ1jDxJjuWvgpZTur1HQ4tVkw0cCxhew/TgGmB0JZSMCcdznIzvpMfx/Q+Ao1i1jhEvnPfEk4zQiLimxLOplri90ZUw1rvKU7prjZ1+aE9r8HGzMDCsOYXY6O3C1qVXilHmxeUn46CiwmI6TOZB0VuMWXlpJ9Kb1Q1SQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 16:38:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ec95:c199:551f:2d11%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:38:25 +0000
Date:   Fri, 13 Oct 2023 09:38:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
Message-ID: <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013085722.3031537-1-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:303:b8::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: be0040e2-0f60-49cd-4249-08dbcc0ad1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WseJ59YFwT9HHxHTpFYyy8Jq0WK+EA1vh2SpV2DitF2e/Fi90tg5LibDvfdtTWBucHjgQykdiXlSs4CGVCowAI017Iyt1DAnNNFKscWCQfTWvczpg66MELancucxPFVVvLfA93mbtxuc4QZBv9rzX3bXxACR/m3gtxAMKRISyaJ9GxKRvBsEjbhN3hbYotliq0w4xWb+VUDeDanIBOQh15L+lZrimkOVqARPJEwA3KNFJMw4AZMc40ywUsXhW3C87KCtLCurn+iryCtrwjyIQEdRrTqG9wae9SvjkjyLSZZSca19lQHGSu0YEJJEdNIsefDtjrq+A1ccSVlpCs1UCbEo4Y7G3pt4T5hb41JxWQmLz5xkNp1JHW9IyW6DpBlhHrfsstOXcLLvlfloTmnsfEWv9afCk2yP06uQKJfrt2fegiIUt85ml5io9U5yh6xip738oC4XsATQvsQaC9oPs+3IlWnR6VzsbndNDxAqoJW/V4I5YMhfrw93tRAmLR5qFSsrUJvncFTpjUbhNsdRP+PnMYQ6jXCXo7+6AGqvaDpbIqLW7uETYowrC83aHumH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6666004)(6512007)(9686003)(6506007)(6486002)(478600001)(83380400001)(41300700001)(26005)(316002)(2906002)(8676002)(54906003)(66476007)(66556008)(66946007)(4326008)(5660300002)(8936002)(4744005)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRRFr3BI5JvfyPt1gSNtKs1Er/gGiQAPwBJRWYxTvAO3tACs1x0yVaac0RKq?=
 =?us-ascii?Q?7sh2lSjmS8jyBVDs3TFK8JVaQ2XrelJIB6GsmQ7SbF/Gmo0KIXeOOl6ruMvW?=
 =?us-ascii?Q?b9jIJlO0T0PDA57crZkP5XHIef9ZD3ID+lyI11PsfP2VQb33gwMPWt6nzjx1?=
 =?us-ascii?Q?eDFkkhR/xllh8f2VRNBDodWGOIYc3HuBz2SA112t33jaP2Hmx17xt4BMbj20?=
 =?us-ascii?Q?hRzyw1yx80wc/f4rzTUx/eL0pHAVVLyVERKLR/zlqx+kExF6masCE5hxGf7a?=
 =?us-ascii?Q?bURsW6hBGF5Ta6GybmAEzQO0WmHeTTaU6p3Cvr11ZJqc+JAFharddbx3lASy?=
 =?us-ascii?Q?a1rnN5PsLgjdSb1FbLmgBiXKxQcIbbtZdghyb6frvFM1uN9njsgKDDNrJ/qB?=
 =?us-ascii?Q?RH729nNOu8vmsZCOsRp5XnEsygClbyYaRUOhAK/yZy52uROUXGCC/H5ZlDJ7?=
 =?us-ascii?Q?W7ifHP2OiZpRyo0E2ItNMN/asSdS3JG7w9LRwjvbRTYejjazeskXo4IjbIGa?=
 =?us-ascii?Q?idH5AZ0/PRVekKtvbY26VKiLHOEazY2UyIv1SNXs9JcctcKEVD+SsDaQBwju?=
 =?us-ascii?Q?/nKlClCp2UI/KnZU/3K7scb0MMumzeJaZwyotjhO0slb2TdMrs/Arkc+TD2o?=
 =?us-ascii?Q?0hVsC0WBFbS4xt0LlhTDZQzsceIiZvR2i/av53kv3Wf65bv9BKiYbSQErPnD?=
 =?us-ascii?Q?+LxFRSAew3bFVrSqduf9jsEdU27KSvrOb9vtXAnrpNnxhewxrrBPP7aUHdWn?=
 =?us-ascii?Q?1gGzvmSRfQJ0RW38hw3IyfW0opjSoxwWY07axc2qpu+06rtEtEPlokfMQXUM?=
 =?us-ascii?Q?UZcqAjwtwSrIUmTIJFB2O2+DanxsCabGxXWQ2exTmnXk6XKnDnf5iu9sIwli?=
 =?us-ascii?Q?axtKbg2S3gfJ3cV4Xo+XtiMMqNR0nLij9B/4rLW5EfQF6OthjsWoF4SJsgOL?=
 =?us-ascii?Q?Ae2gY/A3Bc67ureQ4g79zze+QUxuBYur+gSTJliuUQf/kxqG4T+SJkcyBEYV?=
 =?us-ascii?Q?1eP9dHUHOSfnlKhcoOFf1bORGlUljpUmwB1QFGnftOOXwil+crkcBIk+/N/F?=
 =?us-ascii?Q?B3gxFMj1/uifIp4OMIOKfU8KMRb6sWtfuxCTL8Ub282JsWa/+VbM8NZRJ16p?=
 =?us-ascii?Q?ksiDF89+20EO+s1AndqRl4HyYAZ65WxHZvu7cC2tb3pM+ScUAmzWK3jeFb9o?=
 =?us-ascii?Q?wlwv4My/FgHlrdY7tnhzZN/sHijc+lu0VwZfVW2tBcxxDccsuNGk9Dg+QHro?=
 =?us-ascii?Q?X4OXQwhWXoO3TYr7wjo4LRWLuPPK+hAvun6v13tb0r5dtFEdCr0snPHhAaJQ?=
 =?us-ascii?Q?UTi1ldsu5eMNECFeOZjfScyDAFprj1+kuikUHidvWEz/lTymGJFwNRGCr49i?=
 =?us-ascii?Q?UEv5k+0nNRR8wrvycl1W+lAtmBLEu4rb+yTDmeaGWjFdCEfLWAGMAqaZlyny?=
 =?us-ascii?Q?xXBxIlYQNZny5aDEeSKG+t8UX8P/aQvtWzuQYcXOE/GHM/cfnDjG+WEkSLxm?=
 =?us-ascii?Q?A7BrcXRnY7IqzMPrLZYs5YGh8U/gg3Hgq/zDcV1xkaD4JqlD33A1XhkB8CyF?=
 =?us-ascii?Q?OXdGHwFg+2tkh6xaL0uQTv7k5kfmTVI2dwF0vFOdKaqN2hWJWoRdXzz20wdb?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be0040e2-0f60-49cd-4249-08dbcc0ad1d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:38:24.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyDOYoYj530ty2Fw8HhQdUXz62jy5nh+1k7W9j9QGlqkU106vmb7ooml03ji3EqqYoyXSOWpWRzRRrDE98F9uFiAgdHf5HuGoDChBozjcwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
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

Michal Wilczynski wrote:
> devm_*() family of functions purpose is managing memory attached to a
> device. So in general it should only be used for allocations that should
> last for the whole lifecycle of the device. 

No, this assertion is not accurate, if it were strictly true then
devm_kfree() should be deleted. This patch is only a cleanup to switch
the automatic cleanup pattern from devm to the new cleanup.h helpers.

I am all for modernizing code over time, but patches that make
assertions of "memory leaks" and "incorrect API usage" in code that has
been untouched for almost a decade demand more scrutiny than what
transpired here.
