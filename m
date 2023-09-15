Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874787A1239
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjIOAP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIOAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:15:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4302102;
        Thu, 14 Sep 2023 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694736951; x=1726272951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cYfz5W94R4Wb7c6NdVGWBQ5viKC9rzQcjJjtLNyUk3s=;
  b=EYJc3IuDZEF80axU8HineKD4JeAQM3WHtGgAvHXuJ5FhVCFEAt6IMhoJ
   3VfACBkCEmupr+2olw1ZidlhnzWACOU95diT9wVPfb8lxuCutFds5ZJCG
   6ixpTAFBN0a+TORl8KwyUdyC6hWEH5ftoChUGs6+xanaVuDfzg+7jkLmF
   qrY/uO8oRAaWixYs37IUZI3wQgnq9lx0cmt9QX16Yv/odd9Qk/rfXSR0M
   DIUcsiu7fEFcl22241K4l4wj2FdRLhm5+i8KDsfVfhIaGn5MiLxjcl2iv
   VSqynFPjCDljMXh3qEZeTSvCx9VI84zT9Ojh5A4Iw8oVWkmrWScvtX5lN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369431369"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="369431369"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 17:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744751620"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="744751620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 17:15:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 17:15:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 17:15:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 17:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxFmv1VbK3THQwZBU3rVv/7MCGtEV+N/7XsdQWf4ifzzIXPnaB8149bBC0Qeo4XxGvaCXYMC8xQM4y4bABmdYGqZoI+KTfLm5d1kufZ+gamcBSVhHdRLPGq1S32jgrCkLRbql7TglHNK7pgGEd7JAne8heu3jVRYIR0as7CyT1gL4PFsBYzTvFxbsWObHMniMY8cihJFldvm1/3OgjoSrEwaGk/r1z7iekGJeoVUMA8GJGPtkGlnWKYjs7wrCE3vK7IoYnE0+ZpvUDC3Uy31vwcnPc6VWBDWqZ8KRyWnQSxxt7nMeEU4H/UHlrEurfKjawYa3n6ZfOCIhJT/Yi9Zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQAX1ehpdPWc/4M4a4kfYeI3msksqOtRCqdlMd9kclg=;
 b=AN4ls4/mmv/lzoxsxD4Rr8O7y1cfLfI8y2H0Adq7G97Hn+JERk+Dfi08n9KlkEwCUR1rLOa9Xpdn5iZPirjN2H0+2fr70uhSMjEEe6peZROUHZ5j7vI/t/1FBVqdgfINcOz6UlN+F56TJ/VJLTLk+ZsgtHm8tmTMOKf7DEzajbMIPcZbG4EvpHpLaJ4+GO6Zb63/l5er+R1Aw8s1Ne5J8vvME54mYaaOxVU5AOq5v9eRrdl2p1zbMnoilXjF07jd48BuU7jj1FOsP8neq/F3l9b79dLLovB23QHtNqZIigk8hrjfHhPNqRlr/A9w1TlF30u5fnDLzTvnAZLAo+u0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Fri, 15 Sep
 2023 00:15:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 00:15:47 +0000
