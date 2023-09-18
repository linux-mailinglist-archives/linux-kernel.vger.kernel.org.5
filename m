Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7B7A4546
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbjIRI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjIRI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:58:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BACD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:58:39 -0700 (PDT)
X-UUID: 8bc40054560111ee8051498923ad61e6-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wHrc4z7aVF1yWNFuAZn1lDmxs38e3qf9y8PQUGHKoTw=;
        b=bi85bsR+RpeypFnE7dipSWzWjzdkwxR+RYH7TZgukiun59g7VYtxvnUFFSCvrqubyP89FgFUB6Ca7zB3u4KzrIGhqBBAREEUMVvsITMa8heJNUtljjgkffLq+mlD3q4oj1zq2R6E6I8uJRCnEv5XGP7ARG33CoUg8Cg0FA6U95k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:0f594c41-fa41-4d3e-be27-8dab1119dc25,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:5b22d3ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8bc40054560111ee8051498923ad61e6-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 366130972; Mon, 18 Sep 2023 16:58:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 16:58:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 16:58:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqviV9fcah8VeoJGrGJ+Ac+JH8bdr+HS+ERULL6VyQgYXg548f6oAJqDsVoNBXTB1pLxJV56MtRExIYItsKE/9J3hwSuPDYdpT01jVcf//xFt6vo2OoMV+nAlMr3yA2iI3jsYpNgHAOfQrCkSzU6QeQfjLW5OMUTi737L5/5xnhqECe4/ieAXrmsfMEUucM5E2AfwT7DHNm6U2d0N3HRV43GARRV8H/l+lFXPm92NraptOZOc01kNd17cAgLOgjoWdTbKpEqNyjAynLy3mRepTn8TnzfHZrOLq5Pb8CN476kdIXzCH49j5+MXoef3HTcGmAlWggxfWoE9uc6sg3NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHrc4z7aVF1yWNFuAZn1lDmxs38e3qf9y8PQUGHKoTw=;
 b=Lw/oZIVz+GVdgvmnkK/fcBkE+0eqgGoIjWbMVeMM+jzGqgJg0vIpY8LQr8Bd8hUSmWQy0Ljm8likIQ260jGd+pghA+8o/9FT+jLRrfH9VxSJ4zQ4zHDGfhmntLE2wMzmjQ7I8fTe6N+Q4s2pe3cPs68GZM6v8uOvhPMMPYd39ewoNkXgQtA7jrRvfKTgYJ4qaThyGs9i96Aw9KX4IE6g5rBii4Y6NqSoj5V9O6ZE/wfh+Yjj9sfF02x5RmvYcEbrz0+6/m2sc4AXhq+cCQpfKCWb33P2/pN1CxaoH3gsDArAvdURHG7AAMis7vDVCGAu1ZarGUplemumK9sAUMYswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHrc4z7aVF1yWNFuAZn1lDmxs38e3qf9y8PQUGHKoTw=;
 b=I4dW3MVstjMgGkJL6SxgCtTArbnPAIafz/RJo9Ta3bykSR3jLhyMPUqmoPe5T/ujcehFgEuBfAEhNQt8C5w8mHTdmJRYInUPp9KGkuHvTQG6mJWrTe+IxnL7LnWb9UxCnCbhEi+7NgndTZdNnltXumnDaUWc6Ai49xJ73Wh2s/Q=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by KL1PR03MB8043.apcprd03.prod.outlook.com (2603:1096:820:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:58:29 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::faa3:6316:28ab:206b%3]) with mapi id 15.20.6792.023; Mon, 18 Sep 2023
 08:58:29 +0000
From:   =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 13/15] drm/mediatek: Add missing plane settings when async
 update
Thread-Topic: [PATCH 13/15] drm/mediatek: Add missing plane settings when
 async update
Thread-Index: AQHZ1dSXiFA3TVMB4UyuRIssiWQXb7APY1mAgAZddoCABK9tAIAGAK8A
Date:   Mon, 18 Sep 2023 08:58:29 +0000
Message-ID: <1698b2effab54209f242ee12d39ceb8b46fc7af9.camel@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
         <20230823151332.28811-14-shawn.sung@mediatek.com>
         <d43e0d7b-1e93-f9ae-df3f-cbf8a3381a70@collabora.com>
         <e1f07420c9d7abf26cf9ce111c063224001ba561.camel@mediatek.com>
         <982d201a-bcf2-f856-00e7-8807ca5a006a@collabora.com>
