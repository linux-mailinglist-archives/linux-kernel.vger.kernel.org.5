Return-Path: <linux-kernel+bounces-103137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5387BB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8963F1F215BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B46EB4E;
	Thu, 14 Mar 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CZMe9Nab"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7165A0F8;
	Thu, 14 Mar 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412834; cv=fail; b=LPUTL/bsRmzPBDUGPD0f7ABQrUS825Bi7Ocvh2QNOk2V+jJKFPpAdSK/Dt1roMG9rLuAV4Ot+umbL87YMdzp8kAp+hoWpub6TEIy0CeToxzryiqoK0BVeeXOzeNZZP3PUXaRhFYGlT8XxLz4mFXYX63k1MH9Hd55Mhn4J8i4S+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412834; c=relaxed/simple;
	bh=XYG+Zx/jgzs3syCxoBgbmc5mQkKTjDYBovZkDGQvXvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BIwNCmSDSWROLohRb8CbxIEOHR7vFrUHVmT/qMagPoCQtwT7Sld/Y7myIyYWOo8odtQRMO+DCd5yc6QQQU7vCtit4ofeQwIoC7/7glhswCPHGpu5TsyYoATppgyV75MbukD937UIxN4wjNAaLOLrhXI5LGqNEZTQ8n+S/cHSi4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CZMe9Nab; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710412828; x=1741948828;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XYG+Zx/jgzs3syCxoBgbmc5mQkKTjDYBovZkDGQvXvY=;
  b=CZMe9NabVCkEqihSq9Ea4FCVV6pAyHxP9U1DOvWnjYs/Ez3fYpZ1dVrh
   uNG4ssFtx9WrNWgHNk8+ujI1ibFSoaRrFWNXlgvFTcrODps5DDGQLBSJO
   txZf4RcX8whgtIL1YaiihBR2xy9rY3w5Qio2kHopTBpzTl0uGV/kxdNsR
   221CSPFo6EuIox2cfhYmEfRx3EdfiszMo8jKgRY5ekwqxkndk2BY5vYo+
   HHf8/XpWFqUhXX6BlX3Zi7gf8z9rOWhZMV59FGmULWvIP+YXTEHhEjrep
   zBbkYxxhzjIkGHX4Id2SHCjQxb40HEMzSFV+3wXiIdLfJstb+Ubiz2bmv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="113620210"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="113620210"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 19:39:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MA0xl30HbZD2VldLlQ0WalqoRVJmR7wHpyNBdXP3AiJz5XFH7PJh1fzoFN+6TSDQKMY7f1N11Rotz6Fhxm9fU2JAlrQVbyOApMkZKlzACr6yAaTXE8XMCJIVxHgiqpZ0a/9CzrtBNl7Tj7a8u95Zy5lDvJyO2PGA0+KO89x8i8m1gnhgNNvNEFV1SW/RgX2guUEoF9QtDNXvTFBEHRZh3noF8OdcbPeGzaIHvwvqNU4zJ1UqNM98bn2Rt2eZYnPAO7V50/fKNkBzxSG+Fdp6ECbLkkEg5i2HAHazAQ2yvmB//UK5UCtRo+cNvykZt4opsXm7waNU3EDUwo2UCaHPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYG+Zx/jgzs3syCxoBgbmc5mQkKTjDYBovZkDGQvXvY=;
 b=B76230iAx8DLCo3cQ4O4dBqhyLs9URnQDfST0WUOIKWFVFe6CjE3mmCE6giSPD+jc+T4XQpIMp1LZS24+5Lj0KBqRgdv1Y3IoQ4b+0ITCG6TxeRYByy2HxrlbP+mvDeSL1KGDkCc1ihUeNSrsGKUcSZg3UdxEfJI8BCAup8+UxzYQ/L11r8OcLhkJ3oMsiL7yduxAEDhfWqB8SSQAzk5mBWD+Io79YJr1PHwsCqFiU8uiWPFbQcO67/TqDxhXYMXlv0puOlUwDx4HQVuFjX9fG4H1duxnu5n840Hik1c8JeTh9XAlbHuueEqRrx0F7gBq0IP+RBf+MTpnyUx4tv1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYWPR01MB8526.jpnprd01.prod.outlook.com
 (2603:1096:400:13c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 10:39:12 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 10:39:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] HID: hid-picolcd_core: Convert sprintf/snprintf to
 sysfs_emit
