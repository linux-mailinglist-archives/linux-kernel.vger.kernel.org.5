Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9083F762AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGZFpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGZFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:45:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC53DD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:45:09 -0700 (PDT)
X-UUID: 9282d5642b7711eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HAVJm19sX2cGUp57sHWM6md4/U5nyWZXty/F/5D9iM4=;
        b=Ks5/rMGAhNpCa9d8hxIG3dbYYw9e7Cqg5Z/BmpnXPDTUSWqmZgb/w8xoK16eelV5onMl0gbLNFHWfUP7oJBackIjW818eJayAYg7TA48W5L6gjk5q9bSXwduPfgxTE4Z1PHLlI0PZLrCV6YGsLhzOY+zebyWFhZuU0KqeUBWYao=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:fc5c5ca5-e715-40a7-8851-7be3c26c5066,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:fc5c5ca5-e715-40a7-8851-7be3c26c5066,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:504f8aa0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230726134506G8GZ2RZW,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_FAS
X-UUID: 9282d5642b7711eeb20a276fd37b9834-20230726
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1316559514; Wed, 26 Jul 2023 13:45:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 13:45:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 13:45:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMbq6bqJYG6nFz5qrsOywiJfbyg9kpZbnFweSt68wUFb2jRusA+KnUIE/dfjpGqCFgNXa61j+z00xp6IEv5BMfr+EqIhRf33/EHSHuNOIpSQDElKgNakQlJpjIsYVNmwmyYHbfhSz35iudHNRdqCFLYAVxMjVPwYA3LC9Sk3ZHOxPyzj+6S5eIXoQOo+ZGz/yXeXVPYZuoujak98bzl7/2iZYfyK6U0KXAZ7kuWXDqa5siauDcz93l7IFeWd5z6ce30jaEi6eA0b6YSsfgNCkoqfldNU817OAsBFISFGFBy6PYJjDeYPP+3WImOdkegKGcS+bYQpcA2xj6wUaNf0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAVJm19sX2cGUp57sHWM6md4/U5nyWZXty/F/5D9iM4=;
 b=VM6VsotVnMc89XkQTr9KT6Db1ILY8dCJIIV4Lll7zrvSynB2RbZEGEn598mg0ConBXSR/myrRbLrr/dOohxmYS6nyal70yBcEoKoXf2UaM6H7mkonESbqrX1B0H0PJXkVDkjgMy34AsQCK+W5AwG53xNiaP64/qgWnO7nKiflICfk3yM3CuoYyl+DkqE7AlGK11KVtOkJjGf9cUyc0cay0/BsZNLcJON6nuS2WwHcMPuWcAJwB2FrdNLiKfMmX2OOCVs3FZtbWX6oaRsqrRa5FyHj37F4jWOIcHf0GRITopwwp7kuqHsWObCTnTvIdtPIcDbV01DC3v0cW5cI4atYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAVJm19sX2cGUp57sHWM6md4/U5nyWZXty/F/5D9iM4=;
 b=GsqS5vuAUKsJrmlmkuCaXiuzagzYtSWhUMLLQeqWPSuneTSCI5JImIU7GZkQUd7e8WyemRgo2wwtcd036KR7+C1Wo/RcpvjhIy9u66HSTKhDch3IS+BEQTzXbYhBRvKVBxOG5CAGNBb9tc3OpR+W7Wos6jKyH0DDt+jYF5jsswI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7427.apcprd03.prod.outlook.com (2603:1096:400:40f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 05:45:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Wed, 26 Jul 2023
 05:45:02 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2 4/6] drm/mediatek: mtk_dpi: Switch to .remove_new()
 void callback
Thread-Topic: [PATCH v2 4/6] drm/mediatek: mtk_dpi: Switch to .remove_new()
 void callback
Thread-Index: AQHZuhXvQ+MOLIhUqUukVyRCFoQS86/LlHgA
Date:   Wed, 26 Jul 2023 05:45:02 +0000
Message-ID: <f2bf0c11449709369bfb9804ac124e7ff66281fc.camel@mediatek.com>
References: <20230719075056.72178-1-angelogioacchino.delregno@collabora.com>
         <20230719075056.72178-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230719075056.72178-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7427:EE_
