Return-Path: <linux-kernel+bounces-147733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D5C8A7855
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B930B23043
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B9113A86B;
	Tue, 16 Apr 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdAgZuj7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916963B2A6;
	Tue, 16 Apr 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308721; cv=fail; b=DPftFZ7As0eTYOuCCKjWGP3QLb+3cFGFWLSzOLAf66hArOJNKnfHGGOzGqa78rdtOnUXesSwVWtCl+IDx+oyve85C43TaxVGxd7ySJLvhU80G65zLl2TpdcD/6h/nIaSK0xJpRqjLk/loUdAb+wmSiYzkW9ZVYT9vogHswuZuMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308721; c=relaxed/simple;
	bh=aW7jINDDZQAqUt0HjWaqkQx4v6U/0dcn0Lf2oxH99M4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rc8AuouqmB6i2Cluly1NMcCTPH7NK0XlO7LuQQt6HjmPS71+huPYsuscuLohMqXeGvHUVppsvu/6eDe7Aa0gI2zIjzM3AqhbXe9B2rtpnbprAQCpJlt+979IOO9eeDNDLeyL0F64fUHmLGO54MAEXQw+L5ciACyDJCDjxUpwiMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdAgZuj7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713308719; x=1744844719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aW7jINDDZQAqUt0HjWaqkQx4v6U/0dcn0Lf2oxH99M4=;
  b=HdAgZuj7uHN1CYGJ8yZlbzWLlV6FmL3LLCkdcGTrTeDHGkLddJ47d7Mf
   K/DS7COD7dNVHFOmTz8tKGqEra9HZb+11i6tvr5PEUrrPm/PddOnxT0m7
   OUKYygDYRWp1pKCiPmkMnxwnOv2iNdecew8YjENBEFYs2duSYeryiEgoK
   MAcVXUsSx4obV9WX/sOID/f7AfTa+FFkAKjZVQoAuSHa2Kyg1Kl9a5kbR
   x0mLUvRAvXstzfOpb7vh6O6hqwjEgklb4HQGx0A0ogtUK7vbHxARDJn/J
   2Po8LkXYDsqxadVbs39ld40wHj/k2EJ/Hcglq6nmeQ06GZxPKhTnzjn6Y
   A==;
X-CSE-ConnectionGUID: lCd4BuH8QNSqiDi8M1dSZA==
X-CSE-MsgGUID: iB5/a6CYTfmTplLyyczXjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12618705"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12618705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:05:19 -0700
X-CSE-ConnectionGUID: tufZK44sQxedFrKSsVQEwQ==
X-CSE-MsgGUID: cSszwBL7SYmcgD6TJe12LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26852081"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:05:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:05:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:05:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:05:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg8n/YnS+cCWSzxUfGwoiTneKoso93I5Yo27NR2Sg5wvLbDSuXBcp8dy7XAXzOaK6TC2OjuWWJ4USPncRvCXX3xoxFg2RqtSLNlmhFzxBMJpPG0sryuUAgTtOO9cN0ExhdamJGIUcmBUXPIt4E6rB0c0bMQfOtLRhCqBrIBT+EnM/7Se42fBI6o8cfrlpl2jJNT+ZpcSzr+8I6d0r6KqYfUtm4lYoGuWa7pD+mdRLPGtJPdMCKEoyWqq0hQ0sjAS+DCPPHq1TSfUVFUQRiqEhr//3KqMuzhA3ymNQRpfdPLfBeI5LPednbPpevwDyjto3y4gZZiTuwU3fb3cmJtoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TsXrTGAUxrZN/U5PGM6AaQoNqSIsFHMj+8bT3TUxpM=;
 b=d2CgsnQq4AmYCk0xMbbGOiwlz8OpPKNeinI5BT03sbzr4S2NejPSKWtzEYd0IsBBm7SOCUK2946goprjfr64xD9WMRQ8hQUkAJD+gJrguHQeufuP0AM7+jYtw+NlrIvxHq8g78GViuCH+UlOcPUJu2BZE368EnbkxjFIAGZuvQbrFjjsbbIoPHfRfq/Tz8RgKSaIa0VNM9LGeymKjnU3RPxxraVy6RUa9hxwlox4fvhtpFFbKGDsf3aBBPp+PLwExQZcacLf00PVGh8YKKCDdbnKVbz+C0AF7y7++QgFOOcuox1IRnAoowbKiNjZDAPyup8qf0qxMZ089wtO50FooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4600.namprd11.prod.outlook.com (2603:10b6:208:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Tue, 16 Apr
 2024 23:05:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 23:05:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jean Delvare <jdelvare@suse.com>, "Winiarska, Iwona"
	<iwona.winiarska@intel.com>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v3 50/74] x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
