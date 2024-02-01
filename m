Return-Path: <linux-kernel+bounces-47924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D98454B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89081C2174D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438F159566;
	Thu,  1 Feb 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qx/qjbyi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jcLvyz7W"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760B4DA0B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781725; cv=fail; b=K1cKHizd6+xudAwTZxp1QdMviLYbaFLY1Qct2VQY3zKoEKsjNIHVKnWdmlNQc9O3pFvlzEKTIzfMk1TGZAGSsYLippus3y5fdwHrDEEaNaMyXWzR4m9b1JKFJnbMh6DwABNOrHMUtPDYg6aGjhCp3+g7UJh29Rkmc0wiJbj0EAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781725; c=relaxed/simple;
	bh=m/j5CpwsU2iwNuW9yRJEadX61jU//ZDwRwrYjffPfLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N4ycPLexJxf9dFLYUAUdYTH2ixU3S7wt27DbR9f2cRwrrXJjCRXh9B8+mfZowbuAUrFqBJ1RuhV1HdcKdOvUFWqQhIAW2XUXcVkZ83BxWRSlsu0JRt/6Rp/lCVpHE73YgTcw7GGk/BObhTgq+Vyf6oWKolJBK9KsH8Wd2WelpRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qx/qjbyi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jcLvyz7W; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: efb3156cc0e811ee9e680517dc993faa-20240201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m/j5CpwsU2iwNuW9yRJEadX61jU//ZDwRwrYjffPfLg=;
	b=Qx/qjbyi5y+aAXZhMPlDNtTAV71LAa0Edo1z2ZQGFqDQBQ9Bws9Glh83+31HSEe6iIGB4vQWP6l5z8fIlD4IhsxRHQ4U26bemGHpQZldVAT0RGzfzIC31PRs0iw4qeq05gscA+aQB4oXUZSFTYFxO9npDprl700zuXu03kgPuTA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:87a63dcc-e84e-4970-a3c5-63d72469f132,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:19b566fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: efb3156cc0e811ee9e680517dc993faa-20240201
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1286782982; Thu, 01 Feb 2024 18:01:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Feb 2024 18:01:56 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 1 Feb 2024 18:01:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEOlJVK7VBGcr3p+fu9P98wroWzj8YBBw+IEb34PFLuJ5JR0oPCd4Cbu59Q/SEABdS40DMqb0NE5qQpkF173aydeCL9dMivzkh9Q/phanq8FTFLhkaXXWRxHDeivRAoqRTjyydDv/UcOQ2auIYiC1/gsIgktPjE9YO134s7sh6ZplR+XCNVJt445t/KY4b31SYcrBQBq31HsZkVpgsyvpWTa0cJiCxLciQ26fvXRP2jpRJ16VPrXSQLNQ22VXpPE+wXDRTtwmZoOh5m5bw91U7rRdjao8f6yXUhRoQ9BZhxkPBQLEuOsRKyyaX68SfbJOdosucfSnbLTSVO9LJpwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/j5CpwsU2iwNuW9yRJEadX61jU//ZDwRwrYjffPfLg=;
 b=LcdkvWWuEkIsRqTHpZXH98PQdD6+T3av7pezEtMDYR9RDHfoAPM+4368+z2M/cpG8Eb+d9ju0pRFejLSFXwJaR51/Jxv3XS20SBDvsHLlsADrq7jLTDOl7mopi5MvnGnE9/CdrXzDbXNrSEXbT0rrlgf2TVCwIsEazWLz8FVm+T+EWAxV4eWicE4kC0NYVJ96GDZAGCeb+lzuWKWq24eUMfGbkHif0nAVdGILiXLj04OruQMA/Nl45Km3TAinnlOaNS21oYebaQHOat7yXreKDbbohZEPe1nXJCGFHpuPGxSLgZXkhKRlR61gtpdHNQ70std03HRIezuZPipeP876A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/j5CpwsU2iwNuW9yRJEadX61jU//ZDwRwrYjffPfLg=;
 b=jcLvyz7WOyFx9HSYkkB9PPlV/Q7DHcqZ5jHVncFU2jPK+SSaW9eG+qhimFhkiYkGFVD15DInU4IssnNtr0XbafOrszRD09Hc4ZhPOCtka+sasNJAHszRXAbX9XvTx3wCMOzcH7E30msA/T1G1LNFGckSVAA9sVZ0o8mEpgXh3rw=
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com (2603:1096:4:1d4::14)
 by TYSPR03MB8835.apcprd03.prod.outlook.com (2603:1096:405:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 10:01:54 +0000
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::ee61:725e:c463:8c6a]) by SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::ee61:725e:c463:8c6a%7]) with mapi id 15.20.7228.038; Thu, 1 Feb 2024
 10:01:53 +0000
