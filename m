Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD54770E89
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHEHk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:40:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8034EC9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:40:51 -0700 (PDT)
X-UUID: 63a2f5be336311eeb20a276fd37b9834-20230805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QrySxCLiM5PmbzUtcXpV0+CTL4NMn3UiZZGythazpRM=;
        b=sPHlsB2+ExqbEBaMHRR5Hf285lRLxO0ou0kmoojuGlGTPE5cQMgSkOt1JVfztDQnQnG8vL67bCuTGFyF3HQVUTJv08zw1nICa//2fEnLoRqaqRnFCV8yNbBHm8FIi5Q/7RGu5uqHuE7tDFDmoEhBEGfAuj1czwVWCUnfVmp570U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:e374747b-2c86-40a4-bdf0-49d6bcb9e2c0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:e374747b-2c86-40a4-bdf0-49d6bcb9e2c0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:52342cb4-a467-4aa9-9e04-f584452e3794,B
        ulkID:230805154046XWNOLK24,BulkQuantity:2,Recheck:0,SF:28|17|19|48|38|29|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS
X-UUID: 63a2f5be336311eeb20a276fd37b9834-20230805
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1507765994; Sat, 05 Aug 2023 15:40:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 5 Aug 2023 15:40:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 5 Aug 2023 15:40:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6wRB2hZafgbaSMiiUgVIA0xW3MQ77Det23StxsWuobpyUrWQVz6NSlM4bblPa24Fm7cR9WwmN7B+FR9PPvfYdbTUbEX7LMV4yHPAPgh8/C4iKrYMe34ShAkSXtt2RhzlUE8Mkl4eBulRSt9K+hKGQtzb92VrXdJaZdRj/XDXwJ03/dhG+f9vIWR8yYwRh4V2n9Wohcyf51VrIKL3/p/eay7yO1x4X+IEj9KBj8b6vWJO2b/sZinOzsM99ph4OVT5VKGKj7k5EIqqfkwUNIQEy8DFu7qk/Z+y5Kgke5cxqnSPoBfFaKe5P1Kul4ds5LjYKLZgk04cUiwcSiqs/fODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrySxCLiM5PmbzUtcXpV0+CTL4NMn3UiZZGythazpRM=;
 b=VhO7Uib/m7MLsGcdLG1ftC9qUGcXSWEmYgLEDLCTVfIg6DkDUQ3mnXRH55NiNzqtoBKK9NS8LZ24CZb12Fvgt7BNL3frj++0YUu1N/nJR3FEItNZtt0pyMOPmObhzB2idcEiaPHyEjbXcnzvN33CnM6eXnNSj7qFzkBJahJWaLZ9VC7QcLLV2TOe1VwF4lIipYh223+jmByi7hkRS5EnmSwN0GJ+iX/tLTMdv7QIS1UiqCw2rUNa10/6lXCi5FP0eU7bxgphOeGVPSuezII8tJAoJZMN6H9kJ0cw818WQ7QS8jZitHeQdpiFMQPEYzsyz0CZQP4svMGKBL3TYNnzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrySxCLiM5PmbzUtcXpV0+CTL4NMn3UiZZGythazpRM=;
 b=oHACiVSlJijCh4bpkA8KMwuwpIMUzv4iM8EHYZdxlj64zI0LOG3Lx39AmHu99lKta/CXtb6QffkTSNt+8OUZJ+5e/ctTKNrFDXSK+w4m7/PG5N2FS0Lv1fPqYwoFA4J+wIKd3+cxODKgG+jFSaunvS1U289BG9txbVGEj7airII=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB6380.apcprd03.prod.outlook.com (2603:1096:301:a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Sat, 5 Aug
 2023 07:40:41 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.020; Sat, 5 Aug 2023
 07:40:41 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 4/8] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs
Thread-Topic: [PATCH v8 4/8] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs
Thread-Index: AQHZxVB7/ANm3oD/nUKBwjCDYvocnK/Ykc8AgALD0wA=
Date:   Sat, 5 Aug 2023 07:40:41 +0000
Message-ID: <afa85ed37c861e02255ff6c7bd56ab847fad957f.camel@mediatek.com>
References: <20230802144802.751-1-jason-jh.lin@mediatek.com>
         <20230802144802.751-5-jason-jh.lin@mediatek.com>
         <a0b5ab0a-4c2e-d14c-508c-09a981d7087b@collabora.com>
In-Reply-To: <a0b5ab0a-4c2e-d14c-508c-09a981d7087b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB6380:EE_
x-ms-office365-filtering-correlation-id: 313634b6-3486-454d-828c-08db95874502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8p5rplKcX7oc1rxNVpScwuywhVamHhyVYC67wUPtHx2mjKymWiFUkSjuDfEn2evNmmWZPictiakh7RhLkORpDKpHbzQu3ReZIGvLNroaQBvqLRE49dyEht0SbJWLovBL/RDC4dXpkrLlR7CO14iDR2gZD6uhx5ARz30fK568ofkaJVJvHClLInkbykOVP45mmJERr+6fPVb/l/lzB1t5xzPBWJJX0OYzoxVRs+gX5ZNVjh4aSEOy4rBF/RY0kX1YR8VP2pePOJFp5fM8LiRIkBVDC1mHwtL8kWWQoja8jDvgfqsogHs7B896xGGDJmSVZlDxDbtixsZsz37PKx3zx3139VPtEiHZ/qq0mD19Guj+7/TH8GoRUgDRQrTtneYR4Y9ZCW0HPPJQhIZoxsLCizDTEA/boOGsFJmTZGcCEJq+LoG4ELUYIpTD/Ava75nTiH/1Nt8lTXnEcZc7ktMoc2rPhMwP8/V1V+SskLWCVjrdFs7ivmRHDkqT7ZosMfqawhTe1RwzVxejGWqOfopJtByJy4xPq87/tPH9gUgxFeCHMjPqkuUrD6GmgX2j0nbbY6YmYKkiSIz+WSOc4URO10P76Ja/Sf0CXzG50ybW7GnjFn9MpLIUkYxLNiYQ5bRFrGIp72IL5iN8q8Kyh4IcDu0VAKnXVEHGlRFe/0PBok=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(186006)(1800799003)(41300700001)(6486002)(6512007)(38100700002)(71200400001)(122000001)(2616005)(83380400001)(6506007)(26005)(53546011)(316002)(110136005)(54906003)(86362001)(38070700005)(478600001)(2906002)(66556008)(66476007)(66446008)(64756008)(91956017)(85182001)(4326008)(76116006)(66946007)(36756003)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXV6THZLaktRNS9aNWdlMW42V0pOdXJnRXZpNDRhZ2NzUGMySmRNQzZjeUJx?=
 =?utf-8?B?WUxSUzVQcVFCZjYxRjFoZ3VwZUI2V25KWVZxU2RxaWNaVXBWeE8xVVgxb2Nh?=
 =?utf-8?B?VzdUOENUQkNyRnFJK0RwNzNDVFJVcGZpc0V2Zzk5dGdOaVZ2dTM5R3doUG5Y?=
 =?utf-8?B?NnZpdDVHN0dNa3E1UUJUalJmS0ZjUEZDSHg2OHZDQXc0ajJWbWJiY3Z6N1hk?=
 =?utf-8?B?WkU2Zk1zanBNVXJCUkF2VTI1SUc4ZXhJTitwVlIrU1lXM1Mzc0NJQWpNeVI3?=
 =?utf-8?B?anU3NDBOSDdGeGlSQWFQWitKNkRSUEpqTm1UN1AxZm9hMFJONEY0bytaTHRP?=
 =?utf-8?B?RmowVUVORGozWmZsaktvdldwOWhmT2YyWTdDN0diaU00RGs0SzZ6Q1ZKWEw4?=
 =?utf-8?B?WHpSZEtNbzlaelRhekF5QTFnQkZocU85WTNVdStjWWVFVDZOUk5xQnFFRE9q?=
 =?utf-8?B?a3A0QzdZNHR2U0lUUVZpYzk4bWZheVlSaHF4TVhqdzA3TUFIWUFrRGtqSWR0?=
 =?utf-8?B?dGlPeURXWVhCcE9OSFMrbE5rSWplTEhlOHZLSkpBVDY1UFpIUkM1TldFWVY5?=
 =?utf-8?B?QjMycCtwWDkxd012THFjaTdheTFSMllnNi94SElyOE00M2pRdnhwd2w5UGxY?=
 =?utf-8?B?K2xGZWpjMU4wRjJLdGFnWmZ4L1hiWkx2M1RjWm1yV0NpSk5tR09iRWlJdlcr?=
 =?utf-8?B?cUpPYUJWRmY5UjdXVXVKeEhzMVdITzl2THZ2QWdCdWF5UW1uVllVcmFySUhM?=
 =?utf-8?B?N2xrUUEyU0VPOHZZR3B3MEdadmVMMWIyemxTNk4weENweGVYeFNEL2V0WUQ2?=
 =?utf-8?B?SjQ2TVJuQ0VoNlBqTzBHSnJLajk2ZUdqaEViNGl0QUpOYWlpcmtTUDZuTExx?=
 =?utf-8?B?OG9XN1JuR1lyVjhPY21VZ25VMEpVTE9ySWdNVTl1dERWenZOT09hV0lLMmo5?=
 =?utf-8?B?T0c1eStPVVFKSG1nUlBIMVllYTF2eTRpYVNmK2xYUjdmK2hDeHZ3aVBqWm95?=
 =?utf-8?B?b21URkxOU0cwKzdZVnVUdmx3Q1NqK1NvTElHaG8zTUlHYzU1ZkZMS1I3c2xB?=
 =?utf-8?B?bzFSVjEyZldJb3N4M3FoS3drNjc1YXlMcmx4WlJzSHkzNjI5Z0ZDZ1I0cm5n?=
 =?utf-8?B?Z2FzVVFWQk9zT2VXQ1oyWmNpaWlEWWlGa3R0bkorN0VPb2pDa00zbnFpM2po?=
 =?utf-8?B?WHdJYWVkQmxKaGhNSXlWR0pqaU8yZkxLYm91cW81Y0tScDh5QWczL2ErUDJL?=
 =?utf-8?B?amM4S3R1S1ZZaUQ5alh3RkZIWXNQang1VG5GODhqWU80alVaQ3R1YXNhZFZO?=
 =?utf-8?B?VmYwa3dRNWtZc3lhK2tYUUlkOXlEdUtlN3oycFQwWnJCOHpMTEkvd3NjT1VM?=
 =?utf-8?B?QnBaYjc5M2NnUGd5NUR0M2htSk1jajFEeTZYOXBsNFdhb2JxTnNaSUpzN2VO?=
 =?utf-8?B?Wm0wUHFYVksrK0xibkl5Rkw3Qk50OGdIUk44WCtlbCt4ZFF1Qm9JUnlPMkoz?=
 =?utf-8?B?TVdRSDRYTGk4RWJlRHkrUnZWYjFaSENwNy91dXl3QU93WmxESU53T1BEaUJP?=
 =?utf-8?B?V0d2eERUVnpUaHg4aWJKUlk4ZGZCWGRHZ0NkdGpmei9UT0g0RUh1Zi9pcE50?=
 =?utf-8?B?bDlZUHFWUFZ2UDlPZGxTUEVob1Q0S1RGemxZdUtTR3Bjc1JKVFBQU1ZvQXoy?=
 =?utf-8?B?L2NVdGppWHdzcUloMHdKZVFHeHBWVmp4UUVQUTRuZG5rdGtjKzc3Z24rMm1v?=
 =?utf-8?B?NlVSOWJDTnl6aFl1MVFMaTVvRXJOUjJuV2NqRDVLdDhCZ20wUDN0cFEyMnBm?=
 =?utf-8?B?TlVIdmV4SzdTUjh5UE1RbGtUUHRpbFh1M09UMjBtKzB2ZnloVGlKb0MzUk5B?=
 =?utf-8?B?ZWpVVkRsNmNiMzM0U2R2QUZsZ2xZOE5UQWNMSnF2U1c5VUJVWjNLVDNkSlV5?=
 =?utf-8?B?c3oyeVZ3T09tcFNFOHhmRGJSVDR5UitxNVVublFOSDVNNFZscTdiOWxrd01x?=
 =?utf-8?B?VjZwWUVteXp4TW82NVZ3anI3SmNmL2lzZkQ0YzJmampxUHFtd0ZQcXVnYWhZ?=
 =?utf-8?B?Ty9tWXVPbTFpRFNNajUwUnpTOGdiUkN6aVdmTEh3LzJ2Zlphc2hBZFZIZUtL?=
 =?utf-8?B?eFBRMUhnNnl2c29HVkg1L0ovdFJtOEl1QytXVEc2NTRvMlo3alNwN3RIaEQv?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92F55A4F05E452479E5952D1517B62BD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313634b6-3486-454d-828c-08db95874502
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 07:40:41.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa2Yud3XCCXWLN0mceqBtGYvju0mtP/tYWVmVB4gPywEmkPI1eu2tQzT1D+O9AKXz7Ws2/OSe11DRbZE02ad3BdTQ2woqqrlI8XVMDQgKG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB6380
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW4sDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFRodSwgMjAyMy0wOC0w
MyBhdCAxNjoyNyArMDMwMCwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gT24gOC8yLzIzIDE3OjQ3
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gMS4gQWRkIGVuY29kZXJfaW5kZXggZnVuY3Rpb24g
dG8gbXRrX2RkcF9jb21wX2Z1bmNzIHRvIHN1cHBvcnQNCj4gPiBkeW5hbWljDQo+ID4gY29ubmVj
dG9yIHNlbGVjdGlvbiBmb3Igc29tZSBkZHBfY29tcCB3aG8gaGFzIGVuY29kZXJfaW5kZXguDQo+
ID4gMi4gQWRkIG10a19kZHBfY29tcF9lbmNvZGVyX2luZGV4X3NldCBmdW5jdGlvbiB0byBzZXQg
ZW5jb2Rlcl9pbmRleA0KPiA+IHRvDQo+ID4gZWFjaCBjb21wLg0KPiA+IA0KPiANCj4gVXN1YWxs
eSBhIGNvbW1pdCB0aGF0IGRvZXMgdHdvIHRoaW5ncyBpbiBhIGxpc3QgaXMgc3VwcG9zZWQgdG8g
YmUNCj4gdHdvIA0KPiBhY3R1YWwgY29tbWl0cy4NCj4gDQpPSywgSSdsbCBtb3ZlIHRoZSBzZWNv
bmQgcGFydCB0byBbUEFUQ0ggdjggNi84XS4NCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgOCArKysrKysrKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4gaW5kZXggZmViY2Fl
ZWYxNmExLi44NDI4YmFjYTcwZjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gPiBAQCAtODAsNiArODAsNyBAQCBzdHJ1Y3QgbXRr
X2RkcF9jb21wX2Z1bmNzIHsNCj4gPiAgIAl2b2lkICgqZGlzY29ubmVjdCkoc3RydWN0IGRldmlj
ZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ID4gKm1tc3lzX2RldiwgdW5zaWduZWQgaW50IG5leHQp
Ow0KPiA+ICAgCXZvaWQgKCphZGQpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG10a19tdXRl
eCAqbXV0ZXgpOw0KPiA+ICAgCXZvaWQgKCpyZW1vdmUpKHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IG10a19tdXRleCAqbXV0ZXgpOw0KPiA+ICsJdW5zaWduZWQgaW50ICgqZW5jb2Rlcl9pbmRl
eCkoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0cnVjdCBt
dGtfZGRwX2NvbXAgew0KPiA+IEBAIC04Nyw2ICs4OCw3IEBAIHN0cnVjdCBtdGtfZGRwX2NvbXAg
ew0KPiA+ICAgCWludCBpcnE7DQo+ID4gICAJdW5zaWduZWQgaW50IGlkOw0KPiA+ICAgCWNvbnN0
IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgKmZ1bmNzOw0KPiA+ICsJdW5zaWduZWQgaW50IGVu
Y29kZXJfaW5kZXg7DQo+IA0KPiBGb3IgYmV0dGVyIGFsaWdubWVudCBJIHdvdWxkIHN1Z2dlc3Qg
dmFyaWFibGVzIHRvIGJlIGRlY2xhcmVkDQo+IHRvZ2V0aGVyIA0KPiBhbmQgcG9pbnRlcnMgYWZ0
ZXJ3YXJkcywgbm90IG1peGVkIHVwDQo+IA0KDQpPSywgSSdsbCBtb3ZlIGl0IGJldHdlZW4gYHVu
c2lnbmVkIGludCBpZGAgYW5kIGBjb25zdCBzdHJ1Y3QNCm10a19kZHBfY29tcF9mdW5jcyAqZnVu
Y3NgLg0KDQoNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50IG10a19k
ZHBfY29tcF9jbGtfZW5hYmxlKHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gPiAqY29tcCkNCj4gPiBA
QCAtMjc1LDYgKzI3NywxMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiBtdGtfZGRwX2NvbXBf
ZGlzY29ubmVjdChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCBzdHJ1Y3QgZGV2DQo+ID4gICAJ
cmV0dXJuIGZhbHNlOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBt
dGtfZGRwX2NvbXBfZW5jb2Rlcl9pbmRleF9zZXQoc3RydWN0DQo+ID4gbXRrX2RkcF9jb21wICpj
b21wKQ0KPiA+ICt7DQo+ID4gKwlpZiAoY29tcC0+ZnVuY3MgJiYgY29tcC0+ZnVuY3MtPmVuY29k
ZXJfaW5kZXgpDQo+ID4gKwkJY29tcC0+ZW5jb2Rlcl9pbmRleCA9IGNvbXAtPmZ1bmNzLT5lbmNv
ZGVyX2luZGV4KGNvbXAtDQo+ID4gPmRldik7DQo+ID4gK30NCj4gDQo+IGl0J3MgYWxzbyBhIGJp
dCBzdHJhbmdlIHRoYXQgeW91IGFkZGVkIGEgZnVuY3Rpb24gdGhhdCBpcyBub3QgdXNlZCANCj4g
YW55d2hlcmUuIERvbid0IHlvdSBnZXQgbGlrZSBhIGNvbXBpbGVyIHdhcm5pbmcgZm9yIGl0ID8N
Cj4gDQpCZWNhdXNlIGl0J3MgdXNlZCBpbiBtdGtfZHJtX2NydGNfY3JlYXRlKCkgaW4gW1BBVENI
IHY4IDYvOF0uDQpJJ2xsIG1vdmUgdGhpcyBwYXJ0IGludG8gW1BBVENIIHY4IDYvOF0uDQoNClJl
Z2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiA+ICsNCj4gPiAgIGludCBtdGtfZGRwX2NvbXBfZ2V0
X2lkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwNCj4gPiAgIAkJCWVudW0gbXRrX2RkcF9jb21w
X3R5cGUgY29tcF90eXBlKTsNCj4gPiAgIHVuc2lnbmVkIGludCBtdGtfZHJtX2ZpbmRfcG9zc2li
bGVfY3J0Y19ieV9jb21wKHN0cnVjdCBkcm1fZGV2aWNlDQo+ID4gKmRybSwNCj4gDQo+IA0K
