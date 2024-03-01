Return-Path: <linux-kernel+bounces-87980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8E86DBBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE701C23913
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3469300;
	Fri,  1 Mar 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sy3J/IKM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Qgfby4lQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE89612E1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276198; cv=fail; b=b4p++1+2/OD/KnU70Y0h2N/7rBIGAO3ODnC4hyp/vB6RqWT+TZ+GL568aRfAAs7vZZC9BKcBdcljdCtlfCD/p6FqDgRAguH+motHxNIn5Tko6/5zCKSHd12QH5g62rIZrOh/7qfMaiod5Pckv8c8qFbTQC45DNgJJH0JNf05mM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276198; c=relaxed/simple;
	bh=kNnHf20HbEwH4032Ode+vUrRvCIg5sJZ+jJohEs1rvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BX3WXhzFBy0pTYnEPxu/uJyiHESF5DUMFK2mCAxclPQBMUxQbF6W0/D3cVGKMHay872BtCLEBKcYMSsJsivAfb5bq68De6/wt9uyywS0rErXoK2Ucud4vHzvkm3TjAd791OHFW815xs5/C3m/5ml5Cn4M/MMs8TCZlIvdrNQhpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sy3J/IKM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Qgfby4lQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d5b4b69ad79811ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kNnHf20HbEwH4032Ode+vUrRvCIg5sJZ+jJohEs1rvE=;
	b=sy3J/IKMu73kP7VhCcfErNqDjSIwWteIRroZ68/m5sMTgAzTAXaAkV7fPfKeKXUhIXAd3D+2oxMLJ1ICF4Pdx2UcJ6hYSa/FIfZ+rKE5tWPxv8Q8Lu1ZKpC/MIVMLkl/YT3f7tkjTYlo+cGr5rXS3WxfnAVVQqNZDygNoC/PmvI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1a02e8e1-7358-4ff2-a445-fb90432fd2d9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:901362ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d5b4b69ad79811ee935d6952f98a51a9-20240301
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1051959980; Fri, 01 Mar 2024 14:56:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 14:56:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 14:56:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI2lD3Qpgg2gMzvpFsE/6lVRomjQAP2Rv24b7UaJbg3joZ3ooaEonM+UWIRRJatnaZwCZiCnITgDlodKgJ9OSuP2vreeq1Zbzl/CAcG7PVYk+VW92Hue0+KMl0RTo/mq3lTqtOenw58TSYDV/ROMsl7OFWPEJWTOpoLbx1Mtk1ecgv1U3FyAERnINwSfvWDGKkCqZQg2D156uqKTJAMsXmQEDwmu/B8pk8/eq0jZGGxBozuf86BKqIjhi7sbFXKLXwZ3CWaNZ3irecpnKqnfUXs9Uwof4vfTbBHdcpxuXRHPeCKYafbn6HVsJIghgrt5Mt/OhXSGrAc6wd+Nbu/9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNnHf20HbEwH4032Ode+vUrRvCIg5sJZ+jJohEs1rvE=;
 b=OFdhl5S+XI7aVDpxvISWdlapr8FGKcZKU/09zbT4UoGSKo7aTwdTif9yIZIyvXLfNMkugb6fsfwYq3VKs7hi7DVjl5KNl7GG7QXvk4gDhtMozIsqJvhZ3rFQGo8c/Sq518mA2mUHElxlyj/k0VKDB388lL6KuO1rp1P/6PQi4VO0VgFI2XYInKNKkagfOF2J9nChuuV7uuVLo3CqgdpSnac/Lc5AU2bo8e7UJccRoErSJVUX8wxnY0G1qUOOPwlB4cclLFST678218UMSN27SjmcBYUeqovTOs832Avpw6AgiKGwhcmoITyWM9iWz3+xlP46xeHHGUrseob6JIzF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNnHf20HbEwH4032Ode+vUrRvCIg5sJZ+jJohEs1rvE=;
 b=Qgfby4lQpn9UNG/6mxZnQvhEvsTlyejkjLBsMzGlL5UIj2YMVUCfEHmTZhRdB5Tf/xYe2fiGsutaaixRvzJ6sJbGQU4+mnnAl/GgNNk1x9quHFdrtZhkuADnHNT5rz9ODZg31doAE5bkTbchY4o/gjzbxJXH8AdMTU9/9RC4AFE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7235.apcprd03.prod.outlook.com (2603:1096:301:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:56:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 06:56:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "seanpaul@chromium.org"
	<seanpaul@chromium.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 04/13] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v5 04/13] drm/mediatek: Fix errors when reporting
 rotation capability
