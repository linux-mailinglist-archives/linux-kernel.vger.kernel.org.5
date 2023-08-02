Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7076C3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHBEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjHBEM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:12:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842EED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:12:26 -0700 (PDT)
X-UUID: c6c88d8c30ea11ee9cb5633481061a41-20230802
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TKGOGyT/WIBJzEhdDa1avW3f/TarmTTPOzZ3dh6Prpg=;
        b=nnqN3bNcT7lRLAOeYryb7kFYpG+aALFyZcvcvxzs8GtZbbLpy2DJbVY2PWm7+ppqBP1h5aGFghRlh7HaOJafoRyL1B5umxHQ9RWMsLgOuUwTvFfHIcLkW+0fvGkmnOdGAI5ejAbaHRIHx5QEOHlHnLbX6CL73/IoCObTwByVNJ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:606f5493-e0c8-4653-bf36-263f741aa3c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:606f5493-e0c8-4653-bf36-263f741aa3c4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:81cd0db4-a467-4aa9-9e04-f584452e3794,B
        ulkID:230802120342SKDK82UN,BulkQuantity:6,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: c6c88d8c30ea11ee9cb5633481061a41-20230802
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1803137304; Wed, 02 Aug 2023 12:12:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Aug 2023 12:12:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Aug 2023 12:12:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btJIVfHmfUvCHsdYGjYa3d/Nq9Bzg5VABWx0LIyIc/ESdoUe2/tHCS/6TaqzIFZIs6DdjTBuBYVe2utP1s2qcD//jWCr/+rkWLFLutVfy7jq9j+XO0qUgwmiJLF/FTVIdpttwcuwVfO8S02CgcJeQcr3YozcrGK81uwL4WnAEiVlMcqDBst0DFTd1JWqJgUZe81em4EI6RA/+ehgUemt14Isv3HUDArz4M9f9OKoYCV48k9o8Q32css1ohK/pDnIrTGPtMkdHjqVEtwsWrz6twzvZpIyhs9z/2JOv9DpD72o5ZsGnUkxovXiole6vGqzJzf5CU6oWiE2ZlXprWi4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKGOGyT/WIBJzEhdDa1avW3f/TarmTTPOzZ3dh6Prpg=;
 b=PlJYN18cY0XaJHsR0xHZtwfchZUBxA0FdX63APS+QIflKCwOjaqIoZc+/4xrEYkJAn52JwKqnPffxizvuHVFQ8RYO8j1F0HcfYL08biO4bJ1rWdA/NQGG458wintN98zA4mOTXHFJoLniTanldqjapq5uWzukCYjbtHDUgUznYG6LOFC3njQ7A/CA85lbfQ9XOldjwZ704oJZLG+ILDSdWV2w+3D3M6rHZU18NTZ5tI83ElUP7lYaBBzVl3ORjwLMEyqwkPacRD0IehQr3TW/9/dDq3S9H9+OzS0xF+d96nmHq//PD8FPIrcDBpsRt+Ua/GrFvyeb3V3UBu5vFR3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKGOGyT/WIBJzEhdDa1avW3f/TarmTTPOzZ3dh6Prpg=;
 b=utxpcIlD0sJONyiSLy6LaqLE+y2wcJtAB0fCtAWErlW8vgJHlgl9VelxtbZqbLQktUjXZjqSSp8xv7HfFoelthTlOcGx1Pp5OJpVHz+cMCU9F3fBLJJ/vF/gWl/UtMOlpNd/LaiKiWzHYSi4c8MH2llj6vfNHFXDZ2+pPrVPMHA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6471.apcprd03.prod.outlook.com (2603:1096:400:1c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 04:12:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 04:12:18 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v8 08/13] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Topic: [PATCH v8 08/13] drm/mediatek: gamma: Support multi-bank gamma
 LUT
