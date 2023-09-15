Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BA7A124C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjIOA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIOA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:27:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA15526A4;
        Thu, 14 Sep 2023 17:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694737669; x=1726273669;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hWGof5zDXpeP+YEGuL9M2HPIIgfWx7UCy2u8QpdhA5Y=;
  b=lAwcww0RV8j69SqO/KssjAhqDutIVOCrst54PmEqSZ5WJmhX2xUNS5hJ
   OtCQNRTjEMs6RbS1TMDkIDFPSVTcI8LQ/abLsU+DLr0XxWFl7QHNK+278
   9SGAui0QiFOibF7d+BH68H3/pQqYhdps87at2wwco9HY1WU9hDzjJHe8o
   USvBlkTd/P3dG6DNqin4TPwHegkevN7ODsZGCjMyS6/Orju34OERyZOOL
   92sq2KWXcomQ69A6iJ5RtmZ9mFi8YClmakhtQstDku5T421nlpFObIpg/
   9AcFNxa3lBcjexFU+wQHo5Me1VEzAleRwpIDPVlY3Zly52PoFOG8Mw8A8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410060844"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410060844"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 17:27:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="868471035"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="868471035"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 17:27:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 17:27:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 17:27:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 17:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OC6xOz5o0gqHOmANGa97HCKQ+SeOuV5QVjm+2WE1jCsa+dbr27z7pTm5bP5Cbmyae63JQSjpiODvZbRdS8KX4iYflGeQPwO9gXRMV0i2vbO26siQ8SPwPvVNu+R8AS6IZBbTSr5OJYEfwuwPTFXEfLwfCZWo0k1R6JIZxxanWDdNGj/rc/F8Se9ZKLkiD+liyy10SdKLuOlhLvd3s4OxESF7QFlyn3rN39mEbpXjd8c6k/TKTlj7E8GDnJ+RarJmIQWEmw67T/QWDrUiIIMDzwXtGX0WwSK+OZVrLm+GNnsBchs8Vrc732dyqJzz6W/cZmZ28cwQI4iWtoKDOJkvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNKdb+guT0dgMblzfbmHNULYZPZis5JL+DTrpng8J54=;
 b=VIO4wUxtTMER0LkRviHH2DlMjYwayJdL9CneG3MNU5y+lUIt0gv6gymDW1KQMo1umUoS2WAH+9eX1bXvj5GbXA8se5Q1Re5aiJzq8cml5Cqy/ySCpLs0jbKdDB7DZH19tr6Js1zMARfwvUECY11/DztJeTBLCmD4yilu8ikuOqlkHoa7q759yd7x6YTUPs66i8HK7NzZV9BJEeV0ktjyspjLdBrcCjlXYkeKc8Y/Ahj7k/4gSDbFmnN00tFOnVYrnyDuQYZkEjvKfhCx/6lvI3I1ChmMcjx+wjAaSA8cgeDMOM72wG0gX6plbV6RUOQ5bGer7kI6Xm6TZuIfN/6Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 00:27:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 00:27:39 +0000
