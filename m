Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94257D5F29
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJYAph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYApe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:45:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8363D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:45:25 -0700 (PDT)
X-UUID: c660ecdc72cf11eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X0BzzHG8NQWnBxabtoiRVOwy89coqF2xJqSH2KXgqh8=;
        b=hCvm8phC/qer2rf1Iv2ZSIEt9PML7l754sKHQaJ4kvxcUO7TCTWx6IaJ8x05rqu2aFANKvfD0JVQW+pdrwM5d0mBbJhmsThfsh+EeSXB0iqV+vqdQ1l0G8FsTFNPeAju2s1m2bJD9s3rRXl4qo5YjibdQBSn/7ZoY/Ig3Oo7Hoc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e72954a0-ffa3-40d0-a8f1-fa3213730f17,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:18e546d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c660ecdc72cf11eea33bb35ae8d461a2-20231025
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 872721125; Wed, 25 Oct 2023 08:45:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 08:45:19 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 08:45:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhKlBFIt+C5igYlaTv+yAYwo4nth8mIoudoaJjxp0oqAbD1i+yLumNX4tnpADc3kR9zN6VyYU9mqvYYItchehibd9u+7ZUm/Hr8HSh6ITc9MELE5SK7N1caV3iEpdp9qSQCsZbAYAyjk+1uy83Cbfncw5lNaIevDU9wKiTn1x+/Z4ptGwWU40uAK7G468ATS90KAH8RhMnU5dIERr0/kbzf1oT5qB+tOIiwJVCU/r0BMOa+XVcD9xHRZqlUtdK1XaE+j1D9VjhvaGHO6kgcFUEiwAAQHUtvBw+zey+ToyiPaFD1OzzfBroOZPPj7lKal59/EB3nLYyiOtNb61DFMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0BzzHG8NQWnBxabtoiRVOwy89coqF2xJqSH2KXgqh8=;
 b=Rm4BaRMz4yOkUPGpNPIfjzdhKAxyBp0VxtS+AmZca/3HV5rlcJjWUVaDMvuzkLVyemYeXwo2/WLKg3bAP3BBslpmi3cyI32IWyVOL9PJJjDF30TJO4Ie/BtzdS96hiGz991+LPQndQMhIsPewxH4Wmgsd/RZI4KX2yUVrmoIXX80X5pjhuxCqQwdM4HKZH5Enwy5j6k5+IBsITj0fOV0F7GKOHNcPIaEf91iHUnD+dK1GXOGpLN85swQ+elFXM0VAFpI5Lx98oYEm5dPrPzR/oiljVa+/JEZvNEUQQL8+dxmwKDSHKkirPpvSM5/AZ8wLNR2veAKarf4zxfUANX7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0BzzHG8NQWnBxabtoiRVOwy89coqF2xJqSH2KXgqh8=;
 b=S6kht7OB2GXho3WASBIsRg99blL8WAPF0RcdldcBpxVPQfDNjeuV2lIRk1/fGyfpXFl/he4hVRJ0nAQblqqSFOMQVdGWoDQMhQugBvi5IMUwp53aRI8ynfIk2e1l9v7p6J1/TzfXdIAoyQpfNGs29Q9bubp4Wk1Xxne13TNP3Ao=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB7383.apcprd03.prod.outlook.com (2603:1096:990:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 00:45:17 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 00:45:16 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
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
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 4/9] soc: mailbox: Add cmdq_pkt_write_s_reg_value to
 support write value to reg
Thread-Topic: [PATCH v2 4/9] soc: mailbox: Add cmdq_pkt_write_s_reg_value to
 support write value to reg
Thread-Index: AQHaBWq93xoxaVmyM0+kz9Q3ov3v7rBXIdmAgAKMWoA=
Date:   Wed, 25 Oct 2023 00:45:16 +0000
Message-ID: <890ecba19d19bf9d11e2a80c72cfedfcc88e3083.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-5-jason-jh.lin@mediatek.com>
         <44b27975-1476-4da5-8427-8b0dab81b0d6@collabora.com>
