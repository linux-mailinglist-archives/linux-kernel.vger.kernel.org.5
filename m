Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E47A2AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbjIOWyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjIOWyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:54:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994783;
        Fri, 15 Sep 2023 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694818483; x=1726354483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tLJhr1A4kKD30E5GrrLdk9oc5xHaWgxf6e6wLZIGYw4=;
  b=hnNw178TQl8bX7tbm/3mkWZfEU/LIPJkzdM1qfQyJaVNa0Il3XHyJCDi
   YnvfWkmYiBHqxEzR0kUAbgkw3j7fvJjXMuXpkIY2PIjtFWKaxasevSeSc
   LVYIbfjtKv4ldeSLEL+vPrMW9dW60lttBMxIs/EJ4jWeBt/97pYnP0RxO
   44KWHsTAfagvwL7MAyTmUchV9/AIcTxGAA/f5rZULZNm29Fnlmwm4X59I
   t3vOq9lZ1Qxt1aprQVHkU/7PALzKlct1b6ONefmmSWF1xAWzlwEddqAHL
   eLcxjycj5GBwzRvCzuwuolVHuFxe0+uKDwIuwJnn6kQAJ+tcxyJu5O3TH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369678938"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="369678938"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 15:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810676430"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="810676430"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 15:54:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 15:54:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 15:54:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 15:54:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 15:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBAhjhFxo7fN3RgrI1nkBNnQHu98Bi8Cn1plsaOs5qfa+5+3zP1QCzXLR0d7Par0wGwxl2u/BBkEW7gc1Egc4qm+he5+YKXYRzMBV8xbtJDdq7mF8luBaqCI86f+d0uL1jM6aOK3Q9y+tigAVGV+g5RT8gMj+DP57zJn5mAHwW/1LtJPpi85o3q8C+bSPEIEvXLE5akT1hJs4qpB/UKnaOu2kRXYAc66RMZ3GN2beHMyJpgdnPfrUrKS0jG8W6cbJltf2kJLQMCnAhGsd4inE8fz6UUy7gr8fuHU80ArUiQMF3G6HD2rwvZGLB6EFkTL7nQ/NliTL6iWvqXe0pDUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6fFh2kWdAgxbne9w6f83kBmVT49HhxciJLkEoRHYjY=;
 b=QhiQ+jZf6Id54knKEmZDvCZhXUeSsBQaUYjRrXg9hzmUx+dV4qb9QvFIqnWirLf/nIheBd20CvjU2dRBvAMCJ96ejYqD6bNG/5nczG/LUXXkmTxTgz0xqgeqrrQ0alSVhfQ0FuqXpA8KC9d48BVlyTguwNVxGRD/T7X5PP//+MdAWKkke24KH/pJ0cbSmGkuHz354whMJ0/jLO5uACrX6i6RysQaNpA8NtfYttlpRl+j5EvF1dLeXLwLLq/dmXojlvQ2nxEgMPKclHsHpYMcbfuu8tgTU3/uT0srJVemow4uMXoJpKHUM2rCE4Mh8l5OHaOijM1MvlaGOTKbVexxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 22:54:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 22:54:34 +0000
Date:   Fri, 15 Sep 2023 15:54:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v10 04/15] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <6504e0a74d073_d7cc829499@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-5-terry.bowman@amd.com>
 <64f0dd4c8965e_31c2db2940@dwillia2-xfh.jf.intel.com.notmuch>
 <6503a23013cbf_12747294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZQTSRk6gOg41ybG1@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQTSRk6gOg41ybG1@rric.localdomain>
