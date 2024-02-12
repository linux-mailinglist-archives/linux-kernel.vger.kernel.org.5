Return-Path: <linux-kernel+bounces-61863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83D851789
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D01E1F228A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E13C07B;
	Mon, 12 Feb 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="GsgxOg4t"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9443C470;
	Mon, 12 Feb 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750270; cv=fail; b=jd6s3IiVD7iYekJe3pJnObFh8+m4bGwiL0qs8SxrttKf+IS9NEtzPa9T+Pg6wB9VFPiFqC9SSPd05FgOBfsRP8g74fBiQhA4IkxWj+ewU7+A7IAynXZ/1efu3OolGZOrIWQ0ccnvgZSkMV2sHzh87T/mHYk6QC85eTu9NEmHiIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750270; c=relaxed/simple;
	bh=YOnSdJXICfh49FjUDS3n7g9p5jKqZcN0uGIDjLDERQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o10pLJWYTyVS9cPBS57P+psz9WrFoWdFu3ocxtSMhIs7p2vjEz+MwryfWxhQqe61CQQI+IPgBYRLEopw+IAtwGD5HddVTupCGkHvk5CGY5/7E252Qqw1oWsB7Yfgc7YKeQzSt5WpdYA21og0mjqEKbCcOKeBSFE9j5Ccofa0Cgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=GsgxOg4t; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyJ4JKfrl4diSGQQ53DwXGOFvKat+l/tSZAx86OUibp8G+L0b12K3BmGvv/qf7z4Jlky8zcJe/zbGeq+vWpptzSaH1dLgUy3r21BzcaarAoqDzdgAeMRpeh7GF2A9umXZMj0s5UoM//h4lb06bvjqSvpvw+f1xPHuF8xSBTTDODxm1K+xj/AsDw0hq5bRPUzdOJ80ncTXXWvqdVfw6yHTic49yURMzZ3Bkvim8La9L62K9aqyApoGY9RMfC3swa35zpI0TRA3Frcusgf0OSpjqrbhczGF2r+Uo9Wb69vlv4G6RHtH5fT73iROdOQZZ15LkYW3zu5yVPEUr8I/IHrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOnSdJXICfh49FjUDS3n7g9p5jKqZcN0uGIDjLDERQ4=;
 b=Y9a2eXHb/bj6jGTm+iLO2RfEc09H50oD+DKCwpSsDFFMLvXJphg9l4tv1lmGhLVMbrUrw4NBLyMdNxEy+7Eteufx2kP4a2cIUcD1QfdRvzREPSuIyACIEDTjEd4DGvTcqebqfp/1tVTXj0trimtGQAzT+NwHokHRuwAk4RY4siG3bs2Re9sOhTqFDPJ5sjkXbjsqsqffERKusWg+scsiOJF2hsN1lfMibWmmCcqX8qyv+6NrlTWdtWli9yChPeiyfXVqVvWGLsfZ1uwvJ9EuPDvsVNT7WHCdD3dYBuReii0bQ9HkBY4DezJK1tYTq4E6zhfJ1wO1iCQb8hj4TFQi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOnSdJXICfh49FjUDS3n7g9p5jKqZcN0uGIDjLDERQ4=;
 b=GsgxOg4tTtbcICRBijir9iLozsYzOaUulv6pSTQpo1t9m+p4gPrHKmv4tNseH2/nSl06ELbwhGsT0AuWU9X2edd3o4kSvrDm7xHQ/muYo0vIXuGFa2romiLLyreDV7w2pM/FwYw9BIc7oAJu7ZMnBvMPHcemNxGlkMEfkVLTm6c=
