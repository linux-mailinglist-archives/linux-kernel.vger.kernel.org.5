Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A297A907D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjIUBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:31:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351EA1;
        Wed, 20 Sep 2023 18:31:40 -0700 (PDT)
X-UUID: 97051f2e581e11ee8051498923ad61e6-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1RKShM9diTXAFTjUQ1zwsDVnImMwuRqCaomM1zqAXsI=;
        b=uZo2hx8MNvtdov3rrCZz/GcEV3m1HAsWq94/3qxW6VnzXGEnkKXFB3cvgrrXF4zEPTv/0dlJ18KV8DFXiONUAj+PlchRomRfRRwrNAC0rO9WW9+YWRMeAJD0QeDJCAzWhvCiRGoyiv823yZy/yAkAQas5WsEJZlCTma0JXXV5Fo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:527123d9-d0a6-4f9f-b670-76d61afefe91,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e1d22e14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 97051f2e581e11ee8051498923ad61e6-20230921
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 847648354; Thu, 21 Sep 2023 09:31:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 09:31:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 09:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgQSnrT/0r54mNkyfG6960e44If97/N33DfQcZe0Dd9/k/K6FmuuOiajVZYQ1SDK4GhWLiv4K0rH8lwv+N7Lqnq1xuP6YAoV4lJsS6uIZGtUS/rq9jE+j3S8/EyF+yZzdPEucO9FlOaAJC6yhsjjesn+IcVrefXVWFEvyEAH5K92XCw6C6ylMzEi1ZeI0ALqA17jDSpzWiAEYIVzGbP9RUQEP9HkkFyYM5xbGjN3LztF2wqz9WNALKjqxBuPkw8d0nxhl6HaTUvjqMMhUkhMm6zfNGVTsgRFQijULQscXfGol3VmZHeAaP/cnToSvuQrgLyqnYzbGSwlUoYzxlXjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RKShM9diTXAFTjUQ1zwsDVnImMwuRqCaomM1zqAXsI=;
 b=QmUafzrpt0wl338ifqz+qaPSLR3Qub9OpVwhXxXACiuE6778f2ccZxJcrq27nU7FBhD8/G4zjsXQ8+RcZPDsdxZ2t2xyXRPto+KitRCkSLBSGmFsgLK3stL6AR7jo1G0wWrCGm3Ibher1HCSJvbAr6yvg8HlGWen59Bdfqll0WGYb3CPdCbh9y3c46af9HfKOe7BGI48/u/S6vtg+HW/YvGR3zgpu0gVr+TDp5UVFWaF1o8O16B0ycC80dBqN/5Mr4+UihPkMo6QshkWjXuJuurcNPF5R/0GUrvnz5IOOopQMuS+SZvN6QAMGLb+8gR0+9PyYk0X2GSGk4bcYlazdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RKShM9diTXAFTjUQ1zwsDVnImMwuRqCaomM1zqAXsI=;
 b=iQOjGidyyY6Ytr5pltSziSgrD6cgZ88jLR9I2UDlkhDTnJyCL1VesE7C0aclJsWA2V5TtHRFxFB423gjmOpIYeps4Jztu/3SF2ieLXGbAtRS2T/YHK95NBhmyaq6Wvs3LqLPijx+metLrdejI2kBoQz3/eURSuwmrFPC62ZM8Mo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5619.apcprd03.prod.outlook.com (2603:1096:820:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 01:31:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 01:31:27 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "jkardatzke@google.com" <jkardatzke@google.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH 00/10] Add mediate-drm secure flow for SVP
Thread-Index: AQHZ6qYCRTH7YrTpyk6QXsEzLaAxhrAjMCUAgADaFgCAAHckgA==
Date:   Thu, 21 Sep 2023 01:31:26 +0000
Message-ID: <0f828842524f1518ccb6f75e6b34efd849466016.camel@mediatek.com>
References: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
         <a0b32a1d93bc9d991f77ad3408fe7b177bb32889.camel@mediatek.com>
         <CA+ddPcNPeo=z42fG24uoSMJ8M0uWB-huzXVKBm-seG=7b+50JA@mail.gmail.com>
