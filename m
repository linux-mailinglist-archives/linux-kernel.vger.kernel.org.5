Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5AB7A9F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjIUUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjIUUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:22:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9363400FA;
        Thu, 21 Sep 2023 10:15:08 -0700 (PDT)
X-UUID: 5a7b8106589111eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0TkkM2xljPwFMwFIXca8fsglCjDepXpYkV+L7r4EB9o=;
        b=mUfv/yYIO2IS6ejX989b99b0r1diy44RCGFdoybDFHr8yZAabFDx7x7Ec8baHwz7yKy4LKHBHEfu86pP4jRkNi2KrZYkG9VKZOniAAn14miP80FN3oTa3NrmCc7S88Vzuom+WwvvdawosIDb7UhN7991+sCwT5/uQ0ciIEvxK94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:4f38d285-b368-4b4c-a9e9-c14dc4ae9dec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ee1af9ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5a7b8106589111eea33bb35ae8d461a2-20230921
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 712752105; Thu, 21 Sep 2023 23:13:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 23:12:59 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 23:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIAJrl7Pr9mCqXv+YGfgK4getQMYuf9mQcnm7luBSIQqZQ0P/tRCfEF+sjsulogapFfNPqHopjj77Mm86t/qItyuEDNtpyAPjKOAaBxiVBqE+MwlkM7va6b8MGCUsXZZfqSa9LorY3ChcKLw9Du5SBmzFBW84qSRsjytNuRvLZW/FU/+I7GQxfa6oxIs/kHnD7U53fKVMFOg57szWzjrMYejCKeeL+URiEQjLLjttbsQWuj65P2PYBD/DIN8TUZ8Ceoo5rpJRp+kSwhNfvNLAkw0iLzPWoQ3dj/yLM4PRvvwuXzoNtbTcyZcvbcjQLp9XitWnw3lOoKVanel85/RBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TkkM2xljPwFMwFIXca8fsglCjDepXpYkV+L7r4EB9o=;
 b=KnCa9nYlwAfUjJST1FuG8KAKPZJ1oaNEqrwJxpnXIj2Kg8+PXrFOLSj2bv87snBbUhIKOYI8IH0jvbU4gxopX5RDf/i+k1PSCGbW1S8fSq/GVlZsTcgbCYMkGjTopDMWzBv+NC5NRKvo/fujlFRUmAihT8qKdkIxSfF3yQh9OMluuwMXoHTvd5vvkdV5hG5wSD+F5bhcBMJFbwzvJEEDdcJ77Fk4EExa7rPV0L8O4bUFSqQkQ02QCVZvx8vCHfAu813EtIJYnZG1z2N4D/6zfnqNlMln0MYmqQT58qk6xzupt11Lwn0BYhUFe/hLkBXtE/tqaev1qR2gAfH2A3UUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TkkM2xljPwFMwFIXca8fsglCjDepXpYkV+L7r4EB9o=;
 b=wMB6gu6YvzJoaEbwsC5kt56gtvy9BSO6we9+g9wj/UBp2AvDo9OkbADVsKI/8QIQFDhOq07MGUUducQxZNIZhywpM1Uu35bdd3tBQFGf97gqHtKMmBb44wEZiMfcQvG/0+N4tMfJWTEqOWAkPFbHm7G/y8lpttD/lGrENvgJwLw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5319.apcprd03.prod.outlook.com (2603:1096:301:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 15:12:57 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 15:12:57 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 01/15] dt-bindings: mailbox: Add property for CMDQ secure
 driver
Thread-Topic: [PATCH 01/15] dt-bindings: mailbox: Add property for CMDQ secure
 driver
Thread-Index: AQHZ6mVx/p6l1cKRKEyVN8cXDX+ztbAiXM8AgAMKmQA=
Date:   Thu, 21 Sep 2023 15:12:57 +0000
Message-ID: <dab72f40399f74540c6ac1049437aa70b1534a75.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-2-jason-jh.lin@mediatek.com>
         <20230919164614.GA4059766-robh@kernel.org>
