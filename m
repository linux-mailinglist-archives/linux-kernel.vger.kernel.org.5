Return-Path: <linux-kernel+bounces-19581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D3826F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0A71C22676
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A941209;
	Mon,  8 Jan 2024 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b="PbuUT6tS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC640C1B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwHMH+rQzFJj+A9CGJxNqa2ZmAZorokV27X1iHsLuiK7+Q07YTOnoiq/kcnIK4sYuZa5J422rG85iuRX9iWGS74xv9HzAWwUZxXDZ80ktNvPzG2ei7DWo5ml2KKVCaRMEDaY2IuxhWu05xUQA+XRcSGgUfGH1BxM04LTksZ3eYQEBMHfbIit27I7RFEapiJGUsnqu9W2VgrExZLoYxMDzwLgxbjkS4c29xmyqHb5u08pWwpRY5ixqLNTFMiwkDiiKLMf0F99Ysf9/k/M3HJGW4Pp7Z8+dvOoFzc2GnBRZwZmja6KR2Ha62CVxxAtz3BqfMJ8n0ugHz+khD0TeCyJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWK0if9znUP5LcC1Lrh+3Prv8D+J0Ufbl6RRlzhiN5w=;
 b=H250EllbdkMK9yCthUbPBUPjmSJmR0T9o9aLCjNKXlvjF0yu9iGw6b4pwASmFiF0VxjdOgVJ2NRqhO44PHje+YXkEUMYqm1cfiiLazdrJp7IDYuIwDYoUzHGlx6X+he7hQKCGFK/08uv+D7D6WL1fNHsiAZsOpb8+GAx5ckdsmhg4s8ZzWD0x4scJOaRrUPRfnS/hSoWm6Rwup2w1IvITZYLxanOiT7S4tbGC93QAv+jemOulcFkql4JCCvKY3qo23Qv+Ft0VZWJ0hRIWW00Zs6RZ/iB4bXigqNSuvFX2cdgKX4wfVXZ08P/Ac7vtQsAlSBuU9PD98rHZs4QWnNdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWK0if9znUP5LcC1Lrh+3Prv8D+J0Ufbl6RRlzhiN5w=;
 b=PbuUT6tSHx/uXnNgnppzJ4MnqE8u1WOqAAv12G+BE6ikuypFYb8ZYiQc81akNFpvHfSySbuOkGNOXkxrLGJ3VrYb+QNBD6xxhjfLA8IaE/1fKBZYeMkikJ8WJKrJT269bLhlytCvRa52cu8dxjGOodJtk3QpieoDvrT08UhlQb4X4KNVqovhq+Sda2sZrUzfZEGeYC198s7V9MRlNvluEa0eWe4fTcZ63ozAHYOktYBXgKL01cOwylVJEISiAjl1kNaa7h+QKHg4Z2DRdPMMqEbvEu4jyIbgASKASnkTH5lJr4G29mHMh3vkaYXdrU9QrOGChpqRehe1QZjQjZdFxw==
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:162::23)
 by DB9P194MB1875.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14; Mon, 8 Jan
 2024 13:00:39 +0000
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5d13:7cb5:9ade:602d]) by DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5d13:7cb5:9ade:602d%7]) with mapi id 15.20.7181.014; Mon, 8 Jan 2024
 13:00:39 +0000
From: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: mm: disable PAN during caches_clean_inval_user_pou
Thread-Topic: [PATCH] arm64: mm: disable PAN during
 caches_clean_inval_user_pou
