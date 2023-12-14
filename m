Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D312F8133B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573581AbjLNO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjLNO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:57:45 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2117.outbound.protection.outlook.com [40.107.13.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37CBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0ebI42stpET/uZZCGY/XPekFE9fG2NxkxwxSQIMMM/UgjmD1RC0UgNP+0hTow6woooqR4x535WAfhqT+0JGWbHQe/OgPVQ/R/OmXW/e7v35R0h9xbajoXq4K2Gmxq+3yMloCJOlFIN7ibczW7BG7iQBicxXoynoJXtklJcINTpvTTTUbVQXNWK/HG5j73Z9+pLY+Z48a9P1hFvOc9UrjBazpOG8nkWhhF3XnMB+jPdZw9BCvRuAzZL/btHdLs7t+PNWWn69I6zThdgnJS/jgntNhYdgStu2D1x4T1rykKu9ggB2bAkk5ZcCp1FiT1GjtghgaMKQeb5/3rbRosyWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJWdTE9ePSQHucXstcRe1JhrnpPoUfKAW0jrFLBI1UU=;
 b=nrRmALG669a6mBlLIFvWSUMj0+pArQPGvOHgzFuhbKnamlDdiNQI76a9dk+6sBHQu54UGcs+iYul0LUW293N9lbl6NgZuSMVDmj9U1P1lQBWyw7FVMOW+JJWbiZgDv3g1iJ5ZPz/nkuW+qo+gMMymyLDmJGacvYEpvp7UGyXl5okPo5URxZxwA1beE4Z1G+EMzxxtePB81rMcJlwCZpCvru0NAiIOe26xHFs5R2zvWFLWNO4fYGd0EA4TYtBV+vtAknxA4N5IgeFEmYrOaGGSFZnnAZ0zsXAlVNSzKX3/UXABsDJeV5bqMHmyu/SsJ2LusuN9HoedpJO8WIR2ZWyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJWdTE9ePSQHucXstcRe1JhrnpPoUfKAW0jrFLBI1UU=;
 b=mqXKcedzz31RYm24cTf/mxTTrMbMKlvBO6y8U7AOGrqD+QRM7DyI1a4HWPih3WFSN6BXcB0Km+IAXfvNK1TmVCcm8UHR/I29kdMfjrkkteCqhYzXivLD3tRAfGA//APkKdmNKUgL7MkOipef2BnoAKBDZOJJIL+os1xlgBFeJjA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB3PR0302MB9160.eurprd03.prod.outlook.com (2603:10a6:10:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 14:57:47 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 14:57:47 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Joe Perches <joe@perches.com>,
        =?utf-8?B?RHVqZSBNaWhhbm92acSH?= <duje.mihanovic@skole.hr>,
        =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] get_maintainer: correctly parse UTF-8 encoded names in
 files
Thread-Topic: [PATCH] get_maintainer: correctly parse UTF-8 encoded names in
 files
Thread-Index: AQHZ/sMhBcic5kyOw02EooPWkwpkuLBMfwoAgACAqQCAABuLgIBbOrMAgAAJ/YCAAN5XAA==
Date:   Thu, 14 Dec 2023 14:57:47 +0000
Message-ID: <ttycax5vbxx2lnuzdjrhi7kyaryzzwmz35b4pqs3in2skpanto@nl5fdzlorm5x>
References: <20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk>
 <5719647.DvuYhMxLoT@radijator>
 <fdb7c6312ea52086566e279918b5b873c687fecd.camel@perches.com>
 <dzn6uco4c45oaa3ia4u37uo5mlt33obecv7gghj2l756fr4hdh@mt3cprft3tmq>
 <b3th52nczdpeokggs2ogdnxq36m3jfhrw72ogjhlvnn53ocxy2@s6uhcbdgaowg>
 <CAHk-=wjZnfj2=yxokkCcpVdchY-NKwDO_Sh99Rtz7cWqb9OP3w@mail.gmail.com>
