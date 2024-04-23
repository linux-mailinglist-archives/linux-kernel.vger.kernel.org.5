Return-Path: <linux-kernel+bounces-154713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77938AE009
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418EA1F22823
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9758ABC;
	Tue, 23 Apr 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzJ7xFch"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C156B70
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861760; cv=fail; b=bN0WliRL9mBZpKPE6AfYy0aQomsSAzVFwOY34UVC90+ELcw+faIoq9Oecj6+xMHG1g5P0aooCQzq9H5z6cMmStzCJzAiU4N7V5x+yAX0yVYDNLHrpwPAAOcShyhxvg0P4MqfaMZlnTvLIMPsQrmeN3ccvWaB66EPOyN/b/ZywHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861760; c=relaxed/simple;
	bh=KhfkarctnIcHziIsD7c2rucJK7nIjCksyuRDRINv4DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WelDBqXS0oBjG0L7nC8YQ68lmQobrN4BnuWSDmDIbesE06ALYQNpQ9b/RmE4ycmQY1d8Z537hNWqb0yTJlnC6vLQaoKjvUMnIMDMTOL8GwwI/VEwuN5FJdJ2F4ypMuu38tBWM0YJjS3TB1ngQSACUnXw8Vhtr9sy1kIkcT5Bqmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzJ7xFch; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713861758; x=1745397758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhfkarctnIcHziIsD7c2rucJK7nIjCksyuRDRINv4DQ=;
  b=AzJ7xFchTW0RhJ4PVNaZ1j1vPJuNZoGAG7wyB9R6D0InaqqI1WqCMXGS
   H5oMHr5/q4Tup5nlhB2/QtB1G/pSUGq6/FZuSj/c65KAKaozepgCA9av6
   2PmwjT4Psi+fNVH1SYYD9md1cj5R3HwnG9ehBa5j+1Ud9N10zk5mOgq9v
   or0HRfgy390LJk3Y03u0GEKXPUebHcL/+2LVV8bSZbbB/djd5Z37hWX5b
   5wwJoYfIW/eJi46aJ5/wnPdU8WJTMeEQn1CNLsHYYtXA+s7juplRks1lR
   lC4//Y+eYoUIrMW+5P2qNYN+5TC4k/YREsjS3YnB68Ng3y6+c4gDgI4Zj
   g==;
X-CSE-ConnectionGUID: xXOHPMGWShKhzHPzWGIorw==
X-CSE-MsgGUID: NKs3EdGjRzS/AkrZcoPHDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9600972"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9600972"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 01:42:38 -0700
X-CSE-ConnectionGUID: NEqAtcEUTbSKFZ/yH5pTFA==
X-CSE-MsgGUID: 2S/h6wymTjCogNckadyp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47582965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 01:42:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 01:42:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 01:42:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 01:42:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 01:42:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu3OaIXLFxPqPFt0iEd5Z638fK0u7fAwft3UHQ+JhkGOd0xMTWL7isq5h49P5E+/MnoyxYRv3PloLwpKv0H45VwrNAcF/tTbY1XVT2u5FP8aKKQst8AGEX2kXkZi2gb1zdx8rYxUKAK7z/KzX3pDZbitlE9j/lBHHDt1e/mKToMhzOlkLceeWLduvSPtw89QcE210QUHJs9fVgRaqVVLT+vgJifpWhKQ+TKpE/kD9UWKe3IhN8uyw9JTQDXJVKqPmJhLTbqnA7yFr2T5zBx2amB5Og3ehiaeTjBtf/6S3m17aiKkU4cxosG9vTnimCzHc69XCcV2C4Y/LSrVguVkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhfkarctnIcHziIsD7c2rucJK7nIjCksyuRDRINv4DQ=;
 b=Qz1lIYLf58OOs+B0HMnsUAZOu+X0twqZdyJk10yGriIrmmyC6MkJpxct658QXWW9ue8rUHW5+8Ui6I877TrVvkIrITCMclwB8h/Vr9tvYcNqS8qHx+Z0sRvJfZwOG9XZDhzbu4MUnGtsNfwJzw51bEXu+2u2Umak5B4ts2cfhnyCuJ4pmJeFcu55FDPIibAHrhVen3md1+Vg36VZWmgurA46mxRWNRo7iqvUH7yN1ppww1aTiwE7t1tZUTC1g0qybkGqhNwNfQquhd2dyPJKwqTtsBYmgtQBb58yC2+ysv44Qrj8BBh914TnazNPeKPHMbATeNJMD6hqJzvTsiYLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Tue, 23 Apr
 2024 08:42:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 08:42:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Topic: [PATCH v3 02/12] iommu/vt-d: Add cache tag invalidation helpers
