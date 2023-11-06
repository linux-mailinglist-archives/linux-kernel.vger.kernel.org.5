Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71177E1851
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKFB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKFB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:28:09 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F9E0;
        Sun,  5 Nov 2023 17:27:59 -0800 (PST)
X-UUID: b36852827c4311eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FIwf+IolEGFuI0HNS3rMmZdl3i4DfQ/JuwLi1s5FFrA=;
        b=KPXiGxcfZVAyCUeq7GdAEw07YmA3Az5i1QUscCCUXVvXV+nYpe3k5e1+rSOBzZa3nX75aEFqemjXLZbI58MTPOCeQXFo1PFnT2yRf15xRQE03GMsRwdXLh6wbYjHS1LUecTUKzjX/oZjUjtSqHZm9vq0bmS/4o5PseD/8yDypeg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ace0e87e-c627-489c-a560-1fe0acdb42d0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:11022efc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b36852827c4311eea33bb35ae8d461a2-20231106
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1546431142; Mon, 06 Nov 2023 09:27:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 09:27:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 09:27:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0TkG3JE5qd0lGVgXnFH8HfvpMyC+1a+1tzZ9RDqRpw7+fYUlKrWz1MmbeBu39b2Gru53/DlkF3b5ySMg6Ul8MlMgI3PPD6uHlWZm2HDhEgbA7CRtvI08bCY4YsSssepqWJxw/YXubs1BcUvTsbAa6ppWqI9fHGWt1Z6vf0p5ES4PSuyxPNO9CESu/wiHfm6l8mun+RpzZjYAWm14/KF0XWJS6iWwF0m+OLwwwa7hNj6rt3Vvx2XdPIK8j1W8ZPcUTyj+vZmI/GMV7GlLBhyOHQjyp/Br+cthKB+ZL0dXQBHyCr+iUsc3/nZXlr3ia8O5fG1/jTEkSbJFzA8ob/AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIwf+IolEGFuI0HNS3rMmZdl3i4DfQ/JuwLi1s5FFrA=;
 b=FV6K1OI/4ihlDJML0XryVdOkv0mUXVCCAO+Q7ioFFvI/EqzvqD2j12+Pe7N/n+ThA1bF8H5b7cx0i6Z20alTQeyQXUJUu9q3jjoyRstplF6oviTSwnuJvznkXcUdOK23ZuOls2+laCb4uxU9AXaim+bLXJp4XdYkTAm55MHBqeflH+PNKG/+Ko7/Dj/ZES9BrIpsqHZ8eNb79kb77erB7E4pqyDqhabChQa2CZAwYznqy+VJ8WwKqGKQ5lFBjj8OXSwNIFrt8qYq6XEapQ2ZU+LIW/aTXLrpuQuYMAeifmWfK93TblbFUgPXff/Vmigbydc5fVg/POTjTEaY4tF33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIwf+IolEGFuI0HNS3rMmZdl3i4DfQ/JuwLi1s5FFrA=;
 b=rDhqB2F3JAXlT5v0A3EtkLqQMa2iDzlE7bPud4TJBAUPHGWL9QhMzEkLFxn6GmCBRlwrUSRgqCQk26//g76DbpQEsPZxVX4mFzOOBEFOotmp/cQPscSHQaHy9pioDLqHTCATlFOaQvy+2LFs36VbwFu1OIqDltUQiMUIjYKt+eU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8314.apcprd03.prod.outlook.com (2603:1096:101:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 01:27:46 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 01:27:46 +0000
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
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
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
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWv9A+i72gD9wE2ClQpB4tiv3bBjdJYAgAhR5ICAAM+RgA==
Date:   Mon, 6 Nov 2023 01:27:46 +0000
Message-ID: <137cd99b6749e7a2e3b7fa091fd9a20d3c798c53.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <02187af1e98093d20a170d0ce4b2b428c7eee37d.camel@mediatek.com>
         <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
