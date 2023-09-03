Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BF790F39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 01:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349753AbjICXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjICXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 19:36:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79216C0;
        Sun,  3 Sep 2023 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693784190; x=1725320190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m4Q8b7uY5d/CHZ0G4A3ZU1b0n4MNJfNsydggkirzrDA=;
  b=QGGfhZqkvjeEkXb/O7jtfTTXIJOL9mDEuXskf0fV6+jwjVDpnmVcllx8
   kZ/6gA1u8APAki1FiH94SOOdD4j9c666pQl5+LDOF+z3AzujkRbs7g5fw
   RgrJc4QeqPX44Fvw6DrCtkqBP8AALq5CH2RuVeefdHeKC3zdKYYAyhmu4
   bW79UocEARSZ7xcTpsT4903KSTHqPJkb2IRITQ9OMKTIWDxADLfb36Zx2
   iq8h0iZsp8EZqWhKSWWnDCByuolnNVhrnuObHrYjH4ELRz1KhRbllpKaN
   JGNPAu23a0CQ1AU6udWbEq3juRkpiH5QubP8AlTfqTChUQl77CdZMlYFB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380279412"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380279412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 16:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="864149932"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="864149932"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 16:36:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 16:36:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 16:36:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 16:36:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 16:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1vsD6+Q2+e3sg495fXakEDA/w7c2d3HBVEM9TzJSHblHcr4E8RbldTuMI6EAoZDv/JqKMhLtStLy+wDmxoVFCfXMKlK8Gz98eKzzmdsrmNdhjS7rhkBD0QcEPAGprqVAH3/vy42NCn9uNURr/LlwkiCzaP679QQy1X2DWPkroCsWoNVdBrU23qdhNncYidd3oZtD7S2lJBba2HbPZizMNSu+7f97nPH3rWrEixDUsYxLlG6VoP9N75LTc5GaQ4pnbd2bIH9rwP17ujTOM+6k42WZeM79eoscBHiGPAPhaenvjB0cDN4l2n3sj54UyGuTqyhETxbZvSSHvUOyCzVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0sF2bh3pCaJqCv8QjRA6ICMMeZQy5/5wlCkjcbOURU=;
 b=AE8AXhuOq+v5NBfcys7B6D24onVZBvugiPFovJr2BVSpBag8N2D0Jgx592yJaikLL/zRQot95E50Rf7Eh0Y+zuhTYGtTs0dPNhv9MmFlD3iUVnLrAGwe1lNQjUG81JKM+Iu/B0JNbD+8vVgF3WnzEOgJH3CPDVZjP5IjxMA36Ksl33yJ1Ysa3akuSEDICbsQBzENIIzrRCVnEAGKYlBJJow5vAL2g2aOyezzO8x3PP6BaGAi95hQ2Dp62KcPoISFwQZHNf7z1+eAyFVTK9ecmlUPr3z082VBhjx7WTCJYpFUZ5chGs+ad1n4POIaHld6cWG6mx5vywxnRz4rKDZOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 23:36:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 23:36:21 +0000
