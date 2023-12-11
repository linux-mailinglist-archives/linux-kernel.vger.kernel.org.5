Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2C80C048
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 05:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjLKEI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 23:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjLKEI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 23:08:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306E2F2;
        Sun, 10 Dec 2023 20:08:26 -0800 (PST)
X-UUID: ed38245897da11eea5db2bebc7c28f94-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=q7kpojaN8YJBJmunjUXeAJdj/8dKLKq+PNeaMGr8Anw=;
        b=ebJCjZeXY1e+z1KhErBrRUF77pInJ3AwfhuazyuwLCk5dEfGoKou51REaqpjP1axVyUQMpzRUeA33U/beDWF94bi41nKwml7wD4wAoQoNpmOJvpq5nBr9sl+km16fzRKE7uHFK3tTaIrukwrKKeR7+H1+yLPr0e0G0UIxylbtVU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:80ac9f92-e4c1-4eb5-832e-c0c22825a741,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:87ed83fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ed38245897da11eea5db2bebc7c28f94-20231211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 130414138; Mon, 11 Dec 2023 12:08:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 12:08:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 12:08:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkwCCB2cnaidhGli4gLjfNPl/2Aq06zMI9ljjOsQGBRbSBGrKcvsQypPg3T0dUDd7cODv6+qBaxsi05Gr8iGXMn5LxQ9b0dDtkg/4cUnB0u/WXGSI9aXtetbpD7XyLQbLFtoqAlrK5eOtVmi1nByCJnlYS/Lt7PjGtS4k4tyfX5jy+4h+wrJ7Wjj2kB/5Iv0FtJL6JGcJgSutWSNzDThp51JtBF6suPcO/fX5JAhpMwykrNpVGdpR4VKvKFtMP/FqghoAlFc4GR9pBM2r15J8OKshodQ2ZG0dnuej2PVTzARF5OdqJRyFEUFiXNY4b3+yxQG+3kZP6sI4WwvDdOwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7kpojaN8YJBJmunjUXeAJdj/8dKLKq+PNeaMGr8Anw=;
 b=YvlaDjSpo9gtHWbqOOnHfZ5SUxI0Uet9enytwfR4VikViXhxtDUHhVh0K5zk5RPb/bryQtETWzweGgxnq0N06MhMTBoNoIgWapKeVqepsaCNthg6NV95mksJUZGhQBz/o2imZcw8mnSfygm39eztg8xmtfFxlT0/a/qB5/q8HnVaPUFVaFMiEAmbVNofa9WZ1kOf+yO483KIL2oOqxhkcr77ws41a68ndVzj5ntl2rqRHed71T0Ybb/lcSS2aYaVedZpbQW0JpBoV6dXL3C5nDluNzTD6gACPbL6Q6AKF1+OIl6lBMG7/kQjc0WS1JdNFNIJ6pAOJGa//x4D9Z+rVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7kpojaN8YJBJmunjUXeAJdj/8dKLKq+PNeaMGr8Anw=;
 b=ZcVsguK2Ufu4bbe/kR/1VuF5UbKVVDDkJxnA0cj6xeDWYz/fAjWyNAAmB03c7C2Ox7dDJipBkKt5KV77VVNMM7Hev3Xgp5Ld3ThoL+H6cgI9yMGuCSbOi18QAugMhcGRXt3kKaBigA+yLdGOzNn5FVW/5ZD7NcY6CI7n93VNFG8=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TY0PR03MB6632.apcprd03.prod.outlook.com (2603:1096:400:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 04:08:19 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::882f:76f:6f8e:8208]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::882f:76f:6f8e:8208%3]) with mapi id 15.20.7068.025; Mon, 11 Dec 2023
 04:08:19 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt7986: silence error in case of
 -EPROBE_DEFER
Thread-Topic: [PATCH] ASoC: mediatek: mt7986: silence error in case of
 -EPROBE_DEFER
