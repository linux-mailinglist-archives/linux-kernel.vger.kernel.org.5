Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B87E13C1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjKENo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKENo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:44:57 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77603CC;
        Sun,  5 Nov 2023 05:44:52 -0800 (PST)
X-UUID: 7b897c9a7be111ee8051498923ad61e6-20231105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Rz2ySUHW2wv48zaD9UAwfRxa5lusRUXvgMoeRkk5C24=;
        b=Evaz10I1NbtTG3pCct1Vw8LZuMqR6Ueb8jfK40iacP7R66us5LRsPFsaEVoXfYaFEBPnzMwPZUaRfvJcpjk2YszYciHUPFB0HQez7F2uKMoDWqmMCxx4z2+a7lSYO7Djw+swHWzSDMqV+1rQwowJZ5bPqA2gNx1zF81SHlCM4Vk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6b1d06f0-48da-4fb4-91fd-eed069e99c45,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:ba51b25f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7b897c9a7be111ee8051498923ad61e6-20231105
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 111069003; Sun, 05 Nov 2023 21:44:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 5 Nov 2023 21:44:45 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 5 Nov 2023 21:44:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrbWeDxASZRBWLtPZUlanRNgbXtdnRPBXiBXbdGDcplKtq81l2pvdDy6CafmsEFYPS2UhkE8xC1nYWqBfZDbN+uSeSN17rvoHxcRX2VZVQZoDz8AbwvkpIf12QQsw+4oH+MNLdV6k+2w8hJIFtfQt98+6mldcQ+QhuVi+8H84/h9lmx4KvoUysweV9uMr272WnrVb8X7GQP9y3H6aGJkAwvT8Jjoyhxd0Jq7B2czCBiIE+UzWo43fDd+DaL/U2GG6zlNwo4MZPx8vlXE8oFb6OrQ+HQKXNw8xar14O3JXznsiOyqSBoRAcPxR1mNPUAcGqa3LQSYYT8x0pAQEIEh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz2ySUHW2wv48zaD9UAwfRxa5lusRUXvgMoeRkk5C24=;
 b=Uy/Q1cKaOpeJh3R7F7t8FqBf8NsJculLay0rIuvIxCY4i7LoO4MnNkdqP2Cs3m+4aXQO+lrCgkMzvaPf48gWrXFbkcu5R0EWH4Q+97oSIQhxfCHeZ0GkZTd2QzOe0hVR5SO3mooHZEwE8JFZ1pAuCvRBw8XK9a/Ik7yDQeHRtHwP5BCz+BM5Hj3vvn2xWWTGCHFhfCDHd//cEz8SY7jFpL9jrGTz2N+3bEgFf6CwSDXAhqcmWVpTTepgbIGl5FY3apaAFe3CBS5HXjFgAp44hSj5ofGp5HLTiHF11wK5On7SJif8OsvydatghCQR1QOzu6FeEKhP5IaTUaHb29p2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz2ySUHW2wv48zaD9UAwfRxa5lusRUXvgMoeRkk5C24=;
 b=BDCMs4ZS5prgyjb/+5vsgHh3cX42TtYD0jkwfioxT6e3/lcMXEZ5JKcLtF91yR0wu0gKGC3Ll6MR18q/3kzwYd1RSkHHTZQMEd61lWR/QhoIEprdgHAx4qs/8YnQiDvcx9md5CDpS4sti+Hj+L35LieaSib1EXHwFjI2gpS1B7M=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5647.apcprd03.prod.outlook.com (2603:1096:400:5d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sun, 5 Nov
 2023 13:44:42 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6954.025; Sun, 5 Nov 2023
 13:44:42 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH v2 00/11] Add mediate-drm secure flow for SVP
