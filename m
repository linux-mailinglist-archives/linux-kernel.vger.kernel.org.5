Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8727B10D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjI1CcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI1CcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:32:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0F3102;
        Wed, 27 Sep 2023 19:32:15 -0700 (PDT)
X-UUID: 3a935b145da711eea33bb35ae8d461a2-20230928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kL25Rn/AP7i9z/ZHjz47jH84CIGC8JhHa7rCdhWUaes=;
        b=mZ9drMngBwinrjADHySZHWk0ImbhCPbpyCOIa67Fd1d0Xdv+g7lE+HqFAezCqG+n4GUOBIQCNc5Co9ms5xxCc3EMoVShQFy13JdkgzzZ9M3RF/c4sfUfQLJhvpcum4PA8D2+NJxm4vwk8OyPQweedcuJexBYN6DtHCuoQB5NInY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2124f72a-37d2-4292-a7c4-fcf65d1ff975,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:2bb98cc3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a935b145da711eea33bb35ae8d461a2-20230928
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1523485547; Thu, 28 Sep 2023 10:32:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Sep 2023 10:32:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Sep 2023 10:32:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezKuk0RcaJfxGC9IJY7if4dkeJBfW+Ax3X+DRKbuCr+1fkbVMZlGDALBDcHSxu8I/LSe9dhW2Gk//2QpIktPXMwmc08LabXmHR8ssi/z4lKyp3qZ6YuxIvKt0Uw1VQsgeV7j5OYEZrpxMbMOX2zXbcAOybmiG/TTcIoyvs9sLWEK+DPtXCzpa0Ob0Noo2/p7FiA4P03d23gGotyzr+HIld6Mn6UtgSxcvKOoXe9If74we4Pb15nVVE6HoL/Bnu9A7KjTIpfjdwVGOvwUrifNOlZWTnKoAVeu01oX2T2zqeASxhG3w7+VwKVUPkfF34Yf+7No+jpei5vJ01q4dKYTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL25Rn/AP7i9z/ZHjz47jH84CIGC8JhHa7rCdhWUaes=;
 b=Qdq+gfaPV8v9t9K6vM0CaIv5MWc5I+f9wYmOhTW0AKNXe8HVhe/Bhhjj0dTyRVv3C2eIH/u25bwSfMUpVhJelvQ9Ch6/LP1vqbrBNkFJimzMe6d3Yor8q6kpU5sfont9YhuVIxXYTfXBkTYaSWorBIt2TptBKIcccqbGaz7lqij6l66TTTA5QkkX1Hh11uw0I1lbgpq7YYDNxT8ZavarAWEt9EwpDQyR9fYaW+g6igA43XGIyrtImUdC+EaxnbRf5s0apF0RY/Qoicotq01BCsN8QOif13KWxOEFnVtsze8L14I/FekrQ2OSISzTDvw6dsln/kI9XC2cPIh1MXIX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL25Rn/AP7i9z/ZHjz47jH84CIGC8JhHa7rCdhWUaes=;
 b=vxWDefbzNGEZCWHUon4Df1aXMiA1pKjgA2pl2uPNVqaDePZUpgjKEkKgDvArf7cHpxKaVKjcqybZ8MPqdidk0nbhJgtgwzgqo/u3hYK7iabyIF6IJ8eYdO73Rpp4pz1bHR23b/fDBgcMN/9HIRXVtIHyoTkaL+PpMUozqNWZl68=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6160.apcprd03.prod.outlook.com (2603:1096:301:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 02:32:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.026; Thu, 28 Sep 2023
 02:32:08 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND PATCH v6 16/20] drm/mediatek: Make sure the power-on
 sequence of LARB and RDMA
Thread-Topic: [RESEND PATCH v6 16/20] drm/mediatek: Make sure the power-on
 sequence of LARB and RDMA
Thread-Index: AQHZ5IO9G+a0r5TRFkuvtq+840dZZLAvnuuA
Date:   Thu, 28 Sep 2023 02:32:07 +0000
Message-ID: <701804230d4de3dacf7028c60afbc73f4f7167fa.camel@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
         <20230911074233.31556-17-shawn.sung@mediatek.com>
