Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B5F79C2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbjILCbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbjILCbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:31:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40816BD07;
        Mon, 11 Sep 2023 18:55:45 -0700 (PDT)
X-UUID: 782015e8510f11ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fb9KxVpH4OBpEInNoK8mmultVYZuDy73c0cuEEGoPkA=;
        b=IDYCH1bxWVxVUH9pGPjfoF0jxyScJY4+ddHuQj/8sTml/jGVpgB5Q9QgIVhKrZkKuKKEwjc0ZIarC5fwX6juC3dB2oSxcZNLz3IVA+F4Dj5jxahDo80ooZXFkexMT8+SxmKvJJcVFs+jQToVxcBuW9K0PYyxI2H+24R6Q/arcgA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:53fbdb63-3779-43ab-b7a4-975e07587782,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:d2d8d213-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 782015e8510f11ee8051498923ad61e6-20230912
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1194677442; Tue, 12 Sep 2023 09:55:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 09:55:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 09:55:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2385LRkXcFH5n0EgNXITFaxp0XPmgYZyuuvFqaOYcuWrbTFc3VCnMCHaz9sRcrpy31fm5b+2+c/j41Lw0T9odnvkELGIIoAjChGGQxdF7mKmDUwUBT29cVYZl8x4Q3qEvoGoEItpQmdW8dvDHNN0VtDIGaKPN9pcBsMyRbFt3dlGxG3sNPE3Ctk2M5a6/ZuR7i5uvnvblrJ89Mdn51ALTy0vwoaxT2QYWIwOXzZhcggRYJIg+014HRXdUrm+nhQCYMLdCx7hXqYjRJtNQrpkOAiDBs4go8a+D+KYoivIvz0VeO6jn2Y1H9TTrekrc+wwgMpIBuUxfGTYpVgBb9L1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb9KxVpH4OBpEInNoK8mmultVYZuDy73c0cuEEGoPkA=;
 b=jB1dN5HMpQOve5aLmiJC0fO4ePcDwsn0PlDB7S4zI2Jzt04tKAXmzm9kMeaAUL9Xbesod3c/TLUbUuXYB4FDb3fQ7+oAeuFnvqV/Kx3uxMtMtswYRRd79pfYytxevRb0cVCTnKfQ+IMYebwsxTN6U204cU/MoVhLUR0ROxPKLi4L8C6oEY0IpJn4gKqXU5JhwabM4fEymmc6f1gmizNGfJmZPWwNiSRRrtDWOjR+MMPz942sez2+hpyQRbBNWTODnZbA6GrtgOJKppd405utOknw8MkwHsK4ZvGrOnaKcI/YiqOqtbfpCDpaAOk94nRXv1yEX4HYjx7kupSDyfe5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb9KxVpH4OBpEInNoK8mmultVYZuDy73c0cuEEGoPkA=;
 b=GfWHyJmVfOzLlRK0DhUF6KeI3iZhg5wU3MyrlSin8IEp1F1/SebKxG0gQkEOSaSIqXpPxHnETvo56zX1EXGWiilDdaRZor1ol7gSWtIFhrLAWVu9s3RdUlwFG1LiPM4tpfpck/0j7efO4e38t2IwTF/Wp3q9c3K/2DHzu24enOw=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB6308.apcprd03.prod.outlook.com (2603:1096:400:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 01:55:32 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 01:55:32 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 11/14] media: medkatek: vcodec: covert secure fd to secure
 handle
Thread-Topic: [PATCH 11/14] media: medkatek: vcodec: covert secure fd to
 secure handle
Thread-Index: AQHZ5K/7L10+KqGGU0aD6jo+SpmbZLAVxTsAgACp0IA=
Date:   Tue, 12 Sep 2023 01:55:32 +0000
Message-ID: <2c4fe325d8e541749a84ad30774129321e169151.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-12-yunfei.dong@mediatek.com>
         <4867b91b3bbc9267982dd80ad79f3e73a7bab6fc.camel@collabora.com>
