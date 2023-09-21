Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24A7A9627
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIUQ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjIUQ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:59:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910681FC1;
        Thu, 21 Sep 2023 09:58:48 -0700 (PDT)
X-UUID: be1d1960588a11eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JiNIMV1IL1s5AWsQwb4DcbaZvi4/kWTIBXY7OWCmxrs=;
        b=CUSZANBwfPXqLmJdlOUeYn6/De3jNJEFWo4biljjLpDO3WxFxnP4E65FeXLghgVrelSydjmsfhGpKV3JXa1xg0pHqWPpf9IwiJScUbmK5p3DnGnNl5zU1w6Sv576EdzWy+pW0ydgZC0w/pv4kJjm0M/Rsj0b+zI/wGg5ej2SN1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9924c10f-3b20-4029-9ba5-52ba0f0e0935,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:f4d9f8ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be1d1960588a11eea33bb35ae8d461a2-20230921
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 795248450; Thu, 21 Sep 2023 22:25:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 22:25:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 22:25:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm5n47LNiAHlAJBxYHmqI0Ojd2w5Qn9yOkG8wBUYkoWAH2/dp1i40p1qowRT1Ko1gXfkgFD2ujvkqfdOpduPO3r4MDL0TRteEmbp8Oezz4iY4BIjOf7X+1/glOmjJqS1ApNl2RNL4vP7b1URQzVH9nyKGpPM3S7vLZi836Ydmg+tDi4vMpK+fsz3GggP1meErzYE/phwGDa3jSXlVEiaN3TwlYGdvMEgTeHc0EWgywIfjf1OYhsY82Xd4gXVqqanYYo0QzEx1/soQcPV1f99t33RMsy2RHoNqI7onmp1v8qqBeCdno712OwVw7oSCiKXckU9OXx5n5DhbmVluHxVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiNIMV1IL1s5AWsQwb4DcbaZvi4/kWTIBXY7OWCmxrs=;
 b=aUVDzBQ2I2857RODDUSJmHyyIPuWlgIg88En+eAlsziocwfvnqGwiJ6ce9P/EpuPRGuXLmUvdbYPwrnITF0swmPhwrSjaAXYiEQTrh/Vqt6VRaB/lIHBjZN6SJlsiJvtN5vCOyKb72PoatUv2DJcg4LDd1boJot51OYaNfBO2kgypemxIVOaT1LM62uFJmq0jINX04vJucbJNEEagKZEsHAehbs6bpZy7PVxyu17CI8P4HtVhGwPuEHBp3t8e2fGPw7qQtG10B3XVawpWUYqyerZFJOc5oBrVShPk2LU8AQlvuX+NagqAjR3yV+fekgfKUO6AZQn4DlRGYTTEQjDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiNIMV1IL1s5AWsQwb4DcbaZvi4/kWTIBXY7OWCmxrs=;
 b=Wq/K0tV3HpK5jsBTBXSWwXGn8xml/V0O39QjPx2JELbkgUA9v5tFft+aqe87Cn4r11KvBUiOoeu0/l/GhCK7DvUO0f0aJvSPXITVUe9vaZGs4riOPCoaRvKnkBWNOO5eogAu1jv7OZKL5WCVLydvossJkwV74fnZPiiUzEz1Wu8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB8158.apcprd03.prod.outlook.com (2603:1096:400:471::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29; Thu, 21 Sep
 2023 14:25:37 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:25:37 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 08/15] soc: mediatek: Add cmdq_pkt_finalize_loop to CMDQ
 driver
Thread-Topic: [PATCH 08/15] soc: mediatek: Add cmdq_pkt_finalize_loop to CMDQ
 driver
Thread-Index: AQHZ6mWDa+rwkVDFL06SYTk3XuyKWbAhX0kAgAP65IA=
Date:   Thu, 21 Sep 2023 14:25:37 +0000
Message-ID: <6a80acb293cbc7e1b544f85b22800b5343a931b0.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-9-jason-jh.lin@mediatek.com>
         <54799d50c0b4427102e275117e715d9d4a190375.camel@mediatek.com>
