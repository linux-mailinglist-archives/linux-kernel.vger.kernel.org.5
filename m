Return-Path: <linux-kernel+bounces-133569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C089A5CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEBB22A59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63C5174EF3;
	Fri,  5 Apr 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8uzXOi9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04C1327FD;
	Fri,  5 Apr 2024 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349694; cv=fail; b=rA/LPzE5Yx6ll+vRwokQ77gDzqUzgT0b7OiD0YMvtWvdKe5RtaNHdjJz/9HvQmu912VdGd7WitWbP0aWr83Sqo/IhzjLM8yG84l6aOr71dKDMuUVSmQdMgODwDFoV7WJGpJcKQ0JPkTWC1BvmK1tFEgbNY/XhNRQB6s8Q1STCdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349694; c=relaxed/simple;
	bh=/s1MQa6yVLYTE2nKYt+d6lV+Nla1D6j5QjJp/Ab/u58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Smg1JDVxFYTYvXO7OBXPT2JOY4vy8XVc+XAX7l+uXOG5UIVfLcx4RBcdTo3zXZrYGqSvp3MojJFnNFdO9d1FBU+TP1bWPXuPMvduY9ubiHq4W/uty+M+UxtC0pu0ftLq/N7KwrWgt5HBJEwzx8ZcxZgPmgLFrF5+/XvgixAVwCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8uzXOi9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712349693; x=1743885693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/s1MQa6yVLYTE2nKYt+d6lV+Nla1D6j5QjJp/Ab/u58=;
  b=T8uzXOi926wRVOibocnVmBxzJX+fPINRpMbg4jkrtHSgSftdn8ICSsV5
   WQZB+6RhK6e5AtI0Nm7hOkxWZXbfQTMD+irKe04MdT5BO9whp0KhW4Pkl
   cuiPze32EmGrklRFuA/0v1N2sFVJ5B/8s8ZyrBmMwQKh52ncM1Whf4g/x
   h4fdY7Ba+GLFexUXoTr4VqCezqOE0UPQ6/fCICEx+TXgxZUB4AXRdayOa
   ZqxmTKO1KXpM6/baPgp6ZgYIG5v6hUbd8PE3Hy9iNISW5kn+83Tpowuko
   k5Jtbkk+ah9Yoip/gDoomWIwiQ4+d/T3SPsl9wjIY28s/LZ7I1og+Yieu
   w==;
X-CSE-ConnectionGUID: iByvX2HBTWCbPNkpNy74Mw==
X-CSE-MsgGUID: MFemn2C+TzCRlLuuizAWpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19051850"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19051850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:41:26 -0700
X-CSE-ConnectionGUID: SeezwY94QEGxnMx7iOv7bQ==
X-CSE-MsgGUID: zp7h543FQD6re9aLP6oP2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23770666"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 13:41:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 13:41:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 13:41:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 13:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz1VkwyuH8Q2weKCWtSUwdd0vWV3gpwTCn4+yjsIUO/D2m/dHlCCclASIUJuyYBe47jRt8YB69np3MIhE+GnF34TBQACv95ONzovE0QRHjyZ283+NxdH+FnAv++MFP9uLtVxTTfnDQrTybCZECeYb5oq+1V4qnM0/G8lYT5CAPfkOkYp+cxMcMVB8edOX6uysMQ/rifXo55K31VWm9Jji2aMUVP7W6NZ/32KdUTZ4uicMrKrZfXpEDDDCLDYxv/lNijvf0hjholQ9bK6mlZhZwfEH7UvWEwEYPlCt6kjDDj33XuOnrNTmi/5gw7AIn+GN2OjgBAfz7ZY/kTqAT7+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s1MQa6yVLYTE2nKYt+d6lV+Nla1D6j5QjJp/Ab/u58=;
 b=OyvD20QRKmVgKo0XDxsdIxJr5Xpa7sp2fI2rFOfS5cVYyc7U3GAomFBNTZRlHls2H6OC3VuuBUHRjQ2MFibpT3rrgJjcP0jkBy8eDAbKBi6Ftu+R4qlKupTA5mLpQiwGYg1K+Z/jxd2ney2cjUykx9W2bD+RnHJ3EVE1BbzWhxilyHT4YstmOZFQIISM2nA3ts/s1aZuSzzldd0tKNwDQkrV60yu5hcAmK9HwaQZhsIsGqeImfuJ8TOA2OgZ+GMYUAeTcUKLT4GM6zffYXS3Hq+SloWB8SIpXxf1QMK3e+oxV1foidJoxRRJAzkUAPF6Ri/shI5CcrFlILiMBH9B0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 20:41:16 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::2764:df21:d682:c419]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::2764:df21:d682:c419%5]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 20:41:16 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Zheng Yan <zheng.z.yan@intel.com>,
	Konstantin Khlebnikov <khlebnikov@openvz.org>, Heiner Kallweit
	<hkallweit1@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH 2/3] igb: Remove redundant runtime
 resume for ethtool_ops
