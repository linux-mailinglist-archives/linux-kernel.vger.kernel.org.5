Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE3793120
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjIEVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbjIEVnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:43:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F416CEA;
        Tue,  5 Sep 2023 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693950185; x=1725486185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KoYZbbY5D8/eTzliWOMmIAXkXXl+PXE3mcrXCjQyE/0=;
  b=H64nKdxzkWhX/OSThWz4kbjPQ0gfwCkqBpWQ6q77HdYNSksjl89aBd8Z
   tsEPIe3S4/JgpG4xdlrrk5m8z5rOlOX8oDuafAs7hVwPO3qqvnZz5ekHh
   tBoTNnyK4HtQjB/bBPjk760x+bIX9X/WJkmcm/YYI/r5YrD7vSd3F93Ik
   PhX5gJeBaj4Sgw2s+LeWEbYiRreuGsMpqFX/5AgT2v79kJZsY3wDnCHc0
   vwFjlHrZZ8OS7qbuy2vRJuIsajK+GkJypfzB+EG4ZDaFlkBoqpHCF0QAT
   8uN+cM8jYfgFk/qhaD0iZ53XO1iEc22pRrMd3CD1QSLbAo/MTHf9wkSa0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376827966"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="376827966"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="770489430"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="770489430"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 14:41:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 14:41:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 14:41:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 14:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz5clSfiQNu6g4OXr4gSppOnD+l6Mj1O+JvQ4QD32Ifm+v0AjpCXH3vXUSG4ome9moBNy85sLBAXyQRYRIn0jfSX88g178x4vmKZc1MMJsdjUD3Zy1enPmIokNCktp+mEBlkUVOanhoX2ylfzh31zqLXgvc3i36txH1l4VSNXy/6GNqzAz1EWR2WikqgHx411mds4O9urSm4+bkgJt2/7ccCvsD8EkNWantjY40Y4vJjRl7odevkk0FgMMha1H6KxEPUK7PPP/cOaRIjTIfCyr2wVBFH4rzyMH/lo3gZwNKg0x2gE6RjDQQmFrjOTgljsknHDCWKaYOtFIkXsgnhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX+h0qQ0QgcUXitSrOWz330Nl1GJkS5jrNolJXveXJg=;
 b=k8CkUHIGnTWZetaaA6QuQZ4iV+8H0QP859t1r+SSUnvG/Y6ZxwZJWwYxcVTAZNAHkMycKRqGObsxHZnZ0P6LPjohBfM2wp2DqgsorImD63EYpCef3EFYuYgTccwIGS811m7jKXIZ4I66QaUo4vJO0A4O5ZOB8oq2QzTKmY+k8bcMYSTlC5Z6D83wQdRtzd8Q4gjlxHg8uCw10QemOi/N5so0K2IV7V+nRZLqB+xdmZP1aZxyB0MGnrlbAuVJ9MsyIUCwstgoPZd2/Uzwz6y23Z4o7Isbgrhum2Mf+TgGCBJK63a1s024qvcd/RllKyUh7c6gufILTDmMjOT+fzU26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:41:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:41:15 +0000
Date:   Tue, 5 Sep 2023 14:41:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 09/18] cxl/mem: Read extents on memory device
 discovery
