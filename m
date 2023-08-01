Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62C76AAE4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjHAIZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHAIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:25:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B089610EB;
        Tue,  1 Aug 2023 01:25:45 -0700 (PDT)
X-UUID: ff773918304411ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=QolUfRyVQ41dCWkW2/rXksbII4PK5scwVM/X3ykBsuw=;
        b=FOi2Cb0SgfV3k4dBgJ9N+t5njHhSt0Epojb8sUbfb9tsw2z/Cle14ijdra2xbMK8cSkROasH+E82grZNRJEu0JFa+npJEs7vgdnINNPsAoMHh7pM4sGBZIck124o7knbgYDE0cF2nbDxWsOquMyrIB2Rnr/fzHmY5SVP7fwfYW4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:528cea64-3f25-48f4-9d19-9b2340923a02,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.30,REQID:528cea64-3f25-48f4-9d19-9b2340923a02,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:1fcc6f8,CLOUDID:a38d8ed2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230801162541N16XYKC4,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS
X-UUID: ff773918304411ee9cb5633481061a41-20230801
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1144823888; Tue, 01 Aug 2023 16:25:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 16:25:38 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 16:25:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuoUaz79wQXsREu+xTLbHZjCvVIe1PcTI6rN6HrI+naK8/+XbmmeAYSX5a8Dhtoq3+QfIqut3833AoXODWUqmsCzpSYUVJcNbIdVYiolpBn5UkYL/StWRt5Kyahkqu31yAi0IvvRiHCgBeMomRZLjBNS8LmUBsnKF3y4Cw4PBC+WQDDMFv1uq3xVutVm+bHXG4jclABDtz8sq2J2J5KZZxPtwCwyZH1goGI8Ms6g0UylEy9VkmsF4jqdF7/wJfeqazJqG+7At6TjJVAjRp5t3wBGNPcZGBkc90pjMWm2/6p6iA2alj2w9zbys8yWKQ8Z8et6WwsNrcS7sxF+14NaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QolUfRyVQ41dCWkW2/rXksbII4PK5scwVM/X3ykBsuw=;
 b=NSLFIbJD1fDKL7P4MHC16U8l3m8e44SceSsXc82G9k76t7XSiZlhmFGN3QhpcqoXSe1GzSUEyV9dEYCCYwUFrl9LGX1aURpgXqkMM9gDxd/h1a2WvP53D8U+DiPMaA7ybK7ERlpGZhcl39a/POCkxYN+dyJVW3M5IoWyPrJt0pn7zd83c+ODFsDPgfZSqeVBVfS4sh2qFtWzUwDk7AD5a5Zw4Dk6Xe29NFTMpjijUjM2t0hdWLakNqrq6aF1opeO0Z/Zxm9oerkS0U7XRGXH/DQJNCmU+90NkBCDqPtCch3MTPeoHNtJkKk74uuDxmAcgU0vQMZNhVZGoXHFkVmxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QolUfRyVQ41dCWkW2/rXksbII4PK5scwVM/X3ykBsuw=;
 b=mVPIJwxN8uFVktWyW9K1VqKplpPDPb1f5FWQgHbpKsVqK8gpaKFmnb3YbksT/pOJMdVox/sUakYwgdlPNr/OL4uvNQ3ljF7sJCgkbxI91MteLMqq77r9llOK6ERY9FkTSc1en0oeqaRyo3Kd6m16i3WJkZBhGaMpFhjJYAhD4IM=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB7638.apcprd03.prod.outlook.com (2603:1096:400:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Tue, 1 Aug
 2023 08:25:36 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 08:25:35 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Topic: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Thread-Index: AQHZwTM8FwajV4doNE2aIAHm/Atkhq/PIgoAgAX/CwA=
Date:   Tue, 1 Aug 2023 08:25:35 +0000
Message-ID: <5d005f518d974b7912c832101b5cfbde77f57270.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-7-maso.huang@mediatek.com>
         <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
In-Reply-To: <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB7638:EE_
x-ms-office365-filtering-correlation-id: 17ff0166-c023-41d3-43be-08db9268e150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvhV1ylR/VRt5gphOOLeKeMpBpm4Q4SJU286KXiV/4MpKnMpZheO7R2W3E7JYLTjJ0iFDRkhXEvcswA/Rfk922yBZSA+Z66KyR3HfZGeOULMETd+H8docBPdCUxXZYII1VxevajqP2TLzAqxB8cH0OLnIUEOREdSBITjCK96w1CKmJSeTe/kIIU39k5/Olc7jREutCAf3jWJPiL4AfmCYN73pfmmI1oo0S1URQOmqfWNuouXBTaS2EpSGaEt6Q7phrm8NPMVCTMwT9vPPvLU2loNCSWMsz/L1FnMNx4Bk9Tz7bAzk70jlSFXexhVR9ymRCOXEOmhYZMQMUwnUJuN8EIXquiMIB9S+ug8wPl4J3ZPlecVwjfCJ3rI1b2+6M3EXVNC/2g7kUiajsbyBOM4rDC/6y2+F8TaZH8RGH/JC6Ane4/VFbNA74pAIu6mBDkmG+4kdxUQcOvlFs+McJEdjeiEQwCmUi5NZgouaYPrPQzdl82Y0iHEmZUnxmLJvqu8ToeA8S61XkJB9kKI7NXca5NnwBUjsVJQb6NLZPHW7Q35MF46Q7Usw5Lq7apT3W+2ZEti/HOQIKqrvD1tVXdbudJy45ZhtY9TJlOYMOsI8M1CMQurIujACJ8C5hgqM6u117rPVA2gTD+xTNWuo8BWeF1037pkPGgpg1j6wkwLpacM0eCM2hnrk88KIOwBCve7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(64756008)(66556008)(66446008)(66476007)(2616005)(66946007)(83380400001)(41300700001)(38100700002)(86362001)(921005)(36756003)(5660300002)(85182001)(122000001)(8936002)(8676002)(6512007)(6486002)(110136005)(71200400001)(26005)(478600001)(316002)(2906002)(38070700005)(7416002)(76116006)(186003)(91956017)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0tHWmI1ZlJveVVSWXV3VHNBRGhTdDZBZ3pyc1VPNTBYczc1ZEQxcEtkMEYx?=
 =?utf-8?B?NTZvZlFsZnFCeUJpRnJmTWZWcmQrWVRuRlNsMTNnNmh1dzEvV3duc2FGaUFs?=
 =?utf-8?B?ZEF5UVBIRUNtK1RFMjRDOGFacFhCSk5CRWYyeVpnSXdsUmg5Zm51aS82YWZr?=
 =?utf-8?B?TU5FeG1HV0JlOUtLdUJJMlhFNFdKSUZQMXJCRUF0TkxhazYvSlFiU2w1SjVm?=
 =?utf-8?B?ZzU4N0FTeHlwcVJ3TmdRSkRPdW11THMvQ2w2WjVrY0RiSzQ3cm1PK3VMUjha?=
 =?utf-8?B?d1d1WjhTVS9JVmdnRGNtanZtbjU3bmlLMXh0SUs0bE0rUzAwWHc3SjRFUjJu?=
 =?utf-8?B?TkZOVk5kNTRtT053SnNDeExCNC9GS3BrLzVXc25EWG5abnJPRmQwM1A3Qkp1?=
 =?utf-8?B?RUFNdWMyK3JCd29ITzR1dTlLN05ENy96elBUTC9pVjdNR2tKcXdtVThoQjVO?=
 =?utf-8?B?cXF0TlJhK3hUbnlzY09LQVFuNzhhUTEzaWlKaFBPREMrYWJIUGdrNTZ2Q1Ex?=
 =?utf-8?B?a0d5VVZ0UDVyWGphWHp4a1ZlZVora1RXU2g4UnhuUUcwUTk4VWY2anpjNzRs?=
 =?utf-8?B?Q0NXTm1vTjJUR3gyNHpVblY2bE9tcUxWWXd3TkxFblErdWtmZjErQ2dXbDFr?=
 =?utf-8?B?WWdteFlLbFUwT0QwVU1TWEcvS3pLQUZBRzlxVkY2RjhBVU5CVTFGQTlxQlpO?=
 =?utf-8?B?Q1JRMkdWeUp5a1R5Z2czZ01UTnkxTDRkMDNnc2pCU01MSnhPTTB5dkV3R0xm?=
 =?utf-8?B?QmtuTStpa0FXWGkzN2RBZm9ZVnl5YVZmbkJiSUYzNFJPK2g3djVyMGNsTEFD?=
 =?utf-8?B?dm9NN2NzbXM0L013aWF2aE41VE5rWkZVR0tVS3hkMEVXRnh2MWpPQmttUmd5?=
 =?utf-8?B?a1ZNTzBsRitJeWJvNjdaREJqU0grK0VsRVdRY3Vva0ticVduT1gxQWlKcTNE?=
 =?utf-8?B?Q0hjTHcrV2NOczBVcXY1dGdTYTk1Sm5xaUVXdmxoa3NMc0Z4RjRpQUdRV29C?=
 =?utf-8?B?cExMS1ZMRnNLZVFKRnVadFQ2a3k3U2V5Z1MyU05iZjltc09jR25YL0VITlRW?=
 =?utf-8?B?M0dZbXBPQ3pzeFR6dkxlNlgrayt1SHF6dGJZZDRFVkdVYXBDV0pBaXUrYmEr?=
 =?utf-8?B?MEIwUGoxaWI3N2ZON2ZRdlhYd3dRb0hFb1ErQkhpRyt5Q2h5ZU9ESE5DeE5x?=
 =?utf-8?B?RS9wLy80ZVdsaDByUlcrdW9FbFdPZUJJSWgxaU8xdXh5VEE4OUdpQU1ncjl4?=
 =?utf-8?B?YjV4L3NvYU15cDZlUDhlRWJFR2ZER09jS3k5ZmJkV0RnUHJpclVSNW9wQkwv?=
 =?utf-8?B?djRrd1ZrZGJVcEh2cnY5enh4emNDa2ZEdnJoZ1plTVBsSjg1LzFzRnZCREdq?=
 =?utf-8?B?WlNSYlR1N1l4Mk9zOURJVjZ0NmNWc0ZGT2NTTXJoRHJmRHozVytwZ2dWcVNo?=
 =?utf-8?B?aXVJWlJqTW1KNk5VeVY2SHdmcTkvSXdkcEJuaXVYWVNPalhtVFpnaUpsYjhn?=
 =?utf-8?B?RmErVm9TekN5a2pwK05CNk9uQmVoRnhPaW9LQm95aGVmOG9zRHBLdUJTZEZS?=
 =?utf-8?B?TUZTMHVUaFdtR1BlSWZIdzRFalkxWXNsU2xtVVNkK1YzdlV0WksxMXVBWXRY?=
 =?utf-8?B?akplaDZkcE12UmdhWEcxQTF0UjRmeGFDbHo0dkRzV3ZQZ1Y5dEVSeW9YT2th?=
 =?utf-8?B?cVlEUzgxS2FpNklheDhwUUZjVnk0Mkw2RUVHTmtmTUxqWmRSd2RZbTZYMGpx?=
 =?utf-8?B?NHAzVWdOV1c2UGhHRjF4a1RheWFUWXVUOFgrbWQydHZ3Q09DMTFhbUloaHpE?=
 =?utf-8?B?NUpYbllTQUF4UkFVQi8rVUxjbEl3eVFIRUlmU0tRemlqYW9UR1Z3V0dlUFVC?=
 =?utf-8?B?OFpLOGs3ellrZ1MwbmJFR25YZ25YRTRIVWlrOVZLditzSFgvSTFId3A3TG01?=
 =?utf-8?B?bExsQmc2Njh4d1FLa0lTay9QK0V1bExoQ0tQbjBXSlJ2L2YrNG9LSzN2azFH?=
 =?utf-8?B?WXAwSFhyUGVxQ3dqbUhqVGNNR1E0ZnNQb0lpZ1FJWm12eitEbGw1RUJBeExi?=
 =?utf-8?B?cWVCU2ljL1M3SWErUE1kc0hUKzI0TTBHbnAzU2VuTWpEWjB4OHlwWlRkUXU4?=
 =?utf-8?B?Y2ZGWXowWEpjWkxHUkpQbXhKSVVVMmtWeEdrMUVVMWl4allQNHBzc2cyWFpS?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FBF2DEB0A179E4EAF222622CF5E5DD9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ff0166-c023-41d3-43be-08db9268e150
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:25:35.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJMVQxsOQgzUUSAhZ0NFSZGHh3sRQ/YIKYNF4lEQ55zohTS6trCPqyGn3m3hyI7jPadcsrwjyEESBu3YBjOhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTI4IGF0IDE0OjUxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDI4LzA3LzIwMjMgMTE6MDgsIE1hc28gSHVhbmcgd3Jv
dGU6DQo+ID4gQWRkIG10Nzk4NiBhdWRpbyBhZmUgZG9jdW1lbnQuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBUaGFu
ayB5b3UgZm9yIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNvbWV0aGluZyB0byBkaXNjdXNzL2ltcHJv
dmUuDQo+IA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4g
KyAgLSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0g
Y2xvY2stbmFtZXMNCj4gPiArICAtIGFzc2lnbmVkLWNsb2Nrcw0KPiA+ICsgIC0gYXNzaWduZWQt
Y2xvY2stcGFyZW50cw0KPiANCj4gWW91IHNob3VsZCBjb25zdHJhaW4geW91ciBjbG9ja3MgcGVy
IHZhcmlhbnRzLiBJIGRvdWJ0IHRoYXQgdGhleSBhcmUNCj4gcmVhbGx5IHNvIGZsZXhpYmxlL29w
dGlvbmFsIG9uIGVhY2ggU29DLi4uIG9yIG1heWJlIG1pc3NpbmcgY2xvY2tzDQo+IGFyZQ0KPiBy
ZXN1bHQgb2YgdW5pbXBsZW1lbnRlZCBwYXJ0cyBpbiB0aGUgZHJpdmVyPyBCdXQgdGhlbiB0aGlz
IHNob3VsZCBub3QNCj4gcmVhbGx5IGFmZmVjdCBiaW5kaW5ncy4gQmluZGluZ3Mgc3RpbGwgc2hv
dWxkIHJlcXVpcmUgc3VjaCBjbG9ja3MuDQo+IFlvdXINCj4gRFRTIGNhbiBhbHdheXMgcHJvdmlk
ZSBhIDwwPiwgaWYgbmVlZGVkLg0KPiANCj4gDQoNCkhpIEtyenlzenRvZiwNCg0KQWZ0ZXIgaW50
ZXJuYWwgY2hlY2ssIGFzc2lnbmVkLWNsb2NrcyBhbmQgYXNzaWduZWQtY2xvY2stcGFyZW50cyBh
cmUNCm5vdCByZXF1aXJlZCBvbiB0aGlzIFNvQy4gDQpNYXliZSB3ZSBjYW4ganVzdCBkcm9wIHRo
ZXNlIHR3byBvcHRpb25zPw0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQoNCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo+IA0K
