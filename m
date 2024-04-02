Return-Path: <linux-kernel+bounces-127861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC78951D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2436E1C23692
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86B6519D;
	Tue,  2 Apr 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K7J++tkh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q0faOrHR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECD4CB4A;
	Tue,  2 Apr 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057258; cv=fail; b=U/oJpR3t/fUJKubM7ENAnVLP1i8V5GUzyAIAfPR03VXh1iXwjzc6wxI0hS5DN2SQpF38v3i2vkHcOpICsuyADFxTg4d/uPYchzGARu2nL+sIo0S9a3eQA/e16Ke8c3uSZIsFDcqo2U1x2/ApxHsyrGsSnS0JpUR1Cbw3JM6nlFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057258; c=relaxed/simple;
	bh=jZHW3r9Ktp89afczzt8rIO3zlwATYZRkwt2U9/11nqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHejA3bmTag0A9Si0210tu7b6f2MSjyUPPaE8saYb97MzZ/niZisAX1TvfANxKmXT1dywPkiYGo8uP7+AUKAkrW6QzxlgujbX7XPgS0GEgb2VrnC7bP2CZjpptf/D3OaOUUznYlUnGkuoRUhptZJQb/r8yUblcMPGsP7cjRwPuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K7J++tkh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q0faOrHR; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712057257; x=1743593257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jZHW3r9Ktp89afczzt8rIO3zlwATYZRkwt2U9/11nqk=;
  b=K7J++tkhkjDkTs/2L53zON5finDqcE0rcLLcVkq4PyxIwklLlc3zwEgN
   piSWXChMPMsHWXafrsQp9VYvYzjXIeTzLdVvxYZYdfjwA1Fn5ZN2ydwv1
   hIdjV4oeeh2QX9NMcuyW38Gq5NSLuKs5oK6ib2gNUQ8hcxEQxj4T7ulm3
   WRa0sgyPKf9vaGsTAMs2+sPJm/KLlp/B2mnbw/wGjcrGZr6ERtem9uWKZ
   0GgCdDa0hgkpK4f/k74uyTIQzbA/bHzhxB7vjmXyrQFpxG7rhaXUNTFF7
   dMGCBxrvWQmGjheIDUv4hGn0jK+KWSbpiRR9AMQgELkHqo+r7YkwbrrZ+
   w==;
X-CSE-ConnectionGUID: ItPKXF06QJ2TjRXGP18WZA==
X-CSE-MsgGUID: HI/mAGInRR6rfu1e+JD8Tg==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="249931163"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 04:27:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 04:27:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 04:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn8+nRYV740brxu27ucSVLNnIThDxtceyH1gfoh+i2ce9MxcaQhk28hm2lMdffoLHoIZV3PJeCoZ61TR4t0H9syzP11VzeTnR3Mk3ilC+88hFcdkV6A+hsE3CjsgtHVS+VV4rCYH4fNRa7Fdqbf9lAfq/UubDr1Em/kRKmfF4ay4otcjqbuVuP+XzVUM/mKORxi1nJXgaYfnV1a/gKDdK1bcRQ5UmkOv+uOGsuLY3/AB+Q2uJinqSJXNr9oD5VWBQTH8QHC+QmROW6MlAYNsp1aeIKzZHtN6uX3zjpV/MktnSP7m9pV0urMlOudywP9yA4pB3dFIkGtIgVNZcKJ6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZHW3r9Ktp89afczzt8rIO3zlwATYZRkwt2U9/11nqk=;
 b=oEQgtT4lJet3uV0nyNFaohtz8sStRXY2i4a0T1lAbFRmhWFlzwNAzzzxzYMi+PYwrIwxDSHNsshF/iRp5lbM2egNRpeeC8kej6IzmmDA67BgLlFS35ROjoNlmtlapWMr0iBNED+KnZMJIMvoO/6yTraqHEwy8bAP1rshp7L+0Z6mf01lxo/Ja3xtG0y9Ah/DC9AwjJdWMGiHtYW7RGofENX4SVXH4BoFWKtVtP+XEwIdupS526iSF+71Wv8YzidjENLYlrX6PIJJ4sh/8vqA7N0NxFFz46YAnX57CtRAAMn7th8hFQiq929AwoClARBZQdPOQgXuFpJ3UPDemlYB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZHW3r9Ktp89afczzt8rIO3zlwATYZRkwt2U9/11nqk=;
 b=q0faOrHRXUzx83ivURZlG9GIMQg07vYAZ6tYVR/kDYVNeH9ExhEaErBWCW2MhcrYHLF/gmy3xE9DWE5pcVFucSjfFTUeJWmG40jOJqZ46dZwPCPeFTrPTcXZw8rnNdaqnzqlyKHzGiEV4wrumQtvoY7RciIuTWMD/fhjVoN0JYb3NT2vSottRBXfx1ZhN+p2/hxe2T7D5pq56OYUb7KBIrQtQGjyzwMPzGlstszU5dNSXDWRdColh8fnpgF7/5udd6IpUuBkJ+5GttKjo6WwXJ1pefyAgpArU0oKPUaNfwCi/G2GeiRBGhLOson6ZlJI8eMgTjjZnJiDPU9nlKqwmw==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 11:27:29 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::8e5c:ad:54ec:c5db]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::8e5c:ad:54ec:c5db%5]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 11:27:29 +0000
