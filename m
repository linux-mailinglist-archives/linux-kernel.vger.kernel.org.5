Return-Path: <linux-kernel+bounces-137664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377789E59E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1072B1C21FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679E158D88;
	Tue,  9 Apr 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2d8yH6K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDC12BE9C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701427; cv=fail; b=I/x40k/7A71hxWDMXu9IlTIhN/Fvm+dn5ije9K3E7RiEydOg10ohhOgXpUajgpv1Drf2gn8B3kWzpA4sekC4q8qLpAANqvIVfkFAjRR/3wNy03OqRVq+YEm9zAQsastnJMBdzf0BELyCZftuZywcruSjZY7/7YHa8Tf7GakLFTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701427; c=relaxed/simple;
	bh=J64MVewDWKPMwxFvvALMvn6te9lgrsM631ven2wS87A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Myntr9asnkfPN0e/pWjmxzNTpYVGlzE9IHkdcidMW5kTYMU3BMAsl+5a+XFnn7cZhfI1R096F3fvA2C9Wsx1EsAEPjWSX7CDkQErYXtpsqqcAheivmhsI7mZLEadn3i6zDTRo6PlrnzCdjMxSIe7+luWuX8RSwLc6u134kvcSYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2d8yH6K; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712701425; x=1744237425;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J64MVewDWKPMwxFvvALMvn6te9lgrsM631ven2wS87A=;
  b=T2d8yH6KJX32X6uZB1eArhuxnxphkdrcFO+2hKOFZ0romXRUj/rUZmuP
   nqowgZ1z+ugOWjsu0MjnCT7t94NfhNbeF+mGOXJV9hdEH6QF8NGeYjnd/
   iW1vacDcHV2hXZ7aIJrEDVYjorKQ0Tfo1euk1nceRzL2k0oRf2VlUBIgR
   xIZZSDUfc998bp0OZij3UI7K90WxBqkzjeLEw0qRHfTKwFc5T5hpjKPLR
   5uoO9pjLx3B9VPl2Xy+bO5dBXssBdLsfW67D6SOyJjKmzcMnXZ+R4FXEC
   ZQEpLt3lJQbbCbfOxw/uWGE/9JjY2RqXqfvW5wjN672uezlsB90chuWli
   Q==;
X-CSE-ConnectionGUID: dO6dDAjdTmq5ofcTX8b5Cg==
X-CSE-MsgGUID: x8cM+9acSD2imo8EOkDt6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18648400"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18648400"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 15:23:42 -0700
X-CSE-ConnectionGUID: Q8tSaRdEThmBZQRoQBiJvg==
X-CSE-MsgGUID: 3QruoJtIQae+O3L9Q5VVfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51332917"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 15:23:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:23:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 15:23:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 15:23:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 15:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ay9uKms3Y6SsH/d5HjOKoZ2uidGL6EkMVwCzOU3xSK9buWSlpyxYKm1/sdOo39xWPQ48bUTIAGV+jNpI4TjqHfwDSMb4g0llrqzpEzZ3tY3G+itx9/5vz1GivdszKVW1Hie0qWxpWbXykbM2Pk5QCg8UmYjlmob9H81LG9mTn0KKrVH3wH7CbkbKsWp/1kJ7isW124+bvmcCa2Bkfdq59HuEE3qwPsFyY2pOslCRHJhxRCnAoXD/zzKHzMA3mrf7khfm8QCeVb4MGpcn6fFcX+d9Yotkh3MASFUzjKWVMwtO2XYzVZS5Gc2JuNya3XyE0K7EH+Jw4XrkjH8w7iv+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC19CIDAGQSHYbK8q0bpq8DFt3/IxQANJxdVl4oFmq0=;
 b=aWxu4gvbWX3IT7Y0CQVizKpXRcb4fl1FWXSk0iAWVchtbZqEdExduJmAj5bsvJAD4yNO1LHmy9dC8qiUBeJDtCeicxmKU6v1wVzZQXrcV0QkrH4AGp+lYpYfx47JcCQhi46Y4KHzeYsWtI4MjHXsd+M2bRxi9ritriOGXIVqCa4IvBPS+obAaWDW7LtfFLSXJw2wDBXqHapLGPblro/+CnYIQ65La8E19XSmY/ApzNCnDG4eW5pA1yvfb3VwaEgaCJQh9Vi9iEh8e2y2tOadzHA5gugFNJyNasqUlY4aZdAB6cki3cjh9AmfQpGwSKhRJ2Di4InNrUNVGM7sPQFSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 22:23:39 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::7607:bd60:9638:7189%4]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 22:23:39 +0000
Date: Tue, 9 Apr 2024 18:23:33 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>, "Mukesh
 Ojha" <quic_mojha@quicinc.com>, Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v4 1/2] devcoredump: Add dev_coredump_put()