Message-ID: <64f7a078298ec_1e8e7829471@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-9-f740c47e7916@intel.com>
 <20230829162600.00004ac2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829162600.00004ac2@Huawei.com>
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1811146e-8d6b-4f71-2fa4-08dbae58d49f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKLq8sYuLVysrp6i1IRG1ikbyJqU8Yr9VuzGg/yQcfSG/+xMu1WiObH7E3uGo9QS+oLzSqN9kwSazXytTFmzrorEyfTxvcMB9/LUPXDI0RvrpBWaXX458wFZBYBU4XHwld1FBfSM/UXMmzsWCjmXVtcAdb//CuvYTSRBJyGH1IHQB9ox0UJfq16zVNy9bSq/U6PPxpl1m6+1koRpZP5ncdCLme1b8RHw1hIvuCv/qS38bl6lGi2MOjQtMEvbYwauvcSj2pP2q0gMbMXv2gyP5RuTF3hBPvEeFj6ElDKe2QO+3Igx533ttCLVheTk2NTjyjPqIwrn5YD83t56trmj0B6CMiYb194lf4Q2LVilHL5fmPqv8U112fLC0+yKmtynoKTK244q4S0XJSPQ4o7PAkuzgJLnbgcmmqdDcrd+Tc2kYz+TKuRxCP4jIptdHB94qw5UBaxitsI6C8sOf3qB8wtXZPin1jaU+w6gV4DWUx0Un+nyFKfsa5pdt1E6MjAFLXA/ocD/PP8UCsjikfO43tgwOGR/dv+jHQqDTVNfyb628Ew7rcVbpqsgHUKJIo58
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(6486002)(6512007)(9686003)(6666004)(6506007)(82960400001)(38100700002)(86362001)(2906002)(26005)(110136005)(478600001)(66946007)(5660300002)(8936002)(44832011)(4326008)(8676002)(66476007)(316002)(41300700001)(54906003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aX+hMQpOHcIEDJF7TLBKO/FYKkxCaKJyMKJd+KFmiqBYjTFYI54vR5wFeFs?=
 =?us-ascii?Q?dbt0E4VpbnnJ+V0tq5WhHjRnmOxZqHoqpB8kYnBn5OrdEncn6Ln17RNaHXug?=
 =?us-ascii?Q?8bLx+EjK5KUTv4/6OIeUchGsYKnUE6aYWI34si7TZ9m6rl7Ae+081kV0kT8N?=
 =?us-ascii?Q?b9wDu2RYqe0rXP7P0yszznXCgqdEIsAorvwg4ZcptCtU3ZrfTibwYfywwkh8?=
 =?us-ascii?Q?UKPgybFIKXBDW6S9D/nzZcz77OX7wCVz2pxOMvMzZDqUlLLR89q4bTzkw7uu?=
 =?us-ascii?Q?GFvG2nCzFHsuvsq+OsBjlIBmajE7oMdvehhOJJc/teuEsp+zuFc4BWiqFr9B?=
 =?us-ascii?Q?skqpIGftHzAX3xrZtYjq9YMOHj/r1DYObiFdjJpB9L8SMtBKWit7Vw9LyX1e?=
 =?us-ascii?Q?a4xGnuOh4PpIyWSThuUC9ehTjpWj8mEU9YY2fwgfHNGPr4iJ+77o7gk4iZif?=
 =?us-ascii?Q?WHjFBniCqkBgAVErY2wdt2a8pH0y2/vMLg45b3on8hKm67H8ygAV32gwiFuC?=
 =?us-ascii?Q?oPTJRyrr+MMHxzguCCexmHX1AmT2NG01iEJrJpQKJBuGF10S3uYHpK5PlBoN?=
 =?us-ascii?Q?S4XbffKG5+teU2dXM5jVAgwd2IZ+VMZLrqbqJq5S9+rMzDjSZxfAbeQt5xlV?=
 =?us-ascii?Q?nbjwT1FjKaWeB6cj/6oGOmvT2OGp+ETa2BNn2ywaU0vsbCymZdmGWCcZe48M?=
 =?us-ascii?Q?X/NjuysG1hSddGfBtn4aECmwZHReEH+MXbisWjdERy9NxtQ5l/h7xhXZJQi5?=
 =?us-ascii?Q?nFNEywF1aZmi3izAVzt07/30/5PTq5BKyRdI/2Q7BTeqFeHTdgrbU6TtT8sP?=
 =?us-ascii?Q?sTOUFc3uCinuX17H8Tpo4Te8ixb8On+n3Ud1/Bkr7cQkrw/4/OdNYy4hNUNZ?=
 =?us-ascii?Q?kHbJ61yO+W7/Z9btK3Wdgvchm82lb0ULwU4TZRMOcrtwc5LxwdlO3WCwISp5?=
 =?us-ascii?Q?Ldtre6DvXX7qadFDJxNPGPJBTrEuK/fAw0Iv1nbLgp9OaaJRPUPKKHuXqbCU?=
 =?us-ascii?Q?HXn0ZlItrPhb0uxi5qbgYZ3fapLoH+tilWNQszZJl3apR393vSqHUtG9I0Mk?=
 =?us-ascii?Q?r5DilEH75Q4UrVUWpknpPZ7cMxiswPtkqLTg7iT9s0iMREQl+VDNstNjD4d7?=
 =?us-ascii?Q?M3PvZGUX4oCwZ2zpxfXEu1O7l1tERCsf/pb2Tqn3zqT/ZvlVYnaizMH/zviB?=
 =?us-ascii?Q?036I2KqFieP9XZVHNNPODa07UukUftRxZ6ZZawLmh9WgT7s1eJ5ML156Uk81?=
 =?us-ascii?Q?wVxJH/xoa8Rw6gMJH+E0EVQKuWfUHXwnL9ZzMlrih8aZwpqK3O0qGeOWLfAL?=
 =?us-ascii?Q?YtyEob4eOHUxxyZj/IT965T0GNpjCaieTIbKg+yidO4vDf5AAHvwXsAEpH6z?=
 =?us-ascii?Q?1kpxsnzLNKXjZ3/qY5bczrU0nm8CDWg7fJ2AlAflF8DKkHxXWS5wU4S8ILHe?=
 =?us-ascii?Q?Cg6lH2+YUWE5mvksf5GEKTZwf1FsMoK84EU0t8tr0UKxIRTQVSL78ibXwXRc?=
 =?us-ascii?Q?yMpGIpOoVPEwXAAuLO3nn2JsNSQM7jX8uJVZcdX6L8mzF4Jk4vNO5ZVRs6wl?=
 =?us-ascii?Q?CbMeu37ipRUZod4/s/8GtrVOcdLFL2o562S71z6s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1811146e-8d6b-4f71-2fa4-08dbae58d49f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:41:15.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhXszqwxXJitM6B/FmCGCvgcVF0LE5KKsXhu7DO/roYvhu7lYKTYv/pjJr2w06iooIN8E/BDQmF2EBFipuMCcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:00 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > When a Dynamic Capacity Device (DCD) is realized some extents may
> > already be available within the DC Regions.  This can happen if the host
> > has accepted extents and been rebooted or any other time the host driver
> > software has become out of sync with the device hardware.
> > 
> > Read the available extents during probe and store them for later
> > use.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> A few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 

[snip]

> 
> > +static int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +				     unsigned int *extent_gen_num)
> > +{
> > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > +	struct cxl_mbox_dc_extents dc_extents;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	unsigned int count;
> > +	int rc;
> > +
> > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > +		return 0;
> > +	}
> > +
> > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > +		.extent_cnt = cpu_to_le32(0),
> > +		.start_extent_index = cpu_to_le32(0),
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +		.payload_in = &get_dc_extent,
> > +		.size_in = sizeof(get_dc_extent),
> > +		.size_out = mds->payload_size,
> 
> If all you are after is the count, then size_out can be a lot smaller than that
> I think as we know it can't return any extents.

