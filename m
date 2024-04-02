Return-Path: <linux-kernel+bounces-128647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43B895D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E61F1C222E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5C15D5B1;
	Tue,  2 Apr 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmCKtWrW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0014B081;
	Tue,  2 Apr 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089044; cv=fail; b=Xwc5GEPDqt5a71E3TRa6oxM7ierT/Y2qWiy22LTbTpQSkOxrtCi1DzpiH2a9J++P/RaS+uADclO8N5CgbUI1gEo1gjxEkvc4Er83u/f5UT7d1OAVrrMfCIms+wfDTzmVv3vziawWpfpRk01d50M2ZTci418RaElyVvZD5TPlsUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089044; c=relaxed/simple;
	bh=a9H6LreUHY4xC02mbDV3YSBkCqIhlVp2MNZxPJV14sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VA/fLYPHPRiecytlPYKq6qr/aeOqDzeryzP7I1fBVKEYihhocliy0aQkUjx4jNtVUgmxNUIrCZ61D9aOmaDf2ugO3uehW7TClPGhVMHqE27c90zs5kmJjO45Kh+mrWIgRFDWWDw/I6Dotj/9kr2Xx2dzmJHdifocalWqO8TUZuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmCKtWrW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712089044; x=1743625044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a9H6LreUHY4xC02mbDV3YSBkCqIhlVp2MNZxPJV14sk=;
  b=OmCKtWrWpQpbIizM1yYJ1M1jg7uDohvYMBOU5M0Lp5ol+Q+oDaQD8ZG6
   sFQUX2ThyfBwIyeXkq/YGYJ8XfGT9v/JfsKqQoG8nqnp6JUlT5lrX8Nh/
   uiYnmrfN0j8LasLYYKCt48VMeTTGg9mjMSallAknIIxJpXfNltdVvA+hn
   FC+M4bwoCSrJQ/9pVFCH2eQn5Jz/yndCjKDKUfcDbH9xWWxPzgnMGW+Fh
   RYyjW3hp1NC8CCCNUSR3a3jViANKFfKybZaqgZb8dTtTOViMrkL8pp6xk
   Q94QuzHI1ChB+aWtpEk6GKd5FE58DcaJ91I/nTZoiOgAiK05WW8vj5KFY
   Q==;
X-CSE-ConnectionGUID: 9LN+yFPZQIOrTE+7S73vkg==
X-CSE-MsgGUID: 4NMCy5gtRt+B5YvacBv7Sw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7214652"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7214652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 13:17:23 -0700
X-CSE-ConnectionGUID: fNQkPKrhQd6dWXRvxqCrBg==
X-CSE-MsgGUID: TG403OxwRti1aS1Ixe+zjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18297750"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 13:17:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 13:17:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 13:17:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 13:17:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 13:17:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvtrPKm7MxO0MGRzhOYyOom+7oXiCjzkCV72CtJTy/2Ty7RghSViDhb1sCL9874kY0j/3bBqVqgWn6rlMpFS5DZEaZn5RLPw9is6duGR5VxPHc4C6r0c/lK/e8gN6JXU4T2NsgEeuicTDDWGg0eQedxXZ1OuyJcKR5kDBApo+4T/7VHEbvU3+b2QxdiFIlHubg+1eqmV+zvmA/m+c5AYOydByVYi9FsQ8l3kPHZ6wWOrPTK/cWFRNK57Y0aZ9b7/l+qFkZhApJ7fOlqRyynQqNM1SQ9TzPnXY8jOVkc5WE8ZGot8RWNbhgQZx0XSCVrz+B7Yak+WViPntB67z+BrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9H6LreUHY4xC02mbDV3YSBkCqIhlVp2MNZxPJV14sk=;
 b=KxBWRTCjgMZtm1GlzErHXktRws6wsOJMSPhdBM6ZIP7fnns2pEXHJJvBqrB9VctBI5slxzwQMPQlUtQGdQkmJBH+g/MPiB1pVbIZlHs2ZbncZWIW6MNcLBzbWkRAuL78Dea+Gc1LK7duDUcaOIlENpsj+WwIb4+ktI7yaUzpYnHupbfozhyy3uZYk+OzyyEuu+NUmwmq06n5wvSSDXWs7Ge3ynu9oE2prebb0ToBmqBMaQ/yjVCS9XcerxK6ppk98L6NM9I3bA0GAxe5T0UHcVBSXxtgOLvPyohRMuu2XM0yvf5HCh8TY9pfJO+nMKqLzXuG14j1gxDOwXmNy6yT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 20:17:17 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5997:c66:5650:3bed%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 20:17:17 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: lkp <lkp@intel.com>, "enno.luebbers@intel.com" <enno.luebbers@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"luwei.kang@intel.com" <luwei.kang@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
	"atull@kernel.org" <atull@kernel.org>, "shiva.rao@intel.com"
	<shiva.rao@intel.com>, "russ.weight@linux.dev" <russ.weight@linux.dev>, "Rix,
 Tom" <trix@redhat.com>, "Pagani, Marco" <marpagan@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: dfl: fme: fix kernel-doc comments for some
 functions
