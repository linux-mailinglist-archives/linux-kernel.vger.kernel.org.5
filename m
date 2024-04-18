Return-Path: <linux-kernel+bounces-150287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775758A9CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71831B27110
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C7168AEC;
	Thu, 18 Apr 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h6LQtccb"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB5165FA3;
	Thu, 18 Apr 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449949; cv=fail; b=jPUOVG0CB057wBVuQ4ieIIPEy4gSJcmefGQjUg5p/lyUOV9MiT1Grp2lCeaz47QxJXoMD3dZKHt3e4t/YrZwDM+WBzSbYJ4d9Rsk3sgjo7NMz1szDULud3iv3Qggj7jv8TSAY0aDXYrY+rg44cKFD2q6AuWtHyt9AlVjlAV7+rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449949; c=relaxed/simple;
	bh=OHOjw3nIiTAUxJW0xkkgVj68+GhAz6qApJYb2N1gBxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTT3H7J8vPiAwjVgAT01HDIjDZTpyZc0rSgTSjOCmi+GgGNlJHO5GBYPVbu2Ot/wUBQlbF/K3ul43cknRiXvmiSzwIjhEL8h0lhDFV/gN7ESghuKd290HKDC154PmqueNRAuU6NSSMd7tBcN1JcyizxqaVuioLzw3Ymucnar9yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h6LQtccb; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYwr4FZfBTzbouUHS8g+/iJit7ANZSQb98ILudAL3EbjZB70kvMeSSZQmF99hBhWW3FQvhGDbADg/zJo/JhLhefFKVH3+QfWkRikPamRTST3kIiwUbK3+DyGpUEzFWzwSrOYZjWcBOpGPdcbbR21wh7SLNSXEcBDkoIX49YT6knroLMcEobeCj9ZTzQ/dlmGY1v3Qt4DD/+pZ1J8rPAIjKbUUxvl7JE3+yTvRYcp4vFox1QIC0g7FYCVsckjpFAj0V+gTkhgV10ZrYufhylcejd163kMJWZTNbDz6oy+8c+glYnCi/7SonvRDCrkp3jLk+9HxLR6GYYDEUOvOL9jPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHOjw3nIiTAUxJW0xkkgVj68+GhAz6qApJYb2N1gBxo=;
 b=htrEkk7cpXXECF5KYYhXhpql82Hnx02eGBt0FMZYt8KibEs6OXGWmYuDYgrcf0lGnPwOlQ6o25CxtcDALBMlwxNGVz0FnRzT7DMtg0+QY5pifjbYSEc7SYNfojNJ/pWRdMzSrzVOpRHYmTELEW+BJm+6QCdfpRNTJNdl6m0GevlAN9s0qXAdn0snuhGDZbU6F9hkK/j4iIuwBHPzKPrPlpLs287p9sdumX0wuu5sqSTNl2NPCVU1SZwVyxqk4Bi8uztYJnxWgmU/RSkyjIARxogKUO28ItUx98BMx2+TASWjYzQqZnBLTteCDQrHbdPSDjhud6l/DrPwUAPr+EpQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHOjw3nIiTAUxJW0xkkgVj68+GhAz6qApJYb2N1gBxo=;
 b=h6LQtccbb//ZH/YHCgYdffcd0zVqkfQJDbLbObSG/ThFtDevihWk0DsyTfTJBgoEYS5qU67n0JalFr1eLes8NcAhdFROVy8hQLjlXhsnP0+77Ys/XKMV24CInEFWlCPzOu5zuzP6F4zvKvkuEawJAeg4VezSfktL39G6zpn7mlO2DlAvYkeAJloe/8PncqcZYco0vQjd0MuVpu9LHTOZwmS+w7x4DQ6brJkfK8wdVmkxdckEyuvjaQ6HpDerpPjn4WpXkfidL/n/Xvq+xs4g5m6Do1QdnwQezN6WpvIepRcoHbKR1LScLJj/LOEHzxFpbdIyQH5aAQoBWQOe1ArDAw==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYTP286MB3596.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 14:19:04 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 14:19:04 +0000
From: Qi Qi <ArcticLampyrid@outlook.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
CC: "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
	"james.schulman@cirrus.com" <james.schulman@cirrus.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Thread-Topic: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for
 Legion Y9000X 2022 IAH7
Thread-Index: AQHakZMnl6GUz3RxgkmV9kw8BxeryrFuDjcAgAAFWIA=
Date: Thu, 18 Apr 2024 14:19:04 +0000
Message-ID: <1883258.tdWV9SEqCh@qlaptoparch>
References:
 <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
 <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
