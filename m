Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1076D0B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjHBO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjHBO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:57:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B2F196;
        Wed,  2 Aug 2023 07:57:05 -0700 (PDT)
X-UUID: d45ab8c6314411eeb20a276fd37b9834-20230802
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YFnsRWfDZHHeXs8O+fNMDv9ViF16Og5QGmf9pjck3dM=;
        b=ECxS5Ska9ITLTdvuRSQ3WpLA6ngFozHr2vpu4h+g5RwimxVoX5onV8Fk04QjWUkPeGVN+wf/MQfU6SZJaG8NDEV4T3aCXQli7ZYA3mC5dw9dxixQx4ybQSh6t8wexGGN54HfJfSXJesqoapRn8JEQ0fjO1hMHwdvBRnX2JfQQKA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:89e7df5d-b294-4efb-bd5d-2999e823e2b1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:1fcc6f8,CLOUDID:4493d1a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d45ab8c6314411eeb20a276fd37b9834-20230802
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1706678165; Wed, 02 Aug 2023 22:56:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Aug 2023 22:56:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Aug 2023 22:56:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvqYM0rGIeaCvjaTrgK9+4SgSD7F0UH9jMS1V8avihXN9XKnmTVWz2F7VrO1zPkz3F+vYGBd0lXpkU8TBJ2cJ7qhOCDKXFjHdGhMdBOiGi6r+91aQuHPd6GY8Ga2sQvrWEAoJ1ycKu1fyfUdL7fTsyqzyPtuwPe9UEl+Kjt+xhYim5rlOjrb2me2Znh4CqnWXdxTwMtc5uoeszyE5vCZw/Zer/qp/cOvrGdFHXh6x/09BGwQ6wkVF9dYxETwEACbAdRooNAAo0gMTRVTr4Y5mRYkSpAMoRZJoviiDcDVLP3K4f/Z7mgWIJCXkpv/iVkYSAW/YX4cDLhp0QlExn1KQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFnsRWfDZHHeXs8O+fNMDv9ViF16Og5QGmf9pjck3dM=;
 b=i0LPND3TRTqa3ireAKt+JYtAcqvzyAzZNpLuOOiVPHd0zgj7/YtvLXE26nM3YJEygvlH4up1HXSf+7r9PfgAT5vGNqJwGQfcluo+f+9HnaGziafuh20WRHmG8lSsRWv4T8d+/q50tjrGRFM8m7hb0bUvDxAtrB/iYs0CdgZBHmYgs3PaHu6x0fbYsPlCbNv+vqPaIElHg18SVHJ6pbyNwCakpGmbUdh6dyv9t+zGr3NhW/IJfMrG9zkCOU0ECFjE7pQQoU43OZd4cNkp24X1VPx4BceICRxj0ZiRH5ttfaKBPInBHs4qqNvhiigW7HoNe8Cb83kzLMF4R9TdM08RCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFnsRWfDZHHeXs8O+fNMDv9ViF16Og5QGmf9pjck3dM=;
 b=Uft8Ib7k274jQgDPliaEoTJx1rZEbg7xQwwdCgm6GAArgfcKxCF2T0kOKFfeQOHI4P6uJTnPRWHn8KEytlfzkU++toTBF3eikbcLip/xsReBqiQveT/g6bnK+eSSh77+lb0qVmRbPXUSZ/rqD+KkebN55rmLNihhwvvzcVQia8A=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SI2PR03MB5417.apcprd03.prod.outlook.com (2603:1096:4:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:56:54 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::b637:cc4e:c9bd:64d%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:56:52 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3,1/2] media: mediatek: vcodec: Fix possible invalid
 memory access for decoder
Thread-Topic: [PATCH v3,1/2] media: mediatek: vcodec: Fix possible invalid
 memory access for decoder
Thread-Index: AQHZwc940Dkt/5CrvE6t64UldQoic6/WuWqAgABmGQA=
Date:   Wed, 2 Aug 2023 14:56:52 +0000
Message-ID: <ea1c98e2c4a29d94fc382cfebc711d39c80b5092.camel@mediatek.com>
References: <20230729034735.17213-1-yunfei.dong@mediatek.com>
         <dca6f8c2-7d80-14fb-0090-7b10b1da13c2@xs4all.nl>
