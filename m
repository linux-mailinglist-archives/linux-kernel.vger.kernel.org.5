Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7205F79AF94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbjIKVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbjIKU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:26:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8570185;
        Mon, 11 Sep 2023 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694463975; x=1725999975;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4dtitF6+w6+WWJ4jlSkZV0dZS0Qx6EvYnHLGxzrehtg=;
  b=jDSqe4G2M5aMa1BHy3IG3QiRaDh1BC09RnDgSNrKTK+dJRS1BN/ikaG3
   s12k3Vg1ha9fxsDQ4vqa6yyJsteMBS2Tqsat15vYGus4w+zLcSHmJ4OI3
   eLwlyV+B2E5ZZX1v4xUThsW4be/wmKOWXewGxjFpdOXVpjXHzxoBqZ5la
   wtnURN17F9eLlj2WpObH5lTEpzGplvYhht4Qno/hLoIPcfTOzKatm1Bwl
   oY8g6IyDEU05YlzblcNaz8yb+9PXggIJENXU0pxMRftftqu3D74kX8W2O
   KDOSNYCl6JJR5uO4qEWqDhowpI6PpurpoWt/QhusXNfwWGCncQZx86p3C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368451778"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368451778"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720116476"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720116476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 13:26:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:26:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 13:26:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 13:26:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 13:26:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un+Y/kzKKIIlUnCSI07XV1Z7NEz1Bn4YOT+hkGQzIBrSX9Kl1PZi6Gif3L9jHFsWQ1p6/QOFLb6e3+T6GOp5aWHt3fXAZL06B7nlmGQmtmyLUFAlwU0n9+ApSBE9ijbLEkZSDonzt/S1pUpno+iqYKRsCKPQsKJQ7VIZ2SAmI3c2np4Gekj1T4LPxmE1yFafH7HMoZPsD8wQRFBmnKLR8VkGDLDkOloPP6hkYMaRCZr94Q1fn+9kaYFDNidi8KZgRAssgBh7eZ0XCAZbeXOCIat9I1ADtk3oiiqgRfrOuCI2rEK3qoQklva+KAdKJm4Gu1bsMa+1K48rUOU9tQCorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOCPYOdm4Sjko8jKfQT01goseXCazKLcGVaFw+aa3Ic=;
 b=MLlNjzHkpA81la3sr9Re0EneAP8taQGuPm116iAZJy8SKLROCEsylJcGSVtVT7cuiBEPCb4V9AIfTy/d5rgEt/tFDcIsgqZv7zvs8KDKK8FsYuXpLyH0I3/4dDOIAkfZs1V9AvQvuLCOVCOlfPrNy5wU+xwRo2J//geLIasblAwjpQghszqZiJU+nN73r3SrFawlaTH5dJWtICkLCMMNWjCpAV9EK8RLdnOsoQZaZj+FcRWsNROVbyPaKo6D/+c3fdZDNqWq4g2NVVuuCW/YDOK1gL2yxQ4V+y0sARcRpEPZkomugwo+dqm341E/BMhfXKbn9L0dkwOTki/oRrBNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 20:26:11 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:26:11 +0000
