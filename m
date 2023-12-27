Return-Path: <linux-kernel+bounces-11802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25181EBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53425283142
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B72CA5;
	Wed, 27 Dec 2023 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Soy1Y4id";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mXp0XCqg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35B5220;
	Wed, 27 Dec 2023 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8f770c42a46611ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4j8hvQJFvEoAYCw8KskiW5d2doUGZDec9u7Fy1s9aAM=;
	b=Soy1Y4idSrnaiZcOBQhbR/vyG8aRjenhiC06aKsvIXsuuwME0pHum5kVdES41faRAiNpaM5gE9UMYJHPf7DkgONZZiPcRNE4zlPVKdrx1qVze2Mc62Pm5B91Eu0CpqssrW+MvW5Z0JEzQJRPozXydiVO7H/q+GoTJExnBFVcOdQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9a801df5-aed4-419e-a9bd-5351a39c2325,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:7ec29b8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 8f770c42a46611ee9e680517dc993faa-20231227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 744222216; Wed, 27 Dec 2023 11:18:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 11:18:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 11:18:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLr1t2z77N0G0PvJlrepv0er7VIFRWjZnNwgmb/Ka89bUvVTPVxcufzYBn9eOAfrArjsmtZV/0rLaHMY2qkzsBU9sqb69GKTimJsVQ5ctXRAVL6FI5eHu4oey5BEtBd3i4LKLPddfBzWZZ1tFAyJAPRaoI1njJN9jbjqWEtSfERUo0Uk1w8e3C9zZsbrGIav7wAHuft/fc2eK/gUqOJkoABxWfL/6hm08KB1zsD1d5vOg+5GzpW9ktjX9La6Xil4X/bbm07FvjJH48I4y40TMXm4pjdNlpYYKSqoyEoXG89iAV3tsxxRVZpvD1PgowN/N0AEwsOivGAMPkymuYoQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j8hvQJFvEoAYCw8KskiW5d2doUGZDec9u7Fy1s9aAM=;
 b=AEM+FtcHEeChXoXt49G5gBER9g43gpZ7PK3nthhjfTm3SyENxJP+odi53fV/2bLd0WSsIpxC167ME/bgYOLKL4fCIMuzI0/J6v9VPoKcIw/7hNAF78/yqr+To4jZOno4eXS2lfzsgHeR3WfxNCpcqfcohp4cGM+ml4vDIpNYgBGQygpg2afg/89JAXrxT3P4tQxhsA8oWM1MN7StqW8Erbt049M46JCOmYeOgd3XR2GE9911IeThfvjOm9mc/7L+1G7lI5v+eA7evdqYTmMM6PLDzhnlcT2dIwLZJLFUpp/AK5urs9dwVaKz1WcTMUtGAhRVSAklmVzYfHXg9wQavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j8hvQJFvEoAYCw8KskiW5d2doUGZDec9u7Fy1s9aAM=;
 b=mXp0XCqge1Sx62vFkRndjMs9jnQNnwswXOEJxB+X3CmZxkuKqiSzjQZw7knFmic/eAac/k2MgsssGa3jutOkGxlPEUbtwvhfci7nS6GBg4r2+YeWk1lKu48yj/qPdMvwfRV4lSd26/UB1RcGEYdCt0mLcMYNv25l1nklGLcBs8g=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7498.apcprd03.prod.outlook.com (2603:1096:400:413::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 03:18:04 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 03:18:04 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "drinkcat@chromium.org"
	<drinkcat@chromium.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 01/11] drm/mediatek: Add interface to allocate MediaTek
 GEM buffer.
Thread-Topic: [PATCH v3 01/11] drm/mediatek: Add interface to allocate
 MediaTek GEM buffer.
Thread-Index: AQHaNc3/Bo95NNkdkk+3zrmkbIBoNLC5t2yAgALDkoA=
Date: Wed, 27 Dec 2023 03:18:04 +0000
Message-ID: <323607d815bf7ad593144dceecc387af1f661729.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-2-jason-jh.lin@mediatek.com>
	 <4169f943f6e82da50243d91614ab73d6b5f57c8a.camel@mediatek.com>