Thread-Topic: [PATCH v2 1/4] HID: hid-picolcd_core: Convert sprintf/snprintf
 to sysfs_emit
Thread-Index: AQHadexhfswEuz8eLEWSWWXLQmFAmLE3C7MA
Date: Thu, 14 Mar 2024 10:39:12 +0000
Message-ID: <04f70a02-f507-4aaf-946c-410376ae35cd@fujitsu.com>
References: <20240314084753.1322110-1-lizhijian@fujitsu.com>
In-Reply-To: <20240314084753.1322110-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYWPR01MB8526:EE_
x-ms-office365-filtering-correlation-id: e157c6f3-c1e5-44f7-f1ad-08dc4412fcee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1zjOSb3W1efrYpf2oRpw0A9PGb3GBjNi7oBDnUkCU4es1aaWhOYHRb2ukTVvTpXRhIGh6HglgN1tL5sA5dtOOdwoXbqEmVyA3jxSVTtGHd47zrMHjTdBXaSaMrdnpSUU5ev61qq4r+LOQgGQ0MJPjkKVQLQFB0paXjfsKxqL6l2hPP8uKRIkQjENv00WzinlFuqmCTSYT5XhwakYpg/7mWqN16DfgatZDUhlnVdWGN3ba07xc2siFruP3oRjqQ7x4QlOYSA6M+KPPi2K5e2z/9Me+hg4/18ERb+5167EroPdfBV5gBaw+oQzALAic3q56NY4OtkoB9HPMRRLk9ghGWpuf5m8TI5lZSgWRxa5R/GGCPawFoaJycvgyufoBvz7KUiFsK6dmHvgecoFgQfyWI+sLnG5LlQTsjaF7qrouMDk74aoPHBdWXPvkQK91OqCALjClrGbge9IKxjLYDKulfIdLFogehS+rHpcNK/DU3bwFYsLrciI4WYIh5w2ku8LCfPDAr6FGfEuESOMQnVxFvo0DSDXg7Irlbfz3Z5wz+glReSTykbaUgRqY4gXsL1NK73WJ9NSxVQ5LIx2oXkJRZbnmK2gTr1XTH/Lwt3f58JVeiYJESGUnIhxqvxYqIixnvIZZDgtJoEi2gbjHgwuwQk+iKHhcrtS1f9nwzg90k0bIoOZWBClmNekC7UBXn4p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGhVOVhwM3hsNTMrSWJaK2VUTmNjWDRxV0lzYkZXUUl1MllqY2pkVTVSQnQr?=
 =?utf-8?B?MklaMVUxeTJjdXlmczFoTnFpVTBpWTNlZVc5MDF3eERSTzJwcVBaQ3NpRzNr?=
 =?utf-8?B?S0srcDRvc1F6bFpFSkJOZUZYM25lK0tsZWVPMHJpSnZTM1hQdjczTmlIeFBO?=
 =?utf-8?B?YXJlUEtFNnZBRE5wMDZ1TGIyUXY5UWI3enN6M1BQL0FOL1FORE1MczdvUXdm?=
 =?utf-8?B?bW1uTGllRE10YzdNdnFsakt6NVJrdXpJZDhXekIrNDRMUGpjNnRMYjVMWWR5?=
 =?utf-8?B?VzN4N1hOVC9Gc3U2aGlZMytzc0NNVkwzK3NKNzV5eWlPazZrYTVybGlaQ3lB?=
 =?utf-8?B?UzUwTTBFTkxPYTJ0Zyt5elgrNE13RXBOemppdFMvVkdaTDhOcTErcHRUZjRU?=
 =?utf-8?B?enBESTNtNDZTSktrTSthK3U0ek9rQzdvcmc3S09NbHpWaE11d25jdUJXeUVk?=
 =?utf-8?B?cGtmZE1laXJ5VWdZTWZndEZlVlp4eFhUWVZpUXlDQVZYZE5xMUZsRm82bDFa?=
 =?utf-8?B?VnNvT0ROSzBGVmpoczlLanZWcnN5VEVRM2hITE9LblFWVnhBTmE4aklJWmZG?=
 =?utf-8?B?VUJSRjQ2QUtBbEsyTzl4OURhNVA3NTV6TVdTWE5NalZ1R05kQ0Urb2t0Tm5N?=
 =?utf-8?B?aTlha05BbjN1bmpwbWM0dlNPclhmL1o1a2VCUjVWc2lLdXMwODMrRXBsYmtI?=
 =?utf-8?B?TnB6RUtDOEwxT0JRbUhuY3pQYXRHS0Q2cVJnMXVCVEVFS1pVMGU0OXZEUmxo?=
 =?utf-8?B?SzcxUHdIZGdqOWJhb2M5ZXI3MTVRR1ZDbFNjd2RDam16NktqdUF6MEpIaENk?=
 =?utf-8?B?cGRCZnhubU1zQnZhcXVEWXJZNk9wMFVtUTRqSkFLUWhtbWRMbG1FeDlBM1Bw?=
 =?utf-8?B?MVFQL0FNWG9mditCbldrQ014MzBHSFlZeDI5K1RmMVpzZ09EWW9tdGpETTAr?=
 =?utf-8?B?RkFZRTRia2hYd2ZyL0grdUFlbDZBVWh5cjE5NWFENTRkbFhxSkJIelJDUEc2?=
 =?utf-8?B?U21DaU94WTludkNDVlY5RW9nVE5Sb1dETjkvc3JNeWZNRFl1TStrblRCckJp?=
 =?utf-8?B?VVJqQm94Y3VnWC9KNjJwMWw2bzhlTU1lcHo1a2dCd2NNQXdSNEVLSUdUQ2Vx?=
 =?utf-8?B?NWl1Qmt3SGorZXRVT2t3clI4ZjA5dW1xdlpYQ1RXRXpDLzZqSkViT25GbG1C?=
 =?utf-8?B?bWtRcVRoNGlmSDdnVUNXN3hrSmVRdHhIUFlPMXVWSC92eFduL2hLdVpCK1My?=
 =?utf-8?B?MXk3QWlDUDlzYjluUTFUbVVtWGVPazJwTEROV2xHTGJockcyK09pN2wrdlQ0?=
 =?utf-8?B?SC96eENLVmhzYnpOcEwyT0xBZWllRWk1ZU8vTFI3ckh6eVg3YTFwS2N1UU9s?=
 =?utf-8?B?UkhRYktHWUVSdGtMNURJWTFxSlNJNzRBWnBFNXhkaVJaTURKR2Qya09BcDAx?=
 =?utf-8?B?YkdrK1pTQ2FwdGxWekpYVWxXSWdYK3hkR1lYSndvZ1ZPUjNLL0lUeTFjcWlr?=
 =?utf-8?B?NjQ2R0NxU042ZEtuRFhMdmt3RSt6clZ6aFhIeFYvaG9pT1Y1c0JoRVlhbXg4?=
 =?utf-8?B?aXdMTytTWnpIRnhsL0hVbWFJUDVKK0lpc0taU2xwRXVsMjNFZERPRGlvSi9J?=
 =?utf-8?B?SVQrbHJITU5HV0lwcUlORzBFbjdiLzl5d3R4RXFHQWVXRm9MZFp5aS9vQ1hh?=
 =?utf-8?B?alNoYngzRUI3bnRBMDFoV01NaUJzKzhPUXJtc1pLNUxXWEdnT3IvTk80SDlW?=
 =?utf-8?B?NVFtUDVtOHBidEdTZFQwT3VzS3p1dmlsbDE0aW5xbTRlK1plb1hBZXdOQmF2?=
 =?utf-8?B?SUtpSEl1Vms5RVlZZkZtMENKTVZQNlNUbnpvcTBnZWlqQnF1eWZ0U2Raek90?=
 =?utf-8?B?RFcvRVFhRlZnZURuSEUxRVcwL1R4TmtNcXZUL2twZ09DZ1pqN1duaWZMNjFt?=
 =?utf-8?B?MjN6dldJSFVZcEp4cmhMTEJudy91USsvVnhsSE1pU1FzMVJFeVNhS3N4NjNw?=
 =?utf-8?B?NGV0THhkOS8xRVdHRUxjMWlNQWkwNi9icW8ydDBTODYxNGVSdnpTNk5qblZB?=
 =?utf-8?B?aXV2MUZxRVpQNkcvYi9JaTY3TTkyZU9oeitpa0p3L3NMZXREUENPc2tDb01M?=
 =?utf-8?B?UkRWRmtZQ0gwLzJhc3JZZ3ZrVWJpQk16L2dnTTFqRW1ucHlpWmZSc1MwTmVt?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA59110B19896F4BBE3FC2A09149A4E3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZT1LEsWx9lIJlsdvX9Eq9gIfyiQwR/aSN6leeEBO40pMGxWvZW8NHxhMLsyVHziyKYoqETh28xq/kN53FwKE2cIhMS41nYvZNtdxvpS9Xq5SwfK5+H6ffZEouxzf9Wp9jU0p7uK/Ft4AUM9lCcZo5Lj1hsz2TNWsfQle39djZZLh+VN/ylUAmZW+4rL12hKPUStA6ZUiQ5G04j/MkLgDFYm8wawBDL1tfLTzCsZNFv71A4VND4yowXbq7s5e/flkI5dxkG747XlkC3P4CB8hLSUREGqXDPXsuzL0Ur/2eXPBzvGGD7F5CDtGVvm/aYSuhgIisDk6T6099GNeawtvi6IWF26kzRPF6tEfa6g/KQg4etagEYe3YYL55nzlxqdQqjnFpXMkU/BYJRQ0rs43O2j5LOtULKnGcORx5UyY3hverBy9F/pr/75W0AF8wl0+AV+ujan/bU6xEBg89ybwLRx8Vp8g53dwqXJYGbUcJmTRoU05N0SsJIl5BWYU/xXnQ2DAA2IIp2eUVQsT8+7acKRKx58BB5hU+Y/4BPzLb8Ye2aYE5qCybb0+j61FF2sDWQCABjlbpkJNFSFA4SB0IG+cN6H9QUKEj12fDvDj7k9MtkjSU+JukTtjop+VmmP/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e157c6f3-c1e5-44f7-f1ad-08dc4412fcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:39:12.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pf05qO6511ugVwPs9SI5Dp7n4o+0KZKXjzQpK7JPRegZFCvIRAn0Uky6ySuhSGW2eSYCH2TUOqNxEWgUHOofEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8526

