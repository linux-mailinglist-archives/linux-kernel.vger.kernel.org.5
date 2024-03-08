Return-Path: <linux-kernel+bounces-96697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0197387602B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A6284C97
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66722F19;
	Fri,  8 Mar 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zMpw0c7m";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NQYyj71I"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FB210E7;
	Fri,  8 Mar 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887880; cv=fail; b=EEuIwHFHaB4Icl7FSsT3Ud7w8IHtz5xrd33AAeirUHVlkGEW51C8aDrxCKVDFn78Ekorqmr1xwKAnF4CtQEvAAc6E5HpOhKLrym2yjw5XQbJr5jh6pCwi/jf7+KDiLoro9DMI7fIPqdDDyFZlaXm+iBZHqGwIjJWidsSlambRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887880; c=relaxed/simple;
	bh=Q0vxSJidsLU7QrKv8KswXHeLBnH68SHh0mNavKDOBKo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=opniGf4u7yK4GSr0N599uZsWK/jZayUUQ6+bAKNt/P2CE+jZH1hHhWom6BiEerGGra4Wzgenf09M5aE6pj+iONASiiclxa9N6ptbI2xaJt90o9vQkytdnbcMEPxdZF2o+P3BqY7g+LKUNt712PeTmFMDyL1/+TD6R+O9QZ+Hk40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zMpw0c7m; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NQYyj71I; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709887878; x=1741423878;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Q0vxSJidsLU7QrKv8KswXHeLBnH68SHh0mNavKDOBKo=;
  b=zMpw0c7mCidf3KUaziIZL0BXRn6SPe7fH5Ijo7S8lIBh6AAKa852FO0q
   PRmKtr6XsVurbyttOvKRQzhJjZWtmpFZSGup/2e1Cu3ZWTXO1Ie1cW2l7
   zohM6frLUOx62xmazLoTaC2KSP6KU2DNqc7dWUqEXc8FqiBaPmePk+JGL
   gzWbQGPilK974CSPZAFZT5S0Svp0e3rsRI88dYFDPn8jNOi37EGciQZhP
   Mk+UmYsM9HYJYPh7V2Eqgo1AHTrP/2/q1x6Hs1/IIRl6BG673XH8PcO/5
   1I3KQZGbvG10rOx74wGXG5+DryFgcCd8ZdXomneF2jWyqJGzQxPJ73RQ7
   Q==;
X-CSE-ConnectionGUID: 6Y7IRf7nT2yhgiGn/H1Wlg==
X-CSE-MsgGUID: vCzIFCcLSN2ET6Ad+uR4dw==
X-IronPort-AV: E=Sophos;i="6.07,109,1708412400"; 
   d="scan'208";a="248159251"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2024 01:51:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 01:50:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 01:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx52qGHFj0p0qO0/db+iSkED5RH7r+Vh4HItH2dCIEZkrj5sXjJUv+0qgcknWeow4Beo9rynfh0CkaAEZy3yR4Ob0+AmJbYXo2osZtPbAfKpsEkxs5d0gaadEaQq4M5OCPJumKtyuDtMyPTfvaxLb+oI//+KFOpQM9j6QPFZnjClKiViX2E/hn53DE3s8Qt74x9YLwr3rfMKlO+Ck3UBiOLtD6FTD0s5Numi2sQVpq4GAFACY2xeOIIkGItndurHRtbutWLfgye89714XT3VU8284Wpd5wqgPItUJL2+Nzf5ACFlz2fSK0tEwCVAqr8tjNwl9OX+wwvcSJCOX5bkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0vxSJidsLU7QrKv8KswXHeLBnH68SHh0mNavKDOBKo=;
 b=k9O77LMXkBdz5K5g7H9u/zZiJKptmL9e7Xr5+yoDeBXfctlwwQa3X17xZZ3FBn9UoVDWELoUwuLU5civHbpG9+SR5QwaLiApBi/scSfW8lJXIByYnS4QSOdgnMQGymPwf9hbaeXlNpj1FZsRB1Sis9ltEskruMhkgMK/Nc3Dvw8SYRyOcwRYnOXj9yndVFe2jx9eXZXMqKutZldn6XCXXJFt4b1euTD/It3M3iSr0p0z0YBmVWQYmeWhzsWoW5uDIg5QlfXe6UlzId/xItyrt17wMeM5HG75CD46JaSuefbqARKZ4DGKh3B7ZESa9nSJ8qteYi8b65YO8WYGvnhikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0vxSJidsLU7QrKv8KswXHeLBnH68SHh0mNavKDOBKo=;
 b=NQYyj71IdadWNVLxZzH8gc6lJNoBrMpXZ5bz4c4M4gen7z8I1WhysA0fXhRhU3e2Vj++6hOqvI3gzHB22oDNdCB5OnYLtDROxeDGijSVbZwY5nTA/CXifYyjJnO8LOAaos4/CU6YPqzG+6tKesAU+DWKCSaxkhEkZ87rh1GBQKsdNbMCyKlU2yd3HJUgo5w6euT2txkhy5Hq5N0ZIyDZDQGdbBECf9Z9Wd3aYziGIu9BO9bxf7qyKrtK3I9pbpVtUslDRqqeYYJSdQ7XEG56+XI88C7fEgY6W8Qa7h3QMoaBwz+zXdDFAU0nKTbHJWO4SgxQ0RNjkIGKOdt82qkMVQ==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Fri, 8 Mar
 2024 08:50:43 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433%4]) with mapi id 15.20.7386.009; Fri, 8 Mar 2024
 08:50:43 +0000