Thread-Index: AQHaQjKt20xeAz7LS0mwiFLj8Z0q9g==
Date: Mon, 8 Jan 2024 13:00:39 +0000
Message-ID: <e6dc8a44a140d1e54bc1408c36704b581433ec10.camel@lenze.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0806:EE_|DB9P194MB1875:EE_
x-ms-office365-filtering-correlation-id: b2709b4c-b291-4753-0093-08dc1049d033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lzHvhuLLrpT80bfeNk605i5w7ptNgz+Q5wIs1q5caeMSg0bNWtSgw2Xmz8M8SsWoIFw0ilxKoPJFXwAXUYvpfG1ZPU/gOAEPzjwoGAMwN81ECWyTwj8y/sSt51IoGaPQjoTpao5HTuCYGaKHnBIoDQFGjMWEzdIbxTxPxjEOFwvSKVg2WIqUxQrwXGoApFcCygRvmZW08f/Qdk+rO6tNE3de681PbdYWDjM84lzpKyETRBNwMOJG7Gx9vp+HClAUC5R1Q67s4qIv7r+B27k4uShiB9UNP/3sycKYY1oAx6S+8B4upIhSuwavwLbpDKkthyNiPzB760VLb1ayAynY5RuQkuKd+24csPGVTuRBYSi6QjQl9ohLCNwdknY9qnclPXwxVvY4czO7IsQJzLf6W9NMCCIRRj+a7jLysPICZJtF3HfQM8dmMAh6vopi9SS1ZFY3sAuEQ4+Y8AoTmKJqCWJA4HItavYVsR8hxAOAxZyaIhRQ/cwRZ4FQWzV9jlRGEHr3kVi3C5hID024vdnO/IouL502pBYl+IQoBXI2YkucItQIzmZXD36G0uf3+ff06u1esEDsfhs3N2QAqAa0CkGleyM9RFNcvs2H9TwXKiyK0UqvsqEpJa9pc5rZaTxd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P194MB0806.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(6512007)(6506007)(8936002)(83380400001)(8676002)(4326008)(86362001)(316002)(478600001)(66946007)(66476007)(64756008)(71200400001)(76116006)(66446008)(6486002)(66556008)(91956017)(122000001)(110136005)(38100700002)(38070700009)(5660300002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU5JUld4bTNOQlc0SmF6WlRaSVFmWkt4cEhLYURCdFRkMGVVZjFvWEpMRFFa?=
 =?utf-8?B?cnhyV1VoRkYzRkxKSzUzdG5rWis1NzRQall5SmJnWEJlQmVSS1NJOFNCblNv?=
 =?utf-8?B?MzlOVlZPZFArTjZKaDY3NVN3OUxhRGVSblB3WEdrUkhLL2Q1bTg5OWpiaVRz?=
 =?utf-8?B?WVBnOC9vd1BLeUlJUXhRRDZ2YVpGYjFqZXVoN2lIL2t2S0FBQlprczBOcEV6?=
 =?utf-8?B?UHZFNkthQkJ5NEJ2VWk0ZW9SUTJ5aFpUV0lsOW55aC9oMHMvVVNYbk9KUUFW?=
 =?utf-8?B?RGJyY3hxcEM4UmRaMXZ2OFZROS9KQWM0UXBacExtd1d2NlQ3N1BJMUJJRFMw?=
 =?utf-8?B?aGpTM1dQL2tsZHY0eGJBbktMUkJNMmphS0lRejFXdGFzMkxiRXlna0tuT3dI?=
 =?utf-8?B?Ry9zMlhPVFcvZzBHZ08xby9OK3I5dkRLSy9UYkZOUUdQc0l4R3BVczJxZjNs?=
 =?utf-8?B?b3MyeVNJSGpQYWI1ZlRqN2E4NWNkQXI5QVhQeTAvMDlRNm1LQi85UkJhZ2Rq?=
 =?utf-8?B?N1JoTFJMMkZtM0pDUFZGYkx5R3NGdUozczJKeHl5QnlkUWs0MDRoMnl5dzk0?=
 =?utf-8?B?OXZNNXM0Qm9sWEM5VHF3RmJyemZHbXhPWGRPVjVxbXZuYkE3bmFOS0JxbTZ6?=
 =?utf-8?B?VW01RGlXY1kwbUNhMXYzeWZXZkN5SG9RZTBGRGE2eHhPUnhKekJNeEFPMjdK?=
 =?utf-8?B?dzZhL2JXa0d1RVpuemZkc0ZIbmh1VUs5Y1dXMXNaYzhodFpKNmhqUlM0TXIx?=
 =?utf-8?B?TnJOYmR5aFl0RUk1bm1RV2ZlK1YvUm5BQ1YxdnJ6bVZhOWJwUm9Mb3d3VkZh?=
 =?utf-8?B?MERFRWR5Q3BZY2ZObzJCSENMQWVyTzNWMkQ5VmVwRzVMNmdteWZJRWZXQ1cx?=
 =?utf-8?B?Uzh2UTdXQ0gxcmFyTDVrQ3ViMzBOOTBtcWRzU21xS3ZDQWNkdFZBdFRDSmRv?=
 =?utf-8?B?Zk5Lc2dsL0JwNnpWbXdVZ3BJaWZuNFhkZm0yUHpqKy9lZWx6ZU9TWTBlaVZH?=
 =?utf-8?B?S3RtV3FNVUFpS2RBS2ppOHpkblhFdXk3eks4bXowZS9JMk5ScFhxelZHTU1N?=
 =?utf-8?B?OGxHMnN3Nis3U1Jucng2ZVdlZ2RMY0tZOEZvaFpJMGZUZVlWZVNqakFFZTJn?=
 =?utf-8?B?M3lsRVZrNFBLa2JxWXJqblFPRjdPVU41ckJhT1ZZbWxwWC9GOExabzdKN0NJ?=
 =?utf-8?B?UjM3VVN4SFZEUjdZL20xa3hxNUdnSjZydGhqUTRTSElOaC9kWlJ4TkVDYU8w?=
 =?utf-8?B?cmd6NC9mM1BkM2FYSE12TXJlVDVUc0d6QnkyaGp4NDN3ajJEbEp2Y3BFT290?=
 =?utf-8?B?enJyVVVQb2dObjVHWXkyZ0YvUk9hSm8rV0hUMXA2TGlnaE94eURLSlpJRk0y?=
 =?utf-8?B?bTc1d3h5NjlPR09IQnpiczN1bjMzUVFISVhTVFNRZmxmK3lDR2krQTBRSzQx?=
 =?utf-8?B?TFpXWmtBNGZ4emlobXNnLzk3SlNuWE5oVUs2RmpGY0VGL21mSmNDczBmSy8x?=
 =?utf-8?B?a05qcE9ZdzF1ZW9TT1Y2Umxid0tyYlVuODdJYXFwVlpQSjU0Y1lYbjNJM3dr?=
 =?utf-8?B?a2x4RzcxSWN0MysrN05teVI0QTRpM2dkYnI4MGVMaHo3NDVpZWY4MFJhZUZo?=
 =?utf-8?B?blE3WUdpa3c5eDJjQWlTK09FSy91ZnBwQ0RWK2Nocm45RHlzbnRDaDk5VE5E?=
 =?utf-8?B?TDFtM2VWUzVIanZkNWR2S0F1TEI3dUNTVElEM0NnUUlsaVlhYUg3b0RrSlN0?=
 =?utf-8?B?ZU8yU3JkcVNWeHA4ZU9EUTRiVEJRQWU1aUovc0VTQy9BUXhyN1dIZkRTUVVL?=
 =?utf-8?B?ZDQ2dnM5anRjNWlsNzNINHVZRFpUd0VpMDJZY3pvankreVk5eXQzZUhyTG1x?=
 =?utf-8?B?Y0hIaGN3ZEE0NnZmbFFHZVlET0QzanBnYitrT1pwVGVoKzZEejU1dEFHZHJQ?=
 =?utf-8?B?N3ErWjVFYUhxSTRlS0hzMHBiSEllcXRFby8xdDY5blpzajdEb1FZZVBlTm5J?=
 =?utf-8?B?VTF6T0VvV2MvSTNPc3o4cDhIc1hiK2FybzFzWXNiV2RabVBkYzBIT2JSQTBt?=
 =?utf-8?B?czh4WUFCdHFhbmVLUCtKTE13ZnFiWnV0QzYzQUhNamZUZnZ6TnZKYkRSc1Zy?=
 =?utf-8?Q?Qm+oNUez5YbqJNC3oZKe31D3N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C4722F1F510694CB6EA29CCFA1BF203@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2709b4c-b291-4753-0093-08dc1049d033
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 13:00:39.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xv2W/CAFl32nSiMHR/J0dO7065L8/ilm1W80zHf1P0+B/PHZVixjaOHdOdijxO1tjSFdjrVF/oMWWOMLFWcHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P194MB1875

VXNpbmcgdGhlIGNhY2hlZmx1c2goKSBzeXNjYWxsIGZyb20gYW4gMzItYml0IHVzZXItc3BhY2Ug
ZmFpbHMgd2hlbg0KQVJNNjRfUEFOIGlzIHVzZWQuIFdlICdsbCBnZXQgYW4gZW5kbGVzcyBsb29w
Og0KDQoJMS4gZXhlY3V0aW5nICJkYyBjdmF1LCB4MiIgcmVzdWx0cyBpbiByYWlzaW5nIGFuIGFi
b3J0DQoJMi4gYWJvcnQgaGFuZGxlciBkb2VzIG5vdCBmaXggdGhlIHJlYXNvbiBmb3IgdGhlIGFi
b3J0IGFuZA0KCSAgIHJldHVybnMgdG8gMS4NCg0KRGlzYWJsaW5nIFBBTiBmb3IgdGhlIHRpbWUg
b2YgdGhlIGNhY2hlIG1haW50ZW5hbmNlIGZpeGVzIHRoaXMuDQoNCkZpeGVzOiAzMzhkNGY0OWQ2
ZjcgKCJhcm02NDoga2VybmVsOiBBZGQgc3VwcG9ydCBmb3IgUHJpdmlsZWdlZCBBY2Nlc3MgTmV2
ZXIiKQ0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IE9saXZlciBC
cmFuZHQgPG9saXZlci5icmFuZHRAbGVuemUuY29tPg0KLS0tDQogYXJjaC9hcm02NC9tbS9jYWNo
ZS5TIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvbW0vY2FjaGUuUyBiL2FyY2gvYXJtNjQvbW0vY2FjaGUuUw0KaW5kZXgg
NTAzNTY3Yzg2NGZkZS4uMzMzYzRjMmJhYTU2OCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvbW0v
Y2FjaGUuUw0KKysrIGIvYXJjaC9hcm02NC9tbS9jYWNoZS5TDQpAQCAtNzAsMTAgKzcwLDEyIEBA
IFNZTV9GVU5DX0FMSUFTKF9fcGlfY2FjaGVzX2NsZWFuX2ludmFsX3BvdSwgY2FjaGVzX2NsZWFu
X2ludmFsX3BvdSkNCiAgKi8NCiBTWU1fRlVOQ19TVEFSVChjYWNoZXNfY2xlYW5faW52YWxfdXNl
cl9wb3UpDQogCXVhY2Nlc3NfdHRicjBfZW5hYmxlIHgyLCB4MywgeDQNCisJQUxURVJOQVRJVkUo
Im5vcCIsIFNFVF9QU1RBVEVfUEFOKDApLCBBUk02NF9IQVNfUEFOLCBDT05GSUdfQVJNNjRfUEFO
KQ0KIA0KIAljYWNoZXNfY2xlYW5faW52YWxfcG91X21hY3JvIDJmDQogCW1vdgl4MCwgeHpyDQog
MToNCisJQUxURVJOQVRJVkUoIm5vcCIsIFNFVF9QU1RBVEVfUEFOKDEpLCBBUk02NF9IQVNfUEFO
LCBDT05GSUdfQVJNNjRfUEFOKQ0KIAl1YWNjZXNzX3R0YnIwX2Rpc2FibGUgeDEsIHgyDQogCXJl
dA0KIDI6DQotLSANCjIuNDMuMA0K