Thread-Index: AQHaj9VDlyamjraQqUOj1ncOzJXSgrFzzKmAgAHHaRA=
Date: Tue, 23 Apr 2024 08:42:34 +0000
Message-ID: <BN9PR11MB5276DE66A1052497BB3E215D8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-3-baolu.lu@linux.intel.com>
 <40c3b216-f3bb-4058-88a1-45de433432f3@linux.intel.com>
In-Reply-To: <40c3b216-f3bb-4058-88a1-45de433432f3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6156:EE_
x-ms-office365-filtering-correlation-id: 5cc96983-0e78-424d-c5bc-08dc6371528b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UmQyczYrZnA5NUQxdm5lVVZWeE8xclVIcnc4eDR2MXlPTzVvTTZNcjRHRUxs?=
 =?utf-8?B?bURkellwdjY2K2xYWXdlby9LRmxxRVJ0SldocHN5SzhrTitVSjErdy9RTG54?=
 =?utf-8?B?cWhJckgzdEthVUpFWTVYdUVYTldnQnRsY2tzR1hEejJBajlmT2piQ3YzZFZ2?=
 =?utf-8?B?Tys1ZW5ndy9zTTc4ajhqV3hWcGw2QXZpODFkSHdicVU0MDZiRXZ1T3p2SnpJ?=
 =?utf-8?B?cUQ2YUtZTnpKd3EyRTRrWTN4KzdMbW4vR1dPOXp1S21DeFFVcEs2RnJYbUFT?=
 =?utf-8?B?bFNGWk5CR09iakRRbTFiYStsV0VBV3FCMjVyQ0hCbGVCTWwydjVTZ2UxdDFC?=
 =?utf-8?B?cjlRdWNtL0hSTnhBV3hmZ01TZW9BMERDZ1ErYVJTUXZRQ0FJQmYrOXYxbnBH?=
 =?utf-8?B?WnhCd0ZUN3RJc2NXNk5EVTJ0UDFCZmoxdTBTUGRXTVdOZGFyWC9mY053blZt?=
 =?utf-8?B?bTRiWnp2bEJMU2lITUFvcjcrSXRvRS9rSForSnlkRVVYQWhyTXk3SHl4aUVY?=
 =?utf-8?B?dHN6SkYzMEcwMUFMQUp6OFlaTDJqZVM3cS9WZnlIVU5ROXVUOGh5N2s5OWlO?=
 =?utf-8?B?S0FVcDhta1ZyOWxLME83SHdEZDRWZFdxNzU2WmJ2dEsrRnMxRFVQUW54dUND?=
 =?utf-8?B?Z0NNSlZyd2Rmb2FZZEFXMWR3bGFweHlNeElMbzNBdGw0TnBTbW9BeXBwQ2lh?=
 =?utf-8?B?S3IxWVA1S3NTYXVYQ050aXM0RVE3MWpJUHM2ay8wQWdEbjdyMUhkWE1FZlcz?=
 =?utf-8?B?Nm5HNmVIV3NYVXBGUC9sOXFDVTh3ZUxGdDEvS1ZZbzZJeGppZFBDSUpRUEZy?=
 =?utf-8?B?VFN4bks0YXVncWZ4ZllTS3c0OFRRVEpGSC9iU3p5WnY4WjE2dmtSczhiWC9o?=
 =?utf-8?B?akh1V2gzYnVINmFLcmtIM2tiSzh1K1lKeHBDaURRcndIT0JXZGdRandkTXBB?=
 =?utf-8?B?N05od2pYTmFaYS9xcXFSN2U4Q2FXZ0NvSWhXeFpTRnlqZTBGc25CSmljd2Zt?=
 =?utf-8?B?NFo3akdTWGtQTmdubTFrRXNrbEFEemN5aDMxRUpYVHI1ZXl0SytaK2IxOWVk?=
 =?utf-8?B?ZWlnb3hJTHVSOC9qTWo0VU1iQ2J1UERGck1aU3kzZ01sd3BsWmZnV0ROcXNq?=
 =?utf-8?B?dmdGc3ZpclpFSTBVRkNYWUhVa3JUNzRnSEc4VFlyWkVFOERQU25ueWp3WTNo?=
 =?utf-8?B?NldwdkpQMkwwUkJSTFo3Z1JPQjJJbndoM3E4YjE5SnZaWXpoZ1REak1SRDlw?=
 =?utf-8?B?OUhOQWFOVENNa1MycDhoamV4MEx4L3hBQ2plclowNFNvbFNzYTBUVEhmMnVB?=
 =?utf-8?B?RWVDNVNjbnNDQndDVVBTT3hpc2lxRWVtVVdvT2RsZFNjY0liSGJiWUNHNVBD?=
 =?utf-8?B?R0JLYkYyWTErcUU5d0FodUgwUE1Nb0EwYm9UdWRwQXpkditSeE0wbzlrQlFZ?=
 =?utf-8?B?S2pXNGV2eDRYY0hQbWZSKzAyZVRPQkNPTkFJNGtPUGdRZWRsUVRmUFpDMVBn?=
 =?utf-8?B?MkZpZnE4OWx3OVpSYzRLbHVuNmhNM3RYdTA1TEFUZFp2NnRRalpzQmFCc2lE?=
 =?utf-8?B?MjQxYzNMTHh4dTllY2lLUHpHVHFPNS9nSHQwUEIvdGNNUjdWMld5RWZxVlpy?=
 =?utf-8?B?WTh1Z3JXSUpqWGVyMjZHWERrVjdqY3NnUXR5M29mQnNXT3NEN3doWHpJRFB1?=
 =?utf-8?B?RjBpY09XNzhhY2lHajZSd1BDWnFXUlBBUCthOGFzdlhLRGFCNGhzRHQ0WjlN?=
 =?utf-8?B?Z1dnUEJuK25Hc1FJQXZReXVGUXJQdmVRYU9yYVZTdmp3aWFrRWhaejMxZkZT?=
 =?utf-8?B?OGhkRFFMSzl1L3M0eFQ1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNneDd6aDJMZnYrUkhyWVE2bk1XQmQ2M1phV2FEM0xSZ094enQ4UzJndDFh?=
 =?utf-8?B?SEh5L0pPdDBaV3Z4VXNPMGtEWjdTQnRkelVvNzBMNmJxSEJteEdsWFpkVkFn?=
 =?utf-8?B?TDhaejkzWUFBRlgrY3l4WkJ0QlBGdU9EY0JEUkdCbnMvNlZCQ0hvSVlOcEhz?=
 =?utf-8?B?THR6N1BIbVRrckowc1l1UU9RK29yQkFzZWpUeFVWTFkvR0tmeGh2OXBTWjlO?=
 =?utf-8?B?S2VMblVCbW95MCt3NlpTUERjYUZjNXJ1eFJXU1F5ZjkzaGxtWG9VSExJaDdp?=
 =?utf-8?B?d0RnTkcvdmxPZTFsdHVjbUwvWHEycXVyRVB0MEVGQ2R5THREei9pcVJNcU1n?=
 =?utf-8?B?ZFk5Q0xKSHdLZzl5L3p1S2dZUXZDc1hlK21GdGNIU2tteWNsejB3SHlTc3Yw?=
 =?utf-8?B?YWx5NXMvMTRuLzlKdzlURjhFZ3c3ckM5cDNkYnZNVTViTlRqSXo0UzQwTTh0?=
 =?utf-8?B?eXJHdXE5SG95TU9aMkNmc21YSjByUW9YbTZlN0YzeWNPaFdCRDBFR20xbmRE?=
 =?utf-8?B?YUphNWZvZWk3YVJCU3lnQ2V3eEVMbTQwcDFrWVAxdEJ6QkdmNEtYUEtGNE45?=
 =?utf-8?B?MlBib0tHQ2ZUQWtZNCtqc0NvVGJLeHlyaktDaWczcDJRNnVzb2hQa3RjQm9r?=
 =?utf-8?B?eEl3ZXZtbFZTVzJXeEdOd0E1RXFXa0RKYWgzSDY3T1hYaTViUE9oN1BNQ3dV?=
 =?utf-8?B?SHQ5c3YyS1BaK05mbnJadDFsT2srckdXZG1aaGcwOVNrVmY5Q3VFVEVncWVL?=
 =?utf-8?B?VjBLQlBlSytzRGFkbEJLVGp2UDNVZDY1UGFydiswZk5EQVZJUEFuTUlkeWRm?=
 =?utf-8?B?WkRTc2UxOExmaGlRS2JhN1ZSMHNhQkJnRjJhM0lidkt3SmRRYUt4Mll0bk03?=
 =?utf-8?B?V0lWamF0QzNWSWNGVS9qbVhzNmhaeFhWaU5wbEpNdkROUHVEMjdiVVgrU2hp?=
 =?utf-8?B?bzVmMzNhZUFNelRCcFI5T3ZkZWN6cUhmQnlrbzhrYUV3QkVtWC83SEhaNGdz?=
 =?utf-8?B?aTl0Qzc2UUxQQ2lESncxdVNJQmk0OTlGSWlLbUZwZlljMk44U0swU3Z0cXRq?=
 =?utf-8?B?U29uSGVZUG5qbWM3Y1JXWGd4aTd1cGVDVzRzNFUvaFI2RmYyeFJUbVJOUS9w?=
 =?utf-8?B?ZDlhK1gzQ3B6eVZJS1RhVEV2cHlrTTRNbStaRU5xSTV3WHNJbFJUMVNFTGg5?=
 =?utf-8?B?cDloYXNiNExQVEx1ek1uV3dOaWtBaE5QK2VoMWovd1RsSGhUQjJpa1FDSGtl?=
 =?utf-8?B?OFZ6bzJXdkdHTDBYV3M1anRrUnduS1Y4a2UvWTRUdUJJYnBvUEg1K0haZUlM?=
 =?utf-8?B?elJIT3VZQk9YVFBOSVF4R0J4bUE5bndmS3RTNFZFVU9yUFBVRnlJUHYxQkxz?=
 =?utf-8?B?cVFyVXE2TGxBVXZ5Y3I4MTMyYlR2SWJscmJ2aWowQjJSa1UrcjZxSXY4cEQz?=
 =?utf-8?B?Y0MyQWU4RFo4M0VZK3Y4WlhsWEpFTXJnQW5pcWxhVWxuK1lJSTI1S2t2S1I1?=
 =?utf-8?B?OWZZREFraTFVYmYxb3E2V1ZyMVdoWVdOY2x0YldYa1VWNFRpSmxES0lrcGVk?=
 =?utf-8?B?NGNnU0gxS2pJZi8xNndONXgrdmE4SnIyZVcyS1VENEszQXRqY04xYW9hWmFq?=
 =?utf-8?B?RTF0TE43SzBUcjFNL2w4NlhiZ1VzVTRLV21BbkVtNnhLY2RkbC9TeGRWSlpo?=
 =?utf-8?B?U1JXNktUM2hpb2hDbndZejNLVjI1cVlDTmYzcExCUkFMSVppajNUcjhxVHVK?=
 =?utf-8?B?bWk5dnI3NFBuSmx4NDF6ZVpFVm5HdncvRGNDWENSTUVyU3FXY3gwbjRCTHhE?=
 =?utf-8?B?eFlUYWFPRmd6dktaNVpubi9nN0wwMDZsTk5VdXVqU0FWSmVzMjU4SzY1QUhB?=
 =?utf-8?B?Q09EeEdGd0lhaEV4TnJ6d1czWmtHYjN0RytNbU1IdnFnR2x0UDdJMjU0b3Nt?=
 =?utf-8?B?eU1RVEREOEtnMGRmVkFIVmZvRWlxOXN5WUpTZkRkb3BHOE5JUkZ0NFFJbkwr?=
 =?utf-8?B?VWJPTWVWdzU0RUlIbkYybTJVbnludW9MMU5zRkdXQk05MHc2VWwveC9SRGpv?=
 =?utf-8?B?UlBQVWQxeFMvYlZONU94R01EdENwcVprSWw4emUxWEFwT1l2eXdGMWdTQUFh?=
 =?utf-8?Q?fgQUaQspZ5QG5EsJ5CfYDj0+y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc96983-0e78-424d-c5bc-08dc6371528b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:42:34.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0WIOoafJCNWPg4w4T45IPNU/M6XpQ2bTBA+Y1LYNxjN/pdDUwXUB43YVa0C++Z+v3g+pFB1HrvXklMEqllDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEFwcmlsIDIyLCAyMDI0IDE6MzAgUE0NCj4gDQo+IE9uIDQvMTYvMjQgNDowNiBQTSwgTHUg