X-ClientProxiedBy: MW4PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:303:16d::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: b3331461-f7d5-4ded-cad4-08dbb63ebabd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tx4UIhYN0WKQq7RApj6p8WaMsRfZhzkQz+Wrkr1o0gQgq11ki/BRVFaF6XfXBwlxnPoQUbFBdMN2tn1DPCn4sj49CUWsIGr9LoV+PmFYOWpPwkdl2Eq2SHehBXvrRHymqTnOxETXc4+IlnfKRt3i+dA/S7GjyPZK4o+o5HdMqBQZcLLsCybHMcQ233KIsH8E7/t4tSmxD+lCe2QDZopK6/9DwWz/CdHI4u/m3xt+CI+ERKFix2MkqPhiIhrBTIEyBjpKj7M2QG8EnSvUmO75IBZ0wCnDlxizIR1OZZSwnKwTxz27+gESUTmmn3lMFXnfZHqZ9wdFLDaE3TT3RSfJWqDMFIrJClzMn1SwWwTigBbrQ/rFcXAKVS9/TcYB0W7npaE0Ss7Z4keL0TmbMcD4qGC8D6Dy1GLpkpfb5wp3PA+ohzYNn6nawhYMxj0WGoW4grzjThV+H6CXXlsFwihgLPnjUS8PbnRTvvdVctKmswXaOiH7O6X3VKHpRBuLhuo6FjJXJdVRM16yhjlDVhV/pSiRPmnZshK6jTALA5gEeNSH3qqgJ4sa5qN7wHBYyZO8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199024)(186009)(1800799009)(2906002)(316002)(41300700001)(66476007)(110136005)(66556008)(66946007)(5660300002)(8936002)(4326008)(86362001)(6486002)(478600001)(6506007)(8676002)(6666004)(83380400001)(6512007)(26005)(38100700002)(9686003)(53546011)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JhOaV+TP6f0O3gcjsvsFHdlKqdj9YVTO70QXeFXJjym246h1JhQMYLjlE4KS?=
 =?us-ascii?Q?/f8v3Cv3IaBmtAta5s9xwnMBRcFx5E2PSOax7y+3MNxIoovKwKJqL+f5uZv5?=
 =?us-ascii?Q?jS0mU3qkaw+MkWpNS20D5gnDR6H6+7TCupJmA50leGNNwAt9dNeto9Ctu1Gl?=
 =?us-ascii?Q?ZtfGP5XY4jjYhDXoCGbc+Ahq2ahEDy1In5HSLS6uP7v97d9TmXrIWZlYer+p?=
 =?us-ascii?Q?t3SYIgUwlNMSsgAymz1gEKXUqLnK+GXIIlIo8/oVG0bhOetuvJ4mO0YmFTg2?=
 =?us-ascii?Q?RgW4PkmwJdDp9R0FRfeIKqL6LGuzsYpzbQ51A8ZK0r+ERyBzx0C1f2T8n8Df?=
 =?us-ascii?Q?MmB7Ei7dbuXQ+g3k22OFXPYDdL76mDmqP773cg8XMYBXp/fRIJwI6zPjpYzT?=
 =?us-ascii?Q?xT4K5YZyx91YZEJT1N/OgIr6BSibWimsIAtialMaGdinJGfvyBiMFLvz/Q3g?=
 =?us-ascii?Q?DyI2zNkjecd3usKiMDH4irXpCXY8SYOE6m3FI9epkpxzBe61rWl17G/EApHl?=
 =?us-ascii?Q?SxzeLlTesDiyMiONej/1frGTyAiO0YlI0DPj+hmdzRSsm9wiPgtVWxyXX/lg?=
 =?us-ascii?Q?oP0D+q5tx47nFe38k7MksKvoWQqbyjTa5apjzQKcuYUJ91RWazl356fXwVau?=
 =?us-ascii?Q?wbcRiEgULauMgspCz/CWrvjXRerGLXoNoszD2zAqyYL3PJMe+cKalXg/SxNR?=
 =?us-ascii?Q?LktqTT2L9k7HIqCJphYfczvFg1+FiguVMQJJ38w3tqpn8FFWvGqNJxF6DAde?=
 =?us-ascii?Q?lu9X9NFLLy0VlwTLczpDFUOnGt68Uu0v0qy+5ddjsxmvh/0GwybY148aDrJM?=
 =?us-ascii?Q?kl0XKYcHWgiOzBFtdZaevZv+79qgDcgF0UzYTPH8PYVuGo+FypAtLbHOZ9lZ?=
 =?us-ascii?Q?2CGcIkVZ4c8HHilY9PP5vdSDW3RBuxbuTxCLAVPTVTOcsG/Al+2HDJltk50D?=
 =?us-ascii?Q?97AuwN7FQg3yupIOXoEpPKB832j8PouCDkqLE9RzAsfsJ1LGgPxkhVc4fpMa?=
 =?us-ascii?Q?olWLJrinkHpQR3L5OvvS29iTghsDcQLc0XsncrRU2OMdh+5ok+3wilEY3C8c?=
 =?us-ascii?Q?Y4iO52MP2RuW4yTfDOaHpICMT9zXT4ttPgVB1JyW6CStPj+z9xopcF0HXlAw?=
 =?us-ascii?Q?kHdklRtgEchnjYtz/yMO9TwM2ZHGx+kOlXfFDQC+WhEHxVu+q1bkmn+S1/Mj?=
 =?us-ascii?Q?a9Ezo0pGbFVtFWUzcCbzguWBfweRflT2x0eKNW7RMqDESZPlDByYz+bNTt/j?=
 =?us-ascii?Q?Y49D3mAJecRAHDJ6pN9Ww1Xwsdg/zTRAwCrDlm8ohBd+xeWK2cQIT36+mAJ3?=
 =?us-ascii?Q?jt2Y7I3tf5nnj7Z/gpL3mN5FKRV+2kT5dSoq4zQyyRWMsTibiyZmUqPghqaM?=
 =?us-ascii?Q?Sq2TBOqPplcIcLimJiX1/EtBi4g9+H2XrWL+S4E82O4nqEGv2EtPTahSXWS5?=
 =?us-ascii?Q?fCjs4VWzC72WoaEx0tMqK27faGe/r0Y1cSjzJ9Z9J/10MOI9Ym1SDdyKLekA?=
 =?us-ascii?Q?W0niqdtrIVUQwHEeN4nhsKRUppXu+ZAN6PNRUHF1tlEYbPuaONG2sCBOXpxL?=
 =?us-ascii?Q?zOOXOWi5lkpY/YML/wxPvmY/btxaX8O0XDLxHaPuNSGEKGVPMHjsOTwy8roR?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3331461-f7d5-4ded-cad4-08dbb63ebabd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:54:34.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntYtVxwSIZq1mJfC1f7qmJ6/ykMEH6RtZITh6VY2AZTRUwo+Zi77vuh/B29J6UQRZOa7SFvy6d+AL7/F1nyRp/yXX8UDwYZ9xf0SVTsZpfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Dan,
