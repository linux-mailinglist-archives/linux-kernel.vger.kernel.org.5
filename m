Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD57DFE26
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjKCCgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKCCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:36:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B65A111;
        Thu,  2 Nov 2023 19:35:57 -0700 (PDT)
X-UUID: b47b47aa79f111ee8051498923ad61e6-20231103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ePOzeCl8VX/mY/xE/fAgOTBa6z5uvuVSBaT9K2raUlA=;
        b=qoLdUerAdRo7rYbGDem6/AO6MJJC1uVKVKyHT7e6WDIpRT9JHRo4szKkvyhSRWWADSkbZD14KBSEE7PWHj0tH85tllmEumlhiNt8PyimgXLu2t6eMbIxwt8EEM0gDmGHXFVED6xLff7JFFSsJeRBa/FZ0UPONNMgvVW+UoDXqyI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:5c6192d7-8ff9-4e20-9182-37ebeee53762,IP:0,U
        RL:0,TC:0,Content:12,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:12
X-CID-META: VersionHash:364b77b,CLOUDID:4bb5f594-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b47b47aa79f111ee8051498923ad61e6-20231103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 309561341; Fri, 03 Nov 2023 10:35:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Nov 2023 10:35:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Nov 2023 10:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c05Xm9MzLsmTehizz13Sq8qWyaZ0qfFzNGaK9GGEV58x7aEn08dU2+9uLTmn0HGDK/SJwbST5gqfYU2/IhZhAH6RFxISD+ciQFodaGogYp0cIl4QEe68TkU7OFumFR6gc5CsMiERLkQPT5grrIZVpUrZXAoF00um3fEJBCnSM3L9ziNvA2CxAINyiPm8ZzpzT1G0LvPx9d63m+UITCYunFmHTsDOQRI6DnBEQXLFSl5mK8Z+c2GOyrpnxxrwDlwegc8kKar3XEhN+IqM6hIyNlRJ+94vkR72KEavHYQd20XiVAO9e/7NZnG2ZE9njxozKRJyH8GWZhOqJ9cSvwIe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePOzeCl8VX/mY/xE/fAgOTBa6z5uvuVSBaT9K2raUlA=;
 b=RKMCtpR3vQ5olwFOI7WqV4GHSBjelvUehmLMmTJ/f6DUmOgro5Crr6uv447O0wUVT9bh7fRmjAQfe29ioCjA5pPQS45yTP6nOQJA/mElGbH5unDkbCxxSkuB+9sXAgWEMa0TfxlOuRUjhy8bKiPc15gvFVAwtQdXaXqGGTQePsUJ//TSxFxlwdjno1pJPKVljKAq/7YKLMlXMJFzX/Pb1RN3735mgt9DIa4K9fxuiPRDQfKiNr975z6NeOPQauNbAkcu17fa2joMZ/ycR7ht09TaVB8lYMt/bvtD2aVnKE/9w8uu+Fzh+Yffiv9egYfz6x0jSkN8D6ngKYUFogddxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePOzeCl8VX/mY/xE/fAgOTBa6z5uvuVSBaT9K2raUlA=;
 b=MKIbq3M20T/UE4V+JhS/98BWjMNDNe526eANLowLLsTExt9mELxo0+0kIHzHTwW8fSdS8r4N7K9SeRL49d7kc/+9aA+flz5w49UcghYk/PgubjBjpsJO2GI343yf9ZezJ6VK4rutTcBL7NFJMGXW8UoHdiuHYqTYQLsiyp0DSYw=