In-Reply-To: <c0b47da99e0a43e867a3fb27efc36786d4315aea.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8314:EE_
x-ms-office365-filtering-correlation-id: 82b1ec5f-c2ad-453f-de45-08dbde6794f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3cA0+sh0USkos1dKBDkOA8VHVrppiKrYmm3jjb5LiDMuujaB8/lmg5763b0SJiO11C6qBkRvl5R4owmlE5fwGHFJBE0mZdtF0La3XLCgEPCUxjxrjlBkiQ+a0CC6WiuJa12d4rrxfPHFGXYsuCmU5tMSJ6/Fb76/CurdXYdqKBk76CjyPgqFst+c202qBlgAmeWbbHwsD+vicewR2CSc5602EqyAFtlIvyjTAB2iUKEFwlVIU5WFt53+3bpNnBSrmzH0bsRnxV3F5beK7VZFc6jw522BfErBzA7tQi97d03pKsLORdjto9G+JVDa0we9IMRHcq1IJF4MFtGK1ATbY/WYTzLWIm7kujI9My+fl6lwqzsmAtBkZ9vVub0zlp3MWbeqmVOvcegRF7RshKdAtejmrQNoAvRn5m1fWm1gWMDECM4/+diPvs0f5vy5ZhgVKDqT20BqaceslrAr6gvnA/ni9QFaeEUvZB6lr0x2CmL2i+RWJZ9S+rYEs80Xmf5v6xAwr0PmsIbYy527LG5T9LqqnBuOZQGHlHkXUN6GrF8xgoLytneO7YV4OYV5Aoh29/TrpXu4MHs75hYEPZa46du25MQxI/gLSHgugbRDgCfXnPbm0Nq7JmZJvcgP77PZwv3MVsjF9SnDzPM8RiO+9FqLmkUf4W9TVfZPP2xMO+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(4326008)(2906002)(5660300002)(7416002)(4001150100001)(41300700001)(83380400001)(316002)(38070700009)(8936002)(8676002)(86362001)(64756008)(66476007)(66556008)(85182001)(76116006)(66946007)(36756003)(54906003)(38100700002)(6506007)(478600001)(71200400001)(66446008)(122000001)(110136005)(2616005)(6486002)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1Zyc1U1Smhia0ptWkdYMU5Wa1JmWHRnczh5MzlsWW40L0JJVTlnSU0vR24v?=
 =?utf-8?B?MVJBVTBjTml1aFgxME43b3k2WGdXaDZnN1VLNFVQWjMyZGJBMzNpNkMwU1p5?=
 =?utf-8?B?dkpWYS9Ed043eitwUkQwaFZHWFJ0b2VuZlI3RGxsQ2lvRnFrNVpnanlVZWRq?=
 =?utf-8?B?MVNnaVFNU2NvamV2S240RDBuaHY0WmdHd3hpanNEZ2FZUGRVMERsQ2JCTDNL?=
 =?utf-8?B?cERWZGpjODROMUYvWWhFQVpCdVU1VkR1V2E1Qm5sbnpHY1JyNGlodmxvd1Vi?=
 =?utf-8?B?SHF3VmNkQVpWdUc2NnRybUU4YTdaNXVqeTVhbzI5MERpZllOeER1Yy8xZW5Z?=
 =?utf-8?B?elhOSklqV0FOTHBZeVFnTUFXSldDcXhnRXVVVmVSYmpsazVGYmV6bXlxSnVH?=
 =?utf-8?B?YVY3RVRhemtkYmlJSzh5QlROcnFuYlpRWnRxaEoySlU5SXp4dmxLQThmNGty?=
 =?utf-8?B?dDhQTE1FRXAyYnIzbnVZMm0vaHFvRlBhcGxvS1BjaVpqWEdDa2gzK2s3eUYw?=
 =?utf-8?B?d0YxMDZ4N0JCTjkwWFNsT2tONStOcnpKOTBsbzRMdWZuTGY3NkJnREUyYXRz?=
 =?utf-8?B?b2ZnenVyQWtuczM0c1RVSGhMUHZmRzJNZmZQNVA2ZVBCTFdLdHpvR0wwVjQ1?=
 =?utf-8?B?cDVNZTJTSUxSMDdGV0MwKzRUbzZwdHJoZ2JXdXY0L3Y5QU4vYk5LYzM1YTA1?=
 =?utf-8?B?WjUwaGJVMlYzN3Zqbkg1R283M2VJSVN1R2xZdERTY1dROUMvdytoL2dXNkQ0?=
 =?utf-8?B?TW4xYjFUV1JBUFVHQmhrOUowN0dMQ3VSMEFmTlc3WVpSQWpHYXY3akIwM0E2?=
 =?utf-8?B?cmxLUTM4SzdEUWdXcm9UY2pRcGJrY3hORUQ4SXBxZGRTczM0M1RMK2sySUFn?=
 =?utf-8?B?TVIzd2VGUGNnODhwL2RHeUthU3AwcWtrSHd0a1BvNDlvcExWZi9hVUdLdVVo?=
 =?utf-8?B?Y29SSjJOSWVQSHJQcE90MjZhTHNVS0ZPMFNGSCtPcHNmOE5nMDRIcFRqcXNV?=
 =?utf-8?B?L3dueGhPektxRVdzTFF4Mm85OWxLazdNclN2aDRqb3JIeEhnVmpQMWQ4NlMx?=
 =?utf-8?B?OTd0Q1c2WDloTXRXTmt2dTVkYUt2UnFKNzEzZ1BmUVBWbEFvZ3MydURsSnll?=
 =?utf-8?B?OC90ZjFabkhFT3duRk5jaCtSdW95cVg0L3M0blFXbmdPUytNRi9uWFh0dy9H?=
 =?utf-8?B?VjhzNWRNUlVoL1RhSW1kdDZTWGFUUHI1ZTBEZXFsOXpUeWFIVTRnbFpma1dq?=
 =?utf-8?B?NXlsT1FyczZJRW93VVNEOUNWcWtpeENYUlQ1cDlQbG9HN1hKNUg4dlhSanZT?=
 =?utf-8?B?MERhellmNVc5VmQrblhCcTV6bWlESmVjYlpWTCtIZ0duL0lZakFCQlhJRXBV?=
 =?utf-8?B?VytoTTJidXV5MklucVBqa3ptemN6clB5anNMMVY2V2R6NEJYbjJWSjkyTVk0?=
 =?utf-8?B?bUpaWEtFVW9ONkRsNkpNd2ROZTF1MEFkZlppMnRabURUenlqZkxLZElwbml3?=
 =?utf-8?B?TTBUV0dINXFJektSQ2dzT0FISkdDM1VDa1I1Z3RhZ1UrbXdHTXhYYmc4S2NK?=
 =?utf-8?B?c2VJTlZKaWRJZ2hpUENaZGNva3NXNXBjWk9tNVl6NDRhQVBEUitSbHJ0UFVa?=
 =?utf-8?B?Y0pNaDJjekJuNE9TdU4rYlFJdHQ2N0pydnBBbXNFdkswUXpEdkVyVGpyeFZ1?=
 =?utf-8?B?T2VKSVVheFI3Y0NDajZpVU11U241V2tmYkQ5TXlFMk5mb3ZSczdpQjU0MVBp?=
 =?utf-8?B?bXNYZXloS3NuZUFHUWZyd0s4a0ZudUhMZndyalE1a2dwd0QweUw4NVpTeGpU?=
 =?utf-8?B?T3NYTjNzV1ZSVlVDV0ZtQVdoR09DOVdic2JLZWhGaEhWNzJrVmFvekxTZDZX?=
 =?utf-8?B?aVZiZVYyT3V5eGZsSmxOT0VBOEU3L0tOR1NmZFYrTnZqWHh1MTlZSzZOOXNa?=
 =?utf-8?B?cE5YMmp4OVUrdkV1bnlMcUdYZjQwMGVnV3VwMm1yaG5zUnM5c24wc2lndTNK?=
 =?utf-8?B?VU1GQWdnMU5HWTV4b1NQVEE4THc1UVJRbFN2R1M5NXRjVnJwUkpnenIyUE41?=
 =?utf-8?B?QjFSMS9ZQ0FibndPck4vSUFKMVBPL0Z1YkdmRnB1clBHbS9hSzcxUmZ0K2JC?=
 =?utf-8?Q?dgw7YOP0+lcuxg+4JC33afDms?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A12E457C119CC64EA3ADDB0FB0CB5A37@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b1ec5f-c2ad-453f-de45-08dbde6794f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 01:27:46.5107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJi1RYGUq6kegkiDoQCePCXvg56uXcxQStmgmxAZ3KPJyNiUJHbq+t99g0isYGzhJY9JFajbM9TrBqkVAMMuGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8314
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.895600-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F4OwH4pD14DsPHkpkyUphL9fjJOgArMOCZV1lQ/Hn0TOtj3
        ZmXrgmMgUP1MXr5ntoTa0d8z9Gm40BtlRBeFg9jMTd1FGyH+HrKZf5btvM85AenZDXpMs2JZGlS
        ob8qphoEZB0R4cFpbTf62rxjX6Lwx6fubsV+A+k+HZXNSWjgdU7uesBT0pDFR2viB/Jr4D1QfZ/
        c4tyoTbUIuHOzPMNGSCn3hS1T7H+eU2fVedEQUOzo39wOA02Lh+eBf9ovw8I0Cgjr7b0ytGcmL/
        yOcY1B66UiXS+55JmqvMY7/3p558hpTtEEj9y1VkX71Hy/ufOZA8JZETQujwizt4/lw8JZD+7tH
        HXbpFaTQGlxIVvV/XpGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.895600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 60E74AA2CBEA49966C3F90C3AE6E0FAD27945D056FD347D92C20EA09C94944222000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTExLTA1IGF0IDEzOjA0ICswMDAwLCBKYXNvbi1KSCBMaW4gKOael+edv+el