In-Reply-To: <CA+ddPcNPeo=z42fG24uoSMJ8M0uWB-huzXVKBm-seG=7b+50JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5619:EE_
x-ms-office365-filtering-correlation-id: 74664959-a900-4f87-5fd3-08dbba427955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4S0LAdn4FGaSL2FsWyBlQzKr2Z6TJP3lSCCN/0k20qbjAglCp3GljCoKWPzzUiwtmu9uXfUbHpAHR/slifh3Ohg3z1pcgkj9PdIeTw0LElm3iLDlnirHy1k7JUMKsxqKiqQostJobK0HBGMsqGKDRyKz64wrGL9fJXmbRvzRqu7nbVtCTZvirLPc4zdGsjKEYqpPH1Lfexx1tVMp8xBm5CqbaSddpTLurG7E8SXGnJS3GZ9xa1amwK/Xp/l0Yqa/k7zK6vm6MS/KTgi/8lDBLe4s0fRigpmx1t7lj3Z8v6vTpCdvkSrbDJr3bkn55aY06W0msvraHOr9KdF7n++oIFHhafjH1aGPGzExTb4yC+QVfM1T7UtBH547QWxSPkdNscpmes/v4iSsWh3RxA/HBrwnLJFErFId2USjGb52VQpb6AAhhsDXMBHs6gDndVWYioaxxEFgWahw8bj/XdFeqBMfGT3CPV3jz7jaSC2Jffht15FlbYKmXAmfMbFYSG7bQ4Qclh8tLQgoRWSQMVMxCTfemTJBNjSdNYWUEMbmDNENIuxUXSPt08ALOvffkqGtH/3GW6Bo/qQ54I7V1LARAv1lu6spOwc+0DpzFzj0h1p9RgQ8XGDnQEAkK3vk+bIgQSOYs2D+lI2cs7IdYV58+kFeh61aONMHhPaNHt/aUO1PtH3JfKGb50fAy47DwPB7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199024)(186009)(1800799009)(7416002)(2906002)(6916009)(54906003)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(316002)(4326008)(5660300002)(8936002)(8676002)(71200400001)(86362001)(85182001)(36756003)(83380400001)(26005)(2616005)(122000001)(966005)(38100700002)(38070700005)(478600001)(6512007)(6486002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZFZ0xEZjREZkttSGVneDF4dldGc0dyZU5oR2pTN05Hd3BkN3Y5OC9PUmM3?=
 =?utf-8?B?U01RYTV1bVA3UHlxOTFNMHlnUjlEZ1k1TVhrZ05VQWsyMnVSM09RT3JweS8r?=
 =?utf-8?B?NmFEK0xjT3l3cXBkZVpaZmhnMW5QenpkdGM2MHhUWkttNG5mejN4Q2JhSDVP?=
 =?utf-8?B?V3VDYVVuNk50ZXdjSStlMVRqU1lzdnFNRU1pcXRlbDdsOVZxRHNzajhVU29X?=
 =?utf-8?B?b2tzWjY1Z0JDbzZqQ1RBZXVBRFZWNnRNVXJTRzBkQU1tMTQySUYybjE3Zm5W?=
 =?utf-8?B?akJ3azljYkI2OTFwODVEaDljTXhPTlZVNEJiUjVMeUtqVmxxV1ppMFhsQ2VN?=
 =?utf-8?B?TDkvV2Ftc3lyUm44ZGR0QjJ1QnRLQzdiV1ZaZXRuOHAyTnF1WVFEQW9BaU9U?=
 =?utf-8?B?SmJRUXpYN3lNNVdCK25oY2V1eGE2L3ZUY0RCWTF5UnAwem4rV3FydUtaNFNO?=
 =?utf-8?B?bmQyWGhBNWlaazZTbnlnVlJXUjlyYldxTDU5TUxZUEViZElIUythaFNBazRr?=
 =?utf-8?B?UkRvWFZZNSt1dE05aGN4Vkd0Wm5PNG5ORExTaXUzU3F4TURYUDE3ZWJ2OHAy?=
 =?utf-8?B?cnc0ZmVhd1JjVEFFdm1UV0h4Y3dZbzN6WWpLMThUNjFHSGNSZi9iOHUrQkV5?=
 =?utf-8?B?ZFROYkF3RTFOQWpFbGQ2dzJUb1FmMyt6YUM0dktRQUZWbHJlU01DNUUrWjBn?=
 =?utf-8?B?YmtxVFd0RUJEVHR6TWtoR3hzSlFhS2hPbWZDSyt0ZithY0xZT2ZVOXdlVG1y?=
 =?utf-8?B?TmYyTGcwdWRwdTA4RFZKbitpUjFQU2J0alRRMXN3NVE5QVNlWkh2TktmeXQ1?=
 =?utf-8?B?MDFFcjJ5T1NmdSs2MUNLY2tLM2lBUHdTZ1V5enVXZHlLNklJc1NMUWZGeDhj?=
 =?utf-8?B?anNhbGVCRDN5dTBFVlkzalR5eUFlcW9DbW1WMnVBbXUrbFRUYzVyanI0R1VJ?=
 =?utf-8?B?dHppZGhabXBWcWtnYkRiOW1FV2JxT0huN1lIM2RpQno1VUI5eE5uLzg5VmpG?=
 =?utf-8?B?enJ5eFRLb25oT2hLenhWbmRZUFF5STdZY1R3cDZpNEU5dm9JaWJXUWRQSmph?=
 =?utf-8?B?UnZTTThyZE9vaE9kZWF2MlprUUpNbmx6VnpjVTZRVjdHNGx4aXRpQTJCb2No?=
 =?utf-8?B?Wko3MVgzTjkxOXZ4eHhQaHFpUGQ2bGFhcDlJZXpSUXpqb0dvYW5ic2NHUmF6?=
 =?utf-8?B?R1g1Z3V4UFRiQVBjNitjMGF0cFByTXR4WlBEUUcyRFM0TjVoSEg3M29LOExl?=
 =?utf-8?B?dEQ0RXpVeWlYYUt1SnRwL1VybGhlcG1CT093dFdPL0dpSzNxenBVSWJPWmJK?=
 =?utf-8?B?Y2pEZExYdmMycENxWDNvdThvQWZwdkV4bVQ5SGlPWFBmRHVlSFg3NVFvK0My?=
 =?utf-8?B?V0dJeUo1eW1RTjRPUGpBeEl1N2w1Nm5OZXRhQzNTcnNRZ0o3RU85bnMwQU5y?=
 =?utf-8?B?bkNwdzgvUmRRdmtobkV4WUlvNFhDWHF3SFVUVklBNzROVmI4eXhZU1hUM0p5?=
 =?utf-8?B?UHplSi9FK05VRHJ0MHFKd2RXazJ3RGZjUFJxTTBTb1ErRlRWSlVNWElYdm5W?=
 =?utf-8?B?WnU5TkNzbC9GRUN1T1RmclJJV2xBYlBVVFN4VHR0NkRxMVprMkhhZ0NMdGZa?=
 =?utf-8?B?b1k0YUw1RmgrS0hrYjFtb0xLSVdXK0xCeXlDQ3NISkt2N2M3dEg2SU5VeE9j?=
 =?utf-8?B?VERJYnU0bk1JOVBmbU1sbVFQdFp5NE9mUllsUzM3YU9UNHU1WXdtbGg3cWFp?=
 =?utf-8?B?dzA5RWpYcnJUUnJoZG9QSmJ4TkRnbGlUa3h2ODVrdXhiRWxkNmdqbzNhTy9m?=
 =?utf-8?B?d1VlcnZLbDYzWXV0MXBWblJob3BBRjdlS2lRUGwwRHFVdmZWOHF0QjU3dDM2?=
 =?utf-8?B?alhpNGZUMk1CTXhuajlyM2hCOGs4RFltUDRDTmlDY3hVSnE5My9NdFphV2Ez?=
 =?utf-8?B?L1d1anRnNDhqd0ZqMTZNbjdsY25OajVmS2RiQTFuVVdrMWdsU1Z4MHA1Ulhh?=
 =?utf-8?B?aG1FYzZUMnZHR1BPblhDRFNyRk9IVUc5YXRpam5VN2RrdGFYc2FGOTh4Ky9J?=
 =?utf-8?B?bExLR2hEa0JEM3FkZDVMOXNoSkI2dzI5RUVva3ZWNjM2QkphcXNiNHNuc2lj?=
 =?utf-8?Q?5D2Ynk/8+z9x81cYx+mqfIOXy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E379639542884CBE9FD9D13D513522@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74664959-a900-4f87-5fd3-08dbba427955
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 01:31:26.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHBmY2z1JaRXkzv2AOV+7zh/LuzLkpy47DeQIGWZ12MDp+AjkbNrTIwVddYOhiHt+ossa6pCAwUOBTXuIcLDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5619
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA5LTIwIGF0IDExOjI1IC0wNzAwLCBKZWZmcmV5IEthcmRhdHprZSB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCAxMDoyNuKAr1BNIENL
IEh1ICjog6Hkv4rlhYkpIDxjay5odUBtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
SGksIEphc29uOg0KPiA+DQo+ID4gT24gVHVlLCAyMDIzLTA5LTE5IGF0IDExOjAzICswODAwLCBK
YXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gPiBUaGUgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGRybSBk
cml2ZXIgc3VwcG9ydCBmb3IgZW5hYmxpbmcgc2VjdXJlDQo+ID4gPiB2aWRlbw0KPiA+ID4gcGF0
aCAoU1ZQKSBwbGF5YmFjayBvbiBNZWRpYWlUZWsgaGFyZHdhcmUgaW4gdGhlIExpbnV4IGtlcm5l
bC4NCj4gPiA+DQo+ID4gPiBNZW1vcnkgRGVmaW5pdGlvbnM6DQo+ID4gPiBzZWN1cmUgbWVtb3J5
IC0gTWVtb3J5IGFsbG9jYXRlZCBpbiB0aGUgVEVFIChUcnVzdGVkIEV4ZWN1dGlvbg0KPiA+ID4g
RW52aXJvbm1lbnQpIHdoaWNoIGlzIGluYWNjZXNzaWJsZSBpbiB0aGUgUkVFIChSaWNoIEV4ZWN1
dGlvbg0KPiA+ID4gRW52aXJvbm1lbnQsIGkuZS4gbGludXgga2VybmVsL3VzZXJzcGFjZSkuDQo+
ID4gPiBzZWN1cmUgaGFuZGxlIC0gSW50ZWdlciB2YWx1ZSB3aGljaCBhY3RzIGFzIHJlZmVyZW5j
ZSB0byAnc2VjdXJlDQo+ID4gPiBtZW1vcnknLiBVc2VkIGluIGNvbW11bmljYXRpb24gYmV0d2Vl
biBURUUgYW5kIFJFRSB0byByZWZlcmVuY2UNCj4gPiA+ICdzZWN1cmUgbWVtb3J5Jy4NCj4gPiA+
IHNlY3VyZSBidWZmZXIgLSAnc2VjdXJlIG1lbW9yeScgdGhhdCBpcyB1c2VkIHRvIHN0b3JlIGRl
Y3J5cHRlZCwNCj4gPiA+IGNvbXByZXNzZWQgdmlkZW8gb3IgZm9yIG90aGVyIGdlbmVyYWwgcHVy
cG9zZXMgaW4gdGhlIFRFRS4NCj4gPiA+IHNlY3VyZSBzdXJmYWNlIC0gJ3NlY3VyZSBtZW1vcnkn
IHRoYXQgaXMgdXNlZCB0byBzdG9yZSBncmFwaGljDQo+ID4gPiBidWZmZXJzLg0KPiA+ID4NCj4g
PiA+IE1lbW9yeSBVc2FnZSBpbiBTVlA6DQo+ID4gPiBUaGUgb3ZlcmFsbCBmbG93IG9mIFNWUCBz
dGFydHMgd2l0aCBlbmNyeXB0ZWQgdmlkZW8gY29taW5nIGluDQo+IGZyb20gYW4NCj4gPiA+IG91
dHNpZGUgc291cmNlIGludG8gdGhlIFJFRS4gVGhlIFJFRSB3aWxsIHRoZW4gYWxsb2NhdGUgYSAn
c2VjdXJlDQo+ID4gPiBidWZmZXInIGFuZCBzZW5kIHRoZSBjb3JyZXNwb25kaW5nICdzZWN1cmUg
aGFuZGxlJyBhbG9uZyB3aXRoIHRoZQ0KPiA+ID4gZW5jcnlwdGVkLCBjb21wcmVzc2VkIHZpZGVv
IGRhdGEgdG8gdGhlIFRFRS4gVGhlIFRFRSB3aWxsIHRoZW4NCj4gPiA+IGRlY3J5cHQNCj4gPiA+
IHRoZSB2aWRlbyBhbmQgc3RvcmUgdGhlIHJlc3VsdCBpbiB0aGUgJ3NlY3VyZSBidWZmZXInLiBU
aGUgUkVFDQo+IHdpbGwNCj4gPiA+IHRoZW4gYWxsb2NhdGUgYSAnc2VjdXJlIHN1cmZhY2UnLiBU
aGUgUkVFIHdpbGwgcGFzcyB0aGUgJ3NlY3VyZQ0KPiA+ID4gaGFuZGxlcycgZm9yIGJvdGggdGhl
ICdzZWN1cmUgYnVmZmVyJyBhbmQgJ3NlY3VyZSBzdXJmYWNlJyBpbnRvDQo+IHRoZQ0KPiA+ID4g
VEVFIGZvciB2aWRlbyBkZWNvZGluZy4gVGhlIHZpZGVvIGRlY29kZXIgSFcgd2lsbCB0aGVuIGRl
Y29kZSB0aGUNCj4gPiA+IGNvbnRlbnRzIG9mIHRoZSAnc2VjdXJlIGJ1ZmZlcicgYW5kIHBsYWNl
IHRoZSByZXN1bHQgaW4gdGhlDQo+ICdzZWN1cmUNCj4gPiA+IHN1cmZhY2UnLiBUaGUgUkVFIHdp
bGwgdGhlbiBhdHRhY2ggdGhlICdzZWN1cmUgc3VyZmFjZScgdG8gdGhlDQo+ID4gPiBvdmVybGF5
DQo+ID4gPiBwbGFuZSBmb3IgcmVuZGVyaW5nIG9mIHRoZSB2aWRlby4NCj4gPiA+DQo+ID4gPiBF
dmVyeXRoaW5nIHJlbGF0aW5nIHRvIGVuc3VyaW5nIHNlY3VyaXR5IG9mIHRoZSBhY3R1YWwgY29u
dGVudHMNCj4gb2YNCj4gPiA+IHRoZQ0KPiA+ID4gJ3NlY3VyZSBidWZmZXInIGFuZCAnc2VjdXJl
IHN1cmZhY2UnIGlzIG91dCBvZiBzY29wZSBmb3IgdGhlIFJFRQ0KPiBhbmQNCj4gPiA+IGlzIHRo
ZSByZXNwb25zaWJpbGl0eSBvZiB0aGUgVEVFLg0KPiA+ID4NCj4gPiA+IERSTSBkcml2ZXIgaGFu
ZGxlcyBhbGxvY2F0aW9uIG9mIGdlbSBvYmplY3RzIHRoYXQgYXJlIGJhY2tlZCBieSBhDQo+ID4g
PiAnc2VjdXJlDQo+ID4gPiBzdXJmYWNlJyBhbmQgZm9yIGRpc3BsYXlpbmcgYSAnc2VjdXJlIHN1
cmZhY2UnIG9uIHRoZSBvdmVybGF5DQo+IHBsYW5lLg0KPiA+ID4gVGhpcyBpbnRyb2R1Y2VzIGEg
bmV3IGZsYWcgZm9yIG9iamVjdCBjcmVhdGlvbiBjYWxsZWQNCj4gPiA+IERSTV9NVEtfR0VNX0NS
RUFURV9FTkNSWVBURUQgd2hpY2ggaW5kaWNhdGVzIGl0IHNob3VsZCBiZSBhDQo+ICdzZWN1cmUN
Cj4gPiA+IHN1cmZhY2UnLiBBbGwgY2hhbmdlcyBoZXJlIGFyZSBpbiBNZWRpYVRlayBzcGVjaWZp
YyBjb2RlLg0KPiA+DQo+ID4gSG93IGRvIHlvdSBkZWZpbmUgU1ZQPyBJcyB0aGVyZSBzdGFuZGFy
ZCByZXF1aXJlbWVudCB3ZSBjb3VsZCByZWZlcg0KPiB0bz8NCj4gPiBJZiB0aGUgc2VjdXJlIHZp
ZGVvIGJ1ZmZlciBpcyByZWFkIGJ5IGRpc3BsYXkgaGFyZHdhcmUgYW5kIG91dHB1dA0KPiB0bw0K
PiA+IEhETUkgd2l0aG91dCBhbnkgcHJvdGVjdGlvbiBhbmQgdXNlciBjb3VsZCBjYXB0dXJlIEhE
TUkgc2lnbmFsLCBpcw0KPiB0aGlzDQo+ID4gc2VjdXJlPw0KPiANCj4gU1ZQIChTZWN1cmUgVmlk
ZW8gUGF0aCkgaXMgZXNzZW50aWFsbHkgdGhlIHZpZGVvIGJlaW5nIGNvbXBsZXRlZA0KPiBpc29s
YXRlZCBmcm9tIHRoZSBrZXJuZWwvdXNlcnNwYWNlLiBUaGUgc3BlY2lmaWMgcmVxdWlyZW1lbnRz
IGZvciBpdA0KPiB2YXJ5IGJldHdlZW4gaW1wbGVtZW50YXRpb25zLg0KPiANCj4gUmVnYXJkaW5n
IEhETUkvSERDUCBvdXRwdXQ7IGl0J3MgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSBURUUgdG8N
Cj4gZW5mb3JjZSB0aGF0LiBOb3RoaW5nIG9uIHRoZSBrZXJuZWwvdXNlcnNwYWNlIHNpZGUgbmVl
ZHMgdG8gYmUNCj4gY29uY2VybmVkIGFib3V0IGVuZm9yY2luZyBIRENQLiBUaGUgb25seSB0aGlu
ZyB1c2Vyc3BhY2UgaXMgaW52b2x2ZWQNCj4gaW4gdGhlcmUgaXMgYWN0dWFsbHkgdHVybmluZyBv
biBIRENQIHZpYSB0aGUga2VybmVsIGRyaXZlcnM7IGFuZCB0aGVuDQo+IHRoZSBURUUgZW5zdXJl
cyB0aGF0IGl0IGlzIGFjdGl2ZSBpZiB0aGUgcG9saWN5IGZvciB0aGUgZW5jcnlwdGVkDQo+IGNv
bnRlbnQgcmVxdWlyZXMgaXQuDQoNCkJ1dCBpbiBbUGF0Y2ggMDcvMTBdLA0KDQppbiBtdGtfb3Zs
X2xheWVyX2NvbmZpZygpLCB0aGUgc2VjdXJlIGlucHV0IHdvdWxkIGVuYWJsZS9kaXNhYmxlDQpk
eW5hbWljYWwgaW4ga2VybmVsLCBNZWRpYVRlayBTVlAgZG9lcyBub3QgaGlkZSBhbGwgY29udHJv
bCBpbiBURUUsIHNvDQpJIHdvcnJ5IHRoYXQgc29tZXRoaW5nIGxvc3QuIFRvIGFjaGlldmUgU1ZQ
LCBkaXNwbGF5IGhhcmR3YXJlIHNob3VsZA0KaGF2ZSBzZWN1cmUgaW5wdXQsIHNlY3VyZSBwaXBl
bGluZSwgc2VjdXJlIG91dHB1dCwgYnV0IGluIHRoaXMgc2VyaWVzLA0KSSBqdXN0IHNlZSBzZWN1
cmUgaW5wdXQuIE1heWJlIG90aGVycyBpcyBkb25lIGluIFRFRSwgdGVsbCBtZSB3aGljaA0KcGFy
dCBpcyBkb25lIGJ5IHdoaWNoIHN0ZXAuDQoNClJlZ2FyZHMsDQpDSw0KDQoNCj4gPg0KPiA+IFJl
Z2FyZHMsDQo+ID4gQ0sNCj4gPg0KPiA+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gQmFzZWQgb24gMiBz
ZXJpZXM6DQo+ID4gPiBbMV0gQWRkIENNRFEgc2VjdXJlIGRyaXZlciBmb3IgU1ZQDQo+ID4gPiAt
DQo+ID4gPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9Nzg1MzMyX187
ISFDVFJOS0E5d01nMEFSYnchbVBvY2JRd1o0LTI1RG1pZHZBZ2Q5SzVlWGpORWhTeUlLcHZ2WUhQ
cGRycTJQZ1MtaGtZeUhvaHpEdm9KeWRENDVVWnA1SnZZOUR1RFZGajFsdFZuaEdZJA0KPiA+ID4N
Cj4gPiA+DQo+ID4gPiBbMl0gZG1hLWJ1ZjogaGVhcHM6IEFkZCBNZWRpYVRlayBzZWN1cmUgaGVh
cA0KPiA+ID4gLQ0KPiA+ID4gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVz
PTc4Mjc3Nl9fOyEhQ1RSTktBOXdNZzBBUmJ3IW1Qb2NiUXdaNC0yNURtaWR2QWdkOUs1ZVhqTkVo
U3lJS3B2dllIUHBkcnEyUGdTLWhrWXlIb2h6RHZvSnlkRDQ1VVpwNUp2WTlEdURWRmoxMHNENGtI
RSQNCj4gPiA+DQo+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiBDSyBIdSAoMSk6DQo+ID4gPiAgIGRy
bS9tZWRpYXRlazogQWRkIGludGVyZmFjZSB0byBhbGxvY2F0ZSBNZWRpYVRlayBHRU0gYnVmZmVy
Lg0KPiA+ID4NCj4gPiA+IEphc29uLUpILkxpbiAoOSk6DQo+ID4gPiAgIGRybS9tZWRpYXRlay91
YXBpOiBBZGQgRFJNX01US19HRU1fQ1JFQVRFRF9FTkNSWVBUVEVEIGZsYWcNCj4gPiA+ICAgZHJt
L21lZGlhdGVrOiBBZGQgc2VjdXJlIGJ1ZmZlciBjb250cm9sIGZsb3cgdG8gbXRrX2RybV9nZW0N
Cj4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGlkZW50aWZ5IGZsYWcgYW5kIGZ1bmN1
dGlvbiB0bw0KPiA+ID4gbXRrX2RybV9wbGFuZQ0KPiA+ID4gICBkcm0vbWVkaWF0ZWs6IEFkZCBt
dGtfZGRwX3NlY193cml0ZSB0byBjb25maWcgc2VjdXJlIGJ1ZmZlcg0KPiBpbmZvDQo+ID4gPiAg
IGRybS9tZWRpYXRlazogQWRkIGdldF9zZWNfcG9ydCBpbnRlcmZhY2UgdG8gbXRrX2RkcF9jb21w
DQo+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBm
b3Igb3ZsDQo+ID4gPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3Vw
cG9ydCBmb3Igb3ZsX2FkYXB0b3INCj4gPiA+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGZs
b3cgc3VwcG9ydCB0byBtZWRpYXRlay1kcm0NCj4gPiA+ICAgYXJtNjQ6IGR0czogbXQ4MTk1LWNo
ZXJyeTogQWRkIHNlY3VyZSBtYm94IHNldHRpbmdzIGZvciB2ZG9zeXMNCj4gPiA+DQo+ID4gPiAg
Li4uL2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS1jaGVycnkuZHRzaSAgICAgIHwgIDEwICsNCj4g
PiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgfCAgIDMg
Kw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgICB8
ICAzMSArLQ0KPiA+ID4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9y
LmMgICB8ICAxNSArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jICAgICAgIHwgMjcxDQo+ID4gPiArKysrKysrKysrKysrKysrKy0NCj4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgICAgfCAgIDEgKw0KPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICB8ICAxNCArDQo+ID4g
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCAgIHwgIDEzICsN
Cj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAgfCAg
MTYgKy0NCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYyAgICAg
ICAgfCAxMjEgKysrKysrKysNCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9nZW0uaCAgICAgICAgfCAgMTYgKysNCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9wbGFuZS5jICAgICAgfCAgIDcgKw0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX3BsYW5lLmggICAgICB8ICAgMiArDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19tZHBfcmRtYS5jICAgICAgIHwgIDExICstDQo+ID4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5oICAgICAgIHwgICAyICsNCj4gPiA+ICBpbmNs
dWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5oICAgICAgICAgICAgICAgfCAgNTkgKysrKw0KPiA+
ID4gIDE2IGZpbGVzIGNoYW5nZWQsIDU3NSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkN
Cj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS91YXBpL2RybS9tZWRpYXRla19kcm0u
aA0KPiA+ID4NCj4gDQo=
