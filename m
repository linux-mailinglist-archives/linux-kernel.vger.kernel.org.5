Return-Path: <linux-kernel+bounces-162443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60B8B5B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6121C21611
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C51E48E;
	Mon, 29 Apr 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="dX+uwNIn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4ECB654;
	Mon, 29 Apr 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401042; cv=fail; b=Ei3EX/FlCl2z6fnmkxUbbO3qTeW8cD2MQBACv9/iVXXg7qrH6WFqLTbu3h6ulzGyWUwPDrzRhV1MkJZxRBWwUXuCKMXpOxxuncFhq3n+ZaHYEX0AsE6nLMVtUJor19LolOFdMWgBULPwlfODgjxeuExb2s11MebEIyA/uhgC9oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401042; c=relaxed/simple;
	bh=GOH0Wa95LppLGdeGgK51LU5SMLR8yAcUrH5qtF+I6O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V02c2ewWoIamKXpJOJvrzdCf6lGcJCQUR3Fs8Q/LmiZKhgAs5YYdEw3afNV2+/YF2TNQLOJ7rDRLo4Ra3EC0oTDpEC634fCLoWGcRz2e0yBPrtyWSM3SLV9pBfkdkcVGd6lW4yuT+eXN3xVr+6JOlPmK8wX6HSQBJKsfFzYJjRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=dX+uwNIn; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T3vO7j005302;
	Mon, 29 Apr 2024 07:30:35 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43au049-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctYcOPC1WuLW+4NPt31SEI+Kj2LVa2FTpahQbocHFf1ws5kJsOsrO4h0mlCovuYmdFwbT1WC6/ey9KFtguVTWYUBmGcqv8g0NnwY2/5zt3MSfKqahrF2vNRS4vHJnkm3rNKVKZLE1DBXgEyp/nlgX7TrrKsfjPsa1VnUSYLR0gstdw5lhV3IShGQngCtW5X7CNCjzDm2UCYp/3GgPEUqtCjAdJbaH+xZQqj1KpKcp4jwEy0xzwluIaDky1+hQYkKz2oqk3qUrqmTKYL9r0IIhHtOff/RV1jtsh+1YljtPSoRMk7yphuyQ2KeMpfNpqKwu87tP+T892ECygUXdO5dpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOH0Wa95LppLGdeGgK51LU5SMLR8yAcUrH5qtF+I6O0=;
 b=g1oTYMMKSYlVQNZAP/OVwyofjKoW0y5nyaTS82Yc1ofqZlD9f4KZL5kDxXatVaD9PipMMUnXa4dvXQImdkkHTHUWZPU5g+c/lzlrCpEA56B+TtN+/kPqpb29KTiRiAPk9UPgws9x8SjIc1u1jnNX5JYiAs0pbMNVplTHv7QFbm4Okbu2k2TFiMWKE1BhBo08FwOODd/75FdK8rNOlf9FhfWv56qi6mfOFHzAS2ZrspliOw2ne3XXj1T3gyNwn61zxCmTrYH9LawI1VqjXTiD1jAZiRmv6OUK2YhuUmeDPmGWVpmv9pHCXZ7KCp5w56mv8jKvxyGp72e/XKF4fpHtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOH0Wa95LppLGdeGgK51LU5SMLR8yAcUrH5qtF+I6O0=;
 b=dX+uwNInz0+K2Z/4jLA0PStroIRPEQtjiYHC0BRQ0qJXZDKummgtokPlG3FyZ5QC8WlBrgoiYN/+ifhprKh/vf7Ow61mU7qIik84RcyVNWQZHQWV6VTN6UfD3sGmtHBKIwag0J/Cyo6RfLZM369+/HWNTAaq4/oiK+p1fyYNtSI=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 BN9PR18MB4268.namprd18.prod.outlook.com (2603:10b6:408:11d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 14:30:31 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5dc7:7d9d:2619:191d%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:30:29 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>,
        Piyush
 Malgujar <pmalgujar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/5] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Index: AQHakS3IEG1hJ0bMHU6EYeq4uC1r/rFuT7AAgBEONvA=
Date: Mon, 29 Apr 2024 14:30:29 +0000
Message-ID: 
 <CO6PR18MB40989F97F92C9A37C6BA896DB01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
 <20240418011353.1764672-5-wsadowski@marvell.com>
 <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
