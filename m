Return-Path: <linux-kernel+bounces-21457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEE5828F66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD51C24A01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84E3DBAC;
	Tue,  9 Jan 2024 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Eacls0qW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PytB69wQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC733E460;
	Tue,  9 Jan 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409CNciG008035;
	Tue, 9 Jan 2024 16:03:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=PODMain02222019; bh=16cGTnryCRP+4z1qdxvR2ODHEU/4vqaRhk7pgqi1d
	0s=; b=Eacls0qWizhiHX09vVPAug8wt444YRj7Mr05IY3p986T/OeawzJaORbDV
	NymFYA8jelTae7/DmFgnQV779NX2nh/TW+Kx193Dg8WkW6FM0tCFgc50/PApndBX
	WsmuSN+P+Engc56vuA4qgOXBbYqcFtUGFuTGVAWED0es3wIO38idAhVz7kJxqDt0
	WpnP3GUUz2EYVmfiVZLGKXDfh5BwsnlG624dAKKIezY5VTNiwcnh8L2Q4gCnmOJk
	DGQ53ymCek6WPrCKJ9k3iyQ9QWWUsGEUwqAQZIy868M45H3Naz6eOGwN7lI/CJbY
	TpoUGYKG+gVeV3Zg2nh4T/10PRfag==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vf552mh5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 16:03:07 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq+tC27e/ysZ9rZwDaQnH8/o6sR460nR4ZRn8mwH+JP+bBNuI5EFRPIYBuRXq+Z8nUtPQZPukIIwhzvfs4H0Gh6DmPxmsNJCINr/1sDQhkiznQQaQ4KiJF27sIBCsNsH/pi+zLSqe+5E7rRgZSzJIOzStnt/ZH+Uz1FIpJ9WiODapnbOTxqIAARUABSyJArb+foQRu5EnMk+DH+/Fl0WJ21wWXxMOyB0oKWVW1/i6lrFPVhqhxO3wiQCYMamKZyGZOZxGZWAVJkVgpSau/l6fEZiYKbbEJJmRlvQvNeh0N2xLrfCJsrZ95ILGf8rt9rgknGYAFPi+M/Yd3xY7T7ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16cGTnryCRP+4z1qdxvR2ODHEU/4vqaRhk7pgqi1d0s=;
 b=A1PQTgRpTW54CRcxaEnMEw7LIE/ATThp2udwepUnQkSkzvO7t5Pecfb7UqANMqupFBcA3qbK49qcNZiQ9bzFKVbCAYxUeOM0mAiS61KsiSRpx523qGiWgdccJ0RzPf+FlwU9xK1RRho5iZh7OKzMDmEWDmr5S7aYYWLvd6Rp2cFyIXmh3lG9rH2BYXxFrsvXy4OzOAtofFjbwq1sRCTBvSBkrsDq66yBNdN/cyVcG4yVrC7W8/Ee6ayXa6qadpky2Yxd0HkvUsDmmPUCEVqRAvF7hyH+M1K0cUg0rZ2BJBWAlORWD7aDnE1rqknfyn8wenV97NMRyxOVtP+TAE2hWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16cGTnryCRP+4z1qdxvR2ODHEU/4vqaRhk7pgqi1d0s=;
 b=PytB69wQUUiMQYIUPvDMfF3QX3oMnrzDjQjTKWRRY7dIQ4fIfZ1KUZegJUtw/kk0+357EJL8KIR/lfA7t574E400d+isO5tua09LkjYY4+hpyvd+8Jmd3pbEn/OmM8NrFjNDrkHBhdNZylFOHZPPWlThfeE8Ydu2YqoOXzsT1RA=
Received: from DS7PR19MB5688.namprd19.prod.outlook.com (2603:10b6:8:73::14) by
 PH7PR19MB7482.namprd19.prod.outlook.com (2603:10b6:510:27d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:03:02 +0000
Received: from DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb]) by DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:03:02 +0000
From: James Ogletree <James.Ogletree@cirrus.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven
	<Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<James.Schulman@cirrus.com>,
        David Rhodes <David.Rhodes@cirrus.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Peng Fan
	<peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        Jacky Bai <ping.bai@nxp.com>, Weidong Wang
	<wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Topic: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Thread-Index: AQHaP17EFm09wiwp9km197ze4eTGobDNm1eAgAR1GIA=
