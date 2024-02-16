Return-Path: <linux-kernel+bounces-67972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E98573C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937C1285578
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D26DF78;
	Fri, 16 Feb 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xnnrgnpt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WTehXM4G"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E2CA64
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049879; cv=fail; b=FjlQil5N52Kr8FVKEexMw7vyI8R7JI+QZdwY1S9CzwK5wWLEZtUq4WMzfIDEYXuplVERIBJ9b6ulGfVrAM2X7PDnk+HenUXOIDoK/isDACjnKtufHqv2jSELqbd0LP2Cq9yzYJNZRamLl8QtNZm5K4SopKWYRE63V8J1HfUrRMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049879; c=relaxed/simple;
	bh=Q3zqRSbGL88ZQAKnAWGaNm4JCUNopPk+KLDFLz4MXWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njUReOiTeoaDh2AkqTn1unm3evgSBxfCOIDf80Bfi30V6IA5v7jRu/msBSegl+LAq/I8TIfa0M1bmqS9fdWOod/xv0gdiN3P5GrKI2ngTJRGmRVKqzJRNx7qHlUhH8qfverYR/WT22SqWDlClzg5ukOWuI3dcU4Mq+Yo+EOTM0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Xnnrgnpt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WTehXM4G; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9699e6c4cc7111ee9e680517dc993faa-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q3zqRSbGL88ZQAKnAWGaNm4JCUNopPk+KLDFLz4MXWg=;
	b=XnnrgnptWDllnDcN1DxQxYl73+MjRnaqOy4IW7MKYvA64zkx8Y0Bo2uURc8vEdlPVsHcyd7LYkjphFR1NI8EnInR/tr+Iqnod8SWClPDFAji2cA8EhTa0kPGePuxohRVDzgWy0I3L5s8XsMRfvMHl9wKeWbxUyvv5mHvSGiArm4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:66c09763-2258-4c68-b299-f44089996bf1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b8fc7080-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9699e6c4cc7111ee9e680517dc993faa-20240216
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1628225964; Fri, 16 Feb 2024 10:17:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 10:17:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 10:17:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVbIvsQ5sT57QnRDeIk9TtKE8Wb9k8I4xOhxKkF02nbZTH+72IO9meOB+UNX5iJcdd27GI+q+Rr8NZ4VVRRW2m2J9v23UA4nKtNUiWU5beToN3TJ3rtl5D5cwMwaX7tqJ15um0DDPgqUO8x8KnowBkph4r4iS9LVTae15IB+15naY3n9fJ4NyV1VkPWle4BB9TTT5br9Y/v23jwcYIlUUK8WEYmRB2NbHQOV1Hxq6W8pVKVg17AW4gXSNpKzpPdUz+/HnwOpUTK/cdfVqr/5BQ/AiyqwP0QOTKbCfsCs7De7XlnZ7yrCTJDDkplaLQhU8Pt1gOCAjQpmR2r4j6S17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3zqRSbGL88ZQAKnAWGaNm4JCUNopPk+KLDFLz4MXWg=;
 b=N/QhVD4Ekz45SDce0f2kUWZ4/gEw7Bo79vaENX2KyNOH28A1WkveVoNTzOe/pOOPAQO4G6rz9Me9h6PAieUhE6Fv47usMdo04ZHPqFCYkbE09DzIeEXtEWcRhiPu0OiSNe/oAUSZ4GFqLfk55I1Bmff/x3N8b5RWWLYgCXUz0p5kswWESnu0mXVevjuaXQeiMEQPJOsgWsdT8G1dS2T+ukUbwTn37kgjNBRooTCP/yuZiCy0iGSl8pvDK4DFyV1GBzV2A7q+r1x5auSajeM1zRinrvpFM7h7XTy4rzErYsJim1P0mKnBaFh6ctrw3U7O0op0xmflGfGaVk3Zus/AnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3zqRSbGL88ZQAKnAWGaNm4JCUNopPk+KLDFLz4MXWg=;
 b=WTehXM4Gpu0FqtBm/U+cb2tUoP0iWuUuB+zZucPNJxk1RlsD16iHlnBWnIIFD/lZ/Svmn/90HygLEZFQgm7DndcW5/iEnJaxWhh8it54MKh1/2cKkfwjWOSE1akKBt80kun0vg7DnVecymYzvH0FsBtvG/A6eFnkInYA2RwVWwQ=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SG2PR03MB6729.apcprd03.prod.outlook.com (2603:1096:4:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 02:17:49 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 02:17:49 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v5 08/13] drm/mediatek: Support alpha blending in OVL
