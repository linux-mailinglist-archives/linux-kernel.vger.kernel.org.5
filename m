Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671879C2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbjILCVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbjILCVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:21:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2216830;
        Mon, 11 Sep 2023 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694483106; x=1726019106;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7Bdw7+/vyabcvYfUj0VaxIDPDVy1P0gvVH+wu4+Gt4U=;
  b=W2qDmvHT7WgYpGAc/B1es0HcnVaQX6CCd80syTf4eamYdbe8KbHwkQ/D
   LzHUTav1YOuqvnCeenNLN5bkWflxLZxZ1GFvN8UqJaPSAzb44MXVsx/oq
   qfnmVLcOcVureaavSdbawoviVNpl9MYt/LpBZpp2/vnaQUJm2mYRAB9nE
   lY2YMIDwr48KIIP5fYr7aTzuFHOmO3EYmtqpRCyao5hH9nlYNDB/HMoFe
   aTM0gCfo0mNrN+sA9J7IwUOVJI+7o0bh3Ojeyy3B8msLaTaJ4L/M2PICM
   Uou2NCtF4ZhF9WF5ECaA8yk0h4ZCUoZRTIIoOCrkZSzLFOYlp1RlvTHOx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368506449"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368506449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 18:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886757231"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886757231"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 18:44:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:45:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 18:45:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 18:45:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 18:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVGGHsGE7W3fOXVf5fmTyIQTgIwoP6vT9UKK8fK1fRhZKq56k/2+tkBu4f7lhM+NOj/0oKz8CE4ULVU3dPRXLj94w4j+e8+qsQuUNOrl3KtYIClzxaYUGkTrq4knwkrt1q0rwVLLYHiPdhnIidgYNVi5LNlALbxk9KE8QyPp0JWAzEsdcpo9mu+hx+SeRWs8od59zOcVFc9MUgp7/56VqSHO1PVKERjsMWcO1Db7dQFrgd2l4X6+clsU5S3aWGBgVd3RZKwa83ClJybbSM5AJWJWPvFKjq8yWnV9f1pDopKRPhQ4972SSmCW3y3vnCv4a5GEH8oiolhcRgYkFcPHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGdK2ebuL5FrckhY1dnI/RRB6/jqNQWLc63xpcagvFY=;
 b=FHwYisqyyJLdeWoihwlW3Voib4+Vv+iGkzqc5Ta/UUz1dTD4fBtcoDly1mPAHIFmSeg+qPb2VVOfgHg7gJCBr4YwLmI/c9YqX6XrraDITf6XCNrvJwwfEVPRVuh4tebdes1eB7CygqKZbUDazQo6jmbBpzXuVqwWsPEoQeF4K4fqFNx0bHc2/lmeBBVuXp+4ji09r1ErT27an8WQpbRf32taNe/i20PQLs0QE771s3XkNAdXj6OlXazlJFtr8gro7/r2dI9OLSCBC5hsM1eux463PDeMF6APqcncuo4ICj45/DRJ0q7/9JaOjL909nR8wf3y+t8HhKzFvrrd0SvUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 01:45:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 01:45:01 +0000
Date:   Mon, 11 Sep 2023 18:44:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@gmx.us>, Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a.manzanares@samsung.com>, <nmtadam.samsung@gmail.com>,
        <nifan@outlook.com>
Subject: Re: [PATCH RFC v2 00/18] DCD: Add support for Dynamic Capacity
 Devices (DCD)
