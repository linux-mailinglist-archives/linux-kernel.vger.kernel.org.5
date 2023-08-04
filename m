Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7A76F783
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjHDCKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHDCKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:10:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB44488
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:10:13 -0700 (PDT)
X-UUID: 08d1e99e326c11ee9cb5633481061a41-20230804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xlcGE01SVK9qUuL/0jTy5pnHa/nkzbb92Ia6cFWaz9M=;
        b=rEHs04nrR++Hxhe02Ci3AqeeHktEo5+eA+vFLN4Gl2VBBA4c3bvQM5dHtjGHpWJ0GXu5knfTuQgftqSvI8qy/VukDAtR5hJmQF1zauv12Ba6Wq2+t+ZDEJTYpeogvtFQSdSgemrzMj2caFmTjG5mIJ5UuM/9nLiAfpcGi6qdbtQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:e5fc84f8-9645-4d23-a59c-ee31b8f0162a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:46
X-CID-INFO: VERSION:1.1.30,REQID:e5fc84f8-9645-4d23-a59c-ee31b8f0162a,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:46
X-CID-META: VersionHash:1fcc6f8,CLOUDID:08cedea0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230803181636BF75UWIX,BulkQuantity:6,Recheck:0,SF:19|48|38|29|28|17|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,
        TF_CID_SPAM_SNR
X-UUID: 08d1e99e326c11ee9cb5633481061a41-20230804
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 324882595; Fri, 04 Aug 2023 10:10:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Aug 2023 10:10:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Aug 2023 10:10:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYr1kva6gRrW44IijvUeppf+Pq/v1BOVYsNCSsYwHKNeab5HuGBGfmWLaKEFYacXBStg3GjXcPxD7igMXiwMnWVz7dbklkffKEbVVioQ1gSdfKP6mqIFaRitWvrhlSPJLY/6H2v/EAvOn6VOKoEX3DhKRsFKR3vpsKX0EbpXrztpCfUk/XlzzKkOjIRvWfc/o20MZXUjz8naQfWfHOht5U5yLQRqgNLTZ70s0RyXkaK+W7cFqTL14I0dUL9AEw6pe0v+Hht8BPE3MWe16sjlMbbh4lR2i2yFeQeoQUdEKdke0glDdqeVnu1WlQWASXcOXmNO8Q9+LIkytFMbQgtcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlcGE01SVK9qUuL/0jTy5pnHa/nkzbb92Ia6cFWaz9M=;
 b=Klc3A7qrdUfO5S1T/gkyBjZwF7O3Rn4lpeoThWTcyf/aIQcWZg0BDrWAihGBumE36Qk1QE7X5AR0L6Qpccmx+ZCFI2ktIhrvQ2kCNMrVUzpRTm0TYJCbeGaPGH1Atqn52gQYI7YvPc6masNB8kcsxR+d6X80sIkRxr2OXjMvXjCm1kEbaN+D8yWbTyo6f78mID497DYMWNpYSQF7snr8WmRAC2CS3OALZRnRx/JjtvbmBq+VaN6lXxeaN1zvL4Tr24IwVjC+zrZ7pNIkJkDfUDMWpuEynb4Heit/RAcFp4KmVPKPVZUtjhVaMxrmsLgX/sXzuh60isDliWdrK6E2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlcGE01SVK9qUuL/0jTy5pnHa/nkzbb92Ia6cFWaz9M=;
 b=qP0GYpxMiHjP9UhisdjkNphLeIKHpKBC/9iqHWXagaXgGFDKYhuFLQ8ybumVKWKWKnLd1K+fs+kGMbi3qxLf/loG/wATl3JcAKNXxdCnnJe+OyzDtbTW88AC8eQRDJT1Iv3CeaDMiF5BMeja+Uv29Ar7m3Qs8dcB/YOzoHv66VI=