Thread-Topic: [PATCH v5 08/13] drm/mediatek: Support alpha blending in OVL
Thread-Index: AQHaX/dwe9hdcqVJEEqYchVXw9Rxv7ELPPcAgAD/xQA=
Date: Fri, 16 Feb 2024 02:17:48 +0000
Message-ID: <111ddf7030051aa71d1283bd2eb4f23718eb8a9c.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-9-shawn.sung@mediatek.com>
	 <7664fece-c29a-4374-a59c-4ce8fe831494@collabora.com>
In-Reply-To: <7664fece-c29a-4374-a59c-4ce8fe831494@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SG2PR03MB6729:EE_
x-ms-office365-filtering-correlation-id: c4a395cf-9d2b-475b-387a-08dc2e9578bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2u3DmtvOr8E+RPJwpt+0cgBNddl3KEX6JafTJqiB1np7+DARroIiVEhcSAXwOlg/IC30Ia437b2W0CzCjjwe2mhQAtt3tKnVBTzoZqxyaAWrjG3DMUKEK3DGwm6PbUAdRLPYwNZbypgSMMHOTju86MAusSG0uanxqxJ+nsc2ZtKj83AOyYA1Q62BXOUdco3mrTtr13M/FLr7JFMhc+UxuYx+2eOSu20Wo6P17bjDND0PMDTr4Y6Yynz/KYt+74iFkixAQ+Y1uT57etlxX6SB84wk6lSqmULPjMonoEt4lK2167VhETW0zMswZl3j7Eaj9EwLDK6q2q0IzqgpdNalOaQkMzpu6R0Lz77Ps+oZmyqC3CILB+3f4TSBXXD58qVok4o0aDqptDD2GECrq5XHvPqCxD4dK6op8vIh4NIzkzVLATMqupU5oeB4sVaNxuZmQXQdN3rIcChJFCgLjga/8R/zIh8dSoNehSsD1p/2IEiGbLL0CSQxW9RtWb2wriKglniGS+xNHdZqx/pzFCSFfPBpem/rx1cLrLZvpOFueZOnhMKiAR9z8yZEWaFA8krWeecN4IVsr/rT2no5yoYKfIZ3lufHpZLel2/z5QsNJmSh/vN4y641x9ZgI2DZysN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(66556008)(64756008)(66946007)(76116006)(8676002)(66476007)(66446008)(4326008)(7416002)(8936002)(2906002)(38100700002)(85182001)(36756003)(122000001)(86362001)(83380400001)(6512007)(38070700009)(110136005)(316002)(478600001)(54906003)(6486002)(6506007)(41300700001)(26005)(2616005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGFwMzhxaXNLK2dkTytCYkR4a0VFZlR2YXF5ZlVJVWF2U3JkVFYwUEhiYm9s?=
 =?utf-8?B?VmhpNlZzWSt1U3o0MEViNUhRemlQSEhtM0dDYm9SaWRPL1NYd0psUDNYTmtV?=
 =?utf-8?B?TnhGUFpCcVZaL3dPVWkxeXhWdTRHY1d6YlozaVd4dUZWaG9iQUxPVDIxUW54?=
 =?utf-8?B?azdwMjFScGk3Y0d3WUJ2UWRSU3ljeG1pOFo1MWhlWmJpT3dndmFyYWdubVBm?=
 =?utf-8?B?Z2tWTTd1RVhaRnQ5cVFHajNlYjRNZGd0dVJINUYvTzV5WHZZY29ROTBUaHp0?=
 =?utf-8?B?b01YKzJ0cDlnVENhZ3Fhd2JVMXZjWHdmcmdHM1JVOE1lSTlvL3dVRHpVM1c4?=
 =?utf-8?B?YS92NnU0V3NJR2VKR003dHRIRDJMZDAwc0c3ajBYVFBzQkVFWjBuNFpXUUIw?=
 =?utf-8?B?QnZtc1RYbE40Qm9CWnkzSUtCbFozK1VocERhS1dLOE9pRzYvYTFySVFYNnBa?=
 =?utf-8?B?NktKS3piTjFud1ZkUEd5OWdnODJMSzM1WWk2Vlo4R1F3QUJwS0VUeG9rL255?=
 =?utf-8?B?b2gwY2R5U0kwYWRVYVFmTGJyWWVuNjcxOGpNQ3hRazYwSGVSdjZtQlNxVW4z?=
 =?utf-8?B?Yzd4ZGlSemY1dmtBTjBJbFVzak5FTk41TWVMcVVtamtsVEZncUpZNWpIMFl6?=
 =?utf-8?B?REhFK1F4N0lURjZxRGJDYWFDcnFDR3dUbFg5NjRPSzlMWlJlVnA3bXNTTUo1?=
 =?utf-8?B?VFVTRnRxOWI5dHlubFI3cXNpNHFqb0pmTWxpNHVTd3poeURBTk8raFZmVThW?=
 =?utf-8?B?M24wWXp0VlErV1k4czkrR1l6bnVzbXRDZkhWNVYwMGNpSndjbzNWWnZoemFV?=
 =?utf-8?B?WFg0WVYxbmFQYU1rcU1HYmE3NEM0N0x5eEVUWk1FKzZCczl1YWI2ejRtc2dJ?=
 =?utf-8?B?YVgwUWRJa1Zvc2ROKzZ6Z1NKSlVSK0ZDZGc3SmJmSmZPdFRYbzcwR0hMSUF1?=
 =?utf-8?B?TmhSTlNydEVRclozZ01OanlGb0sxWHNpVDVONjR5YnJhOXNnMGZ0cFdZTHh1?=
 =?utf-8?B?Z1JUWG9vZ05UOTVwNWFlQTBjSk10YnFwaXN1dWI2VDI5d0thcTNhL2NVTXFk?=
 =?utf-8?B?SGdaQTEyMGRYRE8xRFExYUJPSFpFbXlQU0J1akpnMUlmNHpUNi9rQnUzL2o0?=
 =?utf-8?B?SmlPZnRxbmRqci90VGlpZWZmZUFwdHB2d2lackJlMVNlNEExK3VFNGpwS0Qy?=
 =?utf-8?B?REhMeFBJdnNKSjZYNFFVb1hlWWJDcXB5ZURnM0JYUHh3d2dha3ZzYjJibWNh?=
 =?utf-8?B?bGJEOHo5NzdQbldZUU85REFIUEJPaFFTYy9vRzd5OHhFazJzR3RoWU9ua00x?=
 =?utf-8?B?azhacFIwZ2Jxc0Z4WHhFMDhVQjJuU0lkcVZsdWRQRnY1RnZxU2VUV3ZnTVND?=
 =?utf-8?B?aTJybHZ4TUliUDA4WUtoYXJ5NE1QZmh0b1d4RDhxR01NcU9vMWhsYWlYa3Rn?=
 =?utf-8?B?c2tVVkpPdUJiNU9iSW5ncTFpQkdrTTJqWFo4S25TVnRUT2IzRVIveUpORnZK?=
 =?utf-8?B?ZnpjSWdLUGdMd2dPWDJxN0daa2t6YUwrdGNuL0d4OEhmUTBSU1RuOHdjTnYy?=
 =?utf-8?B?VmtDVDN5WE5adEpHWmU5Z1ZIdlQ3aVYyd3JEVTRMWUR1UmV1eHlPeFZlUWUx?=
 =?utf-8?B?RVVqU1U5WmN1L3JXSWZxVUxGMmdtOENmRDJVZDFRMW1rSkdrWWdNdWJiVExi?=
 =?utf-8?B?QTZha0RhVStucUFuSEZjR2dLcndhZXBPOWQ3OEJiTzI3QWVtSlkvM1QxQXFl?=
 =?utf-8?B?c1dZVk1oUlpZUWZPeUc1b1Q0TUgybWtrVndTS29EUU9rcll3OEZsNEgwOFAy?=
 =?utf-8?B?enFmNy9oU3NDd1kyaG01QnZTbDBTOW9EM2xoVC8rY0JwWXl5YzZqZUdXZXBh?=
 =?utf-8?B?SStJY2hLZHFRaDBCRFl1eXpHMkpMQXNWTnh0OXhrb3htQ3RnRVlSUVBkZitl?=
 =?utf-8?B?NnUvNVRUVGphQkVGS3d4WG9KMzNrb3JvQU1qVVBrZ1JvbGtMVUNyTUR1NHRE?=
 =?utf-8?B?bzRtMHRUSUd6a0NFQWRKdHFheFBUTlNQOWxVUVEzRXJYcWl5U0xsb0N5dytr?=
 =?utf-8?B?ZmtrNHdPT2ZSNjdjVUpOOHhsTzJHRm1aQXQvSVJZWlQxZmU3aWVydVh3b2cy?=
 =?utf-8?B?R0MrR2R5RmwrZ0dpNFJUNFE3VlpDUTh4ald5aHRlN2ZscWo1L2oyZjEzNkxO?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <291783745AD9E647B58C56D70C5E6C22@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a395cf-9d2b-475b-387a-08dc2e9578bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 02:17:48.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HQEi3uyhd/ur1G2JHsdy4PDoBHP8m1dhui8CDuNhCHasA8DixPpTza0nadVNqwBVA94JrI6EgsNEraLw/szyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6729
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.652700-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU/wt
	lOVHF2NRUmsNbSHn8eD5qR7J2CotBpz3nEP4SjjAbBu6+EIezdwxmlBLt0TR1rFRmrhHzmfvwSc
	2bbTUBMmjmrD+IUq29gG2ORx9Eyap5W9n1Vmnd4QdxBAG5/hkWwreImldQ5BDv8D7QPW2jo93Cp
	W7baJzYFfpQg84b6ItRtmamHCmvybSV+Xuk4c29rYUrknUqEL7QKuv8uQBDjp9WQH9y/pSXXLOJ
	Owcwkpm5HqxcSv17rhfDKKVLAxShRgHZ8655DOP0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.652700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D08287FE8943C1DC329152FC9BD12559857DD47B058327BF8F0CD43661BD39722000:8

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTI6MDIgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxNS8wMi8yNCAxMToxMSwgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IFN1cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBhbmQgIk5v
bmUiIGJsZW5kIG1vZGUgb24gTWVkaWFUZWsncyBjaGlwcy4NCj4gPiBCZWZvcmUgdGhpcyBwYXRj
aCwgb25seSB0aGUgIkNvdmVyYWdlIiBtb2RlIGlzIHN1cHBvcnRlZC4NCj4gPiANCj4gPiBQbGVh
c2UgcmVmZXIgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBjb21taXQNCj4gPiAiZHJtL21lZGlh
dGVrOiBTdXBwb3J0IGFscGhhIGJsZW5kaW5nIGluIGRpc3BsYXkgZHJpdmVyIg0KPiA+IGZvciBt
b3JlIGluZm9ybWF0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1
bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgODMNCj4gPiArKysrKysrKysrKysrKysrKysr
KystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9vdmwuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+ID4gaW5kZXggYzQyZmNlMzhhMzVlYi4uOThjOTg5ZmRkY2MwOCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtMzksNiArMzks
NyBAQA0KPiA+ICAgI2RlZmluZSBESVNQX1JFR19PVkxfUElUQ0hfTVNCKG4pCQkoMHgwMDQwICsg
MHgyMCAqIChuKSkNCj4gPiAgICNkZWZpbmUgT1ZMX1BJVENIX01TQl8yTkRfU1VCQlVGCQkJQklU
KDE2KQ0KPiA+ICAgI2RlZmluZSBESVNQX1JFR19PVkxfUElUQ0gobikJCQkoMHgwMDQ0ICsgMHgy
MA0KPiA+ICogKG4pKQ0KPiA+ICsjZGVmaW5lIE9WTF9DT05TVF9CTEVORAkJCQkJQklUKDI4KQ0K
PiA+ICAgI2RlZmluZSBESVNQX1JFR19PVkxfUkRNQV9DVFJMKG4pCQkoMHgwMGMwICsgMHgyMCAq
IChuKSkNCj4gPiAgICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JETUFfR01DKG4pCQkoMHgwMGM4ICsg
MHgyMCAqIChuKSkNCj4gPiAgICNkZWZpbmUgRElTUF9SRUdfT1ZMX0FERFJfTVQyNzAxCQkweDAw
NDANCj4gPiBAQCAtNTIsMTMgKzUzLDE2IEBADQo+ID4gICAjZGVmaW5lIEdNQ19USFJFU0hPTERf
SElHSAkoKDEgPDwgR01DX1RIUkVTSE9MRF9CSVRTKSAvIDQpDQo+ID4gICAjZGVmaW5lIEdNQ19U
SFJFU0hPTERfTE9XCSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gOCkNCj4gPiAgIA0KPiA+
ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX01BTglCSVQoMjMpDQo+ID4gICAjZGVmaW5lIE9WTF9D
T05fQllURV9TV0FQCUJJVCgyNCkNCj4gPiAtI2RlZmluZSBPVkxfQ09OX01UWF9ZVVZfVE9fUkdC
CSg2IDw8IDE2KQ0KPiA+ICsjZGVmaW5lIE9WTF9DT05fUkdCX1NXQVAJQklUKDI1KQ0KPiA+ICAg
I2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0IJKDEgPDwgMTIpDQo+ID4gICAjZGVmaW5lIE9WTF9D
T05fQ0xSRk1UX1JHQkE4ODg4CSgyIDw8IDEyKQ0KPiA+ICAgI2RlZmluZSBPVkxfQ09OX0NMUkZN
VF9BUkdCODg4OAkoMyA8PCAxMikNCj4gPiAgICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfVVlWWQko
NCA8PCAxMikNCj4gPiAgICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfWVVZVgkoNSA8PCAxMikNCj4g
PiArI2RlZmluZSBPVkxfQ09OX01UWF9ZVVZfVE9fUkdCCSg2IDw8IDE2KQ0KPiA+ICsjZGVmaW5l
IE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OAkoT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfA0KPiA+
IE9WTF9DT05fQ0xSRk1UX01BTikNCj4gPiAgICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCNTY1
KG92bCkJKChvdmwpLT5kYXRhLQ0KPiA+ID5mbXRfcmdiNTY1X2lzXzAgPyBcDQo+ID4gICAJCQkJ
CTAgOiBPVkxfQ09OX0NMUkZNVF9SR0IpDQo+ID4gICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JH
Qjg4OChvdmwpCSgob3ZsKS0+ZGF0YS0NCj4gPiA+Zm10X3JnYjU2NV9pc18wID8gXA0KPiA+IEBA
IC03Miw2ICs3NiwyMiBAQA0KPiA+ICAgI2RlZmluZQlPVkxfQ09OX1ZJUlRfRkxJUAlCSVQoOSkN
Cj4gPiAgICNkZWZpbmUJT1ZMX0NPTl9IT1JaX0ZMSVAJQklUKDEwKQ0KPiA+ICAgDQo+ID4gK3N0
YXRpYyBpbmxpbmUgYm9vbCBpc18xMGJpdF9yZ2IodTMyIGZtdCkNCj4gPiArew0KPiA+ICsJc3dp
dGNoIChmbXQpIHsNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMDoNCj4gPiArCWNh
c2UgRFJNX0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0JYMTAx
MDEwMjoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMjoNCj4gPiArCWNhc2UgRFJN
X0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9BQkdSMjEwMTAxMDoN
Cj4gPiArCWNhc2UgRFJNX0ZPUk1BVF9CR1JYMTAxMDEwMjoNCj4gPiArCWNhc2UgRFJNX0ZPUk1B
VF9CR1JBMTAxMDEwMjoNCj4gPiArCQlyZXR1cm4gdHJ1ZTsNCj4gPiArCX0NCj4gPiArCXJldHVy
biBmYWxzZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBjb25zdCB1MzIgbXQ4MTczX2Zv
cm1hdHNbXSA9IHsNCj4gPiAgIAlEUk1fRk9STUFUX1hSR0I4ODg4LA0KPiA+ICAgCURSTV9GT1JN
QVRfQVJHQjg4ODgsDQo+ID4gQEAgLTg5LDEyICsxMDksMjAgQEAgc3RhdGljIGNvbnN0IHUzMiBt
dDgxNzNfZm9ybWF0c1tdID0gew0KPiA+ICAgc3RhdGljIGNvbnN0IHUzMiBtdDgxOTVfZm9ybWF0
c1tdID0gew0KPiA+ICAgCURSTV9GT1JNQVRfWFJHQjg4ODgsDQo+ID4gICAJRFJNX0ZPUk1BVF9B
UkdCODg4OCwNCj4gPiArCURSTV9GT1JNQVRfWFJHQjIxMDEwMTAsDQo+ID4gICAJRFJNX0ZPUk1B
VF9BUkdCMjEwMTAxMCwNCj4gPiAgIAlEUk1fRk9STUFUX0JHUlg4ODg4LA0KPiA+ICAgCURSTV9G
T1JNQVRfQkdSQTg4ODgsDQo+ID4gKwlEUk1fRk9STUFUX0JHUlgxMDEwMTAyLA0KPiA+ICAgCURS
TV9GT1JNQVRfQkdSQTEwMTAxMDIsDQo+ID4gICAJRFJNX0ZPUk1BVF9BQkdSODg4OCwNCj4gPiAg
IAlEUk1fRk9STUFUX1hCR1I4ODg4LA0KPiA+ICsJRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMCwNCj4g
PiArCURSTV9GT1JNQVRfQUJHUjIxMDEwMTAsDQo+ID4gKwlEUk1fRk9STUFUX1JHQlg4ODg4LA0K
PiA+ICsJRFJNX0ZPUk1BVF9SR0JBODg4OCwNCj4gPiArCURSTV9GT1JNQVRfUkdCWDEwMTAxMDIs
DQo+ID4gKwlEUk1fRk9STUFUX1JHQkExMDEwMTAyLA0KPiA+ICAgCURSTV9GT1JNQVRfUkdCODg4
LA0KPiA+ICAgCURSTV9GT1JNQVRfQkdSODg4LA0KPiA+ICAgCURSTV9GT1JNQVRfUkdCNTY1LA0K
PiA+IEBAIC0yNTQsOSArMjgyLDcgQEAgc3RhdGljIHZvaWQgbXRrX292bF9zZXRfYml0X2RlcHRo
KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2LCBpbnQgaWR4LCB1MzIgZm9ybWF0LA0KPiA+ICAgCXJl
ZyA9IHJlYWRsKG92bC0+cmVncyArIERJU1BfUkVHX09WTF9DTFJGTVRfRVhUKTsNCj4gPiAgIAly
ZWcgJj0gfk9WTF9DT05fQ0xSRk1UX0JJVF9ERVBUSF9NQVNLKGlkeCk7DQo+ID4gICANCj4gPiAt
CWlmIChmb3JtYXQgPT0gRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMiB8fA0KPiA+IC0JICAgIGZvcm1h
dCA9PSBEUk1fRk9STUFUX0JHUkExMDEwMTAyIHx8DQo+ID4gLQkgICAgZm9ybWF0ID09IERSTV9G
T1JNQVRfQVJHQjIxMDEwMTApDQo+ID4gKwlpZiAoaXNfMTBiaXRfcmdiKGZvcm1hdCkpDQo+ID4g
ICAJCWJpdF9kZXB0aCA9IE9WTF9DT05fQ0xSRk1UXzEwX0JJVDsNCj4gPiAgIA0KPiA+ICAgCXJl
ZyB8PSBPVkxfQ09OX0NMUkZNVF9CSVRfREVQVEgoYml0X2RlcHRoLCBpZHgpOw0KPiA+IEBAIC0y
NzQsNyArMzAwLDEzIEBAIHZvaWQgbXRrX292bF9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0K
PiA+IHVuc2lnbmVkIGludCB3LA0KPiA+ICAgCWlmICh3ICE9IDAgJiYgaCAhPSAwKQ0KPiA+ICAg
CQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAmb3ZsLQ0KPiA+
ID5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+ICAgCQkJCSAgICAgIERJU1BfUkVHX09WTF9ST0lf
U0laRSk7DQo+ID4gLQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIDB4MCwgJm92bC0+
Y21kcV9yZWcsIG92bC0+cmVncywgDQo+ID4gRElTUF9SRUdfT1ZMX1JPSV9CR0NMUik7DQo+ID4g
Kw0KPiA+ICsJLyoNCj4gPiArCSAqIFRoZSBiYWNrZ3JvdW5kIGNvbG9yIHNob3VsZCBiZSBvcGFx
dWUgYmxhY2sgKEFSR0IpLA0KPiA+ICsJICogb3RoZXJ3aXNlIHRoZXJlIHdpbGwgYmUgbm8gZWZm
ZWN0IHdpdGggYWxwaGEgYmxlbmQNCj4gPiArCSAqLw0KPiA+ICsJbXRrX2RkcF93cml0ZV9yZWxh
eGVkKGNtZHFfcGt0LCAweGZmMDAwMDAwLCAmb3ZsLT5jbWRxX3JlZywNCj4gPiArCQkJICAgICAg
b3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gDQo+IE11bHRpcGxlIChhbGwg
b2Y/KSBPVkwgY29sb3IgcmVnaXN0ZXJzLCBsaWtle0wwLTMsRUwwLQ0KPiAyfV9ZVVYxQklUX0NP
TE9SKHgpLA0KPiBST0lfQkdDTFIsIEx7MC0zfV9DTFIgYW5kIG90aGVycyBkbyBmb2xsb3cgdGhp
cyBleGFjdCBsYXlvdXQ6DQo+IA0KPiAjZGVmaW5lIE9WTF9DT0xPUl9BTFBIQQkJCQlHRU5NQVNL
KDMxLCAyNCkNCj4gI2RlZmluZSBPVkxfQ09MT1JfR1JFRU4JCQkJR0VOTUFTSygyMywgMTYpDQo+
ICNkZWZpbmUgT1ZMX0NPTE9SX1JFRAkJCQlHRU5NQVNLKDE1LCA4KQ0KPiAjZGVmaW5lIE9WTF9D
T0xPUl9CTFVFCQkJCUdFTk1BU0soNywgMCkNCj4gDQo+IC4uLnNvIHdlIGNhbiBkZWZpbmUgdGhv
c2UgYXMgdGhleSdyZSB2YWxpZCBmb3IgbXVsdGlwbGUgcmVnaXN0ZXJzLA0KPiBhbmQgdGhlbg0K
PiB3ZSBjYW4gdXNlIHRoZSBkZWZpbml0aW9uIGluc3RlYWQgb2YgYW4gYXBwYXJlbnRseSByYW5k
b20gdmFsdWUuDQoNCkdvdCBpdC4gV2lsbCBtb2RpZnkgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KPiANCj4gLyoNCj4gICAqIFRoZSBiYWNrZ3JvdW5kIGNvbG9yIHNob3VsZCBiZSBvcGFxdWUg
YmxhY2sgKEFSR0IpLA0KPiAgICogb3RoZXJ3aXNlIHRoZXJlIHdpbGwgYmUgbm8gZWZmZWN0IHdp
dGggYWxwaGEgYmxlbmQNCj4gICAqLw0KPiBtdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3Qs
IE9WTF9DT0xPUl9BTFBIQSwgJm92bC0+Y21kcV9yZWcsDQo+IAkJICAgICAgb3ZsLT5yZWdzLCBE
SVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gDQo+IEV2ZXJ5dGhpbmcgZWxzZSBsb29rcyBvay4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg0KVGhhbmtzLA0KU2hhd24NCg==