In-Reply-To: <4867b91b3bbc9267982dd80ad79f3e73a7bab6fc.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB6308:EE_
x-ms-office365-filtering-correlation-id: 5c2d01a2-44cc-49c3-0580-08dbb3335967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rRUi/DFtja3a4EEBXYQC0tC2rf566HcG3XxYtpttPs1O20bRiT2C7MEkvfPe7iW3psjF+3bRFkFGNltwhoJDHFUSZ0O2eHf1FiV7ZTOBYgtj84CDW5COZ7BfHktOeVWNlrAYx0U1ZrnpWa+5dz/2Gx1Z2rv1oKx5fJma/kgelFddIs5NemDjL9OXbnnprvslHqn1iU25qUM9OMUa5D9ZBlZahwsv2Y0QaVhSurKYdRR8GyzsjmBquB5rsXNAWgRz8Acxp86G2qhnZKgBngOPhw5Z/YWUAmrUlCxFPc/r1e52Fd2nE0ffVSI3YOxyVu2gvHyysCdof7ooK9VKjUs55RpZvtPTPM4zXEqmmXVvYXE6ECyRS/ux29UHJbpumerJ0YayZceoH5jEnYE3laxhlhh2KhF3kjf9vyJuXEtv9vXAqZZhNO7s0WwN3TIFPEscP2OWf/BMxOChzoCvUKQmaK37wmTmCRiWcZDG1E+FcRbxIHQcfaJfW54lfCsGvpCfIbguAbYkpXlFs14XwIA8+3+4KrE9SveU/qDgJkxgI+UJ0lgdvO2XYLZmHBSmjHEMvOvdOYZ9OxeMcgmMbNE4nrXVGHKxIEjcHgOhnSvp6ofbPym8A7/xA73psQuPxr8QwoVsr0yp3v7hECmKOlYxyqPwHFR0wHnKce+itCJB4/Qmzra0f8UMApJOo4n0QOG6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199024)(186009)(1800799009)(86362001)(5660300002)(8936002)(8676002)(4326008)(2906002)(7416002)(85182001)(36756003)(6512007)(71200400001)(6506007)(6486002)(26005)(2616005)(38100700002)(38070700005)(122000001)(478600001)(66574015)(83380400001)(41300700001)(110136005)(76116006)(66946007)(91956017)(66556008)(64756008)(66446008)(316002)(54906003)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ZxREpyNWVRUFUrZ3RHUWpMeFRjVThsTk1kcXFMaXF1emU3MnVOVWhlYzNL?=
 =?utf-8?B?amIrSTF1STd4WS90S2pEa3huajA1Z09kaWc2R3VVYktrVEMxd1IwdE5rN2cy?=
 =?utf-8?B?NU81SVQrTG5ZdzdIQWxOQ1hKQjNMOERNMkxpejk0QWhFZ0d2V3VoclBZanpq?=
 =?utf-8?B?Y3V5emttcVQ5WlpNMHJqREVWcHNzYmdKSVdYTFRHTlRnaFpFZmNYamZuSUlZ?=
 =?utf-8?B?VlpwdGloRmlzNGJDVGFYSWJWM0MxWElZajJ1YUZEZ3FXakV5V2haUkd6ZzlQ?=
 =?utf-8?B?dE5vbXIvOVZKYVQyb1QvWU43Tkl1S2NoU0gvRS81djg2YVpDY1l1TnBBeVVr?=
 =?utf-8?B?YjBzTXlmZUtheEJrTEtWVFJtblpNQk02MFB6V3hBUm41UTZYUzkvR3d0bHU0?=
 =?utf-8?B?NXFNWU9jbE01ZVdmZWFlcXk2TWd0WnpBVndTWEFubFJHNTZ4VTQ3OFNvNm9B?=
 =?utf-8?B?OGY4bTJSOVZaVjB3K0JZblRRSVluWVhEampGOURzR1JiQzlMdExxRFR2WVFY?=
 =?utf-8?B?clB5cjNvT1BEYXl4UWp5c05sdDAvS0hhNUNLMHVjZ2JrcjNoR0pjTjNmMjFt?=
 =?utf-8?B?MkFDSXdYcHUyYisrMk9IOWx5bVJnVU5ITjNOdnFrVU9YZml0VUpwTE1xZUMv?=
 =?utf-8?B?emhQclRqWXpyVmpVbEk4YjlkWUZUT3B6Mkh1YzJZb0d4T0tra1hHM2lqeVh3?=
 =?utf-8?B?cUVPSDhLS3dab1Bsa0FUQTdTYVF5QnNNYkF6cjBNWEZBYTZNYkN1YnozYVhD?=
 =?utf-8?B?YmpQVkdadXZlTXp4NHVEUndVUnN5VStPaXVwU2NPVEFiNVN1WlpLRE1QL2x2?=
 =?utf-8?B?WG1pb2FwYitJdFd2dFVSRnJTa1RBZTJuc1FyRXlqdUV1QmhRYUdWZVpaaGN3?=
 =?utf-8?B?Yml2T1hhWk1JVzhYZHVKcGpXa3UvZHY4YkZPdVNLNCtHRGdZb3VkVFNwUSt1?=
 =?utf-8?B?d2srMVoyTG52YnRadFJvRDhkTGJmd1c0ODZsMHUzWHp2b25abHcxT1Bhckpx?=
 =?utf-8?B?UysrUzY5Zys0SzY5eXJVRktZTDNPdStRTFl4NUUxR1M5TE1xMWsyQmhTRGpn?=
 =?utf-8?B?bVU1cWRTWlZLdmw2NmdvTTdoa3BxYmdGUTR4dk9MdDNuc1BKRXIvdy9QU2hn?=
 =?utf-8?B?RVIyU0l4OVEyUGRLZnQyVzk3OHZ1N0RkUThFZGpveUFkUzIxUnBBZWpBYThP?=
 =?utf-8?B?ZTZBRFkvdUR3SU5UUFVHWXlzaWZEQjFHZUluUERUMkJ3VlhIRTRIejJ3bW41?=
 =?utf-8?B?YUlsUVZzUFBxdWlCT1MzejJ0K3dUaTUyY0k5NGJNSlR2NEd4ZUxQNWFSV0ls?=
 =?utf-8?B?ZXJsMHZwV1A4VUhJWGRJankrQ1pNN2pQSC9kKytFZThwQ2xFRTRKVWxrNk85?=
 =?utf-8?B?TnpRR09KRU83RUtWVEhYcS8rTzJWUEJ0ZG1Sc2hoOWhZUGhaV2hHOUhmVE1j?=
 =?utf-8?B?M0Y5WS9oVWdsTU9HRldXcWk0WWtlS1Z3V3RseDJrdmdSV1BveVFTdjVnMUNy?=
 =?utf-8?B?NkRwazhHZEtVRFN0SEs5dHBndXhLTjJNS0ZMSDNFUk1KRmxyZWF1MWhtZGJJ?=
 =?utf-8?B?Um9pZlBwZzFiMTVtZjZtQUZWSE0wcWMyYzhnK0x5bERKSElnNXdWRWpMbGJw?=
 =?utf-8?B?KzEyVC91TlpNb2xrNnFrNmNSYVkzSHdIN1k4WGc0T1VucWZJRldYZWZWTVQ1?=
 =?utf-8?B?N0pZR3EzVTEyZ2d2NlRBcDZodUE5UGJWeDl5VnZySk40d29tLzYwaE5pZjRl?=
 =?utf-8?B?c0MxUFhESFpIeElQUUtaZ0M1VE1pWUd1Y3J5anZLOEUxSU93SlVMSDFId09O?=
 =?utf-8?B?K3dnRmkyb25GTEpYQ251eHhpWGtzWG5zak9LdXY5dUFHWVJkeVBiQjFGS1FJ?=
 =?utf-8?B?R2JFOUppOVhLZjVyYnBNL0tkSUhhNHp0elBJek5JbnlvZjhzZTdCNGN5bndR?=
 =?utf-8?B?MExsU2pVY1pRaGRYbzdZK2NUK0JaMkt0UmNZcXJDWWRRWUM3UDVoUFk1Sk1T?=
 =?utf-8?B?bUFzd0ZQK21lWEkrU0lkOHB1bkVJNXluNzl5bVhjWVZ3Y0V6aStsVitkWDlN?=
 =?utf-8?B?Z1l4WkFSQytBdnBQZFFsNDMwN0pyVDFmRnd3SklEQ09WbGJZV3REZGVUWG85?=
 =?utf-8?B?ZUliRE95Z1NSUTJoY0NOWFd4d3o5by95UVM2VjI4U01QOS9BL1g5dk5vaDZU?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <288C68751E8DBE4699995AEB11822292@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2d01a2-44cc-49c3-0580-08dbb3335967
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 01:55:32.7320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05+xgPna5AkWbvajfeeRd7m4XMSGhNJSabIXFA9kkRJ/N3QdCQ3msWeBgdbdj/BpGBbKeu8E7GthR741I8NCjNoYDchE4bXR2DZ1v/r99EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6308
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.428400-8.000000
X-TMASE-MatchedRID: PL66URbwWA+nykMun0J1wpmug812qIbz+WzVGPiSY8gNcckEPxfz2D6h
        VXnKDh9Xpvgw2afXSK0cdXOBHMLEJ5e8p4eY614fAjTI/+6gf4MoUVkB7ifJnoaKwv8Fn/09WIA
        WAqR3u1VIw7FB3LvHosTYVMHqv0dvB011LpxMs1gXrP0cYcrA2/n94Go09nBskzE2kM4b6HoL27
        i3iyIp163jY+Rx8ZdtAqcHpHTabpFveCKWtaLcaISvKOGqLLPKK2i9pofGVSuuJov5CSdpsK1W5
        jVjArJqhyL3RHiI3u8K3OrJWcpBViwmW5mXIeVjsp7Uow62+uFkH9TYe91uUbDUHYVkjKWEk8Nu
        KSQycgI1+fGUASm+j7O5KgtqXMcjyyYYa/LAYfos4dkUtuCs/DuvYa1v2IFh8cWgFw6wp7NYua/
        kyrSLKx4IIX8mD9X1P65g2cPKN+w/uACEfpgIcZ7QqGSrNJhlM9g+YfdqJKEkt9BigJAcVic+T5
        1NKwR+4vM1YF6AJbY9l7H+TFQgdY2j49Ftap9Eymsk/wUE4hoD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.428400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 66ECC116B31299D390976F70F5BE09D595EB1EEC75EB96BEC635BC7A2AF7D1F22000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCk9uIE1vbiwgMjAyMy0wOS0x
