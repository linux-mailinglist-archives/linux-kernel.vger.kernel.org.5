Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A320807274
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378878AbjLFOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378823AbjLFOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:32:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BDE1BD;
        Wed,  6 Dec 2023 06:32:34 -0800 (PST)
X-UUID: 45cb173c944411ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=n31F79xicJLV9kdh4bPglO/N2KcREtR1K/ug7XH0AOU=;
        b=o7hc01n1tc2MdsBIirMmLdUGSCk9aIbbCHx/CFkVaCbbg8WMp/GZz/roioAUHr4/wntiwYvgP6d79K7HqcCjwR//xsapyJf4c6Vh+g0XDk4zvfpog0W3USD0VzVQ64il5hsv+20QwYtrCuSTtaZ971hk0QXAewq4CSByCQ4lgRM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:75db640a-fbba-4163-9fed-2974414e55e2,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:abefa75,CLOUDID:f8007b73-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 45cb173c944411ee8051498923ad61e6-20231206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 222927527; Wed, 06 Dec 2023 22:32:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 22:32:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 22:32:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVisedAbC9swKkkV12KiIyaF7xUWzZyDyRd6aDfUwfMX9bDZIFqJ/PxCEN+6afkwyi+LlplBpKs0eIOiVeyGs1uOg/X60AHAAjAQDbGsurVp/Mgs5JuoWlhSdUGEXOD6oZLWt7bDj5AzxLgTisnTgWro4AVhidFJlMbj0JYehXTGE8YCpu3r9Hg3CSE0Q0o5aVRKtw+euVgXPGR3rAQKrzeHzYV3UkbyD7Qpk5dkmF4B9gIgZLh3kYgbNJastA3ldoDpYleJQt1RYegoxGBqlb1jV+HaSitTXLgl9OapSWOJyV/bwYaoVcE0H/OUdmXpjWX8gjGKGWPc8ZYijsSeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n31F79xicJLV9kdh4bPglO/N2KcREtR1K/ug7XH0AOU=;
 b=ZnhinBG8kAYSalcWTuJzpW9/OCSlpyCp28HUtq2WxTi2vJc+BlRhehHnj5UevZJ2+q52JHTUjjnzwlVgCkv2BEkbj3UU0JIiZ2G5WB0YPWWoCiujZIExlmX6TJYUcJUzWfi6ydbiiYt7vlYrSRz+5199202yorB8p3f749qh3b7iSdq6zBxyR/O881jDrQgYsJjvM1j++ouj09o763HeIefVKyWbH5z2xHWkD34q+wxAMn6NaX5z5XtXoYIw0IYjiMgbBDBLmp+FHT3hD5VgOvxvernXEyvLtmIcTiEqKBQsknyMxVKyv/yChVbQGJqGWKqmbsgpUz0OoLNgYS4+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n31F79xicJLV9kdh4bPglO/N2KcREtR1K/ug7XH0AOU=;
 b=BgkXkf95I/5bTepklIVXq7RLNxtjj4JwzdJdv4AN1/Q15U6PAAioF82q8MbvToqLParLSsg1KhqNYweBV5vvfdV5iocIgtKJEwVKx3ZPJt4TbAgxR1oDOT68Kqv7seO3kn/HJYxnHPFIVNk1K+PnFMgKgnZNWjIDxZqSR/7jWxo=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by SI2PR03MB5786.apcprd03.prod.outlook.com (2603:1096:4:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 14:32:20 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::66c6:e98b:f23d:2d84]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::66c6:e98b:f23d:2d84%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 14:32:20 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Topic: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Index: AQHaDNPevanWicGux0eGx3l2bTLI9rB9I2wAgB9k8QA=
Date:   Wed, 6 Dec 2023 14:32:19 +0000
Message-ID: <9051236e98194f0358bb197a4a425d3fc0d4aeac.camel@mediatek.com>
References: <20230916113327.85693-1-bo.ye@mediatek.com>
         <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
         <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
         <CAJZ5v0hSeCcpOr4qOpji8sbN89GnsYYc1pYBhV+LmS=TiJQMnA@mail.gmail.com>
         <c8d305f8b46287d86a49a887983ff2198cfbc297.camel@mediatek.com>
         <2f6530d551665e87cdf0331ecb223bdf4feb2435.camel@mediatek.com>
