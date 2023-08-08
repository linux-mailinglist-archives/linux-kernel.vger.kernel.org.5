Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32850774C7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjHHVKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjHHVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:10:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3AE10C6;
        Tue,  8 Aug 2023 13:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIrMHzYcwQeA1r/71LBCDXU800N98Z7j4ON3h7ljtU7Dhrf5V8/mRmxtaEtH/8vKV6LIPZ28pyq2cBB1UyiWmD1oXvidFZiXsZmiNBMwhTTaqZQTINxto3x+hZb55K7EJ17TBRiVWC0JgHRs73tXs0chZWQUFzu7ddJxZWJnTErwk+qAH8ez0vJYvchrIWpleRwGv+CYdhL3JPzT/iKlScDyP6Nl007zD4f+EQYXkQ598YQ9rFlHcj9639w8J+lXGurnIY8sLSW5ogxE1m11iarsXNPThtN5iVO6YteaMj2vXkc4LJXfiJ2GbcCbnWRgIlaJIg3HkZSAiByqdJjztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsmLJpmiyjbvMy1bhSEQLRpIBdpezc5FQRZuWuew1Cs=;
 b=aDKs5I4170ckVz+UQzmfADMIs4Yw8QHPsaf4VpAcLpm/wtV8p15KFR1ahGFIYGPjD0m9TPsaBXvGERreZ6xUvxFh2BQkLZq/pWDHbz3mOobFEj+PIG6rjuLkfwN1CCGyMjtfE6SDEuVe/p1u58BwfMCMQ04kFcELl/O11yLYBeZ24VMQqj/O1lD8qNHJGP6TIgD59ZyoKiMNrmPMF+MyZdXT+48YY5fOX5WNkyUbC8GfPj0iFWmBgmqOhXBbfon6e0Aep2TlyEXRW14qPUh+DcqNvo0IoOlUM+7Ls2hUXADVxhd2pqVVgfjNDQFEpGCYt3e53drPNInMxzAiAAWE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsmLJpmiyjbvMy1bhSEQLRpIBdpezc5FQRZuWuew1Cs=;
 b=wW+K1UU9OqZ6SRk/YlWq/bIlEbRazVSChmxe8y8yF7VpkV6243CDAumOUasP9PMDLFMeVGpPw+TN8W4vgqBYoD7LgIebdt4bAXKbOcxacoqM5FDXFXPPSS5jG6TdLdsGYgUOKlI97exhEhcS8AzzU6YRdlMZxVSNgEnVQKYAvcE=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:39:14 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6652.022; Tue, 8 Aug 2023
 20:39:14 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/LA4yAgAK8ytCAAYwdgIARmeKggAAFgwCAABEpoA==
Date:   Tue, 8 Aug 2023 20:39:14 +0000
Message-ID: <PA4PR04MB92222D4A70BC88DD24E6B8499A0DA@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
 <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <8686c5c3-81b0-278f-d81b-0c906bac62a8@roeck-us.net>
 <PA4PR04MB922285C2DC1BB0BDBDD602B39A0DA@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <c46e24e0-b054-e59f-34bc-e5ddcb93b6d8@roeck-us.net>
