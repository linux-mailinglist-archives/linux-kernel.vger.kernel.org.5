Return-Path: <linux-kernel+bounces-93372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28BD872EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C1FB20F44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E51BDCE;
	Wed,  6 Mar 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QrdLszIT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pcV6o3Xy"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE91BDD3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705645; cv=fail; b=KqkZOUX+gqunlvd460cl/HTh+1yEl3CsQR5/k4Pu5mwklPCaSKAhAvaZ9CnR0ntxPZ+80gmpPSGHcQS363nSMd2Ji03CWK4ZBsu8a2/irGLPnYFhSd2iBBKtnR4OHIbzwkFOVXX6EIB9onyjVp2kiu8557iB6tgbTzvMyl9D5wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705645; c=relaxed/simple;
	bh=9r1EQFVq71yCgADMc+4LrCMAEsI8rmG38N765yiLeC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fbwes/4HBzsmj6lbmodZevTRDtKGgASapviJybfVTfvRVidZPPMWiTSep33KUQCqvfbVJVd6Q+/zzxCUjWxUDn+4zI1X8pUQHBCL7Gu/LG8IirN7BVfM4BlJjR8JCgBGqnv2YflFawOEBe+ro8RSp6UitZ4awXPUmndO8rJjaRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QrdLszIT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pcV6o3Xy; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b432946adb8011ee935d6952f98a51a9-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9r1EQFVq71yCgADMc+4LrCMAEsI8rmG38N765yiLeC0=;
	b=QrdLszITViwMn9pRmAwIRYcRalTMDdoCiwGXNupwLv2rq8+wlR5BbOTzbBQtLulJ8V/PwZoBYqjqYoFnfVyeXWRCSSmdda8Dpj9U1k6ziz8WliTEK+LZ2jwntieN2qG8fOWcohNVr766r18ojNCMKlkVJ0u2SCW2iSrSo2DBwz4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f7c96347-9a5a-4d25-844b-10de197b216d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:1fe8ab84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b432946adb8011ee935d6952f98a51a9-20240306
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <flash.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1923841581; Wed, 06 Mar 2024 14:13:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 14:13:50 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 14:13:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7PLF9Oda+jUu4gNTGqFNvKHfGmmlTnYQfOyit+0NtcrOZT/jyheNoSmYTfCGPAGgnDXx7E9ZBh7GDsIcACz1mRM/LMbz6OXfWFdzvtslEg6rc0xkib0RNU3OOzb7K2Po+byYNg8qe7wPpE/ih/GCLA4RRT2NGQaGCav5E/QZ3dRJiP17Hi2FGYUjSbqlYLI2iizymf9FW+CtQfEJeABtiLnvRZ5xVpzuieai3edmvQdujxLkWHC5+jhbOpT4DU+7blILxGGOZLQguzypsr2Pp60FPQ5HSx6XhO+xvb22+OxSZQAgZbS9OPpHBJJmHtRUufsleypQPzdvT9oZyOJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r1EQFVq71yCgADMc+4LrCMAEsI8rmG38N765yiLeC0=;
 b=O8OgWVixdpl3+Z0HGKDRwxsw3FyDNPHjjCTYkcJEf0M+9SxcDhQdqV0Flo9fEBG661DiFI+ebCP5Pd4h8yl11D1afEBv93/FgBUdX98BuuTlSXiMY4bAStJObzVs9RVoLbuD23uvIL2GrK3Pw74PdAv9vp7qM47fxIMN/8xgr1BaakzZQ2hoQo8p5Iu0ATI4CFbn85nhz3B0YMRs3PIi6Oqfoq6GNjgemmHhwAIwsAMwsAHGUZQxKwVnvmOtt92TygSSOnIcz0PlTPrpe4FL1UQWffm6bFqMXPTTWAYC089KduZIMRlRwgbM1hf6C22fcCs3oZRx0vy2Th9HU4PvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r1EQFVq71yCgADMc+4LrCMAEsI8rmG38N765yiLeC0=;
 b=pcV6o3XyAJdJmq2CHxUvRElaa9zwBROHKKC15WtxVipt/48tUETqrV/Rd5HbIquiwldsyjzfbvT88DklkjkOqfpXIimj+gBfF2V6CT/gQlHGOSCAcmCokk0k9oUh6Xo65G9VihURX9gMGNJDO7BgsKzzWiSVzaQsa507XhZyytg=
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com (2603:1096:4:1d4::14)
 by TYZPR03MB6421.apcprd03.prod.outlook.com (2603:1096:400:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Wed, 6 Mar
 2024 06:13:48 +0000
Received: from SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::9a30:9de4:c31d:2bae]) by SG2PR03MB7279.apcprd03.prod.outlook.com
 ([fe80::9a30:9de4:c31d:2bae%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 06:13:48 +0000
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
Thread-Index: AQHaVPVIVsXO+7KbOka+qKoEb18oerD24yEAgAAb7gCAM3HsgA==
Date: Wed, 6 Mar 2024 06:13:48 +0000
Message-ID: <56e1b2f5adbca437a14b738e1c58a054f6302fcd.camel@mediatek.com>
References: <20240201095754.25374-1-flash.liu@mediatek.com>
	 <ZbzKckIhn8HQv5pW@pluto>
	 <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
In-Reply-To: <053cb4a2edfe576412942daed2f7055b2ba9e207.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB7279:EE_|TYZPR03MB6421:EE_
x-ms-office365-filtering-correlation-id: 61831c3f-c881-46db-9792-08dc3da49656
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37DfzB1BJa1GWM0c8n6fw6zEfuWZz6ClIGcNd1DrSjQUf1CrnftpsHBT2RnBwzKKTzONC1zvPcbTYtRcrgKHDUuy3qTViHeranBhSSv5fWBWlBYyC4/BLnKaAqJEG2xb/EH+VE+0jSnYbZKDUEyD/fHg3bzD1WLFUax4PG6szfsWqnZzfirvoFnHq4ZNvgVLU3O0Z3ObXlNa0A//EIzaXldPz6xRD/9kPtseX3+j4bmpxK+XyUuIYz6KNctBAQ9WBGFEfM9tOuGeplFFW+lS1TPAnd/g3bplUlm+QJo27wsDIGWriexordHQXNcUxWoWDNQJu8JQaljxgjh0XdAH3UtWj8O774N/aiqf6I3q+qalwkIs0xh6mPyd0C7Bg+xuKJDCeDGyYPzWyxR1va9vAXxlzCTgoqj2cvNRbTOu+kM3rrgozEY+zc1bPSJctmEzuW2sDBHjsJ7KBWejixuQKoPSL9oWUrq00SGQcssjfWBxM0KUn2lnLRDnNRISmK38uR6tl4brfvOgeY5dnTMXau7RDrd9la+kKqpsB8z0DYKdOVeaUQ4LD8ddYi4sJloyO5Vq1Eq1SM7RuhdqI1tgm0wkS2SXJ76W032gqqwdaMQrj/0lzUmGN7L+qQXOBbxrJTkdfxSajaug3HVKxDdrQGlmBxX3rxXzaeYy2MR1fAeCxGfUTjzLFJTzUt5kg0ZFQ4G9ulugnTzoAo08nc1+LGPci33Ho9/wjT5Ybzs4iGY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB7279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEZadG8vYmZZa1BUN2J3eEoxb0VpM1JNUlBCckpWdlZRR2lsN21EbjVsemRM?=
 =?utf-8?B?YnhDOEdpNVB6R09ESVlpWXRZSFRqU0lYQTRoZ2xzM1MxSjVCNUZaNnRHV2VH?=
 =?utf-8?B?b3pRbGZnY2FTS3NRZU1rMCtqUS9GN0pCMkFWSzlRMDVVdUhUQ3RQK2lYVThY?=
 =?utf-8?B?bm1Xc01RK3NIRTljNVhBenVKdm4wNFhua2YvcVk3V2s1SnBqU2twSHRpUWFh?=
 =?utf-8?B?UFgwajZXeFFqa3I5MnNHcTVJWHFKRUdrcXdBTHROanp4bk5YclRLYkJvRXJJ?=
 =?utf-8?B?SHVQOVN2S1dqZjFMdUgrUE11UndpSDRQcXEyT0NpaVZMbXc2T29sK2EySVhK?=
 =?utf-8?B?Q1YvTjNmemIvQVNLL2l2aElUNWQxU1hVTGtwRDVOS0VrUXMzckcxL0FhYncy?=
 =?utf-8?B?SnZBRWE3cFlWQ0w1UU9WWlZuMEFWRCswOEZXYk81NHo5RDk5UHBRNjVIYWV5?=
 =?utf-8?B?V2o0MEFIZ2hzSnRzV3hDRWpwZCtub3h1L1kwRnhTTFlJSndGQi8wc1NDcnls?=
 =?utf-8?B?TGFaZzVubmFkeWlRMjZBM0k0Qi9EeGlGUVN1YzQ4SDNPYkh5V0liNmtJcVN6?=
 =?utf-8?B?L3BxWWtwVEhDL0l6OFVjTytoWFVqWHgwdzdGT3BLTzA0S2g0eG5Rc2FMWldo?=
 =?utf-8?B?NDZDbENkakEyVkxyTkJvTHUvRVJmcy9jWG4zeUdJaTZrNEh4bGozcFVSQXdE?=
 =?utf-8?B?YU5uT0FKL21OM2NzNzd6ejJUR1MrZ2ZacXZSL1JxZytvaUdNWmZ0VWlNT2Yr?=
 =?utf-8?B?ODBrUGVhTkdWUXM2VnEzbjFFa3BSQmc4UlVSKzRxWnpTVUtmRHkyWUN0THo2?=
 =?utf-8?B?aC9vNncyaFVqS0FEejNjbmtLck9MWkpLakJOeUt1ZlAzajcrMjBram5JSEdY?=
 =?utf-8?B?YjY0TU9OMjRmL0MzL0wxYWswOUt2Q2RoRjhtaHBOZWZJdnBxK2crOCswQzYr?=
 =?utf-8?B?Z2IyamlsbEdCd1FsSHZib3hPcHFsZUprK0R6UHM5SDRhV0Z1alVYM200dFBQ?=
 =?utf-8?B?aG5FQ2wwWTk1Y2hJVFZ4UkF2amkvd3pKdGw1S2dObVl6bmVvTzRrZ1NnNDVx?=
 =?utf-8?B?emxhcmNFMHRIR3E5azFPSk11S3FFNkxtZmJYaEVvN283ZlR4UFdzSUxZYnFx?=
 =?utf-8?B?blV5U1J1THhhTWdpL1lIS0g5bE1UTXVpTy9xRk83MzZVMkFaUjRTV3Y0Mllo?=
 =?utf-8?B?VU5rRXc3V3FxM2ZyR3hZaGNHaVdHWVhUbmNFTGErc2wyOTkrNHR2dUhzOUNR?=
 =?utf-8?B?TWRPUGUzbzNxbk1BQmxlOUN1aXNlVG1ucmxta2hKeUdzdFBkM2I5dkIvd1Vq?=
 =?utf-8?B?MU5kS29ETEloZkNKWkdJSC80WXVCSjhMN0MvMTEzNXpDaE1mV3hvVHV3dkE2?=
 =?utf-8?B?OXp5dnFiMy8xNURhZUg2L1F1aTNNc2VEcWY4NWZzNVhFZDl6TVBCNUdXWmYr?=
 =?utf-8?B?Mm1lc0RqVzlEK2VHMVZ3cnhYMzNqU1c5cFArVDBnWFROek4xQkthcU5zVHFl?=
 =?utf-8?B?cTcrSWxPWDBsWWg4WjNObkx6bkxtVjdVRlBhNms2SHM3SEtoRWV2M3FCWGVr?=
 =?utf-8?B?aEtJdWE0dlBJQ3FPZkpCMDFRTXlRQzdYMTVZV3g2M2VIbHB0N09QQ1BEWlJl?=
 =?utf-8?B?YWVjQkpySFNLd3FZelpKc0ROOUkxSmtzZVZKMFBKN3FHaTQxak1zUFlCUml0?=
 =?utf-8?B?Z3A3Q2RJdHc5Qms1WFNGTjY3S3RWdC9DbnM3NXNpUUNMdFR0VmQ3TE5jY0VT?=
 =?utf-8?B?a1RBZXlzSzY5c2RjS3cvR1lEMGFZL0E5NFFqRWtScW5HSWZraS93ZDZRWjNv?=
 =?utf-8?B?dThEQjVydmJXWDBzbUlvcGZwZC9INzB4b282cTlCRUNMUWRYRDVXQ2dkeHRl?=
 =?utf-8?B?aEZqMUQrZHRRbkNWcHdCTWhhSStIemVJZ1MrZTVXMFlYYTUrY3RYNkxCeTBr?=
 =?utf-8?B?NzgrSG9MS1NSazJWZ0NUV0c5aWo3dFlhUEc5SE9WbUpvWGlNN0djbnJnZ05T?=
 =?utf-8?B?WVJpZXIwR1IxdllIK3NIRktneDFCTXlJWm5KUEJiMVNHd1JWWlFxTGtIZVFh?=
 =?utf-8?B?WnJpYkovUkdxbXJwTDVyRVJSTXNiWEV4SHdyUXRSVEhyVldkNkJCUUhLUDR2?=
 =?utf-8?B?Ymk3dk1tZ2FyTEZEUDhaRGdIRHFnWGMzaVlaMFVIOWdJc2t0TllmMng0Lysz?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C2EDCBB01E01B44BB44E632BC2EA12B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB7279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61831c3f-c881-46db-9792-08dc3da49656
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:13:48.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QZChHwemw1k5FDgmdW+wpfSQIUv86yDXeIsuKDOae3Ixj+s4gWbbJUIKXYS7L3GoL6ae+Bi51xYxWczKavHUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6421
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.887500-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4lIwtTtvyT1CEtdrY/Wb3fOexfb7PJMB4/CW
	RBMIiZDW1Fc61VCGvh1+bI1Hl8sHV+D2Gw854pMrF6z9HGHKwNu+JGWINXafLE1KG1YrOQW/MwR
	yrAxy6J+RKof4pz0GQm9yZj3aufb5Qv21zJNl0CyDGx/OQ1GV8qffT5A0am5mZsCGLUmGln7kwj
	HXXC/4I8prJP8FBOIapAOLCM9z3owd2TSl+s/BiT9QhduzuLecUbzbsj1y5Sb86Nbt8bRf81r/V
	RGx0IR2+Uo4vXq+qmzIizeCsI6wA0LUmjyL3DZSqHzcKNbZb2s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.887500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	27FD298076FC52448E345A30CF0C51435586DB5566F394A1390D750E3B62B9A12000:8

SGkgQ3Jpc3RpYW4sDQoNCktpbmRseSBwaW5nIDopDQoNClRoYW5rcy4NClBpbi1DaHVhbg0KDQpP
biBGcmksIDIwMjQtMDItMDIgYXQgMjA6MzYgKzA4MDAsIFBpbi1DaHVhbiBMaXUgd3JvdGU6DQo+
IEhpIENyaXN0aWFuLCANCj4gDQo+IFRoYW5rcyBmb3Iga2luZGx5IHJldmlldyBhbmQgZXhwbGFp
bnMuIFllYWgsIEkgaGF2ZSBldmVyIHRyaWVkDQo+IGFub3RoZXINCj4gd2F5IHRvIHNraXAgdGhl
IGNhbGwgKGkuZS4gbGV0IG1hcmtfdHhkb25lIGJlIG51bGwpLiBIb3dldmVyLCBpdA0KPiBsb29r
cw0KPiBub3QgZWFzeSBhbmQgYWxzbyB0byBiYWNrcG9ydC4NCj4gDQo+IEF3YWl0aW5nIHlvdXIg
dGVzdCByZXN1bHRzIGFuZCBmdXJ0aGVyIHN1Z2dlc3Rpb25zLCB0aGFua3MuDQo+IA0KPiBSZWdh
cmRzLA0KPiBQaW4tQ2h1YW4NCj4gDQo=

