Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466B07D7E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjJZI2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbjJZI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:27:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07EC18F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:27:49 -0700 (PDT)
X-UUID: 8707b15073d911ee8051498923ad61e6-20231026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OVvZWp6EXR2XjaRMByoFURjTFKiYVTUH8cCz4yQM1CE=;
        b=Jg248Q5UTcF/2sfy7EN6afggZU9Uy/KSYLECISqB+sYHVGW/9PNL/RCLZFmStf8NpUp1z06uUPlDJ/zakgiTqL2xFICHOKwZjtmgEsBFPikRVRtLEp2cf60S8PheP8DBgW/gIpzqeJj63uubQVBTUl1v+2lzOnitQVjmam35NMw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:47a1d34e-8025-4cfc-b175-b9e7d343348a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:342aa994-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8707b15073d911ee8051498923ad61e6-20231026
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1661529981; Thu, 26 Oct 2023 16:27:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Oct 2023 16:27:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Oct 2023 16:27:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9CFXstOQR84U60sr4fCvP0tsuCtzLBplhAufEo1PU4H3wnMqPNH7w9a1PcKMmY989J4gHkMprQ1tH+Z5czwQC/6gIm8/eVzA6K4yA4YolxbJzi+D+Iuu8nzczRwFWh3DRMoYd9hfMbwnEtJXJntn1tNcXBZ7EjqqS0L6lbTskQHDmaGCFl2KzlYuND5V04ameKtb+KXqDM9LwucPVd1Dj84L/vRl76aU3qTT9hayjs6yjBJ74tDFDO1nzdFBUY2SIIOohDxm82fMcpDB2Brxx8C2iGNEG8qePpuXn0KH/DnbNrFC/QvvaZUkcfd92c0MUKlS9R+4p28u4hXanIHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVvZWp6EXR2XjaRMByoFURjTFKiYVTUH8cCz4yQM1CE=;
 b=dHWwk8zzkJfPPP37kIFiM/m0Zw8N6dAA7EYSC/ldNlsBHyfoavNbHKSPtmXji4g+Xa289Cg2f/AxLPgGLF3/JgTanLbtYv6Wre4sKrC5lRwWK6/gfidDqksVkpKkoeSG/ncKMl3DBgXoZj5vc0Sp8HdpnI5Ply1n6dN+btUDJ3biFhy3lf+jxgr9D0pezcLaDofsWBSjrHz+XRcu/Lrk7jmJZoqi5pCLqY9jrjS8a3oV4gd/mdwJ8oQhSKKhjm86kljlsdydznw+RzHmDYlq8rqew5G4fTYcOXvwQinpyZR73EtZM2Ejpk/G6vKimIM2iBl2IaLrpFxq/cxJ2IEWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVvZWp6EXR2XjaRMByoFURjTFKiYVTUH8cCz4yQM1CE=;
 b=q3wE17hkj2ntTcHEsVbnOqG1L6mZKgDZQSua8PDdeXb9vG+H82Y4/q8J08L6fhCkmZdprT3yr3JlCChTxoAewCwOQvkLiBuUXwZ3aV/jCHOApSpxgtJf8Zokai82ROEmC0t2dLouXfT2dDcRZKnoYqbsvOUusFeiE1tFJ9rs+IE=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SI2PR03MB6808.apcprd03.prod.outlook.com (2603:1096:4:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 08:27:36 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::7a6f:69a8:742c:af8f%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:27:36 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHZ6f8vrgZaHzRCV0+BVRY7kyABsLBbin6AgABuDoA=
Date:   Thu, 26 Oct 2023 08:27:36 +0000
Message-ID: <72db0a70e99374509140dada1363edb33b33b1e5.camel@mediatek.com>
References: <20230918071011.18481-1-shawn.sung@mediatek.com>
         <20230918071011.18481-2-shawn.sung@mediatek.com>
         <10fda9ad9ffc4a16418ccd8b113f8cece461747d.camel@mediatek.com>
In-Reply-To: <10fda9ad9ffc4a16418ccd8b113f8cece461747d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SI2PR03MB6808:EE_
x-ms-office365-filtering-correlation-id: db54d3fa-2e39-4592-451b-08dbd5fd68bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQgwnRHfbiWWFBp5FASKLsUMBgYvnI3nlN48lwEcSjHI68ea8gGHg0GdZhRF98qjs7MvpHxTwf0ofg5Y3N/JSk1mgSq8dp+12akiqxrUMC3ZB72Ukbk0J4dygTCav0QcQpJGFm7My+qDZFPR3BT65GXtA3gPWPdtuA9XOZlhK2h5cflEMDHBn+iL4RPY8vRqnR+Y+wRwqBVxE3+PjoCkRUWhSKshYMapz7KFAbq8NXZ6Z7zJ/4ZeNOGRzvZYCPLvPetfO+eMvLXsCbUsFBjtFuuOYl+0OdKfSdH++WFKa11IyVPtn0/oaoDCzz64DcTR4Lxejh+/SH29kmeDUkbfPeiyEmST0kwacMg+O0PQ8bmYMFoYjviXmglvvwrbZEJmhYFJkgjuG8SI8QRCgjE6KkaxdZ9xIDCxDFOb4fboXRMGYifPC8zaqN5Mwk+3NVlqz3Ph0PEkJ9LOvoxSDCZuO+eGE06F7u+/+jNvgpxP/qoY3zUTOZePb7rpoIN2SMPDb001YjT3kbFi4LZ/FR3ZWg0IDF4BOve+r65aAQ00sz1fbnr8qqPcLAPeWrPOtpVEIyAMXizPoo0B2OgVRCyYYLgAosRInqSsxHPfTxqRjW8+5Lf6zY+aqO31RXcioZGBuWiyjK+Gh8kUx6tWQ6C4h0wvxsGXj2wcYti3DvOXoM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(26005)(86362001)(71200400001)(83380400001)(2616005)(36756003)(122000001)(85182001)(41300700001)(2906002)(4001150100001)(7416002)(6506007)(38100700002)(6486002)(5660300002)(478600001)(8676002)(8936002)(6512007)(76116006)(66946007)(110136005)(4326008)(38070700009)(66446008)(66556008)(54906003)(316002)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czBRbU9YRlprRm1mUER3WHc3WFFoajRBaENGaWxvWmNLN2NsaTRxem9jOTdG?=
 =?utf-8?B?SEVtNU1EamRuRTBxVzhyT2QxUlBDcDhNV2JyRmJBbW5FMXlod0N5NGMraERj?=
 =?utf-8?B?OFFIOTUraW82bUgrSWh3anVJL3BiaDk2RHdVOENHdjFEMU5ZTnp1aDNVam9H?=
 =?utf-8?B?TFp5T1hkMmMrNG9wT1FreHRwR21tcVJGZDg5RW81OXp6R01KWHNqVXNCejRD?=
 =?utf-8?B?RzJzdE95VVhKVmZLTjFzemZZb3JWZDdrZU5TNFhJMHBWVFJOVE9aT0gzZDFi?=
 =?utf-8?B?RU8vMnVkNThwcEttcmVQN2lidkRuZzhPTE1tTC95SDdiQkJzWGY1bWkxRC84?=
 =?utf-8?B?bklvc2F3YmtLMGRZbno1UlpVREZHQ1FNS0ppSDh2djJvcUNaeklRR1lZV0Z3?=
 =?utf-8?B?eFRCdHVjWjRVc0lXVVI1SWY4QmY4QmdybURYUEFoamFNdkJHSWwxYlpnV0FX?=
 =?utf-8?B?S1hZL1dUNE9UMU9VQVl4dHJuKzJGR3lNdStEMlMyTStJNy9vM2JObGdoTXMz?=
 =?utf-8?B?MU9yZHZxOVhLWDF6bTFOUGpheXFxSnNZSDR4L0Iyb0Fwdm1FMTVhVnkxNzJ5?=
 =?utf-8?B?ZkcyRHlyU0VxYWN2VFdWdi9lTldBM3ZWSkxaMm8wbWVDYUVYT2dvOFJFMTNQ?=
 =?utf-8?B?UGxCbGQ5ZGpqWndMWklzN1FGbU5XendwTWlQaWxJQldNaXJleUgwcmVVc094?=
 =?utf-8?B?K2NVQkNncU1LWTRwV2o4RGRCTC9uK1ZBRUVWWlA4ekxGZUhDOUtNaDlsNUtl?=
 =?utf-8?B?WDNNc3NjZVFZS2ZmdmM4bXI3UVQwYlc0Q2ZseFdJMGFXRTRmSklheG5INmlQ?=
 =?utf-8?B?ditzSUl5b1kwWjN5QjhkTjdtc3JTZE16ZmJNUHFsZCtWTkZ5Z0FEV1NtdTAz?=
 =?utf-8?B?bnlVdlVOOGtEOXJlYlBVU09TY1FCQ3FUS3dnMjI3clNRZE5aZnhyVzloVnVu?=
 =?utf-8?B?ZElCOUpVNGZnNUxuVVBlZHlNSDN4ckdTZFh4QnNDbkVsQ0RSSE1vMkxHM2FU?=
 =?utf-8?B?N1huVjZCa3dpVVJHU2JhVDFLaDA5MHYrOFBDWG0zZFR1VXFJTVUveUFOSHRp?=
 =?utf-8?B?UkJXbDZYdFlUQ21XZVBWSHlDclVjVGRHNXJ4VHBMN280MWRxaUsvb2I0QWla?=
 =?utf-8?B?WElCdEpuWkJ6aFFxL2cremphbGYvOTJoMGtvVDBXbHlYL3BKQm5PR3psNnhx?=
 =?utf-8?B?U3piQTVVMG1rZDJ3akgyMkoyNFhxMjA4cXE2aXZ1NHN6MkZDelJhM1dSVWU3?=
 =?utf-8?B?V0lXYWVGN3VzakhydWQrWjNxMFRVZWFrUVdFaGdTWE9jVTg3c25DbWNvTTk3?=
 =?utf-8?B?K053R1pneXVpOXRjbnpEN3JaODFOaW5jalc4RUx2Q2hRNzRvRU90Sk5BMjM0?=
 =?utf-8?B?UGtFTk9lVm9Ud0FPaUd0QmNtSWd2RGZScUFoaUtsT2c5eVZhaWN3emI2enZ3?=
 =?utf-8?B?SDdiYkt0cEpqMWVsNmdXcVQyNkEzdUxaT0h4U3pVdkg2YndPNXJ4MjNqYnFC?=
 =?utf-8?B?dEQ3ZVBvUmcyTjlIZk9laGxEeFpFOTJ5WnF2eEtOYXFsNkRwWVNoMTV0MDY5?=
 =?utf-8?B?TGV5NGVpeEFKRE1wK0gwTmhlNFJhTWpJRXlVNE1PbmdaTmJsTlN5VWRNa1FR?=
 =?utf-8?B?QUZPbzh4dmZrN29Va0tmWGlKYWREd0JCR1J0aXZZQ3I3bUZKZmh1aGZRR2Q5?=
 =?utf-8?B?V0ZySkZPWjN1LzBScTMyUWVadFVPSnBmYnVRcmI2dW03N0NqcUIwZTFFa08r?=
 =?utf-8?B?WHQ0dGh3TTlIRVdIUzY3SWo1dmFpRlduZGROSCtpZXcyYnpzUS9oeFpBM2M1?=
 =?utf-8?B?Tm9haVdsR2k5TDZhUDFRdEJTVnNjVGZVTFVtekZ6UzAvZ1BQT1RPZU8vMXhm?=
 =?utf-8?B?aXFTK2ZHUEJ6aXdJcU1BTG15eFVyUFpiQ1Z1RWliWHBwTjM2Mzl3UnVpNERF?=
 =?utf-8?B?d2xINGZPMFloZEIvSFA5cXdDdk5GKzNqblhPZFJmOXBoTS8vcUEyWnFBOGtH?=
 =?utf-8?B?MHc4ZU9vbGtCWWxVTFBESUhFWHE1aHRzZFVQQzd1WXNiL2ZMazFNUDhoeFJo?=
 =?utf-8?B?S1R3RVc1V3FXRUJVZDhEQk8vd3R4KzFhSzUxMHpGM0dCTzdCbnZzdTBhMURj?=
 =?utf-8?B?Sjh6K2JJdmluYXZZRTYvT0s4STUvbnJLQkczUFRGSmdSMGRVRWdSVkZlWXpN?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F64DB478495E404289F0C06801C97718@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db54d3fa-2e39-4592-451b-08dbd5fd68bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:27:36.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ESiJxXz2g5DwIZqcAdfgi4nIUY1Qp99WQGHYecDGRaMenwwPY3rQZ/yu5h+9YmXbL6QBkBSU6PiVg3LM5ruUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6808
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.422900-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4ia1MaKuob8PofZV/2Xa0cKSO6So6QGgypyh
        lVw/MC0Hvb6Wbu7L5KCxK9ETst1t5M9tfSEZlKTRh3ZN+5lFR7eeEP0DdJruliz+5QCTrE/saUX
        s6FguVy13IL9RTZjcZXTv9Bst6w/PD7+f/jfUYxIc9jA4mLo8uWLu7N0EkjfkmyiLZetSf8n5kv
        mj69FXvEl4W8WVUOR/joczmuoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.422900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 85939A2D71189CCC3999113673F534A1C83CE02579D03E926ECF7D9CE06A9A9D2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFRodSwgMjAyMy0xMC0yNiBhdCAwMTo1MyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIE1vbiwgMjAyMy0wOS0x
OCBhdCAxNToxMCArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBGb3IgQ1JUQ3Mg
dGhhdCBkb2Vzbid0IHN1cHBvcnQgcm90YXRpb24gc2hvdWxkIHN0aWxsIHJldHVybg0KPiA+IERS
TV9NT0RFX1JPVEFURV8wLiBTaW5jZSBib3RoIE9WTCBhbmQgT1ZMIGFkYXB0b3Igb24gTVRLIGNo
aXANCj4gPiBkb2Vzbid0IHN1cHBvcnQgcm90YXRpb24sIHJldHVybiB0aGUgY2FwYWJpbGl0eSBv
ZiB0aGUNCj4gPiBoYXJkd2FyZSBhY2NvcmRpbmdseS4NCj4gPiANCj4gPiBGaXhlczogZGY0NDQ0
NTc3MTE4ICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0IDE4MCBkZWdyZWUgcm90YXRpb24iKQ0KPiA+
IEZpeGVzOiA4NGQ4MDU3NTM5ODMgKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgcmVmbGVjdC15IHBs
YW5lDQo+ID4gcm90YXRpb24iKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVu
IFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgICB8IDEgKw0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgICAgICB8IDggKy0tLS0tLS0NCj4g
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgfCA1ICsr
KysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgICAg
IHwgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgICAg
ICAgIHwgMiArLQ0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2Rydi5oDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
ZHJ2LmgNCj4gPiBpbmRleCAyMjU0MDM4NTE5ZTEuLmY0YzdkYmE4ZjczZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBAQCAtMTIwLDYgKzEy
MCw3IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4g
PiBkZXZpY2UgKmRldiwgdm9pZCAoKnZibGFua19jYikodm8NCj4gPiAgdm9pZCBtdGtfb3ZsX2Fk
YXB0b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgdm9p
ZCBtdGtfb3ZsX2FkYXB0b3JfZW5hYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+
ICB2b2lkIG10a19vdmxfYWRhcHRvcl9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYp
Ow0KPiA+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMo
c3RydWN0IGRldmljZQ0KPiA+ICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdGFy
dChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9wKHN0
cnVjdCBkZXZpY2UgKmRldik7DQo+ID4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3JfbGF5
ZXJfbnIoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBpbmRleCAyYmZmZTQyNDU0NjYuLjVmZDFmNmFlNDFmMyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBA
QCAtMjg4LDggKzI4OCw3IEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xheWVyX25yKHN0cnVjdCBk
ZXZpY2UNCj4gPiAqZGV2KQ0KPiA+IA0KPiA+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9zdXBwb3J0
ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgew0KPiA+IC0JcmV0dXJuIERS
TV9NT0RFX1JPVEFURV8wIHwgRFJNX01PREVfUk9UQVRFXzE4MCB8DQo+ID4gLQkgICAgICAgRFJN
X01PREVfUkVGTEVDVF9YIHwgRFJNX01PREVfUkVGTEVDVF9ZOw0KPiA+ICsJcmV0dXJuIERSTV9N
T0RFX1JPVEFURV8wIHwgRFJNX01PREVfUkVGTEVDVF9YIHwNCj4gPiBEUk1fTU9ERV9SRUZMRUNU
X1k7DQo+IA0KPiBJZiBvdmwgZW5hYmxlIHJlZmxlY3RfeCBhbmQgcmVmbGVjdF95IGF0IHRoZSBz
YW1lIHRpbWUsIGl0IGlzIHJvdGF0ZQ0KPiAxODAsIHJpZ2h0Pw0KPiANCj4gUmVnYXJkcywNCj4g
Q0sNCg0KWWVzLCBpZiB0aGUgdXNlciBkbyBzdWNoIGFuIG9wZXJhdGlvbiwgdGhlIHJlc3VsdCBp
cyBlcXVhbCB0byAxODANCmRlZ3JlZXMgcm90YXRpb24uDQoNClJlZ2FyZHMsDQpTaGF3biANCg==
