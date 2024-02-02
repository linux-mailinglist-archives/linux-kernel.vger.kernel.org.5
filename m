Return-Path: <linux-kernel+bounces-49850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE9847071
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD5C298416
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8BB15B1;
	Fri,  2 Feb 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="usOzi9nq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="B7TTuZ4z"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E193D8F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877428; cv=fail; b=UR1OP/QPBa20BCF81cEZJTQLp+HWNK2VBJkrIsEAQQKLuCLRfwLZZL5oQPjeZteRWFqEPxWoncZ98sLOpWAEEN22WSa+4AZaF401w1O3TXjr8k0Jb85I0aiSJFqEjcqGSpLEqHChj5LCOZ6gm6cWo2biqrhJIZatQRmC+WpiWP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877428; c=relaxed/simple;
	bh=XU75UVnBPRnChPV6WnxEeT8Xos1ypy0EL1YWBhVHtzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c54S+0QEQaQt6PY9U5TsUdYnK1tIftHmnyq1tO87zfA0z8QtU4vHpfRyEgHmLp+UV8G0Ba05PKUIypFz263dM7tcKYUCAPwyMx4K1aUTJvNZ1WVX5vaR2CSwhGl+9sQUxdoCYL5XgYoedtAVB3fAZo3PGaznjQNeDak5xyqiw+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=usOzi9nq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=B7TTuZ4z; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bed0a862c1c711ee9e680517dc993faa-20240202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XU75UVnBPRnChPV6WnxEeT8Xos1ypy0EL1YWBhVHtzs=;
	b=usOzi9nqHRMqSojMog4VaORMPxoQHMIVtgkyfRgPkYlCmy8TsPHCAvxSFazawPyVYPBXqU0/TizfcNQ3niCX3Nkq6yQhpbJOLNDvgvucsYeuo6UlWeMXlosKp/+fTBOnnv9ff5gvDEaCrZLWzvXmO0AclVAEN9hLeyqWMS9hSR4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:7065e1cc-643c-4485-af93-5639c8cf2c5c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:3ac972fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bed0a862c1c711ee9e680517dc993faa-20240202
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 425907208; Fri, 02 Feb 2024 20:36:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Feb 2024 20:36:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Feb 2024 20:36:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgPcP5/70utXkb5XlbX132ei5B+h1yTPA/1kOmVT4o3gNdONY22mW3AwbBuxZwjAZp1LZ+EBHRvEV30CsHj97lUltyae2DQuuOwE7xOQDvr6ZKguAqGxZqip5dM7GEtDBq1EfQSEQSi9xnX5I3ZoRBPv1CdYqsmbauTrieihkB6ft4fV4naABsMwCSjWdIRfJp6KuRdCFiLJnP1RWx6x8fnRfLeKx3VrSTtSaxbjyDZEJM1LlFh5NIyLE32M3wjKFX/K3MenoTbGKxtDcoG0/fbbbzglOSGN9sUtmBVOsRkGU98ZTvEzyv6uzF8OyorNyBvk6zdmEu/x2lkBnG1IuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU75UVnBPRnChPV6WnxEeT8Xos1ypy0EL1YWBhVHtzs=;
 b=bts2oF1icTHWVzU4vQhYK9MVTTAlwt5zCtr4ft4XLFm3vCeiF6tZ/t0Mts+uyG4AECnJRfdl58bBwcOLlL53Hsv9PiM60MgFpm3fbX0fz5+KWyt5OzWrhRVr0q/yn6Ie2u19E+YHGBohr62CjDVICUXrridh2Y9PbUQ0mvqdRlg+x1P8iZrIrzpCwGNvaPcqF7WiVM/32JlqTAHGAv7j1BoR8Hc/aL6FUxq7u1NlcvnwUYitvS6HiRLWXGh/O+biulgVHS/Fiump3Ii+Nn1F7qFocXalmTedgaNbLYs0WGd+4qTDe/nqLTv35pv1evj7n6LIbJvLhMKTgPDoyHgidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU75UVnBPRnChPV6WnxEeT8Xos1ypy0EL1YWBhVHtzs=;
 b=B7TTuZ4zywWuZzeBc9W5o+2zzrGuuliXNQZIrtBNAu2yzBvVvRQz91TP8wOAP5Y89onRfweA46S/dH8yFLjCJSpFjuAxXqcQFaNSE17MTFfaLbJuGKHExTngrBO8Fn2DTjHu80fGzO3a5K3Jal8ctTyWBaeqo2Qvo3n4M+4hAIk=
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com (2603:1096:4:1d4::14)
 by TYUPR03MB7088.apcprd03.prod.outlook.com (2603:1096:400:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 12:36:49 +0000
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::ee61:725e:c463:8c6a]) by SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::ee61:725e:c463:8c6a%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 12:36:49 +0000
From: =?utf-8?B?Rmxhc2ggTGl1ICjlionngrPlgrMp?= <Flash.Liu@mediatek.com>
To: "cristian.marussi@arm.com" <cristian.marussi@arm.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, wsd_upstream
	<wsd_upstream@mediatek.com>, =?utf-8?B?Q3lsZW4gWWFvICjlp5rnq4vkuIkp?=
	<cylen.yao@mediatek.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Thread-Topic: [PATCH v2] firmware: arm_scmi: Avoid to call mbox_client_txdone
 on txdone_irq mode
