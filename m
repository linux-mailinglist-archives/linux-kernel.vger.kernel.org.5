Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB657B0144
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjI0KFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjI0KFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:05:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E1199
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 03:05:29 -0700 (PDT)
X-UUID: 5d764f725d1d11ee8051498923ad61e6-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5NwTyUrVmyqP7lNtSgxazlHSvOMau0Mhvi9j+1ElUKI=;
        b=fvE766D8FZx2SWuauWfw6kJ5RbHLchx5YRbpcPC4wN5u1+9Yw6eLW0s3OVT2oV1j9oF/q9RADB1hJowW8nsYdB4curzOSyMRZLPEPvmGUZpxnn28q8Vx9J1Z6rSdrb7XKaav4rcC0NvnzaPKyorTpIQZ6xJd8xBIY0dH18xIBp8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:39cb2561-3c7f-4dee-94c5-edb1d54e1da3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:948855bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5d764f725d1d11ee8051498923ad61e6-20230927
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1008673002; Wed, 27 Sep 2023 18:05:19 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 18:05:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 18:05:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvAmedJslADZCKJa92XmsMLXV03eFoOUipxUkapp36GjgAzMElEf+goQEc/Jz5jBJGIy+YiHi6WjDo7wS9x5an3a1T6rZ3rct2pVZBdVm8svxwYve0hbBs+jJ/UTJYYTCVL0w53qzD66Zzo6nYZeK2tjXMvbgzUF2HACHpZmD0leUkG9FEa5qo3nWXRl5oz2uGYlhoiWBO7hCUMwFb1TLQQBXCcsw6EKusMm6/t9mi2QLiCMZoeURzAF4H97u7GKALnhmYR3t/fDRo9+Y4vtaUZ31eKwXmYciM99+CS02iqjSKu6eZfejfB7ADhgEh1pTZoNoU07yHGJRWjfvZNUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NwTyUrVmyqP7lNtSgxazlHSvOMau0Mhvi9j+1ElUKI=;
 b=mW2lPzLqX7CYB0Ww0SzvZZTKBGfbr5eV18SjaS1HJyirkskTrqE46Wdd9foPpw1BhsWSO49rabjnIeOS80YjDFBZte8ogkaSc/KTw1eRoYrjl8QoSTX5fLEFunaw8sbuOQBGQ8UCKzbXsfSRKUQgk4ernxSExNXRv0IGgCMPJ4T7byMx1+O+NpZnKxKfI4M0ySYdkIjQ/jvq/8qTlNoJ86VN9oH5ZLfAYK68PTrWOkEEhC89G/G+Axuqceh2CbcGynB1mA1C/iIbj6xpfUaEljuaQ9l4EgNGPp9MCPmV2QHU0yK0UcdzRs0cBbMhboUFHQu9oFF3RK1nroizyWBpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NwTyUrVmyqP7lNtSgxazlHSvOMau0Mhvi9j+1ElUKI=;
 b=eDwTU4xyUFlCZvwRAdyjiam31Vj/8M7JaedBbec/akg/O9lRUWurp8LazBdWyrQCaQc6IWeVx+DNJ5GU0w0btQk878B0u9bUdMjpGftz7nj1XAOBi0VMyu7Y6Vb3JE6wblgUPzGyYndXcugFqwGeeVbwT1zxw7+vuu7m5Ppo3sg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:05:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 10:05:15 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2] drm/mediatek: dsi: Add mode_valid callback to DSI
 bridge
Thread-Topic: [PATCH v2] drm/mediatek: dsi: Add mode_valid callback to DSI
 bridge
