Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274077F7369
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjKXMHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjKXMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:07:16 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B7ED69;
        Fri, 24 Nov 2023 04:07:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP5whFPtlU7r+943G9T5Q5k94/5h2pQTT4ckaKpEny1YI9L4QFbAg054jLOuYNrpLL+113yTRn7+Txq5XnqVHl1wv+PMqz2u1R/jEfhjT+/FZigh6wodKOlggHitMJ2DFZRk4HHD5bHhlfrzGGSLSYjlaiyCPBzK9fup0wGagBbEqbW3QpfgmeSI+MCTdhVILuW2+eMCx+o88Tkr43N2pKtcvn0K/2peMDZ2j0I/YZluSrfQ0z5FSpDBNWB3uFrO1jKwngvmXw8PvnhYjXE9g4EKrPGfva3QMy/BQdusCK2XvfjH0i5Qqr0Sp/sSlE84+2alFAH+DV/WExUaE4IClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Roji+Ai3AUPKWj5LzrxrhNZUHQsXtR+Bv+GDxN+WL0U=;
 b=izRoPNbrKp8xNi7xUWhcPThEvDcf0hyO7Bdsbsz6ykwwouqZ+Ajki5cyt3+R3Aos+K6LUSGxNDqwB4ogw5Rx+b7FXCWNpi7dNZbGSgejyx4Tr2vbkZWoahSBuhbOIM5podTTW40ngwcd4EWuOxdmWPv7eckrXy/TO4V15UtMzAU9g2e9RVjf+pwG9s+vB1p0mmL+Ut8TLhNEm6APPmXist5LYaRszxKnNuBp86MrpBZWvOsZh2DUG60JkEm4G+XDHpKftRNjDJHQLexdp/D6PGYIMtcAEq4MTnv+fGZLUWm2AzxWqGUZqvUBN0sMEl7s4Fayw7+D5gi02dlaq1/tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Roji+Ai3AUPKWj5LzrxrhNZUHQsXtR+Bv+GDxN+WL0U=;
 b=xGL+6p5YtX+wspIgFLgdMIahnBo9Y97mKKH4yui8lNEOCEV4wdul5OBMMTmKym4iM0JTyKujEEUPn8MvxnuKemBQmKSnVYQuBPyBpU1RsT9txQeSzNOrdP2mhwYC192AmFBA56njyZUHNRi9A3LDHknR0BNsoG58yjOa68a7wN4=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 12:07:17 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::6397:2723:2d20:5d8b%6]) with mapi id 15.20.7025.022; Fri, 24 Nov 2023
 12:07:17 +0000
From:   "Sayyed, Mubin" <mubin.sayyed@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Thread-Topic: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not
 probe TTC device configured as PWM
Thread-Index: AQHaFvj4QMudblc/L0uc3zBCSY9LkrB6UCsAgACFcMCAAHYrAIAOELBwgAAKUACAAAFhEA==
Date:   Fri, 24 Nov 2023 12:07:17 +0000
Message-ID: <DM4PR12MB5938256CC0E50256004ED6B19DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
 <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
 <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
