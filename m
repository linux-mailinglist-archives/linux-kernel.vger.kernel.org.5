Return-Path: <linux-kernel+bounces-78001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567FE860DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BDE1C22560
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56C5C917;
	Fri, 23 Feb 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qgau0OCI";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jv4c12EN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B65C8EC;
	Fri, 23 Feb 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680187; cv=fail; b=tnQSTT3h+xDQ+pb5XfTkQEN2S+g5ZVINm16juw4OpNRdWn7tfZi16D9axHL3Inne+Jc1+I9SbVfWfSVQ7airoS/RRSBoh5WxLyUC49tA8Er05UQ0qR+m1UqqeRNpzktgqh05Ew0zueqGkf8qEkl9+XTvOK7S/vncudC+7nGEDKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680187; c=relaxed/simple;
	bh=sxnBpTbgOeTl6GxAMzV0jKakxmLiP1WqPv2YsRq4U5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILL3I50CPRx6o1o0cZstCBS1eSizquzh4R9hrLxxEchfegLT/tTxlj3v+QWxPSJS3Xi/K433tHtSGtsxl1dINl6uUhqLhcynq9yj3ZF+0kiGkz5NOjR/qKWzb9sXu2aM2apTQhYk52yt/PI7D54WAzOooi3mEGDoP2y1pdyWaWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qgau0OCI; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jv4c12EN; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708680185; x=1740216185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sxnBpTbgOeTl6GxAMzV0jKakxmLiP1WqPv2YsRq4U5M=;
  b=Qgau0OCIjEqEIHBMkyr+gvsHnz744qI+L7qz5LSECAfZ1JGJa1C5Gt12
   rTcoAKwNi+yK9eHYx5PdZ0sZTFUNDrKO4nnNKYt1oupdNp+MKxVeq4IBw
   XPY1cIYHcjUSsV05dLG/O8oymu//O2tD2rzGaArzZ4JY8o+iqmmb5H97t
   VYvAmYxlX9vew8cnbhoePHHlOTun3pGY9Jk5Bh5lyKD3oH6sz0Glhgrdp
   X+ETVkQJLDKZ97V13ruqpTpHa/TCK+LvSqYi2HSnJz08GWkNxZKaL57w1
   gFqzttlQ/7t+TKdU+wZjegFDsN2e4L9lyHDTwJvmZMSZKuwL0iQE1kZNS
   A==;
X-CSE-ConnectionGUID: vzWSt3+fRKux0ExA02lXlQ==
X-CSE-MsgGUID: 8D16T9BKSOme11WcJU1Zgw==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="17247641"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:23:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:22:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms6Mx5tmZGaARuGmMRp3QhesyCX70HlZ97sYpAo7vxnZdrPDDQq//N4Q4nRTc/GsVc2Qr/c0NeFHtqoCbqndEbs3skoD/gPq3vLRHjewypoXeR/3ntDbOSvoSPykhz0FVCdF9iJzGDKa6EWPhL6KMGhSCbj0/ni7vT11C67SHflXC0K+dknJ2dVfXVDtYt5E99jORgWsbToL8gnmb9/sdqFaAaF0+85AeId78DDa1oacDPNAAqP7Zk2GGTiEsDomuMNIOOe71uGK8JKd/SIng2ptb6+cPK1eNX0i96QdUc69KtCXkYSHa1iD7QL42phju/0rkfoQlrAZQiCcbQaHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxnBpTbgOeTl6GxAMzV0jKakxmLiP1WqPv2YsRq4U5M=;
 b=iStIu6fmMYkBvnaE9vIl81CaDym0t6P+8xoQQzc/FPQmaMY4Ei7/UIsNcQMzHKKeHyoqK3M3maRiXGbMpCdfOZuPXxcRRrb7Pwv+c9ts6gaahyeAttaAWzDO+tFKUgaGIE0+VkJtGpnzRrZJyUbwcb2RfLU/85JEpnKcaD3v+YbG/mjoyi1oikh8jx16tWFJBEq8CzMEFY2qJrklqeYvTrjh4STLYELiZkB9pZ5vnf0qIP59QcSRwHO0vubmCTwlQJpH5AsttVKL9gQAEhDKNnVFTEBPJETcN1yh9ci5YR4a31LvLJHiUkHGs5h50e/QVBw+waUtc5OcsFxttJMAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxnBpTbgOeTl6GxAMzV0jKakxmLiP1WqPv2YsRq4U5M=;
 b=Jv4c12ENnY1jII3BZoOb3qtO7cCJKGN4zvQ29GuhObTfrdOnsUDOg6GkCIMovLkBOCkVsKw8FWgeML2wCT9qE4slEWSmr4ylufKGGiTp/zKfgE7PJV7/AZdTIpnjxsUx4YSvyHyVSdHEVkjJF1Ysllecd0gvXn7JWazQY29A6EfGn4jGnh7K1WvH1kf1vuAg7wYCTDCSXxPUeTxxkdxBKRT+qjEJV1OuSnEPpdGGDHpxUNxhzy0p2qD3wlbmj6bHMm1/EMl2vdWoRXlGGSsgeIWhVh2l1QxpSRrYmh3ZTMuD0z2I1qx+aE8lYjprKYyEFxZ2YTX9kGpnrTWiPpWkKg==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:148::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 09:22:55 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b%3]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 09:22:55 +0000
