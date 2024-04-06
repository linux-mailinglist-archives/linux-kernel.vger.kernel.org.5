Return-Path: <linux-kernel+bounces-133979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7189ABAD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7F7B218C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380573A1D7;
	Sat,  6 Apr 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRYC2N0G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D136AF2;
	Sat,  6 Apr 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417798; cv=fail; b=J8xsHJz1EvgZeIyaAkwZliZGemk4ozgTBzjbU5Afq7dus/Kexy9qg1upLVFQN0qAd36sAD1zWISZa0yWoAvxJr6S23NAUyTNISqnkE5VZp3liTJ5tSU65S1Gj+ipdBHYAcIH4P++eyM2/BbfyNH2yVOjIDc7UrWtcOVQMxYx++c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417798; c=relaxed/simple;
	bh=wUjvhWVW+8qnPAGVPRjUFC8j++QsI2NNVA36iRONCeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nbPCvxUeHTwqrLKQHH+zquiSkpV40fqHh7LXDQMOSKokcAJt0lW9uPmaQ0Y82+7FTsRef4GJLue//c4DLFn777ssSdrN16NapdjYy+4Z7pikWn1tX9islXeHe8/+L9vA7wbH8IPjXpv1AIuI2XtBA0t3AM5Ed0vqquKMJmQwWWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRYC2N0G; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712417796; x=1743953796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUjvhWVW+8qnPAGVPRjUFC8j++QsI2NNVA36iRONCeo=;
  b=NRYC2N0GvY3F0KkR/6H0hbIf9XkN4s3XHdtkCCYXt6WIrakvvwaiKvT6
   dcQQyzgC8VFrjqCbHtTuL8nJ5zEQb5/yvRc2m7JUtC64wFYh9OK6gxDAx
   LgfU5McE7aqnkM+j3/0PLH0mDP8rffkIhK2UyTewIeSwXnAKjQ2S2vAQ8
   jO6/aYS4TaI++JqZXHSB25UEcJsoDXXiDcaCiv0qX18vv5GhsYj2LRngT
   Z1kspUCZ75ZsPG4dMmIkinWsorTFfJyG2QO/Lx0UHz72eAw3xfOZMe+af
   T+2mrvL+cssm9RVF7Tt4342YEuLAx6932H1BwNfxYInpjO2hKB1wEkehR
   Q==;
