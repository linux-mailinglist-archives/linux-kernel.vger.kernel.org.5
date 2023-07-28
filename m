Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB280766DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjG1M7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjG1M7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:59:50 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2097.outbound.protection.outlook.com [40.107.105.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B605030FB;
        Fri, 28 Jul 2023 05:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTVKYdPtW8bKbGOTYyl+i69f7i5WyGlSyZhSjEOlEF+IpapAK+sRN7qQ8yjgi+DjdwlvPthBUdGRxUBOBQQcgIWDAnn3LonsgIHMIMGlG0FAfdLGRHHB0/a9vdKaKNGaUzUQErYG1Zsaij5+KxHXjjXS6uBBDV5uYouWGkbc92DE6wzNEfi4wXAoGiIxk8VsXObvf3Jgzyo0FAsD3kXHS6MDU0Wz3TA1U6yC052ZBcnUCe5Bud1560n09YDRIHNaNJpKvnSWtbov33EHhuW6hNSyEbqWpyU5FiR8+nOWMBDZUO4X5sZT0ZurUNZDgJpODdj9ItjaNQjMdnhfjkmukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irCPvuvnAMo7N7aavKBCZorILeO3u+m3ckYrVQLGijQ=;
 b=KoIhN8LIIYpzTP6qCQw+5epbY8+i+Ldgh0kWutCB/5+SYjXS8YZULfRFZCKO3nk+bHbE60FloALzjA8ofTkSh+cJBbsWlzV8iQpEZ7NE3YcfC8dumn2nmo4FtknfFCj9WAaccDphEdrxwXE1Y85gpaLqbMXCe0xnNFDjyABpjsOVfz7XJKno6aCvJXQ/k/bJXM6Eo2iQSIQKW4Bo0RwfJ9aejoMTCo6/UP/0VN/bJpOR6j2VCklLlCFc8a/7iCGwOXDxLXq6KNerBkn1xYAIwMNJuHDXuaXYd0Ab86Uc5faUSU12BI1LY51qoF1C+JXDVTzaAfC3pbGs1mCKs9d1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irCPvuvnAMo7N7aavKBCZorILeO3u+m3ckYrVQLGijQ=;
 b=Kp26V4IqSbqSM2LggusObJ2eIlfr4DTwzMD9x+/ygGOSSYNIkrz4CqP5r11X1FZwBihA5Q6NGH7xKTCggmv9hvc2pjSR3Ak5ebzAKCN0TGQD6xZi/l0pnwFXtLjUHVksHKt8VRtl6x8+C42agd+932XmFkqfxDR3DUdmPWKevaw=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by DB9PR04MB8300.eurprd04.prod.outlook.com (2603:10a6:10:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:59:45 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 12:59:45 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC:     "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH] Add Silicom Platform Driver
Thread-Topic: [PATCH] Add Silicom Platform Driver
Thread-Index: AQHZuZEcSTfJXOh+tEO5M8hB8nDqzq/LA4yAgAK8ytA=
Date:   Fri, 28 Jul 2023 12:59:45 +0000
Message-ID: <PA4PR04MB92225B65A45868A9CBE25B999A06A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230718160104.2716-1-henryshi2018@gmail.com>
 <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
In-Reply-To: <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|DB9PR04MB8300:EE_
x-ms-office365-filtering-correlation-id: f190941f-8535-47bd-8ba6-08db8f6a8450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxN27f3hCUQVit4g5BLPp71Pvvp3IYHNr/e7gjVJYQE1zqMw8uA4clADT/O/Tq4ZArCxjr3UGYUcQxGPXsLVPtLUcfliEBhJwg0vejv2IF41EdgWGRO+gfOHF+Ogj7QDrPJVnQT51MQjAP+Rdob7AAvvzXsjRIW3gZqSX4HkSJwejQPaYrtnKhGCHHxedp5MybKSgI/xOQBbFBiLuAi59/afF7kjn27AnPTVnZVWq33KPIuyPy2DV87fGl649OcUr5ZMIIYl6wAjdqL/B9MCtRIDLzNRnaje1sxXYrD3S9xt5Ma515XYizUXY8lEBHlDX6inGnhdQN4oHHo96/9xyrUJi5ALZvwwXbiI7ChvX4K+Lw6pR8Wb7HVTV6CvUS9BQjtC0qc/ppiTi1xP+LolkEwm2z2ba6x/GzTFdlTsSz/AmhGd/EDkvNSYH1xGFRIeo7X7XA2INU0ImaX3dhzX2swcFvJmnwgECcDC5R58SeO1OUoBdDd1T5ZbNmLp6ish448VtO1D9XvXiKO5oz0aYQhyDfoCE6/x7M8liKonwCkL4IowmT6VdL7E2I99v8+kfUlQ6PGgSoGcBu/qrCbi1L8bAuVolyfudABMrANLyd0oyd7y7vGlk9BQBttutRQF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(451199021)(41300700001)(2906002)(316002)(7416002)(5660300002)(52536014)(8936002)(38070700005)(33656002)(8676002)(55016003)(86362001)(54906003)(45080400002)(71200400001)(66574015)(122000001)(110136005)(921005)(478600001)(186003)(53546011)(6506007)(9686003)(107886003)(7696005)(38100700002)(66476007)(66446008)(76116006)(64756008)(66556008)(66946007)(4326008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXc1MXdUTG4wVFkrK3hhbWgxa2Z1Z3R3ZWFPaFNWcTBrbWcrNUcwN05NZE1C?=
 =?utf-8?B?ZGZiY1UvdTc5MHRqT3dacmJhT2YxS1BvMkEzNzJybndDdm5rUms2aDhYZm1V?=
 =?utf-8?B?Ylg2eTd6Qk9sNmYrdUZ1Z3locWxrMkhtVjVySlBvbmxFTWVvUXpyU211T2xT?=
 =?utf-8?B?YjBBWFZVbXlUL1pmY2JtTjNLSDhtOFhvZzFlb2UvM0xNaTRueGp1OFp1alQy?=
 =?utf-8?B?VGRwRVRHY1EvTTZFQ2hDQ2dNaTRwb0lMZ0VReEQybGI4UVFXejg1NC9SU1lB?=
 =?utf-8?B?aE9Wb0RITDFJajhQQUZMZ1gvSnFsT0JiK2tIMDNzVFhkdXFzSHZvdWk4S3FD?=
 =?utf-8?B?Wkc2Rnk0bDBzMTJKVTVJY0REdmxOeXFyZEhtcGx5WnNvbVFxNlRUYkJJb2Nn?=
 =?utf-8?B?bDJ5RmxKUVFvUC95elNzaGxnU1lMZ2V0QkQ4dHQ4VUNWeUdta2JwNGQwSTc5?=
 =?utf-8?B?d1RrT0VEQjRkcEdHUExuT2lNQVJKemJSUm1uQnpBQkZ1YndjN0xzazlEc1RX?=
 =?utf-8?B?NXpCemRPY25xMjVTRUNTV1hhTmpLQm5EeDB3ZWE5QWtKNTdXcmZWSmFLOE9J?=
 =?utf-8?B?WXZvUldxMTBIaFBaVXgrMzhWTERvVm12ZVJraU1vNHJyUzA1YVZMQWJTWStr?=
 =?utf-8?B?d2FHNnBGQU95KzJQcEgwZitMdFRZU0ZScU90M2tYMEh0ODFmME5TbmNMNUFQ?=
 =?utf-8?B?ZVAyTWNCNUZtY3lUTVhFcmYwa0dJc2o3K2RiM1lrV044NlFIT29RUHA3ak5M?=
 =?utf-8?B?TVhwczJiYWNKcVE4Vm85R0Y4a1RQaTlKdUpqcjZyVHFuUDJsN0NPUGlkVG1S?=
 =?utf-8?B?bWVWT2ZkRWtua1gwcmVGWStEbjlVRWM3UFBkWklvbEZOaitkdmdKQUZyQjhk?=
 =?utf-8?B?V1dqT0NGSjlDWGlIU3p1aVJZOGwvRkVxeTVkeEdmZlJNRWVGSjNUUk8rZG1I?=
 =?utf-8?B?Q0FobzJLb3gyOC80NnltdG1ZNHViZmZyMTJjZkszZFJOZXNVVCsyb0V3TkxK?=
 =?utf-8?B?WUJVZEk3YkhKSkNVVmNDK05XTTdQWUdIdDNkNFNTVkZ5RCtVbXlhV1FXeGF1?=
 =?utf-8?B?enAwbWUzSi9WMWxzbkNVajdFMmgzT0ZZS1lwclg1aklxeC90OGtlcWZab0tl?=
 =?utf-8?B?UjZHS1V5MWtqWTBmUE11SkJMdi9IQS9hQ3NmYkd0cDRuQUdEdXliMW1Nbk9P?=
 =?utf-8?B?amhmZEQ5UmQ1K2FNNkQrdGQ1bXdlUXdaeWR2SVc4dGpQVmRwMEI4REg5T1lM?=
 =?utf-8?B?c254VUlMT2J3WDBvNkRNWTMzSUFhZzBrWlp4dDRMajRtdjF2TE9mN0xjc3FR?=
 =?utf-8?B?UisxTnFiV1ZmcUZBYXhOcTVPNUYzb2FrYXRaK2twbWVxMDRlWDNvK3RITldE?=
 =?utf-8?B?bGhoaHBzTm1PM3BFT01qdWUweGF0OUFlWlpTRUttNnFxN0NFYWQ2elpMTFl3?=
 =?utf-8?B?eVZHSjZiVHZ1RFVWclFGaG1Ta0hVcWs3RWFJVmE5VEhPY0x3Y1VjdU52ekd2?=
 =?utf-8?B?MzVJZ0RPT2tYdGpRTHk5OSs2MnJnY3RjbDJ1MDg4ZUVCcSttUEMwWUh6cXZV?=
 =?utf-8?B?NlowOU1udU4xMEMrRVRlSkZSR090RVcrRVNrWkRJNzFBbDlOQjFqTVBiZVBL?=
 =?utf-8?B?WU1oSVF0QVorRzd0dE1pU0hVTEtjSWRPeURMaGJQcXc2SnVnbGE0dk5TMG5S?=
 =?utf-8?B?dTNvSENtU3NNcVVyNU5OWEpQSnRmL0l0OUg2b1EvWFZYMjJuL2tJNTNSUTN1?=
 =?utf-8?B?eUN4QmxLcGk5RzBUOWJXMUxUR1B2R1hUY0Q4N1pKRFZ2S1ZBemp5TUxTbzlK?=
 =?utf-8?B?YXF4MFo0OSs3bUF0V1h3dHFNd2NVbThlb3Y1dlZpTEhySEZZMUNNekhWQ2ZM?=
 =?utf-8?B?cGFPM1JOUXlKVVM1a3JSMGdQRWE5K3N3Z3c5Qk9vSS9oWmN2cHRmRnNoSmFl?=
 =?utf-8?B?NW9QL3RnU0hnRmcvY2RhbEtyRnR3TDRaTjRCNFVIRVlEWVk4WU9SYVRMTkJh?=
 =?utf-8?B?ZXplWXhsMVNJdnEvVHptM1BRekdFNXlFc0xqS0xsVklLbUcrNXlZSDlHUDMv?=
 =?utf-8?B?Q0xWUHM1OEQ2eHYvcVZoeTJXVlRHdjlDcjhyd3hkVnpvcDkrTUR6Zno2Wngy?=
 =?utf-8?B?UWdFaW9uaEhGcWJROHREemhxaFhoajljVjNISzJNUWZLNm8zaHpqRWhZWS9J?=
 =?utf-8?Q?+KBYnrkiGmXhTYgb7kdGGBBCGs+gASobs1ootadlugYv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f190941f-8535-47bd-8ba6-08db8f6a8450
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 12:59:45.1657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3z4NDsewrdxUYeOUrr+o1awSOtMQJ6HzclvdNQYUI2TWvfxX8RxL1PeC/yvf/vY2k/dGk1OC6r/EdnsaBjG4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8300
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hyaXN0b3BoZSwNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIFNlZSBteSBjb21tZW50cyBi
ZWxvdy4NCg0KVXBkYXRlZCBwYXRjaCB3aWxsIGJlIHNlbnQgb3V0IGxhdGVyIGFmdGVyIHJldmll
dyBjb21tZW50cyBmcm9tIG90aGVyIHJldmlld2VycyBhcmUgYWRkcmVzc2VkLiANCg0KSGVucnkN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNo
cmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPiANClNlbnQ6IFR1ZXNkYXksIEp1bHkgMjUsIDIw
MjMgNTowMyBQTQ0KVG86IEhlbnJ5IFNoaSA8aGVucnlzaGkyMDE4QGdtYWlsLmNvbT47IGhic2hp
NjlAaG90bWFpbC5jb207IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBA
YWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IHg4NkBrZXJuZWwub3JnOyBo
cGFAenl0b3IuY29tOyBoZGVnb2VkZUByZWRoYXQuY29tOyBtYXJrZ3Jvc3NAa2VybmVsLm9yZzsg
amRlbHZhcmVAc3VzZS5jb207IGxpbnV4QHJvZWNrLXVzLm5ldDsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh3
bW9uQHZnZXIua2VybmVsLm9yZw0KQ2M6IGhiX3NoaTIwMDNAeWFob28uY29tOyBIdWliaW4gU2hp
IDxoZW5yeXNAc2lsaWNvbS11c2EuY29tPjsgV2VuIFdhbmcgPHdlbndAc2lsaWNvbS11c2EuY29t
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gQWRkIFNpbGljb20gUGxhdGZvcm0gRHJpdmVyDQoNCkNh
dXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBj
bGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLg0KDQoNCkxlIDE4LzA3LzIwMjMg
w6AgMTg6MDEsIEhlbnJ5IFNoaSBhIMOpY3JpdCA6DQo+IFRoZSBTaWxpY29tIHBsYXRmb3JtIChz
aWxpY29tLXBsYXRmb3JtKSBMaW51eCBkcml2ZXIgZm9yIFN3aXNzY29tIA0KPiBCdXNpbmVzcyBC
b3ggKFN3aXNzY29tIEJCKSBhcyB3ZWxsIGFzIENvcmRvYmEgZmFtaWx5IHByb2R1Y3RzIGlzIGEg
DQo+IHNvZnR3YXJlIHNvbHV0aW9uIGRlc2lnbmVkIHRvIGZhY2lsaXRhdGUgdGhlIGVmZmljaWVu
dCBtYW5hZ2VtZW50IGFuZCANCj4gY29udHJvbCBvZiBkZXZpY2VzIHRocm91Z2ggdGhlIGludGVn
cmF0aW9uIG9mIHZhcmlvdXMgTGludXggDQo+IGZyYW1ld29ya3MuIFRoaXMgcGxhdGZvcm0gZHJp
dmVyIHByb3ZpZGVzIHNlYW1sZXNzIHN1cHBvcnQgZm9yIGRldmljZSANCj4gbWFuYWdlbWVudCB2
aWEgdGhlIExpbnV4IExFRCBmcmFtZXdvcmssIEdQSU8gZnJhbWV3b3JrLCBIYXJkd2FyZSANCj4g
TW9uaXRvcmluZyAoSFdNT04pLCBhbmQgZGV2aWNlIGF0dHJpYnV0ZXMuIFRoZSBTaWxpY29tIHBs
YXRmb3JtIA0KPiBkcml2ZXIncyBjb21wYXRpYmlsaXR5IHdpdGggdGhlc2UgTGludXggZnJhbWV3
b3JrcyBhbGxvd3MgYXBwbGljYXRpb25zIA0KPiB0byBhY2Nlc3MgYW5kIGNvbnRyb2wgQ29yZG9i
YSBmYW1pbHkgZGV2aWNlcyB1c2luZyBleGlzdGluZyBzb2Z0d2FyZSANCj4gdGhhdCBpcyBjb21w
YXRpYmxlIHdpdGggdGhlc2UgZnJhbWV3b3Jrcy4gVGhpcyBjb21wYXRpYmlsaXR5IA0KPiBzaW1w
bGlmaWVzIHRoZSBkZXZlbG9wbWVudCBwcm9jZXNzLCByZWR1Y2VzIGRlcGVuZGVuY2llcyBvbiAN
Cj4gcHJvcHJpZXRhcnkgc29sdXRpb25zLCBhbmQgcHJvbW90ZXMgaW50ZXJvcGVyYWJpbGl0eSB3
aXRoIG90aGVyIA0KPiBMaW51eC1iYXNlZCBzeXN0ZW1zIGFuZCBzb2Z0d2FyZS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSGVucnkgU2hpIDxoZW5yeXNoaTIwMThAZ21haWwuY29tPg0KPiAtLS0NCg0K
Wy4uLl0NCg0KPiArc3RhdGljIGludCBfX2luaXQgc2lsaWNvbV9tY19sZWRzX3JlZ2lzdGVyKHN0
cnVjdCBkZXZpY2UgKmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgbGVkX2NsYXNzZGV2X21jIA0KPiArKm1jX2xlZHMpIHsNCj4gKyAg
ICAgc3RydWN0IGxlZF9jbGFzc2Rldl9tYyAqbGVkOw0KPiArICAgICBpbnQgaSwgZXJyOw0KPiAr
DQo+ICsgICAgIGZvciAoaSA9IDA7IG1jX2xlZHNbaV0ubGVkX2NkZXYubmFtZTsgaSsrKSB7DQo+
ICsgICAgICAgICAgICAgLyogYWxsb2NhdGUgYW5kIGNvcHkgZGF0YSBmcm9tIHRoZSBpbml0IGNv
bnN0YW5zdHMgKi8NCj4gKyAgICAgICAgICAgICBsZWQgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXpl
b2Yoc3RydWN0IGxlZF9jbGFzc2Rldl9tYyksIA0KPiArIEdGUF9LRVJORUwpOw0KDQpzaXplb2Yo
KmxlZCkgaXMgc2hvcnRlci4NCk1vc3RseSBhIG1hdHRlciBvZiB0YXN0ZS4NCg0KTWF5YmUgZXZl
biBkZXZtX2ttZW1kdXAoKT8NCg0KSGVucnk6IHRoYW5rcy4gRGV2bV9rbWVtZHVwKCkgQVBJIHJl
cXVpcmVzIGFkZGl0aW9uYWwgYXJndW1lbnQgdGhhdCBpcyBub3QgbmVjZXNzYXJ5IG9mIHRoaXMg
ZHJpdmVyLiBJIHByZWZlciBkZXZtX2t6YWxsb2MgZm9yIG5vdy4NCg0KPiArICAgICAgICAgICAg
IGlmIChJU19FUlJfT1JfTlVMTChsZWQpKSB7DQoNCmlmICghbGVkKQ0KaXMgZW5vdWdoLg0KDQpI
ZW5yeTogT0ssIGNoYW5nZWQNCg0KPiArICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYs
ICJGYWlsZWQgdG8gYWxsb2MgDQo+ICsgbGVkX2NsYXNzZGV2X21jWyVkXTogJWxkXG4iLCBpLCBQ
VFJfRVJSKGxlZCkpOw0KDQpUaGlzIGtpbmQgb2YgbWVzc2FnZSBpcyB1c2VsZXNzIGFuZCBzaG91
bGQgYmUgcmVtb3ZlZCAoY2hlY2twYXRjaCBzaG91bGQgd2FybiBhYm91dCBpdCkNCg0KSGVucnk6
IE9LLCByZW1vdmVkLg0KDQo+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsN
Cj4gKyAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgbWVtY3B5KGxlZCwgJm1jX2xlZHNb
aV0sIHNpemVvZigqbGVkKSk7DQo+ICsNCj4gKyAgICAgICAgICAgICBsZWQtPnN1YmxlZF9pbmZv
ID0gZGV2bV9remFsbG9jKGRldiwgbGVkLT5udW1fY29sb3JzICogc2l6ZW9mKHN0cnVjdCBtY19z
dWJsZWQpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
R0ZQX0tFUk5FTCk7DQoNCk1heWJlIGV2ZW4gZGV2bV9rbWVtZHVwKCk/DQoNCj4gKyAgICAgICAg
ICAgICBpZiAoSVNfRVJSX09SX05VTEwobGVkLT5zdWJsZWRfaW5mbykpIHsNCg0KaWYgKCFsZWQt
PnN1YmxlZF9pbmZvKQ0KaXMgZW5vdWdoLg0KDQpIZW5yeTogT0ssIGNoYW5nZWQuDQoNCj4gKyAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFsbG9jIHN1YmxlZF9p
bmZvWyVkXTogJWxkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpLCBQVFJf
RVJSKGxlZC0+c3VibGVkX2luZm8pKTsNCg0KVGhpcyBraW5kIG9mIG1lc3NhZ2UgaXMgdXNlbGVz
cyBhbmQgc2hvdWxkIGJlIHJlbW92ZWQgKGNoZWNrcGF0Y2ggc2hvdWxkIHdhcm4gYWJvdXQgaXQp
DQoNCkhlbnJ5OiBPSywgcmVtb3ZlZC4NCg0KPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQo+ICsgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIG1lbWNweShsZWQt
PnN1YmxlZF9pbmZvLCBtY19sZWRzW2ldLnN1YmxlZF9pbmZvLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgbGVkLT5udW1fY29sb3JzICogc2l6ZW9mKHN0cnVjdCBtY19zdWJsZWQpKTsNCj4gKw0K
PiArICAgICAgICAgICAgIGVyciA9IGRldm1fbGVkX2NsYXNzZGV2X211bHRpY29sb3JfcmVnaXN0
ZXIoZGV2LCBsZWQpOw0KPiArICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlZ2lzdGVyWyVkXTogJWRcbiIsIGks
IGVycik7DQo+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiArICAgICAgICAg
ICAgIH0NCj4gKyAgICAgfQ0KPiArDQo+ICsgICAgIHJldHVybiAwOw0KPiArfQ0KDQpbLi4uXQ0K
DQo=