x-ms-office365-filtering-correlation-id: 328d6563-0a52-42c1-a958-08db8d9b74fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RgZaJCpfN2yEs/9KEIoSDRQ98VOEFASIUrgt+y+gAuruSyMwTnHMLNjvOOVgsBN9rMF2ms5jaETOUiJRTRSg5+IIe3zZzh4Kp0MHSF9AXnfJOUzC2Vl/ADm74s4RYrM6oEloTl+Kawzb8HEVTXyDwB1aH+9j1RiyrFv7eHgv25ZVNfpNL9YjPI6ve8BBfsf6TSI2u0/OB1o+mblmq0IXyfOZO0KLATQXoYGcKJKJcIgzC1c9ZYaO4YKoxWEVfOaxnXPy/K5Zp06vrQYXoJDJd4JLJ78pcjch3xg2SaCsdQnzcozxPrWkXc9CD8cd8s1becgmYR4wesPRxF9sCBpCm+NE3OMb2/TSynfocGwHPAeirXHb9BbfdoYMbGishlKSQvGTzJMS373Q/G9jb3mt8KlX76VKPzeU4urs4OKxE78Dg1R0we8NJIi69Kb9kf3aSe9JNNK+ucRDrutmAmgdwL82iZaf1Qd5f/A1uviJzHwUx0o9wvlQ6PbsO2v4hwAabi+PbrQSK9hvRtW1k0LKoqAg6161zrpD8mczSEnvKmV8LOODEhSVm3P+jfOilIF7IimK6ToqtcmR9SWm4yy1JzAsaPEC2hlomuqI/BYFIkIw1atsyxVd8TnH36Prw0WOKcxCRET0YO0NERSBfKisWhHC29bJsOWZoxCT/ZOKrklW3RNDlJpmI+lTmG7gyd8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(2616005)(66946007)(64756008)(66476007)(83380400001)(66446008)(85182001)(38100700002)(36756003)(86362001)(41300700001)(38070700005)(5660300002)(8676002)(8936002)(122000001)(54906003)(6486002)(478600001)(71200400001)(110136005)(66556008)(4326008)(186003)(316002)(6512007)(2906002)(76116006)(6506007)(26005)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lqYXNXc3ZGd0p5clp4Y1IzdW9DQXc5UEVXSlRUdWYxaENRMnhlVHFjTks2?=
 =?utf-8?B?TzRBbjIwcDdra014d2NWNXl2TFhPdXpiR2hkQ2VIT3pjSGNySC9keHpMd2Vv?=
 =?utf-8?B?UlVMeHkwcTZKSUIvTUtRTXp2eks0Q2VaYzExSnZ4T2lMZ0xnaFZrcHZUSENP?=
 =?utf-8?B?OGtGaHNqZGFNTVY5aXNxaGU3bUhjSGFETm80elgyK3l5bXNoQ2Mzb0plcXFw?=
 =?utf-8?B?bFNIeW1XQU1ub1BlUDZ6MU9SbjUyZTBSTktNejd1bDlMMjRueVROSEhaMzBK?=
 =?utf-8?B?QSs4U2FkUlVHSWxwM3M0T1Vja2lSWmYweHV2WGsxNmsrc0UzMVpSd3JLRGxD?=
 =?utf-8?B?cUNzVFV2U1BmYk43SUl6WlVTWjJXRG5xa2VjZnkrRHRvRlNyd253MURJNGFy?=
 =?utf-8?B?Z3I2QzZzVldnaUI1ZmtySzJrS2FNRWk5cDVoY1c1S0FsNG45Q1VaVEtrNEpK?=
 =?utf-8?B?bit2TXljMTF5T1J6UkIvWXZlN1NFeldmeU82bzdkWWJ3cVFVM1ZmcFZrR1Rh?=
 =?utf-8?B?UTBZMFpDYmpwbE9tZndIMXRZa3kyNWw5MkIzeXJpR2xlVzNSbDJQOWkzYmRU?=
 =?utf-8?B?dEJCUExLd1hFK3Q5aUptQWlvK1Vmb0NNY2lTeXRFRDZiM1VUaEx6K1NNdUxR?=
 =?utf-8?B?N0R0aFFoc0k2eU1KUWQ3NVJiZ2RuNnpJdlpHb1orcGxaRlE3dURyNE1MVVRQ?=
 =?utf-8?B?Vk1SOCtVREU2cC9kZFV3NTF5Z0hTYTF6MTJJamhjSDNCQTFuK3h5MlNpMEcz?=
 =?utf-8?B?S29MSnRPVndwQlQxM3dOeUkyVi9DQUFHZmt6Q3JVaUVrTFJaR0ZEN0JIcENR?=
 =?utf-8?B?Y3hrWS9BaFNPa2VGVUdmUnBlRnUwK0JQMFY1SGdaWXFkNVFXaTFLVUgwVGNR?=
 =?utf-8?B?NWRJcVA3ZTFtTVBmTS9rcHRJYmY2c0g5Z0ZqV2M0ZW93STRFOTJlUlFRSXJ4?=
 =?utf-8?B?emFjNGpZT2JESUg0K0JTOVN3RWNsV3V3VThOTlJYU01LNXAxU0p5WmlKbWYz?=
 =?utf-8?B?NENPeFVxaTdyZjNWRnhSMEFKc3hYMHdhZFZ6U01QVEU0bnY0OVR5RUFYOVhM?=
 =?utf-8?B?UWgrZmNEdjA4ZUtmZW16Rjdib3V4ZmhXZEN4VU95R1NCUVNRa0JMaDNRVFZs?=
 =?utf-8?B?aHdoUCttTWdOUTBWWWl2cE1kSnppR2xXUFNpUXorZ2VNbFpIcnZ1a1k0dHJZ?=
 =?utf-8?B?QVpueVNoNElic1pQVkhTdC9GTHlwTzBxVGovRWdqT000S2IxTStwN0xLOTRH?=
 =?utf-8?B?RWRIV2hCZU8vcXZOUWVuYm9EdDZDSmxxRU5IVmhYUnkzbDNUa0J6Z1d0ZVVG?=
 =?utf-8?B?MDcxbHFncXJneWZLWG1XSlRtOEZ5SFNXakJzNHZWYVB0Y01SNlZoUWN2QnM1?=
 =?utf-8?B?NDZFcXFnam1kNER2WjBKc0c2d1Y3UXZlUnJRN09JVWFTcmV2ckZMQ0dvUitH?=
 =?utf-8?B?S0I0SWZxRUVmbHVlcjdqczBMbFdxNDRjWlZ3RDRmZ1h4Y2FLQ0lOQ0JycnJR?=
 =?utf-8?B?bE1VWFNyemdheG9EREJNR2wzbE40OGxvQWtKaXZ2L28xbDY5T2NIVWk2aVRN?=
 =?utf-8?B?WnlCYzBOb2ZaYXpGQXlwS2JKbGhaOVI1aFlGQnczZWxNYnhHdVVBdzAzdkdV?=
 =?utf-8?B?aTE5dUdETzgycEw2d3p3ZXl5YUlhdHd5VEgrS0xEdVhPSXd1YXJadEc5cFRW?=
 =?utf-8?B?ZVFUY1RISmJqWU1KNU40d1IvOHZpenlQWGNKL0pyeWQyakR0dWFZZmhMRzBy?=
 =?utf-8?B?aVlvNXVMY2tOZmtxMEhMNWpIcXZvVDdYNjFBbUs5K240OHZKVGc1YzhKV09r?=
 =?utf-8?B?bWNPUm1GbHNzSStjWHJOczhvSWZXZUdoUTVQRTRNQndTUWtnMWtsN2htSUp5?=
 =?utf-8?B?Zi9BVG9ncnYxNWpCL1RKUEFJRExRbUIzaUU0L2t3eDRRTVM1Q3VjclkxUUNH?=
 =?utf-8?B?ZHhkK1QwOGN2enluNTI4Uk4wdmRtR2ZkRGVmMEVSUi9Hdkx3RXV2UUwvQTlm?=
 =?utf-8?B?STgyclR3REVudHBPR0ZzdUxoNWRvUXZtRjUzM3R4UERZQkc5SythSCsvZnIx?=
 =?utf-8?B?Y1MrcDFrWXV5OUhyWFpxVWc4akNoM0xIS1hUN3cvZDBYQ1FPS1Z0L2tidUJ2?=
 =?utf-8?Q?zTxSBwxn2voLi9TBMy4c501H3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFBA4032E30F8243A24D3318A86F3558@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328d6563-0a52-42c1-a958-08db8d9b74fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 05:45:02.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +SZ6dJeIiUk11ke7jihxvZ/cJmO4bYkDbSQ6OVN0f9k8kj8ovVgsqanCLMZCsWov54h0udQCEel2tEDptf9i+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7427
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDIzLTA3LTE5IGF0IDA5OjUwICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gVGhlIC5yZW1vdmUoKSBjYWxsYmFjayBjYW5u
b3QgZmFpbDogc3dpdGNoIHRvIC5yZW1vdmVfbmV3KCkgYW5kDQo+IGNoYW5nZSBtdGtfZHBpX3Jl
bW92ZSgpIHRvIHZvaWQuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+
IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIHwgNiArKy0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHBpLmMNCj4gaW5kZXggZTljNWEwZjQ0NTM3Li4zYTE0MDQ5OGM5OGEgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBAQCAtMTA4NywxMSArMTA4Nyw5
IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IG10a19kcGlfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICtzdGF0aWMgdm9pZCBtdGtfZHBp
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCWNvbXBvbmVu
dF9kZWwoJnBkZXYtPmRldiwgJm10a19kcGlfY29tcG9uZW50X29wcyk7DQo+IC0NCj4gLQlyZXR1
cm4gMDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRr
X2RwaV9vZl9pZHNbXSA9IHsNCj4gQEAgLTExMjIsNyArMTEyMCw3IEBAIE1PRFVMRV9ERVZJQ0Vf
VEFCTEUob2YsIG10a19kcGlfb2ZfaWRzKTsNCj4gIA0KPiAgc3RydWN0IHBsYXRmb3JtX2RyaXZl
ciBtdGtfZHBpX2RyaXZlciA9IHsNCj4gIAkucHJvYmUgPSBtdGtfZHBpX3Byb2JlLA0KPiAtCS5y
ZW1vdmUgPSBtdGtfZHBpX3JlbW92ZSwNCj4gKwkucmVtb3ZlX25ldyA9IG10a19kcGlfcmVtb3Zl
LA0KPiAgCS5kcml2ZXIgPSB7DQo+ICAJCS5uYW1lID0gIm1lZGlhdGVrLWRwaSIsDQo+ICAJCS5v
Zl9tYXRjaF90YWJsZSA9IG10a19kcGlfb2ZfaWRzLA0K
