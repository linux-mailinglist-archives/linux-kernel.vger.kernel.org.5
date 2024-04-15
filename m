Return-Path: <linux-kernel+bounces-144483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CE88A46DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57A0B20D07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B5D14F6C;
	Mon, 15 Apr 2024 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jh9EeoQT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057B3224
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147752; cv=fail; b=a1pxPNqCAaGAqJyLyecS1FoV9/BY0cBv7/wwFVfTaZJ+r56CZlg3U5JfdbrRUgVf6JCovrKK/gBEk7PIHP0901VSxkd8vE57jjwEOTXAE2ocjbPvOjjmaFl3RMwXQwDsDD2E11tzwPpBSrGQNmmIq4iVTjMSedfxv0DCFLzsrFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147752; c=relaxed/simple;
	bh=00efHYQ62mCJz1vtlZt+Jh/HZ/boE0CFihnlcpabLtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZu4xkyZkTGhsHwOosJZyNb9vYA7BqUxFn94dn4PPwQb3zGIomWK2LaxoO5Fj3bTE5D2fxdL79XiBk/He6CpJjc56af21a6aof/1WimcuUbzeV6zibxVQMf6mdwQxEmIgFkeKm4AFatenhTs1ioICSl9LoHHdgg/4a6q81GQ7hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jh9EeoQT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713147750; x=1744683750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=00efHYQ62mCJz1vtlZt+Jh/HZ/boE0CFihnlcpabLtE=;
  b=Jh9EeoQT1mgD3usW0ij6AeFhDV71HwWsd+LCWksDRpjVuWzqk16H89CN
   y4c++YLrfS7oQuh98I2qDyt1RP9atms/yU5zMACH4+dNkV8e/6hsukYoS
   nTC2koZOmO637MWnGR6iEGbqjzIAE/PBKVh6GvPI4Pysuf1d2TWim8Tke
   v/BwOGpa2KsHjpHg5zIzy1TFh1FS5YiMNHh/P7v6fThmNeskH0UhLYzhy
   9At664AxQYNrjvqWzPnAz3OC1Hl9v8BFuDCGbpAaaEL1VfaDsvH8PefAv
   ddiB+fZDoY3RwCv31WpCsvWaF/syzS0bJv5fvkVikP2qNOn/cIDDPpAn3
   w==;
X-CSE-ConnectionGUID: llFTl7TMTq6X1IoaqeAV/g==
X-CSE-MsgGUID: 0iiAlwkZR4qC74ODzEhyFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19233308"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19233308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:22:29 -0700
X-CSE-ConnectionGUID: /CR9DpH+QryjY90HGtzDIA==
X-CSE-MsgGUID: YXxep5LhTwWSrTeZTA/dgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26188472"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 19:22:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:22:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 19:22:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 19:22:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWLm7oF2TqVdIbMZ8pJekzAQagqC/uF14xKI3oqtxR01y+xUQV7upsmjUk++UrOf8JZeepG51icYHXZQw5bzzIcZfer4kuazIWFfYhkSfaHbZ5GlX0125iX4Pw+3gzFTGxS63HDZ1LC1JcabDYKj190li/WJvyIeLSwrvsN5JMR1x17AW0hj0LgBiKawihJw8SkZ+MrZE2Ts8fufF2smcEREKUnCwKHX/uKuuv7kJUCPXo3kAk90Sfbfwxz4cx1kH7hvLrIOodSTcX2x7RNoGGEa2JO9vDx6ouDsB/5Wn0sSCqm3aUx3npqlHGd1coznAuLR1/cBCzgxFlr6PY2CyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00efHYQ62mCJz1vtlZt+Jh/HZ/boE0CFihnlcpabLtE=;
 b=IBCc27iC9JeyPTsQkx1OWDUNcYDYPwqRZAwAuL6Kfg/4ulG5iMP+1mEbW6KJYj4Bh6FUvlEFZbAhEKOfjZCvrG3FtAk+mYfHmfMtqHEDVTbf7jEQcXi1ElOAamthuMBzUA73pAKKIkWsjXruabAPr5rw2Dfa0PpHnIJrVr9sP2z2v43c6mt9IUAWOeEYDYLlhjzftyuZ8yvOClLnW32mZy8x1q4Gd/eGOEiitWJJZDu3OGftDaSu6DrzvPbNbVd7nM78PNvbm00bXximiGG42V0JGERBMP2BBf4r5qaZzFlcmBrGeCgjeGLMbZ1yUavMM34Rzmu4s/4mZ8j3WbIPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 02:22:26 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990%6]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 02:22:26 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Thread-Topic: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Thread-Index: AQHajtXXl0hn1tuKek2BkzH8BIG/FbFoks/A
