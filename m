Return-Path: <linux-kernel+bounces-134767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A889B69D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1111F2209E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F003C4A3D;
	Mon,  8 Apr 2024 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYgBxble"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CC1DA26
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548380; cv=fail; b=fg/9kGHQMi7hdRFbh1ilTbM6YgeuFYJvcVxIl/+A9R4x8W8vc/9JUftPPjeBEnd0eJNMzX0MbmJcXLEYa+3v74QjOb6uOHSs9Xm13mNGSf/wbZLnJv4S7OAKdxqTShM7xwVgHI1vWj+IbVP8G8swIMykGVFBbQ9L7um6gO4SXvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548380; c=relaxed/simple;
	bh=1JF9KZpjEshZ24UhbtoqQXVAt/Euc2FTP3rpBFUbalo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ioM3EO8BVmagX+UtaKMpk4uDx6e0nh30L6EATDngYiTYgS1MCfqMm3DoOKo9n5ArvdsWuVPamVMNNHAsoTzi61CoklMJVNALLEgDXZNRGG1npCRIwTof5R7SI+yCGlMwkY0/yNsWnB3yEKwCw9b0ePn25k8yb47ZILLRDNDtvh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYgBxble; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712548379; x=1744084379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1JF9KZpjEshZ24UhbtoqQXVAt/Euc2FTP3rpBFUbalo=;
  b=nYgBxble8DbbadP+OWf3BPCsE8+h8mp5okrakoc90sldRyHxFa3xNM01
   GHVv2TWZav/ZI/KcXUob7KAvSHueQ9gfXkz+qzxDs2hvIIcqhMM8u+1AV
   6ZvjD33++CwFIo8TCusIJsTZDMQHTbw0tkg2PjGzr01DXnBw558y3oNYZ
   TCE9va9SEbTc83e53tJYxeNUOmWztSwYsY4dPSrjha0+nvfcYKz0cMd3K
   XKvoVH71ENfh5pE/wWvLcWpmFaOBo5j0SRmO1mJEARU94BA7xwzGsVBG1
   mCfVM7+/vYtsymiBGDX4eWqJGQKztzwPT7Zzqr8s/rcqixExoskKxDmM+
   g==;
X-CSE-ConnectionGUID: 016AYNELSKy8t2kmXQZwnQ==
X-CSE-MsgGUID: 53urMCj/STyfT2lFp/Gcrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7672743"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7672743"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:52:58 -0700
X-CSE-ConnectionGUID: 3sTxJGCvTV6d7xvhY+W34g==
X-CSE-MsgGUID: cw37Gt4ZTFCLsUk8q0zqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="24520864"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 20:52:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:52:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:52:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:52:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 20:52:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpBT9pitkVyYgp3GJwf0n7QkaaM859JdwsvlJN01Nwo6xO11EHSP1lF8XfZYDG8Xnqt+ZFuAF6F3TYM5Ek5wKK2y/t4SG0gZyherqe2lSGuvs4sRNr8jxcF9t8TYYHSZVGgfgf8z5rGQteFiMqVnXKzB95c9d02c84dnI8aKh6qdcL09manmzFmKDu8s+ApK0MbX6dUhQoO3pR8Zht/+1Y+IIt5gzQ7hXBn3WwnC47qgOdlloAzzWo4B3dQWlrm+++S7o4lTfLaz1azEo6Tk9hCFPRI/y5LipAlGwyNfJ6qbw0u6v3GVpE5qrMiL57BhXDcDNeswk5Neg/q4BtjIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8waNPgtWTxP6HhVmZj7+HjODfDMaPOAtS18BQ97A2y0=;
 b=edQNpmM7VG12juZ9doZvk6UdzHn2iokW1JT8Qvs0YdH+C/H8n37kI0TG7JuFIk66OF99sMueMiZPeisurQycDBIrncNcEmzBrmWiDCZcTYLmq6kZSxaw05cY3vpvaC4E3KcK3E76OcJ3dJCb9GRkPECT22UhScTXOJZ1U844Fn4drN6R73jx4rWOqz0fAZKEOblQnb9+0MBMPsagoRA82efJiyo4g+a1YEDxDl7DLXOMHR+XYi1y8RG+gLPMVv16DHTk4qeTJ2AEBPQzQo/chypTKygrfnbY66J1mhGw9kYq8DLfgG8YMvxqm2agI7orINeAxTzl3dBhGDT9S3xy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 8 Apr
 2024 03:52:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 03:52:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix WARN_ON in iommu probe path