Message-ID: <64ffc298707ae_2f5aa3294df@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <ZPo6J3OsmD7YbYJs@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPo6J3OsmD7YbYJs@debian>
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: a641aacf-00e8-418f-5d11-08dbb331e0a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGboGWAPheBrTEQN8h+K2VKnOvlWXVGe/Ew09vJTQssVj4nZ0extu6ix9r7cArZs8DO1hTJ4o1DK1jj15ybfdAoywOflZ4TeXhzUXgdzt/0LR8PMny1v534ztBAyZWagTWk7n3YFEl72dQnjRxt/XOVIVzWGGHwGpAg6sQokGpUrBPDpg+DNoZYyq4j8xzJUiAbPefR9gq0wNq4vq0S89mZZWJbpKkKP2RxgiGPXUOIofgFiU/OpbUlLITtponi9h3i/fF9Fcv8I88ZRJGVKuSws2bKQ0nIyx+qDJ51IezCMQBaOwEdZeBAA0Fdoom6EoGIjMcfLy+XjASu2F5pGUh9IZd9d2xzX+w8VDUjfuW+1O6K5ebm2HJZ/ko30Gln99PRHoQqi6U/bHuywT37p8naTt3krvE1UUCIBYMsID1c9mR/4We1kzh4o5M192uYtCk3RB9G0KWbWO/jEG1GHrXrqrBICxLLzKo45Agduq3LkuBhG/rPkKZBErrg5wLybI5+v+6v/0N3tPGU0D6iwawDvqD7jz8ITz6ssSxUJZOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(110136005)(8676002)(478600001)(86362001)(82960400001)(38100700002)(6512007)(2906002)(966005)(9686003)(83380400001)(8936002)(66476007)(4326008)(316002)(41300700001)(44832011)(5660300002)(54906003)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QcDncTLLU8N6NeIfobGO6eDg/g334xKqHK3xhkYapPp/5CH8NfQpBwkxoaQA?=
 =?us-ascii?Q?zgGmI2wlkh166HQCZzNOyqCoztkCnbCDtZi4xFAOItiK9ZW70sy8mh2lp7xL?=
 =?us-ascii?Q?BXQTPtGBbdcSmTmj0YPdEStf79Cz/ghCUK+O6CvrU4H4UfZFdIeIPEuwawct?=
 =?us-ascii?Q?tW18lX1zXWNC42bcAem045bkSBwcyOV5CgrWnvOqRb4O/fVdS2RV26PuLHpr?=
 =?us-ascii?Q?SCP2zFw9xXsp2NOyWREvasZHd2HGofZnyN04+5PDzUN8iRua1R+bb30ShasL?=
 =?us-ascii?Q?IRNQiy17z9lRmN8Ijl9DgzAZWVAB24wod/uclZwtXGjtLuprgN54P857aQgv?=
 =?us-ascii?Q?txlBJyFHAS6V1E4RJ6AYwpBbddMP8k86eoi8BY6XYiw5Ya56XW3wG9WTI+ty?=
 =?us-ascii?Q?++xfb63Ibp8ran85cqooFGnNq8giyP21SRoeLQ5dfNUEX33yUfgh7XKbxcb6?=
 =?us-ascii?Q?5evpSKQa/2ZfFd1XIvVSEMUjAz5gyD3GNn8c0sCzgWNRHNheR+LFSEnhcCTv?=
 =?us-ascii?Q?NjqjtHGxBWZhuOfB0di0YvimPF3wUD4n6rj3wf/w2gZENumtVeiWsZJEOlYD?=
 =?us-ascii?Q?TgVWjylBcpexLbSe4GlRSuUrjXvu9eRJf+BFlLOwIeT5dQIINJqMdvB88Pb+?=
 =?us-ascii?Q?PaHAXbUcQo/v1ij7th1ir3/VM8CXEsqDrcviNasYNW5yrlzzJy+LsUkNdbcu?=
 =?us-ascii?Q?lExqMbYk3T6b5cr1f5YYglZUwA8WiqmKP+0tHoXPmPFdpIwzlZ+qOxUrCZOE?=
 =?us-ascii?Q?ACPIkhjLDKDq6dXKKqT4hE84wprfE9vQ0/FzzUEcXUrMyudx1dNlgLW5exBd?=
 =?us-ascii?Q?FKMrwqArA/rIMUVmFgmhsDLBjZBS3XsVxteGHfEFAhHELDM2s6eIcFXF0rU3?=
 =?us-ascii?Q?pHZq+inttBhh+8hN8SAmgcYPX30/5CzVJh7rMHacMs7tHG/UlX1ajDAZBGyo?=
 =?us-ascii?Q?EB+/o4J8Z2B6Z1GKY/yJoDsmh9tuoONlwaQe1UhpJwM4oQr9C0uPydsPnNk0?=
 =?us-ascii?Q?S4yl5u7Y6dePZF8ei5ieARyaQmlFVecsWqr69hjZmZdzCpw0NDdHdl7QByd1?=
 =?us-ascii?Q?tntzS+x2eAVnCBXbTtSM8//8fW4Lae1U/KSZwH5cayPRs3nFsDykl8RMPaRp?=
 =?us-ascii?Q?8OMcffExTWDga0mAqim9NS6UiWMhet6TEbWnV9AmvgvTPrB+RxEHTEKardNX?=
 =?us-ascii?Q?UDf9AZGayVQvM9yao3UINGP58YJo3HHhWT4FvlPN3TKGgoSuEBtnEVGBXap/?=
 =?us-ascii?Q?9j9Mf6RcYano8LOFNhUJX0VP4YMynCfU2jqamT7HcDclpETGhbU5VkCdmQiY?=
 =?us-ascii?Q?l3iNKOa2oWIKxStypMeR+a82MuiKNAViAZY8XHvAQ3H9D4m549/KWXJz/w03?=
 =?us-ascii?Q?SyTY8cZac5/be/gBeYi0FQwLjGZMNZQXPKeAk9ncx/rINitzIGmnux/NmKV4?=
 =?us-ascii?Q?TZ+AwleomY+rZ5SOs06C+yjkpLvyZewPMSX+otea7ITTqiNmhRs8D7nwhUu3?=
 =?us-ascii?Q?Odb+4rQu8zTf/NHXB34mffUVz/3f8o0mwwFwE5m/GIvqzd8WnFE70RPST5lX?=
 =?us-ascii?Q?yFncO4VbrX9cWhnWP1gFP/D5US9+iWDS7P8oAhu8pOR5GQ4zstWX9AZYEzBp?=
 =?us-ascii?Q?SfAWM2394014xXSSSidamX7H89QFQl3vw5np1ImiGYgb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a641aacf-00e8-418f-5d11-08dbb331e0a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 01:45:01.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8SV6DhI6staqkkPpfDhmNHBvAczqULP1UmJxuramWiaAKx6wAX+abJGR/ZrX57pqi4CgXT6/PyWzWlpHEiNjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fan Ni wrote:
