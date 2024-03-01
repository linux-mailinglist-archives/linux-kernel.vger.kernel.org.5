Return-Path: <linux-kernel+bounces-87858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8F286DA07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543BE1C21036
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24B46433;
	Fri,  1 Mar 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FXYku7/N";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ThByD8f1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C8845BE8;
	Fri,  1 Mar 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709263667; cv=fail; b=axL3n72juubRH+PP9Sg0WcOYCy4r12Jl51ZlIAklCBb002gd2yigCUM+CJAMSdomCbAihmkwxoa3gOSr06kAljt8lEZo7sGVvD3jMmnCdom6nSShyBjV50p/Y5xWDMwE4LWAxh/kbp8ZATXjVKg5QyV2jg8jieMz4PII2BXMMjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709263667; c=relaxed/simple;
	bh=RPDpS0vmFRmgQT0PowxFadzbDC3Q79Lfc5P328MtOeo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mbh5TK4+3oIsufrGAcaZbm0n0vTwobeRNYRCAjotn3ZgybHycndPeZp9E7eMBQvhkyahIz98ss40kFzUfNk1Tez/TVXs2lh3J/t30DXqpZRcPbHY39me+wFo4g2xookotYvSbCtRSPiht8n5Kww21RzJ7xgsR3ywJHedlp34rCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FXYku7/N; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ThByD8f1; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709263665; x=1740799665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RPDpS0vmFRmgQT0PowxFadzbDC3Q79Lfc5P328MtOeo=;
  b=FXYku7/NOMSwY/DNKYn9lsznFBO5ojVmYik5SY3YrlKVGLcyLh1pHjnF
   PLE/9iqJkAgdvL0IKBF8wAY0LzWLb8SIVpan9vBhxdAOlWoq9CPHH9tZ6
   yVsfr1NHl5A37ggGDsZoOf9n+gvaBY0tiewbzFtL1u205zq3Tkb5OLQFy
   5rRjOdUGXTmNA6xjk0VWJWc4/5lL1fz6TgqG5LCfxci2XXEFRmp1l5+rP
   /++pQul7sBHlWIU9GtJXCANxUie2dZdeoesIYq+p4tIL0KmV4xg0VDpGs
   YK5lapBkcPAxc0KZ5yix8oUJ4sSuJ4nHXgGxzMcy7OP2XzIPWxpCJRrvG
   Q==;
