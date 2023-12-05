Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4118043F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjLEBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbjLEBXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:23:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56574A4;
        Mon,  4 Dec 2023 17:23:32 -0800 (PST)
X-UUID: e2b8bace930c11eea33bb35ae8d461a2-20231205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xhm/L5UlLpy/HEEsBenU8d4cfcuzwWQIgI+SMSEnQ5E=;
        b=S0Obnk+vD5LZeo7oJM+kguM1F6GoYezMQLGC2iLzWlswdW8Il3qCRNlVSV2VCd8ESBQokWQ+nWrMBhV31aYAIf3ahn65skC3H4jLKFGtJ/Vd6x+QNN/BcZxqRVyP6J5rmbG6D3Q4Dd4gBca2ObdyfA1nANBI6fDqcBM1M2/tnKE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:03d85c19-8f0e-4a64-afef-d43800812988,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:a1ff48fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e2b8bace930c11eea33bb35ae8d461a2-20231205
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 705117120; Tue, 05 Dec 2023 09:23:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Dec 2023 09:23:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Dec 2023 09:23:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrZgF4TjKn4wQ/FLao/dew8rks8utu/P8nBIPpoWPALxnkVqF8kyosOvRss8AjoAcSwSmSyGH+Hbnxau98G2Irtur00BM0NVZ4ShY0Y0r/h3hEsaUHCASA9+xGynXCxamD/aq32UE7wLX0LFfyp7M5oil1OBgT+jf8enNsgg6geX2E040RhRHliH2Lo51dY4jkLCJ6N2e0N5smeDgdbimtoW71iwJEXqSjWF1kR+8LRVAav38Mi398CCeC0Le1To3iJawHgfgi6jNKaJax2CcBFU2eZmU27akA0Xv+Ahdl3r84g9NtP2Tp5OHxyRSI/zsDLnsSWExCSE76Cbxil9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhm/L5UlLpy/HEEsBenU8d4cfcuzwWQIgI+SMSEnQ5E=;
 b=N/PAo0UfEL6WAdSAY6T29zhOYMy1NNZtXW9/fmmQ0x/+Na8dI3sgqjYEe2YkH+3J72WNp9rG6sXtZCtHx6hxaXsLzqtp4GbVLDQdnLn7FfwS/HQXBBYanBaUaJ50VEYYp2Ag2Dbcpau2pTCvMLP4ARJVPez8V4rzTfLPyBWYVF11f9RO0Sb0GgPdU8ubZ5OcOOpls9kkmvvq7N+nGJjp3QkISLLFOhombf2WOavtApDyDM4Dkkrg65B9ituYK2FxbGR+Bo1wojei9dNGoEm4jn0bExqvLHZsvD/pxRzEFYUBK37EQT6+4gHJ9J5Z6Wu4jsoRkxp7VUxJdDiRQL3DLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhm/L5UlLpy/HEEsBenU8d4cfcuzwWQIgI+SMSEnQ5E=;
 b=MN/OnuI/k+WVa+pqPeonlepNFG3jQOGt5iscmFQ28gpeYxpX83g/2Ci3OtrtR9Z2aO2iu8Mfvwa13TlmpyRTYlY2zIu+zyH6UPtD8M5hJOGVY7Y44y8uuAbET2OP9d8LabzKw72Qp63QQaE1Nxp0fSPQtGgBkqNSqCvI0v+NB/g=