Date: Tue, 9 Jan 2024 22:03:02 +0000
Message-ID: <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
In-Reply-To: <ZZoFUwOEF6NByIp2@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5688:EE_|PH7PR19MB7482:EE_
x-ms-office365-filtering-correlation-id: e4026cb0-1005-4114-689f-08dc115ebfc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 f59XcfI/07sVIYOafmxqaImQqmmOzlTUJYgPN/js1L+zxNfjkfsET/PEHmzjljTeXVEz3wu1zh1Gd8I7Fkl/IESqIM/BzSfWA1a+lHSaRsKhu/2C3gIt3ha1neWfUEcFzdAkJHhbUjSRDgZXMzjTRe4jk8TPvVqgYC+17prXmecWwa/jmbzVNrAC8VC1N/e1Kgoy8Gq3rHg6oRRQaTdR8ZGrMbD0oL6CJL2Ur8DNXyYGt/mZY7t+yZ+dcWcjngT6E5Q+y7TpqoLEONI1474K6pOwZ5hURki42Xal6POP8N6X17xCqiTUWZissgD+7dD4L5rUWTFXxE2oGGbimO0PGKN9k5Q4DwlsAqnvadH1LrXMWTKQbOHsQIAO4+US35sn693oBkI3kjGVsnJQcHaEzQF/Zf86tfgSNdV2KYPS7JbyR7+myOFee/Wp/W5HHMVndgG0Dcu5wrhExT+8SaxInYg8omMF2V3VshXykVVU/yeBw85gf2rPVB1S5N3BI1ceWmu5J2BvvyNn71Nmf3JQwcuEtnCk2enwfQJobSOidWaVM7oz4FPE23Jxsdfw05cSnVtvl/yUTUoPY1zpPupoN7qH0f6gaDRf2xdcG/xLIRaCNOGRpbL6iMC4fDmv3wXUsCiA75cw+Owr0haP1DT9qw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5688.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39850400004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(2906002)(7416002)(5660300002)(38070700009)(86362001)(41300700001)(36756003)(54906003)(122000001)(316002)(8676002)(8936002)(6486002)(2616005)(66946007)(76116006)(66476007)(26005)(66446008)(64756008)(6916009)(6512007)(478600001)(6506007)(83380400001)(71200400001)(33656002)(53546011)(66556008)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZDJscVE3Zm9lcjdVMzYxN1hkTXZwRjlkY1VOYmpVdjZKZXUrZFpRVmtDSUI1?=
 =?utf-8?B?aEhmZGpHbjY5RU1yUnZVUk9sNUNtNkd2RHY2RkFsL0dBUGdDRStucEtXc211?=
 =?utf-8?B?QnFyUGhyWTJMRVBicjNWM0p5Z1MwUkpwejRnZVRwaVdpWEMvL0VqL0IrU3Rn?=
 =?utf-8?B?c3lFQXQ1d0w5NlIwZk9lRlNtSU9rTnFobGdzZ2Z0VHlpZFhLZWR5SVQvTmJO?=
 =?utf-8?B?K0c0NlhsazZjbDV5aDRyNlBIY29Cb05LQTVrVzVSd0xTQ3JrcWNmcFpCWE1M?=
 =?utf-8?B?K1k5cGNEN3NXMGtBTFJQbFI5S3N4NUd6T0Rvc1VCRHY1dTZBaDB0aVhhMEpm?=
 =?utf-8?B?Sy9JRDJHSlhQMGdSNm5LcVlZMnZlU0Z2Q1ZHbTlaa1dYL3ZQTGRCOTF4OHRI?=
 =?utf-8?B?dllqTHdOaHM0UDdrN0F2L3ZOZE54SU9jaDMraWVHeWZrdWJERGhkdUJXSUZp?=
 =?utf-8?B?VlhSVE9qOFYzU3ZYV01WSmUvYmJ4aW9qazgvUmg1QnJGWldQWGhOWFlyendM?=
 =?utf-8?B?V1dqWFNUNDRKOU9YNGtNZi9ucUtxeVBtbmRmRzZscEkwY054N09xYmsrT2N3?=
 =?utf-8?B?d3ZvMUdSYkE5QVZHaSs3Tml5Q2FGMXpWQ1ZVOFAvZzlLWHcwem5UaTFKYzVt?=
 =?utf-8?B?L21TL05YWDhRY1o2eVJzUDJ1QVViN1NZU1FwbDlQQmlpRjF0K2pmdGZ5SXNH?=
 =?utf-8?B?ai9xMVEyTDZSM1kvN0xlbTV3dFR3Vy9ISGdLYktSR3BkWWtCTUx2MWo1SjRx?=
 =?utf-8?B?dlJMdzNuTlJ2NG90VHJtQWRvOXhhdFZCTXZ6OUdhMUVMcTNQdnB4b1hud2ZD?=
 =?utf-8?B?Y0tOTW5BSndFTVVNNlpmVmdCb2syMlRqbjFLa0xnamJNRmpLUWxuelo1RVJr?=
 =?utf-8?B?Z1dWdVRjR25RYWF2L1RJd3UrVXJ4ZXlYS1cyM1ovQVF1cEdyM1NkLzJQa1lV?=
 =?utf-8?B?SGJ6eVZVOVlyajF2N0lTOG1uM3lwUnV5UFBKTFZ0UTVyb0E2T2lKSGZxMWhl?=
 =?utf-8?B?RDlkSUNDUTRSVTRaS3kxTXhDL1ppSU1VclVZODBlKzUwVnd2cHR5OUZJL0RG?=
 =?utf-8?B?UWR0QmlQNTdldjQ2aEFEWXZXdEZTRlp3RnJSOEdTYytldXRlWitHb2xlSWVs?=
 =?utf-8?B?T2J6Qk5UaU5ZamtjelNtZDRYTFJLbTE1K2V3b09ER3pVbFB3ay92U0twbDVG?=
 =?utf-8?B?cmcwSC9mSXRCWVhxd3M1UGwwVkkrUTJpZGxSR1FsSG5PZFdFdWRMeDdBYnJw?=
 =?utf-8?B?cEFQdDJVaHd0UGZ5QnpkNDZ0emc4RGlDUFc3eGVNdmY4U3paZXBtYld3bnAw?=
 =?utf-8?B?REZ2Rzdjc0FWNkx5UUtRcEtpSzRQUzh2dUJrd2tCdUVjdTd1TzJJRFB1VDhv?=
 =?utf-8?B?VE5tV0NtRlppN2VCZFdYMWtzVHhodU54d095MWNINVQwTGJ6T0NtZWRkb2pt?=
 =?utf-8?B?akprYTdvMlRWYVBxRTlJc1N3WWFpSzd5bmpEUFNaMEVzbUg2UHdPTEYrOEdU?=
 =?utf-8?B?YXFGMXlxb3BCa3JHQzRFWkt0bmpmOVZpZjkyT1dlK2dJT3Y3MGVMSU9sRDdZ?=
 =?utf-8?B?ZjU2Y0lnN1JpQjlFdkNBWlBZbUFQY0NTT2NhL1cxWXM5VjBzM2JxVWV6T0VD?=
 =?utf-8?B?S3NIc3RTalAvNzVsY0RRZjg1NDFrSk0yREFqUEF5U3Zwc1liNS84ZWZlZ09m?=
 =?utf-8?B?YkJCTnJZNFJJaDFoWXFOdDJuYWt2QkhVMlZ6aEJXS2d6WXpIVUhhQ3kvTG0w?=
 =?utf-8?B?L2Vhc1FXUEpXM1ZYMXN2ZG9rcDFxMGR2V2NFYSt2c1Z3U2F4WDdodHU0OW5s?=
 =?utf-8?B?aUtJaWxKWDF5YUNjckdPQXI4d1dERlI2U1NvNWkvdmtwTmdvczFYRUVoN2pQ?=
 =?utf-8?B?dnlacW9MNW51a3hiS3QzMmJFMDIra0lZcGRyN0M3QzVSckVKaVpYbUtmSFRF?=
 =?utf-8?B?bkhhaGNpOGlIOTlLQXFSclNDWlJFZ1pXbUJRVkFnY0p5Q0lWbDEzQU0vRHRS?=
 =?utf-8?B?Um15RnVpMEJQQURvd1AvQXNKb21GRlFzSjlGMzlUSFBOeURGSUJCU1gyTFox?=
 =?utf-8?B?R2FMUWtpVWoxVDNkc0t6VWVIbGREM2xmSithbDZtNWFsVm1VR2hoWUhxUUp6?=
 =?utf-8?B?b3Y0WW9MLy9TSWc2UUtTT1ZyaVR0U2pKaXowVmRNOWJ3MThGNHNER21qN3dQ?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C1F429260D39B4CBBAFF6C62DAEC20F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5688.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4026cb0-1005-4114-689f-08dc115ebfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 22:03:02.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS/mjiaYdKydGvT9NE92ZEstG8hOhUvpPADr8EwSm/EQQvsbDQPckWO7wjFzennB6UJC5AAWN0ZcpeQx481UERQCF1qvKlfDZaJbgYHPqqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7482
