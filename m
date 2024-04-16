Return-Path: <linux-kernel+bounces-147769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082A8A7967
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C291D1F23D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011213AA47;
	Tue, 16 Apr 2024 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpgR90hT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EE137C33;
	Tue, 16 Apr 2024 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311835; cv=fail; b=hYYfWx4S1w4BS8mhTHxcL9LBtH+5FD5gwQert53V+6OpgfGxoN/R1oX0IsK9BM8Yxh39/5AKVkvhgIbMfA0gtYUeEHD9qXoJjmKOu7BxDK70H/ozE1KMBNhb/6D86yBJtkksxg0Xi91k1ZvfkeozL9+VtPg+6SVGfA4P1oBNdrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311835; c=relaxed/simple;
	bh=kar1K8Oo/G3r+lPHvv0fCeHaEzEV/KRpGCSF5doQEtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CShx0uC3rGMCd+3U9N3b/edI2ljv5jcneOGqtgd3uzA1narJ3zW1XiKKToTRLWHsrZNAkGwNr/2qh9rNPv5W+OJiwPCNk5FRWPR2dApQsBAHI3tDFEIdIf1NLv6u9njwGj+dydzSMZZayTHUtq03kFVCLBgRLVpHB0FkSTSgv/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpgR90hT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713311834; x=1744847834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kar1K8Oo/G3r+lPHvv0fCeHaEzEV/KRpGCSF5doQEtE=;
  b=PpgR90hT8vG4oyRcMx5GE86X5lfiJ95ycczZR4Ec78s3/ZYNok9dxbbW
   dR3x+zMBDQIu4lYruma00ZY1szHB4QczrUwZOahwGrJ3IWQRg7id18PLM
   g7vA7/89i7ajg3RZWasBTFyqYBoPJXjU8TjhcVNgp7WjTM/AQ9+umr1TN
   6L/4UdgdOS28uJ8/wiCx+YsZsuwxNMsCNBkszg7ikfrCaTVO7xZdzINiC
   uNreBxB12K5zVkTy2F/BjO9tQXsvt3hcEzvj2PQosTX8o8lPcGI8EzpDz
   rxRqAEetyvKUktKu6WeLMNX0yhet/1Li1FCga1YhwDdL+Bvh7k8QCJnHz
   g==;
X-CSE-ConnectionGUID: DAObGjQFT+6hTV/iwaNQcw==
X-CSE-MsgGUID: Yv8pTGoUT5yT0uGQsJUMoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8644353"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8644353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:57:13 -0700
X-CSE-ConnectionGUID: U8JCzoIjTQ6SaE+U0+FH/A==
X-CSE-MsgGUID: dOcrPtayTCOJJH3GgTJfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="27222704"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:57:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:57:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:57:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:57:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:57:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0KCPz+7TEGgffrTRjdLp3Edge9iIoAe1w7+kXNCKcw7ScSt693ghj+n2HCROdMkNdA9qx8m7/M3H9pguGANB+l1sQSKuJnblpWcI2i9qByB6RkbLLvGBUEbnl2tglTat6OloHnFTZdxfoqYDLsBGoXxC/bZ/CkhdE3fwm5MW1Jz7hm77jtZQRINCS8l8gh2bHUWhxH0C5vEu2bcJrASZdmoLKqC5t87aPKnwEsT8k4lh4QOac46aMpkwAnzppWdT6EX2ElZ/3XvtlZn9qCUSPh8SMawbN1fg9VrcH5f/M76HKf2Zti3oD55AcSL1BAeR0jAtXgO5OiU33waDQPqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kar1K8Oo/G3r+lPHvv0fCeHaEzEV/KRpGCSF5doQEtE=;
 b=e4ipBt3IIgBQuB1cKxvLVwUkYTuEpRxHvRkTCcOSDaW+IRR8iiiUxtZCstSsNNrHP9OxQ/O7+p5cj45ioi4ZOhcJDzXM5Fcgxh6X4WJBeyfrk5UyIx2F3L0vL1xU83VlVScs7IlfGDzci225GpER4voilcIQ+3zRieJGzICngX8Ab6qskqL1FgKENimyNwmkKW1p39CKk4jBpZ6L5I8b5n7G7xPJ3IfgvvIjMVrU74iikSRn+fXpMND3o6M7VWJdwmpy8vneJvDFghkYMTvNP0Q6vQsf2yK0QR4zPMjIYp0AATcSmPUc/kgzyTAskMsYsaNtGi5SwUSNidJo9yJ8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Tue, 16 Apr
 2024 23:57:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 23:57:10 +0000
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
Thread-Index: AQHakEQwBnh1fvUg7kmXRylMjbAVKLFrfA0AgAABsLCAAA+0gIAAAzKg
Date: Tue, 16 Apr 2024 23:57:10 +0000
Message-ID: <SJ1PR11MB6083C8D12885057BF3A0A6AAFC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212216.9605-1-tony.luck@intel.com>
 <5869d164-25c4-42e5-bf87-c4aeeac57388@roeck-us.net>
 <SJ1PR11MB6083D0DFBC7DE286F986A453FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
