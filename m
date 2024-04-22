Return-Path: <linux-kernel+bounces-154178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04898AD8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB7C1C2137C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E84776F;
	Mon, 22 Apr 2024 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvVLXgNI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF546B83;
	Mon, 22 Apr 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827036; cv=fail; b=ZZzB2WbcxtMtWAtCoLmAjbLO3sLVcHtSR3RvGzsUrR6EmTaOrNGmvvJK2iF7UIvGEl1ou0PTNAhs+jSaY/79ioK4C3XcrR0oWA+pT1CmCT4SKvL4vAGl06kZpn7BAZrU/EH0FeFE5ZhLPB2GvM6Doc9oLBWHsjBfsudRo+2XSwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827036; c=relaxed/simple;
	bh=7LhgiWsoI6kH21ROirULbIMD8RcUCHUD1ttjrmrO9Eo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7W/sfLyQIvpNCiM9u6lVecDFcp1ArY8bDSfD4HN72JDSU3wMArgwTt5nOwh6yTJawYog1MCKEphP9sgVIbZwvwie5ltWn5gFjoDHCPGVM0+LYBr3UwYNIaFeii46CtHx5gW1BsjVTAENOCCyJvix99PJeGxU32cgJEO0Izj1sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvVLXgNI; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713827034; x=1745363034;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7LhgiWsoI6kH21ROirULbIMD8RcUCHUD1ttjrmrO9Eo=;
  b=VvVLXgNIuPnmunuRAiGCX09IifCFm/WAevr9CjwZ7mufj3T2MaVN1oSP
   +InWCtgD09RWQtcxOD0h01z31yAHiVc8EsYa2k2mUKlJRYgx8wMntylZt
   72JpXDNefOTtCiNmF9g741O6PaZJqHkpvZMW9P4D+CNlenU8DVYkVvaJ9
   43gLHK8ht4Hr3fUlhIGNemdFiSNB/Uov/1N0oB2wNWwt8eqjnJXt9/Mun
   3Rq/wW/oADyRadUUqAenxd6sT6e1uIKW0rdPIva8nlYI1uydF3ePe6c4T
   kT42sThzjyjxuAk7O+cSEDsY0N/CvhJxqdGNh9/0cNy9VH3idTGK1wYH3
   Q==;
X-CSE-ConnectionGUID: ZEf8RJa7TUOuRA+f7+v3DA==
X-CSE-MsgGUID: RyF0qzuIQ2y/1bChGZ+Xrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13222430"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="13222430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:03:54 -0700
X-CSE-ConnectionGUID: RkNDLGSLTAOepD5sNscjPA==
X-CSE-MsgGUID: djrxrXeCRTOt2zbL3IhYEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55379125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:03:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:03:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:03:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:03:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjF/W0a/WTfk+R8RQIMeYMuDsYj34w0Yh2Lhyl6wJRqCTZkrcJAfLYV0ZV2It5CvbUBwp0WL4uYo09cwjYBVafCbUMZS6iyGDqoGM8W6a8WlGMKr0F/SYtOaXVS8jRxYnuS4x/0tU01bfyy4ufwEfpS89N8YJMlSBdy07wj1APon4kPcBx9gVQE5b608dgSczAwveQLxeUF1HSYgRheoYPpOQJBKR8H53VswJ5DU4HWd5rnWC6ZdE303AYGfYm6qk5N6fL1T09jmzGn0PFhtA7ZiCTXiI9aCo8Do1oarUSI5D3YYxRoyxZ7DhaL81MWFFIFMbj/8ixOrppDKoMOtwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ/8b2/TEl+bX7Q7XngHzVQoKRcp4uxxtX73yuxDiPw=;
 b=jQPR/59TMZZEdV279QVEyRREHKB7IFgbZUEBsS3ESqIPKo7b2oJLmy6RaW6re54fun5SW0G665tLTiEr38gIUH+HJAvso9a8OEUnonZYQOYGPqQuhYkEOdXg++rc/k8I/v3or79O3lKUt4QDWHSR5+8FMN/Xh6GdiivzOUqxrt99hyWmWQtTwa5zYxOPCo1cLJPWPlQg6rbH22KRfTCvMdW/cph+qKnumsGQeXyUqzUUJcSewmI5pOJC3p81DR1Q3ZMa5374oJKqmwZ4SmPyjm1950XLFaCi/rp0UD5U3s5uw3/pxmKHPVB67cJun2NST0BraZVaILpxUmcroGhJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 23:03:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Mon, 22 Apr 2024
 23:03:22 +0000
