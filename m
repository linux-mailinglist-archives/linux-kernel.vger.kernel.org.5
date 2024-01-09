Return-Path: <linux-kernel+bounces-20724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C233C828439
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3655F1F22F31
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A436B1E;
	Tue,  9 Jan 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EKGdwkX2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Q+da2FQ8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3D364C7;
	Tue,  9 Jan 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5a307eb2aedc11ee9e680517dc993faa-20240109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hZ4atKULKmr38EldIdUWJZzcudaGRLqjKWY7mfo1OoQ=;
	b=EKGdwkX2QzQkxhb4kH5IrAUfkQMneBoLtZNBTxj3W4ki51ggBaU1wdtjZ2ksyYBUAliW48hAT753mIcENqjfRYB7xkV6ZXc3HfS2O8xu3JsO1Re4vWIeEcgfQvA32Ym/OSQEBJuyPeFaiyE/vyMeLuXbX+a/ImKrBTwSwF/F1I4=;
X-CID-CACHE: Type:Local,Time:202401091841+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5a499377-9d0d-47ae-a114-8abcd99d5617,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:21720e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5a307eb2aedc11ee9e680517dc993faa-20240109
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1762065679; Tue, 09 Jan 2024 18:46:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Jan 2024 18:46:31 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Jan 2024 18:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5ttJ8AZNDe0f3tgYFgCssOOJ7jhCulfzM6W+DPTMT9Wan4xfo87aeoS2Rb3nYatmjUAA65mcWzM8qWWY58r1nXdXcW+AcNWzSWajcr+bTh5DFpmuNn/DagMIwYHR/E+EYvIBxQSiaE0Gu1IAdgTxHkB+KO72NtWxlMj2ydtPhyo/hqCNSqm+43Kw5dCZ27XBeowYh5nvtnkCrAmRjqmDYiL7GSPiVYoue+V+Iq7xjaeO+0TtCUDPw9El+9zHRcm48fl1U4K/VeHnzXeQCPAyMMKZVuEcvW6eRQSfQq6TYgjeYpzb0HPy+UQaOP6RWdq2bXjptEYCvN1IC9KCorwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZ4atKULKmr38EldIdUWJZzcudaGRLqjKWY7mfo1OoQ=;
 b=JlEgZiWcFo8MAmE1gxnTY3XylsWWQIlsWWY9l559Q85YLCp0JO54zBetpOXUF4Zs8nf4gMKO/dlwhEStfLMMHBSJ67HrZkfwNuqYX/26VQ6CtEjRXJhJWB+7Ab/lgN55Kawow4w48QiSofC6LzOhT0ETaMrTw9n7t4Eh2iDSFEIOR4uHgQZCbjN844dBpBM6XJ4GqX0raFxjKTw9iI5oPMCG0LiayRrAchqP7O/DhBZ1uPc8dkb65cEgWD9wmGNDGZmiIilNllgKgmhNhky5C31prHxNoH+Ltlax6VKvKZKwJJ7rHuFokITvwzGhiTp6cF+7STiny3kpJrhDRzhuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZ4atKULKmr38EldIdUWJZzcudaGRLqjKWY7mfo1OoQ=;
 b=Q+da2FQ8U/D9YnEwU1A17oIJnO4HdeOipgmL27SwRN4RXyEQ9ccr5pKv1n+j/bsI9Z5hQPKfiHiMU0HpyOXVwEFQUqetpUsOaCe9Qsro/OwSg/IiF7/2e3FelUATkL0mhHI1VqMSeY9HI2BpHyQWS+H3mu13sZ/WThGJFFNzPIY=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by JH0PR03MB8843.apcprd03.prod.outlook.com (2603:1096:990:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 10:46:28 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 10:46:28 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "mchehab@kernel.org" <mchehab@kernel.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "yunkec@chromium.org"
	<yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "10572168@qq.com" <10572168@qq.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaKM07MRhkqnzY9kyFxe9G5PmOILCdekUAgDQGUAA=
Date: Tue, 9 Jan 2024 10:46:28 +0000
Message-ID: <ff85bb4675f1adf01f48cdcf89ef314ba4170ddb.camel@mediatek.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
	 <20231207052016.25954-2-zhi.mao@mediatek.com>
	 <1d58c2b9-4206-409c-b312-87f4fb649512@linaro.org>
In-Reply-To: <1d58c2b9-4206-409c-b312-87f4fb649512@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|JH0PR03MB8843:EE_
x-ms-office365-filtering-correlation-id: 6e7b1633-3ecc-4fd8-07c5-08dc11003c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0zf7gUvsBGT0hhGG2LPO1Jg6rgBzKdHaKT2SRHsk3enRdZ5o4yts3KCPnip/TBslXazOgWFk0hxxxk/XVh35iYHPoh2ElvUxdeNAmXrF1RyqZbNhNRcfzNxIDoPM1Q7MLVZq/CG/ECQohJ7NERlsuRoGn+S3HhQdTkhc3ZGKY4R3FHRKJsifNDuwzD5rE5xm71UblHTHv076/7CIOTQqEBJ9xyp+p0qlUOWKVCMBdipZQOYSoqzh9RW1ZQciIyQtvZve61SI+s2HLAm8MDK1Jwb0NTqPlijAidl2KRUzhFL87ArrrAanHGJoqFDW8BCcEgAk9Ds4h6G1qFuQB5uDOLAUO3XfNryvAvBcxcbNb6fCEJ4lBf5wFb/sRdWSxP7kwdnC1Vcdte/GmRMwMcXuW1W+S3VcHoXdpfp8+RaKJ2nyQzDcLVGHP677oN5t4zHpwDuMLg2gGUKRS0LXGyeyd7IvbqCefEtW4EoXLCqS7G96DW57NZxVaW4sTRNtACOMKopMqZWD/pyQvm5aXiUj5hjUAxtaOqG4IQwnUcaUkr028xWXxV8uZQ43Qv25kZcmBgZWYPq33Eru5M7LWoMf4t+jpqkWXlGYTxXJzVCa3n67v8VPqADBEZzXpA1O4bfcx++kf2w1op6rUuSzzUCnHUwPKZwR1LRvUtIEd2a1PF6vu444D8Y67BZSvmQrq5M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(6486002)(26005)(2616005)(478600001)(71200400001)(122000001)(38100700002)(6512007)(966005)(6506007)(53546011)(8676002)(66556008)(66946007)(54906003)(110136005)(8936002)(66446008)(66476007)(91956017)(76116006)(64756008)(316002)(83380400001)(4326008)(5660300002)(7416002)(2906002)(41300700001)(36756003)(86362001)(38070700009)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS9jTGwraFIvaXJUWXVhRmthbmJjbkQwRFVmNlhIT1YvRXNlV2NxVFVwbWMy?=
 =?utf-8?B?d2xvNExnSEZRYW9MY2JYZ1hlQUsrNlJpYWc0NUNXM1hnUC9Qa3QwSXdGdVdJ?=
 =?utf-8?B?N3lEajFwV2RnR28vcHA2aXo1ZW1sUmdDSjAwengxTjBHeFJzUVA5Vjc5cGUx?=
 =?utf-8?B?TWt6eFBBQW9SWWhheGdGRE0yVXd4REJtQkRCOE84YjVmR2tHNStJMmROQmo3?=
 =?utf-8?B?LzlNNG5jSWl3dzBrOTRNVmRpdE5vWHIyV1B1aUlpVzFTbVRnWldIa1gxR3Vu?=
 =?utf-8?B?YlZZYm51WlI4SnhHcmpqYnZtUUExSVVTWG5QNWpXb0hjZGF1TG9DSzE3bkJM?=
 =?utf-8?B?RnRJeUJJbm1LS2pXUldFbWJRdVcrT0RsQkxIN05PcEN4bU0yZUx5Rmp1WXFw?=
 =?utf-8?B?ellHcDgzeVJBdmdQT3RDb2c3N2tCYjloWmU0ZU02NGoxSkRtWkovOGhVR1ZJ?=
 =?utf-8?B?ZjZHL2l5K1RsdEJkdzFEN1hCVms3SnJEQThsTm42WWZVL1FxUFYrUFNsVU1W?=
 =?utf-8?B?MTRMREpuZ3gwOFBYZWtiWmEzV0dnd3NoNWs5WFlCZ2JmU3RpdFRkQjlYamVw?=
 =?utf-8?B?QU9PcFB6Uy9VUExlOG01QUtNKzNxWE1WanhJUlNxSjVmTGxXaXZBcjVLOGVj?=
 =?utf-8?B?RW55WU4wb3duc3A1U2FRMzlJeXM0Ujlwa0graWpSTlBYLzBpeHA3ZUdPdnJz?=
 =?utf-8?B?ZVdTNUN6RDRJUHZYdlUwNUcxd1VxZFA1VnNzT0J5WEFZTU9nbFhwRzVGSno0?=
 =?utf-8?B?RTlGQnhnV08weHluL0ljNzNNM1lSV2xPdnlZVGlCRmNPT3pkUWJ1elI0ajlY?=
 =?utf-8?B?WS82dEdOMUNnTFhGNi9mSSsyM0lFVmQzaGZYMTRxTVlLWnhscm52bVdnSGh3?=
 =?utf-8?B?NVd2MTZnYy9wdGFUOVdOaWNJNy9od2QyODRoV3JFT1hGb2pZQy9lcU41clpG?=
 =?utf-8?B?NVVxMmljeXkxb3VjSmRUdE94SWhTdXVFSVR0QmJSNXJIZVNYd2tBUnpld1FU?=
 =?utf-8?B?K0s4eHBEQi9pQmsrTGUvNzJzbVAzYTRNWHFYLy9EbnVMV0xTMzdRQnd2eUt0?=
 =?utf-8?B?OWVEZUFGY1hIc2ttajN3dkcrU2QzaXlvL1d5eVQzRG96VFBJbFRqZmt4N3pS?=
 =?utf-8?B?Y01UNTZpUWo4dTluUlhHUDZFZ2ZXdTA1aGFzdW5TdEtITlNTWUtnMVN1QkJl?=
 =?utf-8?B?YlVVcHJKQ3AyakxabE1hemFYMXdLY1l4RFcxZjVzS1hoeVZiblhqTy9aMHpr?=
 =?utf-8?B?YUQ3MVJwbGlnVUtlOFpuUDE3V1pyWEltSkM3RkdTdW8ySmtxNlkwVzVsUGNs?=
 =?utf-8?B?dWZsMUhYdUg4cGJsa3VjWHA1MDhTWU1VbElQejFXamtkMVJvemlETmxQUWt5?=
 =?utf-8?B?WEsycWJkN2Q1bjRad2VwY2o4NEd5OEpkNFg3SjFhZWpNK3M2aWdaM0ZwWDFW?=
 =?utf-8?B?YU1sNTEvc1Z1TzhpanpqUG1nZlYzNDB2SjFySTMxM3RjVFJNalozMmtkRXYr?=
 =?utf-8?B?MWJXWWI3TVNvUWIzVkRWNE5vWjk1aWNTRG1SYXNyd3YzL2dPdTB2bmd2Y1VR?=
 =?utf-8?B?dGxQOEpBdlFNZERLK2ZzWG02b2dCK3VQMW9sSEt2dGFQamRNaGFHendlTnZZ?=
 =?utf-8?B?a093OHE0MDZNb2pVUHFRV1lNeFFwUGlNMW9oUDA4aHJOR3FGVmJ0L0xRam56?=
 =?utf-8?B?RFlZYWF4UTkvS0F0UHJMbzBVem41SmlwT1dkYWRuY0JCdFMvKzNycExiZms5?=
 =?utf-8?B?VXdFdjdBY1doZXJrNnhUdHZLTGx1L2ZsWmxuVE1KVFY0VzlnUXFGTTdrYzRN?=
 =?utf-8?B?Zk9BMUNHeHVjOFVUa2FveEhoK3FFNm1wdklad211clU1UTNKd0Nad3RVYlhJ?=
 =?utf-8?B?RzF2a3pwai9GSmJsNHdMWUhOaVgwbS94YVNnTmc3Tzg2QjAwclR4QUdXam9h?=
 =?utf-8?B?L2M5KzlRcXdCdExVRVpGNWV6MWZoQm5CQVNncWs5ZVR6dWpHUmV0M2ovUmor?=
 =?utf-8?B?bVdlVmhUc0RBaTNDUzBGVGcyMmtPb2UwWjg3d0swc2tRK04rOTdYQUlsajRi?=
 =?utf-8?B?RmZUSDJEdUlCemJYWmxVandQQmJQOGs0SUpid1dKTnRNaDNSaGZOeXNLUWhH?=
 =?utf-8?B?akc3MDhlTndsZ2dIdit1TXJnS091ZDd5SWNSbHhReUNOQWpzdU4yZHFOUVdX?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BEF480D3AD7B74BBC3D1A4C04B0EAF1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7b1633-3ecc-4fd8-07c5-08dc11003c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 10:46:28.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LV8AsB7R/hyl0y29rzVUWVVzI0oXxd8S7AVZak4gXmxba18Au0DxgNjNBA+5YZJWu8pbpWuNBkjRI6K4GPv2rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8843

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDA5OjE4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDA3LzEyLzIwMjMgMDY6MjAsIFpoaSBNYW8gd3JvdGU6
DQo+ID4gQWRkIGEgVjRMMiBzdWItZGV2aWNlIGRyaXZlciBmb3IgR2FsYXh5Y29yZSBHQzA4QTMg
aW1hZ2Ugc2Vuc29yLg0KPiA+IA0KPiA+IFJldmlld2VkLUJ5OiB5dW5rZWNAY2hyb21pdW0ub3Jn
DQo+IA0KPiBJIGRvbid0IHNlZSByZXZpZXcgZ2l2ZW4gaGVyZToNCj4gDQo+IA0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWEvMjAyMzExMjMxMTUxMDQuMzIwOTQtMS16aGkubWFv
QG1lZGlhdGVrLmNvbS8NCj4gDQo+IFRoaXMgZG9lcyBub3QgbG9vayBsaWtlIHJlYWwgcmV2aWV3
LiBXaGVyZSB3YXMgaXQgcGVyZm9ybWVkPyBIb3cNCj4gdGhvcm91Z2ggd2FzIGl0PyBIb3cgbWFu
eSByZXZpZXcgaXRlcmF0aW9ucyBkaWQgaXQgaW5jbHVkZT8gIFdoeQ0KPiB0aGVyZQ0KPiBpcyBu
byBuYW1lIGJ1dCBhbm9ueW1vdXMgcmV2aWV3Pw0KPiANClttdGtdOiBTb3JyeSwgSSByZW1vdmVk
IHRoaXMgIlJldmlld2VkLUJ5OiIgbWVzc2dlLiBwbGVhc2UgcmV2aWV3DQpwYXRjaDp2MyANCj4g
DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9LY29uZmlnICB8ICAgMTQgKw0KPiA+ICBk
cml2ZXJzL21lZGlhL2kyYy9NYWtlZmlsZSB8ICAgIDEgKw0KPiA+ICBkcml2ZXJzL21lZGlhL2ky
Yy9nYzA4YTMuYyB8IDE4ODgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTkwMyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYw0KPiA+IA0KPiANCj4gLi4uDQo+
IA0KPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBnYzA4YTMgKnRvX2djMDhhMyhzdHJ1Y3QgdjRs
Ml9zdWJkZXYgKnNkKQ0KPiA+ICt7DQo+ID4gK3JldHVybiBjb250YWluZXJfb2Yoc2QsIHN0cnVj
dCBnYzA4YTMsIHNkKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBnYzA4YTNfcG93
ZXJfb24oc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBpMmNfY2xpZW50
ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7DQo+ID4gK3N0cnVjdCB2NGwyX3N1YmRldiAq
c2QgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsNCj4gPiArc3RydWN0IGdjMDhhMyAqZ2Mw
OGEzID0gdG9fZ2MwOGEzKHNkKTsNCj4gPiAraW50IHJldDsNCj4gPiArDQo+ID4gK2dwaW9kX3Nl
dF92YWx1ZV9jYW5zbGVlcChnYzA4YTMtPmVuYWJsZV9ncGlvLCAwKTsNCj4gDQo+IFdoeSBkbyB5
b3UgcHV0IG1ha2UgZW5hYmxlIEdQSU8gbG93PyBUaGF0J3Mgbm90IGhvdyBlbmFibGUgR1BJTyBp
cw0KPiBzdXBwb3NlZCB0byB3b3JrLi4uDQo+IA0KW210a106IGZpeGVkIGluIHBhdGNoOnYzDQoN
Cj4gPiArdXNsZWVwX3JhbmdlKEdDMDhBM19NSU5fU0xFRVBfVVMsIEdDMDhBM19NQVhfU0xFRVBf
VVMpOw0KPiA+ICsNCj4gPiArcmV0ID0gcmVndWxhdG9yX2J1bGtfZW5hYmxlKEdDMDhBM19OVU1f
U1VQUExJRVMsIGdjMDhhMy0NCj4gPnN1cHBsaWVzKTsNCj4gPiAraWYgKHJldCA8IDApIHsNCj4g
PiArZGV2X2VycihnYzA4YTMtPmRldiwgImZhaWxlZCB0byBlbmFibGUgcmVndWxhdG9yczogJWRc
biIsIHJldCk7DQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3JldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShnYzA4YTMtPnhjbGspOw0KPiA+ICtpZiAocmV0IDwgMCkgew0KPiA+
ICtyZWd1bGF0b3JfYnVsa19kaXNhYmxlKEdDMDhBM19OVU1fU1VQUExJRVMsIGdjMDhhMy0+c3Vw
cGxpZXMpOw0KPiA+ICtkZXZfZXJyKGdjMDhhMy0+ZGV2LCAiY2xrIHByZXBhcmUgZW5hYmxlIGZh
aWxlZFxuIik7DQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3VzbGVlcF9y
YW5nZShHQzA4QTNfTUlOX1NMRUVQX1VTLCBHQzA4QTNfTUFYX1NMRUVQX1VTKTsNCj4gPiArDQo+
ID4gK2dwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChnYzA4YTMtPmVuYWJsZV9ncGlvLCAxKTsNCj4g
PiArdXNsZWVwX3JhbmdlKEdDMDhBM19NSU5fU0xFRVBfVVMsIEdDMDhBM19NQVhfU0xFRVBfVVMp
Ow0KPiA+ICsNCj4gPiArcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQg
Z2MwOGEzX3Bvd2VyX29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sNCj4gPiArc3RydWN0
IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsNCj4gPiArc3RydWN0IHY0
bDJfc3ViZGV2ICpzZCA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOw0KPiA+ICtzdHJ1Y3Qg
Z2MwOGEzICpnYzA4YTMgPSB0b19nYzA4YTMoc2QpOw0KPiA+ICsNCj4gPiArZ3Bpb2Rfc2V0X3Zh
bHVlX2NhbnNsZWVwKGdjMDhhMy0+ZW5hYmxlX2dwaW8sIDApOw0KPiANCj4gSG93IG1ha2luZyBl
bmFibGUgR1BJTyBsb3cgaXMgcmVsYXRlZCB0byBwb3dlciBvZmY/IEVuYWJsZSBtZWFucyB5b3UN
Cj4gdHVybiBvbiBzb21lIGZlYXR1cmUsIG5vdCBzaHV0ZG93bi4gTG9vayBhdCBjb21tb24gR1BJ
TyBjb25zdW1lcg0KPiBiaW5kaW5ncyBpbiB0aGUga2VybmVsLg0KPiANClttdGtdOkhlcmUsIHdl
IHJlbmFtZSBpdCB0byAicmVzZXQtcGluIiwgYWNjb3JkaW5nIHRvIHNlbnNvciBwb3dlciBvZmYN
CnNlcXVlbmNlIGluIHNlcGMsIHdlIHNob3VsZCBwdWxsIGxvdyB0aGlzIHBpbi4NCj4gDQo+IC4u
Lg0KPiANCj4gPiArc3RhdGljIGludCBnYzA4YTNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCkNCj4gPiArew0KPiA+ICtzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmY2xpZW50LT5kZXY7DQo+
ID4gK3N0cnVjdCBnYzA4YTMgKmdjMDhhMzsNCj4gPiAraW50IHJldDsNCj4gPiArDQo+ID4gK3Jl
dCA9IGdjMDhhM19wYXJzZV9md25vZGUoZGV2KTsNCj4gPiAraWYgKHJldCkNCj4gPiArcmV0dXJu
IHJldDsNCj4gPiArDQo+ID4gK2djMDhhMyA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqZ2Mw
OGEzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gK2lmICghZ2MwOGEzKQ0KPiA+ICtyZXR1cm4gLUVOT01F
TTsNCj4gPiArDQo+ID4gK2djMDhhMy0+ZGV2ID0gZGV2Ow0KPiA+ICsNCj4gPiArZ2MwOGEzLT54
Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo+ID4gK2lmIChJU19FUlIoZ2MwOGEzLT54
Y2xrKSkNCj4gPiArcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGdjMDhhMy0+eGNs
ayksDQo+ID4gKyAiZmFpbGVkIHRvIGdldCB4Y2xrXG4iKTsNCj4gDQo+IE1pc2FsaWduZWQgaW5k
ZW50YXRpb24NCj4gDQpbbXRrXTogZml4ZWQgaW4gcGF0Y2g6djMNCg0KPiA+ICsNCj4gPiArcmV0
ID0gY2xrX3NldF9yYXRlKGdjMDhhMy0+eGNsaywgR0MwOEEzX0RFRkFVTFRfQ0xLX0ZSRVEpOw0K
PiA+ICtpZiAocmV0KQ0KPiA+ICtyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwNCj4gPiAr
ICJmYWlsZWQgdG8gc2V0IHhjbGsgZnJlcXVlbmN5XG4iKTsNCj4gDQo+IE1pc2FsaWduZWQgaW5k
ZW50YXRpb24NClttdGtdOiBmaXhlZCBpbiBwYXRjaDp2Mw0KDQo+IA0KPiA+ICsNCj4gPiArcmV0
ID0gZ2MwOGEzX2dldF9yZWd1bGF0b3JzKGRldiwgZ2MwOGEzKTsNCj4gPiAraWYgKHJldCA8IDAp
DQo+ID4gK3JldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiA+ICsgImZhaWxlZCB0byBn
ZXQgcmVndWxhdG9yc1xuIik7DQo+IA0KPiBNaXNhbGlnbmVkIGluZGVudGF0aW9uDQo+IA0KW210
a106IGZpeGVkIGluIHBhdGNoOnYzDQoNCj4gPiArDQo+ID4gK2djMDhhMy0+ZW5hYmxlX2dwaW8g
PSBkZXZtX2dwaW9kX2dldChkZXYsICJlbmFibGUiLA0KPiBHUElPRF9PVVRfTE9XKTsNCj4gPiAr
aWYgKElTX0VSUihnYzA4YTMtPmVuYWJsZV9ncGlvKSkNCj4gPiArcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCBQVFJfRVJSKGdjMDhhMy0+ZW5hYmxlX2dwaW8pLA0KPiA+ICsgImZhaWxlZCB0byBn
ZXQgZ3Bpb1xuIik7DQo+IA0KPiBNaXNhbGlnbmVkIGluZGVudGF0aW9uLi4uIHByb2JhYmx5IGVu
dGlyZSBjb2RlIGlzIG1pc2FsaWduZWQuDQo+IA0KW210a106IGZpeGVkIGluIHBhdGNoOnYzDQoN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

