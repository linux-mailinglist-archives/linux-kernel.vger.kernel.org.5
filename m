Return-Path: <linux-kernel+bounces-154942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB61A8AE356
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFCE1F22472
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE677F1B;
	Tue, 23 Apr 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1aVO1+L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EE69944;
	Tue, 23 Apr 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870270; cv=fail; b=cqB5teHkrl3mQ/GV2diWGWEoq5rPwP3J8RhCHjV+CNKQeRracuftWLVk/F1RLbCmYbonKjqQRkp4mQoM5p/jV/Fgo0SgGlJjTUgM/Bce0e43CSRmVD8k9tnuQUIAA2FN/oyWZLxsvU1zfygntQYFJZCbL5cW1EnCMIMW2/JGYb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870270; c=relaxed/simple;
	bh=4ITnjLOnYzOcZ1r8dhLNDHSLuBzqekvsArwLX5T9kas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ob94pvSNU32i1w1Y9ykYKpaFU30/4A+ZGssA+ZrawMlt/M+yULY+SuAczGE2Xs1SJUY2/xiv/RoqZIHzZSDX4Fq17Ji//NKK0Hal8wPhMM6mktJZoMrNr/L1fdDcYZjGn/QkIgM3Rs4Mcbpm9L9v72iJ9MSaYV6c/GzJVNxRa5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1aVO1+L; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713870267; x=1745406267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ITnjLOnYzOcZ1r8dhLNDHSLuBzqekvsArwLX5T9kas=;
  b=G1aVO1+L+i/2w4PJFJeob8C0D8vmnCgbxbfa29Dns3GZppIBFovJvWid
   bo7KkVeML/u69YEEy4Cu9ewpetD/ogu6Ix/esICXMDHQ16I32VGRLQ3TG
   byTUlQtt/fHQtn1DXrMVCvVBNbaGc2Y00ztGkTwENRB1sBljVkf2awcf4
   AYKHzNvh+iy6tlC1ec5mvWlJQAibl72c5KgEhOJWvFF95h61UpP7ytTgj
   0zxlVMf8WnE6JSmoY8ZqaYaLOm38fUgVO4RPaAHHg8ZAGOm3OG3LvaHQ2
   2VRTASoORym4vN6pHFWMnOAeKH5uoGGPavDkMSI75qrjMnFo5ax34EjaQ
   A==;
X-CSE-ConnectionGUID: GuEBeIqNSx+8JTau4JYThA==
X-CSE-MsgGUID: 0WSm7JiMQc2MCOTWF+iuZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9617627"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9617627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 04:04:27 -0700
X-CSE-ConnectionGUID: UwWsaRD3R9+Zsx2Y+6KYnw==
X-CSE-MsgGUID: gQfpgJz3Q1u9EQQk6ALwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29003466"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 04:04:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:04:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:04:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 04:04:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 04:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yr9jsS1WCdyCJNGhFA//5e0ild98jRbhlYQDBBjSmNOmkKLOIZOZPnPqyDph9N5tUuEP3rQ1y2tOiEhdtYSfrmzsaGlU6qfxe55vW3i+/yVxTkiPu/O4PGE53H0m5Tw2GMbbrKMQXFkR6HHYdZo2pSI3MdovqlNfiwXjx0EBxzfLgzEC5003Kqhf6dI+fszeSIjm3km2emy3N6ow4ubl2S7vIOsGUAYFrx2X4ZZBhBwM335JXkFIfidn8CvcVhxZWML4OYf8m1UMYIsbfPTb7cS8R/+mwrQZrVzfwHOvyrUPv0ebxq1YIPpJOC+IX3BZ3O6T+b95BXS8dM5rg504YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQyqUD70jiP3vIFeE3UjmhQ7MvxlcdigmO8RNB3CML0=;
 b=URxxdraQl2iasAyOL8oHSA/eqfUDP9UrExAs4Q/+L+70ax454xUYmi+UKSazbv09kSv9216dvGB/Gg2kFauGE1tdU1LwkPo+1QTE9J1141TjS+8DXMNg513yYVFEO1rlIXph+89BECBTawn+ZkTsDi4Uh8dOYN1GDOIOo2JjmKgtiHRKaiOiqAHKeKkKOJLhRvkP2o+T+EGPHnb1dBPy/Jyv8Tbv01VTbxO737clIE6uh2eVpyeaMithMTf+TleuxPnB6tpqtVMQblELL/wlwm/txJ7QAs2wXSyN7zZIAhoqEZG2xMnfr3aEmUzdT+3iyAItXWy6j+trSB+/rfPNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Tue, 23 Apr 2024 11:04:22 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::7d7c:9a51:767e:730a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::7d7c:9a51:767e:730a%3]) with mapi id 15.20.7519.020; Tue, 23 Apr 2024
 11:04:22 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Thread-Topic: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Thread-Index: AQHakpL1PxeMlLmpYEyEiHJJwvzNZLF0TZAAgAFoi2A=