Date:   Thu, 14 Sep 2023 17:15:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v10 04/15] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <6503a23013cbf_12747294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-5-terry.bowman@amd.com>
 <64f0dd4c8965e_31c2db2940@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64f0dd4c8965e_31c2db2940@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4686ccee-4f2d-46a2-2132-08dbb580e8d9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjzo3/OAfARPPpTO5biTShZcPKy0vrYYeZtvWL2RfW31NRJ2myJVhmRqa7dYGXska5ElC/ffSvVJa6Ns0O4V9nN48ejex3tnLouT7la6T2Wy9K+wlPELwu1J3s38sgbS69iOhC8RrArHsVqzxkurOMi2YEI+XeXUhum24UtCQhcNynHOHNXidFk8Nys9j6UATsc6cvHV1ltqAgktoV94lthwoiwpbfZZobOgq6qiyvoir9poJTZkWhwVivMHlwGx+GMCSLbTxOQgFe6fQKkinw5gf4SCP5L3Ulpgit4P3mlpn5HBH9T8mXj/Jx+zAaYyhp2JWf6vW5JGnSURBSuHqbWaOPP4LDqgSEWtT9bunCJAiH9pmVgkdokYl7SOYCnRVY5IUQZ2h/app7ddKeSDe9kVpBjrj8G3wvSd0hGtM9JIhungh49r15okfSwTBR7HhH3Lu23Da13f82oHF5XEm8aAyVFWzsFcWo/dbXPCwOnsIP01f3icQNAq+2lLrCkDYSa6x4pZib2yB8cFGraxJ63mgTO/J1YTiOdHHhKvEYuydJNN1H4DmcR7UOX01Ocd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(1800799009)(451199024)(186009)(6486002)(6506007)(6666004)(41300700001)(86362001)(82960400001)(38100700002)(9686003)(2906002)(478600001)(83380400001)(8936002)(4326008)(26005)(5660300002)(316002)(6512007)(8676002)(66946007)(110136005)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjC0TRUC3abo11sH2c1pml4fTlJrX01a7DyMHKliTstYM+uDeCNuP03Ccn6E?=
 =?us-ascii?Q?frDgTVc5bN8AhhAnUXllO71ktSbTphrI0twYwkPMctyLLBlNez15D/mpU0qA?=
 =?us-ascii?Q?SqlZVORC8eDfFJDWwImP1Uwl4i3wVexFjgAScEz0oHVycNxRqWoDU1pno0it?=
 =?us-ascii?Q?UEdRnRMKAgnVenbCMsDyChUhM5wuupnEO3O4Olm1Dj+5Jcx6aCZmb661c22W?=
 =?us-ascii?Q?a1CDeBv/gBk3PJZoVGuqAHD4kd1XPIi5/ru7wycGe7tFAzToVLB6Mjw9834H?=
 =?us-ascii?Q?Q+gtOyuNtJq9eUrLL506LOGWhttBOVVt7gsD2IZP2PzV4JpQApb32liS15Gs?=
 =?us-ascii?Q?9utxLbcxJGB8pk2Scvr85WU7u0oLN8AMtbO/83DIJte0Xcw6O7ysgg7MHhkU?=
 =?us-ascii?Q?XS6erXH9LyuDbKQl4qx6fvOtoX5zP6f2FE7AC/6H+3Atqpfn48XWooGGo1P1?=
 =?us-ascii?Q?jwhu7lQU3ksHI+Nvl7jQV9cLXDRasAgi3tkp7TucptY047fZybo8Kuy+1Ddl?=
 =?us-ascii?Q?+Dqj0XC0RCwIbdULAZFWIqhvRH0wo45I/qGoCB5HaIMXEovwP9V0+gVfn6oD?=
 =?us-ascii?Q?wHiaE3rx6S0cq8QxC5ta9tbNzcHrA1dbPP7OfjY57rQz/fDB/O0Nwr5l5/T5?=
 =?us-ascii?Q?T5IiJydV6iCjSH70j6UH2CMDUB8diMBVG8qEfqUwNPndOvrBy02DQ3uqe2sh?=
 =?us-ascii?Q?oRvYdr9Sod6/4ysvzjch0JFF4le3VUrvwDLnYvbqzhHvTMWlpswM5oioZ92J?=
 =?us-ascii?Q?3aVkT8DlNK3ZcTevDo8gSVcu0jglMEUbixzr3P7883kuCJpwZZB/zrvdeGQf?=
 =?us-ascii?Q?1tXCl4imqaMjn9EP04aoj1l7zgyopBk67nDt5nGJpeQAgILN9cwkTGmnWikM?=
 =?us-ascii?Q?bY0kKD3O9CNKgq5bfZ6VMIYW22UXc1rLvXX401e2a6lOJiB9/TbwNGzR3CP4?=
 =?us-ascii?Q?IIhTqcA7x1WPqY88I2BzgpgHSQjRRMD9FYpUe93Q6ZBx5oCFxPNwYCCTJ2SJ?=
 =?us-ascii?Q?+CSt1E4B684R8WPIEatxg2P8HCqN/L5okIkqEq+3CuFfl2W/7Vw346gaeK4E?=
 =?us-ascii?Q?lQlOn587ZBaM+pK+UdeeItdLLQZT8OZC+AWZyMPXWAgCkrXPQaQXJKSMbxMW?=
 =?us-ascii?Q?0mZ6ly95sP5cEKhuSUhO9n6RnR5hy++csHti2IkhYl5CQ6uOT9d+jbxYHATB?=
 =?us-ascii?Q?FhxAkE7KzbvdnoCFyyPlyqXoU3TR9GdAtlU6qDMAEBiNemLPPKXYwksKxhm8?=
 =?us-ascii?Q?NE2dnGk+nToInMPdZafrWzAZ07I+IVhzU8PBlzOFo/Y7WNWvGGS4M21arLrj?=
 =?us-ascii?Q?Lq9bU4v/DIMGvIkDRQVPizwK7dRkc0CA0GI8AI+c7QgNwLS6FWbTO+33ZVy6?=
 =?us-ascii?Q?3FhzvSZn3YM7vRzr8DVAQb6Q7rH6c5VHZWSdjLfUm97aimmS9Q8X6X0dMoT4?=
 =?us-ascii?Q?qozgk8sMJi7liQSYfBF3UI6+GeOYwWxuagObTP+eV8xKFLLtpkwK0eexvXDb?=
 =?us-ascii?Q?eZxVjIIykRGT8zMUjnOrEaC0qGUEQhn/CMcsgA8BHuj43/dZ+VW50/s5z8Qq?=
 =?us-ascii?Q?98LfHyMeUox7K66+dhltMGxGI7Ge/3ggxTO8s0HNzGgeBmsTYHq9+KWkm1S7?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4686ccee-4f2d-46a2-2132-08dbb580e8d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:15:47.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yHb4VfkuQKaiYkdHE9rYSqtLEmAl1XWklxHbwdFe/rT5W4c82fOj2pfR4eYXM9lmuVAeHgO1tcHP2nzCi9OptFHqQvlUBMkaEfqq2CraDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > Now, that the Component Register mappings are stored, use them to
