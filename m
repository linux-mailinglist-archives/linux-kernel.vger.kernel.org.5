Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A397AF89B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjI0DZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0DXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:23:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38881F1C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 19:48:50 -0700 (PDT)
X-UUID: 5e74b40a5ce011ee8051498923ad61e6-20230927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JRrUVGHHNPZq+Kz8i9fLGIMMweli0dEELW4+sHoPoAw=;
        b=Y09bRk4jVZnmvaCkBmW8KEpSshlVbjaZ6IQYnd3YyMtkl7FM7YlmMg1sVaMuZWMrjV4Bquv+6y9qtQnhZcSOMT4B7jKacBX9Pr31irM99mcYrdrNuv1P8TKxbCoXGGzeXYca+XZidDxvCaYTg15n2wTuT5Ph/RKAndyieq02kw0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:884a2a2b-7aa1-4e7b-8f03-8b5d5409c35d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:887781c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5e74b40a5ce011ee8051498923ad61e6-20230927
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2061880531; Wed, 27 Sep 2023 10:48:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Sep 2023 10:48:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Sep 2023 10:48:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrROvBqwduOdT7Ij9mVFl9qy81p9VMAHN5v8PIFx9bAtmFHpWpD90lbHMLfwPTa/rI1qxy+888EBQM7BMK6vwwP/40oJQgFACdXVM+IRcqG/D6/eUR7jUoRt+Ocg3ZIjoZc/rdAUMPvQDfEByyObVKf4kL6tfRY3sDRfw3tY/n/Pe14QzNsIPTZR/eqGytTrGJvjM7bMRr0wp6FClxlkxFqr5e9kRtn1wN2FWwWmcQb3kQyVa0v50lnAY14qAPuE8+sv79qWKAQZebcGvBluuMZjIjFEWf4xokUOvo0tDMUhwWBNX6awU54zib1xMELMO9z047wuKmoiZy54ayhg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRrUVGHHNPZq+Kz8i9fLGIMMweli0dEELW4+sHoPoAw=;
 b=oe6XNmGaLB0s1fMahKtqksiYiBwGXDplKUbhlPW8bwwOJJKDIozU3X470B4gDs0npeuexP5QdwpTxJPvsTDxalbAPwtLXJ+RQeivrJKIQRheUw+zOi7m1BB75+eKu2yBgRClzlbsZYLMjkleGJxS3QLPqcDlMJIY0T0BWb8mo6aHbjIw5TLWVl9SNvA4rJEsmM368NEnqZDQp8oc5sKPUS2a3bqhlIE4qQUvWBv6ZhHWF6VGN00Knypp+9Zk76A8zZ7ehYND7ANV/5Rwbo3W3k/HbWCGRx437dc+xUQoljy6Jhc6+rH2xySjo+Danf8A0hdfzETI6C8fM8Fv+Lzg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRrUVGHHNPZq+Kz8i9fLGIMMweli0dEELW4+sHoPoAw=;
 b=BkCchM8UYKgjpZnZBQ0CbBhIM5VQHrq+pQXoQChKcEffB+zh+dPWmg/cpRRQJcP0K6L13cxeUMjq/uQpvXoTpHjuewzdr/4saPk8zypcpyCXQcUoo0pfIPCsZiaNS3OOHVyblo8ROdYs0gb5bJk3IXwyukE3wxaytwb18PYzPFA=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB7866.apcprd03.prod.outlook.com (2603:1096:400:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:48:38 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::96c:e99d:e17d:7188]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::96c:e99d:e17d:7188%5]) with mapi id 15.20.6813.024; Wed, 27 Sep 2023
 02:48:38 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "xiazhengqiao@huaqin.corp-partner.google.com" 
        <xiazhengqiao@huaqin.corp-partner.google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [v2 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Thread-Topic: [v2 2/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Thread-Index: AQHZ8C9HSZAc5Nc1pkyU/dr+VO5AkrAt+doA
Date:   Wed, 27 Sep 2023 02:48:38 +0000
Message-ID: <cb9202ded221ad13eaa2acf917d43b27968ef31a.camel@mediatek.com>
References: <20230926040901.20338-1-xiazhengqiao@huaqin.corp-partner.google.com>
         <20230926040901.20338-3-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20230926040901.20338-3-xiazhengqiao@huaqin.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB7866:EE_
x-ms-office365-filtering-correlation-id: a6e6c73a-377d-4fc1-a950-08dbbf044043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3qAa6xUs+w2iFsOpsSg3AWqSrzGMt3w+4kfVUK8gzjEYl7FliJq/OYYd7G10+4/+ZECB0xjaBWNvzotfWLa3aKQVeUiFn1S10IWVa9Itp7OK4J6AmeTZGpmKjWcJcHmD8h1TXW3dEZ4Spdizx/5m8nsd9ScfNb3XnRfiqlDbyYPkhGQF3ZsFkEXZ3Ntr2jlzHYLJcxqAWa+dra3ZwCHIoxe9SRVBlPFXU3fJQ/jLvuFI/BK/Y4+clS5Eg6ZNN5HRP4112AkailY43n+09aVRhG/mJyn/m2egI0NiNLvhaxYH91dfYpFOEaWibD9rIdPQwMPSOurRlM2Wh4omI3CAjN3oWWAoDkVxxJT9hh+3K0o7CZpJhPYrgDyQZigBnSW0St10IcbLVM7hQUk6ZE/xOgFM6/ZW/91bE/dF2ktTwNY2OfcIpJy5wdLfXBJAq/lscKbKnOn2TgSuTPJaau5zjb11ZTWGHPBBgovjI44MydxK3dNqm7OES/l4Tv1le2ur3jg5XxG6mokkK2o2tTK0mnqzayhxf5JYgv8+xNe0p6R84Z+pVmbmxVbuttkx8cNM3Te9wI85rb7tsBG8ByE64mxzS35OIduBSiHeu/HmOjdA6ORGTkWj8KJuy3lswz83XapNwHjlz56tP2TndTTk5fbF6tpFXyRhCRUONVBsTdOyxf3C1NKfZaDWTF1LNVX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(41300700001)(8676002)(2616005)(4326008)(8936002)(66476007)(66556008)(54906003)(66446008)(66946007)(64756008)(316002)(26005)(76116006)(110136005)(91956017)(86362001)(2906002)(122000001)(478600001)(6486002)(38070700005)(38100700002)(71200400001)(36756003)(83380400001)(6512007)(6506007)(5660300002)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NVVFp4a3MvL3JXVkR6K1ZhMTBNYzF1ZFZQWFRyUEMwSE1UeVRvSU91bGFq?=
 =?utf-8?B?d1JXdWE1dkhPZHB6QUpTeFFLbGZhRjErV2NGTUZLNGM2WWlTWUE0ZjY3dTBk?=
 =?utf-8?B?Ni9mSFRrRE1VN21PK0U5WURQR0FCVTZud1BBOWZmbkJaZkkrREVYRzB1aHk2?=
 =?utf-8?B?S1RiVTFhK1NvOEliSmFoYzdlVEZEbWcvVjRzb3NGZkF1VVlzb1JILzhsTTNt?=
 =?utf-8?B?SVhWemhCakJPK3p4ZTZtRzNxK3V5dEpNM0VZak5GS096YTc0U3hDdjloc0dF?=
 =?utf-8?B?K2dhWHNqWXN4dlZwREpyNUpTY0R2SkJ1VHIrWUFvdEtiOGZyZGJPMnY0ZTlq?=
 =?utf-8?B?WHBYU2NYK2g2ajRObk1uS0hTVXRKTmJVOWMvV3lrcVE4R1ZJYnZ2Z2gvSWRx?=
 =?utf-8?B?VHVmcXpqd2R5OERGV3kyMW9pWW1JZXV3VHFvQ0pxSTcyQjFtVmlZSjgrNXB2?=
 =?utf-8?B?YkdGVFVvUVgxeUtpNk0xekVzYWZxY2duNEFCOFFTSG1xeDRUbEdiQkMzZnhC?=
 =?utf-8?B?Zi9TaWZMVFJWc1YvYUhnSXRFK1Z4dVhPdjY0eWxzMENWNyszM1NDZDNJSFR4?=
 =?utf-8?B?Q2d1TVV4QldCZlR4d2VOcE8zSVRyN0Q1ZzhCNHFiRVBTL2NKVjJYVmZqc1Rj?=
 =?utf-8?B?dHdSMld3TUxjTHppRjBrZHF2YTg0S0xobm1RZ2RkK1pKdVd0RmNRemd2Qnpq?=
 =?utf-8?B?RTQ5WUkycXFFMlZVVFgvZGZDbDFuT3JOK2VscmlOekdET0U1TmQ2a2ZYWkdU?=
 =?utf-8?B?N3htU05iRXdoVjhEeUZqMThDbDIzbUc5a1EwdWYveUFaNVhsb3ZoZVNMakh0?=
 =?utf-8?B?SW1JaTNELy8zQmlmcnhDY3ZrSm1wdjdCRitSaXRoUDdPS2xQUlF0M0d4L1ZO?=
 =?utf-8?B?T2FhRzJPNU13UDYrVlhlVVBCaVBJMzlWcVhWNTY1cmJxaVFjS2I3SUppYzQw?=
 =?utf-8?B?RDhPMVdlZWh0aU82anhOOElqRm14dkxsNURrVnF3NzZOQ0ZyZ2I2dHpKZmRw?=
 =?utf-8?B?SWNMVDlWa1MwaUlNTzFlR0dPS1EvbjlSTFM0VkVabjVwMUx6WlR0aG9ZVDNX?=
 =?utf-8?B?UkQxZXBlYUZUZEhPSlNJSm9Ra3psYU9OVW5Dd0lRYzNncThXaGlPT0FRbklO?=
 =?utf-8?B?UEFEZVIwUnNEbVhKSC9DbHdtalArdkNKZERkRnIvRWtCWGJPeWp5V3MwdWtR?=
 =?utf-8?B?cUlFMzhESGFLM2dWL2V5dnp0Y1RVdExKbXRiNTdUb3lwVVBGS2NyQW0yeTVG?=
 =?utf-8?B?YVRKYTlOYVh4N1R5R29Oai96cVFZT2U0U2hzYnlzVDBuQ3N0UitvSlByVnlJ?=
 =?utf-8?B?d05sZDNjeUkySVU0TG56Y1RhQldBb24wVHhDMjZhcU9pOHNXSk0rQTZITEVa?=
 =?utf-8?B?azk5T3dPY3ZoK3JCa2ZGQmpEUGlzU2pxaVB6ZXBCRzU3UDNwS1N4OTNMRWZ0?=
 =?utf-8?B?NWU2UVlNc2I4UVdmTUdvbzQzUDBKU0xiTHJiRGJ5Zzd4bVJrM2NBMzFxU080?=
 =?utf-8?B?UXRlUTZJcUhKd0NTanoyNWpZUy9RRjhNVldPM3V4eTJKT2NYdCtXWjdhUUtQ?=
 =?utf-8?B?K1NuOUxaZkRyalRFcnFIVGlHMFIwMHhMNFR5ZjFvWkVVVGNZYUwwaEV2UnZ5?=
 =?utf-8?B?TU45QktUT0V3OVR1ZDc0SFR2TWNHbVk2UG5lSU1xbHFSOTJOWGd3dVhXaDlX?=
 =?utf-8?B?WFNzSGY0eFlhTlcwTzBwbk1YS29ib2lCVXRQVGpXVW5nM2lvd0RYSFRyNlha?=
 =?utf-8?B?K0ppZC8rdm1RcGNhOWVNYVAxa3JuSGNiNHd4MTk4VloyN0I5alZzMUd2NzFR?=
 =?utf-8?B?TGJRK09iMUFGRUdzUmxUZisxeGhvcCtGZ1dXM3V4OWJsMGNWMVZCd0V1MUlD?=
 =?utf-8?B?VDM2RlY1WjBCd2haMmYzV29xSkR4SlZFTkxjMFhaVDhGMHhGTnhyS28xNmU3?=
 =?utf-8?B?c3I4dFIrMENlT2c5RTF5djdFL2FIK0xDWVNWT09YYzYrVkRPUTZrajFuZmFP?=
 =?utf-8?B?YmZ4c09aNUxQTkd1WGVrYkhKbkNVQW5CMVB0cFBYeVBCVmNIYm0ybzhIV2dX?=
 =?utf-8?B?Z3lzb2lrUDBibUxmSjBzRnEyTjJ2TlJ2QlU1d2xHdnlXa2VNajkrcFBPQ1Bp?=
 =?utf-8?B?ekVJMWdoUHlFRnU5b3JSZEdJZ2Z2YlhBTG9aUzc5UVlLMXBZdG5MeDJmUHQ1?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBADB07DA0EFDF41A0452B600B6CACCC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e6c73a-377d-4fc1-a950-08dbbf044043
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 02:48:38.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inh28S0M58wRK0gddXCZO3VxLelmPsrMW3DC8Bz4qBNK6+Yz2osu+jYtIffH1AdTqrNVPPqmlXHD4ln1BaLT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7866
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.703200-8.000000
X-TMASE-MatchedRID: LVkZzMT5mErUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
        CsGHURLuwpcJm2NYlPAF6GY0Fb6yCk2VnXMRzIBjhDK4kXfgEboxmbT6wQT2a2ecrqZc3vabEyJ
        Eaq6KM3HWsfhGDQA5PbWrjxGHjCv1QgUInkqQBs8+N0lB+o/v7jZs8BrQWsptDlLOAk1ICsuqCl
        PUe3qxhBvafArXkICnJPdUhRFY+eEJW7Uf3mINHhWCVBr+Ay98/5QRvrl2CZDOMdbgLsryf3hNN
        kDTRART4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbtuRXh7bFKB7tchskOsxA5SIVN/
        zIGNkia3uT4Ix127UKYcf4qG3TxISwwcGKLTYEc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.703200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9CD47D346954F2A81451A723B8994C4F8E86A366C53E1FF68A24E48C1A97299A2000:8
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDEyOjA5ICswODAwLCB4aWF6aGVuZ3FpYW8gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgVG8gdXNlIFJUNTY4MlMgYXMgdGhlIGNvZGVjIGFuZCBNQVg5ODM5MCBh
cyB0aGUgYW1wLCBhZGQgYSBuZXcNCj4gc291bmQgY2FyZCBuYW1lZCBtdDgxODhfcnQ1Njgycy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IHhpYXpoZW5ncWlhbyA8DQo+IHhpYXpoZW5ncWlhb0BodWFx
aW4uY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IC0tLQ0KDQouLnNuaXAuLg0KDQo+ICANCj4g
K3N0YXRpYyBpbnQgbXQ4MTg2X3J0NTY4MnNfaTJzX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3BjbV9z
dWJzdHJlYW0gDQoNClNob3VsZCBiZSBtdDgxODguDQoNCg0KVGhhbmtzLA0KVHJldm9yDQoNCj4g
KnN1YnN0cmVhbSwNCj4gKwkJCQkJc3RydWN0IHNuZF9wY21faHdfcGFyYW1zDQo+ICpwYXJhbXMp
DQo+ICt7DQo+ICsJc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCA9IHN1YnN0cmVhbS0+
cHJpdmF0ZV9kYXRhOw0KPiArCXN0cnVjdCBzbmRfc29jX2NhcmQgKmNhcmQgPSBydGQtPmNhcmQ7
DQo+ICsJc3RydWN0IHNuZF9zb2NfZGFpICpjcHVfZGFpID0gYXNvY19ydGRfdG9fY3B1KHJ0ZCwg
MCk7DQo+ICsJc3RydWN0IHNuZF9zb2NfZGFpICpjb2RlY19kYWkgPSBhc29jX3J0ZF90b19jb2Rl
YyhydGQsIDApOw0KPiArCXVuc2lnbmVkIGludCByYXRlID0gcGFyYW1zX3JhdGUocGFyYW1zKTsN
Cj4gKwlpbnQgYml0d2lkdGg7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWJpdHdpZHRoID0gc25k
X3BjbV9mb3JtYXRfd2lkdGgocGFyYW1zX2Zvcm1hdChwYXJhbXMpKTsNCj4gKwlpZiAoYml0d2lk
dGggPCAwKSB7DQo+ICsJCWRldl9lcnIoY2FyZC0+ZGV2LCAiaW52YWxpZCBiaXQgd2lkdGg6ICVk
XG4iLA0KPiBiaXR3aWR0aCk7DQo+ICsJCXJldHVybiBiaXR3aWR0aDsNCj4gKwl9DQo+ICsNCj4g
KwlyZXQgPSBzbmRfc29jX2RhaV9zZXRfdGRtX3Nsb3QoY29kZWNfZGFpLCAweDAwLCAweDAsIDB4
MiwNCj4gYml0d2lkdGgpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycihjYXJkLT5kZXYs
ICJmYWlsZWQgdG8gc2V0IHRkbSBzbG90XG4iKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+
ICsNCj4gKwlyZXQgPSBzbmRfc29jX2RhaV9zZXRfcGxsKGNvZGVjX2RhaSwgUlQ1NjgyX1BMTDEs
DQo+IFJUNTY4Ml9QTEwxX1NfQkNMSzEsDQo+ICsJCQkJICByYXRlICogMzIsIHJhdGUgKiA1MTIp
Ow0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycihjYXJkLT5kZXYsICJmYWlsZWQgdG8gc2V0
IHBsbFxuIik7DQo+ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gc25kX3Nv
Y19kYWlfc2V0X3N5c2Nsayhjb2RlY19kYWksIFJUNTY4Ml9TQ0xLX1NfUExMMSwNCj4gKwkJCQkg
ICAgIHJhdGUgKiA1MTIsIFNORF9TT0NfQ0xPQ0tfSU4pOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJ
ZGV2X2VycihjYXJkLT5kZXYsICJmYWlsZWQgdG8gc2V0IHN5c2Nsa1xuIik7DQo+ICsJCXJldHVy
biByZXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHNuZF9zb2NfZGFpX3NldF9zeXNjbGsoY3B1
X2RhaSwgMCwgcmF0ZSAqIDEyOCwNCj4gKwkJCQkgICAgICBTTkRfU09DX0NMT0NLX09VVCk7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19vcHMgbXQ4MTg4X3J0NTY4
MnNfaTJzX29wcyA9IHsNCj4gKwkuaHdfcGFyYW1zID0gbXQ4MTg2X3J0NTY4MnNfaTJzX2h3X3Bh
cmFtcywNCj4gK307DQo+ICsNCj4gIHN0YXRpYyBpbnQgbXQ4MTg4X3NvZl9iZV9od19wYXJhbXMo
c3RydWN0IHNuZF9wY21fc3Vic3RyZWFtDQo+ICpzdWJzdHJlYW0sDQo+ICAJCQkJICAgc3RydWN0
IHNuZF9wY21faHdfcGFyYW1zICpwYXJhbXMpDQo+ICB7DQo+IEBAIC0xMTQ4LDcgKzEyNzEsNyBA
QCBzdGF0aWMgdm9pZCBtdDgxODhfZml4dXBfY29udHJvbHMoc3RydWN0DQo+IHNuZF9zb2NfY2Fy
ZCAqY2FyZCkNCj4gIAlzdHJ1Y3QgbXQ4MTg4X2NhcmRfZGF0YSAqY2FyZF9kYXRhID0gKHN0cnVj
dCBtdDgxODhfY2FyZF9kYXRhDQo+ICopcHJpdi0+cHJpdmF0ZV9kYXRhOw0KPiAgCXN0cnVjdCBz
bmRfa2NvbnRyb2wgKmtjdGw7DQo+ICANCj4gLQlpZiAoY2FyZF9kYXRhLT5xdWlyayAmIE5BVTg4
MjVfSFNfUFJFU0VOVCkgew0KPiArCWlmIChjYXJkX2RhdGEtPnF1aXJrICYgKE5BVTg4MjVfSFNf
UFJFU0VOVCB8DQo+IFJUNTY4MlNfSFNfUFJFU0VOVCkpIHsNCj4gIAkJc3RydWN0IHNuZF9zb2Nf
ZGFwbV93aWRnZXQgKncsICpuZXh0X3c7DQo+ICANCj4gIAkJZm9yX2VhY2hfY2FyZF93aWRnZXRz
X3NhZmUoY2FyZCwgdywgbmV4dF93KSB7DQo+IEBAIC0xMTkwLDYgKzEzMTMsNyBAQCBzdGF0aWMg
aW50IG10ODE4OF9tdDYzNTlfZGV2X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAJc3RydWN0IHNuZF9zb2NfZGFpX2xpbmsgKmRhaV9saW5rOw0KPiAgCWJvb2wgaW5p
dF9tdDYzNTkgPSBmYWxzZTsNCj4gIAlib29sIGluaXRfbmF1ODgyNSA9IGZhbHNlOw0KPiArCWJv
b2wgaW5pdF9ydDU2ODJzID0gZmFsc2U7DQo+ICAJYm9vbCBpbml0X21heDk4MzkwID0gZmFsc2U7
DQo+ICAJYm9vbCBpbml0X2R1bWIgPSBmYWxzZTsNCj4gIAlpbnQgcmV0LCBpOw0KPiBAQCAtMTMw
Niw2ICsxNDMwLDEzIEBAIHN0YXRpYyBpbnQgbXQ4MTg4X210NjM1OV9kZXZfcHJvYmUoc3RydWN0
DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCQkJZGFpX2xpbmstPmV4aXQgPQ0KPiBt
dDgxODhfbmF1ODgyNV9jb2RlY19leGl0Ow0KPiAgCQkJCQlpbml0X25hdTg4MjUgPSB0cnVlOw0K
PiAgCQkJCX0NCj4gKwkJCX0gZWxzZSBpZiAoIXN0cmNtcChkYWlfbGluay0+Y29kZWNzLT5kYWlf
bmFtZSwNCj4gUlQ1NjgyU19DT0RFQ19EQUkpKSB7DQo+ICsJCQkJZGFpX2xpbmstPm9wcyA9DQo+
ICZtdDgxODhfcnQ1Njgyc19pMnNfb3BzOw0KPiArCQkJCWlmICghaW5pdF9ydDU2ODJzKSB7DQo+
ICsJCQkJCWRhaV9saW5rLT5pbml0ID0NCj4gbXQ4MTg4X3J0NTY4MnNfY29kZWNfaW5pdDsNCj4g
KwkJCQkJZGFpX2xpbmstPmV4aXQgPQ0KPiBtdDgxODhfcnQ1Njgyc19jb2RlY19leGl0Ow0KPiAr
CQkJCQlpbml0X3J0NTY4MnMgPSB0cnVlOw0KPiArCQkJCX0NCj4gIAkJCX0gZWxzZSB7DQo+ICAJ
CQkJaWYgKHN0cmNtcChkYWlfbGluay0+Y29kZWNzLT5kYWlfbmFtZSwNCj4gInNuZC1zb2MtZHVt
bXktZGFpIikpIHsNCj4gIAkJCQkJaWYgKCFpbml0X2R1bWIpIHsNCj4gQEAgLTEzNDMsOSArMTQ3
NCwxNSBAQCBzdGF0aWMgc3RydWN0IG10ODE4OF9jYXJkX2RhdGENCj4gbXQ4MTg4X25hdTg4MjVf
Y2FyZCA9IHsNCj4gIAkucXVpcmsgPSBOQVU4ODI1X0hTX1BSRVNFTlQsDQo+ICB9Ow0KPiAgDQo+
ICtzdGF0aWMgc3RydWN0IG10ODE4OF9jYXJkX2RhdGEgbXQ4MTg4X3J0NTY4MnNfY2FyZCA9IHsN
Cj4gKwkubmFtZSA9ICJtdDgxODhfcnQ1NjgycyIsDQo+ICsJLnF1aXJrID0gUlQ1NjgyU19IU19Q
UkVTRU5ULA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
bXQ4MTg4X210NjM1OV9kdF9tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTg4LW10NjM1OS1ldmIiLCAuZGF0YSA9DQo+ICZtdDgxODhfZXZiX2NhcmQsIH0sDQo+
ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtbmF1ODgyNSIsIC5kYXRhID0NCj4g
Jm10ODE4OF9uYXU4ODI1X2NhcmQsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODgtcnQ1NjgycyIsIC5kYXRhID0NCj4gJm10ODE4OF9ydDU2ODJzX2NhcmQsIH0sDQo+ICAJ
eyAvKiBzZW50aW5lbCAqLyB9LA0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10
ODE4OF9tdDYzNTlfZHRfbWF0Y2gpOw0KPiAtLSANCj4gMi4xNy4xDQo=
