Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908B7F2134
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjKTXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:05:01 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A18C9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flzz/uXMgadUeVvGQlBt84PwxX3ALsQlPCEitXCeuvP3j3QTFGv33nm0StR9oZyNHZUPLoaoiFERSY2FCNRBiISAu6T7Bg1JaAaupMyocSv+Zdnh+eu96Vgn6yEV8rF/QfxFLcRjFu8YtccqzWxr6q72/kYXtwkEq5SRxek+16wXhBnJKdwXk0F9lZ6qaVtY4FtocJSXFS3b8qgebl2Kub4WnS9O48RJZTavs97ygfwlhwBgQTjKjOJm3RNuJR3YCdED8hphNZsk6b6KyH78Cn4TqfS7tsf6O7xetECPpYSWZhDLh3UZG73Wvp9iEZvmtcPxNm+GFlh6qjV8vcHJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZyKTizv9Zrdq9EkkYN+zmC9KqBnGR1iOqZ2HwkHJj8=;
 b=jAFt8X4LfNHnL0umt0EThDDR/kA6nP+V7mkNwm9cQ7xVORyLeh3BWmK9NwrXtNUVnT5azJtrQHfk1JQ/YnodOxi67CBvelyvF5C/zg9RVKDhERUjwsWmFPWUw4xi9g2KIKVFnDi07A3imgJWO9DO/rlixXRS3l90DrFHMMAAMIeRcVZqhbTEpJCVE7B9tEr1HJYIX6Tw0p1qiSNCgujFFmwqrrTvx0XjEB+t3bnAYs33Gmbnb6SFjdSeKntNFI2mdeRYw4vAWUS4LL83w407okxXeI7Y9wn7hUcyJi23PjdnYHIdL/nIGdRqtfN27+xAbrV4Qjm4qh3Fg5ul2TkqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZyKTizv9Zrdq9EkkYN+zmC9KqBnGR1iOqZ2HwkHJj8=;
 b=HsUafPvHQPiPFDI3tqAMGRmNd7zxh3eh1yYBLm+J/R19wJCtTfmpmYRacxKIARg38MhpFxmpHVu124WopbxkfSXJK+/xPT7gj4lFszDxn/z/LZbfmHH1c039MFU9DGoilHDjSgyGhZ8YbNZzidkdtWDEB6LaDoyWwPtIikx7SRo=
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB9323.jpnprd01.prod.outlook.com
 (2603:1096:400:199::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 23:04:53 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846%6]) with mapi id 15.20.7002.028; Mon, 20 Nov 2023
 23:04:52 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: RE: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
Thread-Topic: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
Thread-Index: AQHaGXSgqKqilaeU5kqopIa/H3nty7CCo04AgABZ2gCAANXDwA==
Date:   Mon, 20 Nov 2023 23:04:52 +0000
Message-ID: <TYCPR01MB109142FEC8F77CFFE3930456CD4B4A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
 <874jhh2g8s.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
