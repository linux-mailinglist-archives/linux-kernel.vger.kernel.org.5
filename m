Return-Path: <linux-kernel+bounces-128349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDA89599E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA7A1C21D90
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF29114B06D;
	Tue,  2 Apr 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vj+Ut6wP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B614AD2F;
	Tue,  2 Apr 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075002; cv=fail; b=dUuoUR5M5vJl6jnuzM1JI9b+70rMXuVKUoDdKaQuBzyLSnIrUR3nxf/s0ijqJEAto7OhBA0BUU8EzqEPIv+YDVzDkeOlMrnP95s1GBSxnGovluE5m6vNQiXC+d5vczGrP2F++ssGR7i5rZJYPkPX/+K5IMYDrSQlXeGbgJT2VDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075002; c=relaxed/simple;
	bh=cyK9cUO2MsPHqtI3nAvCsNh5XthWTBz3rN4S5qefVVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LTM2aMpfIoF0rZmOiFYzN6tEJxuwF1xYoFjObLCzy3le3bL+goX6w4HuThJfVabQIKoYvrUrVLnThDM7o8bmFXeVilWrlCkJ3jc9NhRtqTI4tJvzg+fqUn4aNuxJ2c6ulGHAvaAWAQYbnABW/CRH1JoDCAYTBB3/tSN/bjT12/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vj+Ut6wP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712075001; x=1743611001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cyK9cUO2MsPHqtI3nAvCsNh5XthWTBz3rN4S5qefVVw=;
  b=Vj+Ut6wPzZNOL5+gggU3JTlOR/K6xmMe+36D9w/yiS8IOBe2aAhPhnW8
   B4CNplwhfwmYy9wk6u9E7QaQS1ewoCgeIomtbby5C75V2svkjjr70aeID
   bg9i/GRsG6n35q2UTFB2XwX9hbzxmsoKmuudoSGc4b4byU82y67Ycktlo
   gtajq6YpGCkuyUYErUmIOSoT3LhC3G2GOOhrSuUHV6VI+Zw7KvfTdIpma
   3bjU2611exTH9yX0orDn2Z5n1uaqISZHyw5eLBt4944kGGyPEJDQ1/bnZ
   hnXK2nBqS4LurX0bLyukmW8uZDWi4ZdAPmRduPsZKjLOZAbEQ8GDeQ75v
   w==;
X-CSE-ConnectionGUID: C/FA4xBxSZCxLZBvD+kd4g==
X-CSE-MsgGUID: awWYsP0iRp+FhqWqfSS3vQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18621475"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18621475"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:23:19 -0700
X-CSE-ConnectionGUID: csowpM/bSG6bxyUTIHljhw==
X-CSE-MsgGUID: RfQbJjzhTzyIymm7VeEzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22828973"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 09:23:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 09:23:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 09:23:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 09:23:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 09:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKZ/auxaHZmz2s7pxZizW8K3AGz57eE0FZdDxKBbhf93fU3S5tncFBQYwHnB+7IklbPzLPUYv269xA3C0l8m9luHLqbM/a0dfmFfJAxZugre59WI1JPtTxkpZ/0/pFSgKMTcTtOStiP92TLCRLF7l5do2gdxZ1fT6OD/FA4/UnONO2sVBFXFS5IIQHiRYXDaWPsMyzNCE/nae77bm/BkAKPbR61YJ+AatKrA6jgGseSjJKLyATc/jhQA7My4aeo00X3LX/BzYE/ytTQkg0zGjSJdUw8FxZ8V6/lsVcunq4Els61uU/eAv6ZHqDZZB6jp7I9mvEIv/tOMJm2cFLZBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpA32W4etDdXVbQMRcRPLqBOBg/6MQLvK+PjowQLfxc=;
 b=ZOiFHWL8ur1fmNQrJDLsxmP3XVyV/i28yY4UL4NFQJUnFeakCLBamwHO72bL1MlHt969MqPH0eQ0LMVhW9T34c10FOW62rYhgm9iPktvExRQp0Jz9Ow38EYkLib1Ust+DoBnu24/ETX6VO/PnHeoQ6dmwcQ848l7RpT6AITOnYeJyw6ZSLaVcLTvpzM0oLrDeNXLL4Na8jwXTAIOXsOMW313668otrIFdbr6CYMj27ODFuNGen0C+ap/v3z48MqrHxJvgWCr6/L5UopqPNgNj2nV9K+VX5XfddXmY5fq2yOE3q/KwzWqQdCu7rEkQaWhX+om05DwwSwpsQT8efSalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.21; Tue, 2 Apr
 2024 16:23:15 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 16:23:15 +0000