X-Proofpoint-ORIG-GUID: c9qzVwraXqHAiO0ZWblf3CsdoKAp_H8i
X-Proofpoint-GUID: c9qzVwraXqHAiO0ZWblf3CsdoKAp_H8i
X-Proofpoint-Spam-Reason: safe

SGkgRG1pdHJ5LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZXhjZWxsZW50IHJldmlldy4gSnVzdCBh
IGZldyBxdWVzdGlvbnMuDQoNCj4gT24gSmFuIDYsIDIwMjQsIGF0IDc6NTggUE0sIERtaXRyeSBU
b3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUs
IEphbiAwNCwgMjAyNCBhdCAxMDozNjozN1BNICswMDAwLCBKYW1lcyBPZ2xldHJlZSB3cm90ZToN
Cg0KPj4gKw0KPj4gKyBpbmZvLT5hZGRfZWZmZWN0LnUucGVyaW9kaWMuY3VzdG9tX2RhdGEgPSBr
Y2FsbG9jKGxlbiwgc2l6ZW9mKHMxNiksIEdGUF9LRVJORUwpOw0KPj4gKyBpZiAoIWluZm8tPmFk
ZF9lZmZlY3QudS5wZXJpb2RpYy5jdXN0b21fZGF0YSkNCj4+ICsgcmV0dXJuIC1FTk9NRU07DQo+
PiArDQo+PiArIGlmIChjb3B5X2Zyb21fdXNlcihpbmZvLT5hZGRfZWZmZWN0LnUucGVyaW9kaWMu
Y3VzdG9tX2RhdGEsDQo+PiArICAgZWZmZWN0LT51LnBlcmlvZGljLmN1c3RvbV9kYXRhLCBzaXpl
b2YoczE2KSAqIGxlbikpIHsNCj4+ICsgaW5mby0+YWRkX2Vycm9yID0gLUVGQVVMVDsNCj4+ICsg
Z290byBvdXRfZnJlZTsNCj4+ICsgfQ0KPj4gKw0KPj4gKyBxdWV1ZV93b3JrKGluZm8tPnZpYmVf
d3EsICZpbmZvLT5hZGRfd29yayk7DQo+PiArIGZsdXNoX3dvcmsoJmluZm8tPmFkZF93b3JrKTsN
Cj4gDQo+IEkgZG8gbm90IHVuZGVyc3RhbmQgdGhlIG5lZWQgb2Ygc2NoZWR1bGluZyBhIHdvcmsg
aGVyZS4gWW91IGFyZQ0KPiBvYnZpb3VzbHkgaW4gYSBzbGVlcGluZyBjb250ZXh0IChvdGhlcndp
c2UgeW91IHdvdWxkIG5vdCBiZSBhYmxlIHRvDQo+IGV4ZWN1dGUgZmx1c2hfd29yaygpKSBzbyB5
b3Ugc2hvdWxkIGJlIGFibGUgdG8gdXBsb2FkIHRoZSBlZmZlY3QgcmlnaHQNCj4gaGVyZS4NCg0K
U2NoZWR1bGluZyB3b3JrIGhlcmUgaXMgdG8gZW5zdXJlIGl0cyBvcmRlcmluZyB3aXRoIOKAnHBs
YXliYWNrIiB3b3JrZXINCml0ZW1zLCB3aGljaCB0aGVtc2VsdmVzIGFyZSBjYWxsZWQgaW4gYXRv
bWljIGNvbnRleHQgYW5kIHNvIG5lZWQNCmRlZmVycmVkIHdvcmsuIEkgdGhpbmsgdGhpcyBleHBs
YWlucyB3aHkgd2UgbmVlZCBhIHdvcmtxdWV1ZSBhcyB3ZWxsLA0KYnV0IHBsZWFzZSBjb3JyZWN0
IG1lLg0KDQo+IA0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgdmlicmFfcGxheWJhY2soc3RydWN0IGlu
cHV0X2RldiAqZGV2LCBpbnQgZWZmZWN0X2lkLCBpbnQgdmFsKQ0KPj4gK3sNCj4+ICsgc3RydWN0
IHZpYnJhX2luZm8gKmluZm8gPSBpbnB1dF9nZXRfZHJ2ZGF0YShkZXYpOw0KPj4gKw0KPj4gKyBp
ZiAodmFsID4gMCkgew0KPiANCj4gdmFsdWUgaXMgc3VwcG9zZWQgdG8gc2lnbmFsIGhvdyBtYW55
IHRpbWVzIGFuIGVmZmVjdCBzaG91bGQgYmUgcmVwZWF0ZWQuDQo+IEl0IGxvb2tzIGxpa2UgeW91
IGFyZSBub3QgaGFuZGxpbmcgdGhpcyBhdCBhbGwuDQoNCkZvciBwbGF5YmFja3MsIHdlIG1hbmRh
dGUgdGhhdCB0aGUgaW5wdXRfZXZlbnQgdmFsdWUgZmllbGQgaXMgc2V0IHRvIGVpdGhlciAxDQpv
ciAwIHRvIGNvbW1hbmQgZWl0aGVyIGEgc3RhcnQgcGxheWJhY2sgb3Igc3RvcCBwbGF5YmFjayBy
ZXNwZWN0aXZlbHkuDQpWYWx1ZXMgb3RoZXIgdGhhbiB0aGF0IHNob3VsZCBiZSByZWplY3RlZCwg
c28gaW4gdGhlIG5leHQgdmVyc2lvbiBJIHdpbGwgZml4IHRoaXMNCnRvIGV4cGxpY2l0bHkgY2hl
Y2sgZm9yIDEgb3IgMC4NCg0KPiANCj4+ICsgaW5mby0+c3RhcnRfZWZmZWN0ID0gJmRldi0+ZmYt
PmVmZmVjdHNbZWZmZWN0X2lkXTsNCj4+ICsgcXVldWVfd29yayhpbmZvLT52aWJlX3dxLCAmaW5m
by0+dmliZV9zdGFydF93b3JrKTsNCj4gDQo+IFRoZSBBUEkgYWxsb3dzIHBsYXliYWNrIG9mIHNl
dmVyYWwgZWZmZWN0cyBhdCBvbmNlLCB0aGUgd2F5IHlvdSBoYXZlIGl0DQo+IGRvbmUgaGVyZSBp
ZiBtdWx0aXBsZSByZXF1ZXN0cyBjb21lIGF0IHNhbWUgdGltZSBvbmx5IG9uZSB3aWxsIGJlDQo+
IGhhbmRsZWQuDQoNCkkgdGhpbmsgSSBtYXkgbmVlZCBzb21lIGNsYXJpZmljYXRpb24gb24gdGhp
cyBwb2ludC4gV2h5IHdvdWxkIGNvbmN1cnJlbnQNCnN0YXJ0L3N0b3AgcGxheWJhY2sgY29tbWFu
ZHMgZ2V0IGRyb3BwZWQ/IEl0IHNlZW1zIHRoZXkgd291bGQgYWxsIGJlDQphZGRlZCB0byB0aGUg
d29ya3F1ZXVlIGFuZCBleGVjdXRlZCBldmVudHVhbGx5Lg0KDQo+IA0KPj4gKyB9IGVsc2Ugew0K
Pj4gKyBxdWV1ZV93b3JrKGluZm8tPnZpYmVfd3EsICZpbmZvLT52aWJlX3N0b3Bfd29yayk7DQo+
IA0KPiBXaGljaCBlZmZlY3QgYXJlIHlvdSBzdG9wcGluZz8gQWxsIG9mIHRoZW0/IFlvdSBuZWVk
IHRvIHN0b3AgYQ0KPiBwYXJ0aWN1bGFyIG9uZS4NCg0KT3VyIGltcGxlbWVudGF0aW9uIG9mIOKA
nHN0b3DigJ0gc3RvcHMgYWxsIGVmZmVjdHMgaW4gZmxpZ2h0IHdoaWNoIGlzIGludGVuZGVkLg0K
VGhhdCBpcyBwcm9iYWJseSB1bnVzdWFsIHNvIEkgd2lsbCBhZGQgYSBjb21tZW50IGhlcmUgaW4g
dGhlIG5leHQNCnZlcnNpb24uDQoNCkJlc3QsDQpKYW1lcw0KDQoNCg0K

