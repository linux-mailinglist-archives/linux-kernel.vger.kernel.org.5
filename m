Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D057EE104
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKPNDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjKPNDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:03:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D63AD;
        Thu, 16 Nov 2023 05:03:23 -0800 (PST)
X-UUID: 7fbfa1d4848011ee8051498923ad61e6-20231116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8XcCw7B4RQHjAb1HRPTzrEUMWtXY75bod7dq5UYLD2o=;
        b=UupcILS6UymSpgGw/lG+ATMdVM3Pxo/rcqX5CiXK3TjJxrNpHOoqv1osOnUc9Y7YqIqAF5ajwsfxi6mpYd4TrdR7JnW6IQvvSv9bXHFwB9LYxXCbP4YC7nyhdsPz+ywO+YlbrS8Kkp3viui0oIMncYUTRoV3aB8aNYQeqJQiIkQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ace46473-cdcb-4048-ab19-6c799af556eb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:2ceeba72-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7fbfa1d4848011ee8051498923ad61e6-20231116
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 988318511; Thu, 16 Nov 2023 21:03:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 16 Nov 2023 21:03:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 16 Nov 2023 21:03:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl84nK6gz2+0QPsLcvIOGaUGWF+/TZuvRjFwkSQVQHxQ7hXbTrYMAUojWdq6xTSMVCDKiZfXYIf5uXaAuIK9a0afMWurYKAzRxg+7RrNW0i/2ES4D2ARzLoIulxoBl9EgiBMGeQkD1yHb6380mv0eGC5k9i3y+f/OfAL2GqBSMprmEJvBvYp1lnIohrgbJ9bYxZas8168DJ06cnuZKcG6NX0qaIsuYEdSBWSOaehkZphR5EKMIDyQVHaqok/ny7Aztg2hjUk2BTpWKSeQsoJ/nJhujQlyWDzRdJHguvPPMxD2xZ05XLgep89LZUbK4wUCthi9I43l+Uv/QOQutbmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XcCw7B4RQHjAb1HRPTzrEUMWtXY75bod7dq5UYLD2o=;
 b=lWBOuwszklw9hHETyvQMagc5IpbpIw8iVghQMg6MXd7BfLncy1SWQiapDS3uctCBb0KDRlF8D/1GbNdCRulenv3fdWIRIbMmQv0p1+3nyXV0NLzcnUKBX79GFCbofUAC+tmNXaqfRuaChqceA9MnG5pqL9TjIxGyu7IwhPgwb1Dufuz+A8Emw/+y2MefjYm+rWKdKd9La3vkuRmxBmaptcnj++lH6KR81VdWlaItosNE/v9p/sTq9jDWoMwpSH/jcRCvEoNtbq9IR4XWZIIHxLsTmPs5XNdqolZ3LuyL6fhBjIFSgePCfI3SzCDs3vCMRsOFnSCIBPk1767OCZKhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XcCw7B4RQHjAb1HRPTzrEUMWtXY75bod7dq5UYLD2o=;
 b=oU3PVcrlTNZbUia41w+7IHPG5BZPESt2N+S6mJpAW1/YQO2PFEpc4ks5oFQdDkowjwaT8n5yeLVg2b2oDdbeoNKH9SDhd4WR3VATUC6HnIObpZ+zQLYQ6O5oJvfYm1Ll/IzAjx7MBpIqMwHZQa67K6a374Y3Eqsd2sgunuaXZ+o=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by PUZPR03MB7253.apcprd03.prod.outlook.com (2603:1096:301:103::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 13:03:09 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::3439:9de9:ec9d:4e68]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::3439:9de9:ec9d:4e68%4]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 13:03:09 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>,
        =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?= <Qilin.Tan@mediatek.com>
Subject: Re: [PATCH] mmc: add wp_grp_size node
Thread-Topic: [PATCH] mmc: add wp_grp_size node
Thread-Index: AQHaDi+wQidU4h3SvUKcCc1y+C9ZzbB8/hyA
Date:   Thu, 16 Nov 2023 13:03:08 +0000
Message-ID: <d741713fe41f3995ac247a9958c9f7ac9508f685.camel@mediatek.com>
References: <20231101154927.119312-1-bo.ye@mediatek.com>
         <63fecefb-61bf-4232-ab91-db04e3212f14@collabora.com>
