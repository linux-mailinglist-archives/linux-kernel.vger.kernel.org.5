Return-Path: <linux-kernel+bounces-163316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC88B6957
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7101C21E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC312E5D;
	Tue, 30 Apr 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e718czRf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF7101C5;
	Tue, 30 Apr 2024 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450306; cv=fail; b=st7KPW4mdL8pyo1gGpD004KI752r9D7vs0PhjJ31S8oNtBNuIHWILKKDPs/0ehy+IZandHZjST1Otg/kbyHdKihB68LxtJId4zEj5gEo9rc10HnZ0fmLVo7/G4gMrnneLmsL0hOJ1+H9eoe9FsSsxvsT1ZvBfD5TV1CQQwcJ74s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450306; c=relaxed/simple;
	bh=1NQC+Ad2AkK+ot0PqGcrGzDCjxKvEmqk2RHJkikKbeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IqzkmdS/f3oQtAMcR2yypKYmfcdufjg4so4Hl7knkFxUkSvxRb1J4gC7PfMJEg0bdoPSARxHVMwO4bWLZ2h6FStBmNtzLqt/e8C1ngatYHjC1VI0h6zZvhKHT8/mOpuFQpwQWpwRzOG02vH4uIw4Zk8L93KUu3Xcv3oZBzm7Z0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e718czRf; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714450305; x=1745986305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1NQC+Ad2AkK+ot0PqGcrGzDCjxKvEmqk2RHJkikKbeQ=;
  b=e718czRfvW+a2lrNioOutteNdRNylugpSRUvhh0Gk4DAkgwtqrHVInwC
   AYu3/4nhCTm5DqNZ1wcFi29JoYlNH3VzREpB0O3RP3pQQ+OU1vuer5Fvd
   dnDa6dtZX0LEl4wyBGaYfsOvGwdTKLUa2We4w17TCr/b0HPkaGxGRwlnq
   WCd2nHU60an/4byjCO117wZgYMwRKHayYXCsD7rmmyWUC842ZJcTm3A+n
   AXqNvVXxj9+dn+zhbcZfbB9kWAZ+p8kGHXwVOvXhMGEk3tdyiYQxmWhNX
   S671EcW7I2h/gmYL1QCGpJEN7yGirj45Tag4034w4tw5ENusiXiqWhPYV
   A==;
X-CSE-ConnectionGUID: Q4lJEFdLRsqdU6KTuU/9sg==
X-CSE-MsgGUID: lPHD0iXhRJG0pFws55nDxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="20754151"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="20754151"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:11:44 -0700
X-CSE-ConnectionGUID: 7RodtkYzQiWVBMK4sILO9w==
X-CSE-MsgGUID: TWvb5XIsQFecwdYC71jKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26728349"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 21:11:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 21:11:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 21:11:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 21:11:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 21:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKWQkRCcFGp8fqEseb+AqOTyu2iLd7JbKn9wwm7jsIRn/HFq1nOGUXR+7rmpb/NxUhvc5fl3tKgYlXsjZ8S3XGvDD0OoDgkHAM4gkDvqZWk/49ywGP4VVrGP6V/TZDR/6KhInUqguK4QBjEgAwoiAXED1ziqTC0oR8BgMUA83C1vmOJ9PMzT2Oi2oa7I7PFVOJsldib57l0Z094kHsqG4Yd349X3vuN7LB14WV8Kukw5grOW7h70QqBEJ/DqZTh11PdL5LboQSnjjEmLYbRLA/RBU72S6YVyfLe+aZROYyKS2IRWhh/xUJq+HMstOJgt8Z+INeMpZIbWvDRNo27z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NQC+Ad2AkK+ot0PqGcrGzDCjxKvEmqk2RHJkikKbeQ=;
 b=J2ilABRSt/AITBdllqR1r6/mPym5/qFQWSnb3IraRcmemGHd3V+ZxwQPYmJmdF/soHYE2VKA5PXL4TnaQg2eeaPXT3m2JpzVmTKvMD7oSOgS8JTfQPLCMn+u7c4sDIZwgLMfBKwFkMckMAm/TS8gPVQqJrDtPzOt7XZX2KUZNJsyzyJ0mGD6dRWUSow2AToShjJfM+NEX64rwH50qm65QBv06tdyNRKJWF6obQGRpErvuUOnhYR8KAtnk1rkkGak5hvovPMvKsnebFtKoD4tr0/cYyIYH6TTi6hUbh8QSln0Hs96jB2Y/muKJ/y9RPWuO7b2Q85UMELUeWvOQd/70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB7451.namprd11.prod.outlook.com (2603:10b6:510:27b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Tue, 30 Apr
 2024 04:11:40 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::ed72:f69c:be80:b034]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::ed72:f69c:be80:b034%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 04:11:39 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <alison.schofield@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dax/bus.c: fix locking for unregister_dax_dev /
 unregister_dax_mapping paths