Thread-Index: AQHaiIkfDCiYXSWkLUGWnjJZsYe/DLFdt7FQ
Date: Mon, 8 Apr 2024 03:52:54 +0000
Message-ID: <BN9PR11MB52760913F36DACBC612088668C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407011429.136282-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240407011429.136282-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB8069:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wvoGzKTArk8z2UTI1Zbf8c5OU2TLkgkBdEjwo5LrJ3wrfXpiFwXxboK7eY9DjXbSyeXgHHhdc6m7+n8Xmw5IQb+VQTv/mxaYYxeUdSuvdeqNGkMSIQmSeKm00zoFlERCodmX25DjJpWEcGu0lGrw9BN2FLodLU7K1ScewnYflfhwIPzPVOiWB0sGSNWLFZM+qptPOy5k8fhPxeVIJEl0llr2t7rRo8VE18OZ2gFQHnF1tj6DdGYL9XIETNoLs6em9b9RLJgEYm8uxvp9nQcwCmHel/LNdRb46UcsqoAzMWL8Z9OuVZDZ/sRgEd+29KEi0c2uO0ms88J2TCgH4dQ0RXaj3cujQxN1ydBms3jw6NOZaHETycRkNN+EsekdL43J8f7NR9lVQL3LW8/Ic4tQ457VN98iilKmium256yIKLrdS83rN9qSSqSFDdbsArGBtvTrD5pJRhTWp1InaU/ydmyJjXUHT+ycmidC1GgfYYyscIzY72ZvoYlNGkzzBLyXQeF/451jrSuyXqvh1Q2beSJyIjgv4bRE8fkS5rHP3W5IAiYzV4qFtbgUEQ8y1Ufzwe96WSAKHAN4iFFm1uS/pZTAYG0UBkZ7yYyKG1xovYtCreAMrQz04hfktflKuL4UJ7TwLY20/UWFzHzVAAsjYZTDPY3QpRzJs5GmZ1rpzBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Rm6h5zatkXY/qcbXaoAXDuYA5T0ON++YeL+2s2cj4VxIMqRF8jcVDrpN1Rg?=
 =?us-ascii?Q?4x/JWGIyJKdzAKdkE+MhkwYwQFzAdEnhG/WC3wqzkU4J2Khe75IAqd8afyfM?=
 =?us-ascii?Q?hEgIWc7Bu3zkBucfB3u01c41azyi1sTwS/JuRHdkmvQxWGS/tLmhxsHqaLnx?=
 =?us-ascii?Q?N5mc/2SRHcQTkk6wdAh5oqwcxIQxrXpQahLT8T/MUCyHHgNDXl36iGVVQyGc?=
 =?us-ascii?Q?wmeIvSiGEczP781qMFbtMexyps+2IL40AE8i9KxiuLxYbWDbIU/pjqX4TBsO?=
 =?us-ascii?Q?VdgqjnGRwtinEUOWexZ08wn+CuulPOlOPCZvAN1//1Rn2lcz7wX9mSuAKmmG?=
 =?us-ascii?Q?t1sTefLoZ4NBQBAuOkUQaI7iTlHd9GqvYUtTUN3wxtAT/+clHnxSX+cFIjS3?=
 =?us-ascii?Q?ceT3fqMm1YGpldaX+9Lk/BDiU74t/Z+ybxJCVevD6hrgzdIW5pTsEBp9nd+d?=
 =?us-ascii?Q?OzrXTdjhySdZuwlTQGpsejblKLYCuQ9Czfw+G9BQkvhfC9BVwo4T7SDI+mqQ?=
 =?us-ascii?Q?+ba+v4YM3iiiUb4BjsR+8XjhuNRE4rm9ox4xjWwK7dA/Ml+J4DMKQPKGablF?=
 =?us-ascii?Q?ViahfhTZ6W7wdRU7UkvJ4/dcmGBRTl8G1ccdiVFxkEXC6jS0RCcsumsb3Gc0?=
 =?us-ascii?Q?2IxjR82CE9AQIEbwRsaROAFBqcj2G/8sju1dopaSeyzFyAW9MdkPcC3oflGe?=
 =?us-ascii?Q?SpWIVIVeaPhU+ih6c/XpPofsmJbdj/tm5RbBIkPMxw5AA/637i2+Qp9P1OEA?=
 =?us-ascii?Q?8hv+AjVMPrgZ+ib9lkHN3LG7AupaHBJstN9QXEXYXcuuAZ3enX+xZqBhW9pS?=
 =?us-ascii?Q?f8qNk2ss9Qx9zxohuz1S/Oo03LrveMSP2+/mn9qPAXRryS3Vh/Qfj309raES?=
 =?us-ascii?Q?lU2kgEvznbFdIIrdE2hM5rKPPIZKih7MB2d9RxVoVv2ZQXD2GadBeHwsKdcY?=
 =?us-ascii?Q?UfmZITo4Lhye3/p2pfd+z8S5mtyPVJLTMkXSx1A5fTpPjZOlm4J9Hxip3F+X?=
 =?us-ascii?Q?3f5h18YPXcJH2wjBzMGwuxHRoe+eyUMJwQpZKVmDwFWfR1yhfNpWKCneHHiD?=
 =?us-ascii?Q?8Oc/3QD9+osNb2C+s/ytk66UeZ9OdpFnu+w00ezC7bRlQTQXiOYbgho6+Oec?=
 =?us-ascii?Q?uHrMbIJ9GhG23gQ2SKj5rms1dl2sn0kc783LrKEIzRQT1B9xz8LsoPnRKVzw?=
 =?us-ascii?Q?4Y4xTANzo+HOZLd29Vf7TpIEN2cc1o5I2L3NOWzRW9lu+V15OZrMxc59lN+5?=
 =?us-ascii?Q?jXEWb/PI1X6R5bRGK7mffsMo+h0O4IeAuI9pc+cpTj+9AQuBLhaa1uD5gJGQ?=
 =?us-ascii?Q?ZSWTqZ3+32XaGUzZuj/BATr41N/60P5KwcBDoAFAYYMDULRFMi7oZZbS7pA6?=
 =?us-ascii?Q?iRim2RhNb9RvAXw0hd71ZqNdCiZAwEPKaNwdHIQn/ytAcR+uhdtiMvVcLPTb?=
 =?us-ascii?Q?MMnTqTaXq1w5Fetu/A+oAqaDVcIkWnMjDxoO01D6kVkwgAGUjBPauGEu2DeH?=
 =?us-ascii?Q?Xyqx3i90rtZYGeTSS6Kpe5L2yFGk/2qsQSHAcnw1pQ7irBftkX2xGJjlz5D6?=
 =?us-ascii?Q?LEOSRKu6sv+EmmlHFjxQO/4bK9ys9S8jJZHr+c7+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fc723f-ae26-41a4-573a-08dc577f5f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:52:54.9292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpLmdwe33DyQlk+WE+FP2PIrN/oyNTB7qbdW5sdvWovWm3MHbhNeyGIkfRLmhEgYbt5jwyhf7CrsELwVzHHvHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 7, 2024 9:14 AM
