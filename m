Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD394773C46
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjHHQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHHQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:02:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55AC35BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:40:32 -0700 (PDT)
X-UUID: f204c7b435c611ee9cb5633481061a41-20230808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZU74V6Vt7d0ghoWMNU9oe+xFVfUShww9+Yz88EXY4rs=;
        b=a/Dl9otC/bCOVBjvuojXi5OCdpGj67Qet4Nv4y4oft5ytFxDXNRbaP2fP42OpyqqttOnc3pkdJaEVB3e1Liwqhtc36lIiYVB2scxA0TKsmbmu+e7/Q3YyclbEUor4tFYEg+m4SgaCoLNupt+2OgY3oQ6YiP/dJq2ZdzQdbwyaV8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:554220a4-ea84-4cc7-b7b8-1aaedb3167ec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:4d6e04a1-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f204c7b435c611ee9cb5633481061a41-20230808
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 653404861; Tue, 08 Aug 2023 16:38:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Aug 2023 16:38:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Aug 2023 16:38:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcK1ukKK/Q+q5XJCtxl6zy/Y3JPYdBEhLt0NYlZ1qW7KXpqvzPFr6GKHy5970K/8NR7/6WZWfwmjmhrOXZsy/yDnV15B1QjeuhA695omerpU/ddp7UI3eDTmnW1EuQHozWNpH5QOui2JfMhOxZPXWvAdD1oVuCrpbbS6/LBzSXDCKchG3nWd1f+5igk+8w58duUweVJ5bs6Gv97Rru60yR5TDZBVgJGlSkYYsKQ2kDaRIG5kHcaSsL/DJrq5IzzLtYRcnf1gjjnmU/GkOkc//jLIdHQpX0S1IE6BQLNyQI5kXfdx0MkPpCZpv3O3DRs26NmTJvhzAQBH7HdNHDk4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU74V6Vt7d0ghoWMNU9oe+xFVfUShww9+Yz88EXY4rs=;
 b=UVwVv+9wswAIs1BAJ4W8OUCwSND9/gErWT32jPwwi6ykEDEFQg5yStRQ1I+Arp5Pco63dEXIdsJQxfMaBXN5/ML4/SftlMsJ9lxV0HszHqP0x4fom4wQgOkFtBIVEZhn7Fh4zJuxeuE+CDOGC90tFKyIj5u6ME4/1shwXFDEZDQNRddkmx9DEHnzgBCXilQcyDhjGpF70/Tj+wrC0hguwyb8X6LgBPw97Y9TBci89y8wJS2G4pCcI8GEBJHb8/3FecXu9VVoC5ubi+MTsrfEeOglWMq1IKhJAnHp8F5gPAVySZU3SKNpAhJL7I0/tPtN1QxrRYtZNupSNbZCMnTJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU74V6Vt7d0ghoWMNU9oe+xFVfUShww9+Yz88EXY4rs=;
 b=DithlLEY5D5hgGe778Ocabeznn2DQYRRl7C5DlUrxtS3CQ6252FPOdHV9UISBFy/Z8pe8ZSkvqw/q4JYvP//y8uNb1GONUg5GC4hMVm4FcdVwXbhZ0Gk9XgwR5mUikAceBWlwZ8659waB8FHczB7jXHLw/3gwrJJ8p1QbQlenF0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 08:38:24 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:38:23 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Topic: [PATCH RESEND v4 2/2] drm/mediatek: Fix iommu fault during crtc
 enabling
Thread-Index: AQHZyRPpFsizTgWRg0G/DVBCFYkp76/gFTqA
Date:   Tue, 8 Aug 2023 08:38:23 +0000
Message-ID: <44b511d536ce2b96da49d03da2e301f123385c0a.camel@mediatek.com>
References: <20230807015110.30579-1-jason-jh.lin@mediatek.com>
         <20230807015110.30579-3-jason-jh.lin@mediatek.com>
         <98fe8211-52b4-37ec-a0eb-7dc0ae5a0615@baylibre.com>
