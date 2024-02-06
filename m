Return-Path: <linux-kernel+bounces-54621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6C084B19B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4542826B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554F12D745;
	Tue,  6 Feb 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kM4/1qj6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JVtRZB52"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DC12D157
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213064; cv=fail; b=KZ3+w33BGOwpdJK31RDXmxB33YfwDK7LGx5gCXTwu6LCZrjYrryUbZlEXdmZpGzveDTwIRSwtrZDHLpAIIkaRHp2dBL1pRNshfMHEfhr4g5V7SaCqetrPCHZ6L4OAbEMDUqCpGEBnFiXggYm4DCChfCzeC239+q/fb4rIuLQC+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213064; c=relaxed/simple;
	bh=n0Q/GmkqBgHvfMkkUZLFt0RiftrGrTNLILB0EWbRQ18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mn6sYRWXjtp83MGKPGdVlMyFSKL9OvYRWMFgDiHETKHso5vlOwhzhQH/a9n77N+mnCMSiRrw3bvWs9Nb15X8mQHyJ0T+As5zPPzMjT6dYOxlDOJASRuYdoObTv0oYMaKp1o6ClzBKcNu2bvQSrojn9N4Qzi4d6j6XMiZ11OhMYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kM4/1qj6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JVtRZB52; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 33a8c3a8c4d511ee9e680517dc993faa-20240206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n0Q/GmkqBgHvfMkkUZLFt0RiftrGrTNLILB0EWbRQ18=;
	b=kM4/1qj6upT/5wFQnoZRz7Defcp2n/uX8Tvjn8bMP4dEtImZmQ6+f3MMCoBRANCkzkGmbkn0pYcvOXWPSLU4oub7h/crbLUh/4c8gpHL4xKND5KFfQKXEGqnQ1sCnar4N11XQSAX/+9/UF1fAbccYDcGqQgQ/Hw++gnpQROAJgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d1d528e9-921e-49ef-912b-566935c907e5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:05adad83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 33a8c3a8c4d511ee9e680517dc993faa-20240206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 169303738; Tue, 06 Feb 2024 17:50:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Feb 2024 17:50:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Feb 2024 17:50:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QolfpRYHWHPK9ZIoO0MuCHonOl4CdPp91OWlmfASVeqVONf8WGYoD9o2TumfUhaFd7Ro2LrV9dGuQLfZt7XbaHvblNr6FgnJSucDgsf+D1eQ6kkwZtSdLdkYkaLxGzn4A2y7Z89YIc3cuf/fSHj7zKRus6PzYVjpMGglZQinZZ/epcBX6jmu1CYWh5VRGJLU36nFiToVzQEG887BQeEluUZ3j14FYJG1Hlq5CsPjPKJsGJPoj5bBFBWcUrGsYKbUzT9xzeWHKndwJWczU9YYGOMzKiJItPQZvizIe5sMeoODpANGVXIZ7iObGG64+ZLEOZ71DmPziqMyzGNJBWle5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0Q/GmkqBgHvfMkkUZLFt0RiftrGrTNLILB0EWbRQ18=;
 b=a+SXs7IcYznh+5u3sMMUMTAhemXAIyhnfA0Ya6rYHlVi4hJgz/YTO+LwWWiQqFp3iNATPnR9nuACM8HP2nRygFAOnHNWgkJLHY5rFlID+6kNVAKjBAwtM7vRZP/EzNrHpl9Wum6SnZ53fvf/oQwJj2yvePYSRMfYZoZbb887MpnsiS2ZWailrVUbF3Txux/FoiFTGzC1Ic5W9+tMvAibUnRh2mDWLGqZppaVNuerGa8ojIAguDHyj+ugqSIes10yDd7jEZgtdWm+RT22RvMKisD3k4eYydI3lv+m8pLCY+2ZOVwrH7Qz659N0GobCoStdwqRGLvalFuWf1tsmwFpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0Q/GmkqBgHvfMkkUZLFt0RiftrGrTNLILB0EWbRQ18=;
 b=JVtRZB52A18O//UJus0QeItgn6HJHIbq/KZqq7WFAUR3chgKVM5BSqga3Ia8gBaNwlvQLZFbbODhUeLnIqwx6mXednB2QgfqB5rUGlBx2jHGglwKaNOz6cPjM7lU+0WzMhTNc9a3O/60cpeak+Ee1ZdB+Z2eJUrekTSFDZYHWv8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7571.apcprd03.prod.outlook.com (2603:1096:400:410::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Tue, 6 Feb
 2024 09:50:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281%5]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:50:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/7] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Thread-Topic: [PATCH v3 2/7] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Thread-Index: AQHaVDmLcgoPeaZ1rkSpFo642zgWdrD9G28A
