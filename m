Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A47E6959
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKILO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjKILOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:14:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB832D61
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:14:23 -0800 (PST)
X-UUID: 1fdf46b47ef111eea33bb35ae8d461a2-20231109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0LonU2sA4qvUNb86LvCoFiv9vfECJ7CJKpxjl90NX0c=;
        b=Fr7qUdYeUSynKDwVD2H/+my7qeOFHXutSj1d7KarvHFRzMhjTSyic/sJCyvEVkIJIQpUJyRlVRU1bb67AHkc2nfpfr2ZUlUvZ5qdTIckJj6aytcDut4bCgugGHf7hEJhGoHW4D/nTkXfQs/lS9rcuCr09ovO3q4ZOaVOOZov66Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:7a6ef255-b9ff-426a-92ee-acb2fda733ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:dd7d57fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1fdf46b47ef111eea33bb35ae8d461a2-20231109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 993062752; Thu, 09 Nov 2023 19:14:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 9 Nov 2023 19:14:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 9 Nov 2023 19:14:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3fx0+Ya7HqWv0Eq1YLSOGTFwCSJsDzUP5VgsjgRhqOv7+u+zxVBNiMTw5vXjUr2gzrE2miRXarss0+ZCUbsYA9UxBHi5r8yS7wVGLzfzcntrg5eannTYsGLaOaHZoyCU9+roEbBCr38oA45igGi+svqWY7fx29yZ3NG09RF7mCCNeonUHLyz5rbD6EQlz0Uug7TLCPuPAR2oshB/W6GHfQDtONGMBzK7f5iDkg4j/iEjKjG+AFKJD9nfe2p9XOAoD8dQoCx9lJ6Ljssbh5w7GFsJvXI8Hm5ya55d8bi+eW4mPkEv54atQqgL3ng/yIPgLl+PtvKboR/MXriojVBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LonU2sA4qvUNb86LvCoFiv9vfECJ7CJKpxjl90NX0c=;
 b=SHlU5aZ79jY/Cd+3nU0YWxMRjheOsg8VCZgXTOtt/uShE6Da0ECilvqe3+5fZmtSWZpFw9rsFKqNJmKev950qQTgEHYTMydDXPseHV8dAWNVmvU4HRh90GymUxs0ErUX7QhSbvLmrAD3ALrTlGYMxsPoBcx+RVERwuKTy8WXTjwkQrTjntRfQ4AqOmaKsXCbi/X4M33w1y0hEvR9EjjdsGC+n4QiccDdp3PV0jLTCYeyOyQWgBRJYINqPyoYQTRtc9QPe6IbfAfXyR2cqtvRHMx6WZzEUds1W1ikMn2kbWbn9Wuf56X2cAppr86NPV5aZu5RW+RfyUon+KKxIQuHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LonU2sA4qvUNb86LvCoFiv9vfECJ7CJKpxjl90NX0c=;
 b=TV7+SZGOZ2Wv5/Sa/o/+ItNhGhyvMKHiK1FAnrYHxG4A8CkGsmdbcwGVF/oBN59Z3z/eW+ti7N4FMniqVCvKhOKl1zqeSUmEVH2B+QB/LSu/lJdXFOk2fHJsmiJUZHK4I+NrV4xH2pEqPXGt5w4vc/F9isYWI984IaHJajjWEKQ=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by KL1PR03MB8515.apcprd03.prod.outlook.com (2603:1096:820:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 11:14:14 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::1bd1:4be7:8749:79ea%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 11:14:14 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmF0aGFuIEx1ICjlkYLmnbHpnJYp?= <Nathan.Lu@mediatek.com>,
        =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 2/3] dt-bindings: clock: mediatek: Remove compatible for
 MT8188 VPPSYS
Thread-Topic: [PATCH 2/3] dt-bindings: clock: mediatek: Remove compatible for
 MT8188 VPPSYS
Thread-Index: AQHaEuXUiUhnGfK6q0iy/+mYYdr7UbBxtLUAgAAhPIA=
Date:   Thu, 9 Nov 2023 11:14:13 +0000
Message-ID: <5abd0e8f60ec569336fe650af1f69dcd5a53a23e.camel@mediatek.com>
References: <20231109082201.7698-1-yu-chang.lee@mediatek.com>
         <20231109082201.7698-3-yu-chang.lee@mediatek.com>
         <c28c99b8-36f8-479a-adbf-442c87062ca2@collabora.com>