In-Reply-To: <44b27975-1476-4da5-8427-8b0dab81b0d6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB7383:EE_
x-ms-office365-filtering-correlation-id: 0760bc39-a135-40b0-9488-08dbd4f3a814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hot5+KoNiUVl/rIWKRHdq/1zj7S7vojywVneFmmfeZVRHNn/LlbTdrHAi1UoykNFTeQ7RxXUzvY29dGETd++ZkRO5UM1RspVk5KzMlwhXt0ywF4LeuiIEWxGsGGqtW+NRS3zqf4jw1JdPNsdEuz9FtaMIxtvdOPcZY1dkogI6ubfhCs3Pj/kNu/HcEj/Pp9SUBY2duoM/9co4EG2LqIYtSAeJW+nrrf0iFsau7i2aoZxMwOqK5sGx2Zd1zsh4XiHqoAscvZVGZW0Io/BZweU5+WfO8PDBTeIJxQQdxAggJ37ct/+Ed9YTKGL9Gy/BGYXKs5w0HQLX9dSt3StL/y6lHI4lk5zDnftGoNO5NYV8xgLb75PWvc7HyW8EeWqbw6TSVWVOltKfeIy9YFXGdLWi7YpgdKUGBgeN1MDs+uXOtenfIOel6KBpYCLgvDbrqE3abcmwJgj4q+5uwaXLqcZ8aXdHVK87vT9oUJI3uaPh93h5MjvKTR+Q8Ii1dewRXWAKJUQWxakHzxr4p9NrTq5W18IE5dXctYqM+KkksrZHIppiodogMIWHWAjYqagD4Fd3J4Q9ygn7WdJGSU/DIdMCEf1jPv9lti2gB8p7Irn/+cP2WtkWJpC5tvAGp4kFb2fwMduOXDbs3Ot+GX0VT9NxWAnoS6PHVNkLzFVng6Sric=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(4744005)(41300700001)(7416002)(122000001)(86362001)(36756003)(85182001)(4001150100001)(2906002)(38100700002)(316002)(26005)(6486002)(478600001)(6512007)(76116006)(6506007)(66556008)(64756008)(66476007)(66446008)(66946007)(54906003)(2616005)(71200400001)(91956017)(38070700009)(8936002)(110136005)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU9DbENFdkxoTE82QktGcjFva1ZRaEJSaDNSR09BR2hlOWhYSGZnWVlEZ0JD?=
 =?utf-8?B?RzhCbDMwRHZCdFNQMjRFdG8vQ0EzZDRURzNJaXgrbDBaNlZYQmloR1piY1ZE?=
 =?utf-8?B?ZnRBbGY1dG5yQURRQ1JxTll0M0VEYUhMTkdwREQzcFpDazgwRWRFZGtDd0Ni?=
 =?utf-8?B?S2F1VjlhRHo5eGU3U2M2MTlDcWFFVHJTd1l5cy9ZTGpNZmlaVFg2ZHpBaTRE?=
 =?utf-8?B?SFlHaTl4MFZ6Q3Exd1UzbXRpUkJsQTlWWWRsY2tpbmhSZlh6Nlc3cUxCdTZE?=
 =?utf-8?B?N2RmYUorM3ZQc3k4Y0E1ZGd5aUFPUUZxT096TUtJRWZ1TStFYUJoZDJ0QmJq?=
 =?utf-8?B?dm9aajl0VG1LdXRCTmdvOVR0bU5pUWd5L2RmUk80MXpuWGEwYUsraENIVlpn?=
 =?utf-8?B?YVlmZ1JsdDkvUjFtajc4OE5vODNQS1lCWnNhbTNGc1h1N2RvTDh4NkE0UGFy?=
 =?utf-8?B?eE1ZSTJ3UkpqVXI5RTkwZUV4UVBCQzc0Vnc3d2VuS05IMGI0QUhJbXc2MTdV?=
 =?utf-8?B?QXdIVFZIejJiU1Q5eUxEbGVkRmNHSW5uQjhObGF1ZFJGR3hhWDIrZ1ZYaGdz?=
 =?utf-8?B?Y0sxVE1ieGthU1NkSmNUYU0zOTZxcUVZYjZQV2JTdFZsMXhEUG1iKzFueHJT?=
 =?utf-8?B?QVRnSkpUUWZVb3diWWYzQlRlUnFEcDluK25jRDdpM04xZzBtUUprV2dlNkdB?=
 =?utf-8?B?M0o1Zys1Zi9rSW9hVC9xamV0WjdLdVBVVGRQWjdITnY3aXVqdDNML2orSGRo?=
 =?utf-8?B?OVQ1QmdOdENJaEJaaDRJZ2kwTkJnZ0JMWWJrK2dqdUxiS3lYdmhNQzUrcFdv?=
 =?utf-8?B?ZWRqeG85U1RZSjdPaW9uaVdRWW5lQ2NiTUNMSWxqbzViZ0Q5SG5BcVRSdG5I?=
 =?utf-8?B?QWhVZnFBTGRiT2pGV1JYWmcvcVY3d3FFKzQzWTZBSTRtSXRCeDZZR3EwbDVx?=
 =?utf-8?B?YWs2NFh6ZWxQRDVRYVczZ2djZkZlYnNnVEJUb0hYUkJCeDFrVHRxMGpJWHVO?=
 =?utf-8?B?RDc1emVJaXRscHMvUy9xV1ByQ0tjZjMxcGtuSUpscjVmN2tVTEV5TVpuRito?=
 =?utf-8?B?K1BDaTAzN1FPM0dVcEI0RGdGNEtrT2tiTVc2UURFS2t4SUFwWG1YdWJ2QXNz?=
 =?utf-8?B?NkFuRTNtZHorN2UxTlY4RDRraEFvZG41NjVZcExYb0tnU1Fwa0JrMzNjc05O?=
 =?utf-8?B?QVpFOVY2U0tsQnBlaHB2R3NwTW5nMDcrem8reEFvK1NXZi9rME1DRGZxRHZD?=
 =?utf-8?B?cUxtMzlLUmhqOGlrem9ybUw1Y1RqZUVHOXhXTU1FWnhOUkFIMmw3MXBQNndZ?=
 =?utf-8?B?MC85bW1XOHRGdWtQZU0vTFFuQ2UzUjdiSnYrZEt0VWVkRXRIRG83MnRYZS9Q?=
 =?utf-8?B?WVZjWW5QQlhWVXgvZDRscWdkNlkyY2VEQldWNGxJVmQybVdROFQ5ZHdYZHlm?=
 =?utf-8?B?VlQrR0szdUgzaVJFeUVNUnp0RVM0N0srejZkZG4zT1JpU0FvMnIvMlgrbUY0?=
 =?utf-8?B?WUxQbGJQWVRITEh3WEJlN3R5OUpxNFl5cVI2OEFUK0RRZVZNSXlDa1ZmcCtj?=
 =?utf-8?B?U0FlMmFoMjloYkNadE5DTEl6YVlhUDAwQXFxbVhIWnZWZ0E0RFRrbzZCUmlB?=
 =?utf-8?B?bnZFTk5nU1NCdDhYOEY5TEdjWDVucDF1cWhiRXRWbnNRd0ZrRnJBK2l3V1Jr?=
 =?utf-8?B?VDhwQlo2L3E4bDIxYXJFSjRvRHdmVnhTaUlWYWh4NkN2TkErdWkzZ1RtcXR1?=
 =?utf-8?B?dDhKYmVJRXV2eXlIZVliVjVLYTlyY2lybjlZeFdOOTNETlR1dXl5dVBpRmZR?=
 =?utf-8?B?OGc4Ni9lV3FkaEZFQ3huNkRSUnB1RGRSa0g2blc5d05nWFB1YS80YU9GNklG?=
 =?utf-8?B?L3VUd3J6aG9kVmRzZGRZN2RiR2NkUlJ4QlBkOTBPSzZ1V3J5clgrT3lmOUdC?=
 =?utf-8?B?UG11eksvNnJnalpGOHdMeWs5RllaaEQ4WXc1WkNrd1QxcUdlYndRR2djRzRr?=
 =?utf-8?B?UE1NZkdEUE5ManZzU3A5bGlYQzZ0QlBPcjIvK2tzRWtpVEZ1V0VUb1R3SG5B?=
 =?utf-8?B?RzlLNE5wbFQwRlNkYUZTSUZXVUZmTk9URWVwNEJTaXBIUGJFRjFtMFNHZ2s1?=
 =?utf-8?B?UnVlbG00ZDFpZVpXbXM4eC9yVklFRlBaUE55TURIZFRIbTFkeDN5d0Z0YW5M?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF149B10D8133340989B217624FAC8CF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0760bc39-a135-40b0-9488-08dbd4f3a814
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 00:45:16.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7tYPnstbXulYm7I9AFxca+kZUl6h+ckVYxsqRhm8ujvI3QNIoqDmCuthWwC83lZRMIN3N4dbMoiZObx3/jq/jUaN4Ox0yQjk3Sor9ei6WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAt
MjMgYXQgMTE6NTAgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyMy8xMC8yMyAwNjozNywgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGNtZHFf
cGt0X3dyaXRlX3NfcmVnX3ZhbHVlIHRvIHN1cHBvcnQgd3JpdGUgYSB2YWx1ZSB0byBhDQo+ID4g
cmVnaXN0ZXIuDQo+ID4gDQo+ID4gSXQgYXBwZW5kcyB3cml0ZV9zIGNvbW1hbmQgdG8gdGhlIGNv
bW1hbmQgYnVmZmVyIGluIGEgQ01EUSBwYWNrZXQsDQo+ID4gYXNrIEdDRSB0byBleGN1dGUgYSB3
cml0ZSBpbnN0cnVjdGlvbiB0byB3cml0ZSBhIHZhbHVlIHRvIGENCj4gPiByZWdpc3Rlcg0KPiA+
IHdpdGggbG93IDE2IGJpdHMgcGh5c2ljYWwgYWRkcmVzcyBvZmZzZXQuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAN
Cj4gUGxlYXNlIGZpeCB0aGUgY29tbWl0IHRpdGxlOg0KPiANCj4gc29jOiBtZWRpYXRlazogY21k
cTogeHh4eA0KPiANCk9LLCBJJ2xsIGZpeCB0aGF0LiBUaGFua3MhDQoNClJlZ2FyZHMsDQpKYXNv
bi1KSC5MaW4NCg0KDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg==