>=20
> Commit 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> devices") adds all devices probed by the iommu driver in a rbtree
> indexed by the source ID of each device. It assumes that each device
> has a unique source ID. This assumption is incorrect and the VT-d
> spec doesn't state this requirement either.
>=20
> The reason for using a rbtree to track devices is to look up the device
> with PCI bus and devfunc in the paths of handling ATS invalidation time
> out error and the PRI I/O page faults. Both are PCI ATS feature related.
>=20
> Only track the devices that have PCI ATS capabilities in the rbtree to
> avoid unnecessary WARN_ON in the iommu probe path. Otherwise, on some
> platforms below kernel splat will be displayed and the iommu probe result=
s
> in failure.

Just be curious. What about two ATS capable devices putting behind
a PCI-to-PCIe bridge?

>=20
>  WARNING: CPU: 3 PID: 166 at drivers/iommu/intel/iommu.c:158
> intel_iommu_probe_device+0x319/0xd90
>  Call Trace:
>   <TASK>
>   ? __warn+0x7e/0x180
>   ? intel_iommu_probe_device+0x319/0xd90
>   ? report_bug+0x1f8/0x200
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? intel_iommu_probe_device+0x319/0xd90
>   ? debug_mutex_init+0x37/0x50
>   __iommu_probe_device+0xf2/0x4f0
>   iommu_probe_device+0x22/0x70
>   iommu_bus_notifier+0x1e/0x40
>   notifier_call_chain+0x46/0x150
>   blocking_notifier_call_chain+0x42/0x60
>   bus_notify+0x2f/0x50
>   device_add+0x5ed/0x7e0
>   platform_device_add+0xf5/0x240
>   mfd_add_devices+0x3f9/0x500
>   ? preempt_count_add+0x4c/0xa0
>   ? up_write+0xa2/0x1b0
>   ? __debugfs_create_file+0xe3/0x150
>   intel_lpss_probe+0x49f/0x5b0
>   ? pci_conf1_write+0xa3/0xf0
>   intel_lpss_pci_probe+0xcf/0x110 [intel_lpss_pci]
>   pci_device_probe+0x95/0x120
>   really_probe+0xd9/0x370
>   ? __pfx___driver_attach+0x10/0x10
>   __driver_probe_device+0x73/0x150
>   driver_probe_device+0x19/0xa0
>   __driver_attach+0xb6/0x180
>   ? __pfx___driver_attach+0x10/0x10
>   bus_for_each_dev+0x77/0xd0
>   bus_add_driver+0x114/0x210
>   driver_register+0x5b/0x110
>   ? __pfx_intel_lpss_pci_driver_init+0x10/0x10 [intel_lpss_pci]
>   do_one_initcall+0x57/0x2b0
>   ? kmalloc_trace+0x21e/0x280
>   ? do_init_module+0x1e/0x210
>   do_init_module+0x5f/0x210
>   load_module+0x1d37/0x1fc0
>   ? init_module_from_file+0x86/0xd0
>   init_module_from_file+0x86/0xd0
>   idempotent_init_module+0x17c/0x230
>   __x64_sys_finit_module+0x56/0xb0
>   do_syscall_64+0x6e/0x140
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>=20
> Fixes: 1a75cc710b95 ("iommu/vt-d: Use rbtree to track iommu probed
> devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50eb9aed47cc..a7ecd90303dc 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4299,9 +4299,11 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  	}
>=20
>  	dev_iommu_priv_set(dev, info);
> -	ret =3D device_rbtree_insert(iommu, info);
> -	if (ret)
> -		goto free;
> +	if (pdev && pci_ats_supported(pdev)) {
> +		ret =3D device_rbtree_insert(iommu, info);
> +		if (ret)
> +			goto free;
> +	}

probably replace device_rbtree with ats_rbtree?

>=20
>  	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>  		ret =3D intel_pasid_alloc_table(dev);
> @@ -4336,7 +4338,8 @@ static void intel_iommu_release_device(struct
> device *dev)
>  	struct intel_iommu *iommu =3D info->iommu;
>=20
>  	mutex_lock(&iommu->iopf_lock);
> -	device_rbtree_remove(info);
> +	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
> +		device_rbtree_remove(info);
>  	mutex_unlock(&iommu->iopf_lock);
>=20
>  	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> --
> 2.34.1