In-Reply-To: <CAEnQRZBb0ZJk7aTaji-xH2jEs7QiTaoXTuS5_K-ruSaxpEnWdw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10914:EE_|TYCPR01MB9323:EE_
x-ms-office365-filtering-correlation-id: aa03bf5e-c133-41a9-fbcf-08dbea1d1ae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JTLyFoxYsYTQB75L8EmcaOIdcAFxjOkKlyoDY1pelQ962jbMxUaGsKRL5XgNffDrpI7wf2hdK8yahLQkK9CE2b0jJO/YW9iRnMHLjUG1kqvqOYQePPjAdIsM5xiMWtdBdPsx8skhdijdayAwgXzwpwWSdOOhGMQa9yHpBdKqJa38dkHHBjajaOhuG3e9X6KzeboV+acd0Rv+We/8zCorDAaSSTE6uX8JM8wizDukFDLLTyHt23JasfBAW9JGFeK6QinvVE+rRhPe7e/4o8LRiQYFD0RTAl4JyAZj52Ywg1yNMuudoxNc7lxcxXK9gMPLTXBBZsNZLl/vpZwwFFXmZkSszq9+DrvWVwQ7h4UlnWV/FVhPDQHsFiPghfIOgel7Yk0PNdZnQ9tDW6XNdnexauprq0xb/G1wdTfrcGtDkxoa8B7duK1dMkEGke+7QCAH1aVSpzv/CTHAEWiJ2DrT0XVOEUNDhgcMQYTc4jtM4vC5xTety8/3kMXcOf0RGDgmDmxPv1GzbRQjIPYbheidGvv9rKE7mfsd4GpeVpc6XR5VqBvGu9TEvFy2+utT+76wYOpjBbX7HSR716KieIZtMGxwiFya5gDgtE/5HP+cBjjdlkW+9IKlaRoMvpdVa0D3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(52536014)(41300700001)(5660300002)(86362001)(33656002)(2906002)(38070700009)(83380400001)(122000001)(7696005)(6506007)(478600001)(71200400001)(107886003)(55016003)(9686003)(38100700002)(8676002)(4326008)(8936002)(6916009)(66476007)(64756008)(66556008)(66446008)(54906003)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTdkQVkwR0tuc1N4dkdFU0lpd3JTaGw5Mzh6cStCS0FLUlZuNjZpSnY1dXU0?=
 =?utf-8?B?dTBRTXJyODVCZWlWYlJvMjc5UFRTdFUwSEJQWmw3bkVOV0dSSTN5T0tkU25r?=
 =?utf-8?B?UndaNlN2SU9nd1NqcG5ZdXVoVnpzK01DUVhOK3FCWitReUptK0IzMGlMSUc5?=
 =?utf-8?B?OEtyME9XUkl5WW01c3NFcnBSZWhybGRHMjJFWGYzUmw1N1RHTGJZZ2VjUHdt?=
 =?utf-8?B?L0ZVMTRmNjlHbzI4d2tpMlQwUHJiR29kVEdkYWZvb3BQSGZ2ODhodk9aVEtF?=
 =?utf-8?B?aFJBMjJOdTVZbk53Z0Z3WlFJcXA2R1NjR0ZjVzVBN2pGSHdjUWlpNVRtWGc2?=
 =?utf-8?B?ZXNJTExQbjd0RWkrbE9RZTV3dEhibWpTNUlkU3FQSS81cnE4dUpCUFJpNnlr?=
 =?utf-8?B?Z2Vma1llWEZ5dSs4d2YvRGpYU2ZqWXpHTzNwaVdoRVZzV1pPRGIyNFVoWVVO?=
 =?utf-8?B?YVFrVHpwTUx3ZGgyeHQxeXNxV0pJRStMSE9RRFJqZVROVENWa0pSTE1Nby9Z?=
 =?utf-8?B?WnFSNmQwcDlqRlNROU9kQnRoejJhYUVJa09qV0FSdnJQeWxFekl0SW9JbzVE?=
 =?utf-8?B?eURmbThERHFDNnN6ZzVGdWpCZlBkQllPQVErM3dhRFlPbTdlclk3OERiMWc2?=
 =?utf-8?B?MUdlTmVhRklRY2c1VVgwN2k1cHJIMGpIanJWQlNheVFYa3RydFQ4NllmaHk2?=
 =?utf-8?B?Q1F3cFpKblpJVm1iSU5HNGVuV3lJNE42V3BuWVFUTUdjR25lR2JWemtGQnJS?=
 =?utf-8?B?ZE9LSXhqTXoxRGJOdDFNWkJuQXZVcDdlVUJRK2JCZHhFZkZtbW5ZV1hhYit3?=
 =?utf-8?B?K0FaMk1RSGFOcWR0UlE4L1hycFB6RTZHL1B6czE1bmhWRk54RnhTM1pKRXZn?=
 =?utf-8?B?b01PTG95WS9yenAwUnY4eFdHL0JrdTcyVkVaOFlHZUkxY2hqZSt0U1RjUmkw?=
 =?utf-8?B?MUxGOUpSNWpsMktiZ1B6b0haMXV6Qi9LUzBzOTN2eTN1dmVXV3FrS1JDNmEx?=
 =?utf-8?B?VHBSZ2RHamovNVBvWUJLUDdjWFk0WENIaWdpN2JsRHJQRTBXdU94M0lIbTVw?=
 =?utf-8?B?ZHlrSzFoKzdIZDdqTlZONkZ6ek40NXdtbXpvSEpNV0cyTnk1d2FPYWExbDc1?=
 =?utf-8?B?UGZTTnhQRmdJZ3ZRWTNSUnJMYmFhOEVOd1NGQUxZWFBoblZZNGFYTDNPNlBW?=
 =?utf-8?B?VE9VbEhEVHpqUUsvVmVMZWhpQ2VzRUJoU3J1ZzBoVFVKOThvZkNVVmxZTDRT?=
 =?utf-8?B?UGRBNy9OaWlDdEVqSE5GVFpyK2pQMVQ0eHRjcTlKOTczSDE4N1BsWEZUaFdK?=
 =?utf-8?B?OWJLQjN1aGVMVFBFWjlZYkphKzdBR0dxV20zYmdhbkRVV0gzQzY0Y280Z2JT?=
 =?utf-8?B?TjE4S05CRlRWTHNmUlNhMjNJQzdYNU1ILzJZekhCaDhHRWlIblB4Tk83L0Fs?=
 =?utf-8?B?UUFqMGpUT3RDMkJXVlZaa1B2V3dxRzROaitCa1h2am92aVhYRHRaMEFqanR3?=
 =?utf-8?B?UjdJT1kyMGpGRjVPak1IVmhNWlRwK2ZCS0x1LzRMOXZOamlLMmlkM294ZlJm?=
 =?utf-8?B?R2wwYWF6UEgvQ0dkeWhMRmc4TjJrdnBaRzRKaC9ZU3dsM1dSTlRIS3RrQVQ4?=
 =?utf-8?B?VEEzYUhQOGJTSUxOcFRjVDFraDgzTm5LZ2djV1NLUkZxdHEya0wxNWZUNGJP?=
 =?utf-8?B?NGVrc29id0w3VE5lRTJNeG1YWnJ3WnVkM0IzMVRHdDE4VjduWU1PVlMzWTYw?=
 =?utf-8?B?NzJZSUxXMm1saHdOSTJvUEZ2c2ZXdEZxV3AvNEJEa2NKNTFGM1JSWU1UeE9U?=
 =?utf-8?B?Y0pFTFB2Z3pQVEVGTnRVTm5LMUlESkJZd0VDdzZzWGJDWENTUXFYOExpNGdE?=
 =?utf-8?B?aDdUMldXQlJWZVpYZ2c1blpCaCtjNHpaV1BmM0JmRXowK3UwSFlKREZKVlZG?=
 =?utf-8?B?S3ptUWYzdi94UHpqUmc2WHMxdjB3QUFHcVd1MVJxT1J3QnUxVWl3YmIwb1c5?=
 =?utf-8?B?Q3dqQ0JOYXV2N3RVMTZpRHgxdUVuTWNVRldCdURVbUQ0dVhhOVMySWpiV2px?=
 =?utf-8?B?ZlNmbis1c1RXRUl4c3h2dEdETGJHbWNYZGthNjFtQVNBYVJlQXdpZlBpQVZx?=
 =?utf-8?B?eWtjNHZTeEkrZ1RFQjZoUmNISk83dEZRMnVXOGorcXNxNGxIYzM5bHBqMFVa?=
 =?utf-8?B?T0FnR2d1U0ludys2UDJtbjBzWFptd0R3enZKZW9Pb2tTc2VEY0ZWaDM3UlJX?=
 =?utf-8?B?dWp1U0RNTGJ3TmxBR05PMldkVU1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa03bf5e-c133-41a9-fbcf-08dbea1d1ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 23:04:52.8473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yS062I34CLTuqC09VNyUfAIbIJ6GhPcVg5m/+ZHeJPRa04mbe8GlzmYZfivX7HCsp4SQhxYmzBCHps2npXlAxnoppzUgohSX9yYF4lG2ySsgzEt5l6qvdHsthKbLeXWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLCBNYXJrDQoNCj4gPiA+IC0gICAgIGFyZ3MuYXJnc19jb3VudCA9IChvZl9ncmFw
