Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4379B7D6527
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjJYIbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJYIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:31:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBDA12A;
        Wed, 25 Oct 2023 01:31:30 -0700 (PDT)
X-UUID: e1947802731011ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mOXP3NVZsCHY08iV6UDwkaFbWntMy6MPAk3cKG5o/WA=;
        b=YnNN56wopC4NlsuJpCE39OtLbXH2K7TH40fFsZSkCG9tmO+zj89nVwTrjZ5xGVRLR6nntjgazEXq/L6Rxp6W0NtQYwfbKbDrXjHs38sya6sK+/JEouuGmCVfa6cN45fUmJoaGwRvY9SityXjkrWTRACXBh6ljVhimuZOvSLNIUQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6150662f-3f25-4a5f-94a5-e35dd18a2df5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:3c8dc0fb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e1947802731011ee8051498923ad61e6-20231025
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2021858614; Wed, 25 Oct 2023 16:31:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 16:31:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 16:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbGHC1oCFZ74uUCbK+DwXHv88i8hyFxHpYH9373zcg/d6jD/r6GyxuzIMrgq38YC6zLPNXGaLBcMztW8eP6CYEbBz3Xq34mI8Essy5iUZ9gvRMFV7q/jVojshOoWKPIMVSnEDarBT9yxWC1nTT9GWBKHKhn+J1CrUsdNh79UiEZ7PpubLVmTOatLEnM3Pf5PCjkR1a26z4XGU3GnpE3GCgEdjv47BgOr/Gjx0yPAyzItSF5XldcPH9FrZs5f7HUfRPAjBegjcFLnYnNNxRYZ6QCOgErwZPxqgz9sNvXqZdstIDPbhO7QpVFl6SJwBn0w+gqIg704CF6VsB+2O2a+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOXP3NVZsCHY08iV6UDwkaFbWntMy6MPAk3cKG5o/WA=;
 b=NGSgeA0fdp48B8NOOVnoV8ueyqsLZi9jwO9ZFenwQHUV2nxNnyI6VGFBIJkSVD6lyRTlqi0kXgvt2pPC8f/HuKKxGHH+2R7+DEjGd+87jyHa92lga9l73P1MX3/ZigE4P4WZoBpkiCtaQBZ6LbNSNbjhtbiYWra0yCqrvZSEspESAQKPIptOWm4FKebb6ULlzfeRRXlfrI9c+ISHre4/tHVhheslYKRDrk0PaqYPOqzxvZspqo7lW88LFyudkvsY6frTqH3Bi2UMfAqPGx7OpEgJHHmi0NKZXXgHoynz8FeugNZ2LIJHbJGvIESYSuhqDD8NUs6IWGMEi1IGAyOxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOXP3NVZsCHY08iV6UDwkaFbWntMy6MPAk3cKG5o/WA=;
 b=G88/XlE5IusCeDj5G0jqLheryuE6QbT/bfdBFCbvrElBD0ZICZCKYEEZlPw5OiNGQDNPAp77QkXJjdWokuwdFE4rt5LqLir6VluF6N7GalfErzn7EQsFmWk7bF0sH80irlyvQleKUzr2xZfmakUr8Rt6x9rpY8simHi8lWXZHvU=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB6895.apcprd03.prod.outlook.com (2603:1096:400:288::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:31:20 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 08:31:20 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v2 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaBWvxkYcM1loCq06xiO/urU0GrLBYkGAAgAGgCYA=
Date:   Wed, 25 Oct 2023 08:31:20 +0000
Message-ID: <96d97143f287718c596657589fa651797c6298bc.camel@mediatek.com>
References: <20231023044549.21412-1-jason-jh.lin@mediatek.com>
         <20231023044549.21412-10-jason-jh.lin@mediatek.com>
         <e89c5a96219f60650829e51063af7c31dec0e796.camel@mediatek.com>
In-Reply-To: <e89c5a96219f60650829e51063af7c31dec0e796.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB6895:EE_
x-ms-office365-filtering-correlation-id: 4fce9cc4-3fd3-4c30-a149-08dbd534c3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOYmyLuJByTkcnnWCe8JoOQn8znhZQCNetZQwDICZkav6pgab8JFJSQciXi3k0CU2nzfTpxvFHHl1gd1x5P3mnKbjB27rB1vz6rR2VNex5q4I7xVj1MQVCMWgbLn7j7sqM2CORMtYvCnQb/MJdKDJOjl8FKxYvoo3ksSldIf4qNj43E724eGF5rUM8M/ZyNF/StNcaZDR5XZGa/c+/hCfaUj1Sj+m3ZfuS6lwvwZSbqAcBXBKxO55IzbpbDvAdzlwYzLRQ0VFGMxS01Xwk6xaBFxzfIrPyjho/ttGjfVmAkqMP6vWKfkMK/VL7f3fcLJmmSZiXkmKLojWmIvhag4UdHZJygD5LeMfGvrJcoVePCbeC55XmOnURLqQcxuJsQhx3Cq2QuDWZ+1ZpQkbHr1/kjCjfo94P6Ju/l0Drq+2uteY4cPE/6OLCZ9YeMGqjqQOu9zGlhWwHCw/cCfDWZnAgVWfga2X8IB/VTNPFscITX9dpgUYMFO/KVbLEW4Yk70hoNPlJMkgZ84YvHHja1C0Ak1ji8HeTgSNkeppCOGxfe8qTCMMW6Tbk5dJ8I7drljLwGnsjoMy8LnxvT1lIu9KTMbrP/OP4PD+volpbdrSJt4pZ3u5BtmcCYrl8EC+HKSOm28QZcX6/5nfIz0SuFTuXtphNTQCdaoP+Nl8tILzR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(71200400001)(4001150100001)(83380400001)(8936002)(7416002)(85182001)(36756003)(2906002)(26005)(8676002)(2616005)(122000001)(38100700002)(4326008)(76116006)(6512007)(6506007)(316002)(478600001)(6486002)(5660300002)(66556008)(66946007)(110136005)(86362001)(54906003)(64756008)(41300700001)(66476007)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a09wOHU2bTdUUTlrZk5JcHF4bkJoWlFuQkloVTAybTlYWHYzVmFSeVNYcGZB?=
 =?utf-8?B?NFVSaFNQeEhVeCtoMTU2TC95WWp5eTN4YWlUbHJSQm1xbE0xd1pIbitvTUlE?=
 =?utf-8?B?SFNxU1BuN09SZ0MxM0ZtT2hWVnNQd1BBdVovV0ZGZmd5TFp6TENtbXhzWE96?=
 =?utf-8?B?d08vcUp6dEorNFNjY00wK3d5S3plNzJHTnJWcjRZK2Z0Nzh0dkUwKzV4c0NE?=
 =?utf-8?B?bm03czl1VHhaR3gvc2hMKzZ0L2dOZHlpZFdzWnhLbkhtSlljeTVzQ09QRU5Y?=
 =?utf-8?B?OWtESkk1UldzU2ltM3Z2MjlzbllIRFAydzNWWlc3SWE2bmxvMXVqZUdJcTV5?=
 =?utf-8?B?RDdZV2xiLzlnZUxjcFJwamVrTUVuQTM5aEhKaEJRREE2K2I1WDRwUWdQUHE2?=
 =?utf-8?B?MzZYR05WWU41cVlqWGg3RHFQdXVtZGNEdDNubVNhUEFrUnZqdGFMcTB3S0xO?=
 =?utf-8?B?TW5XZjRrMHYwMHNzRFJYMEd1aHJvaHNTeUMrZEJlblQwVkpGVXRYREZjRzh4?=
 =?utf-8?B?YXE2bHhBQ0lDNFh2U1p5eFVpY25SMGkyU29BMHlOOUY0bGZ2Y0NEbG10dFB6?=
 =?utf-8?B?Z2xkNFo3WjNIaEZOVGh1ZDhUa3pUZlZxZ1dTYUZVU2l4RGVjVjRQb1lwRHlw?=
 =?utf-8?B?ZDJ6ejhzdjI2azIvTWcwTHJDSnZJWEZhcXg2ckdvZW5MdlU2VVovSTNSZVcz?=
 =?utf-8?B?dkM2N1NHdDhtS3pyVnNvVURDb21FSXBJTTVPdWVVdlVFNWp0NW9zQkxGdktI?=
 =?utf-8?B?ak9mZUVwTHhVMndRZ2dob0tQcTUwL1Q1SkM5cTV2cXo2NzJGeEJTM0RqS0lz?=
 =?utf-8?B?S3FhcnJzOWFwcjVMU2dWY3F6cVZhclBJMjZBWWZQTU1YU0RqYkhaRGc1QWR1?=
 =?utf-8?B?VFdxMUcrV09KM29BckZnREVNREw2MEhObGx1NUk1MHN1eDdSZXByRlB1NnJl?=
 =?utf-8?B?U1Zya2FiTGErS2FDTkowWldjL1BRSlQyNXQyODdJbmxMeE5mb0lYaWNiam5v?=
 =?utf-8?B?allUdHRNc2UzUFJNRHVlbXl6MTFmYnNUdGZ0YXR5Nm0rSWJRdjhKZG5hcTFS?=
 =?utf-8?B?SzRZWFlqU01pNWVNbngxTmhQUXdqOVlOcElCS3Q5SE9VVER5ajlyYkowWUlG?=
 =?utf-8?B?Q1YxeDNKTC94a1BRVnpDZG9BMlNHd3JOd0RFYUZ1czZHcmRSQ3VDekhacUcw?=
 =?utf-8?B?VjArV2g4R3VjYkcrbVBhYm9xZTBxM1Vtc2o1ZjFaNHUvenZvNEZkN1k3ZWNZ?=
 =?utf-8?B?ZnYxVnI5V0tRdS9hNUg0WG1ZNTJ3U0haRDNoTGltL284TStkNUtHN3VYNHZO?=
 =?utf-8?B?UjI4OUhScDdwWVZSUXpqYWtSS0JGQVRiMjErd0JqUkZzUVpURjhIaG9ScGF6?=
 =?utf-8?B?WkVsbHdEeXNNY3B1YUU5TTk3ZmxzNnVPOE1TcHZIT2xuTnRhUFR1UUhha0Ur?=
 =?utf-8?B?VEdva1VFTW5tbHFFVDNOVDE5a0grVlQ4cE9qYjdSYWNzaHM5QURXV3VvYVFx?=
 =?utf-8?B?bWJMS2ExNGxRWllBMnlqMnRrdm1uR29VaEJjVGlWZjlvYWROSXpEMFlHYzg3?=
 =?utf-8?B?cSt2anJaTWJEd1g5Q3VxcU43ZHlNbTdGS2xwSTV6MCsxUFVwanl0RHhCV0F2?=
 =?utf-8?B?cUQ1TnFlVGcrc0ZmZlBJRGdNOUdLemlvb3pNNUtMTEpZcjd3TW9sMXFDRExP?=
 =?utf-8?B?b2ErSlFtQkhpclVNQnhVWnBxUmtjTnNacmxHWUFiQUEzeUdrcnNQczlhd2F1?=
 =?utf-8?B?b2h4dWg0bk03RGtvRU1mTkppV0QxSm1ZT2tNOWplV1I1Ujk2QnRPWm1QVktJ?=
 =?utf-8?B?Y3Z4K24xM1Q4T0ZIN2cwKzNTaVNrNWMySGF3eHo4c3dwdVgwNVJCNjFUSnlL?=
 =?utf-8?B?SFd4bmZ3MEFCbHhSU216cjlDSFpzR1JpVGVneitMelNYc1VIWVptRmZzSVpR?=
 =?utf-8?B?R2ZaOEtWMDdwOWhjR1h0VlB0NDVPdkFqaWZaREF3ZFk3SEZId29DUGFmdXhC?=
 =?utf-8?B?Q2JIZDdHS1FuNTlRbytZR1hJbjUrRjhvbGNiRWZFSFNVcm9KR1grV1hxMkJr?=
 =?utf-8?B?anlXdTlwVWxnVFV6aW9odkFQTTFYSnl0SERnaWtqamE5dXJDT1lldkIvdUF3?=
 =?utf-8?B?NU9naWxMMFlCRjY4Ulk5WW93eStwSEdMbVU5bk9heFRsY3cxbDZzdzM5d3Nv?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <599B1D98FFB388498EE0AE231B29C884@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fce9cc4-3fd3-4c30-a149-08dbd534c3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 08:31:20.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZq2o7i1oaCi/ls76NBHRcl+FTyGtNW17gy+JbRn4SfYhNHM1E5cPFIz0kEioNRmQMspXS6tRClAtGy6lOxYjvy4YkexwGlV0VwRyk8GEYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6895
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--25.243400-8.000000
X-TMASE-MatchedRID: X4bcv0S75KmnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4+qvcIF1TcLYJyh
        lVw/MC0H9KE7L0nJx0o9DY386Yl5frgFJkVTA0wMEe5D10MltLZQCOsAlaxN73PBWZjlMys2i7J
        dnz9E5vjMAS+aj7ouPE7WDVwHg5SjJBVW14/3QK0D2WXLXdz+AV67veYUroY0w01zN1c0miIH+X
        Byy8KTTgRMBudAg30DMMF7UwyfRQhPicTzzI9Twd35+5/2RxqmFk73i4rVVIHxCQaCt6X8bsSKI
        2zVNBuVguP8XuU2B/cD1qI/5qw4UjAo/rUTivG7t1AhvyEKdj7J5SXtoJPLyFfjDrxkVu5iNKCF
        v+lwDDKnzmiwP1ZzR9g68hfLnE/VJnLCYm9iI2meAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
        Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--25.243400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 04A18E434B1BCC7118F448C8D176EF886C388F124E1F36A3EC1262ECBE3135172000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMC0yNCBh
dCAwNzo0MiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIE1vbiwgMjAyMy0xMC0yMyBhdCAxMjo0NSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIGFkZCBzZWN1cmUgZmxvdyBzdXBwb3J0IGZvciBtZWRpYXRlay1kcm0sIGVhY2gg
Y3J0YyBoYXZlIHRvDQo+ID4gY3JlYXRlIGEgc2VjdXJlIGNtZHEgbWFpbGJveCBjaGFubmVsLiBU
aGVuIGNtZHEgcGFja2V0cyB3aXRoDQo+ID4gZGlzcGxheSBIVyBjb25maWd1cmF0aW9uIHdpbGwg
YmUgc2VudCB0byBzZWN1cmUgY21kcSBtYWlsYm94DQo+ID4gY2hhbm5lbA0KPiA+IGFuZCBjb25m
aWd1cmVkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gRWFjaCBjcnRjIGhhdmUgdG8g
dXNlIHNlY3VyZSBjbWRxIGludGVyZmFjZSB0byBjb25maWd1cmUgc29tZQ0KPiA+IHNlY3VyZQ0K
PiA+IHNldHRpbmdzIGZvciBkaXNwbGF5IEhXIGJlZm9yZSBzZW5kaW5nIGNtZHEgcGFja2V0cyB0
byBzZWN1cmUgY21kcQ0KPiA+IG1haWxib3ggY2hhbm5lbC4NCj4gPiANCj4gPiBJZiBhbnkgb2Yg
ZmIgZ2V0IGZyb20gY3VycmVudCBkcm1fYXRvbWljX3N0YXRlIGlzIHNlY3VyZSwgdGhlbiBjcnRj
DQo+ID4gd2lsbCBzd2l0Y2ggdG8gdGhlIHNlY3VyZSBmbG93IHRvIGNvbmZpZ3VyZSBkaXNwbGF5
IEhXLg0KPiA+IElmIGFsbCBmYnMgYXJlIG5vdCBzZWN1cmUgaW4gY3VycmVudCBkcm1fYXRvbWlj
X3N0YXRlLCB0aGVuIGNydGMNCj4gPiB3aWxsDQo+ID4gc3dpdGNoIHRvIHRoZSBub3JtYWwgZmxv
dy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyAgfCAyNzINCj4gPiArKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyB8ICAgNyArDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMjY5IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+IGluZGV4IGI2ZmE0
YWQyZjk0ZC4uNmMyY2YzMzliOTIzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KPiA+IEBAIC01Niw2ICs1NiwxMSBAQCBzdHJ1Y3QgbXRrX2RybV9j
cnRjIHsNCj4gPiAgCXUzMgkJCQljbWRxX2V2ZW50Ow0KPiA+ICAJdTMyCQkJCWNtZHFfdmJsYW5r
X2NudDsNCj4gPiAgCXdhaXRfcXVldWVfaGVhZF90CQljYl9ibG9ja2luZ19xdWV1ZTsNCj4gPiAr
DQo+ID4gKwlzdHJ1Y3QgY21kcV9jbGllbnQJCXNlY19jbWRxX2NsaWVudDsNCj4gPiArCXN0cnVj
dCBjbWRxX3BrdAkJCXNlY19jbWRxX2hhbmRsZTsNCj4gPiArCWJvb2wJCQkJc2VjX2NtZHFfd29y
a2luZzsNCj4gPiArCXdhaXRfcXVldWVfaGVhZF90CQlzZWNfY2JfYmxvY2tpbmdfcXVldWU7DQo+
ID4gICNlbmRpZg0KPiA+ICANCj4gPiAgCXN0cnVjdCBkZXZpY2UJCQkqbW1zeXNfZGV2Ow0KPiA+
IEBAIC02Nyw2ICs3Miw3IEBAIHN0cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+ICAJLyogbG9jayBm
b3IgZGlzcGxheSBoYXJkd2FyZSBhY2Nlc3MgKi8NCj4gPiAgCXN0cnVjdCBtdXRleAkJCWh3X2xv
Y2s7DQo+ID4gIAlib29sCQkJCWNvbmZpZ191cGRhdGluZzsNCj4gPiArCWJvb2wJCQkJc2VjX29u
Ow0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RydWN0IG10a19jcnRjX3N0YXRlIHsNCj4gPiBAQCAt
MTA5LDYgKzExNSwxNTQgQEAgc3RhdGljIHZvaWQgbXRrX2RybV9maW5pc2hfcGFnZV9mbGlwKHN0
cnVjdA0KPiA+IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ID4gIAl9DQo+ID4gIH0NCj4gPiAg
DQo+ID4gK3ZvaWQgbXRrX2NydGNfZGlzYWJsZV9zZWN1cmVfc3RhdGUoc3RydWN0IGRybV9jcnRj
ICpjcnRjKQ0KPiA+ICt7DQo+ID4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX01US19DTURRKQ0K
PiA+ICsJZW51bSBjbWRxX3NlY19zY2VuYXJpbyBzZWNfc2NuID0gQ01EUV9NQVhfU0VDX0NPVU5U
Ow0KPiA+ICsJaW50IGk7DQo+ID4gKwlzdHJ1Y3QgbXRrX2RkcF9jb21wICpkZHBfZmlyc3RfY29t
cDsNCj4gPiArCXN0cnVjdCBtdGtfZHJtX2NydGMgKm10a19jcnRjID0gdG9fbXRrX2NydGMoY3J0
Yyk7DQo+ID4gKwl1NjQgc2VjX2VuZ2luZSA9IDA7IC8qIGZvciBodyBlbmdpbmUgd3JpdGUgb3V0
cHV0IHNlY3VyZSBmYiAqLw0KPiA+ICsJdTY0IHNlY19wb3J0ID0gMDsgLyogZm9yIGxhcmIgcG9y
dCByZWFkIGlucHV0IHNlY3VyZSBmYiAqLw0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJm10a19j
cnRjLT5od19sb2NrKTsNCj4gPiArDQo+ID4gKwlpZiAoIW10a19jcnRjLT5zZWNfY21kcV9jbGll
bnQuY2hhbikgew0KPiA+ICsJCXByX2VycigiY3J0Yy0lZCBzZWN1cmUgbWJveCBjaGFubmVsIGlz
IE5VTExcbiIsDQo+ID4gZHJtX2NydGNfaW5kZXgoY3J0YykpOw0KPiA+ICsJCWdvdG8gZXJyOw0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmICghbXRrX2NydGMtPnNlY19vbikgew0KPiA+ICsJCXBy
X2RlYnVnKCJjcnRjLSVkIGlzIGFscmVhZHkgZGlzYWJsZWQhXG4iLA0KPiA+IGRybV9jcnRjX2lu
ZGV4KGNydGMpKTsNCj4gPiArCQlnb3RvIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwltYm94
X2ZsdXNoKG10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbiwgMCk7DQo+ID4gKwltdGtfY3J0
Yy0+c2VjX2NtZHFfaGFuZGxlLmNtZF9idWZfc2l6ZSA9IDA7DQo+ID4gKw0KPiA+ICsJaWYgKG10
a19jcnRjLT5zZWNfY21kcV9oYW5kbGUuc2VjX2RhdGEpIHsNCj4gPiArCQlzdHJ1Y3QgY21kcV9z
ZWNfZGF0YSAqc2VjX2RhdGE7DQo+ID4gKw0KPiA+ICsJCXNlY19kYXRhID0gbXRrX2NydGMtPnNl
Y19jbWRxX2hhbmRsZS5zZWNfZGF0YTsNCj4gPiArCQlzZWNfZGF0YS0+YWRkck1ldGFkYXRhQ291
bnQgPSAwOw0KPiA+ICsJCXNlY19kYXRhLT5hZGRyTWV0YWRhdGFzID0gKHVpbnRwdHJfdClOVUxM
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBTZWN1cmUgcGF0aCBvbmx5IHN1
cHBvcnQgREwgbW9kZSwgc28gd2UganVzdCB3YWl0DQo+ID4gKwkgKiB0aGUgZmlyc3QgcGF0aCBm
cmFtZSBkb25lIGhlcmUNCj4gPiArCSAqLw0KPiA+ICsJY21kcV9wa3Rfd2ZlKCZtdGtfY3J0Yy0+
c2VjX2NtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwNCj4gPiBmYWxzZSk7DQo+ID4g
Kw0KPiA+ICsJZGRwX2ZpcnN0X2NvbXAgPSBtdGtfY3J0Yy0+ZGRwX2NvbXBbMF07DQo+ID4gKwlm
b3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmxheWVyX25yOyBpKyspIHsNCj4gPiArCQlzdHJ1Y3Qg
ZHJtX3BsYW5lICpwbGFuZSA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiA+ICsNCj4gPiArCQlz
ZWNfcG9ydCB8PQ0KPiA+IG10a19kZHBfY29tcF9sYXllcl9nZXRfc2VjX3BvcnQoZGRwX2ZpcnN0
X2NvbXAsIGkpOw0KPiA+ICsNCj4gPiArCQkvKiBtYWtlIHN1cmUgc2VjdXJlIGxheWVyIG9mZiBi
ZWZvcmUgc3dpdGNoaW5nIHNlY3VyZQ0KPiA+IHN0YXRlICovDQo+ID4gKwkJaWYgKCFtdGtfcGxh
bmVfZmJfaXNfc2VjdXJlKHBsYW5lLT5zdGF0ZS0+ZmIpKSB7DQo+ID4gKwkJCXN0cnVjdCBtdGtf
cGxhbmVfc3RhdGUgKnBsYW5lX3N0YXRlID0NCj4gPiB0b19tdGtfcGxhbmVfc3RhdGUocGxhbmUt
PnN0YXRlKTsNCj4gPiArDQo+ID4gKwkJCXBsYW5lX3N0YXRlLT5wZW5kaW5nLmVuYWJsZSA9IGZh
bHNlOw0KPiA+ICsJCQltdGtfZGRwX2NvbXBfbGF5ZXJfY29uZmlnKGRkcF9maXJzdF9jb21wLCBp
LA0KPiA+IHBsYW5lX3N0YXRlLA0KPiA+ICsJCQkJCQkgICZtdGtfY3J0Yy0NCj4gPiA+IHNlY19j
bWRxX2hhbmRsZSk7DQo+IA0KPiBZb3UgZGlzYWJsZSBsYXllciBoZXJlIGFuZCBkaXNhYmxlIHNl
Y3VyZSBwYXRoIGluDQo+IGNtZHFfc2VjX3BrdF9zZXRfZGF0YSgpIGxhdGVyLiBCdXQgdGhpcyBp
cyByZWFsIHdvcmxkIGFuZCBjb3VsZCBiZQ0KPiBoYWNrZWQgYnkgaGFja2VyLiBJZiBoYWNrZXIg
ZG8gbm90IGRpc2FibGUgbGF5ZXIgaGVyZSBidXQgZGlzYWJsZQ0KPiBzZWN1cmUgcGF0aCBpbiBj
bWRxX3NlY19wa3Rfc2V0X2RhdGEoKSBsYXRlciwgdGhlIGhhcmR3YXJlIHdvdWxkIGtlZXANCj4g
cmVhZGluZyBzZWN1cmUgYnVmZmVyIGFuZCBwYXRoIGlzIG5vdCBzZWN1cmU/IFRoYXQgbWVhbnMg
dmlkZW8gY291bGQNCj4gb3V0cHV0IHRvIEhETUkgd2l0aG91dCBIRENQPw0KDQpEaXNhYmxpbmcg
c2VjdXJlIHBhdGggYnkgY21kcV9zZWNfcGt0X3NldF9kYXRhKCkgd2lsbCBhbHNvIHN3aXRjaCB0
aGUNCmxhcmIgdXNlZCBieSBPVkwgdG8gbm9uLXNlY3VyZSBpZGVudGl0eS4gU28gZXZlbiBpZiB0
aGUgc2VjdXJlIGxheWVyIGlzDQplbmFibGVkLCBPVkwgY2FuIG5vdCBhY2Nlc3Mgc2VjdXJlIERS
QU0gd2l0aCBub24tc2VjdXJlIGxhcmIuDQoNCkFuZCBpdCB3aWxsIGNhdXNlIGEgSU9NTVUgdHJh
bnNsYXRpb24gZmF1bHQgd2hlbiBub24tc2VjdXJlIGxhcmIgYWNjZXNzDQp0aGUgYWRkcmVzcyBv
ZiBzZWN1cmUgRFJBTS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBSZWdhcmRz
LA0KPiBDSyANCj4gDQo=