DQpTb3JyeSBCcnVubywgaSBmb3Jnb3QgdG8gYWRkcmVzcyB5b3VyIGNvbW1lbnRzIGZvciBWMSwg
SSB3aWxsIHJlLXNlbmQgYSBuZXcgdmVyc2lvbiBsYXRlci4NClBsZWFzZSBpZ25vcmUgdGhpcyBv
bmUuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCk9uIDE0LzAzLzIwMjQgMTY6NDcsIExpIFpoaWpp
YW4gd3JvdGU6DQo+IFBlciBmaWxlc3lzdGVtcy9zeXNmcy5yc3QsIHNob3coKSBzaG91bGQgb25s
eSB1c2Ugc3lzZnNfZW1pdCgpDQo+IG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcg
dGhlIHZhbHVlIHRvIGJlIHJldHVybmVkIHRvIHVzZXIgc3BhY2UuDQo+IA0KPiBjb2NjaW5lbGxl
IGNvbXBsYWlucyB0aGF0IHRoZXJlIGFyZSBzdGlsbCBhIGNvdXBsZSBvZiBmdW5jdGlvbnMgdGhh
dCB1c2UNCj4gc25wcmludGYoKS4gQ29udmVydCB0aGVtIHRvIHN5c2ZzX2VtaXQoKS4NCj4gDQo+
IHNwcmludGYoKSB3aWxsIGJlIGNvbnZlcnRlZCBhcyB3ZWVsIGlmIHRoZXkgaGF2ZS4NCj4gDQo+
IEdlbmVyYWxseSwgdGhpcyBwYXRjaCBpcyBnZW5lcmF0ZWQgYnkNCj4gbWFrZSBjb2NjaWNoZWNr
IE09PHBhdGgvdG8vZmlsZT4gTU9ERT1wYXRjaCBcDQo+IENPQ0NJPXNjcmlwdHMvY29jY2luZWxs
ZS9hcGkvZGV2aWNlX2F0dHJfc2hvdy5jb2NjaQ0KPiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Ug
aW50ZW5kZWQNCj4gDQo+IENDOiAiQnJ1bm8gUHLDqW1vbnQiIDxib25ib25zQGxpbnV4LXZzZXJ2
ZXIub3JnPg0KPiBDQzogSmlyaSBLb3NpbmEgPGppa29zQGtlcm5lbC5vcmc+DQo+IENDOiBCZW5q
YW1pbiBUaXNzb2lyZXMgPGJlbmphbWluLnRpc3NvaXJlc0ByZWRoYXQuY29tPg0KPiBDQzogbGlu
dXgtaW5wdXRAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCj4gLS0tDQo+IFRoaXMgaXMgYSBwYXJ0IG9mIHRoZSB3b3Jr
ICJGaXggY29jY2ljaGVjayBkZXZpY2VfYXR0cl9zaG93IHdhcm5pbmdzIlsxXQ0KPiBTcGxpdCB0
aGVtIHBlciBzdWJzeXN0ZW0gc28gdGhhdCB0aGUgbWFpbnRhaW5lciBjYW4gcmV2aWV3IGl0IGVh
c2lseQ0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDExNjA0MTEyOS4z
OTM3ODAwLTEtbGl6aGlqaWFuQGZ1aml0c3UuY29tLw0KPiAtLS0NCj4gICBkcml2ZXJzL2hpZC9o
aWQtcGljb2xjZF9jb3JlLmMgfCA2ICsrKy0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQv
aGlkLXBpY29sY2RfY29yZS5jIGIvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfY29yZS5jDQo+IGlu
ZGV4IGJiZGEyMzFhN2NlMy4uZmE0NmZiNmVhYjNmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2hp
ZC9oaWQtcGljb2xjZF9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9oaWQvaGlkLXBpY29sY2RfY29y
ZS5jDQo+IEBAIC0yNTYsOSArMjU2LDkgQEAgc3RhdGljIHNzaXplX3QgcGljb2xjZF9vcGVyYXRp
b25fbW9kZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gICAJc3RydWN0IHBpY29sY2RfZGF0
YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgIA0KPiAgIAlpZiAoZGF0YS0+c3Rh
dHVzICYgUElDT0xDRF9CT09UTE9BREVSKQ0KPiAtCQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdF
X1NJWkUsICJbYm9vdGxvYWRlcl0gbGNkXG4iKTsNCj4gKwkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVm
LCAiW2Jvb3Rsb2FkZXJdIGxjZFxuIik7DQo+ICAgCWVsc2UNCj4gLQkJcmV0dXJuIHNucHJpbnRm
KGJ1ZiwgUEFHRV9TSVpFLCAiYm9vdGxvYWRlciBbbGNkXVxuIik7DQo+ICsJCXJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgImJvb3Rsb2FkZXIgW2xjZF1cbiIpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0
aWMgc3NpemVfdCBwaWNvbGNkX29wZXJhdGlvbl9tb2RlX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gQEAgLTMwMSw3ICszMDEsNyBAQCBzdGF0aWMgc3NpemVfdCBwaWNvbGNkX29wZXJhdGlv
bl9tb2RlX2RlbGF5X3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiAgIHsNCj4gICAJc3RydWN0
IHBpY29sY2RfZGF0YSAqZGF0YSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAgIA0KPiAtCXJl
dHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVodVxuIiwgZGF0YS0+b3Btb2RlX2RlbGF5
KTsNCj4gKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlaHVcbiIsIGRhdGEtPm9wbW9kZV9kZWxh
eSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzc2l6ZV90IHBpY29sY2Rfb3BlcmF0aW9uX21v
ZGVfZGVsYXlfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA==