In-Reply-To: <54799d50c0b4427102e275117e715d9d4a190375.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB8158:EE_
x-ms-office365-filtering-correlation-id: 41702999-597f-4ecd-ab84-08dbbaae9fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t006leVW38ClsW8n7grKKm1akAirI5ar+4feRFHNngmk57N676vaFXlMH2YOkbnig4yME4AKYNxi/vOtkGgMaWMhXHcgYVKNFN+HZi6NzCXfCVCLUeRDmWKf5LYGPGW03lFWau3OdD2HXyfg4DnjMqTPSK783uITvYK5qNqBphsaOw7azvJePPBk8Zo4mmUEMiMDpEpDWgVJZvG+0jNtUGjjtiXzVsWLNluoVyyccq6yc1YH28KqhmbMTh2Q1ll9LdayYuCKPgoHYTWhO+fhwtrQlMtGny9aHBIgPEXnCArNWIk0M8kU7xweUrNxLttPzj6Kjz9rvLMPwUx9Mqg7AWYOwAfxI1CWicL32b2oJ3Z4PLGyWLqTJ7SrdCpAuUewWWM6zAnTJma1A6gwX1BGGHE/FkKmxjqM/tXHohSG1du9t2tObt2s+IZagP+yCJdQz4nmb3Xr7tkkO3yiPulhj9ukmINn9gvuRsmLW0elBNChJjMbMTgD4aVyDXtbIYHA1TvPQeTXiK7PI3IqucDoZoO81q6XRBni+x4tOOrCwI0teGShAOoLHn8F1KxkF+fUwffdM+DKqmO5zXwtylpwqG4vyOjSuaTDDcVczgayzblp/qXdSEGRnyew9bHZFm32zgr/vYW2HQqAR6LGCAM2djyn1El9rBKphmRSHIYKNLc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(1800799009)(451199024)(186009)(64756008)(54906003)(316002)(66556008)(91956017)(66946007)(66476007)(110136005)(66446008)(76116006)(26005)(107886003)(38070700005)(83380400001)(6506007)(36756003)(71200400001)(6486002)(6512007)(2616005)(38100700002)(86362001)(122000001)(85182001)(478600001)(2906002)(7416002)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NScUpnOGlnQWlyT21tRXpxUlU3NlAwQi8xRGQyNkhPM0YrNmRhWDBtWE5k?=
 =?utf-8?B?Q1c3YnFkSlFPYS96aGpLSjBPWnNabnduRGlaNmUwV2ZHRjVVcXdFUzZPSFJW?=
 =?utf-8?B?VlNVOVZ6c0lpTGp3cHJPVXlRL3Z5ejJVR3dYYTY0em1udWlwUjBCVkZ0bFNC?=
 =?utf-8?B?OUZXSWprcHRnRmJuckpIRUZCeFNSb3BvdllhQmhCQStOQzJQd05jT2MwQnI2?=
 =?utf-8?B?VmZSQlRjTkwrNStZQVhyekdzdlA4aVFYZCtGVGtqRCt4TWdPR2lPSU1nbWt6?=
 =?utf-8?B?WXRaaVV0VUg0bzVVMm44MUtrMFpUQmF4Zk1mRmdEOU5vRTNweDBvTW5qcDI0?=
 =?utf-8?B?em00NTRldng3SVB5THM1UXVRNDZMYWN0UFVEZUxMd2FXRGx6WWdiTUVWbU0y?=
 =?utf-8?B?VDlVdFRKUmhDYm4vSWdsWFo5MldZdEpES1B2N3AzM2hEZWJaTlZRZ3haU2xx?=
 =?utf-8?B?NWx2V0QyaWV4WW5MUFVQck9mR2pLOVhVZkJPbnMvMlVCU05GOFdWeWYwZjMz?=
 =?utf-8?B?NGxSQ3o4WHdITy9PVUlpOXMxNmdPSmR5OVc1ODBVNURyMFBJWUxObEU0WFJu?=
 =?utf-8?B?cUl4ekZCc2R4UE84KzJJRDBEOXE0M1BZWCt1ZVZFaU5BL1pDVFhXbjI1K0pu?=
 =?utf-8?B?bVh6ZzE3ZEdDNjNlSHhkOVdyWldrdVhYOE5RWklCeHlIdXZyYWJySUpDY0Vm?=
 =?utf-8?B?U2g3RnVCTDl5SjJjbDc4VkhtVWtGd0xCb0hwT0JBMkhpSXdGNW5neDAwUGtV?=
 =?utf-8?B?emprcCtqYnVaQ0NReXFpd2wvUDdkMHB3V1dMUVF3am83ZTJaL1R0L2w4WDV1?=
 =?utf-8?B?cUtFOG50Z1EzaUtmNHJWYzVCck5wQTlhUFdEMXY5K29tRi9TUDJpNnRsZ21r?=
 =?utf-8?B?eWcycno1U1A4RHBLNEVOaUV3dVQyalFFM0JqNEVEZzFQQytjTlpDMzExdXVl?=
 =?utf-8?B?eGpwZ1kyVDRVOHBDM1hVblVjR1VBUnZPSlU3ZWsxclBMWEVXcmlid2QvTTVa?=
 =?utf-8?B?NXkwajUzbmJyMDhwbGpuZ1JYVnNBUHRDTjJ3MDNUdmlsa2Qzd1VWcEoyRTY2?=
 =?utf-8?B?dUp4NlNYNmJJbE9RQkxSNHpFZGNOQkdJTTYrVWlGU3AxWkZCU3lIb0M3bE1D?=
 =?utf-8?B?SURFQlR3NFAySU9HQkJ1T3BkRGUxUy9TRzhzZWVKbTkzd2k1cW1vL0h0Y0hO?=
 =?utf-8?B?MTA4YVc1NmR0bmllK1RseVA3NWwwNkRFZkVwbGhGS08wazhnRlNLVk8wSHNz?=
 =?utf-8?B?L2UzMjR5aVNrS3gvenFyM096S1lLUi9LY2locXVydTd2QVFIS1lzTEVFQm1l?=
 =?utf-8?B?YWRJcVpMTVU4NEZBT3Y5SC9pdENWQTJ6MzJOUTJWVTR1cVVHVU5ncHl5SDE3?=
 =?utf-8?B?QXlrM3FlSjZWZjdnV1Q0ZGlNSWJLT0VPWnBPR1lBMTRncXlvQkdOc3BVTmpJ?=
 =?utf-8?B?U1J3N1hMZzI0WG95dHlKZ2lyU0UvczRNcFBwdzVuSE1Ub2FJcUtpSnB4ZU9x?=
 =?utf-8?B?aHJDUmNLcE1WNTR1MFUyczJ5QUFlSGt4SlBTU2tGSDQwSkZHOWJ3OHpBWkNv?=
 =?utf-8?B?SG9aaDBYK3JBRG9sQjVLK0FrNzd5NS9sa1JpRDM4bmYzdWh5aG53Nmkwa3do?=
 =?utf-8?B?Y0syS3dMVTdWS2hid0dFMzhKV01CNmF4WVI1cmRFQXNYQzZXUHM0eHh6MXd0?=
 =?utf-8?B?MThnN1BVYSt6TnM3RFd0cVVjaGw2cTBUdEtTWk5EVHZqeVhlV3FtM0JJdXhN?=
 =?utf-8?B?a05sUHpzQTVUeEEwMm9DVXpSNmM3YkNJNVZMT0E3Z3k2TmU2K1dxTWtsRzFi?=
 =?utf-8?B?T0xBMEVEN0lTOUh4b3lBeTJtMGhWMFdPR3BPS0tXbFpoeTRrWVRIWFRsVGls?=
 =?utf-8?B?S3RuMFhPY3RzZEpwYmMvNU1JTEF5aVFRbWhZZjZWK0ord3BJeGxXTjdSQTlU?=
 =?utf-8?B?SE9xR1BnQzZMOVNwREhmSVd1TjVEL2luRkZLUkZPWkxlcmE5L01vb1lYUHNH?=
 =?utf-8?B?VnQyaVBjSlV4UnByRjdzVUY0UHNGeTBBdzNnNmpoV0wzM0VzVWNIU25pU25Z?=
 =?utf-8?B?VGsxTHZFS0ZzMFoxSFZTTTd6Y2pBMEV2QWcyeklkeGRLbmdRWEJ5c3Y2c0d4?=
 =?utf-8?B?QU82UVUrYVhKeUtFWjdYK0drNmgrYVFMMkc2a0VXSm5RTDlhWjlmejV2TXZa?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32EA922727127F418AACCDB1120B55EA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41702999-597f-4ecd-ab84-08dbbaae9fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 14:25:37.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Md538O2SkmFy07RN109hmOKEq1/HO0pOUFIONEMn8T7xCJXTYuY0zOeieSPiZS1okXCBzZXNbYZTt2YYBJzAYY5E6G9xNdYTgy7W8+RZ0a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTE5IGF0IDAxOjM4ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gVHVlLCAyMDIzLTA5LTE5IGF0IDAzOjIxICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gQWRkIGNtZHFfcGt0X2ZpbmFsaXplX2xvb3AgdG8g
