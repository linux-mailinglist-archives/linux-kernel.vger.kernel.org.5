Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB87D593B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343947AbjJXQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbjJXQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:59:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C887123
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:59:23 -0700 (PDT)
X-UUID: ac14c2d6728e11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dZp/vNssat1I/XH4H0QITUc/8Z513vop6GeyVmj2vYA=;
        b=sLof2ov/6a5TLsVJFMh24ktqnrX/2NoiogCBMteI61uYFMrR1kGoXHiZggxd32hyZPz6SL9B4bLvmQRkMmbM+rOC31DaOnrbtB4ze+ew4Jk85oUW9GWUm4BRcm6MsGbjvqb9qy+k4JyEUG1+peXHviLj+YXmR7Ycskil0DEmStQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:a7c0ccf2-1be7-4dd5-bc97-9d2510989531,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ce6344d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ac14c2d6728e11eea33bb35ae8d461a2-20231025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1441692464; Wed, 25 Oct 2023 00:59:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 00:59:17 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 00:59:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDQhQw+ULNpwV429A7g41etbdvkJLm2G5lIkmShjtbovak5C6maiQ34Rv6xi077NuKkX+ciSTYoklXfqarbVyP/aR04b3t4c/GnvU7cE+4QMcGtb2/UKmh1ipxMLYgLoIHtdlfBMFbf74ePP5RBOPbjfo+ww31HHc5e6Q3kMgYsbWFk8M489rZVMN9/kIltZdBB3OlhT67l4YtbOPfUpeGoqe+O8ryCVlo3A6tUuELTtTLgAByy7P+xybep++HeuAEdTn3LQFejIjU99fEklB8ylDP14YXCwzji/1erLt2fuupmT54ilI0CkGCcDxen6ZWnGldhDnwt30NGz7g62sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZp/vNssat1I/XH4H0QITUc/8Z513vop6GeyVmj2vYA=;
 b=d4347QfVYeZRGPnSv8M2/e5aFFLCk/zDkdEexIRbUYxNB66bfczT2bROznNe+odSbFmP2Iop4WSFgWCZ8dsqWThLBiecXLJpFpERREaHUkuu6aLIsoh4ZeQSSkYRgBXcfNGf96BoiJBmYwXCbEq47aQG0eE0VV6L1tLeeFT75ZlHwLMoevf3tiYyx2fZscDlOVQlFJwjAhVTDV/9FaAPiDH8QbR3BannYqvGaTon/8WYytSu5E2GBOdoVjU0zz1fn0HkUPQ5YlQRKadppNFEwJ0ajhezqVCOhBwO08nGUN7zNeqGQFyoZpF7f0MqFmGlPyMuwIRgYDHJ3R4YNMmDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZp/vNssat1I/XH4H0QITUc/8Z513vop6GeyVmj2vYA=;
 b=crJaOZh/uZatzYetPSXg/gO5tJD74I3Imyh3k2fH/uBLl7Zw/1PKV8eM10drSHy6UK8+YajHzt5ATlEU0Iuz7y94ELDN6bXMIx8I/tNDZuBb1/BcTcXKnPAImbPXC2JquIIVJ7xTeH2XAoBUqZ/teEcGPLw/vVvjoK5FmnEWgpc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7467.apcprd03.prod.outlook.com (2603:1096:990:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 16:59:13 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 16:59:13 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
Thread-Topic: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
Thread-Index: AQHaBWrCX17ODV7GF0K6Rv6tIltX2bBXClyAgAIhoQA=
Date:   Tue, 24 Oct 2023 16:59:13 +0000
Message-ID: <5fa0ca0bd4024a5bdb6654fc9b3900377938ed8d.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-4-jason-jh.lin@mediatek.com>
         <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
In-Reply-To: <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7467:EE_
x-ms-office365-filtering-correlation-id: b6ae5321-8da0-4951-69f6-08dbd4b28cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: py1rhogryHLFoMyqDa90lXNNdhG5aPJhn6geiPbIiBcclHMqiLbUtItjppMNYJ3hdxQr5h3P5Hkmh5CSUQa24K2VcPZ8JrdXkK7u8SYHaclTOHD4J2Sxp8yO+85RDBWsKUjIEsjpB9lRDVN63p5gQxNfRK9PPHzknaWcPeDNFmIMy0NSP5t4wzGWdOjuKp0bALDWzqPDpuSySScoInRwSRi0V4NOlB5SbHkLlSoPJ4Bm5v6qxHS5DZPWxJCU5oRg7lCPS4OWYDRB3DPOWv6bPEDZ+UAOJTMl/vqndCMF3a8Ji64KnwldDspfnI7W5ToId1haODgsTN/2cQ/VJY5HFIib40+0ZaTUti3OpDBMzua/C0WDoA53xNcG8u7vO5UJzoMSoNqDdEsXqB2NKGoCyfGGGRUTLQ2aViH7XTKBTJkLcrNKwJ+Zmz2K/0tu+97ezjLcJSNyYzjuGeYGetj/2j9qx352OQXjM6BxAfmMLJt7JtK5d8eCYkezi9sxpkt6ACboKsHGy3/SC27Nj5n3KCQWoKtIeMYq2eF+isrn2fnEe+N63XU/V3L2RFGIFfwnCHLNzhKRcIRgJem/A1e5rd8PDA3VeU+yWTpO6cPcMbn67JrlBRhhcmwhDwwXA71dQr5KlLXg59rOFDeNMjm9tQmYRN1JxlptOsfu/UlCX3E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(38070700009)(2616005)(6506007)(6512007)(53546011)(478600001)(38100700002)(122000001)(86362001)(36756003)(85182001)(6486002)(15650500001)(26005)(7416002)(71200400001)(4001150100001)(4326008)(8676002)(83380400001)(5660300002)(8936002)(54906003)(66556008)(6916009)(66946007)(76116006)(91956017)(66446008)(316002)(41300700001)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SThrRzFxMzZaUjZxNTVzM21vQmY4K2hUV0h0TFRiNEdpUGYzMmpOTHNBcU03?=
 =?utf-8?B?OXZDY29wRWRzajVRc0FONXIwMDdQU0dvYkhxYUtTVk9yMnJSWDdTQ0ZZa3lS?=
 =?utf-8?B?WUFjU2JreklRZ2JadHhqaW1yK0UyWlNJY3l4ajJFbVkxQTE1dzlKcVE5aVFR?=
 =?utf-8?B?MDNaWlltdDJucnl3ek5JYkpDMlBQbUQ1eFBvVWJ4UlBRbkxYeHdNamRJUnBO?=
 =?utf-8?B?Ni9tbXJZcDl2azhHOVVRQktzRGdoaDRka2NPQzVaNTVsaExaeUE3eDYwS0pV?=
 =?utf-8?B?UnNIczA5SlowN2cvcEZ6Vk1oVUw5TEYyek1GMlFTUW9ObGs2T2U3bHZvcWhD?=
 =?utf-8?B?ZmRQZzQwQmVKdnFRNndBOElXa051WmphNmtvODRjQ012YTBralhsVytydEpJ?=
 =?utf-8?B?OURZYlR5QTQzYXlNZ0M0RVBaZy83eG52TTRmY0hwZ2pNYjU0T091WndXd1dB?=
 =?utf-8?B?SStkT3BMYThzUkdTc2Y2ZG9ENGE2c1lua0pyQmtjQWFQY0pvTXJNYXBMRUkw?=
 =?utf-8?B?dzc3STVmeDdUQjFpbVRYb2VBNmE4ZU12MU12bWszTC9uYlcwZy8yRkhTMU4w?=
 =?utf-8?B?ZEZ2R2hvVllRSjJuZTNuRStZdjN3M0c2UVU1N1B5YWhoOXBnd0ZobVVjU3lT?=
 =?utf-8?B?OXZ3ZnpvVy8zWDBpMjEydlVCa2RmdGwyMXFZcWUzQ3luRW1ibmhHMXVyT1JR?=
 =?utf-8?B?SEhNcDFlM2srUHYwL3F5cUpISmZuWkNhMEdocnp2MGNWSFpmazI5TVY5alBQ?=
 =?utf-8?B?WXphZCtYRnV5b2hDQ3ZydVh3WGRPbTAwRzZPZEZWRDFqYjZwNDlmZDNoNm1X?=
 =?utf-8?B?UEpJMmlNZUtCb0lwTHhjZnlWWkNya3oyN3huSnI0SjgvYlNsN1NVVFVDQ0Fo?=
 =?utf-8?B?MFJrRGlLZDR6VE5uRTRBSDZHTnN0V0NmRVZWcFI4RFNrZ0c2cHVxNU04KzI3?=
 =?utf-8?B?bDJENmU1Y3FLOURmUmJ4anVvNUJXSlN3bEQ0VkZEcDEwLzRMa1I5WkRvZW90?=
 =?utf-8?B?UUQxRVV3Um42TmpPN1pBOFpxUXl0cnZnb3Z0dGE4TFJYekJ1UnRiN05QZU5V?=
 =?utf-8?B?Slh3T2w2ZDBxVHdNVEUrTmRZZk9vamcyOWVmUXN3SGpnRDMydHhydTREZG14?=
 =?utf-8?B?bHlZek41TEl6TWV5U1VtK0RPbVZBbjlEYzNoVjNCYWQzNHFwbzhGR3dQQmVm?=
 =?utf-8?B?UG1ibVBQakNjY0ttWTBubFQ0OS9EZmh6RkVVbUtGeVBzcFRBTUVBV2FybkJt?=
 =?utf-8?B?TXZMT01XTjFDK2xsQnc2Ti9EVFVkeko0N0dnRDVDTVRPUkF0dXhXaG1ZdDBi?=
 =?utf-8?B?S1RkQmZISGpvaHoyNUdYdndNU1pQSXdsTG04VHVRM3JXb2NuUVZaYVFtY2F6?=
 =?utf-8?B?SVZWci9PY0FHWWFBcmxyS2h3VUZUdEpkRURScEhxUDB5TXdhcTE3MlNFOTRo?=
 =?utf-8?B?MmE1OFNqZVVqZVllWWRYY3dtd0E0bU5KVENCN1JmajZreWNkYXRscHFPd0tJ?=
 =?utf-8?B?c2NZME5PcjlaQ2g5NFVJd0JNQ3lyQlp0MEcrbGFiMXZzNHFOSjlUd29FbVBO?=
 =?utf-8?B?dUJWK3h1TmZDbmg2Z2ZBcm51czJlRkl3RW1tY1ZweE43c1NmbFRiNUpxODg4?=
 =?utf-8?B?c3pSeVJRNTY3eHBCOHltdWYxRGJiUUxTSWQramRueFRYbzhLbGwzVkZyUWRw?=
 =?utf-8?B?UWxpQ09XKzJQNThvaERBUlNBWVdHZU5VdFRENDFJaTQ0ZWhxM1hlN0tOd0VD?=
 =?utf-8?B?RlN2YldWTmRJS0FGREdNS0JwMHd1TjdkR2g2MnptTXgwTHIwblJTaGV6cXJS?=
 =?utf-8?B?UVJ1SDQ2R3Z5OHN6cmdEbWZleU90a1ZKVll1N21HaWNNN3lQaGI5VGRmOG9H?=
 =?utf-8?B?WnZ0M3RmRHRUZVRwMjBFeGdaQlhvK2ZhcXdaV2hsZW9BcEVLY001NnZLb2w3?=
 =?utf-8?B?N0Uzd0YyVjB2ZzZxejNKQ2lQSENvbTNnb2Vaa3lpOTZiR0lTZkVPR3BmUVJV?=
 =?utf-8?B?WE9SNHhteGp2YXRPMWNBcTNnUCtmOUFVY0VkekZEWHJQRUtEN0VWWFVDMGhk?=
 =?utf-8?B?bmRrNlFxeHc2UTRVRytLUWFtbEtYS0Zlai9iNlFHSElzaUcrQndjUm53VkVR?=
 =?utf-8?B?Kzc4T3BGYUdmejVTT1Y0L01kckwzRkRLTTdlZlA1Q0QreGNnRjBiSndUUFpS?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90EB22D97737B043AF7FB7B74A968DE8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ae5321-8da0-4951-69f6-08dbd4b28cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 16:59:13.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3rXFWZPEXZzrqWWmxb6dHClhix7rMod5oK6Asgy/x2gIV7a91A0exuCF6bilgWA6tTCtyRM3BF4iLUk6iBMWeVLzOIRhQN/CxWyQoiE2RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7467
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.226300-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F6nykMun0J1wmjZ8q/Oc1nA+WzVGPiSY8gNcckEPxfz2DEU
        xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CzojsJ+zYaKNZ722hDqHosT8U1
        60P1TrZDG6zbE/IjsTv6HPbBy6Th1BwoiKXLFjYJjoaO27r+3fUjmbQR0Nyy8WltirZ/iPP5FHk
        YRmOFTHfAMlpNjRTDW4o6Y3rd6Bkiw8kFTdnBpUYdlc1JaOB1Tiyn6+JdHhc85bxeAKHFV2NAOO
        SAF0cTNnrsa5UtzJy5F723NoBoBvn5iF3J6dlPPEgwM8US/pTG5pw2tsxj4tMlgi/vLS272mtG/
        PWE2jkz3cuxjGnQlwJGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPI6T/LTDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.226300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B41DB8473A764A8D226C9281EC310DEF8810B2E17C1E2BE30FBB3CF72A708D592000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVpLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAtMjMg
YXQgMTY6MjYgKzA4MDAsIEZlaSBTaGFvIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIEphc29u
LA0KPiANCj4gT24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMTI6MznigK9QTSBKYXNvbi1KSC5MaW4g
PA0KPiBqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBjbWRx
X3BrdF9sb2dpY19jb21tYW5kIHRvIHN1cHBvcnQgbWF0Y2ggb3BlcmF0aW9uLg0KPiBzL21hdGNo
L21hdGgvDQo+IA0KSSdsbCBmaXggdGhpcyB0eXBvLiBUaGFua3MuDQoNCj4gPg0KPiA+IGNtZHFf
cGt0X2xvZ2ljX2NvbW1hbmQgY2FuIGFwcGVuZCBsb2dpYyBjb21tYW5kIHRvIHRoZSBDTURRIHBh
Y2tldCwNCj4gPiBhc2sgR0NFIHRvIGV4ZWN1dGUgYSBhcml0aGVtYXRpYyBjYWxjdWxhdGUgaW5z
dHJ1Y3Rpb24sDQo+IHMvYXJpdGhlbWF0aWMvYXJpdGhtZXRpYy8NCj4gDQpJJ2xsIGZpeCB0aGlz
IHR5cG8uIFRoYW5rcy4NCg0KPiA+IHN1Y2ggYXMgYWRkLCBzdWJ0cmFjdCwgbXVsdGlwbHksIEFO
RCwgT1IgYW5kIE5PVCwgZXRjLg0KPiA+DQo+ID4gTm90ZSB0aGF0IGFsbCBpbnN0cnVjdGlvbnMg
anVzdCBhY2NlcHQgdW5zaWduZWQgY2FsY3VsYXRlLg0KPiBzL2NhbGN1bGF0ZS9jYWxjdWxhdGlv
bi8NCj4gDQo+IA0KPiBPciBJJ2QgcmVwaHJhc2UgaXQgYXM6DQo+ICAgTm90ZSB0aGF0IGFsbCBh
cml0aG1ldGljIGluc3RydWN0aW9ucyBhcmUgdW5zaWduZWQgY2FsY3VsYXRpb25zLg0KPiANCk9L
LCBJJ2xsIHJlcGhyYXNlIGFzIHlvdXJzLiBUaGFua3MhDQoNCj4gPiBJZiB0aGVyZSBhcmUgYW55
IG92ZXJmbG93cywgR0NFIHdpbGwgc2VudCB0aGUgaW52YWxpZCBJUlEgdG8gbm90aWZ5DQo+ID4g
Q01EUSBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29u
LWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDQxDQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBi
MGNkMDcxYzQ3MTkuLjUxOTRkNjZkZmMwYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTEzLDkgKzEzLDE4IEBADQo+ID4gICNkZWZpbmUg
Q01EUV9XUklURV9FTkFCTEVfTUFTSyBCSVQoMCkNCj4gPiAgI2RlZmluZSBDTURRX1BPTExfRU5B
QkxFX01BU0sgIEJJVCgwKQ0KPiA+ICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTiAgICAgICAgICAg
ICAgICBCSVQoMCkNCj4gPiArI2RlZmluZSBDTURRX0lNTUVESUFURV9WQUxVRSAgIDANCj4gPiAg
I2RlZmluZSBDTURRX1JFR19UWVBFICAgICAgICAgIDENCj4gPiAgI2RlZmluZSBDTURRX0pVTVBf
UkVMQVRJVkUgICAgIDENCj4gPg0KPiA+ICsjZGVmaW5lIENNRFFfT1BFUkFORF9HRVRfSURYX1ZB
TFVFKG9wZXJhbmQpIFwNCj4gPiArICAgICAgICh7IFwNCj4gPiArICAgICAgICAgICAgICAgc3Ry
dWN0IGNtZHFfb3BlcmFuZCAqb3AgPSBvcGVyYW5kOyBcDQo+ID4gKyAgICAgICAgICAgICAgIG9w
LT5yZWcgPyBvcC0+aWR4IDogb3AtPnZhbHVlOyBcDQo+ID4gKyAgICAgICB9KQ0KPiBgKChvcGVy
YW5kKS0+cmVnID8gKG9wZXJhbmQpLT5pZHggOiAob3BlcmFuZCktPnZhbHVlKWAgZml0cyBpbiBv
bmUNCj4gbGluZS4NCj4gDQoNCkkgaGFkIHVzZSB0aGF0IHdheSwgYnV0IGl0IHdpbGwgZ2V0IHRo
aXMgQ0hFQ0sgd2FybmluZzoNCkNIRUNLOiBNYWNybyBhcmd1bWVudCByZXVzZSAnX3N0YXQnIC0g
cG9zc2libGUgc2lkZS1lZmZlY3RzPw0KDQpTbyBJIGNoYW5nZSB0byBjdXJyZW50IHdheS4NCg0K
PiA+ICsjZGVmaW5lIENNRFFfT1BFUkFORF9UWVBFKG9wZXJhbmQpIFwNCj4gPiArICAgICAgICgo
b3BlcmFuZCktPnJlZyA/IENNRFFfUkVHX1RZUEUgOiBDTURRX0lNTUVESUFURV9WQUxVRSkNCj4g
PiArDQo+ID4gIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPiAgICAgICAgIHVuaW9uIHsN
Cj4gPiAgICAgICAgICAgICAgICAgdTMyIHZhbHVlOw0KPiA+IEBAIC0zODAsNiArMzg5LDMzIEBA
IGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+IHU4IHN1YnN5
cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQo+ID4N
Cj4gPiAraW50IGNtZHFfcGt0X2xvZ2ljX2NvbW1hbmQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGVu
dW0NCj4gQ01EUV9MT0dJQ19FTlVNIHNfb3AsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTE2IHJlc3VsdF9yZWdfaWR4LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBjbWRxX29wZXJhbmQgKmxlZnRfb3BlcmFuZCwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgY21kcV9vcGVyYW5kICpyaWdodF9vcGVyYW5kKQ0KPiA+ICt7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArICAg
ICAgIHUzMiBsZWZ0X2lkeF92YWx1ZTsNCj4gPiArICAgICAgIHUzMiByaWdodF9pZHhfdmFsdWU7
DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFsZWZ0X29wZXJhbmQgfHwgIXJpZ2h0X29wZXJhbmQp
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArICAgICAg
IGxlZnRfaWR4X3ZhbHVlID0gQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUobGVmdF9vcGVyYW5k
KTsNCj4gPiArICAgICAgIHJpZ2h0X2lkeF92YWx1ZSA9DQo+IENNRFFfT1BFUkFORF9HRVRfSURY
X1ZBTFVFKHJpZ2h0X29wZXJhbmQpOw0KPiA+ICsgICAgICAgaW5zdC5vcCA9IENNRFFfQ09ERV9M
T0dJQzsNCj4gPiArICAgICAgIGluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiA+ICsgICAg
ICAgaW5zdC5zcmNfdCA9IENNRFFfT1BFUkFORF9UWVBFKGxlZnRfb3BlcmFuZCk7DQo+ID4gKyAg
ICAgICBpbnN0LmFyZ19jX3QgPSBDTURRX09QRVJBTkRfVFlQRShyaWdodF9vcGVyYW5kKTsNCj4g
PiArICAgICAgIGluc3Quc29wID0gc19vcDsNCj4gPiArICAgICAgIGluc3QuYXJnX2MgPSByaWdo
dF9pZHhfdmFsdWU7DQo+ID4gKyAgICAgICBpbnN0LnNyY19yZWcgPSBsZWZ0X2lkeF92YWx1ZTsN
Cj4gPiArICAgICAgIGluc3QucmVnX2RzdCA9IHJlc3VsdF9yZWdfaWR4Ow0KPiA+ICsNCj4gPiAr
ICAgICAgIHJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICt9
DQo+ID4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfbG9naWNfY29tbWFuZCk7DQo+ID4gKw0KPiA+
ICBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwg
dTMyIHZhbHVlKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBp
bnN0ID0ge307DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCj4gYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4g
aW5kZXggYTI1M2MwMDFjODYxLi5lYTRmYWRmYjU0NDMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAtMjYsNiArMjYsMzAgQEANCj4gPg0KPiA+
ICBzdHJ1Y3QgY21kcV9wa3Q7DQo+ID4NCj4gPiArZW51bSBDTURRX0xPR0lDX0VOVU0gew0KPiBV
c2UgbG93ZXIgY2FzZSwgYW5kIHBlcmhhcHMgdXNlIGBjbWRxX2xvZ2ljX3R5cGVgIG9yDQo+IGBj
bWRxX29wZXJhdG9yX3R5cGVgLg0KPiANClRoYW5rcyEgSSB0aGluayBJIHdvdWxkIGNoYW5nZSB0
byBgY21kcV9sb2dpY19vcGAuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRz
LA0KPiBGZWkNCg==
