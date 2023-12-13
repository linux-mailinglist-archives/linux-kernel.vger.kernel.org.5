Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9981080C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378275AbjLMCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378297AbjLMCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:16:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7AEAF;
        Tue, 12 Dec 2023 18:16:49 -0800 (PST)
X-UUID: a8da69ae995d11eea5db2bebc7c28f94-20231213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=IqY5Md5O1f7vIoQFgC2t1OPF59iHm+75Nbuox0fCq0s=;
        b=ohEkbvldvlqp0Dt8IK8nuwbms5csEys+55y24SNDkNUj63V0Z0/GCH/OIIKb/fZnkFD+zdiMqPcaNikSZD6YDxOhCABG7McPfxXVAt0Oz4I5NpSmPNwF7/OUTEVIst18AtSVag5PIwByXtTJekSW35McpICXrNjIUI5sNETMc1Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5b3e4312-2bce-49d9-9e89-23ac8c5ebe13,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:26572161-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8da69ae995d11eea5db2bebc7c28f94-20231213
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1950136631; Wed, 13 Dec 2023 10:16:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Dec 2023 10:16:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Dec 2023 10:16:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR83irdzf0UxrSn8pV0p9Y9c76HRw3hrCYplIcmrVPg7RegWjyAq/0Tl0AHAC21qM1p68mbVt0Sh4Giau3VxWoO0YivvUoocP6OLXxu9kncviZPhOCQrSdU2x+yH06YfJ443BTuMUyWvFpJxDYx/quuftf2zGJHgZxEGjMQxXhiC0071mZzWxsxjv/tnU/2zaDA7UhN+WRcn0SAot78H0kWv7PGnwgOGo8P19XJsGa2+zHOkNvAr5A1DF96LAf0GIujVZrA7F350G/LRHqmi82iLrMpfsxtCahAzv4xlJCS9j2Uy+juvNok11MwY9zKp9RChgg20vmY8LRNn2YcCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqY5Md5O1f7vIoQFgC2t1OPF59iHm+75Nbuox0fCq0s=;
 b=cSja7aybvGbI8X4JzTfMltsW5qi6j5wtgGsM9bPBzgTNYAMge63IBmTtJxaMNDlRjPU8e1K8HOy++/luscQ6p83cPtSiTn+bAgDtjuVRStP/1JFj1wMJlLzIPhxOWKJib7/kauzSWb1++J2B+BZRAffoUn8Qb9R4Vnc35yGp4d/K8gizdmNp0L6WtlqYSyzJg43oQINkNkHj5HjJW2WQk5G/k5EJrloOd3VWK/TuGyMktH2DlIFvgTxW3OGmLHsTmKHc+jfGrPhI5f3TzG9neK5euO3dSzc4Fi7PF7uDACfng6QZnClf9g53ebK8DT0PBVH87bWKJqSL7d8cAT6Eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqY5Md5O1f7vIoQFgC2t1OPF59iHm+75Nbuox0fCq0s=;
 b=o4Dsx0UtHfT5mJW9mZmUlyX74LPPpIzwdR0uNVKjTPn17/ivG1mlmQRMYzprwexRS+hZ6w1hlTg/4g+Pzxx8HvJ7tZCcNRZY3jUpzLKAtsWWs/zkygPNSxHYmTch+RF3eE8sTEgFWJZD8fvKNCgU2qpGy+73qvBc23InkSiK9Rw=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SEZPR03MB8931.apcprd03.prod.outlook.com (2603:1096:101:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:13:11 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 02:13:10 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= 
        <Mark-MC.Lee@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "lynxis@fe80.eu" <lynxis@fe80.eu>,
        "dqfext@gmail.com" <dqfext@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= 
        <Weijie.Gao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?= 
        <SkyLake.Huang@mediatek.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john@phrozen.org" <john@phrozen.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next v3 2/8] phy: add driver for MediaTek pextp
 10GE SerDes PHY
Thread-Topic: [RFC PATCH net-next v3 2/8] phy: add driver for MediaTek pextp
 10GE SerDes PHY
Thread-Index: AQHaLK4V9cHJRF5XD0qlmI2MZjuVVbCldiIAgAEEVoA=
Date:   Wed, 13 Dec 2023 02:13:10 +0000
Message-ID: <d54e1438f6d18d0c3e9ad6493903a3434c7fcd3c.camel@mediatek.com>
References: <cover.1702352117.git.daniel@makrotopia.org>
         <a58dae1cce1b49093b0ae05159c784a9ec02f058.1702352117.git.daniel@makrotopia.org>
         <d5d0d01f-7df1-451a-a4bc-4c85f31b03db@collabora.com>
In-Reply-To: <d5d0d01f-7df1-451a-a4bc-4c85f31b03db@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SEZPR03MB8931:EE_
x-ms-office365-filtering-correlation-id: e7accf42-62c3-4e5c-3e0d-08dbfb810e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 63ZhrLPgERDqe0NozehxrDEQV6s7nv5VWCqSdf5LmXRX17xZ6AXjZezBlbOX/s7A39LZTFhYiGKWbGa1fdDGMS/Rw6Tb+lEpqwac8Z8Ud73ycq7MGluGklLw+8/MjrHaVlKPKyovDZOZUI/HY8OrZAhoeRjdqRJNkum7SvInbOpHs6pFBMwZqRCU58KchWiFU7uOY/yl+HO1661GdrhHy5h6gjgtyQfT42ixIEq5gWjjT3cYBaE7CQBP98U1s0kWWGS0Y2T2ynXTSleBXN2NZq0tL70BRbT76QpVsrv8dmFoO6i/XmYRlHmLBGjftEmFtB3IDg8ZQPkYGdj1UGdD/RXcB6v/cLXvaVEf6Yu9MNyAwxImCbftJrIy4m9hk/LLxKraKQbSndhnFoi8Y+mKbWfHKUSdh3kkS8KA3Qh/R9PjRhSQsT39MkOSIDeq1Js+4WVrT72onOgyPlEhiGpYRShqoCxUagaQrcI8kCDrmTSXnSgi2qfP8W/gDeNrO4ZT/E3W5Gp/gTMuILhFOMRcxLopgifdWoLzdP01Ct6/XYg60ScJED9RrJUItURznY171sJd4bQdm0YFI6XH/CveM3IX/CNey7rpdbKaxK110ZHibKyTkO4V2qnmwhLFow6gCRDkSsam/2L9y8FO2SP3+LoexOfSXjHqFllK+yAo2PTmIhIedamkS71FuiQPIdZtdXZ/vzrGcEei3cY8ECzLaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(41300700001)(26005)(71200400001)(38100700002)(122000001)(8936002)(316002)(64756008)(8676002)(7416002)(30864003)(2906002)(4001150100001)(5660300002)(66446008)(66556008)(478600001)(2616005)(6512007)(6506007)(66476007)(66946007)(76116006)(91956017)(110136005)(6486002)(921008)(36756003)(85182001)(86362001)(38070700009)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGNzaHlkRHNKZE9DVUl1TDh2ZDhMR1E1dnhQVHlkcjl4Vlp0MlZpS0grdFpT?=
 =?utf-8?B?d2tWWEhjWmJLcjg3bm9idUtmTk5xOTVJY1crd29tWmdmN3BLQndnaGpQcjIx?=
 =?utf-8?B?L0lsRkdaSWM1WENoTEFSdGk1TXNlOHNkdmdjUjRVYWFLZEdYWWVqZ0RDNVBL?=
 =?utf-8?B?K3Y3SGRCWFIvbkpFd3lIak90bXVHcUc4Qk5HdDlKUElxMGdpWWMzQ2xqVEFE?=
 =?utf-8?B?VGVqZzFxMUdILzZLRmtpcGN0QnBVMlVBY1lyR3k0M2RnMHZqYWM3NUYvT3VV?=
 =?utf-8?B?WGVtT0UxWUhyMTBLZ1lkaW9hMGtHSlJhNDA2bW03YU52WDZQMy9XYlhHdmty?=
 =?utf-8?B?NmtJaFRpakdnblFRWEtRbzlhODVVTlJhZzFReFp0eWFkL3BLM3BrL1R6QXBV?=
 =?utf-8?B?K2JTdXV1dFEyQmZtL0g2NXVmUWJMQjI3YmEwWTM1OC8zSW9EODV4WVUwQXVh?=
 =?utf-8?B?SHFHVFpXQnRTUjh1RnJVT2t1UCtsN3Q1T0JFbHpERFdsbmJ6UlUyMXY1OEY5?=
 =?utf-8?B?Rk5jdE80VEdyR2ltZEFkNEpFVEtob2I2cFBCc1l3cmVHT3FycUVyMUpISzda?=
 =?utf-8?B?VUE3aXU1cXhLRUl2MnhORkI2M3JvVDJISEV2ZTZ2S05MMGlPU1oraWFtT2V5?=
 =?utf-8?B?NDI5Rk82WXJvcHJzVUovanorTmd1bXg0cUhWMDhjR3BXaUhZMGIvQjZicDFM?=
 =?utf-8?B?TzlmR3BuVWlEblFtMmhldmRmSDZ6V3RaV3BlbHdPbFpLYkhYMzZnUFB6QUFG?=
 =?utf-8?B?K3VWa2hIRlRveXQrVUx2MnRmUk1CQlVvQlppcktDTkJsUWJwV25DR1VsZlpn?=
 =?utf-8?B?ajQ2aUVzcnFKWGhQU0FFVU1HRTlpVmJIUGhReWF6dVVlampmb1BhNDdUYWwx?=
 =?utf-8?B?T09CVEtWRmdYZ25jc0V2elVWZVdRcGlnd1dJK1hIdHAxOTU3L25yVHlucWVU?=
 =?utf-8?B?cEcvWUFYQWVHVVNwdDVHMzlwbTc4clRvQ21jQVdqaUx1K3dGOWEzQVR1NWVx?=
 =?utf-8?B?RDUwZlMrVWZvamJESThhcFYwRlkzcTVoK1Z1MHFzVjExR3dKMFp6eGlKYVFT?=
 =?utf-8?B?akcwWUpMM0ovS2dUYS8raTdvVEFCclBKMDdySVNUU1FvTFE5NXp3RC9hd2FN?=
 =?utf-8?B?TDVEQU5uRmMwQjlHUUpad3hEb25BVmluRmdnMFpUOGNsREdEaWpwS2sxT0g2?=
 =?utf-8?B?M3JTaVJhNGtzenVoRTF5TkR4c3A4VUxGcy9iSzQ0SU8xWlhtZ1RIWDJJMWwv?=
 =?utf-8?B?MG94eUhXUHBhcXM4SkljcjFDSmxiT0NyS3d2Zy9rVm1tYTc5ODVVQ2YyQi9q?=
 =?utf-8?B?N1J4cHpVa3l6VGxVSXlzQXhhRE9TWVpFYmdqSElHeU83cUFKaC81dEFhUmRa?=
 =?utf-8?B?YW1MNVVmdDZqSEhZc3ZwVzhWNG9kZnRMSk0xejh6YXlJbFNaUm1jMktHNllD?=
 =?utf-8?B?alN5ckRrZ0tnSkFmTlQ1QXlicGpMMHFYMU50bGJzb2JMdEtvdnYwcTlUQWZ2?=
 =?utf-8?B?OGZWTk5VdmwxakUrbXdjUElleittY3hXYm9XL2FqNXhxNHJYRWVkNXpNVmFJ?=
 =?utf-8?B?QWxyandJQVNRKzJtN1YyeVZTa2cvUFR0YTk5NmE3VVFNb3poNFBTa3R3bXZL?=
 =?utf-8?B?NFF1WjMzcHNJa1hGZTZwY2RzK1BIMENYczhSTUNvd0NURkFrOU5XZUYyc0h5?=
 =?utf-8?B?Z3RLSmlrcUN3aWhRR0NkNE9teDRQRXFkVWlaZndFbzNmRnR5V1k0UlZWejdJ?=
 =?utf-8?B?MlRmN3JTWWxQelpTTWtzd2hpMFpjSURFUTVwM2N5TU5kWmx2M2xDU3hJUnFC?=
 =?utf-8?B?MXlFa1NXQ2dJanBzZkhkVExVV0V5Z0Z6WE44dUplalo2NG1RSmMwQ2JKRFVG?=
 =?utf-8?B?a0NOeHJrbncydWsvRmtrS2duRlowV3ZiY2NyUUZGalo4ZGwrenBFUEtJT1Jz?=
 =?utf-8?B?YUtmUVlhTS8zWGRPQjdpQ2FyWW40SDJNV3ZXUS96YTJucVl4R3B6NjdNWm50?=
 =?utf-8?B?Z0ZPZVBMOWRMbTBsVEVxTXVpb3loRnZ4RmthRnp5Ti9uV0VVaTNFbVZIVjFL?=
 =?utf-8?B?K3VpQ2pkTDNMbFIxTlYvcHZRR0VpWG11MUlRUUM0SXBGUVBzeFlyNzdQdGdC?=
 =?utf-8?B?eFBGVnlZcmROMmYxZjlrOG05TGpXUFpJVU1naWcybkJNM3RMbmx0bzl1TWhv?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62F9E7F4D100E42ACEF01812F182509@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7accf42-62c3-4e5c-3e0d-08dbfb810e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:13:10.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkfBb/PsAAjH5rN8a4CkMTGOJSnpMEdlQSpT3tswtdvHVeE7SX6RcE436dP8DftvfiKfe+6RnTVg4RY9Z83p996ZT/yUyoiAaYIEQomPNvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8931
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.487700-8.000000
X-TMASE-MatchedRID: /nPNxfnsEhPUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
        bY7xfgXY9KE7L0nJx0rhihMBM8ipLJ4dOTBCL+zXWteDSXCrUTQZKp0SZ4P+dbv408/GP5Hqllx
        kRtI36f1dQO8rFsU1Cc5CUAhTWIIeXoZZdCbQG2F0BEBFOTiHn/7KE7XIKgt81moAkqFfNP6Arq
        oIZrVn15L+1nZr9xfjLZyDzqFlWlAXNVPhBUtpssnUT+eskUQPzV4D+5YmeSK67Q3uPo9KI3md+
        25VkQsz86lfaWv1uB5BhYDtId/lrMEIemFKn0+SGRqzqLQxuk6P/EshoNKyESHxdv8hOo8bq257
        wzawCztyLoBTJinK38HWcCMGec7ZwdbU3akH5AwdxBAG5/hkW5naxzJFBx6v82HMiBe0UlXJv31
        pIEp7kQmKAKAPPRzxMFGjWhwUm9sF5e8Prq/HpdigeTkdjx3h5TbwqVVpF+PczkKO5k4APkH8Bv
        ERi2dU4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.487700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E89F5FB52F5EBDE43CEEBDD585AE9F769C8230C3BA93BAB7AF5E8DABAC806BBB2000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEyLTEyIGF0IDExOjQxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTIvMTIvMjMgMDQ6NDYsIERhbmllbCBHb2xsZSBoYSBzY3JpdHRv
Og0KPiA+IEFkZCBkcml2ZXIgZm9yIE1lZGlhVGVrJ3MgcGV4dHAgMTAgR2lnYWJpdC9zIEV0aGVy
bmV0IFNlckRlcyBQSFkNCj4gPiB3aGljaA0KPiA+IGNhbiBiZSBmb3VuZCBpbiB0aGUgTVQ3OTg4
IFNvQy4NCj4gPiANCj4gPiBUaGUgUEhZIGNhbiBvcGVyYXRlcyBvbmx5IGluIFBIWV9NT0RFX0VU
SEVSTkVULCB0aGUgc3VibW9kZSBpcyBvbmUNCj4gPiBvZg0KPiA+IFBIWV9JTlRFUkZBQ0VfTU9E
RV8qIGNvcnJlc3BvbmRpbmcgdG8gdGhlIHN1cHBvcnRlZCBtb2RlczoNCj4gPiANCj4gPiAgICog
VVNYR01JSQ0KPiA+ICAgKiAxMEdCYXNlLVINCj4gPiAgICogNUdCYXNlLVINCj4gPiAgICogMjUw
MEJhc2UtWA0KPiA+ICAgKiAxMDAwQmFzZS1YDQo+ID4gICAqIENpc2NvIFNHTUlJIChNQUMgc2lk
ZSkNCj4gPiANCj4gPiBJbiBvcmRlciB0byB3b3JrLWFyb3VuZCBhIHBlcmZvcm1hbmNlIGlzc3Vl
IHByZXNlbnQgb24gdGhlIGZpcnN0IG9mDQo+ID4gdHdvIFBFWFRQIHByZXNlbnQgaW4gTVQ3OTg4
IHNwZWNpYWwgdHVuaW5nIGlzIGFwcGxpZWQgd2hpY2ggY2FuIGJlDQo+ID4gc2VsZWN0ZWQgYnkg
YWRkaW5nIHRoZSBtZWRpYXRlayx1c3hnbWlpLXBlcmZvcm1hbmNlLWVycmF0YSBwcm9wZXJ0eQ0K
PiA+IHRvDQo+ID4gdGhlIGRldmljZSB0cmVlIG5vZGUuDQo+ID4gDQo+ID4gVGhlcmUgaXMgbm8g
ZG9jdW1lbnRhdGlvbiB3aGF0LXNvLWV2ZXIgZm9yIHRoZSBwZXh0cCByZWdpc3RlcnMgYW5kDQo+
ID4gdGhpcyBkcml2ZXIgaXMgYmFzZWQgb24gYSBHUEwgbGljZW5zZWQgaW1wbGVtZW50YXRpb24g
Zm91bmQgaW4NCj4gPiBNZWRpYVRlaydzIFNESy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlhLm9yZz4NCj4gPiAtLS0NCj4gDQo+IC4uc25p
cC4uDQo+IA0KPiBDYW4gYW55b25lIGZyb20gTWVkaWFUZWsgKipwbGVhc2UqKiBkZWZpbmUgdGhv
c2UgcmVnaXN0ZXJzIGFuZA0KPiBmaWVsZHM/DQpJIGRpc2N1c3NlZCB3aXRoIG15IHNvZnR3YXJl
IGNvd29ya2VyIHdobyBhbHNvIGRvbid0IGhhdmUgcmVnaXN0ZXIgbWFwDQpkb2MsIG5lZWQgb3Vy
IGhhcmR3YXJlIGRlc2lnbmVyIGhlbHAgdG8gcHJvdmlkZSB0aGUgbmFtZXMgb2YgdGhlc2UNCnJl
Z2lzdGVyIGFuZCBmaWVsZHMuDQoNClRoYW5rcw0KPiANCj4gSW4gdGhpcyBmb3JtLCB0aGlzIGRy
aXZlciBpcyBwcmV0dHkgb2JzY3VyZSBhbmQgbm9ib2R5IGtub3dzIHdoYXQNCj4gaXQncyBkb2lu
ZzsNCj4gcGxlYXNlIHJlbWVtYmVyIHRoYXQsIGJ5IGFjdHVhbGx5IHByb3ZpZGluZyBhIGRlZmlu
aXRpb24gZm9yIHRob3NlDQo+IHJlZ2lzdGVycyBhbmQNCj4gZmllbGRzLCB0aGUgb3BlcmF0aW9u
IChyZWxpYWJpbGl0eSkgb2YgdGhpcyBQSFkgbWF5IGJlIGltcHJvdmVkIGFuZA0KPiB0aGlzIGRy
aXZlcg0KPiB3aWxsIGJlIGFjdHVhbGx5IG1haW50YWluYWJsZSAoYW5kIHBvc3NpYmx5IHN1cHBv
cnQgbW9yZSB0aGFuIG9uZQ0KPiB2YXJpYXRpb24gb2YNCj4gdGhpcyBQSFkgaW4gdGhlIGZ1dHVy
ZSB3aXRoIGxlc3MgZWZmb3J0cykuDQo+IA0KPiBNZWRpYVRlaz8NCj4gDQo+IFJlZ2FyZHMsDQo+
IEFuZ2Vsbw0KPiANCj4gPiArDQo+ID4gKwkvKiBTZXR1cCBvcGVyYXRpb24gbW9kZSAqLw0KPiA+
ICsJaWYgKGlzXzEwZykNCj4gPiArCQlpb3dyaXRlMzIoMHgwMGM5MDcxYywgcGV4dHAtPmJhc2Ug
KyAweDkwMjQpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWlvd3JpdGUzMigweDAwZDkwNzFjLCBwZXh0
cC0+YmFzZSArIDB4OTAyNCk7DQo+ID4gKw0KPiA+ICsJaWYgKGlzXzVnKQ0KPiA+ICsJCWlvd3Jp
dGUzMigweGFhYTVhNWFhLCBwZXh0cC0+YmFzZSArIDB4MjAyMCk7DQo+ID4gKwllbHNlDQo+ID4g
KwkJaW93cml0ZTMyKDB4YWE4NTg1YWEsIHBleHRwLT5iYXNlICsgMHgyMDIwKTsNCj4gPiArDQo+
ID4gKwlpZiAoaXNfMnA1ZyB8fCBpc181ZyB8fCBpc18xMGcpIHsNCj4gPiArCQlpb3dyaXRlMzIo
MHgwYzAyMDcwNywgcGV4dHAtPmJhc2UgKyAweDIwMzApOw0KPiA+ICsJCWlvd3JpdGUzMigweDBl
MDUwZjBmLCBwZXh0cC0+YmFzZSArIDB4MjAzNCk7DQo+ID4gKwkJaW93cml0ZTMyKDB4MDAxNDAw
MzIsIHBleHRwLT5iYXNlICsgMHgyMDQwKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaW93cml0
ZTMyKDB4MGMwMjAyMDcsIHBleHRwLT5iYXNlICsgMHgyMDMwKTsNCj4gPiArCQlpb3dyaXRlMzIo
MHgwZTA1MDUwZiwgcGV4dHAtPmJhc2UgKyAweDIwMzQpOw0KPiA+ICsJCWlvd3JpdGUzMigweDAw
MjAwMDMyLCBwZXh0cC0+YmFzZSArIDB4MjA0MCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYg
KGlzXzJwNWcgfHwgaXNfMTBnKQ0KPiA+ICsJCWlvd3JpdGUzMigweDAwYzAxNGFhLCBwZXh0cC0+
YmFzZSArIDB4NTBmMCk7DQo+ID4gKwllbHNlIGlmIChpc181ZykNCj4gPiArCQlpb3dyaXRlMzIo
MHgwMGMwMThhYSwgcGV4dHAtPmJhc2UgKyAweDUwZjApOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWlv
d3JpdGUzMigweDAwYzAxNGJhLCBwZXh0cC0+YmFzZSArIDB4NTBmMCk7DQo+ID4gKw0KPiA+ICsJ
aWYgKGlzXzVnKSB7DQo+ID4gKwkJaW93cml0ZTMyKDB4Mzc3NzgxMmIsIHBleHRwLT5iYXNlICsg
MHg1MGUwKTsNCj4gPiArCQlpb3dyaXRlMzIoMHgwMDVjOWNmZiwgcGV4dHAtPmJhc2UgKyAweDUw
NmMpOw0KPiA+ICsJCWlvd3JpdGUzMigweDlkZmFmYWZhLCBwZXh0cC0+YmFzZSArIDB4NTA3MCk7
DQo+ID4gKwkJaW93cml0ZTMyKDB4MjczZjNmM2YsIHBleHRwLT5iYXNlICsgMHg1MDc0KTsNCj4g
PiArCQlpb3dyaXRlMzIoMHhhODg4Mzg2OCwgcGV4dHAtPmJhc2UgKyAweDUwNzgpOw0KPiA+ICsJ
CWlvd3JpdGUzMigweDE0NjYxNDY2LCBwZXh0cC0+YmFzZSArIDB4NTA3Yyk7DQo+ID4gKwl9IGVs
c2Ugew0KPiA+ICsJCWlvd3JpdGUzMigweDM3NzdjMTJiLCBwZXh0cC0+YmFzZSArIDB4NTBlMCk7
DQo+ID4gKwkJaW93cml0ZTMyKDB4MDA1ZjljZmYsIHBleHRwLT5iYXNlICsgMHg1MDZjKTsNCj4g
PiArCQlpb3dyaXRlMzIoMHg5ZDlkZmFmYSwgcGV4dHAtPmJhc2UgKyAweDUwNzApOw0KPiA+ICsJ
CWlvd3JpdGUzMigweDI3MjczZjNmLCBwZXh0cC0+YmFzZSArIDB4NTA3NCk7DQo+ID4gKwkJaW93
cml0ZTMyKDB4YTc4ODNjNjgsIHBleHRwLT5iYXNlICsgMHg1MDc4KTsNCj4gPiArCQlpb3dyaXRl
MzIoMHgxMTY2MTE2NiwgcGV4dHAtPmJhc2UgKyAweDUwN2MpOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCWlmIChpc18ycDVnIHx8IGlzXzEwZykgew0KPiA+ICsJCWlvd3JpdGUzMigweDBlMDAwYWFm
LCBwZXh0cC0+YmFzZSArIDB4NTA4MCk7DQo+ID4gKwkJaW93cml0ZTMyKDB4MDgwODBkMGQsIHBl
eHRwLT5iYXNlICsgMHg1MDg0KTsNCj4gPiArCQlpb3dyaXRlMzIoMHgwMjAzMDkwOSwgcGV4dHAt
PmJhc2UgKyAweDUwODgpOw0KPiA+ICsJfSBlbHNlIGlmIChpc181Zykgew0KPiA+ICsJCWlvd3Jp
dGUzMigweDBlMDAxYWJmLCBwZXh0cC0+YmFzZSArIDB4NTA4MCk7DQo+ID4gKwkJaW93cml0ZTMy
KDB4MDgwYjBkMGQsIHBleHRwLT5iYXNlICsgMHg1MDg0KTsNCj4gPiArCQlpb3dyaXRlMzIoMHgw
MjA1MDkwOSwgcGV4dHAtPmJhc2UgKyAweDUwODgpOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlp
b3dyaXRlMzIoMHgwZTAwMGVhZiwgcGV4dHAtPmJhc2UgKyAweDUwODApOw0KPiA+ICsJCWlvd3Jp
dGUzMigweDA4MDgwZTBkLCBwZXh0cC0+YmFzZSArIDB4NTA4NCk7DQo+ID4gKwkJaW93cml0ZTMy
KDB4MDIwMzBiMDksIHBleHRwLT5iYXNlICsgMHg1MDg4KTsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlpZiAoaXNfNWcpIHsNCj4gPiArCQlpb3dyaXRlMzIoMHgwYzAwMDAwMCwgcGV4dHAtPmJhc2Ug
KyAweDUwZTQpOw0KPiA+ICsJCWlvd3JpdGUzMigweDA0MDAwMDAwLCBwZXh0cC0+YmFzZSArIDB4
NTBlOCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWlvd3JpdGUzMigweDBjMGMwMDAwLCBwZXh0
cC0+YmFzZSArIDB4NTBlNCk7DQo+ID4gKwkJaW93cml0ZTMyKDB4MDQwNDAwMDAsIHBleHRwLT5i
YXNlICsgMHg1MGU4KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoaXNfMnA1ZyB8fCBtdGtf
aW50ZXJmYWNlX21vZGVfaXNfeGdtaWkoaW50ZXJmYWNlKSkNCj4gPiArCQlpb3dyaXRlMzIoMHgw
ZjBmMGMwNiwgcGV4dHAtPmJhc2UgKyAweDUwZUMpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCWlvd3Jp
dGUzMigweDBmMGYwNjA2LCBwZXh0cC0+YmFzZSArIDB4NTBlQyk7DQo+ID4gKw0KPiA+ICsJaWYg
KGlzXzVnKSB7DQo+ID4gKwkJaW93cml0ZTMyKDB4NTA4MDhjOGMsIHBleHRwLT5iYXNlICsgMHg1
MGE4KTsNCj4gPiArCQlpb3dyaXRlMzIoMHgxODAwMDAwMCwgcGV4dHAtPmJhc2UgKyAweDYwMDQp
Ow0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlpb3dyaXRlMzIoMHg1MDZlOGM4YywgcGV4dHAtPmJh
c2UgKyAweDUwYTgpOw0KPiA+ICsJCWlvd3JpdGUzMigweDE4MTkwMDAwLCBwZXh0cC0+YmFzZSAr
IDB4NjAwNCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGlzXzEwZykNCj4gPiArCQlpb3dy
aXRlMzIoMHgwMTQyMzM0MiwgcGV4dHAtPmJhc2UgKyAweDAwZjgpOw0KPiA+ICsJZWxzZSBpZiAo
aXNfNWcpDQo+ID4gKwkJaW93cml0ZTMyKDB4MDBhMTMyYTEsIHBleHRwLT5iYXNlICsgMHgwMGY4
KTsNCj4gPiArCWVsc2UgaWYgKGlzXzJwNWcpDQo+ID4gKwkJaW93cml0ZTMyKDB4MDA5YzMyOWMs
IHBleHRwLT5iYXNlICsgMHgwMGY4KTsNCj4gPiArCWVsc2UNCj4gPiArCQlpb3dyaXRlMzIoMHgw
MGZhMzJmYSwgcGV4dHAtPmJhc2UgKyAweDAwZjgpOw0KPiA+ICsNCj4gPiArCS8qIEZvcmNlIFNH
RFRfT1VUIG9mZiBhbmQgc2VsZWN0IFBDUyAqLw0KPiA+ICsJaWYgKG10a19pbnRlcmZhY2VfbW9k
ZV9pc194Z21paShpbnRlcmZhY2UpKQ0KPiA+ICsJCWlvd3JpdGUzMigweDgwMjAxZjIwLCBwZXh0
cC0+YmFzZSArIDB4MDBmNCk7DQo+ID4gKwllbHNlDQo+ID4gKwkJaW93cml0ZTMyKDB4ODAyMDFm
MjEsIHBleHRwLT5iYXNlICsgMHgwMGY0KTsNCj4gPiArDQo+ID4gKwkvKiBGb3JjZSBHTEJfQ0tE
RVRfT1VUICovDQo+ID4gKwlpb3dyaXRlMzIoMHgwMDA1MGMwMCwgcGV4dHAtPmJhc2UgKyAweDAw
MzApOw0KPiA+ICsNCj4gPiArCS8qIEZvcmNlIEFFUSBvbiAqLw0KPiA+ICsJaW93cml0ZTMyKDB4
MDIwMDI4MDAsIHBleHRwLT5iYXNlICsgMHgwMDcwKTsNCj4gPiArCW5kZWxheSgxMDIwKTsNCj4g
PiArDQo+ID4gKwkvKiBTZXR1cCBEQSBkZWZhdWx0IHZhbHVlICovDQo+ID4gKwlpb3dyaXRlMzIo
MHgwMDAwMDAyMCwgcGV4dHAtPmJhc2UgKyAweDMwYjApOw0KPiA+ICsJaW93cml0ZTMyKDB4MDAw
MDhhMDEsIHBleHRwLT5iYXNlICsgMHgzMDI4KTsNCj4gPiArCWlvd3JpdGUzMigweDAwMDBhODg0
LCBwZXh0cC0+YmFzZSArIDB4MzAyYyk7DQo+ID4gKwlpb3dyaXRlMzIoMHgwMDA4MzAwMiwgcGV4
dHAtPmJhc2UgKyAweDMwMjQpOw0KPiA+ICsJaWYgKG10a19pbnRlcmZhY2VfbW9kZV9pc194Z21p
aShpbnRlcmZhY2UpKSB7DQo+ID4gKwkJaW93cml0ZTMyKDB4MDAwMjIyMjAsIHBleHRwLT5iYXNl
ICsgMHgzMDEwKTsNCj4gPiArCQlpb3dyaXRlMzIoMHgwZjAyMGEwMSwgcGV4dHAtPmJhc2UgKyAw
eDUwNjQpOw0KPiA+ICsJCWlvd3JpdGUzMigweDA2MTAwNjAwLCBwZXh0cC0+YmFzZSArIDB4NTBi
NCk7DQo+ID4gKwkJaWYgKGludGVyZmFjZSA9PSBQSFlfSU5URVJGQUNFX01PREVfVVNYR01JSSkN
Cj4gPiArCQkJaW93cml0ZTMyKDB4NDA3MDQwMDAsIHBleHRwLT5iYXNlICsgMHgzMDQ4KTsNCj4g
PiArCQllbHNlDQo+ID4gKwkJCWlvd3JpdGUzMigweDQ3Njg0MTAwLCBwZXh0cC0+YmFzZSArIDB4
MzA0OCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWlvd3JpdGUzMigweDAwMDExMTEwLCBwZXh0
cC0+YmFzZSArIDB4MzAxMCk7DQo+ID4gKwkJaW93cml0ZTMyKDB4NDA3MDQwMDAsIHBleHRwLT5i
YXNlICsgMHgzMDQ4KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoIW10a19pbnRlcmZhY2Vf
bW9kZV9pc194Z21paShpbnRlcmZhY2UpICYmICFpc18ycDVnKQ0KPiA+ICsJCWlvd3JpdGUzMigw
eDAwMDBjMDAwLCBwZXh0cC0+YmFzZSArIDB4MzA2NCk7DQo+ID4gKw0KPiA+ICsJaWYgKGludGVy
ZmFjZSAhPSBQSFlfSU5URVJGQUNFX01PREVfMTBHQkFTRVIpIHsNCj4gPiArCQlpb3dyaXRlMzIo
MHhhODAwMDAwMCwgcGV4dHAtPmJhc2UgKyAweDMwNTApOw0KPiA+ICsJCWlvd3JpdGUzMigweDAw
MDAwMGFhLCBwZXh0cC0+YmFzZSArIDB4MzA1NCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCWlv
d3JpdGUzMigweDAwMDAwMDAwLCBwZXh0cC0+YmFzZSArIDB4MzA1MCk7DQo+ID4gKwkJaW93cml0
ZTMyKDB4MDAwMDAwMDAsIHBleHRwLT5iYXNlICsgMHgzMDU0KTsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlpZiAobXRrX2ludGVyZmFjZV9tb2RlX2lzX3hnbWlpKGludGVyZmFjZSkpDQo+ID4gKwkJ
aW93cml0ZTMyKDB4MDAwMDBmMDAsIHBleHRwLT5iYXNlICsgMHgzMDZjKTsNCj4gPiArCWVsc2Ug
aWYgKGlzXzJwNWcpDQo+ID4gKwkJaW93cml0ZTMyKDB4MjIwMDBmMDAsIHBleHRwLT5iYXNlICsg
MHgzMDZjKTsNCj4gPiArCWVsc2UNCj4gPiArCQlpb3dyaXRlMzIoMHgyMDIwMGYwMCwgcGV4dHAt
PmJhc2UgKyAweDMwNmMpOw0KPiA+ICsNCj4gPiArCWlmIChpbnRlcmZhY2UgPT0gUEhZX0lOVEVS
RkFDRV9NT0RFXzEwR0JBU0VSICYmIHBleHRwLT5kYV93YXIpDQo+ID4gKwkJaW93cml0ZTMyKDB4
MDAwN2I0MDAsIHBleHRwLT5iYXNlICsgMHhhMDA4KTsNCj4gPiArDQo+ID4gKwlpZiAobXRrX2lu
dGVyZmFjZV9tb2RlX2lzX3hnbWlpKGludGVyZmFjZSkpDQo+ID4gKwkJaW93cml0ZTMyKDB4MDAw
NDAwMDAsIHBleHRwLT5iYXNlICsgMHhhMDYwKTsNCj4gPiArCWVsc2UNCj4gPiArCQlpb3dyaXRl
MzIoMHgwMDA1MDAwMCwgcGV4dHAtPmJhc2UgKyAweGEwNjApOw0KPiA+ICsNCj4gPiArCWlmIChp
c18xMGcpDQo+ID4gKwkJaW93cml0ZTMyKDB4MDAwMDAwMDEsIHBleHRwLT5iYXNlICsgMHg5MGQw
KTsNCj4gPiArCWVsc2UgaWYgKGlzXzVnKQ0KPiA+ICsJCWlvd3JpdGUzMigweDAwMDAwMDAzLCBw
ZXh0cC0+YmFzZSArIDB4OTBkMCk7DQo+ID4gKwllbHNlIGlmIChpc18ycDVnKQ0KPiA+ICsJCWlv
d3JpdGUzMigweDAwMDAwMDA1LCBwZXh0cC0+YmFzZSArIDB4OTBkMCk7DQo+ID4gKwllbHNlDQo+
ID4gKwkJaW93cml0ZTMyKDB4MDAwMDAwMDcsIHBleHRwLT5iYXNlICsgMHg5MGQwKTsNCj4gPiAr
DQo+ID4gKwkvKiBSZWxlYXNlIHJlc2V0ICovDQo+ID4gKwlpb3dyaXRlMzIoMHgwMjAwZTgwMCwg
cGV4dHAtPmJhc2UgKyAweDAwNzApOw0KPiA+ICsJdXNsZWVwX3JhbmdlKDE1MCwgNTAwKTsNCj4g
PiArDQo+ID4gKwkvKiBTd2l0Y2ggdG8gUDAgKi8NCj4gPiArCWlvd3JpdGUzMigweDAyMDBjMTEx
LCBwZXh0cC0+YmFzZSArIDB4MDA3MCk7DQo+ID4gKwluZGVsYXkoMTAyMCk7DQo+ID4gKwlpb3dy
aXRlMzIoMHgwMjAwYzEwMSwgcGV4dHAtPmJhc2UgKyAweDAwNzApOw0KPiA+ICsJdXNsZWVwX3Jh
bmdlKDE1LCA1MCk7DQo+ID4gKw0KPiA+ICsJaWYgKG10a19pbnRlcmZhY2VfbW9kZV9pc194Z21p
aShpbnRlcmZhY2UpKSB7DQo+ID4gKwkJLyogU3dpdGNoIHRvIEdlbjMgKi8NCj4gPiArCQlpb3dy
aXRlMzIoMHgwMjAyYzExMSwgcGV4dHAtPmJhc2UgKyAweDAwNzApOw0KPiA+ICsJfSBlbHNlIHsN
Cj4gPiArCQkvKiBTd2l0Y2ggdG8gR2VuMiAqLw0KPiA+ICsJCWlvd3JpdGUzMigweDAyMDFjMTEx
LCBwZXh0cC0+YmFzZSArIDB4MDA3MCk7DQo+ID4gKwl9DQo+ID4gKwluZGVsYXkoMTAyMCk7DQo+
ID4gKwlpZiAobXRrX2ludGVyZmFjZV9tb2RlX2lzX3hnbWlpKGludGVyZmFjZSkpDQo+ID4gKwkJ
aW93cml0ZTMyKDB4MDIwMmMxMDEsIHBleHRwLT5iYXNlICsgMHgwMDcwKTsNCj4gPiArCWVsc2UN
Cj4gPiArCQlpb3dyaXRlMzIoMHgwMjAxYzEwMSwgcGV4dHAtPmJhc2UgKyAweDAwNzApOw0KPiA+
ICsJdXNsZWVwX3JhbmdlKDEwMCwgNTAwKTsNCj4gPiArCWlvd3JpdGUzMigweDAwMDAwMDMwLCBw
ZXh0cC0+YmFzZSArIDB4MzBiMCk7DQo+ID4gKwlpZiAobXRrX2ludGVyZmFjZV9tb2RlX2lzX3hn
bWlpKGludGVyZmFjZSkpDQo+ID4gKwkJaW93cml0ZTMyKDB4ODAyMDFmMDAsIHBleHRwLT5iYXNl
ICsgMHgwMGY0KTsNCj4gPiArCWVsc2UNCj4gPiArCQlpb3dyaXRlMzIoMHg4MDIwMWYwMSwgcGV4
dHAtPmJhc2UgKyAweDAwZjQpOw0KPiA+ICsNCj4gPiArCWlvd3JpdGUzMigweDMwMDAwMDAwLCBw
ZXh0cC0+YmFzZSArIDB4MzA0MCk7DQo+ID4gKwl1c2xlZXBfcmFuZ2UoNDAwLCAxMDAwKTsNCj4g
PiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfcGV4dHBfc2V0X21vZGUoc3RydWN0IHBo
eSAqcGh5LCBlbnVtIHBoeV9tb2RlIG1vZGUsDQo+ID4gaW50IHN1Ym1vZGUpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBtdGtfcGV4dHBfcGh5ICpwZXh0cCA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0K
PiA+ICsNCj4gPiArCWlmIChtb2RlICE9IFBIWV9NT0RFX0VUSEVSTkVUKQ0KPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCXN3aXRjaCAoc3VibW9kZSkgew0KPiA+ICsJY2FzZSBQ
SFlfSU5URVJGQUNFX01PREVfMTAwMEJBU0VYOg0KPiA+ICsJY2FzZSBQSFlfSU5URVJGQUNFX01P
REVfMjUwMEJBU0VYOg0KPiA+ICsJY2FzZSBQSFlfSU5URVJGQUNFX01PREVfU0dNSUk6DQo+ID4g
KwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV81R0JBU0VSOg0KPiA+ICsJY2FzZSBQSFlfSU5URVJG
QUNFX01PREVfMTBHQkFTRVI6DQo+ID4gKwljYXNlIFBIWV9JTlRFUkZBQ0VfTU9ERV9VU1hHTUlJ
Og0KPiA+ICsJCW10a19wZXh0cF9zZXR1cChwZXh0cCwgc3VibW9kZSk7DQo+ID4gKwkJcmV0dXJu
IDA7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19wZXh0cF9yZXNldChzdHJ1Y3QgcGh5ICpw
aHkpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdGtfcGV4dHBfcGh5ICpwZXh0cCA9IHBoeV9nZXRf
ZHJ2ZGF0YShwaHkpOw0KPiA+ICsNCj4gPiArCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBleHRwLT5y
ZXNldCk7DQo+ID4gKwl1c2xlZXBfcmFuZ2UoMTAwLCA1MDApOw0KPiA+ICsJcmVzZXRfY29udHJv
bF9kZWFzc2VydChwZXh0cC0+cmVzZXQpOw0KPiA+ICsJdXNsZWVwX3JhbmdlKDEsIDEwKTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtf
cGV4dHBfcG93ZXJfb24oc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRr
X3BleHRwX3BoeSAqcGV4dHAgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoTVRLX1BFWFRQX05VTV9DTE9DS1MsIHBleHRw
LQ0KPiA+ID5jbG9ja3MpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19wZXh0
cF9wb3dlcl9vZmYoc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX3Bl
eHRwX3BoeSAqcGV4dHAgPSBwaHlfZ2V0X2RydmRhdGEocGh5KTsNCj4gPiArDQo+ID4gKwljbGtf
YnVsa19kaXNhYmxlX3VucHJlcGFyZShNVEtfUEVYVFBfTlVNX0NMT0NLUywgcGV4dHAtDQo+ID4g
PmNsb2Nrcyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgcGh5X29wcyBtdGtfcGV4dHBfb3BzID0gew0KPiA+ICsJLnBvd2Vy
X29uCT0gbXRrX3BleHRwX3Bvd2VyX29uLA0KPiA+ICsJLnBvd2VyX29mZgk9IG10a19wZXh0cF9w
b3dlcl9vZmYsDQo+ID4gKwkuc2V0X21vZGUJPSBtdGtfcGV4dHBfc2V0X21vZGUsDQo+ID4gKwku
cmVzZXQJCT0gbXRrX3BleHRwX3Jlc2V0LA0KPiA+ICsJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtdGtfcGV4dHBfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpu
cCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3By
b3ZpZGVyOw0KPiA+ICsJc3RydWN0IG10a19wZXh0cF9waHkgKnBleHRwOw0KPiA+ICsJc3RydWN0
IHBoeSAqcGh5Ow0KPiA+ICsNCj4gPiArCWlmICghbnApDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7
DQo+ID4gKw0KPiA+ICsJcGV4dHAgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpw
ZXh0cCksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFwZXh0cCkNCj4gPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gPiArDQo+ID4gKwlwZXh0cC0+YmFzZSA9IGRldm1fb2ZfaW9tYXAoJnBkZXYtPmRl
diwgbnAsIDAsIE5VTEwpOw0KPiA+ICsJaWYgKCFwZXh0cC0+YmFzZSkNCj4gPiArCQlyZXR1cm4g
LUVJTzsNCj4gPiArDQo+ID4gKwlwZXh0cC0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArDQo+ID4g
KwlwZXh0cC0+Y2xvY2tzWzBdLmlkID0gInRvcHh0YWwiOw0KPiA+ICsJcGV4dHAtPmNsb2Nrc1sw
XS5jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgcGV4dHAtDQo+ID4gPmNsb2Nrc1swXS5p
ZCk7DQo+ID4gKwlpZiAoSVNfRVJSKHBleHRwLT5jbG9ja3NbMF0uY2xrKSkNCj4gPiArCQlyZXR1
cm4gUFRSX0VSUihwZXh0cC0+Y2xvY2tzWzBdLmNsayk7DQo+ID4gKw0KPiA+ICsJcGV4dHAtPmNs
b2Nrc1sxXS5pZCA9ICJ4ZmlwbGwiOw0KPiA+ICsJcGV4dHAtPmNsb2Nrc1sxXS5jbGsgPSBkZXZt
X2Nsa19nZXQoJnBkZXYtPmRldiwgcGV4dHAtDQo+ID4gPmNsb2Nrc1sxXS5pZCk7DQo+ID4gKwlp
ZiAoSVNfRVJSKHBleHRwLT5jbG9ja3NbMV0uY2xrKSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihw
ZXh0cC0+Y2xvY2tzWzFdLmNsayk7DQo+ID4gKw0KPiA+ICsJcGV4dHAtPnJlc2V0ID0gZGV2bV9y
ZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoJnBkZXYtPmRldiwNCj4gPiBOVUxMKTsNCj4gPiAr
CWlmIChJU19FUlIocGV4dHAtPnJlc2V0KSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihwZXh0cC0+
cmVzZXQpOw0KPiA+ICsNCj4gPiArCXBleHRwLT5kYV93YXIgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jv
b2wobnAsICJtZWRpYXRlayx1c3hnbWlpLQ0KPiA+IHBlcmZvcm1hbmNlLWVycmF0YSIpOw0KPiA+
ICsNCj4gPiArCXBoeSA9IGRldm1fcGh5X2NyZWF0ZSgmcGRldi0+ZGV2LCBOVUxMLCAmbXRrX3Bl
eHRwX29wcyk7DQo+ID4gKwlpZiAoSVNfRVJSKHBoeSkpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIo
cGh5KTsNCj4gPiArDQo+ID4gKwlwaHlfc2V0X2RydmRhdGEocGh5LCBwZXh0cCk7DQo+ID4gKw0K
PiA+ICsJcGh5X3Byb3ZpZGVyID0gZGV2bV9vZl9waHlfcHJvdmlkZXJfcmVnaXN0ZXIoJnBkZXYt
PmRldiwNCj4gPiBvZl9waHlfc2ltcGxlX3hsYXRlKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gUFRS
X0VSUl9PUl9aRVJPKHBoeV9wcm92aWRlcik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19wZXh0cF9tYXRjaFtdID0gew0KPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc5ODgteGZpLXBleHRwIiwgfSwNCj4gPiArCXsgfQ0K
PiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfcGV4dHBfbWF0Y2gpOw0K
PiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXRrX3BleHRwX2RyaXZl
ciA9IHsNCj4gPiArCS5wcm9iZSA9IG10a19wZXh0cF9wcm9iZSwNCj4gPiArCS5kcml2ZXIgPSB7
DQo+ID4gKwkJLm5hbWUgPSAibXRrLXBleHRwIiwNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBt
dGtfcGV4dHBfbWF0Y2gsDQo+ID4gKwl9LA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfcGxhdGZvcm1f
ZHJpdmVyKG10a19wZXh0cF9kcml2ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9O
KCJNZWRpYVRlayBwZXh0cCBTZXJEZXMgUEhZIGRyaXZlciIpOw0KPiA+ICtNT0RVTEVfQVVUSE9S
KCJEYW5pZWwgR29sbGUgPGRhbmllbEBtYWtyb3RvcGlhLm9yZz4iKTsNCj4gPiArTU9EVUxFX0xJ
Q0VOU0UoIkdQTCIpOw0KPiANCj4gDQo=
