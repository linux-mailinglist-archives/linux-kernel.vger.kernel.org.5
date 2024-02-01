Return-Path: <linux-kernel+bounces-47823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF61B84535B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E655289577
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4C15AAC5;
	Thu,  1 Feb 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c2J/bYU0";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I/EdhLRP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D715B0FF;
	Thu,  1 Feb 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778143; cv=fail; b=InjwF6rq98FjbG3EWntpayD0I+4HkB96SbbYN+MaQUO/jSo2jdszjugCe5woKZsqPCXjpFWoBK4dtVnFJ6/rryB/l12tp/Fl2NVBG7weDaU41pJi+2CN27M9OIr/9yknKV6I864WtpjEL1GO2aPO1v9+F6CE0nRUibk7lIRkdss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778143; c=relaxed/simple;
	bh=x+brR3HCpoRg6KlGb7z0lcuL1pKhx7X81G/r6ULMg4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1QVrF1INuTVVpc4+NkOAULpt58kG0YPlrZsS9p2xOKgg1vtpJIuxyncM/VMsx2uUqi85JgRq8CoeXHAxO2yyEaTcD7H7MQ1ROjVIhzuksOFlp45Q5akbRr10kjmGHp/tg9r2J+q9SUSmP0nPL/P5kacjxPUNx8eI8McaPiIaj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c2J/bYU0; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I/EdhLRP; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706778141; x=1738314141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x+brR3HCpoRg6KlGb7z0lcuL1pKhx7X81G/r6ULMg4A=;
  b=c2J/bYU08ernBbnsKB0nWPBtEkDkbpuSfmvLp5xcwaZKNmNNoOT6gdwQ
   i2InJsRCW0KKZ+rEeer/oSrpJf5V/RCeDFgeH4bKnt4bUPgggMa7WHmJI
   yEMFuLV5DvdLbxr8ONy5XT+rXKbaahmOntjK7DnEJkDgqH/BIFaLt7VSh
   JvPfp+E4cBo8Gg6mB+LckioUUNCBH8yzZCO4UhCGn9pWuZCbjyWQSZTha
   7ZkD8u7wpjrLesJO4defcHmZpNOywmAL5DdHpHPKLcgPQ+hlI6pz+gjSi
   UKprRp9/d54QX0zuSc0pMU9FmnbZNUVWD4oHvQJZOCI5RjzfmTjwTfJg9
   g==;
X-CSE-ConnectionGUID: x4tV4z4ZTy+ELyHqxJkbJA==
X-CSE-MsgGUID: yF22Bms2Sk6VljdfvtUORg==
X-IronPort-AV: E=Sophos;i="6.05,234,1701154800"; 
   d="scan'208";a="182865244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Feb 2024 02:02:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 02:02:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 02:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Ht1Bf40zrebPVSVh4jhm0LvNoqqVRd8aEaxjohk1ubHKsZZPOGgdCY8Hq+IGVBQCmQP4bG0fevKBrapvUeLED1LJWcEImJ7qmlbVfaHWz3kkbmZZ9kI49P3RCiFM70BLSt5XDD3QzxKpo+zNrMJSbTrMTlMxzhBMuZvpqe3dovt54HON2VALZPoBjxGXJVEYPszHlRILsTZFz9Iy/LfqqFI2kL4v3SXe9X1uz+BvVZaj6r42Qr/DbfuB+fLbzxsmV7l6CUaBTODnosNkp/YZ1rROfEJmG+PcpgnvQM4Udsz1DX5gersSHybeLTUjH7jqDZRXtfOwKGCVlvyXqJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+brR3HCpoRg6KlGb7z0lcuL1pKhx7X81G/r6ULMg4A=;
 b=mnULAWZd3cQwWMcnq2GJ2d+euqScYszBjxdWr7peHOkgqHQ/+g7eM5//IHOEE4G7kdfOG8PfJXIt45Lata9urAhWfirD7BQKUzS87fN/AoFxqA7ze9KNqVbF8CUGQkOcura+sXOHhmehklyxgbQYagLkeAn9nP2gp8nEnpTmWI7mp+E5oOt94IXRPSo0bLsbBU87gG2ycOViOKI7e9KTrglFlRgR77JR2hZz8IKlZz7rwRo/hxI4gqHvw4/Z6NYdEo6xQXWBTpBnZr+SjmFJH2hOraqOkNg0zrjMvbX602fB8UGCrjCJ08Sv2QLP6pnEjmHRWPbbDBLxil1MN8DFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+brR3HCpoRg6KlGb7z0lcuL1pKhx7X81G/r6ULMg4A=;
 b=I/EdhLRPKCZrzGpVuxzpM1fwULdm4xuzoko/Jz14ze9tzHxvwmXUi4bSKY+n4e31jng/9d7lRa488DatRoZnpKCm03hqp1EWVtp0hPvLw/MfasUEWjKI63CV9xRHtYAA9S/fs4E4IfvxWzz0I9JI57qm6byUYS7j5RfxjVh6n+JbJTEORBUOqBrlIj3+m1uGGDoAg0htvsoQlgMqrX1m752djFlPTqABsIkpbblpTwIxsww2+BppF7FRoahIT3Ls4Emmjkf7bl0tTVwclhdr/E9opc6z8T1gR9kD0PpRGH0MZafkMSJrbU+tg5nrfrotJW91f1tqWivTUjUAmuxbSw==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by CO1PR11MB4802.namprd11.prod.outlook.com (2603:10b6:303:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 09:02:13 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::9773:5f8e:785b:1c31]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::9773:5f8e:785b:1c31%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 09:02:13 +0000