From: <Varshini.Rajendran@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<tglx@linutronix.de>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <andre.przywara@arm.com>, <mani@kernel.org>,
	<shawnguo@kernel.org>, <Durai.ManickamKR@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 29/39] irqchip/atmel-aic5: Add support to get nirqs
 from DT for sam9x60 & sam9x7
Thread-Topic: [PATCH v4 29/39] irqchip/atmel-aic5: Add support to get nirqs
 from DT for sam9x60 & sam9x7
Thread-Index: AQHaZn3lLFE5+OUN/UmzjmxjtudQILEl/b+AgAegrYA=
Date: Fri, 8 Mar 2024 08:50:43 +0000
Message-ID: <ba7a59ae-d377-4514-89e7-86991420507c@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172905.673053-1-varshini.rajendran@microchip.com>
 <f1f9c53f-b11a-4fe1-9541-356ea75e883c@tuxon.dev>
In-Reply-To: <f1f9c53f-b11a-4fe1-9541-356ea75e883c@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|LV8PR11MB8557:EE_
x-ms-office365-filtering-correlation-id: 4bf9f764-ae14-48fb-377d-08dc3f4cd705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBLxCS4mxOWzUiqDIcuyT3RQz3wJaE0p4+H8diGSdukjC+VbRtrL1X/P+1Z/07L64L8J+pUnzFfw/MrCml5xHgrm1Huf9G5gFL5X40pZp0ZDiNt6GqtlmdKPHP3wxCQkrl2ozjL8jAjpPxX5FmYGzArV39z20GC6hYbyx9MiLoAc4K0+e84uowhxWe0r65hizsrZhDj4WjTZhm9apRa1uOWzrCQbeiZ+UjhM2v82iDMipLGK99FSRAPNknJFiefJKO/Y7TKYcW5TwgNvMNuam7Sa1tajL0bNyeND/zWKSpBBFS6sivb2DAJ49x9toD4OnWx69dVgIPoAeXW+ERt/1n/bIhTzTOU/TQ2AegNlHksdlP/NL4A5FXX+rla3EfaqTx4XotNEgnYCkiJhlWqm2HKNtkZvLU58f1HHVH+SP8OyUFHAZNZejKFnFBiN67MgWoxMhOBdUVYBupOeQ5DNLda2C6xZMlsioTHBcAaaadYzWw4GK09cCUMjnpBQ2lmYoN6oMhFQ92rIGpeOPlJDQ22TdG9GXEi4Y2AivkSE4+cTDsRexIl+eHfGR5U8gNRRq6ac4Ga8puCk/pVBQLoAX/rQZs0fumRBWEqHoquy4oJnwTYmp85A0rxLsPX8ozQvLuZxhfM+d+6KQFiQCMqJhV+vemz9A59M43wOkUMtDeLrE+WrGBqfCWJzsncWdOvr+disNgu/jVPh8VTifufUj+X8ZMx8Zx8awc9sx0Wud0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkZxRUl5SXVwL3dJa1pockFMN2MwcmJzVFZTYkp0KzJ3MjIwRi9ZbDY3WUtj?=
 =?utf-8?B?VmRDalpWeVlBNzFmNXcvWnFnSnlUYlFEd2lRa0hzR01zU3ZMdkw5a24xZTBJ?=
 =?utf-8?B?V2ZBSlZhVUtZL0dQYXR3ekZOcEN2dnNEUmdSMm1TZ29uRUxtWnh0TlB3UjNz?=
 =?utf-8?B?dWdZSzlWaXNGMjVndElWZWQ1MW9GVkhVaGpkbUxJbmVRWUwvcCtZSFVkQWZD?=
 =?utf-8?B?S29CNE1zRm1yNGVDdVlld0IrTkx3RlVKbWt0bkdMTWFwbis2Vk5LS1hNZUJo?=
 =?utf-8?B?a3FyTTBiUEpFeFoxblEydjZlRnEyaHkwdjJxVkdMakJINHVLUzN1UVNoYjhQ?=
 =?utf-8?B?clpaSWFBVGFJUkorQjZSSjdBOHhvUmlZSk9CMWNVVmRmSzR5N2NnelJxVVRV?=
 =?utf-8?B?K3MzQnp5bjJCRkxFamVyWEZraGJFaDlzY0RRWVVHU05uV3FKSGVFZUdyc3pJ?=
 =?utf-8?B?MFZHajFDYm4yTXVuYnFaUjhmL0s1NmQwSHlyeVp2bHU5SkhnSEVtN3dZU2N2?=
 =?utf-8?B?NHVxQWx3Y2ZPRUk0UXRNQ2dKUDQ3WXVYZmw0UW1aMHVpc2x0bnE5VVU1aHo2?=
 =?utf-8?B?UDFRNENENjNOVnVNTzhGenFQem41WUhDZUFMV1BnRFprcElldTQvMVFvRmtB?=
 =?utf-8?B?N0oxODF2cGVMUFpsbnh6L0o1bXp0NEI2czBQWEVmeElEZ0NZelphb1phblUz?=
 =?utf-8?B?MkVzYUF6N3BEakNkSmVzYVYxVUpyZ2h3ZmhJajV3aWplNUNCZ3Ryc2ZmQ0dG?=
 =?utf-8?B?b1hjdnEvOGxuUlE3VVJtQ0ZHeVI2MVo1UFQ3Vi9Ic05ZanduZ0Zqa3pTMTMx?=
 =?utf-8?B?enVPWi9rNnRSTFk1NEFPRlZWSWg5YmpwbDlaZno4d2NQMDBYYS8yTEQ0V2JO?=
 =?utf-8?B?VjhOc0R3bi9UNnlteHI3Z2N0V1owWjZzb1F3WlVsTGNBVDZ3NWFYUGc5WXN6?=
 =?utf-8?B?UjNZZVdGb2VEOTJVOWxkOTlmNmtHWjF5RjNwMUkvWnZXN0pOZGNuTDluNFAv?=
 =?utf-8?B?Z0NMUFZJYjlVc2hWbFZJSHprTDhsQzM1a0wzeTRqV1VJMHB3R2gvTWRmT0o0?=
 =?utf-8?B?bjRZVXdmTW1mMzRaVWlJVG4zNzdGRG8xQjFNOXpZckduTnBqU2lZMXk4ZmZL?=
 =?utf-8?B?dEZkcjJOZlBxNmhKZ3c2QnR5enZhY0lTdUJ4OG1wdmFPSUVLZ1k2Um1TSWs2?=
 =?utf-8?B?RG0vZVo5Sm82WElhZ0lGaXlQSHEwUUtldzUwMjhPMElxV3lYdExXTTNiaDJU?=
 =?utf-8?B?Ym1DVmUreEFXbWRXajBob1FwY3IwMlVPU2F1cnh2aGF2STZ5M3I1RmNSeC96?=
 =?utf-8?B?a1hUcnBjd1gxZFNXdmF3dCtMdVljZUhjZjNNOWlGREJHWmliYnBQclE2UURV?=
 =?utf-8?B?ZDBXdEx4ZnBHVWUyZEVVL2VleENXWEFtRDhML2pZTzI0SmFEZ2JlVldRYkli?=
 =?utf-8?B?QzRFd1Z2MFQ4ckwwbmNaZW5NSVFXS0wxY3hCZ2RUbElHRnBVRUtRNTVkSUVt?=
 =?utf-8?B?eGgzNmZtaVYrUXhERjZWVm1Dd2VVclo4VzFYVE1BK2pybzM2MFFNbGYxMEFv?=
 =?utf-8?B?WXh3ZjkxMzN4MnNNcVJTUi9kZVppNEl1MXFZNm1FMGNOeW9CYkFEOHBhejB2?=
 =?utf-8?B?aXRQbWtCSWIzZ2dXMys4UktySlpDdlhLQ2JSR3Z6aUlvc2VyUGhLWFc1L2Nm?=
 =?utf-8?B?aEJXRXpsTnR5SXYrRUxHOXp2amhZQnNaSE43L0FQRlkvZE5RYldVM0hmYllt?=
 =?utf-8?B?bStIeSsySGNQRlVXVWkzMC9ucGE4M01tQXdaWUlyRmZHOXVHUmMrUHJxcVU5?=
 =?utf-8?B?eExQa0xCdEdFSFJPZG9pN0ZnTFRsOWZScFg0dnNBME5yR1hvRHhFbjhJWjFo?=
 =?utf-8?B?cmxqQUtyY3RxNUdvcXlRZ3FJSndRZ0NtTVR5WG5jWFpFYURzbFk4NFdYL0ZE?=
 =?utf-8?B?OWhqd0g1RmJ1b003UXVQYTZhT09FZ003WlVDRmRHaU9VZFpyNTFqQk11NCtu?=
 =?utf-8?B?YzEwdlFVcGhJNnNLM09DZTMzdDVUL2ZTVmJRZE4yUEpQajRUdzgydVlJS2R3?=
 =?utf-8?B?VUdONG9qVWU4UnFibi9NWlloczVwMFFLclU5WUNIZkZHYlJ6TmcrN051cWow?=
 =?utf-8?B?NHhWY2NVVjFNREZpek5IbmJOTHVGOE1MalVHTjdma3dFSXZpVisydEUrYUFO?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC81E3992DC88A41BF7280D7656FD0B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf9f764-ae14-48fb-377d-08dc3f4cd705
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:50:43.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR/2XRpVOcXl2URnPWQGukJbXfcm+ZjCxnYXWO1HC7ULM5aqwRkwfMMvbY7ma2IjisdI3WAmfsiatLC/uHa+qt5L4WQsCGRxyCV6iDgmq8hn2naErfFCnDWyCjvGXFD9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557

