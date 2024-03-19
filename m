Return-Path: <linux-kernel+bounces-106884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CA187F4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C871C21600
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6BA40;
	Tue, 19 Mar 2024 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XcH70Idj"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E2A38;
	Tue, 19 Mar 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710811362; cv=fail; b=oKQr0tuiCUft42g+kBSqI4j/ZB3c94ghk1aCY/CgYcs2XnpxOExi4dETBIma4UTEhjR9r5KgwvUJBelhj0zeCF5W0quSo8v/hgY/e/4aH51fkdHumLIPOrPQpQB0Sr0dLUX91C+NhnwOVyBstxcM7591gmNLflTUbdnKEikn9WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710811362; c=relaxed/simple;
	bh=LjiwoOux+DU552k9hqA5H0eveclLY32/pyzwRSJ/5zM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lnonnqOeGKK1gRE0igpYLC18bcQVwHB00Ur8w6FO4nbqPvgUhzQWnA7kY++FpvoBmNYzpMuv3Ydhk5TlQPlMaXx1u0o7Zw36a2pN7Pb1eO3DQSnr2fg0SXr/uipwCgXd1mru77MscgNjv4v51VMpWvDO3wfS94hdQow0Tz9DR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XcH70Idj; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710811356; x=1742347356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LjiwoOux+DU552k9hqA5H0eveclLY32/pyzwRSJ/5zM=;
  b=XcH70IdjwDR6k8YkBdOPeFUZTZOJo0kBR3B4kES4VX7+QPfGDvOSaWsz
   KXPB451ZcMaAYZS5KfpPoTrtEqPnEaVsy1SQY6Redsk3hJyHLokNMT/hi
   5N2kahY/GohILM+goxcQAJXFqfCnB/0qrugyml9x3MxpOEsEyMtLPIRtB
   nBWya5SPxNcVZ/V+nJO64KaUY6slNk5YS2/rU/krT2zz+BUAd8TOGVorx
   m/H3TZsqnl2jDQvxjl3aPBy8YA3gTcQ8OEfaKqNXPWYC0ZbfFgKyujvoQ
   dhwdWMh036bDZjfaHJnFikEqsrIqP45J0FQu3OOjHBpX2/2tqUpVgPtMk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="27355330"
X-IronPort-AV: E=Sophos;i="6.07,135,1708354800"; 
   d="scan'208";a="27355330"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 10:21:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7QocMomUZ31BQ7Cpwqs2iU2eYdhlr4DrNCs8DlGiNyyDuKoNcHEzqQ4fQX2tzd5ow8yV4cAwYuEVcMn6wq0bmmSqNSG8XbbX2kXj4CrTPP9HCcnxOqVSz97heBPCVWbRsm+VTZBmrGO66V2Oi0Bs/+HCPkDKmPHo+WQK3ivZ8077db4LLsFZX4wZ6O7P2dp/7NEzMzFps/CdguO5bjB/1wQkn0NKxw0GlATXZhvy7dyreu1EkfaXEye2EqVDiJi66a9tSkK+F6H5gPNGH7EnhrQVSR0pz4VhTtr/vuNyfc5bq496g5YkgYl7rv/S2fl6jx+qBuv9Izurpe7o5UjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjiwoOux+DU552k9hqA5H0eveclLY32/pyzwRSJ/5zM=;
 b=oHL9NZ+mT6VNyi/DaG9GmfFbFxXfbxJ6qu4mMiCqrIU9mbvrlhBoodGGbUazuDonZVqnRsLP6cXGZQ9G3txWzdcSfhl5AHfviN6OEYxm54NhJcmRUv9dIkly9SDjl3lnYYIUJe0s9UfuNiBAL+cGkiMFT5Mjjplh2mfTPo6S9wO0TQq+Tsd8Bn/z/mRtouFo62wka4XgdHArOEVyxdmnY7oSYUzrp6JocfTRyU0+nb3y8AzBwbEv9vaOpX5iz1eLDlLpY4E1319QauDkUVWJc8m1C0IiKp0lUYNJ02SN1OME1WQbcHWk2w4R1+gU5pZq9rnaM2xxACGxFVcyiq/WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OS3PR01MB6950.jpnprd01.prod.outlook.com
 (2603:1096:604:12d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 01:21:20 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 01:21:20 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>, Jiri Kosina
	<jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] HID: hid-picolcd*: Convert sprintf/scnprintf to
 sysfs_emit/sysfs_emit_at
