Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8127AF6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjIZXmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjIZXkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:40:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F7118E8A;
        Tue, 26 Sep 2023 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768825; x=1727304825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=39fzGLIIAGR05sKPRvzfrSou3lJZpQbhfYLcfP/SSpQ=;
  b=AqWsSXnX7Q4bvrLauDkb9yebLJixrBLmdDTkYblx+b4aLTqztr5KDesE
   RfZgnV7Lx0pEuix6Gg9K9eiGd2P/NwElVA2zsI6VkUY+4+esuwYWTnorR
   94kLnV0b+2In11akW8ior7EPisH32N/JxQS/xOfQYEpuWhpcnesADeWfV
   OmiN40egoRacixEKzP57bcaTEXCSGPWyUNNhh+E6wAhykoNvSnEB+V9+Q
   AKgg8373H04EWZpfaYwTI0by2luhVFFEW3GVn4Nx93xZOXL4TY1+l2pNR
   Wlajnj+HHVPd44qQqBYWChdiKhaMKJ19f9Wp5GqIig7IgO+wMKcHV2Gsp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380544765"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="380544765"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872648557"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="872648557"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:47:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:47:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:47:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:47:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRMxg1Jx19zOg4WEfo7jYyRqRjwvWZObbJ3MhLV5phquPf89a/x7Icwh30aI+w+4WcnAaWBeUQIESpP12CHia6mdwxFPhXC1p1hP0acDSB+T2cW5n4yS+XgEkReJXe2JFaEXwaOtQbTSlZman6dL/r+CF1sA6f3zWNOlPshpLXk4zgDadFT1R8hlqRbRuFYqgUUroUTftmav3xQIup1d5enMXYIaaIi2x2UG0FG1jhFsAVAHJFSKL+0BNK8TnLiDzVFpGzKsXsrKWgxvqq7KCD9xd9KLHnr/5B0UlRHQlrJ5nEjtPDj+GsiUxPc1EWbbGpVxdlDqcz2MeCzXmcExLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkYFO/idGsFlfk3LL/LTCj45TdGZjf51oPZyUiRyCqA=;
 b=HApw7Xu0UFVWz8nbSrwbTUkW+Ntziq2dWVOUKu2EJFwQLOx9lP4RdzCqf/+RSthrs+Mfn3+XWZqcC1sDZDPUXW/5wOX7fEfJ6DO0ZrVy4C+n8Tu4acuJyaf7dAs8EHKksoWPbVsT3MVxe8BTJWwacd45SCn4KF7irPFfL9/a2XJYL8i0i9F3KfUTQraO34k6gQdVe+Zh7gcZ4Tfr2mMivhZ85JtmNptR87l2HmrndvtweAlhvU6dolkxRx32DeEirAMLg7ASCsZs+4BXbLD5wbL/uav9cpJmRjpToSam17HF1IVWqs+z15/xOexnv7hgTlDLHinADervsTOxdEu2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 26 Sep
 2023 21:47:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 21:47:04 +0000
Date:   Tue, 26 Sep 2023 14:47:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <Terry.Bowman@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v10 12/15] cxl/pci: Disable root port interrupts in RCH
 mode
Message-ID: <6513515526995_bf9129471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831170248.185078-1-terry.bowman@amd.com>
 <20230831170248.185078-5-terry.bowman@amd.com>
 <6504a5e23cee9_d7cc8294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <f27f685c-6b53-8955-735f-e9c0c04354a5@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f27f685c-6b53-8955-735f-e9c0c04354a5@amd.com>
