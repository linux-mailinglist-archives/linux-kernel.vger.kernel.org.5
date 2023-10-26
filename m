Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909A7D8044
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjJZKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjJZKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:07:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6BF93;
        Thu, 26 Oct 2023 03:07:08 -0700 (PDT)
X-UUID: 69fad3cc73e711eea33bb35ae8d461a2-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KGZA0LuUhnC2uqRb6WyiE8goo6URzEKFk4VuJuW5f7A=;
        b=aS3alaPmgadCagNAEMyR/zt8QaAJ/Gg4NBYXJUg33Wc7Jl3NwDV8C4NN0HGL9tUQ9QhpwhqZu+Ttlx6R3lMHBwC0G5PL9hFh52USnx9gflMpAz0aPBOs+sb6hbRgXpgQke+14lL0UPL/S6bg13LO9boNlZm1S3P57eqi9SZOP08=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:94f2766f-4eeb-4bb4-b223-7c52a4431f3c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fd49aa94-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 69fad3cc73e711eea33bb35ae8d461a2-20231026
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1654293068; Thu, 26 Oct 2023 18:07:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 18:07:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 18:07:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwXG3IIBMyYdga648YHcxS1PnAdtLmRPnuPehO5NzSGD+J3lh08xlpMqBdpmg6oSdTE8wN6a2eTj5f57N+7WN4HTGWpXhNTNmIPx3tpX7kHey23cESfgKIJLtLRtqZcfU/OfCbd1xbVYispRMC+FL1tIK4y/9dO0/CvhbbgzQKKo4qHeQqbJglEA1U7llDlNylU+TLdD7vHnWt94lJ6YuB1LuaNj6dUjiU43riD3aztort7ZhDLLVXQrDqYqnqePRry9hXSCvSV1sevjjSvBeyvUDI6ijosLQl2pqbFjhUxoDTOxL7iufYjnHk4NlQ7BmPOQmsB28Wek2QmsF+bX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGZA0LuUhnC2uqRb6WyiE8goo6URzEKFk4VuJuW5f7A=;
 b=CHfkXDUYfNVvkwnkRdZWRVKmoh5Sly6zCmlx+A9gY+mlsSeAP2ShOiP61/O/XATFshy1M1wd8JL/5AVrQR0dTNiKza6D6vIyiLVLPnxIcfgwV3NnHq9z0XkxPgqCyneZdcqLUqS6C43L+R+G1t9dTXp/3LLBEPi5IAIpweqFnylMfj/1AgyQsCoVyY/QrZiU0fpXyh3rjq5/ZzYAgIllq9AkyRfbi1R7zxXAITCUNaLKfmHxvmo55Kb2d5WRqEqUcGQhVEdL/PghBH9Djr+q3I+xVj+uBh7sTzAcYlBk/8ay9WmVmaXDf6N1Yrgy0HGJSenHTUS3nE3AMD8lcXtVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGZA0LuUhnC2uqRb6WyiE8goo6URzEKFk4VuJuW5f7A=;
 b=N8IAMELWYrtye+fp/Sqh+XazYsK4gH0zrXuafdNubYGDXB2nu2pMr8kAAKiDtWEqLmz0P48lTvfQUE9QsF2Bkz3SY4Ds5f4jNP9fR/rRLyHRFLPmH3MYL6nhrvR+AD62H+kPx02isotyvhgoHTrh5uOANBekykUPQjCadnFlev4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB5967.apcprd03.prod.outlook.com (2603:1096:400:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 10:07:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::fe5a:c0e7:4b72:64f3%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 10:07:00 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
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
Thread-Index: AQHaBWwJYGbjWCm+FECrWQohGGln37Bb3XkA
Date:   Thu, 26 Oct 2023 10:07:00 +0000
Message-ID: <3af3f0919045e806b7cc2c36fb99bff8918f874e.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-8-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023044549.21412-8-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB5967:EE_
x-ms-office365-filtering-correlation-id: 2c72e004-e641-4ee2-111a-08dbd60b4bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CLWA0zadLZlLWzbFrQbIx+WsL2AzlUTuJEvzhRsZ36KSTDTngIUiZq0AiWL4SxoSMeqJw8JU9U0seeF3hA4XYfD8Fxk6m4ogThxskkNWUhSv+TPPR8si74LBlDLenChbuj58FOTkZse7cW2oU/0V5p3KO4XG+CAGHZTBz6QJforQ/VPDxKT7nkddtOVQWMhz9RRa5ZYXkDXfoF0j72pEs9YKhBhOGcBJnnNYjen3igwe4ihZyV4XiuawCrySk7xUrCdW+CboAAA/sHjwcatEfihXIksIa7fHBYWTnxRIU+kSGLAjTa6skBhH1SfoZKlGhRz+41LvC69nOyHTX3+RChSX9dGQfzznUa96S/qQ8LXvsmNlgDfpNnFVi00Xgq/HHiTCj/9FPWPYvtUtV0Bwer4yAu4ru3sDvfdZmGoxi6XnTdHC+GFWYynNEcFBrjAhwm+PvUcuKN61gkHVD4vFnXHMVfF+umiDdIcc/WiFCFlpvXzH+cXNk1AMtgtOBXTtLyAnArkEzc2MIGOQvxtisimR8TyFZHkiXjZpxaTOa0qjJdbJKErNaI0u1jSnDcxBAPRhj75TZN+aGmPYPnxi3JNNeu34XcGMVJ2GEtNsMx8Vvv7jmxtE/fS5yfoJICabAr7B3wFKZM7GHL1RFEqz4y/HUGlYQ4v35clY7+nSXtg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(5660300002)(6486002)(478600001)(71200400001)(83380400001)(38070700009)(316002)(6506007)(6512007)(26005)(64756008)(2616005)(66946007)(54906003)(66556008)(76116006)(66446008)(110136005)(66476007)(2906002)(4001150100001)(122000001)(38100700002)(41300700001)(86362001)(7416002)(85182001)(4326008)(36756003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUo0R0tBUUtRaWR2Qm1CQUxHQUFNWTZFWW1hbGRDRU9xbWtWaklJRm1Od0Yx?=
 =?utf-8?B?TjIyMDZvalh5azZ1eVZUL2VJZFE5NlJhNkphY0RPWVE3RVArdnk0Tm1mMjdU?=
 =?utf-8?B?RjcwVWNYc0NDT2ROalRyenFDN0p1bXlZRVFVTzdrV2J6eWlYaHA1b054Zmpl?=
 =?utf-8?B?S3NwODdGMGZtblFuQll2aHJOOTVNcjRUZW1tRDkvcVpoQ0hyNW1oWjcyRnJY?=
 =?utf-8?B?OEYzclZjVmp6dGg2QTBCb25QZ1N3bXovbEZNUFMvRkViY0w3SWRYanNIMXVQ?=
 =?utf-8?B?aFVZVUNDcVdEbFlXNDN0V0RnalFPa21lZ0g3bzRpeDRVQnlnVjZWa29NRGU3?=
 =?utf-8?B?eEtrMWpvcUozVXg1L2d4SFNUakFLWW9MR3dWM012R1FlNlUrWWx2RlM5c3ZN?=
 =?utf-8?B?aE1SeUpnSi94ZU4xVlVmYnBZMENCNzlPVFhzWDJheW1YeXZENTZleVJ2cVVx?=
 =?utf-8?B?Z2xhbVMxRWJobE1WMG80cUR2cmgvK0wwZXlIK3VKLzVsR253dWFxaTFBaXRQ?=
 =?utf-8?B?WU40bDhQRXF5Y2ZRN24xVnI3WFlSRGI5blFPY01xRFp4bWhaS0VOVXg0L1Qw?=
 =?utf-8?B?ZmVLaVpGSEoyNXhOV3N2cS9OdmlPZC9PWnRDREFNQjBIb0JpVHh4dnBjWkd2?=
 =?utf-8?B?YzhEV0dGeXF6akRrbFRGQUQxY3hQV1d1eWtUT0lubWFqdUprZG52VWY3TmF4?=
 =?utf-8?B?RldsRndIcUV4bXo2OHF0cXJycU13OVd6QnJ4ZWozSGdXMmN0aE9iSUNLZUx3?=
 =?utf-8?B?WmYxSXgzdHZXTmw3UFJJMWJmSWFDYmtUek9xZytsR2lNTUtON054R1ZERkFt?=
 =?utf-8?B?UVNpeXI3OWJhTFZZbFBBRWZDU2ZHOHU3TVorL2krSm1lVEpyV3VrQVJQSkRu?=
 =?utf-8?B?YzhZY2w1SXBnQTV6SUZvZExUbWRKVCt3YWQreXVzZVVFcS96MU9rNndQL2VF?=
 =?utf-8?B?ajdhejgwY294bFoyb2RHZXZwOWNmWi82WUxIRjZLZEdQTlFHUTBxcHlMWm91?=
 =?utf-8?B?Ry9vc2JFajk1VHpwdEQwclJkMEZFcmIva1Z1OXhrM1hQSzZLTXRvVWl5WjYv?=
 =?utf-8?B?eHlrb2RVdEp2bHVVMmlncnl5ZnJ1T21CcW1FYXVHalEzd3RWaDBPZ0NXbVcr?=
 =?utf-8?B?V1dYSEcxV0FIL08zWForL2liZEN3NzFTL2F3Yms5TC9FNUNKZklvUzJIdFhP?=
 =?utf-8?B?WGNsZnRyZVhFYU4vMXJNRmRzWFFaNkFvR1R0Z0ZjTEdTQ1ZaQnNIeDZrZ242?=
 =?utf-8?B?WG1ZcXJEbFliS3VwV3pIZHhrR0sxQ2I3RHFuZldVbVBQY2NDRFF6MzYvN05i?=
 =?utf-8?B?Y3J5T2RpcUxETjcyUkxMcWc2WThhNVBUYVk5TWRZaloxQThVcFhCeVIxenZF?=
 =?utf-8?B?K1gybXJCVkpkaSs5aEZ2Vi9WK09VSWJWdUYxTVJYc1dsakErTUEyblhWRjlR?=
 =?utf-8?B?NnZVd09DNHp4VGZVWTBrNzErVFl2UVcvbDVSaER6L21oMEovRVNTWjN5MjNT?=
 =?utf-8?B?VFNscldnM0JGcWx0ZFFxSnExa0kyUk9JMUxRTU56RjhZbnV2ZGZCWEt4eXZ2?=
 =?utf-8?B?MzI1UmNCSldVMGVGdmtWUDl0bXRvdUxmSlJTNXlmV3VXWmlrSUhJVXhXZzE4?=
 =?utf-8?B?dzg4b3NHa1VzU3VUVlB5TGpVZ2hEYU9lZ3JnSW1FOVIyMTJ5cFl6cFh6QUND?=
 =?utf-8?B?dVF4TGtIU1Btdmw3TGordkNwRmhWMkxDaUMrZTh6VkEzNnVGMk5NVUFrRUFj?=
 =?utf-8?B?MnFXanlYR3k3R3kyZVNxRU5DQ3NXK3V3WjY5NEM1SGdpUVRqWTBuVzgvWDQ2?=
 =?utf-8?B?d0N5Z0FrRklhRWhISnloc0dNWk1ESGEwY0E4TDNTdXVjZmdzNTBKT1NEYndh?=
 =?utf-8?B?cFgzSC9wRSt6czRtL3hYelBBL0dnSCswTFZybk5TMTFnV1NZb05TdVNrcFVk?=
 =?utf-8?B?RFpYZFFXWDQrQjJwSGdwRi91VWFoak5YUjZBTWNwbmVUamE1MFlzV1Z2VGVE?=
 =?utf-8?B?VzZ3SkJiUmpDWU1hcmJUVFNMeWJtSUU0R2lVTUFENTdCZUIxK0ZBRTVlN2tX?=
 =?utf-8?B?TklMdlJBZ3ZnZHUzQmdnWlVYMTdFczI5a1orOGR2aCtaK2ptNlVtQzJtSlRU?=
 =?utf-8?Q?pKCpfDT0wYaDYX8++2qjUbZG9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A405BBF1F3B7945B3617B42E9A29DA8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c72e004-e641-4ee2-111a-08dbd60b4bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:07:00.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqagzqbNDdrsTKL9kEkFWLqw4ioP56i4O+XzHaF+X25AyxZn/qpG6wa36ZUoJkkeBSbT9GGHzOaURzgQzecJpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5967
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjMtMTAtMjMgYXQgMTI6NDUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCAg
ICAgICB8ICAzICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMg
ICAgICAgfCAzMQ0KPiArKysrKysrKysrKysrKysrKy0tDQo+ICAuLi4vZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAxMiArKysrKysrDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgMiArKw0KPiAgNCBmaWxlcyBjaGFu
Z2VkLCA0NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCAyMjU0MDM4NTE5ZTEuLmRlYzkz
N2IxODNhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Rydi5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0K
PiBAQCAtOSw2ICs5LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5oPg0KPiArI2luY2x1ZGUgIm10
a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICAjaW5j
bHVkZSAibXRrX21kcF9yZG1hLmgiDQo+ICANCj4gQEAgLTc5LDYgKzgwLDcgQEAgdm9pZCBtdGtf
b3ZsX2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ICAJCSAgICB1bnNpZ25l
ZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiAgCQkgICAgdW5zaWduZWQgaW50IGJw
Yywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCk7DQo+ICt1NjQgbXRrX292bF9nZXRfc2VjX3Bv
cnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50DQo+IGlkeCk7DQo+ICBp
bnQgbXRrX292bF9sYXllcl9jaGVjayhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBp
ZHgsDQo+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiAgdm9pZCBt
dGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgs
DQo+IEBAIC0xMTIsNiArMTE0LDcgQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfY2xrX2Rpc2FibGUo
c3RydWN0IGRldmljZQ0KPiAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2NvbmZpZyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAgCQkJICAgIHVuc2lnbmVkIGlu
dCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICAJCQkgICAgdW5zaWduZWQgaW50IGJwYywg
c3RydWN0IGNtZHFfcGt0DQo+ICpjbWRxX3BrdCk7DQo+ICt1NjQgbXRrX292bF9hZGFwdG9yX2dl
dF9zZWNfcG9ydChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZA0KPiBpbnQgaWR4
KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHVuc2lnbmVkIGludA0KPiBpZHgsDQo+ICAJCQkJICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRl
ICpzdGF0ZSwNCj4gIAkJCQkgIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDJiZmZlNDI0NTQ2Ni4u
NzZlODMyZTQ4NzVhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292
bC5jDQo+IEBAIC00Niw2ICs0Niw3IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSKG92
bCwgbikJCSgob3ZsKS0+ZGF0YS0+YWRkciArDQo+IDB4MjAgKiAobikpDQo+ICAjZGVmaW5lIERJ
U1BfUkVHX09WTF9IRFJfQUREUihvdmwsIG4pCQkoKG92bCktPmRhdGEtDQo+ID5hZGRyICsgMHgy
MCAqIChuKSArIDB4MDQpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBu
KQkJKChvdmwpLT5kYXRhLQ0KPiA+YWRkciArIDB4MjAgKiAobikgKyAweDA4KQ0KPiArI2RlZmlu
ZSBESVNQX1JFR19PVkxfU0VDVVJFCQkJMHgwZmMwDQo+ICANCj4gICNkZWZpbmUgR01DX1RIUkVT
SE9MRF9CSVRTCTE2DQo+ICAjZGVmaW5lIEdNQ19USFJFU0hPTERfSElHSAkoKDEgPDwgR01DX1RI
UkVTSE9MRF9CSVRTKSAvIDQpDQo+IEBAIC0xMjYsOCArMTI3LDE5IEBAIHN0cnVjdCBtdGtfZGlz
cF9vdmwgew0KPiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YQkqZGF0YTsNCj4gIAl2
b2lkCQkJCSgqdmJsYW5rX2NiKSh2b2lkICpkYXRhKTsNCj4gIAl2b2lkCQkJCSp2YmxhbmtfY2Jf
ZGF0YTsNCj4gKwlyZXNvdXJjZV9zaXplX3QJCQlyZWdzX3BhOw0KPiAgfTsNCj4gIA0KPiArdTY0
IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVk
IGludA0KPiBpZHgpDQo+ICt7DQo+ICsJaWYgKGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZM
MCkNCj4gKwkJcmV0dXJuIDFVTEwgPDwgQ01EUV9TRUNfRElTUF9PVkwwOw0KPiArCWVsc2UgaWYg
KGNvbXAtPmlkID09IEREUF9DT01QT05FTlRfT1ZMMSkNCj4gKwkJcmV0dXJuIDFVTEwgPDwgQ01E
UV9TRUNfRElTUF9PVkwxOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpcnFyZXR1cm5fdCBtdGtfZGlzcF9vdmxfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2
X2lkKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZGlzcF9vdmwgKnByaXYgPSBkZXZfaWQ7DQo+IEBA
IC00NDksOCArNDYxLDIyIEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX1NS
Q19TSVpFKGlkeCkpOw0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb2Zmc2V0
LCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0KPiA+cmVncywNCj4gIAkJCSAgICAgIERJU1BfUkVHX09W
TF9PRkZTRVQoaWR4KSk7DQo+IC0JbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBhZGRy
LCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0KPiA+cmVncywNCj4gLQkJCSAgICAgIERJU1BfUkVHX09W
TF9BRERSKG92bCwgaWR4KSk7DQo+ICsNCj4gKwlpZiAoc3RhdGUtPnBlbmRpbmcuaXNfc2VjKSB7
DQo+ICsJCWNvbnN0IHN0cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdF9pbmZvID0NCj4gZHJtX2Zv
cm1hdF9pbmZvKGZtdCk7DQo+ICsJCXVuc2lnbmVkIGludCBidWZfc2l6ZSA9IChwZW5kaW5nLT5o
ZWlnaHQgLSAxKSAqDQo+IHBlbmRpbmctPnBpdGNoICsNCj4gKwkJCQkJcGVuZGluZy0+d2lkdGgg
KiBmbXRfaW5mby0NCj4gPmNwcFswXTsNCj4gKw0KPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21k
cV9wa3QsIEJJVChpZHgpLCAmb3ZsLT5jbWRxX3JlZywNCj4gb3ZsLT5yZWdzLA0KPiArCQkJCSAg
IERJU1BfUkVHX09WTF9TRUNVUkUsIEJJVChpZHgpKTsNCj4gKwkJbXRrX2RkcF9zZWNfd3JpdGUo
Y21kcV9wa3QsIG92bC0+cmVnc19wYSArDQo+IERJU1BfUkVHX09WTF9BRERSKG92bCwgaWR4KSwN
Cj4gKwkJCQkgIHBlbmRpbmctPmFkZHIsIENNRFFfSVdDX0hfMl9NVkEsIDAsDQo+IGJ1Zl9zaXpl
LCAwKTsNCg0KV2h5IHBhc3Mgb3ZsLT5yZWdzX3BhIGludG8gY21kcSBkcml2ZXI/IGNtZHEganVz
dCBuZWVkIHN1YnN5cyBhbmQNCm9mZnNldC4NCkluIGFkZGl0aW9uLCB3aHkgcGFzcyBidWZfc2l6
ZT8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwl9IGVsc2Ugew0KPiArCQltdGtfZGRwX3dyaXRlX21h
c2soY21kcV9wa3QsIDAsICZvdmwtPmNtZHFfcmVnLCBvdmwtDQo+ID5yZWdzLA0KPiArCQkJCSAg
IERJU1BfUkVHX09WTF9TRUNVUkUsIEJJVChpZHgpKTsNCj4gKwkJbXRrX2RkcF93cml0ZV9yZWxh
eGVkKGNtZHFfcGt0LCBhZGRyLCAmb3ZsLT5jbWRxX3JlZywNCj4gb3ZsLT5yZWdzLA0KPiArCQkJ
CSAgICAgIERJU1BfUkVHX09WTF9BRERSKG92bCwgaWR4KSk7DQo+ICsJfQ0KPiAgDQo+ICAJaWYg
KGlzX2FmYmMpIHsNCj4gIAkJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBoZHJfYWRk
ciwgJm92bC0NCj4gPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+IEBAIC01MjksNiArNTU1LDcgQEAg
c3RhdGljIGludCBtdGtfZGlzcF9vdmxfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIAl9DQo+ICANCj4gIAlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwg
SU9SRVNPVVJDRV9NRU0sIDApOw0KPiArCXByaXYtPnJlZ3NfcGEgPSByZXMtPnN0YXJ0Ow0KPiAg
CXByaXYtPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiAgCWlmIChJ
U19FUlIocHJpdi0+cmVncykpIHsNCj4gIAkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gaW9yZW1h
cCBvdmxcbiIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bF9hZGFwdG9yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IuYw0KPiBpbmRleCA2YmY2MzY3ODUzZmIuLjI4YTBiY2NmYjBiOSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMN
Cj4gQEAgLTgzLDYgKzgzLDE4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb3ZsX2FkYXB0b3JfY29t
cF9tYXRjaA0KPiBjb21wX21hdGNoZXNbT1ZMX0FEQVBUT1JfSURfTUFYXSA9IHsNCj4gIAlbT1ZM
X0FEQVBUT1JfRVRIRFIwXQk9IHsgT1ZMX0FEQVBUT1JfVFlQRV9FVEhEUiwgMCB9LA0KPiAgfTsN
Cj4gIA0KPiArc3RhdGljIGNvbnN0IHU2NCBvdmxfYWRhcHRvcl9zZWNfcG9ydFtdID0gew0KPiAr
CTFVTEwgPDwgQ01EUV9TRUNfVkRPMV9ESVNQX1JETUFfTDAsDQo+ICsJMVVMTCA8PCBDTURRX1NF
Q19WRE8xX0RJU1BfUkRNQV9MMSwNCj4gKwkxVUxMIDw8IENNRFFfU0VDX1ZETzFfRElTUF9SRE1B
X0wyLA0KPiArCTFVTEwgPDwgQ01EUV9TRUNfVkRPMV9ESVNQX1JETUFfTDMsDQo+ICt9Ow0KPiAr
DQo+ICt1NjQgbXRrX292bF9hZGFwdG9yX2dldF9zZWNfcG9ydChzdHJ1Y3QgbXRrX2RkcF9jb21w
ICpjb21wLCB1bnNpZ25lZA0KPiBpbnQgaWR4KQ0KPiArew0KPiArCXJldHVybiBvdmxfYWRhcHRv
cl9zZWNfcG9ydFtpZHhdOw0KPiArfQ0KPiArDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9sYXll
cl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gaWR4LA0KPiAgCQkJ
CSAgc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUsDQo+ICAJCQkJICBzdHJ1Y3QgY21kcV9w
a3QgKmNtZHFfcGt0KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rk
cF9jb21wLmMNCj4gaW5kZXggM2RjYTkzNmI5MTQzLi5lZWMzYTFjYzJlZDQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtMzczLDYg
KzM3Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9vdmwg
PQ0KPiB7DQo+ICAJLmJnY2xyX2luX29mZiA9IG10a19vdmxfYmdjbHJfaW5fb2ZmLA0KPiAgCS5n
ZXRfZm9ybWF0cyA9IG10a19vdmxfZ2V0X2Zvcm1hdHMsDQo+ICAJLmdldF9udW1fZm9ybWF0cyA9
IG10a19vdmxfZ2V0X251bV9mb3JtYXRzLA0KPiArCS5nZXRfc2VjX3BvcnQgPSBtdGtfb3ZsX2dl
dF9zZWNfcG9ydCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9j
b21wX2Z1bmNzIGRkcF9wb3N0bWFzayA9IHsNCj4gQEAgLTQyNCw2ICs0MjUsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiBkZHBfb3ZsX2FkYXB0b3IgPSB7DQo+
ICAJLnJlbW92ZSA9IG10a19vdmxfYWRhcHRvcl9yZW1vdmVfY29tcCwNCj4gIAkuZ2V0X2Zvcm1h
dHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X2Zvcm1hdHMsDQo+ICAJLmdldF9udW1fZm9ybWF0cyA9
IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMsDQo+ICsJLmdldF9zZWNfcG9ydCA9IG10
a19vdmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qg
Y2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBFX01BWF0gPQ0K
PiB7DQo=