Date: Mon, 22 Apr 2024 16:03:21 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Terry Bowman <Terry.Bowman@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] PCI/RCEC: Introduce pcie_walk_rcec_all()
Message-ID: <6626ecb93f752_690a29483@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240313083602.239201-1-ming4.li@intel.com>
 <20240313083602.239201-2-ming4.li@intel.com>
 <d69c2157-a0da-4d8c-8684-d42afd285191@amd.com>
 <661e00eb808e4_4d56129429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <84eb39a1-60dd-40cb-8c7c-dfd9a988732d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <84eb39a1-60dd-40cb-8c7c-dfd9a988732d@amd.com>
X-ClientProxiedBy: SJ0PR05CA0167.namprd05.prod.outlook.com
 (2603:10b6:a03:339::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: a383392e-730e-4f24-dc4d-08dc632068be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HlXaYJ3XMiy/DjX6d2ywXgX7ri6wP1v7oDmPsnODCvef+lcpXo3BidprU8Lu?=
 =?us-ascii?Q?3ydqhiKJr2H/Y2MXUPE+YLJqlb1uUWoMsJ7OILqtowcMppWeCsoQDXN69TDH?=
 =?us-ascii?Q?dfFUZKeB1nuvli6ko/ZwGhgZUkR+iL2eN/GJ1Nk3eU144gsVMZVPSGFUhNR9?=
 =?us-ascii?Q?uDnOyPDXpjShK3pSyXrITxD1RtZa+ZjWtWbW3G92fohNYcfC42WoVkPOEjnj?=
 =?us-ascii?Q?MRkC1eXIKv0wERnZrzIIbno5AeBJKMqut68BS+LD/Q99ces4YO8UYfHQ1APs?=
 =?us-ascii?Q?ZMQKUL5nJcGN4nZy7pNIXGqsjXDnYfFhFypc7IymsvG9CXj4SwCd3zY+mysd?=
 =?us-ascii?Q?7NRXlIvRqtoJZX0GofbqEBucUqBHGad0DxKcB92FBKSeUNPFKQNWGQgvzNG8?=
 =?us-ascii?Q?Bkp+Za7Hjy9AANCte/RFVamCPhxP0pIfWihOlDSOfaVT5GF1ThUViT/wROZc?=
 =?us-ascii?Q?THN4FEZwdm6qVDtJX9TZ7SWfVLOVuQvdcOQjLMPMlpWQYYdgOxvhqOK3bBUw?=
 =?us-ascii?Q?6GJK5s1o4LSEZ0wGlMW5gLAdvLUeJzSlZiNYXSBKymW481gTV1jDBUDUMGE6?=
 =?us-ascii?Q?np0mKUivsO9yPlPkoPEf2vVLZsNS59X4iNUkY+S4NINf0qFLuQEjMdxGHege?=
 =?us-ascii?Q?9C59K3GNC/4tDbaal9Oo0qT6p5dJIsg/C8BnbIG9RzO/pdOuUxylszFXfJFr?=
 =?us-ascii?Q?4ZB036LAcagvBUEAlzejtMxMNrUz+FqGi2/z0sc4je935EBIKbmsAHisLWfw?=
 =?us-ascii?Q?8JwnBeysYjUxQZOmrwgTaoQXC9d4ZNExjNnc8lgWrsyDpSDWHxcfD5POq7MS?=
 =?us-ascii?Q?TCjKjbzM1xSHZiwvDR+cXZi8vPXef9+Nxg9JpJZXLXytYvzhYo9rbDs4W4xP?=
 =?us-ascii?Q?t/tRKo1xHAttGftp4+8EZoucCzDL27E/xWiZX753VWqZwm7G8XjJpPbp+Zs2?=
 =?us-ascii?Q?SrVV4yYGipGj4uRQcrumYhICP+XOHbyClS08COyC613ht6+SsHOOn8XTFh9s?=
 =?us-ascii?Q?6alh5JyzvO7SdgTVqIl6QkErsTotDbcOI85cu3Fi7cWoyFffrfJuekCum5vP?=
 =?us-ascii?Q?7i3ZKkUhJaULRj3X8Xo+GzCT8VdQ2rsPiKl6xAjwmaRhyiasx+/TMkprYh6N?=
 =?us-ascii?Q?EEmeu+0/4FE28CyCQ8f9xLkb/5AAxgbMY4Mk7Gj6mwwS9k/X7notzIdIWyKw?=
 =?us-ascii?Q?4Z0Sw8oE/G2Gdb994SGjo3psX/JttS9u0Juet25GydXEwYgcGSVzeBsyDcdj?=
 =?us-ascii?Q?pIpYERgyHEvK+3T5EuG4TfVMqjkydR+/TsLCpwOoYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ez0ing11tpLyacToxONX4CUg0R0nGJAIL+HnlcD71eNC/HcwgfCnUWZGcZlO?=
 =?us-ascii?Q?ym+2pmQKGLejLWf1D4zwN8WZAK3WU1lzibFW5UxT6qtiQQvKexy2kaD/4klD?=
 =?us-ascii?Q?ZdN6Amyy+iLOk467tU01L+D3AVIEfr1egJAua+91mrYI6AjiRxqGgj32wehl?=
 =?us-ascii?Q?tLRaKIwy8GXUauulqdTMtH/OgULxR7BHqg00+Lufq1Filwq0Wtv4NyANsphx?=
 =?us-ascii?Q?N/2FpMAgEV9E6+J1srlB/K1z+MLJgc05uXq3kfseShggaBsuDwIfTTKyZuOk?=
 =?us-ascii?Q?u8f78CizxXNcmlZm2LT8uZL/jEd5Kj2x/b+3xHCp9iSe1nnzDvE4xS+PKXot?=
 =?us-ascii?Q?BLtqLOnxyf5e2DOUB3DpyNo9ts5z1AuVMxj5LZZrEpsc/p4W566H88+TmLGm?=
 =?us-ascii?Q?x5PDkKuuNRekK+v5+X1kfE/EquPckk6oNJoNQPqb5SdlEvVwS5n8l3mzyPB0?=
 =?us-ascii?Q?GzX9RMtQYnUqy3M7DfgVR2RsJ3Al9T8PtcEdKhJJENG8e/fEsdci0hTYQlgh?=
 =?us-ascii?Q?JGWfLxiBRmbeiL+WqUTVxLqVx1dGEQPur52hTOj3InNlaGBEoi0EC8TGIrDH?=
 =?us-ascii?Q?KKbnQluZsgKGmAsHIfFFge3htOsFqZMBOZYjmYIg7IlxCuj3bcQBrZoQzcqV?=
 =?us-ascii?Q?SLhWlLqvFCrvBS2ZGH8ly9HF8yWUJwvbCQ/JvIE/NJP8jRg5BuG5RYrxjCJ6?=
 =?us-ascii?Q?h4xKaTp0ASQswB1h+DU0sXQzSk+SVr5gmIDT3ug9YbintM0Igk9OELKUYq3W?=
 =?us-ascii?Q?2f6YHA0ZayWwq3E2+Lu3Wncu6rp+G8CMPQHqR18/PbsF8BcE91lo1GCV4YoD?=
 =?us-ascii?Q?Y/dJpIM7toMnh/OWURpqrWsLCHOs1I9y4i7BEvJ6tS86PDlpD5ogLdV54iiy?=
 =?us-ascii?Q?p8qddwXrVzbCt2BbaWNsGpbcBYCwdbWFRlJGVTVjiFPmX77hpJpk6wtc9Gzk?=
 =?us-ascii?Q?WKcxYrErmSVhijxvYui85tV/XvHFXnTN8n5bL4VzewHykGo6QzYYRCfTglXL?=
 =?us-ascii?Q?9W08Rts71NTfm053RbpfHKHqPU6gdNFWJeaHXggbureNL8k7UYUON2qUWdxl?=
 =?us-ascii?Q?I1HkuH1owDu7NouYKeK4JpTJ3aAeVXhEyvFFhOuEQEgZpjI7RiBzR13csrL3?=
 =?us-ascii?Q?mTf/u2S3Cubjc19PpzoTM/s7WIysbDpdbaK0l9L5iRqb3jliWTZegPabQIXg?=
 =?us-ascii?Q?CwNlh58XZCCK3OF8EL04vCBUGJrbpAe1HHKHp8CrHzRHK4srh+W/F5X072rV?=
 =?us-ascii?Q?B3y9ng6gdQUFM1XjC5AueEdRwK6V5uvwYppwCjxa25OrsVtfsz8saNBtPAKE?=
 =?us-ascii?Q?C01iyo7hk4OvXzP1ceiAY1qy64Ub98QUABMd6ba3Mh+WSwmNfl7vrZ5uZPLg?=
 =?us-ascii?Q?EZAVw3bAt+iK/uU1ubRhy4p9/B7jArx2EKCyg45b7qDOMftEdbL/wlm7Yq1i?=
 =?us-ascii?Q?pLRDeCtNmcP1Bh90e5jOPA0oMeuudRjTJuM0d32+m/fBTvo2TEG2MXbrNibn?=
 =?us-ascii?Q?ASc9KRu4bVQa7RLIcpcAIwxypBDAIQ8ZuHpBOEmNBcqvRyCnxplVHeSGNdKl?=
 =?us-ascii?Q?WvSyrHgWDapX6J7Q1BE2K1/rO9pfaZdZ9O/KqkpxNHRvFeD9eQcMJ6wH7uUA?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a383392e-730e-4f24-dc4d-08dc632068be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:03:22.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nU1JltS/+LTiBb4gzAzSCYhySJi98stZn7RpU19s+LLPA3h/c3XueFDN977Fw715M0+RFUJXuiEBokHoHkaGAhM2sRcEOpFp+qxK8gXOU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com

Terry Bowman wrote:
[..]
> > Hi Terry,
> > 
> > This patchset is responding to the implications of the implementation
> > note in 9.18.1.5 RCEC Downstream Port Association Structure (RDPAS).
> > That says that CXL.io and CXL.cachemem errors in Root Ports may indeed
> > be signaled to an RCEC. Do you expect that implementation note to cause
> > any issues on platforms that do not follow that CXL spec behavior?
> > 
> > My expectation is that it may just cause extra polling for errors, but
> > not cause any harm.
> 
> AMD platforms in RCH/RCD mode consume protocol errors in the RCEC's AER driver. AMD 
> platforms in VH mode consume protocol errors (including root port errors) in the 
> root port's AER driver. The exception is the VH mode host with CXL1.1 endpoint and 
> RCH downstream errors. CXL1.1 endpoint and RCH downstream errors in a VH host are 
> consumed in the RCEC.

I agree that's the most compatible path for existing software.

> I don't believe these patchset changes would affect this behavior. But, I will need 
> to test to confirm.

As I wrote to Li Ming, I think any potential conflict can further be
limited by the fact that this extra scanning is limited to CXL.cachemem,
not typical PCI AER flows.

