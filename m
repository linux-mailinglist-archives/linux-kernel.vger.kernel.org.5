Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E397B16E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjI1JMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1JM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:12:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26768AC;
        Thu, 28 Sep 2023 02:12:19 -0700 (PDT)
X-UUID: 1bf284905ddf11eea33bb35ae8d461a2-20230928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xUiCPZU4xmAGFy8/JnL50MRcZgisJ4HmK7nEEcnt4ns=;
        b=LIEgANHtrJTwvItJxjwvl/QnANkhd0Zk1Lo+6CxlguMb4HsTonbgWqyHo+pdIwUp9RaKmmEUOZEafKPI2xuSehYmxS9bq9RiqYpqWoscsxvdPz5iOajqOnnr5SFkiDuP0pbgGx0p+qx3FmTrOuMlbYHsi6roYqoWJvnfqozLWzY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:bdaa925e-515c-4812-8f73-0e81b6de1e62,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:d3897a14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1bf284905ddf11eea33bb35ae8d461a2-20230928
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1542886467; Thu, 28 Sep 2023 17:12:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Sep 2023 17:12:11 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Sep 2023 17:12:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix948IBjb+zWKfO5d5DAX4u4PTeZjv54Dxvr/6KqISteY9piEhQM3WW1Bi4uoj7ItLcARcqE4jUheJRr3cCHwidJvdaO+IIYAbRDaCmQpuSD6mOEkEen5NsnV/8kOCTHdkkrYl0maKiBwqNjoAl1Aid6Zcbz9FE18716XnAlApYZ+ofpPyzLDS+I/L97T5D4e8OFUb6u9hzmFCkhjzdjHRw3SUkrVhBaWsKKh0JBWDYIaBxwN5ZbAfQx3+GfoCInfdZaBfRoM9bf29p7DWxLnDyIxOBtttGyLJRr/yXf/w2YfXkc5dbsZ0ngazZgWajcFsSqDYh/XesgVkMS+9rmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUiCPZU4xmAGFy8/JnL50MRcZgisJ4HmK7nEEcnt4ns=;
 b=Ks6D7jvF1Q2IFV4LwQL2Z2zj6UldbCNG5nQDAU9YG0Vj1iapAJV+a6MgRS1S/bEO8cEZudS/G2NS06P++itZVWnAAl8+nWq9rmko0FL9aUM7U2eMo/BG4b/KPtlDVdub+7xBgdmhoZRtuyyED5+7wyeSOOKY3McQtN1S1hetPKdQBBCBhrwYg9qQz+e1MHURPlQQm4NrMgcS/bRappOTC0Mv9x2LvDL53ggTYBrafWD9lhYsDSDymqDD7OdCYI70YNG6yOPLOOv78PPSm2r2ITLoC1JQZeLnFQfYSOCPvCD6ZRdIZTetIdkNZr6UhLwi67IWBnuhESBYG3JH7uYYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUiCPZU4xmAGFy8/JnL50MRcZgisJ4HmK7nEEcnt4ns=;
 b=gwXcKClAR6A/ZCOg5JgMYfmqZlWP1aviWuKzMHVxdRkeR2Dl9whxN40vH5oFCY2LZ5nJqs0GU8mxnKEsuBLnBX49Rhia1DllCwjVFSqCblZ55ENLJxup11oteSQP6lQLlvY8gJlH3iUVXORYLDiQAa2WmLqi8v97Dkff/0VHFAo=
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com (2603:1096:820:e2::6)
 by TYZPR03MB5728.apcprd03.prod.outlook.com (2603:1096:400:8b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:12:09 +0000
Received: from KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::e7dd:ae45:2b7b:24bc]) by KL1PR03MB7669.apcprd03.prod.outlook.com
 ([fe80::e7dd:ae45:2b7b:24bc%4]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 09:12:08 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
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
Thread-Index: AQHZ6qYEdO5WCsCYu0+t+bshYdi40LAjMCaAgADaFQCAAHclAIAA4IqAgAXpa4CABLcUgA==
Date:   Thu, 28 Sep 2023 09:12:08 +0000
Message-ID: <a20254c855ba761fbc7a03b9c8dc6625549ba4b6.camel@mediatek.com>
References: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
         <a0b32a1d93bc9d991f77ad3408fe7b177bb32889.camel@mediatek.com>
         <CA+ddPcNPeo=z42fG24uoSMJ8M0uWB-huzXVKBm-seG=7b+50JA@mail.gmail.com>
         <0f828842524f1518ccb6f75e6b34efd849466016.camel@mediatek.com>
         <9d6e628e1a420edf1106895eddeced7b9847ce8c.camel@mediatek.com>
         <e40245bbca67e3ca538d70d0ae9bb6eba3a7e1c6.camel@mediatek.com>
In-Reply-To: <e40245bbca67e3ca538d70d0ae9bb6eba3a7e1c6.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7669:EE_|TYZPR03MB5728:EE_
x-ms-office365-filtering-correlation-id: 5bdb9ca6-2af7-4cc6-f24c-08dbc002fe08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZNOII/oIybfWiET+XJj58LPvkstmf5i12dmmWSihNJ7La0kkYIjXa7R5YGrN2vhPPzaY6CZbACuApkPyimZfDuP2sSpEx4FZnOPaVCtrXtUz8KSmuAsu4S5A/wKwLeTm91X0nV+HVJcRvg3mIk63MaiZLSVrhzmw8Ouop/6id6SxdnZ1T3rDenKfYE9mo77VBDvcdtaur1cOeAYE8nTezEVAfgYQNQU/UonJw9whzPD60SoPFz2h4tkHBzhYqcmdnqZLvsHWwl6yn3A5ZY72J8ChddCIHs6ihZuUuVeMQUcMfETpqAS/muBHrTZRr5hH/zokJqWRELuwJFvM3Jj2EfqstJEr/7hTFGw+g3XuYplfKzAURGNI5BjqhFHWGofiFGqbMsio9zETTMmtyJyY1l0rS733i3olONZnCuGNEbLHLoEu9udUSBDmbkB90VQFgP6I7RekIS0jL/QHWJ+tRU4UVHOYhivkpgSGd0hiIC4ffwQCbQISmS0Cqv9BqNSZcmyiZzbQZhGum+JSoRtk8nIPKeb9Qj9Gl8LHj8inU2Lcy2Q6Xd2zxGSP0AQKfW2frAMYeVcmQY15bMcj91TZSQRVcizpRvN5JlVR8LkuzTPNgkB39eDv5xYDbU6R7DDmIgvA3YIhkHcDexaXEBaiA8TRdPHKsKGUN6jtxLUcYM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7669.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(85182001)(38070700005)(38100700002)(36756003)(86362001)(66946007)(478600001)(6486002)(66476007)(2906002)(6512007)(2616005)(7416002)(316002)(54906003)(91956017)(110136005)(64756008)(76116006)(66446008)(6506007)(41300700001)(122000001)(71200400001)(66556008)(5660300002)(83380400001)(8936002)(4326008)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5aaGVuMjZQQnBjTjlBU05obkQ1OWlMa0hIZnIxa0RXNmtraGFONi9oOGVu?=
 =?utf-8?B?RUZtRjEybXVVamtGd3dtNERnYkt3TnJ6ZFhUMjNudStQeGpkS0lmREpnSVdX?=
 =?utf-8?B?UEt2bVBXU2tkeTA2cFFITWZjbkVqbkswN2N2QTlUdlNlVUxGY3hTV2pSL3VI?=
 =?utf-8?B?R2lIZk1xZ1VtMHJEVCtpdVRvSWgrNzdTaEN3R1ppcVFmUkNzSTJCcVk2dkNs?=
 =?utf-8?B?TTlxc0VBSGlhY3k0Z0svNE5iMHJ1M1RjN2NtN2NXNGJsb3ZXT1lpajZJS1Yw?=
 =?utf-8?B?NjhoUEZ4S2RHdm5JNE9nWkdjOHVqbHk1ZU10bWJlMG5VMkFDSEpsNi9zWXZm?=
 =?utf-8?B?eTM3TDg0b0Yrbmc5TUNGbnlmS0dpY3lRMndEY3VaWG5XSHNycG9GRXByT1p4?=
 =?utf-8?B?aXBQYkhpM0hXdnRPQkxmTFpJM3hldUduQXZ3eTNNSWZjc3BOckNxWkZ2RjlK?=
 =?utf-8?B?eEtkYVBMb0dTNk92QllYblo3RDF2YTZQeDI3aHU3LytQZWt3cThabDh0T1RQ?=
 =?utf-8?B?M1RWTjBMTGVUb1BzakF5N1kxeC9ubmpjZWpvMHc2YXpGVDc5VUQvU3VJMkhB?=
 =?utf-8?B?TGdMYWVGUldXVXJubVU2TVEyVEk2RG1IUFByUTFYZEE5Q2lpNXJUWTg1WFFI?=
 =?utf-8?B?alpoYmdsNjg5S1JyL0IxRERHekVoUm54ZDkwNWZCOEtRYTFEL0NpQUVSWDJw?=
 =?utf-8?B?VVpsSEcxMG1TZG9DemRpZTF3UWJUNHJ1bm92VEtteitGa1Fock5ZTHZWZHdE?=
 =?utf-8?B?N1UxMGdTZmxXcHNBQURleXlCclNlUlRyUWZOTXNwZ1V5WkJhS1B5NS8vMlcv?=
 =?utf-8?B?eWVuYXM5a0hIbmo5bTVkb3lrTTVvN1o2QlUra085UXN2b0VoRjcrNSs5dHpE?=
 =?utf-8?B?NFp6N0RtKzlkNjNyN25sc0tGMHVIU1Q4clp2TGxDZUVRbFZPY25RaitETEFm?=
 =?utf-8?B?blR0d1phLzJnZjRDY3ppTS9LQm4zcS9BMlVuNkozU2g0V081MzhHVkR4NU14?=
 =?utf-8?B?NHJ3SmxZUVJIT0NjZlFORnRHVFRxMlFFSWdlQmhWRk0rc3VTSVR4enVtWk1q?=
 =?utf-8?B?dDVSTWZvRnJUU3R4QWxmTng2OTRYRUxseDdIcXJmc3JJbXowNHJ2VlFDdXNR?=
 =?utf-8?B?N0oxS2UwVFJWTk8vbk5iYXZHemNXRWFRS3BoVU80cXI2ZnBhSWF5Y0lQdndq?=
 =?utf-8?B?eC82elJyR3hsdExuYmd4bnVURmNUa0J6YWUvdmpaU3hnWGdiQUUya0loR1Nk?=
 =?utf-8?B?aHdnRzdsaEdNSk85NXdYL0VyOFkzN3ZzWTdBTUZwYVo3dDIwWGptUkVqRDZx?=
 =?utf-8?B?ZTJRZWRjNmZFeVJTWVlpTHpFYmNqMjZmY1BpNWlNUm93V2xTRkVMYWQvc29Q?=
 =?utf-8?B?UzFwWlNzTmgxSzB3OUVtU2lGK0cvSm9COGRWdHlreER3N2FvMUdneDk3TDFh?=
 =?utf-8?B?cUxlTTUrSStpWGZBQ095aXpwbjNDN3ZmZmhaSFgyekZqSHR3dEhNQ0Y5eXJ1?=
 =?utf-8?B?cWFwMGIwK0VOT2Yyc2FZOFhXeVR6RHMvVy9Rbk90aTNTWEhRL2VDeERzSXR2?=
 =?utf-8?B?N2RhS0FxcExsVGQyTTVuL0I3akovczdOQ21OYVFqU3dKRkJucmMxUlVoV3Bp?=
 =?utf-8?B?MWYrOGs1K3lyK2FpaUMrbzlBZXh2WFVtMG0wSk14dTlhR1RmV1pIaWVQYVcw?=
 =?utf-8?B?WFVjM0RUbHZpVmF0ZVZHMVoxNDIvUHJqMnJTNUdackNhVDNmdWJqS1RtcmJS?=
 =?utf-8?B?TUdtV2JwRjFpdHdJdjQzYzliK29uK1lDYS9Fd2ErcysxR3JaQVV0WUpONnl2?=
 =?utf-8?B?OFluTjhMRXBIVC9BZXJFYW5IaTBsT25ZN05TbkVxUjA2NHYrajdhTW1GMnZW?=
 =?utf-8?B?NXBZR3EyUHRSUlRETW5GaWh2ZnZkbWwvWm9sZWw4ejV0dFdsQzNBOWkyVlRS?=
 =?utf-8?B?LzRPUGFIN0dpOVpNbkFLVlhnbHJIejY4STZtNTI1K2FNUXg0OUxxeDBlcWNs?=
 =?utf-8?B?KzUyMEY3b25ZVnVJZ0tVeXJSZGhzelFxaUc0bmJnTi9ycXBrMkkvcEZpakVk?=
 =?utf-8?B?bEM5Si8xcW12TEpoWTZTMmNENmRiRENKUURDZFdabGYxaENMeDg1alRPRFhD?=
 =?utf-8?B?WmhCUDM2WkVocVQ3U2QwclBzUG5Yd1VIbmNibzFGYzIzRGNTdHd0Rk1tQXJ4?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <189D29098A09D44D9B5066BD3BF87F38@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7669.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdb9ca6-2af7-4cc6-f24c-08dbc002fe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 09:12:08.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8zeSGk9Js+2VNLt8LHzjuMCzppxaFe6FodiLT37kcur+gUIGj8c5WkkFArB9mGnfSeewXx5BGxyAuUgK2+Q7GOaOAI7553cw6P6Se1o0dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5728
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCltzbmlwXQ0KDQo+ID4gDQo+ID4g
V2UnbGwgdXNlIGNtZHFfc2VjX3BrdF9zZXRfZGF0YSgpIHRvIGJyaW5nIHRoZSBzZWN1cmUgc2Nl
bmFyaW8sDQo+ID4gc2VjdXJlDQo+ID4gZW5naW5lIGZsYWdzIGFuZCBzb21lIHNlY3VyZSBtZXRh
ZGF0YSB0byBURUUgd29ybGQuIFRoZW4gd2lsbCB1c2VkDQo+ID4gdGhlc2UgaW5mb3JtYXRpb24g
dG8gbWFrZSBzdXJlIHRoZSBwaXBlbGluZSBpcyBzZWN1cmUuDQo+ID4gDQo+ID4gV2UgZG9uJ3Qg
aGF2ZSB0aGUgc2VjdXJlIG91dHB1dCBmZWF0dXJlIGN1cnJlbnRseSwgc3VjaCBhcyBXaUZpDQo+
ID4gZGlzcGxheSwgc28gd2UnbGwgZG8gaXQgYWZ0ZXIgd2UgaGF2ZSB0byBzdXBwb3J0IHRoZSBm
ZWF0dXJlLg0KPiA+IA0KPiA+IEFsc28gdGhlcmUgYXJlIEhETUlUWF9IRENQIGFuZCBEUFRYX0hE
Q1AgVEEgd2lsbCBjaGVjayB0aGUgSERDUA0KPiA+IHN0YXR1ZQ0KPiA+IGluIHNlY3VyZSB3b3Js
ZCBhbmQgdGhlbiBDTURRIFRBIHdpbGwgZ2V0IHRoYXQgc3RhdHVzIGJ5IGNhbGxpbmcNCj4gPiB0
aGVpcg0KPiA+IEFQSSBpbiBURUUuDQo+ID4gSWYgQ01EUSBUQSBnZXQgYSBIRENQIGNoZWNraW5n
IGZhaWxlZCBzc3RhdHVzLCBpdCB3aWxsIGluc2VydCBzb21lDQo+ID4gaW5zdHJ1Y3Rpb25zIGlu
IHRoZSBzZWN1cmUgY21kIGJ1ZmZlciB0byBtdXRlIHRoZSBESVNQIEhXIGZvciBlYWNoDQo+ID4g
ZnJhbWVzLg0KPiANCj4gWW91IGVuYWJsZSBzZWN1cmUgcGF0aCBieSBjcnRjIHBpcGVsaW5lLiBU
aGF0IG1lYW5zIGl0IG1heSBiZSBwcmltYXJ5DQo+IGRpc3BsYXkgaXMgc2VjdXJlIGFuZCBzZWNv
bmRhcnkgZGlzcGxheSBpcyBub24tc2VjdXJlLiBJbg0KPiBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dDgxOTUtbW1zeXMuaCwgdGhlIHByaW1hcnkgZGlzcGxheSBpbnB1dCBjb3VsZA0KPiBiZQ0KPiBy
b3V0ZWQgdG8gc2Vjb25kYXJ5IGRpc3BsYXkgb3V0cHV0LiBJcyBtbXN5cyBwcm90ZWN0ZWQgd2hl
biBkaXNwbGF5DQo+IGlzDQo+IHNlY3VyZT8gVGhlIHdob2xlIG1tc3lzIGlzIHByb3RlY3RlZCBv
ciBwYXJ0aWFsIG1tc3lzIGlzIHByb3RlY3RlZD8gDQoNClZET1NZUzAgaGFzIDIgcGlwZWxpbmVz
IGFuZCBjb25zaWRlcmluZyB0aGUgc2NlbmFyaW8gb2YgdXNpbmcgVkRPU1lTMC0wIA0KYXMgc2Vj
dXJlIGFuZCBWRE9TWVMwLTAgYXMgbm9ybWFsLCB3ZSBjYW4gbm90IHByb3RlY3QgbW1zeXMgcGF0
aCBtdXgNCnJlZ2lzdGVyLg0KDQo+IElmDQo+IHRoZSB3aG9sZSBtbXN5cyBpcyBwcm90ZWN0ZWQs
IHRoZSBub24tc2VjdXJlIGRpc3BsYXkgcGlwZWxpbmUgd291bGQNCj4gYmUNCj4gbWFsZnVuY3Rp
b25lZCBiZWNhdXNlIHRoZSBjb250cm9sIG9mIG5vbi1zZWN1cmUgZGlzcGxheSBpcyBpbiBub3Jt
YWwNCj4gd29ybGQgYW5kIGl0IG1heSBhY2Nlc3MgbW1zeXMuIFBsZWFzZSBkZXNjcmliZSBob3cg
dGhpcyB3b3JrPw0KDQpGb3IgdGhpcyBjYXNlLCB3ZSdsbCB1c2UgQ01EUSBQVEEgdG8gYmxvY2sg
dGhlIGludmFsaWQgaW5zdHJ1Y3Rpb25zIGFuZA0KcmUtY29uZmlndXJlIGN1cnJlbnQgbW1zeXMg
cGF0aCBtdXggcmVnaXN0ZXJzIGluIGV2ZXJ5IHZibGFuayBpbnRlcnZhbA0KYnkgR0NFLg0KDQpC
dXQgd2Ugc3RpbGwgaGF2ZSBzb21lIHdvcmtzIHRvIGRvLg0KVGhlIG1haW4gaWRlYSB3b3VsZCBi
ZSBtb3ZpbmcgbW1zeXMgY29uZmlndXJlIG9wZXJhdGlvbiB0byB0aGUgQVRGLg0KVGhlbiBwcm90
ZWN0ZWQgdGhlIHdob2xlIG1tc3lzIHJlZ2lzdGVycyBieSBEQVBDLg0KU28gbm9ybWFsIHdvcmxk
IGNhbid0IHdyaXRlIG1tc3lzIHJlZ2lzdGVycyB3aXRob3V0IHBhc3Npbmcgc21jIGNhbGwNCmNt
ZCB0byBBVEYuIEFURiB3b3VsZCBjaGVjayBtdXggY29uZmlndXJlIGNtZCBpcyB2YWxpZCB0byBj
dXJyZW50DQpzY2VuYXJpbywgdGhlbiBjb25maWd1cmVzIHRoZSB2YWxpZCBtbXN5cyBtdXggcmVn
aXN0ZXJzLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENL
DQo=