Done.

> 
> > +		.payload_out = &dc_extents,
> > +		.min_out = 1,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> > +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> > +
> > +	return count;
> > +}
> > +
> > +static int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> > +				  unsigned int start_gen_num,
> > +				  unsigned int exp_cnt)
> > +{
> > +	struct cxl_mbox_dc_extents *dc_extents;
> > +	unsigned int start_index, total_read;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int retry = 3;
> 
> Why 3?

Removed.

> 
> > +	int rc;
> > +
> > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > +		return 0;
> > +	}
> > +
> > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> 
> Maybe __free magic would simplify this enough to be useful.

Yes.  I'd not wrapped my head around the __free magic until you mentioned in
in the other patch.  It is pretty easy to use.  But I'm worried because it
seems 'too easy'...  ;-)

I'll convert this one too.  So far the other one seems good.  So dare I
say "I know what I'm doing now"...  :-D

> 
> > +	if (!dc_extents)
> > +		return -ENOMEM;
> > +
> > +reset:
> > +	total_read = 0;
> > +	start_index = 0;
> > +	do {
> > +		unsigned int nr_ext, total_extent_cnt, gen_num;
> > +		struct cxl_mbox_get_dc_extent get_dc_extent;
> > +
> > +		get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > +			.extent_cnt = exp_cnt - start_index,
> > +			.start_extent_index = start_index,
> > +		};
> > +		
> > +		mbox_cmd = (struct cxl_mbox_cmd) {
> > +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +			.payload_in = &get_dc_extent,
> > +			.size_in = sizeof(get_dc_extent),
> > +			.size_out = mds->payload_size,
> > +			.payload_out = dc_extents,
> > +			.min_out = 1,
> > +		};
> > +		
> > +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +		if (rc < 0)
> > +			goto out;
> > +		
> > +		nr_ext = le32_to_cpu(dc_extents->ret_extent_cnt);
> > +		total_read += nr_ext;
> > +		total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +		gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +
> > +		dev_dbg(dev, "Get extent list count:%d generation Num:%d\n",
> > +			total_extent_cnt, gen_num);
> > +
> > +		if (gen_num != start_gen_num || exp_cnt != total_extent_cnt) {
> > +			dev_err(dev, "Extent list changed while reading; %u != %u : %u != %u\n",
> > +				gen_num, start_gen_num, exp_cnt, total_extent_cnt);
> > +			if (retry--)
> > +				goto reset;
> > +			return -EIO;

And this was a bug too :-(  ...  Fixed with the __free() magic.

Thanks for the review,
Ira

> > +		}
> > +		
> > +		for (int i = 0; i < nr_ext ; i++) {
> > +			dev_dbg(dev, "Storing extent %d/%d\n",
> > +				start_index + i, exp_cnt);
> > +			rc = cxl_store_dc_extent(mds, &dc_extents->extent[i]);
> > +			if (rc)
> > +				goto out;
> > +		}
> > +
> > +		start_index += nr_ext;
> > +	} while (exp_cnt > total_read);
> > +
> > +out:
> > +	kvfree(dc_extents);
> > +	return rc;
> > +}
> 
> 