aF9nZXRfZW5kcG9pbnRfY291bnQobm9kZSkgPiAxKTsNCj4gPiA+ICsgICAgIGFyZ3MuYXJnc19j
b3VudCA9IChvZl9ncmFwaF9nZXRfZW5kcG9pbnRfY291bnQobm9kZSkgPj0gMSk7DQo+ID4NCj4g
PiBJZiBteSB1bmRlcnN0YW5kaW5nIHdhcyBjb3JyZWN0LCBmb3IgZXhhbXBsZSB5b3Ugd2FudCB0
byB1c2UgMm5kIERBSQ0KPiA+IGJ1dCB5b3VyIERUIGhhcyBvbmx5IDEgcG9ydCAodGh1cywgaXQg
aXMgdXNpbmcgcmVnIHByb3BlcnR5KSA/DQo+IA0KPiBZZXMuDQoNCkJ1dCBobW0uLi4gaW4geW91
ciBjYXNlLCB5b3UgbmVlZCB0byBzZXR1cCAycG9ydHMsIGFuZCB1c2UgMm5kIHBvcnQNCmlzIGFz
c3VtZWQgYXBwcm9hY2guDQpXaHkgeW91IGRvbid0IHNldHVwIGZ1bGwgcG9ydCA/IERvIHlvdSBo
YXZlIHNvbWUgcmVhc29uID8/DQoNCg0KSSB0aGluayBhbG1vc3QgYWxsIERUUyBhcmUgYWxyZWFk
eSB1c2luZyAicmVnIiBwcm9wZXJ0eSwgdGh1cywNCnRoZXJlIGlzIG5vIHByb2JsZW0gaWYgd2Ug
cmVtb3ZlIG5vbi1yZWctc3VwcG9ydCwNCmJ1dCB3ZSBkb24ndCBrbm93IGRldGFpbHMuDQoNClJl
bW92aW5nIG5vbi1yZWctc3VwcG9ydCBuZWVkcyB0byB1cGRhdGUgbWFueSBjb2Rlcy4gDQpCdXQg
eW91ciBvcmlnaW5hbCBwYXRjaCBpcyBlbm91Z2ggZm9yIDFzdCBhcHByb2FjaCwgYW5kIGl0IGlz
IGVhc3kNCnRvIHJld2luZCB0aGUgY29kZSBpZiB0aGVyZSB3YXMgc29tZSBpc3N1ZS4NCkkgY2Fu
IGNyZWF0ZSBtb3JlIGRldGFpbCBjbGVhbnVwIGNvZGUgaWYgdGhlcmUgd2FzIG5vIHByb2JsZW0u
DQoNCkJ1dCB0aGVuLCBJIHdhbnQgdG8ga25vdyBpdCBpcyBuZWNlc3NhcnkuDQpJZiB0aGVyZSBp
cyBnb29kIGVub3VnaCByZWFzb25zIHdoeSB5b3UgZG9uJ3Qgc2V0dXAgZnVsbC1wb3J0LA0Kd2Ug
Y2FuL25lZWQgdG8gcmVtb3ZlIG5vbi1yZWctc3VwcG9ydC4gQnV0IGlmIHRoZXJlIGlzIG5vIGdv
b2QgcmVhc29uLA0KdGhlIHRoaW5ncyB3ZSBuZWVkIGlzIG5vdCB1cGRhdGUgY29kZSBidXQgeW91
IGFkZCBmdWxsLXBvcnQgc2V0dXAsIEkgdGhpbmsuDQoNCg==
