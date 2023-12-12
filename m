Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E880EE6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbjLLOLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376684AbjLLOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:11:09 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5468F;
        Tue, 12 Dec 2023 06:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXLgEq0CZnDoKQRuXKOa+bvl8BW1CaxqUjnVswyJg90zSAdoBwQ86HAkTZl9uLY4LwhkLwZfxfi7lZkL7wPC/L0T7c2+0kv4fyuTGXnl1zUKrjPTeuLCMn2w3d34dctaU8xQj5z1Oj0zvXNa3FJS9cmeh6rE1bwLckMOT/bPua2m49cRy1cqoiUzrOAPW3Ad8GNpe02Uv+SL9hpdYpj/7tr8lOIaN2iikSVkhZSy2KmsNhU5U0nEhyASoxb6aRbmvy/5uE/f3eQl8aGLR9hs0jv9PY/wSNUq3V/rwjKmGUazKYJp5b+zVS9OFOoQqljLj2i1VAfXPMzhCNdSrJ9GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yE4Ip/iN6p33GAqDaD06zjn6JpwnovDaZ3bf5MmAIv0=;
 b=EuRyvoz5/RINhCdxD44ObNyjvTkb6jVAdqE4m3YETNPmL3m27F+AEzIXhSz6fdr36K4KB2kEdkcu8JuvX3hnrsybUlaS45wMzXoiGP3pIrHcpmDjZlEdedWrzNxmjbm6ilf4bvd/spQCTA9NcMjuXCP//WF7nU8FMT9tFigaXNdfGpxCGAuArWmf5eSU1e58HZkn/XvAnvVruVX7rbKcGm+0MuOtzMm69NUy6GMBOiq1VwfGARlqP9htwgyIWsKpnW/wb4VQQrdz+7kMIUxA0D5QH3kTmTtHD20D3ReJGagnwifb/F7n9tZ2NeUwsFRXopYd+Qhc6PFSpPYGi4IztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com (2603:1096:101:143::5)
 by SEYPR06MB6662.apcprd06.prod.outlook.com (2603:1096:101:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 14:11:06 +0000
Received: from SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62]) by SEYPR06MB6278.apcprd06.prod.outlook.com
 ([fe80::c664:8a1e:66d6:4e62%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 14:11:05 +0000
From:   "Joakim  Zhang" <joakim.zhang@cixtech.com>
To:     "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cix-kernel-upstream <cix-kernel-upstream@cixtech.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIFYxXSByZW1vdGVwcm9jOiB2aXJ0aW86IEZpeCB3ZGcg?=
 =?gb2312?Q?cannot_recovery_remote_processor?=
Thread-Topic: [PATCH V1] remoteproc: virtio: Fix wdg cannot recovery remote
 processor
Thread-Index: AQHaLLtrb+AjoFlBq0aMuorlloVq1bClrctQ
Date:   Tue, 12 Dec 2023 14:11:05 +0000
Message-ID: <SEYPR06MB6278AE38D53CA55FB06574F6828EA@SEYPR06MB6278.apcprd06.prod.outlook.com>
References: <20231212052357.2052629-1-joakim.zhang@cixtech.com>
In-Reply-To: <20231212052357.2052629-1-joakim.zhang@cixtech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6278:EE_|SEYPR06MB6662:EE_
x-ms-office365-filtering-correlation-id: ea42d4f2-c79a-4eaf-e894-08dbfb1c2e50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZC3bys7cdvUWbZ2SBptMMeVQu5zFNQyDQCdaa1P1AXlZIYEgroYu9AP+sq/4TIBEgvsNDE9k0KnqppUUmVY2p9SX46nmovJjBVNnv10bblj4n4/wSAL7GZUr88ZIjb7lHd0phURZstl9QJOXBYoT6BcZqLMYgR44FgUGazodk4U8HPsmq+53+E/9D6F1j0Edt0ftM9afXbYM/9efYOIHkcPzpNLxbD+Jfz0B+pulkTYS7SG0abN9KmTWIdhRfDgPRC/94s9jncMyaEvIzgqGj8VVkP5LHnBObCrWV0rll7NKqhzsgNvLX66oVJ0lJWsNCmfNMDGuhDQm+ou3eufbdTCN9vXQVTliq+gurJjhfthNRuY82Sewj/O8LMQToDN2kMWR71tVLhhgZRyg/oTCYUPicur4kVg0niVQchJo/XX93Zbjqz4MriEG7kHjSyznSRZRhxneqijqNoQ5+ZjGyF5YNPVzwei+xGoJejwr210HkemIeq9OWYezQNCB8X2dIFoimtH91uLxIxiNC/dHW2S/O4s3iGq3ru61N17oTWsepBzlkWURJFN4jegHzezXAvCtOkTtLOQHscZNfZDl4vJRzpcEiBc0TQNvxCJq/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6278.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(76116006)(64756008)(316002)(110136005)(66556008)(54906003)(66476007)(66446008)(66946007)(478600001)(966005)(107886003)(26005)(9686003)(33656002)(83380400001)(38070700009)(7696005)(6506007)(224303003)(41300700001)(71200400001)(122000001)(86362001)(2906002)(52536014)(5660300002)(55016003)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZjFXV1R5SmdKYjREQzJzZllkbHExQnZZRmJPSUVsbmlDRy9OYmN1bU1Ha2wr?=
 =?gb2312?B?OThISnUyU003eE0zVitPRjdQOEhRRVo4b3V4eFJ1WGxhK2lJbkdQM09kUXph?=
 =?gb2312?B?aTRZWDNmZXZwKzZ2TkFqZDVYL3FEOVQ5V0M4N05RSWQwdHlsVXByVk5GRWhx?=
 =?gb2312?B?Rlhac092YzFsNWdLd1dqaWw2SDV0U3JGSEMwUmJ3NXNUcm5QNmtpdHlvOThW?=
 =?gb2312?B?TjFubWxuTzhFWlNaS2RmTURVZmtNQTM5T0R6c0NDUWVwSjlvMFd3Q0dhcFUr?=
 =?gb2312?B?Z1JLUnNDUWIyV0dYTHU0SE5qVGloRG1OaXRuMnpLU3JIQkhMMWI5c0dtc09w?=
 =?gb2312?B?b2FRVm1sSnpPSGgrS0I0bEFxbjNSTjUzUHdEcjh4Y1ZIQjA5YmlVbzdZNCs1?=
 =?gb2312?B?bWJZcHhGdWRNanZoelM4dXRNKzNSby9PeFJTcFVtQzY1UTUvRjE0a1NmMElu?=
 =?gb2312?B?ZzBIbUdXcWtoYjRqc0tPQnNEYkE1WUpSOThKbGYwcGZWZ2prVUtmalRqd0Zv?=
 =?gb2312?B?UEdLWkVqelgrcTlpN3hLSlp6Q3I3T0p2NzV2dlZPQnNjd1o2YndQb1dKWFN6?=
 =?gb2312?B?YTRNRUlSLy9McE4xMlluL3pFYzU0Z1RyRzdYcFF4K2xYWGRTQU9NOGhQTXR3?=
 =?gb2312?B?bnM3VTRPVUZLbmoxZmpzU1o4NGFpVloxekxUWjVYMU5ZQmtsbUxkbEtHalFP?=
 =?gb2312?B?SlZMZnFTWTJsTGoxODZSMXhIY1FiQjkwWXpLMW1qMHFWRHlXSVhLVmoyM3ph?=
 =?gb2312?B?TllvK1NDaXpibmNqbTRnN0JEZFV3Smo2UHFUTTdocjhtd2hCUVV3aVlQM3RV?=
 =?gb2312?B?aWk3bmJNUHpGRkFBOWdVdlBPUVR6YWx4bW5QaEFmbFFsc2RjR29zMDZZT0RC?=
 =?gb2312?B?dXRZWWtSKzZYbTZpY3Y1Z1JpZ0V5V2hwcVdkbVhCaUE4RXdKcXBoVUk5VFFt?=
 =?gb2312?B?NWlqLzBGZ2pYUjZzMzNuSG9LYXZRSGo5cGtjZGJ5dmVIWnYrbGxmUFdEdGdR?=
 =?gb2312?B?UjRuQjA5NFBOWTFSKyt5VWVwSlNJMjd4cXpydWlMdklRd3J6WVY0RjBjN0x0?=
 =?gb2312?B?SFJLZzgwTHAzVFJpUmNScjRjLzhWZFg3N3RacHBSNFlqcGV0UnlYWjdycHR6?=
 =?gb2312?B?bHhnMnB5MnV1ZFp2N0VxTEtoMUVqc3BDT3RtRnQ3bEgzb002QjBxTHBsd2Uw?=
 =?gb2312?B?Uk1VZnZmaVFvR2REb1dLWnk1cCtoNkFudUREcjlBNEtzVG16aGJwZ1REZUU5?=
 =?gb2312?B?SldjeGRwSmFPS2ttcExLeDFQa2ZRa200NExDeGRJWFNrZmlkZGhUc2RzMDU3?=
 =?gb2312?B?ZHhLazJuSHVkdWhaVWlMQzduRVNkSTYwUkpBT3V4S2ZWMzQzOUhCbUJWZy9P?=
 =?gb2312?B?MkkreG9ZWWFqN3loTVBLdEgxZW5kWHMvOHdpQUxyVk93YjdtWmVaNmtmdVFw?=
 =?gb2312?B?UnpXSTBkTzZmTWxNRTJiS3dOcDVpRVdDQlVFY0VHVlNXQ2d2MnJlS0hnd2hU?=
 =?gb2312?B?QXZ4SVc0TXB2VlJuT0ladFJTYk5QRUpJajY3aVYvS3gwWmpIeUNjbjNuaHBw?=
 =?gb2312?B?Y0VHY1FTUk9EUDNqZS9KeVlURU45dDVKS2ZhY3I1RC9PdlIwNjNkMHFnVGUz?=
 =?gb2312?B?cEw4QmlvdDFwZml0NEpncVdoY25lQk43cE44WFFCSnJCbWdsQ09MZXZUREVn?=
 =?gb2312?B?T2s2WFE2bG1RbEJoeDF5Q3JHVXpyK2NXSTJYaFhNY1FvSXlwTzB0ak5RRlJ3?=
 =?gb2312?B?dU5yZlZnREN1SmFodzd2dU1yeFVORFVyaWpnck04dEFCUVF5Z2N2aEVOVzVa?=
 =?gb2312?B?aGdmVUNrR08zaTV0Rys1TlBiM1BTNDFHb0xQYm9PZ2diL1ZQcjgvTGo3TE9B?=
 =?gb2312?B?QmY0cVZRdGdQOUJyTVBqbVBtWUpUdUNFSXk2OTg3WWx6Y0RSYlZNQUI5QlJq?=
 =?gb2312?B?dVdqbWFrejE2MHJhOVJ1T250SkdIam82VVhEQTJleU1UbnF1WVNLQTRYM3pI?=
 =?gb2312?B?YStneEJjc3NMaGdwdXkraEppd1JFd2NKYk9kdW1GaTFkWkZhaXBuanNuVnla?=
 =?gb2312?B?RjdURW5IV29Oa0pland3clJuZGoxQ3BReEtsa3Jua3VnOHdLYk41NFlXeG9F?=
 =?gb2312?Q?PIPJ54vMFuGpi7m8NyhFdifK5?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6278.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea42d4f2-c79a-4eaf-e894-08dbfb1c2e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 14:11:05.7708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBx6ZP4Hgc6EeVuTKOM2bjBUba+fNwG1lI8fq7Evkk86suyqwIxF+b+b5LEaRx6kChR4h1t2Ar1HRs3RZQf0pwb6bX+/fjo1GRcyG9iTd4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6662
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbyBtYWludGFpbmVycywNCg0KVGhpcyBwYXRjaCBtYXkgbm90IGZpeCBpdCBpbiBhIGNv
cnJlY3Qgd2F5LCBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCBpbiBycHJvY19hZGRfdmlydGlv
X2RldigpOg0KDQoxKSBJZiB0aGUgYWxsb2NhdGUgcGF0aCBpcyBkbWFfZGVjbGFyZV9jb2hlcmVu
dF9tZW1vcnkoKSwgaXQgd2lsbCBiZSBmcmVlZCBmcm9tIGRtYV9yZWxlYXNlX2NvaGVyZW50X21l
bW9yeSgpLCB3aGljaCBpcyBleHBlY3RlZA0KDQoyKSBJZiB0aGUgYWxsb2NhdGUgcGF0aCBpcyBv
Zl9yZXNlcnZlZF9tZW1fZGV2aWNlX2luaXRfYnlfaWR4KCksIGl0IHdpbGwgc3RpbGwgYmUgZnJl
ZWQgZnJvbSBkbWFfcmVsZWFzZV9jb2hlcmVudF9tZW1vcnkoKSwgd2hpY2ggaXMgbm90IGV4cGVj
dGVkDQoNClRyeSB0byBmaXggdGhpcyBpc3N1ZSwgSSBhbHNvIGludHJvZHVjZSBhbm90aGVyIHBh
dGNoOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMjEyMDUyMTMwLjIwNTEzMzMt
MS1qb2FraW0uemhhbmdAY2l4dGVjaC5jb20vVC8NCg0KQXJlIHRoZXJlIGFueSBzdWdnZXN0aW9u
cz8gVGhhbmtzLg0KDQpKb2FraW0NCg0KPiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBK
b2FraW0gWmhhbmcgPGpvYWtpbS56aGFuZ0BjaXh0ZWNoLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjPE
6jEy1MIxMsjVIDEzOjI0DQo+IMrVvP7IyzogYW5kZXJzc29uQGtlcm5lbC5vcmc7IG1hdGhpZXUu
cG9pcmllckBsaW5hcm8ub3JnOw0KPiBhcm5hdWQucG91bGlxdWVuQGZvc3Muc3QuY29tDQo+ILOt
y806IGxpbnV4LXJlbW90ZXByb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBjaXgta2VybmVsLXVwc3RyZWFtIDxjaXgta2VybmVsLXVwc3RyZWFtQGNp
eHRlY2guY29tPjsgSm9ha2ltIFpoYW5nDQo+IDxqb2FraW0uemhhbmdAY2l4dGVjaC5jb20+DQo+
INb3zOI6IFtQQVRDSCBWMV0gcmVtb3RlcHJvYzogdmlydGlvOiBGaXggd2RnIGNhbm5vdCByZWNv
dmVyeSByZW1vdGUNCj4gcHJvY2Vzc29yDQo+IA0KPiBGcm9tOiBKb2FraW0gWmhhbmcgPGpvYWtp
bS56aGFuZ0BjaXh0ZWNoLmNvbT4NCj4gDQo+IFJlY292ZXJ5IHJlbW90ZSBwcm9jZXNzb3IgZmFp
bGVkIHdoZW4gd2RnIGlycSByZWNlaXZlZDoNCj4gWyAgICAwLjg0MjU3NF0gcmVtb3RlcHJvYyBy
ZW1vdGVwcm9jMDogY3Jhc2ggZGV0ZWN0ZWQgaW4gY2l4LWRzcC1ycHJvYzoNCj4gdHlwZSB3YXRj
aGRvZw0KPiBbICAgIDAuODQyNzUwXSByZW1vdGVwcm9jIHJlbW90ZXByb2MwOiBoYW5kbGluZyBj
cmFzaCAjMSBpbiBjaXgtZHNwLXJwcm9jDQo+IFsgICAgMC44NDI4MjRdIHJlbW90ZXByb2MgcmVt
b3RlcHJvYzA6IHJlY292ZXJpbmcgY2l4LWRzcC1ycHJvYw0KPiBbICAgIDAuODQzMzQyXSByZW1v
dGVwcm9jIHJlbW90ZXByb2MwOiBzdG9wcGVkIHJlbW90ZSBwcm9jZXNzb3INCj4gY2l4LWRzcC1y
cHJvYw0KPiBbICAgIDAuODQ3OTAxXSBycHJvYy12aXJ0aW8gcnByb2MtdmlydGlvLjAuYXV0bzog
RmFpbGVkIHRvIGFzc29jaWF0ZSBidWZmZXINCj4gWyAgICAwLjg0Nzk3OV0gcmVtb3RlcHJvYyBy
ZW1vdGVwcm9jMDogZmFpbGVkIHRvIHByb2JlIHN1YmRldmljZXMgZm9yDQo+IGNpeC1kc3AtcnBy
b2M6IC0xNg0KPiANCj4gVGhlIHJlYXNvbiBpcyB0aGF0IGRtYSBjb2hlcmVudCBtZW0gd291bGQg
bm90IGJlIHJlbGVhc2VkIHdoZW4gcmVjb3ZlcmluZw0KPiB0aGUgcmVtb3RlIHByb2Nlc3Nvciwg
ZHVlIHRvIHJwcm9jX3ZpcnRpb19yZW1vdmUoKSB3b3VsZCBub3QgYmUgY2FsbGVkLCB3aGVyZQ0K
PiB0aGUgbWVtIHJlbGVhc2VkLiBJdCB3aWxsIGZhaWwgd2hlbiBpdCB0cnkgdG8gYWxsb2NhdGUg
YW5kIGFzc29jaWF0ZSBidWZmZXIgYWdhaW4uDQo+IA0KPiBXZSBjYW4gc2VlIHRoYXQgZG1hIGNv
aGVyZW50IG1lbSBhbGxvY2F0ZWQgZnJvbSBycHJvY19hZGRfdmlydGlvX2RldigpLCBzbw0KPiBz
aG91bGQgcmVsZWFzZSBpdCBmcm9tIHJwcm9jX3JlbW92ZV92aXJ0aW9fZGV2KCkuIFRoZXNlIGZ1
bmN0aW9ucyBzaG91bGQNCj4gYXBwZWFyIHN5bW1ldHJpY2FsbHk6DQo+IC1ycHJvY192ZGV2X2Rv
X3N0YXJ0KCktPnJwcm9jX2FkZF92aXJ0aW9fZGV2KCktPmRtYV9kZWNsYXJlX2NvaGVyZW50X21l
bQ0KPiBvcnkoKQ0KPiAtcnByb2NfdmRldl9kb19zdG9wKCktPnJwcm9jX3JlbW92ZV92aXJ0aW9f
ZGV2KCktPmRtYV9yZWxlYXNlX2NvaGVyZW50X20NCj4gZW1vcnkoKQ0KPiANCj4gRml4ZXM6IDFk
N2I2MWMwNmRjMyAoInJlbW90ZXByb2M6IHZpcnRpbzogQ3JlYXRlIHBsYXRmb3JtIGRldmljZSBm
b3IgdGhlDQo+IHJlbW90ZXByb2NfdmlydGlvIikNCj4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpo
YW5nIDxqb2FraW0uemhhbmdAY2l4dGVjaC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9yZW1vdGVw
cm9jL3JlbW90ZXByb2NfdmlydGlvLmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9y
ZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMNCj4gYi9kcml2ZXJzL3JlbW90ZXByb2MvcmVt
b3RlcHJvY192aXJ0aW8uYw0KPiBpbmRleCA4M2Q3NjkxNWE2YWQuLjcyNWI5NTdlZTIyNiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMNCj4gKysr
IGIvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfdmlydGlvLmMNCj4gQEAgLTQ2NSw4ICs0
NjUsMTIgQEAgc3RhdGljIGludCBycHJvY19hZGRfdmlydGlvX2RldihzdHJ1Y3QgcnByb2NfdmRl
dg0KPiAqcnZkZXYsIGludCBpZCkgIHN0YXRpYyBpbnQgcnByb2NfcmVtb3ZlX3ZpcnRpb19kZXYo
c3RydWN0IGRldmljZSAqZGV2LCB2b2lkDQo+ICpkYXRhKSAgew0KPiAgCXN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2ID0gZGV2X3RvX3ZpcnRpbyhkZXYpOw0KPiArCXN0cnVjdCBycHJvY192ZGV2
ICpydmRldiA9IHZkZXZfdG9fcnZkZXYodmRldik7DQo+IA0KPiAgCXVucmVnaXN0ZXJfdmlydGlv
X2RldmljZSh2ZGV2KTsNCj4gKw0KPiArCWRtYV9yZWxlYXNlX2NvaGVyZW50X21lbW9yeSgmcnZk
ZXYtPnBkZXYtPmRldik7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC01ODUs
NyArNTg5LDYgQEAgc3RhdGljIHZvaWQgcnByb2NfdmlydGlvX3JlbW92ZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCXJwcm9jX3JlbW92ZV9ydmRldihydmRldik7DQo+IA0K
PiAgCW9mX3Jlc2VydmVkX21lbV9kZXZpY2VfcmVsZWFzZSgmcGRldi0+ZGV2KTsNCj4gLQlkbWFf
cmVsZWFzZV9jb2hlcmVudF9tZW1vcnkoJnBkZXYtPmRldik7DQo+IA0KPiAgCXB1dF9kZXZpY2Uo
JnJwcm9jLT5kZXYpOw0KPiAgfQ0KPiAtLQ0KPiAyLjI1LjENCg0K
