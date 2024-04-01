Return-Path: <linux-kernel+bounces-126480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7915289387F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040F41F213ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDBD8F7A;
	Mon,  1 Apr 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eaJev3+3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D3B8F5C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954490; cv=fail; b=Azv/00Lh7XBbfaLCDf619mG5ZPIZuFlA6W/UirXMKvsxWcVWLJx/2lBSLxL0yUpEvrkUZ0+ZoVtUM902tbCwzC9F0fSirGbdURWQgmGgP6odjNkfwgrtHQR/yWLGswRDuYueGBhNV2tO5xgJoo8uY1sZyOI6aLBtBDGUMGAKDWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954490; c=relaxed/simple;
	bh=UurU13gIyxTVRTlkhMeAl76YlMvHuOL7cLBANq2C36A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxeNyb//9ZgZWZE7g0jg8b2W9x/ZHIXDB+7n1RK1wczY9rCDaW9nD37DLo97BjmK99XHt0SE/R1+rb8C131xsXGG60MuXbGfCbNlh7QmtbquWDaSJB/fhi4ewUVYNdijelHCgRy0dIHEauvnRUWAY8Qj44PIOaRbSPJNqqJppjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eaJev3+3; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711954488; x=1743490488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UurU13gIyxTVRTlkhMeAl76YlMvHuOL7cLBANq2C36A=;
  b=eaJev3+3XV9NDGfPhR4ShYEsOaW7Om2WgBS2gaeK3RoT1Qr+BXc1llpp
   /hISRtJrRI/jZRXY4FzIp8n1e0BD6hPg4rElQxc6HCEzz50i1TkzhyleT
   lNjbpP1icHnc8VTpGBWyj4fg5P8u/XV6fm4yJ+V9/0VC7FbS2W5/ZrsHq
   q//9un8Jtbp+E0Jcr5vouYAGb3ZGwMvsgnOwv12BKvY+tR7mLzgLDxTGI
   WnFqgFWvg0hYpvv9M8mI5fdgMlYMA5XlNmjdquumehf3cqkrAp0Tfhzq6
   q4AM+2BQSm1Kf3F1qInEEL6vB51z5vxrKodWwjYdiPJwtWx+GmJTefGQu
   A==;
X-CSE-ConnectionGUID: b3R2B674Rx6NP9rg5xG4zg==
X-CSE-MsgGUID: 3VPnYgKbThu1NFPvXSdOyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6905665"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6905665"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 23:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="18256031"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2024 23:54:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 23:54:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 23:54:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 23:54:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 23:54:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPaqjhoA9o8bJP3yenIBLHl7oeBa6orjLXuhJXRo5xGCrwALkmHHSKrnj8+KCjrIcPs6mHZgv1BdBUcjmUwBiEhBjgwDFVASri3WamrjTZ7eD11ttxl1+alGYPvmE0m4t8bX0IidOq+quxr+m9eN4TN9oENh3MNBpZ+zEwdnocswNd7GFi4BdcILU8IQtaGZZ2t5DK/GXVW7TH4gHOVVNFBI/BNoxVc85YzpZr8qJidkyUUVw12pimDaZgbg1kswzEhoIa5DtZDvy/9qdNR+/RA1ntRQspErr8red0VV0Cc0AMjXNzqr0wqi6aS5v6E/L/2Erc+ytoeJIj3J/iWvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UurU13gIyxTVRTlkhMeAl76YlMvHuOL7cLBANq2C36A=;
 b=U4ehfke+/QMqWuZffx44rzua0XtrGpmu6Gpos3kmOYgToBK2agiC9589WYryzslvI/xniLW07zAgZ90wXNRJjaL8GyYNcTwDpMnoblX5SWWQUW66qUVYsneXRDbc9nsxrDiH1nhd6WBTwIMIplHe+biaJ8r9g6kM63HrYAV0wafWvLaMapmukwghkuhB/ND7lJuYXCDs0Ne3V/P1ySkXnDh74cKU9DAQkYBpfgOSAVXAgHJ/P20FXuZxY3yZycN+mCiESJGOTXsKxaW2+Wfy2GcPS/pUhumBgF81u6vNaln5O+BbTJziyNFs4yN6lxdNEAs6EKcuBqFlvtv6mwI8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Mon, 1 Apr
 2024 06:54:44 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::90e5:7578:2fbf:b7c4%4]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 06:54:44 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Winkler, Tomas"
	<tomas.winkler@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Topic: Linux logs error: `mei_me 0000:00:16.0: cl:host=04 me=00 is not
 connected`
