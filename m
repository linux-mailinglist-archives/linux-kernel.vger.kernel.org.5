Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35817DDDDE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjKAIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjKAIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:45:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB2DF;
        Wed,  1 Nov 2023 01:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6317lXLMVn8K1hsyYuKGZ8OU9pekpNPswUGkDwfhlSLvYvxvNsS/AlPUUQN+8W5C3yMZVC1lcW/eCMyeBCbY7pE31SjEyfgcYbPrjHD78Q34un59qbnFKlkW5iSp20ovj4qXRNK4qTXLrcwKoYktcx6chyuB/gCpZMr5LCwUTMf4FyRjoM0bP/l+TyVJCmrG8G+0GV+EzQpU1IsN17c9UlI46W2rOZj6kpLKkpYju0IdWggYbVuBeWsI0LqXfnpf/uM5NSfJoxwWsq9Gy3NViFqWamQ19EugIWwzBEJhNYcF4WcZ7csniawlXtLOCYzQf7/44vq69/sumjjTOHTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyt/hbPcZpw17C5qfW4nJrKNYyUZ76h/dmgJaUBaDms=;
 b=KlfkxoyS4/3O+8LybUVYjrc2RWzn6wGRUbeVIjINw4VVVvZGbqxnngMVFBWt0oQmDojQ593YWT3QzjdgaxflTnseSjfrO9fzaXJMX8DJTfFhpXF49Tzug8BJCh7wPD8tuAJJQ8OI2TS3MxlCF7ZFy12KYcH3E4M9tzSgXGEZl0/NL6aGsqoE3mjsxpsB0hCHciRYWuNou15JWWGENhOCSP+lpb1BrB3DZi3vrBQ1GkCkksP4u3NS3ikuz6FWEkZvvX45IbiKqCRLTNcpE3QdeZ4aG4Zj4FeJSzTOoTczFtKiMHWqy2cPPCWv/xKkRBcpr7RU9zS3HjCwgtA5MYxesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyt/hbPcZpw17C5qfW4nJrKNYyUZ76h/dmgJaUBaDms=;
 b=fVNQzubOHMh4lPKBJFCmdVshinYRgu0lRyEUZDnkQBrubMiRq327wUYoryTHmQK2wlP6JJNgfQExC7ndzV82fGo8c/V/nULP7dOBRWwcpifI5WEh1vBly4VfvZupKPcjyYIqXLUrV/LnIHDkK1CkSrwJTsnfWmmUZVGgwxm5EZ+3RhAMeSag77eFQPS0iez4YAaJEzBbkoOP0LON+ih5IPMA8r4GZs/A5Uf9yuo+fDOKQRcg1ouOMxNw4ux3sP5Q2D/4yY/x7wS+NK02IVPY9WbIBvusPKfpBTeTGeZkxNPsfx8h8sJtPLBouBjqsNrSyWMK4Jq33EZPeInxVEVruw==