Date: Tue, 23 Apr 2024 11:04:22 +0000
Message-ID: <DM6PR11MB465781953B5600F67C96AA809B112@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>
 <ZiZmpg7GF99Ihxk0@nanopsycho>
In-Reply-To: <ZiZmpg7GF99Ihxk0@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CY8PR11MB7084:EE_
x-ms-office365-filtering-correlation-id: 1b2da3bc-9d12-49dc-aa1a-08dc6385219e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?bVmH10exIu2GSx1URlIQAC55Ym/Y2g4SsJK8733KvSYviHBIzJ59GyKZnyjJ?=
 =?us-ascii?Q?/Obsn6/pbf+Vj8Vj6KWTqb1Pj9OtQ0CuIKSaHyg+KWeMglxHyR5W9DD2Y5Vj?=
 =?us-ascii?Q?Vtipui9tFuz/N8RnAFSxguAfOXtSEo5dkkv5Pg8jtqeaDBrlcANFwqav9FsR?=
 =?us-ascii?Q?pV2w/9sHkSpscM8RpbQ5PB8lFUzAXO9Us61iAedSJevFjHPbwy44W+QRBNXn?=
 =?us-ascii?Q?7KwqCIpGqg0RN8RuN1L9gJH6DXQoo0x/3Y+O6Yhm3tlzQkIRfEOXFgMqQ0La?=
 =?us-ascii?Q?BH8u6zy5rk9fRgkGNqGbYzeIE0qoLZnjnEkCe5+VgDSn5eZ+8fze0+z/Ekch?=
 =?us-ascii?Q?aUdN1krr6WelLCfO63XuXvVb+RGMzj8ay1PIsUL7p1j6d8VuvHC+90Iy3xAm?=
 =?us-ascii?Q?oRydvMmjg0BFPj9c+Stwd4w+XWX4dUPKv+lL4U7sxq//OimSigN+thZuJPyv?=
 =?us-ascii?Q?RclwOIBn0x/ETBw8Okk/JgDHD6YnmRG2beuf6189a3CryZQcnYntx+83osB9?=
 =?us-ascii?Q?hh+mhYsCL961Z28Y5Hp4Dkc1qUIJS54mAYI/Px9zDYO9jt8QrxTPPU3e+ovG?=
 =?us-ascii?Q?j5jJ7hOm80n6hODn9dxMZa+xakYpQtvSjeJ1qxB96vgD6IH3WijbplMlNyNe?=
 =?us-ascii?Q?x+CgjrevFRLFtZTHvipFxpguU7tDkFKcLHYPT6ZyTyb9WSCKRwZSorpZDMDn?=
 =?us-ascii?Q?2fXgOnOhQ4X5uN/bFr5AgadTuD44oEvcMGYtxlSYEQxZ8OYS61e7mnrkUAue?=
 =?us-ascii?Q?3z727RfHC4vauFFyu/buM6LwWYrCptdDVlfGPxPG0PZgm1q0H381Yz7N/MM2?=
 =?us-ascii?Q?3TfQsDaHx3lXSE0rCQKQ4GFBq96IkdUPuu0V5x7LxrQcesJzv2JD81cFfrUs?=
 =?us-ascii?Q?pOE84UblcyfHkVAmYZzWcrJQtEVpCM79zw5YP6AB+n68W/JFMzPTf+0Hgh1x?=
 =?us-ascii?Q?WO3qIZxjDch8y2zOpIJ274McsbFAXpT1WNWTbyG2Y1J9/62MjqNqS4FglIWn?=
 =?us-ascii?Q?7rEqGJ5EZb62ZSU25OAA4Gra0IFFZqgV39hqWFJS2/BdSPNKo6+/MEVIuXkl?=
 =?us-ascii?Q?nMHuPdoeG+fuhGWUvZhIZb1jHjNexEap/063LAMTqayyOmxKTq188NiPkI8i?=
 =?us-ascii?Q?2JBWH1FUrbsvc0NTxT6+NbnrBVJx05dH+A9AaKe8kfNucM5aPSPQWUMclxK1?=
 =?us-ascii?Q?0NfHlaQd9mxKr2yJSk6aCvPSPppM7DN/clVMh+7wBdDasNrZmy+Q0YlkZY2R?=
 =?us-ascii?Q?Jw+xcqi3KxSWx1voJ2Gb7IafGJ75O5/ujd0N0jnyDMX7/2pEsamhCywZxQAJ?=
 =?us-ascii?Q?GAh552FLn3ehM80QqV1pm7NbfUcp6ORHSedRXxkOFvvfuA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?thlJUYVlrZbCAhIKCwTet1k3aUVf3XQvLKi2VF657r5v5M3mWwkhneooMQn2?=
 =?us-ascii?Q?j6GwT/btaUcEzJn/QMBrtcMxY31T6sdC+bHIhk7rEj+sjI16SPHKtbeblKBl?=
 =?us-ascii?Q?+7Y2L1v9/E4T8GhLziiXqMeLtjHUePg6FTvpT8tbkqby13eOvyY+kZxvWiao?=
 =?us-ascii?Q?45Okp2MwI2DcOWL7Mznbdo28qO7gz6d6AOEvfbD08F6hl0OUy3zdHv9mr+9J?=
 =?us-ascii?Q?kJuqymjlOc7E5hvcYDmluGYUi7IGfEiCs3AP754z0EPrn8gChy6Gw1ZfgSVR?=
 =?us-ascii?Q?/lT67jh+xe5Xa2ef/PKfn8EpBkV20gvdH9kPogjQ6QU5wgYwM08d0j6UR4gf?=
 =?us-ascii?Q?sn6FkXSTGacEfvl9kS7ndl3YU5gFMi6ZE6S9qiWdYp3UxPDgMAsZ1mN91AbP?=
 =?us-ascii?Q?yNllO9mpYByYHeCT8IqMMfDhy5RI8O3KDDv8FY/OMlX3x8eegnW7rl1X5dzX?=
 =?us-ascii?Q?/wd2y+FMSdc1cu9rTl9tukUT2CHh5mQdU6CXXgA9+X9hdZ3BqZHyhmcDIyXa?=
 =?us-ascii?Q?iWOAslRMYD/gO+weBBcK6IVp2IU0t1inpcy6qYP/UB/kWDOqnDFh1oKyTZP3?=
 =?us-ascii?Q?VnOgCwQNZN3ZG6pGRWhm7OwZA9iNXOZ+SWEKqNN0OjvHKBRHDQ6V3AD1RN1w?=
 =?us-ascii?Q?pUFeQZqZuRZm4V7u7EQKldx0Tt1sv7D5STDR2mIKVae4wQhY6GREcmD0PxxM?=
 =?us-ascii?Q?C0pltwhgP9qjicHD0PK55NwkK+TOsDmMSYNUCa/7cM8YKy4F0uXQOmqufuy9?=
 =?us-ascii?Q?A1kfQm6lcmelb7Ckk77UgBpTU062SbtPj7Dz54AJbZ6J2YJ7KCrS0hrgOb+t?=
 =?us-ascii?Q?iJ2sk6nzszdJGYMZAiITbYAkRfPsPOf7KD9csFZO9u3kJ4WBlZmwJ8T+kmy1?=
 =?us-ascii?Q?vc6jcA3MgIoAPMB7rUUZryUQ/zzOOK9GbHbzuMF2TnQVjOjEQiMnc77RzouN?=
 =?us-ascii?Q?icy48h5fr4QPhi/uJgZjmgMh3TYhyEvkmJMFWJgCT79Gg33b1uZOciK6YyIR?=
 =?us-ascii?Q?vKl0vYcPAAWtUGU6XGReAjVLo4on9tKaKltTDIle4gqibMkvdY3OWvt3G3VT?=
 =?us-ascii?Q?ntNy+L1Ka30+qjwAxQR8UTloybviVKZFZKwo1qG+uj+OfW2yXwvLxZkrcc++?=
 =?us-ascii?Q?t1Y8FFNiOXd5GrGCZoUX02ln5kciPUyZ2PYexBKudYWqpV8b1pa5pgio/aHf?=
 =?us-ascii?Q?0lURG2Q0mY1rk7N+BXp8vsprKPvvsq0cg+4oHcqOUYHJ6uq7+ETowEgOT1yO?=
 =?us-ascii?Q?W+yrQJOrlT7GJpBAkVRGm7xAAeDDg/Zj/t3qefqZW9w8pClLQTQ6Zlg6dFMA?=
 =?us-ascii?Q?HH8s5A4jeIDciMS5emDdO1iUIKR/jawVAU6przNgSbkKEt1AP05t0l8YZl6M?=
 =?us-ascii?Q?gO6P+nf4locM2jnRFzz8U4EZeumFsuOmKKdEZHofu2ylUCPFYPlJ1HN+4Apa?=
 =?us-ascii?Q?6AXeN772C3/3sqVgze/e6w5Ht1TsukrzwdRXoeNuFEu+6cwJtaHTotj5yNEC?=
 =?us-ascii?Q?iy6dOTilO1MHfP2VIM9Uh7WMSeeK4i8q+pB2wqHKc1cEYYxm3z0dOxNfybDS?=
 =?us-ascii?Q?FRFKA2CPieP0h7FAhj6MZAVKg/xvhH6JrFHgGmcrPQhJ2tVAZZG1PiX1MmsF?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2da3bc-9d12-49dc-aa1a-08dc6385219e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 11:04:22.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTJSP7GTRMED4syRrPgJ5Zw5akncXMd9eR8it57lXyT4MtWhPxt/rANDzmJChtd6Eazff9enqGt4LiS7Wg2QMKB+pb9zGA2BQVGH2WyURiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, April 22, 2024 3:31 PM