Thread-Topic: [PATCH v3 50/74] x86/cpu/vfm: Update
 drivers/hwmon/peci/cputemp.c
Thread-Index: AQHakEQwBnh1fvUg7kmXRylMjbAVKLFrfA0AgAABsLA=
Date: Tue, 16 Apr 2024 23:05:15 +0000
Message-ID: <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212216.9605-1-tony.luck@intel.com>
 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
In-Reply-To: <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN2PR11MB4600:EE_
x-ms-office365-filtering-correlation-id: 2eaefe13-5615-4763-b89e-08dc5e69ad8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snTWSbPKuIsSWypadRArB7VL8txOyn5M8sxWggQ/TpR+Xn5iZK9zffQCBwE3tYgN8p9dBA51FC9tcisyBsc19O20i/hnZmyZb0B078c+yzPtQ6Z1v+9OYlGYjovcyqFj16gkfunx7O0YRdS4V8TkvtWi7veVfB3xiKTQlEQ1YIZgmLNAF6zBYWY6/679ScGvPWgAOBzG7uHVZactrh38M82oY41LWE5ulSKBTUcBloBhRij/aQNLSvzVGsMtEO8KJFgnPGkzIgwg3V+jLLM9qOkjMlGmHiTpkqHHUQ+cDLlHfhpc02h1yd5y73JJdZv5L/4JX9IPPsgeGMYErZ4Q7ADi4tzbfEqdjwT4IufOaNneZOmJaEKf7qjw7QlpGliFlI4NnENfqY39EL8ZNRKMd/bVootDNIZ5Rzbw/4viaiNiPwwxeZQdzIDxWjfH5aWoAdc9Wa91rBXkxoD8rRjdT8FDNUfAcP5m7dFjiJYHisEJOJTcq+RUgQ0nq9xxJCASuIoFbsN/rxPR9pJ0zgXhRH9TyQ5nKOqDFHlHI84C1PcFddEZprK1kZ2HRfkHFX/4RZJmlcuTr22J0685UPvpqOsGEfhG3BMnwjLfr8eW4MveXAMVkm5HvbYtDFH8af1GR9DUezcq9SpHnF22S+BytzD5u93CuSl73d+mThktPsu1XANa89xqCmcz0TAniHbZ42YNbx2CDpCfmnmHyBec3j+LPpyJHezeOnFelbF/BIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zu+RN+ccOMKHeo5JuuPLl/PIvapsp4GvtbF0xCpJah9W5Dq2avs4FS7WESAZ?=
 =?us-ascii?Q?IrTT/819Qf3h4zgPc5v8SBGgrspl5uqxPnwhD5npO3qDbVKXtHMa7f6BM7bT?=
 =?us-ascii?Q?DTY3olFgjMjDxVV1YDSgrcTghNME39RD3O7aqe/4iKQ8Fefk2zAQ/Wr/nmh2?=
 =?us-ascii?Q?W06Z61ndR5FYMX6h9bBfdH9Cw19pH7mz5n+T7tCUmqvXoIcStw0tMj8tPwjo?=
 =?us-ascii?Q?Hi0UoyKocESy8UiNnxQ3VEYDFzZ2g1uQ2MouIeV9LPCO/xOJLuXrF9GjTtzZ?=
 =?us-ascii?Q?hwvaawlZNtymgHuNjLHMR17/YRYiR11/ho1KJ2bZ/wJOJwTvQRTBFV6rYK5j?=
 =?us-ascii?Q?hO8+2baN5TJUdnglWRxKNgwM26o2nRcQdM0duf4nHX2OY7Q7T7kMsxPe1mUq?=
 =?us-ascii?Q?txIzS0irLGLr24JyIzIcsFUxJtu9QU3lHDQxWs8bI/4XAX/2E4g1AisTyh/i?=
 =?us-ascii?Q?qg+oB5/vY6nptE2hEMzThCHNYGcn40gezjzwzn24DLhneRm84bq3gVxKgUjN?=
 =?us-ascii?Q?WqoBQiwMxtOyoTwy4J+3IdN3hnGVkTWKgUFaLKOdGLM+7ecf2Yii6YA47/h+?=
 =?us-ascii?Q?lEPc5cTyFrBIzCj7ljJHvQmeNCykJjL13ci3kMLtM2bBkeB0tNerupdvbSw3?=
 =?us-ascii?Q?burEOlQ03hsQ8eVvG6rkzE/y8NNpfDFYDDbnuhpLIK0W5f9vy5v8LmDYHWkK?=
 =?us-ascii?Q?KfEpzRSFDkiuo11519Pr0oMyCoxsxp8dRJPe/kvIhyO0qyLklfibB79Cuujk?=
 =?us-ascii?Q?tUSkw2I3XgvlQ2+F35EsBScYJ7eoszOnzHA3R8aSpds9c7sw8QH4ig3/Qo2K?=
 =?us-ascii?Q?8/KL7C5XzHwRezjcpl5kRMFMabQeU7SRybyFp3KX+bdt/jwa+HozpSoP0yZ/?=
 =?us-ascii?Q?UskTfFBx8gCJ09WTagrGYIyeBt+RQEWXwERcv4vz/HC/RYziU87jIZSoiVV2?=
 =?us-ascii?Q?GluZODcy/qhulaSEzJPHUMofD+pJ1oW6//xizCPbMpL0u/rQdRqd6osBNQVV?=
 =?us-ascii?Q?id0rAQvy6E4kkl+0XChMdd/NU9kXkXLsDMfAcqmnm0Pex/prnaaGA8fJ5cJe?=
 =?us-ascii?Q?/nQ07PUBtlVz/aB0az491mv3PGH8xEdm0VZY55hiSz743bA7P5MwW9OjEcy4?=
 =?us-ascii?Q?uPlliruPY8zgW4YxttHExjw5O0pGuoE0zXs203qEcP8NB1pBfiwX+Pdsr2/4?=
 =?us-ascii?Q?BfDg4O79IwXoAXT55AnNzFk6FVVab3mpZgMwtbdbREvFckEcfQuvXY0nRGzZ?=
 =?us-ascii?Q?L0LqLrftmglji4BRWqYEQ3VH2jjIO61mGFhwp8EHqCmwum6WlqdR5H0vPQ7Q?=
 =?us-ascii?Q?xqfj0FYELV5T/5hXclFd0XfM/JTZBK5KZ8DlN9K2ti3/4/kqdRP7/fLOFQWn?=
 =?us-ascii?Q?cMGndSSgKY9k3LmqDwA/twnjUXBs4/dc72tV005ZwcqWkgynhvrh5p04954w?=
 =?us-ascii?Q?Ica/3dr5qHJarhQ+Xy+3JJiOfIURNchqZ2MrRaPUNE1Omkv0SODnzmu0BcRY?=
 =?us-ascii?Q?JmCUXACOKkhWWvpW6eV82+vcaK6I8Hok/LgnqcTO8cG58/Iiyy4WVa9l7oo2?=
 =?us-ascii?Q?oIvyij0+olDWf279KfToiBRlE3WjKB/M+4xLM5MJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaefe13-5615-4763-b89e-08dc5e69ad8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:05:15.5775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXF0fMzhJ5lUg4Y0aYrz9Hr21DSeUvDEtDPHVCAiTLAvzr7zNk9te0eqwT35SsUD/U2IOYjbYNyOAwzRszcYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4600
