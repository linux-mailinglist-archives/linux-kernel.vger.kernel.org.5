Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3917BB2BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjJFH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJFH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:58:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5189E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 00:58:25 -0700 (PDT)
X-UUID: 1d9702ea641e11eea33bb35ae8d461a2-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=V67rrdxp0znrJhyFKDuXvyzxzHy8v0eJP0cAbyRX5VM=;
        b=oHeWBOAy+1BGax5MXQ2qoeMdRw3h18PVlGYEjsZPXUNG04I6oRNv6vSx1eJ3V/V9zvFwNafJXmyEbWZHUn31ovp/0CYWdr22CVbwdZ9bMnJtzhsAR5+tftNFHHWGEX9pfzCGOdwepAP541xbiEvwFG8ubkDtou/izcnEip5szTc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:aafa0043-0f95-4cdd-9fbe-111896f826c4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:301583f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1d9702ea641e11eea33bb35ae8d461a2-20231006
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1898631282; Fri, 06 Oct 2023 15:58:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 15:58:18 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 15:58:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHoJSqy3ilc7Pz/w1JpX+VhrFFpu0NKasmABJeQwRRxGlM3sTJTk8pOdw4GaOsOj54TVKqoqRWy7yvz0enXhW7qQdmp3B3vIz2A3ll1hzhAfvSVpTwqAJV9hsWxGA1UiaAptYz45Y08AYw/40miw54eMQ187h6vqmwEEdc6AiKsazeZW9z6G5C8bSdtawotNDANJAff4ULNRZMMmcArdKTeFqynqA3/IDCEVdP2w9QbZx5Jx+TMqF56vRZd6/zlYcS7UFaU9uV5UOBfniC9kiepwp9xF/YIqRJYf7iaGmGrp4Bz0jBqfr/l+OnAoqEAJBHGGL5kEUwW3WSofnCrhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V67rrdxp0znrJhyFKDuXvyzxzHy8v0eJP0cAbyRX5VM=;
 b=ehkzbEYP/sDB0gc7vhGR5xNMSE2EuGclt8PW57gjxpCwaC+TcOB6CDmbp3n1Xb424eLylwJIS5B/zvX1gc/V74KcOCcKjSTUmcTpaC1f0dOReZcZVtu5NfQ64O0oFBbXR0vD+E6zV/covlYMSH22aCwX/REJ/LgryBf6/jZz/YSwAOwTuIf3vpaKKzycA535SkK3tzeEVxZpDY5Hlmi3IH0GUW8CZANV1oP6a/upc6F1wv4WcSYeOMzLE9eLkfTjnntxj1yhqkN03WKt3XX/E/0WZs/dNyGlnmn6+f/QtvwF8xMT4bewzETkYf0wh16DYCNRAEUq2d2QzUBmZESPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V67rrdxp0znrJhyFKDuXvyzxzHy8v0eJP0cAbyRX5VM=;
 b=b00frSfljhEO5iVOyv4pzv1VwY97LS/4xKPLhHl736snFEnCSdx2Mbs7wWs13y4qDjnozdEUMj7/s8+Gzq5E/Q/gjX6f+4BKbR2sA28pOCEy7TWyCJA466ZZZ4Umo/nwyi3USxiWH/wzR0RIzmLUw5IDpTVB2t8ewBDK/dFNsBY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8182.apcprd03.prod.outlook.com (2603:1096:101:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 07:58:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 07:58:13 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v11 8/9] drm/mediatek: dsi: Support dynamic connector
 selection
Thread-Topic: [PATCH v11 8/9] drm/mediatek: dsi: Support dynamic connector
 selection
Thread-Index: AQHZ9mwyeDgYuHec0U+brPwCdyDOoLA8aN2A
Date:   Fri, 6 Oct 2023 07:58:13 +0000
Message-ID: <cc73ca5c65a5cec24028af84ec67ff16469b21dd.camel@mediatek.com>
References: <20231004024013.18956-1-jason-jh.lin@mediatek.com>
         <20231004024013.18956-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231004024013.18956-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8182:EE_
