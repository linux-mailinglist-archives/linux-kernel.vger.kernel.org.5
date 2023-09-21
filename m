Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237EB7A9A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjIUSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjIUSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:35:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B4089D9D;
        Thu, 21 Sep 2023 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695318023; x=1726854023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pAUfq80ikwtc1BhUgSspBsuAXWsJjgrj924rQoBEHj0=;
  b=S8BYLmNfXzBtWy4MzxL1IdeJvtv7M2wTgmVk/2yzL/eK6iAodspBg3x0
   IMICv8ggAm+zIMusu++NIFlhDRE2rjD/KoFuSo2Ngui4sb1RPKrHlHfzv
   Wv7ZX0VtxoJMsghoNZ789kuKPP4+MVWfDLb/ArRyaVyfOyliaQUwmw1LV
   7M/vtS2d9eF6YpiAF3Q3VnevkHzjbNP4hUAQVo0STXgoPM8MjzJEL5G6Y
   aiDoMoxf1fXmjzJJq/HgetttwxIFYjQYDfwlro8z6bmg51CWqPrcALqXG
   SLDLw1Idp29rpvF01DMFuKqlaGKVdZxeDYhroVbFbS4CrFwBI7BwlRD/o
   w==;
X-CSE-ConnectionGUID: satpLb0XSe2wRPVxdqMNCQ==
X-CSE-MsgGUID: ENuh8lCNRkW9X8z7COPN8A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="5844703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 05:28:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 05:27:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 05:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL9NsU0njv5fgafv+h33F0jYgRE/bHRs0ieH8ChCFl9u6ie5bZn566epPvIgYq+HkopSFEuS4NOLBZmtQYO5oTTUIxeGKGxKyE0GWCaH66G1TnAbZAv8F1TaxN5vwSYnBWywmuTp2rwLfXApuDVJt5NXwPg157q47Jtj2Pm8yesyudclmrchQ+WjAqC3uDmowEXx2svCZdVChYdSfRoWsZB0whKw+cy9yFGngxnlGdVgTDqnGGAojn960x+9ZIkvvLK88ragvk9yxaIbJjtmdcDeBqGyIJd3zRWcnyUfe1Vn61pvnFEPWnlOg8mHVgCaLwiDBFdx699T9ftfZ4EeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAUfq80ikwtc1BhUgSspBsuAXWsJjgrj924rQoBEHj0=;
 b=WKf7ij167P5cc2X41vshEDYJ73Hh3bD05fhtBXkn3yybDJGl9BttRz6qDFsrERVVrrcLB9D7Hn1jWffYOIm9O/0eVpgKDQfKIqAP12I0OD7l7xJs8Lagj+uCg7xCjJ/DkUYzlDR6Sf95ft2u59DTfGbg3Ds3YKiY/v51lws/FDSDNUIiKWAoeIlPtdzyE2slGCVKq1xIfcZuoTbSACrIHy+K2+IPuXHGs2wOO1MkHhDXx9FAEMRj8OvzOqKfA1gMXbilsoPM5QiD2dJf5GGtQR4W7g8LClKOtUG3wSAfvLTnoNhOqoJE0r6XTzfwgpw3Oujnq+sPapNLCLLpcEFRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAUfq80ikwtc1BhUgSspBsuAXWsJjgrj924rQoBEHj0=;
 b=ojr7jdUf7wgDH4ePNb+vYqAficSVJsQvCyRVOnwAr7gtSTjqvAGrHumI3+OPU/3uOqw+O59satADEsN4ylJDzVbfFJ9Nwqt6Rk6KlnmC+kGEtOdQhdXSMey2ajJ8H50auc3YmcoSSdFePa239QIOpNCYntn6VVRukYXs5EErCho=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DM4PR11MB5455.namprd11.prod.outlook.com (2603:10b6:5:39b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 12:27:56 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 12:27:55 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibASf7oAgASuf4CAANFsAIANSZwA
Date:   Thu, 21 Sep 2023 12:27:55 +0000
Message-ID: <94e4a08b-005d-adc0-5852-85568ba5db72@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
 <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
 <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
In-Reply-To: <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DM4PR11MB5455:EE_
x-ms-office365-filtering-correlation-id: a39c35fa-efd7-46f9-7132-08dbba9e2ed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xWLrdcIbT/B/pRzhJo+JyDHzO/xFe6OB98PtAPPsbY0mZLYXcqOtXBgRv0HzgwO0YOrpt4AtummL1VrUhqfw5LktLVAOA2y4xLHRacaOorfpjlYvKJcL9FcFYYvNfrXQNETl6AMuYDJYJiffiw8aCk3rfTaB+MF7kaeyyssDIf7cqaWDe4MqrUZ3IX00lhl68XMMv0dZ1qTkBkuJhz26IBSEG2UbAASKrkgnqw8rT74RTg5szGH7FfT4GA53/kTAjpOcB6OhXoyO/NPODzJ6e76njr2o1f9gFhCWoCdU+WAUwnkjPly6VmL5dp+/gu9KNeGhGbbiDVBPL+L8FoCxxbpY5PJhcCCu+c8rxRFS4moJ8h7GDVmND/7KSEiYHJ1SmUYeJjJgHX1fXpreK6Xem4GKVxvnTxnUtuTA5JpeCcbQEQjQyelzeK97i8+2cAp2XW23ug91QjJkePRYJFcWomh6/zTMzuO0fV9NFoNmnquIThJUmS/bGUjjRviAKeQlwN7z4+DPCm1UCtCoqVk9dr0YTiY6D3Wi7MJX0FS60e+G8vuXipHjeW7u1WAIprLJ49xPmWBibwgbx+1GIsRrAD4GZwIWytGj8tb0nAhHa8NzJGJScnFFyHAuD8aTIijTp11TH/qtdk0tfdTqn1c3hXdthPWm0jDAFv3zl+SG12luS9p5Donaj0J7Ju29XVm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6512007)(6506007)(6486002)(53546011)(71200400001)(478600001)(7416002)(107886003)(2616005)(2906002)(66446008)(316002)(91956017)(54906003)(66946007)(76116006)(41300700001)(66476007)(66556008)(64756008)(26005)(8676002)(6916009)(4326008)(5660300002)(8936002)(38100700002)(38070700005)(31696002)(36756003)(122000001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm0rQVpTSDhkMS8zdWxQOStaV2xqdE9vWWtKcVJQdlB4UmZlenlTdDFWMTRq?=
 =?utf-8?B?dUU5NzIzNHpyemJNT3VHYnlzZTVaM0VMT3IzWGlXNDRFNnJWYktjcVhOQUlK?=
 =?utf-8?B?YXNRVHJoM0tEUDV4VXhvNUVoUXIvTmtCR3NXUlZTWm84MStXT0JueXZaTXZs?=
 =?utf-8?B?V2YrbFkyNmcvMjg1b1dhSUpYU1JFYmgva1ZYQm9CYWpLaDN1cWEweXhJMjlH?=
 =?utf-8?B?Ukh0ZFJ5WUxHejhKZ3dOa3Q3dmduUFM1bGhpdnZKSFVuMjB2ZHgvKy9ZVEhR?=
 =?utf-8?B?cnRaM2VLM1JGS0dtWnk2OExqb1lxRDFFd0N1bE5hMGlSeWNQUTBIREQ3QXRU?=
 =?utf-8?B?eHN5NWNVRWNrZlVIenJ0bWJnUUU5M3J5alhkanBjcWhySTVvQ3ZrQjNJbmFS?=
 =?utf-8?B?WmkvbTI4bHFzNjFocEFLTVR5Q3RrSlJEVUJZS1RZUCtGZStDYmFndUwwM2N3?=
 =?utf-8?B?U3RLb2cyNFAyRlJMNXhYTUtoN1BjdHdJdk5WWVh5SC9BWGw0S1lQc3YzdEU2?=
 =?utf-8?B?NmhaQ3IwS2c4dHF0bm93OWlqSm5XRFhaRXZtTUdlcS9DKzRjWUlLbkxtRlNq?=
 =?utf-8?B?MFhLcTBRTHNPNzByQjhENmFtZTNlYmZFdzZ1MDlUWGRQWlNTRFlMMXhTQnQ0?=
 =?utf-8?B?TmVHTmFUU05QYktIaUd3R2gvSXhDdmhvczNhTldMSWVsVHhqb1pmaEsyYkZJ?=
 =?utf-8?B?Vk8wNU9XenVmSVM0TnJvVkNwanRaU2hvSmdKWVh0cjFpZFBZOTFBaFVvOERJ?=
 =?utf-8?B?ZVl2dUxkZkRqT2VVNEp6dVlRdjMxdGpIdWRUOFZqeStMcE1uY2N6WkhnOWZl?=
 =?utf-8?B?WGV4NS83NExybjBkUWZtWVpuTGkzQUNpeTI3NFBSazQ0eFhJN0FtR2phMnZL?=
 =?utf-8?B?WERJTEdpdmlSL2FyWlZGRSswcUN4azcvN0MyRC9uMlRNMml2c0VjYm1pdmZm?=
 =?utf-8?B?ai9rZ25DUW5yMXNKa3l3VUtQcFA2K3N4dVcyaTlWQVhYeFRWWTFCYlByclZ3?=
 =?utf-8?B?SmZOMm1ZZlMrb2hiZ0tMeHZDUUJUbGNFSnpBRUZwbnM5bHJFYjZ1MFRJQ0lh?=
 =?utf-8?B?YXJFcmc3ZElNczhiaVVzNWs4SlNya0JhcDAwaHNVK2VsV1p6QW51TlhITHJh?=
 =?utf-8?B?eUxsY3hjTGFYdFhCZ1ZwWHRJMi9IazBBeGh3SSthcmptdFVLWkpkaEk2ZmFq?=
 =?utf-8?B?QS9ITFFIczJ6ZmpKLzZSaWZjcHpYbzVQSkc3cjVucHlEQXlDdWxnbXNuR1Zr?=
 =?utf-8?B?VXN5bmY3cTZpNHh2MGZZL05Va1NhbkxHMXd4V0xTMUtnaXhUWDMzdmF6U0hT?=
 =?utf-8?B?TVArOXpIZnVEcTN5VngwdVlXOU1tSkcxUEpvOTJCQnkyOUkrR1R6RlI3V2I4?=
 =?utf-8?B?VExGLzhpSU9pMmR2Wkg0MlV1d2lNZVV5OGJxeGhMdEZxM3JKQUV6ZC9YcjJI?=
 =?utf-8?B?YXV1dVJNV25sY0xmOHNsVTZaRVI5enlFaFNpNjRqckNJYzlRUGZBUEpuWllQ?=
 =?utf-8?B?ZUMrU00wZ1VxeitETk1EWWRuUDlxZFdieENzN1U0SUdnYVI0SkxRblhqU1gw?=
 =?utf-8?B?alVJeFNYOWhTRWNNMUF3QXo0UERqZXRSVW0veFoyZFgyQlluMkREbE9DVm8z?=
 =?utf-8?B?M1VDTEJ0VW5QMG44TmNYOW5YTElKdWVCUTVxZkpRbFQ0WGtmb0VPeGc4dC9W?=
 =?utf-8?B?YjN0ckJsdGlaWFAydGJoQ0RkQTU0M3hFaTlOZXltT1IxWk5FR2xGQzVYNVJE?=
 =?utf-8?B?cU9pSzd4SFZ4WjJsWitTM3BCYTg2cGFIRTFYS2ErUmJPZmgxZGdIdFREOSsw?=
 =?utf-8?B?RTRoSjJXM1NaVUJNd3hudG5wYXZSNUl4Vm41UDMvS1F0WnkwK2ZkU0xBSEtY?=
 =?utf-8?B?VFdrVytMSHB4UFFib1B6TWRnYm1DRFpheDVXc016Sll5VGl5ZHdEUzZMUFIz?=
 =?utf-8?B?bEJIMUxONTliTzR4eW8yODhMTEpyMDVYRjJ1bFlBaWJlb3IvM3pwUXM0QVJE?=
 =?utf-8?B?WElaMHpQTXYwRHdsR3pyK0o4YU0zdmlnRXNxSVdJTlpibE1QdllaMjNzbzZV?=
 =?utf-8?B?V3JVdy9zRHB4MWwyOG1IbHhmbFRZZ0Y4cXlCR1pzVlhkK2xEaVFCQ3FxdTVq?=
 =?utf-8?B?c1hDT1dVUHZoQWorYldSWk80eW5ZanNXcjVxL0JyL01FeTJTdXc2eHdjSkZy?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAC0F29433989B429591D398E0AD25E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39c35fa-efd7-46f9-7132-08dbba9e2ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 12:27:55.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIbaFeoMR1ZwKwfyJcOzTz7JwbeG4KUHy6J2kn3p/45UeYGfeauCSOz6jpVIfb3umg+jMnm6ovTQL2APgsnQUWAVniikFhFxILiXaZGH2vNZFPhwazvgf3HeA0VKuo91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5455
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxMy8wOS8yMyA3OjAyIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gSWYgSSB1bmRlcnN0YW5k
IHlvdSBjb3JyZWN0bHksIHRoaXMgZnJhbWV3b3JrIGhhcyB0byBpbmNsdWRlIHRoZSBtb2R1bGUN
Cj4+IGluaXRpYWxpemF0aW9uIGFzIHdlbGwgdXNpbmcgdGhlIGJlbG93IEFQSXMgYW5kIGhhcyB0
byBiZSBjb21waWxlZCBhcyBhDQo+PiBsb2FkYWJsZSBtb2R1bGUgc28gdGhhdCBvdGhlciB2ZW5k
b3JzIG1vZHVsZSBjYW4gbWFrZSB1c2Ugb2YgdGhpcywgaXNuJ3QgaXQ/DQo+Pg0KPj4gbW9kdWxl
X2luaXQob2FfdGM2X2luaXQpOw0KPj4gbW9kdWxlX2V4aXQob2FfdGM2X2V4aXQpOw0KPiANCj4g
WW91IHNob3VsZCBub3QgbmVlZCB0aGVzZSwgdW5sZXNzIHRoZXJlIGlzIGFjdGlvbnMgd2hpY2gg
bmVlZCB0byBiZQ0KPiB0YWtlbiB3aGVuIHRoZSBtb2R1bGUgaXMgbG9hZGVkLiBJZiB0aGVyZSBh
cmUgbm8gYWN0aW9ucywgaXQgaXMgcHVyZWx5DQo+IGEgbGlicmFyeSwgZG9uJ3QgaGF2ZSB0aGVt
LiBUaGUgbW9kdWxlIGRlcGVuZGVuY3kgdHJhY2tpbmcgY29kZSB3aWxsDQo+IHNlZSB0aGF0IHRo
ZSBNQUMgZHJpdmVyIG1vZHVsZXMgaGFzIGRlcGVuZGVuY2llcyBvbiBzeW1ib2xzIGluIHRoaXMN
Cj4gbGlicmFyeSBtb2R1bGUsIGFuZCB3aWxsIGxvYWQgaXQgZmlyc3QuIFRoZSBNQUMgZHJpdmVy
IGlzIHRoZW4gbG9hZGVkLA0KPiBhbmQgdGhlIGtlcm5lbCBsaW5rZXIgd2lsbCByZXNvbHZlIHRo
ZSBtaXNzaW5nIHN5bWJvbHMgaW4gdGhlIE1BQw0KPiBkcml2ZXIgdG8gdGhvc2UgaW4gdGhlIGxp
YnJhcnkuIEl0IGFsc28gbWVhbnMgdGhhdCB0aGVyZSBpcyBvbmx5IGV2ZXINCj4gb25lIGNvcHkg
b2YgdGhlIGxpYnJhcnkgaW4gdGhlIGtlcm5lbCwgZXZlbiBpZiB0aGVyZSBpcyBtdWx0aXBsZSBN
QUMNCj4gZHJpdmVycyB1c2luZyBpdC4NCkFoIG9rLiBBY3R1YWxseSBJIG1pc3NlZCBpbmNsdWRp
bmcgdGhpcyBsaWJyYXJ5IGluIHRoZSBLY29uZmlnIGFuZCBNYWtlZmlsZS4NCg0KU28gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvS2NvbmZpZyBmaWxlIHNob3VsZCBjb250YWluIHRoZSBiZWxvdywNCg0K
Y29uZmlnIE9BX1RDNg0KICAgICAgICAgIHRyaXN0YXRlICJPUEVOIEFsbGlhbmNlIFRDNiAxMEJB
U0UtVDF4IE1BQy1QSFkgc3VwcG9ydCINCiAgICAgICAgICBkZXBlbmRzIG9uIFNQSQ0KICAgICAg
ICAgIHNlbGVjdCBQSFlMSUIgDQoNCiAgICAgICAgICBoZWxwDQogICAgICAgICAgICBUaGlzIGxp
YnJhcnkgaW1wbGVtZW50cyBPUEVOIEFsbGlhbmNlIFRDNiAxMEJBU0UtVDF4IE1BQy1QSFkNCiAg
ICAgICAgICAgIFNlcmlhbCBJbnRlcmZhY2UgcHJvdG9jb2wgZm9yIHN1cHBvcnRpbmcgMTBCQVNF
LVQxeCBNQUMtUEhZcy4NCg0KVGhlIGRyaXZlcnMvbmV0L2V0aGVybmV0L01ha2VmaWxlIGZpbGUg
c2hvdWxkIGNvbnRhaW4gdGhlIGJlbG93LA0KDQpvYmotJChDT05GSUdfT0FfVEM2KSArPSBvYV90
YzYubw0KDQpJcyB0aGlzIHlvdSBleHBlY3RlZCByaWdodD8NCg0KQmVzdCBSZWdhcmRzLA0KUGFy
dGhpYmFuIFYNCj4gDQo+ICAgICAgICAgQW5kcmV3DQo+IA0KDQo=