Date:   Thu, 14 Sep 2023 17:27:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v10 10/15] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <6503a4f7c8aa0_12747294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831170248.185078-1-terry.bowman@amd.com>
 <20230831170248.185078-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831170248.185078-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce0753b-432e-411f-674c-08dbb582914d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmVbW5jcZFlh9hJBRnLxnqEYkc1f5S2XACVQ64QcMMeGOYwFxBFxCTGh85k97HFRxpNIslonRyiTZ5nVAjl5GMEFGs3WeHo0+xyopcGiArY16yvKOTyHxBEvQN1Z4honPrr0T9BZwC6AyD4rptt7gq8HiNgvz4D4J7SAoQ/paXBRDhBwc/pym935fqCdA8nPUd/oOD9gjnyAwvemb5KzWRoGQU6DHbokhZMVqeOp2HD1y3ejqMc2bumawRkPrEDfXedAeommj44mhvB2uMiiH24ImigG6ah5e/3zQLa613rXkTDyrI7rDretI9wxKjEydbdS4RmBzDkQeSkv+0x/Mw6oDESV05XouhrqWlTc5S4Gesx2vk7buSljNJT5/qZnZ+BgFRFWcFojdIg3RX+x5ZuItEIs2kXJ0IozU8kyna8qNoCsPSqLMqE5sIJSzpYn7tBcTAUbwZafvGfA1ys0qPZJcWa4akG4GjRU1ubQ2iolsjwgmhGr7dGE8IQGzl2WVJP1EdhMa/x5TybwQgual6LicwWMSFzg/HvGWTbEDVLuHJAPbU8vO+orRCMWaTBP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(86362001)(5660300002)(8936002)(8676002)(4326008)(2906002)(6666004)(6506007)(82960400001)(6486002)(6512007)(9686003)(26005)(38100700002)(478600001)(83380400001)(66946007)(66556008)(41300700001)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DIa/LRZznDrlJitk2WLp7M7r+MNB1kthJN5y36oir01BoHd1ytG8N0+J1oIp?=
 =?us-ascii?Q?s0tyysg8mxPnUSdC4BiAwqOzy2oLa4wL0mqPfWPD0fWd00N5SJtbH9cy+/B1?=
 =?us-ascii?Q?E0e1B+UC8Ra7M4Ya8QCtlTfC5X1JwoPihsNjjilqrYhwn9nJn63ypbD/FXyO?=
 =?us-ascii?Q?HwbYA3G07p5hgfQO+TGkJdCqYiDURB6uHdWQYQRHi3UBNZKUegJOovKKYMnq?=
 =?us-ascii?Q?CR39A3QSLULbIdHJcoV3K6skXdgL+JnJIofeiKB6kM+/nDtc+6jszFYxIl2d?=
 =?us-ascii?Q?LpWJABSXRMcxT8pW/0p6kWefofKiJXfsm9Q76JENFmI9IzRRxz4gAX2zxh1W?=
 =?us-ascii?Q?aJqqfwjfAp8DcPUX2haTpzd0JyDRd9PumirLoWDpMwJfCtpokxe+kdQgj+pN?=
 =?us-ascii?Q?QwCLNWzC2vbJB1LgFROKmpGEzENaSTFMn5NmpwMzD6M7RNakucTXk4Tyg+w/?=
 =?us-ascii?Q?bEhbHmiFfuH9mU85bTN8eKMAMj4TA01MlnIR4HFzaQxrg316eA6krVSOUSkb?=
 =?us-ascii?Q?owGOrIiv5vidvmn++UgAyG7WWbVGfxerY+TNJlMG6S0qnBWl5jnyVsCJUC30?=
 =?us-ascii?Q?2Tv6Yeu/XOmVq4Wl0s56G5J/7Uxrjb503MBMkj0bwWWrf5znXAXZBvndNOYl?=
 =?us-ascii?Q?K4cjxwlHbt7VNFbWVa4RzFBf9wIFp1J5SrYPje4mK5lfYGZS2BcmzhFstPxF?=
 =?us-ascii?Q?Er6trl347dcfkXIUrmoEgbXVvcMIGg+PtAv4i1m/rzq8KXHPm5dReWzj6mtI?=
 =?us-ascii?Q?sAhXCXkoIXDyMYxMXRV4ogvfFvpCHd3v5n3jupZpQzR+MYy8Q7356LHN54ig?=
 =?us-ascii?Q?f1an14ZPa32S9QN8TIJJAd6KqO654FdL62AORo/GU5CQ4n4wMvneV/3s/bPK?=
 =?us-ascii?Q?5d+xTpoPIePFa/v734AzBZgJPqp+252GrPzOhNkFCkjeS4R9+LS3xknyHrew?=
 =?us-ascii?Q?xhPusUegCBrS8dqFICpAuzb8AnsP/BPoKMIUlXxmDQvaqwyOOdST347Fw75B?=
 =?us-ascii?Q?5Zitu17yS3IloeuX4JLNHcTCLQLOP41xbd6dqwdvCTLgFgcB+uNh41uP6d1t?=
 =?us-ascii?Q?JRwMFqPPBgz/UnuX9dVVkuvWlE97SAyx33urcn1PSVs1EEuQ0fMqLn0MGB2T?=
 =?us-ascii?Q?tu3eR7GTN8s7UDNhyDkc3o5PGaAS6O7T1WRe1Qva2qWQJb9Z81yD57KLN9UQ?=
 =?us-ascii?Q?rL73ZU6toP547uC8ziL92o2gDiNIl74c7oH56SJ7AV6LoFxGY5e71zxZu9sp?=
 =?us-ascii?Q?/9WU59eMQ+8WvSFFAD03sJK3je6Uq4JsfwHl3em4YZAYIIq7Aa/hQ5BczyIX?=
 =?us-ascii?Q?hPbPLnFKNlZttXOuLccypWZk1SpZ//YdfHp9QNeMSaP/cUtx0kmxuHyrE529?=
 =?us-ascii?Q?0emK3CrEkL8NHk/DOnWkWb/ZFz9UJjRf2Gt7SlE1vHH7k7sNtYzX1jN9nCtn?=
 =?us-ascii?Q?E5tP3t9eWv76c/5GdII2n6NhDyVpHaPImJg0fbJpJ5jeaRfXn9zvLIlv7biI?=
 =?us-ascii?Q?wRNDX4TQCL+K/JK4kT5KwhlbNhWz5SomHvgBEi5atnWHECzSWDeCUmfUN+9Q?=
 =?us-ascii?Q?6lxBwMBOrkrwtraGq1BNRc0CN94rMK/SRzfeopd5fKlJjoAiNbWtpRMI9Oih?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce0753b-432e-411f-674c-08dbb582914d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:27:39.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbluOnXNyBnnq3ee7nf282lrecoGRHJAUn63uyJH+5/2teJhMrbTlM4xsBqvlJHV7aRxRAs6U28BzoAvLcS1/Q28+0ODn0WaX41/BM84ynQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need
> to be virtually memory mapped before enabling interrupts. Update
> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
> the RCH downstream port's AER and RAS registers.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 +
>  drivers/cxl/cxl.h       | 12 ++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 45f8846d8c8a..2a22a7ed4704 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> +#include <linux/aer.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> @@ -949,6 +950,37 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	struct cxl_port *port = dport->port;
> +	void __iomem *dport_aer = NULL;
> +	resource_size_t aer_phys;
> +
> +	if (dport->rch && ri->aer_cap) {
> +		aer_phys = ri->aer_cap + ri->base;
> +		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
> +				sizeof(struct aer_capability_regs));
> +	}
> +
> +	dport->regs.dport_aer = dport_aer;
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->comp_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, dev, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +
> +	if (dport->rch)
> +		cxl_dport_map_rch_aer(dport);
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1008,6 +1040,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	cxl_dport_map_regs(dport);
> +

Mapping registers for usage is a driver operation, not an enumeration
operation, so this should move out of add_dport, and it should fail the
driver load if it fails.

Yes this happens to be the case that dports are only enumerated in
cxl_port driver probe path, but that need not be the case forever and no
other parts of the CXL core are lighting up registers from an
enumeration routine.