Thread-Index: AQHaVPVIVsXO+7KbOka+qKoEb18oerD24yEAgAAb7gA=
Date: Fri, 2 Feb 2024 12:36:49 +0000
Message-ID: <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
	 <ZbzKckIhn8HQv5pW@pluto>
In-Reply-To: <ZbzKckIhn8HQv5pW@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB7279:EE_|TYUPR03MB7088:EE_
x-ms-office365-filtering-correlation-id: 9e0250be-d361-45cf-4e88-08dc23eba03e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwzuwHnfrPtvAlII9d6CjIsQyfp949rw0/D9TlicuCNQQ4eKV+TKnRjUCwNRR0+ub76dMqopWipLLKomF36rvKAm9hd97alzM5y2eEYn6spUk0U8i6NwZbqeTeeXPaddZG9FqeZFQw/TEt/MkPKlD25n6dJDBDGeoiMHDKkhPmYUW0+tRZ425i4u9qune36oUoosRd2KBLNCTGQ5mi/DCRnVuxyXCCHTIAy8Wb+zD9CeEDTL0Aq3knv5gunWKLkKWHh1/qsq9U2/E7vCd6zRc7gZ6gmRXrG3Be0ZLNc8r3SlQReuK3XdsQdL7KJ4q1kvln57KtHEhSOF5YPvBUoPG1strNL1/n+M+85S6lBmK5iU0LjwKZaI/1RuyT683pUWquUyxhsM0mAUhf6HLX2QFZvwFj74k5pSKVcfuQBfAov/mCBB6d8kJHX9i5SvGrsAHW5DDVq2ognQWq6EYMsfsso/XC6s/b/lDPo79LhX3oW1fu/QIbQNPpSro3pQ6U8e3OJzSY48rvOK1vRNaai3xDBnWZEq0d5/I4aJM5Ac9zmIF0O3N00ojjtLxoqbGDB17gBYXFfDk/a4fXrL73eNUTuM8D0Kb1pmIR0wDOU8l8MZyDwP23IC+bnadX2os0IwCD5ICAcPoTebvHB1zNhqlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB7279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(83380400001)(85182001)(86362001)(36756003)(38070700009)(122000001)(38100700002)(2616005)(26005)(6506007)(76116006)(64756008)(478600001)(6486002)(54906003)(71200400001)(6916009)(66946007)(66556008)(66476007)(66446008)(8936002)(4326008)(316002)(6512007)(8676002)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVp4VTlRazYxeEoyOHUwMUtYTlRhWnhwMnhoQzJxb09rZmpoYWtmWFVPMTBV?=
 =?utf-8?B?REZNU3RicEdIQUxML3J3MWlvbXlpQmE5cUdNMHdMNWlEUUhMRGFhOGQvOGlx?=
 =?utf-8?B?ajIzZG1kVWJqSjFkL3oxTFN1SjB4U012U1FzOGswc0VNNGNoMGliQzFCTXBL?=
 =?utf-8?B?QnIwcFN5K05CU2RJRzU4QzcwSHFJSjY1Z2puMjRsamlkdTVtZVR0ZzE0Wjgw?=
 =?utf-8?B?bnB0NWc4MGZhK1FQVldFT0FDK2oxOE1QRmN4M3dDL2xveUM0cVZleGtFa1RT?=
 =?utf-8?B?ZHBQRUlGV3dQU2cydWxKOTVVUEU2bThpeFBTRlhJNElXeGZkMnZEMWZFTWNr?=
 =?utf-8?B?cGFZT0YyWkNENjBBa0l6RTkrM1I5bUFKTy9Td2MyNkU0dmh0WGVEUGRnWThl?=
 =?utf-8?B?cTZGeXpaejlMOVNmNGhDaW1KTWExOTVSSjdjTS9uOWFkZXlyNXdrM1FscEtq?=
 =?utf-8?B?WC91bG9nWnBjeERPTk5KU1dCY1RGdHBSUWlzM1JyeE5YYXdlMklGQXBPWG81?=
 =?utf-8?B?ck9BaVh4ZlBQUnJRcWNoN0xMVjJvWnJZUHZURm1BSy83N3gzRVBTUUVkUTFi?=
 =?utf-8?B?dmZXdVZkWHV6aUZLcmtRYVJneENWM25ueXJ6UmJZWGxQV2lGWUZGRktmdUlF?=
 =?utf-8?B?UmdzV0FFMjV6RjBwN01lSDh6a0NnOVl1U3RkTm5sdi9VVnpvQk0zUkcwelBz?=
 =?utf-8?B?eEg4RmxNZmxuT3l1dTZnc3dvdldDc3F0ZXNoSElaS1BVbnRzVGttZDcvTkhr?=
 =?utf-8?B?SUlZOXpLU0Y1bFJSSFluWWpRSTJBUnoyS2E4Z1BtVjFWTzFKZ0Q0Qm9LUzE4?=
 =?utf-8?B?c3NMMVpjTHNta091aERhVmt3S0Q4Zk1NRi9yTVR2WDg2dXp0SVRqK1lOa25i?=
 =?utf-8?B?NGtuNWFQVDFoeXBnVDJWVHMrT0wwV3RSaVgyb1NVdmF4ZUI1TzhKYjE4NGgy?=
 =?utf-8?B?dDgwcXhaUWlVeDRZNmpKaVcyTlgwY0dnRUpxM3VMaWJtQU16eDVZUnFPVjZX?=
 =?utf-8?B?RUdCZjc2YUVaaUxsYTJaMC8vZzZIc201SmF2NUcyQ1d4VEF4SG5hMHZ2K1g0?=
 =?utf-8?B?S05nMEY4djVaMk56QS9kNWNrbG4vcXJWa3FNc3o4citSWDlvRUVFVkpFVlYy?=
 =?utf-8?B?bkVHWjhGQTlWTXZ0NndOTmxsOTdxZjVkOFlpUDNqbWhleHZyL3JBZnU4M3hG?=
 =?utf-8?B?WFlxWTJVeS9SK0lkYUMwZUhocC9LZXRRc2FzQ1NKU2JxU2k0d1RQMmtKSUNV?=
 =?utf-8?B?dDA3UUZjeFdGNnlMMHZYcjZraUxmcXY0WGNiU0JzblhzYk1VcElkbXRzYjRJ?=
 =?utf-8?B?U3NNOThZYVVuNnlsQlAvOVZ0Yi80am93ekFIZmxWaUNacFV5R1I2NERvWG54?=
 =?utf-8?B?cy9CdTFRY2FWYWdtTVlMQTFVeTNWUGEwd0FFS09qRUlDK0Y4ZU90VFMwaE9J?=
 =?utf-8?B?em1vWU8vRXB0MDhRRmE5SkZXV1hWWjhuYmNTRk8yWXZ5OXFUd21VOWVaRHVo?=
 =?utf-8?B?bzk3Sm8wR2Q3YWl5QVR0b3dqdGtlZElLL1FyUVpHWVVXdFlMUkh0OTdOdGha?=
 =?utf-8?B?OWFwdG4yZStGa0lJTk1FTVMyajJDblNzTlJmeC9nbWFTV3VybXB5UmdKcDNs?=
 =?utf-8?B?RlJkbTNpSWtLZ2N2OVI1bk12SGN2cVRNRCtUaHVta25Fb1l6NkhURTMrWjVk?=
 =?utf-8?B?ZXJaL1FPQ1hYTEFSVDczK3M2WXhMcFAxengrS3NIbHJONEhJTW5ZazVNcklC?=
 =?utf-8?B?RnZFYUdqcDNUSzZCakdzMUxmajlpeDkrTytiWW04SFlxN0RCbWFXcFFOK3Rl?=
 =?utf-8?B?T2hvcUZoQmpjM0trTk05aklwYXJPbDFtNERoUDVQUkRxdUovdEZHbE9LS0JJ?=
 =?utf-8?B?cEJ1WGI2MnJ2VnNiSUp0UVdzSWszakFqRUt5ZGp0QU5lTnFMZHlETTlDVy8x?=
 =?utf-8?B?d2lKVUtLVFJ6YUx3MGFrSEowU0M2M3M1QWNJUVdCQ2t1ZzdSbGdhNGNaWVlT?=
 =?utf-8?B?MDltcHo4RGV5aXlCYWFLQlphL1RqNzZFd3dzdWFRazkxMmRiMmt3OEd6Zm5N?=
 =?utf-8?B?SVdNVG1NTkZ2cjFNU2hkU2phVWJ0bFRVUU5KSTBEMjhoZHFaSVVmQ0poNjRp?=
 =?utf-8?B?ZEtONFh5eEpLWnNoNEloNTRNWnFCOURRY1FjZnBXLzR0S1RvVjVGdEh3aW1p?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11028B5B7447664CBCECBFA8BEE10964@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB7279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0250be-d361-45cf-4e88-08dc23eba03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:36:49.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrfPV09+CjbcoOXz37jn/6LD8K57cUAnPsWEClWsOnpeHj3lodPZIPd5uZ6n+ZRgWB31lrlmPzC7Cgd3DbyvxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7088
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.810300-8.000000
X-TMASE-MatchedRID: F3kdXSFZYkfUL3YCMmnG4lIwtTtvyT1CEtdrY/Wb3fMs7eP5cPCWQ4Jp
	rzbcFdzao08uxFQToaSIukMxD7tJATpI0A0aNTmURlqShqb35p4Zj1j4BNp7XNhUoLB0ybhDyRS
	EpZz6DA/IYnVKJk2A46xcCIHpUrjwBtssTatiD/3C+o4YGuB7eyRii5mE9mXmyiPhwk5Hiq1iqT
	CaIpgXG/Dr2R4TYias6FitcwONFSmLwgJA7qJvFEhwlOfYeSqxOUMq8Vspro1GJOyYwlBX4LzIj
	p9Wmj43weebJ+rKEhyTnu3jYPRcBe7G+tZV7obXsaYkVcFnjzMIjen4m7yaqmzN1J6s5wy2I6qq
	9xPsXYgBqTv1J2BCwF+wdeqF8OOyMZPj25j8CtxCnGIuUMP0VX5Lmbb/xUua+yNYYwngrxYGqAm
	2SgFn8UMPxOsRD9avgFK2nmPCAnlC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07QKmAR
	N5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.810300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3AED81EBFDC91F4E3CAB1D64FB7DBAC8E5D124EB47C5B7B395C3B56AE5E140FC2000:8

