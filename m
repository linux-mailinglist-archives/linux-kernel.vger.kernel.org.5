Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA07A72AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjITGQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:16:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A739F;
        Tue, 19 Sep 2023 23:16:42 -0700 (PDT)
X-UUID: 408a477e577d11eea33bb35ae8d461a2-20230920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=of/5GxF1/d6c9dZJzpaUuPveZgRxacFJo/BTS4JwHlU=;
        b=VYMahJiClkqdf7Jq2l6XwNV1Ujb6Ah9tmRbBtdihn3XMVc1Lh6qFHQJcFuaDNfnB78zti748KzczMcfYrosKnPkkFuE49D+K19z2bsC6bkm5zj6qHeOAl9mZUdkpT+GmXhZI6vtZU6vhhl0zR8NZk691r1Pv27r0VVPY+GaUmYk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:7e6fdb36-968c-40f5-af12-90f3742e35e6,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:5f78ec9,CLOUDID:7f842614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 408a477e577d11eea33bb35ae8d461a2-20230920
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 876961147; Wed, 20 Sep 2023 14:16:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Sep 2023 14:16:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Sep 2023 14:16:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn19NbbqepT6UqxyIKUabcxi/sWhUU+L1bDZMQ0DHtmbB/vgk+h9v+ccR/M8JtNoWqm5HH6V5ww6RSFdkwXWqYM4EHCN4vxbj+hCt6j9i4/aZ7VOi02PzEBOwrYQf9xzTO8+c4CqiZrm13NQW6zGFZdI2m84tDH2poYIxZUP6+UWksMPqtGtocY3oBnLkqPA+O6Km2sK38qpBdNwetTUFZnmAUGYHxeIcpoSPSPXa4wUPuw3yw/KRKa1wjHi12LEfW5qhslisXfvzezf/u3Idg1O8EoGZeh6pcdpv8zbTalDrhKRwdLJmw+669NddxOGFkkRfSBBnNyde4VO7+2KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of/5GxF1/d6c9dZJzpaUuPveZgRxacFJo/BTS4JwHlU=;
 b=IszrcT1jKpzjbbCfojgLhtf+sQCgBx0zU4tZ4+H+JVKIYNIuK4QoU6xR8QIkyiarwvfE6i6XDhF7x2TGWE4nz0BphMJJFYKy7VV4G2DeWVkZzTxng+QGZUtbU/pjJcP/NaKQsEwaV7l8cRyWynK6rW6DA3FaZebTQsfuvpxMEcd8oyFahqBYJpyl/6sIVVdjFXPQrighuVD+LJmwwGNerUhGn2oqgyYswhE+g8IDjKqMExE77EKb/1/bLK2YdDBAloGXPYh2qW0dP6lkJ6Fp65Yg0PEw6HrXazW6nW5pPLfpa7T51V4uDjrvvVSkuEQeCt4rdT2LoKL1P5v2f0wlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of/5GxF1/d6c9dZJzpaUuPveZgRxacFJo/BTS4JwHlU=;
 b=Jad8Dg3wlW2z1SLpA8iIfFNQXW7/IemZb+vBgLATkwLsUxjGeJXvE8ioEVNrdYiqeCqfJpwqlwU960lr/mD4oQEy2RoaLUleipjpHodC87XPE7zfm556BWhmUyJmQPLjsnjB6mLSxni8UiNjz4bUwOGGCyNuFQdEmfjknQXcjZA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6609.apcprd03.prod.outlook.com (2603:1096:4:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 06:16:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:16:31 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 04/20] dt-bindings: display: mediatek: padding:
 Add MT8188
Thread-Topic: [RESEND PATCH v6 04/20] dt-bindings: display: mediatek: padding:
 Add MT8188