Received: from SEYPR03MB7339.apcprd03.prod.outlook.com (2603:1096:101:142::10)
 by PSAPR03MB5717.apcprd03.prod.outlook.com (2603:1096:301:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 02:35:48 +0000
Received: from SEYPR03MB7339.apcprd03.prod.outlook.com
 ([fe80::741:77b1:856e:f087]) by SEYPR03MB7339.apcprd03.prod.outlook.com
 ([fe80::741:77b1:856e:f087%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:35:48 +0000
From:   =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Thread-Topic: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
Thread-Index: AQHaDU0sQQt9qHQif0Wuzifkics3R7Bn4kyA
Date:   Fri, 3 Nov 2023 02:35:48 +0000
Message-ID: <0561b22db688eda38e63ecc9cec26682cf88cc03.camel@mediatek.com>
References: <20231102052426.12006-1-naomi.chu@mediatek.com>
         <20231102052426.12006-2-naomi.chu@mediatek.com>
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7339:EE_|PSAPR03MB5717:EE_
x-ms-office365-filtering-correlation-id: f93c8cee-9d53-479e-5d8c-08dbdc1596cb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3wzIMpnn8/rMkz/z1uc4QXvc6fL8r6gUNhgvbZ7AswHHwhYI7GOd5+o/KbfdXR7XHFMqXZllk3YITSeKLuvwBFxNvl56dTZ8Sj2ypJiSgTbMZckNHu0SP30D/2LJAE0Ja7BA6DxzU75fp25sEvyanIMenCXPCffbHnCuI/oMbmhmY9ie72C1wBA4quM0LvqrHrmwy/hVizhUN2yNivECyuvQuWDLQKqDcHxjEEvP0Q7cHzry2tnMio/ELUR/Ee4qcdL6kLyk2+qq2Tu6Qja9l/K8Xm2+J6GfFH8TKNdKSgMlmLzb2bwTjHUSdv7vk9Iyv5tQqsKmKTc3BD+9oCdP1jkvS3wXWg57+Yd6aZZOCnW6Mo3LMSVz0FDVqPKskFqZHOAt+uSTRWUCcrir4DT0wopfmp2vtTgANe80NbuS/KSX8s7r5M49KAd00BUSaVbgqUv6XVwmwkrfL6wUO+rE8SSp93IMA1jcZSYwTpolKeClPuafqr1sLvLVXU50txscNRxAmv+Q54M6Bn5dewAdnsAK8g4CJAux32dL467Z9GGwKDRNL5s5bO7QaMIT2niu1VFIAS5uKZyokBh0eVzASURKZk0myDsElL2pNhC47Fncbv5MRT7q2DVLSdvTncaaTmq6ZPg1wi1Q627jpfRH6gAGHo95td3XZFDBB0pmBwtW1Yy8ARjlZpbzFya+WAJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(6512007)(2616005)(478600001)(6506007)(71200400001)(8676002)(7416002)(83380400001)(2906002)(5660300002)(41300700001)(110136005)(91956017)(66946007)(76116006)(4326008)(66556008)(8936002)(66446008)(6486002)(66476007)(64756008)(107886003)(316002)(54906003)(38070700009)(38100700002)(921008)(122000001)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2tZak14bG4vRlYraWtQdzR0MTY1U3p4ZmdsdFovaDZtbTdiYUd5K2dpeVlr?=
 =?utf-8?B?REpYSkR1aUV0R2Rod2xYb0hPVG11ZWl6b05KZzl5c0tPSStCWExvNGMyU21Z?=
 =?utf-8?B?NzhCalQ1U2t0aUY3THhZaWU5d09rd3lRYUNENEcwM3hFQVlQOUlrSm1xZTh5?=
 =?utf-8?B?UlNlQ1o3VWs2eEZKVWh2WXh3d25yMDdLQ3pNazdydWdqWmR6MXRoN3pBWWhk?=
 =?utf-8?B?eVYvQVBYalFaRDNXcnJxTmVhMitlVEZWOFdsOXFVSTRoWmtIcXppNitMUjJr?=
 =?utf-8?B?VGFidjI0OHRFeUJ5WUlvQkNacVlBTFdaam4rQ05JREdRYm9tNTRxeER0UURj?=
 =?utf-8?B?WTlNNHg1cUdybTFoSW5zMzNSTDYwbWxvT200V3FPRG02RmhHZk9RRnlvaE5h?=
 =?utf-8?B?MXF3ZDNtR1JGbHpPUnRTc1NUYitKb0FpY0dTZjdXemo1ZWc4QVk3VDVyRFI2?=
 =?utf-8?B?b0RKN0o4dXltckFIMGl2dTR5eGVoNlpHY3NvU3hML2dvTTk5TTJKeU1DTE1O?=
 =?utf-8?B?VzVMZTE2OWpPWXFkSitRTzlpWVFGSGxaYjBEdXJ4UWgzc2xoaTZKSUw3OENn?=
 =?utf-8?B?MnNhc1NJakVYb2RXQSs0LzlmdEJHTnZ3blhLUDErdHpDclU2Tm84a0VmUWEy?=
 =?utf-8?B?VzRiUldRQ2ZzbUtSeVB0VDBURmluQmZvcVREUEFMVk94cEFIMzJNTVErcUov?=
 =?utf-8?B?cGVrUXZibWsvektTcVE3d2ozOC9KMjRzcENoZzBiRm0yTVlXQjUrczdianZV?=
 =?utf-8?B?djI4UUI0anJCZStqcC9SMU94QTRQRmhCbkozejlxNVFyUFk3WHRaSzJkMmZl?=
 =?utf-8?B?VzU3ZkwxUjJUR2JHU0pmWDhkbnNzajRpMmt1QXVnWjhpU0Y3blVxOC92UnlF?=
 =?utf-8?B?Y2JBZWFCOVBzMGtuaVFvY3R0MnJKSkVZQUpEcGp0OE1FYWhoRHZncGNYL1Qx?=
 =?utf-8?B?VlFiZC9oSUpiWTI3T29yejBZSDErU3VkdERhSkRoT3lNdm9vaHFkVm42VVU1?=
 =?utf-8?B?K0xOSHhBbHJwSzBUcG9uMGc2VklSVlovSXN6N0o1dkphN0xUWFVrV05tbzVU?=
 =?utf-8?B?dVh2WHRDTi9nelFZdVlzSGViK2VIN2s4dlA3QWFCREx5UTBrQm9Ha2dKODNk?=
 =?utf-8?B?RGtXQUtaOVNxWHlGKzluUTdKRzdQcEJWeGR2eGdjYzJQMVZwNHVrTXlqMitQ?=
 =?utf-8?B?U2RRaHZ0bkJ1Z2UvNGV2UUtuZmN3N3E5RDYzaWEyeldXL1J2WjFlYm5VWTFs?=
 =?utf-8?B?dGl2WE8wa21zTytWeEx0SXkrdUJmbEFCTHdSSkVzU0h4OC9qZU16c0loU0Zx?=
 =?utf-8?B?SWhCVVdVajNxM3VXbU5JZ3FPd28weHl6VUlBZkpzYVB0VXVlSFd3UlVHcjhI?=
 =?utf-8?B?M3ZxcS9GaFlLMW44SHE0T2pabWw2NVRWZWR1Skl6aTdZQUJlR2FEbnI5R0pG?=
 =?utf-8?B?d1g0R3pCN2VvUEVFREtDUVRTVmhNU2Z4UkpYN0RYS3FlVThhVGFlSGRIWjVr?=
 =?utf-8?B?TUpTMDQydVFyb2dRbnErejN5ZTcvUUhkNmFsSjdYUUNXeVVFSUpUUzNtNnZl?=
 =?utf-8?B?VWU0N200S0xNb0E0SVQ3L2wzZWpORkV6T0psZ0xtZUNVL1UvcmhudDQvTmR3?=
 =?utf-8?B?R01FME9LeVhaWGFNUVZFaTVGQ1ljRWw0UElGWkgydmVNRmZQa2NMRm9GWGZ4?=
 =?utf-8?B?U09NM1JvR213RlpUWktZQUozQ3JVVjVFZmFtWGk5T2Q3bkRaQlhHVmY4OGI0?=
 =?utf-8?B?YmtDSVhINXdWeU5PRjFtZXJWMExoTTJPRE5QcFBBQTlSNStRd2c4RXJleExO?=
 =?utf-8?B?dStvOTZDdXk1TUdzRjl2OE1JMEtvKzJGcGhFZnBOcVdUQkNVQ0h6aWZTc2o1?=
 =?utf-8?B?TG5sdXIwUFRiWjFCS1NUSm5aM3ZIRjFEYU42SngrRzRGUzVRSXVtcTdMNTBI?=
 =?utf-8?B?NG90ajdaRzc5Z2c0VFJVSVI4QWZKcnIzM0YwK1lrMW82TXZQTVUzdmZSM2gx?=
 =?utf-8?B?UlJoUEc5R0ZjcklkQWU3NXJ2N1JuVmJvRFVsdS9wWElVd1hrZklBcTgwa2N2?=
 =?utf-8?B?anhUZTAxWHEzN21RUUhXNDJBKzgwekh3S1JHWGw5UUQ3a0o4L0taS0padFU0?=
 =?utf-8?B?Nm5yQWZCTmM3V0VKY3Mxc2lnRjhDSmhtYlYyb2JLWHJaTHQ5V0NvbjdRUzBV?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E1D448149B1B642B742DDC7C72EACFA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93c8cee-9d53-479e-5d8c-08dbdc1596cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 02:35:48.4911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAUX/B32ewbeO1/1cTpC/nAtZF3VLnlLYP7+u/DOIOwRydV7QHvPNelWBUtHgPbcyJsa5XdffTAMK63HsQ3fj2i9U9CuzMa1abpuEzQoW9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5717
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTAyIGF0IDEzOjI0ICswODAwLCBuYW9taS5jaHVAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBOYW9taSBDaHUgPG5hb21pLmNodUBtZWRpYXRlay5jb20+DQo+IA0K
PiBUaGUgVUZTSENJIDQuMCBzcGVjaWZpY2F0aW9uIG1hbmRhdGVzIHRoYXQgdGhlcmUgc2hvdWxk
IGFsd2F5cyBiZSBhdA0KPiBsZWFzdCBvbmUgZW1wdHkgc2xvdCBpbiBlYWNoIHF1ZXVlIGZvciBk
aXN0aW5ndWlzaGluZyBiZXR3ZWVuIGZ1bGwNCj4gYW5kDQo+IGVtcHR5IHN0YXRlcy4gRW5sYXJn
ZSB0aGUgYGh3cS0+bWF4X2VudHJpZXNgIHRvIGBEZXZpY2VRdWV1ZURlcHRoICsxYA0KPiB0byBh
bGxvdyBVRlNIQ0kgNC4wIGNvbnRyb2xsZXJzIHRvIGZ1bGx5IHV0aWxpemUgTUNRIHF1ZXVlIHNs
b3RzLg0KPiANCj4gRml4ZXM6IDQ2ODJhYmZhZTJlYiAoInNjc2k6IHVmczogY29yZTogbWNxOiBB
bGxvY2F0ZSBtZW1vcnkgZm9yIE1DUQ0KPiBtb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogTmFvbWkg
Q2h1IDxuYW9taS5jaHVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdWZzL2NvcmUv
dWZzLW1jcS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMg
Yi9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYw0KPiBpbmRleCAyYmE4ZWMyNTRkY2UuLjVjNzVh
YjlkNmJiNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMNCj4gKysr
IGIvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMNCj4gQEAgLTQzNiw3ICs0MzYsNyBAQCBpbnQg
dWZzaGNkX21jcV9pbml0KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICANCj4gIAlmb3IgKGkgPSAw
OyBpIDwgaGJhLT5ucl9od19xdWV1ZXM7IGkrKykgew0KPiAgCQlod3EgPSAmaGJhLT51aHFbaV07
DQo+IC0JCWh3cS0+bWF4X2VudHJpZXMgPSBoYmEtPm51dHJzOw0KPiArCQlod3EtPm1heF9lbnRy
aWVzID0gaGJhLT5udXRycyArIDE7DQo+ICAJCXNwaW5fbG9ja19pbml0KCZod3EtPnNxX2xvY2sp
Ow0KPiAgCQlzcGluX2xvY2tfaW5pdCgmaHdxLT5jcV9sb2NrKTsNCj4gIAkJbXV0ZXhfaW5pdCgm
aHdxLT5zcV9tdXRleCk7DQo+IC0tIA0KPiAyLjE4LjANCj4gDQoNClJldmlld2VkLWJ5OiBDaHVu
LUh1bmc8Y2h1bi1odW5nLnd1QG1lZGlhdGVrLmNvbT4NCg==
