Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525A776444E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjG0D1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjG0D1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:27:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61661FFC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:27:12 -0700 (PDT)
X-UUID: 77cf10e62c2d11eeb20a276fd37b9834-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o3OANIT8BOE1azHxjVZybqFHd5dMPApwTd55W7zQLuQ=;
        b=OJvl5PWwXxGLzsNBS7mFsJhiRkUs8jz/eMkIvRnuC3Pp3N/w1d2sI4ltzoAG8vDwNDAESknSOwWUL0CfrA/BTBecikaSs5vw7SQr1viLMrA4YDo8Zpnjj3kQXics5xtJZ7N3H1iQb93rhYRpD+rUlwudMkNBiS4i0fnxWgp15HU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:25f44610-7495-483c-9323-ddb927fc0662,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:25f44610-7495-483c-9323-ddb927fc0662,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:f6e75fd2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:23072710532737Z6Q7OY,BulkQuantity:7,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULN
X-UUID: 77cf10e62c2d11eeb20a276fd37b9834-20230727
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 767861223; Thu, 27 Jul 2023 11:27:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 11:27:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 11:27:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ipa6LbaT7UxrEZpjDK/Z6j2ez2t2hbSzELQ5R2zBiA63zl1PtQJ10UembpIpxrFV3PLHj8PJ9wpeDy2O5Y0yTCzEFCRoNWnJvsfy8cSMVFHAWvmSUKLStm1l2Q7RK58qxlyEIok41onEUI6MerV363H/dB/nvAgq6pzD/Yh7a7MqWgODi9X0vYn/vTSLDJYKSk/g7rQE8WGWmlSZgCZH4BWpK/9CWSuVuhE8NxGGxtQkabanxI4um0Ju2rheFmK8yq8oXAPMxdwAAhJKQwtptU0NpXLBZfM/AFVOPBTr+SSluk+51YzkSRehOADERQUya3pnoexYCnn0yWZwcwUghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3OANIT8BOE1azHxjVZybqFHd5dMPApwTd55W7zQLuQ=;
 b=E1609LInJRykLJZKIPJMciI98Grja0gOiPuNdAV9cVwiVae+gNMSTMNUf73AtiRWbYTNkIa3FC2k5VBYTcOwpsAd6j5FJZS/O0bTyus8TD+i+llr80r54cKKG9GiP+2oRGPcv3g/7wVrq7tyjmrX2qSURGtVwckS6AJ6XhYUJTo5wXh6bEk9fiyl+6cXZKyXb8UcuD+h/ltlPbYERwI0pmQag/qcTpYuJhtjAVpRQHL6Avh86Suv9o4t5+7JAnHWULxjSlRvVvXxM11CV89B3lKku35Tkyw/9rfNUm33Wyf1ZkQoRXa9JSVDHVyeSp9F0qmRi2CIfGxI9/ziBJwDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3OANIT8BOE1azHxjVZybqFHd5dMPApwTd55W7zQLuQ=;
 b=WPWdM8gQdXQyh5BfWjCDmWw4NN1qwLkwafurBq89snL9LOV+2XiYCOWWZe9M4rPRk25nzpOfXtQmWCoLe5Ww/soDxvNipxKpNUT3bncuiSHHsNUcA4FAfAukuWiB3l0LLx7mJ15rvYuhzFXzfRn8TmVKOUVNwQAijd7VcSxNyGk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5769.apcprd03.prod.outlook.com (2603:1096:4:15b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:27:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 03:27:03 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v7 08/11] drm/mediatek: dp: Move PHY registration to new
 function
Thread-Topic: [PATCH v7 08/11] drm/mediatek: dp: Move PHY registration to new
 function
Thread-Index: AQHZvsqHCJVF6g0BJESGkWpVnAZEYa/M9taA
Date:   Thu, 27 Jul 2023 03:27:03 +0000
Message-ID: <1533c98764b34896fc959bb03b748830f97437d0.camel@mediatek.com>
References: <20230725073234.55892-1-angelogioacchino.delregno@collabora.com>
         <20230725073234.55892-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725073234.55892-9-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5769:EE_
