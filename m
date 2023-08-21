Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76798782379
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjHUGOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjHUGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:14:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0ECA2;
        Sun, 20 Aug 2023 23:14:07 -0700 (PDT)
X-UUID: eca631d63fe911eeb20a276fd37b9834-20230821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yBPHOLf7rsfSwOWccuOVuBYF3cDwCxGd2Me4R6aT2Ss=;
        b=oM0oECP5+a4UK57MNz37OoI9I9OkTB1hQdiU/QujH20FXcCqrGoxn+dKGTZ2gLscHsnn5ErF4Z+CFUHjqvKCv7AdBKQQemCoENgbxMoT8GYSdUfPYrJdOTmIiIzEZOpSDF3ktNA+Y9z4eO2ABw6rjDGCO6IN6ALY9eP+Hax7JeY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9b75e7ef-f116-445a-9662-052817eeed81,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:a0fc8e1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: eca631d63fe911eeb20a276fd37b9834-20230821
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1142938822; Mon, 21 Aug 2023 14:14:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Aug 2023 14:14:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Aug 2023 14:14:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEqCubCXCeLmoVJXBF50V7Ni5uPTjAEKVsqTkTR7i2e05K23l2tLQ2iau1kioZo6Ug9xMs7waN6C12+Y4yXjciLc9sUZ2qf541se3bL3BEYjKq9Zv/hCK3oyOSit6ibWjswyh74Zu5Iz5/Vljo+jpc5XvJ09OkdbPrb7iAQjzQx9AXK+qbwfRb2qODw3L6ehPXnEgVFB7rkyQv2d3nEROGuX1YHSoZydWuPNS2AZTJ3rib596KmIMKYONi670mfyAe7iqjBT35TpzrUFLoTq0V50bLWgKjfuZRshwXhtymWd2mQuX784LrI7CFl3mKxvAGt7g7/5uFT5iNNLUaIXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBPHOLf7rsfSwOWccuOVuBYF3cDwCxGd2Me4R6aT2Ss=;
 b=ggJf+qiwY9aFgfgUnK1nVQZE6bUyI8G6G1VAaHfMmUEp+8oxM2Po+hUSrILs9MKls2Vwo7Kv7JEGWcBuGEfzsAZfGxibq/j9yeAZwqpaiQxAOfg6liljxZGOIrpGt/yKDVh2ZqhGQWBtH4fT5vrEBEasE5vVw5JkwhAgjT/Kee+fFS2J+kHgOaCO/DMI4DmW7rQrWCW20CybPOnPdNtbqBkdPvPQnPoNpH+tI96bJ1jpL7jiHmo6WvTa+V1p5KgD8U2c+gMoL9VSVVsPGrS10hhk8idBqFJ6WPdq44wUEZIoNZlUTJQ5jTiRNELBSzKLk5Ge3ZKlGcIGWak858faZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBPHOLf7rsfSwOWccuOVuBYF3cDwCxGd2Me4R6aT2Ss=;
 b=fBchqAOWihuR5qA1F38vW86RcSGYHgN6MopXFt8UIp4ZmiRePTNu30KpSYDxMDRhcIwO3yv0ydqtaumP/NzuGmbFldACt6k6V+cF/4J+6rJcgpdpwPAmeTBVLQVSfQgDyj7UBz6q/Onf+u1kQc5BrbQiuUmu5lJWNj8ibqdIeuE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6859.apcprd03.prod.outlook.com (2603:1096:4:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 06:13:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6678.029; Mon, 21 Aug 2023
 06:13:58 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v5,4/4] drm/mediatek: dp: Add support MT8188 dp/edp
 function
Thread-Topic: [PATCH v5,4/4] drm/mediatek: dp: Add support MT8188 dp/edp
 function
Thread-Index: AQHZ0NPU24OOWNH5V0OU15OsSP+qc6/0S66A
Date:   Mon, 21 Aug 2023 06:13:58 +0000
Message-ID: <1d41747060c613ca0ae8e3b6395cc33bfa4d9056.camel@mediatek.com>
References: <20230817062635.8786-1-shuijing.li@mediatek.com>
         <20230817062635.8786-5-shuijing.li@mediatek.com>
