Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1E7D28F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjJWDQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWDQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:16:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE38AD;
        Sun, 22 Oct 2023 20:16:19 -0700 (PDT)
X-UUID: 87c28180715211eea33bb35ae8d461a2-20231023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mcys5al9eymjZkVx8JHmRNFEViSTle9xClElvwN/YNg=;
        b=pl6vPqPIqFYEbHEnTE+wf3xVVj9xvL0ZOVfsqpkahWg7quUeDaQT6O5yD6S0L0/S079iPHER5DJw2Di21PtApI//K+zQoJ9UkOpMCxCW/9Cq5CUX2FQaW1NP53OXQd0LdRB0P4DGqF27IX21oUdoegBM/zpJ05WmOzIFPOq7F40=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:80b6b8a0-f713-4bab-bfeb-3d6e5bc902b0,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:840e8194-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 87c28180715211eea33bb35ae8d461a2-20231023
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 537081876; Mon, 23 Oct 2023 11:16:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Oct 2023 11:16:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Oct 2023 11:16:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG0sKwwFe/kddopr7wCEifTXCSVBgl10CPICtPWNzHuUMfk2ohMoMKhktfppg0G/sZVk8IVOWVuG3msnbH0RMR8i/OvAlUqOiDw+ZEr3X2EvNGf8/NqWKOdgoTCsH/i0aFV9+pdbyiEOd+jFR4vs6Z+2HWDGv5jfZY9UuI7DxGwq5RAJA+nyT/DSyn6kp0FlXHX3tTleNr02LnpKXtlDlmp7Oham24ItC5W0Pri1oY0jJnlpyM/ztWzWYXpEHS0Y69nIq1PTgIlQO3El+8LELxUHcOs9SOIIISVnuotj4TXzduS9dytETRPLXzyvtj8EyIECVRMNdlzotdoE6k2fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcys5al9eymjZkVx8JHmRNFEViSTle9xClElvwN/YNg=;
 b=ZmwyGqDXNjFCHLFCIuhR1u0NE+eQLfYllOTiidp1xHYRtEVEf22JjMZMZ67FL6LdJljZeg1e2uTGtANu/8jzDskMm7EFtGp0DxfRxkNLeD3yj7zxvfRgxQJNKLHcY8y9IciqUI4zxqs1cocEG+72dTx//hfPp0HeYoi3llTp5JRHDmDF30IcAjyTbedxVm4X1i34ljJj/IiFod6NoVJU6sSBHwBryWSP0xV23LsmJwYLuReDcjXQoVL7IhgeYiBGLFZjaYCqdI6gScM6dY+b3PTFYeSwY6FQM6GPABHVzUfRzoo5kgEEEBFXHaKZv2CtRKr9CeQbZbuVcRK47rIqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcys5al9eymjZkVx8JHmRNFEViSTle9xClElvwN/YNg=;
 b=lVS2HGzQr0Zd1Is9lpZEpmoAd6oRaGOJ9xpD0dOX0pUHxiFq9Ajqxx8EG9HsGXF0hExd3kwuzEaL5NKXV3xB9Bsv40+rFGZTIndKjeZX97ywUpwDBibSf+Q5HJbbeUpKSWayhCPiCdAvyafOqLIpnPk7od2Quc5404dpGFdJp7M=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYSPR03MB7425.apcprd03.prod.outlook.com (2603:1096:400:415::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 03:15:13 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::f213:3be4:9d6d:dda8]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::f213:3be4:9d6d:dda8%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 03:15:13 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 1/7] media: mediatek: vcodec: Getting the chip name of
 each platform
Thread-Topic: [PATCH 1/7] media: mediatek: vcodec: Getting the chip name of
 each platform
Thread-Index: AQHaA/jQ6UiPKaC1WEC+JaaFLKF6AbBWtlKA
Date:   Mon, 23 Oct 2023 03:15:12 +0000
Message-ID: <b4b7463e72f20480fbdcc5b90a4036d8c39835d9.camel@mediatek.com>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
         <20231021083015.ivxvmrm7fq5pofdp@basti-XPS-13-9310>