In-Reply-To: <982d201a-bcf2-f856-00e7-8807ca5a006a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|KL1PR03MB8043:EE_
x-ms-office365-filtering-correlation-id: 38010666-077d-43af-85a1-08dbb8256d65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuoCnh3q0DaB2j3muBLKn0pd/Ftf/k7BS1xuAbWCEjqO7Zf+pq+5cSPoM02gpCrHYUWw21fVY9+gZ+k1rmxB55tkUN2fxmg+7L8qXWfK6h20IMOFvp8BXWPKyKaj6ehPD2b5T7cR0GwlQLvb81Q69xy0/ZiquPBMIInbva+k/RKJScYfpy23uoLRLrxunyxSESdObrDuO5smgTPCdJLUikg2tM9wT2yQhBmzcgehSOTl+9lLpvLM5FS2d2ymz8bHb8ff5ZkZpTiv/R8BBFZ44tQrXlQLquaEUXtNONs4ECDiSUemwjas+5larHBmAAzW82YPtbb1/ugiTcVkIpIwEKFJtsDvIwZI5Snsm0+TsWpOrB8TWN7EYzDcs6JnSisyEokhjrCZ6pPKuq5mG4e0RKSDPZWFgvVUIq98cq1qtoPTpeWXnjl0F2w0xZWnEMFFlfYhbGyx6I0UWSytQzPkk4uWZvYjnUyVkIQt6Si3hlcaCvikxBowtBc8r23YE/J3J6QskQ42d9ATD53qxn2O1DlL4xEXbwMz5qcVLxmpQmZqRGzl6cTZ+Br6/GO2ZUl5ngf/gIkz6cR6cERJyom8s/lYzhwEeWegPsyUIAE4H2YW23QJHg/VVEdrQixUlUg6meqF3yL6cNzEi8CGs8nsBoa5iq6wGkriu/1snPDjMIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(1800799009)(186009)(451199024)(6486002)(6506007)(71200400001)(478600001)(122000001)(8936002)(8676002)(4326008)(38070700005)(38100700002)(86362001)(7416002)(26005)(107886003)(15650500001)(5660300002)(54906003)(66556008)(66476007)(66446008)(66946007)(76116006)(64756008)(83380400001)(110136005)(41300700001)(316002)(6512007)(2616005)(2906002)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmhwaUNobVYwNHJWTG1vQUhYNkJLQUJ5eGptdDczUmR2aHpVKzBoM0NsNmpO?=
 =?utf-8?B?aWE4K2dxMkxaMHJOMFBWays0WjgyaDRUb2FQcFVkNy9mcGh0d0JSZCtGM2R5?=
 =?utf-8?B?aHQ3OWpqT2sxbTdsWFZJdDg0V0syci9Gd3J0S2k1SzB3c29QejhrWFdLQU1o?=
 =?utf-8?B?ZjloaUJBUkdPM2Vpc1IvdUhab0hDVDBsd2VmNy9rM3VDRE15SmNXc25kUUVw?=
 =?utf-8?B?bDU0WEVJTktjOWRScUhvL2xNT0ljaXRqNG1FZEZ5NVhiQ2hKWXN1ZTh6MXNS?=
 =?utf-8?B?SGRzTXVNUGIzVEQ1TGJxTyt1dk1Icm0rKzFlT05rd0MxZHo4Y0VxSWhOc1RH?=
 =?utf-8?B?MGJhOEN2cU8vZmZKNlFuNmpESm1oeUFiZDl3bk1iVkw5UXRBTGxKZGZKSTU2?=
 =?utf-8?B?UDBDdS94TmZUenEwS3AxQUxPakVmQlhFV2U0Vm5LRWUwU3pCR0tudm16Zzh1?=
 =?utf-8?B?MC9RNktQQ2EyYkVNdUsrdi9vcmxLaEZSdXdXYUlidDlFbHpxdkYzR2Z4V2Vw?=
 =?utf-8?B?MUdOTEsxUVc4WjUwN20rNXA2K0xjU1gyRk5BZVVucnlZRG5jOU9tb0YyU2pJ?=
 =?utf-8?B?a1JWOG1CMjVBcGxKbEpvclcvY3RvRmJ4RElsZzdLbkxIL21jZmp6Z0pWM1hx?=
 =?utf-8?B?OEVzUTViVVU0UWMwU0h6emhiZWU3OXJrNEVHT2E1d1QvVGRvSTQ4WURWKzBx?=
 =?utf-8?B?MzJxYzBVTWtJU3gxWGNOYkdSVjc5Qlg0TGpGN3NUaDZNeVlmTExxdm5JY0Fl?=
 =?utf-8?B?dDNyVFpnWDRycXo2cmVwazRUWkI1YzFsc09Xa014d3BQVnZWSUN3RDFxb1FO?=
 =?utf-8?B?L1F1bEw5ZTZXcEdhaktBNlBpLzNJMVR6eC9nNENScFc5amxTelgxSnJEdThU?=
 =?utf-8?B?QXR3VndXQnZ0a3ZjVkNzWkdQazFDV2VGNENnZzV2NWlleXR6aWRRLzBCS3hm?=
 =?utf-8?B?VVpqR2duSTIyaUVPNE1GdlcvRzluYVdGMkIwS0FPOWkxLzZVTGtHcDQ3VDRx?=
 =?utf-8?B?UXdRUE95LzVBN3dhNVV0K1RrYWpaQ2VlR2ZtT0djdEJ1T2R2NDhJWUk2bzRt?=
 =?utf-8?B?ZGJqM1RERGtDTnQ3S3o1VExHT3NZWllDS2o2b0lpUWdDd1VpTlRNVG1Oem1T?=
 =?utf-8?B?VUVrcUNIQzIvWG9rWEg3ZkRpbDQxVHZIZVJyU0lqQ3lrY3BybjJna2VubDc5?=
 =?utf-8?B?UUhQRmFBaU5CWmRNd3ptMFowd1BKZDlORkV2T3RHMndkSkw5Q1hkc0hNaUkw?=
 =?utf-8?B?SEtsdGNQMnlEUnR6NFd6ZUpDSThhKzBSWnY5aGNuWGtYM2R1YzFXYWlQREhH?=
 =?utf-8?B?QndGbzNJdnpxaDlOZ3h3ZDEzNmpDbUFUY25zLzFUZlI5Uy82L3dlZmpSb2NC?=
 =?utf-8?B?WHZ6KzNhVXNiTjF2VGw3S0tmMDFQSUh6K0EvdTBRQm80S2NnYXppNkdxVUVM?=
 =?utf-8?B?SXZMUWdndmhCMk16Ry9USGQyV3FVYU5NVDZFWDhWNWlPWGhrekZqOHQ5U3N3?=
 =?utf-8?B?OGtMb0NoZHJpZ1pyT1llTmNrSTB4bllqcjBBKzc0Qy9ucWkwOTQrcHVkSjht?=
 =?utf-8?B?TFpMY01XdXgwc1kxM3lDSm9NUFNkTlNQQW1aSVpHMjJIaEVyNVB5dkZLaFpU?=
 =?utf-8?B?SlZ3YnNTdjJOVzlQUGVhQXdXSWhaQ2x6d2toRGQwRjVqZkxDZFBoN3Nhcnls?=
 =?utf-8?B?WTlDNlM0Q2ZYM2FUOUNDQnVUaUNYS1NkU0N4TUJndWlVK2pWcmwyYVRTUjJ3?=
 =?utf-8?B?d0g4UEVkZGpPNmtES3JOVWJiSUhCMHA1U0xITkJoU1JxVk5iSGIvb002NUxT?=
 =?utf-8?B?VUM1WWJKSGVUZ1ZrQ3gzTFQrdUN5V3BpdWNSc1VjdkxJWkNHdmRFTVBuVERL?=
 =?utf-8?B?VDdhOERieW1VdXdHSjlWTHFhWGpVSGRTQVovTndVYlRvdGtoWWJzaHhOTXp4?=
 =?utf-8?B?c1AwRHQ5OXp1VkxCTkErVG1aZTIwcTNOa2J6Y2VwMVFhZ2djMHY3UEdEZHZC?=
 =?utf-8?B?YnFuREJkbzlPVXB5YVlwSWcrMzJjMDN5YkJIeDJJSFEwQVZjc0xMeFBCSDBD?=
 =?utf-8?B?VEQ4RXlXR3Jmd0p2dnhWTGg3MjZqWm1BZFl6akxzMXA5WFIyZ3VMQmgxMXp4?=
 =?utf-8?B?TENEQ2x5bENNVnJTcHFRcU1oR1ZSL0x4WU8wRk1HNUFmbWtweWlYaG5Xb1lH?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1C0412867FFC245BFD8227FDC0A71D9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38010666-077d-43af-85a1-08dbb8256d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 08:58:29.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vS03jBFwMoR/qVWwcCLhIvkJg4cuO4iwXfshJqF0wJ+NhrUxlYzQu4Y72aSfhR+KJlrgpFNHqAbUTmuVpj3+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8043
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.967000-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXYLhsH23joBiQh5Y6YXsJtcyA1dgOjatGGwtxO0yU8hpUrHkgIan9a0YZ9m2yOY6FFM+p
        +NpswZmrHzzR0zD+Vr84pEbFr1obyePs/Cx1DJd0zw5Ejs3g1ll3KZkFy4YZEZ5yuplze9psDkd
        7WQNL44uLzNWBegCW2PZex/kxUIHWNo+PRbWqfRDsAVzN+Ov/sLdyEcCsJjPq1Rxs9MK6JEguFW
        8LIkUfeoRM6N1v+9lA6GRZkfRbuiA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.967000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B3C4D7260BC34B998A848185E90A9D6D2EE151AD0E9A3C4D87995FB874CADAE82000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjMtMDktMTQgYXQgMTU6MTggKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxMS8wOS8yMyAxNTo0NSwgU2hhd24gU3Vu
