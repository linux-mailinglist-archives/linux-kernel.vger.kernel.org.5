Return-Path: <linux-kernel+bounces-62928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3408527F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC95B2425B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133AAD49;
	Tue, 13 Feb 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ES/60jxy";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AGsnBeGZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F3A923;
	Tue, 13 Feb 2024 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707798226; cv=fail; b=B5zrakZYqoUa+nEay141UtUJ7YWqfHjrrlL0uh7u+3860L2wSTFroLUwpMf2izAYjATw2FyXjgkhHkgAWxHkByxAfBhwLK+rv2WN0+n2NGfaTHkVj+3vKkKXpzuv59fFG7j64k8l4HDVKwNbBsG9/ij3pvF3JyZ9YoEVkQUyc1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707798226; c=relaxed/simple;
	bh=rHwHQZhKUqw1ZyUDxQrBF2fxis04w8scW/QPb/+tb7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XHUGCmsO+btyq8sRd4azyqzjH8ffp3CHcO6Q1/RGdwxS1yM6455OMrKpAJJAwkOdbhMvpjmh/QOINp93NhUjLpV3h3l+kbtJq59pPNPBIlvBLYFY3ACQsilEGQNjpK34y0EX9qTbm5Rx3gGXvf3ZLnsQuNK0xbpcjFID6/StCTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ES/60jxy; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AGsnBeGZ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707798223; x=1739334223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rHwHQZhKUqw1ZyUDxQrBF2fxis04w8scW/QPb/+tb7g=;
  b=ES/60jxy1bOq9hMrux4Ubdo87vCsR/x3z1upMCG4i6EZTsUCc77gektp
   uohlI6kENc3jk5pB8Muji95btuI+RYWVTL7mgzakY6eYVzVO/TmIQK/mo
   tlwA1iyfzB/7hTfzWWUbsYCzoY84vTNZMz8Fzo1W5djSozzW3x93QcKtZ
   vP88pf9I5vLv2jbQpcAOZxKJ0d1wwsa3557UJt+SkgHToU8pObFaUZOzw
   pqcVxbuwQZ7vgaAnlyaf+z3gpZF9vRxVlQq3qjI0DyOChKfSSv8BoRg0e
   rDVEDVeH0OedapVjsZB/JypFEFBvL8r4rss+hedTi+z/3DZ80GWGkwQlH
   Q==;
X-CSE-ConnectionGUID: GrbPa3QvTLeQt9e+1KO4UQ==
X-CSE-MsgGUID: jYUkvFAyTCW7clp9xJYgmQ==
X-IronPort-AV: E=Sophos;i="6.06,156,1705388400"; 
   d="scan'208";a="183413720"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2024 21:23:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 21:23:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 21:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbG7YwI75YNgKph9PuugHxLBUURiUjWO6bRdV3EJk18YBpsfWJsWyG58xN/Lr2SADOi7oLUyMHNpXFDWCnssl3ahXN5COk/hrGEat5voU71zVOygMWpa3fgQYUivWcm194tznLyILCC+bUd5uDgaK3KMCXvrZZY5UNNnu8CBCCuqieVViYsGwAGycsntCZxE6nirtY97M1NSx/RKwu5jY+883Aj9EQ9dBVZEExfnkgoLuFFAZTbgyFEmCVwRJpbHs+zKLLq3PQiwVv6C3NYJeyY8mcOGvX+wFwMCHRvkHcxYe6356xEZeAsie5YNssY5OPfkG73876p2SsXJpXIh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHwHQZhKUqw1ZyUDxQrBF2fxis04w8scW/QPb/+tb7g=;
 b=og0DHx3gIUxIzjORbbsMpApcbZwpjjdlPmbb5rABzDggGIXofMo6gsdVFL+NLIGrsj4fk+nzHV65lj10H9PMeemgcPyF13oXw72bCN6KL3eN8hV5f6yL5QO5bS9Ej4YIPcM8OHEQVZLOonyXDjhHYCUF5GkhTqHXufL2FCiW4tfRNgsJTf8xTPXLTmIWMvverhNj/w3amvXaRzsiMDSETXkSmzxkm/VlSlgKHjQmP6C/o90Jm9XG4vo5LncPYWft7Ip8pvNrnWsZ9mBNNRipFlbh2WItRm090KoKVtsfCTq/hkXIoQrAxqcHtSVlPKvrm8v41NKlLy1/Ia18lwL1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHwHQZhKUqw1ZyUDxQrBF2fxis04w8scW/QPb/+tb7g=;
 b=AGsnBeGZe+n5uKuxkBEaTbR2rwOmd2F1cAkqTN7lFiQWBHId/JX5NvTIx6mLyCm0EKCBDNz1qfnf0xlvGlCfyXQVoPpOZ8s+jwv/m2/C6XETAh6Y5KaQ1MFMMeazRkScq+nPWQ9XmszBWofnlSBSw6tpQeBAGKBH32NJ3MRGPWPPAb8sKSEyuNqL36/JjMMjKjNhd8cRONqrtzRwcxVDeti5yHFeXhGNdvQqOQ3QY9A6XZHlW1A0rZCOKxURCAWi2Z15GoG+sdkcXu9b35+LLgVtoW7CQjYk/LpyvU+tPd93xC2Rfnk1AfFiCJznAlV6AfiKE/CS0rnP5YClczlpLg==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 04:23:36 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 04:23:36 +0000
