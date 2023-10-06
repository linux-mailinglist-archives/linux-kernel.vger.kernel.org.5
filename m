Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356837BB40C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJFJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJFJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:16:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562829F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:16:09 -0700 (PDT)
X-UUID: f878a224642811ee8051498923ad61e6-20231006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wpqzKOAXPudRRjhQPPtjDmqmrsnMNoqd3zWJIHTkZE4=;
        b=Nz777PK2WJjrRGuzwbGOfuKLSNmlnzvshOagpI3OiIsHFCYOMM/Xt4ehG0J2mlQt2tqoQD6ahoVwCgdqo+A1ui69OrP76tvt4EwhfEGNQ7ZJl4y4wlnBqLT6SHfc5XBDTDIJlCrn5oUQkazORmWm8a/ndj1dHZNUl6+/NYMt9k0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:8391aad0-afa1-4b65-b474-2734e4308fcd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:1f92d8c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f878a224642811ee8051498923ad61e6-20231006
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 280994694; Fri, 06 Oct 2023 17:16:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Oct 2023 17:16:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Oct 2023 17:16:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL2ViLlTRcgmgvQejuyviJKYsYwGxNiFuv+aKUlvKM5N71+PoTToa8joWLO6SzgrIV8rVFbYfcrh6o08ZuT0a5lMsh6WUNi58daEs2+r+ivrBnwH4Yu8dsg4/XbufwWQxNFdWII/EXnIm1qC5N8m5QkohAynzsnUmJUSOsR/NLfcYxTMVXt8E+cSYGfYzBZ8SvlRyefIqsIF9UH40V00GefHdzMy6ocaXftcGodEvKzLOzfpNNoJqXAYDCv3+8xHRs0MT/XBwWJPgjUghQV6syI++8zqTUQj0zOcp5l99Ns6jGTY5sYkLt9/SO7HUwFqN0SA0/U96npkmlNiD+qYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpqzKOAXPudRRjhQPPtjDmqmrsnMNoqd3zWJIHTkZE4=;
 b=VJ5WlYvHoeg/o+pY8QM4hy2K2VxPEpehMWzb8Mg0L+XiYm8Rqdmjesx0gfD/Sm9nbtCMAWE4bgv3yVkbn3skdg2Z0ZFqpRyG3be+RuPAtcsc4qmqPH1NQDQl2oN9T+llhoDvld1PP+KDIiw7WMmheriWg83KQWJwsWjG1UCePyb5/QDMM+hCEb6D5ISnLFkl/hWi0WS/XuSLJ2jIQiTbm+IMDT4MbWcXakn/fU36bwNOD/q8GMzyNTbnRodfiuqHy0SJ+3h8XJ/RfrjUrLWzw/mxiVqw7/Mmp8E79vRMD0tHqmJwLrZK6Nl8ZASplN9eC0zTif69M9BsBq57mCctHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpqzKOAXPudRRjhQPPtjDmqmrsnMNoqd3zWJIHTkZE4=;
 b=Bl9FIHz7IBviUUOwybpkjQonHrgu9UzUgauNWhuCqUTubzywQAGHFLw+W6Izq5NbzQddBcAdp8IEr3bh8q87EqvP2uvX7aZihx7f7Gkv2s6AAMzfWoTUJhBwm8V9N+VZ+lJ0iPjCkkwIscIP/xu+lkPnDNAf+dLwY6NOsANveCs=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7608.apcprd03.prod.outlook.com (2603:1096:101:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 09:15:58 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::8c0:a8fa:8e5:159d%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 09:15:58 +0000
From:   =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
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
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] mailbox: remove runtime GCE clk control
Thread-Topic: [PATCH v2] mailbox: remove runtime GCE clk control
Thread-Index: AQHZ9qBuCYSBVpc1a0+03zvp2lR9C7A5WrSAgAMjeIA=
Date:   Fri, 6 Oct 2023 09:15:58 +0000
Message-ID: <672d86a9e9bb08c770a6884860e9d13a0aaf0eb7.camel@mediatek.com>
References: <20231004085430.19538-1-jason-jh.lin@mediatek.com>
         <baa122da-4ae3-9023-3529-3ad38204b989@collabora.com>
