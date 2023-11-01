Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE87DE374
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKAO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjKAO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:58:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A291FC;
        Wed,  1 Nov 2023 07:58:43 -0700 (PDT)
X-UUID: 1f46017878c711ee8051498923ad61e6-20231101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZKBMtyXg+HEPkFN11LwPiR8Q70+NEdUXGh5HOs5Fk24=;
        b=CIuB/QEfumBn1clcQl8lz9Xy6YxwsOhOtriipBZvyUszVa7DzOMhQUq5zL2yY6jTY9DqmwpNKbm0NTDVfMA6mxRAEOr7OW8o0z6uzXc8xyoRpqsTyBHAdeMjh/j+I0/8W0ZS66j9Dqe6A3rQLCl8wm27S+XaWqNp+5vgAjza1Z0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:c882b5fb-0412-4a3c-8cd0-1feade98e7ff,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:52cb905f-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1f46017878c711ee8051498923ad61e6-20231101
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.ye@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 633300296; Wed, 01 Nov 2023 22:58:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 1 Nov 2023 22:58:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 1 Nov 2023 22:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNIEDOorJzi+mDg1Is9nt+Aum+ot0jKxwc9bmdEYWwVxDR3cgVNBp/G97bhH+fGuSxstuycUtCcvPGSsVqUDiYd3DI1Idgv9z28lT3L7T52PgG9ZAoLsc8WC46/VZ4GrgVVua5CRkYkVUIJrzWNck8B3LEFdNStaA3p8gQdfhkS2s4DMFqoY4IAztARlrASW5GsRTciUCBXPxIRMznST8UDm68wDiIK8Fy4u/yLdV36WMPcBcWltym4JBUN7+p3vnNn5YbvkGjoK9gqV6/X7YbnydwH4vNKiHgLYITTbgYI/d5LpedGgf65lkm+yPT3Z79/eFX89jup0rHl7lIW45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKBMtyXg+HEPkFN11LwPiR8Q70+NEdUXGh5HOs5Fk24=;
 b=XTM3VHTXQVXQQCNNSudGSZ9q3ZgNjvbcaMUgG28nDgMm0mH8AIJ2/D+hQfpJBXpOhm5HmnEiPnboBJ5k/VNwYUYtbzgcVm/aePsqv/Mko/AzLeOpziHpsJwWspnhpd169aVvzb5OczmfruIJe+e4i+NNrIFQEFMrYMcKI8gePCWmu4TU4/hfxDOpXISioqxWDrPPHar0M0bminQlG/g+GqeTP9BltQgsJUJhLq4N9Lm+iifPb1qUhOnhuZ+Yrc8utngZ41f2VdPFy4gjQmzmD3FSjrEsWQIRWwJZ6psKjUnJ25nYo8spuz/uq+s+vAgy032VMMHBb5/M1l+fxk5N4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKBMtyXg+HEPkFN11LwPiR8Q70+NEdUXGh5HOs5Fk24=;
 b=vC2crj30Qq5YkeTGeJ3QRyUX2J04/t/+FBhe2RJR3c96h7KOO/XunLLKphY/LbuS3nWewOVjjHOooesVLCr6Vr0kT4//LHduwR6FYa0FhKzjTk/JlFc9b/pvYCO+urqmkEg0MdEQAi1q7BpDy+BFRleHtaCs9UOMnXV2LzHhr0M=
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com (2603:1096:400:32::11)
 by SEYPR03MB6995.apcprd03.prod.outlook.com (2603:1096:101:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 14:58:27 +0000
Received: from TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf]) by TYZPR03MB5199.apcprd03.prod.outlook.com
 ([fe80::b06f:65cf:b887:6fcf%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 14:58:27 +0000
From:   =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To:     "rafael@kernel.org" <rafael@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        =?utf-8?B?QnJvd3NlIFpoYW5nICjlvKDno4op?= 
        <Browse.Zhang@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        =?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?= 
        <Yongdong.Zhang@mediatek.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= 
        <Yugang.Wang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Topic: [PATCH] thermal: Fix race condition in suspend/resume
Thread-Index: AQHaDNPevanWicGux0eGx3l2bTLI9g==
Date:   Wed, 1 Nov 2023 14:58:27 +0000
Message-ID: <c8d305f8b46287d86a49a887983ff2198cfbc297.camel@mediatek.com>
References: <20230916113327.85693-1-bo.ye@mediatek.com>
         <542a64a842d715329b35654db908681e074b0db5.camel@mediatek.com>
         <148c8e2d10bbb932177f732dfc44230681dc4d91.camel@mediatek.com>
         <CAJZ5v0hSeCcpOr4qOpji8sbN89GnsYYc1pYBhV+LmS=TiJQMnA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hSeCcpOr4qOpji8sbN89GnsYYc1pYBhV+LmS=TiJQMnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5199:EE_|SEYPR03MB6995:EE_
x-ms-office365-filtering-correlation-id: 028118fa-6bfe-4f6c-508e-08dbdaeb014c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeCO7s6k0UrlMgK2e/Nxho0gQrA1XZAv6bnZkaSoY57mar5TKdUAMVQdwWCr5nku5JlBqFzb6d9urQvTuaogOq/3fxGrXtpzbjkdLYlIoYMMHi/1KKQqFhYQiWjb4XyXlws/16IawLgssYab7yA0H0idXjv+Xdt7oanO/qckzRy0P4pomZhdO+AZauBoqlswpkTAksLMM5nDmvANJiTSYANTlfYcewZ/LA656/mK2OIpX1ZUiz1VDayepRDzIT1H6B1FhcfSy7FRVdNV/4S2PjHnIVoDoWjCnjcYJmzARHlmxnJ/NdYi8znIC3TQg4ijU5z15Tfmz0ukHJRBQxEgRoHJlNYbLzyd/KyAuArvCQ+runnauVmf3fKkzr2uOd+b94VmkhZ49uQixvvbgAYsn+Vnpk3oEXYacP4IAHNB4vP86/361h5w3URG5QxtCtPjeC/dRYNtGKCQPobN6TjD2qwZFxFkD1+7R6JJlYMXFtVvhwifnFE6N+BhUdIsZrXQxKMLtLGqqXva077G5uw4CHp7AgoXkjB270agzugtvec531dZKAGn/M/45EDJ95MLGin73aVq+mS59mmKBeHt1IQvvebifLWntVnYtgkFf3+3YY80IebLBOBaRIwBHprPK1nmt4fjXWLgZ01x7qOqP/4FYuJxRKQ4zTjdOk8TE3P8rvet2BLw5pVd6qiEfFzrN6wq1kYfe1uRgeXuGU1ruw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5199.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(122000001)(66556008)(66946007)(76116006)(91956017)(66446008)(66476007)(6486002)(54906003)(38070700009)(64756008)(6512007)(53546011)(38100700002)(36756003)(15650500001)(6506007)(478600001)(71200400001)(6916009)(26005)(83380400001)(5660300002)(316002)(4326008)(8936002)(8676002)(2616005)(86362001)(41300700001)(7416002)(2906002)(85182001)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bSs2SkV2VHJ0emJRQVBGZ3hZRGswaStKVms5U2p0RGV0bW4vRUVmbzZaNUZm?=
 =?utf-8?B?S3NzT2JnNHp5TjNGenNDOUxqWDl2V1NNRHNJQ1RoQk0zMzcySHo5ME5MQUxJ?=
 =?utf-8?B?cTBmZmhKTE9SVnRvSytiVkY5REFnanExY2VTd1RyTkQxSXdheXEzWHpFYyti?=
 =?utf-8?B?U1piU1dDa1l1QzdBbm1Ddllrb2VqRWw4aFVpSmRkMzgveVpGMU1vYkZDNm1u?=
 =?utf-8?B?aVRYVHRnSjYxelRpcitFV3RQclFkUUJNWTk0RTY2azNNeTdCY3kyS0REM1FX?=
 =?utf-8?B?RWw2R3ZHMGVWVno5ZlcyUVpJekQ4dVhvc1J1bUF3MEdnOE5QUVQyQWIxZWZk?=
 =?utf-8?B?Sm1mL0FkeSttb01IWWlWQ1JrQ3NZZGIyUEVXbmlTL0RXNDhTeHEvRXlVTWJO?=
 =?utf-8?B?MjRjVU1ydHFaSVZKVzNXRjFPQzlycnM2ZzhEWVVnNjVoSjFpR0NndG9yM1Zw?=
 =?utf-8?B?YmZXTWxEMWNqU3NWV3lHWktzSG9BbURzMHc3NVdJYXVTbFN5ZWVkODJjS0p3?=
 =?utf-8?B?TWhMMk0yUkFkL3ZMemdNVmVhMm8velp5bEFjbFlubjQ2RlBLSThhTzJrTngv?=
 =?utf-8?B?Z2NPdks3TndNekgrMVUvdmpjUzl6c0wxZnMzUWY1MXVNRDZpUEM1cHZrU21T?=
 =?utf-8?B?eEtHTTdIRUVwRE1QMGQ3NXN6NU5QcFpwSTdVS003QjhEK1FUR1RHdDdBNzJP?=
 =?utf-8?B?ZzJWMmc3U1ZNTTJaK0NLSW1yTmU1aXc1dlIvR3RKTXdLdkl5d01WczJiTkY1?=
 =?utf-8?B?ZldNYjQ3cWFhekJpYzdhemJId1NqVjhrdWJ0SGRtSDBRZ3lvNDhWUWRldlN1?=
 =?utf-8?B?M1lwcXEzbkVWaXJRb0toMTAzN3JmRCs5OFZDc1ZPZUxnbGtsRzlnU3NSSHJV?=
 =?utf-8?B?VGUxUlozOW9pYmVxbGttZ2RBWnhpY2ZvSEVOUk9oK3JLTXN2T2pGd2F4TVFH?=
 =?utf-8?B?RWY0ZEFCaS9Gb1M1TlNpc0ljdTVjOHMwNmpuL0hTd2xFQXVFZ2MycHpIYVJx?=
 =?utf-8?B?cWRQc3U0RXRjc1RJK0xkMWVIbHZ3Nk1jSnVmYjNzY1B2VjFJcjdkTnJQWWw5?=
 =?utf-8?B?ZGo4U2U3aWlZSUpyYjFydWZPSmc3Z2VNWW9VeEcwb0hmU3RDdjFyRndUeGVR?=
 =?utf-8?B?UnVoT0pVdGw5UktFN2xLUkFNVldRL2hjd0VKVzJaejFXN3RKYU1YUzN0S21t?=
 =?utf-8?B?MFV5TEppNW15Q3ltVWI3MWc3eHRsY25jeGpMZzVJZHJoblJYVFZmdThXRk5k?=
 =?utf-8?B?eFBIRlpHMWFHbkR0aEh6RG1VR0JvWTY1ODgrYXBQY2R6Qnoyd25lUlRWQXBV?=
 =?utf-8?B?RDBiNzNJczA1ME9BMUFyUUtzRGYyamJBcWNDUThIVTkxVlFtNHExOHljd2ZY?=
 =?utf-8?B?VldJMWJYV1hvd2h4c25rYjBEYUJoSDFoUEUza0pCMkZzQmMrWE02Z0dIanBo?=
 =?utf-8?B?Q2JOanhUejRXT3kyTjhxSHVHTk9pWVFESUloemM5RzF3dVhmTHJCdDZUaVVV?=
 =?utf-8?B?ZlVCNXRJQklmeWVlbVJxOURSUDBUazg5b3RvSjJrSy81Ly9HQjkycmJsY3la?=
 =?utf-8?B?eHdXRWhkcGVtUTZ6U3ovV1ZmdUtBUFYzR05yNWRyWUhBd0t2ZzZVT056S0dk?=
 =?utf-8?B?eTJGZzA5aGFockd6NzRiQWNzV1JUMGttMUx5L0tvNnIxZWVXYmdNN281ZXJk?=
 =?utf-8?B?OSt1dC9FR0E1ODVkYURqZG5yRmQ5cU1vejljK3gyb0k5L2VySnNVaVI5b25F?=
 =?utf-8?B?UTI5WHpnbkpuVXkwQSs0NG53NlBqMmpIV25vbXB0RWUzRmZIS3k2bzJzTzA4?=
 =?utf-8?B?NEorRkZvdExTamladTI2UlloUzFHNWxUOHF4ZTJIdmswUk1PREk3VnNQK0FI?=
 =?utf-8?B?QnlpV0RZclczb3ZNdlVDTUpiSEk5Wk5yVE1Qa0paWXEvNzJjVXdCU2wyaUNr?=
 =?utf-8?B?cWJCTEZuSVRrWXUwRDlZRHg0aTVOeHZOdXhQZFd5K3R3UkhJWDhha2RqQTBl?=
 =?utf-8?B?V2xUTzRLUklSc09tSzllN2RzWWozRTJnVzIxVC85b2lXSnZpL08rMXFteUJK?=
 =?utf-8?B?QU1RZ3B0NDN0V0JpbTd6TDJWNjNIdnVOc3pCenNzR3ZWc0wwRXNpL1ZaMGor?=
 =?utf-8?Q?wNV7RQmLE+P5pT/EMUp2DQ7Id?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <430EA4B5B461744BA893287290206302@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5199.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028118fa-6bfe-4f6c-508e-08dbdaeb014c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 14:58:27.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBpK5o2Sf8JJWQcbKLfg0dqjYKxZ5AZUwT5Ngfoji90l4ry3OqzgiqjJWkvXBEK1ufwVsejuVtS7PKsQMEW2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6995
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDIwOjIxICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ICBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAzOjIw4oCvQU0gQm8g
WWUgKOWPtuazoikgPEJvLlllQG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBZZXMs
IGl0IGlzIG9ic2VydmVkIGlzc3VlLg0KPiANCj4gSXQgZG9lcyBoYXBwZW4sIHNvIGl0J3Mgbm90
IGp1c3QgInBvdGVudGlhbCIgYW5kIHRoZSBzdWJqZWN0IG9mIHRoZQ0KPiBwYXRjaCBpcyBzbGln
aHRseSBtaXNsZWFkaW5nLiAgUGxlYXNlIGFkanVzdCBpdC4NCg0KRG9uZQ0KDQo+IA0KPiA+IEZp
cnN0bHksIGl0IG5lZWRzIHRvIGJlIGNsYXJpZmllZCB0aGF0IHRoaXMgaXNzdWUgb2NjdXJzIGlu
IGEgcmVhbC0NCj4gPiB3b3JsZCBlbnZpcm9ubWVudC4gQnkgYW5hbHl6aW5nIHRoZSBsb2dzLCB3
ZSBpbmZlcnJlZCB0aGF0IHRoZQ0KPiBpc3N1ZQ0KPiA+IG9jY3VycmVkIGp1c3QgYXMgdGhlIHN5
c3RlbSB3YXMgZW50ZXJpbmcgc3VzcGVuZCBtb2RlLCBhbmQgdGhlIHVzZXINCj4gd2FzDQo+ID4g
c3dpdGNoaW5nIHRoZSB0aGVybWFsIHBvbGljeSAodGhpcyBhY3Rpb24gY2F1c2VzIGFsbCB0aGVy
bWFsIHpvbmVzDQo+IHRvDQo+ID4gdW5yZWdpc3Rlci9yZWdpc3RlcikuIEluIGFkZGl0aW9uLCB3
ZSBjb25kdWN0ZWQgZGVncmFkYXRpb24gdGVzdHMNCj4gYW5kDQo+ID4gYWxzbyByZXByb2R1Y2Vk
IHRoaXMgaXNzdWUuIFRoZSBzcGVjaWZpYyBtZXRob2QgaXMgdG8gZmlyc3Qgc3dpdGNoDQo+IHRo
ZQ0KPiA+IHRoZXJtYWwgcG9saWN5IHRocm91Z2ggYSBjb21tYW5kLCBhbmQgdGhlbiBpbW1lZGlh
dGVseSBwdXQgdGhlDQo+IHN5c3RlbQ0KPiA+IGludG8gc3VzcGVuZCBzdGF0ZSB0aHJvdWdoIGFu
b3RoZXIgY29tbWFuZC4gVGhpcyBtZXRob2QgY2FuIGFsc28NCj4gPiByZXByb2R1Y2UgdGhlIGlz
c3VlLg0KPiANCj4gT0ssIHNvIHBsZWFzZSBhZGQgdGhpcyBpbmZvcm1hdGlvbiB0byB0aGUgcGF0
Y2ggY2hhbmdlbG9nLg0KPiANCj4gPiBPbiBUaHUsIDIwMjMtMTAtMTIgYXQgMDc6MzUgKzAwMDAs
IEJvIFllICjlj7bms6IpIHdyb3RlOg0KPiA+ID4gT24gU2F0LCAyMDIzLTA5LTE2IGF0IDE5OjMz
ICswODAwLCBCbyBZZSB3cm90ZToNCj4gPiA+DQo+ID4gPiBDb3JyZWN0IG1haWwgdGl0bGUgZm9y
bWF0OiByZW1vdmUgIlN1YmplY3Q6IiBmcm9tIG1haWwgdGl0bGUuDQo+ID4gPg0KPiA+ID4gPiBG
cm9tOiAieXVnYW5nLndhbmciIDx5dWdhbmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+DQo+
ID4gPiA+IEJvZHk6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgYSByYWNlIGNvbmRpdGlvbiBk
dXJpbmcgc3lzdGVtIHJlc3VtZS4gSXQNCj4gb2NjdXJzDQo+ID4gPiA+IGlmDQo+ID4gPiA+IHRo
ZSBzeXN0ZW0gaXMgZXhpdGluZyBhIHN1c3BlbmQgc3RhdGUgYW5kIGEgdXNlciBpcyB0cnlpbmcg
dG8NCj4gPiA+ID4gcmVnaXN0ZXIvdW5yZWdpc3RlciBhIHRoZXJtYWwgem9uZSBjb25jdXJyZW50
bHkuIFRoZSByb290IGNhdXNlDQo+IGlzDQo+ID4gPiA+IHRoYXQgYm90aCBhY3Rpb25zIGFjY2Vz
cyB0aGUgYHRoZXJtYWxfdHpfbGlzdGAuDQo+ID4gPiA+DQo+ID4gPiA+IEluIGRldGFpbDoNCj4g
PiA+ID4NCj4gPiA+ID4gMS4gQXQgUE1fUE9TVF9TVVNQRU5EIGR1cmluZyB0aGUgcmVzdW1lLCB0
aGUgc3lzdGVtIHJlYWRzIGFsbA0KPiA+ID4gPiB0aGVybWFsDQo+ID4gPiA+ICAgIHpvbmVzIGlu
IGB0aGVybWFsX3R6X2xpc3RgLCB0aGVuIHJlc2V0cyBhbmQgdXBkYXRlcyB0aGVpcg0KPiA+ID4g
PiAgICB0ZW1wZXJhdHVyZXMuDQo+ID4gPiA+IDIuIFdoZW4gcmVnaXN0ZXJpbmcvdW5yZWdpc3Rl
cmluZyBhIHRoZXJtYWwgem9uZSwgdGhlDQo+ID4gPiA+ICAgIGB0aGVybWFsX3R6X2xpc3RgIGdl
dHMgbWFuaXB1bGF0ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZXNlIHR3byBhY3Rpb25zIG1pZ2h0
IG9jY3VyIGNvbmN1cnJlbnRseSwgY2F1c2luZyBhIHJhY2UNCj4gPiA+ID4gY29uZGl0aW9uLg0K
PiA+ID4gPiBUbyBzb2x2ZSB0aGlzIGlzc3VlLCB3ZSBpbnRyb2R1Y2UgYSBtdXRleCBsb2NrIHRv
IHByb3RlY3QNCj4gPiA+ID4gYHRoZXJtYWxfdHpfbGlzdGAgZnJvbSBiZWluZyBtb2RpZmllZCB3
aGlsZSBpdCdzIGJlaW5nIHJlYWQgYW5kDQo+ID4gPiA+IHVwZGF0ZWQgZHVyaW5nIHRoZSByZXN1
bWUgZnJvbSBzdXNwZW5kLg0KPiA+ID4gPg0KPiA+ID4gPiBLZXJuZWwgb29wcyBleGNlcnB0IHJl
bGF0ZWQgdG8gdGhpcyBmaXg6DQo+ID4gPiA+DQo+ID4gPiA+IFsgNTIwMS44Njk4NDVdIFtUMzE2
ODIyXSBwYzogWzB4ZmZmZmZmZWI3ZDQ4NzZmMF0NCj4gPiA+ID4gbXV0ZXhfbG9jaysweDM0LzB4
MTcwDQo+ID4gPiA+IFsgNTIwMS44Njk4NTZdIFtUMzE2ODIyXSBscjogWzB4ZmZmZmZmZWI3Y2E5
OGE4NF0NCj4gPiA+ID4gdGhlcm1hbF9wbV9ub3RpZnkrMHhkNC8weDI2Yw0KPiA+ID4gPiBbLi4u
IGN1dCBmb3IgYnJldml0eSAuLi5dDQo+ID4gPiA+IFsgNTIwMS44NzEwNjFdIFtUMzE2ODIyXSAg
c3VzcGVuZF9wcmVwYXJlKzB4MTUwLzB4NDcwDQo+ID4gPiA+IFsgNTIwMS44NzEwNjddIFtUMzE2
ODIyXSAgZW50ZXJfc3RhdGUrMHg4NC8weDZmNA0KPiA+ID4gPiBbIDUyMDEuODcxMDc2XSBbVDMx
NjgyMl0gIHN0YXRlX3N0b3JlKzB4MTVjLzB4MWU4DQo+IA0KPiBXZWxsLCB0aGUgY29ubmVjdGlv
biBiZXR3ZWVuIHRoZSBhYm92ZSBsb2cgc25pcHBldCBhbmQgdGhlIGlzc3VlDQo+IGFkZHJlc3Nl
ZCBieSB0aGUgcGF0Y2ggaXMgcmF0aGVyIGhhcmQgdG8gZXN0YWJsaXNoLiAgUGxlYXNlIGluY2x1
ZGUNCj4gbW9yZSBvZiB0aGUgb29wcyBpbmZvcm1hdGlvbi4NCg0KVGhhbmsgeW91IHZlcnkgbXVj
aCBmb3IgcmV2aWV3aW5nIHRoZSBhZGRpdGlvbmFsIGV4cGxhbmF0aW9ucy4NCg0KMS5FbmFibGUg
dGhlcm1hbCBwb2xpY3kgb3BlcmF0aW9uIHdpbGwgdW5yZWdpc3Rlci9yZWdpc3RlciBhbGwgdGhl
cm1hbA0Kem9uZXMNCjEwLTIxIDA2OjEzOjU5LjI4MCAgIDg1NCAgIDkyMiBJIGxpYk10Y0xvYWRl
cjogZW5hYmxlIHRoZXJtYWwgcG9saWN5DQp0aGVybWFsX3BvbGljeV8wOS4NCg0KMi5TeXN0ZW0g
c3VzcGVuZCBlbnRyeSB0aW1lIGlzIDIwMjMtMTAtMjAgMjI6MTM6NTkuMjQyDQpbIDQxMDYuMzY0
MTc1XVtUNjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOnNwbSZdW1NQTV0gUE06IHN1c3BlbmQN
CmVudHJ5IDIwMjMtMTAtMjAgMjI6MTM6NTkuMjQyODk4MjQzIFVUQw0KWyA0MTA2LjM2NjE4NV1b
VDYwOTM4N10gYmluZGVyOjUzNF8yOiBQTTogW25hbWU6d2FrZXVwJl1QTTogUGVuZGluZw0KV2Fr
ZXVwIFNvdXJjZXM6IE5FVExJTksNCg0KMy4gSXQgY2FuIGJlIHByb3ZlbiB0aGF0IHRoZSBhYnNl
bmNlIG9mIGEgc3dpdGNoIHN0cmF0ZWd5IHdpbGwgcGVyZm9ybQ0KdW5yZWdpc3Rlci9yZWdpc3Rl
ciBvcGVyYXRpb25zIG9uIHRoZXJtYWwgem9uZXMgKGFuZHJvaWQgdGltZSBpcyAyMDIzLQ0KMTAt
MjAgMjI6MTM6NTkuMjgyKe+8jA0KQmVjYXVzZSB0aGUgbG9ncyBmb3Igb3RoZXIgdGhlcm1hbCB6
b25lcyBzd2l0Y2hpbmcgYXJlIG5vdCBlbmFibGVkIGJ5DQpkZWZhdWx0LCB3ZSBjYW5ub3Qgc2Vl
IHRoZSBsb2dzIHJlbGF0ZWQgdG8gb3RoZXIgdGhlcm1hbCB6b25lcy4NClsgNDEwNi40MDQxNjdd
W1Q2MDA5MjJdIG10a1Bvd2VyTXNnSGRsOg0KW25hbWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1h
bC9UWi9DUFVddHNjcHVfdW5iaW5kIHVuYmluZGluZyBPSw0KWyA0MTA2LjQwNDIxNV1bVDYwMDky
Ml0gbXRrUG93ZXJNc2dIZGw6DQpbbmFtZTp0aGVybWFsX21vbml0b3ImXVtUaGVybWFsL1RaL0NQ
VV10c2NwdV91bmJpbmQgdW5iaW5kaW5nIE9LDQpbIDQxMDYuNDA0MjI1XVtUNjAwOTIyXSBtdGtQ
b3dlck1zZ0hkbDoNCltuYW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFovQ1BVXXRzY3B1
X3VuYmluZCB1bmJpbmRpbmcgT0sNClsgNDEwNi40MDQ1MDRdW1Q2MDA5MjJdIG10a1Bvd2VyTXNn
SGRsOg0KW25hbWU6dGhlcm1hbF9tb25pdG9yJl1bVGhlcm1hbC9UWi9DUFVddHNjcHVfYmluZCBi
aW5kaW5nIE9LLCAwDQpbIDQxMDYuNDA0NTQ1XVtUNjAwOTIyXSBtdGtQb3dlck1zZ0hkbDoNCltu
YW1lOnRoZXJtYWxfbW9uaXRvciZdW1RoZXJtYWwvVFovQ1BVXXRzY3B1X2JpbmQgYmluZGluZyBP
SywgMg0KWyA0MTA2LjQwNDU2Nl1bVDYwMDkyMl0gbXRrUG93ZXJNc2dIZGw6DQpbbmFtZTp0aGVy
bWFsX21vbml0b3ImXVtUaGVybWFsL1RaL0NQVV10c2NwdV9iaW5kIGJpbmRpbmcgT0ssIDENCg0K
NC4gdGhlcm1hbF9wbV9ub3RpZnkgdHJpZ2dlciBLRShhbmRyb2lkIHRpbWU6ICAyMDIzLTEwLTIw
IDIyOjEzOjU5Lg0KMzE1ODk0KQ0KWyA0MTA2LjQzNzE3MV1bVDIwOTM4N10gYmluZGVyOjUzNF8y
OiBbbmFtZTptcmR1bXAmXUtlcm5lbCBPZmZzZXQ6DQoweDI4OWNjODAwMDAgZnJvbSAweGZmZmZm
ZmMwMDgwMDAwMDANClsgNDEwNi40MzcxODJdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6
bXJkdW1wJl1QSFlTX09GRlNFVDoNCjB4NDAwMDAwMDANClsgNDEwNi40MzcxOTFdW1QyMDkzODdd
IGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl1wc3RhdGU6IDgwNDAwMDA1DQooTnpjdiBkYWlm
ICtQQU4gLVVBTykNClsgNDEwNi40MzcyMDRdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6
bXJkdW1wJl1wYyA6DQpbMHhmZmZmZmZlOGE2Njg4MjAwXSBtdXRleF9sb2NrKzB4MzQvMHgxODQN
ClsgNDEwNi40MzcyMTRdW1QyMDkzODddIGJpbmRlcjo1MzRfMjogW25hbWU6bXJkdW1wJl1sciA6
DQpbMHhmZmZmZmZlOGE1Y2U2NmJjXSB0aGVybWFsX3BtX25vdGlmeSsweGQ0LzB4MjZjDQpbIDQx
MDYuNDM3MjIwXVtUMjA5Mzg3XSBiaW5kZXI6NTM0XzI6IFtuYW1lOm1yZHVtcCZdc3AgOg0KZmZm
ZmZmYzAxYmFiM2FlMA0KWyA0MTA2LjQzNzIyNl1bVDIwOTM4N10gYmluZGVyOjUzNF8yOiBbbmFt
ZTptcmR1bXAmXXgyOToNCmZmZmZmZmMwMWJhYjNhZjAgeDI4OiAwMDAwMDAwMDAwMDAwMDAxDQoN
Cj4gDQo+ID4gPiA+DQo+ID4gPiA+IENoYW5nZS1JZDogSWZkYmRlY2JhMTcwOTNmOTFlYWI3ZTM2
Y2UwNGI0NmQzMTFjYTY1NjgNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogeXVnYW5nLndhbmcgPHl1
Z2FuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQm8gWWUgPGJv
LnllQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3RoZXJtYWwv
dGhlcm1hbF9jb3JlLmMgfCAyICsrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvdGhl
cm1hbF9jb3JlLmMNCj4gPiA+ID4gYi9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4g
PiA+ID4gaW5kZXggODcxN2EzMzQzNTEyLi5hN2ExOGVkNTdiNmQgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gPiA+ID4gQEAgLTE1MjksMTIgKzE1MjksMTQgQEAg
c3RhdGljIGludCB0aGVybWFsX3BtX25vdGlmeShzdHJ1Y3QNCj4gPiA+ID4gbm90aWZpZXJfYmxv
Y2sgKm5iLA0KPiA+ID4gPiAgICAgY2FzZSBQTV9QT1NUX0hJQkVSTkFUSU9OOg0KPiA+ID4gPiAg
ICAgY2FzZSBQTV9QT1NUX1JFU1RPUkU6DQo+ID4gPiA+ICAgICBjYXNlIFBNX1BPU1RfU1VTUEVO
RDoNCj4gPiA+ID4gKyAgICAgICAgICAgbXV0ZXhfbG9jaygmdGhlcm1hbF9saXN0X2xvY2spOw0K
PiA+ID4gPiAgICAgICAgICAgICBhdG9taWNfc2V0KCZpbl9zdXNwZW5kLCAwKTsNCj4gDQo+IEl0
IGlzIG5vdCBjbGVhciB0byBtZSB3aHkgdGhlIGFib3ZlIHN0YXRlbWVudCBuZWVkcyB0byBiZSB1
bmRlciB0aGUNCj4gbG9jay4NCj4gDQo+ID4gPiA+ICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hf
ZW50cnkodHosICZ0aGVybWFsX3R6X2xpc3QsIG5vZGUpIHsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICB0aGVybWFsX3pvbmVfZGV2aWNlX2luaXQodHopOw0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgIHRoZXJtYWxfem9uZV9kZXZpY2VfdXBkYXRlKHR6LA0KPiA+ID4NCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRIRVJNQUxfRVZFTlRf
VU5TUEVDDQo+ID4gPiA+IElGSUVEKTsNCj4gPiA+ID4gICAgICAgICAgICAgfQ0KPiA+ID4gPiAr
ICAgICAgICAgICBtdXRleF91bmxvY2soJnRoZXJtYWxfbGlzdF9sb2NrKTsNCj4gPiA+ID4gICAg
ICAgICAgICAgYnJlYWs7DQo+ID4gPiA+ICAgICBkZWZhdWx0Og0KPiA+ID4gPiAgICAgICAgICAg
ICBicmVhazsNCg==
