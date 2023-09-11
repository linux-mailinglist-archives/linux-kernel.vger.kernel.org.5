Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2D79B21F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbjIKU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbjIKNiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:38:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A7CC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:38:38 -0700 (PDT)
X-UUID: 8097e42450a811ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7ulFnk6Dl8V8Qcwk9xoGPdL1JnyeNFIrDSnCG1J9a4U=;
        b=LlxNzsvzRRsFuKDg6K3YBpkA93vHYJftUkFM94Y4nkaV+UXVhr/cI/Tx+0yuH/DM5jwH4EKuZ/vjDlDsV9o4opMrQx5/vsY2rnDlqFWkCrogjcrd8/tUdmxz+cctJUIHdNwkK+dkEDH0Yv+UImSaaazEM2qUmz/glu7ECGz/2FI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:acd690d7-bfc9-4a6f-94f8-ebe71fc4cbec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:5356b4be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8097e42450a811ee8051498923ad61e6-20230911
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1067714500; Mon, 11 Sep 2023 21:38:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 21:38:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 21:38:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n11D1ArkGartJDofjmEIcwfWvR2rfMCzNHWh6TGp2+6YAo1DB6RW9G2EtEsKgmmDsmnkvZy/bqH5YTaCyIMOfGRQZR/jaxo6zXGnfNZVIBe9MbRUlED1ZsvMLsdTGCy5XfNpYuuEB7O4EbECD41uPqHjmlHcBzJQ98Wlq++lmF/9kiqld8GItP9qo5vOzf7mErj0iwuWMVoXANeFfRmg+JB1YpFW0CiRaJVM0q0CUkw10czNLk5sD0eaWAsFZoFRWF4A8GswrFzUFXzNuF62/5mjk2oEvbKqgJOQrPEKNO5EP9JH01X298RPoTUdj9JHAqGH87AluA8ELL1cbSApVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ulFnk6Dl8V8Qcwk9xoGPdL1JnyeNFIrDSnCG1J9a4U=;
 b=LNsP6PfoGmimMbXz/4mMQQh/4N/IhdvFzfK08iUX9i17wLcST9pJ9RDt7B7FhthkzHAhIN7Sk9yv78IX7oBs7hrsJssVRCtYeYj+3ex1dxgFCCgBd2RIxDtD+HZBggUov/nxZ+LGWfJddCSiA9lGFrkiCqLF6PT7YEM7NLfGLK5FEW9kFW3kTI1KaquxjTVm0QcenbGEnDs14eMya0Vd9Um58XbVXGVXBdxyri1DZwiKX1XXvoRRX6CmxSMJMpy24xDt1x0sP+A8GAVswIhvFIyF2kM+auViht9iWayZriSCkaYTap5oDDCcWDX81pZmxc28tDgHa3a3DsQ/CQ+6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ulFnk6Dl8V8Qcwk9xoGPdL1JnyeNFIrDSnCG1J9a4U=;
 b=GGts0XD7WWgqEiowSI+/9d0VJ90yKuTM9f7rEEhVCrlVpR1QDZGNHxXphXB36Bj1pxTgggkflMuQnkrF0JM80wJ8IVSsfn3xYYXlbylZjh+UcLdn6Bwr6GcniRmhfY6nKv0zppJl4pPxKvGaKG9Or85i2zTLV5IRWvvTtESKn2g=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB7072.apcprd03.prod.outlook.com (2603:1096:101:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 13:38:27 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a441:8f4:4de6:2437%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 13:38:27 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 01/15] soc: mediatek: Add register definitions for GCE
Thread-Topic: [PATCH 01/15] soc: mediatek: Add register definitions for GCE
Thread-Index: AQHZ1dR6H1mqSaw12k20xguxLLIkw7APXU0AgAZhhoA=
Date:   Mon, 11 Sep 2023 13:38:27 +0000
Message-ID: <82dd93e59bb8914eba13cb3bc9e831f11feb0616.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-2-shawn.sung@mediatek.com>
         <a0b60e8b-7fb7-b2d9-8c91-1be665e43800@collabora.com>