> > enable and map the HDM decoder capabilities. The Component Registers
> > do not need to be probed again for this, remove probing code.
> > 
> > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > Endpoint's component register mappings are located in the cxlds and
> > else in the port's structure. Provide a helper function
> > cxl_port_get_comp_map() to locate the mappings depending on the
> > component's type.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c | 65 +++++++++++++++++++++++-------------------
> >  1 file changed, 35 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 17c8ba8c75e0..892a1fb5e4c6 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -81,27 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> >  }
> >  
> > -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > -				struct cxl_component_regs *regs)
> > -{
> > -	struct cxl_register_map map = {
> > -		.dev = &port->dev,
> > -		.resource = port->component_reg_phys,
> > -		.base = crb,
> > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > -	};
> > -
> > -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> > -	if (!map.component_map.hdm_decoder.valid) {
> > -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> > -		/* unique error code to indicate no HDM decoder capability */
> > -		return -ENODEV;
> > -	}
> > -
> > -	return cxl_map_component_regs(&map, &port->dev, regs,
> > -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> > -}
> > -
> >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >  {
> >  	struct cxl_hdm *cxlhdm;
> > @@ -146,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >  	return true;
> >  }
> >  
> > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > +{
> > +	/*
> > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > +	 * Bridges. The Endpoint's component register mappings are
> > +	 * located in the cxlds.
> > +	 */
> > +	if (is_cxl_endpoint(port)) {
> > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > +
> > +		return &memdev->cxlds->comp_map;
> > +	}
> > +
> > +	return &port->comp_map;
> > +}
> 
> This was the function I was hoping would disappear in the new version.
> cxl_pci and cxl_port care about different register blocks and have
> different mapping lifetimes. I think that justifies having the
> endpoint->comp_map be valid for everything that the cxl_port driver
> cares about even though it duplicates some informatiom from
> cxlds->comp_map.

In the interest of time I went ahead and reflowed this patch to the
below and it is passing my tests. I also noticed some other @dev vs
@host confusion in some of the previous register conversion so perhaps I
should just send out v11 with this all rolled together...

-- >8 --
Subject: cxl/hdm: Use stored Component Register mappings to map HDM decoder capability

From: Robert Richter <rrichter@amd.com>

Now, that the Component Register mappings are stored, use them to
enable and map the HDM decoder capabilities. The Component Registers
do not need to be probed again for this, remove probing code.

The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
Endpoint's component register mappings are located in the cxlds and
else in the port's structure. Duplicate the cxlds->comp_map in
port->comp_map for endpoint ports.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[rework to drop cxl_port_get_comp_map()]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |   48 +++++++++++++++++++----------------------------
 drivers/cxl/core/port.c |   29 ++++++++++++++++++++++------
 drivers/cxl/mem.c       |    5 ++---
 3 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 11d9971f3e8c..ced7801516d2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
-				struct cxl_component_regs *regs)
-{
-	struct cxl_register_map map = {
-		.host = &port->dev,
-		.resource = port->component_reg_phys,
-		.base = crb,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
-	};
-
-	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
-	if (!map.component_map.hdm_decoder.valid) {
-		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
-		/* unique error code to indicate no HDM decoder capability */
-		return -ENODEV;
-	}
-
-	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
-}
-
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -155,7 +135,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
-	void __iomem *crb;
+	struct cxl_register_map *comp_map;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -164,19 +144,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
-		cxlhdm->decoder_count = info->ranges;
-		return cxlhdm;
-	} else if (!crb) {
+	comp_map = &port->comp_map;
+	if (comp_map->resource == CXL_RESOURCE_NONE) {
+		if (info && info->mem_enabled) {
+			cxlhdm->decoder_count = info->ranges;
+			return cxlhdm;
+		}
+		WARN_ON(1);
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
 
-	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
-	iounmap(crb);
-	if (rc)
+	if (!comp_map->component_map.hdm_decoder.valid) {
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return ERR_PTR(-ENODEV);
+	}
+
+	rc = cxl_map_component_regs(comp_map, &cxlhdm->regs,
+				    BIT(CXL_CM_CAP_CAP_ID_HDM));
+	if (rc) {
+		dev_dbg(dev, "Failed to map HDM capability.\n");
 		return ERR_PTR(rc);
+	}
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3732925162e4..64fcb5b22372 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -741,16 +741,31 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 		return port;
 
 	dev = &port->dev;
-	if (is_cxl_memdev(uport_dev))
+	if (is_cxl_memdev(uport_dev)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
 		rc = dev_set_name(dev, "endpoint%d", port->id);
-	else if (parent_dport)
+		if (rc)
+			goto err;
+
+		/*
+		 * The endpoint driver already enumerated the component and RAS
+		 * registers. Reuse that enumeration while prepping them to be
+		 * mapped by the cxl_port driver.
+		 */
+		port->comp_map = cxlds->comp_map;
+		port->comp_map.host = &port->dev;
+	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
-	else
-		rc = dev_set_name(dev, "root%d", port->id);
-	if (rc)
-		goto err;
+		if (rc)
+			goto err;
 
-	rc = cxl_port_setup_regs(port, component_reg_phys);
+		rc = cxl_port_setup_regs(port, component_reg_phys);
+		if (rc)
+			goto err;
+	} else
+		rc = dev_set_name(dev, "root%d", port->id);
 	if (rc)
 		goto err;
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..04107058739b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