T24gMDMvMDMvMjQgNTo1MSBwbSwgY2xhdWRpdSBiZXpuZWEgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjMuMDIuMjAyNCAxOToyOSwgVmFyc2hp
bmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgdG8gZ2V0IG51bWJlciBvZiBJUlFz
IGZyb20gdGhlIHJlc3BlY3RpdmUgRFQgbm9kZSBmb3Igc2FtOXg2MA0KPj4gYW5kIHNhbTl4NyBk
ZXZpY2VzLiBTaW5jZSBvbmx5IHRoaXMgZmFjdG9yIGRpZmZlcnMgYmV0d2VlbiB0aGUgdHdvIFNv
Q3MsDQo+PiB0aGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdGhlIHNhbWUuIEFkYXB0IHRoZSBz
YW05eDYwIGR0c2kNCj4+IGFjY29yZGluZ2x5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZhcnNo
aW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0N
Cj4+IENoYW5nZXMgaW4gdjQ6DQo+PiAtIENoYW5nZWQgdGhlIGltcGxlbWVudGF0aW9uIHRvIGZl
dGNoIHRoZSBOSVJRcyBmcm9tIERUIGFzIHBlciB0aGUNCj4+ICAgIGNvbW1lbnQgdG8gYXZvaWQg
aW50cm9kdWNpbmcgYSBuZXcgY29tcGF0aWJsZSB3aGVuIHRoaXMgaXMgdGhlIG9ubHkNCj4+ICAg
IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgU29DcyByZWxhdGVkIHRvIHRoaXMgSVAuDQo+PiAtLS0N
Cj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL3NhbTl4NjAuZHRzaSB8ICAxICsNCj4+
ICAgZHJpdmVycy9pcnFjaGlwL2lycS1hdG1lbC1haWM1LmMgICAgICAgICB8IDExICsrKysrKysr
LS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2FtOXg2
MC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbWljcm9jaGlwL3NhbTl4NjAuZHRzaQ0KPj4gaW5k
ZXggNzNkNTcwYTE3MjY5Li5lNDA1ZjY4YzlmNTQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9i
b290L2R0cy9taWNyb2NoaXAvc2FtOXg2MC5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9taWNyb2NoaXAvc2FtOXg2MC5kdHNpDQo+PiBAQCAtMTIwMSw2ICsxMjAxLDcgQEAgYWljOiBp
bnRlcnJ1cHQtY29udHJvbGxlckBmZmZmZjEwMCB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4ZmZmZmYxMDAgMHgxMDA+Ow0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGF0bWVsLGV4dGVybmFsLWlycXMgPSA8MzE+Ow0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWljcm9jaGlwLG5yLWlycXMgPSA8NTA+Ow0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPj4NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgZGJndTogc2Vy
aWFsQGZmZmZmMjAwIHsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWF0bWVs
LWFpYzUuYyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtYXRtZWwtYWljNS5jDQo+PiBpbmRleCAxNDU1
MzViZDc1NjAuLjVkOTZhZDg4NjBkMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9p
cnEtYXRtZWwtYWljNS5jDQo+PiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWF0bWVsLWFpYzUu
Yw0KPj4gQEAgLTM5OCwxMSArMzk4LDE2IEBAIHN0YXRpYyBpbnQgX19pbml0IHNhbWE1ZDRfYWlj
NV9vZl9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4+ICAgfQ0KPj4gICBJUlFDSElQ
X0RFQ0xBUkUoc2FtYTVkNF9haWM1LCAiYXRtZWwsc2FtYTVkNC1haWMiLCBzYW1hNWQ0X2FpYzVf
b2ZfaW5pdCk7DQo+Pg0KPj4gLSNkZWZpbmUgTlJfU0FNOVg2MF9JUlFTICAgICAgICAgICAgICA1
MA0KPj4gLQ0KPj4gICBzdGF0aWMgaW50IF9faW5pdCBzYW05eDYwX2FpYzVfb2ZfaW5pdChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50KQ0KPj4gICB7DQo+PiAtICAgICByZXR1
cm4gYWljNV9vZl9pbml0KG5vZGUsIHBhcmVudCwgTlJfU0FNOVg2MF9JUlFTKTsNCj4+ICsgICAg
IGludCByZXQsIG5yX2lycXM7DQo+PiArDQo+PiArICAgICByZXQgPSBvZl9wcm9wZXJ0eV9yZWFk
X3UzMihub2RlLCAibWljcm9jaGlwLG5yLWlycXMiLCAmbnJfaXJxcyk7DQo+PiArICAgICBpZiAo
cmV0KSB7DQo+PiArICAgICAgICAgICAgIHByX2VycigiTm90IGZvdW5kIG1pY3JvY2hpcCxuci1p
cnFzIHByb3BlcnR5XG4iKTsNCj4gDQo+IFRoaXMgYnJlYWtzIHRoZSBBQkkuIFlvdSBzaG91bGQg
ZW5zdXJlIG9sZCBkZXZpY2UgdHJlZXMgYXJlIHN0aWxsIHdvcmtpbmcNCj4gd2l0aCB0aGlzIHBh
dGNoLg0KDQpUaGUgb25seSBvbGRlciBkZXZpY2UgdGhhdCB1c2VzIHRoaXMgQVBJIGlzIHNhbTl4
NjAgYW5kIHRoZSBuZXdseSBhZGRlZCANCnNhbTl4Ny4gVGhpcyBjaGFuZ2UgaGFzIGJlZW4gdGVz
dGVkIHRvIGJlIHdvcmtpbmcgZmluZSBpbiBib3RoIHRoZSANCmRldmljZXMuIElmIHlvdSBzdGls
bCB3YW50IG1lIHRvIHVzZSB0aGUgbWFjcm9zIGFzIGEgZmFsbGJhY2sgaW4gdGhlIA0KZmFpbHVy
ZSBjYXNlIEkgY2FuIGRvIGl0LiBCdXQgdGhpcyBjaGFuZ2Ugd2FzIHByb3Bvc2VkIHRvIGF2b2lk
IGFkZGluZyANCm1hY3JvcyBpbiB0aGUgZmlyc3QgcGxhY2UuIEkgY2FuIHJlbW92ZSB0aGUgZXJy
b3IgY2hlY2sganVzdCBsaWtlIHRoZXkgDQpkbyB3aGlsZSBnZXR0aW5nIG90aGVyIGRldmljZSB0
cmVlIHByb3BlcnRpZXMuIE9yIGlmIHRoaXMgaXMganVzdCBhIA0KY29uY2VybiBvZiB0aGUgb2xk
IGRldmljZXMgd29ya2luZyB3aXRoIHRoZSBuZXcgY2hhbmdlLCB0aGVuIHNhbTl4NjAgDQp3b3Jr
cy4gUGxlYXNlIGxldCBtZSBrbm93IGhvdyB0byBwcm9jZWVkLg0KPiANCj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4+ICsgICAgIH0NCj4+ICsgICAgIHJldHVybiBhaWM1X29mX2luaXQo
bm9kZSwgcGFyZW50LCBucl9pcnFzKTsNCj4+ICAgfQ0KPj4gICBJUlFDSElQX0RFQ0xBUkUoc2Ft
OXg2MF9haWM1LCAibWljcm9jaGlwLHNhbTl4NjAtYWljIiwgc2FtOXg2MF9haWM1X29mX2luaXQp
Ow0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