> 
> On 14.09.23 17:15:44, Dan Williams wrote:
> > Dan Williams wrote:
> > > Terry Bowman wrote:
> > > > From: Robert Richter <rrichter@amd.com>
> > > > 
> > > > Now, that the Component Register mappings are stored, use them to
> > > > enable and map the HDM decoder capabilities. The Component Registers
> > > > do not need to be probed again for this, remove probing code.
> > > > 
> > > > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > > > Endpoint's component register mappings are located in the cxlds and
> > > > else in the port's structure. Provide a helper function
> > > > cxl_port_get_comp_map() to locate the mappings depending on the
> > > > component's type.
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > ---
> > > >  drivers/cxl/core/hdm.c | 65 +++++++++++++++++++++++-------------------
> > > >  1 file changed, 35 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index 17c8ba8c75e0..892a1fb5e4c6 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -81,27 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> > > >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> > > >  }
> > > >  
> > > > -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > > > -				struct cxl_component_regs *regs)
> > > > -{
> > > > -	struct cxl_register_map map = {
> > > > -		.dev = &port->dev,
> > > > -		.resource = port->component_reg_phys,
> > > > -		.base = crb,
> > > > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > > > -	};
> > > > -
> > > > -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> > > > -	if (!map.component_map.hdm_decoder.valid) {
> > > > -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> > > > -		/* unique error code to indicate no HDM decoder capability */
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > > -	return cxl_map_component_regs(&map, &port->dev, regs,
> > > > -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> > > > -}
> > > > -
> > > >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > > >  {
> > > >  	struct cxl_hdm *cxlhdm;
> > > > @@ -146,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > > >  	return true;
> > > >  }
> > > >  
> > > > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > > > +{
> > > > +	/*
> > > > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > > > +	 * Bridges. The Endpoint's component register mappings are
> > > > +	 * located in the cxlds.
> > > > +	 */
> > > > +	if (is_cxl_endpoint(port)) {
> > > > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > > > +
> > > > +		return &memdev->cxlds->comp_map;
> > > > +	}
> > > > +
> > > > +	return &port->comp_map;
> > > > +}
> > > 
> > > This was the function I was hoping would disappear in the new version.
> > > cxl_pci and cxl_port care about different register blocks and have
> > > different mapping lifetimes. I think that justifies having the
> > > endpoint->comp_map be valid for everything that the cxl_port driver
> > > cares about even though it duplicates some informatiom from
> > > cxlds->comp_map.
> > 
> > In the interest of time I went ahead and reflowed this patch to the
> > below and it is passing my tests. I also noticed some other @dev vs
> > @host confusion in some of the previous register conversion so perhaps I
> > should just send out v11 with this all rolled together...
> 
> just a quick update here.
> 
> We were going to send v11 a couple of days ago but I found an issue
> during testing, see below. If you don't mind I will send it out next
> week with a fix for that included.

Sounds good, I will wait for that update. I had found a couple more
issues as well, like come some confusion on the @host for cxl_dport
register mapping. I will send just that out so you can incorporate.

There was also the feedback on moving register mapping calls out of the
__devm_cxl_add_dport() and into the driver that makes use of them.
Similar for root port interrupt enabling.

> 
> > 
> > -- >8 --
> > Subject: cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
> > 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > Now, that the Component Register mappings are stored, use them to
> > enable and map the HDM decoder capabilities. The Component Registers
> > do not need to be probed again for this, remove probing code.
> > 
> > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > Endpoint's component register mappings are located in the cxlds and
> > else in the port's structure. Duplicate the cxlds->comp_map in
> > port->comp_map for endpoint ports.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > [rework to drop cxl_port_get_comp_map()]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c  |   48 +++++++++++++++++++----------------------------
> >  drivers/cxl/core/port.c |   29 ++++++++++++++++++++++------
> >  drivers/cxl/mem.c       |    5 ++---
> >  3 files changed, 43 insertions(+), 39 deletions(-)
> 
> Patch look good to me.
> 
> I have a similar implementation, but did that with a
> cxl_port_clone_regs() function in cxl_endpoint_port_probe(). I can
> take this version instead.
> 
> During testing I found an issue freeing IO resources with devm for RCH
> mode. The endpoint is not removed if the cxl_mem driver is
> unbound. Then, the resources of the endpoint that also holds the IO
> mappings are not freed. A subsequent IO map fails when rebinding the
> driver again. It looks like cxl_mem_find_port() is broken for RCDs
> preventing the port from being autoremoved. I am working on a fix for
> this and will test the whole series again.

Oh, I see that bug, yes, good find. The cxl-topology.sh test is only
checking for endpoint port removal on parent port removal, but RCDs do
not have the same port interaction when the cxl_mem driver detaches.

I expect you found that delete_enpoint() is the problem in that it
assumes the parent_port has a driver, which for RCH it does not because
that's the CXL root port.

In any event, glad to see this moving forward, and glad to let you
drive the next version.
