Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393578F2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346882AbjHaSvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjHaSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:51:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D2E5F;
        Thu, 31 Aug 2023 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693507875; x=1725043875;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hpj3ipOJ38yizcn8Tl7quS/V4gSTcC4eRlXOWO/eFd4=;
  b=ksH24kagC9rnwYWxjwfKvucySve4qEZoh7rCkQTglSJvjNr0c2K6gE+t
   tMOuQ4Ob90zx0yxDbi5AR3YetnSud7GMCPc+pCXjy8K3NNm29ldrjx72j
   u8n8NjYDAjPel3p3QGLlEIAHSNeaNamHivHnUKWntNl4cuJiPhrUW8wdW
   jfCKsXVXbnlrGN2+g6UH6TpMZTMiNVa+6Nc6l2DIYubpDSql9pRgePzcr
   HW5AiVbYwq23UCDwRy4nr1+0BO5qSn2oAk4Qm38wmMB/WIwNffwlAQTIr
   /V48IP5GIq0EXzPCx0XPibFPMo2+0L4Lt21IZPn1nGLcjfFrdyLngetGL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374943531"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374943531"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829821858"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829821858"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 11:51:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:51:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 11:51:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 11:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ks02JTRIOcIjaigvvwKhfdtH/cr5aOGrViFmiTFKKf6QhFPyhkRJORBsh2foCCtCqwMmbTQ2XBNi/Rr2BpOgsh49KYMqPUUYHLDslv+iDQAFN7vovm+9Lx29UcARowUdRM1ixscislzx/5qT8WOIVF7h0IwgpPAU/Ts4XMjekHJ+42tWIBv/0bijOa0r3VysJ/grn4BAIKWHIQ78AmkqqL7nQKMvWVusaHzjizCqXIm0KdjBBZ/b7SYNSjet+yF6pKBj6RnguUuBWLxymPXJZLbBHnsDqagtgu3KkzTlEiFg9LvobY3PJ0O/LvxxOInOJFs77IJ6MI/RiiXLSOUzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ7SlsG6IdH5pcowp+LOTYLZvKkbdHK3fxr0RUlzL48=;
 b=iZQxI68dl3KT1yv1ot/cXW+LbaRETt34oe6bF2NJzu7d5YVM/omNKVESaXxrpC93/qQxfixk9Y6/Znm+bO29SSxUJzpTdI9mUinrMwrUYoG3Ak9RzowS5tXGsKmi18Iv/EJdOowmAk6yMvsYqgmoI6anPvZKl+KAiHDZQCgQ4DBlp5oMmNYXG57DqAnokF4he+zVg9hVP+oAkLsbAt8zlDqi/PmwpFq3bjGbp1wnGhnQOWnwiasXdZ/oxsdFyEe7A5O3KaMCssZEfo25dDagHr7bcUNrD/SjDLZuuS1PwMWe30rtMJYhybxmtdx+xHkHVRgn2J6NoygQMNTnEFyMpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 18:51:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 18:51:09 +0000
Date:   Thu, 31 Aug 2023 11:51:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v10 07/15] cxl/pci: Add RCH downstream port AER register
 discovery