In-Reply-To: <c28c99b8-36f8-479a-adbf-442c87062ca2@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|KL1PR03MB8515:EE_
x-ms-office365-filtering-correlation-id: fd3772e3-1780-4790-eed9-08dbe1150181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nKOvIoK5eChECQVtytH8DKPUVBvFiyXzcUpkCA6Gn25yoslvpl5OcKlMq3KTU+XCABIpOdc7Loo4B6QkJ/BiXZf6p02dxKPa5vEt6qRLLldC5U5ge5QKXoVZv7jt+x1/1Qktyl+KfvcJhi99sgZnTtgBCCfr9UfkHy9XS7Kml62e/jWywmfSltBLWSJ01PjkPjl9I5To2wdQiJYjR5vIj0v89wgJMfMV7jmiP2IQDnsnHG4GKTrWb2EhLETKdrVLJMNPmxwKV9obwuywe9SzmU7bKPsaCLdn1zrwzK17M1iTEFOH2EtCJ9lrGKL7FMko1LmeqFhBmprjA6wtYZi6niyaj6lD2GMY3ngF2TcfkWoiLWtiMFy07JyfwftIdsezZ8BO03QcVWnWjgTNYPWt4z82Od9CQA+NlPOnETyJaeJyt1ipgsvpgDGJuMpyvYTmv3e5BcxVr90X0KhpsNq23b0mH6nhSsnw+TcrFb3gI928BA1i3HQGTFTGUgmOWQ8jR37Jv0HkYLpe62WWOM74svuqMXNDMYTXf0Lpf4PH7KeXZTzCEhdpTs8M61TdXoBFE9cV6pGtD1ZvmmebR7I1nD/mTNSPdgNYiauorG70ouNU+kR7MI5L6STm5p4S1X5lScy7mCVzXNoORiEzhg1eJeBftzHJbGl+k6Be4519u6U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(2906002)(41300700001)(38100700002)(64756008)(86362001)(54906003)(66946007)(66446008)(66476007)(36756003)(85182001)(66556008)(316002)(91956017)(110136005)(76116006)(6512007)(2616005)(26005)(122000001)(6486002)(107886003)(71200400001)(478600001)(6506007)(83380400001)(38070700009)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlplZzN5d3VtY1RLYkw0aUVoa1BwOWI4ZmJTb0JwYmlKT1lDZnk5YTYvZHNp?=
 =?utf-8?B?TGwyZVBTbjFFcjJXUzJlUnRwS0s4cUViK29Xb3VQQjFuVnNhZGt3SWJxT1RB?=
 =?utf-8?B?enFwSm9zU2VQcytHTTZNY1NzeXUvZ3VxVWptNlpXZnFPQnlWRjNjUzV0bkZH?=
 =?utf-8?B?UVlHcXIvOWFUdzVZWjU0R0tpbUJPYWJhOWxEa3RJQnBXWDczN0JHV1dhMDdB?=
 =?utf-8?B?RDZMbi8vcUxHcVFOcEYvVGowdVhRL2NZQ2V3V1BZZE4ycC94RCt5WjN6dmV1?=
 =?utf-8?B?VXFqTUlJeHNqNlBtb2h0SW90Q3VWelkwSmc5WFlHdGlUMWplMEFRREkyUUJa?=
 =?utf-8?B?SGZMSzVPdjVVTWpsZ0RSdHd2dnhEYUg0bEtyczM1SVV1b29xZThEN0NiWU1P?=
 =?utf-8?B?aStNYXg0NTZvQ0I4Z2VRMkNreEV4dUJTM0JDZHljM3hWbURkOGhQR0xTVTFu?=
 =?utf-8?B?RlFTL0tBb1hZYU5mcXlpTXo4MktBTGRORzgwTDNSY0hUTmhVSGI3ZittMTl3?=
 =?utf-8?B?RC81NXFibWJkVUF5akFpQmN6Zk5DTlc5NmFnbFVhN2ZOUDBIeE5IVE8rYTZr?=
 =?utf-8?B?ZW91aFNDVHRlZ09wQmg5VVJkOGcwU2NaNTJtd0Y4enJLNnkvbFIwenpjMlpr?=
 =?utf-8?B?Nmt6TU9sVE04bmFlYUZXNGwwVCt3OXRYTzBldlgzNW5NZXdUbnJKRGYzN2Vq?=
 =?utf-8?B?OXMwK0taeHZGTHJyNnFFY0IySXBGUWdqUSt3MFZTbXg1NmcxeGhLL2llZjdG?=
 =?utf-8?B?Y2pQbHFmM3lqTGI5VTg2eG1wZXlITmJ1MUp2UnpZRWR4b1FxMHp5K0ZNS25D?=
 =?utf-8?B?V2w0enlZRDFqK0ZMNjVaeUNIUHZEeVJDTXhjZkxHTXNpeDRrcjhSaUNxQ1JO?=
 =?utf-8?B?Z2t2dlRHT0xBWmlEdlB6SlNrTDBqQzZyZE5id05VN0I3VjFlcWl3Qjh4Z3Nn?=
 =?utf-8?B?UXNIRGtJQ2ZXVkUxWitLSUlXbFRUR3F5K3NOVTQxc0pmeEdIMnhlclhFNmVN?=
 =?utf-8?B?QlNNNXpMWi95TWttcmVYdFpPSndtby9kMXdwK1FGU1B4ai85QzU4akgwN1pB?=
 =?utf-8?B?MWhWREl6K3ZaTlE4ekpDVkxtOUxkWE5kK2o2NnlsNHkrWDRPQVUrOFN4S3FS?=
 =?utf-8?B?NFUxcXhMRHArRHFQVmRwRy84R2hnbWJwaXNDOFBPTlBFeEIzaXVjTzlPK0Nv?=
 =?utf-8?B?NnRiMlkzS2dqTzl3bGtkLy9hRG9XNDN1YjYybXl4b29yOWRIb0FQanNaa0hO?=
 =?utf-8?B?bk92YjZXbllmVURZeTFpM1hmNk1KZWZIRzk1MDZJS1NHTUIvcmZQTUVVdWJN?=
 =?utf-8?B?ZTlMdTRtT3R0YS81WUZoaEJwSGR5eFA0OEZ2REdMWUNRL2E1cE13RnAxN0N0?=
 =?utf-8?B?OWE3M2xxR0lZQ0NvTmpKOTZldkZnMDlETkg1WWxlc2hkdDBPc2NQUDVrY3Vt?=
 =?utf-8?B?RzBab0lzRWk5RTM1anBVc2JReGkwRCtaVDQrNmVsYjZZd3RMWHhQNUp1SjVw?=
 =?utf-8?B?SU9lNElEQ2VGc1YzN0JVemM5cEZYWjFja2xyRk84aFlNVjN5bHJ2K1R0Rncw?=
 =?utf-8?B?SXduRHY4QkhJV0hIdklRdVlOaW9xeXY1T0dzcUd6R1poWm9BSFFPbTBUdGtk?=
 =?utf-8?B?MUJseTNhSTJlTTdpUGpJMThkYXRUYVJ5cXJ5amlMWGVSV1RYV21lV3dSVTJ2?=
 =?utf-8?B?K253bUp4ME4xd2pWRUVYR01rMWxWSGxwc1B1eVczc25iVGlQcG4rQnpjQVBE?=
 =?utf-8?B?L09kbElzOG1leVNoTDdNak05cGYwdmJsVnBTTTFORnNUV2I0UTQ2b3NlanRP?=
 =?utf-8?B?V08zdVZFUDA2YXRuWjdBT2padjdmMHA3TmFhbUV5UTdjTUlvcXV6YnFlVjZm?=
 =?utf-8?B?R2dId0N2SXFMRGh0ejUvYlliLzR1NkxyUkZDMmhtYjNOT0E4UzRMYXZ6R1RC?=
 =?utf-8?B?eGxOSGJkaW9FbFQ4WGRmSHY0em5nQmNkaStBNHhSSXV5dmtRY2RydDBTSzVn?=
 =?utf-8?B?R3QyblpDWDhONzVhR3pZZURrYWFPbzhoMlB0MmZBYWpnY1UvYmRMMmlDQzdl?=
 =?utf-8?B?UFJVWTNXdHkxbldBNTd3b09oYldFMkxENmJwbDNzaHhmVUFKeG5LM1MwWVhp?=
 =?utf-8?B?SnFNVUlLdHBEcTNLbkhVU0JucjkzdTR4cVFWM0h1TGNZckRGTVVURFFlWjhi?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8ECB989B8A7AA4D8936DC7BCB178C8C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3772e3-1780-4790-eed9-08dbe1150181
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 11:14:13.8564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ms/GRoah86xz/UKF/gh4V89JY+K9TMothdBBpxl1VTDRWn83P3x7uDDjz+TGjSew7PXi6J6mtHuEobwTmx8GLNvPQdi3vVuRoGxNZE/+XK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8515
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.978300-8.000000
X-TMASE-MatchedRID: w2TFuZOvAtfUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXY0esWB2EIL9DGR+wa3Qzqi4lBPsquo2ppkPoFsM336M6dDRRKoGVQTwzvg1/q1MH2F6v
        JwcxFm00q4mcv3X3RXLe9jPJWA+Z/sEBAuoaUqK90BEBFOTiHn30tCKdnhB58pTwPRvSoXL2ZMP
        CnTMzfOiq2rl3dzGQ1ivN9ssYEZY3o2wxtCFAi3GHsZ4nL8s61BITynijlyyTw0JzDI997lA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.978300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0F3F1CE466CB144D1DAEDDB4B9E79BCE427FBDBE2B3092F0680B2C55EF737D362000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTA5IGF0IDEwOjE1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDkvMTEvMjMgMDk6MjIsIHl1LWNoYW5nLmxlZSBoYSBzY3JpdHRv
