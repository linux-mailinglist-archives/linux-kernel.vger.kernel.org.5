Return-Path: <linux-kernel+bounces-134734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A889B630
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A40F281B03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A781860;
	Mon,  8 Apr 2024 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ywnhxx68"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726DEDF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 02:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545051; cv=fail; b=Iqyk1Er1yU9fzCluDkfJnTyr6bl0442Cvfy+vRPOiK2/XdrM8KNl1YoNcNE7C36rUgvQbXsGGTTzri2jTBWIqpnWh0RynRXtn3OISggXsmW6zZoIMY4e2nH+sqF4OTmvb4Zg53BCZ2nwavg5ShfAbYmE1CcO1cyyaY9oMnsx7Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545051; c=relaxed/simple;
	bh=VKsJkjHn6cEDVJ42vWtolkB2S/xQM2Tjs6nlE+mMzyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tzQroJpF0F8Qc2JLlz0po0ZKrPclWOV69T6XZaryUJ4vz5r40MedwwBTS4wetXHKkIbM9zrhB8H+EgajBYxLKYAFRhkeaTDZL5KqLXh91CQLcvvN0SaSVpuJcTHRycesiSCkT1+eYV9WZaep+0MuhN5DxTt4sLt4ErJ+GqtYw74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ywnhxx68; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712545050; x=1744081050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VKsJkjHn6cEDVJ42vWtolkB2S/xQM2Tjs6nlE+mMzyg=;
  b=Ywnhxx68kkAq0eFIrEMYXcqakhNgigVYykObDLfvTiTqbFuvMkmfOQcp
   gVaw+9mq4gvrKU+x7s+ixM5eoejC40XMUp8CAZIdDJiLewxIDxG8LSogN
   +YHN9IzqMbL4dY9gNAaO1D5WTzoUiqkGnqwLGPheBDuMvvualojKvY8FO
   Xc01R9YbQy7BW96SAuk/gDEM5u1ytvMlZ6TKgjY9m0WMMHCd8BZImx8KV
   +bqN0aHw2mHspdg0pfCY3zUNr4GimEzqH+jR/4RIk/o9qSdmXVELOOfxb
   TUwsVtoYgsQoJfrmaEVA8G2D3IVPLbNSwEXteFSkkVzS7MPbV3s8zy9wK
   g==;
X-CSE-ConnectionGUID: Yy8TP2zrSs+NRlWL+phfYQ==
X-CSE-MsgGUID: M83ffJo2QZSoNxLZeWbA8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19243798"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19243798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 19:57:29 -0700
X-CSE-ConnectionGUID: 3dR39270SX+T2ayk3GnZtg==
X-CSE-MsgGUID: cMmF+VWwT+eYgizNDRPaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="57202353"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 19:57:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 19:57:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 19:57:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 19:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jtrw2CB114tIrJ8uo2s/hNC5M6QvRAZI2+1C2KhhUv+WxfnXNEEX6Wn2LU7IgyobejNwvSibQ9m218FY6mO7L2JGr/5B7OcEbid+ShkeOFJaS3jujc9RugUdIo2hEiw5MTPn5vWip+6eNzVl6mg2WN9bDClHPVrIfzx4HleSqn98XUDJdH/yJA5RzIpjMajT/ECs9kXmCpMQWG37Ld+o+GUTPwunKE7vi6sm91t5fCCnFGWxup2F7kxxFjnejID5DeIudoaqo18eT0nbUHaulOE/6FLI4GGOnST0qXZ0F2k61y5JoACIxpUHSATbUHUYN/GeKQ9C4BeyaCIMVhTffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKsJkjHn6cEDVJ42vWtolkB2S/xQM2Tjs6nlE+mMzyg=;
 b=GnjltJjq0aGHyoHKuvxafMYFIk6608l72ldx4vySlxlzOTiMEAZldw7B6P51RJ1VObrhXtudp4q/nM2r9morL9dOzBaQvU6SvJno5Ln3eeGkZXnVPI8LYa9WCvrzYGkY5Yk6t+lDYZ54qRaCSBcAuTx4avnYnhV7A8IA7wb/JZziNKc4mngHO0F9Wrd2JQISVttduHewlzEjbdq0ewWmOGR7tvwkIad5gXDEdWEi1206wAM4J22MkqYkZflOBg/kzyfeTsXwvP5LfV7NbQRJkCPuZLKIDioejk2L5aB7Aq+yQjfzPebECKapBUg/Vr+M7i3AoQbvw4hEyvkTf6wqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 02:57:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 02:57:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Thread-Topic: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Thread-Index: AQHafltsByQh7ckHwEyzV3jciVckfLFMzEuQgA+rHYCAAUuU0A==
