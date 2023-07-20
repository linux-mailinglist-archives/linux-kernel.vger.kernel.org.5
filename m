Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C275A918
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGTIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:24:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D82110;
        Thu, 20 Jul 2023 01:24:02 -0700 (PDT)
X-UUID: c683fc3026d611eeb20a276fd37b9834-20230720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6iPTH9dVUt/LOf9aPI/LaRP5g1CPUrFsqU9c9mMr65A=;
        b=ncrdemC186Qvrn28QCj/bTGif3b4sxQ/or9Ix2GdKn2qf/GYYkaK+Dx9IubtZJaro4mR+PXoAr3RpjhWyc/x8VbrRiT4n6sYECq5CrZQSnD5t32giBLGeY/BXp1m4YNKtcy2PhH5CBt+b8USOAOxK6AT0YeSBm6yH6eHBJqiIMU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:045da50e-5b9a-4ed0-93bf-cd957598ce7e,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:65
X-CID-INFO: VERSION:1.1.28,REQID:045da50e-5b9a-4ed0-93bf-cd957598ce7e,IP:0,URL
        :25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:65
X-CID-META: VersionHash:176cd25,CLOUDID:d511e18e-7caa-48c2-8dbb-206f0389473c,B
        ulkID:2307201624002MF7XO88,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: c683fc3026d611eeb20a276fd37b9834-20230720
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1671136945; Thu, 20 Jul 2023 16:23:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Jul 2023 16:23:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jul 2023 16:23:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKTfvmuzZeWc+9q7bJNzsJtGC8DC6VVlR3ifFCrd/ARnBKIuOZecAmBWYpwTmJImGrX+95NRD6i4R08pbN/y+QTzCV7x2iiQhDPxVYmOyAgMNJZwZx1iTwpmycFRIO7WMLOiO2OuyYYsXAWOw/Rc+cDvf1x7syRHMwmu+p4epFBQUAbCTcRav2i5rrEpo0nsHjevjI0/14Asg0fMTyxbmz/LMsb8ECgnM6KKsHh6hVFSGk/rn+bDaTKF5ulUTBXsGW+lSSb7MWHJK2uWCETaDVWfCtxRDKN+L7EvxpBQUnz6XUJS+rRbouLVSWubvX3HS8IvnL+gBdavEHLzwsC3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iPTH9dVUt/LOf9aPI/LaRP5g1CPUrFsqU9c9mMr65A=;
 b=jOVZ5O6YDRzCDkuRusdotz3oXbqQx0+4pC3kaXP9xCD6L1vwnUUZmV0F3mJL+v1lAODgriZCteFwghDNY2uNnqjWQm2C1+NSuS3qRX5e1yDB8VhtyIt4H9+so53sZtvVIrBeMwYZ57crlt/lxaeD2CLlsROVv3BxyEmSwFBt7M5JOf+qtbfy7brLJndWWRPjhGAXg9gQZlvuthLmXlGBPEYSKVVTtEwtgU7kUdtd3LFlzgC+29js3fJrawW3GerRgaGpHdiqcton1OJIO+eHO1FWx1cJJgsMsnP1f0KQt88eCX6m9nuwxVCzO5kNdoKv9xXGrCOcbAWdOwzJ+uywig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iPTH9dVUt/LOf9aPI/LaRP5g1CPUrFsqU9c9mMr65A=;
 b=qcSpV7It7JBA+I5Wi51j1lEH4sbr9J6xUckxbXo5qDqE79LTjsrYnntMAngb4Xo08WYKKUFfDdEtoCFiw0JnKx4f4ngrOVlzeB5tb+4+fPs0/lBP9druUZzkKNO3Xd4T9MouIZhuvBXXYCWBf2P+zVlVjn9CyKpwdZMt46CE6h0=
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com (2603:1096:4:3d::11) by
 SEYPR03MB8005.apcprd03.prod.outlook.com (2603:1096:101:176::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23; Thu, 20 Jul 2023 08:22:34 +0000
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::7427:c811:1678:5916]) by SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::7427:c811:1678:5916%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:22:34 +0000
From:   =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2, 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Topic: [PATCH v2, 2/2] drm/mediatek: dp: Add the audio control to
 mtk_dp_data struct
