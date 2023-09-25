Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB267ACFCE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIYGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYGBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:01:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E787DA;
        Sun, 24 Sep 2023 23:01:30 -0700 (PDT)
X-UUID: f63187065b6811ee8051498923ad61e6-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2IvufnZl++y4RaQNzQ9ulhPAjNx79Wh2s4t67oCKgWs=;
        b=pkzzP8MpQrWPqxCNr7V+/LyVA5boj2mNVgW2Guy9xjVOap3jgLqBXZcL/7QvT8+Uo8mG2THqDvGGxQcuFbZA2RgzW45YeSXmsAEIm5b/j9Q7iD4tLqKiOS24HoFeFrNQViZcJuZi7ixYv75xWrzP8fedHy8NsgjDR5iqfTLXANo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:420916e4-27e5-4a53-84ee-743fd0cb694d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a6546cc3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f63187065b6811ee8051498923ad61e6-20230925
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1840550346; Mon, 25 Sep 2023 14:01:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 14:01:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 14:01:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSZ4Uf6NCxjTCJIx077RF93ohOExjhlTQzVUaXzYFMClLR9su2m6guOPEbn9piWMepn0ZeCYCjiws7aF2njZQTJcs94ZkANPDLy4MBY6z1yoz/pGYEk261DQh0yIfxaSOUn1U8q/FwZ3Fr/u7L/LhuecdER1zm/RqZQerhOUa3Zr7S7GEIr2W/gXMfIOry+XuVCjoXB1/x3SyDSZtiDjXuLbi+6Rvzen26kgCashrAZfyMmmbVYwD4qjs77JWmDC/nqkQdrRkx8c6/Hx7DkPRsKqPcW+s4vK6Oq9sBcohjezjRClHwidNT1qloyNHQKDiD59jXvMxL1GmKUstERGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IvufnZl++y4RaQNzQ9ulhPAjNx79Wh2s4t67oCKgWs=;
 b=g0QVup1zre+UcgaJXqRXcTsQK+ylfrlet82kOuTD6d/LUB9D+UOf/pqwmSeyNZnE1LrWFZsMPv6cjOp/dxfqXOPXz0jKq1TKXlQEnJOJ27wGOokfY5ft0Ez84zdrYFu7o1sf9ygdpBuGhfQeAuVTxaDVRFOoCbGD8pf78dKtrOTsQJ0snxxFZMnzPQBmR/fT7jYF9i9X5r9HbiFuWF92yCzOkNbaVj1VQLtqCe5LCA6Uwhx+t0TYqvwj29cY1diH0tLNH5/w+jRd3Mab8BUBrqx7yY2LuZUaglxGyeJ5+rKub/wwWCbsjLPkqgDXtfLXxQdlv49xrgKn4dI+YOasjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IvufnZl++y4RaQNzQ9ulhPAjNx79Wh2s4t67oCKgWs=;
 b=sbrzXRTOdQ8KuBNKB4Mza8K/c5JiY4PBl0vgywYBSD1W+k57+UO38HulVC7SCZPrxSmbUwiC0/gSPpG7NZ8vHTITzadoZSYNYZ5M72vMMZCRCBSIAPEJnOw2nLMpckPRIm6OIJe5v7o+u7xqJvTUMgu/yYZ3vcIR+ZPFhq/1je8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB8067.apcprd03.prod.outlook.com (2603:1096:101:167::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:01:22 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1b82:a45d:e171:62e8%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:01:22 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?utf-8?B?RWx2aXMgV2FuZyAo546L5YabKQ==?= <Elvis.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 13/15] mailbox: mediatek: Add mt8188 support for CMDQ
 secure driver
Thread-Topic: [PATCH 13/15] mailbox: mediatek: Add mt8188 support for CMDQ
 secure driver
Thread-Index: AQHZ6mWCmZUY4MLR0kyy2m5qdCRfibAovXaAgAJZKIA=
Date:   Mon, 25 Sep 2023 06:01:22 +0000
Message-ID: <6f1bdf10c87aab40e965bb667eb8036c3e524646.camel@mediatek.com>
References: <20230918192204.32263-1-jason-jh.lin@mediatek.com>
         <20230918192204.32263-14-jason-jh.lin@mediatek.com>
         <87ae80c0-a09b-3642-e3e9-c753cd330bca@linaro.org>