Reply-To: "ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com"
	<ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-tmn: [Xh/i7gCk/X4ZQc/HHnV444OvoaWJyRQz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB2535:EE_|TYTP286MB3596:EE_
x-ms-office365-filtering-correlation-id: d2e67935-bd1a-4e37-ddbd-08dc5fb28053
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RWQ0RjDxQPyYuWCLPrhlEC+rrSKPYPgOp3ZoJWa5xAWFYqz8hEM77oYL7oCsJt/qfDei6ZGkIUH0DNJO5dNgv/70k+OQ3ZgYOT9hO3Q9r8qwIZaAcv4bNhmxBpmN3yD7DiihckdB7Qd3C5cS2oH59Y3dPTtLBcMc7T8daQpnCTEAfL/vfvoF03idqBiW2MmdGbmVoM8ZdbF2X4Mz+wKpZPwjjblX83rK8CzroCY06NI1UKb2KbBISj2JuNV8sy8w1Ys3+UxWj0v/TG7j0d5QgwcwLOkzeD/g9FUoVNyvnYunNUTKYIsJKEzCn1xAYZEkTgXbx954nfBFNoqj9OFh5omec3J5yuDu5YI/Wdr+aHWnWaLJcOoGxwKtvrgt0VVJq7gKk97JacIffG1EJ1dcDLhUQ6OKCr9W7S12IYDIOXBgwWSIbzxyt+wTxzDo6L2qMa7u7i7qSUgr3ldLiI9lRwese2/c4f5ICZItxoNHQXdvsicyssTiHjb7CmZvI7sHKE08EQpihlF9dzePfBoFro0J5Ly5Bt2ZAWQ8UANLXGTGZKf4ORcw0t5HIPlQzbm2YNsWV0fjrxZhcsOPATynw2lQIwTVIXtYomGX+5W3D1jlAcSgbl4bxAqQ8lcWZk2e
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHplbGIyZGNOdXcrbEZkK1IrdlJDeUxvaHVjOTFwb0VQUEEvMENuQ0VvR0tG?=
 =?utf-8?B?N1hMN0hMbzZFY0ZoSnp1dHEzZ1FQcThDaGpDUEh2Znd1eG9GWENFZXZWSHBL?=
 =?utf-8?B?VFRKaTRGVVA5T0N4K3R1cEVUcVdqU2doNHF4Z3NjQmMwblVmRWdiTDhjdTBO?=
 =?utf-8?B?dnoya0ljNE5SekFOZWlOYkg5OXQ1aUdmK2VYbEFmL1FDVGxkWVhWUGdlaGxw?=
 =?utf-8?B?d3FqZE9odkI2cGRIMHc0dXozU0szOUFpZkJNQjlYTVkvU1hPTmlwVm9yQll0?=
 =?utf-8?B?UU5PRUlyWVhmMHFPd1EyV3dtcGdHbEp0T0g0R2JoaGNnTmsrODZMZzJJSVJN?=
 =?utf-8?B?cHFqM3JTa1hvWkRvemhJYUFQMGdlVEZJMVp4bFo2dnZDT2VvYmxTeURYb3pt?=
 =?utf-8?B?MEtweDR0ZDRXYWRkZzZqUVZoYnNhaHE0VlZ0Vk5GdGsrMEg2a1UxdzZKajAv?=
 =?utf-8?B?aXVjbGo0M29sRE5oMmJ5TlVCMG9GUW5sUkJGdE9vRWpKNmhUY3dtVW1FR0kw?=
 =?utf-8?B?MTRwU2ZRNDFtRkVEMk51V0dzK0JlZHNYMjViU2N1cGpkL3A0RDdteHBNaHBY?=
 =?utf-8?B?WWRmT2l1Qk9LZ3JmL0VQZGU2a3lKcjhqd1lJNUFXMWpFWEQ1Yy9iaC9sTFlM?=
 =?utf-8?B?c0NEQTlHWUdjcjFFNTlZQ0xjdDM5UFI0ckttUTVNMmRuNTNVOEdJaHowUjhE?=
 =?utf-8?B?UVM4MldlSWFoQk5rU3JkRGFLcFpnZVdhc0ZSNkxCdkdDVjJ0S1kzUDRiRzI2?=
 =?utf-8?B?UTN4UnV2STAxQ0pIc1lWZWFvZFltZm5nNVFNclN1TFBldEsxRzc4SHNmOFBB?=
 =?utf-8?B?OVVrV1JsaFpFOEJJN2FYaUxSTlVaaGVzNDh6RnBVdDZsalVCMURRV0I4N1Js?=
 =?utf-8?B?MGxBQnJlaTQyVnlaMHpEakN6RDB2Mlp4a0FiaEk2VVhPSTJYRXNtYTNBYUNs?=
 =?utf-8?B?cGtwWEs0Vkw3SnBPUnpyd2FyUExoRllmbjFVc29JSFJPSTk3R0x2cXU0ZlEz?=
 =?utf-8?B?UWFsU2lNOFBGS3ZQTXI1bGpjUUY0b0gwZzFWVlhlMkxOZ0hONFViQWlNOXpX?=
 =?utf-8?B?Q0QyUWVHR1JvREVDci9EcmlvTFBpdW12OEdZY3RYbkltMzJkNlUvc0xVcnVn?=
 =?utf-8?B?eklBUEtpWE5WbHY3TnNPQ1JPc3F1SXI1OXV4a1k3eGRVOFRTaUY1MzVMZk1U?=
 =?utf-8?B?aWQ0Vmo3SlVESWlWRFhWTXNZTU1GS2hMWXlldnlsd1N3aVZvWHplL2pNbmda?=
 =?utf-8?B?eHZjdFIrOUhtRm1NUGROVkl0RHlacjZrRE9MZ3k0QXVvUnM2SjVTbUdUbkJn?=
 =?utf-8?B?REhlNFBKRGVOOVNqZTBCbExhN1J3Ykt4NkVobWlTaWdqRkR4V0VEOVJ1ekc5?=
 =?utf-8?B?bFZxK2c2Q0ZuL0xkcm5vbDBnRjY1RjRPT0pZMGVBbWo3Yy9qK0g1SXYwcThS?=
 =?utf-8?B?eWVWMWVGOGMyajhjMGNzWEdHaWtjbjJsWnIvMUdYYU5wKytaUEVLaWE1dERC?=
 =?utf-8?B?MHVBME5uYTVsNWFScWpxanczMkFBRmNHYVRHTzRGRXcrZ1I1RWxncFMvMmJO?=
 =?utf-8?B?aGJoTlBGczVYYnpnTlVDeW5xdEZIMHlKRTZnajdYMWJiYjRpOGIrVjZKckda?=
 =?utf-8?B?QTBsQWJmYzJJbkp3U3NOaVMxN0lOdWF2ZnROZHRXL0NydUlaNWUvNmZTSXBj?=
 =?utf-8?Q?nzHR/JM0PZoKiuSPo2Ld?=
Content-Type: multipart/signed; boundary="nextPart2179604.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e67935-bd1a-4e37-ddbd-08dc5fb28053
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 14:19:04.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3596

--nextPart2179604.irdbgypaU6
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Reply-To: ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com
Date: Thu, 18 Apr 2024 22:18:59 +0800
Message-ID: <1883258.tdWV9SEqCh@qlaptoparch>
In-Reply-To: <ZiEnWBbvmWwKqytK@ediswmail9.ad.cirrus.com>
MIME-Version: 1.0

PiBJIHdvdWxkIHdhaXQgZm9yIFN0ZWZhbiB0byByZXZpZXcgdGhlIGNvbnRlbnQgYmVmb3JlIHJl
c3Bpbm5pbmcKPiBidXQgeW91IG5lZWQgdG8gdXNlIHlvdXIgcmVhbCBuYW1lIGZvciB0aGUgU2ln
bmVkLW9mZi1ieSBsaW5lIGFzCj4gcGVyIERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMucnN0LCBpdCdzIGEgbGVnYWwKPiB0aGluZy4KClRoYW5rcyBmb3IgdGhlIHJlbWlu
ZGVyLgoKTXkgcmVhbCBuYW1lIGlzIEp1bmhhbyBQZWkuIApNeSBQR1AgZmluZ2VycHJpbnQgaXMg
N0RBODgxNUMxMEZDREFCOEM2RDExQzRCREM3MkEyNTE5RTc3RDZDRi4KCkkgY2xhaW0gdGhhdCBJ
IG93biB0aGUgY29weXJpZ2h0IG9mIHRoZXNlIHBhdGNoZXMsIGFuZCBhZ3JlZSB0byBsaWNlbnNl
IHRoZW0gCnVuZGVyIEdQTCB2Mi4wIG9yIGxhdGVyLgo=


--nextPart2179604.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllLQUIwV0lRUjlxSUZjRVB6YXVN
YlJIRXZjY3FKUm5uZld6d1VDWmlFcjB3QUtDUkRjY3FKUm5uZlcKejR2c0FQd0lCdnBQMU1MdzJR
U3Y0RERrWEJGQWgxNzY4aE5PcXRwTDVyTmhSUkFyWEFFQStwMzNUR1ZkOWM4UQpVOEpnQ1VaQWFm
UFhNa1Jad0RmN05FTWR6UFAwVEFBPQo9K3RtNwotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--nextPart2179604.irdbgypaU6--

