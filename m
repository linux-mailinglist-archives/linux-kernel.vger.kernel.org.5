Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB37D0602
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbjJTBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbjJTBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:04:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8830112;
        Thu, 19 Oct 2023 18:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697763854; x=1729299854;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=okEioGFTVPUQQFJOKjADaR5r44nQAIBW+UMs/RktEaY=;
  b=bawb4nwy4aiO6H2ydU/aHHtCeKsEv/FcYBlDq0EHnz15rts0GQwEpK0k
   zsI5A5SUaKmce5b3XjRF9D+/vZVsB64mZkxtR5CZCRLNyCSCwzpw12+M4
   ecA+WjeA/nGtsTLYZMJIyZditMUfiFZpCrN2ESF3JJwlbXbHpaQ8NAP2U
   S+i4EGUJt3wdKkC5mb9YI+C/OLKosEan4Vtl2PFcnp0mnGe2JGKzbV4bc
   DgFI9VB1xi1c6ok8Vg3NYB0p5paXxUgytRnmlGyYheQbDhxpGZ9S5olJM
   cOrd4gtHGqa9gy0ztcOwtZyU+ehU2i5Q8CCopdqst8NRviCcD3QM54+UK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="376786107"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="376786107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 18:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="880904205"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="880904205"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 18:03:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 18:03:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 18:03:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 18:03:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 18:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzSb4I3bdsLAefpMZY28+WPaNswh3m/smmylR/UvQZIj4thuP3NObUnT1r2J5rhwyTIn0dy1L80Qr8bafwy65XXB61KepnI4NjbaqfDu71JJ8lmWO/CG3I/2OnD7xDiP0Gow6xF7WPe6kqsiQr+OOPNIcfgztrknI2/pTookQ7zFW62t6ZS/BzSSlUVbVyo2KEGdUTvCmrpXBKhIUf7dqrnlVpB3ikxtAlkhKtNtqrnAwIbKKirtTeUIrSBrFiyKgki00Xlp8WUV43WElsfGJud1ZKajgl8dh0xB4gg2+9m81dEg7Jl+MTkUSKRg6CjvEJxMdPMMBgABqd8XqwsqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okEioGFTVPUQQFJOKjADaR5r44nQAIBW+UMs/RktEaY=;
 b=O28MnfDZ/5jIblixcDADnhCXRpzOjzBZrpKfgO8Fj0e9FBqnUarpe2n0nFwHsPxCyy8WIvlliy7TOykLD1/KuviBMve1BHUUtfZri7tC/mSxAKEpltTTV7AWLDYGI/0JaNmMs45NtIh2fHTKnPKQjjHPqog7JG7bHXtCkivDQF++9fzdjl/D8zhYKNK+V1RdpkjSj0b/ENdF7r8demBfLWVFwRAn77Y2RimSu4EeGW5iNqv1xkGiSEdnYjogh//coBrOTruZL9375ys92M+nSxVudHHMLnwI/4+2u+sKCuTYnFxgYPX4TWXpPtqLZ336TXFGLezSxbZRxtFTF1dR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 01:03:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d%4]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 01:03:30 +0000
Date:   Thu, 19 Oct 2023 18:03:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1 1/1] ACPI: NFIT: Switch to use
 acpi_evaluate_dsm_typed()
