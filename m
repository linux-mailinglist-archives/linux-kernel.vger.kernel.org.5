Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AA17CCA90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbjJQSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJQSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:24:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75BC9F;
        Tue, 17 Oct 2023 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697567067; x=1729103067;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nA4p7G3Abak/SQAc43FW/spO4oaDSOQxAHU27OuHbRM=;
  b=fR7SK8MtdANDWcjpAs0+zmly8g5Im2LpEpM4UOe6Wql8QxboOtT44F1k
   70+pamA0kwC3BM9Mxu05/+ki+CqOf/QE+ZPcJ6QtxcsONZr8UoG4E74Ey
   OwEFL+OdN5IHkKmfkruG8nK7o5oU2XplFOCHyvmU5ki3tBMmLAHgRlwTO
   F8aGDRlJXEXUXqjv0KuZrCid+Q0FQuTrfdnHELkgduj1NRyJd/0UIEnSX
   85U+43n6LUKx6OwgdUsumk0seicmDq1vDIQfRO67lvtE8FlS1QeMPhmrl
   a8E/jrNcWOa1knDmHzD3aV86ZS/RexNIe3AefecIzewZl2Iy7sy7mt83F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385689526"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385689526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:24:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791296399"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791296399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 11:24:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 11:24:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 11:24:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 11:24:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 11:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofNfWS+ee18t75kEYohLfUADn9yOLUTl+7Q32hC60qM5nBYm4PokfTJMhH6YrFOIA48d0o2D7zz6h080O5B0Sc7bZ+cbHPuZUbGNKrRaDHIp6d43pIaDr8c+ZCL9j6Vp76nJCAJUOdmpToR+tD9B3NwHRrZjxf4AHfo/CxRG2S/X02b8yZQEfq9Q25DjT/UkVBqxG+3ZGgL06krx4QNEJA2nFr+eiQzybgEvkI9+XN+FGMwuw5qaNbs7hL4ai0DJgISJfwWdzo9mqj8hvOkb+FqM5UQivMj4nMuFYcLv2QVweFKACmtr2SPiwqTMjsDoM66FpHBSQtBlaTlTUTb2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXiHVoagEOLAhbBHryErYrbENW7Gwmz69YWR6LaBqu8=;
 b=jteVNj2fIffgUCZDVlxbdL92zAcNe9y0qwlRC+0+aiHSpzJ/sV4rV1IYt1hv6VqGTE817hMYu9pi8qixPDFmX4CFSOOSnGBS7NDkcSCjqIraiIrQupKS9jiqhkosyajInM/fFjnmb1AxdbPpefd8nBAXs6e2OuVt8sEpEjV+aFMlM8/f4ur3Bj1rDtxTuLtwjLmUOI0u6/UX08o1RwlVOskidz0/GS708KJ047WXjKCeOTEbYkYRYOsHcVy86KKohQEWrG/kw83MzhQDrna7pRTqTUKxTNSImEdvKHUlI6tohm9q28VKmBSEk5jowPc2FsXTVCVZKbVVys/nIy0Qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 18:24:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:24:23 +0000
Date:   Tue, 17 Oct 2023 11:24:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: RE: [PATCH v2 5/6] ACPI: NFIT: Replace acpi_driver with
 platform_driver