In-Reply-To: <dca6f8c2-7d80-14fb-0090-7b10b1da13c2@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SI2PR03MB5417:EE_
x-ms-office365-filtering-correlation-id: 3eb72b91-7473-4b7c-47c5-08db9368b4e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4j85sU60UNCJHg2FpE7HLyKVUz0gysjcE3i9vysQ3Bj7Ez1lWsfvMq+0XzCZn9P8vUjvMU6di4zQXZ61F1DmzPwFvswH9jf3rB/0Bix/XtMzaX3LO3gltjzN5OjOT9O3/wRWQk6J80Wl2gGuCtPR4x+cmoshejtDg2WR0oo7KND2zQIVj5nhBvxBVXdd14YmjrAexxglq6cE1iYU0zfxCZhfbjPlWsheci4ELFh2cjVJTrrr6vNtlow6SA+BfoWoIYOWNAVk3Oia7hbQPwoTspJH2M1tgeSGI6ssPZsCNwdPDVymWAzfwgpMMo1tivhIUGQqtmgnIOlJ3OWLNxRjQUSP3DhCricOq1unw+f4D3Zx7xWoa2lXiaVgIxgN87QctCBfZuQJeNsbtx7/sHVkLenWUBHG82Mhv1IM8oSRXE8PqjQUoWbTtKVIBRAt1lESFC28X3r5pghqMZzLjNqLYfN1MApFRWwZQdG9KmvIBy2YhPOuG06froxMse38DhfzehbMVglBQV96gUTRG6jBnfSd27N/GOYYyXL1RT6iWTW3KjtbZxY9hQnR4tTY5rq6vfJTpxWXL/xPiRSe8dIavpBLH6RviUK8AJGd90JeAg3GYibdF+8R55ph5yJWoHFQxYtAx8WFJdtSjnTjFVJcBJoq0CdBE6JUwKm+iEVctA23Mdp0GRnLVkbuzGka9wC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(86362001)(85182001)(2906002)(36756003)(53546011)(186003)(2616005)(7416002)(6506007)(26005)(6512007)(38070700005)(6486002)(5660300002)(8936002)(71200400001)(122000001)(478600001)(41300700001)(110136005)(316002)(54906003)(8676002)(38100700002)(4326008)(91956017)(66556008)(66946007)(66446008)(64756008)(66476007)(76116006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eitub0FIRm51dVVPMkRrL1dsRmdZeTN1a1dUK0FObk5XRGVtWkIxRWR2bTRU?=
 =?utf-8?B?cEhsM1I2eUNDZzBUSWowbmlXVFlOZzFRTFFxd1lyZDVrSFVPWHJnbTFHR2RS?=
 =?utf-8?B?ZndXMDgyaVNyTlNUNWMzQlo0M05mQVcwVHdwMCt5ejJYWGtxemR6Nksrc2Zw?=
 =?utf-8?B?a3Foa1NBNCtEYjV6d09vRHpscEtGdXBZdUdRLzRWcEJxZ2M2YnA3S2YwQVN2?=
 =?utf-8?B?YVpVT3JWWXV2UHhNWks1WFF3TTA0WWZBZVRIREFhUVdTcXVQUlB4SmFhWCt6?=
 =?utf-8?B?MURWWmhEUU1uWkRBL3EyQjFia1lkelhhQ1RQYXdrQURzNC84aFRiZXVrS1dC?=
 =?utf-8?B?WE1kNXBwSW9xVG93aFdIVG1iS29Sdzh5VWVKeG9nM2RXNW85V3BRcDlES3Fq?=
 =?utf-8?B?c3lZcFU3Wkp5akdaaWZOM1NEeDcwYVhKUVdJSFBUL1ZaeGQxZ1ppQndTbm5W?=
 =?utf-8?B?RVdjUG0zRkdPVGN0bjYzYWRKR1UrSlVoZDN5OHUyVGp2RnZiRm9tdngzR1Uy?=
 =?utf-8?B?K1BrSkhkT3YvVE95VUV1a1Q3S05WQ0liQmtuL25laUs4SURtRlp3dmpaSGhB?=
 =?utf-8?B?NzlYTkwybXhDbm5OdlRtT1lyYUZabWVneXQxZVIwUHM0dncvTDNic3NoMmpG?=
 =?utf-8?B?UzJvcE1EWDFqWlAzU3NoWWVFcUprMWVwRW8wZWZBQzZRTmtxRnYxUUJxVmIz?=
 =?utf-8?B?TFZHK21lc3duQnAzN05BakdCTnpIZmVKOEFpL2dCSENQM3dnSjR3RmxlSTlh?=
 =?utf-8?B?RXJOWDI3aSszems5Q0VrMXJLdkI3a3dFUGl6RndwYjZyZ3NyaDh1Zk85SW5z?=
 =?utf-8?B?d0tnVnNPVkQvRHV0SndUdHQ2QlVFWU9PbjI0VXZVWFBwRWFFZ3VFajI4UEt2?=
 =?utf-8?B?NFRJa0RTenBQZTExVVZPUlpkM3pYQnNuSUs3dGNWWXM1RCtxcVZJRTdKOWl1?=
 =?utf-8?B?akVEQXl0SnlEMFBmelB5QTVobjQrTDBlWmlwWEFFYUExZHFpZU5MUHpYSlZp?=
 =?utf-8?B?dGVuQjQ2ZkpoeFRkWnJOL2dMNW1kTkVUczBVWEV1Sk83dGVmNUovSW1HQitt?=
 =?utf-8?B?TG93N0w3NTVoaUJCcktxc1M2bmNwTnFTOE1FN2tmWmpsaWM3KzlqQTFwWjhS?=
 =?utf-8?B?N1ppZ2NkamoxdGRXaUpMV2dPS2I2cTRHaEpPMW5tMjlRRENkeXQ0SGk1ZjBl?=
 =?utf-8?B?UmNUTmtjcWk5emQ3THV6bktyOTI4bkl1aUxnaTJhd2VjY2RWOU1aSnZVbmVN?=
 =?utf-8?B?aHdiZDVWNFNzdTBIUGtIUmJDRW9yMTg5dDhXZnVCY0gzMit3NzlRU2FCb1JL?=
 =?utf-8?B?SUtROGUyVitrTGwzOVY0L0paNDNaKzdmSHBBdVAvNUNqYWRBZkNxS0Y3aDBQ?=
 =?utf-8?B?U3JYSEJVU203cDhwOUdPbkQxZHRqbFZxZkpwN1c1bjBNVmVlRkdpb3ZpbmVF?=
 =?utf-8?B?eXg1bm4rVHlsZzJETk9JUHZOSU1rVVVwUVBxdk5pMnFOT3FBVEg3RTJxM1dz?=
 =?utf-8?B?a0dHeTExZHo2Rzc1VVN2c1ExRzFsNHlDL3dvOVRoTjNHQ2YvWFh1d0YrUFJL?=
 =?utf-8?B?UlFLTWVsZWFFK2xzajlVVEVSWERRNUFCUzVFWUU0YmZTOFdoNlVRR2tlNFBu?=
 =?utf-8?B?eko3ZzFpdm9zdERPaVdPSkxkK2Q2Z0s0bEpwZG1rR2ZuMnZUT21TOW9VWnFM?=
 =?utf-8?B?TFFGZlBTb2JHdkNZNC9pbHdIdEdFaG1nUFRWdGo3SXNjY0xMV0J6cEk4MGth?=
 =?utf-8?B?QVBVYUlJdndkOU9FSW5wejl1L1FReUtadm9lRVVldmg4dFFZb0E2Mmk5cUl3?=
 =?utf-8?B?MHZSM1c4TjNiMlNvZ0xRN2V6WkxaTXVFcktxcEJwc2hMMisxRDVzWUxONE9X?=
 =?utf-8?B?aTFzYS9nbjBJQmJrbndIWmlBQVNQUWtnSnpOVGtXNk9VTXVzS21YL0dTcW1U?=
 =?utf-8?B?RmhTRVBULzJTVDJhNTU2ejU0K3oyc0ZzVk5tamEzQXhkenU2cjdDd2JEM0tJ?=
 =?utf-8?B?MGJtQ0dvUTlWeFpKZjIxbE1mM2l1aXc3aFZyR3A2YllqUUZ1dlg2U1RmcjFC?=
 =?utf-8?B?Q2VQMkdPeHpCKzZES2dpV2x1NzlvRU1GajZoOHJOeWZQcjBDUStPQTM3amJ6?=
 =?utf-8?B?L0lBNkJBelNZU1RkOUJIajkwVzBweWlQWml6UG1iY2hLQzllUVM4dGpVUVcr?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BD1B95106238F4697282F67C5CCA9E5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb72b91-7473-4b7c-47c5-08db9368b4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 14:56:52.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dx5219BPnsDxeYUW3zZEpfuIowPky/2btjMwaUm52wC9+AOfICUHgYB43xTH0pGL7EyVNc/2oPZV9b/LnlYxjJ2Qmya/p2puxTZAvsFK+K4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5417
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgaGFucywNCg0KVGhhbmtzIGZvciB5b3VyIHRlc3QgYW5kIHJldmlldy4NCg0KT24gV2VkLCAy
MDIzLTA4LTAyIGF0IDEwOjUxICswMjAwLCBIYW5zIFZlcmt1aWwgd3JvdGU6DQo+ICAJIA0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiAgSGkgWXVuZmVpLA0KPiANCj4gT24gMjkvMDcvMjAyMyAwNTo0NywgWXVuZmVpIERvbmcg
d3JvdGU6DQo+ID4gVGhlIHZwdSBtYXliZSBudWxsIHBvaW50ZXIgb3IgdW5yZWFzb25hYmxlIHZh
bHVlIHdoZW4gc2NwIGNyYXNoLA0KPiBuZWVkIHRvDQo+ID4gdmFsaWRhdGUgdGhhdCB0aGUgdnB1
IHBvaW50ZXIgYW5kIHRoZSB2cHUgaW5zdGFuY2Ugd2l0aGluIHRoaXMNCj4gY29udGV4dCBpcw0K
PiA+IHZhbGlkIGluIGNhc2Ugb2YgbGVhZGluZyB0byBrZXJuZWwgcmVib290Lg0KPiA+IA0KPiA+
IEZpeGVzOiA1OTA1NzdhNGU1MjUgKCJbbWVkaWFdIHZjb2RlYzogbWVkaWF0ZWs6IEFkZCBNZWRp
YXRlayBWNEwyDQo+IFZpZGVvIERlY29kZXIgRHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
dW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBT
dGV2ZSBDaG8gPHN0ZXZlY2hvQGdvb2dsZS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE5pY29sYXMg
RHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT4NCj4gPiAtLS0NCj4gPiAt
IGNvbXBhcmVkIHdpdGggdjI6DQo+ID4gLSByZXdyaXRlIHRoZSBjb21taXQgbWVzc2FnZSBmb3Ig
cGF0Y2ggMDEgYW5kIDAyLg0KPiA+IC0gYWRkIFJlcG9ydGVkLWJ5IGFuZCBGaXhlcyB0YWcuDQo+
ID4gLSBmaXggc21hdGNoIGZhaWwgZm9yIHBhdGNoIDAyLzIuDQo+ID4gLS0tDQo+ID4gIC4uLi92
Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYuaCAgICAgICB8ICAyICsNCj4gPiAgLi4u
L21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWNfdnB1X2lmLmMgICAgIHwgNzcgKysrKysrKysr
KysrLS0tDQo+IC0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAy
NyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlY19kcnYuaA0KPiBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2Rl
Y19kZWNfZHJ2LmgNCj4gPiBpbmRleCA2YzMxOGRlMjVhNTVlLi43ZTM2YjJjNjliN2QxIDEwMDY0
NA0KPiA+IC0tLQ0KPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2Rl
Y29kZXIvbXRrX3Zjb2RlY19kZWNfZHJ2LmgNCj4gPiArKysNCj4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjX2Rydi5oDQo+ID4g
QEAgLTE2MSw2ICsxNjEsNyBAQCBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfcGRhdGEgew0KPiA+ICAg
KiBAaHdfaWQ6IGhhcmR3YXJlIGluZGV4IHVzZWQgdG8gaWRlbnRpZnkgZGlmZmVyZW50IGhhcmR3
YXJlLg0KPiA+ICAgKg0KPiA+ICAgKiBAbXNnX3F1ZXVlOiBtc2cgcXVldWUgdXNlZCB0byBzdG9y
ZSBsYXQgYnVmZmVyIGluZm9ybWF0aW9uLg0KPiA+ICsgKiBAdnB1X2luc3Q6IHZwdSBpbnN0YW5j
ZSBwb2ludGVyLg0KPiA+ICAgKg0KPiA+ICAgKiBAaXNfMTBiaXRfYml0c3RyZWFtOiBzZXQgdG8g
dHJ1ZSBpZiBpdCdzIDEwYml0IGJpdHN0cmVhbQ0KPiA+ICAgKi8NCj4gPiBAQCAtMjA1LDYgKzIw
Niw3IEBAIHN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggew0KPiA+ICBpbnQgaHdfaWQ7DQo+ID4g
IA0KPiA+ICBzdHJ1Y3QgdmRlY19tc2dfcXVldWUgbXNnX3F1ZXVlOw0KPiA+ICt2b2lkICp2cHVf
aW5zdDsNCj4gPiAgDQo+ID4gIGJvb2wgaXNfMTBiaXRfYml0c3RyZWFtOw0KPiA+ICB9Ow0KPiA+
IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9k
ZWNvZGVyL3ZkZWNfdnB1X2lmLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy9kZWNvZGVyL3ZkZWNfdnB1X2lmLmMNCj4gPiBpbmRleCA4MmMzZGM4YzQxMjczLi4y
M2NmZTVjNmM5MGI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlY192cHVfaWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlY192cHVfaWYuYw0KPiA+IEBA
IC03Miw2ICs3MiwyMSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfZ2V0X3BhcmFtX21zZ19hY2soY29u
c3QNCj4gc3RydWN0IHZkZWNfdnB1X2lwaV9nZXRfcGFyYW1fYWNrICptcw0KPiA+ICB9DQo+ID4g
IH0NCj4gPiAgDQo+ID4gK3N0YXRpYyBib29sIHZwdV9kZWNfY2hlY2tfYXBfaW5zdChzdHJ1Y3Qg
bXRrX3Zjb2RlY19kZWNfZGV2DQo+ICpkZWNfZGV2LCBzdHJ1Y3QgdmRlY192cHVfaW5zdCAqdnB1
KQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHggKmN0eDsNCj4gPiAraW50
IHJldCA9IGZhbHNlOw0KPiA+ICsNCj4gPiArbGlzdF9mb3JfZWFjaF9lbnRyeShjdHgsICZkZWNf
ZGV2LT5jdHhfbGlzdCwgbGlzdCkgew0KPiA+ICtpZiAoIUlTX0VSUl9PUl9OVUxMKGN0eCkgJiYg
Y3R4LT52cHVfaW5zdCA9PSB2cHUpIHsNCj4gPiArcmV0ID0gdHJ1ZTsNCj4gPiArYnJlYWs7DQo+
ID4gK30NCj4gPiArfQ0KPiA+ICsNCj4gPiArcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgLyoNCj4gPiAgICogdnB1X2RlY19pcGlfaGFuZGxlciAtIEhhbmRsZXIgZm9yIFZQVSBpcGkg
bWVzc2FnZS4NCj4gPiAgICoNCj4gPiBAQCAtODQsNDQgKzk5LDUxIEBAIHN0YXRpYyB2b2lkIGhh
bmRsZV9nZXRfcGFyYW1fbXNnX2Fjayhjb25zdA0KPiBzdHJ1Y3QgdmRlY192cHVfaXBpX2dldF9w
YXJhbV9hY2sgKm1zDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgdm9pZCB2cHVfZGVjX2lwaV9oYW5k
bGVyKHZvaWQgKmRhdGEsIHVuc2lnbmVkIGludCBsZW4sIHZvaWQNCj4gKnByaXYpDQo+ID4gIHsN
Cj4gPiArc3RydWN0IG10a192Y29kZWNfZGVjX2RldiAqZGVjX2RldjsNCj4gPiAgY29uc3Qgc3Ry
dWN0IHZkZWNfdnB1X2lwaV9hY2sgKm1zZyA9IGRhdGE7DQo+ID4gLXN0cnVjdCB2ZGVjX3ZwdV9p
bnN0ICp2cHUgPSAoc3RydWN0IHZkZWNfdnB1X2luc3QgKikNCj4gPiAtKHVuc2lnbmVkIGxvbmcp
bXNnLT5hcF9pbnN0X2FkZHI7DQo+ID4gK3N0cnVjdCB2ZGVjX3ZwdV9pbnN0ICp2cHU7DQo+ID4g
IA0KPiA+IC1pZiAoIXZwdSkgew0KPiA+ICtkZWNfZGV2ID0gKHN0cnVjdCBtdGtfdmNvZGVjX2Rl
Y19kZXYgKilwcml2Ow0KPiA+ICt2cHUgPSAoc3RydWN0IHZkZWNfdnB1X2luc3QgKikodW5zaWdu
ZWQgbG9uZyltc2ctPmFwX2luc3RfYWRkcjsNCj4gPiAraWYgKCFwcml2IHx8ICF2cHUpIHsNCj4g
PiAgbXRrX3Y0bDJfdmRlY19lcnIodnB1LT5jdHgsICJhcF9pbnN0X2FkZHIgaXMgTlVMTCwgZGlk
IHRoZSBTQ1ANCj4gaGFuZyBvciBjcmFzaD8iKTsNCj4gPiAgcmV0dXJuOw0KPiA+ICB9DQo+IA0K
PiBUaGlzIGNoYW5nZSByZXN1bHRzIGluIGEgc21hdGNoIGVycm9yOg0KPiANCj4gZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci92ZGVjX3ZwdV9pZi5jOjEwOQ0K
PiB2cHVfZGVjX2lwaV9oYW5kbGVyKCkgZXJyb3I6IHdlIHByZXZpb3VzbHkgYXNzdW1lZCAndnB1
JyBjb3VsZCBiZQ0KPiBudWxsIChzZWUgbGluZSAxMDgpDQo+IA0KPiBUaGUgc2FtZSBoYXBwZW5z
IGluIHRoZSBuZXh0IHBhdGNoIGZvciB2cHVfZW5jX2lwaV9oYW5kbGVyLg0KPiANCj4gQ2FuIHlv
dSBwb3N0IGEgdjQgZml4aW5nIHRoaXM/DQo+IA0KPiBUaGFuayB5b3UhDQo+IA0KPiBIYW5zDQoN
ClBsZWFzZSBoZWxwIHRvIHJldmlldyB2NCBhZ2Fpbi4NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVp
IERvbmcNCj4gDQo+ID4gIA0KPiA+IC1tdGtfdmRlY19kZWJ1Zyh2cHUtPmN0eCwgIisgaWQ9JVgi
LCBtc2ctPm1zZ19pZCk7DQo+ID4gK2lmICghdnB1X2RlY19jaGVja19hcF9pbnN0KGRlY19kZXYs
IHZwdSkgfHwgbXNnLT5tc2dfaWQgPA0KPiBWUFVfSVBJTVNHX0RFQ19JTklUX0FDSyB8fA0KPiA+
ICsgICAgbXNnLT5tc2dfaWQgPiBWUFVfSVBJTVNHX0RFQ19HRVRfUEFSQU1fQUNLKSB7DQo+ID4g
K210a192NGwyX3ZkZWNfZXJyKHZwdS0+Y3R4LCAidmRlYyBtc2cgaWQgbm90IGNvcnJlY3RseSA9
PiAweCV4IiwNCj4gbXNnLT5tc2dfaWQpOw0KPiA+ICt2cHUtPmZhaWx1cmUgPSAtRUlOVkFMOw0K
PiA+ICtnb3RvIGVycm9yOw0KPiA+ICt9DQo+ID4gIA0KPiA+ICB2cHUtPmZhaWx1cmUgPSBtc2ct
PnN0YXR1czsNCj4gPiAtdnB1LT5zaWduYWxlZCA9IDE7DQo+ID4gK2lmIChtc2ctPnN0YXR1cyAh
PSAwKQ0KPiA+ICtnb3RvIGVycm9yOw0KPiA+ICANCj4gPiAtaWYgKG1zZy0+c3RhdHVzID09IDAp
IHsNCj4gPiAtc3dpdGNoIChtc2ctPm1zZ19pZCkgew0KPiA+IC1jYXNlIFZQVV9JUElNU0dfREVD
X0lOSVRfQUNLOg0KPiA+IC1oYW5kbGVfaW5pdF9hY2tfbXNnKGRhdGEpOw0KPiA+IC1icmVhazsN
Cj4gPiArc3dpdGNoIChtc2ctPm1zZ19pZCkgew0KPiA+ICtjYXNlIFZQVV9JUElNU0dfREVDX0lO
SVRfQUNLOg0KPiA+ICtoYW5kbGVfaW5pdF9hY2tfbXNnKGRhdGEpOw0KPiA+ICticmVhazsNCj4g
PiAgDQo+ID4gLWNhc2UgVlBVX0lQSU1TR19ERUNfU1RBUlRfQUNLOg0KPiA+IC1jYXNlIFZQVV9J
UElNU0dfREVDX0VORF9BQ0s6DQo+ID4gLWNhc2UgVlBVX0lQSU1TR19ERUNfREVJTklUX0FDSzoN
Cj4gPiAtY2FzZSBWUFVfSVBJTVNHX0RFQ19SRVNFVF9BQ0s6DQo+ID4gLWNhc2UgVlBVX0lQSU1T
R19ERUNfQ09SRV9BQ0s6DQo+ID4gLWNhc2UgVlBVX0lQSU1TR19ERUNfQ09SRV9FTkRfQUNLOg0K
PiA+IC1icmVhazsNCj4gPiArY2FzZSBWUFVfSVBJTVNHX0RFQ19TVEFSVF9BQ0s6DQo+ID4gK2Nh
c2UgVlBVX0lQSU1TR19ERUNfRU5EX0FDSzoNCj4gPiArY2FzZSBWUFVfSVBJTVNHX0RFQ19ERUlO
SVRfQUNLOg0KPiA+ICtjYXNlIFZQVV9JUElNU0dfREVDX1JFU0VUX0FDSzoNCj4gPiArY2FzZSBW
UFVfSVBJTVNHX0RFQ19DT1JFX0FDSzoNCj4gPiArY2FzZSBWUFVfSVBJTVNHX0RFQ19DT1JFX0VO
RF9BQ0s6DQo+ID4gK2JyZWFrOw0KPiA+ICANCj4gPiAtY2FzZSBWUFVfSVBJTVNHX0RFQ19HRVRf
UEFSQU1fQUNLOg0KPiA+IC1oYW5kbGVfZ2V0X3BhcmFtX21zZ19hY2soZGF0YSk7DQo+ID4gLWJy
ZWFrOw0KPiA+IC1kZWZhdWx0Og0KPiA+IC1tdGtfdmRlY19lcnIodnB1LT5jdHgsICJpbnZhbGlk
IG1zZz0lWCIsIG1zZy0+bXNnX2lkKTsNCj4gPiAtYnJlYWs7DQo+ID4gLX0NCj4gPiArY2FzZSBW
UFVfSVBJTVNHX0RFQ19HRVRfUEFSQU1fQUNLOg0KPiA+ICtoYW5kbGVfZ2V0X3BhcmFtX21zZ19h
Y2soZGF0YSk7DQo+ID4gK2JyZWFrOw0KPiA+ICtkZWZhdWx0Og0KPiA+ICttdGtfdmRlY19lcnIo
dnB1LT5jdHgsICJpbnZhbGlkIG1zZz0lWCIsIG1zZy0+bXNnX2lkKTsNCj4gPiArYnJlYWs7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gLW10a192ZGVjX2RlYnVnKHZwdS0+Y3R4LCAiLSBpZD0lWCIsIG1z
Zy0+bXNnX2lkKTsNCj4gPiArZXJyb3I6DQo+ID4gK3ZwdS0+c2lnbmFsZWQgPSAxOw0KPiA+ICB9
DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW50IHZjb2RlY192cHVfc2VuZF9tc2coc3RydWN0IHZkZWNf
dnB1X2luc3QgKnZwdSwgdm9pZA0KPiAqbXNnLCBpbnQgbGVuKQ0KPiA+IEBAIC0xODIsOSArMjA0
LDEwIEBAIGludCB2cHVfZGVjX2luaXQoc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSkNCj4gPiAg
DQo+ID4gIGluaXRfd2FpdHF1ZXVlX2hlYWQoJnZwdS0+d3EpOw0KPiA+ICB2cHUtPmhhbmRsZXIg
PSB2cHVfZGVjX2lwaV9oYW5kbGVyOw0KPiA+ICt2cHUtPmN0eC0+dnB1X2luc3QgPSB2cHU7DQo+
ID4gIA0KPiA+ICBlcnIgPSBtdGtfdmNvZGVjX2Z3X2lwaV9yZWdpc3Rlcih2cHUtPmN0eC0+ZGV2
LT5md19oYW5kbGVyLCB2cHUtDQo+ID5pZCwNCj4gPiAtIHZwdS0+aGFuZGxlciwgInZkZWMiLCBO
VUxMKTsNCj4gPiArIHZwdS0+aGFuZGxlciwgInZkZWMiLCB2cHUtPmN0eC0+ZGV2KTsNCj4gPiAg
aWYgKGVycikgew0KPiA+ICBtdGtfdmRlY19lcnIodnB1LT5jdHgsICJ2cHVfaXBpX3JlZ2lzdGVy
IGZhaWwgc3RhdHVzPSVkIiwgZXJyKTsNCj4gPiAgcmV0dXJuIGVycjsNCj4gPiBAQCAtMTkzLDcg
KzIxNiw3IEBAIGludCB2cHVfZGVjX2luaXQoc3RydWN0IHZkZWNfdnB1X2luc3QgKnZwdSkNCj4g
PiAgaWYgKHZwdS0+Y3R4LT5kZXYtPnZkZWNfcGRhdGEtPmh3X2FyY2ggPT0NCj4gTVRLX1ZERUNf
TEFUX1NJTkdMRV9DT1JFKSB7DQo+ID4gIGVyciA9IG10a192Y29kZWNfZndfaXBpX3JlZ2lzdGVy
KHZwdS0+Y3R4LT5kZXYtPmZ3X2hhbmRsZXIsDQo+ID4gICB2cHUtPmNvcmVfaWQsIHZwdS0+aGFu
ZGxlciwNCj4gPiAtICJ2ZGVjIiwgTlVMTCk7DQo+ID4gKyAidmRlYyIsIHZwdS0+Y3R4LT5kZXYp
Ow0KPiA+ICBpZiAoZXJyKSB7DQo+ID4gIG10a192ZGVjX2Vycih2cHUtPmN0eCwgInZwdV9pcGlf
cmVnaXN0ZXIgY29yZSBmYWlsIHN0YXR1cz0lZCIsDQo+IGVycik7DQo+ID4gIHJldHVybiBlcnI7
DQo+IA0KPiANCg==
