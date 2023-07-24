Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8992F75EB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGXGST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGXGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:18:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684CE43;
        Sun, 23 Jul 2023 23:18:07 -0700 (PDT)
X-UUID: d78f8a7429e911ee9cb5633481061a41-20230724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=zJY+8QNTq59dj1DfradbqzRLB9XYr2ZqdDf03FWMkYw=;
        b=cjfgJDqP4oQZpSytuEzGR7cV4zqCpz4PPv46lOGpf+agB1RshbXBFraFyddt8xNzpulKRA9TrGzp0BhUwqJIxfT/yTf0QDa475LqY26LbhVrC/sfufT9U8k2iUheNeVA5lsj5jlr16L/s/LolLHdYkOXcGBpzcZMItCsja6FRaE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:27046013-98f2-4289-8f40-66e008983850,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:e7562a7,CLOUDID:3883f687-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d78f8a7429e911ee9cb5633481061a41-20230724
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1213990082; Mon, 24 Jul 2023 14:18:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jul 2023 14:18:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 24 Jul 2023 14:18:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/FYPM88RGC2sQh1q3R6wZYWciEVsV5GZ1GmraDx1c/903jrz/QVtrFuOwH6Q2LSVw4gQqb7FV3GfmgOPCP5/NWV0zI2uyCkv/0cteh6wsAIxczluYq1AqDtIUUWJJ+eER5uJK7Ze7+2VImDUBglDoAG5jKeLPCGNTUAQnVtmiqebz6o+Ek+KgfRkd0wzcnv6c+nfkWUx8zvCRqLP94ODRFk7iJpRhyTcWDcBvPcDjT3XtNNpFbsQAWZy+nuGnlL8cc8UcrNaDeO00lDIXyH2pjWNqBVL+rkLzD7QHJUh8CPLKtZ/SjRljjL2YFg1TYNwDbkK+SKUb6INd88+vJIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJY+8QNTq59dj1DfradbqzRLB9XYr2ZqdDf03FWMkYw=;
 b=cqCOvteOsVro1pI0ZpFJDxK7gI23xX22Pz1l8QDCj3LAAkDcXl2M8h8YJD1wjHy4ADHF+g7TlL6IME4FKACMuINpGyEippV8nD1AKasi3mWEZiPCRwQ5cNSLlLHCPGM+BMZCCCtOmVwrzidX4eiMsj/joQOjM+5eQGA4JGUmFDzlbzfqcaBPt+AlQAXAHlwCJiW4HO1UeaZGc2qDPw8CyCX8WTuiIlZpMAuGmDPh6TTe9l7bbH+2DVzY2C4IPCBW37/+WhkybiHFjFiN14inPI6JImKWCwMotoeAImX8VMKUTGmabRl1zaJvKjw13JHvaqMGcxOLGEEdHMhF5nqY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJY+8QNTq59dj1DfradbqzRLB9XYr2ZqdDf03FWMkYw=;
 b=p/gMP/yWxQRIzr3v6EYmMbySpw/Q24rUHG9nNumtoaVUffFXzj6coopCUo65ftW/LoWGkDzGhxiEkjTNpHcbKpeJBaOzSA1pBWqJVchnS54sGyS9yYeWugOCiDCKGMMzA7EUWVhwXaC08cORBuAhVhYPVaKZPj2BJDNrgTJg5Q8=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYSPR03MB7388.apcprd03.prod.outlook.com (2603:1096:400:416::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:17:58 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:17:58 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 0/7] ASoC: mediatek: Add support for MT7986 SoC
