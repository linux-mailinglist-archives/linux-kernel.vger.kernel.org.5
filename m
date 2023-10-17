Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408407CBF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjJQJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjJQJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:36:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5873A2;
        Tue, 17 Oct 2023 02:36:37 -0700 (PDT)
X-UUID: a7e95ca86cd011eea33bb35ae8d461a2-20231017
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=78zvHmVJDqPh6bKsTWvw2eU3Qjh+vk0JFAZ4tDlj2KI=;
        b=l0C3voWlcmsVxq9oqmZWVnT1sBQqJCyId31ZNWdogsSEDnrLBclDPrgzMD+ill5qTWOvL6+H+DOhZZLzXwNYm4EsVfXccBsxRfY8npnaomc8+dvoUNQ5sa3tZvjvw0nCKAaUur35mOf7WshBuSxPExBNW4oppc2jBvRlg20ymFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:f0164dd3-deb0-4607-bc57-4a06f9bd143a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:68ca07c0-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a7e95ca86cd011eea33bb35ae8d461a2-20231017
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 82252301; Tue, 17 Oct 2023 17:36:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Oct 2023 17:36:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Oct 2023 17:36:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0D4kbuR/Gofwt132lwHB/1iDOkWoaJ95g7qNZVHcWSTXJWSdfYHtHwZ3HSxmaezHhJiraAIjpqXwp7QhST3FQcqlHzgXUuz10r0kYOYteKJ2KznMbrchNRd04CiYA4j0RsALK4Yc7Vfqys0ACB8VJ1VekN/kuM49NFRR4ERJF7fxfjDoG6enUrjWVGo84mFrlQyPxjExguUX9lZZrAT58vaGAbRKs+ISohTUKRfn7HOjKIMptaKBaE5K2nReJqH0SV9C2FGp+EGJWmV2lf1EHaHSyL7ap+Aw05a8q1zZPlTbZJlLcFua1oz8oDEEzBw1+ueBCmgqVlIoRg8YzqzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78zvHmVJDqPh6bKsTWvw2eU3Qjh+vk0JFAZ4tDlj2KI=;
 b=ECySybcioEapzJO0n+/3PNenfTKoF6xPf5TJwMjFbL8HsmrfSTTmNJ2Z/vknkQqHb0pGd69t3aX+iIsUAD/xlpBmyvqQZ33ux/YwWxTpYMX3ASSFbNtCiaTzkqZ3pCuDQhNIu6tt2jWrb0CFfz/Lcu5Nav8T/vXttDRdU3H6uHXM5s/UTpHTM0k1tsaq5TetYi7bA3sOoXs7LLxL5WrMuNK5oAsg3OMhGdghsq82sjR/G+opTtHvsFQzmN4mNevgC+5HR1BXGKX54uPC462Ur7yDbCiZNwWNMrXbfLSfOpRjeQJxw3hEPN4qgYaTu4+qmtPRC16xuXQdtoYNjW2yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78zvHmVJDqPh6bKsTWvw2eU3Qjh+vk0JFAZ4tDlj2KI=;
 b=sItE9wKwuwymFRxtldDEgz7f1zSedQkyY64MKeAHSdkp+ytpz8vBw68fCVLqHn37lmVNEDUzaMXPzvaY8DBDpYuGL5kwDu2BxR/VhDr3VXAHzX+ZBFrP+vzd96mxp9w5iFq1PzelSrUZ6gajC9BimTP/NfBeu0gCmohgRD6+CDU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7637.apcprd03.prod.outlook.com (2603:1096:400:41f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 09:36:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:36:28 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "johnson.wang@mediatek.corp-partner.google.com" 
        <johnson.wang@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v8 17/23] drm/mediatek: Support MT8188 Padding in display
 driver
Thread-Topic: [PATCH v8 17/23] drm/mediatek: Support MT8188 Padding in display
 driver
