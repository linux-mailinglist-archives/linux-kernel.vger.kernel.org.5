Return-Path: <linux-kernel+bounces-132093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B651F898F88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414F61F22499
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7C1350E3;
	Thu,  4 Apr 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcGjBDvo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A01C6A0;
	Thu,  4 Apr 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262056; cv=fail; b=KV78bvk11MVOJEh1DE6ON2gYgBcWoy6Bye/IMwt2mtzvy2W9f9V/1p43jhheCka5dxUTob8siS1oSbCfHqFF9PJfdz7kCtbnxxBizDwEZQl+6IOvXlX9fL2rxxNtNI2sSXVODWaK+roMB8rjo1O7cxMq2G1juT1ciEHfZvbjtCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262056; c=relaxed/simple;
	bh=oeMnIlu7GH6qtcvIb8bOG+qBf1tP26uIaSPxI/vsHPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GV/PfwoC5HeF/cPl1fZA762aYJZwLjpIUHgjzNGaH7j1XlAkJA7fbPivEp3ErFXl3PTsxekQBMnVxAzFibAA649BHcx3GIYueQp6lak/YCv/YPkiRPXZtPlIK3iTHXzQ9e9NNYffe7vInxOZSaPvFU1ByrRKlF5TBt2j645gwZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcGjBDvo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712262054; x=1743798054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oeMnIlu7GH6qtcvIb8bOG+qBf1tP26uIaSPxI/vsHPM=;
  b=FcGjBDvokj0NPSyJAcBL5qoRNSvkRhWX2lN53CCCFZxCOdH/PMGJjvNh
   g1YY2i6ssvRN6j7AH6Jrfy6xGXuuLgdhku0sApuUriGOmF6yZalY4a1Da
   AJ6REexEnuMd3WjRPHoS5Y3wTSOfYhLsHjpR7FMhR8jBFnrNkY0pSoXTB
   mM93Crc2d4lp3jMStqCmSaU6Nlqwf/NaUtJ2Gw+Bj57TlgDvJ34Rxbi3i
   WnRHQhhTpMLhXhlaKLCFyzBQEJKfz5gVLjhs49+7l2jkJyrhmrJfgbgQP
   qzQBX7hn6rY88xw4l/Sdi5xxUH365KbA7lf4+OqJThbPcFa6UrZDQMN7B
   A==;