Message-ID: <652ed155ef8e_780ef294f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-6-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006173055.2938160-6-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: c82cb438-ae37-4366-4c72-08dbcf3e499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEx98ss6jLctfUkcIBcC7V9nZC+mhBblHQws81mdhC6zvmSBWpbYrqaKJkNpL9ozGu0nX/bbjzF5CSp84QNImyLQc55pFj5MPIY0MxfvW5zCv8+H3iFf2roaYwmrfLHrzsb1JklMgYWsWtkmw9Q9mOcttNPyH+HFZjQ63Hja+B5lCqsvBmF4dse/ut+SpKnV7uMW/+0K8bBfxv7zBEzR/38mK8GBnzwq4cfkuRJxCiGYv7xilVuU39bwqJbXiiFskpuUe79uNayg8kDJyGtvrcmBJ+USfG9sXLdSIgvt0TG2S916uGJ8Elc3zj+e31aZ66ZTS3JxamGkKF7+qfH8ZiE+YmkF+0FtVAJqc1QDFUGjWjXQLItuSrjVjMoFRzlklzC/5f+ygN41C2CuymphAUaY6lBHlZBAtlNGILPF/yI6x9i/9cPQ52DRs9YIv9MTvPAWPpmTMFVfl0pJi7n/ifNozZfDmwuMxwEAgxfmB0AYysH6LF3TrzZwAJwoNI37sdET5OqnQm5ZF3dJLhtTnUx7DdmMHEEb3dinHuUAV5ZMBNGVfLI2ISsgEa990qYjeOIbZjUxjEw0xZ+6kJvAPeAVLiiCIYLq9jIrMycBE563GHRdUQFFd70lTBIWuhFwRFjp48Se2lQOafLspKfJkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66476007)(316002)(86362001)(2906002)(66946007)(66556008)(41300700001)(5660300002)(4326008)(8676002)(8936002)(38100700002)(83380400001)(6486002)(966005)(478600001)(6506007)(6512007)(9686003)(82960400001)(26005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkEaa98mjaV/CkB2H82DZtfGCjOTJ1zmeB4g9l1LCj9ge9ieNg7leh9vSs2n?=
 =?us-ascii?Q?VL71oAJ+5mKh7W0G3OX4p3mowLW7FW7CuwdOSMk1C+aR9Qhp/PyeCF18H2ro?=
 =?us-ascii?Q?px83rdm6e9EKwvRVSpUj5duMbZBLLCm5VAO43ahpbPRC7b7W2cx21hmuy56A?=
 =?us-ascii?Q?wucf7713JsOp5dZbcC2buwDmx/T314Ti7iaZiAK+ZjqJYo+o98lNVEIcP4FO?=
 =?us-ascii?Q?CI7GrGRRjIvqNG6ROz7WCafbFTcwr7QU154Mo/QK8LAsqnUxJZX9MIOmlZls?=
 =?us-ascii?Q?YHDAJldCkg7Xyfu64nSWYfDWb/icAGnK1fOJGjSedqqKVnHZYPg3wLF1+5sI?=
 =?us-ascii?Q?LUMnqFe3SBhOdwPtXTjFm0cxGz46xdnadQ1JFDy3nx2VY1izAjjr9uC9HDRj?=
 =?us-ascii?Q?iVt8at8cV48gjovinqZZkewjvQxyltlsmYeSFFYFMbaGxp/hIAwb2L0CPlfM?=
 =?us-ascii?Q?68hwo2bG3cuWPy3IZaxj6rGtCNomxAB+ozkB8TNZjCNIgHv5ij8f9mjxjC/q?=
 =?us-ascii?Q?uVd/DZaKZbUW29aCoz8wDtxN6/cLp/3D0wR+oylhy6kdJsDPK7hdLKeisMgp?=
 =?us-ascii?Q?AszKYZiI7Tj6TU2Kc2e+VQ58PsD2k/wmFgUpSxBYU7kvSyrzN9eynsG8m19X?=
 =?us-ascii?Q?t0CQefYSaeT/0uaD7PkrDJM/RD9odrG9ItyYlVMssO0vEDyeb9WaA/elYX+f?=
 =?us-ascii?Q?fnnVtH3LgdGbLCfFv0nR9bKvbLQUFk7bTGa6UX+Ag+mcaVkFO6pVdldtDJuz?=
 =?us-ascii?Q?ODLRI34Zx8kqO6aEfmMdBgk32X2aSotu+hnohsYDvw3fXwpYUsdTW4lg7r9f?=
 =?us-ascii?Q?SFkos7PfZCkA0//5sVmySojNgun3ETQrLvhg5AAhU0VP/lDv0HxoZ7PZZVit?=
 =?us-ascii?Q?mkj7DkMfL4Vwa0oLekLYLuivKGiXkPbgC8dqyfz6IdLtgsgblol3WtLlvvFu?=
 =?us-ascii?Q?xRJmrADa1JqfB4xnEvLfSEJ7FAos1v3lkBMwnnLu/Gvgq3sK5sjPuczQ1wW0?=
 =?us-ascii?Q?Ih8+q0pqgBH10YByeMl0lotspl1wCKoFN3BO8adlbSCiAX4SabDZPPTHny+3?=
 =?us-ascii?Q?kgMCma7cRpm9+SEYm3QaToIKk/nF2bRGNrQnvPtz65wPzjjGAYGqc2RzCJOe?=
 =?us-ascii?Q?kMYuQF0YPK2JBosg0v3LrRqpxBZHNwRiPNPhaol0PJdh97SGkFxxgPaCPBNI?=
 =?us-ascii?Q?3w2wvXtkL+cVKcd0JEWsVVmSNQxunOeGo++lwtCogbip5FIB5VTaWmfv3PBj?=
 =?us-ascii?Q?MnA7UtpZaN03UZzUlSxUQp9dpqbkT2Ufo9zlkkzASXQLQSdAYqgJbMKMDRoB?=
 =?us-ascii?Q?58fI9vV5yJAg7ZFFJQm5EgC9ZM31ih9LGvP/es6vL9Ve73e2G5T2rGa4K2k9?=
 =?us-ascii?Q?kTySyDcc5OiHozW8uWGRyqvpJKVn3RpSBCrWo7yL/t0F+anmoX6DuVKsF383?=
 =?us-ascii?Q?mrNI8VNTKO8il/wId2BN2AsP66rGRerKXsj+Jj9qo3m1ZmgvBnUN+FDVa/yj?=
 =?us-ascii?Q?n5PJIP3YEMG3Xa7mJWahuJaXp8ksYHl60N6NIr8Vx+4f9vIv5BnZWmcqtbkG?=
 =?us-ascii?Q?IAELgTUJ16uzIIgX5K7sh0vFaaO80EZWomyCwTymzCZi9aGV6jN5WVVsfMQz?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c82cb438-ae37-4366-4c72-08dbcf3e499f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:24:23.4770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmlqtjmIHZnXOY9k9L072p44LC8ks5xwzXnwQUjdehVLv3KHAnR32A/+E81FMdXJlxFsAcnD0xZ2pKVbC7/qQF8yVk2NkMMoyHjfRik0J8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Wilczynski wrote:
> NFIT driver uses struct acpi_driver incorrectly to register itself.
> This is wrong as the instances of the ACPI devices are not meant
> to be literal devices, they're supposed to describe ACPI entry of a
> particular device.
> 
> Use platform_driver instead of acpi_driver. In relevant places call
> platform devices instances pdev to make a distinction with ACPI
> devices instances.
> 
> NFIT driver uses devm_*() family of functions extensively. This change
> has no impact on correct functioning of the whole devm_*() family of
> functions, since the lifecycle of the device stays the same. It is still
> being created during the enumeration, and destroyed on platform device
> removal.

I notice this verbiage has the same fundamental misunderstanding of devm
allocation lifetime as the acpi_nfit_init_interleave_set() discussion.
The devm allocation lifetime typically starts in driver->probe() and
ends either with driver->probe() failure, or the driver->remove() call.
Note that the driver->remove() call is invoked not only for
platform-device removal, but also driver "unbind" events. So the
"destroyed on platform device removal" is the least likely way that
these allocations are torn down given ACPI0012 devices are never
removed.

Outside of that, my main concern about this patch is that I expect it
breaks unit tests. The infrastructure in
tools/testing/nvdimm/test/nfit.c emulates an ACPI0012 device that allows
for deeper regression testing given hardware is difficult to come by,
and because QEMU does not implement some of the tricky corner cases that
the unit tests cover.

This needs to pass tests, but fair warning, 
tools/testing/nvdimm/test/nfit.c does some non-idiomatic + "strange"
things to achieve deeper test coverage. So I expect that if this breaks
tests as I expect the effort needed to fix the emulation could be
significant.

If you want to give running the tests a try the easiest would be to use
"run_qemu.sh" with --nfit-test option [1], or you can try to setup an
environment manually using the ndctl instructions [2].

[1]: https://github.com/pmem/run_qemu
[2]: https://github.com/pmem/ndctl#readme
