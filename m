Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751B7D4576
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJXC3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:29:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09CCF9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:29:06 -0700 (PDT)
X-UUID: 1720c52c721511eea33bb35ae8d461a2-20231024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=Sqj+G+MbLQQWo0nLdwcyqAjwFMXJ6ZftgHGCIgSU2Ic=;
        b=DT2EMFBBjm+kpgFKnWM1lU9beziy3AanhMILOjr7+JaZ9I4zWvpJcSAXP5F0CsMl5IebL8wrTZAlhLo5YHj+I5Nk/Od/l9CZUF78dyCmjikKRwWxTGR98DGdmefwWaRAjE5VEXe3v0tDQbbGBY1j0oTvHbiWKQkaZCB8KVzvOAM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6558322d-cf29-4b73-a86c-9a4b7a414968,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:93d6d328-cb22-4fa7-8134-287af20ad1fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1720c52c721511eea33bb35ae8d461a2-20231024
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 386232157; Tue, 24 Oct 2023 10:29:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Oct 2023 10:28:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Oct 2023 10:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdvzecYeWKNAIT87CK2DWGFMlVEqiZLpPASpDbN5cnrqqnn/IIR5MbQBWF0g0cNdEVXCgK+w38T8kp0uE3fK1wj8HPc3s6MpxXT3UvSmZUSUqyy6eyFyxgbV3+DXXI3C4Cv3KBeaLTZKdO5htJkudYrvt5qiJu7kC4PK4hIget3wCDI6MHrDufJIystZPCHFUAsujqcgRH65YM7Y38uMG4uED/xX27PrL0G6tAui9nBA7mfiEm+qMfbfYBu/RHobxQA1v1cwiJh2kUetsQGWhmlSrxGLFDbLhCTFpLcBVFsfwdEvjnmCkB2yzCpCl+h+oKW6vORUm2fgAFHb8jFURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqj+G+MbLQQWo0nLdwcyqAjwFMXJ6ZftgHGCIgSU2Ic=;
 b=n5w1DqR1OKBXkX07ajzuse8LTmjtZSuEysUgu9UoHSOY+03TPLs4ft6RmzSaM4njgmitDzAmyL1mydwx1zWxBI8WGzpLRD6IaR3QK0DLJLOiGhNHAqARX3zic9QiQ8gxoEUWzJ6qilUe429XCkndq3qSQ1p5JhQsIyrUn48l1tg4FrU2+6FXra7tW3Sadb+heLe9VgA025wfN2FkFBq47VJdrNj+1jF/B4TYB1gRNQHL9Jz+LbS/fE62PL8wMK645y7vt/WsawOsabDDRVBl52La0y1OiqR+0qb5f95f4L999DoMmsSVzz4bg65W6LrGXLs2ReV+3Ht1FGvQYLCsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqj+G+MbLQQWo0nLdwcyqAjwFMXJ6ZftgHGCIgSU2Ic=;
 b=mJ1uMY1KK/SI2Yr/ueAtygLcLNeI5SPmew6qHskKqpmp/oTo0qsqA3fEzgN6y9CxuQQnG3SzM3G8FZTDceA6vo52ncBQ81LS43bs9wakVYuhU+cK6WX743gzZmYY8mAWu6N729sy1+h1g+MExGYf2y5t7jJ6wxo7gKd948voHDU=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB5472.apcprd03.prod.outlook.com (2603:1096:400:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 02:28:57 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::3b6f:e1e1:39de:3920]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::3b6f:e1e1:39de:3920%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:28:57 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt7986: remove redundant remove
 function
Thread-Topic: [PATCH 1/2] ASoC: mediatek: mt7986: remove redundant remove
 function
Thread-Index: AQHaBZcHTDomkVMJ90WT9yEA3tSasLBXNusAgAEBkwA=
Date:   Tue, 24 Oct 2023 02:28:57 +0000
Message-ID: <b5fa38585cef3739b0672cb73c71beed2d3f2cf5.camel@mediatek.com>
References: <20231023095453.4860-1-maso.huang@mediatek.com>
         <20231023095453.4860-2-maso.huang@mediatek.com>
         <07af235a-c6d5-4d8d-9b44-ff7157e2a80c@collabora.com>