Message-ID: <6531d1e01d0e1_7258329440@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab07686-7647-480c-c4c8-08dbd108600f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuEThgnq+TUtU6p8N/HSwlqmLW3E1nYRrajKUM84WX29sFkzqDXfOCxmf2rkpHoVINrX5oig06OkXIM1CqDVizrPIzW95pA90gDXDqHXa+DX91pNvzme26yBBjKBUOjni7Nm47TQTPDpju19RAyz0RhbFcNdaGDNBNPvS0t+BgstDx+UzZbTB3bjCcruQs2xI/EvnzZ8MLTfxKoDYFkTiKDSuXUgvfUyVFnRfDH5albbMm7UmsWH5d0ycN+9pJv3txErKCsACvZM5ZC8HriCm73p2cGH5qIyE4UogGi0y8C96pbvkgZ+gT64JXPA0S1qp1YizDTmuhB7U8I42V6C5MYXBNz8PQcwZWWxGv7it0639I0RI4g34UeIORWJCJ6MsLQ8kK/3gYir/l8l05YwJgEDG49Q2NF/qVZApemsBUrSXG8N+2UVKiUnOlLzgb7eheza8U2Zfb/vsPukcdq95SHo0ZgrGtfT3dDQwC0KaA+DjmlNxu14DOS6rA976iT+RO5MU7+HeY2ZrxrMVLZi75uM3pNcz1HKECWMx2GcCPuIm5UYfTMV9kfladB28Mji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(41300700001)(9686003)(6512007)(6506007)(38100700002)(82960400001)(478600001)(316002)(110136005)(66476007)(66946007)(54906003)(66556008)(2906002)(5660300002)(86362001)(6486002)(8676002)(4326008)(8936002)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+iD/7fpANoqGAC4awyk4lrcZJdtGSJRGLOnwpgImpsqh4qC2e0bwBUGzvRE?=
 =?us-ascii?Q?Oo+Xmo0e3AfqH0kIpvILk6g2zvDYtPcLS+2wr9MGXKoKfHaISRau3jhmS/RB?=
 =?us-ascii?Q?bmwuNiK8dphdnjnpa8uPPdWJcpzu+twzj2O393AKYMcI6xdTmO2yTqwn2a+I?=
 =?us-ascii?Q?nTr7ezgAHWEj2R9KuZnRCOlkSSRx42ggSSAmjWxrulmGqH1BQF+zzBfbzozX?=
 =?us-ascii?Q?mxWjt3QoG6mPKiLrRcQqKpgOcmgAOFf7MsxCnKk4i0UXOYKtema6UHKQYOgT?=
 =?us-ascii?Q?wKzs/w3wy3wTX0OGXiUgl87TF0fcsOO69IN/LkdHjVTm+9qQgFhekU8LCJ/n?=
 =?us-ascii?Q?XFEbWJxfQ38yHBAf9OCq6AfYEmAhIwdLt2rbSayjCU+pTdA4TcvBpbFbDT6l?=
 =?us-ascii?Q?mi5CzCv2kTrhuGU6keY+T80kEJMp7TyAmmwh7WC/tk10zRT+4RTv8Myu27au?=
 =?us-ascii?Q?fjVdfp7bw2NwRrvyNxrn04BhkNV2JKzDiomP9ahjpxH3W/7gmYi98CsMJAEm?=
 =?us-ascii?Q?d41OPOG30/OWPEadH2xoHmt26Mu6oelCV4pU1VoMPI7EQOZhg0o8m98fqPKs?=
 =?us-ascii?Q?802Se/zfre7BrGSwL+Fi8iV7wJm435ZqGC4qUTumEPKMW5tuVWEQjJkksBxU?=
 =?us-ascii?Q?Nk5hZrT3fz2EuPaZb2LV/bv06KqKyxnaBgcnY3ApkPcbEJDVExBEFy0jFvU5?=
 =?us-ascii?Q?oSCPe+6XcJtNTJaGWlzFDC8OseG8Woe2rwbd5zJ+2R6PgVfP6eK91ysEX4GW?=
 =?us-ascii?Q?m2gMs8/xXyef46GfqBjDQRXVby2Z861MeyySjZ9WyGKqMG64nUFcW/5L0e12?=
 =?us-ascii?Q?YIO/LgYx0aTRM7rsa0aDyboCxBUy8RgOVyDhkiipikzu1TAamtZ+dbgeNdfP?=
 =?us-ascii?Q?k3tnuLGcGgzqgQEhvbRc+P8MT3jU90fVHxji72EdUZRnGMlc/zIWWm61weUd?=
 =?us-ascii?Q?0yHxLkdbo2EaHRiWrTIYJh+6WhNc2uv+dh4y9S1gy3UVMSTL5IPOouupcl07?=
 =?us-ascii?Q?fzkjzxU7MNIzDSY09FNDjvmLtda/H3oLTV2mq/E2cl+KM5bGD8TiTRsOK76H?=
 =?us-ascii?Q?v17n5rTUN/AK3GWgpOppYmbicxscdVzL85ruEdCel9XydUnhFCev/xCZ/W4l?=
 =?us-ascii?Q?AHaFR9XunY496AH2FOrwD+uaY3dz6ZpFrqN92NgFxFUVouRX8YjWnXaZNrBR?=
 =?us-ascii?Q?pYgZJiCkHoxJPXSXpiy2ZPbIBtbeb+4ZPXd+GLQqmEtJ3ROIhHNkJORld9Ko?=
 =?us-ascii?Q?/SpVrSGec8STqtV23Ux2AAqMp71SWMaXBl7XS7HuizVVquUxACdeIm+ni1QW?=
 =?us-ascii?Q?IbAgEbWTJL6EIFbtrXo+r2OmGaWo/0D+oxUbDsSWJfqD440i8hMOYB1HGZ2B?=
 =?us-ascii?Q?kYILSYZt9HzFzZi9EwU06dO7JJQ7xhhpes+Qfq72CUC7TaJy2IbRh7WXG1lV?=
 =?us-ascii?Q?wvaKlbu4JWDGjfW65AVkFDVKv8mUb3RTp9CC5RCHv2VEfS0JOhP2iCzw+9l+?=
 =?us-ascii?Q?m5dYPl7cuurNEQJ4KEBBkueOmopHlTN0MfNRoxfmsFKyVZLdc3NwvLZZn3vV?=
 =?us-ascii?Q?GSBCS2PYhvCaKf4p9/p+mj9swPMugRwO+Uyi26jO93XKqEc0nBW6Y4LUMtFS?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab07686-7647-480c-c4c8-08dbd108600f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 01:03:30.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7iIPnkbe+yGP3a9TkFhifyX83V1w0UtzDPclbV4dM5hnxcN356APfvq2cUnLEVT8h6jX3MQYEDF7mAsEocurbPTBhMspSXATtlyjXWN8X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