Date: Tue, 6 Feb 2024 09:50:41 +0000
Message-ID: <14e124f02d82ff151974f99d042c4197e4dd5dd7.camel@mediatek.com>
References: <20240131113434.241929-1-angelogioacchino.delregno@collabora.com>
	 <20240131113434.241929-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240131113434.241929-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7571:EE_
x-ms-office365-filtering-correlation-id: 22a55871-46e9-475c-7a06-08dc26f914c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S25pAWNGdOCkzNZnqJRjo6zDgXLFxTwG31qMD9dqh5NjGyNV8SOkbQsPBmqITdfNM5TNxgMk6tD6XIpq4trxMjKrTjnD5IAorLTSdPGVRPKgMciffzsWNOoZ5jqnfnfnnY+vic3U+8pflfiWzL7cvZT6quQs2nK7MIFXK7Sy56f4XXfLU8OQPtnyiCRhzBKIgorNkiYh0IsnB4DG8kgZzBYl2U/r2JBQI/MBlLPh6BMkpP/0Rm8/70G2Qq73WMKX1QnScGqZ8PlLFid2baMsFPa/O8BHRtBgDkF5Y2OaG/aLDIfRHyJanROCZEYFK3TdZP+vuYCMgXpfLlJCwaCCLeVt82We2QYyyjwDC60H2iCFmT0iMhCRyBgU6ko0cHWLjUyhJ+gdqHkotLwChWVvGl7jlkq52RSB/5FvUX0m9gL9SCRMuLR7l4kKrdmKmDP17mU6ttMRl+i5UhVrX+kYMwBDt3yacfZraDVQfdR2u2T1grVwaOzEeDrnx9Wm0rKh1AGdYklawbLKuRlMadEsO1przQsW0tkZ19mxIY/Y1fY+GbOvs27EAx3O7+oGncJqhbh27FP3Zw7d/WuWjfsCTM/YAChHMEEnuvZDpLoEha68bVDr5h66TIPuKogT5xk4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(6512007)(41300700001)(86362001)(8936002)(7416002)(5660300002)(8676002)(110136005)(4326008)(2906002)(66556008)(66446008)(64756008)(66476007)(316002)(54906003)(38070700009)(76116006)(85182001)(36756003)(478600001)(38100700002)(66946007)(71200400001)(6506007)(83380400001)(6486002)(2616005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWpENU1KeXV4ekpiYkttanVPb1JJVml5dXJNdnN1OUNjZjFOT1pGS3hkVzBO?=
 =?utf-8?B?QkVta0lpdFZPUkw3V2JQVFVsOGRPMHY4V1U3dllJQ1NDeE52cytwUms0ZkxC?=
 =?utf-8?B?dC9TU0w5R1ZkektwTXBlMEllTFJrUzQzUzZwUldKbHZzUVlWZzk4MnhHZ1pJ?=
 =?utf-8?B?Tk1BL0s5dzQrczhxWEx2dUtHd3ozUmk3RG5KVHhUZHl1NTRnTVFkUWxvNUZu?=
 =?utf-8?B?M0tkSzV5WnhVY3UzOTc5VUVWbEpKMVJqNWdGaGk4STNtR01CYm5zUlk2dXVE?=
 =?utf-8?B?QklGd256SDZHMFBSTldTb0JDUFltLzNpSzJYdmhpSEYrdTlkd21ZaSsrVDFL?=
 =?utf-8?B?L09mZFVTRGdKeElEVUp5WFFsemlVMklTMDl0Ym0yY3BJU3dKdHlmOTArOU9Y?=
 =?utf-8?B?OCtQd2NHKzVha3JYeklPSzAvRk04WTJWSDFxZHp3R0dXNURTRGV1aC9wMGhO?=
 =?utf-8?B?cFJORnN1NEcvL29uaFluK1VDZHVqNS9lRWJrYmU1Ukp0YWtCRzNEdStmaWw5?=
 =?utf-8?B?WldTR3VQOUlFdVhuREFDbklTUWd1ejZWS05Qc2xqNXlRd1BaNnhaUnJYaWlk?=
 =?utf-8?B?eGZiZVJYeTJpeFZlc0R3RE9IeXhIU01CZVNVNGVleXkvc1Y2V3BHTWo3S0JJ?=
 =?utf-8?B?akVBclNpQUs2d3pHMHc3QytjVmFmeGFQUTdSdENKWGRXOHR2WSt3dXBEcnRW?=
 =?utf-8?B?amltV2VjNXljaGRQZ0NHd1pzTG14YzNuRUtwM1F1bzM1ZGRhWVpRWjJUVUJD?=
 =?utf-8?B?WlN3ZEZod1A0L0VBRXB3VFErR3BXMlpIbnBmbEI4M3Y0VVVySkdMQit4MnZ3?=
 =?utf-8?B?bWM1cEl5bUxYNU9wS3hCMFBITWtnVjk1K2RyUjBOdGRqMG1WcGp2R3JaRnJ4?=
 =?utf-8?B?c09QbkVZSDNabEpXZE4xVVF5MUxiRkVjU0ZDVk5nTThFK3c2a1Nxek5kdEti?=
 =?utf-8?B?aUFNb3J5dVVweUVHQU1hMytDOTRHNWpKSTdkT3VTVGJtVTBGMTBTQWdiaU5k?=
 =?utf-8?B?S2lzZHMyVno5d3NxQmhFK1NIZzhYcVZ1RWczTmdZcnc0aXgwMkFUekZzcm82?=
 =?utf-8?B?aWlwMFltZWNUVUFKMnFlMVZZQkdQbEdnamVCV3hBb1lINEh6RmpiNUZWNXFx?=
 =?utf-8?B?TTVrSlFLUG5OQnlMOXhhZzBBQUdkMFJTeVRWeUluUFBKdGxsYWxQVWgwRk83?=
 =?utf-8?B?c1dBb1F1aDEwaGZiSXlYZVBJdU5EMnhiWm9YNVg0cCtsUWY4VzJBM3BPaXMv?=
 =?utf-8?B?WldlOTk1RzlBaWdTczNLcnRNV2RzNGJFc0RvQm15WGtRWDhmUS9obHY1KzRh?=
 =?utf-8?B?Tm1FUEg4QkU3Z3FJTXBLZFYyeHVWVU5HME9oOGdldHFMTzl3R1RPL214UzNl?=
 =?utf-8?B?MUdZTG45VjQyYjlNRWgreEpCbkU0bWFPZmg5UXhqSURVSXZ4N3M5VTRpSXlq?=
 =?utf-8?B?b2dPU0t0a3ZWWHRLRUxFSzZCczN5S1NrZGF2M2dFbEdvL1hhdnFJOGN5NUlS?=
 =?utf-8?B?cytBSEtjd1J1MWE2SlJiSlNkeERQaER5cW9EU0s3Rjk4ckJXZ1dpUFl6VWdR?=
 =?utf-8?B?b1R2SGthMlRzRUp2bVhhN0tpdDJTZCtMWk9VMDd3SGc4SWRqbEFvYnduTkR2?=
 =?utf-8?B?NjlJRk1JOVRYOHJPM3pvSTRhU3VLYzBWcm0zb2xLdEFDdVlzQlFFb0IzZm9F?=
 =?utf-8?B?SDd4dXMwbGc3RkZUWGpBT2QyZzAwcDc4eVV5bVcrY21wb044NnhJL0FGZmRn?=
 =?utf-8?B?SG1Hbm85QXlrUEhOQlBHMThFNFU5eWtFdjhJRjRrejlCRXJzMStHalZRNXFu?=
 =?utf-8?B?a3hsRzJoT0dROEVvdk5YSGhOS1ZsOFpPRldKSVV0L0o2Qm5XWjlwbHFoeTgw?=
 =?utf-8?B?RytPMEh6YVJBeDhmZVJBR0hwTTliTDc2VVFMa2dOMHIvUjJBNHdXVzU5b2w3?=
 =?utf-8?B?ckRWdHpFTVZrRmpkTU82RVFIdDZ2UGhCd25EUDRhNFFoNCtpZVhkYjRxcWx1?=
 =?utf-8?B?SGhzdlhWY3ZnbkQ1NkhGdVlTOGs1c1JpOVVIZHBhVENGdlBxNEJYSGpaVlgy?=
 =?utf-8?B?RFZLWlp0dDhSVW5IOHhzZGl4UjZnM2ZDTHd1aXNxMi9naWFxMHVVWFF2Y1du?=
 =?utf-8?Q?da1a6sqEh/WRtpKNpOgNKMiQs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C52B9BD5B4CF045BDC4A37485A45EF2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a55871-46e9-475c-7a06-08dc26f914c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 09:50:41.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uqLS7kUfYfX2Eb6tSw6fhuGwBy2WC7XkwdD0ZRA5MFgK6CUxFmHZiWvtnKPi+6FarKKbrrjP2jpr2FbQNF8Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7571
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.586600-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYNtKv7cnNXnSa1MaKuob8PC/ExpXrHizwGW3hFnC9N1Xxm
	C/CenOgN0Q2PKuAVSm5v0m8F0YusaSUtdpGicV4RA9lly13c/gHt/okBLaEo+Luqk4cq52pzmbc
	KRmzJEYU58CIn96icLbFDVUe0p6pLwuTfHDVJ/170hv/rD7WVZIyOql5H9hUNCwWRLqiC/UqJW1
	4oA532uFHt4fwsd7PhNUqwxsefwYkM8jMXjBF+sNIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2r
	l3dzGQ1GpeevGsoI5enFeS89CMDHrJ13/HNvwKE58UWoF3WrbfGKWGPX4/+wC+KPcsYuSMNVhyk
	pjTJ72BHUHMpUZTGO0Hb4V6MM9v1PI1oyzhaJJS5ZyimlDMxyA56xhuba2WuZ86KY3oNT3zIO0S
	i2Tuenn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.586600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B949D22B542D36C6D41A7CCA921D94D457359CF8C63AF3A6F72B897266D2D2732000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAxLTMxIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRnVuY3Rpb24gbXRrX2RzaV9wc19jb250cm9s
KCkgaXMgYSBzdWJzZXQgb2YNCj4gbXRrX2RzaV9wc19jb250cm9sX3ZhY3QoKToNCj4gbWVyZ2Ug
dGhlIHR3byBpbiBvbmUgbXRrX2RzaV9wc19jb250cm9sKCkgZnVuY3Rpb24gYnkgYWRkaW5nIG9u
ZQ0KPiBmdW5jdGlvbiBwYXJhbWV0ZXIgYGNvbmZpZ192YWN0YCB3aGljaCwgd2hlbiB0cnVlLCB3
cml0ZXMgdGhlIFZBQ1QNCj4gcmVsYXRlZCByZWdpc3RlcnMuDQo+IA0KPiBSZXZpZXdlZC1ieTog
RmVpIFNoYW8gPGZzaGFvQGNocm9taXVtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDc2
ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCA1MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYw0KPiBpbmRleCAzYjczOTJjMDNiNGQuLjg0MTRjZTczY2U5ZiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC0zNTEsNDAgKzM1MSw2IEBAIHN0
YXRpYyB2b2lkIG10a19kc2lfc2V0X3ZtX2NtZChzdHJ1Y3QgbXRrX2RzaQ0KPiAqZHNpKQ0KPiAg
CW10a19kc2lfbWFzayhkc2ksIERTSV9WTV9DTURfQ09OLCBUU19WRlBfRU4sIFRTX1ZGUF9FTik7
DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2b2lkIG10a19kc2lfcHNfY29udHJvbF92YWN0KHN0cnVj
dCBtdGtfZHNpICpkc2kpDQo+IC17DQo+IC0Jc3RydWN0IHZpZGVvbW9kZSAqdm0gPSAmZHNpLT52
bTsNCj4gLQl1MzIgZHNpX2J1Zl9icHAsIHBzX3djOw0KPiAtCXUzMiBwc19icHBfbW9kZTsNCj4g
LQ0KPiAtCWlmIChkc2ktPmZvcm1hdCA9PSBNSVBJX0RTSV9GTVRfUkdCNTY1KQ0KPiAtCQlkc2lf
YnVmX2JwcCA9IDI7DQo+IC0JZWxzZQ0KPiAtCQlkc2lfYnVmX2JwcCA9IDM7DQo+IC0NCj4gLQlw
c193YyA9IHZtLT5oYWN0aXZlICogZHNpX2J1Zl9icHA7DQo+IC0JcHNfYnBwX21vZGUgPSBwc193
YzsNCj4gLQ0KPiAtCXN3aXRjaCAoZHNpLT5mb3JtYXQpIHsNCj4gLQljYXNlIE1JUElfRFNJX0ZN
VF9SR0I4ODg6DQo+IC0JCXBzX2JwcF9tb2RlIHw9IFBBQ0tFRF9QU18yNEJJVF9SR0I4ODg7DQo+
IC0JCWJyZWFrOw0KPiAtCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2NjoNCj4gLQkJcHNfYnBwX21v
ZGUgfD0gUEFDS0VEX1BTXzE4QklUX1JHQjY2NjsNCj4gLQkJYnJlYWs7DQo+IC0JY2FzZSBNSVBJ
X0RTSV9GTVRfUkdCNjY2X1BBQ0tFRDoNCj4gLQkJcHNfYnBwX21vZGUgfD0gTE9PU0VMWV9QU18x
OEJJVF9SR0I2NjY7DQo+IC0JCWJyZWFrOw0KPiAtCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjU2NToN
Cj4gLQkJcHNfYnBwX21vZGUgfD0gUEFDS0VEX1BTXzE2QklUX1JHQjU2NTsNCj4gLQkJYnJlYWs7
DQo+IC0JfQ0KPiAtDQo+IC0Jd3JpdGVsKHZtLT52YWN0aXZlLCBkc2ktPnJlZ3MgKyBEU0lfVkFD
VF9OTCk7DQo+IC0Jd3JpdGVsKHBzX2JwcF9tb2RlLCBkc2ktPnJlZ3MgKyBEU0lfUFNDVFJMKTsN
Cj4gLQl3cml0ZWwocHNfd2MsIGRzaS0+cmVncyArIERTSV9IU1RYX0NLTF9XQyk7DQo+IC19DQo+
IC0NCj4gIHN0YXRpYyB2b2lkIG10a19kc2lfcnh0eF9jb250cm9sKHN0cnVjdCBtdGtfZHNpICpk
c2kpDQo+ICB7DQo+ICAJdTMyIHRtcF9yZWc7DQo+IEBAIC00MTYsMzYgKzM4Miw0MCBAQCBzdGF0
aWMgdm9pZCBtdGtfZHNpX3J4dHhfY29udHJvbChzdHJ1Y3QgbXRrX2RzaQ0KPiAqZHNpKQ0KPiAg
CXdyaXRlbCh0bXBfcmVnLCBkc2ktPnJlZ3MgKyBEU0lfVFhSWF9DVFJMKTsNCj4gIH0NCj4gIA0K
PiAtc3RhdGljIHZvaWQgbXRrX2RzaV9wc19jb250cm9sKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+
ICtzdGF0aWMgdm9pZCBtdGtfZHNpX3BzX2NvbnRyb2woc3RydWN0IG10a19kc2kgKmRzaSwgYm9v
bA0KPiBjb25maWdfdmFjdCkNCj4gIHsNCj4gLQl1MzIgZHNpX3RtcF9idWZfYnBwOw0KPiAtCXUz
MiB0bXBfcmVnOw0KPiArCXN0cnVjdCB2aWRlb21vZGUgKnZtID0gJmRzaS0+dm07DQo+ICsJdTMy
IGRzaV9idWZfYnBwLCBwc193YzsNCj4gKwl1MzIgcHNfYnBwX21vZGU7DQo+ICsNCj4gKwlpZiAo
ZHNpLT5mb3JtYXQgPT0gTUlQSV9EU0lfRk1UX1JHQjU2NSkNCj4gKwkJZHNpX2J1Zl9icHAgPSAy
Ow0KPiArCWVsc2UNCj4gKwkJZHNpX2J1Zl9icHAgPSAzOw0KPiArDQo+ICsJcHNfd2MgPSB2bS0+
aGFjdGl2ZSAqIGRzaV9idWZfYnBwOw0KPiArCXBzX2JwcF9tb2RlID0gcHNfd2M7DQo+ICANCj4g
IAlzd2l0Y2ggKGRzaS0+Zm9ybWF0KSB7DQo+ICAJY2FzZSBNSVBJX0RTSV9GTVRfUkdCODg4Og0K
PiAtCQl0bXBfcmVnID0gUEFDS0VEX1BTXzI0QklUX1JHQjg4ODsNCj4gLQkJZHNpX3RtcF9idWZf
YnBwID0gMzsNCj4gKwkJcHNfYnBwX21vZGUgfD0gUEFDS0VEX1BTXzI0QklUX1JHQjg4ODsNCj4g
IAkJYnJlYWs7DQo+ICAJY2FzZSBNSVBJX0RTSV9GTVRfUkdCNjY2Og0KPiAtCQl0bXBfcmVnID0g
TE9PU0VMWV9QU18xOEJJVF9SR0I2NjY7DQo+IC0JCWRzaV90bXBfYnVmX2JwcCA9IDM7DQo+ICsJ
CXBzX2JwcF9tb2RlIHw9IFBBQ0tFRF9QU18xOEJJVF9SR0I2NjY7DQo+ICAJCWJyZWFrOw0KPiAg
CWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2Nl9QQUNLRUQ6DQo+IC0JCXRtcF9yZWcgPSBQQUNLRURf
UFNfMThCSVRfUkdCNjY2Ow0KPiAtCQlkc2lfdG1wX2J1Zl9icHAgPSAzOw0KPiArCQlwc19icHBf
bW9kZSB8PSBMT09TRUxZX1BTXzE4QklUX1JHQjY2NjsNCg0KWW91IGNoYW5nZSB0aGUgb3JpZ2lu
YWwgbG9naWMgaGVyZS4gSWYgaXQgaXMgYSBmaXh1cCwgc2VwYXJhdGUgdG8gYQ0KaW5kZXBlbmRl
bnQgcGF0Y2ggbm90IGhpZGluZyBpbiBhIGNsZWFuIHVwIHBhdGNoLiBTbyB3ZSBjb3VsZCBiYWNr
cG9ydA0KdGhlIGZpeHVwIHBhdGNoLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCQlicmVhazsNCj4g
IAljYXNlIE1JUElfRFNJX0ZNVF9SR0I1NjU6DQo+IC0JCXRtcF9yZWcgPSBQQUNLRURfUFNfMTZC
SVRfUkdCNTY1Ow0KPiAtCQlkc2lfdG1wX2J1Zl9icHAgPSAyOw0KPiAtCQlicmVhazsNCj4gLQlk
ZWZhdWx0Og0KPiAtCQl0bXBfcmVnID0gUEFDS0VEX1BTXzI0QklUX1JHQjg4ODsNCj4gLQkJZHNp
X3RtcF9idWZfYnBwID0gMzsNCj4gKwkJcHNfYnBwX21vZGUgfD0gUEFDS0VEX1BTXzE2QklUX1JH
QjU2NTsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+IC0JdG1wX3JlZyArPSBkc2ktPnZtLmhh
Y3RpdmUgKiBkc2lfdG1wX2J1Zl9icHAgJiBEU0lfUFNfV0M7DQo+IC0Jd3JpdGVsKHRtcF9yZWcs
IGRzaS0+cmVncyArIERTSV9QU0NUUkwpOw0KPiArCWlmIChjb25maWdfdmFjdCkgew0KPiArCQl3
cml0ZWwodm0tPnZhY3RpdmUsIGRzaS0+cmVncyArIERTSV9WQUNUX05MKTsNCj4gKwkJd3JpdGVs
KHBzX3djLCBkc2ktPnJlZ3MgKyBEU0lfSFNUWF9DS0xfV0MpOw0KPiArCX0NCj4gKwl3cml0ZWwo
cHNfYnBwX21vZGUsIGRzaS0+cmVncyArIERTSV9QU0NUUkwpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0
aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+
IEBAIC01MjEsNyArNDkxLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdfdmRvX3RpbWlu
ZyhzdHJ1Y3QNCj4gbXRrX2RzaSAqZHNpKQ0KPiAgCXdyaXRlbChob3Jpem9udGFsX2JhY2twb3Jj
aF9ieXRlLCBkc2ktPnJlZ3MgKyBEU0lfSEJQX1dDKTsNCj4gIAl3cml0ZWwoaG9yaXpvbnRhbF9m
cm9udHBvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IRlBfV0MpOw0KPiAgDQo+IC0JbXRrX2Rz
aV9wc19jb250cm9sKGRzaSk7DQo+ICsJbXRrX2RzaV9wc19jb250cm9sKGRzaSwgZmFsc2UpOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHNpX3N0YXJ0KHN0cnVjdCBtdGtfZHNpICpk
c2kpDQo+IEBAIC02NjYsNyArNjM2LDcgQEAgc3RhdGljIGludCBtdGtfZHNpX3Bvd2Vyb24oc3Ry
dWN0IG10a19kc2kgKmRzaSkNCj4gIAltdGtfZHNpX3Jlc2V0X2VuZ2luZShkc2kpOw0KPiAgCW10
a19kc2lfcGh5X3RpbWNvbmZpZyhkc2kpOw0KPiAgDQo+IC0JbXRrX2RzaV9wc19jb250cm9sX3Zh
Y3QoZHNpKTsNCj4gKwltdGtfZHNpX3BzX2NvbnRyb2woZHNpLCB0cnVlKTsNCj4gIAltdGtfZHNp
X3NldF92bV9jbWQoZHNpKTsNCj4gIAltdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKGRzaSk7DQo+
ICAJbXRrX2RzaV9zZXRfaW50ZXJydXB0X2VuYWJsZShkc2kpOw0K