In-Reply-To: <20230817062635.8786-5-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6859:EE_
x-ms-office365-filtering-correlation-id: b60d42db-0d05-41ba-08c5-08dba20dce77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGecEeYo+7EdhiT4cxA0v1GJjUWNlYMkw/965Cjq5dtDxvZerzMiW0JOzz8x5yRBhquEo3q7TfKfYQulheKCjUwUvUIgNRRRwgMX26YHhKOLfLNscbZ1kgeAX3r/5M4FtHLTKbp80CHuceibSdROrQZnvf4ydPq+m7pOlEjjsAAjGfOjKRV51jcFpT+PBChIQ1Ty++CjvEptPwmP92fiRiXaFmALj9oD7aXf+heRTH/jD+hkGZ4fqE/gW0dyJ9awP5Clq5LXudBlL83Ob08fyH7V93KZSdNTnN/TaZO9+nOt3lcPKe2I3AIuI8xQe+7CdGX45VXz2yw4oXhQS1m0wGtOFdajEL5cZTdeOYL9yoilWg0569wtPDYC23AOKxKlGP4ja4QsDhWUmM4a1fZqA+CAwUh4n6b1rfHLKNycfemTTVxxAg+42uZgs2CBZjotAMmvv5qDi+QNQNVomAjm/Fste1q+ZwyhMhuZa8+QyGbXB62+Ylh1TkkLtotntDd0RhierZJx9PgRr1MCMKX48jLGWnFoyrtz6IlssbKNquNx3Y+hFkU0aofnNALCYftBGQp8pj9UvddJFyuSvz/zu0xwittyoNgwgFQLCQlwy3EVkmn9Qea9ALaWgQHajiX4YpnD5PIBB3Sf82pmhS38oTgqwYv1FwvrW9vDPG7DSXX7DKaS+5WRyJzi5Jz7CJPw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(64756008)(2616005)(107886003)(6512007)(71200400001)(6486002)(26005)(6506007)(83380400001)(8676002)(4326008)(8936002)(5660300002)(2906002)(7416002)(478600001)(41300700001)(966005)(110136005)(76116006)(316002)(66946007)(66446008)(66476007)(66556008)(54906003)(38070700005)(38100700002)(122000001)(85182001)(86362001)(36756003)(12101799020)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDBMcFQvSEdtZGRaREoxRUlGQXB4TGJ6OFZSUE1VOXl2RW5ackdrVGRFMXJ1?=
 =?utf-8?B?NnVwaDZZbzc4cFRlL1p6M2JZR3JVM04xNS9xZFowQ1NIdC9tMEZrakxYbWl1?=
 =?utf-8?B?b29kY0t4NHJ4emtJamNyekZhR2ltZ0xwZWVhc3Fuc3BXdHo1QkV0OURydVdw?=
 =?utf-8?B?d3hFSSthZlVlc0UrV0pEUnBTeGw3SEFoS2V6NzNXSGlXLys1MldJYThKQ0hh?=
 =?utf-8?B?alBuSUVOV08yYzZ5TTNFVStuQXZMcS96NzhjUTFDbTNIcmIwbWFjSUxZREkr?=
 =?utf-8?B?ZmtOeTVTQWptMk1CM2pOZHhlemV0Sk1xRWxnK2JaZjBLZ3hpUzY0UzU2Nmx3?=
 =?utf-8?B?QnNxSU9qOFlEN3prRmk1TSs4MWR0NUROeDA2Y3JYdGs4bFpLVUlxdGdIeU1h?=
 =?utf-8?B?N2RCVEZRc0FFbWtjSjVkTnJxbzI0MmdJR1FDdi8rQlI0RGN1d1RqN2EyNE4z?=
 =?utf-8?B?eVl5LzVaMU1od0dUTGJKZXcrRWJQSlJ5ajd6REI0QjlCb0xxRTUwcERoMkMy?=
 =?utf-8?B?Y0lKSjhNUTJNeEY5OXdTMkF3YlNmYWdoVTk0bGlNUW8vR0djZ1EzNkNYNDQ3?=
 =?utf-8?B?R3A0eFRERFN5OTJ1aFc2RVR3WEU4N1cwaXlOQUZYSHBrNGpWTFlvTE1lQ1ZH?=
 =?utf-8?B?QzIwUFRPcUc1OUFCY3RQeXlCWU9sMEVucEo4RWxGV1NwZWljS2U3UXBicHVr?=
 =?utf-8?B?bWtINkNyYjN6Q3FXd0hCVG43eFBsTW82UnRwY01aMVRjdVUzZzJteGlZaG5x?=
 =?utf-8?B?aldVYllscHZTVS9HWjVROHJ1ZkN0Q1F3UjUxTEZOckR2MFpUUk9NSUFIYzVm?=
 =?utf-8?B?OXdLYTB5UGd6NDNkV3g3OVdUKzRmeXZhMk1zbFV6dUdwN3JRYjc5NjlJK0RV?=
 =?utf-8?B?R01RV0FXYlpKTTNJQlptSHJUSDlQdW8xVHJGYUxFNkFEb2JQbVA3NTE3L3d1?=
 =?utf-8?B?UWZJalV0dUxiOFFrZjh2ek9wN0RUaWVCZUhPcnJpdlE1ajJCcm9tTXFWQUlL?=
 =?utf-8?B?NERMVUduMEpnUUpudmRyM2RzR3M1aWtKOStIMXFCb0MyUVIvRW8va0htTHlX?=
 =?utf-8?B?Q1B2RDJSdWFKcjkwSWh6bDJPTVREZEx0b2JYbGtHc1hiMjFEdy9TMWRaQ1Rq?=
 =?utf-8?B?ZnFLT1Ixd2tyZ3BQTFc0aWNOcEY0bWZDTEFmdkZzT21nQU9oZXBKRVNEVk5I?=
 =?utf-8?B?TVgrUDZNWTRUbTdWbkJ5WGhvQ1REOUtGUUxtQU56UWFiam9LZ2VESFpYQUlw?=
 =?utf-8?B?bURkenl6SkJ0YjAyWE1OUHh3VmZENFRuc0huMy9xMVcyYko1aTBvMFh5Njhq?=
 =?utf-8?B?dGNscW9WZGU0UzBXMjJpYU1aR1BDcHNzVWdrU0RGalhyajV5dGpzNlpnUXpa?=
 =?utf-8?B?WDlSSGhOVFVCVDdnUStHcG82U1BoQ1lSK1Z2THNSa0x6cXdhcFpJWlY4a2tq?=
 =?utf-8?B?cENzaldITGJOR3FLZ29GWlNwV1EvUDJEOTR6OFRpcm5DVFpPODZ3aTZqZ0o4?=
 =?utf-8?B?NTlrMVhKSVlXWCtCaXNqdGtLQU5VL1orREQxZGpGSG1uVU5Pcmt1Z2ZwRysx?=
 =?utf-8?B?QzVnbDJFYndOZnE2TE1kWUx6OTQzKzZkQUJQSmVqL1lDOFgyMjBkTGx1M2Vi?=
 =?utf-8?B?SW03MzB2clpHSG9ITmMwcW1pVXJsNytNWmJDNkdJSDVhakYwRFJTai93eDlo?=
 =?utf-8?B?ZnhmdVcvWEFxLzByeWdGVVB1UWFkalV1aFluTE9oaVpDbmw3bVFBOXVWclNQ?=
 =?utf-8?B?N0pJcTI5cDdIeTdYQVF6ZDcwMnduMjJsS0hnQmV0WFplNTFYdUMxc0NFTytl?=
 =?utf-8?B?dkltazdBVkt3SWhETjN2OEVJZXdlY05FcVNBRVpyYUIrTlJhUFgrNlpSZUUw?=
 =?utf-8?B?VDY1VDhSTHlmWnFNdUNRUFFZL0VKV0cyOVVmendoT3pxQTVDWHdRYk5VRmFq?=
 =?utf-8?B?SkVud2xKTTd5SE9wSW1JTm8zTHhVUWRmalpHRENkQlprbjVIV0ovQm8xbFBu?=
 =?utf-8?B?bVlYazVjYXFZdU1pQzAwYVhRVk5vbmI0UnhSaFhucFVzY3ZNcGdvamtCOHIx?=
 =?utf-8?B?aHJud24xa3RtZGxPMHJ1L0pNVEk3Y1h2c0FNeG9uQ1IvbDJrSHVrRXArV2x5?=
 =?utf-8?Q?WwNDJlLGQrVJ4XpsruTJDN4if?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B8E3D1F996C72429BB388D12E3EC85C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60d42db-0d05-41ba-08c5-08dba20dce77
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 06:13:58.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZGY2NFiP5KvOv8Z7RbtjHsgQC96Y5ufxd9Qe4h/t6u9lc/ZyyO7Mpb8HlXVqofTPJrTMjbK+/WLyjfPK533aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6859
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjMtMDgtMTcgYXQgMTQ6MjYgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGQgbXRrX2RwX2F1ZGlvX3NhbXBsZV9hcnJhbmdlX2Rpc2FibGUg
ZnVuY3Rpb24gZm9yIE1UODE4OC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNodWlqaW5nIExpIDxz
aHVpamluZy5saUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY1Og0KPiBTZXBh
cmF0ZSBtdDgxODggcmVsYXRlZCBjb2RlIGludG8gbXRrX2RwX2RhdGEgc3RydWN0dXJlIGFuZCBt
dDgxODgNCj4gZHAvZWRwIGZ1bmN0aW9uDQo+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZp
b3VzIHRocmVhZDoNCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2MxYzg0NjE2ZjNk
YTgzYThhMmJjMjQ1YjBkM2M3Njk3MTUzY2Q4MWEuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYyB8IDEzICsrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcC5jDQo+IGluZGV4IGZiMTEwMzc0YWQxZi4uNjc5ODZkZDdjOWQ3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC0xMzY0LDYgKzEzNjQsMTggQEAg
c3RhdGljIHZvaWQNCj4gbXRrX2RwX3NkcF9zZXRfZG93bl9jbnRfaW5pdF9pbl9oYmxhbmsoc3Ry
dWN0IG10a19kcCAqbXRrX2RwKQ0KPiAgCQkJICAgU0RQX0RPV05fQ05UX0lOSVRfSU5fSEJMQU5L
X0RQX0VOQzFfUDBfTUFTSykNCj4gOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBtdGtfZHBf
YXVkaW9fc2FtcGxlX2FycmFuZ2VfZGlzYWJsZShzdHJ1Y3QgbXRrX2RwDQo+ICptdGtfZHApDQo+
ICt7DQo+ICsJLyogYXJyYW5nZSBhdWRpbyBwYWNrZXRzIGludG8gdGhlIEhibGFua2luZyBhbmQg
VmJsYW5raW5nIGFyZWENCj4gKi8NCj4gKwlpZiAoIW10a19kcC0+ZGF0YS0+YXVkaW9fcGt0X2lu
X2hibGFua19hcmVhKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwltdGtfZHBfdXBkYXRlX2JpdHMo
bXRrX2RwLCBNVEtfRFBfRU5DMV9QMF8zMzc0LCAwLA0KPiArCQkJICAgU0RQX0FTUF9JTlNFUlRf
SU5fSEJMQU5LX0RQX0VOQzFfUDBfTUFTSyk7DQo+ICsJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19k
cCwgTVRLX0RQX0VOQzFfUDBfMzM3NCwgMCwNCj4gKwkJCSAgIFNEUF9ET1dOX0FTUF9DTlRfSU5J
VF9EUF9FTkMxX1AwX01BU0spOw0KPiArfQ0KDQpNb3ZlIHRoaXMgdG8gcGF0Y2ggIlsyLzRdIEFk
ZCB0aGUgYXVkaW8gcGFja2V0IGZsYWciDQoNCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX2RwX3Nl
dHVwX3R1KHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gIHsNCj4gIAl1MzIgc3JhbV9yZWFkX3N0
YXJ0ID0gbWluX3QodTMyLA0KPiBNVEtfRFBfVEJDX0JVRl9SRUFEX1NUQVJUX0FERFIsDQo+IEBA
IC0xMzczLDYgKzEzODUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfc2V0dXBfdHUoc3RydWN0IG10
a19kcA0KPiAqbXRrX2RwKQ0KPiAgCQkJCSAgICBNVEtfRFBfUElYX1BFUl9BRERSKTsNCj4gIAlt
dGtfZHBfc2V0X3NyYW1fcmVhZF9zdGFydChtdGtfZHAsIHNyYW1fcmVhZF9zdGFydCk7DQo+ICAJ
bXRrX2RwX3NldHVwX2VuY29kZXIobXRrX2RwKTsNCj4gKwltdGtfZHBfYXVkaW9fc2FtcGxlX2Fy
cmFuZ2VfZGlzYWJsZShtdGtfZHApOw0KDQpEaXR0by4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAlt
dGtfZHBfc2RwX3NldF9kb3duX2NudF9pbml0X2luX2hibGFuayhtdGtfZHApOw0KPiAgCW10a19k
cF9zZHBfc2V0X2Rvd25fY250X2luaXQobXRrX2RwLCBzcmFtX3JlYWRfc3RhcnQpOw0KPiAgfQ0K
