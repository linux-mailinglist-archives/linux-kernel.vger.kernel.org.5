Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C04757630
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGRIF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGRIF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:05:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217DB3;
        Tue, 18 Jul 2023 01:05:24 -0700 (PDT)
X-UUID: d5b38234254111ee9cb5633481061a41-20230718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/C4pQPEqEIqXs7kyLrCwcFRBGJ3EWPAfikPpMs662ts=;
        b=E7lvOFh36BSlosnQTIw6E65YGkrAMW8Ob/AkPDqka+yt+Yisa7KFvhVnyVSx0ySx+MP+8/aPI4K1uVJGUENDKrRUFS63QTFuBBI668tXA0cwN5Eca/2zoZT4mN3DC0iKkm33E5oHSCdmk/6Y4CX0tgoP94QvyjvTQOnzH6zT9Vc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:e22ba37a-607f-4fc5-94fd-d6b8d51f686e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:e22ba37a-607f-4fc5-94fd-d6b8d51f686e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:a76ebf87-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:230718035813SD88J7EN,BulkQuantity:11,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_ULS,
        TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: d5b38234254111ee9cb5633481061a41-20230718
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jason-ch.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1519194335; Tue, 18 Jul 2023 16:05:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jul 2023 16:05:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jul 2023 16:05:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLe5xTMbuUITQcgMkt2ElKPCJA6YdAREY7d0Xu/4nMMxO49PtmkE94kiT0X3YpkeibWPqTUu7xL7kJRX1XdTFhutGgXLaG/iP9MpaFuJoyQpf50p0Ff1S4mFVG1G1FAsqfHxlUq9Bis23lnxjzb8MZRd06riiZ0K/EAu6N+Q77atjtR0HbAmo4l4JBEPsykKOfL9WW4nUISPWcS7M5c8Gd5AGym8I2FOeGdaMwBo7HcKmHBoeBhJFOv0BE7k0XbCuGXy1LD6xwGrcok9yvalsG11VeYF2M1S9z2P/AXtV6rZwSps3DnRANiMOUvx10MicnZEQn/ZYRN5ymVZGFTDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C4pQPEqEIqXs7kyLrCwcFRBGJ3EWPAfikPpMs662ts=;
 b=cF3BZYTx5Ef5DsZrSkpKPN7OHgk4RAv5NnpBRVJXCRbEHlPvSOX2K8BlOh3/7uy9MzCJcaJKE0TpM+//q1nzasB/fdWEDzRNf0t2c/53tyopYRksvgIEye37BH1J0t0u9ztRkE4U803eBwWBBHWiOm7R9wevnv5U71FGvpbm0h0j1ITCu/OqqwcIKsX56O4ffasSzIU0JdZ87wQ6OBPom7t+1ck6h2bU+1zjWpKcnrERvNUsAF2IZhEZbkXGM7mhOXJUYwnZ0958Vnodxx3Y/A75lFYq5p8SGO1CzeWBNQmvYfvhoVXtdeJ6F6mXRc04TeutJ4ZjybT2xVhFI15ehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C4pQPEqEIqXs7kyLrCwcFRBGJ3EWPAfikPpMs662ts=;
 b=AqfM30+ZxZ6g32WoCw5dkzxdAi+JJvdQuZGCRnAkTGA/xPYkQrvZ40Ir2NsHJE8+k4nUQd9Oz7Z8rhqV/BDfLliX+kykpetz3gHUuwWU66mNC55QIIoBF0FFwbRHAsN1thB+1fxA2s7DEWldVd6HEj1Ts5U23WRg/krKvgpfqG4=
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com (2603:1096:820:73::5)
 by TYZPR03MB6528.apcprd03.prod.outlook.com (2603:1096:400:1f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 08:05:12 +0000
Received: from KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b]) by KL1PR03MB5650.apcprd03.prod.outlook.com
 ([fe80::27f3:ca11:2b8a:475b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:05:11 +0000
From:   =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and evaluation
 board and Makefile
Thread-Topic: [PATCH v3 4/4] arm64: dts: Add MediaTek MT8188 dts and
 evaluation board and Makefile
Thread-Index: AQHZuKbL6i9A+qQZX0CZYfm+vuSMCq++YLMAgACyUYCAABJDgIAABpGA
Date:   Tue, 18 Jul 2023 08:05:11 +0000
Message-ID: <267d43a13a08b6f6f4914b0cc0dd49eae60a99cc.camel@mediatek.com>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
         <20230717120300.21388-5-jason-ch.chen@mediatek.com>
         <43ecf0b0-4b55-ab11-3b80-b9243b971c2c@linaro.org>
         <f0055b0f42388ff0da395bd9de7b86ce40bf77c1.camel@mediatek.com>
         <42e4d678-d114-332d-f1c5-61575cbc0e3b@linaro.org>
In-Reply-To: <42e4d678-d114-332d-f1c5-61575cbc0e3b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5650:EE_|TYZPR03MB6528:EE_
x-ms-office365-filtering-correlation-id: 932cca01-a969-4433-bbdf-08db8765b612
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZibnkKfuvKWFdOpZ195rvuTXXZlIQlDMQn4NJ8T2iEQFv0f8WalLiRf5SL8wuVK+T22Bm068jrh9rdF+7YQ4nFv/dHQMThmElbBSWbif5qv+OtM4hQuCTuSyQhs8MFY0U2KHxvv786UY1IfJFQIuHegt+huvuKrQ9Lsy6uNp5AjPaRGrSHWv7oeZj64Vu6nQsK1vTX0vF9ZX2doV65H2lZcMlk9w1lKTnxKPnxks2dYbAl16Iy6IDjZzYwLlxuq9PWX0Sn2sZd/LVkZCyvH/lYI30ZDc5WNjb4M4MT9fqmy1sOodQ9atUy4OgUq0ILadAhDDHM9YvHpwHCmtSweiuADyNv2GuZwBKCvRBMoUdF/J54nxV4r2YcWhZTa4/IUTTJ2/WKSENmSTFuTFlYPWj7MFBZoSD+R3qaNAAv4gK/OMd7m7hAMkVf3OeQ1S34MDgj2vEJg3C26bdSuDYQIzvB8WIl2Gw2WMGQ2Fa0gqzAm9MzHHoeRQ2fqPNIz8iPYcL1L7/aN/WcyNKm9M8cc/aBhKvGhBXDg84eOOlaPjGkLqIypmdvh4o2PBM9No7njUJz/Des+z6kDgc4t6V5HruWYUp4+MAg1/zH3FygqApjD+IC/6yg+bvv9yHOM5+yLT2DHnVKO3T8LmhyerDtVjaM17Gm5iIdPlc00H6YBuFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5650.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(6486002)(54906003)(91956017)(71200400001)(478600001)(110136005)(83380400001)(2616005)(85182001)(86362001)(38070700005)(76116006)(2906002)(186003)(6506007)(53546011)(6512007)(966005)(26005)(38100700002)(122000001)(66476007)(64756008)(41300700001)(66946007)(66446008)(66556008)(4326008)(316002)(7416002)(36756003)(8676002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJoZzc1Vzg1VzNtZlZQQzNOSGpQYldZN3RDQ2NDZTFBbEhBM05IaVo0cTBp?=
 =?utf-8?B?K09LZlk1TWE3VHh1ajdTbVQvT3ZZRUFxK3pnamJPTTBEd0xjbVVNbENGV2dL?=
 =?utf-8?B?cUlwdUZhOTdpclA4ZDRpbllhQUdtbjRweElRVzFTVE81SHRkdzZGYW5pS0sy?=
 =?utf-8?B?djROSmg1YldURHJTWVZYaEw4NWdhaHV0N203VjJGVTV5cDZsUUhMTGFMVnZ2?=
 =?utf-8?B?ekhIbG1DeE5GS3V1NGJaM0JwbEtDMHR6L3dnS1NxY2RDd25kdmVYSUFpY1hy?=
 =?utf-8?B?M0YwZGY3YjVBRTNyRHZKSGJtYzRwQUdxL0VoaTcybnp5YlNPMER5TE4zM1No?=
 =?utf-8?B?UGlSY0lTTUhZMWxlVXdXNjFPUjhPNWRVKzFLM1VhVzRPWkRXWXZWaktUT0Jp?=
 =?utf-8?B?aFNmb3N0VFVncUxHQjI0eTBhOW1BcmZMZVpIYkZ6T3FRSGozdE9XelFOeTlp?=
 =?utf-8?B?di9QUFZSQ0Z1Q2VnQVdiVzFVNUhxTHozQmJPYXJpaE1ZMUhKYU85NE05RFRm?=
 =?utf-8?B?VXkxdit4d244VHJHR2lKMjgxQzVramFYaDl1cndVeENzTUxlcGpTSExDZjJK?=
 =?utf-8?B?RTMrZCtwaUJGdTJXSzdrSDQyWUU1VWFwcGFQaTlmMjJaV3lSbG42WDFERnRH?=
 =?utf-8?B?cUcrbWdyczJLdUgwVXFnL3BwU3dleWkxV0VXWVNYOU5Sa2Fqc1NZNjFDVTR0?=
 =?utf-8?B?R0J3NEloaTE1L0pTQlY4Um85bjFWYm93S3hLOEp2dk0xRkZnNS9aTk12ZTdt?=
 =?utf-8?B?UjR5bVEram03ZjNicFd1dDNWOEtxRE5RZ2lhd2hRcG9QTGdiZjkxeHRpYlF4?=
 =?utf-8?B?Y3ByamxEQ25Mbm43M1NPWExXajQ4UjVVYnlaRUx3RlZpaDVaQW16b2tsUG5N?=
 =?utf-8?B?M3hGUXE3d3Foalp0UFdZMUlURituNkNjSW5PYnR3bU8rZG9FS2xuQWw2WjF2?=
 =?utf-8?B?Y1F5cEpGSXhwbXlIL0NCS1IyV3M3b1lkVW5FTjF5ekdPU0ppVmpJemZta3dt?=
 =?utf-8?B?S1BGVXhMTjQvQlVlU2pxL3lITGtkY2ZoaXVCN1VlTVE0QnhKSWRQMFBpQlpw?=
 =?utf-8?B?bFY1SzIwOUNDZTlabWV3cEdSalU0UzdMYWNrWXRyWnZEaE9qOGdKRW96RmRt?=
 =?utf-8?B?dlRpZlJRbXJqMnRwL1U2QzU5U3RUR0R1NFMrLzA1YVNBTFAvbnBTYnpGZW5y?=
 =?utf-8?B?cE5JbExneFhwWGxwVVphR3RCa3hQZ2lDc2VxRDNDblFydVZucDA2c1NMQ1pn?=
 =?utf-8?B?dVNaS2VZY1VWQWdWRjV3VG1SU2JzZmE5dmxXdE5VMUlRVGs5VjdKL3E3WE5J?=
 =?utf-8?B?bDljaW1id2NQcTduZm1RYisrRnFITjRnc1crWFNWejNtRjNSQlc3NGdzWjRq?=
 =?utf-8?B?bGtVbVR3WFZVYVBrcVR2SXc5YWdoVm16VGtLbnJWckg1WVZ4M3JQT2l3MTRI?=
 =?utf-8?B?ZFBBQlhveVAvNHZNUkRxdGViWGU4bGthUHB6RDB1aGhlazVGY3l3ajJPVnJF?=
 =?utf-8?B?LzFtUnVkRWdKN1FXMzBDN0VENm5hV2RxQzhkcUczUjlxckdPVkdOWEZOVTdx?=
 =?utf-8?B?SlZ0cHVKdVZFbm9LUks0Q3JHV1gzWHI0bXVVbG50YzkyVml0dXhNZE1kSHJW?=
 =?utf-8?B?UFl1dXNoUG1WYUdmTWpMM3gzY3Z0VW1OeVpvWUhyYVJwbVpOQ3RESkVvY3p2?=
 =?utf-8?B?bWk5dm1UVWp2MldNZmZMUndGU2VGUlBjcmo4MjYyelVQQkxSNVJML1dEeEFY?=
 =?utf-8?B?U2pPa28vaDJyaGVkY251eDFFa0FEMGs4WkdlbzFrelMxaWdMWWhucWV4SjJs?=
 =?utf-8?B?U1Q3Mnl1WkxJTGNTU1BDZUxZckZCQllyUUJvY2FNR2YrVFZXSW53eHBFUkNR?=
 =?utf-8?B?N1o5RGwzSTNOUE5BajJveENyVUJOOGFFSDJOV0ZGQlh3QzVzVVp4QjFEWE0r?=
 =?utf-8?B?ZVhmbThPektsMk5BUC9HL2R3VEpjdzJ2TU83Y0l1R3h0VlB6NC9NQ2xCazZO?=
 =?utf-8?B?SmdmVzJRSnRwQU5ERDVGSFFrMzJJVlZ0OUJVMUNnYlZVUUhEdTZZaHZxTzli?=
 =?utf-8?B?QWlyV0N6WjJ2UWRvenRVSUZDOWFQQnptdld3eVQ4SVNPdDQ0RGR0UDJvVUI0?=
 =?utf-8?B?YXQ0TkFJWlVLZUt0eWtDODdxZGdhSjI5ckR6bE5salVkbUlEMlExQmQrMDNM?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <973080710415534CA4D867A0B38B5341@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932cca01-a969-4433-bbdf-08db8765b612
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 08:05:11.8701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EL/azCmZA/O2F3ZemuG3McJpJvYCEfSD0SDpfG6PC3efOgRkDZVr7gKryB1uDMWXBxdEX6gxlBD8pqYT1YzIZlrY5oFlgji8otlVAmLPfys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBUdWUsIDIwMjMtMDctMTggYXQgMDk6NDEgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTgvMDcvMjAyMyAwODoz
NiwgSmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKSB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+
ID4gDQo+ID4gT24gTW9uLCAyMDIzLTA3LTE3IGF0IDIxOjU4ICswMjAwLCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+PiB5b3UgaGF2
ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAgT24gMTcvMDcvMjAy
MyAxNDowMywgSmFzb24tY2ggQ2hlbiB3cm90ZToNCj4gPj4+IEZyb206IGphc29uLWNoIGNoZW4g
PEphc29uLWNoLkNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+Pj4NCj4gPj4+IE1UODE4OCBpcyBhIFNv
QyBiYXNlZCBvbiA2NGJpdCBBUk12OCBhcmNoaXRlY3R1cmUuIEl0IGNvbnRhaW5zIDYNCj4gPj4g
Q0E1NQ0KPiA+Pj4gYW5kIDIgQ0E3OCBjb3Jlcy4gTVQ4MTg4IHNoYXJlIG1hbnkgSFcgSVAgd2l0
aCBNVDY1eHggc2VyaWVzLg0KPiA+Pj4NCj4gPj4+IFdlIGFkZCBiYXNpYyBjaGlwIHN1cHBvcnQg
Zm9yIE1lZGlhVGVrIE1UODE4OCBvbiBldmFsdWF0aW9uDQo+IGJvYXJkLg0KPiA+Pj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IGphc29uLWNoIGNoZW4gPEphc29uLWNoLkNoZW5AbWVkaWF0ZWsuY29t
Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPj4g
YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8ICAgMSArDQo+
ID4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODgtZXZiLmR0cyB8IDQwMSAr
KysrKysrKysNCj4gPj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNp
ICAgIHwgOTUxDQo+ID4+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMzUzIGluc2VydGlvbnMoKykNCj4gPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODgtZXZiLmR0cw0KPiA+Pj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNpDQo+ID4+Pg0K
PiA+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUN
Cj4gPj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL01ha2VmaWxlDQo+ID4+PiBpbmRl
eCBjOTljMzM3MmE0YjUuLjliZDIzMjQyNTlhMyAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUNCj4gPj4+IEBAIC00NCw2ICs0NCw3IEBAIGR0Yi0kKENP
TkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxODMta3VrdWktDQo+ID4+IGtyYW5lLXNrdTAuZHRi
DQo+ID4+PiAgZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUspICs9IG10ODE4My1rdWt1aS1rcmFu
ZS1za3UxNzYuZHRiDQo+ID4+PiAgZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUspICs9IG10ODE4
My1wdW1wa2luLmR0Yg0KPiA+Pj4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgx
ODYtZXZiLmR0Yg0KPiA+Pj4gK2R0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxODgt
ZXZiLmR0Yg0KPiA+Pj4gIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBtdDgxOTItYXN1
cmFkYS1oYXlhdG8tcjEuZHRiDQo+ID4+PiAgZHRiLSQoQ09ORklHX0FSQ0hfTUVESUFURUspICs9
IG10ODE5Mi1hc3VyYWRhLXNwaGVyaW9uLXIwLmR0Yg0KPiA+Pj4gIGR0Yi0kKENPTkZJR19BUkNI
X01FRElBVEVLKSArPSBtdDgxOTItZXZiLmR0Yg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg4LWV2Yi5kdHMNCj4gPj4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE4OC1ldmIuZHRzDQo+ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kODkwNjE3MjM5MGUNCj4gPj4+IC0tLSAvZGV2
L251bGwNCj4gPj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg4LWV2
Yi5kdHMNCj4gPj4+IEBAIC0wLDAgKzEsNDAxIEBADQo+ID4+PiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkNCj4gPj4+ICsvKg0KPiA+Pj4gKyAqIENvcHlyaWdo
dCAoQykgMjAyMyBNZWRpYVRlayBJbmMuDQo+ID4+PiArICovDQo+ID4+PiArL2R0cy12MS87DQo+
ID4+PiArI2luY2x1ZGUgIm10ODE4OC5kdHNpIg0KPiA+Pj4gKyNpbmNsdWRlICJtdDYzNTkuZHRz
aSINCj4gPj4+ICsNCj4gPj4+ICsvIHsNCj4gPj4+ICttb2RlbCA9ICJNZWRpYVRlayBNVDgxODgg
ZXZhbHVhdGlvbiBib2FyZCI7DQo+ID4+PiArY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgt
ZXZiIiwgIm1lZGlhdGVrLG10ODE4OCI7DQo+ID4+PiArDQo+ID4+PiArYWxpYXNlcyB7DQo+ID4+
PiArc2VyaWFsMCA9ICZ1YXJ0MDsNCj4gPj4+ICtpMmMwID0gJmkyYzA7DQo+ID4+PiAraTJjMSA9
ICZpMmMxOw0KPiA+Pj4gK2kyYzIgPSAmaTJjMjsNCj4gPj4+ICtpMmMzID0gJmkyYzM7DQo+ID4+
PiAraTJjNCA9ICZpMmM0Ow0KPiA+Pj4gK2kyYzUgPSAmaTJjNTsNCj4gPj4+ICtpMmM2ID0gJmky
YzY7DQo+ID4+PiArbW1jMCA9ICZtbWMwOw0KPiA+Pj4gK307DQo+ID4+PiArDQo+ID4+PiArY2hv
c2VuOiBjaG9zZW4gew0KPiA+Pj4gK3N0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgiOw0K
PiA+Pj4gK2thc2xyLXNlZWQgPSA8MCAwPjsNCj4gPj4NCj4gPj4gSXQgZG9lcyBub3QgbG9vayBs
aWtlIHlvdSB0ZXN0ZWQgdGhlIERUUyBhZ2FpbnN0IGJpbmRpbmdzLiBQbGVhc2UNCj4gcnVuDQo+
ID4+IGBtYWtlIGR0YnNfY2hlY2tgIChzZWUNCj4gPj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dyaXRpbmctc2NoZW1hLnJzdCBvcg0KPiA+Pg0KPiA+IA0KPiBodHRwczovL3d3
dy5saW5hcm8ub3JnL2Jsb2cvdGlwcy1hbmQtdHJpY2tzLWZvci12YWxpZGF0aW5nLWRldmljZXRy
ZWUtc291cmNlcy13aXRoLXRoZS1kZXZpY2V0cmVlLXNjaGVtYS8NCj4gPj4gZm9yIGluc3RydWN0
aW9ucykuDQo+ID4+DQo+ID4gDQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCj4gPiBJ
IGFjdHVhbGx5IHJhbiBkdGJzX2NoZWNrLCBidXQgaXQgZGlkbid0IGRpc3BsYXkgYW55IHByb2Js
ZW1zIGhlcmUuDQo+IEkNCj4gPiB3aWxsIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0K
PiANCj4gQWgsIHJpZ2h0LCBpdCBpcyBjb21pbmcgZnJvbSBkdHNjaGVtYSwgc28gdGhlIHByb3Bl
cnR5IGNvdWxkIHN0YXkuIEkNCj4gZG9uJ3QgdW5kZXJzdGFuZCB0aG91Z2ggd2h5IGFkZGluZyAw
IGFzIHNlZWQuIFNob3VsZG4ndCB5b3VyIGZpcm13YXJlDQo+IHNldCBpdD8NCj4gDQoNClRoaXMg
d2FzIG15IG5lZ2xpZ2VuY2UuIEluZGVlZCwgaXQgaXMgbm90IG5lY2Vzc2FyeSB0byBpbmNsdWRl
IGl0IGluDQp0aGUgRFRTLiBJIHdpbGwgcmVtb3ZlIGl0IG5leHQgdGltZS4gVGhhbmsgeW91Lg0K
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQpSZWdhcmRzLA0KSmFzb24NCg==