Thread-Index: AQHaBWvmI0D7juVVnkOavIrmWYW347BjNIKAgAidGoA=
Date:   Sun, 5 Nov 2023 13:44:42 +0000
Message-ID: <45eaa8a62bdb4a17b443c0ed8b3210a4b3b4a670.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <83ab8f76b48b27a5406a03c50467c968598b23db.camel@mediatek.com>
In-Reply-To: <83ab8f76b48b27a5406a03c50467c968598b23db.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5647:EE_
x-ms-office365-filtering-correlation-id: 96ee1e50-0fea-43aa-3054-08dbde055d23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XW8jJOZBnav7BeRQNxHGRx+PLgmqnMI4Vv2XCdEdzz+jl+iaDr0q1l3L+i9Cwm6izBSnrk22wvzurGOeflDwt1WfncYNbuRRsEeXj98kYPHu8fggfCqYhEvMOjhKneQXTQSk8gY20Fz3doXbAGjbn6xCe4Xv7gQPXchD7gxXnuecTC+9glRUs48Z444xIacIosp80z41Wp6Y0s86pktF6+yUphomEW0oOlCXZdH9uC/KEwlHEsUkslTj8ddyzbrSOpmdhNkQMPww/JevwdoagOeoqWfY7MKa08dCzNPtFVFSSA3RJGoQ+1zRqRKXl8BXfiRzNZbB+2KcC0znxFYdneuMZd9H9VICEGLjMYgxgxCkJu39CYUE/Ap9dbnSVhnB4vhyu/VpbkS+g2z0/qFX4XUnCW1Uy8Cc45GcjickWKGFvMd0CBwGBv1Bk6U36VwfxvMLajU/etNPemLbvbYhbg+cnxnMkvGUozOegVigtoJ4hmtfAmPcrM8bn9lrJ5uUuUr9nHzbVIXm2q7smGjoX57qxSxciIUBkHJmNgjLxibU84zNKVeb2KyBqK010HIylWB5mD/yFIlmht5CxDCexyI9b2I++xUMx/rBmHpw419fcFWw/XKN/PoNq7GlbCXPyGXnDkVyNDSoI09v3cqEHa8OPYdNWa4YOGKQ4wYcpq/ZRHEHTThlyV8EZOiWhDdl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(396003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(2906002)(478600001)(71200400001)(6486002)(4001150100001)(2616005)(38100700002)(26005)(122000001)(38070700009)(86362001)(85182001)(6512007)(6506007)(36756003)(8936002)(8676002)(7416002)(5660300002)(966005)(4326008)(41300700001)(54906003)(66476007)(110136005)(66556008)(316002)(76116006)(66446008)(66946007)(64756008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmF1MTRKYWJEQlRWaks0WWZxdCt3Q0hnQTI2YmN3QUlnSGZ3ZU1zOTlhZU9J?=
 =?utf-8?B?VGZzcHBpUjhHZ05GdEl4Y3ZsKzFiaDhUR2IwbmxOV0JpUC9VbTJQRkRCdTRB?=
 =?utf-8?B?RmpVaEdmdmhTWlRQWHRJdEFMbkozdUN0SHFnQVUwWElOTE1rWnEyV3BadzB5?=
 =?utf-8?B?SkxjU1VYZ0twWW1PYzVKaVRkMkxxMm5tSWFGNGxPZ3RoaDMxQXNTQ3ZMd015?=
 =?utf-8?B?eU9telFpbnh2S0VZNWpOVDVBeUF1M3UxaHp1N3JKQ1RTelp6bHF1aHViWnZW?=
 =?utf-8?B?dXVlbDA2RU5veG04TVQ3VWM2ZS9KRmFuRThnZE1RZ2x1aHFtVWEwZlljOTkv?=
 =?utf-8?B?SDhpY015RWFSQ1B4b1dnRXRPT0hQWUpFeFFTZlVCdWdIK09sZ0RPZVZldzN0?=
 =?utf-8?B?ZUMwNzJOMVBOVlhIWWZ6ZDZTdFZRNHJzS0VOemtGOVZxMWwzVmwxM0hZQ1BH?=
 =?utf-8?B?S0JrM2VFZU1VeDgxQVRZUk1QVFkrZkRSU2hqbXpoS25XZzhkNE4rdVd0Yjcw?=
 =?utf-8?B?K0paNkhGMVgxYUlYbnJhOUZSWDZqR0YwakVIT21VUEh5RWJyaDZCdExsM0sy?=
 =?utf-8?B?RGFaNkE0dGZBVW9MczFpWUZIMWJaSW9ZUlJsaDUxVk9OemV5Mk1GT0dPRSsr?=
 =?utf-8?B?R1V3ZVdYVmJoTU5nL0FoSU80MWd5QkVPNm5meTVrUmNDNXM3SDhtVjFwclVl?=
 =?utf-8?B?MHo3NHIwT2RENHRmUEVjT2U4WmJTaGxzM2l0di9EaHB2V0xDWU00OXoxSmox?=
 =?utf-8?B?eVhVV3lLSmkyNWRXVk9GOFJQMUtaS1FtYXNKVEZvd0dLSTNEUUU4aWVMYk9V?=
 =?utf-8?B?QW5hS1ZzYm9ScE93dlg1UExVOGM0OWw1cGZ1UjNLMU82aDRMQkxEUTM0MXQ3?=
 =?utf-8?B?NGdBZGdBdWZBNWQ1NFpCdjNjMk13N0tmRWNNYUxUbWFoR2o1SEMvYnNxSldO?=
 =?utf-8?B?UldSaW5BQ1BCLzIzWTB0QlJveHlBdHpTbFZKWWxyd2ZKVTVCcDBLWFNjVC83?=
 =?utf-8?B?eVVlQkFqWUZleHRiTGFTaHZpdjRqc0NxSmI3K3FtcmhsWHFjY3pkLzZvTzhy?=
 =?utf-8?B?d0FCYm4zNWF3RHlUdVNKODRxV2g5OWNuTEhrbytzTVdzTmNOZm95YlJCdC9J?=
 =?utf-8?B?U3R2YmtpcEVMblNud1Y3OFFEeGc4eE54U0dvTHZSQjVXY08xeDEramtmblRV?=
 =?utf-8?B?eVNER25mak84VWRiV2kyUHl5SkMzYTVGN0VnK1MzSklVSXgrWmZLdGsyS3dp?=
 =?utf-8?B?TGNxQjFjRlJ4aGNHeVRDb3gyb3loeTY2b3ZZMFVVNTNsRk80MmduM01NY1ZI?=
 =?utf-8?B?djVZQVNwdkJmMk9BVVJzVjNVeG11NGdPVmVTdVc4ZnV4SWY4OW5lZmhuTnR0?=
 =?utf-8?B?RVRUOUZ1Tk9HQzlyNFJFTW9UcXJrVEY0T0NVbTFvUEZ0enBRN0NGaXRGb08r?=
 =?utf-8?B?cys2dHl1K3hFUGZWK0x1QmxzVWZnaVp0OFBMR2EvRUV6cXAyRlhoczI2NFZG?=
 =?utf-8?B?bHNQZTl6c2lHbVlZZklITFh4MEgzcWN5Nml2b0dqdDZmb1k3a2I1ZXROTFNM?=
 =?utf-8?B?UXduWVllZmVZQlVpWUd4Mk5qc1psb1BraGZmeE1ZWkhvdGdGcEg1Q1FRQUtx?=
 =?utf-8?B?UmtsRSs4ek9jWk1odmErTTF0OGIxYmxUUEIvREhZTWdKcSs3aEpWTldjbUVi?=
 =?utf-8?B?K0lLTE1iZXRSKzJjODA1T1NVV25iNC9ray9OcUwyVlluNStabHVWbEFCTWg4?=
 =?utf-8?B?eVEzcWJjV2EwK05vR2dsakIzR1ZiZjB1bytvVDRpb052bU9SRm5ucTA5dHRH?=
 =?utf-8?B?NmlRMk5HWUJjemo2TnhaNmE1N1J0VXk3MzV3c2lRQWJRZmpublJMTVBtcjZD?=
 =?utf-8?B?Y3V3M0lBaGFmV1FBd2xoUjB2Z2lJTk9PREU3WWZBeXluR2JQRmwxL1BHOGpr?=
 =?utf-8?B?eFJTS0hVY0FDN3pqd0RQTFBCZ1htUEFybzlMN25hVnNVczJGRFlpcVQra2hP?=
 =?utf-8?B?NUhOS1lRSVlZYjVNVDRtQXZDS3FFdFFiL0dMQXJPdmM1cUNWeUNpZzdzbW9y?=
 =?utf-8?B?bmw3K29VYkx5R3E5RUw4dnBZaHAyL1Q3NE5IL1JvZnQwOXYzN3BLSFVNWWpH?=
 =?utf-8?B?ZGwvNUN0SWpxaC81bThsNXdHTmxqWUwvN0VNMEhLMTJVeXM3a05MN05CMjN1?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36AD36075CA7B54C8494F679A851B1DD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ee1e50-0fea-43aa-3054-08dbde055d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2023 13:44:42.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu1D0/ysG4BV621g+sRKctEUS+UP8SFsCGV5D14Mv3478NdqjFHbdlR6/15c0OZmlht3jByWHBhGhHvItSN4LRIJBctIxkcLwkr/sCPhqng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5647
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMC0zMSBh
dCAwMjoxMiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAxMjo0NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRoZSBwYXRjaCBzZXJpZXMgcHJvdmlkZXMgZHJtIGRyaXZlciBzdXBwb3J0IGZvciBl
bmFibGluZyBzZWN1cmUNCj4gPiB2aWRlbw0KPiA+IHBhdGggKFNWUCkgcGxheWJhY2sgb24gTWVk
aWFpVGVrIGhhcmR3YXJlIGluIHRoZSBMaW51eCBrZXJuZWwuDQo+ID4gDQo+ID4gTWVtb3J5IERl
ZmluaXRpb25zOg0KPiA+IHNlY3VyZSBtZW1vcnkgLSBNZW1vcnkgYWxsb2NhdGVkIGluIHRoZSBU
RUUgKFRydXN0ZWQgRXhlY3V0aW9uDQo+ID4gRW52aXJvbm1lbnQpIHdoaWNoIGlzIGluYWNjZXNz
aWJsZSBpbiB0aGUgUkVFIChSaWNoIEV4ZWN1dGlvbg0KPiA+IEVudmlyb25tZW50LCBpLmUuIGxp
bnV4IGtlcm5lbC91c2Vyc3BhY2UpLg0KPiA+IHNlY3VyZSBoYW5kbGUgLSBJbnRlZ2VyIHZhbHVl
IHdoaWNoIGFjdHMgYXMgcmVmZXJlbmNlIHRvICdzZWN1cmUNCj4gPiBtZW1vcnknLiBVc2VkIGlu
IGNvbW11bmljYXRpb24gYmV0d2VlbiBURUUgYW5kIFJFRSB0byByZWZlcmVuY2UNCj4gPiAnc2Vj
dXJlIG1lbW9yeScuDQo+ID4gc2VjdXJlIGJ1ZmZlciAtICdzZWN1cmUgbWVtb3J5JyB0aGF0IGlz
IHVzZWQgdG8gc3RvcmUgZGVjcnlwdGVkLA0KPiA+IGNvbXByZXNzZWQgdmlkZW8gb3IgZm9yIG90
aGVyIGdlbmVyYWwgcHVycG9zZXMgaW4gdGhlIFRFRS4NCj4gPiBzZWN1cmUgc3VyZmFjZSAtICdz
ZWN1cmUgbWVtb3J5JyB0aGF0IGlzIHVzZWQgdG8gc3RvcmUgZ3JhcGhpYw0KPiA+IGJ1ZmZlcnMu
DQo+ID4gDQo+ID4gTWVtb3J5IFVzYWdlIGluIFNWUDoNCj4gPiBUaGUgb3ZlcmFsbCBmbG93IG9m
IFNWUCBzdGFydHMgd2l0aCBlbmNyeXB0ZWQgdmlkZW8gY29taW5nIGluIGZyb20NCj4gPiBhbg0K
PiA+IG91dHNpZGUgc291cmNlIGludG8gdGhlIFJFRS4gVGhlIFJFRSB3aWxsIHRoZW4gYWxsb2Nh
dGUgYSAnc2VjdXJlDQo+ID4gYnVmZmVyJyBhbmQgc2VuZCB0aGUgY29ycmVzcG9uZGluZyAnc2Vj
dXJlIGhhbmRsZScgYWxvbmcgd2l0aCB0aGUNCj4gPiBlbmNyeXB0ZWQsIGNvbXByZXNzZWQgdmlk
ZW8gZGF0YSB0byB0aGUgVEVFLiBUaGUgVEVFIHdpbGwgdGhlbg0KPiA+IGRlY3J5cHQNCj4gPiB0
aGUgdmlkZW8gYW5kIHN0b3JlIHRoZSByZXN1bHQgaW4gdGhlICdzZWN1cmUgYnVmZmVyJy4gVGhl
IFJFRSB3aWxsDQo+ID4gdGhlbiBhbGxvY2F0ZSBhICdzZWN1cmUgc3VyZmFjZScuIFRoZSBSRUUg
d2lsbCBwYXNzIHRoZSAnc2VjdXJlDQo+ID4gaGFuZGxlcycgZm9yIGJvdGggdGhlICdzZWN1cmUg
YnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpbnRvIHRoZQ0KPiA+IFRFRSBmb3IgdmlkZW8g
ZGVjb2RpbmcuIFRoZSB2aWRlbyBkZWNvZGVyIEhXIHdpbGwgdGhlbiBkZWNvZGUgdGhlDQo+ID4g
Y29udGVudHMgb2YgdGhlICdzZWN1cmUgYnVmZmVyJyBhbmQgcGxhY2UgdGhlIHJlc3VsdCBpbiB0
aGUgJ3NlY3VyZQ0KPiA+IHN1cmZhY2UnLiBUaGUgUkVFIHdpbGwgdGhlbiBhdHRhY2ggdGhlICdz
ZWN1cmUgc3VyZmFjZScgdG8gdGhlDQo+ID4gb3ZlcmxheQ0KPiA+IHBsYW5lIGZvciByZW5kZXJp
bmcgb2YgdGhlIHZpZGVvLg0KPiA+IA0KPiA+IEV2ZXJ5dGhpbmcgcmVsYXRpbmcgdG8gZW5zdXJp
bmcgc2VjdXJpdHkgb2YgdGhlIGFjdHVhbCBjb250ZW50cyBvZg0KPiA+IHRoZQ0KPiA+ICdzZWN1
cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpcyBvdXQgb2Ygc2NvcGUgZm9yIHRoZSBS
RUUNCj4gPiBhbmQNCj4gPiBpcyB0aGUgcmVzcG9uc2liaWxpdHkgb2YgdGhlIFRFRS4NCj4gPiAN
Cj4gPiBEUk0gZHJpdmVyIGhhbmRsZXMgYWxsb2NhdGlvbiBvZiBnZW0gb2JqZWN0cyB0aGF0IGFy
ZSBiYWNrZWQgYnkgYQ0KPiA+ICdzZWN1cmUNCj4gPiBzdXJmYWNlJyBhbmQgZm9yIGRpc3BsYXlp
bmcgYSAnc2VjdXJlIHN1cmZhY2UnIG9uIHRoZSBvdmVybGF5DQo+ID4gcGxhbmUuDQo+ID4gVGhp
cyBpbnRyb2R1Y2VzIGEgbmV3IGZsYWcgZm9yIG9iamVjdCBjcmVhdGlvbiBjYWxsZWQNCj4gPiBE
Uk1fTVRLX0dFTV9DUkVBVEVfRU5DUllQVEVEIHdoaWNoIGluZGljYXRlcyBpdCBzaG91bGQgYmUg
YSAnc2VjdXJlDQo+ID4gc3VyZmFjZScuIEFsbCBjaGFuZ2VzIGhlcmUgYXJlIGluIE1lZGlhVGVr
IHNwZWNpZmljIGNvZGUuDQo+ID4gDQo+ID4gLS0tDQo+ID4gQmFzZWQgb24gMyBzZXJpZXMgYW5k
IDEgcGF0Y2g6DQo+ID4gWzFdIGRtYS1idWY6IGhlYXBzOiBBZGQgTWVkaWFUZWsgc2VjdXJlIGhl
YXANCj4gPiAtIA0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzgy
Nzc2X187ISFDVFJOS0E5d01nMEFSYnchbUZLeEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdXMC1K
WmVUWlprcXhKZ0I1V0ZiTVR4ZUVqYWxyc2xMckFKM2l3WUY2LWsyNzNqZ3pYS1NRWGNiZ1BVJA0K
PiA+ICANCj4gPiANCj4gPiBbMl0gYWRkIGRyaXZlciB0byBzdXBwb3J0IHNlY3VyZSB2aWRlbyBk
ZWNvZGVyDQo+ID4gLSANCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVz
PTc4MjkyMl9fOyEhQ1RSTktBOXdNZzBBUmJ3IW1GS3hHZnBYTEVGOC1BemhsakdHX04xMmJrLWg3
VzAtSlplVFpaa3F4SmdCNVdGYk1UeGVFamFscnNsTHJBSjNpd1lGNi1rMjczamd6WEtTSVB5Q1F4
SSQNCj4gPiAgDQo+ID4gDQo+ID4gWzNdIHNvYzogbWVkaWF0ZWs6IEFkZCByZWdpc3RlciBkZWZp
bml0aW9ucyBmb3IgR0NFDQo+ID4gLSANCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0
Y2gvMjAyMzEwMTcwNjQ3MTcuMjE2MTYtMi1zaGF3bi5zdW5nQG1lZGlhdGVrLmNvbS9fXzshIUNU
Uk5LQTl3TWcwQVJidyFtRkt4R2ZwWExFRjgtQXpobGpHR19OMTJiay1oN1cwLUpaZVRaWmtxeEpn
QjVXRmJNVHhlRWphbHJzbExyQUozaXdZRjYtazI3M2pnelhLU3JPOGdtYkkkDQo+ID4gIA0KPiA+
IA0KPiA+IFs0XSBBZGQgQ01EUSBzZWN1cmUgZHJpdmVyIGZvciBTVlANCj4gPiAtIA0KPiA+IA0K
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzk1NTAyX187ISFDVFJOS0E5d01n
MEFSYnchbUZLeEdmcFhMRUY4LUF6aGxqR0dfTjEyYmstaDdXMC1KWmVUWlprcXhKZ0I1V0ZiTVR4
ZUVqYWxyc2xMckFKM2l3WUY2LWsyNzNqZ3pYS1Nwb3NEMlJrJA0KPiA+ICANCj4gDQo+IFNlY3Vy
ZSBkaXNwbGF5IGRlcGVuZCBvbiBzZWN1cmUgbW1zeXMuIFJvdXRpbmcgY29udHJvbCBzaG91bGQg
YmUNCj4gc2VjdXJlDQo+IHNvIG1tc3lzIGRyaXZlciBzaG91bGQgaGF2ZSBzb21lIG1vZGlmaWNh
dGlvbiB0aGF0IGNhbGwgaW50byBzZWN1cmUNCj4gd29ybGQgdG8gY2hhbmdlIHJvdXRpbmcuIEFk
ZCBtbXN5cyBzZXJpZXMgaW4gdGhpcyBkZXBlbmRlbmN5IGxpc3QuDQoNClllcywgSSdsbCBtb3Zl
IHRoZSByb3V0ZSBzZXR0aW5ncyB0byB0aGUgc2VjdXJlIHdvcmxkIGZvciB0aG9zZSBTVlANCnN1
cHBvcnRlZCBTb0MuIFRoZSBtbXN5cyBtb2RpZmljYXRpb25zIGFyZSBzdGlsbCBpbiBwcm9ncmVz
cy4gSXQgd2lsbA0KYmUgc2VuZCBhZnRlciBhIGZldyB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpKYXNv
bi1KSC5MaW4NCg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gLS0tDQo+ID4gQ2hhbmdl
IGluIHYyOg0KPiA+IA0KPiA+IDEuIHJlbW92ZSB0aGUgRFJJVkVSX1JETkRFUiBmbGFnIGZvciBt
dGtfZHJtX2lvY3RsDQo+ID4gMi4gbW92ZSBjbWRxX2luc2VydF9iYWNrdXBfY29va2llIGludG8g
Y2xpZW50IGRyaXZlcg0KPiA+IDMuIG1vdmUgc2VjdXJlIGdjZSBub2RlIGRlZmluZSBmcm9tIG10
ODE5NS1jaGVycnkuZHRzaSB0bw0KPiA+IG10ODE5NS5kdHNpDQo+ID4gLS0tDQo+ID4gDQo+ID4g
Q0sgSHUgKDEpOg0KPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgaW50ZXJmYWNlIHRvIGFsbG9jYXRl
IE1lZGlhVGVrIEdFTSBidWZmZXIuDQo+ID4gDQo+ID4gSmFzb24tSkguTGluICgxMCk6DQo+ID4g
ICBkcm0vbWVkaWF0ZWsvdWFwaTogQWRkIERSTV9NVEtfR0VNX0NSRUFURURfRU5DUllQVFRFRCBm
bGFnDQo+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgYnVmZmVyIGNvbnRyb2wgZmxvdyB0
byBtdGtfZHJtX2dlbQ0KPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGlkZW50aWZ5IGZs
YWcgYW5kIGZ1bmN1dGlvbiB0bw0KPiA+IG10a19kcm1fcGxhbmUNCj4gPiAgIGRybS9tZWRpYXRl
azogQWRkIG10a19kZHBfc2VjX3dyaXRlIHRvIGNvbmZpZyBzZWN1cmUgYnVmZmVyIGluZm8NCj4g
PiAgIGRybS9tZWRpYXRlazogQWRkIGdldF9zZWNfcG9ydCBpbnRlcmZhY2UgdG8gbXRrX2RkcF9j
b21wDQo+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQg
Zm9yIG92bA0KPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBw
b3J0IGZvciBvdmxfYWRhcHRvcg0KPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGZsb3cg
c3VwcG9ydCB0byBtZWRpYXRlay1kcm0NCj4gPiAgIGRybS9tZWRpYXRlazogQWRkIGNtZHFfaW5z
ZXJ0X2JhY2t1cF9jb29raWUgYmVmb3JlIHNlY3VyZSBwa3QNCj4gPiBmaW5hbGl6ZQ0KPiA+ICAg
YXJtNjQ6IGR0czogbXQ4MTk1OiBBZGQgc2VjdXJlIG1ib3ggc2V0dGluZ3MgZm9yIHZkb3N5cw0K
PiA+IA0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpICAgICAg
fCAgIDYgKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAg
ICAgIHwgICAzICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
ICAgICAgIHwgIDMxICstDQo+ID4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9h
ZGFwdG9yLmMgICB8ICAxNSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2NydGMuYyAgICAgICB8IDI3NA0KPiA+ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgICAgfCAgIDEgKw0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgMTQgKw0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oICAgfCAgMTMgKw0KPiA+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAgfCAgMTMgKw0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYyAgICAgICAgfCAxMjEg
KysrKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmggICAg
ICAgIHwgIDE2ICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
YyAgICAgIHwgICA3ICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxh
bmUuaCAgICAgIHwgICAyICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBf
cmRtYS5jICAgICAgIHwgIDExICstDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bWRwX3JkbWEuaCAgICAgICB8ICAgMiArDQo+ID4gIGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtf
ZHJtLmggICAgICAgICAgICAgICB8ICA1OSArKysrDQo+ID4gIDE2IGZpbGVzIGNoYW5nZWQsIDU3
MCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgNCj4gPiANCg==