Received: from VI1PR06MB4718.eurprd06.prod.outlook.com (2603:10a6:803:9d::17)
 by DB9PR06MB8042.eurprd06.prod.outlook.com (2603:10a6:10:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 15:04:25 +0000
Received: from VI1PR06MB4718.eurprd06.prod.outlook.com
 ([fe80::739a:c38:b3d9:44ae]) by VI1PR06MB4718.eurprd06.prod.outlook.com
 ([fe80::739a:c38:b3d9:44ae%5]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:04:24 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Topic: [PATCH v4 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Index: AQHaXYemZiwmM1zt5EyvIyDjdhgdRLEGwOKAgAAF+4CAAAebAA==
Date: Mon, 12 Feb 2024 15:04:24 +0000
Message-ID: <ff630ce9-0da8-4ad7-ab30-11f337dfa1ff@leica-geosystems.com>
References: <20240212074649.806812-1-catalin.popescu@leica-geosystems.com>
 <20240212074649.806812-2-catalin.popescu@leica-geosystems.com>
 <186cf83c-b7a7-4d28-a8b1-85dde032287b@leica-geosystems.com>
 <10ed19e3-01a9-4fcb-819f-686c6d0bf772@lunn.ch>
In-Reply-To: <10ed19e3-01a9-4fcb-819f-686c6d0bf772@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR06MB4718:EE_|DB9PR06MB8042:EE_
x-ms-office365-filtering-correlation-id: 6588d284-0d37-469e-8158-08dc2bdbe6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zYWktHO18mKavCL8fZzqFFfgiWpXXMftXJl2tQI91ZfsFRqq/FPh2BQ7FFuWVyxTnpyvcYSVyRhgrnJcoXG2Rs/q6yDrv5cL4ChTsWQQ1tOl9BTVWZDss5HkO0NyXjdlClMur5rm98PSH/jLWXEb4omDKMSNE3Ubor3eeG6IhxlDikp4NTxZu5G8XXs86sz9C0OXGY8huk18cbAOL3DmCiBjYggtTeNqbblqSTAuut5QoqUYl9Z1jurCPPu9VwYl4qKSl9KlDiFYXzcj7hqoPSyWtOy0MLXiY2hL6WZCcuOmV5q2hloONlkV6EiwzkReVgzpCA3taDrHk6thRlHmSeR5nAQ6yuky7zc95DJbO6HFpHg/xZfwQiv7aH/jxEnwvnjqYB5CHF2fSEmF5STOkBlpSbQl1/l9TGfdIsz+ZwMNSDkimnIGvfD+Kqw0dyKfSEG7T/0Z+wcwbmaHuWK+ilmD8l2F/sLn+5ytNTTLUcnkXgDX428GbEYtz7x7XediqH4MRmfnNIAm64mzQ2m/4L8AVaYULO52Z8IIzlPzi880BlwR3NxTQzupRv2BZc2s34k6my7yo5n3fHx4/jMMJHWcpyj5MFHddv7CqttjTcVnf/K3KOU5uiNPvTR4jIbO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB4718.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(4326008)(8676002)(7416002)(5660300002)(2906002)(2616005)(83380400001)(26005)(38100700002)(36756003)(122000001)(31696002)(86362001)(38070700009)(91956017)(54906003)(66946007)(316002)(6916009)(64756008)(66476007)(76116006)(66446008)(6506007)(66556008)(71200400001)(53546011)(478600001)(966005)(6486002)(6512007)(45080400002)(31686004)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3VnNGZPZU5uYmhXSEFnV1NtZXkrM2l0cGJnRlM3QitST09wdGVPVkFxTmkv?=
 =?utf-8?B?dlNFdzlBVDhMN0J3aUFNWTFzc3BpNUJzeExkb0hKYVRlV0thZ2xKZ29qMUxK?=
 =?utf-8?B?NUY4RHg0UERlSUM5K0M5TUJDNi9SUEl4TE5tQ0pBS01tZDk1RGk0R3UvdVlx?=
 =?utf-8?B?RDc5bEJJcWlvMkFjelYvd1YzTTgyUnhyblJPS1hHeXpMUVdmclpWU0lLWXhI?=
 =?utf-8?B?Z1BRRmxVM0dHUmtpS3ZXWGRNaFozWGJ6Y2NkK3dWUFV6MFZqM3B3TWViRlFU?=
 =?utf-8?B?UExNc3BJWjhNL0RPbjc3KzdFQzY5S1VlWEV5R2dKOW9yeHdibCtVU1grWTMy?=
 =?utf-8?B?MUZsYkpVK2IzMFhSSUQ2QmkrRzVJd3ZNODZlTHVhWUpjYnlDUHF0b2pNZ0xi?=
 =?utf-8?B?TGJGWWszbFBqRmhNdlpQVU54TTdWS2NXOVVXMTN2b3o5NnAxUkdFVmJaa3dY?=
 =?utf-8?B?TTVMdGppVmprUk1OdWRhK3loMGt5UEp3dkRhSWxFWTloM0RCNzBnczM2cExp?=
 =?utf-8?B?a0orWHJoaG81UGx0dVBnckl0MUxxbWtVOHN4SEgxc1FNbnZWd0hWQnhEeWxY?=
 =?utf-8?B?MTRaeXNhK29tU3B6eVJNbkROc3FuRXBSTDYyUkQrd2lGcnVad2U0ckpSMDJK?=
 =?utf-8?B?V1lHU20yb1hsajJMMy9FdEpNK2dNaldXdVhoZmNjaXM2YzFjQmlxSk9zRkVR?=
 =?utf-8?B?TXMremtBaEdpQk1oY2lTQkpiOWQrMmFaS2UwNzFZWER5RmgyaVFKUGdOeGZW?=
 =?utf-8?B?UGpPUVFHa0pYSHgrZXI1TGZyb2hkVzBVdXdZNHJGQW4zV2xSb3c2ZmpkbmJW?=
 =?utf-8?B?ZVVNNlBrNjBDc1pwUzM2Z0dqbEZGR1BOY1h6MEd0VCt1clptSnlMbEEvSkpi?=
 =?utf-8?B?MFloOEIrTDlIVWI2UE5rOWRmUm1adjZVR2JtSjcvUk5JZnRrUWFOZDhVVmtQ?=
 =?utf-8?B?emVWUkJiUlhXdWkrNjl6MW1EMzU3bmN3bXoxQU5oRXIwaERvdk1TcE9hRXpN?=
 =?utf-8?B?Qyt0NTFpdHdPWFRmZE9kMU90SW5mNnJ6ZlFyTGRvZDB4cWZmNmprdDdXMnRR?=
 =?utf-8?B?eGFhcXdLVDhlekF4cmwxbEdSVS9TYXAvQzRHMFVoSjZ0L2RXaTZ3djNhWk9D?=
 =?utf-8?B?VHhxLzR6OVYwTEpVNFV4b2c4TmF2bWxMcC9DamhOTVRIMWdoWmQ5d2t0S2l1?=
 =?utf-8?B?eFZCRFJnSm5pK1dxVE9HRXBvR3pPcy83Mk9sWlN5aWdhWksxaTUwcDN6VVBG?=
 =?utf-8?B?T2E1cHRLZVBxclczOHp6TERoazZVdGFnU04xVWFuRWJKQUxZWGpLNkVUSElk?=
 =?utf-8?B?WmpDUGx4QnJSZDA3K0lrTmUyZmt5OEpSdVZpSzlCaUlPMGg1TWZoanVaVy82?=
 =?utf-8?B?UkpCb0txazFMTVlEaU1Xd0FCMmhHTjZ0cmhuOFdnSmcwVDVXTzVieWJEcHp4?=
 =?utf-8?B?aElMWlhrUDNsM0dtMHN4UnZmdElEcjVwZ3hnNEZCaStKWEMvdE9rQ0xTUVJv?=
 =?utf-8?B?K0JuWGl2bkc0LzZ1ei9Gdit1cjFZWUNBOFFTaHBJYlVuNnczTWR0N1h0bnpX?=
 =?utf-8?B?dm15ZjgwQTJjVWlONCs2aEwveG5rSExaa0FZbGpZL0tybWVLbDFpaFJhNmlk?=
 =?utf-8?B?eXdSRlFZQzBVRm5tOGhxcFdyWUhLa1JhTUp6UnVHV1Y3amJReGFWZm91N1Nh?=
 =?utf-8?B?ckZhN0xRaWRSWEUwS1hsd3hpZ3RENlV4dnRsbWlwTThOWThMNUovd1pGUGJw?=
 =?utf-8?B?Skx1cFBDWjhMOGJneWlUQ1RUczEzTzhMYVV5anQyUjV4SVF3cGNQNzVibDlF?=
 =?utf-8?B?M2oyMWFpM1Jram9pVTlFaVg5YTdpLzJQaDc0ZWo5L0QrQTJhcGU0N0N2UUJT?=
 =?utf-8?B?S1drcE9BNm5vYTFjNGN1Tm5PeDdlcXBLOGF5bHgxcURlSE55NUl3cWluRVZI?=
 =?utf-8?B?dEtYNEw5Qi9reExIU1VqaTJ3MnVYMzZuUmhLUXdlWERUZTN0dHNoQVNkd0Jr?=
 =?utf-8?B?cGNWUzZFQlRoMm1TWEdtYkhKRUhzdHRjbGhKa25FdDNHZmt4QzRIWS9pbWs3?=
 =?utf-8?B?dWtjODgrQWkreE5STTVmS21QUkkxR0swdi9MNUduTVZrY2NUcDd2Ukkvdyt1?=
 =?utf-8?B?WmRiZzQ2UVBRdC80RERuYmtSTm9SekRydXV5WEhhUDVIZDlIenJpT0JLd0dx?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F25CE94129BEE419EE96844BDF2735A@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB4718.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6588d284-0d37-469e-8158-08dc2bdbe6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 15:04:24.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKYSscFux32t1BoVrjqK9pDJotRdVJ9Mvc9G2ICvsbk/McQaCPjKFIqWdzhKj82C5Ivpt270JpBTpks/INZSirdRNAwl9DSb8EamMY72kiEDe3+rf0zolD+MCGnB4fO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8042

T24gMTIuMDIuMjQgMTU6MzcsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhbmRyZXdA
bHVubi5jaC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xl
YXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMgbm90IGZy
b20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hp
bGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRo
aXMgZW1haWwuDQo+DQo+DQo+IE9uIE1vbiwgRmViIDEyLCAyMDI0IGF0IDAyOjE1OjQ3UE0gKzAw
MDAsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4+IEkganVzdCBmaWd1cmVkIG91dCB0aGF0IEkg
Zm9yZ290IHRvIGRpc2FibGUgV09MIGluIHRoZSBjYWxsYmFjayBjb25maWdfaW5pdC4NCj4+IEl0
IGxvb2tzIHRoZSBQSFkgZHJpdmVyIHNob3VsZCBleHBsaWNpdGx5IGRpc2FibGUgV09MIGZlYXR1
cmUgYXQgaW5pdCwNCj4+IGFuZCBsZWF2ZSBpdCB0byBldGh0b29sIHRvIGJlIGVuYWJsZWQuDQo+
PiBJIHdpbGwgcHJvdmlkZSBhIHY1IEFTQVAgdG8gZml4IHRoYXQuDQo+IFdvTCBpcyBhIGJpdCBt
dXJreS4gT24geDg2LCBpdCBjYW4gYmUgdGhlIEJJT1Mgd2hpY2ggY29uZmlndXJlcyBXb0wsDQo+
IGJlaGluZCB0aGUgYmFjayBvZiBMaW51eC4gVGhhdCBpcyBub3Qgc29tZXRoaW5nIGkgd291bGQg
YWN0dWFsbHkNCj4gcmVjb21tZW5kLCBzbyBkaXNhYmxpbmcgaXQgYXQgYm9vdCBkb2VzIG1ha2Ug
c2Vuc2UuIEJ1dCBjb25zaWRlcg0KPiBzdXNwZW5kIGFuZCByZXN1bWUuIElmIHRoZSBQSFkgaXMg
dXNlZCBmb3IgV29MLCB0aGUgV29MIHNldHRpbmdzDQo+IHNob3VsZCBiZSBrZXB0IHRocm91Z2gg
c3VzcGVuZC9yZXN1bWUuIFNvIHlvdSBuZWVkIHRvIGJlIGNhcmVmdWwgd2hlcmUNCj4geW91IGRp
c2FibGUgaXQsIHNvIGl0cyBvbmx5IGRpc2FibGVzIG9uIGJvb3QsIG5vdCByZXN1bWUuDQo+DQo+
ICAgICAgQW5kcmV3DQoNCkkgc2VlLiBUaGVuLCBJIHNob3VsZCBub3QgZGlzYWJsZSBXT0wgaW4g
Y29uZmlnX2luaXQsIHNpbmNlIHRoaXMgDQpjYWxsYmFjayBpcyBhbHNvIGNhbGxlZCBvbiB0aGUg
cmVzdW1lIHBhdGggOiANCm1kaW9fYnVzX3BoeV9yZXN1bWUtPnBoeV9pbml0X2h3LT5jb25maWdf
aW5pdC4NCkhvd2V2ZXIsIHRoaXMgY29udHJhc3RzIHdpdGggdGhlIHJlc3Qgb2YgdGhlIGRyaXZl
ciBhbmQgbXkgcGF0Y2ggaXMgbm90IA0KYW55bW9yZSBhYm91dCBqdXN0IGFkZGluZyBzdXBwb3J0
IGZvciB0dW5pbmcgb2YgVFggdm9sdGFnZSBsZXZlbHMgLi4uDQoNCg==