X-CSE-ConnectionGUID: zE8KjYedTDqlCHQY1aEO4Q==
X-CSE-MsgGUID: kpWbYrGcSC2hMyUv87TPBw==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="scan'208";a="17052463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 20:27:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 20:27:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 20:27:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjzOSyaPcu3DrdDGrzXWvsp40Ga1SRl4k/rQNSoXesje7ZJHEyXg9NQYBvfvfbtjkVAYbTP192sSf5cYOuFGZEw7NsoA9YlHsHU/R0gzEpot6+GhjfPPygWDvL7Lses5l0yl1/yNr4q5v+uANiTMv99WBFBc6lMVR/9XGYkJOHptiIkHSxrIIYS4qwdv/KDE31UJpTA+vaYl2s2ZHuE1weNlvAEgYD9WpML0w13hIyP6wpblr7waLniDAgeIRE0Us9Mrr8Dk7/nPDUxsh3uYjfpCJjx/J1CHMpM8Vk3oANE6RK51PBZz+HNPpQmhywYgx+HHIKs3WouM0f83bOysAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPDpS0vmFRmgQT0PowxFadzbDC3Q79Lfc5P328MtOeo=;
 b=g7qgM5WXsO3aeOrJ52xEY/PKpSZrWw9DCsIC4jkXccpMz8QHBVMKMqbo3D0sZtVXTnj1kFegesXAhFlwHvZkWw6SU3MDqaiM2MXDvSb5znhqD3w6dq4t0QhLsTcd+v0+yDIMKSsVDvIvYuygqTTL8hPP5J4u5E2N2iUm3bFZAGYzFklopCBzj1uYojZNFSjTTVlH53ye9rxiVVz6fytl9BxwoDvBKEBsLh4UKdWNcwrXXFM3Ko0Dzj8xMYnD4tpVUiRCvrH8jjFj9/hcJAFs+rrAkeqYhEX4+TFeURVOnQSl9x4Yuw0b0YxBU9oZkhc/8LsvcsXtUtyh4EnyJ7X92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPDpS0vmFRmgQT0PowxFadzbDC3Q79Lfc5P328MtOeo=;
 b=ThByD8f1XwQHJT4V3zbi/1I0bQH2rio7wGdSVmxUqwJuO1uv9ZsOCqshSb1v+07J2nBJyXerLriB/gM0Uv+Lx7elHhkJf4VnJxSFYM/CkkCAAJgTa33/5ubgcv1ixGWnf01uCIdi6SBAFPfViFoE6tadAMjY8OHr4Uez3xADtF/u134g7RCEHVQzHuPLrYoivPwj8/02//r3Pveq53IQ7CfH6aHzACzP2rR246GLZ6igGZFZrKrbyWG73mi1oD/+J33sDGN+8EFru4aQgPT19bnJEnWQQIE2nC3uc3GNR9FqVUGaRKfBvjPPAn/nmR3xYy+QMBIjKHNeaYFnv30nWg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 03:27:32 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 03:27:32 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <linux@armlinux.org.uk>, <hkallweit1@gmail.com>,
	<wojciech.drewek@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <Horatiu.Vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Thread-Topic: [PATCH net-next v2 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Thread-Index: AQHaa0jf1YphDJ8VxU2wvTDgiUxtHLEiOoiA
Date: Fri, 1 Mar 2024 03:27:32 +0000
Message-ID: <80bea3ec2ec86d2e75002f849da174f50e0b846b.camel@microchip.com>
References: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
	 <20240229195220.2673049-3-horatiu.vultur@microchip.com>
In-Reply-To: <20240229195220.2673049-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH7PR11MB6524:EE_
x-ms-office365-filtering-correlation-id: 304c07f7-d8cf-4c4a-e7d9-08dc399f87f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWSxfWdB9r/MIUjO/fgyDhNV83oWMbsLmPMHJm/N3u/7FsEN/cwZEZNsWQXQLTMVumC04eGjREUMC8cpimDPOSuo20ap8A+gu1th/OSczy7jzX92UvrPzvg6I1tlq8/0ePT7R1+9fVL1XsHfVxmn2u3WGmEnTBN0TFgATmPTqrQY4QgMG5b/bAWI9SoOLqNIjmTZD5SlSmVk2JNVNQdf4RPLnuEe2GuwiXMW+NQwDeRLdCBUIEdWP+ZI9BuGNsNzz1yh3HgY9Ok2LegqV7GbmYl6KRYgoDBoCPa/szxSjGovXc6k20EGEKsqXzNVjqp6jgHY3k35bYlLMXEC3WnrhS2GwkV75WTWT5HLI+V+aQ6zTLmhRI50up4rUuubtDNgYilFCjBJMWNm0/CNBg53HShodIvWpu+/3Q+ENLRQtk+RQpeNb6EB+PXtnLi6N3WwWg6kC76Z130MfB5Rq6txv6d7gS1tPxiFaZXOkWw+VXoExS+Yp+sUrNXzTRQMZqyPLEcc55U2Ymh3a3S8lcD/0seN11261SIZwDAbcVL5IqPZLMkaGAaTTCRIO3+IyIxMZEFzDmlreJ8l5O91ELjHauzt3B//LluX8pe7Vh/pnl/Mo92Lhk6q9CAwVRocIxQ2n31WgrPB9DzUG6PiJIVlBgaO9NsF/yx4gEh/Taqq4N2PFcX1zl8PPlCpp3HjIFfbJEBTYvhnmr9GfpQ+7XVehOQhrveQdKySa3NKAZU5oko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHJrTnhTcmdrT2IwNmxTMnV5YkhSeVdBcyt3WFp3R05FUitranNtb1lBbjJW?=
 =?utf-8?B?THhENzg5dS9xVzFzM0RLMHp0Y0hJUmNUNUZqeTNiV3doNDRyeE8yUEdjbjJZ?=
 =?utf-8?B?V0d1RHhON3R5WlJZeGRyTkdVMXZIemZjUVFvNm9XN2o0bklLandwWitQWDFH?=
 =?utf-8?B?eFB6d3pMcVRDUVo2K1diL0JLQjZDaU1lRjJFVmJuZEpzMk1lZmEzOHY5R2Vw?=
 =?utf-8?B?YkJhVlhITGJPMWhPV1pKQ1JkdGpibFlNTnUrd1p4OExZdXJUQ25vb1d4bVNK?=
 =?utf-8?B?UWo4Zm9PVkRQamJKN2RwWVFPSWJ0N1JIM3h6MFovbVI0TE1MNFV2elpOc2p2?=
 =?utf-8?B?UDE5MXBHS0FDOURnaWJNRlpKT3BiK0o2MUltYk1QQjA3ZzgzMmZmTVlucFlk?=
 =?utf-8?B?ZmZiNm5HZWRBNENpejZ3STNHdUNBeHJhMUs2TWV5cDdLSjEyYUErMmRham5p?=
 =?utf-8?B?enM4bEVBWEVGdk0wcW0vRkJ6VUNOM0VZRXVWSmdkaDcxaFU4d2w2YlE3M29E?=
 =?utf-8?B?MTU3S3ordkpJSDV0bU5taTQyblhVZVpFUnEwYUc5bUx3aXI2VmhaL0RxdnpO?=
 =?utf-8?B?aDdOekgrREo3ZUMvM0VwQmVYRUhuRVk4QjdKVER0YWFIb2oxcDRVcmszcWlO?=
 =?utf-8?B?dFNWQWVlNVlaVkNKbXYyVFJvdzNXNzNaNnNQM2E3MStXQ3VPd1p3YUFLK2tR?=
 =?utf-8?B?RXBoSm1RczdZd1U1c3cremZRYXVIZ2cwdkFVVjIydzRCNjRpalJ0KzVBUC84?=
 =?utf-8?B?bWZsbzlzTmgzSlhrTkM2VXFCUUlBQm1uOHBQeXNrdkZ0cmhyQ2VHSllrTEk2?=
 =?utf-8?B?ZktyQk1wTG4yTitNZmtWMCtVblhyN0RFdFFab3VLdEVjVXFOdVU5QXpvMXFY?=
 =?utf-8?B?NzM4MGx4NVdBVGduQ29EYnBoWDRNc2JubHNlSlNYT3ltZitXWnBZSGRhOENR?=
 =?utf-8?B?WDdxUlBUcXFwaHFodlNEaWk2N1dVK0dzcU5oek1NenYzczRnTkVkTUlhYVpL?=
 =?utf-8?B?UU9jYTl3WnRlT1V2cTlpbWs5QjVsamhSTzB0ZG5KNlR4eHozVmVZdmNGUWFC?=
 =?utf-8?B?alhHcFU2TVdzdjBpODd4ZnZ6cFZZWCtBaHpXZWFaakpxWGw4ZVJyVjQ4WE91?=
 =?utf-8?B?eG0vM2FMMDkwRmxnbnZpb2NpTzZ4YnRrNlE3M1JXY2ROTDhIT0pRZDU3Vmdv?=
 =?utf-8?B?UGJjaDk0ZjZNQzhDR1BudGh6d29QR2Vwejh2NHlyUm1DczByYnlBOWJrTkdS?=
 =?utf-8?B?eS82L25VTDU2Sm1YbVp3b3V6NFRPdTlPQmNzUmJ5aFR0bGR4eDY3SWs1K1Y2?=
 =?utf-8?B?WVg2YzNhWDI2VUlUQTUvTHUyakdFWTNtZkJTZ2FmWEZMZXFrTjJRYXBkM0Nh?=
 =?utf-8?B?dFhsaVZRREt6WVMwN0VxYWFTZmllUG9ub0pCdmJpUjNmczZmKzM3VFpHbWtq?=
 =?utf-8?B?S2I4UmxtUGkyektMN2pXYm9LQTM3amxOQlRXVzlYelRIbzVkY0kvN3o4M3lT?=
 =?utf-8?B?WmxSa1o1MTdtbjh3eFlBekYwUUJwZlR1bjdReDBNc0UrVVpxNndwUmU0NmlQ?=
 =?utf-8?B?cVJmT2FVMDcvTzFNSTFwTER4bktSejAxUFdYOS9EMWxHWHh0MFhZUGdCbVNJ?=
 =?utf-8?B?MzFzdzlwQUdhSFZpNXIyUER0bC8yNWpCRTkrZjYrSnJDWGd4MmNid1pNcktK?=
 =?utf-8?B?c1NwK09sMGNubEFJNXg0eHZCa2lwcTMvdnYrc3FKSVp2Skx6aEZJU1BWVDdm?=
 =?utf-8?B?a2syb1Eyd3NiZTZTUHladldBb0hIdk5id21BR1VyY0ZGcW8vNjduYmU0Wkc0?=
 =?utf-8?B?MUE0ZHB1dmF5a1FCSlcvTlQ2U09MeTBxRHdsL0IrUTJndUk4d0llNDBDeWoz?=
 =?utf-8?B?ZlRwTStRWmFqUnVTVm55YVB5elZQTVBhaWRYL2RLdTI0akh2d1ZPRWszWURN?=
 =?utf-8?B?a096RG9JV2x6RU1IaWhEWHFtTDRmdW1YOWp3cDV6MWhvWUN2NXA0MGJwQ0R4?=
 =?utf-8?B?YTJGc3hORy9FcXVtWm03TDlXWGcxZko1WmRlNkxxSjZkbnlncFlpM2s3TFlH?=
 =?utf-8?B?anI2M2FwVFJ4SFZ1emdXdWlZeXlnTy9EL2tERU5uelVzQ0d3aFNCOFRLYVBv?=
 =?utf-8?B?eU5OV3JsUlNBWDlxVWQ2QjNSRldIVE5wV0U5TTk2N1VxQ0pmazkwZk5jNVlr?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44E654AD68B96D4AAF8E1AB8E094FFD9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304c07f7-d8cf-4c4a-e7d9-08dc399f87f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 03:27:32.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dul8vprIPF3eqXl0Mrm5p5J4MODQFi2GKP82o5Ide5hh09mAdiIFznWwoR/4uB/bzUU0VDXTx+6uP/tZOsBqn5L4LIX1OBzH9C6I6K/V9Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524

SGkgSG9yYXRpdSwNCg0KT24gVGh1LCAyMDI0LTAyLTI5IGF0IDIwOjUyICswMTAwLCBIb3JhdGl1
IFZ1bHR1ciB3cm90ZToNCj4gV2hlbiB0aGUgbGVuZ3RoIG9mIHRoZSBjYWJsZSBpcyBtb3JlIHRo
YW4gMTAwbSBhbmQgdGhlIGxhbjg4MTQgaXMNCj4gY29uZmlndXJlZCB0byBydW4gaW4gMTAwMEJh
c2UtVCBTbGF2ZSB0aGVuIHRoZSByZWdpc3RlciBvZiB0aGUgZGV2aWNlDQo+IG5lZWRzIHRvIGJl
IG9wdGltaXplZC4NCj4gDQo+IFdvcmthcm91bmQgdGhpcyBieSBzZXR0aW5nIHRoZSBtZWFzdXJl
IHRpbWUgdG8gYSB2YWx1ZSBvZiAweGIuIFRoaXMNCj4gdmFsdWUgY2FuIGJlIHNldCByZWdhcmRs
ZXNzIG9mIHRoZSBjb25maWd1cmF0aW9uLg0KPiANCj4gVGhpcyBpc3N1ZSBpcyBkZXNjcmliZWQg
aW4gJ0xBTjg4MTQgU2lsaWNvbiBFcnJhdGEgYW5kIERhdGEgU2hlZXQNCj4gQ2xhcmlmaWNhdGlv
bicgYW5kIGFjY29yZGluZyB0byB0aGF0LCB0aGlzIHdpbGwgbm90IGJlIGNvcnJlY3RlZCBpbiBh
DQo+IGZ1dHVyZSBzaWxpY29uIHJldmlzaW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRp
dSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9uZXQvcGh5L21pY3JlbC5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9w
aHkvbWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCj4gaW5kZXggODhjYzAzOTgy
YmI3OC4uNzg4ZmRkNTRmZDIyZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21pY3Jl
bC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KPiBAQCAtMTE3LDYgKzExNywx
MCBAQA0KPiAgI2RlZmluZSBMQU44ODE0X0VFRV9TVEFURQkJCTB4MzgNCj4gICNkZWZpbmUgTEFO
ODgxNF9FRUVfU1RBVEVfTUFTSzJQNVAJCUJJVCgxMCkNCj4gIA0KPiArI2RlZmluZSBMQU44ODE0
X1BEX0NPTlRST0xTCQkJMHg5ZA0KPiArI2RlZmluZSBMQU44ODE0X1BEX0NPTlRST0xTX1BEX01F
QVNfVElNRV9NQVNLXwlHRU5NQVNLKDMsIDApDQo+ICsjZGVmaW5lIExBTjg4MTRfUERfQ09OVFJP
TFNfUERfTUVBU19USU1FX1ZBTF8JMHhiDQoNCm5pdHBpY2s6IFRJTUVfVkFMIG1hY3JvIGlzIHZl
cnkgZ2VuZXJpYyBpZiBpdCBjYW4gZW5kIHdpdGggc3BlY2lmaWMNCmxpa2UgVElNRV9WQUxfMTAw
TSBvciBzb21ldGhpbmcgc2ltaWxhciB3aWxsIGdpdmVzIG1vcmUgcmVhZGFiaWxpdHkuDQoNCj4g
Kw0KPiANCg==

