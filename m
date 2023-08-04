Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4048076FE8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjHDKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjHDKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:31:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E9C49F3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:31:46 -0700 (PDT)
X-UUID: 1953744032b211ee9cb5633481061a41-20230804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7YlLVquUt3eLnUZnPdBmbTG1JD344khThg2rUS8ntEw=;
        b=DpKTKQl+w5pGvP0VyhOduVU9qSmd8YldVmF5LH5IJT4ySrWkbdvvP8J4qCGlDn8xHmX6dikcjQAxqcd462UtyWQZ2dkcaYIowrtc9RRengcAV83tApYx05Fod4c2Ocem2Fjxn3RSa8WgWZKmIZwCdCpvGmeqfPLtJ+PtV19/QWg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:0334571d-dee6-4475-8d92-00d26443c438,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:bc9dd042-d291-4e62-b539-43d7d78362ba,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 1953744032b211ee9cb5633481061a41-20230804
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 407419310; Fri, 04 Aug 2023 18:31:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Aug 2023 18:31:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Aug 2023 18:31:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU4PSnyNo3gQ3WGF0dbFZXvJMGBcP+jRY8phzHMM5ma6XOWqe1ORm/eCI7zR59sllfKZ/baJtOCNjrk5Driyj1oEgO/JRKfq74MqHQ91OjDUewVESeMAJik/t3Vy3Mub9ircbRRZ5MlkFKuVpPHI00Ww9K0q4lHqEwFsse3AbPIgw1ZTXnTL/t8H6erLoAyPazwMhBud+zyJgzIk0XEGTZ62mVsn1OxWFUdn36FkObYam17pbyw36R/PSloyJNG7/Vvjlz3UZMZPUr5+yryflUjmOm644zQo/vY0/yvvJA3kCaDJ1lHpMmYxhUZsoSq+1Ij4UiHMzkMMm++2DzZNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YlLVquUt3eLnUZnPdBmbTG1JD344khThg2rUS8ntEw=;
 b=KQYq4/AgrRyiF1OJm6Y1lwpIXDcpnlyluo4NhnnUyCR+ZLt6YMKShQ0nQxQlz+MPOMTUIKfar3kRqrxw3Q/G5fVlFhmxqTaGej0CGTlSkcYGx/K5AU3tnLUSZoq8g7cOOyDVEKMefnWTwC01oxIz7fBvMPEjcEEJAv0eyGKw8Bet0KTLP9sguxsyMFbPPGNuMnMXLlATZxsUUGGJ5uFsQVUbAoc1Hb8UB1tR801PYfcCj5X7INjpAUug9GfgurLqft3pUcjm1+7Ubx0oXYvQ/7m4sWD9h3hUwYHohmxSeklbnkJOEkdle3uH4mgiXb3B0GzQR0gUAtQX+zW5Z8QvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YlLVquUt3eLnUZnPdBmbTG1JD344khThg2rUS8ntEw=;
 b=FgJOpN1pr8JVrP9cv1IEYsb334fzt+hgcXTPjzC8TRUn1ZXEEir2LKxe2HzpYRJ52AXMe1jyYO+1eDdXbfk1DR76ZjSg8R7gilHXKpGfNAeWJ1r587mgeJDrUwGxEiRo4UY0av06PvO7/B9eYP25ekZkaarmVyfZQQa83JURaJU=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5293.apcprd03.prod.outlook.com (2603:1096:400:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 10:31:36 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 10:31:35 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: mt8186 modify dram type as non-cache
Thread-Topic: [PATCH] ASoC: SOF: mediatek: mt8186 modify dram type as
 non-cache
Thread-Index: AQHZxd8x66fYopO9Gkq3xwcsbTojWK/YNmOAgAG7jAA=
Date:   Fri, 4 Aug 2023 10:31:35 +0000
Message-ID: <698fea91dbe0953cb945d51ff85a837d275a818b.camel@mediatek.com>
References: <20230803075028.32170-1-trevor.wu@mediatek.com>
         <e88a1074-ca86-709f-8c26-f875320e728a@collabora.com>
In-Reply-To: <e88a1074-ca86-709f-8c26-f875320e728a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5293:EE_
x-ms-office365-filtering-correlation-id: ab9349ad-a91a-4318-c32f-08db94d5fa81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rx5DDh2/B3Tix3nK0/TLbGIIjn8UnDIteXKiPHvDK9f2f/4aMbYnQvlr8QeaTbRxp5sFUtov1eYwhHk+4OdHSC+GXH3hbFtHlaevYsyBGGsd3lAFfijtZQ+tTm9/4huT054mRLYrr/RmlSIGna0sXySXrfa+3+luO/5U9wjWJIN7M48YbbPYvGJlgNf49/YE2M7ivpXb59ZcfpaTonxDSmOqk34VIkM54AQtlmzxEAHxHmDX3qkuF5SNLuRodqjzb3HkStkR/UtIp2hhE5DTUvPtX6+R04RFvUtvwQW8YuKcfBwTWDYZ+gtZLmIh1G+/zjOCuBsEddfijXWyvprQ64ROKeI6YF8azweXOKjPk2g0wQFXiIOMXGl2ZEJ+fpwVTFV2BgelFM5AtkwSMEX7D4rUIvZv1C2Z9mLh4g/vz4i2R0W2f8xQ08bgCrz3P02JwpONksqnKp8jk3Ywc/A+j3ADZe/E7g5R+SBYYvBKP+OOEIqhnFUoJMGQ8JL1lC5qdMXlk22SZbSiC8HGwXnm9mCKSLnQ0HaDniHpNwS6JoyNVCdipTosmxXqaLR6312Xf4kshokliCF1qccIeETP48zZlI+lpBAguu2CznrKjBFPapx8Y/vNx1ZxZuNyqQxARjrUj/y1Z4N8JU84xBL4QyKUHfDTKeBOHXn8Tditxirhi+kVNO4cG1ML48zVxKNn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(186006)(1800799003)(107886003)(41300700001)(478600001)(5660300002)(53546011)(7416002)(8676002)(8936002)(26005)(6506007)(6486002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(91956017)(38100700002)(38070700005)(71200400001)(86362001)(122000001)(921005)(110136005)(54906003)(2906002)(85182001)(316002)(2616005)(966005)(6512007)(4326008)(36756003)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUFGSUNxQVJ6YmltcXdkK1p0TFZmdnB4YkpSOUVQRUw2OXJpcU5nRk93YU83?=
 =?utf-8?B?TFNoTmh0b3ZncmpTMlUyOERlZVV4VDdma3lxRUxKNVo2dWxnSFpWL0VlSTRs?=
 =?utf-8?B?L2FjQkx1N1dpQ2w2SGt4ZWJEZ2NGOS9YdlNHN0FFaEtYb3Y5S0lkZjVNTGQz?=
 =?utf-8?B?c0l0bWVKUWMvWnNlakJRbHROV0lpVHNrVkNsblRHZ21UWVpNbmNKRzVkWXNO?=
 =?utf-8?B?dDhVODNza3k3SmRRUTRPOVN5N1FXZTg5T1ovUk1SSHRIMHVGa1pYRVZ5YTU0?=
 =?utf-8?B?M0FIOVBCaHFQaWFBV05UNjJRQk9TWUt2NmpUYWxxbXZEbDJrdllJT3pCQitw?=
 =?utf-8?B?Rk9RZkVvbUJIS0czWmQvOG1MeE9JZ1luS01LazBxZ00rais3RGR5UXJBR0ds?=
 =?utf-8?B?d0R5c29KaTN3ZWNkcTBPNnU3d25XN3QvRWhvKzdpYUZWUnU0U0JFaFR6S2tU?=
 =?utf-8?B?bXNSUDFhS2tTYXBubnFkSmVPT0FGWUpIaUQyQjdQaW9obVNqenUwRmZ2S1BH?=
 =?utf-8?B?ZHI1UkRkYUJ4WUhzbi9iczZUOVdNd3VnQmV1UFVoUzAxaUh6Zzk0aUl5NFRm?=
 =?utf-8?B?WGduWEFYYkpFMlh2cVBhZWxuVVpRbDZEQm1MdTEvdGZJMHVxNnBDb3d1MTRv?=
 =?utf-8?B?S3ZPTHFYRjhDb2E1RE9WcnhUTTZDbm5MSzZoaU1nSG5XZm9wRkFOdE9aSGU3?=
 =?utf-8?B?SHVhMkVqandGUVczSmhMbTRtY3RiOCt4WUk4ZHlSRWIrZllKUXBXM2ZYcERX?=
 =?utf-8?B?dXU3NDNUWS9qa1dwVzZtb1pQRlM3Z2J2bE9IeCtNL0tuR0Q5a2lBQkZQV3Mv?=
 =?utf-8?B?MGx1cUJJTTBHUTIvRmVDK3BYTDBkY005VENBWms0MVllNi9HSHBhaUs1T08y?=
 =?utf-8?B?NkRINXpzSmVPa05ITWdGVkJabk1qaEdCdmxjbUJNR2NpZkVtV3FKSWJiK0M0?=
 =?utf-8?B?WlFjbkF6RDdxSlJCYm96Y1F3ZFowWWw3NWplOW11R0s4N0N1V1M3dExPVGpP?=
 =?utf-8?B?YzAvMEZvY1lST3MyTTdqYSt6bzI4c2hjQkFNVCswb3BtRTFmaHBwTk8zMWR5?=
 =?utf-8?B?ZW1BaTE0RzBveExobmRDNFlEMXorM2RTcVFoeE10bGdzc1VZcWNQb04rR2tt?=
 =?utf-8?B?Y3ZhQzd1aVM2aTdrbzhLNUN0NDE4OWFpMENMTXVkVEtYTDNuV2RwZXN2TCtF?=
 =?utf-8?B?cnZPNWpuZm9RT0Y1cXFiM2lxRHRuMXdOV2ozMGNVMENROE1ycTkzUytGUm5V?=
 =?utf-8?B?RSttSFBpSStHMkJpdjU2WmNSZjhianlndXRyREU0V25XSk1URXIrL0JDWTZ4?=
 =?utf-8?B?ZXJKTVJuNjJ5L0JRU011Um1qS0VzM0w5K3RlQlFGamw4bmVIWXJoZTQvblpI?=
 =?utf-8?B?N3VrZkliRjVsWlBwRWNyMCtDUW1PTHhqV3Mvb1FiWnFmZVFLbERqcEFacWtm?=
 =?utf-8?B?bnVZYXpBZjQ5cW5aekpsb3dqdmwxSUd1QTdGRUJJRDhCc2t0QktnNnQxc2I0?=
 =?utf-8?B?bkpaQXhLWXYrbmQ0c2JTQVkzMlhJeEw5ZnBCMktCWkRibGxBQWNuQ0hqNVV4?=
 =?utf-8?B?VlI1NmUyb2gweVBQdzFmL0FMZSt4a2x3eTMrQmoxOWFwVkU2S2xPcmd6amVK?=
 =?utf-8?B?ZVo0dzZ1SWlHc3VoZms2U2J6SjlVY3FsYjIxK0lhYmIrUmV1bjcrMmZDTGxl?=
 =?utf-8?B?cnljTzkyMlpuc1BWODlVSFhIV1ZDcDhnYTkxc3FVYWxMcnNQL3VBOTNiLzVT?=
 =?utf-8?B?TlpXTEgzcWNMT1lheGI4MVo2dHg0eXN1UGlaZVNKOWNsT1hPUld2MWNmM3hD?=
 =?utf-8?B?T1lGaHdXdjZWMUg0NEVxV3J3Q3VWRSsvZWlTbFZ6SktqREdoc1o3OUsyTjdX?=
 =?utf-8?B?b1lzNDhzOSsrdDhZTXBjM0NWb21jaElMT2NscVE5Z1BQdlFaRzJQOUZXMEVO?=
 =?utf-8?B?TjFsMHd6d3UzSmZKdWpnUGwzWHhSdDRQdW03TUlGUDN6NDlIUVVBWkFCeXhD?=
 =?utf-8?B?NzcxNlBiTTVqcXZkeisyZ25sMkYreHFNeTg5OWlpbHBPMFdlWmt6OFFkbzkw?=
 =?utf-8?B?K1dyRTh2UWpJamp1Y1dXenJVN3VHMG1FUHdFR1BRcUtpaGIvQi9ncklvcHNu?=
 =?utf-8?B?OWNraGI3UzBtUm1SZk5nMHQ0ZFVzMGh1U3VzaHdHaWRPZEtya2cwdUxHYVk5?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E36A94803689B34CBA9314872B48A9A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9349ad-a91a-4318-c32f-08db94d5fa81
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 10:31:35.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohF5U11DqeQHdOxyabgMAm0mRwrxJChbQJ9CCmaCUlcGBQVuMi42bQiZhZYMEwetSeC8f2ODcgdTz+1slkQrYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5293
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTAzIGF0IDExOjA0ICswMzAwLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0K
PiBIaSBUcmV2b3IsDQo+IA0KPiBPbiA4LzMvMjMgMTA6NTAsIFRyZXZvciBXdSB3cm90ZToNCj4g
PiBUbyBwcmV2ZW50IGluY29ycmVjdCBhY2Nlc3MgYmV0d2VlbiB0aGUgaG9zdCBhbmQgRFNQIHNp
ZGVzLCB3ZSBuZWVkDQo+ID4gdG8NCj4gPiBtb2RpZnkgRFJBTSBhcyBhIG5vbi1jYWNoZSBtZW1v
cnkgdHlwZS4gQWRkaXRpb25hbGx5LCB3ZSBjYW4NCj4gPiByZXRyaWV2ZQ0KPiA+IHRoZSBzaXpl
IG9mIHNoYXJlZCBETUEgZnJvbSB0aGUgZGV2aWNlIHRyZWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBZYW9jaHVuIEh1bmcgPHljLmh1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBL
dWFuLUhzdW4gQ2hlbmcgPEFsbGVuLUtILkNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIHNvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTg2L210ODE4Ni5jIHwgNDAgKysrKysrKysr
KysrKysrLS0tLQ0KPiA+IC0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L3NvZi9tZWRpYXRlay9tdDgxODYvbXQ4MTg2LmMNCj4gPiBiL3NvdW5kL3NvYy9zb2YvbWVkaWF0
ZWsvbXQ4MTg2L210ODE4Ni5jDQo+ID4gaW5kZXggM2UwZWEwZTEwOWUyLi5mNTg3ZWRmOWUwYTcg
MTAwNjQ0DQo+ID4gLS0tIGEvc291bmQvc29jL3NvZi9tZWRpYXRlay9tdDgxODYvbXQ4MTg2LmMN
Cj4gPiArKysgYi9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE4Ni9tdDgxODYuYw0KPiA+IEBA
IC0xMTEsNiArMTExLDE0IEBAIHN0YXRpYyBpbnQgcGxhdGZvcm1fcGFyc2VfcmVzb3VyY2Uoc3Ry
dWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2LCB2b2lkICpkYXRhKQ0KPiA+ICAgDQo+ID4g
ICAJZGV2X2RiZyhkZXYsICJETUEgJXBSXG4iLCAmcmVzKTsNCj4gPiAgIA0KPiA+ICsJYWRzcC0+
cGFfc2hhcmVkX2RyYW0gPSAocGh5c19hZGRyX3QpcmVzLnN0YXJ0Ow0KPiA+ICsJYWRzcC0+c2hh
cmVkX3NpemUgPSByZXNvdXJjZV9zaXplKCZyZXMpOw0KPiA+ICsJaWYgKGFkc3AtPnBhX3NoYXJl
ZF9kcmFtICYgRFJBTV9SRU1BUF9NQVNLKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJhZHNwIHNo
YXJlZCBkbWEgbWVtb3J5KCUjeCkgaXMgbm90IDRLLQ0KPiA+IGFsaWduZWRcbiIsDQo+ID4gKwkJ
CSh1MzIpYWRzcC0+cGFfc2hhcmVkX2RyYW0pOw0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0byBqdXN0IHJlYWxpZ24gdG8g
dGhlIG5leHQgNGsgYm91bmRhcnkgPw0KPiBPciwgaXNuJ3QgaXQgbW9yZSB1c3VhbCB0byB1c2Ug
ZG1hX2NvZXJjZV9tYXNrX2FuZF9jb2hlcmVudCA/DQoNCkhpIEV1Z2VuLA0KIA0KVGhlIDRrIGJv
dW5kYXJ5IGNoZWNraW5nIHNlcnZlcyBhcyBhIHNlbnRpbmVsIHRvIGVuc3VyZSB0aGF0IHRoZSBt
ZW1vcnkNCndlIGFzc2lnbiBvbiB0aGUgQVAgc2lkZSBjYW4gYmUgdXRpbGl6ZWQgb24gdGhlIERT
UCBzaWRlLiBJZiB3ZSBoYW5kbGUNCml0IGluIHRoZSB3YXkgeW91IHN1Z2dlc3RlZCwgaXQgd291
bGQgbWVhbiB0aGF0IHNvbWUgcmVzZXJ2ZWQgbWVtb3J5DQp3aWxsIG5ldmVyIGJlIHVzZWQuIA0K
DQo+ID4gICAJcmV0ID0gb2ZfcmVzZXJ2ZWRfbWVtX2RldmljZV9pbml0KGRldik7DQo+ID4gICAJ
aWYgKHJldCkgew0KPiA+ICAgCQlkZXZfZXJyKGRldiwgIm9mX3Jlc2VydmVkX21lbV9kZXZpY2Vf
aW5pdCBmYWlsZWRcbiIpOw0KPiA+IEBAIC0yNDQsMjMgKzI1MiwxOCBAQCBzdGF0aWMgaW50IGFk
c3Bfc2hhcmVkX2Jhc2VfaW9yZW1hcChzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
IHZvaWQgKmRhdGEpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYt
PmRldjsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2Fkc3BfY2hpcF9pbmZvICphZHNwID0gZGF0YTsNCj4g
PiAtCXUzMiBzaGFyZWRfc2l6ZTsNCj4gPiAgIA0KPiA+ICAgCS8qIHJlbWFwIHNoYXJlZC1kcmFt
IGJhc2UgdG8gYmUgbm9uLWNhY2hhYmxlICovDQo+ID4gLQlzaGFyZWRfc2l6ZSA9IFRPVEFMX1NJ
WkVfU0hBUkVEX0RSQU1fRlJPTV9UQUlMOw0KPiA+IC0JYWRzcC0+cGFfc2hhcmVkX2RyYW0gPSBh
ZHNwLT5wYV9kcmFtICsgYWRzcC0+ZHJhbXNpemUgLQ0KPiA+IHNoYXJlZF9zaXplOw0KPiA+IC0J
aWYgKGFkc3AtPnZhX2RyYW0pIHsNCj4gPiAtCQlhZHNwLT5zaGFyZWRfZHJhbSA9IGFkc3AtPnZh
X2RyYW0gKyBEU1BfRFJBTV9TSVpFIC0NCj4gPiBzaGFyZWRfc2l6ZTsNCj4gPiAtCX0gZWxzZSB7
DQo+ID4gLQkJYWRzcC0+c2hhcmVkX2RyYW0gPSBkZXZtX2lvcmVtYXAoZGV2LCBhZHNwLQ0KPiA+
ID5wYV9zaGFyZWRfZHJhbSwNCj4gPiAtCQkJCQkJIHNoYXJlZF9zaXplKTsNCj4gPiAtCQlpZiAo
IWFkc3AtPnNoYXJlZF9kcmFtKSB7DQo+ID4gLQkJCWRldl9lcnIoZGV2LCAiaW9yZW1hcCBmYWls
ZWQgZm9yIHNoYXJlZA0KPiA+IERSQU1cbiIpOw0KPiA+IC0JCQlyZXR1cm4gLUVOT01FTTsNCj4g
PiAtCQl9DQo+ID4gKwlhZHNwLT5zaGFyZWRfZHJhbSA9IGRldm1faW9yZW1hcChkZXYsIGFkc3At
PnBhX3NoYXJlZF9kcmFtLA0KPiA+ICsJCQkJCSBhZHNwLT5zaGFyZWRfc2l6ZSk7DQo+IA0KPiBZ
b3UgY2Fubm90IHVzZSBkbWFfYWxsb2NfY29oZXJlbnQgPyBUaGlzIHNob3VsZCB0YWtlIGNhcmUg
b2YgYWxsIHRoZSANCj4gY2FjaGUgbWFpbnRhaW5hbmNlIGZvciB5b3UuDQoNClRoZSBwdXJwb3Nl
IG9mIHRoaXMgcGF0Y2ggaXMgdG8gYWxpZ24gdGhlIGltcGxlbWVudGF0aW9uIG9uIG10ODE5NVsx
XS4NCkluIGZhY3QsIHRoZSB1c2FnZSBvZiAiYWRzcC0+c2hhcmVkX2RyYW0iIGhhcyBiZWVuIGRp
c2NvbnRpbnVlZC4gSSB3aWxsDQpjcmVhdGUgYSBmb2xsb3ctdXAgcGF0Y2ggdG8gcmVtb3ZlIHRo
aXMgcGFydC4NCg0KPiANCj4gPiArCWlmICghYWRzcC0+c2hhcmVkX2RyYW0pIHsNCj4gPiArCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBpb3JlbWFwIGJhc2UgJXBhIHNpemUgJSN4XG4iLA0KPiA+
ICsJCQlhZHNwLT5zaGFyZWRfZHJhbSwgYWRzcC0+c2hhcmVkX3NpemUpOw0KPiA+ICsJCXJldHVy
biAtRU5PTUVNOw0KPiA+ICAgCX0NCj4gPiAtCWRldl9kYmcoZGV2LCAic2hhcmVkLWRyYW0gdmJh
c2U9JXAsIHBoeSBhZGRyIDolcGEsIHNpemU9JSN4XG4iLA0KPiA+IC0JCWFkc3AtPnNoYXJlZF9k
cmFtLCAmYWRzcC0+cGFfc2hhcmVkX2RyYW0sIHNoYXJlZF9zaXplKTsNCj4gPiArDQo+ID4gKwlk
ZXZfZGJnKGRldiwgInNoYXJlZC1kcmFtIHZiYXNlPSVwLCBwaHkgYWRkcg0KPiA+IDolcGEsICBz
aXplPSUjeFxuIiwNCj4gPiArCQlhZHNwLT5zaGFyZWRfZHJhbSwgJmFkc3AtPnBhX3NoYXJlZF9k
cmFtLCBhZHNwLQ0KPiA+ID5zaGFyZWRfc2l6ZSk7DQo+ID4gICANCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiAgIH0NCj4gPiBAQCAtMzA3LDkgKzMxMCwxMiBAQCBzdGF0aWMgaW50IG10ODE4Nl9kc3Bf
cHJvYmUoc3RydWN0IHNuZF9zb2ZfZGV2DQo+ID4gKnNkZXYpDQo+ID4gICAJCXJldHVybiAtRU5P
TUVNOw0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+IC0Jc2Rldi0+YmFyW1NPRl9GV19CTEtfVFlQRV9T
UkFNXSA9IGRldm1faW9yZW1hcF93YyhzZGV2LT5kZXYsDQo+ID4gLQkJCQkJCQkgIHByaXYtPmFk
c3AtDQo+ID4gPnBhX2RyYW0sDQo+ID4gLQkJCQkJCQkgIHByaXYtPmFkc3AtDQo+ID4gPmRyYW1z
aXplKTsNCj4gPiArCXByaXYtPmFkc3AtPnZhX3NyYW0gPSBzZGV2LT5iYXJbU09GX0ZXX0JMS19U
WVBFX0lSQU1dOw0KPiA+ICsNCj4gPiArCXNkZXYtPmJhcltTT0ZfRldfQkxLX1RZUEVfU1JBTV0g
PSBkZXZtX2lvcmVtYXAoc2Rldi0+ZGV2LA0KPiA+ICsJCQkJCQkgICAgICAgcHJpdi0+YWRzcC0N
Cj4gPiA+cGFfZHJhbSwNCj4gPiArCQkJCQkJICAgICAgIHByaXYtPmFkc3AtDQo+ID4gPmRyYW1z
aXplKTsNCj4gPiArDQo+IA0KPiBTYW1lIGhlcmUNCg0KVGhlcmUgYXJlIHR3byBzZXBhcmF0ZSBt
ZW1vcmllcy4gSG93ZXZlciwgdGhlIG1lbW9yeSBiZWluZyByZWZlcnJlZCB0bw0KaGVyZSBpcyBu
b3QgdGhlIG9uZSB3ZSBzZXQgZm9yIG9mX3Jlc2VydmVkX21lbV9kZXZpY2VfaW5pdCgpLg0KDQpb
MV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDYwNjIxMDIxMi4xNDY2MjYtNS1w
aWVycmUtbG91aXMuYm9zc2FydEBsaW51eC5pbnRlbC5jb20vDQoNClRoYW5rcywNClRyZXZvcg0K