In-Reply-To: <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|SN7PR12MB8604:EE_
x-ms-office365-filtering-correlation-id: 0405fd71-f697-4bba-aefd-08dbece5e73c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: leW5OxwLUCcCXinqCa2+U9ZxHqsDgt9aZ0Mqi41TytrUlBpddJQ346u+QDaCV0e7FwG+NJasDwjGIEyesOguGZst4sLyIQHpXjRvlxJqsEb+e0Hb+HPMRlfogdDXCjuSvDX2E2wvjJgOeYGHjfxRz1QfH8GO+c2WE2Xr5A2+TyHhmn+S5lrdJLVGk+yueuVzPBoR/jJm8FZ+DS/YPjSZTGPcB5edvpJ4iHqw/JsrMz1FEWaJ+mneK0GzvkrsYBljqc+FJSQhvNxTt6b7WHXqoq52LLZ4D/LiKNHCOL1cvgnTcAekdd9A5P6RP9j72eDIZ/m+2NAb7Iek44lpXklJSlMSZ8YOKkd/d+HxRxd9JmuaTLWC2KyOYvwXD2ja5o2T8CroXx8+f/gZx+OcJ10N712Z6kmnkojFahaCHAtahPCkdNXiqdL71dP5thJjDyY3zZ66SeS9MGepKAUS28Edq88wH7bRzTiOZZjd9IQg3onRmU6QOPbgI9DrgBxvldeVemWF5fmvRUQld4a4DXRAbe2zgF/lYGVN8KlKrN3yUbAuGzvmuStW2HV9VQLG2RexodL4puSSvWrO0GlrKV7FTNefJshCePweWxwIZdS2/J4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8936002)(55016003)(83380400001)(4326008)(122000001)(8676002)(52536014)(5660300002)(7416002)(66899024)(66556008)(64756008)(66446008)(6506007)(54906003)(6916009)(7696005)(316002)(33656002)(53546011)(478600001)(86362001)(41300700001)(2906002)(66946007)(76116006)(71200400001)(66476007)(38070700009)(966005)(38100700002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzVsZjV3cG9vSS9oZlRDeFFaNmozVkk4bHdRbzUycEV6MnFaTlovem5kVHhU?=
 =?utf-8?B?UjRZNjBOTnhUdjQyV21GbWNPdjNrY3k2ZFNJd2dTY3BpeFdZNGRjVWxtS1Fs?=
 =?utf-8?B?aTRFbWdnbHVxUEZVU1Y5ZGQvLzRHbUgxWVFHaWQxNW5EQ3UyR3NoYllwTkcw?=
 =?utf-8?B?NEtxaFoyc1Q1b1JkQXhVS1pWS1RZakhnYlVWcmYxeWovc0RiUVpqRGdnbjg3?=
 =?utf-8?B?ZU52YlZSdGNtRXYxRkVLSGtuUy9iS1g5czU4VGRzczhFa2V5UUl0N1hHVmlG?=
 =?utf-8?B?Y2pvN0t3M3pvbnpHWG13dDlIZzJlZTI1T0NkbE8zdkphOFlUQzl0RFpxaGlj?=
 =?utf-8?B?RDBmWFBnMk9ZWEJZdmlIU0dSTmhzU1R3ZVYyZHc5OXd3Q0dEdzZnZ2dHZmpw?=
 =?utf-8?B?dmo5eHAxZG1PVTVEakJqQ091cDUrMWsxeGJxWHRGb1RVbzFWR2JST2ZYMVVI?=
 =?utf-8?B?Z0VHK1duUVI3RXNnakhtUU9lWUN4WWgrTzMvaWhxNWtaQ0o3T0VpWFVJM0Nm?=
 =?utf-8?B?NkNmc091REx6RzZ0ZjJzRThKZmpQOUd4YU42cjZ0L0JKeXZ3ZXNqMm1GRURm?=
 =?utf-8?B?N3RoUndESDVGUXlXWGo2b0JaRm1NcmF3eExuTFNXNWZaZkdzMVF2aDhjdS9o?=
 =?utf-8?B?ay9CQnZRbFNUcFhoYVc5RkFIaVlmZ2pmSVVYSmZvTkVPNWdQR1c4ekQ3ckZl?=
 =?utf-8?B?dUpvZ1BmZDEyZ0NqeEs1R1kwMWk5QUdsUnRjdXZKQURGWERJOW43ZlZVNnFw?=
 =?utf-8?B?NmNuMXdBZ2xmQzhMcUsvYmFicWcrbzBZVnR2RzR5Rmdla3JTQlJVcy9pS053?=
 =?utf-8?B?dG5zVms1emwrU1hWWEtSREcxNWJiRzk5bFNjc2ZMVWpXSnZpcUlsOE5lN1VO?=
 =?utf-8?B?VDZxa0RoK0h2RnUxSHR5K1l1OHM4bUo3OEt6V2tqZ20rSXo2eXNTWEgzZzJi?=
 =?utf-8?B?Z1dxd2o4MkZvZ0hadmtUSDBKcDcwZ3g4Sm00Y0lvbDE5d3hUMEE1K3JENGc4?=
 =?utf-8?B?ZzIrakRzS2RRZFR2eFVUeUFjUGdtSmJoQUtJT2c4KzRoZVpRWkZkcC9lcXkw?=
 =?utf-8?B?ZWV5a3FvSkFXNzFDdjU3L3hsZHRlU0I3WnVsd1N0K3ZiaFlmc3I0bGN1Vk1l?=
 =?utf-8?B?YWVVbTc3U3gzYTVhRTk4c3pLb2l6S25BeExEK1VoTjRUNGI1dnAwdUdDWkVM?=
 =?utf-8?B?YUhZMnlLTDZtMHZRM0Z5eGlDTW83QXE0Q01iTmhCNEc2OVVFQTdJK0U4Qlgz?=
 =?utf-8?B?aDRsMmpkS1JNMGNndEljb0JxNFh1c2JCWGFRb1dSa0RuNmNhdnZseVUzdWRH?=
 =?utf-8?B?dnQxSmcxeDBnaDFXSVczSkI0LytPeFV2WXVCRmJ1T0R5YzVEZ1IvQ0o3V0RH?=
 =?utf-8?B?OXdNcldwQllYNTc5UmtqaHJMOVUrSzZKY2dDTHRLOEFOSTJ3MjZiU1VrTVQ5?=
 =?utf-8?B?cmVkRkVDVmduWTUvSEtueVFEZkdqZEhNUy8xQVRBQnZubzVqd1M2NnlHaSt5?=
 =?utf-8?B?ZHM3RjF4M3FJRmZBMGxBTXVOZCtPaHRLMHVxbkI5eVZzckFGOHNxcGVRTU5Y?=
 =?utf-8?B?S2ZLSkxjY2VRU0lMTGwxbEN1NXp0WXkxYko1aXJyQi93OS93QnRSamFmSkFU?=
 =?utf-8?B?eW9oQ09ZTjF6WUZNR1ZPVmtNQXNqQjQ1dzdJdVFWVk1aL3p6VnB3S2hJQzFt?=
 =?utf-8?B?TnZjV1ZLQW1aWDB2NDVVRWNGMGNlVVdoTU5uVUZrY3ZYakZhYUhNbnBKaUdh?=
 =?utf-8?B?b3MvdWdpYVFPelFhRGhUeHpqTUthTWZETTBUZXJ1SHR0MlVmdDRheUd4M2VF?=
 =?utf-8?B?K1VibHluYWg0WTVDMGZrcE5Bclc2WnJQOHRTVE1FeGZrRkVnWS9WbmRjdWFr?=
 =?utf-8?B?NlB6MFVrSkt5MEEwQnliUUpSVjF6UlNqVWNPcFI2Yi9HZ2RLbzFSN2NpNlAr?=
 =?utf-8?B?d0pnS3QwbC9xU2UzamdlRngyeFNZa2lBYjBvR09FR0pQUVRvSXJGWDVJaG5V?=
 =?utf-8?B?YlE5QTVFZFh1MGFJV2tyR1JGQkF1NTFEK2lEYUJYTHJrZDhLaFJ5ZkQzSUFG?=
 =?utf-8?B?U21acXJtVVlLOU41a2lSQXlWQzBzNWpTSnJWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0405fd71-f697-4bba-aefd-08dbece5e73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 12:07:17.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6elMXnQ0G9rY4cieAThv+bZlqeQ1IBvC6xjuQEjMnOOhhBasQk2iGfPjdFenyKPgaLfSQxADKXyyLOhF4fMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXks
IE5vdmVtYmVyIDI0LCAyMDIzIDU6MDYgUE0NCj4gVG86IFNheXllZCwgTXViaW4gPG11YmluLnNh
eXllZEBhbWQuY29tPg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54KQ0KPiA8Z2l0
QGFtZC5jb20+OyBtdWJpbjEwQGdtYWlsLmNvbTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOw0KPiB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7IHRoaWVycnkucmVkaW5n
QGdtYWlsLmNvbTsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyB0
Z2x4QGxpbnV0cm9uaXguZGU7DQo+IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IFNpbWVrLCBN
aWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW0xJTlVYIFBBVENI
IHYyIDEvM10gY2xvY2tzb3VyY2U6IHRpbWVyLWNhZGVuY2UtdHRjOiBEbyBub3QgcHJvYmUNCj4g
VFRDIGRldmljZSBjb25maWd1cmVkIGFzIFBXTQ0KPiANCj4gT24gMjQvMTEvMjAyMyAxMjowMywg
U2F5eWVkLCBNdWJpbiB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVt
YmVyIDE1LCAyMDIzIDU6NDEgUE0NCj4gPj4gVG86IFNheXllZCwgTXViaW4gPG11YmluLnNheXll
ZEBhbWQuY29tPg0KPiA+PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPj4gbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtWGlsaW54
KSA8Z2l0QGFtZC5jb20+Ow0KPiA+PiBtdWJpbjEwQGdtYWlsLmNvbTsga3J6eXN6dG9mLmtvemxv
d3NraStkdEBsaW5hcm8ub3JnOw0KPiA+PiB1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU7
IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsNCj4gPj4gcm9iaCtkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+ID4+IGRhbmllbC5sZXpjYW5v
QGxpbmFyby5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiA+PiBT
dWJqZWN0OiBSZTogW0xJTlVYIFBBVENIIHYyIDEvM10gY2xvY2tzb3VyY2U6IHRpbWVyLWNhZGVu
Y2UtdHRjOiBEbw0KPiA+PiBub3QgcHJvYmUgVFRDIGRldmljZSBjb25maWd1cmVkIGFzIFBXTQ0K
PiA+Pg0KPiA+PiBPbiAxNS8xMS8yMDIzIDA2OjU1LCBTYXl5ZWQsIE11YmluIHdyb3RlOg0KPiA+
Pj4+PiArCS8qDQo+ID4+Pj4+ICsJICogSWYgcHdtLWNlbGxzIHByb3BlcnR5IGlzIHByZXNlbnQg
aW4gVFRDIG5vZGUsDQo+ID4+Pj4+ICsJICogaXQgd291bGQgYmUgdHJlYXRlZCBhcyBQV00gZGV2
aWNlLg0KPiA+Pj4+PiArCSAqLw0KPiA+Pj4+PiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wo
dGltZXIsICIjcHdtLWNlbGxzIikpDQo+ID4+Pj4+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+Pj4+
DQo+ID4+Pj4gWW91IHdpbGwgaW50cm9kdWNlIGRtZXNnIGVycm9ycywgc28gcmVncmVzc2lvbnMu
DQo+ID4+Pj4NCj4gPj4+IFtNdWJpbl06IEkgd2lsbCBjaGFuZ2UgaXQgdG8gInJldHVybiAwIiB0
byBhdm9pZCBkbWVzZyBlcnJvcnMuDQo+ID4+DQo+ID4+IE5vLCBiZWNhdXNlIHNvbHV0aW9uIGlz
IHdyb25nLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+PiBUaGlzIGRvZXMgbm90IGxvb2sgcmlnaHQuIFdo
YXQgeW91IHdhbnQgaXMgdG8gYmluZCBvbmUgZGV2aWNlDQo+ID4+Pj4gZHJpdmVyIGFuZCBjaG9v
c2UgZGlmZmVyZW50IGZ1bmN0aW9uYWxpdHkgYmFzZWQgb24gcHJvcGVydGllcy4NCj4gPj4+IFtN
dWJpbl06ICBJIGFtIGRvaW5nIGl0IGJhc2VkIG9uIGVhcmxpZXIgZGlzY3Vzc2lvbiByZWxhdGVk
IHRvIEFYSQ0KPiA+Pj4gVGltZXIgUFdNDQo+ID4+IGRyaXZlci4gIEl0IHdhcyBzdWdnZXN0ZWQg
dG8gdXNlICNwd20tY2VsbHMgcHJvcGVydHkgZm9yIGlkZW50aWZ5aW5nDQo+ID4+IHJvbGUgb2YN
Cj4gPj4gZGV2aWNlKFBXTS9jbG9ja3NvdXJjZSkgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtDQo+ID4+IGRldmljZXRyZWUvMjAyMTA1MTMwMjE2MzEuR0E4Nzg4NjBAcm9iaC5hdC5rZXJu
ZWwub3JnLy4NCj4gPj4NCj4gPj4gWW91IGFyZSBtaXhpbmcgYmluZGluZ3Mgd2l0aCBkcml2ZXIu
IEkgc2FpZCBoZXJlIGFib3V0IGRyaXZlciBhbmQgeWVzDQo+ID4+IC0geW91IG11c3QgdXNlIHB3
bS1jZWxscyB0byBkaWZmZXJlbnRpYXRlIHRoYXQuIEl0J3Mgb2J2aW91cy4NCj4gPj4NCj4gPj4g
U28gYWdhaW4sIG9uZSBkcml2ZXIgYmluZGluZy4NCj4gPiBbTXViaW5dOiBJIHdpbGwgZXhwbG9y
ZSB3aGV0aGVyIG1mZCBmcmFtZXdvcmsgY2FuIGJlIHVzZWQgdG8gaGFuZGxlIHRoaXMuDQo+IA0K
PiBZb3UgZG8gbm90IG5lZWQgTUZEIGZvciB0aGlzLCBiZWNhdXNlIHlvdSBkbyBub3QgaGF2ZSBh
IHJlYWxseSBNRkQuIFRoaXMgaXMganVzdA0KPiBvbmUgZGV2aWNlLCBzbyBJIGV4cGVjdCBoZXJl
IG9uZSBkcml2ZXIuIFdoeSBkbyB5b3UgbmVlZCBtdWx0aXBsZSBkcml2ZXJzICh3aGljaA0KPiBh
bHNvIHdvdWxkIHNvbHZlIHRoYXQgcHJvYmxlbSBidXQgd2h5Pyk/DQpDYWRlbmNlIFRUQyBJUCBj
YW4gYmUgdXNlZCBhcyB0aW1lcihjbG9ja3NvdXJjZS9jbG9ja2V2ZW50KSBhbmQgUFdNIGRldmlj
ZS4NCldlIGhhdmUgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jYWRlbmNlLXR0Yy5jIGZvciBj
bG9ja3NvdXJjZS9jbG9ja2V2ZW50IGZ1bmN0aW9uYWxpdHkuIA0KTmV3IGRyaXZlciBmb3IgUFdN
IGZ1bmN0aW9uYWxpdHkgd2lsbCBiZSBhZGRlZCB0byBkcml2ZXJzL3B3bS9wd20tY2FkZW5jZS5j
ICgzLzMgb2YgdGhpcw0KU2VyaWVzKS4gIEluIGdpdmVuIFNvQywgIG11bHRpcGxlIGluc3RhbmNl
cyBvZiBUVEMgSVAgYXJlIHBvc3NpYmxlKFp5bnFNUCAgVWx0cnNjYWxlIFNvQyBoYXMgNA0KSW5z
dGFuY2VzKSwgZmV3IG9mIHRoZW0gY291bGQgYmUgY29uZmlndXJlZCBhcyBjbG9ja3NvdXJjZS9j
bG9ja2V2ZW50IGRldmljZXMgYW5kIG90aGVycw0KYXMgUFdNIG9uZXMuIFNvLCAgY2xva3NvdXJj
ZSBhcyB3ZWxsIGFzIFBXTSBkcml2ZXJzIGZvciBjYWRlbmNlIFRUQyBJUCB3b3VsZCBiZSBlbmFi
bGVkIGluIA0KdGhlIGtlcm5lbC4gDQoNCk5vdyBpbiB0aGlzIHNjZW5hcmlvLCBlYWNoIFRUQyBk
ZXZpY2Ugd291bGQgYmUgbWF0Y2hpbmcgd2l0aCAyIGRyaXZlcnMsIGNsb2Nrc291cmNlIGFuZCBQ
V00sIHNpbmNlDQpjb21wYXRpYmxlIHN0cmluZyBpcyBzYW1lLiAgSWYgSSBkb27igJl0IGFkZCAj
cHdtLWNlbGxzIGNoZWNraW5nIGluIGNsb2Nrc291cmNlIGRyaXZlciBhbmQgcmV0dXJuIA0KLUVO
T0RFViBiYXNlZCBvbiB0aGF0LCBlYWNoIGRldmljZSB3b3VsZCBhbHdheXMgYmluZCB3aXRoIGNs
b2Nrc291cmNlIGRyaXZlci4gUFdNIGRyaXZlciANCndvdWxkIG5ldmVyIHByb2JlIHNpbmNlIGNs
b2Nrc291cmNlIGRyaXZlciBwcm9iZXMgYWhlYWQgb2YgUFdNIG9uZSBpbiBwcm9iaW5nIG9yZGVy
Lg0KDQpJIGFtIGV4cGxvcmluZyBtZmQgdG8gZGVhbCB3aXRoIHNhaWQgc2NlbmFyaW8uIERvIHlv
dSBzZWUgYW55IGJldHRlciB3YXkgdG8gaGFuZGxlIHRoaXM/IA0KDQpUaGFua3MsDQpNdWJpbg0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
