Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5B7E3F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjKGNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjKGNGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:06:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA74271F;
        Tue,  7 Nov 2023 04:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699361791; x=1730897791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ns/uQDrquxDt+t+aIRYo9mHOAE6TOL7Hg6iB98du2FM=;
  b=j18lpeiYQFDPmDmRyincEc1d4+Gz5qP0K/pI9UrhqRTjhotvfqXnz61Y
   SCbXVLiGnq30shOiNXTJSPLCVt/hnXJav3Bsf7zaIERW/YZAnYhA9TyMw
   olOr5ZVvpQlbTqKJuOaNiU6i0o/KpjNN+ud2pehAVFuHDjY+NTzDPEYtZ
   YvCfCTODxTG54//VttvibTVkjjZR9VZTv8jhSN1s904MnkF/lWx4CeqxV
   t+Gu/AL2b1dWmNogmP+lpnCjNgwMh+5MgwW1gDIEm96vstPAMdxhj0PQi
   gBkPKql2BrU37kpW0YFWtoGoxoCvUzACWm9Gc3DRHkpuNTTf+GcKh9HHo
   A==;
X-CSE-ConnectionGUID: 6Ruc56LURVyFt7K2y3geEw==
X-CSE-MsgGUID: 0utXEaQyRPyI2XLgL5eSNg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="11918187"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2023 05:56:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Nov 2023 05:55:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 7 Nov 2023 05:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyxWfl5iLcvzuW5mK9mgHK4HlDL3GPGdZtITYxkdzL9qCVu8gw4Yc1538pgc786dW2Dvx2zrZx4maTDmorJQiiK3m3OAFfPY4pPDF3FimXTGmry3IA3pLFjQ3q3GreQM430uHZzqcoRpDfNwmCWlIEsA6WGNapmBvF88ROZqchWuzuGk8Qh/YubR3cd/1qSLLXNkpYvcydDigSgHSnV9O52/Npr3pbe4UDvWmSC+oFzP78Z5WKuVYxtuWUd1kCWHKsFHOdtBEf2vzQfeOsDl3qwDlv6SYXOF631So2+sLuZcL7I6+gN4Oj/37G6cY9j/xvUxwmSgapyUsB1jB+HzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns/uQDrquxDt+t+aIRYo9mHOAE6TOL7Hg6iB98du2FM=;
 b=M4SgEZQOfJXe8OF8CGforKCO8MoP6KBDfiBAp7iI2XaTRrgmMqQxG2/baSnulCl4z8iMg2W/aYK/Aqw8agwa69KPeCQ1vhV5ZFYr3NBqew/FwomdWhtyy6urnh0zzDh7ISRWVRUuspLR9cxyDPt5nyDWdKNVmcA1Bskp4iq88/5TEcecGmu1UQv7roOXMbnZ7ZrfdoqZpHiagK/6PnYbJWwKdttip+iuo1NfR29pheTR0FBbYzotczGtm7VA2oWuC0eRweUZVTRt6qo6zQQkVQbZ50yAzqCtfE38yL/pZdoul1bWwb3AWQnOPOuDDCNXMqgPnYXWwtL/xrTwEyJdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ns/uQDrquxDt+t+aIRYo9mHOAE6TOL7Hg6iB98du2FM=;
 b=ZV49tGqpCFdSsUPpEPReVF7lZGydrRxs8tTEvZhVFAYO7LqgzeYmIe2+yFPoOJylFilSVgple9RIthxJJePlE4cjWXHd5I6be56+7JWqbDN26LwvC0UopVs4KnvNG+ofRrRKPJQUHytiXgHCu/rg59rZep6aAYLbNBjgc+yHFwM=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:55:48 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%5]) with mapi id 15.20.6933.029; Tue, 7 Nov 2023
 12:55:48 +0000
From:   <Marius.Cristea@microchip.com>
To:     <rgetz@mathworks.com>, <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Topic: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Index: AQHaB0llG35Muzqel0+JxBePU2newbBdwweAgAlgIACAB8G6gA==
Date:   Tue, 7 Nov 2023 12:55:48 +0000
Message-ID: <710b749db585689eb959ccc00a0230a5059b424f.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-3-marius.cristea@microchip.com>
         <20231027161813.7bff8866@jic23-huawei>
         <BYAPR05MB4424FBC5CFF90F55198C4351A9A6A@BYAPR05MB4424.namprd05.prod.outlook.com>
