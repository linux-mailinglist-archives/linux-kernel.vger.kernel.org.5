Return-Path: <linux-kernel+bounces-56060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1F84C580
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DFA8B23C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF421F934;
	Wed,  7 Feb 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aNhFgsrn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eGCDpmUv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253C1D552;
	Wed,  7 Feb 2024 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290104; cv=fail; b=QrRUljTffQFnzXkAoaLDfQZ5GCogl5W0aj8o2rtVq0JXA4JidArCW3N/tX2+AWwsdxY1zrHQ02ShHy1ZQE61Y5IgZLPNw4bMck2oUH9fLrQsPxntGwn73jM8HT6fwilL1DKm2Ey0mKnLjKo6x0lfENHmtiYdhlJYwd6N8mzvZmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290104; c=relaxed/simple;
	bh=qgASr8YKLjvCDlds8ZS5CZE9Wgn2W/Hl4Ma9krE1w4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zih7dZmqGDpDH2EF3Ik0BdGQWVy8hzDz+nMruHGJ9S7HZaTp37uL0rEeNDzbsbvxZDIoEbycWcrCRy5wjiMHSd/a7fS28CT8Id0aXofdqLxB2EOAKHfyT30T4g0fEMvgRVBlBCnb0t/HrdchWzd7aVx2zhldaDMqujfqfBofhIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aNhFgsrn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eGCDpmUv; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9888f23ac58811ee9e680517dc993faa-20240207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qgASr8YKLjvCDlds8ZS5CZE9Wgn2W/Hl4Ma9krE1w4w=;
	b=aNhFgsrny6SZH8eVfAUlYnGela2X8TXYQYF3mpwCVLjjhL364pFHnG/vem2sko+RsWFbmFL7oJ3riFIKdc8KuF+/WBMgCpGnLmkUyPlIUE+oPWlW9hNrYFN4I0u7MwKnHblCApzwdG1LollKdQu5lcDTf79ESHI8ALJECKHtnko=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:01590ff4-dea5-40f1-9433-fb3b03f74c3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:a0a6b683-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 9888f23ac58811ee9e680517dc993faa-20240207
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <bc-bocun.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2092353399; Wed, 07 Feb 2024 15:14:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Feb 2024 15:14:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Feb 2024 15:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIOaeXrs6tFvdY7JfmanLOZ1K0bWQIg6qCKIGxR+w+QRiPXllOcPmrTdjIoGWO7qrkJsTvvAct3tI0N0XWovDvd32nZcBsZiIfabVmqiePZCfWqJflENCOr86RhrI3PGpuBd4JLPdSfO6ZDohUaFIFFPUWRT/0HRAx9xeWMMTseZnQ68jW7KeaMY1D4WSZOfDqVUgMREBWwyL39H9I0cJB+i9ZGggKmLDfVk95ZtuUuZukr4CNlWqunQDEqLAx3dWBVqFD4jdE5YjcnR7+LzdJi9IOTs92f7+URbtoCNMqRk+lQbp9uXrvhJLAnpuIrVb2qllmRXjwJzjaGy8bf3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgASr8YKLjvCDlds8ZS5CZE9Wgn2W/Hl4Ma9krE1w4w=;
 b=L7ipym0hFjRNwogoneNmESLZoL8ZqxHrwUCei364zvbyCzl4pmCSWaONic6OMHANAPBKMow5VYf0LubPIgme9XsTFucSKHYC3tbEgfpGi1Aus2aQQo5aw1XwtcJM6x9/F/p7pavksgab7N6JVxSd9ntQe8UblOpQuwpapX6V3dugAQkdGxOasT7k04rMy9DApYb+4pnRvycX1EyIAf/THafeB7lkZ/YzRRPipjVvvZTjYA7SaO5LxtfVQR+t3/A30aaKV6HozE15LAEy3yzxfNJyHHSLtZ9fXs6i5nHdQVVboJVNgLMGvoNwsqBOEZtE6Z3Seu3Bh4QypNTVR7MbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgASr8YKLjvCDlds8ZS5CZE9Wgn2W/Hl4Ma9krE1w4w=;
 b=eGCDpmUvnpUEEe9mBvqe/QY+Qyzndr223vOAvCDfXfGZvfJ5xa4pt8YG5Gzzrh0uQbX68ic3makO8rJoIr8FByyqxumQ/QduYgDqch+uMAWbIoWAzR3Qo6//PXx9tMWQIvCZXep96fAn4OEh1Hdhaq30tHvgmtx5TjZXe9w6Fzc=
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com (2603:1096:101:ef::15)
 by SEZPR03MB7052.apcprd03.prod.outlook.com (2603:1096:101:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 07:14:51 +0000
Received: from SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::8f79:8e05:15fc:e387]) by SEZPR03MB7219.apcprd03.prod.outlook.com
 ([fe80::8f79:8e05:15fc:e387%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 07:14:51 +0000
From: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
	<Chunfeng.Yun@mediatek.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "dqfext@gmail.com"
	<dqfext@gmail.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Thread-Topic: [PATCH v2 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Thread-Index: AQHaWRGbmU4ItmlK4EWmjz53qZ3IgLD+eIoA
Date: Wed, 7 Feb 2024 07:14:51 +0000
Message-ID: <6058aea8a315201f686957e520f5784725b6b95e.camel@mediatek.com>
References: <3251ac3db1a739e0c18ded0a824edae981c1e2df.1707153425.git.daniel@makrotopia.org>
	 <31d2c56a-5108-4265-a267-6733e1ba328e@linaro.org>
	 <ZcJQyaTotW_bCWGU@makrotopia.org>
In-Reply-To: <ZcJQyaTotW_bCWGU@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7219:EE_|SEZPR03MB7052:EE_
x-ms-office365-filtering-correlation-id: c80df027-a490-4838-9604-08dc27ac79eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjudHiKDJo1j6abyvgSZJ1VzwUnETKIzjVQzj5WjKcTlFBuiH6gZ2/3Jggd9wRWZE5Bze2IxmYqyfz5WGVM51f/KHMp541ujOXeivjcYkT6mP+9CXMetO+97byQAS0qY3hIzuhzBrtdwJ4VfQ36YjcfBye21c/p9y8x5DB4YEaY2O42NKypReHwDvjH2WzNQk3nWLxMw6P5hYSFWjlnh5iKx0RhXgHQ9TCFfUqGPY2tzAymDbJt7009fJIi5OVwAVT2C/zyjN6WxKTmKQoTp5AT6xlvqG99c+PALTGp1R0ezrKysKkajPH/eAeDFbsRs7Ouq830JxJN6ahm+KPOAEj2eBJDcvj6o8o7sDmaTes7/Kbo30RXWQ2PkT4vAkiA6R+kBH04QCY+zAxtT7KLbDf1UkBAG/7LfZp61kK8Lg/Vm2w2HvUxrnuhD9r3spKe1nOR+7pD+0h0zBUv1Tx3zP5wg8uhiNrQsa1sZD5hnsCHOIb1ZFFkq+YW9LrN/z57+MKSbBw233wfUwWemINZXLIylPqUptUPVvfaOe0OT4Ee0asVro/6w8qUsSikl2UmZuAj+mdLoXIvN1iUKSeLbMkpGDjrcsl1dJD60q1nYhV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7219.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(76116006)(4326008)(8676002)(8936002)(86362001)(7416002)(5660300002)(36756003)(478600001)(6486002)(966005)(2616005)(6506007)(6512007)(53546011)(85182001)(71200400001)(64756008)(110136005)(66446008)(66556008)(26005)(66946007)(66476007)(54906003)(38070700009)(316002)(83380400001)(122000001)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjFuVGZPTUZnYXhwUEJ4MVZVVFNCa29uVkhpTkx0UUFOY3ArMmxBQnZJWlM1?=
 =?utf-8?B?RUpJSE96V20rZUhSbkFZU2pqbmd3T2EwNGMxbUNZb2lmRTEvZVV2Y0ZFVFVy?=
 =?utf-8?B?ZDF5NkxqbEo5cjdZdld1NDliT1lPN1VxOXMwSmpqeFd3dUtLQWxMN0JOcnFN?=
 =?utf-8?B?d1Zxd0dXTzE0L1ZlbjBHY0M1TlFjMWZyZ2lTZGllVmJFanhqbitpNkZUSXFN?=
 =?utf-8?B?L3dkYW9rYndBZGlRQjF0aFVCU3ZUdVo3SlFmV2V2eFFGRTFUcHk5ZU8wZHdM?=
 =?utf-8?B?WTVTcmd1aGMzRmovcG1zU0p0TVBJYXFBVTlKWEFqOUJtOWx4LzFSVnZvYWdD?=
 =?utf-8?B?WGtJd2JrZUJiU29FbzRmVjVYdGtLeFEzMGMzckkvNU55ak5aQlJqU0tqSm9i?=
 =?utf-8?B?a0xDUWxiWUVRQ1BjRk1Rb3FVSTBYRlZ0bzRtSnFzcGZsV0EzSTg0SmpEVFVH?=
 =?utf-8?B?TStPaDMyM0ZUUFpCc0FzYkp0d05vSGcxeEJsd0k3ak44WFA3azY5aGxFajIw?=
 =?utf-8?B?M0ZBd3d4TlRsWWtEY0x0S1ZZWHRuR3R0YWZtZk0yWHZVRnZQS1ByOExMdHBh?=
 =?utf-8?B?d2VPOWRVcVpURDlTbGc2TGJmTjFlWForVTFqT3V6QmRPeDdmWmV0djRmOUg0?=
 =?utf-8?B?YmpETUV1aUhFa3F4cEtOclpqUzMxR25RbG5hMUlFdjZ4TytvR1NCWDFVVHYy?=
 =?utf-8?B?emZCVmtnRjZiUFhiL0hJdk9RYVNwN2FIeEcxWXBUWG52QjVpTXhPcWhLQy9n?=
 =?utf-8?B?b2FJNDdiZlVjcEpwQ05KMHY3TXdNbkppY3BLUStXMXYvbzdZOGp4Yks3NkZP?=
 =?utf-8?B?TWR5T1lzYS9QQitHdUZUWUNwRTZleUt2d2VuWHp0bE5aTVZQTnREWnZBVXpK?=
 =?utf-8?B?VjdrbW4va0p3d0RsRTA2UCtScHNxRVdVeU5xalFFOEVDcUsrRW1KRVh1QTdF?=
 =?utf-8?B?ZXlCeDNiYkMyVjU0cklURG1DM24wYk9yZHUwQS9mY0RoTGo3dlpKeDVVS2FM?=
 =?utf-8?B?YW9lbTdUU3RUWElBcU9wWFozOEJjcGVSUUVNZmJPTWhUT3VIMytEN0FPSUpU?=
 =?utf-8?B?VVdTcHdubVNnOEhzRXM5U3hsVTIzVG91NG5Na1JpNnk4NS9VeUxDcm1nRy9H?=
 =?utf-8?B?STFJcmt2UTBkZWNMcWFJbGlOSEFKQmNvUzd5TjVyeXZSQ0tnUGFtbXZNUjJv?=
 =?utf-8?B?cGNzN3ZWSnZ5SDZ0Q0tRendZb1N1VjNUNVBWRnlvVlJGU2hGMjl5YUdwZUt4?=
 =?utf-8?B?cC90ZmJTSFdoa1F3OHhEN0IxL2h4aHdHUjVQVjRSNzdFcm9iMWFjR2o5NWhq?=
 =?utf-8?B?dDFsemxrcmN2aWtQTHh4ZHdmVTNPeEV0TjNsK1ppaVUrNUQ4K1BJNXBFbGZk?=
 =?utf-8?B?MURLcEcvMHJtVGNVKzJycVdyZUNFWXFVSUY2cFFlUVQ3RnYrSlZMZlhYNXpo?=
 =?utf-8?B?Sll1cG9XQlArZTBlRVdPRUExS05KYnpqRTNhNHBCbnoxajU4dnV2NWQwWkx3?=
 =?utf-8?B?eXQxMUpJbzZ3NHQyaERZek03VzRqSERhYWdMenRIL25WK0E1VW82ZEMrSktY?=
 =?utf-8?B?MVNncTNyb2Y3SkpyK1h5SzdhRkZ5VVF4b0xlSmFtK09QOGZQTkE2QXIrT0tx?=
 =?utf-8?B?ZFNSeXdzR1FGcnl1U09RUitvNVA1L0xYQ3VDd1RWdDkyNk1ZMjd5dWdKYUI2?=
 =?utf-8?B?L1BEbDIxdW9XSlJ1eTJCdUpKK3BDODZ3T3pJUkd1dFhEWGw4UmFqWEd3OHE0?=
 =?utf-8?B?aEJybzk2MEMrVFg5M2Z6ZlRyeFdObUNObmgwZXQ4NkFCb0t6K2RQa0UxQVRX?=
 =?utf-8?B?VXNnc0NyZGY5UlJkWWhhY2tIU0VVQnRsM3g0QlNwU3VTZjAyY1NGWnRvc3c5?=
 =?utf-8?B?YTgzZHdpc0lJczhIRmU1WGR0Rnptc09JZktwTDZTTjhqdjFqV2p2WXB2VzlC?=
 =?utf-8?B?YktjSjlhdXdGdWpxUm52M1VQYmlaNC9xR0JIMVA2RVFUak5tRGRhalBGV2tR?=
 =?utf-8?B?ZG82ZVdUbjh5S3BaQTZzWmlULzk5OFVaTzRwaWZhaUVPcUxta1A5QlV6TUpo?=
 =?utf-8?B?RW94QS9manphTHlBeHhkNUp1WGxVSmpIdlQ2NFIrSk9uQmY3cUdhQVhRcUR2?=
 =?utf-8?B?K202b3VWY1NlRGhJa2g0RWZnY1hIdjRWbDl0VTRZWHlsV2pSeWJmeE9GWkNU?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBF614FAC69EF44098E44757CBE161AF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7219.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80df027-a490-4838-9604-08dc27ac79eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 07:14:51.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+/r8dC8+RlcWU3Uvrd5VAU/jeXWgoayKMLjPVqMCP+F+FDZBFF5qw0loEGMXFP+XR6PAd16r8sMWBt3nOKUzRdBfF02xGhMimmvDvMNDHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7052
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.502500-8.000000
X-TMASE-MatchedRID: /nPNxfnsEhPUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tXP5rFAucBUHegqK9F+QonFa2o9UdV1eYCL1
	yYUEE8H6V3EAsRciN4U3vo7D1vK5cXMNFF510ZsQYteHAndhXow2AVSpm3nkDa73+XlYDLuw8hM
	k0TNhNt1hn5un32CvQsidzbaW8UwtrtoObOqfJT4zb2GR6Ttd3Q434w0c1NoFHZg0gWH5yUUuK3
	tWUBMDoIUM+EI7fOGNCLZXVtHx5zBIsRevuHsEg04Rmz/agfdyB01driWko23RNGrhtzGYfwe0c
	SbGr35g0I6tvv/X3qsFJLM23Oo3mcMMjBRRYYhx05zsoB1UKTqHErxDyhjvnQU3XqMtEfQ9e8eV
	5hjwoelxc/Yu3WITY2qylDsS4PNPUbBocSvqNd9xajlW+zwxCZa7LkubQvj8KXKtfi06bFKPFjJ
	EFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpOlxBO2IcOBaUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.502500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	93BF0BC2A4187845549C4706CD3A6AC8BEA1D42B680EA4B1A0BB95CB73753C022000:8

SGkgRGFuaWVsLA0KSGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjQtMDItMDYgYXQgMTU6MzEg
KzAwMDAsIERhbmllbCBHb2xsZSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSBLcnp5c3p0b2Ys
DQo+IA0KPiBPbiBUdWUsIEZlYiAwNiwgMjAyNCBhdCAxMTo1Mzo1NUFNICswMTAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDA1LzAyLzIwMjQgMTg6MjgsIERhbmllbCBHb2xs
ZSB3cm90ZToNCj4gPiA+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIE1lZGlhVGVrIFhGSSBFdGhlcm5l
dCBTZXJEZXMgVC1QSFkgZm91bmQgaW4NCj4gdGhlDQo+ID4gPiBNZWRpYVRlayBNVDc5ODggU29D
IHdoaWNoIGNhbiBvcGVyYXRlIGF0IHZhcmlvdXMgaW50ZXJmYWNlcw0KPiBtb2RlczoNCj4gPiA+
IA0KPiA+ID4gdmlhIFVTWEdNSUkgUENTOg0KPiA+ID4gICogVVNYR01JSQ0KPiA+ID4gICogMTBH
QmFzZS1SDQo+ID4gPiAgKiA1R0Jhc2UtUg0KPiA+ID4gDQo+ID4gPiB2aWEgTHlueEkgU0dNSUkg
UENTOg0KPiA+ID4gICogMjUwMEJhc2UtWA0KPiA+ID4gICogMTAwMEJhc2UtWA0KPiA+ID4gICog
Q2lzY28gU0dNSUkgKE1BQyBzaWRlKQ0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5p
ZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlhLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gdjI6IHVu
aWZ5IGZpbGVuYW1lIGFuZCBjb21wYXRpYmxlIGFzIHJlcXVlc3RlZA0KPiA+IA0KPiA+IFNldmVy
YWwgY29tbWVudHMsIGZyb20gbWUgYW5kIFJvYiwgd2VyZSBpZ25vcmVkLiBQbGVhc2UgcmVzcG9u
ZCB0bw0KPiB0aGVtLg0KPiANCj4gSSdtIHNvcnJ5IGlmIEkgaGF2ZSBtaXNzZWQgc29tZXRoaW5n
LiBJIGp1c3QgY2hlY2tlZCBhZ2FpbiBvbg0KPiBwYXRjaHdvcmssIGp1c3QgaW4gY2FzZSBJIHdv
dWxkIGhhdmUgbWlzc2VkIGFuIGVtYWlsIHJlcGx5IHRvIHRoaXMgb3INCj4gYW55IG9mIHRoZSBw
cmVjZWRpbmcgcG9zdHMgb2YgdGhpcyBwYXRjaCBhcyBwYXJ0IG9mIHRoZSBvbGQgc2VyaWVzDQo+
IGdvaW5nIHRvIG5ldGRldi4NCj4gDQo+IENvbW1lbnRzIHlvdSBoYXZlIG1hZGUgd2hpY2ggSSBo
YXZlIGFkZHJlc3NlZDoNCj4gIC0gcmVtb3ZlZCAkbm9kZW5hbWUNCj4gIC0gdXNlIGNvbXBhdGli
bGUgYXMgZmlsZW5hbWUNCj4gDQo+IEFuZCB0aGUgb25seSB0aGluZyBJIGZvdW5kIHRoYXQgSSBk
aWRuJ3QgZWl0aGVyIGZpeCBvciByZXBseSB0byBpcw0KPiB0aGlzOg0KPiA+IENhbiB5b3UgZXhw
bGFpbiB3aGF0IGlzIHRoaXMgaXNzdWUgYW5kIGVycmF0YSBhYm91dCAoZXhjZXB0DQo+IHBlcmZv
cm1hbmNlKT8NCj4gDQo+IE5vdCBvdmVyd3JpdGluZyB0aGF0ICh1bmRvY3VtZW50ZWQpIHZhbHVl
IGluIHRoYXQgKHVuZG9jdW1lbnRlZCkNCj4gcmVnaXN0ZXIgcmVzdWx0cyBpbiAxMEdCYXNlLVIg
aGF2aW5nIHBlcmZvcm1hbmNlIGlzc3VlcyBhY2NvcmRpbmcgdG8NCj4gYQ0KPiBjb21taXQgaW4g
TWVkaWFUZWsncyBTREssIHNlZSBoZXJlOg0KPiANCj4gDQpodHRwczovL2dpdDAxLm1lZGlhdGVr
LmNvbS9wbHVnaW5zL2dpdGlsZXMvb3BlbndydC9mZWVkcy9tdGstb3BlbndydC1mZWVkcy8rL2E1
MDBkOTRjZCU1RSUyMS8jRjANCj4gDQo+IE1heWJlIEJjIG9yIFNreUxha2Ugb2YgTWVkaWFUZWsg
KGFkZGVkIHRvIENjKSBjYW4gZXhwbGFpbiB0aGlzIGluDQo+IG1vcmUNCj4gZGV0YWlsPw0KDQpP
dXIgUUEgdGVhbSBoYXMgaWRlbnRpZmllZCBhIHBvdGVudGlhbCBwZXJmb3JtYW5jZSBpc3N1ZSB3
aGVuDQpjb25uZWN0aW5nIFhGSSBQb3J0MCB3aXRoIGFuIFNGUCBvcHRpY2FsIGZpYmVyLCB3aGlj
aCBtYXkgdmlvbGF0ZSB0aGUNClNGUCBzcGVjaWZpY2F0aW9uLg0KVGhlcmVmb3JlLCB3ZSBoYXZl
IGFkanVzdGVkIHRoZSBQSFlBIHNldHRpbmcgZm9yIHRoaXMgcG9ydC4NCg0KPiANCj4gV2hhdCBJ
IGRpZCBtaXNzIHdhcyBSb2IncyBjb21tZW50IGF0IHRoZSB2ZXJ5IGJvdHRvbSBvZiB0aGlzIHJl
cGx5Og0KPiA+IFdoYXQgaXMgUEVYVFA/DQo+IA0KPiBJIGNhbiBhZ2FpbiBvbmx5IGFuc3dlciBi
eSByZWZlcmVuY2luZyB0byBNZWRpYVRlaydzIFNESyBzb3VyY2VzOg0KPiANCj4gDQpodHRwczov
L2dpdDAxLm1lZGlhdGVrLmNvbS9wbHVnaW5zL2dpdGlsZXMvb3BlbndydC9mZWVkcy9tdGstb3Bl
bndydC1mZWVkcy8rL3JlZnMvaGVhZHMvbWFzdGVyLzIxLjAyL2ZpbGVzL3RhcmdldC9saW51eC9t
ZWRpYXRlay9maWxlcy01LjQvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX3NnbWlp
LmMjOTYNCj4gDQo+IEhlcmUgdGhpcyByZXNldCBpcyBjYWxsZWQgWEZJX1BFWFRQMF9HUlNULg0K
PiANCj4gSSBwZXJzb25hbGx5IGZpbmQgdGhhdCBuYW1lIGNvbmZ1c2luZyAoYXMgdGhpcyBQSFkg
aGFzIG5vdGhpbmcgdG8gZG8NCj4gd2l0aA0KPiBfUF9jaSBfRVhfcHJlc3MpIGFuZCBoYXZlIHRy
aWVkIHRvIGdldCByaWQgb2YgaXQgd2hlcmUgaXQgaXNuJ3QNCj4gZWl0aGVyIHBhcnQNCj4gb2Yg
b2ZmaWNpYWwgZG9jdW1lbnRhdGlvbiBvciBhbHJlYWR5IG1lcmdlZCBkcml2ZXJzIChsaWtlIFNh
bSdzIGNsb2NrDQo+IGRyaXZlcikuDQo+IA0KPiBJZiB0aGVyZSBoYXZlIGJlZW4gYW55IG90aGVy
IGlzc3VlcyB3aXRoIHRoaXMgcGF0Y2ggd2hpY2ggSSdtIG5vdA0KPiBhd2FyZQ0KPiBvZiwgcGxl
YXNlIHBvaW50IHRoZW0gb3V0IHRvIG1lLg0KPiANCj4gDQo+IFRoYW5rIHlvdQ0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcw0KPiANCj4gDQo+IERhbmllbA0KDQpUaGFua3MNCkJDDQo=

