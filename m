Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEB76967D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjGaMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjGaMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:38:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA8E47;
        Mon, 31 Jul 2023 05:38:11 -0700 (PDT)
X-UUID: 1a968a6a2f9f11ee9cb5633481061a41-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=LBw22o1fvVe6sNTWwzg3FpxjI1Zc0e+uyai4qMW8OG4=;
        b=o575qfk4/QSLqZs7vJLqUWOfVQxMR97ZQdrkETg1Xc0SIq3w5KNhbKCJpODizBsj/dOGE2JOuiT6KYV3JiQQUIPfHWGTKx3FzI8wwYXtiMci1GjOpU3Z8dbJYLQAU2a1OPYmPDmEciydIG99vd3Ceez0U5qmHtkmnxhWGp82A48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:50700796-f69c-44cd-a72c-32f35d55bfe8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:7da5b9a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1a968a6a2f9f11ee9cb5633481061a41-20230731
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1786256656; Mon, 31 Jul 2023 20:38:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 20:38:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 20:38:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+K0p3lbzNVpkDSX8DuUqfCPWu00CsJ+8xHGBGQDZDA7kpiVc7rWylEKqDoHkAZV2fJwoPKZeTPk7Y7ydvjuebHAoOYsVD8643phNox4ieLYaqo+LEcRa8A+cnlL2EFkDszCuTN/mLcfPKlln8wEo3B0AiuAgfUBsCwTPQRjh1DqP57IFfCH/BNPSatdNHjRprAY+EP7PmSgpkkNhhGnUp5cib5Dgrdn2Urppk7EXweCnPLFZm3MGqzMGC+4hIlCEDaVMdZqbVGptRZ72b0YiuFW2skfNPwhz/Hg+bsJmt6pf6rtcGWn6GFoID2qzcRJFERiifrqniImT01NRxR4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBw22o1fvVe6sNTWwzg3FpxjI1Zc0e+uyai4qMW8OG4=;
 b=U9ubqDr4l3SNYk0fA+MxvCKq/uObFZMZDw3eJ7GL1P8ET5AgAfO01jckQ9jniPWec59kATPze8Zjzh1opjk9gHxuCIbWqaPSkeoTD3kUYKsOp8GZkEbRfKAs+PXRjrl6MhXxV5wAs8krr7/K1BFyMY8dQL945aFAeOjfkhWsPcKybE5vyOy5sdMn9uZYMk32h1hSCngxpwrKs2ykWBn4o1dIHJ9bIL5PBn2+eWzU6/ySfOBnU8A42lYgENiHvC3lb/92vNXILoUUMc6+83tAVi/smHEa6YG3+aYNlCHXbOr27aXnCtKFi4vT8ZsPVbZeaDCQjOIJy2YTW53+BqczHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBw22o1fvVe6sNTWwzg3FpxjI1Zc0e+uyai4qMW8OG4=;
 b=oj5LPRvqKta7H9S6tPj2FpNaM1LGi2hzv3bJcnyvoW13xkjnIRpNthcM5V6okcnYOJd39WDExmSTuzS7DRiVRrZ/OlPnbSoYCnWBbFiRPPeoDEzHi9K5VaTkp8eo1tPTWWocjQfPbXqoY8vSTxzS+gamjVo+6gtfPKTdM+Ot+d0=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TY0PR03MB6426.apcprd03.prod.outlook.com (2603:1096:400:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 12:38:04 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::7f10:d3b7:86ae:4271%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 12:38:04 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Topic: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Thread-Index: AQHZwTM9qZx2VdeqykKSfnhu9XP0Bq/O8P2AgAAFtwCABHskgIAAQ9oAgAAfmYA=
Date:   Mon, 31 Jul 2023 12:38:04 +0000
Message-ID: <9096ead3acac8dd3e18915204b8c50aebe3b4ff3.camel@mediatek.com>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
         <20230728090819.18038-6-maso.huang@mediatek.com>
         <8e207baf-4a85-71f1-8ea3-08eab438b7cd@collabora.com>
         <ebfc016f57ec50ea8026efdce575813a75676b5c.camel@mediatek.com>
         <4aa7dd33239d568cfdf46f1e403bdeeef947726a.camel@mediatek.com>
         <fc142ae5-bc96-ca95-eb96-e54d6d9cdb22@collabora.com>
In-Reply-To: <fc142ae5-bc96-ca95-eb96-e54d6d9cdb22@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TY0PR03MB6426:EE_
x-ms-office365-filtering-correlation-id: 4f8750e5-1746-4bbd-bad8-08db91c2fc53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWxDkEmb8zC/MqrNv2ITqKsOsp/AlDY1zySRa1z1gV6nkyFD3sXSWhkZ5ACCAhc9U8hHsmAGlqxqlorFUEYYaA7wZOkZRlznU1gAF20ZR59zQe1f3GdI1jp72x0+sZK5Dsi7iyRFWcll+gnYbI3MF+zKVYLfQwz0s1DZH0Glp8jlNoUQczjKOVWRYSPeeB5FAXKHUB42YdFHToAYN8lQ1axTnSpYvs8SaVKfUSyTW3Ls3LTXe3enueCevN5MPXfZ4hITkG0YgC4nU7yPAkiC7P7lcWl5Fi0nccY8zQPFSigqgHgcE3HvbePASPmc7VJaQAHxx7GddomcEbb8Q6y1I3OmgLR3qCgd/32SPiw5pWCdLFWOYsrED6tP4ELTFDtFoQqXOWzT9dI/VBvLZek+VEGrIUNwk/mv2RurcNTvhyRkFyQOj+juYMnsf/yXAPs2KzCRW4c3gntZyn8f4QSoV8eyWglOU93Edt51N1fmv10EOxa/ocAob0jCjlPLmUamPXdjakhjawDpKic3+KpOBwmR29nPqImMMNBunCdB0tHCl+cxwwnsZQqjn0hElzEPLm50LfnT4/ISbBOx9r1Ldf/azJH3gZE17C1YsIwY47sLO27gLbg3BP71qLIknHsoPRXbEhkX38mUr0qYhjCUrCu+ZWunJGAC0DV9b+QIXq0cUmlX/Vt4K1zdNOnxlmIhOiRyDjAHXl4Q78JSm4a3rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(966005)(6512007)(71200400001)(110136005)(478600001)(6486002)(36756003)(85182001)(86362001)(38070700005)(2906002)(2616005)(91956017)(186003)(6506007)(26005)(122000001)(38100700002)(921005)(66946007)(76116006)(66556008)(64756008)(66476007)(41300700001)(66446008)(5660300002)(316002)(8936002)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVo2UHNWOFJGdlNmRXB0VkhMVmkxbHJ1UlpvWk9NanFJV2Z4WHdTZkxoS05M?=
 =?utf-8?B?aEE2YzV6cEZBUGhVTWxSbU40RXNQSjRsYVordTZzS3NmZFZ3cm1XQlE0Mi8v?=
 =?utf-8?B?eGMzdW94M21aMUFUMVpYdk9xc3lHeW1lajJnblhvRnhEbEh6eGpOemNoZ2VR?=
 =?utf-8?B?S1djTEdBKy9EL3hnOXJNa010NCtCeG16OEpKalc3VXBWb0IzZzQ3VjlKbzhi?=
 =?utf-8?B?TjZOS0YycmxPMlBtWWlNK2JFTFU5RWNIanY4RFZPcGxpNFgrRVJiclVFOWRQ?=
 =?utf-8?B?QjVtRFNCTG84b1hEbTVVZ24zYTVyMFFlQkFOS3BxQzlRYkV4NmZEc1FHcGhJ?=
 =?utf-8?B?ZnNtRzVoeERicnJ4Q2hsRnRPeWdFRlIzV01nQUwxRVFabGZ6Wmx2Ty8rb1BM?=
 =?utf-8?B?MUhhWlJhMy9ueVd0VU5BWlRUWDhNUVQxdW50dUJvK0kyb0Z5SUNsVTdPQXdX?=
 =?utf-8?B?RlRrUC9HbDkxOElzVzArcVF4T1FYVXNCaTdSQTFoNlNwMW9YclBtOE04S0xx?=
 =?utf-8?B?NzJoSlMrNURkMEZiaE1VTXM5dUlVTzRla3dSOFBOSTIzRDV3ZS9EL3B6ekVS?=
 =?utf-8?B?K0FwS1pEcEdsa0ZvMGdBZ2NMSnM5OSt3ZHYrSEpTUW0xd3l1dld5WmV2UjQz?=
 =?utf-8?B?SG9QcG1xaERMVTM3ZjMvMlZ2M2dqNmpnSFRGV0tFUG9EdEhCanFGbXBHVElY?=
 =?utf-8?B?bWFMdlNUQ0twUzR1cG9VRXhoOU15aVFtT3YzUytNL1FUS0JYVDBpanVqS2hU?=
 =?utf-8?B?NFprRTRBWlBzanlkYTlsa25UTXNKMFJ5dEdZam1mK0lXTlp4UjFhdXVoaDFj?=
 =?utf-8?B?Um8zd2V0d29hYkNIdzJFU1Y5VStIdTdYN3dqM3hVeHk3b2N0MEc5dWxGdWsw?=
 =?utf-8?B?TE5WeGN2c2lEZWpzdUdDREhVQnJ4eXJQdlB4bkxPUzAyUll1NTVDVC9ZVjhJ?=
 =?utf-8?B?VTFZY1RoaTkxRXVVTUxiV1Q2cWxEZlFNcm53STdqZEM4QW5YNythdHJ6WUFW?=
 =?utf-8?B?M0RUSzE3VU9Sd0Fua2t4MmovZ0VlNGlHM0tQNFMwVDlKc0FzRFUvS0dxMUVY?=
 =?utf-8?B?Q1FXdlRzdHliL1FLUVA1SzFnWTF5Z0NaTUhJL3lpRlFoR0VHaXg3U1dhSTFK?=
 =?utf-8?B?b2JpclRJZ0FRQWplc2U2VklNSjJaQlREK3RIT3QyKzZCY1BLc3ZsVXcrcmxz?=
 =?utf-8?B?RVlnT3JoNEhQMVlZV3JPTHZGSHFhdnhqRUcyc3JqY1EzTU9NRldoQks3MjlQ?=
 =?utf-8?B?Z0F2SUVocWRPcXIwekhDY3lWSnd4bHlBR3NkTnRXeVd6b2hoelhRbXllWDdS?=
 =?utf-8?B?OVVIaG0xVzZ4b0VlWm9GZis3WHpzbjdDeVF4NElIeGdQcDU3MzhOdXlPTzZG?=
 =?utf-8?B?eVR3Mi9xT3dCU1lyYzRwVmdCajlXenU0dE9veUtVSGhhaUJKRjRZVUhuczAz?=
 =?utf-8?B?UWtycC9lblk5ZVA2aDY2SytSd21idlp4cGZTYTlxNDZ5S1VSTmM2Q1JuMkN3?=
 =?utf-8?B?T0ZpVkpGKy9tYkxLbnJGQ1BZcHA1d1IveDh0SktYZi9ianNJbmw2KzNZRkFP?=
 =?utf-8?B?RlY4NFg4MnpvN1ppYWZqVlUwRk9QMGNydWM4aHJLS2NTczY1WThvc3ZReGFK?=
 =?utf-8?B?YklKUEVCT2NaOExycWg3ZVpSaXNTMTBmTGhBNHVXNDZHUFhDOHp2Rk40QThZ?=
 =?utf-8?B?VnlMbng3akgxRWZQcWhhY090bDhRdkUwQWlaMzEzcTljWWJJR0krMHFOSDFX?=
 =?utf-8?B?L1AxcnN0Q21iYXAwSk9FZVVtQlkwQ3Bva2l2Z29Qd25Ta2FjQkNaaEFvSXk4?=
 =?utf-8?B?NWk0ek9wVlg0RFpwTjJHSVpEb3dwRTBkejF4OVBzNGFQQ3pjWU9NbmZyWlVQ?=
 =?utf-8?B?OENFcXI5aWxmWmo4bkwzQmtzVXhYVXdkRGdITUhNUElvbHFWb2dZb2grWWxM?=
 =?utf-8?B?bVpZRHc5Y1k2aEtGSldoRkNvc1hYSGpiUU1ndHZqY1Ayb1NKUEVZS05LT0Jv?=
 =?utf-8?B?ZWk0dmxnTUhVUmhKc092ZlVTZVQ4T1ZVSHZwUTB2djRFUk5raFo2cCsrVytn?=
 =?utf-8?B?eXZLRnRMa0d6ZFFWZG8zLzRjZmV0MnpiQjJzOWJjeEpYRFJpMVNsczlMVUFI?=
 =?utf-8?B?NmNscnE4QTYwSUdGbkE2azRQRnhjZzdjNFpxSGNpczBOUGpEZFB2K3dFZTE4?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AE55F18C2EADF40910DA9235E345DE2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8750e5-1746-4bbd-bad8-08db91c2fc53
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 12:38:04.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tuN2sqTZemPbE8lLfv8IkNuFS51hbLNwg93FMiMv04vlfputF2lliq0LDluN+ACRuGCVFOEwtjrdwi0kUmXMmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6426
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTMxIGF0IDEyOjQ0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMzEvMDcvMjMgMDg6NDIsIE1hc28gSHVhbmcgKOm7g+WKoOeruSkg
aGEgc2NyaXR0bzoNCj4gPiBPbiBGcmksIDIwMjMtMDctMjggYXQgMTg6MTYgKzA4MDAsIE1hc28g
SHVhbmcgd3JvdGU6DQo+ID4gPiBPbiBGcmksIDIwMjMtMDctMjggYXQgMTE6NTUgKzAyMDAsIEFu
Z2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gSWwgMjgvMDcv
MjMgMTE6MDgsIE1hc28gSHVhbmcgaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiBBZGQgZG9jdW1lbnQg
Zm9yIG10Nzk4NiBib2FyZCB3aXRoIHdtODk2MC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
PiAtLS0NCj4gPiA+ID4gPiAgICAuLi4vc291bmQvbWVkaWF0ZWssbXQ3OTg2LXdtODk2MC55YW1s
ICAgICAgICAgfCA1Mw0KPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAg
ICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ICAgIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiA+ID4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tZWRpYXRlayxtdDc5ODYtDQo+ID4gPiA+ID4gd204OTYwLnlhbWwNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ3OTg2LQ0KPiA+ID4gPiA+IHdtODk2MC55YW1s
DQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVk
aWF0ZWssbXQ3OTg2LQ0KPiA+ID4gPiA+IHdtODk2MC55YW1sDQo+ID4gPiA+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjc2Mzk0ZjdlNTUwMg0K
PiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gPiArKysNCj4gPiA+ID4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtDQo+ID4g
PiA+ID4gd204OTYwLnlhbWwNCj4gPiA+ID4gPiBAQCAtMCwwICsxLDUzIEBADQo+ID4gPiA+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNl
KQ0KPiA+ID4gPiA+ICslWUFNTCAxLjINCj4gPiA+ID4gPiArLS0tDQo+ID4gPiA+ID4gKyRpZDoN
Cj4gPiA+ID4gPiANCj4gPiANCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9tZWRpYXRlayxtdDc5ODYtd204OTYwLnlh
bWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFsdTRaNnBKZVJpTDctOGw0VDNwdHFVQ001NEZuSFRC
aXloNUtXQk5xU2psNm1PT0k3V216SHBXRWQtWlNaLTJOSjRDczlQUGFBRl83NXl3bzJTS1cxNk1Q
UFJhUk90MCQNCj4gPiA+ID4gPiAgIA0KPiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gKyRzY2hlbWE6
DQo+ID4gPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3
TWcwQVJidyFsdTRaNnBKZVJpTDctOGw0VDNwdHFVQ001NEZuSFRCaXloNUtXQk5xU2psNm1PT0k3
V216SHBXRWQtWlNaLTJOSjRDczlQUGFBRl83NXl3bzJTS1cxNk1QdHRaSUxBbyQNCj4gPiA+ID4g
PiAgIA0KPiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICt0aXRsZTogTWVkaWFU
ZWsgTVQ3OTg2IHNvdW5kIGNhcmQgd2l0aCBXTTg5NjAgY29kZWMNCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gPiA+ICsgIC0gTWFzbyBIdWFuZyA8bWFzby5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+
ID4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiA+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssbXQ3
OTg2LXdtODk2MC1tYWNoaW5lDQo+ID4gPiA+IA0KPiA+ID4gPiBtZWRpYXRlayxtdDc5ODYtd204
OTYwLXNvdW5kIGxvb2tzIGJldHRlci4NCj4gPiA+ID4gDQo+ID4gPiA+IEFmdGVyIHdoaWNoLA0K
PiA+ID4gPiANCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IDwNCj4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhpIEFuZ2VsbywNCj4gPiA+IA0KPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPiA+IEknbGwgY2hhbmdlIHRoZSBjb21wYXRpYmxl
IHRvICJtZWRpYXRlayxtdDc5ODYtd204OTYwLXNvdW5kIiBpbg0KPiA+ID4gdjQNCj4gPiA+IHBh
dGNoLg0KPiA+ID4gDQo+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiBNYXNvDQo+ID4gPiANCj4g
PiANCj4gPiBIaSBBbmdlbG8sDQo+ID4gDQo+ID4gT25lIG1vcmUgcXVlc3Rpb24gZm9yIHRoaXMg
Y29tcGF0aWJsZS4NCj4gPiANCj4gPiBUaGUgc3VmZml4ICJtYWNoaW5lIiBtZWFucyBhbHNhIG1h
Y2hpbmUgZHJpdmVyIGZvciBtdDc5ODYtd204OTYwLg0KPiA+IEl0DQo+ID4gbWlnaHQgYmUgYmV0
dGVyIHRvIHVzZSAibWFjaGluZSIgaGVyZS4NCj4gPiANCj4gPiBPciB5b3UgcHJlZmVyICJzb3Vu
ZCIgdGhhbiAibWFjaGluZSI/DQo+ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IE1hc28NCj4g
DQo+IEkgcHJlZmVyICJzb3VuZCIgYmVjYXVzZSBvZiBjb25zaXN0ZW5jeSB3aXRoIG90aGVyIE1l
ZGlhVGVrIG1hY2hpbmUNCj4gZHJpdmVyDQo+IGNvbXBhdGlibGUgc3RyaW5ncy4NCj4gDQo+IFJl
Z2FyZHMsDQo+IEFuZ2Vsbw0KDQpIaSBBbmdlbG8sDQoNCk5vIHByb2JsZW0sIEknbGwgdXNlICJt
ZWRpYXRlayxtdDc5ODYtd204OTYwLXNvdW5kIiBhcyBjb21wYXRpYmxlIGluIHY0DQpwYXRjaCA6
KQ0KDQpCZXN0IHJlZ2FyZHMsDQpNYXNvDQo=