In-Reply-To: <CAHk-=wjZnfj2=yxokkCcpVdchY-NKwDO_Sh99Rtz7cWqb9OP3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB3PR0302MB9160:EE_
x-ms-office365-filtering-correlation-id: 9f1daaaf-efe9-46d7-7b96-08dbfcb50907
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+IhR2BRDCtqs7PhE5Tp50DkJP+pniPPEJAfX2YLWdfTkDx8oxJLnAQG/X/VY7ncJj8jnqqp8Rky1mkEhpHDkLIVU93uBIUbpUEpchh+P46MUmI2TttvxUuY9bhT0N7dj1UKd98boF8viy+myn2oYEVSrbs2xeGuVWGRLa6KqocKs9IPDi2LeXCzXpD94kb/PbGnemLaAQcnfQi90qeYWifhmsYXFP1oPURllbCnmurPCJUN/9xVKfqgvmy8OkIDV2u7vJW6fW1yGT/DnJtX4TA+T8562IvP9DJtQZ6p000vbTy81ed3IbJTAFH6wsjjVaAzeBYNCa3vrXX3IA6nCpDzNrjDh2JXqJdH+jps4glHE/Hc4/z78VNdpQt+RTpV3XNF4nS1ZLcXVXZ62VzACBaf7j3AsIIhj4gW/P1gAbSiRI6GWqf89awyhwT+djLM/6qY61UG5o/e0RgS2govp/R1dx52+QFQaXISske6B9gcC+mLjYTGgvBvsU9agdJLVSl9ZywdzRkjqINDJ9glJHvCJrKIO02QUesW+/bo5mrshO3bzRH3vpQZw7Pr0+v1FTHIBLzYhfs+JOdJdnKss6MSyDXOzi+rU1HLMsJKTKsULoCyKvxsEDhhFpv9ZL2Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(346002)(396003)(39850400004)(1800799012)(186009)(64100799003)(451199024)(6486002)(66574015)(6512007)(9686003)(8936002)(4326008)(8676002)(71200400001)(83380400001)(478600001)(26005)(91956017)(64756008)(54906003)(6916009)(66556008)(66476007)(66446008)(66946007)(316002)(76116006)(6506007)(5660300002)(122000001)(85202003)(2906002)(4744005)(41300700001)(86362001)(38100700002)(38070700009)(33716001)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBMZysybStzdUxrazUybGhuelh4VEJGWnpKU0VIcjZtY2ZIYU51QjREYko0?=
 =?utf-8?B?ZW4wYzBnUXBRaXpucENoUzFqdjJqQzdXOUJUaW1LYURUOHB0RDEzZlM0b1VO?=
 =?utf-8?B?ZU9QRllUZGhoUUdyVWFpSVhtMnJvMmFVc081QzJRZU1VaHpVRWVWSmFYODRC?=
 =?utf-8?B?YytIVlZXWWFUR2h1SGtZT2gxVCtWZHNJQ1JQTVhjNzEwWGVXS1E0RkpUVkc0?=
 =?utf-8?B?RnNlZVdqVzViQklPbGJKb2RCUld5RnY2TDZnUTlka2RYTnVRZ3BKN3RZMEla?=
 =?utf-8?B?QkRKbGpnbDJ5dHN6enRCYmtMcjFUYjdUaWdicnhSNG5HN1BXRVBSYkhDUnBz?=
 =?utf-8?B?OWVCd0VTTHRnLzFicm4zY2RaRG9kdEtQWEgzdkwrM3NZcE9OT3N0NTZJbzJu?=
 =?utf-8?B?OHVUNjNkeEYzMUZTU2pCOE9EVmlHcVQrMTErQ2JIbkV1eWhaL1R2aVd0cUZ4?=
 =?utf-8?B?UVlPU2QxNXVSVjNyK3VraWtaaGVpQWhZbktGZ3FYdGpKZ0xrZGEvRDB1OVc3?=
 =?utf-8?B?NXI3WGdISmdDazI0YnFwWm9TQ3pRazZDZ2NOc0d6ZmlrZTBHdXB4UXB3YkUr?=
 =?utf-8?B?am5zQUorZmdxc0NMN2xmZkJsdFdzQ3M2Z3J5UXNuRzFQUzY5UUV6S1o1MURF?=
 =?utf-8?B?WW00SW40b3JrS0lhL2gvV3F2NlcrR1A3ZThOdzdualVlMnlaVmYrd1lQZ0FI?=
 =?utf-8?B?cmFhSGY3aW94b090VGpTMXNFay82NEpuMzl6YkVKTlBENHpLSmRnVEdtclVF?=
 =?utf-8?B?YVdYcVJiVjNBUmdoVEJFSzc3aE5tVEduQXpKOGxGZ1ZmelZINnd0QUoydVJh?=
 =?utf-8?B?NzFOTEM1Y3Z3MmtVcmdscVdlTHgzWjNHY2JiR2h3L3ZnUVl4dWhDZ0pjVmdP?=
 =?utf-8?B?UFBoeVhCbTBxVExhb1JacUsrMGxoK1dxWG9yc3BINGc4azFFWWR0ZWczZEl0?=
 =?utf-8?B?emJKTFdBcFRDcDZQQW9pOXZuQk9xZllMcTBGUVFmTk9KdHUzL1ZUOVRjWjRH?=
 =?utf-8?B?ZDNwOEoxeXFYYlAzWW1ZV0Irb3d1YTl6a3dqN2xwYzkrNE1FRHZsbW9MTnJG?=
 =?utf-8?B?VEdzcGk3a2dLeFUxeHk2Y3JMbm1lSnV5UE9UZHFZTDJ2d2RPajBTdW9GTzYv?=
 =?utf-8?B?Y0hVVklBVzFvZWlPTHpodHNCZGFqbGhpQ2tNY1VQaC9yT3pVSDVUMHRVdnQ1?=
 =?utf-8?B?MFd3ZGRmL2Q0Z1lFVm4rTzRNcU56dmtFclVsQWVLbm53ZDFVeU1QZmUwZjdY?=
 =?utf-8?B?aXEvdHVTN3VpdnV3M0w3OGltQmFVLy8ydXRvRkZoVGtIcWc1MGZVQUVoN0tk?=
 =?utf-8?B?ZHFLNXVoUTgvdkU2ZmtteDF1UmtPeHc5NnlzL0N4ZjhwdG1sVVJsaklnelBT?=
 =?utf-8?B?WGdXdTg1RXJsSjduSFYrMzRuNW8yOWdsTG5INVNTK1B0MFhVU2Nsd1NhcDl5?=
 =?utf-8?B?SVg5Q04yaHppNkhKZWE1OFN1MTJJVWRsQkRodkxqcDliZHpsTGdCc1hicTlh?=
 =?utf-8?B?WDlwNEpNOUJ3U2dqaEdMVWRCWEZBS0dRWWNXUVZJcjBzUHY3NThXd3RaSEJ5?=
 =?utf-8?B?SmxtYTBjREUzU2t0clUyS0JNUDhGejJqL1gvZzNuTmFmb3ZZYmV6UG5xdFFQ?=
 =?utf-8?B?VHU3L0g0clJkUGQxMkJzRGNxOWpsclppK3cwQnBxR3NRMEh4cFVWRnlIUC9N?=
 =?utf-8?B?c3BsUUg3TmUrOS9UNXZ4Y0xCTGp4ZEtLbnZKM1owcmZjT1JKV1d5a0xQUzJv?=
 =?utf-8?B?cXBFNytvRWl6dlZ2Nm9YTlA2Rk9PTnlhM1ZhVGhyNGVHa1UwSTlPc3BUcXo5?=
 =?utf-8?B?djFvYnRNaWFvUjlKUTl0WnJNUTlCeWJHb0M0MERxc1kxSERMUlYyUjdBNnV2?=
 =?utf-8?B?Q0ZoOU5BYzBGM0tUdHBBdXJrNzVrbjJaK0tyQXpuMVVZM0ZPbE9hUDlRUVo4?=
 =?utf-8?B?VkV4eFZYMzZqUmZhMTRhMWg5WlE0alJGWlpNY21uM1owdnJpcTlXTS8wZUV1?=
 =?utf-8?B?ankwWTBzNzBwR2ZIWVAzdTljQVJvd09DK3Ivd0lrR01nVDNNQ0hjN1VyTmNU?=
 =?utf-8?B?MlpjK0kySjlPdGd6OGJveVNLN1B6Vkg3UVYrRXBSdnlzZkR0bFNkWFFWOEJW?=
 =?utf-8?Q?pxxReYhN6HagqbN4aV6RdkfQw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5120548C25B6B47A59893E816CF9280@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1daaaf-efe9-46d7-7b96-08dbfcb50907
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 14:57:47.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7b/SLiSUjRKXz8eiGSjJX0EsCO3CqISBvaAy6AqQXE0l2x/wIh5zsQtSuLQlChuPty7I9UjcV/wXiZo5NMfUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBEZWMgMTMsIDIwMjMgYXQgMDU6NDE6NTlQTSAtMDgwMCwgTGludXMgVG9ydmFsZHMg
d3JvdGU6DQo+IE9uIFdlZCwgMTMgRGVjIDIwMjMgYXQgMTc6MDYsIEFsdmluIMWgaXByYWdhIDxB
TFNJQGJhbmctb2x1ZnNlbi5kaz4gd3JvdGU6DQo+ID4NCj4gPiBTb3JyeSB0byBiZSBhIG51aXNh
bmNlLCBidXQgY291bGQgeW91IHBsZWFzZSBoYXZlIGFub3RoZXIgbG9vayBiZWxvdyBhbmQNCj4g
PiByZWNvbnNpZGVyIHRoaXMgcGF0Y2g/IE90aGVyd2lzZSBOQUsgaXMgZmluZSwgYnV0IEkgd2Fu
dGVkIHRvIGZvbGxvdyB1cA0KPiA+IG9uIHRoaXMgYXMgaXQgc29sdmVzIGFuIGFjdHVhbCwgYWxi
ZWl0IG1pbm9yLCBpc3N1ZSBmb3IgcGVvcGxlIHdpdGgNCj4gPiB1bnVzdWFsIG5hbWVzIHdoZW4g
c2VuZGluZyBhbmQgcmVjZWl2aW5nIHBhdGNoZXMuDQo+IA0KPiBUaGUgcGF0Y2ggc2VlbXMgYm9n
dXMsIGJlY2F1c2UgaXQgc2hvdWxkbid0IGhhdmUgYW55ICJMYXRpbiIgZW5jb2RpbmcNCj4gaXNz
dWVzIGF0IGFsbC4NCj4gDQo+IE9wZW5pbmcgYXMgdXRmOCBtYWtlcyBzZW5zZSwgYnV0IHRoZSAi
TGF0aW4iIHBhcnQgb2YgdGhlIHJlZ3VsYXINCj4gZXhwcmVzc2lvbnMgc2VlbSBib2d1cy4NCj4g
DQo+IElPVywgaXNuJ3QgJ1xwe0x9JyB0aGUgcmlnaHQgcGF0dGVybiBmb3IgYSAibGV0dGVyIj8g
SXNuJ3QgdGhhdCB3aGF0DQo+IHdlIGFjdHVhbGx5IGNhcmUgYWJvdXQgaGVyZT8NCg0KWWVzLCB5
b3UgaGF2ZSBhIHBvaW50LCBJIHdhcyBiZWluZyB0b28gY29uc2VydmF0aXZlIHdpdGggdGhlIGNo
b2ljZSBvZg0KJ1xwe0xhdGlufScuIEkgd2lsbCBzZW5kIGEgdjIgdXNpbmcgJ1xwe0x9Jy4NCg0K
PiANCj4gUmVwbGFjaW5nIG9uZSBsb2NhbGUgYnVnIHdpdGgganVzdCBhbm90aGVyIGxvY2FsZSBi
dWcgc2VlbXMgcG9pbnRsZXNzLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCktpbmQgcmVn
YXJkcywNCkFsdmlu