QmFvbHUgd3JvdGU6DQo+ID4gKwkJY2FzZSBDQUNIRV9UQUdfTkVTVElOR19ERVZUTEI6DQo+ID4g
KwkJCS8qDQo+ID4gKwkJCSAqIEFkZHJlc3MgdHJhbnNsYXRpb24gY2FjaGUgaW4gZGV2aWNlIHNp
ZGUgY2FjaGVzIHRoZQ0KPiA+ICsJCQkgKiByZXN1bHQgb2YgbmVzdGVkIHRyYW5zbGF0aW9uLiBU
aGVyZSBpcyBubyBlYXN5IHdheQ0KPiA+ICsJCQkgKiB0byBpZGVudGlmeSB0aGUgZXhhY3Qgc2V0
IG9mIG5lc3RlZCB0cmFuc2xhdGlvbnMNCj4gPiArCQkJICogYWZmZWN0ZWQgYnkgYSBjaGFuZ2Ug
aW4gUzIuIFNvIGp1c3QgZmx1c2ggdGhlIGVudGlyZQ0KPiA+ICsJCQkgKiBkZXZpY2UgY2FjaGUu
DQo+ID4gKwkJCSAqLw0KPiA+ICsJCQlhZGRyID0gMDsNCj4gPiArCQkJbWFzayA9IE1BWF9BR0FX
X1BGTl9XSURUSDsNCj4gPiArCQkJZmFsbHRocm91Z2g7DQo+IA0KPiBJIHJlYWxpemVkIHRoYXQg
dGhlIGxvZ2ljIGFib3ZlIGlzIG5vdCByaWdodC4gU2V0dGluZyBib3RoIEBhZGRyIGFuZA0KPiBA
bWFzayB0byAwIGRvZXNuJ3QgbWVhbnMgZmx1c2ggYWxsIGNhY2hlcyBvbiB0aGUgZGV2aWNlLiBJ
IHdpbGwgY2hhbmdlDQo+IGl0IGxpa2UgYmVsb3c6DQoNCkkgZGlkbid0IGdldC4gQWJvdmUgY29k
ZSBkb2Vzbid0IHNldCBAbWFzayB0byAwLg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pbnRlbC9jYWNoZS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+IGluZGV4
IGU4NDE4Y2RkODMzMS4uMThkZWJiODIyNzJhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+IEBA
IC0zMDIsOSArMzAyLDE0IEBAIHZvaWQgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFy
X2RvbWFpbg0KPiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICogYWZmZWN0ZWQgYnkgYSBjaGFuZ2UgaW4gUzIuIFNvIGp1c3QgZmx1c2gN
Cj4gdGhlIGVudGlyZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICogZGV2aWNlIGNhY2hl
Lg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgIGFkZHIgPSAwOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBtYXNrID0gTUFYX0FHQVdf
UEZOX1dJRFRIOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgaW5mbyA9IGRldl9pb21tdV9wcml2X2dldCh0YWctPmRldik7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNpZCA9IFBDSV9ERVZJRChpbmZvLT5idXMsIGlu
Zm8tPmRldmZuKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICBxaV9mbHVzaF9kZXZf
aW90bGIoaW9tbXUsIHNpZCwgaW5mby0+cGZzaWQsDQo+IGluZm8tPmF0c19xZGVwLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgTUFYX0FHQVdfUEZOX1dJ
RFRIKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVz
aChpbmZvLCAwLA0KPiBNQVhfQUdBV19QRk5fV0lEVEgsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfTk9fUEFTSUQsDQo+IGluZm8tPmF0
c19xZGVwKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQoNCmFuZCBJIGRpZG4n
dCBnZXQgdGhpcyBjaGFuZ2UuIEl0IGdvZXMgYmFja3dhcmQgYnkgaWdub3JpbmcgdGFnLT5wYXNp
ZC4NCg0Kd2hhdCdzIHRoZSBleGFjdCBwcm9ibGVtIG9mIHRoZSBmYWxsdGhyb3VnaCBsb2dpYyBp
biBvcmlnaW5hbCBjb2RlPw0KDQo+ICAgICAgICAgICAgICAgICAgY2FzZSBDQUNIRV9UQUdfREVW
VExCOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaW5mbyA9IGRldl9pb21tdV9wcml2X2dl
dCh0YWctPmRldik7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBzaWQgPSBQQ0lfREVWSUQo
aW5mby0+YnVzLCBpbmZvLT5kZXZmbik7DQo+IA0KPiA+ICsJCWNhc2UgQ0FDSEVfVEFHX0RFVlRM
QjoNCj4gPiArCQkJaW5mbyA9IGRldl9pb21tdV9wcml2X2dldCh0YWctPmRldik7DQo+ID4gKwkJ
CXNpZCA9IFBDSV9ERVZJRChpbmZvLT5idXMsIGluZm8tPmRldmZuKTsNCj4gPiArDQo+ID4gKwkJ
CWlmICh0YWctPnBhc2lkID09IElPTU1VX05PX1BBU0lEKQ0KPiA+ICsJCQkJcWlfZmx1c2hfZGV2
X2lvdGxiKGlvbW11LCBzaWQsIGluZm8tPnBmc2lkLA0KPiA+ICsJCQkJCQkgICBpbmZvLT5hdHNf
cWRlcCwgYWRkciwNCj4gbWFzayk7DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJCXFpX2ZsdXNoX2Rl
dl9pb3RsYl9wYXNpZChpb21tdSwgc2lkLCBpbmZvLQ0KPiA+cGZzaWQsDQo+ID4gKwkJCQkJCQkg
dGFnLT5wYXNpZCwgaW5mby0NCj4gPmF0c19xZGVwLA0KPiA+ICsJCQkJCQkJIGFkZHIsIG1hc2sp
Ow0KPiA+ICsNCj4gPiArCQkJcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVzaChpbmZvLCBhZGRyLCBt
YXNrLCB0YWctDQo+ID5wYXNpZCwgaW5mby0+YXRzX3FkZXApOw0KPiA+ICsJCQlicmVhazsNCj4g
PiArCQl9DQo+ID4gKwl9DQo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkb21haW4tPmNh
Y2hlX2xvY2ssIGZsYWdzKTsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCg==