Thread-Topic: [PATCH] fpga: dfl: fme: fix kernel-doc comments for some
 functions
Thread-Index: AQHahLEswb4PSHpoq0eVRcCRbyUjhrFUZxEAgAEFDoA=
Date: Tue, 2 Apr 2024 20:17:17 +0000
Message-ID: <a5145b2cd2c36e3efd78985c51366b082949cfe5.camel@intel.com>
References: <20240329001542.8099-1-peter.colberg@intel.com>
	 <Zgt/wftzm4xthfio@yilunxu-OptiPlex-7050>
	 <fb49e921-a765-4828-bcfe-b2b4e623c5ea@infradead.org>
In-Reply-To: <fb49e921-a765-4828-bcfe-b2b4e623c5ea@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|PH8PR11MB7022:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymMshNVEe2Ytz5W7EM4FJLKtc5U1aQJamI+0wQghxO+Mn5dI44NMU6WccAP7EC0KIm5IRnyVFLdCXrubwQo3f7RR1RgiR5rEVB/FTGPINis/S0KPJrU/3IkA63JJE+dHcr2024xjWACnWrF00ThEorvXtqrv8YyZvs5ljS0hUcCsjvu4OFhZMpDBKtYJpA7Rjuqvq2ejGT+0RnzJGzdXVCyVMEbM5dOJQBkPvD4a8rXWBNt+QdnX5vZmygJJdXXsfV7r9WbzUYeyB890TLDVv1MNlDzy9QQyT0HLEZyxyhtgpM0VtfXmj1+I1Tl0ce4MzojzCKm03PEVocCRvEiAKg9ii4HCOrJDCp2aNXw9ABLJzKcWry/J3A/IYrr2YMbe6PzUVrtetUBORRlpZF4w2e4+6hx7elfi3AzAp0TO7VeBWLg/iJ3JXi2t155UoNbPChjOSrJjjldkqxfFcwCu4F/uj1NtItIr5zX/aU+TlipZITP79Qu7Vf/xJl8chizIwHY0rCUKlxLDxtWZPRTvmAWWQMCHsw1QPhEwR9C8G02IYfm5Dd9kbQcAD1KplFoAgl+jYQ+WS9kbkByTL4TWXwv419s7Devw+isIbZHNdxx6PkMhNzcySNb52TFiwapVmrjpZ0EAZ44xrlZiLikR0ynRb9eNCaa26Dminit2OBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MldoUU5Bdmd1WEJQdDZ3YVpzSGszRC9QdjZtNHlEQlFhNTV5bERuL3hTSzNH?=
 =?utf-8?B?KzBIOU9weUNpRzJzT25QdnVRdG5oaHZSWWRmSEFraXg2TlArWDhWcm8ybi96?=
 =?utf-8?B?QWRzTGVhdHhLVGFINnFXbklvOFk2SktGWUhjQWt5dlN1VXVQSllKWE4yUFU4?=
 =?utf-8?B?dTNjYjBkaUZjVzZ4Q3A3c2hTcU12MlBxNVJUSHNQdGI5R3lsQ1p6Qm1IOTBI?=
 =?utf-8?B?aEpyNHBYTEcwMDNTV3o5S1NtdjAvWmUwbDNCd1JtNGJWa1JCSVBQMkl0SkZr?=
 =?utf-8?B?cHFvTlZxSUdtR0ltck9HaitlZk91TFFIRjBEdmF2NFFXVUVTdEhOSmMyZkdC?=
 =?utf-8?B?cEVZdGxJTXhpMWo1STliaGY1Ky93aG53MVpVWjhLWjArTGhhbWd2c0JVcmc4?=
 =?utf-8?B?WXU4OVpkZmQwLzV1Q0ZZNTBDQlVGWjd5Z2N4cEM4K283MUdFMnkreDFtczFD?=
 =?utf-8?B?VDBJOGdpL2dzbzJEYXYxR1dNWUJrbHpRV1BCSXpYWjlxNWQ4WFo4THhDcGdG?=
 =?utf-8?B?TWpvakNJbThQc2prVUhuMHExcVhxY3cwaEZTTC9mNjhydWVOb3NRc0xQck1R?=
 =?utf-8?B?dlA1TllnQnQ5ejJiVEptVlgyTTJFc0FtSXNQZG9zcW1FMEtQcnN1bjMvakhM?=
 =?utf-8?B?andrZjRFZnFwbTZFZmFMYXpMSHVOWVl3WUZyYlZGbmI0dFlpL0FmMExGdytq?=
 =?utf-8?B?b2o0MWFIRTFneWRQY293VXJuaE1WdmRlWVY2b0NsL2hDQVNtdURvUzJ0dGNm?=
 =?utf-8?B?L2xjMURveVpYa2o3bjUwQlNubHFUbnc3RVErWU0rMldsSW5ud29hYWx6emZo?=
 =?utf-8?B?YldnSTJIMUxNMDhDaS9KdnhVc3BUclNXWXhPQlVIZ1FUV05oRmV5MU5WRXQ1?=
 =?utf-8?B?WFR5YzNWRHF1MXJJT3BKMGtENUZJeElpUk9PenhCNWdnUCt6RHZXYW0zY1NF?=
 =?utf-8?B?OVUwRE9USE1pcWhHWUFQdlg2UTVmUW8yeXREYzBkNkpaQTFJTVRNMlhwK3J3?=
 =?utf-8?B?dWhINEpvdWZ0bzc5Rk05azFMWVVLdnpIRWUwT0pSYmlFcWlpRlViWTZXSTRt?=
 =?utf-8?B?MnNBbXFRNVRYTWZFK3VjQm15ZFJYWHEzeXoxNEdoQ3BOM1dXMXJOSnRpeDdL?=
 =?utf-8?B?dFpEUHRDVlhEWFZONS93SXNpWnYvMUkyUWQzQlpPVzNLc0lhbkdPSldrdDZE?=
 =?utf-8?B?ZWlJdVhZTVBqZExvWEhBMVYxOTNNZ05iQjdlOVA2N3o3ZFlQMVZWL3JSWUNx?=
 =?utf-8?B?ZUxuU1Ayckppd0FvVHgwb1RTVGhSRGIzWGxoQkZKRTE0TzJDTHJOSjlDejhQ?=
 =?utf-8?B?T3d6RDJPeit6aXNFUVk3bTZWc3JsRTEveDZlY0pDUEdKa09DZmdqaGNFemVO?=
 =?utf-8?B?TWZWa0Q4dHpoeE9xRDNteHppSStzaFNEU09CdHRrRXdZcGpwUmRaY0pveWJi?=
 =?utf-8?B?QmhMLzNGSDZINi91VWJjUzdxQk5yOS9JUXdTOXh4Si9HYzJ5TWh6cnJvTHc1?=
 =?utf-8?B?S29qczU0OS9ZY2FHTm9sOUhvN1JMbXpxTXhZbGltbWNVQVhVS0d6cFRCVkpH?=
 =?utf-8?B?U0tINWN2RmprNi9RelN0cjdGZTJ4WGYxNXg0Mm4xVXZNN09kcnFpNWtGUE8r?=
 =?utf-8?B?RlFHY2lscVR1d1hacndwMXBuNXRodFZaTjVzSnJzcFBobmVJLzk3TEJxb1Rl?=
 =?utf-8?B?M0JIWHJzc0hnL1ZXR1o2SHIyaWFGQ2FIN2d1dEplZkg5cEpocEdEQ1ZpZ1Ev?=
 =?utf-8?B?MGJITStnbkNxK3VKWVVlVkUvRmdvelJsY3ZqT0VYdW93c1Rza25FZ0VYZFBq?=
 =?utf-8?B?YlZ3VVI2TTY2V1loZlgyVzhuTlZxRTVmNjNXd3o2Q3VtZVZGekUxM2pZRDZs?=
 =?utf-8?B?SmZST0xmbVc5UlVjUmhjODhYTVhEWjRsN1BDcEdhKzlvNjBYRmhDcC9WRWJi?=
 =?utf-8?B?TFZzWFZMRVpCREZoSEdBUmlCVzhXcHIxZmEzNTdaR3hURUN5WGhIVlMwZW9Z?=
 =?utf-8?B?MERvOWszUkFTTmQ5SjlBeUdNRkFqQU4zWnU0WTdScjlxWEF0QjdQOG52dFRE?=
 =?utf-8?B?dDNJc3lRU3VPd2ZXemNWMTk2K3hwOHBEaEJCL1NFbmlybDlZY3Q1K0pDZ3cy?=
 =?utf-8?B?Z1E1TnJSTlU3MkhiVjVPaWtPcGxTVXdXMDJvS2xTc1ZGQnlIRzZJVDJSNWpr?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BC9C0C743303841AFD791917557D5AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a1aa5d-0c47-41d2-c55e-08dc5351e4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 20:17:17.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIFaRTYaVYmEjI+eFWv4J6yd6jGuo5qyFmj+6RxXvTiip5UCqv3euEFW3PIzOWwKOrEIOrGDKUkVXBUW3bHdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA0LTAxIGF0IDIxOjQyIC0wNzAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+
