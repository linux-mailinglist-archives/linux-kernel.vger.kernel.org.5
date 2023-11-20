Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8617F104A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjKTK0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKTK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:26:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA69A4;
        Mon, 20 Nov 2023 02:26:27 -0800 (PST)
X-UUID: 3cef2016878f11ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hStr/RGwYg1kMBYPmfbLTP0MN+Z5G0A4Rr+EtD4JFZY=;
        b=e+78D2nrTG5oZ7GnRohk1BtctHWpN+W/KIBMqNQQqH9TCflnvAiBHrkbX60RidpfDcx4svkJgJ5LPxWTIHh0AgGkV613krZuxi932xG315ewevhQ4X6qifJtJCh44XKSRmpkOE04qIWx0VqOReX/dCCtWoZXk2kBoyYpqVi2dhE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:4efc887b-9c36-419d-92a2-fd94eedb1361,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:d70dbcfc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 3cef2016878f11ee8051498923ad61e6-20231120
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yu-chang.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1617468400; Mon, 20 Nov 2023 18:26:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 18:26:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 18:26:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N02cyppSi8mBcXj9IyhTh0daW5/lcqA5vwwRqG7WMD8HuPDCXFUnZiz5tkebIIFiYxN1HMAcsETfSntM0X9EAM8N3psXDgVNG89pItV1cLoBb1W4Ed+BQGRTup8W3aDEwCy8c/v9ZdL67e6yz33LhvvFtBwi2AYevpRQdgjf84JcGGDTv8cS6W3mizpmSqsnDFJ3sJu5Z+HmI2MxSr6Eod+M559LquRWR7VbBEbfQqhEit82fgM3O/qUvf5EXarsrXqCSW5QGgL2PbdQArBFnAsY0IYSRgGtySoDu7YqO1hUMaUUVesvx1y0GUVLm8fQ2LhGNpXfWgmDZWcsg5jGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hStr/RGwYg1kMBYPmfbLTP0MN+Z5G0A4Rr+EtD4JFZY=;
 b=bNVflybuX7UXqah+K+ZvuiR+AV5RY85tPZFdYDZrxyoH8yopkrfpn1HImp2zx1FA1cB20RMV+Wxs/BrakQK7sGdRd9HqxuyQEDErDc6W6CcPU+Ca9CQ191iJ9PXLEuGzgrhhyZ02T7CYuZvMhNhFLoZ4l2D9VncxQu3Q1rJHHgHwgOUhtAQ17Y2clmMqzH73xyAlgluZhm44CrzgoSC0YGaGUbPFSZcrLpWWImL//Qj3sw/XUNjAgAf3RlBVFn1AHVnjuvRoUYuM3C3b8wDqMixrSSq7P461P8MYXNIbVansxo7jBL2qPkqzJYXLEZR6mkts6q6GjLyNBG2XLOtkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hStr/RGwYg1kMBYPmfbLTP0MN+Z5G0A4Rr+EtD4JFZY=;
 b=C1fLZXRWd/yQx7Kr18XxdTXYQm22JKzvo7kDSclFvkSVtg+F3dEpNpr4yQFIS20Izn6xymJiUI424mLRQNsaMODD9mQvtWiURdJeZSrAzNUKXcDqq7jVS/ynsXXWKOFfzssXVAuEeUxfY52I+w9ht0HIRl+wCM/jZ4zij1qNNsg=
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com (2603:1096:820:ea::9)
 by SI2PR03MB6859.apcprd03.prod.outlook.com (2603:1096:4:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:26:13 +0000
Received: from KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::7fb4:3f3e:cd86:90b5]) by KL1PR03MB7366.apcprd03.prod.outlook.com
 ([fe80::7fb4:3f3e:cd86:90b5%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 10:26:13 +0000
From:   =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= 
        <Yu-chang.Lee@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= 
        <Garmin.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4] dt-bindings: arm: mediatek: mmsys: Add VPPSYS
 compatible for MT8188
Thread-Topic: [PATCH v4] dt-bindings: arm: mediatek: mmsys: Add VPPSYS
 compatible for MT8188
Thread-Index: AQHaG5j3o6fbGXwHTkWoQaQDYJimgbCC/CcAgAAEnYA=
Date:   Mon, 20 Nov 2023 10:26:12 +0000
Message-ID: <77302f50b5c977011ec26be7a04fa3c6c63653c6.camel@mediatek.com>
References: <20231120100258.3428-1-yu-chang.lee@mediatek.com>
         <6bc4fa28-a98f-46c7-b315-7366307b5206@linaro.org>
In-Reply-To: <6bc4fa28-a98f-46c7-b315-7366307b5206@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7366:EE_|SI2PR03MB6859:EE_
x-ms-office365-filtering-correlation-id: 9c530b7c-42d5-42f5-5255-08dbe9b31ee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FYbpJIPWSj4aTnJyC0GSA/tp62iXQlj58025YWdpdi1LBGG304RGbgZMr22YwgbVDJsGWzS0dPOTlCQs7/PYobiwLiZmuQG61OPOWbmhyw7OtzPAI6J2/1tM+z/ZZgrVM2pdFEFdrwYo0renKvMlVofuC1eVBR3dZeJ1E10SmKLeAY7cJG81A6BDOmEvJY8mDjcH4llDs+k80pvtnqFcoK1WuValsD4ILE1GzGZ8biodpZxK/vA/IaHfdp9miHs5kmCqCZW1PJQzyZPtDPNU9IrJL7I5WAqn4h7VZhAEZZQFzel2DsHWiZpJWxcffMTC+ow18o4wkn5oqYS731LxKYqsYmD0houj8/UXXePGmOhBfZzM1bFuiJsMeoA+CNq3pzN0hI4OJ3UvJSJf3dlSUc95sPshukKqGeCDMadK6RB+qMceB8zqA9LPF0EO7VwScSFZXJLcP3kWnoNDLzscdbblPg78pvZMmd/uYnHoWLKaVmyH2YQpmPOk+VCl3TL/yPqvJejqt5sNZexMD8YAqfL/at0b4YrMsEgeM1uWaHKR0RWwBvy4ufJTUlAGUAvdq/YnIV6a5u8RQ9bUOOnz5wMSgcds3mW7jAzKOzo7scZoBKVILfTaBUvrgG6YWbX/qmT0wylqQ3xAh/dXXg59mCpYpXcF9xhlGt7OzvlVZOu76+NoHxAdGXZODzqDUG9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7366.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(7416002)(4001150100001)(5660300002)(4326008)(8936002)(8676002)(38070700009)(85182001)(86362001)(36756003)(38100700002)(41300700001)(66446008)(91956017)(122000001)(478600001)(54906003)(76116006)(66946007)(66476007)(64756008)(66556008)(316002)(26005)(2616005)(110136005)(6486002)(966005)(83380400001)(53546011)(71200400001)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01xaWVQMXh6ZFpJcXhnRTU1bEUxYVJFS2dza0d2a1VORytuM3lRdkxzVXE4?=
 =?utf-8?B?d1dBdENoeVpIenJEdTZyb2N2b05NVFVNSmNXNVF3M2VaUnk0NVlGQjJEUUQ5?=
 =?utf-8?B?QkNJM1h2VGtPWVFVM2pjZTRlMnhlNE5PVU5pc3ZrUlJudGlpU2NIMUhBR1VE?=
 =?utf-8?B?dis3UTBESWJMSDJHOVJRbDljZis1RlZZZmxKNVhQRENCOGpDcXJ2Q1V5eTI1?=
 =?utf-8?B?QkJvUFQwQnVvdUpVdU85M0REa1FLZjdpYU9HZVphMERZVkVnNXY1L3NVeEV1?=
 =?utf-8?B?RzdnSVNMSGkxRkx2MDZCU2pUMlpEMnBUU21uRzcwUDRaMDJzbjY0Y1FkVnFB?=
 =?utf-8?B?Y2pKQXRBSVNOK2JQNmo2WDFqQWtNek9HeEhCQnJqZjk5TzVWcTAxRVhsRUhD?=
 =?utf-8?B?NHd6M1BNbDZyWmJBUkNHOEhkVmhJd0h0T3p2bVpmV083TEw5NHA5bWp2VjRK?=
 =?utf-8?B?VUJvYm94cGVHcGdMa1VKak9Odzl4bjNpZldoNGdWb2w2SVVMU0ZscEp4SkJz?=
 =?utf-8?B?ZHVvVnZCWTFGUkZ6Rks1Z0VCVjlIUC9WVmdCOWh3V3I2SlZPMTF2ODJDelg3?=
 =?utf-8?B?MzdsTzBoZFMxOW9PMWgxNmRpQld4aW9yY1dyT1Vwd3QrSUd4ZHNJNmFJV1ZQ?=
 =?utf-8?B?VHNRSnc5YlhvSjNqSzZIRUVZQ1JnVUtIb2hrbHduWWJMTXVNMyttUVNQY1Qw?=
 =?utf-8?B?amh0cjdabW1MVHhhd2dLYi9pOVR6MXVMNzhRTmhGL3Y0SFhma0JENFNhN3pC?=
 =?utf-8?B?Mys5bUUwMGdvcXE4MWxEVGNKZXh1NXRSZWNmVFl1anhNakQ4Snk3M1RsUTNM?=
 =?utf-8?B?a0l5Q2lRQjZjeW9NRnc5MEpraDlOZ3Z1cnlsVk0vR2M5Q1ZrWmlBZ3FBcU9S?=
 =?utf-8?B?djJXd1k1ZXc0c1VORm9WMzc5QTFnSnZ5RlVEc3NrTWhUZW5Ud3A3RWdDd2Jz?=
 =?utf-8?B?SEFuYjFtc3B4cG91U3pTZmU5dWNVYWI2QlByVVhReDJpQ21GY3BzSjI3Y2Uy?=
 =?utf-8?B?Q0hKL2RqS3ZWLzNyTUJMTWFtV3AwMktDTnFzNVpBNi8zKzZQK3J5RmoyUU8z?=
 =?utf-8?B?WEpiYXVJYkRweVVwMGhPQUdkUXh3NzdRMFl4Zy8wbW9DM2hEcjhpVC9SRGZL?=
 =?utf-8?B?V3NjVjBJMWoxcVBnZUtNMnA0bGZFOUl6R1NjR1I1ZmM2d3g2MzA4dzQrMWFt?=
 =?utf-8?B?SFZ2OUlZSlErbTYxSXQzdkdJd01ucUZaU2JXbG9oWGRwM3djQUpuZUlXRVFq?=
 =?utf-8?B?SmViZzc0Uk1tT1dtOHh5aTdFY2srNWJHZG44Ry94bGJHNWZOUHFaSlIxUFJx?=
 =?utf-8?B?MnhQZXRQRTdLZjZNZXA2WWEvYXVJMEVjSjIzOGNaSy9QRXZRTTBYcmZvWFNF?=
 =?utf-8?B?K2grSXJ0eHZrQmVSN2szbmRnWnJNNkl0WGxxUWUvQU53SlJRbnBhSldDSWYw?=
 =?utf-8?B?c2IwdUZrSXNXVlBPbmF4RDM5U2hIdEJ5QzJ4WFNoeXB5SHNpYzM3YlhKdW5r?=
 =?utf-8?B?UGdqZzY5RDRFSDFQMjBMaXd5MWZqK1VxSGpEQW5KYW9KODlsMklUcEdVZ09n?=
 =?utf-8?B?bVU3elA5UkdGWm1xUERpaDk5WHU1dXJKUGpTMWN1ZG5wTitmM3c1RHMvZ3RT?=
 =?utf-8?B?bTNwdm1qdW1SR3R4K2pCZmpSd0NqVGt1QUZDajByY1lwenUxNnBBNmdDQXp6?=
 =?utf-8?B?L3NKak5HazFJZm54UlUwZWtEL1RSQU5RT1ExL2hVRFZYOVo1OFNCcEEwRDBV?=
 =?utf-8?B?MC9KWG9mT1NSNHJLUEZJaXk0Uko2dW9FbVpHUFJ2STY0OUxTQVhiak9oUkRM?=
 =?utf-8?B?ajlhNkpQazlxSWk3U0FoZXRCcDZkcnRIdURmRDRGVXloWlExR3lNd0FJWVlO?=
 =?utf-8?B?ZVl4a2ZaRTl1NllkUDk3WUxZVW1zdUdDL1J5RnUzdFFjclYxT1pYTXlvL1lG?=
 =?utf-8?B?ODlvWXBoZGJvMGF4M2pEemc0MEVDV2NVc2Y0UEIraXZudFNrdHpEcmxUc3Ry?=
 =?utf-8?B?UUk3d2psaUc0aVFKZzlDMEI1cDBqaVJLSndVNGNtNlE5QnlkR2thM2VFNHpI?=
 =?utf-8?B?VzFnV1lTaTUzODY1Wm9WeUdvQmFkZUJGeFJZb1p1Wk9waWczeVRtUHIzN2JX?=
 =?utf-8?B?MlVyZVpqRWtuOHYvdnhneXY3cXFFcGJ5S2JQeGlGSC9MaDhGVURZeXU3VGZu?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48F934F9F51FEF4391060BAAC3823447@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7366.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c530b7c-42d5-42f5-5255-08dbe9b31ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 10:26:12.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/ryCP6HqTC/hQ+QDt7LjHHrWIgM+q6XOJUqD2f4f24cggIP/K13bid7CrypskNqJ4jdjAavn4fDXZWunhuG8IzVCHFLDsqxcypNFP0J7Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6859
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTExLTIwIGF0IDExOjA5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIwLzExLzIwMjMgMTE6MDIsIHl1LWNoYW5nLmxlZSB3
cm90ZToNCj4gPiBGb3IgTVQ4MTg4LCBWUFBTWVMwIGFuZCBWUFBTWVMxIGFyZSAyIGRpc3BsYXkg
cGlwZXMgd2l0aA0KPiA+IGhhcmR3YXJlIGRpZmZlcmVuY2VzIGluIHBvd2VyIGRvbWFpbnMsIGNs
b2NrcyBhbmQgc3Vic3lzdGVtIGNvdW50cywNCj4gPiB3aGljaCBzaG91bGQgYmUgcHJvYmVkIGZy
b20gbXRrLW1tc3lzIGRyaXZlciB0byBwb3B1bGF0ZSBkZXZpY2UgYnkNCj4gPiBwbGF0Zm9ybV9k
ZXZpY2VfcmVnaXN0ZXJfZGF0YSB0aGVuIHN0YXJ0IGl0cyBvd24gY2xvY2sgZHJpdmVyLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IHl1LWNoYW5nLmxlZSA8eXUtY2hhbmcubGVlQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgaW4gdjQ6DQo+ID4gLSBTcXVhc2hlZCBiaW5kaW5n
IHBhdGNoZXMNCj4gPiAtIFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gWzFdDQo+ID4gWzFdIHNvYzog
bWVkaWF0ZWs6IG1tc3lzOiBBZGQgc3VwcG9ydCBmb3IgTVQ4MTg4IFZQUFNZUw0KPiA+ICAgLSAN
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3Bh
dGNoLzIwMjMxMTE3MDU0MzQ1LjE1ODU5LTEteXUtY2hhbmcubGVlQG1lZGlhdGVrLmNvbS8NCj4g
PiANCj4gDQo+IFRoaXMgcHJvYmFibHkgc2hvdWxkIHN0YXkgcGFydCBvZiBwcmV2aW91cyBwYXRj
aHNldC4gV2h5IHNwbGl0dGluZw0KPiBpdD8NCj4gDQo+IA0KPiBBY2tlZC1ieTogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgZWZm
b3J0LiBJIG1pc3VuZGVyc3Rvb2QgdGhhdCB5b3Ugd2FudCBtZSB0bw0Kc2VuZCB0aGUgYmluZGlu
ZyBwYXRjaGVzIGFzIGEgaW5kZXBlbmRlbnQgc2VyaWUgaW4gcHJldmlvdXMgZGlzY3Vzc2lvbi4N
Ck9ubHkgdW50aWwgbm93IEkgc3F1YXNoZWQgdGhlbSwgYnV0IHRoZSBkcml2ZXIgcGF0Y2ggaGFz
IGFscmVhZHkgYmVlbg0Kc3VibWl0dGVkLi4uIFNob3VsZCBJIHJlc2VuZCBhbGwgb2YgdGhlc2Ug
cGF0aGVzIGFzIGEgc2VyaWUgYWdhaW4/DQoNClRoYW5rcywNCg0KQmVzdCBSZWdhcmRzLA0KeXVj
aGFuZw0K
