Return-Path: <linux-kernel+bounces-158470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B046D8B2098
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C05B257D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BAF12AAEC;
	Thu, 25 Apr 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dqackj2t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52B2AF03;
	Thu, 25 Apr 2024 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045492; cv=fail; b=FecrCbvsnbBe8P3Cvn1Ysh4rGIRlPhXEgaRxI/3OqgCH1XMvbfqMQVNlrFGYAPOXuCGOO6xEo8AgIEPv//p5rVJB6Whb5r3cyYG2HnuEHLAKs57KNdyI70pLOYwsNqGwJKVhpT1V4JpErUN1sqgy2PZFVs6CUlK7n+ts6BQXClw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045492; c=relaxed/simple;
	bh=J4gJoMO6WIoZRBltNygc5f/tf0/iwXCRT9WggIc6lcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tXVrjotJqAFPmxcappKB2EKkkZbtaquT/+J4C6t2lwiyD0nXJwbVipQIDc+6OE7f2Cypb3dnXTyg/A0ECdTFoHKTP88+FrnV5ZecZnQkegRcnwbZWxtDVZi7G+TKpV5snxXK+IHXJczOy7Zy4DuZQmG55hbroUnpgr3ivdR507E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dqackj2t; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714045490; x=1745581490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J4gJoMO6WIoZRBltNygc5f/tf0/iwXCRT9WggIc6lcY=;
  b=Dqackj2t6GDpDCO/+AcrJFaKpFR+RS+utNcBX8mJyW6crTa3KZBvZQPH
   d0MmojhXAWuQESfuzg76FXsH/2kug487/SMrTM+e0eFR+5dzbwKqE6nvC
   WcNLHhUcFKHVcVLeTIcao+ftmBcNUHw5+o54w9Rr5i84APnqUjbhOqx4L
   rvG/c2J8XVgCXoweycTqRFTMWnrczSFetmIk3FssYk0gKEYeZTo+Uttr5
   UGr2immxF6jWEkNVcINrEZzztklZckBbMsr5dGoD97hQhEIsO1CE+6kJa
   ubOkNzXliJlwA65E9u1DC1Wdian+BgzuFCA30yALpWyt/qFUfrnJRrqdR
   w==;
X-CSE-ConnectionGUID: 3ArNT/lQTaaxKIQ1xzECaw==
X-CSE-MsgGUID: OEddqOBZTOe0nXYLT13NEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9592309"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9592309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:44:49 -0700
X-CSE-ConnectionGUID: imQo0lRJTA2jSjrt3PU4gA==
X-CSE-MsgGUID: F6QMr3ixR7ihEEJq2//N2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="48307090"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 04:44:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 04:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 04:44:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 04:44:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 04:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEmMLW9tKBA4Iy0+coNrFEOAioxp4NqLY/hYcdi/fAtEJknbEPzDzYyKETHlX3uu/fDRAkScAubzfRiRx+VTXVAm4I5ETPS2jyfKAddz51S0w0QcPNlxNrdUxz7q11zrJ+u+Y35rbeSHPwE77DAsn/EJ1XzSp+RC/ICdLHpYWOVyif0IIB4d8JkvMIiWvx+31nhmfurrGJGftZvdQXUTYB7IHZ5zWPvxKFdPFyLkYjyqkcUYj0+wM9eRvY2EsDmgTetnt8CRgnkrqYZji1YbnuxPsvxhm70G3U45uYDJCox/8mIAV/yeVFnYZlsitRP8QN+4Mxd2CoT9d4FYvxCgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLkBa4dYE9pWM9MhJDo6lIwoW6RMpovCaxCgubaKv7U=;
 b=LWTtmx0d1F7frgLZy+HBO62anFhiWnCdmw7HvR1GmNRHZK6/1vJWGmKoQNh4wXau7U2IvepP1QJa0pMAe+ZBvdjUyvLn6WdtrWQl2U1MUlWmAvK6RArQdG+/We0zgEYKUM3uA0auJzLvVCOgGDWu7/VzqZHuulxKQ4qC2o3A3aQI4e89SVZnQRQoUckF+bMOQ5HPEAPaas+cUhNoY1bjdo3BzKudq+Oj5emYIj9dBPsj5p7E14E9+D9Aev8OdSb59w/qsM6iNBqMV8jRjCq/+ZMWfXOH2/YKLv3gmas8rAuDtbGhGKcemfncC5Mq4jHEST93PzHB3WsyZj46T+IFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 11:44:46 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::d738:fa64:675d:8dbb%7]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 11:44:46 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Eric Dumazet <edumazet@google.com>, "Brady, Alan" <alan.brady@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH RESEND iwl-net] ice: Interpret
 .set_channels() input differently