Date:   Sun, 3 Sep 2023 16:36:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <64f51871e49f6_1e8e78294a6@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <20230829153714.00000a4c@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829153714.00000a4c@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0175.namprd05.prod.outlook.com
 (2603:10b6:a03:339::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 08db49c0-2b4d-442a-b1e2-08dbacd69412
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rICmZEvMIIlbKojzX2Uv+/fIsgKuAwSBjogknv7QgMvrtbN7wGC4U+MWtk5zxfq4N6wLlpwwgAp/Ccp8Vdy0yVO5UAWAAyPI3OevkisNxPfZHYVZ+N8lRm8PA89FACgGMmP6yNHZFU70eBRJ4Sa9FyT5S7iFeTMMbgz/+gcMuY0PHc7OWZKEuM4vpInGC4gegY3i6VPVfq7tZ2gOWQJ3Mz1bSQtXUp6ea8Y2C9VDK2oC7ARIq5afnYVZD3TwZ+2cIA3ikKrrYq2LQ35OhaKWexsD7IqWEg43d86YFM3y+Vx05q1UA7/TfBioGKSTQ6nUelKmFCZbcLXmMSFN+/3hd5DAPKmkJwBq9DN9PNUyvWl3oqrZDbMjL3MxWEYcdOCujlo0E0qSZfNcpRKZu4YpWo/yD2SNcSx3GhudT5TYasba9hzetaxk19p3JDEPXMnAHHjnKdOLhW0rRCpnTN7bqvhWpk1mtp9CwDlXeixBffeAkXkC+hSCRm+Xsyj0LJrVEmGIwWKQE0dWABgoU05vXlQuXAYEo6TvGOS3D84FBbuMBB2pH/t4mXdAMmjYvWN9y8aJ+EIjArPfHjg3nE/1vh+FwmylRtfdZY6VCp2WZn5caK1DBXsYvaYWluob7yy9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(1800799009)(451199024)(186009)(8936002)(8676002)(5660300002)(316002)(66476007)(54906003)(2906002)(66556008)(30864003)(66946007)(4326008)(44832011)(41300700001)(6506007)(6486002)(26005)(9686003)(6512007)(38100700002)(82960400001)(6666004)(478600001)(83380400001)(86362001)(461764006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMy4mIHuczlj3JhZZaCOWlLafsf+wrt31Vp4No2HBLcQYAkwlt1CCXMbLdny?=
 =?us-ascii?Q?cbS6GYJeJumwGbacSzBMdFiJV4nrmdo6OLv8rg02xKr3K/U8f5uBv6TQ9P3y?=
 =?us-ascii?Q?wAOsqHIJpA4uT1PKb/HUkIpdfQ11Sh7qlVjY92fFXPvisubBicL7bwOdAS/e?=
 =?us-ascii?Q?LtbJ2/WuAv8BWDA1weGo+htSP8BH2dkBDDi+FzhFVMTPetjz4s9VHrffgrzE?=
 =?us-ascii?Q?dLq/LJlyrzEk+yilJmlEDZut8cvEu135g2EpUfzhRAHO4q/BLSLrX0oGDflP?=
 =?us-ascii?Q?ICqSgJ5RPnhBGXGP9F2DuDQPZvMvf5vipTw0CFEieuGbt4MjSeM/qoNhn9JA?=
 =?us-ascii?Q?Ew5ekN7nuDvEjE4/ktob9VaJhk8nAdmeoSNmST1E0/bCbc8p4G6iO2eFeElM?=
 =?us-ascii?Q?02MhMZM+3iTqeOVM7s551kLgOC6fINLcQxYkT/xsrVUZe1L3wbpwgLQ+PCvg?=
 =?us-ascii?Q?kh0D/m806EdRMwVTAzyF/uY7PiN72YPvW4yiR9y7wASWoq00Aow6r93orPuV?=
 =?us-ascii?Q?QpSJTMfq2BbVjAZuq8TmmPaBjNz3bwUe+YUtgBZdDi7cxoPzOj5DKha7n0dJ?=
 =?us-ascii?Q?DhBcxFdqshCcqx4N9iU1ZF8OUtqOxKUuzMQ0JCa0/uBKa+lIeS9WT28MUayH?=
 =?us-ascii?Q?QnO73zcZ3vkGI+7byi6O++SgCRZMNEocLgmFNHOBPJRctRdUUh6CHs+h/EaO?=
 =?us-ascii?Q?B5gJCq5V6g3YH6FdP8tvEviPNfQ5PXUW2kmx5ZJtS14TMIFid/5D0YTHBQr3?=
 =?us-ascii?Q?qAbJdMiPj1BDcnfAjn+XBWg5Ff7z3WY+uDUwYapqgFEOIAht33OFqf6pModw?=
 =?us-ascii?Q?MrvriMgAUHa5xbgFCit0gFuYU5WGB2xn0gLMh5uGZSblGJMvCV0npHdGIfQP?=
 =?us-ascii?Q?MqfonDdPJ93CzGmjvXqg/xKYByhvC4qIsOf56XAramR/hUAnGLNwRRvzJYIk?=
 =?us-ascii?Q?oowFQc0tSNJdLVgpXsAMeNcBCMeWypnaZyUPJt1r1pkVCCNDYx4XNP2Pg620?=
 =?us-ascii?Q?fW9DkvT040+dF2l3eB1udtXw1th9V5Hui1yyNpnxNPhMOrTvUdFBVayM6Opm?=
 =?us-ascii?Q?3ic4sfMGYY2QSVphnByWUqoAaeh3FoXtYPknvufnGuqOTAryg+NDUX7G/FoO?=
 =?us-ascii?Q?KHrQvslQoOAoZnWpbULA56gbRX3wTGT0pku6uz7ncIdGf3gMuXpBpivX+U3e?=
 =?us-ascii?Q?Bkyjyj1j5vagTlAIsKeTzVSO1JLqtFLShC4LaGSy6St4yJx4sxc6q5pOk4UB?=
 =?us-ascii?Q?Hij0InLLheL7fue0HGlwrXKSLCIc4YCeJ5/IXCMl9UhRH4kPuIkHOzBuZHck?=
 =?us-ascii?Q?RKY5OYlI2BemuP/4f3ziIccdYocVtlRqJNybmIWxgIBuO6QcbpXADr7c2+4c?=
 =?us-ascii?Q?aQpxy4TyLOi2tMQBYySo32rEe6W3q9kLpXE/UrvezjG+OFXcqu8Ure8+fkyN?=
 =?us-ascii?Q?LlhEfwHF5BXl8UU/MEDMJ5501lJ9N5l/jSih6p89vy9xPLrxphPtz/IAbsWb?=
 =?us-ascii?Q?HQh+IM0pbGRb1a4fML+6nAzx1uv+Dc3lNU+/wOpqV9dUw9Pn24dK0JG5U+ge?=
 =?us-ascii?Q?Z+5uSPZ9SaE2BZnKUenSBx5vkudCFDK6rxCrhU/j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08db49c0-2b4d-442a-b1e2-08dbacd69412
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 23:36:21.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tby/FSw82xQwwadEQLT/rZBjCnbpVDMkwu9YUrsMiH7EswD/9dCvbGO7o2gh/oVtiBePhOV10t1IJffzJA1M4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:54 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Devices can optionally support Dynamic Capacity (DC).  These devices are
> > known as Dynamic Capacity Devices (DCD).
> > 
> > Implement the DC (opcode 48XXh) mailbox commands as specified in CXL 3.0
> > section 8.2.9.8.9.  Read the DC configuration and store the DC region
> > information in the device state.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Hi.
> 
> A few minor things inline.  Otherwise, I wonder if it's worth separating
> the mode of the region from that of the endpoint decoder in a precusor patch.
> That's a large part of this one and not really related to the mbox command stuff.

I've taken some time looking through my backup branches because I thought
this was a separate patch.  I'm feeling like this was a rebase error where
some of the next patch got merged here accidentally.  I agree it seems a
good idea to have it separate but I can't confirm at this point if it was
originally.

Split done.

[snip]

> > +
> > +	rc = dc_resp->avail_region_count - start_region;
> > +
> > +	/*
> > +	 * The number of regions in the payload may have been truncated due to
> > +	 * payload_size limits; if so adjust the count in this query.
> 
> Not adjusting the query.  "if so adjust the returned count to match."

Yep done!

> 
> > +	 */
> > +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> > +		rc = CXL_REGIONS_RETURNED(mbox_cmd.size_out);
> > +
> > +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count);
> > +
> > +	return rc;
> > +}
> > +
> > +/**
> > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > + *					 information from the device.
> > + * @mds: The memory device state
> > + *
> > + * This will dispatch the get_dynamic_capacity command to the device
> > + * and on success populate structures to be exported to sysfs.
> 
> I'd skip the 'exported to sysfs' as I'd guess this will have other uses
> (maybe) in the longer term.
> 
> and on success populate state structures for later use.

Yea that was poorly worded.  Changed to:

	Read Dynamic Capacity information from the device and populate the
	state structures for later use.

> 
> > + *
> > + * Return: 0 if identify was executed successfully, -ERRNO on error.
> > + */
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > +{
> > +	struct cxl_mbox_dynamic_capacity *dc_resp;
> > +	struct device *dev = mds->cxlds.dev;
> > +	size_t dc_resp_size = mds->payload_size;
> > +	u8 start_region;
> > +	int i, rc = 0;
> > +
> > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> > +
> > +	/* Check GET_DC_CONFIG is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> > +		return 0;
> > +	}
> > +
> > +	dc_resp = kvmalloc(dc_resp_size, GFP_KERNEL);                         
> > +	if (!dc_resp)                                                                
> > +		return -ENOMEM;                                                 
> > +
> > +	start_region = 0;
> > +	do {
> > +		int j;
> > +
> > +		rc = cxl_get_dc_id(mds, start_region, dc_resp, dc_resp_size);
> 
> I'd spell out identify.
> Initially I thought this was getting an index.

Actually this is getting the DC configuration.  So I'm changing it to.

cxl_get_dc_config()

> 
> 
> > +		if (rc < 0)
> > +			goto free_resp;
> > +
> > +		mds->nr_dc_region += rc;
> > +
> > +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > +				mds->nr_dc_region);
> > +			rc = -EINVAL;
> > +			goto free_resp;
> > +		}
> > +
> > +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
> > +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> > +			if (rc)
> > +				goto free_resp;
> > +		}
> > +
> > +		start_region = mds->nr_dc_region;
> > +
> > +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> > +
> > +	mds->dynamic_cap =
> > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > +		mds->dc_region[0].base;
> > +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> > +
> > +free_resp:
> > +	kfree(dc_resp);
> 
> Maybe a first use for __free in cxl?
> 
> See include/linux/cleanup.h
> Would enable returns rather than goto and label.
> 

Good idea.  Done.

> 
> 
> > +	if (rc)
> > +		dev_err(dev, "Failed to get DC info: %d\n", rc);
> 
> I'd prefer to see more specific debug in the few paths that don't already
> print it above.

With the use of __free it kind of went the same way.

Done.

> 
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > +
> >  static int add_dpa_res(struct device *dev, struct resource *parent,
> >  		       struct resource *res, resource_size_t start,
> >  		       resource_size_t size, const char *type)
> > @@ -1208,8 +1369,12 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  {
> >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> >  	struct device *dev = cxlds->dev;
> > +	size_t untenanted_mem;
> >  	int rc;
> >  
> > +	untenanted_mem = mds->dc_region[0].base - mds->static_cap;
> > +	mds->total_bytes = mds->static_cap + untenanted_mem + mds->dynamic_cap;
> > +
> >  	if (!cxlds->media_ready) {
> >  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> >  		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> > @@ -1217,8 +1382,16 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  		return 0;
> >  	}
> >  
> > -	cxlds->dpa_res =
> > -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> > +	cxlds->dpa_res = (struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> 
> Beat back that auto-formater! Or just run it once and fix everything before
> doing anything new.

Will do.

[snip]

> >  
> > @@ -2234,7 +2247,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
> >   * devm_cxl_add_region - Adds a region to a decoder
> >   * @cxlrd: root decoder
> >   * @id: memregion id to create, or memregion_free() on failure
> > - * @mode: mode for the endpoint decoders of this region
> > + * @mode: mode of this region
> >   * @type: select whether this is an expander or accelerator (type-2 or type-3)
> >   *
> >   * This is the second step of region initialization. Regions exist within an
> > @@ -2245,7 +2258,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
> >   */
> >  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> >  					      int id,
> > -					      enum cxl_decoder_mode mode,
> > +					      enum cxl_region_mode mode,
> >  					      enum cxl_decoder_type type)
> >  {
> >  	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> > @@ -2254,11 +2267,12 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> >  	int rc;
> >  
> >  	switch (mode) {
> > -	case CXL_DECODER_RAM:
> > -	case CXL_DECODER_PMEM:
> > +	case CXL_REGION_RAM:
> > +	case CXL_REGION_PMEM:
> >  		break;
> >  	default:
> > -		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> 
> Arguably should have been moved to the cxl_decoder_mode_name() in patch 1
> before being changed to cxl_region_mode_name() when the two are separated in this
> patch.  You could just add a note to patch 1 to say 'other instances will be
> covered by refactors shortly'. 

Ah well I've already split that out and sent it.  I was hoping little
things like that could land quickly and we could get to the larger patches
in this series.  For now I'm going to leave it (But split out as part of
the region mode patch).

[snip]

> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index cd4a9ffdacc7..ed282dcd5cf5 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -374,6 +374,28 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
> >  	return "mixed";
> >  }
> >  
> > +enum cxl_region_mode {
> > +	CXL_REGION_NONE,
> > +	CXL_REGION_RAM,
> > +	CXL_REGION_PMEM,
> > +	CXL_REGION_MIXED,
> > +	CXL_REGION_DEAD,
> > +};
> 
> It feels to me like you could have yanked the introduction and use of cxl_region_mode
> out as a trivial precursor patch with a note saying the separation will be needed
> shortly and why it will be needed.

