Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92672768F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGaHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGaHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:49:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77519A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:49:14 -0700 (PDT)
X-UUID: b99ff02a2f7611eeb20a276fd37b9834-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zsdy0d1r5ddDftILKgLsN5cBILN7Wc+7EVgfHE9qjSU=;
        b=ngV8Ci6frvcMdp97v4/dSi1LqdZ3xiRPYJ9hgCotT9dy11EMxEeAthigG7LU3Q6drA/gIzVoaOC3/rzaOaSHXmL3xLOEF3hAwVQrPGTn4KPA0SZTtRC8JxVH2I7ixbfzvEoz8QpXvQ9XCzcn3BAIpLh7hPHU6/gQd1SvtdAYoU4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:059df4a1-dce2-46b3-a32e-1d377df53813,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:8968a342-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b99ff02a2f7611eeb20a276fd37b9834-20230731
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 97613512; Mon, 31 Jul 2023 15:49:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 15:49:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 15:49:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I09OcwadU57MsXspl/dQgcIOK5vxN+r1fMXRoMhlCDOCczhEuHomBB96ztE0T0BmmSp3Ib9LJV7y3/aMb4X8/LipXyeXCQIFyA+6b+7/+cXZo8vEpQUrjgRMo1AQXbn9R1oAsChoW+J58JyvkwBUOSCdk4/PtOPNUn8a8h4i8xIxEKh8qOz50Llggs7bmGcAq0Av79XICIO8ApYLOgczP326/ntjX8qMTi9uZCgCdQCOQx/B6v7nHKFY4VW5uxOEii/NIWT/qaP1m9Gzxd8evwyCTbUg9iRs7djM9HcRNDUoubBoZjdhULYfuQdY2FHHmBB5ucMj7ykMlH0PdgjsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsdy0d1r5ddDftILKgLsN5cBILN7Wc+7EVgfHE9qjSU=;
 b=msxHdgSBtvl16Iki1Yiy0o+vSeCnZ23H2ZL63Hlhw0ZeXuQ10QyQDUg492OQ1zCtp8Vk2+/i7K1SGljPh4MyEZc/hph8d6F9pOnu+VMXMLSEoYV7sVwsWJ6KeF6XxU47R+wrO9BfZHnWnbbTlyXOuSF46baCX3j/aiqCD7VrxWSL/kwXR5PepVce1Z8kxNQNWwHt9V5UnsaEgK2p/a+LUdi1jTU6TM5V84H6NfgcsIhUWuN0cUjH80txYbhRbcoLUMb9Y/27wc87iOejA+sMhjbpA3AXZhi+dVonAOJAxeefOmzD0Qf5K4tfhePv4Poh2mXgm11bpEKWTKTkhvXnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsdy0d1r5ddDftILKgLsN5cBILN7Wc+7EVgfHE9qjSU=;
 b=wFFchgjunOCKtX4Fs9jfHQy/CZKHbX5QoAtdX8m0DPwkh1wkthctqGKARx8gDCwqXSg/rhQI7NWUcHv0zToIZIGUWuYPCaxuMQkg7/L6UPomeTrTUbsY8wmnLR/KH8lDffhvd41f2r4fra7m/Wg9oKBKcv+LazAJd92M+LUNWZE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7393.apcprd03.prod.outlook.com (2603:1096:400:41f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Mon, 31 Jul
 2023 07:49:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 07:49:02 +0000
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
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH RESEND v6 03/11] drm/mediatek: gamma: Support SoC specific
 LUT size
Thread-Topic: [PATCH RESEND v6 03/11] drm/mediatek: gamma: Support SoC
 specific LUT size
Thread-Index: AQHZwG92wGZaa68WxE6Rpcper0nJNa/ThhGA
Date:   Mon, 31 Jul 2023 07:49:02 +0000
Message-ID: <e9bb287ea6177568c16ed0dc91a2d4f2c9d433e3.camel@mediatek.com>
References: <20230727094633.22505-1-angelogioacchino.delregno@collabora.com>
         <20230727094633.22505-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230727094633.22505-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7393:EE_