X-OriginatorOrg: intel.com

Guenter,

Thanks for taking a look at this patch.

> > +   case VFM_MODEL(INTEL_ICELAKE_X):
> > +   case VFM_MODEL(INTEL_ICELAKE_D):
> > +   case VFM_MODEL(INTEL_SAPPHIRERAPIDS_X):
>
> $ git describe
> v6.9-rc4-31-g96fca68c4fbf
> $ git grep VFM_MODEL
> $
>
> So I guess this depends on some other patch ?
> That might be worth mentioning, especially since
>
> $ git describe
> next-20240416
> $ git grep VFM_MODEL
> $
>
> doesn't find it either.


Yes. This depends on parts 1,2,3 of this series. I should have added
that to the "---" meta comment part of these patches that I'm spraying
out to maintainers of random subsystems that use INTEL_FAM6 defines.

> On top of that, it looks like
>
> #include <asm/cpu_device_id.h>
>
> introduces a dependency on X86 which is not currently the case.
> CONFIG_PECI is typically used on BMCs. Many of those do not use
> Intel CPUs. It does not seem appropriate to make support for PECI
> based hardware monitoring dependent on it running on an Intel CPU.

It seems that some use (or need to know about) Icelake and Sapphire Rapids.

How does this code get the value "peci_dev->info.model" used in this switch=
?

Given that it is doing some magic just for some recent Intel CPUs, it seems
plausible that when non-family 6 CPUs appear in the market, it might have
to grab both the family and the model to reliably determine what to do?

Simple options to avoid including <asm/cpu_device_id.h> would be
to either:

1) provide a copy of the VFM_MODEL macro here.

or

2) Keep using the old INTEL_FAM6_* #define names, but define those for
the three CPU models peci needs locally instead of getting them from
<asm/intel-family.h>. It looks like there is a somewhat convoluted path to
include that. I see in <linux/peci.cpu.h>

  #include "../../arch/x86/include/asm/intel-family.h"


Or maybe some better option?

-Tony