Q01EUSBkcml2ZXIuDQo+ID4gDQo+ID4gY21kcV9wa3RfZmluYWxpemVfbG9vcCBhcHBlbmRzIGVu
ZCBvZiBjb21tYW5kKEVPQykgaW5zdHJ1Y3Rpb24gYW5kDQo+ID4ganVtcCB0byBzdGFydCBvZiBj
b21tYW5kIGJ1ZmZlciBpbnN0cnVjdGlvbiB0byBtYWtlIHRoZSBjb21tYW5kDQo+ID4gYnVmZmVy
IGxvb3BhYmxlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgfCAyMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgIDggKysrKysrKysNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4IDRiZTJhMThhNGEwMi4u
YmJiMTI3NjIwYmIzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCj4gPiBAQCAtNDc1LDYgKzQ3NSwyOSBAQCBpbnQgY21kcV9wa3RfZmluYWxpemUoc3Ry
dWN0IGNtZHFfcGt0ICpwa3QpDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9m
aW5hbGl6ZSk7DQo+ID4gIA0KPiA+ICtpbnQgY21kcV9wa3RfZmluYWxpemVfbG9vcChzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5z
dCA9IHsgezB9IH07DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCS8qIGluc2VydCBFT0Mg
YW5kIGdlbmVyYXRlIElSUSBmb3IgZWFjaCBjb21tYW5kIGl0ZXJhdGlvbiAqLw0KPiA+ICsJaW5z
dC5vcCA9IENNRFFfQ09ERV9FT0M7DQo+ID4gKwlpbnN0LnZhbHVlID0gQ01EUV9FT0NfSVJRX0VO
Ow0KPiA+ICsJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiAr
CWlmIChlcnIgPCAwKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJLyogSlVNUCB0
byBzdGFydCBvZiBwa3QgKi8NCj4gPiArCWVyciA9IGNtZHFfcGt0X2p1bXAocGt0LCBwa3QtPnBh
X2Jhc2UpOw0KPiA+ICsJaWYgKGVyciA8IDApDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gDQo+IENv
dWxkIHlvdSBleHBsYWluIHRoZSBjYXNlIHRoYXQgYSBsb29wIHRocmVhZCB3b3VsZCB0cmlnZ2Vy
IGFuDQo+IGludGVycnVwdD8gSW4gRFJNIGNyYyBmdW5jdGlvbiwgdGhlIGxvb3AgdGhyZWFkIG5l
ZWQgbm90IHRvIHRyaWdnZXINCj4gaW50ZXJydXB0LCBzbyBJJ20gY3VyaW91cyBhYm91dCB0aGlz
Lg0KPiANClRoZSBsb29waW5nIHRocmVhZCBpbiBEUk0gY3JjIGZ1bnRpb24gaXMgZm9yIHVwZGF0
ZSBDUkMgdmFsdWUgdG8gRFJBTQ0KZHVyaW5nIGV2ZXJ5IHZibGFuayBldmVudCBjb21pbmcuIEl0
IGRvZXNuJ3QgbmVlZCB0byBoYW5kbGUgdGhlDQpzb2Z0d2FyZSBmbG93IGFmdGVyIHRoZSBFT0Mu
DQoNClRoZSBsb29waW5nIHRocmVhZCBpbiBjbWRxX3NlY19pcnFfbm90aWZ5X3N0YXJ0KCkgaXMg
d2FpdGluZyBmb3IgZXZlcnkNCkNNRFFfU1lOQ19UT0tFTl9TRUNfVEhSX0VPRiBiZWluZyBzZXQs
IHRoYXQgbWVhbnMgdGhlIEdDRSBpbiBzZWN1cmUNCndvcmxkIGhhcyBmaW5pc2hlZCBhbGwgY29t
bWFuZHMgaW4gYSBjb21tYW5kIGJ1ZmZlci4gVGhlbiBpdCBuZWVkcyBhDQpHQ0UgaXJxIHRvIHRy
aWdnZXIgc2VjdXJlIG1haWxib3ggcnhfY2FsbGJhY2soKSB0byBoYW5kbGUgdGhlIHRhc2sgb2YN
CnNlY3VyZSBjbWRxX3BrdCBkb25lIGluIHNvZnR3YXJlLg0KDQpSZWdhcmRzLA0KSmFzb24tSkgu
TGluDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gKw0KPiA+ICsJcGt0LT5sb29wID0gdHJ1
ZTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0wo
Y21kcV9wa3RfZmluYWxpemVfbG9vcCk7DQo+ID4gKw0KPiA+ICBpbnQgY21kcV9wa3RfZmx1c2hf
YXN5bmMoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ID4gIHsNCj4gPiAgCWludCBlcnI7DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA4MzdhZDg2
NTZhZGMuLjM4YThlNDdkYTMzOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KPiA+IEBAIC0zMjMsNiArMzIzLDE0IEBAIGludCBjbWRxX3BrdF9qdW1wKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+IGRtYV9hZGRyX3QgYWRkcik7DQo+ID4gICAqLw0KPiA+
ICBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpOw0KPiA+ICANCj4g
PiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X2ZpbmFsaXplX2xvb3AoKSAtIEFwcGVuZCBFT0MgYW5k
IGp1bXAgdG8gc3RhcnQNCj4gPiBjb21tYW5kLg0KPiA+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNr
ZXQNCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJv
ciBjb2RlIGlzIHJldHVybmVkDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3RfZmluYWxpemVf
bG9vcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogY21k
cV9wa3RfZmx1c2hfYXN5bmMoKSAtIHRyaWdnZXIgQ01EUSB0byBhc3luY2hyb25vdXNseSBleGVj
dXRlDQo+ID4gdGhlIENNRFENCj4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tl
dCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YNCj4gPiBkb25lDQo+ID4gcGFja2V0DQo=