Date: Mon, 8 Apr 2024 02:57:26 +0000
Message-ID: <BN9PR11MB52761B8A7D11C39DDE0FFA5E8C002@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-8-baolu.lu@linux.intel.com>
 <BN9PR11MB52762CD9DB4CB9DFA3C26A6C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a0e2bde5-1ec0-4b42-aa52-5f86e9e0822e@linux.intel.com>
In-Reply-To: <a0e2bde5-1ec0-4b42-aa52-5f86e9e0822e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5073:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6YV0QPdRw7uAF6DFC6njM4Tl2VJGI5h92fs+PoOxwysiK0yXw/xEk8dLcHQZUJ2AoNNZ6QbuVqfIsNRpjx9c6Otb7lWnjiYUBFJPJWSoUjTOB8FHXgmaLnddkzUYNaOMd7ZLdD0c+Ucfo26Ifb7iXONnC1N2vLKV3FUdHJJDR1rooOTKYJGFtEaK3bKYUta/eubNgMFedYKNscZF+9XsP1/w3THp+GQSKBIK3S2JSBwyDzyJ5slWTks/JAmLnv98vcWNhvE3IcH9Kob2+fmDkG0Ma4Kb4oQ9s+4Ag2R5rA57BLjcYf+pz+v6vDEW5Ii78/vkZkcYGH5o6k43qhvVUkVK0mOXUggy8zS13hhhOnJVLwh98JAfHQXeassV8NP/zl7knNg+LAbcvTjvTlkze3t+UW2Mc2sWPYfkxh+T6/b2yqDQuDGkhmhUiJfPzXAmy/9wUrpGWPOXxpMXEMWc/y1AWddN+1kpJgbe2Y0uH/Qz8s7SY5WEkY40AYno6AVEsbS7OHmVLSTJE9cKAUpesyelB551O3rgqiriDVAV5FDL0ZR8ad/yFOz5gTTnT9J/6RWxa/FzWLauAixavLsALB4mzb2bmpuB6RTMYcR+2YAe0OTRcFm6pyUFoqyNR7RO73aAg6NVngrAl/7kEZtnf0UQdUjPG1OhAvNbynKYwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJWZjM5TGduMWI3TEZtQ1hOcTc4cE1aakxuenpiUVZXMGFYVGs5WUQyMGhp?=
 =?utf-8?B?L1pWeGF5U0pXakcvOFA3bjNhUTlvMGVuWksvTUFHZjhtZzdaanVFeUhVamZP?=
 =?utf-8?B?NWc3ek01OFVxK0dyTTZuU0VnNWlxa09lcytab2FYeTNyNi9oaEtUd3lvTlY3?=
 =?utf-8?B?dHdaaU81L2JPUm9yUEd4cjg3M1FGUEdQUTNOUll6cHpsRVRpcGVIdnpCRXB2?=
 =?utf-8?B?dDY5Vzk0TTU2NHJQMEh4U1gzdE82RGFBeXY3WkpPQlJhbnBnakIvOVB0SXo3?=
 =?utf-8?B?dzRsVitxemNBS1JBMGxYek9TUGpWUTgyQ0hsQncrTGI2UWxBSENxZmYwWVp3?=
 =?utf-8?B?UVZnRGFPMlhTZGU4ODBrUGlBNEFZSHZTSSs1b294RHY2cjVZZlFqSnpVSnFT?=
 =?utf-8?B?Z04rVXhxYytXbDlGamFJVEtoVHlYcEg4K3ZzR0RNNE9FZlp1MC9MVXljUkox?=
 =?utf-8?B?Mkk1UFMxM1duK1NPM0lHaGRGWncySlNkTkRkemlUdHh3R1RjckxsNW9qSFUx?=
 =?utf-8?B?ZzRNUDZsbDJqVmdkUGhWK3ZmOUpVUXRabEY2V0JFRjBNUEUzTU9hWXNDSTIx?=
 =?utf-8?B?UC9VTTdQd3B6RnNmSjBwYkJRS2lCTlBuSEhidW1WZk5oMlBQK2pSZGZaOWMr?=
 =?utf-8?B?V3BYSHRWbEFzMVRZL3g4T0Q0VDFDcEhzSjNCZmlwcXBuSkFNa2dvMUZ1YTVv?=
 =?utf-8?B?cFYwaDNmVWRsYVV5T29oaXJHS255Zm9jeUJMczVwMnkwamgrOWFsd3ZBZ2tW?=
 =?utf-8?B?Qkw3YURwUmd2KzllS1U1em5MRkliOEpYMHZnZlVtNlBSRU5YVDBjVEd3ZHl4?=
 =?utf-8?B?VG12UjQrNk1wTWxPN2l2WDVNNmxzSTNETGpINUdvSXJzYlFyRjA0UFFUcWpq?=
 =?utf-8?B?TXdjNmR0M25FY0tRajlxN2E0LzdHQ2NhK1NLYUJnZGtiRS82YzFiazNRMG9N?=
 =?utf-8?B?MXYrQUJWbGNvdmhDdXBya29Lekd4WTdDc3NKQ25QejhDZTUramtjRDVqYU1D?=
 =?utf-8?B?WkNIWmt0akROakNDdHM0QVZRSnNDeS9qTmphekpKSjd5R0MxbUNBQmVLZCtz?=
 =?utf-8?B?aVdIdGhlRWNTRXBMTUFIZEszejkvZ3haMDBTZnJ3R3NlK0tMNHY4NXJJYXhw?=
 =?utf-8?B?NERIQUtBQ3U5czl1TU9abUtEQmVac0JrTE9hd3c1UEludWRCNWQvY0VVVUl1?=
 =?utf-8?B?cUtzeWlYRVE0OGV1NmZwYnQrd1RTV1JmRzRnclh2TDU0ZUlTNG4vNm1lM0p2?=
 =?utf-8?B?WDhMdXVzWUxmMldrRnZNNmVlVHJTdlcrYmhJRFVyNXdKTG1lN1VhVFFybXlL?=
 =?utf-8?B?dnRGSWoyK25FN0J5QkJ3Q1hMc3EvWG8yM1RGL016UWZQWWlYMXZpWVM5V3hT?=
 =?utf-8?B?bXAyTlZjckI2endpL1hnYkRLL1ZRL21kT3cvV2NiVGZ0WW5LOUxWS3lXWkN4?=
 =?utf-8?B?OFV6VHRLMzdJVTFzOTZ0MnVTTlJOMk9GaFRMUWpYVWp2ZzNSY29XQWowTjVJ?=
 =?utf-8?B?WVZXTDh6aWN3akYyaGs5V2pqb01IbVZ1RXpHTmJ2VWNMdWV4UlErWjJpU3Bw?=
 =?utf-8?B?MExnd1ZGWnJrVW8vblRLdUtnT2NaZnlTUTFjRmdpcFEwalFsdXZWSi9vbld6?=
 =?utf-8?B?K0tuVXVtU29ubHp6Yy9WMmFMTE94cVBkOVB6TGxyQ3pZOU9FMGtDdXlhMDg5?=
 =?utf-8?B?YStRd0labmpDUWF1UGtTcE51Skg5MlNWQUJyeVZINXZtK0pCNmtzbEtoUlJx?=
 =?utf-8?B?VkNPYjkzSi9GTWh2WnpXUjU4MHQxeGZIVDZFdTVjWXN1T1JrSUpyNjEyTzdY?=
 =?utf-8?B?WlYxV3pMSHZaM1RmQXByY2xpY2JDdUdaeGVPc3VCcURYVUdzOTQxckx2L0d1?=
 =?utf-8?B?YXRYaEttY29ldUpNRkJkNHlvTWRDVHc2UnZhN2JFWXpRclZmNHI4REU0UHFO?=
 =?utf-8?B?aGdVNUlFZDJQaURNZmNkWTBIUm9nTzNWUmNsbVJUU0ZjRFhUaGJFcWtjbzVZ?=
 =?utf-8?B?TFYrNTh1d3RWOTZhK2FpWXdvU2hDNjBLWk1qQ0VEYTVBa0VBckRWMEFZbHJw?=
 =?utf-8?B?aGNDOG9lTmVOYnlKMFdlTlA5U1NjQjJzM2VieUh1M3hzanNHVG5xbXVobUV1?=
 =?utf-8?Q?5mlAN4/J4+V45LV/qpQc/+qeG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b5c396-4ff3-4b37-58cd-08dc57779f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:57:26.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rKPL60D7Z9o0i4cRNwdkFS/APtzboc1ZOyWaHM8UYZC4IVylcfb4Q54VElCZp4VcJSOL4gQFVlWWJhmlll7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEFwcmlsIDcsIDIwMjQgMzowNiBQTQ0KPiANCj4gT24gMy8yOC8yNCAzOjUwIFBNLCBUaWFu
LCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCAyNSwgMjAyNCAxMDoxNyBBTQ0KPiA+Pg0K
PiA+PiBVc2UgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKCkgaW4gc3dpdGNoX3RvX3N1cGVyX3BhZ2Uo
KSB0byBpbnZhbGlkYXRlIHRoZQ0KPiA+PiBuZWNlc3NhcnkgY2FjaGVzIHdoZW4gc3dpdGNoaW5n
IG1hcHBpbmdzIGZyb20gbm9ybWFsIHRvIHN1cGVyIHBhZ2VzLg0KPiBUaGUNCj4gPj4gaW9tbXVf
Zmx1c2hfaW90bGJfcHNpKCkgY2FsbCBpbiBpbnRlbF9pb21tdV9tZW1vcnlfbm90aWZpZXIoKSBp
cw0KPiA+PiB1bm5lY2Vzc2FyeSBzaW5jZSB0aGVyZSBzaG91bGQgYmUgbm8gY2FjaGUgaW52YWxp
ZGF0aW9uIGZvciB0aGUgaWRlbnRpdHkNCj4gPj4gZG9tYWluLg0KPiA+Pg0KPiA+DQo+ID4gd2hh
dCBhYm91dCBhIHNvZnR3YXJlIGlkZW50aXR5IGRvbWFpbj8NCj4gDQo+IFNvZnR3YXJlIGlkZW50
aXR5IGRvbWFpbiBpcyB1c2VkIHRvIGZha2UgdGhlIGhhcmR3YXJlIHBhc3N0aHJvdWdoDQo+IGNh
cGFiaWxpdHksIG9uIGVhcmx5IFZULWQgaGFyZHdhcmUgd2hpY2ggZG9lc24ndCBpbXBsZW1lbnQg
dGhlDQo+IHBhc3N0aHJvdWdoIG1vZGUuIEl0J3Mgbm90IGFueSBraW5kIG9mIHByb3RlY3Rpb24g
ZG9tYWluLCBoZW5jZSB0aGUgT1MNCj4gaXMgbm90IHJlcXVpcmVkIHRvIG1hbmFnZSB0aGUgY2Fj
aGUgc3luY2hyb25pemF0aW9uLg0KPiANCj4gQWx0aG91Z2ggSSBob3BlIHdlIGNhbiByZW1vdmUg
aXQgc29tZWRheSBhbmQgZm9yY2UgdGhlIERNQSBkb21haW4NCj4gaW5zdGVhZCwgd2Ugc3RpbGwg
bmVlZCB0byBjYXJyeSBpdCBub3dhZGF5cy4gSG93ZXZlciwgd2UgbmVlZCB0byBtYWtlIGl0DQo+
IGNvbnNpc3RlbnQgd2l0aCB0aGUgaGFyZHdhcmUgcGFzc3Rocm91Z2guIFRoYXQgaXMsIGhhcmR3
YXJlIHBhc3N0aHJvdWdoDQo+IGRvZXNuJ3QgcmVxdWlyZSBhbnkgY2FjaGUgaW52YWxpZGF0aW9u
IGluIG1lbW9yeSBob3QtcGx1ZyBwYXRocywgdGhlDQo+IHNvZnR3YXJlIHBhc3N0aHJvdWdoIHNo
b3VsZCBub3QgZWl0aGVyLg0KPiANCg0KeWVzLCB0aGF0IG1ha2VzIHNlbnNlLg0K

