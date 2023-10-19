Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108057CF488
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjJSJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjJSJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:58:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF4B8;
        Thu, 19 Oct 2023 02:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWj+ysG3dhicL2tfjSf18OEeQ2C4afN7yaZeVCzRPkmXFubNTrk9wru3lrhqVfA/ywVnkzw1APzORZR69OS1WkvqIzR0gGbotG0m3K6oq9ys8npljHeNSaBE6eW0I1Hleaiyr8DLgh1XQcCqxBw0s+Zx00MA9HWtLBbsmgS0DerlGDMgw1JchOy3IVYNEQObTZS9KKpdz3Nlv5UDA/r03WREuj9HBkT8vI0pS7f5VMDA4tleTf77fQwo+0FXQOt2owL4UACYsyMzBGvXWfEtNJ4Jg1Tu7IiIru75BrQFWYA7bb9iMR8MDcw0ygSEAQAOa2PEF8UitSeHfKtyBH+rgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoTpF8BQXxL8GshY/NC07JzUpeMjbY+81QUyqIYt0Kw=;
 b=EBVJXl3za15eX2azT/z2yIlaZA+nBQcMrBC2v3oXMW/BC1sEeWs5HrOQ5yInzo4V87a/7ioT11MYtNPksFMlPxJVIrgDwwxcbyxQ+quy0GZVGTjNpNcJPoap6XIHcBRzzBAPKaBd5CuEeYxJmdIsgrBgVTB56zD9Nt3vmHejEmch3ZuZ1+8VZ236zCSpIm9LHuz0UEG8gygKLzxTCMCHph4LHyNCX+4zA33oSkBRhk0lV8AG2ZiCLzowUQYpRneGnE/QVtWDF6aEddSgTg8T0oNnHw2vCmlMxHqMDwRSWBvM75+3U/vgaxk6EFuwiGiUfikJ1A/W4PxFL4ETu3mCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoTpF8BQXxL8GshY/NC07JzUpeMjbY+81QUyqIYt0Kw=;
 b=rp0NhN5PUhWEvEmb7lu0PgmEZPBNRDaW/md58roMDOHSIPKxwZTK29d1MMyp6Gh6GwU0Bso1I9hJz6e0cBIDz/dvB3I2noowohtRRL0vs/DmQgX1nwgdJocPh5BaYW/WVsq5OD/YfzI3nKcWouSEvWz8Q8qP2apCv7foOKUPYlQ=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AS1PR04MB9501.eurprd04.prod.outlook.com (2603:10a6:20b:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 09:58:36 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::527a:fa6f:ffe2:5326%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 09:58:36 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Topic: [PATCH v1 2/2] Bluetooth: btnxpuart: Fix nxp_setup
Thread-Index: AQHaAnLTmx+HF2QsJku6JyeMUHN/SQ==
Date:   Thu, 19 Oct 2023 09:58:36 +0000
Message-ID: <AM9PR04MB86030EDD81A5513752962C1DE7D4A@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
         <20231018145540.34014-3-marcel@ziswiler.com>
         <AM9PR04MB860351E818A6DD715A7F88FDE7D5A@AM9PR04MB8603.eurprd04.prod.outlook.com>
 <dca8bc7fec5f527cac2e280cd8ed4edae1f473ea.camel@toradex.com>
In-Reply-To: <dca8bc7fec5f527cac2e280cd8ed4edae1f473ea.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AS1PR04MB9501:EE_
x-ms-office365-filtering-correlation-id: 2f1550e8-c0e2-4552-e8a8-08dbd089f659
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUlVuRlP2fj5NtQoAeTR8aw4HP+3gVOS3qoKKn+/Nz98PKa7DCgxsuJuUjp74948NLsLQQiNFACEgRVwGQlKpzgbqUcy5GZJawzrRn2COSU+AtSt9NCUBaEl/S43slGvKwrqc9UwIoo+9OkZ3LJSP6ZcYGinCQaq0O2+uaz0GvNcf88/7XeHWRBoFeiYBZqKNC6SbVdkczC01ektg44HMFpuHZFoygY/crHGpboylDG+v6FFLKF2jsoa0uMPG8V8G6O0aT6UklH9JxMP1/ZAESlTp31HY5zr5FIR+ACRhFIEhgzYowopxwff6mfz+BfF0+ijROyTkfuZ8AagFfd83teHNPn0Lib2BcFDmYUb9u5Che2mM1POsTM/LAZvMhzFAFRit15nEDGm+8WTTsVc84ZhFlhM4jMBL4q1lXN0tjx2Z4aFeEV+dmRkuNxRfXN1buDZZC48vUJPlmAL54GwGU7I7D81uk5UOnmDJ1Sd0wvj1oJg63RH2K1YpI61+zUkKT1rr/4RYoDDRMQMgZOYbpkmVkpLdJk7+/kAQvWXzGUhuLPwt76fC8AhxG4fUFrlYPgQoPbA23mHyeUYxnWAFAtqocdvTymSLB6IMjMTBd8og0R1XR4zNQ+UERZ29ELg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(478600001)(55016003)(8676002)(8936002)(122000001)(86362001)(53546011)(4001150100001)(33656002)(7696005)(6506007)(71200400001)(26005)(2906002)(41300700001)(9686003)(66574015)(83380400001)(38070700005)(38100700002)(52536014)(5660300002)(64756008)(66446008)(110136005)(66556008)(76116006)(316002)(54906003)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2wrdmROZ0J1WEMzZXNXZHRJMU4rc09pNGxyTTVKbTYyZW9hcU9ab2hjVUw4?=
 =?utf-8?B?bGR4TWliWmhxUjlKbjNnMDcrNXl0WUhWRFF1YmFPR1poVnNxRytyeFppL1hN?=
 =?utf-8?B?bUNuQUN5bkVQdEQ0eHo2NHhqSHBuMEJqaUhnK25GOHp3TWQyZDhHaWwwNEc5?=
 =?utf-8?B?VTlRK1RRRUYyNGQxRmU4dVZBeHF4aHh0K1JQOVFGeUx5Vld2UU93aWtpQXRT?=
 =?utf-8?B?TGlGOHprVVNrZEdtZE50VUVSME5uWkE1R0U1N1V0Smx4S2EwRXNzYjdqMGhT?=
 =?utf-8?B?UE84U1IvcU5raTBSN2ZyeVdNM3AvYXViTWxLblhTdllaeXJvMGdSTDNZV2I3?=
 =?utf-8?B?QTIyeXlwc1hlVm5BR2ZSVVF5RjFhdXZHKzJKOVUyK05Zck5GeHhFRlNLR2tK?=
 =?utf-8?B?RUEweURZd29LUjBIN056ckR5aFkzQncxQnhPU3V1NkNGaWVYZVFEU1JMQmUy?=
 =?utf-8?B?WWNtSkJrMlNXSXMvUW4yOEozajFhSElXdW9PcHdFNGJQSmpMWGFRR3lNcWUv?=
 =?utf-8?B?UFpxZURZZGwrdUJtV2xtMm0ya2JuM010VXRQM0poNWNPQlZBUzlZQU5lZVdt?=
 =?utf-8?B?SXpaYjdPWFdBOG9XK2U3YVRTWUx5RHNIRkQrTXkxS1cvK2MvZ0wxSi85WWZy?=
 =?utf-8?B?ZEIwUkxYTTRQSVkyNlZTN1lCMklzdTBYQ3ArcnJFQklXTG5BYytYcFRoekE2?=
 =?utf-8?B?Njh3ZXJtNWJJQ1VRUGJDYzdkOGRJV1oxa1J6bWhkOHJXVHdsWjA1dWkzOE9p?=
 =?utf-8?B?NFc0b0dZWVN3a3daNHp5K1VGR0FSZjcraFZVWUpUK3RMYXhpVTYwM3hvZDFl?=
 =?utf-8?B?ODIySEVmRDkvNldtUlluZlVZQTVFMWZhbCsxTHQ3NHNmak1rcW9MbWVxTjRy?=
 =?utf-8?B?VHo2REhWeGFCb05INkgvS2hXdDZqQzZtZDBPOGNvK3NSeFZwdHRobnN3L2xU?=
 =?utf-8?B?dUdNMk12YUgrRWpuaTBiY1RjTUZtVmZtVUNHUDlqMW1FWWRLeGVhMXlGRmpw?=
 =?utf-8?B?SXk0OThqNkF0ck1DQnN2eXFOeXV4Y1g2azY1dy9jcUIvQVRXL3lIdzNMczRY?=
 =?utf-8?B?U1oyMkVsYnUrTmtoZ2FybDYrWTkrZTE4MUozM3RWSW1Ra1o1YU1DMUNnTG5h?=
 =?utf-8?B?NHFRYnNrejVnSlZtU0JCSWE4OVRyS2Q4M2xhWDh6MGMzTXhCKzk0ak05Q1pF?=
 =?utf-8?B?SlkyNDdrTkllR0pVSzd0ZWR6bHVCVjF0MkZwNlBxaCtEUDRyNWZHNHQ2eW4v?=
 =?utf-8?B?OUp2VGRyclFaUkZsb2JlSU9ZVmtQMWxpTEhVZSttMGJFWFhIRnZhMXMvaUo3?=
 =?utf-8?B?UTlzOGZhbUVBR1U2UFlDUTFIRkFIaFZpTThJNk9sakU3K1AwbDcvNkxPVW5k?=
 =?utf-8?B?UG5XNDdoUldpM0lWT0lzak9UaEVoejl3WlFtaDZrSkdMS0orY29GYVQ4M0dh?=
 =?utf-8?B?NVhiZHIxRjdYODkydzVGdnkvYTNoRyt4WElYOGI0OVZIYTZSRk9ZYktEaWx1?=
 =?utf-8?B?K0JqNlJtdFpGMk1CNnJKWnYwWjZQQUplQXl2b0FFSnlJZ25nVnV4TkVjTTJz?=
 =?utf-8?B?Z2cyWlphWWFQcWZmNEFHc2d2S0t6RC9mWDQyZ1JHaDBNY1ZRdkE1V2VXN0Fk?=
 =?utf-8?B?L0F5T2s3Y3pyb1U4NjF1bThHZTVYaGk3azNWZS9iNE1LZ3hKMmxkU0pONDRp?=
 =?utf-8?B?NnhQUXBYcWk2TnU2VmRZU1RQbXZLSWZyQVcycFJKVVdjTHpRRDBBRW1nU3pH?=
 =?utf-8?B?U0ovMTBwb0s0T2tYbURHcGZyaDlrckV6cjcxVFV0YWIzamRmdjJwbUZldVN6?=
 =?utf-8?B?YnF5bDBzWkFueFVuMm9jeXJGam5uQ3ZNWG8wZE10OEM4RG9rZGRFNUpZbGlH?=
 =?utf-8?B?MHYyWUtOUkJING5qM1RMNDVGNWpIZmJiU2J1QW5sZDByZVpkR2Z1Yi9qQ1NS?=
 =?utf-8?B?VTBKYk5LOTR6UGZqSWtCU3RRYks0SFVWeGQwYkxBTG80TUNOeXdQUS96REZN?=
 =?utf-8?B?ZEc2WThkRDZ3eTREeC9PYk1SOVg4djdrclhLTGpYVTJtNkdibXNQcS9GZGtD?=
 =?utf-8?B?V0p6VXNQZ1Q1QlFnZVg3VmVhQzRhQ2M2aXZaRjFhVjVGWHVoVzl4aXNubUZs?=
 =?utf-8?B?VDczSTRVU2hHSCtkOXJocEpNUlJVTmppZ1BCRkxCbjFjaDZWVDlxd2xCWGpl?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1550e8-c0e2-4552-e8a8-08dbd089f659
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 09:58:36.4931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJXtML5shX07eNi8kdc8AquzANuDzOBSMG1+OUS9qbUho5N2KaCjqInS7CZdis1mK1daz7X6+0EPCDOjXjy00NrCafiHlcjHYC2RKyHUb5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9501
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2VsDQoNCj4gDQo+IE9uIFdlZCwgMjAyMy0xMC0xOCBhdCAxNToyOCArMDAwMCwgTmVl
cmFqIHNhbmpheSBrYWxlIHdyb3RlOg0KPiA+IEhpIE1hcmNlbCwNCj4gPg0KPiA+IFRoYW5rIHlv
dSBmb3IgeW91ciBwYXRjaC4gVGhpcyBjaGFuZ2UgbG9va3MgZ29vZCB0byBtZS4NCj4gPg0KPiA+
IEkgdGhpbmsgdGhlIHNjZW5hcmlvIHlvdSBhcmUgdGVzdGluZy9yZXNvbHZpbmcgaXM6DQo+ID4g
MSkgTG9hZCBidG54cHVhcnQua28gZmlyc3QgKHdoaWNoICJtYXkiIGxvYWQgQlQtb25seSBGVyBp
ZiBjaGlwIGlzDQo+ID4gcG93ZXJlZCBvbikNCj4gPiAyKSBQb3dlciBjeWNsZSBvciBwb3dlciBv
biBjaGlwDQo+ID4gMykgTG9hZCBXTEFOIGRyaXZlciB3aXRoIGNvbWJvIEZXDQo+ID4gUmlnaHQ/
DQo+IA0KPiBZZXMsIGtpbmRhLCBidXQgdGhlcmUgYXJlIHJlYWxseSBhIHNsZXcgb2YgaXNzdWVz
IHdpdGggdGhpcyBkcml2ZXIgb3IgdGhlDQo+IGNvbWJpbmF0aW9uIG9mIGl0IHdpdGggbXdpZmll
eF9zZGlvOg0KPiANCj4gMS4gU2hhcmVkIHBvd2VyLWRvd24gcGluIChQRCMpIGJldHdlZW4gQmx1
ZXRvb3RoIGFuZCBXaS1GaQ0KPiBJc3N1ZTogVGhlcmUgaXMgY3VycmVudGx5IG5vIGNvbmNlcHQg
aW4gdGhlIExpbnV4IGtlcm5lbCB0byBhY2hpZXZlIHRoaXMuIExhc3QNCj4gZmFpbGVkIGF0dGVt
cHQgWzFdLg0KPiBXb3JrYXJvdW5kOiBJbnN0ZWFkIG9mIHVzaW5nIG1tYy1wd3JzZXEgdGllZCB0
byB0aGUgV2ktRmkgZHJpdmVyDQo+IChtd2lmaWV4X3NkaW8pIHRoaXMgY291bGQgYmUgaG9nZ2Vk
IGF0IGJvb3QuDQo+IEhvd2V2ZXIsIHRoZW4gaXQgbWF5IG5vIGxvbmdlciBlYXNpbHkgYmUgY29u
dHJvbGxlZCBlLmcuIGZvciBhIChtYW51YWwpDQo+IHBvd2VyLWN5Y2xlLg0KPiBBIG5vdmVsIGFw
cHJvYWNoIG1pZ2h0IGJlIHVzaW5nIGEgcmVndWxhdG9yIHdoaWNoIGNvdWxkIGJlIHNoYXJlZCwg
aG93ZXZlciwNCj4gdGhpcyB3b3VsZCByZXF1aXJlIHVzIGltcGxlbWVudGluZyByZWd1bGF0b3Ig
c3VwcG9ydCBpbiBidG54cHVhcnQuIE5vdCBzdXJlDQo+IHdoZXRoZXIgeW91IHdvdWxkIGFjdHVh
bGx5IGFwcHJvdmUgdXMgZG9pbmcgc28uDQo+IA0KPiAyLiBCbHVldG9vdGggZHJpdmVyIChidG54
cHVhcnQpIHZzLiBXaS1GaSBkcml2ZXIgKG13aWZpZXgpIGxvYWQgb3JkZXINCj4gSXNzdWU6IEJ5
IGRlZmF1bHQsIHRoZSBCbHVldG9vdGggZHJpdmVyIChidG54cHVhcnQpIGxvYWRzIGJlZm9yZSB0
aGUgV2ktRmkNCj4gZHJpdmVyIChtd2lmaWV4KSBhbmQgdXNpbmcgcmVndWxhciBtbWMtcHdyc2Vx
IGZvciBtd2lmaWV4X3NkaW8gd2lsbCBvbmx5DQo+IHBvd2VyLW9uIHRoZSBtb2R1bGUgbGF0ZS4N
Cj4gV29ya2Fyb3VuZDogVGhlIGluc3RhbGwgZGlyZWN0aXZlIGluIG1vZHByb2JlLmNvbmYgY291
bGQgYmUgKGFiLSl1c2VkIHRvDQo+IGVuZm9yY2UgbXdpZmlleC9td2lmaWV4X3NkaW8gdG8gYmUg
bG9hZGVkIGZpcnN0LiBIb3dldmVyLCBkb2luZyBzbyBhZGRzIGFuDQo+IHVubmVjZXNzYXJ5IGRl
cGVuZGVuY3kgd2l0aCB1c2VyIHNwYWNlIGFuZCBpcyBpbiBnZW5lcmFsIGRpc2NvdXJhZ2VkLg0K
PiANCj4gMy4gRGlzdGluZ3Vpc2ggcG93ZXJlZC1vbiB2cy4gcG93ZXJlZC1vZmYgc3RhdGUNCj4g
SXNzdWU6IFdpdGhvdXQgdGhhdCBrbm93bGVkZ2UgdGhlIGRyaXZlciBoYXMgYSBoYXJkIHRpbWUg
ZmlndXJpbmcgb3V0DQo+IHdoZXRoZXIgb3Igbm90IGl0IG5lZWRzIHRvIGxvYWQgdGhlIGZpcm13
YXJlIGFzIG9ubHkgaWYgaXQgaXMgcG93ZXJlZC1vbg0KPiAoYW5kL29yIHdpdGhvdXQgZmlybXdh
cmUpIHdpbGwgdGhlIEJsdWV0b290aCBwYXJ0IG9mIHRoZSBtb2R1bGUgc2VuZCBpdHMNCj4gYm9v
dCBzaWduYXR1cmUuIFNvIHRoZSBhYnNlbmNlIG9mIHN1Y2ggYm9vdCBzaWduYXR1cmUgbWF5IG1l
YW4gZWl0aGVyDQo+IGZpcm13YXJlIGlzIGFscmVhZHkgbG9hZGVkIG9yIG1vZHVsZSBwb3dlcmVk
LW9mZi4NCj4gV29ya2Fyb3VuZDogVGhlIEJsdWV0b290aCBVQVJUIFJUUyBwaW4gc2VlbXMgdG8g
YWN0aXZhdGUgYW4gaW50ZXJuYWwgcHVsbC0NCj4gdXAgdXBvbiB0aGUgbW9kdWxlIGJlaW5nIHBv
d2VyZWQgb24uDQo+IEhvd2V2ZXIsIHByb2dyYW1tYXRpY2FsbHkgaXQgaXMgcmF0aGVyIGhhcmQg
dG8gZGV0ZXJtaW5lIHRoaXMgYXMgdGhlIHJlZ3VsYXINCj4gVUFSVCBkcml2ZXIgKG5vdyBkcml2
aW5nIFJUUykgdXN1YWxseSBnZXRzIGxvYWRlZC4NCj4gDQo+IDQuIERldGVybWluZSB3aGV0aGVy
IG9yIG5vdCB0byBsb2FkIHRoZSBmaXJtd2FyZQ0KPiBJc3N1ZTogSWYgaXQgaXMgd2l0aG91dCBm
aXJtd2FyZSAoYW5kIHBvd2VyZWQtb24pIHRoZSBib290IGxvYWRlciB3aWxsIHNlbmQgaXRzDQo+
IGJvb3Qgc2lnbmF0dXJlLiBJZiB0aGVyZSBpcyBubyBib290IHNpZ25hdHVyZSBpdCBjb3VsZCBh
cyB3ZWxsIGFsc28gc3RpbGwgYmUNCj4gcG93ZXJlZC1vZmYuDQo+IFdvcmthcm91bmQ6IEFsc28g
Y2hlY2sgQ1RTIGFzIGl0IGdvZXMgdXAgaWYgdGhlIGZpcm13YXJlIGlzIGxvYWRlZC4NCj4gVW5m
b3J0dW5hdGVseSwgaW50ZWdyYXRpbmcgdGhpcyBpbiBidG54cHVhcnQgaXMgbm90IHNvIHRyaXZp
YWwgYXMgc2VyZGV2DQo+IGludHJvZHVjZXMgaXRzIG93biBhc3luY2hyb25vdXMgY29uY3VycmVu
Y3kgd2hpY2ggaXMgYWxyZWFkeSB1c2VkIGluDQo+IGV4aXN0aW5nIGNoZWNrcy4NCj4gDQo+IDUu
IERlcGxveSBzZXBhcmF0ZSBmaXJtd2FyZQ0KPiBJc3N1ZTogRG9lcyBub3QgcmVhbGx5IHNvbHZl
IGFueXRoaW5nIHJlc3AuIGFzIHRoZSBwb3dlci1kb3duIHBpbiBpcyBzaGFyZWQNCj4gdGhpcyBz
ZWVtcyBraW5kYSBwb2ludGxlc3MuDQo+IA0KPiBZb3VyIGlucHV0IG9uIGFueSBvZiB0aG9zZSB0
b3BpY3MgaXMgbXVjaCBhcHByZWNpYXRlZC4NCg0KSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIG9u
IG15IHNldHVwLCBhbmQgdGhlIGFkZGl0aW9uIG9mIENUUyBjaGVjayBpcyB1c2VmdWwsDQphcyBp
dCBtYXkgbm90IHNlZW0gdG8gYmUgYSBnb29kIGlkZWEgdG8gcmVseSBvbiBib290bG9hZGVyIHNp
Z25hdHVyZXMgdG8gZGV0ZXJtaW5lDQppZiBGVyBpcyBydW5uaW5nLg0KSSBoYXZlIGFsc28gdmVy
aWZpZWQgdGhhdCB0aGlzIHBhdGNoIGRvZXMgbm90IGJyZWFrIGFueSBleGlzdGluZyBmdW5jdGlv
bmFsaXR5IChmb3Igb3RoZXIgY3VzdG9tZXJzKS4NCg0KVGhpcyBzZWVtIGdvb2QgdG8gbWUuDQoN
ClJldmlld2VkLWJ5OiBOZWVyYWogU2FuamF5IEthbGUgPG5lZXJhai5zYW5qYXlrYWxlQG54cC5j
b20+DQoNClRoYW5rcywNCk5lZXJhag0KDQo+IA0KPiA+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWxAemlzd2lsZXIuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE4
LCAyMDIzIDg6MjYgUE0NCj4gPiA+IFRvOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiBDYzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPjsgSm9oYW4gSGVkYmVy
Zw0KPiA+ID4gPGpvaGFuLmhlZGJlcmdAZ21haWwuY29tPjsgTHVpeiBBdWd1c3RvIHZvbiBEZW50
eg0KPiA+ID4gPGx1aXouZGVudHpAZ21haWwuY29tPjsgTmVlcmFqIHNhbmpheSBrYWxlDQo+ID4g
PiA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IE1hcmNlbA0KPiA+ID4gSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+OyBNYXJjZWwg
Wmlzd2lsZXINCj4gPiA+IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyBBbWl0a3VtYXIg
S2Fyd2FyDQo+ID4gPiA8YW1pdGt1bWFyLmthcndhckBueHAuY29tPjsgSWxwbyBKw6RydmluZW4N
Cj4gPiA+IDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQ
QVRDSCB2MSAyLzJdIEJsdWV0b290aDogYnRueHB1YXJ0OiBGaXggbnhwX3NldHVwDQo+ID4gPg0K
PiA+ID4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+
DQo+ID4gPg0KPiA+ID4gVW5mb3J0dW5hdGVseSwgbnhwX3NldHVwKCkgbWF5IGluYWR2ZXJ0ZW50
bHkgYXNzdW1lIHRoYXQgdGhlDQo+ID4gPiBmaXJtd2FyZSBpcyBhbHJlYWR5IHJ1bm5pbmcgd2hp
bGUgdGhlIG1vZHVsZSBpcyBub3QgZXZlbiBwb3dlcmVkIHlldC4NCj4gPiA+IEZpeCB0aGlzIGJ5
IHdhaXRpbmcgdXAgdG8gMTAgc2Vjb25kcyBmb3IgdGhlIENUUyB0byBnbyB1cCBhcyB0aGUNCj4g
PiA+IGNvbWJvIGZpcm13YXJlIG1pZ2h0IGJlIGxvYWRlZCBieSB0aGUgV2ktRmkgZHJpdmVyIG92
ZXIgU0RJTw0KPiAobXdpZmlleF9zZGlvKS4NCj4gPiA+DQo+ID4gPiBGaXhlczogNjg5Y2ExNmU1
MjMyICgiQmx1ZXRvb3RoOiBOWFA6IEFkZCBwcm90b2NvbCBzdXBwb3J0IGZvciBOWFANCj4gPiA+
IEJsdWV0b290aCBjaGlwc2V0cyIpDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyY2Vs
IFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gPg0KPiA+ID4gLS0t
DQo+ID4gPiBUaGlzIGlzIHdoYXQgbWF5IGhhcHBlbiB3aXRob3V0IHRoaXMgZml4Og0KPiA+ID4g
W8KgIDI4NC41ODgxNzddIEJsdWV0b290aDogaGNpMDogT3Bjb2RlIDB4MGMwMyBmYWlsZWQ6IC0x
MTAgWw0KPiA+ID4gMjg2LjYzNjE2N10NCj4gPiA+IEJsdWV0b290aDogaGNpMDogU2V0dGluZyB3
YWtlLXVwIG1ldGhvZCBmYWlsZWQgKC0xMTApIFVuZm9ydHVuYXRlbHksDQo+ID4gPiBldmVuIHJl
LWxvYWRpbmcgdGhlIGJ0bnhwdWFydCBrZXJuZWwgbW9kdWxlIHdvdWxkIG5vdCByZWNvdmVyIGZy
b20NCj4gPiA+IHRoaXMgY29uZGl0aW9uLg0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL2JsdWV0b290
aC9idG54cHVhcnQuYyB8IDEwICsrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290
aC9idG54cHVhcnQuYw0KPiA+ID4gYi9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyBpbmRl
eCA5Y2I3NTI5ZWVmMDkuLjRiODNhMGFhMzQ1OQ0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRueHB1YXJ0LmMNCj4gPiA+IEBAIC0xMDIxLDYgKzEwMjEsMTYgQEAgc3RhdGljIGludCBu
eHBfc2V0dXAoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ID4gPiAgICAgICAgICAgICAgICAgaWYg
KGVyciA8IDApDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+
ID4gICAgICAgICB9IGVsc2Ugew0KPiA+ID4gKyAgICAgICAgICAgICAgIC8qIFRoZSBjb21ibyBm
aXJtd2FyZSBtaWdodCBiZSBsb2FkZWQgYnkgdGhlIFdpLUZpDQo+ID4gPiArIGRyaXZlciBvdmVy
DQo+ID4gPiBTRElPIChtd2lmaWV4X3NkaW8pLg0KPiA+ID4gKyAgICAgICAgICAgICAgICAqIFdl
IHdhaXQgdXAgdG8gMTBzIGZvciB0aGUgQ1RTIHRvIGdvIHVwLg0KPiA+ID4gKyBBZnRlcndhcmRz
LCB3ZSBrbm93IHRoYXQNCj4gPiA+IHRoZSBmaXJtd2FyZSBpcw0KPiA+ID4gKyAgICAgICAgICAg
ICAgICAqIHJlYWxseSByZWFkeS4NCj4gPiA+ICsgICAgICAgICAgICAgICAgKi8NCj4gPiA+ICsg
ICAgICAgICAgICAgICBlcnIgPSBzZXJkZXZfZGV2aWNlX3dhaXRfZm9yX2N0cyhueHBkZXYtPnNl
cmRldiwgdHJ1ZSwgMTAwMDApOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0X2Rldl9lcnIobnhwZGV2LT5oZGV2LCAiV2Fp
dCBmb3IgQ1RTIGZhaWxlZCB3aXRoICVkIiwNCj4gZXJyKTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4gKw0K
PiA+ID4gICAgICAgICAgICAgICAgIGJ0X2Rldl9kYmcoaGRldiwgIkZXIGFscmVhZHkgcnVubmlu
Zy4iKTsNCj4gPiA+ICAgICAgICAgICAgICAgICBjbGVhcl9iaXQoQlROWFBVQVJUX0ZXX0RPV05M
T0FESU5HLCAmbnhwZGV2LT50eF9zdGF0ZSk7DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+IC0tDQo+
ID4gPiAyLjM2LjENCg==