In-Reply-To: <4169f943f6e82da50243d91614ab73d6b5f57c8a.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7498:EE_
x-ms-office365-filtering-correlation-id: f882ce61-ed8e-468d-5a2e-08dc068a707d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NqkCR4wjcjXxdv+bRazR3VwGa7gbunBZjLnWV5nmCLndFg7cEyoXa4RpKq/8Ps/+FP4JiZcffvzCiltQtp/6gurUwhlzCC1gA7pM+ae3bjcOsNemcV/IuDAVPiYPVYSOu8s4jtbDail+NIcLQakrGwmgC1RUzytz7k0WN19bP36zG+UebpmXtFeNG3U12HjzAKf/1JY2et+xkFeF9DKKNfUJqILJ5dooI5E05+iKHT2BKHsuwgqKlOCcmig+rFzeQe0VrhW6x0GHG6/ITIOplz5SKnqUWob0LrFV3FZLHHkQEmV0u1bOPyyoPYJuoNPLecqj77lUKfICPc6Sr8fNsePp4wc08DYW/T+3oaAJqMkNcTItS+hyMG0JuY2Gw6WjRXlUyBn0qJWcPzIcW9RwcuCdi0S6acTlpvTavpM1dv2f+9c2z1idEtQ+S0yz6saQ6cTyArAt38ixvSKem1umvmu0ba53HUSoDnqcntywfSiKkrgaToMDq9urnztJa62TnVouHSdvXk7SFmKNO9r89g6DOcKbC4Y4bSZ6vqFEUEro49j3IbdKnyGXrHMeuIuci3Y6VS/3FuA5zS3hvJhwFLEF/fpTONA5kau8sWuapK76jnJHTP/eRT46TcimK/xkD1tH+dKitXufbx7nzM/6o7JS7CuWC3Ekg3mSg2VMtxx19LKyoTNqLIw1W9gpce8x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(86362001)(26005)(2616005)(71200400001)(6512007)(6506007)(83380400001)(478600001)(4326008)(8676002)(8936002)(5660300002)(7416002)(6486002)(66556008)(64756008)(66446008)(316002)(76116006)(66476007)(110136005)(66946007)(54906003)(91956017)(38100700002)(122000001)(41300700001)(4001150100001)(38070700009)(2906002)(36756003)(85182001)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0lwR2NvTGQ2dVRiRGFWN2lEeXFHWHVYSTE2Y3Z1b1NrZXhxeWZMTU5Pbndh?=
 =?utf-8?B?M3NKa0NzOGx2OXZ6cnlSVTVGc1pmNE55UXV4WDFwY3pFd0xqR0tlZ2ZFNWZ3?=
 =?utf-8?B?Z3hRMk0wSmVFa0xmcEcyRVlhTHd4S2gxcDViUTlua1k2N00rM0JJam55QTRZ?=
 =?utf-8?B?TkpaeHdqZC9SQU1HbnFsY1FHOHpOZjF2T3dzcXAzaVVKRU5rUXdJcm9jSnNO?=
 =?utf-8?B?Q2tCVmdVdnNLVUx2b1hiUUhBRENDajJRdUxCWnZuTzhTWFpIblp6OHNYbU5G?=
 =?utf-8?B?NHZSelQyUndGbjVHNTJvUjRUbVpTSGhCaW1oZWs5U0ptNTJHVWZvZThSd2dU?=
 =?utf-8?B?ejVaNkdVWkEyZXI3Mk1tRDl5Lzl0NHJ6NWY1M1ZMSFBjVGJoV24waFNDSEUx?=
 =?utf-8?B?V3d0Zk9sQm9ER2s3UEZYd2FEaXh5WGRnbHRYQUQ4My9XMTFIVUFaYlBuME0v?=
 =?utf-8?B?U1hrUmxGbmJ0aGZUN0U1VGkyWGhqVW9mUlF5MUorTnhSRnRVZWVvek1hZlVw?=
 =?utf-8?B?alZ6ZlNXMURuand0bUlxRzRPVytiZFV0SUt6M1VoaC9DZTgyRlpZUjVJWkpq?=
 =?utf-8?B?bWdqWXpqS3Z3TW4rYnRoQWxzVTRTK0NQZ1VLTzAzY3JuUFkvSGVDaEdMWjBG?=
 =?utf-8?B?enhsYmlIaWhlMUJyZzRObng4S0h5V1pwdTArRUR3T1ZTZFoyTmg3MG9HRGJZ?=
 =?utf-8?B?b3VVRnU0Q1JPVU5xajhVV3ozRHZHN0puZWVLVytGQXJZSVVmWkxSRnJCSlZ5?=
 =?utf-8?B?THZjMmRnMGpMbUhpdmFwS1IrWXdubEFtaitNZE1Da3VjajkrT3R5c2x1Wmhr?=
 =?utf-8?B?djJaV0xvN2N5U3JESHZyUTV5NXFlNXVNVWlKQndHUXpvOGZnMlVjU0F2Q1Vo?=
 =?utf-8?B?VmlrS2hhYjZMTHhXVnBlNmI0WFhHNEhsNjYwOHB5Mzl6WGZyamQxSXFQeUFO?=
 =?utf-8?B?c0g3RG01V29aZWNPd2kweE5HZTNmQkdBNXlaSzNJdnF3dURQTGl2bXQ0MFUz?=
 =?utf-8?B?d1UxNmtUdzZNQ0dMblNKd1l6Y28wZmRXWjFEbFRCWk5VMzc5TmZ6ZXJsNnpE?=
 =?utf-8?B?cGcxTlllaEtNSnA3disvVEpxSmhBZ3N1U2NyeGN6RlEzRWFpWGxMNHFac0o3?=
 =?utf-8?B?bFFqOHRKSGppQjlLWkNPeXFKWlhxWGF5WDdtVHowVTdzWC9NSW5yMkkrdm5G?=
 =?utf-8?B?V1UwQVFWemllelJyMGk3b2Z4NmlxeDRBdUdqb0tmZXRaanR0bFBZMjZRcnox?=
 =?utf-8?B?NUUySkZyOGRMQ0lwai9XQWloeFcxamNvSERwVEFLb01yUm5zc05pTVRQb09j?=
 =?utf-8?B?ajA4MUZiUGQ2Rnd6eVVpbytJWlZPa040cjh5dXlDRGxJWkQ1cm9tb1o4TklT?=
 =?utf-8?B?LzRtZUNxUGh0RVZydG03cy8wejJ5OWR3UDBtSWVLcGlqWHpSbUZhUzVnY2Ev?=
 =?utf-8?B?RFZSdmMrcTdXcHVSUmFJVldxQ1JLaVVnYWQ2TVliRjBqZ2lVVGFHVktyeXUr?=
 =?utf-8?B?MjY1WWpxUzUzSTcxYkpMTkh5d09pWDVjUVJZNUJXZlMxT1RPeTgzUG5KMzRD?=
 =?utf-8?B?OVBHbkFTVDc2UG8vMW5LS2RzVnNaM1ZuWWV0aTRUZlBNdTZ5M2tTa0l6YWFy?=
 =?utf-8?B?a0E0QVBnQnVFcFFNQjZZVUl0bXkzMTJPc0RrNjB4QTRIbUVsY09jSjl4UTJ1?=
 =?utf-8?B?VCtpLzZnbHlicGNackUvQ084YkdtUVl0RnR5VGFxMUhlZUY2OXNQKzc0R0p6?=
 =?utf-8?B?TVpoTzFEakNXV050Z3hoUkVVQ1VyanBsS28yaDZBWDZvMjJZT0xYUkNYdm9E?=
 =?utf-8?B?dm1FNFdyRDd1TjNCR3BDRW5TNEQwaVhRQjVjZlF6Z2tCbVE3VDJWV2dpT2hq?=
 =?utf-8?B?N2poU2FlMGg4UmNqRDFXS3ZidmhlZUkvcU11NnVRMlJ1Qm56RWpNL1VrNitY?=
 =?utf-8?B?SDhtaFRIVjdPLzNsaVBUOWlxanQ5U3p4Wjk0eFdQTUE4bjk3eWhtZWVyN3lD?=
 =?utf-8?B?eHBLeXBWRmd4UjZ4NHM4OXF0RFFtMnNpUHNYU3F5VS81czZ6L0xXR1BUd1Zk?=
 =?utf-8?B?T3hNNW01aVhpeWhDRlM3ZmZPcVlFbTBzdzNsTlh4MTVKNXJJbWg1TlZLSjlY?=
 =?utf-8?B?WXorWHNwWXorS1Jtb0VCWmxXRzJKZXVQSTkraktTcWNBQUhaeGQrR2VEa09H?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A14ED001A75104187299DC23A1C1245@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f882ce61-ed8e-468d-5a2e-08dc068a707d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 03:18:04.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVdlVJtX6gmW0MYI48W8SmHiYhaYIuOZpcakBppi42Z9IRpy+qOR4E8YI7Z3U7+whTEnDKfMfXSwMBSxdUys5SWKAZ8Pl/MjlVlBJjpX11w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7498

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIE1vbiwgMjAyMy0xMi0yNSBh
dCAwOTowNSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IA0KPiBPbiBTdW4sIDIwMjMtMTItMjQgYXQgMDI6MjkgKzA4MDAsIEphc29uLUpILkxpbiB3
cm90ZToNCj4gPiBGcm9tOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFk
ZCBhbiBpbnRlcmZhY2UgdG8gYWxsb2NhdGUgTWVkaWFUZWsgR0VNIGJ1ZmZlcnMsIGFsbG93IHRo
ZSBJT0NUTHMNCj4gPiB0byBiZSB1c2VkIGJ5IHJlbmRlciBub2Rlcy4NCj4gPiBUaGlzIHBhdGNo
IGFsc28gc2V0cyB0aGUgUkVOREVSIGRyaXZlciBmZWF0dXJlLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmlj
b2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IERhbmllbCBLdXJ0eiA8ZGprdXJ0ekBjaHJvbWl1bS5vcmc+DQo+ID4gUmV2aWV3ZWQtYnk6
IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiA+IFRlc3RlZC1ieTog
RGFuaWVsIEt1cnR6IDxkamt1cnR6QGNocm9taXVtLm9yZz4NCj4gPiBUZXN0ZWQtYnk6IFBpLUhz
dW4gU2hpaCA8cGloc3VuQGNocm9taXVtLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgfCAxMyArKysrKysNCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMgfCAzOSArKysrKysrKysrKysrKysrKw0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uaCB8IDEyICsrKysrKw0KPiA+ICBp
bmNsdWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5oICAgICAgICB8IDU4DQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMjIgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0u
aA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4g
PiBpbmRleCAyYjBjMzVjYWNiYzYuLjVkMmEzOWU0OTFhYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gQEAgLTI0LDYgKzI0LDcgQEANCj4gPiAg
I2luY2x1ZGUgPGRybS9kcm1fb2YuaD4NCj4gPiAgI2luY2x1ZGUgPGRybS9kcm1fcHJvYmVfaGVs
cGVyLmg+DQo+ID4gICNpbmNsdWRlIDxkcm0vZHJtX3ZibGFuay5oPg0KPiA+ICsjaW5jbHVkZSA8
ZHJtL21lZGlhdGVrX2RybS5oPg0KPiA+ICANCj4gPiAgI2luY2x1ZGUgIm10a19kcm1fY3J0Yy5o
Ig0KPiA+ICAjaW5jbHVkZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiA+IEBAIC01NjksNiArNTcw
LDE0IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fa21zX2RlaW5pdChzdHJ1Y3QNCj4gPiBkcm1fZGV2
aWNlDQo+ID4gKmRybSkNCj4gPiAgCWNvbXBvbmVudF91bmJpbmRfYWxsKGRybS0+ZGV2LCBkcm0p
Ow0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9pb2N0bF9kZXNj
IG10a19pb2N0bHNbXSA9IHsNCj4gPiArCURSTV9JT0NUTF9ERUZfRFJWKE1US19HRU1fQ1JFQVRF
LCBtdGtfZ2VtX2NyZWF0ZV9pb2N0bCwNCj4gPiArCQkJICBEUk1fVU5MT0NLRUQgfCBEUk1fQVVU
SCB8IERSTV9SRU5ERVJfQUxMT1cpLA0KPiA+ICsJRFJNX0lPQ1RMX0RFRl9EUlYoTVRLX0dFTV9N
QVBfT0ZGU0VULA0KPiA+ICsJCQkgIG10a19nZW1fbWFwX29mZnNldF9pb2N0bCwNCj4gPiArCQkJ
ICBEUk1fVU5MT0NLRUQgfCBEUk1fQVVUSCB8IERSTV9SRU5ERVJfQUxMT1cpLA0KPiANCj4gRm9y
IHNlY3VyZSBidWZmZXIsIHdlIGRvbid0IG5lZWQgbWFwIG9mZnNldCBmdW5jdGlvbi4gSWYgeW91
IHJlYWxseQ0KPiBuZWVkIHRoaXMgZnVuY3Rpb24sIHNlcGFyYXRlIHRoaXMgdG8gYW5vdGhlciBw
YXRjaCBhbmQgZGVzY3JpYmUgd2h5DQo+IG5lZWQgdGhpcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IENL
DQoNCk9LLCBJJ2xsIHJlbW92ZSB0aGlzIGZ1bmN0aW9uLg0KDQpSZWdhcmRzDQpKYXNvbi1KSC5M
aW4NCj4gDQo+ID4gK307DQo+ID4gKw0KPiA+ICBERUZJTkVfRFJNX0dFTV9GT1BTKG10a19kcm1f
Zm9wcyk7DQo+ID4gIA0KPiA+ICAvKg0KPiA+IEBAIC01OTAsNiArNTk5LDEwIEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZHJtX2RyaXZlciBtdGtfZHJtX2RyaXZlcg0KPiA+ID0NCj4gPiB7DQo+ID4g
IA0KPiA+ICAJLmdlbV9wcmltZV9pbXBvcnQgPSBtdGtfZHJtX2dlbV9wcmltZV9pbXBvcnQsDQo+
ID4gIAkuZ2VtX3ByaW1lX2ltcG9ydF9zZ190YWJsZSA9IG10a19nZW1fcHJpbWVfaW1wb3J0X3Nn
X3RhYmxlLA0KPiA+ICsNCj4gPiArCS5pb2N0bHMgPSBtdGtfaW9jdGxzLA0KPiA+ICsJLm51bV9p
b2N0bHMgPSBBUlJBWV9TSVpFKG10a19pb2N0bHMpLA0KPiA+ICsNCj4gPiAgCS5mb3BzID0gJm10
a19kcm1fZm9wcywNCj4gPiAgDQo+ID4gIAkubmFtZSA9IERSSVZFUl9OQU1FLA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gPiBpbmRleCA0ZjJlM2ZlYWJj
MGYuLjMwZTM0N2FkY2JlOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9nZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2dlbS5jDQo+ID4gQEAgLTQsNiArNCw3IEBADQo+ID4gICAqLw0KPiA+ICANCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L2RtYS1idWYuaD4NCj4gPiArI2luY2x1ZGUgPGRybS9tZWRpYXRla19kcm0u
aD4NCj4gPiAgDQo+ID4gICNpbmNsdWRlIDxkcm0vZHJtLmg+DQo+ID4gICNpbmNsdWRlIDxkcm0v
ZHJtX2RldmljZS5oPg0KPiA+IEBAIC0yODMsMyArMjg0LDQxIEBAIHZvaWQgbXRrX2RybV9nZW1f
cHJpbWVfdnVubWFwKHN0cnVjdA0KPiA+IGRybV9nZW1fb2JqZWN0ICpvYmosDQo+ID4gIAltdGtf
Z2VtLT5rdmFkZHIgPSBOVUxMOw0KPiA+ICAJa2ZyZWUobXRrX2dlbS0+cGFnZXMpOw0KPiA+ICB9
DQo+ID4gKw0KPiA+ICtpbnQgbXRrX2dlbV9tYXBfb2Zmc2V0X2lvY3RsKHN0cnVjdCBkcm1fZGV2
aWNlICpkcm0sIHZvaWQgKmRhdGEsDQo+ID4gKwkJCSAgICAgc3RydWN0IGRybV9maWxlICpmaWxl
X3ByaXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkcm1fbXRrX2dlbV9tYXBfb2ZmICphcmdzID0g
ZGF0YTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZHJtX2dlbV9kdW1iX21hcF9vZmZzZXQoZmlsZV9w
cml2LCBkcm0sIGFyZ3MtPmhhbmRsZSwNCj4gPiArCQkJCSAgICAgICAmYXJncy0+b2Zmc2V0KTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAraW50IG10a19nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQo+ID4gKwkJCSBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGVf
cHJpdikNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19kcm1fZ2VtX29iaiAqbXRrX2dlbTsNCj4g
PiArCXN0cnVjdCBkcm1fbXRrX2dlbV9jcmVhdGUgKmFyZ3MgPSBkYXRhOw0KPiA+ICsJaW50IHJl
dDsNCj4gPiArDQo+ID4gKwltdGtfZ2VtID0gbXRrX2RybV9nZW1fY3JlYXRlKGRldiwgYXJncy0+
c2l6ZSwgZmFsc2UpOw0KPiA+ICsJaWYgKElTX0VSUihtdGtfZ2VtKSkNCj4gPiArCQlyZXR1cm4g
UFRSX0VSUihtdGtfZ2VtKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogYWxsb2NhdGUgYSBp
ZCBvZiBpZHIgdGFibGUgd2hlcmUgdGhlIG9iaiBpcyByZWdpc3RlcmVkDQo+ID4gKwkgKiBhbmQg
aGFuZGxlIGhhcyB0aGUgaWQgd2hhdCB1c2VyIGNhbiBzZWUuDQo+ID4gKwkgKi8NCj4gPiArCXJl
dCA9IGRybV9nZW1faGFuZGxlX2NyZWF0ZShmaWxlX3ByaXYsICZtdGtfZ2VtLT5iYXNlLCAmYXJn
cy0NCj4gPiA+IGhhbmRsZSk7DQo+ID4gDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWdvdG8gZXJy
X2hhbmRsZV9jcmVhdGU7DQo+ID4gKw0KPiA+ICsJLyogZHJvcCByZWZlcmVuY2UgZnJvbSBhbGxv
Y2F0ZSAtIGhhbmRsZSBob2xkcyBpdCBub3cuICovDQo+ID4gKwlkcm1fZ2VtX29iamVjdF9wdXQo
Jm10a19nZW0tPmJhc2UpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICsNCj4gPiArZXJy
X2hhbmRsZV9jcmVhdGU6DQo+ID4gKwltdGtfZHJtX2dlbV9mcmVlX29iamVjdCgmbXRrX2dlbS0+
YmFzZSk7DQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9nZW0uaA0KPiA+IGluZGV4IDc4ZjIzYjA3YTAyZS4uOTBmM2QyOTE2
ZWM1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dl
bS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmgNCj4g
PiBAQCAtNDYsNCArNDYsMTYgQEAgaW50IG10a19kcm1fZ2VtX3ByaW1lX3ZtYXAoc3RydWN0IGRy
bV9nZW1fb2JqZWN0DQo+ID4gKm9iaiwgc3RydWN0IGlvc3lzX21hcCAqbWFwKTsNCj4gPiAgdm9p
ZCBtdGtfZHJtX2dlbV9wcmltZV92dW5tYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosDQo+
ID4gIAkJCSAgICAgIHN0cnVjdCBpb3N5c19tYXAgKm1hcCk7DQo+ID4gIA0KPiA+ICsvKg0KPiA+
ICsgKiByZXF1ZXN0IGdlbSBvYmplY3QgY3JlYXRpb24gYW5kIGJ1ZmZlciBhbGxvY2F0aW9uIGFz
IHRoZSBzaXplDQo+ID4gKyAqIHRoYXQgaXQgaXMgY2FsY3VsYXRlZCB3aXRoIGZyYW1lYnVmZmVy
IGluZm9ybWF0aW9uIHN1Y2ggYXMNCj4gPiB3aWR0aCwNCj4gPiArICogaGVpZ2h0IGFuZCBicHAu
DQo+ID4gKyAqLw0KPiA+ICtpbnQgbXRrX2dlbV9jcmVhdGVfaW9jdGwoc3RydWN0IGRybV9kZXZp
Y2UgKmRldiwgdm9pZCAqZGF0YSwNCj4gPiArCQkJIHN0cnVjdCBkcm1fZmlsZSAqZmlsZV9wcml2
KTsNCj4gPiArDQo+ID4gKy8qIGdldCBidWZmZXIgb2Zmc2V0IHRvIG1hcCB0byB1c2VyIHNwYWNl
LiAqLw0KPiA+ICtpbnQgbXRrX2dlbV9tYXBfb2Zmc2V0X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYsIHZvaWQgKmRhdGEsDQo+ID4gKwkJCSAgICAgc3RydWN0IGRybV9maWxlICpmaWxlX3By
aXYpOw0KPiA+ICsNCj4gPiAgI2VuZGlmDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9k
cm0vbWVkaWF0ZWtfZHJtLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjRkNDc1
NzdjOTRlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vbWVk
aWF0ZWtfZHJtLmgNCj4gPiBAQCAtMCwwICsxLDU4IEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wKyBXSVRIIExpbnV4LXN5c2NhbGwtbm90ZSAqLw0KPiA+ICsvKg0K
PiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTUgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKg0KPiA+ICsg
KiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yDQo+ID4gbW9kaWZ5DQo+ID4gKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgdmVyc2lvbiAyDQo+ID4gYXMNCj4gPiArICogcHVibGlz
aGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQo+ID4gKyAqDQo+ID4gKyAqIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLA0KPiA+ICsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUg
aW1wbGllZCB3YXJyYW50eSBvZg0KPiA+ICsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+ID4gKyAqIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lm
bmRlZiBfVUFQSV9NRURJQVRFS19EUk1fSA0KPiA+ICsjZGVmaW5lIF9VQVBJX01FRElBVEVLX0RS
TV9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8ZHJtL2RybS5oPg0KPiA+ICsNCj4gPiArLyoqDQo+
ID4gKyAqIHN0cnVjdCBkcm1fbXRrX2dlbV9jcmVhdGUgLSBVc2VyLWRlc2lyZWQgYnVmZmVyIGNy
ZWF0aW9uDQo+ID4gaW5mb3JtYXRpb24gc3RydWN0dXJlLg0KPiA+ICsgKg0KPiA+ICsgKiBAc2l6
ZTogdXNlci1kZXNpcmVkIG1lbW9yeSBhbGxvY2F0aW9uIHNpemUuDQo+ID4gKyAqCS0gdGhpcyBz
aXplIHZhbHVlIHdvdWxkIGJlIHBhZ2UtYWxpZ25lZCBpbnRlcm5hbGx5Lg0KPiA+ICsgKiBAZmxh
Z3M6IHVzZXIgcmVxdWVzdCBmb3Igc2V0dGluZyBtZW1vcnkgdHlwZSBvciBjYWNoZQ0KPiA+IGF0
dHJpYnV0ZXMuDQo+ID4gKyAqIEBoYW5kbGU6IHJldHVybmVkIGEgaGFuZGxlIHRvIGNyZWF0ZWQg
Z2VtIG9iamVjdC4NCj4gPiArICoJLSB0aGlzIGhhbmRsZSB3aWxsIGJlIHNldCBieSBnZW0gbW9k
dWxlIG9mIGtlcm5lbCBzaWRlLg0KPiA+ICsgKi8NCj4gPiArc3RydWN0IGRybV9tdGtfZ2VtX2Ny
ZWF0ZSB7DQo+ID4gKwl1aW50NjRfdCBzaXplOw0KPiA+ICsJdWludDMyX3QgZmxhZ3M7DQo+ID4g
Kwl1aW50MzJfdCBoYW5kbGU7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogc3Ry
dWN0IGRybV9tdGtfZ2VtX21hcF9vZmYgLSBBIHN0cnVjdHVyZSBmb3IgZ2V0dGluZyBidWZmZXIN
Cj4gPiBvZmZzZXQuDQo+ID4gKyAqDQo+ID4gKyAqIEBoYW5kbGU6IGEgcG9pbnRlciB0byBnZW0g
b2JqZWN0IGNyZWF0ZWQuDQo+ID4gKyAqIEBwYWQ6IGp1c3QgcGFkZGluZyB0byBiZSA2NC1iaXQg
YWxpZ25lZC4NCj4gPiArICogQG9mZnNldDogcmVsYXRpdmVkIG9mZnNldCB2YWx1ZSBvZiB0aGUg
bWVtb3J5IHJlZ2lvbiBhbGxvY2F0ZWQuDQo+ID4gKyAqICAgICAtIHRoaXMgdmFsdWUgc2hvdWxk
IGJlIHNldCBieSB1c2VyLg0KPiA+ICsgKi8NCj4gPiArc3RydWN0IGRybV9tdGtfZ2VtX21hcF9v
ZmYgew0KPiA+ICsJdWludDMyX3QgaGFuZGxlOw0KPiA+ICsJdWludDMyX3QgcGFkOw0KPiA+ICsJ
dWludDY0X3Qgb2Zmc2V0Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArI2RlZmluZSBEUk1fTVRLX0dF
TV9DUkVBVEUJCTB4MDANCj4gPiArI2RlZmluZSBEUk1fTVRLX0dFTV9NQVBfT0ZGU0VUCQkweDAx
DQo+ID4gKw0KPiA+ICsjZGVmaW5lIERSTV9JT0NUTF9NVEtfR0VNX0NSRUFURQlEUk1fSU9XUihE
Uk1fQ09NTUFORF9CQVNFICsgXA0KPiA+ICsJCURSTV9NVEtfR0VNX0NSRUFURSwgc3RydWN0IGRy
bV9tdGtfZ2VtX2NyZWF0ZSkNCj4gPiArDQo+ID4gKyNkZWZpbmUgRFJNX0lPQ1RMX01US19HRU1f
TUFQX09GRlNFVAlEUk1fSU9XUihEUk1fQ09NTUFORF9CQQ0KPiA+IFNFICsgXA0KPiA+ICsJCURS
TV9NVEtfR0VNX01BUF9PRkZTRVQsIHN0cnVjdCBkcm1fbXRrX2dlbV9tYXBfb2ZmKQ0KPiA+ICsN
Cj4gPiArI2VuZGlmIC8qIF9VQVBJX01FRElBVEVLX0RSTV9IICovDQo=

