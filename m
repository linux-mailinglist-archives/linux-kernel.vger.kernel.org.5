Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30175A849
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGTHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGTHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:53:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4332128
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:52:55 -0700 (PDT)
X-UUID: 69666b0e26d211eeb20a276fd37b9834-20230720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gzTH4JAUYZJkMQSBXaOlJyntOm1fWWaMrTWJlG9JEPk=;
        b=CNbua/I2td9M+DUVHzCe7wlnknGpaOyZoBVjmXf6r3ra7p9M6A0bn6thxV3F0/pik2RlG1jiYhlI7A5Ckdm7AG65zODk4QsIl8p2tCi0jkTEmk7Ezb+vUCn78KlFB0JbMTBjb4AWe0p+PqQvC0AT0hInMnLoxk+TV6+F0Ekahto=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:cd95972e-3ed8-42aa-b681-79185808e45a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.28,REQID:cd95972e-3ed8-42aa-b681-79185808e45a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:176cd25,CLOUDID:70d3cfdc-dc79-4898-9235-1134b97257a8,B
        ulkID:230720155247FYZ4PZYG,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: 69666b0e26d211eeb20a276fd37b9834-20230720
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 922282141; Thu, 20 Jul 2023 15:52:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Jul 2023 15:52:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jul 2023 15:52:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWMtMgleCeWK9hkfXcZxNo15BRNxyfs0U5htH//0ZhhacVV2GqfMMbWaWsCK4Ai5z36Zr/YF7c/umRoZwTmdhRIYnofygR8ekeALjIHJCAh2g89A0X2atjNEef7hIzdXzfttQsq6qWrW1DpvW+5XHvPysdz91VlmHwhHHOFv2EjRb8KZB3TwSGpKI1MbGpp3lonssv4A4+SfopDVmBEjo/70LP6INerUaIoogheumIYBSpvJO9KYVe2bgLS/UuX+lZSlGLIcSQBtFjlQSAYK71+n6QaZFrsIBvu+e7E8X+Tu25fOOmKiw3OeRRM3Zej+Ut8Q2s9nkE1y3rDzWFG5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzTH4JAUYZJkMQSBXaOlJyntOm1fWWaMrTWJlG9JEPk=;
 b=UiWPHX+WhnoSs8JMeEXGPuupxC08hqqj14W9LU94Bgyemdzn5nLM7y0IhX69j9UE26JwPuK6VtoebPkunMLxmbmh003HcFAY/ERaEd5Bz7iQnH4MOHM8pEtWsPIwBnT/UcBm6mR17xKxemKDe1xyrGYAhPE7CovcWA0Sr+XsBzc9XhgvPvDaac57HfQFDHCYqqSDMzqEe4MSlROwt6gRE8sb/vvwvmrZqI+aNX0Ygr59pPEH8qNxBIlTD2ck3j2QmJiw6XWJ058iKNLa910YpWwUjLUS7mNxrRydF43s8QFC/egVt/gHIcwXw0bk/PyYA6IQsodyAjD2U22YyC27Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzTH4JAUYZJkMQSBXaOlJyntOm1fWWaMrTWJlG9JEPk=;
 b=u8p1ZCxTiLHFaouQ414g5TtiNmdAGhcXHcO/LcehqcqAgLnQAK8/SH3u9OfmBeRn2NmO9oP8q0itNW4FS98pJwwv3tDGnWsV/rm5joFobLYioVVUIcycX5oW/pmeszFAkaAG9J/h3lQyg/3xKsRCnOp9quMutNAVna9uNe2Js0c=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SG2PR03MB6660.apcprd03.prod.outlook.com (2603:1096:4:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 07:52:40 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 07:52:40 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Topic: [PATCH v2] drm/mediatek: fix uninitialized symbol
Thread-Index: AQHZc/dS0+UnhHpH9UKQpbsnSvSsEK+5gs+AgARbeACABPgZgA==
Date:   Thu, 20 Jul 2023 07:52:40 +0000
Message-ID: <7e1124a15395dbb6906c17e240e5011a4274a9b5.camel@mediatek.com>
References: <20230421021609.7730-1-nancy.lin@mediatek.com>
         <ae96299cffaacdbf51beae96e3a257c95a04ac95.camel@mediatek.com>
         <CAC=S1njEG2sV28XAWDw8FoQ0p5w=-sU4i+D-ESfapHMQC1ZW3Q@mail.gmail.com>
In-Reply-To: <CAC=S1njEG2sV28XAWDw8FoQ0p5w=-sU4i+D-ESfapHMQC1ZW3Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SG2PR03MB6660:EE_
x-ms-office365-filtering-correlation-id: f310637e-8970-4cfc-0b87-08db88f64af6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHPXN72VG1XHQlkgJ+sc8bxAexMpKBW3YTX2Kj2j3ppwGlJIOifjlXiIySNdJnmYXWD5pEAFRkK9DOl16RqC69l5xZ+KCmFzAJioTTQ+dIMiqaLSUikXT1EHAHpBqDWbVlohxrsHamicnCHyJyU71gHCVXqlmM+PDM0ojDo3b9AjEnU279yoGCd1+uWwgUN/JQsvdwyxWmmG6SfSLi7uX9jEm5zfJD0EEmc9gEnLPXdmNsoYl3z1i1zkdv4Ihq4fXnACdJm2AiBWjdrP/kSrwVOM3fHQAS4Dd38FkRviGtMrC/Z7eQ/UEYmMsVQAH7t6X3J5eY5Y8lxz2h3knnzCtva3Qv43xMq0qTdX7+fB07tvmKrsaQ7eLa9HvEuuhn1qlUKIyHd+susrXzZupvyvCQJbsA40QrQDzYjBAKt4hFGdiHJXSWAx+9Hb2RciADO5iYHHeTsaTtc6pj96AYfEBjbqtMMoKrqnedMpvkeBCeZ9tAe203BD5j0K8miD+a/ophI2QV5N+6YRHiuZ7o7C1mYv0bO7HL6mexgDHL/vNYQfoSmzS4IECp0URDoX0f93l757BMr0hF8OK1N52p3Jm0tS7Inb/sJ8v1jnA481r3cA6Nrrixa7SYvQDou/RbeVuk649Py5ZVp7eHO2zIKxct9Hau+5l2MthFJ+t2NokOg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(122000001)(38100700002)(85182001)(38070700005)(86362001)(36756003)(6512007)(6486002)(71200400001)(478600001)(26005)(2906002)(186003)(6506007)(53546011)(8676002)(316002)(76116006)(8936002)(41300700001)(54906003)(4326008)(7416002)(66946007)(66476007)(66446008)(6916009)(66556008)(64756008)(5660300002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blMrY2FNTS9ETnU3WEZBc3dMWnJLUXFzTXVXSlJHcjdpNmJnRGIvbm5MSlND?=
 =?utf-8?B?RG1FdHBpRjFWQm9YS3hraVdNcEtNZXVJUzhzbGpBKzkxOENqQXYyRjR0S3RQ?=
 =?utf-8?B?Nk9uMUNmbklqaGNSMlQ4Ky8yRjRzM3UyZEdEME1PT2ZselRLd1hYa3Zpakk4?=
 =?utf-8?B?UGsxSStLZGhJa2dzRWtFTVhqN2xwa2NzT2RQeXRqcVMwc1p2R2hld2dLelMx?=
 =?utf-8?B?akJGclNLLzZRV3JtdFYyZURrejJrRkFZd3ZDNWNCWUNacFh5TlROU3NWQ3ZP?=
 =?utf-8?B?MSs3MDNCYkRIMk54cnpISUJ5Ym16QkZlcHNIbkYvQkdpTFlzeWJJM01HZVgr?=
 =?utf-8?B?eDFLU1F2VTlUY2V3aVl2ckdoQVlocXhwbGJ5V3BHWXE5dkI4c0EvSWVRa0t4?=
 =?utf-8?B?N0VYTWJackNWQnY3eEZmWGlER2srVmExQXN2SGhqbmdleS9sUW92OGhjeDc1?=
 =?utf-8?B?VHpIUkdneC9TdzRMZmRUcEx2amY1WFhoZXNvd0hkbjB3MEV4YmV6eVozdC83?=
 =?utf-8?B?SUgrT2hyc2R6bWhlc2pvUU5nbDJPV2RNQlFOS2ttTjhKamM4UGFRVFl6Q1Vv?=
 =?utf-8?B?eTFhdU5EZnk0U1lrRjR6czhSOVV0VWppTWV1OFZLdS9aUDIyQUlNbC94M1k0?=
 =?utf-8?B?YzB4WTJ0c09vdlFvM2EwMmdraEd6NWpXTTRLS0gwTHdNMkVQblg2V0tVQ0lq?=
 =?utf-8?B?N0FrZFJ2ZCtMVlVhRWpZZzBmbmJJYSsxNmh3ZFc5MmJXOW9mSENFdHdjUHNh?=
 =?utf-8?B?MklIWkx6MkJTVndsbUpVS2d2TGNUYkc0ZXZRTGtaR3ROUmdxbzd4NEFFRVht?=
 =?utf-8?B?SWhYV0pYSVFJOUFPME5RVTRSbkVRZHZWYjV2NGJaMjJ0YVlVYTBGTElCUzJu?=
 =?utf-8?B?eDRPQTdCV2kza3h0Z2NRVVFIcm5Cci81emd0ajBKWEp6VXhvMnlObm1HUk16?=
 =?utf-8?B?aithcHJQTzFBQjhlQkVrT0dRbU1mVHNZOVZ0V29vY1pwRGl0SkJ0eGVGVWZs?=
 =?utf-8?B?SXhDbVliZW9wYjlqaWlhaEVhOEFnaktYTGFoc3o2aUJCQ3JqTWRKbWU5ejNJ?=
 =?utf-8?B?RFU1OEtRNHQ3Qjd4OGZzdjEzSmFRUURybkVVV282KzBTZEwvZHRlWEQxU2xS?=
 =?utf-8?B?MFdSZVBjMWpiUFZpVUZHY3E3SU9zK1pSNkRsZXlDZS9mWWhxTUpXdlJoWjRN?=
 =?utf-8?B?L2ZveCtDWGtuWkIwT1NMaThtYXlrOVpINmVHNUs0cnRwVUZSaEU1cW5lZ3RQ?=
 =?utf-8?B?MGI5Znc0aDNCQmlJL1lXV1ZXdlJveHR2WFhNZ2ZTRnVpMldPVUtwNjVqQWJ6?=
 =?utf-8?B?U0xTMG5KYnNxN0kya3FEOEFwcXFDazd1dmZnWUNVRS9OWWV0blZ0SjV2clBk?=
 =?utf-8?B?STdWWjNvMzhhTUpmTWZpaWE3REVPbGlCWUFFUzdqYXUzQUZPNEIrOVIxNjU5?=
 =?utf-8?B?UU9nazhCWFY1N29GUU5HaFJReTRZVlhCK1pkWVl2Q3g3TFBJaXBqelRPSGlQ?=
 =?utf-8?B?QTgzUTBORHpOdU15M3NPdFFSSjcrWVZKQ1UxK3pYV2VBSkhReXB3TGxvVit6?=
 =?utf-8?B?WEJGOGYrY2RldXFEMmhUbXZCbDM0MXdjU2pwSWNVSU41U0NCSmNpUHg1eTN4?=
 =?utf-8?B?cUJ4R0IyS2Vmbmp5WnQ4dEtuU3FXTnhXak1pS05WRGd1eEVRRlNDRWgvWHNo?=
 =?utf-8?B?cU9KdnZaMCswT0wybVhvdzdPWmQzcWw0TXlGbktYbG9ocEdrRkk4UU94ZVF0?=
 =?utf-8?B?ZWF4ZElzNkZwK0pXSlB2QWFKa245M1RMT2dnWmJqWnc0UGRXZzBtTy9sckd5?=
 =?utf-8?B?eHFXWHBqWlZMVkN4amxmTXZaVkhGVlhQSlFVbDc4R2hiZ09QWXgvaFdIZEhx?=
 =?utf-8?B?MTJLNkJMTlM5cThydGkzR2s0V0pyd29XRUIya3lDN2VwY0pSbTRJdnhSTU8r?=
 =?utf-8?B?eml6UzJQMThlWGltV0RuS3o5T1czaWNLay9wRURtbW16NUlaQVl0eVhuMHdZ?=
 =?utf-8?B?RU90M3BvemQ3MnV1VlJOZHpPUkFteG10RjdUcXRveUhnbm1uNTJ4N0poM09F?=
 =?utf-8?B?MFc3VWo5ak51RXF6VmNFaXFHQ3h4bVc3RG5BNVZ1YzZ6UTRCNzlMV1pPQkc2?=
 =?utf-8?Q?YIb1VpBmAECLVnu43n3EJC+ev?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB8D395E7828364EA4623A9A8163BC65@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f310637e-8970-4cfc-0b87-08db88f64af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 07:52:40.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAKnAXxU3APQIVeZGzJqv4xffQkGQKJKNzRva3NJ6RSnbPeMBVVZY6+npeS7A4ezOwO1un6oWFdVTaPj/ZOZpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6660
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZlaToNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDExOjU5ICswODAwLCBGZWkgU2hhbyB3
cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSBDSywNCj4gDQo+IE9uIEZyaSwgSnVsIDE0LCAyMDIz
IGF0IDU6MjfigK9QTSBDSyBIdSAo6IOh5L+K5YWJKSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEhpLCBOYW5jeToNCj4gPg0KPiA+IE9uIEZyaSwgMjAyMy0wNC0yMSBh
dCAxMDoxNiArMDgwMCwgTmFuY3kuTGluIHdyb3RlOg0KPiBzbmlwDQo+ID4NCj4gPiBJbiBsaW5l
IDU2NiwgdGhlIHN0YXRlbWVudCBpcw0KPiA+DQo+ID4gaWYgKG5vZG8pIHsNCj4gPiAgICAgICAg
IGNvbXBfcGRldiA9IC4uLg0KPiA+IH0NCj4gPg0KPiA+IFRoZSBjb21tZW50IHNheXMgdGhhdCBv
bmx5IG92bF9hZGFwdG9lciBoYXMgbm8gZGV2aWNlIG5vZGUsIHNvIHRoZQ0KPiA+IGNoZWNraW5n
IHNob3VsZCBiZQ0KPiA+DQo+ID4gaWYgKHR5cGUgIT0gTVRLX0RJU1BfT1ZMX0FEQVBUT1IpIHsN
Cj4gPiAgICAgICAgIGNvbXBfcGRldiA9IC4uLg0KPiA+IH0NCj4gPg0KPiA+IGFuZCBsYXRlciBp
dCB3b3VsZCByZXR1cm4gd2hlbiB0eXBlID0gTVRLX0RJU1BfT1ZMX0FEQVBUT1IsDQo+ID4gc28g
dGhlcmUgd291bGQgYmUgbm8gcHJvYmxlbSBvZiB1bmluaXRpYWxpemVkIHN5bWJvbC4NCj4gDQo+
IFRoYXQgc291bmRzIGZhaXIsIGJ1dCBJSVVDIHdoYXQgTmFuY3kgdHJpZXMgdG8gcmVzb2x2ZSBo
ZXJlIGlzIHRoZQ0KPiBmYWxzZS1wb3NpdGl2ZSBTbWF0Y2ggd2FybmluZy4NCj4gSG93IGFib3V0
IHRoaXM6IGdpdmVuIHRoZSBgaWYgKG5vZGUpYCBibG9jayB3YXMgZXhjbHVzaXZlbHkgYWRkZWQg
Zm9yDQo+IG92bF9hZGFwdG9yIGluIFsxXSwgcGx1cyB0aGUgaW5pdCBmdW5jdGlvbiB3aWxsIGlt
bWVkaWF0ZWx5IHJldHVybg0KPiBhZnRlciB0aGF0IGluIHRoaXMgY2FzZSwgaXQgc2hvdWxkIGJl
IHNhZmUgdG8gZG8gdGhlIGZvbGxvd2luZw0KPiANCj4gYGBgDQo+IC8qIE5vdCBhbGwgZHJtIGNv
bXBvbmVudHMgaGF2ZSBhIERUUyBkZXZpY2Ugbm9kZS4uLiAqLw0KPiBpZiAobm9kZSA9PSBOVUxM
KQ0KPiAgICAgcmV0dXJuIDA7DQo+IA0KPiBjb21wX3BkZXYgPSBvZl9maW5kX2RldmljZV9ieV9u
b2RlKG5vZGUpOw0KPiAuLi4NCj4gDQo+IGlmICh0eXBlID09IE1US19ESVNQX0FBTCB8fA0KPiAu
Li4NCj4gYGBgDQo+IA0KPiB3aGljaCBpcyBlcXVpdmFsZW50IHRvIGFkZGluZyBhIGBub2RlID09
IE5VTExgIGNoZWNrIGJlZm9yZSBbMV0uDQo+IFRoaXMgc2hvdWxkIHN1cHByZXNzIHRoZSBTbWF0
Y2ggd2FybmluZyBiZWNhdXNlIGBjb21wX3BkZXZgIHdpbGwgYmUNCj4gKGFnYWluKSB1bmNvbmRp
dGlvbmFsbHkgYXNzaWduZWQgdG8gc29tZXRoaW5nLCBhbmQgdGhlIGB0eXBlID09DQo+IE1US19E
SVNQX09WTF9BREFQVE9SYCBsaW5lIGNhbiBiZSBkcm9wcGVkIGFsc28gKG9wdGlvbmFsPykuDQoN
ClRoaXMgc29sdXRpb24gYWxzbyBsb29rcyBnb29kIHRvIG1lLg0KDQpSZWdhcmRzLA0KQ0sNCg0K
PiANCj4gWzFdOiBjb21taXQgMGQ5ZWVlOTExOGI3ICgiZHJtL21lZGlhdGVrOiBBZGQgZHJtIG92
bF9hZGFwdG9yIHN1Yg0KPiBkcml2ZXIgZm9yIE1UODE5NSIpDQo+IA0KPiBSZWdhcmRzLA0KPiBG
ZWkNCg==
