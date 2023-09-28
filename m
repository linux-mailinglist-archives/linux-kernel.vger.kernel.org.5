Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6AA7B1355
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjI1GsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1GsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:48:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C0599;
        Wed, 27 Sep 2023 23:48:06 -0700 (PDT)
X-UUID: f7c1d1e85dca11eea33bb35ae8d461a2-20230928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JZ3lzCc7PlXX6cPojgDYoXnNiYZZGfKB0wjDCagkwIs=;
        b=okMbRyBCO9FTt8SC5vJ15ia4Xy5zS093RezALXOLlJrmo+R1zGh8isuZvIjmZavluyUHpnH+AiLPijPpvXzAcJF9GJ6nXevUTJ40/58ApWcH66Rw1/IH2npfiEamtM+fbFlrt06MNOnFY4j6AVSCb25TtvCsNCZKW8jcMKWICWs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:874db624-75d8-497c-a19d-753a85fa67cb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:91c97814-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f7c1d1e85dca11eea33bb35ae8d461a2-20230928
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1153070846; Thu, 28 Sep 2023 14:48:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Sep 2023 14:48:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Sep 2023 14:47:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkKNYX5RiP/nWcsk1WJ/aqQFbAcp07/Re6ovqCJ5/APAfoK9Y/rds3H0HIDFDY9zxEDe9u5S4+RTKwW7RSq729zUGGyPYfL/gR8I/pqNJvU1NkknIHyohglrodFlxkOm2xl4COo09JiAA+e43kC9ScJ3UjlBS4Jj1KTUbZy22m2x+P2GXdovHxtEsfkN986rSo3/ZHRsixvteOLaMPdj3MVD/ggWt5Kbv7ptKVwGak7RBgi2Qy3PLqBCcNLsmVRxY/ZSpp+KRop667ETYeVHgOOFEBdsO0WweiYKOReTuZIt7UeX0PmJxTbHRIl2Ki+N+BOXe9GG/ZaAa0kab3eKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ3lzCc7PlXX6cPojgDYoXnNiYZZGfKB0wjDCagkwIs=;
 b=jd5v9dIC7uZqVb/VZOjgpVnONtlv/W3YuqzsL31vfngDcG/C131g/qXCTuiEplCPT7A/CTBWLwl+DU6U1zMizyhzg9nDgqpkR6fIrt+MSeqyp7lSQvJcQdRRjrx9168FjC5+Rtz7KwqOE5Nhj1uDiKjjk01g1nyXTQCuW85AUjh4Ek6b2m0so9plY+XZvpvy6mcvLKl/XlIvb+ld9jwWev2X+7oZmnA2wxgUi4nlAmND+pYwSrprUCyIxe4PTp3TadFmI0baPBkV1x2tn8u9md3WLlWZIKHcMxLVfkQXYt4oZHiTD/GxHksG1K0k1ndFv0XjmwWYFkxysWas6vOvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ3lzCc7PlXX6cPojgDYoXnNiYZZGfKB0wjDCagkwIs=;
 b=ZP84bMxlmwq3L9HhyERHnBEQcATPuGfBoicSY34mhxJGsJWzVIMUsWe4HUSubRWL+UM3pw0xsF3VrrqRxlSROs0gu1qQIPFa7nC38Dw24bemLz1ZB7VMdM/7oTjVONE5OItfMlPitqacIOroIXd0Id8qQJWJTGUEAs+WSpiElBQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6815.apcprd03.prod.outlook.com (2603:1096:101:8e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 06:47:56 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 06:47:56 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 19/20] drm/mediatek: Support MT8188 VDOSYS1 in
 display driver
Thread-Topic: [RESEND PATCH v6 19/20] drm/mediatek: Support MT8188 VDOSYS1 in
 display driver
