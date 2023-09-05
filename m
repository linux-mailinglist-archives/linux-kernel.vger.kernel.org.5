Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518C791FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 02:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbjIEAGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 20:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIEAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:06:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7A1B4;
        Mon,  4 Sep 2023 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872374; x=1725408374;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=85yZgsLoQSgSzC3B+h9DrHitoPwVtb9Sa+bGVnaTL04=;
  b=KRHeFXv0rFq1uN4R93cvG0ESJlrOOaKLWcA3PqyoMNtk6xm2SGz1sn2O
   lJREL2a4dcMQkP3LT57lsfp3ZnclQlTDuSHVly9Ih+JToQRSsEo2XvAj8
   eiWYPZypmXJ9rpHOQuvKAZy+vBCtwVmqCi+2vHNA1gSDgFZymQj4vSlIo
   82JJIH7VheBQgNN30ELXOHRYYddnmNBJkDrAd6WYWqZ0666SUzhVm57wA
   SE+fo8o8/EoFnlZ9zFlzMCSIQ84kBE70sRrBMJF4z7+x1ylcUgfrt4VXn
   P9pibzt0Nr/ByM2JxUwIvf9RIPQOYouIurLbsa5UXFpPWav/4stfntTRQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="407658276"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="407658276"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806389309"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="806389309"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 17:06:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 17:06:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 17:06:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 17:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnmDeLAVXAml4xcYdOPAPrBw+bXlevI3xea6E+1c9LK17ywAfF+SvPEdYgfm+KusfhfZvXOrMeDue0iG37K2Mns1xWftHhjdRWQtEEs/lA0wL+K+pdNJ96xJaTzeGblmvJj6nA4hm18iCT/zkUPFroplmOhVlXlewTeFMWZFkTIo183rid5kQbhbYvffGQalSbuIZ2uBPiDslPiN2Oa3CSwEif53WT0NBlJ97x4n2VHCBJEC/GMMcVX6Tn9igx+seiw75kTHJkH7QVFEZjY7xMGz7HSFatbX8jHoRwOhjdlF62xa/N5Y4I+8Rsr6fS8CjZ/38Th+JywnJoaCtMd1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiYk/xvGxs5WaaXiUI9u2arIhd+eq6u15Z9SoWqa5F8=;
 b=ZWmK/A02AEA8/OJRJAfeasT5cF5VzRD3tzD3eWj74M9nuw4MSST50h8xM8q4/aGRLLxfXCd3Cr3EHvIeTqrQy0pxVXaZmYZKbh5um/yOsBcp4LklzoS4LXRcWIL6nIZHLtotabAE5nAahVmiOVnwdbrdhcuwsd0dBNUzYNGZpfNPzN60M3nbNfMBQwHJwbYeu8MbnwoXQPdCBUz36yTGAl5iWJ76fWPu0jx3QSRMRZv0evzXMx8eh8C4SIBqwH3HwuLKVslBxf7D98VmPK1Xq6lY/gIFNQbNjJmsE/p2R47Oa8IChIFDS88tztHcQOR9+fMwGD12xvJeApol681FsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 00:06:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 00:06:05 +0000
Date:   Mon, 4 Sep 2023 17:05:59 -0700
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
Subject: Re: [PATCH RFC v2 05/18] cxl/port: Add Dynamic Capacity mode support
 to endpoint decoders