In-Reply-To: <8690bcea-3ff4-49f1-a671-16583b8d241e@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7276:EE_
x-ms-office365-filtering-correlation-id: ed50affe-6309-49f6-051c-08dc5e70ee33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NS9VphEGR1agI56qzkkGCUjCe8LIN0q+mf+HvRyp9O4zCxQiJCUHiKbNoKOxXiPZOrHLgq42oSXzfgR1eGLp8V+ImGJWLG4Y0fgn62ak5mi95J0OzDu6A90d7BslJFA0damfFxCDNb7WQzlxSkKF/V1UnyuZ0F1meuxrhLZLM2Kqbp3Jn9BL66BGaMhGvRPDO/4WTJiQG5bljaS+JYW8REcSj51h9i2NL/D2WhTYguTmtmQoWVqTAEPc5UXj8uqM0XmuM3P/JCr5Pf8qHKH5HWqUyaqXtpvB3kM/6B8mhAqV4GP0O11sN9kxQlPodlSGk9JoEJjrDIrTpVTE19rYIz5seo6qtOnCto2FsEF9rJfQmPBKBatfyFv0GYmH93BTGlbyjDfw8gK211xUDCNX/KwmkMb69PF1hhXO9znGMplEnpsmU8gulfhZTXssW03HZsRgLSwQCHq+J6IQj9vXVdN5F+sbYOGqa3wirpzLarHt31XEfoTUp0cU4xdA+ix5f4qxdJEQ1nlu9TyqH2+7QnJ9rn4kRQKgwOkSbo+m3EZcW4iX8S39J4zWaFm5WiyeMchWzE0zB0VSA4TRKOd2kGelq9xljikkVMWljU5wkR6ldAGsTuuCLDWhGQEND76/W3YFVPspHCXNRz9QwLMForrBET//hMBXiHKivJl2MZRrIB9887B4UO2ZFZopP+/tWmDAcsrNdWLQhZVxh+ofgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H/izls/gwmp/C71PnEmTDtsJauJ3eTpoP2rJyFo36+SN3dtxI0c2gtkumvsG?=
 =?us-ascii?Q?8PJ10VQK0hI9fvgysygl/aX/UqcoIyDLuRFxLTnOfmvzeoDuZEMnteN41PD2?=
 =?us-ascii?Q?+H9Pipc+V+P42HvbBqf0yfrUT2fhdk2ENOPex95GFH2DZIv9UUdqutTPXYQI?=
 =?us-ascii?Q?5KgfLZ12XxW/l5crk9N5+IVkSfZebpTV1DGPJE6PXtl2QKPjEKrH7RxPqJ3E?=
 =?us-ascii?Q?V+kvIbOGgnJHBPK/LrZOIoBS4hCDgk+s4xNRizegk+4kASrN5XJQEJA1nfel?=
 =?us-ascii?Q?IOtstFpl0BbO3Jdv5sygNny3ME9Kdgr7EJC7bipl6KPEpDuhVX4LNAT34wrM?=
 =?us-ascii?Q?R2Dg8CpZZalTqVyQgIlZ7GrfLIn6BZfbT409gOqD9aGuLPU+Zl70znkACiX/?=
 =?us-ascii?Q?E9pl7pIH2YCh5+fTuNFrBf9jqMCd9zz1oCU4NCa0UB3lgO7sDbCrW5vVODY3?=
 =?us-ascii?Q?uGLxOCV4DHniyQXlc4knfnreRx7P37Yv2jst3LsT6hd4+CsskIIuu97VhC4d?=
 =?us-ascii?Q?lQ480wlcbzW8RVd7PBDknx2+aAmzvT7HLah3xeLf+4jba0xjAPrPIyRR4jVd?=
 =?us-ascii?Q?LokszLRsDPTZ2R4sDi+VGNKSyy4ocCpMFyf/gNQkvTn6y+FY7F2A1EQRz6DG?=
 =?us-ascii?Q?IHQlOU+JIiTNbTOQiSdwDgKEuAaUro/G+y8YqoWDQll3qTyVTF3eOG+rgzft?=
 =?us-ascii?Q?JBzyOsVC0CDtqQVYH++1N3dKlsz/cWb20hwaQKRX/OFivVXjmOuqYElw7gRK?=
 =?us-ascii?Q?uFp9RA6a0gE4XKpR7lqEkuR7cVnc/Ze016WLt2oIhF9LzfIWnkYnaCdu4y1F?=
 =?us-ascii?Q?URg1PSJBRgvImyPHDxMTzw385TF38qlKgLu+cQ1KJa7Oy/Haww/uNl2fSgdi?=
 =?us-ascii?Q?uToWvLAC+oz9OBFmRa13OHc/4cCVeHnwGgcNFgYpZNm/+xQGiwrX/bkS/13C?=
 =?us-ascii?Q?XzhOuQXaPUmMu6JA2U2ZVkqCCXJ7z6zqzj13pUN8iCKm6QHEUMBoBanwURWI?=
 =?us-ascii?Q?BS53eyYRfTQQspnFgMtipnMGZZd5FGO4bquRMKpYKYxuh6fQYshUhnlFA/v4?=
 =?us-ascii?Q?kr8C+Hlgk1TV6AYUpddatXWoINSSvWjs1tuUvTYErXYNZhPvSjTQfV8h3gfx?=
 =?us-ascii?Q?1fuhDbrhiMNTPXhytbwcf4lCLzJcFW/HXg10r02ifDOzoo5fxGZUleO3j2aM?=
 =?us-ascii?Q?4LKhmZLgbQgARQPh5yXdgq+jOyDFDbr9ApkBtspOHm7r1QTqsOAjuodzBcIJ?=
 =?us-ascii?Q?W8Y5pIxSfH77EEJAyPu293vL/aeih3DQMsWcJBAljcMR0tgCKqyNWN7IKrRX?=
 =?us-ascii?Q?3R7knJe6jVKZJVdlCrRbckQcz42d+wsxfiKCdvOIXkXsItcJFJ+CJHDWSVsp?=
 =?us-ascii?Q?tWeJiDrLDWzDwPeKVlq0nrfNRMo1U3Ez/6mGQKRn+rstfyyhYOCNr1ouNEdI?=
 =?us-ascii?Q?j4lHuxckL+uW/qbGSYkYdvztpGhSjrvRo9/UKF8f6gwA1x5QB2+8PGiLOAui?=
 =?us-ascii?Q?7905GEAvVLBiWaMrkqFJoaFCRP340uCH011yvZfkasjAW+z76GZf3bEvB4WW?=
 =?us-ascii?Q?iCbzftKlfcJutu4I2xr7XtE4SN1mcRTm5H5gOfSL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed50affe-6309-49f6-051c-08dc5e70ee33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:57:10.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5c8ulSXHlD3LwNX9cDalGXg+fkcT+A0IfOLneGOwxPfeOJiRIRJg14ba78ryoieaInV4mGEZmGNJVmrd/YJUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com

> If the CPU defines and the new macro are to be kept in architecture code,
> maybe include arch/x86/include/asm/cpu_device_id.h from linux/peci.cpu.h.
> That would not be worse than today's include of intel-family.h.

Guenter,

Looks like I did that to resolve one of the other peci problems. Because I
already have:

#include "../../arch/x86/include/asm/cpu_device_id.h"
#include "../../arch/x86/include/asm/intel-family.h"

in <linux/peci_cpu.h>

Simply deleting the include from cputemp.c builds OK in the
context of all the other changes in my patch series.

-Tony