In-Reply-To: <BYAPR05MB4424FBC5CFF90F55198C4351A9A6A@BYAPR05MB4424.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|LV8PR11MB8747:EE_
x-ms-office365-filtering-correlation-id: b73dd834-1eac-41a7-eccc-08dbdf90dd52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRHPACbUlA8GS7IQeKJNKGezOqIXQhpESLkWX0XVZjYgKSBA6lR4Mh5e8h8qIhKLsy1RyXTXswZjx/5fyBqLyNYpOMxmumVOo6cCa8/VyNLiI+V7HO1sZJtyBOXYxDXJPC6omdwx4jb3NcE57tcahUqO04YKmdWUjq12uw4+Z9QsTxC3HNrFvXj9soe2cgoeQYx/ZxGvgaEp/m0DD1qivhLeMw2oF3qJp11aDuAm0ra9ntzbIy4AANOAZk9p3tMT8A/6fjsq7NxHmZGQJWleiqvR+2ms6000XoYVFm5+cpu3WL+8AGGkKJ6flcLnAIC5dDYTNljexzsn6wmRvacIIMpaHYIrOzebs+zKdRLJonjVlTH07Fia6UIDxcoXqgE/mc7Ai4ZdKZp4XvQ1LOR0ngUbUhctuavxQ2Q3c+w7ieP0Yo3Ann1wtyKKpm6RsorwQj8Hc9X3IPS8Ac4aDSbQTx41VFU4h5OEHr4iOfHGewd7rxUKNJ8HIDXmwlMr5ePtS7ObJHUONx+AMAcn53OcqslpkEvc8+v0Qig1AWy/hYj4W/N0s6Ygfx3Y/CFZs9VKVkaOUC0kf6irablB5Saw5jO61JHr2++hEuBIbqc0eflHHc4wopPi0Q3iUID725yfytMY4nfl3Mk/xf2W4z3rYGZtMDCyBRvGpC4YChKCDTuw6U4+3EpleSohxHLOMWyWGFqKd6+yxs4vy0g5eIRcvzPQqePKsHmx8RWp0ofmUsXEfawq7/hIWC+WT0UHPoYd8HH+iQke6yoKwKPlOzsmaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230373577357003)(230473577357003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(83380400001)(53546011)(6512007)(71200400001)(26005)(2616005)(6506007)(66476007)(478600001)(66556008)(66946007)(4326008)(316002)(76116006)(110136005)(91956017)(8676002)(38100700002)(54906003)(64756008)(36756003)(66446008)(8936002)(122000001)(2906002)(41300700001)(86362001)(5660300002)(966005)(6486002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0tXYXd4RnVETnlKRU9ieVRqSkI3OGpTUUxseGZBMmc4OTkxckp6cmtDRytX?=
 =?utf-8?B?OFJMbTgwQXA3Yk8rQm9HSzJPcFJycGc5cEdFd3YwNUFoMWpJN3lRdWtGT1dl?=
 =?utf-8?B?Z2FXeXJ6cVh4S3dyWm5xQllxOURTeDBCQmFobEJFSFVBNm5QN3JiZmo5dlU0?=
 =?utf-8?B?Uk9QcXl3a1V1QWEvTlRUU3hvdUV1c0JWZUsyZzRsT2dOWEM4UEh1QjhRWnZO?=
 =?utf-8?B?OVVmUWgzZ0V2ZEg5aDhDaTcxc3ZsYVBjOCtPRU5hVWwyMDNOb2p6d1VYS3BH?=
 =?utf-8?B?Sm9KRkRDWWtkUkxYdDc2bmNBSzRHTlF6RnBkYnRNWm1sZ3R6eTVRZm15N2NQ?=
 =?utf-8?B?TzJKcXkxeWpGY05hQnB3dDNNVHZCT1NxODVXTnpoejdHcVNpZ0hodS9uUS9u?=
 =?utf-8?B?bmtSOHUwSEl5Vkk2UTBBVUhwZzQ1TWxrdGo5MFU4a09nY211cEZWQ25VSGxQ?=
 =?utf-8?B?bkRKcS9jakQrbllwZEd1LzUyeWhwZllkLzlUbEtEZVM0WXJYa21NdHRFOGFC?=
 =?utf-8?B?YlhDNGNNeWdLVXVmMzJhWUd5RjA5WEUwWU16RUdvQ1lubS9keW1jVGwrQUx1?=
 =?utf-8?B?VHBtb1BXUXNPRG1MSFF2Nk1tM3h3a1c1U1VTVHorRFR6cG1EbEx5S3Z0ZXlp?=
 =?utf-8?B?VjRDZmtoS2tFOWtURE9WNEhJR1lxU0ExY29KbnM3UXpJYWRNbDBlMW5sdEhl?=
 =?utf-8?B?QTRrOVhOV1JUN0JKTzdMbEp6U25UdlY3S3BJR3c1bytGREdkT3crcGdLR0dp?=
 =?utf-8?B?SVdidVRxQ1diaEJGYW1mZGlUQzMzc0pLeWNodkJ2azZTZTNNU2V0TmhBVzF3?=
 =?utf-8?B?amJ4U3ZrZ2dWMUFTMEFkeEhjMXNleUNFNkE1Rlo0ZmltZ29qbWFpdGNaTHB4?=
 =?utf-8?B?QUpZSXdvbnhlYzArcEN5US9iQWJJQ3FxR3lmcm9BRDBZUCtQL2pPWHp4QTh1?=
 =?utf-8?B?eTdGUktHcHEybU90WE04endjaTN6eFBoVGJSemhXbks5dEtpandNb3BGNEQv?=
 =?utf-8?B?RHdWTWx4RnBKVFE4MVpRUlNBWVhEWGhmM2s4dEVXS05LRVhjTVEwVkNLS2Jz?=
 =?utf-8?B?R1E3ci93Sk95YjA1QThxdzVpMk92UHNRUkZiS2lzemJFRHcxTldNMlJnMXJG?=
 =?utf-8?B?RnA5K2QrTWx2dFdSWDJ1TnRLcVYzYjVDcU1rc3VwS2RYUmtzRWNGUklxTnUv?=
 =?utf-8?B?TGNRWDZEa0pyRXVaTmN5V214aGF6ZGUwOVo1NU1SRVhGNDgyTm1OakRhbklP?=
 =?utf-8?B?Y0ZxdzRVNy95bTFzR2R0eEdhTzdMd2FjSFpwRmFCcG5lSjlGdVFkeXBvQ2E4?=
 =?utf-8?B?TTQ2OWdGTUlkbmhjRG5RNjZYbG8wTFZMWmhiTnhjKzVYWEwzNDZYRFpkN1RF?=
 =?utf-8?B?dm1aaDdwamNrUkhvNDZ6dzdULzdoTnJHTDhnQVB6MERPNmVpSDZsTldGb2Vu?=
 =?utf-8?B?YS85NXJmR2hPY0Jhdk0xeVN0VFZXSWJFSkZ0cnIxUHBnZkY2L21Fd0xwVW5m?=
 =?utf-8?B?Tko1RlEzZUNYMGZKaDFENDVqY1JiYjlkNVlDSzYyaHQ2WGJ2RWpQb2Y1TVJl?=
 =?utf-8?B?M29wcnM1cHU3U1lpdVlPOUdyak9tZU81UzFkNUE5aTJGdXFaaGdvTXhrSmJt?=
 =?utf-8?B?RUtFU09BSUplRVlVaVU0VzhFT0cyekdyZEQ2Q3B5b2poUk5SRnArYTRqMWdT?=
 =?utf-8?B?T1MwQmQzR1JtZy81K2F4TVdHTU8rdGc1SzcyK0xDMnVxL1E3WVhmT0k4MjlQ?=
 =?utf-8?B?M2tIRzhrRW1Wbk1aVGlMZ29rY0ZiS0JvbTRRak9xWmExTjdzOTBxZndMOGIw?=
 =?utf-8?B?L2d4MEdIOUZlcjhyWkxQSHdtNHorWXFKaEkwdXptM0xkR3hIUmtBR0hoV3Fs?=
 =?utf-8?B?MVNkWDdmeE9WZHQ4aFExZmxvd1lkdUhNRHZ0M0xXdDAvOWZFdXJEZUpIaTNs?=
 =?utf-8?B?RzRPUHd1RFMzb3V2a3U1WEszQURtOVZsNHpnd1c5N25xd29vS2M5TnlnQnMv?=
 =?utf-8?B?V0FWN3ROaTNoOEJER2VZMUp0SlVPK05TSXVpTDJ2MlpSU1ZRWTVtQ2Z3a1dH?=
 =?utf-8?B?RDdaeVFhWUJrL21OaXV3djRKV2FTTjdlMHFnUncwNDZadisrMGtCa2pFYS9Z?=
 =?utf-8?B?dnVwYU05cEdNZHFwa3h0YzJtaXhzM3ZvMEdwQ1RqSXI0TWNWb2h5UytLT0RQ?=
 =?utf-8?Q?f5x0gFXiOc54khBI+o6mcWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <529B08A998298B4298510CFB3C285D43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73dd834-1eac-41a7-eccc-08dbdf90dd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 12:55:48.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnylQa8yVw1nvxN2p9ocGlBVpPAsDHoFlP1SBnyMFo6rGzftRZp76lZ1Ldb5OOc/8txihPnQ0rSee+vVhYDVZt3wE8YBtDHVnPiQuo8AS1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCg0KT24gVGh1LCAyMDIzLTExLTAyIGF0IDE0OjI4ICswMDAwLCBSb2JpbiBH
ZXR6IHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHJnZXR6QG1hdGh3
b3Jrcy5jb20uIExlYXJuIHdoeSB0aGlzDQo+IGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gRnJpZGF5LCBPY3RvYmVyIDI3LCAyMDIz
IDExOjE4IEFNDQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiANCj4gPiBPbiBXZWQsIDI1IE9jdCAyMDIzIDE2OjQ0OjA0ICswMzAwDQo+ID4gPG1haWx0bzpt
YXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiANCj4gPiA+IEZyb206IE1h
cml1cyBDcmlzdGVhIDxtYWlsdG86bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gPiA+
IA0KPiA+ID4gVGhpcyBpcyB0aGUgaWlvIGRyaXZlciBmb3IgTWljcm9jaGlwDQo+ID4gPiBQQUMx
OTNYIHNlcmllcyBvZiBQb3dlciBNb25pdG9yIHdpdGggQWNjdW11bGF0b3IgY2hpcCBmYW1pbHku
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMt
aWlvLWFkYy1wYWMxOTM0DQo+ID4gPiBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMt
YnVzLWlpby1hZGMtcGFjMTkzNA0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZWE0M2RmMjkyYjljDQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1paW8tYWRjLXBhYzE5
MzQNCj4gPiA+IEBAIC0wLDAgKzEsMTUgQEANCj4gPiA+ICtXaGF0OiAvc3lzL2J1cy9paW8vZGV2
aWNlcy9paW86ZGV2aWNlWC9pbl9zaHVudF9yZXNpc3Rvcl9YDQo+ID4gPiArS2VybmVsVmVyc2lv
bjogNi42DQo+ID4gPiArQ29udGFjdDogbWFpbHRvOmxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiA+ICtEZXNjcmlwdGlvbjoNCj4gPiA+ICsgVGhlIHZhbHVlIG9mIHRoZSBzaHVudCByZXNp
c3RvciBtYXkgYmUga25vd24gb25seSBhdCBydW50aW1lDQo+ID4gPiBhbmQgc2V0DQo+ID4gPiAr
IGJ5IGEgY2xpZW50IGFwcGxpY2F0aW9uLg0KPiANCj4gV2hhdD8gRW5kIHVzZXJzIChwZW9wbGUg
d2l0aCBhY2Nlc3MgdG8gdXNlcnNwYWNlKSBkb24ndCB3aGlwIG91dA0KPiB0aGVpciBzb2xkZXJp
bmcgaXJvbiB0byBhZGQvY2hhbmdlIHNodW50IHJlc2lzdG9ycy4NCj4gDQoNCg0KWWVzLCBlbmQg
dXNlcnMgd2lsbCBub3QgY2hhbmdlIHRoZSBoYXJkd2FyZSAobW9zdCBvZiB0aGUgdGltZSkuDQoN
Cg0KDQo+IE9FTXMgZG8gdGhpcyBkdXJpbmcgUENCIGRlc2lnbi4gVGhpcyBpcyBmaXhlZCBwZXIg
Ym9hcmQgaW4gdGhlIHdpbGQNCj4gKGFwYXJ0IGZyb20gZGV2aWNlIGV2YWx1YXRpb24gYm9hcmRz
KQ0KPiBhbmQgaXMgdHlwaWNhbGx5IG1hbmFnZWQgdmlhIGRldmljZSB0cmVlLiAoQWxsb3dpbmcg
aXQgdG8gYmUgY2hhbmdlZA0KPiBieSBPRU1zLCBidXQgbm90IGVuZCB1c2VycykuDQo+IA0KPiA+
ID4gVGhpcyBhdHRyaWJ1dGUgYWxsb3dzIHRvIHNldCBpdHMgdmFsdWUNCj4gPiA+ICsgaW4gbWlj
cm8tb2htcy4gWCBpcyB0aGUgSUlPIGluZGV4IG9mIHRoZSBkZXZpY2UuIFRoZSB2YWx1ZSBpcw0K
PiA+ID4gKyB1c2VkIHRvIGNhbGN1bGF0ZSBjdXJyZW50LCBwb3dlciBhbmQgYWNjdW11bGF0ZWQg
ZW5lcmd5Lg0KPiA+IA0KPiA+IEhvdyBjb21tb24gaXMgaXQgdGhhdCB0aGlzIGlzbid0IGtub3du
Pw0KPiANCj4gSSB3b3VsZCBzYXkgemVyby4NCg0KQWxzbywgaW4gdGhlIGNhc2Ugb2YgY29tcHV0
ZXIgYm9hcmRzIHRoZSByZXNpc3RvciBpcyBrbm93biwgYW5kIGl0DQpjb3VsZCBiZSBzZXQgZnJv
bSB0aGUgZGV2aWNlIHRyZWUuDQoNCj4gDQo+IFRoZSBBRE0xMTc3ICh3aGljaCBpcyBkaWZmZXJl
bnQsIGJ1dCBhbHNvIHJlcXVpcmVzIGEgc2h1bnQgcmVzaXN0b3IpLA0KPiBod21vbiBkcml2ZXI6
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvaHdtb24vYWRtMTE3Ny5jDQo+IGlpbyBkcml2ZXI6
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hbmFsb2dkZXZpY2VzaW5jL2xpbnV4L2Jsb2IvbWFzdGVy
L2RyaXZlcnMvaWlvL2FkYy9hZG0xMTc3LmMNCj4gDQo+IHVzZXMgZGV2aWNlIHRyZWUgdG8gbWFu
YWdlIHRoZSB2YWx1ZSBvZiB0aGUgc2h1bnQgcmVzaXN0b3IuDQo+IA0KPiA+IEknbSBub3Qgc3Vy
ZSB3ZSd2ZSBmb3VuZCBpdCBuZWNlc3NhcnkgdG8NCj4gPiBzdXBwb3J0IHVzZXJzcGFjZSBjb250
cm9sIG9mIHRoaXMgZm9yIGFueSBvdGhlciBkZXZpY2UgYW5kIHRoZXJlDQo+ID4gYXJlIHF1aXRl
IGEgZmV3DQo+ID4gd2hlcmUgdGhpcyBjb3VsZCBpbiB0aGVvcnkgYmUga25vd24gb25seSBhdCBy
dW50aW1lLi4uDQo+IA0KPiBOb3QgcnVuIHRpbWUsIGJ1dCBhdCBQQ0IgbWFudWZhY3R1cmluZyB0
aW1lLCB3aGVuIHRoZSBkZXZpY2UgdHJlZSBpcw0KPiBjb21waWxlZCBieSB0aGUgT0VNLg0KPiBU
aGUgYXNzdW1wdGlvbiBpcyAtIHdobyBldmVyIGNvbnRyb2xzIHRoZSBCT00gLSBjb250cm9scyB0
aGUgZGV2aWNlDQo+IHRyZWUuIFRoaXMgaGFzIGJlZW4gcHJldHR5IHRydWUgaW4gbXkgaGlzdG9y
eS4NCj4gDQo+IEl0IGFsbG93cyBPRU1zICh3aG8gbWFuYWdlIHRoZSBoYXJkd2FyZSkgdG8gY2hh
bmdlIGl0IGFzIHRoZXkgd2FudCwNCj4gYnV0IGtlZXBzIHRoZSBjb21wbGV4aXR5IGF3YXkgZnJv
bSBlbmQgdXNlcnMuDQo+IA0KDQoNCkhlcmUgdGhlcmUgYXJlIHR3byBraW5kcyBvZiBjdXN0b21l
cnMgKHRoYXQgd2VyZSBhc2tpbmcgZm9yIHRoaXMNCmZ1bmN0aW9uYWxpdHkpIGZvciBzb21lIHBh
cnRpY3VsYXIgdXNlIGNhc2VzLg0KDQpUaGUgZmlyc3QgY2F0ZWdvcnkgb2YgY3VzdG9tZXJzIHdh
cyBhc2tpbmcgdG8gY2hhbmdlIHRoZSByZXNpc3RvciB2YWx1ZQ0KZnJvbSB0aGUgdXNlcnNwYWNl
IHRvIHVzZSBhIGxvd2VyIGNvc3QgcmVzaXN0b3IsIHdpdGggbG93ZXIgcHJlY2lzaW9uLA0KKHRo
ZSBub21pbmFsIHZhbHVlIHdpbGwgc3RpbGwgYmUgdXNlZCBpbnRvIHRoZSBkZXZpY2UgdHJlZSkg
YnV0IHRvDQpsZWF2ZSB0aGUgcG9zc2liaWxpdHkgdG8gY2FsaWJyYXRlIHRoZSBzeXN0ZW0gYW5k
IHVwZGF0ZSB0aGUgcmVzaXN0b3INCnZhbHVlIGF0IHJ1bnRpbWUuIENhbGlicmF0ZWQgdmFsdWUg
d2lsbCBiZSBrZXB0IGludG8gYW4gZWVwcm9tLiANCg0KVGhlIHNlY29uZCB0eXBlIG9mIGN1c3Rv
bWVycyBhcmUgdXNpbmcgYSBtb2R1bGFyIGRlc2lnbiAodGhlDQpleGNoYW5nZWFibGUgbW9kdWxl
IHdpbGwgY29udGFpbiBhbHNvIHRoZSBQQUMgY2hpcCkuIFRoZSBtb2R1bGUgZGVzaWduDQp3YXMg
bWFkZSB0byBzdXBwb3J0IGRpZmZlcmVudCBjdXJyZW50cyAoZGlmZmVyZW50IG9yZGVyIG9mIG1h
Z25pdHVkZSkNCmxpa2UgYmF0dGVyeSBiYW5rcy4gQXQgcnVudGltZS9ib290IHRpbWUgeW91IG5l
ZWQgdG8gaWRlbnRpZnkgdGhlDQptb2R1bGUgdXNlZC9pbnNlcnRlZCBpbiB0aGUgZmllbGQgYW5k
IHNldCB0aGUgc2h1bnQgcmVzaXN0b3INCmFjY29yZGluZ2x5Lg0KDQpUaGUgImluX3NodW50X3Jl
c2lzdG9yIiBwcm9wZXJ0eSBpcyBhbHNvIHVzZWQgYnk6DQpkcml2ZXJzL2lpby9hZGMvaW5hMnh4
LWFkYy5jDQpkcml2ZXJzL2lpby9hZGMvcnRxNjA1Ni5jDQoNCg0KDQoNCj4gLSBSb2Jpbg0KPiAN
Cg0KDQpUaGFua3MsDQpNYXJpdXMNCg==