In-Reply-To: <20230919164614.GA4059766-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5319:EE_
x-ms-office365-filtering-correlation-id: 9c754bdb-fe97-41d8-2340-08dbbab53c9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLFKJ8t1LIegE+Oqq9VgxLv2QUhjzk400R9cB37enh+x8wQPDh5X77VzdiyEOgiadsYkxUpw2mfjeDnQs4wtEu2F7C4pfNnwYPPBY5/90Q88nxXfWTxLS+TqMlXgHWC/MxvCWUHqIa+NATZWwUAWIePAGYxka9je5N1yz2Gk7TZ8kpnc8nIA+3+2tGTqOXX8aRyAkQkPuB92uX8HXwJ9zb7Jo2kCF2ePthXb1E/8fyOeghijttrOjBkkwYu2QJtdMeoPdjCUZu629zVGdAB3XFmTUVVnJihfLrSfAfVbuhYe0GSgvtbISSfgYuoSkVXarjr3gW7dJKTJ4FEosA4Qu4T4X/IrB6he4CPjmp8dKrrMnvvkitoYue9olfPhj4fyXCb2SNNDT3tOnrMEmjHgRbbep3ZSq/hwb4aAX07TQEBUmxPWvA/swda53ucYKmhhlk4eOqLqfn7fA8CrJ24tq9SgE1C3pc1D4hsq8slAYtOQVKuuv6Ygb8gu7QWuZIVhYmskRcEXfkUYQ7kUNsqv8ZNGef2btLOk6a/dRKiSVWvaA0XQpl4Jy/gr/sDK6igeDLXIZIW/OwlhzIhlejQI5j3+fTD3tS8JC9Mz70Q0GOHEOUGftF8JQpBWDKcXiC/ycn8KiZin3/thVcdRR1XUctsCth/B3HO0+7lRCEKV99I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(186009)(1800799009)(451199024)(71200400001)(122000001)(8676002)(8936002)(4326008)(26005)(15650500001)(5660300002)(2906002)(85182001)(7416002)(316002)(41300700001)(6916009)(66446008)(54906003)(64756008)(36756003)(86362001)(6486002)(6506007)(6512007)(38070700005)(76116006)(38100700002)(66946007)(91956017)(478600001)(66476007)(2616005)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmhhU09ma0xEZnBRb0ExVTZBaW9WWlRwemI1Y2c3VnRkM1hqTzFPcTlkMUVS?=
 =?utf-8?B?OC8rT0lIdkVGUVJEWmlIa2wzQUh0d21rVnBaeDgyWExGZXVoUTliajJTZER3?=
 =?utf-8?B?U01BS2N6RklaMVJnTWs2aUxOOEx2SXZkZlZYOWxMTStYNlplbFViREV2Q1pa?=
 =?utf-8?B?OC84a3p0K05IWktUMTg2VmJnS0JDcklxeWtaZmJUcEFLZTF4MzBJTlBhaFV6?=
 =?utf-8?B?U2s1SDhMaXhydmk5NGJKNUVCU2ZjRmNMbGxyNkNzeElHS2YwaitpSUROYllS?=
 =?utf-8?B?RWdnOW11T0dzSjBhOUpPY1JrblZEYmc0NTMxbnRDMFE2ZVZEVWcwV3YvZWRI?=
 =?utf-8?B?WDZubmFobTlpV25ocVdVWmtFQlJJajN5NmNZTkZpV3lDVVE1UklUWkF5V0U2?=
 =?utf-8?B?eHllN04rdWhoTFlFMUJrdWhWK0dmdGk2SzF5VzVFcEpERWlwVHdVZDJlbFUx?=
 =?utf-8?B?bG9QUXE0Q3JBVWc3SkJnMElSVU5NZ1BDY3AwTVVpdVVMT0xhN1VwREM3S2xF?=
 =?utf-8?B?TEhlQlNZT2lsOExSZFpzYmZQVS9ROTFZWUg2ZUlUR0crSzUxSHlNVzNuckFh?=
 =?utf-8?B?RnFyd0xHdU1Xc3BOMVRzWTBialc1alNrQTBReVVzNXUxTGhnbzdjNGlrZnZ3?=
 =?utf-8?B?K3ZMZ0JTL2ZmR21URGJpMnNRMVRCYmJrUWhQL0NscEo2ZW1wdEs5c3RhMFVk?=
 =?utf-8?B?dGhPZVVEaTlDakhadlZOSnZZMm04UDIvZ2pDRlNQNzMxMW1jM0JZQWJFdUxo?=
 =?utf-8?B?VHQ2cFIrM21HLzZFL2tmMTdjYlc1ZGRnMm9XS0E2S0cxQmVnVVJXMitHOERi?=
 =?utf-8?B?WlNwczRjRVY0elVDOTRzNjIrL2g0WmN2NEw4cHMvVWUweUFwWlFTU3BIY011?=
 =?utf-8?B?Zit6Y3ozWUpoZTFyNG1aRUxacFRJU0YweFZVeE4vS3QweVkwRUhZaTMrTEZt?=
 =?utf-8?B?aDh1NXIyNER6V2gvTFNiNnpZN2NFd1ozakY1SmwrOXhIb0hvcWRqRlFCOWF5?=
 =?utf-8?B?cmpNcmFFTVlGNytrMWJ2cGV2cXAzdnhlWmUrTlNMdjBRU2pleDZPdkVhNEc4?=
 =?utf-8?B?V0tUNHpBc05NblhnUFczT3VOS1ZoT21FVUxUdHlqdjhVbEtmK2FzMk9zSXNt?=
 =?utf-8?B?N3NMbWxyZDZXQzdsMTJGQUxRcUY1dW5XSGpQTnZ0ZXgzU0hNSUJHQzhReGJQ?=
 =?utf-8?B?clBMMTJGTWw3Q2NWeWYwRlVscTdFR0ROSUcrdEFjZUlLSHhHa3JtZFZDN2s0?=
 =?utf-8?B?dWpTd1JVdi9QcTBZcGt4VVFEM1J1Zy9TZFlyRmk3VFpqZWI1SzhJb3JSNEdL?=
 =?utf-8?B?VWJCRmpVQnVPcmowWEw4cXJsMGxpVm5XVlFTZW81WFFOZ28yN3YvZFViQzRI?=
 =?utf-8?B?RWIzcGt3K0NWL0NjcUhBVU9BbmZVTGJ3cGlicldmbXE2UHhIeUx0NHJxQVBX?=
 =?utf-8?B?ODRFTTMrUWNoUXBPaXkyZDNkUmJhV1VnL1ZwVnFQODN5clhmdTBIYkJsakVh?=
 =?utf-8?B?S1dmUXNwT09hZnRvbmxLVGJ1NU9ZaGZEUUUvazEzR2w5Nit2M2R6Ty9McmN4?=
 =?utf-8?B?dU8vdDExcWFhMzkwcHZVaTlkTll0ZU9ld1ZCbzI2R2pKZDhwcU12ekRyNGta?=
 =?utf-8?B?Q3lrQVI2dEhjNUZzNHJlUFdzVExiblJlVWRKT2hsNytKS25sYlBnM1U3eW1W?=
 =?utf-8?B?Q29KdjZZTmpHVzlHd3dvYm5NS1dqNWcwL2RnK2xzSlliRWZhQ0ZjS2FZR3lF?=
 =?utf-8?B?ZGNVRGYyU25zOHhnSDBDTzNlcVZwdXFsUjFoTGo4SU9nM2dtZjNEcTRYdERG?=
 =?utf-8?B?TW9KN1gyZm00T1FGL1J3TGpqS0hicllkdVF4SWtNQWVPMFBUSUxJclcrYmox?=
 =?utf-8?B?d2dVeHViL0tFRU1LR004RWMzN2VoMGRGak0yOVVQUWl0eVNDVVZHcGNtNEtu?=
 =?utf-8?B?UnlwZUg0YWhFeGxSSzdycEFmajVWTnFJTEVMdUxTSFBHcDhHK24vb3NHeXJu?=
 =?utf-8?B?WEFPZVVWaE9ic1pzWmxIWGpsNkIvZnB0UXgwMEZPWjFBa1pkdVVPaElZdm5I?=
 =?utf-8?B?ZXhGcU5lSWhFNkxsVWI1VWJwS3V2alJ6b0QvdTZWRFFHajFSWExoMUZFaktD?=
 =?utf-8?B?dVlweERLUUp4K2N3UGVuMXp3TWtvYUZqMHFzV1orYkFFZ1lsalpIRzY5aFNM?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <879B4847CA85924C8B2537BA1E377CD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c754bdb-fe97-41d8-2340-08dbbab53c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 15:12:57.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFWgBCjjapCVJ+49qlWt15hXgrC+Fx7c0Pim3eBx2Xsh3AcIi53IYYCy0TKFwq0N+JudCz3Ay2JyjMMPu6ps4OO6gSC4uRmuQMtpiZgy16o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5319
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--34.030900-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGinykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP0xmbT6wQT2a/dsGrGaOKdNtpg
        p4+urkOgeNwaalmieXm9eiKwSUd+IsEBAuoaUqK90BEBFOTiHn1sChor7BLiN80PabessLkcY20
        f1wrB11i6cOIhljP1Ly0R2TzRAIA1md03XlK+nb/OHbIp2eXtYI0ZIn3NG5Q1Zps+y1VXzqbeUB
        Un7dzD+rPqTgY4OT+ZU4JSXFLj5D2TCzF7UO28xDB+ErBr0bAO/zKpacmFSwWecrqZc3vab+r6f
        KqtIz3bzD4h78ZZ5B9vsSE+UFSWkrH9NJG/0SI2eAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZxE
        AlFPo846HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--34.030900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A7033476FE6501AB48957C4CFF4B5009D67CD02A8DB06D79406C4065D93DCFEF2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBUdWUsIDIwMjMtMDktMTkg
