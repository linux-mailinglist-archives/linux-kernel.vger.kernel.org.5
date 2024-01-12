Return-Path: <linux-kernel+bounces-24401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2782BC14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775A91F22F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B463B5D747;
	Fri, 12 Jan 2024 07:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s2IPK4st";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PwyWJEKF"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7E5D72A;
	Fri, 12 Jan 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e87ca976b11f11eea2298b7352fd921d-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ctlTCZSaRXvSOmFr8yTMTFRi1xf/oDEWI7+cCurTyyU=;
	b=s2IPK4st6bZ2N65Wv1LxfKZ4n0oVvvU18wi0FLQON18oGEB10xZDhvc6m0ktpsixgzscC2kGoEE0lvfJE1/FWGxDaAvFrLhmFIptWXw/pthMkkoDaV2aUUeizd7511cVUKIttN62ct/1R+w6ux7Sl9SwLznIaU/My/QJjGQu/5E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3c1bcc15-9250-4082-817b-31b8c32c0043,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:d15fc682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e87ca976b11f11eea2298b7352fd921d-20240112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1165588429; Fri, 12 Jan 2024 15:55:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 15:55:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 15:55:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKdyeEZ5vJzVFyZz3jK7dHhnG9u3r/Nltd/QK7LcOn894DoZoLu6I238r+oip/64HwAmNrUsoAAacoQbu/FFhwbtYNqjO/+omm58D0jn8agQ6WshMf2FnkHoH5Za1fX8AyrTjPMM3CI2LCNdxH9/MLs157lJxFqB4F6HypORBel95xryyHceei9dW9ZUetW57odo6Lnh+1xp8tZsvWF1TOmuAEEVSkR0yvnsqgCu7KXsdAPpZbVjKy1JvHn92FgBWAzKLWRVW3OkH+e/YoG3d1hNb3bgwvqLk09jlWWA9DdCXzYyZ+sEs/Dm/8YyhPUjDRsZLA3x8Mj48u0a60DUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctlTCZSaRXvSOmFr8yTMTFRi1xf/oDEWI7+cCurTyyU=;
 b=J+v2AOShV+T7/v53LXd2cY8knxkjxpBSuujpKYneDBIbqT/HO111+QpJaai72pVx7giJ+MhX7PfuADHM56MtoIo3CvLLdcnuiadQP94wsCIbfMmDgT4up2EJ91UFCk8XYup3Ed9oYDOSvoeUBFc6zBu/X56Pvis2VTC6Dwdg7+vlWpJdARIT+gEckrY856hlFIisQK1Ifi0jyjmCi2Js8IiRRSvqoAckMNJHOj69KM/Nh01E6WW03mDOn7WxqTsjP22MStSiNw5E19DOj8Akj4DganxnTeAMRWsWPh41SrK12TK6xbdJyjZG6mNcEPEPpiOhmDHZYZaFy7rBk2myhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctlTCZSaRXvSOmFr8yTMTFRi1xf/oDEWI7+cCurTyyU=;
 b=PwyWJEKFz7zQeDkOJwkT32BN1zMeS9bwMA09zqzcuNEK8CRWF5HIJ5gjMJxLc2SgJBZdqMwowGhbsW3GZVXO/gZQyrCOLBq6WbeHC2/9EEot8bRBcjHCcBVfG8UMFRxbx3V25oi7CejmzK/Yw6XKwfViquWlBmw9Nzqshznw/uU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB8732.apcprd03.prod.outlook.com (2603:1096:820:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 07:53:29 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7181.015; Fri, 12 Jan 2024
 07:53:29 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: media: mediatek: mdp: Change
 mediatek,gce-events to reference
Thread-Topic: [PATCH v2 3/4] dt-bindings: media: mediatek: mdp: Change
 mediatek,gce-events to reference
Thread-Index: AQHaQ49NN/eCY55yY0SZIlkPfyHDJrDVySyAgAAIkAA=
Date: Fri, 12 Jan 2024 07:53:29 +0000
Message-ID: <88caca5148e8e00a23f062c46ccc6a7afc5f66d6.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-4-jason-jh.lin@mediatek.com>
	 <d1bae8c6-a511-4bd2-9bc6-1b3c4dc6fb42@linaro.org>
In-Reply-To: <d1bae8c6-a511-4bd2-9bc6-1b3c4dc6fb42@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB8732:EE_
x-ms-office365-filtering-correlation-id: e31cdf13-a63c-42b5-aa79-08dc134390f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIdZ/DVTYQsdOLW9mLQrE/E2Mxo5/aFpsgjFbO7zx8MjyhR8ZgQiEsBSFXTEPOIxk7bAzpVzPZIws8UT6qi1LxJ5WFeiyLXtJo+pYxvp0jvwYCe3gasqJcd57i/dMzGyqlBtM57Vhmaa0p4NZe+Tcp3IcnAlnOkITwV9TzlMxmiQZFcctWYAIubSLZWg2MK/IHafk2YQiC7wrYzRsb17C+PYX25iR/nMGBX3qw1gZLeBJHyhkb4mcau+jpctEh/xUbqqMsn0EY9xlRHGH02Ob1B6ytifHXP//oBvwd7jQVqdka2KwFEG7ETJRF96QMT0XXqfucFapRkavfhsiSCuPONJFOyaxOszT7Ga2uSLuO2QyTuBFCw47yddxCPFjNOJH4wCgG9w+fnqfmnCLnxDPTHO/+7jmelgp+W3WFEJzsai9bg8liNr1/u6c1nMdtHKh5zJulet8DfZdDO0XUwQJGTVwfW1svQG0KaC8tXx57JV+kGCK31Uzwl2HOOOTfXnbpZyOMgamYJl8iOxtfSVRJUi+Rj+azst+eSObsalP1W/0OPxzUw7o8lElDACmevKN6oC21J1cTfIIuhPmBvAsMJtVEeDJmTS8+C7s7uZYytUFyfcG3yIKj11Xj0zOcmwbFHA5Vb0tu5So9Q/g7XhlPldpMNIV35v/fKjTq5CmmY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(53546011)(91956017)(76116006)(38070700009)(86362001)(85182001)(36756003)(41300700001)(38100700002)(66446008)(122000001)(6506007)(26005)(5660300002)(110136005)(6512007)(66556008)(6486002)(64756008)(66946007)(54906003)(66476007)(316002)(2906002)(71200400001)(8936002)(7416002)(4326008)(478600001)(8676002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE9WSVBRbTR0VlJDaUkydlJOK3lSMjJCWmlqZWRzR2I1SkRyMGxrZk9LMTBO?=
 =?utf-8?B?VDJTSmNUYzN6OEwzcld3OWhhMVNmaGlvay96TmIxbjVWSVliVXYrdzZ0emtm?=
 =?utf-8?B?TGJrTkhDQTl6aW9TQWZsKzlnR2hRbjVGWUtTWnBSc3J5NENoSGNnOXpjU09t?=
 =?utf-8?B?djBsU1JaZ29MU3hsRVlRcUF4ZTRPZ2s0dGhzbGErSmVBR01aNnZSSVVqWVJx?=
 =?utf-8?B?MzNRVTVybUlHbDRyc0JSVlk3MlRIY1B1VnMxWVpIQ0Q3NDhlRjVlbnBnSnNC?=
 =?utf-8?B?Ulk5RzBES3gyK1FGdDBjcVB0M21vMVdUR2NiWGRYN3h0Q1l3WUNKME1KdlR2?=
 =?utf-8?B?bWdSc3VXeUlYejJyTjU2SUJFMFI5eHB2bGpxaktISVhobnVOWVFiRmJERmY2?=
 =?utf-8?B?UXNlWkViQ1k1NnBHbkhaS1d4TnlVVjJ6UnliUnRhakM5RGU2NzdOQ0dvUEJh?=
 =?utf-8?B?QXJBU1YyQ1JhakZteXZjWGd2WkF1Y1lSVUpqV0ZTZnRQOFViQ0xlUEM4VTly?=
 =?utf-8?B?dVkwRlNXVFVaSU9TMGV3Tk43VUdxdWNtdUxHb2cyV0pzQmdnb2N1NDJxMTZq?=
 =?utf-8?B?N2FBSTR3dDBsYXdvY09NR2FTaWZ1RHgvcmRhNGxveCs5V2M0c3VWWlhSU29x?=
 =?utf-8?B?Q01veUtvUnh2T05veHNMbW8xbzBLU2Q3UHVTM1JVSHBlQURuc3NQQnY1dERT?=
 =?utf-8?B?eGhyNWRvN2FiU3hrYm41SFFuQWFlZUVFRXV2SzlQcCt5eGFwQ3pRb2xqbmxk?=
 =?utf-8?B?clNhZVF6OVVNVkhjWGlFbzVDdDNTYlZlTStjTmZxY0JKMDZTOWFRNXFDaWo0?=
 =?utf-8?B?MDJ4ak1GZUMrblZLUmlYM25iUW5aaWFyOHBRRzRIM3BORnlJZHNoaVpsQVpz?=
 =?utf-8?B?bXVVelVrZ2lsNi82dklMTVlTbXdvc0dUMkdCLzZBa0pQNHB5cTVjcHpxa3lz?=
 =?utf-8?B?bXc4WmNOOWJyMEFOTU5QaUd3aHFqcU5tQ283YURBOGNIbXZEd2c3ejZCc1Jh?=
 =?utf-8?B?UmprcHFIb1RXZEZRblIxeENEemJjelM1ditiVFhOMWFWcWFOUEhvQzA3V0t2?=
 =?utf-8?B?TStLa3A2VnBaMkxwc0VlL3Q4cFJ2WWhqV21KTmZiaFhtcDd6bjkrdXFVd1J6?=
 =?utf-8?B?eEVSM1RxbjJhNUhOWjNLQnpLVGhiaitMaU0xcEJ0MmF5Tm1CeE10K1YxZlhj?=
 =?utf-8?B?bSsva1V6N3ZIaUE2NGhwQzZReXYzUFFXeGhvMm1CUjREbFVjWjB4Y21Kam9R?=
 =?utf-8?B?cjVuUUlmL0VZaG8xdEZwSlhIL1ZEeCsrTm9SUnpTNTVVV2w3NTRGblJ2TTlq?=
 =?utf-8?B?bmlCQ004ZWRUaEdMclhUM1hiNW1SRWhQWmF2cnk4R09IQWw4am16NDkzMEtX?=
 =?utf-8?B?MDVyUlR0MURsSkVNTHJQRzRvcTlmeHcwL01NQjhVQWxwSjhsM29zcGV5dFlz?=
 =?utf-8?B?bWlINHBNSzcwSDE4YXp1dWhrUCtRNktFVjE2eXFqNjg5Um1wTXdoT2drQnNZ?=
 =?utf-8?B?clUySGRKdTZCdUpzK29xVWVQN0hIY3cwc2QvSmhDa1RCSk9sdnExbU03dkQ4?=
 =?utf-8?B?MVhXWDVVWWo4R3VPL3hRS3RWNHdvNkd4ZFZBbTFVaHlpTC9Xc1VQaFQ2cjNJ?=
 =?utf-8?B?UmlrNkU5VVJtWEtZUHc5VVRicDl5enpoZGlwZVlxYWorN05xOXU4OXFzcUNo?=
 =?utf-8?B?STZKREgzeG9PYkdaaWZreklNaHpCWDI0N1NEaUMrc1dlRE4rR2g0ZzZ1Y05C?=
 =?utf-8?B?WXYrVnNoaStDY2VUZmhjTzkvbmV5eTFYSmtWRWJYU2lSTnFBOWsyeXJZYzIv?=
 =?utf-8?B?L1FCUG51SnU4UTNZYzA4RkJVc21mVDhiMW9saThiakt2QXduZFJkcEg5TTkr?=
 =?utf-8?B?bW5ZcFpPSlhxQzB3SDU1VVhFT1ZWajVwbnhhU21LTTN1K0NXKzdGVkFJTTAx?=
 =?utf-8?B?RzVXV0VSK0wrdTVaQXkrc1VidlkyWHhTeElQczB6VmovMzdodkdGQ2hVckZ4?=
 =?utf-8?B?ZUhILzJld1B3M2Q0aHFla2VSbEI1RE81SS90cWFValJTOG5mMmVFNlIyZGFh?=
 =?utf-8?B?Y0tJbXJEZ3RBUzVmcDlzcXJxMm11SjZrQW5hZmo2M3hGUVFkOXF4QkNOQ1VT?=
 =?utf-8?B?V2psUFNtcmNGYXJmWmx5ZTVJYXBtUk81WWdoZmVEU3BhbS9JSHRJRFg2bXJS?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6DF25BD95D20941864CFCD4882025E8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31cdf13-a63c-42b5-aa79-08dc134390f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 07:53:29.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4HShLFqdiGb8U9qpDmel609UOAbrqGPF5Y11rYkI1N62IG0zbjMYSJlZs15LAgEAjgTrDAFQZXLbS4WzzLYUNAKbPnTOfHZ6K+GMSuBWuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8732
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.774500-8.000000
X-TMASE-MatchedRID: 9zTThWtzImunykMun0J1wia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2twCZxkTHxcclMkOX0UoduuTUsHjosUACSqK2
	aXFdgHvqkN82NTTG5VmKZKgqeFEBZEV60qkfIybn8gEfQ4Av4R5sqkCVjbLpJRC8FOrq2WvajxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.774500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BC0EF11A38EABC97063048420D9172307F8B8978FBD42C93A006535A16B03E542000:8

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZWl2ZXdzLg0KDQpPbiBGcmksIDIwMjQt
MDEtMTIgYXQgMDg6MjIgKzAxMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMTAvMDEvMjAyNCAwNzozNSwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IENo
YW5nZSBtZWRpYXRlayxnY2UtZXZlbnRzIHByb3BlcnR5IHRvIHJlZmVyZW5jZSBtZWRpYXRlayxn
Y2UtDQo+IHByb3BzLnlhbWwNCj4gPiBpbnN0ZWFkIG9mIGRlZmluaW5nIGl0c2VsZi4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtZHAzLXJkbWEu
eWFtbCAgICAgICAgICAgfCAxMSArKystLS0tLQ0KPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy1yc3oueWFtbCB8IDEyICsrKystLQ0KPiAtLS0t
LS0NCj4gPiAgLi4uL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtd3JvdC55YW1sICAgICAg
ICAgICB8IDEyICsrKystLQ0KPiAtLS0tLS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+IHJkbWEu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxt
ZHAzLQ0KPiByZG1hLnlhbWwNCj4gPiBpbmRleCA1OWRiODMwNjQ4NWIuLjFiYTcwYjlhNTg0MyAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEv
bWVkaWF0ZWssbWRwMy0NCj4gcmRtYS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+IHJkbWEueWFtbA0KPiA+IEBA
IC00NCwxMyArNDQsNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICA0IGFyZ3VtZW50cyBkZWZp
bmVkIGluIHRoaXMgcHJvcGVydHkuIEVhY2ggR0NFIHN1YnN5cyBpZCBpcw0KPiBtYXBwaW5nIHRv
DQo+ID4gICAgICAgIGEgY2xpZW50IGRlZmluZWQgaW4gdGhlIGhlYWRlciBpbmNsdWRlL2R0LQ0K
PiBiaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oLg0KPiA+ICANCj4gPiAtICBtZWRpYXRlayxnY2Ut
ZXZlbnRzOg0KPiA+IC0gICAgZGVzY3JpcHRpb246DQo+ID4gLSAgICAgIFRoZSBldmVudCBpZCB3
aGljaCBpcyBtYXBwaW5nIHRvIHRoZSBzcGVjaWZpYyBoYXJkd2FyZSBldmVudA0KPiBzaWduYWwN
Cj4gPiAtICAgICAgdG8gZ2NlLiBUaGUgZXZlbnQgaWQgaXMgZGVmaW5lZCBpbiB0aGUgZ2NlIGhl
YWRlcg0KPiA+IC0gICAgICBpbmNsdWRlL2R0LWJpbmRpbmdzL2djZS88Y2hpcD4tZ2NlLmggb2Yg
ZWFjaCBjaGlwcy4NCj4gPiAtICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMi1hcnJheQ0KPiA+IC0NCj4gPiAgICBtZWRpYXRlayxzY3A6DQo+ID4gICAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlDQo+ID4gICAgICBk
ZXNjcmlwdGlvbjoNCj4gPiBAQCAtOTYsNiArODksOCBAQCByZXF1aXJlZDoNCj4gPiAgICAtICcj
ZG1hLWNlbGxzJw0KPiA+ICANCj4gPiAgYWxsT2Y6DQo+ID4gKyAgLSAkcmVmOiAuLi9tYWlsYm94
L21lZGlhdGVrLGdjZS1wcm9wcy55YW1sDQo+IA0KPiBZb3UgbmVlZCBmdWxsIHBhdGgsIHNvIC9z
Y2hlbWFzL21haWxib3gvDQo+IA0KPiBBcHBsaWVzIHRvIGFsbCB0aGUgcGF0Y2hlcy4NCj4gDQoN
Ck9LLCBJJ2xsIGFwcGx5IGl0IHRvIGFsbCB0aGUgcGF0Y2hlcy4NCg0KUmVnYXJkcywNCkphc29u
LUpILkxpbg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