x-ms-office365-filtering-correlation-id: f363cb9b-cd45-43a2-2b4f-08db8e5158bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/pFqHh5WjOj3kKZhRYnrRmCSe5hUzBRj4raZgpmSAhWjAcz/BDx8thqWIHsQQJ+vmgJ3LeRLYfS7xK3cN0MmBu/onBOpfUr8IPZsFTk3+IJFphiLQGrmdVHQ33mdDW/N4mjPxKhguWuXDUZKQ9NtMILTPIEfN8EEOSckqLFxm88gPF4VfoUWm5YlfEfntkeMHThvZ3OCsmwlMytVt2Tf8Y2u/BAzasS3dqyl3j5cr/5xK6oBMGg5CZp/TuJMFAYpSO+d4vyUgh0GifQqByEndePE7HmkXzWTMAB/mxAbReU9tef5Wm//dkZgOy/DYH9vqkvb6TLsy7yqNzYq+NTNTQjc38BPC8yLjP084HVRlxbTtS9VbkuICFQOPD3mrRqx75zK4P6SD5BEAp6RptRFNMfvuZgF96SHBZpHxdSMQHReZNzBPsPebO39D6LSORsAdikl7UW8g3YX0L4mkSaWKwWXsCnY2dFEkDeuTvPOEwZ9wukRNMXiaMAA1Q/iDyVynonived/w6UZIKgn9oylzbsa8ENmjzNkcwkD+XHHMG7aKH55U8FSl+8ANR/WexDnqfLSa26ca8UX++MgiFKBBJs5HdSbqo1XJxsbSzM6IbBEL/GQM4+GJvOV7Hzfbilj9rz0sMTUHu97R+syoLKh/Q5sUPClqDbY/4M752ruA4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(2906002)(316002)(41300700001)(86362001)(38070700005)(7416002)(5660300002)(8676002)(8936002)(85182001)(36756003)(6512007)(26005)(6506007)(478600001)(6486002)(71200400001)(83380400001)(186003)(2616005)(76116006)(38100700002)(54906003)(66946007)(122000001)(66446008)(4326008)(66556008)(110136005)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDk0b3NyMFJQODYvNW9ySEtEU2tUY3NCQ2pSdTJUUHVYUmJqQSs4azhjbVd1?=
 =?utf-8?B?aTB4aHJZcVlBWDNXeW5RSmwreG51SmNtVi9hTk1nbHVWZnJIakJhaUl5OHFW?=
 =?utf-8?B?UThCbFV4WnMvSjZENW9qbGlPR3RoclNzZTNvV1Z3MW9aZWxMK1JNSnk4VHhT?=
 =?utf-8?B?ZmdUNFhRa2ZPN3ZjKzFtWEdhdzkycVBXemx6T2krQTNpOWltVnQrRnhlcFFr?=
 =?utf-8?B?VmJ5U2o3TGlybTlvMlFCR1FiMHdCWlpnQzRMMGRMNXRDTHE2UEpWWENzTlYv?=
 =?utf-8?B?QTJyUm16TTlYOXlXeHpubVZiZkdoUzQ4WHFEMnVuV1lZRDU5QzdLUU1CdUNY?=
 =?utf-8?B?Y0JDTUZITXRyMnNJRjBJVjlBUVIyRFRNOXgyd2NvK3J1VE9MVWRxZ2FUU1Iz?=
 =?utf-8?B?bTNiUFhZbWgzTUNqNEozcnUybWNxTVlBRW5qUGFwTVN4NE9IY2dqaGpVeTQw?=
 =?utf-8?B?V1EzQUVNV2U5ZEdYTHBXM3lNSnF6M0VMUXAzQzlBTVNycnZrTXNEaG45dkpz?=
 =?utf-8?B?YjM0eGE1dGF0WG0xMFFJMUg5eHNJTWZia1h3UmNYYXBOdGl4aHUzMTcxT2VN?=
 =?utf-8?B?NUxvWlVvN2pBNVloQ1NHZ2ZWU2RZSVFIeTFvd2ZBdUZaOUI2V3kvZVluL0xZ?=
 =?utf-8?B?aWhseTFLSjZ1cEdXME9maWF2N1JVd1F6aHhjVllwWGw5cDhIbC9VWFFLSWE0?=
 =?utf-8?B?NGFXd25SNGhGaG1aWm1HMEJ4aW9GaTBHNW5lYzBOUzFCVXBwVzVudU14WDJo?=
 =?utf-8?B?eHVta0JNSWVWZ1FZUTF6WnU4UU9uTGFMTGlzZ2hzOWdOV2h2SWl5WnB1Q2ZF?=
 =?utf-8?B?dWFmUWJSVVZwbWlJWjB3anYzYjBxVjhtOVVVZFFKM1hBQjF0Z2pqbXFIVUhr?=
 =?utf-8?B?bEtLdmdSSWtDR3VaNnVtMDkrNDVhcC92SXlOR1FKTHJYdWFwb3BwQnlKYXdj?=
 =?utf-8?B?eFd3aVAvQTlVL1BVbWlVWStNbVJUUzJUc2w3NFNIaGlQZG1xTFZIVGtrS2d0?=
 =?utf-8?B?UnpLcW5mTHU0cWFBUDR3bGc1RmlFR3R0WHJ1RzBUeHlJZVE4ZFE4VktOcTBN?=
 =?utf-8?B?dERHR0MzUm02Q0wwelRqNGVVekMwMHh6ZmViWkRON2I1TjFORzJkRmtpUGhu?=
 =?utf-8?B?WXB1R1ZWOU13RTdCL0tHUGRCd2dSWktFTC9BNXVxK09JaGhSOCt4RUJLcjF1?=
 =?utf-8?B?Q2dhcXFSMWpCMGZHUnY2SWpaOWhaa0V1TDN3aVE3aStzbFcxazFrc0RGcW9y?=
 =?utf-8?B?ZTRuVzl3TDhFMFQxV3laaFpVdVdTMjFmUk0zZE5LMzN0WG51bTRaeTdtRzVy?=
 =?utf-8?B?SnpVVmo1QlR1QVBOaU85WXBoV3dmV05uN0lnaTVUa1kyeWkySHIyUkE3c2Ny?=
 =?utf-8?B?K0kyMktTcUhFSHJldTd5cHpnZlgzTlFjM1JSUHlrWDVDdGJZbU83SEVSNkEz?=
 =?utf-8?B?VGVONzhJcTlMVEM1RFhlSkw0OFRxYm94cnhFYmhHb3IzNEMwSnFUQzJKcGhu?=
 =?utf-8?B?MWZTQ0dMMnhDeFhUSDZhZ2VweE1zZnhaNk56dTJOZkFrNWVVN2Z0WnJxc0sz?=
 =?utf-8?B?L2pMMnpqT2QvaklWMzVUYUJwaWV4QitiTDMwelZPQTZ3cUp1NWt0bHpKb0Iw?=
 =?utf-8?B?M1N3Y3ZFaXlaV0MyMlFwc1hpKy95UFJYM1hXRGhDZHhveXFYbXRESlU4U0l2?=
 =?utf-8?B?TzZsSWhqSTI5U3VrU3psWU1iZllJNGF1bUFCWW9PRFJ0QldmcW5DK3hqRkVm?=
 =?utf-8?B?UVN4bHZhejFpQzZ1Qm45dzNrQUpwNldOSUVMR3p1U0R5ak0zKy9zYW9mWDNY?=
 =?utf-8?B?ZGloNlYvUllrNzNPT09MaE8yVEU2eFBLWFQ3R1g1QkFkWERkNWFUNTZEYjJN?=
 =?utf-8?B?SVJ5K3o4TjUzTWMxSUZVdFVsamVCc0Q0dU5jSlpQeHp0ejg2SjVva0ltTGxF?=
 =?utf-8?B?K0dKVHRCcVd6V0o0ek9EL1pjMjRZZTNLS1VOR3N6SjFBM21Dd3ZSQUJhLysy?=
 =?utf-8?B?NmZYaCtWV2I1anY0Z09CVjBSQ0NWaks5VjFHZEhTOERjRzFaVEhSbTJTaTZZ?=
 =?utf-8?B?VGdQdFplNTJhbHVtNThkOElyYmN5Mmk0MW9EelkvdjdGdStQN2d5TERpK3RH?=
 =?utf-8?B?SzhDT2xpeUpuK1l3bUhKTkltZkdoV3E4b2JNQWUzRWtLenpFZGVrWW81NmtB?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C683FBDCB5F3F144852B86AA1E6C911E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f363cb9b-cd45-43a2-2b4f-08db8e5158bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 03:27:03.4845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N50tEi9JFoZOkSvGxmTRugSZS2M9eci2Q8EoXwtpkuvVl+DVAl7DBnAKwWYhs0KOLsv5F4F4gtaRv4jOYLjw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5769
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDIzLTA3LTI1IGF0IDA5OjMyICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBz
dXBwb3J0IGZvciBlRFAsIG1vdmUgdGhlIFBIWSByZWdpc3RyYXRpb24NCj4gY29kZSB0byBhIG5l
dyBtdGtfZHBfcmVnaXN0ZXJfcGh5KCkgZnVuY3Rpb24gZm9yIGJldHRlciByZWFkYWJpbGl0eS4N
Cj4gDQo+IFRoaXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gVGVzdGVkLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNocm9t
aXVtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwg
NDMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyNiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmMNCj4gaW5kZXggYzFkMWE4ODJmMWRiLi4xYjQyMTllNmEwMGIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gQEAgLTI0NzgsNiArMjQ3OCwyOSBAQCBz
dGF0aWMgaW50IG10a19kcF9yZWdpc3Rlcl9hdWRpb19kcml2ZXIoc3RydWN0DQo+IGRldmljZSAq
ZGV2KQ0KPiAgCXJldHVybiBQVFJfRVJSX09SX1pFUk8obXRrX2RwLT5hdWRpb19wZGV2KTsNCj4g
IH0NCj4gIA0KPiArc3RhdGljIGludCBtdGtfZHBfcmVnaXN0ZXJfcGh5KHN0cnVjdCBtdGtfZHAg
Km10a19kcCkNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtdGtfZHAtPmRldjsNCj4g
Kw0KPiArCW10a19kcC0+cGh5X2RldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKGRl
diwgIm1lZGlhdGVrLQ0KPiBkcC1waHkiLA0KPiArCQkJCQkJCVBMQVRGT1JNX0RFVklEXw0KPiBB
VVRPLA0KPiArCQkJCQkJCSZtdGtfZHAtPnJlZ3MsDQo+ICsJCQkJCQkJc2l6ZW9mKHN0cnVjdA0K
PiByZWdtYXAgKikpOw0KPiArCWlmIChJU19FUlIobXRrX2RwLT5waHlfZGV2KSkNCj4gKwkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG10a19kcC0+cGh5X2RldiksDQo+ICsJCQkJ
ICAgICAiRmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgbWVkaWF0ZWstDQo+IGRwLXBoeVxuIik7DQo+
ICsNCj4gKwltdGtfZHBfZ2V0X2NhbGlicmF0aW9uX2RhdGEobXRrX2RwKTsNCj4gKw0KPiArCW10
a19kcC0+cGh5ID0gZGV2bV9waHlfZ2V0KCZtdGtfZHAtPnBoeV9kZXYtPmRldiwgImRwIik7DQo+
ICsJaWYgKElTX0VSUihtdGtfZHAtPnBoeSkpIHsNCj4gKwkJcGxhdGZvcm1fZGV2aWNlX3VucmVn
aXN0ZXIobXRrX2RwLT5waHlfZGV2KTsNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQ
VFJfRVJSKG10a19kcC0+cGh5KSwgIkZhaWxlZA0KPiB0byBnZXQgcGh5XG4iKTsNCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBtdGtfZHBfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RwICpt
dGtfZHA7DQo+IEBAIC0yNTM2LDIzICsyNTU5LDkgQEAgc3RhdGljIGludCBtdGtfZHBfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAkJfQ0KPiAgCX0NCj4gIA0KPiAt
CW10a19kcC0+cGh5X2RldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9kYXRhKGRldiwgIm1l
ZGlhdGVrLQ0KPiBkcC1waHkiLA0KPiAtCQkJCQkJCVBMQVRGT1JNX0RFVklEXw0KPiBBVVRPLA0K
PiAtCQkJCQkJCSZtdGtfZHAtPnJlZ3MsDQo+IC0JCQkJCQkJc2l6ZW9mKHN0cnVjdA0KPiByZWdt
YXAgKikpOw0KPiAtCWlmIChJU19FUlIobXRrX2RwLT5waHlfZGV2KSkNCj4gLQkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKG10a19kcC0+cGh5X2RldiksDQo+IC0JCQkJICAgICAi
RmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgbWVkaWF0ZWstDQo+IGRwLXBoeVxuIik7DQo+IC0NCj4g
LQltdGtfZHBfZ2V0X2NhbGlicmF0aW9uX2RhdGEobXRrX2RwKTsNCj4gLQ0KPiAtCW10a19kcC0+
cGh5ID0gZGV2bV9waHlfZ2V0KCZtdGtfZHAtPnBoeV9kZXYtPmRldiwgImRwIik7DQo+IC0NCj4g
LQlpZiAoSVNfRVJSKG10a19kcC0+cGh5KSkgew0KPiAtCQlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdp
c3RlcihtdGtfZHAtPnBoeV9kZXYpOw0KPiAtCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBU
Ul9FUlIobXRrX2RwLT5waHkpLA0KPiAtCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgcGh5XG4iKTsN
Cj4gLQl9DQo+ICsJcmV0ID0gbXRrX2RwX3JlZ2lzdGVyX3BoeShtdGtfZHApOw0KPiArCWlmIChy
ZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICANCj4gIAltdGtfZHAtPmJyaWRnZS5mdW5jcyA9ICZt
dGtfZHBfYnJpZGdlX2Z1bmNzOw0KPiAgCW10a19kcC0+YnJpZGdlLm9mX25vZGUgPSBkZXYtPm9m
X25vZGU7DQo=
