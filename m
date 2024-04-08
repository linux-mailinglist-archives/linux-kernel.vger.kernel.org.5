Return-Path: <linux-kernel+bounces-135078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6FA89BAD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16591C21BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6C3BBF7;
	Mon,  8 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E3ew8wm+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E653BB3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566146; cv=fail; b=G+sgwd7Br8/d+Mb54imo15SzCu3AXGO4rCL9D4QIlM83om85VmWDz+oCk0tUbq1UelllRy5gOhF/kbFlh9Xj/qEA6rNehbOaDJH5d1nDBsMxUeldY/EcFY7IazuLqJHHTfC4iCJXL4h1WUKnUZw3UqTEd/SiXk9kAcWaD7SnSH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566146; c=relaxed/simple;
	bh=bUj3b1tQMee6eb3z6GqjxgHqQuvyW+nZGm1iONI5GKg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQzOVXQMxf9qHoLQddMjIwG8bgL1wsFoIVsTiApCfaHCY4z5OxLIH+eR8b+w0iGHFOyZro2W3JpMvVgWzMWFLLX9Bd5VRHlzs8FAPia04ws8xRfXEYpkM5yPua9UDpnR19lh6S28rWHCoREbDQh8vM7RSvvHmB/vY4GDzjrIZAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E3ew8wm+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712566145; x=1744102145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bUj3b1tQMee6eb3z6GqjxgHqQuvyW+nZGm1iONI5GKg=;
  b=E3ew8wm+Igo5tLwhKYsWof3OhV1z0nlZNayYETtDnRF+FKUs2egIdSV6
   +h0jLzcViMblhqHOuk1yADoWA2zm8WS0W1+7GfcboOr7w7TuT8Qez6pky
   Mjx0eM9IIe+E7xvXXRS6AgWd/FNkjpf3PGOGtztK1oWn4RklQLe6u8Be/
   bTi12QoIdt7NSiH2CeY1FEPKr9Tyb1WOPmd+XEbiS2ormM9RZ2TwNRjwW
   1KpPgIiB2ZDPWmScqE+n9hVziZFoWXTMP6EfUUIcjeyjuOYnmmmfT7puN
   cX8yDcWGlwbmzyA3bvLiFpAwl2zOXqmk+oUY8+n8K+f3GUMnJ8paGbBVq
   g==;
