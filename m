Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0267D5FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjJYCJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYCJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:09:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3B10D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 19:09:00 -0700 (PDT)
X-UUID: 71db126c72db11ee8051498923ad61e6-20231025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6Jld6/UTcmNsBGMQKjM/qyN+0mei5DyDUxX5XlLyvjM=;
        b=sZw5It9Hh12BdjaLTeJcIFKHqbtafaUfDAPboRDjn/fzye3kleTFcJ7qtiB3ska6JcZ3AEI7I+mNSg1SBmZ3Vx2KNCuMZPlFuEOcP0J72kupmX0B62nssSx8byBr6lJ5yCPbg4hBMyx4S9HCjJ4RVKugBlt3mfz6Pxr1pDplPlg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:61a1f5f7-166b-4071-a9ba-dde2fb31141c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:8ef4bbfb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 71db126c72db11ee8051498923ad61e6-20231025
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 160381494; Wed, 25 Oct 2023 10:08:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 25 Oct 2023 10:08:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 25 Oct 2023 10:08:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDRBU4cFBxWoJGV7PaT23QDgdhsQ6dBbpPNEG6CwEA7pba6AZzAHM+zXGm8tuk+/5M+Z+QDok/JCwMs3fwNStS4Ix5r68Ttp/qbeY+vKpA64gEeNZeIF0aftHzJES6Tw0UZa/DeR29XJ0VAvE/CwrEoRmV5On6hd9hbNkeThd4e+IQ5Cvg4y+fX7TF9THcLGZlxZzimvs5Hs8uAHzRWUyRh6yjv4l6QLEH7iC08x4TAUyGEZzgH0LpjKOySLshtsZokCE5JhzJjOEbucQMXA2bRCCT+F4CdR80nm4BKzbu9b96y2hoigaqFbBSfkkOJZPeclC16xoQSpY3UrZZ6WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jld6/UTcmNsBGMQKjM/qyN+0mei5DyDUxX5XlLyvjM=;
 b=E6dMR0j2vcFBTwqO94slG59ccAIHZ/4kPJsoGUjUpL2lUu/L0jJ2bFKbmCme7HlvfuVBuuCsZkbFuYF1SwY4HWm3FkJHMQsmSe4idnXqMxCEMIFj3REJZmj5KPs9C66OxpYpRuFFLm1sNo6HyOZEYqY+rO4+EhBDHmy8mOkbFT53P0rDQEY8O+5Y47RsjxzrsmNte4NgOF5JAPrz7kar3mLEdHf/CaTiXHJvu+hBLarBc6ldbTacewv0TVm3rqb5j7FOBGJerK5N6QF1qRAFsfeZSvBDutrJVS7YDqcaFZAwz9pO6jRE2uGdY4bfAcKf+M1bK3GO7BydUyftZuMc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jld6/UTcmNsBGMQKjM/qyN+0mei5DyDUxX5XlLyvjM=;
 b=lecxpExij18Sj2rtvizSzez/rZHRyN6Ex200+twbqKRqhiyXjFjE9JuApkyHjkgs2okTHdtjfjDBA+vFKSjTjNbjxbq9MQBabQZ9QO4NstE5vByirzrrO7iLRrQmtnnZGXqdWoAi8YbbTPk/CqjoFRkNeKLguxpuch+oAaK5tK4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7946.apcprd03.prod.outlook.com (2603:1096:101:186::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:08:47 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:08:46 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "fshao@chromium.org" <fshao@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "jkardatzke@google.com" <jkardatzke@google.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 7/9] mailbox: mediatek: Add secure CMDQ driver support
 for CMDQ driver
Thread-Topic: [PATCH v2 7/9] mailbox: mediatek: Add secure CMDQ driver support
 for CMDQ driver
Thread-Index: AQHaBWrDh5tJdLaDf0eo2WO7Ca+cLLBXMdMAgAKTtYA=
Date:   Wed, 25 Oct 2023 02:08:46 +0000
Message-ID: <8accca79ebcde0b78a9e3026155543e67df3ed7a.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-8-jason-jh.lin@mediatek.com>
         <CAC=S1niRYwftnmi8VABzENf2g94ELEBZrB3NRRdvwn0Ro6tO1A@mail.gmail.com>