Thread-Topic: [Intel-wired-lan] [PATCH RESEND iwl-net] ice: Interpret
 .set_channels() input differently
Thread-Index: AQHakXfVPUlwAHZPXUGd0kLjMf5KprF46Ggg
Date: Thu, 25 Apr 2024 11:44:46 +0000
Message-ID: <CH3PR11MB8313C553C871B6CA07196ACBEA172@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240418095857.2827-1-larysa.zaremba@intel.com>
In-Reply-To: <20240418095857.2827-1-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SA2PR11MB5067:EE_
x-ms-office365-filtering-correlation-id: 6959b21d-cd92-45ce-b25c-08dc651d1b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?NmeygTqpEyrwD5v+gjKIMnlSzs0E0oEctUMl9Fia9MDLmQ2w17wreLARwJHU?=
 =?us-ascii?Q?sPbv9ryR3XhD5S5K116zg5f6p0jqO4N6lfoWMW9ITdsFMoHtnTbrfn7FXrKN?=
 =?us-ascii?Q?ggdaCV6g+PP8WH3V97KWsbKmEO5chLaPZQOvhDkxsyizIGew4LQOVAhdjLBT?=
 =?us-ascii?Q?W3GR/d7sFWImXN8y7e7O69+ai7jJjg1yJxv79Q0Fs1udBB+lf7+l+L1+06GR?=
 =?us-ascii?Q?k2XcsE3Uo+s3j1fh+Sq97GYrSO6i8iEGDry/Ou6XddsbMHc9dLCjX37DWQyA?=
 =?us-ascii?Q?UAcaqcBOwrXZOxr0NHyR+rBzqzyyo+dTGlBau/bCbFa08yWPbzaGBCK0/zkd?=
 =?us-ascii?Q?lE8ovk2PQ5qgKHw6sAIs6INwKjgGeFTjfYj8cT82G3YKNLNG8ZQsqH7oY/nC?=
 =?us-ascii?Q?xRE5eUNKuL6hYY/AEhvVRBwkMs3bVAinXKyyAxMsqRAm/4yWX54i4lkPg6a2?=
 =?us-ascii?Q?1mlCo3uDXvPewvK1DLtcXFPJ/zlNLcDauL18eC37cRV4nnViCAg68wYiLWvW?=
 =?us-ascii?Q?GIEnkgkrcIwfdEKJARwRtqvdA3P5pFYVqqNJrfx+g+azaSl8ncw7q/ARPUL+?=
 =?us-ascii?Q?kzgdgUmqcQJb8gc90sasTUI2oo1RStvME6crLeHzxngRBhnUTk5sxkNWJEdp?=
 =?us-ascii?Q?Oj2slnJ92bLBUthEzLigXtwf27NzRdrsNxPlFEwfAePmHSskLYGW0X15wJ8U?=
 =?us-ascii?Q?+4qQsnMvpZDF19PAIERZJmLdubQeS6e1nhLMMXcmyo9tR8KLmbiTKO4dcpqE?=
 =?us-ascii?Q?mptisBBWbikThGqjH6w5UBNRuqvwb4wcds3vIRFvhT7NQ+Bt+UWiHh8ZyWFQ?=
 =?us-ascii?Q?+s/oK+mgkZ/4T2vnS96NJn33dSOY6Aigk9oFiOh+oY/PE0peuj8t0b+ncY7B?=
 =?us-ascii?Q?xpJ+4DyhxSAVPo7m/JrgqOmuUP/iD70T5YgKCHtYlFMOEv9++2Q/nhLmwMqM?=
 =?us-ascii?Q?Dx6TuxsedT+2UErNQqCFEgMHlJChkY8UK0UTSE38AZZXqMaSfb0JFCEU/gxQ?=
 =?us-ascii?Q?PSRyx4YJLP+MIFDmPUFDldT6oJTg0ZKljEVg7lFHzS2kLUYtY9bypTydTelm?=
 =?us-ascii?Q?RfhmU63Aq2TW8HjsN3OHSD1M+8IUv2BVbi5R41wtczNBj0ITzJJIw72zIauu?=
 =?us-ascii?Q?St5AAcjb0hYsSrIxC456rBNIRGpnWAtx4OBIzYhBFuBiK7Hyb7qtp8vmJu/h?=
 =?us-ascii?Q?mpCuNyoSaYbp6hVdZSLBkPj0QPJpsOe7qsL+ihHlHQ1OnhEHLLOTlz6sVWYd?=
 =?us-ascii?Q?LY3h1aWzVBdGbPoXaTRIatbYToKZpYiAUHa/CsGuoQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6rvysJ8fj9eLoUYRM0ZcMCo+Lu0l5PQZ6rb8IMFeyGhiQaucXiivyF3CXPsn?=
 =?us-ascii?Q?M4EPAZqOY5oMl/VCNoDdIl1WhrAyarInUaWoZZ/e5ocfE3B+ygCcoItaPrvo?=
 =?us-ascii?Q?s3KuRsfH7R+jY3YT+1gospcfvjUsKlzEIEoVp2ebQsFayECuEovtRsZSdwc0?=
 =?us-ascii?Q?TtO4PwXXATSmjeGzvNGHWpKzqTNPrpF8/XvuY06vRDxDJ1oDL/v2BmEoTtgo?=
 =?us-ascii?Q?midDpAZ4gLh4mFW6yljWLKKnVlMAkf535ZOlYzXFyiFosWV87VqLYk+mV/KI?=
 =?us-ascii?Q?5Dlofvuraz5SuuiatmHO9q8c0MY+RfRJF6e1OEe5pqad4u3JGj1GIzk3KFOW?=
 =?us-ascii?Q?Zs3WhkNgZ/M0slYHGEbkMJQc9vi6aUUfTfAh5MFpivbZAEHVrZ4p6bKugCWn?=
 =?us-ascii?Q?2Y2fZV+MgCv+RsFUzO4sV7XoYVzq+TCkdxPrAWMMSWhkuuTcvkeNbAoiP9Ag?=
 =?us-ascii?Q?1h2doWMMAq0BTxGx5pyc44iwtna6wrSuVS4hmSZraeEPkhmRKLklHdQ7f4Wv?=
 =?us-ascii?Q?C2FgjAmlPUplTIor4zUgKGBxR6uKXshboeLDTj8GjyJ/5Z10X3tLeKTZ9t1V?=
 =?us-ascii?Q?UtJUIcwWee8MSl5Ivrfxvf529i2oGBg3kCosBnsEqa2hXwmNLNf/aq8LKgOn?=
 =?us-ascii?Q?4UPXPxi5CT2IC9nPZzhVmsyOx92odZxIUYVR5TkAg+F9YN0kzobF76skd1Mp?=
 =?us-ascii?Q?i6FGjI6ZorFUpeLJmg98Rov3owfZMfYSko417V/J9Vi29dnAcn7FersgTzmW?=
 =?us-ascii?Q?c0LRrP4UGhkw7iilbouAC7Lx9Pe+FbJk8dHlbm5WmeNjR4msz+9U+BEPYf/z?=
 =?us-ascii?Q?iggelZfcKP1DfsyFIVYwYGApNnDWueSAqtAkyUPK8mAEXRhDv4SXFgnKIrg7?=
 =?us-ascii?Q?R7WGeoBSw4tUpq7k5wKtikEh/n+ULEcvZ0EseyZdM31LLHDKhOXL7kSvU5HZ?=
 =?us-ascii?Q?OeIdYk5bRQkvhKYdngPcj9FReqTusM2oYZBkOj33WIyEc/CsGXXa7oVSZPQl?=
 =?us-ascii?Q?t1HQFsr4L6KqoxT3ao+OHXq9P30o5xmQJXIgYds8Q3dYTEN/EPVDgST6v8zS?=
 =?us-ascii?Q?ZzLGoxFdl88ZQTZl2XfsjCdcYVNLoeS0j3nB3xIeeG8AoGtVEa2sneIOz6ZB?=
 =?us-ascii?Q?lEHFkmw0mRLHmzh1Toygar+Lq4XZiqdwnV67T+AIz+NZWcNu8W/BxCyiAW9j?=
 =?us-ascii?Q?/6+O8E71ZIq5dBU+D9LhpFaVRXGVgwcCU8jjWkvz1KLeoK2w3mXQCIFsoKje?=
 =?us-ascii?Q?mjwDGyMII97IfVjmCT/B6aK05ApuDF9VIJJ+qTo/nZbIDo0IxXsYSqj5f/Vv?=
 =?us-ascii?Q?A6moljaqWb+6BS1038Si+xYw3I9yTJF2wkv3j1e9vGNXuq8CWZr6bXWxA3/+?=
 =?us-ascii?Q?ci6sT3PIcCZlOhYj2DPHVkqnkbiHW2aKW9QN99LI3eOTPoyOWan2qxoTUMGs?=
 =?us-ascii?Q?t2/KO2LIhWKM649S4OeWsI0xQE1EmbVaKHh6Rph2YRX2je036ovf8eSuTLts?=
 =?us-ascii?Q?TJeLUqAs1l6DoloVBVe6WBgetm5VueJxP0aCnfjEJvtoQWNTC5SZz4/tRZpy?=
 =?us-ascii?Q?B6siOxyo5f/CSgiQJ7onTAukpGj5D8S5rqPd7JEj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6959b21d-cd92-45ce-b25c-08dc651d1b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 11:44:46.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BidVaq+b4kVR6mHiNtGFKtf0ck4mclDPQbqxN/Nl64khQQwFMOKFrI8LeDVmyWE3wtu296vvwRymN/6sFF49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Thursday, April 18, 2024 3:29 PM
