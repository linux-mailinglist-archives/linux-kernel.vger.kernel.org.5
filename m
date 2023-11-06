Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DB7E1CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKFIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjKFIux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:50:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D49D47;
        Mon,  6 Nov 2023 00:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699260650; x=1730796650;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=jzxVJ+MXYNEYwplwofjDIQH79rHyZjTSi/6Zxvd3tpQ=;
  b=PoxKFNU52CmwpLifNXlU/2FzHroLVIBKYFvYMrIIDhaJrjH5ln7EfBzF
   6GQ1zg8YG5SOCAMbL9Kf8f5S1IEBdP3VJRYgMPd1vdMSqAC4ZMkdyqRQ3
   WbT3bRdTpZNybFTbjX+uDXwU3OGPeaXcgvIuscyObyekvOeXzbwDOwb6Q
   aERBNJ2seACSd5lEvgHfwYvwtZB5e5K4ITKYtb/QhznE12FBi3f9Yth4a
   Lr8EMXuggwLQj3sHv1k82VqkwFE1VUOB7a9bTaLvxZeuAcSyf9jvLI3m4
   C+leMGTzyx+no1DG2U15ITaKnMs5Ey4Vn9uiMOAJS4Dy0KNceu930PHbQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379624070"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="379624070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="905984008"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="905984008"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:50:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:50:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:50:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:50:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLXhGcH3b1MjVrqUiVtMbUzraPmX7N8KnU0bYurhDzUs8ZWtyn5OJWGOW2VvE7+a51zI/U/EpAxVGqVdW5MddathsJ49vPROKJYEcwOencjtoQ6ltWErEW6Mvq4n7DPp3clBTejdxWsGysD1vbTLvcee65QdKSk3weUOn7W6Qoe2opWbcQNK98VJm6ErkPrPePDx7J3WnTRXOWFAJ/Y0BvnORYyYMA3AWStGcj836P0npvOmrFFKUxTP6KPIR6i1tXBDSwbWSMVjmyqUNUHLlKQqF+VslzfgLeZ0IiluDA+64O6/qFWCCsFiBTfVBb0U8TyHKyl3WTIM4Ta5tremhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hw2iphEezfvmHtYwWG38a67FV3UjghJ0DHp99oVfjg=;
 b=OIstCYA6vQZ7cMGgnqpR8Jbsz6P4bwHujOeh248vSM2d50BvGoWilExvO3wQGOdmX1mwCan/noFV06Ky2GhbtKkgzLlomM5TMf5bo6gvffXr1Gv4QuEssGsMuRXDY2i4W64C6Lmn9+076lcHXjR5AGCE1dOihxbIY+vlM58dq2T7U1iM1ndkO3gK+/4ciQn6dQVmaoiSGdHVgqsUotqlDY4x7aL3TOc+56LKbeT29Y69F8VQkfarN6TukRr7rEt5NhvVv4Cl8Spn4XccHUk6kqcxEtBLhU3rsFULP4FcYIkZoIUYdskaTdVisSizwy9JztKMs/X1AX2dwvPBMWQYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:50:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Mon, 6 Nov 2023
 08:50:43 +0000
