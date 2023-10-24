Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B67D5982
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjJXRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjJXRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:11:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE0122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:11:55 -0700 (PDT)
X-UUID: 6c4496e8729011eea33bb35ae8d461a2-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WN/c1xXRD0eTC8+7rSEcmx+1UtbqzKckKoVOsAPsHS0=;
        b=i9Rpg2oOjptqWsKN37JittPK4VV57wbFw+szySgEIiy+1N4+HVa3nO/WpEHLJJimV6syDhJ6piG97qw2cQm6DTbvnb1SnqcjlbKobUhkTAytZyUVGer9nYBXuYdTgxQ/dF9OP/MhC7wfvxu99R9ozPpyAuguQ6il/H9bISUIkpA=;
X-CID-CACHE: Type:Local,Time:202310250059+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:fc030197-22a7-4afb-99ce-a6deeed7d362,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:ce6344d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c4496e8729011eea33bb35ae8d461a2-20231025
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1558261442; Wed, 25 Oct 2023 01:11:51 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 01:11:49 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 01:11:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVo1FJSelXHtV7nxotG2igRwQqFbmaCHxXxfV2inpo2sb4xu04Pi8kK9cbKoNPz7N2aXaJ3Ytdrt/ETW8bHMHRmemU0CqhDFbv3xwdoW3whocMFlB+CbsAByQsgnHl1S7RgZbasUf7gIHT9SXandYKdqcQ72YttfY5WnC4XP4m0Ebgb9H6jqKJMmZZLu3gVcD47eleiD1pw4RQ8r5lYJmYPeT42xs0qt7zviR1sCmin0GlyY8kOCavQNIMYhsZMAqmmN+2Qp3xSi2WVMfhwQJ9MzbcDulGIr7fYErmSx7GXJjvPJ199I9OBFgMwU0BMVv00cSuzqUZUJgeiPbIkTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN/c1xXRD0eTC8+7rSEcmx+1UtbqzKckKoVOsAPsHS0=;
 b=f2ny9JdrPm8odqK9nvIOIg4AZHy+sFP9s6q6Jz9+FjsZcvBkY7APRFEcdoOvrVKYggBV2f4nD5iFfIJDv2PsTMSiz5H1rjC2R2m9wKaEYATiq0H3G4QKWTvpW7Rf36YILaea0Xsj5yShrzEA7cramNbd/JgdHuRnVBeiy7oZzKgvEb33Vh4l7o34RYtWWoMb3Rr0StYN5rbs5qK3sbc0tLoLpzDla8G/YhDJmo//IOAWNtthMONdo5MnMaT472mw66qUq/seDM8RxU8RbFkD/y4+l0pkwSis9Rz+Pd2EMSo2/TcG4+Wgz/Z21OBTc9SS8zlAvqBSPUxsPmzJ8lOhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN/c1xXRD0eTC8+7rSEcmx+1UtbqzKckKoVOsAPsHS0=;
 b=vadC6Wj3lCp3lO5aD+pTPHcOgL33gMywcxyXmjKppMasxFhaOQAW2ZiNf4OFozahjYBkNlc6E44+7t3SavYC4LTF2ulwgMBZLP2o4hMreM8AtpLrMBSQcWiC4yRfVc7pTBKwVOn6Zi1r+pyZP76ayqoYAQ+8ZipHT5/hwKxOjjA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:11:47 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 17:11:47 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
Thread-Topic: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
Thread-Index: AQHaBWrCX17ODV7GF0K6Rv6tIltX2bBXId6AgAINogA=
Date:   Tue, 24 Oct 2023 17:11:47 +0000
Message-ID: <cf0ab8ec882c26a179656bd694dc7322c48738f9.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-4-jason-jh.lin@mediatek.com>
         <687aeef8-a413-4f02-9c6b-3a3adc23cc36@collabora.com>