Thread-Topic: [PATCH v2 2/4] dax/bus.c: fix locking for unregister_dax_dev /
 unregister_dax_mapping paths
Thread-Index: AQHakEeWieoZVKHeP0OLyYS+sQIww7GAGe8AgAAuf4A=
Date: Tue, 30 Apr 2024 04:11:39 +0000
Message-ID: <d4047d21f0b88c5baee9140adb56e86afca24b3a.camel@intel.com>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
	 <20240416-vv-dax_abi_fixes-v2-2-d5f0c8ec162e@intel.com>
	 <6630487879c61_148729427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <6630487879c61_148729427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB7451:EE_
x-ms-office365-filtering-correlation-id: 7241bc20-cd96-4bc1-a759-08dc68cba2d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?T0VTaTNkOFNneDFTa1JrRnYwM1BWY3dpTWtubmZhVHhtR0V4SEtFcmFvL2px?=
 =?utf-8?B?UEYvUEt5TDhjSWd6T2JLeC9UQkswQ3ZoLzdnM0pMRUF1TTNPOEc1NHJVTXJu?=
 =?utf-8?B?NVc4SStncnI1VUVtdGZjTVNITytZbjQ2YzJJVjduY0RzcmYzV2s0ZXVLU1RJ?=
 =?utf-8?B?ZlExbFVTNW1sSjNER2htOWpTbzNpNHJGZnllQStpYjhmZFIyNXNEZWl3NE9B?=
 =?utf-8?B?MG4vT00zdmVrK2RLVmxtSDZnUHRyN1pGZTR4cGtoMlV4ZWVJanhMUHZESDdJ?=
 =?utf-8?B?RWZVNlVLeEliM3VOUTd4QStJSjJQa3N6b1VTU1p0SWdEM3UrMEhXZHZHbHFp?=
 =?utf-8?B?eFBXNDNWMVpKc2MyYnkwalIva0lTcGo0OG1VRmM4Z2ZBWTZkZGtNUG5jaFM2?=
 =?utf-8?B?ZGZBNS9ERlRYRE5OYjRiR1U4UUVEbmU0aFNWVjc3OFBmZEdDWjNNNVVVa2dV?=
 =?utf-8?B?NUZYc1Y5WDFZaGdZMHdLZkE3S0xoWFhPVnlaUTNvcW44eGkzWXRJQzVvWDRM?=
 =?utf-8?B?ZTc2TXR0U3BLdWtlVUFWRFROTS9EY0pKY0NDMzRpTGEwWFhVeHJvU0RrRkZL?=
 =?utf-8?B?YllEbFd2b2RBWlZCVmNLeUo0R1daQmpqRXpZSlRMeERFaHZvalErL1cxV3pF?=
 =?utf-8?B?WnhSQndtYzJWWWFwNnpTRm1BTXNDc0wwcnVNK2Y5Zk1HcDRRTFBzaDhlaStr?=
 =?utf-8?B?TE1obnNsRzZ0Sml3cHBiZjZlS0dpcVVBNnRZQ3FxbHhsclAyUnhUOTd6d2k5?=
 =?utf-8?B?MzFUTkYyNVJxSlMzSkJGTU5uMi9mSHJIWFpNWGFrWkd1OGQzZXkzVzBWTk5l?=
 =?utf-8?B?RGtPYmxSdlF1RmVTcE01RzRNZlNYSDJsU0h5TDRtbTJ6RmJ0SGVHRThsT0RB?=
 =?utf-8?B?dWlUaVZWOWU2YTRKeXl1ZG11dERqVlFSelgrMzFEK0o4bTczYjNEYU9mL01k?=
 =?utf-8?B?ak5EYnZ3MTlaZkZMU1JIVzVwbHhYOWhOSnVwYk5hVUxyK2xMUHVwYnBadzMv?=
 =?utf-8?B?UWkyUWJ1cGY0d21hTEk5aGcvdlNKa0loc2d1ZjFHRThBb2kyUG1NTXpFWVRi?=
 =?utf-8?B?dmFQNnRrSmtlNlg1L2ViZ0JrZzdBTUc3dTh5T3VRbVVWYjRyb09maDFkY01C?=
 =?utf-8?B?M3IxMFk0VjduS0ZJTnY5RnBFT2VGTXZWb0dLTmJ2dTkxenJ2L0NUMDIvTzBa?=
 =?utf-8?B?a2F0NFdDUFR1MDRUYVNpaXZiNGtEVVBRZUVGTlJ1TnZoa1psejhXeG1tRmtG?=
 =?utf-8?B?ald3ZzdxV1Z2T0J1cmJvZkZDaGs1RjdCaDBDTnFXQmpKdFJ4QTdKMXUyZGlP?=
 =?utf-8?B?eEFKd3ZJZUJ5NmJSb2FZRTZaVVN6NWc0RkFCc3dZNzhhTTRNUnJ3cThUdjFl?=
 =?utf-8?B?M3lwTGwwbTRUT2VuaWVFRTFTY2UzQXFsdys1SVJDek9ibnh4QlNnWDZ5TXBn?=
 =?utf-8?B?ZlRqTk1rRFZTWXF1MW1lcktzcUxuM0xuZmlXWWhqeCtHZzFIaGpCbDRtVk1n?=
 =?utf-8?B?b2JCcW1hS1FqamF5WWNGSmtZaHBRQW9uVXVMWXBEa216VDZ4NzN4K255bDRK?=
 =?utf-8?B?TXBBZXRlT0MzN09HdFpTQ2o5c2FVdGUwY20rcUhwaDdKMHplSlkzZVc3VlVB?=
 =?utf-8?B?UlZyVlZ2QngyczZSdVAyd1JHT1F1QXpkd3pxZk1Wbk90VG1acGR6blQvb2lW?=
 =?utf-8?B?SFdyajVSRjg3eHhFbTNoMWNlM2pEVnJNdTNkbmtBcUY3TnRabk1WT2RvMGw4?=
 =?utf-8?B?UEJkY1RYQURzek42ZHhwbndvWkxDUVQ1Y0J4VTFGTGluVlFqamQrQldTa2xZ?=
 =?utf-8?B?akwyTmVNWmdiK2c0SlJ2UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk5pdGVPcGxzWURqSmZoR3N2VW94RVhLdFAwRUZNSzQ2Y1NmNFN0MTFIbHdS?=
 =?utf-8?B?TjhCcXY1czZRbGlOSENOLzdvUWpLRk0yeDMvclRXSXRSQlN6WmxtL2Qza1ZJ?=
 =?utf-8?B?L1VuT2t5cVMrcmJjN0pwbjlzdnFISWdiSmhtUk1MdmVYaUl0N3JHcWczWXJD?=
 =?utf-8?B?bnZBZDk1MDNLRkk0TmhUQVR6Vjh4ODdjaDVTZHQrWFF6VEZCQWtWSm41UnRE?=
 =?utf-8?B?cUpzVnNBTWM4VWpTMlNKcVBOY3hjRFlzWmRtbCt1bFVXZU1LQjd2K1VFWjM4?=
 =?utf-8?B?cElVL0tpajAxaTk1azhLdHp6YlNqRDJINFRQUlRqalZhMUkyeVJ6NGlvbnQw?=
 =?utf-8?B?L2s5MW5qbTdFV0RBRXB6Wmd5bjJsVUF1b3JOVkgreTVoR3hYVWRUMzFabExX?=
 =?utf-8?B?b29Kenh4S2RkMUJRMnFZdW5rUi9NUUJJRlgrWnJCTTJxLzVJMWVGMkxwY25I?=
 =?utf-8?B?RTNmY2ZETVBZOVVXN3BUOXdINHROT25lNXBXWTA4R25CY0pLVytyckRBeHNV?=
 =?utf-8?B?M2lyanVYejRQdkprbmJuMFZjcUs0RzBzeEVHL1VJcXI1VHJoM3djL1h2WGZR?=
 =?utf-8?B?U2JGZUxhcXcrWUxNemUzbWZ2VHdod3RKRWZRL0Nua3piN1c1UXFGdWRhd3l6?=
 =?utf-8?B?RVFkcFZuWEVaOVNaemx4c1ZOL3pjYnZobzVKM1RiMHVBV2tScWp3RmdWaTA4?=
 =?utf-8?B?S0UvcTdiY0puYnNhNEk4SEZyVXFnbmRVU0IwSGNlZTdRRWNuazFzOFJGODBG?=
 =?utf-8?B?ZnBiY2tyNVhmd0NnbGxXMEhjdGM4VEZwaUh6aEoxbk0wQmViZjV6MTFPVk0w?=
 =?utf-8?B?aXBxM0xSR2x5Yk5xWm9MWmdWNUx4RXRETmFURjVadWxZOUlSL3RwWU1ZUHFZ?=
 =?utf-8?B?NVdBZVVsN0xRU3czOXV1YTQzZTBCK2taaUY2UHJSTjdPT21hdFdnYXhjTnRM?=
 =?utf-8?B?U0RqNFZCMjV2V2luTE1wMk0wNHFuRlBBUTFQcGt5TzlOeG1YUXBsbFZpeXZU?=
 =?utf-8?B?T1dDQnIrQWZ6S3g3am1TaCswU1QrMCszYTNJK0RKR3JZckxFSDcxMlJCOWFr?=
 =?utf-8?B?cUo3NUJxdEdueGE2cHBpa1JlVENLanpXV2NtdEdFWG5zdUFYVGpzckhkRFND?=
 =?utf-8?B?WnFub3VXMU43NjU2WFhPSDhiZVZ0RTFFK0REOHBSaVYzWGkzUG9wcHpvS0Ix?=
 =?utf-8?B?Y1AwTGEzL1Fad0pGZXdMQWl4ekF4Sm9zL1R6dGhQcmgzeUVzWWZhSTdMaTB0?=
 =?utf-8?B?enVocXUyOThaVXVvdTl2K3JMaklWaytqcmFDSEhrTEZYZVhaczY0U3IwcVlJ?=
 =?utf-8?B?SWZGM0RwUnhocGY4TjRMQWVBckZGcHNNZU9LZW5PT0dBV2U4UGtnZW4ySXZi?=
 =?utf-8?B?MjAzaURiejYzUk9RRlVpNytqY3R6SE9WM1JPV1RRVWp1L3M4dHk3aGxGcEhV?=
 =?utf-8?B?dVdmRlcwZUVFTVZ5UHZobWFsREloSXNXQUdNK2FBRVJTTDl0STN6VXFZK0U4?=
 =?utf-8?B?eTAvN21RcEtzcm5Zck1PVWo4ZW43cVlWdENlU0l0Y0lsaUNXY0xYN1oxamZt?=
 =?utf-8?B?aHMrUmFDMlFsSFZRN2JXMnVpMlFMVnpUTkJ0VnR2dWMyaUI3YTVoT1hLSEM1?=
 =?utf-8?B?TGpqMGUwQlRjS09iQ3l4bDJmN2VyTSsyNEtEYkd5QmoyTHZWeGRhSzVnMnNx?=
 =?utf-8?B?NVErdUhVaXpWbE5kV2cxNUNqSSt1YjZtRkRDWndOUUFLb0JqK3FFV3FCdUlM?=
 =?utf-8?B?NUM5WGdLTWF5dkhEYStIQUNaWEJxWThiL1BoZjEzRVRuRDlQejhGdjAzN2tR?=
 =?utf-8?B?VkVzRkhhVktYdHpqQjRrbnoya0lGSFVqZ0ZDMzkwZHFlQjREWWtyV0tiampB?=
 =?utf-8?B?REhlbklwWmpWZGNEZm4xc3cxcWxKOHpXOE55NGcvcXpwM0o0bSs2bFg4N0gz?=
 =?utf-8?B?VXZ1R1Nva09OU2tNZndRei95STdFRVBSUytoSGpNVnhUMmVTOEpPdkFER2li?=
 =?utf-8?B?RG1tK1ZDY2M4bDNEYzlXWmsrVkQ5LzZCaXRhNExiYVFvay9CamtpRDl6R1Er?=
 =?utf-8?B?TEMxM2dTMENGQXZIQ2JRRGRvelFwYjVqMXhyNlNWYUF1bWUvSllUYjhrRTcz?=
 =?utf-8?B?dkRTSEFXYlpmdFpqc3MwNEFiWDNrNjB2V1ZUeXJNeGJtblJMcWQzQlBTdUx5?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2EB1B2B24180E4BBFB746C7C048BBDC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7241bc20-cd96-4bc1-a759-08dc68cba2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 04:11:39.8909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lSqiZK/ZsKNpYKPZUB9oZFTd0HkRUe79rPnIjgPMOzjx1zUzjoK7YSV/v7dntF5f3EbBMycKePOO9kDGhM0myCm7XkxIc2z+o0uFAKet9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7451
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTI5IGF0IDE4OjI1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiBDb21taXQgYzA1YWU5ZDg1YjQ3ICgiZGF4L2J1cy5j
OiByZXBsYWNlIGRyaXZlci1jb3JlIGxvY2sgdXNhZ2UgYnkgYSBsb2NhbCByd3NlbSIpDQo+ID4g
d2FzIGEgYml0IG92ZXJ6ZWFsb3VzIGluIGVsaW1pbmF0aW5nIGRldmljZV9sb2NrKCkgdXNhZ2Us
IGFuZCBlbmRlZCB1cA0KPiA+IHJlbW92aW5nIGEgY291cGxlIG9mIGxvY2sgYWNxdWlzaXRpb25z
IHdoaWNoIHdlcmUgbmVlZGVkLCBhbmQgYXMgYQ0KPiA+IHJlc3VsdCwgZml4IHNvbWUgb2YgdGhl
IGNvbmRpdGlvbmFsIGxvY2tpbmcgbWlzc3RlcHMgdGhhdCB0aGUgYWJvdmUNCj4gPiBjb21taXQg
aW50cm9kdWNlZCBpbiB1bnJlZ2lzdGVyX2RheF9kZXYoKSBhbmQgdW5yZWdpc3Rlcl9kYXhfbWFw
cGluZygpLg0KPiANCj4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byB0ZWxsIHRoZSBzdG9yeSBh
IGJpdCBhYm91dCB3aHkgdGhlDQo+IGRlbGV0ZV9zdG9yZSgpIGNvbnZlcnNpb24gd2FzIHByb2Js
ZW1hdGljLCBiZWNhdXNlIHRoZQ0KPiB1bnJlZ2lzdGVyX2Rldl9kYXgoKSBjaGFuZ2VzIHdlcmUg
anVzdCBhIGtub2NrLW9uIGVmZmVjdCB0byBmaXhpbmcgdGhlDQo+IGRlbGV0ZV9zdG9yZSgpIGZs
b3cuDQo+IA0KPiBTb21ldGhpbmcgbGlrZToNCj4gDQo+IC0tLQ0KPiBjb21taXQgYzA1YWU5ZDg1
YjQ3ICgiZGF4L2J1cy5jOiByZXBsYWNlIGRyaXZlci1jb3JlIGxvY2sgdXNhZ2UgYnkgYSBsb2Nh
bCByd3NlbSIpDQo+IGFpbWVkIHRvIHVuZG8gZGV2aWNlX2xvY2soKSBhYnVzZXMgZm9yIHByb3Rl
Y3RpbmcgY2hhbmdlcyB0byBkYXgtZHJpdmVyDQo+IGludGVybmFsIGRhdGEtc3RydWN0dXJlcyBs
aWtlIHRoZSBkYXhfcmVnaW9uIHJlc291cmNlIHRyZWUgdG8NCj4gZGV2aWNlLWRheC1pbnN0YW5j
ZSByYW5nZSBzdHJ1Y3R1cmVzLiBIb3dldmVyLCB0aGUgZGV2aWNlX2xvY2soKSB3YXMgbGVnaXRh
bWF0ZWx5DQo+IGVuZm9yY2luZyB0aGF0IGRldmljZXMgdG8gYmUgZGVsZXRlZCB3ZXJlIG5vdCBj
dXJyZW50IGFjdGl2ZWx5IGF0dGFjaGVkDQo+IHRvIGFueSBkcml2ZXIgbm9yIGFzc2lnbmVkIGFu
eSBjYXBhY2l0eSBmcm9tIHRoZSByZWdpb24uDQo+IC0tLQ0KPiANCj4gLi4ueW91IGNhbiBmaWxs
IGluIGEgY291cGxlIG5vdGVzIGFib3V0IHRoZSBrbm9jay1vbiBmaXh1cHMgYWZ0ZXIgdGhhdA0K
PiB3YXMgcmVzdG9yZWQuDQoNClNvdW5kcyBnb29kLCB1cGRhdGVkIQ0KDQo+IA0KPiA+IMKgDQo+
ID4gQEAgLTU2MCwxNSArNTUxLDEyIEBAIHN0YXRpYyBzc2l6ZV90IGRlbGV0ZV9zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiA+IMKgCWlm
ICghdmljdGltKQ0KPiA+IMKgCQlyZXR1cm4gLUVOWElPOw0KPiA+IMKgDQo+ID4gLQlyYyA9IGRv
d25fd3JpdGVfa2lsbGFibGUoJmRheF9yZWdpb25fcndzZW0pOw0KPiA+IC0JaWYgKHJjKQ0KPiA+
IC0JCXJldHVybiByYzsNCj4gPiAtCXJjID0gZG93bl93cml0ZV9raWxsYWJsZSgmZGF4X2Rldl9y
d3NlbSk7DQo+ID4gLQlpZiAocmMpIHsNCj4gPiAtCQl1cF93cml0ZSgmZGF4X3JlZ2lvbl9yd3Nl
bSk7DQo+ID4gLQkJcmV0dXJuIHJjOw0KPiA+IC0JfQ0KPiA+ICsJZGV2aWNlX2xvY2soZGV2KTsN
Cj4gPiArCWRldmljZV9sb2NrKHZpY3RpbSk7DQo+ID4gwqAJZGV2X2RheCA9IHRvX2Rldl9kYXgo
dmljdGltKTsNCj4gPiArCXJjID0gZG93bl93cml0ZV9raWxsYWJsZSgmZGF4X2Rldl9yd3NlbSk7
DQo+IA0KPiBUaGlzIGJlZ3MgdGhlIHF1ZXN0aW9uLCB3aHkgZG93bl93cml0ZV9raWxsYWJsZSgp
LCBidXQgbm90DQo+IGRldmljZV9sb2NrX2ludGVycnVwdGlibGUoKT8NCg0KRG8geW91IG1lYW4g
Y2hhbmdlIHRoZSBkZXZpY2VfbG9jaygpcyB0byBkZXZpY2VfbG9ja19pbnRlcnJ1cHRpYmxlKCkg
aW4NCmFkZGl0aW9uIHRvIHRoZSB0YWtpbmcgdGhlIHJ3c2VtIChpLmUuIG5vdCBpbnN0ZWFkIG9m
IHRoZSByd3NlbS4uKT8NCkkgZ3Vlc3MgSSBqdXN0IHJlc3RvcmVkIHdoYXQgd2FzIHRoZXJlIHBy
ZXZpb3VzbHkgLSBidXQgdGhlDQppbnRlcnJ1cHRpYmxlIHZhcmlhbnQgbWFrZXMgc2Vuc2UsIEkg
Y2FuIG1ha2UgdGhhdCBjaGFuZ2UuDQoNCj4gDQo+IEkgZG8gbm90IGV4cGVjdCBhbnkgb2YgdGhp
cyBpcyBsb25nIHJ1bm5pbmcgc28gbGlrZWx5IGRvd25fd3JpdGUoKSBpcw0KPiBzdWZmaWNpZW50
IGhlcmUsIGVzcGVjaWFsbHkgc2luY2UgdGhlIGhlYXZpZXN0IGxvY2tzIHRvIGFjcXVpcmUgYXJl
DQo+IGFscmVhZHkgaGVsZCBieSB0aGUgdGltZSByd3NlbSBpcyBjb25zaWRlcmVkLg0KPiANCj4g
T3RoZXIgdGhhbiB0aGF0IHRoaXMgbG9va3MgZ29vZCB0byBtZToNCj4gDQo+IFlvdSBjYW4gaW5j
bHVkZSBteSBSZXZpZXdlZC1ieSBvbiB0aGUgbmV4dCBwb3N0aW5nLg0KDQpUaGFua3MgZm9yIHRo
ZSByZXZpZXcgRGFuIQ0KDQo=

