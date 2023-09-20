Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3DB7A7298
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjITGK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITGKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:10:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FBC8F;
        Tue, 19 Sep 2023 23:10:18 -0700 (PDT)
X-UUID: 5c5b25aa577c11eea33bb35ae8d461a2-20230920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zeM4VaRVHu6lnh9PrzQHS6l23kG8p0sucVbFFPFM6d8=;
        b=JVhFsRZgwFE95vUwh+FmB66zvUtGQjNqWTh+Iv414YmFN7frQm9QWr4SMNVADvMEvqXEsUwsndQ/9Dye4dmpN0TkdfDrCqIQ5thjWkJjeb2Rr9Ml8rlmsMw+9PaeRzQCgBwwFZOEFpBXYtWh1iP93jstgVf25BfeMMereGQbtYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:b174a1c9-00ac-4ad8-85f9-576012b1e53a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:0a712614-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5c5b25aa577c11eea33bb35ae8d461a2-20230920
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1464837350; Wed, 20 Sep 2023 14:10:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Sep 2023 14:10:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Sep 2023 14:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no4R1inLWVEnNX+9jZGeUWzerdbMsgCkDqk7iMUcsOS3HfuxE+wGV2RGXoysSab4AZSRYTxSiZy0a9lNVHswz4LR2EX8Z0E5gX/n/bckzdl8iXqq3fytFmUGpCH9O4+XMN2Ppuy6upCg/UNHOlWXfkVpc5EJNy2rLmJQsXYLQgr9gyo/aIwpqrhYwgo2Eslg1ehCnlb1ouWNb3/YkK1LcL7WWqXQFeuSvcrEjKI7J5wszePrNRn1XYZ4pKkhGoZnNGUfrH3Qms73uvAaRjv1/gbhc0f/u2n4PMd/MImezmg38/XojgcVfZaqDCifLI/xKK7xehYRo8C4Bbt2c0HsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeM4VaRVHu6lnh9PrzQHS6l23kG8p0sucVbFFPFM6d8=;
 b=Ja5gtmQrOuOXTQNa6jLh0McrnRzGh9W+l3p74AKu34X5lPj3w3GciEKKOSjBsBwuw0owaNmgb5eokkouDSxV2dCprmayHI2L+tBMxCqZrW+3aiFBIlDMkHoVO+b80eR7O22WSdGBasK7XI4K1Vtod3hayR9zZJygrT3ZT4Li/kR7KIvKMVt83tjQVRULYv12YICTCh/wnBrQwgU5M5p/0I9lXm9E77VHh1+jroz+GgJw15qR6Nj98fLu8Xnz6KUKU0T1bnRhw/SaY+W2GKHWjJlDPlACrJr+1ZXq7AStfqcYVqEBpv9xOV62mwWUVlV5vfsmLXQlHGCbJkoP1fvUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeM4VaRVHu6lnh9PrzQHS6l23kG8p0sucVbFFPFM6d8=;
 b=H0vbFkAz/LUjL5+oVGT5PO3aCKe+y5boKQu2dXdRACtlYFnzC2WDAVFTsJ3DQ8Me4TvsqJ9CJJjPdXJ/dCmHckX5jmz+gvqDWuk1bZAULIxsq+XGOwuqGeAFXIksEjp6YtTTgzm4bkxf321riTW/53yTxYBzecXlZngmw8Xd5B4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7598.apcprd03.prod.outlook.com (2603:1096:820:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 06:10:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:10:09 +0000
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
Subject: Re: [RESEND PATCH v6 03/20] dt-bindings: display: mediatek: merge:
 Add compatible for MT8188
Thread-Topic: [RESEND PATCH v6 03/20] dt-bindings: display: mediatek: merge:
 Add compatible for MT8188
Thread-Index: AQHZ5IOrl6rOhmnMHEiiQhg17kaHn7AjSS4A
Date:   Wed, 20 Sep 2023 06:10:09 +0000
Message-ID: <d4ab0d202e890955875da1090434bf9727091a20.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-4-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-4-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7598:EE_
x-ms-office365-filtering-correlation-id: 4a889a10-6ef8-4c89-e11a-08dbb9a03e30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpZRIlY4BJjtEMbHXoM9sg42YEj8JmgpBY9U+q1BGZ3H2pLLW6finqLv6rvMGfCh/VwRWZwNRrKDuO9O9hhCDNYWQc3FKzn6ssjkoNTIvPBSGIc4g02IsSIx8nJvxiTtGzumr+nqSppvbv38IQo2ItxE6mza3B0efgI7msJ2ViTBf4/cQ47/f3ZDN4XoR2KSPtDRXi3gzGkZvp9EkNTS6Kr0A2Mbu5dgMUi1+nHtGZ0sCMFMG/1GozYd90FpgQdNTYU7Y3TGiAdlSsHHT+GMouIE9TmbjVPdF3UAp8JsIBRBA95WZEsDcZ/fRlKzaNS+gWLg1Sj8KE7yk/C2W8LV0xFouac3+pSXKJvMoRc/EEibOU3Gu/EKx+QcWlhbbnyEVY9s07iFL8TFhvnX+jAlsENWOi2zwuoKM6Q7jhPlvQK5myriFQ63uwOoLBJ5auDfcoJK8NAguoVWI94EaAkKfFDkjBr9xGXQIMJ4+14JBBAtNIidAbRFEhxEqjtggp9JgTkUN5X/JflyXNcn5y0IdXtF0hxlxDxWGuPpgu/QuDCNNOYVu3Mq9BxwgD2R6e1dgT0+eDzNH5g+NZX/iDV8HvJdFzx31FbfIBU+O2gUWwejRpW5/UFWXjTqOrZCKBQBXNoEsP+Rp511tTYlEbK8+iemVNpJpCS5CEyInAjtfnE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(1800799009)(186009)(451199024)(2616005)(4326008)(5660300002)(8676002)(8936002)(6506007)(6486002)(6512007)(26005)(478600001)(71200400001)(122000001)(66476007)(316002)(66946007)(76116006)(110136005)(54906003)(64756008)(66556008)(66446008)(41300700001)(7416002)(86362001)(36756003)(85182001)(2906002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1YzelV2aGo5VVJ5VVpaN21oNm9mTXNJRE9aVXd0R1daNGQ1dG9GZGdLSXZS?=
 =?utf-8?B?djJKV3VXWGtES3hzeUJFRnpyRDZsUWxrVmNsWlVkbHRnRU1XMHB1LzJ0V1Qv?=
 =?utf-8?B?bm5RZTMweXdJYUJLb29oVEpIMWpZaEtSdFZKNDFsS0QzK01waEpUU0RzNkx6?=
 =?utf-8?B?WWpaZllRUmpTbk5sQjhOelhDcUtlUzZ5aDI4eHJhTWFVbUExNWxEcC9QY2Mx?=
 =?utf-8?B?b1dab2JIY0pEaDJuSkdqOVJkYmM1aW1FWmhLK3JIcjN1czVBcUllMHhhN1JF?=
 =?utf-8?B?SHlsbFFlZW9KOFk0RndkY2hsZWkvc3hPdGVDTWhDdzdHZW1CVnM0TXoxRHhM?=
 =?utf-8?B?Ymh1dFh4M0dPcVJ0ZDNWNVM1WVJoRTZDbzFCVW43ZDEyNldKOVNwT1hUQ3Vx?=
 =?utf-8?B?OXVZOUZPT3VQMEU3amJYbTd1UXhFZkw1UER0QW95TGh6K1UvNmJRN04rakgy?=
 =?utf-8?B?L01iSjMwTjg5bVE4TVptRTgydnJhSXM5SEg3M1pXL284eVRrMGw2eUEzaUIv?=
 =?utf-8?B?Y2lTcFZwQUM5cENZeU1HUmRiYnF3Q2czQmMrUzk5N25mUlhKT0hsS3Q3Q243?=
 =?utf-8?B?akR4SVNzU3hTb1V0Y2kycHhycXlmbnh3SWZjS0hHaU1rVnh6OFN0eFZsWUtE?=
 =?utf-8?B?SFhjSmt3YUYyMGt2Z0srdDhHYmVQaWpodXVGa2tyMVB1ZFpLQ1p0MzJiT3FX?=
 =?utf-8?B?L0VQZnBMR2VobUNOeFRXeXBjVVlBUnJ5Y2M5Ym5FRDZXTHpnb1ZLNlJIVUli?=
 =?utf-8?B?R05QMFJWam1CUzFnMUpjbjRTRDliRE5MWWJlS1B5RUFuNnBMMmhOVVlNYlFz?=
 =?utf-8?B?NjhJdEUvR0ZvOEthak5od1BOU0FNWEFnb1ltbU1YS2pkZlByMXNBN0VWaVZu?=
 =?utf-8?B?d252M3o1WUhadkxzMnVvWWZKaUNGUTVLNHAzTzJVeFpZRHpIZ2x6MzFNOHFR?=
 =?utf-8?B?aGlOb3VLa2hiKzBZZ0RKNHBxbFNZR1FPalo3cWdaRTdwTFR4U3BhS0xnUHgv?=
 =?utf-8?B?aXhpMGcyRU1FeW5RaXVJU2FBRUZMSURtYytWOXp5bmkrYVROeE14QjhLd3J3?=
 =?utf-8?B?V2xndmMrMmVzT2MzUWFJeGtPbnVqZXFDNW5qNEtZQkpGaE56L0VDSGpoUEdy?=
 =?utf-8?B?RkFPMjZtMit6T0pjYjdtZDdjMFhUTktMN1dJTkp5emNHRmY4NTgrWXJOT2Js?=
 =?utf-8?B?VHlGVmZkQ2lUelZBMHk0RFZxNkFHTURtZmwza2dVSUpZWFd1VGNnMWZaeUl0?=
 =?utf-8?B?VUpKTnJJcWtBNW5BcHRoMDRjRjZJcy8vSHlPRjB4QTlFMTNYSk4vNWdiM0VZ?=
 =?utf-8?B?UlU4T1JzemJ4UDgxSkVOQ1V0QnBTRWpQQThaUGQ3MUE5RTRQLzN1NmRGSFN2?=
 =?utf-8?B?bXNVTHdFQzhLVmpPU1gvQ25JTDVxdnVjSXdpY0k4STJlVENHTjFYZnc5K0tq?=
 =?utf-8?B?NmIvVEdYaTJhbmFqUkthalJYNEkvR3R3a3ZVbnowMmFsRkYrZ0wzb3BZN0t2?=
 =?utf-8?B?YTV3b0ROVDBpcm5OMGo0a0ZicWg2UWIycE9xNFFOdXVZYm0xbXpNYU5lS2Nt?=
 =?utf-8?B?SEVCZEFGMzNwc2lCMm51alNmQWg4VGlZVmtvdGZaRlNtOVBQcE1qWkJaSWxx?=
 =?utf-8?B?Tm9wM29HR1Y1TUlOaGVpS0ZEMHhZM3p0YkVIeXZVSkkxNWk2NnZBQjJOejZW?=
 =?utf-8?B?bTVUeTJOd1AyeUdoMGpvMG1yR3V0MkJjR2k0V2FZTGFjbVZXbWZSbDhQQ0dz?=
 =?utf-8?B?S25xZUgvZFZxNDVLcDN2MXkrT0lWY2MydVhBZ0JxamxaSGlYcUpzcUZXbUp1?=
 =?utf-8?B?d0FzREVNTFIrYUtkNkxZUXRLUWI0d0F3VSsrSkVhaUdCZmNFQW9SOFQvV0E5?=
 =?utf-8?B?RERhT2FWYVNSK3ZDdk9vVWRxclBBbnhIRWRGbnZTcDhEdmRxeVNNWE0rOGVa?=
 =?utf-8?B?MURZWHFPK3JKUnloNkVaU0lEVy9KV29iRGIzcVZRTTBHWFdqOE5ZazQxSjBr?=
 =?utf-8?B?LzNoVmkyM2w0dGpBcmpoSGxBdkdrNHJBRHRoc3BnQVRCMUtBQVMvbEpJdkdN?=
 =?utf-8?B?MHZScmpvQXRmMkN1MDU3eU9iWWZjWEJtZXN1cVY1VjBHMnlTR0xSemJ3NFpv?=
 =?utf-8?Q?fC7mU+cIR4nC4UT4XesgIeqkg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <241257B231EF0440A38A6A7DACD3D4FB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a889a10-6ef8-4c89-e11a-08dbb9a03e30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:10:09.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFM/NKUImr1lSL7mWRShrmbcg0kwe7aC+y6hnjtJ0D7aSBB/78ngeENnBCAvapug2Z7ALYU5q2n7VTOALXlIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7598
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.570400-8.000000
X-TMASE-MatchedRID: u1zqiMeMcro/XHdICuW5r97SWiiWSV/19r9tEcSw8jdcKZwALwMGs80z
        jHUi+uXR6YQejPuwftfxHXxxAO/d2Ws/tFw6ZTQWngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1Gc
        RAJRT6POOhzOa6g8KrVuRPArf5m8nfkxNUg/sHX+9jcrgLGa1YskC5vN1p6vce43Y2W+LzvxDDK
        a3G4nrLQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.570400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3DF639B621470041177A8463C252D7358A746CE41AD5216CDF986F34059F9BFC2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IEFkZCBjb21wYXRpYmxlIG5hbWUgZm9yIE1lZGlhVGVr
IE1UODE4OCBNRVJHRS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+
DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gQWNrZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxt
ZXJnZS55YW1sICAgfCAzDQo+ICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG1lcmdlLnkNCj4gYW1sDQo+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbWVyZ2Uu
eQ0KPiBhbWwNCj4gaW5kZXggZWVhZDVjYjg2MzZlLi41YzY3ODY5NTE2MmUgMTAwNjQ0DQo+IC0t
LQ0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVr
L21lZGlhdGVrLG1lcmdlLnkNCj4gYW1sDQo+ICsrKw0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG1lcmdlLnkNCj4gYW1sDQo+
IEBAIC0yNyw2ICsyNyw5IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAtIGl0ZW1zOg0KPiAgICAg
ICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10Njc5NS1kaXNwLW1lcmdlDQo+ICAgICAgICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQ4MTczLWRpc3AtbWVyZ2UNCj4gKyAgICAgIC0gaXRlbXM6DQo+
ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTg4LWRpc3AtbWVyZ2UNCj4gKyAgICAg
ICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTUtZGlzcC1tZXJnZQ0KPiANCj4gICAgcmVnOg0K
PiAgICAgIG1heEl0ZW1zOiAxDQo+IC0tDQo+IDIuMTguMA0KPiANCg==