Received: from PSAPR04MB4598.apcprd04.prod.outlook.com (2603:1096:301:69::12)
 by SEZPR04MB8045.apcprd04.prod.outlook.com (2603:1096:101:22d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 08:45:16 +0000
Received: from PSAPR04MB4598.apcprd04.prod.outlook.com
 ([fe80::b141:ca0e:b9f1:22da]) by PSAPR04MB4598.apcprd04.prod.outlook.com
 ([fe80::b141:ca0e:b9f1:22da%6]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 08:45:15 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Patrick Williams <patrick@stwcx.xyz>,
        Krish Skandakumaran <krishskanda@meta.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Thread-Topic: [PATCH v1] hwmon: emc1403: Add support for EMC1442
Thread-Index: AQHaC9hhpqElOFTjb0ems+IZMveFDrBkhJUAgAA5jACAACoBAIAAPe/w
Date:   Wed, 1 Nov 2023 08:45:15 +0000
Message-ID: <PSAPR04MB459864E8447A97985FA303FAA5A7A@PSAPR04MB4598.apcprd04.prod.outlook.com>
References: <20231031085807.618827-1-Delphine_CC_Chiu@wiwynn.com>
 <7d92d8ae-c247-4a71-a84d-4f9639a43fb8@roeck-us.net>
 <ZUG3fOnw8RE7JHsh@heinlein.vulture-banana.ts.net>
 <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
In-Reply-To: <aa00e20a-03ee-4092-a477-6d952cdacf4e@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR04MB4598:EE_|SEZPR04MB8045:EE_
x-ms-office365-filtering-correlation-id: 68d5b9cc-c7de-492f-9a23-08dbdab6dea2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhIl9eQv0Aap30ySGuxHyLK9Skz0znYoLV8+Pnag7jGB7NIB4j4YaEvE/Yq1B+RBYRUUhfxn6Mh7h/NPunNWeDgpw9vm9fgGGgpDdalkyASLmthP06K4bpiuOE+vM74Wlpq44G08pIHJekej4PSkmkLa+YmfBfsLHu6GisPEb+2QBcLeqT8FyEv9K9vUB8aeog4tbEQwxs7Zv1qsyETfiLI/V4XrQo4iBmGmjY5mgrdQKZwAG5qj1rcqLJwqNhz7odL083j7b2HMpwptoMI9D1wrK/2rhraWVbdAy4SN0k+IVPPyilmWdpq8cGwqkXoRCglAUZFNhV6wRrhTe2nkTwndS1kJY+/bvNpPkRizhLMrvhw3Xn4D1PYFZortz/QweWOiMElt3hEu094hZWUVYFbtfSY28krhAVHuEA+XzVv3o7/tOwhOtzTZ8Ta6ZRW7vEswWWYl+gQrsmrtiA8piqmzV+SbgVoFyBMxgwHbEfNIzC6a60cnfNfflzqKNX7pzT31+DPIz3I/7KKCbCT8l+h7QFYsyYEppBp+xpqijuJbJ9qz4vnTyeJl33+w34N3VKqOpDozZ8aMgLeAe1XGw0IJR91uTxvftxEYWLIRjDmthdJmhZvZJDulTiuKVyrweL7aqLzRTBP0kJ827g3zYbSiD2kNRwZPGLOo/Mh6F5U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR04MB4598.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(38070700009)(55016003)(6506007)(7696005)(2906002)(5660300002)(8936002)(52536014)(4326008)(8676002)(64756008)(316002)(54906003)(76116006)(66946007)(110136005)(66446008)(66476007)(71200400001)(86362001)(53546011)(9686003)(66556008)(478600001)(26005)(122000001)(83380400001)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWEra3lReWkzZE1Ld2FVYTVtZWdnSHBGNmE5REFIK1g0R3dZaWFTRDBFZFFw?=
 =?utf-8?B?RTA0d2lvRjVjdjdoSmlIemh5K0VIL09EY3dvN01FQWNUYU82MkdHaUM4b2tF?=
 =?utf-8?B?R3kxbUJJNnM2VisrZGxZc01HMzZ6VWt4N2gyNDltV3ZXWWFiTmlrSXB6S0ta?=
 =?utf-8?B?SjJCNlRYQ2w3WTYyb2w5T2ttM2doSTFqVEpBTkZtTENjK3pRNzVmcFlpUXRE?=
 =?utf-8?B?WE9LWUNnZFRwR05CTDY3OHg2UGw0bzQ4SzdYNkYxNFVIYitUQUlnSWQxZUth?=
 =?utf-8?B?Unkwa2FJVkUxUVY3VHpBblRkWGg5d1FSQzVTUmgxQ2NLbzBid0VUbitWTjc2?=
 =?utf-8?B?cXE5QnQrYmpjZ3d6SFVUN0xRNlFiUHBaVGNjbkRQR3VnZjBsbXVGMUZySCtX?=
 =?utf-8?B?eHJBUkRmbllXYkVHMWpGcVlWNlF5RXZXWFpST0cxNlhXa05WdDU3L1A1ZlVn?=
 =?utf-8?B?YlhvOE5ZYkMwdjNBdHB3UXNvenhtakR6NXJpak5WNHlRS2pUWDBTQ2d5SS8x?=
 =?utf-8?B?SEJJa2pTS3pieTh3cTZNaURLeUhDdGJkeGgzT2pYUVRnTE1hNXgxbStnTk95?=
 =?utf-8?B?NjNQcU9YM0ZSSi9hTnZ6RjZlcFFaQ1hPTTArNXJ1bzJRUldIQUR0bUxCSEJr?=
 =?utf-8?B?Zm9NWVc4T2ptWFpmSWM2bFgyaFF1RHAyT1JnUGQvcjN3S3loc25lOW1vcWVG?=
 =?utf-8?B?bHJoWWpIU0V3TWUvZDI1SVFaRVVQS2RwMlNIRTYxVFN3V0wzV3VFOGNkMXZ5?=
 =?utf-8?B?ME9ydE5wemprd0h1czBsRVJXQldxa0dGY2NwNjhSWXhGSkpOVWNtV20zQ3ps?=
 =?utf-8?B?Z0orQ1p4QTRaSDJtMVovaExXY1htOW5zN005MHc4Q3hvcjcwK0dSS2thUVhw?=
 =?utf-8?B?ai94UjVhdnVpSmVwUit1RFVKQmNoV2J6bXZQM2hqclR3aVJkOWx3K3E2dlhU?=
 =?utf-8?B?V2hKd3cyRGNWRVBydXN6WmFYUnNGdW9kcEFuY3NXSVFHR3BsbnFXN1NiQ0M2?=
 =?utf-8?B?ZktJZDBsRmQ1RE9GaU1kMjZTeE1RandEaFpjS0pNQTA4a3I2RnJDR0FDaFpu?=
 =?utf-8?B?VCtHbnVSZkNzQlRLeGVERFpFek1oVVNjallZSGF0aUJCVEZiR25tZ0ppSmVm?=
 =?utf-8?B?eVhzNlgyWFRoeDZCQkhUMFJLOXpOY1pKcjJJTkpwQ0thZFBPdFRwa3psam9r?=
 =?utf-8?B?aWJ4OEQxOEtVUUFueTN2TzZCODNkTGtQS2hjWkhnTDg2a3JPdWdhcVpBRG02?=
 =?utf-8?B?ZW4zMG9GdGJKWjNuTzRyTzBydXpNMW02VzB5b0R3OXR6L3d3cDM4K2gzUTFp?=
 =?utf-8?B?ZUQwbkVUVGdDbmE0dUJsM3VBNHNmQUVJQk5vSHFkdmFpZVkxVkhPZ0xFazlt?=
 =?utf-8?B?bkp3a1FuY2FhU0FpUWs3VVQvWHZBMUFZVExJc1hFM0JMRUNxZjJuayt1aWl1?=
 =?utf-8?B?SGxGQWZqTkdFVCtudzdabHpSTkh1Z2NrOWFHVk5NNUx0UWRoeVhKS1pDWlJM?=
 =?utf-8?B?Rm9iQnNaS2k0TWhKVU5CajZRanIzRzZqcyttVkl1SlNVL3BleExZa3YyNVlO?=
 =?utf-8?B?Y0pYREk4bEt4dlVtZnpOL05paytUclkyV091NjBvQnVScHBXQitlMGI0N2xk?=
 =?utf-8?B?WjlQbWVBV0cwZDBaRzkwTGdJcGRtZGlRM2UrMndDU1ZzVmlkYW03MHhtbDFP?=
 =?utf-8?B?d2k5OGZ1Mmw0RUJjM2srMTFOMGNmcGlnVlJzSGF1Z0RGUURCVzY5VG9ibWVl?=
 =?utf-8?B?MGZMZzVvVVJxMUwyOUlTLzRJZnEybEs2S2pnaWdxb1kwTEZiVVFhR3Y1R0Rk?=
 =?utf-8?B?eUsxNkMzN0VBN2VEWC82MnB4RngvQ0w3eWprUmxHbzFKanBxQmpmQ3M2eCtx?=
 =?utf-8?B?UmFJRkdndjloRGNXU3VoVVQzOFZ0K01lUHRBR2ovYWpxWUQrVjR3RjU2RW9W?=
 =?utf-8?B?MENzbi9SWEVGblgrWWp4V1l0aEtmOERzL0FSODR3Um5BQk5DMFFqVjVNTENV?=
 =?utf-8?B?QUpVSG1CVWJKajZnL2JzeUVvV1RIcllRdlRaSWNWZ2ZlYmZyY3F2ZDhUR0Vo?=
 =?utf-8?B?R09ycDhKVjcyRkxsMnB6Y1NOaEFPV2FtVUtzbWZ5Y0Eza3NyRExmSDVIazFT?=
 =?utf-8?B?SjhsUkREK3BTVWJPcHl3dFRVVkdNallGRjBTN2o3SmNXNnM4Um93S1FWRUJj?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR04MB4598.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d5b9cc-c7de-492f-9a23-08dbdab6dea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 08:45:15.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36k/PicBG2b571eAkUGiPqczEoVssVfFioa+tww0pEZ4g8osb5jonj/ABG0HnGVZhyus0RQafulGAuQCvVUKwgWLfr1mljs8Hqfj1i9SMUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTm92ZW1iZXIgMSwgMjAyMyAxMjo1NyBQTQ0KPiBUbzogUGF0cmljayBXaWxsaWFt
cyA8cGF0cmlja0BzdHdjeC54eXo+DQo+IENjOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5u
IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+Ow0KPiBKZWFuIERlbHZhcmUgPGpkZWx2YXJl
QHN1c2UuY29tPjsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGh3bW9uOiBlbWMxNDAz
OiBBZGQgc3VwcG9ydCBmb3IgRU1DMTQ0Mg0KPiANCj4gICBTZWN1cml0eSBSZW1pbmRlcjogUGxl
YXNlIGJlIGF3YXJlIHRoYXQgdGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsDQo+IHNl
bmRlci4NCj4gDQo+IE9uIDEwLzMxLzIzIDE5OjI3LCBQYXRyaWNrIFdpbGxpYW1zIHdyb3RlOg0K
PiA+IE9uIFR1ZSwgT2N0IDMxLCAyMDIzIGF0IDA0OjAxOjEwUE0gLTA3MDAsIEd1ZW50ZXIgUm9l
Y2sgd3JvdGU6DQo+ID4+IE9uIFR1ZSwgT2N0IDMxLCAyMDIzIGF0IDA0OjU4OjA2UE0gKzA4MDAs
IERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4+PiBBZGQgc3VwcG9ydCBmb3IgRU1DMTQ0MiB3
aGljaCBpcyBjb21wYXRpYmxlIHdpdGggRU1DMTQwMy4NCj4gPj4+DQo+ID4+DQo+ID4+IFVuZm9y
dHVuYXRlbHksIGFsbW9zdCBubyBpbmZvcm1hdGlvbiBpcyBhdmFpbGFibGUgYWJvdXQgdGhpcyBj
aGlwDQo+ID4+IGV4Y2VwdCB0aGF0IGl0IHNoaXBzIGluIGFuIDgtcGluIHBhY2thZ2UuIEFyZSB5
b3Ugc3VyZSB0aGUgY2hpcA0KPiA+PiBzdXBwb3J0cyB0d28gZXh0ZXJuYWwgdGVtcGVyYXR1cmUg
c2Vuc29ycyBsaWtlIEVNQzE0MDMgPw0KPiA+PiBUaGUgY2hpcCBudW1iZXJpbmcgYW5kIHRoZSBu
dW1iZXIgb2YgcGlucyB3b3VsZCBzdWdnZXN0IHRoYXQgaXQgb25seQ0KPiA+PiBzdXBwb3J0cyBh
IHNpbmdsZSBleHRlcm5hbCB0ZW1wZXJhdHVyZSBzZW5zb3IsIHdoaWNoIHdvdWxkIG1ha2UgaXQN
Cj4gPj4gY29tcGF0aWJsZSB0byBlbWMxNDAyL2VtYzE0MjIuDQo+ID4+DQo+ID4+IEd1ZW50ZXIN
Cj4gPg0KPiA+IFRoZSBkYXRhc2hlZXQgSSd2ZSBzZWVuIHNheXM6DQo+ID4NCj4gPj4+IFRoZSBF
TUMxNDQyIG1vbml0b3JzIHR3byB0ZW1wZXJhdHVyZSBjaGFubmVscyAob25lIGV4dGVybmFsIGFu
ZCBvbmUNCj4gPj4+IGludGVybmFsKS4NCj4gPg0KPiA+IEJhc2VkIG9uIHRoaXMsIEkgYWdyZWUg
dGhhdCBlbWMxNDAzIHNlZW1zIHdyb25nLiAgVGhlIGRhdGFzaGVldCBhbHNvDQo+ID4gc2F5czoN
Cj4gPg0KPiA+Pj4gUGluIGNvbXBhdGlibGUgd2l0aCBFTUMxNDEyDQo+ID4NCj4gPj4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IERlbHBoaW5lIENDIENoaXUgPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5u
LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgIHsgImVtYzE0MjIiLCBlbWMxNDAyIH0sDQo+ID4+
PiAgICAgeyAiZW1jMTQyMyIsIGVtYzE0MDMgfSwNCj4gPj4+ICAgICB7ICJlbWMxNDI0IiwgZW1j
MTQwNCB9LA0KPiA+Pj4gKyAgIHsgImVtYzE0NDIiLCBlbWMxNDAzIH0sDQo+ID4NCj4gPiBTbywg
ZW1jMTQwMj8NCj4gPg0KPiANCj4gQXQgdGhlIHZlcnkgbGVhc3QsIGlmIHlvdSBhcmUgd2lsbGlu
ZyB0byBjb25maXJtIHRoYXQgZm9ybWFsbHkgaWYvd2hlbiB2MiBpcw0KPiBzdWJtaXR0ZWQuDQo+
IA0KPiBJIHByZXZpb3VzbHkgcmVqZWN0ZWQgYSBzaW1pbGFyIHBhdGNoIGFkZGluZyBlbWMxNDQ0
IGJlY2F1c2UgaXQgd2FzIGltcG9zc2libGUNCj4gdG8gZ2V0IGEgZGF0YXNoZWV0IHRvIGNvbmZp
cm0gdGhhdCB0aGUgY2hpcHMgYXJlIHJlYWxseSByZWdpc3RlciBjb21wYXRpYmxlLiBObw0KPiBp
ZGVhIHdoeSB0aGF0IGhhcyB0byBiZSBzbyBzZWNyZXRpdmUuIEl0IGlzIGEgdGVtcGVyYXR1cmUg
c2Vuc29yLCBmb3IgaGVhdmVuJ3MNCj4gc2FrZSA6LSgNCj4gDQo+IEd1ZW50ZXINCg0KSGkgS3Jp
c2gsDQpXb3VsZCBuZWVkIHlvdXIgY29uZmlybWF0aW9uIG9mIHRoZSBkZXZpY2Ugb24gdGhlIE5J
Qy4NCg0K
