Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AF7D944B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345652AbjJ0JzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0JzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:55:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C32610E;
        Fri, 27 Oct 2023 02:55:01 -0700 (PDT)
X-UUID: e0be110a74ae11eea33bb35ae8d461a2-20231027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W4VuKq9eRZJfGtYl+rzHzB8jDqtgz2zj1DGVG+75a+Y=;
        b=dIDEaTMld5uwv1P5Qzmf+5wQn23dT0lObk0F9oIW/I7e42A+Dx5GcVG5b26itXp0u7x5I4m9xxI19PN4RvtdT0DzezRJvpWr9uYo/lfvVB2S3EIs44+lYHHjVhLReBdBYmbxaIqDKvHB/2wLWiQMohNBCb2iFBN9IW2E5EILIkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e992febb-3462-4df9-889e-bb1cb27ed2a8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:fbd364d7-04a0-4e50-8742-3543eab8cb8e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e0be110a74ae11eea33bb35ae8d461a2-20231027
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <lena.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1961234163; Fri, 27 Oct 2023 17:54:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Oct 2023 17:54:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Oct 2023 17:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VctqfxwlBE8i1GFsRDKmC4BB89Juu0NaUNzUMfDrjPCV8LCtRn77HtxlvyaVxV2SOPRVlFh7P29tFqZwVOGoefSeBvsty29Sp4ugcv7bWUNCdVDV+A9B9ev8GS21epHcXepTPhXEZwMRvsvp27v73W0lsPMKkNjlf1OAhX7JJPg8CJHd/FtnDvJyf3RcZ3DXHBjcASR2VCPtJSjnRYketdBuM8ZJWgT/2CnZUvZoWqXYK+HO2+RhNturaw6STB6r+5Q+NqQda63aNWHTTvM4RhwVoqcJqYic7YCTvm3kMLRV8DRlHzEUgxJPxtKzgU3Thx1swEFuo21SUwsa12JT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4VuKq9eRZJfGtYl+rzHzB8jDqtgz2zj1DGVG+75a+Y=;
 b=iScW9oyFVT+O2BcPruT8mRBAcs1VO1xC0RJg/MA148xQpsaNOv4NrqkjV2kG9xSqveboJXMHeCCXpCLXCjk1KfnEtAPZraK7lN7vRVAWMkCYyEnoYxOjuvtqMfIosEtCbtR1xefy7pUkkw+vtknzF6GVMA6PxL6q09T9c4ebgDZeXtf1xQBncqerYK5kgQzpLNjVCc+kmF2/bqwvA0Ozo10Mb5Koxq/593nh08IV4Jg0bI7ufXnBIRlx/FjFx90yUK/4E8OC3nTRc3Xlv0iGHGgHINogUBfNYL7nDswFS61lZsCdh/mKrtm9cYNV9HPGwzPDrmVBb+pr7PyJR/5izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4VuKq9eRZJfGtYl+rzHzB8jDqtgz2zj1DGVG+75a+Y=;
 b=USJj54xfBbYal8ZVhgZY4SG2e7VuZ9yEa8yYCB3Ln1LIyCEcU8YBBjtRZxwa8lW+4imv21pqmbJHCdyMPthK8eg3q4FVyeMf610kaBAe+EyY09fU2yr3D1EDxwxFTNPHIFvryosX6ppgV43JAEC57nznGVQqKOuqqe0c3Gl+dhI=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEZPR03MB7471.apcprd03.prod.outlook.com (2603:1096:101:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 09:54:50 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 09:54:50 +0000
From:   =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To:     "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "cmllamas@google.com" <cmllamas@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "maze@google.com" <maze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: GKI: [kernel6.1] Kernel panic on __udpv4_gso_segment_list_csum in
 rx-udp-gro-forwarding
Thread-Topic: GKI: [kernel6.1] Kernel panic on __udpv4_gso_segment_list_csum
 in rx-udp-gro-forwarding
Thread-Index: AdoIhTjCvcufaaYrTPCBKiZyeFWqjgAId7iAAAEyhAAAAnepgAAA6tiA
Date:   Fri, 27 Oct 2023 09:54:49 +0000
Message-ID: <8d1eedae2705357427dc974deae17850dd3b4e65.camel@mediatek.com>
References: <SEZPR03MB6466D3C5A5F187510572F3A69CDCA@SEZPR03MB6466.apcprd03.prod.outlook.com>
         <0eaf6a7d914be6c1e207c2ce54de5f3284a33326.camel@redhat.com>
         <e0b361de5f120c583412c148fdd982624fa16e30.camel@mediatek.com>
         <7b3d9af8fafa18050cb5f5f7afc241baccbbb3cf.camel@redhat.com>
In-Reply-To: <7b3d9af8fafa18050cb5f5f7afc241baccbbb3cf.camel@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEZPR03MB7471:EE_
x-ms-office365-filtering-correlation-id: 4899b7a6-c51e-45da-b294-08dbd6d2c2a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGXEtWBxNywgIl22wkQPQd6kZUoz8e9qYisPL6Bl2PZjOm1fG9NYUN7UirJO97XkRLLPXQSQGcSduRqjwe4wBj2eQNblqWTQSo91bhzsLrBruh3KXEYwUjvCk8ETBdTE55Ww0xXrWsl4/lWdKvGbYEyhcvZ5qZZFao+dItYUCYuA/RCVHE1NrXIo6XpElY36wBZpr4+ToK29iNEjv+q+JoW0dWHpbJjKVTZhuIKBkBsBl2tVg5c2hQjZqcgzsCThu/0+5ihbsaoKkRpnMEXQyX7mGUJGbsDZ0bBjKXzguo7MGjBiS+gunQ5XLky8Rl03LLtEUyqkwAgBPtDfF4dLJ6KVmeapurLQoC0QDTW1SYW/TWIg2U+ukq5t2wXo/BwOWOkbjOTl04oa1RAt8axfevsoXx6Rn2nQZkbnsT9uO2r/YQBfSRDt88izfyCGDaOZEEBB7yC3Xfgk/7iAtQDStvDyOXxDTgbnoZel0CXn7ZRWsoH+PJD6h/fu862N5uacORiBfpIYZcOYOPEKau38ScWMYiZd60ncuBb3O1/Ab4loGC6+yoLk+omnFo30XIAZhRdMOtlOPTmvzgKUohvEsSsBCoSbaXzkWiDqliHew4gNfLIoHHNY94qqX634FQjKUYmR0CRVN+/KYHXnypMZCambWQ3fDftnmN5ljpFDP4x+Kyf23ngwUuI5NETfOuAGSofbNhrfXF6QeelDw+E3UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(122000001)(38070700009)(26005)(38100700002)(83380400001)(41300700001)(5660300002)(91956017)(66446008)(66556008)(2906002)(76116006)(66946007)(54906003)(8676002)(85182001)(316002)(86362001)(4001150100001)(6916009)(66476007)(64756008)(478600001)(36756003)(6506007)(4326008)(71200400001)(8936002)(6486002)(2616005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStyQlM3K2JvSkZsUGZ5MGtWWmdFTGJDNkxvOGlrY25CNjFyVVJoaVFFNFlq?=
 =?utf-8?B?YmlrcHZyQTBvcC9RS21WVXE5Tm9JVmtGSWpQbHQ4TjNyVnhEQkFIakx6TVA0?=
 =?utf-8?B?RnRxZnpFV3N4cWtBc0Jjamt3VEJ6SEozeVNnQXZhS3BMbkovOSt6djVibHNU?=
 =?utf-8?B?RVNvdVBuenpzUHVhb2VXSU5kVTY3ZFp2VTRvQy9qZWJWcXYxaGpBakh2ZHRv?=
 =?utf-8?B?OXQyNEJLWE9FOHk2eW1lSUIxT3RaVkZORlJRTXpzUVBJbkFWaFl4Q0VlN0ll?=
 =?utf-8?B?a0N3eUE0cFkzZVp0eWx5bTBVcUJodDd3SFMxM3Z2bFpkaStwZTkwa1o5NlJU?=
 =?utf-8?B?a1h6QTFnVUVjU3lCMzBVZnJ0K2hvVHIwUEYxeGxJbzFUMEp5YXNxMmY0L0RG?=
 =?utf-8?B?akEycGVaYzVOcWZzNENZMHFRWXU3VkRESm1Menl5ZVk5WW52TmZWNTNaSFB5?=
 =?utf-8?B?ZkREdnJUWHd6OXNZa3cyTFhrSWdHdFcxcWd6RFRZd1JiQVFsU3FvWjhUZmpk?=
 =?utf-8?B?b1pjMllQU040WGlFL1BLL0RPZWR0SWdwTHhiSWZvWkxSQ2Z4cCtmRm1jVjV0?=
 =?utf-8?B?TnRMZlNXT3ZhQmNYTG1DU2dnZTdpRlZ2dXVsMnFOY2V2NlkzY0YxMEdGSVZt?=
 =?utf-8?B?dGpacVlscEx6TlBKeUJRSVNaRjd0c0pWRTZzY1RjcHB2U1pOZlVUb0dBYnhC?=
 =?utf-8?B?WC9STFl1R0tySWJ6V2ZsTm1VbDZLL2Y2WThaaUd2TERnRWhyakdVcWw0VG51?=
 =?utf-8?B?a0xLNHpXbE5TckhybDF5Ky9RaHBHcW9GT21mZGJ6VmpLZDA5NStmZDk4cGF5?=
 =?utf-8?B?bHB5aVdQYVIzN3FBYVRkN29ZRVVuTG81N3hUcEJJQ0g0NVcxYU02K3ArWUtD?=
 =?utf-8?B?VjNvekdKTU9MazF6WmpYYS9CM2hmczhldGFoNExQbkhsNTVHd3pkZGRiNXZS?=
 =?utf-8?B?VW1ubjJnNlpFWHVnb1NObXdlRS9Qc1FENWtQS2xON3BDeXNmeTM3R01rOVly?=
 =?utf-8?B?eGNTQmRNZTQyTC9lWnZTZ0tVT1d2NWtlZ3VtVmErMXVnYkYyeUlVcEtudG1K?=
 =?utf-8?B?dmdIclVhOWQ5RUpOOTlXRXNzRnVMSG05bngxZzFQTnMxR3hJNHZTZ1RRV1c3?=
 =?utf-8?B?ZWtGai9RbDNqU2VJcm8yZUNONTVYcjRkWERmYXJEQTJwTVl4a2RXTVJCQ0Ir?=
 =?utf-8?B?Q0g0VE9lNHptbFFSV3VxK3FmQnRqSDlwZkZzemdqRFVRc1pUTFB1SlFTemgv?=
 =?utf-8?B?aW5tTzRLdW5JU204QmZDWk8zbTRRbHkyRnU0cDREWWVCVzZIMDE3NDI3VVJ1?=
 =?utf-8?B?UzhVSWhsOUd0RStKcEhCWm9oS1NjUUV4YittZi9mdmFKeGhFanJXSFRnb25q?=
 =?utf-8?B?aVQ3djQrb2ZUMml5MFUyT25QdW52b20waHBNanpuc3FVemIwYTFleG5SSy9z?=
 =?utf-8?B?T0FETFlzQThwbVB2dm5IbWpkbGtycHQvUHlQWHVML1pRYW9MUkM4ajV5NUY1?=
 =?utf-8?B?TXlROXRKZjBhNU9wUi9UdUEvRDJLUjBzUHFxR1RJNUdibmhaZmF0bS9VR2Mw?=
 =?utf-8?B?Z0QxOUFSbW1oZWlUakRyV01KRTRSMHE5dzc0cDU0andUeDZqeWN2OTFrbGoz?=
 =?utf-8?B?cTdGOW9HMTUxaS9qRitEdUxEdXlwSUJnNVpzeWR4bkgyck94dzlzSjBOQ0s1?=
 =?utf-8?B?VzlPbzZoMlY0a0lXOG1zYUVhVnZ4T1pvVE5vS1JDMmJlajljTXJpQTJQK2tz?=
 =?utf-8?B?VENxR0tsbnh1cTNtUGpLWDZXS1JzK2RubVdTUXhEUUw5TzBWT1RQVzZycXln?=
 =?utf-8?B?Q2xkSXh5dnVqOEZNemlPSVRKOXhmZlBNa0pnSW5acWljUTZlMk1teEZvQnZp?=
 =?utf-8?B?ZnBLdVBPRU9ZZlE3MWpkUkx3TDQwNmdxYzBpdGZuQ0dxb3lvclhPS1pYMk5t?=
 =?utf-8?B?aVIxcW9MZ0RoWU5Od1hGajNFVGowT3R3U2s0dks5R2t0RDNkcUpZNFk3dFhh?=
 =?utf-8?B?T2hUeklUNWpWMkJidFJQTVRzaUYxdjI5TWpZajBTSG9oTVpyQ1Nxd3JjbmdH?=
 =?utf-8?B?QTRTN2RySjQxVUtHRTk2b1FRSGQyOUtMdWhJWXFnVlU5eEE5cDFLK3BVOS84?=
 =?utf-8?B?UWVSWm4xaDExSXhWQS9IUlZ0b0VMcG9ROHpBZEphbHdYbzU0dzhMOUk5U3FE?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E306CABAE9F2B47BAB822D7EE3D4085@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4899b7a6-c51e-45da-b294-08dbd6d2c2a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 09:54:49.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbqRdvEg5DPq/C68ObENOk2gseGtS48l2I6+zwZBMuvpecrLZMDktMVEi/pOKh+YGBpQWO7FopDHxSuYPVW/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7471
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.712400-8.000000
X-TMASE-MatchedRID: 1GZI+iG+Mtdq0U6EhO9EEy0UvD/exuSelV2LeD3ayQ8NcckEPxfz2DEU
        xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cz5VvfCjIxlu5722hDqHosTQqJ
        x4++XpSr1e+V8HdVGj8JZoay2k271S4Q3I/LeUOcjK+nUBBcfy0KzuF0egUUDrFW3LKYp4bQzK+
        JU/VbWZBT6+KIPEGWdf848Lqzjpoy6XBlyCm38klT/YzREB9OKfkuZtv/FS5reiSHKHp6DZT9Rh
        DVQ/mzMrwnpAeqauILMJYD0aRF0ReVMn7RQEfwn9UVHiwLx0/JMkOX0UoduuaV+Af96k5K4o8WM
        kQWv6iUVR7DQWX/WkT3Al4zalJpFwrbXMGDYqV8CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.712400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 007636C75CA53C3FB18468DF0EA4883C7EAA9232CDA8E60E3B652113FB2D35692000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDExOjEyICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIDIwMjMtMTAtMjcgYXQgMDg6MTcgKzAwMDAsIExlbmEgV2Fu
ZyAo546L5aicKSB3cm90ZToNCj4gPiBTb3JyeS4gSSBkb24ndCB1c2UgbmV0ZGV2IE1MIGJlZm9y
ZS4gSSBkbyBoYXZlIGEgZ29vZ2xlIHBhcnRuZXINCj4gYWNjb3VudA0KPiA+IGxlbmEud2FuZ0Bt
ZWRpYXRlay5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbSwgaXQgaXMganVzdGVkIHVzZWQgdG8NCj4g
cmVwb3J0DQo+ID4gR29vZ2xlIGJ1ZyBhbmQgZG9uJ3Qga25vdyBob3cgdG8gc2VuZCBhIGVtYWls
LiBJIHRyeSB0byB1c2UgdGV4dA0KPiBmb3JtYWwNCj4gPiB0byByZXBseSBtYWlsLg0KPiANCj4g
SSdtIHNvcnJ5IGlmIHRoZSBmb2xsb3dpbmcgY2FuIHNvdW5kIG5vdCB2ZXJ5IHBvbGl0ZSwgYnV0
IHJlYWxseSB5b3UNCj4gaGF2ZSB0byBtb3ZlIHRoaXMgY29udmVyc2F0aW9uIG9uIHRoZSBuZXRk
ZXYgTUwgb3IgdG8gdGhlIGdvb2dsZQ0KPiBzdXBwb3J0Lg0KPiANCj4gQ2hlZXJzLA0KPiANCj4g
UGFvbG8NCj4gDQpIaSBQYW9sbywNClNvcnJ5LCBJIGFkZCB0aGUgbmV0ZGV2IGluIGNjIGFuZCBp
ZiBpdCBpcyBvbiBuZXRkZXYgTUwuIA0KPT09PT09PT09PT09PT09PT09PT09PT09PT0NCkkgaGF2
ZSBtZXJnZWQgeW91ciBwYXRjaCBpbiB0aGUgbG9hZCBhbmQgdGhlIGtlcm5lbCBwYW5pYyBoYXBw
ZW5zIHdpdGgNCnlvdXIgcGF0Y2guICBUaGUgY3Jhc2hlZCBza2Igd2l0aCBjbG9uZWQgPSAwIGFu
ZCB1c2VycyA9IDIuIEkgYW0gYWZyYWlkDQp0aGUgcGF0Y2ggZG9lc24ndCB3b3JrIGJlY2F1c2Ug
dGhlIHNoYXJlZCBza2IgaXMgbm90IGNoZWNrZWQuDQoNCkkgYW0gbm90IHN1cmUgaWYgeW91IGNv
dWxkIHN1Ym1pdCB5b3VyIHByZXZpb3VzIHBhdGNoIHdpdGg6DQogKyAgICAgICBpZiAoV0FSTl9P
Tl9PTkNFKHNrYl9zaGFyZWQoc2tiKSkpIHsNCiArICAgICAgICAgICAgICAgc2tiID0NCnNrYl9z
aGFyZV9jaGVjayhza2IsIEdGUF9BVE9NSUMpOw0KICsgICAgICAgICAgICAgICBpZiAoIXNrYikN
Cg0KKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfbGluZWFyaXplOw0KICsgICAgICAg
fQ0KDQoNCg0KIGRpZmYgLS1naXQgYS9uZXQvY29yZS9za2J1ZmYuYyBiL25ldC9jb3JlL3NrYnVm
Zi5jDQogaW5kZXggY2VhMjhkMzBhYmI1Li4xYjIzOTRlYmFmMzMgMTAwNjQ0DQogLS0tIGEvbmV0
L2NvcmUvc2tidWZmLmMNCiArKysgYi9uZXQvY29yZS9za2J1ZmYuYw0KIEBAIC00MjcwLDYgKzQy
NzAsMTcgQEAgc3RydWN0IHNrX2J1ZmYgKnNrYl9zZWdtZW50X2xpc3Qoc3RydWN0IHNrX2J1ZmYN
Cipza2IsDQoNCiAgICAgICAgIHNrYl9wdXNoKHNrYiwgLXNrYl9uZXR3b3JrX29mZnNldChza2Ip
ICsgb2Zmc2V0KTsNCg==