SGkgQ3Jpc3RpYW4sIA0KDQpUaGFua3MgZm9yIGtpbmRseSByZXZpZXcgYW5kIGV4cGxhaW5zLiBZ
ZWFoLCBJIGhhdmUgZXZlciB0cmllZCBhbm90aGVyDQp3YXkgdG8gc2tpcCB0aGUgY2FsbCAoaS5l
LiBsZXQgbWFya190eGRvbmUgYmUgbnVsbCkuIEhvd2V2ZXIsIGl0IGxvb2tzDQpub3QgZWFzeSBh
bmQgYWxzbyB0byBiYWNrcG9ydC4NCg0KQXdhaXRpbmcgeW91ciB0ZXN0IHJlc3VsdHMgYW5kIGZ1
cnRoZXIgc3VnZ2VzdGlvbnMsIHRoYW5rcy4NCg0KUmVnYXJkcywNClBpbi1DaHVhbg0KDQpPbiBG
cmksIDIwMjQtMDItMDIgYXQgMTA6NTYgKzAwMDAsIENyaXN0aWFuIE1hcnVzc2kgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVGh1LCBGZWIgMDEsIDIwMjQgYXQgMDU6NTc6NTJQTSArMDgwMCwg
UGluLUNodWFuIExpdSB3cm90ZToNCj4gPiBPbiB0eGRvbmVfaXJxIG1vZGUsIHR4X3RpY2sgaXMg
ZG9uZSBmcm9tIG1ib3hfY2hhbl90eGRvbmUuDQo+ID4gQ2FsbGluZyB0byBtYm94X2NsaWVudF90
eGRvbmUgY291bGQgZ2V0IGVycm9yIG1lc3NhZ2UNCj4gPiBhbmQgcmV0dXJuIGRpcmVjdGx5LCBh
ZGQgYSBjaGVjayB0byBhdm9pZCB0aGlzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbi1D
aHVhbiBMaXUgPGZsYXNoLmxpdUBtZWRpYXRlay5jb20+DQo+IA0KPiBIaSBQaW4tQ2h1YW4sDQo+
IA0KPiB0aGFua3MgZm9yIHRoaXMsIGl0IHdhcyBpbmRlZWQgc29ydCBvZiBvbiBteSB0b2RvLWxp
c3QgdG9vLCB0byBhbGxvdw0KPiBNSFVzDQo+IGVxdWlwcGVkIHdpdGggVHgtQWNrIElSUSB0byB3
b3JrIHdpdGggU0NNSS4NCj4gDQo+IEhhdmluZyBzYWlkIHRoYXQsIHRoaXMgbG9va3MgZ29vZCB0
byBtZSBpbiBnZW5lcmFsLCBteSBvbmx5IHBhaW4NCj4gcG9pbnRzDQo+IGFyZTogdGhlIGZhY3Qg
dGhhdCB3ZSBoYXZlIHRvIHBlZWsgaW50byB0aGUgY29udHJvbGxlciBzdHJ1Y3R1cmVzIHRvDQo+
IGtub3cNCj4gaG93IGl0IGlzIGNvbmZpZ3VyZWQsIEJVVCBJIHdvdWxkbid0IGtub3cgaG93IHRv
IGRvIGl0IGluIGFueSBvdGhlcg0KPiB3YXkgaW4gZmFjdCBhcyBwb2Ygbm93Li4uOyBhbmQgdGhl
IGZhY3QgdGhhdCB0aGVyZSBpcyBhIGNvbnN0YW50DQo+IHJ1bnRpbWUNCj4gY29uZGl0aW9uYWwg
Y2hlY2sgZm9yIGVhY2ggbWVzc2FnZSBzZW50IGV2ZW4gdGhvdWdoIHRoZSB0eF9hY2sgaXJxDQo+
IHByZXNlbmNlDQo+IGNhbiBiZSBkZXRlY3RlZCBvbmNlIGZvciBhbGwgYXQgc2V0dXAgdGltZSwg
QlVUIGV2ZW4gdGhpcyBpcyBub3QNCj4gZWFzaWx5DQo+IHNvbHZhYmxlIGFzIG9mIG5vdyBpbiB0
aGUgU0NNSSBzdGFjay4NCj4gDQo+IFNvLCBhZnRlciBhbGwgb2YgdGhpcyBiYWJibGluZyBvZiBt
aW5lLCBJIHdvdWxkIHNheSB0aGF0ICB5b3VyIHBhdGNoDQo+IGlzIGZpbmUNCj4gYXMgaXQgaXMs
IGFsc28gYmVjYXVzZSBpdCBpcyBlYXN5IHRvIGJhY2twb3J0OyBuZXh0IHdlZWsgd2hlbiBJIGFt
DQo+IGJhY2sgSSdsbA0KPiBnaXZlIGl0IGEgZ28gb24gYSBjb3VwbGUgb2YgcGxhdGZvcm1zIGFu
ZCBnZXQgYmFjayB0byB5b3Ugd2l0aCBhDQo+IHByb3Blcg0KPiByZXZpZXcvdGVzdC4NCj4gDQo+
IFRoYW5rcyBhZ2FpbiAhDQo+IENyaXN0aWFuDQo=