X-CSE-ConnectionGUID: ZP0V3+pgTOCXlMpIpyVLOw==
X-CSE-MsgGUID: RCAsjca0TN+6Wagg1lOn5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19269737"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19269737"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 01:49:04 -0700
X-CSE-ConnectionGUID: euzXqDxoTsyzPqN/3lHXbA==
X-CSE-MsgGUID: z/Sqv2IaSvm0cnvn9AYM7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="42986209"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 01:49:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:49:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 01:49:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 01:49:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 01:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqq0zdGOaKf7o8Ebb/mD8dec+6XsuWihdF9laSSyqwRJ+oDcUZ4NueD0sbTSrMMRjZU/vcnjfU0JhrOP6z+gUajxlnyDyhUsw/0O3RZ+bMACsnVSaLtgq8iV/ZDKnwL8nXud/loH2FUMb0aRkYhG40ISirIQRdHsQSvrbIbZclp3N2DEIe0MQxrPEiGCsMj23bzWmo4YWOtT6V19Ik1MGzrrCz/cAS3E7wgZGTLxZRL25Y6vVlCTfwaOKUmIQRm0RQAWhVLhznO+0RTAE/ZX2ibHfvnxEPM/gf9Z/TlG+RC/IAYy2kKe0JSUS82DSUE5EU4OSd2O1OtqmjCjYQclyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc9veNNzGIqla7HURG9CSoS7Qf9r9hipZHmRQx9h1d0=;
 b=gdQLcwJNoRMMV9sLcPredvKs4QFP4zfxs1iz+CUvH8KOFkTzIzZr9DYMtVbzRL62ygs8JaICm9guzTF0qtjjC/mxYulaUNr59Fr6Sktdiasn6BN7ylgHkJfLrSKpf3cMULvREqAGkJLnIC5vfaZLw8VdHo8F49zguzRQD8O0yxGG/LHJo+DydGm9m2NGAnkvr1W9LxOzVQ7guQDKLBYdTndl351siDM0orVBVZxFKr0w30nlA7rcOzwMAfUM32CDPH5eYInusOHpwsv1F1kfh2VSuUIGnmdMwznJHtFAX3qeLe3VJnESoJdqK0M17sntmjJUX9dYNeG8HBmYSGcX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5781.namprd11.prod.outlook.com (2603:10b6:510:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Mon, 8 Apr
 2024 08:48:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 08:48:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "sivanich@hpe.com"
	<sivanich@hpe.com>, Thomas Gleixner <tglx@linutronix.de>, LKML
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "steve.wahl@hpe.com"
	<steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector
 exhaustion
Thread-Topic: [PATCH 2/2] iommu/vt-d: Share DMAR fault IRQ to prevent vector
 exhaustion
Thread-Index: AQHahiB7n7Y2ch8WjEeOJ91b45rj4rFeEdyg
Date: Mon, 8 Apr 2024 08:48:54 +0000
Message-ID: <BN9PR11MB527677A69A2004A951165CC38C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240403234548.989061-1-jacob.jun.pan@linux.intel.com>
 <20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20240403234548.989061-2-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5781:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFTxou0jmZOCMxIBjU5OTTnnd3b5pxPmqa3KUVd8IhBKErPwQeWH94pto6o6rwZIp230m06kMa7AYZJPlVzhhUVWKB3uf1ysjrZXB+yelFD0CvZukU5L4SWDtUhK8Il2Ny8ykNPFkJHoAZceB4lqRCGJuJFpvmkuCLdzGaZb7mowzvElIiCBvyQJiK5E7y0QMQUGM1uN9dHdtnD2yL8YXGIjrZf7OYunlTOfANkiNE9UvjJf0oQnpyT+V+7KamptgcJPCTQOUgL7/wmxLi4BcK1DIrqa/rDP0DbkQRdJL1lnBAP91KKDlghkeGZ9UIj3PrCLmg24vzRoAWPYYBTVd9acvz4tap9nq4Qip7/sa1CXZN/UcWGp1P82wDTzmmfKxIkdNzCDCH1mMezIn8qHpCTsMrMvb+B1+5S6BBIpGg/g7e/KSzbSe69dwyIvGc/UTQndDmteEw8R7XmHmG/F2Yza+mgN+HUH1UfCgPCvTvRgEqbQ82biRzxZ4d7aWubOQJDoiRJ85XBlewFh7h9FsOLcA6jHzCWDs4ozZKs5WxZe//gmyXNUI5L2BLS1ENE+nfI/Rkyf159mxeGaFUiyFjvIGlYNY+TcEtuhAgmOZkzjfCwJ7oqugaYH76gnMtPIfn2Y280c4bFmkZ9k+mSMIIesqG/0CifsNstHfDTgZEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z78s5ZH3X2GzPIua3ZVyu6Hh2IGQ2N4ak3AV1fgvvH7aJXb0TaZWZj73BnVv?=
 =?us-ascii?Q?0eyRF/czm0hgV9GqR7v4zBQ49u/bcejQS4My3A9ad5fKJy7eL5RJY1DLAgrp?=
 =?us-ascii?Q?OkVwLErv4Khsg3VhwJYXyciAUgg5SPhCSmPUvJJ75Oaa5BWwZ4hAX4wNkLWy?=
 =?us-ascii?Q?+MmYvlsIVkEWkY91KOgku7ugCFjeMiSCJyLjaBOmcTnLntBbm8b4WsoZLg0a?=
 =?us-ascii?Q?9V12IV9B6HJ5h+EO4+5R/rVTzbDvB5U/WW1lTvB0kFQ5okFd6DZ8+9ObAviy?=
 =?us-ascii?Q?fJn2UT2QCMuPFhM6tptvYjuaD9D5h6avvZcm8DeZB4PGhPbxbOcvptSpfprc?=
 =?us-ascii?Q?mRkwt2N7i4OPMRhKf31hKELQJYaxoS8Upf7Sw56N5vMG7ivSFLpS9SJVQt7Z?=
 =?us-ascii?Q?Xsck8acqzc4PBI/Ctui/foGUvepVnxKlbotgKLtwlmfxDAZN4kqBSBtkeiGn?=
 =?us-ascii?Q?epI8qQB8wIQvUeh85VKNQaPoRwJYtEJgzqqyKdHOP/c/YJat21+ZI8tQEN0o?=
 =?us-ascii?Q?iZRl9gKzDo2vH8FRX/qJZzNLaDzNmPazptdne8Y+kqy/TB11utQzMRHe41Qn?=
 =?us-ascii?Q?bkJIIwwBz3nqlRQ6iNFnxetWIB5XM69lkFrN3CvMWPIR/cBe/U/miBV6+lb0?=
 =?us-ascii?Q?0hdJMncpeaRiq3nyvvPXinZIDR4HVHoYRkkmEu+paNFoSyPNJja4jsTdXh9L?=
 =?us-ascii?Q?vxVX8p/rbrg9jUGFGRvZlLOFMlz7EQuSmupKsABfi6Xv39T6XnySbFdWf1+P?=
 =?us-ascii?Q?3ia3Xvc51gN+K7QZ7Ro8fOQbO9TrzKjCHOL5gc+Li5+eEA1g7k9Ok6kLQizw?=
 =?us-ascii?Q?dwhzdfUbmVG8vgf6Pf5QsnC5uIdWDPkn58JMeJcOFhkDUyB+ViPB7hCS40Fo?=
 =?us-ascii?Q?Ge1Xs0LvM9fqKuEkI494rHyBEXXNzb4Gfl/ZMSt2mj5043AU3mS19eJb38N2?=
 =?us-ascii?Q?NgYVtumMzAmzxF3/pBLQ883uoICp+BLqPYe5cqYbY8f3+bQz94rgCoFi1PGp?=
 =?us-ascii?Q?7TEZ1CdbtWaCwuNoKaN2BaVJi5+VRvROdhrA022cVafXQKq33ejSxsSxddvy?=
 =?us-ascii?Q?rVhDRKeayIdgsJ74OvWZPJjrKukZ6osiRo6QM2CYnwcqUUJvwC5ZnNHXDIb0?=
 =?us-ascii?Q?3TywvTJ4LHvaHiII55LqS0c5aXhUV2Om575hKWC5AVFY2EzWp0l1WySClw7z?=
 =?us-ascii?Q?q0QqYjVeW2rnwTpU4uc4rNDUx3gAk5ge7VQ50Q7sxdgyB/Eun/nCb5E2hmMi?=
 =?us-ascii?Q?dygNvDXX69d5A10SwKf/q5ltx3udrHhDwcfojYosBpgHdzX7gnMNjNpDS0gs?=
 =?us-ascii?Q?CLHnegdFgCMqHc081VDJwC3k66fN/ndN7FeU9jfNuLV35ZtIzUGHPczPLzE/?=
 =?us-ascii?Q?awrne96Mpp5fWUKvUH+AjS/aaPXszHO6QtrkxubIuNeGft5n9EL0ZiERpi2V?=
 =?us-ascii?Q?cSTZphHuY1fSh0sw1/Q/ZdKYxsiZA+ccMLOMa+OlovlwwLkf9Op1wJfHYmXC?=
 =?us-ascii?Q?KJy91bRfVDY9E+OJGi2gfuNfw8oHW1dPuBQxKAGHf6pf+fGocqHVwKHGf/5d?=
 =?us-ascii?Q?1xs1E5o+G1hdaTSqxf4WRngTtDkpiyup2C6FD3bo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d5e5d4-b806-445a-5b92-08dc57a8b8ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 08:48:54.4483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbYjectOlV4XHA4XkHdolP61gRJi6gK2qeLulAOQVTKYoRrksuSqY3nyyb7GcA7Z/LpkgwxBl44VIkhBQ0i2Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, April 4, 2024 7:46 AM
>=20
> DMAR fault interrupt is used for per-IOMMU unrecoverable fault reporting,
> it occurs only if there is a kernel programming error or serious hardware
> failure. In other words, they should never occur under normal circumstanc=
es.

this is not accurate. When a device is assigned to a malicious guest then
it's not unusual to observe faults.

in this context you probably meant that it's not a performance path hence
sharing the vector is acceptable.

>
> @@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iommu
> *iommu)
>  			iommu->pr_irq =3D 0;
>  		}
>  		free_irq(iommu->fault_irq, iommu);
> -		dmar_free_hwirq(iommu->fault_irq);

You still want to free the vector for the iommu which first gets the
vector allocated.

> @@ -1956,9 +1955,8 @@ void dmar_msi_mask(struct irq_data *data)
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  }
>=20
> -void dmar_msi_write(int irq, struct msi_msg *msg)
> +static void dmar_msi_write_msg(struct intel_iommu *iommu, int irq, struc=
t
> msi_msg *msg)
>  {

what about iommu_msi_write_msg() to match the first parameter?

otherwise it leads to a slightly circled calltrace:
	dmar_msi_write_msg()
		dmar_msi_write()
			dmar_msi_write_msg()

> +
> +	/*
> +	 * Only the owner IOMMU of the shared IRQ has its fault event
> +	 * interrupt unmasked after request_irq(), the rest are explicitly
> +	 * unmasked.
> +	 */
> +	if (!(iommu->flags & VTD_FLAG_FAULT_IRQ_OWNER))
> +		dmar_fault_irq_unmask(iommu);
> +

em there is a problem in dmar_msi_mask() and dmar_msi_mask()
which only touches the owner IOMMU. With this shared vector
approach we should mask/unmask all IOMMU's together.=20

