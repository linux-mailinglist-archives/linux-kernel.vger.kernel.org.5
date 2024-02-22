Return-Path: <linux-kernel+bounces-76166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E219885F3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D2F1F225A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D6D36AED;
	Thu, 22 Feb 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wS3PW9Xl";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qbZpFu+o"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE7C182D2;
	Thu, 22 Feb 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592417; cv=fail; b=JfrafBLijerpWrNfoPWPmQ2AwotrbQu8m1N7XiFNAgty++BX5LB15gYDjOmm0OKH7pP5uYo9hsOfAUIR4u2ziTU8n1CJP3l2GTKvQM9nVM+wGA32L4qBMNZtA1nL5Zqhnu++Vgmll0IZrm3OPLBRu4htM7CFUSbJJIjAhulzSi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592417; c=relaxed/simple;
	bh=oPOojqwxGfrh4JaotqSISs3NqDyQRk3Qk5jS0FwNjQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liIJcsawEBdEI5EpwIUgnwqAu6PjxF0PG6RTFll0xZ58egH0aNDrncQSHlCiZAm4X+EPtIILV+2obNIOWNIeNriyXJZw8EehzS31XzrHK15nrcnLI0L9DFnyXTogt5m69CJcsUH1o4X+cSnj6I9tQGie2/bckbqcKRnsUirwb7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wS3PW9Xl; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qbZpFu+o; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708592414; x=1740128414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oPOojqwxGfrh4JaotqSISs3NqDyQRk3Qk5jS0FwNjQo=;
  b=wS3PW9XlnWp0LwBDpXymUTJZ/3nPshRO+ptxNdO1ZrKyj7o4ZKwyKpbA
   d6iToO1yeZvHBgSA44nqFky6P5YomW2PGsfkdIBvhozc7HjBLySojBAHH
   +msaaqE8VVX+8/g8bklBqgoesoNfas2/Hi0BGzGMKu+xokjZ0oWu96hrC
   Uk2fXmAjQmGzC4dhSzLUO8EIaPQ8WdJBJkdhe/a+CJ8nPUlALYLts4wQ5
   P1U8Jh0jrl8ft7xaU0YdUj3hap/u4LJTSTbdzFLxSQ/HoLlFs8RL+3gFn
   ccNgiJntaliJpun/8PQUouLF7NRcq1Zn4au4pdLuGxJBhXB7ZmHIXkiiP
   Q==;
X-CSE-ConnectionGUID: WQFa/OZsSpi2YH7CWy0HHQ==
X-CSE-MsgGUID: MNmR9WRDRsy0isEsIEw3lQ==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="183919684"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2024 02:00:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 01:59:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 01:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLaJzB0wzoqzfM74TSMFjiBejefPfGigLwzJmJOo07yMpyx6+WRpX0sjGKQdf15ymj6eVDXdz+bUHcolA85chvk+kBYRq+6eGYoYTW8pMdLrZR9AUXD2RnbvQnXWK/TALL8ZpK+GHV6qoB/IUNDa0/Ki2sD1z8QImyfInXG8CIdXFQlqSrPS/knL4A8ekbioB6FOzQ9jN27QBEc8W+S5w9JdYBkCpn+6HiJcYpAdSpGa2MNVgPNn5Qyi7qmcHZsDYBOJviIr0B3LmIktARk4ikxVB3d6DobDEfEKlQKhxNYCkyqBE7T+5QY1RstVHS8bFtsnp7o399Z9uFmiJ1YTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPOojqwxGfrh4JaotqSISs3NqDyQRk3Qk5jS0FwNjQo=;
 b=ZS5szEE80fvp1g+pbo7MozSO9huHKQ4Bqn/cniabEfK24SPC/gLLU3cx/Sk6khfPj48l6ybYQMIyMaWlAVWXhOIhlw2R3f289GQDVBodI8AnWxsgBMhlqqLVWUyN0mPpFtSAwUGaTQGgSmLT5dnRLAyEiQnUSeMJKEDtHsQ5JFixPAu2knneCEM5+tZGe3r4lINXxRY92MUt+YTkypxG76Ccpl3jCwFmCrmfJ0sJlVZvtyjpsUHWQ5VtEGo6iwTo/XOvDbLmzdGI87mSe0IpMlpPHxjH+yz8pr25FDXAjp2uRSldrjimvl3XzKiDxoq7zXUUcqvIYjEqNqAj4NuzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPOojqwxGfrh4JaotqSISs3NqDyQRk3Qk5jS0FwNjQo=;
 b=qbZpFu+oSMdmC4ruTsHd+CZIqsq34zLvn3p/jrYn/PUckXE853vnXt0edltAih5dNulskRSItkFO+BWGIRSJ1KWWIWvAJq/TU2WhMH4eReeYhitZpO/uZb25XZDIyhZ+tl9L/iBtTlW/fcLhwE9yw22uDOQfds13q5jI+fMi0fbTNfx7/H9dePCZeQuxgIZCLoIKHnFPfAoUkbjZYJaRP+HYwNkV1mjYxnTUS1HLgaGZm3WbdVMGRVbSVQKY6/vq4WWHQDNyAs+1M1Iy2KiNH6fxULj4u2JcA6SsXLuMhR85UY2DHe9fW7G9NskiDQhqkxIYlfqkqHKcu45tBtx/2g==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 08:59:28 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.036; Thu, 22 Feb 2024
 08:59:28 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <robh@kernel.org>, <tglx@linutronix.de>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Conor.Dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Topic: [PATCH v3] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Index: AQHaZUKaRz7vhpmmVUKPKDUtfUx3wLEWD3SAgAAA54A=