In-Reply-To: <CAC=S1niRYwftnmi8VABzENf2g94ELEBZrB3NRRdvwn0Ro6tO1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7946:EE_
x-ms-office365-filtering-correlation-id: 9740250f-5c92-472d-c576-08dbd4ff527a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ruCzuLSjmBQo37IWuDi2HwAKbt3wtQEofzQbd98vmasNIhL9RL1VGjtvvf8FxmYf/Qj1mYdtO0xBMZ221XSNsTHhbDBP5HDqddjxPWMcLageDUyXk11tqSnMCLlGjkU8lFZPLHi5+H4erMiFdCniMQXYidMH6yzzZy4hjjenuG9RFiyod0iwsPCcCsoxieyRSuu5wIuELIWXtwAlynwxCa2dHdmtmNi/0bNlDOY1RRsWbU9MB+yOunabtcDrWRzUAC12s4vpbsnWWD6te9w9ZqaK3mP4lcsAAkYTejVuuhakCKVeFNuEuTGrjFAGDnlcHbbMDhgI0TGZA9tw7Zd5uRTCGOWd7hsa/jbHDS8OWSzGrfMgEnFw1Yfhvi7fy2Pa7FimmE+2dXX2haj+tlz816DOfybqDhuWhQsiyKShu3EtZ+LJOELUs7i9xWOtAu67FqsXXJmH/IpOiHg7KmO4ChkeDTH90LMELZkFjdgYiOEt5FJXsPCF8v3xhj4fC8YO4d3wgV2d0kP/zKIAHi9lYI6QT5wwe80bkrfZ36TPjxGe78YsvkxRivT2A4gR+kmd+EwEJO8JGRsC/VF1diueYglIuAKMPnSvHQMjs8CSV8pKBN2HKRUNMvNs1fGcyXBcC7WP4mVNPY+508Cf1uTME25xQ/r+dHOowlqsMhrptGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(41300700001)(66476007)(2906002)(122000001)(38100700002)(54906003)(66946007)(64756008)(76116006)(91956017)(316002)(66556008)(71200400001)(6916009)(6506007)(66446008)(6486002)(53546011)(6512007)(83380400001)(2616005)(85182001)(15650500001)(7416002)(86362001)(5660300002)(478600001)(4326008)(36756003)(8936002)(8676002)(4001150100001)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emM1NXI5dXF3SmVZdnp2SGt0ZERtd2NjYmc1NXI2RkRXd3B4RHgxUVptNU4y?=
 =?utf-8?B?UGpnVmtBa1AzSnQwa0s0LzdaS2xFUGNhUnBQbVZDTHhHU1NiUHJERjlkVkZy?=
 =?utf-8?B?am9Lbis0TDg3SmVCY2JacUZSUStNa20vTXltTFdKYms2N2NmZjhyMllza1dJ?=
 =?utf-8?B?ajkzVE5SVXBxOXA1VExvTWk5bXpPRzBJbjZpMldza01haENNMFN6OHJ6TXNt?=
 =?utf-8?B?UWZ4dVoxejNvVVh0K2lSV2FGYnJYZzNLU0ZESUE4Q0UrdXhZektVWkM0V0dT?=
 =?utf-8?B?K2JYVW1oQjh2UkdzelVlVm8vcHVBQjd6bkVaVFBLZVBWeVp5bWkzYVZuLy9U?=
 =?utf-8?B?elA3OWNRMk9DcDN3QURlT1Z1Z3lEY2l4ZFFtYmR5UjhRcm10UmIxNlFrRHRI?=
 =?utf-8?B?Z1lJblRMRGY0bzk4SGhzb1JNckpaZThoVFN4WCtsUzhhbUE4WEp4S09vT0VK?=
 =?utf-8?B?SGZVRzFnUVQrMkJqQVFLTXVjOEdiWEY3ZVNOWjZsWEwwNEpVbWFsdmRBTi9K?=
 =?utf-8?B?cWxzbG1IK1FPQmhOQUpkNzhOZmF3YmNDSzF5RVJ1U0VaWWxySnF2L0hEZTE2?=
 =?utf-8?B?ekdreTBGa0lIRDRrL2lJNDhtaXdPWlB3Qk0rckRlOUJXZGRHNHFVR3dMdkp4?=
 =?utf-8?B?UTIwaXFPelhOeFlyMFAxSjlyQVJNdDNMZ3JNcmFyYldxQ3NoRUhRZ0ZrQnN0?=
 =?utf-8?B?RkQ1SnVqREVlbVBzWFpSWUVpeW14UGhnYlVXc0IrbmdOUHpKRElUWHB3eGlk?=
 =?utf-8?B?QzIzd0N5aDZYdzl6ZmRsMWovYXovQXp4UEVmMEF1RHN1N2w4TnlWR2VEZGJk?=
 =?utf-8?B?N05QZjBNQThJejBUdjd3TEcvbUkvQU5DUlJYVWQwOGhDaFlHT2lqbnRHQmla?=
 =?utf-8?B?OXpRenN1SVZmL2xQZU9yUEpnVXRGcWhWZThqcG9wU0VQSVBSR0x4VDVLZmVy?=
 =?utf-8?B?Q1ZVdkt3N0FhejQ0c0hTeTBiQUFRTnM1VytjaXJiSlRyNW5Rc3A1VHYrYkE0?=
 =?utf-8?B?QkZHVTNlaXVtSFh4NkZFT2pWeVdIYXNtcm9KWk1oSGMwK3phaisxeUl0dlNq?=
 =?utf-8?B?MEN0NTAwVHJYNFEzNURxZ2MwY1ZNY1Z1MWhKcEFmZXRkTlBITEt5b2I2NFJa?=
 =?utf-8?B?bmdVVzhhQVdTVjhqYVhtUlp0VHlNQUt3UFhNd2JyRlBZTm41U083NVVFMWZ2?=
 =?utf-8?B?alY0T29TVE5meUxwZkVZZ1E2c1J1bWxIZ0ZXajN4VnBHWUMxa1hIeHlaRE5x?=
 =?utf-8?B?QW1FdGZRak8vbkRMUi9TOFhaTXQ0SDNiQm04QVJVQzBhOEt3eHFIeUtIN2Jq?=
 =?utf-8?B?LzJ5dEZpZDlIMS9vbmk5dmFiblFaeWR6UVdRemgzMW5hUWlZT1FDdS9WZklW?=
 =?utf-8?B?OGNBNDZ4c3h3S0tJa2lGV0g1WXlLclBYa2Z1blIwbllUeld5S0xmRU5HQ2xq?=
 =?utf-8?B?b0RJY1RMZFUyZlZSa1p6eFh1dWE3VlB5WkVGRUloWWJ3Ni9Ndzdsd0VrQUY2?=
 =?utf-8?B?NE9EWk5pYVhGblozNm04b0duNjBYK3NsNWlaemxxWWRIMGpmYkR3UHpVdnY4?=
 =?utf-8?B?VmN4SE5tb1NnMGd3Z0t4Unp2SFVDOFpNcEVpT2Q4ekJnWE5hVHA0eS83cGJL?=
 =?utf-8?B?d1ZjNjhaZW04dmRUYUNDK3EwV004RWVPbWZIVjRxWnhEYkJpWEJqaS9peldX?=
 =?utf-8?B?TzJaVy9WYTh1NEFtUmtkR2hLaXgxbFVETzVzSFlrQXVlU1hzNFQzUHhhclA1?=
 =?utf-8?B?azk2L1pEdU9DYitXZmV2SVJjR1BobmxvYll2M2dvVGJ3VUZCaVcwNzVOMTB1?=
 =?utf-8?B?NFI2amVwZDJOeDYrNWF0MUJpTFNhUDNHWTc0ZWJNd2VPOVZiWUlISG5FUTVs?=
 =?utf-8?B?aWd3dFZ4b2dVRGVXZXl6L2FCYTJwenRQeVNUb1VGcEJNa2k1Y05iSm5TZEZJ?=
 =?utf-8?B?QkxyQ1l2UTJ3cVpqTGg4aVpYRlF1cnJjTUxibXowWFdTSXh5a1U1ZjVyWmZI?=
 =?utf-8?B?S0xFS3JNRjFsMndRWXJiTEkrRzZLK0krejRsTjBaVHM5d29DOTNSdzhwcTY4?=
 =?utf-8?B?OFE0VG9qV1pWQVg2L1dlVVdIcFJDSjNWOFRpbHRWN2wzU2t0MjhYam5UKzNZ?=
 =?utf-8?B?SFFvWnNJd0JwdkgyN1JUK1hDRE5ueEJMR00rQ3RCcUJNK1loeEdqc3NWOC81?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D489CA8D8824F4A961DB86F4B22791B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9740250f-5c92-472d-c576-08dbd4ff527a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 02:08:46.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PBgLdkvz0P4D1DYa7tZT6SeXDTZR0iAl9psLDwRgWzKw9RAQS31iVPlQvlVnPY1S0lto7Y5jzfseIiKin4kfMv6wCiOPO5iGlSoTZOZENw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7946
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVpLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBNb24sIDIwMjMtMTAtMjMg
YXQgMTg6NDcgKzA4MDAsIEZlaSBTaGFvIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIEphc29u
LA0KPiANCj4gT24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMTI6MznigK9QTSBKYXNvbi1KSC5MaW4g
PA0KPiBqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IENNRFEgZHJp
dmVyIHdpbGwgcHJvYmUgYSBzZWN1cmUgQ01EUSBkcml2ZXIgd2hlbiBoYXNfc2VjIGZsYWcNCj4g
PiBpbiBwbGF0Zm9ybSBkYXRhIGlzIHRydWUgYW5kIGl0cyBkZXZpY2Ugbm9kZSBpbiBkdHMgaGFz
IGRlZmluZWQgYQ0KPiA+IGV2ZW50IGlkIG9mIENNRFFfU1lOQ19UT0tFTl9TRUNfRU9GLg0KPiA+
DQo+ID4gU2VjdXJlIENNRFEgZHJpdmVyIHN1cHBvcnQgb24gbXQ4MTg4IGFuZCBtdDgxOTUgY3Vy
cmVudGx5Lg0KPiA+IFNvIGFkZCBhIGhhc19zZWMgZmxhZyB0byB0aGVpciBkcml2ZXIgZGF0YSB0
byBwcm9iZSBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYyAgICAgICB8IDQyDQo+ICsrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+
ICBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgMTEgKysrKysrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0K
PiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRleCAzYmRmYjlh
NjA2MTQuLjRkYjVlYjc2ZjM1MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiA+IEBAIC04Nyw2ICs4Nyw3IEBAIHN0cnVjdCBnY2VfcGxhdCB7DQo+ID4gICAgICAg
ICB1OCBzaGlmdDsNCj4gPiAgICAgICAgIGJvb2wgY29udHJvbF9ieV9zdzsNCj4gPiAgICAgICAg
IGJvb2wgc3dfZGRyX2VuOw0KPiA+ICsgICAgICAgYm9vbCBoYXNfc2VjOw0KPiA+ICAgICAgICAg
dTMyIGdjZV9udW07DQo+ID4gIH07DQo+ID4NCj4gPiBAQCAtNTYwLDE0ICs1NjEsMjMgQEAgc3Rh
dGljIGludCBjbWRxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4g
ICAgICAgICBpbnQgYWxpYXNfaWQgPSAwOw0KPiA+ICAgICAgICAgc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBjbGtfbmFtZSA9ICJnY2UiOw0KPiA+ICAgICAgICAgc3RhdGljIGNvbnN0IGNoYXIg
KiBjb25zdCBjbGtfbmFtZXNbXSA9IHsgImdjZTAiLCAiZ2NlMSIgfTsNCj4gPiArICAgICAgIHN0
cnVjdCByZXNvdXJjZSAqcmVzOw0KPiA+ICsgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
bXRrX2NtZHFfc2VjOw0KPiA+ICsgICAgICAgdTMyIGh3aWQgPSAwOw0KPiA+DQo+ID4gICAgICAg
ICBjbWRxID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpjbWRxKSwgR0ZQX0tFUk5FTCk7DQo+
ID4gICAgICAgICBpZiAoIWNtZHEpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Ow0KPiA+DQo+ID4gLSAgICAgICBjbWRxLT5iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiA+IC0gICAgICAgaWYgKElTX0VSUihjbWRxLT5iYXNlKSkNCj4g
PiArICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01F
TSwgMCk7DQo+IFRoZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSBoZWxwZXIgd2Fz
IGFkZGVkIG9uIHB1cnBvc2UgWzFdLg0KPiBQbGVhc2Ugc3RpY2sgdG8gaXQgdW5sZXNzIHlvdSBo
YXZlIGEgc3Ryb25nIHJlYXNvbiB0byByZS1zcGxpdCBpdC4NCj4gDQo+IFsxXTogYTA0ZjMwMzU2
ZTc1ICgibWFpbGJveDogbXRrLWNtZHE6IE1ha2UgdXNlIG9mIHRoZSBoZWxwZXINCj4gZnVuY3Rp
b24NCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkiKQ0KPiANCk9LLCBiZWNhdXNl
IHdhbnQgdG8gZ2V0IHRoZSBwYSBvZiBHQ0UgYnkgcmVzb3VyY2UgbGlrZSB0aGlzOg0KZ2NlX3Nl
Y19wbGF0LmJhc2VfcGEgPSByZXMtPnN0YXJ0Ow0KDQpJJ2xsIGZpbmQgYW5vdGhlciB3YXkgdG8g
ZG8gdGhhdC4NCg0KPiA+ICsgICAgICAgaWYgKCFyZXMpDQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArICAgICAgIGNtZHEtPmJhc2UgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KPiA+ICsgICAgICAgaWYgKElTX0VSUihjbWRxLT5iYXNl
KSkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBpb3JlbWFw
IGNtZHFcbiIpOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihjbWRxLT5iYXNl
KTsNCj4gPiArICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgY21kcS0+aXJxID0gcGxhdGZvcm1f
Z2V0X2lycShwZGV2LCAwKTsNCj4gPiAgICAgICAgIGlmIChjbWRxLT5pcnEgPCAwKQ0KPiA+IEBA
IC01ODUsNiArNTk1LDggQEAgc3RhdGljIGludCBjbWRxX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAgICAgICAgICAgICAgIGRldiwgY21kcS0+YmFzZSwgY21k
cS0+aXJxKTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGNtZHEtPnBkYXRhLT5nY2VfbnVtID4gMSkg
ew0KPiA+ICsgICAgICAgICAgICAgICBod2lkID0gb2ZfYWxpYXNfZ2V0X2lkKGRldi0+b2Zfbm9k
ZSwgY2xrX25hbWUpOw0KPiBXaHkgZ2V0IGh3aWQgaGVyZSB3aGlsZSBpdCdzIG9ubHkgdXNlZCBp
biB0aGUgaGFzX3NlYyBicmFuY2g/DQoNCkJlY2F1c2UgSSB3YW50IHRvIHBhc3MgdGhlIGh3aWQg
dG8gc2VjdXJlIHdvcmxkIGFuZCBsZXQgaXQga25vdyB3aGF0DQpHQ0UgcGEgc2hvdWxkIHVzZSBp
biBURUUgcmF0aGVyIHRoYW4gcGFzc2luZyBHQ0UgcGEuDQoNCj4gDQo+ID4gKw0KPiA+ICAgICAg
ICAgICAgICAgICBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKHBoYW5kbGUtPnBhcmVudCwgbm9kZSkg
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGFsaWFzX2lkID0gb2ZfYWxpYXNfZ2V0X2lk
KG5vZGUsIGNsa19uYW1lKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYWxpYXNf
aWQgPj0gMCAmJiBhbGlhc19pZCA8IGNtZHEtDQo+ID5wZGF0YS0+Z2NlX251bSkgew0KPiA+IEBA
IC02NTMsNiArNjY1LDMwIEBAIHN0YXRpYyBpbnQgY21kcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICAg
ICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBpZiAoY21kcS0+cGRhdGEtPmhhc19zZWMpIHsNCj4g
PiArICAgICAgICAgICAgICAgc3RydWN0IGNtZHFfc2VjX3BsYXQgZ2NlX3NlY19wbGF0Ow0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRl
di0+b2Zfbm9kZSwNCj4gIm1lZGlhdGVrLGdjZS1ldmVudHMiLCAwLA0KPiA+DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmdjZV9zZWNfcGxhdC5jbWRx
X2V2ZQ0KPiBudCkgPT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdjZV9zZWNf
cGxhdC5nY2VfZGV2ID0gZGV2Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdjZV9zZWNf
cGxhdC5iYXNlID0gY21kcS0+YmFzZTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnY2Vf
c2VjX3BsYXQuYmFzZV9wYSA9IHJlcy0+c3RhcnQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZ2NlX3NlY19wbGF0Lmh3aWQgPSBod2lkOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGdjZV9zZWNfcGxhdC5nY2VfbnVtID0gY21kcS0+cGRhdGEtDQo+ID5nY2VfbnVtOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGdjZV9zZWNfcGxhdC5jbG9ja3MgPSBjbWRxLT5jbG9ja3M7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ2NlX3NlY19wbGF0LnRocmVhZF9uciA9IGNt
ZHEtPnBkYXRhLQ0KPiA+dGhyZWFkX25yOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBtdGtfY21kcV9zZWMgPQ0KPiBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZGF0YShkZXYs
ICJtdGtfY21kcV9zZWMiLA0KPiA+DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiBQTEFURk9STV9ERVZJRF9B
VVRPLA0KPiA+DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAmZ2NlX3NlY19wbGF0LA0KPiA+DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KPiBzaXplb2YoZ2NlX3NlY19wbGF0KSk7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKElTX0VSUihtdGtfY21kcV9zZWMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byByZWdpc3Rlcg0KPiBwbGF0Zm9y
bV9kZXZpY2UgbXRrX2NtZHFfc2VjXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBQVFJfRVJSKG10a19jbWRxX3NlYyk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9DQo+ID4gKw0K
PiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+IEBAIC02OTMsNiArNzI5LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92NiA9IHsNCj4gPiAgICAg
ICAgIC50aHJlYWRfbnIgPSAyNCwNCj4gPiAgICAgICAgIC5zaGlmdCA9IDMsDQo+ID4gICAgICAg
ICAuY29udHJvbF9ieV9zdyA9IHRydWUsDQo+ID4gKyAgICAgICAuaGFzX3NlYyA9IHRydWUsDQo+
ID4gICAgICAgICAuZ2NlX251bSA9IDINCj4gPiAgfTsNCj4gPg0KPiA+IEBAIC03MDgsNiArNzQ1
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92OCA9IHsNCj4gPiAg
ICAgICAgIC50aHJlYWRfbnIgPSAzMiwNCj4gPiAgICAgICAgIC5zaGlmdCA9IDMsDQo+ID4gICAg
ICAgICAuY29udHJvbF9ieV9zdyA9IHRydWUsDQo+ID4gKyAgICAgICAuaGFzX3NlYyA9IHRydWUs
DQo+ID4gICAgICAgICAuZ2NlX251bSA9IDINCj4gPiAgfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+IGIvaW5jbHVkZS9s
aW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IGluZGV4IGY3OGEwOGU3YzZlZC4u
ZmRkYTk5NWE2OWNlIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+ID4gQEAgLTc5LDYgKzc5LDE3IEBAIHN0cnVjdCBjbWRxX3BrdCB7DQo+ID4g
ICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBsb29wOw0KPiA+ICB9Ow0KPiA+DQo+ID4g
K3N0cnVjdCBjbWRxX3NlY19wbGF0IHsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmdjZV9k
ZXY7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gKyAgICAgICBkbWFfYWRk
cl90IGJhc2VfcGE7DQo+ID4gKyAgICAgICB1MzIgaHdpZDsNCj4gPiArICAgICAgIHUzMiBnY2Vf
bnVtOw0KPiA+ICsgICAgICAgc3RydWN0IGNsa19idWxrX2RhdGEgKmNsb2NrczsNCj4gPiArICAg
ICAgIHUzMiB0aHJlYWRfbnI7DQo+ID4gKyAgICAgICB1MzIgY21kcV9ldmVudDsNCj4gPiArfTsN
Cj4gSSBmZWVsIHRoaXMgc2hvdWxkIGJlIGluIG10ay1jbWRxLXNlYy1tYWlsYm94LmguDQo+IA0K
VGhhdCBtZWFucyB3ZSBoYXZlIHRvIGluY2x1ZGUgPG10ay1jbWRxLXNlYy1tYWlsYm94Lmg+IGlu
IHRoaXMgZmlsZSwNCmJ1dCBhY3R1YWxseSBtdGstY21kcS1zZWMtbWFpbGJveC5oIGhhdmUgdG8g
aW5jbHVkZSA8bXRrLWNtZHEtDQptYWlsYm94Lmg+LiBTbyBJIGFkZCB0aGlzIGhlcmUgZmluYWxs
eS4NCg0KQnV0IEkgYWdyZWUgd2l0aCB5b3UsIEknbGwgdHJ5IHRvIG1vdmUgdGhpcyBzdHJ1Y3Qg
aW50byBtdGstY21kcS1zZWMtDQptYWlsYm94LmggYW5kIGluY2x1ZGUgPG10ay1jbWRxLXNlYy1t
YWlsYm94Lmg+IGluIG10ay1jbWRxLW1haWxib3guYy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxp
bg0KDQo+IFJlZ2FyZHMsDQo+IEZlaQ0KPiANCj4gDQo+IA0KPiA+ICsNCj4gPiAgdTggY21kcV9n
ZXRfc2hpZnRfcGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbik7DQo+ID4NCj4gPiAgI2VuZGlmIC8q
IF9fTVRLX0NNRFFfTUFJTEJPWF9IX18gKi8NCj4gPiAtLQ0KPiA+IDIuMTguMA0KPiA+DQo+ID4N
Cj4gDQo=
