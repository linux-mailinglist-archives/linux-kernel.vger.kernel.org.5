Return-Path: <linux-kernel+bounces-91507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C728587126C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8471C22ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16CE17C74;
	Tue,  5 Mar 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t8hPpU0Y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="avrzGUez"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902C5CBD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602892; cv=fail; b=smIqi92QhRKfFWPHCNB9kzNTfOfdC30zkfuwEPURSSghg2ZTvVhvggfcuQ3xUaH+4DO7wgMlP8R1RwqfosoxYr3KuMPmmE1T9yIRRTs6jke8HIMvnb+PgglcpCRM8mjGE12LhuUUfz2OddRLMqIynwjYGl7Q707Zv/MCOoO0tQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602892; c=relaxed/simple;
	bh=M57scfB9qy9h7b3u4KJjeJpSh4af5urRWr3wHzLWlz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=du00JFAbQWrBTKOpmon5hY5jgnC2AeouCMKkanVcw7UIcwo7xyv/qFSwn5tx2hXrFsXM11ltCpSANS6w3jsYN+iMVANdJcB0xDjpMalrOOzgXpoadWRJia2/XxWc5aAfnY3mdL7peDZh1LSvxKzai3UqlnIYol9BQSfzvfAnnOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t8hPpU0Y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=avrzGUez; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 79f0d306da9111ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M57scfB9qy9h7b3u4KJjeJpSh4af5urRWr3wHzLWlz0=;
	b=t8hPpU0Y0Aj6B8WTicHf6OEB/2Y8saLlx1CIJeNGtNh3l4JvEYgSpriqgEI6IjsVzJYURD2nwYzQRW/ahiBAzhgRlz62CWoxjqLSxqopzuIPbi5Mhaq7JEtE8PRVh/VeJYjhyvNzEipbvsMPBKP2kSwPrqW8cuySY99WS2Q5lMU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d172d020-6087-498d-b961-5ccee8f81517,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:6d581c81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 79f0d306da9111ee935d6952f98a51a9-20240305
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1803993299; Tue, 05 Mar 2024 09:41:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 09:41:23 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 09:41:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/rkXLbwUL/xDy7bSUhQXh/TgGaVMklZca2vrFGZPPTNhCAo4Ffo/JtxzSD4CSjI/G2euyjSq64xRwfjr8TyRUTmES7BhA5H8LiA4AUesoqH64adh/E4oXjJ3QURO3fZL5tJEM1u2uRBb3JMqGcdPoVE+MDvEDQXQB0XtzrbSi6ZEdmcizrVqsu2oGZxA5IW0REUK4F1FOZaQls/cM6tq6GaxMpAzJLt6U+JKagSQogZbcotZ3FsIrUS4PLcR8m7Pop8eFX90p7xAqoxQUL874eppVZHqHSwXltPH+5hXH7EvAViVSH7uQKWwLheRSZ1gUudxfkwEeGUxUvMeAj19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M57scfB9qy9h7b3u4KJjeJpSh4af5urRWr3wHzLWlz0=;
 b=H8VDghF3z8NPkwBz1fmi6EAgPtb/KnR2STR29nbwBoQWrL+8LBjDWGrAhjv62h5kpAzQAS1QycCcllUPCm1DwLLUANd5e+vnJfll9Nif4stccUB8ZgPqCi80QXY5AgNuAhO2qUrsL8M4n/3k8v1u8jmLEjhX/8kLsNaTmJNtn5fVCEklCum4GWf5za8kW4hbFSEZ6BJwBpTgtOxUkiHhkb+P57aq8yqFsh/zIiDJv1bf2IYOeSU5hnowp693N61xnH5HHfRKamG9HeLj9mNHPOYIbkkDmA8eWqLFG/nITKemIeRiwr5NT2YLt7c7xUFFyxkOwqfew5fUXJ7G6oducA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M57scfB9qy9h7b3u4KJjeJpSh4af5urRWr3wHzLWlz0=;
 b=avrzGUez/AibswGgN0uSVF+vCF0jlfwRiE2T85Bsvl8uaPTbDbpmsany+UdrRuKPzZJkJj8b5zDq2Nl61zA4H1+7E7u05TdnmlcI6pyzum1mCc0Qeod8e/oMRV0QXMyVKYfxcns96iOKc5fjx0v74ie13ETHni/8aTz5YtRIW/Y=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PUZPR03MB6965.apcprd03.prod.outlook.com (2603:1096:301:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 01:41:21 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:41:21 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_acquire_event()
 function
Thread-Topic: [PATCH 4/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
Thread-Index: AQHaa8lay6RCDDUsb0GYfphhyU+UT7EnX4YAgAEFWQA=
Date: Tue, 5 Mar 2024 01:41:21 +0000
Message-ID: <0ea4fc33aa9d7937f2a24daf693001afda05adb0.camel@mediatek.com>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
	 <20240301111126.22035-5-jason-jh.lin@mediatek.com>
	 <3dab3afd-7d0c-4bf1-b4f6-984f8d5d2d02@collabora.com>
In-Reply-To: <3dab3afd-7d0c-4bf1-b4f6-984f8d5d2d02@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PUZPR03MB6965:EE_
x-ms-office365-filtering-correlation-id: 4a2bcb88-c574-4583-d2f1-08dc3cb55c35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KrcEWTtUzdWBmykWNzl5ds0tGMJT4oghDRncoDiWN7tpq65QOqmySzTVxUO1YtNEG3RMEYaPB3fWjyeU+nXgD20YlbCHpiw0iCwIAD4M777QVCGpBECcghwhAEYvirDkuj+cNnFg3zHQ1mV8aAIla5ESlL98BnzOmAGPrLCUmoEoQGMmsQtd0iah8Q+IvdmO1+L5azYfjrzxKLO83khxYBawXcQZqfYmj2dzR0ULtoityqKSSF1mbVW0MNITHmQp1794X3vyscz5TX7Xjn0DN3cUSxRy9zsszjxFPRtLLjvYWOi98J9suJrPK5FXWcUIKixulCPyn4dmembheZCmAUCraSt7ZucZP4Td5iC5OIc1kR9WD2oC+T5R1HLwLEUeSS0Ns65WOOYHSopg9UbDRztnLPxEOmkyIqSG0UepgHBHFLvG/E6LIqaCsKLqyGqPAfEjXReccxJzutMARGHyW5UCtkfcUGBc23a7ViydKRZ4iNsk45LBbhTByxPmZDj+hoPQSaPsw+M3AmAtdD11LWSBaKbq6Ntct7Cjwqeg2dskBY0tWo2dOyamDqQhmEkYbygbx6NxV7RTmC3ceZJeRiQowhwD/wv4FU3oBoYLWNDYd69XB5VQd6ZF5lAZY6EtBkDSnrvGHFlVX0PWSBxmqk5G2H28SkJZfCO1cmUJxwTtDljzet7I5inRqCnWtemIUMMo+XlHPIPbWJZzHNcuXwO75TCsW3no8WxwT3yjweQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFwUUhQczlabjFMcU11alpXQTVFSnF2azBvcFpwdHVjTGNXcnNmZi9JNU50?=
 =?utf-8?B?U0RZME1RN1VJNFkwWmZFZ2V0LzkxWjFTZGlkK1F6SUo0UUovU1Y2WFFUMHBh?=
 =?utf-8?B?eklyY2hVNlYzSnVXTmlSS0pOeW1URFlzTHRRSk1LSjN6MytibENUTjdiNVFQ?=
 =?utf-8?B?MWxFL1B6NVhJRDgzTHVNbUF2bTFHbVFqaVl6T0lXeTFGcEhoRjl5dTRmSktq?=
 =?utf-8?B?bkRkNVhoMzRmU0dDNkd1blI0WkYzcnhGWFZ0MWpESWtWMEtLNU51em1QcTlX?=
 =?utf-8?B?MkZkWkhDcEFoWE1ELzArRG9kdU1McWVNK2dBV01WR0dvVlhnV3pIZHdWZVZS?=
 =?utf-8?B?VlBnQmdiazV1YjN0VC9PanhDUVRrRExzbW9JcnYraUwvY1dwa01QbmNXSTRV?=
 =?utf-8?B?R1gvT3JMa29NU0pQZERlOHpQYXd4M2o1aDBXRkpoV1BhcXZISWZDOHI5dU16?=
 =?utf-8?B?cUwycGZWQ3oxWkRsVmI0NHBrOHFrbVBUc0h0dlBJaGYzakV3ci9RNmlGdWNW?=
 =?utf-8?B?R3Q0dG0yZUhRWDcwWDdQSXRnSFJPclQ1NzFseVpiN2VqcVp1blZzUHJsZGdw?=
 =?utf-8?B?Wjd3TWFJNGYwcjRLV28xU05PUUlCQUxQMmxEZVdyVkhBWkFsc1llRjVnbTkr?=
 =?utf-8?B?a3E3MWdLRzhEdWgybEtHYmZkWHBpVDJnRjFFN29CTTIzVDJOd3A1NnlHblBS?=
 =?utf-8?B?akdBMXh1ZFM4R1FLdlZBdlpYTU9MSWg1RktkcHRFa2pLckpvUEZiWWs4TEtP?=
 =?utf-8?B?ejhmM1hsTlBibWlnTEdHek1DRlVCVjFtb1N2TmJSeWZVMk1wdG9TL3FFdzFM?=
 =?utf-8?B?RzRrQ3FiZVRvUnF3SWFKSDBxcGpnbFYxSVk5eFhnWUJYaFRHUWlrWklXMlBW?=
 =?utf-8?B?ZHRLbWkwR09KVFkwWkExdFdrTXRJUVR3QWNVeWtCMEtLZnd5ak5sSDkyQzJV?=
 =?utf-8?B?NGFTOElER1hOU2c0bkxLbVRiTG9sWEhxbVA0WFFnQ2RxNk83bk5QeHhkbkxq?=
 =?utf-8?B?THZtY0FlRXNFbEowQUtQVGxoa052MDNoQk9hN2lGV3h4SkZKMWt4SXFJdlFq?=
 =?utf-8?B?ZDNQSCtxSE8zM3VoY0hKSTRzNUVOYmR4Nk56OUdURElzVUVQcW1nSTVIbThr?=
 =?utf-8?B?d3F4NmkvTTFXbmcwYjM1bjRrN1hvRHlCRFNmZEIxMXQwM0lCZU4zSnBuRnZZ?=
 =?utf-8?B?Qk1LMUw4eUZuWDhrZXh2VE5jbHNkRmRib2NHTC9vTlp1emNuZVlKdnY1NHM5?=
 =?utf-8?B?cks3U1psczhLeTdDZjIvRVhhTVVwMmZzV21CY1d3UkxWMWlheUJhY05NUlF6?=
 =?utf-8?B?N3pLeVFXbU5vdEliT2lNL2MreC9wdXNaZVpZMEo2QnFvZkF2dXRIZW9MRDRw?=
 =?utf-8?B?THdpRUp5NTF5U2dFckczUGNxcExIREpQYTlWdnBZa1VSemxJVlYvQXdGT1B2?=
 =?utf-8?B?YTU4Q0VCNnBuOXFaMEN5aGZmVlhaSDJ2ZGRoSVk2WmZqQmxJNmQwcFQxcU03?=
 =?utf-8?B?WFc1LzA0KzIzN0V1aVNTVFFpbnBwTzE5cTV1R0dBWUo3YUQyUk5ORCtLV2lC?=
 =?utf-8?B?OGRMdkVHeklwS0NPRm1oUkxRYnJMRUg5YndWLzJOOU1IZkQzOXprRVBiQzVo?=
 =?utf-8?B?ZE5UTFVRMlFmOTRKS1BZSUFjdGNJNkZZZFpiNjZGam9YcS9LWlRmU0VUMkNV?=
 =?utf-8?B?M3lSV0NTcE9OU1QvR3BBRlZYWjZXd2o2S214WTFwdE9TQ29nL1MrL3VLSzd2?=
 =?utf-8?B?M1FBNWlPQzZyZFcrLzljZ3VJMjZ1QWQ1dUgvekgyeERLdWhyOEhsMjJtMjhC?=
 =?utf-8?B?bDlkVHZZUDdERTBzMU92eFpGNkhlY1d4VGFiZTRCZGk0NkM3b0FCYm5ZUUNO?=
 =?utf-8?B?TXpUa1EwTTFGWUp4MGtMcUtCN3RrYkVPeERmNTN4YW5LOVpla2pVY3p4YTBj?=
 =?utf-8?B?V1QrK0NHQktvdGxGZGZRS3ZweWtDWXBRYnljbWE5cjdDOXF2YzIvWXpuU2Y5?=
 =?utf-8?B?ejZjcXhnRGJZVktucndMQlVMbHFBdHVZR3FkWU1EM2pySTNPWjlKanhvRVgz?=
 =?utf-8?B?T0lDeTMzNHRHRXhtcTBTYkNXNzM4NUhxZlFYRFBEUVNSVWRMQklzYWR2N21G?=
 =?utf-8?B?QWdLUjVXd3h1Z1FnSUVCNk85QTB4dUYwdjF3VlFuUVBZSFhOMVJZREZrM1BX?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5B82D0F3664694DB5BDF4ED33E3B857@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2bcb88-c574-4583-d2f1-08dc3cb55c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:41:21.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTQNnNp4uLqzYLKgGIu0+nlYHRnaYjZGuF9ojnnANEJwxhZU1MUTTkSmQGhvIpXZoymP5HIz9/seoZTLQCf4wAjyYDFPAuzHC4CZQB+Kqm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6965

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjQtMDMt
MDQgYXQgMTE6MDUgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAwMS8wMy8yNCAxMjoxMSwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGNtZHFf
cGt0X2FjcXVpcmVfZXZlbnQoKSBmdW5jdGlvbiB0byBzdXBwb3J0IENNRFEgdXNlciBtYWtpbmcN
Cj4gPiBhbiBpbnN0cnVjdGlvbiBmb3IgYWNxdWlyaW5nIGV2ZW50Lg0KPiA+IA0KPiA+IENNRFEg
dXNlcnMgY2FuIHVzZSBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KCkgYW5kDQo+ID4gY21kcV9wa3Rf
Y2xlYXJfZXZlbnQoKQ0KPiA+IHRvIGFjcXVpcmUgR0NFIGV2ZW50IGFuZCByZWxlYXNlIEdDRSBl
dmVudCBhbmQgYWNoaWV2ZSB0aGUNCj4gPiBNVVRFWF9MT0NLDQo+ID4gcHJvdGVjdGlvbiBiZXR3
ZWVuIEdDRSB0aHJlYWRzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8
amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEljZGFlNmI2MDM0NWM3
ZWMxZDc1NDFhYzc2ZDFmMDZkYTU2OTU5Y2RlDQo+IA0KPiBEcm9wIENoYW5nZS1JZCBwbGVhc2Uu
DQoNCk9LLCBJJ2xsIGRyb3AgaXQuDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAgOSArKysrKysrKysNCj4gPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCAyZTlmYzliYjExODMuLjAx
ODNiNDBhMGVmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBl
ci5jDQo+ID4gQEAgLTM0Miw2ICszNDIsMjEgQEAgaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTE2DQo+ID4gZXZlbnQsIGJvb2wgY2xlYXIpDQo+ID4gICB9DQo+ID4gICBF
WFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dmZSk7DQo+ID4gICANCj4gPiAraW50IGNtZHFfcGt0X2Fj
cXVpcmVfZXZlbnQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiArew0KPiA+
ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0KPiA+ICsNCj4gPiArCWlmIChl
dmVudCA+PSBDTURRX01BWF9FVkVOVCkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+
ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCj4gPiArCWluc3QudmFsdWUgPSBDTURRX1dG
RV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFMVUUgfA0KPiA+IENNRFFfV0ZFX1dBSVQ7DQo+
ID4gKwlpbnN0LmV2ZW50ID0gZXZlbnQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2Fw
cGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF9hY3F1aXJlX2V2ZW50KTsNCj4gPiArDQo+ID4gICBpbnQgY21kcV9wa3RfY2xlYXJfZXZl
bnQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1
Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IDJmZTliZTI0MGZiYy4uZGU5M2MwYThl
OGE5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4g
QEAgLTIwMiw2ICsyMDIsMTUgQEAgaW50IGNtZHFfcGt0X21lbV9tb3ZlKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LA0KPiA+IGRtYV9hZGRyX3Qgc3JjX2FkZHIsIGRtYV9hZGRyX3QgZHN0Xw0KPiA+ICAg
ICovDQo+ID4gICBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZl
bnQsIGJvb2wgY2xlYXIpOw0KPiA+ICAgDQo+ID4gKy8qKg0KPiA+ICsgKiBjbWRxX3BrdF9hY3F1
aXJlX2V2ZW50KCkgLSBhcHBlbmQgYWNxdWlyZSBldmVudCBjb21tYW5kIHRvIHRoZQ0KPiA+IENN
RFEgcGFja2V0DQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAZXZlbnQ6
CXRoZSBkZXNpcmVkIGV2ZW50IHRvIGJlIGFjcXVpcmVkDQo+IA0KPiBXaGF0IHlvdSB3cm90ZSBp
biB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgZ29vZCBkb2N1bWVudGF0aW9uIGZvciB0aGlzDQo+IGZ1
bmN0aW9uLA0KPiBwbGVhc2UgYWxzbyBwdXQgaXQgaGVyZSBpbiBrZXJuZWxkb2MgZm9ybWF0IGFz
IGEgZG9jdW1lbnRhdGlvbg0KPiBwYXJhZ3JhcGguDQo+IA0KT0ssIEknbGwgcHV0IGl0IGluIGtl
cm5lbGRvYywgdG9vLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiArICoNCj4gPiAr
ICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVk
DQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3RfYWNxdWlyZV9ldmVudChzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTE2IGV2ZW50KTsNCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIGNtZHFfcGt0
X2NsZWFyX2V2ZW50KCkgLSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUNCj4gPiBD
TURRIHBhY2tldA0KPiA+ICAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiANCg==