In-Reply-To: <a0b60e8b-7fb7-b2d9-8c91-1be665e43800@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB7072:EE_
x-ms-office365-filtering-correlation-id: 5dcfbbbc-ff7e-44c4-0f48-08dbb2cc614c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVQYfYTBxvSbaxKUMqbNxD9GXol89teCSqcNXyghZh+1l6SG9J9ZnkCkIsdwE893DHDo9gcQxTKrv0+YNYH/oEZS39NZ425SsdtuYdZg64syXC+lM33x8IshzBYy0Iszu9MMd09HLQ3MfRQKr5mu7Y3E+ZPR6j5HbbbZwfnN8CfzIEyocXozB+HsyhqVPwOjdtOPhNP+q8OjCw9AR/KXnUKdfmoDndtxiObooMHW+/VIIBOBmPOQfD5MEz35yM3ghI2Qxs3PQvPtEcbZnpMZeBAntxwQUgNPnS6/czt/dSQjRiwzPauZtdO3rKKp6Gqg6KPCiPE4QZkWE6K1ZnBcPHFhZVykZfySMDOf6MSdcjHQeubCpUMGK1+347AW8IveVRPl9vlD1mypwWnMCqn1y6tBbXWL2+3Xz8dVb9u/fX/9jfp40TBhB+aq2bkCsduUMxf4s8JQyi+nehed5JQJvDN8klwuUI/Et696Sl3PzebZx7d/J4VZeYc6OljHjj4SuB7z4vJKJ0/ZciJSFn/G2eNl1nhYzuucHnOcnb3u5EWnvyUxZaVkrtvk+WHtf4u3KxCxu6eyCVP0r2StHWYSMI+U+22+01KWKVPQXGt0oqLqYsJq1WFCU+uZsqq+tMv3R1UVZbZolrgaY/s/lxcsltfzkSCzZaQTqvr7j6C2UlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(6506007)(6486002)(6512007)(71200400001)(122000001)(86362001)(38070700005)(38100700002)(36756003)(85182001)(2616005)(107886003)(26005)(76116006)(66946007)(64756008)(66476007)(66446008)(66556008)(54906003)(110136005)(7416002)(316002)(41300700001)(2906002)(8936002)(8676002)(4326008)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZPR2xTZzE4NTNVaysyN1o2cHlUVzlrMFFkdGg2Qk4xMVNWZ25RUFNYM1dR?=
 =?utf-8?B?VVM5SjhTTFZaeENzVm9kbjJMUlVPUUN0ZHRyT1lqRmhPbHQyRWN1TnE0TEM3?=
 =?utf-8?B?ajZJcDRBT3oxa042cnllNkY0NmI3aDlRSmZYMkFCYjVjSVZyZkNLMmRwWmxn?=
 =?utf-8?B?NWJrZ0tUdkI1UnJBWXJnYUZQM1p0V0Q1d3VmbjBxOHp3UXVMMnVDemd0U0tk?=
 =?utf-8?B?dzJ5RzNFUHV2WlBIbDJCaEdzbXQrODBhU0IvcUFKV20wVTV6YVlqT251NS9F?=
 =?utf-8?B?SUsvUkpzZTJ4ZU1NajlSQk10d0xNTk1xaHNxclFmQWNkS1YwLzBGZnZOSjNI?=
 =?utf-8?B?VVZ0OGVzSXEvUkJtcDZFeU5tLy9WdDdEWkhCdmlHcUloOXFpMm5OTzFqa3lo?=
 =?utf-8?B?WXAyOHJmalA2L1VKNFVPRlRob3pla3JJU0RpdWZ2a1Ira1NEN2dLdWY5RXpl?=
 =?utf-8?B?MmxoOGxSb2xIcmM2eGhrdWxPZ1p0Q3A1OWUrNEF5VEgyT1dQL0ZUNCtFalVP?=
 =?utf-8?B?QjdrbUVxcmVFU3VHemRRT0FTRi8rcTBUYUtQYXFxUlB4TVJnSmlGQk9wMk4w?=
 =?utf-8?B?cFl4NjRWUzVNM3dVSmM3UHUwWU5sNWpKT213Tk9nbllnMVJ5OWc3L2I2a2ky?=
 =?utf-8?B?RUN2d1N0U2lVeVA5OFJFWEh6ZFBmUysvSmc2K09VVVZpMXBKSU9kVnBWTXhY?=
 =?utf-8?B?MmdTbWxQek5NTnc5L2NTUDllR0dWeW1idSt0RHpQT1poTlFhMnBrbDRDUita?=
 =?utf-8?B?K1I2bEcweEw1UTdiSE1CQ3BqSVAwU2dJTWFaU3BYWis3YmRDSC9nMS9SR1hi?=
 =?utf-8?B?UGpCS0ZCSk5mMFBLUGc0Ni9nK1hnMmRuZm5lTVd6OWkrZDBKN0tnQk9jOVNm?=
 =?utf-8?B?cEkydW1BUEc5a3hhWnoyNTMvS3FTKzhhd3FIdm5jc3A4OGxMS2I3alN2SWs0?=
 =?utf-8?B?bWpPM0ZpaWNoSVJMTVhQa3E0dGRKVzhPSHY5V2xCNkRCeHRZejlldnhLQ1BO?=
 =?utf-8?B?cXA0Q25OcTYzeFRXbEFSVFdzUW9TNFRuRGl3dWRTWHVleWQyc2tFOTRtOEZ1?=
 =?utf-8?B?dlZVbUxjbXZqQUM0WFlJemJNZlN5S1BxMjZPeXJCTFRNZ0p5dTRuY0xZWE4r?=
 =?utf-8?B?OXovWDZzWHZ4OWFaa2RYdUFNZVZFOFR3VDdTVW1aNWZzcmZ1Y2UydGZpa3Zn?=
 =?utf-8?B?ckJ1dWM2bEVIQkFGWitiYWtDKzd2dGx5OVJ0SmdXK0hzT0pLT0w4S1djK3Jl?=
 =?utf-8?B?QjVOV0ZQOE1wME5tQnZGUW5VcnluT3RDaXc4d0NMdG4rU3pJbGVMNGZhL2JR?=
 =?utf-8?B?a3hXWENVQ1lBSWQ2YlpOK0xnUk9jdmdwT1JXMHh0Yk5sVWhRaTdIUUZaWjR4?=
 =?utf-8?B?WHJ5RkZRbjdqTmJMRExPWERLUERMb3oraW5TYkg1OFV3NlQweVhSWlljL3N5?=
 =?utf-8?B?cEIzQWM3YmswUjZsaS8rSFF4WUNLenM5d0l0TTVXY3FvV1hXVnpFYUZsZzlr?=
 =?utf-8?B?MVBVbVgwdkVJWFFNZjZyZi9sNkw4MWtwVVo3SHdhcUtaa2hQWHVYSkNEaVBx?=
 =?utf-8?B?SDBlczkvdDFoWUJyeE9DTzVVNjlFT1BtVmxoZmtnSEZWWTNFY3EvVEpLWUtz?=
 =?utf-8?B?cDNmVXVCYmNUOFhOUXBTbHVwb2hNRGtYTUFDdFNNc2daVy95SnY0VUVyN3Bw?=
 =?utf-8?B?czY0RkpyQzlYd3pPVmp1S1ZPNlExWDFzdVREZjNlUnQrMEFYa3h0K1hNcGFa?=
 =?utf-8?B?TVZkQ3RFc2x0eThZclRVUkJualB1aGhPdXE2ZEdaV2g2eDY2QStwUE8wMW8y?=
 =?utf-8?B?SnpvT1NRSzRyNU5HWUVQbVBQdFFjeHNvNlJJUmJFUjM0Q2tjL2YzcFNJTThI?=
 =?utf-8?B?RjBTWkl1OHB5QXFTdEMwWmFubXdnS3gwMkFvSEZVRUVOcXpVK0Y2ZlEwL3FB?=
 =?utf-8?B?cFgyQTYrNWpFNHRPdGx1TVZ3M2M1b0hkSjU0dXgyK01ISHoyWjk3NzdYcG9y?=
 =?utf-8?B?aktHbDZqVnBaNGJlbm93dTN5ajJqOU81OEhiZUR1N3JYVUcxTktzT1ZCVFBQ?=
 =?utf-8?B?UVBoTm5EMXVCcWFnNEYvQU9WVlpYUUMyTEJBcTlWS2hBNXFUUTRMcjdla0JX?=
 =?utf-8?B?SmZzMUZRNkhybmpMdlhaSit4WHhRY2J3YTlFVUthbFlyaFpPNGVmTzVQcFBT?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5DC535958D13C449148DB6C0F4D9598@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcfbbbc-ff7e-44c4-0f48-08dbb2cc614c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 13:38:27.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCy1xMbdBgjMfMd4VU1DtCjHtFLBAIoNAYG+9UjROBj7a0LbHFsZyUCgzaYWk/gUJLwjqsMM67uUSNVl2OWX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7072
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.175800-8.000000
X-TMASE-MatchedRID: w2TFuZOvAtfUL3YCMmnG4vGG8F2k2BBVYefZ7F9kLgsNcckEPxfz2KYJ
        d411IbQJTSQ+dxkMp9r89WDKQGB2LkaWGOeKmQYQydRP56yRRA9QCOsAlaxN72rVm7PW4m4IT85
        +SH/4AvjtZx7TunPosBPF8Qn6QUl/Ja+FAG1BTBPmAId+2bAQwn0tCKdnhB58pTwPRvSoXL2ZMP
        CnTMzfOiq2rl3dzGQ10bRinHhsJamb8f/bI55WHKVywR9kxIrsGIPdeePzUz0HZcYOSUeiCw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.175800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6A5C6A021ABFEBDA09CDA5F3213C30A840092A52CE54CD3FBFF33AC0E0DDC5E52000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMDktMDcgYXQgMTQ6MTEgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyMy8wOC8yMyAxNzoxMywgSHNpYW8gQ2hp