Thread-Topic: [PATCH v2 0/7] ASoC: mediatek: Add support for MT7986 SoC
Thread-Index: AQHZp9beuKJHxJOqjUqF7OPihh56ja/InX+A
Date:   Mon, 24 Jul 2023 06:17:58 +0000
Message-ID: <04a1a53ebd9df265da780c644a0db86952cde8db.camel@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
In-Reply-To: <20230626023501.11120-1-maso.huang@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYSPR03MB7388:EE_
x-ms-office365-filtering-correlation-id: a0ff024a-1990-4998-3165-08db8c0db9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeGzF8yK6lwJcGpj81d1SJtDKvhMyiTWrq/TiUvkxs+Mykn2tC/dxvCL+ArnZDuUiVy8QTRfEIS9+FzTccWpdOuyEnGAq7nZfOmUMmv92SeiiiHGkxAWkaoNfc/fvAjD2MZNrJRvHzDdMitcmAM6MxacA3QwgVTCbsJUJYh9cyRAoyJJr2VRieZEnK3W2OBKwGA2Qmb+nVtX2rvt5nqVnVgrIiPZWq+SpFTkEwmFb0mQaF1oOOc/nVPuyAtA10JrJUu5B0j+eyMo3tAkOoFuiSmOq665CBvSO6psnttpY4G7PIzIbNvglgZo9Ss5jP+cDoZqZgvx15+fwxUj1mM0t9VGE6/VmkzlSZNublGtHvQpVN2uKZ/H51OStkP0nAJKiaoeB/rlOAdTucnTgXpm5b3asgcxPDzylQgkZgzLwy2T/Km8IMM5iBsIMGGXtzhyCrzaMYLtNLKrXVTA46YjbZdLcba1MXmCl8ghZnRTG7uEYjoqiGpUnsNtIVJHef2vkK8xSRQ3zhzFNd/ktVsw6qdj1t5m8elAB4VF8of2znlkw0jLJIPiSugwgde1nq2ik3H6EdZ8wOy7HkfhF285pRFcW/7X5EVj4uNCGZfK1RwyZKnNEex3UgAGnVhJkD0JBteHLRkZiRCusElGKclWlCPu0bQ+N+JB36ROHLNJ+Ss7Njv5TDmLm/AyG/y/cIta
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(84040400005)(451199021)(6512007)(6486002)(71200400001)(110136005)(478600001)(91956017)(83380400001)(86362001)(38070700005)(2906002)(2616005)(186003)(6506007)(26005)(76116006)(921005)(122000001)(38100700002)(36756003)(85182001)(66946007)(66476007)(66446008)(316002)(41300700001)(8676002)(8936002)(64756008)(66556008)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpRRllpNHVnRlVUSTFUT0l5cDdPejhqMjRJZjRCZFBBalpUQ3dqd1B4N2pP?=
 =?utf-8?B?SUdHSEVjbW9hRnB2YWFSMzltVnhEbHZjR2VLWEhaa2tsc2wvN21QVzNESjV3?=
 =?utf-8?B?NGhGTDRnc281S3MrOUx1Q1dVSmFib2VYYThVWXNDeFBwMHNYRFJHNU0yVGZ4?=
 =?utf-8?B?R3pOWGwyOFVDWHZWTmVGSDNsZE80NnBqUXlCNWtoNDdFMHZrSWRTSHhuTlpi?=
 =?utf-8?B?WFZ1cTR0NmU1Sk92TE5QY2dXMXRvVkR3dlpPcFdZWVNKTkM4MG5aNXJudkYw?=
 =?utf-8?B?MWlZdVJGL0hXS0srZ0dnbWc1VzJwNjZoYjdualNvN0x2Z0ZZekRSNVZ6cW03?=
 =?utf-8?B?Rmh1d2N1eFF5bzlBNXh6VE1xaU1WRFlkWXAxQm5kc1hSZkNpL051d3JQcE8r?=
 =?utf-8?B?U1ZvR1VEVEpqRVhPZyt3Y3loQmpwdTRQeDV4MCticityUEZOclFSZjhlQys1?=
 =?utf-8?B?ZmNQd3F3T043c0hzWjFYcW5ySUJ3REo2cnFDMkhnRlNsbHJYTFowSjF0akNG?=
 =?utf-8?B?WXpaMFFIMUd0ZVVJYjliQWdiSFg4ekoxdVBpem11SGlsblRwbXkvV2xiTkg5?=
 =?utf-8?B?MG56NW1HZFRCdDNoTWlGZ2FwQkhDYnNIMXVaSVZCbTNFR0wzdkJTcDc4Zzlm?=
 =?utf-8?B?dVpvaTNQUkJGOU8vdU9MYjE4T1BmTXdpOVROZGIzSlhJd0g5UmxveXJqVGJE?=
 =?utf-8?B?OVRpNnEzVE9EeWpqUkZwNUhWVjVoTE9FWVk4dnRZNWxjbk8ybDQrcVAzTU9Q?=
 =?utf-8?B?dVZlWmVQalBwbmNqV0ZJMm9iWUVlU3Flekw3akxkREYwUXRKV3N1cjlRWnNJ?=
 =?utf-8?B?MW45WnlkTVFhd1p6V253Y3AvWUlTWTh2UGNGczV1c3lPTEFuSDNVQUdwRmNN?=
 =?utf-8?B?S3RxVUE3RStqN2MyckswTFFWc1ljVm1kakdiakRVSXRzVm1WZGpPb1hjM2Z3?=
 =?utf-8?B?T1hSakZFaHJ0ZnRmcTk2cDZMWnp1Z2V4aW5NbzBmZCtIckhHZExHNGRLR3U1?=
 =?utf-8?B?MWh4a3VGSWNtcGtUb1JmcSs5cWFWSytzOGFMcHNGTGpQL1c3U0NUVXl4dFM4?=
 =?utf-8?B?WVV5R0puNFhkYklRTktGT3V1SjZaOEU4R2FuQXBBRGorODZZbGJyK1M3Z0Iw?=
 =?utf-8?B?bko3cnU4OTY0eEo2NmZtcEorRTBxOE9EaHRqaE5zRWlHUjIvL0NyZDdYc1My?=
 =?utf-8?B?bmtadlhnVVJobWRuU0lHemlnM3pVYjJ0a2RmODBjK1NaT0RCUm83aXl1cmtC?=
 =?utf-8?B?QTYzQTltcVVyTmk1QkZ5VHI4dUxPMFJ3V3lQWjdXOVJKUjI5N3BvQzFtN2Vj?=
 =?utf-8?B?TUhpQlJUY1I4TG1MbmVRaFNmdWY4ZXNGTytMZ1pkcjQySzhHM0drYnF5SG1C?=
 =?utf-8?B?RDEyTDE4bS9oOUxGVUVMWHpzNXZiMGVoUjNFTTQwWlB5U0FjUTh2SmQ4UWZQ?=
 =?utf-8?B?UzBVWllTT1hqZWFJQjFwN3R0NjA3OWRabmxPTWJZWEI5eUtwblgrdzZqU1Jx?=
 =?utf-8?B?SWFxemFLQnJXZm80aG1EVVVlUUhTVDBsNEwyV1dZZmZ3Y0JZNWtWLzRYRWtR?=
 =?utf-8?B?bzAxcnhmNFEyZFBJOTFXVE1FaTFsZy82c3o5NG5MN2V0dVduUUZBT2srS1BZ?=
 =?utf-8?B?TG4wY25PSHRXbWlWdGhKdklMYXltV0NSQUlZREtrR2RYeGZMNlBwa1R1ZGM2?=
 =?utf-8?B?S0x1YkZrZVZ6bldDY2REYzdwTFRGRHNrUkJqZmh5NEJ2d01IMkVVQW93NEs0?=
 =?utf-8?B?R1BKSzZ3aFdhVTVvTEtDcjNZTFp1MTFIRkphYlBJVEdoWjR1SndLbldtWEpU?=
 =?utf-8?B?d0lkTER6MTdxN256d1RxVjRMaFR6MGg4ZE5WU3ZNQllYKzJ4ZmU0K1ZRcXNv?=
 =?utf-8?B?WHovTGZxajJBbjB1Rk5LMGJ1bHphVHp6NEc3SFppb0FHdFVUM2xmOThBMnhv?=
 =?utf-8?B?UE1sRXlFT3dIdzlCaDFQMG5Vb3hodkl3VGc1TGs3SzBZbTJpblJtUVFNMVhS?=
 =?utf-8?B?YTI2d1BtYitFYVNjQTJXeWY4WkM1OUlPQjZMeXJsb1dhNDVtS3paS09la3Yw?=
 =?utf-8?B?MDd2U21lejdnbDRRUkhhWVQ5Z1lLZkZFRjl0UXBoSzNLWUhZMml3TGY2MWNL?=
 =?utf-8?B?QTlQVkIzZUt4ZnprWVREZEJOVmhWbG5QOUJKRzlUU2ZQSSswUzNoV09QL0FK?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C100B32A70C86B42B9DEDF3CDCE72A00@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ff024a-1990-4998-3165-08db8c0db9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:17:58.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVOp5EJRSHNy8fVuSoPBD+NrevC/67cUodjIBI22LUJf/9FLMsRNVMwiKxqd9p7luBExRx4FzQnobJqDEm05QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7388
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcgOikNCg0KSGkgUm9iIGFuZCBBbmdlbG8sDQoNCkNhbiB5b3UgaGVscCB0byBj
aGVjayB0aGlzIGxhdGVzdCBzZXJpZXMgYW5kIHNoYXJlIHlvdXIgdGhvdWdodHMgaWYNCmFueT8N
Cg0KQmVzdCByZWdhcmRzLA0KTWFzbw0KDQoNCk9uIE1vbiwgMjAyMy0wNi0yNiBhdCAxMDozNCAr
MDgwMCwgTWFzbyBIdWFuZyB3cm90ZToNCj4gQ2hhbmdlcyBpbiB2MjoNCj4gIC0gdjEgdGl0bGU6
IFtQQVRDSCAwLzddIEFTb0M6IG1lZGlhdGVrOiBBZGQgc3VwcG9ydCBmb3IgTVQ3OXh4IFNvQw0K
PiAgLSBhZGQgbWlzc2luZyBtYWludGFpbmVycw0KPiAgLSByZW5hbWUgbXQ3OXh4IHRvIG10Nzk4
NiBpbiBhbGwgZmlsZXMNCj4gIC0gdXNlIGNsayBidWxrIGFwaSBpbiBtdDc5ODYtYWZlLWNsay5j
IFsyLzddDQo+ICAtIHJlZmluZSBtdDc5ODYtYWZlLXBjbS5jIGJhc2VkIG9uIHJldmlld2VyJ3Mg
c3VnZ2VzdGlvbnMgWzQvN10NCj4gIC0gcmVmaW5lIGR0LWJpbmRpbmcgZmlsZXMgYmFzZWQgb24g
cmV2aWV3ZXIncyBzdWdnZXN0aW9ucyBbNi83XQ0KPiBbNy83XQ0KPiAgLSB0cmFuc3Bvc2UgWzMv
N10gYW5kIFs0LzddIGluIHYxIHRvIGZpeCB0ZXN0IGJ1aWxkIGVycm9ycw0KPiAgDQo+IFRoaXMg
c2VyaWVzIG9mIHBhdGNoZXMgYWRkcyBzdXBwb3J0IGZvciBNZWRpYVRlayBBRkUgb2YgTVQ3OTg2
IFNvQy4NCj4gUGF0Y2hlcyBhcmUgYmFzZWQgb24gYnJvb25pZSB0cmVlICJmb3ItbmV4dCIgYnJh
bmNoLg0KPiANCj4gTWFzbyBIdWFuZyAoNyk6DQo+ICAgQVNvQzogbWVkaWF0ZWs6IG10Nzk4Njog
YWRkIGNvbW1vbiBoZWFkZXINCj4gICBBU29DOiBtZWRpYXRlazogbXQ3OTg2OiBzdXBwb3J0IGF1
ZGlvIGNsb2NrIGNvbnRyb2wNCj4gICBBU29DOiBtZWRpYXRlazogbXQ3OTg2OiBzdXBwb3J0IGV0
ZG0gaW4gcGxhdGZvcm0gZHJpdmVyDQo+ICAgQVNvQzogbWVkaWF0ZWs6IG10Nzk4NjogYWRkIHBs
YXRmb3JtIGRyaXZlcg0KPiAgIEFTb0M6IG1lZGlhdGVrOiBtdDc5ODY6IGFkZCBtYWNoaW5lIGRy
aXZlciB3aXRoIHdtODk2MA0KPiAgIEFTb0M6IGR0LWJpbmRpbmdzOiBtZWRpYXRlayxtdDc5ODYt
d204OTYwOiBhZGQgbXQ3OTg2LXdtODk2MA0KPiBkb2N1bWVudA0KPiAgIEFTb0M6IGR0LWJpbmRp
bmdzOiBtZWRpYXRlayxtdDc5ODYtYWZlOiBhZGQgYXVkaW8gYWZlIGRvY3VtZW50DQo+IA0KPiAg
Li4uL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni1hZmUueWFtbCAgIHwgIDg5ICsrKw0K
PiAgLi4uL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni13bTg5NjAueWFtbCAgICAgICAgIHwgIDUzICsr
DQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgfCAgMjAg
Kw0KPiAgc291bmQvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4gIHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvTWFrZWZpbGUgICAgICAgICAgICB8ICAx
MCArDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmMgICAgfCAg
NzUgKysrDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtY2xrLmggICAg
fCAgMTggKw0KPiAgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtYWZlLWNvbW1vbi5o
IHwgIDUxICsrDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtcGNtLmMg
ICAgfCA1OTgNCj4gKysrKysrKysrKysrKysrKysrDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3
OTg2L210Nzk4Ni1kYWktZXRkbS5jICAgfCA0MjEgKysrKysrKysrKysrDQo+ICBzb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1yZWcuaCAgICAgICAgfCAyMDYgKysrKysrDQo+ICBzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni13bTg5NjAuYyAgICAgfCAxODQgKysrKysrDQo+
ICAxMiBmaWxlcyBjaGFuZ2VkLCAxNzI2IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWss
bXQ3OTg2LWFmZS55YW1sDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10Nzk4Ni13bTg5NjAueWFtbA0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvTWFrZWZpbGUNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUt
Y2xrLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210
Nzk4Ni1hZmUtY2xrLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsv
bXQ3OTg2L210Nzk4Ni1hZmUtY29tbW9uLmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9z
b2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1hZmUtcGNtLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni1kYWktZXRkbS5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9tdDc5ODYtcmVnLmgNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OTg2L210Nzk4Ni13bTg5NjAu
Yw0KPiANCg==