Date: Thu, 22 Feb 2024 08:59:28 +0000
Message-ID: <01916920-5ad3-4f6b-a53d-649dccec6999@microchip.com>
References: <20240222035158.195265-1-dharma.b@microchip.com>
 <20240222-stiffly-squeeze-b4ec2b49a4fe@spud>
In-Reply-To: <20240222-stiffly-squeeze-b4ec2b49a4fe@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SJ2PR11MB8566:EE_
x-ms-office365-filtering-correlation-id: 594d33fe-1ece-41d1-c2a1-08dc338493bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpX6b1HAMzBfscjRYOb+66JjoXmoJiNn7I8a8hQHX+FbyYTFR47HJifW3F+CJ4QO9/S03wtQMm2L+fTkFyQWrVNhGm4/xBc1IyCeFp3RPGPiUEzXqlAi/Vo7fTz65X8kSRd2O35vquNi6m/Nb92ip6x9mbQ0oA9Z9js9dO1BC75kxh8lV+gFHgrM3dapXKPoPzIZMelRGGi+vyM4NjBPtKgBBnhel1FLOjElhxMo2W09lKXfPGsvsqhmh8jmMvVqIevX/UOtbHorTRjd1zPVK8VQRcM8Vr2YVj/hVN3ENrzC7r6GL7hy8+XsoLIA3i07fqXP6FcM4ibfvi9EnHYFV0UkmA15pi80QVRrYPedJL2q+oBA6jUv6zOd/LeePAx0+9dSudfiIH2YvPpF7MJWz8vllf14+yJsxciGucS3rBlrDF3Lyl+fpJyDOQUwzTwc6+8Ui8mxoDsQLHaKBm8R5qbJHCjTEkLTgHAGVCLo+ClNzRYLxKD6KNZ4mUVnrXBi38yJgL342XNZGyplEKHhwPcGIVV+oDBEUCr2ci7tezNViYujfFuE+8GxJsRrjByWtsI/7/+JrAf5Du6pCFEXRMeGvdc3neCIDbUhMlSdG5A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2hYZm9HVFFoZEFDaU9UcllXNXdjTFplVklkVzRxcXNBQmxpVlNZNkZnQVRD?=
 =?utf-8?B?V2MrQldiR0xjNzRpd2tlS1VicitUMjZnWWJRdlZnNjh2cFVYdjVub0tCUEdL?=
 =?utf-8?B?bHArQlZienlhRHdqTnBzdFN3N1RaR1ZPSzJQakhPVFAxTGUydnpKeTNyZUx4?=
 =?utf-8?B?T1VtQ0tQTEhHcHdkMm5PNFAwQmVkTWtmTXA3MCs4NDVYMUxyVnIrSlZFamRw?=
 =?utf-8?B?VlJLMTM3K1d5ZUg0L25qQ0lwNXVwNVU5VW5odW54V2lXY0lrRkNLL1ovb3R6?=
 =?utf-8?B?WWdvNzNHRm00dmN6cmJoZnZOb29hOCtlc0h1eTVMUnV0MXA4THBISytNZzRV?=
 =?utf-8?B?eUpwSmdNeTY4dWNtTWRMcUZNcnVnUWwyc3NxK2U3cmVsM3B4a01FRXIzL3dN?=
 =?utf-8?B?bFlTa2gvckQ4YnZXRmdRRGRmaFFYbFk1dCtyTy9USjdsUTdMNjR3SWhYbzBl?=
 =?utf-8?B?MWFjaXcraHJKR0RSWXU4bnlWaXg2TWtNZWo1YmU1Tlh4eENLNmFuTzhHZGhz?=
 =?utf-8?B?WmlLQ3RUNE5LWElLNzBuMkNDT2VPUWp3aFJ6V1JucVErWExVZzduZEdFcXRP?=
 =?utf-8?B?dVJibm5rdFJaYWNsSkNmZEFEa1I4VlpZbC9hanV2QXJVaGdPYVJveW1SWHhu?=
 =?utf-8?B?VXpmKy9TdzVIZDkzZXNNOTVTdTFYK0ZmUlVLSFg0K1RDNGtiOE9oWTVYam1i?=
 =?utf-8?B?OFBUNXlXU0FKWkE3TzdXYmlZRG9jNS9lNldkbWVhZWhZeU5rZHJ3Y2s3cVlT?=
 =?utf-8?B?RGJTQ0M3MjVwUkVnOXNmanJncHJDY09MSm9JcUlYRitObVQvYVdYZ0R6eGU0?=
 =?utf-8?B?VFpGbHpSQStEL2N4ZmhnQTZZdEt6QVowekdnZ1dqQmdXeEMyM0c5WGQ0bjJi?=
 =?utf-8?B?ck5WVG5NTHVLNFAvcVdJRmRrVTVMbHg4WmRJZGI0SDRJcTJXdVFpMFhQYndk?=
 =?utf-8?B?NHZOL0tINzJMeHdocmJ4TmFQbUdqVmxXcjFqMU5LeElrSWZZUzFDbmtTRFNS?=
 =?utf-8?B?TVpndk96cDB3REVVdG5wWUlrLzJ2eTVzQjY1Ulk0S2JKNHVlVis0eDJNWk1U?=
 =?utf-8?B?emhMTTFwVmNremhLT1ZWOTN5RkxLblJGeWhXNG16MWtPSFl3Z2V4bjJJV2xk?=
 =?utf-8?B?MnJMVjQ0WFNDWWhjOWpYKzlwdU1pTFR1WExFQ3QxcFBRemgzUHpXanZTSEFQ?=
 =?utf-8?B?WVZTM0hTNWY0T0JTbWdCQ0xOU0NsWXZvdFZaTGlJUnoyVDc3ZWlkQTlsZGsz?=
 =?utf-8?B?S2dsWFRaWCtRa0M4ZXVIK2JzYU1ocUNKWjQ0c3Q3aTQ4TzBqcnFFeHdVOG41?=
 =?utf-8?B?SkNnSVV4cUVEbDhpek9PRDN2RzFPWmNPZlM0dldkSG54QkRTUGlqUlJYMVNq?=
 =?utf-8?B?TExQTGJiMEhuaXR4dTRGa3dGdjBOb1o0NlF4QmQ2UVN5TDBrb3pab0thSkpI?=
 =?utf-8?B?cTRLTGNDbEVCQ2FKUjhrbHF3eHIxRFgxdFhkMVBHK2ZOVDVPM0ZKb3V2ekZX?=
 =?utf-8?B?Nk5jT05JNTZ3emYrRmtCb1EwT1ZzMTgwQ09CVG8zeUhWMGpCRTgrVVl0NVk5?=
 =?utf-8?B?d0pCMU0yNzhYOEZKTmkxUVU4ajZrakNlcTdWQ3NPbTZiSkZYUXhJVGtZYmlG?=
 =?utf-8?B?UFBJUHlXOHlEZE9HZXY2aFRXR2xZZE5wUWFydnJiR0J1Q3p3eHhFcXI2cGw5?=
 =?utf-8?B?OXkzeDBZSGNNdlNObm1jYkZITWM3WmhsaDJ2ZTczYlRrSU1zYjF2cVBkL1l3?=
 =?utf-8?B?V3h0cFh5TStMa2NMNklUV3lDNFAzUGxZWE9xTEREOUU5emFOYXltVmVXMFJY?=
 =?utf-8?B?Z0p2a0VRQi9PYWtKdThXbFZGbmN2YU82OHNNWUd2TWtVRGJhcGRwWWRYZGlP?=
 =?utf-8?B?L3grQVMxT295THJLYnk3RDJ5YUd4Z1NRY0FxK1RQSndJTG1PZDRWeFRmZzI0?=
 =?utf-8?B?NE1yWk1Cc0ZITU5wem1vMTN2c0pEOVpYUFFtY3NVYUxWV3dTU01MRDgwdHhq?=
 =?utf-8?B?MUNmaVYwZmYzYXJNaXdzN3BrNU5uMWo3SktpcVlPd0s1ZVRtYlVnQnk5azk0?=
 =?utf-8?B?c214cDVOZEdHL2VMTWNheTliSXlDRnliN1hGbTZPVDhOalE3N3NBYjJkTlF6?=
 =?utf-8?Q?ERShl0PWxWNAZyTcpphXeea1Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EDCC0E2FA5BB548B9DAD647B4E8D203@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594d33fe-1ece-41d1-c2a1-08dc338493bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:59:28.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZVqIJJfOEQIx4iG9s4ebXJ5o4m/4MKn3h9qmZdWdW5LDrJ6ihAqwtxTmB5ZCG30yS1n2yM/4Bgzu4OmpLCzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566

