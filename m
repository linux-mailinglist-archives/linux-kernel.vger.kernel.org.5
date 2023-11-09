Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2045E7E68E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjKIKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjKIKyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:54:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E32590;
        Thu,  9 Nov 2023 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1699527270; x=1731063270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jqULNvC8So1R7XXan2J5nhd00nJuRRCdv0j4wy4LbsI=;
  b=cTPzOmrXJe9q6CJYl2us7wEO5gYBivgln2bj5f9kYfx8SzDA42IW1sMW
   dqsu1HEJGiPiWM66L3cDeef0Lax5x9NsRcxb7NMkztutOdygCv8WYaI+3
   FF2iSaUlWVKDBG4PN6A4wm95KBD+GfByrJMJLsb9wpdgNn+H/MYWdt2RI
   C/O9pjKjyBeCP1Z6nPSDIB28puA0sCGKl6yn5SgHktMhgl5X/+ay75snb
   qPlZDI2pNN+uu5Ij3RBz5ZuLLei5Qm0MsjrvjVwsr0hYd2cVaqZrkvin1
   QDKzzPkkpKQPIOzcuRTI1cQvAH9IjIfBZrLs8ZA8RpftpMt2TZaLBJKlQ
   g==;
X-CSE-ConnectionGUID: uIkylMUjRo+ABRJWN7sdzg==
X-CSE-MsgGUID: WEM7x5ooTEqkwtyqH4iL4w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="178583222"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2023 03:54:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Nov 2023 03:53:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Nov 2023 03:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTrWOGFpw/gIBfP7gFSQ1fkPnZrxse/j2QCAdwlsLCzrj8N8zP1n3I18DOtrYf6PN3FW0ZcOqWbnaG6jfLBRlHoRyFcKy5W3EXWrx3hqElMC2PG6WhDHOkDAA3HQChaK94VP9BNC32mg/utbPAYcYmY2i3Sm5AL0pcTyTZ9rmacR0NFmzUCKX7Zl4NlyM3lDif1dTlfGDaJu2+d5yWJVHUD9KvN9IInjuDdsC/6LQWMJBdwLyueZ8rHtbnMn20zoAQ9ONdLDPZSVGRK37mtm1BnjswfZ3Nnl+C7KMWcj9vC5ozjmtIugMj1DG4Ob8l8bDRVFcWTzLIpTsYuNyzIy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqULNvC8So1R7XXan2J5nhd00nJuRRCdv0j4wy4LbsI=;
 b=kTMCynP8x8CWeHxhyg5/kG1IU+eb7FFlaoZVukrk60ldofaOzZXHxoXpubKOsp2VjPgHKMG/7rqINnjbopephkT1n1suNdF7YsY7BazfNXn6Jb08bIWtHhkeXo+hbod+Eaw5lXq0eAo2Q/sY/hTVcjviKaAlfXJKgeom7otAiglJAbIYZKmHX/VLv5hBpyrlLxd91YqwK8NlPnx6Ql3J6CfHZJjOy8535byaC/PoOUpzd95aDD/kwmZqXmurXxYFqJYPcgJ4REzdXhz4OIGftwhAs/YvHvvk4eqZMJsCLoNZPWoNjEtqbeTRgbokjkvrs9rHTcMtc3iyhoEQVqVkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqULNvC8So1R7XXan2J5nhd00nJuRRCdv0j4wy4LbsI=;
 b=vVmiXzlF55uqs/PGo52qMBXn+XxLEFKeycoVp74vMiYuWpaphUB8WjHmbBzOU3RMDvB+gafEFPe41XVolenfUsF42a7EwXTD8xoIsllReMpW78hPdWP8YE1l+aycbTSPA2hqzUQJRg0KVC06WAw9/tX0XRs3VeLXs9fmBW4TdNg=
Received: from CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.30; Thu, 9 Nov
 2023 10:53:26 +0000
Received: from CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51]) by CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::311a:249d:c84a:1c51%4]) with mapi id 15.20.6954.030; Thu, 9 Nov 2023
 10:53:26 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <kuba@kernel.org>, <f.fainelli@gmail.com>