Received: from TYZPR03MB7602.apcprd03.prod.outlook.com (2603:1096:400:41c::11)
 by TYZPR03MB8284.apcprd03.prod.outlook.com (2603:1096:405:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 02:04:43 +0000
Received: from TYZPR03MB7602.apcprd03.prod.outlook.com
 ([fe80::9b3b:96da:53cd:28f9]) by TYZPR03MB7602.apcprd03.prod.outlook.com
 ([fe80::9b3b:96da:53cd:28f9%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 02:04:43 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "Hari.PrasathGE@microchip.com" <Hari.PrasathGE@microchip.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] drm/mediatek: fix uninitialized symbol
Thread-Topic: [PATCH v3] drm/mediatek: fix uninitialized symbol
Thread-Index: AQHZxe/RcM9OqQef/UGlrKkoGl/sqK/YWxkAgAEJFwA=
Date:   Fri, 4 Aug 2023 02:04:43 +0000
Message-ID: <a9a0425a5aa25228a8cd4a2c27fa7ce8d327c702.camel@mediatek.com>
References: <20230803094843.4439-1-nancy.lin@mediatek.com>
         <688a97b5-ce0c-cf6b-c78b-aa7410347d1d@microchip.com>
In-Reply-To: <688a97b5-ce0c-cf6b-c78b-aa7410347d1d@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7602:EE_|TYZPR03MB8284:EE_
x-ms-office365-filtering-correlation-id: 0a51acb4-e9d0-4227-0f94-08db948f2bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3ibMbN5dWzSwH/fuwKpO48Wke8DcvnWeIJ2W3S3Q5SCodguHJRPZM5AEUCJfV+WYpVwDF+LFBAQymyxF0nwHS28mKpEHq7ioidbSoQm0iMDxi/xxtXfk5s9tufCLXxCY0j+HYxqnGv3jOV9q0yBiUS509hGYSQ5RyvIlaT8RxI/raKiqkauq8D7NCkee025n5dUmI/BTgvIz/AkG6ZxcknSFWRsw0OCtqYI+hyZMjGzZh4VB9niZUsYs4eBeY53TCFRo75ZFADTjjIIqV4VTCTEVdLIsO+F4RkKNTKYdmC+DYW7aiTm4D+YcSspZgbdo22bx5bD9Z9LQX+FxDnFeLok5xJEdI249PzlweVuNIOuQzZp7ypu8lY6zEbGsEnp1hxXz3n2yTuX0KN8DsPN1uLA5iG0sgsftVuNbF9laEqMSedi2DxktlMyLwFNj5KzPZq+fzmhguAH3BFCfRWK4EW436yioa4m2XtODxVA+kuiMDuZtNYOMUu283+fMiaX+J5kiNoaxUU9cychjm6Yqz/Gyq9VO6QoCknes3/gqW3iEFvc+HAaIwW5xKQwp+bsmMWl1dVN/0jUBOr4nt8qBoQK94jJ9ffY0/9qFQOY5+/TqsIejdq1pN/8iCx6CmcHwRK3ZaPWEtJiBJtBD3vAgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7602.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(1800799003)(186006)(71200400001)(6512007)(966005)(6486002)(38100700002)(66446008)(66476007)(66946007)(64756008)(4326008)(76116006)(66556008)(316002)(54906003)(478600001)(38070700005)(41300700001)(5660300002)(110136005)(83380400001)(53546011)(6506007)(2616005)(26005)(122000001)(2906002)(36756003)(85182001)(8676002)(86362001)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRvbmNvUGhHaU9TU2c5cjhpbFUxTGRaTHZPSnZDclRoZWZaanNWeDZMQzNI?=
 =?utf-8?B?b0tHdVZmTGJOMEZVTGx5QW8xNnpVeW1WaWZNQ25qQnIyaFFRSHJ2V01MUmo5?=
 =?utf-8?B?UCt6U3BqVkpzR0tFY2ZNTVh0K0JUM3BUbGhsdEhHS1ZIQkZXVjhmNnEvNVZ0?=
 =?utf-8?B?N1FIa283VWQ4dlJtdkZIL2psbSs4UEw2SS9hdWJOdVFyYVcweGNVV01Lamdi?=
 =?utf-8?B?V3ROL1pRV085ZFY2NnhCRmVqdHl4ZUoyTWhaMUduZWlJZUdaSTh4ZFBDSm9m?=
 =?utf-8?B?YWhTcVNhS01zalh4S1AzUHdnclZqbnlGT3NGZVdYYmxqOXMzVUxUUDBWaGIw?=
 =?utf-8?B?NUZYaVNtczV2Y0ZMcWo1TDFpSC9zbXFVR2NIY2wvNnVNaEdCdHI3VWx2aWJC?=
 =?utf-8?B?NG1sRWZOYzFTa0RucFgyM3FJTTRhK2NETmVlVlZReE1qTE42WmJ4eDRrbGtY?=
 =?utf-8?B?N0xHSEVvK3JwTVJWTzVjQmFJRm1yMTB0MHBPNy9EVEgyekdlV1JTMDFzNXkr?=
 =?utf-8?B?SWJuTkozVjJLQnQyUytBTW0zN2ZQZ1EvY2dVRlRCSm1HYzNxSTJwQmo4SHNK?=
 =?utf-8?B?c1hoWkdpZ3NjUUtwS0hhOVRobVZGckkzLy9ScXVPTU9rZzY5RE1EVUtEV3B6?=
 =?utf-8?B?VDg5RlJYVjRIN0tQTk1QWE8wRHRwRFNvOG5wRDNoVHQ5TjN4V2JFL2hNZHRG?=
 =?utf-8?B?NElsWGMrRWlCeExGTkxjaklLQWlmcDByc2xJNHhxMm9DbzJsRmpyM3l0bENV?=
 =?utf-8?B?QVFnQ3hFbXFONVBCVG1ZZjRQZUMxWUdTWTdCenVPempOdmlNamlQbFZMZVR2?=
 =?utf-8?B?eit1ZVFxN0o0VGg2bEoxUzE5VUVITGFsUSs1d1hFZHFub2xuK0VQQU9wRkJz?=
 =?utf-8?B?bEo4dTZHbmNxY1phSzVvWlRqcmd1RWFUcVhGdXZ2ejYxbWk4b3FWakZRSHkx?=
 =?utf-8?B?SkdaWUJpVERvdUYwcHhxRXR6MHByUnJoRkxISTlSUzZxMDVsT21qdEhUT3RF?=
 =?utf-8?B?MkRPV3lwUldDUDJObDNwQ0ozYjVhZ3ZMOHNabXBxQWlzYXJvZmI0ZVcxckVT?=
 =?utf-8?B?L2lFUFV4Q0FoUUdMWGhsR25hUXVOdUMvaTBBczNNRmZTNmFqRG51eFFleFo1?=
 =?utf-8?B?bDNRenRGb2tEMkZkM1h0RGlEbEw4d2V6eVMvaDV2RlVJaDJWdDNndU82QjV4?=
 =?utf-8?B?MXdNREQzcHpTVXRrTHhndTR2RWFBMitoVFlSMnR3d2l2VVFaNEpjZlJYSGJV?=
 =?utf-8?B?VWNIa0pyTU5yZ2pMbndubFZteXpWemdlbG1OM1gwU3E4SDJDaktoM1RkdVJ3?=
 =?utf-8?B?Skd0L04vL1U1Znh6WXg2c0l1OFlPbVpITnYrbDdDZnBZSDlRYzdQb29LMkkz?=
 =?utf-8?B?UHZkNjUzbzlRQ1hhZGRycXVTR0F0NVJDUnpyTU1CeEttcmZBbVlUMGtHeFNE?=
 =?utf-8?B?c3p3NG9NV1VxVHpJWHhLek0vdWNzUWRRb01pSW5wZk13Wm5GNFE4NWx1MStG?=
 =?utf-8?B?Z1gyOXBwcFkvTzNuWGxyKzNaV1dSS3E4SHZzdG1OWThSQ3VXNXQvdDdTS0E0?=
 =?utf-8?B?VThXOFdZMFJ4Y29ZbHgwMjdvZWduSFF1S3cycmQyL2R2cGtESk9hd3NSOURp?=
 =?utf-8?B?LzZQMXE4a3RCemU2Qk1GS3ZkWTNYMi8zVVh3SUZLdnQxTmJlcFZ0WDE5Zng0?=
 =?utf-8?B?WTlucXB6R1BvVXE2MGJVb1V4ejZoQkxwWS9ZMEhUTjJ3RjVVYUEwdjBPOWZ2?=
 =?utf-8?B?NXpFbFM2ODhURFVhcHVCOXFES085b1cycnllT29jaEVXMTdJcXV4dUlEc0dN?=
 =?utf-8?B?STlybU10SkN1MkNrZHEycWUxRG5VN1NPemZ6eXNCS2RqQUVVMVZTTmM3eGc0?=
 =?utf-8?B?L0RFdWZwb1lJd2lsWjhhMlVQUDB5VFBaR0xTYVd0aHE4d0QwK2lXM2hzYk5w?=
 =?utf-8?B?cWlMbTlzekNBZ242ZGEydUdPYlh0Z2d5eGtHWndDbDRFV1BQaU5id0hVMjRT?=
 =?utf-8?B?ekpNYlEvVC9FSTVzUFlCclc5MjdZblJLL3BhdlFiZFFqZ2tTVG9rQ2RmVVNB?=
 =?utf-8?B?WHBFUERXZ2FMSjdmV29xUTkyMkdHRWh0cGtSQVZGT01KKzcvRDQwZisrMmFX?=
 =?utf-8?B?ZGhzRXk4dVNXK1NFOW44SVJVTTVsLzZGeEU1SHE5TnBkaEdWYUpMQm5heGlK?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AA7D8F9B5B7E94DB06249A6B4810681@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7602.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a51acb4-e9d0-4227-0f94-08db948f2bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 02:04:43.6830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqK11t/+nFa1CBOKNgeGc/I0wHjwYblnaL8AILCb11+XqdB8Mfc7Fj0OpN41/65kEfUqfmRd8K8ZXorRxUSYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFyaSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBUaHUsIDIwMjMtMDgtMDMg
YXQgMTA6MTUgKzAwMDAsIEhhcmkuUHJhc2F0aEdFQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+ICAJ
IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiAgT24gMDMvMDgvMjMgMzoxOCBwbSwgTmFuY3kuTGluIHdyb3RlOg0KPiA+IFtZ
b3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gbmFuY3kubGluQG1lZGlhdGVrLmNvbS4gTGVh
cm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRT
ZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+ID4gDQo+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+ID4gDQo+ID4gZml4IFNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5n
DQo+ID4gICAgLUZpeCB1bmluaXRpYWxpemVkIHN5bWJvbCBjb21wX3BkZXYgaW4gbXRrX2RkcF9j
b21wX2luaXQuDQo+ID4gDQo+ID4gRml4ZXM6IDBkOWVlZTkxMThiNyAoImRybS9tZWRpYXRlazog
QWRkIGRybSBvdmxfYWRhcHRvciBzdWIgZHJpdmVyDQo+IGZvciBNVDgxOTUiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE5hbmN5LkxpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiB2MzogZml4IHJldmlld2VyIGNvbW1lbnQgaW4gdjINCj4gPiB2MjogYWRkIEZpeGVzIHRhZw0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
YyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gaW5kZXggZjExNGRhNGQzNmE5Li43NzFmNGUx
NzMzNTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMNCj4gPiBAQCAtNTYzLDE0ICs1NjMsMTUgQEAgaW50IG10a19kZHBfY29tcF9pbml0
KHN0cnVjdCBkZXZpY2Vfbm9kZQ0KPiAqbm9kZSwgc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwN
Cj4gPiAgICAgICAgICAvKiBOb3QgYWxsIGRybSBjb21wb25lbnRzIGhhdmUgYSBEVFMgZGV2aWNl
IG5vZGUsIHN1Y2ggYXMNCj4gb3ZsX2FkYXB0b3IsDQo+ID4gICAgICAgICAgICogd2hpY2ggaXMg
dGhlIGRybSBicmluZyB1cCBzdWIgZHJpdmVyDQo+ID4gICAgICAgICAgICovDQo+ID4gLSAgICAg
ICBpZiAobm9kZSkgew0KPiA+IC0gICAgICAgICAgICAgICBjb21wX3BkZXYgPSBvZl9maW5kX2Rl
dmljZV9ieV9ub2RlKG5vZGUpOw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoIWNvbXBfcGRldikg
ew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIERSTV9JTkZPKCJXYWl0aW5nIGZvciBkZXZp
Y2UgJXNcbiIsIG5vZGUtDQo+ID5mdWxsX25hbWUpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRVBST0JFX0RFRkVSOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gLSAg
ICAgICAgICAgICAgIGNvbXAtPmRldiA9ICZjb21wX3BkZXYtPmRldjsNCj4gPiArICAgICAgIGlm
ICghbm9kZSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsgICAg
ICAgY29tcF9wZGV2ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShub2RlKTsNCj4gPiArICAgICAg
IGlmICghY29tcF9wZGV2KSB7DQo+ID4gKyAgICAgICAgICAgICAgIERSTV9JTkZPKCJXYWl0aW5n
IGZvciBkZXZpY2UgJXNcbiIsIG5vZGUtDQo+ID5mdWxsX25hbWUpOw0KPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gPiAgICAgICAgICB9DQo+ID4gKyAgICAgICBj
b21wLT5kZXYgPSAmY29tcF9wZGV2LT5kZXY7DQo+ID4gDQo+ID4gICAgICAgICAgaWYgKHR5cGUg
PT0gTVRLX0RJU1BfQUFMIHx8DQo+ID4gICAgICAgICAgICAgIHR5cGUgPT0gTVRLX0RJU1BfQkxT
IHx8DQo+ID4gQEAgLTU4MCw3ICs1ODEsNiBAQCBpbnQgbXRrX2RkcF9jb21wX2luaXQoc3RydWN0
IGRldmljZV9ub2RlICpub2RlLA0KPiBzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLA0KPiA+ICAg
ICAgICAgICAgICB0eXBlID09IE1US19ESVNQX01FUkdFIHx8DQo+ID4gICAgICAgICAgICAgIHR5
cGUgPT0gTVRLX0RJU1BfT1ZMIHx8DQo+ID4gICAgICAgICAgICAgIHR5cGUgPT0gTVRLX0RJU1Bf
T1ZMXzJMIHx8DQo+ID4gLSAgICAgICAgICAgdHlwZSA9PSBNVEtfRElTUF9PVkxfQURBUFRPUiB8
fA0KPiANCj4gSXMgdGhpcyBhbHNvIGEgcmVsYXRlZCBjaGFuZ2UgPw0KPiANCg0KVGhlc2UgYXJl
IHRoZSByZWxldmFudCBtb2RpZmljYXRpb25zLiBNVEtfRElTUF9PVkxfQURBUFRPUiB0eXBlDQpj
b21wb25lbnQgaXMgYSBzdWItZHJpdmVyIG9mIERSTSB0aGF0IGRvZXMgbm90IGhhdmUgYSBEVFMg
bm9kZS4gVGhpcw0KbW9kaWZpY2F0aW9uIHdpbGwgcmV0dXJuIHdoZW4gY2hlY2tpbmcgaWYgbm9k
ZSBpcyBOVUxMLCB3aGljaCBtZWFucyB0aGUNCmNvbXAgd2l0aCBNVEtfRElTUF9PVkxfQURBUFRP
UiB0eXBlIHdpbGwgYWxzbyByZXR1cm4gYWJvdmUuIFRoZXJlZm9yZSwNCnRoZSBjb25kaXRpb24g
InR5cGUgPT0gTVRLX0RJU1BfT1ZMX0FEQVBUT1IiIGlzIHVubmVjZXNzYXJ5IGhlcmUuDQoNClJl
Z2FyZHMsDQpOYW5jeQ0KDQo+ID4gICAgICAgICAgICAgIHR5cGUgPT0gTVRLX0RJU1BfUFdNIHx8
DQo+ID4gICAgICAgICAgICAgIHR5cGUgPT0gTVRLX0RJU1BfUkRNQSB8fA0KPiA+ICAgICAgICAg
ICAgICB0eXBlID09IE1US19EUEkgfHwNCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+IA0KPiA+IA0K
PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4g
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gDQo+IA0K