In-Reply-To: <16a4a58c-cae6-4b62-859b-3661c052468a@linaro.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|BN9PR18MB4268:EE_
x-ms-office365-filtering-correlation-id: 2bff310e-40ea-47b2-219c-08dc6858eb97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UTV6d2ZHK2ROVlVyanJMRnlkNm1UMnNJcnlNQzZwTDdXQnh2a2tkQUlvUUVk?=
 =?utf-8?B?dnpWNEN5MTBNcStoRjFVdGs2Mzc0Z3piTExQbzUxS2tsbTFURHl1S0NFS3Ju?=
 =?utf-8?B?TFp3YnFJOFpZTjlBZTlNQmU5TW1uU1RuRGQwVGV2cHo1NnFuQ3NUOG1DNHZX?=
 =?utf-8?B?dm5yTWYxdUNkUmlPVWJDcGpOZ1dwK0lJUjM3V0VpSVVOYlMrQjNsWkp2OUxj?=
 =?utf-8?B?LzlIL0lQRE5nWW1hVHNncDlTcDVrbW9WaFNYdEF0QThYRkNPT2hRTG5neHdB?=
 =?utf-8?B?VkVPbjQ3WEs0TFBZWTVIV0hhRzJiUCs0RE5ndy9IMVJ1TDZxVDJhTCtFbzVW?=
 =?utf-8?B?Y2wvWlJsNThIMURHMmdLc1pGbzJiaVZvUytKWi8wMHc2S29Ca2JJYjZxMjVG?=
 =?utf-8?B?dWFOY1Q5KzdZdlN4emZFRGtIRXZlT1BjdjZXTmFQRTdneVJHaC95UlNiYzc3?=
 =?utf-8?B?N1ZZMkx6TkxCblo5NnUvTlR5TFhHUC8yN2plMzFZaWZBVk5OaW1abjJWRmhx?=
 =?utf-8?B?ekI5QTJ5djJYMXg3eWlMYUNiVW5kUVJpNTBQNWJZTmkyWDVKV3p0cXJ5MWJ4?=
 =?utf-8?B?MzB2dUMzck1YUzRGdytRTW53eUxqdUtVdVVUaFRvMUFVUDNsZWlud1RJTXpr?=
 =?utf-8?B?NzBYSU1XSGl3L01kcGJGSGMzMG5rLzBmdnlWQzVibHNlRHY5bEw5NWlvaytR?=
 =?utf-8?B?MmI3a1ZlSEY5VXZrc3BlNVphY2lBbXRDYWtiemkwdGVlTmpiekZROVVsMlkx?=
 =?utf-8?B?aGlMQktJa0xqOGw4c3ZBWlNDWjc5ZlcvQVhaTzhJYTUyOFhDWVNkaXBqZ2w5?=
 =?utf-8?B?SmEyRDJyUUhYNUF6aURXVTlLOHdIVGF1T3djZ3BXQ3JuZWY2UkQycE1XbkRr?=
 =?utf-8?B?Sk9ITGl1Qm80bk85R0w4K2F1SElmZHVyM3lwc3hnYW9wOU8xMWErQURoNm1K?=
 =?utf-8?B?WjN4MENReG5Rdk9CLzNwemJSNTdvajhCck1FQ0F3bDdwVlQ1bmdnN0trRDlF?=
 =?utf-8?B?cE5FblJERzRFMTlHVktEYStkMmlUbDNaeDRIektaNThNNG92aGdXQjIycHo1?=
 =?utf-8?B?b1hLeC82dG9mTDJ2cjl4WUx1VXM4eDVRY0tZOStNRTArdm1meEo4Z1ZCMmpJ?=
 =?utf-8?B?Q01JNXZmT2ZQUUdRUGI0SGRIeFFMSWl2c29lcnhZSHRYdE5uWmVtR3dsamlv?=
 =?utf-8?B?OHFrcHlPcmNNWW1TNnd6d095YXFuWkdyRnlWdzA5Nkloc0pYYldKaWpqZ096?=
 =?utf-8?B?cTdveVVqMjljNEVvS2hoS2hRYlY2U2xINmxYZnZJWktnUisvSkwzYUd4L2FO?=
 =?utf-8?B?eXZnOE5ZR0wwakRmYUxEN0wxNjhZM05CUE1OOW4rOGJ1UE1ISlFxVjFtUm1Z?=
 =?utf-8?B?Wi9rQ09YNWJ0YnE2d01CYWRvcHA0ZnhnT3ZNTEo1SkgrUUZJTmhuREQ1Y3RX?=
 =?utf-8?B?Sm84cEdzWThiT1NPOWVwSDJFNTlnQ09OdUVNdnBwai9lVVpBNXlqUi8zMFAv?=
 =?utf-8?B?OGZYSEtEZWlKZng0QlJRMVpkaE44emQ0L2dLWVozaWdSVlZ6RFNTaGZMeUUx?=
 =?utf-8?B?VENNMG9rV1pkTmtrZmZvZkgzT25XSzFZbmMvQm94WTRHOUd0Ym9TblpYYUt4?=
 =?utf-8?B?K0dBTURZR2orTFRnVHhjZFVFSkk0UnlrcTFpRnNNeTFJZVRBcWRGWEhYTFAr?=
 =?utf-8?B?UTFyc3FWMWV1RXJDdFplOWtBdVhLQUJlL2tEV0U5bHVrS2ZCalNyT21Pcitz?=
 =?utf-8?B?dnJxTXlkcFMyc01GODJRdEhycit0QXVxK2IrUDRlNDM5UjU3RTNvbDBSYUtr?=
 =?utf-8?B?UCtMMUxONXJpSTV4VFJ0UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QVVPczNWQll0M3h5K2J3NE5Ed2lSdVZaeWUycUgxMmRqRUU5ajJ2czBUUE0w?=
 =?utf-8?B?U056dFdKNTNmMEpVNGUvT2E5KzllY3owT3FRcmdmU3BJOFRxNk9ZdjQwNTJj?=
 =?utf-8?B?QU9wTVVEeXRPaXFCejZ6ZzJzQmFxVUJwaVVnVngwTk1CWkExYUJob3M2dk40?=
 =?utf-8?B?NzIyeXRtNHFXSHRsREhLS1hXcWVBRTJOK3dtZER1MWZ5WEJFOHY5ekMwOGN2?=
 =?utf-8?B?RFNSclM1T21iYmVMYVVNOTJxVUFZRlZyT29iYTZmaDdiTFdpNWJKbEZuRTEx?=
 =?utf-8?B?Sy9ySU51bVJnQUFOYkVzeFhCSitKbmZXUjlHMHl0UXYrRmdEZGNCaThiTWJk?=
 =?utf-8?B?emhlV0pLRXdsaGNZZWRwcVhsU2F0d3F5U0xBNk5kRVprK0JOVzlsVjIvd1V2?=
 =?utf-8?B?cUF6QnYyTEVxM3U1dHlUM2tCR1dOVCtUS05YVFJxMUNCZUZUdDBiZUh2Znow?=
 =?utf-8?B?Y1JZc2RtMzVFLzJ5ZFVzRlYrSUxINVJYNUpLS1hnaVlwZkhBdGxoS1J3TkJP?=
 =?utf-8?B?Vk81WUZRajZGWnFwanZlZG5PbHF4dUdJRFR3cmJ5V2pYZ0dDQVBDTmJUSXox?=
 =?utf-8?B?djN3MVR3N1BUdm0zMVRlT09iNDJoK3UyZDdtL0Y2Z2lsSFlUUzF0UjlQOXU1?=
 =?utf-8?B?MjZoNUVZb1c0Z3o2am0rUnR6cmxTR0xCTHNpcFp0U0tYTkpoYjRVdFRpbUNZ?=
 =?utf-8?B?c1JRZlAwcEI2NGNxL0hEb3FXNmpqM2xCY3IzQmRQaTdKeEorSVRpdy9TVTFv?=
 =?utf-8?B?LzNlY3pLbjBqVEY1Y3UyVmNONm8rMWFXcTRJRWx3TEJvNVREZDRmcDN5dDdM?=
 =?utf-8?B?MDhzQTRCUGFYTk41bnlJaUIzWHR1a2VEc0RRdzArbTRsMWd2UWM0aWMzbDNS?=
 =?utf-8?B?bHRXNFd0cklnMlhramU4dVZNaVhRekY1YW1xbW9RWXNibllGcDRFNzlMRDd3?=
 =?utf-8?B?Rms3RG1NL2VRYzVGYi9aZlVmaWlyUmlJWitTTXV1Q09kZ0ZkVU1pTndRVnVN?=
 =?utf-8?B?YWtFb05xc1pjY1hHTnVMcGxJdjkxbStRNzl0UGhFY3VuWXN2bzBkbDJ2eHA3?=
 =?utf-8?B?MUhZd0FaNGlQZWR4aXR5anUyOXhYL0xSRjIyaEMzQjFvNTF1N3NxQlJySmty?=
 =?utf-8?B?ZG1XWkN4c3FjQmplUWo3L1ppdVpTcmdnRXB4cXVMQk80WDRKVVNFR3RBZGJF?=
 =?utf-8?B?TkluMmZGdnRqL0dFcllRWlBEUzhTOUgyVzBNU1JHaERoOHE4WCtQZFROc0RY?=
 =?utf-8?B?eENGWGJneVAzMk8vSkhXNUhtMHVzTnZnMmI1QzZvdEZVZ3VNSURHT1R0QXBn?=
 =?utf-8?B?SlVvYjA5QkZPTk1pdTcwbUMxK01NRjJrUVlkLzFDS0pDUUw4bE1Qd2M1a0JY?=
 =?utf-8?B?TjR1bXg4ZnNGQmRwbjM3b3dJZ2ErOVVWKzFIMkkyZVpjbys4RW5Kc2xNZThy?=
 =?utf-8?B?RTFFQXUvcEU2S3hnazJtcW9FakFwUk5icjdvUnVmTDJDS21nNWIydVRsUHU5?=
 =?utf-8?B?aE4wak95TEhsMWdJT1ptbzZ6N2UzcUpoNEZwckxzdWVEOWJNbWZMbjZCdUFM?=
 =?utf-8?B?aUorRXc3RytDS0pVKzVkYW5ZbWVDbzNMR0FrNjkvdFBLWnUzNVVCQ0RHUzRX?=
 =?utf-8?B?enJZTXpHSjFoQlM4ckZiSDljbjNtNXhTZkJ2TkJjT3FNZVFsSnhROVNXVEpl?=
 =?utf-8?B?Z1pNU054NVdMY2ZPZXF2ZWdQZW1OSHBZZkFob3hENVAvclZGaENiMUVLRFJR?=
 =?utf-8?B?bCtoTCs4QW9LMW16MXB5ZXFGNWoySEIwdHJpTnB1enkvVEh6eVhnN0dIQjJu?=
 =?utf-8?B?S05wN3dsV1Nrd1dMbmk5czlMUGZSMXFLOS9pNDBLUW9YQ3M3QnY1REFaa3ho?=
 =?utf-8?B?TzB3b1UwYnYybmRNWk9IeGpWZWdyZEwyTTVTRW0ralBBRnZaaTl0RWhnUity?=
 =?utf-8?B?SUs0T2tWc00yWjlsVUg2Qm1UY3NkOTBBWmxWOVFTa2drcDRObkVTdDZoYVpw?=
 =?utf-8?B?YjlqUGd1UWgxMFNqbGlvSmNWSmNsQ2hwQWNhelRqYTJmcjZ5L1lacWZMVHhU?=
 =?utf-8?B?a1RtTUFTK2pHQTlleXowZkxyQmFtRUFZZ0dJTVI3Sy90OWYyZnk0V2xubTZm?=
 =?utf-8?Q?4DThP1zck2zpNLLnCoUshCRxX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bff310e-40ea-47b2-219c-08dc6858eb97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 14:30:29.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgO6pr9JZ4L+rxRCuXSJPrMehZKwiAkHiC7gxhbrGh5Zk6QAKbstZVBryeYZEA3l4CyBK1wbUh1KXymKbDEiqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4268