In-Reply-To: <07af235a-c6d5-4d8d-9b44-ff7157e2a80c@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB5472:EE_
x-ms-office365-filtering-correlation-id: a0cbf48e-7625-49fc-e7eb-08dbd438f967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eoRExX0JUGmQHJ7W56Mg9kD1lzPqOIZxjCVL0sQoRsZZwu6raFj55t+g9ttu3ey6jIdERXNnBA5rtfedvVWrLMywRzAR4nUXD2oaDMzlehzfY5SCC8WZwLFNv6mqEaCbiM8GE86BBPnAae9pMkvYveYEVFVzdNYtHe7tjqvoaQeFa/wIrfwIAtaYSmqtX1Px5kVnLeQTkxf8YGldzWehN7eFjn6BiPCEi382C/9D2+IV06NhuCL3ipgPwWreYbLKnLwiDc1eqjrSRoNdOJQtSpDUL2rS69FKr3O7YV85Vw0PVySAvTtlk6pxZfTv8+X0AqsbCG5u3PTZ4Inuqp5EPE122DQEMUNKpwajht0YqXTP3dNC5QGaHuDsd1ET4ySSM3GiMAiIrfv6ffsdSIyWyzBamYDGhlKQ6LVObZaTxwUytGIIw45HaOqbMQIQI6gpoNPtFQGDFwP2k35jBaDPSvu/3uCypVVTMLI6GkHOm3rL7QZWDQIAc0ymHIz1bvpmriyQqYL6pFBJkAOkrXMrObm+Yy7z1I9Qk9AAVP+KLy5V+HKv8ERehmyibXJcUGf/irdFi0nox3EwaHAmnptFpCfw28+cD9clHgUxtMlOjK3/DiHXik8XSkWi8JkiGbEzrrtn43ZjNquxyKWpsIKtAGWUtWqWTJmm+cZqi5C+4YwEyl/JOeOD+NHGLMgT8FVH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(921008)(2616005)(6506007)(6512007)(38100700002)(122000001)(86362001)(85182001)(36756003)(26005)(41300700001)(2906002)(4744005)(7416002)(71200400001)(8936002)(4001150100001)(6486002)(478600001)(8676002)(66556008)(5660300002)(64756008)(66476007)(66446008)(316002)(66946007)(91956017)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHQ0RjNhOWFKc1BNb3BrWXVVeWhFaVVWRno4WTVvMmkvRkprOWp1bVVocjA0?=
 =?utf-8?B?ZHp2cU1lSHUrbUhiYUVGTnNNZzZSd2JmM3ZpNHNFSGpZMGU5TE1tWW9ZVmd6?=
 =?utf-8?B?QzFPOUlvRjB5OHJmWUxTSUtzelg3aDA0M0t3Wk5zMmhxNytmY0FCWG8vdFN4?=
 =?utf-8?B?QWdUdzZmNHFZaVR1c1Vya1dINVNxcG40TGI4RUNsRnh4R0RPbkkvaHJNSWxm?=
 =?utf-8?B?MXBwTkhvZmlucGR0bVVqNjJZdUVTSnBleFRCd0ZPSHdVbGJKM1NoL0h3QVdh?=
 =?utf-8?B?MER1WUptN281aXYvOUd5ZER3eWlRK2RiOStnNGZmcFhza08rYllYTnkwcG1z?=
 =?utf-8?B?am1LV3VkMm8zWjk3MUxHRU1NQ0FJcXNCZkpUazMxZm5zVXJzYlg1QjY1VjNU?=
 =?utf-8?B?NXBXeVhaa05qWXFPS0pBbko5WjRLQ3BDR0dtWERieTl4aC9zeHN6Y2hJK0I0?=
 =?utf-8?B?Z0pDVFZER2JVN05BOXVZc3liOVJxN1BMeG0wSTg2TktWODd5ZEhPZ2pzQ3Qv?=
 =?utf-8?B?ME1kQ2V6ODRaTENGSGJFTDkwZHc0eHp6Ti9jWHNtdm0zN3VVM0xod0hDbWxR?=
 =?utf-8?B?Ykk3VHRyTG1FU09LMFg2WDBOTjlRaWtrK1JNN1pkQXRHditmbG9UbSswa0hk?=
 =?utf-8?B?Q01UcXlldjFuc2g0Szl4WjhiYVVmbXNqdzY3T28vb2J3NkFFNDJyVDhCaUx2?=
 =?utf-8?B?V0lkNE9oNUpMZXQ3S0U2SDdWM2owVERjTkZvUU9xUUJTa0R3UWpEa2dmQzZQ?=
 =?utf-8?B?T0J0T2t4SzVZSE9VZXMwNkZ0WEpZWVVHQ2Yvd1daVU92TzZkWHh2MmM2REJP?=
 =?utf-8?B?M1RPaGpqQVo0SmtoaVVUQ1E5VkhxL2d2NHk3Y01PMkdCblJidmFVMXIxMktW?=
 =?utf-8?B?dDZjN2Y5T2xVTGtRTUxUWVJDVzJMbzhabE9sWCt2S2xRUmlTOGhnbGdIdlZk?=
 =?utf-8?B?R2xhelZFSTRhdDFLZk1UcENnaFZQVGtWa2N1RmRmczlJL1R6b3RkMUFyK2hh?=
 =?utf-8?B?eHRrSko4SVg0Ump5NklMU1QxeDFsSEZ0bkVhSkN6VTRKa2JONFRHMDlPM25k?=
 =?utf-8?B?Y1dCUVBJcEFad3VzaGN4N0RseUVEWFlhRDd2bEhDMXhpc1FkUmR4NzJMU0ph?=
 =?utf-8?B?VlJLL0ExMFZEWXl4N3dKb05sZFV2dGZkc2FDbzJYNEc4U1lZb1JuSVZqa3dx?=
 =?utf-8?B?VXFyY1pyS0FmcGJjRkRnclBGUkNjUnRWYnBuanJ6dWxZV1FKQVpUa0hSVE5Y?=
 =?utf-8?B?VHVkU21GVmJHVnlreHRMbE5PbUNZMWprME5JeDFzM3MzN1RNaWxCT0JIbjYy?=
 =?utf-8?B?ck9KTUdEM0kwVHN2dG90OWNOWXVsbm8xaENsSGxTalplczBRN212SEs0Qm5M?=
 =?utf-8?B?QzFsdnlxZFFIeWpaWGNYWTYwZWx0OHVubGpnMko2ZWdwalhmRmU3YXRvMDB6?=
 =?utf-8?B?LzdKRXdvcDhEeVozTVZhbVpCOVdNL0hXNFY0dk9neVVCV1RhMUZsaHpsWHZ0?=
 =?utf-8?B?bVlTcXFzb3l3aUpkcm40c1RnS1gzR2Z2alZ2RDhLQytDeXAxVHZUODZtTDRM?=
 =?utf-8?B?WWtVYTgxMHR4QVNBL0k1R25mb0l2ejVwUmlHZUtRNlJ4VWd1emZFamo0ZTl3?=
 =?utf-8?B?UVA5UTV2TEFrNEE0NmVsS3cxWk1BRHlnMVFaVWlHUWdqYzNjTmRLOG8zSUlI?=
 =?utf-8?B?eUJMRWdGV2VPaTdsZ0RsT0JKWndpQmJXbVI1M2dLaFNlRkRMU1htcGEzNktI?=
 =?utf-8?B?ZmpDd1VhdFJOeVFQOVNuNEhGRERaUFJTRkNVbDV3OUhhS2NlWHFDaUlFYlRN?=
 =?utf-8?B?NE55QlY3MmZZY215R0hYZzI4aEplMjRCTE9QS1hmRVdpekNjckdWL0QwbVM4?=
 =?utf-8?B?MXJIdjEzSVg0aXBHTjlFaDZHdUtWanNGcnp5QUVnNm5ndCtOWGp3bDR5OENi?=
 =?utf-8?B?aW1wanVveEhQN0sxbEZoVGdHalRJRzhITGlKdjQ2aXlzcFM5ZjROR1FRbVFE?=
 =?utf-8?B?cTdaUEJjWHZTdW5wRVZKWkhaNjA1TitOTTBUaVMyTmFTWTdxbFNBWUxCVFhX?=
 =?utf-8?B?WWRLamJxQXluUk9OVkpCd3gvOWxHUGRORWhoOTJYcEVZVmR1WXZOTjUxZXZl?=
 =?utf-8?B?V0VEcWNPQXZnZURUT0pHSFFxQXJJdWxTWWwzaGZWbjA4RmJnbTB6RGh4b3hu?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E18CB1613595A40A72441AC5DDA76D8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cbf48e-7625-49fc-e7eb-08dbd438f967
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 02:28:57.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOqy1THaDMpH3k+cabllXgs5pKtt+AK3K6Eu91I7JcAtfUF7l5LKyRg/CuIk1TOshxdATI0xzu5YnO1iJCn77Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5472
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.226900-8.000000
X-TMASE-MatchedRID: qEAy/z09Hq3UL3YCMmnG4t7SWiiWSV/1YefZ7F9kLgsNcckEPxfz2Iqe
        hz/PsL8GrvuhYKtRRDX89WDKQGB2LrUN8Yzp1vtfVU3yVpaj3QxQCOsAlaxN79zOQo7mTgA+qAX
        wsdh85gYezXDyBkGT+fnayvLb8IJKNyl1nd9CIt3SBVVc2BozSpwhktVkBBrQgqm22sIY9Fzakj
        6FuUTADwtuKBGekqUpOlxBO2IcOBZSECZkSqUZXRN1Uw20sf4ZVXxyrHoowlNU7phUxqJEvbXj1
        5XMF9Rz
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.226900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: EFC087BD6640D02A5E3051A8227999CC1D7E99C81F24FF977ABC54718B148ECD2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDEzOjA3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjMvMTAvMjMgMTE6NTQsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBSZW1vdmUgcmVkdW5kYW50IHJlbW92ZSBmdW5jdGlvbiBvZiBtdDc5ODYtd204OTYwLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gWW91J3JlIGRvaW5nIG1vcmUgdGhhbiB3aGF0IHlvdSdyZSBhZHZlcnRpc2lu
ZzsgeW91IGFyZToNCj4gDQo+IDEuIERyb3BwaW5nIHRoZSByZW1vdmUgY2FsbGJhY2s7IGFuZA0K
PiAyLiBSZW1vdmluZyB0aGUgbXQ3OTg2X3dtODk2MF9wcml2IHN0cnVjdHVyZQ0KPiANCj4gWW91
IGNhbiBkbyB0aGF0IGluIG9uZSBzaW5nbGUgY29tbWl0IGlmIHlvdSByZWFsbHkgd2FudCB0bywg
YnV0IHlvdQ0KPiBoYXZlIHRvDQo+IHVzZSB0aGUgYXBwcm9wcmlhdGUgY29tbWl0IHRpdGxlIGFu
ZCBkZXNjcmlwdGlvbiwgc2F5aW5nIGV4YWN0bHkgd2hhdA0KPiB5b3UncmUgZG9pbmcuDQo+IA0K
PiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZvciB5b3Vy
IHJldmlldyENCkknbGwgZGV2aWRlIGludG8gdHdvIHdpdGggYXBwcm9wcmlhdGUgdGl0bGUgYW5k
IGRlc2NyaXB0aW9uIGluIHYyLg0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQo=
