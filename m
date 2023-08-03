Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0376DF1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHCDmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHCDmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:42:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B43E4;
        Wed,  2 Aug 2023 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691034124; x=1722570124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uAXL4wnoH31JxweJsSwLb423dS6Emsu8aAXVGZfk9ms=;
  b=CGpNln/5Dr1VL78K5/5NyDZRvEuRoykUEpI6mNaXLvIadxjHRnefh5t2
   wdMQCorGFt2rh5ZHBXs6MqH+ZFRhN76CS0JS7oij7wiqSItrrjvE2q/FF
   jO3R2ZwYjlUaPCwkw4muPvbhyyP2QW7CbdIBSvsYEkoJkVe6kY+FKqbbE
   y7jGyjQXF74dqY+DioGYK1Vr86thMoZ3Dx1Jb1TuoTmEru6IWp0G3P+8t
   k9ZwcKgIxmxXOFr40ybpSNFSZ3hD7XvF8d+J0ROSxXJigIZ08xhRhrfqQ
   gOId7MY37nygUhzblGTIrO7eXRnSia3ooOCHhciMkCUZ8BLgvRVSmcB+m
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="227719946"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 20:42:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 20:42:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 2 Aug 2023 20:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKL6U94kPiP5Dk1Rh1PNxdHraq0IFQwM0MCKbMZ1WwuyP9SlH+KLatX4db2ylsYHX3W7TQ10xwQgs0eUXX0Sjsv/pqn6iHHJlJ53La2A+tkv9EaFv2EcYt5xj6d2FZb9mKtmhjARVeI2rgBBVxyml9JNp354Zj4HjnHSJduLlU8Vqyj6AsMIAvekFUry9nsDellhimlZgk6Bihe545ynt6mAELps/JiDQnCkF2URfxSvtuL+AVf5jTKqyMXMCYZHeHA7Gw1gRVzKwzf+vkqYuwCuX6uyZCLbqR85ir5CzAeGUM6d2og1vro/jus1986EYnakg8yKGH0MIfSXJJbL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAXL4wnoH31JxweJsSwLb423dS6Emsu8aAXVGZfk9ms=;
 b=S8ZqNt6dbCBQfsY4opy/M8hYt+Two3XL+P4r3C/eWdtH7aBgl4UWIcUVVTobRip6DWTArTdNID56Oy1MUOmy/dC1YLRunWyb03T1t8agyIlJUyI7WFzwK7muRpXlyvkmRPKvih5wvJ5BpgnlHiWywgJNTxVJV3LPKSsy2sen9fLzptLyP5hfq3TPvG2Y9ShEoPwQOmDrBp6lVP1a8Fu3ehhDY3z2SrKyM4foyJsQWmS5oD9uXwc4GFDKLr5LV6NYsncWi+/GzCUwC6TNvz+TYBvtazJjNoijVlo2aFgFDarwShVNPYCnWtc3RDATLwJpJ4YnXh4vWxLEPdPFmYksyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAXL4wnoH31JxweJsSwLb423dS6Emsu8aAXVGZfk9ms=;
 b=CBUQc9UFAX+WRDaCYEHF4MSHcIlloA5fgqqpwIj6ogosZaqC3pYsgoWU1iEDhqo45uSFWltG9IfIOzqHnGsdOiPqWEwmxVcShzxKhkMoAU5fnmbgoGKSder8AIeyj4GMJ7C9CzvAPtC8dEdstaQ9HWgBE8sIOChY+hsd0JjxxuE=
Received: from SN6PR11MB3341.namprd11.prod.outlook.com (2603:10b6:805:bc::27)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 03:41:57 +0000
Received: from SN6PR11MB3341.namprd11.prod.outlook.com
 ([fe80::f71d:7e80:690d:ee1c]) by SN6PR11MB3341.namprd11.prod.outlook.com
 ([fe80::f71d:7e80:690d:ee1c%7]) with mapi id 15.20.6631.026; Thu, 3 Aug 2023
 03:41:57 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Thread-Topic: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Thread-Index: AQHZw2rbMPoDf41Sy0CTnd7RT703zq/T48aAgAQNxQA=
Date:   Thu, 3 Aug 2023 03:41:57 +0000
Message-ID: <SN6PR11MB3341C4078B29FBF86F14F8D5EC08A@SN6PR11MB3341.namprd11.prod.outlook.com>
References: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
 <337b535c-e2a3-bd65-d1c5-fd7199432891@linux.dev>
