Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45747DC88C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJaIm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjJaImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:42:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C1C1;
        Tue, 31 Oct 2023 01:42:49 -0700 (PDT)
X-UUID: 73a453e077c911ee8051498923ad61e6-20231031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xq91qZ4AuOBK5Uebo95oEh6GuQOhAET7Pd7SNUSFf6M=;
        b=JHxJ9BBCxWwC2Dl6m50sXKJ0iafZJCbWEQkEZXyuI/7P0Zxdog24duEUODwJEjfsYue3jsMdRdqWDF5pX97xr4zD9fX3NWkN4mNkSn3Nx7D7CFnyyTpr6da8O0WkVmb6r/4fdblGd40vCRMk6wN+MouBOU4LEHouHYfWb5F5DiM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:04aeb27b-7e09-4adf-a543-7bd649bbb368,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:2ef785d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 73a453e077c911ee8051498923ad61e6-20231031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 830982331; Tue, 31 Oct 2023 16:42:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 31 Oct 2023 16:42:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 31 Oct 2023 16:42:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRBCx/veGIj1iU35bLr57k+ZwPCEU0WeEZe/j/E490K5QrbyXxxiaVb9r+YNaIDpMgM7jY2Lo40WrIRJ0NbL/Dzy31IdJEweFCusV8OPi6v7dgdtJIXPyqfW+5Q0fDy8WtbMbHO1XocyMoUQZzG8wszkd5ldjuoeLkuhZ0QTTFv/4jNbE70jWzND+CkJBKCCG11wYzw3RSgip200ty9XoNIHmurJ42r3/NQjc9q8hbqtahq9vXEZbhVYNlnZRxIrYTdOwum9CL7iEn/LScGiMmZjJwYwE5BJmla+wHq9Hbxt8lr5wO3tOXt1T3GBSuqqt07GXp2xeeyvZiTGks0EsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq91qZ4AuOBK5Uebo95oEh6GuQOhAET7Pd7SNUSFf6M=;
 b=F/WLuJx/RDYyRZFjCo5XGx/ye4GT4tcA9NVMdG7tSY6iZugeUJeXrs0Hn7KxRS9MzwkabF0YnEjCknWnSQy0nn1iwBIwByfqfMs91X/P7Ad5KlQdcea3o0LmPZx/w1sANB1E5uX9IKmSJQCy27JPO8OcaZepFBcyghemavsO41KKUwoiM3smREr2qKviP0Kktd1TSEdvg3oZNirOhRYBXm+uk8EhJkECReNK725CZmSPj/2hUKLZpygeV3AAaDKxFGIu1gqnscG6v9AleUumIOCgfdF2UKX6HScDFgs6ZwVI6UYShYghfGDTfeyNTwsG/uv68KoqXwN5kH27GCQk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq91qZ4AuOBK5Uebo95oEh6GuQOhAET7Pd7SNUSFf6M=;
 b=TnIcynIHZlrkT8ebxMaOyU87tVOo99z6XZy7hSEgdWZj9AmnvHqdTSyXIlB7TIQeY+HbFmrNfgKdA+wwLmHyIG99mSldRxmtvVxP0sRhIf7VyqoRbG/uaWrpbgu7gbrERWbXPmtglcv1iqesxtveQO0FxPe8GG3utWyp0hzu1+s=
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com (2603:1096:400:14c::9)
 by SEZPR03MB6810.apcprd03.prod.outlook.com (2603:1096:101:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Tue, 31 Oct
 2023 08:41:45 +0000
Received: from TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::9e24:980f:fc1d:d4ba]) by TY0PR03MB6356.apcprd03.prod.outlook.com
 ([fe80::9e24:980f:fc1d:d4ba%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 08:41:45 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v8 00/12] add support MDP3 on MT8195 platform
Thread-Topic: [PATCH v8 00/12] add support MDP3 on MT8195 platform
Thread-Index: AQHaCxjAkYamjN+2d06it1xVTAw/9bBjlfUA
Date:   Tue, 31 Oct 2023 08:41:44 +0000
Message-ID: <8914ce10649260695fcd1e6295020c6c30c018d4.camel@mediatek.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6356:EE_|SEZPR03MB6810:EE_
x-ms-office365-filtering-correlation-id: fe00fe91-9d1a-4baa-611b-08dbd9ed36a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9NQ/j6ynHTbT2866dpq7cS/JR1nHU0EusAAEeayoGi4RMt2jW6L9x1+7Yt4gXUeUaltjsM40VSd8r0Sek2Na9Xi2B/egJE3Vai8m/yGUNf/zsv7CgWkvYnHqy711csfN+6XIXYyN7jd3+IUgsKabp0TrfQjCMMYFzE2uhPlLdEWxKHDeCTDDsSzgZA0jZBO2Gj8jJIfHYk8T6LvJwQh7GLrWYixYCgTYGFs02lUGMOpj+0BD6UZfKS33K02LYHxmZyAxliB1GfqQOblDSJH+DrGhJpHjHXlAszehCicoXPqTsaZ78O4SVHbsLx9PR9rC+ztelP0/Dbq7UuNQLRmkrUGzwqge9y7kvbUyoJz5mb5Vshfj6orJOMVqtKgKk13TeqPERdwqHKsG9RfuSOEiQ3AvjhRlU4HvqoNpozKVyuNGMGboH2+hqQKrFuhsaTwxn5+qHGsSVvWxHARRGal8GWJyV55v409HQcDV4/qQnGD0lQV776m4BMoFDl0dpfcsIEfwYMdjdM+QMPMNh4kwr0amtOKWD2FtZSIS1yPHpjHSag/D1/pomX8RYk2GpDeCpCBPsBo/MMi6hAvluLutuIUbP9xkPZ+ZF2IDaT757ziLeV/OnOJYpxU/JnIzadd5WVMGi64jziM40aXueFDQ/11ygjoPBeJ/yjqyHiOHZIFeoVYIbMT8FaIGfqDbKyWponO86cs4aFXi0BM7ZGezy/AGWWJtqVPpVncUU94Fxb+v+rJ1djvEi0u5qB1nEbI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6356.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(6512007)(41300700001)(38070700009)(122000001)(38100700002)(2616005)(71200400001)(85182001)(36756003)(4001150100001)(66946007)(6506007)(2906002)(6486002)(86362001)(83380400001)(966005)(478600001)(110136005)(4326008)(8676002)(8936002)(54906003)(66556008)(66446008)(5660300002)(316002)(64756008)(76116006)(66476007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFJWTU0vWjV6QkVKUmUxQ3BvNWZEcWFoNzY2dmhlcEpXL3k1U1NKcE9vbXFT?=
 =?utf-8?B?WXJyQmd4SVUrZWQ0OHZNVlc3NVk1REJJaDBVT0FacHA1dTQ5WkNNeFZBb2lu?=
 =?utf-8?B?SGhJSFpSYWlNK2lKNVAzSDBnSWxjbHFBSXRKRXBCNTZqcjlpeklaMzg5dUFK?=
 =?utf-8?B?Z01jb01YTHEybllrM3pVc1VrNWptd0Joa29kcXpFREFqbkloL1c0c1BwRmhG?=
 =?utf-8?B?enFFV0hFTXRiZE1NWHdNUjVjenJZMTJIdGRTK0JQR1FCUHFkcmdRYXNqR0lY?=
 =?utf-8?B?Q1BBKzZmM1g0N01DYksrVDRhZ2h0SXpCWkNjYzBsbDl5VnZrdVEzMHBINm5m?=
 =?utf-8?B?c0M5MVBjelNKR2QrSkpnNUpvSE5XOXFTL3d3ZDRwdE1vNWxCYWl5aEcwb1Ba?=
 =?utf-8?B?YXZQYVJPa3lla09GWWszeU0xbW1nSmhjT0I3N0hTNXY1bU8xcTNUVzJKU2R0?=
 =?utf-8?B?SnRRSjduaSttc0o3V1FzWlM2SzduQjQveGlmaGt5YmQ4SFhwRS84dXlVTTdh?=
 =?utf-8?B?UTgxRmorV2k5NzJvb2dGZTc5dFg1bUtGdnZJWEhhbW9mZ0Vha3g5MG5aRTVC?=
 =?utf-8?B?K3lsRU5aMWd2QU10YkFNUHYrUlJKYnRyNlJpc3lwMWxhaVJrenhDQXc3Ry9X?=
 =?utf-8?B?VHE4dTZ0TjUwK2s0V214MlZTL0hnc0krclhMOW8vbmNDUUJmY01STGxLVi9P?=
 =?utf-8?B?Rm9IWFJSUmRMUjR0MHJsTFJGSzdsUzFaYWZsOHJ4R3M2cWFWakVnZ2F3dklO?=
 =?utf-8?B?SWI2Z2crckxJWTlYUDhlWXJQdHRxdm41OW5FT1NZaVh0SnF0UEo2UGg3WTEv?=
 =?utf-8?B?OXh5YWx6UDFXeHVFNURzUVZTRlBVVlFEeE1qWklRd2NrYTVYVS93LzVaZi80?=
 =?utf-8?B?b09WSmtTUzdsSm5mQ3NHQnMxeVRoR0l6VmhxZzQ4UW5xOHhyMzFBT2lkVFI4?=
 =?utf-8?B?Qmlia0llVGdiSkQ3RUZjNFMxZlFESm5xalBSeVpwSDBrMStyRGQ1Tk80eEJL?=
 =?utf-8?B?cTV2eDZwY3ArOUZIU0ZRd2tDbmhDYXdKZ2o5MGlXYUVDVkwvblFYbGJzeWFK?=
 =?utf-8?B?cGVBZ3Yrd3c3K25oTWlqaFBhU0ovOW1LRVFYUXUybGI4YmV4TkhiOEVuSXpX?=
 =?utf-8?B?WGJzMk0yZE1HVWVkTDQ2QmVyd0p5K2oxM25HOHg3amxtS1UzWTRIQWc4Yk53?=
 =?utf-8?B?UXA4bUw4TXdrcnNZUnNJMHpDc21UTVdoMXp0ZjhYTEF6UlFMVGV2c2dvdXdZ?=
 =?utf-8?B?WHhtckJBWks4OXFCaUZmZEs0VVZuOFhZTUEvT3l2M0xaMTRUVFk0SjhrQm5r?=
 =?utf-8?B?ZGtKQTlKNjR2WWZqOWRxVU1nQ3ppdkpoL3RxRFZFQU01UEJTcjF1aGF5VzF1?=
 =?utf-8?B?OXZsWmlYNHIrUFpvcEEweXcxQ2NxZ3pZaWxPZDMyL2lTKzdHTGI2cWhlUWlE?=
 =?utf-8?B?MGpSblpxSW9zN3h2d2NsbHBDUlNEVGdaS29vUFBHeXIyOUNxS2RNNWhORWNT?=
 =?utf-8?B?UVZWQ0xWOE5ITTBoMnA5eUtLc29zUEx6elZWcE1EemorUUJIaTBWTEVSYUVL?=
 =?utf-8?B?RnNrRllLVnNSYkVWa0N1SDkvQVVsVGtIM21pNlZ0YzJwaTBaOUlOVXA3cGdw?=
 =?utf-8?B?VGdWS0FvZkZ1dkE1ZWRWQy8zVFM4NDF3THRreDh6dHVMTGhVVXhLd3RhSmY1?=
 =?utf-8?B?YmFRL0lSNVU5QS9mZDVrVVpNbDlySmFVU0doTzZHU1N4WnFpaGlkSDV2YmxX?=
 =?utf-8?B?dk9JcGJubnFvTGZSdjRhV1dCa0pIeU0yMFNmSlpRdVJnczVZM1lTaXg5STFw?=
 =?utf-8?B?Ni90TzRtSk9rUmtkd3E0ZXRQY1N6dGFubmQrV09EMXI3cklVYzFacHltRWk0?=
 =?utf-8?B?cCtOc0J1SGlHY0tZd21laVo3d25Qc0RRcEJ4RERqa0xCZXVrd2JwQWFHc2Rh?=
 =?utf-8?B?TWwwQmpEVG9wM3d5dEpOQW1OZVBqMXJHV0FnT1NlV1Q1TE5vM2psRm8yaVk1?=
 =?utf-8?B?L0RlU1FnYTdZTDgyYUdJZm8zb25xQk5RZ3pDeW9FUXFFRHZLMzlBY1ozeGQ0?=
 =?utf-8?B?dENMZThRSmNnbnpoMWxvYXhIcnpqQ2VQNXpteVBCV3oyY0YrVjFxRDRuYVVq?=
 =?utf-8?B?RjNpdm44U003VVpmcW85VFNWU1lXbGVIa3RBZTJORDlPQkc1RzVMOGc5aXhB?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F202BC9F72CD224190B686A4161F0C8E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6356.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe00fe91-9d1a-4baa-611b-08dbd9ed36a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 08:41:45.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YP4J1PmYs+LVFMuk0ExKoTDwBajQr+4FfLIC7+2nGgATsb1lIJ+EWhXJOSxpjeFTkNhw73kgr1VoqEC6WymZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6810
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.145800-8.000000
X-TMASE-MatchedRID: MDgwTWowY3bUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYBFx
        R5JQAS6O3r7mn2ykawjbfYuOZjCEqrGaAH5r9EhkU+OjsPhIWDj2kudi1D33Eqj5v7I4/SgYT8L
        sLXQkTu+XFexZ59orJDg1P1WakhUbftCKaE1FuIWxo9yzdPhMvfTcf8Av+QSAIDp4740OYDFwE2
        cWHm+ugDS82RAJWQKffNhH6L7s8UbY2FVQoH3tl+QoIU4rAATMJ7TAdoWYpOcdXtyyzrIOt3WCd
        6QvVzbeijfBSrzijpL/uXY8rf5fRk2VnXMRzIBjqeBupNgLgYcCnYfpEgyUOPoPTC51Lsjx8+LS
        DYFV7vaRqKv9ycRHmZtLyQif1NEvuAUmRVMDTAwmEURBmKrZlA++9cyE1sOg31GU/N5W5BB96t9
        wDfdERUoetY1TJgpWcBOyDww4NUhC/bXMk2XQLIMbH85DUZXyIhbI4bdUUePUZxEAlFPo846HM5
        rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.145800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1B9F94F9274301B64A3744FCAFD8FA489DBBECCD3EAB00639F74FDF5CA179FFE2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTMwIGF0IDE4OjA2ICswODAwLCBNb3VkeSBIbyB3cm90ZToNCj4gQ2hh
bmdlcyBzaW5jZSB2NzoNCj4gLSBSZWJhc2Ugb24gbGludXgtbmV4dC4NCj4gLSBEZXBlbmRlbnQg
ZHRzaSBmaWxlczoNCj4gICANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz03OTc1NDMNCj4gLSBEZXBlbmRlbnQgYmluZGlu
Z3M6DQo+ICAgDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1t
ZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzk3NTU1DQoNClRoZSBkZXBlbmRlbmN5IGJpbmRpbmdzIGhh
dmUgYmVlbiB1cGRhdGVkIHRvIHY5IGFzIHNob3duIGluIHRoZSBsaW5rDQpiZWxvdy4NCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJp
ZXM9Nzk3ODI0DQoNClRoYW5rcywNCk1vdWR5DQoNCj4gLSBQYXRjaCBbOS8xMl0gaGFzIG1hZGUg
Y29ycmVzcG9uZGluZyBhZGp1c3RtZW50cyBpbiByZXNwb25zZSB0byB0aGUNCj4gY2hhbmdlcyBp
bg0KPiAgIHRoZSBjb21wYXRpYmxlIG5hbWUgb2YgdGhlIFBBRCBjb21wb25lbnQgaW4gRFRTSSBh
bmQgYmluZGluZy4NCj4gLSBBZGRpbmcgV1JPVCBjb21wYXRpYmxlIG5hbWUgaW4gdGhlIE1EUCBk
cml2ZXIncyBvZl9tYXRjaF90YWJsZSBpbg0KPiBbOS8xMl0gdG8NCj4gICBhdm9pZCBkZWFjdGl2
YXRpbmcgJ3BtX3J1bnRpbWVfKicgZnVuY3Rpb25zLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2NjoN
Cj4gLSBSZWJhc2Ugb24gdjYuNi1yYzUuDQo+IC0gRGVwZW5kZW50IGR0c2kgZmlsZXM6DQo+ICAg
DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9s
aXN0Lz9zZXJpZXM9NzkyMDc5DQo+IC0gRGVwZW5kZW50IGJpbmRpbmdzOg0KPiAgIA0KPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2Vy
aWVzPTc5MjQ3Nw0KPiAtIE1vdmUgdGhlIHBhdGNoIHRoYXQgZml4ZXMgY29tcGlsZSB3YXJuaW5n
cyBmcm9tIHRoaXMgc2VyaWVzIGFuZA0KPiAgIGNyZWF0ZSBhIHNlcGFyYXRlIHN0YW5kYWxvbmUg
cGF0Y2guDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY1Og0KPiAtIFJlYmFzZSBvbiB2Ni42LXJjMi4N
Cj4gLSBEZXBlbmRlbnQgZHRzaSBmaWxlczoNCj4gICANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz03ODY1MTENCj4gLSBE
ZXBlbmRlbnQgYmluZGluZ3M6DQo+ICAgDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzg2NTIwDQo+IC0gSW50ZWdyYXRl
IE1NU1kvTVVURVggc3RydWN0dXJlIGluICJtZHBfcHJvYmUiLg0KPiAtIEZpeCB0aGUgYnVpbGQg
d2FybmluZ3MgdGhhdCB3ZXJlIGRldGVjdGVkIGJ5IHRoZSBsaW51eC1tZWRpYQ0KPiAgIGJ1aWxk
IHNjcmlwdHMgdG9vbC4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjQ6DQo+IC0gUmViYXNlIG9uIHY2
LjYtcmMxDQo+IC0gUmVtb3ZlIGFueSB1bm5lY2Vzc2FyeSBEVFMgc2V0dGluZ3MuDQo+IC0gQWRq
dXN0IHRoZSB1c2FnZSBvZiBNT0QgYW5kIGNsb2NrIGluIGJsZW5kaW5nIGNvbXBvbmVudHMuDQo+
IA0KPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiAtIERlcGVuZCBvbiA6DQo+ICAgWzFdIA0KPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWEvbGlzdC8/c2VyaWVz
PTcxOTg0MQ0KPiAtIFN1Z2dlc3RlZCBieSBLcnp5c3p0b2YsIGludGVncmF0aW5nIGFsbCBuZXds
eSBhZGRlZCBiaW5kaW5ncyBmb3INCj4gICB0aGUgbXQ4MTk1IE1EUDMgaW50byB0aGUgZmlsZSAi
bWVkaWF0ZWssbXQ4MTk1LW1kcDMueWFtbCIuDQo+IC0gUmV2aXNlIE1EUDMgbm9kZXMgd2l0aCBn
ZW5lcmljIG5hbWVzLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gLSBEZXBlbmQgb24gOg0K
PiAgIFsxXSBNTVNZUy9NVVRFWDogDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NzExNTkyDQo+ICAgWzJdIE1EUDM6IA0K
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlz
dC8/c2VyaWVzPTcxMTYxOA0KPiAtIFN1Z2dlc3RlZCBieSBSb2IgdG8gcmV2aXNlIE1EUDMgYmlu
ZGluZ3MgdG8gcGFzcyBkdGJzIGNoZWNrDQo+IC0gQWRkIHBhcmFsbGVsIHBhdGhzIGZlYXR1cmUu
DQo+IC0gQWRkIGJsZW5kZWQgY29tcG9uZW50cyBzZXR0aW5ncy4NCj4gDQo+IENoYW5nZXMgc2lu
Y2UgdjE6DQo+IC0gRGVwZW5kIG9uIDoNCj4gICBbMV0gTURQMyA6IA0KPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTY5ODg3
Mg0KPiAgIFsyXSBNTVNZUy9NVVRFWDogDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Njg0OTU5DQo+IC0gRml4IGNvbXBp
bGF0aW9uIGZhaWx1cmUgZHVlIHRvIHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaW4gZmls
ZQ0KPiAibXRrLW1kcDMtY21kcS5jIg0KPiANCj4gSGVsbG8sDQo+IA0KPiBUaGlzIHBhdGNoIGlz
IHVzZWQgdG8gYWRkIHN1cHBvcnQgZm9yIE1EUDMgb24gdGhlIE1UODE5NSBwbGF0Zm9ybQ0KPiB0
aGF0DQo+IGNvbnRhaW5zIG1vcmUgcGljdHVyZSBxdWFsaXR5IGNvbXBvbmVudHMsIGFuZCBjYW4g
YXJyYW5nZSBtb3JlDQo+IHBpcGVsaW5lcw0KPiB0aHJvdWdoIHR3byBzZXRzIG9mIE1NU1lTIGFu
ZCBNVVRFWCByZXNwZWN0aXZlbHkuDQo+IA0KPiBNb3VkeSBIbyAoMTIpOg0KPiAgIG1lZGlhOiBw
bGF0Zm9ybTogbXRrLW1kcDM6IGFkZCBzdXBwb3J0IHNlY29uZCBzZXRzIG9mIE1NU1lTDQo+ICAg
bWVkaWE6IHBsYXRmb3JtOiBtdGstbWRwMzogYWRkIHN1cHBvcnQgc2Vjb25kIHNldHMgb2YgTVVU
RVgNCj4gICBtZWRpYTogcGxhdGZvcm06IG10ay1tZHAzOiBpbnRyb2R1Y2UgbW9yZSBwaXBlbGlu
ZXMgZnJvbSBNVDgxOTUNCj4gICBtZWRpYTogcGxhdGZvcm06IG10ay1tZHAzOiBpbnRyb2R1Y2Ug
bW9yZSBNRFAzIGNvbXBvbmVudHMNCj4gICBtZWRpYTogcGxhdGZvcm06IG10ay1tZHAzOiBhZGQg
Y2hlY2tzIGZvciBkdW1teSBjb21wb25lbnRzDQo+ICAgbWVkaWE6IHBsYXRmb3JtOiBtdGstbWRw
MzogYXZvaWQgbXVsdGlwbGUgZHJpdmVyIHJlZ2lzdHJhdGlvbnMNCj4gICBtZWRpYTogcGxhdGZv
cm06IG10ay1tZHAzOiBleHRlbmQgR0NFIGV2ZW50IHdhaXRpbmcgaW4gUkRNQSBhbmQNCj4gV1JP
VA0KPiAgIG1lZGlhOiBwbGF0Zm9ybTogbXRrLW1kcDM6IGFkZCBzdXBwb3J0IGZvciBibGVuZGlu
ZyBtdWx0aXBsZQ0KPiAgICAgY29tcG9uZW50cw0KPiAgIG1lZGlhOiBwbGF0Zm9ybTogbXRrLW1k
cDM6IGFkZCBtdDgxOTUgcGxhdGZvcm0gY29uZmlndXJhdGlvbg0KPiAgIG1lZGlhOiBwbGF0Zm9y
bTogbXRrLW1kcDM6IGFkZCBtdDgxOTUgc2hhcmVkIG1lbW9yeSBjb25maWd1cmF0aW9ucw0KPiAg
IG1lZGlhOiBwbGF0Zm9ybTogbXRrLW1kcDM6IGFkZCBtdDgxOTUgTURQMyBjb21wb25lbnQgc2V0
dGluZ3MNCj4gICBtZWRpYTogcGxhdGZvcm06IG10ay1tZHAzOiBhZGQgc3VwcG9ydCBmb3IgcGFy
YWxsZWwgcGlwZSB0byBpbXByb3ZlDQo+ICAgICBGUFMNCj4gDQo+ICAuLi4vcGxhdGZvcm0vbWVk
aWF0ZWsvbWRwMy9tZHBfY2ZnX2RhdGEuYyAgICAgfCA3MjkgKysrKysrKysrKysrKy0NCj4gIC4u
Li9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfYWFsLmggICAgICB8ICAyNSArDQo+ICAu
Li4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tZHBfcmVnX2NvbG9yLmggICAgfCAgMzEgKw0KPiAg
Li4uL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3JlZ19mZy5oIHwgIDIzICsNCj4g
IC4uLi9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfaGRyLmggICAgICB8ICAzMSArDQo+
ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tZHBfcmVnX21lcmdlLmggICAgfCAgMjUgKw0K
PiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3JlZ19vdmwuaCAgICAgIHwgIDI1ICsN
Cj4gIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfcGFkLmggICAgICB8ICAyMSAr
DQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tZHBfcmVnX3JkbWEuaCAgICAgfCAgMjQg
Kw0KPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3JlZ19yc3ouaCAgICAgIHwgICAy
ICsNCj4gIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfdGRzaHAuaCAgICB8ICAz
NCArDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tZHBfcmVnX3dyb3QuaCAgICAgfCAg
IDggKw0KPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3NtX210ODE5NS5oICAgIHwg
MjgzICsrKysrKw0KPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLWltZy1pcGkuaCAg
ICAgIHwgICA0ICsNCj4gIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLWNmZy5o
ICAgICB8ICAgMiArDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jbWRx
LmMgICAgfCA0NDAgKysrKysrKy0tDQo+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGst
bWRwMy1jbWRxLmggICAgfCAgIDEgKw0KPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRr
LW1kcDMtY29tcC5jICAgIHwgODk1DQo+ICsrKysrKysrKysrKysrKysrLQ0KPiAgLi4uL3BsYXRm
b3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtY29tcC5oICAgIHwgIDkzICstDQo+ICAuLi4vcGxh
dGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jb3JlLmMgICAgfCAxMzkgKystDQo+ICAuLi4v
cGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jb3JlLmggICAgfCAgNTAgKy0NCj4gIC4u
Li9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLW0ybS5jICAgICB8ICAxNSArDQo+ICAu
Li4vcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1yZWdzLmMgICAgfCAgMTggKw0KPiAg
Li4uL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbXRrLW1kcDMtcmVncy5oICAgIHwgICAxICsNCj4g
IC4uLi9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL210ay1tZHAzLXZwdS5jICAgICB8ICAgMyArLQ0K
PiAgMjUgZmlsZXMgY2hhbmdlZCwgMjc0NCBpbnNlcnRpb25zKCspLCAxNzggZGVsZXRpb25zKC0p
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay9tZHAzL21kcF9yZWdfYWFsLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3JlZ19jb2xvci5oDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfZmcu
aA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvbWRwMy9tZHBfcmVnX2hkci5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21kcF9yZWdfbWVyZ2UuaA0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tZHBfcmVn
X292bC5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
ZWRpYXRlay9tZHAzL21kcF9yZWdfcGFkLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21kcDMvbWRwX3JlZ190ZHNocC5oDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9tZHAzL21k
cF9zbV9tdDgxOTUuaA0KPiANCg==