In-Reply-To: <63fecefb-61bf-4232-ab91-db04e3212f14@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|PUZPR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 1b196385-ba9a-4092-28f2-08dbe6a461a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fB6SjZ52H7+lrQxvtfhUOefdehjAG7fI2l1BACGKoCxEC20gd1+bQAmV/T+urC3n/v0QV08UZZDaC21wpj9VQP3qkjx7jSqYCElTUbOBxc96iMECGkfEbZZedgn0TqjcKf60i5cyxHzY2lb2rWbsdBz0CcFPp4yaAD4RCkJQGWejLaEiOYIlftUkmdZxAq/0r2StVIxm4tsyI1xZAMWuuLK9iCKcFhYP/HSmoJ8PVPPDlv3j/8dRXNc8nTF+2HZ2x/2ESH9aLXQOWeBpmBUL0+aRYl1N7mYRbU9zRau5hWsK/QP9QXkYChCmcTe1r2Go8NDHF/kR6egU+f2O6+A5XlDJKy89eNn5d1uyKeU/wPlVnWdoKKoQAvi/CKrt/EZyx1Z5CYJ7IWRIy5Lxw5EWxFJ6bTeLboMkofXbiaVB0y8e6P9MEmO5VRN5Gt/jH8apyDLvMJwiGhFID3eeTgaDc547yACPXORDgdCW31Yd8nmPAJ8F2TuRleT1eGoYGpUugGjxLgO6hoz6aEnSl/JN6a1U2Oi40SpSB+jininJk1pBwVY69pgXCx0pEq4X7FxmxQTfIHmfLgb4ujAUeUb7rj2YWk+mwsOzeyXxXS3IcreLTJGR6fRUtjGUg1JynlSU7QVWjXIX8D1pz5sk7q50huC7aVOFnMOln921iOGzd6c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(85182001)(36756003)(8936002)(6506007)(6512007)(316002)(66446008)(8676002)(83380400001)(4326008)(54906003)(110136005)(71200400001)(2616005)(6486002)(478600001)(26005)(107886003)(91956017)(76116006)(66946007)(66556008)(64756008)(66476007)(86362001)(122000001)(38100700002)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eElDWmpIUGRmblNFWlV4d2l5NGZzdjNmK2tZV2pmRDJGWXNMbUhUa1ZVVzJi?=
 =?utf-8?B?bG1pSW1PZS9LVGRIKy9PVzNGc2lWQXQwN21VVDg3cE93aWl3cmt4S09ZbjR2?=
 =?utf-8?B?NkhaWXN5bnk5dVZqb0dUcEtIY3cxTzhZbDRvRlRjeEx0aW5TRGp1MVNGMXA2?=
 =?utf-8?B?bTE1ZmhSUncydzN2cGRMQW9HUkdLVlNKaEIxTTdVYjNwQVh2TXp2R085SVRY?=
 =?utf-8?B?cEh3bXFHYWxuL2dHYjBJYWh4N25oL1VuR1ViRml4YlIxaVhZaEFRd3BweU9a?=
 =?utf-8?B?bm0yUGc1ZkpTSlovcWxLV1QzTnluVmJSN3BHUHlVUW50ZloyclE1c2lJcGty?=
 =?utf-8?B?WkdmazZIVW5scUNFTXAzN3gvWkxQMWI3VGZZSkN5UlNVeW1YMC9JMUdaaEl4?=
 =?utf-8?B?MUZ5N1NiaVZ3TmRNblhmSFcreXZsRm5sUWw2c3pMcUxlLzZubUNFakFUdjFC?=
 =?utf-8?B?QnJjdWZDalVhaU4rc282ZmxGZ01tU1RZaTZDaXZOb1pITHhwMVpDek1BZkR3?=
 =?utf-8?B?MGJDMnhpYTRGV1hXbzQrU3JoZXJxS1dZL09CR0hsY2F4Skp5OEkzZDBnc3hJ?=
 =?utf-8?B?cGZqMWJhc1JmR2R0OTBxZGJJNm4xZjZwUm4vMmh3TjZOZjR0Q3JSU1JHcU1Z?=
 =?utf-8?B?V1BoeW9kNE9aS3R6cisyUzd0aE4xTkJkR1RWaVJBYWFTSDd1M0lIRlBIQ1I1?=
 =?utf-8?B?L0QzbVNWYkZaTXJvM1gxM01nVVVmZ3A4SC9lb0NuMjl6Q1NYUGJBMFVuRlpz?=
 =?utf-8?B?dW11NFMrR2xXRjdCc1FpazE5bGlpMm9DZm9FNmV5Rkw0K1MwVHQ3TjJWS0R5?=
 =?utf-8?B?REpjemF6SWVLTFJGRjZkbFhGR0pjdy95WlllSEVLMEJEVCtUWjJTOE82bW94?=
 =?utf-8?B?U2JpaU93MEdDb1YzODdqL01iU2hiMVgwUmdPc1FKYXdhdU5hVWlTTW9tTGJm?=
 =?utf-8?B?T1QrMnFCUmlJbStoZXkwakJKSzFVRkduR2ZGKy85OU1DQ0pzRGk3d2VhUERh?=
 =?utf-8?B?Y1FWUjBVOWZ5SzNUQXBVd3JxT2pRWnR0TWtBSitldjNPRGRESTJpK29WRnl5?=
 =?utf-8?B?UGt5amxhZ0pRM3dTd3BONG5mQ2NEZmcxQlRKRGZwem56blFWVjlpQk1FUDZq?=
 =?utf-8?B?bFBaL01sMXhyeDExL2tGMW42TEZxNFQrRDQvU0JTYVhYRmE2VnNiZEtENWQ3?=
 =?utf-8?B?aFFWNkphcDFCb3ZodzNmaFlnanl2enhRdjM0RlRsdDNmbDlUaFJ0cVlyT1hC?=
 =?utf-8?B?U2JjMTVLU1ZPK3hVWE1Zd1IxM0FDWXpjOU52ZWVPQ2E2TzZrTE1PV3RQNWRW?=
 =?utf-8?B?dFcvTnd4Z1ZzZW1vZTNzTzdNTUthTkhHTFdEZnRDVzhEWm1TQW9hOVgrcEl2?=
 =?utf-8?B?M2gvWkltNExORlRKcnpzcGxBMmErbCtadEtCWDRXRUo4VmJ0QWxUY2hQaTNF?=
 =?utf-8?B?VkNBSDRoeS9GYjVWWEx6RXd4NEpScXdCdUtIRSttdXA1WGxTWjJWRnFYczZG?=
 =?utf-8?B?RHRMS09XRFlNQmFWMHovbVBNa3djMVgxa2xyS1JFUUozcVZRZm4vY0lIM01k?=
 =?utf-8?B?WXp3VHU5Wnh6VFU3L2NhQi8ybXordzRyaWM2NDVFUWVWZWFHRGF0N2VXQ1lG?=
 =?utf-8?B?aTJrQ0pQMmpCVzc3a2tqN0tYbGJDZjBxNm00YnJ6VCtmbFJ4K1JYbjlyL0ZE?=
 =?utf-8?B?eFc5T3kycVE2MU9uYTA5NFR2ZW5tYmVxcitHZFRackZRZmhCWkM5WWFDTUE3?=
 =?utf-8?B?VGlnemNtY3lzSk80dytMampuTU9TUDNkanlPY3pJdUQ2MHQ2SVRpVGFDSUlP?=
 =?utf-8?B?bE9XUS8rVzdDZ0ZCSEdHSUJoNlRBSHpyb2hmbElMYXlaYk1wNjJPU0JJN2Vj?=
 =?utf-8?B?cm4zRmlXSG9tV3dybHRCTVc2aEx5QXYyREt6VzdVbVdxYWdFQmxKM1hWQXgz?=
 =?utf-8?B?amtCUHUxVXhweThVbEh3K2hpLzVoMjg0QXhsa0xjTS9zd0pTWTViRVhiZitJ?=
 =?utf-8?B?WkpENTNyQldOa2NMSFp2TXRURUlwMlFwRXp1SHZTa0pqclRKTGl4ekJ0YlJr?=
 =?utf-8?B?V25Qd2FHZjJvNU0zM1Y4d1VkUnJvU2JpL0NEMlVMTENSZ2xJaExhOVpEemZ0?=
 =?utf-8?Q?JAlmPYPuyaKDA6+8PqIxDNOMI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3035AA20CF0CBC4D84A2DEA78C80991C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b196385-ba9a-4092-28f2-08dbe6a461a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 13:03:08.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nau5lP5M+wm7IeIixvf9wpa/qre+9vPAahKdUfQcHPIwgj+HBOiBdXR9/YjV9U5jnLngAEj4x84l7C/0G5j1pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7253
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.184600-8.000000
X-TMASE-MatchedRID: rYpa/RC+czENtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDzndfeJ
        lqUEMxA/bZ0UBL4L5a/u74Xv4GSF5o39U4x946BX4T0EFRcNxxQjkrgJ37Rqj0dmDSBYfnJRM+f
        jINbnJ/exHSqlNpo6+I5KSdqj1OliRFuZfuhIqrV+7IhLVmN+uyaXATIpQghoowtRP8whCK+bZC
        Q5AwsoRtrz71sogk/my3HscmUQ3XxCBQieSpAGz5mug812qIbzuOpqP7b2k9yN+IZcOLD8xNnoq
        uRwHY3BcmQ2Pu47BxrIBtVTcxQLG+qi5ZHdbnMGH5YQyOg71ZZCX8V1FiRRkt9RlPzeVuQQS0ei
        OsrXcTjWSkIp1XXQU9w9oY9Ibw2m39LwM21FJtumput5KKcJ0+e5JB2PHL7Euim6G3L+ZbhaapA
        zRzPL/pxaj00r7AfJc0O9f5VVZtbyTBeqcpWTVtbVO5cqfV4RKD1FAxZRItXW9R0dU1eYdIKVs8
        PI8OvcFD+pPLLM05PyMqp73qgJxGJ1mLiX15SGiguiJuCNURd9LQinZ4QefKU8D0b0qFy9mTDwp
        0zM3zoqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.184600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 66167609ABF3AADCC87FDBE2062DB9C699950B14B6FF45A33D78C4763DD2632C2000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTExLTAzIGF0IDA5OjI3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDEvMTEvMjMgMTY6NDksIEJvIFllIGhhIHNjcml0dG86DQo+ID4g