Message-ID: <ZhW_5Yctai75qvT2@intel.com>
References: <20240409200206.108452-1-jose.souza@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409200206.108452-1-jose.souza@intel.com>
X-ClientProxiedBy: SJ0PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::22) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH7PR11MB7098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6delC17Q7JbsUvyc1KWeq4tk+AepFr0lM2T3pO6DvAmwfsaS13QRWQ7Gdo4u4Cqe1f4bhIZCF73nuSk76s9EPs/u6gEE4l89HoGJW0upeW6TfP8m4fUKN2BHdsgI2ZwtOdlOye636/9zl54+mbVw+K9/2w8JtrFzcbg0Kiw6wr/5tR4MnJh1T4zCq5fHzLsCifPGBTXP1j9zc6zNSKAQlY0dvaFtwrHuyY7+kHY96ZOREI66XsfVPfSvGYYeRD7VNeB6ctFTiT2RtUHO0tIMhRe62Q2Rx+VJQVAdJoFQ2RLsC7tjguEGgmEXB/YWDcYeno5KmbQXWdTQgSxco2aY8f8+G2wIAKWdasWA5bs20qgqQog90WfYX+lZA+gGlZUCqlUHLdZdViymNya4yC1nFvVka/weuDY/1APidVmu1lg8pWE04TGsnG6e5XHG6OGiMUWQ0vT96HdBichklfz98kFfnLhP+Zn3/iZ+g0RxjoZlWD5pKZBFLmmgAfqGpz2ORQse/P1Gck6AjwFE2drjdqTcmc/tEkmgLLQpZENLg0ytpH4oeohWLTawqzp4tYGfeZ4TKmUaUr9AvY1dggbi4mB9o46/bk6p7CySKVDTAbtXxx3J+Yh5cJkaEoT2zGjASYqAF37VvJOozJOKwqotZF/0fT7jXg7kvhuPjpjppmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bVqy1OZ51i/BXEZyZXwmn3VSFBjR+V5MQTsb4cRbQGaUpB9JH0xamy350z?=
 =?iso-8859-1?Q?719JzcyQwvoq2N5qdtKR36HF5m4f861yhyBfC9gBr8LV3xGFxoowQGvCNC?=
 =?iso-8859-1?Q?Yk7EoC35GwuYD+32uorSzQ1ukD5oeg7LwkQOXZ+fnt4dhaaaV5ltPiV3xI?=
 =?iso-8859-1?Q?mFsRA24y6JIgOr1BrNAOLIjvuOilDjAyItCyXDhUAegL25s/LIhKnuwxSR?=
 =?iso-8859-1?Q?lT84ITBh+snDzGYoUs2fwG4NHpFRkmjkD6ryJGw4N98woj2oh3tX07Ojbv?=
 =?iso-8859-1?Q?+oLJmgVTaOKNzHTaeZeXg0439XljS+sEiHDofbtIiQQJbnkyKTfGEtgHXi?=
 =?iso-8859-1?Q?db0PI5LdZMPUIASqw1HJuaIjPzCjCs0c8KVPwCuZVffC413Opm9jrzC9pY?=
 =?iso-8859-1?Q?X3H7x5wCtp7OC7swUSxwb6fNWwdwi47vaw2m26dbvVuvbAjHRkLG8SH+nD?=
 =?iso-8859-1?Q?zamsJfYBg/Fpo45W6TdCH4xc4b0aqI5VfGpVgf2hlCuc0lkoLqZkNivCV0?=
 =?iso-8859-1?Q?qrD8JJz65Nbi7GcFTrZRF668BYPemP/CgB+WyJoqCZ9rBFRFgsVnhVjsux?=
 =?iso-8859-1?Q?E03nTCb3WiEjxvqFzbaAlGJlAYwy8hiz02TJQ6UmR6XIirbf8dxpWMdIfP?=
 =?iso-8859-1?Q?zDph227QBR0B8eOD+a2ebndGYn4eX9y9RaRRfgyIYLBcx7+BnM4JfoQJ9S?=
 =?iso-8859-1?Q?opUe2nnZqlWXP5b5So++PKlXfE8gK+EYGs75Fq6zHY7/KJYDdGYDhH7fDK?=
 =?iso-8859-1?Q?8wwehLU3ysAKP1RyqLeyktpyEfc9X6dgI9e0W+dd0AYnXwu9MlUeTXetbi?=
 =?iso-8859-1?Q?q0j4G2MJcKEiRCTB4buugWgH5mQJFOmSooS2jCWOI4LIHZvcwHQYEoIrfC?=
 =?iso-8859-1?Q?gs2SFyskoqkSluJ/QdbKFHUEkREymzbZSNYSx8JD84CAVWazIefOLOlvEJ?=
 =?iso-8859-1?Q?XKRCwcmSUFqzPieC7qSTSepuF76TVLRgh4rMPMLr2FAw5WO9uEUPuFf55Y?=
 =?iso-8859-1?Q?WmriBPA0JXPHY846tRkddTS0FNQK5CMHbAJjVoAEg939nciVdyvhVO3ymZ?=
 =?iso-8859-1?Q?EJXhHn0muMCPveJN6iK6R9Xen+UcJi0JgJwvkRTd2DSw/XHiTYYLq0GjUd?=
 =?iso-8859-1?Q?n0LdP7OUevDDYz6X509QSjx6UXE26C7e1/jwqvPeRdUZ0/UkOcG/dYOuz0?=
 =?iso-8859-1?Q?dDTbXMci+eRV9e1dUaU7EgtrBb5lEsNhm5lxwLJM6DR9q0vKJT910ZD+mK?=
 =?iso-8859-1?Q?TxbjT4LOO9rn7QX3Ho++5wraLx1U/1rTp2I8N83E74Ide+yJdmQlymiqTk?=
 =?iso-8859-1?Q?zHoOTchUdVHTJi9uKPPrDRLYesPLkelFtIYq1qmaoc+e2b0VE6QsOP9bhf?=
 =?iso-8859-1?Q?V8yKc5/OXZCEScz3XZn0thTV5P5745/EeBdqrlx5J4IlHV8FqTFtRcQ76W?=
 =?iso-8859-1?Q?fOpk4UGuca+RIc8WRUouBOjgPs1g+A0R6S8iVfVt3+jJsrFZKvc84maK0Y?=
 =?iso-8859-1?Q?SX6Qjx0eVmS70efWKCr+p1mtXYDiUOG6eayhv3HD7cJPYz73bLQ6VO+S9+?=
 =?iso-8859-1?Q?86MQhNvvcaaiC31YbXUzEdP4mgZVHfQ6e1mWgowrdc2p4yjtQxW6LTRM7h?=
 =?iso-8859-1?Q?uPJavHzJJygk5+8roqEVwK/1DhEqpLNRqcq3r2PI+eE82bmw9cKN2sEw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b344d4-9339-40e9-6c37-08dc58e3b47c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 22:23:39.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKlMdxoO8KIaKKdvRZo0HG6fPeGdeICiTZaGUIGBCfB9azm2ytjqhHyWpTOkNdGHm+pFWk9c0d84HwzLPHRAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

