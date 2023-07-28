Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8D766A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjG1KXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjG1KXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:23:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CBB3A81;
        Fri, 28 Jul 2023 03:23:15 -0700 (PDT)
X-UUID: be27e5642d3011eeb20a276fd37b9834-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=aZKQZ9D4JxwhHtLlm+rsc7tsgna/tmloIPYELLY404A=;
        b=cE4LVIckMGuxnKPhXzxXZ3lxSaOXplIYwGabIExpNf6rIz3zzF9M78NPfuZcZceV6envhJrdEB/HDoz4l57WxmTie0FzKlCP+f92bpQoVQyZjLAPMuShNm7Y8iytGA8eBhDSbUXdZe6vIfAnTv1RQMKjDt+GM6dcbiaEWK1/Phg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:8cbaf3fd-bc24-47c8-8631-3f40295bc933,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:8cbaf3fd-bc24-47c8-8631-3f40295bc933,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:5a676ed2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230728182308PSCHA10Q,BulkQuantity:2,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:43,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: be27e5642d3011eeb20a276fd37b9834-20230728
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 99606181; Fri, 28 Jul 2023 18:23:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 18:23:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 18:23:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWJhdUtMRFBjlqH1kHjQz3t6h06JwXGmvyoaBR/IZvv17N6tDEbqljurXDoRKJXB9gX/e/HCijbP8t6AecwaDjubgDz+TY0EnVyvwav1og9XYrDCZbdOH0U4V84iqFje4KFaP4fOk9FiEI2vxU7qvmdZV+Aas6d3M9z66yl3zUrH0kBL6JMK6MltdBFDB7b/5VMtuw0C9uzY2/hHkvKgFMJoWSOhqmTsGPa9mGwRTnavLTwWkpEYVqUhiHD7Jk/G7n7fWLvIMYq7rticUwfrfa+C2vWG94vCjGZrruylEMBEkJN+cbpoVPCrhvEumenMuQEabtl26A9MsiiTuTO+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZKQZ9D4JxwhHtLlm+rsc7tsgna/tmloIPYELLY404A=;
 b=B9URvOchVpdZ0L721V6rgvdahsZQwZ6fRVQ1CvUGk1OMJyVAJid3Ehw21WbcqWtueT3cn5WyP+galRQd0tVTCHBWnur2YxR4ZUj7+opudpCpv5wmLSv2Do8wPoGr6tfAnWSS5RfqDJKDRhOgtt8rndYTXpLeHH5OpeeulGwFIxxOwftIR1AE/yIreqKMfzW3RfqJ/cyIbj+V0vpGpZ8rbwwY/7ltX3KtApUP0J2wHVEoHxFs6MLY4z/ScRDznElQeQIAnlh3gjdnPa02a+rWM/4JtM9rqtyj7h35aIYmgeEcG+Rqi4YJsF4yiEGihcXGfm9fZTantPKG0HY1bv/Dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZKQZ9D4JxwhHtLlm+rsc7tsgna/tmloIPYELLY404A=;
 b=qd4Rv+tsH47R26omPqBWBZUbKSDnxdxum/XBLfhcW+gSIRQe1JxiVO35ctRoFSB1HTzYEkZu488/RUOoCy/1T1aQw5Akb6KGkemH4D0JGgd8AucPeKVLfXfmYBfxH5AohT7x2Fvepd+t/tygkEXPeVRQ9dpqy1/pZI1gmOk6FTU=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by SG2PR03MB6503.apcprd03.prod.outlook.com (2603:1096:4:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Fri, 28 Jul
 2023 10:19:07 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:19:07 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Topic: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Index: AQHZwTM8FwajV4doNE2aIAHm/Atkhq/O8jkAgAAFQQA=
Date:   Fri, 28 Jul 2023 10:19:07 +0000
Message-ID: <2bb70a3be923c437a122026d2885a52ee6e47ed0.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-7-maso.huang@mediatek.com>
         <b2869bdd-04e8-262d-5d1a-4d835397360e@collabora.com>
In-Reply-To: <b2869bdd-04e8-262d-5d1a-4d835397360e@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|SG2PR03MB6503:EE_
x-ms-office365-filtering-correlation-id: f3dae125-32f5-48ee-1dcb-08db8f541383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VaarSx1RyrBcwuZ643xmpUXtsOp6De/cJnntCPticYbGMlXdsqxn2Vit9QdDwz89xkpXqIcG7e4Tb+L/cw/3ejYRMlOAsG8KGQOJ1rtnMCJOdW+Akh+htz6lFkZhiuO9ObYtKzYSFQkBgPwSvWrOcsEk4AmY7zOeCDpIr1KYdHEOwdnPRJpr9lBFzp7OXHfrO/ppOSRF+uiuU2Qh7bxEJxY4S68kxKpAO2H8eEpkdqBGd678LyLvoKQaSoyrr80qrtuGsOW+dZrxEjphMkfToo5MrC9FM8RKcP1HoK0oU5om+VqNNFP/C5UO1KoqN1SuL4mjb3xfY1tVa2s3+ifd7097/YBGlamTNUwy749DWriCDTbiLxTKFoOxwTUUQ7WiSz2y9V5fXb4fnbXgQG4J6/BSdfZTa54GcP1+t0lkVcRL887VogTviJTRTHVLbyANnymlN4yEJzHpa4E6ei4cinBvIFkcSlsLdQBnOAJEZOkoVk6GVy3BEtxmIIdwOlafpzcqGEiR0Cjj1yRSyXFDeSkEvw2b4/iyLLAMYyFk8cXLPl0ilLsbzNxNVggshdaDuFUa0UDx1lq+kFx+CP4Vf1qAPP+Xs73ygsksFXjRiGi2Sdsj658Y0OH6NpUrHF1jNNykqYRRsfKsgCESrUntYNbukkqx+BVHxBS3qXjyljH9Tf9PUHOuHBqw6mcg4kO8hWK6dzVk9zWRbBzlapvXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(2906002)(36756003)(85182001)(86362001)(38070700005)(7416002)(83380400001)(186003)(6506007)(26005)(966005)(6512007)(38100700002)(921005)(478600001)(110136005)(71200400001)(122000001)(8676002)(76116006)(66446008)(66556008)(91956017)(8936002)(316002)(66476007)(6486002)(64756008)(5660300002)(2616005)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXdETmtLV3lnNDh4UjFaWDdpY21zWFBKT0JLVVVUUktVT1F1ZTRLTFNobVA2?=
 =?utf-8?B?N1ByZWV6MSsyT3lBcWYwZi9GZ1FqVjdIanpVQWJZQVNnMXZvc0o4ZWRERkRy?=
 =?utf-8?B?VndkR1V6K1FwdlQ3USt0RkwvUFZjZW40aHJnVnJJdE40MzVlS2gva1c3bmxT?=
 =?utf-8?B?ZmFYMld4bnB3UCt6a1gxekxWUnRHZk5YY29MbnRZN3dOMXk1OWhyK1o4THVn?=
 =?utf-8?B?SnlCOXhyV2xFSnU0RmVHVFNURXJadUJXZUxueE1tS2lWY3hRcGZuZ1hNbEI4?=
 =?utf-8?B?T2dZODhmQkpMS04zMlZjN2YrT3lwNjRWUUNmcGtCT2JPN0hUL1h2Ym8xWTZ5?=
 =?utf-8?B?YnNlUndOZC9va0daM00zTzRNTDkwRThaY1d4ZzlyUmk3YUtNMTJOM2RwT1pJ?=
 =?utf-8?B?MDJyMWxRalJoNjJ0dVNIekxTZXMyQnN1ZGR4Y0VYRUhlZVkyWVhIY05HT242?=
 =?utf-8?B?dTlSUGVPR3hJVkJWUEZ0aWJXNWdOd3FOLzY0a0pDVUFjbGxrK0UwSjh1U1Yy?=
 =?utf-8?B?Qy9uS0NWNWdUTEdvSFRSVnBDZ09EVnNWczU5cklicm9md2d6MC9uZDdlWVlT?=
 =?utf-8?B?aVdJK2hWa2pld1dGaHZpV3ArOExtS2VHRzVsQ0ZCQ2h2c3IwUWVNOXRJR1Jz?=
 =?utf-8?B?MjliaUtLOXh6NGhMekhLVWd5ZUJXcnppRm1rL2JGandLZ3hMNGZYbnpBN0Fy?=
 =?utf-8?B?NHRhV0hpYVVwS21ydDZoODkwMzNsN2FhN21Mby90OFI2SG1FMTMrbUNnZmFI?=
 =?utf-8?B?cndzb05VcXMwNkI0SmJXMVdrdWFJa2ZCUll3Nm9zN3pqNXhYeWtuWjJTa3Np?=
 =?utf-8?B?RkhBNlp5N0VVVkRJWDFweWthUDFJODFmc2xwaHhlQ1kxcnk3ZzJvTzZjOFdo?=
 =?utf-8?B?RElZb29hZWRYK1ZaVUEvZzY2VWNNQ2VmbEtHZGE4VFd6SjNxTWplSjRRR1NE?=
 =?utf-8?B?RlRtblh2MEFDS1EzMUVmZERTZHBvaW9lT09IS3NGc0hTeWc0bm1udDF5b2w3?=
 =?utf-8?B?UGlLMHI3SW4yZjJFbkRWZHI2K3B4SzlTcGh4M1oycmc4RUpYb09TaWFtNEZH?=
 =?utf-8?B?S2d3T21heGZKYmtaYXdOeHNJd0NzNFJzLzF0TzVpdUhscCtsazNEeHF3ZWg1?=
 =?utf-8?B?S1lxNlBKd09qc0pWRlhBZlVOcmlDditXMVVnaXJoSFV4ZmtTTlBiWndMTXgy?=
 =?utf-8?B?YTgwdkNZMnJ6RytOaXBhdWNnUm5MakJpM3FtaGFNTW5OWWRnUTcxK0lzdDlS?=
 =?utf-8?B?RDh2RWJYTktzdk1sU2VTT2xqRXBqZlE3WG1aZmU5WnlTLzM2c1JibURPa0R2?=
 =?utf-8?B?VkhHWjBsUGdJSjltTjc1d0plbFRIMUMzY3ZCTGZ2NDBGQWNaMVVRaDk2RS9i?=
 =?utf-8?B?Y2R0VVdvR0k4OERpY3M5SVBtTVhUVnlkQUFlN2FJYXJlZlExSjhiZkNDQVdJ?=
 =?utf-8?B?dHRnZnE5enVDUUpPWUV3czdsRjNBc3crRjkxZUtQK051aXp4ampabTVwcFQy?=
 =?utf-8?B?bklmSjZUSnFzaU80ZzFKRHlNeWhITFcxUEhjaTBBK2w1dGo0UWpJSDZvRE9h?=
 =?utf-8?B?RHFueDlvamcwaVRZOFU4ZmdjS2lHVXk2cWJQYkJPUWtXRnNIUE1ZcVFQZ1lv?=
 =?utf-8?B?by90Wi9Oemw1K1FnNEN4aisrR2dmZWJ1S1d4bkZDakFXOWg2amc3MWVsaHAw?=
 =?utf-8?B?TnhhellmNkNQaXlKMUEyYnpBU0ZZUlRTVEE5ZWFxaWU0bCtabFJSOEJJeDQy?=
 =?utf-8?B?Z1BIR2J0NFJKR2NuVFpTODkvQmd2U1I0T3orSmpKc0dBWit5QjlBdE5VQktY?=
 =?utf-8?B?YlQ5aUFvSDZLVHIwL0RuSXFqM216elpERldlTG84MVcwWnJPbzNIalVqdS83?=
 =?utf-8?B?dndxZ3A0S1pxZUR3MWpSNWJpNzZNZ1EvcWdsWkNrYm8wUENiTCtkeXhnTjY3?=
 =?utf-8?B?WFVZT1dNenVIdmtmRi9PbUMzU1RZSk5vVEpETUQ1QWxWMTVJVUZIZGdWYWE3?=
 =?utf-8?B?RDZDb1ZDSkFzckNOem1TakFPWUJ3WjVBQUhxYkoxMDhPSkYyQnQ1TlhldW1R?=
 =?utf-8?B?QlZCeE41OHpSTncxMG0vYVdsczNSTU1LQ1RkQXVwNTExYzJsdFhGcG1STEhS?=
 =?utf-8?B?L0FoUjdXUE9pSUREcGY0NWlwNVZvdE9xcGt4eGJZdEh3ckpoMlJGTHFpempF?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4CD13C1B8D7844AA17DBC11FA3C7FAA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dae125-32f5-48ee-1dcb-08db8f541383
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 10:19:07.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZFUDIUxRfiWoqTeKK0QbYtjQtecDmMN8qIZyXL4h8pauMobbLFeyKqDdimqcn84qfPP++q1E0URLHdv6srUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6503
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDEyOjAwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDcvMjMgMTE6MDgsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBBZGQgbXQ3OTg2IGF1ZGlvIGFmZSBkb2N1bWVudC4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IC4uLi9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtYWZlLnlhbWwgICB8IDg5DQo+ID4g
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDg5IGluc2VydGlvbnMo
KykNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtYWZlLnlhbWwNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVk
aWF0ZWssbXQ3OTg2LWFmZS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LWFmZS55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmViYjE1MWM2NDAwZg0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
bWVkaWF0ZWssbXQ3OTg2LQ0KPiA+IGFmZS55YW1sDQo+ID4gQEAgLTAsMCArMSw4OSBAQA0KPiA+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVz
ZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IA0KPiA+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRp
YXRlayxtdDc5ODYtYWZlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFud3RKSU11b2FUNVJp
VWxGVS0wRXhMaHZXSGd6OW55WG0wSnhrOVJmb2FLcUlLelM4X0pUdmRJVzlBaE9rVElwVmpOOUp2
M0w3QWo0blh6VEVldUhLMi1XZHE2OW1vMCTCoA0KPiA+ICANCj4gPiArJHNjaGVtYTogDQo+ID4g
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbnd0SklNdW9hVDVSaVVsRlUt
MEV4TGh2V0hnejlueVhtMEp4azlSZm9hS3FJS3pTOF9KVHZkSVc5QWhPa1RJcFZqTjlKdjNMN0Fq
NG5YelRFZXVISzItV28xZWJ2eDgkwqANCj4gPiAgDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFU
ZWsgQUZFIFBDTSBjb250cm9sbGVyIGZvciBNVDc5ODYNCj4gPiArDQo+ID4gK21haW50YWluZXJz
Og0KPiA+ICsgIC0gTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gKw0K
PiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4g
PiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3OTg2LWFmZQ0KPiA+ICsgICAgICAtIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ3OTgxLWFmZQ0KPiA+ICsgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3OTg4LWFmZQ0KPiA+
ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3OTg2LWFmZQ0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWluSXRl
bXM6IDUNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdWRpbyBi
dXMgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gMjZNIGNsb2NrDQo+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IGF1ZGlvIGludGJ1cyBjbG9jaw0KPiA+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBhdWRpbyBob3BwaW5nIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246
IGF1ZGlvIHBsbCBjbG9jaw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIHBjbV9t
Y2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogYXVkaW8gaTJzL3BjbSBtY2sNCj4gPiArDQo+
ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogNQ0KPiA+ICsgICAgaXRlbXM6
DQo+ID4gKyAgICAgIC0gY29uc3Q6IGJ1c19jaw0KPiA+ICsgICAgICAtIGNvbnN0OiAyNm1fY2sN
Cj4gPiArICAgICAgLSBjb25zdDogbF9jaw0KPiA+ICsgICAgICAtIGNvbnN0OiBhdWRfY2sNCj4g
PiArICAgICAgLSBjb25zdDogZWcyX2NrDQo+ID4gKyAgICAgIC0gY29uc3Q6IHNlbA0KPiA+ICsg
ICAgICAtIGNvbnN0OiBpMnNfbQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21w
YXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIGNsb2Nr
cw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtIGFzc2lnbmVkLWNsb2Nrcw0KPiA+ICsg
IC0gYXNzaWduZWQtY2xvY2stcGFyZW50cw0KPiANCj4gYXNzaWduZWQtY2xvY2tzIGFuZCBhc3Np
Z25lZC1jbG9jay1wYXJlbnRzIGFyZSBub3QgYSAqcmVxdWlyZWQqDQo+IHByb3BlcnR5LA0KPiBh
cyB0aGF0IGRlcGVuZHMgb24gYSBudW1iZXIgb2YgdGhpbmdzIGFuZCBzb21lb25lICptYXkqIHdh
bnQgdG8gb21pdA0KPiBpdC4NCj4gDQo+IEJlc2lkZXMsIHRoYXQncyByZWxhdGVkIHRvIGhvdyB0
aGUgZHJpdmVycyBpbnRlcmFjdCB3aXRoIC8gc2V0dXAgdGhlDQo+IGhhcmR3YXJlDQo+IGFuZCBu
b3Qgd2l0aCB0aGUgaGFyZHdhcmUgaXRzZWxmLi4uIHlvdSBjYW4ga2VlcCB0aGUgYXNzaWduZWQt
Y2xvY2tzDQo+IGFuZA0KPiBhc3NpZ25lZC1jbG9jay1wYXJlbnRzIGluIHlvdXIgZXhhbXBsZXMs
IGJ1dCBhZ2FpbiB0aGV5J3JlIGRlZmluaXRlbHkNCj4gbm90DQo+IHJlcXVpcmVkIHByb3BlcnRp
ZXMuDQo+IA0KPiBBZnRlciBmaXhpbmcsDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNj
aGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtz
IGZvciB5b3VyIHJldmlldy4NCkknbGwgcmVtb3ZlIHRoZXNlIGluIHY0IHBhdGNoIQ0KDQpCZXN0
IHJlZ2FyZHMsDQpNYXNvDQoNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210Nzk4Ni1jbGsuaD4NCj4gPiArDQo+ID4gKyAg
ICBhZmVAMTEyMTAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3
OTg2LWFmZSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MTEyMTAwMDAgMHg5MDAwPjsNCj4gPiAr
ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA2IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
PiA+ICsgICAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FVRF9CVVNfQ0s+
LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FVRF8yNk1f
Q0s+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FVRF9M
X0NLPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9BVURf
QVVEX0NLPiwNCj4gPiArICAgICAgICAgICAgICAgICA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9B
VURfRUcyX0NLPjsNCj4gPiArICAgICAgICBjbG9jay1uYW1lcyA9ICJidXNfY2siLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIjI2bV9jayIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAibF9jayIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAiYXVkX2NrIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICJlZzJfY2siOw0KPiA+ICsgICAgICAgIGFzc2lnbmVkLWNsb2Nr
cyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9BMVNZU19TRUw+LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9BVURfTF9TRUw+LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9BX1RVTkVSX1NFTD47DQo+ID4gKyAg
ICAgICAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9BUExMMl9E
ND4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmYXBtaXhlZHN5cyBD
TEtfQVBNSVhFRF9BUExMMj4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwmdG9wY2tnZW4gQ0xLX1RPUF9BUExMMl9END47DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiAr
Li4uDQo+IA0KPiANCg==
