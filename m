Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E97A632A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjISMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjISMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:38:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A35F5;
        Tue, 19 Sep 2023 05:37:52 -0700 (PDT)
X-UUID: 55b3067056e911eea33bb35ae8d461a2-20230919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5Y41qKxjFUS6iLEh3jI6ZerYje9z3rKxtfFnMe2X4k0=;
        b=BmIv0Md3N4meljdByBbrkSyNlQIZdBdnpkFBDPvELw4k4XgKStiyUUEp450pCO6uwkEH0987CtC33jDWB6J7XqmKU/0a+D+nCsskQTwdWXnpl/nmjlhX8yBDPMc1AA8KJ1Q8zWzlM+vmMAC3w9ATZPKY7DL2nizO9xxbI0E1zbU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:930e8fc2-e643-47d1-b36c-3d1b21b69f95,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:5fe21e14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55b3067056e911eea33bb35ae8d461a2-20230919
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 45952618; Tue, 19 Sep 2023 20:37:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Sep 2023 20:37:44 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Sep 2023 20:37:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNsWSuCe5qrrYp/Amhjp3GZaD64/viphc/BeRs7MIx2/QilYWEIMC4X7aFw3dbUH/tjbU4q+qleztzSPquqCF1VHTdmYfU81aJ/LT0MWvyVLHcgT+UNczIh+Obi1slQeoZP8e9oStDL9UfcKvesymqIbdsPECGwiL6rOjKlgganXR066hHGR79Bla7ALyreok9WzHppW9wa9p65hUuRMLtDnqDhAMlGP33/jDEM28tuDhsN0Lqt2NKDIYCX+6N7kkvJiod2j1vPyqb5DOETBbVMjOVaiCPo5+alUUpNVT5wB7QXaf0fSrRSkH9yAK3yIJ9KyauVX+IkRuhcOSvnQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y41qKxjFUS6iLEh3jI6ZerYje9z3rKxtfFnMe2X4k0=;
 b=Y3XqmpDyU6bDgg2ZhY7IA7zVtWR85Uz8frc6GbgXRv3U80ZrZoEPqw9ZbwxHQLlcP4uArCOtnpnUBuzkQta/2ZjbpM909WXHPFFbrRAhMAGerZ+YxGEQwQLvHhgiX3vfR6ib1VCbabpwSY/5oxGxzztGn9yDe0n0t6k9LAh+JMpZXPtsYbaFWdUZkZkUQmP+4G0+CZboSMPFAQeKuDheaWl2nqp4d3KNThU3o2kKx4eBZW5N/9yomd59mlGg9bzCh4ReOmv52hRopOBXdrdNVl677yZOWc0bvu9SK8+ANR69dZIZBl3pXj0D+NjhT/AQDLKDiyXFaTbQGEKhT8ICwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y41qKxjFUS6iLEh3jI6ZerYje9z3rKxtfFnMe2X4k0=;
 b=efIXaI5oNn+CD1WCOyqchLgohAl1MeJUjxnS9mpiF1oKS1xQ/kA/6bkiYe0RuEq1OJIs4B5x9BAIZg2F2VmI08HKMftIbAM8L4bhfcrPNh1wsTRisgF+ziXwjF9X6g1xuri9anm8TsDocG9LgCK/zsbfY8WctuNPpar6SIFB6C4=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by KL1PR03MB8163.apcprd03.prod.outlook.com (2603:1096:820:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 12:37:41 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::fb21:1c1a:678:fbfd%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 12:37:41 +0000
From:   =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= 
        <Chun-Jen.Tseng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v3 2/2] soc: mediatek: svs: add support for mt8188
Thread-Topic: [PATCH v3 2/2] soc: mediatek: svs: add support for mt8188
Thread-Index: AQHZ6pr4zcsq7puX3U6jyOm98/AG5LAh+ZsAgAAdVgA=
Date:   Tue, 19 Sep 2023 12:37:40 +0000
Message-ID: <acd2cba7db6d4e523f84fa4725e9bd6b596023ba.camel@mediatek.com>
References: <20230919014439.5795-1-chun-jen.tseng@mediatek.com>
         <20230919014439.5795-3-chun-jen.tseng@mediatek.com>
         <0009f224-aac4-6681-fde5-cf1ead94c604@collabora.com>