On Tue, Apr 09, 2024 at 01:02:05PM -0700, José Roberto de Souza wrote:
> It is useful for modules that do not want to keep coredump available
> after its unload.
> Otherwise, the coredump would only be removed after DEVCD_TIMEOUT
> seconds.
> 
> v2:
> - dev_coredump_put() documentation updated (Mukesh)
> 
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>

Greg, can I have you ack to merge this through the drm-next?

> ---
>  drivers/base/devcoredump.c  | 23 +++++++++++++++++++++++
>  include/linux/devcoredump.h |  5 +++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 7e2d1f0d903a6..82aeb09b3d1b5 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -304,6 +304,29 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
>  				  offset);
>  }
>  
> +/**
> + * dev_coredump_put - remove device coredump
> + * @dev: the struct device for the crashed device
> + *
> + * dev_coredump_put() removes coredump, if exists, for a given device from
> + * the file system and free its associated data otherwise, does nothing.
> + *
> + * It is useful for modules that do not want to keep coredump
> + * available after its unload.
> + */
> +void dev_coredump_put(struct device *dev)
> +{
> +	struct device *existing;
> +
> +	existing = class_find_device(&devcd_class, NULL, dev,
> +				     devcd_match_failing);
> +	if (existing) {
> +		devcd_free(existing, NULL);
> +		put_device(existing);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dev_coredump_put);
> +
>  /**
>   * dev_coredumpm - create device coredump with read/free methods
>   * @dev: the struct device for the crashed device
> diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
> index c008169ed2c6f..c8f7eb6cc1915 100644
> --- a/include/linux/devcoredump.h
> +++ b/include/linux/devcoredump.h
> @@ -63,6 +63,8 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  
>  void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>  		    size_t datalen, gfp_t gfp);
> +
> +void dev_coredump_put(struct device *dev);
>  #else
>  static inline void dev_coredumpv(struct device *dev, void *data,
>  				 size_t datalen, gfp_t gfp)
> @@ -85,6 +87,9 @@ static inline void dev_coredumpsg(struct device *dev, struct scatterlist *table,
>  {
>  	_devcd_free_sgtable(table);
>  }
> +static inline void dev_coredump_put(struct device *dev)
> +{
> +}
>  #endif /* CONFIG_DEV_COREDUMP */
>  
>  #endif /* __DEVCOREDUMP_H */
> -- 
> 2.44.0
> 