In-Reply-To: <2f6530d551665e87cdf0331ecb223bdf4feb2435.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|SI2PR03MB5786:EE_
x-ms-office365-filtering-correlation-id: 2bc22572-e73d-42e0-ce85-08dbf6682757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BD1Zy+A5u65bnPYlXBblX223uwJ5vwBUGQgYzl3V+PQphRxubE98Q/RCgLMy6BU4hGPLh2aYvCMzFLhPn0ykdQZ88Wz8Obtcmuk8cZTCCtYWTSl0HPIrxGGVzFOKlWn3YS0jbLDU+JffZ/VWlAc0yO5zRY1Bq7ZdgaOvW75WauNnaQ4KASsnj5VJLxTU7od8/5Qlsc95/79G4jkEI5pPwbE6PX3mpHZW0pkj1NNZKtwIi0T8OzoCMfY6BnOmye+3/QJNtUfKnUbXjZkuMVVgbGuOHVKQgWELZwxv3X8JCFe2mTtpjtgDbwb433Ua2wbdKB+z2Swk3hyQKtE8Hj3+3aLUsOBz6z1eYDtPWccvLfSZu8KN//rJxPRLFVqzvBd4GWKq995rQUiCdaqgupFwDkfFJQW9rob3lSX1WF7txhRwGU9c3pMWc0dC+sKFBTHxl0aGnnMFUrksYB1buZEATszsZiMF3MuuKEXyxZr0C1ZV6w6OyJYNOSE/0MFBn/+NLCLNOwwB/oXoSg6BewyQ1VkBKiNRQ+Ul4JYgnypZLLZbto5O6ggTI+eLZFP23pgHbdbw9uRXCPV2bfEFNSofOtB8KePa3EaedVAHSkcs4HaUkpHysVlKQJb0fH4OGGAlnKmf/4BddxRa6bFhoQN5c8BiA53JsrMe0SoYUYYOsTZ6XGG9NOryZaJ56iG7+nI3cdc3/hIroPPDzO5bYY/iCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38070700009)(316002)(478600001)(91956017)(8676002)(6486002)(53546011)(122000001)(2616005)(6506007)(71200400001)(26005)(64756008)(4326008)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(6916009)(83380400001)(8936002)(7416002)(38100700002)(5660300002)(15650500001)(6512007)(36756003)(85182001)(2906002)(86362001)(4001150100001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2s0OU10S0x4YjZXQW5CU1dLMklpRnVRdHMrV1NmQ1E4MG9rclJRWVNrNjFm?=
 =?utf-8?B?L0MyZGh3NzBTR01aUFhkbEk2RU1rYkRMS2V6NjF0NW9ZQ3doK1g1VXlrZEl6?=
 =?utf-8?B?Z2ZlNWc2em8rUUhLRTBLYmhsTTNnYTh6ZnJXMHRqckd1UzlQaG42SHcvUGVL?=
 =?utf-8?B?dFVkdzZZQVBhQkt6cEJoVk92YTgzeG1qM0Z0OFlseXpTdFlmOTd6SXRUcERh?=
 =?utf-8?B?ZnRXMVJPNk5vMkp6THRPbGRQQVZTdlRYZnNUYWlMbFJsRjRQVjhzendMTnc0?=
 =?utf-8?B?dWNuQVlVeHU5QUxYRTRQdFhsdkFTbFlNZ2JDRE1lR2pTemRUQkRTVUFycmM0?=
 =?utf-8?B?TGUwbDhLdm5mQ1dGZmZLMnNvTWpKa2szdmE2dzJxZDIydXY2a3V3OFdFUWQ1?=
 =?utf-8?B?ZFFObzN3SUpsRlhEUDExaVI5eGNCRmwrQ3B6UWFUcmRaaWxmYmFhQnVvclJR?=
 =?utf-8?B?NHQxQWhKOWpxUUZLVzZOWjloNXhUZkJlOWJqOG5EVFlwOUNFdUxzcEVCSVRl?=
 =?utf-8?B?ektRNHZzM0ZrVHJ0TTZTU1FDQXQ5TUJjajJabGxvaFJweWc5TDZxVFd3L0Jy?=
 =?utf-8?B?RlFWNUJSbVpQR2JoSS8vUnFWWmVyOVBSTjdMKzZab3g4SEMvOGg0K0dWMjJF?=
 =?utf-8?B?Smc0c3M2TGNjUWV3OHpWOFlpeG8yOTB5RzVhcC9CUXVSVmU1U2R6RXNRQmlU?=
 =?utf-8?B?aGxaT0xYZ1pqN2IzckhYcTVVZ2dCcFk0dVB1TGxEQW4rYXo0ZFhlZkFwcGh2?=
 =?utf-8?B?dGJsbmJQT0RlZWJ2Q3Q2YUc3WWd4Z1Y0aTBxTUZZV1d4RmhCYnBxMjZuWE8z?=
 =?utf-8?B?aTVvMHF1RGlQenYveGFYSlFpRjVCMHNwYWJRQXNBa0VDU2xuZXVFQUZtU1dK?=
 =?utf-8?B?TTJBN3BKTHg3OGUrWHMyeUlLREZxNmUxbDNhaTlNTE1UN1hoOXdINmR2ekNj?=
 =?utf-8?B?SHE1dnhxdWhTT01HVzRFVUNoNWNSOXVZek5DSzlUdjdEUDB3SStyYndMcDAv?=
 =?utf-8?B?L0Q4dGhLZ2xRdENzckd3YXU5d2NsMjFONnQxTHhMaHVRWjcxaGxWTjFOQ1Jr?=
 =?utf-8?B?WnlkZFdNNldXd0FHVGRKd3lwR2tNTlRlM2hvWlZwdUxwb3VlRkIzSHNNS3E1?=
 =?utf-8?B?eWhaK2ptUjBXekxVVzNMaWtEZXFEUXR1M2w2dUV5eXFmQjJUblBOa2xDSUY0?=
 =?utf-8?B?dTJJdVdqZnRkMXpVenBDTGlMNEViTTQ0V2lLUHJNWGI3OVdjNXB4RDJ1c1Bj?=
 =?utf-8?B?amorUXNtanhjNzgwWUVaT1pKTzBwcmNjVklCUEhvNy91dHpSa2k0SjVXZ0V4?=
 =?utf-8?B?MmJkYlQxUk5sZkxqaFhYSFpyRHJnTHpqdFBidG51ZFV0MUhwblJYdGRrZitS?=
 =?utf-8?B?dDl1R1NqdUIxbE9ZS09yOU5JbUlSTmRZTmpRZU0yQTZRWlFkSmY5SEF4aEht?=
 =?utf-8?B?Tld4ME9vNlpYL2RxQ0NyYlhybEVwZktSNUtFMmRiYVpra2VDUFhmZVZoN2VC?=
 =?utf-8?B?VzliejlKSUJZM2NpRFpneHRhVmRxbDkvKzVxZlVTTnBCamxtQzByb21lU0pn?=
 =?utf-8?B?SWs4bTdObDBReE5UY3lWc1JERnIzZmNqeGd2cUQ4a2xFSkxyUHBuR1JRRXNI?=
 =?utf-8?B?a0FRaTI5dFQrRUNwTlRFMEF1QmFsY2xPR3R1Vlp1MURBUEY3VDM3UVFuaENK?=
 =?utf-8?B?aWxpcmJWWHpFUDVVRTF1Y1QreXd3TElpNGZtdS8yUCtnaGxnNExIZHVZTUpR?=
 =?utf-8?B?a2daWUtOdlcxcjdXNWdCOUlkbUtYQTFoVmVYV2EyTkZoQmM0TmFzTlFGaFUr?=
 =?utf-8?B?QjM0SkxvZlBrRm5IYjdYb1dqVjJ1Z01ocVBYR2kvcVhoTzBFdCtwdnN5SUt4?=
 =?utf-8?B?WG1pMG91eXQ5YWQxYkhibXJnemVlOFRRWGJDTzRvQ1JJdjI0TVBKTkhMWS9F?=
 =?utf-8?B?ODZ1V3oxc1lCMHZRRHBNRkVlNFNLcjJUWVE0NDFqR29VbVJ1WEwyU0lJSWp1?=
 =?utf-8?B?azZKRzIrNkcySE5tc2c3aGNERGpURGFXazAvZFNYNjNCNVk4dWZSbjd3Rlpi?=
 =?utf-8?B?VEV5cGlWR0MvaTRYZkJsTlFrcWlLaHBKL0ZzaDZUdFZNMkpBSFFjK0x6L3pM?=
 =?utf-8?Q?/VvENDdTJNjIeOPI+/paOKirV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <240B95205990C94280596E13E3404DD4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc22572-e73d-42e0-ce85-08dbf6682757
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 14:32:19.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmhhxkomfc5yEiXOTsr5clDvOsnbv5BGfVGARUMRvFDj5NOiY3wwktoIEi4gR4HiRR2xN3yDIC+CJ/s+/lszBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5786
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.790500-8.000000
X-TMASE-MatchedRID: /77LoUQXvQ9oR8pJe2OQcya1MaKuob8POhJ9m53n4aAY0A95tjAn++yV
        M+eG9WifAa9+YM8LMtFO6CI7rIh2ivDwiplDZf25mlaAItiONP2Z43ybYV0aJ4O/UIC+qP94wg3
        IxeTkv4jZAFMTSY1TNubxLtBtX1lLcNPMFJIX+nOrVklnbP5Jtr574JQAXc+htXl9IxEPXOrhFA
        mHAchnboVObQUevjtqTusmWkECHhMsia1sYU8Nle7KTDtx8CggkKAa/khZ3iRHZg0gWH5yUT1uZ
        lSSRLdY2tUB1fUPpqliEgb3ryiNYAvuBkbttOjiXP5rFAucBUGnEB3qaLUZrUaEuXPXlR5qEIb1
        3yAeqGw1niZbDeKaKiYpplBNDtiwhEy3/eAjCRhmDWLbBOZJw23eqxoVjgMEJxXJwKAKea/IT07
        FSqH1vzt5/UisYj5OMcU9NEu4RFJT9yNhC6QSghlckvO1m+Jc9Nx/wC/5BIBPnGDTa4GHDoCuqg
        hmtWfX49UDn6y0n8OMQThPoGBHwRXmXQTdJn80EwyZyuMQ412Z2scyRQcer/HFoBcOsKez1QHAN
        Kou0PARzw695MTyJzyql6CYqfcHrO7gb73egJkVglQa/gMvfGEF8bGZ0cKCpQhHxZgJnzKjxYyR
        Ba/qJRVHsNBZf9aR6A6rUGAnOXcLbigRnpKlKT4yqD4LKu3A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.790500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 42C454BBC3E55C3FA81353558F97B9ED6B7571E2FDB65155A600E9CCDB63FDFF2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTExLTE2IGF0IDIzOjA2ICswODAwLCBCbyBZZSB3cm90ZToNCkhpIFJldmll