From: <Andrei.Simion@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] regulator: dt-bindings: microchip,mcp16502: convert to
 YAML
Thread-Topic: [PATCH v3] regulator: dt-bindings: microchip,mcp16502: convert
 to YAML
Thread-Index: AQHaVEbi20CG20F0TEWipog2v+zuqLD1LDMAgAAF9YA=
Date: Thu, 1 Feb 2024 09:02:12 +0000
Message-ID: <00417e83-ee1f-42f6-a48f-e7f5d9fa374f@microchip.com>
References: <20240131130727.447738-1-andrei.simion@microchip.com>
 <d2c0c5dd-e1a2-4607-9177-f3855cb5601e@linaro.org>
In-Reply-To: <d2c0c5dd-e1a2-4607-9177-f3855cb5601e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|CO1PR11MB4802:EE_
x-ms-office365-filtering-correlation-id: 8752363b-2015-45bc-571e-08dc23047b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhXROJysXDSabn3icb+ugSKSmyy1aU+DOf8wnV9bKGMo9dJv4dal75J/QBemExX0wkYZf7m9tSfRZ4OnF3SLRdU758KieFhvpq0s8pRAslb4+P+uPkPO5SzFhncoyLC3MdLxhJeznavBu8yJSJKwxv+fediZNjTbOkYfeVz+Nd8ayxsvGIpxcARveq7KXA960Yp1vQzYBZVqPBCZ5qA30nCfHogr4PiGZe5Usb1im4eMnIiQ1okDVTHJ9K6ybVy/fTWYUR33jPTtJl8F7EpbikrxWg+0YSOd1DoBiMxHoJBni3aiJqIQFerl6hLvpEng6I/kKlhQHJT7B4NLwj4Rr8bVSS39pMAJZ9cQOu3PbVqj1Mp0j/IzkXYP32HjVbq3U+nLTBX0GT3Df0Brzxw6IX1iO0oYEfZxdpSkt02NBhXyTgYkHGRIcV14wZ4eAtcLXPT5fIYMMwy0Z1Kt18pNt0SBDwTOQ9gchYEQkWimuNau3K6daokvGs4YZQxcPTVj+LPSihiwGNMm4dPMwe8R+XJitw2OhQLA4WbDwWuL5hjSjec/ZOis/9CgPx+LTAOYUEeld8p8zJBnWSOx09zr3poVR719uTFoRKX0GSmKobS/EFcpi5y1EqWLJX7IBya9+ZyBlLs9+XjX3b0gA8ikOzUrRMSaWA0PiMICUhwUw0BrRbnWD0dcmBjFLNX9y1bgfbcsOuiQeflHmbzEwaApPoa3bu593OcniT85zmoT25Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230273577357003)(230473577357003)(230373577357003)(230922051799003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(66946007)(110136005)(8676002)(8936002)(5660300002)(31696002)(2906002)(7416002)(86362001)(76116006)(91956017)(4326008)(66476007)(316002)(64756008)(66446008)(38070700009)(83380400001)(966005)(54906003)(38100700002)(122000001)(66556008)(6506007)(6486002)(478600001)(36756003)(71200400001)(6512007)(53546011)(2616005)(31686004)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZmSi9VNWtTY3hvM1hYbXA4aVl3cGtPSWo2L2VlYnRQU3YwZnNCcmlhaDlv?=
 =?utf-8?B?dEpabG1TRXdaaW1DZ3cyY1kyb1pnUkd1ZUp3NmJPMTdUR1VPdWsrR3k5MHZN?=
 =?utf-8?B?cFJSVk8zSkxibC9wTU91cWE4ekhKRkZIVllqVEZNTXQ5Q0w3Z1pZSGlZWWZD?=
 =?utf-8?B?L29Mclo5Y2trNjBoMUkyeU1VRFptQnFqNm00L2o0TEV2MHVubGxuWjBRc1Fj?=
 =?utf-8?B?T00zR3pJakM5UkVxTW5sS0VObk8ybnBHbUVVN2lVMFh4TGQvYmhyaU9MTkdX?=
 =?utf-8?B?eklkTWhFdTJFNmFDQmEzUDNZRTVMY3IrV1pubTQ0N0I2TjRUU2lPa0w3VXRB?=
 =?utf-8?B?YWNtdkpHU1pBVHU1MlZGdm1HLzFRNlJKdG5EU2pqM0RQMURwQm1oNFZQZjZ5?=
 =?utf-8?B?YWd3SytvTUFwM3hvSEpzckthSXNuRWtWUTI0ZERzT0EyZ2NET005ckVoc2xS?=
 =?utf-8?B?ZlA4UWNrUmdoeEhQTHhCRzhpdTU5YlpPdDhTKy9TWmcyUWhnVmU5TEpRcDlS?=
 =?utf-8?B?QUM4VWo3ck1Eelp0NncvYU9TOFRCc2g0RmtQZEk4UnhHU2ZiTTA5OVVqeE8x?=
 =?utf-8?B?NGtIZTQ5aFRwQ2hXaE5YUTI4RUlNcE11UEtEaW9XVEQ1VGNhdVR5Mkl5MTZk?=
 =?utf-8?B?MjVUYy9nWGlOOXB0S05EWmdUbVFoV25sUjEvRnAycUtXRUhjL3UyVzFCOVBP?=
 =?utf-8?B?UXRNK2xRc2p6TTQ5emR3MXhMdjRVOHpYRGNlYm45NGlWb3ZsNW1JaElvYWVh?=
 =?utf-8?B?L1pHZ3BvMlBWbGhQZ1lBREZNUGNTMmJzMzduaU5lWmU5S3VWdnJoNXFmN0Rt?=
 =?utf-8?B?eHI2K1BSdTZqcTlSUERjUVFsS0MwUjNFWHBiVy9qUk1vWW96OStINzZCWkc2?=
 =?utf-8?B?UENnWUhBbWtjVDdmMUZqUWdSdG5JTFZ1ZmJBUzV0T1Q3TGo4dFhlcHFkdmx1?=
 =?utf-8?B?cnpRS0ZkNnQwV0IvSzAxakgrRFJSVExTVzE3eThiUWRrck5KUU4yWjROcGlw?=
 =?utf-8?B?YTk1VUxLNjg5M3h5NGs4dW9iOVl3NFRnOFRLL09mbXNiMUhFeEdyejdIaWJq?=
 =?utf-8?B?OFlJLzJlRGgrQkt0c2RhellYUjdUdDhyeE1MTjVnb25zcHVQK2pIMnQ2WTZY?=
 =?utf-8?B?bnRTdWZ3c0poQ0hZa3I1Q0k1c0FtQmxNcnJiZXIyRVljUlRzS25sZW9JZEM1?=
 =?utf-8?B?eUszSTRUZWQxWGM1RHZlQ0h4M1RkRVJKRFFkalFONUNpZEY2cHF5V09pQVdF?=
 =?utf-8?B?a3NtSkFhdm4xNXhnd1BHMnJBSkdWREt6UHZDYzh2OGVzbTFEeDZpYjhaWXR3?=
 =?utf-8?B?WXpTYVdVM3YyRU1SRnNaMTFFQ1NHV204cUoyYktvWHpHSkF4cHBOTjVScFU5?=
 =?utf-8?B?U2c4czVjMlJaVTIyWlZUek1uVHQ0MFkwdktSaldUSG5DNnRHeFh0Q09vclR4?=
 =?utf-8?B?NHR6MXZTMHd2b3lSWUc3MC9MRUNYcDFsMWdZY1J6OHdGWm1UeEV1VmlrSHlw?=
 =?utf-8?B?UUpkbElvVmVpK2xwekplNmlNTDE5bnRPWmRmWDBld25BTjFCNHBzdXU4NkFZ?=
 =?utf-8?B?UktqaE1qZUNyOUl2RnRrdXI3U1lodnFDODkweXZXa1Z1dlpoWWJhRjlMejh5?=
 =?utf-8?B?blpUa3QwK1Q4R2pEQzVNaHpLbHFYSEN4UXJmSy9NWUVpSC9OcnA5TGNSb2U3?=
 =?utf-8?B?V3RwaCt2aVdJWUdUQ1Z5c2xINHMzMU5Pd2VjOGUxSUlhSnVWRkRTU3Y5emFI?=
 =?utf-8?B?N09pZEFxd3BLb2JZNFdhNDRCcjBtbkFPR1dDVXU1Y09VK016TnV6eEYxbEs1?=
 =?utf-8?B?QllGYWRONlRYN0R2Q1ZpR1dtYTdKdTNYK2Y1eTdEV0lXTDVubTUwRkxveVZw?=
 =?utf-8?B?aUNOS09VVW9QZkUvMTB4UkQxRXU3SVkwYnBINHFFeHBReTJjNm92N3pQNy9r?=
 =?utf-8?B?VG9jWkpGcmt3UFAvRXlPZHdPWVczK0xISTVsbk8wYyszZ1hkVWx6bytJb1ND?=
 =?utf-8?B?cnRNNk8zUFQyWnBjR1Q0V0NjNzdSOSs4YUVJaGZwZ2tYZnZZcEdHTEpuYlFT?=
 =?utf-8?B?blY1dndpaVNTdE9TVVFjeGVyNnZxU0RKYnhnQkJMRWVySmt6aEdBK3hSQzlj?=
 =?utf-8?B?eFdJd1FLYzEwMmt4VmQ5bVNrTWpXeEJrY0NldytsZG8yMXl2RElHVTA2Snhp?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F413932951DE8D428462ECC886024B15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752363b-2015-45bc-571e-08dc23047b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 09:02:12.9889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U41ePqOHy5aw/aUAGuh8NBaYCRgqLq4HfnbnPG7eJPgdjVfIJg09Y11U6Dw5iF7yXFDhjhPs8h6aNQ7ziiNukKywOMDXvf33hto3we+779k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4802

T24gMDEuMDIuMjAyNCAxMDo0MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW1lvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmcu
IExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0
U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiBPbiAzMS8wMS8yMDI0IDE0OjA3LCBBbmRyZWkgU2ltaW9uIHdyb3RlOg0K
Pj4gQ29udmVydCBkZXZpY2V0cmVlIGJpbmRpbmcgbWNwMTY1MDItcmVndWxhdG9yLnR4dCB0byBZ
QU1MIGZvcm1hdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgU2ltaW9uIDxhbmRyZWku
c2ltaW9uQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgdjIgLT4gdjM6DQo+PiAt
IGtlZXAgb25lIGxpbmUgb2YgcmVndWxhdG9ycyBkZXNjcmlwdGlvbg0KPj4gLSBhZGQgYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNlIGZvciByZWd1bGF0b3JzDQo+PiAtICJkZXNjcmlwdGlvbjoi
IGF0IHRoZSBlbmQgZm9yIGVhY2ggcHJvcGVydGllcw0KPj4NCj4+IENoYW5nZXMgdjEgLT4gdjI6
DQo+PiAtIHJldmVyc2Ugc3ViamVjdCBwcmVmaXhlcw0KPj4gLSBsaW5lIGJyZWFrIGFmdGVyIGZp
bGUgImRlc2NyaXB0aW9uOiINCj4+IC0gZHJvcCBkZXNjcmlwdGlvbiBmb3IgcmVnDQo+PiAtIGRy
b3AgcmVndWxhdG9yLW5hbWUNCj4+IC0gYWRkIHJlZ3VsYXRvci1pbml0aWFsLW1vZGUNCj4+IC0g
dW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIGp1c3QgYWZ0ZXIgJHJlZjogcmVndWxhdG9yLnlhbWwjDQo+
PiAtIGFkZGl0aW9uYWxQcm9wZXJ0aWVzICBqdXN0IGJlZm9yZSAicmVxdWlyZWQiDQo+IA0KPiBJ
IG1pc3NlZCBpdCBiZWZvcmUsIHdoeSBkaWQgeW91IG1vdmUgaXQ/IFByZXZpb3VzIHBsYWNlbWVu
dCB3YXMgd2hhdCB3ZQ0KPiBleHBlY3QuIEkgZGlkIG5vdCBjb21tZW50IGFib3V0IGl0Lg0KPiAN
Cg0KQWgsIEkgd2lsbCBwbGFjZSB0aGUgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSIgYXMg
aW4gbXkgZmlyc3QgYXR0ZW1wdCBpbiB2NC4gVGhhbmsgeW91IGZvciBjbGFyaWZpY2F0aW9uLg0K
DQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tp
QGxpbmFyby5vcmc+DQo+IA0KPiANCj4gLS0tDQo+IA0KPiBUaGlzIGlzIGFuIGF1dG9tYXRlZCBp
bnN0cnVjdGlvbiwganVzdCBpbiBjYXNlLCBiZWNhdXNlIG1hbnkgcmV2aWV3IHRhZ3MNCj4gYXJl
IGJlaW5nIGlnbm9yZWQuIElmIHlvdSBrbm93IHRoZSBwcm9jZXNzLCB5b3UgY2FuIHNraXAgaXQg
KHBsZWFzZSBkbw0KPiBub3QgZmVlbCBvZmZlbmRlZCBieSBtZSBwb3N0aW5nIGl0IGhlcmUgLSBu
byBiYWQgaW50ZW50aW9ucyBpbnRlbmRlZCkuDQo+IElmIHlvdSBkbyBub3Qga25vdyB0aGUgcHJv
Y2VzcywgaGVyZSBpcyBhIHNob3J0IGV4cGxhbmF0aW9uOg0KPiANCj4gUGxlYXNlIGFkZCBBY2tl
ZC1ieS9SZXZpZXdlZC1ieS9UZXN0ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3DQo+IHZlcnNp
b25zLCB1bmRlciBvciBhYm92ZSB5b3VyIFNpZ25lZC1vZmYtYnkgdGFnLiBUYWcgaXMgInJlY2Vp
dmVkIiwgd2hlbg0KPiBwcm92aWRlZCBpbiBhIG1lc3NhZ2UgcmVwbGllZCB0byB5b3Ugb24gdGhl
IG1haWxpbmcgbGlzdC4gVG9vbHMgbGlrZSBiNA0KPiBjYW4gaGVscCBoZXJlLiBIb3dldmVyLCB0
aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRvIGFkZA0KPiB0aGUgdGFn
cy4gVGhlIHVwc3RyZWFtIG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZvciB0YWdzIHJlY2VpdmVk
IG9uIHRoZQ0KPiB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni41LXJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1p
dHRpbmctcGF0Y2hlcy5yc3QjTDU3Nw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cj4gDQoNCkJlc3QgcmVnYXJkcywNCkFuZHJlaSBTaW1pb24NCg0KDQo=

