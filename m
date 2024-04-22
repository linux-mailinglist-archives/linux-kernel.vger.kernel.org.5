Return-Path: <linux-kernel+bounces-152722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA28AC370
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4057528170C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9914285;
	Mon, 22 Apr 2024 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="AnfWHqT+"
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020003.outbound.protection.outlook.com [52.101.156.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333972F5E;
	Mon, 22 Apr 2024 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713760235; cv=fail; b=m4bsap0/IBoMJiJ1/5Ld0SW+ZJMFs3CuqRxOWDwql8L94HOtIQ8e5gt/z6R8EL1HJQQoCJM8MXa5XO/ZemNb54UQeysSjBM4kyIeo3ln4kLwxm3sRq3GQXLKeiBxyYg0kLJoxsx45JdvuCjpXWPSJnkS1F5TUFwalIAyFu16OIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713760235; c=relaxed/simple;
	bh=J9tLDilVgx40FBJ0QsutpHPEGIyPGSLEzOypJZx7uXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rme4Qq0c5xTQVXVVX3M4LHf0O05eFpyM9n27iSqFD9WDY8CIbw3iXClmx1ze95Ql9qQXenKnBjvVkYkU1QstC9HUHlB5p9pgjihWIIEi/eMBGg4Zn3gx23FpPzzpEQjzxISROUJxv9et4w1x/XsbMi979rsbyfRWn6XvTi5Fyy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=AnfWHqT+; arc=fail smtp.client-ip=52.101.156.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKo7aGNERBpKxJJHNIVacqz/+hMgM1NR9346c9eCJdIm2n2Br2w1XHwbpsPiH2wkPeIRHoeUhWw90SiUnWPynPfIpYyh6iaGzeExYZOC2Tbx3NFg68PT0mmTlCetesbc88H8wwh9MZHVGAQ0UUw81H9a6Ds3M/Bg2hg8EbvEEAqDDaxbqp7+Exr0GrYSqXQpwmimkTBiqJiTRe5KoInuv0oKAFLsgbcX3zgvDM1KIBH55IAUuQL0n81jKpq2khwwGbnhCpWnY6p1gISD8eYLai4Ka7oDYvYIfhDJTUlcT2f5yLYWFNaYAw6JeTvule4tjE9JRQ9DyEiTMxDovYBmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9tLDilVgx40FBJ0QsutpHPEGIyPGSLEzOypJZx7uXs=;
 b=Pc7Sbw/wp8RAirvIJM2yzbO6A3EQg8SKvMH/RpckPx1qRsspK3FmQPKTx5l7w1h0Heu29TO2e2QI8BGwpOlW1C3g2RBiE+IOoTnQrC5898iaqjF7oeq8nhlvZovs2AzspFLcxK2pyCkIMIsQ3s8lpaCZxJKcrTEcq79VaSeyOe/iBUVLCcUQ7331d14rd/dPe1GxVi0bKUz4BM9Fpqm1dwadqZXyVYxNTC4/buq+7t9fEWdvs1s/UKFngXD/rGGDO8HphKsGEKw8QeHFLjf9k18X1qllKvArMWyg9ASWv4oJ89iFMiRG/Vo30KbEtSM6atlZ0sxnCscKyg4DpuPEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9tLDilVgx40FBJ0QsutpHPEGIyPGSLEzOypJZx7uXs=;
 b=AnfWHqT+eY28sqy3Jx31xifBXyBDCJXi72UOs0SYc2YCz+aUuh/wxuS7gaEzBQQdMQMC/zFp/FFN+F1CzqJregWnqRsQQNSTYH3s4IUrmn06amfnsb+U0KKKbPK2iF/y1Me2tdapvpHPsg/zt3np5JzWrJAeOxigqyZFtRLEjMw=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PS2P216MB1268.KORP216.PROD.OUTLOOK.COM (2603:1096:301:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 04:30:29 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 04:30:29 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "sebastian.fricke@collabora.com"
	<sebastian.fricke@collabora.com>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>, Nas Chung
	<nas.chung@chipsnmedia.com>, lafley.kim <lafley.kim@chipsnmedia.com>,
	"b-brnich@ti.com" <b-brnich@ti.com>
Subject: RE: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422
 raw pixel-formats on the encoder.
Thread-Topic: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422
 raw pixel-formats on the encoder.
Thread-Index: AQHac6LGh5SBSdVHAEC+vu7H2SqqlLFuwRcAgAUx54A=
Date: Mon, 22 Apr 2024 04:30:29 +0000
Message-ID:
 <SE1P216MB1303F475980132394E5E79DAED122@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-5-jackson.lee@chipsnmedia.com>
 <3ba3445e820e14730794e85fb4322e5aa57e1119.camel@ndufresne.ca>
In-Reply-To: <3ba3445e820e14730794e85fb4322e5aa57e1119.camel@ndufresne.ca>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|PS2P216MB1268:EE_
x-ms-office365-filtering-correlation-id: ca482197-3001-403e-ad97-08dc6284f103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDBIbXdtTTVMTHV4WnpyVGtJbkpZdDRVRXJHVldlaXU0WURONUF6WklpRlJn?=
 =?utf-8?B?c0dmMTFycWhOYnZOdlRiOS94cDlScEUydURKQVhMQ0hjU3Vmc09VRW9jVVhT?=
 =?utf-8?B?bks5MTVxdWJURkw5K3NJNlBVNEpCSTNHN2FoajBOWFErMUtXRlhtNHQ4c3NI?=
 =?utf-8?B?YkRiaTJvMmlnaC9ES0o3RUJvUzdmdGZtOGRoeUFseXY1cFNHaFh6dTZGcXVY?=
 =?utf-8?B?V2pEckRvNmZkRWhvMUlyOHZHUTlHalc2cHBISXVFQlYva3dwdTJyTkJ2YlRi?=
 =?utf-8?B?ckFpUEZPQlpZSmhub1Z4ZytWUGlLMjc5Ym9MVHlYTGNxNjg2T1dWOFR6L0FG?=
 =?utf-8?B?WmY1QlNSdFJZQ0xXcUt6UW50MkwrajdnVDRScXdBQlJYMEMzZVV3OHYrWXhJ?=
 =?utf-8?B?ZnRuSkwxL01GeGQwWFJ5em5XRG9DRDlVbmFJVGh1T2ZzeVl3NmhwRXp0MHEz?=
 =?utf-8?B?K1ZUckJndnEvNEFQeHdQcVN5UWFNMW5pTW5IeW5WL2ZTNGpOejJ3dVhrRkJq?=
 =?utf-8?B?VDROUmJPejJMSlQ3ZHB5bDB4NmNYQ2ZyaUFvNEdTakxvT1lkdEt4UDZhc2ZJ?=
 =?utf-8?B?NXpGTFVSNlRPWGFsTmdodk9Fam1janN4ekx0Qjl0aUo2NDdvL2hjYlRDT1h6?=
 =?utf-8?B?Z1AvTWJYdThSNERoZkdpaXZVdDRSajBpeEZ1Uk1FTzVBRDlmbC9qMjVVanZF?=
 =?utf-8?B?OW9jOEdUc1lyK3VGYTNBTzVEMjEzV3dnTE52TWt2Vk9DVG0vMWdBZEhUU0xv?=
 =?utf-8?B?K3I5aHR3RWJSKy9LZXRHZG44cWczNG80ZDZzR1VYanJQYXg4bHh2bVVSZjVJ?=
 =?utf-8?B?V3JIZ1hFcVEzcjVtOUxoOGdQeTJDak5QbnVvQnJwT2pJdjZkWkJXeXExbjJs?=
 =?utf-8?B?cDd5K2xHdjB6R3pRTE52NTR4c0RPZjJCVmlnTVRzdVRUTHhyVnhVYXZmWC9n?=
 =?utf-8?B?REpWQTZVdldJbGdpV20xZzI5a0lHY1M1QzlQdnZRUEh1L29KOXhDakpoSGJq?=
 =?utf-8?B?enJ5NHJyY1VOSkVJL2tMK3pnZldCcUlvTzMzVnBCWGpaR3RaaEJ5aTE3R1lS?=
 =?utf-8?B?WTlyUEFDbFVhZ1l2UGNUSm9iZC9nOC9sL004TWRzWkZUZ3RmVGlnbnU0SXVM?=
 =?utf-8?B?MGlSaVVtOFU0QXZkR3ErQzhPaG5UMkRMVUNlYmFQWVJ5RzBnWHV4dnA4Rm9G?=
 =?utf-8?B?QmxaZ0p4U3VQOHdnWk5uMnpHVER5TG9ZWmhmdERzY1ZqRk5IZllYMi92NTBi?=
 =?utf-8?B?YVY3RVM5VTZneW9GRGxCRnRYZDJJdGJPNlZXdWpNTHo1eXRNVHBNWS83SGNL?=
 =?utf-8?B?T2FxaHQ5OEpYaTErRHQvK1dQOXhIU0gwaG1GbXJUc3RYN0tGY1kwT1M3RDhI?=
 =?utf-8?B?RTlPK3V1SG5CYkk2Vmw5d1BlRkJ2RjgxV0lZaXhwaVdtS2F3M0lveEU1SmI0?=
 =?utf-8?B?WVZVOGUreWZIbFp6aFZpdkdyS1BWN0hqdlFxeUlXbGFWTXRRdnI1YkxZeFBu?=
 =?utf-8?B?UytFdnh0U3VoVFF6M1Z5eHQ4ZnAvY3hZZlN3ZjU2UitCN2UvdWx3WEs1V1Vp?=
 =?utf-8?B?RU05K1ltWnI0K3lGK0FjMTdyYUxZdmJJampBWG53Rm9rdEg4YVk3VHkxYSt0?=
 =?utf-8?B?aE40RmR6S2NqT1hYRjJiQVFjT1lidHAxeTkwYitMYkUrWDdBOVZPK3d5VWJ5?=
 =?utf-8?B?SC9jWFZraDZVeUdTMVBPWnArYzY5YUZVZXFVOHhKd1Zmb1BMTU81N3VlM1Fj?=
 =?utf-8?B?SFhlb3dmcmpCNUhPdFlJSmVlQUJ0T3gybjdsanhLdWc5aUF2MndmcUdMNEdi?=
 =?utf-8?B?NG9nc0RlMDc0TUhoaE5nUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1ZCeS9BNEhrNUpZZ3J6ejl1Q1JvZC9zR0o2WmN5VXFtbzF3c0w4MlNJU2tS?=
 =?utf-8?B?bytHYStMcFBZbkdkdG45bkYvWnZuNURVMlJsakgwWFMzaUYxbGFNUHkvMm1G?=
 =?utf-8?B?M01qYm5UL3NOOVpxSkZBSkVwcWZCNVVWbTNlWmJnWG5iVEp4SFpURW5ZcEtu?=
 =?utf-8?B?eWdnL0RrbjV4dHpOejFRUkxVb3RMSkx4RDhxcjdQV2FkVjRoNDNGSi9EYUZW?=
 =?utf-8?B?QWNDRW5nZG5BQzlITVZLaEM0R3JETkRTN2taRzdVTHI0d1lPUGFHMXdlUE83?=
 =?utf-8?B?R1NTc1JCaDN3WVl4YVJyakpQV3oycWMxOVM1RHdZMzNrQUV2d05uTnBmZGxy?=
 =?utf-8?B?ai81bnJwOHFLN05FUDhrYjEybm1hZ2NNeWxSZkNhZnVqOGpvWjREbHBVWERX?=
 =?utf-8?B?akVhM2tERzJ4aVBLVE4reVVjdVRMdXR6YXJGcjI1VzRld1BweW5ZOXhmbVRW?=
 =?utf-8?B?UWJDNTl4MzhNN041akRlR2FuYzB2bUdvVzYzNDVscCt1UElyZjE5ODFsUHNR?=
 =?utf-8?B?aXpvY3pOdlRBZWNZejF0VEJHV05ldE5BSnAvQnljaG9nbGxuMWZxWVV3MGNt?=
 =?utf-8?B?WVFiSHJXSkRSQ2JFWjJJR3dEZ3Q3T3QvazZWMEFvZjk3YTRqeTVrbjRCTmk1?=
 =?utf-8?B?VHEycmxrYWNVeExHTGZFaitIeW5Na292byt1VDJmVW1HbHMxb2NISFVoUmVi?=
 =?utf-8?B?b2NuZG5KRW11amNoU0QrdEhWd3luc3JlaUtuV0VTUHdtdjdDa1lzeUF5YzB1?=
 =?utf-8?B?M3pSSTJHRWhmeW9GOEx4OWp5V2dQUWNpQ3JwRzlyeDNvWHB2V0hZK2NBK01W?=
 =?utf-8?B?SG1Qb3RzYU13TThUUG9tVmF5bUVqekR6VU9ObUt0eHJ2V3BhWXYza1d1TElm?=
 =?utf-8?B?ekJPT0hMcDVKeGdtWHpvVkppbCtGUGZzTTB0Q2F2VTFVZ2pHbEx5TVdmeDgy?=
 =?utf-8?B?OUxydnh5OEQ1aGhMcWZlVU1CaHVzNmt5dlEvN2hmZkgvd3dUT3kzZmFabFV2?=
 =?utf-8?B?T1IvTlNLdTRyUEdGcm1FOGxha3VKbGhjd01HNWRBdzhhRXAxUHFzRGdYd1Ax?=
 =?utf-8?B?Qk92Q1luRTIyczdHVHhydHY1WnRFTjgwakdnd2dGaFR5emF5Z0crUlpuL282?=
 =?utf-8?B?c29hMkRMaFVhcXprRElCWnJHWTlNVlBmRW40WmFaM3BRTGJpeHBMM2FYUHNv?=
 =?utf-8?B?d1hSNG1SWEg5NzhKbzQ4MjRhM0JGVHRUdnJqVW14d0ZrL1E5Y0JZYXBkZmZK?=
 =?utf-8?B?ZjI1aFV2SEpCR0g0WDNtQlc5SzRXV2tNOWhBWUJWcjl1NWR1RzY3L1ErVngy?=
 =?utf-8?B?eTdvWDhucURpOTNYZi96S1FUdDY3d05EWTZEUWhjdis0TFlFamh6dEZaMzN6?=
 =?utf-8?B?elpuNXJEWnI0Nis1R1BSaXZoL0FybmxSYkxSdmFJY21QMUluK1hCSWxvQlIy?=
 =?utf-8?B?TFRrUDExYjlhSmgvZERQc1NkOW9aQmJiZVFlTjloRzZZS3IyaXNrTmpwOHg1?=
 =?utf-8?B?aXFKbUUreHVmYTljTDFSVUtZaFlING13dnRZZlFuYzVMd2k0NEJiZ3RiZVVH?=
 =?utf-8?B?M2l1bGhzVER4bWhkN3lEc0lSaVkzS0RWakU4N24wd20zQmcyQzRUcjlpZXVC?=
 =?utf-8?B?RG1HcTExQktnWnNsa2JUV3JIY29jY1p1dVVqLzNKMUV5ZUFKWlVsRTFkcDdH?=
 =?utf-8?B?c2ZadEVFS0xBakhqMGJKSVlvNEtCL01zWmpEdkkzT05NYXhKbDhqNk93SllP?=
 =?utf-8?B?cFZFWWlWRlJUM3ZacmhrWXpmUktuT2gzSVdLTjd2aWxqenV1TGxWVDBVNWkw?=
 =?utf-8?B?bGNaWXg2RlN6WHdveFJuUlZ0MTNXODZWa3RoZXd5NUVUMFZtZVlpN0s0Qkhu?=
 =?utf-8?B?UDd1R0YveHk4V294ZlJTa00rYWtoSlV5NVRIZ1JQRyt0RUh3YnI0SmxtaE1P?=
 =?utf-8?B?NDZxMlIzeW5Odm9MZmJzMkVkTU0vQmdmbjhrNHZmOUJWL1NmZnhnaGV4SHhX?=
 =?utf-8?B?TVFYRkJQUG9BeUkveUhFTVlYaGNDOGJSQ2RmaFhQcE9iNEZXL201b1p2bFor?=
 =?utf-8?B?NGNCOHdtdEF6aGJwVFdtVTY0TFc1RUtxMlk1b0FIK1pvTytzUWpxcXJUeFA2?=
 =?utf-8?B?S1pHUzdTZVVRZDFxUC9ocnlNTGpMTnRwS1lENzFvaWdZVU9RYTBCMEx1UGlQ?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca482197-3001-403e-ad97-08dc6284f103
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 04:30:29.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+2UsryMZ3eoxZnYMcJCsgSCUNJ5TCVuVTfZYg4eTdKqYxPxXCFlj4btHo0KLgCbHeMFbQa01dbizyaMW7iwSPEZr7G4fRdPs266CQPy/WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1268

SGkgTmljb2xhcw0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmlj
b2xhcyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVzbmUuY2E+DQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMTksIDIwMjQgNjowNiBBTQ0KPiBUbzogamFja3Nvbi5sZWUgPGphY2tzb24ubGVlQGNoaXBz
bm1lZGlhLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsNCj4gc2ViYXN0aWFuLmZyaWNrZUBjb2xs
YWJvcmEuY29tDQo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGh2ZXJrdWlsQHhzNGFsbC5ubDsgTmFzIENodW5nIDxuYXMu
Y2h1bmdAY2hpcHNubWVkaWEuY29tPjsgbGFmbGV5LmtpbQ0KPiA8bGFmbGV5LmtpbUBjaGlwc25t
ZWRpYS5jb20+OyBiLWJybmljaEB0aS5jb20NCj4gU3ViamVjdDogUmU6IFtSRVNFTkQgUEFUQ0gg
djIgNC80XSBtZWRpYTogY2hpcHMtbWVkaWE6IHdhdmU1OiBTdXBwb3J0IFlVVjQyMg0KPiByYXcg
cGl4ZWwtZm9ybWF0cyBvbiB0aGUgZW5jb2Rlci4NCj4gDQo+IExlIGx1bmRpIDExIG1hcnMgMjAy
NCDDoCAxOTo1NiArMDkwMCwgamFja3Nvbi5sZWUgYSDDqWNyaXTCoDoNCj4gPiBGcm9tOiAiSmFj
a3Nvbi5sZWUiIDxqYWNrc29uLmxlZUBjaGlwc25tZWRpYS5jb20+DQo+ID4NCj4gPiBBZGQgc3Vw
cG9ydCBmb3IgdGhlIFlVVjQyMlAsIE5WMTYsIE5WNjEsIFlVVjQyMk0sIE5WMTZNLCBOVjYxTSBy
YXcgcGl4ZWwtDQo+IGZvcm1hdHMgdG8gdGhlIFdhdmU1IGVuY29kZXIuDQo+ID4gQWxsIHRoZXNl
IGZvcm1hdHMgaGF2ZSBhIGNocm9tYSBzdWJzYW1wbGluZyByYXRpbyBvZiA0OjI6MiBhbmQgdGhl
cmVmb3JlDQo+IHJlcXVpcmUgYSBuZXcgaW1hZ2Ugc2l6ZSBjYWxjdWxhdGlvbiBhcyB0aGUgZHJp
dmVyIHByZXZpb3VzbHkgb25seSBoYW5kbGVkIGENCj4gcmF0aW8gb2YgNDoyOjAuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKYWNrc29uLmxlZSA8amFja3Nvbi5sZWVAY2hpcHNubWVkaWEuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hcyBDaHVuZyA8bmFzLmNodW5nQGNoaXBzbm1lZGlhLmNv
bT4NCj4gPiAtLS0NCj4gPiAgLi4uL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYyAg
ICAgICAgIHwgNTkgKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTQg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMuYw0KPiA+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9jaGlwcy1tZWRpYS93YXZlNS93YXZlNS12cHUtZW5j
LmMNCj4gPiBpbmRleCA1YTMyYmIxMzgxNTguLjc3NjU3ZjYzYTE2OSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2NoaXBzLW1lZGlhL3dhdmU1L3dhdmU1LXZwdS1lbmMu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vY2hpcHMtbWVkaWEvd2F2ZTUvd2F2
ZTUtdnB1LWVuYy5jDQo+ID4gQEAgLTM5LDYgKzM5LDI0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
dnB1X2Zvcm1hdA0KPiBlbmNfZm10X2xpc3RbRk1UX1RZUEVTXVtNQVhfRk1UU10gPSB7DQo+ID4g
IAkJew0KPiA+ICAJCQkudjRsMl9waXhfZm10ID0gVjRMMl9QSVhfRk1UX05WMjFNLA0KPiA+ICAJ
CX0sDQo+ID4gKwkJew0KPiA+ICsJCQkudjRsMl9waXhfZm10ID0gVjRMMl9QSVhfRk1UX1lVVjQy
MlAsDQo+ID4gKwkJfSwNCj4gPiArCQl7DQo+ID4gKwkJCS52NGwyX3BpeF9mbXQgPSBWNEwyX1BJ
WF9GTVRfTlYxNiwNCj4gPiArCQl9LA0KPiA+ICsJCXsNCj4gPiArCQkJLnY0bDJfcGl4X2ZtdCA9
IFY0TDJfUElYX0ZNVF9OVjYxLA0KPiA+ICsJCX0sDQo+ID4gKwkJew0KPiA+ICsJCQkudjRsMl9w
aXhfZm10ID0gVjRMMl9QSVhfRk1UX1lVVjQyMk0sDQo+ID4gKwkJfSwNCj4gPiArCQl7DQo+ID4g
KwkJCS52NGwyX3BpeF9mbXQgPSBWNEwyX1BJWF9GTVRfTlYxNk0sDQo+ID4gKwkJfSwNCj4gPiAr
CQl7DQo+ID4gKwkJCS52NGwyX3BpeF9mbXQgPSBWNEwyX1BJWF9GTVRfTlY2MU0sDQo+ID4gKwkJ
fSwNCj4gPiAgCX0NCj4gPiAgfTsNCj4gPg0KPiA+IEBAIC0xMDEsMTMgKzExOSwzMCBAQCBzdGF0
aWMgaW50IHN0YXJ0X2VuY29kZShzdHJ1Y3QgdnB1X2luc3RhbmNlICppbnN0LA0KPiB1MzIgKmZh
aWxfcmVzKQ0KPiA+ICAJc3RydWN0IHZiMl92NGwyX2J1ZmZlciAqZHN0X2J1ZjsNCj4gPiAgCXN0
cnVjdCBmcmFtZV9idWZmZXIgZnJhbWVfYnVmOw0KPiA+ICAJc3RydWN0IGVuY19wYXJhbSBwaWNf
cGFyYW07DQo+ID4gLQl1MzIgc3RyaWRlID0gQUxJR04oaW5zdC0+ZHN0X2ZtdC53aWR0aCwgMzIp
Ow0KPiA+IC0JdTMyIGx1bWFfc2l6ZSA9IChzdHJpZGUgKiBpbnN0LT5kc3RfZm10LmhlaWdodCk7
DQo+ID4gLQl1MzIgY2hyb21hX3NpemUgPSAoKHN0cmlkZSAvIDIpICogKGluc3QtPmRzdF9mbXQu
aGVpZ2h0IC8gMikpOw0KPiA+ICsJdTMyIHN0cmlkZSA9IGluc3QtPnNyY19mbXQucGxhbmVfZm10
WzBdLmJ5dGVzcGVybGluZTsNCj4gPiArCXUzMiBsdW1hX3NpemUgPSAoc3RyaWRlICogaW5zdC0+
c3JjX2ZtdC5oZWlnaHQpOw0KPiA+ICsJdTMyIGNocm9tYV9zaXplID0gMDsNCj4gDQo+IFRoZSBo
ZWxwZXIgaW50cm9kdWNlZCBpbiBwcmV2aW91cyBwYXRjaCBhbHNvIGNhbGN1bGF0ZSBzaXplaW1h
Z2UgZm9yIGVhY2gNCj4gcGxhbmVzLCBzbyBubyBuZWVkIGZvciB0aGlzIGNvZGUgYW55bW9yZS4N
Cg0KWW91ciBjb21tZW50IG1lYW5zIHRoZSBiZWxvdyBjb2RlPyANCg0KCXUzMiBsdW1hX3NpemUg
PSBpbnN0LT5zcmNfZm10LnBsYW5lX2ZtdFswXS5zaXplaW1hZ2UNCgl1MzIgY2hyb21hX3NpemUg
PSBpbnN0LT5zcmNfZm10LnBsYW5lX2ZtdFsxXS5zaXplaW1hZ2UNCg0KCQ0KPiANCj4gPg0KPiA+
ICAJbWVtc2V0KCZwaWNfcGFyYW0sIDAsIHNpemVvZihzdHJ1Y3QgZW5jX3BhcmFtKSk7DQo+ID4g
IAltZW1zZXQoJmZyYW1lX2J1ZiwgMCwgc2l6ZW9mKHN0cnVjdCBmcmFtZV9idWZmZXIpKTsNCj4g
Pg0KDQpUaGUgYmVsb3cgY29kZSBjb3VsZCBiZSByZW1vdmVkLg0KDQo+ID4gKwlpZiAoaW5zdC0+
c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIwIHx8DQo+ID4gKwkgICAg
aW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIwTSkNCj4gPiAr
CQljaHJvbWFfc2l6ZSA9IGx1bWFfc2l6ZSAvIDQ7DQo+ID4gKwllbHNlIGlmIChpbnN0LT5zcmNf
Zm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjEyIHx8DQo+ID4gKwkJIGluc3QtPnNy
Y19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX05WMjEgfHwNCj4gPiArCQkgaW5zdC0+
c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYxMk0gfHwNCj4gPiArCQkgaW5z
dC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYyMU0pDQo+ID4gKwkJY2hy
b21hX3NpemUgPSBsdW1hX3NpemUgLyAyOw0KPiA+ICsJZWxzZSBpZiAoaW5zdC0+c3JjX2ZtdC5w
aXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIyUCB8fA0KPiA+ICsJCSBpbnN0LT5zcmNf
Zm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9ZVVY0MjJNKQ0KPiA+ICsJCWNocm9tYV9z
aXplID0gbHVtYV9zaXplIC8gMjsNCj4gPiArCWVsc2UgaWYgKGluc3QtPnNyY19mbXQucGl4ZWxm
b3JtYXQgPT0gVjRMMl9QSVhfRk1UX05WMTYgfHwNCj4gPiArCQkgaW5zdC0+c3JjX2ZtdC5waXhl
bGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlY2MSB8fA0KPiA+ICsJCSBpbnN0LT5zcmNfZm10LnBp
eGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjE2TSB8fA0KPiA+ICsJCSBpbnN0LT5zcmNfZm10
LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjYxTSkNCj4gPiArCQljaHJvbWFfc2l6ZSA9
IGx1bWFfc2l6ZTsNCj4gPiArDQoNCklzIFRoYXQgcmlnaHQ/DQoNClRoYW5rcw0KSmFja3Nvbi4N
Cg0KDQoNCj4gPiAgCWRzdF9idWYgPSB2NGwyX20ybV9uZXh0X2RzdF9idWYobTJtX2N0eCk7DQo+
ID4gIAlpZiAoIWRzdF9idWYpIHsNCj4gPiAgCQlkZXZfZGJnKGluc3QtPmRldi0+ZGV2LCAiJXM6
IE5vIGRlc3RpbmF0aW9uIGJ1ZmZlciBmb3VuZFxuIiwNCj4gPiBfX2Z1bmNfXyk7IEBAIC00OTAs
MTEgKzUyNSwxNSBAQCBzdGF0aWMgaW50IHdhdmU1X3ZwdV9lbmNfc19mbXRfb3V0KHN0cnVjdA0K
PiBmaWxlICpmaWxlLCB2b2lkICpmaCwgc3RydWN0IHY0bDJfZm9ybQ0KPiA+ICAJfQ0KPiA+DQo+
ID4gIAlpZiAoaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYxMiB8
fA0KPiA+IC0JICAgIGluc3QtPnNyY19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX05W
MTJNKSB7DQo+ID4gKwkgICAgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9G
TVRfTlYxMk0gfHwNCj4gPiArCSAgICBpbnN0LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJf
UElYX0ZNVF9OVjE2IHx8DQo+ID4gKwkgICAgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBW
NEwyX1BJWF9GTVRfTlYxNk0pIHsNCj4gPiAgCQlpbnN0LT5jYmNyX2ludGVybGVhdmUgPSB0cnVl
Ow0KPiA+ICAJCWluc3QtPm52MjEgPSBmYWxzZTsNCj4gPiAgCX0gZWxzZSBpZiAoaW5zdC0+c3Jj
X2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYyMSB8fA0KPiA+IC0JCSAgIGluc3Qt
PnNyY19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX05WMjFNKSB7DQo+ID4gKwkJICAg
aW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlYyMU0gfHwNCj4gPiAr
CQkgICBpbnN0LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjYxIHx8DQo+
ID4gKwkJICAgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlY2MU0p
IHsNCj4gPiAgCQlpbnN0LT5jYmNyX2ludGVybGVhdmUgPSB0cnVlOw0KPiA+ICAJCWluc3QtPm52
MjEgPSB0cnVlOw0KPiA+ICAJfSBlbHNlIHsNCj4gPiBAQCAtMTA4Niw2ICsxMTI1LDE2IEBAIHN0
YXRpYyB2b2lkIHdhdmU1X3NldF9lbmNfb3BlbnBhcmFtKHN0cnVjdA0KPiBlbmNfb3Blbl9wYXJh
bSAqb3Blbl9wYXJhbSwNCj4gPiAgCXUzMiBudW1fY3R1X3JvdyA9IEFMSUdOKGluc3QtPmRzdF9m
bXQuaGVpZ2h0LCA2NCkgLyA2NDsNCj4gPiAgCXUzMiBudW1fbWJfcm93ID0gQUxJR04oaW5zdC0+
ZHN0X2ZtdC5oZWlnaHQsIDE2KSAvIDE2Ow0KPiA+DQo+ID4gKwlpZiAoaW5zdC0+c3JjX2ZtdC5w
aXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIyUCB8fA0KPiA+ICsJICAgIGluc3QtPnNy
Y19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX05WMTYgfHwNCj4gPiArCSAgICBpbnN0
LT5zcmNfZm10LnBpeGVsZm9ybWF0ID09IFY0TDJfUElYX0ZNVF9OVjYxIHx8DQo+ID4gKwkgICAg
aW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfWVVWNDIyTSB8fA0KPiA+
ICsJICAgIGluc3QtPnNyY19mbXQucGl4ZWxmb3JtYXQgPT0gVjRMMl9QSVhfRk1UX05WMTZNIHx8
DQo+ID4gKwkgICAgaW5zdC0+c3JjX2ZtdC5waXhlbGZvcm1hdCA9PSBWNEwyX1BJWF9GTVRfTlY2
MU0pDQo+ID4gKwkJb3Blbl9wYXJhbS0+c3JjX2Zvcm1hdCA9IEZPUk1BVF80MjI7DQo+ID4gKwll
bHNlDQo+ID4gKwkJb3Blbl9wYXJhbS0+c3JjX2Zvcm1hdCA9IEZPUk1BVF80MjA7DQo+ID4gKw0K
PiA+ICAJb3Blbl9wYXJhbS0+d2F2ZV9wYXJhbS5nb3BfcHJlc2V0X2lkeCA9IFBSRVNFVF9JRFhf
SVBQX1NJTkdMRTsNCj4gPiAgCW9wZW5fcGFyYW0tPndhdmVfcGFyYW0uaHZzX3FwX3NjYWxlID0g
MjsNCj4gPiAgCW9wZW5fcGFyYW0tPndhdmVfcGFyYW0uaHZzX21heF9kZWx0YV9xcCA9IDEwOw0K
DQo=