pSkgd3JvdGU6DQo+IE9uIFR1ZSwgMjAyMy0xMC0zMSBhdCAwNjowMSArMDAwMCwgQ0sgSHUgKOiD
oeS/iuWFiSkgd3JvdGU6DQo+ID4gSGksIEphc29uOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMy0x
MC0yMyBhdCAxMjo0NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gVG8gYWRkIHNl
Y3VyZSBmbG93IHN1cHBvcnQgZm9yIG1lZGlhdGVrLWRybSwgZWFjaCBjcnRjIGhhdmUgdG8NCj4g
PiA+IGNyZWF0ZSBhIHNlY3VyZSBjbWRxIG1haWxib3ggY2hhbm5lbC4gVGhlbiBjbWRxIHBhY2tl
dHMgd2l0aA0KPiA+ID4gZGlzcGxheSBIVyBjb25maWd1cmF0aW9uIHdpbGwgYmUgc2VudCB0byBz
ZWN1cmUgY21kcSBtYWlsYm94DQo+ID4gPiBjaGFubmVsDQo+ID4gPiBhbmQgY29uZmlndXJlZCBp
biB0aGUgc2VjdXJlIHdvcmxkLg0KPiA+ID4gDQo+ID4gPiBFYWNoIGNydGMgaGF2ZSB0byB1c2Ug
c2VjdXJlIGNtZHEgaW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSBzb21lDQo+ID4gPiBzZWN1cmUNCj4g
PiA+IHNldHRpbmdzIGZvciBkaXNwbGF5IEhXIGJlZm9yZSBzZW5kaW5nIGNtZHEgcGFja2V0cyB0
byBzZWN1cmUNCj4gPiA+IGNtZHENCj4gPiA+IG1haWxib3ggY2hhbm5lbC4NCj4gPiA+IA0KPiA+
ID4gSWYgYW55IG9mIGZiIGdldCBmcm9tIGN1cnJlbnQgZHJtX2F0b21pY19zdGF0ZSBpcyBzZWN1
cmUsIHRoZW4NCj4gPiA+IGNydGMNCj4gPiA+IHdpbGwgc3dpdGNoIHRvIHRoZSBzZWN1cmUgZmxv
dyB0byBjb25maWd1cmUgZGlzcGxheSBIVy4NCj4gPiA+IElmIGFsbCBmYnMgYXJlIG5vdCBzZWN1
cmUgaW4gY3VycmVudCBkcm1fYXRvbWljX3N0YXRlLCB0aGVuIGNydGMNCj4gPiA+IHdpbGwNCj4g
PiA+IHN3aXRjaCB0byB0aGUgbm9ybWFsIGZsb3cuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAyNzINCj4g
PiA+ICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5oICB8ICAgMSArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYyB8ICAgNyArDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyNjkg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4gPiANCg0KW3NuaXBdDQoNCj4gPiA+
ICsNCj4gPiA+ICsjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiA+ICtzdGF0
aWMgdm9pZCBtdGtfY3J0Y19lbmFibGVfc2VjdXJlX3N0YXRlKHN0cnVjdCBkcm1fY3J0YyAqY3J0
YykNCj4gPiA+ICt7DQo+ID4gPiArCWVudW0gY21kcV9zZWNfc2NlbmFyaW8gc2VjX3NjbiA9IENN
RFFfTUFYX1NFQ19DT1VOVDsNCj4gPiA+ICsJaW50IGk7DQo+ID4gPiArCXN0cnVjdCBtdGtfZGRw
X2NvbXAgKmRkcF9maXJzdF9jb21wOw0KPiA+ID4gKwlzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtf
Y3J0YyA9IHRvX210a19jcnRjKGNydGMpOw0KPiA+ID4gKwl1NjQgc2VjX2VuZ2luZSA9IDA7IC8q
IGZvciBodyBlbmdpbmUgd3JpdGUgb3V0cHV0IHNlY3VyZSBmYiAqLw0KPiA+ID4gKwl1NjQgc2Vj
X3BvcnQgPSAwOyAvKiBmb3IgbGFyYiBwb3J0IHJlYWQgaW5wdXQgc2VjdXJlIGZiICovDQo+ID4g
PiArDQo+ID4gPiArCWNtZHFfcGt0X3dmZSgmbXRrX2NydGMtPnNlY19jbWRxX2hhbmRsZSwgbXRr
X2NydGMtPmNtZHFfZXZlbnQsDQo+ID4gPiBmYWxzZSk7DQo+ID4gPiArDQo+ID4gPiArCWRkcF9m
aXJzdF9jb21wID0gbXRrX2NydGMtPmRkcF9jb21wWzBdOw0KPiA+ID4gKwlmb3IgKGkgPSAwOyBp
IDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspDQo+ID4gPiArCQlpZiAobXRrX2NydGMtPnBsYW5l
c1tpXS50eXBlID09IERSTV9QTEFORV9UWVBFX0NVUlNPUikNCj4gPiA+ICsJCQlzZWNfcG9ydCB8
PQ0KPiA+ID4gbXRrX2RkcF9jb21wX2xheWVyX2dldF9zZWNfcG9ydChkZHBfZmlyc3RfY29tcCwg
aSk7DQo+ID4gPiArDQo+ID4gPiArCWlmIChkcm1fY3J0Y19pbmRleChjcnRjKSA9PSAwKQ0KPiA+
ID4gKwkJc2VjX3NjbiA9IENNRFFfU0VDX1BSSU1BUllfRElTUDsNCj4gPiA+ICsJZWxzZSBpZiAo
ZHJtX2NydGNfaW5kZXgoY3J0YykgPT0gMSkNCj4gPiA+ICsJCXNlY19zY24gPSBDTURRX1NFQ19T
VUJfRElTUDsNCj4gPiA+ICsNCj4gPiA+ICsJY21kcV9zZWNfcGt0X3NldF9kYXRhKCZtdGtfY3J0
Yy0+c2VjX2NtZHFfaGFuZGxlLCBzZWNfZW5naW5lLA0KPiA+ID4gc2VjX3BvcnQsIHNlY19zY24p
Ow0KPiA+IA0KPiA+IEluIGNtZHEgZHJpdmVyLCBzZWNfZW5naW5lIG1lYW5zIGVuZ2luZSB3aGlj
aCBuZWVkIGRhcGMuIFlvdSBzZXQgMA0KPiA+IHRvDQo+ID4gc2VjX2VuZ2luZSwgZG9lcyBpdCBt
ZWFuIHRoYXQgbm8gZW5naW5lIGlzIHByb3RlY3RlZCBieSBkYXBjPyBJZg0KPiA+IE9WTA0KPiA+
IGlzDQo+ID4gbm90IHByb3RlY3RlZCBieSBkYXBjLCBJIHRoaW5rIHdlIGNvdWxkIHVzZSBjbWRx
IG5vcm1hbCB0aHJlYWQgdG8NCj4gPiB3cml0ZQ0KPiA+IE9WTCByZWdpc3RlciBpbnN0ZWFkIG9m
IGNtZHEgc2VjdXJlIHRocmVhZC4NCj4gPiANCj4gDQo+IFdlIGVuYWJsZSBEUEFDIHByb3RlY3Rp
b24gZm9yIHRoZSBlbmdpbmUgdGhhdCBpcyBhYmxlIHRvIHdyaXRlIGRhdGENCj4gdG8NCj4gdGhl
IERSQU0gYWRkcmVzcyBzZXQgb24gdGhlaXIgcmVnaXN0ZXIsIHN1Y2ggYXMgV0RNQSBhbmQgV1JP
VCwgdG8NCj4gYXZvaWQNCj4gdGhlaXIgcmVnaXN0ZXIgYmVpbmcgc2V0IHRvIHRoZSBub3JtYWwg
RFJBTSBhZGRyZXNzLg0KPiANCj4gV2UgZW5hYmxlIGxhcmIgcG9ydCBwcm90ZWN0aW9uIGZvciB0
aGUgZW5naW5lIHRoYXQgaXMgYWJsZSB0byByZWFkDQo+IGRhdGENCj4gZnJvbSB0aGUgRFJBTSBh
ZGRyZXNzLCBzdWNoIGFzIE9WTCwgUkRNQSBhbmQgTURQX1JETUEsIHRvIGF2b2lkDQo+IHNlY3Vy
ZQ0KPiBEUkFNIGJlaW5nIHJlYWQgYnkgdGhlIG5vbi1zZWN1cmUgbGFyYiBwb3J0LiBTbyB3ZSBk
b24ndCBuZWVkDQo+IHRvZW5hYmxlDQo+IERBUEMgZm9yIHRoZXNlIGVuZ2luZXMuDQo+IA0KPiBO
byBtYXRlciBEQVBDIHByb3RlY3Rpb24gb3IgbGFyYiBwb3J0IHByb3RlY3Rpb24sIHRoZXkgYm90
aCBuZWVkIHRvDQo+IHVzZQ0KPiBzZWNfZW5naW5lIHRvIHRlbGwgVEVFIHdoaWNoIGVuZ2luZXMg
bmVlZCB0byBiZSBwcm90ZWN0ZWQuDQo+IA0KPiBCdXQgT1ZMIGlzIGEgc3BlY2lhbCBIVyBlbmdp
bmUsIGl0IGNhbiBvbmx5IHNldCBpdHMNCj4gRElTUF9SRUdfT1ZMX1NFQ1VSRQ0KPiByZWdpc3Rl
ciBpbiBbUEFUQ0ggdjIgMDcvMTFdIHRvIGVuYWJsZSBpdHMgbGFyYiBwb3J0IHByb3RlY3Rpb24s
IHNvDQo+IE9WTA0KPiBubyBuZWVkIHRvIHNldCB0aGUgc2VjX2VuZ2luZS4gQnV0IHdlJ2xsIG1v
dmUgdGhhdCBwYXJ0IHRvIHRoZSBURUUNCj4gc2VjdXJlIHdvcmxkLCBzbyB0aGF0IG1lYW5zIE9W
TCBzZWNfZW5naW5lIHdpbGwgYmUgc2V0IGhlcmUgaW4gdGhlDQo+IG5leHQNCj4gdmVyc2lvbi4N
Cj4gDQo+ID4gSXQncyB3ZWlyZCB0aGF0IG5vcm1hbCB3b3JsZCBjb3VsZCBkZWNpZGUgd2hpY2gg
ZW5naW5lIGlzIHByb3RlY3RlZA0KPiA+IGJ5DQo+ID4gZGFwYy4gSWYgaGFja2VyIHNldCAwIGZv
ciBvdXRwdXQgZW5naW5lLCB0aGVuIG91dG91dCBlbmdpbmUgd291bGQNCj4gPiBub3QNCj4gPiBi
ZSBwcm90ZWN0ZWQ/DQo+ID4gDQo+IA0KPiBJZiBoYWNrZXIgc2V0IDAgZm9yIG91dHB1dCBlbmdp
bmUsIFRFRSB3b3JsZCB3aWxsIGNoZWNrIHRoYXQgb3V0cHV0DQo+IGVuZ2luZSBkaWRuJ3Qgc2V0
IHNlY19lbmdpbmUgZnJvbSBub3JtYWwgd29ybGQgYnkgdmVyaWZ5aW5nDQo+IGluc3RydWN0aW9u
DQo+IHdoZXJlIHRoZSBvdXRwdXQgZW5naW5lIGluc3RydWN0aW9uIHNldCB0aGUgc2VjdXJlIGhh
bmRsZS4NCj4gDQo+IFdlIHN0aWxsIG5lZWQgdG8gc2V0IHNlY19lbmdpbmUgdG8gY2hlY2sgdGhh
dCBhbGwgdGhlIHNlY19lbmdpbmUgZmFncw0KPiBhcmUgbWF0Y2hlZCB0byB0aGUgc2NlbmFyaW8g
YW5kIGluc3RydWN0aW9uIHZlcmlmaWNhdGlvbiBpbiB0aGUNCj4gc2VjdXJlDQo+IHdvcmxkLg0K
DQpTbyBhZnRlciBzZWN1cmUgc2NlbmFyaW8gaXMgc2V0LCBURUUgYWxyZWFkeSBoYXZlIGEgc2Vj
X2VuZ2luZSBsaXN0Lg0KTGV0J3MgY2FsbCBpdCBURUUgc2VjX2VuZ2luZSBsaXN0LiBBbmQgbm9y
bWFsIHdvcmxkIGhhcyBhbm90aGVyDQpzZWNfZW5naW5lIGxpc3QsIGxldCdzIGNhbGwgaXQgbm9y
bWFsIHNlY19lbmdpbmUgbGlzdC4gTm9ybWFsIHdvcmxkDQpwYXNzIG5vcm1hbCBzZWNfZW5naW5l
IGxpc3QgdG8gVEVFIGJ5IGNtZHFfc2VjX3BrdF9zZXRfZGF0YSgpIGFuZCBURUUNCndvdWxkIGNo
ZWNrIG5vcm1hbCBzZWNfZW5naW5lIGxpc3QgaXMgaWRlbnRpY2FsIHRvIFRFRSBzZWNfZW5naW5l
IGxpc3QNCm9yIG5vdC4gSWYgVEVFIGFscmVhZHkgaGF2ZSBhIFRFRSBzZWNfZW5naW5lIGxpc3Qs
IEkgdGhpbmsgaXQncyBub3QNCm5lY2Vzc2FyeSB0aGF0IG5vcm1hbCB3b3JsZCBoYXZlIGFub3Ro
ZXIgbm9ybWFsIHNlY19lbmdpbmUgbGlzdC4gU28NCmRyb3AgdGhpcyBub3JtYWwgc2VjX2VuZ2lu
ZSBsaXN0IHBhcmFtZXRlci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEph
c29uLUpILkxpbg0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiArDQo+ID4g
PiArCXByX2RlYnVnKCJjcnRjLSVkIGVuYWJsZSBzZWN1cmUgcGxhbmUhXG4iLA0KPiA+ID4gZHJt
X2NydGNfaW5kZXgoY3J0YykpOw0KPiA+ID4gK30NCj4gPiA+ICsjZW5kaWYNCj4gPiA+IA0K