YXQgMTE6NDYgLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1h
aWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwN
Cj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIFR1
ZSwgU2VwIDE5LCAyMDIzIGF0IDAzOjIxOjUwQU0gKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToN
Cj4gPiBBZGQgbWJveGVzIHRvIGRlZmluZSBhIEdDRSBsb29wcGluZyB0aHJlYWQgYXMgYSBzZWN1
cmUgaXJxIGhhbmRsZXIuDQo+ID4gQWRkIG1lZGlhdGVrLGV2ZW50IHRvIGRlZmluZSBhIEdDRSBz
b2Z0d2FyZSBldmVudCBzaWdhbmwgYXMgYQ0KPiBzZWN1cmUNCj4gPiBpcnEuDQo+ID4gDQo+ID4g
VGhlc2UgMiBwcm9wZXJ0aWVzIGFyZSByZXF1aXJlZCBmb3IgQ01EUSBzZWN1cmUgZHJpdmVyLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL21haWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gu
eWFtbCAgICAgICAgIHwgMzANCj4gKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0
ZWssZ2NlLW1haWxib3gueWFtbCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWFpbGJveC9tZWRpYXRlayxnY2UtbWFpbGJveC55YW1sDQo+ID4gaW5kZXggY2VmOWQ3NjAx
Mzk4Li41YzlhZWJlODNkMmQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiBtYWlsYm94LnlhbWwNCj4gPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxn
Y2UtDQo+IG1haWxib3gueWFtbA0KPiA+IEBAIC00OSw2ICs0OSwyMSBAQCBwcm9wZXJ0aWVzOg0K
PiA+ICAgICAgaXRlbXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IGdjZQ0KPiA+ICANCj4gPiArICBt
Ym94ZXM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgQSBtYWlsYm94IGNoYW5u
ZWwgdXNlZCBhcyBhIHNlY3VyZSBpcnEgaGFuZGxlciBpbiBub3JtYWwNCj4gd29ybGQuDQo+ID4g
KyAgICAgIFVzaW5nIG1haWxib3ggdG8gY29tbXVuaWNhdGUgd2l0aCBHQ0UgdG8gc2V0dXAgbG9v
cGluZw0KPiB0aHJlYWQsDQo+ID4gKyAgICAgIGl0IHNob3VsZCBoYXZlIHRoaXMgcHJvcGVydHkg
YW5kIGEgcGhhbmRsZSwgbWFpbGJveA0KPiBzcGVjaWZpZXJzLg0KPiANCj4gQWxsIGNhc2VzIG9m
ICdtYm94ZXMnIGhhdmUgYSBwaGFuZGxlIGFuZCBzcGVjaWZpZXJzLiBObyBuZWVkIHRvDQo+IHJl
cGVhdCANCj4gdGhhdCBoZXJlLg0KDQpPSywgSSdsbCByZW1vdmUgaXQuDQoNCj4gDQo+ID4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5DQo+
IA0KPiBBbHJlYWR5IGhhcyBhIHR5cGUgZGVmaW5pdGlvbiB0b28uIFlvdSBuZWVkIHRvIGRlZmlu
ZSBob3cgbWFueQ0KPiBlbnRyaWVzIA0KPiBhbmQgd2hhdCBlYWNoIGVudHJ5IGlzIGlmIG1vcmUg
dGhhbiBvbmUuIElPVywgdGhlIHNhbWUgdGhpbmcgYXMNCj4gY2xvY2tzLCANCj4gcmVzZXRzLCBp
bnRlcnJ1cHRzLCBldGMuDQoNCk9LLCBJJ2xsIGFkZCB0aGUgbWF4aW11bSBudW1iZXIgdG8gMSBm
b3IgdGhpcy4NCg0KPiANCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWssZ2NlLWV2ZW50czoNCj4gDQo+
IFRoaXMgaXMgdXNlZCBhbGwgb3Zlci4gSXQgcmVhbGx5IG5lZWRzIGEgc2luZ2xlIGRlZmluaXRp
b24gd2hpY2ggaXMNCj4gdGhlbiANCj4gcmVmZXJlbmNlZCBieSB0aGUgdXNlcnMuDQoNCk9LLCBJ
IHRoaW5rIGl0IHdvdWxkIGRlZmluZWQgaXQgaGVyZSBzaW5jZSBpdCBpcyBhIEdDRSBIVyBldmVu
dCBzaWduYWwuDQpJJ2xsIHRyeSB0byByZWZlcmVuY2UgdG8gb3RoZXIgbW9kdWxlcyBhbmQgbWFr
ZSBhIGRlZmluaXRpb24gZm9yIGl0Lg0KDQo+IA0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4g
KyAgICAgIFRoZSBldmVudCBpZCB3aGljaCBpcyBtYXBwaW5nIHRvIGEgc29mdHdhcmUgZXZlbnQg
c2lnbmFsIHRvDQo+IGdjZS4NCj4gPiArICAgICAgSXQgaXMgdXNlZCBhcyBhIHNlY3VyZSBpcnEg
Zm9yIGV2ZXJ5IHNlY3VyZSBnY2UgdGhyZWFkcy4NCj4gPiArICAgICAgVGhlIGV2ZW50IGlkIGlz
IGRlZmluZWQgaW4gdGhlIGdjZSBoZWFkZXINCj4gPiArICAgICAgaW5jbHVkZS9kdC1iaW5kaW5n
cy9tYWlsYm94L21lZGlhdGVrLDxjaGlwPi1nY2UuaCBvZiBlYWNoDQo+IGNoaXBzLg0KPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+
ID4gKw0KPiA+ICByZXF1aXJlZDoNCj4gPiAgICAtIGNvbXBhdGlibGUNCj4gPiAgICAtICIjbWJv
eC1jZWxscyINCj4gPiBAQCAtNzEsMjAgKzg2LDIzIEBAIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQ0KPiA+ICANCj4gPiAgZXhhbXBsZXM6DQo+ID4gICAgLSB8DQo+ID4gLSAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTczLWNsay5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10ODE4OC1jbGsuaD4NCj4gPiAgICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gICAgICAj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxtdDgxODgtZ2NlLmg+DQo+
ID4gIA0KPiA+ICAgICAgc29jIHsNCj4gPiAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsN
Cj4gPiAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAgDQo+ID4gLSAgICAgICAgZ2Nl
OiBtYWlsYm94QDEwMjEyMDAwIHsNCj4gPiAtICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxNzMtZ2NlIjsNCj4gPiAtICAgICAgICAgICAgcmVnID0gPDAgMHgxMDIxMjAwMCAw
IDB4MTAwMD47DQo+ID4gLSAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMzUgSVJR
X1RZUEVfTEVWRUxfTE9XPjsNCj4gPiArICAgICAgICBnY2UwOiBtYWlsYm94QDEwMzIwMDAwIHsN
Cj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZ2NlIjsNCj4g
DQo+IEFyZSB0aGVzZSBuZXcgcHJvcGVydGllcyBvbmx5IGZvciBtdDgxODg/IElmIHNvLCB0aGVu
IHlvdSBuZWVkIGENCj4gc2NoZW1hIA0KPiBzYXlpbmcgdGhhdC4gSWYgbm90LCB0aGVuIHRoaXMg
aXMgYW4gdW5uZWNlc3NhcnkgY2hhbmdlIHRvIHRoZQ0KPiBleGFtcGxlLg0KDQpObyBJIHRoaW5r
IGFsbCBTb0MgY2FuIGFkZCB0aGVzZSBwcm9wZXJ0aWVzIGlmIHRoZXkgaGF2ZSBzZWN1cmUNCnJl
cXVpcmVtZW50IGFzIG10ODE4OC4gU28gSSdsbCByZXZlcnQgdGhpcyB1bm5lY2Vzc2FyeSBjaGFu
Z2UgdG8gdGhlDQpleGFtcGxlLg0KDQo+IA0KPiA+ICsgICAgICAgICAgICByZWcgPSA8MCAweDEw
MzIwMDAwIDAgMHg0MDAwPjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDIyNiBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICAgICAgICAgICAgICAjbWJveC1jZWxs
cyA9IDwyPjsNCj4gPiAtICAgICAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFf
R0NFPjsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZ19hbyBDTEtfSU5GUkFf
QU9fR0NFPjsNCj4gPiAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiZ2NlIjsNCj4gPiArICAg
ICAgICAgICAgbWJveGVzID0gPCZnY2UwIDE1IENNRFFfVEhSX1BSSU9fMT47DQo+IA0KPiBUaGUg
cHJvdmlkZXIgaXMgYWxzbyBhIGNvbnN1bWVyPw0KDQpXZSdsbCB1c2UgYSBtYm94IGNoYW5uZWwg
Zm9yIHJlY2VpdmluZyBHQ0Ugc2lnbmFsIGluIHRoZSBzZWN1cmUgbWFpbGJveA0KZHJpdmVyLiBT
byBJIHRoaW5rIGl0IGlzIGEgcHJvdmlkZXIgYW5kIGFsc28gYSBjb25zdW1lci4NCg0KUmVnYXJk
cywNCkphc29uLUpILkxpbg0KDQo+IA0KPiA+ICsgICAgICAgICAgICBtZWRpYXRlayxnY2UtZXZl
bnRzID0NCj4gPENNRFFfU1lOQ19UT0tFTl9TRUNVUkVfVEhSX0VPRj47DQo+ID4gICAgICAgICAg
fTsNCj4gPiAgICAgIH07DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQo+IA0K
