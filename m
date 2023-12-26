Return-Path: <linux-kernel+bounces-11333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E43081E4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB05A282C29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3C1A29C;
	Tue, 26 Dec 2023 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mSw7EaF3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MkrrA8t3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61F107B2;
	Tue, 26 Dec 2023 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bf1e12b6a39d11eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K5vy4mzZWy8uM/UCpW3fr94qQJfl1DEsmSDLI8O8oqc=;
	b=mSw7EaF3dgGqWkMErwmB91px4Ge50+E+cRriYbZAI74LZ+4icB2Coz/jIffNdOFW6+Y2UrXi9tOY7RVAtpu22ICE8jPERL+fTEasnh3GPJ9KQ9F9JnNOBUMRt5N3JpZLiU4o4hgZcgNoJP5dMi0OdFCy2d3UXq2ayhqPyttOZD4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:91437283-6c8d-40ad-9f9c-0bcd83c22224,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:4be77b2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bf1e12b6a39d11eea5db2bebc7c28f94-20231226
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1605956674; Tue, 26 Dec 2023 11:20:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 11:20:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 11:20:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKQoT2fAyVnp3L93ZL1IH4/W+Jn/Eb5GGR0S5jsMTFKN1h6tqrH4U0xaAbgQ/AaoX4OsrCZYRILlekw/Y9biBktKjbIVENpolJikee6JGWm8NxriWavum3Y0qt5iBrL7vpupg9r3CyzxjIOMy/wClrN+rvxHPEYUIa16I3qQe1tiz5vloIzW9UeEt4M1v/wA2j1LKJgC/IHLyt/uZZ8FvMBgqQ4WYh1n5t3YCFMDex2cvJ8zMlD0JUfSySvLmJKMwWQ2jr4rY7Q2sERRLnrwgQWQKWi78/mjTijwJVmNj1JR+Wn6N1HyYaU0fxXhXabbMxNjTjdGAwc/eA9VuzUuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5vy4mzZWy8uM/UCpW3fr94qQJfl1DEsmSDLI8O8oqc=;
 b=mo8mWZNQRdjmcDaDj1thFecKX+PHwjygizCIqMmxMZF13k5jT6T5WlH93KU9OkWFaIj2WwnP+ZJybdizOwhLykC227V3wE+yU57Y6I8Psnt8+B/6s2b7JhiCyCgOOug/a6yeiZ3l21ahMhz9s+7PQok59k8fJpO0YBHfKj/7Z3E7x/2EZ2UTn5Hq/coGw6V7vNG47xTj7kXCx6FdtjilhMViUP9dJI8rGj0KpXX9KXKASb9qz8Ky+PGwIpUu29H3h2TwFUzcavH81mhp2JmCdHDDQhFjswlB/YitkDAit9P3lkwBOyWR9gy8RAMGgE9GhBmgJqBAtrcVpbRuXfN2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5vy4mzZWy8uM/UCpW3fr94qQJfl1DEsmSDLI8O8oqc=;
 b=MkrrA8t3PXIGMWixgI9wAl0hbUoFobSf81YVJ7BLFPKJbn+sWCAc21X/KhsGLbKsufbXIjBpRQ+y2czHLAeQzQE/nr3whAnY+ilt9zXwSi3y/ujG/ysP0wtPGbgrW50lU1bEtMn8KDlvS5LrfBLDSJDOwNKcCHomM78MWEepk50=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 03:20:36 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 03:20:35 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Topic: [PATCH v3 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Index: AQHaNc43AVmHuSnLR0GmKONhb0q3ULC66V0A
Date: Tue, 26 Dec 2023 03:20:35 +0000
Message-ID: <2d045768bb3f1da3e2ea77f9f94050b194627e5b.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231223182932.27683-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7297:EE_
x-ms-office365-filtering-correlation-id: 50a37623-2c7c-4c95-3e14-08dc05c1a03d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhkbhAUjRubtzE+U8ttllcmCBJ3hdqNxq1cWdxMaBRGDoW8m6UjnTX7Bdg3OKq20ssyfBiNVSRX3884Scv1gpgjZagU1Fl2bDs7w+XKdc71N+FyxiWvBPbabYTk92TGwo76zjbyy3CQZ+794/9swgvnMy+wpUAvmP/ozYc4F4amYPgYz16tD0kS18b6Y8a5s9RfM5SsoCQxMeHXFiU62Yck4r7DHzYaXK+WOhkpw4CMPvxzPmizkzp4beaeq3W4nKk/Dwg72igeEZ67Ftul9zKgxvIeXr/fne1FI4lXeBqOGUXQRCaAPFk0pGOrf9sV57h2+DJ8aklEgpyubyKT5wlZpntEO7btVT2QjrzqDDqc9lDb/jvwSORvGzuXbHfaRuNhMCwrJMNbQ0v7OhqGQBWqjgQFGHciB0VbcgPCfjbz/KCzAUzr7y28/RmgNuzyLfB+u81Ck6vOEXpTc9wmcZva9Al8Dq0sa/FB8R2ytrBFQTF+BB+Byka8xUA4M6KapOA6G7oeYPQ0ZzmtPqRlO/VcFBeI1kXcZz3Z9qcHwspHxsN7bk+6eJiT+IC6PL8tqCqqy46IoLxl+9rgLgIz3UFV5F3EIbjWI1sMVBhXiVCR5Xp1W/+ozum1hgJsoQzJAqH1aOJfF5ZWNYKBhsHvPxZd+DNcFDx6SA7Ha4VB+F78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(4001150100001)(66476007)(66446008)(66556008)(64756008)(76116006)(66946007)(5660300002)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(38070700009)(85182001)(36756003)(478600001)(6486002)(71200400001)(2616005)(6506007)(26005)(6512007)(86362001)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rnp2WUZqTUxqTmRWOFk3U3JDaTh1WXF0SE9LR2tWU1gyRjhqNmJDVEJ0eWpn?=
 =?utf-8?B?VndFay9IM0VMWDJWdUpLQVo4VDhhSllRanhoMTRvUlNUcFA1Y3RJTkRaNkhB?=
 =?utf-8?B?cTdUUTZxVTF0NnFmT2NUVGlZYzMwb09hQ2picHJ3WjNtejR0YzVNYzh5dHNO?=
 =?utf-8?B?K0tHdnJ3Q0traG5Fcy9ZT294U2Jqc0JDQVp5OFowei9IK0E4QXB1Y21iRUdL?=
 =?utf-8?B?ZFI5UWlpa0hVUDJUZ0FuYTF3Q09SNm5tbG9DelJWYXlMeXVxcGNKaTJBdDNW?=
 =?utf-8?B?NXo5aSsrWE9rY1ZUQk9lZXBqQ1lsWTdWL0xTRnAxWThJVm9lVjhNbUNDWEVF?=
 =?utf-8?B?bFF4VXFkREI5NnF1YWowTWVhN1cxNENLRGkwL1dMWDJ3ZGN2M1Y5VWlscEcv?=
 =?utf-8?B?c3ZJR0RKRStGSHRaN1U5NEVEMEU1bzRWZGJuZXZydUlwOTdrYWdNVDFrdURp?=
 =?utf-8?B?K2FLd3NlRXBOYnVZcE45cGV4VXhab25WTWJ1TDFHbDNqUUJRZ3FQbHY4QUQw?=
 =?utf-8?B?K2hKeUNTdEJqekp3V1c4WU5zY3JycDBzUE5TaUdxN1FMVkRhL2VWbE4wNjhw?=
 =?utf-8?B?Y0FpQ3h5bnUxQnQvdXRDblFuQUF4MnczeTR0Q1BURXhKSU5Dc1RBWHNyUEFS?=
 =?utf-8?B?NjZJazNhUTJLOE5abmtjTm9keml6cGZTQW12QzdkVk9QV3ZlK0JqdDVPWkxh?=
 =?utf-8?B?SnBhMHEyQ0htNjB4WEhnNzQvcDB3OFJLZld5Qis2bnBwRTdUZitCRTNIZmVu?=
 =?utf-8?B?WFd2TUpXL0JaRzIxempMVVNXRjRHY2lVdmlHMkFVblpkb1gxL3pVOEtrZG15?=
 =?utf-8?B?azd0ZnZlV0xoV0NERm5Mb09XWEtrdWNVUTJJUG9RWm54dHV0a1VtbFhsYnla?=
 =?utf-8?B?NXpkcHEwWldpQmpad3B0LzV0MVZLbnVqMXBsd1RhREVZNkJhVXpxaUFlRnFj?=
 =?utf-8?B?bDEvZjl0SkhRUU0yZUMzMHZPZHpnRzFrU0lHa2t5c3ZCKzZITXh4cXdlZzFs?=
 =?utf-8?B?amMyamxxdTNNTHZUMGRvQmh5elJEbkNYVU93akg1bVBTQ2RuYjYwUFVVd3V5?=
 =?utf-8?B?ZFFKSHE5WHlMOXdGNE83TVNycWVRU1JJb3B3NHZNQStHaU02MjVRdkJWdkxP?=
 =?utf-8?B?RmdtaUxoMWR1YllBcFgxVnltVG1SSHhKZE9OZzdabmpwaVpwUmdFVEVkeVVB?=
 =?utf-8?B?bGl6U2RTMjcrME5XYThjNHY2NC9IUTVpa0xZTWVKM0ExWWlBeVphL2p0SlR2?=
 =?utf-8?B?M1hVajUxZCtEOXJET0ZCbWtuT205Mm1zb1NmREs0WnFCUWh5M3dZNkZnU29R?=
 =?utf-8?B?UTZ1YUVCTVhQTFo1U2Q5anFqaDg4S1ZBcU40dEZ4RlhtZ2MrM0pNL1lOTzBF?=
 =?utf-8?B?amtCNko3QTRWdm82dUIwQ1I5Vy81WFo4aFVwWE9ack5HMUNvQ1pFTGdCQVg4?=
 =?utf-8?B?Nkc1S1h0aDZrOGVnQXhXNDhFMmowbXhBeTZ2WEN5SWNyNU8xN0FSSVp5aUY4?=
 =?utf-8?B?UmFyMmZIcHJMSFE5NjUvS3RFdXdLQkZOVThSNzNTYW1qUFpicDdVZGh6bXFK?=
 =?utf-8?B?UkltdnF3RTA2dURITmxyamhKbWg3Q1dEMkg2S2Q4b0ovbEh4UUExMmdXcDRk?=
 =?utf-8?B?WWh1WFpkSC8wTGdhbkhYUXE5V2VmZTBvQ2JtS1RkVUFtc3hJMjBuMXFtenVS?=
 =?utf-8?B?a3NDbmVqQ2U3bkJsdXA1a2NPcTRFUkRiQ1B2RnNJSEh0VVdtT1hJUU5UOEZI?=
 =?utf-8?B?V0xNdlpyY1ZYd1dUbnZ6ZnU0OEFvMHNwaUdybDd4VXRDRFlLeU9HMUovK1cy?=
 =?utf-8?B?ZTZUZmJqS1JQMmgzY2lLUWVYQ3RtaGEvbklTT2hLallxbU9ZQnM3bWoxL0Vq?=
 =?utf-8?B?TXZGODExcEkxRUFmZ2JwSE9YQXZodGhINzFrNTZtd01pN0pqelpjMTVQbFVn?=
 =?utf-8?B?aVJsVTdPT1VQTFhqa2FOUHBHMXg1U0RMM3ZVY1RkR0F6REhOMElXVlgzVE54?=
 =?utf-8?B?SEVUa0hTTVJYZTZ3bXFiblRoWWRnakV2aXNXWkZjNWNiNVJVeXVzL3ZQcm9X?=
 =?utf-8?B?MkJCek1oenRDd0pXbWMyNkdvLzVMazJNSFhXczBtalBHVkZsZ1J4RGJwajdR?=
 =?utf-8?Q?K+i5Pywm4gPYbteP2ioAzh2wN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FC69303AA720E45A0D80EA6E34001D2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a37623-2c7c-4c95-3e14-08dc05c1a03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 03:20:35.4692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4wo7W4I6x7DXBbg0I46MDTl68+a1ImcgSUQ445PaHZqPNUq4ULrUvznSycAwWDZlTKBrzJAqaYez+XkXPW4Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7297
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.876200-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsPHkpkyUphL9MZm0+sEE9mv3bBqxmjinTcEn
	Nm201ATJGQdEeHBaW03ijpjet3oGSBgpb8HNtH0+FYJUGv4DL3zt/okBLaEo+Ha2ZEC0WTlXqgp
	T1Ht6sYSrHycOHk7y5srpjUJEQv++8qNdXuIPFlzhG1IOMb7PsFAI6wCVrE3vXgEU74aJgwrrfD
	j+Yor2t4qihQXPJb82lYV7k8KbNDmVhIWL9FEuN0hEDfw/93Bubd6rGhWOAwTANHjiWWI+7YE7H
	zR7bLpW4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbtuRXh7bFKB7ix9E/TC3AL3ybcG
	3TIpTNBiQLLXLUrIcwwcR1iQx3w4vuvB6gAgryg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.876200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3FA5CF227FA688B9ED5C95E371D03EFA03A856FC4BB09CFFA7C918D01B46690C2000:8

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjMtMTItMjQgYXQgMDI6MjkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsX2Fk
YXB0b3IgYW5kIHN1YiBkcml2ZXINCj4gbWRwX3JkbWEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgICAgfCAgMSArDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyB8IDE1ICsrKysrKysr
KysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyAg
ICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMgICAg
ICAgICB8IDExICsrKysrKysrLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21k
cF9yZG1hLmggICAgICAgICB8ICAyICsrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX2Rydi5oDQo+IGluZGV4IDc3MDU0YWRjZDljZi4uZWM5NzQ2NzY3NDY4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xMTcsNiArMTE3
LDcgQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZQ0KPiAq
ZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHVuc2lnbmVkIGludCB3LA0KPiAgCQkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQg
dnJlZnJlc2gsDQo+ICAJCQkgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+
ICpjbWRxX3BrdCk7DQo+ICt1NjQgbXRrX292bF9hZGFwdG9yX2dldF9zZWNfcG9ydChzdHJ1Y3Qg
bXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZA0KPiBpbnQgaWR4KTsNCj4gIHZvaWQgbXRrX292
bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludA0K
PiBpZHgsDQo+ICAJCQkJICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSwNCj4gIAkJCQkg
IHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBpbmRleCA2YmY2MzY3ODUzZmIuLmY0
MTljMmU3MGJhMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTgzLDYgKzgzLDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb3ZsX2FkYXB0b3JfY29tcF9tYXRjaA0KPiBjb21wX21hdGNoZXNbT1ZMX0FEQVBUT1JfSURf
TUFYXSA9IHsNCj4gIAlbT1ZMX0FEQVBUT1JfRVRIRFIwXQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9F
VEhEUiwgMCB9LA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHU2NCBvdmxfYWRhcHRvcl9z
ZWNfcG9ydFtdID0gew0KPiArCUJJVF9VTEwoQ01EUV9TRUNfVkRPMV9ESVNQX1JETUFfTDApLA0K
PiArCUJJVF9VTEwoQ01EUV9TRUNfVkRPMV9ESVNQX1JETUFfTDEpLA0KPiArCUJJVF9VTEwoQ01E
UV9TRUNfVkRPMV9ESVNQX1JETUFfTDIpLA0KPiArCUJJVF9VTEwoQ01EUV9TRUNfVkRPMV9ESVNQ
X1JETUFfTDMpLA0KPiArfTsNCj4gKw0KPiArdTY0IG10a19vdmxfYWRhcHRvcl9nZXRfc2VjX3Bv
cnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQNCj4gaW50IGlkeCkNCj4gK3sN
Cj4gKwlyZXR1cm4gb3ZsX2FkYXB0b3Jfc2VjX3BvcnRbaWR4XTsNCj4gK30NCj4gKw0KPiAgdm9p
ZCBtdGtfb3ZsX2FkYXB0b3JfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWdu
ZWQgaW50DQo+IGlkeCwNCj4gIAkJCQkgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlLA0K
PiAgCQkJCSAgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gQEAgLTE0MSw2ICsxNTMsOSBA
QCB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZQ0KPiAqZGV2
LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCXJkbWFfY29uZmlnLnBpdGNoID0gcGVuZGluZy0+cGl0
Y2g7DQo+ICAJcmRtYV9jb25maWcuZm10ID0gcGVuZGluZy0+Zm9ybWF0Ow0KPiAgCXJkbWFfY29u
ZmlnLmNvbG9yX2VuY29kaW5nID0gcGVuZGluZy0+Y29sb3JfZW5jb2Rpbmc7DQo+ICsJcmRtYV9j
b25maWcuc291cmNlX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkgKiBwZW5kaW5nLQ0KPiA+
cGl0Y2ggKw0KPiArCQkJCSAgcGVuZGluZy0+d2lkdGggKiBmbXRfaW5mby0+Y3BwWzBdOw0KPiAr
CXJkbWFfY29uZmlnLmlzX3NlY3VyZSA9IHN0YXRlLT5wZW5kaW5nLmlzX3NlY3VyZTsNCj4gIAlt
dGtfbWRwX3JkbWFfY29uZmlnKHJkbWFfbCwgJnJkbWFfY29uZmlnLCBjbWRxX3BrdCk7DQo+ICAN
Cj4gIAlpZiAodXNlX2R1YWxfcGlwZSkgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggNmFlZDc2NDdkZmMwLi45YjdmZTM0ZGY5YTYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0K
PiBAQCAtNDQ1LDYgKzQ0NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1
bmNzDQo+IGRkcF9vdmxfYWRhcHRvciA9IHsNCj4gIAkucmVtb3ZlID0gbXRrX292bF9hZGFwdG9y
X3JlbW92ZV9jb21wLA0KPiAgCS5nZXRfZm9ybWF0cyA9IG10a19vdmxfYWRhcHRvcl9nZXRfZm9y
bWF0cywNCj4gIAkuZ2V0X251bV9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9yX2dldF9udW1fZm9y
bWF0cywNCj4gKwkuZ2V0X3NlY19wb3J0ID0gbXRrX292bF9hZGFwdG9yX2dldF9zZWNfcG9ydCwN
Cj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbXRrX2RkcF9jb21wX3N0
ZW1bTVRLX0REUF9DT01QX1RZUEVfTUFYXSA9DQo+IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfbWRwX3JkbWEuYw0KPiBpbmRleCBjM2FkYWVlZmQ1NTEuLmExNjRiYTgyZDAyMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYw0KPiBAQCAtOTQs
NiArOTQsNyBAQCBzdHJ1Y3QgbXRrX21kcF9yZG1hIHsNCj4gIAl2b2lkIF9faW9tZW0JCSpyZWdz
Ow0KPiAgCXN0cnVjdCBjbGsJCSpjbGs7DQo+ICAJc3RydWN0IGNtZHFfY2xpZW50X3JlZwljbWRx
X3JlZzsNCj4gKwlyZXNvdXJjZV9zaXplX3QJCXJlZ3NfcGE7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgdW5zaWduZWQgaW50IHJkbWFfZm10X2NvbnZlcnQodW5zaWduZWQgaW50IGZtdCkNCj4gQEAg
LTE5OCw5ICsxOTksMTIgQEAgdm9pZCBtdGtfbWRwX3JkbWFfY29uZmlnKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gc3RydWN0IG10a19tZHBfcmRtYV9jZmcgKmNmZywNCj4gIAllbHNlDQo+ICAJCW10
a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LQ0KPiA+
cmVncywNCj4gIAkJCQkgICBNRFBfUkRNQV9TUkNfQ09OLCBGTERfT1VUUFVUX0FSR0IpOw0KPiAt
DQo+IC0JbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBjZmctPmFkZHIwLCAmcHJpdi0+Y21k
cV9yZWcsIHByaXYtDQo+ID5yZWdzLA0KPiAtCQkJICAgTURQX1JETUFfU1JDX0JBU0VfMCwgRkxE
X1NSQ19CQVNFXzApOw0KPiArCWlmIChjZmctPmlzX3NlY3VyZSkNCj4gKwkJbXRrX2RkcF9zZWNf
d3JpdGUoY21kcV9wa3QsIHByaXYtPnJlZ3NfcGEgKw0KPiBNRFBfUkRNQV9TUkNfQkFTRV8wLA0K
PiArCQkJCSAgY2ZnLT5hZGRyMCwgQ01EUV9JV0NfSF8yX01WQSwgMCwgY2ZnLQ0KPiA+c291cmNl
X3NpemUsIDApOw0KDQpJbiBPVkwsIHRoZXJlIGlzIG9uZSBiaXQgdGhhdCBjb250cm9sIE9WTCBo
YXJkd2FyZSBjb3VsZCBhY2Nlc3Mgc2VjdXJlDQpidWZmZXIgb3Igbm90LiBXaHkgbWRwIHJkbWEg
aGFzIG5vIHRoaXMgYml0Pw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCWVsc2UNCj4gKwkJbXRrX2Rk
cF93cml0ZV9tYXNrKGNtZHFfcGt0LCBjZmctPmFkZHIwLCAmcHJpdi0NCj4gPmNtZHFfcmVnLCBw
cml2LT5yZWdzLA0KPiArCQkJCSAgIE1EUF9SRE1BX1NSQ19CQVNFXzAsDQo+IEZMRF9TUkNfQkFT
RV8wKTsNCj4gIA0KPiAgCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgc3JjX3BpdGNoX3ks
ICZwcml2LT5jbWRxX3JlZywNCj4gcHJpdi0+cmVncywNCj4gIAkJCSAgIE1EUF9SRE1BX01GX0JL
R0RfU0laRV9JTl9CWVRFLA0KPiBGTERfTUZfQktHRF9XQik7DQo+IEBAIC0yODUsNiArMjg5LDcg
QEAgc3RhdGljIGludCBtdGtfbWRwX3JkbWFfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAlyZXMgPSBwbGF0Zm9ybV9n
ZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCXByaXYtPnJlZ3NfcGEg
PSByZXMtPnN0YXJ0Ow0KPiAgCXByaXYtPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2
LCByZXMpOw0KPiAgCWlmIChJU19FUlIocHJpdi0+cmVncykpIHsNCj4gIAkJZGV2X2VycihkZXYs
ICJmYWlsZWQgdG8gaW9yZW1hcCByZG1hXG4iKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfbWRwX3JkbWEuaA0KPiBpbmRleCA5OTQzZWUzYWFjMzEuLmNkNDg0MDQxMTQxMSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuaA0KPiBAQCAtMTUsNiAr
MTUsOCBAQCBzdHJ1Y3QgbXRrX21kcF9yZG1hX2NmZyB7DQo+ICAJdW5zaWduZWQgaW50CXlfdG9w
Ow0KPiAgCWludAkJZm10Ow0KPiAgCWludAkJY29sb3JfZW5jb2Rpbmc7DQo+ICsJdW5zaWduZWQg
aW50CXNvdXJjZV9zaXplOw0KPiArCXVuc2lnbmVkIGludAlpc19zZWN1cmU7DQo+ICB9Ow0KPiAg
DQo+ICAjZW5kaWYgLy8gX19NVEtfTURQX1JETUFfSF9fDQo=