In-Reply-To: <87ae80c0-a09b-3642-e3e9-c753cd330bca@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB8067:EE_
x-ms-office365-filtering-correlation-id: 5adff101-98b0-414c-2e8f-08dbbd8cd882
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLilY2VVJBBHpwIGfp0Ku1b090ZNIpep38IiHqJAwUGVOgM99V969qbtyJCSw7KW8HYieuJrY/rTX9qjiXhZQl8CcZaxIHpXrnD+lTunO6KrGbVO/xClNRSyQLW6KVHq7W02sgwQDGjYnfq2n1P9EvTIEx8ZlvBwB6rnmwem9BKPEVKJbFqdE9YXW1n9kixq7r/FsFYcKhX/DMIiqwXW6ap3zO9W+rhOsDjYCAAn8+Jdlg4z8Vu0YdNCdegpMxzKnz8VMD/xBHZut7gi5iMYA7OoxykArAItRdo3mhuBXIg04zjcKP4sdUPL+7eXZcyEOSyuL6R7E2QuJW5WlGJkZfA+8Bdk4KduQxouSDTklMM+NKq8EMF6NzZL+9MY7F/bVry/dxAi3LYwdbNGwU3CWAgszAOsazpfbFTgf6nfQm3uW0bsjofGwEZ+l25WaOXjczf0qdKbqK6e251koFh60yOIC/ULVQH3adR8PdZEamSvqLKeUTY1UuUhRywDlvGljwztdJo45vlap7iVhlosZtIEPsDSvd0SLfJLQyIuIGRddyV9GqSw3z+w9wqOTg36hRNF0YIk5BrupzjTa4RhU02I1MGEnAW7lRIHDYlG49fu9mdMP2yjUxFwVVjNSPltMo01LM5I1Gn8qCRdwFB492Xr2d9sbPLbWODvjyeB9V0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(7416002)(2906002)(71200400001)(107886003)(53546011)(2616005)(26005)(6506007)(85182001)(36756003)(6512007)(6486002)(86362001)(83380400001)(38100700002)(122000001)(38070700005)(478600001)(66946007)(91956017)(5660300002)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(110136005)(8936002)(316002)(8676002)(4326008)(15650500001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akVBaitDdUkzRUdycGNKSFRNZ2RiMjRiaGhlQnRwdlpZUnhTVWt4OFJndnIx?=
 =?utf-8?B?YitEcWREOUpCQWgvbEp4clVZUVBSTExsWTgxL280d3NURU1tZ0pacDZwWjlz?=
 =?utf-8?B?Mm5DV0xCVllMYlJWcnpiR2FPbCttUVJMMUh4R3k0bGhMZHIyUVR6NFY2bnBD?=
 =?utf-8?B?bGFVVTUxS1RRcTVGdXdLWDlycVFyU3N4bGRxK1hpSzM5K1N3YnphaTZNNGpt?=
 =?utf-8?B?aFF3QXltWkZHQU04c2ROUm5jN3lLQWdJemlndGpOYmp5dGt0cE9HYWsrRzg1?=
 =?utf-8?B?dG5tSmkwdlNzYzVUOXdnSE5pRE5xNkd1K1pLOHB3M05Ubk5XblF4WHVqSkQ5?=
 =?utf-8?B?UkM3eDlGQlZBSXNyTDBvT2wxQ0NoclJqeDhyUFpGOEgzdHZicHFTZFF3dHYv?=
 =?utf-8?B?K21CZ2U5RDYzU3ptVFVwc2F5WGxNeFVqbk1Ob1BKQUpxNDBXRG9tNHJncllw?=
 =?utf-8?B?anp5NHUrL1VhR2szZytFelpoSkZyWFRjRkxzZE9BV3dYY2FXbzVoQXNKVVhK?=
 =?utf-8?B?ZGdHUm5UYWJra2loYjFxNlVLNmdxdDJ1L1BsNDdBSmNlZC9qNFFpaEhUZnY4?=
 =?utf-8?B?T2k5M3BGWDRTQkZUTVJ0ZXNjbHVIbmxWZ2JXTmhzSmlzajY4ei9hQzR4TmV0?=
 =?utf-8?B?ZldwNEplbU5JRHlxNEx5MXp3RmZUWUl6RmVVZG8yNGJPMDN2Q3FHejZQMUEz?=
 =?utf-8?B?UERwZXZjb1o3SkhHM1ZYMTlma3M2UmJMMEtTaDUvcGEzUWtIT1BCbnlJRXN5?=
 =?utf-8?B?eFNESHdIT1dOaHEyR0UyN3RHZXRrNm1TWThzU0tpNGJ6VFFZVnVndVIrMUV4?=
 =?utf-8?B?VklVV3ZNakkwL2x0MVcrNEoySVYwZ29BdkRGZzl0STh0VU9TMExVcWRMZXRx?=
 =?utf-8?B?ankya2ZBV2NPMGFaeDViVVFGSStROXhRRXhtN1ZFQ3M3MXpHS2REaG8rNDVp?=
 =?utf-8?B?VGgvTjhQNk9kZkZiK2FYMktHSUhiSTJFeEdlV1pYMzNCVGtubllGemxjYVRP?=
 =?utf-8?B?a1AyWnI5dm5sVjFyU3p0enIxc3kwbUYwNXZnNWJFYS9LZDFCTVNTOHRIa1Qx?=
 =?utf-8?B?RDZVYThsYzVEc0g3aXRqdUhvWDRVaWJrL2pyMVVPR003TDVzYmdQdUdXdUZi?=
 =?utf-8?B?Si91dHBpbVRkUCt2Ry9XQWE0WnV3M2cwYkRzMUtIOWZydTF6MG5XTHI5QWJa?=
 =?utf-8?B?dGptbGk4ODVmMldxcEVrMU1NenZpQXBZczRuakFtbU9Wajd2WTRWQzJpOVEw?=
 =?utf-8?B?UmNYcTFoU3RIek1DM1BGbGtXNzNiaVNCZEhiYTRMSG02TnpScXo2Z3dBbVRH?=
 =?utf-8?B?NmVwcEszNDVnenhYRGVQcEFIUEo1NFJlV2hZYUR5SFBTSzZpdGhsYmU5TUhQ?=
 =?utf-8?B?WmhMWXhVTWJkOWQ2YTI2QmtsbUdEMzdZZUVRZi81QnpBdkRUMkZJNE90Z2ZU?=
 =?utf-8?B?WU5mTXlGOUx0OHdZcmw4VE9nbFl6QUNISkF0elRqb0xqd3ptN2ZvR3ZrblIy?=
 =?utf-8?B?NFpYTkpzV2JkWEd5dit3K2p0NThRS1Z3d3BYWk5CMHU0dkNySDBhbjA4ak1s?=
 =?utf-8?B?eVBQUldvbUJoWWJUbjJONmpsV0Iwc1psM20xV1JpWENjS0t2MlVKWU5XKzVL?=
 =?utf-8?B?RXRBVjZya1YvVUdaWGVhcTZxK0FQZmQvYUJEMXhxbkVUZkxHZTVqUE04ZkdT?=
 =?utf-8?B?dVpTZVU4RjdFSEF0RUpvanJtYzhKMzNtc0JPL3ZEa0lIZmoxMlNmOTNJUmhs?=
 =?utf-8?B?SmYwSnFjMEY0eUxVK1VkTlM3aDE0T2szZWNVU2RxVGNXcjRoUFRlWW9lTy9F?=
 =?utf-8?B?cnJtWjBEZit3SVN2ZGZ3S2NEelBvaVZqL3dIa2ZhZi9vU21Lc1dqV2dWWjFq?=
 =?utf-8?B?NFBSUi85UGovTnFXZ2tsNDVMVFo0Yi9qK0x4aDNqTXM0eTR4V3lWZDZHSHIy?=
 =?utf-8?B?ZkMyb1d2NkxSVERPMTFMeFg4b203UmF1N3cySitJV2JSSmY3SzAyVDNaZzFP?=
 =?utf-8?B?NUZ1QkJWVTdyMjRuVUF1a1dIQWtaY0kzZXVwYU9LOUNoanJxSm9ERTBwdmJF?=
 =?utf-8?B?VUttV0U0UHZCajVlNG00ZnVNWXFTVGJzUmZUZGpwdi9acXdubm5sdkQ4NVdh?=
 =?utf-8?B?YTUvYzI5c292Smt4MDBhd003VGRrSW5EMVpPMW52VEc5OXBoMk9pMFVRNHhx?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73EEC257D6C26348B0855CB3458EB32C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adff101-98b0-414c-2e8f-08dbbd8cd882
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:01:22.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2Y3GFs4T567h8ExyvsTL8yniL6W5yVsF1YBghcf72ghHgQAv38Sr5/jMBERPVfOoBkHDjSzl6aBoGfGxE2+YEq+8trrjTiLE0vCagcoCic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8067
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.459400-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0rbaVyalxbpdEaWGOeKmQYQAjTI/+6gf4NMjQ19j30wyd9RlPzeVuQQj3Q
        bFpHxze2uhRwhmhuOv2qB6SGBSa2y7bdBxC9wVFejFYHTfcPkwkKzuF0egUUDC9/FfQ/6pO2jxY
        yRBa/qJRVHsNBZf9aRPcCXjNqUmkW8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.459400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 4C54613C7B1312D4E219FE4C7BB957BA2972D2A02B1A26910855A90173DF21082000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBTYXQsIDIwMjMtMDktMjMgYXQgMjA6MDkgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMTgvMDkvMjAyMyAyMToy
MiwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IEFkZCBtdDgxODggc3VwcG9ydCBmb3IgQ01EUSBz
ZWN1cmUgZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFz
b24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210
ay1jbWRxLW1haWxib3guYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiBpbmRleCAz
OTQwYjlmOGU3NzQuLjRlMDQ3ZGM5MTZiOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRx
LW1haWxib3guYw0KPiA+IEBAIC03NTAsNiArNzUwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBn
Y2VfcGxhdCBnY2VfcGxhdF92OCA9IHsNCj4gPiAgLnRocmVhZF9uciA9IDMyLA0KPiA+ICAuc2hp
ZnQgPSAzLA0KPiA+ICAuY29udHJvbF9ieV9zdyA9IHRydWUsDQo+ID4gKy5oYXNfc2VjID0gdHJ1
ZSwNCj4gDQo+IE5vLCB5b3UganVzdCBhZGRlZCBpdCBwYXRjaCBhZ28uIERvIG5vdCBhZGQgYnJv
a2VuIGNvZGUgYW5kIGZpeCBpdC4NCj4gQXJlDQo+IHRoZXJlIHNvbWUgS1BJcyBpbiBNZWRpYXRl
ayB0byBoYXZlIHBhdGNoIGNvdW50Pw0KPiANCg0KVGhpcyBwYXRjaCBpcyBkaWZmZXJlbnQgZnJv
bSBbUEFUQ0ggMTQvMTVdIGF0IHRoZSBnY2VfcGxhdDoNCltQQVRDSCAxMy8xNV0gaXMgYWRkaW5n
IHRoZSBmbGFnIHRvIGdjZV9wbGF0X3Y4IGZvciBtZWRpYXRlayxtdDgxODgtZ2NlDQpbUEFUQ0gg
MTQvMTVdIGlzIGFkZGluZyB0aGUgZmxhZyB0byBnY2VfcGxhdF92NiBmb3IgbWVkaWF0ZWssbXQ4
MTk1LWdjZQ0KDQpJJ20gc29ycnkgYWJvdXQgdGhhdCBnY2VfcGxhdCBhcmUgdG9vIHNpbWlsYXIg
dG8gY2F1c2UgdGhlIGNvbmZ1c2lvbi4NCg0KSSd2ZCBidWlsdCB0aGUgd2hvbGUgc2VyaWVzIGJl
Zm9yZSBzZW5kaW5nIGl0LCBzbyBJIHRoaW5rIGl0IHdvbid0DQpicmVhayB0aGUgY29kZSBhbmQg
SSB0aGluayB0aGVyZSBhcmUgbm8gS1BJcyBvbiB0aGUgcGF0Y2ggY291bnQuDQoNClNob3VsZCBJ
IG1lcmdlIFtQQVRDSCAxMy8xNV0gYW5kIFtQQVRDSCAxNC8xNV0gaW4gdG8gW1BBVENIIDkvMTVd
IHRvDQpzaG93IGhvdyBpdCB3b3Jrcz8NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg==