Thread-Topic: [Intel-wired-lan] [PATCH 2/3] igb: Remove redundant runtime
 resume for ethtool_ops
Thread-Index: AQHafwQV/Uu+l7+5s0Kiy5T16ALscbFaNAQg
Date: Fri, 5 Apr 2024 20:41:15 +0000
Message-ID: <PH0PR11MB7522DF37FA0185E56DF02C27A0032@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20240325222951.1460656-1-helgaas@kernel.org>
 <20240325222951.1460656-3-helgaas@kernel.org>
In-Reply-To: <20240325222951.1460656-3-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CH3PR11MB7348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fZoY7XTGf2nHAt4N6k0xtro6AD2IDOAILzG+dq0hRdRO1XwHsrpRG04LJAfXBIWlnXFi8pP810QP9liN16Ikjh/446DLIQOsd8mFkocGPxSJb+yCRXsMWEyalCiIMCyDeaVV8eMgGwSS3ikMr7vkpTOOOdY6LVnn0HFpO+RAXdBr9VdGQgXmSAtM9Oi2YLG3eghWsizlG5FoBZl/CVuW/yuv1GBf1uVrrltDes8bEExaT+RHzS8GocSYLta8VGzSyxDEeEpVvehoKpgQTwrKpZPWsJ5ilJQEGOGfr1oFDnbfyls7FOC5nQjAlkKVAStvvCwwkkimZZMSzhgtTQekyodcKmxFuKpiGGghbVT4VyWAcQB5Xlp8kHQh2TBd3EgqSxyfndHWavpQej8rygmrJX4DrRE1mDxCdrhomA8WV40+U8Ok4pHthO3+EskSuFvYRJ00AaifQ/YKckACFuRJcP04fElvNrMCd7clVzvSRCbkVTG+HRiwaQOAPwXO4ZSrczUlbTCt7x8Lppb7Ehkg64O2yPYxLQVGH2k4lfKHvlCnpInn/XaiW3WYVrLzbCgYycJv0/5CgVsFr25ZSLKuO0h59620d8SRPrQ7gnAQs3i6EJUoSjl0a/qVytTjHJywaJF1XwDyGMd/KvxCC/Sz1q+Sinkpxbf9GyrAgJqdTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dqx5tKyU6gieO1kVirEiPtgziE/3SzsK6Fc+GhgD+undaL9lIpUtcP1zZ939?=
 =?us-ascii?Q?ZO6zrCDtkH2uXC1l3xXnVfQfzLYzxaJnTmzAUPOVpYTkhMwmCzeCbXyuieL+?=
 =?us-ascii?Q?YI4z0CY2H4bbkIdx53QbIpBF0gcZ8qxwYbWbYhgFF6aH/4s+s2uDMnu+2qR8?=
 =?us-ascii?Q?7WIiIFVKW4RvSI+G1jm42IUAGdc40AqnHQCsvQtNkIIklBrXmwDyE482JHK7?=
 =?us-ascii?Q?QVCuLd8qHS+dVvuPZ5owI4PRkeZ8TGm2rBcuig04BHZe0uhn5eW4q1zbSpMs?=
 =?us-ascii?Q?ItBRoIpfeNogPXjKfdDFXN6sBh3+abnyhPECrnMMKQ5xuyLnRjkrEuiOB2Ix?=
 =?us-ascii?Q?HOcnTDcXzq0245i7PLBqTrH3K5ziDn+MaXDUD4tUUXdOklritMulM5EAQWKk?=
 =?us-ascii?Q?MmPn1G7wOGDjQaC9CV69JsYeGiTxvQKiMyoRgbBgxyN19+6UF//G03iyrvgz?=
 =?us-ascii?Q?Z+QOzt+lvGXkVDGtNKHvG7IoJkNS6ly+HZQlM8efRsicRgjqqJjMqNU+bxHW?=
 =?us-ascii?Q?zYruOtcR/jFiX7i35Y51AzgY3yvbISfN79OEak53IkNuFI1hIlGEQkf6xyn5?=
 =?us-ascii?Q?SV+Y5Xh8D4S1T6E9zE2WrCPWvUrnJyt5Qxa1BGf38xJgBgyIXEA2QUKdTOVH?=
 =?us-ascii?Q?WsJGv8sA7VBP/vlqyYCtmhsDWiT4Bvc/YNUFEer54ypxmCIj9EwjAf1FQHK+?=
 =?us-ascii?Q?2b5xj7JhhPwKbtqQVd0w+QPX58DW0shO9iT8uLcRoPazlBuUWUPsgZlUR4g3?=
 =?us-ascii?Q?xhQHiE4s6sv7GT4aloBCsioTKTjj8i6gdLGkXuTbnC4rTKWnffLkNdappx15?=
 =?us-ascii?Q?TcBOnsz1qyISQmgiplkq3g5I0e0kcWfoViA/7TFb5GBaFMKGRBCsL13Ba1H5?=
 =?us-ascii?Q?gO372cDs1OpZ4w85ldCl6/zKk4GagyJaqPTXEN5/blNuEHOPCHQfXqMCEGoZ?=
 =?us-ascii?Q?858G1TtY+6qUyWjRr72JBmL+eJAgg3QE9ExGzCOw8oO8hORg4qQRK0b0t74c?=
 =?us-ascii?Q?XhA7BnZiXxwOHmYsvrt0YOvSjS8Thh9x3Y5JJvygpSSXLZaihE5TiPCZbnPL?=
 =?us-ascii?Q?EI+5dnBTGaLMqmNkK4ww69i7tvnf+5ZzFv8FjHsUnNFrylDFJAhb9VqLocSH?=
 =?us-ascii?Q?Wfxw9lsOMoPwZ/kZ0D530uGvPf578WDjTZtfdOat0B0azP8XTmimYmfTN+3Q?=
 =?us-ascii?Q?nGI7IKKaxIxyeGFlQ9hFCo9ifq9gNoXiye9JJavijHBBqAGB05QgCHVD+V/b?=
 =?us-ascii?Q?uirl7ZJAAAobVIOhb8h7kn6VAdE/Q+bbcr0CsnENYZ++yOrG+vwGO2FfyVeM?=
 =?us-ascii?Q?iblmQiMPusFJkKl5Prvs9oS7WaWM1Ft+auMLX9q10j6/vW27hRhqlmjqk5b/?=
 =?us-ascii?Q?OYji/PP7vsFSzi+mRs0VUH/gUUdEy8QWE7X+TS5p5S2McTLyW2+rqEEYLKZn?=
 =?us-ascii?Q?2jrDQbaYmis69+0v8LeObZwAZJK13NvSYF2Xe5XSPMtsTcgGIyrfy3vWDbq8?=
 =?us-ascii?Q?HakootxMpPQNWqKXakuu04UXXrCNi+K0Pevhm56f/o2mDh/Iv1mFUkrIJrkP?=
 =?us-ascii?Q?/2VgMqnERkaA4aXU38z8lf9YagN5RUKYrzEEGGKO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97593be8-c8a1-426b-1b59-08dc55b0bd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 20:41:16.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3Fp03aMJrhCsLsOGME4+5a7tarHeJcbD3HZNTXTcImVufHlV2xiNzQpSi2HImCXUB1qd27nMcAumdqTTiafLdDMs4IFrcSiKHefqqRj7mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of B=