From: =?utf-8?B?Rmxhc2ggTGl1ICjlionngrPlgrMp?= <Flash.Liu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>
CC: =?utf-8?B?Q3lsZW4gWWFvICjlp5rnq4vkuIkp?= <cylen.yao@mediatek.com>,
	wsd_upstream <wsd_upstream@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] firmware: arm_scmi: Avoid to call mbox_client_txdone on
 txdone_irq mode
Thread-Topic: [PATCH] firmware: arm_scmi: Avoid to call mbox_client_txdone on
 txdone_irq mode
Thread-Index: AQHaVMqJcSxaNt2twU2z5czKsG+1ULD1LD4AgAAViAA=
Date: Thu, 1 Feb 2024 10:01:53 +0000
Message-ID: <e5dbd84996a3cd568b3f097a435ef14a69cf723e.camel@mediatek.com>
References: <20240201045253.14390-1-flash.liu@mediatek.com>
	 <7cf660b8-240f-442e-be55-2e6e6521338b@collabora.com>
In-Reply-To: <7cf660b8-240f-442e-be55-2e6e6521338b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB7279:EE_|TYSPR03MB8835:EE_
x-ms-office365-filtering-correlation-id: 7a4ccef2-1c69-42a3-c176-08dc230cd135
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Dvm+x7O+S75GkbCc5ExUKTIJEyzVcEPjHnzc0GzRpNysIOPyPCJvM6Ndm0Bol+RcndhapL0zJqN6/t8hGiz3d2N339oKNS7dqRscoKYKkjtZheJcZTnhLQpON3+/mJnegi9lfqHDcjkk6u4xQ5k19kWw3ckcRCSnXb/ASK7AH41dcpVokEpOvu45NZGshvg5SL7R7m2Ttr6bEq+SuRqS80HrB1t9U4D+acHi1GtgETP0Cf6Fexr7cgNJL+m4+zV0Aj+wP2ORk2umeID7jIDgUKzIGbxb1h74jr9+X7Nl6Mqlf9GkfH3pJRjiOEvTg3Z6yLNz3WD9CarnN54Lyeh6VteFbUb2+jUPvXNoelykK+lPGYG72imtTSn+/9DvAB8EndzQMooAUOnVQwcsOQMMnHnXT2kLrFnjr5B9QDm9jxKcn7c3Tv8LlQMmmTTj/TRvQnsK+69E+dhp/OnFeIotxuImwJfJ2MuUPCKpAuxCr4zIjA4Twzk0NawkR7GjNS15YimjC201QnIbLtqEF9Clc3dbZxI7xN23Bx1xeGkvpbFkRci0bvuABFy1huhYaDSbjb0ncPDgaazizTiR1nBSPAKHWxyWync45VSsFOXpqj9o1OY97PxyWTGK36PN2MO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB7279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(26005)(41300700001)(54906003)(38070700009)(66446008)(316002)(64756008)(85182001)(83380400001)(66476007)(71200400001)(6512007)(6486002)(6506007)(36756003)(478600001)(38100700002)(66556008)(122000001)(66946007)(2906002)(5660300002)(76116006)(4326008)(86362001)(8676002)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VSt2THhRQ2RWbmRwc1padjNLRlNHS3FIK2J6L0lzbWRxZEhaQlIxLzR5Ti8v?=
 =?utf-8?B?TVdtMWx4dWYwRWdmNkJkd0QwbWc4c05BTEVkUlM2V3d2S0xCUlNFbzQ1cTNq?=
 =?utf-8?B?dVVBb2lqWGk2YVQraUVzK3BTT2p3bkJoRGp1M0tEaHk1dldoeFpta01aOEto?=
 =?utf-8?B?bXZrMWdGWEVvalVod25HSzVpcDlWMnF2cm53b212YUViQjdsblRuWkVLdVVD?=
 =?utf-8?B?M1ZoTU5wWDFUM1V4bVZMeXB6eGVLaG5QU3lZS1JST0Z6TE1BQW1QRUpyeHJr?=
 =?utf-8?B?bVIzdDlxSUhUQ0ZDOVJFMGkrcDdWcStCdG1ZczJzT0tRSDFmcThJeUtGZFh0?=
 =?utf-8?B?cFNVakJzVFFYd01IQmxtbTE3VTlHVGVuMGRwYU9lTWJsaVJCRjNRM05SdUJ0?=
 =?utf-8?B?dHlwRWc0QlplRlVNZmdnTGQ3Zy9aRU1mWDhIT0ZDQUpWNTR0VG9ES0d2M2hI?=
 =?utf-8?B?a2NtSVVYMFZmdWQyTUViUWtJc1Blek9XZlBRQ2NpTktGc3hFc1BrZ1FQdHkx?=
 =?utf-8?B?SWMzQ3FNZTd3YVpqc0tFYU9Ed2U3c1I2N1NDa3NvWU5kOG8yalN4cTlFRFo2?=
 =?utf-8?B?NDVBejNRM3RBUjhxZ1NiSnhyOWpSQkpmbUZna2lSa2JOcitVNnFKaGpkQVRX?=
 =?utf-8?B?cm5qd1ZhbUxDVS81a2Z6REhNcmdBTURuelVFanN3aTFqOVZrNktWZlRTNldq?=
 =?utf-8?B?RFRaaDhsSGRvcytweGhNR0d6a05PTUpDWVVMOWZDelB1eWFWQnM2d3N5dzd6?=
 =?utf-8?B?T2NJRnQwTmdCb3EwRVlBN1loN3o1dUl5MlpsSW55TEZLTG0wcUxVRktTZUUr?=
 =?utf-8?B?QWFlUUM4MTlXQzdwTWUrb0I5MERBWVAyRjNUMzl5TTE3MXJWSE5yWWt5Q0ZU?=
 =?utf-8?B?cUY5amQvWVBMcXdCNy8ySjJUU3VUa0FhVzArK0dvL1FHNVZWejgwZXI1dzkx?=
 =?utf-8?B?bE1lcjhuVkJPUmNxei91Rjg4NlhtWWU5akhiOEpORUo5UHJGOTJZckplVFdu?=
 =?utf-8?B?YU5xMkNRdnR0QWVrK1JCeWQvTDNQbmcyMUxFUzB6OTV0TGtodjgyTGZnTTky?=
 =?utf-8?B?NGxiVmtYZzhVNitnMkVYNWpHMHlCMzNrTGZBRmRxYjRxc2tVWlZ3UGtFOHVs?=
 =?utf-8?B?dzlOVytESkZHTFVOdm5wVlRQZysrdnF4U2pWdVg0UnFrMks0R3pPQW1tbDZ1?=
 =?utf-8?B?VGJadlEwdm9QZk9SS1hFNkpMNmNySm4vMDB3aUg4MWpUS0ZDUFlzbGpRbEEr?=
 =?utf-8?B?RDdwQldCMzlQQUp0aG9IY3JVa2t4NkYwL0lHWUxRQnZkbGUyajVQMG54SkIv?=
 =?utf-8?B?dHVaMk1sRGdYWTdXemYwT2J3QUdGU0VnU0hHVmxUOXF5NXU4Wlljd2taTjIr?=
 =?utf-8?B?TVRBR05FakpHRFZEKzFEN2FPTWkyb0E0TCs4NFpJeEovZnpEZWpscTdaVVR4?=
 =?utf-8?B?RHJVVmR0STJ0R1NqQ2x4M01FZWJjclN4VUhNczU1K3FaS0J4RkozQjZCbHlG?=
 =?utf-8?B?cVdZSlJtZjhGWmx5YlZHaTZoaWUvQzdQQUxVaEdXWCtHWjBrOE5QZXdnN0cr?=
 =?utf-8?B?clloMnMyR3JTd2ZBT0p4SitEdWYyV2lQN085aUswV2FuY3ozVHB0Wm1sRkJ1?=
 =?utf-8?B?YUJjbjBrcFB0QzBTdTZ3MWM4WHVoeUxTWkNrMndSUzhyaENpbis1dlJSeUJx?=
 =?utf-8?B?dGFUUVhMQ0RqSWNzVDVGUzhzU29hYyt0Qlhrd3NYQ2FtS3hqN0lLQ3diTUJo?=
 =?utf-8?B?TUN2clpGSUZvbS9CZEREdXEvai96enRaZzh5NTNuUFg3d1cvOEdLWGx1dVA5?=
 =?utf-8?B?bndCY0FoZnMxaUhZNlRGUkU4a1Y2UER4QUgyQU1LSVJMMWp5Z3RHVU8wd3M3?=
 =?utf-8?B?SjQxb2NDOHNicUprTVpPWWtvSTZCMWFXM3I5UnQzNmVLMTV4cWJ2cTE3bjFG?=
 =?utf-8?B?MEZjK2dBVkNXUUNhRkFZbEdrd0VNazdkSXp2bXFqOVZXYURSd2duY1d1SHZu?=
 =?utf-8?B?dER6ZUlobDFhNGVUakNMVlJwOW5yM0tlSUN0MWxHSlV5TlpZUGFGYjBYQkhi?=
 =?utf-8?B?ZkRaeXVDa1FESDVVN2pobk5mS01Ca0lmdU9sb283aHgydlpEU2FSdlpHQ25G?=
 =?utf-8?B?eHlQdW1sanp1N0JnN3lXZDByTW1pNXp1dnlkWmJUK2pyTVlYZUZvYXFvbVNG?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59D322B413D9BB4299E000F71BDED6A3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB7279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ccef2-1c69-42a3-c176-08dc230cd135
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 10:01:53.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzJ6jGsRlFcsWY397nEPyn8C02rmHYnK7e5bkhPD/OZH31q7/wTzKrxkK/oc6D+YVf7a6dmciKosRjugFfRB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8835
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.673900-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4uYAh37ZsBDCY9jdRrZwapWyrCkM9r1bWskU
	hKWc+gwPGn/WtUiprlBKPaf7gqXHGHYIQoHEix+q7spMO3HwKCDvJY9pBzgg1Fvo8FSqar5S39l
	SYY/1iRsjhyyvj8tLeuJTTC9C/TDryTBgz6hl0dcSEYfcJF0pRUJfxXUWJFGS31GU/N5W5BCiy1
	KZnNPG2qa4Tywc0f7RV1M/l3DgYREY3ren1qnVipMSBMTQNiSA0nXvwjW2mSW9CZ/Psf5gsaPFj
	JEFr+olFUew0Fl/1pGWc/0wwBlx2gtuKBGekqUpOlxBO2IcOBboFBofqzIBqxQ/WXKj9iXNkttK
	dleHW6L32gjFnqMfMhUN2UJlVN7T
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.673900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9DB8333F8A2BE00BC53125F2D75770013B57CE796B42A8A6B930DCBB3B17668F2000:8