Message-ID: <64f670e7d52e2_1e8e7829411@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
 <20230829154945.00002870@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829154945.00002870@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7895447c-89ec-48f8-2d46-08dbada3e5b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ8ijpsdCB2OAXAmLHD/FykUhSCtKdkmY7k5IsBSXcTnXn0s4A5e4tulaJRW8mEQFZCM2MrhJblKPnxQO2QI3+07obgDa0QlmBPdk4IleOteTNlCk2bIO9T3tnncU6DAM6kgYCOZcJFHF2nACxbNY9HpoiTiVctVfnWtEpKzI03T/753d8B5X+Uc3wwTH0UODqYRrqH3CZJ8GRNjLxVsd7qClKkALb7m1j1GovuMgNrjo5Si396cC7znaT5ygeQQTAifnq0uiq+bXIc0EZ66CtpXQptELt70wYeRUhzwMZNPKcHnj79irGUQPXGBOf+7gFS4Hw0TqvcPZ6E/OkZZ60QC9Kh2RsMOI6L5wT+kRLQVbh67/LrHKpyBGXWTUvJJ1cfZIuLIjVuOWsr68tKKR7lyJonB2tSoroosT9TGr+BSrxODoNAuq5EUymKT8de8m1zOygU7X7X/alBTkeQca1yk+re/nk14aSxGjyPIXUwkRSezHJVmh/JiqPdIWcEj4Dfu8HsM0jI4fqG6Cm6n8nvFjcNL0Pe7Go9fENkQQ5frZzlftWSS5QZVBHN8oDyN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(186009)(1800799009)(451199024)(41300700001)(66899024)(6666004)(6486002)(6506007)(478600001)(82960400001)(83380400001)(26005)(9686003)(6512007)(38100700002)(86362001)(66946007)(110136005)(2906002)(66476007)(316002)(54906003)(66556008)(5660300002)(8936002)(44832011)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVOnb3QxVSPLN6bwWDzS2UCgUQlo6sKVd2rGPFlrnsz9duaJ7LBL8mLnGwPp?=
 =?us-ascii?Q?ki43XT7CrxBF86aPDW0mner0Vu9DUSbKhoj8+YpOGp3CTg/3FgR8TjovLPe4?=
 =?us-ascii?Q?zF2xfSslShkOXxAnRVDKn8kwzd2XE0anaO7kxLTgNuHvbzFIgLEpRT3KjZni?=
 =?us-ascii?Q?FMAcpYBMU6a4V8cQaOtTnBbkM5wthc97b35B4+SB+2GcZVC8u3yUiqy69YNm?=
 =?us-ascii?Q?MzpWpK69a27K/P9Myy21Xe/5zzBg24Fi7mW33CLpVFL+f1iEHqaEaEfcRphZ?=
 =?us-ascii?Q?oHRPFUdF1e/ezZOQjCJnw485oMNNbcJ181h2+VRKPk6+OnwcKyotz6+LTG9J?=
 =?us-ascii?Q?k4exX3JMh54UtJB+/sP2KdmWj7urbOYacFhK6pr+kdZ4LqjlZuZ+bu8bzSlx?=
 =?us-ascii?Q?5WEdKoODotnxd4+FFpY0Der6UHqKTp6f0+/rQ2fAeiFhH0hqGN0I4dmF056a?=
 =?us-ascii?Q?ProkSfcEq2IK3WW9bXksb3iXLY7xVt1ebSBT6LR65/xaDceu9dOHC0GvSnab?=
 =?us-ascii?Q?T7a16X1b0cN1v+8VhGoLfKd8aWKvznyYRawAonvEwrKS5qiPhSIUk4MRH6VW?=
 =?us-ascii?Q?P+pDLyc4ctgSgdklulkkvla4vCR7h13SFpQgWbrU94bqK/+yjfNa7YnVRZ17?=
 =?us-ascii?Q?J0/YqJaNObC4Z/RgvZSe7RuQXcFsc+Hok/rCu/j9xPU63XIJ28bJv+6+V8SN?=
 =?us-ascii?Q?lHFxA6DDuHXgW2x5f8OzjXWVo/EgKoIj+Jxn4NvYIHJa+WUwhS3UgI/nQE9q?=
 =?us-ascii?Q?z71RZEklNeCSbhQU+wa/h9VqAus+sKLoXHVZ+R9d66BHeMKv9Ti9KhRqDGDx?=
 =?us-ascii?Q?OTjQo9EhKR1d+NZotOUOkIFt5hN9OoAvkohxl9kmJOkQzcfNLcUTeMqY0iTm?=
 =?us-ascii?Q?HgYvNEmh+BqKSadKqZhD3vM1A9Ttx2OekbLjNtzn79j/z/K7pQ+JozgAwqW4?=
 =?us-ascii?Q?CywVK9kTu8hN+eP6+S/6x0SxP/7Ab1kWJCDdcs+S5FZp/rjpw+TJWHFsWVYP?=
 =?us-ascii?Q?6daMxBVKQRDAFSPn4dd39W1+LfbWjvJQCk1jg45sk3TK8fKIVATqyB08037K?=
 =?us-ascii?Q?yKJreFU7wvw55liJ7GM8m+tA1YFJQZIb7nI0FshKQ983XkaW+kJCorqJIKd3?=
 =?us-ascii?Q?V7bKJVCmM9VLnu7vQNEqMh9mrjav1xu778U9Ji0CmMSZVEmLFlIieD43b2OH?=
 =?us-ascii?Q?xUEXthTQxva/+/bj6kIjUc4Feb7GHbjRkq4NfFSzhTe5klt6fHtTgk3X887w?=
 =?us-ascii?Q?boF7rmkIcdX1PnLKEr8eTGAMFVyC2nECf9jyadZL3/pNk4mglfZm4BooXg34?=
 =?us-ascii?Q?IWYYeNYufASV86EXdLnGTAMh6Q+psAkt5xH+qez9gfVmQPjlujLIaUq+W612?=
 =?us-ascii?Q?EzI3dZtujyGiR6KoJsnSlxcWqxqR8mmY9YwMD0SoYCHLAoawxVbr7pjuF7yT?=
 =?us-ascii?Q?j6LshpNv75mBAHsqEItfXycczHixNnT6JRcjC1ha6EBfx8+X+Ue/b+QGQuS4?=
 =?us-ascii?Q?s/w8KF6lL+GVJrMkIaIktOQPI42Dqx1QfLkRoWK9WiSN84VVuCRG40RrCgma?=
 =?us-ascii?Q?0xFt9vc4YVxCLyl+qALuoAswbEn4mZwZD3t0yj8U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7895447c-89ec-48f8-2d46-08dbada3e5b7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 00:06:05.0844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4z+JP2ZsVNnzOv/nsnXAs2TcZ6I1XcA28r6FtPsW4ncEOtZLdE3pcI5Xt3kP0DDDsERjl3AT7ShMGsRcU/isg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:56 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Endpoint decoders used to map Dynamic Capacity must be configured to