Message-ID: <0c710537-254f-48a7-b11d-3ee27c1f10f7@intel.com>
Date:   Mon, 6 Nov 2023 16:53:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 2/8] Kconfig: Add the new file vhost/iommufd
Content-Language: en-US
To:     Cindy Lu <lulu@redhat.com>, <jasowang@redhat.com>,
        <mst@redhat.com>, <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231103171641.1703146-3-lulu@redhat.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231103171641.1703146-3-lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 806c2d18-f327-4425-a4c4-08dbdea575ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgWXa/8uv3H/YEdo5zuBXFb0xVBwBlG+GGMZ/paRvaZNfvdSlzNAUO8nMFUHfzUFyrRYAtVs4PC1uZnL7gLnzk6/BWk9eDaibhoEzB2HJHhXSklyAZVSU66bNqkYl8fCqHtDsWRlkUUICWunTn+kMG5ahfAB7RB5KV9Vd/cjb1NlwCsdXWblNXBSiXpgKhh3avPQFom0HwxqcCSKTLolLIJslZWE3VjEGLClzYwrNr68gmTMHWRyiPNRn4i4G1Dn7E8ZmwMj0rYAvwXH5iraEvZSV+7I3sKZecn9I+IRWgCreOuX9pdqKpKZ7oWHTW67oMCBjpz549uO02nuNaNbHwzeT6Hx0JZ+iEOwTigLixJWfvtc8KyciG/dETTze7YzxKoixiu+6eDbwFvOsB9lTqq3AkkHPOn7vt3s3WeP1OY8sk/rzfAZ2cP9gdiwYdXS1FjNImaH5a4np7DwHhMIU2I+wrL9x8rzKkbkILr0N9UE8TcB7zHzTuim05ceQfnChuvpCC+9ZD9oNngrYNWZf1mnJCfS/R0ME41FERxRyd25QewqJyG7TOPKDXMe67mcJlg0dbtsFUBY9CYwHVjj3XTumcuMM2V8+glwCtPuOFS66WsbfskhRGcEvnVEUeK5t+JvMOYyvujX2gJUY7vVLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(53546011)(31686004)(6512007)(82960400001)(2616005)(86362001)(41300700001)(2906002)(8936002)(36756003)(8676002)(31696002)(5660300002)(66476007)(66556008)(316002)(66946007)(26005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRSVHJDeFNHcnVncFRDSkV2OW9mVHRmTWRkS3lUTHcyZmVnTGxIRnlGVDFI?=
 =?utf-8?B?SEZVQ0dRUk9aS3RGQWwvRjl3bDBJM1Q3alRGNTl6anFYYnUxWjArMW1QTHR6?=
 =?utf-8?B?Slo1KzJNL2lXSEdnTlE3MTlkN0lPU2o3VTJBcXgzWW9mVG5lMWtDMjRXVUFZ?=
 =?utf-8?B?RGJTM21GRnU1NFV0cjg0bU0yVXRZaGszbzdqMWtwdW5VUnBOOUpPU1ZpRFJm?=
 =?utf-8?B?UzBzWjg5eXR5UmJad1dJK0R4TFNLQmZuQTNmZFd6NGFXMUlBNkkxQmQ3Y3c1?=
 =?utf-8?B?TURMczNmeGVFbmgyZWZVTUhUSGY0ZERzYmhuUlpPTUwxWVhCYVAwVWFid0wv?=
 =?utf-8?B?enY2eUYzWnVnZlZZSFU4Y0poMkUzZjZnWnc1NnBIMVhSOWNFaWsvSXM0OGhT?=
 =?utf-8?B?ZnBDTmtjc3BUWUNXclBHa3hDMkhQamtkQTl4VG1OcTZuL2xQV3cyVGRmT3Vk?=
 =?utf-8?B?Y3NJNmRuZW1EM0lNQ0xVWm0yWFNQZlEvNHNaSms1cXhyYWhRRzVmeFhhQ0tL?=
 =?utf-8?B?Ymg0ZzJ0UTkvZURWKzM1VVZHOHdYd01jSXFNSGRLNUNleFhFK3N4UC84RXJl?=
 =?utf-8?B?RXBlQ1ZCaE5XekRCc3RlSG9HQm9STzl6QnFCNnVEK3J0RTh5dHJxTGZnaDFq?=
 =?utf-8?B?cW5kZkRJcFRZTDd1Q01WL2JjZDlxalpWTUZvZG45VG9KbUJTZjQxRW1wdFZT?=
 =?utf-8?B?aE15L0tXcXB2bmpXRzJ2VGNFa0hLUHNFWXlWbWg1c2tubE9zQis0dnRXdFdo?=
 =?utf-8?B?THNOZ0cxcUpHeUVzMjhxUktVSmNjR0psL2dGUkc0YVUyeHJ6NFZFTE1GWjVa?=
 =?utf-8?B?YnJhS0ZGaGM2QVl1YUFhVXZwaFc2MnJyN0RWeHlBbUhuNmxtOVpPdjZyWDZP?=
 =?utf-8?B?SnRsaFhEL3QyMUd1LzRrRFNRb3RsSG4rV3ZwU1RxTlJVRS80YmpVdENXQmJC?=
 =?utf-8?B?OHNHcFh5NVpVK29aY3liMlFJY0pXNFNRZnNkOEx1dnNNSkowbXZvMjZWTnBx?=
 =?utf-8?B?SkZVUnFBek1nV0dtTXFGelh4b2E5SnM3aFVqL2hzVzNha1JJTWNMbjhQVEFw?=
 =?utf-8?B?M2VXa2hzUzl0VUlNUUxEVFFzYitISG5PSFB0WURXay9BcHYwMHhUMHJkNTZp?=
 =?utf-8?B?TUlTZnJ1VTEzRkFibzVuUVpURUZ1dUg3cnlaZU43UGY3YjFTRXhPTWh6eTNj?=
 =?utf-8?B?YWNsNnNxeHlpaVVDMm92Z01SMk9LdXFKbEFtOVp6bTU3N2JrcWsyUThFVWVN?=
 =?utf-8?B?T0JUWWQ0cERWRDh5dXFnV2tXUDNua3FwQ1cyaTk5RFZ0cmlLSk45eVZKQzE1?=
 =?utf-8?B?dXV1SmJnb1IxQ1pOTGlNQ2pyS1NpTjRtUW52blRKeUlIU096aWtqQ3dRVEM4?=
 =?utf-8?B?SWZHUWtlZ1Bpd1ZFQWtOYW1JQUlBck4vd3YxSWJGSEpsVmxIeDRzWW9rdUNO?=
 =?utf-8?B?SlJYTjFwQXFqNjVVZFV5Q283SHBRYXRHOVEraFF0UEx4V2RmRWI3MHVHRlQr?=
 =?utf-8?B?Q0FJZFE4alpoV0Zvd1plNEd3QWN2MmZKeGRyN2dDdjUxdWtEVEMvR1c2S3pT?=
 =?utf-8?B?RjhqRGNnb1I5YjBrYWd6QU56cXJDSWV2M0NrdHFwQkc1bCtDc2NObVVEM0I0?=
 =?utf-8?B?bG9ONGFxU3JsaUhxWkpFa0M1YWpOWFhTblB1SWZEdTlkUy9CNkZRQnJJSWdi?=
 =?utf-8?B?bytiaytZQ1F3VjJEODFjZTVxQTVvUUc3UWNSSGJCUTduVGlKRkhQNzVvZmxv?=
 =?utf-8?B?YzFhTkV3ZElVQXFxcnp5Y1FjZFh4WlBaQTJWTkxiempjR2NJNGREbCtCUmJ3?=
 =?utf-8?B?S2FnbS9JdDROcy9UdUl0WGpzSWs3MlJYc0lrUXB4VThIeDNOeHNMVW9JdnBQ?=
 =?utf-8?B?TDcyYlJZbHVOS2FkOW96dG1Va3Vpams1aEJrK01iTmJqTmxqczQ3MnVwVGN0?=
 =?utf-8?B?NzRDS1YreVFZenczRkdBMW9UR0tRWEJCdVR3czJpK1NtbE1OTjIyRUo1MFJI?=
 =?utf-8?B?dW1OS2dnV3lqRGFLcDJhSWYxTnNwM0tyRU5ieVVxalJVVHNpNUdWNFUxTWw5?=
 =?utf-8?B?RTdIZFp5bTMwMjJ4ekdlSDUzOUJZK05XbVJyMGJySVFjNFlhcXU1YitKUzY2?=
 =?utf-8?Q?rW5NyGsLCsRF3liR2t1j+JSw8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 806c2d18-f327-4425-a4c4-08dbdea575ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:50:43.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbb0x2CBd2FdmMaraK4L2GNoO37DBpWsUaMi3g7CyWi/z7rSfRDI/TdTQrNbzYspN/a0K/9BHpWGn5zrvrDEFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/4 01:16, Cindy Lu wrote:
> Change the makefile and Kconfig, to add the
> new file vhost/iommufd.c

why not merge it with patch 1?

> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vhost/Kconfig  | 1 +
>   drivers/vhost/Makefile | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b455d9ab6f3d..a4becfb36d77 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -72,6 +72,7 @@ config VHOST_VDPA
>   	select VHOST
>   	select IRQ_BYPASS_MANAGER
>   	depends on VDPA
> +	depends on IOMMUFD || !IOMMUFD
>   	help
>   	  This kernel module can be loaded in host kernel to accelerate
>   	  guest virtio devices with the vDPA-based backends.
> diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> index f3e1897cce85..cda7f6b7f8da 100644
> --- a/drivers/vhost/Makefile
> +++ b/drivers/vhost/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) += vringh.o
>   
>   obj-$(CONFIG_VHOST_VDPA) += vhost_vdpa.o
>   vhost_vdpa-y := vdpa.o
> +vhost_vdpa-$(CONFIG_IOMMUFD) += iommufd.o
>   
>   obj-$(CONFIG_VHOST)	+= vhost.o
>   

-- 
Regards,
Yi Liu
