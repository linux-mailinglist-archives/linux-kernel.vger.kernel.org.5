Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98BE7BC4F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJGGQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbjJGGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:16:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E2BF;
        Fri,  6 Oct 2023 23:16:36 -0700 (PDT)
X-UUID: 0bf9121a64d911ee8051498923ad61e6-20231007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ds5y9BdfsCHo30OmjnjR2fc1qE0Yq28KmIcnrVGR7EU=;
        b=mQSupmqFuM0/IzUkUCn2arsV3Lk+hoK894fGVdDnHCAxUZHKXxTpZfkM626GgD2exBRmtWJLcVVtPVNr+esOK6sODqxhEDgCkRVkxfCGPLKT6lkNFxDtIZzbFKxBTAB2yz6yobt6xqd0c5CwjBFxejFY5r6UDHiq4ZIRvt2+KcA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bcf7a9fa-c221-4c91-a8e8-7f89ba29c3f7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:710baebf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0bf9121a64d911ee8051498923ad61e6-20231007
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1159196809; Sat, 07 Oct 2023 14:16:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 7 Oct 2023 14:16:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 7 Oct 2023 14:16:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b045NxAy6DGmPaFlaIYc/+fubJnMH3DSEcllnebV3N4YxK4/gqK8IBayqGtp0OJWChoPD278TusBdw4vAmVWgIHQHFVrDa67/EUBwkNoxNNohGOr4lskaYEv60tUv0Xn5s3Ugr0RJ6WND6q9uEDpeL5xd6vz8F/dkTNd/4Tt3rhtUrg6BkBWfM3dtkUHjcRFgZBCPh5rU7i0omqyq17Ncti+XbXVKBTW4oivl5SsvT3zBBPg6CoTt2U0RXUo1LYpfwXDkYZ7TTtP1+UU9DxyJ8Ve/e5b/kQz5CuB0tzYCrT1hWd9owbCSXvOeLOg8hqNrtPdsV1dX2h2GX7FcJq2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds5y9BdfsCHo30OmjnjR2fc1qE0Yq28KmIcnrVGR7EU=;
 b=e/z+1tb2oKhlGFrZPw9rpFhgJ178g9/l6BSb7NU6BCg48t2TsRWqxLBmUetXuC+t1B73HNMvcb+3g1VGFDZwo5dOv6jyC+HFNnuB/0MAVa4OcKy2pOh6x31mDJ0m5EJUtTZZAHR74Kfav7gOp10Lt6LCopCJFQ7gmDuUECpvQk1jG5w6G+dwBDzuOrkFs5QCwEmP5Kv4fYJJx+4ehmXfRhM2LGk7gylxyctRW4uOlLAj+pRKIhbuNOKVw5Pos1Fb1inpxjA23EHtrYagKmsOuHeNmxAoIagpFkQ1N321yek/efafRFPyqyv2khNp+z5WtBu/oTCG3GJ+WWT2vgHMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds5y9BdfsCHo30OmjnjR2fc1qE0Yq28KmIcnrVGR7EU=;
 b=c6XipVRgDdlLL9Ov7YQFJpH2qsH1Cs/drtIVpqYcxmejsO5ISi5/0V+3eJQQmMKif9Umt96T4ILOyUsT2uDvcwyb+wBTJAPegN5OOagPDdwEIekeFk4+wjF+kLsYbyQVkfmm64zPvfgKyekZrkR3B6EOUGbX4diKOIceeW3OgUk=
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com (2603:1096:101:187::6)
 by SI2PR03MB6464.apcprd03.prod.outlook.com (2603:1096:4:1a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 06:16:22 +0000
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::c468:315e:d2f2:c3e]) by SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::c468:315e:d2f2:c3e%4]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 06:16:21 +0000
From:   =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] media: mediatek: vcodec: Handle encoder vsi NULL
 pointer case
Thread-Topic: [PATCH 2/2] media: mediatek: vcodec: Handle encoder vsi NULL
 pointer case