>To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
>lan@lists.osuosl.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
>Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Tantilov, Emil S
><emil.s.tantilov@intel.com>; Zaremba, Larysa <larysa.zaremba@intel.com>;
>Czapnik, Lukasz <lukasz.czapnik@intel.com>; Eric Dumazet
><edumazet@google.com>; Brady, Alan <alan.brady@intel.com>; Michal
>Swiatkowski <michal.swiatkowski@linux.intel.com>; Jakub Kicinski
><kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
><davem@davemloft.net>
>Subject: [Intel-wired-lan] [PATCH RESEND iwl-net] ice: Interpret .set_chan=
nels()
>input differently
>
>A bug occurs because a safety check guarding AF_XDP-related queues in
>ethnl_set_channels(), does not trigger. This happens, because kernel and i=
ce
>driver interpret the ethtool command differently.
>
>How the bug occurs:
>1. ethtool -l <IFNAME> -> combined: 40
>2. Attach AF_XDP to queue 30
>3. ethtool -L <IFNAME> rx 15 tx 15
>   combined number is not specified, so command becomes {rx_count =3D 15,
>   tx_count =3D 15, combined_count =3D 40}.
>4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>   new (combined_count + rx_count) to the old one, so from 55 to 40, check
>   does not trigger.
>5. ice interprets `rx 15 tx 15` as 15 combined channels and deletes the
>   queue that AF_XDP is attached to.
>
>Interpret the command in a way that is more consistent with ethtool manual
>[0] (--show-channels and --set-channels).
>
>Considering that in the ice driver only the difference between RX and TX q=
ueues
>forms dedicated channels, change the correct way to set number of channels
>to:
>
>ethtool -L <IFNAME> combined 10 /* For symmetric queues */ ethtool -L
><IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */
>
>[0] https://man7.org/linux/man-pages/man8/ethtool.8.html
>
>Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
>Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 ++++++--------------
> 1 file changed, 6 insertions(+), 16 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

