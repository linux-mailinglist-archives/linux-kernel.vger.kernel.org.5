Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D6376351E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjGZLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjGZLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:37:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C61FF5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:36:57 -0700 (PDT)
X-UUID: b720303e2ba811ee9cb5633481061a41-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=weq2hEEtlvcOoCMvxsJISahUd8vw88wDWpzDOAFeuXs=;
        b=JovrG4QYQCIKcLGmkbU5pKXgIMrYaoc2ZjYguuiKjDIZHxmhJtmbrFHGGwhyZGF6W+/KQ3Zflw95qz6bx14qIoRrJhIJq1SQ5eXsTgrUb45/VHsEkhpc79OyAxzda/IS/AJIG2yzPE7n72QhE6JmRR3gjFZ5YtkZPOmHebwaCMQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:973c8011-5756-4370-849b-ff00718c3ed6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.29,REQID:973c8011-5756-4370-849b-ff00718c3ed6,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:e7562a7,CLOUDID:31308ea0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230725150643LC6Z3HE4,BulkQuantity:30,Recheck:0,SF:19|48|38|29|28|17|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: b720303e2ba811ee9cb5633481061a41-20230726
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1814971768; Wed, 26 Jul 2023 19:36:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 19:36:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 19:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLiwDan0lWHR+RGM6w2JPetpnOYeS/hL15e2VPVXYO0c+ZvlAZojjsup1D8qmAU1vvlXWOksTOL9mbtzkWRn6RaKU1dD6dJpmujhH0IFR+hvLM2jnNvyLSeNUKRNCtMEqEkyDs13VDQN29hjsOY3fWTtXmrlXEQukRGg/Kbkmaxmmquy+Kn10Nfq5Um14plQU9q7fxpP72jx2ZSjT97Twi67WiW/WruIbIPYSfJKVQN34CvBFxb+pTxJinIQG03kuhe6bNqFyEZYtS4grWL6HTaXVt7xKM81WKtwTW+76dsbMoVpqE58g9y/FDZ6hvShgk8ZeCuxu6PyAYbZ2NYd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weq2hEEtlvcOoCMvxsJISahUd8vw88wDWpzDOAFeuXs=;
 b=fbVlNxmNiwAfbJnZJwHNkPCqPGSeICNINKQwIFtFO5FC2cqHrHZZ4R2oePj12cyNLXMd/T4GUCQmQV1T3i40Qo3EnUUwFBHTO+DI2ZseSRxlCjUaxhNGAlVMLani0/6VZnJLRlrT3cw8J+TNji51fRpt8YS8tq7tC8ZmfXl1D6mkggra5IacPhVYAXQxF1zjMsP7ufadSPlxbJ4qYgkhgOGRZyX7DnBsktxR5ew7crPI1IromIZQe2JVlmRLj3liVuZIjjYIEy33PMe71Nbn8x1kcEXBeris97haJkhNd8sVc8hBJxDBaUEtgMpkDA3fErlgIeqO72dPzRcD9L0ZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weq2hEEtlvcOoCMvxsJISahUd8vw88wDWpzDOAFeuXs=;
 b=jXHkptILF30LgbX9k/FY5MEvMbLEr5DNT/G+QYYVj1ZI/nhgIxvH0lgp8Fd9gp+GFk5H70sTV0cZWzvsG/LsYlWLPeX+NLtWBY9YGJMdXD4A4xCbYqa12svDfcGxGVoRSTMyZbVNdIvvxTX1aq3XJ6uBPbpKfl9K4WgCWkXOWoI=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by KL1PR03MB6228.apcprd03.prod.outlook.com (2603:1096:820:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:36:48 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::a88d:fbad:5956:fd1a%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 11:36:48 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Topic: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Thread-Index: AQHZvquHbd20P9+WpES+HRrZk+KuQK/KD8AAgAFCEICAAEnvAIAAUdWA
Date:   Wed, 26 Jul 2023 11:36:48 +0000
Message-ID: <b9e49c0a16bb59ed803fbb6102269b948be95ecc.camel@mediatek.com>
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
         <20230725035304.2864-2-trevor.wu@mediatek.com>
         <5314542c-9a99-fad1-93f6-4f72c8698715@collabora.com>
         <69690b530fb46d6adad1732d570c8cfad9c0f23c.camel@mediatek.com>
         <320ab7cc-32dd-79dd-b2ae-96d3608aeb9c@collabora.com>
In-Reply-To: <320ab7cc-32dd-79dd-b2ae-96d3608aeb9c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|KL1PR03MB6228:EE_
x-ms-office365-filtering-correlation-id: f37132ce-626e-4983-436a-08db8dcc9929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clmURB75eVqoPMTcWLhmL4SD376sBSi7T5Y3Bn7RbObkeKw2z9yydfLGkXNtOsam0Tmd/Af5Ierh3WucBXHaV3FRoDebrHqekydTCv3uF3KRrN5PoEiPz8nG7H3fxvsePdDwLvko9cUoxmd4Q0nwUoNEfgnMlNSQZ1OaNt3JHkqcBlofCdnHkeDgVl3ZmmlvlVu9s3tsIFLLeSEu/3Eu7770gHKhUH4erFOd5iyBHzeMfgBYiOZYqVmL/Mu8l7AgBxPGqPfrgRw4z4L9FkHwbsoRzXyyJa+Q13ekmLieCfHVBbAfSMH+ncThs7LGejhn7+C/4QA5WbQkZbUC81NhZwRDYmGXgCyXXctaU2jxG/Ii6ncZGUkZ2ryUemhEjrQDD3LPy4yjJlQvQkV230Wny3ROvZF23S061m/OB+b8GYVGrax8lgTaJDuO70ywXkZ0+2YkSbAneEPMnyimZ98Tl5cOcliyLuq0SX0hjLi7uaA6pJWouqqQpU52YNpDxfbmr/hwnMAorh9LTnOi7qPwN0sQbe4yssR2+vz8q2e9jcWjBVXlGSYZVBDKv8ZnqPLMoDPBcyy8Xw4wv4ijT+QcLHbvB2a7qp3ZfZkC7qWAhmyMwFvLCkTANIpJGl++q8bGG9a0reuZsdgXCKUrCUzTbqN9rQR6pMhXW+0nQOVa7BuX6pl+ddNuKzoFEAbUAJF2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(110136005)(122000001)(54906003)(478600001)(38100700002)(6486002)(6512007)(41300700001)(5660300002)(66476007)(66946007)(8936002)(8676002)(66556008)(64756008)(66446008)(4326008)(76116006)(91956017)(316002)(71200400001)(2616005)(26005)(186003)(83380400001)(6506007)(86362001)(2906002)(85182001)(36756003)(38070700005)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2IrVXJxUVkvRitSUm5sM1hFbDJYVTQ1MFRGRWdFUGRQVmlsM1ZJZlF0T1BX?=
 =?utf-8?B?VzdBMkhsaHkxd2N4MllyTG04ZHpyU2Z4NWVvYndpT0pUOGVZRStXRHhaVkFa?=
 =?utf-8?B?MklpMldBenhpd3hyMmRmUjRlMW16WTBFUTVLYnpqbzJjbWJHNmNNQ0RML0gv?=
 =?utf-8?B?SjR1U3hqbEdsT3Q1WG1QQ0xTWmJVanZNQnU1MGpmZlVnZ01KNFdjMGpQUGRV?=
 =?utf-8?B?ZzFuM1o3b1VBd3lVQmsySHVOVHlkeFE3a1l5Y1BwdHRWMEdCU0FZMnUvL3Ez?=
 =?utf-8?B?b24zaGpreHRndUpOaTN6aWxGQVczS25wQ1NzR2lwZndoS3o5Vzl2cGVRYm8w?=
 =?utf-8?B?ZTJHM2p1SjZQVWsxWEk4dnZvYkhWY3BldUtSY0ptdWdZUytPcWpNYU9yUFpq?=
 =?utf-8?B?VHRhZVZ3cUZzUkhOQlovTDZXakFRdlNlOUZFNDFTMHRuVlhuUVllVXpGdHR1?=
 =?utf-8?B?VklGN3I4NFAxdHZVWjRSQys1M1VvT3hCNFV1Z2xhbkQ4ODZQM2ZwSVpjOCsz?=
 =?utf-8?B?dHl3Q0dzSEdhVi95c1JPT3lJQlFhVkowY3dCMkVOWHVlSnI1ZThMMXBRRG4v?=
 =?utf-8?B?cFYxS1JZT1N0Z3Z1Zk52K1RxcDkyTXcxTG8rbkw0K2c4d1lYaFBZNkJiVVll?=
 =?utf-8?B?MWM1cWpzdDV6THF2Q0RqeCtpWExib2VQUkdmazBBZXdpdVUzTm9YR2dlcEVJ?=
 =?utf-8?B?eks4Q2ljYS9jckRBRUNnWktmTWU0bjkwT3NzbGpDMGxHSjZ2UDcvbGY4VWh5?=
 =?utf-8?B?UjVMa1d3RjAvY3Q1VHQ5blp0K0pLWFpZY2NRM2twcUlVRnJvOFhtbGRPVWg1?=
 =?utf-8?B?U1BQWUVnclBQUUFnaHpMUzlPeEhDRHoxK3JpSjVlYVVaeDFiaFkzZ0dscTBZ?=
 =?utf-8?B?ZDA5b1ptWXVUUXBVREdVYnFqNzdMTlI1bmU4eERKcGNGVHg1UUsrSGJjM0tv?=
 =?utf-8?B?eUN2cldoMWQrQ3JFdkltd2RvZlAvNWd1RUVWQ2liRzNTeUJYWUJRRFZJeUVI?=
 =?utf-8?B?YTRoU2NqMW4wSHpjVDBjMnNoSFBkUWlYeGtaM3Y5cENxY3NpckVjQzNoa3lo?=
 =?utf-8?B?NVhoSnZzY1dVRVEyQk8xZDBQNFJCa0kxQjNMSjVvYWlueVI1bUhSRWlBMWpx?=
 =?utf-8?B?NDFUZjJXaWQ1bFkzeXpEOTZLRXlXQzQ0ZUE2WG9CTXlVVDVwQkJvQW5rakc1?=
 =?utf-8?B?NkhLay84V3dkWDRoTWNETGV4em1NNFAzZ3dJTVFUeEh3aG1MUlF6bDZDRFlx?=
 =?utf-8?B?NmFjZ0xaWFZoTTlBaER2bFBFTitadlViS21pMnJLTUpWZ0Q0bW1wOGJJamY5?=
 =?utf-8?B?ZEV1RjdFTzhYYW5DYzZPOGgyRDM2azNidmp4M0xmTHJ3K3dDaUdpS0JndWF1?=
 =?utf-8?B?R2lONFkrUW5mVlZRcGNnR0oxeGs5dTZmMFBIRGVjYWZ5QkZzYkJZeUMzd0FI?=
 =?utf-8?B?bmNqUm15THVmZ2xZNk5rUjdLQjRvK2lZeTV2Z2R0bHQrRHZIdERvazNKWGFa?=
 =?utf-8?B?NkxKZXY1R01jc25MQ09ueENnL2JJUnhCK3lTQVM3dVc3RmlwckJ1eWliU3Rl?=
 =?utf-8?B?ZWMwT0s0M1RqU2diSEhCZjJIMmdGYUt2TXBQd1JoVFdNTkhLS3VvdUZNalhM?=
 =?utf-8?B?VzRiUzdQbXhSdVRyOWxzTzRvUFI5dUNhcUVxSktXaU1mTzdEZWRLbCtneitm?=
 =?utf-8?B?bG5pdzlwanhlam5mUkYzdUF4S0VIL3k4eE9TMVZuYlhSWWdHbUZJM04wS0U0?=
 =?utf-8?B?Z0RSL21PUWpMY3BrNG42Sm9uRUY5d2dNbWpiL0xRTUZHZnNCVnRkOHd6RDIy?=
 =?utf-8?B?WXVMVjhrUHNwcW9ocDg2SzZuVWhWMEh5dGl0QjBaUCt6YlUrM1hTV0JVdTRQ?=
 =?utf-8?B?aGNSZVdlVE91dWdJQ1V6a1d0YWpFWXRXM3Q4YWZpdXZzMlRpczlyU1ZiUE9X?=
 =?utf-8?B?WndxNkU1bHJRSkhFRWlaU3JYMVhwSUNBYzNxeTc0U09iM1d4KzgwTDlTOGdl?=
 =?utf-8?B?ZUlndDV2SC9TdGpqVjRGQ3p3Uldnam9RLys1cE5FMG5XTzVLU1hNTmJaRlRT?=
 =?utf-8?B?UzVsK3htalphcHVxcHhFRWxOZlVrT1Mxd210Und2SGo2OFBMTEhLVEI2M2lV?=
 =?utf-8?B?aUdpT1ZmZnFHNUNndnVUSU1TNHZ5ajlxdUIzNW9YUlpRY1pWb0JIdWZvWGpq?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4034D5A3250CEA40809A16818A68C79A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37132ce-626e-4983-436a-08db8dcc9929
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 11:36:48.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHBV5ynYwZoqXo/uG8uX8NeT29G/P4iP7betleb4Q8gox+tMT5mdHVuzURybGySvy38eaQW6/2v9p1Cs16MMeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6228
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDA4OjQzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjYvMDcvMjMgMDQ6MTksIFRyZXZvciBXdSAo5ZCz5paH6ImvKSBo
YSBzY3JpdHRvOg0KPiA+IE9uIFR1ZSwgMjAyMy0wNy0yNSBhdCAwOTowNiArMDIwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IElsIDI1LzA3LzIzIDA1OjUz
LCBUcmV2b3IgV3UgaGEgc2NyaXR0bzoNCj4gPiA+ID4gVG8gYXZvaWQgcG93ZXIgbGVha2FnZSwg
aXQgaXMgcmVjb21tZW5kZWQgdG8gcmVwbGFjZSB0aGUNCj4gPiA+ID4gZGVmYXVsdA0KPiA+ID4g
PiBwaW5jdHJsDQo+ID4gPiA+IHN0YXRlIHdpdGggZHluYW1pYyBwaW5jdHJsIHNpbmNlIGNlcnRh
aW4gYXVkaW8gcGlubXV4IGZ1bmN0aW9ucw0KPiA+ID4gPiBjYW4NCj4gPiA+ID4gcmVtYWluIGlu
IGEgSElHSCBzdGF0ZSBldmVuIHdoZW4gYXVkaW8gaXMgZGlzYWJsZWQuIExpbmtpbmcNCj4gPiA+
ID4gcGluY3RybA0KPiA+ID4gPiB3aXRoDQo+ID4gPiA+IERBUE0gdXNpbmcgU05EX1NPQ19EQVBN
X1BJTkNUUkwgd2lsbCBlbnN1cmUgdGhhdCBhdWRpbyBwaW5zDQo+ID4gPiA+IHJlbWFpbg0KPiA+
ID4gPiBpbg0KPiA+ID4gPiBHUElPIG1vZGUgYnkgZGVmYXVsdCBhbmQgb25seSBzd2l0Y2ggdG8g
YW4gYXVkaW8gZnVuY3Rpb24gd2hlbg0KPiA+ID4gPiBuZWNlc3NhcnkuDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1t
dDYzNTkuYyB8IDIxDQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgICAx
IGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+
IGIvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPiA+ID4gaW5k
ZXggN2M5ZTA4ZTZhNGY1Li42NjdkNzlmMzNiZjIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL3NvdW5k
L3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+ICsrKyBiL3NvdW5k
L3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+IEBAIC0yNDYsNiAr
MjQ2LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19kYXBtX3dpZGdldA0KPiA+ID4g
PiBtdDgxODhfbXQ2MzU5X3dpZGdldHNbXSA9IHsNCj4gPiA+ID4gICAgCVNORF9TT0NfREFQTV9N
SUMoIkhlYWRzZXQgTWljIiwgTlVMTCksDQo+ID4gPiA+ICAgIAlTTkRfU09DX0RBUE1fU0lOSygi
SERNSSIpLA0KPiA+ID4gPiAgICAJU05EX1NPQ19EQVBNX1NJTksoIkRQIiksDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwkvKiBkeW5hbWljIHBpbmN0cmwgKi8NCj4gPiA+ID4gKwlTTkRfU09DX0RBUE1f
UElOQ1RSTCgiRVRETV9TUEtfUElOIiwgImF1ZF9ldGRtX3Nwa19vbiIsDQo+ID4gPiA+ICJhdWRf
ZXRkbV9zcGtfb2ZmIiksDQo+ID4gPiA+ICsJU05EX1NPQ19EQVBNX1BJTkNUUkwoIkVURE1fSFBf
UElOIiwgImF1ZF9ldGRtX2hwX29uIiwNCj4gPiA+ID4gImF1ZF9ldGRtX2hwX29mZiIpLA0KPiA+
ID4gPiArCVNORF9TT0NfREFQTV9QSU5DVFJMKCJNVEtBSUZfUElOIiwgImF1ZF9tdGthaWZfb24i
LA0KPiA+ID4gPiAiYXVkX210a2FpZl9vZmYiKSwNCj4gPiA+ID4gICAgfTsNCj4gPiA+ID4gICAg
DQo+ID4gPiA+ICAgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldw0KPiA+ID4g
PiBtdDgxODhfbXQ2MzU5X2NvbnRyb2xzW10gPSB7DQo+ID4gPiA+IEBAIC0yNjcsNiArMjcyLDcg
QEAgc3RhdGljIGludA0KPiA+ID4gPiBtdDgxODhfbXQ2MzU5X210a2FpZl9jYWxpYnJhdGlvbihz
dHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZQ0KPiA+ID4gPiAqcnRkKQ0KPiA+ID4gPiAgICAJCXNu
ZF9zb2NfcnRkY29tX2xvb2t1cChydGQsIEFGRV9QQ01fTkFNRSk7DQo+ID4gPiA+ICAgIAlzdHJ1
Y3Qgc25kX3NvY19jb21wb25lbnQgKmNtcG50X2NvZGVjID0NCj4gPiA+ID4gICAgCQlhc29jX3J0
ZF90b19jb2RlYyhydGQsIDApLT5jb21wb25lbnQ7DQo+ID4gPiA+ICsJc3RydWN0IHNuZF9zb2Nf
ZGFwbV93aWRnZXQgKnBpbl93ID0gTlVMTCwgKnc7DQo+ID4gPiA+ICAgIAlzdHJ1Y3QgbXRrX2Jh
c2VfYWZlICphZmU7DQo+ID4gPiA+ICAgIAlzdHJ1Y3QgbXQ4MTg4X2FmZV9wcml2YXRlICphZmVf
cHJpdjsNCj4gPiA+ID4gICAgCXN0cnVjdCBtdGthaWZfcGFyYW0gKnBhcmFtOw0KPiA+ID4gPiBA
QCAtMzA2LDYgKzMxMiwxOCBAQCBzdGF0aWMgaW50DQo+ID4gPiA+IG10ODE4OF9tdDYzNTlfbXRr
YWlmX2NhbGlicmF0aW9uKHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lDQo+ID4gPiA+ICpydGQp
DQo+ID4gPiA+ICAgIAkJcmV0dXJuIDA7DQo+ID4gPiA+ICAgIAl9DQo+ID4gPiA+ICAgIA0KPiA+
ID4gPiArCWZvcl9lYWNoX2NhcmRfd2lkZ2V0cyhydGQtPmNhcmQsIHcpIHsNCj4gPiA+ID4gKwkJ
aWYgKCFzdHJjbXAody0+bmFtZSwgIk1US0FJRl9QSU4iKSkgew0KPiA+ID4gDQo+ID4gPiBpZiAo
c3RybmNtcCh3LT5uYW1lLCAiTVRLQUlGX1BJTiIsIHN0cmxlbih3LT5uYW1lKSA9PSAwKSB7DQo+
ID4gPiAJcGluX3cgPSB3Ow0KPiA+ID4gCWJyZWFrOw0KPiA+ID4gfQ0KPiA+ID4gDQo+ID4gPiBU
aGF0J3Mgc2FmZXIuDQo+ID4gPiANCj4gPiANCj4gPiBJZiB3LT5uYW1lIGlzIE1US0FJRiwgdGhl
IHN0cm5jbXAgZXhwcmVzc2lvbiB3aWxsIHJldHVybiAwLg0KPiA+IEhvd2V2ZXIsDQo+ID4gdGhl
IHJlc3VsdCBpcyBub3QgZXhwZWN0ZWQuIEkgcHJlZmVyIHRvIGtlZXAgc3RyY21wIGhlcmUuDQo+
ID4gDQo+IA0KPiBZb3UgY291bGQgYWxzbyBkbywgaW5zdGVhZA0KPiANCj4gaWYgKHN0cm5jbXAo
dy0+bmFtZSwgIk1US0FJRl9QSU4iLCBzdHJsZW4oIk1US0FJRl9QSU4iKSA9PSAwKSkNCj4gDQo+
IC4uLnNvbHZpbmcgeW91ciBjb25jZXJuLg0KPiANCj4gDQoNCkZyb20gbXkgdW5kZXJzdGFuZGlu
Zywgc3RybmNtcCBpcyB1dGlsaXplZCB0byBkZXRlcm1pbmUgYSBzdHJpbmcgYmVnaW5zDQp3aXRo
IGEgcGFydGljdWxhciBwcmVmaXggd2hpbGUgc3RyY21wIGlzIHVzZWQgdG8gY29tcGFyZSBhIHdo
b2xlDQpzdHJpbmcuIEluIHRoaXMgc2NlbmFyaW8sIEkgd2lzaCB0byB2ZXJpZnkgaWYgdGhlIHdp
ZGdldCBuYW1lIGlzDQpleGFjdGx5ICdNVEtBSUZfUElOJywgc28gSSBiZWxpZXZlIHVzaW5nIHN0
cmNtcCB3b3VsZCBiZSBtb3JlDQphcHByb3ByaWF0ZS4NCg0KVXNpbmcgZWl0aGVyIHN0cmxlbih3
LT5uYW1lKSBvciBzdHJsZW4oIk1US0FJRl9QSU4iKSBtYXkgbGVhZCB0bw0KaW5jb3JyZWN0IHJl
c3VsdHMgd2hlbiB3LT5uYW1lIGlzIGVpdGhlciBNVEtBSUYgb3IgTVRLQUlGX1BJTjEuDQoNClRo
YW5rcywNClRyZXZvcg0K