Thread-Topic: [PATCH v3 1/4] HID: hid-picolcd*: Convert sprintf/scnprintf to
 sysfs_emit/sysfs_emit_at
Thread-Index: AQHaeNOh+/PyJbDYYUqbphdIT5em2bE9z4IAgAB2VIA=
Date: Tue, 19 Mar 2024 01:21:20 +0000
Message-ID: <efe64892-2f6f-4629-ae0b-d82c0fd4c7c4@fujitsu.com>
References: <20240318012819.1405003-1-lizhijian@fujitsu.com>
 <588c9ba0-fcec-4700-a577-b604511f22a1@wanadoo.fr>
In-Reply-To: <588c9ba0-fcec-4700-a577-b604511f22a1@wanadoo.fr>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OS3PR01MB6950:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gZezHaC2FksSh0SDQG9nMMg3d+FQVLFG/HKQhmWsyUShC4ZJAJwigy6Nw2xb527r6Z1S72Oz0xOYTqE08J7a2vqe08rBR7GtDxL6MlrkcWyPcNU6iSlghgzw8tMnMXtlj+jiKzlz9Aj2LBZ3ngSt0DrjLXAHmgS+sxcJ9r1SJsUI+UDMz6tr0bWdopEYT50Zb7BfRUW9BGxgjT6Akw4HX2amsAQMCw8BjZItYSxnC8Ho2sJhR7m+eWx5MJZuq5A8IpjbmijtB/LoEeU7K5uO1B9nybT2J/j8QEM1hWhVn7G3yp3yabifcX4YJQjFRraaIgOJWqjTdkLWAqlY5Y9bEAGiEt9/+o8pPqrO1c3CU5Ctit6xcalDn1kKw9eC9Rps85PH0V4A8LnHNcPL9niCO8SUx+ziG2hmN7ftJmjYFC5iGIwdT5b28McnXGe+LUW4SysLSdukD9FuimuvaUp56WyPTcS2B1YY0yIwtwiw6HuuzC69N5Owm1qbwTCL/YDzgCzR8Yb7BLPdk/+3Qnona1QiNSqXcmGYNaCvoos2HXrC114/O+mmi3o5Mb1hr8F8tLqLAh5ZVUq+tCrbWE4D9P2RbXGdjtEi8CHuUwW3tOqzG16Kekddte7H8eDNSXeGHh+J/r6dKRaKtflM54DGbZ+aZqKfNDHjhUR4gEeSHzE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjZRWGxoMG5EaUZwMTMrdVBmUkl3c3RCSmFNcFV3UWVVa2NSVGJXUGZQeGcx?=
 =?utf-8?B?aGFXNEUvdlRtY0pWOFdpZitsU2JsZWFTcFZTOU5TYmx0UkNqVGRRZXh1RnZL?=
 =?utf-8?B?Vm5HRmxRWDlVNnlUKzNMVm1oUXAvZkIyMCtXNkNSM3J5YjdGcUZ4clBKU0hq?=
 =?utf-8?B?c3A2eVF3WkZNSnkyR1hheTFWd3NhSk5iYktaZUpiTll2ZnZka0NPdzZUMkQv?=
 =?utf-8?B?SG92cFVqaGF0cEtuamVzVkk3VHpibEVOeUZOQnBGbVBrN1NIWnBoSjUvajVW?=
 =?utf-8?B?bzJYWUI0VnZjSVZKV1RFcmdkYXJnTHY3d21HOE8wc0FQcUgwY1JjN29pbzIx?=
 =?utf-8?B?Q3p0WjdVZzI3ZXhNY0hSNkxkSVNVS0tzZGRHektZZlk2OUxMaGRCK2toY3hR?=
 =?utf-8?B?TDR5eUJjUlc2Z2VWTU1ad0Z6VERSNG1qSGhYa3EyOG1tRTRmczUvaThEcmlZ?=
 =?utf-8?B?NUlya1p4cnJoNzFvcHBycVh3Q0o2NjJhSTJ3blN0RnNHdkFLSU9UWjNHeHR6?=
 =?utf-8?B?WG1yV2VMbVlqL0FOWVl6UTkrdlBuckl1U1FFUE9CeVl6cHRKRUFiN1VEeWlF?=
 =?utf-8?B?dktYV21sa1JEczlVVFFMMUJRc21zNTM4UGoycnJhZE4wK29jUENtS0lHL2po?=
 =?utf-8?B?a0dBU3FtZW5xcWlUTDh5ZVVlemlUMmRIMnN2OHlWWWl1ZmdVbjJ3NU93LzdZ?=
 =?utf-8?B?RGl5RHhWaFpQd21qVjZicmp5QVdzVE9WRFJJN2xIMW9FT3kzM0hEU3cwSDI1?=
 =?utf-8?B?ODVwZ2M5UUpXaUVESzRTQjlIUTVxZ2QxQnpaWHpVN0E0cjZRMGNMdHo5UmZ5?=
 =?utf-8?B?Z2c2bkVZODhwMExqUDFaL0NFeXU5UUIxN3ozMCtta2NZcWRIYTVFUG1VdHlD?=
 =?utf-8?B?elJRS0pCTGN4VkJWN0dRSjRISkVNdG02QUUvTUxOQTdibEhFd3F1R0FuS0ps?=
 =?utf-8?B?MVQ1V1I4WFdSc1hhenp0c1h4T05rU1YzYWVXbjNrUFFDL3hvaEJBOEhMbDc1?=
 =?utf-8?B?RDNTNWZpcmpjWmk4OVRjSG94akZwQjY0bzk0bm1tYU83TjJkYUNPTTdsQlFE?=
 =?utf-8?B?NXFSRWozVFM4K09iZTdRZmxpcjBmOCtUbnVhVXYvdWJZdnlBUkloZDQ5VnpK?=
 =?utf-8?B?aEQ2TXQvUXNvZmtLbUFoRnY1aTRobUlFa2duMGJEZk5uTXR5QXdmVGFWQjVI?=
 =?utf-8?B?VVJNRS9vdTJZZWsxZ3p4QmRYeDFVRkFySHM1WC8wQXZYcUNMZ2NsRGNZejZi?=
 =?utf-8?B?ZkQyZDZZQnkvZllkYTFUK0RDdTVCYVNIeHZaL2NXaWhGOUUzdzMwMDFIb3hB?=
 =?utf-8?B?YTJlNGpxVnJvTGduRGNKRlc2VjhvV09rOFVBS0REVWk3SWI3b1NCZDJqeVlH?=
 =?utf-8?B?b3hHZ0VzZXpUM3FqSXI5S1hjYkJBMHRtZmtIc1BBK2pMZGdJbS9tY04zU1Vp?=
 =?utf-8?B?ZU42L0VaR1g5V2doUWpzQXo4bUFkemUwd1R0ZlFaMWNMZkMwTWNlUm81VWlY?=
 =?utf-8?B?elBGcS9rd3B0eHRucmZKaDN3N0c3YXRDN0hDZGNVUVZiSTFHTlhPUHQwOURB?=
 =?utf-8?B?QkNOMTJKaW1tb1JGVW83dWlIVmxLd0tBV0s4R0JkcGVhU3E1SkRHaEJ5bFZm?=
 =?utf-8?B?SFhQNW1IMWtlWmdndUcwRHl4eVRCejB5alFCNHd1RUJia1dISU1mRGxEQWtP?=
 =?utf-8?B?YWZQV2M0NnlMMS8yNFZaMHlSWG5tbEtDMGlGSmVCcFJIVzk2ZkxvSjVtNWFX?=
 =?utf-8?B?aFljY1FJanBFTjZKdEw5NWdnTVlmZjJsdlUyTVNXQ0J6MHB0MXFCMGE5MHZr?=
 =?utf-8?B?NzdEOGV1ZGRzRU5Ua3JjZUdvaVluMHlvQm9FZy9oZ0NXeTZWVzFmQWx2YUhJ?=
 =?utf-8?B?R0ZPcWFlS1ZHMko1S0dOam8zY05UWnpwWVJ3K08zZXRzUFAyVXpNWFBPWU52?=
 =?utf-8?B?VjRwU01PZ2ZzQ1BkRU5tK0lLcmdFRkdRdVk2TGJqMEdjVE9JdXhmZWpYcmZi?=
 =?utf-8?B?aGNlYnRlN0tsRU4yZndtR09ObW1CdktSQWlkV2ovdmFrN1FaZDBWQ0NNU05Q?=
 =?utf-8?B?Vi9NK3o1Q0RRb20vVVltU1ZCNDJITjZMcktXWWFjQ1l1K21wK3ljb0FuMFNY?=
 =?utf-8?B?YzFEZTU4VjlXeWhqWEVqWUgvdWpvOGt6alZlL2FjSWRYNXpNWDZoMHNGajA1?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A61644678341A9449C2F74DED42CAD27@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8mIP5M/hGaMGpbkJI49BTjKlKbbxDJXDJncwDIpv1pgdclgbW2xWWh1YS3R0sGYdUB6uMxZzpG6cX2YOyMX6RGBW0R92F9VxOpchn36BXNlvyVAl2+cdC1QY+GK3ATvii5ChGteKrrwVgM9qv+IEqOPqwhmKcUj3fPnCuGJ6cOFHZgRfTUWcWc56+T3t7czNtoJ8JLKk0NkOWFKwdFIyqu8VKPao9pf7dfsoC7z+9XhAEMzObhaPCONLzDXM/cFtgRJrSDgXNgTXn3Decgx+BEJKyCfnQyB+gFTSUlxpXUHPMs1+WDYgICrNFtzslh2P3oGLNP8pUBFSFr/iwqwBgcoM7C/u+6zHSmMM57vdN5jTrOWWxlYB6PvdNyd7M9dXwCX2besN578MskYkvv7Ma91aeFMpPIECONRWgyOdjKy8k1sTCRSwqQK/O4HgjcoElWFoDvqMfy+PGfyQJqrHIeHV7OOCn9Zxdr9s+e2DZTIt/0LuMzhtwnHGDVvetgc4CjCom2Ouqub0tlNhFQytusIVWCGi4naQOWhwtc2ph+p09DGrVh/gKoJ4ekk3rQDIpe36PH1nmgjK6p/gmhYOCw7N/pJAuqCRP6R/nm02fYN0U9hRPUOEjnGFNimvbVB2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d5270e-5c6c-407d-a3e5-08dc47b2e25a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 01:21:20.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xqY+R+QLiTRm3CbhUPhccm0axu7qTfwxbMN7kqT348cd+1dj2yHpDNBiuIcj5+jZbPi7n6aw5IQJuJDXRLZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6950