From: <Andrei.Simion@microchip.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Mihai.Sain@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: boot: dts: microchip: at91-sama7g5ek: Replace
 regulator-suspend-voltage with the valid property
Thread-Topic: [PATCH 1/2] ARM: boot: dts: microchip: at91-sama7g5ek: Replace
 regulator-suspend-voltage with the valid property
Thread-Index: AQHahN5LZ5MAh+l7HECdjA0NqvBbAbFUykSAgAANgAA=
Date: Tue, 2 Apr 2024 11:27:29 +0000
Message-ID: <312bed1a-0b8a-457d-a2e2-b8ee1b6f443b@microchip.com>
References: <20240402091228.110362-1-andrei.simion@microchip.com>
 <20240402091228.110362-2-andrei.simion@microchip.com>
 <34543ae2-4e78-45a4-9cff-389f7495fd4a@linaro.org>
In-Reply-To: <34543ae2-4e78-45a4-9cff-389f7495fd4a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|IA1PR11MB6145:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: he8MPfMbm/qgAwjLbrOeex12obY876ZZXwZZilJAB4LjdjzBbXYgWfM9ahiL+30MPetQ30m5xY6Cs/2ch2XyW70omUL0DCOpOsdx6zophEkRB5NiXx1jp/HJtYTYs6TONngmYMcDTNQrdO/thcAMO9Av5LCHdgTqq/rYF9ilvuhC58ZdF874n+LuNwYEprHuMlOBnWQA8Tx9aq9EG74YsUriPshIJN4DHDjniseH0aETWCQrhMO44Ur8aJFSqCfPQ4tfzCfJSaHCg58rctDWI7tnaIaC0RQQtd4HVybNXhY8P+h1grlgKZupY+ER8J89sZBriNpvIGEJRcGVBaix4haktFdTJriqfAAKjQukisbGnZph7L6qVTPK4mAQ7+LvS/jdjPZREWjY7IlRXmOkGnWu0oiZSmRHaRV49FdTB6meL03iZzw5Z4I4zJ9+/bw7R/7Pgnh9mGQR1d5+afaX5e3wstdfDtOA6mV9ZxflqT7JOH1H9KrMdhY0G18uR0mDbra1AKAGiiebBENorfdIIBvyt2awa6BK6dHhUWYb6SwpcB0vUQZbsyxyQjTOL1pZfffiq4C0GC9aGL2ika6ek3SXUKGzvtwRx/uHFTFlpUUXvYwCnCHvrw5ZOaAmdFOO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU9HOG40TlZEbW8veklORlN6bEF5cFNzcFp2Tk9aenpyNldvMXA5blNsUHpY?=
 =?utf-8?B?L0IvZHJKU0pleTViK1UydkEyeTVjQWtlSlFzUlJvWldTQjhTRkpZMlFtRytY?=
 =?utf-8?B?dmlCUmZHSlRDRDhoaUdCdTBhWHplNzlzOXQrZmdNcW1VWktvOWtlcVptOExW?=
 =?utf-8?B?eTBmVDZHbVRpN3BZVzRXVHptckxUSEl2RDRUYkRVQUUvendjZE1sb1NmMkJN?=
 =?utf-8?B?YkVHdVNkQnd1emVpclVSVEMxd08yZGErVnpHMjFHVHhEODZicGFrM25ST0gz?=
 =?utf-8?B?THA1d210ZWhSNzM4ZnYvVmhJTVcxcWFNTk9NQW9Ya1ZaUGNvTHlLZ3dlKzgx?=
 =?utf-8?B?aWw0allmUmNKZ0pnK3Q2aFRyN0NMbG9nQURhMzRHdGFrcUxCOW9JVlRvb3ky?=
 =?utf-8?B?M0J0TXhma000YU54NG5FZUNESjQ4UzZ0YkIrejJQbGNqMTJ3Q3hyK1dvZGxa?=
 =?utf-8?B?YTFxZVpidTNJVlB0UGlkUG45WUIwMzJDVHp5ZXBIdlEzOEZDcUQ4QVJCMGVJ?=
 =?utf-8?B?Q0pPemIzaXlHVFUyaXdNQkE3eU9LMTF5ZFEwR2lMQXkwUW9EWSt6R1gwY283?=
 =?utf-8?B?UzhFejBscllLMWVtTWY1Vi9aV2dqODh2RVBycEtWYStOZ1VVM3R0TXcwdGNG?=
 =?utf-8?B?VFlyc0F6cXErR0NVQ2FzU0dxRzdJZ21FR0hXakdiYnNoeTlwNVA0THUrS2RU?=
 =?utf-8?B?ZEdweFpmY3pkWDgrVWxQVlo3d2VZVks5Y0RuU1YzSHBtbGt4WEpCb1gzSGJi?=
 =?utf-8?B?S1JUc0I2eWtWSVZNeEQrVEpNQjdGWi9WR0hVWm53ZFEvTXpXOVlqMjZyeVd0?=
 =?utf-8?B?a2N1Q3NWbGliZUphc2RJNW5aM3I5REg3N0x5K044aS80RGZOTDFuY1BkVkdZ?=
 =?utf-8?B?ZzRYZHJhZC9FZWorNk0veDY4MjM3NS9VTnlLSHpiTFRIYXUwWGtuZm5SOHFV?=
 =?utf-8?B?eEJoK243Wkt5ZllESE56REdZcFhuckhhOUJsR2M1UVVOWTN2aUhUdEgzQUVI?=
 =?utf-8?B?d1IraXhmRURacTIvNmE5ZDFtMmZPT0NkU3R5ejltUEtybHEvZUJ0SWQ4OVcw?=
 =?utf-8?B?VHRiUUV5bVBpMGN5TXIyQ3YxRHFqSFhabStVVVZWUGplQnk2aldxTlJhYzlq?=
 =?utf-8?B?Y2xFSmtKbFdKZ1I4V2luYzUzamdPRXE4ZU50b09ta01jSmFZWXBVa0FMNEV6?=
 =?utf-8?B?RTRob2NHbXVsS2QxcWpocFQ1UndlUEsvOHF6QnVEMmFJNlBuMVI0VmZzRkMv?=
 =?utf-8?B?M3lxdmxSd0JyQkRESVM1Njd5ZWJSSE5Jcm92WFNRNm1zVU9mQmVzYldoajAz?=
 =?utf-8?B?UUVZTmNqZ3l3bThDd2xxYXlyQ09oYlpiRmNkVzh3UC9uNytFVkkvcU5aQXBG?=
 =?utf-8?B?UXNBOXBzUkE5SmRDUVl0b1p6Zk5qaTk3dHk0V3JiZk80akhyNU45aXhsNTM3?=
 =?utf-8?B?b2cxREptbDFCM2VFYSs0TVZWV0F4YjBGb3R0dGxtaklMZS9IaDBmZzdRdFBT?=
 =?utf-8?B?NHBLYnJaUGJmSDN6QStHNy9qQ0pyRmt1LzJwTjNUUmFleDBjaExrRFBnMjBN?=
 =?utf-8?B?MTBvU25XaU4yN1A3SklMNnRvR1JCRlFMT3J3bU05U0QxWTNlcVMrUGQzeXBD?=
 =?utf-8?B?b3JvSVJTZlFhL0JtWFZvUGJIMlNZMi9uYWg4UTQ0Y1VhQy8zVXQvYlRJbkxE?=
 =?utf-8?B?S3VYNlpoeG9qYW5UWWQyQnEvV1MvQWg5UlJwSlFLbzNlVnF3VFV5MjdTUjBz?=
 =?utf-8?B?NlJod2piQVFkazBCM09FQWM1NGNod3ZKd3dzV1IxSHU1c29YVnR0RlZyb2NS?=
 =?utf-8?B?K00xVmh2bWRaSzR0MHpBcUhiVkRFZkQyUnlYWDJhRzFJVXI4WXJNcjEyd3pn?=
 =?utf-8?B?aHE5dzdMQTBxZzJ3blVRQXR4THh0LzNIQ2Jqa045ZktxU3RyOGQ5R21WckJu?=
 =?utf-8?B?SnNkb3YxUGZsaXNEdlZ0YXVWbWRvM2c1Q1l0VmE2M1FmcUlUQitrRTFmUVZM?=
 =?utf-8?B?OWZkR2xmdmF1TVFHeWpEZXdUTzNDM1pCcHE4RDVNNU1UL3JSdW5WM3pFOG03?=
 =?utf-8?B?bkpPNXAzM0luQ3plY3Fsc3dhMk9WRHdzMHdHUEk4d3BxUmk2UTA2OE9oajNx?=
 =?utf-8?B?SXhqS3lnRVFnOE54cVNkdWpVaEZibHg0K0tNRDFZUFA0UDJPQlNOMjNvUDNL?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7092CA2112838469F393D419E67E8B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8451fb68-0d4f-4585-5532-08dc5307e18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 11:27:29.3351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiDKgUxDhy2MgaZeVk8+y1EnS47/jLgG2engsheJmig59s1BHEIsrQ5I3+Df6MMMr+SMLWEHJ8PcTPCluIhuHHhU0L8O7MKYtLGqRy63lsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145

