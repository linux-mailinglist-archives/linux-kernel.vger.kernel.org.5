Return-Path: <linux-kernel+bounces-52086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1F8493F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF52284209
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E64C2DA;
	Mon,  5 Feb 2024 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bLvRBWu4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tdgNaiRX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361EBE6F;
	Mon,  5 Feb 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115433; cv=fail; b=Bd8Qhp1jgFRicxDGX40NPc9nCYLonZIy86Q+FmiGJA+ofZYgBoZc+BWr4xFezV1+IBfP1RPzrl8A2sjBzoSurPaHaFYpXfhgrFw4A+tYmFOurQ8bJLhoCuyVwtUTd/MTSPWdoeUuw+LLBLGCeTT7fO97Y5WdCqLDieRQIpd2zBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115433; c=relaxed/simple;
	bh=glodNQ5oiO0ov7HWFwBB1OspFDomUlFp5UDtHdUexW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WXFPrMxdJTQatEno7v4TJ/9Bmlf0Xl3sOPFze1gXC0j/+UQHSDlGq6olT4GCm0WNBiQDU8R9deBnuybfNK8TaM1ict4x4rFLcG6CYAN4dhzC2M2M47noKSAfB2EigkC1SIs8q6jZdzqIx+bSaa6eNUJA7YdIBlufz0+kFUO0WwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bLvRBWu4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tdgNaiRX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e5a762ecc3f111ee9e680517dc993faa-20240205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=glodNQ5oiO0ov7HWFwBB1OspFDomUlFp5UDtHdUexW8=;
	b=bLvRBWu4n4Hjzr7PISAVhhUi4b9++O97EM2GvRcPO2KJqwUop9bVT2BncVcz1yQNECiZKFqDTleNaLyVAhXpk6wAc9HG9PGTMr9loBtw+KhxtsMbnvY3n46+QvYcJMpWId1OyuZxAwDtMcfW2t/wb2SGgM6VLT2Vfnj0g9RF3NE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:24899c3a-405f-4f3c-9f75-030a59ecc334,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ce31a083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e5a762ecc3f111ee9e680517dc993faa-20240205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 713797443; Mon, 05 Feb 2024 14:43:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Feb 2024 14:43:39 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Feb 2024 14:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/XS30dPhKN1te35WDSoOftAiG7ZFZbn2TdGvk4Z1fI/yJr4zTSFCPq+YGpp5JmlxfkIoTBPUzS+h+vWXtvg/X2HRMaM4KWo7cwvBy8lCOF/2sukSEb22P1pJv2UgPXtX1sNt8KkLspMtUB4Xs3bc3g9qlHLROS1qhzZfOjGzuBOfkBdK/IKRwPQCHCI68oWrlz8Ytn6xMSSRU/TedgKqjDVCZh6sORa98G/e6R4hZSG+nY9ObAAyY5lN13xIp02H9HLvy3wKOFYcJu15BavU+TsS3P/kDAtV+3QN2ZL5OzZ8tPYfiaMHpHyg4hZK0YrUr+H5xLIym9RFL10UBEreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glodNQ5oiO0ov7HWFwBB1OspFDomUlFp5UDtHdUexW8=;
 b=kMs+qZ47GaGcUNdkBprkyx+5lYhaL3e7+/6/euBvruma3bTdz1asprfrylR5s9RvxiJcFvqbRR4aYA5G41TURiUfHIPwuEzAqvZzdGeoruqXewjGC7I5DWPz6CbGCL0NjCpqS9Ppl1W3eOJlfmN86997pkQi5Leb1fzsSeWxJ60Ao/lGT+VH9mmjwH2uxnp2TwVmHmlFTtJbEcdiAg8NDni9TeLSblALzSoEql74Li3fhw62Hf57JmjVqy1R6GZAQFU2u8kK/mIX0a5gEVBEaoqFMFmzQClZBkxGRnSpuwW0ZeQXSLV/ZI9oc3wrRGf4Q4pC+jd6A9FoZIYcRMSEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glodNQ5oiO0ov7HWFwBB1OspFDomUlFp5UDtHdUexW8=;
 b=tdgNaiRX3D8+0VXsdOlsCwYAYuddPfQcw+FXMEFeSyV3vcmGR8yrb4dsybhiZHYHvKFLqOyVTlY4iCgEWnuj0uSD4fz99ToOp9tudmc4RoB6B5vVKFz4DzxWCrclYLlFAtAo28fV/5VUv7QGKTgq9i2iveQcykh/bGXKhLqBkfw=
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com (2603:1096:820:e1::7)
 by TY0PR03MB8279.apcprd03.prod.outlook.com (2603:1096:405:14::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 06:43:36 +0000
Received: from KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::8a1b:502a:b5cf:edc3]) by KL1PR03MB7648.apcprd03.prod.outlook.com
 ([fe80::8a1b:502a:b5cf:edc3%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 06:43:35 +0000
From: =?utf-8?B?TWFyay1QSyBUc2FpICjolKHmspvliZsp?= <Mark-PK.Tsai@mediatek.com>
To: "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "minchan@kernel.org"
	<minchan@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] zram: use copy_page for full page copy
Thread-Topic: [PATCH] zram: use copy_page for full page copy
Thread-Index: AQHZ+Oy7dGuGEzEpC0aLCvVrYS7X4rA/UNeAgLy6lAA=
Date: Mon, 5 Feb 2024 06:43:35 +0000
Message-ID: <99a493e1e906637a179a80b1f27a4b6bd2a0a671.camel@mediatek.com>
References: <20231007070554.8657-1-mark-pk.tsai@mediatek.com>
	 <20231008043855.GA2738554@google.com>
In-Reply-To: <20231008043855.GA2738554@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7648:EE_|TY0PR03MB8279:EE_
x-ms-office365-filtering-correlation-id: 7cb3ac72-da37-4560-7ce4-08dc2615c6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiEUnfqhqSgyIAq3NPbkb3lNWYrN3C5NlVVxrApcPAo5l+Rp4q41D7ya01N7AFmQU+LmuitE3J/fazz0WoxQdIJSrC9e34kQmdyWXlzsXa8ci0y5/t8fKlbf8UfFDMWwFBf3y+rUQWl1ik2vvfgr64vKZiE6bUuORn+IIdgtjNcOjI6QIUYh97RUrWmuRdrEXonmKS/tPSWz28WlwAy2Fk2NOumNyW/g4xnthCCF09nuKtTKxMyt7FI9KxUaILJp4Llkfyb/4gZ+t/eJH4b6mFxY2eJzz3r1neVSYGqbbV7KNfpGWTD6STf4j+8lRLmg7eBjK2FI4AdpPGr2nWOIDolCK6gNTZc/vI0wUjoARPdeIFlXKkXHjWfkvQZWKqebNSjsjVgDAze+k4vpgGaxqy7i9omujhg6qVoADwObZKY2K9Z3skYieBmKuCrgntY6ZfeqCL5D/Q1OoFKwwH1bwhJwUEC0plXSgTYfSTwsu9SshpMnrmDeE77IOO78KwZlgvpdkYD9dqQBhfGS1i1NvTdL3sRhs+KKTOkmhXdnXaUekMRRFQMb0HOk6k1NArpB8RoRH1JR03B+SUaKkENEY6oQ39sHlhAdvN/FWvw0/u5Bd1PN8IoJEbSHhCcUWhoO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7648.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(6506007)(316002)(83380400001)(122000001)(26005)(86362001)(41300700001)(2616005)(4326008)(8676002)(8936002)(6512007)(36756003)(71200400001)(2906002)(478600001)(6486002)(4744005)(5660300002)(76116006)(66946007)(64756008)(54906003)(6916009)(66446008)(66476007)(66556008)(38070700009)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFtRUtSZlBEN0x3dDI3cGtabWRaRWk5bmlnSnI5ZFFJS3NEOWlrTW9GRnFT?=
 =?utf-8?B?c2pLUHo2MGFmMG9zVDdTanF4dEJlc2l6UXRDOU9GZGlZU0RPWEwyZmZSSjhG?=
 =?utf-8?B?SUZqVWZtTjd1b1pDVlFEaDlQZWhvZTgzMkgwbFVYZ2tnN1Z5cFRPVmtjRzRQ?=
 =?utf-8?B?NzhYWldJeG9Ob2lNaTZFemZIYzdCTEZmTU5sQjhBaXRtcVVZWjNjMjZVRXhZ?=
 =?utf-8?B?bUN0SFVuWWhqbUtVU3FoT3k0aUVjUXA0andKdnpubFFJUnhtSG5rdHVyUDZ1?=
 =?utf-8?B?OHY5WUZ6NDBQNzRGVWMzbWU3WGpPeHNjQ3hnSm5CeURtLys3RTlNWmV4amhj?=
 =?utf-8?B?QTZFMGVVZkZtZkRnY0IrQldKb1VjUVZXRGdaK0xzTXd6TVRxRnltMjlSTnVN?=
 =?utf-8?B?aUpqSXBnSnRYakxPOHMxYkxzc2hwcDJCY21uRFhwdGNMWTBtZCs0QndnNXNw?=
 =?utf-8?B?MUduTHpMWUpwbFFqU1o5ZktDWUIyMVJGVmxzNjZ2Uis4QWRwclZiOGVIRHhz?=
 =?utf-8?B?QzZ6LzF2b1lUckdRcnBYYzdUN2xpWDZ4NXQyWDhKSU1FRllzaHZOUERiWmxD?=
 =?utf-8?B?ZzBWcFBmK3FOTVBrWWxCYXVzbVRCS1VBWWlQVE9Mc1NNMmV5V24rTzNwL1ln?=
 =?utf-8?B?VjYwMW93VUQ1ME1vdzA5YWdQOW1UdTQyYTNRR0dnZXpsMTdyRnhhWTJvOHJz?=
 =?utf-8?B?L0xmY1VPUGdaMUxteXFFblBtakYzS3lydy9nRlVhV2ZwaUVmaHZQb3lrTWpT?=
 =?utf-8?B?REVsejRmdkNVclN6eGhMeFQ2dVNTbUFaOHBCbjhvckltME54NWFzS2RKaUFy?=
 =?utf-8?B?ajduR0tYYkdoeHZvY1lDd3JvQStXMndVZ0RZMUE0R0IxcFVOMGRQYWpOL1lQ?=
 =?utf-8?B?N0tadnFDZy93Wk9MYTRic2xkZlFBN1VRM1FJQ2RRRkgwMnVZMExWWTBBeVgx?=
 =?utf-8?B?bzhKb29CSEdReEphYWo0ZVA2N25sSFNEaFRzem51S1dtWjVqWWgzZmpIYlkw?=
 =?utf-8?B?Z3BreWNJQzZKUGtRbzk4RzVGTGFEU214MnZ5SUJhdFYrZkxrQi95RWl2LzF3?=
 =?utf-8?B?d3lQRWNKM2IwaXBvbzlrRmxaQXltU0s3WENQd2hyVXhRVXYvbzI5ZXEyZ2Fk?=
 =?utf-8?B?UW9uZTk1L3hJbWRGVEVJNkNFdEd0d3c0WE8rd1VITnlsZVBrMWpzMTJ2bTAz?=
 =?utf-8?B?MXVyd3hPcWFiWDVoZWdQbmtsNW9ka2pYckhnMndFK0FGVWdtaWpXbmszQitD?=
 =?utf-8?B?RU1BbllNMUJsV2cyWXJ3SDhLeXFzK0Y4cnlzc0FsRmdhV2ZmMGJaYmx1WnZl?=
 =?utf-8?B?SzBFKzNSNXZNQSszakJzdzdrZkJNZGZIcm5OVXNESmh2RjEvNS9aMHNuZjk4?=
 =?utf-8?B?dE5wN0NSaEE2Yjh3T2xVVkFUNVYvbTAwUnBEcXFndjI5ajFLa2tTZTNleUVa?=
 =?utf-8?B?eVJaSW4yVnJlTTF3NWhKcTEzWkpWZTl1RzMxVC9mMmRIejJrY1dMVWl3blhp?=
 =?utf-8?B?eDF2bVhoaXlXbFhMcllGWFFEdlFuUFlKTGFOT2tnOEdzL0kyYnhhUnFiRlE0?=
 =?utf-8?B?VTBXK2gzcmlZbzNuUURlWXBYTHVGVkcwalB0MThNSzVhVjJIUEliNzdZVnlw?=
 =?utf-8?B?TW5PckwxekEwZm9KbW5ubkkyaXE2elhoU0Z0Q1dHZkVQMXhMZjJ3NjhYLzlj?=
 =?utf-8?B?QmRvTy9FamhvOW1SdDRTMzNLTEdsWlV0SndDRXNWRUdIMHViOGxEb3ZTMnVV?=
 =?utf-8?B?TmNhTWJUZ3YrUXAxbTFzSm1XNENBaTUraGh6dFN0VzBqUmYrSjc5MGxIaE9U?=
 =?utf-8?B?T20wZUNZQnhmMUdvYlJHR0xlMUdTWXZsZkJQV3JZaHhBM0Z3VHVDK3pXOVlH?=
 =?utf-8?B?cTErMXpWeE4yYUlYaS9EWUVtSzNRYWU4Tndsb05IOXdueFVVR3VRWkptRmtw?=
 =?utf-8?B?aFcrNjR4WXVDSzdzaHptUFJvU3pOdFdtL0twUjVxWjVEeWdQVFF5VzNPNWtC?=
 =?utf-8?B?czhJR2pmOEtlSWl0dUg3SFVkY0IvNm90cGdibUtQVVBldnFXRWpMTUthZXlR?=
 =?utf-8?B?MnZscDVESGtOdFl1VkRUMVBPM3JKeDRqTUNUd1RYQnc5VlZwUDZBNzNlQzVp?=
 =?utf-8?B?ZHhnQllrcVl3bWJieGtLd09YdjRoaXZvUENUMTE3M01KV3REWDUyRlNoNnFR?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA079A71BFF6C2429CBF8EB17DC263B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7648.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb3ac72-da37-4560-7ce4-08dc2615c6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 06:43:35.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQVLEMukrMwLT0WVV5CY3Gr9rXm8jtTtK5Q+sHL4fxudKU0X1HOjp1LITP2YvFhQQRJUABjgUwqVvls9GjXP4UDSeBhAmkA+wslcBDCuv6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8279
X-MTK: N

T24gU3VuLCAyMDIzLTEwLTA4IGF0IDEzOjM4ICswOTAwLCBTZXJnZXkgU2Vub3poYXRza3kgd3Jv
dGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVy
IG9yIHRoZSBjb250ZW50Lg0KPiAgT24gKDIzLzEwLzA3IDE1OjA1KSwgTWFyay1QSyBUc2FpIHdy
b3RlOg0KPiA+IA0KPiA+IFNvbWUgYXJjaGl0ZWN0dXJlcywgc3VjaCBhcyBhcm0sIGhhdmUgaW1w
bGVtZW50ZWQNCj4gPiBvcHRpbWl6ZWQgY29weV9wYWdlIGZvciBmdWxsIHBhZ2UgY29weWluZy4N
Cj4gPiANCj4gPiBSZXBsYWNlIHRoZSBmdWxsIHBhZ2UgbWVtY3B5IHdpdGggY29weV9wYWdlIHRv
DQo+ID4gdGFrZSBhZHZhbnRhZ2Ugb2YgdGhlIG9wdGltaXphdGlvbi4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJrLVBLIFRzYWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQo+IA0K
PiBSZXZpZXdlZC1ieTogU2VyZ2V5IFNlbm96aGF0c2t5IDxzZW5vemhhdHNreUBjaHJvbWl1bS5v
cmc+DQoNCkkgZ3Vlc3MgdGhpcyBwYXRjaCBtYXkgaGF2ZSBiZWVuIG92ZXJsb29rZWQuDQpDb3Vs
ZCBzb21lb25lIHBsZWFzZSBoZWxwIHRvIHJldmlldyBpdD8NCg0KVGhhbmtzLA0KTWFyaw0K