Thread-Index: AQHaX/dt8A2CJNeE3ky/RI+ap0eEJ7EiizkA
Date: Fri, 1 Mar 2024 06:56:26 +0000
Message-ID: <a5e37328f866d3a46b66b69d3caa10313f6bd697.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-5-shawn.sung@mediatek.com>
In-Reply-To: <20240215101119.12629-5-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7235:EE_
x-ms-office365-filtering-correlation-id: 31f4cd57-38c3-46c7-f704-08dc39bcb738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoV5aMxsRQDCmyiiniJ5DYJrubV1/Vf9d0ewBnGxFl0PjDi23WmiJ+acKZAxTSQ6Nv98RfGGd+EwdOaWmNlKK/4n/XiwNdd/FjUFrRGJEqOED7yihMwnhtJGBZp1Qq+APsKrJXBa4c0jdJr/BxQ8KdWdxLR+yiCjVnDOVc34AMjXf9WnqsQ06Onfon47hPZ8iyNLg+gaXY7deAu0iesM6oyFNRv0XX6QSUYOQAGHEnH+bTppb4XOtEzTyFq16M/feqBnNKAnbbuXT/tnMY54+8lHx1Td4OLcX8X3wkWIVHZOGudjHq+A0wTOsZ1+SGxlesw+a1GnzsthokrryRLHRuGJUxO43F6td9aMIrA/usqPMPzlLakyqhsKwwXrCZenW+CsJucDJLV5Aldvpun8/cLhQf55uitrbC5xdv8gGPm+vbSKx6hvnAe1fegOjjXwhL0TyP3QJIs8Rrn5DcQ+ercwjztFGs7UN18+dJFK46OFJH5mJMaOBnoTyzNXTJFwuzCIGMSqN25FtEvV1sL/LEz8BfA2C7IxDoSLnC7z67kWzVzTDPdaLS35a6n24liYrvcojC5k/cCunFIX8RxHDZ+GjqUq/zme+65xL0TeNS1cwkF0ZO5ztFEATmTEoPCuSl4S5zgS4OEgBWbdTmOr3Ki8v5GhtB3P5RqvS1gbzN8z+74RuMgysiPSBKgPfXnDZSmoU3I2q7OmMcQ1Y9N7BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enJIcDFSZTZxUXd5aTJwaHpKeUFhajE0WTdmbkg4bCtjdlE2amcwNUJDM21N?=
 =?utf-8?B?OHRPN2xLY3c1ai9LU3dValdQTTRFWTN1VkppWUZid096enVBbU0wd2tGTk1U?=
 =?utf-8?B?Szc3bTAvV3Z1UHl2YVpaV1RsbXZuTEo3MC9Pbm5sNXdWRXFGQXU0bFNtcTFh?=
 =?utf-8?B?SDdLeDM1UEdHZzFnOTc3R0pUVkp4ZThPekxKV1p3RWhnUVpEdnkyazZpNzZx?=
 =?utf-8?B?dk9Na0pqVzcvV0d4MWFKNG80NGxpeWVwbXlhTlJZQVk5MUtXNjg2b0Z5VWd0?=
 =?utf-8?B?dDBKQVZobXU4dFlLWGhuRHJNV0k2dytxbE82NUpzUFF5QnA5elRlNkJnZW9W?=
 =?utf-8?B?RzAwaFlYQTBVejdTNUJtODV6ei95ZzdlNkVUUFpYR1B2WHcvNFM0QUs5UUZa?=
 =?utf-8?B?RGJjMytwM1RPMzZjdHNLN0Qzd0dVaUpKbG5md1lnVnA3M0MzQjdPVUNFc1Vn?=
 =?utf-8?B?RGJHUVJqMGV0VnhkVWVUbUFOOWZVSDN4Mi9tT3VLZ2dlR2VxbmtmS0M5R3Iv?=
 =?utf-8?B?ZzF1ZEd5NTNYTlRjbG1kTC9DbktybElQSU9OTXJDVEVqYXBleC9MK1ppM1FP?=
 =?utf-8?B?T3BJeDMvRWNFWmtTNEU0dWRrdUZjUlZWN2JSQit1K3N2SE1FL1NlOHFhMGE2?=
 =?utf-8?B?NHExdTJxZ29jR3JNWHNnajNYK2dnWjI2WmNUY2oxQktubnNYemY5NUlZK1hE?=
 =?utf-8?B?ZVZvZjUyN0hIQzVnSFpiSE1TeklIWWd4NGNSSVR2M0dvNUh3b0tNZnRNQWxF?=
 =?utf-8?B?SFN0eEFLbVprVnl2RVZ4RENGQlVhTFp5VlIvTUtiKytjTTF3TFMwc2dCSzlO?=
 =?utf-8?B?SWFvQ0pvbzE1YmQvZTRTRk1nUDYzd1lBam5yMXcrcjl5YzBJcVhYYlRLUGdF?=
 =?utf-8?B?dDZSZ2dqMHRYc096R0FxZzVCMVZyYTNGMkRuMzRHUE5uSzRNM09NWjI0TXEr?=
 =?utf-8?B?U083SDlvb3ZtN3pEdWJ3WWRCekw1ZU9TZHVEVnlIMURaU3FYT0V2YjhSTzdZ?=
 =?utf-8?B?WVNzUy83SnVLRWxFVlVIT3VCUEptOFJSajZOd3VEdU5VQ2xDVXpPeFFJbEoz?=
 =?utf-8?B?ZnR1RFhjUTQ3VHBaTVpLUmFSYmtVaGtkNkVJQnBrMnNrTmd0eU43bEVZeXYw?=
 =?utf-8?B?RnF4MnpSQzBpS0JMTHVzU1ZKbmF2bEpheFFtSng4MWJZQTh0L1VDb0VOMzBZ?=
 =?utf-8?B?UzY0YkVDblZib2hsZGozSlFpMzljR1NzOThENEd4VXl3REx2KzRGM0h1TVdQ?=
 =?utf-8?B?Y1lwQ0NibEo1WlNBTEFKbVFYTDJocUtKR0d5QTVXYk9lcVBwcmpocWs5L1lP?=
 =?utf-8?B?amlpOUZXSU9ydXlseGxQTWZIb1lLajY2Q0VMdkc2dkRWVDR6REMxYmlEWXFF?=
 =?utf-8?B?QndiNG15K1JsTlU4bFJRZitKbXhreVZDTXQ4TENXM2NIOEk5UGM3NWplRnVq?=
 =?utf-8?B?MDlxQzExb1NiZW9mUFFKUVhLcDBKK2ZRdjljcEV3NkJBSWpHckMvMHNGZG5N?=
 =?utf-8?B?K0hNL1pWYjR6ZloxQ2psSENQUXRuRkM2ZzVVNWVGbU90T0RXTFQ3bmE5eGNq?=
 =?utf-8?B?TUo4V3dMTXhLRUJuRzhsTEVabnVyOGdFaHNGZzhMY1pMSlVJZmdKNmY5ejRB?=
 =?utf-8?B?dEhBcUZWYTgzOElFRGlXajQ2YmZsWVY1akdyc0k4L3YxZTJ2Q243SjBQZE5a?=
 =?utf-8?B?dnY1SVkzem1yVnF4QWdhVERSbUF1UitpSVlHZEFEdnYzSll3dU9uQ3JxUWdh?=
 =?utf-8?B?YzZQRldyd01UanNKUUJVS3dTZlNtNWF5VjVtSi9UTWE2YnY2Q1BRaVg5NEtW?=
 =?utf-8?B?YnR2Rm5zYmhtWWtqRmxGaW14UmJLaGpJdUg2dUJnU3VqNGhuV1grbHRSN3Y5?=
 =?utf-8?B?Ri9WOWFZN3d2MEZBMTd2Zms1MG5xY0hEbllWSDJ3ZnZtVVlmUER4dzk3NEht?=
 =?utf-8?B?Y1JzYUtJbEdYQWEwVVNoU1JHOXhyWEVQUFBCblN5YjhlWWxHQzdOZDRFRnNW?=
 =?utf-8?B?UUVGQUQ5dHpqTm00VWVqNGIrSGZlMHk4Z2Z0dHdzSmJwYnhhNzJCeUJManU5?=
 =?utf-8?B?Nm5wWnBHTWwwdFZ4WmNPK0hRU25xeTJGMytNVTdHT2ZzRWp3czJ0K01rTHAy?=
 =?utf-8?Q?B+pqBrTZ1ks4W/d69X1TVpgur?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AF66333EA6A3847A3AD48650084D0F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f4cd57-38c3-46c7-f704-08dc39bcb738
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 06:56:26.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQrJO9t2KN6J4i8mGLl7/RJmXxDTZ7cAxrHBOpxwPtLCnAIH/deVAGiJ34r3gHB3wjMVDbCVSE6xtHopJTHwHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7235

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTg6MTEgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IENyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBhY2NvcmRp
bmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkuDQo+IFNpbmNlIGN1cnJlbnRseSBPVkwgb2Yg
YWxsIGNoaXBzIHN1cHBvcnQgc2FtZSByb3RhdGlvbiwNCj4gbm8gbmVlZCB0byBkZWZpbmUgaXQg
aW4gdGhlIGRyaXZlciBkYXRhLg0KPiANCj4gRml4ZXM6IDg0ZDgwNTc1Mzk4MyAoImRybS9tZWRp
YXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxhbmUNCj4gcm90YXRpb24iKQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgICAgfCAxOSArKysrKysrLS0tLS0tLS0NCj4gLS0tLQ0K
PiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgIDkgKysr
KysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAg
fCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgICAg
fCAgMiArLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4g
aW5kZXggNGE1NjYxMzM0ZmIxYS4uY2Q1Y2E1MzU5YjBmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAtMTI2LDYgKzEyNiw3IEBAIHZvaWQgbXRr
X292bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIHZv
aWQgKCp2YmxhbmtfY2IpKHZvDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl91bnJlZ2lzdGVyX3Zi
bGFua19jYihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfZW5h
YmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jf
ZGlzYWJsZV92Ymxhbmsoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gK3Vuc2lnbmVkIGludCBtdGtf
b3ZsX2FkYXB0b3Jfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpOw0K
PiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZv
aWQgbXRrX292bF9hZGFwdG9yX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHVuc2lnbmVk
IGludCBtdGtfb3ZsX2FkYXB0b3JfbGF5ZXJfbnIoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCA1YWFmNDM0MmNk
YmRhLi5jNDJmY2UzOGEzNWViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+IEBAIC0yODksNiArMjg5LDEwIEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xh
eWVyX25yKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gIA0KPiAgdW5zaWduZWQgaW50IG10a19v
dmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICsJLyoN
Cj4gKwkgKiBhbHRob3VnaCBjdXJyZW50bHkgT1ZMIGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sDQo+
ICsJICogcmVmbGVjdCB4ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4MA0KPiArCSAqLw0KPiAgCXJl
dHVybiBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8xODAgfA0KPiAgCSAgICAg
ICBEUk1fTU9ERV9SRUZMRUNUX1ggfCBEUk1fTU9ERV9SRUZMRUNUX1k7DQo+ICB9DQo+IEBAIC0y
OTcsMjcgKzMwMSwxOCBAQCBpbnQgbXRrX292bF9sYXllcl9jaGVjayhzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpt
dGtfc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUgPSAmbXRr
X3N0YXRlLT5iYXNlOw0KPiAtCXVuc2lnbmVkIGludCByb3RhdGlvbiA9IDA7DQo+ICANCj4gLQly
b3RhdGlvbiA9IGRybV9yb3RhdGlvbl9zaW1wbGlmeShzdGF0ZS0+cm90YXRpb24sDQo+IC0JCQkJ
CSBEUk1fTU9ERV9ST1RBVEVfMCB8DQo+IC0JCQkJCSBEUk1fTU9ERV9SRUZMRUNUX1ggfA0KPiAt
CQkJCQkgRFJNX01PREVfUkVGTEVDVF9ZKTsNCj4gLQlyb3RhdGlvbiAmPSB+RFJNX01PREVfUk9U
QVRFXzA7DQo+IC0NCj4gLQkvKiBXZSBjYW4gb25seSBkbyByZWZsZWN0aW9uLCBub3Qgcm90YXRp
b24gKi8NCj4gLQlpZiAoKHJvdGF0aW9uICYgRFJNX01PREVfUk9UQVRFX01BU0spICE9IDApDQo+
ICsJLyogY2hlY2sgaWYgYW55IHVuc3VwcG9ydGVkIHJvdGF0aW9uIGlzIHNldCAqLw0KPiArCWlm
IChzdGF0ZS0+cm90YXRpb24gJiB+bXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zKGRldikpDQo+
ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+ICAJLyoNCj4gIAkgKiBUT0RPOiBSb3RhdGluZy9y
ZWZsZWN0aW5nIFlVViBidWZmZXJzIGlzIG5vdCBzdXBwb3J0ZWQgYXQNCj4gdGhpcyB0aW1lLg0K
PiAgCSAqCSBPbmx5IFJHQltBWF0gdmFyaWFudHMgYXJlIHN1cHBvcnRlZC4NCj4gIAkgKi8NCj4g
LQlpZiAoc3RhdGUtPmZiLT5mb3JtYXQtPmlzX3l1diAmJiByb3RhdGlvbiAhPSAwKQ0KPiArCWlm
IChzdGF0ZS0+ZmItPmZvcm1hdC0+aXNfeXV2ICYmIChzdGF0ZS0+cm90YXRpb24gJg0KPiB+RFJN
X01PREVfUk9UQVRFXzApKQ0KDQpZb3Ugc3RpbGwgbm8gZXhwbGFpbiB3aGF0IHlvdSBkbyBoZXJl
Lg0KDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IC0Jc3RhdGUtPnJvdGF0aW9uID0gcm90
YXRpb247DQo+IC0NCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBpbmRleCA2ZDQzMzQ5
NTVlM2QzLi5kNGExM2ExNDAyMTQ4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBAQCAtMzc5LDYgKzM3OSwxNSBAQCB2b2lk
IG10a19vdmxfYWRhcHRvcl9yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0DQo+IGRldmljZSAqZGV2
LCB2b2lkICgqdmJsYW5rX2NiKSh2bw0KPiAgCQkJCSAgICAgdmJsYW5rX2NiLCB2YmxhbmtfY2Jf
ZGF0YSk7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3Jfc3VwcG9y
dGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJLyoNCj4gKwkgKiBz
aG91bGQgc3RpbGwgcmV0dXJuIERSTV9NT0RFX1JPVEFURV8wIGlmIHJvdGF0aW9uIGlzIG5vdA0K
PiBzdXBwb3J0ZWQsDQo+ICsJICogb3IgSUdUIHdpbGwgZmFpbC4NCj4gKwkgKi8NCj4gKwlyZXR1
cm4gRFJNX01PREVfUk9UQVRFXzA7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9y
X3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1
Y3QgbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IgKm92bF9hZGFwdG9yID0NCj4gZGV2X2dldF9kcnZkYXRh
KGRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KPiBpbmRleCA5NDU5MDIyN2M1NmE5Li5iNDdiZTY5NTVkOWI4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gQEAgLTQxNyw2ICs0MTcs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiBkZHBfb3ZsX2Fk
YXB0b3IgPSB7DQo+ICAJLmdldF9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9yX2dldF9mb3JtYXRz
LA0KPiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRz
LA0KPiAgCS5tb2RlX3ZhbGlkID0gbXRrX292bF9hZGFwdG9yX21vZGVfdmFsaWQsDQo+ICsJLnN1
cHBvcnRlZF9yb3RhdGlvbnMgPSBtdGtfb3ZsX2FkYXB0b3Jfc3VwcG9ydGVkX3JvdGF0aW9ucywN
Cj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbXRrX2RkcF9jb21wX3N0
ZW1bTVRLX0REUF9DT01QX1RZUEVfTUFYXSA9DQo+IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGluZGV4IGYxMGQ0Y2M2YzIyMzQuLjJkYzI4YTc5Zjc2
MDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5l
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBA
QCAtMzM4LDcgKzMzOCw3IEBAIGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2LCBzdHJ1Y3QNCj4gZHJtX3BsYW5lICpwbGFuZSwNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9
DQo+ICANCj4gLQlpZiAoc3VwcG9ydGVkX3JvdGF0aW9ucyAmIH5EUk1fTU9ERV9ST1RBVEVfMCkg
ew0KPiArCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zKSB7DQoNClRyeSByZXBvcnQgaXNzdWUgdG8g
SUdUIHRlYW0uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJCWVyciA9IGRybV9wbGFuZV9jcmVhdGVf
cm90YXRpb25fcHJvcGVydHkocGxhbmUsDQo+ICAJCQkJCQkJIERSTV9NT0RFX1JPVEFUDQo+IEVf
MCwNCj4gIAkJCQkJCQkgc3VwcG9ydGVkX3JvdGENCj4gdGlvbnMpOw0K