T24gMDIuMDQuMjAyNCAxMzozOSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gW1lvdSBk
b24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmcu
IExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0
U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+IA0KPiBPbiAwMi8wNC8yMDI0IDExOjEyLCBBbmRyZWkgU2ltaW9uIHdyb3RlOg0K
Pj4gUmVwbGFjZSByZWd1bGF0b3Itc3VzcGVuZC12b2x0YWdlIHdpdGggcmVndWxhdG9yLXN1c3Bl
bmQtbWljcm92b2x0Lg0KPiANCj4gV2h5Pw0KPiANCg0KYXQ5MS1zYW1hN2c1ZWsuZHRiOiBtY3Ax
NjUwMkA1YjogcmVndWxhdG9yczpWRERfKENPUkV8T1RIRVIpfExET1sxLTJdOg0KcmVndWxhdG9y
LXN0YXRlLXN0YW5kYnkgJ3JlZ3VsYXRvci1zdXNwZW5kLXZvbHRhZ2UnIGRvZXMgbm90IG1hdGNo
IGFueSBvZg0KdGhlIHJlZ2V4ZXMgJ3BpbmN0cmwtWzAtOV0rJyBmcm9tIHNjaGVtYQ0KJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9yZWd1bGF0b3IvbWljcm9jaGlwLG1jcDE2NTAy
LnlhbWwjDQoNCm5vIHByb3BlcnR5IG5hbWVkIHJlZ3VsYXRvci1zdXNwZW5kLXZvbHRhZ2UgaW4N
Cmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JlZ3VsYXRvci55YW1sICANCnNvIGlm
IGl0IGlzIHVzaW5nIHRoaXMgcHJvcGVydHkgdGhlcmUgd2lsbCBiZSBubyBlZmZlY3QgYXMgaXQg
d2FzIGV4cGVjdGVkIGluIA0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1p
dC84NWIxMzA0YjlkYWEwNjM2NzEzOWI0NzE3ODljN2RkYjc2MjUwYjlmDQoNCj4gUGxlYXNlIGV4
cGxhaW4gd2hhdCBpcyB0aGUgYnVnIGFuZCBob3cgaXQgbWFuaWZlc3RzIGl0c2VsZi4gSXMgb25l
DQo+IHByb3BlcnR5IGluY29ycmVjdCBhbmQgb3RoZXIgY29ycmVjdD8NCj4gDQpUaGUgbWFpbiBy
ZWFzb24gaXMgZXhwbGFpbmVkIGluIHRoZSBjb3Zlci1sZXR0ZXIgYnV0IGlmIHlvdSBhc2sgbWUg
dG8gZXhwbGFpbiBpbiBlYWNoIGNvbW1pdCBJIHdpbGwgZG8gaXQgaW4gbmV4dCB2ZXJzaW9uLg0K
DQo+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZ
b3UgY2FuIGdldCB0aGVtIGZvcg0KPiBleGFtcGxlIHdpdGggYGdpdCBsb2cgLS1vbmVsaW5lIC0t
IERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUgZGlyZWN0b3J5DQo+IHlvdXIgcGF0Y2ggaXMgdG91
Y2hpbmcuDQo+IEhpbnQ6IHRoZXJlIGlzIG5vICJib290Ig0KPg0KDQpZZXMsIGluIGh1cnJ5IEkg
c2xpcHBlZCB0aGF0ICJib290IiBpbiBzdWJqZWN0Lg0KDQo+Pg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCj4gDQoNCi0tIA0KQW5kcmVpIFNpbWlvbg0KDQoNCg==