X-CSE-ConnectionGUID: KtMmTfJqRkappDzJrsDjgw==
X-CSE-MsgGUID: t2Uz0FbFT0K6oIun3o0uwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="30220683"
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="30220683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 08:36:35 -0700
X-CSE-ConnectionGUID: q3O+fauuR/OYBtfDzL5blw==
X-CSE-MsgGUID: 2rgAq7wITUqr2STRahsK3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,183,1708416000"; 
   d="scan'208";a="50417302"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2024 08:36:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 08:36:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 6 Apr 2024 08:36:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 6 Apr 2024 08:36:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 6 Apr 2024 08:35:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnx1pTcolYbF/JcztFDBFqlj/Xjpmn9yxaWNTWS9G+den8OQp3oYz0oNI6xBFN/VeoxhwYQL/O8GUUAGdHopIYaYAPVac3A3ph+Pk+j6byrQC4LSoMjK0r+wJd9qlKBlHXC2gZqtmLhdiKvjO1OeA1riwMYbl/DBotBFJwoaAamHE6k6O5ctGD0zXaB5uObgc8+PZX0VuFm+AGGSHbpx/IKan1KSdT3a85G/ljIg/E6wlYE3Xat27QIJhqoJSlvk4lwaMG989YrZQoC6PdTn3AT9W4VHCQSQdRUbNXpIVF1KhoaDjZEvElbpYGLLMIuxXM1YqkbbgrA92g9DN114sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUjvhWVW+8qnPAGVPRjUFC8j++QsI2NNVA36iRONCeo=;
 b=X4Ts8MFYfZQzMzrz6FSDak8bEG7N9RtIOQU2cKdCRiJ1jNTBQ+jgAhobDrlWkDyy3kOnlLkXUC1xaZT5QML6GfodNA7Zagzn+TjE6lhBZZxrEIwY6uJM0NKkCQvTXtzYzJ9SLvN4EcnaccG2lviqeq2SmU3fOQqOZ5t85WU7GIlAqYzA7GBPSy27g6octdRHIip9BQI8m2vcKRscv0wz6/Xyu8ULIXlMglo3MgeI2cMraBihlk9kz+A5YZvXqg1eZwgnQFgba51LbK1vbIWUKHQtBX9iIGzIDquR4wJrrJ78M7Dn03VSETOMyWkHQniA3arxjfl1SOWbJiHCFTVGGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by DS0PR11MB8164.namprd11.prod.outlook.com (2603:10b6:8:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.19; Sat, 6 Apr
 2024 15:35:38 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7452.019; Sat, 6 Apr 2024
 15:35:38 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Avri Altman <Avri.Altman@wdc.com>, Jens Wiklander
	<jens.wiklander@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
CC: Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: RE: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v4 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHah0/hJT2WrDdFbEWpLf8rN6MBt7FbC1OAgABVFEA=
Date: Sat, 6 Apr 2024 15:35:38 +0000
Message-ID: <PH7PR11MB7605390056DA5DBA168DEBC7E5022@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-2-jens.wiklander@linaro.org>
 <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65757A966792C93334DE4BF1FC022@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|DS0PR11MB8164:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eFi0S7p1PIL9BGnES8e1lBNfB1I4nrljfvrXszz4VzqdjimROQnUP9M5zBl9LpvGM67pQMEO36KdehLJ3lw1wqYUeadOnteRjl7AQN4tYbL56DPFx0l7JfwYpNfcLTHOShGpAg3+9Mwd7QAItwFndQ3mQ/snLodygoS/Fvr44cLaIdCExAHKmuVR1N0RlwPo0Wsnls/WTbTSmKTCjD7CCN7sL52N+aZ73JhJFJj/xU+dfGRxxAbPYrcl3KyNouaT81Iy3aEJUPCxO5yq/yvHKmjtPmi2puFhHPmk9n0OPiZkjf0rQZEy+CPSuxm4XaUXrC1/PGnLvRCxkdoO8lo8P/MtcHZi6Sep7YM/3lRFtwl0fwzNwJdlkj9KtdXOKLI5Is4SMCXjfG92B7HSI9St1UXpc1mvaHwjPvawMLOnYvxYbgCEo94rpqA250efNZ7fwV6I38zNpZXCHhJ0RRPCXvh48T63HqsUS0CSv/B2fUherJUxwQj3CnLUFXru5uN7yk05YWK6vB7IoakLu+S8hBIiEb9oK5K4xyiPN7DjIBRiS/d2Mm1NVM9TaQDKyU5qas/UmT2/Ekw1EJhPClxc/c9CHej+KHS4jWDBXmFLenc0gbcRzzULPZiZsMGWB1NE73qN7Mrrk17QxDmTsdQWNKMDZPkG3+QRPEDkopSZrI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhha1h1K3NFdm9oaWVsWHFZRHc0d0RmeXo4K3NUdERkcGlYcitYM1gzaE5q?=
 =?utf-8?B?UU90a0F0MXJGTXV3ZS81QWw4UDJJMy9XdHVkRzhYcHEwK2c1dUxrTit4cURX?=
 =?utf-8?B?V2lJK1NoWklFL1l4ZEZHVmQ5L3EvZ2ZzT1QrUjlyc2h2Y3ppZGc2enN2ejF4?=
 =?utf-8?B?VTJhN0RiY1p3K0dBSnU3bjE3Q0hhdGNjNWdFSkxqZWdKTWljMjV2RURHN0dW?=
 =?utf-8?B?dWVPbWd6TDdNakQxV0poYmZhTVYvU2t6Wk5xd2hta2NrVUN2N0dyUU5OWklh?=
 =?utf-8?B?dVVnQ2pVcnd0TWRiNE9VVXpwRGNKbGNvbncyT29MMWNjVWpzRFcyVWZOendZ?=
 =?utf-8?B?UFBZUW5OUk9MZHVLY2ZqbnJCajkydGJkQjNzSEFsR2xWUjZ3MVlabVdQSk9O?=
 =?utf-8?B?Q2kwcUFPa05wUkxlZFB3K0ovSi9OcEZpU0VYK2svWnBEVXNkQnlRSFBtQ2Yx?=
 =?utf-8?B?eTJnLzZYenFaV095aVp3b2FJdENKbjRGUDBUQlQzUkljbVU4em5WWEl6aWdl?=
 =?utf-8?B?ZjNJOHA4dmlOYk0wcHIyWkNOM3RqQWx5MCtkQnY3SEFqOFVYSDBRVlpMNW1S?=
 =?utf-8?B?MFduWkQxa2p2UDRUVk9KR3NDZHBnaHJwdU9yYllWbjVwcmFWZGNOZTlrSUtQ?=
 =?utf-8?B?TTlvSlp6Z3Rla0NCclhQY3NMaFVUSmJMUGk3MklFMFpNaXk0Yk1GY3ZQZUVr?=
 =?utf-8?B?RXhUYjBZQ09DdkcvUXAyTTdSd2pIL043SjYzcnpVblA5aW83dDlzUTRvcnRO?=
 =?utf-8?B?WGhJdUQyb2FaZDQ0QUhMbi9vVkhrOFNWMyt1WjFSZmZTYmdxM2RGMHBHa0Js?=
 =?utf-8?B?VnExUkJRTk1EQUVaMXFBb0dRQlB1ampDeGlhVWkvS281TysyUWIxdFlINlBn?=
 =?utf-8?B?RmVoK3E0S0IxMmYvdmNHWkRCRGhFMlVWWG5lVUMyYTZnSTB4ODRWTHFITk5w?=
 =?utf-8?B?VlpITGNDa2gvb0VDZ0dtd1BsMEo4UzdrUTBoY2lFSWs1Ny8zaSsxYk5VK0JY?=
 =?utf-8?B?a0VBdmV2akQ5bUxveVcyUThya3pvTk5LYldKTFk4WTlodEFDUm9weTFlNGh2?=
 =?utf-8?B?K1VaSU1tblFDL1c2T3pSa1EvWEV0VWlIZTRtS2IwOTJhQkJDd2dXTWl2azYr?=
 =?utf-8?B?QmtoUU1rcDlOemg4czhkWmcrcENmMVg3VkNEbUNpRGpBUjBnWGxrUmwyd0wz?=
 =?utf-8?B?d1YxM2FJK1p0TTZJNUpaK2g5Y1I1d096aU52bDUxV2ZlaHBiTDArRkFEbGNl?=
 =?utf-8?B?T1F4VURSREh4SGRXSnc2dmpmWjh3K20wM1Y4a3I2eHhmMjVMZmY4UUV3SEN4?=
 =?utf-8?B?R1NYZXpzWjZiZklUNGh1TVk1YjRtSDRTZ1NpMW9ZYnlCbWRXVjhaTWdNSEty?=
 =?utf-8?B?MUplcVpVNSs0OXhETUY5cmU0a2NHRUxBc3VjcDhIR2hCYVkwVXVZZGxOQktu?=
 =?utf-8?B?RVZrbFJicXRzY2crMTlsa2xVZWF5MDJabXlCbnNPNTd3MkRneW1oZFY1VjZs?=
 =?utf-8?B?aGpnK2VvTDZWUVQ0SjRSd3VUalFiY3RNMForNGdUME5WdmMrbnY1RTZhZzZM?=
 =?utf-8?B?Z2d4MU1WYk1yanp4NmlJVUtSSnZ1ekIxa2xWNDg4QmRjUE96OGgxaDIvS0VL?=
 =?utf-8?B?RHU5eXdTWVJMcE1raWVEWnZYMUhUMTJhdGpaRHd1QUNuSUZJMHR1YWV5djlI?=
 =?utf-8?B?cnNDUmNhVitkUlhMY2VrOFF3WURPL2JwODNhYmFIZ0xWTGw3VFZoU1AwaHNz?=
 =?utf-8?B?cTNvcFdyQlh0SGc0MnIxY2lCUjduUU9xZTJpZ0ZLN0ZmT3cxTWFOeEw3aWtY?=
 =?utf-8?B?S0s3c1RBRXBjSGxXL0hwRXFkZ1YwcGtnMFNGUWpTZGQ0KzV5bXNQKytWQU8y?=
 =?utf-8?B?TDNCTVhoZ1I3WXUwNEkzSXpIcFQzYXhTSmRhYzZHMmZ4SG5mSlBxMUdCN0F6?=
 =?utf-8?B?VUFsRTl4aEdZYUIzRnBQVUt6SjFwWGxoZ0xSdmRWMFN5TzROVWtQQ21BYWlj?=
 =?utf-8?B?aFExRUxaOWNSbjVnbTJXNVkyU1M5OEIrTTJwb0p2V3lMaVdhRjh1OUNPZ0li?=
 =?utf-8?B?RlNQN3NtU3VaS1R1bHdtbElvS2NTNG5vTFJTeUtEVHIxb0dhSG83YmtlYkN3?=
 =?utf-8?Q?+8ZmT4sP9sxOkkx0surrHpzh6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f0b84b-3e30-4c3d-e850-08dc564f35ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 15:35:38.6816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZ5v5ztZawz4PDkex9bb+bPs0OZahfzEft2gVc0H1IzTCHmhlu+aOxNTYWPbQjkiUClGPUHVFlALpfNz86QuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8164
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXZyaSBBbHRtYW4gPEF2
cmkuQWx0bWFuQHdkYy5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA2LCAyMDI0IDE6Mjcg
UE0NCj4gVG86IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPjsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7
IG9wLQ0KPiB0ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZw0KPiBDYzogU2h5YW0gU2Fpbmkg
PHNoeWFtc2FpbmlAbGludXgubWljcm9zb2Z0LmNvbT47IFVsZiBIYW5zc29uDQo+IDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPjsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3Jn
PjsgSmVyb21lDQo+IEZvcmlzc2llciA8amVyb21lLmZvcmlzc2llckBsaW5hcm8ub3JnPjsgU3Vt
aXQgR2FyZw0KPiA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPjsgSWxpYXMgQXBhbG9kaW1hcyA8aWxp
YXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPjsNCj4gQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hl
QGFjbS5vcmc+OyBSYW5keSBEdW5sYXANCj4gPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47IEFyZCBC
aWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+OyBBcm5kDQo+IEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47
IFdpbmtsZXIsIFRvbWFzDQo+IDx0b21hcy53aW5rbGVyQGludGVsLmNvbT47IEFsZXggQmVubsOp
ZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2NCAxLzNd
IHJwbWI6IGFkZCBSZXBsYXkgUHJvdGVjdGVkIE1lbW9yeSBCbG9jaw0KPiAoUlBNQikgc3Vic3lz
dGVtDQo+IA0KPiA+IEEgbnVtYmVyIG9mIHN0b3JhZ2UgdGVjaG5vbG9naWVzIHN1cHBvcnQgYSBz
cGVjaWFsaXNlZCBoYXJkd2FyZQ0KPiA+IHBhcnRpdGlvbiBkZXNpZ25lZCB0byBiZSByZXNpc3Rh
bnQgdG8gcmVwbGF5IGF0dGFja3MuIFRoZSB1bmRlcmx5aW5nDQo+ID4gSFcgcHJvdG9jb2xzIGRp
ZmZlciBidXQgdGhlIG9wZXJhdGlvbnMgYXJlIGNvbW1vbi4gVGhlIFJQTUIgcGFydGl0aW9uDQo+
ID4gY2Fubm90IGJlIGFjY2Vzc2VkIHZpYSBzdGFuZGFyZCBibG9jayBsYXllciwgYnV0IGJ5IGEg
c2V0IG9mIHNwZWNpZmljDQo+ID4gUlBNQiBjb21tYW5kczogV1JJVEUsIFJFQUQsIEdFVF9XUklU
RV9DT1VOVEVSLCBhbmQNCj4gUFJPR1JBTV9LRVkuDQo+IFdoYXQgYWJvdXQgdGhlIG90aGVyIHJw
bWIgb3BlcmF0aW9ucz8NCj4gVGhlcmUgYXJlIDcgb3BlcmF0aW9ucyBpbiBlTU1DLg0KDQpUaGVy
ZSB3ZXJlIG9ubHkgNCBhdCB0aGUgdGltZSwgbm93IHRvdCBzdXJlIHRoZXkgYXJlIHJlbGF0ZWQg
dG8gVEVFIG5lZWRzLiANCj4gDQo+IC4uLi4uLi4uLi4uLg0KPiANCj4gPiArLyoqDQo+ID4gKyAq
IHJwbWJfZGV2X2ZpbmRfZGV2aWNlKCkgLSByZXR1cm4gZmlyc3QgbWF0Y2hpbmcgcnBtYiBkZXZp
Y2UNCj4gPiArICogQGRhdGE6IGRhdGEgZm9yIHRoZSBtYXRjaCBmdW5jdGlvbg0KPiA+ICsgKiBA
bWF0Y2g6IHRoZSBtYXRjaGluZyBmdW5jdGlvbg0KPiA+ICsgKg0KPiA+ICsgKiBJdGVyYXRlIG92
ZXIgcmVnaXN0ZXJlZCBSUE1CIGRldmljZXMsIGFuZCBjYWxsIEBtYXRjaCgpIGZvciBlYWNoDQo+
ID4gK3Bhc3NpbmcNCj4gPiArICogaXQgdGhlIFJQTUIgZGV2aWNlIGFuZCBAZGF0YS4NCj4gPiAr
ICoNCj4gPiArICogVGhlIHJldHVybiB2YWx1ZSBvZiBAbWF0Y2goKSBpcyBjaGVja2VkIGZvciBl
YWNoIGNhbGwuIElmIGl0DQo+ID4gK3JldHVybnMNCj4gPiArICogYW55dGhpbmcgb3RoZXIgMCwg
YnJlYWsgYW5kIHJldHVybiB0aGUgZm91bmQgUlBNQiBkZXZpY2UuDQo+ID4gKyAqDQo+ID4gKyAq
IEl0J3MgdGhlIGNhbGxlcnMgcmVzcG9uc2liaWxpdHkgdG8gY2FsbCBycG1iX2Rldl9wdXQoKSBv
biB0aGUNCj4gPiArcmV0dXJuZWQNCj4gPiArICogZGV2aWNlLCB3aGVuIGl0J3MgZG9uZSB3aXRo
IGl0Lg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5zOiBhIG1hdGNoaW5nIHJwbWIgZGV2aWNlIG9y
IE5VTEwgb24gZmFpbHVyZSAgKi8gc3RydWN0DQo+ID4gK3JwbWJfZGV2ICpycG1iX2Rldl9maW5k
X2RldmljZShjb25zdCB2b2lkICpkYXRhLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJwbWJfZGV2ICpzdGFydCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAoKm1hdGNoKShzdHJ1Y3QgcnBtYl9kZXYg
KnJkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgdm9pZCAqZGF0YSkpDQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBycG1i
X2RldiAqcmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKnBvczsNCj4gPiArDQo+
ID4gKyAgICAgICBtdXRleF9sb2NrKCZycG1iX211dGV4KTsNCj4gPiArICAgICAgIGlmIChzdGFy
dCkNCj4gPiArICAgICAgICAgICAgICAgcG9zID0gc3RhcnQtPmxpc3Rfbm9kZS5uZXh0Ow0KPiA+
ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBwb3MgPSBycG1iX2Rldl9saXN0Lm5l
eHQ7DQo+ID4gKw0KPiA+ICsgICAgICAgd2hpbGUgKHBvcyAhPSAmcnBtYl9kZXZfbGlzdCkgew0K
PiBXaHkgbm90IGp1c3QgbGlzdF9mb3JfZWFjaF9lbnRyeSANClllYWggdGhhdCBtYXkgd29yaw0K
PiANCj4gPiArICAgICAgICAgICAgICAgcmRldiA9IGNvbnRhaW5lcl9vZihwb3MsIHN0cnVjdCBy
cG1iX2RldiwgbGlzdF9ub2RlKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKG1hdGNoKHJkZXYs
IGRhdGEpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcnBtYl9kZXZfZ2V0KHJkZXYp
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgICAg
ICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgIHBvcyA9IHBvcy0+bmV4dDsNCj4gPiArICAgICAg
IH0NCj4gPiArICAgICAgIHJkZXYgPSBOVUxMOw0KPiA+ICsNCj4gPiArb3V0Og0KPiA+ICsgICAg
ICAgbXV0ZXhfdW5sb2NrKCZycG1iX211dGV4KTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4g
cmRldjsNCj4gPiArfQ0KPiANCj4gLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQo+IA0KPiA+ICsvKioN
Cj4gPiArICogcnBtYl9kZXZfcmVnaXN0ZXIgLSByZWdpc3RlciBSUE1CIHBhcnRpdGlvbiB3aXRo
IHRoZSBSUE1CDQo+ID4gK3N1YnN5c3RlbQ0KPiA+ICsgKiBAZGV2OiBzdG9yYWdlIGRldmljZSBv
ZiB0aGUgcnBtYiBkZXZpY2UNCj4gPiArICogQG9wczogZGV2aWNlIHNwZWNpZmljIG9wZXJhdGlv
bnMNCj4gPiArICoNCj4gPiArICogV2hpbGUgcmVnaXN0ZXJpbmcgdGhlIFJQTUIgcGFydGl0aW9u
IGV4dHJhY3QgbmVlZGVkIGRldmljZQ0KPiA+ICtpbmZvcm1hdGlvbg0KPiA+ICsgKiB3aGlsZSBu
ZWVkZWQgcmVzb3VyY2VzIGFyZSBhdmFpbGFibGUuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybnM6
IGEgcG9pbnRlciB0byBhICdzdHJ1Y3QgcnBtYl9kZXYnIG9yIGFuIEVSUl9QVFIgb24gZmFpbHVy
ZQ0KPiA+ICsqLyBzdHJ1Y3QgcnBtYl9kZXYgKnJwbWJfZGV2X3JlZ2lzdGVyKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBy
cG1iX2Rlc2NyICpkZXNjcikgew0KPiA+ICsgICAgICAgc3RydWN0IHJwbWJfZGV2ICpyZGV2Ow0K
PiA+ICsNCj4gPiArICAgICAgIGlmICghZGV2IHx8ICFkZXNjciB8fCAhZGVzY3ItPnJvdXRlX2Zy
YW1lcyB8fCAhZGVzY3ItPmRldl9pZCB8fA0KPiA+ICsgICAgICAgICAgICFkZXNjci0+ZGV2X2lk
X2xlbikNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmRldiA9IGt6YWxsb2Moc2l6ZW9mKCpyZGV2KSwgR0ZQX0tFUk5FTCk7
DQo+ID4gKyAgICAgICBpZiAoIXJkZXYpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOw0KPiA+ICsgICAgICAgcmRldi0+ZGVzY3IgPSAqZGVzY3I7DQo+ID4gKyAg
ICAgICByZGV2LT5kZXNjci5kZXZfaWQgPSBrbWVtZHVwKGRlc2NyLT5kZXZfaWQsIGRlc2NyLT5k
ZXZfaWRfbGVuLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBf
S0VSTkVMKTsNCj4gSW4gYWRkaXRpb24gdG8gdGhlIGRldl9pZCwgd291bGRuJ3QgaXQgbWFrZSBz
ZW5zZSB0byBoYXZlIHlvdXIgb3duIElEQSBhcw0KPiB3ZWxsPw0KPiANCj4gPiArICAgICAgIGlm
ICghcmRldi0+ZGVzY3IuZGV2X2lkKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGtmcmVlKHJkZXYp
Ow0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiArICAg
ICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZGV2LT5wYXJlbnRfZGV2ID0gZGV2Ow0KPiA+ICsN
Cj4gPiArICAgICAgIGRldl9kYmcocmRldi0+cGFyZW50X2RldiwgInJlZ2lzdGVyZWQgZGV2aWNl
XG4iKTsNCj4gPiArDQo+ID4gKyAgICAgICBtdXRleF9sb2NrKCZycG1iX211dGV4KTsNCj4gPiAr
ICAgICAgIGxpc3RfYWRkX3RhaWwoJnJkZXYtPmxpc3Rfbm9kZSwgJnJwbWJfZGV2X2xpc3QpOw0K
PiA+ICsgICAgICAgYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbigmcnBtYl9pbnRlcmZhY2Us
DQo+ID4gUlBNQl9OT1RJRllfQUREX0RFVklDRSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmRldik7DQo+ID4gKyAgICAgICBtdXRleF91bmxvY2soJnJwbWJfbXV0
ZXgpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZGV2Ow0KPiA+ICt9DQo+ID4gK0VYUE9S
VF9TWU1CT0xfR1BMKHJwbWJfZGV2X3JlZ2lzdGVyKTsNCj4gDQo+IC4uLi4uLi4uLi4uLg0KPiAN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMjUxZDZi
N2U2ZDE1DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcnBtYi5o
DQo+ID4gQEAgLTAsMCArMSwxMzYgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEJTRC0zLUNsYXVzZSBPUiBHUEwtMi4wICovDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAxNS0yMDE5IEludGVsIENvcnAuIEFsbCByaWdodHMgcmVzZXJ2ZWQNCj4gPiArICogQ29w
eXJpZ2h0IChDKSAyMDIxLTIwMjIgTGluYXJvIEx0ZCAgKi8gI2lmbmRlZiBfX1JQTUJfSF9fICNk
ZWZpbmUNCj4gPiArX19SUE1CX0hfXw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVz
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L25vdGlmaWVyLmg+DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogZW51bSBycG1iX3R5cGUgLSB0
eXBlIG9mIHVuZGVybHlpbmcgc3RvcmFnZSB0ZWNobm9sb2d5DQo+ID4gKyAqDQo+ID4gKyAqIEBS
UE1CX1RZUEVfRU1NQyAgOiBlbW1jIChKRVNEODQtQjUwLjEpDQo+ID4gKyAqIEBSUE1CX1RZUEVf
VUZTICAgOiBVRlMgKEpFU0QyMjApDQo+ID4gKyAqIEBSUE1CX1RZUEVfTlZNRSAgOiBOVk0gRXhw
cmVzcw0KPiA+ICsgKi8NCj4gPiArZW51bSBycG1iX3R5cGUgew0KPiA+ICsgICAgICAgUlBNQl9U
WVBFX0VNTUMsDQo+ID4gKyAgICAgICBSUE1CX1RZUEVfVUZTLA0KPiA+ICsgICAgICAgUlBNQl9U
WVBFX05WTUUsDQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogc3RydWN0IHJwbWJf
ZGVzY3IgLSBSUE1CIGRlc2NyaXB0b3IgcHJvdmlkZWQgYnkgdGhlIHVuZGVybHlpbmcNCj4gPiAr
YmxvY2sNCj4gPiBkZXZpY2UNCj4gVGhlIHVzZSBvZiB0aGUgdGVybSAicnBtYiBkZXNjcmlwdG9y
IiBtYXkgYmUgc2xpZ2h0bHkgbWlzbGVhZGluZy4NCj4gVGhpcyBpcyBiZWNhdXNlIGluIFVGUyB0
aGVyZSBhcmUgdmFyaW91cyBkZXNjcmlwdG9ycyB0aGF0IGlkZW50aWZpZXMgdmFyaW91cw0KPiBj
aGFyYWN0ZXJpc3RpY3MsIGUuZy4gZGV2aWNlIGRlc2NyaXB0b3IsIGdlb21ldHJ5IGRlc2NyaXB0
b3IsIHVuaXQgZGVzY3JpcHRvcg0KPiBldGMuLCBhbmQgcmVjZW50bHkgVUZTNC4wIGludHJvZHVj
ZWQgYSBuZXcgZGVzY3JpcHRvciAtIFJQTUIgZGVzY3JpcHRvci4uLi4NCg0KTWlnaHQgYmUgb3Zl
cmxvYWRlZCwgc3VnZ2VzdGlvbnM/IA0KDQoNCg==

