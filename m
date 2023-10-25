Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142347D6A47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJYLkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYLkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:40:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0512A;
        Wed, 25 Oct 2023 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698234004; x=1729770004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=229bp7xdOh0PHXN872WUCIONMkHzRWGbUpntiWAWLD4=;
  b=uaxskyzl2v+f/qfqM9Yf0OV8rk+WVntoTuazK0wUgdwYq7JcWByTAjj6
   yUYGKdHWH0fELIeNVMBlKDdeYVxFDT6+mpqNYnmzpTQf00VaVkXrcDKuC
   wG0M/2fcxDflmka13ocivmMJWZ0GB9n2CLOQuh/Ld7CRFDJ/pheDNsIdc
   vubQqXKMgN3vSwd7z36wlatDRkkPXlL0/TBrvZcE5l/A5GUgJKlFNpP+o
   ZfW6utKy8kfZdr0Js4x0dMvbiTPiVNolzRP6Ttc7MXbPnvcOrYY6s84yD
   bnNsfYeETO3ZldipMxWgpUUmXvlxiEDROv2KpwAJf3NOdfGMNPwNGh5ko
   w==;
X-CSE-ConnectionGUID: uDHbV2nMT5CNuNpT1QQjQg==
X-CSE-MsgGUID: Z3Nd8QjMS1qDnSzleUSlRA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="177737852"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 04:40:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 25 Oct 2023 04:39:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 25 Oct 2023 04:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLCx0oiDP6mDRyf/OWNmp9hdHpFf2nU7mMus2GAGThqWxjaQ/rU+4hd5MWRRBTE/gw7MBoXkunII5XDvdSfJiYYcLFNQsWSHnRQYQ5B6br98dipNHLl2kBV6rJE/cpjGvu7oAvunRetkO7xkjsKP4n+EU0QYWuhYS2twwSZGOz9jJFRH/+Ru22dlmbwIpb1usQcZrvq9naHpY6tomb8ByyHOGi4t+1B01UQLCgv43eVvE2OHRdVuhsS5JuHuwkw7O2uhvAbu2kinyo3XVEzpbt4hShG9jZa9Xwszx58TDk6rTE2lGcx6fc/PVhiZkwKHVYmvPu03oBZu+Dg4kPteZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=229bp7xdOh0PHXN872WUCIONMkHzRWGbUpntiWAWLD4=;
 b=ADjcSuS52x01+zj3ahsliZc1aS9Xqei7uFwehn2y3yorZgLVXHof4WNgmx2Dl832bJKuiW5rTJqyM5tZE6V2yRJkcc5FVTCtfgMW0guFLl/0L7VjygRYJbG9nNprQ504N1dFCn7djwLacxe3biJzILWf1C+By20InXU1/09fyHFlgnNFmgmKZN2xogDMyYQrg1LIbQTYG85ithWKmMpFlPCL6srznE8HxWzMFY7uuj6u0atPKK9KMyzqe9r/vfKAj7i52UVc+ZJSUqhK4njub3DD9xhQU2JzVw899auTm74fTddpWqzwrLem1jpshLtfQ+MWNgXxktduNC/0zRl9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=229bp7xdOh0PHXN872WUCIONMkHzRWGbUpntiWAWLD4=;
 b=TIW+Fj27Gkmow8dL5OvSbdelSXTmznGHKnqBNajo52HCuvzBm+WXpbXT+dooVcy1A/ED0HilCER3Eq56nXScsr6BiAZ82BBq6AF0i3Xn7/i3hlNrdV3vBmMCxXJ7bJBkfINHAvu08nGbNtm9SRY2a/YcWOZ+qi/EgR3v7aDjCaE=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH0PR11MB5952.namprd11.prod.outlook.com (2603:10b6:510:147::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Wed, 25 Oct 2023 11:39:52 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 11:39:52 +0000
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
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Topic: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Thread-Index: AQHaBchLKhew5fqyxUWYo0q8cO3RgrBX+QGAgAJrRQA=
Date:   Wed, 25 Oct 2023 11:39:52 +0000
Message-ID: <841b3e03-1944-43fb-9698-eb5db6c029ab@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
 <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
In-Reply-To: <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH0PR11MB5952:EE_
x-ms-office365-filtering-correlation-id: ddc474d7-e506-49f1-cb76-08dbd54f1a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F6d/uu4FIWwyE+EAeDJWBJPzlUBDdWRZTsvqOu6cS4lhc83bHrQbSh0LaBEqXckNAooiht3btGR4maqU6pbgxrexx1fqji7dNdRJ+8Tsfzq0u8dAfF4N2ZUWitXnUvZzoB9UahmxAW+eY/BdJ6mSoxDb81uJlX8HhyOoZitb0GRPZT1Smc1wS4zut97T1JX42f/nbGeLNaa2tOj4xdZ0lDgSmGh0JyDpv/6ZM9DxE3ymeHPyFXfChfQSckCqrDiRhhKF1WapPP55JUeduIAMWWA6iC4f76wjqlvjgsDbOGohtmXeJ0FVSWI5FQ+5Ox9l1FhvemGkjTaPgf7SgbWspKb8GE/S0+tyepcVUZxsPb2q07O4zZOAhV6kzuethyM6tJyubXerAvveLQDepptLncAEWgYaxa1+C4CDcvakCQ1OsPHPon7nHTj9UfN9T1+uBUFOAulE9yvNXVkzPe6/TUKvBmAKZ4lIedFv8NTvwCbX8XUZevDuhxcK56qJoIrnEpvSGl211aucXbl+MfVuDAW57jOl1qid1dbMMEiKY3PuQPMD/3wJhtXr9Ij9GaHDkZqoyVTWaXOgvXKibi3Je1+90Ww2fIcTcMUTY+Rkvo47j2bQ9L9ih7nJDn7i9CnY2LL44pq/AYYVaYzz+mrfCC/KiCRBd8X5SzrO/bFBOC6Uic/ttYiJZ4oIEDNvPmp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(38070700009)(31686004)(53546011)(6486002)(91956017)(2616005)(122000001)(316002)(66446008)(107886003)(83380400001)(36756003)(54906003)(66476007)(478600001)(7416002)(64756008)(8676002)(76116006)(31696002)(2906002)(6916009)(86362001)(71200400001)(38100700002)(66556008)(4326008)(6512007)(8936002)(5660300002)(41300700001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0Z1ZFJhYWsyLzFGc2F3Q2dNSUpHRVlIVldDYUVIa2RNNytrVGRRand4Ulk1?=
 =?utf-8?B?OFByS0tGYllMM0lSL3NXeWlFbFhZVW1TUFlXcnpEcE0rUXpQTjU0cDdvK1VM?=
 =?utf-8?B?REprNERwMlQ3aDJYaUV2YlJMbjd1MWp4TnFYd3pRMjY0ajhnVi9ycFNmeEY5?=
 =?utf-8?B?T0VseGRqQm1CZ2w2eXBSeE1Mb1ZheitMc2w1K3BsK2RVekozaTA2MWNMV2k0?=
 =?utf-8?B?eU5Uak9jdjVCejZMZHlJZWlSaUVsSmRMUkVFN25oaSt5VUYzaGQxS2hVNkVJ?=
 =?utf-8?B?RGVhUUhxTUh2anQ1ZXRrSUNOYm9rM2V0bnRjaGZQbW9KbjJBMjVhbXlBQnMr?=
 =?utf-8?B?Vll5Sm1jenhwVmNpNG44ZXhLMkM0eFZlbG9QMWdrbnRBTGRvR0dBUytCY2gx?=
 =?utf-8?B?aDRpSVN5V2JVQU9OUXVvY21yNTZBSjhDY0pvVXBQSXY4bkwyaHIwcmg3UU9Y?=
 =?utf-8?B?b1dGby8wT0RXZjdPVDZpLzEyNTEyTXlJaDVEWFdyeG1YbzBkem9ZZUNtZkk1?=
 =?utf-8?B?OHI3Y2dGVXFtT24xNTFScnhOcmlsRkF5WjBSYUlzL1FnY0tKSDl4dU10eDd0?=
 =?utf-8?B?aCsxSHFYamFtOVdxSjJRMDE1SGswUVQvaUVXR2szUHlhV0ZSVmhocmdBeEJP?=
 =?utf-8?B?WTIyWUJORnFHcGFDTGYyOG9obmg1RUp2azgvTmtQM1NmYjB3aTFYdzhvNURE?=
 =?utf-8?B?OUFDWkszLzFaQjVCWnFqcGxuSWRnaXpZKzdEUmVMd09hekJ1VGJMMkF5OVBk?=
 =?utf-8?B?dHhRQThFMlR2SjF3dGJwNEk5eWpPQVlMUFprYUVKeE1iUUlvYkdEUEhsRCsz?=
 =?utf-8?B?MzlaMjlaejF6eVN3amdLWURBdThJbUJUTHBDcUQyc3ZjWVhlQnhTb01BcVN1?=
 =?utf-8?B?RXg3SWhOdWVDV2Roc2NPRTQzZ2lYYWp1QlVCSndBTXplakVmZlVMcHhTSXZz?=
 =?utf-8?B?OGk3a3NRVzJKb3Q1ODZMSkYxdnZ2TU1lUXB3bXZzWjlVa3hOOEdNb0RSM2d1?=
 =?utf-8?B?WSthenlWWkpQTUNkeGp2K2kxck80dkh0VlZjZENIb1htb0sxOTFqRU9vNDdw?=
 =?utf-8?B?cVhFYUwrSlN0a1M5T3VJVHpacURrbWNhOVFMaDBQZFVpa1ZDQWxYdTd5OUt1?=
 =?utf-8?B?Z1k2MmUrdEsrek9WeUw0QVdyd1hjTGNTWnp0WVAwcW5Va20xVkVkVkpzSmE4?=
 =?utf-8?B?STdTbFFFWVVadXhnM3hycEJLQ3NpRytZdzBJV0x1OGNia1FNRlQ1dXdveG91?=
 =?utf-8?B?QnFUcDVWWXR3amNzWDhlL210TGwrTnBTUVZmWG0rSkpHS01CMnpaN2xQWDBM?=
 =?utf-8?B?eXlYcm0vWFFaVlU2cjVNSlVMeGs2UmxyT3JSazJ4VDZsSnlkRTFtSnpMeVNz?=
 =?utf-8?B?VkxDWGYvTmpxQXJ2ckF1TXRtcVVyREtaTllIbTdHcFp1WGZPeTNHK0VjWmtD?=
 =?utf-8?B?SXhZUCt1M29Od01VWlM5TFR0dzNkd2x0ZmJkQzRWKzBGTkRibFNmd0REVmhl?=
 =?utf-8?B?bVRZdTRuc0drb05UMXp5bXNTWTNTT29DZkZPL2pHMnhFeUxOUzZrQ1YwMEw1?=
 =?utf-8?B?cnN3aE03MmdxUGE3S1E5QUh4SFVqek5iVVdzd2xpMDBaeTdibzk3MUFSS01W?=
 =?utf-8?B?UHRSUURTc3pYelZRR1UvSlJ1d2lPTUV4ZVBrQURjNElYbEdlL0RBM0ZvdFJ2?=
 =?utf-8?B?R3RSSklRM085TDM3aGt6Mm42QnZtUHRnbHRJY0pHc3JsY3Y0Y1BQaENjWStC?=
 =?utf-8?B?NGh5UDg0VmdpQkhaa0NjZGFnMjRmWXd3cWppN0JKNk9LVGJHaHhxZDZUeGJT?=
 =?utf-8?B?WWp3ZDRYMnpyakl6dHRsN0lGN3pRenZCcTNtQmk0M1FjOVpSOGhpRDZzMFNo?=
 =?utf-8?B?QWZ2UGg4K3Y4d3E1ekNDZnhPeHc2UnhOWnZrN1JKVmx4cUR5L0JORmhIcHBo?=
 =?utf-8?B?Y1phTkNSdmxwem4yR2pCQ2VCTGVQQUdVWG5jbmhrNDNlOXNZTVZvTzRLT04w?=
 =?utf-8?B?dGl3WVlkT1hvcXNnalROemZwVVVlMThBazdOVElLMHAvbVNLeXRQU09DVlEx?=
 =?utf-8?B?ditWRDhqYzVKK2wzMFZqUnNLLzNNOFpaT2xpdi9GcWhYcmtqaG9MUjFNemxE?=
 =?utf-8?B?T0RDTVRIb1RhbWVBeUdONzQ1bjR4eUxFUUV1VmJ1SzltZHJ4a3k3dmswWUcw?=
 =?utf-8?B?c0JWcnhkelpKVFgrcENnK01hbkEzQkdnQWw3MGhxcGlIY3ZwWWNpYVV0OCta?=
 =?utf-8?Q?oz1pQyuVXYryDPec2EW05PUXsQwBLt3tzw8eXhrOzs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9D796CA666564EB9139C7C6FD4F68B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc474d7-e506-49f1-cb76-08dbd54f1a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 11:39:52.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+f5kQCGVMJ4KK/cVmAANmxUdQWexXimcWKWMq4Q2fHl3HJzBpza613AM/Hi8rcUTN9dbk5fWDfbFAVG85+jarfo1GJCMrOuFsIq6bC0dm99ruaYSYGo5giKAnNg8Ra9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA0OjEzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgICAgcmV0ID0gb2Ff
dGM2X3BlcmZvcm1fY3RybCh0YzYsIFJFU0VULCAmcmVndmFsLCAxLCB0cnVlLCB0cnVlKTsNCj4+
ICsgICAgIHJldCA9IG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2LCBSRVNFVCwgJnJlZ3ZhbCwgMSwg
dHJ1ZSwgZmFsc2UpOw0KPiANCj4gSnVzdCBsb29raW5nIGF0IHRoaXMsIGl0IGlzIG5vdCBjbGVh
ciB3aGF0IHRoZXNlIHRydWUvZmFsc2UgbWVhbi4gTWF5YmUgYWRkIHNvbWUgI2RlZmluZXMNCj4g
DQo+ICNkZWZpbmUgVEM2X1JFQUQgdHJ1ZQ0KPiAjZGVmaW5lIFRDNl9XUklURSBmYWxzZQ0KPiAj
ZGVmaW5lIFRDNl9QUk9URUNURUQgdHJ1ZQ0KPiAjZGVmaW5lIFRDNl9VTlBST1RFQ1RFRCBmYWxz
ZQ0KU3VyZSB3aWxsIGRvIHRoaXMuDQo+IA0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIC8qIFRoZSBjaGlwIGNvbXBsZXRlcyBh
IHJlc2V0IGluIDN1cywgd2UgbWlnaHQgZ2V0IGhlcmUgZWFybGllciB0aGFuDQo+PiArICAgICAg
KiB0aGF0LCBhcyBhbiBhZGRlZCBtYXJnaW4gd2UnbGwgY29uZGl0aW9uYWxseSBzbGVlcCA1dXMu
DQo+PiArICAgICAgKi8NCj4+ICsgICAgIHVkZWxheSg1KTsNCj4+ICsNCj4+ICsgICAgIHJldCA9
IG9hX3RjNl9wZXJmb3JtX2N0cmwodGM2LCBTVEFUVVMwLCAmcmVndmFsLCAxLCBmYWxzZSwgZmFs
c2UpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+
ICsNCj4+ICsgICAgIC8qIENoZWNrIGZvciByZXNldCBjb21wbGV0ZSBpbnRlcnJ1cHQgc3RhdHVz
ICovDQo+PiArICAgICBpZiAocmVndmFsICYgUkVTRVRDKSB7DQo+PiArICAgICAgICAgICAgIHJl
Z3ZhbCA9IFJFU0VUQzsNCj4gDQo+IFBlb3BsZSBkb24ndCBhbHdheXMgYWdyZWUsIGJ1dCBpIGZv
dW5kIFNUQVRVUzBfUkVTRVRDIGVhc2llciB0byBzZWUNCj4geW91IGhhdmUgdGhlIGNvcnJlY3Qg
Yml0IGZvciB0aGUgcmVnaXN0ZXIgeW91IGp1c3QgcmVhZC4NCkRvIHlvdSB3YW50IG1lIHRvIGRl
ZmluZSBTVEFUVVMwX1JFU0VUQyBpbnN0ZWFkIG9mIFJFU0VUQyBvciBpcyBteSANCnVuZGVyc3Rh
bmRpbmcgaXMgd3Jvbmc/DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAg
ICAgICBBbmRyZXcNCg0K