ZW4gU3VuZyBoYSBzY3JpdHRvOg0KPiA+IEFkZCByZWdpc3RlciBkZWZpbml0aW9ucyBmb3IgR0NF
IHNvIHVzZXJzIGNhbiB1c2UgdGhlbQ0KPiA+IGFzIGEgYnVmZmVyIHRvIHN0b3JlIGRhdGEuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oIHwgNyArKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBp
bmRleCA2NDk5NTVkMmNmNWMuLjNlYjk1ZWYzNGM2YyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0xNCw2ICsxNCwxMyBAQA0KPiA+ICAgI2Rl
ZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAxNikgJg0KPiA+IEdF
Tk1BU0soMzEsIDApKSkNCj4gPiAgICNkZWZpbmUgQ01EUV9BRERSX0xPVyhhZGRyKQkoKHUxNiko
YWRkcikgfCBCSVQoMSkpDQo+ID4gICANCj4gDQo+IFBsZWFzZSBhZGQgYSBjb21tZW50IGV4cGxh
aW5pbmcgIlRQUiINCg0KSXQgbWVhbnMgVGltZSBQdXJwb3NlIFJlZ2lzdGVyLiBXaWxsIHJlbW92
ZSBpdCBpbiB0aGUgbmV3IHZlcnNpb24gc2luY2UNCml0IGlzIG5vdCBiZWluZyB1c2VkLg0KDQo+
IA0KPiA+ICsjZGVmaW5lIENNRFFfVFBSX0lECQkoNTYpDQo+ID4gKw0KPiANCj4gUGxlYXNlIGFk
ZCBhIGNvbW1lbnQgZXhwbGFpbmluZyB3aGF0IHRob3NlIGRlZmluaXRpb25zIGFyZSwgd2hhdCBp
cw0KPiAiU1BSIj8NCg0KU1BSIGlzIFNwZWNpZmljIFB1cnBvc2UgUmVnaXN0ZXJzLiBXaWxsIGFk
ZCBhIGNvbW1lbnQgaW4gdGhlIG5leHQNCnZlcnNpb24uDQoNClRoYW5rcywNCkhzaWFvIENoaWVu
IFN1bmcNCg==