>
>Fri, Apr 19, 2024 at 09:47:11PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>In scenario where pin is registered with multiple parent pins via
>>dpll_pin_on_pin_register(..), belonging to the same dpll device,
>>and each time with the same set of ops/priv data, a reference
>>between a pin and dpll is created once and then refcounted, at the same
>>time the dpll_pin_registration is only checked for existence and created
>>if does not exist. This is wrong, as for the same ops/priv data a
>>registration shall be also refcounted, a child pin is also registered
>>with dpll device, until each child is unregistered the registration data
>>shall exist.
>
>I read this 3 time, don't undestand clearly the matter of the problem.
>Could you perhaps make it somehow visual?
>

Many thanks for all your insights on this!

Register child pin twice (via dpll_pin_on_pin_register(..)) with two differ=
ent
parents but the same ops/priv. Then, a single dpll_pin_on_pin_unregister(..=
) will
cause below stack trace.

It was good to add a fix in b446631f355e, but the fix did not cover a multi=
-parent
registration case, here I am fixing it.

>
>>
>>Add refcount and check if all registrations are dropped before releasing
>>dpll_pin_registration resources.
>>
>>Currently, the following crash/call trace is produced when ice driver is
>>removed on the system with installed NIC which includes dpll device:
>>
>>WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0=
x20/0x30
>>Call Trace:
>> dpll_msg_add_pin_freq+0x37/0x1d0
>> dpll_cmd_pin_get_one+0x1c0/0x400
>> ? __nlmsg_put+0x63/0x80
>> dpll_pin_event_send+0x93/0x140
>> dpll_pin_on_pin_unregister+0x3f/0x100
>> ice_dpll_deinit_pins+0xa1/0x230 [ice]
>> ice_remove+0xf1/0x210 [ice]
>>
>>Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registra=
tions")
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c | 17 +++++++++++++----
>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 64eaca80d736..7ababa327c0c 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -40,6 +40,7 @@ struct dpll_device_registration {
>>
>> struct dpll_pin_registration {
>> 	struct list_head list;
>>+	refcount_t refcount;
>> 	const struct dpll_pin_ops *ops;
>> 	void *priv;
>> };
>>@@ -81,6 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>dpll_pin *pin,
>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>> 		if (reg) {
>> 			refcount_inc(&ref->refcount);
>>+			refcount_inc(&reg->refcount);
>
>I don't like this. Registration is supposed to be created for a single
>registration. Not you create one for many and refcount it.
>

If register function is called with the same priv/ops, why to do all you
suggested below instead of just refcounting?

>Instead of this, I suggest to extend __dpll_pin_register() for a
>"void *cookie" arg. That would be NULL for dpll_pin_register() caller.
>For dpll_pin_on_pin_register() caller, it would pass "parent" pointer.
>
>Than dpll_xa_ref_pin_add() can pass this cookie value to
>dpll_pin_registration_find(). The if case there would look like:
>if (reg->ops =3D=3D ops && reg->priv =3D=3D priv && reg->cookie =3D=3D coo=
kie)
>
>This way, we will create separate "sub-registration" for each parent.
>
>Makes sense?
>

It would do, but only if the code would anyhow use that new parent
sub-registration explicitly for anything else later.

Creating a sub-registration with additional parent cookie just to create a
second registration with only difference parent cookie and not using the
cookie even once after, seems overshot for a fix.

What you suggest is rather a refactor, but again needed only after we would
make use of the parent cooking somewhere else.
And such refactor shall target next-tree, right?

Thank you!
Arkadiusz

>> 			return 0;
>> 		}
>> 		ref_exists =3D true;
>>@@ -113,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>dpll_pin *pin,
>> 	reg->priv =3D priv;
>> 	if (ref_exists)
>> 		refcount_inc(&ref->refcount);
>>+	refcount_set(&reg->refcount, 1);
>> 	list_add_tail(&reg->list, &ref->registration_list);
>>
>> 	return 0;
>>@@ -131,8 +134,10 @@ static int dpll_xa_ref_pin_del(struct xarray
>>*xa_pins, struct dpll_pin *pin,
>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>> 		if (WARN_ON(!reg))
>> 			return -EINVAL;
>>-		list_del(&reg->list);
>>-		kfree(reg);
>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>+			list_del(&reg->list);
>>+			kfree(reg);
>>+		}
>> 		if (refcount_dec_and_test(&ref->refcount)) {
>> 			xa_erase(xa_pins, i);
>> 			WARN_ON(!list_empty(&ref->registration_list));
>>@@ -160,6 +165,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>>dpll_device *dpll,
>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>> 		if (reg) {
>> 			refcount_inc(&ref->refcount);
>>+			refcount_inc(&reg->refcount);
>> 			return 0;
>> 		}
>> 		ref_exists =3D true;
>>@@ -192,6 +198,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct
>>dpll_device *dpll,
>> 	reg->priv =3D priv;
>> 	if (ref_exists)
>> 		refcount_inc(&ref->refcount);
>>+	refcount_set(&reg->refcount, 1);
>> 	list_add_tail(&reg->list, &ref->registration_list);
>>
>> 	return 0;
>>@@ -211,8 +218,10 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct
>>dpll_device *dpll,
>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>> 		if (WARN_ON(!reg))
>> 			return;
>>-		list_del(&reg->list);
>>-		kfree(reg);
>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>+			list_del(&reg->list);
>>+			kfree(reg);
>>+		}
>> 		if (refcount_dec_and_test(&ref->refcount)) {
>> 			xa_erase(xa_dplls, i);
>> 			WARN_ON(!list_empty(&ref->registration_list));
>>
>>base-commit: ac1a21db32eda8a09076bad025d7b848dd086d28
>>--
>>2.38.1
>>