Thread-Index: AQHZ8GMBpdc65+S2UUigw07IyekOSrA67zMAgAL7m4A=
Date:   Sat, 7 Oct 2023 06:16:21 +0000
Message-ID: <bfac65fcd5df18fd31db4b0d326b0dec48ae88e1.camel@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
         <20230926101909.15030-2-irui.wang@mediatek.com>
         <b7c19673-a3bd-449a-9e84-49a68c89b0ea@xs4all.nl>
In-Reply-To: <b7c19673-a3bd-449a-9e84-49a68c89b0ea@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7947:EE_|SI2PR03MB6464:EE_
x-ms-office365-filtering-correlation-id: caf6db2f-3d74-4ba2-4529-08dbc6fced48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8fvlfzXu6IF6vw0RQzGouxZAurBeeA1mxXNtlMueZCWI+JBkGYHtXPACUPZ+CQR7qjJZaLI0HDDYjccQqbiAZXTNPtUhUiOnjzxGEcfA3GJR9WWU79ctK8ZxmogcaSt9XnBcVDKOeviw5bLBlfnHkaJBX1x5HZNoYeFFP3z70cvzK+zX/f6y0FFQNSAII7j0WY1PWaAX8XDMSzc5AYMY4XZ7exX3hhGg7tJS70Ik8C7249PNipl3F8xVgaKLowkN7Hw3ACGwqfxp3WisgFiZgy9ZqcMWiXk+/kIbqdgo9iHmhyI8JhlS9O2r8f1MoEFU5IMKTQtXLjp+WdwkCuzvbIAXTH+ng5UtJRtz2mPpC6p8FU6Cf32UF/JjLsnFgi9THIwPni0ijNFPQK+NR+CWJe2LduzU8vp+9u/AEyMSGA8Bh9LUoqihuxSSCfVck/IMAq8F4+xPrTyL44kwS1hbQXKrf/8gLrcNiqzF9Hf19ghXXcY+s78NBAdFDr9XNkQfG2JsjMFrqfd9nzVYHJT+eO7PN/RuyPEv/0DLifuaAnZFibMCQPuLK5Wr4qGmoue+aTHcLTxrUkPwr2Vb3MaEEqTLksuGMosWU2q1exnaO+mMrq0nSihmnFXVecRbMsIYgH17o+h1yJ+YlgmdgRcqECNV+FawUhWS2DvgZk52zE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(2906002)(4326008)(64756008)(8676002)(8936002)(41300700001)(54906003)(5660300002)(85182001)(6636002)(36756003)(7416002)(91956017)(110136005)(66476007)(76116006)(66556008)(66446008)(86362001)(6486002)(53546011)(66946007)(71200400001)(6506007)(478600001)(2616005)(316002)(26005)(122000001)(38100700002)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rlc1ZEpId2hBYUtuZ21PY2hpL3VteFp1WXFWSmZyZ3I5R1Y5RlQ5RXY4VGlU?=
 =?utf-8?B?cStYM1YxclB5Mmx3cXh2M2EwRW12b01tempWcmpPSzAwZ2JzOVNkL0J4YTUv?=
 =?utf-8?B?Ym9jd3pGR0dKNnB5U3JkUmt4Zmx1bkpSb0o0TFNlcmFBNnBNeTlHKzErWnBX?=
 =?utf-8?B?S0dIL2NtSHVHcjFlQzVxM2MwM3RHN2ZsdjlKRm9TMzlmbVdDYW84bTlvcFhp?=
 =?utf-8?B?SUtjQlMxRVJZekFxUXFuSmM3K3dTR2Y4cG94SlExWmpsM2JaVnpCa1dRcFVH?=
 =?utf-8?B?WWE2bDZSUERVa3B1UExqb0RrbWhycWRINEVIanBVaS9BNkFYd0VqU2M3Z1c2?=
 =?utf-8?B?VXg5cHFlZTEwTkVyN0lWcGhvNiszNVhDNzFBK2VHU2lSYVV4bWh6UWNBQmxW?=
 =?utf-8?B?eW1wakR2QTFDNmtyelo2SXNRQVpyUUxyd3dlbVRoeTVuMElISEdRa1orUCtO?=
 =?utf-8?B?eEdraHdXZllUWGQyN0srODZtWlUwRlI0M25QNWl3ay9tV2JWNTZwT2NlUnZU?=
 =?utf-8?B?NktZYkRDV3pVUXl0V1FYVGtGRVhHdjMybHBCd0ZNU3NzcTYvYU1BdEdZVisr?=
 =?utf-8?B?V1prNVdvOFMwczBrNDhjdDBYQjR5cU02akJTRXZ2dmdvZWxjdmt4Sldyd0ty?=
 =?utf-8?B?TUVKVUJGZW0zdmFJUXgwREgwWjEzZWhoT3NIS3R2VWxIWUU5ZzdtcjVVdTBk?=
 =?utf-8?B?WFRSdUJxOThxUkVkOGlxOXhPNno0eTBsaUM0L0dvck5zNnkvUnQ5ZCs0ZUlP?=
 =?utf-8?B?d0NiNldkRGI5NXBHZWdCbi9ORWxjd3J5TlhJWlhRcmk1TitJc05CdFBPeHY0?=
 =?utf-8?B?S1RNQ2VVVVFhSlRWbmJkY0piS1haVmgyOG9UQlRCbWpSa0toVDhXMDRYK2R6?=
 =?utf-8?B?SXRVQlpzdDVUUW4wNU96elMzd1BCcnBBUldwck4vakpsYXVZeDc1U1JoRThO?=
 =?utf-8?B?OGtkU29iRnI2ZEpZOXZkV2hkZHRwalptSEp5amVURkNBbjFIbUNkVkNNNjRk?=
 =?utf-8?B?SlNmN2J3VGtKdnNuOFIvT0djS0F1WDkvMUk2SGtZREY3dVdkdWdOUlpJdFVp?=
 =?utf-8?B?TlA4SXdEdzlIUEhja21Ib0lWdVZyWGVzVjZLb29jRS9hcThIdm1mSHFLbjJM?=
 =?utf-8?B?RGMxSmcyd3RIRThKSTdGUWpqc1YvcjA0UWQydzBNU1NPVHJZUFY0amNMemxM?=
 =?utf-8?B?Z1lXNStvYWhJeG82UWhnQkp1VlV6R2s3TzhrUXlDMmpaSFNrWTBiOUFaRXpw?=
 =?utf-8?B?S25aNU9FYXhCWDlpUnduRCsxQi90Y0tXUVAwU3JNVW5RS3Urc1JjZ0tSWkJa?=
 =?utf-8?B?QzhEeVBTRk1IcEhsR1hmdjNGMWpqQ2VxZk80RTNLNElRWlR5WlByZ3JVYUFm?=
 =?utf-8?B?aTNJQXUvc2UrUTNVWVd5RXVKdDFOM2hGZ3VESElQeHVJd3NYeWgxUGcyTWpr?=
 =?utf-8?B?ODR6STlLYnN0cjVVdFB5SFNZYk80bE1EdkhkbDhLRy96eFljNXNYWEoyUEZR?=
 =?utf-8?B?YlhCdHJaSC9VWVg0elBEclZTcW42L1Z1ZGtnUnNKbTBoNnM1TGtFd2I5WDVC?=
 =?utf-8?B?bW8vMnQ3RG5tUlFNYW56a2RPWDk2VzlOWUl4MllTeGo2TitFY3VuaGhlcDNL?=
 =?utf-8?B?Rjh2ek1IZExraVBvQTZkamtrQkpJNCtRNEI3SFFSZXpvNmhGL2htUlJZdlR1?=
 =?utf-8?B?QTVncUowSklKZ1p6M2VUcHB1cHVHb2tJQzUyU2dJSnVBVzZTTWEzeWNnRmdS?=
 =?utf-8?B?bkxLamduVUlrWjZDSUZRYnEwb3oycXl5RW43VVJOOWxFaVpDUTFTanFlZ0ZO?=
 =?utf-8?B?QWRrLys1NEVrVVRRS0x3dmhsbWd4WmlMaGkrMGpDNXRuYjV2a3JjSVdqc2FU?=
 =?utf-8?B?cGFhaGVKdDlyNE5UajNxUDNraWRWRXRqdWZvSjg2ZnZWd2lnVnB6aC9pYm8r?=
 =?utf-8?B?UGpyRmJVZXpnRWwxRmxtcjE0czNkWWhjbGVUSCtQR1FaWnNmY0JRb2prUmNq?=
 =?utf-8?B?Q1UzK2RhS0FqUnpvc2dYM0x4SnVpTkFYZ1FleXB1ZmhpQVFFSjV2THdnWWJa?=
 =?utf-8?B?azNNbDIzaXlHc0hzWDlOOGVzTVhZNU9hNkM5OEdQL3FuclhkMVhBMXZUdER0?=
 =?utf-8?B?L0xFTEYxQnpRQTFEUG5vbzBHTUZjZWVxaFhDbFJWNFdVT2lHc1FscU9HZUdI?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46C1B9FC21DEB9418FD048AA9177B455@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf6db2f-3d74-4ba2-4529-08dbc6fced48
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 06:16:21.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z+UWmBNACOe/JlYZVazReMbAr6VFWjdGWz1KkjhXxvsDB9jeME1dnPTwKA3GCAM2MATlSC39tQnQ4SBJzO/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6464
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmdlbG8sIEhhbnMsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcuDQoNCkkgd2ls
bCBzZW5kIHBhdGNoIHYyIHdpdGggRml4IHRhZy4uLg0KLi4uLg0KDQpPbiBUaHUsIDIwMjMtMTAt
MDUgYXQgMTA6NDMgKzAyMDAsIEhhbnMgVmVya3VpbCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFs
IGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
dGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBP
biAyNi8wOS8yMDIzIDEyOjE5LCBJcnVpIFdhbmcgd3JvdGU6DQo+ID4gVGhlcmUgd2lsbCBiZSBh
IGtlcm5lbCBudWxsIHBvaW50ZXIgZXhjZXB0aW9uIGlmICd2c2knIGlzIE5VTEwsDQo+IGNoZWNr
DQo+ID4gJ3ZzaScgaXMgbm90IE5VTEwgYmVmb3JlIGFzc2lnbiBpdCB0byBlbmNvZGVyIGluc3Rh
bmNlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IElydWkgV2FuZyA8aXJ1aS53YW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNv
ZGVyL3ZlbmMvdmVuY19oMjY0X2lmLmMgICAgIHwgNQ0KPiArKysrKw0KPiA+ICAuLi4vcGxhdGZv
cm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuYy92ZW5jX3ZwOF9pZi5jICAgICAgfCA1DQo+
ICsrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9l
bmNvZGVyL3ZlbmMvdmVuY19oMjY0X2lmLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21l
ZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL3ZlbmMvdmVuY19oMjY0X2lmLmMNCj4gPiBpbmRleCBhNjhk
YWM3MmM0ZTQuLjM4NWJjYzBkMTRmMyAxMDA2NDQNCj4gPiAtLS0NCj4gYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL3ZlbmMvdmVuY19oMjY0X2lmLmMNCj4g
PiArKysNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVy
L3ZlbmMvdmVuY19oMjY0X2lmLmMNCj4gPiBAQCAtNTk3LDYgKzU5NywxMSBAQCBzdGF0aWMgaW50
IGgyNjRfZW5jX2luaXQoc3RydWN0DQo+IG10a192Y29kZWNfZW5jX2N0eCAqY3R4KQ0KPiA+ICBp
bnN0LT5od19iYXNlID0gbXRrX3Zjb2RlY19nZXRfcmVnX2FkZHIoaW5zdC0+Y3R4LT5kZXYtPnJl
Z19iYXNlLA0KPiBWRU5DX1NZUyk7DQo+ID4gIA0KPiA+ICByZXQgPSB2cHVfZW5jX2luaXQoJmlu
c3QtPnZwdV9pbnN0KTsNCj4gPiAraWYgKCFpbnN0LT52cHVfaW5zdC52c2kpIHsNCj4gPiArbXRr
X3ZlbmNfZXJyKGN0eCwgInNoYXJlIGJ1ZmZlciBpcyBOVUxMIik7DQo+ID4gK2tmcmVlKGluc3Qp
Ow0KPiA+ICtyZXR1cm4gLUVGQVVMVDsNCj4gPiArfQ0KPiANCj4gU2hvdWxkbid0IHRoaXMgY2hl
Y2sgYmUgZG9uZSBpbiB2cHVfZW5jX2luaXQ/DQo+IEl0IGxvb2tzIHdlaXJkIHRoYXQgYSBmdW5j
dGlvbiBjYW4gcmV0dXJuIDAsIGJ1dCB0aGVyZSBpcyBzdGlsbCBhbg0KPiBlcnJvciB0aGF0IG5l
ZWRzIHRvIGJlIGNoZWNrZWQgbWFudWFsbHkgYWZ0ZXJ3YXJkcy4NCj4gDQo+IFJlZ2FyZHMsDQo+
IA0KPiBIYW5zDQpBbHNvLCB0aGlzIGNoZWNrIHdpbGwgbW92ZSBpbnRvIHZwdV9lbmNfaW5pdC4N
Cg0KQmVzdCBSZWdhcmRzDQo+IA0KPiA+ICANCj4gPiAgaWYgKE1US19FTkNfSU9WQV9JU18zNEJJ
VChjdHgpKQ0KPiA+ICBpbnN0LT52c2lfMzQgPSAoc3RydWN0IHZlbmNfaDI2NF92c2lfMzQgKilp
bnN0LT52cHVfaW5zdC52c2k7DQo+ID4gZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuYy92ZW5jX3ZwOF9pZi5jDQo+IGIvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZW5jb2Rlci92ZW5jL3ZlbmNfdnA4
X2lmLmMNCj4gPiBpbmRleCAwNWFiY2E5MWU3NDIuLjIzY2EwZDkzMzI0ZiAxMDA2NDQNCj4gPiAt
LS0NCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9lbmNvZGVyL3Zl
bmMvdmVuY192cDhfaWYuYw0KPiA+ICsrKw0KPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL2VuY29kZXIvdmVuYy92ZW5jX3ZwOF9pZi5jDQo+ID4gQEAgLTMyNiw2ICsz
MjYsMTEgQEAgc3RhdGljIGludCB2cDhfZW5jX2luaXQoc3RydWN0DQo+IG10a192Y29kZWNfZW5j
X2N0eCAqY3R4KQ0KPiA+ICBpbnN0LT5od19iYXNlID0gbXRrX3Zjb2RlY19nZXRfcmVnX2FkZHIo
aW5zdC0+Y3R4LT5kZXYtPnJlZ19iYXNlLA0KPiBWRU5DX0xUX1NZUyk7DQo+ID4gIA0KPiA+ICBy
ZXQgPSB2cHVfZW5jX2luaXQoJmluc3QtPnZwdV9pbnN0KTsNCj4gPiAraWYgKCFpbnN0LT52cHVf
aW5zdC52c2kpIHsNCj4gPiArbXRrX3ZlbmNfZXJyKGN0eCwgInNoYXJlIGJ1ZmZlciBpcyBOVUxM
Iik7DQo+ID4gK2tmcmVlKGluc3QpOw0KPiA+ICtyZXR1cm4gLUVGQVVMVDsNCj4gPiArfQ0KPiA+
ICANCj4gPiAgaW5zdC0+dnNpID0gKHN0cnVjdCB2ZW5jX3ZwOF92c2kgKilpbnN0LT52cHVfaW5z
dC52c2k7DQo+ID4gIA0KPiANCg==