X-CSE-ConnectionGUID: wVKW01sgRo215fa8mxGyUQ==
X-CSE-MsgGUID: TZcVkjFYRkCddfyjaXeLPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7478273"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7478273"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:20:54 -0700
X-CSE-ConnectionGUID: eT09kurnRLSNSrRLHE7qzQ==
X-CSE-MsgGUID: qg94Q7mPTruuowB5A/BHmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="50155140"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 13:20:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 13:20:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 13:20:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 13:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB0SZjN0xfsKG9bNYjzp0CBndz8VPlIzm2l++VzInVQ3rtImGKR6wJPmGl0l/5q0RG9zsqI3HDYUMtd71nPRoJH5S5QKotxtSN99jNQMAPFFfdT2Y1fJFKNbhqqhOlUU4+Oms1y3DBbjnld/S7DES6+XLNXEkJX0ClcVsACUiudZpl2oUkitQu0FR6sXLylklAlXBRFGv0TH/JpthClEwoAO2/FpIlLvEk2dN5DCnAIhs3rx1KvdktwR1c5huWr5IPujUWUCesS22vowzKWqewwNLE8mx67MueAE++Rf5V0gpd87AYCbRJ56iBAeurK6aUZ1K+lUSzHCklvwu9loTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/UwRkj7TiFaD9ZjlRrKueAvZvsgPTIbY9OQdsFL7c4=;
 b=m3HWqZJlK96LFXhi5eIKvI3UMMIrLKXnVzn9c6uDJFFlHkG+DOOGcf3vUt28eoIBUdjbHwA09+hp3FQvNfvaIpQ1+am2OHao1KeFwxi70Pvv0xzr8VYW2Oxn3HQfsj+PAyHQikilkWisiH7nUmz4g3QENlTJy71+cPzCwm6phTlMeTkvX16pcd51GQF7m4BraPCZLNfbb6lmZ9+kmSUScRx0wkCdTKb/4VtxmVDRRrtUIvzw/+rw/l8YLxWq/srTnH3gtRNZVuhpVoOem25splOetF12IQ4QuEvf1dKh6qfV3+40hdClsFA8KE+aKvq+uDWXRCi1U/mrTDqRaJQzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6800.namprd11.prod.outlook.com (2603:10b6:806:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Thu, 4 Apr
 2024 20:20:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 20:20:49 +0000
Date: Thu, 4 Apr 2024 13:20:47 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Kwangjin Ko <kwangjin.ko@sk.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel_team@skhynix.com>
Subject: Re: [PATCH v2 1/1] cxl/core: Fix initialization of mbox_cmd.size_out
 in get event
Message-ID: <660f0b9f43ab_e7f16294f0@iweiny-mobl.notmuch>
References: <20240402081404.1106-1-kwangjin.ko@sk.com>
 <20240402081404.1106-2-kwangjin.ko@sk.com>
 <660d6d64a50bd_7702a29466@dwillia2-xfh.jf.intel.com.notmuch>
 <20240404143049.00005635@Huawei.com>
 <660ee4f023cd7_7702a294d0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <660ee4f023cd7_7702a294d0@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6800:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzaZlwCczFRMqtBqIcVvL0cFkLzQr4M4JJvqFv3B9gXhYzJnR7G+cdLLgMcYtGbVNs+G5a7G3atE0qRcw2ZrT5KObnaRHRbWQ8CJjWHtP7tgXNfUsCGeYgluYYny9MJnr8I7qChBvPCMZuFODCS7iTnD2jAygZVZxvYjtSKyrNDmzgeNs2duhLnA0ygkGbEChbxSu3ZR1wqaUUnE2to+TI9P+qXQ7GC6H70hpkx87+fVeJKhZtKB4Ge/0ToZ+z0lb1d7G3Y0EfsbOGG5Gbm9PG+b+PnvhSWosol/SI+jQvOilsww2UBvwMJEzlURU1/DmqEbdmzufQz0eRoQ9PxGAZ4G6OXf4afxiwGDsTxKDpUloR4krTU9+2zDKVgMvlZzSBcjcBxiA3cLdqw7jAdVX+dISPFAN/hUI4bVwiFN9zeXz2uqyRzm924szZMqhDuehXV5AEy+mSIz8XTK8hLJgP54dl2HsdvGKLHaO2sJQwvjkX7ixOHoGFul6aaF3rtODUu7Gqbm6HmMMK1Eb4Bkt4NbrvEgjKTx9OZbtaeSe+E/0NrqYnoym/ShWwILzukBBZK/TWISMdlB6k6O6f7XaSno8GyHHlqoD/ssoVQ/ZYo2fWsUtjhVk/svaKyL4EAK/mxhk8smEschr7mjDbBkxifM3BlWFqZq/ou+JCPWO78=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5ZwJRGUWmx6yG1AyYeN8Hv0VmRGd0qXFGy3zYV2aLj1vPk4grl5NeoC7r9s?=
 =?us-ascii?Q?9orQqul1Tn8ORrJvMC78IVe1MRQrsfLfthq2mS2EZInrpGTQWj3a1kyjjsh/?=
 =?us-ascii?Q?yLKQvujJJCeTvKvBlUIoTzeMuPeAeOFCU8y2G70wa70A1gySGz3JvUkDoBvS?=
 =?us-ascii?Q?0KpCWHDXqMzoLZXCq9E5iTrtRhrixXLUrhw0PhReMcolFJejYyU7QBUMu85z?=
 =?us-ascii?Q?zAh4dBLhzO9wjNMk19TH9J91luUJ+UdcUcUSJa6sG85WyWzvliE5VQJEER16?=
 =?us-ascii?Q?ttUxdiE3Ad6iPcYct6P1pM4XzyxNqgsqZJMGTPepLzXW6gJaLXmx99rOUvKW?=
 =?us-ascii?Q?ynMlbCgQf4IpvlrLNaPxgeMV85V9Ed2wUAVNucoHE9MEJxjlRPqIJTIM3BvZ?=
 =?us-ascii?Q?r7CGPiN6AfpLs+/10tL+zoC6w+NxanwNRtyQDSNvijeiwmJMy5vEGJoq1dR5?=
 =?us-ascii?Q?daYyrOXS3xUFtwOOZZnDa3JF//b3Vypzdxg36ZLtF8mx+ChgPqifBoqKWWxi?=
 =?us-ascii?Q?4fOkcw6T9Yluy36smWfDovGLv7y+j1CLuIhQIp0Ex+H2spWRArINHpBpTEni?=
 =?us-ascii?Q?S5ebKGH956QStRL65fMq2vo0i+x0DlSnPa1S78qYeMzNWWo4kqQxMOFXXN92?=
 =?us-ascii?Q?PZBtikk9SctnOG3ox2v+3CARH5OS4GrBYTihuTFhEBsEe5JZwVqXQypH0I6d?=
 =?us-ascii?Q?FOy/kZZcUm0fHpzfHPqQ29Ottumvl/1KEcxm5dEMxHxYcb7On+KG4ZCTIH60?=
 =?us-ascii?Q?7lAbajfjDrNjwj2QkmCAF4ED4jxiPdc0YGGcvhfZrVMAunkATiV3iF+//dCR?=
 =?us-ascii?Q?ltYFtPgVn4BW21+rbyC3UhAuFYb5gLFM9kONb2YdWxpB6OP2+u8BGiyCQ+xl?=
 =?us-ascii?Q?odLET22ju5MUGqy9DNvcQzuCysWGwl4CKk6w0ZjyShbWcfJrAxqPvV6jVc8G?=
 =?us-ascii?Q?K9tDRzF+NRfnnUYjXwWxgg6eojF2X1G2QuXBBWpw1pFciVX/hFFl69yGGkWM?=
 =?us-ascii?Q?lL3ne7L+NF7cgAtN2qeeBS6RKoGy5a9CoPdzGhoOeikjgqHcXUX7C4XjC27o?=
 =?us-ascii?Q?cp6WTJ8Om6XHtlsULwktwAPXt99YF1fsofGTmNEaCUhh4tKTVj+F3qZ9oFb1?=
 =?us-ascii?Q?z/FcuthDdU12WIwXYVwvMxNG6WzmURtpUegTos+TjWWNbaMnYligzb7vl2c0?=
 =?us-ascii?Q?r6Uqhsd0dt1ktwERR9AG462uFB8kW/1Hv5k+Gcwi0hTdhbRsHTqtKIvXYgUj?=
 =?us-ascii?Q?FSB9+tkpmmpVHY+LYNFn8dSIr1Vst4gq7u1Ha1rOf35oEChmNKgq77pkxKXq?=
 =?us-ascii?Q?HUgYQBY7dZVX1EEw4/IxBNozHrQqwTrc/nJBt2W3ZLkjN2XHnVvgjqcadwIA?=
 =?us-ascii?Q?X+ky1bqzIX9lP/hzL3fJ5So3i4WxtyInDSNChzr8GsmzLiQdcimgkDJJ7cKQ?=
 =?us-ascii?Q?CZcq/QxkPDGnxo3li4DFB3O9rQpxq5leEuqeD0CTEF4e1c/kn4Typ1LytjJj?=
 =?us-ascii?Q?K2SUS4ir6hW4CyxoLhICETUyNQhSYIv1GYWLHrFcm0o7T9Np7rDLXBmzuofO?=
 =?us-ascii?Q?ruXu9Uso86RVp9uAvlek53UIG8D8st7PvuGhasO3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf98dff-00e3-4a71-ed25-08dc54e4b81b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:20:49.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlBnfYHxaCCNhauvVYgAo+Z5YVTUNVOmgTkrtOinWDkMiCcDKOWXY7bOPW5TlX8QDx8ZfecVZdcgEENleZk8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6800
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Jonathan Cameron wrote:
> [..]
> > > 
> > > Fix looks correct, but I am concerned it is a band-aid for a more
> > > general problem. For example, if I am not mistaken, we have a similar
> > > bug in cxl_mem_get_poison().
> > > 
> > > So perhaps a convention to always define @mbox_cmd immediately before
> > > cxl_internal_send_cmd() like this:
> > 
> > Makes sense to me.  These aren't hot paths, so safe code is worth the
> > possible extra writes.
> 
> Yeah, the before and after size wise is small:
> 
>    text	   data	    bss	    dec	    hex	filename
>   15407	   2129	     49	  17585	   44b1	drivers/cxl/core/mbox.o
> 
>    text	   data	    bss	    dec	    hex	filename
>   15461	   2129	     49	  17639	   44e7	drivers/cxl/core/mbox.o
> 
> ...which I think is worth the peace of mind, and it matches what is
> currently done in cxl_xfer_log()
> 
> I will send a follow on with this since this patch is already in
> cxl-fixes.

Thanks Dan.
Ira

