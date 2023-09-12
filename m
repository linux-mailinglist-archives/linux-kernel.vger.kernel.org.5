Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9144379C336
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjILCnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjILCnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:43:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD814CAF2;
        Mon, 11 Sep 2023 19:08:11 -0700 (PDT)
X-UUID: 358eadfa511111ee8051498923ad61e6-20230912
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=lagTBjxFCVgj1AjAvF8FoSVU9RzlRfUFlQE/E3jxfLQ=;
        b=opzHbKi7GGmiDdTmCU6EGB9vmvVzzKVqi8cJxdZ2PasdpwZfk8sUoQjXblTgE+wvZ9484DJaZs6hHGaHH7uxx40kv69DEBaTMN8K7o8bNUIr79jbrd4IN+u8WlZ7VP/SEWw0NsTwaCPSJntRAnA447wWvSETB1JP7JPS/o0t9sc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:21112a6f-d646-4804-9b11-f7ebfc823486,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:9009d313-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 358eadfa511111ee8051498923ad61e6-20230912
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 92535259; Tue, 12 Sep 2023 10:08:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Sep 2023 10:08:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Sep 2023 10:08:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL2ltDCc6zy6pE6tzQLP1Rj2zpjFanmmYOACVVI9GK9FNffUh6Md/ex9jH7sqfUL9GcfFeGDUiGwvkV/jN4wFf7wyVgyQbQoF3ztNHpLa3Lr/KDUSoF8xBGO18KYA+Jvc/xPKsvTTPrrYeW8QAYXiTEig6FwD3V7dWkAJoXOLOPfv7waMNABGNRrxVHxcFmLq+NieUlXOMneLYKHCQr6wnb2vQCF4Jc6o/B3gB22YUHdvN9LPXP38Z1kOn6yB9HBdQZVZ3BlePjBtmb7Zu8u5pEf+W3FVWiZcA9iHmT4hH7JeuEuIbIkkIvG2vSnRnq0x2TzJiZfaHt02uP5xzWcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lagTBjxFCVgj1AjAvF8FoSVU9RzlRfUFlQE/E3jxfLQ=;
 b=IAXtBgoT9/Ab/wzhOAmD5HwIRemdQScGVhL/4+1nShmzZo2+RjC8y74mBS0pufIgoGTxuW7J+HRYmn7RlU7w2T/DgD0NJSxS/IJnzDQlq3JeRjDmR7FlyfuFrmT15WhOtaobkzeWl2jLIHES1vKjmEUXgIlzsksZWHxT3JP49GjlibjnIQpjQv52YNduwpD9pmdBiHQD0rSDu9RSVSmqcH2oWwyY5++ku2kzJ+6kzre0etolz2tFkz/F5moIH0FtRhRaKOXcEqX6z5IxcJ5MIWTFodEvrkykHFI5Gy48Ks/eqQuwsvV0qVT15LUtwqzezh3nBU7E6ZJpKCvAazjlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lagTBjxFCVgj1AjAvF8FoSVU9RzlRfUFlQE/E3jxfLQ=;
 b=dSMWI/h6Exmxr9KJ8nYPByLpUEx3batOId6VlDJSWAAPV3MamlOC4k86K1M934/G/yxs1rr+gls1A03GnPIRTsYfIh8tB8GrfouprbP8C6KSXPKf+e/3S8S7nmw7GBM1SPQyCx4NryIBVm81qtN16T4prTuqjGjc4YSuu/rs66s=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB8223.apcprd03.prod.outlook.com (2603:1096:405:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 02:08:01 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::9a3c:4c0b:e835:1004%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 02:08:00 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 08/14] media: medkatek: vcodec: support one plane capture
 buffer
Thread-Topic: [PATCH 08/14] media: medkatek: vcodec: support one plane capture
 buffer
Thread-Index: AQHZ5K/8sYpjXmsUWEiHVRIFVGeQMbAVxFyAgACuK4A=
Date:   Tue, 12 Sep 2023 02:08:00 +0000
Message-ID: <33daf18157fe1c0b5b2a023a9fb65128915091d1.camel@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-9-yunfei.dong@mediatek.com>
         <4ff89457cbcc0582d312c8af919dab7a16b1943b.camel@collabora.com>
In-Reply-To: <4ff89457cbcc0582d312c8af919dab7a16b1943b.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB8223:EE_
x-ms-office365-filtering-correlation-id: 36302e66-ee1b-4eec-5464-08dbb335172d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A00jaVC8lpUAhrJBig0XhJvfQewZaBgm++4fjGfUCC7+ujVBb0TDzIZ6UQC41RKyYlOaYBFa1RL8eQ8iF+Dn/Y9xqogJ/ZGYqD4W/wmo8RYiWIgo65beK+OgBxNAxTl9df5UbmaTGn3Zvqccz5BokrK0+4I/qDCinU+HnQUw9bzxCnTTI2FEX/DJ08wLMik3KLh4Vb6gzJBglOl6MfX1zxsmjPr8XTkX3ZfHYvOti+RwVHlrSI0hrxcMlK1wly7d2u65/6L89r9SYsW8qsIcBske76wH+cKmhlW0gbIiq+kQA71EZgLprEvhPrr+b4ZGWebtOfXATVL0+0j23PMH0LTHZ4263EYrNYck5E98SY40C2/iUvMjPCBIj8WIykQvb8JbrZBefGxWtIPFX3+Wjthfb7YxENI50+q4nT9LU/uRQk6x4ScqPyEjYAtAVEcrWUY9FRGdvOE3MH2E6gk6lP0VSrNu4c7ZNTKy1lVMobwZP2lcDjKaLkfdsSdugTkFxkq6+p5mI2FGXJXlnMWkfbqVFPL2gtsSZd+wTllOKvJvzI524WWB/MbffgAfb3dRr9uD/OI8Kh7gfSxf/zdLpMcZ/1VwfZXUJFHthiZWc7tkKQCqfMY5fjmV8jU1biamj0PYIMcxUaA6c3PsUvzc9aBhIu8ZkJFL/bU6L2CSSxBhmxfOYnmLRuhLbLhwpr7M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(6512007)(71200400001)(6486002)(6506007)(26005)(2616005)(41300700001)(76116006)(66946007)(91956017)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(5660300002)(8936002)(8676002)(4326008)(38070700005)(38100700002)(122000001)(478600001)(66574015)(83380400001)(85182001)(36756003)(2906002)(7416002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXlQTEQ1RG04ZERPRXdnSDk2U2czV0lJRFBCQXJUT2VyY3ltRFpPbjUwN0VU?=
 =?utf-8?B?N0ZTYS9hdGpsVHR4MUJ5ZWh2eXd1ZUJoL0dHMGhmQno3ZGczMiswd2VmZng4?=
 =?utf-8?B?Z1d2OE9NUlc4Z09zaWV6UERMWE90Wk5MWkt6VjZTTVJBakpucXhhbWNCb1ZE?=
 =?utf-8?B?N3J5Zmc3WGhLVmhEMWhmdS84aUFzWnZOVjRmb3M0MVlLT09idjlmSzRqVVBZ?=
 =?utf-8?B?WWVmcVB3TWRyQ3ROMHY5alVadEJ0UWFvdVVjeHh0dUQrUjdiek8za1J1RldX?=
 =?utf-8?B?T0g5Y001WWZ1TFRRWmhOMExDTWk0TUhIQzNkcms3RXdWck9YSitlMVJtTXMr?=
 =?utf-8?B?V1lIcXZ1WGdrZ2Q0WHgzMnlYVmdkVlVNaGM5a0RaSm5GL28zVTMrczZxLzRW?=
 =?utf-8?B?TjJuL0wvV0s4MGxLMHFwblpISkZjY0FxM2FDblFGeWVUNFF3WEtBL2hJVm9I?=
 =?utf-8?B?UnVQNnZVOWlla3pVSll4aWIrRW1JTjRUaHBwNERvemc3NFlMTnFGUXhibHJu?=
 =?utf-8?B?aWJNN1dDbEZjdURzRTlSRkZ6ZlVKZStKOGRYSlNuczMxOFJtZWpuK3NpbzU2?=
 =?utf-8?B?OTFOU2N5SGJuTmdkNkliNjhMUlU2bVVXZllKWFVocVQ1V3RVdVFKL3M1WFJu?=
 =?utf-8?B?WEVIWVQyWWZTWjB2TVRaYkVrbDVRRjRqbk1KMnpvZk1ZdEI3SnpSaTNDWnJE?=
 =?utf-8?B?ZllCWlZVSVRDMjNxWUNUWmdKUXdjaEt3TldNcmt5SHhhSzFqM1FYYkVlNUhw?=
 =?utf-8?B?TXVJT2ZqK0ZlUTI2UTcrVUhKY0NKd1FJSVRhckRPUFZTMjFQMWllT1ZiTm9Q?=
 =?utf-8?B?bmRzdzZQd04xV3JZaURZK2s3REFCWUtmeXM0UWI0YzBrV2hjbTkrWjdBbnRv?=
 =?utf-8?B?c0h2RFhhTnlSdzNNU0xuRDI5c2htakRyd2VWOXkwRnlkdW9UNDhGb1hpK3Av?=
 =?utf-8?B?Ymt4dHdNMm12SU5sejFseTYwMk9yYUNsS2pOa0M1aC9CbVE0YU1xK2E4R2Vt?=
 =?utf-8?B?Q3M1OTJmSCtQNmIrYnpIRm1uVmduSlVUM1hsRFhWaUZOYXNqVmF5TlRiV3hV?=
 =?utf-8?B?aXRKbWVYWCsybmQwc2JaZy9HRlIvVmdBK0tZemJDMmF5clpMcmtaaGJvQUR4?=
 =?utf-8?B?OVczNnlhZ1phUmQ1YVl6R00yVFdadVY2S0U4UmJ6VXRRanJLanovUnhBWEFh?=
 =?utf-8?B?NVF6eTN5NXp2R3lFcVBpMkZhVTBVYjM2ZVgrN3pjeDhJajJwRmcwUWlJOVhp?=
 =?utf-8?B?bHdkY1pRL0t3cGtRVml2Y2x3blV5anRMSHB1RGR5bXZMMTcrVUpieWFBNDEw?=
 =?utf-8?B?azdmcWx2WE1oOTUyQVJGT3BnTTU0b2lxeXA2NFpjZWI0U0w1eituMGdXN1F6?=
 =?utf-8?B?R1puZjV4d3dYV1lsL2hSMUFIdmgxekJlaDROektYTHhLNTVLZU9XVzgyVzd4?=
 =?utf-8?B?blFURHdvWjdFTXVEaWdPV0ZLVnRvVHFnOE1WV2NjWjFOdzRIRlNQb3A5VFZO?=
 =?utf-8?B?ckl4NFdmYnRua3N4WjdDV1ZHN2tSNWhVU2cwV1ZZekx0ZHVvUGJaMGwrK3Qx?=
 =?utf-8?B?VEViWjQ1M2RYV0NSRmZBb2ZWb0svNUNmenpLRm1aQlpVSUN1QmQyckpscDBh?=
 =?utf-8?B?VkhUa1BWTTMvbE9CajdNTjd4d2VlUEtaUVU0a2pXZkh4cEEycEdkOVZrZUZT?=
 =?utf-8?B?Zk9zTTdOR1NPMnVwODNGaUwreWR0M2NxZ3N2MzNJclNIOFBrZlZHMUgrSktp?=
 =?utf-8?B?c0h4RlF1dzhTT2pjN1RYRUsxYURJSjJSb1c2ZXpadTJOV2hWWU84clN0SlRo?=
 =?utf-8?B?VXlhWmhQWnVpYnV0WHRVQVJhTVgrdnI4L2JyYjA5cUorYzBoUkllTmFDOWQy?=
 =?utf-8?B?V2s0RGFrN2FPSHhFOTdhdlJSVUdmdDBvYVFKZlRpR2Q0Y3FjU2cxcjhiYUI3?=
 =?utf-8?B?ei94SXRYdytjcTFSSGNFeExFSGttNTMxOTRsZHZBdjYxV21TbEsxNTN2bno2?=
 =?utf-8?B?TjFzQkdxeWV3S3NoZ3JaVkhTbFNDWFVLQy9CKy95b3RCSWFUaUQ0ZTdzMTJm?=
 =?utf-8?B?R2gvcWFSQ25MbGFRSXJaVDNMK2xyOEMwZEZ5WHlXeWd5UEN3L3RWWHdXZ0pn?=
 =?utf-8?B?c1pBSGRIb2FzaDQ3TXlOa2tRMkFWRWJCKytORE5ybHRCOU1rQVUzUm5jektk?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACA4F45A83E0E1408E888C17518CA43D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36302e66-ee1b-4eec-5464-08dbb335172d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 02:08:00.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hihfcGprZaNjF6D0/4SyImNRTWLR17+CqW6pS14l8fcxDYGCd3k3+9xiy6ARX33WHHYJAs6IrynMPACDF/QDc+R2rA6C5xzjb81HRWqpZ+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8223
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.274000-8.000000
X-TMASE-MatchedRID: UuaOI1zLN1inykMun0J1wpmug812qIbz+WzVGPiSY8gNcckEPxfz2D6h
        VXnKDh9XIKnWpFLTpyHrtOvKPS5k+ibAJYoIaNibDB+ErBr0bAO4vBuE2X0Hlbuqk4cq52pzcbc
        gOSSPsBfojo8IP4jjXPQ6JrmXjZ0mj0dStCqojpep4G6k2AuBh7BH/AqZyGLZ31GU/N5W5BAiiF
        Ii+xQv75qYTZh4tCqI/rGoL83UKLNUaz8ayo4K5lVN8laWo90MjiWciALpTNPzYcyIF7RSVcS4G
        +2ecnOxLm/CqU0z0fEjH48SZpETM/xrs+NFHdykbajVAc2DKqYUkWvaqUqLH3aMP8m6qk6SIubj
        9bOa7Mtx7XPgNTGHonATsg8MODVIQv21zJNl0CyDGx/OQ1GV8t0H8LFZNFG7gFAtZqE+Xpx+3Bn
        dfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.274000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CF5E9245DF43DB91EC2DFA24C6B199F77BED7CDADD4B1BB7C41AAF7CFDEF4C542000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCk9uIE1vbiwgMjAyMy0wOS0x
MSBhdCAxMTo0NCAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gSGksDQo+IA0KPiBM
ZSBsdW5kaSAxMSBzZXB0ZW1icmUgMjAyMyDDoCAyMDo1OSArMDgwMCwgWXVuZmVpIERvbmcgYSDD
qWNyaXQgOg0KPiA+IFRoZSBjYXB0dXJlIGJ1ZmZlciBoYXMgdHdvIHBsYW5lcyBmb3IgZm9ybWF0
IE1NMjEsIGJ1dCB1c2VyIHNwYWNlDQo+ID4gb25seQ0KPiA+IGFsbG9jYXRlIHNlY3VyZSBtZW1v
cnkgZm9yIHBsYW5lWzBdLCBhbmQgdGhlIHNpemUgaXMgWSBkYXRhICsgdXYNCj4gPiBkYXRhLg0K
PiA+IFRoZSBkcml2ZXIgbmVlZCB0byBzdXBwb3J0IG9uZSBwbGFuZSBkZWNvZGVyIGZvciBzdnAg
bW9kZS4NCj4gDQo+IEknbSBzb3JyeSwgYnV0IGluIGN1cnJlbnQgVjRMMiBzdGF0dXMsIHlvdSBt
dXN0IGludHJvZHVjZSBhIG5ldw0KPiBmb3JtYXQuIEFzc3VtaW5nDQo+IHRoZSBzZWNvbmQgTSBt
ZWFucyBNUExBTkUsIHRoaXMgZm9ybWF0IHdvdWxkIGJlIE1UMjEgKHRob3VnaCB5b3UNCj4gYWxy
ZWFkeSB1c2VkDQo+IHRoYXQgZm91cmNjIGZvciBNVDIxQykgPw0KPiANCg0KSnVzdCB1c2luZyB0
aGUgZmlyc3QgcGxhbmUgZm9yIGZvcm1hdCBNTTIxIGluIG9yZGVyIHRvIHN1cHBvcnQgc3ZwIG1v
ZGUNCmFjY29yZGluZyBnb29nbGUncyBzdWdnZXN0aW9uLiBUaGUgcGxhbmVbMV0gd29uJ3QgYmUg
dXNlZCB0byBhbGxvY2F0ZQ0KbWVtb3J5LiBXaGV0aGVyIGl0J3MgYmV0dGVyIHRvIGFkZCBvbmUg
Zm9ybWF0IHRvIHN1cHBvcnQgb25lIHBsYW5lPyBOb3QNCnVzaW5nIE1NMjEuDQoNCkJlc3QgUmVn
YXJkcywNCll1bmZlaSBEb25nDQo+IE5pY29sYXMNCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjLmMgIHwgMjQgKysrKysr
KysrKysrLS0tDQo+ID4gLS0tLQ0KPiA+ICAuLi4vdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19k
ZWNfc3RhdGVsZXNzLmMgfCAxMyArKysrKystLS0tDQo+ID4gIC4uLi9kZWNvZGVyL3ZkZWMvdmRl
Y19oMjY0X3JlcV9jb21tb24uYyAgICAgICB8IDE2ICsrKysrKystLS0tLS0NCj4gPiAgLi4uL21l
ZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWNfZHJ2X2lmLmMgICAgIHwgIDQgKystLQ0KPiA+ICA0
IGZpbGVzIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNv
ZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWMuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9y
bS9tZWRpYXRlay92Y29kZWMvZGVjb2Rlci9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gaW5kZXggOTFl
ZDU3NmQ2ODIxLi40NTdjM2UyOTc5YzkgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9kcml2ZXJzL21l
ZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL210a192Y29kZWNfZGVjLmMNCj4g
PiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29k
ZXIvbXRrX3Zjb2RlY19kZWMuYw0KPiA+IEBAIC01NDEsMTQgKzU0MSwxNSBAQCBzdGF0aWMgaW50
IHZpZGlvY192ZGVjX3NfZm10KHN0cnVjdCBmaWxlDQo+ID4gKmZpbGUsIHZvaWQgKnByaXYsDQo+
ID4gIAkJCWN0eC0+cV9kYXRhW01US19RX0RBVEFfRFNUXS5ieXRlc3BlcmxpbmVbMF0gPQ0KPiA+
ICAJCQkJY3R4LT5waWNpbmZvLmJ1Zl93Ow0KPiA+ICAJCX0gZWxzZSB7DQo+ID4gLQkJCWN0eC0+
cV9kYXRhW01US19RX0RBVEFfRFNUXS5zaXplaW1hZ2VbMF0gPQ0KPiA+IC0JCQkJY3R4LT5waWNp
bmZvLmZiX3N6WzBdOw0KPiA+IC0JCQljdHgtPnFfZGF0YVtNVEtfUV9EQVRBX0RTVF0uYnl0ZXNw
ZXJsaW5lWzBdID0NCj4gPiAtCQkJCWN0eC0+cGljaW5mby5idWZfdzsNCj4gPiAtCQkJY3R4LT5x
X2RhdGFbTVRLX1FfREFUQV9EU1RdLnNpemVpbWFnZVsxXSA9DQo+ID4gLQkJCQljdHgtPnBpY2lu
Zm8uZmJfc3pbMV07DQo+ID4gLQkJCWN0eC0+cV9kYXRhW01US19RX0RBVEFfRFNUXS5ieXRlc3Bl
cmxpbmVbMV0gPQ0KPiA+IC0JCQkJY3R4LT5waWNpbmZvLmJ1Zl93Ow0KPiA+ICsJCQlpZiAoY3R4
LT5pc19zdnBfbW9kZSkNCj4gPiArCQkJCWN0eC0NCj4gPiA+cV9kYXRhW01US19RX0RBVEFfRFNU
XS5zaXplaW1hZ2VbMF0gPQ0KPiA+ICsJCQkJCWN0eC0+cGljaW5mby5mYl9zelswXSArIGN0eC0N
Cj4gPiA+cGljaW5mby5mYl9zelsxXTsNCj4gPiArCQkJZWxzZQ0KPiA+ICsJCQkJY3R4LQ0KPiA+
ID5xX2RhdGFbTVRLX1FfREFUQV9EU1RdLnNpemVpbWFnZVswXSA9IGN0eC0+cGljaW5mby5mYl9z
elswXTsNCj4gPiArDQo+ID4gKwkJCWN0eC0+cV9kYXRhW01US19RX0RBVEFfRFNUXS5ieXRlc3Bl
cmxpbmVbMF0gPQ0KPiA+IGN0eC0+cGljaW5mby5idWZfdzsNCj4gPiArCQkJY3R4LT5xX2RhdGFb
TVRLX1FfREFUQV9EU1RdLnNpemVpbWFnZVsxXSA9IGN0eC0NCj4gPiA+cGljaW5mby5mYl9zelsx
XTsNCj4gPiArCQkJY3R4LT5xX2RhdGFbTVRLX1FfREFUQV9EU1RdLmJ5dGVzcGVybGluZVsxXSA9
DQo+ID4gY3R4LT5waWNpbmZvLmJ1Zl93Ow0KPiA+ICAJCX0NCj4gPiAgDQo+ID4gIAkJY3R4LT5x
X2RhdGFbTVRLX1FfREFUQV9EU1RdLmNvZGVkX3dpZHRoID0gY3R4LQ0KPiA+ID5waWNpbmZvLmJ1
Zl93Ow0KPiA+IEBAIC02NzMsNyArNjc0LDEyIEBAIHN0YXRpYyBpbnQgdmlkaW9jX3ZkZWNfZ19m
bXQoc3RydWN0IGZpbGUNCj4gPiAqZmlsZSwgdm9pZCAqcHJpdiwNCj4gPiAgCQkgKiBTbyB3ZSBq
dXN0IHJldHVybiBwaWNpbmZvIHlldCwgYW5kIHVwZGF0ZSBwaWNpbmZvIGluDQo+ID4gIAkJICog
c3RvcF9zdHJlYW1pbmcgaG9vayBmdW5jdGlvbg0KPiA+ICAJCSAqLw0KPiA+IC0JCXFfZGF0YS0+
c2l6ZWltYWdlWzBdID0gY3R4LT5waWNpbmZvLmZiX3N6WzBdOw0KPiA+ICsNCj4gPiArCQlpZiAo
Y3R4LT5pc19zdnBfbW9kZSkNCj4gPiArCQkJcV9kYXRhLT5zaXplaW1hZ2VbMF0gPSBjdHgtPnBp
Y2luZm8uZmJfc3pbMF0gKw0KPiA+IGN0eC0+cGljaW5mby5mYl9zelsxXTsNCj4gPiArCQllbHNl
DQo+ID4gKwkJCXFfZGF0YS0+c2l6ZWltYWdlWzBdID0gY3R4LT5waWNpbmZvLmZiX3N6WzBdOw0K
PiA+ICsNCj4gPiAgCQlxX2RhdGEtPnNpemVpbWFnZVsxXSA9IGN0eC0+cGljaW5mby5mYl9zelsx
XTsNCj4gPiAgCQlxX2RhdGEtPmJ5dGVzcGVybGluZVswXSA9IGN0eC0NCj4gPiA+bGFzdF9kZWNv
ZGVkX3BpY2luZm8uYnVmX3c7DQo+ID4gIAkJcV9kYXRhLT5ieXRlc3BlcmxpbmVbMV0gPSBjdHgt
DQo+ID4gPmxhc3RfZGVjb2RlZF9waWNpbmZvLmJ1Zl93Ow0KPiA+IGRpZmYgLS1naXQNCj4gPiBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2Rl
Y19kZWNfc3RhDQo+ID4gdGVsZXNzLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVk
aWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfc3RhDQo+ID4gdGVsZXNzLmMNCj4g
PiBpbmRleCBlMjljOWM1OGYzZGEuLjJlYTUxNzg4M2E4NiAxMDA2NDQNCj4gPiAtLS0NCj4gPiBh
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2Rl
Y19kZWNfc3RhDQo+ID4gdGVsZXNzLmMNCj4gPiArKysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvbXRrX3Zjb2RlY19kZWNfc3RhDQo+ID4gdGVs
ZXNzLmMNCj4gPiBAQCAtMjU2LDExICsyNTYsMTIgQEAgc3RhdGljIHN0cnVjdCB2ZGVjX2ZiDQo+
ID4gKnZkZWNfZ2V0X2NhcF9idWZmZXIoc3RydWN0IG10a192Y29kZWNfZGVjX2N0eCAqY3R4KQ0K
PiA+ICAJZnJhbWVidWYgPSBjb250YWluZXJfb2YodmIyX3Y0bDIsIHN0cnVjdCBtdGtfdmlkZW9f
ZGVjX2J1ZiwNCj4gPiBtMm1fYnVmLnZiKTsNCj4gPiAgDQo+ID4gIAlwZmIgPSAmZnJhbWVidWYt
PmZyYW1lX2J1ZmZlcjsNCj4gPiAtCXBmYi0+YmFzZV95LnZhID0gdmIyX3BsYW5lX3ZhZGRyKGRz
dF9idWYsIDApOw0KPiA+ICsJaWYgKCFjdHgtPmlzX3N2cF9tb2RlKQ0KPiA+ICsJCXBmYi0+YmFz
ZV95LnZhID0gdmIyX3BsYW5lX3ZhZGRyKGRzdF9idWYsIDApOw0KPiA+ICAJcGZiLT5iYXNlX3ku
ZG1hX2FkZHIgPSB2YjJfZG1hX2NvbnRpZ19wbGFuZV9kbWFfYWRkcihkc3RfYnVmLA0KPiA+IDAp
Ow0KPiA+ICAJcGZiLT5iYXNlX3kuc2l6ZSA9IGN0eC0+cV9kYXRhW01US19RX0RBVEFfRFNUXS5z
aXplaW1hZ2VbMF07DQo+ID4gIA0KPiA+IC0JaWYgKGN0eC0+cV9kYXRhW01US19RX0RBVEFfRFNU
XS5mbXQtPm51bV9wbGFuZXMgPT0gMikgew0KPiA+ICsJaWYgKGN0eC0+cV9kYXRhW01US19RX0RB
VEFfRFNUXS5mbXQtPm51bV9wbGFuZXMgPT0gMiAmJiAhY3R4LQ0KPiA+ID5pc19zdnBfbW9kZSkg
ew0KPiA+ICAJCXBmYi0+YmFzZV9jLnZhID0gdmIyX3BsYW5lX3ZhZGRyKGRzdF9idWYsIDEpOw0K
PiA+ICAJCXBmYi0+YmFzZV9jLmRtYV9hZGRyID0NCj4gPiAgCQkJdmIyX2RtYV9jb250aWdfcGxh
bmVfZG1hX2FkZHIoZHN0X2J1ZiwgMSk7DQo+ID4gQEAgLTMxMCwxNiArMzExLDE4IEBAIHN0YXRp
YyB2b2lkIG10a192ZGVjX3dvcmtlcihzdHJ1Y3QNCj4gPiB3b3JrX3N0cnVjdCAqd29yaykNCj4g
PiAgCW10a192NGwyX3ZkZWNfZGJnKDMsIGN0eCwgIlslZF0gKCVkKSBpZD0lZCwgdmI9JXAiLCBj
dHgtPmlkLA0KPiA+ICAJCQkgIHZiMl9zcmMtPnZiMl9xdWV1ZS0+dHlwZSwgdmIyX3NyYy0+aW5k
ZXgsDQo+ID4gdmIyX3NyYyk7DQo+ID4gIA0KPiA+IC0JYnNfc3JjLT52YSA9IHZiMl9wbGFuZV92
YWRkcih2YjJfc3JjLCAwKTsNCj4gPiAtCWJzX3NyYy0+ZG1hX2FkZHIgPSB2YjJfZG1hX2NvbnRp
Z19wbGFuZV9kbWFfYWRkcih2YjJfc3JjLCAwKTsNCj4gPiAtCWJzX3NyYy0+c2l6ZSA9IChzaXpl
X3QpdmIyX3NyYy0+cGxhbmVzWzBdLmJ5dGVzdXNlZDsNCj4gPiArCWlmICghY3R4LT5pc19zdnBf
bW9kZSkgew0KPiA+ICsJCWJzX3NyYy0+dmEgPSB2YjJfcGxhbmVfdmFkZHIodmIyX3NyYywgMCk7
DQo+ID4gIAlpZiAoIWJzX3NyYy0+dmEpIHsNCj4gPiAgCQl2NGwyX20ybV9qb2JfZmluaXNoKGRl
di0+bTJtX2Rldl9kZWMsIGN0eC0+bTJtX2N0eCk7DQo+ID4gIAkJbXRrX3Y0bDJfdmRlY19lcnIo
Y3R4LCAiWyVkXSBpZD0lZCBzb3VyY2UgYnVmZmVyIGlzDQo+ID4gTlVMTCIsIGN0eC0+aWQsDQo+
ID4gIAkJCQkgIHZiMl9zcmMtPmluZGV4KTsNCj4gPiAgCQlyZXR1cm47DQo+ID4gKwkJfQ0KPiA+
ICAJfQ0KPiA+ICANCj4gPiArCWJzX3NyYy0+ZG1hX2FkZHIgPSB2YjJfZG1hX2NvbnRpZ19wbGFu
ZV9kbWFfYWRkcih2YjJfc3JjLCAwKTsNCj4gPiArCWJzX3NyYy0+c2l6ZSA9IChzaXplX3QpdmIy
X3NyYy0+cGxhbmVzWzBdLmJ5dGVzdXNlZDsNCj4gPiAgCW10a192NGwyX3ZkZWNfZGJnKDMsIGN0
eCwgIlslZF0gQml0c3RyZWFtIFZBPSVwIERNQT0lcGFkDQo+ID4gU2l6ZT0lenggdmI9JXAiLA0K
PiA+ICAJCQkgIGN0eC0+aWQsIGJzX3NyYy0+dmEsICZic19zcmMtPmRtYV9hZGRyLA0KPiA+IGJz
X3NyYy0+c2l6ZSwgdmIyX3NyYyk7DQo+ID4gIAkvKiBBcHBseSByZXF1ZXN0IGNvbnRyb2xzLiAq
Lw0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsv
dmNvZGVjL2RlY29kZXIvdmRlYy92ZGVjX2gyNjRfcmVxDQo+ID4gX2NvbW1vbi5jDQo+ID4gYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY19o
MjY0X3JlcQ0KPiA+IF9jb21tb24uYw0KPiA+IGluZGV4IDVjYTIwZDc1ZGM4ZS4uODM4ZjBlZWVh
NmUyIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfaDI2NF9yZXENCj4gPiBfY29tbW9uLmMNCj4gPiAr
KysNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIv
dmRlYy92ZGVjX2gyNjRfcmVxDQo+ID4gX2NvbW1vbi5jDQo+ID4gQEAgLTgxLDEzICs4MSwxNSBA
QCB2b2lkIG10a192ZGVjX2gyNjRfZmlsbF9kcGJfaW5mbyhzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVj
X2RlY19jdHggKmN0eCwNCj4gPiAgDQo+ID4gIAkJaDI2NF9kcGJfaW5mb1tpbmRleF0ueV9kbWFf
YWRkciA9DQo+ID4gIAkJCXZiMl9kbWFfY29udGlnX3BsYW5lX2RtYV9hZGRyKHZiLCAwKTsNCj4g
PiAtCQlpZiAoY3R4LT5xX2RhdGFbTVRLX1FfREFUQV9EU1RdLmZtdC0+bnVtX3BsYW5lcyA9PSAy
KQ0KPiA+IC0JCQloMjY0X2RwYl9pbmZvW2luZGV4XS5jX2RtYV9hZGRyID0NCj4gPiAtCQkJCXZi
Ml9kbWFfY29udGlnX3BsYW5lX2RtYV9hZGRyKHZiLCAxKTsNCj4gPiAtCQllbHNlDQo+ID4gLQkJ
CWgyNjRfZHBiX2luZm9baW5kZXhdLmNfZG1hX2FkZHIgPQ0KPiA+IC0JCQkJaDI2NF9kcGJfaW5m
b1tpbmRleF0ueV9kbWFfYWRkciArDQo+ID4gLQkJCQljdHgtPnBpY2luZm8uZmJfc3pbMF07DQo+
ID4gKwkJaWYgKCFjdHgtPmlzX3N2cF9tb2RlKSB7DQo+ID4gKwkJCWlmIChjdHgtPnFfZGF0YVtN
VEtfUV9EQVRBX0RTVF0uZm10LT5udW1fcGxhbmVzIA0KPiA+ID09IDIpDQo+ID4gKwkJCQloMjY0
X2RwYl9pbmZvW2luZGV4XS5jX2RtYV9hZGRyID0NCj4gPiArCQkJCQl2YjJfZG1hX2NvbnRpZ19w
bGFuZV9kbWFfYWRkcih2DQo+ID4gYiwgMSk7DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJCWgyNjRf
ZHBiX2luZm9baW5kZXhdLmNfZG1hX2FkZHIgPQ0KPiA+ICsJCQkJCWgyNjRfZHBiX2luZm9baW5k
ZXhdLnlfZG1hX2FkZHINCj4gPiArDQo+ID4gKwkJCQkJY3R4LT5waWNpbmZvLmZiX3N6WzBdOw0K
PiA+ICsJCX0NCj4gPiAgCX0NCj4gPiAgfQ0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWNfZHJ2X2lm
LmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIv
dmRlY19kcnZfaWYuYw0KPiA+IGluZGV4IGQwYjQ1OWIxNjAzZi4uYzdkMzNlNTQwYTEzIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29k
ZXIvdmRlY19kcnZfaWYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL2RlY29kZXIvdmRlY19kcnZfaWYuYw0KPiA+IEBAIC03MywxNCArNzMsMTQgQEAg
aW50IHZkZWNfaWZfZGVjb2RlKHN0cnVjdCBtdGtfdmNvZGVjX2RlY19jdHgNCj4gPiAqY3R4LCBz
dHJ1Y3QgbXRrX3Zjb2RlY19tZW0gKmJzLA0KPiA+ICB7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4g
PiAgDQo+ID4gLQlpZiAoYnMpIHsNCj4gPiArCWlmIChicyAmJiAhY3R4LT5pc19zdnBfbW9kZSkg
ew0KPiA+ICAJCWlmICgoYnMtPmRtYV9hZGRyICYgNjMpICE9IDApIHsNCj4gPiAgCQkJbXRrX3Y0
bDJfdmRlY19lcnIoY3R4LCAiYnMgZG1hX2FkZHIgc2hvdWxkIDY0DQo+ID4gYnl0ZSBhbGlnbiIp
Ow0KPiA+ICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+
IC0JaWYgKGZiKSB7DQo+ID4gKwlpZiAoZmIgJiYgIWN0eC0+aXNfc3ZwX21vZGUpIHsNCj4gPiAg
CQlpZiAoKChmYi0+YmFzZV95LmRtYV9hZGRyICYgNTExKSAhPSAwKSB8fA0KPiA+ICAJCSAgICAo
KGZiLT5iYXNlX2MuZG1hX2FkZHIgJiA1MTEpICE9IDApKSB7DQo+ID4gIAkJCW10a192NGwyX3Zk
ZWNfZXJyKGN0eCwgImZyYW1lIGJ1ZmZlciBkbWFfYWRkcg0KPiA+IHNob3VsZCA1MTIgYnl0ZSBh
bGlnbiIpOw0KPiANCj4gDQo=