MSBhdCAxMTo0NyAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gSGksDQo+IA0KPiBM
ZSBsdW5kaSAxMSBzZXB0ZW1icmUgMjAyMyDDoCAyMDo1OSArMDgwMCwgWXVuZmVpIERvbmcgYSDD
qWNyaXQgOg0KPiA+IFVzZXIgZHJpdmVyIHdpbGwgZmlsbCBvciBwYXJzZSBkYXRhIGluIG9wdGVl
LW9zIHdpdGggc2VjdXJlIGhhbmRsZSwNCj4gPiBuZWVkIHRvIGNvdmVydCBzZWN1cmUgZmQgdG8g
c2VjdXJlIGhhbmRsZSBpbiBrZXJuZWwuDQo+IA0KPiBBIG1ham9yIHJld29yayBvZiB0aGUgd29y
ZGluZyBpcyBuZWVkZWQgaW4gdGhpcyBwYXRjaHNldCwgdG8gZml4IHRoZQ0KPiBvYnZpb3VzDQo+
IHR5cG9zIGxpa2UgY292ZXJ0LT5jb252ZXJ0LCANCkkgd2lsbCBmaXggaW4gbmV4dCBwYXRjaC4N
Cj4gYnV0IGFsc28gdG8gc3RvcCBjYWxsaW5nIGRtYWJ1ZiBhbGxvY2F0ZWQgZnJvbQ0KPiBzZWN1
cmUgaGVhcCwgc2VjdXJlIGZkLCANCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byBleHBsYWluIGl0
IGRldGFpbD8NCldoZXRoZXIgeW91IG1lYW5pbmcgSSBjYW4ndA0KY2FsbCBkbWFfYnVmX2dldC9k
bWFfYnVmX2F0dGFjaCBmdW5jdGlvbnMgZGlyZWN0bHk/DQoNCj4gaXRzIG5vdCBwcmVjaXNlIGVu
b3VnaCB0byB1bmRlcnN0YW5kIHdoYXQgdGhpcyBwYXRjaCBpcw0KPiBnb2luZyB0byBiZSBhYm91
dC4NCj4gDQpUaGlzIHBhdGNoIGlzIHVzZWQgdG8gY292ZXJ0IHNlY3VyZSBmZCB0byBzZWN1cmUg
aGFuZGxlLg0KVXNlciBzcGFjZSB3aWxsIGdldCBhIHNlY3VyZSBmZCB1c2luZyBkbWEgaW50ZXJm
YWNlIHRvIGFsbG9jYXRlIHNlY3VyZQ0KbWVtb3J5LCBidXQgbmVlZCB0byBjb3ZlcnQgZmQgdG8g
aGFuZGxlIGluIG9yZGVyIHRvIGZpbGwgZXMNCmJ1ZmZlcihvdXRwdXQgcXVldWUpIGluIG9wdGVl
LW9zLiBJIHdpbGwgd3JpdGUgdGhlIGNvbW1pdCBtZXNzYWdlDQpkZXRhaWwuDQoNCkJlc3QgUmVn
YXJkcywNCll1bmZlaSBEb25nDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcg
PHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3Zjb2RlYy9kZWNv
ZGVyL210a192Y29kZWNfZGVjX2Rydi5jICAgICAgIHwgIDEgKw0KPiA+ICAuLi4vdmNvZGVjL2Rl
Y29kZXIvbXRrX3Zjb2RlY19kZWNfc3RhdGVsZXNzLmMgfCA1NA0KPiA+ICsrKysrKysrKysrKysr
KysrKy0NCj4gPiAgZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMgICAg
IHwgIDUgKysNCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaCAgICAgICAg
ICAgIHwgIDQgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmMN
Cj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRr
X3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmMNCj4gPiBpbmRleCAwYTg5Y2U0NTJhYzMuLjY0ZTAwNjgy
MGY0MyAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmMNCj4gPiArKysNCj4g
PiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zj
b2RlY19kZWNfZHJ2DQo+ID4gLmMNCj4gPiBAQCAtNTcxLDMgKzU3MSw0IEBAIG1vZHVsZV9wbGF0
Zm9ybV9kcml2ZXIobXRrX3Zjb2RlY19kZWNfZHJpdmVyKTsNCj4gPiAgDQo+ID4gIE1PRFVMRV9M
SUNFTlNFKCJHUEwgdjIiKTsNCj4gPiAgTU9EVUxFX0RFU0NSSVBUSU9OKCJNZWRpYXRlayB2aWRl
byBjb2RlYyBWNEwyIGRlY29kZXIgZHJpdmVyIik7DQo+ID4gK01PRFVMRV9JTVBPUlRfTlMoRE1B
X0JVRik7DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRp
YXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+
IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNv
ZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+IGluZGV4IDJlYTUxNzg4M2E4Ni4uZDJiMDlj
ZTlmMWNmIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRp
YXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+
ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rl
ci9tdGtfdmNvZGVjX2RlY19zdGENCj4gPiB0ZWxlc3MuYw0KPiA+IEBAIC00MjYsNiArNDI2LDQ2
IEBAIHN0YXRpYyBpbnQgbXRrX3Zjb2RlY19nZXRfcGljX2luZm8oc3RydWN0DQo+ID4gbXRrX3Zj
b2RlY19kZWNfY3R4ICpjdHgpDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+
ICtzdGF0aWMgaW50IG10a19kbWFfY29udGlnX2dldF9zZWN1cmVfaGFuZGxlKHN0cnVjdA0KPiA+
IG10a192Y29kZWNfZGVjX2N0eCAqY3R4LCBpbnQgZmQpDQo+ID4gK3sNCj4gPiArCWludCBzZWN1
cmVfaGFuZGxlID0gMDsNCj4gPiArCXN0cnVjdCBkbWFfYnVmICpidWY7DQo+ID4gKwlzdHJ1Y3Qg
ZG1hX2J1Zl9hdHRhY2htZW50ICpkYmE7DQo+ID4gKwlzdHJ1Y3Qgc2dfdGFibGUgKnNndDsNCj4g
PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZjdHgtPmRldi0+cGxhdF9kZXYtPmRldjsNCj4gPiAr
DQo+ID4gKwlidWYgPSBkbWFfYnVmX2dldChmZCk7DQo+ID4gKwlpZiAoSVNfRVJSKGJ1ZikpIHsN
Cj4gPiArCQltdGtfdjRsMl92ZGVjX2VycihjdHgsICJkbWFfYnVmX2dldCBmYWlsIGZkOiVkIiwg
ZmQpOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWRiYSA9IGRtYV9i
dWZfYXR0YWNoKGJ1ZiwgZGV2KTsNCj4gPiArCWlmIChJU19FUlIoZGJhKSkgew0KPiA+ICsJCW10
a192NGwyX3ZkZWNfZXJyKGN0eCwgImRtYV9idWZfYXR0YWNoIGZhaWwgZmQ6JWQiLA0KPiA+IGZk
KTsNCj4gPiArCQlnb3RvIGVycl9hdHRhY2g7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJc2d0ID0g
ZG1hX2J1Zl9tYXBfYXR0YWNobWVudChkYmEsIERNQV9CSURJUkVDVElPTkFMKTsNCj4gPiArCWlm
IChJU19FUlIoc2d0KSkgew0KPiA+ICsJCW10a192NGwyX3ZkZWNfZXJyKGN0eCwgImRtYV9idWZf
bWFwX2F0dGFjaG1lbnQgZmFpbA0KPiA+IGZkOiVkIiwgZmQpOw0KPiA+ICsJCWdvdG8gZXJyX21h
cDsNCj4gPiArCX0NCj4gPiArCXNlY3VyZV9oYW5kbGUgPSBzZ19kbWFfYWRkcmVzcyhzZ3QtPnNn
bCk7DQo+ID4gKw0KPiA+ICsJZG1hX2J1Zl91bm1hcF9hdHRhY2htZW50KGRiYSwgc2d0LCBETUFf
QklESVJFQ1RJT05BTCk7DQo+ID4gKwlkbWFfYnVmX2RldGFjaChidWYsIGRiYSk7DQo+ID4gKwlk
bWFfYnVmX3B1dChidWYpOw0KPiA+ICsNCj4gPiArCXJldHVybiBzZWN1cmVfaGFuZGxlOw0KPiA+
ICtlcnJfbWFwOg0KPiA+ICsJZG1hX2J1Zl9kZXRhY2goYnVmLCBkYmEpOw0KPiA+ICtlcnJfYXR0
YWNoOg0KPiA+ICsJZG1hX2J1Zl9wdXQoYnVmKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdGtfdmRlY19zX2N0cmwoc3RydWN0IHY0bDJf
Y3RybCAqY3RybCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a192Y29kZWNfZGVjX2N0eCAqY3R4
ID0gY3RybF90b19kZWNfY3R4KGN0cmwpOw0KPiA+IEBAIC00MzYsNyArNDc2LDcgQEAgc3RhdGlj
IGludCBtdGtfdmRlY19zX2N0cmwoc3RydWN0IHY0bDJfY3RybA0KPiA+ICpjdHJsKQ0KPiA+ICAJ
c3RydWN0IHY0bDJfY3RybCAqaGRyX2N0cmw7DQo+ID4gIAljb25zdCBzdHJ1Y3QgbXRrX3Zjb2Rl
Y19kZWNfcGRhdGEgKmRlY19wZGF0YSA9IGN0eC0+ZGV2LQ0KPiA+ID52ZGVjX3BkYXRhOw0KPiA+
ICAJY29uc3Qgc3RydWN0IG10a192aWRlb19mbXQgKmZtdDsNCj4gPiAtCWludCBpID0gMCwgcmV0
ID0gMDsNCj4gPiArCWludCBpID0gMCwgcmV0ID0gMCwgc2VjX2ZkOw0KPiA+ICANCj4gPiAgCWhk
cl9jdHJsID0gY3RybDsNCj4gPiAgCWlmICghaGRyX2N0cmwgfHwgIWhkcl9jdHJsLT5wX25ldy5w
KQ0KPiA+IEBAIC00ODksNiArNTI5LDEyIEBAIHN0YXRpYyBpbnQgbXRrX3ZkZWNfc19jdHJsKHN0
cnVjdCB2NGwyX2N0cmwNCj4gPiAqY3RybCkNCj4gPiAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
IAkJfQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICsJY2FzZSBWNEwyX0NJRF9NUEVHX01US19HRVRfU0VD
VVJFX0hBTkRMRToNCj4gPiArCQlzZWNfZmQgPSBjdHJsLT52YWw7DQo+ID4gKw0KPiA+ICsJCWN0
cmwtPnZhbCA9IG10a19kbWFfY29udGlnX2dldF9zZWN1cmVfaGFuZGxlKGN0eCwgY3RybC0NCj4g
PiA+dmFsKTsNCj4gPiArCQltdGtfdjRsMl92ZGVjX2RiZygzLCBjdHgsICJnZXQgc2VjdXJlIGhh
bmRsZTogJWQgPT4NCj4gPiAweCV4Iiwgc2VjX2ZkLCBjdHJsLT52YWwpOw0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICAJZGVmYXVsdDoNCj4gPiAgCQltdGtfdjRsMl92ZGVjX2RiZygzLCBjdHgsICJOb3Qg
c3VwcG9ydGVkIHRvIHNldCBjdHJsDQo+ID4gaWQ6IDB4JXhcbiIsIGhkcl9jdHJsLT5pZCk7DQo+
ID4gIAkJcmV0dXJuIHJldDsNCj4gPiBAQCAtNTI1LDggKzU3MSw5IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdjRsMl9jdHJsX29wcw0KPiA+IG10a192Y29kZWNfZGVjX2N0cmxfb3BzID0gew0KPiA+
ICBzdGF0aWMgaW50IG10a192Y29kZWNfZGVjX2N0cmxzX3NldHVwKHN0cnVjdCBtdGtfdmNvZGVj
X2RlY19jdHgNCj4gPiAqY3R4KQ0KPiA+ICB7DQo+ID4gIAl1bnNpZ25lZCBpbnQgaTsNCj4gPiAr
CXN0cnVjdCB2NGwyX2N0cmwgKmN0cmw7DQo+ID4gIA0KPiA+IC0JdjRsMl9jdHJsX2hhbmRsZXJf
aW5pdCgmY3R4LT5jdHJsX2hkbCwgTlVNX0NUUkxTKTsNCj4gPiArCXY0bDJfY3RybF9oYW5kbGVy
X2luaXQoJmN0eC0+Y3RybF9oZGwsIE5VTV9DVFJMUyArIDEpOw0KPiA+ICAJaWYgKGN0eC0+Y3Ry
bF9oZGwuZXJyb3IpIHsNCj4gPiAgCQltdGtfdjRsMl92ZGVjX2VycihjdHgsICJ2NGwyX2N0cmxf
aGFuZGxlcl9pbml0DQo+ID4gZmFpbGVkXG4iKTsNCj4gPiAgCQlyZXR1cm4gY3R4LT5jdHJsX2hk
bC5lcnJvcjsNCj4gPiBAQCAtNTQzLDYgKzU5MCw5IEBAIHN0YXRpYyBpbnQgbXRrX3Zjb2RlY19k
ZWNfY3RybHNfc2V0dXAoc3RydWN0DQo+ID4gbXRrX3Zjb2RlY19kZWNfY3R4ICpjdHgpDQo+ID4g
IAkJfQ0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWN0cmwgPSB2NGwyX2N0cmxfbmV3X3N0ZCgmY3R4
LT5jdHJsX2hkbCwNCj4gPiAmbXRrX3Zjb2RlY19kZWNfY3RybF9vcHMsDQo+ID4gKwkJCQkgVjRM
Ml9DSURfTVBFR19NVEtfR0VUX1NFQ1VSRV9IQU5ETEUsDQo+ID4gMCwgNjU1MzUsIDEsIDApOw0K
PiA+ICsNCj4gPiAgCXY0bDJfY3RybF9oYW5kbGVyX3NldHVwKCZjdHgtPmN0cmxfaGRsKTsNCj4g
PiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS92NGwy
LWNvcmUvdjRsMi1jdHJscy1kZWZzLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0
bDItY3RybHMtZGVmcy5jDQo+ID4gaW5kZXggODY5NmViMWNkZDYxLi5kOGNmMDFmNzZhYWIgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jdHJscy1kZWZzLmMN
Cj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLWRlZnMuYw0KPiA+
IEBAIC0xMDQxLDYgKzEwNDEsNyBAQCBjb25zdCBjaGFyICp2NGwyX2N0cmxfZ2V0X25hbWUodTMy
IGlkKQ0KPiA+ICAJY2FzZSBWNEwyX0NJRF9NUEVHX1ZJREVPX0hFVkNfU0laRV9PRl9MRU5HVEhf
RklFTEQ6CXJldHVybg0KPiA+ICJIRVZDIFNpemUgb2YgTGVuZ3RoIEZpZWxkIjsNCj4gPiAgCWNh
c2UgVjRMMl9DSURfTVBFR19WSURFT19SRUZfTlVNQkVSX0ZPUl9QRlJBTUVTOglyZXR1cm4NCj4g
PiAiUmVmZXJlbmNlIEZyYW1lcyBmb3IgYSBQLUZyYW1lIjsNCj4gPiAgCWNhc2UgVjRMMl9DSURf
TVBFR19WSURFT19QUkVQRU5EX1NQU1BQU19UT19JRFI6CQlyZXQNCj4gPiB1cm4gIlByZXBlbmQg
U1BTIGFuZCBQUFMgdG8gSURSIjsNCj4gPiArCWNhc2UgVjRMMl9DSURfTVBFR19NVEtfR0VUX1NF
Q1VSRV9IQU5ETEU6CQlyZXR1cm4NCj4gPiAiTWVkaWFUZWsgRGVjb2RlciBnZXQgc2VjdXJlIGhh
bmRsZSI7DQo+ID4gIA0KPiA+ICAJLyogQVYxIGNvbnRyb2xzICovDQo+ID4gIAljYXNlIFY0TDJf
Q0lEX01QRUdfVklERU9fQVYxX1BST0ZJTEU6CQkJcmV0DQo+ID4gdXJuICJBVjEgUHJvZmlsZSI7
DQo+ID4gQEAgLTE0MzcsNiArMTQzOCwxMCBAQCB2b2lkIHY0bDJfY3RybF9maWxsKHUzMiBpZCwg
Y29uc3QgY2hhcg0KPiA+ICoqbmFtZSwgZW51bSB2NGwyX2N0cmxfdHlwZSAqdHlwZSwNCj4gPiAg
CWNhc2UgVjRMMl9DSURfTVBFR19WSURFT19WUFhfTlVNX1JFRl9GUkFNRVM6DQo+ID4gIAkJKnR5
cGUgPSBWNEwyX0NUUkxfVFlQRV9JTlRFR0VSX01FTlU7DQo+ID4gIAkJYnJlYWs7DQo+ID4gKwlj
YXNlIFY0TDJfQ0lEX01QRUdfTVRLX0dFVF9TRUNVUkVfSEFORExFOg0KPiA+ICsJCSp0eXBlID0g
VjRMMl9DVFJMX1RZUEVfSU5URUdFUjsNCj4gPiArCQkqZmxhZ3MgfD0gVjRMMl9DVFJMX0ZMQUdf
V1JJVEVfT05MWTsNCj4gPiArCQlicmVhazsNCj4gPiAgCWNhc2UgVjRMMl9DSURfVVNFUl9DTEFT
UzoNCj4gPiAgCWNhc2UgVjRMMl9DSURfQ0FNRVJBX0NMQVNTOg0KPiA+ICAJY2FzZSBWNEwyX0NJ
RF9DT0RFQ19DTEFTUzoNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDIt
Y29udHJvbHMuaA0KPiA+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiA+
IGluZGV4IGMzNjA0YTBhM2UzMC4uN2IzNjk0OTg1MzY2IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC92NGwyLWNvbnRyb2xzLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvdjRsMi1jb250cm9scy5oDQo+ID4gQEAgLTk1NCw2ICs5NTQsMTAgQEAgZW51bSB2NGwyX21w
ZWdfbWZjNTFfdmlkZW9fZm9yY2VfZnJhbWVfdHlwZSB7DQo+ID4gICNkZWZpbmUgVjRMMl9DSURf
TVBFR19NRkM1MV9WSURFT19IMjY0X0FEQVBUSVZFX1JDX1NUQVRJQwkJDQo+ID4gKFY0TDJfQ0lE
X0NPREVDX01GQzUxX0JBU0UrNTMpDQo+ID4gICNkZWZpbmUgVjRMMl9DSURfTVBFR19NRkM1MV9W
SURFT19IMjY0X05VTV9SRUZfUElDX0ZPUl9QCQkNCj4gPiAoVjRMMl9DSURfQ09ERUNfTUZDNTFf
QkFTRSs1NCkNCj4gPiAgDQo+ID4gKy8qICBNUEVHLWNsYXNzIGNvbnRyb2wgSURzIHNwZWNpZmlj
IHRvIHRoZSBNZWRpYVRlayBEZWNvZGVyIGRyaXZlcg0KPiA+IGFzIGRlZmluZWQgYnkgVjRMMiAq
Lw0KPiA+ICsjZGVmaW5lIFY0TDJfQ0lEX01QRUdfTVRLX0JBU0UJCQkoVjRMMl9DVFJMX0NMQVMN
Cj4gPiBTX0NPREVDIHwgMHgyMDAwKQ0KPiA+ICsjZGVmaW5lIFY0TDJfQ0lEX01QRUdfTVRLX0dF
VF9TRUNVUkVfSEFORExFCShWNEwyX0NJRF9NUEVHXw0KPiA+IE1US19CQVNFKzgpDQo+ID4gKw0K
PiA+ICAvKiAgQ2FtZXJhIGNsYXNzIGNvbnRyb2wgSURzICovDQo+ID4gIA0KPiA+ICAjZGVmaW5l
IFY0TDJfQ0lEX0NBTUVSQV9DTEFTU19CQVNFCShWNEwyX0NUUkxfQ0xBU1NfQ0FNRVJBIHwNCj4g
PiAweDkwMCkNCj4gDQo+IA0K