X-Proofpoint-ORIG-GUID: gyBv8NAsKDtLIZ7mjEbpzT_0xHtLCDoQ
X-Proofpoint-GUID: gyBv8NAsKDtLIZ7mjEbpzT_0xHtLCDoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02

PiBPbiAxOC8wNC8yMDI0IDAzOjEzLCBXaXRvbGQgU2Fkb3dza2kgd3JvdGU6DQo+ID4gRnJvbTog
UGl5dXNoIE1hbGd1amFyIDxwbWFsZ3VqYXJAbWFydmVsbC5jb20+DQo+ID4NCj4gPiBUaGVzZSBj
aGFuZ2VzIGVuYWJsZXMgdG8gcmVhZCB0aGUgY29uZmlncyBmcm9tIEFDUEkgdGFibGVzIGFzIHJl
cXVpcmVkDQo+ID4gZm9yIHN1Y2Nlc3NmdWwgcHJvYmluZyBpbiBBQ1BJIHVlZmkgZW52aXJvbm1l
bnQuDQo+ID4gSW4gY2FzZSBvZiBBQ1BJIGRpc2FibGVkL2R0cyBiYXNlZCBlbnZpcm9ubWVudCwg
aXQgd2lsbCBjb250aW51ZSB0bw0KPiA+IHJlYWQgY29uZmlncyBmcm9tIGR0cyBhcyBiZWZvcmUN
Cj4gPg0KPiANCj4gLi4uDQo+IA0KPiA+ICAJfQ0KPiA+IEBAIC05MjQsNiArOTg5LDIxIEBAIHN0
YXRpYyBpbnQgY2Ruc194c3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfQUNQSQ0K
PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNlX2lkIGNkbnNfeHNwaV9hY3BpX21h
dGNoW10gPSB7DQo+ID4gKwl7DQo+ID4gKwkJLmlkID0gImNkbnMseHNwaS1ub3IiLA0KPiA+ICsJ
CS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkgJmNkbnNfZHJpdmVyX2RhdGEsDQo+ID4g
Kwl9LA0KPiA+ICsJew0KPiA+ICsJCS5pZCA9ICJtcnZsLHhzcGktbm9yIiwNCj4gPiArCQkuZHJp
dmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpICZtcnZsX2RyaXZlcl9kYXRhLA0KPiANCj4gVUVG
SSBwcm92aWRlcyBjb21wYXRpYmxlcyBmb3IgQUNQST8gSSB0aGluayB0aGF0J3MgZmlyc3Qgc3Vj
aCBmb3JtYXQgaW4NCj4gdGhlIGtlcm5lbC4NCg0KWWVzLCB0aGF0IGNvZGUgaXMgbm90IGRvaW5n
IHdoYXQgd2FzIGV4cGVjdGVkLg0KQ3VycmVudCB1c2FnZSBzY2VuYXJpbyBpbiBBQ1BJIG1vZGUg
aXM6DQp4U1BJIGJsb2NrIHdpdGggSElEIFBSUDAwMDEsIGFuZCBhZGRpdGlvbmFsIGNvbXBhdGli
bGUgcGFja2FnZSBzZXQgdG8NCmNvcnJlY3QgY29tcGF0aWJsZSBzdHJpbmcNCldpdGggdGhhdCBh
cHByb2FjaCBvbmx5IGlzc3VlKGluIEFDUEkgbW9kZSkgaXMgd2l0aCBtYXRjaGluZyBkZXZpY2UN
CndpdGggZGF0YSBmaWVsZCBmcm9tIG9mX2RldmljZV9pZC4gSXQgbG9va3MgbGlrZSB0aGVyZSBh
cmUgZnVuY3Rpb25zDQp0byBtYXRjaCB0aGF0IHdoZW4gRFRCIGlzIHVzZWQsIGJ1dCBpbiBBQ1BJ
IG1vZGUgaXQgZmFpbHMuDQpJIGJlbGlldmUgc29sdXRpb24gaXMgdG8gdHJhdmVyc2UgZGV2LT5k
cml2ZXItPm9mX21hdGNoX3RhYmxlIG1hbnVhbGx5DQpUbyBtYXRjaCBkZXZpY2UgbmFtZSB3aXRo
IGNvcnJlY3QgY29tcGF0aWJsZSBkYXRhIHN0cnVjdHVyZS4NClRoYXQgd2lsbCBiZSBpbmNsdWRl
ZCBpbiBuZXh0IHBhdGNoc2V0Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQpSZWdhcmRzDQpXaXRlaw0KDQo=