x-ms-office365-filtering-correlation-id: 349d45e6-e81f-4be3-7352-08db919a9bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4eIl9ZbN9/R+s1cHFJsXEJGeuktDYUXPiQKQiP+o0YJS1Y4jhindmbGQnobpkFdum9A4dQjDY2mqKuv4x7AlowiwU3tpqrHrd/ivjmlrq794ecjmqqyyQCVuE00P3pVWgHqFxjSexIYVqGqpoJrRCMVI9oGvwoSpIulkb2RJ37ckxsv/DdFuSVfAPL5HCZ86G7MjID8mZAsnWcfj8gkTCL75D+JUV1UtLW0YB4+ERA6EAloO7vdBV0TXps5qYFlq1gdI54udMaXpg1LnRFk9mR31wyydma9L+EFm+qLk39/uOrOLf8fV+ndynAa1Ehg0uWgkDQnUxJH3S6PM2QqnT1tsuacdYC8dqSCNK+HH4cb8DKfejQ0/EPhWL5mLM0vDwix4L+kbV3lUS2rAYAVESvZSVBClACVzMBZKxjW7+t2nZQ9DuGPQ/ruZDHuHlIN6iPICN/fV6/SGUpQh+BtHwzbOltZLcp7234GtRfg7uqjzkqZZWECiYGs4jqHu3ECatGBKt29guRC/7/k7E74iXcDNeZKfjWbgdxGFAUVO17+8cHW+HLJys+ZQU0KVd5WBA/fKw4vff8663YBKS26VJgjSgf5AyA8RaF51UrUMu4rmeaqn9Qik6jhHUYaJOuJ34C9RAEomFpcsJtNrn0MBnSmPt/IWYa2B6onkFS+LVUU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(6486002)(71200400001)(6512007)(478600001)(54906003)(110136005)(186003)(2616005)(6506007)(26005)(2906002)(316002)(66946007)(66556008)(66476007)(4326008)(41300700001)(66446008)(64756008)(76116006)(5660300002)(8936002)(8676002)(7416002)(122000001)(38100700002)(36756003)(85182001)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTM5cjhuZnRUczVmQkM3d200Z2hCc1lWMzhLNzdJOU91cHQvNFhaRDRuSXU3?=
 =?utf-8?B?Zjk2SDRPM3oza3RrS0xqbE1vV0hQZXpHV0ZlVHlaSnd4MUZvamJxb1o0RDU0?=
 =?utf-8?B?bXdVWGpydFlUcFhIbmxBekZ2Sno4VlQ4Y0oxYmhUUkcwaFJlM2NjSjBIWHRB?=
 =?utf-8?B?cVJvSGFycERYREVaSWJVYkl4SWc2VVV6VzkySnd3SU93THJock4yc2Z4VCs4?=
 =?utf-8?B?bzgzV0FtbTk4Qlp6Z0tYci9JU1BnWU5Jb3FLZzRyZHE5SW55ckJGVTBOVExT?=
 =?utf-8?B?QU1ad0piKy9qcnBhWWlGVlhFczNrMVJLSEtMbktqMmNRVnZDWTBQYW0zSVdG?=
 =?utf-8?B?QVBsZkdOcWlMemdUQWNjUTdRZU1DOXcxTlc0OXcyNTgzYnBmakk1blR4dUVh?=
 =?utf-8?B?eHhuVjJYL0txdGNLWVJxbkVERC9tN1lxVFZmN20rRWF5UmhrMnVaRzltZC8y?=
 =?utf-8?B?bXhTQnF1R3hCWWVFZllUZnB2Q3lWN2t0eXpLRk9OVmRXZG1IN0tmRzFCUnJz?=
 =?utf-8?B?dzFHVEdaejRtYWFheGJNNzRDQjcvalpXS0VQeU1HWE85NnpyakhQbmZmRXhL?=
 =?utf-8?B?TFA4MUNDQVNXeG1JQklzWU5NK0RXYnJTbFk3QS9ETWxyUjJMSDZ5TDN4YWRo?=
 =?utf-8?B?c2d6UWZ5ZW5NaDN2VEpPaUloZXZtQzBCTmlma0R1Wk5Wc1NYYmJzWVhQOGcz?=
 =?utf-8?B?OE5YcytCMUsvWUdVNzlNckd0WU5pNjdJMHJxSlFGRzJRWm1mRFdQaFV1a1oz?=
 =?utf-8?B?WmsydXUyZURwMW1SU0NQU0tWY1hvb2ZuSW9NMWFpc1dsZWQ5YjFZVENMemY1?=
 =?utf-8?B?bWsrZ1VUc2QvQnJsaklsTjRmaFVLdSs2dzlyVnR3TTEyT1kxMVZsRDdlem1x?=
 =?utf-8?B?cHlCeFYvYlgvUER1ZWphaUxBMGVOaUVMTjJjK0Uwb25hSlR2eU9rSkJXQkcx?=
 =?utf-8?B?Z1lGVW9KR2lnSFc2RzJvV1VxM2ZMVWxYNGgyeGFtWmJGendVMFVXQ3NRQjBS?=
 =?utf-8?B?YXNHRGRGcm9BR1laM0RSQzZUbXUrbG5iaU5rT1VEQnpIT05ROEhNaXRxdmFa?=
 =?utf-8?B?QU9DU0c1cklvUGlhbjRJVHB5d3hta3hGTDNzQjN3V0tTbGdCUmc4T3N3a1ZD?=
 =?utf-8?B?UTRPTlFGSTVFZ2VQMjVnMWdpcmtEamFMb0V4YWkxTDdXVzVKT1ZaTUhtZ2lv?=
 =?utf-8?B?M1UwNDNIeUJRdXdZUmxJeVQ3UDBmVGNIZW1zSUpIMVpNU2ZONm1kRUgwR2VG?=
 =?utf-8?B?K2tVSVRsK0luN2Vpdlg2T2J5b2x0dHhWQjV3MUE2eElnNmczY3U5emsvL05P?=
 =?utf-8?B?WjBxRDVveitacUk4OHJFQUVCT29kdDl2OS82N3MzL0FwYzZCTVRPNVhEbDBK?=
 =?utf-8?B?RmFVcE9TWURDd3MyTFlCOW1WdWREcDVsMkluTEpRRlA4ZnRBVmFPVXA4d0RM?=
 =?utf-8?B?M1IzZm51T2VFb2xiZXVTNEQzRGxZUDlhZm5OQUNFSE1LajduVkluQnJJaVA0?=
 =?utf-8?B?aXNTNTBzTlc4dVZrQW1MSGxXV2pJWUZCelBnZ0lHZ3BqdjRpQld4bmxybi9j?=
 =?utf-8?B?cVE0Nm9pclc5TVFkb2Y4eUhSRndOL0Y4NE96M2JkUm15Qis4Z3F0d2NucEpI?=
 =?utf-8?B?NnVHb3V5TG40bXJVajVMYS92WVhrUjI2dU54N0dwL21WMzJsYkJrNzNhNG5n?=
 =?utf-8?B?b1RNMjZwRXhGaWxkZlNvVjZLY2pHbTFtNXlUV3pPN1piWmh4YncrNHZuRnNk?=
 =?utf-8?B?SzZtcjRXek1sVHVUWWRMYVloT2tzQzZHaVFoNnBZWVphVnpsNVpySmRUWjhR?=
 =?utf-8?B?c2Rlb2NqK3pZdlVXRGt3bFoxQkxMWTJUS1RvdjBJQVdvVTN2WXBNQmhDZzlV?=
 =?utf-8?B?OEZDellRSFpRZHdabCtNVTdKZUhwMFdEV2I0MjFTZzlaNnNibERuRzc0QUR0?=
 =?utf-8?B?aEdGRDBQbEcxYWszbGlXL2Q3KytBMGFmTldET081UlRSUS9JVm55OFJtRmFS?=
 =?utf-8?B?R3loZ0R1V3pjUjFMc2dvdHlaMTAvUDBUd3pjSytrb1YvaTI5MHlJVSsva0Jm?=
 =?utf-8?B?Tm1YZTFtbkVLZlBjWWdHN1hLcFkzaCtDcHBRRnNLWHc2ZkQ1Y1BnbDZrQ2NR?=
 =?utf-8?Q?SWk9nDikb6PYGM9QkbLW5iTb0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39BF31F66A791B4ABEC2F3C0CB2F40CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349d45e6-e81f-4be3-7352-08db919a9bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 07:49:02.5215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onbdMWn56nixTiezXLm4IBdwfWFVSMB6As5Ut393QDaVy3aIaK3byB5luIswIA7OPGANWdPi1tVVtp8MlbI0xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7393
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDIzLTA3LTI3IGF0IDExOjQ2ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3ZXIgU29DcyBzdXBwb3J0IGEgYmlnZ2Vy
IEdhbW1hIExVVCB0YWJsZTogd2lyZSB1cCBhIGNhbGxiYWNrDQo+IHRvIHJldHJpZXZlIHRoZSBj
b3JyZWN0IExVVCBzaXplIGZvciBlYWNoIGRpZmZlcmVudCBHYW1tYSBJUC4NCj4gDQo+IENvLWRl
dmVsb3BlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
IFtBbmdlbG86IFJld3JpdHRlbiBjb21taXQgbWVzc2FnZS9kZXNjcmlwdGlvbiArIHBvcnRpbmdd
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAgICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYyAgIHwgMjUgKysrKysrKysrKysrKysrKysrLQ0K
PiAtLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8ICA0
ICsrLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuaCAgICAgfCAg
MSAtDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgIDEg
Kw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8ICA5ICsr
KysrKysrDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IGlu
ZGV4IDc1MDQ1OTMyMzUzZS4uZTU1NGIxOWY0ODMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC01Myw2ICs1Myw3IEBAIHZvaWQgbXRrX2dhbW1h
X2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19nYW1tYV9jb25m
aWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gIAkJICAgICAgdW5zaWdu
ZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCj4gIAkJICAgICAgdW5zaWduZWQgaW50
IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCk7DQo+ICt1bnNpZ25lZCBpbnQgbXRrX2dh
bW1hX2dldF9sdXRfc2l6ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfZ2FtbWFf
c2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlDQo+ICpzdGF0ZSk7
DQo+ICB2b2lkIG10a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBf
X2lvbWVtICpyZWdzLA0KPiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKTsNCj4gIHZvaWQg
bXRrX2dhbW1hX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGluZGV4IGNlNmYyNDk5Yjg5MS4uYjI1YmEy
MDllN2E0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
Z2FtbWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZ2FtbWEu
Yw0KPiBAQCAtMjUsMTAgKzI1LDEyIEBADQo+ICAjZGVmaW5lIERJU1BfR0FNTUFfTFVUCQkJCTB4
MDcwMA0KPiAgDQo+ICAjZGVmaW5lIExVVF8xMEJJVF9NQVNLCQkJCTB4MDNmZg0KPiArI2RlZmlu
ZSBMVVRfU0laRV9ERUZBVUxUCQkJNTEyDQo+ICANCj4gIHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9k
YXRhIHsNCj4gIAlib29sIGhhc19kaXRoZXI7DQo+ICAJYm9vbCBsdXRfZGlmZjsNCj4gKwl1MTYg
bHV0X3NpemU7DQo+ICB9Ow0KPiAgDQo+ICAvKg0KPiBAQCAtNTUsNiArNTcsMTcgQEAgdm9pZCBt
dGtfZ2FtbWFfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCWNsa19kaXNhYmxl
X3VucHJlcGFyZShnYW1tYS0+Y2xrKTsNCj4gIH0NCj4gIA0KPiArdW5zaWduZWQgaW50IG10a19n
YW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBt
dGtfZGlzcF9nYW1tYSAqZ2FtbWEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25l
ZCBpbnQgbHV0X3NpemUgPSBMVVRfU0laRV9ERUZBVUxUOw0KPiArDQo+ICsJaWYgKGdhbW1hICYm
IGdhbW1hLT5kYXRhKQ0KPiArCQlsdXRfc2l6ZSA9IGdhbW1hLT5kYXRhLT5sdXRfc2l6ZTsNCj4g
Kw0KPiArCXJldHVybiBsdXRfc2l6ZTsNCj4gK30NCj4gKw0KPiAgdm9pZCBtdGtfZ2FtbWFfc2V0
X2NvbW1vbihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgX19pb21lbSAqcmVncywNCj4gc3RydWN0
IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEg
KmdhbW1hID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+IEBAIC02Miw2ICs3NSw3IEBAIHZvaWQg
bXRrX2dhbW1hX3NldF9jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkDQo+IF9faW9tZW0g
KnJlZ3MsIHN0cnVjdCBkcm1fY3J0DQo+ICAJc3RydWN0IGRybV9jb2xvcl9sdXQgKmx1dDsNCj4g
IAl2b2lkIF9faW9tZW0gKmx1dF9iYXNlOw0KPiAgCWJvb2wgbHV0X2RpZmY7DQo+ICsJdTE2IGx1
dF9zaXplOw0KPiAgCXUzMiB3b3JkOw0KPiAgCXUzMiBkaWZmWzNdID0gezB9Ow0KPiAgDQo+IEBA
IC02OSwxNyArODMsMjAgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHZvaWQgX19pb21lbSAqcmVncywgc3RydWN0IGRybV9jcnQNCj4gIAlpZiAoIXN0
YXRlLT5nYW1tYV9sdXQpDQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCWlmIChnYW1tYSAmJiBnYW1t
YS0+ZGF0YSkNCj4gKwlpZiAoZ2FtbWEgJiYgZ2FtbWEtPmRhdGEpIHsNCj4gIAkJbHV0X2RpZmYg
PSBnYW1tYS0+ZGF0YS0+bHV0X2RpZmY7DQo+IC0JZWxzZQ0KPiArCQlsdXRfc2l6ZSA9IGdhbW1h
LT5kYXRhLT5sdXRfc2l6ZTsNCj4gKwl9IGVsc2Ugew0KPiAgCQlsdXRfZGlmZiA9IGZhbHNlOw0K
PiArCQlsdXRfc2l6ZSA9IExVVF9TSVpFX0RFRkFVTFQ7DQo+ICsJfQ0KPiAgDQo+ICAJcmVnID0g
cmVhZGwocmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gIAlyZWcgPSByZWcgfCBHQU1NQV9MVVRf
RU47DQo+ICAJd3JpdGVsKHJlZywgcmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gIAlsdXRfYmFz
ZSA9IHJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4gIAlsdXQgPSAoc3RydWN0IGRybV9jb2xvcl9s
dXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiAtCWZvciAoaSA9IDA7IGkgPCBNVEtfTFVU
X1NJWkU7IGkrKykgew0KPiArCWZvciAoaSA9IDA7IGkgPCBsdXRfc2l6ZTsgaSsrKSB7DQo+ICAJ
CWlmICghbHV0X2RpZmYgfHwgKGkgJSAyID09IDApKSB7DQo+ICAJCQl3b3JkID0gKCgobHV0W2ld
LnJlZCA+PiA2KSAmIExVVF8xMEJJVF9NQVNLKSA8PA0KPiAyMCkgKw0KPiAgCQkJCSgoKGx1dFtp
XS5ncmVlbiA+PiA2KSAmIExVVF8xMEJJVF9NQVNLKQ0KPiA8PCAxMCkgKw0KPiBAQCAtMTk2LDEw
ICsyMTMsMTIgQEAgc3RhdGljIGludCBtdGtfZGlzcF9nYW1tYV9yZW1vdmUoc3RydWN0DQo+IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlz
cF9nYW1tYV9kYXRhIG10ODE3M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFzX2RpdGhl
ciA9IHRydWUsDQo+ICsJLmx1dF9zaXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIG10ODE4M19nYW1tYV9kcml2ZXJfZGF0YSA9
IHsNCj4gIAkubHV0X2RpZmYgPSB0cnVlLA0KPiArCS5sdXRfc2l6ZSA9IDUxMiwNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX2dhbW1hX2Ry
aXZlcl9kdF9tYXRjaFtdID0NCj4gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQo+IGluZGV4IGQ0MDE0Mjg0MmY4NS4uMGRmNjJiMDc2ZjQ5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC05NTgsOCArOTU4LDgg
QEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCj4gKmRybV9kZXYs
DQo+ICAJCW10a19jcnRjLT5kZHBfY29tcFtpXSA9IGNvbXA7DQo+ICANCj4gIAkJaWYgKGNvbXAt
PmZ1bmNzKSB7DQo+IC0JCQlpZiAoY29tcC0+ZnVuY3MtPmdhbW1hX3NldCkNCj4gLQkJCQlnYW1t
YV9sdXRfc2l6ZSA9IE1US19MVVRfU0laRTsNCj4gKwkJCWlmIChjb21wLT5mdW5jcy0+Z2FtbWFf
c2V0ICYmIGNvbXAtPmZ1bmNzLQ0KPiA+Z2FtbWFfZ2V0X2x1dF9zaXplKQ0KPiArCQkJCWdhbW1h
X2x1dF9zaXplID0NCj4gbXRrX2RkcF9nYW1tYV9nZXRfbHV0X3NpemUoY29tcCk7DQoNCkluIHRo
aXMgcGF0Y2gsIGZvciBBQUwsIHRoZSBnYW1tYV9sdXRfc2l6ZSBpcyBub3QgZGVmaW5lZC4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gIA0KPiAgCQkJaWYgKGNvbXAtPmZ1bmNzLT5jdG1fc2V0KQ0KPiAg
CQkJCWhhc19jdG0gPSB0cnVlOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5oDQo+IGluZGV4IDNlOTA0Njk5M2QwOS4uYjJlNTAyOTJlNTdkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oDQo+IEBAIC0xMCw3ICsxMCw2IEBADQo+
ICAjaW5jbHVkZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fcGxh
bmUuaCINCj4gIA0KPiAtI2RlZmluZSBNVEtfTFVUX1NJWkUJNTEyDQo+ICAjZGVmaW5lIE1US19N
QVhfQlBDCTEwDQo+ICAjZGVmaW5lIE1US19NSU5fQlBDCTMNCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggZjExNGRhNGQzNmE5
Li5jNzdhZjJlNDAwMGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuYw0KPiBAQCAtMzIyLDYgKzMyMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9kc2kgPQ0KPiB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZ2FtbWEgPSB7DQo+ICAJLmNsa19lbmFibGUgPSBtdGtf
Z2FtbWFfY2xrX2VuYWJsZSwNCj4gIAkuY2xrX2Rpc2FibGUgPSBtdGtfZ2FtbWFfY2xrX2Rpc2Fi
bGUsDQo+ICsJLmdhbW1hX2dldF9sdXRfc2l6ZSA9IG10a19nYW1tYV9nZXRfbHV0X3NpemUsDQo+
ICAJLmdhbW1hX3NldCA9IG10a19nYW1tYV9zZXQsDQo+ICAJLmNvbmZpZyA9IG10a19nYW1tYV9j
b25maWcsDQo+ICAJLnN0YXJ0ID0gbXRrX2dhbW1hX3N0YXJ0LA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gaW5kZXggZmViY2FlZWYxNmExLi5j
MTM1NTk2MGUxOTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaA0KPiBAQCAtNjcsNiArNjcsNyBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNz
IHsNCj4gIAl2b2lkICgqbGF5ZXJfY29uZmlnKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVk
IGludCBpZHgsDQo+ICAJCQkgICAgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlLA0KPiAg
CQkJICAgICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KTsNCj4gKwl1bnNpZ25lZCBpbnQgKCpn
YW1tYV9nZXRfbHV0X3NpemUpKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICAJdm9pZCAoKmdhbW1h
X3NldCkoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQkJICBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUg
KnN0YXRlKTsNCj4gIAl2b2lkICgqYmdjbHJfaW5fb24pKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+
IEBAIC0xODYsNiArMTg3LDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0KPiBtdGtfZGRwX2NvbXBf
bGF5ZXJfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICAJCWNvbXAtPmZ1bmNz
LT5sYXllcl9jb25maWcoY29tcC0+ZGV2LCBpZHgsIHN0YXRlLA0KPiBjbWRxX3BrdCk7DQo+ICB9
DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG10a19kZHBfZ2FtbWFfZ2V0X2x1
dF9zaXplKHN0cnVjdA0KPiBtdGtfZGRwX2NvbXAgKmNvbXApDQo+ICt7DQo+ICsJaWYgKGNvbXAt
PmZ1bmNzICYmIGNvbXAtPmZ1bmNzLT5nYW1tYV9nZXRfbHV0X3NpemUpDQo+ICsJCXJldHVybiBj
b21wLT5mdW5jcy0+Z2FtbWFfZ2V0X2x1dF9zaXplKGNvbXAtPmRldik7DQo+ICsNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSB2b2lkIG10a19kZHBfZ2FtbWFfc2V0
KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ICAJCQkJICAgICBzdHJ1Y3QgZHJtX2NydGNf
c3RhdGUgKnN0YXRlKQ0KPiAgew0K
