Return-Path: <linux-kernel+bounces-128350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0B88959A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B842849B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623014B079;
	Tue,  2 Apr 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jc9cyXyW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6D13541B;
	Tue,  2 Apr 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075059; cv=fail; b=Agltyoic/M6DdyR8+p4Ko2cGxqN3QpHXOQm34fnKS6zUxQA49w2ZMjE0DdVbZsqBKR1rYhIj3yB8FHBdGZ2GmLk/BgkVwCAvChKEYpfF+tGTlAm7ZKGaguOSGWexXpuy0YphF6Xspoh/eh8vmdZ6GUygFSN6C+0uZWW52a8q6Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075059; c=relaxed/simple;
	bh=wZm4MU3AAIAGTMsX+Q0lyoE2B6larj/Go7M1CiVdG9M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=So6Julfb8eHWU3Enkqr9DHawtLU42sR3+PmTWDxWsMBOOEt/eaCT0Nh5SH7MK7rsf3p76GLwet95Vx9cgyvyVwJgX+Qkuzb8fvS+oBrICo+7Gs+2bZ2+stQ2zOHtOrIYF8Or6RrkNmYOWTT9RXm8BEC1+u7bFBXPpwLeR4Ykt74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jc9cyXyW; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712075058; x=1743611058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wZm4MU3AAIAGTMsX+Q0lyoE2B6larj/Go7M1CiVdG9M=;
  b=jc9cyXyW+pHmrAFMsIoqSsjMbNh10gQzPCP+1mKSp8+r4YemEwIu2yCj
   xp5K0WQaeW5gT1+kCQNEjFpLF1MHbXZaEMWr6yj3fzbpuPKtN3VEo/M1U
   xlZVKjkE7R3DhKtFWttZTmdWlVvMXb/OTx4i0J4DUYw/qa7rUigaKCfmc
   yUJ//SfF2aEze9cwYanWv6fhu/lWJKXBN02G0Ol00b8fP9IhSJgpoaoEP
   gi/2Qt9EvmBKjgGCHL0yuQorNqgqGSBFf8gf4BdEulcb7OB+dhHbvHrX/
   Ri/zxHfPBHAb9f/67JA6eUO7SdAiRSj7hQeIf7j5Fwi0hpkHM3nmu1lVC
   w==;
X-CSE-ConnectionGUID: Z7Lu2og7T6+eTdcbeZZ/jw==
X-CSE-MsgGUID: PAP7VgQ7S7edhexk5j7MlA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18621700"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18621700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:24:17 -0700
X-CSE-ConnectionGUID: thby8Z+ZT+ah0DO4uKzlAA==
X-CSE-MsgGUID: NcjKvGiBQCChNLAZ4XcEuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22829584"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 09:24:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 09:24:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 09:24:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 09:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyukT9uGppB5ImEDI5ioFTlJPYFsimn4V/IA2HjU9GMYckHkW2SyR5xu/9vVZj5B7X+S5MJ3EArjN7OIuaiDpO/c9Ew1RFuWrwH3uBAU1/cSjEjGu+/7jYQRsUDXj9GsPkbSHecMqCR0k0BnsfkSQw5ip0oDAKxm3qlBGsyaz2P3Ce41FyC5KQAHj8iq2LwKjKeVOPYo0NJAW+tBVLAkKBIU2kibMteApRzQOCFUwXdy3HOl3mjk6aGA2Q2sQ4FJTLRyTFhX72mJmoVlgVbbB9TOFiVHraun308qYPTeJ5/DAZWFqSwFAd/tIK6C9e4+9ZFhgdZcmG7tQkrLLJ0xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2l/w4gDAn2FilbtRTxVH1/4LKfeNZSn+4ZI4ZlOk0g=;
 b=hI66M/GF6TvLMp/JbTH6AgAegeFawtHAwVLYrwoTxMCNPtR+xcudvwalwhylCieZW+FTc2yHUqswUtOWyuL+ntHxPGI35LgPtnXO6Qy5heZDwyRYV/JVc2ad5eet6r1hEoxYaALpokBypca35Hi7aQ7qtfb9prpHdguHnLt2oOi8mLQnGPwiAPVjfZKnQfrMxQcntCpzHOcluf3ZjOOBq8DZNmtc8TjLRJuWbToVYw7uyPjDUcARS206DQsmTAOPwEl9a1mJRkmGhrUNnrNgm4IgBoAm5yTOAvmQSHlH9tOwC/eR0SyG8oSB6IoGJyty4N+jIovOwLHfUDGUN9xvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 16:24:13 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 16:24:13 +0000