Thread-Index: AQHaAB1FF3SJV5hojUez30lhqx2z+rBNupKA
Date:   Tue, 17 Oct 2023 09:36:28 +0000
Message-ID: <185a903fa3d2e99d02c35cb167f71955afd21e6c.camel@mediatek.com>
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
         <20231016104010.3270-18-shawn.sung@mediatek.com>
In-Reply-To: <20231016104010.3270-18-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7637:EE_
x-ms-office365-filtering-correlation-id: 42c77c68-45be-4d10-30d4-08dbcef489fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5DzgiQrnI+ry+l1G+4v4jD95w95BL0GAxuQxMeTp7cTrFQFyZIFNMunbizYKNj87amkfseI5bUiaShJPAwyah5YqaGSjQyY4/R+jVLkaxNhLG66oinK9KuoZZ3pXIX6cm48j5D0v+secIRtf32iFN9JwDpYFrBvyK6cIV7XVWFJDLc78rXIftd6/oGqgINCBm6WjDpsPxDO8XU8CBDQXSdeh7YimOWsnnpQzc8GammSZYMQJB9PHZrdbqWK+448e3xfDv/yaM4b1nHkomaSWZ5tRqrhN0+vdsyhitbCQ3EQjje9FPKDvW5jqblH+cmKg+9N4TbRTQvHgAHC5sL15WdplpyjJUYyspc/n27w7WjcSZIjCjF1LxsRs7Y4MDcF/P5ZjqfnRlolU+zyhj1WC3Ox8bvqrExkmSOx6c6ieOlTaJlDRk8t9k4Qvrjv0GxxX4k5HXA6zRq1HA12qhvoYK2b4CAT9NghNEhZZcgre8uBGhYyeurO5x/dCMLnhIIFDQV39/NPF2BX/26bEHPZNmbbEqkqVO0Ql6BJajTiDEmA3nwO0b7LP1DHwXtE4ko/PZs7hCoZPcx1MnWhjNZsDpHYY25WNysqhJal7qWB13syPHGF/ehrvCihTGMbdb7kMiutTRq7eGQ5myLpk5U7bctiCljJmEnz4ofJNibIxcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(26005)(38070700005)(8676002)(8936002)(4326008)(71200400001)(66899024)(38100700002)(5660300002)(83380400001)(122000001)(41300700001)(478600001)(2906002)(6486002)(86362001)(4001150100001)(7416002)(110136005)(85182001)(316002)(6512007)(6506007)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUpFRFd2Z0pOa3RQUFpuWkZKYzY5VGFZMndJL2VQa3ZibFhCVE54d3lUclZz?=
 =?utf-8?B?UUJDY21hRENqTU4yRDhoWVZ3bE9uQzFRMnZZNzZ4U2VYZzhyWTRPQ3pMSXM0?=
 =?utf-8?B?aG03WHUrOVF4dmNNdVpJaitMbGJWa2ZRc2YxWHAzL2tqelBzVnJuR3p2c2Zo?=
 =?utf-8?B?UWR0S3hsTkJYbldHa0tGK1J2NTZxRlVFVHRLWTRBa1BjVDhGTEpZYUNZUktH?=
 =?utf-8?B?UFgzZ1AraEhPVnZHTHl3VmJxYkliY1NDTHZEWVJqUEEzOFdOR0JOeG0wTEwy?=
 =?utf-8?B?TFRlNDdpUUNQNzNWd0V3V0xIaVU2RS9yTGg5eTNrSHd4ZEJEUHQ4QTBnMGVJ?=
 =?utf-8?B?MXQwbEwyUFpoQmNickYwVEF5QjJUUnk1U0o1RVZTY0dKUzVuSTRRVXp2ZGJ1?=
 =?utf-8?B?VGN6Q2dxckNyamdaVGkrSmhPN3RrWXR5SGNRQ1FJUTViWU9sNm5hdnI4TXVa?=
 =?utf-8?B?b3dsTC9yK3NjUzZoeExoWEFsUDE2QjBZbDY2WWxBMFlKTEY5TmJvZnJkaGRL?=
 =?utf-8?B?dFJFMnRxcENidi9QaWlvSzB5MHV6WjlGUDdxTzd1VFhvUS92S2xadjY4ZUxU?=
 =?utf-8?B?a2RTb2FqQitxM0FXWjZ6bzBIa3Yzay9ubXdyVXNYN1VqdU9YWmt6V1JiOTgx?=
 =?utf-8?B?YXVLYlIrUFJoWFBoNGh2WHlsVlV6ZzlMa2FQMk9Pdk5URHZidldNKzdmdGJr?=
 =?utf-8?B?Und2M0hjZGVhVG9OaTlSbXRlYWdkK1FHMkxBSEo3S09xKzhKdm5IWklkdDZu?=
 =?utf-8?B?WGwyM29KMkR2RjIxRncyU1dDYjNxTHgrWXVac3o4WGlrWjRSWTF1cUZDL2xm?=
 =?utf-8?B?NHNmU29ILzBON2R0R0Y2M25jNjBMVUsxeDYyd0ZsL2RtYzhkYVFYU25pTHZh?=
 =?utf-8?B?MXRxVk12RUtRZEpzNytaVmFOaVpFZFEvRW8rcHM0UjZYeHZ2eDRNcGhtbldz?=
 =?utf-8?B?NTA2VGJRVjVZVFluMkl0ZUE0Z2VVUDloOVpvQ2ZCZ2pwSGd6NDRhTi9NNHl5?=
 =?utf-8?B?cEFTdW5UZWN6amNHOFdGVWtuQnB3VmtzOExuUEhDZFdvbzV6VXd2b1M5WDZ6?=
 =?utf-8?B?QVRjR3kzMHRaditRbFVaSEZGWTIxR3VWUk1MeXVmblVGejdoS3NiYzlzQmlS?=
 =?utf-8?B?NVBNOFkrQ2ZDZC91OGMvbGFLNFBRVmxKY3BZejJJWEpIeDRTbWd1ZFpCZEs2?=
 =?utf-8?B?dTF6dkloVFpGK2ZVd0FuV3k3NmQ1OWFwaDFkQkM4aThscVV2NzZRY0RCOG9z?=
 =?utf-8?B?NDkzK1V4K3RkNXUwR0trR2xvNlhJWDBLY1JFZjhrdnFaQXMraWRDRllMc2RM?=
 =?utf-8?B?c2VLU3kvR3BqZ1dUajdxSk9JQmlLbFZ5dTNtOFJMbDhtNi90S1FLMXlTSy80?=
 =?utf-8?B?YVVQalNqd1g2UDRPejZKZVhNZ0NzWVBRTEI1ditwNEgyd3FvTC9yYnRhZVVD?=
 =?utf-8?B?Z214bmd4YjluNWFqZXc0c3JtWVRreWZOSHQxbWpiUWVzVng2OHM1Zm9LOU5x?=
 =?utf-8?B?YkFxbE5ROW1pTlJQbk9QTHJXb29QUDJyRkdjL1M3UFd4WHhlaHc1WWdIeW9z?=
 =?utf-8?B?NkVBanprQVFVVEhWTDUvc3kwdUxFcDNkaWhjSTVzOStpRDJHcXphYU1ZNEVh?=
 =?utf-8?B?dG5KRGJINTlndnl6ZHY5eUEyVUlxK0dwTTBuN3k3Njl0alJLSUV0TkdXS1la?=
 =?utf-8?B?SGlydEZzQmRDWkxtUGtIMDVwZ0dxSFRta25uQ0ZrNlJ1RzI2OWNRNndTbzg2?=
 =?utf-8?B?NENYOWZDT2NlSERDV3Z1QWlVQVVHYWdFRmQ3bkJ1a3BBUFpZZC82cjlvcjF4?=
 =?utf-8?B?QkREL1AvSlBydzBBNVlmR2FoaFpNWFZuaVBRQ0NZMllkSmtJMEdZd0ZmTzZz?=
 =?utf-8?B?L2N2Qm8wT2VyWHZBR3ZIUjhKcDVwM3A3SnpWNVhwdWI1K24raVZzcEVoK3pB?=
 =?utf-8?B?MGtVY3NnMXRQaXBMemNPV2l0MjJzL0ZJN0g1OUhNeE5QUVUyUUw3YmZYVi9L?=
 =?utf-8?B?TEUvZGU5Z1A0V0FxWW5MaEFYelR1WEV2U0lxdEY0bFBqNjk5bElOcS9VRkVi?=
 =?utf-8?B?WHp3MWpmaGFXYlRrNWo5aFloQ3M3K3M5dTF3c3EvUGY0ZlZOMk50WDMwRmZN?=
 =?utf-8?Q?on2ZjRnGGwFWYC7gxvcshlH1J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E4A305856DC164AB4113C37DC897ED6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c77c68-45be-4d10-30d4-08dbcef489fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:36:28.5299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0H9FbjPKLbdqkjpoEbqpvr0CvA7WWjkfM+jj3L8wAR181Lli5C1M1nWhQpn1laY6XgCa5V1eZo3OoOT6ue90yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7637
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMTAtMTYgYXQgMTg6NDAgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFBhZGRpbmcgaXMgYSBuZXcgZGlzcGxheSBtb2R1bGUg
b24gTVQ4MTg4LCBpdCBwcm92aWRlcyBhYmlsaXR5DQo+IHRvIGFkZCBwaXhlbHMgdG8gd2lkdGgg
YW5kIGhlaWdodCBvZiBhIGxheWVyIHdpdGggc3BlY2lmaWVkIGNvbG9ycy4NCj4gDQo+IER1ZSB0
byBoYXJkd2FyZSBkZXNpZ24sIE1peGVyIGluIFZET1NZUzEgcmVxdWlyZXMgd2lkdGggb2YgYSBs
YXllcg0KPiB0byBiZSAyLXBpeGVsLWFsaWduLCBvciA0LXBpeGVsLWFsaWduIHdoZW4gRVRIRFIg
aXMgZW5hYmxlZCwNCj4gd2UgbmVlZCBQYWRkaW5nIHRvIGRlYWwgd2l0aCBvZGQgd2lkdGguDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgfCAgIDMgKy0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCB8ICAgNCArDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgfCAgIDEgKw0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmggIHwgICAyICstDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX3BhZGRpbmcuYyAgfCAxNjANCj4gKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE2OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGFk
ZGluZy5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2Vm
aWxlDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IGQ0ZDE5
M2Y2MDI3MS4uNWU0NDM2NDAzYjhkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxl
DQo+IEBAIC0xNiw3ICsxNiw4IEBAIG1lZGlhdGVrLWRybS15IDo9IG10a19kaXNwX2FhbC5vIFwN
Cj4gIAkJICBtdGtfZHNpLm8gXA0KPiAgCQkgIG10a19kcGkubyBcDQo+ICAJCSAgbXRrX2V0aGRy
Lm8gXA0KPiAtCQkgIG10a19tZHBfcmRtYS5vDQo+ICsJCSAgbXRrX21kcF9yZG1hLm8gXA0KPiAr
CQkgIG10a19wYWRkaW5nLm8NCj4gIA0KPiAgb2JqLSQoQ09ORklHX0RSTV9NRURJQVRFSykgKz0g
bWVkaWF0ZWstZHJtLm8NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Rydi5oDQo+IGluZGV4IGJmMDZjY2I2NTY1Mi4uZTJiNjAyMDM3YWMzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xNTksNCArMTU5LDggQEAg
dm9pZCBtdGtfbWRwX3JkbWFfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gc3RydWN0IG10
a19tZHBfcmRtYV9jZmcgKmNmZywNCj4gIGNvbnN0IHUzMiAqbXRrX21kcF9yZG1hX2dldF9mb3Jt
YXRzKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICBzaXplX3QgbXRrX21kcF9yZG1hX2dldF9udW1f
Zm9ybWF0cyhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgDQo+ICtpbnQgbXRrX3BhZGRpbmdfY2xr
X2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfcGFkZGluZ19jbGtfZGlz
YWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfcGFkZGluZ19zdGFydChzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiArdm9pZCBtdGtfcGFkZGluZ19zdG9wKHN0cnVjdCBkZXZpY2Ug
KmRldik7DQo+ICAjZW5kaWYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2
LmMNCj4gaW5kZXggY2RjZTE2NWMwOTJlLi42MmU2ZTk3ODU0NDMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC0xMDI1LDYgKzEwMjUsNyBAQCBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciAqIGNvbnN0DQo+IG10a19kcm1fZHJpdmVyc1tdID0g
ew0KPiAgCSZtdGtfZHNpX2RyaXZlciwNCj4gIAkmbXRrX2V0aGRyX2RyaXZlciwNCj4gIAkmbXRr
X21kcF9yZG1hX2RyaXZlciwNCj4gKwkmbXRrX3BhZGRpbmdfZHJpdmVyLA0KPiAgfTsNCj4gIA0K
PiAgc3RhdGljIGludCBfX2luaXQgbXRrX2RybV9pbml0KHZvaWQpDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oDQo+IGluZGV4IDhkY2E2OGVhMWI5NC4uZDJlZmQ3MTU2
OTlmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
aA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiBAQCAt
NzIsNSArNzIsNSBAQCBleHRlcm4gc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfZHBpX2RyaXZl
cjsNCj4gIGV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19kc2lfZHJpdmVyOw0KPiAg
ZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX2V0aGRyX2RyaXZlcjsNCj4gIGV4dGVy
biBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19tZHBfcmRtYV9kcml2ZXI7DQo+IC0NCj4gK2V4
dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19wYWRkaW5nX2RyaXZlcjsNCj4gICNlbmRp
ZiAvKiBNVEtfRFJNX0RSVl9IICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX3BhZGRpbmcuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGFk
ZGluZy5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmEy
ZTdmYzljN2JkDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19wYWRkaW5nLmMNCj4gQEAgLTAsMCArMSwxNjAgQEANCj4gKy8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIw
MjMgTWVkaWFUZWsgSW5jLg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ICsNCj4gKyNpbmNs
dWRlICJtdGtfZGlzcF9kcnYuaCINCj4gKyNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNp
bmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICsNCj4gKyNkZWZpbmUgUEFERElOR19DT05U
Uk9MX1JFRwkweDAwDQo+ICsjZGVmaW5lIFBBRERJTkdfQllQQVNTCQkJQklUKDApDQo+ICsjZGVm
aW5lIFBBRERJTkdfRU5BQkxFCQkJQklUKDEpDQo+ICsjZGVmaW5lIFBBRERJTkdfUElDX1NJWkVf
UkVHCTB4MDQNCj4gKyNkZWZpbmUgUEFERElOR19IX1JFRwkJMHgwOCAvKiBob3Jpem9udGFsICov
DQo+ICsjZGVmaW5lIFBBRERJTkdfVl9SRUcJCTB4MGMgLyogdmVydGljYWwgKi8NCj4gKyNkZWZp
bmUgUEFERElOR19DT0xPUl9SRUcJMHgxMA0KPiArDQo+ICsvKioNCj4gKyAqIHN0cnVjdCBtdGtf
cGFkZGluZyAtIGJhc2ljIGluZm9ybWF0aW9uIG9mIFBhZGRpbmcNCj4gKyAqIEBjbGs6IENsb2Nr
IG9mIHRoZSBtb2R1bGUNCj4gKyAqIEByZWc6IFZpcnR1YWwgYWRkcmVzcyBvZiB0aGUgUGFkZGlu
ZyBmb3IgQ1BVIHRvIGFjY2Vzcw0KPiArICogQGNtZHFfcmVnOiBDTURRIHNldHRpbmcgb2YgdGhl
IFBhZGRpbmcNCj4gKyAqDQo+ICsgKiBFdmVyeSBQYWRkaW5nIHNob3VsZCBoYXZlIGRpZmZlcmVu
dCBjbG9jayBzb3VyY2UsIHJlZ2lzdGVyIGJhc2UsDQo+IGFuZA0KPiArICogQ01EUSBzZXR0aW5n
cywgd2Ugc3RvcmVkIHRoZXNlIGRpZmZlcmVuY2VzIGFsbCB0b2dldGhlci4NCj4gKyAqLw0KPiAr
c3RydWN0IG10a19wYWRkaW5nIHsNCj4gKwlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiArCXZvaWQgX19p
b21lbQkJKnJlZzsNCj4gKwlzdHJ1Y3QgY21kcV9jbGllbnRfcmVnCWNtZHFfcmVnOw0KPiArfTsN
Cj4gKw0KPiAraW50IG10a19wYWRkaW5nX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiArew0KPiArCXN0cnVjdCBtdGtfcGFkZGluZyAqcGFkZGluZyA9IGRldl9nZXRfZHJ2ZGF0YShk
ZXYpOw0KPiArDQo+ICsJcmV0dXJuIGNsa19wcmVwYXJlX2VuYWJsZShwYWRkaW5nLT5jbGspOw0K
PiArfQ0KPiArDQo+ICt2b2lkIG10a19wYWRkaW5nX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKw0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShwYWRkaW5nLT5jbGsp
Ow0KPiArfQ0KPiArDQo+ICt2b2lkIG10a19wYWRkaW5nX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gKw0KPiArCXdyaXRlbChQQURESU5HX0VOQUJMRSB8IFBBRERJTkdfQllQQVNT
LA0KPiArCSAgICAgICBwYWRkaW5nLT5yZWcgKyBQQURESU5HX0NPTlRST0xfUkVHKTsNCj4gKw0K
PiArCS8qDQo+ICsJICogbm90aWNlIHRoYXQgZXZlbiB0aGUgcGFkZGluZyBpcyBpbiBieXBhc3Mg
bW9kZSwNCj4gKwkgKiBhbGwgdGhlIHNldHRpbmdzIG11c3QgYmUgY2xlYXJlZCB0byAwIG9yDQo+
ICsJICogdW5kZWZpbmVkIGJlaGF2aW9ycyBjb3VsZCBoYXBwZW4NCj4gKwkgKi8NCj4gKwl3cml0
ZWwoMCwgcGFkZGluZy0+cmVnICsgUEFERElOR19QSUNfU0laRV9SRUcpOw0KPiArCXdyaXRlbCgw
LCBwYWRkaW5nLT5yZWcgKyBQQURESU5HX0hfUkVHKTsNCj4gKwl3cml0ZWwoMCwgcGFkZGluZy0+
cmVnICsgUEFERElOR19WX1JFRyk7DQo+ICsJd3JpdGVsKDAsIHBhZGRpbmctPnJlZyArIFBBRERJ
TkdfQ09MT1JfUkVHKTsNCj4gK30NCj4gKw0KPiArdm9pZCBtdGtfcGFkZGluZ19zdG9wKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3BhZGRpbmcgKnBhZGRpbmcgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCXdyaXRlbCgwLCBwYWRkaW5nLT5yZWcgKyBQ
QURESU5HX0NPTlRST0xfUkVHKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtfcGFkZGlu
Z19iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZQ0KPiAqbWFzdGVyLCB2b2lk
ICpkYXRhKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBt
dGtfcGFkZGluZ191bmJpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ICpt
YXN0ZXIsIHZvaWQgKmRhdGEpDQo+ICt7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgY29tcG9uZW50X29wcyBtdGtfcGFkZGluZ19jb21wb25lbnRfb3BzID0gew0KPiArCS5iaW5k
CT0gbXRrX3BhZGRpbmdfYmluZCwNCj4gKwkudW5iaW5kID0gbXRrX3BhZGRpbmdfdW5iaW5kLA0K
PiArfTsNCj4gKw0KPiArc3RhdGljIGludCBtdGtfcGFkZGluZ19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5k
ZXY7DQo+ICsJc3RydWN0IG10a19wYWRkaW5nICpwcml2Ow0KPiArCXN0cnVjdCByZXNvdXJjZSAq
cmVzOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6
ZW9mKCpwcml2KSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFwcml2KQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCXByaXYtPmNsayA9IGRldm1fY2xrX2dldChkZXYsIE5VTEwpOw0KPiAr
CWlmIChJU19FUlIocHJpdi0+Y2xrKSkgew0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBn
ZXQgY2xrXG4iKTsNCj4gKwkJcmV0dXJuIFBUUl9FUlIocHJpdi0+Y2xrKTsNCj4gKwl9DQo+ICsN
Cj4gKwlwcml2LT5yZWcgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZShw
ZGV2LCAwLA0KPiAmcmVzKTsNCj4gKwlpZiAoSVNfRVJSKHByaXYtPnJlZykpIHsNCj4gKwkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gZG8gaW9yZW1hcFxuIik7DQo+ICsJCXJldHVybiBQVFJfRVJS
KHByaXYtPnJlZyk7DQo+ICsJfQ0KPiArDQo+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtf
Q01EUSkNCj4gKwlyZXQgPSBjbWRxX2Rldl9nZXRfY2xpZW50X3JlZyhkZXYsICZwcml2LT5jbWRx
X3JlZywgMCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBn
ZXQgZ2NlIGNsaWVudCByZWdcbiIpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKyNlbmRp
Zg0KPiArDQo+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcHJpdik7DQo+ICsNCj4gKwly
ZXQgPSBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGNvbXBvbmVudF9hZGQoZGV2LCAmbXRrX3BhZGRpbmdf
Y29tcG9uZW50X29wcyk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlwbV9ydW50aW1lX2Rpc2FibGUo
ZGV2KTsNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJmYWlsZWQgdG8gYWRk
DQo+IGNvbXBvbmVudFxuIik7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgbXRrX3BhZGRpbmdfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICt7DQo+ICsJY29tcG9uZW50X2RlbCgmcGRldi0+ZGV2LCAmbXRrX3BhZGRpbmdf
Y29tcG9uZW50X29wcyk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19wYWRkaW5nX2RyaXZlcl9kdF9tYXRjaFtdID0gew0K
PiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXBhZGRpbmciIH0sDQo+ICsJeyAv
KiBzZW50aW5lbCAqLyB9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX3Bh
ZGRpbmdfZHJpdmVyX2R0X21hdGNoKTsNCj4gKw0KPiArc3RydWN0IHBsYXRmb3JtX2RyaXZlciBt
dGtfcGFkZGluZ19kcml2ZXIgPSB7DQo+ICsJLnByb2JlCQk9IG10a19wYWRkaW5nX3Byb2JlLA0K
PiArCS5yZW1vdmUJCT0gbXRrX3BhZGRpbmdfcmVtb3ZlLA0KPiArCS5kcml2ZXIJCT0gew0KPiAr
CQkubmFtZQk9ICJtZWRpYXRlay1wYWRkaW5nIiwNCj4gKwkJLm93bmVyCT0gVEhJU19NT0RVTEUs
DQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IG10a19wYWRkaW5nX2RyaXZlcl9kdF9tYXRjaCwNCj4g
Kwl9LA0KPiArfTsNCg==
