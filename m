Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230957ACF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjIYFLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjIYFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:11:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A358B3;
        Sun, 24 Sep 2023 22:11:06 -0700 (PDT)
X-UUID: ebd1dcd65b6111eea33bb35ae8d461a2-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yXI74R3frkpz/1/EzuWiM8ThDfhjAqGn4yURQQWq6n8=;
        b=O6UIWCrHMamJG++YgrAKYvwKLhBQ4LWiotP67m5TR51uP7bxSxL7lNfd/d/VF54v4Yj0hKFSt1EfDVZDnQCfFlbi6khqGSF4i1LS8qQkLEQgqmW/XMfnrecGRaXoRA7gamObey/xBwCvk/HHTWr6HB8j8AlLCGDM2Avbki5qy4c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:10247811-0641-4d79-b0a3-3d9c0c67fdf2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:74cb6bc3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ebd1dcd65b6111eea33bb35ae8d461a2-20230925
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1240751306; Mon, 25 Sep 2023 13:11:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 13:11:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 13:11:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFbm7VRTQyh54IqSfQ5JmSOrfHFoBrjroitJvhDqcq8sVnzdQ799721OnBJgWsC1zto41UbhDgJvfA4NRAVBXo0JoWDoFeqyh0ZYnN11PXwxisnbWTNcyVeD20ghidr0QXaVykGfhzyfgUFUqpfq47aGqr0TgTqCjBqPvR1DvpRlaXvKxtoTosdToNnlf84+XlP6F9VTe3Yca7bfL8xht6xVEU6Cie8pksYLUl3unl1eLXZlpf5RKnHdGzkZlUsnbQcvZBuvaCoyIoBWZQjwOwq69Ci9cGHAp5Qn7uzjidK9pkWxZRJQnfhWEHp73z9R6zJzP/NPFSab2CPyuES6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXI74R3frkpz/1/EzuWiM8ThDfhjAqGn4yURQQWq6n8=;
 b=AFNQ8rAat2k4AiDHog5Nu6NtK3quJs5FKsqaX9irTRVc+55a6kw2R1eFNMYtNhvig3q/SuAwQL0xE6mMfKowWnC4O4L5m0FzjbgvIXTfvwR8XxYsG0peoMCaOGQ7IC/cZu2NGc38535zKvRM69bg4xi4WBKrTnntvNsXnIz8ABM1iYF4dH5OK+nHLVSUW/AIlhu2wOG6G5fmuFa5F14nEqKYkYw5Qm6ne1FYKYIvbiTyrw3Xe8iVXMW61ids9gGoRmVwUVrcT178dXnI6CC4jVDbMKMAFJpkvD7klxknwFykVbPAX3JECYQb33MRbr9WE9GdS1DrS4760Q3eN3356g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXI74R3frkpz/1/EzuWiM8ThDfhjAqGn4yURQQWq6n8=;
 b=HXOfiUT1SLp/ut4J9nsf9mg345yFXb2BUnMwzZI//9d4ZM/lvXIt022GiwYCjPis4hs4IdWQcfo5z4wpTWMUtusPlCdn4lgi4AiNmQPr7DXCIgzsus0cnmQqq05NnmxrqQ09Sea61XWEUVVIg6Ro4LGL3GHRJonhPpDfj6K0vRE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB8075.apcprd03.prod.outlook.com (2603:1096:990:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 05:10:57 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 05:10:57 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 06/15] mailbox: mediatek: Add cmdq_mbox_stop to disable
 GCE thread
Thread-Topic: [PATCH 06/15] mailbox: mediatek: Add cmdq_mbox_stop to disable
 GCE thread
Thread-Index: AQHZ6mVzAB+DDXoZvUWdOhEu85xiW7Aou4aAgAJNAgA=
Date:   Mon, 25 Sep 2023 05:10:57 +0000
Message-ID: <4b9950182e7409f1625e0d5013a6609f63b6bd0f.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-7-jason-jh.lin@mediatek.com>
         <95f61cb0-f0a9-111c-1541-88d51c3e5748@linaro.org>