d2VycywNCg0KICBQbGVhc2UgaGVscCByZXZpZXcgdGhpcyBjaGFuZ2UsIG9yIHByb3ZpZGUgeW91
ciBzdWdnZXN0aW9uLiBUaGFua3MgYQ0KbG90DQoNCj4gSGkgUmFmYWVsIHNpciwNCj4gDQo+IENv
dWxkIHlvdSBoZWxwIHJldmlldyB0aGlzIHBhdGNoLCB0aGFua3MgYSBsb3QuDQo+IA0KPiBCZXN0
IFJlZ2FyZHMNCj4gQm8gWWUNCj4gDQo+IE9uIFdlZCwgMjAyMy0xMS0wMSBhdCAyMjo1OCArMDgw
MCwgQm8gWWUgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIzLTEwLTI1IGF0IDIwOjIxICswMjAwLCBS
YWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4gPiA+ICAJIA0KPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVu
dGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiA+ID4gIE9uIE1vbiwgT2N0IDIzLCAyMDIzIGF0IDM6MjDigK9BTSBCbyBZZSAo5Y+25rOiKSA8
Qm8uWWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMs
IGl0IGlzIG9ic2VydmVkIGlzc3VlLg0KPiA+ID4gDQo+ID4gPiBJdCBkb2VzIGhhcHBlbiwgc28g
aXQncyBub3QganVzdCAicG90ZW50aWFsIiBhbmQgdGhlIHN1YmplY3Qgb2YNCj4gPiA+IHRoZQ0K
PiA+ID4gcGF0Y2ggaXMgc2xpZ2h0bHkgbWlzbGVhZGluZy4gIFBsZWFzZSBhZGp1c3QgaXQuDQo+
ID4gDQo+ID4gRG9uZQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiA+IEZpcnN0bHksIGl0IG5lZWRzIHRv
IGJlIGNsYXJpZmllZCB0aGF0IHRoaXMgaXNzdWUgb2NjdXJzIGluIGENCj4gPiA+ID4gcmVhbC0N
Cj4gPiA+ID4gd29ybGQgZW52aXJvbm1lbnQuIEJ5IGFuYWx5emluZyB0aGUgbG9ncywgd2UgaW5m
ZXJyZWQgdGhhdCB0aGUNCj4gPiA+IA0KPiA+ID4gaXNzdWUNCj4gPiA+ID4gb2NjdXJyZWQganVz
dCBhcyB0aGUgc3lzdGVtIHdhcyBlbnRlcmluZyBzdXNwZW5kIG1vZGUsIGFuZCB0aGUNCj4gPiA+
ID4gdXNlcg0KPiA+ID4gDQo+ID4gPiB3YXMNCj4gPiA+ID4gc3dpdGNoaW5nIHRoZSB0aGVybWFs
IHBvbGljeSAodGhpcyBhY3Rpb24gY2F1c2VzIGFsbCB0aGVybWFsDQo+ID4gPiA+IHpvbmVzDQo+
ID4gPiANCj4gPiA+IHRvDQo+ID4gPiA+IHVucmVnaXN0ZXIvcmVnaXN0ZXIpLiBJbiBhZGRpdGlv
biwgd2UgY29uZHVjdGVkIGRlZ3JhZGF0aW9uDQo+ID4gPiA+IHRlc3RzDQo+ID4gPiANCj4gPiA+
IGFuZA0KPiA+ID4gPiBhbHNvIHJlcHJvZHVjZWQgdGhpcyBpc3N1ZS4gVGhlIHNwZWNpZmljIG1l
dGhvZCBpcyB0byBmaXJzdA0KPiA+ID4gPiBzd2l0Y2gNCj4gPiA+IA0KPiA+ID4gdGhlDQo+ID4g
PiA+IHRoZXJtYWwgcG9saWN5IHRocm91Z2ggYSBjb21tYW5kLCBhbmQgdGhlbiBpbW1lZGlhdGVs
eSBwdXQgdGhlDQo+ID4gPiANCj4gPiA+IHN5c3RlbQ0KPiA+ID4gPiBpbnRvIHN1c3BlbmQgc3Rh
dGUgdGhyb3VnaCBhbm90aGVyIGNvbW1hbmQuIFRoaXMgbWV0aG9kIGNhbg0KPiA+ID4gPiBhbHNv
DQo+ID4gPiA+IHJlcHJvZHVjZSB0aGUgaXNzdWUuDQo+ID4gPiANCj4gPiA+IE9LLCBzbyBwbGVh
c2UgYWRkIHRoaXMgaW5mb3JtYXRpb24gdG8gdGhlIHBhdGNoIGNoYW5nZWxvZy4NCj4gPiA+IA0K
PiA+ID4gPiBPbiBUaHUsIDIwMjMtMTAtMTIgYXQgMDc6MzUgKzAwMDAsIEJvIFllICjlj7bms6Ip
IHdyb3RlOg0KPiA+ID4gPiA+IE9uIFNhdCwgMjAyMy0wOS0xNiBhdCAxOTozMyArMDgwMCwgQm8g
WWUgd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ29ycmVjdCBtYWlsIHRpdGxlIGZvcm1h
dDogcmVtb3ZlICJTdWJqZWN0OiIgZnJvbSBtYWlsIHRpdGxlLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gRnJvbTogInl1Z2FuZy53YW5nIiA8eXVnYW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBCb2R5Og0KPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCBmaXhl
cyBhIHJhY2UgY29uZGl0aW9uIGR1cmluZyBzeXN0ZW0gcmVzdW1lLiBJdA0KPiA+ID4gDQo+ID4g
PiBvY2N1cnMNCj4gPiA+ID4gPiA+IGlmDQo+ID4gPiA+ID4gPiB0aGUgc3lzdGVtIGlzIGV4aXRp
bmcgYSBzdXNwZW5kIHN0YXRlIGFuZCBhIHVzZXIgaXMgdHJ5aW5nDQo+ID4gPiA+ID4gPiB0bw0K
PiA+ID4gPiA+ID4gcmVnaXN0ZXIvdW5yZWdpc3RlciBhIHRoZXJtYWwgem9uZSBjb25jdXJyZW50
bHkuIFRoZSByb290DQo+ID4gPiA+ID4gPiBjYXVzZQ0KPiA+ID4gDQo+ID4gPiBpcw0KPiA+ID4g
PiA+ID4gdGhhdCBib3RoIGFjdGlvbnMgYWNjZXNzIHRoZSBgdGhlcm1hbF90el9saXN0YC4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSW4gZGV0YWlsOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiAxLiBBdCBQTV9QT1NUX1NVU1BFTkQgZHVyaW5nIHRoZSByZXN1bWUsIHRoZSBzeXN0ZW0g
cmVhZHMNCj4gPiA+ID4gPiA+IGFsbA0KPiA+ID4gPiA+ID4gdGhlcm1hbA0KPiA+ID4gPiA+ID4g
ICAgem9uZXMgaW4gYHRoZXJtYWxfdHpfbGlzdGAsIHRoZW4gcmVzZXRzIGFuZCB1cGRhdGVzDQo+
ID4gPiA+ID4gPiB0aGVpcg0KPiA+ID4gPiA+ID4gICAgdGVtcGVyYXR1cmVzLg0KPiA+ID4gPiA+
ID4gMi4gV2hlbiByZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nIGEgdGhlcm1hbCB6b25lLCB0aGUN
Cj4gPiA+ID4gPiA+ICAgIGB0aGVybWFsX3R6X2xpc3RgIGdldHMgbWFuaXB1bGF0ZWQuDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZXNlIHR3byBhY3Rpb25zIG1pZ2h0IG9jY3VyIGNvbmN1
cnJlbnRseSwgY2F1c2luZyBhIHJhY2UNCj4gPiA+ID4gPiA+IGNvbmRpdGlvbi4NCj4gPiA+ID4g
PiA+IFRvIHNvbHZlIHRoaXMgaXNzdWUsIHdlIGludHJvZHVjZSBhIG11dGV4IGxvY2sgdG8gcHJv
dGVjdA0KPiA+ID4gPiA+ID4gYHRoZXJtYWxfdHpfbGlzdGAgZnJvbSBiZWluZyBtb2RpZmllZCB3
aGlsZSBpdCdzIGJlaW5nIHJlYWQNCj4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gdXBkYXRl
ZCBkdXJpbmcgdGhlIHJlc3VtZSBmcm9tIHN1c3BlbmQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEtlcm5lbCBvb3BzIGV4Y2VycHQgcmVsYXRlZCB0byB0aGlzIGZpeDoNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gWyA1MjAxLjg2OTg0NV0gW1QzMTY4MjJdIHBjOiBbMHhmZmZmZmZlYjdk
NDg3NmYwXQ0KPiA+ID4gPiA+ID4gbXV0ZXhfbG9jaysweDM0LzB4MTcwDQo+ID4gPiA+ID4gPiBb
IDUyMDEuODY5ODU2XSBbVDMxNjgyMl0gbHI6IFsweGZmZmZmZmViN2NhOThhODRdDQo+ID4gPiA+
ID4gPiB0aGVybWFsX3BtX25vdGlmeSsweGQ0LzB4MjZjDQo+ID4gPiA+ID4gPiBbLi4uIGN1dCBm
b3IgYnJldml0eSAuLi5dDQo+ID4gPiA+ID4gPiBbIDUyMDEuODcxMDYxXSBbVDMxNjgyMl0gIHN1
c3BlbmRfcHJlcGFyZSsweDE1MC8weDQ3MA0KPiA+ID4gPiA+ID4gWyA1MjAxLjg3MTA2N10gW1Qz
MTY4MjJdICBlbnRlcl9zdGF0ZSsweDg0LzB4NmY0DQo+ID4gPiA+ID4gPiBbIDUyMDEuODcxMDc2
XSBbVDMxNjgyMl0gIHN0YXRlX3N0b3JlKzB4MTVjLzB4MWU4DQo+ID4gPiANCj4gPiA+IFdlbGws
IHRoZSBjb25uZWN0aW9uIGJldHdlZW4gdGhlIGFib3ZlIGxvZyBzbmlwcGV0IGFuZCB0aGUgaXNz
dWUNCj4gPiA+IGFkZHJlc3NlZCBieSB0aGUgcGF0Y2ggaXMgcmF0aGVyIGhhcmQgdG8gZXN0YWJs
aXNoLiAgUGxlYXNlDQo+ID4gPiBpbmNsdWRlDQo+ID4gPiBtb3JlIG9mIHRoZSBvb3BzIGluZm9y
bWF0aW9uLg0KPiA+IA0KPiA+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHJldmlld2luZyB0aGUg
YWRkaXRpb25hbCBleHBsYW5hdGlvbnMuDQo+ID4gDQo+ID4gMS5FbmFibGUgdGhlcm1hbCBwb2xp
Y3kgb3BlcmF0aW9uIHdpbGwgdW5yZWdpc3Rlci9yZWdpc3RlciBhbGwNCj4gPiB0aGVybWFsDQo+
ID4gem9uZXMNCj4gPiAxMC0yMSAwNjoxMzo1OS4yODAgICA4NTQgICA5MjIgSSBsaWJNdGNMb2Fk
ZXI6IGVuYWJsZSB0aGVybWFsDQo+ID4gcG9saWN5DQo+ID4gdGhlcm1hbF9wb2xpY3lfMDkuDQo+
ID4gDQo+ID4gMi5TeXN0ZW0gc3VzcGVuZCBlbnRyeSB0aW1lIGlzIDIwMjMtMTAtMjAgMjI6MTM6
NTkuMjQyDQo+ID4gWyA0MTA2LjM2NDE3NV1bVDYwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFtZTpz
cG0mXVtTUE1dIFBNOiBzdXNwZW5kDQo+ID4gZW50cnkgMjAyMy0xMC0yMCAyMjoxMzo1OS4yNDI4
OTgyNDMgVVRDDQo+ID4gWyA0MTA2LjM2NjE4NV1bVDYwOTM4N10gYmluZGVyOjUzNF8yOiBQTTog
W25hbWU6d2FrZXVwJl1QTTogUGVuZGluZw0KPiA+IFdha2V1cCBTb3VyY2VzOiBORVRMSU5LDQo+
ID4gDQo+ID4gMy4gSXQgY2FuIGJlIHByb3ZlbiB0aGF0IHRoZSBhYnNlbmNlIG9mIGEgc3dpdGNo
IHN0cmF0ZWd5IHdpbGwNCj4gPiBwZXJmb3JtDQo+ID4gdW5yZWdpc3Rlci9yZWdpc3RlciBvcGVy
YXRpb25zIG9uIHRoZXJtYWwgem9uZXMgKGFuZHJvaWQgdGltZSBpcw0KPiA+IDIwMjMtDQo+ID4g
MTAtMjAgMjI6MTM6NTkuMjgyKe+8jA0KPiA+IEJlY2F1c2UgdGhlIGxvZ3MgZm9yIG90aGVyIHRo
ZXJtYWwgem9uZXMgc3dpdGNoaW5nIGFyZSBub3QgZW5hYmxlZA0KPiA+IGJ5DQo+ID4gZGVmYXVs
dCwgd2UgY2Fubm90IHNlZSB0aGUgbG9ncyByZWxhdGVkIHRvIG90aGVyIHRoZXJtYWwgem9uZXMu
DQo+ID4gWyA0MTA2LjQwNDE2N11bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+ID4gW25hbWU6
dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfdW5iaW5kIHVuYmluZGluZyBP
Sw0KPiA+IFsgNDEwNi40MDQyMTVdW1Q2MDA5MjJdIG10a1Bvd2VyTXNnSGRsOg0KPiA+IFtuYW1l
OnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFovQ1BVXXRzY3B1X3VuYmluZCB1bmJpbmRpbmcg
T0sNCj4gPiBbIDQxMDYuNDA0MjI1XVtUNjAwOTIyXSBtdGtQb3dlck1zZ0hkbDoNCj4gPiBbbmFt
ZTp0aGVybWFsX21vbml0b3ImXVtUaGVybWFsL1RaL0NQVV10c2NwdV91bmJpbmQgdW5iaW5kaW5n
IE9LDQo+ID4gWyA0MTA2LjQwNDUwNF1bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+ID4gW25h
bWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfYmluZCBiaW5kaW5nIE9L
LCAwDQo+ID4gWyA0MTA2LjQwNDU0NV1bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+ID4gW25h
bWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfYmluZCBiaW5kaW5nIE9L
LCAyDQo+ID4gWyA0MTA2LjQwNDU2Nl1bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQo+ID4gW25h
bWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfYmluZCBiaW5kaW5nIE9L
LCAxDQo+ID4gDQo+ID4gNC4gdGhlcm1hbF9wbV9ub3RpZnkgdHJpZ2dlciBLRShhbmRyb2lkIHRp
bWU6ICAyMDIzLTEwLTIwIDIyOjEzOjU5Lg0KPiA+IDMxNTg5NCkNCj4gPiBbIDQxMDYuNDM3MTcx
XVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVtcCZdS2VybmVsIE9mZnNldDoNCj4g
PiAweDI4OWNjODAwMDAgZnJvbSAweGZmZmZmZmMwMDgwMDAwMDANCj4gPiBbIDQxMDYuNDM3MTgy
XVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVtcCZdUEhZU19PRkZTRVQ6DQo+ID4g
MHg0MDAwMDAwMA0KPiA+IFsgNDEwNi40MzcxOTFdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25h
bWU6bXJkdW1wJl1wc3RhdGU6DQo+ID4gODA0MDAwMDUNCj4gPiAoTnpjdiBkYWlmICtQQU4gLVVB
TykNCj4gPiBbIDQxMDYuNDM3MjA0XVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVt
cCZdcGMgOg0KPiA+IFsweGZmZmZmZmU4YTY2ODgyMDBdIG11dGV4X2xvY2srMHgzNC8weDE4NA0K
PiA+IFsgNDEwNi40MzcyMTRdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl1s
ciA6DQo+ID4gWzB4ZmZmZmZmZThhNWNlNjZiY10gdGhlcm1hbF9wbV9ub3RpZnkrMHhkNC8weDI2
Yw0KPiA+IFsgNDEwNi40MzcyMjBdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1w
Jl1zcCA6DQo+ID4gZmZmZmZmYzAxYmFiM2FlMA0KPiA+IFsgNDEwNi40MzcyMjZdW1QyMDkzODdd
IGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl14Mjk6DQo+ID4gZmZmZmZmYzAxYmFiM2FmMCB4
Mjg6IDAwMDAwMDAwMDAwMDAwMDENCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiB5dWdhbmcud2FuZyA8eXVnYW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQm8gWWUgPGJvLnllQG1lZGlhdGVrLmNvbT4NCj4gPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8
IDIgKysNCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1h
bF9jb3JlLmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+
ID4gPiA+ID4gPiBpbmRleCA4NzE3YTMzNDM1MTIuLmE3YTE4ZWQ1N2I2ZCAxMDA2NDQNCj4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+ID4gPiA+ID4g
KysrIGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+ID4gPiA+ID4gPiBAQCAtMTUy
OSwxMiArMTUyOSwxNCBAQCBzdGF0aWMgaW50IHRoZXJtYWxfcG1fbm90aWZ5KHN0cnVjdA0KPiA+
ID4gPiA+ID4gbm90aWZpZXJfYmxvY2sgKm5iLA0KPiA+ID4gPiA+ID4gICAgIGNhc2UgUE1fUE9T
VF9ISUJFUk5BVElPTjoNCj4gPiA+ID4gPiA+ICAgICBjYXNlIFBNX1BPU1RfUkVTVE9SRToNCj4g
PiA+ID4gPiA+ICAgICBjYXNlIFBNX1BPU1RfU1VTUEVORDoNCj4gPiA+ID4gPiA+ICsgICAgICAg
ICAgIG11dGV4X2xvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsNCj4gPiA+ID4gPiA+ICAgICAgICAg
ICAgIGF0b21pY19zZXQoJmluX3N1c3BlbmQsIDApOw0KPiA+ID4gDQo+ID4gPiBJdCBpcyBub3Qg
Y2xlYXIgdG8gbWUgd2h5IHRoZSBhYm92ZSBzdGF0ZW1lbnQgbmVlZHMgdG8gYmUgdW5kZXINCj4g
PiA+IHRoZQ0KPiA+ID4gbG9jay4NCj4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgbGlz
dF9mb3JfZWFjaF9lbnRyeSh0eiwgJnRoZXJtYWxfdHpfbGlzdCwgbm9kZSkNCj4gPiA+ID4gPiA+
IHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbF96b25lX2RldmljZV9p
bml0KHR6KTsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgdGhlcm1hbF96b25lX2Rl
dmljZV91cGRhdGUodHosDQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFRIRVJNQUxfRVZFTlRfVU4NCj4gPiA+ID4gU1ANCj4g
PiA+ID4gRUMNCj4gPiA+ID4gPiA+IElGSUVEKTsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgIH0N
Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgIG11dGV4X3VubG9jaygmdGhlcm1hbF9saXN0X2xvY2sp
Ow0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ID4gPiAgICAgZGVmYXVs
dDoNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgIGJyZWFrOw0K