From: <Dharma.B@microchip.com>
To: <robh@kernel.org>
CC: <tglx@linutronix.de>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Topic: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Index: AQHaWz8HvDl6LGSGcE+Fqy+8rXoJf7EGw2QAgADu8AA=
Date: Tue, 13 Feb 2024 04:23:36 +0000
Message-ID: <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>
References: <20240209100122.61335-1-dharma.b@microchip.com>
 <20240212140824.GA107736-robh@kernel.org>
In-Reply-To: <20240212140824.GA107736-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH0PR11MB5901:EE_
x-ms-office365-filtering-correlation-id: f4fd6f4c-c4ab-4a02-91da-08dc2c4b8c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UmS9j56s0qyxC7uYprgtKSIbvTzPj9MKLrQ81wGJsRJ6t9JtE4VKAoHpCV8J34hxrNSyOxmsv+vqDT5KiDCby29F1hIdvSP1/2+LkkO8QMjF1Qmg97CsteoJby8lyQ8JSX4T07kCJ4iiGYGyF4i4aIkLivF1MbQNzvN5pWLRK9bK3YrYZZIEf7+05VBOrpJvCimJmAG5ZVyaIH3eHdrHZiXp5tIHZIO3LKGlMM92vRDkEaOMujPEd/m2eDdlbZaBOyGJfsnnYu8YK3JiEDhF4hmV6z01tOxDjeHX6U2IZAqb2T5YI1ZdH3qTZaPgUA4lTVZcqI6ZQGjxbvMKGEi4k/GgVigKs++KkHoWNkdHVzUq9RIaSy42lICB5hpJdPYJZ0Z6YJ1nAJPbg45moK4P7/UPVuTCvU5KXUqowuAtu6jWDAaii4P9U4XsuN94jbzyaPckGrgJUyeG3IFJAghk4WzQ5aTZRR5eH88N7e09fFfr1xKzR0isDIgal/8gMY3Ar1i/+VvlrI6mUsGd8CenLYp6VudeZjyi8y0hPUT80FIK78qZ3eIV8b4KNG4Bys9yh3Ebj0OtStVgHZrHKMOs88BS++jiGXgzYhoS35U6nPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(53546011)(478600001)(76116006)(66946007)(26005)(91956017)(6506007)(66476007)(71200400001)(5660300002)(64756008)(8676002)(8936002)(4326008)(6916009)(66446008)(6512007)(6486002)(66556008)(966005)(54906003)(316002)(41300700001)(86362001)(31696002)(38100700002)(122000001)(2616005)(83380400001)(2906002)(31686004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXdPR2YwNDNpc0E0STlLdWoyT1UrR1dEQ1JzVXBKVHFnZzFWRXluTVdEWWwy?=
 =?utf-8?B?cVYxWVBJMUJkWnVMeEdLZEEzMzdnVzJzRnRURGZCTXB1SzAyc3RTbXM5eFor?=
 =?utf-8?B?SWpvakM3dWFOZitld3NKeXlmYmlNL2UvVGs2NlNLQlY0Vi9qUks4RHBpZ0Nr?=
 =?utf-8?B?WEpjUzNmeU52OHhiSWx2cGJjQlFQRjFlNndwU2JkbVVFenZMclgwclV0bnh4?=
 =?utf-8?B?RlZXdm5xRjg3ZmZIODlGcWZMUzNaUHBaWUxBRjg5M2FMaEdhb2IvQ25nZkY4?=
 =?utf-8?B?NFF5V2NMaU5wbm9YRmtZaDhTT0dzaVB3cEp1WUYrRGJ5SG5rLzA2RUdSb3Rq?=
 =?utf-8?B?Z3draEQ2R2pzOWdMVFZ5QXhwOG1yaEdDMkRrYmswVjZwVEswNGxEVC9Eem1Y?=
 =?utf-8?B?ZGN6bTVnWDYwcGNDUHJVT0lROEdyNEdoOXBBL2ZYOHpCUURnaitOZlhTUjVO?=
 =?utf-8?B?TUMyQ0RxZjkwRHZzSUNlRXI5UGdzSi85MWN6MGx6SGsvY3A2MUVlTUhOZ1ZM?=
 =?utf-8?B?aWxmd1VyRC9uZ1RucmZhWjF3L2g0S2h5Zm83SU5PODVibVdhS21NVm1sajd1?=
 =?utf-8?B?K3hJeHRJSVVrSksvSHlUQStvUktDU1JDRXh5ZjZqS1dzNFd5Vk0xeVNBcU9j?=
 =?utf-8?B?My9NdVhlRC9uVXpseGJMNmt3S3hZTkxvcmF4NnhZR1BjOXNDNHJWNE5VSHZz?=
 =?utf-8?B?a1g5a3RvK0g2UDJiQk5XSk51UFdNcHFxcDVlLzRKU2NGeVV0RlUvSi9Qalln?=
 =?utf-8?B?UUtoRXNMMHNUVUdkQzBrcW1nV1ROanY5MVNIRVJqSEYwamc2OENheHUycWoz?=
 =?utf-8?B?UC9PUFJnc3RLUEFXQkVyek5JV29WcmFncFcyWkFsdDNtOUw2K1FRMm1rNlhs?=
 =?utf-8?B?SG5rSXUwOVlmRW5JdnNqVWFTTEhiazQ0TUJWcS9MeVNXamtGOFVBVU56NlpK?=
 =?utf-8?B?eFVVdjVJaks0NnJ4TEJPNlJQNXR2clNKTVYxUnRycDJ3ajNBNFlxQkZpYnZL?=
 =?utf-8?B?Nnd6N2ZiZVQzdEpxQkhFcVQ4YWtCUjdpc2xkaE9XQWJMOSsyZ2V2VU9EcXBR?=
 =?utf-8?B?WVBxSmswNjVmdk9icmlrVENoL3JRYi93bXd4cWhXVFRkNXRRWHpDN0h6eVJT?=
 =?utf-8?B?NUhLT3NJeENVcDg0aTZUQ0JwdVhPeFFMUldmN2tQVHluNHFCbUdtNGJLWG15?=
 =?utf-8?B?RUFzeExDKzlvdWJWbkt0QnVKSGRMdEpKdXN4bXVrR1B6MDJjb0hndjh4SEdp?=
 =?utf-8?B?REhUU3VqUDEyRzF0Skt6TEdwbE9mWThqdUpLRjMwNS85SWcrNEpPZlRUdnZS?=
 =?utf-8?B?MlpCWE9rUkhJNmxXZUQ3QllkU01DVUMwUjFTbFQvMmhuMnlTbFUwYmk1QVdo?=
 =?utf-8?B?Uy9aMXR3ODNGbjAvVlJSTnFuWHROb1RaN3oyeHVQalFrYXFNMDlCakdPWHpI?=
 =?utf-8?B?VCtaMHZuRk1DSEZLSGRCQXBTNS9zRDlxNXV0Q0x1VUptQXd6YzZJTitTL1ZL?=
 =?utf-8?B?RHUzL0J1UkQ1Zm5MUFRUQkc5L0xRSGpLRThwZGlZeWZrSDdsSzJKczNldlBE?=
 =?utf-8?B?ZFVDOVZNT3lVMy9rTFRTRkRnTlF6bVBvQ3VKVXIwR2liSkdKdFhPUzlzYjIz?=
 =?utf-8?B?ZDRHSHVrZUcyd0MwclZrSXF2bkduQmxCYVBxZDVqMWpDeCsrMWdKUXordS9Z?=
 =?utf-8?B?eUgzTjAzMHpUSkdId3FjM3QxVVNxSGNhZDZVWEdmRlcxSmNGaGFtcEhxWEZw?=
 =?utf-8?B?THIyVVUyN1VBR1loSlgyd0RrdWVDUkVIZ2ZqaXQxdVZMWC92bDhBR3Fhb0o5?=
 =?utf-8?B?V1ZMa3FvQ1MxNFFWL3lMUHZDVzkza1hnRS9hZEN6SUpSa09qbXB3dTNONytT?=
 =?utf-8?B?djFSdUxxaVpnTHhFWEpoTk9SQkE5VjBrTnRuRGlBdVZZTytVVytBdHdGeXZz?=
 =?utf-8?B?d2RKenloMjhhMjJKWExocU54ajNoeXgzWWhQOXVvZGpCVUN5MlBPanFubFVt?=
 =?utf-8?B?cFZRMSt1RVExcDBuQTIzQXRUK09WZS90bzgxQzRvenBueTJjVUdwQWVIenlr?=
 =?utf-8?B?akpVZldyY0EzRllRSm5XeEtORmNOeDl6ZUV4TStvMG5RRkxqT1VIOEhZclMx?=
 =?utf-8?Q?rBVtTA7mxK2ns71RxunRGxQP+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A5811C979255E47A65A451AF046B8B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd6f4c-c4ab-4a02-91da-08dc2c4b8c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 04:23:36.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yF4h1wCYmrfZA5PNneZWRZ+fM41eG4/359u9eiCdHE+pVPNxpdxaPkIHKfBPOALEpE47DKwvkTroH1LcLYSeyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5901

SGkgUm9iLA0KDQpPbiAxMi8wMi8yNCA3OjM4IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIEZlYiAwOSwgMjAy
NCBhdCAwMzozMToyMlBNICswNTMwLCBEaGFybWEgQmFsYXN1YmlyYW1hbmkgd3JvdGU6DQo+PiBD
b252ZXJ0IHRoZSBBdG1lbCBBSUMgYmluZGluZyBkb2N1bWVudCB0byBEVCBzY2hlbWEgZm9ybWF0
IHVzaW5nDQo+PiBqc29uLXNjaGVtYS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFs
YXN1YmlyYW1hbmkgPGRoYXJtYS5iQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZWxv
Zw0KPj4gdjEgLT4gdjINCj4+IC0gRHJvcCB0aGUgJ3wnIGFzIHRoZXJlIGlzIG5vIGZvcm1hdHRp
bmcgdG8gcHJlc2VydmUuDQo+PiAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBtYXJrZXRpbmcgc3RhdGVt
ZW50IGZyb20gZGVzY3JpcHRpb24uDQo+PiAtIERyb3AgdGhlIGRlc2NyaXB0aW9uIGZvciBpbnRl
cnJ1cHRzIGFuZCByZWcsIGl0J3Mgb2J2aW91cy4NCj4+IC0gUHV0IHJlZyBhZnRlciBjb21wYXRp
YmxlLg0KPj4gLSBEcm9wIGNvbW1lbnQgaW4gZXhhbXBsZS4NCj4+IC0gRHJvcCB0aGUgZXhhbXBs
ZSBvZiBkZXZpY2UgdGhhdCBpcyB3aXJlZCB0byBhbiBBSUMgYXMgaXQncyhkbWEpIGJpbmRpbmcg
aXMNCj4+ICAgIG5vdCB5ZXQgYXZhaWxhYmxlLg0KPj4gLS0tDQo+PiAgIC4uLi9pbnRlcnJ1cHQt
Y29udHJvbGxlci9hdG1lbCxhaWMudHh0ICAgICAgICB8IDQzIC0tLS0tLS0tLS0tDQo+PiAgIC4u
Li9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbCAgICAgICB8IDc0ICsrKysrKysr
KysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspLCA0MyBk
ZWxldGlvbnMoLSkNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMudHh0DQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFp
Yy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvYXRtZWwsYWljLnR4dA0KPj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCA3MDc5ZDQ0YmYzYmEuLjAwMDAwMDAwMDAwMA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy50eHQNCj4+ICsr
KyAvZGV2L251bGwNCj4+IEBAIC0xLDQzICswLDAgQEANCj4+IC0qIEFkdmFuY2VkIEludGVycnVw
dCBDb250cm9sbGVyIChBSUMpDQo+PiAtDQo+PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4+IC0t
IGNvbXBhdGlibGU6IFNob3VsZCBiZToNCj4+IC0gICAgLSAiYXRtZWwsPGNoaXA+LWFpYyIgd2hl
cmUgIDxjaGlwPiBjYW4gYmUgImF0OTFybTkyMDAiLCAic2FtYTVkMiIsDQo+PiAtICAgICAgInNh
bWE1ZDMiIG9yICJzYW1hNWQ0Ig0KPj4gLSAgICAtICJtaWNyb2NoaXAsPGNoaXA+LWFpYyIgd2hl
cmUgPGNoaXA+IGNhbiBiZSAic2FtOXg2MCINCj4+IC0NCj4+IC0tIGludGVycnVwdC1jb250cm9s
bGVyOiBJZGVudGlmaWVzIHRoZSBub2RlIGFzIGFuIGludGVycnVwdCBjb250cm9sbGVyLg0KPj4g
LS0gI2ludGVycnVwdC1jZWxsczogVGhlIG51bWJlciBvZiBjZWxscyB0byBkZWZpbmUgdGhlIGlu
dGVycnVwdHMuIEl0IHNob3VsZCBiZSAzLg0KPj4gLSAgVGhlIGZpcnN0IGNlbGwgaXMgdGhlIElS
USBudW1iZXIgKGFrYSAiUGVyaXBoZXJhbCBJRGVudGlmaWVyIiBvbiBkYXRhc2hlZXQpLg0KPj4g
LSAgVGhlIHNlY29uZCBjZWxsIGlzIHVzZWQgdG8gc3BlY2lmeSBmbGFnczoNCj4+IC0gICAgYml0
c1szOjBdIHRyaWdnZXIgdHlwZSBhbmQgbGV2ZWwgZmxhZ3M6DQo+PiAtICAgICAgMSA9IGxvdy10
by1oaWdoIGVkZ2UgdHJpZ2dlcmVkLg0KPj4gLSAgICAgIDIgPSBoaWdoLXRvLWxvdyBlZGdlIHRy
aWdnZXJlZC4NCj4+IC0gICAgICA0ID0gYWN0aXZlIGhpZ2ggbGV2ZWwtc2Vuc2l0aXZlLg0KPj4g
LSAgICAgIDggPSBhY3RpdmUgbG93IGxldmVsLXNlbnNpdGl2ZS4NCj4+IC0gICAgICBWYWxpZCBj
b21iaW5hdGlvbnMgYXJlIDEsIDIsIDMsIDQsIDguDQo+PiAtICAgICAgRGVmYXVsdCBmbGFnIGZv
ciBpbnRlcm5hbCBzb3VyY2VzIHNob3VsZCBiZSBzZXQgdG8gNCAoYWN0aXZlIGhpZ2gpLg0KPj4g
LSAgVGhlIHRoaXJkIGNlbGwgaXMgdXNlZCB0byBzcGVjaWZ5IHRoZSBpcnEgcHJpb3JpdHkgZnJv
bSAwIChsb3dlc3QpIHRvIDcNCj4+IC0gIChoaWdoZXN0KS4NCj4+IC0tIHJlZzogU2hvdWxkIGNv
bnRhaW4gQUlDIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3RoDQo+PiAtLSBhdG1lbCxleHRl
cm5hbC1pcnFzOiB1MzIgYXJyYXkgb2YgZXh0ZXJuYWwgaXJxcy4NCj4+IC0NCj4+IC1FeGFtcGxl
czoNCj4+IC0gICAgIC8qDQo+PiAtICAgICAgKiBBSUMNCj4+IC0gICAgICAqLw0KPj4gLSAgICAg
YWljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBmZmZmZjAwMCB7DQo+PiAtICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJtOTIwMC1haWMiOw0KPj4gLSAgICAgICAgICAgICBpbnRl
cnJ1cHQtY29udHJvbGxlcjsNCj4+IC0gICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDwz
PjsNCj4+IC0gICAgICAgICAgICAgcmVnID0gPDB4ZmZmZmYwMDAgMHgyMDA+Ow0KPj4gLSAgICAg
fTsNCj4+IC0NCj4+IC0gICAgIC8qDQo+PiAtICAgICAgKiBBbiBpbnRlcnJ1cHQgZ2VuZXJhdGlu
ZyBkZXZpY2UgdGhhdCBpcyB3aXJlZCB0byBhbiBBSUMuDQo+PiAtICAgICAgKi8NCj4+IC0gICAg
IGRtYTogZG1hLWNvbnRyb2xsZXJAZmZmZmVjMDAgew0KPj4gLSAgICAgICAgICAgICBjb21wYXRp
YmxlID0gImF0bWVsLGF0OTFzYW05ZzQ1LWRtYSI7DQo+PiAtICAgICAgICAgICAgIHJlZyA9IDww
eGZmZmZlYzAwIDB4MjAwPjsNCj4+IC0gICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwyMSA0IDU+
Ow0KPj4gLSAgICAgfTsNCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlh
bWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmRmODEx
MTVhOGI3Zg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy55YW1sDQo+PiBAQCAt
MCwwICsxLDc0IEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1Ig
QlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWwsYWljLnlhbWwj
DQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+PiArDQo+PiArdGl0bGU6IEFkdmFuY2VkIEludGVycnVwdCBDb250cm9sbGVyIChBSUMp
DQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAtIE5pY29sYXMgRmVycmUgPG5pY29sYXMu
ZmVycmVAbWljcm9jaGlwLmNvbT4NCj4+ICsgIC0gRGhhcm1hIGJhbGFzdWJpcmFtYW5pIDxkaGFy
bWEuYkBtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9uOg0KPj4gKyAgVGhlIEFk
dmFuY2VkIEludGVycnVwdCBDb250cm9sbGVyIChBSUMpIGlzIGFuIDgtbGV2ZWwgcHJpb3JpdHks
IGluZGl2aWR1YWxseQ0KPj4gKyAgbWFza2FibGUsIHZlY3RvcmVkIGludGVycnVwdCBjb250cm9s
bGVyIHByb3ZpZGluZyBoYW5kbGluZyBvZiB1cCB0byBvbmUNCj4+ICsgIGh1bmRyZWQgYW5kIHR3
ZW50eS1laWdodCBpbnRlcnJ1cHQgc291cmNlcy4NCj4+ICsNCj4+ICthbGxPZjoNCj4+ICsgIC0g
JHJlZjogL3NjaGVtYXMvaW50ZXJydXB0LWNvbnRyb2xsZXIueWFtbCMNCj4+ICsNCj4+ICtwcm9w
ZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgZW51bToNCj4+ICsgICAgICAtIGF0
bWVsLGF0OTFybTkyMDAtYWljDQo+PiArICAgICAgLSBhdG1lbCxzYW1hNWQyLWFpYw0KPj4gKyAg
ICAgIC0gYXRtZWwsc2FtYTVkMy1haWMNCj4+ICsgICAgICAtIGF0bWVsLHNhbWE1ZDQtYWljDQo+
PiArICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1haWMNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsg
ICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQo+
PiArDQo+PiArICAiI2ludGVycnVwdC1jZWxscyI6DQo+PiArICAgIGNvbnN0OiAzDQo+PiArICAg
IGRlc2NyaXB0aW9uOiB8DQo+PiArICAgICAgVGhlIDFzdCBjZWxsIGlzIHRoZSBJUlEgbnVtYmVy
IChQZXJpcGhlcmFsIElEZW50aWZpZXIgb24gZGF0YXNoZWV0KS4NCj4+ICsgICAgICBUaGUgMm5k
IGNlbGwgc3BlY2lmaWVzIGZsYWdzOg0KPj4gKyAgICAgICAgYml0c1szOjBdIHRyaWdnZXIgdHlw
ZSBhbmQgbGV2ZWwgZmxhZ3M6DQo+PiArICAgICAgICAgIDEgPSBsb3ctdG8taGlnaCBlZGdlIHRy
aWdnZXJlZC4NCj4+ICsgICAgICAgICAgMiA9IGhpZ2gtdG8tbG93IGVkZ2UgdHJpZ2dlcmVkLg0K
Pj4gKyAgICAgICAgICA0ID0gYWN0aXZlIGhpZ2ggbGV2ZWwtc2Vuc2l0aXZlLg0KPj4gKyAgICAg
ICAgICA4ID0gYWN0aXZlIGxvdyBsZXZlbC1zZW5zaXRpdmUuDQo+PiArICAgICAgICBWYWxpZCBj
b21iaW5hdGlvbnM6IDEsIDIsIDMsIDQsIDguDQo+PiArICAgICAgICBEZWZhdWx0IGZvciBpbnRl
cm5hbCBzb3VyY2VzOiA0IChhY3RpdmUgaGlnaCkuDQo+PiArICAgICAgVGhlIDNyZCBjZWxsIHNw
ZWNpZmllcyBpcnEgcHJpb3JpdHkgZnJvbSAwIChsb3dlc3QpIHRvIDcgKGhpZ2hlc3QpLg0KPj4g
Kw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGF0
bWVsLGV4dGVybmFsLWlycXM6DQo+PiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMi1hcnJheQ0KPj4gKyAgICBkZXNjcmlwdGlvbjogdTMyIGFycmF5IG9m
IGV4dGVybmFsIGlycXMuDQo+IA0KPiBDb25zdHJhaW50cyBvbiB0aGUgYXJyYXkgc2l6ZSBhbmQv
b3IgZW50cnkgdmFsdWVzPw0KDQpUaGUgaGFyZHdhcmUncyBzdXBwb3J0IGZvciBleHRlcm5hbCBJ
UlFzIG1heSBkaWZmZXIsIHdoaWNoIGlzIHdoeSBhIHUzMiANCmFycmF5IGlzIHV0aWxpemVkLiBU
aGlzIGNob2ljZSBpcyBiYXNlZCBvbiB0aGUgZmFjdCB0aGF0IElSUSBudW1iZXJzIGFyZSANCmNv
bW1vbmx5IGV4cHJlc3NlZCBhcyBpbnRlZ2VycywgYW5kIGEgMzItYml0IHVuc2lnbmVkIGludGVn
ZXIgcHJvdmlkZXMgYSANCnN0YW5kYXJkaXplZCBzaXplIGNhcGFibGUgb2YgcmVwcmVzZW50aW5n
IGEgYnJvYWQgcmFuZ2Ugb2YgbnVtYmVycy4gVGhpcyANCnNpemUgaXMgbW9yZSB0aGFuIGFkZXF1
YXRlIGZvciBhY2NvbW1vZGF0aW5nIElSUSBudW1iZXJpbmcuDQoNCg0KPiANCj4+ICsNCj4+ICty
ZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJy
dXB0LWNvbnRyb2xsZXINCj4+ICsgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQo+PiArICAtIGF0bWVs
LGV4dGVybmFsLWlycXMNCj4+ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+
PiArDQo+PiArZXhhbXBsZXM6DQo+PiArICAtIHwNCj4+ICsgICAgaW50ZXJydXB0LWNvbnRyb2xs
ZXJAZmZmZmYwMDAgew0KPj4gKyAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXJtOTIwMC1h
aWMiOw0KPj4gKyAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KPj4gKyAgICAgICNpbnRlcnJ1
cHQtY2VsbHMgPSA8Mz47DQo+PiArICAgICAgcmVnID0gPDB4ZmZmZmYwMDAgMHgyMDA+Ow0KPj4g
KyAgICAgIGF0bWVsLGV4dGVybmFsLWlycXMgPSA8MzE+Ow0KPj4gKyAgICB9Ow0KPj4gKy4uLg0K
Pj4NCj4+IGJhc2UtY29tbWl0OiAwZGQzZWUzMTEyNTUwOGNkNjdmN2U3MTcyMjQ3ZjA1YjdmZDE3
NTNhDQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0KDQotLSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhh
cm1hIEIuDQoNCg==