Yep done.  Like I said I think I had this split out at some point ...
It's immaterial now.

[snip]

> >  
> > +#define CXL_DC_REGION_STRLEN 7
> > +struct cxl_dc_region_info {
> > +	u64 base;
> > +	u64 decode_len;
> > +	u64 len;
> > +	u64 blk_size;
> > +	u32 dsmad_handle;
> > +	u8 flags;
> > +	u8 name[CXL_DC_REGION_STRLEN];
> > +};
> > +
> >  /**
> >   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> >   *
> > @@ -449,6 +464,8 @@ struct cxl_dev_state {
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> >   * @total_bytes: sum of all possible capacities
> > + * @static_cap: Sum of RAM and PMEM capacities
> 
> Sum of static RAM and PMEM capacities
> 
> Dynamic cap may well be RAM or PMEM!

Indeed!  Done.

[snip]

> >  
> >  /*
> > @@ -741,9 +771,31 @@ struct cxl_mbox_set_partition_info {
> >  	__le64 volatile_capacity;
> >  	u8 flags;
> >  } __packed;
> > -
> 
> ?

I just missed it when self reviewing.  Fixed.

> 
> >  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> >  
> > +struct cxl_mbox_get_dc_config {
> > +	u8 region_count;
> > +	u8 start_region_index;
> > +} __packed;
> > +
> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_dynamic_capacity {
> 
> Can we rename to make it more clear which payload this is?

Sure.

> 
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> > +#define CXL_REGIONS_RETURNED(size_out) \
> > +	((size_out - 8) / sizeof(struct cxl_dc_region_config))
> > +
> >  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> >  struct cxl_mbox_set_timestamp_in {
> >  	__le64 timestamp;
> > @@ -867,6 +919,7 @@ enum {
> >  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> >  			  struct cxl_mbox_cmd *cmd);
> >  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
> >  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> >  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> >  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> 
> ta

ta?

Ira