In-Reply-To: <95f61cb0-f0a9-111c-1541-88d51c3e5748@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB8075:EE_
x-ms-office365-filtering-correlation-id: 551fb62c-075d-4d74-f2e4-08dbbd85cd23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1T1BNsAl4qswkLEUoA5WwSqPNaB5BXpiLotw0z+YP5u/1Pis0eBIQxLh+bpJkFTH4CWTn5VQzuon85JG/WAiMuL5Yc7cokhFIlPPXImvW4H/kXA3JTblPeHeb8t+qtZBfqaujU9VdmgHZmoBnWGPAq9c5LNqJ17WBPhLE6m4VV4vZim9aBnc93dldloCSuNJXNbhiLt7BfMe7q3E5njqkycNl336IObmGRc2Oti/56b2f/3OTiwiILXJNl1GN5yFatbot+x/mcfz2GJi9wHp2StBHYr/JlXXUKg50Hsln78sFFBrwlVyRiTVMi7IJPaEbmXIjvZ32ghFqL5Ek13rVpD7Uxp8dB5qMDqjj2e2NtosYnT1a8fkGRkC7iZv+GRuGEYZYZXjTjLuxfkxNX+sfVB8KKK78WqOGqu9G5e9ruWbl2Dj0yQEeVhmnQEnXs2P/zHRpgkW6OwNcoHPEJHC/s5LvSoEXwPxb4VRK51GvJXCyz0nmZpwh1gF0RTzYtR6smoTnoUS48lDmGD0aZpJSL7R8Fp/vRW28g5D7x/3WaudQajfCT1C323iKpWswqDbuJgWhKmfpb8fgUNIxVXZAfS9ACfQ1C6gaj5nVCJb6rCnVurSVIlDfDJLW/Pz9nGds/Jry8E1UVnYi6ZlFCI9f1Tgx54nPnZYiIj8F4J8J4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(107886003)(26005)(71200400001)(64756008)(2616005)(86362001)(76116006)(66946007)(66556008)(66476007)(66446008)(110136005)(91956017)(122000001)(478600001)(38070700005)(38100700002)(83380400001)(54906003)(2906002)(7416002)(8936002)(8676002)(4326008)(85182001)(36756003)(15650500001)(316002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDk3TVI2RGkzQmtVNlF0dVhCb2U4MlhURTA5dy85T0N4ZmNTUHlaRWtHVWNN?=
 =?utf-8?B?ZVphVlpDWmFoWDBjQWVEblh4ZmdXbGcvTGU3QUVwZ1EwdGhkaGVIRmlnVnE5?=
 =?utf-8?B?WWhXbUtucWEySHpFQ3NwdjhGcWt3VTk2NDhkVHh0dzYxaWxTeFNRaVRKVy91?=
 =?utf-8?B?dVo1QnVTcmphc1R2MktuL3hNV2VUSzZKWE1ESTMwUk1pdzlmK2x3QVFjUEZY?=
 =?utf-8?B?SkpoZDNuVWNnVE42dDJpVjQ4T3FMc3hYZ2llYWF1SktKVFFoZXhoYXBlazBu?=
 =?utf-8?B?RjNxR3hFcFNKbWZqbnMybklmeFNDbWxud2Vhd3JkNjgwbHlyRG4rcDVuSExv?=
 =?utf-8?B?VVpNbmhDeW9tbDFRUFZBZWt3QzNvTG1tanEvYUtzV2VTSnA3V1pwODh1R1dz?=
 =?utf-8?B?Mjg3ZktYS1hFdVNrNXpFUm1kOWpFOHdDZ1JDdzRYVG01MTYwdGVxTDVhUGZU?=
 =?utf-8?B?V2hVMm5OU1VXOGxmd1ZUZHZ3RVRxSkJTMXgxN3JOOElZd2tOOEN3MmNrZmk2?=
 =?utf-8?B?VkZDR3VtcHhBMmppYWxLNmQ1TjBocmZicVhjZnhJTFRVY0x5WlJrcjh4ZmJJ?=
 =?utf-8?B?TnlaWHA0eFEzT1hpaGVyZzltQnF3UHluWjh4RVVqemQ3ZXY4bWRoVDZKMDQ1?=
 =?utf-8?B?V3NpOG1IVHJ6RlAvTG4rbGhJRlFROVJWbGdOUGh6SUxJU0tsQWFicmt5YzJs?=
 =?utf-8?B?cEg5aytaZVF4L0lnTU42UDNoQXZ6WlIrRnpBR0ZETDlVNUFkbDh4OEV6ckZ1?=
 =?utf-8?B?TWpJRWFpVk1vbjl1YnZzSjQrVE12TldUYmVZNVMxcG9QNVlqQUxaeWxNZjkz?=
 =?utf-8?B?NGFqaVhpZ1BSaWlFQWJBWEIyc3R6MkRoaVo4QUtITDFNUmdIRkkxVTdNM3Fq?=
 =?utf-8?B?QytVbE9sU1Y3RkFnMUJzV2YvUEJPWVhjb0FkclpKNkNoSGRKMXFKWWcyblVs?=
 =?utf-8?B?Q3JjSzNIZGNoWGkvNWFGa2poUmc0Qzc1aGxJaGNTKzJXTENuREcwZktiSy8y?=
 =?utf-8?B?YldTcWNiWS95ZDZuelVyN2lhaFdnNTAwTDBFRDlHTnRneE1vSUZRNWkwL0JS?=
 =?utf-8?B?NzViSDZ5L3U5dldQZHBoeU51N0V4a2VPQmJFUVREWDZ3RWNPZnJJL1k2R3pC?=
 =?utf-8?B?OEpJR2NHMDBGYUZ5WGFmNVRERER4SnUwY3BaQmpDaGt2UUZPeVpFTDc5UExB?=
 =?utf-8?B?d0VzVVFwR0FVN1IwbDJtbGo2QVlyNjg0VU9NN1d0NDRKQ0I0S0J0ZHJGYnZK?=
 =?utf-8?B?N0dISE5zY3BjZGZJV3BxL3oxcHNhaVNjbHArSDdWQ3I0VlBxc2YrZko0empU?=
 =?utf-8?B?YlFRYnNLbklRZXlYN0d3Qm96RG5MaURRMUNwNTRtQXF6bU9IY01QeUlCb0Jr?=
 =?utf-8?B?aVduaGd6Y083Z0UvMnFCVUVDSVNSeUhSM3dKd1dTSStUb0V4RG1yYnUwZkoz?=
 =?utf-8?B?N0R2bVNJbjZrWGVTdEFHYmVpYzAvT2VjemkxZ250SGplRGNCNnRCUm9rZXpt?=
 =?utf-8?B?K3NIZy8yWjFJcFgrN0JEZ0hpdThrUXhMU3pxQ2o5WFE5TFJjNDdPRkY1Z1Zu?=
 =?utf-8?B?aGlybTJsa1JiTHBSSTE4S3gvVVluVUVlQzNZb2lYTkVLWVpBSkNReXV3aHVL?=
 =?utf-8?B?Rk9UQVE5dVNqVlA0SjhBallNOFRRZlhZN1VaU1RNNG9ENUl3ekVZdllRNmNL?=
 =?utf-8?B?MXJJV1p4eGJCL1IzVVFLN0N0RmxoSStkTk1BK1c1VHVISjNHT1RCUXdkYUxJ?=
 =?utf-8?B?QVN6VUxhKzl2dXFPSE94a3U0Y2hmUGlZcUFSMFJ1bGRzZ1NMenpQQ0w1Qkc0?=
 =?utf-8?B?NG9COCt6VzRpT1N2czVQSU1rTXBLclNKanUyTFI1bXUySEM3L0tyYjVaY1ha?=
 =?utf-8?B?WjMyd3RTei9jQXBIU0VaL0VVbWlWbDJlRU9PTTIvKzJyR2UzcTdDNno2cjFV?=
 =?utf-8?B?NW5WTndGbXBzc29BamVuSHFvck9Kb1VMdVNBU1NENDRjZGRGaEVvblNCYVVk?=
 =?utf-8?B?WWJUdnFNQzF2N2QyaUFpT3JYWSs3dXNhVSs3TnRDNko0aXBVbXg0dU5EMENI?=
 =?utf-8?B?RklENGVsQmJhTW1KTHlGYWFqc3Z0MnZCcFlTYzBmKzU3WVRTckFxWGVGS3ZU?=
 =?utf-8?B?VG5mcUNSbC9GSlpqbkdHWjZjNy9ncnA4TDg4bFc2VU9RZWY0SWgwOGwzNXpy?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6E5704DC5EAE4E9E33BA6969E7F56D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fb62c-075d-4d74-f2e4-08dbbd85cd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 05:10:57.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9xIDIVpSs7cEtK4G9vfdvgeE8w/Yl7m+/WjPYi86BxSOpF8j8KDkNKGa8LBzE0QfBACIhkFUc3It0V8nz64a616RitKq+nlKsyqMkDsD58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIFNhdCwgMjAyMy0w
OS0yMyBhdCAyMDowMiArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkgDQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ICBPbiAxOC8wOS8yMDIzIDIxOjIxLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gQWRk
IGNtZHFfbWJveF9zdG9wIHRvIGRpc2FibGUgR0NFIHRocmVhZC4NCj4gPiANCj4gPiBUbyBzdXBw
b3J0IHRoZSBlcnJvciBoYW5kbGluZyBvciB0aGUgc3RvcCBmbG93IG9mIHRoZSBHQ0UgbG9vcHBp
bmcNCj4gPiB0aHJlYWQsIGxvcHBpbmcgdGhyZWFkIHVzZXIgY2FuIGNhbGwgY21kcV9tYm94X3N0
b3AgdG8gZGlzYWJsZSB0aGUNCj4gPiBHQ0UgSFcgdGhyZWFkLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICB8IDYgKysrKysr
DQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAxICsNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBiL2RyaXZlcnMvbWFpbGJv
eC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRleCA0ZDYyYjA3YzE0MTEuLjhiZDM5ZmVjYmYw
MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+
ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IEBAIC00Njks
NiArNDY5LDEyIEBAIHN0YXRpYyB2b2lkIGNtZHFfbWJveF9zaHV0ZG93bihzdHJ1Y3QNCj4gbWJv
eF9jaGFuICpjaGFuKQ0KPiA+ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4t
PmxvY2ssIGZsYWdzKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiArdm9pZCBjbWRxX21ib3hfc3RvcChz
dHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+ICt7DQo+ID4gK2NtZHFfbWJveF9zaHV0ZG93bihj
aGFuKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGNtZHFfbWJveF9zdG9wKTsNCj4gDQo+
IDEuIEVYUE9SVF9TWU1CT0xfR1BMDQo+IDIuIE1pc3Npbmcga2VybmVsIGRvYyAoZnVsbCBkb2Mp
DQo+IA0KPiANCkFmdGVyIHJldmlld2luZyBieSBDSywgSSB0aGluayB0aGlzIHBhdGNoIHNob3Vs
ZCBiZSBkcm9wcGVkLg0KU29ycnkgZm9yIGJvdGhlcmluZyB5b3UgYW5kIHRoYW5rcyBmb3IgdGhl
IHJldmlld3MuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo+IA0KPiANCg==