Date: Mon, 15 Apr 2024 02:22:26 +0000
Message-ID: <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240415013835.9527-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA1PR11MB8426:EE_
x-ms-office365-filtering-correlation-id: 11345726-e102-4de7-dc1d-08dc5cf2e463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SiAQeFrgQWl0Nlrl6BdA16JCDVDjTMge4///L1bpxNNKwFkuA9WIrBmE+VXB4j1WOX2PJKtRaunm4oe9DpVGegOk1jFagH66L5o2ezHh3FKTrbBQlxvQwU703l/Od7QZiWdZBX+fBSwEdnt86CritPpSaVuHI50fXzhZCfsdjxfLLVXH1QAFb1zOWQT3XSaykS3QBP2ArR1SliGBchZs/+jhqL+pl+KPkIn09DwsfsZNpqOnoJUi5Hzy8MdPjwuRMyFSQrQlnw3HljicHuXU8gExVrCG+csvEwUBWGHKghT8XHpEHwwjV47wdpBLqcU9wj7NIN7RvNSUX8i4Ck5vvY3khA8xw7Gp5oLEaRMztE0F0trUA1p6wCD8+GWq/6x76Ge6GUH3jW0JWRHEGkK5p8AGYWRAiDqUVDNIu48BCUsxRsAYVUPM3rYB9xukmqX8fskO6Zb330xgZ/G3O1XZaaFKLzefQDe4OA7VcBtSPS74YQgmk5zrqrO8jqfPfxZShwJgeYOYf6HAaNND13Ew6MfvByxaUFlIoXXdcJq4LP48fMcaJLOkO3Qisdw69Do6x31OeQ1I2+NDxVNESr48w8FosaLebNeiP49QJloWItP2qp8ft8iD/IEzxAhMF9ZISz9f7YhgiwkGBr+NO9HD5oNis1Nux8+U7w+NyM44hrVmfkTHkyepfEoS6uFRtjJQNvRuGE1TaoSUFavPiGHz76AMZA9DnDJKfaAgNThEVSo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1KVF8DelcZ2mWV0XgjaASZ0Q7JEnCo4YJBKqFCvBkgRsMNx/i2qBR5gcNQJu?=
 =?us-ascii?Q?z0KpUm3RMphd8UcEY8iDjd2M4FXlqU796kPBQM1dfVuMYv1EiqSp/pY4Iyyp?=
 =?us-ascii?Q?II4BQ06WL+unVy9pODuOf2g1GUAYsKp6/syHMDpR3js4Vc/XPpX6+wazZmaP?=
 =?us-ascii?Q?ULR+PYE+btCyaPBI+Kc1Xl1huZTQ+C17702ebiqz69E9WkjIydGBwd0mm176?=
 =?us-ascii?Q?+HbnL1PV6m2vbxybr4VX4dYObyhG130F4ZB8SS9e9uZpJJC+HwSqIUAMSg3m?=
 =?us-ascii?Q?Vq/fmnj2195892lh3cngAN6Od9aWkBhdj5F771uGUcATR/0BTjvE7uJAF2Yq?=
 =?us-ascii?Q?ja3zCY3PKoo6GTAlUeLEIAt5/DesqSPZQAz8EOTCzZt2PO2h44DVr1HlN/iV?=
 =?us-ascii?Q?hfIdD/Ez23TioGTGEoqJhF8DlMwrXsdjMso7kCjJkJFEC9nlDGiGP8dpbpAk?=
 =?us-ascii?Q?4FfpgGpa75ASVxtIh4thLX1wqRflUOxUb3GU1vfY8LVO9MhLNDJiqeqH+Axt?=
 =?us-ascii?Q?ogmPZ5K85UupT3a/KgtnH3HLl+CqgDdfETWFwqFWoKy+QCFRSBDb9aJqIgfg?=
 =?us-ascii?Q?2KgZy95boTOYTZmDPAS1k8lJYo55OapB0LPX5nyYAN5Px0emIUWW9eW1zkkz?=
 =?us-ascii?Q?OBzilEw17bGbHdZTslIpQFBjeCppXv3dkxfc/UuhoK7puX1ftn9chP0hxDVg?=
 =?us-ascii?Q?S2EEFiXZmuu3RhV5bRI+37oGsCxKXfumL3bZSL4YcC1HbceDZATCkNe3REF9?=
 =?us-ascii?Q?6+wzTksKuC66F/YsuSIb67Wy7VJB1W0E6McRPiTceRNO6oFSJmXDp5Bf3nFf?=
 =?us-ascii?Q?awvCpOzzu80KUdEeq1HDzZJEpgVRnt2+i0ldmRYccre4WH1nxRcSet7zlEHS?=
 =?us-ascii?Q?PmMvT5JqZlrUx2F4oQB/xziM1ZV5WX68Ct90tDwCDmiXvtwoYSe/e7KkWo1n?=
 =?us-ascii?Q?Tu4OZ7inRhOpWLIHJZxyOqcK78JrLIdKgZP1T8UWkBZ23c0TtI6GaB5cHROM?=
 =?us-ascii?Q?V8a6IlaYGNE7jEHWx1L2zzCoAOpc/IbANmMX/KF1ch3nIYQR7wcK4Vhunx7b?=
 =?us-ascii?Q?ZnYKgIM7THNBvrXx/UvBq8YBcWLlUaZ2mqU5yby/1F6MdDxl+pVTM/c8lE5c?=
 =?us-ascii?Q?jbH1YD4iTYYY/xNTVbAVZhHS5Hart4JtTqAtoRhwzORy2QPHXxAWdlvGtohb?=
 =?us-ascii?Q?73ox+43dQ+8219ni8Imc6KD1p8Rmuxlu9ywTQBcLlFa/W4jEacQCUvquFwES?=
 =?us-ascii?Q?3bSe6eiE6SlPxc0bvyIVq1QB9eNRMKzjBbi772Ay2sIrwYGS1RsozOA4zmiy?=
 =?us-ascii?Q?RUmQ17CEB/ErQ/2G55rD+7Mooef/oCcVH8ZpsCwOIqUuWcP8mAsoEcona82j?=
 =?us-ascii?Q?RJ7wlXTLuAElPba03vJZ9MMHP/QRKPyoztpCLnuH9cyXXbcRXj/yS8t/BDPR?=
 =?us-ascii?Q?6OBr3QXXPEbhm8V1MpLzZxRrRss36/KO8BIAb65HnYuAtTBL/51tTzchK/Av?=
 =?us-ascii?Q?0rkeqOjHvtaVXIjt7LfErrbTzpemrwM+NhsN1Xw+rPc2VZPjrMCA/TTz7PG8?=
 =?us-ascii?Q?lagiBTUUV/iLoZebPCgUs3C5zgPWwfH4uQhcOUOk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11345726-e102-4de7-dc1d-08dc5cf2e463
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 02:22:26.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqyn1xesNIzsSsgZ6k2DEUch0DC4rR9ogvN7pbOtDMIdOaaByR6ZelrJvLZ4oVERA9BGSkyKzF4jnKBHx16muw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, April 15, 2024 9:39 AM
> To: iommu@lists.linux.dev
> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; J=
acob
> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Will
> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
> device TLB flush
>=20
> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
> implementation caches not-present or erroneous translation-structure entr=
ies
> except for the first-stage translation. The caching mode is irrelevant to=
 the
> device TLB, therefore there is no need to check it before a device TLB
> invalidation operation.
>=20
> Remove two caching mode checks before device TLB invalidation in the driv=
er.
> The removal of these checks doesn't change the driver's behavior in criti=
cal
> map/unmap paths. Hence, there is no functionality or performance impact,
> especially since commit <29b32839725f> ("iommu/vt-d:
> Do not use flush-queue when caching-mode is on") has already disabled
> flush-queue for caching mode. Therefore, caching mode will never call
> intel_flush_iotlb_all().
The current logic is if the caching mode is being used and a domain isn't u=
sing first level I/O page table, then flush-queue won't be used. Otherwise,=
 the flush-queue can be enabled.
See https://github.com/torvalds/linux/commit/257ec29074

In other words, if the caching mode is being used and a domain is using fir=
st level I/O page table, the flush-queue can be used for this domain to flu=
sh iotlb. Could the code change in this patch bring any performance impact =
to this case?

Regards,
-Tina


