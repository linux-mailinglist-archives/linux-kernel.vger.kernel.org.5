Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D467BB4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjJFKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjJFKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:10:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A89F;
        Fri,  6 Oct 2023 03:09:56 -0700 (PDT)
X-UUID: 7de95852643011eea33bb35ae8d461a2-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=z/cb5Bx+mZO8HSyDRq1oFzxX1n9J1kV7ss7TZj/U4xs=;
        b=QNvmRC4XFtDNgtSpKx2e/ZurqxkXo9FZscK0A6UVeNcu3jKbYQdupYQMHcRc50Nrxm/RbWGXCgWtyzAeLwTZB5LG4wMoQLnVDTQ8B8Di4AM/7vlmjaaAlEfsJ7uClCyY/G74gYrf3eZDQTlzTUyp39J4IWJP1udIBwalFepXuzk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:2d2e20bb-070f-4bbb-ac99-4d963dd736eb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:df8084f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7de95852643011eea33bb35ae8d461a2-20231006
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 119274833; Fri, 06 Oct 2023 18:09:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 18:09:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 18:09:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwCojtE4R62lRQjIXpfP20dFNwGkMQPfF2jybD34T8mkawUIo1wacItKPYAmXTXHizbQk4t+f0CLP37ZMMHlHWbZJhjaz39F4wLUlCYcFU5h52KtzBTjHX1VjKWyeyJN+Tu9FZD7HCu0up9WSSyj2ObDlhkrySM9fWLWYGNwdP83PfC675vP9vIYc6uEFuwvuXP/A6s0VedrJ17V4FiRQUfg7VIaqTZqDN8JikRzk6xXzc43hYk2oOgUO14whKc1yt0PHilj0LBqZgGlkkeiSfMGUFHayVnK81rCNNvZPj9cmAOt8vvLCE82gNl37lRweMCgmUiMU1k/HhloQf/pPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/cb5Bx+mZO8HSyDRq1oFzxX1n9J1kV7ss7TZj/U4xs=;
 b=E58goTEAtrGDOye8A1TaBsfkphGHHL1AwukxOH2mQRwqjqaPakZr2J7iX8Mn6VFyrK7KE5acHWgef9DdLlb4KL6xLpPVmU7qBXYEEGNP5xz9pkKo4W/7M3HVlAzHlfQQd/OZRLGJ59G51iOJWVLR7946ZrIjXB38G46jTUygSF1Wdc7s4ky0m/ZKr6Td2jV9EC1Ie4BpwFjqevgNOrZUjcY9Y751nhhiu0QpuqCXhXFc1kvqh8ZiIxpe29b/izJiq9wQ6XIpVtivG/H2sTS11gQBg2wM9duTPGuaUhdccWnESpOCKXQWKBvkP/WzSP4i2f88oUJYTyYdKIqGGCcEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/cb5Bx+mZO8HSyDRq1oFzxX1n9J1kV7ss7TZj/U4xs=;
 b=hyCLqe9jxRLkA2mWPlu/kXgIGwn9o252nV37CmlOB9U33zOtlvyo/V2gKelLvLxEzzRX3CLa+lsjKdicqIhb1uk2H7I/HKnAV14L37hN37DA9h59JpTt8tUNovw8xe0XMnPxSPChICQlzkwqERJ6SM3HN3oOKluF9DP6/iZsefA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8359.apcprd03.prod.outlook.com (2603:1096:101:196::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 10:09:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6792.026; Fri, 6 Oct 2023
 10:09:49 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/mediatek: Correctly free sg_table in gem prime
 vmap
Thread-Topic: [PATCH v2] drm/mediatek: Correctly free sg_table in gem prime
 vmap
Thread-Index: AQHZ9p1dh+1k3iMzaUKmT3IHY9xMFLA8jT4A
Date:   Fri, 6 Oct 2023 10:09:49 +0000
Message-ID: <d45d0357f53c8856aa03239066d092e5ed3bfdf0.camel@mediatek.com>
References: <20231004083226.1940055-1-wenst@chromium.org>
In-Reply-To: <20231004083226.1940055-1-wenst@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8359:EE_
x-ms-office365-filtering-correlation-id: 3c7babb4-11f2-4e8f-9776-08dbc6546039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFCVkah82gvUH5VRoawEfj1su0SmSEfR+Fto/76F+5XkQ1jOqi0rciB1tWYEycEYvX6WJSpKHcu/v7VidzVDqCEEc7gri2awsFekYYhNGl652Mocx3P0D5uiKOQVfSBUQUbwsvjvAtmurk5G/TWpG11z35SCLw80ALyq0Y3aD+XgRyikfgb3OFeMGptRzvLCzu6r6RKEZmLM1lRZe5Se16h6JVd0GOGevoau0TDFGuwn4CFfTdRa7s5VsKhHBX3lV8s5vpMWAkDCpViEvvdK5AFq3uwGbvt6PFRhF4imAoelnrSr7Lelj5vQTYitqT6dimePb3oXltTCopqZ+xVZd70tgMzSFeaGJRkSrZQH/7C5Ltl/c1h4Uxx0kqsizMtCYy6yNNPygyh7jYBVrYu5JQ1bKzveDWsk+gW6y+s5OewOkLuUY11mqSgD6dy5f6K69HanwH9wa6dqTiABSAJbYNAvRrztJRM81q4A2YOssNcm2oTQMkRXO+z5RWGUiCKxIWTA6ZBzfChTucW6GxEOjiEUKxhcre+QGYSeuURkeFH/sMDIeYZKHf8sNYVoRIJLsQ0mYT+R8u1SZquKr2dVu2qhG6AnzH0fO0tByWeqAe64Pu/0tX7iQLbyXm+qrpF0HFaQhtzt8ezRp3bS0RuqOC7tWH6suG5Ifi5+T5ngEGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66446008)(54906003)(66556008)(110136005)(66476007)(64756008)(6486002)(478600001)(122000001)(76116006)(66946007)(86362001)(8676002)(8936002)(4326008)(38070700005)(38100700002)(5660300002)(6506007)(41300700001)(85182001)(36756003)(7416002)(71200400001)(316002)(6512007)(2906002)(66899024)(2616005)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTVhRiszWnQzY0JNZVZEblFZbjZ1dEUrNWxMUFBvRStOMUc0TmZPWkp6Y2hT?=
 =?utf-8?B?aGdoRFNjTmNJUngrY2RCOTVjSEVQUmpCWWQ1RkFBbDg0U29zYzhXcWNPaDJV?=
 =?utf-8?B?NkVVZk94WHpLeXNsQ3V5Q0x0VmEwcWNPUVlORUxrT2l2NVJCaU9ycmcyS200?=
 =?utf-8?B?M2RhUGw3c0NPZUZKOGRrTnhCazMrQW5qSkova2JlWGtEMU0vdGRGQlFCck5p?=
 =?utf-8?B?elNxSDAzckpJdVczSFFUSGM0SFpxYThpSFVFMENwdkV6Ym9nTjFaUHJsNW1C?=
 =?utf-8?B?REpFNGhkYTdjSTBFSjgzaDR5cW03MWxKeTBBek9HVktwQmM3TFFkOVdtbEpB?=
 =?utf-8?B?M0Vua242cXM4UzgzUVpybmNsR0RoUmhybGVCSUdYWHZ1RCtxTFBtU1JicCsv?=
 =?utf-8?B?ZXdqMnhqMnpuVkR1aklXeEMzQmwvSlBJOUtrRGJqT0xjMndWRUxrUzcwenBy?=
 =?utf-8?B?RFY4eVJHZUgwRXpBZHEyOUJXazNFaWNaT1FQMDEvNGNaZkRTZE9Nd0VTSmI5?=
 =?utf-8?B?YllHa3BZaG8yb0FOaDhic0IrZ1N6RTNZR2Z5dVNVeDFkYVJXait6MG9oemk0?=
 =?utf-8?B?bURGMGNPT1NjNnpweEhvNXF4R0tzZ1BUVHRHQ0YyZzR2WUI5dU9GUURoc28x?=
 =?utf-8?B?ZjdKbzZsTVBYZWRMb1dHNzhiTndkRmVDSTRvUllCdDVVZG9ic2FBZ05WTVFC?=
 =?utf-8?B?QU8va0JVdWtvZ1lQTjJLeVczcC8yeGd6WnJQbkMxMy9aUXl0MVp4NXZRREZn?=
 =?utf-8?B?UFFnVGZUVHN3MDNmWUlQNklkMlpRRnZ4YjZNeEJXd3BHa2EyUDl0bHJLcmVz?=
 =?utf-8?B?NWJlRWY2a2pLVzV1eXJHeU10Y2g2b20vZFllcUZGaS94S3YxalltYk95Y0k2?=
 =?utf-8?B?TUlYUzE2UVJmYk1PVEtrOUtZTGxJWWwrRDMwVWJXY1AvOE1JMmlRTTVWbSt5?=
 =?utf-8?B?UEJEOFN6dVVKeXp6bkVLVmJ5ZTRDTWJFQVJBRmhYSVFhelUyOCtOaVRtVmt4?=
 =?utf-8?B?SjkyaFd6WkdWVFBhRHlrSGQ4RmI0TmE0bll5V3B2Qmp1UDN1bmw0bHh3azA3?=
 =?utf-8?B?N3FnekZwaGFCVFcrQVl3ZUJEeTFQVlJmV2VMN3hDV3VhcEdJVit4bmUrNjds?=
 =?utf-8?B?QjdQUTcxZzRJTnNBTjY5TjVIVjNmQVZFUUxkZVk5NFFmdjEvWjRyRWhRQ2Rt?=
 =?utf-8?B?Qi85RTNRSTZkVWVKTVhKUnRhSnBndUJjZnNYaGRaN01qR2pFcGM2Kyt4MTVr?=
 =?utf-8?B?RmJJV0srd0VyUmVQNTIya1pzTHQrUDV4M3c2QW0rNmdLUks3dm1YTkhFM3ZF?=
 =?utf-8?B?bTJVVHRLcTcwMGE0S2pBZ2xPdzVnSVpHTHZ0cWw0WEMzYk0zRExJQ1pMSGFR?=
 =?utf-8?B?OW00a253N3J6cnFnYUxxMXl4a0VjOEg0NlRja29mZHlYWStnQlJoSWRvVS8w?=
 =?utf-8?B?bk9ySDd4d2NCUXhwTmQ0dWs2eFlYb2JuSGlpbkV5MjZWZ20rN3JSRjVBbm9C?=
 =?utf-8?B?aXFXTFN0dE1ONEZ2c3FRTVdxdkhMT0xLdFVVMk1FekR3aGs1SlRUM1lsbXRZ?=
 =?utf-8?B?MTJ0aGxQdGUrRnpkbWRmK1hLbVh5QUZDaGtCQWhtSHJWQldUWTZnMEZLZEZi?=
 =?utf-8?B?N1FDUzdGSFhBK2Y0bWlTanl5U3A2M2NnNDFnREtYU0FNRUhEaDIrMG53V1hp?=
 =?utf-8?B?SnBNS2lGaE5SUnRUVVdLYUMwaW5OQ2JFaXFJZ1dNd21NNW1SVmhXTUhDN3NL?=
 =?utf-8?B?UjJ6UXprM1dXTFJZblc4WHhKd0NqeVVKaDd6dUdyZnVuZXQrOEk4SnE1S1ly?=
 =?utf-8?B?MVZzMU9Gc29LTWhyWWtrb0EwOEwyckRQUFdBeW0yQndqSThWZ2Q3RGMzMXBu?=
 =?utf-8?B?R3V6Mmtnd1BkYzN0U1IzMGVCcnpLTzg5dzY4a3E5akdnLzJpSG13SlgwMUph?=
 =?utf-8?B?ODNPdVRYekxvUkFVMWdzaEMvQk8vNmJYM2dGTnNVQlpvWDE3aUZXL2VaTEZ4?=
 =?utf-8?B?MCtiZlBDWXR3MmNJWmg0YXVlVVA5WWdyM0poU0hodGNyRGpMWmI4U1EwcnJM?=
 =?utf-8?B?UzVEcDlZMGN5U3NzVk83bDlRejVJajJ0VWpYeXVHekhWU1BpamNYQjYwM1Fm?=
 =?utf-8?B?RUkvSHk4RzVWWUFPVVFRN1l1TnhYTVN4SkNrUGZHMDlMTWVuZUQ4NlN2YmNV?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <399B7822A9F63247971EE0C9F0A2BF59@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7babb4-11f2-4e8f-9776-08dbc6546039
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 10:09:49.6640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZIpedte8rQcU2rqrOYAJDVmiMFhGSXkHBR6N2BVt/2iwotivpIGkTMxC3B9F5Oo8zXxDOzBJz7BYuUdzPR6tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8359
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.257800-8.000000
X-TMASE-MatchedRID: 6lay9u8oTUNjbyiFvYNuKLhzZI/dfrdOjLOy13Cgb4/n0eNPmPPe5KWz
        WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2bc297PAGtWakIbxK0FmxqwqAIpMpi6Gd6IO
        4BLC7c+cUPm/3TsFL+sEqngjgYPGiD/bCg+XzMaBor4yxPAz7WUJWAS69Pr/+cVGXoLjwQ0Huwi
        N5DeT7Jbt6c3FViD8d7GPWdSUjJ8o1BACrQFB3pVz+axQLnAVBuoYFb0nRiqPOxDyJFXIPjgQHT
        64gg+vfcODoO2WaU5WJ3PevIp+3D302CIWujuz8wCZxkTHxccm1k3bRIdXVNAZbeEWcL03VP6oE
        tFD/y1cag3VgO8sYrfx9tANXjexl0x3/HP06C9wpoxDq3DugMkyQ5fRSh265h5Q1ArtCPly+Unf
        56ZSSHOLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.257800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9B8EDD47C14CA301546DE8559DC0039547AF4181B98FBEABDF23F4B6FB83FD4D2000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENoZW4teXU6DQoNCk9uIFdlZCwgMjAyMy0xMC0wNCBhdCAxNjozMiArMDgwMCwgQ2hlbi1Z