Thread-Index: AQHZr8uipzzRUXVwkUGV2HIVye0PFK/CZyCA
Date:   Thu, 20 Jul 2023 08:22:34 +0000
Message-ID: <4eb44b4f2389ef9f011f5ae3fc4e664fd3b1260d.camel@mediatek.com>
References: <20230706021425.31735-1-shuijing.li@mediatek.com>
         <20230706021425.31735-3-shuijing.li@mediatek.com>
         <e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com>
In-Reply-To: <e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4165:EE_|SEYPR03MB8005:EE_
x-ms-office365-filtering-correlation-id: caff220f-38eb-4bbe-2b27-08db88fa7839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jOublDcKwShSXIzePAF4I9Uu0RDuB/sQ9AwpfVUCFpUtvdXMByeAHqyp0eHS8BcMTmiDdCMbvJlQloPbc3GdCKJ8SAKcyv8tH6nku2imD+kwb/+bv2lC/G+yXlYaKTKAGnoeQiMZ7qvuqceJYVrb0zgOB+kl8c72eNaDglk40JmPg6jVKVClUdC0T0RTVy961zs56F8KM//GYhC7DK3WcCm8FsCs4uDr5XSwMUyAV/yMRKZCLoQhC5Wo9mkNNnsnZ/uo9qslNF3g33FmaWGhOA3zkckcVD1l6Zl3MZ4h3Y2u4MkZUbMev/SpuvJI82XMpWmfkUb7f8jjp27KKHLxzMIFiUWzBL1Q9GplJcT8eTHgMCKnbjI3XdUUgVl3YdxI22Gx15h8tN7FLc+b5s2AyVwXQiDUDFSvVKu6CyrwCLgQBgLp3s4vx2sorxJ5yuxZehS6L34rFfoAC6nuc3j0N+nUe59rb5WfdaC/3SxBaBwyofg90ZQyYAFd5X3qEXwf87z29rS532QmhvV82Nq8kDjQCXA3GWiMR8Oi7cwfJv3EL0R93tHF0KrqEv6MCncg+iTPtMGZsHSYC2RvqKaSG01aiA+vKwgsWDAB9JnchEstplBobws9w9HRL32cqdMmpiMTajFiWZWOuIgK/Uwt2nqz5Kk2IVAAvfM/CiQb+BE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4165.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(8676002)(41300700001)(5660300002)(8936002)(66476007)(66946007)(76116006)(66446008)(64756008)(66556008)(4326008)(316002)(107886003)(54906003)(110136005)(478600001)(2906002)(7416002)(71200400001)(966005)(6512007)(6486002)(122000001)(921005)(26005)(6506007)(186003)(2616005)(38070700005)(83380400001)(85182001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFF4ZjFlcGhRcTFLSnFSZ2ViWnd0dHU3U2Y0ckIxYnNVTFE1NUlFMXVRRTFz?=
 =?utf-8?B?OGRuRkRYc3g3eXJ2WE9ZMWhlTjZ3VlZFUW9NR0g3NmZlMkdaMDIrVFZwTHFy?=
 =?utf-8?B?aFVWdVUyUy9mdG9WVER6YVJvSWNDYzFLeTZwM2dxS3RGTmtTMXl6ZnJQdlAz?=
 =?utf-8?B?TVlRVEZGUnBuVysvTnUyUzBYWWMyUDlnYzBGb2dYTE1yVTlVQnhvZHRQd2tO?=
 =?utf-8?B?emxyNGtSdVhtZk1FamkrbWRZdnlGQlZJVnBRMnNqdlBRdGNhUTJNTktsalRX?=
 =?utf-8?B?eldPNUdHZ0xNVUNuRnNIMlVDZkVTajZXTUllc04wN2g3eXVJQ210Qnc1UGlF?=
 =?utf-8?B?czM2REpxSzE5aDVrNzZoRTNLelducUYzVlpIRXYvbUFxV1hYejk0ZmxXbWRF?=
 =?utf-8?B?V2tUMlBqK0lBSmxiVWhIVmpzZTlRRjVBTmFraGY4Myt1clFVcnlQTjlkU1p5?=
 =?utf-8?B?UzQwZnN6bTdnYVFESFJsRDVnVHpzOGZWWWs0NFJPMXFVOWF5YWNReGZub3lr?=
 =?utf-8?B?R1g5MkFiQkgrbnpVTDBQUVV1SGYxT3krR1J5ZEJQYWIrU3g1aWo2KzU0MlA3?=
 =?utf-8?B?cldqWThtcU9abWhDc1BOekoveHJOQmtLSzRMbHFWdjFxYytublFNNHFMQWR4?=
 =?utf-8?B?K1dLTEV5cHJQTkFPMS9kZmFVajd1TjhBRURlbk90V1orVjVUbHVHVzA2cW5q?=
 =?utf-8?B?WHhWZXpkR2w0VXV0SXljeEVaRFpqWEZFVkw4MUxQdzNRa2Z3aGlZUGFCTTdo?=
 =?utf-8?B?UEdXcXFvWlp3UEsvZVQ3WVZFUEZidXRBWVprMXdWVzByT3NWc01VUVFjWERK?=
 =?utf-8?B?MkhaREUrc3hueXFYeWFpdXJsNWNVcXFiaWdEaGtGZDJLeFVnVTFyTjhad0hN?=
 =?utf-8?B?YjRNMFVqdkZqVm16RjhaaEozZG9Bblh2TElVQ0tiMDhlK0hyL2E3ZWxkcmVr?=
 =?utf-8?B?cUN6NkpGVDhZeUxLK1VzaGc3TS9ucWNlYVFOZ3VPSEY3SWl3c2gyRGkrdjJL?=
 =?utf-8?B?ZEF4VXhBTnNwR2tPcXEwOVJIcUdXeHBUZHlINldJb0tSZmprVkhGK082YW9u?=
 =?utf-8?B?NllXY0pXRkgrcTQ3dXpLQ1h3UFhNOTFNMkprRno2RU5wemZQZ01kN3NjZ0tJ?=
 =?utf-8?B?R3c5eWh0VCt5cjc0RVJuQTk2MThTTkg1aE82Tm5vR3BkZTlPZ29WR1crUGp4?=
 =?utf-8?B?aE16UHlXZlJjK1F0V0ZkbjRaa1FLeHFXVHhzT0M4bkZYdjdISkNTYzhuVXBk?=
 =?utf-8?B?U0NIc04xZVkzVTZOSTJCMS9iSlRhSUVoL2J5SlN1TEFpeHEvKzdOR0M5VTh0?=
 =?utf-8?B?TE5vYndxWDJQM1RCWXpmNEpGdHVjL0pIeUhiY055dGsrU2gveS8zS2pKQk5t?=
 =?utf-8?B?T2NsQXJpdGJRT0E4MVV4MHBKSWNvWGR5TVJuQjc4RGlvNzdWOEtFazJBeTlq?=
 =?utf-8?B?SVg2N2pYWjVlZnJFL2FDb1FwSDlYY3U4bFcwMk81MGo3dG96UWhidXpwUkJC?=
 =?utf-8?B?TkJmYnkyemNLcEVKb2xqU3BUNE1OcWQrVEc5RkxmS3NLdU9iTVNXUm41VWhW?=
 =?utf-8?B?M2MxWUZDVlRxTXhXZkNQQ05mMDBRQittclFUdXRMa0Z6T0NTRzZZR1JLc1Ez?=
 =?utf-8?B?cEZYVHdXK1Z6VjljdDVuNk5yc3hGTFd2N3U2RmlwRG85RFJ5SWlDVERsTjd0?=
 =?utf-8?B?MkVOZlVsUEdxSFlualVKTVpkb01QSmdYZ05hNjNDTThOU2NVb0k5YzRiUEND?=
 =?utf-8?B?YjE5bnU0YXV3aGdmVlNxTmc0U3ZudE5nYWx4MVFPdTErRDB5M1BkUUxiUE1G?=
 =?utf-8?B?MmlrSU1vZXlRZmMvakdlVDBGcitNdUY5c05ORjRPTHBNdXA3MWZiNlFXRmlK?=
 =?utf-8?B?eHVzcEt1dGZGVk10Q2ZINEwrSnhZWklvUFh1blMrbXhENnBoc0VuWCtPQzV2?=
 =?utf-8?B?aVlCWGpoVTgydmt1dEhhMmltYTRPdmUwQUdqaHZVbWEwaExjaXUySGh0VFZS?=
 =?utf-8?B?WW0xTDBsTnpzYlJHbnlydVhmRnZzbURoZ1NBdDJ0K21jZWFFRW9kSGZrcFcx?=
 =?utf-8?B?Nm4rRjRFZHZ2MDdUZ3hnOHVrMjRhSDV6Qm0zRDZEbmxsSkNZck85cDVFeHRt?=
 =?utf-8?B?Yll5SWY1bmRvZFNNSWNTTWhjSjZWOEN6QzVGcXRYWW0ycU9RWFlLVWNFcnpz?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DAA2DFB7360844D94DCE887F3513AE6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4165.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caff220f-38eb-4bbe-2b27-08db88fa7839
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 08:22:34.2920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzGVtNKzYqGEl0pQQMfebx63xUB4ce22QOnE6Tqr5VBxTTHdwSy9WJexTSuyMyOnsYMfrSgQPAfpfVrwi6Iw+D7u2x5UGwdLGOyzM4iJVXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCj5JcyBnMTIwMCBhIGRwIHJlY2VpdmVyPyBJZiBnMTIwMCBpcyBhIGRwIHJldmVp
dmVyLCBJIHRoaW5rIHlvdSBzaG91bGQNCj4gYWxzbyBmaXggdGhpcyBmb3IgbXQ4MTk1Lg0KDQo9
PT5nMTIwMCBpcyBNZWRpYVRlayBHZW5pbyAxMjAwLCB5b3UgY2FuIHVuZGVyc3RhbmQgaXQgYXMg
TVQ4MTk1LCB5b3UNCmNhbiByZWZlciB0byB0aGUgbGluayBiZWxvdyBmb3IgZGV0YWlsIGluZm9y
bWF0aW9uLg0KaHR0cHM6Ly93d3cubWVkaWF0ZWsudHcvcHJvZHVjdHMvYWlvdC9tZWRpYXRlay1n
ZW5pby0xMjAwDQpUaGlzIHBhdGNoIGlzIGZvciBNVDgxODggaHcgZGVzaWduIGNoYW5nZSwgTVQ4
MTk1IGhhcyBub3QgY2hhbmdlZCwgc28NCk1UODE5NSBkb2VzIG5vdCBuZWVkIG1vZGlmeS4NCg0K
PlNlcGFyYXRlIHRoZXNlIHR3byB0aGluZ3MgaW50byB0d28gZGlmZmVyZW50IHBhdGNoZXMuDQoN
Cj09Pkkgd2lsbCBTZXBhcmF0ZSB0aGVzZSB0d28gdGhpbmdzIGludG8gdHdvIGRpZmZlcmVudCBw
YXRjaGVzIGluIHRoZQ0KbmV4dCB2ZXJzaW9uLg0KDQoNCkJlc3QgUmVnYXJkcywNClNodWlqaW5n
DQoNCk9uIFRodSwgMjAyMy0wNy0wNiBhdCAwNTozNSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkg
d3JvdGU6DQo+IEhpLCBTaHVpamluZzoNCj4gDQo+IE9uIFRodSwgMjAyMy0wNy0wNiBhdCAxMDox
NCArMDgwMCwgU2h1aWppbmcgTGkgd3JvdGU6DQo+ID4gTWFpbmx5IGFkZCB0aGUgZm9sbG93aW5n
IHR3byBmbGFnOg0KPiA+IA0KPiA+IDEuVGhlIGF1ZGlvIHBhY2tldCBhcnJhbmdlbWVudCBmdW5j
dGlvbiBpcyB0byBvbmx5IGFycmFuZ2UgYXVkaW8NCj4gPiBwYWNrZXRzIGludG8gdGhlIEhibGFu
a2luZyBhcmVhLiBJbiBvcmRlciB0byBhbGlnbiB3aXRoIHRoZSBIVw0KPiA+IGRlZmF1bHQgc2V0
dGluZyBvZiBnMTIwMCwgdGhpcyBmdW5jdGlvbiBuZWVkcyB0byBiZSB0dXJuZWQgb2ZmLg0KPiAN
Cj4gSXMgZzEyMDAgYSBkcCByZWNlaXZlcj8gSWYgZzEyMDAgaXMgYSBkcCByZXZlaXZlciwgSSB0
aGluayB5b3Ugc2hvdWxkDQo+IGFsc28gZml4IHRoaXMgZm9yIG10ODE5NS4NCj4gDQo+ID4gDQo+
ID4gMi5EdWUgdG8gdGhlIGRpZmZlcmVuY2Ugb2YgSFcsIGRpZmZlcmVudCBkaXZpZGVycyBuZWVk
IHRvIGJlIHNldC4NCj4gDQo+IFNlcGFyYXRlIHRoZXNlIHR3byB0aGluZ3MgaW50byB0d28gZGlm
ZmVyZW50IHBhdGNoZXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gY2hhbmdlIHRoZSB2YXJpYWJsZXMnIG5hbWUgdG8g
YmUgbW9yZSBkZXNjcmlwdGl2ZQ0KPiA+IC0gYWRkIGEgY29tbWVudCB0aGF0IGRlc2NyaWJlcyB0
aGUgZnVuY3Rpb24gb2YNCj4gPiBtdGtfZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UNCj4gPiAtIHJl
ZHVjZSBpbmRlbnRhdGlvbiBieSBkb2luZyB0aGUgaW52ZXJzZSBjaGVjaw0KPiA+IC0gYWRkIGEg
ZGVmaW5pdGlvbiBvZiBzb21lIGJpdHMNCj4gPiAtIGFkZCBzdXBwb3J0IGZvciBtZWRpYXRlaywg
bXQ4MTg4LWVkcC10eA0KPiA+IHBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVh
ZDoNCj4gPiANCj4gDQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9hYzBmY2VjOS1h
MmZlLTA2Y2MtYzcyNy0xODllZjdiYWJlOWNAY29sbGFib3JhLmNvbS8NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jICAgICB8IDQ3DQo+ID4gKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBf
cmVnLmggfCAgNiArKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0K
PiA+IGluZGV4IDY0ZWVlNzc0NTJjMC4uOGUxYTEzYWIyYmEyIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHAuYw0KPiA+IEBAIC0xMzksNiArMTM5LDggQEAgc3RydWN0IG10a19k
cF9kYXRhIHsNCj4gPiAgCXVuc2lnbmVkIGludCBzbWNfY21kOw0KPiA+ICAJY29uc3Qgc3RydWN0
IG10a19kcF9lZnVzZV9mbXQgKmVmdXNlX2ZtdDsNCj4gPiAgCWJvb2wgYXVkaW9fc3VwcG9ydGVk
Ow0KPiA+ICsJYm9vbCBhdWRpb19wa3RfaW5faGJsYW5rX2FyZWE7DQo+ID4gKwl1MTYgYXVkaW9f
bV9kaXYyX2JpdDsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2RwX2VmdXNlX2ZtdA0KPiA+IG10ODE5NV9lZHBfZWZ1c2VfZm10W01US19EUF9DQUxfTUFYXSA9
IHsNCj4gPiBAQCAtNjQ3LDcgKzY0OSw3IEBAIHN0YXRpYyB2b2lkDQo+ID4gbXRrX2RwX2F1ZGlv
X3NkcF9hc3Bfc2V0X2NoYW5uZWxzKHN0cnVjdCBtdGtfZHAgKm10a19kcCwNCj4gPiAgc3RhdGlj
IHZvaWQgbXRrX2RwX2F1ZGlvX3NldF9kaXZpZGVyKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4g
PiAgew0KPiA+ICAJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRLX0RQX0VOQzBfUDBfMzBC
QywNCj4gPiAtCQkJICAgQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8y
LA0KPiA+ICsJCQkgICBtdGtfZHAtPmRhdGEtPmF1ZGlvX21fZGl2Ml9iaXQsDQo+ID4gIAkJCSAg
IEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9NQVNLKTsNCj4gPiAgfQ0KPiA+
ICANCj4gPiBAQCAtMTM2Miw2ICsxMzY0LDE4IEBAIHN0YXRpYyB2b2lkDQo+ID4gbXRrX2RwX3Nk
cF9zZXRfZG93bl9jbnRfaW5pdF9pbl9oYmxhbmsoc3RydWN0IG10a19kcCAqbXRrX2RwKQ0KPiA+
ICAJCQkgICBTRFBfRE9XTl9DTlRfSU5JVF9JTl9IQkxBTktfRFBfRU5DMV9QMF9NQVNLKQ0KPiA+
IDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIHZvaWQgbXRrX2RwX2F1ZGlvX3NhbXBsZV9h
cnJhbmdlKHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gPiArew0KPiA+ICsJLyogYXJyYW5nZSBh
dWRpbyBwYWNrZXRzIGludG8gdGhlIEhibGFua2luZyBhbmQgVmJsYW5raW5nIGFyZWENCj4gPiAq
Lw0KPiA+ICsJaWYgKCFtdGtfZHAtPmRhdGEtPmF1ZGlvX3BrdF9pbl9oYmxhbmtfYXJlYSkNCj4g
PiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwgTVRL
X0RQX0VOQzFfUDBfMzM3NCwgMCwNCj4gPiArCQkJICAgU0RQX0FTUF9JTlNFUlRfSU5fSEJMQU5L
X0RQX0VOQzFfUDBfTUFTSyk7DQo+ID4gKwltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLCBNVEtf
RFBfRU5DMV9QMF8zMzc0LCAwLA0KPiA+ICsJCQkgICBTRFBfRE9XTl9BU1BfQ05UX0lOSVRfRFBf
RU5DMV9QMF9NQVNLKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgbXRrX2RwX3Nl
dHVwX3R1KHN0cnVjdCBtdGtfZHAgKm10a19kcCkNCj4gPiAgew0KPiA+ICAJdTMyIHNyYW1fcmVh
ZF9zdGFydCA9IG1pbl90KHUzMiwNCj4gPiBNVEtfRFBfVEJDX0JVRl9SRUFEX1NUQVJUX0FERFIs
DQo+ID4gQEAgLTEzNzEsNiArMTM4NSw3IEBAIHN0YXRpYyB2b2lkIG10a19kcF9zZXR1cF90dShz
dHJ1Y3QgbXRrX2RwDQo+ID4gKm10a19kcCkNCj4gPiAgCQkJCSAgICBNVEtfRFBfUElYX1BFUl9B
RERSKTsNCj4gPiAgCW10a19kcF9zZXRfc3JhbV9yZWFkX3N0YXJ0KG10a19kcCwgc3JhbV9yZWFk
X3N0YXJ0KTsNCj4gPiAgCW10a19kcF9zZXR1cF9lbmNvZGVyKG10a19kcCk7DQo+ID4gKwltdGtf
ZHBfYXVkaW9fc2FtcGxlX2FycmFuZ2UobXRrX2RwKTsNCj4gPiAgCW10a19kcF9zZHBfc2V0X2Rv
d25fY250X2luaXRfaW5faGJsYW5rKG10a19kcCk7DQo+ID4gIAltdGtfZHBfc2RwX3NldF9kb3du
X2NudF9pbml0KG10a19kcCwgc3JhbV9yZWFkX3N0YXJ0KTsNCj4gPiAgfQ0KPiA+IEBAIC0yNjE2
LDExICsyNjMxLDMxIEBAIHN0YXRpYyBpbnQgbXRrX2RwX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlDQo+
ID4gKmRldikNCj4gPiAgDQo+ID4gIHN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhtdGtfZHBfcG1f
b3BzLCBtdGtfZHBfc3VzcGVuZCwNCj4gPiBtdGtfZHBfcmVzdW1lKTsNCj4gPiAgDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTg4X2VkcF9kYXRhID0gew0KPiA+ICsJ
LmJyaWRnZV90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCwNCj4gPiArCS5zbWNfY21kID0g
TVRLX0RQX1NJUF9BVEZfRURQX1ZJREVPX1VOTVVURSwNCj4gPiArCS5lZnVzZV9mbXQgPSBtdDgx
OTVfZWRwX2VmdXNlX2ZtdCwNCj4gPiArCS5hdWRpb19zdXBwb3J0ZWQgPSBmYWxzZSwNCj4gPiAr
CS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSBmYWxzZSwNCj4gPiArCS5hdWRpb19tX2RpdjJf
Yml0ID0NCj4gPiBNVDgxODhfQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJ
Vl8yLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBfZGF0
YSBtdDgxODhfZHBfZGF0YSA9IHsNCj4gPiArCS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5F
Q1RPUl9EaXNwbGF5UG9ydCwNCj4gPiArCS5zbWNfY21kID0gTVRLX0RQX1NJUF9BVEZfVklERU9f
VU5NVVRFLA0KPiA+ICsJLmVmdXNlX2ZtdCA9IG10ODE5NV9kcF9lZnVzZV9mbXQsDQo+ID4gKwku
YXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwNCj4gPiArCS5hdWRpb19wa3RfaW5faGJsYW5rX2FyZWEg
PSB0cnVlLA0KPiA+ICsJLmF1ZGlvX21fZGl2Ml9iaXQgPQ0KPiA+IE1UODE4OF9BVURJT19NX0NP
REVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kcF9kYXRhIG10ODE5NV9lZHBfZGF0YSA9IHsNCj4gPiAg
CS5icmlkZ2VfdHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFAsDQo+ID4gIAkuc21jX2NtZCA9
IE1US19EUF9TSVBfQVRGX0VEUF9WSURFT19VTk1VVEUsDQo+ID4gIAkuZWZ1c2VfZm10ID0gbXQ4
MTk1X2VkcF9lZnVzZV9mbXQsDQo+ID4gIAkuYXVkaW9fc3VwcG9ydGVkID0gZmFsc2UsDQo+ID4g
KwkuYXVkaW9fcGt0X2luX2hibGFua19hcmVhID0gZmFsc2UsDQo+ID4gKwkuYXVkaW9fbV9kaXYy
X2JpdCA9IEFVRElPX01fQ09ERV9NVUxUX0RJVl9TRUxfRFBfRU5DMF9QMF9ESVZfMiwNCj4gPiAg
fTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwX2RhdGEgbXQ4MTk1X2Rw
X2RhdGEgPSB7DQo+ID4gQEAgLTI2MjgsOSArMjY2MywxOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kcF9kYXRhDQo+ID4gbXQ4MTk1X2RwX2RhdGENCj4gPiA9IHsNCj4gPiAgCS5zbWNfY21k
ID0gTVRLX0RQX1NJUF9BVEZfVklERU9fVU5NVVRFLA0KPiA+ICAJLmVmdXNlX2ZtdCA9IG10ODE5
NV9kcF9lZnVzZV9mbXQsDQo+ID4gIAkuYXVkaW9fc3VwcG9ydGVkID0gdHJ1ZSwNCj4gPiArCS5h
dWRpb19wa3RfaW5faGJsYW5rX2FyZWEgPSBmYWxzZSwNCj4gPiArCS5hdWRpb19tX2RpdjJfYml0
ID0gQVVESU9fTV9DT0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8yLA0KPiA+ICB9Ow0K
PiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2RwX29mX21h
dGNoW10gPSB7DQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4
LWVkcC10eCIsDQo+ID4gKwkJLmRhdGEgPSAmbXQ4MTg4X2VkcF9kYXRhLA0KPiA+ICsJfSwNCj4g
PiArCXsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtZHAtdHgiLA0KPiA+
ICsJCS5kYXRhID0gJm10ODE4OF9kcF9kYXRhLA0KPiA+ICsJfSwNCj4gPiAgCXsNCj4gPiAgCQku
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZWRwLXR4IiwNCj4gPiAgCQkuZGF0YSA9ICZt
dDgxOTVfZWRwX2RhdGEsDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBfcmVnLmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBfcmVn
LmgNCj4gPiBpbmRleCA4NGUzOGNlZjAzYzIuLjZkN2YwNDA1ODY3ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwX3JlZy5oDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcF9yZWcuaA0KPiA+IEBAIC0xNjIsNiArMTYyLDcgQEAN
Cj4gPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfTVVMXzIJ
KDEgPDwgOCkNCj4gPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBf
UDBfTVVMXzQJKDIgPDwgOCkNCj4gPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VM
X0RQX0VOQzBfUDBfTVVMXzgJKDMgPDwgOCkNCj4gPiArI2RlZmluZSBNVDgxODhfQVVESU9fTV9D
T0RFX01VTFRfRElWX1NFTF9EUF9FTkMwX1AwX0RJVl8yCSg0IDw8DQo+ID4gOCkNCj4gPiAgI2Rl
ZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzIJKDUgPDwgOCkN
Cj4gPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBfUDBfRElWXzQJ
KDYgPDwgOCkNCj4gPiAgI2RlZmluZSBBVURJT19NX0NPREVfTVVMVF9ESVZfU0VMX0RQX0VOQzBf
UDBfRElWXzgJKDcgPDwgOCkNCj4gPiBAQCAtMjI4LDYgKzIyOSwxMSBAQA0KPiA+ICAJCQkJCQkJ
IFZJREVPX1NUQUJMRV9DDQo+ID4gTlRfVEhSRF9EUF9FTkMxX1AwIHwgXA0KPiA+ICAJCQkJCQkJ
IFNEUF9EUDEzX0VOX0RQDQo+ID4gX0VOQzFfUDAgfCBcDQo+ID4gIAkJCQkJCQkgQlMyQlNfTU9E
RV9EUF8NCj4gPiBFTkMxX1AwKQ0KPiA+ICsNCj4gPiArI2RlZmluZSBNVEtfRFBfRU5DMV9QMF8z
Mzc0CQkJMHgzMzc0DQo+ID4gKyNkZWZpbmUgU0RQX0FTUF9JTlNFUlRfSU5fSEJMQU5LX0RQX0VO
QzFfUDBfTUFTSwlCSVQoMTIpDQo+ID4gKyNkZWZpbmUgU0RQX0RPV05fQVNQX0NOVF9JTklUX0RQ
X0VOQzFfUDBfTUFTSwkJR0VOTUFTSw0KPiA+ICgxMSwgMCkNCj4gPiArDQo+ID4gICNkZWZpbmUg
TVRLX0RQX0VOQzFfUDBfMzNGNAkJCTB4MzNmNA0KPiA+ICAjZGVmaW5lIERQX0VOQ19EVU1NWV9S
V18xX0FVRElPX1JTVF9FTgkJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIERQX0VOQ19EVU1NWV9SV18x
CQkJCUJJVCg5KQ0K
