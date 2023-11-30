Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C147FE671
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjK3CBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:01:03 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D61B4;
        Wed, 29 Nov 2023 18:01:07 -0800 (PST)
X-UUID: 4cdf187c8f2411ee8051498923ad61e6-20231130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PFjRqQOUXy4XXX/8xViXP5lrkvvfRXEV8UIYUkZ/YfI=;
        b=BvyUfNkwq7PiA4mtLlrrJ1vOxwNp2jo7t1SvMcIQXoVgx9MOry3Iok9wWooRG8kTdqAOlsa8g6IZATx2/yG5p4wEFpVP/sZWBHjHl0SZ9x2wCKSOyH0UDbQz8VEr6ctArefhyIMCRydp+hBrTtlLBUGudwv+8TfZVuvrMBZrHkw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:bd6a0f78-1079-416c-a050-ec6a65e1fff4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:8e8cf895-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 4cdf187c8f2411ee8051498923ad61e6-20231130
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1553933151; Thu, 30 Nov 2023 10:00:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 30 Nov 2023 10:00:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 30 Nov 2023 10:00:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvqIoVOZj6q5QoeWEyutFGcu3HVM5NXbh6m8c3akXsVxzgeeSyjJhvD0deRXp98nmXagwy7nh88NGRAd7VoUp7kj9Ebak3ROtcyi/iLXuWq484Gke2Nn3AoQnFnS8E+M8r5pfTj19SHXg2jeRR/GHxaec5tLPG7c9qHKSC5BxxWhCjrfb/ejVX9kXthtHefyHjt5XPHWNfWvevszg0IrDdTS1xBFhCjFN5y5acbagOn+t4LcIlcaj2bEh8cmfjBfgEjaB860sX8Z2Tz1AQS4OaSjdVcMBHzFgWUcev3tgsUsXrkJAiStzsR2rPT0IJbon1JJPpFi4oDQbzyAWyZ3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFjRqQOUXy4XXX/8xViXP5lrkvvfRXEV8UIYUkZ/YfI=;
 b=dw0ALCDwjiaHDlWtBSXU9/WrAlp++KlF1ZKADOBmBOybnHQeAcJ+n70R/wzGkdJ1p+6i35EZYD2nSJ9auWl50GoBtpQ2FfC9p6PfVfA+7Jk4BxPXw9NJUxXtrc03tYj2LfOA0DjKOpCDxxXbvCNiUIAzsGIS+y5oEY9pM9AnwIKTzPmsRALi1WZop93m44lT0FyNiWRMmyF3W2TBT9sSS/Q1l2L8bHCZTDrdqoMwi23Kf/2+j6uNXYOdhUw8LWeTZPYom8ULpZxPo7fqqNDDMOqDLTWk0zc16Ft0Vkw1pG/lZiHbJYR258/U+jKihTE2fUBCsLWduWhwatgSldZo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFjRqQOUXy4XXX/8xViXP5lrkvvfRXEV8UIYUkZ/YfI=;
 b=g8wfLtvNZRLpMB8+g+/hquVw9F2m5R3soI6QddNh6ymae1TRHSs1Pynh2bPrSWB07pFBnGHugGSWLNVnul2nTnoALFT0CdX4mBI6e8TSmvuFu6/et24k2c7wcR6AkEBhhwvAv/0Jnn2oIqHcPxwqKZWmX2vkN3+CMK2F/ChT/nM=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SEYPR03MB8791.apcprd03.prod.outlook.com (2603:1096:101:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 02:00:51 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 02:00:51 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>
CC:     =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= 
        <bear.wang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Topic: [PATCH 1/2] dt-bindings: phy: mediatek: tphy: add a property for
 force-mode switch
Thread-Index: AQHaHz31Z+QBjWZtBk+dlN+S28FsW7CK2GgAgALqXwCAAANiAIAAaS8AgAP0QQA=
Date:   Thu, 30 Nov 2023 02:00:51 +0000
Message-ID: <11c0db0c8194be1392a5f78058eea3d39feb00aa.camel@mediatek.com>
References: <20231125012303.760-1-chunfeng.yun@mediatek.com>
         <e34c2746-8e93-48b8-9c96-690242fbf6e9@linaro.org>
         <239def9b-437b-9211-7844-af4332651df0@mediatek.com>
         <0dc24d82-e09d-45bc-98ae-1dfb6318cb96@linaro.org>
         <efc64b77-e454-4b9e-9508-311f00d2db83@collabora.com>
In-Reply-To: <efc64b77-e454-4b9e-9508-311f00d2db83@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SEYPR03MB8791:EE_
x-ms-office365-filtering-correlation-id: 2bf531d2-6a2f-4998-a1ac-08dbf1482e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0SHxXEEJbHEaz4/HxkKeOimRc/lTs/uOjgDZ4h0xMvlPYsBBg0rlbAUgltWN1P+b+pT9CF5MVjaj87CX9F8v8GJ/YAKxAavHnGGZ/5zOMKSJ77adikL/+xUIOAw61cFQk9uROrfDPu70vlOQqSNKY03XgPNJZIJm+HN1xcai0q5Dhe8aoNwEdc+HCFpw2NplY7wR3DevxlaGT9rlT5qDOwM8mt456+FSar7Hiw4yZDr2uiaP+z8BtOubzkpz3O7pWSG34YwT5QM1Cy0f0zDX3yvXT6YPuISozpQJUJaNDGfQxPWGeqwiEvRbHdnhHEWa/ffCMbXBOldGR8Svess1W8U1AR9f0szF/1LR5iKfS2/ADfylqxPCIV6YDfzARtUd92tVszZKo5f9OHjj9SOTGE3NurTNp93jUv8Ot+boQOY1wFI+f5WPRnK8wA9kBzZcwqrpXuD85XaBqVBnhVvOSx6PW+yNyqlnisv0Y+X/hAz9Sx/oeKqqSJX2Q9nxmDA+qS7b8jM1e/xAHHT1Nh+6DP2dordtsdRwGWp2mTqrnmtYSRvvc3Iq+wXnVt4Yg8G7GEpIfehWNzSGmqdjt/A3B/lB1p8qxGV8QrSPgizkfA8pWHy2Lt2JlbSFMXVwtW9guuOM82X0l2Til4Hy7eQQfVWgbXORIYYGoSDTiOwdNVYlB1HSs5okMP8O8wfgGl0nF9lrGq/Ll7t4vWm4MwLezTaJAW+8FjpglSJLFg034SPrcdIrENSthlxX6In8XazlI/+r2RpKgx2GlbM0o0Pow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(8936002)(54906003)(66556008)(8676002)(4326008)(6636002)(316002)(64756008)(66946007)(6486002)(76116006)(110136005)(91956017)(66476007)(36756003)(66446008)(41300700001)(4001150100001)(7416002)(5660300002)(2906002)(86362001)(38100700002)(122000001)(85182001)(26005)(2616005)(6506007)(6512007)(53546011)(202311291699003)(71200400001)(83380400001)(38070700009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGkzQWJxTDhQdFZnZGdUb0hBakVid2JOVWcwZE8xbUdJL0pMLzBsL1cxdjRL?=
 =?utf-8?B?dnU4ZysrWS9pRkN1c25xenZJY01BTjgxMU5DZDZ6bXZybS8rZHVWbURFL1lz?=
 =?utf-8?B?MjZPMFdxM2ZyUkhlQmFoOGhnZXBIR3VTVllzSmp3b09DUWpXMnpKUVYwcmJt?=
 =?utf-8?B?Qy9GamJMNzNtcU5PZnRtSlhQcFgzMFdIeklUdHJubkJ4a3krZitHcVdVUUtm?=
 =?utf-8?B?dEJqL3dtZHA5SUwrbXMwTS9MMUxUVE1nb1dCaGtFL1p5S3RTdzNwK3RWSkd1?=
 =?utf-8?B?VnU0emdsNk0zTHk5VVpsZG1HWFg2a29zWWxiSjUvVUtOVU9UbllTWXV3UTdh?=
 =?utf-8?B?Z0tOUm1tMUFRbWg2UUZCRWdZMWZwK0U5aG5SZ2lVOEt4YnNFZXNKdXlIWmtG?=
 =?utf-8?B?QThDWXgydTVnallZUDM2UWFuME1SQnBxbmhMeUdvWXM0VjR0aXliSVNtUmxU?=
 =?utf-8?B?QkRaS3MxZW5zQXVnTVhlYnVZSXk5cnB0L0NvTVR5UTE1NDFTS3hnS0tMeWtP?=
 =?utf-8?B?VWtrTnhTRUlReDZrK2hPbDgvbFJQT0ZVY1ExSXR5Zi9SeTYzcGYvZFlNTEdj?=
 =?utf-8?B?aHRlUFBZclRyRm9rZlZrZ0pTekFRUDFLTmpuM3lkMkd3QlBNYmVDZmRwSU5Z?=
 =?utf-8?B?ejFOcm03TmdvZWFoL2c1Smg1VWV3SlR2bkVrNlYwN2JrUmRtT2paOW9OeHY1?=
 =?utf-8?B?c3ZKNGFBY2ltb3JPUmd6RkJ0TitLZ0dKcWVRMWJOUm9RRjVYSGJ1TE1pRWlL?=
 =?utf-8?B?OXhPY01PMk1wbjd1OXVqRWQ0WGZpcUpRL3RyVmtuNUJTakpISDZ0RDF2UUVH?=
 =?utf-8?B?cnkxLzBpUkkvUGFXbEkxSE1MajRRQVQzOXdzVXRtNXhCQmZNRmJtZDFhM2pP?=
 =?utf-8?B?RFY3dlRWQlRTQ1RUYkVGRWNIWk1vV0poNDNRVHFuZkJpQnBabHc2ZU8vWU5w?=
 =?utf-8?B?b0FrTDNIdVBybVRSMGxaUitnUG9TSjdIT0FwRnBlV3l5YXB6WS9EM1JCZEdC?=
 =?utf-8?B?dWo5Mm04WXJXL3pldnFraGlGam9vQUpGSm9aRVRsRkZMVkp6dkRseVp5NXVK?=
 =?utf-8?B?dlBYd3poV0JBRGovbDh0dVhsblhiQ2dUbngrQUlJT1BOTklHNCtYMnhoandw?=
 =?utf-8?B?SFp3SUpPcktyVG1kVjhmclIyTzR2cy8rOEl6UDV3ZkU0WWpDL0grdVVpUmtH?=
 =?utf-8?B?SGZmcUZhVXIvMmFoTnZSUk9DV21TWTV2U3E1aC9xZ2hJTGRaeW56TkxSV0Rq?=
 =?utf-8?B?N0phb0FRZFkyMVAwbkowSTEzS3hocTM2bHI5WjNHaFZJS1NERjNDV1U4Y0tZ?=
 =?utf-8?B?VmlkMEFCUEcrV1Z5MlZhb0hRNloxYmpRc0t5WmpmQ0FmMXdkeDEvWFNzRHhG?=
 =?utf-8?B?VWU1dGJISFBQU1FESkdJMEYvS2ZNTnFtWVJjSkxhbUpBanBzN1FUS2grQjd5?=
 =?utf-8?B?NzZOMzBzZFA4cC9SQnM4eXk5MWwyNGRSRlZvUm8yb2NBQXBnSmNSM3lTdU01?=
 =?utf-8?B?MjUzOTRpbGxuZFlQbXRDTGM1d0dBaGNkazlaWDZQMmhZcm1xbG9RcWJCME13?=
 =?utf-8?B?enRDa28yRWZpbEJ0RjI2bGMvQ1dyV0c3WFdTNm9WUWZnQUNDUnp4bndZbVEr?=
 =?utf-8?B?Zi94ejM4R2xrVUFLQzJaUlJocXBnRjRyWWtiUElsVVpZZTlOdmlSTUdGbHht?=
 =?utf-8?B?bDZIRVp5OW5qbTYrN0ZNSFJOWE9ybUJaMGNzU1BiaitoZjZBY1ZQOG1SanFu?=
 =?utf-8?B?TVNpcndnQnV4UHY4bFJrMWtLaGtVVnVCNzl6dy9VZmRUeU9hSG96OFVsSE1H?=
 =?utf-8?B?ajB6dzVxS09tdHlzWHBNNVhVbkxELzZBUnpmUkhPaWxTL0phRXZ1U3F6Z1JU?=
 =?utf-8?B?QkpJdXhveXh4d1k5WElZSDZlVXNTNkVaRVVnM2VVR082L2pNM1pJbVZQQ09i?=
 =?utf-8?B?N2J2djhpYTlWVE14TGMrYTFCOHRWL2trZUlaMGdNaElMWVpzQ05OcXRRMm9s?=
 =?utf-8?B?bGlPbFEwK3Z4M1EwTnJLQjV3bXlZYWdNZGxIcVo4K2tobml0eHBubGlGbWk0?=
 =?utf-8?B?RGRYbDlLQlhxQWZYUWxhYktYdEhIeXFuTFprNGVVSGM0QU5saTJQV1ArblpX?=
 =?utf-8?B?REFiM0E0MHB5cE1iTlJ1SFRPOGNxUHU0R0J4Ni9rUkZSOTcyZnEvcWpUWitV?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <310933A80570C84E9A0C56A9888D5C28@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf531d2-6a2f-4998-a1ac-08dbf1482e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 02:00:51.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6erZii2f1rF3rQo7jCcEZTKPLmF8nnBTXe+M8hq2AodnVE3xxZLUMtLKr9aErnJIELFkjKiR2vttzwG38dzLTxlDWUWtKADky6E9gRJYqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8791
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTI3IGF0IDE0OjM3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjcvMTEvMjMgMDg6MjEsIEtyenlzenRvZiBLb3psb3dza2kgaGEg
c2NyaXR0bzoNCj4gPiBPbiAyNy8xMS8yMDIzIDA4OjA5LCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
PiA+IE9uIDExLzI1LzIzIDE4OjM3LCBLcnp5c3p0b2YgS296bG93c2tpIGFuZCBDaHVuZmVuZyBZ
dW4gd3JvdGU6DQo+ID4gPiA+IAkNCj4gPiA+ID4gDQo+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiA+IHVu
dGlsIHlvdQ0KPiA+ID4gPiBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQu
DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAyNS8xMS8yMDIzIDAyOjIzLCBDaHVuZmVuZyBZdW4gd3Jv
dGU6DQo+ID4gPiA+ID4gRHVlIHRvIHNvbWUgb2xkIFNvQ3Mgd2l0aCBzaGFyZWQgdC1waHkgb25s
eSBzdXBwb3J0IGZvcmNlLQ0KPiA+ID4gPiA+IG1vZGUgc3dpdGNoLCBhbmQNCj4gPiA+ID4gPiBj
YW4ndCB1c2UgY29tcGF0aWJsZSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHNoYXJlZCBhbmQgbm9u
LQ0KPiA+ID4gPiA+IHNoYXJlZCB0LXBoeSwNCj4gPiA+ID4gPiBhZGQgYSBwcm9wZXJ0eSB0byBz
dXBwb3J0ZWQgaXQuDQo+ID4gPiA+ID4gQnV0IG5vdyBwcmVmZXIgdG8gdXNlICJtZWRpYXRlayxz
eXNjb24tdHlwZSIgb24gbmV3IFNvQyBhcw0KPiA+ID4gPiA+IGZhciBhcyBwb3NzaWJsZS4NCj4g
DQo+IFR3byBxdWVzdGlvbnM6DQo+IDEuIFdoeSBpcyBpdCAqbm90KiBwb3NzaWJsZSB0byB1c2Ug
dGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvDQo+IGRpc3Rpbmd1aXNoIGJldHdlZW4NCj4gICAgIHNo
YXJlZCBhbmQgbm9uLXNoYXJlZCBULVBIWXM/DQpUaGVyZSBtYXkgYmUgc2hhcmVkIHQtcGh5IGFu
ZCBub24tc2hhcmVkIHQtcGh5IGF0IHRoZSBzYW1lIHRpbWUgb24gdGhlDQpTb0MuDQoNCj4gMi4g
SWYgd2UgcmVhbGx5IGNhbid0IHVzZSBjb21wYXRpYmxlcywgd2hhdCdzIHRoZSByZWFzb24gd2h5
IHdlIGNhbid0DQo+IHVzZSB0aGUNCj4gICAgICJtZWRpYXRlayxzeXNjb24tdHlwZSIgcHJvcGVy
dHk/DQpJdCBuZWVkIGhhcmR3YXJlIHN1cHBvcnQgaXQsIGl0IHVzZXMgYSB0b3AgcGVyaWNmZyBy
ZWdpc3RlciB0byB0ZWxsIHRoZQ0KcGh5IHRoYXQgdGhlIG1vZGUgd2Ugd2FudCBiZWZvcmUgcG93
ZXIgb24gdGhlIHBoeSBjb250cm9sbGVyLg0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0K
PiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbCB8DQo+
ID4gPiA+ID4gNiArKysrKysNCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbA0KPiA+
ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0
cGh5LnlhbWwNCj4gPiA+ID4gPiBpbmRleCAyYmI5MTU0MmU5ODQuLmVlZGJhNWI3MDI1ZSAxMDA2
NDQNCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQo+ID4gPiA+ID4gKysrDQo+ID4gPiA+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFt
bA0KPiA+ID4gPiA+IEBAIC0yMzUsNiArMjM1LDEyIEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+
ID4gPiA+ICAgICAgICAgICAgIFNwZWNpZnkgdGhlIGZsYWcgdG8gZW5hYmxlIEJDMS4yIGlmIHN1
cHBvcnQgaXQNCj4gPiA+ID4gPiAgICAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ID4gPiA+ICAg
DQo+ID4gPiA+ID4gKyAgICAgIG1lZGlhdGVrLGZvcmNlLW1vZGU6DQo+ID4gPiA+ID4gKyAgICAg
ICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gKyAgICAgICAgICBVc2UgZm9yY2UgbW9kZSB0byBz
d2l0Y2ggc2hhcmVkIHBoeSBtb2RlLCBwZXJmZXINCj4gPiA+ID4gPiB0byB1c2UgdGhlIGJlbGxv
dw0KPiANCj4gDQo=
