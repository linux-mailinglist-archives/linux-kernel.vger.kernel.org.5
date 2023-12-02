Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C78019F3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjLBCFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:05:08 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2367ED5;
        Fri,  1 Dec 2023 18:05:07 -0800 (PST)
X-UUID: 34a78f7090b711eea33bb35ae8d461a2-20231202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=02ZtMnRozRXegSApGkQu9Kf8TNcgXQotrdEWXys/ysM=;
        b=DbxkIhCE/E0QuOV7onv77/TZmASvD0t+eghYEE+hFEM6wmUqnTh3ENsrmrdZowiKXws2bKG+cijpOYY+BIJDo3uPjok2tsiW976WRamrT3bbcl/vtH1KmxbV82YE8bkiSfGMN618Vm7JW2pJlc7Um3zc88+jUR82PeQxPIDG+BE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:305daf48-e401-4ae8-a76d-9f639d1a8015,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:29ad0e96-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 34a78f7090b711eea33bb35ae8d461a2-20231202
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1069052857; Sat, 02 Dec 2023 10:05:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 2 Dec 2023 10:05:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 2 Dec 2023 10:05:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3oNxD6qS/iz9LR39nOi4GdGpO5ngQz7fntmxAt1VVBtA7pHv5n2aDenjUPC5BFGglJSMtAfeo1Ju1ybOGsKUQ+9fbNFLrmarw0NkZoQg079aCnE681Lksd+8ZTk8SUUnD+HUBJ6pkPWp1cxNnJ0wD4HCU/NZXwXSRvvTJGBkIHRutUDZ+lRcd08LC9KbEa9XP/yKMkZwSasi5HJ8RKUBTJiAdfegYrM5XrQ8vf3XDHtUwYlopSJGfIWn8GtsbK4ZKLjWbyfkrEHgyL+M5TqtgHqf0mUCOX/Nygtwxq7alkrTSPoGg+9rlA1pD7TVSkxJ/O6Wafu/5f9t6dg/qwNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02ZtMnRozRXegSApGkQu9Kf8TNcgXQotrdEWXys/ysM=;
 b=fBTnPDtj9iDik1+DIJBbG4kN2WYRdi/WhcKVCSpqmkKOYgcPUu9Wc7hYSXtH9JDg4fW1ZZ/RyBZP4ZJTiOMUtoFRYTG2Hk9UDrJrnGDtQYKIOfYAZxBFYD6eoHDK/gGSag6pO9WcOvsVtylxUn8pMuAZsC4mv+PJfc/Ygt64bsv+4+2jlm9zBNUTQ353utrPD7Y9A5mm7OQBdAK8aqgOMhyfjE/0hM12kJHOOovH7z6UP2TU58xtvV9Jr5Zfv2gRM8LdIrcvateFJrc5AznudcdHWlXjNA7Nhpp9a0sZDXmwxEIQvw2oN6wOgwmOJbj/L6MX996kgoVwWa0R1zIdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02ZtMnRozRXegSApGkQu9Kf8TNcgXQotrdEWXys/ysM=;
 b=CZijmLsPdkYgHVsteegewBQ5vLghjmiDAMZnKoLtlnPcKFTA7zK+DvIszpERVZLTgr5KwltVYznkww3P+LuEc0thTu62/zOGsfD4N8QCzSr0/sswse3SZQRrlpVv0iq/kenlx+B2rkSi1DJ7aehoGXhpzUVjOX4+1vn+avMVuRg=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by TYSPR03MB8990.apcprd03.prod.outlook.com (2603:1096:405:cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Sat, 2 Dec
 2023 02:05:00 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::6a1:5b59:1d76:5ff8]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::6a1:5b59:1d76:5ff8%4]) with mapi id 15.20.7046.028; Sat, 2 Dec 2023
 02:05:00 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "treapking@chromium.org" <treapking@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "ot_shunxi.zhang@mediatek.corp-partner.google.com" 
        <ot_shunxi.zhang@mediatek.corp-partner.google.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3] mmc: mtk-sd: Increase the verbosity of
 msdc_track_cmd_data
Thread-Topic: [PATCH v3] mmc: mtk-sd: Increase the verbosity of
 msdc_track_cmd_data