In-Reply-To: <98fe8211-52b4-37ec-a0eb-7dc0ae5a0615@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5545:EE_
x-ms-office365-filtering-correlation-id: e9beb1e0-9b3d-4618-2b3c-08db97ead410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRCpze0x4LuQ5Pzc/wGBlABvsB7SK4XEsqYHSrxZ1xkpgeLIzCKjHARlS0t7Fm5bgQfPjNzdwtVmSIACBNLOfIzkvd8Ls6hXX9g3cYLQzczZt0/qSqnQ1xtlaGXYuMfL3J52lel4KESYwrLPYdFWnW32gLRzsErbT3/9tNsEDEc8rFjICWgN1CbuWo7cYPmEAto35/RWCy2JD6hAku4HccVt/w40QaR2INEqQC4SxG2gg3xZmLD3GpODnhvE1S2YO0mj8XsR3KzJ/mRMuUqB3exmAIYlIlYAW98OfKLxz6sIXuk6dVdgzfse4ntT/a8kn8YeVdXrwM1Pvia6q7t9q167PLa+cqoEQswyn5ZgAfTlVHvbq8Cv/vlEeMsov84VHTZKXnYPfWdgDkGeS3YnkP8pE2NRjNtytrQVFxRwoFFlUCemHKjDfE5sC/MaSNn62Y8gXeh2S3CAMEPSezzsJv3lQRIN9qjJrsA3RMNOwXKX73GE6AfbiMxwoYdCoBpJAnD2B5pasGb6AAvAEd7KwsXy954U6PIr5hUvxSq0NX17cZMb1/hHWlDwHR0IOE348DZn1ycDA5KxGbMRv/ADyMsVAHTqOEfBQapMI61j+/VRC6bMnHvUvTXY7eglDo5vfzgFxJDSqQX4xJ86LVrSjqSMPZPB7ov/zjuufRe6ofQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(396003)(376002)(346002)(186006)(1800799003)(451199021)(8676002)(8936002)(5660300002)(478600001)(54906003)(110136005)(71200400001)(6512007)(6486002)(83380400001)(2906002)(36756003)(53546011)(85182001)(26005)(2616005)(6506007)(66476007)(41300700001)(86362001)(4326008)(316002)(66446008)(64756008)(38070700005)(66556008)(66946007)(76116006)(91956017)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWc0Ujh1cGZDVDlRMGpjZFpIeVlBRnhLNlpYTFhhcDVBam92OHQ3MUw2NWxh?=
 =?utf-8?B?aVJ0aHJjZlBwVjFyNUF6SytxdllqOWtoUDdlWVR0aTZ4dDE5OUFRUnluQnU0?=
 =?utf-8?B?Rlpyekt3dy9pbTZvQW12WkIyS2IrbzVXeWtsUTR2OGRGcFNLK00xVFlPRVRk?=
 =?utf-8?B?Y3FPSlZUb290UGJxYTRnVmRPcENEbWJxQkJNRi9QZTRUTDkrdDNoUWx3ZG5U?=
 =?utf-8?B?RkNvbko1eHUrV3dEWFhKbkRqZWkwNE5LcStHcWRPckQ1T1hSZVprc3VqTkZO?=
 =?utf-8?B?cHVGZVRkR043aGxHcFgrVlNaRlVsNGZvWmJ3ODdrNVdMbW1qWitla2J3QUt4?=
 =?utf-8?B?endJZkFZWjdidXZGNVduLzdpcVpWeE9FYk1GdmVNZzFyT0NUSUw2S2FDTkw3?=
 =?utf-8?B?TWtiazJrbi9oWHFOZkFEWlFYdDNzakphZFJVc1piY1F2K2pYSlFEUDNiVkpM?=
 =?utf-8?B?dkp6VmYwaGpRTlVIN1BkbFkrVi9sbTBNTzMra2NxWlY4RDZjaitWMExRTExS?=
 =?utf-8?B?emlZWWtjeFUxQnVsamh4djQrcHovaFliR3FCMUZ6RCtOS2lZUGV4bVppVGNP?=
 =?utf-8?B?QitDZnVBQm5rOFYyRXNtZFJ3ems2WkVWWThNTHlGcUhjbmFJZHVVOEFWdEwv?=
 =?utf-8?B?TW1iR3pxREsrbG11UzBCZlFqOEIyckdzZjdqYXZYcEhDVENLL0FqNkk0dk1k?=
 =?utf-8?B?VEtwWEU4em5PdXFWUG5NNWRPYmE2M0RRU3l1ZkRWSGpCKzZHSWJmTEp0andl?=
 =?utf-8?B?RXU3OWxoRTBCdHFhd25YeUFBc1VLcXVTNWVwKzFJK1BsVmoyelFkV08vTDJu?=
 =?utf-8?B?aFFwWmdLa0J1USs5NWRjK2d4UCt5KzNaYlBweEpVWW5CdDgzc3I4WTNEbVll?=
 =?utf-8?B?ckRuWTNMNlozZmNkTWZJblpUN1ZDcFZPMGdwaDQvUm53ZmZtc3RiYThqUkFP?=
 =?utf-8?B?NVZDWVg0dWNON3djaU1WSmdPN2l2ZEVaTnpsMHdvUUo0RFpoOXFnbGNiSTFn?=
 =?utf-8?B?K1FNNXBpL3lSNERucy9ML21teGdrQk1UUnZrQVlWNmUvelQreGNpN3pEVmRS?=
 =?utf-8?B?OE9UbTRyNGh3MU1kVjloQ09kTTBlT2FtcUJCVGRjNHNBcXA0VjU5WG50Mm1E?=
 =?utf-8?B?TWRZa0lsRDdnOWxLbGhuVGtPMGFJQ1oyTkltM1h0a0VTYm85KzlEdmdrRjhz?=
 =?utf-8?B?MEw1bHhGdDVpdzVRVGNrcHNHcnVGQm1lbkFweUdGRjZZaGovWmJnSS9ZeVg1?=
 =?utf-8?B?Z1JHOEJFU1FGb0JlSlhSRWgwQ2ozVnVmTzR6RUZzRkJkTmpBNHJpT3FqUVl2?=
 =?utf-8?B?TWd3ZU5mYVhpekFlTjlJRmF3R2VWUkJQRVZGS0hlTk8zL1lqRDJsQlFid3BR?=
 =?utf-8?B?YnpzNDZrNGZ5SzZ1S0N6cU95TTZrNGRmNEN5T2dKaldkemU4ZEgwMEM5TnBT?=
 =?utf-8?B?WDNRUU9CaWFkR21qbWFoQTFSMXdWMmRHTkUxNno5VWxiSTBlNHJSd2tFNVZ3?=
 =?utf-8?B?NmlhdlVwdzZUK3dYc2Z6TEdSK3gxY05Fek9EZWpQaWhGbFloUlRsOVN2UzZl?=
 =?utf-8?B?VlZ2YU83eGZtUW1qM1g0cUF4Q2xGdytwaTROQUx0ckRtTUY1T1JORDlLMTlh?=
 =?utf-8?B?dEdYeEpEL3ZnZUFFSStHdEFlc0RVRnQweHJRUDZDbG5GR002bG9NdHJyUnlT?=
 =?utf-8?B?bVhUY0xFSVVHNHJKWC91S0x2VXd6bzVEL3FmdDRPdG1LQkJFSGpRQnQ2Y2px?=
 =?utf-8?B?N0tCcDlSRUM2Vmp3Qy9EV3lOeXRKbTd5OHJ5UkduTXQ3eFVnK3VqTlpNNFl6?=
 =?utf-8?B?Y292S2FMcWY3bUpIL0dvekZpYTU2Rkk0NFdPZmxXNTJkNGRNWHBIZDhGcEhY?=
 =?utf-8?B?ZDUzUU5QdEQ3bFN4ai9GYTVGUjJnbW1TNnNMcmdLd2toSnNwcWF1K0JiUGth?=
 =?utf-8?B?Qmd4UnBNaW1ldnJyTEhoTmdzQmhWamFxZGpNQ3RBcEJNM1ZkRVJtSGZQTzA3?=
 =?utf-8?B?R2hXcmZKK1dzM3RyOW12bDNSd0lsdjZFTDYzS1VOdEV2TzFVRXN0VDZOQVBU?=
 =?utf-8?B?REdvbERVblFJbUlCQWFXeEIrSEpnV2pJUjN5MTlGS0J6U1VDVlRWZ2k5b2Np?=
 =?utf-8?B?azY1OUxSclp6bTVtdUNyR0h4ekxxVU50SXVoZGIxQUVSYVBXQWdEcmx2NEZG?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <360129148A1CA64E8FF7A0E1A3239178@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9beb1e0-9b3d-4618-2b3c-08db97ead410
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:38:23.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAeSjw9Aghe9q5cI+sWtRQpDg8v3uYG2xl6mRBmW/KmsFdFoSO336nGGZZPeYnlM13oub7AngtFBFuYDLGZ7ma1nnOfn6clRScAWUJLo54I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5545
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZHJlLA0KDQpPbiBNb24sIDIwMjMtMDgtMDcgYXQgMTE6NDUgKzAyMDAsIEFsZXhh
bmRyZSBNZXJnbmF0IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVy
aWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIEphc29uLA0KPiANCj4gWW91
IGZvcmdvdCB0byBwdXQgdGhlIFJldmlld2VkLWJ5IGdvdCBmcm9tIHRoZSBWMyBpbiB5b3VyIGNv
bW1pdA0KPiBtZXNzYWdlLg0KPiANCg0KU2luY2UgSSBjaGFuZ2VkIHRoZSBvcmlnaW5hbCBtZXRo
b2QgYXQgdGhlIG5ldyB2ZXJzaW9uLCBJIHJlbW92ZWQgYWxsDQpyZXZpZXdlZC1ieSB0YWdzLg0K
SW4gb3JkZXIgdG8gYXZvaWQgdGhlIHZlcnNpb24geW91IGhhdmUgcmV2aWV3ZWQgaXMgdG9vIGRp
ZmZlcmVudC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBPbiAwNy8wOC8yMDIz
IDAzOjUxLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gVGhlIHBsYW5lX3N0YXRlIG9mIGRybV9h
dG9taWNfc3RhdGUgaXMgbm90IHN5bmMgdG8gdGhlDQo+IG10a19wbGFuZV9zdGF0ZQ0KPiA+IHN0
b3JlZCBpbiBtdGtfY3J0YyBkdXJpbmcgY3J0YyBlbmFibGluZy4NCj4gPiANCj4gPiBTbyB3ZSBu
ZWVkIHRvIHVwZGF0ZSB0aGUgbXRrX3BsYW5lX3N0YXRlIHN0b3JlZCBpbiBtdGtfY3J0YyBieSB0
aGUNCj4gPiBkcm1fYXRvbWljX3N0YXRlIGNhcnJpZWQgZnJvbSBtdGtfZHJtX2NydGNfYXRvbWlj
X2VuYWJsZSgpLg0KPiA+IA0KPiA+IFdoaWxlIHVwZGF0aW5nIG10a19wbGFuZV9zdGF0ZSwgT1ZM
IGxheWVyIHNob3VsZCBiZSBkaXNhYmxlZCB3aGVuDQo+IHRoZSBmYg0KPiA+IGluIHBsYW5lX3N0
YXRlIG9mIGRybV9hdG9taWNfc3RhdGUgaXMgTlVMTC4NCj4gPiANCj4gPiBGaXhlczogMTE5ZjUx
NzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsgU29DDQo+
IE1UODE3My4iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGlu
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgaW4gUkVTRU5EIHY0Og0KPiA+IFJl
bW92ZSByZWR1bmRhbnQgcGxhbmVfc3RhdGUgYXNzaWduaW5nLg0KPiA+IC0tLQ0KPiANCj4gDQo+
IC0tIA0KPiBSZWdhcmRzLA0KPiBBbGV4YW5kcmUNCg==