Thread-Index: AQHZxG+ywRwsuWkUMUaJbHLP3rmfya/WZiyA
Date:   Wed, 2 Aug 2023 04:12:18 +0000
Message-ID: <92e1ddd531f9b029b89b1f234b9a1dfbb38d454a.camel@mediatek.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
         <20230801115854.150346-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230801115854.150346-9-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6471:EE_
x-ms-office365-filtering-correlation-id: 2d6462b0-d9a5-4ea6-c75f-08db930ea953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBadRUhxBYI7wyQ2Ec/RhyOacS/WfEVqZz4ZAC1+VrK36iudwk/TIBV0IUEKEW2oZxhaSCW8iijvHP7xtHfHar5RxcR6meaKI92Um3U3Ws1uiN+lVIUPtnyRnXSv3J3cxEOIeyeJrGc02YqIgpfF0bhCj5z4so7iud/ibGqoRiaeTlI1+tVv3dTiih+h2o27er2yX6WWdQZU60O2/edX6yq+UjX2bkeifRCMp7zAER+Z91rEyla2dMGlsCglQNvoGwak9649EQEMg3E9m6Z/CXUCSnMCwJeVVakYmyKy1wAgy3QHLmmldyFoQfXbvzlvfL+5k3ffsqMhomHJ+ZInibewr2JDcYkbz6C2cU08MDFcX0peHZDjM8yT8LGQRk7bQ7GBf3GBTJPJcmVRChUft+/2O6kcYCyCyBv1tPXus6/BHH7l5disqOPJdPAtXTiJPKY//lQEp38mn6G+Zgj7HRtrDuSMPkrz8hQnU+1bsfxBQagOgOfEhKeaa1k8uMXqta/RXw+h8f2xnv/PsY7EnOugaDQ5goBPp81+qrrfqjS8h5TMdRtBVnz0eRPtB4O9YTzYmbQl5zXjsgHal6zt5HPnb3Yw2ZerxknSwBWzFSLhyeAVWGLJI8463w5j1YZt4s2T37vi3DyjgJKJfKXm1ZEuK9sZO83z198hnQyaoMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(36756003)(83380400001)(64756008)(66556008)(66476007)(66446008)(66946007)(2616005)(316002)(4326008)(54906003)(71200400001)(110136005)(6486002)(478600001)(6512007)(186003)(76116006)(26005)(6506007)(2906002)(15650500001)(38070700005)(7416002)(85182001)(86362001)(41300700001)(38100700002)(122000001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REViREJCMDRsQzN6SHJ3UitWNnZZMVI5cGo5ZVRGbVJOSXlXRU1WWWoxNFFv?=
 =?utf-8?B?NC8xUmwxWlh3SE1UK25JSE1JM01JQWNoa3dHSXBidWxRaWhpUlBkUCtRM01K?=
 =?utf-8?B?bmtvd2cveTJ0cHMxWGp3eFBpVHhLNmVrWVdWZkVTMnowcFZvNTh1R3ZxN1pt?=
 =?utf-8?B?ci9LK0ViSnd2V3FYUzdIWnRDUVMrSHdzc0Fnb2QxSGRuUy9JRkpOSm51djdi?=
 =?utf-8?B?SzRVdmUzZ2t2Z0Iydk5RMVI3ZDRNWTFlYkN0NHpBWERUTm5zZlIxdXFHdFRW?=
 =?utf-8?B?STZKRFRNdXhId283eDlnbFhkbCs1VkQ5anFWMlo4eXlQeEYzUDRGT3RtcFhv?=
 =?utf-8?B?TUl5cXpmYzcwRWJtRHQ0MDc5V2ZyZ2JGUXh1WDBVYnRoZ2tFQWQrNGxiRVlF?=
 =?utf-8?B?SVllTDJaamYzd1NSWnQxN0srTXhQRnRSK2xUalNsV3ZYSFZyQ3A2MTh5TEY1?=
 =?utf-8?B?U296dEhPalZieE5JdXlqOUNtWG1tRitKK05ZNXhkOUVNeXNIQTJyQmdJdERu?=
 =?utf-8?B?amtXMFdXQzVHK1ZBN1FOVG1aanp5b1ZDMHhqSkxrZjNrWGMvS0Q5S2Fzb05Y?=
 =?utf-8?B?b0RyUWU3RHFTbUE3MnQ4NmJoNVV6QVRYVUxTcHlVRW1hK1NBQTNXOVFRSU1J?=
 =?utf-8?B?VTRSSVFQWXArUmtabllwSjNDOExzN1M0RURMNjZkeGRpMEIwSXpzYUVWOFpl?=
 =?utf-8?B?WGptU3VXZjc2cmF1V29lVUFsbmZVWU10WVdKSjZRVFFiTFpKMS9DQTRURVNy?=
 =?utf-8?B?aG5QM1ZvVDAwWTZyUjg2dm53c25MdGRrTzRJM0pvU0s2UXhVYXd2dGxRTHk3?=
 =?utf-8?B?S0t6Qm9uVkYvSzhQZCtjVTB1SEIwd0Vqa3I3MS9sbW9qVDdyRXg2QStYRmN6?=
 =?utf-8?B?WGRXMzRCOTEwNmovWDNlUDBPd2U1b2RxZXc2V2JOaWo3MU9mN0lCY2dQYkFq?=
 =?utf-8?B?REk1dkRwS2dRcnNhbm5zQ0VlRG5Wd00zQUNxaVRTVXFEbzI0cEt0dm1tMFh6?=
 =?utf-8?B?aE5WQVJLaDJVTU1RV3RUZ2FlOFlFRkRLRXFZS0FKcHdFM3Q5RWR4ZHd0Slgz?=
 =?utf-8?B?djNYOW1QZ1cvN2NDaWZvNmxoeEFPWG04UWJTRE5zVWZNT2JyUDJpSmZDT1Vj?=
 =?utf-8?B?Q0grNUxFRTIrQTNTUUg5b1dlUm9PanRoQTh4N3pmcUN5c0Y0ZGt0dVZoNnhY?=
 =?utf-8?B?dW9od0NJdVg0ZVNWbGtIUFJzSTM3aUlkV0xMTjhvaFE3WmpHTVA4Znc1bDRX?=
 =?utf-8?B?NzFIeGJMeXR3KzlqbGRKUU1lLzFOd1NCNXJua3JWdGNodVR3cGRHb0liNzZX?=
 =?utf-8?B?OHdvZHVqNWh3NHkzUU96ZzVNVWF1RkFVQXFMSDNROGZBVWRjSDVhQjVVanU4?=
 =?utf-8?B?ZkE1bXNWVVhtbUVPWktnZVJRZ1ZrMjRQUDQxcWtqTm40N2JCVFFIbHd3SkNI?=
 =?utf-8?B?VFdNZ2svR0FWbTVHZExrbC9kRDVlcVpIYU9MU0pLYWplSmJ0YlU1Z3lYSGZ6?=
 =?utf-8?B?RkloK0xMa3FKYU9BVFAvSlZJbHJDN2pzY2xseS9qbDQ4RmtUQUdUbUxXenZh?=
 =?utf-8?B?NTlpcWpJS1ZSbldMbXRlMVlmaWdkdU9lSXlZMjhhKzZPeVZ0TVk3SlJubEp3?=
 =?utf-8?B?dXlCOTZlKzAzbWw0bmt0Z0krSVBENmgreHljcUV5aG1ETHg1VmhHa2hNVHlz?=
 =?utf-8?B?NnRkak9yZXBsOEVzU0UvTldtNCtvWXEwQUxTMGxxMFFrYlcrSWlyZ2tRbFVu?=
 =?utf-8?B?eXZ5WEkvR041Mitibzc0VTZuUWpkTVNURXhaWTRyTGZkbE9ZbERyWTVvWW51?=
 =?utf-8?B?N1YxbGhKOGNPbXJYMXNSNyt4M25WN05DWWR0c3ZoRUcwaGNpcnZXY2t5U085?=
 =?utf-8?B?M1UwR3lVbTNQaXZtb3JrbVJXMU51YnJaTUk0M3MwcWQxODhYd09TS0EvTG12?=
 =?utf-8?B?NEhjakxySjhReldQTGRkK1EyeVdmZE1KbVlmRE1wTURlYmpxMjBYWjA5cmxq?=
 =?utf-8?B?ZGdLUVBZVnh2aGYxM2hkV3VXU290SkxQQ2s2QSsrNFRUQkl0RHVRcSsyeGFM?=
 =?utf-8?B?T3hyMnFFWWhpa1NHQzdnbE5rUEpiQXdMb1l6NngvRFNyZEdocURUbEd0YlNj?=
 =?utf-8?Q?vUIWRzNbaAaQw1ZGfHHWAtEkV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34E327D8FF0E954B9F43F51460EC6994@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6462b0-d9a5-4ea6-c75f-08db930ea953
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 04:12:18.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QuIGAZUdfxLShIwjGi9tuQsvB8fOx/Kf53upjyEorWhN1DnaoKEE6mnVIS7oe1B9NDV2YjalIuuTTla4mVDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDIzLTA4LTAxIGF0IDEzOjU4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3ZXIgR2FtbWEgSVAgaGF2ZSBnb3QgbXVs
dGlwbGUgTFVUIGJhbmtzOiBzdXBwb3J0IHNwZWNpZnlpbmcgdGhlDQo+IHNpemUgb2YgdGhlIExV
VCBiYW5rcyBhbmQgaGFuZGxlIGJhbmstc3dpdGNoaW5nIGJlZm9yZSBwcm9ncmFtbWluZw0KPiB0
aGUgTFVUIGluIG10a19nYW1tYV9zZXRfY29tbW9uKCkgaW4gcHJlcGFyYXRpb24gZm9yIGFkZGlu
ZyBzdXBwb3J0DQo+IGZvciBNVDgxOTUgYW5kIG5ld2VyIFNvQ3MuDQo+IA0KPiBTdWdnZXN0ZWQt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gW0FuZ2Vsbzog
UmVmYWN0b3JlZCBvcmlnaW5hbCBjb21taXRdDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEu
YyB8IDczICsrKysrKysrKysrKysrKy0tLS0NCj4gLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ3
IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggYTZmN2FmMWE5ZThlLi5mYjdjMzY1
MGE5ZjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5j
DQo+IEBAIC0yNCw2ICsyNCw4IEBADQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfU0laRQkJCQkweDAw
MzANCj4gICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX0hTSVpFCQkJCUdFTk1BU0sNCj4gKDI4LCAx
NikNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9TSVpFX1ZTSVpFCQkJCUdFTk1BU0sNCj4gKDEyLCAw
KQ0KPiArI2RlZmluZSBESVNQX0dBTU1BX0JBTksJCQkJMHgwMTAwDQo+ICsjZGVmaW5lIERJU1Bf
R0FNTUFfQkFOS19CQU5LCQkJCUdFTk1BU0soMSwgMCkNCj4gICNkZWZpbmUgRElTUF9HQU1NQV9M
VVQJCQkJMHgwNzAwDQo+ICANCj4gICNkZWZpbmUgRElTUF9HQU1NQV9MVVRfMTBCSVRfUgkJCUdF
Tk1BU0soMjksIDIwKQ0KPiBAQCAtMzIsMTAgKzM0LDEyIEBADQo+ICANCj4gICNkZWZpbmUgTFVU
XzEwQklUX01BU0sJCQkJMHgwM2ZmDQo+ICAjZGVmaW5lIExVVF9CSVRTX0RFRkFVTFQJCQkxMA0K
PiArI2RlZmluZSBMVVRfQkFOS19TSVpFX0RFRkFVTFQJCQk1MTINCj4gIA0KPiAgc3RydWN0IG10
a19kaXNwX2dhbW1hX2RhdGEgew0KPiAgCWJvb2wgaGFzX2RpdGhlcjsNCj4gIAlib29sIGx1dF9k
aWZmOw0KPiArCXUxNiBsdXRfYmFua19zaXplOw0KPiAgCXUxNiBsdXRfc2l6ZTsNCj4gIAl1OCBs
dXRfYml0czsNCj4gIH07DQo+IEBAIC04MCw3ICs4NCw5IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9j
b21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkDQo+IF9faW9tZW0gKnJlZ3MsDQo+ICAJdm9p
ZCBfX2lvbWVtICpsdXRfYmFzZTsNCj4gIAlib29sIGx1dF9kaWZmOw0KPiAgCXU4IGx1dF9iaXRz
Ow0KPiAtCXUzMiBjZmdfdmFsLCB3b3JkOw0KPiArCXUxNiBsdXRfYmFua19zaXplOw0KPiArCXUz
MiBjZmdfdmFsLCBsYmFua192YWwsIHdvcmQ7DQo+ICsJaW50IGN1cl9iYW5rLCBudW1fbHV0X2Jh
bmtzOw0KPiAgDQo+ICAJLyogSWYgdGhlcmUncyBubyBnYW1tYSBsdXQgdGhlcmUncyBub3RoaW5n
IHRvIGRvIGhlcmUuICovDQo+ICAJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0KQ0KPiBAQCAtOTEsNDEg
Kzk3LDU0IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LA0K
PiB2b2lkIF9faW9tZW0gKnJlZ3MsDQo+ICANCj4gIAlpZiAoZ2FtbWEgJiYgZ2FtbWEtPmRhdGEp
IHsNCj4gIAkJbHV0X2RpZmYgPSBnYW1tYS0+ZGF0YS0+bHV0X2RpZmY7DQo+ICsJCWx1dF9iYW5r
X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X2Jhbmtfc2l6ZTsNCj4gIAkJbHV0X2JpdHMgPSBnYW1t
YS0+ZGF0YS0+bHV0X2JpdHM7DQo+ICAJfSBlbHNlIHsNCj4gIAkJbHV0X2RpZmYgPSBmYWxzZTsN
Cj4gKwkJbHV0X2Jhbmtfc2l6ZSA9IExVVF9CQU5LX1NJWkVfREVGQVVMVDsNCg0KTFVUX0JBTktf
U0laRV9ERUZBVUxUIGlzIG9ubHkgZm9yIEFBTCBkcml2ZXIsIHNvIHBsYWNlIGl0IGluIEFBTCBk
cml2ZXINCmFuZCBwYXNzIGl0IGludG8gdGhpcyBmdW5jdGlvbi4NCg0KUmVnYXJkcywNCkNLDQoN
Cj4gIAkJbHV0X2JpdHMgPSBMVVRfQklUU19ERUZBVUxUOw0KPiAgCX0NCj4gKwludW1fbHV0X2Jh
bmtzID0gbHV0X3NpemUgLyBsdXRfYmFua19zaXplOw0KPiAgDQo+ICAJY2ZnX3ZhbCA9IHJlYWRs
KHJlZ3MgKyBESVNQX0dBTU1BX0NGRyk7DQo+ICAJbHV0X2Jhc2UgPSByZWdzICsgRElTUF9HQU1N
QV9MVVQ7DQo+ICAJbHV0ID0gKHN0cnVjdCBkcm1fY29sb3JfbHV0ICopc3RhdGUtPmdhbW1hX2x1
dC0+ZGF0YTsNCj4gLQlmb3IgKGkgPSAwOyBpIDwgbHV0X3NpemU7IGkrKykgew0KPiAtCQlzdHJ1
Y3QgZHJtX2NvbG9yX2x1dCBkaWZmLCBod2x1dDsNCj4gLQ0KPiAtCQlod2x1dC5yZWQgPSBkcm1f
Y29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLnJlZCwNCj4gbHV0X2JpdHMpOw0KPiAtCQlod2x1dC5n
cmVlbiA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0uZ3JlZW4sDQo+IGx1dF9iaXRzKTsN
Cj4gLQkJaHdsdXQuYmx1ZSA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0uYmx1ZSwNCj4g
bHV0X2JpdHMpOw0KPiAtDQo+IC0JCWlmICghbHV0X2RpZmYgfHwgKGkgJSAyID09IDApKSB7DQo+
IC0JCQl3b3JkID0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLA0KPiBod2x1dC5y
ZWQpOw0KPiAtCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0csDQo+
IGh3bHV0LmdyZWVuKTsNCj4gLQkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8x
MEJJVF9CLA0KPiBod2x1dC5ibHVlKTsNCj4gLQkJfSBlbHNlIHsNCj4gLQkJCWRpZmYucmVkID0g
bHV0W2ldLnJlZCAtIGx1dFtpIC0gMV0ucmVkOw0KPiAtCQkJZGlmZi5yZWQgPSBkcm1fY29sb3Jf
bHV0X2V4dHJhY3QoZGlmZi5yZWQsDQo+IGx1dF9iaXRzKTsNCj4gLQ0KPiAtCQkJZGlmZi5ncmVl
biA9IGx1dFtpXS5ncmVlbiAtIGx1dFtpIC0gMV0uZ3JlZW47DQo+IC0JCQlkaWZmLmdyZWVuID0g
ZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuZ3JlZW4sDQo+IGx1dF9iaXRzKTsNCj4gLQ0KPiAt
CQkJZGlmZi5ibHVlID0gbHV0W2ldLmJsdWUgLSBsdXRbaSAtIDFdLmJsdWU7DQo+IC0JCQlkaWZm
LmJsdWUgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QoZGlmZi5ibHVlLA0KPiBsdXRfYml0cyk7DQo+
IC0NCj4gLQkJCXdvcmQgPSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGRp
ZmYucmVkKTsNCj4gLQkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9H
LA0KPiBkaWZmLmdyZWVuKTsNCj4gLQkJCXdvcmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xV
VF8xMEJJVF9CLA0KPiBkaWZmLmJsdWUpOw0KPiArCWZvciAoY3VyX2JhbmsgPSAwOyBjdXJfYmFu
ayA8IG51bV9sdXRfYmFua3M7IGN1cl9iYW5rKyspIHsNCj4gKw0KPiArCQkvKiBTd2l0Y2ggZ2Ft
bWEgYmFuayBhbmQgc2V0IGRhdGEgbW9kZSBiZWZvcmUgd3JpdGluZw0KPiBMVVQgKi8NCj4gKwkJ
aWYgKG51bV9sdXRfYmFua3MgPiAxKSB7DQo+ICsJCQlsYmFua192YWwgPSBGSUVMRF9QUkVQKERJ
U1BfR0FNTUFfQkFOS19CQU5LLA0KPiBjdXJfYmFuayk7DQo+ICsJCQl3cml0ZWwobGJhbmtfdmFs
LCByZWdzICsgRElTUF9HQU1NQV9CQU5LKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWZvciAoaSA9IDA7
IGkgPCBsdXRfYmFua19zaXplOyBpKyspIHsNCj4gKwkJCWludCBuID0gKGN1cl9iYW5rICogbHV0
X2Jhbmtfc2l6ZSkgKyBpOw0KPiArCQkJc3RydWN0IGRybV9jb2xvcl9sdXQgZGlmZiwgaHdsdXQ7
DQo+ICsNCj4gKwkJCWh3bHV0LnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbbl0ucmVk
LA0KPiBsdXRfYml0cyk7DQo+ICsJCQlod2x1dC5ncmVlbiA9DQo+IGRybV9jb2xvcl9sdXRfZXh0
cmFjdChsdXRbbl0uZ3JlZW4sIGx1dF9iaXRzKTsNCj4gKwkJCWh3bHV0LmJsdWUgPSBkcm1fY29s
b3JfbHV0X2V4dHJhY3QobHV0W25dLmJsdWUsDQo+IGx1dF9iaXRzKTsNCj4gKw0KPiArCQkJaWYg
KCFsdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4gKwkJCQl3b3JkID0NCj4gRklFTERfUFJF
UChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLCBod2x1dC5yZWQpOw0KPiArCQkJCXdvcmQgfD0NCj4g
RklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLCBod2x1dC5ncmVlbik7DQo+ICsJCQkJ
d29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0IsIGh3bHV0LmJsdWUp
Ow0KPiArCQkJfSBlbHNlIHsNCj4gKwkJCQlkaWZmLnJlZCA9IGx1dFtuXS5yZWQgLSBsdXRbbiAt
IDFdLnJlZDsNCj4gKwkJCQlkaWZmLnJlZCA9DQo+IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZm
LnJlZCwgbHV0X2JpdHMpOw0KPiArDQo+ICsJCQkJZGlmZi5ncmVlbiA9IGx1dFtuXS5ncmVlbiAt
IGx1dFtuIC0NCj4gMV0uZ3JlZW47DQo+ICsJCQkJZGlmZi5ncmVlbiA9DQo+IGRybV9jb2xvcl9s
dXRfZXh0cmFjdChkaWZmLmdyZWVuLCBsdXRfYml0cyk7DQo+ICsNCj4gKwkJCQlkaWZmLmJsdWUg
PSBsdXRbbl0uYmx1ZSAtIGx1dFtuIC0NCj4gMV0uYmx1ZTsNCj4gKwkJCQlkaWZmLmJsdWUgPQ0K
PiBkcm1fY29sb3JfbHV0X2V4dHJhY3QoZGlmZi5ibHVlLCBsdXRfYml0cyk7DQo+ICsNCj4gKwkJ
CQl3b3JkID0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9SLCBkaWZmLnJlZCk7
DQo+ICsJCQkJd29yZCB8PQ0KPiBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0csIGRp
ZmYuZ3JlZW4pOw0KPiArCQkJCXdvcmQgfD0NCj4gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8x
MEJJVF9CLCBkaWZmLmJsdWUpOw0KPiArCQkJfQ0KPiArCQkJd3JpdGVsKHdvcmQsIChsdXRfYmFz
ZSArIGkgKiA0KSk7DQo+ICAJCX0NCj4gLQkJd3JpdGVsKHdvcmQsIChsdXRfYmFzZSArIGkgKiA0
KSk7DQo+ICAJfQ0KPiAgDQo+ICAJLyogRW5hYmxlIHRoZSBnYW1tYSB0YWJsZSAqLw0KPiBAQCAt
MjM2LDExICsyNTUsMTMgQEAgc3RhdGljIGludCBtdGtfZGlzcF9nYW1tYV9yZW1vdmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZGlzcF9nYW1tYV9kYXRhIG10ODE3M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFz
X2RpdGhlciA9IHRydWUsDQo+ICsJLmx1dF9iYW5rX3NpemUgPSA1MTIsDQo+ICAJLmx1dF9iaXRz
ID0gMTAsDQo+ICAJLmx1dF9zaXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIG10ODE4M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsN
Cj4gKwkubHV0X2Jhbmtfc2l6ZSA9IDUxMiwNCj4gIAkubHV0X2JpdHMgPSAxMCwNCj4gIAkubHV0
X2RpZmYgPSB0cnVlLA0KPiAgCS5sdXRfc2l6ZSA9IDUxMiwNCg==