Thread-Index: AQHagb5xXYUPlfLHd0KdEFyAoBFj27FQGuoAgAADYICAAt+Y8A==
Date: Mon, 1 Apr 2024 06:54:43 +0000
Message-ID: <CY5PR11MB6366A6163D4029FE505C9A18ED3F2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <4c785706-2961-4eac-b5d7-2cf89c195969@molgen.mpg.de>
 <PH7PR11MB76058497570D49516C809BE9E5392@PH7PR11MB7605.namprd11.prod.outlook.com>
 <9a0551c8-d29e-4fb8-a85e-6f7f72e0de69@molgen.mpg.de>
In-Reply-To: <9a0551c8-d29e-4fb8-a85e-6f7f72e0de69@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB7360:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+wL7bjYDXmZpJbXHtcCf3G4MhYyLTfYePFatE8G2jHOv3ZmQpvqMIkny39vdXrTNCDFhEALM5Bq9c9BALVjBwNdwGnfuypY8CN1NErvZ0Ko1wnZ0yJCsMQh5S9KRJUtg15tdZ2548SOQ84lQuYgFqbIa1PowxUl1B0LinEUs3xaqsSUOEZDlTpjlPWIBmmIvxfUwnaUOwU2JOufek5HjXsU5aSxZy3Qnr4XH561UgjAwCTjh589/hf/evgWkps0ATAHIot6eKCYC/mje9DOAXZeE4r6s+K/2O2VFTRIw4oohLpOHt592tbXef0LCPLFqCQKJvOEkCd4vejPlhN7ZOuzWCvbV5R3DMnYAe+QPtnhMj87yDHRD3GAP2snCBGqX5qGfDPitDDzk2tqw8A20lYkyAuVBLy/ijwM3G9JwrB+0TjwPbN5H6BsdjLVSvRk5yKBEVntD0T0dNYnhScAIuFnNdUaYF4NVgVyVNWWVfiNIBXU+BpND7b5qFAEDqwg5E6USA8F5VxmkJYujUi41XjYhuJ9wMeLQlZ6kDjo3yo9vPp2ENr1fo/PMxjbgk0gFMM6jZOjFS3YOwNDQm1YjT7lRtMkNh/E76i2sygY2tdb7VHw7TnZUt3/YOl+z7Ylo4y1b0j3FsQucCAHizk+KUPLItwX7rQ4MM7eCiubQjY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjJZUkd5b2U5Z0x1SVJmU3kxMDEyVHVvU0dDa0JOUzNTdHR4VXFLTHlVZEtI?=
 =?utf-8?B?R3UrZkZLZ2JXK0VlRUN4OXYreHIrd0NGUlMra3lPRkxTTTB1TTNSR3NaSGxN?=
 =?utf-8?B?amFob1hlZ3MyY0pML1ZURmtOandoWUloN0xJcjhiUllvb21wR25IR0JDaVNk?=
 =?utf-8?B?a203ODVOYjBtOG9FdWh0RktNUkpkR1h6RFBqbmtCMUtFbHJDeE9DaVZKSlc1?=
 =?utf-8?B?dzhmam5wOHZta2JhcUhkcVFXbFgwNDBXZUtoYnh6dGw2NWNpRVArelhIQnlQ?=
 =?utf-8?B?eDgwQWR6VjZ1TWZCa1k0MnRPQzMwZmN2dTJJWFhtTHJkaUpjVXVkdERXMVJz?=
 =?utf-8?B?ZzFSa2tLN0tRK3VKSzRWZHM1QlVtNENWcHM3dWNyNGpOUW90aHZVNDZQSXJy?=
 =?utf-8?B?NmNIN0pSMkZPNkVqNmFpZ0pyY3llZlVWRDdManlHTE9UR0dUVXMvUllwb2dY?=
 =?utf-8?B?ci9USE5qVjlRaHA5Nk9NdHI3OU9HVTBpOFkwK1FRSkFabmloQ3pPY0kzOStT?=
 =?utf-8?B?WEh0L1hidmNNcXVFbHhPTmZOMStBcWZtZ2xHK09YMC92bnZ1QzI2Y29ad3JN?=
 =?utf-8?B?QTBuaTdzWnZIcVc1QzJKb21wRVIrT1BabUxxSWIvLzdaV1lqZytKYmJLblBQ?=
 =?utf-8?B?RUlXaW5HbUlxZ2ppRDdqYWFDVEtrRmJFTWU5K09iUWFjWlNVMGxwZFowdTRz?=
 =?utf-8?B?aDk3aDJKZWZaZWVBeC95NUl2QmNhVHl3b0ZqeklBMHI2emNMSnNReDFoSlJH?=
 =?utf-8?B?S0RqM3A4aVdnWkNmdHMwaFBsVDlsc04wenlncnNkN3NBTHUrNWVkUXZoUVli?=
 =?utf-8?B?NHBlcFNSa3p1N0pUMGUrVEljV2UwUG9CMmFQcWRUZERyVEE1UlFGaXplN2w0?=
 =?utf-8?B?M1NhbzAyVkVMWHorVnN6ZnhFWVdTOTFQR0VYcG5YTTRHTzFOQkJxNnp3MWpB?=
 =?utf-8?B?eVc4QUtQRUh1d1NUUFd5d3BwWTduay84TFdVTkdIeThYNHZXemc3RnZITjg5?=
 =?utf-8?B?ekRkWjVqNlIxU0J2emcxbUNPQTA3Wm1xbGZ3ZmVFdy9lYlk0cHRoMlBHaUFG?=
 =?utf-8?B?TlZvZ2krYzIwNTRhRTFRdHJNYk1uN0hDL3BMemNpM3haaWJuZHkrTXRmaHU1?=
 =?utf-8?B?cC9kN3RTWEJBR2hPb1FnL3BKU1gwM2ZoOWR0V2UvUldoMTAvdGFzY2NtVGpr?=
 =?utf-8?B?aXFoWHFuQzhlTTVybHNBamM3dHdqaFc1TnlIRG1pRjRoUDdTQmN6eGh5Z3dY?=
 =?utf-8?B?NWJTc25Oa1ZpakZSL3ZKRnVPQVN1VzV6NWk4a0ZYdnRXME1SNHRCdWZHbWg1?=
 =?utf-8?B?MWE0cEduRlBHdEo0djd5RzEwdDFlK0xBMGdsU2NTZFEybTVsWG1lSG5xTTNt?=
 =?utf-8?B?Wk5GK25xY2hlVVhrQ3lZV3kxS0dkZnJSejB1OGg3elBrSzZreW5zdGhRQlRj?=
 =?utf-8?B?NW41WkoyaDhURm5lUDEzN3NhY3lzY0lrNjlqS1JDU2JwMCtiL2w3MTdRa0Zq?=
 =?utf-8?B?enBnRkoyU240VllDT1U5NkkxSXlscmxzMnNPSCt0RGdrVHFuVXI1TFlxV2R1?=
 =?utf-8?B?cEhINlpvdWY1WkVJK1pELy8wNVVYZEZGcFhpdTVxcjIxblNPcEdlZGE2THVz?=
 =?utf-8?B?SnBQdU1PMk8xam5TQmROaXVVc09oemNsemJIdGJieWNWckRZVkNiMjVQVHhi?=
 =?utf-8?B?RWs4cVYwWVhRV3N0K0lBYWtXWUlIMCtYNXFLM2hSK2QyUVVSOGpoUG95c21k?=
 =?utf-8?B?RVprWnZDczVjNE5yeUNLSTNVSU5PcW1ET2V4RG4vamtzK0Q0YTRVRkxFUFdD?=
 =?utf-8?B?TlV2RjdOZlJVQm9RYkplTnpBZm1NVFFEdlBabXUyUkN4ZTlWMDVSVngvN3JI?=
 =?utf-8?B?V1pjOHFJc1JSM1ZUZ0tXWGRFQ1BBbTlCRm9oMVZqTGx3R2pmLzhFbGM2dXEy?=
 =?utf-8?B?cE1STFFOcCsrU3JnR1NwOGM3cGNxSWZ0RWh0dHJ6NzBkOGg5ZStvdSsydnFW?=
 =?utf-8?B?eXZhemx1Tm84MEN0cHZIV0cwK1hCRnkwU25iS2dnWU53SGNicVdqeW1pL0dm?=
 =?utf-8?B?UHY3Rk5zdml6YmRGZmg3L2ozMVJwSURxSkxIUDl3cERuOHBFa2NvdWIxL3BK?=
 =?utf-8?B?UFpScXJWYW1wb0lVTVJwM2FrcUZoTjBLM3dpbG9VVVR6SUljTUdMeTNHMjJS?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3620b516-70de-4ed6-731e-08dc52189ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 06:54:44.0107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tB2JtOmgImh2zdTFr+98Rp7rx+ccaAn+pdY1hjV8PYPsF8TfcgUf7HgmzeLNm1Ag0c+xWe/1QzoNfQJ3dgrJE4k3b+Fa+pxXDfhWv45qDyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMzAsIDIwMjQgMTM6NTYN
Cj4gVG86IFdpbmtsZXIsIFRvbWFzIDx0b21hcy53aW5rbGVyQGludGVsLmNvbT47IFVzeXNraW4s
IEFsZXhhbmRlcg0KPiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiBDYzogTEtNTCA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IExpbnV4IGxvZ3Mg
ZXJyb3I6IGBtZWlfbWUgMDAwMDowMDoxNi4wOiBjbDpob3N0PTA0IG1lPTAwIGlzIG5vdA0KPiBj
b25uZWN0ZWRgDQo+IA0KPiANCj4gRGVhciBUb21hcywNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9y
IHlvdXIgcXVpY2sgcmVzcG9uc2UuDQo+IA0KPiBBbSAzMC4wMy4yNCB1bSAxMTo1MCBzY2hyaWVi
IFdpbmtsZXIsIFRvbWFzOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgTWFyY2ggMjksIDIwMjQgMTI6NDkgUE0NCj4gDQo+IFvigKZdDQo+IA0KPiA+PiBP
biBhIERlbGwgWFBTIDEzIDkzNjAvMDU5NktGLCBCSU9TIDIuMjEuMCAwNi8wMi8yMDIyIHdpdGgg
RGViaWFuDQo+ID4+IHNpZC91bnN0YWJsZSBhbmQgc2VsZi1idWlsdCBMaW51eCA2LjktcmMxKyB3
aXRoIG9uZSBwYXRjaCBvbiB0b3AgWzFdIGFuZA0KPiA+PiBLQVNBTiBlbmFibGVkLg0KPiA+Pg0K
PiA+PiAgICAgICAkIGdpdCBsb2cgLS1uby1kZWNvcmF0ZSAtLW9uZWxpbmUgLTIgYTJjZTAyMmFm
Y2JiDQo+ID4+ICAgICAgIGEyY2UwMjJhZmNiYiBbUEFUQ0hdIGtidWlsZDogRGlzYWJsZSBLQ1NB
TiBmb3IgYXV0b2dlbmVyYXRlZCAqLm1vZC5jDQo+IGludGVybWVkaWFyaWVzDQo+ID4+ICAgICAg
IDhkMDI1ZTIwOTJlMiBNZXJnZSB0YWcgJ2Vyb2ZzLWZvci02LjktcmMyLWZpeGVzJyBvZg0KPiBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQveGlhbmcvZXJvZnMN
Cj4gPj4NCj4gPj4gQWZ0ZXIgc2V2ZXJhbCBBQ1BJIFMzIChkZWVwKSBzdXNwZW5kIGFuZCByZXN1
bWUgY3ljbGVzLCB0aGlzIG1vcm5pbmcgSQ0KPiA+PiBub3RpY2VkIHRoZSBlcnJvciBiZWxvdzoN
Cj4gPj4NCj4gPj4gICAgICAgWzI5MzU3LjE3NzYzNV0gbWVpX21lIDAwMDA6MDA6MTYuMDogY2w6
aG9zdD0wNCBtZT0wMCBpcyBub3QgY29ubmVjdGVkDQo+ID4+DQo+ID4+IFRoaXMgc2VlbXMgdG8g
YmUgbG9nZ2VkIGZyb20gYG1laV93cml0ZSgpYCBpbiBgZHJpdmVycy9taXNjL21laS9tYWluLmNg
Lg0KPiA+Pg0KPiA+PiAgICAgICBpZiAoIW1laV9jbF9pc19jb25uZWN0ZWQoY2wpKSB7DQo+ID4+
ICAgICAgIAljbF9lcnIoZGV2LCBjbCwgImlzIG5vdCBjb25uZWN0ZWQiKTsNCj4gPj4gICAgICAg
CXJldHMgPSAtRU5PREVWOw0KPiA+PiAgICAgICAJZ290byBvdXQ7DQo+ID4+ICAgICAgIH0NCj4g
Pj4NCj4gPj4gd2l0aCBgZHJpdmVycy9taXNjL21laS9jbGllbnQuaGAgY29udGFpbmluZzoNCj4g
Pj4NCj4gPj4gICAgICAgLyoqDQo+ID4+ICAgICAgICAqIG1laV9jbF9pc19jb25uZWN0ZWQgLSBo
b3N0IGNsaWVudCBpcyBjb25uZWN0ZWQNCj4gPj4gICAgICAgICoNCj4gPj4gICAgICAgICogQGNs
OiBob3N0IGNsaWVudA0KPiA+PiAgICAgICAgKg0KPiA+PiAgICAgICAgKiBSZXR1cm46IHRydWUg
aWYgdGhlIGhvc3QgY2xpZW50IGlzIGNvbm5lY3RlZA0KPiA+PiAgICAgICAgKi8NCj4gPj4gICAg
ICAgc3RhdGljIGlubGluZSBib29sIG1laV9jbF9pc19jb25uZWN0ZWQoY29uc3Qgc3RydWN0IG1l
aV9jbCAqY2wpDQo+ID4+ICAgICAgIHsNCj4gPj4gICAgICAgCXJldHVybiAgY2wtPnN0YXRlID09
IE1FSV9GSUxFX0NPTk5FQ1RFRDsNCj4gPj4gICAgICAgfQ0KPiA+Pg0KPiA+PiBVbmZvcnR1bmF0
ZWx5LCBJIGRvIG5vdCBrbm93IGF0IGFsbCwgd2h5IHRoZSBNRSBuZWVkcyB0byBiZSB3cml0dGVu
IHRvLCBhbmQNCj4gPj4gd2hhdCB3YXMgdHJpZWQgdG8gYmUgd3JpdHRlbiwgYW5kIHdoYXQgdGhl
IGVmZmVjdCBvZiB0aGlzIGZhaWx1cmUgaXMuDQo+ID4+DQo+ID4+IENvdWxkIHlvdSBwbGVhc2Ug
dGFrZSBhIGxvb2sgYXQgaXQ/DQo+ID4NCj4gPiBMb29rcyBsaWtlIGEgdGltaW5nIGlzc3VlIGJl
dHdlZW4gc2V0dGluZyB1cCBIRENQIGJ5IGdyYXBoaWNzIGFuZA0KPiA+IGRldmljZSBwb3dlciBt
YW5hZ2VtZW50LiAgSSBkb24ndCB0aGluayB0aGlzIGlzIGEgcmVhbGx5IGFuIGlzc3VlIGlmDQo+
ID4gdGhpcyBpcyBoYXBwZW5pbmcgZHVyaW5nIHBvd2VyIGN5Y2xlcyBzdHJlc3MuDQo+IA0KPiBV
bmRlcnN0b29kLiBDb3VsZCB0aGlzIGJlIGJlY2F1c2Ugb2YgdGhlIEFkZHJlc3MgU2FuaXRpemVy
IChLQVNBTik/DQo+IA0KPiA+IEFueXdheSB3ZSB3aWxsIGxvb2sgYXQgdGhhdCwgd2lsbCB5b3Ug
YmUgYWJsZSB0byBwcm92aWRlIG1vcmUgZGVidWcNCj4gPiBpbmZvcm1hdGlvbiBpZiB3ZSBhc2sg
Zm9yIGl0Pw0KPiBUaGFuayB5b3UuIFllcywgSSBjYW4gdGVzdCBwYXRjaGVzLiBCdXQgcmlnaHQg
bm93LCBJIHdhcyBvbmx5IGFibGUgdG8NCj4gc2VlIHRoaXMgb25jZSwgc28gSSBhbSBub3Qgc3Vy
ZSBob3cgdG8gcmVwcm9kdWNlIGl0Lg0KPiANCg0KVGhpcyBwcmludCBpcyBpbiB0aGUgY29kZSBw
YXRoIGV4ZWN1dGVkIGZyb20gdXNlci1zcGFjZSBvbmx5Lg0KU2VlbSBsaWtlIHNvbWUgdXNlciBz
cGFjZSBhcHAgaGF2ZSBoYWQgY29ubmVjdGlvbiBvcGVuZWQgYmVmb3JlIHN1c3BlbmQNCmFuZCB0
cmllZCB0byB3cml0ZSBhZnRlciByZXN1bWUsIGJ1dCBkcml2ZXIgY2xvc2VkIGFsbCBjb25uZWN0
aW9ucyBvbiBzdXNwZW5kLg0KVGhpcyBpcyBub3JtYWwgZmxvdzsgdXNlciBzcGFjZSBzaG91bGQg
cmVvcGVuIGhhbmRsZSBhbmQgcmV0cnkgaW4gdGhpcyBjYXNlLg0KDQpUaGUgcHJpbnQgY2FuIGJl
IGRlbW90ZWQgdG8gZGVidWcsIEkgdGhpbmsuDQoNCi0tDQpBbGV4YW5kZXIgKFNhc2hhKSBVc3lz
a2luDQoNCkNTRSBGVyBEZXYgLSBIb3N0IFNXDQpJbnRlbCBJc3JhZWwgKDc0KSBMaW1pdGVkDQoN
Cg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IA0KPiBQYXVsDQo=