Thread-Index: AQHZ5IO+UxaXw/JOeUmaTSqbnKHRTLAv5mOA
Date:   Thu, 28 Sep 2023 06:47:56 +0000
Message-ID: <fbfc407213d2de1d781dc43f8cb2b4f3d67a67c8.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-20-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-20-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6815:EE_
x-ms-office365-filtering-correlation-id: 00a50b15-8706-4f7a-8d41-08dbbfeed8e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyjijdnZfBPCnQOrqZwUb79GLaMQpeOjcBtKDg1N7lxAKxCfy5djG862jchD5h8XEkeHM4yKz2sFNLAnr5sNbwPe/bTJ7U9xgrRA06BokQM0xEbQDCq8VdvmkMqD3q5vRFY75FhY6adVhyULkj+pPVIINf5n0t8dixcqRvOuL1n50YVW2/3j+m64T1LI1dbTTb488Ad9yvE1sWt6juTcVrz4kxV/PkQhh0E4rJFYA9AcefKSrvUqlw+DI+GzLLT87gltszsmEGB3IeqFEGhd8K1mTXekbcjy2p1+o3U3MIlwU1I99JlNFmrOQ00l02ZZyz7aLbnOKgTtKXD70b9RC9UFymPwQbGlnBKkgLL1ccbyCJPLgCM1M2asNjj1nvEtSgVtKB5BgmDLC0O54GMNDwpc4UYeibl8tB/Z5PeNxHrxJKtB5zFtIWF0mkfXA3+iRn8yPyXLXCtH2IJT6p66hHIF66miP+ydgd5k6SIfe0mZBTKX0Nngx9M7NMiyW09Bi5xVWe/Wnuo/S0YmtZ6jby0qjon9Y7tY03smNugDnH14D4WAL/Y5dlpqy8gc2CipicEHwz0blJmTHcKxDL9xvow43Ety1sv/oF5oT8Sg3tLwpsDzwGbYOa0a7fDGOpKe37Z3baueR8/5EHPSUfMZyab6RwILLjNPwNN/cAgs64s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(41300700001)(5660300002)(4326008)(8936002)(8676002)(7416002)(2906002)(86362001)(316002)(110136005)(76116006)(66946007)(54906003)(66446008)(64756008)(66556008)(66476007)(85182001)(6506007)(38070700005)(122000001)(478600001)(6512007)(36756003)(38100700002)(6486002)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzBOWUdZL1RjTVF5SlFXUkYwREkwR29HSlovTm5jZy8xejhjbndVWE9SRTRx?=
 =?utf-8?B?aDRxWWFxVmlnTUowNmxKOCtMWGREV2dsbWlUN2xKZDNqZTE3bWFWQmpkelJR?=
 =?utf-8?B?MEFXVGozWlJjaEN0K2dKTlQ5dGMzUjU0WC82OVhDY3NvYmx6ci91YnA4UXQ3?=
 =?utf-8?B?V0F0aVRmN09IQ3NVQWxaZzM2WitZaUNWdEg2NWdEaFNFWC9IU21NK1p1T0lO?=
 =?utf-8?B?Z3plRjZqUjUvY1p3NnB2Nm4remF4MCtMWHZvNkFEcWpKQkhFNWMrK0FIL0JW?=
 =?utf-8?B?amZqaU40U2NlTlR4Y2U4U0NqV2ZGejlmQjNHQVdMeks1Rm5ENWprOHVmMS9K?=
 =?utf-8?B?cW1lV1FOLytMTjAyZzBjTFZaVG1qMC85UjA1YjN6Y0FOeHNVd1lZdXFvbGFQ?=
 =?utf-8?B?UHRrUkpEUmN4OU12aVk1VmhXbC95NUw1SFdvWTFveC9nZW43VlZLMnAzY1Jm?=
 =?utf-8?B?M2NFM0hHWHRtam1Tb3Zod2dFdWpmYzBVR2lpSUhsemNQT0F4Q2NVdkdYaFJY?=
 =?utf-8?B?TG5mQXo4OFNnaXZzbnFrRm5Vb09zckhvY0VySVNTbXhvaUdYN1ZZY2g0cEdJ?=
 =?utf-8?B?KzY4cnBPaDhucFRQbkwrZ0JWaUxwTVRpdEx2SlFFNkJ2TXFGV0lQdXJ2T2Uw?=
 =?utf-8?B?TEdKQ2o2TmFkTWVuWEdxSnhCd05vQUFYZDFXUlF5dFFDQ3JVTHN2UWZQSFdF?=
 =?utf-8?B?V0MvZVZxTkQ0ZE5UZUZDNXBEZUJsWlhrcEFYMjBVem1QdlZSTWIyOXlJczVm?=
 =?utf-8?B?TDZPYTlGVlhlWEJWMU9GaXl0WEpPWW5yZTgydGtsK2dOTk5qTHVXbnAwQVJz?=
 =?utf-8?B?R2dGcWlDZ2FPay9vdGl1OGQ3QklXVmtWeEhZSEMrSkI1VFNPUlVjclpUY0hM?=
 =?utf-8?B?QVZWb2xYMnZzbFhqS0R3U3JJMGVpK2t2VXNvUVNic3Z5NCt3S0tLS0w2M1hm?=
 =?utf-8?B?S0lBV1BDKzdFMmVtMnpGakdNelp0SUNFUDNuaG51MTArRU8rRUdPK1ZWcVpo?=
 =?utf-8?B?ZTV6cE1PcXhCL25DK05KN05nQ1ZqcHZScWRJeDBMbnhDbnlPeXZWMk5YUGFO?=
 =?utf-8?B?TG9zK25LN0R4RThxb1FnUzM5QW5uQWxPSGR3U3ZWYWJvVVBuc3JhMmpoK3Ur?=
 =?utf-8?B?V3BZVlRVTVQvYmNrS3A1dzBrTnZYa1lZM3VLWkY2a2g3TVZ2NFZMRXNNMjZq?=
 =?utf-8?B?ODh2eUdFSk02Ync1bjlnTHFCTXY4WEtURFhEKzZqSVFCdkt1TE8vcFFVU1h2?=
 =?utf-8?B?ZHU3YnJCaDdneFA3YTVNOEZoVEovM2hBR3hUbmN2UVRDYmpoYWthVFIzeVBa?=
 =?utf-8?B?N2EreVg1L1dLMTBoR2JMMEd4elFEbXdzeFM2ZCtOWkNPVTQ5WmZHNHBUemQy?=
 =?utf-8?B?bDRFeGNwQ29zb0JXeHBsbWpNKzRoWlJmWXhVcmg4dTAybWNhT3RkUkd3elBZ?=
 =?utf-8?B?MjFKeUU3dUxmWFZBQXRDV0pYTFNGMDVuUEx2Q2V6cjFjL2hiVGFqR0RtUnBz?=
 =?utf-8?B?em1hQ3VaSzVqQXV1TWdWU0JqRlBOdzF0d2l4MmQwZ2tlQXpTeVkyYnEvczY2?=
 =?utf-8?B?QS92RkJWdDdTOE1PeTI1aUFyREhFdEVIaG43SmF0ZEkzK2FOcjFidnpPRExy?=
 =?utf-8?B?cFdEZ2FHKzluYVdvd3NaejRhK21JOERyMkdCakNDVCtIRS9Fc2xHME5VV29x?=
 =?utf-8?B?N3Q3TGNPUlNST0ZvbEpDTVFJRDNmSjJ0bjlDdTd6a2lTQ1JobVo1dEtTMml0?=
 =?utf-8?B?eEtEN1Y1RXJueTU0NW5sVVFIMVc3bHVMdFNzWXF0bm5pRDdpSGZUbi9qNXF1?=
 =?utf-8?B?M01DZWRSTkp5cGNPNjI3c0ZlbjdRWGdvclJlcDkxbDNob1czQjVVajRJNTRQ?=
 =?utf-8?B?b1ZVeTlWZ3IzUVJmVHRxK0tiN0FPQndUTm44K3JvTUhOV2FEdERPM1hKSDVR?=
 =?utf-8?B?b01kUVZQbDVCUlpNVGs5MkNhbmFZOHVkTjdaTVc0VzYrdmZDT3BmdmZ2M3VU?=
 =?utf-8?B?b3VkeWhCb0MxWnVZQzM1RDI1N1lCOXc0bW4vSVdOeXFFdktKbnM2VmRJOWNt?=
 =?utf-8?B?dk1HciswVWhvb3ZoQlVxZ05scS9nbzdCTTFIQmlKejhxZkFlTjhSc0gvZjRu?=
 =?utf-8?Q?/8HHds+SWr8zHyfzdTVemwRW6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F3B171F601E6E4DAEF38C17F0940025@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a50b15-8706-4f7a-8d41-08dbbfeed8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 06:47:56.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOxCdT05Uwxgk3oOIQvX4KOriaMIrwcWaEsnOA9Bkx9L7ZOx60DzJtiiQN6mB8vEPlbXXjR8dq8vu/LjaFpVSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6815
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.143900-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hc/XHdICuW5r97SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYApB
        bGrMo6JyTPMwViVb9SUzQez0qIntbRnsS71Oo/Hw1ilQ4KKAwrfpJe7BSAYfSKmHdZcXDuA+8oL
        zUWewXkhOFu8ssjxG82lMzgdmISFzXqbZn4+AZIsMH4SsGvRsA7n7V+KB+3cumyiLZetSf8n5kv
        mj69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7ChJgLj8aapYq6OM8FAY9s8ICzmovpevUIALf
        BNkjKijTniYlUdPySc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.143900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5D66AFF8336E609025CE968F444531AEB852B70CD4F4D770C12EA71B9BA2F78B2000:8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IC0gVGhlIG1tc3lzX2Rldl9udW0gaW4gTVQ4MTg4IFZE
