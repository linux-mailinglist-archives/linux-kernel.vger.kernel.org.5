Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220ED7DC54D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjJaEVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjJaEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:21:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F4AEE;
        Mon, 30 Oct 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698726086; x=1730262086;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VsMMgdQmi8BGskbAFrdU0dJ+mCYTxfafp26rPNEmPZY=;
  b=1B4KPQdk/sfitvIsYhxy1V8GjUYSVE8XzcowBtoFd5MDVaWtBCSp/Q1Y
   pUB+D/baHOFaem3NZKhCu8Q4jOaTzful0s9iBv6xZjDx4EHXKQdcyKZ3q
   T2Y7KQ/CJurDDDdjIEnJmvgsCX3seXJYM4tC+fMu3czW01ogLfaSIGMpn
   nm931r1XUJaVKmKaLhRqe1bJeGaijQhUeou2SUVCJ8N89czrNERZKuUWY
   siPcHRnFTsWVSHYaSKcslQutzv5QJIaSgavuJRRibHyIfYSYMsbOUFOI+
   uRoFofEjHvnHk13g+rtkXS0iBawX8TCx2dlouK6sF1Ju6PwZKyua1bBDQ
   w==;
X-CSE-ConnectionGUID: sQv6ZuyERuaEkguCyL47Kg==
X-CSE-MsgGUID: innvNPquT2CbqoHXbkgNyw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="178045658"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 21:21:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 21:20:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 21:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOm0A9PrV69v5JA97Z7uRAI1vUui+ZJIDeO+eMpwdD0EHWYbczm8H3BitqzRrFN+WGoTDROEW5uWMtgqqXu/SH1grQPtq+ZyeDrJdJBSUruBKHlwN5TUKDrDz6JtdEZWbPmpfa9p8W90nNJIm4EEJSbT66XZU5erT5xjOxkpdTykC5jSkGaQZ7aussuSsAviGlcSBWKC1Wlcg7lbnB6H+f60speRjEYMYn5e3LyBxzFnvvmiyJlcWc96XW9o5DjH56tWD/9wGCS7Khq7XeRm+D/y21epXAZ6GjMBLCGZaoLwT044i2yBoXkKUZtWul9jSN/nRrpnqHXXZvkQiQBvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsMMgdQmi8BGskbAFrdU0dJ+mCYTxfafp26rPNEmPZY=;
 b=KKMgBlxGGOGVbaNoDE8vyL4ekmGFtdcu+DmLpRuaW6xaaOfmeNHkmR/WKM7Dp7GS/j5xRuYluHcpN47fjd5ZWFCQxT9zTVTcGj9WbbGf+mcuJipXOIzJ5czD/M3Ohvqps+UiFhwFVvyxpSaLbWSwqrPZH1sh2OW0lgQauK4hw55e92++Eg8IiM5Eg8JhkbAZLyFUPqfHFCL6+W+82S6Q/vSFZ5eqlwiF3DH9q77aZ04yHBwLOrO1ZXGAzzdnGnRFrDuTqmOEsM0fQSw1r7pcqFl4rf+yrcfi2tY7qytKlF4hl+lXaVsfL+FKbfG3wlXwOe7vVFDLRrpZKEmr600gVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsMMgdQmi8BGskbAFrdU0dJ+mCYTxfafp26rPNEmPZY=;
 b=oH6WIXjHwmdisUpf/EEPjJxOcsFJbUYsOcyJLcmEU4aEIpCXKjNmnIYlSy78olFjUmiugOimFBbu6TJX3BnkJntuHauIIzG6hpB5v3KKLxBOwPTSc9dDZGBr+Tm09o06O3Mhi5IAqqOM39f9QDhuSjkWTmaYVn21sO9VuDKnc3k=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH0PR11MB5609.namprd11.prod.outlook.com (2603:10b6:510:e0::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Tue, 31 Oct 2023 04:20:49 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 04:20:49 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement internal
 PHY initialization
Thread-Topic: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHaBchfd4VvkbAYLUa8k+Fx88FoOrBYHlWAgAs5XgA=
Date:   Tue, 31 Oct 2023 04:20:48 +0000
Message-ID: <7873124e-d7b2-4983-9be3-f85865d46de2@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-6-Parthiban.Veerasooran@microchip.com>
 <5c240b3b-60c2-45bb-8861-e3a8de28d00f@lunn.ch>
In-Reply-To: <5c240b3b-60c2-45bb-8861-e3a8de28d00f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH0PR11MB5609:EE_
x-ms-office365-filtering-correlation-id: c30fa573-2857-4656-745a-08dbd9c8c2e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n26Sect0t1zvAelxcZ61NV+gVtWb/BklVO1uG5YiF2wkuMhvLzHNOlEv7IRFh6q/FxTIrdwIdOauyM2C8VI/syPlA2TCjE3Q93LnD835QqtGuHj5WR5bdu2KgTZ5xJtuMQlYuCEXZShlqlfHC3ZMlF/16qdPAoW+XBRBszT7JFVMVrvmPodD5w72X2d72SPhqYjv9Wu7No9DdNoWpRGADXXFnJRxfLcXvtB032xZV/ebUMcr8CycSQ14HVPlBkoOUsl5AIbIPe1Stgyt9LuTKyo/YSd8kq5+dqbxZFx+UE0Ko6xTGGSmApKhmaS5kym36vWZMdtfIQBlHo1ZNp4DBAp2psKipgBWDPHNAOiD3tqT8gaQKtBnNclxIr9nhH8vA966YuHFamFP7EvqUHwKHbZtm4XLKbLQYokCyw5tVRZbsrbFXLnZ5xyPkZiFrJ6lM1VhaVHH7tIh95D55cpYKPWoh5mAnoA3vBMFk9AEstSxJORzB56wlJW0ZvTooAycvaYn2XOjF89tNGf8YSNHUkM+yu0nh2lLjU+HDFQNuGTrGG/5Q9zS1+l/G0l3XWipfvluWJ88E83W9iyUtUgadWiCBOgJAS1hAzgErDIE9kujE8cbgRL/THyuy0AbefdSJfoTpWFUrIN3txL1wZeRhpCYVo/poZCIg9BxcWJkvQrNPDOSQmDrau3HWEUmGCmivMObVbbMlHt63ib8IpG9V6o7O5RYIjWr2yl6yCoqO5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(122000001)(36756003)(86362001)(31696002)(38070700009)(31686004)(107886003)(6486002)(6512007)(41300700001)(478600001)(8936002)(4326008)(8676002)(53546011)(71200400001)(6506007)(83380400001)(2906002)(2616005)(26005)(76116006)(91956017)(5660300002)(66556008)(7416002)(64756008)(316002)(66946007)(6916009)(66476007)(66446008)(54906003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dS9xQ21wWTA4MkpVci9WVGUwRTRBVHFxZG9QUjgrR0VPVEZJejdha1VkckJk?=
 =?utf-8?B?QUk2SDNES25JWW5QTngvbTBXM25UMnhyVklZOTlTaG9JbXBsejlUUzNSRzk3?=
 =?utf-8?B?VGx4bHlscGFxQlB1OHlValVNS2lReGJkWWMrYkFMZ1Y2Ry9nSzBJZlJBZ0RB?=
 =?utf-8?B?RUJlN1Y0WnhDbWRCcjVHbVFZVGVFU0QzOGNxZTNnT0E4dWRtMEFuMFM4SUZ0?=
 =?utf-8?B?SHpScmRsUEJOVVZVMVUvNGFBMlROR1IrdmtxbEpTMWlqdG5tZEN1elpucy9V?=
 =?utf-8?B?aHNrOG1sQmFKTDJzbWJvc3I2NGtNRktsWUQ0RzNRcjVxUHpLcDROMkp4dWE0?=
 =?utf-8?B?M3lHYjlFRWtZL1gxODQ4NGptSjNXTnpGRnN5ME1BN284RjIxK0YveWw1VmRo?=
 =?utf-8?B?ei9sSys3QUpYOUx5dnUwWHhkS2p1Y0tkbjdvWkhUdGptZ0YzcVhDbThQeTcr?=
 =?utf-8?B?ZGw3dTZnTjZEMGhOS1ZJVWxYN3lOVFpjNytydXpZWmNHSkhldVQ5a3I2azhw?=
 =?utf-8?B?bG5WbTVoemZsNzdYYzNQY3JSRWNkOXJQUVExK0tjakJ4SFFqQitlOHo4SnF3?=
 =?utf-8?B?Q2NTRFNwVnN2Q1k3VDlPSTV1RmExWDdCeGpEN2JtOUxmOUZ6Uk91WHQ5Ymxx?=
 =?utf-8?B?UTdlcExQWEZvbU1UdUE0ODhrK1JVOVZMRWtBeElMZVNOYUNCeW5UclY0akFk?=
 =?utf-8?B?aDNydXBIVDZEUzZLKzBOdlkrZ3R2Z3c1TmhjdTlqOUdoenJYZ2dxRDY4Qmxq?=
 =?utf-8?B?KzhUYTlKWkZZb09RMGFRN2U1ck1vM0FwWHBDWi9qUElJOVhDUE04ZDB5bWI2?=
 =?utf-8?B?T0puZ1Iwa0dGd2xtYkNldjdjblRndjA4cG9STUZEeDJIa0xxVUFsSFFWc29K?=
 =?utf-8?B?WXVUU1kvUE9XQ2lwRGpyNVBoZDZZc3I1MUt1NStBaEtDUzdPbUpiTGlwZVUv?=
 =?utf-8?B?c09iZW1hTFJsZEVhQ3lXV0V2OEM0b1E3TEhvTG8vWFhOMFJxNXA2SDJVWkxU?=
 =?utf-8?B?Q3dUVjN3cjJqTXVwSlRPZk0wQ2xKdG5UUkZQWTV2SU8vZW5Ea1cwcmlqMjRl?=
 =?utf-8?B?MUZac0JvTXNQQ1NNcndoRHVQbGYvSGpPMTJkcGdaZjZjUC9VaVBZMUZ3bDFr?=
 =?utf-8?B?OHZoc2tLdkR4SUhQZnlPV3NRK2cyU1FseTJLeDNJbHh6V1N0cDFnMnJjak1l?=
 =?utf-8?B?dDZTOVhUNFJEbW5JZkNITWZ0dWxkYkZWZ2IyWUxrS205aTFFZEI5cjRVaHRS?=
 =?utf-8?B?Z2cxdTlpWGhhWFFVaENjcDRKOFY1blpJeDlSWFZtUitsZFNtbUtsQTVLM1hr?=
 =?utf-8?B?c0UycG9FNjg3NE1kUzU2bFd4UjQ3UXM3WjBoRjJwb2taZnpoYkRyd1U5TElX?=
 =?utf-8?B?THdhZ2dHMWNZREl0ckJlWmFMY2psb0tiVitrelBSWjZQS0N2cVdFTEt2MWpU?=
 =?utf-8?B?dEc3V2J0UjBRcUpVTEFFWGEvVStteWo0VDArWjZtZlRqSno0UERhd0xlNzhM?=
 =?utf-8?B?c0pNalMwZTNGZ0VrM0NNR3pacE1XZmhRckNiN2xjanRpam1HSzBVUzVCOTRX?=
 =?utf-8?B?VjJWUmJOdUQ1WVBMa2hjVm1lZXlWZGR0M25WRlk3eGY5eCtIRDQ3cG5IeHRm?=
 =?utf-8?B?Y2ZiMWJ4SWpaaHJ6NnVPbDJqRlJZcE1PdGczNkp5dlRPYXlmVDlUZXdOb201?=
 =?utf-8?B?eC8zeENTL2FPS3hHVzBYem9tSHFDeXZrNHdNdXFETFlIZjdSaDdaeUJMMldk?=
 =?utf-8?B?K0IwZGdCU2pXQ2ZXUU11THVzb21kZGpMSDc2TEVxVDFPYWttNHp1WEZ1Y2lZ?=
 =?utf-8?B?RFhLa1prSFBuZTVmSFZuMEkrNlZCc0NqSXJsendONUNybEZ4M2JPTzZ0Z0pv?=
 =?utf-8?B?Sk5ZUk4vdlNybCtUZktMeDhNZ3R5VEZkemp2WnByaHFNcXBUdkl5WjJlVnBo?=
 =?utf-8?B?OUdPS1FDcXpDa3lsMWM4dTRNNmtsRkZkYlpQVUdTZEpLNUdrbmladEZmV2hz?=
 =?utf-8?B?UlZ1SHR1NHNFNS9kaTF6NHhvcksvN2lzSzlUMGNGNHk1ZUM4aVhPZW9CQ01s?=
 =?utf-8?B?ZGZJa0RtczNPUGsxUGJ5ZXc2R2NteDB1S2U2MkhmWlBoMEp3WXBOMGEwTFgx?=
 =?utf-8?B?OXVxWkMyVEVJR3h5YklSRllTUjBPWFRUSEVSdkxzYkxEaWJNSVhUTXNOUXd5?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D571F3321712FC42BAD20888939AEE1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30fa573-2857-4656-745a-08dbd9c8c2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 04:20:48.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +C71pU6b1zEKV8jScpGtt9aWV6JMIZc47tirx15HpY4tohCsrC65x9zf9G/SOZcp1hmoo/S/up+5i8a+Ua+mpBMMTie/DLll1iKTA4xNun7RL7/9WD1g4dzBXNoeG2IR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA2OjI2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgICAgLyogTWluaW11
bSBzdXBwb3J0ZWQgQ2h1bmsgUGF5bG9hZCBTaXplICovDQo+PiAgICAgICAgbWluY3BzID0gRklF
TERfR0VUKE1JTkNQUywgcmVndmFsKTsNCj4+ICsgICAgIC8qIEN1dC1UaHJvdWdoIENhcGFiaWxp
dHkgKi8NCj4+ICAgICAgICBjdGMgPSAocmVndmFsICYgQ1RDKSA/IHRydWUgOiBmYWxzZTsNCj4g
DQo+IFRoZXNlIGNvbW1lbnQgc2hvdWxkIGJlIGluIHRoZSBwYXRjaCB3aGljaCBhZGRlZCB0aGVz
ZSwgbm90IGhlcmUuDQpBaCB5ZXMuIFdpbGwgY29ycmVjdCBpdC4NCj4gDQo+PiArICAgICAvKiBE
aXJlY3QgUEhZIFJlZ2lzdGVyIEFjY2VzcyBDYXBhYmlsaXR5ICovDQo+PiArICAgICBkcHJhYyA9
IChyZWd2YWwgJiBEUFJBQykgPyB0cnVlIDogZmFsc2U7DQo+PiArICAgICAvKiBJbmRpcmVjdCBQ
SFkgUmVnaXN0ZXIgYWNjZXNzIENhcGFiaWxpdHkgKi8NCj4+ICsgICAgIGlwcmFjID0gKHJlZ3Zh
bCAmIElQUkFDKSA/IHRydWUgOiBmYWxzZTsNCj4+DQo+PiAgICAgICAgcmVndmFsID0gMDsNCj4+
ICAgICAgICBvYV9ub2RlID0gb2ZfZ2V0X2NoaWxkX2J5X25hbWUoc3BpLT5kZXYub2Zfbm9kZSwg
Im9hLXRjNiIpOw0KPj4gQEAgLTI0Miw3ICsyNTcsNyBAQCBzdGF0aWMgaW50IG9hX3RjNl9jb25m
aWd1cmUoc3RydWN0IG9hX3RjNiAqdGM2KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAo
dGM2LT5jcHMgPCBtaW5jcHMpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FTk9ERVY7DQo+PiAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgIHRjNi0+Y3BzID0gNjQ7DQo+PiArICAgICAgICAgICAgICAgICAgICAgdGM2LT5j
cHMgPSBPQV9UQzZfTUFYX0NQUzsNCj4gDQo+IFRoaXMgYWxzbyBzaG91bGQgb2YgYmVlbiBpbiBh
biBlYXJsaWVyIHBhdGNoLg0KWWVzLCB3aWxsIGNvcnJlY3QgaXQuDQo+IA0KPj4gICAgICAgICAg
ICAgICAgfQ0KPj4gICAgICAgICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3ByZXNlbnQob2Ffbm9k
ZSwgIm9hLXR4Y3RlIikpIHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgLyogUmV0dXJuIGVy
cm9yIGlmIHRoZSB0eCBjdXQgdGhyb3VnaCBtb2RlIGlzIGNvbmZpZ3VyZWQNCj4+IEBAIC0yNjYs
OCArMjgxLDI2IEBAIHN0YXRpYyBpbnQgb2FfdGM2X2NvbmZpZ3VyZShzdHJ1Y3Qgb2FfdGM2ICp0
YzYpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHJlZ3ZhbCB8PSBQUk9URTsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgdGM2LT5wcm90ZSA9IHRydWU7DQo+PiAgICAgICAgICAgICAgICB9
DQo+PiArICAgICAgICAgICAgIGlmIChvZl9wcm9wZXJ0eV9wcmVzZW50KG9hX25vZGUsICJvYS1k
cHJhYyIpKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgLyogUmV0dXJuIGVycm9yIGlmIHRo
ZSBkaXJlY3QgcGh5IHJlZ2lzdGVyIGFjY2VzcyBtb2RlDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICogaXMgY29uZmlndXJlZCBidXQgaXQgaXMgbm90IHN1cHBvcnRlZCBieSBNQUMtUEhZLg0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlm
IChkcHJhYykNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjNi0+ZHByYWMgPSB0
cnVlOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gKyAgICAgICAgICAgICB9DQo+IA0KPiBU
aGlzIGlzIG5vdCBpbiB0aGUgYmluZGluZy4gV2h5IGRvIHdlIGV2ZW4gbmVlZCB0byBiZSBhYmxl
IHRvDQo+IGNvbmZpZ3VyZSBpdC4gRGlyZWN0IGlzIGZhc3Rlciwgc28gdXNlIGl0IGlzIGF2YWls
YWJsZS4gSWYgbm90LCB1c2UNCj4gaW5kaXJlY3QuIEFuZCBpZiBib3RoIGRwcmFjIGFuZCBpcHJv
YyBhcmUgZmFsc2UsIGRldl9lcnIoKSBhbmQNCj4gLUVOT0RFVi4NCk9rLCBJIHdpbGwgcmVtb3Zl
IHRoaXMgb3B0aW9uIGV2ZW4gaW4gdGhlIG5leHQgcGF0Y2ggYW5kIHdpbGwgZ28gd2l0aCANCnRo
ZSBvcHRpb24gcmVhZCBmcm9tIHRoZSBjYXBhYmlsaXR5IHJlZ2lzdGVyIChTVERDQVApLg0KPiAN
Cj4+ICtzdGF0aWMgaW50IG9hX3RjNl9tZGlvYnVzX3JlYWQoc3RydWN0IG1paV9idXMgKmJ1cywg
aW50IHBoeV9pZCwgaW50IGlkeCkNCj4gDQo+IEl0IHdvdWxkIGJlIGdvb2QgdG8gcHV0IGRpcmVj
dCBpbiB0aGUgbmFtZS4gSWYgc29tZWJvZHkgaW1wbGVtZW50cw0KPiBpbmRpcmVjdCwgaXQgd2ls
bCBtYWtlIHRoZSBuYW1pbmcgZWFzaWVyLg0KWWVzIHN1cmUuDQo+IA0KPj4gK3sNCj4+ICsgICAg
IHN0cnVjdCBvYV90YzYgKnRjNiA9IGJ1cy0+cHJpdjsNCj4+ICsgICAgIHUzMiByZWd2YWw7DQo+
PiArICAgICBib29sIHJldDsNCj4+ICsNCj4+ICsgICAgIHJldCA9IG9hX3RjNl9yZWFkX3JlZ2lz
dGVyKHRjNiwgMHhGRjAwIHwgKGlkeCAmIDB4RkYpLCAmcmVndmFsKTsNCj4+ICsgICAgIGlmIChy
ZXQpDQo+PiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gKw0KPj4gKyAgICAgcmV0
dXJuIHJlZ3ZhbDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBvYV90YzZfbWRpb2J1c193
cml0ZShzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQgcGh5X2lkLCBpbnQgaWR4LA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdTE2IHZhbCkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3Qg
b2FfdGM2ICp0YzYgPSBidXMtPnByaXY7DQo+PiArDQo+PiArICAgICByZXR1cm4gb2FfdGM2X3dy
aXRlX3JlZ2lzdGVyKHRjNiwgMHhGRjAwIHwgKGlkeCAmIDB4RkYpLCB2YWwpOw0KPj4gK30NCj4+
ICsNCj4+ICtzdGF0aWMgaW50IG9hX3RjNl9waHlfaW5pdChzdHJ1Y3Qgb2FfdGM2ICp0YzYpDQo+
PiArew0KPj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIGlmICh0YzYtPmRwcmFjKSB7
DQo+IA0KPiBZb3UgY2FuIGF2b2lkIHRoZSBpbmRlbnRhdGlvbiBieSBmaXJzdCBjaGVja2luZyBp
bmRpcmVjdCBpcyB0aGUgb25seQ0KPiBjaG9pY2UsIGFuZCBkb2luZyBhIGRldl9lcnIoKSBmb2xs
b3dlZCBieSByZXR1cm4gLUVOT0RFVi4NCkFoIG9rLCB3aWxsIGRvIGl0Lg0KPiANCj4+ICsgICAg
ICAgICAgICAgdGM2LT5tZGlvYnVzID0gbWRpb2J1c19hbGxvYygpOw0KPj4gKyAgICAgICAgICAg
ICBpZiAoIXRjNi0+bWRpb2J1cykgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9l
cnIodGM2LT5uZXRkZXYsICJNRElPIGJ1cyBhbGxvYyBmYWlsZWRcbiIpOw0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gKyAgICAgICAgICAgICB9DQo+PiArDQo+
PiArICAgICAgICAgICAgIHRjNi0+bWRpb2J1cy0+cGh5X21hc2sgPSB+KHUzMilCSVQoMSk7DQo+
IA0KPiBEb2VzIHRoZSBzdGFuZGFyZCBkZWZpbmUgdGhpcyA/IEJJVCgxKSwgbm90IEJJVCgwKT8N
Ck9rLCBJIHRoaW5rIGhlcmUgaXMgYSB0eXBvLiBXaWxsIGNvcnJlY3QgaXQuDQo+IA0KPj4gICAv
KioNCj4+ICAgICogb2FfdGM2X2luaXQgLSBhbGxvY2F0ZXMgYW5kIGludGlhbGl6ZXMgb2FfdGM2
IHN0cnVjdHVyZS4NCj4+ICAgICogQHNwaTogZGV2aWNlIHdpdGggd2hpY2ggZGF0YSB3aWxsIGJl
IGV4Y2hhbmdlZC4NCj4+IC0gKiBAcHJvdGU6IGNvbnRyb2wgZGF0YSAocmVnaXN0ZXIpIHJlYWQv
d3JpdGUgcHJvdGVjdGlvbiBlbmFibGUvZGlzYWJsZS4NCj4gDQo+IFNvbWV0aGluZyBlbHNlIHdo
aWNoIHNob3VsZCBvZiBiZWVuIGluIHRoZSBwcmV2aW91cyBwYXRjaC4gUGxlYXNlIGxvb2sNCj4g
dGhyb3VnaCB0aGlzIHBhdGNoIGFuZCBmaW5kIGFsbCB0aGUgb3RoZXIgaW5zdGFuY2VzLg0KWWVz
IHN1cmUuIFdpbGwgY29ycmVjdCBpdC4NCj4gDQo+PiArICogQG5ldGRldjogbmV0d29yayBkZXZp
Y2UgdG8gdXNlLg0KPj4gICAgKg0KPj4gICAgKiBSZXR1cm5zIHBvaW50ZXIgcmVmZXJlbmNlIHRv
IHRoZSBvYV90YzYgc3RydWN0dXJlIGlmIGFsbCB0aGUgbWVtb3J5DQo+PiAgICAqIGFsbG9jYXRp
b24gc3VjY2VzcyBvdGhlcndpc2UgTlVMTC4NCj4+ICAgICovDQo+PiAtc3RydWN0IG9hX3RjNiAq
b2FfdGM2X2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4+ICtzdHJ1Y3Qgb2FfdGM2ICpv
YV90YzZfaW5pdChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCBzdHJ1Y3QgbmV0X2RldmljZSAqbmV0
ZGV2KQ0KPj4gICB7DQo+PiAgICAgICAgc3RydWN0IG9hX3RjNiAqdGM2Ow0KPj4NCj4+IEBAIC0z
OTUsMTUgKzUyMSwxOSBAQCBzdHJ1Y3Qgb2FfdGM2ICpvYV90YzZfaW5pdChzdHJ1Y3Qgc3BpX2Rl
dmljZSAqc3BpKQ0KPj4gICAgICAgIGlmICghdGM2KQ0KPj4gICAgICAgICAgICAgICAgcmV0dXJu
IE5VTEw7DQo+Pg0KPj4gKyAgICAgLyogQWxsb2NhdGUgbWVtb3J5IGZvciB0aGUgY29udHJvbCB0
eCBidWZmZXIgdXNlZCBmb3IgU1BJIHRyYW5zZmVyLiAqLw0KPj4gICAgICAgIHRjNi0+Y3RybF90
eF9idWYgPSBkZXZtX2t6YWxsb2MoJnNwaS0+ZGV2LCBUQzZfQ1RSTF9CVUZfU0laRSwgR0ZQX0tF
Uk5FTCk7DQo+PiAgICAgICAgaWYgKCF0YzYtPmN0cmxfdHhfYnVmKQ0KPj4gICAgICAgICAgICAg
ICAgcmV0dXJuIE5VTEw7DQo+Pg0KPj4gKyAgICAgLyogQWxsb2NhdGUgbWVtb3J5IGZvciB0aGUg
Y29udHJvbCByeCBidWZmZXIgdXNlZCBmb3IgU1BJIHRyYW5zZmVyLiAqLw0KPj4gICAgICAgIHRj
Ni0+Y3RybF9yeF9idWYgPSBkZXZtX2t6YWxsb2MoJnNwaS0+ZGV2LCBUQzZfQ1RSTF9CVUZfU0la
RSwgR0ZQX0tFUk5FTCk7DQo+PiAgICAgICAgaWYgKCF0YzYtPmN0cmxfcnhfYnVmKQ0KPj4gICAg
ICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+Pg0KPj4gICAgICAgIHRjNi0+c3BpID0gc3BpOw0K
Pj4gKyAgICAgdGM2LT5uZXRkZXYgPSBuZXRkZXY7DQo+PiArICAgICBTRVRfTkVUREVWX0RFVihu
ZXRkZXYsICZzcGktPmRldik7DQo+Pg0KPj4gICAgICAgIC8qIFBlcmZvcm0gTUFDLVBIWSBzb2Z0
d2FyZSByZXNldCAqLw0KPj4gICAgICAgIGlmIChvYV90YzZfc3dfcmVzZXQodGM2KSkgew0KPj4g
QEAgLTQxNywxMCArNTQ3LDI3IEBAIHN0cnVjdCBvYV90YzYgKm9hX3RjNl9pbml0KHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgICAg
ICB9DQo+Pg0KPj4gKyAgICAgLyogSW5pdGlhbGl6ZSBQSFkgKi8NCj4+ICsgICAgIGlmIChvYV90
YzZfcGh5X2luaXQodGM2KSkgew0KPj4gKyAgICAgICAgICAgICBkZXZfZXJyKCZzcGktPmRldiwg
IlBIWSBpbml0aWFsaXphdGlvbiBmYWlsZWRcbiIpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4g
TlVMTDsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICAgICAgICByZXR1cm4gdGM2Ow0KPj4gICB9DQo+
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKG9hX3RjNl9pbml0KTsNCj4+DQo+PiArLyoqDQo+PiArICog
b2FfdGM2X2V4aXQgLSBleGl0IGZ1bmN0aW9uLg0KPj4gKyAqIEB0YzY6IG9hX3RjNiBzdHJ1Y3Qu
DQo+PiArICoNCj4+ICsgKi8NCj4+ICt2b2lkIG9hX3RjNl9leGl0KHN0cnVjdCBvYV90YzYgKnRj
NikNCj4+ICt7DQo+PiArICAgICBvYV90YzZfcGh5X2V4aXQodGM2KTsNCj4+ICt9DQo+PiArRVhQ
T1JUX1NZTUJPTF9HUEwob2FfdGM2X2V4aXQpOw0KPj4gKw0KPj4gICBNT0RVTEVfREVTQ1JJUFRJ
T04oIk9QRU4gQWxsaWFuY2UgMTBCQVNF4oCRVDF4IE1BQ+KAkVBIWSBTZXJpYWwgSW50ZXJmYWNl
IExpYiIpOw0KPj4gICBNT0RVTEVfQVVUSE9SKCJQYXJ0aGliYW4gVmVlcmFzb29yYW4gPHBhcnRo
aWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPiIpOw0KPj4gICBNT0RVTEVfTElDRU5TRSgi
R1BMIik7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9vYV90YzYuaCBiL2luY2x1ZGUv
bGludXgvb2FfdGM2LmgNCj4+IGluZGV4IDM3ODYzNmZkOWNhOC4uMzZiNzI5YzM4NGFjIDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9vYV90YzYuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51
eC9vYV90YzYuaA0KPj4gQEAgLTUsNTQgKzUsNTkgQEANCj4+ICAgICogQXV0aG9yOiBQYXJ0aGli
YW4gVmVlcmFzb29yYW4gPHBhcnRoaWJhbi52ZWVyYXNvb3JhbkBtaWNyb2NoaXAuY29tPg0KPj4g
ICAgKi8NCj4+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+DQo+PiAgICNpbmNs
dWRlIDxsaW51eC9zcGkvc3BpLmg+DQo+Pg0KPj4gICAvKiBDb250cm9sIGhlYWRlciAqLw0KPj4g
LSNkZWZpbmUgQ1RSTF9IRFJfRE5DICAgICAgICAgQklUKDMxKSAgICAgICAgIC8qIERhdGEtTm90
LUNvbnRyb2wgKi8NCj4+IC0jZGVmaW5lIENUUkxfSERSX0hEUkIgICAgICAgICAgICAgICAgQklU
KDMwKSAgICAgICAgIC8qIFJlY2VpdmVkIEhlYWRlciBCYWQgKi8NCj4+IC0jZGVmaW5lIENUUkxf
SERSX1dOUiAgICAgICAgIEJJVCgyOSkgICAgICAgICAvKiBXcml0ZS1Ob3QtUmVhZCAqLw0KPj4g
LSNkZWZpbmUgQ1RSTF9IRFJfQUlEICAgICAgICAgQklUKDI4KSAgICAgICAgIC8qIEFkZHJlc3Mg
SW5jcmVtZW50IERpc2FibGUgKi8NCj4+IC0jZGVmaW5lIENUUkxfSERSX01NUyAgICAgICAgIEdF
Tk1BU0soMjcsIDI0KSAvKiBNZW1vcnkgTWFwIFNlbGVjdG9yICovDQo+PiAtI2RlZmluZSBDVFJM
X0hEUl9BRERSICAgICAgICAgICAgICAgIEdFTk1BU0soMjMsIDgpICAvKiBBZGRyZXNzICovDQo+
PiAtI2RlZmluZSBDVFJMX0hEUl9MRU4gICAgICAgICBHRU5NQVNLKDcsIDEpICAgLyogTGVuZ3Ro
ICovDQo+PiAtI2RlZmluZSBDVFJMX0hEUl9QICAgICAgICAgICBCSVQoMCkgICAgICAgICAgLyog
UGFyaXR5IEJpdCAqLw0KPj4gKyNkZWZpbmUgQ1RSTF9IRFJfRE5DIEJJVCgzMSkgICAgICAgICAv
KiBEYXRhLU5vdC1Db250cm9sICovDQo+PiArI2RlZmluZSBDVFJMX0hEUl9IRFJCICAgICAgICBC
SVQoMzApICAgICAgICAgLyogUmVjZWl2ZWQgSGVhZGVyIEJhZCAqLw0KPj4gKyNkZWZpbmUgQ1RS
TF9IRFJfV05SIEJJVCgyOSkgICAgICAgICAvKiBXcml0ZS1Ob3QtUmVhZCAqLw0KPj4gKyNkZWZp
bmUgQ1RSTF9IRFJfQUlEIEJJVCgyOCkgICAgICAgICAvKiBBZGRyZXNzIEluY3JlbWVudCBEaXNh
YmxlICovDQo+PiArI2RlZmluZSBDVFJMX0hEUl9NTVMgR0VOTUFTSygyNywgMjQpIC8qIE1lbW9y
eSBNYXAgU2VsZWN0b3IgKi8NCj4+ICsjZGVmaW5lIENUUkxfSERSX0FERFIgICAgICAgIEdFTk1B
U0soMjMsIDgpICAvKiBBZGRyZXNzICovDQo+PiArI2RlZmluZSBDVFJMX0hEUl9MRU4gR0VOTUFT
Syg3LCAxKSAgIC8qIExlbmd0aCAqLw0KPj4gKyNkZWZpbmUgQ1RSTF9IRFJfUCAgIEJJVCgwKSAg
ICAgICAgICAvKiBQYXJpdHkgQml0ICovDQo+IA0KPiBQbGVhc2UgZG9uJ3QgY2hhbmdlIHRoZSB3
aGl0ZXNwYWNlIGxpa2UgdGhpcy4NCkFoIHllcywgd2lsbCBjb3JyZWN0IGl0Lg0KDQpCZXN0IFJl
Z2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICBBbmRyZXcNCg0K
