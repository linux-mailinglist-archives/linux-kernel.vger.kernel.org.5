Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984F7A4227
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjIRHT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbjIRHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:18:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D8CC7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:18:27 -0700 (PDT)
X-UUID: 8b7a04bc55f311ee8051498923ad61e6-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bCmcfy/I5osFqzR7Tth1Sio5iUNG3/+q82Kd7eqmrFw=;
        b=oihlTynZNBIxlmfsF+ceEP/14zJNpoAZkhC/FbiQYrHAOzWuxSjueJ4vKYlbpacxj4hM4rcrt2h2sHHvvUSuY1J1e2pkpXB9K+1mx/NcG3dr4TZp+yRZbZvs2TWPT0iw9Z5EP9rjnxkKZlfL+1yzhkNqhHqJIGv3QgyQiuslHto=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a2cd0c3f-9d0c-4e2d-a4a7-3b8065168bce,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:47c80f14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b7a04bc55f311ee8051498923ad61e6-20230918
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 584394288; Mon, 18 Sep 2023 15:18:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 15:18:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 15:18:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIpsxdAVSNwLO9jgAoPyIU9wn1ckmzOtTd4WZLKYZy0GuXwEBtmzh5+akbDK/oVnYffqm6r3yaI4Ygd2gt+LHBhpwTIZUW2HjpaEqfCmAXv+kVh8AF/KafUjTcog2X1T35SNkG0GSyuQjMn0eYSAYHpBdvMnd0poqWlSMjEY/Ox2ehr38k2rekrdYcba8sy8ZpEPirRWLhrtgMsqQr0huXUxabZKA2ue5JhKqTQuPbrVE2jg/ksUd5jKoCH+WcwVdUEIEYWRj9Ow2mVpHYxU2mEvjVMPGmoFbtBvLduhb9RpiyTeSpopw26n4xSOilc7ba41rpTxapKYoxdet0BPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCmcfy/I5osFqzR7Tth1Sio5iUNG3/+q82Kd7eqmrFw=;
 b=XkVsqUl58Bv0MYjgcnJ2PANpo11yMHlK35j8tr1uJj5VzIO9WCW2JxxyVfTUKcrGO95IlJsz1x1lPGsTYZyDBhz4DGRLb6IR40dIe/Pkc3lNAYwvvJINzCODmMxpUmEFaN4UorDwlqFLqELsEMhS0Z0GFzjeRnZubHtDjwsWpKHgqV4gDw+h2mts4pJnR7aQ2tEoOB8bWnVb5DAOArA6GmJpPMf6PRZ8+ocmCLVWa7dvz+EMWxC5cW11M7JeAFeA2QjEBItV6G5ZHDydYXs1K1FRyNf99GUeHiTIMwKmLB9oYptCuYtqLGrNjHQlnG3agw/fK6cZq3pxZz7vu+R5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCmcfy/I5osFqzR7Tth1Sio5iUNG3/+q82Kd7eqmrFw=;
 b=caHDjMCaq9va8vR3KpbS1PrwYZJUst5C4XTpyAZNjEHIa7vRG7WrnLxhjeZKFuetyRj4v6/S2aShTXnU+mR6DS3IAvmaTeI4GnXqha0TSUrzcmBAP7op4TuHvSy3tmQhIftAyIbvKa1Px2ZQccf53gvW/az3dy4wOZlEKqrOXcQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB7283.apcprd03.prod.outlook.com (2603:1096:400:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 07:18:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 07:18:16 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "eugen.hristev@collabora.com" <eugen.hristev@collabora.com>
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
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v9 4/7] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs for dpi
Thread-Topic: [PATCH v9 4/7] drm/mediatek: Add encoder_index function to
 mtk_ddp_comp_funcs for dpi
Thread-Index: AQHZyu2auCZt44i0Ykac31My4bReDrAgargA
Date:   Mon, 18 Sep 2023 07:18:15 +0000
Message-ID: <96832cdaa57a97768fdb16d08f39afa75120aec8.camel@mediatek.com>
References: <20230809181525.7561-1-jason-jh.lin@mediatek.com>
         <20230809181525.7561-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20230809181525.7561-5-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB7283:EE_
x-ms-office365-filtering-correlation-id: 640d918e-c88d-4e7d-e79d-08dbb8176d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWPqCQWQY50z1RQTgG4qHZJ0IrXG5GCUnZ9s+JeNTAVsFYA4Dc+3IwEXX5JfnbOO5vq8nSa5820w/QRoqSCvizZr9d+CMcsnClDRZ3eUeAjW0aALHaMkSFvSCrLTtk0shFUqPPG6hi3DASKKTGxzsZcB39VYyoIwme8IDzewhDnCNEExvDZThEYEeVjGo46pm5eGIIs2+WiQOoimgTfWJK2OpAoc5CDM8jaa7nUAP/b+xh8AUw29mu+aJvhaQrWC/9VJZYI7GMBFsbnnEkuChG2c4GZvfpz+OUy0PSeg9K3K8tn5XQbY13ztDj1QataIpRFgypAc/a6ohHqSoVbcYOMdjPbBaAY3TfpHoaLvx5sw50XHiRtuQ3p0DaMj07U54BPoEimHCdOBVFh/AmFARib+K7FT3lh1Do2xQxji/NOt7JulB+iQ25ChZUHbR2MYGNWkAVJ7kwfu8prHfc1knM5CuV4D5YYJTpBmkuS2KX9o8MjSoV1qCm48gOJjU7NvB8kzpUg+7odad/xgYGesUMstnJdwjAT0ktcpOQ7CJz16kxrH9y7xkinEV4lU1DymumujhxNSv4OvN3nmEpIZDou/hfv2r7x1wjIXIssdIf1RF5I526j6Hzc9LRIwbt4z+n0PCvWq8NI2wN17ecjKlOOne1XGRlvndOBblHP7JP0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199024)(186009)(1800799009)(85182001)(66446008)(2906002)(38070700005)(86362001)(26005)(38100700002)(122000001)(4326008)(8676002)(8936002)(2616005)(76116006)(71200400001)(41300700001)(5660300002)(54906003)(64756008)(316002)(36756003)(66946007)(66556008)(66476007)(110136005)(6512007)(6506007)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmIzRHF0dXJEYWpmWVRsbCtZRURNOFdWaUZtNE8rN2Ztc25hZGVKVmhBR0FK?=
 =?utf-8?B?d25OMHN1YTR3bWNJL0VNTGV3bS9GaTRTS3VOS2wxT3F1aElpWkFuNFluWEJG?=
 =?utf-8?B?ZmNVRDNCVnBTVE5RSjNLckYzVDFwZm9yNURnbFM4OW0vaHRBQUVHUWZ5UEg4?=
 =?utf-8?B?WW9pbi8ycEdDdlRHNDdqYUErNiszMFhtdTFkNXYzL1hoNjl1WjFlMlhzcHBr?=
 =?utf-8?B?M2c1elJKK3NzV1lrTHlJMTRRT3BwazNkejNWQUtvbDRGM00yZEFEM0VZYVJB?=
 =?utf-8?B?bGJveERXOUNES0RYRk0wQm4yeHlrUGkzaTV1SmJ5RFNjdmVlRjNzNm9Yc1JV?=
 =?utf-8?B?czRhcHZadGtVU1Vzc0t5aVVjVzdQU3VyNVg2a1picGdOdFNrZEVERUpaY2Nh?=
 =?utf-8?B?RG1zT0tZYVdEL0IvUlFTS0F5T0Q2cGxnNTZWMmcxc2xuU21NVlV4YnpodEdG?=
 =?utf-8?B?UjdYVEVocjJpQ1d5NHFhRXdabjVLK1lJSVVqc2hETnJnTFhSRTRjV3RjTDVY?=
 =?utf-8?B?UWJyb05RVkF2dUQydzhmcy9ZNW9MOG91dzBqWU0zUG4wY283eTN4dzdkRnhu?=
 =?utf-8?B?ZkI4TGM2cG51M2JDK2ZsODlaeGxUd0lZT0lHY0lhN2tXcHpCT2RxcXk4bEJG?=
 =?utf-8?B?aXpMYWR6amJBaHZmSUhYdVF6SUVXZWJyWHhkRmN4akZhcnhYQW9XNm1EUTY0?=
 =?utf-8?B?anErV3ZwcUtsenJqNVY1WWdYSzBybTBSTnQxNGxVQVN1bTE1cmRTWlFFMHBx?=
 =?utf-8?B?WnRGYldNdnhuZEwxcDRDWWl5aGpvUTRPTjJXYmRLWjNjOTAxVGRNc0djZHRi?=
 =?utf-8?B?aFJQMVNjVTFZUlhLTVhVeWdpS0s1U25wVXJEckdEUC9IUnVhUTJ3SzFkbStr?=
 =?utf-8?B?NTZSM0NtODlrZHFFTUk0MkJzZ01SMk9ucWkyaWxNamdYbmp5ZmZKTHk0MTdr?=
 =?utf-8?B?WEk1MS9rdUhuY0c4SlBUTWlCcThZWVBodlV0YXczZWhGTWpIVUJjQmJsZVR1?=
 =?utf-8?B?LzFXcCtMZEpjeERmMWY4M0dVdmJmTkxlYXhHcWxEaURIVVRLK0JNMVZYM0pM?=
 =?utf-8?B?K3BOUlM0U0hFWGI2MXlyMHVjdkVmTWlVQS9xRjhwRkk0T1BnZXVkWWpURk4w?=
 =?utf-8?B?WmRmbEFuWm10V3NQVzg1eC9PUUJIaTc3dmVhMFhOYitpWHdCc3pGck9HL0Zv?=
 =?utf-8?B?RXEwemdRZUZuZkdraUhna3NrMEZCM1BNT0x4NWN5T01neUw1V25COWdMVDVP?=
 =?utf-8?B?c3VrSmRLWFhCZXNUQzlUSkZUYkRFZE5ib0sxMFFyOFM0SE55UjJWalpNc2dD?=
 =?utf-8?B?MUx6V1E3ZEEwbTBOSUV5TmZVR3NyTytuWjZiQVQva2g4TFlrUkRMRGxUM29G?=
 =?utf-8?B?aC9NZCtYTlpEK3F3NWVYMW56VHhtRmQzWEpRZnJISnM5WkxvVlVkQ1lYQjJL?=
 =?utf-8?B?eXpvMjJma2tSTXRnN2F0TXgwOWRUSVVhS3NjM0ZndWdtZ1JwV1NsUG80YVlF?=
 =?utf-8?B?Smd3bEdiSmJSK1FsWStrRnlFVFo2SVlQcHpZUFJaWTByY2JIeEk2ZDhxeVl5?=
 =?utf-8?B?TDVoWUJYdVpLbU5adWNNSFdjRlpoTFpIU01xVmxSYzluWEtaWGtTa2pramJR?=
 =?utf-8?B?Wnpjb1pXSE9uVVM2N3JaaXlEM3doV0RxeGRBdVVnRklhVEZjY0JkeWdPMEVS?=
 =?utf-8?B?RDk2ekVBcTdwbVBFTzdjdVNmMm1DaDhjc1dIbXZwNFVBdXlrcVFBQ01PRFBh?=
 =?utf-8?B?MXJoZEsvQlBxSk5ESjR0OU5JTS9FaHBzWjJCYjRpZWV5R0NSSFk4QWo5b0hL?=
 =?utf-8?B?RVYvVWZhUTJ5aEthM2FyZkxHQkFBR3Z6TnhDRWQ0UlVaMUNvdDFsQXRMdEhT?=
 =?utf-8?B?TEFHNzA4S0JmcHc3cHl2NDJ3dUFPOWxvbW05NlZnZ2dsak5ob1g4blU4ekhM?=
 =?utf-8?B?eXBjempJczNKRm5XZEd6bnd5ZGhQZ09SaEJzVkZlMERBbi9EbFpkbGF4U1FK?=
 =?utf-8?B?UXpwdDU3ZXZoVVA5WVJ4V2tYdFBuc2RzR2FpVGlZak5ZbFRVZFk5UFp6d0R1?=
 =?utf-8?B?WkNLd3NWU1B5RkIwZThUM2FBdjNFOFgrcWNKd1h5S1lHMVl5TVFTU2x2VXpE?=
 =?utf-8?Q?oYzFBpXR1n/WbW3Eb1U3PueRI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D7B501E95C11741BADE57D9324A77B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d918e-c88d-4e7d-e79d-08dbb8176d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 07:18:16.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnq+iA981Fz4ehcGu7X6wfjBPy/LaXoOPuEqeDdmd2Wx8VtRyr2nh3TYTbyfnAYAtIz6dD3KbpNwtK0GNbKrNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7283
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjMtMDgtMTAgYXQgMDI6MTUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBkeW5hbWljIGNvbm5lY3RvciBzZWxlY3Rpb24gZnVu
Y3Rpb24sIGVhY2ggZGRwX2NvbXAgbmVlZA0KPiB0bw0KPiBnZXQgdGhlaXIgZW5jb2Rlcl9pbmRl
eCB0byBpZGVudGlmeSB3aGljaCBjb25uZWN0b3Igc2hvdWxkIGJlDQo+IHNlbGVjdGVkLg0KPiAN
Cj4gQWRkIGVuY29kZXJfaW5kZXggZnVuY3Rpb24gdG8gbXRrX2RkcF9jb21wX2Z1bmNzIGFuZCB0
aGUNCj4gaW1wbGVtZW50YXRpb24NCj4gb2YgbXRrX2RwaV9lbmNvZGVyX2luZGV4IHRvIGdldCBp
dHMgZW5jb2Rlcl9pbmRleC4NCg0KU2VwYXJhdGUgdGhlIGNvbW1vbiBwYXJ0IGFuZCBkcGkgcGFy
dCB0byBkaWZmZXJlbnQgcGF0Y2guDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8IDEgKw0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgICAgICB8IDkgKysrKysrKysrDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jIHwgMSArDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oIHwgMSArDQo+ICA0IGZp
bGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gaW5kZXggMjI1NDAzODUxOWUxLi41ZjA3MDM3NjcwZTkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTQ0
LDYgKzQ0LDcgQEAgdm9pZCBtdGtfZGl0aGVyX3NldF9jb21tb24odm9pZCBfX2lvbWVtICpyZWdz
LA0KPiBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnICpjbWRxX3JlZywNCj4gIA0KPiAgdm9pZCBtdGtf
ZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19kcGlfc3RvcChzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiArdW5zaWduZWQgaW50IG10a19kcGlfZW5jb2Rlcl9pbmRleChz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgDQo+ICB2b2lkIG10a19kc2lfZGRwX3N0YXJ0KHN0cnVj
dCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19kc2lfZGRwX3N0b3Aoc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGluZGV4IDk0OGE1M2Yx
ZjRiMy4uM2Q2YjNjMjI4ZjMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
Cj4gQEAgLTc4Miw2ICs3ODIsMTUgQEAgdm9pZCBtdGtfZHBpX3N0b3Aoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiAgCW10a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVk
IGludCBtdGtfZHBpX2VuY29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiAr
CXN0cnVjdCBtdGtfZHBpICpkcGkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25l
ZCBpbnQgZW5jb2Rlcl9pbmRleCA9IGRybV9lbmNvZGVyX2luZGV4KCZkcGktPmVuY29kZXIpOw0K
PiArDQo+ICsJZGV2X2RiZyhkZXYsICJlbmNvZGVyIGluZGV4OiVkXG4iLCBlbmNvZGVyX2luZGV4
KTsNCj4gKwlyZXR1cm4gZW5jb2Rlcl9pbmRleDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBt
dGtfZHBpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+
IHZvaWQgKmRhdGEpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kcGkgKmRwaSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZGRwX2NvbXAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9j
b21wLmMNCj4gaW5kZXggZjExNGRhNGQzNmE5Li5lZmZhYWE3NjliNDYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtMzA0LDYgKzMw
NCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIGRkcF9kaXRoZXIN
Cj4gPSB7DQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZHBp
ID0gew0KPiAgCS5zdGFydCA9IG10a19kcGlfc3RhcnQsDQo+ICAJLnN0b3AgPSBtdGtfZHBpX3N0
b3AsDQo+ICsJLmVuY29kZXJfaW5kZXggPSBtdGtfZHBpX2VuY29kZXJfaW5kZXgsDQo+ICB9Ow0K
PiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyBkZHBfZHNjID0g
ew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2Nv
bXAuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4g
aW5kZXggZmViY2FlZWYxNmExLi4zMjZjYjU3YTE4YzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiBAQCAtODAsNiArODAsNyBAQCBzdHJ1
Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHsNCj4gIAl2b2lkICgqZGlzY29ubmVjdCkoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQo+ICptbXN5c19kZXYsIHVuc2lnbmVkIGludCBuZXh0
KTsNCj4gIAl2b2lkICgqYWRkKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtdGtfbXV0ZXgg
Km11dGV4KTsNCj4gIAl2b2lkICgqcmVtb3ZlKShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBt
dGtfbXV0ZXggKm11dGV4KTsNCj4gKwl1bnNpZ25lZCBpbnQgKCplbmNvZGVyX2luZGV4KShzdHJ1
Y3QgZGV2aWNlICpkZXYpOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IG10a19kZHBfY29tcCB7DQo=