> > point to the correct Dynamic Capacity (DC) Region.  The decoder mode
> > currently represents the partition the decoder points to such as ram or
> > pmem.
> > 
> > Expand the mode to include DC Regions.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> I'm reading this in a linear fashion for now (and ideally that should
> always make sense) so I don't currently see the reason for the loops
> in here. If they are needed for a future patch, add something to the
> description to indicate that.
> 
> > 
> > ---
> > Changes for v2:
> > [iweiny: split from region creation patch]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++++++---------
> >  drivers/cxl/core/hdm.c                  | 24 ++++++++++++++++++++++++
> >  drivers/cxl/core/port.c                 | 16 ++++++++++++++++
> >  3 files changed, 50 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 6350dd82b9a9..2268ffcdb604 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -257,22 +257,23 @@ Description:
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> >  Date:		May, 2022
> > -KernelVersion:	v6.0
> > +KernelVersion:	v6.0, v6.6 (dcY)
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> >  		translates from a host physical address range, to a device local
> >  		address range. Device-local address ranges are further split
> > -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> > -		'mixed', or 'none'. The 'mixed' indication is for error cases
> > -		when a decoder straddles the volatile/persistent partition
> > -		boundary, and 'none' indicates the decoder is not actively
> > -		decoding, or no DPA allocation policy has been set.
> > +		into a 'ram' (volatile memory) range, 'pmem' (persistent
> > +		memory) range, or Dynamic Capacity (DC) range. The 'mode'
> > +		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
> > +		'none'. The 'mixed' indication is for error cases when a
> > +		decoder straddles the volatile/persistent partition boundary,
> > +		and 'none' indicates the decoder is not actively decoding, or
> > +		no DPA allocation policy has been set.
> >  
> >  		'mode' can be written, when the decoder is in the 'disabled'
> > -		state, with either 'ram' or 'pmem' to set the boundaries for the
> > -		next allocation.
> > +		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
> > +		the next allocation.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index a254f79dd4e8..3f4af1f5fac8 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -267,6 +267,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> >  	__cxl_dpa_release(cxled);
> >  }
> >  
> > +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> > +{
> > +	int index = 0;
> > +
> > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> As you are relying on them being in order and adjacent for the loop, why is
> 
> 	if (mode < CXL_DECODER_DC0 || mode > CXL_DECODER_DC7)
> 		return -EINVAL;
> 
> 	return mode - CXL_DECODER_DC0;
> 
> Not sufficient?

That would work yes.  There is no future need for a loop.  It was just
implemented this way early on and I did not really think about it too
much.

Done.

> 
> > +		if (mode == i)
> > +			return index;
> > +		index++;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> >  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			     resource_size_t base, resource_size_t len,
> >  			     resource_size_t skipped)
> > @@ -429,6 +442,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  	switch (mode) {
> >  	case CXL_DECODER_RAM:
> >  	case CXL_DECODER_PMEM:
> > +	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
> >  		break;
> >  	default:
> >  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> > @@ -456,6 +470,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> >  		goto out;
> >  	}
> >  
> > +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> > +		int index = dc_mode_to_region_index(i);
> > +
> > +		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
> 
> Not obvious why we have the loop in this patch - perhaps it makes sense later.

I think it was just walking through the DC regions like the previous code
was walking through the PMEM/RAM 'regions'.

> If this is to enable later changes, then good to say that in the patch description.

... nope...

> otherwise, something like.
> 
> 	int index;
> 	
> 	rc = dc_mode_to_region_index(i);
> 	if (rc < 0)
> 		goto out;
> 
> 	index = rc;
> 	if (!resource_size(&cxlds->dc_res[index]) {
> 	....
> 		

Yea...  but that won't exactly work.  Something like this:

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index cf5d656c271b..f250d1566682 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -463,10 +463,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
                goto out;
        }

-       for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
-               int index = dc_mode_to_region_index(i);
+       if (cxl_decoder_mode_is_dc(mode)) {
+               rc = dc_mode_to_region_index(mode);
+               if (rc < 0)
+                       goto out;

-               if (mode == i && !resource_size(&cxlds->dc_res[index])) {
+               if (!resource_size(&cxlds->dc_res[rc])) {
                        dev_dbg(dev, "no available dynamic capacity\n");
                        rc = -ENXIO;
                        goto out;

But looking at the function I think there could be a clean up patch before
this.  I don't see the need to check the mode twice.

...  Yes I think that looks cleaner.

Thanks for the review!
Ira
