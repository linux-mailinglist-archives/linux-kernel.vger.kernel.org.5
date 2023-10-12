Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC77C6398
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbjJLD6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbjJLD6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:58:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B66268F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:53:03 -0700 (PDT)
X-UUID: d161662e68b211ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cxUQtNLWOQuYtGfydR20dJ7su60TL+lNYW9NcXfqMT4=;
        b=ghNq2MGTwPZqbV8y4YWMAgH9uLdGezHIQ+L5xycU2vuvgox0ijTIZckucXMhNDbT+hwTz6UHw57dRdKGuRQWj+BDZTLlVTSX/vf/uDaMJ5bqlPw1vJdz5WJstwyOi/9wj6rOq3wINmi/h4XzfpEK9GgwlRp3tAe3MAXr9a7gujU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:13b6461d-7225-420d-a870-e4cb30c911ec,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:c8af06c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d161662e68b211ee8051498923ad61e6-20231012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 124443557; Thu, 12 Oct 2023 11:52:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 11:52:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 11:52:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsSfZ4Qp6Epc3Cn1vQDZbEj42bk2+hmRKtLijy/8xyidn8tblHDdds+1gPpeG4p6cxkpjx1/bOv0UktgH2kiFHIDz+CUM7oxAYZ7Uz7Dkh0UyUgBrvG2Te2kZ3AxwKvPNOvGWmKLw2b/dIJAbGF4CljZOaGC1XyVrx2ORRvxzRMrkLevySPuaTGYZtaJaLBfZaiP4+7YaVZQ5KPtzPDqzEzlUlUj3pSALY3K5bCmHqOYuJqQpi4DlouK5ZCvM+AMcDy2sadcbM2TsjU1NpiCjSiz2ULCjHjuUH3WbvQSMJBpV/494/ZXny4c+i3hCJQcroGHg5NQCTfB2wdyG+fAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxUQtNLWOQuYtGfydR20dJ7su60TL+lNYW9NcXfqMT4=;
 b=MyfCqeEelMuK+2M9vOkYYKPrCEI48HiuU7Z8tHbb1RmPyr9/w+3VpPoRahW8CdJigaZBbNabwz6isA76FX8Y3lxSKEbFSt1dDx+UHnzFYgmfo7+qEEMxZ7bJMN8bRIOoKqyxHSaFQHVJhhhEn/Izsr6l7Np/AQzHL4evH5nBe7LsZO47JuE4BqwAAv2txZVUDL3rAhnSA7jjzP+SF0YhnkNI1Fe3R0Ize/Gs7PpUBZe853uTM3plfGCJUVXOWz24hxBOIR/9px+tZfv6kO/H9Cehs8wX3k7/9LdtGtl2ouTP/YneZTDJf9gS4hkiy50uCEWGfDxRodkKi7JKT6mqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxUQtNLWOQuYtGfydR20dJ7su60TL+lNYW9NcXfqMT4=;
 b=Pxg04vpSBYxFvuUQFpR4EBBxxSpu1WOOw5ml8yqY40vVs/5DSkCGAzRr/DBLSYR8+Fd6nWl3v9XcBgwRvO0xYrMd8HUnaf8zN0HpeIcz9i0Zjbmptg9Rt51SOXxuBs5r0ZiYluaIXMrsEVS9UkjkYP7teyWy3N6wV+W5l6QBYMU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7811.apcprd03.prod.outlook.com (2603:1096:101:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 03:52:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 03:52:48 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 09/16] drm/mediatek: gamma: Support specifying number
 of bits per LUT component
Thread-Topic: [PATCH v10 09/16] drm/mediatek: gamma: Support specifying number
 of bits per LUT component
