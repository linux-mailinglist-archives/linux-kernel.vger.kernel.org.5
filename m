Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975667DC477
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJaCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:36:02 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810BA9F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:35:49 -0700 (PDT)
X-UUID: 315bf412779611eea33bb35ae8d461a2-20231031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gYE/jHgqK6bCE+IXglocAcDYOVFOYyKrVQmUzhV4s6c=;
        b=p0Stcj4/0EG21iq3hVS5e88utPVaFh9XkR2T3/KFDqOc2d2ZaD3z8sq+nwD4B7gb5+iosfkd4zCwe7U1KGoK8qjPCIwwBHHcCjYDpvRHnOyRHcMIX6gcldN9kuHhekqhmVceCCglpOLxxKF/dNN8GoRom+7x71LyHrhcDGjakgo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:d1194ff7-7e3c-4ac2-ad00-f56864020555,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:f052d294-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 315bf412779611eea33bb35ae8d461a2-20231031
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1639910232; Tue, 31 Oct 2023 10:35:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 31 Oct 2023 10:35:43 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 31 Oct 2023 10:35:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrKu8qzAAgkdG3fXEk+HUgoZni+al6EWXmzp2djmZYkXKBwemJW8KMgmKPVmHIrUC3WPsNRikeUu2SDvmqIPz6lVYiCph+ZPQJahbwsfBVAOWsOlmx4wV+WgiAjCVhRuVsre42iehRN2HZlH3GeAIJ43GTDXimGjOOlHTv9wkhil7/qWc+p/LNxBWOpkJcAdMEOjxQuuaMKUDmO+JCXE44dBpeNgnurSZFXNCIFKUc5CiUi3Hqs9xjzPwSe/m8L6JpKmDAuMd20QAg5wKZeVyyCxFB3VXA+qXWXcVoAwrVUvFmUdSFW+GnMovSjXdRy6OqwhgpQcZqEjWnUcPIYU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYE/jHgqK6bCE+IXglocAcDYOVFOYyKrVQmUzhV4s6c=;
 b=CR8odX9qkjfRAUPEVDdsAJJP/vUI9f+fyH1J1AcLZB4HGdxAouIj0OOnp6kHEt5L2lPg9c4wttHBXqmCOGYQHquEwxUebirx61AuPZU4M1dCuQ1pBu/z3Ayrp2uLRu03v73XQ0jbv6fOmjYbFj9MHy9d0r8txTwmIJJeDKJl+aywbCGeKWlESZm+3ce4vSd4qcjO9/vyj/P6WfZdtBUqJIbca3Kz4sur0pROIJM7gI0uHoiYm2nSAVsUKeRwn6U9exB9LRLFM/65tPU0UAxjCqY7a9PeOSwZppJ4WDLsQypMsPk3uZ/IDN0AIin1OMVCjmc3lIYez/e0sFcOLrod2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYE/jHgqK6bCE+IXglocAcDYOVFOYyKrVQmUzhV4s6c=;
 b=AWfM32oLez5ufih+1nxefVJKmf1y4XvMXvULTY0c56QDtpBZs9PE9RxXwf+FQpRcAQhQwEmtdjnqhw6Fm++fgF8gLXNINHTwO1xXIdKJR4yFWZC9iyiwOzVfRCm+iaWaSj4dzJTPSmDiHvW3DB6m+feIgrXHNvlhriLlFpyubqE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5564.apcprd03.prod.outlook.com (2603:1096:4:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 02:34:15 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 02:34:13 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
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
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: mailbox: Add property for CMDQ secure
 driver
Thread-Topic: [PATCH v2 2/9] dt-bindings: mailbox: Add property for CMDQ
 secure driver
Thread-Index: AQHaBWq/vadWk4BIjEWoaSV6NJKP+bBXACgAgAIlpYCABcyNAIAESEaA
Date:   Tue, 31 Oct 2023 02:34:13 +0000
Message-ID: <e85331683751ad52fe34f66b11286ed49c10e301.camel@mediatek.com>
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
         <20231023043751.17114-3-jason-jh.lin@mediatek.com>
         <374a6fe3-23f5-4450-8ef6-8e0478c7ade5@linaro.org>
         <c04109bb54d6d4cf728488a8ed697df0b71f4e46.camel@mediatek.com>
         <f9dd6f3f-4608-4cec-9e54-eeaeb95bca97@linaro.org>
In-Reply-To: <f9dd6f3f-4608-4cec-9e54-eeaeb95bca97@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5564:EE_
x-ms-office365-filtering-correlation-id: 587a5fab-979b-46d5-0630-08dbd9b9dee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9SacaTfhGAHXgoLBi65K3xUW05pq+6MLUDpI8pqyU9/CCVgZ72YqA0sBg9/fOTm/LTULDjkE3MReeG3I1qW5gtc2EmjevJs4fugYKav2s+rQy78l/Qs0/dBqbcFhgHc6ZNxQkcCKXLPjbeyQt5jBYOHPznrZK0+3K71r+AtI4CHmFZNrnjjl0VoT0i9Uw/Isi9VZKZ8HRyJgxdRgYkdRkOayzVgGYc8B+FQEJXT7+iW/3pBTqZrIZJGq9zWWiB8mPkjnS+dCYbf96PA6p9/B+OaOmN/2rnzMaE5JeRQ+L/u4eyo1RmIbDlQcw1eh6oVwax6yrfYyqOvh3E/IcWKaF/QvWLK9iN5u2N6WxgZVegK3JxaFaKhoHVsjPvrppTpRaC16bhI1saZjLOkp3KPRkJENcOAlZs0gKUQSjeC1f/2BrOKawsf77bmYfaZ8C+LkyNU5yfhRbS+ZqRg2VF7YypPB97LHcW3uDVkfKEdnSpvReV6UNJWTgQTPxim75NGfsXZzVr2+4+wxOjVEfNeSFrNAsIT6GMVHSjMTEQlNsZT8FptozoI2FU3071cvKmxEIqAklHUxe8CK1ELFefH0b2KoVMT86fcXPJeua2o3ZPi+PwFx2Zqd1Ui5EhMM6pw1gkItAmciXuDm1QpoK/vgmbLFRyOofePih1ZCn5S6QSSTEjCqk8wfDIJ/LpY8uoK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(6512007)(26005)(4001150100001)(38100700002)(36756003)(86362001)(85182001)(122000001)(53546011)(15650500001)(2906002)(83380400001)(7416002)(478600001)(6506007)(2616005)(71200400001)(8676002)(8936002)(64756008)(66446008)(6486002)(966005)(66476007)(4326008)(316002)(54906003)(41300700001)(5660300002)(66946007)(110136005)(91956017)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXY2N2dDM3g0WFVRaVdMcnZmS1FSMmtrQ2NPTjk4dEhIOVdic3FmY0Q2b1c3?=
 =?utf-8?B?SnZHRkJQK0Y0bHlQa2hyTXdkYjBiWUFsRWFnWnFZTEhmREcwQi9tMk5lMEZs?=
 =?utf-8?B?amUyYTFWQkJzdkM0b05vOWh4MUNKWFdzSG1TenFWa0oycU5hMmgzSTV2S1Fq?=
 =?utf-8?B?UDdHT3hiVDFOeXBmRmpOOTlPbWpTTE9oUytOR2NBZVBHaExtSWZGckRuQ2FP?=
 =?utf-8?B?ZHhmWG9JcngzTWdZckFOT3QvbXR0cGpvQXlOektkeXhhakxvRFE0MkVzQ1hx?=
 =?utf-8?B?L2Q0WGVabHJxRzdFK1ZtOWNIWVV4ZUMxbFpYcU9Xd1pNbWdNcW1pNnV5RzlG?=
 =?utf-8?B?VzFlc2RQZE5NSUQ5eVRDMTFhb0hnTmdTaC9KMmhPWHFWSHJoWVZ0dlNkMHRx?=
 =?utf-8?B?YmhwQ2R1OFFWZUExeVIyTHUzaUNaejY1TEhkNHE1dnpNWXJhTFJLRWkvVExK?=
 =?utf-8?B?S056alJJU1ZLSmxuWXRWYzFWbnQ5SVQyN0ZLemdDeFM3d00zMTdBMkZ0UktV?=
 =?utf-8?B?STVidFVTSEJKcTJudHc1QjN2TCtxS0crRXdKeFJNR1NJdUdiczFpVGJEWjJP?=
 =?utf-8?B?YU1HMGRvUGdlZjRaNEg5MXFOUjc0aS83T25HRG5WN0VpRjRrRkJCVStLeWhF?=
 =?utf-8?B?K0JEaHdCSmt4UGIrT2dOekF3QkZobU9uOVJkcWtHbVcrMVR0RkhEUWdxbDdY?=
 =?utf-8?B?MkRXbkJGMjNpOVJDZVlaWnNVMktRNm1HcWdWSms4bjhsaDRuSGR1VE4xaWZv?=
 =?utf-8?B?Qzl5cjREajVqMWN0ZVhnUEZLUFVGYzgxeUZaMk1JQ2lXYm9zTjg0REp2RnZH?=
 =?utf-8?B?VEtVZzFCSjBqSGpVdzNtcHNqVDFScnRtWkVTOVBGSG5qNElBREgreGRBNVlp?=
 =?utf-8?B?azBIWUhPZHhqQkdWR05sL21PUXV2Y2pyUDkram9PVUU0WHc0bkJnbUZTMXpW?=
 =?utf-8?B?a2Vtd2F6cklGVHdZMGdCbmM1b2hWL3BDdm83NUdFWGc1QjJEbDJTQ0pFWU1y?=
 =?utf-8?B?NnV4TWU2WkZxYTNiakhSSFdhcGFReHFXL1JmM0hSbWU1bGsxQklDbmh5SmRS?=
 =?utf-8?B?YU5sdVFLcmJTVWJEMUZIcWVFbUJWOFRqdExadm5zRy9DZFBOYTBLSUk0T1VS?=
 =?utf-8?B?MEJ2T0dBdCszcEhjK0NBTi9lNmpkUlVHT1ErMGRyQlY4MHVuaGxHQi9WUFpi?=
 =?utf-8?B?bUR6dTBoR2VnTFBRSkZkeTV4bG1VZENyLy9CUDc5ejdQa3Z4Q045UGdGUWRK?=
 =?utf-8?B?ZVJmejI5STR4MCs4dGN2SDc3OWxyTi82WG9JdTlMbk5SSEhMTWhiKzdqTXpK?=
 =?utf-8?B?ZFdhd0FyZ21QcTVCWGJ4YUlTWUsweFgxYmR0dGFKS1huRjl4b1JOMUFBL1NJ?=
 =?utf-8?B?UlpvTTVhdmpVYkc1L3Y2L3FaL05yOHUrd0h5NzZweEJOSEIzM01XK0RUbldT?=
 =?utf-8?B?cXJjUm5PdFhkbEhMOXMvWVBJd0liZmdoQzB5QW0zWHJpRXNHRVMwRldub09V?=
 =?utf-8?B?OWRuYU5ITUMrdmxadTg0aVFGWWh6a1h4ZGM0bGhJaVgxZHRoNjhpRmt6enhq?=
 =?utf-8?B?SVB1MjJkQzdBSy8wc0dZVnE2aDNBYUx4OURFU0tFeHByT2oxRlVSZWVRdzMx?=
 =?utf-8?B?NEYxUjRQRG8zNFR2MVdKb0IxUHZWRjh2KzdXWUpCSWhVMGJ5RDBMWnlNa0RT?=
 =?utf-8?B?b1JabTM1Q3c4MTRKMHVxQjVmOG42ODMyQ2IrTWhUKzhLR1hmN1lGOFR2Wk51?=
 =?utf-8?B?WFVaNkNrTlE1OVFqdjQzTEpZKzNqbXgyMWd6ZnlFanB5OW1QNk9RTkQzVlg4?=
 =?utf-8?B?MjJVWjRvWFM5UWNac1RMQXBDWWU1Mm9XMllCQm9BUXg4bTJNb1htcDNOMFRs?=
 =?utf-8?B?bmVPRk9BVllET1E5VUtwOWt6aVFUWGZjOVNWdDhubVhSR2ZJOUhsZEI5SFdT?=
 =?utf-8?B?QUswdWVPNUNBaExFT0JjTDl4T2J2bmYxbjVhcFp0ZkQyYzVtWk50SW9wbU5z?=
 =?utf-8?B?d2JydzRkUXlaT3g0dkJUQnpNYWd6SiswZnp4R3cxL0JKWGxtOUNCYzM5VjN1?=
 =?utf-8?B?MVExeXp2bTA1eUZUaXg4M1Mwa0lkSTFiczU0QnBxaHlaUE1Kbkh2K3pOWTE4?=
 =?utf-8?B?TUpRQXh0TnR4ZnhuY3A1SjgvRVBRV1E5SW1abW95a29KS0RhYlViem52S1lm?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB285A64CAB4A743BEC44FBCE22312F0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a5fab-979b-46d5-0630-08dbd9b9dee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:34:13.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZzrj23w0VHNCWbZKAoUj8bMHGGBAqu5SVnRRXzPyz3suqGyinxWUVsgnKcoHsJjFdkaOS6eLWL21TBLX7paGsShICTRrcDmbcRIVjurRSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5564
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--30.495400-8.000000
X-TMASE-MatchedRID: eVEkOcJu0F4OwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0rbaVyalxbpdBgZ7Tcj60QbaNnyr85zWcD5bNUY+JJjyFwpnAAvAwazLIb
        YUWjS7yhWhIs6EDztJor50uL/CeFYxEEtnnH5KRd0BEBFOTiHn1sChor7BLiNxR3MCi+lBP8pLI
        yXgGntrnpnNJi30lL2oeWrs0KEirQivR3w1mhnWFt3XMydUaMXINC+F8tjh5Wbaqf1L9+tlN2gi
        q5xRdMLjwQarLbSitQ3LXzHrryidfA5M+x5RjkcEwyZyuMQ410z7HWSgiz9ptSVUkz9BPXehDEi
        nUeUG13i8zVgXoAltj2Xsf5MVCB1goHTpsmNVvyx5amWK2anSPoLR4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--30.495400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 36801915FF3D12B19A6045D407C252C18FFAE5E6D9ED7437F9EBBDA79DA4FBA52000:8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBTYXQsIDIwMjMtMTAtMjggYXQgMTE6MTAgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gMjQvMTAvMjAyMyAxODoz
NywgSmFzb24tSkggTGluICjmnpfnnb/npaUpIHdyb3RlOg0KPiA+IEhpIEtyenlzenRvZiwNCj4g
PiANCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMy0x
MC0yMyBhdCAwOTo0OSArMDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4gICAN
Cj4gPj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMNCj4gdW50aWwNCj4gPj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gPj4gIE9uIDIzLzEwLzIwMjMgMDY6MzcsIEphc29uLUpILkxpbiB3
cm90ZToNCj4gPj4+IEFkZCBtYm94ZXMgdG8gZGVmaW5lIGEgR0NFIGxvb3BwaW5nIHRocmVhZCBh
cyBhIHNlY3VyZSBpcnENCj4gaGFuZGxlci4NCj4gPj4+IEFkZCBtZWRpYXRlayxnY2UtZXZlbnRz
IHRvIGRlZmluZSBhIEdDRSBldmVudCBzaWdhbmwgc2VudCBmcm9tDQo+IENNRFENCj4gPj4+IFRB
IGRyaXZlciBpbiBzZWN1cmUgd29ybGQgYXMgYSBzZWN1cmUgaXJxLg0KPiA+Pj4NCj4gPj4+IFRo
ZXNlIDIgcHJvcGVydGllcyBhcmUgcmVxdWlyZWQgZm9yIENNRFEgc2VjdXJlIGRyaXZlci4NCj4g
Pj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4vYmluZGluZ3MvbWFpbGJveC9tZWRpYXRl
ayxnY2UtbWFpbGJveC55YW1sICAgICAgICAgfCAxMA0KPiA+PiArKysrKysrKysrDQo+ID4+PiAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0
DQo+ID4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0
ZWssZ2NlLQ0KPiBtYWlsYm94LnlhbWwgDQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiBtYWlsYm94LnlhbWwNCj4gPj4+IGlu
ZGV4IGNlZjlkNzYwMTM5OC4uNjVmYjkzYmI1M2I2IDEwMDY0NA0KPiA+Pj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+PiBt
YWlsYm94LnlhbWwNCj4gPj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tYWlsYm94L21lZGlhdGVrLGdjZS0NCj4gPj4gbWFpbGJveC55YW1sDQo+ID4+PiBAQCAtNDks
NiArNDksMTYgQEAgcHJvcGVydGllczoNCj4gPj4+ICAgICAgaXRlbXM6DQo+ID4+PiAgICAgICAg
LSBjb25zdDogZ2NlDQo+ID4+PiAgDQo+ID4+PiArICBtYm94ZXM6DQo+ID4+PiArICAgIG1heEl0
ZW1zOiAxDQo+ID4+PiArDQo+ID4+PiArICBtZWRpYXRlayxnY2UtZXZlbnRzOg0KPiA+Pj4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBUaGUgZXZlbnQgaWQgd2hpY2ggaXMgbWFwcGlu
ZyB0byB0aGUgc3BlY2lmaWMgaGFyZHdhcmUNCj4gZXZlbnQNCj4gPj4gc2lnbmFsDQo+ID4+PiAr
ICAgICAgdG8gZ2NlLiBUaGUgZXZlbnQgaWQgaXMgZGVmaW5lZCBpbiB0aGUgZ2NlIGhlYWRlcg0K
PiA+Pj4gKyAgICAgIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlLzxjaGlwPi1nY2UuaCBvZiBlYWNo
IGNoaXBzLg0KPiA+Pj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MzItYXJyYXkNCj4gPj4NCj4gPj4gTm90aGluZyBpbXByb3ZlZC4NCj4gPj4NCj4gPj4g
VGhpcyBpcyBhIGZyaWVuZGx5IHJlbWluZGVyIGR1cmluZyB0aGUgcmV2aWV3IHByb2Nlc3MuDQo+
ID4+DQo+ID4+IEl0IHNlZW1zIG15IHByZXZpb3VzIGNvbW1lbnRzIHdlcmUgbm90IGZ1bGx5IGFk
ZHJlc3NlZC4gTWF5YmUgbXkNCj4gPiANCj4gPiBTb3JyeSwgSSBkaWRuJ3QgZmluZCB5b3VyIGNv
bW1lbnRzIGluIHRoZSBwcmV2aW91cyBwYXRjaCBoZXJlOg0KPiA+IA0KPiA+IA0KPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMzA5
MTgxOTIyMDQuMzIyNjMtMi1qYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tLw0KPiA+IA0KPiA+IENv
dWxkIHlvdSBwbGVhc2UgY29tbWVudCBhZ2Fpbj8NCj4gPiBUaGFuayB5b3UgdmVyeSBtdWNoLg0K
PiANCj4gUGxlYXNlIGltcGxlbWVudCBSb2IncyBmZWVkYmFjay4NCj4gPiANCj4gPiANCj4gPiBB
bmQgSSBkbyBzZWUgUm9iJ3MgY29tbWVudCwgc28gSSBzeW5jIHRoZSBtZWRpYXRlayxnY2UtZXZl
bnRzDQo+IHByb3BlcnR5DQo+ID4gZGVmaW5pdGlvbiBmcm9tIG90aGVyIHlhbWwgd2hlcmUgdXNl
ZCB0aGlzIHByb3BlcnR5Lg0KPiA+IA0KPiA+IFNob3VsZCBJIGFsc28gbW9kaWZ5IHRoZSBkZWZp
bml0aW9uIG9mIG1lZGlhdGVrLGdjZS1ldmVudHMgcHJvcGVydHkNCj4gdG8NCj4gPiByZWZlcmVu
Y2UgdG8gbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCBmb3Igb3RoZXIgeWFtbD8NCj4gDQo+IFlv
dSBuZWVkIHNpbmdsZSBkZWZpbml0aW9uIGluIG9uZSBvZiB0aGUgYmluZGluZ3Mgb3IgaW4gc2hh
cmVkDQo+IGJpbmRpbmdzLg0KPiBEZXBlbmRzIG9uIHRoZSB1c2VycyBvZiB0aGlzIHByb3BlcnR5
Lg0KPiANCg0KQmVjYXVzZSB0aGlzIHByb3BlcnR5IGlzIHJlbGF0ZWQgdG8gR0NFIEhXLg0KSSB0
aGluayB0aGUgZGVmaW5pdGlvbiBzaG91bGQgYmUgZGVmaW5lZCBpbiBtZWRpYXRlayxnY2UtbWFp
bGJveC55YW1sLg0KDQpTbyBJIHNob3VsZCBoYXZlIGEgc2luZ2xlIGRlZmluaXRpb24gaW4gbWVk
aWF0ZWssZ2NlLW1haWxib3gueWFtbDoNCm1lZGlhdGVrLGdjZS1ldmVudHM6DQogIGRlc2NyaXB0
aW9uOg0KICAgIFRoZSBldmVudCBpZCB3aGljaCBpcyBtYXBwaW5nIHRvIHRoZSBzcGVjaWZpYyBo
YXJkd2FyZSBldmVudCBzaWduYWwNCiAgICB0byBnY2UuIFRoZSBldmVudCBpZCBpcyBkZWZpbmVk
IGluIHRoZSBnY2UgaGVhZGVyDQogICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdj
ZS5oIG9mIGVhY2ggY2hpcHMuDQogICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3VpbnQzMi1hcnJheQ0KDQoNCkFuZCBvdGhlciBiaW5kaW5nczoNCkRvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvbWVkaWF0ZWssbXV0ZXgueWFtbCNMNTYN
CkQNCm9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMt
cmRtYS55YW1sI0w0MQ0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21l
ZGlhdGVrLG1kcDMtcnN6LnlhbWwjTDM3DQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWssbWRwMy13cm90LnlhbWwjTDM3DQpzaG91bGQgbW9kaWZ5IHRoZSBk
ZWZpbml0aW9uIHRvOg0KbWVkaWF0ZWssZ2NlLWV2ZW50czoNCiAgZGVzY3JpcHRpb246DQogICAg
UmVmZXJlbmNlIHRvDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9t
ZWRpYXRlayxnY2UtbWFpbGJveC55YW1sLg0KDQoNCklzIHRoYXQgcmlnaHQ/DQoNClJlZ2FyZHMs
DQpKYXNvbi1KSC5MaW4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=