Message-ID: <64f0e11a6cc68_31c2db294d8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831152031.184295-8-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: f00cbc14-68f4-4ed2-17db-08dbaa533d90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bP0N2skfFqpyXdlE9psxsbm5+DF5ZEL1rITUZFj2FWsQQQPh+EQEPtQ8oETEur7kksjRGku6CmXxs3rjMFA8BAkxh58h4ZM4FFRKqMUB11YvE08/+jQouaY2++mgUYPF0Iz/tQ2iLf6Ju7SkTbEgLXzaY1zyYZKk8L2+o9jUrgzZk8jZiDUdi8iJtI/+dVU44WwoH1tywhCF6im0HIUOEZUNz7eLCsf/rnP0rXzKDz6pgu5JWhhZaIR+YqgevRtc5wV5DVxK9ri2wlburH1XUNOYh4rKdAG1W8XPKJWmM4W3LEJ9ndQTwZbecZPJcAD99jLjptvr4Hl/aJgkSQHwOgcAVxLU8JmGfcavQQxeYQfjKViBqafcxB+GW+b9ZhC0AOGUAEWQFnqEmxRR33zElRX1lfZvvWFCMQDGaz65eSQNEzYf8cYgnjSjD2W2eMi7iRiOM0qUdf1kzlVRBg8OGrRD7ulMRfCtB3H3NKTJed+tEIMC2q7JM1UHtXs0ZQmMfXyuoz6HJaC7fvtTmv52Az4b5kPA19gB+rnWK73p3cr/yU4CvITQhovInkz54joF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199024)(1800799009)(186009)(6666004)(2906002)(5660300002)(86362001)(316002)(82960400001)(478600001)(6486002)(4326008)(8676002)(6506007)(9686003)(6512007)(8936002)(26005)(38100700002)(41300700001)(83380400001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/adkS15I8Bd8Nq3YN1y/2rhbuWniQd9++pjb6dXhTKkK+X5mUvEk7JOov9Lr?=
 =?us-ascii?Q?rb7t9f+oumykoGgY2h7+tUURIuW37MH7qf8ebXuMItTzWHrpmzoB6IXpwC0C?=
 =?us-ascii?Q?gNmjgv1gYmGSpFkisoKej4Il2bsIIz07+q1IM9/Krai0dvU9pT0ZfiiieTPp?=
 =?us-ascii?Q?Fvq8H76H39n9u+oTRYCdFVBXx4BFFI8G62MpDNs+H7mVBdwCrCGLfCdd2Yvq?=
 =?us-ascii?Q?4WRIW22HT7GMimNANBQfFy0sdXu2zvtUWjePblfPfFCHqDudni2RNKiqJBdi?=
 =?us-ascii?Q?2DZNlBZBBR/RQmkl3Zwrup7YzznHEUDoapb9JBGRUXdmX3uQipinZCkhV1Pg?=
 =?us-ascii?Q?Ovwoag/ksVNLHprmPKK4ALgq4Gcgb9uT2oaM7UonJkG2jz/dbtnTQZ7T5yej?=
 =?us-ascii?Q?olDhihrPYXJpkRReOTIv7N69Dv8rPwO5DiTEpsFNh2On3P24zLhs3z+5U51F?=
 =?us-ascii?Q?zrTe6tCU0nz4aUXEgqo1G86FzCm7jG5QOTg4628UsX/b5MtUcPg7tWmVA7q3?=
 =?us-ascii?Q?HwdCZBhLLyi3bVcAci85sTz2E6Mk/js1R2koR1/79GKBmrct75Uy0It2D3/8?=
 =?us-ascii?Q?jwn9JI2/eYvfTmI4qOfmtw28A2e2xDC52mlGapMgKdVlf+6ih7tzqu006Fg1?=
 =?us-ascii?Q?Z1KoWncutyetTnOAl8Y05SHItyygK1oRqwF5X3UCxXHNe1Lnwc4u2saoym/a?=
 =?us-ascii?Q?ZgnpLivdzqSfBg9KobPb/gwYzevYkggXnfYZpj2DbosEcBkmS718lq30uVAa?=
 =?us-ascii?Q?MSZlbvumn/cinNqOarT0vCAvrKMEm56OG26Y7/PeUbtf2E8Jt+87GUsTMVim?=
 =?us-ascii?Q?Ua2xKUQNrAsxEIzlEUyeWQnC1UlMRuzk3oHRzhZDQ0WAS/MQ59kn6Pj4hKRE?=
 =?us-ascii?Q?DpWKfnRvjdzYOfLyGVIaoG9+Mwo9Z9CGw8D7o8UocaNYnyynM4mNslewQqe9?=
 =?us-ascii?Q?OpNFs511h96X53YCEtxrcxK4/yPkfk+yBXB1zkFCqmNf1llBtJZ3+vRqi9zv?=
 =?us-ascii?Q?3kzdwn8GLdJrfT7VXVaCqUJgAy6PElWFr+HCdiQcabi0jdwzQI7sQvXXK2RJ?=
 =?us-ascii?Q?Gz3NWpbvgvwRs9BjBOLGUvsADWhJTj+o+Rzivx1FYsfz20eKtBwgHm8ao+LX?=
 =?us-ascii?Q?aOw/IPwnxIBsZUUehSemEOi1qGSW9ftsOeVXpdi9EuqO2fLVZWl/EVOV2i5G?=
 =?us-ascii?Q?DKq9+ng3ROkFiOvhMHj7+9OYFecdCB/NeBgArN0sZk60HsK6zUcWhbxn/P21?=
 =?us-ascii?Q?YAhUJnMJ/eXkeex7xZ9yzccOnMDLOLFGybQf6bH5LTumpB7ycrAzyKYZqPx1?=
 =?us-ascii?Q?PZjpMWcYYXs4SeGv1rY3By0J/pekeTFX0MCvVRJnmW6xv7BPqzEBDEt8LjPY?=
 =?us-ascii?Q?8tBQ7RBH9H2LX17qWz3fswZDmWfll6/v9/d7MF7/Mq082Saq6LGi7c3gAz9+?=
 =?us-ascii?Q?4z1aXh/GnPq8QDOSgpKg+j9acOpRi4I64v9rEXSU9F4Q835U2GHvlJvC7o7o?=
 =?us-ascii?Q?xWAk5il/YDqXlY78h04gPQr8Lc1yAO90I4Effvwti8tDBOR4QdKdpWwU3qHC?=
 =?us-ascii?Q?yvcjDkrOe6QhdUMq1iBWD8ZVIFUw4qV3fs3k8TT6l7rIP7KjsyvwKCvowlEy?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f00cbc14-68f4-4ed2-17db-08dbaa533d90
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:51:09.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xm+Fndr90LP3yY9ic8nXwKJT2NXIcJR09nMOuQFiay2F5WHKH2ecK/DTWkwZWd4ZPGei6OwjUOqw/YR7V9Bp+nDEjmIsfx5qx21h8WjhA5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> Restricted CXL host (RCH) downstream port AER information is not currently
> logged while in the error state. One problem preventing the error logging
> is the AER and RAS registers are not accessible. The CXL driver requires
> changes to find RCH downstream port AER and RAS registers for purpose of
> error logging.
> 
> RCH downstream ports are not enumerated during a PCI bus scan and are
> instead discovered using system firmware, ACPI in this case.[1] The
> downstream port is implemented as a Root Complex Register Block (RCRB).
> The RCRB is a 4k memory block containing PCIe registers based on the PCIe
> root port.[2] The RCRB includes AER extended capability registers used for
> reporting errors. Note, the RCH's AER Capability is located in the RCRB
> memory space instead of PCI configuration space, thus its register access
> is different. Existing kernel PCIe AER functions can not be used to manage
> the downstream port AER capabilities and RAS registers because the port was
> not enumerated during PCI scan and the registers are not PCI config
> accessible.
> 
> Discover RCH downstream port AER extended capability registers. Use MMIO
> accesses to search for extended AER capability in RCRB register space.
> 
> [1] CXL 3.0 Spec, 9.11.2 - System Firmware View of CXL 1.1 Hierarchy
> [2] CXL 3.0 Spec, 8.2.1.1 - RCH Downstream Port RCRB
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/port.c |  6 ++++++
>  drivers/cxl/core/regs.c | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..f470ef5c0a6a 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -73,6 +73,7 @@ struct cxl_rcrb_info;
>  resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
> +u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9151ec5b879b..da4f1b303d6c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -979,6 +979,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (rcrb != CXL_RESOURCE_NONE) {
> +		struct pci_host_bridge *host_bridge;
> +
>  		dport->rcrb.base = rcrb;
>  		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>  							 CXL_RCRB_DOWNSTREAM);
> @@ -987,6 +989,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  			return ERR_PTR(-ENXIO);
>  		}
>  
> +		host_bridge = to_pci_host_bridge(dport_dev);
> +		if (host_bridge->native_cxl_error)
> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +

Minor comment...

Is there a need to gate the discovery of the registers on the ACPI
setting? For example cxl_pci unconditionally enumerates the RAS
component register block but gates *using* them by ->native_cxl_error.