Thread-Index: AQHZxqWKQ+R0esZvP0OxE1QfeRKerrBF8dYA
Date:   Thu, 12 Oct 2023 03:52:48 +0000
Message-ID: <e0a8ea5406e81bcf06304e6c42efcd54af8bcbbf.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-10-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7811:EE_
x-ms-office365-filtering-correlation-id: 54300ad0-5ef8-477f-1228-08dbcad6b3a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1iR+87PSSQgFgxc2C5H3PiFNDMZq+XQ4I5WeZT1Hh5sx3kABkT/E2gEqAAN78wmLOF9Zvv09qmrBy+I4dYQTCvoVZid1HtX2sW8aOl6RfZ/sqkpIsN/6f40aDTHxfLgLXUCnF87zL10WIDq2q1qZsgG5DLs+Dlv9dyV5ec5CcQwOkA4hohUWQL5t7AGRYzDHB8oNdGZARHHyWme5yroHQtuMAIySnFA2wSUIMeZe6+YsQVxGAiBGk3T1OOyakHVb+luUkGsZoJoMSP3FYDg8cCAva9Wx3Pmmm+885NaGj0eUbyAXyFTZMWrPDl+DBFbj1HvupQJ4M6pusDGhnllGvRZBMlMUre/vij/Xv7hwVj1LJ3ULAF+LzRRrw2ODTafBSeURveHjJosebqJwqnChFOEtvzwDBvLYRPHQ1QFA7Pcko/Is8lR7wMR/d5Tew93JSqGrPbxZnEEGM7qmIKNPW8p9YyTsHN6/T69nXOnv7gh3YHkEZ7fKj5IrqYl92tbWyav01GAMI3sfsZ8WCqKe8GbIiB30nK8z0R+p3IwwTjWipAvrbO9ELEqjylZJDv6elb/mWuBYBmO/ouK0xtXgkgMmPtD13K06APuggvZodNCsH7aaNsUSPGZ/jNm0CBVm8CYZ+Iv/fxQH7yU+jS1/ww0w4nWMptXj3OsXtP0Beg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(6486002)(478600001)(71200400001)(7416002)(66556008)(26005)(83380400001)(76116006)(2906002)(66476007)(66446008)(5660300002)(54906003)(66946007)(110136005)(64756008)(6506007)(8936002)(316002)(4326008)(8676002)(41300700001)(86362001)(122000001)(85182001)(36756003)(38100700002)(38070700005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhWd1lGSXloRmtVRUlFUmlLdjhYUCtXUWZWRnR0RTh3UTFDM3kwUkgzU29y?=
 =?utf-8?B?QVRmMUtQb2xzMVRTNkFXRS9CaXk1SEVCb1d5L0FvVEZOM2puQTlTVW5mZkl2?=
 =?utf-8?B?RU5QTVZNS3ZaL0VWdG5lZG1DYlVyb1RrM0VsbktWVlBvOVVQSmIrek5MQzVJ?=
 =?utf-8?B?OWM3bCttK3dpcXNCbHdCMDJIeG1hNm9yckVNWGZXQkdJRFVHVEJGNlVuRml0?=
 =?utf-8?B?MXU1RHlMOUZQVmRBT2Y4OGhjRWJlY29wWC9oM1lQdGhMdVJmMmt6NEdxT0d6?=
 =?utf-8?B?L1lHdFVhVGNJRDlIR1FqcFpmRlBWelNGR2xZT3FpUmtldGlqSmhqNUZSeGQv?=
 =?utf-8?B?WFZuSHBwQjhCQVFVdUtuOFRwZXcybCtFSnRWeHIrbUNLUGJ6NmZQZWJieVJW?=
 =?utf-8?B?STJWMDc4cGdXVzVIYTBZbUdNc3gzSTVYVnNPZ0s5UVZHbXN6dGZ5bDdjL2Y2?=
 =?utf-8?B?Y2oybzczcDZRb0pQb3YvL24xcmhBbjBQSGR5ZVVyU3FkU0p5WEVOek1Sak5u?=
 =?utf-8?B?TS9FK0psdStlQXJ3akhsQVoyekFJSXp0SDk0NGVOejkzUzNrS2JFd2c2S3dQ?=
 =?utf-8?B?RE4vMWNUTGFpZGdZWGwrUUFWVWNkYXR5ZXJTTnpGRFIrQUxMQ05ySmVJanU3?=
 =?utf-8?B?UU5nMWY4NWlDWmJ5WktPYjY0d0ZuNzJja3Y4UkFQRitkSzFEVERZbUJNQXJh?=
 =?utf-8?B?U2kxdG9sSUZEeEtvOUVNTko2S0lLK0FJQUdKQmlFTGtFczc3YTMrQk9QMGpY?=
 =?utf-8?B?M094ZEM5M2I0MDJOcFcyc2pDNWpPSzVnQ0diSW03L2hYek5TUXgrZjF1bzJ4?=
 =?utf-8?B?dThCcWJodjRsZG1mR0JoNWthcWtLWXZkQm8zQlhISk9qYld0c1BjcWZkSUlE?=
 =?utf-8?B?VUNmVVdVRXZSb3VNQmhJVFVGNmtHTHlKT0R0RWhnTTlBOVlOVFQxVEJpSnR5?=
 =?utf-8?B?R3JWSWwyUWZXNmFKaGh2cTBoS3VOalVDcVdGTTRJRHlCeDN4czlRMCtCUU5B?=
 =?utf-8?B?UHJzYy9yeWExRU1FQUlzTlI4eTMwMFJjUDVvNHczcE5Dd2YxakRhNmd3d0h5?=
 =?utf-8?B?NXlZRW9QNDVveVlxSzc5NlFxUkRWWlR6UHMrNnN0RFRLdU9uWUhzMHZWQ29B?=
 =?utf-8?B?RDVkM0swTjRhR3ZLd0lVc1VqZStaOTdZNW1RRjB5bWxzQk9paHRoYWhhdGhq?=
 =?utf-8?B?K0RYTWZaVzlpRWxYVDlWYU9MUGNpdkRKajdSTThtZVJ5L1N0Ykt1SVFHMnBH?=
 =?utf-8?B?MXF3ZldGekl0ZC9MTUxqb01ITVVRNUtDdldKanUvUmhTY20zdXBHRFBIVXR5?=
 =?utf-8?B?TzBuLzA1ckpNelRSaE9pQXRzM3EzVXEyN2dOODhnSmdUZkZqQWtoaVpnaVVQ?=
 =?utf-8?B?NXJRbWNLaHNzYkt4TjlORFY3cFBpMURqcFIyYmFkcGpGUUtoSlFqczEwTnBH?=
 =?utf-8?B?SDU1MkxpNVk3bnN6R09DcXllV2JWQ0JwT2JEalhHR04vZE9ncTZpWHlXbG1T?=
 =?utf-8?B?NE95QnNvZzQvWGJFSjRkMkZyQWNDajB6aDl6NjFKaG9reUhhcU11Mkc1M2Q4?=
 =?utf-8?B?Y3dHRHBEL3A5ZmJIN1VHMVdRWUNEK0VLcGxZS3B6a2l2Zm9HbGVZTk4rQkM1?=
 =?utf-8?B?M1czMDdHbUVjRCtKT2RoVDVKVVJlTDZ1bzRTRmJqdUVJaFJnWXZaUmJxREdi?=
 =?utf-8?B?MWNwcFZGa3F2aE9uc2oxUVIrRXI2NC9oN3B2ZXBsZ1J6VThCZmN5OVhSYU5X?=
 =?utf-8?B?UVVkeUlhK1JEdU5hQWZMckd3OHhOMHl4eTBEQXE1RiszSjhSRDZ4YTZVbldw?=
 =?utf-8?B?Y2JzbFg2eVIrWGJ5RGNZUE1xVDRDT1ZvTXpkMUV0MXA1QWRPcWIzMHV5UHF4?=
 =?utf-8?B?aytQZDA2emkzT05FK0FMWTIrSWtYT2FFM2ZvcDJHSGVHMm9MT0RqMXc0SmtJ?=
 =?utf-8?B?cXNrVENNcmlRdlJhOEQ5QUpHOThUSE5qczRHM3lyelI2UE1GZFo1MUJGVEIz?=
 =?utf-8?B?R09LcGNxYmk4Nk85MWU2eFMrZEVtTlNzZGFJdU1aSU9qSjk2alI1U0FUNVZZ?=
 =?utf-8?B?SXU0TDhwWkJmU01aUm5CTUdMUjFLdWQ2d2NKTE0xTW5zOUo0OFo4blhyVmdI?=
 =?utf-8?Q?zFm9WZvYJ4/ffq/NUtEVLO/u/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FBA466E54686E40B7A5037AB59C36E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54300ad0-5ef8-477f-1228-08dbcad6b3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 03:52:48.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0ke4lyPFbCaWRb4v8ODIQeroOb4DbcTJq5dcE3GP6fVp9kylaIo/9Hm2D+ico1AZfo7J0LRcB1gd8p/Gj7Y7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7811
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.803800-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQNtKv7cnNXnSa1MaKuob8PC/ExpXrHizxnnK6mXN72m/UR
        5rR1XhwPxiuAqQgxJY9zhxDC2hUrqbM5yFdOCNfRY1bQMCMvmn4RvEpVd3vS1d9RlPzeVuQQQkz
        RZrI7fzZMmm8bxtFZ3Q9iGlH7LPmcQkfxbJAyTm5jiC4p+/AIFvQ7szeVKdNbVI7KaIl9NheBz9
        7t1wzOQ+LzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge5TVMPn/DACKYZRn
        Q2aDiPCI50f2hesO9zCfAAIdDTlQ18I4oUq5Vga
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.803800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F7D90F2E7DE398B0D69C50D013B5BE3795E5D364BA30E06A6BE0B8836FBB99852000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTmV3IFNvQ3MsIGxpa2UgTVQ4MTk1LCBub3Qg
b25seSBtYXkgc3VwcG9ydCBiaWdnZXIgbG9va3VwIHRhYmxlcywgYnV0DQo+IGhhdmUgZ290IGEg
ZGlmZmVyZW50IHJlZ2lzdGVyIGxheW91dCB0byBzdXBwb3J0IGJpZ2dlciBwcmVjaXNpb246DQo+
IHN1cHBvcnQgc3BlY2lmeWluZyB0aGUgbnVtYmVyIG9mIGBsdXRfYml0c2AgZm9yIGVhY2ggU29D
IGFuZCB1c2UgaXQNCj4gaW4gbXRrX2dhbW1hX3NldF9jb21tb24oKSB0byBwZXJmb3JtIHRoZSBy
aWdodCBjYWxjdWxhdGlvbi4NCg0KSSB3b3VsZCBsaWtlIHRvIG1lcmdlIHRoaXMgcGF0Y2ggd2l0
aCB0aGUgMTItYml0IGx1dCBzdXBwb3J0Lg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlh
dGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dh
bW1hLmMgfCAxNSArKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZ2FtbWEuYw0KPiBpbmRleCAwMDFiOTg2OTQ3NjEuLjE4NDViZDMyNmE2ZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gQEAgLTM4
LDYgKzM4LDcgQEAgc3RydWN0IG10a19kaXNwX2dhbW1hX2RhdGEgew0KPiAgCWJvb2wgaGFzX2Rp
dGhlcjsNCj4gIAlib29sIGx1dF9kaWZmOw0KPiAgCXUxNiBsdXRfc2l6ZTsNCj4gKwl1OCBsdXRf
Yml0czsNCj4gIH07DQo+ICANCj4gIC8qDQo+IEBAIC05MSw5ICs5Miw5IEBAIHZvaWQgbXRrX2dh
bW1hX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkcm1fY3J0Y19zdGF0ZSAqc3Rh
dGUpDQo+ICAJZm9yIChpID0gMDsgaSA8IGdhbW1hLT5kYXRhLT5sdXRfc2l6ZTsgaSsrKSB7DQo+
ICAJCXN0cnVjdCBkcm1fY29sb3JfbHV0IGRpZmYsIGh3bHV0Ow0KPiAgDQo+IC0JCWh3bHV0LnJl
ZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0ucmVkLA0KPiBMVVRfQklUU19ERUZBVUxU
KTsNCj4gLQkJaHdsdXQuZ3JlZW4gPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmdyZWVu
LA0KPiBMVVRfQklUU19ERUZBVUxUKTsNCj4gLQkJaHdsdXQuYmx1ZSA9IGRybV9jb2xvcl9sdXRf
ZXh0cmFjdChsdXRbaV0uYmx1ZSwNCj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+ICsJCWh3bHV0LnJl
ZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0ucmVkLCBnYW1tYS0NCj4gPmRhdGEtPmx1
dF9iaXRzKTsNCj4gKwkJaHdsdXQuZ3JlZW4gPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ld
LmdyZWVuLA0KPiBnYW1tYS0+ZGF0YS0+bHV0X2JpdHMpOw0KPiArCQlod2x1dC5ibHVlID0gZHJt
X2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ibHVlLCBnYW1tYS0NCj4gPmRhdGEtPmx1dF9iaXRz
KTsNCj4gIA0KPiAgCQlpZiAoIWdhbW1hLT5kYXRhLT5sdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkp
IHsNCj4gIAkJCXdvcmQgPSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX1IsDQo+IGh3
bHV0LnJlZCk7DQo+IEBAIC0xMDEsMTMgKzEwMiwxMyBAQCB2b2lkIG10a19nYW1tYV9zZXQoc3Ry
dWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QNCj4gZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiAgCQkJ
d29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFfTFVUXzEwQklUX0IsDQo+IGh3bHV0LmJsdWUp
Ow0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJZGlmZi5yZWQgPSBsdXRbaV0ucmVkIC0gbHV0W2kgLSAx
XS5yZWQ7DQo+IC0JCQlkaWZmLnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLnJlZCwN
Cj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+ICsJCQlkaWZmLnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0
cmFjdChkaWZmLnJlZCwNCj4gZ2FtbWEtPmRhdGEtPmx1dF9iaXRzKTsNCj4gIA0KPiAgCQkJZGlm
Zi5ncmVlbiA9IGx1dFtpXS5ncmVlbiAtIGx1dFtpIC0gMV0uZ3JlZW47DQo+IC0JCQlkaWZmLmdy
ZWVuID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuZ3JlZW4sDQo+IExVVF9CSVRTX0RFRkFV
TFQpOw0KPiArCQkJZGlmZi5ncmVlbiA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmdyZWVu
LA0KPiBnYW1tYS0+ZGF0YS0+bHV0X2JpdHMpOw0KPiAgDQo+ICAJCQlkaWZmLmJsdWUgPSBsdXRb
aV0uYmx1ZSAtIGx1dFtpIC0gMV0uYmx1ZTsNCj4gLQkJCWRpZmYuYmx1ZSA9IGRybV9jb2xvcl9s
dXRfZXh0cmFjdChkaWZmLmJsdWUsDQo+IExVVF9CSVRTX0RFRkFVTFQpOw0KPiArCQkJZGlmZi5i
bHVlID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuYmx1ZSwNCj4gZ2FtbWEtPmRhdGEtPmx1
dF9iaXRzKTsNCj4gIA0KPiAgCQkJd29yZCA9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBC
SVRfUiwNCj4gZGlmZi5yZWQpOw0KPiAgCQkJd29yZCB8PSBGSUVMRF9QUkVQKERJU1BfR0FNTUFf
TFVUXzEwQklUX0csDQo+IGRpZmYuZ3JlZW4pOw0KPiBAQCAtMjE3LDEwICsyMTgsMTIgQEAgc3Rh
dGljIGludCBtdGtfZGlzcF9nYW1tYV9yZW1vdmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIG10
ODE3M19nYW1tYV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFzX2RpdGhlciA9IHRydWUsDQo+ICsJ
Lmx1dF9iaXRzID0gMTAsDQo+ICAJLmx1dF9zaXplID0gNTEyLA0KPiAgfTsNCj4gIA0KPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9nYW1tYV9kYXRhIG10ODE4M19nYW1tYV9kcml2ZXJf
ZGF0YSA9IHsNCj4gKwkubHV0X2JpdHMgPSAxMCwNCj4gIAkubHV0X2RpZmYgPSB0cnVlLA0KPiAg
CS5sdXRfc2l6ZSA9IDUxMiwNCj4gIH07DQo=