Date: Tue, 2 Apr 2024 17:21:18 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] crypto: qat - Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <ZgwwfrrnFhG9jmo0@gcabiddu-mobl.ger.corp.intel.com>
References: <ZgHiR7j2NYl5M4mW@neat>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZgHiR7j2NYl5M4mW@neat>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU2PR04CA0306.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::11) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SA2PR11MB5180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucNO/2O+JPZ1oGlic+RsQsSKmn3wCk3LoZkfZVA9HIJuQ1BtkrQ/7n1qpWO7H7yjtZsgVfoXuYNvcusesyjL2JIFc1QoruCO2rrJoRUk4413PLcfDXrVKqlMoad98EtnfBV8C2O5h5MrY0/kIiI17foGa78IE9tIblIj8Bx/51Kw89bWtqgzBylsd16kXIJq+/JSgkI4CFpvptUEPyo3VfaiXcvrSV6ekknsenCnkRWJU+Y7hGNG48KBYgSJdSr85dZhGLpnRgudmjVotSJwjNHYBXaaxBtKsdfOe0MHn4c/RefcWCe55ThbJiyttXLl4+JWiXuuD7P3dkQJYoooXLlr9deggagUzlp+gfr7hGCiOHrvRSlDFkJRo4VUbQmTHNboCP1a30FbkEjpIkW3/clvR3MrfEoq6Fa+bD96v+donMsBJC5ZccB17JDyv7bfuywjIE+gL0zwfgYZNotlKvJaNm2Syfu8qVOLrj6dVsVaxPAxcgyxl7WfInDtVAA81DW7pQ4Dlg65uzMEPp6KZjy97xLlLuKlMP1lW9uhl11FwJ8p9yTAlsBRngY2pEubqpsXnnJ5tFurjfAXHRqAjYKb8sdlDT5kUGYbhWqQaWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXkMCBGP/55nlm0Em2s6T1p6Z8HS/F+o+DgO8z40qN4LISoUC5JTVFCUFikY?=
 =?us-ascii?Q?73rKrzyanbSDJiU3PFjsnANdjb3zsD76HIE1zs8EF0t/Hmq6zNLKKUH+i36I?=
 =?us-ascii?Q?xcZ3Ci4YTZ8k2NkAXOGwPfnJKrs3NlgO+Wb3Wz/Z1hGQdFkjoVKWn+u+pyaB?=
 =?us-ascii?Q?y2OkzOBBV7Uh5YEqxRv1RXqUe5gKtoA6JKCHDHh2HKTaM+m2e8KtiF2U5hS8?=
 =?us-ascii?Q?spcoWXRJ7wlomoGXv5jrp7nqPYwu/WJ2BC+LufNaovye8r/c5Sg6qAxa8ulF?=
 =?us-ascii?Q?H3ltL7JPQ0AjkVE2wsHdgGmiBywiXB26V4JhcOIyZ2Zd69HLMjTIXAAOhFta?=
 =?us-ascii?Q?hsCokeE/x9MH/vRuRi/kOpZ1hfX4Sj/ROj+aOpDDVK1QJQiIeDoctryuEvoS?=
 =?us-ascii?Q?9N1www+BIs9SyeLmZqSOOQW7DDb4wJjEFMrM5Hd2f0a6R7RRf3H4/9Wb6riA?=
 =?us-ascii?Q?jLfB0mMDt/RdLPpfUtY2t1USazzhQMJDT1AImpCH6monwvCK3XXJrAA7N4m5?=
 =?us-ascii?Q?JuIHkGxjDUCTBgWwZd1k0/3+aq35ZIfHRmI3vcNRjoZIQIAtuhljgPpgt+SK?=
 =?us-ascii?Q?vEtERYcvavTv6OBAtP7HUp6IjbKZMxEzcbMmFz377kLYpQDhRyGfNZParjRQ?=
 =?us-ascii?Q?20pol0hb82XNZjo1peage247SI6P09nECDOq7W8J70lcd3GUIQXAqMeVY8Dn?=
 =?us-ascii?Q?qDkksXPnLPjmLpnshKKDUyWvk87OBLKoXGngyrRimvcj9aw4Q9C9rBkAYB+n?=
 =?us-ascii?Q?YYk++0tdc2fKFT9CHuZPc+buT2WxcIt/yotLIUaTXGTSyIaNxjeiX/96olP9?=
 =?us-ascii?Q?/I7gon4gMKE5vj+i2VldWxrsUvLhr3+AZjnmuydL506aAXLlFxA7sjAvJ+dQ?=
 =?us-ascii?Q?trQ2+YxcR6eHoDWAfXYJyVDeiveftcilQF2/+UUPbqi1U5ybTHmAk55Qum1k?=
 =?us-ascii?Q?ah6cEZnx9hyFNdSR6nv50+W+ADMlE4unNawYcs7rdF9YzrqZa5VoxjIAOeAD?=
 =?us-ascii?Q?ccOp94bzO8WlL6E0CFSEZZIO0qsNSSQqUacViB0sgatg+XRKo86Twm+N1J4S?=
 =?us-ascii?Q?/fbhh0FLUzyRmh5aZu9CUJukvBv4sL+Ug4ZqxKyub9w6mDIAOd8Pmn53CwN3?=
 =?us-ascii?Q?rTL7sqll7BjgbxdGyeyZCBl2oMDdkS8M+goSwSlzsReGfAhXSIgMWtKPVwFx?=
 =?us-ascii?Q?B/gpE5h+fsi0jl+fq+132QLsdEMPtaeKtr6B3uDmogpnJJlHvTwD87bR/NZJ?=
 =?us-ascii?Q?QJs2E6AZwOXADsIHVslqNH9V8CQIMlycB2z5MGyBwpbnwW7igRE9ckdahZDC?=
 =?us-ascii?Q?7M14YAyhGqY3ZkhZk4FP/oBhPEFQ++TMwd/8oJCzjSEf1MXkWBl6/FKbxrTz?=
 =?us-ascii?Q?uoW8RsnTv5TNB2d4K7PeplD6302Oum7BOKzHE8Dca1qWo6GBQF4Cf8NB5wcP?=
 =?us-ascii?Q?O+e4r1L8jLLC/Hwk0euWk2cwOIyjKOvHwISfERJm3IHqSEFVlIz4ATsbrviu?=
 =?us-ascii?Q?XaGFCIQqkinfgkJFsCV8vgN4s1Kbw07bYS38IIdPe4mcDNjaXItCdZPETG9J?=
 =?us-ascii?Q?6na1bAnvdjYgNXDRmWwSEpZaIK8qSZYubp5jAyjygUqALPmcSedodIqF9lJl?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dde7f7-3575-4cdc-8449-08dc533132d5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:23:15.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9uBcSw/Y1RAqfLyYPG8HVZCrlf4chxeRV5SmJCGSCyVeepBY0Muj8aUT4WI0J+YYWdC7NkXQt/ZUPhiGrRpqvNisYXbALamGqgEjwDh6Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com

On Mon, Mar 25, 2024 at 02:44:55PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
> 
> Use the `__struct_group()` helper to separate the flexible array
> from the rest of the members in flexible `struct qat_alg_buf_list`,
> through tagged `struct qat_alg_buf_list_hdr`, and avoid embedding the
> flexible-array member in the middle of `struct qat_alg_fixed_buf_list`.
> 
> Also, use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure.
> 
> So, with these changes, fix the following warnings:
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/crypto/intel/qat/qat_common/qat_bl.h:25:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

-- 
Giovanni