dSBUc2FpIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIFRoZSBNZWRpYVRlayBEUk0gZHJpdmVyIGlt
cGxlbWVudHMgR0VNIFBSSU1FIHZtYXAgYnkgZmV0Y2hpbmcgdGhlDQo+IHNnX3RhYmxlIGZvciB0
aGUgb2JqZWN0LCBpdGVyYXRpbmcgdGhyb3VnaCB0aGUgcGFnZXMsIGFuZCB0aGVuDQo+IHZtYXBw
aW5nIHRoZW0uIEluIGVzc2VuY2UsIHVubGlrZSB0aGUgR0VNIERNQSBoZWxwZXJzIHdoaWNoIHZt
YXANCj4gd2hlbiB0aGUgb2JqZWN0IGlzIGZpcnN0IGNyZWF0ZWQgb3IgaW1wb3J0ZWQsIHRoZSBN
ZWRpYVRlayB2ZXJzaW9uDQo+IGRvZXMgaXQgb24gcmVxdWVzdC4NCj4gDQo+IFVuZm9ydHVuYXRl
bHksIHRoZSBjb2RlIG5ldmVyIGNvcnJlY3RseSBmcmVlcyB0aGUgc2dfdGFibGUgY29udGVudHMu
DQo+IFRoaXMgcmVzdWx0cyBpbiBhIGtlcm5lbCBtZW1vcnkgbGVhay4gT24gYSBIYXlhdG8gZGV2
aWNlIHdpdGggYSB0ZXh0DQo+IGNvbnNvbGUgb24gdGhlIGludGVybmFsIGRpc3BsYXksIHRoaXMg
cmVzdWx0cyBpbiB0aGUgc3lzdGVtIHJ1bm5pbmcNCj4gb3V0IG9mIG1lbW9yeSBpbiBhIGZldyBk
YXlzIGZyb20gYWxsIHRoZSBjb25zb2xlIHNjcmVlbiBjdXJzb3INCj4gdXBkYXRlcy4NCj4gDQo+
IEFkZCBzZ19mcmVlX3RhYmxlKCkgdG8gY29ycmVjdGx5IGZyZWUgdGhlIGNvbnRlbnRzIG9mIHRo
ZSBzZ190YWJsZS4NCj4gVGhpcw0KPiB3YXMgbWlzc2luZyBkZXNwaXRlIGV4cGxpY2l0bHkgcmVx
dWlyZWQgYnkNCj4gbXRrX2dlbV9wcmltZV9nZXRfc2dfdGFibGUoKS4NCj4gDQo+IEFsc28gbW92
ZSB0aGUgIm91dCIgc2hvcnRjdXQgbGFiZWwgdG8gYWZ0ZXIgdGhlIGtmcmVlKCkgY2FsbCBmb3Ig
dGhlDQo+IHNnX3RhYmxlLiBIYXZpbmcgc2dfZnJlZV90YWJsZSgpIHRvZ2V0aGVyIHdpdGgga2Zy
ZWUoKSBtYWtlcyBtb3JlDQo+IHNlbnNlLg0KPiBUaGUgc2hvcnRjdXQgaXMgb25seSB1c2VkIHdo
ZW4gdGhlIG9iamVjdCBhbHJlYWR5IGhhcyBhIGtlcm5lbA0KPiBhZGRyZXNzLA0KPiBpbiB3aGlj
aCBjYXNlIHRoZSBwb2ludGVyIGlzIE5VTEwgYW5kIGtmcmVlKCkgZG9lcyBub3RoaW5nLiBIZW5j
ZQ0KPiB0aGlzDQo+IGNoYW5nZSBjYXVzZXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQoNClJldmll
d2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBGaXhlczogM2RmNjRk
N2IwYTRmICgiZHJtL21lZGlhdGVrOiBJbXBsZW1lbnQgZ2VtIHByaW1lIHZtYXAvdnVubWFwDQo+
IGZ1bmN0aW9uIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnN0QGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IFBsZWFzZSBt
ZXJnZSBmb3IgdjYuNiBmaXhlcy4NCj4gDQo+IEFsc28sIEkgd2FzIHdvbmRlcmluZyB3aHkgdGhl
IE1lZGlhVGVrIERSTSBkcml2ZXIgaW1wbGVtZW50cyBhIGxvdCBvZg0KPiB0aGUgR0VNIGZ1bmN0
aW9uYWxpdHkgaXRzZWxmLCBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBHRU0gRE1BIGhlbHBlcnMuDQo+
IEZyb20gd2hhdCBJIGNvdWxkIHRlbGwsIHRoZSBjb2RlIGNsb3NlbHkgZm9sbG93cyB0aGUgRE1B
IGhlbHBlcnMsDQo+IGV4Y2VwdA0KPiB0aGF0IGl0IHZtYXBzIHRoZSBidWZmZXJzIG9ubHkgdXBv
biByZXF1ZXN0Lg0KDQpUaGUgcmVhc29uIGlzIHRoYXQgcHJpdi0+ZG1hX2RldiBpcyBkaWZmZXJl
bnQgd2l0aCBkcm1fZGV2LCBzbyBNZWRpYVRlaw0KRFJNIGRyaXZlciBoYXZlIHRvIGltcGxlbWVu
dCBpdHMgb3duIGZ1bmN0aW9uLiBFeHlub3MgRFJNIGRyaXZlciBhbHNvDQpoYXMgdGhpcyBwcm9i
bGVtLCBzbyBpdCdzIHdlbGNvbWUgYW55b25lIHRvIHNpbXBsaWZ5IGJvdGggRFJNIGRyaXZlci4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9nZW0uYyB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZ2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0u
Yw0KPiBpbmRleCA5ZjM2NGRmNTI0NzguLjBlMGE0MWIyZjU3ZiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gQEAgLTIzOSw2ICsyMzksNyBAQCBpbnQgbXRr
X2RybV9nZW1fcHJpbWVfdm1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QNCj4gKm9iaiwgc3RydWN0
IGlvc3lzX21hcCAqbWFwKQ0KPiAgCW5wYWdlcyA9IG9iai0+c2l6ZSA+PiBQQUdFX1NISUZUOw0K
PiAgCW10a19nZW0tPnBhZ2VzID0ga2NhbGxvYyhucGFnZXMsIHNpemVvZigqbXRrX2dlbS0+cGFn
ZXMpLA0KPiBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIW10a19nZW0tPnBhZ2VzKSB7DQo+ICsJCXNn
X2ZyZWVfdGFibGUoc2d0KTsNCj4gIAkJa2ZyZWUoc2d0KTsNCj4gIAkJcmV0dXJuIC1FTk9NRU07
DQo+ICAJfQ0KPiBAQCAtMjQ4LDEyICsyNDksMTUgQEAgaW50IG10a19kcm1fZ2VtX3ByaW1lX3Zt
YXAoc3RydWN0DQo+IGRybV9nZW1fb2JqZWN0ICpvYmosIHN0cnVjdCBpb3N5c19tYXAgKm1hcCkN
Cj4gIAltdGtfZ2VtLT5rdmFkZHIgPSB2bWFwKG10a19nZW0tPnBhZ2VzLCBucGFnZXMsIFZNX01B
UCwNCj4gIAkJCSAgICAgICBwZ3Byb3Rfd3JpdGVjb21iaW5lKFBBR0VfS0VSTkVMKSk7DQo+ICAJ
aWYgKCFtdGtfZ2VtLT5rdmFkZHIpIHsNCj4gKwkJc2dfZnJlZV90YWJsZShzZ3QpOw0KPiAgCQlr
ZnJlZShzZ3QpOw0KPiAgCQlrZnJlZShtdGtfZ2VtLT5wYWdlcyk7DQo+ICAJCXJldHVybiAtRU5P
TUVNOw0KPiAgCX0NCj4gLW91dDoNCj4gKwlzZ19mcmVlX3RhYmxlKHNndCk7DQo+ICAJa2ZyZWUo
c2d0KTsNCj4gKw0KPiArb3V0Og0KPiAgCWlvc3lzX21hcF9zZXRfdmFkZHIobWFwLCBtdGtfZ2Vt
LT5rdmFkZHIpOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjQyLjAuNTgyLmc4Y2Nk
MjBkNzBkLWdvb2cNCg==