Received: from SL2PR03MB4537.apcprd03.prod.outlook.com (2603:1096:100:59::17)
 by TYZPR03MB8190.apcprd03.prod.outlook.com (2603:1096:405:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:23:21 +0000
Received: from SL2PR03MB4537.apcprd03.prod.outlook.com
 ([fe80::2cc7:1b29:a66:6d47]) by SL2PR03MB4537.apcprd03.prod.outlook.com
 ([fe80::2cc7:1b29:a66:6d47%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:23:21 +0000
From:   =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
Thread-Topic: [PATCH v2 2/2] mmc: mediatek: extend number of tuning steps
Thread-Index: AQHaIcjmSydXs8QZ/EKu17lpxk+LjrCPbTOAgAAMpwCAAAu4gIABGbEAgAOE6YCABcuFAA==
Date:   Tue, 5 Dec 2023 01:23:21 +0000
Message-ID: <0fccba2f81984d2448643d47f2bf63c221f9504d.camel@mediatek.com>
References: <20231128070127.27442-1-axe.yang@mediatek.com>
         <20231128070127.27442-3-axe.yang@mediatek.com>
         <207c2f89-b1e7-448d-966f-0c403a9f9e8b@collabora.com>
         <ea1a82b07e98fa682140c460048901a9f962be2b.camel@mediatek.com>
         <36ba3f89-2bd0-45f0-8b61-59f5c6691427@collabora.com>
         <61afefc47b073d63f39972031be6a4dfbd3d45af.camel@mediatek.com>
         <f14e8db1-5909-4733-99b1-2abe10c4ac7e@collabora.com>
In-Reply-To: <f14e8db1-5909-4733-99b1-2abe10c4ac7e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4537:EE_|TYZPR03MB8190:EE_
x-ms-office365-filtering-correlation-id: 052aa51e-72dd-47ee-3394-08dbf530c4d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FC728qB9FGaJHNYTCsEZk+xyMidlbka1n7aDGLGuRpxwyEt8B/dKwJZDtcTAZCbgMfPi2sYEQ0GqSP5BA/yG1pgxgI/YoAoVTtwzG8baR+9KiXeeaEcVCFtb4HWfYeyAmvj7VAY/sy5JD1fjKSgfMs1Ix/kRQvNadY+vlF+jcju8OmMBbC1+OiPOPp4uH150UaLFQS2vXrLsSdF+QryY28VOvTbNcD7cTgVQ8q/kpeRGbNd4vlgh55uFWGfNb/Ir02JbiYCns31+XLRP1TOS5TlLep961aLv3yNmXzJCjg2+ZcPJ9haVkr3vVzo8KkNkUeuJR5D2ZmUGiyifLI9aQZjwIWULEQO+Ils+10mj39f0XREH5dydI0LMPWZbqIaKTCvNIxEJjOq4+GCceC5tLVaMRsSW+TTfbxpBpTYENZa5ZEldqbZ6CM0NEbu9aFB7XEzw7S6hAD9jgp05DtbJMZYI0bLaiGuc4GqcOjwkJHt1cdyB76bknO59nxWzDTWfpmYl85IJrVtgQstGQt4oUj3tYiZ57EWRbJJQuxtZ+SXOkF29GCQsE0giHNLZ2SVnodvD9RXRJvq5FXRStNiVEKOk+Sek8qBseQv24WdOyBk9WLGPY+CgVhtB2rYRtgPWBAM1LgE8nFDZh4gW++nyFc1rdF10sFQ3bNVPi2l/77KjnpMv1LkIW/LwAbhbTlRr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4537.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(2906002)(4001150100001)(71200400001)(6486002)(478600001)(8936002)(8676002)(4326008)(86362001)(91956017)(110136005)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(5660300002)(26005)(83380400001)(36756003)(122000001)(41300700001)(85182001)(38100700002)(38070700009)(2616005)(6512007)(107886003)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnkyamVxN2xRWnZVcTdlT3VnRkZzbzczMjR6bGhXVWloK2ZIN3Y4c0pzUDZC?=
 =?utf-8?B?NzM3Q2tYRzF4OFBzMXlhMHhPNUcyUUI3RjhMQVRJbVpEbVVuSG04ZVd5S1Nq?=
 =?utf-8?B?bS9ibTJwTEU5YjJNV1VRS2ZtRkxVYk54MWQ4c1lpczJ3MlNoQXd3MUdnMWMz?=
 =?utf-8?B?RGE3Q3p1VnhCZlI4Q3A5TUNzcEF0M2Y5bm9zbmYrdlZtUG05TTNMQlpsMVR0?=
 =?utf-8?B?NHlGS0duSW04cVltMTB5Vis1MGtwa0tFVHZDYW5ya212aHl5ZXJKVTF3bVJI?=
 =?utf-8?B?c2huckVrV1hQL0JyUVFFdENYY2QyM3BxL3R4Mll0QlhXR1FTNFBXMThwc0Ew?=
 =?utf-8?B?bEtjSlorSE0yYjdHRkg3WFB0Nk13WDJMTzZyTWZyd2lsQlVDOC9KRlJDakM4?=
 =?utf-8?B?N3Jzb0g0UUpNYXhDQTRrSWVsTWgzQTNvdkQrTUJ0MENqeEJMWk1scElNdUtk?=
 =?utf-8?B?QnBMN2YvbUk4UnpFakFoRTNyZFc1Z3gwMlo0eFp1R29aREpEcEtNK2I5NWIy?=
 =?utf-8?B?elUvOXdYRnFWQTI1a3Z2Y3JVR2hySFlxaUJjS08vWU0zbGd6OUtLRTdENUNG?=
 =?utf-8?B?QlNpWWMrLzVFNUptdzYxQkRzUjNZTlpmU2JNbHhWV29EUUpybXZpV1NXTHN4?=
 =?utf-8?B?SVdsLzV2dWRmY2pUMVhheEZjNE5CQ2tqYnZKQVd5Y2xCUllPNE9CQXVSVUJz?=
 =?utf-8?B?bmM3VmJaS2VKWm9jdUlBSHJLZWJBV2kyVHRheGgzR0JsYW03YjRxeG8zSGky?=
 =?utf-8?B?MFhhcXRFUEFCbThQaHU1R1BYQ3Y2Y0t3SWJYT3hWUVVRZ3huRGJTUjRyOEZ4?=
 =?utf-8?B?SXZnZXBObmVhVzNxajl0RkNzR3ErREhKWThKSXR6SGFKUUhyNXREN1FJRUJN?=
 =?utf-8?B?emtQZ0Vtem5NMDhmRlNnbDNEQngvSHdiZkFsUHNZTStWaFluT08vaTNPODZo?=
 =?utf-8?B?akxpb1FvT2pBd0dqT0xTN3RpTHVBZFkweHpFTHlnUXExUnUyTTY3Vkcvd2FE?=
 =?utf-8?B?SGJHUzJFWTJOemlsQkR0VVkrSUdTMjhGM1FGdm9FSUxBclZYbjRYc0QrWnBn?=
 =?utf-8?B?TGFmbnFuMTJPUlNGaHlLQVJCNzdnTjBTazlFbUpzdDBVNVl5Y2EzU3Q1TGRs?=
 =?utf-8?B?Z1lqNHFLa01uKzBmUnVYQ2t3aWFJS21pZXdvYjNYT0EwMWdlYWY0TzBaR2pK?=
 =?utf-8?B?R0RGTVRDS2t3SUJ6eXBkODEreXVzUVhPK1ZTQS9CNDBPK3Y4dWY4N3haQTdE?=
 =?utf-8?B?Z25wM01mdVZ2cXNTWEprMlhxRlFHWWkwbU5xNi85QkRqRU96UE5McjAzMUNv?=
 =?utf-8?B?SHNBS0lBZWVZWWQyOCtEU055Q3ZsejlZWWc5cTNpajVEWXVJZi9RWmU1MTNm?=
 =?utf-8?B?TGJsdExrQ0RJTi9kR05RcFJYUHgvQUkzeEhIMW1jeHpHOTBhOWdYNkF1c2ox?=
 =?utf-8?B?R2srWk5TMmhnNGN0R0IyaEZxVE5zMjVHTVdoVXB0SzZqMEV5QldMS2lhVzhu?=
 =?utf-8?B?OUlVS3FWYUhQTlpXa0lQTVpUbFh0K3pQUURGSitnOVczMTFVdm5JNXNJd0pt?=
 =?utf-8?B?SVpBa3MxcVY4ekVtMVJjZHFyNzJRTHlwUmNGWDBqcWpSVkprOEdiNDlLaU5u?=
 =?utf-8?B?QUxqTHRlWjA4VSt0TjZLOEdLajVQelJ3QlcyZXlucVBYQkVuTEt0Zk05S2c4?=
 =?utf-8?B?NGZia0dLRDQ3L1dBTWlUMkdrYXB2TlNCRWovYVNVOVgycWQ0N2hXZVJkK0p0?=
 =?utf-8?B?YlFDeGVaRytIWkJCYURMbG85WkZHVXFjcmRXdHl4M1pyZlhWUGNsL3ZQVUpD?=
 =?utf-8?B?VHdvNDZwRmR4OERaU3hCUzhWOHFOVlFldmViV1E3YzkxaWFTc3dMLzRSdlZU?=
 =?utf-8?B?b3RzK3VPZXJKT2FSNjJmUnBrV2ZmQlN5TzJ1c05Oa3VGc2FjZHREWS9hY0VH?=
 =?utf-8?B?SG1MNVpEVXBWTHZFdCtlZnFWMElyYW02RjBDNDlDdDVRVkgydFpzcWtGTDdQ?=
 =?utf-8?B?RFpmVGtwWFRFT0FGMEtOM1lnK2xIZjJWenMyK1hTbUR0MDFpdFZmamZmSlJL?=
 =?utf-8?B?RGVkMUlSSDNPNkptNWFHblBKWGJpU3J1Z3hVVi9IbTRDK2ZTdVVDL0MzMG5M?=
 =?utf-8?B?L3pyZnNyVk9sNzFLbTJSSHF5VEFmLzg0R29vTW5JRmRUZUpPV0MxdEtKMm5G?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C7A15D19BCAF548A4E9BB5796D67AEB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4537.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052aa51e-72dd-47ee-3394-08dbf530c4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 01:23:21.2711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWUunYihsI5QiIrgQ5zVoihHlXxscpvu/B4ovDjsXSggd0SXvZ889WQ3D5UBwOusigyJjD/8PDSkUj4RnIC0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8190
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEyLTAxIGF0IDA5OjUzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjkvMTEvMjMgMDQ6MTYsIEF4ZSBZYW5nICjmnajno4opIGhhIHNj
cml0dG86DQo+ID4gT24gVHVlLCAyMDIzLTExLTI4IGF0IDExOjIwICswMTAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMjgvMTEvMjMgMTA6MzgsIEF4
ZSBZYW5nICjmnajno4opIGhhIHNjcml0dG86DQo+ID4gPiA+ID4gT24gVHVlLCAyMDIzLTExLTI4
IGF0IDA5OjUzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+ID4gPiA+IHdy
b3RlOg0KPiA+ID4gPiA+IElsIDI4LzExLzIzIDA4OjAxLCBBeGUgWWFuZyBoYSBzY3JpdHRvOg0K
PiA+ID4gPiA+ID4gUHJldmlvdXNseSwgZHVyaW5nIHRoZSBNU0RDIGNhbGlicmF0aW9uIHByb2Nl
c3MsIGEgZnVsbA0KPiA+ID4gPiA+ID4gY2xvY2sNCj4gPiA+ID4gPiA+IGN5Y2xlDQo+ID4gPiA+
ID4gPiBhY3R1YWxseSBub3QgYmUgY292ZXJlZCwgd2hpY2ggaW4gc29tZSBjYXNlcyBkaWRuJ3Qg
eWllbGQNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gYmVzdA0KPiA+ID4gPiA+ID4gcmVz
dWx0cyBhbmQgY291bGQgY2F1c2UgQ1JDIGVycm9ycy4gVGhpcyBwcm9ibGVtIGlzDQo+ID4gPiA+
ID4gPiBwYXJ0aWN1bGFybHkNCj4gPiA+ID4gPiA+IGV2aWRlbnQgd2hlbiBNU0RDIGlzIHVzZWQg
YXMgYW4gU0RJTyBob3N0LiBJbiBmYWN0LCBNU0RDDQo+ID4gPiA+ID4gPiBzdXBwb3J0DQo+ID4g
PiA+ID4gPiB0dW5pbmcgdXAgdG8gYSBtYXhpbXVtIG9mIDY0IHN0ZXBzLCBidXQgYnkgZGVmYXVs
dCwgdGhlDQo+ID4gPiA+ID4gPiBzdGVwDQo+ID4gPiA+ID4gPiBudW1iZXINCj4gPiA+ID4gPiA+
IGlzIDMyLiBCeSBpbmNyZWFzZSB0aGUgdHVuaW5nIHN0ZXAsIHdlIGFyZSBtb3JlIGxpa2VseSB0
bw0KPiA+ID4gPiA+ID4gY292ZXINCj4gPiA+ID4gPiA+IG1vcmUNCj4gPiA+ID4gPiA+IHBhcnRz
IG9mIGEgY2xvY2sgY3ljbGUsIGFuZCBnZXQgYmV0dGVyIGNhbGlicmF0aW9uIHJlc3VsdC4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVG8gaWxsdXN0cmF0ZSwgd2hlbiB0dW5pbmcgMzIgc3Rl
cHMsIGlmIHRoZSBvYnRhaW5lZCB3aW5kb3cNCj4gPiA+ID4gPiA+IGhhcw0KPiA+ID4gPiA+ID4g
YQ0KPiA+ID4gPiA+ID4gaG9sZQ0KPiA+ID4gPiA+ID4gbmVhciB0aGUgbWlkZGxlLCBsaWtlIHRo
aXM6IDB4ZmZjMDdmZiAoaGV4KSwgdGhlbiB0aGUNCj4gPiA+ID4gPiA+IHNlbGVjdGVkDQo+ID4g
PiA+ID4gPiBkZWxheQ0KPiA+ID4gPiA+ID4gd2lsbCBiZSB0aGUgNiAoY291bnRpbmcgZnJvbSBy
aWdodCB0byBsZWZ0KS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gKDMyIDwtIDEpDQo+ID4g
PiA+ID4gPiAxMTExIDExMTEgMTEwMCAwMDAwIDAwMDAgMDExMSAxMSgxKTEgMTExMQ0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBIb3dldmVyLCBpZiB3ZSB0dW5lIDY0IHN0ZXBzLCB0aGUgd2lu
ZG93IG9idGFpbmVkIG1heSBsb29rDQo+ID4gPiA+ID4gPiBsaWtlDQo+ID4gPiA+ID4gPiB0aGlz
Og0KPiA+ID4gPiA+ID4gMHhmZmZmZmZmZmZmZmMwN2ZmLiBUaGUgZmluYWwgc2VsZWN0ZWQgZGVs
YXkgd2lsbCBiZSA0NCwNCj4gPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gPiBpcw0KPiA+ID4g
PiA+ID4gc2FmZXIgYXMgaXQgaXMgZnVydGhlciBhd2F5IGZyb20gdGhlIGhvbGU6DQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ICg2NCA8LSAxKQ0KPiA+ID4gPiA+ID4gMTExMSAuLi4gKDEpMTEx
IDExMTEgMTExMSAxMTExIDExMTEgMTEwMCAwMDAwIDAwMDAgMDExMQ0KPiA+ID4gPiA+ID4gMTEx
MQ0KPiA+ID4gPiA+ID4gMTExMQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJbiB0aGlzIGNh
c2UsIGRlbGF5IDYgc2VsZWN0ZWQgdGhyb3VnaCAzMiBzdGVwcyB0dW5pbmcgaXMNCj4gPiA+ID4g
PiA+IG9idmlvdXNseQ0KPiA+ID4gPiA+ID4gbm90IG9wdGltYWwsIGFuZCB0aGlzIGRlbGF5IGlz
IGNsb3NlciB0byB0aGUgaG9sZSwgdXNpbmcgaXQNCj4gPiA+ID4gPiA+IHdvdWxkDQo+ID4gPiA+
ID4gPiBlYXNpbHkgY2F1c2UgQ1JDIHByb2JsZW1zLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBZb3Ugd2lsbCBuZWVkIHRvIGNvbmZpZ3VyZSBwcm9wZXJ0eSAibWVkaWF0ZWssdHVuaW5nLXN0
ZXAiDQo+ID4gPiA+ID4gPiBpbg0KPiA+ID4gPiA+ID4gTVNEQw0KPiA+ID4gPiA+ID4gZHRzIG5v
ZGUgdG8gNjQgdG8gZXh0ZW5kIHRoZSBzdGVwcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElmIHdlIGNhbiBydW4gNjQgdHVuaW5nIHN0ZXBzLCB3aHkgc2hvdWxkIHdlIHJ1
biAzMj8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBXaHkgaXNuJ3QgaXQganVzdCBiZXR0ZXIgdG8g
KmFsd2F5cyogcnVuIDY0IHR1bmluZyBzdGVwcywgb24NCj4gPiA+ID4gPiBTb0NzDQo+ID4gPiA+
ID4gc3VwcG9ydGluZyB0aGF0Pw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYW5rcywNCj4gPiA+
ID4gPiBBbmdlbG8NCj4gPiA+ID4gDQo+ID4gPiA+IEhpIEFuZ2VsbywNCj4gPiA+ID4gDQo+ID4g
PiA+IFRoYXQgaXMgYSBnb29kIHF1ZXN0aW9uLiBUaGUgYmVuZWZpdCBvZiBwcmVzZXJ2aW5nIDMy
IHN0ZXBzDQo+ID4gPiA+IHR1bmluZw0KPiA+ID4gPiBpcw0KPiA+ID4gPiB0aGF0IGl0IGNhbiBz
YXZlIHRpbWUgaW4gY2VydGFpbiBzY2VuYXJpb3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBzb21l
IHBsYXRmb3Jtcywgd2hlbiB0aGUgZGVsYXkgc2VsZWN0ZWQgdGhyb3VnaCA2NCBzdGVwcw0KPiA+
ID4gPiB0dW5pbmcNCj4gPiA+ID4gaXMNCj4gPiA+ID4gdmVyeSBjbG9zZSB0byB0aGF0IGNob3Nl
biB0aHJvdWdoIDMyIHN0ZXBzLCB3ZSBjYW4gcmVkdWNlIHRoZQ0KPiA+ID4gPiB0dW5pbmcNCj4g
PiA+ID4gc3RlcCBmcm9tIDY0IHRvIDMyLiBUaGlzIGNhbiBzYXZlIHRpbWUgc2VuZGluZyB0aGUg
dHVuaW5nIGJsb2NrDQo+ID4gPiA+IGNvbW1hbmRzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGh1cyB1
c2luZyAzMiBzdGVwcyB0dW5pbmcgY2FuIHNhdmUga2VybmVsIGJvb3QgdXAgdGltZS4NCj4gPiA+
ID4gDQo+ID4gPiA+IEFub3RoZXIgY2FzZSB3aGVyZSB0aW1lIGNhbiBiZSBzYXZlZCBpcyB3aGVu
IGFjY2Vzc2luZyB0aGUgUlBNQg0KPiA+ID4gPiBwYXJ0aXRpb24gb2YgZU1NQy4gRWFjaCB0aW1l
IHN3aXRjaCB0byBSUE1CIHBhcnRpdGlvbiwgdGhlcmUgaXMNCj4gPiA+ID4gYQ0KPiA+ID4gPiBy
ZXR1bmUgYWN0aW9uLCBjYXVzaW5nIGEgY2VydGFpbiBkcm9wIGluIHBlcmZvcm1hbmNlLiBJZiB3
ZSBhcmUNCj4gPiA+ID4gY2VydGFpbg0KPiA+ID4gPiB0aGF0IHRoZSByZXN1bHRzIG9mIDMyIHN0
ZXBzIHR1bmluZyBhcmUgdXNhYmxlIGFuZCB3ZSB1c2UgaXQsDQo+ID4gPiA+IHRoaXMNCj4gPiA+
ID4gY2FuDQo+ID4gPiA+IGluIGEgc2Vuc2UgYWxzbyBndWFyYW50ZWUgcGVyZm9ybWFuY2Ugd2hl
biBhY2Nlc3NpbmcgdGhlIFJQTUINCj4gPiA+ID4gcGFydGl0aW9uLg0KPiA+ID4gPiANCj4gPiA+
IA0KPiA+ID4gVGhhbmtzIGZvciB0aGlzIGV4cGxhbmF0aW9uISBUaG91Z2gsIEkgaGF2ZSBzb21l
IG1vcmUNCj4gPiA+IHF1ZXN0aW9ucy4uLg0KPiA+ID4gDQo+ID4gPiAuLi5yZWdhcmRpbmcgYm9v
dCB1cCB0aW1lLCBob3cgbXVjaCB0aW1lIGFyZSB3ZSB0YWxraW5nIGFib3V0Pw0KPiA+IA0KPiA+
IEx1Y2tpbHksIEkgaGF2ZSBhIHBsYXRmb3JtIGF0IGhhbmQgdGhhdCBjYW4gYmUgdXNlZCBmb3IN
Cj4gPiBleHBlcmltZW50cy8NCj4gPiBCZWxvdyBhcmUgdGhlIHJlc3VsdHMgZnJvbSB0ZXN0aW5n
IG9uIHRoaXMgcGxhdGZvcm06DQo+ID4gDQo+ID4gWyAgICAyLjQzMTk5M11bVDEyMDAxODBdIGt3
b3JrZXIvMjoyMTogbXRrLW1zZGMgYm9vdGRldmljZToNCj4gPiBbbmFtZTptdGtfc2QmXVN0YXJ0
IHR1bmluZw0KPiA+IFsgICAgMi40MzQ5NTBdW1QxMjAwMTgwXSBrd29ya2VyLzI6MjE6IG10ay1t
c2RjIGJvb3RkZXZpY2U6DQo+ID4gW25hbWU6bXRrX3NkJl1UdW5pbmcgZmluaXNoZWQNCj4gPiBb
ICAgIDIuNDM1OTU3XVtUMTIwMDE4MF0ga3dvcmtlci8yOjIxOiBtdGstbXNkYyBib290ZGV2aWNl
Og0KPiA+IFtuYW1lOm10a19zZCZdcGhhc2U6IFttYXA6MDAwMDAwMDBmZmZmZmZjMF0gW21heGxl
bjoyNl0gW2ZpbmFsOjE5XQ0KPiA+IFsgICAgMi40NjIzNzVdW1QxMjAwMTgwXSBrd29ya2VyLzI6
MjE6IFtuYW1lOm1tY19jb3JlJl1tbWMwOiBuZXcNCj4gPiBIUzQwMA0KPiA+IE1NQyBjYXJkIGF0
IGFkZHJlc3MgMDAwMQ0KPiA+IC4uLg0KPiA+IFsgICAgMi41MTk4NjNdW1QxMzAwMDY5XSBrd29y
a2VyLzM6MTogbXRrLW1zZGMgMTEyNTAwMDAubW1jOg0KPiA+IFtuYW1lOm10a19zZCZdU3RhcnQg
dHVuaW5nDQo+ID4gWyAgICAyLjUyNjI3MV1bVDEzMDAwNjldIGt3b3JrZXIvMzoxOiBtdGstbXNk
YyAxMTI1MDAwMC5tbWM6DQo+ID4gW25hbWU6bXRrX3NkJl1UdW5pbmcgZmluaXNoZWQNCj4gPiBb
ICAgIDIuNTI3Mjg4XVtUMTMwMDA2OV0ga3dvcmtlci8zOjE6IG10ay1tc2RjIDExMjUwMDAwLm1t
YzoNCj4gPiBbbmFtZTptdGtfc2QmXXBoYXNlOiBbbWFwOmZmZmZmZmZmZmZmZjAwM2ZdIFttYXhs
ZW46NDhdIFtmaW5hbDo0MF0NCj4gPiBbICAgIDIuNTMyMjY5XVtUMTMwMDA2OV0ga3dvcmtlci8z
OjE6IFtuYW1lOm1tY19jb3JlJl1tbWMyOiBuZXcNCj4gPiB1bHRyYQ0KPiA+IGhpZ2ggc3BlZWQg
U0RSMTA0IFNESU8gY2FyZCBhdCBhZGRyZXNzIDAwMDENCj4gPiANCj4gPiBBcyB0aGUga2VybmVs
IGxvZyBpbmRpY2F0ZXMsIGl0IHRvb2sgMyBtcyBmb3IgZU1NQyB0byB0dW5lIDMyDQo+ID4gc3Rl
cHMsDQo+ID4gd2hpbGUgaXQgdG9vayBhYm91dCA3IG1zIGZvciBTRElPIHRvIHR1bmUgNjQgc3Rl
cHMuIEkgaGF2ZSB0bw0KPiA+IGFkbWl0LA0KPiA+IHdoZW4gaXQgY29tZXMgdG8gc2F2aW5nIGJv
b3QgdXAgdGltZSwgdGhlIGJlbmVmaXRzIG9mIHJlZHVjaW5nIHN0ZXANCj4gPiBmb3JtIDY0IHRv
IDMyIGFyZSBxdWl0ZSBtaW5pbWFsLiBKdXN0IGFzIHlvdSBzYWlkLCBlc3BlY2lhbGx5IHdoZW4N
Cj4gPiBhc3luYyBwcm9iZSBpcyBlbmFibGVkLg0KPiA+IA0KPiANCj4gVGhhdCdzIGdyZWF0IHRv
IGtub3csIGFuZCBpdCdzICp0cnVseSogbmljZSBpbmZvcm1hdGlvbiB0aGF0IHlvdSBjYW4NCj4g
cHV0IGludG8gdGhlIGNvbW1pdCBtZXNzYWdlLCBhcyB0aGlzIGNvbXBsZXRlcyB0aGUgYW5hbHlz
aXMgb2YgdGhpcw0KPiBjb21taXQuDQo+IA0KPiBDYW4geW91IG1lbnRpb24gdGhhdCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UgZm9yIHY0IG9mIHRoaXMgY29tbWl0Pw0KPiANCj4gIkFzIHBlciBtZWFz
dXJlbWVudHMgdGFrZW4gb24gTVQoeHh4eCksIHRoZSB0dW5pbmcgcGhhc2Ugd2lsbCB0YWtlOg0K
PiAgIGVNTUMgLSAzMiBzdGVwczogfjNtcw0KPiAgICAgICAgICA2NCBzdGVwczogeHh4eA0KPiAg
IFNESU8gLSAzMiBzdGVwczogeHh4eA0KPiAgICAgICAgICA2NCBzdGVwczogfjdtcw0KPiANCk9r
YXksIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBpbiB2NC4NCg0KDQo+IC4uLmJ1dCB3
aGlsZSB0aGlzIHdvbid0IHByb2xvbmcgYm9vdCB0aW1lcyBieSBhbnkgbWVhbmluZ2Z1bCBhbW91
bnQNCj4gb2YgdGltZSwgZm9yIGVNTUMsIGl0IHNob3VsZCBzdGlsbCBiZSBwcmVmZXJyZWQgdG8g
dXNlIDMyIHN0ZXBzDQo+IHR1bmluZw0KPiBiZWNhdXNlIG90aGVyd2lzZSB3ZSBsb3NlIHBlcmZv
cm1hbmNlIGZvciBSUE1CIEkvL08sIHdoaWNoIHJlcXVpcmVzDQo+IHJlLXR1bmluZyBmb3IgZWFj
aCBhY2Nlc3MuDQo+ICINCk9LLCBJIHdpbGwgbWFrZSBTRC9TRElPIGRlZmF1bHQgdG8gdXNlIDY0
IHN0ZXBzIHR1bmluZyAuDQoNCg0KPiA+ID4gDQo+ID4gPiBJJ20gYXNraW5nIGJlY2F1c2Ugd2hp
bGUgbm93IEkgc2VlIC0gYW5kIGFncmVlIC0gb24gdXNpbmcgMzItDQo+ID4gPiBzdGVwcw0KPiA+
ID4gdHVuaW5nDQo+ID4gPiBvbiBlTU1DIHRvIGd1YXJhbnRlZSBwZXJmb3JtYW5jZSBkdXJpbmcg
UlBNQiBhY2Nlc3MsIGFzIGZhciBhcyBJDQo+ID4gPiBrbm93LA0KPiA+ID4gdGhlcmUgaXMgbm8g
UlBNQiBwYXJ0aXRpb24gb24gU0QvTWljcm9TRCBjYXJkcyAoYW5kLCBvZiBjb3Vyc2UsDQo+ID4g
PiBTRElPDQo+ID4gPiBkZXZpY2VzKS4NCj4gPiA+IA0KPiA+ID4gSWYgdGhlIGJvb3QgcGVyZm9y
bWFuY2UgaW1wYWN0IGlzbid0IGJpZywgYXMgaW4sIHVwIHRvIH4xMDANCj4gPiA+IG1pbGxpc2Vj
b25kcyBpcw0KPiA+ID4gbm90IGJpZyBhdCBhbGwgKGVzcGVjaWFsbHkgd2l0aCBhc3luYyBwcm9i
ZSEpLCB3ZSBjYW4gZGVmaW5pdGVseQ0KPiA+ID4gYXZvaWQgdGhlDQo+ID4gPiBhZGRpdGlvbiBv
ZiBhIGRldmljZXRyZWUgcHJvcGVydHkgZm9yIDMyLXN0ZXBzIHR1bmluZywgaGVuY2UgdXNlDQo+
ID4gPiBhDQo+ID4gPiBkeW5hbWljDQo+ID4gPiBzZWxlY3Rpb24gc3RyYXRlZ3kgc3VjaCB0aGF0
Og0KPiA+ID4gICAgLSBPbiBlTU1DIGRldmljZXMsIGFsd2F5cyBwZXJmb3JtIDMyLXN0ZXBzIHR1
bmluZyAoaGVuY2Ugbm8NCj4gPiA+IGJvb3QNCj4gPiA+IGRlbGF5KQ0KPiA+ID4gICAgLSBPbiBT
RCBjYXJkcyBhbmQgU0RJTywgYWx3YXlzIHBlcmZvcm0gNjQtc3RlcHMgdHVuaW5nDQo+ID4gDQo+
ID4gZU1NQyBjb3VsZCBhbHNvIHBvdGVudGlhbGx5IGhhdmUgQ1JDIGlzc3VlIGlmIG9ubHkgdHVu
ZSAzMi1zdGVwcywNCj4gPiBhbGJlaXQgd2l0aCBhIGxvd2VyIGxpa2VsaWhvb2QuIFRoZSBwcmVj
b25kaXRpb24gZm9yIHVzaW5nIDMyLXN0ZXBzDQo+ID4gdHVuaW5nIGlzIHRoYXQgaXQgY291bGQg
cHJvdmlkZSByb3VnaGx5IHRoZSBzYW1lIHZhbGlkIHJlc3VsdHMgYXMNCj4gPiB1c2luZw0KPiA+
IDY0LXN0ZXBzIHR1bmluZy4gU28gdGFraW5nIGV2ZXJ5dGhpbmcgaW50byBhY2NvdW50LCBjb250
cm9sbGluZyB0aGUNCj4gPiB0dW5pbmcgc3RlcCBhcyBuZWVkZWQgdGhyb3VnaCB0aGUgdXNlIG9m
IGR0cyBwcm9wZXJ0eSBzZWVtcyB0byBiZSBhDQo+ID4gbW9yZSBmbGl4aWJsZSBhcHByb2FjaC4N
Cj4gPiANCj4gDQo+IFllcyBidXQgc2luY2UgdGhlIG9ubHkgcGVyZm9ybWFuY2UgY29uY2VybiBp
cyBhYm91dCBlTU1DIFJQTUIgYWNjZXNzLA0KPiB3ZSBjb3VsZCBhdCBsZWFzdCBtYWtlIHRoaXMg
NjQgc3RlcHMgYXMgKmRlZmF1bHQqIGZvciBTRC9TRElPLCBhbmQNCj4gMzIgc3RlcHMgYXMgZGVm
YXVsdCBmb3IgZU1NQy4NCj4gRGV2aWNlIHRyZWUgd291bGQgYmUgYW4gb3ZlcnJpZGUgb2YgdGhv
c2UgZGVmYXVsdCB2YWx1ZXMuDQo+IA0KPiBDYW4gd2Ugc2V0IDY0IGFzIGRlZmF1bHQgZm9yIFNE
L1NESU8sIDMyIGFzIGRlZmF1bHQgZm9yIGVNTUMsIGFuZA0KPiB0aGVuIHVzZQ0KPiB0aGUgZGV2
aWNlIHRyZWUgdG8gb3ZlcnJpZGUgdGhvc2UgZGVmYXVsdHM/DQo+IA0KV2lsbCB1cGRhdGUgaW4g
djQuDQoNCj4gQW5nZWxvDQo=