Thread-Index: AQHZ5IO9CD6AUvSBrEiQWiPbvOcwZLAjSvUA
Date:   Wed, 20 Sep 2023 06:16:31 +0000
Message-ID: <61877347f684e1a47f1b31fb0021cca35efafdce.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-5-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-5-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6609:EE_
x-ms-office365-filtering-correlation-id: bf58961b-85c5-4158-6af7-08dbb9a121d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NgjYPiBsFpKDLEUnOPDurFfaFzkqNvbpG39siKvq6eG156FaSbQ52RRKrrsHoyT9JiT9T/QxThEoiIsxbxiZ/MQV/zSVo1p2RR5o7r3Go+C9vZtMfX8oRrz0RdVQug0QaZOX1WtWWvr4PMdp0U/1Qy8K3m66D8RDg8uA0Tdv6PL7tXVDqh8/NMTqUppJbR5Penv4bShHT0neV0662BXi9XbcEuvl84qM4sn/O2qk47+ZyraUp79PKNfRD9dXPgyH18ZeXK79kWU5tyk2XSuE3kfRCjiWDNNaEg+JWDR/Bx4bNyYiuzWKrnTZinwoVNGH9nlXwDB7rGOQJbyKiQANNVIJlMrOnw+QMKlM2jECaZUEI1BrK5aaRlg9zHbViZdyXNFrvk1JCIMvpDQTqDxQpZ5+ds+j372/7VgByKlGvHw7WnKHbzNnznhUi7vSuj/Aih5AemrfymdPdh9HdR9j9fBLL8X3igfeYLyeI6dm1hxmw2IFEmxVFH8v2OtYN7/BWoc0yXnepUQRQmcaPqEOQNwAm6OYRj53fxbj49f21J64v66SP1Rk/U0SxMsw2pPA/SI3/22j3Gdn+vjx7N1yQQ+Uq6RAB9SGkp6NxS6qQBJH3v13EkYLB7JNrQ2J5aBCkglFHUjE/mW0Cw+MTpK65xUhmYzayU2uryWuNefQVgO2d9IdlEuYP59Dg2PAFdz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(186009)(1800799009)(451199024)(66899024)(316002)(66946007)(66556008)(26005)(76116006)(110136005)(66476007)(54906003)(64756008)(66446008)(2616005)(83380400001)(6512007)(71200400001)(6506007)(122000001)(86362001)(6486002)(38100700002)(38070700005)(478600001)(966005)(2906002)(7416002)(85182001)(36756003)(4326008)(8676002)(41300700001)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWc4QWF0MFZ1K093TTBnWHIrUjJQUXJsdys2Q1BocWNCdnAvek9tMVpBOGlE?=
 =?utf-8?B?bmJUemlhTnE1NWhDR1pMYkpTWGRabTBkSXAxWko2cTAydWZmVmx2QUZFY3Nk?=
 =?utf-8?B?TzFPbnQ5eHVxU3dVQnhBOWVxTnoyeE9reHpkVjNVSitRQmdKdjRoQktJVERy?=
 =?utf-8?B?U0M1ellaQ0tDR0YrQjhINnhuRGphZFRkdSt4WE5KcEdMU1pUVlFNekt4VGVP?=
 =?utf-8?B?ckVhYU14WXJQWm9OUzlRK1FTQXNRS1F2Vy82YTZjKzJ4UVo5UzA4bkdkbExG?=
 =?utf-8?B?QmpOamNXMlB5YmQ0ZVp0Q0xXdDBpWVM3VnNSWWlvZ2tjbVI3MWpYWmN5Q05Z?=
 =?utf-8?B?U09naWMvdEl5SVlDSnVFZlJ3WUZtQStvQVdZMDh0QjJYS2ZUQ2d5a0UvcGFH?=
 =?utf-8?B?OWJhQUxBRXV2YXFwaHNtS3BiclhmUzQzWTRBZmtpVnVTZm1FVDZBREdvTGxs?=
 =?utf-8?B?RDJNM1Jlb2xuSWNNUFhyUXg1MFZuUmxhOU1UODNMYnA4dUFaZmFUb2h0dXRl?=
 =?utf-8?B?cnVDZFhNd3crUTRTUm8zY0E4a0dXaGQveEFqT2prOHRvbTNveWhkYmlHNDY2?=
 =?utf-8?B?MmtLVjUxd1RXN3ltaElwQmFGVURWNFRRVHI2SmVBdGwzVEVQcVlUU0xjMTBH?=
 =?utf-8?B?TDhxK2JRUW5uMkR3UUx0YnpOTlQzaTRWSHd1RXpsdFAwb0FVcVZTendrNWU2?=
 =?utf-8?B?STdLWXB2ZjdkYTdtb0tNN3QyUlkyTDA5OU1kaFY5ZENad1lFMDMzYUdWM3hn?=
 =?utf-8?B?QjY1ZTE1ajY0YkoycnkxcW5hM09sdS9lNlIvcWhMMk9BSDczc1FuTWdCanZ0?=
 =?utf-8?B?NmE5a0JLNElSVTRnc0RUbHdnV3Zjd2hqK2tIWlRLR1E4aDB0dFl4OU1Gbldw?=
 =?utf-8?B?bVVkTmhxMkdYOGtJRGN0U0FXdzhkQXQ4UWkxVk1OVmNLbFVEN3pQVURoSWxn?=
 =?utf-8?B?cGF3eUdnUHhpZjBwM2crZGxHS25yRUpYRUc0M2s4NjdwTjk0NFdLS2l6NVBs?=
 =?utf-8?B?RXhRNjNsRDkvZjRhWlk2UFF6OHY0d296ckF4ekdDa25ZZ0JWVUpqMkVkYUhE?=
 =?utf-8?B?R3o4LzdjajFwTHVXYXd4bDNWNENXN3RxL2VQRDlFV1V5Z2lCWEFidmVOSVQ2?=
 =?utf-8?B?eVgydDJmcVhuZkR2dU9jblBGc1ZwTW53KzlDVVlDSVlSZ0JhMkFzT2ZTa0tK?=
 =?utf-8?B?cGNNV2NZMVlCcnpxdG55TndsdHFIeXYxR0lPRVlIZEc3MS9PcExMYlVVWGZz?=
 =?utf-8?B?akt4YmMvRlBuVjhJODVBVEZTd0d3cjY1SGFwbjh0cmozZWNOeFYyU0FodXZF?=
 =?utf-8?B?MUg1WFNMNXlqdWNURXVBci92WEluM0FHMWh1eERwRGN6eHEwRE1MYXVxT0lU?=
 =?utf-8?B?b1kwSCszTFh5UmdXMDBZKzZGakpaeENsSVVPSkhqTmdjSkdFSmZmM2l1WjRB?=
 =?utf-8?B?Mnp5dmV4THZ1c3V0WWZyMHdQWkF0dnl4S0xuV1Qwc1p1MXN1ck0rSy9GcHhL?=
 =?utf-8?B?Q3VMY0xxZTVJWUFRSXE2b0JlczEySFZCejliRUl6K3JoWU1mSE9OYVVVRERL?=
 =?utf-8?B?WUJJOWc5ZUNmNHpkRTJPZHdTRmtOem5WRDR5Z0o5K2JRUWRMcDg4cXU3VUlF?=
 =?utf-8?B?UUdIaDlzSkNQaTY1eW9IeC9ramczNFV4cjBPT1VNMUJxa0dpd0drNDJnR2x0?=
 =?utf-8?B?WWlVcDNleTMveGF4dXVTYzFMekZjbmx1cnZ6UTFMMC8rMWMrQS92UmN6SjBu?=
 =?utf-8?B?MkVOdnhRZHBNb1V1TTVnaVhKQktSaDZEWFJvMlRNeUg5ZitpSTJhdStIaERB?=
 =?utf-8?B?S3ZEbGc1OTRrd1BJaUhHVlhFRmVuQVYxU3FmeVY0NHI1N1BMTU5GQVplTTFJ?=
 =?utf-8?B?TWJMK09ZTzVWdnp5MHlWcFBoNFZGZVBpKzZaRlgrbnQ1bVNOZlRCdFQ5ZWl6?=
 =?utf-8?B?Z09ITGhZR205QUpMT2hDK2REMWJNWVNyS2dRblIybXJubVc3QXFaNmh1VE5J?=
 =?utf-8?B?TzRHMDIvbXdwelIvYXhlYUQ0YTlDeWcxQ3IyRm8xaWMwN3lZa3NGakVMK2k4?=
 =?utf-8?B?dUZYYW5UNGcvNWdlYU1CYmZlQzJkS3lMMXF4RXREajRGdzZUbTdYTVhRNnh1?=
 =?utf-8?Q?1C/n3dLFG1BhopzKIIg9KSb2U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <278B1BF45F5AF64BA34EA833D7B0FF34@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf58961b-85c5-4158-6af7-08dbb9a121d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:16:31.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7udempL4Ah2JE0JSYxm4G1mR6LlML7bYcguMQdHJ/aZCUlO0pezQ8Yvb0a6f4gLdf1Q6IFsQBJZJiqbpy39lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFBhZGRpbmcgaXMgYSBuZXcgaGFyZHdhcmUgbW9kdWxl