Thread-Index: AQHaK9IbzfRshSY4JUG8ZxIEC989ObCjd7MA
Date:   Mon, 11 Dec 2023 04:08:19 +0000
Message-ID: <c0fdf2820d2cfb14ed40b39ab9b4e6fd43a0ef3d.camel@mediatek.com>
References: <98491ec78ab671f5a14fce42d10f9745ebddb112.1702258360.git.daniel@makrotopia.org>
In-Reply-To: <98491ec78ab671f5a14fce42d10f9745ebddb112.1702258360.git.daniel@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TY0PR03MB6632:EE_
x-ms-office365-filtering-correlation-id: 5e6b05f0-4e90-4a97-1775-08dbf9fecf20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xN7K+GzmRMQaMea8cWs3RDPhxsP2bc191u7miyxx65CsvNMR+ELx0LiLTtuOz+aXmCRgqKg3ofkYSH06N3sPjRKzV0vzcyVnaiFOSyKnOcneVvAcG+E+ceqkxkDUvYE7hTg08wiGJ/jgDra3j6leOIYLWrSF3E6c+vdfPDdOsfntKYIs42x1kUpPMN80O8ddCkHDiCthrz8zyX39YfWx0lj0uwuyUqAvuoSATginwFsIZhIYF+L2+IsW1JAakW2mBEcqhzRqNOZ+sh0XbsTKSSmslD2tkcmRjLJVRN0tV/av3ovMV+lYcrdp/SeTuoqVrjgdbtEwmIiWyLs8hKLfHZuDNSlc53Qtv47/a8Wr/M22mVWEAd9zKr/m8/LQgDrcxKPhM/HdFgYwhTzc/+xdzfAuwDO5jteEFVQRQ4zur/hptIOPh8JMNlmBTLRTsRfbqyA0JFyJFD8V9INY0Wz5gUt4Xu4X5vCj1g/jigSsTXwqcwQ7dulnTRa1jueDkyDzYPEq/GrqJia+99e0rVKqxL2elzjMxQjtrOddNSQXJURokeiYPLdVr5kWjPYpEuB7P6FkxENbrKVc5wgMDUB6PqVCtqHDnYFrt5qIWN4IT1ZcY1WzKYpnSD6WhQ20nITgq6YY8WAAcQef8/G6+r+HMiHYYrFQw0uCugEixw0JMYsKIYuz20+fak1PpjoghSpC66hvcI+MQUrWRbgT2cxq2znjH4LtcIQqN/sEurLdoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(6506007)(26005)(2616005)(478600001)(6486002)(71200400001)(83380400001)(7416002)(4001150100001)(2906002)(5660300002)(41300700001)(76116006)(91956017)(66446008)(64756008)(66476007)(66946007)(66556008)(110136005)(316002)(8936002)(8676002)(38100700002)(921008)(38070700009)(86362001)(122000001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNLS3I3TXIxZzFlcVg5ZjlUdElQU3Y0aUl5MG9NNjZvMVdsazI3ZGtrR2Iv?=
 =?utf-8?B?Y3U1WENnYjFEWncvV1ByWWVJMXgvQlZvcTJRLzNFWjIybXpjbVN5Nm1qekFC?=
 =?utf-8?B?amVGb3Nka1VEMmI5ckFETWZBME02SHl5dG81ZEVaVUg2TGkxbG53b3BxMUhC?=
 =?utf-8?B?NFdWTlJpMjFkS0VEN2ZkSS9ORjNRdWhoUkhycU1aSVdRSmJUM2NKbUFKdmcz?=
 =?utf-8?B?ZzE5bkNJcUtDa3c0Zmd5bWNWTzZJclpnYVdTSVJkcS9ydjZTSHc3U3NJYUtk?=
 =?utf-8?B?bkxwcFJVbUFGRWllWFJxaWwwQWNnRVlZRHB4WHovV3hYbnN0Y1lrZ2dpNlFQ?=
 =?utf-8?B?NzRBUUpXM2JPTTBkZk9Gb2d0alhKd2pVbUUrUEtwSjJLOWtFRzVDcytlVlU1?=
 =?utf-8?B?VElONEVsMnlOYnBza1VxOUVqRDMxamhLZ0phUHUzcnRRUW43Z0d5blBwVFJS?=
 =?utf-8?B?ejJLaEhydmxEQktmazFFMmFpbzBtSmVGNGpXS094ZFViVG1GazBNcHBmdStJ?=
 =?utf-8?B?TEx6OSt5WFd3MzB3ZjkyRWo2Y2w3KzVWTVZad0syaDN3YkJVcmhFVmVwclM2?=
 =?utf-8?B?U1NWSjZ0REVvSW1TcmtlSVl2cDlEcXhzNGNzV1IwRXBQb1VoUzlOanVQV2lR?=
 =?utf-8?B?Q1FGTUNXTFQvRGhRTTExMU5zNHZQUUxHZzFMV3o4T2pFN0MzSkdYd3dRTjQ2?=
 =?utf-8?B?dXdmQXhkMmVHQk5hMHFHNVFyU2l5RTJjVFBWazU3emdQWmhGejFaUEFNL3Zi?=
 =?utf-8?B?M0E5b0NLNVZTUE14NG9tVzFNU2ZQV0xnZkVhWis3aTBSRGJZVXc5MVFsUGtI?=
 =?utf-8?B?WkVtY1lvVFZFa0tQNnRyQ1ZGdk5WeEcvMlF6eW1JSStLQllNWnRzdWpRMzE1?=
 =?utf-8?B?a29JNk05T08wYXVCR0ZBTXVocExTZWtnMDU0SlduQngybFVING5BRXZmQzRJ?=
 =?utf-8?B?ZEFHOUJJdGI4SDJoQUtGOWc4KzZUd1MyeitBUkpoTUpsODU4NjRlWDlNb1FO?=
 =?utf-8?B?eGtOR25YWnlqM1lPTzAwMThLNkVNMklJa2gwOEkzM040eDdPaHgvQjlMenp6?=
 =?utf-8?B?RmZDMWJwUGd6U2d5MG95K0lGbHgwU1dQTEVCSHJRaWYwYnduL3pYM0oxQU5S?=
 =?utf-8?B?ZkFYeGVmVC83Umpmc1NBRXlYYWJtN2dIRjdnam82SkxDbC9KZkhLbFduZHB1?=
 =?utf-8?B?cTd6M0ZzWjZjdlZnYUV6a01kS25YNjIwUjc2aGtQTVArRXZ0UlpZR3NpTjZU?=
 =?utf-8?B?bFJnZzdiTlFibTNpbkI3RFgrUVNpdmluV01YVUcrZnlpV0FRVjBRcC9zcVFw?=
 =?utf-8?B?QlZ4RkI0MmJXb3kwL0ZwL1VZRGRqMUZCRlFSbzJ4dTBEb1J3L3M4N01QbXNT?=
 =?utf-8?B?em1SaFNWVWMxcDF4aEJUblNpaTRkTDZjeVNhZHBta2FocVNWcm4xVGNtUGpT?=
 =?utf-8?B?N3V0TTFnTklFdDF6bE5zb0lDV1laS0xDMHpCMm4zRW5tNWw1TkU5Vkx6S2Zq?=
 =?utf-8?B?NGt6enY4TG5KNm4raEhXNVNOV2JBd0RGNC9SaE5SUXBzUklHd1R2R2NMUlZy?=
 =?utf-8?B?WFh1d3J5SU9VNGhmaVl2MVhMVTJFMXY5TkM4ZVhEYnRZTnE2c0hYT1FkWFJM?=
 =?utf-8?B?ZkZrM1hpZUptVTd0cVkra1hsQ0NkMk84RWdlU1dEOVBST095WGZ1Mlp5clhj?=
 =?utf-8?B?a3ZXY3hBTVRjYUFkQlZWdDdaQlBsS3I1SlM0TFJlZWUyNHNiMmNhekxzM2pw?=
 =?utf-8?B?YVpWK3l3QUFOVDc2TWxGWkxhU0d2YmhTQm92RkM4Q3VKWkJXWUNEMEJZem95?=
 =?utf-8?B?dGRFUnFOQ0s5Q3BaeDFWenpiUzZCUlJ0WjhGbEE2U0ZpdGY2bmx3c0dUUVlo?=
 =?utf-8?B?cXA5VFNON3ppZXExNU1xVWNubFJ2TkF1MUhRdDhBWGxmTGwycnZvYWFsUlI1?=
 =?utf-8?B?dEhDaWFZNTdZbEo4eGRBRjVpbzZMSFJEOVlxMW1hWUhJc3FyM25JQVlyZ2E1?=
 =?utf-8?B?citTd0l5bGpQc2lJSmpqc2E0Szg5NlRiU2pHNTJlbDFaTDZLTXo4aTF5U3gr?=
 =?utf-8?B?Nys0MDl6aFBPckVOb0l3WGl4a2g2SmFHR1d1VVUzdE1oSG5talJQYiszbDAz?=
 =?utf-8?B?bnFPb2NqU1NFTm52TnpLSjZVenJEc244Ui8zNnp5R0FmUklBRnordmpyTm5F?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B4C2BE4E53D0444A6B4E78B34604095@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b05f0-4e90-4a97-1775-08dbf9fecf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 04:08:19.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9DhIy206ewaHym4ZARQCItY6D4ru1Es1e8HQdX/Cxb5IseK3IIe7Z4hxFSKiHFbJr95jKFwKHovP/ykpeBXhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6632
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.327300-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2Y1bQMCMvmn7y118CCumToVxTR00Ss4P6+Vi
        hXqn9xLGFWYX2TPbDEjM+BDrFyS2u/gpwLIoRZLaeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZx
        EAlFPo8/cUt5lc1lLgoGRyAacnhaa/NhnySPVpfz7NDHPznwnXhwYO42UvYGsT3oCPMp4Z9X7cG
        d19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.327300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CDCEE3A3FE255F804F2343CD8C9C2F94EA32D80C3B049BD65823322CEDA55A562000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEyLTExIGF0IDAxOjMzICswMDAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgSWYgcHJvYmUgaXMgZGVmZXJlZCBubyBlcnJvciBzaG91bGQgYmUgcHJp
bnRlZC4gTXV0ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBHb2xsZSA8ZGFuaWVs
QG1ha3JvdG9waWEub3JnPg0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hc28gSHVhbmcgPG1hc28uaHVh
bmdAbWVkaWF0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgc291bmQvc29jL21lZGlhdGVrL210Nzk4Ni9t
dDc5ODYtd204OTYwLmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsv
bXQ3OTg2L210Nzk4Ni13bTg5NjAuYw0KPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3
OTg2LXdtODk2MC5jDQo+IGluZGV4IGMxMzkwYjM3MzQxMDEuLjI0YTRiOTQzMDMwZDcgMTAwNjQ0
DQo+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LXdtODk2MC5jDQo+ICsr
KyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5ODYvbXQ3OTg2LXdtODk2MC5jDQo+IEBAIC0xNDQs
NyArMTQ0LDkgQEAgc3RhdGljIGludCBtdDc5ODZfd204OTYwX21hY2hpbmVfcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgcmV0ID0gZGV2bV9zbmRfc29jX3Jl
Z2lzdGVyX2NhcmQoJnBkZXYtPmRldiwgY2FyZCk7DQo+ICBpZiAocmV0KSB7DQo+IC1kZXZfZXJy
KCZwZGV2LT5kZXYsICIlcyBzbmRfc29jX3JlZ2lzdGVyX2NhcmQgZmFpbDogJWRcbiIsIF9fZnVu
Y19fLA0KPiByZXQpOw0KPiAraWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiArZGV2X2Vycigm
cGRldi0+ZGV2LCAiJXMgc25kX3NvY19yZWdpc3Rlcl9jYXJkIGZhaWw6ICVkXG4iLCBfX2Z1bmNf
XywNCj4gcmV0KTsNCj4gKw0KPiAgZ290byBlcnJfb2Zfbm9kZV9wdXQ7DQo+ICB9DQo+ICANCj4g
LS0gDQo+IDIuNDMuMA0KPiANCg==