Thread-Index: AQHaJEEfMlM6rI5rBkqBGcD+fvIQRLCVP2QA
Date:   Sat, 2 Dec 2023 02:04:59 +0000
Message-ID: <00568ba8c40d034bfe6ba08f25b114f2b2955308.camel@mediatek.com>
References: <20231201102747.3854573-1-treapking@chromium.org>
In-Reply-To: <20231201102747.3854573-1-treapking@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|TYSPR03MB8990:EE_
x-ms-office365-filtering-correlation-id: 619f6648-d538-43dd-ce1b-08dbf2db1700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqBW9WKYk2/GxNqnPPsHHA87dl/himjETPv6e2cAJviiEKU89fRw1Wh4T4U00wPEvUPRUSnRhAHXq+DvnbyjL11cd/Pyq3J6yGB1TrY0K1STYEknu0Ktq9OQGM2muU3J3k5Ns7mts1V/5bhtGg/cRwxdBdrU+/4oemHiTeCZeZRdhi3z6P26rFZV5cdPHV7dmE07+ImSj+9jUlqkJe9anFuQUBdWCDJOEYoELdIsnnpAWdG7v+w87kFzTGtv6RT/JMz6By9kerj4P53y+PVv41B+hTq4zO7BRZL/b/uRAqdiuhDWMysWuL7gLklv03Sr15hhsiotjk6rEtcwEfXVJAOHJtfSkmLlfQhaB32WuS00xnqVNnh8nlPBJ7x2Ky1cJcF+8MVO9iEH8O3HNa9UE+DJul4dZ9Oq0a81ZkhrtTX1slQhrgSieiN+Je9au1Vs5oUE31Ed1jEg7GTLOHM0NlOuJezvw3ueHf4SYJIJHRD7tz1x5Y7ILlCcN7FEjFZwZn3u1bCyKuepT1UhLc+e8gdLdvVXMBdeJBlMkezf8irHVC+vOI+Z7zvno507hbxNbsnOmEV3B6Jz25g5XBV8acklXiVXZ/Qz8b0eA9bqBJroeEupyrACAZtYQvm1KqCbigzAmCDwRpWmNaFWR2hux5jR6iAB9wXmguihky1NR7U1qqtASvkLbKYctbJnWGidBj3yXstuQtMDqy8kvT4qXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(38070700009)(41300700001)(36756003)(85182001)(2616005)(6512007)(6506007)(83380400001)(26005)(6486002)(478600001)(71200400001)(38100700002)(122000001)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(6636002)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTl0RVFoM0NpOG9WbmVXOGxQTmRjSitlNHVhUVExY3RQOGdncUxsbHo4SHNQ?=
 =?utf-8?B?NFZvcmFMLzZ0cURtVloxdVJzeTRtMmZxYVZ6UklNOGZXdlgvMkM4cTA0T21B?=
 =?utf-8?B?WlpDNDhoWEY3L3ZZMWlXUEsrMERGMVBJdVZ5OURHL2RDOTgvanlna0dSZDFw?=
 =?utf-8?B?eEIzenRwcFozRXhpSklxSDFnSGxhV1RUbmJnVDRSaWpkZ0hsVUd2MWQrTVFw?=
 =?utf-8?B?MVh6SWVOZ3JyNmk1Y0kzOXFablFYaHcrT1UyRFAxZFplSTRzVm5sVy83MnQy?=
 =?utf-8?B?SXNLUlQxQjZSQUl2aG1SbVZkKytWNmtrc0xUeWI1N1A1RlNPSkJtVlNUSUJS?=
 =?utf-8?B?cncrNHNyRWErVzk2c1JsQ0o5TGdRR0JncGFwd3J0SENkRk5QWXg3TGNYSFdY?=
 =?utf-8?B?UlRHWmxrVUVwMWJvZjl0bVAvQ3JzS2J5NTVQa2lCYkRBQnhCdCtyU0txRDhX?=
 =?utf-8?B?T1JhYlY2UTE1a1Q0bmdWT1VVeTl4Um92bi9qVFNFN2ozYVc1ckRYMWl6SXpt?=
 =?utf-8?B?ZThNWGx1QVdhTDlqUGxMUVpVajdtdFZWYjFEc2ppelQ1cmtLOGlxMXFpUEEr?=
 =?utf-8?B?a0RNWEl4TUNyQ0E2dy93R09DNCtMd3cxSEoxTEJsNWlHVFlTYkhMSVFDaDVP?=
 =?utf-8?B?T09KR2FuZ3pMM1QwaVovazRJVC84d1JtZ1ZNbU9MUTliaEFQZkdBWUwrY1Ni?=
 =?utf-8?B?bzRzRklsMjA4UTFrSWdLRy9VdkpCeW13Y1hJK1pldGozaHM2UkI4bDZIMm9j?=
 =?utf-8?B?bGQvTWJGRE4rbEljY21rcnNrUG5TWmtXdm5udUhZQVBkZ0x0clRiUzBXNlN3?=
 =?utf-8?B?elg0SlNIWjUxbjRPQ09XM2RDeTdKbXl2THhqQzZVYzdlTXB5YVpzY1lJblEy?=
 =?utf-8?B?aDdTMGFqZ2I3UkVTRWY2QXAyT0FLRDViSDc1N1NkclBPbGpCVHFDR3RpakNU?=
 =?utf-8?B?N3FCS1BFaXZtVS9FY2FZaHBZQ3FVNW5ZdlFiREEwcXNCRm4rMkFHT3lkMy9D?=
 =?utf-8?B?VFp0dDRoM3BMbkQvYVhxWTA5OXFsdk8vSlRJSTZLbElNUTRRT2IzM3VTeUky?=
 =?utf-8?B?ZHNBVjZlTnF5KzMwM1FZMXFYMmhyVVN2dlNpZmx1UEpKM2hwOVdzOC9rSmc2?=
 =?utf-8?B?SXV6SGJKVURsUys3T3lodzV5UVNRWU1CK0w2SE14KzN3alZLSjJ1a3Q5YmJG?=
 =?utf-8?B?ZUQzWHlLS2pFOFpMWG5CZGJGeXZYUkdzbGVGMUF1bHZ0M2dycU8rcnZMbXUw?=
 =?utf-8?B?c3RQeVVqVHhBelVaR056NEkySXArVXFNdmNTRjc5eTlvOFNyVXgrSTZQMng5?=
 =?utf-8?B?N0ltZ3dzbmd4VmhSbmg4cm5lWG0vdmt6dW45UG9BMlY4ZGpVNGtwalcrUjRX?=
 =?utf-8?B?eHMyMHlCUndTMjRFRmRUanpSd1dPZUE1RVVQUi9uV25JeENUbDVFZ3FwUGhW?=
 =?utf-8?B?Y3l5d1hNVG9aRysvTUdQM096RTlpay9xMGlyUHkxZ2dvdC83VkIxZ3E0WUFn?=
 =?utf-8?B?NHBqN3dqZHRpNWVVYm1nelRjMEs0K1REOWg5eWN0QTRrTGMvRzdNWnlQNkdF?=
 =?utf-8?B?d2hXZUZURnFtc1NhSm1LZ29aczJ5NXk5VlpBZFl3ZnVpUGh3REw3cWJWcmZG?=
 =?utf-8?B?VmlCaE81NU9KV1NSa3pwbzRLUFRSTTAvc0QzY0lIcmFYdytHTEtqME5Wd0RM?=
 =?utf-8?B?Wnh0Q1J4dXg0VlpNRUdqR1h5Kysrd2xUMzNDemFLT3A3dlJEUnFuS3Y1ckhE?=
 =?utf-8?B?SUNFRFRnREMxTGpkR011RnlLYVR6TnBhc1krMzY4TUpsd1BxblZXTm5jTWsz?=
 =?utf-8?B?UjBTZytvenNtM3ZEYTdqNXNaSERRMXQ3bHFidDN4Sks1Umpkdk9SUENQbUhR?=
 =?utf-8?B?cGxQY0w4RzhqdjVscmlqUDJtbWdkQ3lQb3pyUWhQRWp2MVVJVDlwd0xJSko0?=
 =?utf-8?B?MkVjbUpoekFvVzBmYW5oWDZNWnV2THZYRGJqeG5rcUR3UzhMeDRZU05hcXlE?=
 =?utf-8?B?dHd5cEd4WHdyUnRGVlNvcXNYWWptN2c0RlJETFpDRGZ5STR1NlhRZjBObWww?=
 =?utf-8?B?RWY2VC9sUTlqVHdWeDlDZlBOTElRUGZZdGsreERoVU55a09HNU9uTHZxSGw3?=
 =?utf-8?B?bkNlcTEzUnpZWVgvSXpUYmhnS1JaM3huMGs0UDU2RjhsVkhIanViQ0xQUXl0?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F4077A071F2F40BBD9A5B1E1027C94@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619f6648-d538-43dd-ce1b-08dbf2db1700
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2023 02:05:00.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CfcICjTBRsLOa4JuAdSaKVxXlMmQX7uBmw1v2vUuCkA3mFG82ADS2y8ya9RXVmuNpMVQaMZjMjL+POWl7kZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8990
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDE4OjI2ICswODAwLCBQaW4teWVuIExpbiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBUaGlzIGxvZyBtZXNzYWdlIGlzIG5lY2Vzc2FyeSBmb3IgZGVidWdnaW5n
LCBzbyBlbmFibGUgaXQgYnkgZGVmYXVsdA0KPiB0bw0KPiBkZWJ1ZyBpc3N1ZXMgdGhhdCBhcmUg
aGFyZCB0byByZXByb2R1Y2UgbG9jYWxseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBpbi15ZW4g
TGluIDx0cmVhcGtpbmdAY2hyb21pdW0ub3JnPg0KPiANClJldmlld2VkLWJ5OiBXZW5iaW4gTWVp
IDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0K
PiAtIE9ubHkgcHJpbnQgdGhlIHdhcm5pbmcgd2hlbiAtRVRJTUVET1VUIG9yIG5vdCBpbiB0dW5p
bmcgcHJvY2Vzcw0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBVc2UgZGV2X3dhcm4oKSBpbnN0
ZWFkIG9mIGRldl9lcnIoKQ0KPiANCj4gIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCA4ICsr
KysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJz
L21tYy9ob3N0L210ay1zZC5jDQo+IGluZGV4IDk3ZjdjM2Q0YmU2ZS4uNmFlNWUwYTlmY2E5IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3QvbXRrLXNkLmMNCj4gQEAgLTExNDksOSArMTE0OSwxMSBAQCBzdGF0aWMgdm9pZCBt
c2RjX3JlY2hlY2tfc2Rpb19pcnEoc3RydWN0DQo+IG1zZGNfaG9zdCAqaG9zdCkNCj4gIA0KPiAg
c3RhdGljIHZvaWQgbXNkY190cmFja19jbWRfZGF0YShzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCBz
dHJ1Y3QNCj4gbW1jX2NvbW1hbmQgKmNtZCkNCj4gIHsNCj4gLQlpZiAoaG9zdC0+ZXJyb3IpDQo+
IC0JCWRldl9kYmcoaG9zdC0+ZGV2LCAiJXM6IGNtZD0lZCBhcmc9JTA4WDsgaG9zdC0NCj4gPmVy
cm9yPTB4JTA4WFxuIiwNCj4gLQkJCV9fZnVuY19fLCBjbWQtPm9wY29kZSwgY21kLT5hcmcsIGhv
c3QtPmVycm9yKTsNCj4gKwlpZiAoaG9zdC0+ZXJyb3IgJiYNCj4gKwkgICAgKCghbW1jX29wX3R1
bmluZyhjbWQtPm9wY29kZSkgJiYgIWhvc3QtPmhzNDAwX3R1bmluZykgfHwNCj4gKwkgICAgIGNt
ZC0+ZXJyb3IgPT0gLUVUSU1FRE9VVCkpDQo+ICsJCWRldl93YXJuKGhvc3QtPmRldiwgIiVzOiBj
bWQ9JWQgYXJnPSUwOFg7IGhvc3QtDQo+ID5lcnJvcj0weCUwOFhcbiIsDQo+ICsJCQkgX19mdW5j
X18sIGNtZC0+b3Bjb2RlLCBjbWQtPmFyZywgaG9zdC0+ZXJyb3IpOw0KPiAgfQ0KPiAgDQo+ICBz
dGF0aWMgdm9pZCBtc2RjX3JlcXVlc3RfZG9uZShzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LCBzdHJ1
Y3QNCj4gbW1jX3JlcXVlc3QgKm1ycSkNCj4gLS0gDQo+IDIuNDMuMC5yYzIuNDUxLmc4NjMxYmM3
NDcyLWdvb2cNCj4gDQo=
