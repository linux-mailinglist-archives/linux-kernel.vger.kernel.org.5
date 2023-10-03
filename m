Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6B7B5EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjJCCPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJCCPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:15:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4FAD;
        Mon,  2 Oct 2023 19:15:00 -0700 (PDT)
X-UUID: a49a09c4619211eea33bb35ae8d461a2-20231003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dggoPWsQUXViepSzelPLnAaYNPSMK/P9bNgXpF1z7+U=;
        b=fPCX/X88xLTrWKdP8w6DJ8pMjUPlIF2FuRrS21u5LzDmRUG9t0h50CVKQDuws0vE7W+5NJFOa3UtIMglBKLR3UfAd+fx1/2AWat9C7mhTm40JWQZkl0EaQI6FfNtuoj4RwzFTwqVK3fL+Vyi43rymhe/Ci+FMAfEhPvAhePlcfs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:aba05ccc-1567-4dad-a34c-cc6a7acc58ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:54a95ff0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a49a09c4619211eea33bb35ae8d461a2-20231003
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 445687492; Tue, 03 Oct 2023 10:14:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 3 Oct 2023 10:14:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 3 Oct 2023 10:14:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs8iG1jttFImEAoLwXW10/z0DBjq+tPuv009W1QHZSfOqWeMt4UEzt/7g06NuOJPWBRAIq7BiFfMLGjofdeey5/5vyzep5yeZ2S5WJmxah4N38ayA7/SiknbhvaR+ub6cqqlGq4zsMQLXf0RHx57ddrSFm32kkr5BocNQDIQ4AkRuXObN/VbJV6J8YIUMv6xJD7io7bqrPRZopS1BydGKq2rcWLxCsgwXE4bz5+2eNZTJcXIf6LR40Lw2L6EipQz0vERzm6BqxsrbewWO0X/88gqGYe+QqbzMlN3Bw+zbK4kPFYmj+Y7KOjTVnxCO9wq/uBPA8Vid8q072jfDjrsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dggoPWsQUXViepSzelPLnAaYNPSMK/P9bNgXpF1z7+U=;
 b=iITSasaamtBMTwfpC2iAVk2sP+T+x1pY5GVp+X5CsUsKSCLvAloe2Btj8Ot+1b4uq1i8DjqLnkf2/OxVgKf/6p3oBUmWb0cwtBsPqycaPvQ9XClVcPZAlRvNbYf2QzZQtLN6fBoDxiZyL/gUpuCKzj22Z0ZjKb4VgjxlhY4+0SalmG9SHQ9EcQW0Bhd4IWvQ7qxEButwv+pmEPEZhlxlXF8VkgjWFkMvm39H/DVDAHEYqwlQYKdLrDoxEXq/4EqXKUEMXlSbK9Qb2pBjhaKLr4/fxmdv+1Kr3uuRfvSHywPPlMd642Vzf4RbD596iXqmlqooTrtZdZC/qdxMbOgcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dggoPWsQUXViepSzelPLnAaYNPSMK/P9bNgXpF1z7+U=;
 b=Bq6h1GHGvX+Oo5JkO1KdXJRg9izyPV1vrsp+7SadQqDaIxaZhANMNGqa+eJ12b1BvET6x3TW52er9qAJO0t+k3GEzO6NgLRrcOibkQDeMptWHqlzlKiz6H7dRpPHVA4oatXO6GfDqyV6/LY2cpX+HS5uSO73UvSoB1wXuD5Tayk=
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com (2603:1096:4:17a::6) by
 TYZPR03MB5375.apcprd03.prod.outlook.com (2603:1096:400:3b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 3 Oct 2023 02:14:50 +0000
Received: from SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::10c2:a420:e409:a1b8]) by SG2PR03MB6343.apcprd03.prod.outlook.com
 ([fe80::10c2:a420:e409:a1b8%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 02:14:50 +0000
From:   =?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?utf-8?B?UGluZy1Ic3VuIFd1ICjlkLPnp4nli7Mp?= 
        <Ping-hsun.Wu@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        =?utf-8?B?RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKQ==?= 
        <Daoyuan.Huang@mediatek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v6 13/13] media: platform: mtk-mdp3: fix uninitialized
 variable in mdp_path_config()
Thread-Topic: [PATCH v6 13/13] media: platform: mtk-mdp3: fix uninitialized
 variable in mdp_path_config()
Thread-Index: AQHZ7ShQRr84A8dr+UuD9PeWscXiDLA2ZBYAgAEAXQA=
Date:   Tue, 3 Oct 2023 02:14:49 +0000
Message-ID: <578640e2f3a51decb61bf769dcd4d28d179cdd88.camel@mediatek.com>
References: <20230922074145.11977-1-moudy.ho@mediatek.com>
         <20230922074145.11977-14-moudy.ho@mediatek.com>
         <4e9452b9-a02c-47eb-ba8f-5949f07f707d@xs4all.nl>
In-Reply-To: <4e9452b9-a02c-47eb-ba8f-5949f07f707d@xs4all.nl>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6343:EE_|TYZPR03MB5375:EE_
x-ms-office365-filtering-correlation-id: 273c8a8d-3ca6-4ffc-2dad-08dbc3b68598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCzWzudSfNXz/2cQCG9gWByR1B/sZjQZsD/gm3WUjws3F5RBSscOXHyXECYtATSIyn/Ox3k2XGzpn5eYgeFMP5wck3dC1gx/UBIo/khcPeHTXDj8lryon951sw/oC2pshLWLT+ueYGM5J2t17e2Ht3svsklPmIUiYxhVCqLR0ZTKGy3OMt3D/NRekhrDMCvbxpT5Y7roZr2YZZU3oj3zV5hvodap7o/N5yCORI5MZNw8ag66RwYThsy4qZ45NtEv4ivcnxCt0qLQ/CUJvvYKSd6g1hqsYfI66gXm2iJbQQrYouOkf+OLIcbgPzK9pm4MRk0+u5YcFrROAfUT2Zhcoj9DlN8O3ClG+tX5/autXv2JKkSeihbzNvksTl3DxTSY/i9KagH8iX2bIpiPseiM0vSQLIQWTrjuBcxYtFRaIwNM8SKQ+gVFP1ESxnKSKno/4o88d72EZxXox3c+NyckR5NaOT2QY7c1OA1nAnGdSZve1AJqioHysnptCuxUSUAxqhCcnpVEgbMTp09PgX7knSxW5LKk5EFYLsAiUkFaUJOe5KQaMEqqL1pJ/K9sOQGmuGltVbGdwi4V0Kjj2RLpdHv3MJMH3ALsTlYMcOPewsP+nrXBiwS8/B6ySeMS0PoaiMq5MyRJNJIsVzBzBOndEAr402JJNia6uYF16WD49z3L4emfRhp4TFX4DLGL+015
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6343.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(122000001)(85182001)(36756003)(38070700005)(86362001)(66946007)(53546011)(6506007)(2616005)(2906002)(5660300002)(66476007)(110136005)(76116006)(316002)(6486002)(6512007)(41300700001)(478600001)(64756008)(54906003)(71200400001)(66446008)(66556008)(91956017)(8936002)(6636002)(26005)(83380400001)(8676002)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFJZ28xUDIrWXcva0ZmV0RBOXFITW5yTHkzK2UwTE9oRG0rSG8rakhtYUVk?=
 =?utf-8?B?RVNObXl2a0E0WWN2M21jTmFRTzZpWDNyN3hJbDdvMldpbUcrbUFtZklocUVX?=
 =?utf-8?B?MzB4N1NsMzZSRFZRdnorNzdUTFRidkhVeXFYeFNha1EwS0NhS1draHprNVR4?=
 =?utf-8?B?cm1scWtGbXBjZE1uNWgrRjdSWnE4aXZVNjN1Y1lQeUNTVWxESEJkdkRQNDBI?=
 =?utf-8?B?OUk2ck81aU1Sbi95cWY1UEFTZktyR08wT2pPeDkzcTFjbU5BbWpHY0I4Tjg5?=
 =?utf-8?B?TXU3Y0JOQkQrQURvT0ViK0NjQmdvRFlscTZIMUpvNzduZlVLcngxRlNNRDYv?=
 =?utf-8?B?S2c4ZlBtK2xsditoNkJQWll4UU9jc05KWG5yajFhcXU0bXVOMTVJZ3ZvT0lw?=
 =?utf-8?B?L0tER3ZvOFM4S3Z2NGdLTW1aZzgrMW9RcGRReXVOOTMxMURTbTNkbE04ODg5?=
 =?utf-8?B?c1Jhd3I3aDZOdm9WUHRzOXowekhQY1VjQTlrVnpldVZrZlp6aS9iKzl1YS9V?=
 =?utf-8?B?Sk5FREpzeURVU2wrdlJURWd1TzUrd0c5V2F1VG1FV21UMFRjYVF4RGh4Zk9S?=
 =?utf-8?B?eGprZHhFWlErZGRPVCtROFM1Z0U4UWJkMDhuYWFaK0JXY3hMeTdPRDVQQzQ1?=
 =?utf-8?B?NlZvZkVnVzFYZy80Ynowd2VZbnNMT2NrdkVjc0ZSMDBQSk92UUtQZHJVRHNJ?=
 =?utf-8?B?NjVTOUZuQ2FLb1h3RWt5cHJFcjNvY1UycTA3cGZ0c1JZR00xUlI0UzZjYlow?=
 =?utf-8?B?eHdZa3MxRzNVZnMreDVHL0RJcmErMldWWW50WVNwMXZPbVNiYVlXVXVlR21L?=
 =?utf-8?B?NU5IclNjM0RRbDRIM1dxdDVWZUNZQk1HU2s3b2xzRmFGaGgwTnpKcG9lbkZp?=
 =?utf-8?B?SnJia2s5c2FCdld1U05xU3p1U0w2VVdwVWV0Z1B1UCtwMXJ5dEExL3VwM04w?=
 =?utf-8?B?RXU4TnMyaGhzVXdUTkJYa1kyNHNPdE5HWDg3Uy9Oa2Y4eFpNTlNwRzRpUlBT?=
 =?utf-8?B?VENRa01yNWtQUHQzY2QybDlXZTc2YTJWdU9jQkRNRHZtdjVGbjEwNXhZK0hG?=
 =?utf-8?B?NWZMVnBZTTdUOFhJUFdrY0p5d2cwMWVWaUdTM3puVGJNSFNNeENmT3Y3Q2FF?=
 =?utf-8?B?UGR5U0ZLbjZqT3kreCtrZU1sYm5NTncxUitRWjhOajVQZktDRjBkU2UyU2pt?=
 =?utf-8?B?elpyRGowUTZnR1JUdTFPNkZVNEpCVEdlMTlHSmdkZ0t5TGlJOXZQZlhQZE96?=
 =?utf-8?B?ajRLTTVxSVlSWExXc0Rra25Rei85eUlERzVoSTVLa0gwUFl1UzZkVUlKc1VE?=
 =?utf-8?B?bVRhMm5YVWExRjBSdWRPVytQcXNFeEhYeDlWOFhVdEQ5YVJIYnZFaFYzMFFn?=
 =?utf-8?B?MS9CV21ybHhHb0FPVlRSelhiMnVkUkJuMm9LdGxFVnpaZ01pNzVqOTdNZDZm?=
 =?utf-8?B?ekQxa1lWR0EzZ1FUaVI3V1ZmeXNycFhHclpJUDBqZm9ndkRjVEJzV29BUHEr?=
 =?utf-8?B?T0NqTDZ0d2F6WTRiNjVHdko3cUpZdEVmRXRyU0tMb3FPRWJXTXFYNGYxLzVS?=
 =?utf-8?B?LzVPaW1CK3dtWjMyeExna0RqWE5DR1lqZ204ZDJHbEFhbS9xQmt3RjhFdU4x?=
 =?utf-8?B?V0x3M2E3bFBEMFRaTFE0aUpqM1ZndVFkSUdvaGU4ZlplSU1oTi80S0N1UFl6?=
 =?utf-8?B?eXNPR2VuZnRuTVRiTitFbXFoazdhMlRFYTZ3V3BDdnB1SmdZZDNSd0dOTFJj?=
 =?utf-8?B?QytHUGtkU1JoK0pzeTlMZ25PUkdtOVBMSFlmZXBFNm45NkFKTEQ5MzJZV091?=
 =?utf-8?B?T3F6ZXhCNmkzVTFKM3pnMzdOZkRkbUcybjZqOUd0b1RJQ01rOVh6M3owWGw1?=
 =?utf-8?B?Q0R1M3Z1aDg2Z0crNC9PNVN3Z05PN3NxWDkvNkREa1BDTkxKOGN4d2kyaGsr?=
 =?utf-8?B?SmxnNkRVWS8zOEpBMWYyM050c0RzR2xPR0hFSWhjeEtBWkQzR2R2RmprUThM?=
 =?utf-8?B?a3U5L0p6SXJGdW0zSHNxTC9ORXF4V3VuNjVIQkJqMmdWU2xLc3FjekJaMUFQ?=
 =?utf-8?B?d09GbnROVUlIblRjNUh1TnA2U3FnYzRrd2ZqSGpXeWwrZnhKRkJZQjludnU4?=
 =?utf-8?B?Q2xmTHYyT0RhbzNtSTZ2cnFjUER4Qlpud3dPRWt0c09JbVh2WTVlTVozVXlG?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82A079072CE403458FF10D8428B24921@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6343.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273c8a8d-3ca6-4ffc-2dad-08dbc3b68598
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 02:14:49.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkI5ex+pPQ3VIGimB79C2CgMvArMj7uhM5/cDx6/tXAHygjZ2fEfut9I4pfXYNScu3gIwULeHQ1kYIQo/9cOow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5375
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.828300-8.000000
X-TMASE-MatchedRID: GagEC7nsA0TUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP2+1Vx7rDn4r0+u3rM3lFPn7Md
        QiE5zh1ihUUmCDdTE1jUTt4WzvcX2t2NNBR6dUMPJ5W6OZe5hhaRagyMV8rdeVz8J52OVy+RP92
        ZF3mNTgIy+MmYQKgU52wh79NdRsvWQqMvYg6LYsEhwlOfYeSqxQPCWRE0Lo8L82ks92f+Gmp0s0
        IbugqoqO08cfoExxdSxRyZxDWzXY8lBBl8WJYU/phvn2pPa92pzd7C7BtJobom19K09MS2NOQAM
        1Ou/HYLi8zVgXoAltj2Xsf5MVCB1jaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.828300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 2D94AD274D6EA4523730F5CCEBDB6CB14CA08323E1F688DA5A7A408EA3347DAB2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDEyOjU3ICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gMjIvMDkvMjAyMyAwOTo0MSwgTW91ZHkgSG8gd3JvdGU6DQo+ID4g
Rml4IHRoZSBidWlsZCB3YXJuaW5ncyB0aGF0IHdlcmUgZGV0ZWN0ZWQgYnkgdGhlIGxpbnV4LW1l
ZGlhDQo+ID4gYnVpbGQgc2NyaXB0cyB0b29sOg0KPiA+IA0KPiA+IGRyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jbWRxLmM6DQo+ID4gSW4gZnVuY3Rpb24gJ21k
cF9wYXRoX2NvbmZpZy5pc3JhJzoNCj4gPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXRrLW1kcDMtY21kcS5jOjQ0Mzo1MToNCj4gPiB3YXJuaW5nOiAnY3R4JyBtYXkgYmUg
dXNlZCB1bmluaXRpYWxpemVkIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ID4gICA0NDMgfCAg
ICAgICAgICAgICAgICAgICAgb3V0ID0gQ0ZHX0NPTVAoTVQ4MTk1LCBjdHgtPnBhcmFtLA0KPiBv
dXRwdXRzWzBdKTsNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIH5+fl5+fn5+fn4NCj4gPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXRrLWltZy1pcGkuaDoxMzc6MjU6IG5vdGU6DQo+ID4gaW4gZGVmaW5pdGlvbiBvZiBt
YWNybyAnQ0ZHX0NPTVAnDQo+ID4gICAxMzcgfCAgICAgICAgIChJU19FUlJfT1JfTlVMTChjb21w
KSA/IDAgOiBfQ0ZHX0NPTVAocGxhdCwgY29tcCwNCj4gbWVtKSkNCj4gPiAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn4NCj4gPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL21kcDMvbXRrLW1kcDMtY21kcS5jOjM5NjozMDoNCj4gPiBub3RlOiAnY3R4JyB3YXMgZGVj
bGFyZWQgaGVyZQ0KPiA+ICAgMzk2IHwgICAgICAgICBzdHJ1Y3QgbWRwX2NvbXBfY3R4ICpjdHg7
DQo+ID4gICAgICAgfA0KPiA+IA0KPiA+IEZpeGVzOiA2MTg5MGNjYWVmYWYgKCJtZWRpYTogcGxh
dGZvcm06IG10ay1tZHAzOiBhZGQgTWVkaWFUZWsgTURQMw0KPiBkcml2ZXIiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1vdWR5IEhvIDxtb3VkeS5ob0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9tdGstbWRwMy1jbWRxLmMgfCAy
ICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL21k
cDMvbXRrLW1kcDMtY21kcS5jDQo+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay9t
ZHAzL210ay1tZHAzLWNtZHEuYw0KPiA+IGluZGV4IDE1YTBiOTQ0NzQ1ZS4uNGE4ZDk0MTE3OGFh
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvbWRwMy9t
dGstbWRwMy1jbWRxLmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L21kcDMvbXRrLW1kcDMtY21kcS5jDQo+ID4gQEAgLTQzNiwxMyArNDM2LDEzIEBAIHN0YXRpYyBp
bnQgbWRwX3BhdGhfY29uZmlnKHN0cnVjdCBtZHBfZGV2DQo+ICptZHAsIHN0cnVjdCBtZHBfY21k
cV9jbWQgKmNtZCwNCj4gPiAgaWYgKG1kcF9jZmdfY29tcF9pc19kdW1teShwYXRoLT5tZHBfZGV2
LCBpbm5lcl9pZCkpDQo+ID4gIGNvbnRpbnVlOw0KPiA+ICANCj4gPiArY3R4ID0gJnBhdGgtPmNv
bXBzW2luZGV4XTsNCj4gPiAgaWYgKENGR19DSEVDSyhNVDgxODMsIHBfaWQpKQ0KPiA+ICBvdXQg
PSBDRkdfQ09NUChNVDgxODMsIGN0eC0+cGFyYW0sIG91dHB1dHNbMF0pOw0KPiA+ICBlbHNlIGlm
IChDRkdfQ0hFQ0soTVQ4MTk1LCBwX2lkKSkNCj4gPiAgb3V0ID0gQ0ZHX0NPTVAoTVQ4MTk1LCBj
dHgtPnBhcmFtLCBvdXRwdXRzWzBdKTsNCj4gPiAgDQo+ID4gIGNvbXBvc2UgPSBwYXRoLT5jb21w
b3Nlc1tvdXRdOw0KPiA+IC1jdHggPSAmcGF0aC0+Y29tcHNbaW5kZXhdOw0KPiA+ICByZXQgPSBj
YWxsX29wKGN0eCwgY29uZmlnX2ZyYW1lLCBjbWQsIGNvbXBvc2UpOw0KPiA+ICBpZiAocmV0KQ0K
PiA+ICByZXR1cm4gcmV0Ow0KPiANCj4gSG1tLCB0aGlzIHBhdGNoIHJlYWxseSBzaG91bGQgYmUg
YSBzZXBhcmF0ZSBwYXRjaCBvbiB0b3Agb2YgdGhlIG1lZGlhDQo+IHN0YWdpbmcgYnJhbmNoOiBp
dCBpcyB3cm9uZyB0aGVyZSBhcyB3ZWxsLCBleGNlcHQgeW91IGRvbid0IGdldCBhDQo+IGJ1aWxk
DQo+IHdhcm5pbmcuIE90aGVyIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBzZXJpZXMgY2F1c2VkIHRo
aXMgd2FybmluZyB0bw0KPiBhcHBlYXIsDQo+IGJ1dCB0aGUgYWN0dWFsIGJ1ZyBpcyBhbHJlYWR5
IHByZXNlbnQgaW4gdGhlIGN1cnJlbnQgc3RhZ2luZyBjb2RlLg0KPiANCj4gUmVnYXJkcywNCj4g
DQo+IEhhbnMNCg0KSGkgSGFucywNCg0KVGhhbmtzIGZvciByZW1pbmRpbmcgbWUuIEkgd2lsbCBz
ZXBhcmF0ZSB0aGlzIHBhdGMgdG8gYWRkcmVzcyB0aGUNCmV4aXN0aW5nIGNvbXBpbGF0aW9uIHdh
cm5pbmdzLg0KDQpTaW5jZXJlbHksDQpNb3VkeQ0K