From: <Rengarajan.S@microchip.com>
To: <ilpo.jarvinen@linux.intel.com>
CC: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <UNGLinuxDriver@microchip.com>,
	<Kumaravel.Thiagarajan@microchip.com>, <linux-kernel@vger.kernel.org>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EWhaQAgAEjtoA=
Date: Fri, 23 Feb 2024 09:22:55 +0000
Message-ID: <276f34802a7066ea5159e7214814fb8f78a0e4ab.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <37490c91-a48f-e0a1-ec92-2307c08260e2@linux.intel.com>
In-Reply-To: <37490c91-a48f-e0a1-ec92-2307c08260e2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: 536ee331-95aa-4efb-d5c2-08dc34510482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o39/KQaX4LGdNkl2mX4BNO90Dtp/sFqo6BwoHosnZIxk092SXnwB5RCWaSmljk/6yHV4QKKH/GlK3zneAIhNsTdi3BFT4lXfT0ynNJR/85VSXcMQFruf80/6wgQzbdVw1ejlPkWeBJq9Lt/GIq1A4jeE4myu7QkcICcljZfqdmvcdS3zzz6Hjq2UFc0KyRqEhKzSoftV0jILS3+Ift9bPwcSD9eSVqQy+F+NbYgW7absasX30MtiWvqmcG+Ye2VnuYkAvrMc0omNcpp2PDWRWgU6T768NW8NitGrojLC/1FhOPquPLmDAnplA1GDwtlHgQoywf0S96+w09E+4LXRc50TOQB8k6Nu6ySdC84+xGH+dsWGLzZK0lItS8+PdYCtjtXUzQYssIruMGonKxe9R5kOjKpIA6RL2iNhgVRitepUpKAjAGtf7uuCuKvBBFPHEHdbeYJSiFp6WdIU1iAY571qv5RIV9C5wPHNwKdwYOl7mHYpf6iyPogA7yJhJxYkyrgukW8u907fiHijsbKvD73VJrzyJ84/mxHdr0aE2zEgaLof/tbqpP6PYraMv1vm4MjfuWfFu32Fqp7vEN0NjaV3AiaT2hYdN+4y3cPECjBOJWQm7xGsYdwgY3P+wp3B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akZtWXNhV1djTFZDZFdyV1UxbmMrTEpKY1VLNW1JWkdyd3FkTDlBVU1GS0xi?=
 =?utf-8?B?VFNQa0Urc0dwTUkxRnNScWpLcExCN2FDa1BzVlZXbjUrMC93VEVZejhmU0xH?=
 =?utf-8?B?d2NEVGlWbTRab1JvUHRlUFJuQlRrQ1BFdDNiZVJFU1NkbmlNS2dMSzRtZjhn?=
 =?utf-8?B?RmxhK1N0cUt3UlBiZ2tWdVFRT05hYk1zR0pPMEQrUllOVFA1Yy95Y1ZnTzNl?=
 =?utf-8?B?WHNKVjl1QU5qOUljSmUwZU4vUHBTWXlGMzYxTjBjUGNSSUp1Ulg4WmZoQ1Ra?=
 =?utf-8?B?YVZyZGUxSU4xWjlpRmo2WDBXeEFscURoY0Q3cHVUSk1ZR3EwUFJyKzVHYUp4?=
 =?utf-8?B?UlQxUTQ1MStMV2YzTVp3d055TFhvUGF0T3p5VUdwaWVuOStxTnJYUXA1UHA4?=
 =?utf-8?B?TWRBc2JWbEs3MVRpK2d4T3dwcWNPckd1Yzd6ME5zS2NMbXJpUFVnS2Q2bHpw?=
 =?utf-8?B?RXZZVzJpZVZuVjZHdGpJV1Z3UUQ5QkIwbHczREpEcnEvdGVPWDBNMEVrcjVr?=
 =?utf-8?B?ZVEzVkg2M2VYK3dlekVhZ3hHTk5TdXZkVFA5b1JlYzBYVFVESGdJTHVQM0Vz?=
 =?utf-8?B?aUw5TFFmTGFkd1RxR2xzUmFpVGdLVS81bEU3VDd5MlRsNVZhY0RWWE1ta3ly?=
 =?utf-8?B?QkpSWkdoR0lDQzFUVk1UaXNSSlh3SHVLOXBEMHlPRU5yUW5FUytDQ1UrMXNM?=
 =?utf-8?B?MkNuOHpBRkUrQlFKbTJxd254TjJsUHh5VFV2QStoM2c4TkhtcjFwSWozOVZR?=
 =?utf-8?B?ZGJVbXNING9obzRIaDZRRGVMd1RPdEhhWFhxRVFaV0JkUVFWSllBNmgzMDBv?=
 =?utf-8?B?TG5Uc0RUY3ZhNkQwZkRrbE02cTJDQVI5cjU0ejZNYU9QZDJqb1V6aFRPZExE?=
 =?utf-8?B?bEpOVkNtZ2ZtMTNkanhPdHVySTlQTStmd1RQcHZicjZmV0gzV3drRE93ZXJo?=
 =?utf-8?B?WkpZeGlWVGJ0QzRwcDlKdDk4bWNkZ2JySkNHN2U5Q25hbXI1bTFjMTJabnBN?=
 =?utf-8?B?c3pkdVhIWnRTTG5scHRCcFdzYkNZUHltZFJ3TzNMdFU1blM2MXJmemg5Y0JG?=
 =?utf-8?B?UnVkaWJIcFJxaVB1bkZFNzZpb2d1N1RiYllZRVlxZzk4QitDRlU4SmpaN0o1?=
 =?utf-8?B?blFWcmVQTEpCdWVkaVh1QU1ISzUwRXdnOUZxV2ZDaUVNbVF5MHc4Wk1nOWxu?=
 =?utf-8?B?MzJhbXN6QVdhYU9rTXNQU3dMNlRnNUExKy80dXZzWEt2RG1FOXU3ZUpDSTF4?=
 =?utf-8?B?UHRnZW9xNkczeEhNM2c5Zm9BTlFZVHNRRy9QeExJd2NteW9LK0ZpbWt0Y0JP?=
 =?utf-8?B?b0RIYlBOaDZpNmhUL3RlRHpEQjdkQ20yYmhuNjRqRkVhM00zSnlnVVF4c2RH?=
 =?utf-8?B?YlNrUXVEbi9BcXR1Y3lOV3JMdVlVTEdyWW9OV0ZzeFVyM05hcW44Tnl6N3k1?=
 =?utf-8?B?T28zVm84bmZyYTFLTmlaUlU2UmJlSGVTOGQ2VkhXT0ZzY0VYN21pbmNrc0Fp?=
 =?utf-8?B?V3BMYTZNYXJscXlUT2k3a2E1cCtXNytmWGxWOWM0YkhXK0l0QktBRm5tZzlY?=
 =?utf-8?B?dUd0a2h1b1pTajU5cFl5aHFtNEV4bUdqVm5xdllSWTR4cDBwZTZQMlBpR2V4?=
 =?utf-8?B?djJoMSs3Z0NxNlY5dE5xbkNvRmFHRk03WU1JOVh6S3BXZUYzbkdYejRFdVhO?=
 =?utf-8?B?OEJhQlJQM0RKQ3lrYVd4U2xJOTE2NlN6L1UrZmZvb2FwSmttVjFhL3g2VUlO?=
 =?utf-8?B?b0plSithVEhBWjZNc2xWU2xrWFBzMzcrUjZHY0hPdDBFbEsrREkxOXA0TFl5?=
 =?utf-8?B?YjVxVXRlSjM5Z3ozTkwxNGNRVTk0S3JtL1JsMXNBb25HWUNzMkJzY2czZTRW?=
 =?utf-8?B?dWRPU0JUYjRobmNDUVdQVXFSalI1Q0ZzdlBMQmpuNG5KSER6eWFwUTVTVThk?=
 =?utf-8?B?c2gvNFZtZjhveEF3MWxjU2tRK01rbm1MV1JYSVlCZVBodVFuTkFqaU1ia2Ex?=
 =?utf-8?B?QlBnUkVZQVBpVERTbGtHc2Q3L254V2lhM1RIcU9qaE9rMHo1ak5rOFpHVUNt?=
 =?utf-8?B?QWtySklxcWtWSUQ4TlozM25DQVFFVUNWdHFNTmU4Qy9mREZjRUNDT2VPYWZK?=
 =?utf-8?B?MVpBOHpybDhzWTNvdWV6bVhNMzNwK1lGMm01MEtzUndGMEdIamNLdmdQQlVa?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26E68EFE2A76C444BD22232389DB0133@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536ee331-95aa-4efb-d5c2-08dc34510482
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:22:55.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYagIiIGTe7BOk6OAJH7hxEsWhGhxCNSFaM0iTxz6/InGz+VmIQPhFVuF/1WeqAC6oVw5VPYnPhHW562CKqezB5l9jIEQUx+Io22AyPBXfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDE4OjAxICswMjAwLCBJbHBvIErDpHJ2aW5lbiB3cm90ZToK
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIFRodSwgMjIgRmVi
IDIwMjQsIFJlbmdhcmFqYW4gUyB3cm90ZToKPiAKPiA+IFVwZGF0ZWQgdGhlIFRYIEJ1cnN0IGlt
cGxlbWVudGF0aW9uIGJ5IGNoYW5naW5nIHRoZSBjaXJjdWxhciBidWZmZXIKPiA+IHByb2Nlc3Np
bmcgd2l0aCB0aGUgcHJlLWV4aXN0aW5nIEFQSXMgaW4ga2VybmVsLiBBbHNvIHVwZGF0ZWQKPiA+
IGNvbmRpdGlvbmFsCj4gPiBzdGF0ZW1lbnRzIGFuZCBhbGlnbm1lbnQgaXNzdWVzIGZvciBiZXR0
ZXIgcmVhZGFiaWxpdHkuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFJlbmdhcmFqYW4gUyA8cmVu
Z2FyYWphbi5zQG1pY3JvY2hpcC5jb20+Cj4gPiAtLS0KPiAKPiA+IEBAIC00MzQsMTYgKzQzNSw3
IEBAIHN0YXRpYyB2b2lkIHBjaTF4eHh4X3R4X2J1cnN0KHN0cnVjdCB1YXJ0X3BvcnQKPiA+ICpw
b3J0LCB1MzIgdWFydF9zdGF0dXMpCj4gPiAKPiA+IMKgwqDCoMKgwqAgeG1pdCA9ICZwb3J0LT5z
dGF0ZS0+eG1pdDsKPiA+IAo+ID4gLcKgwqDCoMKgIGlmIChwb3J0LT54X2NoYXIpIHsKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGViKHBvcnQtPnhfY2hhciwgcG9ydC0+bWVtYmFz
ZSArIFVBUlRfVFgpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0LT5pY291bnQu
dHgrKzsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+eF9jaGFyID0gMDsKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gLcKgwqDCoMKgIH0KPiA+IC0K
PiA+IC3CoMKgwqDCoCBpZiAoKHVhcnRfdHhfc3RvcHBlZChwb3J0KSkgfHwgKHVhcnRfY2lyY19l
bXB0eSh4bWl0KSkpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+b3BzLT5z
dG9wX3R4KHBvcnQpOwo+ID4gLcKgwqDCoMKgIH0gZWxzZSB7Cj4gPiArwqDCoMKgwqAgaWYgKCEo
cG9ydC0+eF9jaGFyKSkgewo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YV9lbXB0
eV9jb3VudCA9IChwY2kxeHh4eF9yZWFkX2J1cnN0X3N0YXR1cyhwb3J0KQo+ID4gJgo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFVBUlRfQlNUX1NUQVRfVFhfQ09VTlRfTUFTSykgPj4KPiA+IDg7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkbyB7Cj4gPiBAQCAtNDUzLDE1ICs0NDUsMjIgQEAgc3RhdGlj
IHZvaWQgcGNpMXh4eHhfdHhfYnVyc3Qoc3RydWN0Cj4gPiB1YXJ0X3BvcnQgKnBvcnQsIHUzMiB1
YXJ0X3N0YXR1cykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Cj4gPiAmZGF0YV9lbXB0eV9jb3VudCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgCj4gPiAmdmFsaWRfYnl0ZV9jb3VudCk7Cj4gPiAKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQtPmljb3VudC50eCsrOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh1YXJ0X2NpcmNfZW1w
dHkoeG1pdCkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSB3
aGlsZSAoZGF0YV9lbXB0eV9jb3VudCAmJiB2YWxpZF9ieXRlX2NvdW50KTsKPiA+ICvCoMKgwqDC
oCB9IGVsc2Ugewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZWIocG9ydC0+eF9j
aGFyLCBwb3J0LT5tZW1iYXNlICsgVUFSVF9UWCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBvcnQtPmljb3VudC50eCsrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0
LT54X2NoYXIgPSAwOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gCj4g
V2h5IHlvdSBtYWRlIHRoaXMgcmVvcmdhbml6YXRpb24gZm9yIHhfY2hhciBoYW5kbGluZz8/IEl0
IHNlZW1zCj4gZW50aXJlbHkgd3JvbmcgdGhpbmcgdG8gZG8sIHhfY2hhciBzaG91bGQgaGF2ZSBw
cmVjZW5kZW5jZSBvdmVyCj4gc2VuZGluZyBub3JtYWwgY2hhcnMuCj4gCj4gVGhpcyBwYXRjaCB3
b3VsZCBoYXZlIGJlZW4gc29tZSBtdWNoIHNpbXBsZXIgdG8gcmV2aWV3IGlmIGl0IHdvdWxkCj4g
aGF2ZQo+IG5vdCBhdHRlbXB0ZWQgdG8gbiB0aGluZ3MgaW4gb25lIGdvLCBwbGVhc2UgdHJ5IHRv
IHNwbGl0IGludG8KPiBzZW5zaWJsZQo+IGNoYW5nZXMuCj4gCgpIaSwgVGhhbmtzIGZvciByZXZp
ZXdpbmcgdGhlIHBhdGNoLiBXaWxsIGFkZHJlc3MgdGhlIGNvbW1lbnRzIGFuZCBzaGFyZQp0aGUg
dXBkYXRlZCBwYXRjaCBzaG9ydGx5LgoKPiAKPiAtLQo+IMKgaS4KPiAKCg==