In-Reply-To: <20231021083015.ivxvmrm7fq5pofdp@basti-XPS-13-9310>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYSPR03MB7425:EE_
x-ms-office365-filtering-correlation-id: 7590feda-7bb0-4f63-c749-08dbd3764542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovAI/BY4/9BDcOIcR+lQQIouGveTsep7hi4PApib1vh6+PdTqPMMPTeE6pog+ILEUS8t7G4xKBh9dPcJT13tZRpS8RDr5ip5d2lPjNPyqdK/1VK7gelaeY471WG2zYrUF80tVEG/fGBDHqpZ4OTaYd112tgfrs6N58aM2A/xLDwtqp2GPe5XxjxTUUQczLTvo2t3rBJkHXktzDlC3vxTLNa4kL4C8cdtMn+8RPJYi78gyuhwXlZyjLa4l3ZLz/qQmHiW8EHKBMMBBswrqfSxa96iUHJl9/OuY0WLkqTiwl8qG5j+icVAMcWfssvCmzry2DJp3WQ1qLUItBZnyqa29c8BQPbGqRDDsYZ9TpXgK5x3CrY8A8oZT9MvCM2YUS1xhF6kbCWq6lUrn9c26fsZ3KAFh3COuS9ovV+dl0I1DWjBB/4osfew9QXep+pwnvLW4CrUhyd4TXVvd32Mscl1NnrjFmIPVprgeLuDG4krjtrKhQn8CZIins5z8GkfsXYWyZp7ibYlYQGh3jDdhI4IYVLL/S1i8ZvIjJpSiLuzidf9S1nOMSMmQF0t06GPD2tqhotbJHSxmA6N+e9MGMYpcnVvI9s6FBWu+J6Il2Ajiu/zWTU8JuPfSUxbsXZ+2IQWc/jmyeyHapyDmt7ZI/ruTHEytep/vLkfAFyCCRygXdvg3xlew4eQ04IicJO6+FmT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700009)(36756003)(85182001)(4001150100001)(71200400001)(38100700002)(83380400001)(122000001)(5660300002)(86362001)(478600001)(91956017)(26005)(2616005)(7416002)(6486002)(316002)(6512007)(6916009)(66946007)(66476007)(6506007)(66446008)(54906003)(76116006)(2906002)(66556008)(41300700001)(53546011)(8936002)(64756008)(4326008)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFI5amNhVGlsN2oyTlZjdHpuc3pJdXJqZ2ZXM0twTFZqOUpvdTBEalgzT2lK?=
 =?utf-8?B?OWhoUHRVUXFPN3JIbGl1MllQWW9aaURSUS8rMDlEdWNreFpxQnMxRVJMSFVV?=
 =?utf-8?B?VzFwM3pqVzFlOHpMd01CNDMvcGVRRWRQTFhSZGZsdjhjakFUTExEcWY5UFVE?=
 =?utf-8?B?MHFzN2lUYjRmY3UvMlBScW14eTZHeXhDTnp5eGpVVlMvSEFBSHMwcnVrSUJy?=
 =?utf-8?B?UVJEakxSdU9MY1lCSnVqdFN5SmFTdWtDUCtuQXVxSXlLVnNYdGl0S0ZXd0Ri?=
 =?utf-8?B?RWlLNWlVaEhSWGsxbEtKeGhvS2c5b25hakJtY3dBeEZ2UDlGSkhTRGNDOWQ0?=
 =?utf-8?B?VUtudWttVEozNEMxYVNGWkJpb20rZ1FPSytLUVc3SndrZWZUdUVEOXpOS0pQ?=
 =?utf-8?B?WVZncVl2UytyMGFQRkRtRmdsSGRSRzNqQzBLMjJyWjFnemlCc0RyL3hzRmtv?=
 =?utf-8?B?TVplZUgzZS9KbEc3WEdTcW9GTlRkTjM5UTlwK2sxT0dkRElyQ3IvNzl4eG5O?=
 =?utf-8?B?SXIvTFpBYWsreTlDSlg4UTYrTTB5VEd2NE5QcTdmdWpmWHkvQWczME5SVWxt?=
 =?utf-8?B?dVBPVFIrZi8vSGRNa0M1N2Q1SWV1RWZFSEJaSUhPNHkvQmgvbWJtWXVXRlQ5?=
 =?utf-8?B?UDgxbUtrLzZjb3RyVlBpR1VKR0hjS3RkZjY2WXFSYmFFdzNDcy9hN003ZjB0?=
 =?utf-8?B?VjlsMm0yRHl3dndKb0ZGV2pDL09qNHkyY3Z3eDI1Mlh4bkFycTVmM29UOVJV?=
 =?utf-8?B?MjJLY3A4cEoyVWlPTVR4WDJ5SERFMkptVVVoZlkwd3FYQzhqaDRPWTJlM1RO?=
 =?utf-8?B?WTd5ZHhQWklYNDRQdy9Ed3MzQWlBUFFqQ3F5ckhJUkQ1ZnQzL0NTQXEwQXVH?=
 =?utf-8?B?TnhjQTNjYUtRYXZYY0tIeHJWV3JYY296QVJMUStWNHVOajVpRHFyb0l3Z3U4?=
 =?utf-8?B?WUZzN281Uk53cWZyLytkVDI5MlQycStFaUd2VjVhYWZmczBUNFFoUnMvUDky?=
 =?utf-8?B?OWg3SGZjNHdiWk9wQ282alRUaWR1RGhnRm82MVp6UjROZWxXdWtuZTgwZStR?=
 =?utf-8?B?dXNRVjZDQzN5SHU1RE9MS1JEbXBmQUp6VUpiL0hjVFpwZ0VLcVU4WG1aZGhX?=
 =?utf-8?B?MG4wVzVyVkdwdGZ0ZmphNjZNekFlNVMxQ2g3enlLVlQyNFBYYSs0TTVuUFlt?=
 =?utf-8?B?ZU1XemtiYjZsWm5CbWdGczJBZ2hzQTJwZElIVUMwMmF6TzRycnlIaTVScEQr?=
 =?utf-8?B?bDRSWVBxWllYUTFuRENjekxtNVdTNjVUTlFpUjFTREQ0Nnc1alljMWxvRC9F?=
 =?utf-8?B?VTE3bjFQelhQWnAxbHN1Sy9xd05Gei9ycVdIdWtYYW5hSm9wTTltQU5HTmtn?=
 =?utf-8?B?ZHJUV2RjZEgyNmowQTNmSUpvS3djMWhka0NveGZRaTRZQjVpYnZlbWZ0Nm9F?=
 =?utf-8?B?QURmbDdYclZzZTB1NWJmOUJrVVRXaDFMZktFQVl6OGxZWm1lZ3lFT0R1Z3Iy?=
 =?utf-8?B?ckRRanB6OTZqQ2tXTElzbGVWYlRaZ1A3Z2RBS0FITG1YOG1lTENBckJZeVAz?=
 =?utf-8?B?WjMzcXVXZlhDUzJ2aFl1cU1FVkw0eFV4em9HamVGaFc5N2EwcmovS3VPeUZs?=
 =?utf-8?B?U3pzRnFoUGxFRWFJMzNDSXhUTUtOalFoT3hSTVFBMTVnZ0RLa2JNbzNCdHRO?=
 =?utf-8?B?QllTUmlDVEhaTlA2c3lTUHRXb2VVZTIyUG1OWEJXSzQxODNzQ3h6d2JWOTEy?=
 =?utf-8?B?U0pnZk5QdUVjTExXekJxQW1RVVhYVi90cUdKY3d6eEMzRGs3RjkxdE9mY3NE?=
 =?utf-8?B?SXgrSm1vZDJCd3RPVTEvYk84bC9xT2FRdC8rNmY5M01OeTBraGIrS2hDUmlu?=
 =?utf-8?B?SEg0WFROZERnRDRUNERGY3JzT21xTFpTWDg1NGM1YTRXZWtzNkc2N1cxLzla?=
 =?utf-8?B?c21kOGZwZjI5UUUzV0VKOGFPZHFtWEhHaEhWZklncWEybEZ5V293VEVydEtB?=
 =?utf-8?B?bnJaMmdOVkxZSDlSQ1pMSklRenU1NHAwTFFoK3NTSmVvUlRWS1pOVFIwd2NH?=
 =?utf-8?B?UEphSWJKbkMydnQwcHVVWmhqNm5Db0VjT0ljL3I1RmJ5NXFnMnhPQ1hHUWg2?=
 =?utf-8?B?cUpQMnl5czZUVndXbEJ0bm5NSGtWNWQvK0taNGlxU0w1bjFTd3FzTnN2M3Zk?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B74952DED837374B89B052C41C605488@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7590feda-7bb0-4f63-c749-08dbd3764542
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 03:15:12.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IPLmTvhb6AiHjn1qjDDsHAN1PQ0taWYlcU5o1j2f8HV2trJYaadaxQ92KHpJhzqP7mMECYYkS2WPvBDnUCmZw0WXX0tunBJhn1gCVFGC68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7425
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ViYXN0aWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLg0KDQpTZW5kIHRoZSBwYXRj
aCB2MiB0byBmaXggdGhlIGJlbG93IGl0ZW1zOg0KDQpGaXggdGhlIGNvbW1pdCBtZXNzYWdlIGZv
ciBzb21lIHBhdGNoZXMuDQpGaXggdGhlIGxldmVsIG9mIG10ODE5NSBhbmQgbXQ4MTkyLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KT24gU2F0LCAyMDIzLTEwLTIxIGF0IDEwOjMwICsw
MjAwLCBTZWJhc3RpYW4gRnJpY2tlIHdyb3RlOg0KPiBIZXkgWXVuZmVpLA0KPiANCj4gVGhhbmtz
IGZvciB5b3VyIHBhdGNoZXMhDQo+IA0KPiBDb3VsZCB5b3UgcHJvdmlkZSBhIGNvdmVyLWxldHRl
ciBmb3IgdGhlIG5leHQgdmVyc2lvbiBwbGVhc2U/DQo+IFRoaXMgd2lsbCBoZWxwIHRvIGdldCBh
IGdvb2QgY29udGV4dCBvZiB3aHkgd2UgbmVlZCB0aGVzZSBjaGFuZ2VzIGFuZA0KPiB0bw0KPiBz
dG9yZSB0aGUgY2hhbmdlbG9nIGluIGEgaGVscGZ1bCBtYW5uZXIuDQo+IFRoYW5rcy4NCj4gDQo+
IE9uIDE2LjEwLjIwMjMgMTQ6NDMsIFl1bmZlaSBEb25nIHdyb3RlOg0KPiA+IEdldHRpbmcgdGhl
IGNoaXAgbmFtZSBvZiBlYWNoIHBsYXRmb3JtIGFjY29yZGluZyB0byB0aGUgZGV2aWNlDQo+ID4g
Y29tcGF0aWJsZSB0byBzZXQgZGlmZmVyZW50IHBhcmFtZXRlci4NCj4gDQo+IEkgd291bGQgcmV3
b3JkIHRoaXMgY29tbWl0IGRlc2NyaXB0aW9uIHNsaWdodGx5LCBiYXNpY2FsbHkgd2hhdCB5b3UN
Cj4gY2hhbmdlIGlzIHRoYXQgeW91IHN0b3JlIHRoZSBjaGlwIG5hbWUgaW4gY29udGV4dCBwZXJt
YW5lbnRseSBhbmQNCj4gdGhhdA0KPiB5b3UgdXRpbGl6ZSBhIGVudW0gdG8gYmUgbW9yZSBkZXNj
cmlwdGl2ZS4NCj4gDQo+IFNvIGhvdyBhYm91dDoNCj4gDQo+ICIiIg0KPiBTdG9yZSB0aGUgbmFt
ZSBvZiB0aGUgY2hpcCBpbiB0aGUgY29udGV4dCBvZiB0aGUgZHJpdmVyIGluIG9yZGVyIHRvDQo+
IGJlDQo+IGFibGUgdG8gY2hvb3NlIHRoZSBjb3JyZWN0IGNvbmZpZ3VyYXRpb24gdmFsdWVzIGZv
ciB0aGUgZGlmZmVyZW50DQo+IGNvZGVjcy4NCj4gVXNlIGEgZW51bSB2YWx1ZSBpbnN0ZWFkIG9m
IGFuIGludGVnZXIgdG8gc3RvcmUgYSBtb3JlIGRlc2NyaXB0aXZlDQo+IG5hbWUuDQo+ICIiIg0K
PiANCj4gQSBmZXcgbW9yZSBjb21tZW50cyBiZWxvdy4NCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAuLi4vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWMuYyAgfCAyNCArLS0t
LS0tLS0tLS0tLS0tDQo+ID4gLQ0KPiA+IC4uLi92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2Rl
Y19kcnYuYyAgICAgICB8IDI2DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+IC4uLi92Y29k
ZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYuaCAgICAgICB8IDE3ICsrKysrKysrKysrKw0K
PiA+IDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjLmMNCj4gPiBpbmRl
eCA5MWVkNTc2ZDY4MjEuLmJhNzQyZjBlMzkxZCAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWMu
Yw0KPiA+ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
ZGVjb2Rlci9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gQEAgLTIwOCwzNiArMjA4LDE0IEBAIHN0YXRp
YyBpbnQgdmlkaW9jX3ZkZWNfZHFidWYoc3RydWN0IGZpbGUNCj4gPiAqZmlsZSwgdm9pZCAqcHJp
diwNCj4gPiAJcmV0dXJuIHY0bDJfbTJtX2RxYnVmKGZpbGUsIGN0eC0+bTJtX2N0eCwgYnVmKTsN
Cj4gPiB9DQo+ID4gDQo+ID4gLXN0YXRpYyBpbnQgbXRrX3Zjb2RlY19kZWNfZ2V0X2NoaXBfbmFt
ZSh2b2lkICpwcml2KQ0KPiA+IC17DQo+ID4gLQlzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfY3R4ICpj
dHggPSBmaF90b19kZWNfY3R4KHByaXYpOw0KPiA+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gJmN0
eC0+ZGV2LT5wbGF0X2Rldi0+ZGV2Ow0KPiA+IC0NCj4gPiAtCWlmIChvZl9kZXZpY2VfaXNfY29t
cGF0aWJsZShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxtdDgxNzMtDQo+ID4gdmNvZGVjLWRlYyIp
KQ0KPiA+IC0JCXJldHVybiA4MTczOw0KPiA+IC0JZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBh
dGlibGUoZGV2LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgxODMtdmNvZGVjLWRlYyIpKQ0K
PiA+IC0JCXJldHVybiA4MTgzOw0KPiA+IC0JZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUoZGV2LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgxOTItdmNvZGVjLWRlYyIpKQ0KPiA+
IC0JCXJldHVybiA4MTkyOw0KPiA+IC0JZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUo
ZGV2LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgxOTUtdmNvZGVjLWRlYyIpKQ0KPiA+IC0J
CXJldHVybiA4MTk1Ow0KPiA+IC0JZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2
LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgxODYtdmNvZGVjLWRlYyIpKQ0KPiA+IC0JCXJl
dHVybiA4MTg2Ow0KPiA+IC0JZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5v
Zl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgxODgtdmNvZGVjLWRlYyIpKQ0KPiA+IC0JCXJldHVy
biA4MTg4Ow0KPiA+IC0JZWxzZQ0KPiA+IC0JCXJldHVybiA4MTczOw0KPiA+IC19DQo+ID4gLQ0K
PiA+IHN0YXRpYyBpbnQgdmlkaW9jX3ZkZWNfcXVlcnljYXAoc3RydWN0IGZpbGUgKmZpbGUsIHZv
aWQgKnByaXYsDQo+ID4gCQkJCXN0cnVjdCB2NGwyX2NhcGFiaWxpdHkgKmNhcCkNCj4gPiB7DQo+
ID4gCXN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggKmN0eCA9IGZoX3RvX2RlY19jdHgocHJpdik7
DQo+ID4gCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZjdHgtPmRldi0+cGxhdF9kZXYtPmRldjsNCj4g
PiAtCWludCBwbGF0Zm9ybV9uYW1lID0gbXRrX3Zjb2RlY19kZWNfZ2V0X2NoaXBfbmFtZShwcml2
KTsNCj4gPiANCj4gPiAJc3Ryc2NweShjYXAtPmRyaXZlciwgZGV2LT5kcml2ZXItPm5hbWUsIHNp
emVvZihjYXAtPmRyaXZlcikpOw0KPiA+IC0Jc25wcmludGYoY2FwLT5jYXJkLCBzaXplb2YoY2Fw
LT5jYXJkKSwgIk1UJWQgdmlkZW8gZGVjb2RlciIsDQo+ID4gcGxhdGZvcm1fbmFtZSk7DQo+ID4g
KwlzbnByaW50ZihjYXAtPmNhcmQsIHNpemVvZihjYXAtPmNhcmQpLCAiTVQlZCB2aWRlbyBkZWNv
ZGVyIiwNCj4gPiBjdHgtPmRldi0+Y2hpcF9uYW1lKTsNCj4gPiANCj4gPiAJcmV0dXJuIDA7DQo+
ID4gfQ0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmMNCj4gPiBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNf
ZHJ2DQo+ID4gLmMNCj4gPiBpbmRleCAwYTg5Y2U0NTJhYzMuLmY0N2M5OGZhZjA2OCAxMDA2NDQN
Cj4gPiAtLS0NCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2Rl
Y29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2DQo+ID4gLmMNCj4gPiArKysNCj4gPiBiL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2
DQo+ID4gLmMNCj4gPiBAQCAtMzI2LDYgKzMyNiwyNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHY0
bDJfZmlsZV9vcGVyYXRpb25zDQo+ID4gbXRrX3Zjb2RlY19mb3BzID0gew0KPiA+IAkubW1hcAkJ
PSB2NGwyX20ybV9mb3BfbW1hcCwNCj4gPiB9Ow0KPiA+IA0KPiA+ICtzdGF0aWMgdm9pZCBtdGtf
dmNvZGVjX2RlY19nZXRfY2hpcF9uYW1lKHN0cnVjdCBtdGtfdmNvZGVjX2RlY19kZXYNCj4gPiAq
dmRlY19kZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZ2ZGVjX2Rldi0+
cGxhdF9kZXYtPmRldjsNCj4gPiArDQo+ID4gKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUo
ZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbXQ4MTczLQ0KPiA+IHZjb2RlYy1kZWMiKSkNCj4gPiAr
CQl2ZGVjX2Rldi0+Y2hpcF9uYW1lID0gTVRLX1ZERUNfTVQ4MTczOw0KPiA+ICsJZWxzZSBpZiAo
b2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRlayxtdDgx
ODMtdmNvZGVjLWRlYyIpKQ0KPiA+ICsJCXZkZWNfZGV2LT5jaGlwX25hbWUgPSBNVEtfVkRFQ19N
VDgxODM7DQo+ID4gKwllbHNlIGlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShkZXYtPm9mX25v
ZGUsDQo+ID4gIm1lZGlhdGVrLG10ODE5Mi12Y29kZWMtZGVjIikpDQo+ID4gKwkJdmRlY19kZXYt
PmNoaXBfbmFtZSA9IE1US19WREVDX01UODE5MjsNCj4gPiArCWVsc2UgaWYgKG9mX2RldmljZV9p
c19jb21wYXRpYmxlKGRldi0+b2Zfbm9kZSwNCj4gPiAibWVkaWF0ZWssbXQ4MTk1LXZjb2RlYy1k
ZWMiKSkNCj4gPiArCQl2ZGVjX2Rldi0+Y2hpcF9uYW1lID0gTVRLX1ZERUNfTVQ4MTk1Ow0KPiA+
ICsJZWxzZSBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLA0KPiA+ICJt
ZWRpYXRlayxtdDgxODYtdmNvZGVjLWRlYyIpKQ0KPiA+ICsJCXZkZWNfZGV2LT5jaGlwX25hbWUg
PSBNVEtfVkRFQ19NVDgxODY7DQo+ID4gKwllbHNlIGlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJs
ZShkZXYtPm9mX25vZGUsDQo+ID4gIm1lZGlhdGVrLG10ODE4OC12Y29kZWMtZGVjIikpDQo+ID4g
KwkJdmRlY19kZXYtPmNoaXBfbmFtZSA9IE1US19WREVDX01UODE4ODsNCj4gPiArCWVsc2UNCj4g
PiArCQl2ZGVjX2Rldi0+Y2hpcF9uYW1lID0gTVRLX1ZERUNfSU5WQUw7DQo+ID4gK30NCj4gPiAr
DQo+ID4gc3RhdGljIGludCBtdGtfdmNvZGVjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gew0KPiA+IAlzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfZGV2ICpkZXY7DQo+ID4g
QEAgLTM0MSw2ICszNjEsMTIgQEAgc3RhdGljIGludCBtdGtfdmNvZGVjX3Byb2JlKHN0cnVjdA0K
PiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAJSU5JVF9MSVNUX0hFQUQoJmRldi0+Y3R4
X2xpc3QpOw0KPiA+IAlkZXYtPnBsYXRfZGV2ID0gcGRldjsNCj4gPiANCj4gPiArCW10a192Y29k
ZWNfZGVjX2dldF9jaGlwX25hbWUoZGV2KTsNCj4gPiArCWlmIChkZXYtPmNoaXBfbmFtZSA9PSBN
VEtfVkRFQ19JTlZBTCkgew0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byBn
ZXQgZGVjb2RlciBjaGlwIG5hbWUiKTsNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gCWRldi0+dmRlY19wZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgm
cGRldi0+ZGV2KTsNCj4gPiAJaWYgKCFvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zf
bm9kZSwgIm1lZGlhdGVrLHZwdSIsDQo+ID4gCQkJCSAgJnJwcm9jX3BoYW5kbGUpKSB7DQo+ID4g
ZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
ZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYNCj4gPiAuaA0KPiA+IGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYNCj4gPiAu
aA0KPiA+IGluZGV4IDdlMzZiMmM2OWI3ZC4uOGYyMjhiYTlhYTQ3IDEwMDY0NA0KPiA+IC0tLQ0K
PiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtf
dmNvZGVjX2RlY19kcnYNCj4gPiAuaA0KPiA+ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYNCj4gPiAuaA0K
PiA+IEBAIC0xOCw2ICsxOCwxOSBAQA0KPiA+ICNkZWZpbmUgSVNfVkRFQ19MQVRfQVJDSChod19h
cmNoKSAoKGh3X2FyY2gpID49DQo+ID4gTVRLX1ZERUNfTEFUX1NJTkdMRV9DT1JFKQ0KPiA+ICNk
ZWZpbmUgSVNfVkRFQ19JTk5FUl9SQUNJTkcoY2FwYWJpbGl0eSkgKChjYXBhYmlsaXR5KSAmDQo+
ID4gTVRLX1ZDT0RFQ19JTk5FUl9SQUNJTkcpDQo+ID4gDQo+ID4gKy8qDQo+ID4gKyAqIGVudW0g
bXRrX3Zjb2RlY19kZWNfY2hpcF9uYW1lIC0gU3RydWN0dXJlIHVzZWQgdG8gc2VwYXJhdGUNCj4g
PiBkaWZmZXJlbnQgcGxhdGZvcm0NCj4gPiArICovDQo+IA0KPiBJIGRvbid0IGZlZWwgbGlrZSB0
aGlzIGNvbW1lbnQgaXMgdGVycmlibHkgaGVscGZ1bCBiZWNhdXNlIGl0IGlzDQo+IHByZXR0eQ0K
PiBjbGVhciB3aGF0IHRoZSBlbnVtIGlzIGFib3V0LCBJIHdvdWxkIGp1c3QgZHJvcCBpdC4NCj4g
DQo+ID4gK2VudW0gbXRrX3Zjb2RlY19kZWNfY2hpcF9uYW1lIHsNCj4gPiArCU1US19WREVDX0lO
VkFMID0gMCwNCj4gPiArCU1US19WREVDX01UODE3MyA9IDgxNzMsDQo+ID4gKwlNVEtfVkRFQ19N
VDgxODMgPSA4MTgzLA0KPiA+ICsJTVRLX1ZERUNfTVQ4MTg2ID0gODE4NiwNCj4gPiArCU1US19W
REVDX01UODE4OCA9IDgxODgsDQo+ID4gKwlNVEtfVkRFQ19NVDgxOTIgPSA4MTkyLA0KPiA+ICsJ
TVRLX1ZERUNfTVQ4MTk1ID0gODE5NSwNCj4gPiArfTsNCj4gPiArDQo+ID4gLyoNCj4gPiAgKiBl
bnVtIG10a192ZGVjX2Zvcm1hdF90eXBlcyAtIFN0cnVjdHVyZSB1c2VkIHRvIGdldCBzdXBwb3J0
ZWQNCj4gPiAgKgkJICBmb3JtYXQgdHlwZXMgYWNjb3JkaW5nIHRvIGRlY29kZXIgY2FwYWJpbGl0
eQ0KPiA+IEBAIC0yNDksNiArMjYyLDggQEAgc3RydWN0IG10a192Y29kZWNfZGVjX2N0eCB7DQo+
ID4gICogQHZkZWNfcmFjaW5nX2luZm86IHJlY29yZCByZWdpc3RlciB2YWx1ZQ0KPiA+ICAqIEBk
ZWNfcmFjaW5nX2luZm9fbXV0ZXg6IG11dGV4IGxvY2sgdXNlZCBmb3IgaW5uZXIgcmFjaW5nIG1v
ZGUNCj4gPiAgKiBAZGJnZnM6IGRlYnVnIGxvZyByZWxhdGVkIGluZm9ybWF0aW9uDQo+ID4gKyAq
DQo+ID4gKyAqIEBjaGlwX25hbWU6IHRoZSBjaGlwIG5hbWUgdXNlZCB0byBzZXBhcmF0ZSBkaWZm
ZXJlbnQgcGxhdGZvcm0NCj4gDQo+IEkgd291bGRuJ3QgcmVwZWF0IGNoaXAgbmFtZSBpbiB0aGUg
ZGVzY3JpcHRpb24gYW5kIHNwZWNpZnkgbW9yZQ0KPiBjb25jcmV0ZWx5IHdoeSB3ZSBuZWVkIHRv
IHNlcGFyYXRlIHRoZSBwbGF0Zm9ybXMuDQo+IA0KPiBNeSBzdWdnZXN0aW9uOg0KPiANCj4gICAq
IEBjaGlwX25hbWU6IHVzZWQgdG8gZGlzdGluZ3Vpc2ggcGxhdGZvcm1zIGFuZCBzZWxlY3QgdGhl
IGNvcnJlY3QNCj4gY29kZWMgY29uZmlndXJhdGlvbiB2YWx1ZXMuDQo+IA0KPiA+ICAqLw0KPiA+
IHN0cnVjdCBtdGtfdmNvZGVjX2RlY19kZXYgew0KPiA+IAlzdHJ1Y3QgdjRsMl9kZXZpY2UgdjRs
Ml9kZXY7DQo+ID4gQEAgLTI4OSw2ICszMDQsOCBAQCBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfZGV2
IHsNCj4gPiAJLyogUHJvdGVjdHMgYWNjZXNzIHRvIHZkZWNfcmFjaW5nX2luZm8gZGF0YSAqLw0K
PiA+IAlzdHJ1Y3QgbXV0ZXggZGVjX3JhY2luZ19pbmZvX211dGV4Ow0KPiA+IAlzdHJ1Y3QgbXRr
X3Zjb2RlY19kYmdmcyBkYmdmczsNCj4gPiArDQo+ID4gKwllbnVtIG10a192Y29kZWNfZGVjX2No
aXBfbmFtZSBjaGlwX25hbWU7DQo+ID4gfTsNCj4gPiANCj4gPiBzdGF0aWMgaW5saW5lIHN0cnVj
dCBtdGtfdmNvZGVjX2RlY19jdHggKmZoX3RvX2RlY19jdHgoc3RydWN0DQo+ID4gdjRsMl9maCAq
ZmgpDQo+IA0KPiBCZXNpZGVzIHRob3NlIHNtYWxsIHdvcmRpbmcgY2hvaWNlcywgdGhlIHBhdGNo
IGxvb2tzIGdvb2QuDQo+IA0KPiBTbyB3aXRoIHRoZXNlIGlzc3VlcyByZXNvbHZlZDoNCj4gDQo+
IFJldmlld2VkLWJ5OiBTZWJhc3RpYW4gRnJpY2tlIDxzZWJhc3RpYW4uZnJpY2tlQGNvbGxhYm9y
YS5jb20+DQo+IA0KPiBSZWdhcmRzLA0KPiBTZWJhc3RpYW4NCj4gPiAtLSANCj4gPiAyLjE4LjAN
Cj4gPiANCg==