> On Mon, Aug 28, 2023 at 10:20:51PM -0700, Ira Weiny wrote:

Sorry for the delay, I've been walking through the responses and just saw
this.

> 
> Hi Ira,
> 
> I tried to test the patch series with the qemu dcd patches, however, I
> hit some issues, and would like to check the following with you.
> 
> 1. After we create a region for DC before any extents are added, a dax
> device will show under /dev. Is that what we want?

Yes, see

cxl/region: Add Dynamic Capacity CXL region support

	"Special case DC capable CXL regions to create a 0 sized seed DAX
	device until others can be created on dynamic space later."

The seed device is required but is left empty.  It can be resized when
extents are added later.

> If I remember it
> correctly, the dax device used to show up after a dc extent is added.
> 
> 
> 2. add/release extent does not work correctly for me. The code path is
> not called, and I made the following changes to make it pass.

:-(

This is the problem with cxl_test...  I've just realized this after seeing
Jorgen's email regarding the interrupt configuration code.  I've added it
back in.  I'm not sure where it got lost along the way but it was
completely gone from this RFC v2.  Sorry about that.

> ---
>  drivers/cxl/cxl.h    | 3 ++-
>  drivers/cxl/cxlmem.h | 1 +
>  drivers/cxl/pci.c    | 7 +++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2c73a30980b6..0d132c1739ce 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -168,7 +168,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL| \
> +				 CXLDEV_EVENT_STATUS_DCD)
> 
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8ca81fd067c2..ae9dcb291c75 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -235,6 +235,7 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dyncap_settings;
>  } __packed;
> 
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 10c1a583113c..e30fe0304514 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -686,6 +686,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  		.warn_settings = CXL_INT_MSI_MSIX,
>  		.failure_settings = CXL_INT_MSI_MSIX,
>  		.fatal_settings = CXL_INT_MSI_MSIX,
> +		.dyncap_settings = CXL_INT_MSI_MSIX,
>  	};
> 
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -739,6 +740,12 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
> 
> +	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event dyncap log\n");
> +		return rc;
> +	}
> +
>  	return 0;
>  }
> 
> --
> 
> 3. With changes made in 2, the code for add/release dc extent can be called,
> however, the system behaviour seems different from before. Previously, after a
> dc extent is added, it will show up with lsmem command and listed as offline.
> Now, nothing is showing. Is it expected? What should we do to make it usable
> as system ram?

Yes this behavior was not correct before.  DAX devices should be flexible
to be created throughout the region.  Either within extents or across
extents.  Dave Jiang mentioned to me internally it might help to add some
ASCII art documentation regarding how this works.  Generally, the dax
region available size will increase when extents are added and new dax
devices can be created to utilize that space.

Check out the dcd-test.sh in ndctl at this link for the commands to create
a dax device in the new architecture.

https://github.com/weiny2/ndctl/tree/dcd-region2

Hope this helps.

> 
> Please let me know if I miss something or did something wrong. Thanks.

You did not.  I thought the new dax code would explain this new dax device
operation.

Some new documentation is in order.

Ira