Date:   Mon, 11 Sep 2023 13:26:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <64ff77de72fb9_2f5aa32945f@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <1d49b674-81ef-081e-97d0-2e0c5a54af6e@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d49b674-81ef-081e-97d0-2e0c5a54af6e@wdc.com>
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 382e6cac-05a7-4c68-cd76-08dbb3055668
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py3p+fKGdPGvtj20jDER/PSwCXfIv0w5D1ny7AGg59hUPWc/atof3+CpYv2SfCJzbiJjrgWzxs/m0U06QZN6D0RdszPyfS+JWFXA1HnwGx8l+VwtukDf/vcRCqBeOpl95fnGPMSaZdFK6S70D7OqeSOk81IiizpD2uSN0lzTonIQ7wujUYg+RmGPc7S1+WqrLYnHyX+VA4TV8hizR6zryamVXqWLiJz0X8fabTHDc1JoQhDmoW+H1e0NfbQ+wgZV9sU1Hbay29AzTOtqpD7QAPHNoH+CXIFdbly8uUWEVuER1sljRXJTKO2LkFlExCRiXxgkPfqE1iOKneIQyGjmeF+A5viSVHdIfZqxsenyviQ2Dd5gmYe2La91VA7K50XvQ03BZ4Zs7zGadZdZtm/svQzVJ/oZoVEKZtgPiA/BDtgK4h9klzso2TXw5L9l7ROZwDfE5EbidzYgmf9QTbi1aydzoOIxLnNEz7SJ/1TGTdohXjdkYzvLTSgrzS+JZXwgBHxvhvU3+HBJiAkwPkng+vUMeNIzaYUsondphEK+6LR31YKvdFidXBDNbhZaWnFW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(1800799009)(451199024)(186009)(66574015)(38100700002)(82960400001)(83380400001)(2906002)(53546011)(110136005)(54906003)(66946007)(6636002)(66476007)(66556008)(316002)(6666004)(6512007)(6506007)(478600001)(6486002)(86362001)(9686003)(44832011)(26005)(4326008)(8676002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nGS2NMckRGgrkFDOa1IIrnUsGAu1sxACQe0WWkLOqkaqMs1U41y86nj9HZ?=
 =?iso-8859-1?Q?6ZHTZ4pkqvUPRwFz0ULvtFiSE21C0O+NCR+9mMbk+WxvDOIOfgHko8QAjy?=
 =?iso-8859-1?Q?oLCddaAzLvaPZczTFRVnFcqw2br3c9gFRWbdFNOIoBL1ZCqKhJim80iY8G?=
 =?iso-8859-1?Q?01/uJ81VzILTWjAc8SgJ+O3O/F28DAmDQ/wZEvSqqSk4oGjc5NDXOkNh0C?=
 =?iso-8859-1?Q?hm7OHr8a7cNY/oNmDKE0HYnUQAKt1PZTZzetSqZA8aHDtgCq9h9gds2GrO?=
 =?iso-8859-1?Q?mTU8zAU85mB90zQ/OrD75r5ZNMYWHZOJJIyXkcVaTI4zZtNxUI3OlSAkhO?=
 =?iso-8859-1?Q?KHldY3hGCaO4ufhRzgUPZIT3F+mz8dRZqXRJRW2ctJb/+5K+3B0TQ6VJvz?=
 =?iso-8859-1?Q?0USAKK6cYIm9dLpD1gDqWaXBKPgfQaxxxb3Ga7kEx4U4O89D1dCzmB3Kfk?=
 =?iso-8859-1?Q?C/ulfrJtBnNROJYhG9Js6VNk+OSovxGBwA94vuXvXp6M07nYWwvdAeGsIQ?=
 =?iso-8859-1?Q?CUpgVLwrbi298BOBGxNtGTznWbyNtGfACU/0A6hBr+8ql2kXl8b6kGoIZV?=
 =?iso-8859-1?Q?38PM8nXrwNXSLeQdIcg03EGqqgNIVs382rmx6/omyIKRzpxu8DBgoAis8B?=
 =?iso-8859-1?Q?5QPIkCvXMr/z3mC7MFMI1bG1cLN6fcxTKEpaJR2BGdtDrjR82pE3q/3xrB?=
 =?iso-8859-1?Q?CKm8xpQb2fsKvdtgsGvug58utqdCkszS1QxiV44d0pzVwK4ULUksnzEMci?=
 =?iso-8859-1?Q?qdBsw4WnjoSTwjvExDV591tzHLtsRJ8X/+XW5rBxA4cGYW1KpQk9lwGt/d?=
 =?iso-8859-1?Q?f4A7gDYUYnQQxzCzzrSzy6p5xZy31Jtb3OZzMTQybxu8OP6X4riucZfl8U?=
 =?iso-8859-1?Q?T/r96WJ/a2QQR0szW4OqXN9+pUbIXQfMtmkhoMy9l0T5eoCgesx8C1gvMu?=
 =?iso-8859-1?Q?2xR9G82gcJUufQCWC11bAT5Y2R0ImfCSZHide06INU850GSq1t5K3dtJNt?=
 =?iso-8859-1?Q?Vnq21XgmolWKlUsX3DjTVl1SLETOh0K4KT5mWOc5sYsFH4UncUDIPjJoLS?=
 =?iso-8859-1?Q?nImdbSs50vKNfFXklmSllzroch9nTQF+wCaXGFF3DDWrJt9tzlZUqqe42l?=
 =?iso-8859-1?Q?pZEDgVh5GUsVdlWCH1jzT6TjpYEe0G+FhLTtO2J/a/NeTbmtbN0eCXwSOz?=
 =?iso-8859-1?Q?3flxEOCV+kRdqJwFA8wFssY1Lt3t/8B1ZhQSGhl4kowz+8PKYOvP3On1wo?=
 =?iso-8859-1?Q?DheXWzNQdJ3w91wMGOIxSOeQznXhyQ9WXkN3ajgVzDdDuuuA7fY1RA+oj3?=
 =?iso-8859-1?Q?tD2wFDcUNWl9gXp9f8lSVqATST+JsW9OMkmfYraX/FmqSd+iNXoI5Cpvqn?=
 =?iso-8859-1?Q?qs0Cc1+YpFfNpYuVB8ELNPxncUIY6I2vFClr5Q/yxZIebuKU3qhIseYww/?=
 =?iso-8859-1?Q?POOA1cYZSlw6GaOMMDs9GvzQFpTulx0T2e41cSG+D9T/YJTY3SQkIGhgyH?=
 =?iso-8859-1?Q?Y5dEFBnqJaks1QNBCyJMmC2AqVGmvwk8PpVPeD1FkM/l9Cgk4RT0D5Wtrb?=
 =?iso-8859-1?Q?BtTDrTkiB8XwwranLKJDBdKqTeoaRO5zoAIXMSHjQooIMTCqt8K1+4Z7cP?=
 =?iso-8859-1?Q?EftlOmNcDM5vcfYDJ6S1QrR+lyrJCHmbKO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e6cac-05a7-4c68-cd76-08dbb3055668
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:26:11.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eokr+FbCkAR2e7Lw4Wl/IY+DgVMOg+fN0DzKL8ouYpKt82UExSbuuFq4ur/R5rZtmzVyc+SLs8zXZXX6Tcj73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5811
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

Jørgen Hansen wrote:
> On 8/29/23 07:20, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> >   /**
> >    * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> >    *
> > @@ -449,6 +464,8 @@ struct cxl_dev_state {
> >    * @enabled_cmds: Hardware commands found enabled in CEL.
> >    * @exclusive_cmds: Commands that are kernel-internal only
> >    * @total_bytes: sum of all possible capacities
> > + * @static_cap: Sum of RAM and PMEM capacities
> > + * @dynamic_cap: Complete DPA range occupied by DC regions
> >    * @volatile_only_bytes: hard volatile capacity
> >    * @persistent_only_bytes: hard persistent capacity
> >    * @partition_align_bytes: alignment size for partition-able capacity
> > @@ -456,6 +473,10 @@ struct cxl_dev_state {
> >    * @active_persistent_bytes: sum of hard + soft persistent
> >    * @next_volatile_bytes: volatile capacity change pending device reset
> >    * @next_persistent_bytes: persistent capacity change pending device reset
> > + * @nr_dc_region: number of DC regions implemented in the memory device
> > + * @dc_region: array containing info about the DC regions
> > + * @dc_event_log_size: The number of events the device can store in the
> > + * Dynamic Capacity Event Log before it overflows
> >    * @event: event log driver state
> >    * @poison: poison driver state info
> >    * @fw: firmware upload / activation state
> > @@ -473,7 +494,10 @@ struct cxl_memdev_state {
> >          DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >          DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >          DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > +
> >          u64 total_bytes;
> > +       u64 static_cap;
> > +       u64 dynamic_cap;
> >          u64 volatile_only_bytes;
> >          u64 persistent_only_bytes;
> >          u64 partition_align_bytes;
> > @@ -481,6 +505,11 @@ struct cxl_memdev_state {
> >          u64 active_persistent_bytes;
> >          u64 next_volatile_bytes;
> >          u64 next_persistent_bytes;
> > +
> > +       u8 nr_dc_region;
> > +       struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> > +       size_t dc_event_log_size;
> > +
> >          struct cxl_event_state event;
> >          struct cxl_poison_state poison;
> >          struct cxl_security_state security;
> > @@ -587,6 +616,7 @@ struct cxl_mbox_identify {
> >          __le16 inject_poison_limit;
> >          u8 poison_caps;
> >          u8 qos_telemetry_caps;
> > +       __le16 dc_event_log_size;
> >   } __packed;
> 
> Hi,
> 
> To handle backwards compatibility with CXL 2.0 devices, 
> cxl_dev_state_identify() needs to handle both the CXL 2.0 and 3.0 
> versions of struct cxl_mbox_identify.
> The spec says that newer code can 
> use the payload size to detect the different versions, so something like 
> the following:

Software does not need to detect the different version.  The spec states
that the payload size or a zero value can be used.

	"... software written to the new definition can use the zero value
	                                                    ^^^^^^^^^^^^^^
	or the payload size to detect devices that do not support the new
	field."

A log size of 0 is valid and is indicative of no DC support.

That said the current code could interpret the log size as larger because
id is not correctly initialized.  So good catch.

However, dc_event_log_size is not used anywhere.  For this reason alone I
almost removed it from the code.  This complication gives me even more
reason to do so.

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9462c34aa1dc..0a6f038996aa 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1356,6 +1356,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state 
> *mds)
>                  .opcode = CXL_MBOX_OP_IDENTIFY,
>                  .size_out = sizeof(id),
>                  .payload_out = &id,
> +               .min_out = CXL_MBOX_IDENTIFY_MIN_LENGTH,
>          };
>          rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>          if (rc < 0)
> @@ -1379,7 +1380,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state 
> *mds)
>                  mds->poison.max_errors = min_t(u32, val, 
> CXL_POISON_LIST_MAX);
>          }
> 
> -       mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> +       if (mbox_cmd.size_out >= CXL_MBOX_IDENTIFY_CXL3_LENGTH)
> +               mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> 
>          return 0;
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ae9dcb291c75..756e30db10d6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -629,8 +629,11 @@ struct cxl_mbox_identify {
>          __le16 inject_poison_limit;
>          u8 poison_caps;
>          u8 qos_telemetry_caps;
> +       /* CXL 3.0 additions */
>          __le16 dc_event_log_size;
>   } __packed;
> +#define CXL_MBOX_IDENTIFY_MIN_LENGTH    0x43
> +#define CXL_MBOX_IDENTIFY_CXL3_LENGTH sizeof(struct cxl_mbox_identify)
> 
>   /*
>    * Common Event Record Format
> 
> ---
> 
> Something similar needs to be handled for cxl_event_get_int_policy with 
> the addition of dyncap_settings to cxl_event_interrupt_policy, that Fan 
> Ni mentions.

Yes this needs to be handled.  I've overlooked that entire part.  I think
it had something to do with the fact the 3.0 errata was not published when
the first RFC was sent out and this version just continued with the broken
code.

Thanks for pointing this out and thanks for the review!
Ira