In-Reply-To: <0009f224-aac4-6681-fde5-cf1ead94c604@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|KL1PR03MB8163:EE_
x-ms-office365-filtering-correlation-id: 785ec4d5-8e34-42f6-8996-08dbb90d36e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42QnjteHBlQ/cmybb3LA+kfJyY/1zhukq0Tw8pLXenIV/0+5/PmwyR4yMyTdP77gQZ1wR6zIEL+Drd8cqrFNUCL/IJUY6jkrJ2q+fRxFz9mbr03GCtFpFQTTuTL/liHenHdT28WAaHtGiXWipSdgCoPkoN7m56e6yMU4rRct1HS55By5tAkMmGnPuDoPufwZ4tJ3UYTrMJT434JOVvU5gtCUV6fZhWj5qtgP6aZ3yl5jAYxWK5qQUlJimL5+kqfg8jLbq7JZmHcWqFbgwcO6Kqj8DQUb857/FohsXkl1ulCsStIaraHVtqTSlROZtBmsGbarv6y8R78E1xHNtfdZKBexeApWWX0jfSsLpmeL+CyXQQPnK9Z0p8HsC6jkL1eLhHLRZpnMQ/K6YzWFFOrCzC482YYLq8sHGCByVu2oThRXfW+kcXmAiEAOFFx/ln2SThNuKbghzLLtC9AiaGJZb9wFN1DvOKSETvTiOVtDlMg46tWTkGw1Xx3dTxbTafy2iVEsshtoPsuLWUI3ebMAamE89dwGYgFDC2Ii587nz3cLhoHDKyJwd9BK8ZAFCOXVrobiG5o0uMDMHa+EF3B7jdPVfNLxfwKOL/40UQit8AYGG+3jHyZ6cQF7cKg4F33p+OkMSkMXYBfCxnqNR29dyASN+mQBru3J2sgQKwtzopQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(6486002)(6506007)(83380400001)(6512007)(71200400001)(478600001)(26005)(2906002)(7416002)(54906003)(64756008)(107886003)(66556008)(66446008)(76116006)(66946007)(66476007)(4326008)(91956017)(5660300002)(8936002)(316002)(110136005)(8676002)(41300700001)(2616005)(36756003)(86362001)(85182001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTV6UDdKOG9adnBXMjJjcWRjMFhoZ1dENlBwaWNndHMreVRCM254Njgvd3BO?=
 =?utf-8?B?aGtNeGF5L1lYU3V3MWV0ZnNBY3hzT2FxYk1yS0wvVG5qQXVSS2VNZU9tTU01?=
 =?utf-8?B?RHY1UkRHVWtoaGZTWFFWZ2tSdWJQZnhKTWg2Wk4wK2orRm45QitOZmIwbUlj?=
 =?utf-8?B?WGYrUjNDbzBYelVYLzFhOUM1VmZydDRaWEhJWjF5TGliUCtHa0Qrb2hsenh0?=
 =?utf-8?B?ZVVTVXhwQ2ZZV2dKOVpzdzViOEtYTm9uVVUvaWd0YlJkZGJpcFovUFhqZnlw?=
 =?utf-8?B?ZFpDeS9CN0JjS2lyRlZjTTFXMUJJYW10VjBBcVhZTGJqTVFDbzJnTHdoSnZ6?=
 =?utf-8?B?TVNodHFwM25sRFlaamFvdXdyNGRieGR3VE9kQ3FiSUhYQWcyVklHMExwQjky?=
 =?utf-8?B?TGxKaEpZQW05aEs3NVdnaTRhalFqNzB3ZEZ6ME5WeTNYbDk0elhMcFdGWW8r?=
 =?utf-8?B?eGtSZXhGa21JUGZqZmE5d2F3Vis5L3dEMDh6bFFEZTZXS24vUVdSd1R5Q2lV?=
 =?utf-8?B?RUNxa3NSRnhpcUl5V0JtaXExM092elQvdDRDOGthTjZreHZCZWJxc0NBcHR2?=
 =?utf-8?B?YWprWlBuZk4wODAvNk9aaWN6cGE4NkY0UDVMY3F5RTdCbDVwUWE5d3AwWlFx?=
 =?utf-8?B?M2l6VW5QcHhUOHFuVUdrazBDZml1ZVNhQlV6dWdBSnlEMkJJN2xuWUJ5SWVh?=
 =?utf-8?B?MGZUb2JmMmVSb0pqTE9TSzB2L2s2a1ZONUJaeXJMMHUwSDZVaGdqSFZDRXJ3?=
 =?utf-8?B?bWR5SW1sWUVpK2YwczBTOFZHWGNJUVE5RGg0cy9UVi9PK0pkRlBsT1pIRjVX?=
 =?utf-8?B?Lzk2OW5vZlozazB6UWl0SmRTNldWakpkRDlMS244clZJWmlQZjM4b0lENWhD?=
 =?utf-8?B?Zld4WElyUlY5ZnRuby94MCtxaSsrR2I0WnlPYnRLVXJTSjZLOVpXaXFJQncw?=
 =?utf-8?B?L1NYV2xmUnUxempzQmhrR3NOMGM3bjBDbGJ5d1RzYkdqbXdLa3NHY1cwWmhH?=
 =?utf-8?B?VUZFQlJOeVBQS1pxREtaL0xYejlNRUhmNVFqZ0lUNU1lVVN3dXdqd3hCOE12?=
 =?utf-8?B?UGR6OUpzb0RkN1dlNGdBL0hDa3VFVHNSMHdiRklWMnlpSmY2MEVBVmhxUUNl?=
 =?utf-8?B?U29CV2xMWDN4WFdlcDhpZCtVbFozeFhXWXNrazl1c1VwUjdUODVaaDBJUy9U?=
 =?utf-8?B?YTN6Q01hMlpKazdLa0hORVBSVFdrZkJGMzc0bjNpL2t4ZGg1UGtHd2FwTDZk?=
 =?utf-8?B?MXdrMjZXdDVTc0N5NWhBWkZDckl5Mkl3cWs1ZDhUZGlGVXM4QlVnaS82ajE1?=
 =?utf-8?B?enQraXdJamdUSXB3SUs3WHF6M01MR01YRjlMc04ycVNLa0ZtSUhLanBOTllz?=
 =?utf-8?B?ZVJPLzQ4QjZlMFVKVmI5VjVyUDZmV1BtQTFjN2p1MDdPR1UzZ3NWYWErVHBD?=
 =?utf-8?B?bmUxT0twN1Vpc1FWcUFPVFllTDczZzdNYkJwOExDcFdzL29qenU0Vi9hSHI3?=
 =?utf-8?B?M2pLYm5BVmJBSUVsNUlhSXRRYUxweDcyQkdNTW54Mlh3NHFYWUhVWVBGTWd1?=
 =?utf-8?B?Z040QTl5MTErME53MVJwclBSQkJ6ZEdRRjNlSXdYTUovUm5zV2VHUDRYTU5P?=
 =?utf-8?B?U2pQUjh4ejJMMXU4WVJCazFjaWVPK2p4ZDNvbkpNcCtEdDJ6ekJpNnZmYzVY?=
 =?utf-8?B?bUM2MkNjNGFHTmt1NkhmS2xEcHgxbHkzZDY3SnNQUUJ3SmlZYUszTzBEMzVz?=
 =?utf-8?B?cmVGMmx2aUkvZmg2Z1JPdUVhQ003T0wzVHhuOUpiKzdxMVpwWm1zVjdNNjY4?=
 =?utf-8?B?NDBoRVVjQ1RZbzZlaEFndlpMTXBIVkphSmFTZ2lmdysxbnlRVi81NFp3Nzhn?=
 =?utf-8?B?VDF0ZW5VQ0FsaGlKMGgwRXRsTkhtbDdhK0JqWVJMbWgvN2UvdWhQOWR5cVBK?=
 =?utf-8?B?aVFSY1dSZEFzL3JtWE5WM0dSaWt5NzE4OEdXSVU4R2pwRnFtb28rOVFMMWVl?=
 =?utf-8?B?YXdGMEY2elRxMHZiM1FPNTVmUXZsR3Z3SW54cUhyeVVxNDZmVXRVMDgxQzdj?=
 =?utf-8?B?V05NQjVoS2VrZndZR05BY0xXa1pEM295V2FvQ3hENzBTVDZWM0pVUWxVVkR3?=
 =?utf-8?B?dVllbHB1a09LdVppckhUNzRIdTVmNTRYRU5RZ2pDV1hCMm5kUW00MC85NEdX?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3406FBE4A086248A4C555E42D5DB3B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785ec4d5-8e34-42f6-8996-08dbb90d36e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:37:40.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5jqWsnnH4cTOogYuPPfDJZUjmD+6YsIqZ+nDH+Cx0L4i7v0NJ7fi7GlYnGIWD7yuGRFrqNmOmcMg1Kt36dr9CsuDOeFBdwch9CNK1wto/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8163
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.630600-8.000000
X-TMASE-MatchedRID: TMsvcu6/L5fUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb4/Sgap63qByoT4H
        bViYLw2VUmsNbSHn8eB0ja+EQibX6hn6N77xrn9rfxzygoxuBhgGzTZg/u8yG99RlPzeVuQQHbe
        29YCXdrZJCbnPujZHx9bT+AIaB+1+IWPw2wFzPN3AzkaoCiomKp3ZbPRfc5otndu+1niGuXt576
        my5IxjulRKMTSTTuSA0bLEnXdfQbKAtHLrYZwv45U7Bltw5qVLK70vctTSAAena6U74e0+qFl7f
        U/4au864vM1YF6AJbY9l7H+TFQgdY2j49Ftap9EOwBXM346/+ylssknKlYIexhsyfP0i6e0WVjJ
        P16fN6HzjZEQa7TKBOcUn+0BQMB+
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.630600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 85222553D71984BF4AFFE41ABBA468325F211617B559768A41E272C1672D58042000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTE5IGF0IDEyOjUyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTkvMDkvMjMgMDM6NDQsIE1hcmsgVHNlbmcgaGEgc2NyaXR0bzoN
Cj4gPiBNVDgxODggc3ZzIGdwdSB1c2VzIDItbGluZSBoaWdoIGJhbmsgYW5kIGxvdyBiYW5rIHRv
IG9wdGltaXplIHRoZQ0KPiA+IHZvbHRhZ2Ugb2Ygb3BwIHRhYmxlIGZvciBoaWdoZXIgYW5kIGxv
d2VyIGZyZXF1ZW5jeSByZXNwZWN0aXZlbHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFy
ayBUc2VuZyA8Y2h1bi1qZW4udHNlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jIHwgMTg0DQo+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTgwIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1zdnMuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+ID4g
aW5kZXggM2EyZjk3Y2Q1MjcyLi5mMzFlM2JlZGZmNTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXN2cy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLXN2cy5jDQo+ID4gQEAgLTQwNyw2ICs0MDcsNyBAQCBzdHJ1Y3Qgc3ZzX3BsYXRmb3JtX2Rh
dGEgew0KPiA+ICAgICogQGRjYmRldDogc3ZzIGVmdXNlIGRhdGENCj4gPiAgICAqIEBkY21kZXQ6
IHN2cyBlZnVzZSBkYXRhDQo+ID4gICAgKiBAdHVybl9wdDogMi1saW5lIHR1cm4gcG9pbnQgdGVs
bHMgd2hpY2ggb3BwX3ZvbHQgY2FsY3VsYXRlZCBieQ0KPiA+IGhpZ2gvbG93IGJhbmsNCj4gPiAr
ICogQHZiaW5fdHVybl9wdDogdm9sdGFnZSBiaW4gdHVybiBwb2ludCBoZWxwcyBrbm93IHdoaWNo
DQo+ID4gc3ZzYl92b2x0IHNob3VsZCBiZSBvdmVycmlkZGVuDQo+ID4gICAgKiBAdHlwZTogYmFu
ayB0eXBlIHRvIHJlcHJlc2VudCBpdCBpcyAyLWxpbmUgKGhpZ2gvbG93KSBiYW5rIG9yDQo+ID4g
MS1saW5lIGJhbmsNCj4gPiAgICAqDQo+ID4gICAgKiBTdnMgYmFuayB3aWxsIGdlbmVyYXRlIHN1
aXRhbGJlIHZvbHRhZ2VzIGJ5IGJlbG93IGdlbmVyYWwgbWF0aA0KPiA+IGVxdWF0aW9uDQo+ID4g
QEAgLTQ2OSw2ICs0NzAsNyBAQCBzdHJ1Y3Qgc3ZzX2Jhbmsgew0KPiA+ICAgCXUzMiBkY2JkZXQ7
DQo+ID4gICAJdTMyIGRjbWRldDsNCj4gPiAgIAl1MzIgdHVybl9wdDsNCj4gPiArCXUzMiB2Ymlu
X3R1cm5fcHQ7DQo+ID4gICAJdTMyIHR5cGU7DQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gQEAgLTc1
MSwxMSArNzUzLDEyIEBAIHN0YXRpYyBpbnQgc3ZzX3N0YXR1c19kZWJ1Z19zaG93KHN0cnVjdA0K
PiA+IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPiA+ICAgDQo+ID4gICAJcmV0ID0gdGhlcm1hbF96
b25lX2dldF90ZW1wKHN2c2ItPnR6ZCwgJnR6b25lX3RlbXApOw0KPiA+ICAgCWlmIChyZXQpDQo+
ID4gLQkJc2VxX3ByaW50ZihtLCAiJXM6IHRlbXBlcmF0dXJlIGlnbm9yZSwgdHVybl9wdCA9ICV1
XG4iLA0KPiA+IC0JCQkgICBzdnNiLT5uYW1lLCBzdnNiLT50dXJuX3B0KTsNCj4gPiArCQlzZXFf
cHJpbnRmKG0sICIlczogdGVtcGVyYXR1cmUgaWdub3JlLCB2YmluX3R1cm5fcHQgPQ0KPiA+ICV1
LCB0dXJuX3B0ID0gJXVcbiIsDQo+ID4gKwkJCSAgIHN2c2ItPm5hbWUsIHN2c2ItPnZiaW5fdHVy
bl9wdCwgc3ZzYi0NCj4gPiA+dHVybl9wdCk7DQo+ID4gICAJZWxzZQ0KPiA+IC0JCXNlcV9wcmlu
dGYobSwgIiVzOiB0ZW1wZXJhdHVyZSA9ICVkLCB0dXJuX3B0ID0gJXVcbiIsDQo+ID4gLQkJCSAg
IHN2c2ItPm5hbWUsIHR6b25lX3RlbXAsIHN2c2ItPnR1cm5fcHQpOw0KPiA+ICsJCXNlcV9wcmlu
dGYobSwgIiVzOiB0ZW1wZXJhdHVyZSA9ICVkLCB2YmluX3R1cm5fcHQgPSAldSwNCj4gPiB0dXJu
X3B0ID0gJXVcbiIsDQo+ID4gKwkJCSAgIHN2c2ItPm5hbWUsIHR6b25lX3RlbXAsIHN2c2ItPnZi
aW5fdHVybl9wdCwNCj4gPiArCQkJICAgc3ZzYi0+dHVybl9wdCk7DQo+ID4gICANCj4gPiAgIAlm
b3IgKGkgPSAwOyBpIDwgc3ZzYi0+b3BwX2NvdW50OyBpKyspIHsNCj4gPiAgIAkJb3BwID0gZGV2
X3BtX29wcF9maW5kX2ZyZXFfZXhhY3Qoc3ZzYi0+b3BwX2RldiwNCj4gPiBAQCAtOTUyLDYgKzk1
NSwyOSBAQCBzdGF0aWMgdm9pZCBzdnNfZ2V0X2Jhbmtfdm9sdHNfdjMoc3RydWN0DQo+ID4gc3Zz
X3BsYXRmb3JtICpzdnNwKQ0KPiA+ICAgCWZvciAoaSA9IG9wcF9zdGFydDsgaSA8IG9wcF9zdG9w
OyBpKyspDQo+ID4gICAJCWlmIChzdnNiLT52b2x0X2ZsYWdzICYgU1ZTQl9SRU1PVkVfRFZURklY
RURfVk9MVCkNCj4gPiAgIAkJCXN2c2ItPnZvbHRbaV0gLT0gc3ZzYi0+ZHZ0X2ZpeGVkOw0KPiA+
ICsNCj4gPiArCS8qIEZvciB2b2x0YWdlIGJpbiBzdXBwb3J0ICovDQo+IA0KPiBJIGFscmVhZHkg
YXNrZWQgeW91IHRvIHBsZWFzZSBzZW5kIHRoZSB2b2x0YWdlIGJpbiBzdXBwb3J0IGFzIGENCj4g
c2VwYXJhdGVkIGNvbW1pdA0KPiBiZWNhdXNlIHRoaXMgaXMgZm9yICphbGwgU29DcyogYW5kIG5v
dCBvbmx5IGZvciA4MTg4Lg0KPiANCj4gQWdhaW4sIHBsZWFzZSBzZXBhcmF0ZSB0aGUgdm9sdGFn
ZSBiaW4gc3VwcG9ydCBmcm9tIHRoZSBNVDgxODgNCj4gc3VwcG9ydC4NCj4gDQpIaSBBbmdlbG8s
DQoNCkkgaGF2ZSBhbHJlYWR5IGNoZWNrZWQgInZvbHRhZ2UgYmlucyB0dXJuIHBvaW50IiB3aXRo
IERFLCBpdCBpcyBzdXBwb3J0DQpmb3IgKmFsbCBTb0NzKiAsIG5vdCBvbmx5IGZvciBNVDgxODgu
DQoNCg0KPiBzb2M6IG1lZGlhdGVrOiBzdnM6IEFkZCBzdXBwb3J0IGZvciB2b2x0YWdlIGJpbnMN
Cj4gc29jOiBtZWRpYXRlazogc3ZzOiBBZGQgc3VwcG9ydCBmb3IgTVQ4MTg4IFNvQw0KPiANCj4g
UmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