RnJvbTogImxpbi5ndWkiIDxsaW4uZ3VpQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBEZXRhaWw6
DQo+ID4gQWRkIG5vZGUgIndwX2dycF9zaXplIiwgY29ycmVzcG9uZGluZyB0byBXUF9HUlBfU0la
RQ0KPiA+ICh3cml0ZSBwcm90ZWN0IGdyb3VwIHNpemUpIG9mIGVNTUMncyBDU0QgcmVnaXN0ZXIu
DQo+ID4gDQo+ID4gU2NlbmFyaW86DQo+ID4gVGhlIGVNTUMgY2FyZCBjYW4gYmUgc2V0IGludG8g
d3JpdGUtcHJvdGVjdGVkIG1vZGUgdG8NCj4gPiBwcmV2ZW50IGRhdGEgZnJvbSBiZWluZyBhY2Np
ZGVudGFsbHkgbW9kaWZpZWQgb3IgZGVsZXRlZC4NCj4gPiBXcF9ncnBfc2l6ZSAoV3JpdGUgUHJv
dGVjdCBHcm91cCBTaXplKSByZWZlcnMgdG8gYW4NCj4gPiBhdHRyaWJ1dGUgb2YgdGhlIGVNTUMg
Y2FyZCwgdXNlZCB0byBtYW5hZ2Ugd3JpdGUgcHJvdGVjdGlvbiwNCj4gPiBhbmQgaXMgdGhlIENT
RCByZWdpc3RlciAgWzM2OjMyXSBvZiB0aGUgZU1NQyBkZXZpY2UuDQo+ID4gV3BfZ3JwX3NpemUg
KFdyaXRlIFByb3RlY3QgR3JvdXAgU2l6ZSkgaW5kaWNhdGVzIGhvdyBtYW55DQo+ID4gZU1NQyBi
bG9ja3MgYXJlIGNvbnRhaW5lZCBpbiBlYWNoIHdyaXRlIHByb3RlY3Rpb24gZ3JvdXAgb24gdGhl
DQo+ID4gZU1NQyBjYXJkLg0KPiA+IA0KPiA+IEZpbmFsIHJlbmRlcmVkIGZpbGU6DQo+ID4gIi9z
eXMvY2xhc3MvbW1jX2hvc3QvbW1jMC9tbWMwOjAwMDEvd3BfZ3JwX3NpemUiDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogbGluLmd1aSA8bGluLmd1aUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGUg
Y2hhbmdlLWlkIHRhZyBtZWFucyBub3RoaW5nIHVwc3RyZWFtLiBQbGVhc2UgcmVtb3ZlLg0KICBS
ZW1vdmVkIGNoYW5nZS1pZCwgdGhhbmtzIGZvciB5b3VyIHBhdGllbmNlLiBJIHdpbGwgcnVuDQpz
Y3JpcHRzL2NoZWNrLXBhdGNoLnBsIGJlZm9yZSB1cGxvYWRpbmcgcGF0Y2ggbmV4dCB0aW1lLg0K
PiANCj4gQWxzbywgdGhlIHJlY2lwaWVudHMgbGlzdCBkb2Vzbid0IGxvb2sgcmlnaHQuIFBsZWFz
ZSB1c2UNCj4gc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbA0KPiB0byBnZXQgdGhlIHJpZ2h0IHJl
Y2lwaWVudHMgbGlzdCwgb3IgeW91ciBwYXRjaCB3aWxsIGJlIGlnbm9yZWQuDQogIENvdWxkIHlv
dSBoZWxwIHNoYXJlIHdobyBpcyB0aGUgbWFpbnRhaW5lcnMgb2YgbW1jLiBUaGUgcmVjaXBpZW50
cw0KbGlzdCB3YXMgZ2VuZXJhdGVkIGJ5IHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwuDQo+IA0K
PiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tbWMvY29yZS9tbWMuYyAgIHwgMTYgKysrKysrKysrKysr
KysrLQ0KPiA+ICAgaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIHwgIDIgKysNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMu
Yw0KPiA+IGluZGV4IDRhNGJhYjlhYTcyNi4uOWI2N2U0OWE5ZTYzIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5j
DQo+ID4gQEAgLTEzNiw2ICsxMzYsMTcgQEAgc3RhdGljIHZvaWQgbW1jX3NldF9lcmFzZV9zaXpl
KHN0cnVjdCBtbWNfY2FyZA0KPiA+ICpjYXJkKQ0KPiA+ICAgCW1tY19pbml0X2VyYXNlKGNhcmQp
Ow0KPiA+ICAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgdm9pZCBtbWNfc2V0X3dwX2dycF9zaXplKHN0
cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiArew0KPiA+ICsJaWYgKGNhcmQtPmV4dF9jc2QuZXJh
c2VfZ3JvdXBfZGVmICYgMSkNCj4gPiArCQljYXJkLT53cF9ncnBfc2l6ZSA9IGNhcmQtPmV4dF9j
c2QuaGNfZXJhc2Vfc2l6ZSAqDQo+ID4gKwkJCWNhcmQtPmV4dF9jc2QucmF3X2hjX2VyYXNlX2dh
cF9zaXplOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWNhcmQtPndwX2dycF9zaXplID0gY2FyZC0+Y3Nk
LmVyYXNlX3NpemUgKg0KPiA+ICsJCQkoY2FyZC0+Y3NkLndwX2dycF9zaXplICsgMSk7DQo+ID4g
K30NCj4gPiArDQo+ID4gICAvKg0KPiA+ICAgICogR2l2ZW4gYSAxMjgtYml0IHJlc3BvbnNlLCBk
ZWNvZGUgdG8gb3VyIGNhcmQgQ1NEIHN0cnVjdHVyZS4NCj4gPiAgICAqLw0KPiA+IEBAIC0xODYs
NiArMTk3LDcgQEAgc3RhdGljIGludCBtbWNfZGVjb2RlX2NzZChzdHJ1Y3QgbW1jX2NhcmQNCj4g
PiAqY2FyZCkNCj4gPiAgIAkJYiA9IFVOU1RVRkZfQklUUyhyZXNwLCAzNywgNSk7DQo+ID4gICAJ
CWNzZC0+ZXJhc2Vfc2l6ZSA9IChhICsgMSkgKiAoYiArIDEpOw0KPiA+ICAgCQljc2QtPmVyYXNl
X3NpemUgPDw9IGNzZC0+d3JpdGVfYmxrYml0cyAtIDk7DQo+ID4gKwkJY3NkLT53cF9ncnBfc2l6
ZSA9IFVOU1RVRkZfQklUUyhyZXNwLCAzMiwgNSk7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gICAJ
cmV0dXJuIDA7DQo+ID4gQEAgLTc5MSw2ICs4MDMsNyBAQCBNTUNfREVWX0FUVFIoY3NkLCAiJTA4
eCUwOHglMDh4JTA4eFxuIiwgY2FyZC0NCj4gPiA+cmF3X2NzZFswXSwgY2FyZC0+cmF3X2NzZFsx
XSwNCj4gPiAgIE1NQ19ERVZfQVRUUihkYXRlLCAiJTAyZC8lMDRkXG4iLCBjYXJkLT5jaWQubW9u
dGgsIGNhcmQtDQo+ID4gPmNpZC55ZWFyKTsNCj4gPiAgIE1NQ19ERVZfQVRUUihlcmFzZV9zaXpl
LCAiJXVcbiIsIGNhcmQtPmVyYXNlX3NpemUgPDwgOSk7DQo+ID4gICBNTUNfREVWX0FUVFIocHJl
ZmVycmVkX2VyYXNlX3NpemUsICIldVxuIiwgY2FyZC0+cHJlZl9lcmFzZSA8PA0KPiA+IDkpOw0K
PiA+ICtNTUNfREVWX0FUVFIod3BfZ3JwX3NpemUsICIldVxuIiwgY2FyZC0+d3BfZ3JwX3NpemUg
PDwgOSk7DQo+ID4gICBNTUNfREVWX0FUVFIoZmZ1X2NhcGFibGUsICIlZFxuIiwgY2FyZC0+ZXh0
X2NzZC5mZnVfY2FwYWJsZSk7DQo+ID4gICBNTUNfREVWX0FUVFIoaHdyZXYsICIweCV4XG4iLCBj
YXJkLT5jaWQuaHdyZXYpOw0KPiA+ICAgTU1DX0RFVl9BVFRSKG1hbmZpZCwgIjB4JTA2eFxuIiwg
Y2FyZC0+Y2lkLm1hbmZpZCk7DQo+ID4gQEAgLTg1MSw2ICs4NjQsNyBAQCBzdGF0aWMgc3RydWN0
IGF0dHJpYnV0ZSAqbW1jX3N0ZF9hdHRyc1tdID0gew0KPiA+ICAgCSZkZXZfYXR0cl9kYXRlLmF0
dHIsDQo+ID4gICAJJmRldl9hdHRyX2VyYXNlX3NpemUuYXR0ciwNCj4gPiAgIAkmZGV2X2F0dHJf
cHJlZmVycmVkX2VyYXNlX3NpemUuYXR0ciwNCj4gPiArCSZkZXZfYXR0cl93cF9ncnBfc2l6ZS5h
dHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9md3Jldi5hdHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9mZnVf
Y2FwYWJsZS5hdHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9od3Jldi5hdHRyLA0KPiA+IEBAIC0xNzU5
LDcgKzE3NzMsNyBAQCBzdGF0aWMgaW50IG1tY19pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0DQo+
ID4gKmhvc3QsIHUzMiBvY3IsDQo+ID4gICAJCQltbWNfc2V0X2VyYXNlX3NpemUoY2FyZCk7DQo+
ID4gICAJCX0NCj4gPiAgIAl9DQo+ID4gLQ0KPiA+ICsJbW1jX3NldF93cF9ncnBfc2l6ZShjYXJk
KTsNCj4gPiAgIAkvKg0KPiA+ICAgCSAqIEVuc3VyZSBlTU1DIHVzZXIgZGVmYXVsdCBwYXJ0aXRp
b24gaXMgZW5hYmxlZA0KPiA+ICAgCSAqLw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21tYy9jYXJkLmggYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiBpbmRleCBkYWEyZjQw
ZDljZTYuLjYyODczZWNjNTJmMSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9j
YXJkLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiBAQCAtMzIsNiAr
MzIsNyBAQCBzdHJ1Y3QgbW1jX2NzZCB7DQo+ID4gICAJdW5zaWduZWQgaW50CQlyMndfZmFjdG9y
Ow0KPiA+ICAgCXVuc2lnbmVkIGludAkJbWF4X2R0cjsNCj4gPiAgIAl1bnNpZ25lZCBpbnQJCWVy
YXNlX3NpemU7CQkvKiBJbg0KPiA+IHNlY3RvcnMgKi8NCj4gPiArCXVuc2lnbmVkIGludAkJd3Bf
Z3JwX3NpemU7DQo+ID4gICAJdW5zaWduZWQgaW50CQlyZWFkX2Jsa2JpdHM7DQo+ID4gICAJdW5z
aWduZWQgaW50CQl3cml0ZV9ibGtiaXRzOw0KPiA+ICAgCXVuc2lnbmVkIGludAkJY2FwYWNpdHk7
DQo+ID4gQEAgLTMwNCw2ICszMDUsNyBAQCBzdHJ1Y3QgbW1jX2NhcmQgew0KPiA+ICAgCXVuc2ln
bmVkIGludAkJZWdfYm91bmRhcnk7CS8qIGRvbid0IGNyb3NzDQo+ID4gZXJhc2UtZ3JvdXAgYm91
bmRhcmllcyAqLw0KPiA+ICAgCXVuc2lnbmVkIGludAkJZXJhc2VfYXJnOwkvKiBlcmFzZSAvIHRy
aW0gLw0KPiA+IGRpc2NhcmQgKi8NCj4gPiAgICAJdTgJCQllcmFzZWRfYnl0ZTsJLyogdmFsdWUg
b2YgZXJhc2VkIGJ5dGVzICovDQo+ID4gKwl1bnNpZ25lZCBpbnQJCXdwX2dycF9zaXplOwkvKiB3
cml0ZSBncm91cCBzaXplIGluDQo+ID4gc2VjdG9ycyAqLw0KPiANCj4gVGhlcmUgc2hvdWxkIGJl
IGEgdGFidWxhdGlvbiBiZWZvcmUgdGhlIGNvbW1lbnQsIG5vdCBhIHNwYWNlLg0KICBEb25lOiBy
ZXBsYWNlZCBzcGFjZSB3aXRoIHRhYnVsYXRpb24uIEkgd2lsbCBydW4gc2NyaXB0cy9jaGVjay0N
CnBhdGNoLnBsIGJlZm9yZSB1cGxvYWRpbmcgcGF0Y2ggbmV4dCB0aW1lIHRvIGF2b2lkIGNvZGUg
c3R5bGUNCnZpb2xhdGlvbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg==