Thread-Index: AQHZ1aMjzZJ6uDSkPkyssyPrbamoc7AuqPEA
Date:   Wed, 27 Sep 2023 10:05:15 +0000
Message-ID: <a119d3e94cff5530ce00c3c5f72fc4fdb3e46ac5.camel@mediatek.com>
References: <20230823092047.32258-1-shuijing.li@mediatek.com>
In-Reply-To: <20230823092047.32258-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5605:EE_
x-ms-office365-filtering-correlation-id: 54afdcd0-76a7-4723-40e1-08dbbf413eea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1B/n83ZWWuU+RMkWP+YIb6MdQPHVpgNDLoKtlX1rbXRTRJXi/59/l+6M/vyPxN0zexjYWsV+XaBG/eQ1ut07clQLIspC99tnL9HUy6lsVJIWwUFY/fQV7SJCVnhqqlf6xtQzbv8N3RieeQJErhsubbF7iVpnZhjBcrkgCx0pUwPlRBXslLPsAeTSc3OKz8xITF7fEDJlQpSoQDsYtq1plrbLD97smNqlHM6Yp0AEx28Li0m3ZtSFzNuWWmfr5+Mx5JUjTYkkW1YT5w1m9by9zwsjiUPbYC/WoQi6lEWkAyaEso3B08RJiX3rcCNZcah52VMdabTAf/oaE2GJpiObPsTQ7vluTVNbwRYht+sCN8XTw4yP4Mlp8SG3yWZek+NGwIL3YVISHjclVT464s7+sL0krvL4t4VMgv31pRmHBh39wmUmgyBa9sr0UUaZVk0tQHSWgB89OnSidq6KqZInkWNeiJFZqOFlhLY7c/bTJg2XaoMrFunqgD1CmoLBfUqXG3szjk3SyaGXA2IgVJCimF+PId0lUbB38LYpqulsBCbDpWUUcIFgYWC09DIY5Ewi5cewk9t6pq6vv/wMOPzt/G3MG/BjTofWvYcs8VPz84/Dp3cW6CfzOS6RtnggCyHHEopZhy35sbovCpK7JSem8sGYzNPudYPq4J7VuD0PFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(5660300002)(7416002)(316002)(54906003)(83380400001)(41300700001)(6636002)(8676002)(8936002)(85182001)(36756003)(2616005)(66946007)(4326008)(66446008)(86362001)(6486002)(110136005)(6512007)(64756008)(6506007)(71200400001)(66476007)(66556008)(107886003)(26005)(122000001)(2906002)(76116006)(38100700002)(478600001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkV0cXhQTEpTT29hQm8wOHdTWTVqK0hxbDhtdlJ4c05MbDcrSGpaRHBPODVq?=
 =?utf-8?B?WGExWUpZcUlLeEZ0d09RNFRnM0ZTazRtQ3J3RU9YV09yQ2F5ZFpFemIwTkVF?=
 =?utf-8?B?NnJidXl3L09ETGFxWlNJcjJVcDVBYm4vZ25UY0RZYUhXRENJWXhxV1JrbFll?=
 =?utf-8?B?K0tZTlg1ell1SGYrSnhiUU5lbFNVOGk4ejFrNXJGQUYrNnA3VlpUak13QWlM?=
 =?utf-8?B?eUVZYUx1QnBZbktyR3hrbnZCd0JqeFZGVWFJTytLbzV4SGtleGZSalM2QklQ?=
 =?utf-8?B?ZlYvcGdiQi9pQWFPSkRsbWV0clJQcVNBcWNTL1BLUmN6VW1QKzloanViN3NF?=
 =?utf-8?B?cTZCODc4TGtTRXJEOVprZEFqWklpcElDaG9mL1QzN0JTUGlqSUQ5cjN2UnFm?=
 =?utf-8?B?SEFnSGk1RmRUTm5LdHhlaURpakRtNGFYQ0Rhc3ZHeTF3NHJKTzAvdi9kRlZu?=
 =?utf-8?B?Q2RBY1A3cVpRZ3pmNDcrNCtsczhZREc4YUtqaHEvNUsxeGcyUXExU0FYb2ZX?=
 =?utf-8?B?VFIzNjlKbUZIMldkT2szMlVsWkZuRm1hTzM0eUFaU1dBaFNTN0RPWXMxQWFq?=
 =?utf-8?B?WUM1QU40YUh1KzY1ay9aQWM1S2ZzeUdDc21NNDA3WXhsT2hrOGc0eVFxQTdZ?=
 =?utf-8?B?VzZqUkxXVWxIdUdtZ0dIU2ZXTGdoSmgrbHRiRzkvejJLU0RNa1EvbjAwT1VI?=
 =?utf-8?B?eWxjMFdldmwrZ0IzNkkySXdiL2xBT2RSN2VoSGM4MVZ6MnBvbWhoRExQKzFp?=
 =?utf-8?B?RVBpc283RUlJMFlQOXFraWE5VHJpRUdxWVUvQ003em5mZFAzbFNvY2t0WEht?=
 =?utf-8?B?cHgxSzNNT3BNdkFCa1BUR01QU203YzBNT2Q0QVN1YlUyQm4rQXFpb0tqMWJ4?=
 =?utf-8?B?TGlsKzlUMm1IY2xVY2ZMK3RkaWpSaTBlK1dnRjMraUROd3ZZb0NtdUVWL0ly?=
 =?utf-8?B?YnQ2VHMxdUU5MTQ3MVhKZE5Cc1p3REUyTmlpLytuUWsxL0FOUHl6WHVueVFZ?=
 =?utf-8?B?M3BDSm5zNkw3dk1KakY3blAyb0VHd3ozNU9rZzJleEJIYTN3SmFEcmVOcWtr?=
 =?utf-8?B?Z1BaemVnVXBEQXJ1eTVhRjhPRkx3L2NlazVVd2hGbE16WnVkbk5WWk1VWVFH?=
 =?utf-8?B?a2lYVnBIUythY2hOTDFSRThsYmpSWGlnNUhkZjF4UWhJWXlZdnRiMDJXdVkx?=
 =?utf-8?B?eXNYais1UVp6TUtiY1RYMXM3ZUt2UXNRTlZzc0ZwSkozNkgwNlhBS2h1dFFS?=
 =?utf-8?B?eU8xNUJNZldQV01ROWpNS2Z6dGh2Tm1HWVVKOGN2VnIxMlFjUFk1Y1NuZVlB?=
 =?utf-8?B?RE15d0d6RDJ1ODc4ck01dWlENWlVemFlYXZRZFhtUlRqcTY5Z0s3V09PS2Nq?=
 =?utf-8?B?RzRaeHpQSTRDZ1RUVWFHVUZsdGpHTExRS0RqZUE4YXJSUUp0eW9CTTMreXBN?=
 =?utf-8?B?djdHV3V4Z3JFZ0ZCVkR3VXBUVUJBekViOC9BNEtndkR5SGlaVTVkcDYrUHg0?=
 =?utf-8?B?alpyaExqeWczbSt3Z2FoMFBpdlNLSGM0Y1VZYXhJWTFVRFluQUZhSzkzRHpH?=
 =?utf-8?B?MzZuZHYvZ0tzMzFPWGNEUzlXYWtKcDhiMVoxNzRnckNScFRMc2NQZXgxRXhr?=
 =?utf-8?B?T3JNWTB4eU1zNnFFTlUwQW9LTkdUNUREZVVqR0d4R2ZwcnpyUEtGbmZnMWFQ?=
 =?utf-8?B?ZkV6QnBmTWlPa1dodm1rczI5cVl0VGJVcTYyWWpjL3RwQ05zWUsxTFJhcklj?=
 =?utf-8?B?ajMxMW9Pd1o4eDQvTmJJUExZZ2Q2aThLaDZGaGNVenljaVNPN3ErV01vY0hm?=
 =?utf-8?B?UGtLaHNkdVdLRFJsS1c2Q25BejAvd1NteEVMd2JiWEx4UVUySUhZdmx6Z3Rn?=
 =?utf-8?B?SFBtYmtWUWUrVG80VGtYanYzdXJXU3B2RlhaSjh2cFNyMC93RUpPNU5wLzdR?=
 =?utf-8?B?ZG1USUlBMlRONE85c3hGM0JETFZoVDZZWEthTVRyeXNBRWZsR1gxSTkwMUZx?=
 =?utf-8?B?dm9Ha1FqRktCMkZ4d29sL2JJcmNJWk4xdG9hM242Mm9zejdwa2VZZWt6VnZy?=
 =?utf-8?B?S0dqUVBDcHJUUG9qUTVCQU1LY3hPbWRCYjhXMngzTGpGQ0d2RTQxcGFJSWgr?=
 =?utf-8?Q?rwhH2rW7foD2pMKL7Eo1GTOie?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45C4FCB204A8844DA6F5F530419DF1A4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54afdcd0-76a7-4723-40e1-08dbbf413eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:05:15.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjN+ULrsWdBymCBaf7oxY/WeaRqrdl5R0J79Sqw0WpYvwwPr6pKIzR2+DjCti8BevJw89p0CBHmCgr3w+vHEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5605
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.376200-8.000000
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL9nhD9A3Sa7pb7efdnqtsaExZg
        /ywVo+Y8yfqQpSXdi3wAid4IOseWNUodIj41qlWAT7jCYv2QJPFMkOX0UoduuQqiCYa6w8tvohQ
        ioQPL1+5HtHbPEukkeQLhRlyMJQgjbYSeyF0SKjZ05zsoB1UKTn0tCKdnhB58pTwPRvSoXL2y5/
        tFZu9S3Ku6xVHLhqfxWBd6ltyXuvuOa4kg8oSepKLIoizGf+aMCEmrjeDZLPfl6xTf4dUEvn653
        nQTZF1txvI1PaP3lnu1Vc0BfSEp7imtO3C2kI8/uLJkp/eXKZb8DYAMxfNdesTcZRBQ3ORlx7TA
        T/418tn4dFDMTTdqtlRjIYeif4m6ftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.376200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 69829A497821A58E33483D932679823A2136D30BB1E4A85FC6CE4575697799992000:8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBXZWQsIDIwMjMtMDgtMjMgYXQgMTc6MjAgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBTdXBwb3J0IElHVCAoSW50ZWwgR1BVIFRvb2xzKSBpbiBNZWRpYXRl
ayBEU0kgZHJpdmVyLg0KPiBBY2NvcmRpbmcgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIE1JUEkgQWxs
aWFuY2UgU3BlY2lmaWNhdGlvbiBmb3IgRC0NCj4gUEhZIA0KPiBWZXJzaW9uIDEuMSwgdGhlIG1h
eGltdW0gc3VwcG9ydGVkIGRhdGEgcmF0ZSBpcyAxLjVHYnBzLCBzbyBhZGQNCj4gbW9kZV92YWxp
ZA0KPiBjYWxsYmFjayB0byBkc2kgYnJpZGdlIHRvIGZpbHRlciBvdXQgdGhlIGRhdGEgcmF0ZSBl
eGNlZWRpbmcgdGhlDQo+IFNwZWNpZmljYXRpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2su
aHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1
aWppbmcubGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gQ29ycmVj
dCBkZXNjcmlwdGlvbnMgb2YgdGl0bGUgYW5kIGNvbW1pdCBtZXNzYWdlLg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAyMCArKysrKysrKysrKysrKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCA3ZDUyNTAzNTExOTMuLmE0OTRlMDRmMGRkZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC04MDYsNiArODA2LDI1
IEBAIHN0YXRpYyB2b2lkDQo+IG10a19kc2lfYnJpZGdlX2F0b21pY19wb3N0X2Rpc2FibGUoc3Ry
dWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIAltdGtfZHNpX3Bvd2Vyb2ZmKGRzaSk7DQo+ICB9
DQo+ICANCj4gK3N0YXRpYyBlbnVtIGRybV9tb2RlX3N0YXR1cw0KPiArbXRrX2RzaV9icmlkZ2Vf
bW9kZV92YWxpZChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiArCQkJICBjb25zdCBzdHJ1
Y3QgZHJtX2Rpc3BsYXlfaW5mbyAqaW5mbywNCj4gKwkJCSAgY29uc3Qgc3RydWN0IGRybV9kaXNw
bGF5X21vZGUgKm1vZGUpDQo+ICt7DQo+ICsJc3RydWN0IG10a19kc2kgKmRzaSA9IGJyaWRnZV90
b19kc2koYnJpZGdlKTsNCj4gKwl1MzIgYnBwOw0KPiArDQo+ICsJaWYgKGRzaS0+Zm9ybWF0ID09
IE1JUElfRFNJX0ZNVF9SR0I1NjUpDQo+ICsJCWJwcCA9IDE2Ow0KPiArCWVsc2UNCj4gKwkJYnBw
ID0gMjQ7DQo+ICsNCj4gKwlpZiAobW9kZS0+Y2xvY2sgKiBicHAgLyBkc2ktPmxhbmVzID4gMTUw
MDAwMCkNCj4gKwkJcmV0dXJuIE1PREVfQ0xPQ0tfSElHSDsNCj4gKw0KPiArCXJldHVybiBNT0RF
X09LOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3Mg
bXRrX2RzaV9icmlkZ2VfZnVuY3MgPSB7DQo+ICAJLmF0dGFjaCA9IG10a19kc2lfYnJpZGdlX2F0
dGFjaCwNCj4gIAkuYXRvbWljX2Rlc3Ryb3lfc3RhdGUgPSBkcm1fYXRvbWljX2hlbHBlcl9icmlk
Z2VfZGVzdHJveV9zdGF0ZSwNCj4gQEAgLTgxNSw2ICs4MzQsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGRybV9icmlkZ2VfZnVuY3MNCj4gbXRrX2RzaV9icmlkZ2VfZnVuY3MgPSB7DQo+ICAJLmF0
b21pY19wcmVfZW5hYmxlID0gbXRrX2RzaV9icmlkZ2VfYXRvbWljX3ByZV9lbmFibGUsDQo+ICAJ
LmF0b21pY19wb3N0X2Rpc2FibGUgPSBtdGtfZHNpX2JyaWRnZV9hdG9taWNfcG9zdF9kaXNhYmxl
LA0KPiAgCS5hdG9taWNfcmVzZXQgPSBkcm1fYXRvbWljX2hlbHBlcl9icmlkZ2VfcmVzZXQsDQo+
ICsJLm1vZGVfdmFsaWQgPSBtdGtfZHNpX2JyaWRnZV9tb2RlX3ZhbGlkLA0KPiAgCS5tb2RlX3Nl
dCA9IG10a19kc2lfYnJpZGdlX21vZGVfc2V0LA0KPiAgfTsNCj4gIA0K