IA0KPiBPbiA0LzEvMjQgODo0NyBQTSwgWHUgWWlsdW4gd3JvdGU6DQo+ID4gT24gVGh1LCBNYXIg
MjgsIDIwMjQgYXQgMDg6MTU6NDJQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90ZToNCj4gPiA+
IEZyb206IFh1IFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+DQo+ID4gDQo+ID4gSSBkaWRuJ3Qg
cmVtZW1iZXIgSSB3cm90ZSB0aGlzIGV4YWN0IHBhdGNoLCBidXQgYW55d2F5IHRoZSBwYXRjaCBp
dHNlbGYNCj4gPiBpcyBjb25mdXNpbmcuDQoNCk15IGFwb2xvZ3ksIHRoZSBvcmlnaW5hbCBwYXRj
aCB3YXMgaW5kZWVkIHJlYmFzZWQgaW5jb3JyZWN0bHkgb250bw0KY29tbWl0IDc4MmQ4ZTYxYjVk
NiAoImZwZ2E6IGRmbDoga2VybmVsLWRvYyBjb3JyZWN0aW9ucyIpLg0KDQo+ID4gDQo+ID4gPiAN
Cj4gPiA+IGxrcCByZXBvcnRlZCAyIGJ1aWxkIHdhcm5pbmdzOg0KPiA+ID4gDQo+ID4gPiAgICBk
cml2ZXJzL2ZwZ2EvZGZsL2RmbC1mbWUtcHIuYzoxNzU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFt
ZXRlciBvciBtZW1iZXIgJ2ZlYXR1cmUnIG5vdCBkZXNjcmliZWQgaW4gJ2RmbF9mbWVfY3JlYXRl
X21ncicNCj4gPiA+IA0KPiA+ID4gPiA+IGRyaXZlcnMvZnBnYS9kZmwvZGZsLWZtZS1wci5jOjI4
MDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3INCj4gPiA+ID4gPiBkZmxfZm1lX2Rl
c3Ryb3lfYnJpZGdlKCkuIFByb3RvdHlwZSB3YXMgZm9yIGRmbF9mbWVfZGVzdHJveV9icmlkZ2Vz
KCkNCj4gPiA+ID4gPiBpbnN0ZWFkDQo+ID4gPiANCj4gPiA+IEZpeGVzOiAyOWRlNzYyNDBlODYg
KCJmcGdhOiBkZmw6IGZtZTogYWRkIHBhcnRpYWwgcmVjb25maWd1cmF0aW9uIHN1YiBmZWF0dXJl
IHN1cHBvcnQiKQ0KPiA+ID4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWHUgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNv
bT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIENvbGJlcmcgPHBldGVyLmNvbGJlcmdAaW50
ZWwuY29tPg0KPiANCj4gQWxsIGtlcm5lbC1kb2MgaXNzdWVzIHdpdGggdGhpcyBzb3VyY2UgZmls
ZSBhcmUgYWxyZWFkeSBmaXhlZCBpbiBsaW51eC1uZXh0DQo+IGJ5IHRoaXMgY29tbWl0Og0KPiAN
Cj4gY29tbWl0IDc4MmQ4ZTYxYjVkNg0KPiBBdXRob3I6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPg0KPiBEYXRlOiAgIFRodSBKYW4gMTIgMjI6Mzc6MjAgMjAyMyAtMDgwMA0K
PiANCj4gICAgIGZwZ2E6IGRmbDoga2VybmVsLWRvYyBjb3JyZWN0aW9ucw0KPiAgICAgDQo+ICAg
ICBGaXggVz0xIGtlcm5lbC1kb2Mgd2FybmluZ3MgaW4gZHJpdmVycy9mcGdhLzoNCj4gDQo+IA0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYyB8IDMgKystDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYyBiL2RyaXZlcnMv
ZnBnYS9kZmwtZm1lLXByLmMNCj4gPiA+IGluZGV4IGNkY2Y2ZGVhNGNjOS4uOTZjYjI0Nzg3YWIx
IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYw0KPiA+ID4gKysr
IGIvZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYw0KPiA+ID4gQEAgLTE2Niw2ICsxNjYsNyBAQCBz
dGF0aWMgaW50IGZtZV9wcihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LCB1bnNpZ25lZCBs
b25nIGFyZykNCj4gPiA+ICAgKiBkZmxfZm1lX2NyZWF0ZV9tZ3IgLSBjcmVhdGUgZnBnYSBtZ3Ig
cGxhdGZvcm0gZGV2aWNlIGFzIGNoaWxkIGRldmljZQ0KPiA+ID4gICAqIEBmZWF0dXJlOiBzdWIg
ZmVhdHVyZSBpbmZvDQo+ID4gDQo+ID4gVGhlIG1lbWJlciAnZmVhdHVyZScgaXMgZGVzY3JpYmVk
IGhlcmUuIEl0IHN0aWxsIGNhdXNlcyBidWlsZCB3YXJuaW5nPw0KPiA+IA0KPiA+ID4gICAqIEBw
ZGF0YTogZm1lIHBsYXRmb3JtX2RldmljZSdzIHBkYXRhDQo+ID4gPiArICogQGZlYXR1cmU6IHRo
ZSBkZmwgZm1lIFBSIHN1YiBmZWF0dXJlDQo+ID4gDQo+ID4gV2h5IGFkZGluZyBhIGR1cGxpY2F0
ZWQgaXRlbSB3b3VsZCBmaXggdGhlIHdhcm5pbmc/DQoNCkFwb2xvZ2llcyBmb3IgdGhlIGNvbmZ1
c2lvbjsgY29tbWl0IDc4MmQ4ZTYxYjVkNiBvbmx5IGNoYW5nZWQgdGhlDQpmdW5jdGlvbiBuYW1l
IHRvIHBsdXJhbCwgd2hpY2ggYWRkcmVzc2VzIHRoZSBrZXJuZWwtZG9jIHdhcm5pbmc7DQp3aGVy
ZWFzIHlvdXIgb3JpZ2luYWwgcGF0Y2ggYWxzbyBjaGFuZ2VkIHRoZSBkZXNjcmlwdGlvbiB0byBw
bHVyYWwuDQoNCkkgd2lsbCBzZW5kIGEgcmV2aXNlZCwgY29ycmVjdGx5IHJlYmFzZWQgcGF0Y2gu
DQoNClRoYW5rcywNClBldGVyDQoNCj4gPiANCj4gPiA+ICAgKg0KPiA+ID4gICAqIFJldHVybjog
bWdyIHBsYXRmb3JtIGRldmljZSBpZiBzdWNjZXNzZnVsLCBhbmQgZXJyb3IgY29kZSBvdGhlcndp
c2UuDQo+ID4gPiAgICovDQo+ID4gPiBAQCAtMjczLDcgKzI3NCw3IEBAIHN0YXRpYyB2b2lkIGRm
bF9mbWVfZGVzdHJveV9icmlkZ2Uoc3RydWN0IGRmbF9mbWVfYnJpZGdlICpmbWVfYnIpDQo+ID4g
PiAgfQ0KPiA+ID4gIA0KPiA+ID4gIC8qKg0KPiA+ID4gLSAqIGRmbF9mbWVfZGVzdHJveV9icmlk
Z2VzIC0gZGVzdHJveSBhbGwgZnBnYSBicmlkZ2UgcGxhdGZvcm0gZGV2aWNlDQo+ID4gDQo+ID4g
VGhlIHByb3RvdHlwZSBpcyBmb3IgZGZsX2ZtZV9kZXN0cm95X2JyaWRnZXMoKSwgd2h5IHRoZSB3
YXJuaW5nPw0KPiA+IA0KPiA+ID4gKyAqIGRmbF9mbWVfZGVzdHJveV9icmlkZ2VzIC0gZGVzdHJv
eSBhbGwgZnBnYSBicmlkZ2UgcGxhdGZvcm0gZGV2aWNlcw0KPiA+IA0KPiA+IENvcnJlY3QgdGhl
IHBsdXJhbCBmb3JtIGluIGRlc2NyaXB0aW9uIHdvdWxkIGZpeCB0aGUgd2FybmluZz8NCj4gPiAN
Cj4gPiA+ICAgKiBAcGRhdGE6IGZtZSBwbGF0Zm9ybSBkZXZpY2UncyBwZGF0YQ0KPiA+ID4gICAq
Lw0KPiA+ID4gIHN0YXRpYyB2b2lkIGRmbF9mbWVfZGVzdHJveV9icmlkZ2VzKHN0cnVjdCBkZmxf
ZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSkNCj4gPiA+IC0tIA0KPiA+ID4gMi40NC4wDQo+
ID4gPiANCj4gPiA+IA0KPiA+IA0KPiANCg0K

