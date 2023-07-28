Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681247669FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjG1KOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbjG1KNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:13:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FA3AB6;
        Fri, 28 Jul 2023 03:13:37 -0700 (PDT)
X-UUID: 68757e482d2f11ee9cb5633481061a41-20230728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=dKgZxu14XzQlIccuyHeOOYjQUTNSQ66Xw+m83Vva9iI=;
        b=A8eZZG0IKRmL89HmwOjX+xa5GcdEXeONepIsqQLZ5CbNbaXDaLm5WiTSW+T8O1Y4G0McCeLbKFO33p2PZB7KfUD0XUKL39AAoIn7nVthRqS64rQXZRAC2N74UyHZyZ8FUSI/KuLpmp5fdCchuqkqCCCBK/5SwWy8R8DRYY1Uw0A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:d7c0adc0-396a-44b0-958d-fddc4aac9c3d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.30,REQID:d7c0adc0-396a-44b0-958d-fddc4aac9c3d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:1fcc6f8,CLOUDID:24cea2a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:23072817381725JD5BJX,BulkQuantity:32,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: 68757e482d2f11ee9cb5633481061a41-20230728
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1385289885; Fri, 28 Jul 2023 18:13:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jul 2023 18:13:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jul 2023 18:13:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnoO09nbn7vyDfrY/jBy/uOs+b6k+2Qqhpi+u5fc/H84WzxIB8POvs3l1dDcrDU0E6q4Y/ydfSgpvGsuDXikJY0V5WzED7KWScFwFZ9zFL8fyfPrzrkBTAS6wrAl1a2V3KXrlVtg7kklx9jzDilWEn7eZ8lUs2rUhdMSeW2k7HSSvFXzVYGP3GkXTIgL0T9WV+aM+XN8N33Q4WUMgKjpBoBNJDVwe/GsxG8XdFU/5hwP92DwirSzIqXihJs09RtkT9d4zvTroCASZzvfF1qLlDQX3nie4yD7OLQ3PsUrqIgIpIuiYEqbYCjGp0wkwMEo/grnhjcxKHAna0vzlnP0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKgZxu14XzQlIccuyHeOOYjQUTNSQ66Xw+m83Vva9iI=;
 b=BRvxpWuBRoTf8imY4IChR2A365x4fi1a2dJzQdLeexioF50cLWn4dkw0m5q0jzHv1VZYAmIozIx5DtZyaxpeXz2pOqDaYhTd2tZvR8xWqNQWyaTznd6CAaCNo73NwZ1QYNmQukLU1ZA55JbTbj2oVc16aHRr902mH0L6gt31Pp0yt9lY5GDn22SR6GlCmczk0c18o2qjWfKaDNkgzM4cGU1AXJ2YzDkS8TTATo74Pc76F5aRlafkqhSPJ58sh/cHq4jHB59525ghiA/nCxwTtaMLwd9uHPX+TiPUWE0mhed8NQ7CXTIXj4wxjKNuPM/yvl3yM9jL8+H8BA9VFRNoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKgZxu14XzQlIccuyHeOOYjQUTNSQ66Xw+m83Vva9iI=;
 b=vDV90C9OTzC51d5EQWakhVe0hQW72cpdHX/pgvIOEQjvV9hyenaVMcOwufnEeW+tAkiV+45O1vrTnFOIH87twpQfAvBJ4n7MpG0Snm7MVg0sdCELtLovLMGCzE5VU8yWGprkONVeQs6//lbUdPABMu4EMfTbrBuTX3hRG2xzQuc=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYSPR03MB7691.apcprd03.prod.outlook.com (2603:1096:400:416::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:13:30 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:13:30 +0000
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
Subject: Re: [PATCH v3 3/6] ASoC: mediatek: mt7986: add platform driver
Thread-Topic: [PATCH v3 3/6] ASoC: mediatek: mt7986: add platform driver
Thread-Index: AQHZwTM4vB2TH6uAe0SKmi/CtdaYlK/O7AmAgAAJ34A=
Date:   Fri, 28 Jul 2023 10:13:29 +0000
Message-ID: <db849b742c9d2eeba5db614d672667981402ae94.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-4-maso.huang@mediatek.com>
         <4eb32bcc-9a1b-c477-71b1-823bd96c0450@collabora.com>