In-Reply-To: <20230911074233.31556-17-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6160:EE_
x-ms-office365-filtering-correlation-id: 515519bf-9d73-439f-be36-08dbbfcb1c76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbxvqXBKHqoN8Bcq6RMPh6am7/3SH11YWwo7ilN08Paj0mlJwliGiNt+oZ6sBpo9Go7i7CQPbdMyZAntRQLCXDYBJUa2AnxuWpVmg451YG6YHXHbocD9RB/elWfT7ZGrIg9L5bGrUVjvyvzgBRIARLT9g3CrZN7LNZHT3KWZwd8/ifaFG+KDa60j2tuoEVKRPwjKZSKxtYRosg4UBAPNQsfetdA1cKKZRYo3dOCSAyDwYWW61ev7ET7JC6KFPetFiNSbcUw8gjZuLsb1A98UnurpcMjz1w/9hgNGxO3B8bmMQDMBXSBgAJgj0uxjRtQfnNTSwebqMJeKcu9xdRS4UHxAC5PWy7bAugJNSRoIbrD8Lq1z2yJFNudUPmUf7zbra2s3eaCMl/Qz/V3B+lZgCCqBtV+LFTKij4Zi/TRuPpTUOBW/gzTH6jWqWeX9luE9BzhFFc/3IiLmPfsBFTqMMKvtiumx/77sPYKrBDaBFUS+dFx5q5adU/gooIV6x9S4Zr3lModrahgNnCtZePJ9kWVR6/ph7KMOybCef77iazT8Cy75+cq7crZR0mcb8nl0ZtgU/rAxMhak7G+aDwoq2AFmfe52qdjOeXbOyqu0eumrJ8cyqYVXvPW+34JrjcotK/GJKKnqk+6T7TzUQqzQDXnmivniSITkqgDgra4Jn4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(7416002)(2906002)(8936002)(66476007)(41300700001)(4326008)(66446008)(5660300002)(8676002)(66556008)(54906003)(66946007)(64756008)(316002)(76116006)(110136005)(91956017)(6486002)(478600001)(71200400001)(6506007)(6512007)(2616005)(26005)(83380400001)(122000001)(38070700005)(38100700002)(36756003)(86362001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmZJa2x1Um5iNUpGWDk5NHJRcE1VSHJmOXRiK1pIVGE4NDhuUGFvaE1JOHJa?=
 =?utf-8?B?T1llS1czUVFvdXpJWmNoOS9BUFpPc0E5Q3JLb0R3dldkYTFLdlM2aDRyRXJn?=
 =?utf-8?B?TW5IMXVXUTV4ZU9XZnpHK01qU0Nkamo4U0pHeTNHSytvUUFHSWV2NERuaC9q?=
 =?utf-8?B?RTdWSTRVdVp3UXN4Ny9PQ3FSS2ZOazN2bXVZMy8wRTdWOFhtZzAyQXlyc3ll?=
 =?utf-8?B?MFRvMzV3cXh5ZjVCQ25GVVpIZnphazhHS3VqRDdzVUwvWldjK0RRQkplOEo2?=
 =?utf-8?B?elZOWlhjOGdDYVordlJ3dmNIc0JXSGN5dEs3NytwY2didUwwMEhiQUdnNkZO?=
 =?utf-8?B?RVR3S3BsTCtFOWFJVWJFYUxzdmkyckVIcHBwRUwvSFJoWkplTW1IaE9sQWRm?=
 =?utf-8?B?dWtBdDdxc215TDFacnJYSlUwZDVBQ2RQTW51Y3V1N3VlZTZCWHlMbmNBcWNW?=
 =?utf-8?B?bmtwajN1ZXB0bG9wMEh4RUNVSmVpLzJHNTl5QmdDeWFzZWxTUFF0ZTdnYVdG?=
 =?utf-8?B?NDNySlFBZTNqUW0zbW9tOTVCMSt3dVE4b3dJV0IvVmdoODZhUG94aDVua0JH?=
 =?utf-8?B?Mk1YclJIanpoNmQ0UklubnVKM2prUlVmczdDNit6STd2STB3ZklaUS95K3ZY?=
 =?utf-8?B?RTlyeXB3R1hpbEhKTGQyNWI2WkNBSTVaWnFrQnFha2I0Q25KWkxYczI0bW1t?=
 =?utf-8?B?YTFwSVBISldXRk1zUEpMSUV6WVJDVndnSXdBd0JTbkNkRlBGRWVaN2ptMkRk?=
 =?utf-8?B?R3NraWNUNkJaMHVmTVc4ZUtDdGZMOGRNK0lSeEtPckVlTGVYTHB6SjJaVTRo?=
 =?utf-8?B?TDArOGtNQnpPbXhxOGt3Zm9HQzJDSXFkRUtMTjVyTWhkOTVoVFIwSEtRaFZk?=
 =?utf-8?B?THR3aDFPbHNQWG8wc3RKMFV3WVlpZE1ldkY0LzVsdlhvQVViQzRWR3dFUkJR?=
 =?utf-8?B?UWExYnlLZVAwVWNHZ1lNVGR3R25HYm5oczZBVFRSRTVndmdEQUFwbWtXQm5P?=
 =?utf-8?B?TXF3MmFzem5EUnI0eTNISDJrditsRjQwNVZiNFNlTzR4QjMyVGNnUy8rYzlx?=
 =?utf-8?B?dEdJQkQ3MnBCN0N2RHUxSzNTaXd0VUZrTUZSZGVERFE5bHo2Yk1zVW1BQUc1?=
 =?utf-8?B?SUc2Rkp4OVVyS2N0SlVoUjBGQnl6aGJIQklqSWZUVlNvQTEwUzVyd3JKV0wy?=
 =?utf-8?B?QmxMcnJkT3d0VEd3cjBiczc4TXdhczFoekdLci8vNURCbWpnd1JpMjFyVmkz?=
 =?utf-8?B?eGwwejNFNVZWQW9hR1BQSm1SRVNZZUwybmdHK2VsWnRkQWptL1ZRYUZnSWR5?=
 =?utf-8?B?VWZ2a1VWQ3E2Ynl6N2NueENzak1hK2g0SzR1ZEtmdEJzeVI0RXM5VGJNUTJz?=
 =?utf-8?B?V1h4Tlc0ZjMyT3czM05SaHluVTBwQU1CaHRoS0pjdEJ4TVdMTEVzY0JBa3dh?=
 =?utf-8?B?aVVwdVhNcGpibU5HNVJHWC85QnFRTDZhMW5EQUcwK3o5bHJuV0hOcVpFZGI0?=
 =?utf-8?B?Q3Y1d2JJTE9LWDRoMXAvSm9Qc3p0SGtjTWNPNDFzR01NUUF3WThZUUExVTZt?=
 =?utf-8?B?U0k2WkVxa2h3b2QxNXNhNlVBbDlmVGJVN3dJVTkwaG5QQzB3V2R2QXEyMFdR?=
 =?utf-8?B?eXJacmlJeTFGV3hWSFQrSzF3aEtXMVovVGduM2lDTTU3bkg4QUo5UVhGT0lK?=
 =?utf-8?B?akduc2djUDF2WjBCRWtkM3hvRThnWEJVcGhxY0lPRWN6QmkwYW5rYzJINDJo?=
 =?utf-8?B?NFg5NFhqTk1BS05KUVRydnd2VUNmWWZjN0tYKzBkM2lOSjQ3ckVLQno4Z0ZR?=
 =?utf-8?B?Y2xKT0NYVGxld2UyUm9ZTlRqUVBGMTErNzVKVEZWbG44UlB6Zm9oMDR4MnFN?=
 =?utf-8?B?MFV4U2VabS96RERQNDdWUk1RbTk4Tk00bDRwZkZjN1ZrNjdrS2pDMmZTems2?=
 =?utf-8?B?S09QdW9ReHgya2c1OG9Wa2xFTGhaaFY0THN1T1JnUHFyNysrZVV3UVd0SVN0?=
 =?utf-8?B?Q3NocFlGZlV0Z0VHR2I5dTBxeGxpMW1oazU3WWRaNjQvMTBQbFkvcVk2WDZI?=
 =?utf-8?B?YTd6Y2I5SWFhVnZUNzRVdnRKczFOaGgrT3k4WVJZOTRmN3pqLzZSRVk3VURh?=
 =?utf-8?Q?TKf5f3FeCS33XwL+waEZbDl3P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F901F3E0C317CF45AD2C1B51DBB051A6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515519bf-9d73-439f-be36-08dbbfcb1c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 02:32:07.9851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhRtQXWni7BiwQ7U4UfsJHnB6KlNy0dvrWVE59a0HbJ6x9VdYC6xztPlKapIe6TCOpqgaCsh4XvC+wEjxA88Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6160
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.884400-8.000000
X-TMASE-MatchedRID: 9zTThWtzIms/XHdICuW5r97SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYLoy
        jzJLBknlCq5s1+QmQSanqcsEmxwKO+m4jgMXwUpGo65WJt1k1O8xmbT6wQT2a6KZfISIagyS8oL
        zUWewXkhtoWjVt1YIZjhIvjcbHHfSS3Zni/NoaLeHZXNSWjgdU3nUZqRb3abmH8fXhwPLN7GjxY
        yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwAVA+7VR1TCeiB/CWsBLhM1NMt
        nGZsFiuqLQxknt+R2T/uWIvb+RziQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.884400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: C9B408DE6AE3E5C5B7C15880D89899AA072EB28B57C633CEFCE02BED677BF40C2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMDktMTEgYXQgMTU6NDIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFNpbmNlIExBUkJzIChMb2NhbCBBUkJpdGVyKSBoYXZl
IHRvIGJlIHBvd2VyZWQgb24gYmVmb3JlIGl0cyB1c2VycywNCj4gdG8gZW5zdXJlIHRoZSBwb3dl
ci1vbiBzZXF1ZW5jZSwgd2UgY3JlYXRlZCBhIGRldmljZSBsaW5rIGJldHdlZW4NCj4gUkRNQSBh
bmQgaXRzIExBUkIsIGFuZCB3aGVuIHBtX3J1bnRpbWVfZ2V0X3N5bmMgaXMgY2FsbGVkIGluIFJE
TUEsDQo+IHN5c3RlbSB3aWxsIGd1YXJhbnRlZSB0aGUgTEFSQiBpcyBwb3dlcmVkIG9uIGJlZm9y
ZSB0aGUgUkRNQS4NCg0KT1ZMIGlzIG9uZSBvZiBMQVJCIHVzZXIsIGJ1dCBPVkwgaGF2ZSBubyBk
ZXZpY2UgbGluayB3aXRoIExBUkIsIGJ1dCBpdA0Kd29ya3MgZm9yIHllYXJzLiBJZiBhbGwgRE1B
IGNvbXBvbmVudCBuZWVkIGRldmljZSBsaW5rIHdpdGggTEFSQiwgYWRkDQp0byBhbGwgb2YgdGhl
bSBub3Qgb25seSBtZHBfcmRtYS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYyB8IDIwICsrKysrKysrKysr
KysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21k
cF9yZG1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4g
aW5kZXggYzNhZGFlZWZkNTUxLi5mY2U2ZmJiNTM0YjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfbWRwX3JkbWEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gQEAgLTI0NCwxMCArMjQ0LDIzIEBAIHNpemVfdCBt
dGtfbWRwX3JkbWFfZ2V0X251bV9mb3JtYXRzKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gDQo+
ICBpbnQgbXRrX21kcF9yZG1hX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0K
PiArCWludCByZXQ7DQo+ICAJc3RydWN0IG10a19tZHBfcmRtYSAqcmRtYSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiANCj4gLQljbGtfcHJlcGFyZV9lbmFibGUocmRtYS0+Y2xrKTsNCj4gLQly
ZXR1cm4gMDsNCj4gKwkvKg0KPiArCSAqIFNpbmNlIExBUkJzIChMb2NhbCBBUkJpdGVyKSBoYXZl
IHRvIGJlIHBvd2VyZWQgb24gYmVmb3JlIGl0cw0KPiB1c2VycywNCj4gKwkgKiB0byBlbnN1cmUg
dGhlIHBvd2VyLW9uIHNlcXVlbmNlLCB3ZSBjcmVhdGVkIGEgZGV2aWNlIGxpbmsNCj4gYmV0d2Vl
bg0KPiArCSAqIFJETUEgYW5kIGl0cyBMQVJCLCBhbmQgd2hlbiBwbV9ydW50aW1lX2dldF9zeW5j
IGlzIGNhbGxlZCBpbg0KPiBSRE1BLA0KPiArCSAqIHN5c3RlbSB3aWxsIG1ha2Ugc3VyZSB0aGUg
TEFSQiBpcyBwb3dlcmVkIG9uIGJlZm9yZSB0aGUgUkRNQQ0KPiArCSAqLw0KPiArCXJldCA9IHBt
X3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gKw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlkZXZf
ZXJyKGRldiwgInBtX3J1bnRpbWVfZ2V0X3N5bmMgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKwll
bHNlDQo+ICsJCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShyZG1hLT5jbGspOw0KPiArDQo+ICsJ
cmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICB2b2lkIG10a19tZHBfcmRtYV9jbGtfZGlzYWJsZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+IEBAIC0yNTUsNiArMjY4LDkgQEAgdm9pZCBtdGtfbWRwX3Jk
bWFfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXN0cnVjdCBtdGtfbWRwX3Jk
bWEgKnJkbWEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gDQo+ICAJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHJkbWEtPmNsayk7DQo+ICsNCj4gKwkvKiBTYW1lIHJlYXNvbiBhcyB3aGVuIGVuYWJs
aW5nIGNsb2NrLCB0dXJuIHRoZSBMQVJCIG9mZiAqLw0KPiArCXBtX3J1bnRpbWVfcHV0KGRldik7
DQo+ICB9DQo+IA0KPiAgc3RhdGljIGludCBtdGtfbWRwX3JkbWFfYmluZChzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBkZXZpY2UNCj4gKm1hc3RlciwNCj4gLS0NCj4gMi4xOC4wDQo+IA0K
