Return-Path: <linux-kernel+bounces-161290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F88B4A28
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E141F21A38
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2D4F1E4;
	Sun, 28 Apr 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sli+qyyF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98B4E1C9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714286724; cv=fail; b=fv3BR/jGWlEBRfSqCFlDI69TV0fX96BNsZCiTePrCbtYdxf7Uq9IbvQ+WMz4+u0YyS76Lnbb+EHXvVreLdeBiOPbr9mBbBabck1ryjUwQT7O5W7TeBfe/L77fsFdMbE3OOa8hMZo2eXXxZdTlO9QHrGLjmncitdZFsLsT9qnRFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714286724; c=relaxed/simple;
	bh=R6PqILx7+dBviCw4ZwRdXW2hzhkcXI/Lvz6ssi0iEnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9IGlXu5SI0l3GoNeZ/nP9mrcdBzjKNLp2APrqOYOCPDFQ37s8W3IC9U7wjTe9cbUQ3byd/WRRVZoXqtJUlkWrEnlpPSRSQjRxWWcEoceo3cxD+gXQxevoeU+MK7JHKR8BBOc1H7UATsI3m0U2H3xQWF8HGKM+9cbI2UtZ0Fa/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sli+qyyF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714286721; x=1745822721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R6PqILx7+dBviCw4ZwRdXW2hzhkcXI/Lvz6ssi0iEnw=;
  b=Sli+qyyFoGda5imOi5/BYZqh9gIwn6fpB0OyZcxE81fIcFphdx/uK7Uy
   W/uLkCKFeVwwJ6pPmRpe2LO/xjnaYSIRhiqysGK+96HQmezqXLMpKJ78Q
   FRawPtdNs5Q88DeQwIP9tX9wTBdK5oZEi0Zd/b/vL+nqxFNjShjnGZTHe
   Od/iwIAojle4zhQx6zCeS07Aalu3bUN3GlJuSOiJvJqW8KspF7DM1plFf
   DBb2t+9osYYo+cRMwz9ggwFMy4JvZANPPUO+ovtSCK2S0P+kkpWEz3kzL
   8DvpCiDX8AQZR4eVutWxz/JEAIQ9xo6si1/DWzYqYvfqEWQvcfDdTWX7m
   A==;
