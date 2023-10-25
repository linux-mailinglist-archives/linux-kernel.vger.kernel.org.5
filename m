Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F507D6466
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJYIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjJYIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:03:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B62116;
        Wed, 25 Oct 2023 01:03:05 -0700 (PDT)
X-UUID: e9e7a816730c11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ezchoCoDFeDK8WmxC6lFh6VaNG+/iAACe1e12r7J95k=;
        b=jYRY8GMXtb4JlHpGttlAKSYnZ7Rmt7+JfVa2bwbgmvOmHRtWvV96DQ7Nbv4DSCUWYFYbh0XhuYuauDHb7BVOCLj0FhVM3V+TCcdZ4qEw+2O4RP/vnZi8D82GAVS7AI9Q5AvWTx90vfroIUxp3Ko/ysCHmi7+eFFiCX2gfo1jqho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0c70ef6d-f9fe-4a23-892e-0ec3eab81b6a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:18db9c94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e9e7a816730c11eea33bb35ae8d461a2-20231025
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1820498154; Wed, 25 Oct 2023 16:02:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 16:02:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 16:02:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azm0Vp1p+3b4GYxgQbNjz+2eLGP8IJr/VbHbf152UfJ7iG3LdlpjDcISb+XSvdzQb0bVah6uflw8Q+LwbBT+UUJ3qO2Cx74wTqScD686XYC7Y7WlpgslkFACBajyXw4eGG6xqwVmhmK5gg0DYMcXv9qF38gmfrbcGeGYqT30m6v7qdC7sxId/+QmnqYxk+AuENIdrB9FQhrzOqFiDSUYzndx8tjJRATqKLYbyb9HXRCno69KHcyF0AkMcg9jjcdFhlHu5h0+CLUCJeqLiCMqxXYACBBw+NbXfenlyc4qYn/GjTrwjr5K+JsCZnFL4hxp1+lA5dLCtUoCMK7SPwVRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezchoCoDFeDK8WmxC6lFh6VaNG+/iAACe1e12r7J95k=;
 b=NrrWOQ5fCNDx1Rl33AUhej1Px2tjlSyV2VkrRn71tmRsgCAdkB8co3L4uEfn2XaV7ehVy81ApdZcCgj2+ZtDbJA56/xa0UY7UuGPg5pChYlGlE2dQcDchWalk16H9oknjtXBUh/EM9QDGb+1txvfQideCRDx24/sFc7cdMxneGi2uoHozKhxTPTNP7sshPj5CVwXfcaMFLl4cdy3asOj9YPFS1043q2dXLPc29l5HwW9BV5kG6PaLVkZesEx547QJpT0moJv6haEyN7oqBHAKz08aQJvSuMRUvXvQ7rCBi4X4Pqf3yZXUU6AMDThe9KNdsqPE8wK9+o0P6yEsd510w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezchoCoDFeDK8WmxC6lFh6VaNG+/iAACe1e12r7J95k=;
 b=MXJ/Vv8KdnsspLjjENsDmaphYiDLnUfjkCv91qN7TcZzTxJbuWvqJI4fvLsmhlkzNKndeBBRPYLyeppGi9W1vzopQF8JYvisMZNNB4VqGE4uVZIkBLXqy2xaAZEO2DGQKqRCMovtjCZUG/DVD9q7VLf48wioEKqs7YOtK6Ia6L4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5389.apcprd03.prod.outlook.com (2603:1096:400:39::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:01:55 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 08:01:55 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v2 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaBWvoijbhEc/R00mY51hFdbW5LrBZ1jGAgABSAAA=
Date:   Wed, 25 Oct 2023 08:01:55 +0000
Message-ID: <a3ba435411106e6e4b758fc7e815d41b7cafa951.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
         <5d688b197946656bcfac74e8a6f0325a738260c4.camel@mediatek.com>
In-Reply-To: <5d688b197946656bcfac74e8a6f0325a738260c4.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5389:EE_
x-ms-office365-filtering-correlation-id: c418cab6-e786-49bb-5af4-08dbd530a7e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B/4c+iU8985KoOkT6CvY5vxIGj17irUYbUxDSl2v0XhTmvglgOQFrgcigQaHBgoxkWS7T3Nxy+TKJuMGyoLP3y+cqUenD7gcU0yNjItnTGfy0mJJyMjvof8Qda5Kl5Lfw0d0xnbBB/zh083oqw+bOPoTX+WTqB09mWFL43l0BpGTL6Yf340OT/XoUn3Jurt2h133Gd/JkvtLX0Ad2ls6i5/6gZbas1q9RJxu2BPpXF7BMWNz1hDvUARqrPe69B6LyaIKuThCKPfv2EBaDVF0Z5v2YiKpjksN5YtgiqS7MHAdMShNFOVngAfy0nAB9yDboPpCIlfMPXp4duZ4gIT1qS/VtRer83G3MFlT5dpX7FEZwfAOKzAdAOgxr5BCMbYd9jvWfU2TbiPpMx0E7vOA8BzbaLovJaCOm513RN2n/cJKf4JxuCzq8k44gfati+rUvmZnXNVkDNUInWBjMjOfgqVXBRijWMAVzzqCF0oACfrDBZbE0P3AJFhWsFsHrCTu9L1EDwhKhEcd5md0LN4+xlXlGYN8KfbyQTa7Uh7cGC7ZM/gHO/LcpWRbkhN/YUbl/BfMJwlsJGyXikWQ5bwEctZ+0CwDwo6l9kfr6bPYL3fmmo5O4YHjDQVmESrxFBau3bKDCttd0Qai6mWbNUDV91u9Yzn+g17fcS5OvHw1mLk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(85182001)(86362001)(2906002)(7416002)(4001150100001)(26005)(66556008)(110136005)(66946007)(91956017)(76116006)(2616005)(66446008)(66476007)(64756008)(54906003)(316002)(5660300002)(41300700001)(83380400001)(8676002)(4326008)(8936002)(478600001)(122000001)(6506007)(6486002)(71200400001)(38070700009)(6512007)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXI1ZDRpMWVrYVNQZVJnaWJRbDNhbXJZY2pPNzV3SEE0dlZNRFdTbU8veUc0?=
 =?utf-8?B?c1FkTnZiemc3Z1k0NVdoRmY5TWtyYk1YQ2pXNEpicWtjUkVWZ3gyYjBpWGd2?=
 =?utf-8?B?TzNHM3QwakQwNWxGc3IvUTlVSXBZcm5GNlhZMVk4eWtwZExsL1FoYUxHU1U1?=
 =?utf-8?B?b0xzVXpBN2ROSFoyOG0xbWhVbllOQkQ0V1NBYlJwc2JreHFnN0F1b2hvdktk?=
 =?utf-8?B?cUxKTFRaUGt1cWU3K0cveGtFcWRmSEk0RW9mcTNUVGcvb080Zjhqd2gvOXB2?=
 =?utf-8?B?eTRHcGIzN2FQNVhTWWE5dEhtUERJcXZpWkVhcXBXVnl4QzFnalVFRm5EOW5U?=
 =?utf-8?B?SmV6M3h6eHBpUnZibEY4QjFzZ3U2TGI4cmpaZHIyYUJnekw1Nk1FTHhaNlRK?=
 =?utf-8?B?YUErMDNMQmZIdHNhMXZhc0phTWU5dkppaWVTQ3EvNStRamk0aXpRMkllczBm?=
 =?utf-8?B?NG4xNjZlZjVIQjRuejNOcFQzSFdLY1k2bjNDM2E2MHNQazZoZkZaUEprMkRC?=
 =?utf-8?B?K3VLbTRDakJycGNEM2MxU2xJZStvaG9oRU5rZ2xaaFpBVVNJalRZNERMNjRj?=
 =?utf-8?B?clBiZlp5L1lRdFllcG1MTC91RVFGTmREc1lHbENFS1BhV2p1NDkrbFh3SWJn?=
 =?utf-8?B?dC8rSzRuV0xSRVBHOTV5TnBGYzBTdFhJVnpKSXowNjBZeTdaSVJFUEMrdjNy?=
 =?utf-8?B?ZmxDVzVqYnp6bXZNeDZZckI3dXNwU2JFdzlTRVRXa29zdUV0ejdOTmk3ZnB2?=
 =?utf-8?B?Y09rTkFOVHBXeStBREIvMkFZcFprbUdwckRqMlZJRzZpK1RPN1p5SnVHdHBV?=
 =?utf-8?B?ZHBXUGlRQlZSSEllbXBEN1EzY3hOTmxPRTlHVWxUdnRWbGtzMVA5cFIwSWNi?=
 =?utf-8?B?Uk8wZm1NcFZFMVF4Wm9Eak9PdDhkWnBJYUIxeXJaTEVrb2t5eDd0TXR0QlRi?=
 =?utf-8?B?a0o5SldZTnhVUWw4MGZ0aDV4VjVsYjlSc0l5SnhZd3lqYUNvSW5jRjY5dnps?=
 =?utf-8?B?cTJIZG1qcGV0bVhoUExycmNnRE5mVkwySEt5ZkRzWDE5ellnaWxneGI3dW9q?=
 =?utf-8?B?aHIzTXdFcVlPVXFUUnVpaEovUHh0Nm1Yc2N0ZUl4RXlJYTFZbDBUMGQ2UGVN?=
 =?utf-8?B?TGVWZkM0b1pjUE5hWWxEeWlXK01EK1VLb1I4Z3lVZVBFTXJvcDZqYW0vQ0xy?=
 =?utf-8?B?L3Y5cHZjQm1uSXJPeTgxSms2U1VaQXFMRTFpQjR3WDI2Vnk4YVkvQ3VpR3Np?=
 =?utf-8?B?bithUVNOc0lEdVY5OXFydFZ5ZjlDNHBKZmE2S3ZvMmZuWXVVL0lya0R3eENT?=
 =?utf-8?B?a2w0WUwwQXE5QUtkOEJWYnMyWDVxTW8rUzlQMHF0N3EvN1hZdDI5N0I5Qng0?=
 =?utf-8?B?OGpOVWNlTFpHcEZEaGhjU0plbzVtNS9WRDlRbWM3bDRBZlRsMW5VMGFnTkE2?=
 =?utf-8?B?RHJLMGE1ZUkyNnNvTHIxWHJJaXdOQTQyQ21jWkxWVEZ4a2JLMjFTUjdpSCtV?=
 =?utf-8?B?c0lwUUlhd016d3dUNHhRVFdMc081Mi9BbDlyaWRqRkk5N2szdGlBSjYyTzlH?=
 =?utf-8?B?TXpvUTRHaUNRSFhTbVY5Q2RnelBvYk00cGhjbXYreDZ0WnFXTVQzY2hHcjU1?=
 =?utf-8?B?bFV5dVk2UjNsTjFKQ2UxZWhnMEh6VWs4VXlYdkdNaXk2RFIvSGllTTFpSFlt?=
 =?utf-8?B?TjArU3NOeTFQWWdaVE9pRmI4U2RDSTVvSGVFdVAweGJXbUZXZkxlZ3RWNW1F?=
 =?utf-8?B?OWZFUU1ZVlFZSHNiT0k2MkNrV3ZZaEZmeTdDMXRsVUw0UVRGbkJYRlo0MERY?=
 =?utf-8?B?dW5qV3JIWWNXRTBVb2s5VXJkOUp5SzMrYmp0NzE3WUpUZGgxTStRT21rZ2lB?=
 =?utf-8?B?K2VFenRrZFBueS8zL3dqNDBUcWFKdEtSV1JDT0t6aUErTklCMzNQcytuRG5X?=
 =?utf-8?B?a3BRV2o3VDBPeDVpVHdrMENPR1dYTWlHWG1RaG5aSkxzb3Z3YjRtZGE4NlRn?=
 =?utf-8?B?MmFZSmZjS25VQkVjR3doQkcyUjhtbWJ0R0g0aG9heVF1T014OFREVnZjQzVX?=
 =?utf-8?B?MzdGTlEvZzRyUjl5U3hpN05iMGJCZVVYY3VLT0lUT0VQYWFMRklPUE5Penhn?=
 =?utf-8?B?eE1KZmM3SE1sbCs5czFpM2l3OGJHcDhyckxhejZBa0h0V2NFMVhDU2VXbkZR?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567B17B8C897444CABB8057899CECD5A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c418cab6-e786-49bb-5af4-08dbd530a7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 08:01:55.4241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRCL+W/tyIn/i4oPyuwp2V1WnCkeW/jjI3Fz9ym+xoyvEyGugNqeJJ42PYK342V+vm6UIxGW0FPZwRPcMFi0F0tURmtprQICkiYp0zKPGAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5389
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.962500-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvinykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4+qvcIF1TcLYJyh
        lVw/MC0H9KE7L0nJx0o9DY386Yl5fs9vo7YIZzOqA9lly13c/gEraL2mh8ZVK0YvSDWdWaRhxEs
        GD8geUL0vYaMVNsrFr5NWlAuDdhlpLVayL7k7olzil2r2x2PwtbuesBT0pDFR47ndse0z1bf5r/
        N0c4ndacVc51HetUBS/oxWQA7bUu9YQsNwrAY7bjPDkSOzeDWW1KoSW5Ji1XvynD52fV2jJTBXX
        b/qS263PDkVAd1QonrKC/+75/CEQbvaJG+XDhc2ngIgpj8eDcDBa6VG2+9jFNZE3xJMmmXc+gtH
        j7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.962500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E547534274857BE8BE400D6684EF85D62B463BA6506D575795E102C08C46BAA62000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFdlZCwgMjAyMy0xMC0yNSBh
dCAwMzowOCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAxMjo0NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQgZm9yIG92bC4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAg
ICAgICB8ICAzICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
YyAgICAgICB8IDMxDQo+ID4gKysrKysrKysrKysrKysrKystLQ0KPiA+ICAuLi4vZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAxMiArKysrKysrDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICB8ICAyICsrDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBpbmRleCAy
MjU0MDM4NTE5ZTEuLmRlYzkzN2IxODNhOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBAQCAtOSw2ICs5LDcgQEANCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc29j
L21lZGlhdGVrL210ay1tbXN5cy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVr
L210ay1tdXRleC5oPg0KPiA+ICsjaW5jbHVkZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiA+ICAj
aW5jbHVkZSAibXRrX2RybV9wbGFuZS5oIg0KPiA+ICAjaW5jbHVkZSAibXRrX21kcF9yZG1hLmgi
DQo+ID4gIA0KPiA+IEBAIC03OSw2ICs4MCw3IEBAIHZvaWQgbXRrX292bF9jbGtfZGlzYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gIAkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNp
Z25lZCBpbnQgdnJlZnJlc2gsDQo+ID4gIAkJICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBj
bWRxX3BrdCAqY21kcV9wa3QpOw0KPiA+ICt1NjQgbXRrX292bF9nZXRfc2VjX3BvcnQoc3RydWN0
IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50DQo+ID4gaWR4KTsNCj4gPiAgaW50IG10
a19vdmxfbGF5ZXJfY2hlY2soc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0K
PiA+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiA+ICB2b2lkIG10
a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwN
Cj4gPiBAQCAtMTEyLDYgKzExNCw3IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX2Nsa19kaXNhYmxl
KHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2KTsNCj4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gIAkJCSAgICB1bnNp
Z25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiA+ICAJCQkgICAgdW5zaWduZWQg
aW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+ID4gKmNtZHFfcGt0KTsNCj4gPiArdTY0IG10a19v
dmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gPiB1
bnNpZ25lZA0KPiA+IGludCBpZHgpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9j
b25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gPiBpZHgsDQo+ID4gIAkJ
CQkgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlLA0KPiA+ICAJCQkJICBzdHJ1Y3QgY21k
cV9wa3QgKmNtZHFfcGt0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmMNCj4gPiBpbmRleCAyYmZmZTQyNDU0NjYuLjc2ZTgzMmU0ODc1YSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtNDYsNiAr
NDYsNyBAQA0KPiA+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSKG92bCwgbikJCSgob3ZsKS0+
ZGF0YS0+YWRkciArDQo+ID4gMHgyMCAqIChuKSkNCj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxf
SERSX0FERFIob3ZsLCBuKQkJKChvdmwpLT5kYXRhLQ0KPiA+ID4gYWRkciArIDB4MjAgKiAobikg
KyAweDA0KQ0KPiA+IA0KPiA+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBu
KQkJKChvdmwpLT5kYXRhLQ0KPiA+ID4gYWRkciArIDB4MjAgKiAobikgKyAweDA4KQ0KPiA+IA0K
PiA+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9TRUNVUkUJCQkweDBmYzANCj4gPiAgDQo+ID4gICNk
ZWZpbmUgR01DX1RIUkVTSE9MRF9CSVRTCTE2DQo+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9I
SUdICSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkNCj4gPiBAQCAtMTI2LDggKzEyNywx
OSBAQCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsIHsNCj4gPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9v
dmxfZGF0YQkqZGF0YTsNCj4gPiAgCXZvaWQJCQkJKCp2YmxhbmtfY2IpKHZvaWQgKmRhdGEpOw0K
PiA+ICAJdm9pZAkJCQkqdmJsYW5rX2NiX2RhdGE7DQo+ID4gKwlyZXNvdXJjZV9zaXplX3QJCQly
ZWdzX3BhOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiArdTY0IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0
cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludA0KPiA+IGlkeCkNCj4gPiArew0K
PiA+ICsJaWYgKGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZMMCkNCj4gPiArCQlyZXR1cm4g
MVVMTCA8PCBDTURRX1NFQ19ESVNQX09WTDA7DQo+ID4gKwllbHNlIGlmIChjb21wLT5pZCA9PSBE
RFBfQ09NUE9ORU5UX09WTDEpDQo+ID4gKwkJcmV0dXJuIDFVTEwgPDwgQ01EUV9TRUNfRElTUF9P
VkwxOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMg
aXJxcmV0dXJuX3QgbXRrX2Rpc3Bfb3ZsX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9p
ZCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19kaXNwX292bCAqcHJpdiA9IGRldl9pZDsNCj4g
PiBAQCAtNDQ5LDggKzQ2MSwyMiBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiA+ICAJCQkgICAgICBESVNQX1JF
R19PVkxfU1JDX1NJWkUoaWR4KSk7DQo+ID4gIAltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9w
a3QsIG9mZnNldCwgJm92bC0+Y21kcV9yZWcsIG92bC0NCj4gPiA+IHJlZ3MsDQo+ID4gDQo+ID4g
IAkJCSAgICAgIERJU1BfUkVHX09WTF9PRkZTRVQoaWR4KSk7DQo+ID4gLQltdGtfZGRwX3dyaXRl
X3JlbGF4ZWQoY21kcV9wa3QsIGFkZHIsICZvdmwtPmNtZHFfcmVnLCBvdmwtDQo+ID4gPiByZWdz
LA0KPiA+IA0KPiA+IC0JCQkgICAgICBESVNQX1JFR19PVkxfQUREUihvdmwsIGlkeCkpOw0KPiA+
ICsNCj4gPiArCWlmIChzdGF0ZS0+cGVuZGluZy5pc19zZWMpIHsNCj4gPiArCQljb25zdCBzdHJ1
Y3QgZHJtX2Zvcm1hdF9pbmZvICpmbXRfaW5mbyA9DQo+ID4gZHJtX2Zvcm1hdF9pbmZvKGZtdCk7
DQo+ID4gKwkJdW5zaWduZWQgaW50IGJ1Zl9zaXplID0gKHBlbmRpbmctPmhlaWdodCAtIDEpICoN
Cj4gPiBwZW5kaW5nLT5waXRjaCArDQo+ID4gKwkJCQkJcGVuZGluZy0+d2lkdGggKiBmbXRfaW5m
by0NCj4gPiA+IGNwcFswXTsNCj4gPiANCj4gPiArDQo+ID4gKwkJbXRrX2RkcF93cml0ZV9tYXNr
KGNtZHFfcGt0LCBCSVQoaWR4KSwgJm92bC0+Y21kcV9yZWcsDQo+ID4gb3ZsLT5yZWdzLA0KPiA+
ICsJCQkJICAgRElTUF9SRUdfT1ZMX1NFQ1VSRSwgQklUKGlkeCkpOw0KPiA+ICsJCW10a19kZHBf
c2VjX3dyaXRlKGNtZHFfcGt0LCBvdmwtPnJlZ3NfcGEgKw0KPiA+IERJU1BfUkVHX09WTF9BRERS
KG92bCwgaWR4KSwNCj4gPiArCQkJCSAgcGVuZGluZy0+YWRkciwgQ01EUV9JV0NfSF8yX01WQSwg
MCwNCj4gPiBidWZfc2l6ZSwgMCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCW10a19kZHBfd3Jp
dGVfbWFzayhjbWRxX3BrdCwgMCwgJm92bC0+Y21kcV9yZWcsIG92bC0NCj4gPiA+IHJlZ3MsDQo+
ID4gDQo+ID4gKwkJCQkgICBESVNQX1JFR19PVkxfU0VDVVJFLCBCSVQoaWR4KSk7DQo+IA0KPiBX
aGF0J3MgdGhlIGZ1bmN0aW9uIG9mIHRoaXMgcmVnaXN0ZXI/IERvZXMgaXQgbWVhbnMgdGhhdCBs
YXllciBpcw0KPiBBQkxFDQo+IHRvIHJlYWQgc2VjdXJlIGJ1ZmZlcj8gQW5kIHRoaXMgcmVnaXN0
ZXIgY291bGQgYmUgY29udHJvbGxlZCBpbg0KPiBub3JtYWwNCj4gd29ybGQ/DQo+IA0KSHVtLi4u
IFllcywgYnV0IGl0IGFsc28gbmVlZCBzb21lIGNvbmZpZ3VyYXRpb24gaW4gVEVFIHdvcmxkLCB0
aGVuIGl0DQpjYW4gcmVhZCBzZWN1cmUgYnVmZmVyIG5vcm1hbGx5Lg0KDQpJJ2xsIHJlbW92ZSB0
aGlzIGFuZCBtb3ZlIGl0IHRvIHRoZSBURUUgc2lkZS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxp
bg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+ICsJCW10a19kZHBfd3JpdGVfcmVsYXhlZChj
bWRxX3BrdCwgYWRkciwgJm92bC0+Y21kcV9yZWcsDQo+ID4gb3ZsLT5yZWdzLA0KPiA+ICsJCQkJ
ICAgICAgRElTUF9SRUdfT1ZMX0FERFIob3ZsLCBpZHgpKTsNCj4gPiArCX0NCj4gPiAgDQo+ID4g
IAlpZiAoaXNfYWZiYykgew0KPiA+ICAJCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwg
aGRyX2FkZHIsICZvdmwtDQo+ID4gPiBjbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+IA0KPiA+IEBA
IC01MjksNiArNTU1LDcgQEAgc3RhdGljIGludCBtdGtfZGlzcF9vdmxfcHJvYmUoc3RydWN0DQo+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJfQ0KPiA+ICANCj4gPiAgCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gKwlwcml2
LT5yZWdzX3BhID0gcmVzLT5zdGFydDsNCj4gPiAgCXByaXYtPnJlZ3MgPSBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICAJaWYgKElTX0VSUihwcml2LT5yZWdzKSkgew0KPiA+
ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGlvcmVtYXAgb3ZsXG4iKTsNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4g
aW5kZXggNmJmNjM2Nzg1M2ZiLi4yOGEwYmNjZmIwYjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IEBAIC04Myw2
ICs4MywxOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG92bF9hZGFwdG9yX2NvbXBfbWF0Y2gNCj4g
PiBjb21wX21hdGNoZXNbT1ZMX0FEQVBUT1JfSURfTUFYXSA9IHsNCj4gPiAgCVtPVkxfQURBUFRP
Ul9FVEhEUjBdCT0geyBPVkxfQURBUFRPUl9UWVBFX0VUSERSLCAwIH0sDQo+ID4gIH07DQo+ID4g
IA0KPiA+ICtzdGF0aWMgY29uc3QgdTY0IG92bF9hZGFwdG9yX3NlY19wb3J0W10gPSB7DQo+ID4g
KwkxVUxMIDw8IENNRFFfU0VDX1ZETzFfRElTUF9SRE1BX0wwLA0KPiA+ICsJMVVMTCA8PCBDTURR
X1NFQ19WRE8xX0RJU1BfUkRNQV9MMSwNCj4gPiArCTFVTEwgPDwgQ01EUV9TRUNfVkRPMV9ESVNQ
X1JETUFfTDIsDQo+ID4gKwkxVUxMIDw8IENNRFFfU0VDX1ZETzFfRElTUF9SRE1BX0wzLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArdTY0IG10a19vdmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3RydWN0
IG10a19kZHBfY29tcCAqY29tcCwNCj4gPiB1bnNpZ25lZA0KPiA+IGludCBpZHgpDQo+ID4gK3sN
Cj4gPiArCXJldHVybiBvdmxfYWRhcHRvcl9zZWNfcG9ydFtpZHhdOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2
LCB1bnNpZ25lZCBpbnQNCj4gPiBpZHgsDQo+ID4gIAkJCQkgIHN0cnVjdCBtdGtfcGxhbmVfc3Rh
dGUgKnN0YXRlLA0KPiA+ICAJCQkJICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gaW5k
ZXggM2RjYTkzNmI5MTQzLi5lZWMzYTFjYzJlZDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiBAQCAtMzczLDYgKzM3Myw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9vdmwNCj4gPiA9DQo+
ID4gew0KPiA+ICAJLmJnY2xyX2luX29mZiA9IG10a19vdmxfYmdjbHJfaW5fb2ZmLA0KPiA+ICAJ
LmdldF9mb3JtYXRzID0gbXRrX292bF9nZXRfZm9ybWF0cywNCj4gPiAgCS5nZXRfbnVtX2Zvcm1h
dHMgPSBtdGtfb3ZsX2dldF9udW1fZm9ybWF0cywNCj4gPiArCS5nZXRfc2VjX3BvcnQgPSBtdGtf
b3ZsX2dldF9zZWNfcG9ydCwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9wb3N0bWFzayA9IHsNCj4gPiBAQCAtNDI0LDYgKzQy
NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzDQo+ID4gZGRwX292
bF9hZGFwdG9yID0gew0KPiA+ICAJLnJlbW92ZSA9IG10a19vdmxfYWRhcHRvcl9yZW1vdmVfY29t
cCwNCj4gPiAgCS5nZXRfZm9ybWF0cyA9IG10a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0cywNCj4g
PiAgCS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRzLA0K
PiA+ICsJLmdldF9zZWNfcG9ydCA9IG10a19vdmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQsDQo+ID4g
IH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9z
dGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0NCj4gPiA9DQo+ID4gew0K