Og0KPiA+IFJlbW92ZSBWUFBTWVMwLCBWUFBTWVMxIGNvbXBhdGlibGUgb24gTWVkaWF0ZWsgTVQ4
MTg4Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IHl1LWNoYW5nLmxlZSA8eXUtY2hhbmcubGVl
QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoZSBtYWlsIHJlY2lwaWVudHMgYXJlIHdyb25nL2luY29t
cGxldGUuIFRoaXMgcGF0Y2ggY2Fubm90IGV2ZXINCj4gcG9zc2libHkgZ2V0DQo+IHVwc3RyZWFt
IGlmIHlvdSBkb24ndCBDYyB0aGUgcmlnaHQgcGVvcGxlL2xpc3RzLg0KPiANCj4gUGxlYXNlIHVz
ZSBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHRvIGdldCB0aGUgcmlnaHQgbGlzdCBvZg0KPiBy
ZWNpcGllbnRzIGFuZA0KPiByZXNlbmQuDQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vsbw0KPiANClRo
YW5rIGZvciB5b3VyIHRpbWUgYW5kIHBhdGllbmNlLCBJIGFscmVhZHkgcmVzZW5kIHRoZSBzYW1l
IHNlcmllcyB3aXRoDQpsaXN0IHNjcmlwdCBwcm92aWRlZC4NCg0KVGhhbmtzDQoNCkJlc3QgUmVn
YXJkcywNCll1IENoYW5nDQoNCj4gPiAtLS0NCj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Nsb2NrL21lZGlhdGVrLG10ODE4OC1jbG9jay55YW1sICAgICAgICB8IA0KPiA+IDIgLS0NCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQN
Cj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxt
dDgxODgtDQo+ID4gY2xvY2sueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10ODE4OC0NCj4gPiBjbG9jay55YW1sDQo+ID4gaW5kZXgg
ZDcyMTRkOTdiMmJhLi44NjA1NzAzMjA1NDUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10ODE4OC0NCj4gPiBjbG9jay55
YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL21l
ZGlhdGVrLG10ODE4OC0NCj4gPiBjbG9jay55YW1sDQo+ID4gQEAgLTQzLDggKzQzLDYgQEAgcHJv
cGVydGllczoNCj4gPiAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXZkZWNzeXMNCj4gPiAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXZkZWNzeXMtc29jDQo+ID4gICAgICAgICAtIG1lZGlhdGVr
LG10ODE4OC12ZW5jc3lzDQo+ID4gLSAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXZwcHN5czANCj4g
PiAtICAgICAgLSBtZWRpYXRlayxtdDgxODgtdnBwc3lzMQ0KPiA+ICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxODgtd3Blc3lzDQo+ID4gICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC13cGVzeXMtdnBw
MA0KPiA+ICAgDQo+IA0KPiANCg==