jorn Helgaas
> Sent: Monday, March 25, 2024 3:30 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S . Miller <davem@davemloft.net>; Eric Dum=
azet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <=
pabeni@redhat.com>
> Cc: Neftin, Sasha <sasha.neftin@intel.com>; netdev@vger.kernel.org; Wysoc=
ki, Rafael J <rafael.j.wysocki@intel.com>; linux-kernel@vger.kernel.org; Bj=
orn Helgaas <bhelgaas@google.com>; intel-wired-lan@lists.osuosl.org; Zheng =
Yan <zheng.z.yan@intel.com>; Konstantin Khlebnikov <khlebnikov@openvz.org>;=
 Heiner Kallweit <hkallweit1@gmail.com>
> Subject: [Intel-wired-lan] [PATCH 2/3] igb: Remove redundant runtime resu=
me for ethtool_ops
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 749ab2cd1270 ("igb: add basic runtime PM support") added
> ethtool_ops.begin() and .complete(), which used pm_runtime_get_sync() to
> resume suspended devices before any ethtool_ops callback and allow suspen=
d
> after it completed.
>
> Subsequently, f32a21376573 ("ethtool: runtime-resume netdev parent before
> ethtool ioctl ops") added pm_runtime_get_sync() in the dev_ethtool() path=
,
> so the device is resumed before any ethtool_ops callback even if the driv=
er
> didn't supply a .begin() callback.
>
> Remove the .begin() and .complete() callbacks, which are now redundant
> because dev_ethtool() already resumes the device.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>---
> drivers/net/ethernet/intel/igb/igb_ethtool.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