CC:     <Bryan.Whitehead@microchip.com>, <andrew@lunn.ch>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <edumazet@google.com>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Topic: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Index: AQHZ8QY1ceTQbXJwb0+3Qg4gMnoFrbA6DY8AgAALvoCAAAIkgIArKtQAgAzOQQA=
Date:   Thu, 9 Nov 2023 10:53:26 +0000
Message-ID: <0d0627cbd32afb813b75b485ea8e979ac027482d.camel@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
         <20231004122016.76b403f0@kernel.org>
         <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
         <20231004130957.2d633d03@kernel.org>
         <ee81b2128f5178df95a1678d2cf94ad4edf2c9e9.camel@microchip.com>
In-Reply-To: <ee81b2128f5178df95a1678d2cf94ad4edf2c9e9.camel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7688:EE_|IA0PR11MB7356:EE_
x-ms-office365-filtering-correlation-id: f89bcfd7-614e-4be9-ba70-08dbe11219d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEG7iZTjeBf/a5CQ0E/BbCYdsdFGVPNduixT0gEzIKbs9Py9oMyNqhqzLM3HzGqsokeyOs9XvSJG1jCjO61pFSa2C99RXYgv0qqfalwOCWU4Arji5hwRa47ZrcwLBmudFeZ8Lxw2dV4MBI3LSfoKEm1bITdEDGpIDgrhr0tPpYHcclpLHZmX1yFMWIRNtd3RHCTsNYRluqXzkN4XOJvX4sDCFFfLsUJRmqQKpwQKNAE57fBoLEyHNDP/LcW7S5iaKQI6XnAKnijUm4q4pF2+Owr+ZfX0uRPu3ff0FGTQx3lPlBm/7hA+NXGwE+PYoPd+RfsY+GnyXvL7hSZZNK9NLdQw02QWnyhJ88agEKfviBsf6i7HMsa+i98NrrK7+tL6IYicxHvgH74pNWy+bE73B/ChkJvMePaG/4AIQkOohgg0DZEcUVCVPoxMU7shtbXli3Q8+gryqE/XI98LJzMt5eLP7Xs/QaiGX+Wp5yJpnJjv5o3L7dAHqCWNmh5uuTc3WfPeId1ixgvrFxdtbaDJFiFilafFGm6ZvPPK0SflBFJuiWRzH49FFWg9ELgNSWBo0nWRV1HZy5rb/zbhMIcGQ+52YXHenBbEeE7Y/550GVYyS0/XH5IKV/E19SaIi1HifcUxZhjbD+hZzB1kj2+Vo1BZ5l7SWxYFpRkzpwV9mSulLDwm3G4ip9o7QQng/OH8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(86362001)(38070700009)(122000001)(36756003)(6486002)(5660300002)(2906002)(6506007)(71200400001)(966005)(478600001)(66556008)(26005)(6512007)(2616005)(4326008)(316002)(8936002)(8676002)(66476007)(66946007)(54906003)(110136005)(91956017)(76116006)(66446008)(41300700001)(64756008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFAzREFVWG5VaHVBMTNCaExMMHVtdCtpWWlPWExSQXBIYjdlOElieXNyMkFV?=
 =?utf-8?B?Q28rR3BycTFCU29GRGxURy9wNHlPTkVLUzcwcjhoSFNWUXowQUUxeFoyM0Vm?=
 =?utf-8?B?S0Jqem15eFk1RjB6eUllVlVydjQ3NnN5OVo1VHhMb1lJMmdSblg3Q2NOMkV6?=
 =?utf-8?B?UzFjdG9KMGVtc2NvbXFZVDk2VE9NYXo3dVZNWUV4OUErdHp5cjBwSXFHcnB2?=
 =?utf-8?B?bmptUzhNMWd0TUpFaDNES1BlTmhKdGhjVDlEOU9aRnY4OCtmZkliU0dwdXBa?=
 =?utf-8?B?WGE3elY2VjlzYjAwdldHb0NqQ2daOVI3bFAxbzhDMEZzb2VlSmFnUmZ0Qkth?=
 =?utf-8?B?eXdyNEliQ0lUeXZGc0NiNWovdmlCeDZDaG1WQm1Cd0p3SUgzSmNHc3hYcHRJ?=
 =?utf-8?B?TENpUEQyNWhaNTFwY0dMcTVxdmViNjBuOGplV0Z3MWJDMmg2VDlNcmE5UUUy?=
 =?utf-8?B?RmhrL0dNK1ZYZzUzUjZWb2RmOVpqMDNuQ0hWaERFR3ZXSWgxSGNNaWJlQXVI?=
 =?utf-8?B?ZDhFcHc1Tjg1ZzVXQy9HN25yUnRGa2syWEpId1l6c2ZYcTNwK21HM1pudFdK?=
 =?utf-8?B?WDc1Um5VdVJzamczTnhra2krSy9GMGJoZ3JFN0llTTF5dlZjYkt0NHRpcjdT?=
 =?utf-8?B?TGJubTltL3VLdDJzRTNkbXoxeisvcGY1QzNva1U4OUJGRzFpTS9zbldUZUU1?=
 =?utf-8?B?SU1SWExHa3NxRk5FNzhRVmM5UjhLeGRvZlBBbk5RcXI4Z0xnaE0yaGp0MGZv?=
 =?utf-8?B?SXBvOCtId0I3bzdxNmwzYWFiczRyY1NxOVdXOXppZEpsZnRpUy9hSnIzODk3?=
 =?utf-8?B?VElNOVRHODBkbjhPUlRGOUowTVFpRmdoUklTQVdRVVQ4LzVNNklXTnpGUU5u?=
 =?utf-8?B?Qnh2VlFWeDg2ODZsYmcwMjNLcFdUTDJKK0pzWkZGMW1LeVZUNS9BUERoWHNj?=
 =?utf-8?B?eEh6RGlLdktOVDZqc1lWQlJUL3BDVkwyYmJpU3RtTHhBY21XK3hweW9PSlBY?=
 =?utf-8?B?ZUNQb2FXdWFqU3BXU0wvT1RzTnNwY2xSbGVscGQ5TndCK0ZYS2NsMFlGQi9C?=
 =?utf-8?B?SEh0Y0hqLzVqMU5NVHMrcVpQcjJtbURJY3kxeUdxMEVQeFhuU05zakQ3M1lp?=
 =?utf-8?B?bnBBUzBaWjkvNWY2NVkzSjhTZ1hBSlpHRjMwblkwUmNjTEVaeFkxa0p3K1N0?=
 =?utf-8?B?RlpXT1F1YXRlRThzMkU3L3pUa1A1dFJuWGNzZmF2WlNPM2t2dVhZalRHbTlQ?=
 =?utf-8?B?dEl6aU1XUGlPN0Z0TEpRWjlvaTl2WG9KM0pEZVh6RjZqeU1ndElTYUZVOHBl?=
 =?utf-8?B?WnVWQVNjTVRnR2piR1pkdytnWHNzU2o3b3ZYNCtXSmhvR0ZEMU9VWVVubVcv?=
 =?utf-8?B?R0lGTmo2b1NNNTBsdExQZVJkL3Mvc2paQ1JnNkJObG1tekY2cmRPK3dqaWhB?=
 =?utf-8?B?eWFFZll3MXVvVTkwWVpyZnFIcFY0RFE3STBWTnltV2ZXZTlVVEFMMGwwYXV3?=
 =?utf-8?B?cnYzblJlL3NvK2xqaFB2VjBsRFBEWjdwcFNYNWFoQ3NFR043dUJQQks1SlVo?=
 =?utf-8?B?SFJWa3U2bG1BeWExRDZLc0U3OHpzekdZdWVpTEtXTy9VSmV1SHQ0eWJLS3Jv?=
 =?utf-8?B?OGtKTXZoNzJQRVZEVng3ZktOb0UxQWphNEJlb0xMa1pZbjRGU1F4b0xqaEcy?=
 =?utf-8?B?SVhjWUM5enAyRm40a3JmcXZtdCtKY01EaTUyTlZ5Z0FWbUhWOUF4UWFHcjF3?=
 =?utf-8?B?M2pla3lqMFdRUkFwWTRsUy8wRStaZXN2bEhXOHVlQy9VV21GenRDMWVzTDVs?=
 =?utf-8?B?ckpoVWQ3MDlzeVBTQmgrQ2VNTnBiUHlyVi8yOWVKRXlhaURCNmRWaXlIbW41?=
 =?utf-8?B?WDgxeGVnSXB0R0JuUHlub1lzVnFrU29HZnFxcnNvVWg5bUJzYlBzdmtFM1RL?=
 =?utf-8?B?dHNmSWJVQ3E4VzNJMlpSTDNFNWxKQnBGMXR0c0dFSmE3bittcEFVemtRd29w?=
 =?utf-8?B?dzRrTzgvSzFyQTRRSWZJNGV0VUZqdmxPOGxSaHIxdGk3WTZaTWdqVmkrZkw1?=
 =?utf-8?B?UEVqaFpMeXJ4LzJQeFN2L3VCWHZFMmZaMDlnQWpSMjU4dG9uOXNJREJMWEM1?=
 =?utf-8?B?MG8zSWJObTUyMTdiUGo0WjZuWXdYMzYxZWo3VnFTTUtUWXVCKzEvUDRybWV4?=
 =?utf-8?Q?sURE63CKC49nnmHZVYsCjxE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B72C4783BE98FD498F91E67BF57506EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7688.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89bcfd7-614e-4be9-ba70-08dbe11219d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 10:53:26.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i3ha3x/9Cuy6dHV0LqRm7Z5Gi4hbuVUO0fFI88g/xXGWKE8uyrQ164Q+6RojYBUi2Hd3Ggzv9d9IsXUwf8JQqkrMbtILAOtBulzKDfLCcuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTAxIGF0IDEyOjUyICswNTMwLCBWaXNodmFtYmFyIFBhbnRoIFMgd3Jv
dGU6DQo+IE9uIFdlZCwgMjAyMy0xMC0wNCBhdCAxMzowOSAtMDcwMCwgSmFrdWIgS2ljaW5za2kg
d3JvdGU6DQo+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4gPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gPiAN
Cj4gPiBPbiBXZWQsIDQgT2N0IDIwMjMgMTM6MDI6MTcgLTA3MDAgRmxvcmlhbiBGYWluZWxsaSB3
cm90ZToNCj4gPiA+ID4gTm9ib2R5IGNvbXBsYWluZWQgZm9yIDUgeWVhcnMsIGFuZCBpdCdzIG5v
dCBhIHJlZ3Jlc3Npb24uDQo+ID4gPiA+IExldCdzIG5vdCB0cmVhdCB0aGlzIGFzIGEgZml4LCBw
bGVhc2UgcmVwb3N0IHdpdGhvdXQgdGhlIEZpeGVzDQo+ID4gPiA+IHRhZyBmb3INCj4gPiA+ID4g
bmV0LW5leHQuDQo+ID4gPiANCj4gPiA+IEFzIGEgZHJpdmVyIG1haW50YWluZXIsIHlvdSBtYXkg
d2FudCB0byBwcm92aWRlIHNvbWUgZ3VhcmFudGVlcw0KPiA+ID4gdG8NCj4gPiA+IHlvdXINCj4g
PiA+IGVuZCB1c2Vycy9jdXN0b21lcnMgdGhhdCBmcm9tIHN0YWJsZSB2ZXJzaW9uIFguWS5aIHRo
ZQ0KPiA+ID4gcGVyZm9ybWFuY2UNCj4gPiA+IGlzc3VlcyBoYXZlIGJlZW4gZml4ZWQuIFBlcmZv
cm1hbmNlIGltcHJvdmVtZW50cyBhcmUgZGVmaW5pdGl2ZWx5DQo+ID4gPiBib3JkZXINCj4gPiA+
IGxpbmUgaW4gdGVybXMgb2YgYmVpbmcgY29uc2lkZXJlZCBhcyBidWcgZml4ZXMgdGhvdWdoLg0K
PiA+IA0KPiA+IEkgdW5kZXJzdGFuZCB0aGF0LCBidXQgdG9vIG9mdGVuIHBlb3BsZSBqdXN0ICJm
ZWVsIGxpa2UgYSBkZXZpY2UNCj4gPiB3aGljaA0KPiA+IGFkdmVydGlzZXMgWCBNYnBzIC8gR2Jw
cyBzaG91bGQgcmVhY2ggbGluZSByYXRlIiB3aGlsZSBubyBlbmQgdXNlcg0KPiA+IGNhcmVzLg0K
PiA+IA0KPiA+IEx1Y2tpbHkgc3RhYmxlIHJ1bGVzIGFyZSBwcmV0dHkgY2xlYXIgYWJvdXQgdGhp
cyAoc2VhcmNoIGZvcg0KPiA+ICJwZXJmb3JtYW5jZSIpOg0KPiA+IGh0dHBzOi8vZG9jcy5rZXJu
ZWwub3JnL3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1sDQo+ID4gDQo+ID4gQXMgcG9z
dGVkIGl0IGRvZXNuJ3QgZnVsZmlsbCB0aGUgcmVxdWlyZW1lbnRzIA0KPiANCj4gVGhhbmtzIGZv
ciB5b3VyIGZlZWRiYWNrLiBJIGFwb2xvZ2l6ZSBmb3IgdGhlIGRlbGF5ZWQgcmVzcG9uc2UuDQo+
IMKgDQo+IFRoZSBkYXRhIHByZXNlbnRlZCBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gd2FzIGFp
bWVkIHRvIGNvbnZpbmNlIGENCj4gcmV2aWV3ZXIgd2l0aCB0aGUgdmlzaWJsZSBpbXBhY3Qgb2Yg
dGhlIHBlcmZvcm1hbmNlIGJvb3N0cyBpbiBib3RoDQo+IHg2NA0KPiBhbmQgQVJNIHBsYXRmb3Jt
cy4gSG93ZXZlciwgdGhlIG1haW4gbW90aXZhdGlvbiBiZWhpbmQgdGhlIHBhdGNoIHdhcw0KPiBu
b3QgbWVyZWx5IGEgImdvb2QtdG8taGF2ZSIgaW1wcm92ZW1lbnQgYnV0IGEgc29sdXRpb24gdG8g
dGhlDQo+IHRocm91Z2hwdXQgaXNzdWVzIHJlcG9ydGVkIGJ5IG11bHRpcGxlIGN1c3RvbWVycyBp
biBzZXZlcmFsDQo+IHBsYXRmb3Jtcy4NCj4gV2UgcmVjZWl2ZWQgbG90cyBvZiBjdXN0b21lciBy
ZXF1ZXN0cyB0aHJvdWdoIG91ciB0aWNrZXQgc2l0ZSBzeXN0ZW0NCj4gdXJnaW5nIHVzIHRvIGFk
ZHJlc3MgdGhlIHBlcmZvcm1hbmNlIGlzc3VlcyBvbiBtdWx0aXBsZSBrZXJuZWwNCj4gdmVyc2lv
bnMNCj4gaW5jbHVkaW5nIExUUy4gV2hpbGUgaXQncyBhY2tub3dsZWRnZWQgdGhhdCBzdGFibGUg
YnJhbmNoIHJ1bGVzDQo+IHR5cGljYWxseSBkbyBub3QgY29uc2lkZXIgcGVyZm9ybWFuY2UgZml4
ZXMgdGhhdCBhcmUgbm90IGRvY3VtZW50ZWQNCj4gaW4NCj4gcHVibGljIEJ1Z3ppbGxhLCB0aGlz
IHBlcmZvcm1hbmNlIGVuaGFuY2VtZW50IGlzIGVzc2VudGlhbCB0byBtYW55IG9mDQo+IG91ciBj
dXN0b21lcnMgYW5kIHRoZWlyIGVuZCB1c2VycyBhbmQgd2UgYmVsaWV2ZSBzaG91bGQgdGhlcmVm
b3JlIGJlDQo+IGNvbnNpZGVyZWQgZm9yIHN0YWJsZSBicmFuY2ggb24gdGhlIGJhc2lzIG9mIGl0
4oCZcyB2aXNpYmxlIHVzZXINCj4gaW1wYWN0Lg0KPiDCoA0KPiBGZXcgaXNzdWVzIHJlcG9ydGVk
IGJ5IG91ciBjdXN0b21lcnMgYXJlIG1lbnRpb25lZCBiZWxvdywgZXZlbiB0aG91Z2gNCj4gdGhl
c2UgaXNzdWVzIGhhdmUgZXhpc3RlZCBmb3IgYSBsb25nIHRpbWUsIHRoZSBkYXRhIHByZXNlbnRl
ZCBiZWxvdw0KPiBpcw0KPiBjb2xsZWN0ZWQgZnJvbSB0aGUgY3VzdG9tZXIgd2l0aGluIGxhc3Qg
MyBtb250aHMuIA0KPiANCj4gQ3VzdG9tZXItQSB1c2luZyBsYW43NDN4IHdpdGggSGlzaWxpY29u
LSBLaXJpbiA5OTAgcHJvY2Vzc29yIGluIDUuMTANCj4ga2VybmVsLCByZXBvcnRlZCBhIG1lcmUg
fjMwME1icHMgaW4gUnggVURQLiBUaGUgZml4IHNpZ25pZmljYW50bHkNCj4gaW1wcm92ZWQgdGhl
IHBlcmZvcm1hbmNlIHRvIH45MDBNYnBzIFJ4wqAgaW4gdGhlaXIgcGxhdGZvcm0uDQo+IA0KPiBD
dXN0b21lci1CIHVzaW5nIGxhbjc0M3ggd2l0aCB2NS4xMCBoYXMgYW4gaXNzdWUgd2l0aCBUeCBV
RFAgYmVpbmcNCj4gb25seQ0KPiAxNTdNYnBzIGluIHRoZWlyIHBsYXRmb3JtLiBJbmNsdWRpbmcg
dGhlIGZpeCBpbiB0aGUgcGF0Y2ggYm9vc3RzIHRoZQ0KPiBwZXJmb3JtYW5jZSB0byB+NjAwTWJw
cyBpbiBUeCBVRFAuDQo+IA0KPiBDdXN0b21lci1DIHVzaW5nIGxhbjc0M3ggd2l0aCBBREFTIFJl
ZiBEZXNpZ24gaW4gdjUuMTAgcmVwb3J0ZWQgVURQDQo+IFR4L1J4IHRvIGJlIDEyNi83MjMgTWJw
cyBhbmQgdGhlIGZpeCBpbXByb3ZlZCB0aGUgcGVyZm9ybWFuY2UgdG8NCj4gODI4Lzk1NiBNYnBz
Lg0KPiANCj4gQ3VzdG9tZXItRCB1c2luZyBsYW43NDN4IHdpdGggUWNvbSA2NDkwIHdpdGggdjUu
NCB3YW50ZWQgaW1wcm92ZW1lbnRzDQo+IGZvciB0aGVpciBwbGF0Zm9ybSBmcm9tIFVEUCBSeCAy
MDBNYnBzLiBUaGUgZml4IGFsb25nIHdpdGggZmV3IG90aGVyDQo+IGNoYW5nZXMgaGVscGVkIHVz
IHRvIGJyaW5nIFJ4IHBlcmYgdG8gODAwTWJwcyBpbiBjdXN0b21lcuKAmXMgcGxhdGZvcm0NCj4g
wqANCj4gVGhpcyBpcyBhIGtpbmQgcmVxdWVzdCBmb3IgY29uc2lkZXJpbmcgdGhlIGFjY2VwdGFu
Y2Ugb2YgdGhpcyBwYXRjaA0KPiBpbnRvIHRoZSBuZXQgYnJhbmNoLCBhcyBpdCBoYXMgYSBzaWdu
aWZpY2FudCBwb3NpdGl2ZSBpbXBhY3Qgb24gdXNlcnMNCj4gYW5kIGRvZXMgbm90IGhhdmUgYW55
IGFkdmVyc2UgZWZmZWN0cy4NCj4gwqANCj4gVGhhbmtzLA0KPiBWaXNodmFtYmFyIFBhbnRoIFMN
Cj4gwqANCj4gDQpJdCBoYXMgY29tZSB0byBteSBhdHRlbnRpb24gdGhhdCBzb21lIHBlb3BsZSBt
YXkgbm90IGhhdmUgcmVjZWl2ZWQgbXkNCndob2xlIHJlcGx5IGRhdGVkIE5vdiAxc3QgKGFzIHBl
cg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8y
MDIzMDkyNzExMTYyMy45OTY2LTEtdmlzaHZhbWJhcnBhbnRoLnNAbWljcm9jaGlwLmNvbS8jMjU1
Nzc4OTUNCiksIHBvc3NpYmx5IGR1ZSB0byBhIG5vbi1BU0NJSSBjaGFyYWN0ZXIgYXQgdGhlIGN1
dC1vZmYgcG9pbnQuDQpUaGVyZWZvcmUsIEkgYW0gcmVzZW5kaW5nIHRoZSBwYXJ0IHRoYXQgd2Fz
IGN1dCBzaG9ydCBiZWxvdy4NCiANCkpha3ViLCB3b3VsZCBpdCBiZSBwb3NzaWJsZSBmb3IgeW91
IHRvIGFwcGx5IHRoZSBwYXRjaCB0byB0aGUgbmV0DQpicmFuY2ggZ2l2ZW4gdGhlIGFkZGl0aW9u
YWwganVzdGlmaWNhdGlvbiBub3cgcG9zdGVkIGJlbG93Pw0KIA0KLS0tLS0NCiANClRoYW5rcyBm
b3IgeW91ciBmZWVkYmFjay4gSSBhcG9sb2dpemUgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLg0K
DQpUaGUgZGF0YSBwcmVzZW50ZWQgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIHdhcyBhaW1lZCB0
byBjb252aW5jZSBhDQpyZXZpZXdlciB3aXRoIHRoZSB2aXNpYmxlIGltcGFjdCBvZiB0aGUgcGVy
Zm9ybWFuY2UgYm9vc3RzIGluIGJvdGggeDY0DQphbmQgQVJNIHBsYXRmb3Jtcy4gSG93ZXZlciwg
dGhlIG1haW4gbW90aXZhdGlvbiBiZWhpbmQgdGhlIHBhdGNoIHdhcw0Kbm90IG1lcmVseSBhICJn
b29kLXRvLWhhdmUiIGltcHJvdmVtZW50IGJ1dCBhIHNvbHV0aW9uIHRvIHRoZQ0KdGhyb3VnaHB1
dCBpc3N1ZXMgcmVwb3J0ZWQgYnkgbXVsdGlwbGUgY3VzdG9tZXJzIGluIHNldmVyYWwgcGxhdGZv
cm1zLg0KV2UgcmVjZWl2ZWQgbG90cyBvZiBjdXN0b21lciByZXF1ZXN0cyB0aHJvdWdoIG91ciB0
aWNrZXQgc2l0ZSBzeXN0ZW0NCnVyZ2luZyB1cyB0byBhZGRyZXNzIHRoZSBwZXJmb3JtYW5jZSBp
c3N1ZXMgb24gbXVsdGlwbGUga2VybmVsIHZlcnNpb25zDQppbmNsdWRpbmcgTFRTLiBXaGlsZSBp
dCdzIGFja25vd2xlZGdlZCB0aGF0IHN0YWJsZSBicmFuY2ggcnVsZXMNCnR5cGljYWxseSBkbyBu
b3QgY29uc2lkZXIgcGVyZm9ybWFuY2UgZml4ZXMgdGhhdCBhcmUgbm90IGRvY3VtZW50ZWQgaW4N
CnB1YmxpYyBCdWd6aWxsYSwgdGhpcyBwZXJmb3JtYW5jZSBlbmhhbmNlbWVudCBpcyBlc3NlbnRp
YWwgdG8gbWFueSBvZg0Kb3VyIGN1c3RvbWVycyBhbmQgdGhlaXIgZW5kIHVzZXJzIGFuZCB3ZSBi
ZWxpZXZlIHNob3VsZCB0aGVyZWZvcmUgYmUNCmNvbnNpZGVyZWQgZm9yIHN0YWJsZSBicmFuY2gg
b24gdGhlIGJhc2lzIG9mIGl04oCZcyB2aXNpYmxlIHVzZXIgaW1wYWN0Lg0KRmV3IGlzc3VlcyBy
ZXBvcnRlZCBieSBvdXIgY3VzdG9tZXJzIGFyZSBtZW50aW9uZWQgYmVsb3csIGV2ZW4gdGhvdWdo
DQp0aGVzZSBpc3N1ZXMgaGF2ZSBleGlzdGVkIGZvciBhIGxvbmcgdGltZSwgdGhlIGRhdGEgcHJl
c2VudGVkIGJlbG93IGlzDQpjb2xsZWN0ZWQgZnJvbSB0aGUgY3VzdG9tZXIgd2l0aGluIGxhc3Qg
MyBtb250aHMuDQogDQpDdXN0b21lci1BIHVzaW5nIGxhbjc0M3ggd2l0aCBIaXNpbGljb24tIEtp
cmluIDk5MCBwcm9jZXNzb3IgaW4gNS4xMA0Ka2VybmVsLCByZXBvcnRlZCBhIG1lcmUgfjMwME1i
cHMgaW4gUnggVURQLiBUaGUgZml4IHNpZ25pZmljYW50bHkNCmltcHJvdmVkIHRoZSBwZXJmb3Jt
YW5jZSB0byB+OTAwTWJwcyBSeCAgaW4gdGhlaXIgcGxhdGZvcm0uDQogDQpDdXN0b21lci1CIHVz
aW5nIGxhbjc0M3ggd2l0aCB2NS4xMCBoYXMgYW4gaXNzdWUgd2l0aCBUeCBVRFAgYmVpbmcgb25s
eQ0KMTU3TWJwcyBpbiB0aGVpciBwbGF0Zm9ybS4gSW5jbHVkaW5nIHRoZSBmaXggaW4gdGhlIHBh
dGNoIGJvb3N0cyB0aGUNCnBlcmZvcm1hbmNlIHRvIH42MDBNYnBzIGluIFR4IFVEUC4NCiANCkN1
c3RvbWVyLUMgdXNpbmcgbGFuNzQzeCB3aXRoIEFEQVMgUmVmIERlc2lnbiBpbiB2NS4xMCByZXBv
cnRlZCBVRFANClR4L1J4IHRvIGJlIDEyNi83MjMgTWJwcyBhbmQgdGhlIGZpeCBpbXByb3ZlZCB0
aGUgcGVyZm9ybWFuY2UgdG8NCjgyOC85NTYgTWJwcy4NCiANCkN1c3RvbWVyLUQgdXNpbmcgbGFu
NzQzeCB3aXRoIFFjb20gNjQ5MCB3aXRoIHY1LjQgd2FudGVkIGltcHJvdmVtZW50cw0KZm9yIHRo
ZWlyIHBsYXRmb3JtIGZyb20gVURQIFJ4IDIwME1icHMuIFRoZSBmaXggYWxvbmcgd2l0aCBmZXcg
b3RoZXINCmNoYW5nZXMgaGVscGVkIHVzIHRvIGJyaW5nIFJ4IHBlcmYgdG8gODAwTWJwcyBpbiBj
dXN0b21lcuKAmXMgcGxhdGZvcm0NCg0KVGhpcyBpcyBhIGtpbmQgcmVxdWVzdCBmb3IgY29uc2lk
ZXJpbmcgdGhlIGFjY2VwdGFuY2Ugb2YgdGhpcyBwYXRjaA0KaW50byB0aGUgbmV0IGJyYW5jaCwg
YXMgaXQgaGFzIGEgc2lnbmlmaWNhbnQgcG9zaXRpdmUgaW1wYWN0IG9uIHVzZXJzDQphbmQgZG9l
cyBub3QgaGF2ZSBhbnkgYWR2ZXJzZSBlZmZlY3RzLg0KDQpUaGFua3MsDQpWaXNodmFtYmFyIFBh
bnRoIFMNCg==