T24gMjIvMDIvMjQgMjoyNiBwbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9h
dG1lbCxhaWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+
IGluZGV4IDAwMDAwMDAwMDAwMC4uMGQ1MWJkNzhiZjJiDQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvYXRtZWwsYWljLnlhbWwNCj4+IEBAIC0wLDAgKzEsODkgQEANCj4+ICsjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlBTUwgMS4yDQo+
PiArLS0tDQo+PiArJGlkOmh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2ludGVycnVwdC1j
b250cm9sbGVyL2F0bWVsLGFpYy55YW1sIw0KPj4gKyRzY2hlbWE6aHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEFkdmFuY2VkIElu
dGVycnVwdCBDb250cm9sbGVyIChBSUMpDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAt
IE5pY29sYXMgRmVycmU8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPj4gKyAgLSBEaGFy
bWEgYmFsYXN1YmlyYW1hbmk8ZGhhcm1hLmJAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNj
cmlwdGlvbjoNCj4+ICsgIFRoZSBBZHZhbmNlZCBJbnRlcnJ1cHQgQ29udHJvbGxlciAoQUlDKSBp
cyBhbiA4LWxldmVsIHByaW9yaXR5LCBpbmRpdmlkdWFsbHkNCj4+ICsgIG1hc2thYmxlLCB2ZWN0
b3JlZCBpbnRlcnJ1cHQgY29udHJvbGxlciBwcm92aWRpbmcgaGFuZGxpbmcgb2YgdXAgdG8gb25l
DQo+PiArICBodW5kcmVkIGFuZCB0d2VudHktZWlnaHQgaW50ZXJydXB0IHNvdXJjZXMuDQo+PiAr
DQo+PiArYWxsT2Y6DQo+PiArICAtICRyZWY6IC9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVy
LnlhbWwjDQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBj
b21wYXRpYmxlOg0KPj4gKyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25z
dDogYXRtZWwsYXQ5MXJtOTIwMC1haWMNCj4+ICsgICAgdGhlbjoNCj4+ICsgICAgICBwcm9wZXJ0
aWVzOg0KPj4gKyAgICAgICAgYXRtZWwsZXh0ZXJuYWwtaXJxczoNCj4+ICsgICAgICAgICAgbWlu
SXRlbXM6IDENCj4+ICsgICAgICAgICAgbWF4SXRlbXM6IDcNCj4+ICsgICAgZWxzZToNCj4+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgYXRtZWwsZXh0ZXJuYWwtaXJxczoNCj4+ICsg
ICAgICAgICAgbWluSXRlbXM6IDENCj4+ICsgICAgICAgICAgbWF4SXRlbXM6IDENCj4gV2hlbiB0
aGVyZSdzIHByb3BlcnR5IHJlc3RyaWN0aW9ucyBiZWluZyBhcHBsaWVkLCBtb3ZlIHRoZSBhbGxv
ZiBkb3duDQo+IHRvLi4uDQo+IA0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRp
YmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gYXRtZWwsYXQ5MXJtOTIwMC1haWMNCj4+
ICsgICAgICAtIGF0bWVsLHNhbWE1ZDItYWljDQo+PiArICAgICAgLSBhdG1lbCxzYW1hNWQzLWFp
Yw0KPj4gKyAgICAgIC0gYXRtZWwsc2FtYTVkNC1haWMNCj4+ICsgICAgICAtIG1pY3JvY2hpcCxz
YW05eDYwLWFpYw0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0K
Pj4gKyAgaW50ZXJydXB0LWNvbnRyb2xsZXI6IHRydWUNCj4+ICsNCj4+ICsgICIjaW50ZXJydXB0
LWNlbGxzIjoNCj4+ICsgICAgY29uc3Q6IDMNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsg
ICAgICBUaGUgMXN0IGNlbGwgaXMgdGhlIElSUSBudW1iZXIgKFBlcmlwaGVyYWwgSURlbnRpZmll
ciBvbiBkYXRhc2hlZXQpLg0KPj4gKyAgICAgIFRoZSAybmQgY2VsbCBzcGVjaWZpZXMgZmxhZ3M6
DQo+PiArICAgICAgICBiaXRzWzM6MF0gdHJpZ2dlciB0eXBlIGFuZCBsZXZlbCBmbGFnczoNCj4+
ICsgICAgICAgICAgMSA9IGxvdy10by1oaWdoIGVkZ2UgdHJpZ2dlcmVkLg0KPj4gKyAgICAgICAg
ICAyID0gaGlnaC10by1sb3cgZWRnZSB0cmlnZ2VyZWQuDQo+PiArICAgICAgICAgIDQgPSBhY3Rp
dmUgaGlnaCBsZXZlbC1zZW5zaXRpdmUuDQo+PiArICAgICAgICAgIDggPSBhY3RpdmUgbG93IGxl
dmVsLXNlbnNpdGl2ZS4NCj4+ICsgICAgICAgIFZhbGlkIGNvbWJpbmF0aW9uczogMSwgMiwgMywg
NCwgOC4NCj4+ICsgICAgICAgIERlZmF1bHQgZm9yIGludGVybmFsIHNvdXJjZXM6IDQgKGFjdGl2
ZSBoaWdoKS4NCj4+ICsgICAgICBUaGUgM3JkIGNlbGwgc3BlY2lmaWVzIGlycSBwcmlvcml0eSBm
cm9tIDAgKGxvd2VzdCkgdG8gNyAoaGlnaGVzdCkuDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0K
Pj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgYXRtZWwsZXh0ZXJuYWwtaXJxczoNCj4+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5
DQo+PiArICAgIGRlc2NyaXB0aW9uOiB1MzIgYXJyYXkgb2YgZXh0ZXJuYWwgaXJxcy4NCj4gLi4u
aGVyZS4gQm90aCB3b3JrLCBidXQgc2VlaW5nIHRoZSByZXN0cmljdGlvbnMgYmVmb3JlIHlvdSBz
ZWUgYW55IG9mDQo+IHRoZSBwcm9wZXJ0aWVzIGlzIG5vdCB0aGUgbW9zdCB1bmRlcnN0YW5kYWJs
ZS4NCg0KVW5kZXJzdG9vZCwgSSB3aWxsIG1vdmUgaXQgaGVyZS4NCg0KPiANCj4gQ2hlZXJzLA0K
PiBDb25vci4NCj4gDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0g
cmVnDQo+PiArICAtIGludGVycnVwdC1jb250cm9sbGVyDQo+PiArICAtICIjaW50ZXJydXB0LWNl
bGxzIg0KPj4gKyAgLSBhdG1lbCxleHRlcm5hbC1pcnFzDQo+PiArDQo+PiArdW5ldmFsdWF0ZWRQ
cm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAg
IGludGVycnVwdC1jb250cm9sbGVyQGZmZmZmMDAwIHsNCj4+ICsgICAgICBjb21wYXRpYmxlID0g
ImF0bWVsLGF0OTFybTkyMDAtYWljIjsNCj4+ICsgICAgICByZWcgPSA8MHhmZmZmZjAwMCAweDIw
MD47DQo+PiArICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiArICAgICAgI2ludGVycnVw
dC1jZWxscyA9IDwzPjsNCj4+ICsgICAgICBhdG1lbCxleHRlcm5hbC1pcnFzID0gPDMxPjsNCj4+
ICsgICAgfTsNCj4+ICsuLi4NCj4+DQo+PiBiYXNlLWNvbW1pdDogNGY1ZTUwOTJmZGJmNWNlYzZi
ZWRjMTlmYmU2OWNjZTRmNWYwODM3Mg0KPj4gLS0gDQo+PiAyLjI1LjENCg0KLS0gDQpXaXRoIEJl
c3QgUmVnYXJkcywNCkRoYXJtYSBCLg0KDQo=

