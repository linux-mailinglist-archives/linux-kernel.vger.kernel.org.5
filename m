Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB107CC533
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjJQNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:53:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2127.outbound.protection.outlook.com [40.107.21.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA54EA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt/sy5yKUw8WyeKupctBziYm8H/77ii8oMcASEi9x3GX6HgEc3LJqltBew4ZkHtxSreXC2ZLMU3AutGTA9XB53iKOENBjy2Wk7EiDFEow6XC7I/Vc91jXMTDj+q1dbDka/659i1P5U4BqRpn2mx68CzGfVe6qDMt+/jlcq3i+Njze4HXBQFOSwoZ6/1liMSwVea9EKSE0KtKK/Ul5F2jocA1u6PwaF5DMjQ9qYnkJK5Zwv9lZeOk1N0Z1DgStUPMgPWusWb/XRIySCIv32h6K9jZwe/va8RgRl5dU8V5vH34IaFwol8SA8x7VDaePQKwVbH+TWR/Cvnq605w2I+upA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFy73AXfWacVVRYIRkruO4pm9FGMmyQCdGh/nQNJKyI=;
 b=D4Zm0kJZIbyaKSzP3J4ynu7ueHoZBehOAWvsZr2KS+d1wm3yuk4I2fwODiH/GsYVX9Xbm2zGlkDL0rwh2PWZDGK8uZc5f9PsU2Sii6fChI6dH4iPUmjbqZCvDAFFZc4s6LrmwVM8e2qJafxs93g3eRnsmH7/BlgXzgrh8tsZ3xv/m2QKrNZUFK9dcUtrhyntJfUQgqoCOkYLP3vB/GhZfBVFvdX67yYr+Z8VmHIHzSslPp5MeYCio90hsXWJfJzHqJaiQziY1NFbv2vtVkbJXDP28zdFORidHx1tjtbSg0stscT/9eLpu9nDR0RJ7f1N5lgacXr6Tsmp9geKvAHoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFy73AXfWacVVRYIRkruO4pm9FGMmyQCdGh/nQNJKyI=;
 b=X/DbvP8QNIyNEdQ3bpIThtYlojNo0RPNGdWotma7wUVkFIL5mQKAELCroIEYePwOPIoYDATVDzBYahjH8bfvle6c9zVzbNSgbUSCTK3NVR5mt9XQ85yUCDP+wI6oMNrzwWG6S6LtfZEHRY2vJaUx3nZiEbgdVAtzRBL51HhL+AA=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by DB8PR06MB6505.eurprd06.prod.outlook.com (2603:10a6:10:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 13:53:01 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::c2f3:e304:fe49:3514]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::c2f3:e304:fe49:3514%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:53:01 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4CAPY5YgIAvS6uAgBWqFYCAAEtqAIAACFeAgAAKcICAAUdUAIAAMwOAgAAD0ICAACfxgIAEEGaAgAs50wCAAXS0gIAAZIKA
Date:   Tue, 17 Oct 2023 13:53:01 +0000
Message-ID: <67d7e64e-5fea-f772-e654-34f2c41c93d6@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
 <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
 <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
 <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
 <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
 <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
 <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
 <2e3ce75d-7e2d-4e62-8660-48a41074c20c@linaro.org>
 <fd6b5e43-7e90-b98d-79be-0c65840ec433@leica-geosystems.com>
 <5a488a21-596d-48f4-bfdc-28b206542563@linaro.org>
In-Reply-To: <5a488a21-596d-48f4-bfdc-28b206542563@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|DB8PR06MB6505:EE_
x-ms-office365-filtering-correlation-id: e6082692-5653-43a1-2c00-08dbcf1860d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqQqbg4VehOVWrGEA4rEp2bByrR9tdQsnnkv0CyPckZbxL3xJSDMcIScNB6vsMtYK2zy8P29S8mf/n9hTyD0hoCsqgdkS/OK6WfkynQPabL3UJ/4QdhU2TVcymC4LFobDBapPRo9gqjci8Qd2lhOlgb+9OCBkL//7yuCQdcK1/n0WETC34YM6CvP1dWpPFfMIL0nGaQLEYZdVCpEzXPdIJf9eTu3AAviXZ9aPBUtnRP8bXPXdchhS7270oVRN+SQ9QGSiaKbmJkXgCRNsIC02mQPjkyjaxT4Q4nRg9FY3xwnWFNcxdrdz+z0YhlIEVOAGokPE4QmANq8vQL7vXBfYG3B/dcnD1v7MO8/djgtNmXr7K/xUf6bQ2knT07Ygbd6jI2844ad+9bVFrtqhZDH4YCUaRMR7fqaoNQSlPSz0qiKY386/BfFIYaxfUIf7fX904F4hYRHV4OHxsnQGoNcNwF+su0TlSz60CK/6bxg5jP1m/IdsKPmWEZv3pqcSRc2Fbfw7oBOGzh1Z26xVbk9zTi/WKkDU6svVnKplcjLP77DtH3ZYUeaACdskbhGIHNdw7/7oqyxAYw/VgqR3UK9v6xEqrd6IvJvi0kvC7cBYJgQaB/ChytM6a3Ge8RsRoXPKnVTeivQGZsCRJeF7RLZKGsvy8LL4WnJQnA7dodmATU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(2616005)(107886003)(53546011)(6512007)(478600001)(71200400001)(31696002)(26005)(31686004)(86362001)(6486002)(966005)(110136005)(4744005)(91956017)(2906002)(38070700005)(5660300002)(41300700001)(66556008)(66476007)(66946007)(316002)(122000001)(66446008)(76116006)(64756008)(4326008)(8936002)(8676002)(38100700002)(36756003)(138113003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGYxcUF3cW5EKytXM3hpOVNia2g4dHBIZWdNd0x3bDdLUWJkblhSbWVIRFhk?=
 =?utf-8?B?Vkh6NVIxeHAvRk1VRzlQSVRzdmdGcVMyZGI3VUVmZ0c0S2NIRDVkVDhRbmFt?=
 =?utf-8?B?cVVvU3BQK1h0V3FxUDFqNDJONzlrU0FOWFFEaVY0U05TTmNQeW5RRWZHb0s2?=
 =?utf-8?B?NzMxWCszUkhRandlNlFtQzVoanNMcko0RldrdjNLalVsZmNyY0xEdENucDJl?=
 =?utf-8?B?WFBiSHliS0NvQkZJUlBITzgyaVkyaWVsKy9kRVJEc2NFZkJoeDl5UjMwRCsz?=
 =?utf-8?B?MS9GbStXTEtFQnZ4Q2pHaHhCa2tJeWI4REZpZzBnUG93Y0FnUExiUU9NTFNa?=
 =?utf-8?B?UWIzanUxMW1tT2lVazFNcTQ1VTBvQy9MWmQ5SzZhMmlUYlZ6WmROcVFML29o?=
 =?utf-8?B?RCtEbW8wSE9XT09oNEJ0UFFVUThDWGt3M0hpWEx6bU84K2JIekhNZ1FsSTVz?=
 =?utf-8?B?MCtlcHhkL2xhbng1VXZDeVMwUTJ6U2hTQUVjb0tVUjExWTQxdm0rOW15TmtP?=
 =?utf-8?B?TG95TUFZcmdZdUtLcWI5N3NHMVdBb1dObTV1K3RHZW1HSkRibHcwMVB5SFRV?=
 =?utf-8?B?Z2ovdkR5TUVTMUduUWdKdTZYMzhkTlpUL2lmZExKenpra3d3ZnBhcnp3RW8w?=
 =?utf-8?B?dkVjdWh0aUhGSUdQM2FGSEdWS2ZrRHBsbzNNUEUvZnM5Q0o2bDVZZ0p0dlBv?=
 =?utf-8?B?aVpaWkNjbEhaRmdlZThydFdVcEVScmgrM3crMFNwTUxVYVJiZDJqZTdteHFn?=
 =?utf-8?B?alg3WWlRbXFoOGUyMXkyQTRuY0ZwZDFjQnVDQ09XeXQ1OFZodG0yMlY4NEVL?=
 =?utf-8?B?VkFUSGRORExmVzB3TjlEbE5UYkhqWk83Y3ViRVYxUGtoYlRuNTJDdk0yRU8x?=
 =?utf-8?B?c0F4VVVmOUxOM1VZRVpFMWRKdnY0NGphU3UwNVdteW1iTEpCRGozK3BTU044?=
 =?utf-8?B?dTg2TjlnMlIyeHFPdDJaclRLMFdlOHliWWtnUC9lbE51TlpiZmF6WnRQMnVy?=
 =?utf-8?B?eVFHVE53OUhmeHBrZmpqczRHYUlqeVZrZ1BHMEJIREl1UVZ5UDVjd2dQdjRv?=
 =?utf-8?B?anAyRGxYQm9TTkpGTVFzb1R2K3NmWVJVZ2VsemhiUTZSekxMN21IM3daWkdn?=
 =?utf-8?B?ZmlreFluOU00N1I2dGpjd283a0tab2g0a0g1VzRhS1FGNnRSOGNZdGZ5ZEpD?=
 =?utf-8?B?TlF5NWVSdjJCSU10Y0ZVY0Z0NkRpMVRzVmFNbmNyOFVJcjFQS2krUmU5Mi96?=
 =?utf-8?B?U0NjL21LNSs0cGJVaEd4dnVFbXZSVVAzK1ZMazNHYzVIWjNlVGg4ckx0ODZ6?=
 =?utf-8?B?cEl3dnZib2FRZXZNaEVSSU04WEFWa3dVd3FCVFUrc1BjK1RVWHdObnJ0Vitz?=
 =?utf-8?B?a0xXb3FSd2tVWDRka2JNT0k0NmRIaFZrQXBFK0lGYlF3cW8xNlpuUDkyMkNj?=
 =?utf-8?B?azNDR2JrWnJCQjZKdG4xOTZDMTk0RnVtV08rQkswSFpkdU5ReVUxN1N0ZzFu?=
 =?utf-8?B?WHdGT3YyZEhJWWFET1l0aHRRcHFrNXpnVU5YSVlQOFhmeC85VndRVjBrNStW?=
 =?utf-8?B?NnJuS3dFeTRJSUdDdXRBbFBicmxuejJoN3RVWWRBcFdZbmRGQ3VYemhDMDV4?=
 =?utf-8?B?MDdmNEl2Q0FUY001cTA1U2Q5Y0VDbVZBVk9NTTV3NUtRQlcrU2NEL3FybHdF?=
 =?utf-8?B?Yk5oLzVBaXV0UGliclBERzMrY2xIYktpQ1U0ZThsUGhpSWw5aVhTd20xRTkx?=
 =?utf-8?B?MHpqazYwRnY4bGxWTCswZm5PNHlLT214N01OU3kvQ1ZIYTd0Z2RwbDdiWHd2?=
 =?utf-8?B?MGVaWnNXTXZyays5NnZIMDZtTGZHbVlXdk5TM0d1WVpDQXQwVkhFMXdmVFJP?=
 =?utf-8?B?aFBIZ2lFcnJibDkvOENlVmZEM0ZvdzZPdGI3WmZuVndwd2dKQ0FBNlRJNldX?=
 =?utf-8?B?bWdEMk51d1hUL1VkcS9MWVRKbisxVldEekU2TEpZaWl5V3RWVEY5QVhVa09o?=
 =?utf-8?B?a2EyMlVSalRRM1NVeSs5NkdvWjBIZmpqRGhZdS9DdlNXVDF0VnRmMVlZc0Rt?=
 =?utf-8?B?bnRWMmNlVG53bXZWNW03QTVHbEtVQktjL1FUbkdZWm1DVS9UK3ZRVG1qUkk4?=
 =?utf-8?B?UkxGSmx5ckdKMURXQ3kyS1JUMEdublhZNmFwNUlnYW5LR1hnV3JhNmtoVHBT?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E03E801818A8E40BF363886511BF855@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6082692-5653-43a1-2c00-08dbcf1860d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:53:01.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1T8fYCHg79RTqTK4pYzY6DuIJO1tiXj9LwulthqlIrIWBr69ZWLm2JEHCj6rfhfNYgW/hsY2hu7YnWR2sPkgudEI2xAcFNIitc+mE6JRi4/ZKaLsyCyodiSOM3s0ahu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCk9uIDE3LjEwLjIzIDA5OjUzLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0K
PiANCj4gSGksIFNodWtsYSwNCj4gDQo+IA0KPiBPbiAxNi4xMC4yMDIzIDEyOjM5LCBTSFVLTEEg
TWFtdGEgUmFtZW5kcmEgd3JvdGU6DQo+PiB2MzoNCj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvcHJvamVjdC9saW51eC1tdGQvcGF0Y2gvNmI4OWFlNGU0ZDdhMzgxMDUwNzQ2NDU4Y2Iw
MDBjZDNjNjBmN2E0Mi4xNjk2ODQ5NDIzLmdpdC5tYW10YS5zaHVrbGFAbGVpY2EtZ2Vvc3lzdGVt
cy5jb20vDQo+IA0KPiBJJ3ZlIGp1c3Qgc2VudCB2NCBvbiB5b3VyIGJlaGFsZiB0byBzcGVlZCB1
cCB0aGUgcHJvY2Vzcy4gUGxlYXNlIGNoZWNrDQo+IHdoYXQgSSBkaWQgYW5kIGlmIGl0IGxvb2tz
IGdvb2QgdG8geW91IGxldCBtZSBrbm93Lg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbXRkLzIwMjMxMDE3MDc0NzExLjEyMTY3LTEtdHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3Jn
L1QvI3QNCg0KVGhpcyBsb29rcyBnb29kIHRvIG1lIQ0KDQpUaGFua3MsDQpNYW10YQ0KDQoNCg==