VGhhbmtzIHRvIEFuZ2VsbywgVjIgdXBkYXRlZC4NCg0KQmVzdCwNClBpbi1DaHVhbg0KDQpPbiBU
aHUsIDIwMjQtMDItMDEgYXQgMDk6NDQgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsDQpSZWdu
byB3cm90ZToNCj4gSWwgMDEvMDIvMjQgMDU6NTIsIFBpbi1DaHVhbiBMaXUgaGEgc2NyaXR0bzoN
Cj4gPiBPbiB0eGRvbmVfaXJxIG1vZGUsIHR4X3RpY2sgaXMgZG9uZSBmcm9tIG1ib3hfY2hhbl90
eGRvbmUuDQo+ID4gQ2FsbGluZyB0byBtYm94X2NsaWVudF90eGRvbmUgY291bGQgZ2V0IGVycm9y
IG1lc3NhZ2UNCj4gPiBhbmQgcmV0dXJuIGRpcmVjdGx5LCBhZGQgYSBjaGVjayB0byBhdm9pZCB0
aGlzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbi1DaHVhbiBMaXUgPGZsYXNoLmxpdUBt
ZWRpYXRlay5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJYWNiZTBkMzZlZjljYzE2OTc0YzAxM2MzZTk0
YzQ3ZGM3OWVhZTUyYg0KPiANCj4gQ2hhbmdlLUlkIGlzIHNvbWV0aGluZyBpbnRlcm5hbCB0byB5
b3UgYW5kIGhhcyBubyBtZWFuaW5nIHVwc3RyZWFtLg0KPiBQbGVhc2UgcmVtb3ZlIGl0Lg0KPiAN
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZmlybXdhcmUvYXJtX3NjbWkvbWFpbGJveC5jIHwgOCAr
KysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2FybV9zY21pL21h
aWxib3guYw0KPiA+IGIvZHJpdmVycy9maXJtd2FyZS9hcm1fc2NtaS9tYWlsYm94LmMNCj4gPiBp
bmRleCBiOGQ0NzA0MTdlOGYuLmY2ZmU4MDFjMmUzNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2Zpcm13YXJlL2FybV9zY21pL21haWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUv
YXJtX3NjbWkvbWFpbGJveC5jDQo+ID4gQEAgLTgsNiArOCw3IEBADQo+ID4gICANCj4gPiAgICNp
bmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L21haWxib3hfY29udHJvbGxlci5oPg0KPiA+ICAgI2luY2x1ZGUg
PGxpbnV4L21haWxib3hfY2xpZW50Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
PiAgICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+ID4gQEAgLTI3NSw3ICsyNzYsMTIg
QEAgc3RhdGljIHZvaWQgbWFpbGJveF9tYXJrX3R4ZG9uZShzdHJ1Y3QNCj4gPiBzY21pX2NoYW5f
aW5mbyAqY2luZm8sIGludCByZXQsDQo+ID4gICAJICogVW5mb3J0dW5hdGVseSwgd2UgaGF2ZSB0
byBraWNrIHRoZSBtYWlsYm94IGZyYW1ld29yayBhZnRlcg0KPiA+IHdlIGhhdmUNCj4gPiAgIAkg
KiByZWNlaXZlZCBvdXIgbWVzc2FnZS4NCj4gPiAgIAkgKi8NCj4gPiAtCW1ib3hfY2xpZW50X3R4
ZG9uZShzbWJveC0+Y2hhbiwgcmV0KTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogV2l0aCB0
eGRvbmVfaXJxIG1vZGUsIGtpY2sgY2FuIGJlIGRvbmUgYnkgbWJveF9jaGFuX3R4ZG9uZS4NCj4g
PiArCSAqLw0KPiANCj4gQmVzaWRlcywgeW91IG5lZWQgb25lIHNpbmdsZSBsaW5lIGZvciB0aGlz
IGNvbW1lbnQNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCj4gPiArCWlmICghKHNtYm94
LT5jaGFuLT5tYm94LT50eGRvbmVfaXJxKSkNCj4gPiArCQltYm94X2NsaWVudF90eGRvbmUoc21i
b3gtPmNoYW4sIHJldCk7DQo+ID4gICB9DQo+ID4gICANCj4gPiAgIHN0YXRpYyB2b2lkIG1haWxi
b3hfZmV0Y2hfcmVzcG9uc2Uoc3RydWN0IHNjbWlfY2hhbl9pbmZvICpjaW5mbywNCj4gDQo+IA0K

