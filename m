Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA947D61B5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjJYGdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJYGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:33:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84452B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:33:38 -0700 (PDT)
X-UUID: 699ba812730011eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qxl90rvwVESFLcweq3rabjetKFGkkkbMNsR5/Te4zvM=;
        b=ITHhDRxr+qL+aWacd6MN7XEx2vIz5Wf/WVSl2bxM3rfQm7pnWidXrBaPLSNzywvK+6gDp2IQwYX5d44uAsKpu79TtlQmXct2H+5KKkzYmBCeNy/+Kz8zxpJgumv8jziOdQ4dmCgxMsK05fAUfhNJM9P3zwdLLzBfj+9jvmrVx3Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2b1513e9-4e4c-4975-af50-189e271a9aa0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8610bffb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 699ba812730011eea33bb35ae8d461a2-20231025
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 18213643; Wed, 25 Oct 2023 14:33:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 14:33:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 14:33:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ectnXAn43ILv5QTdPLvCsRkBFz7UuLUtOCkIsfWKpoty4T8v7yqJfFf12NCZtAVn2kImEKkOqOuYUKcPRVGtXO2pP+JXbIeAAMRnoXgfrYT0JNCKYVTRq5bknTSJca6jIxYdg6ePviwwVYt6xGPsYxEpklF03mgt9c3EownJyD6iO5WQo3UXISsqMlPllzQLyY43fOieFpBGNzeO1ETSENDukTQa7Qw4ahpBhUiZq6u54a9Hetc0WGtNjM5DW+WFvtlXS+pf7vcDNSpE2tCu7tiHXmNtzNTWIHUaHz+Q0axgfbj4FWti9N9AVk5/Kg6XQfZ27gUd6cCL2agI7TAN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxl90rvwVESFLcweq3rabjetKFGkkkbMNsR5/Te4zvM=;
 b=ZsvtmjXg3CdgMpmmB3A3r91LAMEbDuOz7BH9j3ZBOVnWXwRFYjTt2x8AcIP5mw1Xlleop/9MdOTq87vfQu3mmUbZpoFiQsLSxTI0XrrHbykmgc4Or/Nn3uaBkpwHVyjVVuTc/4eZfZMMaJSIoOkT1d4K8BdRFJ3l/F6wdiKSmR9e7F9Pr2hTqa33B0hNjtOlsmdZUrEG/TwO/gPCBmS9aBkpIlq29CRBsCJl8Xq94UdbbtlXfKm5oTiD+gkypYP8L3xq0HJjM54dARiWuxj8WD1ik2VtPMrprHFthnVciyEnsnFy51xtSu0l1U8esa4FimwdSVYBeFJ64gtzeRJbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxl90rvwVESFLcweq3rabjetKFGkkkbMNsR5/Te4zvM=;
 b=FJjsO2CBizCOuxNEdZ5fLskb5FlF+FWTw9fE8sw7C73Be26inCbj2cdDHv2zmnxdCs7YEn6C/CwupC7I8eR7XmpzaRSx3KoJ53tuxSI/9ZhZug/W9k6fMBQb9dJKkIXRvJXDFj0mGD2mT2VsD6Jyzp5OI1ktuRJ7dLLUFrwiyX8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PUZPR03MB7236.apcprd03.prod.outlook.com (2603:1096:301:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 06:33:27 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 06:33:26 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Thread-Topic: [PATCH v2 6/9] mailbox: mediatek: Add CMDQ driver support for
 mt8188
Thread-Index: AQHaBWq/XPFSvwiV4EiHOg1D0weMn7BXH2GAgALwGgA=
Date:   Wed, 25 Oct 2023 06:33:26 +0000
Message-ID: <92653ade9e0a31b41fd654449f007d41f7e7aa54.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-7-jason-jh.lin@mediatek.com>
         <CAC=S1njt-esHwUEr4O5BVUmmgpB=Gm084h+tY-KsKp9LkPXNBQ@mail.gmail.com>
In-Reply-To: <CAC=S1njt-esHwUEr4O5BVUmmgpB=Gm084h+tY-KsKp9LkPXNBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PUZPR03MB7236:EE_
x-ms-office365-filtering-correlation-id: b83bf9ca-c5b3-402c-2a10-08dbd5244bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pAMmn09FM7Mq69cbN9o75p/KQofTW/7UNoP+xq83A9196VkBIldXuC+MBudoumZjaRYYFA9TSt1DKh5Jpz6GsOzyWIdp/SN212Bt/DxDy5/nmWPShtbMmn9uZUB7jsGtu1KkHlCywx2oa5pBe1caNAP12RgXzfFCfz3OLtPbXkKrXHpyT4wuouY/QQ7lfQFj2+h5uC4C4hevlmZzK7J/BR8Mgo3MPqFPK2qxIOdX+M6gBCnvYKsYX7AmmAzgs441YKgZDu9mx99IPJ5PxKfRhb4BQyV6xb6q3NjQNBmm1EGfpUJ2uP9kgukXYSDUHY5FMCyBHgAmmGERP3z7f2YrjxaKRgF98eBrlu1C4uE1KHoJFZESk8aQ5HhnG5tVq59oLttO42+O1u7Len4xGmcHqOdZthmTl80KTS/BW2oGk3USc0f9oIa8SQvn9SWmz4x5EL10qV5l/gyuBfEtfF3+nlXRkOVC85ydZpIejEE8MgYvjKW+dcE4Xrtvq1JMoSnVwwxo7JYHDT3Nd9x2ImfTTzJB9XrHF1QfBeboleD84Y38vvoQpjiHqC8sBvnuFZBElZyAae5RVmH+KLcDxYWE74yd80GGYHXjAO67kXf2DJiuczDISUOpneugCTQRRhvMI8O/LKi27HT522oRQrMBHRQmf/X97fx8/0g0k63/boI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4001150100001)(83380400001)(6486002)(91956017)(316002)(76116006)(7416002)(64756008)(66476007)(478600001)(66946007)(66446008)(66556008)(54906003)(6916009)(8676002)(4326008)(8936002)(122000001)(38070700009)(71200400001)(5660300002)(6506007)(53546011)(86362001)(2906002)(6512007)(38100700002)(26005)(36756003)(85182001)(41300700001)(15650500001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWlkeTNNMjhUemR4bktvWEJrVVc1WndQc0R4cUNJSzVzczZndHRyN2pub21Z?=
 =?utf-8?B?ZFBmdzQ2ZUZQM2ZxQ0M1SGsyTEl1VDdrMGFqcHBwckZVc29scE1meXJSRUNP?=
 =?utf-8?B?ckR2QXA4YUdLQnN6YWRTWXU0S3RLQWRDbndzVnhsMVRXa0gxaDk5U0dpTm5x?=
 =?utf-8?B?aHphYzUxYXVEWmh5OTE0bFFVOTN4Y3RiSHZKVEM1NHF3bXd1bUIzcENtSjI3?=
 =?utf-8?B?YkhUY2hBTlhjQ1kwMFpBaG9IRmZtbkdmQVd1c1BxZXlQQzVKOGh4NHF5UGNu?=
 =?utf-8?B?eXh3Znp2VDJGVUp0MGRXZVJLNnpIOEhobU45Wks2M1M2WXAxRncvN0dCbU1M?=
 =?utf-8?B?LzczVEpRbGZxUDR5RzBHVStwSHZiTkJ0Z1hQeTM3WDF1aDNwdFpQLzRkajE1?=
 =?utf-8?B?ajJLVHFnNlkxWW1DOXJ1Y2lORU9RQnR2c3JBUmZyZzJjSGZVb2JiaTVhQVBh?=
 =?utf-8?B?bUZMc0FSMFpUNmhLdW50WDBQb3JnekdYcktMOTduejJXellQVjlRWUhoVVZW?=
 =?utf-8?B?YlZaYktvMUNIOG5yZzd1MThtR0Q4N0ZJMmZXQnp2dGplbkx4VnpNS2c1RVlW?=
 =?utf-8?B?TjFIdUZXN2dXQlFDK1lEZmVxY3U0NnRmVVNyb1lNczNMRGg4ekxqUEpjTThH?=
 =?utf-8?B?c1ozOFhwVllnaE10N2dmRE43NTIvcW84Z3RmV3hZVUczSTlMYysyRjlkbGN6?=
 =?utf-8?B?T2ROTGoyUTllaUo0a2g3RjU0ZVJnVXVnelc1UmIrVHNoUk5sdnZoZW9mSGhm?=
 =?utf-8?B?dndKRDZsZXgyWTVEQk1qWCtZSWlTRFdkQ1RTTTQwanc4c08wbVloa2ZCZVJN?=
 =?utf-8?B?TTRhdUlZOXgrVzg5Rm84ZEpCaHVibzZPcENCUkVrRksvQkRTOUJSeE0wZWt1?=
 =?utf-8?B?V1RLajR2RkQzRzMzbnVhL0dSdHpmVmdreGVLb3V2YmdYc3F2dUsyRU90N255?=
 =?utf-8?B?SFJQNkFYNHE2bmVVeEdZY2N0Y3g1L1drcDhhTWNlZS9QWk1udXN4d1BCYU1M?=
 =?utf-8?B?ZXJCOGFXK1VjWGNXZzJ3dVZtS001cUxHVlI4cXNhdG00OUNhVDFaeXBpdkpN?=
 =?utf-8?B?NW4ySzVXREtxR3BsUGIrMTg3b0YvMEtuUHNNTlpOeVh4MHYzTWFVUXphV2xG?=
 =?utf-8?B?dEJ1Z2srSGlPUTcyazNWbHJsUWFTSllQV0d6TE1rbTRKaCtpTEhEbjRnMUI2?=
 =?utf-8?B?VmVWMWxINk10YzVscm05cUtUYlhrZWZTblRlY00vTCtJNzVWMzR4YzJydU9I?=
 =?utf-8?B?emNtWDZRM0EzWGxGdkhKT1hYL2ZZSjNwbU9YaWdjNytMUkMwMDdOT1VoV0Rk?=
 =?utf-8?B?Q0VKWnNmUGFFaHE2M3c3Q1JtekdHVmMzVHpjS2cyM2FMOUNOd2J1QzlNOWJ0?=
 =?utf-8?B?eWxyT2tvc2RhU2Y0VE03aHU4dU5nZDkxbTFpN3U5TzJRUDd0b2NhWFgyR3Zl?=
 =?utf-8?B?ME1IenJYTnlzOEtPRUgwNHJTYk1XeUVvdEZOTWVCMnVOQXZROElVWUVGUXNh?=
 =?utf-8?B?YVZ2c0pQOHlzdGYvVWl0TWYvMzZialVGRWVWQTdJY2xqRWh6a2g0N0tVQ3RT?=
 =?utf-8?B?TmtiYWtPYThwL1g2eFFXVkhJWEJ0Sy9XQ29MM21uampEUzhUT2FuR25yYjU4?=
 =?utf-8?B?eXZiaURPRHIwbjBNd3ppSGgwRy9KQ0VUU2xhMFh3ajB3VU9wa2x1UEIxNDZY?=
 =?utf-8?B?SEhSaG5rL09UQkZ6VExxd0RiWms2ODhSeVlJd0g5eHZzeWppZEFTYmtJNXBq?=
 =?utf-8?B?L0VmRTAzeGNJR0YyUnJDMG4zcU8zejR6aGVGOUpQZUlLYTlUSkRaVitRcXdp?=
 =?utf-8?B?emdmUndQSVBqNzBJYkdESHJqWXdDTEluYjB6elZRTVlQWkVRVzU5SXFCNS9C?=
 =?utf-8?B?MEdVeGVJUXB0NlFpSXRENjlPUzFLbnpzcERlOGtHZjVibHlIUHZzQWR5NmtV?=
 =?utf-8?B?ZmI1dE41KzNHTHhZVURpb0dJNlgzOUNUN0trVXdzWW02alIrUkQvTzJLRVJW?=
 =?utf-8?B?emJwcFlYeG8xc2VZLzdhTE1FeGt2QVR4cG5NdjZLTHlweEljbitXL0NpK1gy?=
 =?utf-8?B?bmRDQ21Bc0RheEhDVnNvcTJwd3BFYnJCQk1WYitWUGwwZU50RlBNYndGcG5m?=
 =?utf-8?B?SEMybFdpSHdxUXdaa3VUUmFlRlJkZlV2cDNiTnBQaFBHamJwcTI1U0xwOW9m?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5AFB96CD44BAD47BA8AC237D2E568A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83bf9ca-c5b3-402c-2a10-08dbd5244bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 06:33:26.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBafqFCppeqlfuLQzstaYTsEENFH/sLL4tp7twnIkejCOPtc0k9NvWdJN53yTWTRFAnHk65lZC2YFZTMngV2UPWSGynTxZTGCIYscIFNx6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7236
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.571400-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvinykMun0J1wmjZ8q/Oc1nA+WzVGPiSY8gNcckEPxfz2DEU
        xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CzojsJ+zYaKNZ722hDqHosTT/d
        mRd5jU4ACS/VWijN+cJiZJN9vH+EekKjL2IOi2LCQOktEo73GFAK+PiKSv+mnyOaFHxibaSsz6n
        42mzBmaq4E78t0Np88a+O6hBaht7omek8QIa7UrsDORqgKKiYqjI6qXkf2FQ2IlH0NRaWl1ehZl
        z9w7V5gE2YAi4tcHVGZ4TZMmYnlrxgHZ8655DOP0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
        Xd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.571400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A0D2A0D8B097096DBF69DDB4ABDCF2E58D2191FFF068ADE7913B6BE80D2CE9F32000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVpLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAtMjMg
YXQgMTc6NDEgKzA4MDAsIEZlaSBTaGFvIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIEphc29u
LA0KPiANCj4gT24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMTI6NTjigK9QTSBKYXNvbi1KSC5MaW4g
PA0KPiBqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBDTURR
IGRyaXZlciBzdXBwb3J0IGZvciBtdDgxODggYnkgYWRkaW5nIGl0cyBjb21wYXRpYmxlIGFuZA0K
PiA+IGRyaXZlciBkYXRhIGluIENNRFEgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gPiBpbmRleCA1NmZlMDFjZDk3MzEuLjNiZGZiOWE2MDYxNCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IEBAIC03MDQsMTIgKzcwNCwy
MCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y3ID0gew0KPiA+ICAg
ICAgICAgLmdjZV9udW0gPSAxDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBnY2VfcGxhdCBnY2VfcGxhdF92OCA9IHsNCj4gPiArICAgICAgIC50aHJlYWRfbnIgPSAzMiwN
Cj4gPiArICAgICAgIC5zaGlmdCA9IDMsDQo+ID4gKyAgICAgICAuY29udHJvbF9ieV9zdyA9IHRy
dWUsDQo+ID4gKyAgICAgICAuZ2NlX251bSA9IDINCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10gPSB7DQo+ID4gICAgICAg
ICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4g
KikmZ2NlX3BsYXRfdjJ9LA0KPiA+ICAgICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3YzfSwNCj4gPiAgICAgICAg
IHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAq
KSZnY2VfcGxhdF92N30sDQo+ID4gICAgICAgICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2
Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfdjR9LA0KPiA+ICAgICAgICAg
ey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICop
JmdjZV9wbGF0X3Y1fSwNCj4gPiArICAgICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODgtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92OH0sDQo+IEkgZ3Vlc3MgSSB1
bmRlcnN0YW5kIHlvdXIgaW50ZW50aW9uIGhlcmUuLi4gYnV0IHRoZSBvcmRlcmluZyBkb2Vzbid0
DQo+IG1ha2Ugc2Vuc2UgdG8gbW9zdCBwZW9wbGUuIFB1dCB0aGlzIGxpbmUgYWZ0ZXIgbXQ4MTg2
Lg0KPiANCj4gSXQncyB1cCB0byB5b3UgdG8gaWdub3JlIHRoZSBvdXRsaWVyIG10Njc3OSBmb3Ig
bm93IG9yIHNlbmQgYQ0KPiBzZXBhcmF0ZQ0KPiBwYXRjaCB0byBmdWxseSBzb3J0IHRoZSBsaXN0
IGJ5IHRoZSBjb21wYXRpYmxlIHN0cmluZ3MuDQo+IA0KPiBSZWdhcmRzLA0KPiBGZWkNCj4gDQoN
CkknbGwgbW92ZSB0aGlzIHBhdGNoIG91dCBvZiB0aGUgc2VjdXJlIGNtZHEgc2VyaWVzIGFuZCBm
aXggdGhlIHNvcnRpbmcNCnByb2JsZW0uIFRoYW5rcyENCg0KUmVnYXJkcywNCkphc29uLUpILkxp
bg0KDQo+IA0KPiA+ICAgICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1nY2Ui
LCAuZGF0YSA9ICh2b2lkDQo+ICopJmdjZV9wbGF0X3Y2fSwNCj4gPiAgICAgICAgIHt9DQo+ID4g
IH07DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPg0KPiA+DQo=