X-CSE-ConnectionGUID: uY997A/mRWSCbHKkqa3Gcg==
X-CSE-MsgGUID: gfo3Y3P9Tdy0rdhTfuLaFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27427705"
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="27427705"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 23:45:20 -0700
X-CSE-ConnectionGUID: g/GErhZhTkKhI1EVW8qQIQ==
X-CSE-MsgGUID: idqrWWiTSCyyqKrppljMmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,236,1708416000"; 
   d="scan'208";a="25792061"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 23:45:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 23:45:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 23:45:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 23:45:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 23:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL7JEZ/PW2fxTOPfw9f0uiheOMxgDQTCERHxE3rZkmlYBJgH7MaL0tu21aShuq83Fh41l7reRgGuZNR342nN8ZPiwp/oHkkzTIjrpI0LnJ7vl521ea7vQ2JdPtklkKI/tZJPUnUNI5ra2/gNbm0HTXQyCj26nCOb7BTi6AGVaqi0UM0vMdTUNACpnx+QY9V20wjiOdGZal27ancUC3/u3ISGwoyf6P6MVOlYgXo/FhY1JuPYP3poYhjdaBecbp382Jo8kq2jQPlKIalMlPD0xBokg6VhhL3Dx1jIE7z+mkR6WlKUqFKp1fZlZ1HU7NqZRRW/pZqiUKmTCyJ9pf+URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxaM/iKX+pylLIWTj/Cd8Cg4GP6mzGx79dwulIJ+EGQ=;
 b=aCB41pb+Ue2PCpCkmOZ02W8c4iihqWYpokkIHmW5O5QhLzEH4gYjqJtilFfdPSMEFja/iHrGhkMA0gWqjzxWWCAvqbKQ2fZ3AlxfGlKMBBXTMRwmzH9mj78MA0WzYy3ZA1ZwKW42zc3OwNPUhVKCGuU/4GtDy97fwp0FMDJiCm3LdEueYuiXDGKGlJ+0Tfc9lZE2FD/WvKX8Ekvk4W4pgDvG6/JODAtwSRkvPeLsGC+KzNVZASH4DRPS7qsS682s916bKcuv0VN25+Vi2iGy4dcrYKf46+ZCZQoxKx3OAPP513kcnLy+EvS+ozVxmr2S+gDjIWlxHTCB/HI7SNAF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8323.namprd11.prod.outlook.com (2603:10b6:a03:53f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 06:45:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 06:45:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Decouple igfx_off from graphic identity
 mapping
Thread-Topic: [PATCH 1/1] iommu/vt-d: Decouple igfx_off from graphic identity
 mapping
Thread-Index: AQHamRs7H6xZ3tB/HkSdsmnXbNR847F9O6wQ
Date: Sun, 28 Apr 2024 06:45:17 +0000
Message-ID: <BN9PR11MB5276AF4C9A57C3B8D3A25E8E8C142@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240428032020.214616-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240428032020.214616-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8323:EE_
x-ms-office365-filtering-correlation-id: 5ca50540-55c1-4660-8360-08dc674ec419
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?QsKGBDHF+lPc6nz5k8nuWQFUw+8sVVfI0SaH8mVwrLKhF0uHSIOEgga415gB?=
 =?us-ascii?Q?q1vrfVgYT+jkO+awITan2jxfWhpFbzniyWfKRx/J6K0TRxI415HEReA+tPu2?=
 =?us-ascii?Q?azD3SCadyYX4wqHuNjOvnlTJZygEOFTDI2rhZA0dX6LOgdPEhHEpgelnCFkc?=
 =?us-ascii?Q?DGy0SYCD4PtkJI74OMqQa6fdChdNbd/IneWLIxAr/54zKqYQyCP1f3ZY7D53?=
 =?us-ascii?Q?zdDQzstMNCPDF7DN6ra4hfKGibV5Bd+Ueu2j+9uFtf109OHRJ6f0oIW4Cbi+?=
 =?us-ascii?Q?M0m2atLN13RGmXt1qvfNfXmyxVxoLPH8sdG9+aUdS2HN8OcIl+GDddJcvjPD?=
 =?us-ascii?Q?iQIo+U6n3hHV1xmn0D8dD2cbX+O9QmQQTY3aqI3dgNQsjh5V5f+5p2AoyZdf?=
 =?us-ascii?Q?KAlKMmvo7OjYf0j4bxBimURDF83TqtjGXAFYAtxGif00oiqzjPxxaXYMpkIJ?=
 =?us-ascii?Q?DTPapX1dT2RBWGaqIKQqhiSK4dcVPRuruEdmrI8P45XRyI+QDFi/hCuQssG0?=
 =?us-ascii?Q?Ac8RopqJsaZL1zPQkNFJoE9vhMJOwvSB7Iid8L5UZi30gJchHPERVO5Ty3Nd?=
 =?us-ascii?Q?pJKCOYkUIOAD+rmZdkT65D0Se4V3g+p9rNiEGkMfYcsI8vwF0uGhTy8Uw3Vx?=
 =?us-ascii?Q?GlNK7IKf9tdK7GTKPDhwQGpQ/avpPsXrLJBso8u6SoxEGMbOuPJwPTriXD9c?=
 =?us-ascii?Q?opQdMNpG0HjEGShqzv8klWjq9GE/O5l5CbZdA08uY+WU5n8mkNBUzvYCoWVP?=
 =?us-ascii?Q?BjvbfDrCpTNjQmCeK2bI/gnd1cQP4CWCukB4ssTmPmFNlXnGOrOIp8BNQ9Qs?=
 =?us-ascii?Q?w/X6zBLSclkn5whu0X1Ftt0vkXVfGm1LsqkXJFD+XV9eRn4lQl9+eALudpP5?=
 =?us-ascii?Q?SybQmDkoT4i4QgB2Ifrjo0WIX08IchqLTOrNjPqAXnMo/lnx8hGTEJYI1x1F?=
 =?us-ascii?Q?Pa5z65aGZi1RVH8SY+qKxiOS+7LlYUAoLTAw5S+wGBrB9gSIVHIKKBGIp+to?=
 =?us-ascii?Q?TFHjpwETDAFQAumbJrA/iANJ1J4bG+fihNjZCcLAzraTB/N+bxnAcz959JOh?=
 =?us-ascii?Q?kCh6jzr49nvY0JZbwfN9Yrxpf6EzVPjzxYy63N25RfgjI9SrZSsdH/a6Pd1g?=
 =?us-ascii?Q?hV8Onr1AKCF9XJ89UgGd9ojdfZipK6v2xbD+i/bb4oS/i2PWofASo+8UBKxT?=
 =?us-ascii?Q?lfy+jaQCjOhhLs6q6i5N7lrkQBS/OtFbiyHDOkY9FQ0rO9pmnEBQGaY4jmNl?=
 =?us-ascii?Q?8EhLSscwh/t4LL0R85ppMqd0w3FA1cIGaE0rjKbVu+hUgCQjsNbPBJwvyKgy?=
 =?us-ascii?Q?m0mWhMsfn0Yf86WNB/VKt1CP6fJcgz5BObkBHrFRMBtm6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YsqHLWLSkH63z7pTesLLu03iPa3yhU089YaqLNZlek2yqBxkFMT9HzIDl2Iq?=
 =?us-ascii?Q?wsnl4UEiaaaqbnGRqnl/zlicMAZexHS2PeQMDPQaIuy+yz5bOoJCtKIO+Ac3?=
 =?us-ascii?Q?CoJlPlgv4dNOLeInFdh854UhtJ2VHTQHw+K+thm7y2Xi6Kz5cOFMpGJ3fIzL?=
 =?us-ascii?Q?wygTqe+6smqNRepHyoIWzvAMqEee8UaVm4TahBRcs4sAC0W0Mjo2l45EnF13?=
 =?us-ascii?Q?WUXzJ7WwWtnsTrx25SSPLhPY6M1unTQhcgMWGAi8pRgXmz+/sHAmecCMInEu?=
 =?us-ascii?Q?rpWvE5CdgRnTjJ+BdO9nqu4sdyamh82EKlgfqP6JOc0Y6+FIU6dIcuQZhP/Y?=
 =?us-ascii?Q?MKOCBuYF/PXtiGiu/gwbdoDiZxuemYg6uJgVgqkz7ULMVZ27lYrQL+R7Nmu/?=
 =?us-ascii?Q?xMoKK1yWaR/4kciqoy3I9kpXE8tG/XSp0l6Isw0carKnZVj6OU8FbNRpJwBF?=
 =?us-ascii?Q?g9r9CMlzZGeujLxWzMaFlgRY8akecYraUq0gTA7Z7iigTrwBkwKfETbDI0lt?=
 =?us-ascii?Q?MR/2T5+sdtswEsr+vJM2ZI9zkNghrmu9mpofIdVjzWehDNPAzlWrLyQRzTlM?=
 =?us-ascii?Q?2+qPAr/C5fcI5R8sZNo8oTuXMXEpGheYvQkX8PD/f1PRQ27aZTSMyTuwd5A2?=
 =?us-ascii?Q?7uyqzg0QB250PzIWPGVI04EsztrLadU51IRmHOR+3cFC1T5KUBEVE0QzhdWh?=
 =?us-ascii?Q?pOLUbWUJWrR3P2waHJEkmHaFfV0HMBK37q1Bj0yzysS58yXPxtVeaIGazXu7?=
 =?us-ascii?Q?j07pgfu/a98u+LMje2w73OonFZhMbd4z4wslGbEyoXOwZassoEWfAAFoXkL8?=
 =?us-ascii?Q?PtSig7TS17mJWIk9XDkmz0/SrgaMj38KWUFj1jhbN4sIeL7Gd79+HR9iQl8l?=
 =?us-ascii?Q?J4IoYsyoKocw0+ATfm30E78/95rtC01g+1Bw6ZH5AlczVjDADPTLreuOJCkl?=
 =?us-ascii?Q?Bq3X5LkQWszQ+uzP4cK0SJDQVxXCgZ7OOG1+bW5pPx6wUr446YD7VqQPAbar?=
 =?us-ascii?Q?8hnQ2RDEN7ZaFRbx8g/2RWV6Fmu+orpNHnWtlY7KyyUTcNO2DFIbW1mMOHIQ?=
 =?us-ascii?Q?Uns7FuRuI7qywV6okk7WmrUOtXHFB7zubHNsXtmsaSQ5rAhVffRlyA6NpDgs?=
 =?us-ascii?Q?viAGP9sjQoPQ0bfgq1xaoBjWPvTpgsxaE1CDUYZFBOZypR6bixEilCbLofzE?=
 =?us-ascii?Q?P6HQ8g4E8RMmZnbbW3h2DaHrJAEL4vxuGV2PKHhFZ657mZODDo34vsYnSCnq?=
 =?us-ascii?Q?44AUgjDzQA3D9GLpDNl2Qum90AuvERLTgVUa3g+mU3AKt2uHed+tFl2rpock?=
 =?us-ascii?Q?n5jsg5zUEm9kVNJCXFgYMQnGV3MsWfAtNzJGNLnS5NvAhUXSSsSte6NHikv+?=
 =?us-ascii?Q?HHwOjTBn/DdftKgkUAJnx1bG4W9jtQzTBXufnLUYUyEIANPAHWTyRJS1gZEv?=
 =?us-ascii?Q?hDBCyipIEkR+TI3IHHDQFyIOlEjOrpt7qaHesQE/bTxXK1gkIX9Njybcrty5?=
 =?us-ascii?Q?UvlN7cfpyZRZlDbci+FJQlAKICwyu7KQf1CG891TmJcTVqzVJfUSQfGsh2Pu?=
 =?us-ascii?Q?MUpiUOKf7Dq0mG3N25wJjok8boCAHuyym9HC5Ws6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca50540-55c1-4660-8360-08dc674ec419
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 06:45:17.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYwUMaYoza+G3hkY84ZkrHObXI82YO62FFWyEhZqrAZZH1OdVkOdsL4xep/bP9cG0vGICD3jusWUyPLRcK7gMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8323
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 28, 2024 11:20 AM
>=20
> A kernel command called igfx_off was introduced in commit <ba39592764ed>
> ("Intel IOMMU: Intel IOMMU driver"). This command allows the user to
> disable the IOMMU dedicated to SOC-integrated graphic devices.
>=20
> Commit <9452618e7462> ("iommu/intel: disable DMAR for g4x integrated
> gfx")
> used this mechanism to disable the graphic-dedicated IOMMU for some
> problematic devices. Later, more problematic graphic devices were added
> to the list by commit <1f76249cc3beb> ("iommu/vt-d: Declare Broadwell igf=
x
> dmar support snafu").
>=20
> On the other hand, commit <19943b0e30b05> ("intel-iommu: Unify
> hardware
> and software passthrough support") uses the identity domain for graphic
> devices if CONFIG_DMAR_BROKEN_GFX_WA is selected.
>=20
> +       if (iommu_pass_through)
> +               iommu_identity_mapping =3D 1;
> +#ifdef CONFIG_DMAR_BROKEN_GFX_WA
> +       else
> +               iommu_identity_mapping =3D 2;
> +#endif
> ...
>=20
> static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
> {
> +        if (iommu_identity_mapping =3D=3D 2)
> +                return IS_GFX_DEVICE(pdev);
> ...
>=20
> In the following driver evolution, CONFIG_DMAR_BROKEN_GFX_WA and
> quirk_iommu_igfx() are mixed together, causing confusion in the driver's
> device_def_domain_type callback. On one hand, dmar_map_gfx is used to
> turn
> off the graphic-dedicated IOMMU as a workaround for some buggy
> hardware;
> on the other hand, for those graphic devices, IDENTITY mapping is require=
d
> for the IOMMU core.
>=20
> Commit <4b8d18c0c986> "iommu/vt-d: Remove
> INTEL_IOMMU_BROKEN_GFX_WA" has
> removed the CONFIG_DMAR_BROKEN_GFX_WA option, so the
> IDENTITY_DOMAIN
> requirement for graphic devices is no longer needed. Therefore, this
> requirement can be removed from device_def_domain_type() and igfx_off
> can
> be made independent.
>=20
> Fixes: 4b8d18c0c986 ("iommu/vt-d: Remove
> INTEL_IOMMU_BROKEN_GFX_WA")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index fbbf8fda22f3..57a986524502 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -217,12 +217,11 @@ int intel_iommu_sm =3D
> IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
>  int intel_iommu_enabled =3D 0;
>  EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>=20
> -static int dmar_map_gfx =3D 1;
>  static int intel_iommu_superpage =3D 1;
>  static int iommu_identity_mapping;
>  static int iommu_skip_te_disable;
> +static int disable_igfx_dedicated_iommu;
>=20

what about 'no_igfx_iommu"? dedicated is implied for igfx
so a shorter name might be slightly better.

otherwise it looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