X-ClientProxiedBy: MW4PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:303:b4::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bac2512-146e-4415-cb49-08dbbeda1f44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6Yegh6KCi//SQ6CIljHkmX7qFgtRzmeoZGbr0OyDk2hygTpSAzGlfkA2In3ZrS5HeaySCN4iqwzSXpTzKws2QYio2/6I1CdvSsYuo8Y6qSYlS2auBbIZSuWzgyODA5gv+n8AmJhFvnG7E+6YrDBB1KdStstiJu3DKEPZJcxj0gvy2z9gyzyKa6lhlXiqEZAxDHv4pHED0leyvR8wh1XKigWTt5Ysz9NPHnKoZbBFM58kb/C9mJijmj+X+GoXn+hTBx03P6f7CsHtiTnyvYfpssmzq+Z70i3eusNsYeYmaI/SooRO5YKztuXIbwfq7UjIh+oy1eWSaDaHNq+aGoh4AvFmtUj+q+4eXGk40ta35Nln5OX+vXtPLezl7v3rLdIFSPdvnAFIt4Mjh3lKoRL0FltT+6g/0PLCzYG/9CCslsuW+l3nf2/HVuFaAXBD/v7AY49zvAVY4P08ToFIIl6YsRxdeAb2FaBsKXCxsIsYNDZZ7JLqcv5qR3snBCJiFbPkwhKrM2IDE7xzbgAO8nRwkAhNlnCpBcFF1TZAvyMnkFHabPx3Wx4hAjqukPfA4KJg+XBLExpc7XFU08fJWaNfQsConA2Rn3Uufe6KHmqW7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(53546011)(6506007)(6512007)(9686003)(6486002)(38100700002)(6666004)(86362001)(82960400001)(83380400001)(26005)(66476007)(2906002)(8936002)(8676002)(316002)(41300700001)(4326008)(66556008)(66946007)(478600001)(110136005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EARsAhRax+yIU/ePGZlR0/kBSCkJLjrqm9UHVf/3tc866HbjxwzReJiTxvOt?=
 =?us-ascii?Q?mlIJ2C6zyejSToioai1A9twaurdPvblZVAQpATgiP7GRv6Ys5pUHMQJiO7XK?=
 =?us-ascii?Q?UDfOideh1Kd1bNqX8qjna5k3kTlGEQDmr4/EhCLVCmwV/gmtILiXFweOo2oQ?=
 =?us-ascii?Q?bam4MICCXGLvYHUzHvvFtfSWnMUMPTMdBSdPOt9vuu5wX0Oi4DIcG2WL53Tv?=
 =?us-ascii?Q?54X/K0C/E0TXnzSQe0tBawhQFDS7Hv5Co2bIWpY89nvotMkGlCWRyzJcBW7L?=
 =?us-ascii?Q?QCnS/3M2Y55J0I75OLiQI7rO2RSQBIDRMS3RIbM4yOtKwNlu5xTgqX2aX8c2?=
 =?us-ascii?Q?989KfX9pNBcKLkZl6c/8drgNnKoJBU1pedL7i6PlFQo77eI+Iot81VuzBLNE?=
 =?us-ascii?Q?JSpfIWG7mkyUWOtgPVEAuZ8f56nWIZHx5bipsznbYW9O3OAc6lAbjl6VUGRA?=
 =?us-ascii?Q?VTypJWys5o+0vlLza2M2Du8xvVJhDCEdc1B2uDfzHZrdORMP5C7qFyPPTLDd?=
 =?us-ascii?Q?fLAFjbK9TqkTdWs+PfpxzcIAUHeTrR5uyS4JW4A0tya5jiBb50NN1ZxvQMe/?=
 =?us-ascii?Q?RyqgENGJ8exrenYLqQL9B6bPbZd3WgKUL0rQvURn7fycXYBkAG5+1WbzI3KN?=
 =?us-ascii?Q?l3eZNeKZoFhRNy4dps7HorS7/MLM1jXUErcOHbttz/wT1M6WL9VtCjwRtttj?=
 =?us-ascii?Q?rdWXDlzU3cQExUcrOTq4bmxKdwPOhpWgO4aCV4G6r1yabflE26DGafdyCTpU?=
 =?us-ascii?Q?k4fzL6BSg0cdwdvzBun/ckxDA2H2GLHQ0RIMhYDhAXF4dWRE2utw01uzDRrM?=
 =?us-ascii?Q?nO9g6xWF4uJD+uTUNOFe+nqgmNAzVe3fQo6IULr6r1GAYc5jIaZya5NcjwOP?=
 =?us-ascii?Q?gZ3dU3WwA9uQ9PfAEUOO0hiJI/N9gyF2Zy4Oc8tueOsHUoaPkG9Ww9j8W3+U?=
 =?us-ascii?Q?wIgsMg4hIRBpHGfgdklGGQf5c4NAignxSdshbXSUhbQW9bY6nqo+YxWo9Vx0?=
 =?us-ascii?Q?FF3mNkWrznzXm4pV0163lzbLNYXhh6Y49qr6a5sWKoADWjilxiy7bZYJvqIB?=
 =?us-ascii?Q?pkRjBm/jGBvj8R2jvom0mFLo3qrGlRinzU/hINm0Ol3DrHliKy9SMVueSMHd?=
 =?us-ascii?Q?eg6/KbGKXFf1mFx9LDg7fA+rzOZIrufQDsbN2MYoUFRMQ4x0qM3IIc33N0Nw?=
 =?us-ascii?Q?4StATULXNWtfSOS4C94WnGvfQnLSd1ZM6XKn28nbHzdo23lnnxbsYUYYWCKn?=
 =?us-ascii?Q?HG50Rcu+y6Dl9JQdlsjaN7zjCNC/78zUnvws8LdS5iliIvxU6x+NyZIvGIkZ?=
 =?us-ascii?Q?5uUz7Zg8P0hsJxkTU6bzcnEcOq9xlzNtK2BnyyHxOn9NaG6tb6uLUDF4WqiK?=
 =?us-ascii?Q?kgaLH05Zh9L3i6ES727FYLdD2EHJfAt8kgZqKKhf6jPwguFTD6VDXgplyxe8?=
 =?us-ascii?Q?y3n0nIg4EjVZ4vPQCbIRbj0dIl5KfssNF3yi6q36kT36kLh84hFjuMpRPBb0?=
 =?us-ascii?Q?/c0N3lgxvhv0UgqzShAUe2u/deCDra9cL2q6X+VlOtfpEHNaCowFADKy3/kX?=
 =?us-ascii?Q?UgvgX+zYbKFYuz+7KyLon9D4CYvTVCzshlaTjtotRBk+8IbN5kly+wZxkabT?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac2512-146e-4415-cb49-08dbbeda1f44
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:47:04.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+STk7BoOwwOQOYiSO81HDcBkPOcuWmJUtgjJVSN+Z92TbmBWvBg9VpoDIPKW77V5YchwnUUNwuo8mFT8VpvF14xYn+FoX2V/zPgl4OYAaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
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
> Hi Dan,
> 
> I added comments below.
> 
> On 9/15/23 13:43, Dan Williams wrote:
> > Terry Bowman wrote:
> >> The RCH root port contains root command AER registers that should not be
> >> enabled.[1] Disable these to prevent root port interrupts.
> >>
> >> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> Signed-off-by: Robert Richter <rrichter@amd.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > [..]
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 2a22a7ed4704..d195af72ed65 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -1042,6 +1042,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> >>  
> >>  	cxl_dport_map_regs(dport);
> >>  
> >> +	if (dport->rch)
> >> +		cxl_disable_rch_root_ints(dport);
> >> +
> > 
> > Similar to the comment about cxl_dport_map_regs() not being appropriate
> > in an enumeration routine, this also needs to move out of _add_dport. It
> > occurs to me that it should also be undone on driver detach just like
> > other device "enables".
> 
> Ok. I will move out of enumeration. 
> 
> Per the 'undo' request: This is a RCH downstream port (dport) with PCIe root port 
> capability. PCI spec states root port error reporting is disabled by default at 
> powerup. And SW does *not* enable the root port errors because the RCH dport is *not* 
> bound to a root port driver (missing BDF, etc). This mask is added to follow the 
> CXL spec precisely and if the rest of the system behaves as expected should not 
> be necessary. 

Ah, got it perhaps add a comment to sanity check that the hardware is in
the per-spec state. Are you certain that even in firmware-first error
handling it is safe for the driver to unconditionally disable these
interrupts?

> I don't believe masking should be 'undone' in driver detach or elsewhere. Adding 
> the 'undo' masking would potentially introduce RCH dport root port interrupt 
> reporting which is incorrect for the RCH/RCD mode. Only CXL components (device, 
> uport, switch) may reside under the RCH dport and never want RCH dport reporting 
> root port errors. RCEC reports the root complex errors in RCH/RCD mode.

Ok, that also seems to suggest that even in the firmware-first case the
driver should make sure they are off per-spec.