DQoNCk9uIDE5LzAzLzIwMjQgMDI6MTcsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4gTGUg
MTgvMDMvMjAyNCDDoCAwMjoyOCwgTGkgWmhpamlhbiBhIMOpY3JpdMKgOg0KPj4gUGVyIGZpbGVz
eXN0ZW1zL3N5c2ZzLnJzdCwgc2hvdygpIHNob3VsZCBvbmx5IHVzZSBzeXNmc19lbWl0KCkNCj4+
IG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZhbHVlIHRvIGJlIHJldHVy
bmVkIHRvIHVzZXIgc3BhY2UuDQo+Pg0KPj4gY29jY2luZWxsZSBjb21wbGFpbnMgdGhhdCB0aGVy
ZSBhcmUgc3RpbGwgYSBjb3VwbGUgb2YgZnVuY3Rpb25zIHRoYXQgdXNlDQo+PiBzbnByaW50Zigp
LiBDb252ZXJ0IHRoZW0gdG8gc3lzZnNfZW1pdCgpLg0KPj4NCj4+IHNjbnByaW50ZigpIHdpbGwg
YmUgY29udmVydGVkIGFzIHdlZWwgaWYgdGhleSBoYXZlLg0KPj4NCj4+IEdlbmVyYWxseSwgdGhp
cyBwYXRjaCBpcyBnZW5lcmF0ZWQgYnkNCj4+IG1ha2UgY29jY2ljaGVjayBNPTxwYXRoL3RvL2Zp
bGU+IE1PREU9cGF0Y2ggXA0KPj4gQ09DQ0k9c2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9kZXZpY2Vf
YXR0cl9zaG93LmNvY2NpDQo+Pg0KPj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQNCj4+
DQo+PiBDQzogIkJydW5vIFByw6ltb250IiA8Ym9uYm9uc0BsaW51eC12c2VydmVyLm9yZz4NCj4+
IENDOiBKaXJpIEtvc2luYSA8amlrb3NAa2VybmVsLm9yZz4NCj4+IENDOiBCZW5qYW1pbiBUaXNz
b2lyZXMgPGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tPg0KPj4gQ0M6IGxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiBWMzoNCj4+IMKgwqDCoCBDb3ZlcnQgbW9yZSBmaWxl
KGRyaXZlcnMvaGlkL2hpZC1waWNvbGNkX2ZiLmMpIGFzIHN1Z2dlc3RlZCBieSBCcnVubw0KPj4N
Cj4+IFRoaXMgaXMgYSBwYXJ0IG9mIHRoZSB3b3JrICJGaXggY29jY2ljaGVjayBkZXZpY2VfYXR0
cl9zaG93IHdhcm5pbmdzIlsxXQ0KPj4gU3BsaXQgdGhlbSBwZXIgc3Vic3lzdGVtIHNvIHRoYXQg
dGhlIG1haW50YWluZXIgY2FuIHJldmlldyBpdCBlYXNpbHkNCj4+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjQwMTE2MDQxMTI5LjM5Mzc4MDAtMS1saXpoaWppYW5AZnVqaXRz
dS5jb20vDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4+IMKgIGRyaXZlcnMvaGlkL2hpZC1waWNvbGNkX2NvcmUuYyB8IDYgKysr
LS0tDQo+PiDCoCBkcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9mYi5jwqDCoCB8IDQgKystLQ0KPj4g
wqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1waWNvbGNkX2NvcmUuYyBiL2RyaXZlcnMv
aGlkL2hpZC1waWNvbGNkX2NvcmUuYw0KPj4gaW5kZXggYmJkYTIzMWE3Y2UzLi5mYTQ2ZmI2ZWFi
M2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9jb3JlLmMNCj4+ICsr
KyBiL2RyaXZlcnMvaGlkL2hpZC1waWNvbGNkX2NvcmUuYw0KPj4gQEAgLTI1Niw5ICsyNTYsOSBA
QCBzdGF0aWMgc3NpemVfdCBwaWNvbGNkX29wZXJhdGlvbl9tb2RlX3Nob3coc3RydWN0IGRldmlj
ZSAqZGV2LA0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGljb2xjZF9kYXRhICpkYXRhID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+PiDCoMKgwqDCoMKgIGlmIChkYXRhLT5zdGF0dXMgJiBQSUNPTENE
X0JPT1RMT0FERVIpDQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFH
RV9TSVpFLCAiW2Jvb3Rsb2FkZXJdIGxjZFxuIik7DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHN5c2ZzX2VtaXQoYnVmLCAiW2Jvb3Rsb2FkZXJdIGxjZFxuIik7DQo+PiDCoMKgwqDCoMKgIGVs
c2UNCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICJi
b290bG9hZGVyIFtsY2RdXG4iKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gc3lzZnNfZW1p
dChidWYsICJib290bG9hZGVyIFtsY2RdXG4iKTsNCj4+IMKgIH0NCj4+IMKgIHN0YXRpYyBzc2l6
ZV90IHBpY29sY2Rfb3BlcmF0aW9uX21vZGVfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPj4g
QEAgLTMwMSw3ICszMDEsNyBAQCBzdGF0aWMgc3NpemVfdCBwaWNvbGNkX29wZXJhdGlvbl9tb2Rl
X2RlbGF5X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgcGljb2xjZF9kYXRhICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiAtwqDC
oMKgIHJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVodVxuIiwgZGF0YS0+b3Btb2Rl
X2RlbGF5KTsNCj4+ICvCoMKgwqAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWh1XG4iLCBkYXRh
LT5vcG1vZGVfZGVsYXkpOw0KPj4gwqAgfQ0KPj4gwqAgc3RhdGljIHNzaXplX3QgcGljb2xjZF9v
cGVyYXRpb25fbW9kZV9kZWxheV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfZmIuYyBiL2RyaXZlcnMvaGlkL2hpZC1waWNv
bGNkX2ZiLmMNCj4+IGluZGV4IGQ3ZGRkZDk5ZDMyNS4uMzY5Yzc4ZDcwZTY2IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfZmIuYw0KPj4gKysrIGIvZHJpdmVycy9oaWQv
aGlkLXBpY29sY2RfZmIuYw0KPj4gQEAgLTQyNCw5ICs0MjQsOSBAQCBzdGF0aWMgc3NpemVfdCBw
aWNvbGNkX2ZiX3VwZGF0ZV9yYXRlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiANCj4gSGks
DQo+IA0KPiBqdXN0IGFib3ZlIHdlIGhhdmU6DQo+ICDCoMKgwqDCoGZvciAoaSA9IDE7IGkgPD0g
UElDT0xDREZCX1VQREFURV9SQVRFX0xJTUlUOyBpKyspDQo+IA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChyZXQgPj0gUEFHRV9TSVpFKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnJlYWs7DQo+IA0KPiBhbmQgUElDT0xDREZCX1VQREFURV9SQVRFX0xJTUlUIGlzIDEwLCBzbyBp
dCBpcyBub3QgcG9zc2libGUgdG8gaGF2ZSByZXQgPj0gUEFHRV9TSVpFLiBTaG91bGQgaXQgaGFw
cGVuLCBzeXNmc19lbWl0X2F0KCkgaGFuZGxlcyBpdC4NCj4gU28sIHRoaXMgdGVzdCBjYW4gYWxz
byBiZSByZW1vdmVkLCBJTUhPLg0KDQpHb29kIGNhdGNoLCBpIHdpbGwgdXBkYXRlIGl0Lg0KDQoN
ClRoYW5rcw0KWmhpamlhbg0KDQo+IA0KPiBDSg0KPiANCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBl
bHNlIGlmIChpID09IGZiX3VwZGF0ZV9yYXRlKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ICs9IHNjbnByaW50ZihidWYrcmV0LCBQQUdFX1NJWkUtcmV0LCAiWyV1XSAiLCBpKTsNCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCArPSBzeXNmc19lbWl0X2F0KGJ1ZiwgcmV0LCAi
WyV1XSAiLCBpKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXQgKz0gc2NucHJpbnRmKGJ1ZityZXQsIFBBR0VfU0laRS1yZXQsICIldSAi
LCBpKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCArPSBzeXNmc19lbWl0X2F0KGJ1
ZiwgcmV0LCAiJXUgIiwgaSk7DQo+PiDCoMKgwqDCoMKgIGlmIChyZXQgPiAwKQ0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGJ1ZlttaW4ocmV0LCAoc2l6ZV90KVBBR0VfU0laRSktMV0gPSAnXG4nOw0K
Pj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA=

