Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E0276E120
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHCHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHCHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:20:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA78F2D71
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:20:25 -0700 (PDT)
X-UUID: 34e3520a31ce11ee9cb5633481061a41-20230803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=x7lMhlIvm1+no3/hMHQP9qiHyB+TGnJH598NQhpFySs=;
        b=aHXbA5uUG7dNWpnH3HU9pEceQFjOBadb+YIR+3WkTvJSkHUKX+HUp4RxZhggf1AQwfOv/ozYMpT7z1I78qD6jfZFJoDEhxbRgYomFq+g/KBD7Md9fY2i3C9KIDnx5xbY0/VsPQx0SuBpNf1uJKbFAC19qVszTjvPqx8Y1oXyACY=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:852b1985-ef93-4763-8ade-8cbe60a8e43f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:82
X-CID-INFO: VERSION:1.1.30,REQID:852b1985-ef93-4763-8ade-8cbe60a8e43f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:82
X-CID-META: VersionHash:1fcc6f8,CLOUDID:eb40c442-d291-4e62-b539-43d7d78362ba,B
        ulkID:230802225303LTIP56LL,BulkQuantity:14,Recheck:0,SF:29|28|16|19|48|102
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: 34e3520a31ce11ee9cb5633481061a41-20230803
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 228324080; Thu, 03 Aug 2023 15:20:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Aug 2023 15:20:20 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Aug 2023 15:20:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZnsLIUkNihNQFopRAn8ODDQ47PH3G7kI8XzZ9hVaBSSw+Ku2+uAHxEjjhrlzpCjtzwcIEUSZmcFXFcMNahBfG2tvRra9NvL13PyZxe9XPPKcYQJNzIEjQFRhDhkZrrna37sR6DFqv6dVJWTiFz6HJgFaKarKxT+9ijH8sBIOAzeOjGa7eJeAUwaCKgmfKg/ZclgAjbJaR7LSzRkATnEKmcOAF469YBBNf8+Puiv9fzxxTlodq806K70JPi4TB5bn/hFpfT4EJ50WwLXsX405sh0EtFZrwZlXBkjHqla81PoAjhGNIylc99vEr2jIZsy8Otn631Xe8EO1se9FqUG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7lMhlIvm1+no3/hMHQP9qiHyB+TGnJH598NQhpFySs=;
 b=GTUzq+nQ7KnzhYT9E274ZMdLLjEZ3JpqtJ2Q3INecDTTQLeEr3gDr0DV/b6Rq+CR2Ra7YpZ4sbkY+3khwTM27T/YLFBKry1HbDRN39z4sMMXhYE3NHsOVZaLCjlbEbqT7Q/w2dEPG0/gClUrzmWwGhxLth8+XnRi8z0H9n2lzNqoBHU4OJeCYCp2W8Y/om7G7vNEFZ5bR8UEEHQTqXpwceJXp1zh+ovmX5UmJWd0jBQCVq7zUqhPj+epMDC21EjM6ptPzo6yvEKDsqWeHufpgg4ssXw1MiUcJqDFntyKLQvgjqvIvOTz1vObufJhoBApjAEUkosxObprRda1oN1T2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7lMhlIvm1+no3/hMHQP9qiHyB+TGnJH598NQhpFySs=;
 b=baGTmVmycn5zS6OJnI7EyIR+78VdH6pe80UZkdvcBj3QoPKoubqDZU59RrNbO3RDBMPO/xF52McAOQUDvABgSPIuMBMPBT1IYJq5O/Mtyz/Pb8elmXuF8urLmtMXO9ATfuPJgak7jSng+8ctrqbpMkNWItNdXPNGmKaB95yblYo=