x-ms-office365-filtering-correlation-id: 1c830dad-3142-41a4-d99a-08dbc641fdd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJzjvh+UvOYZOpROw+opOaDk0Z1ppRqUk5PbXKgyt6IwTibm0WqROJ+9+gDO+c+FkjHajcoP3BWlnwRRhkYT3ixd6c/mvZWr1XxASS5rFDCzbgm6oOfrHrcxP0IBy0bHRkxIOrgWS9gK5xLOboujLHqs7/fHwWsECnLc8v9M1YVY7hAYorzw/swRaI9MMjTWC2QwydE1G1PdoNgbrsOOQgfUoOp6prwmv558h80rGPNNaOc5ef5uu3rGl2xvNxrBslmm6Eqcsk9y0Z6cx9vpO/2Lme0ubc+HKUtw1XF5O1yBhZGxFJ75r6nizGjk8D+HWBAnJcNn6bsp/Ghxg8tRAo27Oa0RbbnKc9ySXbj4JwbnEc+FCQs7cjbvAHaaiKjYsAkHzg0daa2wJU2nzUEEEeD8jVDbniOznHCOzlK4BfdSfsnc3YPhFhxH4+QZwxC1bGmm5wXm6EFdBLsfVSUFrtqfe4BO8Bq3T5pBVAo8GgK6VE4iGd7+fAdKwmbeBDvHwHLAG3TG/k9oEh8mts72MUZ1LkKvGfNy4hOAvL5fhZt19GBepaEl9drA68IUzDth47HxUAlXUOk49rEGo2xJc6nkAwQVcQM+9AatE1+EIIvph47nmSeNpPqSD/3jX3GEdZYCciYV+HGEv7XeXxBaUUkOxwpGikXlKssHLwU16tc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(71200400001)(6486002)(478600001)(6506007)(6512007)(38070700005)(38100700002)(122000001)(86362001)(2906002)(26005)(2616005)(110136005)(41300700001)(64756008)(316002)(76116006)(85182001)(36756003)(66556008)(54906003)(66946007)(8676002)(5660300002)(8936002)(66476007)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajFDV0JmcisxVTZRWjEyTVpodlhCRFUrc2pJeUJheDEzUjMzZ3N2MXpBS1Zt?=
 =?utf-8?B?WTVEUTl4OVh6M2VnRmNHOU5ZZGRNdlhlN1VwcGZMNzFsRmpUTko0MkNPVHAz?=
 =?utf-8?B?OXFNQUJXR09YSkJURVFZbkN6UVM2L3h0aXd5N1VBU0cxZVM5S3JKNTBpNmpT?=
 =?utf-8?B?akxaSVBMUHhhc0dKV2dOMm9WOHZKMTR0eEI4ckU4ZE1hS1NnVFpZcmlrTm5L?=
 =?utf-8?B?QkU4Kzg0WHlSaWNoUnQ1Tk1SMkNvSUVNdG9SOGdWWXltbWFDMkRoQzRHNTJ1?=
 =?utf-8?B?Tkd1S3hMM1Q4V2FGYkRzQWlXWFQvRWR4TVVQMGRjR0UrYVllaXhxYlV0bE1n?=
 =?utf-8?B?b21BMGx1Qlh4OUcxOXlGSm9kcXEvVksrLzczUTRRY2pyOWMwZ3BxNGk1dTFI?=
 =?utf-8?B?Z3dNclRYUHZjanBJY2thaHM4eFV6RjM5cDJ3VktMSzJjRkppSnQrNTg3WDhU?=
 =?utf-8?B?MWxTOFJickR6QTg5aXVURk9JWlkwOEVwQjBFWjVOZ0gvbmtJbDhsTUdnc1pl?=
 =?utf-8?B?dkRldGJYQmZ6TVRLRGR0ZFkxNFB4M2srdC9vVnkyenR3REF6YUcwTjFoTWxP?=
 =?utf-8?B?dm45M2NiTDNra3QvNXM2NGUxRGphc2RCWVVOKzJhRnpKcWhrVk5sdGMvM1Jz?=
 =?utf-8?B?Mm82VzM5ck5DRXByWkgrZTR6MDd1eTVoREdZbVpiK1o3RCtjVkQ4Q2xmRnds?=
 =?utf-8?B?ZlBlb1V2bDdQWVZjUi9Fc0MyamlocmttYWE0OEdaejFycUFqd1BvVjZlcm5T?=
 =?utf-8?B?aU01bm5Nd1JmOFVuNGFRbGtFaDFXbFgwYnN6NE9xaXVoaXVMbStMSDhGaGEx?=
 =?utf-8?B?cWRSZWMzcTZMTlZLc29jSjZmbExreE4xUHptMFF1SXpGY2VJaDU2R01KQWdw?=
 =?utf-8?B?Wjh1MnQydXVpNmU1SUY4dUFyMkJ1bDlRSC9CU0lQU2NjZWVZSkoyNGEvQ2JN?=
 =?utf-8?B?ZDRiSnJyTW1GNllqZnlqd29NMXplMTAvRGEzYnU3MVp3MkpJU3VGV0ZVb01O?=
 =?utf-8?B?TEpPMThEck82UTU1TlhXZHJZQk5QemlqNXVTbzRaelYxUENPc0xicFp1dTlp?=
 =?utf-8?B?SUkyMGd3ZXpyVE1Ra2lNeHVhWVl5QnIxMll1dDIxU00rZzZIT2tTdThNSEVr?=
 =?utf-8?B?SEJ0Uk5ETWprSmhRMGo5djFHNVJkUnF3aWFETVRYWTBIVFliMmJLTU9UM0RK?=
 =?utf-8?B?eXpJUktBenVTUERaYWVaZkFacVVjWG5wbWtKWXZrMjVZQnlXbmRHZUs1Umpr?=
 =?utf-8?B?cC96UHQxcmdWYkFic0lteTk2ZWRCQWRHMWpDSnN1Wi9wN0Zjbm81Szh1czk3?=
 =?utf-8?B?Rm54V2ZhbWR0dGpOMHFLMTh2QWZERmdacWNudmlpQ1Q4ODNoS0F3WmhEQWRJ?=
 =?utf-8?B?UWNHNU9NTVVhV3hLQlNHeGl4b3lyRzBhUzJsSGJXd283TjFDYy9iQ1Vab1px?=
 =?utf-8?B?Y3RrWll5d0Qxd0E3TkJ6aGdYbFMwbmVMSTFhL2xTeSsxWEFXVmJzM1dRUFBo?=
 =?utf-8?B?d0lZeXBRd1FpcldEQ3dBc1crejZwM084NDZBb3lFbFFnNnZYT3AraHVBeVFt?=
 =?utf-8?B?M0IzK1VWaFJnczg5bzRNT3ZIR2VJRnBEQlorVGdBYTIrdGZLT0VSN3JiV25n?=
 =?utf-8?B?aGI0eGZLeWJkdU9rdzc5QnNOaUJjRkljUTRkWW1rVnBkeTR2R3VkOVdJOUtF?=
 =?utf-8?B?TEpZYWo1ZndCbHpRZ3p1MFZtVVJlNkxpWHFUeThxWTFQUTNBVjB3dit3OGJH?=
 =?utf-8?B?dy81Z01xSXQwVlJORy9RUkNNSFVpVCtueGpadnAzc3RHR3g3Yk15S2trZkNh?=
 =?utf-8?B?WDBKcG5BakRLZEprN2drT3M2RVY1SHV5dm1USFZCcVk3OVcxaHU5ZGdXZFVt?=
 =?utf-8?B?QmVISUdBVFllN3QwcmEvUDNvaDNZalpuZ0IxQ2E1ajhLM3UxbjRnbkI3UGpF?=
 =?utf-8?B?S0FZKzF5SmM3eTFoaVlqMGtHT1UxNWl5MUZlMGRidEZMVlNmWFFyL1l0ajli?=
 =?utf-8?B?RDRyZUpQN1F2RGlCdTJPUmM1TFUwQm5XMTNlYTVSRTZ6ZUdoNXpxZWE5aXpN?=
 =?utf-8?B?RTRPYXFqK3VFWUYrMjl1Q2l3d09scVFNTk1vZU9yLzdTWVRtV2ZVaFVveWtF?=
 =?utf-8?Q?tF9ifXHb81MfmN8WhtNTGsVe4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9EEFC8379B00747839E82F6CD24AA0F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c830dad-3142-41a4-d99a-08dbc641fdd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 07:58:13.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymQmHobj0xasG3HI8acGVyTuiV7H69gowLb2J4tqOcfMeZ9fdzMzseD7LGbCm91iiYcvpyhLz0tGoTwPFymdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8182
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.296100-8.000000
X-TMASE-MatchedRID: pBwXUM+nCwsOwH4pD14DsPHkpkyUphL9MZm0+sEE9mv/evmlVf9xZqUo
        SyVrNB2cGQdEeHBaW03ijpjet3oGSG5/NyTKlG69HPYwOJi6PLmZ2scyRQcer19eTSR8I6dufdQ
        7p2bSGhbi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRu+rAZ8KTspSztpixhauoZ4+TGn
        PY7Qtc1ZOZfx5jb/g50ZyTHk1CvTVNa5u7Cr4Y5jY/3n42ecAnY9/CSpfzgYu9lOXCYDyVDnlmg
        4ZYQtWLuWcoppQzMcgOesYbm2tlrmfOimN6DU98yDtEotk7np5+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.296100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A1B9DEA6904A83EF554B1142E20DD28A7F0B3D62556A3506289B31534C6AF18F2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjMtMTAtMDQgYXQgMTA6NDAgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGltcGxlbWVudGF0aW9uIG9mIG10a19kc2lfZW5jb2Rlcl9pbmRl