In-Reply-To: <c46e24e0-b054-e59f-34bc-e5ddcb93b6d8@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|AS8PR04MB9128:EE_
x-ms-office365-filtering-correlation-id: c08e8f20-83a8-4c02-2238-08db984f877a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bik4koyaYLIcAy8t1zmyFxFwGJaYKNhvh7Xgtupq31HiumeAevVtdbE36gfIyAoG3STRV2c2C+zR+NjAlC7ae9tGXTfgoY/GdSsIuBOuXllGTSMCxrpffxt8S1I1znfXrmVZOU2m9raJabotEFHYKMshKLtQmc87s/djICf5LYUHBXPQ1TfUwS/YaSzVU6Xk7+PjoohljdEkpRqvzxcDTYusqhYA2pKBcgRYVGcABtxe7XAU/nxy6moT/0R2EujJzL1Rq2/ZJeB3FE4LMV2+mpIHQ4D+JFseRNTkIWjTtMsanZODiF5mO2MPB037vgStZOWaDmmcfSNnSKIKljIuiwE/uJQ/EJcooGOHhE7iNMSQXdloLZ9uFHaFhYwXgjvpFtzoaT78t2T21EysmIFU1Y2SZF7QHRWdkxtZ1LTkVriL27J18J9ZeoPVMUvqoabeJw8QVB5HuCf3ZiT0H6fn6zErrzGNj0I3h0ffu5D1kj+d/W2aBUaaUinstULfCiREBZFKqvqrMDWBFa4ZbjzECTnDtHCItUREZUDOcS2dPm4ArfbQbytpEJuqyUSoFArjxekQ3+08rtbObCbOi9SB/oMQovqk5/B50fnh4WqQl+ZaLQbFuS2I0C/YVzQs4soV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39850400004)(376002)(186006)(1800799003)(451199021)(122000001)(478600001)(45080400002)(921005)(83380400001)(66556008)(9686003)(53546011)(107886003)(6506007)(55016003)(33656002)(64756008)(41300700001)(76116006)(316002)(8676002)(4326008)(8936002)(66946007)(66446008)(2906002)(7696005)(71200400001)(54906003)(110136005)(38100700002)(66476007)(38070700005)(86362001)(7416002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djQza081czM2ZjROdEFQMjFCaFg1WU5MMEl2cE44S1VFQ3U3aUpxOHp2WDhR?=
 =?utf-8?B?dHVzMjhDaCtoSjRlMk5haTVvelNhYU9ScktUaFpQSHdxUEZ2czJEWXhuM1Fn?=
 =?utf-8?B?RDdZUEwwbW1yNFY2VjM2bWNOVkZRbzZZeVdlb3RhNjZudjdqRnF1Q3IwVFk0?=
 =?utf-8?B?NzBoMGNiemUrZlY0MmtZMWJOWCttTGRiMXhJdzd5TUlCK1ZsUGhTNUVjZ2NL?=
 =?utf-8?B?RXJiTUpseUZWbzRYOTczeDl0cS94aUpQN2FtU3hyQ0VUeDNCNFViUDZwMnNC?=
 =?utf-8?B?cHE5U2Z6Z3F3K2NzdXFpN1dJU2VJSDlTczluTjJhTjFaV3dVZjZqZ01XdlhX?=
 =?utf-8?B?Z3laYnY1Zkk4aExXYWVmdFRvb3BrM09rZUdDclgxMDZjeWZ5ZUF0bmtiVmxD?=
 =?utf-8?B?eGFPSXg0cW9LNHhGRDJJblk1UHBqdDZZMmtPbTBRYjJFdSsxVFZSOEYwazhF?=
 =?utf-8?B?R1RwVFRTNDNROVJkMzEwQWJSa0RyUWJTeE1Pa0hCWjQ4OElmQkRaVm1zM3I5?=
 =?utf-8?B?QjAxS1ZMRDI5SExPL3JVRnBwbW56MW5LcjR6VUJoT0FJMTc3b2N3OVhScm9h?=
 =?utf-8?B?SHdvOHc1bkdNMjhsWjJDSVFqZk9saVBkLzd0TndTRFJJc1hHTVpFOEYvNjBL?=
 =?utf-8?B?VTNxU25KQTFla2cwOEtxbjNsZ1pKUTNTWVI1a3F5cGYyaEY2VFZCcVJFMVA4?=
 =?utf-8?B?THBpd0lYQWV2Y2ZBaTVHdnA3bjNCMTlaN3lpeXgzdWVCN0FlM3FaVnFTUDNp?=
 =?utf-8?B?cU1jTjdTM3hSelVVNlVYVTZrTm9qdDlQamdNU3JrOXlrVzZyUmVqM1YyUzlT?=
 =?utf-8?B?YzhIVjg2ZHJCYUd4M1N4VzZoczRmSGQwWDZVcWVKUWFyN2ZyMW44RHJpQ0dU?=
 =?utf-8?B?U3A3NFMzQVR0OXFIZEVzTjR5NVZXT08zTEEyVEsrNjU1TVBUMlZCaWNzQ004?=
 =?utf-8?B?T0ljNkVNRmUrVVBhTVlaRXlpUjZTcXM0K0RwQ2FLMXlacmdweFNRek5QN2lR?=
 =?utf-8?B?aWlwSGEvb2NkRWh3MFNNclF1clZhNFA0TTBGTzlHRnVZbUJjTHE4T3FFN2VZ?=
 =?utf-8?B?a3F6emg1T0g2Y2R1R2ZQRnAyd3B3OFRabWprSUJNR0hBOXFpTktuamtrSTk4?=
 =?utf-8?B?TjlkTHR3bW56ajh1Z1QvdHZTNVU4ZTYvRXA5Q2l2bVlKUlJ6RjF6U1liWEhJ?=
 =?utf-8?B?R1ZPdzZBNGw1S2JFS0lMR0l0TU0vNWNhbVhFUmNlUDA2MllkSWs2QkkzV3Nx?=
 =?utf-8?B?cmRBb1RTR2ZIQ2czMXhNZ2lXMXdKVjE2Rm1nRzQ5ZXpyRktXSjh4NEJDVFZS?=
 =?utf-8?B?WkkwLzVmaHhzUEcyMDI1WEJrNDBFd09mclVnMTFwQmlWYlMzNTNnNjVRUnNN?=
 =?utf-8?B?RGFQV29zeVNRbW5OTkxkQzlsWkNEOXJoeFJEZGxBMkpMR2xPT3Q5T1dCR1pO?=
 =?utf-8?B?L1BDeFh5U1NDMmJheGlCZys4VTZiSDQ4UzJUaGhpdzlKUVFJVXFBYlowbzlO?=
 =?utf-8?B?UWhvMy82YXlrblRBS3RPRDRZb3NmL2VGSUFWK3VkTnVNKzFIU3VqMEc0bDdx?=
 =?utf-8?B?bGdDMjcvdWkvZnJ0Q0syNk9rSFVXQzVFd04yelI2V1orSXNiNkNCQWR1RS9W?=
 =?utf-8?B?UHdoUFpFN0pLczE2NDB4YmxraS8zdEM2TjFUdjVEZVYzVVpiZ3QrUkF6dHVR?=
 =?utf-8?B?U3ozd1pRQXpYNnVUWCt2c2MwL0xseTFyYWEwN2k3M0kwbjdyMElFMDNaNmNk?=
 =?utf-8?B?Zk9PcE9kMkQvT1Bud281bEwyK3ZLMUZuR3NLRm5rT2JEM1hZNnpxN3F4ZXhU?=
 =?utf-8?B?UmgrTGR4cE9GOFRpRFl4OW5qb2x0WU9PZHVCWHFRY0hvUnlPb1RhOXd5VlJl?=
 =?utf-8?B?ZjRaK0xuemswRnNMU2pkK3h0WDlnWEFOcUsybjN2Sm9ZZlNLUzVSbjVZMGNz?=
 =?utf-8?B?M1E0SGlJb01XTXl4N0MyYVhZMUgrKzJHSDBXaXhPSHN0clZrTmprb1hHR1N2?=
 =?utf-8?B?K3htMW9jQUVjaXBiN0N3MkJMb1RvdmpoTDYzYW9LVlowTTZ0Rk96TDlRVjlk?=
 =?utf-8?B?UTM3blZmT2lQQ3E5UW5sTHNwZ0pQbkU4QmlPdWF2akRtK1l0b3FlaVlIOTlB?=
 =?utf-8?B?a0VvcDFrcDg4eE1RNG5uRmpEOTdHR1JjLzVUQkdEekpWUUlTQjhCZUh5ZElF?=
 =?utf-8?Q?bmnwfzVtn2ETZpXcrdLROq5BDV3I80GpIn0H5Q7nW8xo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08e8f20-83a8-4c02-2238-08db984f877a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 20:39:14.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhNDWLbLKnrIokmecxLKbN0dSsXBpNmeUMkxF9hbH4mL2CUKa/H1AO002RM7PN0dn2g+OdtBeQzGHGvKhlRyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBtZWFuIHRoaXMgaXMgdGhlIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBvZiBkZXZtX2ttZW1kdXAo
KSBmdW5jdGlvbiBpbiAvZHJpdmVyL2Jhc2UvZGV2cmVzLmMuIA0KDQpIZW5yeQ0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEd1ZW50ZXIgUm9lY2sgPGdyb2VjazdAZ21haWwuY29t
PiBPbiBCZWhhbGYgT2YgR3VlbnRlciBSb2Vjaw0KU2VudDogVHVlc2RheSwgQXVndXN0IDgsIDIw
MjMgMzozNiBQTQ0KVG86IEh1aWJpbiBTaGkgPGhlbnJ5c0BzaWxpY29tLXVzYS5jb20+OyBDaHJp
c3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPjsgSGVucnkgU2hp
IDxoZW5yeXNoaTIwMThAZ21haWwuY29tPjsgaGJzaGk2OUBob3RtYWlsLmNvbTsgdGdseEBsaW51
dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGU7IGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7IGhwYUB6eXRvci5jb207IGhkZWdvZWRlQHJl
ZGhhdC5jb207IG1hcmtncm9zc0BrZXJuZWwub3JnOyBqZGVsdmFyZUBzdXNlLmNvbTsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWh3bW9uQHZnZXIua2VybmVsLm9yZw0KQ2M6IGhiX3NoaTIwMDNAeWFob28uY29t
OyBXZW4gV2FuZyA8d2Vud0BzaWxpY29tLXVzYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBB
ZGQgU2lsaWNvbSBQbGF0Zm9ybSBEcml2ZXINCg0KQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5h
bCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcg
YXR0YWNobWVudHMuDQoNCg0KT24gOC84LzIzIDEyOjE5LCBIdWliaW4gU2hpIHdyb3RlOg0KPiBH
dWVudGVyLA0KPg0KPiBIZXJlIGlzIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiAgZGV2bV9rbWVtZHVw
KCksICpzcmMgaXMgdGhlIGV4dHJhIA0KPiBhcmd1bWVudA0KPg0KPiB2b2lkICpkZXZtX2ttZW1k
dXAoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCB2b2lkICpzcmMsIHNpemVfdCBsZW4sIA0KPiBn
ZnBfdCBnZnApIHsNCj4gICAgICAgdm9pZCAqcDsNCj4NCj4gICAgICAgcCA9IGRldm1fa21hbGxv
YyhkZXYsIGxlbiwgZ2ZwKTsNCj4gICAgICAgaWYgKHApDQo+ICAgICAgICAgICAgICAgbWVtY3B5
KHAsIHNyYywgbGVuKTsNCj4NCj4gICAgICAgcmV0dXJuIHA7DQo+IH0NCj4NCg0KU28geW91IGRv
bid0IHdhbnQgdG8gdXNlIGRldm1fa21lbWR1cCgpIGJlY2F1c2Ugb2YgaXRzICdzcmMnIGFyZ3Vt
ZW50LCBhbmQgaW5zdGVhZCByZS1pbXBsZW1lbnQgaXQgbG9jYWxseSBieSB1c2luZyBkZXZtX2t6
YWxsb2MoKSBmb2xsb3dlZCBieSBtZW1jcHkoKSA/IFJlYWxseSA/DQoNCkd1ZW50ZXINCg0K