IG9uIE1lZGlhVGVrIE1UODE4OCwNCj4gYWRkIGR0LWJpbmRpbmdzIGZvciBpdC4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHBhZGRp
bmcueWFtbCAgICB8IDgxDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4MSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscGFkZGluZy55
DQo+IGFtbA0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHBhZGRpbmcNCj4gLnlhbWwNCj4gYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxwYWRkaW5nDQo+IC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uZGIyNDgwMWViYzQ4DQo+IC0tLSAvZGV2L251bGwNCj4gKysrDQo+IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscGFk
ZGluZw0KPiAueWFtbA0KPiBAQCAtMCwwICsxLDgxIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiAr
LS0tDQo+ICskaWQ6IA0KPiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLHBhZGRpbmcueWFtbCMNCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiArDQo+ICt0aXRsZTogTWVkaWFUZWsg
RGlzcGxheSBQYWRkaW5nDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIENodW4tS3Vhbmcg
SHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiArICAtIFBoaWxpcHAgWmFiZWwgPHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBQYWRkaW5nIHBy
b3ZpZGVzIGFiaWxpdHkgdG8gYWRkIHBpeGVscyB0byB3aWR0aCBhbmQgaGVpZ2h0IG9mIGENCj4g
bGF5ZXIgd2l0aA0KPiArICBzcGVjaWZpZWQgY29sb3JzLiBEdWUgdG8gaGFyZHdhcmUgZGVzaWdu
LCBNaXhlciBpbiBWRE9TWVMxDQo+IHJlcXVpcmVzDQo+ICsgIHdpZHRoIG9mIGEgbGF5ZXIgdG8g
YmUgMi1waXhlbC1hbGlnbiwgb3IgNC1waXhlbC1hbGlnbiB3aGVuIEVUSERSDQo+IGlzIGVuYWJs
ZWQsDQo+ICsgIHdlIG5lZWQgUGFkZGluZyB0byBkZWFsIHdpdGggb2RkIHdpZHRoLg0KPiArICBQ
bGVhc2Ugbm90aWNlIHRoYXQgZXZlbiBpZiB0aGUgUGFkZGluZyBpcyBpbiBieXBhc3MgbW9kZSwg
c2V0dGluZ3MNCj4gaW4NCj4gKyAgcmVnaXN0ZXIgbXVzdCBiZSBjbGVhcmVkIHRvIDAsIG9yIHVu
ZGVmaW5lZCBiZWhhdmlvcnMgY291bGQNCj4gaGFwcGVuLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0K
PiArICBjb21wYXRpYmxlOg0KPiArICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODgtcGFkZGluZw0K
PiArDQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIHBvd2VyLWRvbWFp
bnM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBjbG9ja3M6DQo+ICsgICAgaXRlbXM6
DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBSRE1BIENsb2NrDQo+ICsNCj4gKyAgbWVkaWF0ZWss
Z2NlLWNsaWVudC1yZWc6DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBHQ0UgKEdsb2Jh
bCBDb21tYW5kIEVuZ2luZSkgaXMgYSBtdWx0aS1jb3JlIG1pY3JvIHByb2Nlc3Nvcg0KPiB0aGF0
IGhlbHBzDQo+ICsgICAgICBpdHMgY2xpZW50cyB0byBleGVjdXRlIGNvbW1hbmRzIHdpdGhvdXQg
aW50ZXJydXB0aW5nIENQVS4gVGhpcw0KPiBwcm9wZXJ0eQ0KPiArICAgICAgZGVzY3JpYmVzIEdD
RSBjbGllbnQncyBpbmZvcm1hdGlvbiB0aGF0IGlzIGNvbXBvc2VkIGJ5IDQNCj4gZmllbGRzLg0K
PiArICAgICAgMS4gUGhhbmRsZSBvZiB0aGUgR0NFICh0aGVyZSBtYXkgYmUgc2V2ZXJhbCBHQ0Ug
cHJvY2Vzc29ycykNCj4gKyAgICAgIDIuIFN1Yi1zeXN0ZW0gSUQgZGVmaW5lZCBpbiB0aGUgZHQt
YmluZGluZyBsaWtlIGEgdXNlciBJRA0KPiArICAgICAgICAgKFBsZWFzZSByZWZlciB0byBpbmNs
dWRlL2R0LWJpbmRpbmdzL2djZS88Y2hpcD4tZ2NlLmgpDQo+ICsgICAgICAzLiBPZmZzZXQgZnJv
bSBiYXNlIGFkZHJlc3Mgb2YgdGhlIHN1YnN5cyB5b3UgYXJlIGF0DQo+ICsgICAgICA0LiBTaXpl
IG9mIHRoZSByZWdpc3RlciB0aGUgY2xpZW50IG5lZWRzDQo+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiArICAgIGl0ZW1zOg0KPiAr
ICAgICAgaXRlbXM6DQo+ICsgICAgICAgIC0gZGVzY3JpcHRpb246IFBoYW5kbGUgb2YgdGhlIEdD
RQ0KPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBTdWJzeXMgSUQgZGVmaW5lZCBpbiB0aGUgZHQt
YmluZGluZw0KPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBPZmZzZXQgZnJvbSBiYXNlIGFkZHJl
c3Mgb2YgdGhlIHN1YnN5cw0KPiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBTaXplIG9mIHJlZ2lz
dGVyDQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0
aWJsZQ0KPiArICAtIHJlZw0KPiArICAtIHBvd2VyLWRvbWFpbnMNCj4gKyAgLSBjbG9ja3MNCj4g
KyAgLSBtZWRpYXRlayxnY2UtY2xpZW50LXJlZw0KDQpJIHRoaW5rIHBhZGRpbmcgY291bGQgd29y
ayB3aXRob3V0IGdjZS4gQWZ0ZXIgZHJvcCB0aGlzLA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCg0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UN
Cj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10ODE4OC1jbGsuaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcG93ZXIvbWVkaWF0ZWssbXQ4MTg4LXBvd2VyLmg+DQo+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2djZS9tdDgxOTUtZ2NlLmg+DQo+ICsNCj4gKyAgICBzb2Mgew0KPiArICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47
DQo+ICsNCj4gKyAgICAgICAgcGFkZGluZzA6IHBhZGRpbmdAMWMxMWQwMDAgew0KPiArICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtcGFkZGluZyI7DQo+ICsgICAgICAg
ICAgICByZWcgPSA8MCAweDFjMTFkMDAwIDAgMHgxMDAwPjsNCj4gKyAgICAgICAgICAgIGNsb2Nr
cyA9IDwmdmRvc3lzMSBDTEtfVkRPMV9QQURESU5HMD47DQo+ICsgICAgICAgICAgICBwb3dlci1k
b21haW5zID0gPCZzcG0gTVQ4MTg4X1BPV0VSX0RPTUFJTl9WRE9TWVMxPjsNCj4gKyAgICAgICAg
ICAgIG1lZGlhdGVrLGdjZS1jbGllbnQtcmVnID0gPCZnY2UwIFNVQlNZU18xYzExWFhYWCAweGQw
MDANCj4gMHgxMDAwPjsNCj4gKyAgICAgICAgfTsNCj4gKyAgICB9Ow0KPiAtLQ0KPiAyLjE4LjAN
Cj4gDQo=