In-Reply-To: <baa122da-4ae3-9023-3529-3ad38204b989@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7608:EE_
x-ms-office365-filtering-correlation-id: f1d61c93-87a6-4ec5-7f5f-08dbc64cda14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEhn7uISMwz8tOxyZhZDR9fbDdh+fiGQ9MaiMQEuUpZxJAGVHYLRrJtuEAuVvNt8MwaT1+lu48qdDv8bLKZjIeqA1dQqu93nxBIRMGPDUS/wh5De5ffOcm7Xc6Fx0kXgy3mc/0mL2wfqWxpswGzcZm80lvW8+cteHAUKLfoclqeH0lfAAoVt0MgJi7/iPG3DQrFn98rjmNYtdfr5iNvWTAHASPF4pgUX1NNx+3M7MRR6RbrBuTzHxKnPvI/GlkUGOGxwY3drDRkoTS7tuxdsuJulaUPQBIdszQHrcdCKzJknC/cXQ+1ks07MVg4rXuJAOCRH/TZ7jhPCruJrchKJDhO5BlEI6ehNH8uSyMBxVzvlsuHTuc8ZT5WLjV3Jad5MmvFxdggsyoF8Jz4Wvbf4TBExRAc5qf5h5Lc1o4lwfKgogxwYDMwGtnDM7fmfoNvYqYGdRwpkZdj5MTXFFtXq7T/NuB6dpkDf81tplDjvGPP+RrNcH+YcBw4bMs26IKCvnlBv7l/EdvW1wSiD0eX8A5jpPFUQ35JE6ZZbrovo+TeIkjxV1hG9w0kot8irlBww4BQ/bzXs5FBueNBQsFDzcNjdUO3tE1tTSP/z+AKKqs+Vsij6H7rGLyblPQy4X1n0jNVR1CC1wIPphsBXCZ8l5xMMO8pg6yWo28pxgNt9euc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(15650500001)(110136005)(83380400001)(5660300002)(2906002)(6512007)(122000001)(6506007)(86362001)(478600001)(91956017)(66476007)(64756008)(36756003)(85182001)(38070700005)(38100700002)(26005)(71200400001)(76116006)(8676002)(8936002)(4326008)(66946007)(2616005)(316002)(54906003)(66446008)(6486002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJQdW05RWhpVXBuVVdrOU1SZ0xJR2FCc05rQXJ6TjM0aFB3YmZMWWQ2Q0hw?=
 =?utf-8?B?MzNTdmVXZ2MvdTJpWkIvamJlMWtKdkhDL1V3VkZLYXpYTHJkZ2VCT2VnZkE4?=
 =?utf-8?B?YjZ6enpiVTU5d2MvWElKV0xlNFRyZmUycGdlbTQrMHFNTTM0SDZkMHdydHZX?=
 =?utf-8?B?NnVlNDdXdlpwVjRGY3ZYemlnT2t3N2NrMUM3T2RwZU1iQWtwL1JXR05rQkFV?=
 =?utf-8?B?YWFDUXNDTGlTM0tibllKUG5ZK3R0QXJWL2hIZVo2RS9wWk14YzNWNm1rNTJs?=
 =?utf-8?B?aWxxSWx0TEhMNzBGRmNaQlh6TzhsZVYzeGs2N2ErNGw4R3ArZVI4dFZNSktj?=
 =?utf-8?B?ZGw1VzJxSmhUY1AyeFhNcENwNlNBaHNycHB4WnlMTFFwYnVzclpEU24wc0hw?=
 =?utf-8?B?Z0tWbkpPa3d3eTcySmYvaVVxZmtrbTM5b2tLZXpFbjA1SVNHZGN5QkZUMjFB?=
 =?utf-8?B?T0hlUU0rN1dtQjVLOVg4OTA0OGtyNVhSYlRnSU1CdUp0NjlNNE0vSG1aVzZl?=
 =?utf-8?B?MUxZbVZ5YkpMVnNhc0ZSNDNWYU51YVNQUTlCS1FmK1h4ZFN1am51Z2F4OUhw?=
 =?utf-8?B?b0hZUCtpTTc0ODhpTG43UU10VnR1MlY3T1dpVkdvUlB2WW1XcVN1UDhhSFZ2?=
 =?utf-8?B?UGFjUlZoVWxFQXQ4VnpDcjBpek9jTlNxWE1jZGlydk1iWUkvNUxnTnlXVXBp?=
 =?utf-8?B?SDNxVmdoTEFWTlB1R2F6TGg0cUg4cDRrUGRPZkVFbmxvRmwrNW9GV0hhMXpC?=
 =?utf-8?B?U1lXRUpHaE5EckxnRk9SaDM1M0xLUS9GZW1DL0lmbFoyczNveDlUdW9KUzRu?=
 =?utf-8?B?SUI5OWIwMCtUWlNmSzVWT0FrK0RsT3ZoMjZTTzd3a3hIRUc1OC9SZHB5NlAv?=
 =?utf-8?B?aEVmeHpydjk4SlRaajhockJjNTdzRlJ5YUFXYXNiOEk0VWJ1aS9lVDdBM04w?=
 =?utf-8?B?bGxBdnRaYVVyeHNISTM5RXhBUVJqQzN1UUxXejQxbW9FU0JTb2ZOczFvUmlt?=
 =?utf-8?B?RWpIZEdlWldrMnpCOWgvUkxPUC9tK01YRHcyWG9nMmdSNWZ6bkwvb3VxaW9i?=
 =?utf-8?B?Z0JWdHRyQi96M2NqdFBQOUhackRRbm1NV1lTZ1Bsb2VrajBqNU9aMzNJRVhB?=
 =?utf-8?B?RFpHNHY3M0I1YWZxQ3U0Y0pvdHVGcGVhQ2tLSHdLZVFjTkk4UjQ1dW14aTkv?=
 =?utf-8?B?RjluNm1BV3N0Vm5VWW1ESi9acy9zbmJPY2llRWNxNDBNNGpxK3B1U3Q4OGFu?=
 =?utf-8?B?SVM3RkpsaDR2bzJNdVBCeWRCLzBRRSsrdEp0VDNKa3Yrb3BjNjlFcFMxR2pB?=
 =?utf-8?B?Zm1QdUtFenVoUG1JWk1TTEI4SW5mT21GZW1rL3JyZXJaSFdDdHlYOFRhL2Z5?=
 =?utf-8?B?WWRYUnF6OUUvN0FEY0Jxc2FUVXV2ejhvSFJUOGlsRDF6cWU0UnhyRzd2N2ow?=
 =?utf-8?B?L1FIdlZkaTQrUE15aHhadUNjamhuWWE3enExOVI3eHVuRmtCWTZod0ljMnFB?=
 =?utf-8?B?cWpBR3laYzdESnBBMStJb2JsVFRPbE5mQVNoa245YUQySVVoc29CSVlOUk13?=
 =?utf-8?B?Ynp4OWpjTXpxS1pmOStET1oveWJyNXFBZ3pmWlZFRnJMa0VKazE0TXlEcjdX?=
 =?utf-8?B?OVNMZVVTNXd3RXdyRmJud3F0dTEvbFhMNk1xQTlUSHFtWndKSUxSaFV2SFJ2?=
 =?utf-8?B?eGxmanVzOGd2d1l4eUYyQ2F0R0d1NmJZTituSGpwZTUxNGFqZjcxR2x0UU5x?=
 =?utf-8?B?NDRWMzZLU04xTlJhTWRvb1d0TkRXNHVPYnhZbndLSms0NG9CZkFkTjlJTVFU?=
 =?utf-8?B?MUFyYWNITVBJNUNWT2NMQzg1UVM5blorejlhY1ZHZnYxZ2xGdDVIdk96cXpv?=
 =?utf-8?B?N0s2OGhuNTd3aS8vRk44ank3K1FKeGJlMVBoUlY5OXhoL1A1dmZDT3Bqekty?=
 =?utf-8?B?ZWdDUC93ZGpTMWw5UW9wQ2hoZ3kvMUgwY3duQ0FmdVhvNlROaTNJckQrU3VY?=
 =?utf-8?B?VW5LWEtWZDNpcUFPY0ZxT3lKRkYzeDJGNURPZXJwemk0OHVkcGQzN1lLRlBn?=
 =?utf-8?B?VWVDWnZGaGtLcEFralJRTXV5S2JBN0JaekJBbzhuQWhJWkFKSE55VWpkZWhH?=
 =?utf-8?B?TkFxWGpXVldJT3QrNG5CUnlkaXRZdVVHMnpic2w5WElQSjFFZkl1dmxVcXpk?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9EDDB549D362D4B91CA215953E62715@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d61c93-87a6-4ec5-7f5f-08dbc64cda14
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 09:15:58.1378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHFyJDVke8hGxYCKmk83CdS3zW7bNZdd4VXg8iLHL9UkNwvQHh36Ul4jg4RzjYKKOvQ0451Y7iSq5kr3ZFTOBHc/FIxsDvOHCEd+KxbF/uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7608
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.500400-8.000000
X-TMASE-MatchedRID: VfovoVrt/oanykMun0J1wmjZ8q/Oc1nAYefZ7F9kLgsNcckEPxfz2OLB
        DcjMHcx7UmsNbSHn8eDFfOOkDUINTDP6pt+J6m1mi82UiskMqcwsCc2iFTIxrU8vg1FXaj1o33p
        XY2CsQeKRM36eLwqvJ4oSesITgOkEcNPMFJIX+nP8gEfQ4Av4R3nUZqRb3abmDpCUEeEFm7Dmxl
        PBgd8EzuEAhwl+9kCrSCjmFdhaApRaoFFRAKWvJrMjW/sniEQKG/VQKT/ZNQR+YFLISofIH2owi
        x037W0D+SihPPY9VI+Rk6XtYogiatLvsKjhs0ldah1zjX08EkLEQdG7H66TyH4gKq42LRYkgIkG
        pKAuQ8Gu5Wip/qrR2C1QFjrU86kR/hsI5tNFCMl+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.500400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 101C4E9B66DDBD2475AD7504F7F795BF4CEEE1B1D7F7714D41D564445021E4E62000:8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBXZWQsIDIwMjMtMTAt
MDQgYXQgMTE6MjAgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJ
bCAwNC8xMC8yMyAxMDo1NCwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gMS4gR0NFIGlz
IGEgZnJlcXVlbnRseSB1c2VkIG1vZHVsZSwgc28gcnVudGltZSBjb250cm9sbGluZw0KPiA+IEdD
RSBjbG9jayB3b24ndCBzYXZlIHRvbyBtdWNoIHBvd2VyIGFuZCBpdHMgb3JpZ2luYWwgZGVzaWdu
DQo+ID4gZG9lc24ndCBleHBlY3QgaXQgdG8gYmUgZW5hYmxlZCBhbmQgZGlzYWJsZWQgdG9vIGZy
ZXF1ZW50bHkuDQo+ID4gDQo+ID4gMi4gUnVudGltZSBjb250cm9sbGluZyBHQ0UgY2xvY2sgd2ls
bCBjYXVzZSBkaXNwbGF5IEhXIHJlZ2lzdGVyDQo+ID4gY29uZmlndXJlZCBpbiB3b3JuZyBzdHJl
YW0gZG9uZSBldmVudCBpc3N1ZSBiZWxvdzoNCj4gPiAgICBHQ0Ugc2hvdWxkIGNvbmZpZyBIVyBp
biBldmVyeSB2YmxhbmtpbmcgZHVyYXRpb24uDQo+ID4gICAgVGhlIHN0cmVhbSBkb25lIGV2ZW50
IGlzIHRoZSBzdGFydCBzaWduYWwgb2YgdmJsYW5raW5nLg0KPiA+IA0KPiA+ICAgIElmIHN0cmVh
bSBkb25lIGV2ZW50IGlzIHNlbnQgYmV0d2VlbiBHQ0UgY2xrX2Rpc2FibGUNCj4gPiAgICBhbmQg
Y2xrX2VuYWJsZS4gQWZ0ZXIgR0NFIGNsa19lbmFibGUgdGhlIHN0cmVhbSBkb25lIGV2ZW50DQo+
ID4gICAgbWF5IG5vdCBhcHBlYXIgaW1tZWRpYXRlbHkgYW5kIGhhdmUgYWJvdXQgM3VzIGRlbGF5
Lg0KPiA+IA0KPiA+ICAgIE5vcm1hbCBjYXNlOg0KPiA+ICAgIGNsa19kaXNhYmxlIC0+IGdldCBF
dmVudEEgLT4gY2xrX2VuYWJsZSAtPiBjbGVhciBFdmVudEENCj4gPiAgICAtPiB3YWl0IEV2ZW50
QiAtPiBnZXQgRXZlbnRCIC0+IGNvbmZpZyBIVw0KPiA+IA0KPiA+ICAgIEFibm9ybWFsIGNhc2U6
DQo+ID4gICAgY2xrX2Rpc2FibGUgLT4gZ2V0IEV2ZW50QSAtPiBjbGtfZW5hYmxlIC0+IEV2ZW50
QSBkZWxheSBhcHBlYXINCj4gPiAgICAtPiBjbGVhciBFdmVudEEgZmFpbCAtPiB3YWl0IEV2ZW50
QiBidXQgZ2V0IEV2ZW50QSAtPiBjb25maWcgSFcNCj4gPiANCj4gPiBTbyBqdXN0IHJlbW92ZSB0
aGUgcnVudGltZSBHQ0UgY2xvY2sgY29udG9ybC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IA0KPiBJbnN0ZWFkIG9m
IGVudGlyZWx5IHJlbW92aW5nIHRoZSBsb2dpYyB0aGF0IGNvbnRyb2xzIHRoZSBjbG9ja3MgYW5k
DQo+IGFsd2F5cw0KPiByZWZ1c2UgdG8gc2F2ZSBwb3dlciwgd2hhdCBhYm91dCB1c2luZyBhdXRv
c3VzcGVuZD8NCj4gDQo+IElmIHRoZSB0d28gY2FzZXMgdGhhdCB5b3UncmUgZGVzY3JpYmluZyBh
cmUgaGFwcGVuaW5nIGFsd2F5cyBpbiBhDQo+IHJhbmdlIG9mDQo+IHRpbWUsIHdlIGNvdWxkICp5
ZXMqIHJlbW92ZSB0aGUgIm1hbnVhbCIgYnVsayBkaXNhYmxlL2VuYWJsZSBjYWxscywNCj4gYnV0
IHRoZW4NCj4gd2UgY291bGQgdXNlIHJ1bnRpbWVfc3VzcGVuZC9ydW50aW1lX3Jlc3VtZSBjYWxs
YmFja3MgZm9yIHRoYXQuDQo+IA0KPiBIaW50OiBwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9k
ZWxheShkZXYsIDEwMDApOw0KPiANCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpUaGVzZSAy
IGlzc3VlcyBhcmUgY2F1c2VkIGJ5IEdDRSBidWxrX2NsayBlbmFibGUvZGlzYWJsZSB0b28NCmZy
ZXF1ZW50bHkuDQoNCkFzIEkgbm93LCBwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgp
IGlzIGZvciBjb250cm9sbGluZyB0aGUNCnBvd2VyIGRvbWFpbi4gVGhlIHBvd2VyIGRvbWFpbiBv
ZiBHQ0UgaXMgaW5mcmFzeXMgd2hpY2ggY2FuIG9ubHkgYmUNCmVuYWJsZWQvZGlzYWJsZWQgYnkg
c3BtIGR1cmluZyB0aGUgd2hvbGUgc3lzdGVtIHJlc3VtZS9zdXNwZW5kLg0KU28gSSdtIG5vdCBz
dXJlIGFib3V0IGhvdyBjYW4gcG1fcnVudGltZV9zZXRfYXV0b3N1c3BlbmRfZGVsYXkoKSBzYXZl
IA0KcG93ZXIgZm9yIEdDRSBidWxrX2NsayBpbiB0aGlzIGNhc2UuDQoNCkNvdWxkIHlvdSBnaXZl
IG1vcmUgaGludCBmb3IgbWUgcGxlYXNlPw0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCg==