eCB0byBtdGtfZGRwX2NvbXBfZnVuYw0KPiB0byBtYWtlIG10a19kc2kgc3VwcG9ydCBkeW5hbWlj
IGNvbm5lY3RvciBzZWxlY3Rpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KPiBSZXZpZXdlZC1ieTogRmVpIFNoYW8gPGZzaGFvQGNocm9taXVtLm9yZz4NCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBUZXN0ZWQtYnk6IEZlaSBTaGFvIDxmc2hhb0BjaHJv
bWl1bS5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Ry
di5oICAgICB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2Nv
bXAuYyB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyAgICAgICAg
ICB8IDkgKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gaW5kZXggNWYw
NzAzNzY3MGU5Li5mZGFhMjFiNmE5ZGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTQ4LDYgKzQ4LDcgQEAgdW5zaWduZWQgaW50IG10a19kcGlf
ZW5jb2Rlcl9pbmRleChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYpOw0KPiAgDQo+ICB2b2lkIG10a19k
c2lfZGRwX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19kc2lfZGRwX3N0
b3Aoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gK3Vuc2lnbmVkIGludCBtdGtfZHNpX2VuY29kZXJf
aW5kZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIA0KPiAgaW50IG10a19nYW1tYV9jbGtfZW5h
YmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19nYW1tYV9jbGtfZGlzYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggNjAxNzU1OTI1NTIwLi5mMzM0NWFmMTJjYjggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAt
MzE4LDYgKzMxOCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRk
cF9kc2MgPQ0KPiB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBk
ZHBfZHNpID0gew0KPiAgCS5zdGFydCA9IG10a19kc2lfZGRwX3N0YXJ0LA0KPiAgCS5zdG9wID0g
bXRrX2RzaV9kZHBfc3RvcCwNCj4gKwkuZW5jb2Rlcl9pbmRleCA9IG10a19kc2lfZW5jb2Rlcl9p
bmRleCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1
bmNzIGRkcF9nYW1tYSA9IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHNpLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGlu
ZGV4IGQ4YmZjMmNjZTU0ZC4uMTI0NjQ3YTRkOTg1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHNpLmMNCj4gQEAgLTg2NSw2ICs4NjUsMTUgQEAgc3RhdGljIGludCBtdGtfZHNpX2Vu
Y29kZXJfaW5pdChzdHJ1Y3QNCj4gZHJtX2RldmljZSAqZHJtLCBzdHJ1Y3QgbXRrX2RzaSAqZHNp
KQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtfZHNpX2Vu
Y29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfZHNp
ICpkc2kgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25lZCBpbnQgZW5jb2Rlcl9p
bmRleCA9IGRybV9lbmNvZGVyX2luZGV4KCZkc2ktPmVuY29kZXIpOw0KPiArDQo+ICsJZGV2X2Ri
ZyhkZXYsICJlbmNvZGVyIGluZGV4OiVkXG4iLCBlbmNvZGVyX2luZGV4KTsNCj4gKwlyZXR1cm4g
ZW5jb2Rlcl9pbmRleDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBtdGtfZHNpX2JpbmQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+IHZvaWQgKmRhdGEpDQo+
ICB7DQo+ICAJaW50IHJldDsNCg==
