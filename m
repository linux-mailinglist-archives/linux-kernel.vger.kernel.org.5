Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA77A72B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjITGTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjITGTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2114.outbound.protection.outlook.com [40.107.114.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C7B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 23:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDo9vIAsRU1TKUzs6OlHBVR949ums36jeoa5Af6OCPHH0HJBEJ4SCQ4N24sCm8uI4cNkGRux2AcWXGY1UyPANif/UFbZkjS3+g1bwihG5PV1fB+MRblj18ZtcwskgkPob8fDUPc3FA/VtC5ZjccKfkaF0oRqeYPVZL83iKeL87nIwrnANjub6ANICU4Q20oEfWGl8jlYGqRFfevwgbdp93Q/Vu399Qw06mvqq0fTpJIAMnUPgFJwjw2jI6QTR1Od49juAWkIKJFj1u6BxBaubtPGERBQmnyexvaJLDYKm02GJCPPXCveVxs2ylafS+oSUu1BXN8OT466lvB53YUJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAXWOLIrkgLkGOXI9geJCKCvV9vdbZqeS9wG1wzUSzQ=;
 b=BghBFZ90jucm8FWwbmkCSkKZcPX1ho4hdpgkztYemyIEzcgeGrdFflBTGpB38ZEm0irNaS4nl6n5tO02/ZSlxjJSXsQPw7vGlz0SV7UMd2T6VnVYi/+GSZkJUDOYHZUSXqrOuySPtK23qTJxX51tDitu51ctnJpui9WjL2ecm+3XWa6caPd2lmhU9z2dRmvekIiNaM06EF/8G6dPnEfbzag2UBZuBfTCyQxoBP38X18geTRgfROlVvcLfG+hcU0eUrl0vPOUK1f40tHYuHuOAOL6zMsUSueS+fcRniCdvNGLL52TuyueTnUotfpnAUog4ZezNgSKzUnbH3bQqVOssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAXWOLIrkgLkGOXI9geJCKCvV9vdbZqeS9wG1wzUSzQ=;
 b=TqRqdw8WECqJx2iMG++WBSDkUgqOk0i6GeKS/Cks6KlDQcDrDzKriXHcOrv2ibZAw4NEgK3g4CWwfbqsEoeBPOW3YXkqBgjYj+u4fBbmE/6Czl8y/Wjwci+KdX6F5wsLo8YTFsOANbFEjO/Arsy29kVgwBjL8PZQy/or98dLGrg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8248.jpnprd01.prod.outlook.com (2603:1096:400:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 06:18:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:18:54 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v3] mfd: max77541: Simplify probe()
Thread-Topic: [PATCH v3] mfd: max77541: Simplify probe()
Thread-Index: AQHZ3Dxyc5HSAi6RuE62fpzMHWxMxbAiYjKAgAD5xqA=
Date:   Wed, 20 Sep 2023 06:18:53 +0000
Message-ID: <OS0PR01MB592294617B806A39AFDF142286F9A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230831185329.70472-1-biju.das.jz@bp.renesas.com>
 <20230919152409.GZ13143@google.com>
In-Reply-To: <20230919152409.GZ13143@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB8248:EE_
x-ms-office365-filtering-correlation-id: ed42298c-4967-4b66-2ac5-08dbb9a176f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oR9n0+jKAQlFcjyk+6Fl2yjoof13lsZuMhUNQHmZWvSSTbcqfzbd6Pt3wS7XQ+Fb7xh+dZpNRtHzRn8n5LGcib3wilOgfJPFbGD6CWNSO2WqP5v8Jo8y+mEApRCjwtFLRBVlAuSXULeG8i3qXwgY36pCMPIfNona04TsCStHPbB8gt8S+nKXktGwtVsnsJ6aemSBG24eW7YjjquQvlHxvP3rHPgNbUvcSmLpotx/wSFPwarZfpdp+sni+ugAJqsChwNkMBkoa2aKnCY20WrF5R2nOa08ItTA32v9GpOXMm6PqwKvpaGv94mp19gled3KvZBtkV97NDvl1q+wEHPzy+43o42ZsRfgXmhqRk11QqdzRQ0So6YKISycMeSaCYtsF8YVIdd4w9b52SmG3gBw3Vuva2yE4IknrmVACQWdJwp0Bfs/wuAbb1g4jbJmR4j9PsytCYYlj0lFIcIfJl2CUYmejaXvfuypkg5GDPmWNlztYCd5F/zvkdv0D1js+W1UKkX4Tma2H4ntjeng8MMAOkvXstPVhPg7+WYU0RgGFsCIW16VJx/jDmiA9LSFiYFrOvaUpjG0BjmT7jx+EiD0tcZRC73v21h0OQqlrdC9+mlpWaJXU+S8umJtVpxTPD8O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(71200400001)(55016003)(38100700002)(4326008)(122000001)(66446008)(8936002)(33656002)(38070700005)(64756008)(54906003)(41300700001)(9686003)(76116006)(66946007)(66476007)(6916009)(66556008)(8676002)(2906002)(4744005)(316002)(5660300002)(83380400001)(26005)(52536014)(7696005)(86362001)(6506007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVBNSDlDYXJSU0wxM2FwT3FTR1MyaHBLMnZ0VUVNd3E5VCtDdnI1OGF6bHpa?=
 =?utf-8?B?cGRlVUpUbjVBZTRhdlo1b0kyajRKMjZwSFJnQmV0WlBtbVhvVndQRVhqUkRa?=
 =?utf-8?B?S1JpQzZHcms1QkpTK1JFdVVoUjV4YW40NmhoSXUwNW1pOXE3OTl1aHlMemVq?=
 =?utf-8?B?bXd0YU1MSDRWOXlRMHpHU1NCQ0R0dkRGcFhiVVRnS0NVaSthNUw3bDdmeDNP?=
 =?utf-8?B?VWtHaitPRjRTR0JMTHFsaVFobnZ5MjNqTEFMNWRWS1ZrdHdKNThSRWFmYzd2?=
 =?utf-8?B?M1AvZ0N0cmR2Mk1nVk1BZjVNelIwVzdDbDgxd0V5Z0Q1ay8xZWRvZ0hiSUM0?=
 =?utf-8?B?Z2pxVGNpUzJvUFRwdlZ6cVN3OUg4eXRBdDFDWFo1OVVodFdxTmlFOW9HQmVz?=
 =?utf-8?B?NEZLeDRHQ2Q4WUN0QkJLQjhRVkkxVVVuT2RWWEdrZmRJdWFzeHBtbUFuSlVK?=
 =?utf-8?B?V2pZMFFZQ1YyNXhQeXVpLzNpWWF2QmU1ckdwZ3J4RjJ3bURmdnU2T0tkQmdn?=
 =?utf-8?B?TGNFTHk4U3lJenhPNmxHNG02N2plSE50ZjhIYXFjSU5CSFh5eVZ3Q1k5TWVW?=
 =?utf-8?B?VDZMMXUxMWhxbnhSUE1GMWJmcW40TXRTbitrUUh2V0RHYzhZVXNrTTh6V2Rs?=
 =?utf-8?B?Nlg4dW52TjVkMEp0MzNwMGQrL3g0M0FPYm12Z0E5VUg3Si9iR2ZtdFNicDIz?=
 =?utf-8?B?T29lMU1aZ3NybzRPVkx1RmNCQURtNHBiUDNyVDhvTFpsZnZZR2tRVkJJUmVT?=
 =?utf-8?B?YkZaZWVLUWRRQTBhL2I0UXlVeEFISkw0UnROOUM4b0VyL3NnbWNXUU10d1N3?=
 =?utf-8?B?VE8rNHZIVStxbm5hNDRhZXA5UkhvRERGM2kxZWdQaytwRWFwRkc3ME8vem5O?=
 =?utf-8?B?MG56Z0lONi8rQ0JpaC8vWlZDRzk5Q0xwK0JiMTBuNUJud2t4ZTNCakVuOXBO?=
 =?utf-8?B?Ukw5SUEvZjZYZlZPYmVjV2F2UlhBb3V2bisvNGhXZW50Q3VZaGh5TFdSN20y?=
 =?utf-8?B?UG1id3Zhcngxcm5hRFBVRVUzM0xQMEp6Nk9ZOFlsb3p5YXlvS29EMytQMGVq?=
 =?utf-8?B?VXZ2TkUxalhydHl2akF4QThoWjhCYWlxdENuRmlwRUsrdjNJSG83ME15blNI?=
 =?utf-8?B?YlM1dWlJbUJ4QWRCcFhqeWFIdkY0ajhMZEpTZ05McEhzaVJTdHpVbEkzeEdW?=
 =?utf-8?B?Ni92cTZBdUhrYzVuZGhvUTE4a3ZMelpYVTQrQmM0Mnd1cVVvcWdLL1laVDZy?=
 =?utf-8?B?N2V3MnllNGV3MkpTWnF5dE5PVWlkNlowckV3b1hOVHRUSnFBbFhLVXczK0J6?=
 =?utf-8?B?NDlNcDVrQUdFdWZ4OXc1Wm9tdEF0Uk9MYm1abk0xTGxVZ3JLU05yUkFoQUFM?=
 =?utf-8?B?Tnl4cFZaMnI5Y2lIek1FV2ZWYXMyQU9IMTcvWGtGeUh0aUpGWlBiOG5vM2pR?=
 =?utf-8?B?V3UwQ0xvdTY5azV2OW9RT3M0T2tVVkhYWjBGK2FCa1l1dUQ0UGlwSU5oTXJp?=
 =?utf-8?B?QXdBOUhqQThBOS9FSkFkVFc2QXJFemxFZFJVSU43REhJYkdmSytJaEdpUTN4?=
 =?utf-8?B?akpJYzNUTGtJMVFCZjZFZ25lRVcwR3ZBbmZ4ckZKem03eU90eHNlZVZmOWxi?=
 =?utf-8?B?dGc5cXV4OVBaS0dYVWw5MWo1UEg5OHJ4bVhpYWxoaEhuT2hMdjVMRUJTNm5G?=
 =?utf-8?B?ZTArYnlqcENVTXUxblZKbHhlMGZTTGNSWUZwdFNJc2g0bzZORlh6NWRnVU9P?=
 =?utf-8?B?c0VUdkR4QkxkbHhnVWJNN0Z3a1hyYmFIWU4wMlYvSGhISjhSYWVFRVVNZjZ3?=
 =?utf-8?B?blJQZXM2dFVQbWVtdDBEd3R5ZGNlVW1CK2lsNVNiT3Fyb0JCRWFxamJRNjJ6?=
 =?utf-8?B?YlZpLzZyNEFkRC80NGNuNnZSdmZuR1BXVVNtWDVpUm9pU2VYK0ZKN0pQZTl0?=
 =?utf-8?B?VlFnQ0I5VldWdGNpMkNBOUdLSURnRkRtSkI2cWRHV0JvUStwb010cUVXUTAw?=
 =?utf-8?B?Mm1QajRxNG03Nnh1eU5YTlp3RCtwVkZaOGxNd1pLV0hxend1dVE0U1haQzMv?=
 =?utf-8?B?MHpPOVJWNHIwRVl4bG9MLzY1Z21GeFFucFhrdTM1d2owMW01TGJsV2xON2py?=
 =?utf-8?B?R0pFRVdWN1B2Qi81aTBNdXNZRzZwV2FWRFJUUWMrNGZ2WjNjZmp5QmlqMzlp?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed42298c-4967-4b66-2ac5-08dbb9a176f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:18:53.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCW5RTl7p7w96WSkwyxB5wq11QRgd2rH45MrGNEBOLbMCdfHPlYY2eeldrIRwBarXzZioceIEGfDlWyvL8psXFC88DuVj0txPWcYLK4u00s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8248
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlIEpvbmVzLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzXSBtZmQ6IG1heDc3NTQxOiBTaW1wbGlmeSBwcm9iZSgpDQo+IA0KPiBPbiBU
aHUsIDMxIEF1ZyAyMDIzLCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4gU2ltcGxpZnkgcHJvYmUo
KSBieSByZXBsYWNpbmcgZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgYW5kIElEIGxvb2t1cA0KPiA+
IGZvcg0KPiANCj4gVGhlcmUgYXJlIGh1bmRyZWRzIG9mIHdheXMgdG8gInNpbXBsaWZ5IHByb2Jl
KCkiDQo+IA0KPiBQbGVhc2UgY29sbGVjdCBhbGwgb2YgdGhlc2UgTUZEIHJlbGF0ZWQgcGF0Y2hl
cyBhbmQgcHJvdmlkZSBhIGJldHRlcg0KPiBzdWJqZWN0IGxpbmUgdGhhdCBlYXNpbHkgaWRlbnRp
ZmllcyB0aGUgY2hhbmdlcy4NCj4gDQo+IEZvciBleGFtcGxlLCBJIGp1c3QgYXBwbGllZCBvbmUg
b2YgeW91ciBlYXJsaWVyIHBhdGNoZXMgYXM6DQo+IA0KPiAgIG1mZDogbWF4ODk5NzogU2ltcGxp
Znkgb2J0YWluaW5nIEkyQyBtYXRjaCBkYXRhIGFuZCBkcm9wDQo+IG1heDg5OTdfaTJjX2dldF9k
cml2ZXJfZGF0YSgpDQo+IA0KPiAuLi4gYnV0IEkgZG9uJ3QgaGF2ZSBlbm91Z2ggc3BhcmUgY3lj
bGVzIHRvIGZpeCB0aGVtIGFsbCB1cC4NCj4gDQo+IEZlZWwgZnJlZSB0byB1c2UgdGhpcyBkZXNj
cmlwdGlvbiBvciBjb21lIHVwIHdpdGggc29tZXRoaW5nIGJldHRlci4NCj4gDQo+IFBsZWFzZSBw
b3N0IHRoZW0gYWxsIGluIG9uZSBzZXQgLSBlbHNlIHRoZXkgZW5kIHVwIHNwcmVhZCBhbGwgb3Zl
ciBteQ0KPiBpbmJveC4NCg0KQWdyZWVkLg0KDQpDaGVlcnMsDQpCaWp1DQo=
