Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB67516C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjGMD32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjGMD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:29:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F61FEE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:29:23 -0700 (PDT)
X-UUID: 727729c2212d11ee9cb5633481061a41-20230713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GzfXdx4ZiyfcoU8FDNwFy1C1gvS22nK6f/ewpHGFt2Y=;
        b=tQWeVAHKCssgViY83dssqibPI/5E4/DzUY72IvxJI2DXM0LBFxyXpoVQE1st/0/sj+am381T69+HUAQyGUkO32UhopLgjz+1TlTlTMCxQcEUoABYoOEv7pOCoebCmKY9D7vkewptRHE4s4ZyIiMbeMZIEq2agEL/GtLWVJyP854=;
X-CID-CACHE: Type:Local,Time:202307131125+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:c903bf06-a8ce-4ad2-8614-b2a00eebcaef,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:fc6f2c68-314d-4083-81b6-6a74159151eb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 727729c2212d11ee9cb5633481061a41-20230713
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <john.hsu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1789725832; Thu, 13 Jul 2023 11:29:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 13 Jul 2023 11:29:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 13 Jul 2023 11:29:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkzYLb9IjuP34U6fGzWC/QIi57fKiEIAfR8DzfTR2bwro8idESwVTZBXY+w6qT4AuhMOCHlG0m8k3/gRBkE9GlXA2yZXgepDEPAaQvMcADh7oJ6uxeILTIiLr/E7bV1mbSvSz1GJl+FF1iXqq4TO1RkOB5nBG8uLOk4yKXmljsGK+STopEc6F8x+83l8keUq0K6ckmheqkx3FDU7YXYCW4ublUmvayRyNq0BJ9q0Ss63S8iks5WnfcRP3VMDMGf/QHIktbtyylUed5foT2kFhTALDNRCFi1t6l3z7C1scUAsYILk1SpDjNjVTRvV+294T3n9e6SENdh3U2ilmHKYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzfXdx4ZiyfcoU8FDNwFy1C1gvS22nK6f/ewpHGFt2Y=;
 b=OgFifjp5cJVZ67a5ojz1iTuOS1cu43c/ik4ZPOFiTM7B/psVM808NUdmlB6rMoGLfyq69jnHnI8cI9ijeknIvhrN1I8FHR1o4mlCz1ca3JFmgMmpAFAv0IoIr3sHNJlsfUfK+6H5OlOoSsY9WWf6tJcAkvXSETXDkgfxUzIH34yume7bLVsk8fHwBciBxkSGN5QEbP2Fn1diJt6Lahz4G5JTDK74ycSrwjUtsaK5YVIwgBPGHelxt1ld4B1kIaPfB1n5EWVVIffJKPcJEeRK8aPlv0BKI2oCM0npK+wkGpCkZtBCe32vPAWKeWoQ9teJBZpz2r4Sb/tB0hvL4vRE7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzfXdx4ZiyfcoU8FDNwFy1C1gvS22nK6f/ewpHGFt2Y=;
 b=Jk7yrx5NAnPPsBRtykqzsveCKHOsDml+ZXrADkIZFMpGB8ItMMqVA+7TuLBc2t9AlPAy37ufWOiI+16P4xlzGG8ldElbHQCg6swHpSfMPDCwBKMtZY1ca9rbMVU74Qz5tUvC6U9aoAAD//lbu2y2vMCZHHN+gJkD3YCJsNk/dl8=
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com (2603:1096:301:b3::11)
 by TYZPR03MB6164.apcprd03.prod.outlook.com (2603:1096:400:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 03:29:14 +0000
Received: from PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::d21:7640:7279:f22a]) by PUZPR03MB5963.apcprd03.prod.outlook.com
 ([fe80::d21:7640:7279:f22a%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 03:29:14 +0000
From:   =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
To:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>
CC:     =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        =?utf-8?B?Sm9obiBIc3UgKOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Topic: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Thread-Index: AQHZmq2hr8VIEXfZDUmuykLw57Rh9K+IzHcAgAEbhYCAAJTEAIACtPMAgCAPjwCABeNrgIAAGmyAgAP+74CAAAEAgA==
Date:   Thu, 13 Jul 2023 03:29:13 +0000
Message-ID: <66e191f8d7f3fb42f6d381a0085feb8aecef2b79.camel@mediatek.com>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
         <20230613141114.bwbnqsdazqbmyj3u@revolver>
         <3b14df2fc2a7f18fe12f87a27574b7d40f2899ba.camel@mediatek.com>
         <20230614155826.cxcpv33hs763gyrg@revolver>
         <ed7899c7328aabfbe9bc9589f0776a75e6c9d1ee.camel@mediatek.com>
         <20230706185436.agobbv72o3hma43z@revolver>
         <3507fdacf001c49f4c73f2952257beabfe9e1a53.camel@mediatek.com>
         <20230710142425.t5vhrqkjd7ugbmad@revolver>
         <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
In-Reply-To: <f7aec937af73798c5e42b7e37adb744df5562cca.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5963:EE_|TYZPR03MB6164:EE_
x-ms-office365-filtering-correlation-id: 60a5f464-a9e3-4303-f802-08db835154bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QICrcec/3XhqF3c4xQzxl/ugHAyimD2b85I35XlF89xMpkT1dFfZ8Sg+mQHf/tkfhzOSxi66txyS+bPioSE0NPLldHgyC68I99oECo6FW5yFoIJpbtytVh0f51eZ6LafWed+vp2WFUhMN1J50aqdgS8qChr6498cF/kM9il+mTP3lw5lkoKp7XwHbTYUzmMQD47FdcZugqdxJTt99UlYdnIyq7YplRn+f9lzOd6v5CvR9bNCjuhK9tbo0o4Y6OKOut+9adrr3dFei2UFyzsw8sTT0ZVIDABjfpGGAQDRb6jNEHwdnGX24TT8hiSSNjABtjrAVsU4wrzt1TTcnjswkJu1P9rVRJ+ImEeEHBUtvMTYG5ul21mxKR7b6D1kY8sfsUgcyVUcqB7j2CBK9GwIq0LcAUazLrP0htJwJ71XRRWBqfNjwFjj9CX61TGeXhuDRq0/CNYT/HQsk5N6gRjhgKRo+1J6iIxmpDAxOQ4+JYS/jOuo70vbhzIr5EKFb4b9tefmOQa4oef65u3XuamrVN0duZxObQK1bi8KahTXoyy+67O3Kl3VE/P5rxWfDOUfdM0U3XWrw6bJhH5qNLzbl1228PrMcTpYNdGN/OtUUds885lXJ2RQAd5lB5bPdSi6XDBGt2MN5Eo1ApDx5DCVt8ttUUK2IcGCQ1qXuFVIkR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5963.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(451199021)(2906002)(122000001)(6512007)(38100700002)(83380400001)(2616005)(186003)(107886003)(26005)(86362001)(6506007)(5660300002)(38070700005)(8676002)(85182001)(36756003)(8936002)(478600001)(54906003)(71200400001)(66556008)(66946007)(41300700001)(66476007)(4326008)(91956017)(64756008)(316002)(6916009)(76116006)(66446008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1QQ0ptbkpXVlMydXNWbjBtM1dMaDhPSnBEQzBHQ2dZN2VudS9uemZ0azlS?=
 =?utf-8?B?TDJ0aXBaU1VjeE5lY1ZBS1RWckdmT2k3dG5KYnJpYXZDMGhTcXd0WGh2UUpv?=
 =?utf-8?B?aFRTK0NMc2hkMCtYZHBqRTg1aXl5bjFUcE02MmJaSHlLRTZpTEkvcmxEeER6?=
 =?utf-8?B?dVlVaEpZaDFSL09YblB5TWpTNG1OeDhJN1FvdEhrc3ZSNENVOVR5TC9Rd01K?=
 =?utf-8?B?VjNxR2VMUXFveThJUWVqUGpuU0tIcjI3L0RjWUM4UlRVYzJHVUF1M3ZsWDg2?=
 =?utf-8?B?ZmpPQWFJWVdIWVRreUtiR1VqbU84SDRRM000U1Y1QkIxNkNPbTBySmxSSWZO?=
 =?utf-8?B?ZHBJbVNpTWZIdklGUklnNXdCTUcvSFBTYkpEbWJNbWxJVzFkd1pCbWx5SFdX?=
 =?utf-8?B?ejk0cHhWVVhvTC9IV1E3SVBmbkI0Vk9YVnlXWktvU21HYXlqVnNVLzdMRE1R?=
 =?utf-8?B?c29IU2JNSll6UWN6K0JxaVh0YkhQNE40K0h4a2M4Y0hTMHJuZm00cHhkeHVX?=
 =?utf-8?B?L2lna0hrL2llT1JRZHFGTDZ1SjhJQm9rdXNMT1MwTlEzZEh4ZzI5eHdqd1N0?=
 =?utf-8?B?azlDRktzZmFaaENDVUlUdjErb2syVG1XaG9TWUF5UitOcmUwbzhjRWV5TGhl?=
 =?utf-8?B?dHZualB2bW9pTkhQZkRNM0Fwb1BqZGVtdjZFZlBVdzR6K3dzQVUvcFBXcThV?=
 =?utf-8?B?SHBvQSs3LzBidXRvNklERVQzeDlieUJNLy9ZM1A3NlN2VFJvSVB5VEZTd2xW?=
 =?utf-8?B?M1FFS3I0VXl4cmYzWmxEY0hydkgycmFtOGo3VWlERXdOMThJVStkWmtSd09p?=
 =?utf-8?B?NytteE1JaXl2ZUNUdCt1U1hETEpwSjdlOWorMWRGek9yR2dEVjF5QURHVkw0?=
 =?utf-8?B?aVA4Tml4SWNmTk5rSVM2dTg3OVVzajFPWWRsWUtWN2JCdWtrbHFnUVhQR1N2?=
 =?utf-8?B?cm5EZVBFS3RBRHVub1hnWkVkZy94anlKV1NydGZINVMveXFGcFM3WUJoY3BN?=
 =?utf-8?B?R0p0a3JXK0FDR0xUdGZEMUVleFJSSzlQcFNKYTR0SWhnM0xSZkhOYnlmZ29W?=
 =?utf-8?B?V1ZvVk04bTl3UUxKZWI3YnkrVjJWSmxHdDMvQ01uSi9SeW9ubnNHY2FLQ3hu?=
 =?utf-8?B?T0MrSUNHVUpGWHBXeThFV1NhSlBvc01taG51WVUvTVBxdkE3dTRPU0ZNUTRB?=
 =?utf-8?B?UHRZVVg0RlpyaUl0NXpsL29TRzIxcU9zQWhUVzdLT3Z3dVVVd2NxWFhLZlQ3?=
 =?utf-8?B?MHI3YzJpZWYrREhOVmw1Q2ZQbFZxTjZKamoyclNDL082S0hlckk3NWlvZ25J?=
 =?utf-8?B?citjTGZrWEt5SWVGNnBMZmU5QXRscW5VaUxyWEVKRWpscDRVOS9jeUc4aFVN?=
 =?utf-8?B?WjZxYnAyd1RmdXRxczNrZ2J0RDlOUW5tMEdZNDBSRGdML2tTanBLa1hqbkJH?=
 =?utf-8?B?MTJvWnV2V3h1aCtmbGMzeTVLZkw2WnE2UGhpSnIwNnZPa2dwQUxqV2l0Yi9j?=
 =?utf-8?B?dXFrTVpuMDRUbGRrNHFJZFFtenVKbS9PQUxyU3dpRDN6TmQ5dnRPUG81amFv?=
 =?utf-8?B?UXVFUnBIOHdQeERub20wUm5iSGgzSWFkWjZOL3VYTjJxc0VuWXRvRXArSEdO?=
 =?utf-8?B?dGlZQ01Oejl6RXpRMlpOdVRZTkphNnJDekZha3FWblFOZXkxcFBxWXVpekxP?=
 =?utf-8?B?WGxrYWZjcy9MNERZeURZc0t6WXF3c0VuSEgyUDc2Y0IrT0l1ZEg3QWRPd0FJ?=
 =?utf-8?B?Z0xTaVlGWlpDTXI2aE9yNjB6UlR6K2RkSzNidkJuSENya0g5L0U3UjRRYTFi?=
 =?utf-8?B?ZDFSSTBQUGpMNmdGdVMxNGV4aWg5cC9KUFRSK1BQYjVOb2ZTVDF2VXRpc0N2?=
 =?utf-8?B?QTJ1NVNBWmhWOHpnWSs3dXNpK3VSbGJrWG51aWFDOU85STNkRCtqcUI0ZmtG?=
 =?utf-8?B?WTBubHpiOWxNNHhYRUJlYzAwMGV5VHFsYUkyaDdaUDRHYk5pbkRWM0g5eDJV?=
 =?utf-8?B?Q3JMR25xUTQ1cXhNcXZ0UmRaaktQOEJQVVBlRFRZQTlHNFZzZ3pNMUgyRDZG?=
 =?utf-8?B?b2YvcWZIRTJyWjVyZWU2bjhGcUt5dU12MTA5UXp4NXVmL0xoNXd3QUh2NUYw?=
 =?utf-8?B?NWdMSUtscXUrS3Nmb1hCKzdhREJXdHJkL3pOdXY2NDVJT1dWTzE2dnBDZVhn?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <285103242004264E9484A9FA2FE6BF4D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5963.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a5f464-a9e3-4303-f802-08db835154bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 03:29:13.9972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urHOEEzDsNG/O6ztO04l+mzRs4Lb8M8h8UE/jeFnnbFPa4AbEPJW/TnF2IQzXA3Zzf4p0ndbQuFhCwgDN0dNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDExOjI1ICswODAwLCBKb2huIEhzdSB3cm90ZToNCj4gT24g
TW9uLCAyMDIzLTA3LTEwIGF0IDEwOjI0IC0wNDAwLCBMaWFtIFIuIEhvd2xldHQgd3JvdGU6DQo+
ID4gIAkgDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gICogSm9obiBIc3UgKOioseawuOe/sCkgPEpvaG4u
SHN1QG1lZGlhdGVrLmNvbT4gWzIzMDcxMCAwODo1MF06DQo+ID4gLi4uDQo+ID4gDQo+ID4gPiA+
ID4gPiA+IFRoaXMgQlVHX09OKCkgaXMgbmVjZXNzYXJ5IHNpbmNlIHRoaXMgZnVuY3Rpb24gc2hv
dWxkDQo+ID4gDQo+ID4gX25ldmVyXw0KPiA+ID4gPiBydW4NCj4gPiA+ID4gPiA+IG91dCBvZg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gbWVtb3J5OyB0aGlzIGZ1bmN0aW9uIGRvZXMg
bm90IHJldHVybiBhbiBlcnJvciBjb2RlLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBtYXNf
cHJlYWxsb2NhdGUoKQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gc2hvdWxkIGhhdmUg
Z290dGVuIHlvdSB0aGUgbWVtb3J5IG5lY2Vzc2FyeSAob3IgcmV0dXJuZWQNCj4gPiA+ID4gPiA+
ID4gYW4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLUVOT01FTSkNCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IHByaW9yIHRvIHRoZSBjYWxsIHRvIG1hc19zdG9yZV9wcmVhbGxvYygp
LCBzbyB0aGlzIGlzDQo+ID4gDQo+ID4gcHJvYmFibHkNCj4gPiA+ID4gYW4NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IGludGVybmFsIHRyZWUgcHJvYmxlbS4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IFRoZXJlIGlzIGEgdHJlZSBvcGVyYXRpb24gYmVpbmcgcGVyZm9ybWVk
IGhlcmUuICBtcHJvdGVjdA0KPiA+IA0KPiA+IGlzDQo+ID4gPiA+ID4gPiBtZXJnaW5nIGENCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IHZtYSBieSB0aGUgbG9va3Mgb2YgdGhlIGNhbGwg
c3RhY2suICBXaHkgZG8geW91IHRoaW5rIG5vDQo+ID4gDQo+ID4gdHJlZQ0KPiA+ID4gPiA+ID4g
b3BlcmF0aW9uDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBpcyBuZWNlc3Nhcnk/DQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBcyB5b3UgbWVudGlvbmVkLCBtYXNfcHJlYWxs
b2NhdGUoKSBzaG91bGQgYWxsb2NhdGUNCj4gPiA+ID4gPiA+ID4gZW5vdWdoDQo+ID4gPiA+IA0K
PiA+ID4gPiBub2RlLA0KPiA+ID4gPiA+ID4gYnV0IHRoZXJlIGlzIHN1Y2ggZnVuY3Rpb25zIG1h
c19ub2RlX2NvdW50KCkgaW4NCj4gPiA+ID4gDQo+ID4gPiA+IG1hc19zdG9yZV9wcmVhbGxvYygp
Lg0KPiA+ID4gPiA+ID4gPiBJbiBtYXNfbm9kZV9jb3VudCgpIGNoZWNrcyB3aGV0aGVyIHRoZSAq
bWFzKiBoYXMgZW5vdWdoDQo+ID4gDQo+ID4gbm9kZXMsDQo+ID4gPiA+IGFuZA0KPiA+ID4gPiA+
ID4gYWxsb2NhdGUgbWVtb3J5IGZvciBub2RlIGlmIHRoZXJlIHdhcyBubyBlbm91Z2ggbm9kZXMg
aW4NCj4gPiA+ID4gPiA+IG1hcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUmlnaHQsIHdl
IGNhbGwgbWFzX25vZGVfY291bnQoKSBzbyB0aGF0IGJvdGggY29kZSBwYXRocyBhcmUNCj4gPiAN
Cj4gPiB1c2VkDQo+ID4gPiA+IGZvcg0KPiA+ID4gPiA+ID4gcHJlYWxsb2NhdGlvbnMgYW5kIHJl
Z3VsYXIgbWFzX3N0b3JlKCkvbWFzX3N0b3JlX2dmcCgpLiAgSXQNCj4gPiA+ID4gDQo+ID4gPiA+
IHNob3VsZG4ndA0KPiA+ID4gPiA+ID4gdGFrZSBhIHNpZ25pZmljYW50IGFtb3VudCBvZiB0aW1l
IHRvIHZlcmlmeSB0aGVyZSBpcyBlbm91Z2gNCj4gPiA+ID4gDQo+ID4gPiA+IG5vZGVzLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFlhcC4uLiwgaXQgZGlkbid0IHRha2UgYSBzaWduaWZpY2FudCBh
bW91bnQgb2YgdGltZSB0byB2ZXJpZnkNCj4gPiA+ID4gDQo+ID4gPiA+IHdoZXRoZXINCj4gPiA+
ID4gPiB0aGVyZSBpcyBlbm91Z2ggbm9kZXMuIFRoZSBwcm9ibGVtIGlzIHdoeSB0aGUgZmxvdyBp
bg0KPiA+ID4gPiANCj4gPiA+ID4gbWFzX25vZGVfY291bnQNCj4gPiA+ID4gPiB3aWxsIGFsbG9j
IG5vZGVzIGlmIHRoZXJlIHdhcyBubyBlbm91Z2ggbm9kZXMgaW4gbWFzPw0KPiA+ID4gPiANCj4g
PiA+ID4gV2hhdCBJIG1lYW50IGlzIHRoYXQgYm90aCBtZXRob2RzIHVzZSB0aGUgc2FtZSBjYWxs
IHBhdGgNCj4gPiA+ID4gYmVjYXVzZQ0KPiA+ID4gPiB0aGVyZQ0KPiA+ID4gPiBpcyBub3QgYSBy
ZWFzb24gdG8gZHVwbGljYXRlIHRoZSBwYXRoLiAgQWZ0ZXIgbWFzX3ByZWFsbG9jYXRlKCkNCj4g
PiANCj4gPiBoYXMNCj4gPiA+ID4gYWxsb2NhdGVkIHRoZSBub2RlcyBuZWVkZWQsIHRoZSBjYWxs
IHRvIGNoZWNrIGlmIHRoZXJlIGlzDQo+ID4gPiA+IGVub3VnaA0KPiA+ID4gPiBub2Rlcw0KPiA+
ID4gPiB3aWxsIGJlIHF1aWNrLg0KPiA+ID4gDQo+ID4gPiBTbyB3aGV0aGVyIHRoZSBwdXJwb3Nl
IG9mIG1hc19wcmVhbGxvY2F0ZSgpIGlzIGRlY3JlYXNpbmcgdGhlDQo+ID4gPiBsb2NrDQo+ID4g
PiByZXRlbnRpb24gdGltZT8NCj4gPiANCj4gPiBJdCBjb3VsZCBiZSwgYnV0IGluIHRoaXMgY2Fz
ZSBpdCdzIHRoZSBsb2NraW5nIG9yZGVyLiAgV2UgaGF2ZSB0bw0KPiA+IHByZS1hbGxvY2F0ZSBh
bmQgZmFpbCBlYXJseSBpZiB3ZSBhcmUgb3V0IG9mIG1lbW9yeSwgYmVjYXVzZSB3ZQ0KPiA+IF9j
YW5ub3RfDQo+ID4gdXNlIEdGUF9LRVJORUwgd2hlcmUgd2UgY2FsbA0KPiA+IG1hc19zdG9yZV9w
cmVhbGxvYygpLiAgbWFzX3ByZWFsbG9jYXRlKCkNCj4gPiB3aWxsIHVzZSBHRlBfS0VSRU5MIHRo
b3VnaC4gIFdlIGNhbm5vdCB1c2UgR0ZQX0tFUk5FTCBkdXJpbmcgdGhlDQo+ID4gc3RvcmUNCj4g
PiBiZWNhdXNlIHJlY2xhaW0gbWF5IHNsZWVwIGFuZCB3ZSBjYW5ub3Qgc2xlZXAgaG9sZGluZyB0
aGUgbG9ja3Mgd2UNCj4gPiBuZWVkDQo+ID4gdG8gaG9sZCBhdCB0aGUgdGltZSBvZiB0aGUgc3Rv
cmUgb3BlcmF0aW9uIGluIF9fdm1hX2FkanVzdCgpLg0KPiA+IA0KPiANCj4gWWFwLCBpZiB0aGUg
dHlwZSBvZiBsb2NrIGlzIHNwaW5sb2NrLCB0aGUgZmxvdyBzaG91bGRuJ3Qgc2xlZXAgaW4gdGhl
DQo+IGNyaXRpY2FsIHNlY3Rpb25zLiBtbWFwX2xvY2sgaXMgaW1wbG1lbnRlZCBieSByd19zZW1h
cGhvcmUobXV0ZXgpLiBJcw0KPiB0aGVyZSBhbnkgb3RoZXIgbG9jayBpbiB0aGlzIHNlY3Rpb24/
DQo+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSSB0aGluayB0aGF0IGlmIG1hc19w
cmVhbGxvY2F0ZSgpIGFsbG9jYXRlIGVub3VnaCBub2RlLA0KPiA+ID4gPiA+ID4gPiB3aHkNCj4g
PiANCj4gPiB3ZQ0KPiA+ID4gPiA+ID4gY2hlY2sgdGhlIG5vZGUgY291bnQgYW5kIGFsbG9jYXRl
IG5vZGVzIGlmIHRoZXJlIHdhcyBubw0KPiA+IA0KPiA+IGVub3VnaA0KPiA+ID4gPiBub2Rlcw0K
PiA+ID4gPiA+ID4gaW4gbWFzIGluIG1hc19ub2RlX2NvdW50KCk/DQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IFdlIGNoZWNrIGZvciB0aGUgYWJvdmUgcmVhc29uLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gT0suLi4sIHRoaXMgaXMgb25lIG9mIHRoZSByb290IGNhdXNl
IG9mIHRoaXMgQlVHLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0
aGVyZSB3YXMgbm90IGVub3VnaCBtZW1vcnkgZm9yIGEgc3RvcmUNCj4gPiA+ID4gb3BlcmF0aW9u
LiAgUmVnYXJkbGVzcyBvZiBpZiB3ZSBjaGVjayB0aGUgYWxsb2NhdGlvbnMgaW4gdGhlDQo+ID4g
PiA+IG1hc19zdG9yZV9wcmVhbGxvYygpIHBhdGggb3Igbm90LCB0aGlzIHdvdWxkIGZhaWwuICBJ
ZiB3ZQ0KPiA+ID4gPiByZW1vdmUNCj4gPiANCj4gPiB0aGUNCj4gPiA+ID4gY2hlY2sgZm9yIG5v
ZGVzIHdpdGhpbiB0aGlzIHBhdGgsIHRoZW4gd2Ugd291bGQgaGF2ZSB0bw0KPiA+ID4gPiBCVUdf
T04oKQ0KPiA+IA0KPiA+IHdoZW4NCj4gPiA+ID4gd2UNCj4gPiA+ID4gcnVuIG91dCBvZiBub2Rl
cyB0byB1c2Ugb3IgaGF2ZSBhIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBCVUcNCj4gPiA+ID4g
YW55d2F5cy4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFlhcCwgdGhlIHJvb3QgY2F1c2UgaXMg
b29tLiBUaGUgQlVHX09OKCkgZm9yIHRoZSBzaXR1YXRpb25zIHRoYXQNCj4gPiANCj4gPiB0aGUN
Cj4gPiA+IG1hcGxlIHRyZWUgc3RydWN0IGNhbm5vdCBiZSBtYWludGFpbmVkIGJlY2F1c2Ugb2Yg
dGhlIGxhY2sgb2YNCj4gPiANCj4gPiBtZW1vcnkgaXMNCj4gPiA+IG5lY2Vzc2FyeS4gQnV0IHRo
ZSB0aGUgYnVkZHkgc3lzdGVtIGluIGxpbnV4IGtlcm5lbCBjYW4gcmVjbGFpbQ0KPiA+IA0KPiA+
IG1lbW9yeQ0KPiA+ID4gd2hlbiB0aGUgc3lzdGVtIGlzIHVuZGVyIHRoZSBsb3cgbWVtb3J5IHN0
YXR1cy4gSWYgd2UgdXNlDQo+ID4gDQo+ID4gR0ZQX0tFUk5FTA0KPiA+ID4gYWZ0ZXIgdHJ5aW5n
IEdGUF9OT1dBSVQgdG8gYWxsb2NhdGUgbm9kZSwgbWF5YmUgd2UgY2FuIGdldCBlbm91Z2gNCj4g
PiA+IG1lbW9yeSB3aGVuIHRoZSBzZWNvbmQgdHJ5IHdpdGggR0ZQX0tFUk5FTC4gDQo+ID4gDQo+
ID4gUmlnaHQsIGJ1dCB0aGUgR0ZQX0tFUk5FTCBjYW5ub3QgYmUgdXNlZCB3aGVuIGhvbGRpbmcg
Y2VydGFpbiBsb2Nrcw0KPiA+IGJlY2F1c2UgaXQgbWF5IHNsZWVwLg0KPiA+IA0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gV2UgaGF2ZSBzZWVuIHRoYXQgdGhlcmUg
bWF5IGJlIHNvbWUgbWFwbGVfdHJlZSBvcGVyYXRpb25zDQo+ID4gDQo+ID4gaW4NCj4gPiA+ID4g
PiA+IG1lcmdlX3ZtYS4uLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJZiBtZXJnZV92bWEo
KSBkb2VzIGFueXRoaW5nLCB0aGVuIHRoZXJlIHdhcyBhbiBvcGVyYXRpb24NCj4gPiA+ID4gPiA+
IHRvDQo+ID4gDQo+ID4gdGhlDQo+ID4gPiA+ID4gPiBtYXBsZQ0KPiA+ID4gPiA+ID4gdHJlZS4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gTW9yZW92ZXIsIHdv
dWxkIG1hcGxlX3RyZWUgcHJvdmlkZXMgYW4gQVBJIGZvciBhc3NpZ25pbmcNCj4gPiANCj4gPiB1
c2VyJ3MNCj4gPiA+ID4gZ2ZwDQo+ID4gPiA+ID4gPiBmbGFnIGZvciBhbGxvY2F0aW5nIG5vZGU/
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IG1hc19wcmVhbGxvY2F0ZSgpIGFuZCBtYXNfc3Rv
cmVfZ2ZwKCkgaGFzIGdmcCBmbGFncyBhcyBhbg0KPiA+ID4gPiA+ID4gYXJndW1lbnQuICBJbg0K
PiA+ID4gPiA+ID4geW91ciBjYWxsIHN0YWNrLCBpdCB3aWxsIGJlIGNhbGxlZCBpbiBfX3ZtYV9h
ZGp1c3QoKSBhcw0KPiA+ID4gPiA+ID4gc3VjaDoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
aWYgKG1hc19wcmVhbGxvY2F0ZSgmbWFzLCB2bWEsIEdGUF9LRVJORUwpKQ0KPiA+ID4gPiA+ID4g
cmV0dXJuIC1FTk9NRU07DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGxpbmUgNzE1IGluIHY2
LjEuMjUNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJbiByYl90cmVlLCB3ZSBhbGxvY2F0
ZSB2bWFfYXJlYV9zdHJ1Y3QgKHJiX25vZGUgaXMgaW4NCj4gPiA+ID4gPiA+ID4gdGhpcw0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBzdHJ1Y3QuKSB3aXRoIEdGUF9LRVJORUwsIGFuZCBtYXBs
ZV90cmVlIGFsbG9jYXRlIG5vZGUgd2l0aA0KPiA+ID4gPiA+ID4gR0ZQX05PV0FJVCBhbmQgX19H
RlBfTk9XQVJOLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXZSB1c2UgR0ZQX0tFUk5FTCBh
cyBJIGV4cGxhaW5lZCBhYm92ZSBmb3IgdGhlIFZNQSB0cmVlLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEdvdCBpdCEgQnV0IHRoZSBtYXNfbm9kZV9jb3VudCgpIGFsd2F5cyB1c2UgR0ZQX05PV0FJ
VCBhbmQNCj4gPiA+ID4gDQo+ID4gPiA+IF9fR0ZQX05PV0FSTg0KPiA+ID4gPiA+IGluIGluc2Vy
dGluZyB0cmVlIGZsb3cuIERvIHlvdSBjb25zaWRlciB0aGUgcGVyZm9ybWFuY2Ugb2YNCj4gPiA+
ID4gDQo+ID4gPiA+IG1haW50YWluaW5nDQo+ID4gPiA+ID4gdGhlIHN0cnVjdHVyZSBvZiBtYXBs
ZV90cmVlPw0KPiA+ID4gPiANCj4gPiA+ID4gU29ycnksIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0
IHlvdSBtZWFuIGJ5ICdjb25zaWRlciB0aGUNCj4gPiANCj4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4g
PiBvZg0KPiA+ID4gPiBtYWludGFpbmluZyB0aGUgc3RydWN0dXJlIG9mIG1hcGxlX3RyZWUnLg0K
PiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQXMgSSBtZW50aW9uZWQgYWJvdmUsIEdGUF9OT1dBSVQg
d2lsbCBub3QgYWxsb3cgYnVkZHkgc3lzdGVtIGZvcg0KPiA+ID4gcmVjbGFpbWluZyBtZW1vcnks
IHNvICJEbyB5b3UgY29uc2lkZXIgdGhlIHBlcmZvcm1hbmNlIG9mDQo+ID4gDQo+ID4gbWFpbnRh
aW5pbmcNCj4gPiA+IHRoZSBzdHJ1Y3R1cmUgb2YgbWFwbGVfdHJlZSIgbWVhbnMgdGhhdDogd2hl
dGhlciB0aGUNCj4gPiANCj4gPiBtYXNfbm9kZV9jb3VudCgpDQo+ID4gPiBwYXRoIGlzIG5vdCBh
bGxvd2VkIHRvIHJlY2xhaW0gb3IgY29tcGFjdCBtZW1vcnkgZm9yIHRoZQ0KPiA+IA0KPiA+IHBl
cmZvcm1hbmNlLg0KPiA+IA0KPiA+IEFoLCBuby4gIFRoaXMgaXMgbm90IGZvciBwZXJmb3JtYW5j
ZS4gIEl0IHdhcyBpbml0aWFsbHkgb24gdGhlIHJvYWQNCj4gPiBtYXANCj4gPiBmb3IgcGVyZm9y
bWFuY2UsIGJ1dCBpdCB3YXMgbmVlZGVkIGZvciB0aGUgY29tcGxpY2F0ZWQgbG9ja2luZyBpbg0K
PiA+IHRoZQ0KPiA+IE1NDQo+ID4gY29kZS4NCj4gPiANCj4gPiByYiB0cmVlIGVtYmVkZGVkIHRo
ZSBub2RlcyBpbiB0aGUgVk1BIHdoaWNoIGlzIGFsbG9jYXRlZCBvdXRzaWRlDQo+ID4gdGhpcw0K
PiA+IGNyaXRpY2FsIHNlY3Rpb24gYW5kIHNvIGl0IGNvdWxkIHVzZSBHRlBfS0VSTkVMLg0KPiA+
IA0KPiANCj4gQXMgSSBrbm93LCBmb2xsb3dpbmcgaXMgcmJfdHJlZSBmbG93IGluIDUuMTUuMTg2
Og0KPiANCj4gLi4uDQo+IG1tYXBfd3JpdGVfbG9ja19raWxsYWJsZShtbSkNCj4gLi4uDQo+IGRv
X21tYXAoKQ0KPiAuLi4NCj4gbW1hcF9yZWdpb24oKQ0KPiAuLi4NCj4gdm1fYXJlYV9hbGxvYyht
bSkNCj4gLi4uDQo+IG1tYXBfd3JpdGVfdW5sb2NrKG1tKQ0KPiANCj4gdm1fYXJlYV9hbGxvYyBp
cyBpbiB0aGUgbW1hcF9sb2NrIGhvZGluZyBwZXJpb2QuDQo+IEl0IHNlZW1zIHRoYXQgdGhlIGZs
b3cgd291bGQgc2xlZXAgaGVyZSBpbiByYl90cmVlIGZsb3cuDQo+IElmIEkgbWlzcyBhbnl0aGlu
ZywgcGxlYXNlIHRlbGwgbWUsIHRoYW5rcyENCj4gDQo+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gSXQgYWxzbyB3aWxsIGRyb3AgdGhlIGxvY2sgYW5kIHJldHJ5IHdpdGggR0ZQX0tFUk5FTCBv
bg0KPiA+IA0KPiA+IGZhaWx1cmUNCj4gPiA+ID4gPiA+IHdoZW4gbm90IHVzaW5nIHRoZSBleHRl
cm5hbCBsb2NrLiAgVGhlIG1tYXBfbG9jayBpcw0KPiA+IA0KPiA+IGNvbmZpZ3VyZWQgYXMNCj4g
PiA+ID4gYW4NCj4gPiA+ID4gPiA+IGV4dGVybmFsIGxvY2suDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gQWxsb2NhdGlvbiB3aWxsIG5vdCB3YWl0IGZvciByZWNsYWltaW5nIGFuZCBjb21w
YWN0aW5nDQo+ID4gPiA+ID4gPiA+IHdoZW4NCj4gPiA+ID4gDQo+ID4gPiA+IHRoZXJlDQo+ID4g
PiA+ID4gPiBpcyBubyBlbm91Z2ggYXZhaWxhYmxlIG1lbW9yeS4NCj4gPiA+ID4gPiA+ID4gSXMg
dGhlcmUgYW55IGNvbmNlcm4gZm9yIHRoaXMgZGVzaWduPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBUaGlzIGhhcyBiZWVuIGFkZHJlc3NlZCBhYm92ZSwgYnV0IGxldCBtZSBrbm93IGlmIEkg
bWlzc2VkDQo+ID4gPiA+IA0KPiA+ID4gPiBhbnl0aGluZw0KPiA+ID4gPiA+ID4gaGVyZS4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhpbmsgdGhhdCB0aGUgbWFzX25v
ZGVfY291bnQoKSBoYXMgaGlnaGVyIHJhdGUgb2YNCj4gPiA+ID4gPiB0cmlnZ2VyaW5nDQo+ID4g
PiA+ID4gQlVHX09OKCkgd2hlbiBhbGxvY2F0aW5nIG5vZGVzIHdpdGggR0ZQX05PV0FJVCBhbmQN
Cj4gPiANCj4gPiBfX0dGUF9OT1dBUk4uIElmDQo+ID4gPiA+ID4gbWFzX25vZGVfY291bnQoKSB1
c2UgR0ZQX0tFUk5FTCBhcyBtYXNfcHJlYWxsb2NhdGUoKSBpbiB0aGUNCj4gPiANCj4gPiBtbWFw
LmMsDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGFsbG9jYXRpb24gZmFpbCByYXRlIG1heSBiZSBs
b3dlciB0aGFuIHVzZSBHRlBfTk9XQUlULg0KPiA+ID4gPiANCj4gPiA+ID4gV2hpY2ggQlVHX09O
KCkgYXJlIHlvdSByZWZlcnJpbmcgdG8/DQo+ID4gPiA+IA0KPiA+ID4gPiBJZiBJIHdhcyB0byBz
ZXBhcmF0ZSB0aGUgY29kZSBwYXRoIGZvciBtYXNfc3RvcmVfcHJlYWxsb2MoKSBhbmQNCj4gPiA+
ID4gbWFzX3N0b3JlX2dmcCgpLCB0aGVuIGEgQlVHX09OKCkgd291bGQgc3RpbGwgbmVlZCB0byBl
eGlzdCBhbmQNCj4gPiANCj4gPiBzdGlsbA0KPiA+ID4gPiB3b3VsZCBoYXZlIGJlZW4gdHJpZ2dl
cmVkLi4gIFdlIGFyZSBpbiBhIHBsYWNlIGluIHRoZSBjb2RlDQo+ID4gPiA+IHdoZXJlDQo+ID4g
DQo+ID4gd2UNCj4gPiA+ID4gc2hvdWxkIG5ldmVyIHNsZWVwIGFuZCB3ZSBkb24ndCBoYXZlIGVu
b3VnaCBtZW1vcnkgYWxsb2NhdGVkIHRvDQo+ID4gDQo+ID4gZG8NCj4gPiA+ID4gd2hhdA0KPiA+
ID4gPiB3YXMgbmVjZXNzYXJ5Lg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gWWFwLiBUaGVyZSBp
cyBubyByZWFzb24gdG8gc2VwcmF0ZSBtYXNfc3RvcmVfcHJlYWxsb2MoKSBhbmQNCj4gPiA+IG1h
c19zdG9yZV9nZnAuIElzIGl0IHBvc3NpYmxlIHRvIHJldHJ5IHRvIGFsbG9jYXRlIG1hc19ub2Rl
IHdpdGgNCj4gPiA+IEdGUF9LRVJORUwgKHdhaXQgZm9yIHN5c3RlbSByZWNsYWltIGFuZCBjb21w
YWN0KSBpbnN0ZWFkIG9mDQo+ID4gDQo+ID4gdHJpZ2dlcmluZw0KPiA+ID4gQlVHX09OIG9uY2Ug
dGhlIEdGUF9OT1dBSVQgYWxsb2NhdGlvbiBmYWlsZWQ/DQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVs
eSBub3QsIG5vLiAgSW4gc29tZSBjYXNlcyBpdCBtYXkgYWN0dWFsbHkgd29yayBvdXQgdGhhdA0K
PiA+IHRoZQ0KPiA+IFZNQSBtYXkgbm90IG5lZWQgdGhlIGxvY2tzIGluIHF1ZXN0aW9uLCBidXQg
aXQgY2Fubm90IGJlDQo+ID4gZ2VuZXJhbGl6ZWQNCj4gPiBmb3INCj4gPiBfX3ZtYV9hZGp1c3Qo
KS4gIFdoZXJlIEkgYW0gYWJsZSwgSSB1c2UgdGhlIG1hc19zdG9yZV9nZnAoKSBjYWxscw0KPiA+
IHNvDQo+ID4gd2UNCj4gPiBjYW4gbGV0IHJlY2xhaW0gYW5kIGNvbXBhY3QgcnVuLCBidXQgaXQn
cyBub3QgcG9zc2libGUgaGVyZS4NCj4gPiANCj4gDQo+IFdlIGhhdmUgdXNlZCBHRlBfS0VSTkVM
IGFzIGFsbG9jIGZsYWcgaW4gbWFzX25vZGVfY291bnQgZmxvdyBhYm91dCAyDQo+IG1vbnRocy4g
VGhlIG1lbnRpb25lZCBwcm9ibGVtIHdlIG1lbnRpb25lZCBpbiB0aGUgZmlyc3QgbWFpbCBkaWRu
J3QNCj4gcmVwcm9kdWNlIHVuZGVyIGhpZ2ggc3RyZXNzIHN0YWJpbGl0eSB0ZXN0Lg0KPiANCj4g
SSBoYXZlIHNlZW4gdGhlIHBhdGNoIHByb3ZpZGVkIGJ5IHlvdS4gSSB3aWxsIHZlcmlmeSB0aGlz
IHBhdGNoIGluDQo+IG91cg0KPiBzdGFiaWxpdHkgdGVzdC4gQnV0IHRoZXJlIGlzIGEgcHJvYmxl
bSwgaWYgbWFwbGVfdHJlZSBiZWhhdmlvciBpcw0KPiB1bmV4cGVjdGVkIChlLmcuIHJlZHVuZGFu
dCB3cml0ZSBidWcgdGhpcyB0aW1lKS4gV2UgY2FuIG9ubHkgcmV2aWV3DQo+IHRoZQ0KPiB3aG9s
ZSBtbSBmbG93IHRvIGZpbmQgb3V0IHRoZSB3cm9uZyBiZWhhdmlvci4gRG8gd2UgaGF2ZSBhbiBl
ZmZpY2llbnQNCj4gZGVidWcgbWV0aG9kIGZvciBtYXBsZSB0cmVlPw0KPiANCj4gPiBUaGFua3Ms
DQo+ID4gTGlhbQ0KQmVzdCBSZWdhcmRzLA0KSm9obiBIc3UNCg==