In-Reply-To: <337b535c-e2a3-bd65-d1c5-fd7199432891@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3341:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: 6edd405e-7cfd-4211-22c6-08db93d396ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0+CycMSVSUG3gsqpTHDBBJBJo9V7pa5+QbZM/6snyqtkxK04A+QStW0RwkqWxBirFpMHPC6Ti7BzX6ooi1rBZgXtcY1xeNBBMwQZ+r4zTMv69E85NlDw/Pek2s7/0AjvmMfwVaIPMuNwOxXchzhr0CMyWIjpyKICCJAK0Gc5D+6e7fnSM4vTaAboFTa/ToXIuvYdB7BHShfWeyvPDaz328UpLUr1ivtMZlVuro56bOT4TnFrvVJ45mMbduAATkXuKWY0bzngI4JfnEjnv01hmjvvvA7bFt0nqtXWsueoQzF9D+/TaOp1RRPmns421Ns2MvRglIAYKZTDmUEW2GgyhzqyyHX6X0jaFm0dmMHAU3kqmPSA8wkM66UuigzSytnAp61rwGy4Odk5+GnF/5CWrQOgzJGBwv5s5Q7c0cu5/Djvx2CcKPRjN3lQj5CUBams8KU/Nf1x8QnXTPCmx0TAeIvOcQ4MwfxP4++1WgNQJtjscIvuncAFaveK3kweXsD3mV3L9f6bMjX9VIjf0YPYkQzUuMG3+mMLTKTLVrN15C/GoLscmADJ1WTWzh+4/YKOKqS1TtjkxB7xjo0P3AsDusL7hYLM/0l2HUyg5cXAD7wIwK75axCvVsQvm96Hvtg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(41300700001)(316002)(4326008)(2906002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(52536014)(8676002)(8936002)(5660300002)(54906003)(122000001)(38100700002)(33656002)(26005)(6506007)(53546011)(186003)(38070700005)(86362001)(83380400001)(9686003)(478600001)(110136005)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlEyaXlRTEVYWjRzS3BoMTV4cVRvK3Y5SExCZlVOSWdvTWJ1bWFtOU1XdlhI?=
 =?utf-8?B?SG02aWN6bDNLMktxYmxSanpTRkdBMkFiUGJyVlk3MU10TUNIRnk1dzJEbDQ0?=
 =?utf-8?B?QktUNFlhdXJodG5XVFNRUHlvcUoxWHluR2lDWVV0U0NVRWl1bDByMy95T0F2?=
 =?utf-8?B?MWYyTHF3ZWxGSk9CQjY0dmxTdVltM1hKc3ZVMUVKVXp1c0lRV1BrVEx2NUxy?=
 =?utf-8?B?ck55QlFpUzVqcDgrQVJ5K0dvRlF2Y1A3S2dDOTR6VnFLN1R5MHpubjJuRXVm?=
 =?utf-8?B?dC9rRUc3UlVtUU1LUWlvUzA2bUxNY3ZqeW5zMFNaa0EyS3YvQW42V0ZaWUdz?=
 =?utf-8?B?MW9jN3Q4bGF2RXROcjFXRDB6TnQyQ0tXeTdtU1Zmam1rMGphSWZoREYzTHZ6?=
 =?utf-8?B?S1BJK1dHNXVqY0EwbXhMSTVnSGV5MDh0Sit1VHB0NWlzZkF0dEp3Wkl4VmFK?=
 =?utf-8?B?bmdGaTNJZnBpL0w0Y0RpaVJlTGdOdUwyc2wya3VmQ2ZmRTNOaWRuekgwSmFN?=
 =?utf-8?B?eXZKVDhCc3VPdFJhRGpyak1ETWliaEVFVGNDWVBGVU5ETlFtYVdTdDlFWURZ?=
 =?utf-8?B?SzU4TVE3bkxlajBNYmFKc2V2TFFGdHhvcE5kOGFLbEhrZEJsellCVzFQSERn?=
 =?utf-8?B?dWkrdWFNUERFa1BIY2RJcitWS2czelc4NDM0SEUxR2UvL1F3cEJHejZRbGN1?=
 =?utf-8?B?d0VRNnkzSmNwWHhXNzZmMU5OUkhyWTVzanExWnBmVkRYQmFPaURvYmJld0ZL?=
 =?utf-8?B?Ynd2amJNSVEzYlFPWG40VEVIYVJaSEZYSXcxUENIVmJMbnZnR3llanJEWWxD?=
 =?utf-8?B?eC84clFWVFFFektId253UmpxakpUaE11d0t0S0ZVazVvYzljYVNPODd4OGV4?=
 =?utf-8?B?cGZwWkJ3SVdMb2ljUlEzUm5IbGpWaXAzZlYyb25SV2o1ZjlJc1lML0ZQUGdi?=
 =?utf-8?B?VldDTDNxWkhBTDUrbHpPaThUeGNxVEN2UEhnZytjeHpVTm95UVdLalJLSU9P?=
 =?utf-8?B?M1RMSGdyZkhYNXJ1M2dCcUhmalA5T3RyTVZoS2J6TXY1VzRPQjNDVnB1b00r?=
 =?utf-8?B?OUt1WE9MSXREZUtSOGVOdk1tODdXUWJrL1pycy9kenRjWE9HNXdzVEhpOWxi?=
 =?utf-8?B?cWdYSnplWitNdkVTMnVRbHZCNjVjYmxKMUV4U2kwUHpXSm42R2NXY0R5WGI2?=
 =?utf-8?B?bmdYUXNaU3MydzJyN0E1eitBYXY2M3E5RkdSbEdkajcraTd3MGszZytRdlRi?=
 =?utf-8?B?QUp4d2FZVGd6SGlKMm56RE1kU1FjZjh0MEFYM1N4NHFsNjJBQmsrTDVWcHJx?=
 =?utf-8?B?R2hCMEw0Mms5b2d2OVdPZmllWENuSnJxU0NtbkdDdkdPVExyMW54RDR0TEkv?=
 =?utf-8?B?cHdBZTNTUnFMQ2ZkUVBpSEg4RHoxd3JQRmlrbXAwWElyNUZFYTdHSXhMbzZ5?=
 =?utf-8?B?a01nbkpncnhNb05sWWE4ZCs0VE5zUVNlK1JCM29kU1RJeDVMZmxEcHhNdGhN?=
 =?utf-8?B?RkpUR1c1TzZOWGZ6SWNWenBQR0QxS0plUTlGc1dvL0QvSWJvWktUUnlIUG9a?=
 =?utf-8?B?SVF0c1dtQ3IwZmk1d0VrQ1Y2b1d1QXlQWkYwUXVHY3VZKzY1Qk5oTVZKRlJs?=
 =?utf-8?B?dHd4QVcrRnNJTUpXOWp1UTlCbFpsQW9jT2pvYnVoeWcwaDBQWGU1NUtPc2Vp?=
 =?utf-8?B?SXdVaE5kMm0yVkVHV0w2eElSOTFxQktYZ2UxaGVVSlU3RkMyR1dTR04xQ1pu?=
 =?utf-8?B?cGRzZEtaTk5lZmY1WVZVOXQxNE1KTW1jL09MT3dVWEs0M0h4MENnbFhxSzZ5?=
 =?utf-8?B?V1R2UXp4VGVLQzJoOEJaNXdXK2xTOHNhVGpXNG1yOHNpVENMVE13REh5RUFM?=
 =?utf-8?B?ZDZBTm1RV0xWRGttd2ZON1JSWGtKME5JOGFpOHlDdGdQWlRpeU5yQmkvNmR6?=
 =?utf-8?B?UllLdy9YYXNPYlpxNUlKL3NHOC9qSHlIVGJFK3llS29OTnlZUERLckRlL0Fi?=
 =?utf-8?B?cStoUlJOQ1JwM0xwM1U3aW5IYlh2d3FtMmtNSWhmaFgydVErMjhINGgrbk9y?=
 =?utf-8?B?Nm9aajllYzZaWDJFTGwvUk9jMWxpeUxLMWJISE9BTDl2VW8vWkJnNzNaRW94?=
 =?utf-8?B?TUJ3K2NEdWxIL0J0ekVQenlaMkhtNGNpWXpnNkk4Zk5uQWgrTDJiYWF0anBH?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edd405e-7cfd-4211-22c6-08db93d396ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:41:57.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZkBDHvLp+4OPh81QcdUw7l9LXAO0YFwHTl/pJsHlScj4A/1wmtVmix0r43wlXkCWTKkCFHSTZCqEfw2kOZ4zsJx/h5/3sITVOygIbq6ReE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmFkaW0sDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQpXZSB3aWxsIHdv
cmsgb24gY29uZmlndXJpbmcgdGltZXN0YW1wIGJhc2VkIG9uIGh3dHN0YW1wX2NvbmZpZy4gV2Ug
d2lsbCB1cGRhdGUgaW4gdGhlIG5leHQgcGF0Y2ggc3VibWlzc2lvbi4gDQoNClRoYW5rcywNClZp
c2h2YW1iYXIgUGFudGggUw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVmFk
aW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGludXguZGV2PiANClNlbnQ6IE1vbmRheSwg
SnVseSAzMSwgMjAyMyA3OjE2IFBNDQpUbzogVmlzaHZhbWJhclBhbnRoIFMgLSBJNjkxMDggPFZp
c2h2YW1iYXJQYW50aC5TQG1pY3JvY2hpcC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpDYzogQnJ5YW4gV2hpdGVoZWFkIC0gQzIxOTU4
IDxCcnlhbi5XaGl0ZWhlYWRAbWljcm9jaGlwLmNvbT47IFVOR0xpbnV4RHJpdmVyIDxVTkdMaW51
eERyaXZlckBtaWNyb2NoaXAuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgcmljaGFyZGNvY2hy
YW5AZ21haWwuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSBuZXQ6IGxhbjc0M3g6
IHNraXAgdGltZXN0YW1waW5nIGZvciBub24tUFRQIHBhY2tldHMNCg0KRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQoNCk9uIDMxLzA3LzIwMjMgMTM6NTQsIFZpc2h2YW1iYXIgUGFu
dGggUyB3cm90ZToNCj4gQ3VycmVudGx5IGFsbCB0aGUgUlggcGFja2V0cyBhcmUgdGltZXN0YW1w
ZWQgYW5kIHRoZSB0aW1lc3RhbXAgaXMgDQo+IGFwcGVuZGVkIHRvIHRoZSBSWCBwYWNrZXQgZm9y
IHByb2Nlc3NpbmcsIHRoaXMgcmVkdWNlcyBSWCB0aHJvdWdocHV0LiANCj4gVGhpcyBjYW4gYmUg
b3B0aW1pemVkIGJ5IHRpbWVzdGFtcGluZyBwYWNrZXRzIG9ubHkgd2hlbiB0aGUgUFRQIG1lc3Nh
Z2VzIGFyZSByZWNlaXZlZC4NCj4gVGhlIFJYIFBUUCBDb25maWd1cmF0aW9uIHJlZ2lzdGVyIFtQ
VFBfUlhfVFNfQ0ZHXSBzcGVjaWZpZXMgd2hhdCBhcmUgDQo+IHRoZSBQVFAgbWVzc2FnZSB0eXBl
cyB0byBiZSB0aW1lc3RhbXBlZC4gVGhlIFBUUF9SWF9UU19DRkdfTVNHX0VOXyANCj4gY29uZmln
dXJlcyBTeW5jLCBEZWxheV9SZXEsIFBkZWxheV9SZXEsIFBkZWxheV9SZXNwIE1lc3NhZ2UgdHlw
ZXMgdG8gYmUgdGltZXN0YW1wZWQuDQo+IFRoZSBSWF9DRkdfQl9UU19BTExfUlhfIGJpdCBlbmFi
bGVzIHN0b3JpbmcgdGhlIHRpbWVzdGFtcCBmb3IgYWxsIFJYIA0KPiBmcmFtZXMsIG5vdyB0aGlz
IGlzIGNsZWFyZWQgYXMgb25seSBQVFAgcGFja2V0cyB3aWxsIGJlIHRpbWVzdGFtcGVkLiANCj4g
VGhlIFJYX0NGR19CX1RTX0RFU0NSX0VOXyBlbmFibGVzIHN0b3JpbmcgdGhlIHRpbWVzdGFtcCBp
biBhbiANCj4gZXh0ZW5zaW9uIGRlc2NyaXB0b3IuIFdoZW4gUFRQIG1lc3NhZ2VzIGFyZSByZWNl
aXZlZCB0aGUgdGltZXN0YW1wIA0KPiB3aWxsIGJlIHN0b3JlZCBpbiBhbiBleHRlbnNpb24gZGVz
Y3JpcHRvciBvZiB0aGUgUlggcGFja2V0Lg0KDQpFdmVuIHRob3VnaCB0aGUgcGVyZm9ybWFuY2Ug
YmVuZWZpdCBpcyBjbGVhciwgdGhlIFBUUCBzdWJzeXN0ZW0gcHJvdmlkZXMgb3B0aW9ucyB0byBz
ZWxlY3Qgd2hldGhlciBQVFAgZmlsdGVycyBtdXN0IGJlIGFwcGxpZWQgb3IgYWxsIHBhY2tldHMg
bXVzdCBiZSBzdGFtcGVkLiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGltcGxlbWVudCBib3RoIG9w
dGlvbnMgYXMgdGhlIGhhcmR3YXJlIHN1cHBvcnRzIHRoZW0sIHRoZXJlIGFyZSB1c2UgY2FzZXMg
d2hlcmUgdGltZXN0YW1wcyBhcmUgbmVlZGVkIGZvciBhbGwgcGFja2V0cy4gTGludXhwdHAgY2Fu
IGJlIGVhc2lseSBjb25maWd1cmVkIGZvciBib3RoIHZhcmlhbnRzLCB0aGUgaGFyZHdhcmUvZHJp
dmVyIGRvY3VtZW50YXRpb24gY2FuIHN0YXRlIHRoYXQgdGhlcmUgd2lsbCBiZSBwZXJmb3JtYW5j
ZSBkZWdyYWRhdGlvbiBmb3IgYWxsIFJYIHBhY2tldHMgdGltZXN0YW1wcyBtb2RlLg0KDQo=
