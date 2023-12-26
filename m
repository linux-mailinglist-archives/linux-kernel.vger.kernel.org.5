Return-Path: <linux-kernel+bounces-11349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4646C81E4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635F61C21C43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BBB4B144;
	Tue, 26 Dec 2023 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rP4nuqa1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ejJkXv4q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCE4AF92;
	Tue, 26 Dec 2023 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b187d5d2a3ad11eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b8k1pxU27riCYCo9sIo0+ryP11VzqI0XGiUN7LZ/31g=;
	b=rP4nuqa1b4DPACzksdItzuXXJl22IYc3SwtlVAp/PWfjTwUKiqyh64R+IiMEQ4Ak1XlJezHGZyJh8EeLxIL2IgUUOnDypKu8IvJx0kvghovaOUbn+EJ4qZGFG09StHW3wegewCXRdfuEy8LD+1JbbEEGhcODe2PUj0gddHjr9SI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:26ebc32b-a19f-48a3-8a4d-27a251289d38,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ae8fab7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b187d5d2a3ad11eea5db2bebc7c28f94-20231226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 97844169; Tue, 26 Dec 2023 13:14:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 13:14:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 13:14:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM2b4pBUE2JfRy/x04Ia7cpIaaUpKY6yxTZ19NA74u6ZNvodY3hOQ3OcJ/r/ABGyGcRtreblLNzBIfn11i2kTXJFaB4646zqvVQ8dvIkZ7OyCADskC8co7r0J6G/RjB2Yk/8fbIop3X0mpi5Qc4gmMM1hfSn5cr4CBbmuH/2J4DU5slzecCRhVkYCmRZIt4GGmW89oRQdLUwSnJFQ6N5cet245IU3tEDWkJ15WC96pATo+eUUAk+RA94s8Z6/K1EHi7W4Hptv1K7SSuiC1K2mVj/qhJVVxJvxudBtZDdW9hgJXXnfBW0fLd5HUEQG51JLozc6t7I3ItxHdV6cDGTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8k1pxU27riCYCo9sIo0+ryP11VzqI0XGiUN7LZ/31g=;
 b=m6sQNyXleH/OMedFknfoLCQ61AXQ8lR8HqWvOqTQN1Q1RXLvBkdf26URex1jxDyfQ0Srwisk4EdrONM/DvT7t3a3W++20Yb+86hNrWxiW1TMNThSo+J7RMzrR8hG3319gpZVQPiXQSTpoLjoNt3sxJjJwe1fbMB+S2DlUvaSTXV42jA2+ANbGe+m8c7c/xJW0xfSseuyEMD9gQArcQ55uP+kdV0AiVqbYteZV+jCqGMncy3/cd+hoR9ZOk0YM2OXBq5nvBhQeg5Waz47xwnRiJNRbVzON32jpeBulXcJC/BzRzr/qQZMVa24Z6Xw5AHAEklB/aPUdH9ZKjPmfDz3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8k1pxU27riCYCo9sIo0+ryP11VzqI0XGiUN7LZ/31g=;
 b=ejJkXv4q021k0B+W3l52zoLF6Wy+jLvKgklr2Qjq9gy4Jwgk7MjgZtXjltSSQrxbdowqUcfVCt55Mf9hCCL3+XPDdE5x+R7Rxs6dhkAvIR8/9pNA52nYJGoOrDPVatNvMSPD/rgsBYqAt1DGkC6W6fuiTgq4RC3aMklcV3X3xv8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8840.apcprd03.prod.outlook.com (2603:1096:405:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 05:14:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 05:14:45 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?=
	<Johnson.Wang@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v3 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaNc4pQKIbh8mpQ0qI37BfG8I1ybC7CUMA
Date: Tue, 26 Dec 2023 05:14:45 +0000
Message-ID: <eb8fa56d4dfa78f84d32fd7c9e271186d13f4ade.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20231223182932.27683-8-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8840:EE_
x-ms-office365-filtering-correlation-id: c21c4fbe-45b6-4546-2c1d-08dc05d1934e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+u9h+BWPvBoymoEheNAOcKnvwiV4b3I9pZXVdOKpm/Yl6v/dnfQe3tBY5vMVUIKa0hsQVDOmGR6MWNuPBkMqelsHYJlHhbC8UwE4/T5LGMi5rPLo4QfNTKF0NmW/FE5+5JDgfaumHbNIqgdJPtA8P9CMHluoDXsmAkwxlz05ZvVlu0q0fCHUBzk17LIuOZ4UDf+kzOfmZHOmb3pCNYpFAsXTijKMQkPVA0EDOEpg7E9AGlqJF/Rn0CI0Wu34yRfKh+3J86PR9K5Yu+w6Fi+n6rXPfjDoEAFdAiR6Rj/1nlH0Hbii0yMaarpZukEATSYt9FPA9T0Ct8GHM2Xn8qJLfqfEHIeC9Acmz+87LdHuM4xcyl5fDdmiymd67QSDwcJHXc8EZqgILdJiLurxXclBsSq9tU+Z3snkHZc12yp/fJmn2xxiYEzWsgT/LkNGFXZKM8jMc6weh+hXoZFwbTUVAXmXMRh4SHIA2H2UnkTInM2g6GYBij9khdnEuYVKAnmQ4LCywlqYvA32kunWb4/iq/DV9zWhMcay84GNtsAGJWweiMgIpdXgvDKtPSTpgD1Z2WZzcPuaDpS/002hSTSwAwl83tL14T1R4ENBB3x+xtW842dPhc51GGHq/TLxRC6/FWof8QbliBlJocKwZJ3QQFkQdTDm1npiD2j5zmxfdU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(110136005)(6512007)(6506007)(6486002)(38100700002)(122000001)(76116006)(66476007)(66946007)(66556008)(2616005)(316002)(66446008)(64756008)(54906003)(71200400001)(478600001)(86362001)(8936002)(8676002)(26005)(4326008)(5660300002)(7416002)(2906002)(36756003)(41300700001)(85182001)(38070700009)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWpaeFh4dkZ1dnVFL2pRWTA1b2VuRDJoTXpLekFDMU9wbXNEY0pNN2ZGZUxp?=
 =?utf-8?B?S0NGV1g2RnE2UmZpam56VEFnelV5bmVxTzk5Z0RKVWRLUUxyeUVrNHg0UXdl?=
 =?utf-8?B?QzNyWTNXRGxxQW5LNEkzWHB0UjJoZktyaGRCU2FPUngyUUg1NUE4cGpYL1di?=
 =?utf-8?B?S3R1U0tBWkkyMXpuN3NWaldVMnhwbU1neU9UOURDcW83c2tOMk1BSmdzY1Fv?=
 =?utf-8?B?UDRJNVIxdHVXVEhpNXNHaGpLUDF4dGV3UWM3QVVHNkJrZ0Z4TTJtOFFqOUc4?=
 =?utf-8?B?YkpPVmxRR0tMZTdyRnlkck8xdXVaZW44aGE5cVFQNU45ZjVoaHJ0bFVBWjFU?=
 =?utf-8?B?QnUwNm5TdmFOMlA3OHErdy9nQ05WcEJUU1RiRWlNUUlmN1BiZ2FhTjRKcU01?=
 =?utf-8?B?UUhHNVlGOXBnMXJVeEoxUGw5NFZ2QktYckpYQmt4TXZoYzFySVZUMWthWmIv?=
 =?utf-8?B?TWpGUFVBVmluNDRhVU85NUk3WXg2cnZCOUVCMFhlTm1zWGZzYmxOTEZwbDdr?=
 =?utf-8?B?ZEdPSDZPTFhkK3BvaWY4U21TVmFSOU5yVnM2TzJ2eWNYV3N6T0VxZi9OQWE5?=
 =?utf-8?B?c0pOWnlFYmV2bTdqTjI1ZUpzWWd1L0FkSUJRSjl4TjJQWWNkR3FMNFJVRkJB?=
 =?utf-8?B?MFRia09zVjYzZ3p5YjZZUkZHcmQvMHFZdmVRdnZyejNwc0FFNXFkdjBmTWZX?=
 =?utf-8?B?aGxPelVwc3VlVUZRcWJPSVp4TTlFMFVrQnphVCtCMUxqS3gxZkU4c2ZVbWRU?=
 =?utf-8?B?Nlg1cHRSS0lnSnNweC85SFhiNDBPOTFTZFptS1VweUhzRXhleCsvbllHdVhk?=
 =?utf-8?B?WU1wRmJ3a1dpbzhsSkxhYS8yaklGcXAzdTZxY1FqWXdXeDVCOUVUK09ZajFr?=
 =?utf-8?B?WHJZYWFmSWhhanZ6MnlBYzFFQXRtN2RTcmowWnJraE1UcGRiWTFjT2lrTjg2?=
 =?utf-8?B?UnMvL2gySUxUdTFZRVRLZ1lOVjJjbTA3em5JYXhlTVpSSlpCek5BQm10Nm9N?=
 =?utf-8?B?RFJhbDFDcGJRSlZmOWZtWDA5bTUreUlRcUEwK0tiWU5GSllnKzZSakJxOWFT?=
 =?utf-8?B?cEE3dXY0dWN2MzA2bjIyS01IV0VsWUFQaWlRQ1VybkE2RUJwTGxINVpEU2hr?=
 =?utf-8?B?ZUY0Zk5ET2Zoa3NzbTZhQTVrY0tEb3FjYkNTa0VXMEQyWEVheVB5KzFMdzJC?=
 =?utf-8?B?SHRFeTFHbFlLcERnY3lVUXBrVnBVVkFaVEVBalRjcWJhbWNZV1J2NjU2OVM3?=
 =?utf-8?B?a29kaVlCREE3dlI5QjlwTEZ4azFTQ3c4Nk15T3FsZjlkNkhSWlFIRFRVaTdQ?=
 =?utf-8?B?dWdCMzVpS2lhbVFVbzc5MFVFNTJ4dlg2NE5SU1NnOHluWWhWd0orOE5ab05o?=
 =?utf-8?B?TXlpaGJVQXdwdGdlWWdsbWE4WHdJakZ2UmRMd3BsM0lTZmEwMGZMWGtYOHMx?=
 =?utf-8?B?K2ZQK1hBd2JIM3ZkT0hYWnR4bllvTE5zb2lxT1p6YUkzcmdLSlZWMUtIVmFI?=
 =?utf-8?B?L09QUzN6MkFXNVQvQXk1MXBsZ3JkM0JoalV0bGIxL21JRVpKcHNGTVFMRTRC?=
 =?utf-8?B?SjRWZGU3RllwRmhndkhETlVRWk1MUUVLMlpFRXpiN3Y0aHZ0UzVWY2JWd3Yv?=
 =?utf-8?B?UHBQRFRUQkdVb3VqVUJtVHZrWGZJRWRMclZBYTlpejNKMC8zZG1xVUVPbUlI?=
 =?utf-8?B?V3dQN3hMaWlwSDBHOXNXMXh0bmR5czM2UWRiSVN1dE1ab2xZQ1Q1UWtNWHBF?=
 =?utf-8?B?bU94WUxZSElxZGJTenBSTUx6OTFmWFI1VkNtdnJlNjhBdE05RnRxM2s0ZUpl?=
 =?utf-8?B?cm9pbFVseTJQT0s0MzdSUi9hRjNabFp3d2FWUFpXTjZoc1FvUWZ2YWIyZUxF?=
 =?utf-8?B?c3I1a0FiUDAxNWJ2c3dLbUtjNEFIZ3g0aTRYS3FSNFhrRWxVUlJxZnJkSlZW?=
 =?utf-8?B?QnBTdTJvVXRNblNWaHphOHV3alZoZ3RxTjJoazc3K2ozSU9tQTliTVYyQXgx?=
 =?utf-8?B?VzJOVXdpQlFqblVaV09lVWxxYWZyWDhXYzJKbTRPTkJraGNlOUpVMnpSa2JR?=
 =?utf-8?B?OStkakZneVNTQkpaUk1raC9oc3RZQjZXY0tBQnhYN1lJa0ZYNDBRUDczRGlW?=
 =?utf-8?Q?ZbHfCa6yHRF9S7s7+Z7xYXovV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03F02B6B623298488058B82D53A8148D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c4fbe-45b6-4546-2c1d-08dc05d1934e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 05:14:45.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 72vsni/hmQTbNxZY/Myvs9dUBku5pF9BwI4tQVO+MqCfGOaLXMiZDb9V0IAH0F74IVpszfVxtraG9Bw7YW3xgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8840

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjMtMTItMjQgYXQgMDI6MjkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsLg0K
PiANCj4gVE9ETzoNCj4gMS4gTW92ZSBESVNQX1JFR19PVkxfU0VDVVJFIHNldHRpbmcgdG8gc2Vj
dXJlIHdvcmxkLg0KPiAyLiBDaGFuZ2UgdGhlIHBhcmFtZXRlciByZWdpc3RlciBhZGRyZXNzIGlu
IG10a19kZHBfc2VjX3dyaXRlKCkNCj4gICAgZnJvbSAidTMyIGFkZHIiIHRvICJzdHJ1Y3QgY21k
cV9jbGllbnRfcmVnICpjbWRxX3JlZyIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5M
aW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8ICAyICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgIHwgMzENCj4gKysrKysrKysrKysrKysrKysrKy0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMjkgKysr
KysrKysrKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9k
cnYuaA0KPiBpbmRleCAxMzExNTYyZDI1Y2MuLjc3MDU0YWRjZDljZiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAtOSw2ICs5LDcgQEANCj4gICNp
bmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlh
dGVrL210ay1tdXRleC5oPg0KPiArI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNp
bmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICAjaW5jbHVkZSAibXRrX21kcF9yZG1hLmgiDQo+
ICANCj4gQEAgLTgyLDYgKzgzLDcgQEAgdm9pZCBtdGtfb3ZsX2Nsa19kaXNhYmxlKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwg
dW5zaWduZWQgaW50IHcsDQo+ICAJCSAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZy
ZWZyZXNoLA0KPiAgCQkgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRx
X3BrdCk7DQo+ICt1NjQgbXRrX292bF9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAq
Y29tcCwgdW5zaWduZWQgaW50DQo+IGlkeCk7DQo+ICBpbnQgbXRrX292bF9sYXllcl9jaGVjayhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCQlzdHJ1Y3QgbXRrX3Bs
YW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1
Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggMmJmZmU0MjQ1NDY2Li5jMThmNzY0MTJhMmUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTQ2
LDYgKzQ2LDcgQEANCj4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0FERFIob3ZsLCBuKQkJKChvdmwp
LT5kYXRhLT5hZGRyICsNCj4gMHgyMCAqIChuKSkNCj4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0hE
Ul9BRERSKG92bCwgbikJCSgob3ZsKS0+ZGF0YS0NCj4gPmFkZHIgKyAweDIwICogKG4pICsgMHgw
NCkNCj4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0hEUl9QSVRDSChvdmwsIG4pCQkoKG92bCktPmRh
dGEtDQo+ID5hZGRyICsgMHgyMCAqIChuKSArIDB4MDgpDQo+ICsjZGVmaW5lIERJU1BfUkVHX09W
TF9TRUNVUkUJCQkweDBmYzANCj4gIA0KPiAgI2RlZmluZSBHTUNfVEhSRVNIT0xEX0JJVFMJMTYN
Cj4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMp
IC8gNCkNCj4gQEAgLTEyNiw4ICsxMjcsMTkgQEAgc3RydWN0IG10a19kaXNwX292bCB7DQo+ICAJ
Y29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhCSpkYXRhOw0KPiAgCXZvaWQJCQkJKCp2Ymxh
bmtfY2IpKHZvaWQgKmRhdGEpOw0KPiAgCXZvaWQJCQkJKnZibGFua19jYl9kYXRhOw0KPiArCXJl
c291cmNlX3NpemVfdAkJCXJlZ3NfcGE7DQo+ICB9Ow0KPiAgDQo+ICt1NjQgbXRrX292bF9nZXRf
c2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50DQo+IGlkeCkN
Cj4gK3sNCj4gKwlpZiAoY29tcC0+aWQgPT0gRERQX0NPTVBPTkVOVF9PVkwwKQ0KPiArCQlyZXR1
cm4gQklUX1VMTChDTURRX1NFQ19ESVNQX09WTDApOw0KPiArCWVsc2UgaWYgKGNvbXAtPmlkID09
IEREUF9DT01QT05FTlRfT1ZMMSkNCj4gKwkJcmV0dXJuIEJJVF9VTEwoQ01EUV9TRUNfRElTUF9P
VkwxKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaXJxcmV0dXJu
X3QgbXRrX2Rpc3Bfb3ZsX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpwcml2ID0gZGV2X2lkOw0KPiBAQCAtNDQ5LDggKzQ2
MSwyMiBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
dW5zaWduZWQgaW50IGlkeCwNCj4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9TUkNfU0laRShpZHgp
KTsNCj4gIAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG9mZnNldCwgJm92bC0+Y21k
cV9yZWcsIG92bC0NCj4gPnJlZ3MsDQo+ICAJCQkgICAgICBESVNQX1JFR19PVkxfT0ZGU0VUKGlk
eCkpOw0KPiAtCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgYWRkciwgJm92bC0+Y21k
cV9yZWcsIG92bC0NCj4gPnJlZ3MsDQo+IC0JCQkgICAgICBESVNQX1JFR19PVkxfQUREUihvdmws
IGlkeCkpOw0KPiArDQo+ICsJaWYgKHN0YXRlLT5wZW5kaW5nLmlzX3NlY3VyZSkgew0KPiArCQlj
b25zdCBzdHJ1Y3QgZHJtX2Zvcm1hdF9pbmZvICpmbXRfaW5mbyA9DQo+IGRybV9mb3JtYXRfaW5m
byhmbXQpOw0KPiArCQl1bnNpZ25lZCBpbnQgYnVmX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IC0g
MSkgKg0KPiBwZW5kaW5nLT5waXRjaCArDQo+ICsJCQkJCXBlbmRpbmctPndpZHRoICogZm10X2lu
Zm8tDQo+ID5jcHBbMF07DQo+ICsNCj4gKwkJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBC
SVQoaWR4KSwgJm92bC0+Y21kcV9yZWcsDQo+IG92bC0+cmVncywNCj4gKwkJCQkgICBESVNQX1JF
R19PVkxfU0VDVVJFLCBCSVQoaWR4KSk7DQo+ICsJCW10a19kZHBfc2VjX3dyaXRlKGNtZHFfcGt0
LCBvdmwtPnJlZ3NfcGEgKw0KPiBESVNQX1JFR19PVkxfQUREUihvdmwsIGlkeCksDQo+ICsJCQkJ
ICBwZW5kaW5nLT5hZGRyLCBDTURRX0lXQ19IXzJfTVZBLCAwLA0KPiBidWZfc2l6ZSwgMCk7DQoN
Ck1hcHBpbmcgaW92YSBzaG91bGQgYmUgZG9uZSB3aGVuIGJ1ZmZlciBhbGxvY2F0aW9uIG9yIHNv
bWUgb3RoZXINCm1hcHBpbmcgZnVuY3Rpb24sIGluc3RlYWQgb2YgZXZlcnkgT1ZMIGZyYW1lIGNv
bmZpZ3VyYXRpb24uIFNvIHRoZSBzaXplDQpzaG91bGQgbm90IGJlIHNldCBoZXJlLg0KDQpSZWdh
cmRzLA0KQ0sNCg0KPiArCX0gZWxzZSB7DQo+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3Br
dCwgMCwgJm92bC0+Y21kcV9yZWcsIG92bC0NCj4gPnJlZ3MsDQo+ICsJCQkJICAgRElTUF9SRUdf
T1ZMX1NFQ1VSRSwgQklUKGlkeCkpOw0KPiArCQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9w
a3QsIGFkZHIsICZvdmwtPmNtZHFfcmVnLA0KPiBvdmwtPnJlZ3MsDQo+ICsJCQkJICAgICAgRElT
UF9SRUdfT1ZMX0FERFIob3ZsLCBpZHgpKTsNCj4gKwl9DQo+ICANCj4gIAlpZiAoaXNfYWZiYykg
ew0KPiAgCQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGhkcl9hZGRyLCAmb3ZsLQ0K
PiA+Y21kcV9yZWcsIG92bC0+cmVncywNCj4gQEAgLTUyOSw2ICs1NTUsNyBAQCBzdGF0aWMgaW50
IG10a19kaXNwX292bF9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CX0NCj4gIA0KPiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNF
X01FTSwgMCk7DQo+ICsJcHJpdi0+cmVnc19wYSA9IHJlcy0+c3RhcnQ7DQo+ICAJcHJpdi0+cmVn
cyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+ICAJaWYgKElTX0VSUihwcml2
LT5yZWdzKSkgew0KPiAgCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBpb3JlbWFwIG92bFxuIik7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29t
cC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBp
bmRleCAzMDQ2YzA0MDkzNTMuLjZhZWQ3NjQ3ZGZjMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC0xMTEsNiArMTExLDM0IEBAIHZv
aWQgbXRrX2RkcF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdA0KPiAqY21kcV9wa3QsIHVuc2ln
bmVkIGludCB2YWx1ZSwNCj4gICNlbmRpZg0KPiAgfQ0KPiAgDQo+ICt2b2lkIG10a19kZHBfc2Vj
X3dyaXRlKHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QsIHUzMiBhZGRyLCB1NjQNCj4gYmFzZSwN
Cj4gKwkJICAgICAgIGNvbnN0IGVudW0gY21kcV9pd2NfYWRkcl9tZXRhZGF0YV90eXBlIHR5cGUs
DQo+ICsJCSAgICAgICBjb25zdCB1MzIgb2Zmc2V0LCBjb25zdCB1MzIgc2l6ZSwgY29uc3QgdTMy
DQo+IHBvcnQpDQo+ICt7DQo+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4g
KwlpZiAoIWNtZHFfcGt0KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKiBzZWN1cmUgYnVmZmVy
IHdpbGwgYmUgNEsgYWxpZ25tZW50ICovDQo+ICsJY21kcV9zZWNfcGt0X3dyaXRlKGNtZHFfcGt0
LCBhZGRyLCBiYXNlLCB0eXBlLA0KPiArCQkJICAgb2Zmc2V0LCBBTElHTihzaXplLCBQQUdFX1NJ
WkUpLCBwb3J0KTsNCj4gKyNlbmRpZg0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19kZHBfc2VjX3dy
aXRlKHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QsIHUzMiBhZGRyLCB1NjQNCj4gYmFzZSwNCj4g
KwkJICAgICAgIGNvbnN0IGVudW0gY21kcV9pd2NfYWRkcl9tZXRhZGF0YV90eXBlIHR5cGUsDQo+
ICsJCSAgICAgICBjb25zdCB1MzIgb2Zmc2V0LCBjb25zdCB1MzIgc2l6ZSwgY29uc3QgdTMyDQo+
IHBvcnQpDQo+ICt7DQo+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gKwlp
ZiAoIWNtZHFfcGt0KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKiBzZWN1cmUgYnVmZmVyIHdp
bGwgYmUgNEsgYWxpZ25tZW50ICovDQo+ICsJY21kcV9zZWNfcGt0X3dyaXRlKGNtZHFfcGt0LCBh
ZGRyLCBiYXNlLCB0eXBlLA0KPiArCQkJICAgb2Zmc2V0LCBBTElHTihzaXplLCBQQUdFX1NJWkUp
LCBwb3J0KTsNCj4gKyNlbmRpZg0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG10a19kZHBfY2xr
X2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kZHBfY29t
cF9kZXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gQEAgLTM2NSw2ICszOTMsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfb3ZsID0NCj4gew0K
PiAgCS5iZ2Nscl9pbl9vZmYgPSBtdGtfb3ZsX2JnY2xyX2luX29mZiwNCj4gIAkuZ2V0X2Zvcm1h
dHMgPSBtdGtfb3ZsX2dldF9mb3JtYXRzLA0KPiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3Zs
X2dldF9udW1fZm9ybWF0cywNCj4gKwkuZ2V0X3NlY19wb3J0ID0gbXRrX292bF9nZXRfc2VjX3Bv
cnQsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5j
cyBkZHBfcG9zdG1hc2sgPSB7DQo=