In-Reply-To: <687aeef8-a413-4f02-9c6b-3a3adc23cc36@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5542:EE_
x-ms-office365-filtering-correlation-id: 409a1cb1-3cd3-4422-d0bc-08dbd4b44e2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Elt2IYvq4Ir+E7hxTkUevPmTGeIJagjSZQszEGSXRh+SQAE0+hvg0qFmAsfqh/LUaEQ06dsA1TSk1Vxbkuqz25O+T68VnP24V0ZGG+FdG2sMYJ43VLLTltTx/FurGQDydYdvNByHoUgnLuwaqGljUJ3QlDXbB1R+A64mvv7IdW3MXHqSjD4V0sNw3y0SanFh5+mDXx3t/TLL/ZQe2lAoZ9iP9klHOLlHaqsfKhO5mgG+WCeQt5yfIdB5ue8kqe/VosFq0pWRFRhnSpdLjnlxRIqG/mJDW2AXMtommJl6N0nLX431t6Fmqx8YpOXbHqJTcSIEiWBXPgswHB1K6KCfs8A5fkASuQEK85UmEkMP3CUy0e0Qnexzo62IcdNdmIHrk6+wu0phARQI63Ezir4k/po9J7tp0g+kPLZQK5JMMMgfXi5ojWgpF9dK20c7SalExSvbzpIZTmZ3S9wvg3uqPThzW1qGk5DnC6c1cI8aWO7xnkLgxJFBPtBI7t7MqhCNJ59yl0X6C2QAaDwdvItb2pJeRjfgXSR3DNHdFmeMhjazDDepnt/XhbJNoO1Il6ayotT3i5mdrPurJKxvLsaVdBqU7vvDo43btwmpQsbiFt4dbXoZtRvxkIEBZdB4KJJRM6NYTO0LjGIaDQwuRdog204feLgWzGGdPz70UQgoplg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(85182001)(36756003)(41300700001)(5660300002)(8676002)(8936002)(4326008)(2906002)(7416002)(86362001)(4001150100001)(2616005)(6512007)(26005)(122000001)(478600001)(6486002)(6506007)(71200400001)(38070700009)(38100700002)(83380400001)(316002)(64756008)(54906003)(66946007)(66556008)(76116006)(91956017)(110136005)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azVrc3AwNW94Y2pibXhBVlBHTWMwbFJUdFV1SzZERlBQVG9CRUNNWm9acEtu?=
 =?utf-8?B?N292TWJKWERmQjFjUlVvT28vRGFoUzBoR05rV1FPUWlvQWl6TEVVd2lVWnpk?=
 =?utf-8?B?a1pqR0M2eDJzRUkyRStlOGFManpGb2VQa1VnZEhzZDJ4VGxTOVNJOHFYbkdG?=
 =?utf-8?B?RUw4MDJMQ3BSSE9Cd2lqMGtwQllJOXNudksrRTJ0TGdpQXZGRG5mNVJWVTdr?=
 =?utf-8?B?NzlvQ1V2U3Qzclh3S1FiOERGZzZySFBZNnV0SlRhMzBKTDEzSmQxV1JpczZq?=
 =?utf-8?B?cGZkSTlkdmlFUnd5OEhVcmpKYVNSK29kSC9LWVJJUXZrRUVaVFljd3pRck5K?=
 =?utf-8?B?dFhQMUxHOG5BMVYyaXhKT3V0ZU5EUEtqZjRGZXBxbndveDRTRkxOOWF3cXBv?=
 =?utf-8?B?Ny9XSUt4S2wvaXZTV3N5aElsWkYwNFBjTXNvRXQxUVdkZjh0dmxLSUE3NDFy?=
 =?utf-8?B?ZTQrWjM5WmRLYThSR0tRejR5YlIvelhQYldDU1g4ZDNFVWhwcmt4a2x5d2dp?=
 =?utf-8?B?ZkFGdTlKRlJXZHdkT2VYWDlRTGRFTTJmOXVyUEt6LzRxUkFWSGdZd21xZE9a?=
 =?utf-8?B?SjNaYStvcmgyNHdnTlkvMkxFMGhJRU9xVVJ1ZWM0U1B6b0Z2bExHYmY0NXdu?=
 =?utf-8?B?ZGtaZGxuakxIVFZPRmlZYllIckRGMjVsT0gxVFhMVTh5Q3hCNFZ2UUs1Y2Z5?=
 =?utf-8?B?MUpUWVpDSkNaMDh4S2tycjl5cjFIY0hiOHZxV3MrT0dhNkhWeGNWWVpUb2NZ?=
 =?utf-8?B?S0pacU03RFlYeW1RaW5PWjFOYXBCVnpYOTE0Q3lUSDJ0UHdNWEpsK05qZFdG?=
 =?utf-8?B?cVlCakZoQ2RTTERWOFc2bm5maWpCU3paMFhjZlA0SkwvaU9lSXpQWEx2ai9U?=
 =?utf-8?B?QkVBWGM1UU1BcDdmVytCUkJJZ0J3cElDWllTSVpkYjB4eFlYb0RVeFErVHl4?=
 =?utf-8?B?Y1pJRUxzUWZTWVVtUjJDamozNnRHTVdyRzh1dGV1b1pmMEJRTSt5SDhqSmlw?=
 =?utf-8?B?aWxKc3l5cXBIVXFBTTZCb3F4TDl0a29XSnpLZVo3T2wzQWJFVGtIcUFTaGQz?=
 =?utf-8?B?ejhnZTFMOW5mUjRmUFlDNFVCcERmQnNLVUxtQSs1di9QZVlTemhOZzFhaDJu?=
 =?utf-8?B?VllKNC9GMU5HTkdoMzZSdks4djZPTm5yNkMzVHpDdkVFQ2s4ZmVaTXNENjZy?=
 =?utf-8?B?NDhsMzQyb3BUM0hoS2ZIMUQ0UW1teCtHN3B0TXdGOCsvZmRLY3k2UXZVY0lU?=
 =?utf-8?B?TDE3WWpNTjV2RHFyY0NkU3dMYk5Qbk1xdkZkektOdWpiVDB1cHJDTGtxUDdu?=
 =?utf-8?B?OHozOU1vQVM5UUV5ek5KQk5jTE1FM3lZZ3l1S0ZKdHhKL1djVEZ6UGJRd0tJ?=
 =?utf-8?B?YWlrTGUydkVhMTdHakxpU1RVWkVwajNkK2FvSjBXUHp0UUdXMUdWbGZXWkNL?=
 =?utf-8?B?WVlnbUZaYVBzY2ZaT04xcVF5RmVmMFhCVlJTcDVSenB1UTVvYjdUZzM0MmFD?=
 =?utf-8?B?TndnL1UrMkdiL2I1RCsvMFg3dFI4T2ZiK3l3ZElNMXM0cUJBYUZWOTUvaEVC?=
 =?utf-8?B?NkV3YTNMNi90VFV0c1NMUi9HQnNxTGVadjAwUUZyc2tJM0RBUmNhWnlneC8z?=
 =?utf-8?B?Ung5bzlOQklZN2huU3VZdlJ5eENVUzk4MVNrODdjSDFUSFp1ekQ4WjVoWEMy?=
 =?utf-8?B?a01KcGgzNnpkNkpQRENQcWcwekV0YTRTWWFWRGpCL1loZ0crUTZPTHhmNEht?=
 =?utf-8?B?UEdnN2I5ZVJ5MkxFazAwUTFPeXpQbnozcVRsWEJiTWFsaEJhWTR0NHhtTWFI?=
 =?utf-8?B?WGljWm1lbWZKQ0c3QWhQMWdib2lablc0bWJQakl1UlZsd0xzSzNmdlR3MlBC?=
 =?utf-8?B?V0FraSttMEF1cFVWcXBMaTRWL0t4ck9Pa05NaXBVangxdElBVjhvTTlIM1o5?=
 =?utf-8?B?L0o4SDJ0bjMwNHlFZXdYN0lNQlBCeXIwMG45M3RUdjB5a3RjTmlyNHQ0Z3Vo?=
 =?utf-8?B?U0NXb1REQ3lRUWNyU1dIWFQvUE4xZWU2SUxrZGFHcG5YWWpaM1NtSFk3Z2Fk?=
 =?utf-8?B?aXpRU0pzNi9PMjg1czRaUWJaSys2YUUxTFRtMFZTRkNsMitxSGpyOENIY0Za?=
 =?utf-8?B?SkxTZXZDZE1zeDdzaEtMYlBEV2tscFpna29sQVhMYlJleCt5VjlyeFlyMDlP?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D38F9D0DDA701478E2FDC16BDDEF706@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409a1cb1-3cd3-4422-d0bc-08dbd4b44e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 17:11:47.3673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /42dPjDFNEpbr6g4vs+ftQzzqSBHDRhnfcO6bga/gmgUaJ6mIlQ3zKDQYoRsGB0pZ0/tsQ1ZiYLjMFuDHULpesOgH1uVxNPoj0XeGyL6zPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5542
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.311800-8.000000
X-TMASE-MatchedRID: 0dFPYP4mu5SnykMun0J1wmjZ8q/Oc1nAI4bJHZSdxcuyrCkM9r1bWskU
        hKWc+gwPp2+PpVTz2PH89WDKQGB2LkaWGOeKmQYQG5mg0pzqmX70hIfAKsh1L1pbYq2f4jz+sDb
        X4e5uvIiObIAKMbDdIPGszRbikk4/eg7nwmtcFgfLtNJZxvPj1kvE+2pLwGbn31GU/N5W5BD0Zt
        JJqrR/g1z9R/l1CwM8WKNxvq78azWZ4IboRQ7U54dlc1JaOB1Tiyn6+JdHhc+17wx8kgvnlKBw4
        u8H7nqarwvtynGI5coStOdZtNeQurQ9EkyAW8JWTSPNp9e/u1Nzd7C7BtJobrWZRTTpSHog+HmB
        PyReSgzPiwaw8bN2WPSzxtQuO5o5MkaIaLbJ6ufKl4yJoI+fG0jmbQR0Nyy84aROJEypr9wG5pY
        kwMRqtrWcPZUzYO06X4KXKAy1fXM3KXWd30Ii3dIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2rl
        3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.311800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CD902F0ACE1480E56396726199E12B51FF6D8C952E7D33B7ACA381A7C96916312000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAt
MjMgYXQgMTE6NTAgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAyMy8xMC8yMyAwNjozNywgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gQWRkIGNtZHFf
cGt0X2xvZ2ljX2NvbW1hbmQgdG8gc3VwcG9ydCBtYXRjaCBvcGVyYXRpb24uDQo+ID4gDQo+ID4g
Y21kcV9wa3RfbG9naWNfY29tbWFuZCBjYW4gYXBwZW5kIGxvZ2ljIGNvbW1hbmQgdG8gdGhlIENN
RFEgcGFja2V0LA0KPiA+IGFzayBHQ0UgdG8gZXhlY3V0ZSBhIGFyaXRoZW1hdGljIGNhbGN1bGF0
ZSBpbnN0cnVjdGlvbiwNCj4gPiBzdWNoIGFzIGFkZCwgc3VidHJhY3QsIG11bHRpcGx5LCBBTkQs
IE9SIGFuZCBOT1QsIGV0Yy4NCj4gPiANCj4gPiBOb3RlIHRoYXQgYWxsIGluc3RydWN0aW9ucyBq
dXN0IGFjY2VwdCB1bnNpZ25lZCBjYWxjdWxhdGUuDQo+ID4gSWYgdGhlcmUgYXJlIGFueSBvdmVy
Zmxvd3MsIEdDRSB3aWxsIHNlbnQgdGhlIGludmFsaWQgSVJRIHRvIG5vdGlmeQ0KPiA+IENNRFEg
ZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgu
bGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFBsZWFzZSBhbHdheXMgcnVuIGBnaXQgbG9nYCBvbiB0
aGUgZmlsZSB0aGF0IHlvdSdyZSBjaGFuZ2luZyB0bw0KPiBwcm9wZXJseSBmb3JtYXQgdGhlDQo+
IGNvbW1pdCB0aXRsZS4NCj4gDQo+IEluIHRoaXMgY2FzZSwgdGhpcyBzaG91bGQgYmU6DQo+IA0K
PiBzb2M6IG1lZGlhdGVrOiBjbWRxOiAuLi4uLg0KDQpJIHRoaW5rIGl0IGhhcHBlbmRlZCBiZWNh
dXNlIEkgZGVsZXRlZCB0aGUgYFxuYCBpbiB0aGUgZmlyc3QgbGluZSBvZg0KdGhlIHRpdGxlIHdo
ZW4gSSByZXZpZXcgdGhlc2UgcGF0Y2hlcyBpbiBgZ2l0IHNlbmQtZW1haWxgIGNtZC4NCg0KSSB3
b24ndCBkbyB0aGF0IGluIHRoZSBuZXh0IHZlcnNpb24uIFRoYW5rcy4NCg0KPiANCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMzYNCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9t
dGstY21kcS5oICB8IDQxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCBiMGNkMDcxYzQ3MTkuLjUxOTRk
NjZkZmMwYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+ID4gQEAgLTEzLDkgKzEzLDE4IEBADQo+ID4gICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxF
X01BU0sJQklUKDApDQo+ID4gICAjZGVmaW5lIENNRFFfUE9MTF9FTkFCTEVfTUFTSwlCSVQoMCkN
Cj4gPiAgICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCj4gPiArI2RlZmluZSBDTURR
X0lNTUVESUFURV9WQUxVRQkwDQo+ID4gICAjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTENCj4gPiAg
ICNkZWZpbmUgQ01EUV9KVU1QX1JFTEFUSVZFCTENCj4gPiAgIA0KPiA+ICsjZGVmaW5lIENNRFFf
T1BFUkFORF9HRVRfSURYX1ZBTFVFKG9wZXJhbmQpIFwNCj4gPiArCSh7IFwNCj4gPiArCQlzdHJ1
Y3QgY21kcV9vcGVyYW5kICpvcCA9IG9wZXJhbmQ7IFwNCj4gPiArCQlvcC0+cmVnID8gb3AtPmlk
eCA6IG9wLT52YWx1ZTsgXA0KPiA+ICsJfSkNCj4gPiArI2RlZmluZSBDTURRX09QRVJBTkRfVFlQ
RShvcGVyYW5kKSBcDQo+ID4gKwkoKG9wZXJhbmQpLT5yZWcgPyBDTURRX1JFR19UWVBFIDogQ01E
UV9JTU1FRElBVEVfVkFMVUUpDQo+ID4gKw0KPiA+ICAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
ew0KPiA+ICAgCXVuaW9uIHsNCj4gPiAgIAkJdTMyIHZhbHVlOw0KPiA+IEBAIC0zODAsNiArMzg5
LDMzIEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+ID4g
dTggc3Vic3lzLA0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9wb2xsX21h
c2spOw0KPiA+ICAgDQo+ID4gK2ludCBjbWRxX3BrdF9sb2dpY19jb21tYW5kKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCBlbnVtDQo+ID4gQ01EUV9MT0dJQ19FTlVNIHNfb3AsDQo+ID4gKwkJCSAgIHUx
NiByZXN1bHRfcmVnX2lkeCwNCj4gPiArCQkJICAgc3RydWN0IGNtZHFfb3BlcmFuZCAqbGVmdF9v
cGVyYW5kLA0KPiA+ICsJCQkgICBzdHJ1Y3QgY21kcV9vcGVyYW5kICpyaWdodF9vcGVyYW5kKQ0K
PiA+ICt7DQo+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4g
PiArCXUzMiBsZWZ0X2lkeF92YWx1ZTsNCj4gPiArCXUzMiByaWdodF9pZHhfdmFsdWU7DQo+ID4g
Kw0KPiA+ICsJaWYgKCFsZWZ0X29wZXJhbmQgfHwgIXJpZ2h0X29wZXJhbmQpDQo+IA0KPiBJIHdv
dWxkIGFsc28gY2hlY2sgdGhhdCB0aGUgcmVxdWVzdGVkIGxvZ2ljIG9wZXJhdGlvbiBpcyBhY3R1
YWxseQ0KPiBpbXBsZW1lbnRlZDoNCj4gDQo+IAlpZiAoIWxlZnRfb3BlcmFuZCB8fCAhcmlnaHRf
b3BlcmFuZCB8fCBzX29wID49IENNRFFfTE9HSUNfTUFYKQ0KPiAJCXJldHVybiAtRUlOVkFMOw0K
PiANCk9LLCBJJ2xsIGFkZCB0aGlzIGNoZWNrLg0KDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gKw0KPiA+ICsJbGVmdF9pZHhfdmFsdWUgPSBDTURRX09QRVJBTkRfR0VUX0lEWF9WQUxVRShs
ZWZ0X29wZXJhbmQpOw0KPiA+ICsJcmlnaHRfaWR4X3ZhbHVlID0gQ01EUV9PUEVSQU5EX0dFVF9J
RFhfVkFMVUUocmlnaHRfb3BlcmFuZCk7DQo+ID4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0xPR0lD
Ow0KPiA+ICsJaW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7DQo+ID4gKwlpbnN0LnNyY190ID0g
Q01EUV9PUEVSQU5EX1RZUEUobGVmdF9vcGVyYW5kKTsNCj4gPiArCWluc3QuYXJnX2NfdCA9IENN
RFFfT1BFUkFORF9UWVBFKHJpZ2h0X29wZXJhbmQpOw0KPiA+ICsJaW5zdC5zb3AgPSBzX29wOw0K
PiA+ICsJaW5zdC5hcmdfYyA9IHJpZ2h0X2lkeF92YWx1ZTsNCj4gPiArCWluc3Quc3JjX3JlZyA9
IGxlZnRfaWR4X3ZhbHVlOw0KPiA+ICsJaW5zdC5yZWdfZHN0ID0gcmVzdWx0X3JlZ19pZHg7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+
ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9sb2dpY19jb21tYW5kKTsNCj4gPiAr
DQo+ID4gICBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVn
X2lkeCwgdTMyIHZhbHVlKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9u
IGluc3QgPSB7fTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
PiA+IGluZGV4IGEyNTNjMDAxYzg2MS4uZWE0ZmFkZmI1NDQzIDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gQEAgLTI2LDYgKzI2LDMwIEBADQo+ID4g
ICANCj4gPiAgIHN0cnVjdCBjbWRxX3BrdDsNCj4gPiAgIA0KPiA+ICtlbnVtIENNRFFfTE9HSUNf
RU5VTSB7DQo+IA0KPiBQbGVhc2Ugbm8gY2FwaXRhbCBsZXR0ZXJzIGluIGVudW1lcmF0aW9uIG5h
bWVzLg0KPiBCZXNpZGVzLCBpdCdzIGNsZWFyZXIgaWYgeW91IG5hbWVkIHRoaXMNCj4gDQo+IGVu
dW0gY21kcV9sb2dpY19vcGVyYXRpb24gew0KPiANCj4gb3INCj4gDQo+IGVudW0gY21kcV9sb2dp
Y19vcCB7DQoNCk9LLCBJJ2xsIGNoYW5nZSB0byB0aGlzIG9uZS4gVGhhbmtzLg0KDQo+IA0KPiA+
ICsJQ01EUV9MT0dJQ19BU1NJR04gPSAwLA0KPiA+ICsJQ01EUV9MT0dJQ19BREQgPSAxLA0KPiA+
ICsJQ01EUV9MT0dJQ19TVUJUUkFDVCA9IDIsDQo+ID4gKwlDTURRX0xPR0lDX01VTFRJUExZID0g
MywNCj4gPiArCUNNRFFfTE9HSUNfWE9SID0gOCwNCj4gPiArCUNNRFFfTE9HSUNfTk9UID0gOSwN
Cj4gPiArCUNNRFFfTE9HSUNfT1IgPSAxMCwNCj4gPiArCUNNRFFfTE9HSUNfQU5EID0gMTEsDQo+
ID4gKwlDTURRX0xPR0lDX0xFRlRfU0hJRlQgPSAxMiwNCj4gPiArCUNNRFFfTE9HSUNfUklHSFRf
U0hJRlQgPSAxMywNCj4gDQo+IFlvdSBzaG91bGQgYWxzbyBhZGQgYSBgQ01EUV9MT0dJQ19NQVgs
YCBoZXJlIHRvIHVzZSBpdCBpbiB0aGUgY29kZQ0KPiBmb3IgdmFsaWRhdGlvbi4NCg0KT0ssIEkn
bGwgYWRkIHRoaXMuIFRoYW5rcy4NCg0KPiANCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBj
bWRxX29wZXJhbmQgew0KPiA+ICsJLyogcmVnaXN0ZXIgdHlwZSAqLw0KPiA+ICsJYm9vbCByZWc7
DQo+ID4gKwl1bmlvbiB7DQo+ID4gKwkJLyogaW5kZXggKi8NCj4gPiArCQl1MTYgaWR4Ow0KPiA+
ICsJCS8qIHZhbHVlICovDQo+ID4gKwkJdTE2IHZhbHVlOw0KPiA+ICsJfTsNCj4gPiArfTsNCj4g
PiArDQo+ID4gICBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnIHsNCj4gPiAgIAl1OCBzdWJzeXM7DQo+
ID4gICAJdTE2IG9mZnNldDsNCj4gPiBAQCAtMjQ0LDYgKzI2OCwyMyBAQCBpbnQgY21kcV9wa3Rf
cG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgNCj4gPiBzdWJzeXMsDQo+ID4gICBpbnQgY21k
cV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4gICAJ
CSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gPiAgIA0KPiA+ICsv
KioNCj4gPiArICogY21kcV9wa3RfbG9naWNfY29tbWFuZCgpIC0gQXBwZW5kIGxvZ2ljIGNvbW1h
bmQgdG8gdGhlIENNRFENCj4gPiBwYWNrZXQsIGFzayBHQ0UgdG8NCj4gPiArICoJCSAgICAgICAg
ICBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQgc3RvcmUgdGhlIHJlc3VsdA0KPiA+IG9mIGxv
Z2ljIG9wZXJhdGlvbg0KPiA+ICsgKgkJICAgICAgICAgIHdpdGggbGVmdCBhbmQgcmlnaHQgb3Bl
cmFuZCBpbnRvDQo+ID4gcmVzdWx0X3JlZ19pZHguDQo+ID4gKyAqIEBwa3Q6CQl0aGUgQ01EUSBw
YWNrZXQNCj4gPiArICogQHNfb3A6CQl0aGUgbG9naWMgb3BlcmF0b3IgZW51bQ0KPiA+ICsgKiBA
cmVzdWx0X3JlZ19pZHg6CVNQUiBpbmRleCB0aGF0IHN0b3JlIG9wZXJhdGlvbiByZXN1bHQNCj4g
PiBvZiBsZWZ0X29wZXJhbmQgYW5kIHJpZ2h0X29wZXJhbmQNCj4gPiArICogQGxlZnRfb3BlcmFu
ZDoJbGVmdCBvcGVyYW5kDQo+ID4gKyAqIEByaWdodF9vcGVyYW5kOglyaWdodCBvcGVyYW5kDQo+
ID4gKyAqDQo+IA0KPiBJIHRoaW5rIHRoYXQgdGhlcmUncyBhIHdheSB0byBkcmFtYXRpY2FsbHkg
aW5jcmVhc2UgaHVtYW4gcmVhZGFiaWxpdHkNCj4gb2YgY2FsbHMgdG8NCj4gdGhpcyBmdW5jdGlv
bjogYmVpbmcgdGhpcyBhIHJlcXVlc3QgdG8gcGVyZm9ybSBjYWxjdWxhdGlvbnMsIGl0IHdvdWxk
DQo+IGJlIHdheSBlYXNpZXINCj4gdG8gcmVhZCBpdCBsaWtlIGFuIGFjdHVhbCBjYWxjdWxhdGlv
biA6LSkNCj4gDQo+IGNtZHFfcGt0X2xvZ2ljX2NvbW1hbmQocGt0LCByZXN1bHQsIG9wX3gsIENN
RFFfTE9HSUNfQURELCBvcF95KTsNCj4gDQo+IEF0IGxlYXN0IGluIG15IGhlYWQsIHRoaXMgZWFz
aWx5IHJlc2VtYmxlcyAicmVzdWx0ID0gb3BfeCArIG9wX3kiLg0KPiANCj4gSSB0aGVyZWZvcmUg
cHJvcG9zZSB0byBjaGFuZ2UgdGhpcyB0bzoNCj4gDQo+IGludCBjbWRxX3BrdF9sb2dpY19jb21t
YW5kKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVzdWx0X3JlZ19pZHgsDQo+IAkJCSAgIHN0
cnVjdCBjbWRxX29wZXJhbmQgKmxlZnRfb3BlcmFuZCwNCj4gCQkJICAgZW51bSBjbWRxX2xvZ2lj
X29wZXJhdGlvbiBzX29wLA0KPiAJCQkgICBzdHJ1Y3QgY21kcV9vcGVyYW5kICpyaWdodF9vcGVy
YW5kKTsNCj4gDQpPSywgSSB0aGluayBpdCdzIGEgZ29vZCBpZGVhLg0KSSdsbCBjaGFuZ2UgdGhh
dC4gVGhhbmtzIQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiArICogUmV0dXJuOiAw
IGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gKyAqLw0K
PiA+ICtpbnQgY21kcV9wa3RfbG9naWNfY29tbWFuZChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZW51
bQ0KPiA+IENNRFFfTE9HSUNfRU5VTSBzX29wLA0KPiA+ICsJCQkgICB1MTYgcmVzdWx0X3JlZ19p
ZHgsDQo+ID4gKwkJCSAgIHN0cnVjdCBjbWRxX29wZXJhbmQgKmxlZnRfb3BlcmFuZCwNCj4gPiAr
CQkJICAgc3RydWN0IGNtZHFfb3BlcmFuZCAqcmlnaHRfb3BlcmFuZCk7DQo+ID4gKw0KPiA+ICAg
LyoqDQo+ID4gICAgKiBjbWRxX3BrdF9hc3NpZ24oKSAtIEFwcGVuZCBsb2dpYyBhc3NpZ24gY29t
bWFuZCB0byB0aGUgQ01EUQ0KPiA+IHBhY2tldCwgYXNrIEdDRQ0KPiA+ICAgICoJCSAgICAgICB0
byBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQgc2V0IGENCj4gPiBjb25zdGFudCB2YWx1ZSBp
bnRvDQo+IA0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0K