Received: from SEYPR03MB6459.apcprd03.prod.outlook.com (2603:1096:101:50::10)
 by SG2PR03MB6586.apcprd03.prod.outlook.com (2603:1096:4:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:20:15 +0000
Received: from SEYPR03MB6459.apcprd03.prod.outlook.com
 ([fe80::b532:b348:3c02:982b]) by SEYPR03MB6459.apcprd03.prod.outlook.com
 ([fe80::b532:b348:3c02:982b%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:20:15 +0000
From:   =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [v3 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Thread-Topic: [v3 2/3] ASoC: mediatek: mt8186: correct the HDMI widgets
Thread-Index: AQHZwxDWBavvSbTht0etjS6nC3ISe6/TxFwAgANXjQCAAB2hgIAA9jgA
Date:   Thu, 3 Aug 2023 07:20:15 +0000
Message-ID: <6aa6947865795fc534b61f5b8a80b3c42fd5a0cd.camel@mediatek.com>
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
         <20230730180803.22570-3-jiaxin.yu@mediatek.com>
         <25e6ab45-ecad-4bc3-bf4d-983243c939ad@sirena.org.uk>
         <c6ae8630d06138b6d0156c19323afebf0718f522.camel@mediatek.com>
         <089fe457-1c61-4b7b-ad37-a67e7f46cb56@sirena.org.uk>
In-Reply-To: <089fe457-1c61-4b7b-ad37-a67e7f46cb56@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6459:EE_|SG2PR03MB6586:EE_
x-ms-office365-filtering-correlation-id: 1864e57a-9f6e-4ceb-8128-08db93f21559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iswgkusl9I/pAgjsT4zOv0lDNPhmwjy9lcIhdFU9fxOEAs9AZRV+A0hEwmPnvXTgwUhJ1Syr2ufWWq10gvKCvvZk+sjlATuYT16odZLJzYas4WvlSr0ZT6hbKbY89P4jyx0qQF9me6PnZYYsNNtOC9FGaZpOIlwGzc0EFlPL9GWNLyTirtaD2TbwrBB+Qonasf+tWLv6UbLs7m50O1rueMCqRRD/2gR8ly9kQyrS1gsnkmVGmINJkJRvSJzAeIzHnS+CzyuvWj53yRvmYuCAwpiJ+dxeWWStq356NOpr7GV5bxjDIoGSKeiqGVan8XRmZD93CsK1PjPphwvl0d9q0Y2GkV+pVBnpajAdLXLHwc5JZoodlIyVmJnWge+a/R1zGY7agUXqV2EFV7DLEg8//s9mRtxnQ1tkMdEf7SJbZWUPwHYmFeafBp6rj7j7pk+pPCHDVPyw5vqTvFOIMX27r8eJf3I3uFfbWXLmT8qUH/oRbj73WYTeoclskPTJktpIJl9HsgV6pgIfbEtJ61Ite9H7lOpZrYA8tCmbAnAwdBz5YxVFuTgaZ8OD0xr9imJP/dqGCUxSOp1jW0om2l81D61vS7ToT+Hke6Yzq04KhiSR5AtreG8PHxa0Jf0wSxr7rcWjqHmWE9rKiuuya9aTVHTj4aaUKA1/7xSw0HuK3Zg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6459.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(122000001)(6506007)(26005)(38100700002)(186003)(38070700005)(2616005)(83380400001)(2906002)(85182001)(36756003)(5660300002)(7416002)(54906003)(478600001)(8936002)(8676002)(86362001)(6512007)(71200400001)(6486002)(41300700001)(316002)(91956017)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(6916009)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUs4bUtNakpVQW5pc1B0WkFVM01pUklTbEpFYkF2b2JQM1VwdmtwbzE2Nmgw?=
 =?utf-8?B?VEhBMS9XQ0NsRktkVW5GLzlYVnZBNjFEMmE4c3hlYjh4enlZbGNkTzVlS1Rs?=
 =?utf-8?B?WXM1RjVWMlVUYnNTdWhyWkFDL0FIMnJNODhxbXlmRkNrNHlUSjlES1g2Y3pv?=
 =?utf-8?B?Q2VCNUhncmV0R0VQSFhNajJ2WjUyRU1BUVUwU1B0RVJIOW5OQk02Z05YbUx3?=
 =?utf-8?B?MkJzMTMySjhUQ2F2S0hyN3ZYUWR5NmZzNTc2a3FIdE9lVVl3U3FOdTNwUi9T?=
 =?utf-8?B?WlBqUnJRZ0xXNmZmTG04ck5yditUcnJRK0svMk02YzVmNitpVk8zWDZOcXVo?=
 =?utf-8?B?RzdwaS92NU1lcTVPQ1RPazZ4UU9vZkltcFdQRU1iOFpZTVVlV0hCMzJSaURh?=
 =?utf-8?B?Q01Jb1hEaXVobVdwZVBvcE02RWhsYzgrVU1JYSsvczhRRTJKazllN0FHeTAr?=
 =?utf-8?B?TGgwSWxRTjE5MFdjMkNOUmJDUFBBNHkwQnlFU0FOUEZuRjFtTC8xazZLWGpN?=
 =?utf-8?B?TzUrNWtDeTBMVmpVanRmYUhBWk03U05CVldmWW5QMGlQMXdGdFFTSUptQXNP?=
 =?utf-8?B?bTRSaTNZL3VjMWRtU2Mrd1N4WHVpQWtQaVJxUVh5aXIxUFRranNVWDFhRk9D?=
 =?utf-8?B?MXNodE81WHkrOG8rcHp2QWR1SFl3dFBGd1o1eU9nc1FYWnFQbVNFN3VxSHVT?=
 =?utf-8?B?NDVWeXVDRUJvd2hYVjF5VGd4KzBYK2RRN1JweWh2WlNEVitkY2QwK2V5dW9K?=
 =?utf-8?B?ZnQxMHg3MWpXVXAwdy9tMjltZzBxT1lBeW1wdk9QWEg5T3dOT0NSR0lpeDJT?=
 =?utf-8?B?OTNoellrWHBDNXVyYS92b0Z1V3JZeUpObWRLN1NTK0lQWjBIZGxLNmwvN1E1?=
 =?utf-8?B?ZkZRTzVwUjRZTVFSTlVsRzllM1hkYVo5b3NNZXVZUE1vUWl6VDBoN2Y1bDlp?=
 =?utf-8?B?dnlyQ0p3cWZ1NkhxTnM2KzdJUnorRmxIQlJabWptK3BORldKbzFJMjF5cVlM?=
 =?utf-8?B?Smd6RENuYWFFYkx5b0psZXdVZ3NIZmY5QVZ4S1V1VUVDT2xvUElabVhTejk3?=
 =?utf-8?B?QzAvOU12bjJRU1hlY0dXTysrVG43cmVIQitDUFd6V0pZOFFrMEVLUTZwaVJC?=
 =?utf-8?B?NS9adUN1ZTNkUThGWmFUdEY2Z1lkd25uck1nem8wcjNzcXg0QWRKMFdmUXJN?=
 =?utf-8?B?QzF0OElZUWVQVmFIK1RnQk50R3dmVDJZTlpTaE1xWXljcmV3RU9qVkh5WWFx?=
 =?utf-8?B?YmdDUm1XeWlYdVVpd0NXTisrclBBVE9WUEZPY2d1amxTN2djSVhkMkFUb0lU?=
 =?utf-8?B?aWRoc0VUM0IyUm9nT2s4QTI4N1BmdmJHTHJtdzIvSlFYNnpJK3BRN0dmeS85?=
 =?utf-8?B?a0ZjMnErcmRLc1BJTndZYTdBNGkreW1vcytHaFFPM1d6QU14RFJaYTNnUis0?=
 =?utf-8?B?eUFZNDdJWGZnSU1nd3UzMFhyZkhyWXNhcjRWaDNHOGNYWVpYdm9vaG8vUHE1?=
 =?utf-8?B?MXNLSzRQR1hMbytTYTkzdkkvNFhjZGVVQU5mRXZQVEtybTVMK0tncGFmZmV1?=
 =?utf-8?B?TWJNVmR4M0ppeHg5SHRzZzE4TWpzc1pUdUI4REgyNGtpWUptZ2hmbVp0ZFl6?=
 =?utf-8?B?L2c3bVVmL2pFNTlGTlpldG03alNyK0tycHNaeTcrR1RKWkplRjBMY3kxSTA0?=
 =?utf-8?B?TTBJaW5ObjUxZExhL3loNjNDd2V2dHNlR0VTcmxMQXFmWGswOHZYYjE4dVNW?=
 =?utf-8?B?N29Hd3IzYkxuTUpRUTdqMDNsUDFjUjZZbWd3dE1rSDZCd2VQZTl2VThzY0Rh?=
 =?utf-8?B?ZklZbTBjMEUwTDY2ZkdZbnR1TWQ5Z0M1RnV0N2xMT0NiL0t4aXJQblg1SERv?=
 =?utf-8?B?KzFwOEVSZWM5WW1ld3dzc1k5TWRjMGFmdVlMZ2dvNGI4RWg5UHVIZFpaRFA4?=
 =?utf-8?B?ejRYV054a25QUHFJUlprR0V5NVN0ejdyOGg2aGdKT3BRSFM4UkJuSTlSUmVn?=
 =?utf-8?B?cWRnaDEyeHpsUkNJVTBYYWdITjhlVGNqMlY0K3lVMmhVTUtOb0NIa2Fma3Mw?=
 =?utf-8?B?ZkZWL1BzcEN6ZU55OWRQcXhGaDZsbi9oMmFqU3Y0R2xyZU9HRHIwU0Z4Y01D?=
 =?utf-8?B?c2ZheDJUenhaOEdDd0Excm9IcXFMTndYT2ZTTjhyL1h6b3RKcVJNdHZxRGVa?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A82F25C250C9B49A02413789F617A83@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6459.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1864e57a-9f6e-4ceb-8128-08db93f21559
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 07:20:15.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/MbAacKtIixiMBfWURq7uf4stlvVsnJSBemWBXhjzFf8mixmSmW9g2lqm+Ea10n9d9Gq720Tg7HhLqXEprAvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTAyIGF0IDE3OjM4ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAwMiwgMjAyMyBhdCAwMjo1Mjo1N1BNICswMDAwLCBKaWF4aW4gWXUgKOS/nuWu
tumRqykgd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIzLTA3LTMxIGF0IDEyOjUwICswMTAwLCBNYXJr
IEJyb3duIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBKdWwgMzEsIDIwMjMgYXQgMDI6MDg6MDJBTSAr
MDgwMCwgSmlheGluIFl1IHdyb3RlOg0KPiA+ID4gPiBVc2UgU05EX1NPQ19EQVBNX0xJTkUgaW5z
dGVhZCBvZiBTTkRfU09DX0RBUE1fT1VUUFVUIHRvIHRyaWdnZXINCj4gPiA+ID4gREFQTSBldmVu
dHMgdG8gaGRtaS1jb2RlYyB3aGVuIHVzZXJzcGFjZSBjb250cm9sIHRoZSBEUEFNIHBpbi4NCj4g
PiA+IFdoeT8NCj4gPiBJIGhhdmUgZGVmaW5lZCBhbiBTT0NfREFQTV9QSU5fU1dJVENIIHRoYXQg
bmFtZWQgYXMgIkhETUkxIiwgaWYgSQ0KPiA+IHVzZQ0KPiA+IFNORF9TT0NfREFQTV9PVVRQVVQs
IGl0IGNhbid0IGJlIGNvbnRyb2xsZWQgYnkgSERNSTEncyBQSU5fU1dJVENILg0KPiANCj4gLi4u
DQo+IA0KPiA+IDI3NjIgICAgICAgICAgICAgICAgIGlmICh3LT5kYXBtLT5jYXJkLT5mdWxseV9y
b3V0ZWQpDQo+ID4gMjc2MyAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gMjc2
NCAgICAgICAgICAgICAgICAgZXAgPSBTTkRfU09DX0RBUE1fRVBfU0lOSzsNCj4gPiAyNzY1ICAg
ICAgICAgICAgICAgICBzbmRfc29jX2RhcG1fd2lkZ2V0X2Zvcl9lYWNoX3NpbmtfcGF0aCh3LCBw
KSB7DQo+ID4gMjc2NiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocC0+c2luay0+aWQgPT0g
c25kX3NvY19kYXBtX3NwayB8fA0KPiA+IDI3NjcgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwLT5zaW5rLT5pZCA9PSBzbmRfc29jX2RhcG1faHANCj4gPiB8fA0KPiA+IDI3NjggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwLT5zaW5rLT5pZCA9PQ0KPiA+IHNuZF9zb2Nf
ZGFwbV9saW5lDQo+ID4gPiA+IA0KPiA+IA0KPiA+IDI3NjkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwLT5zaW5rLT5pZCA9PQ0KPiA+IHNuZF9zb2NfZGFwbV9pbnB1dCkNCj4gPiB7
DQo+ID4gMjc3MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXAgPSAw
Ow0KPiANCj4gVGhlIGV4cGVjdGF0aW9uIGhlcmUgaXMgdGhhdCB5b3UnbGwgY29ubmVjdCB0aGUg
b3V0cHV0IHRvIGEgd2lkZ2V0DQo+IHRoYXQNCj4gY29ycmVzcG9uZHMgdG8gdGhlIHBoeXNpY2Fs
IG91dHB1dCBvbiB5b3VyIGJvYXJkIGFuZCBwdXQgdGhlIHBpbg0KPiBzd2l0Y2gNCj4gb24gdGhh
dCwgaWRlYWxseSB3aXRoIGEgbGFiZWwgdGhhdCBjb3JyZXNwb25kcyB0byBjYXNlIG1hcmtpbmdz
IG9yDQo+IHdoYXQNCj4gdGhlIHBoeXNpY2FsIG91dHB1dCBpcyBjYWxsZWQgb24gdGhlIGJvYXJk
Lg0KDQpEZWFyIGJyb3duLA0KDQpJIGFncmVlIHdpdGggeW91LCBpbiBmYWN0IHRoZSBzcGVha2Vy
IGlzIGluZGVlZCBkb2luZyB0aGlzIHdheS4gQnV0DQphYm91dCB0aGUgaGRtaSB0aGF0IG9uIHRo
ZSBib2FyZCwgSSBkaWQgbm90IGZpbmQgYSBkZWZpbmF0aW9uIGxpbmsNCnNuZF9zb2NfZGFwbV9o
ZG1pLCBzbyBJIHVzZSBzbmRfc29jX2RhcG1fbGluZSB0byByZXBsYWNlLiBUaGUgcHVycG9zZQ0K
aXMgdG8gY29udHJvbCBpdCBsaW5rIHNwZWFrZXIuIE9yIHdoYXQgZG8geW91IHN1Z2dlc3QgSSBz
aG91bGQgZG8/IA0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0K