T1NZUzAgd2FzIHNldCB0byAxIHNpbmNlDQo+ICAgVkRPU1lTMSB3YXMgbm90IGF2YWlsYWJsZSBi
ZWZvcmUuIEluY3JlYXNlIGl0IHRvIHN1cHBvcnQNCj4gICBWRE9TWVMxIGluIGRpc3BsYXkgZHJp
dmVyLg0KPiAtIEFkZCBjb21wYXRpYmxlIG5hbWUgZm9yIE1UODE4OCBWRE9TWVMxDQo+ICAgKHNo
YXJlcyB0aGUgc2FtZSBkcml2ZXIgZGF0YSB3aXRoIE1UODE5NSBWRE9TWVMxKQ0KDQpSZXZpZXdl
ZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bj
b2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5z
dW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRleCBjZGU2
OWYzOWEwNjYuLjIxMjQ3NTQzNmY0NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gQEAgLTI4OCw2ICsyODgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgxODZfbW1zeXNfZHJpdmVyX2RhdGEgPSB7DQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YSBtdDgxODhfdmRvc3lzMF9k
cml2ZXJfZGF0YQ0KPiA9IHsNCj4gIAkubWFpbl9wYXRoID0gbXQ4MTg4X210a19kZHBfbWFpbiwN
Cj4gIAkubWFpbl9sZW4gPSBBUlJBWV9TSVpFKG10ODE4OF9tdGtfZGRwX21haW4pLA0KPiArCS5t
bXN5c19kZXZfbnVtID0gMiwNCj4gIH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
bW1zeXNfZHJpdmVyX2RhdGEgbXQ4MTkyX21tc3lzX2RyaXZlcl9kYXRhID0NCj4gew0KPiBAQCAt
MzI4LDYgKzMyOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcm1f
b2ZfaWRzW10NCj4gPSB7DQo+ICAJICAuZGF0YSA9ICZtdDgxODZfbW1zeXNfZHJpdmVyX2RhdGF9
LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXZkb3N5czAiLA0KPiAgCSAg
LmRhdGEgPSAmbXQ4MTg4X3Zkb3N5czBfZHJpdmVyX2RhdGF9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTg4LXZkb3N5czEiLA0KPiArCSAgLmRhdGEgPSAmbXQ4MTk1X3Zkb3N5
czFfZHJpdmVyX2RhdGF9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLW1t
c3lzIiwNCj4gIAkgIC5kYXRhID0gJm10ODE5Ml9tbXN5c19kcml2ZXJfZGF0YX0sDQo+ICAJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtbW1zeXMiLA0KPiAtLQ0KPiAyLjE4LjANCj4g
DQo=