In-Reply-To: <4eb32bcc-9a1b-c477-71b1-823bd96c0450@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYSPR03MB7691:EE_
x-ms-office365-filtering-correlation-id: 656b6f4b-303e-4226-dfcb-08db8f534a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9+Oo/YADZdqLaqjEjQvg3I2myfkjm4/5jjuYlZHhrLhmWTZFrAajy2Go82QuPjp+JUConwbN/tZEtb24XvF/rxX6SDu9urNHJ3JPclu4WedruLvlCY/6C7NFgGsXKM2Q5QtBHGyQP3rd0y2akyub6//zdTSXSeRsNxfS53BpaAcSEz1O2ksiyP6qcjr2WHDMDN2sUaAqI6pW4VsPHZoFw2DTvYF9KgA3e99ONkaM85apu5pZUEBYYaVLCZtacfKYtBY+XtqpV3k5IstO+rU62ukWZplcQj+ayLtt49EzT24p/46FPvtQSCD3QVPhNhSkoynbYFYk+jC8Yjv4L6rpaahJGjee6lQ489QuXJxbS0p0+PobhHC+BL3LSQC/sXdtCAJxTCjF7MifbH6idwgsx+3+4K4CGi1W4mjNyNbbkVVmjrp+dUinpsZaA0uipdbZ0/ypH7nZCqaKXdriRkr3W4dUO+zIn2o5tPlf+p4tuQoh0+oRugJiNN5hNnVLnhJykFAxdzuE3dra/wJjxCNum9mGs6cruYKD79t3BINI23wiXr2p725GwemVdHaO2qoUR/Pz1IIitSBQlP6lJmHd7qzXbcxLmsqLkxQ9PQgAEmWx2jC1c+siOm9SSPyfFmdkbKzVzb4xsnCs1s3WgvvcqBwZ2iCuZBZ59hXYH+cXbNGltWJG+VW5BegvCEY1JrW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(921005)(478600001)(122000001)(186003)(83380400001)(2616005)(26005)(6506007)(6512007)(2906002)(8936002)(66946007)(66476007)(66446008)(8676002)(316002)(41300700001)(66556008)(71200400001)(91956017)(76116006)(6486002)(64756008)(38100700002)(36756003)(85182001)(5660300002)(110136005)(38070700005)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3gxcVBZOTdWUjdjRjM4TG5zV1p0SFdOb2pUcmRybFlZRzV5Y0lmb2JRYWpv?=
 =?utf-8?B?SlNCZE81OEFNMy9Obi9GSkVZc2wwSjhGMjdWbU90NnRDVWhXT0J0NjM2bmNk?=
 =?utf-8?B?cE9JY3U2QlkyeWkxR0RaV2l5SkFOemJnZExTU0VydFZ2RldYNk5JRTFoL1ZX?=
 =?utf-8?B?aWtIZnpTTU0zK1JuRDQza010alZLSTdIakNzdjRYS2F2eU1yMFg4OHZ6bThW?=
 =?utf-8?B?NktCWE9UaGVsdXhkMVIwM3ZwKzY2cW5qM3RwNS84UGZJcCtEdHA0eFptUXVD?=
 =?utf-8?B?UHJLdXJuYkNMN0w0NzRPWmFEa2E4cWNic2VQaC9ERlV1TnQyZElGQzJyWHlM?=
 =?utf-8?B?cTBjS3d0SDE4aUs2SlpLejNzNE1sS1Y1TXN2NjIvMStwQ0sxSFQvcFI5S214?=
 =?utf-8?B?SzE5cEdHdzRYcW1ZbTBiNUJSTzJrTHpkWnlkeWVEM1h6N2NMdEFTU01uamlT?=
 =?utf-8?B?aVhqRHVPTVJnYVZGS0R4UitWRTVLcktqWXJock5BaDQ5TlBwNjlvUTJ6aExY?=
 =?utf-8?B?MFZIREhsMGdBUklWTmdsZUhWZjB4L0RGOUU3UXo1ZkZEejAwZ1JSbWoxSWJX?=
 =?utf-8?B?ZnlncnNkYXVHRnh3RXJPRzlhVW8zaUVoUkdXTjVUNzJDUTlVQmV3aWtmVXJY?=
 =?utf-8?B?UkRLMk8wenlyVTJyelg1QlBFL1JLamRxUnJGWTEvT2hOSFFyYTBsNFlKRjJY?=
 =?utf-8?B?TVpoV0x4NGVwRkJoVnd6VW5zNk1HVXFnWTFsSUtlU1RCZHdaRnJxdXRXVEJU?=
 =?utf-8?B?MDkvRGkwcDFiQ2VrTldyVDVTSWxja2VGaGo0UHhxZGF2Y2dNS0VrblA2aGlW?=
 =?utf-8?B?NzNDU1BkSnRVNFE4SElPVW05akM4Y29ZbUNpbmZIeFFaVUoyMGlvUEQ3bkU1?=
 =?utf-8?B?TnhWSWRkYWtIUVpEQ1NXb0JZbmxSd0xUS01xeVR0RVdPU1ErZFNoUkpvcW5R?=
 =?utf-8?B?UWlHVzVPTm1xWnBXaUwxbVpBVjBXcmR3ckVlWDNuRWxKRmVHT2ozVTkzWWll?=
 =?utf-8?B?RW0xNDJrN1VvWmxZTXZ4endIR0NMbUd4bEl4dkNjSE8wYUxlNkNiRFp4M2x6?=
 =?utf-8?B?cVNxMTliNEk0OWhsRTgxMlFsUXM0UzIzVGtGMmJOUVJ2Z2l1dTNPU0JCajRI?=
 =?utf-8?B?U3daSE55SEJpaVlhSHVrb3FTTGx4TW1CVTJFd0QzVy9Tbm9QZjgybWtkdVpY?=
 =?utf-8?B?c0VFMmo1elpvaXJ2aERFaVlySUo3b0ppWHJJZWJWWkxPcEJBMEZHS3ljRVZn?=
 =?utf-8?B?aGI0RzRWNkY5aTB1bmloTzZhWXF2bDdCWDhSMktsYS9TaExHU2w2b205d1Nz?=
 =?utf-8?B?MHRlNVlQaFRoYXJOaVlVK0lFL3Y2YmIyY1FvNnp1TkZURHJMcjkrbEg5cjVa?=
 =?utf-8?B?WGtrRVd6YUZQd2NodmdEK0VSWHd4K1BvaDk3eTdjaWtDVk5YYjNXLzNmcWlu?=
 =?utf-8?B?QUJIaWs0RTFNcTFXcHlmTkUwTU0rTFF6a090TDNZZTAvcEVBK2c5a2ZJTjFN?=
 =?utf-8?B?d001YkVPNXR0MmwycVo4Q3c5cUtMVm5BQ2laeWZWYS9obDhyVXdEUENuMmtZ?=
 =?utf-8?B?V1RXcGFKQzdtQjQ1Q2hUbVdWT2pOOTNiR2NRaDlWcnpiRlczR1FETVNHZFFG?=
 =?utf-8?B?YXo4R1VsbEZzbldJcHUweGVrL2dQTk1PYmsvdEpCZFNRQnIyWTZFT0RkVWQ5?=
 =?utf-8?B?dk41bjlxYld3RjgzZnFoVmM5NDQ1TzZBT1M3NG9sRFU0MEJ3aDJiWXNqM0ZR?=
 =?utf-8?B?Tzl1MjJFa3BhMHdkL1p6ZzE1OWxLbC9QWEhnZ1FuQkxSSHpIejJOS0M3ZTQ5?=
 =?utf-8?B?QW9zRHhzWjRyYy9lZmdaMkFiTU9nNnJMUTR1OGF4Tk1EZkN4L1pSZ2ZOdmRr?=
 =?utf-8?B?QTJOVmhJcTJsMTlNU0wxcDh2RnVvMGV3WkdxMGtuNmMwNjZ5NmRmSFllNEVp?=
 =?utf-8?B?RnQ1WSt2cVNTL2p1VytDY1ZxOEJPTEZpeHJrQ0J3cUFSRksyVUcrZWg4SWtt?=
 =?utf-8?B?WmRuSUxzanpZa2FuY1U5M0d0OXlQeis1U2dueGg4QTl5cyt5T1BzL2JwTzUw?=
 =?utf-8?B?OUZ3MHZwenp6bWFzdWR6WnYzRmhUbXpEY2pEYURVSGNCUzhBMGkyMGZJZ3FS?=
 =?utf-8?B?NWF6RG1wZE1IODVwdVRJU2wyWjF6SWJEc1RZd3dZekZFc2R0T1dmZnBsdkIy?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <110454776FD4AF40A61AB6F9151D44C2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656b6f4b-303e-4226-dfcb-08db8f534a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 10:13:29.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7UxvyIDnAwr18dqOluv1rs37yMrleivoKfxTanR8okP3sga5g6G2Dwmnv5fWglH2QnXmgn7Lgy3c9F9NGlsyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7691
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDExOjM4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDcvMjMgMTE6MDgsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoN
Cj4gPiBBZGQgbXQ3OTg2IHBsYXRmb3JtIGRyaXZlci4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHNv
dW5kL3NvYy9tZWRpYXRlay9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAxMCArDQo+ID4gICBz
b3VuZC9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAg
c291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9NYWtlZmlsZSAgICAgICAgIHwgICA4ICsNCj4gPiAg
IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LWFmZS1wY20uYyB8IDYyMg0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2NDEgaW5zZXJ0aW9u
cygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYv
TWFrZWZpbGUNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3
OTg2L210Nzk4Ni1hZmUtcGNtLmMNCj4gPiANCj4gDQo+IC4uc25pcC4uDQo+IA0KPiA+ICsJLyog
cmVnaXN0ZXIgY29tcG9uZW50ICovDQo+ID4gKwlyZXQgPSBkZXZtX3NuZF9zb2NfcmVnaXN0ZXJf
Y29tcG9uZW50KCZwZGV2LT5kZXYsDQo+ID4gKwkJCQkJICAgICAgJm10Nzk4Nl9hZmVfY29tcG9u
ZW50LA0KPiA+ICsJCQkJCSAgICAgIE5VTEwsIDApOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQly
ZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgImVycl9wbGF0Zm9ybVxuIik7DQo+IA0KPiBJ
IGtub3cgSSBvbmx5IHNhaWQgYWJvdXQgdXNpbmcgZGV2X2Vycl9wcm9iZSgpLCBidXQgImVycl9w
bGF0Zm9ybSINCj4gZG9lc24ndA0KPiBtZWFuIGFueXRoaW5nIQ0KPiANCj4gUGxlYXNlIHdyaXRl
IGEgaHVtYW4gcmVhZGFibGUgZXJyb3IgbWVzc2FnZSwgbGlrZSAiQ2Fubm90IHJlZ2lzdGVyDQo+
IEFGRSBjb21wb25lbnRcbiINCj4gDQo+ID4gKw0KPiA+ICsJcmV0ID0gZGV2bV9zbmRfc29jX3Jl
Z2lzdGVyX2NvbXBvbmVudChhZmUtPmRldiwNCj4gPiArCQkJCQkgICAgICAmbXQ3OTg2X2FmZV9w
Y21fZGFpX2NvbXBvDQo+ID4gbmVudCwNCj4gPiArCQkJCQkgICAgICBhZmUtPmRhaV9kcml2ZXJz
LA0KPiA+ICsJCQkJCSAgICAgIGFmZS0+bnVtX2RhaV9kcml2ZXJzKTsNCj4gPiArCWlmIChyZXQp
DQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJlcnJfZGFpX2NvbXBvbmVu
dFxuIik7DQo+IA0KPiBBbmQgdGhlIHNhbWUgaGVyZSwgIkNhbm5vdCByZWdpc3RlciBQQ00gREFJ
IGNvbXBvbmVudFxuIg0KPiANCj4gQWZ0ZXIgd2hpY2g6DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCkkn
bGwgcmVmaW5lIGl0IHdpdGggaHVtYW4gcmVhZGFibGUgbWVzc2FnZSENCg0KQmVzdCByZWdhcmRz
LA0KTWFzbw0KDQo=