ZyAo5a6L5a2d6KyZKSBoYSBzY3JpdHRvOg0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBPbiBU
aHUsIDIwMjMtMDktMDcgYXQgMTQ6MzMgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
DQo+ID4gd3JvdGU6DQo+ID4gPiBJbCAyMy8wOC8yMyAxNzoxMywgSHNpYW8gQ2hpZW4gU3VuZyBo
YSBzY3JpdHRvOg0KPiA+ID4gPiBGaXggYW4gaXNzdWUgdGhhdCBwbGFuZSBjb29yZGluYXRlIHdh
cyBub3Qgc2F2ZWQgd2hlbg0KPiA+ID4gPiBjYWxsaW5nIGFzeW5jIHVwZGF0ZS4NCj4gPiA+ID4g
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4gPiAgIEZyb20gd2hhdCBJIHVuZGVyc3RhbmQsIHRoaXMg
aXMgYSBmaXggZm9yIGFuIGlzc3VlIHRoYXQgd2FzDQo+ID4gPiBwcmVzZW50DQo+ID4gPiBiZWZv
cmUNCj4gPiA+IHlvdXIgbmV3bHkgaW50cm9kdWNlZCBjb2RlLg0KPiA+ID4gDQo+ID4gPiBUaGlz
IG1lYW5zIHRoYXQgeW91IHdhbnQgdG8gYWRkIGEgRml4ZXMgdGFnLCBhbmQgdGhhdCB5b3Ugc2hv
dWxkDQo+ID4gPiBhbHNvDQo+ID4gPiBzZW5kDQo+ID4gPiB0aGlzIGNvbW1pdCBzZXBhcmF0ZWx5
IGZyb20gdGhlIElHVCBzZXJpZXMuIFBsZWFzZSBkbyB0aGF0Lg0KPiA+IA0KPiA+IEdvdCBpdCwg
d2lsbCBhZGQgYSBmaXggdGFnIGluIHRoZSBuZXh0IHZlcnNpb24uIEJ1dCBzaW5jZSB3aXRob3V0
DQo+ID4gdGhpcw0KPiA+IHBhdGNoLCBJR1Qgd2lsbCBmYWlsIGF0IHNvbWUgdGVzdCBjYXNlcywg
Y291bGQgd2Ugc3RpbGwgc2VuZCB0aGVtDQo+ID4gaW4NCj4gPiB0aGUgc2FtZSBzZXJpZXMgc28g
SUdUIGNhbiBwYXNzIG91dC1vZi10aGUtYm94Pw0KPiA+IA0KPiANCj4gRml4ZXMgYXJlIGFwcGxp
ZWQgYmVmb3JlIG5ldyBmZWF0dXJlcywgc28gaWYgeW91IHNlbmQgdGhpcyBwYXRjaA0KPiBvdXRz
aWRlDQo+IG9mIHRoZSBJR1Qgc2VyaWVzLCB0aGlzIHdpbGwgbW9zdCBsaWtlbHkgYmUgYXBwbGll
ZCAqYmVmb3JlKiB0aGF0DQo+IHNlcmllcy4NCj4gDQo+IFdoZW4gdGhlIElHVCBzZXJpZXMgd2ls
bCBiZSBhcHBsaWVkLCB0aGlzIHBhdGNoIHdpbGwgYWxyZWFkeSBiZQ0KPiBwcmVzZW50LA0KPiBz
bywgcGxlYXNlIHNlbmQgdGhpcyBvbmUgc2VwYXJhdGVseS4NCg0KR290IGl0LiBIYWQgc2VudCB0
d28gZml4ZXMgdGhhdCBhcmUgZm91bmQgZHVyaW5nIElHVCB0ZXN0IHNlcGFyYXRlbHkuDQoNClRo
YW5rcywNCg0KSHNpYW8gQ2hpZW4gU3VuZw0K