Date: Tue, 2 Apr 2024 17:24:08 +0100
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Xin Zeng <xin.zeng@intel.com>, <qat-linux@intel.com>,
	<linux-crypto@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] crypto: qat: Fix spelling mistake "Invalide" ->
 "Invalid"
Message-ID: <ZgwxKIsk+vDIUiI8@gcabiddu-mobl.ger.corp.intel.com>
References: <20240402081355.1365780-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402081355.1365780-1-colin.i.king@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DBBPR09CA0041.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::29) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MW4PR11MB5776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhlMrscUxK36+qjpmgk8i2FP9cgPTDQYMv1v+jwV2Dsb2uKzdLtvAvfS/JbZKS35pTtHovHZ1Vcw2A8UXznrpf3IbdHHQEHl8WrweVt4W2SrDSSgFFQ9yzvA9caTwLcPbYyO7bhCEL6f6xTO1dJ7a8u1fYFhD+CH/DpW/6WwtK8ZoIid2zVe8CUdIJ0L7/dKCOcmdnqdfK8ZZ2RZesD+u1UCJRov7DQyBzF4VrW75laq2mw++P51matfUDXGqtZnRJ/C6IbpYa8Zv6sThbETkjOc/PXNeWZZJoubyqJNKnECXv+QTx9eSncsLeF1OsowbNI8KRKpP0wwWmO0z0UKx7P+TXlwzTCAHeoYo7GlJeQQ41bthFze7PCG157pBj+HM2+vf7g8hEBpnyKU80+DjZeST9IJf79ZOsqlGZ7uwPP1nj9wdvgLQ+of8wtGgJkfvlEOf+UO1Z9oH6BWyXX3vkTK9hQxTuqOpJQVCwpcV17G02Vuz4ja/qH+d1aIY2dcDKiOJu3/XbtvZGKurCuk44xxqglbpOznJwN0ifvARCtve99ysYaBvYezKi4ge/CUU1BAd7OfqGnGughwQdiaPEshH+iwAWxcnCf9n34Tb0gcknQHALqiiz3yZo2gxWxXigjmZImjmQxeyqCtpgES31AdZRCgwD4lD7sYwS2viac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuXYxnztC/qEZAwPJha8jFAQpLhKJLkCYhXAVYXyTfyo5V4XkyYWo2zLToLQ?=
 =?us-ascii?Q?25+5XvklnU4fAmr9FcPbInMf9t5YViIti/zG9JV2Ff46Gc4OeXc+U3SH72yB?=
 =?us-ascii?Q?Wy79hEeU0169DTgNsQwvIr9w9I4p8c9ay8ZKRQP7cUAov0O3aQqFunYgUahR?=
 =?us-ascii?Q?7Wl2kemjUV1rT4W6FtTKOV38xjYPubbpWUSjVcUAZza2uvmbvy0jHdT2+2c+?=
 =?us-ascii?Q?ve69GfFY66YH9UskVXMrfIpceDv8D2ZhxaC9UHGlHoT0dFrVQIiXA1aLRZhP?=
 =?us-ascii?Q?K94viMEpNLh42/aJqH1RRg5nMJV1WIkMkNdd2CztTU3EFzxAeFb4mddAyxjB?=
 =?us-ascii?Q?cpEEXi+3MbcXpSdU+XS9T2ZY5EcM1gntpIRpE4XnNvldIwqmDWnRCEFyMtHh?=
 =?us-ascii?Q?YjCe5oQUCBBC6UG3eAUfXm3KpXUr2DwdeQbGE1FBBa/CC/Xbiy/oj0iQG850?=
 =?us-ascii?Q?6oqt8whzxYTHvHzj0146+rpYiwyDaxrpoGEvhnaQxJenNIvEktH7xcvCcqiR?=
 =?us-ascii?Q?eDMpl1hXimYRPoNf3By7e0Zd6nC4OMP8aDvKhXfOcy8IZAgkw5PjRKpyOSVa?=
 =?us-ascii?Q?n8EyK//sYBbEA4U9e4zvPZxafm/5bDnsfqsihQjPtnApcCTkLX/eJJrky2VL?=
 =?us-ascii?Q?eOJFZ4jY0WoP3DzZCj0NGzSBVsVy5ehYCKYqoKM44UCaM+2/okwTdq3RuEVX?=
 =?us-ascii?Q?OMY2O0VOmg7F0QF1dfmOuf59yCMzdClaXtt4zFaN5FaE3byJRpOKkRZEz4fu?=
 =?us-ascii?Q?bGI8uMu8EHZ6QCq4hsH8PRAKmTuyrRMPGbfqnfxcI+eVx7nde2IrZ8K/cmkE?=
 =?us-ascii?Q?ig9DRp/B9d9Ao063pfvyItXOWXeVkdiCzmsNFFNEbDTz/vSLbtLoeTlV7LBp?=
 =?us-ascii?Q?X1G/S+TIHRoCUhLhnr1+nzcj7dqwCBbQn1CKEQWs19tiOk5vPFMLVZRWY18o?=
 =?us-ascii?Q?JyVQ0zw/GNqsmKRTfqxeW7fv9uvEAMgO5no/3qcHnIqOy42zGSoyvqqusZBL?=
 =?us-ascii?Q?xBPDwXPRlTK8WSKhzNgLb8Flo8d3jB9KVnI3HBPiJykQCreZj/3dluJ7beSH?=
 =?us-ascii?Q?tg03mOBb83f4eVwdBpmHPISCvHgw4B0K8+HPVGP9XdMkzB3M69X9ga/C0maC?=
 =?us-ascii?Q?Sa8MrBlnKfkawwa5NR6IflOWanH4x/AT3IS4kdURjfvj8ofQzMdzVdNwYJrE?=
 =?us-ascii?Q?aZsV23Ne8LdP8i9ZyDUh4JBJy+4Tzq9CMZiFvnSz7ixT5078818vQJt9XLUA?=
 =?us-ascii?Q?vv7SVmZl0XVE4i7bLN75nb47ZSFxqq8lAMEHmDy6JIK3SxTYCNhonMK0DSIf?=
 =?us-ascii?Q?KUWYBQOeUhfykFsYxbMLRaca/IQknuB+zKEidK0ljoaJd6wlRrX7HZRBG9S0?=
 =?us-ascii?Q?3Odn341oKnwajYhpVM5SiMUgb6R68oKK1OMoySU2gzQgc841DRBBF/swCQrY?=
 =?us-ascii?Q?ndnEqkVcsjtTybXrI8cBElscW5/QhPA52oTaNLONuGMRIoxTaHy8uOgNgO1n?=
 =?us-ascii?Q?oom//SnVq+ubHWJxkblj8taz065mkf7b0J338b1FBA+Me1gDyu01H4YsPdqr?=
 =?us-ascii?Q?sWqIHStKB1Z7iUNpANOrorhdPw84T2L7BAjdxBdaJ0DLP74gwB79CsP+pBgU?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfa0ae-1f52-45a0-4b90-08dc533155b5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:24:13.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhfEiFhdFDICwZ9DvvK1w/xJPkmEjyosjuf7C23jJnnucTh/qtnUDtmqThXjvpBVp3lQpLwmwhLMk+jcL2ql+VdwFxbJtghkXIEBxyKTVf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com

On Tue, Apr 02, 2024 at 09:13:55AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

Regards,

--
Giovanni

