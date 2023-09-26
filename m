Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C2F7AED4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjIZMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIZMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:54:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A6FC;
        Tue, 26 Sep 2023 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695732877; x=1727268877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KxA1lq2p43FteklaQ977Zd2XrWq4s+dL9iO7y6Kajqc=;
  b=PHMZazpflqZH+FrgKBQwQ3YiWzhPM89a1WScRP1AvEBm1NfK09teVq9H
   w/L9EvLLLo9ag7UC7qIp9OqMlzUa5LsYu0WYo2i9w+YFZJGJJGeh3WJmu
   xWSvL4a+d7260XPVbQLEsnw1BC+Gb+6lO1lPhqHU7XLylbATmiXJ1JoH5
   Y1qE/3EHAdojSwfd74/kcmrzCxevAI/qwGHe55Bz5QHUFmwxM0q+2g0w3
   vDzGtAYRYEdqCYuna7ph8vlRd2X3cCIKJt5DPWQ9Y5gnLVTCerF76OVQU
   PU4jQS/LjEuk47HPOZ08IVgLVKGdZnM2++QNtvYySEMp1xNhy8zWm5j9y
   Q==;
X-CSE-ConnectionGUID: Qie3AVURSEKfrtNNDcUVAA==
X-CSE-MsgGUID: nyNesxMoT8mxB7rnZeiwdQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="237226928"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 05:54:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 05:54:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 26 Sep 2023 05:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeMGPDmOrrJAI23zTUG1k8/j2lbpyFx9BspH8YPKBc2aXlnerW4Ybw05DKBE56KH72fkVZf+wqANNOrAG1NH6QqvJnspS6gU6wZyHvZTM2moxjf0w7aeWtDV2ukeH7eyVUwlZzREZUNQ5N3kFE2yaquKl5olrw7V874mQTJJR8STCUy4p1Tl2tQtdns/ZiAf3xLnMf8zDktCjP6mBgvNATFGxLHRFGQF95mmfjeNUUCwIOE39VjQF4GoFrV63JXgDLCXGMhGiQf1Ztc9uaWma1nMd3KnaNdavGJznr+LJtVFlCQKqNxQno3jW09cELeJTDX6s+BbBnGYvp9cDXqBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxA1lq2p43FteklaQ977Zd2XrWq4s+dL9iO7y6Kajqc=;
 b=CIr2pq7QyowET9nRuHHzlbCm9n8AK1SmieinslJ/6l8/gvI8zlB6TtIXDG4hAJrcKmo/BWLwtaakKqs0YcbGVRjL6aaKoYTyyctF0gVFtwIVxTEDxLgpbZlb+agkFhP6q7r1Jvhb8sw/MWNACdcAd2g36J+3tphFV2B9rikgIc2T0cfmvb3Jo1J9kfTrm7EthEgMKPzRq3qQEzIrqxNtYrAyt0XzWw/FRO97YxVClBVThtWdJSRbkWq7sWruK8S85GsaTlVTxfDym4QPqt3aoLLomS64kmfB0r7ahT2TEz+AyVcXTHQ7EdmDhP0tk2GTHEvVavuelDUwoTPZwcQesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxA1lq2p43FteklaQ977Zd2XrWq4s+dL9iO7y6Kajqc=;
 b=eTtv2l8b4uTt6PFrXP/5+2KVitaiwlvvxysFrS2iP+mvdQHHvP433De1eMCtEX9zVDRKOLM0Wc6rKwOQATkjL9bm5A51BJ0HNQMQ7SE6C9Guqglzk0aply2G7yGu+55/imAKvYtpr6+asa9Jkp3EhqLU6az6/kZNxWn9ayc9oiM=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Tue, 26 Sep 2023 12:54:32 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 12:54:32 +0000
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
Subject: Fwd: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYC/aAgAoD1gCAAB1qgIADHmQAgABwugCAAJxdgIAG07wA
Date:   Tue, 26 Sep 2023 12:54:32 +0000
Message-ID: <cf4d7ed9-21cc-08d8-28e5-ea0917446b33@microchip.com>
References: <f10db291-dee8-e4b7-2f97-a3237122a2ad@microchip.com>
In-Reply-To: <f10db291-dee8-e4b7-2f97-a3237122a2ad@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH8PR11MB6830:EE_
x-ms-office365-filtering-correlation-id: fd256d7b-a824-4186-cb12-08dbbe8fba9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKM3VRKJAMCcct8Q4UCKm+Kh2+MoHPZFfQYfW/UwOGDp0WKWYqwBupdvoXI5HG5lxO6wjKU3+vU2S5/PBE1VElbKTu5S2QGNaii0OhjiOdNqgIV/Q4FeJ6OSz+vklcZbfonfKHHYnD9mGM1fkElhcbs0H3DENuQp51vYqVHzZKQmqdTebREelYPUrqygrkXqBnL/yH9jZa3PJvQ4IywV8m6M/l6R5u5dLuL9s9LP5f2oamoXIWp95JhH/0706MN+xNw+noeKbIfSYvlb87iHSozn3TBR6Xa8cbfZzmz4deehcmivJTMqm3+L3M9QbCPfHtaVNd5uBOM4zlE4zkWIAnstrZ01zi2NBg0ql9vUEXZUHAobgCKAJpwZ+18BMJT3d5Lx9G9LdIEef3TkpBjSaAJzWKOEFkEvBWN2zLVkeZIqqy2XlYP6QgYBGkDcnToldxjs8w5ZiPZavTOLd0MJL39Yo/HwA66pWVdnRu8/Pj27rrVH95KJRyHsT00YHLBYyqtdMKhCh7oJWzd460e+LryI3cmdtM5GwX541GyvBqSBFDQyLSMMHDGuSE7qsQyUp+ILzJpllwxHYBS6dL4j02rBRYBJ32Syd2ig/sGni4XzcQJX0Qq01Qcw29cIq3kaMxqVYUJCivE//yNDxM4KwnAhBh9LDYdRAkBEkltbQZmpQgxlI3e6rNPaxp2mrpNO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(478600001)(2906002)(66556008)(316002)(5660300002)(7416002)(26005)(66946007)(91956017)(6916009)(31686004)(66476007)(66446008)(64756008)(54906003)(41300700001)(8936002)(4326008)(8676002)(76116006)(71200400001)(6486002)(31696002)(6512007)(53546011)(6506007)(36756003)(107886003)(2616005)(83380400001)(86362001)(122000001)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE1jdndnYUl4TWZXcWZtR2YzcWxGR2hVTzcrNS96T2RCUW4zWitmZUN1SlUv?=
 =?utf-8?B?c1ZuellIbmpuUVVsbjdSMVRNc1lIQkliKzlZQ21EQmFRS1hTNzRoZSs4dDRv?=
 =?utf-8?B?VWlhWHordzdrZzRWMTdPTEJLK0dUYlRrS0t3RWpUOHJJcGtzYmJRbFI1b3hD?=
 =?utf-8?B?eTFUNFk1emZtNG9XeWtFMTNyeVpVS3ZZN3B0d0Nzb1paRTJ1SytjcmlydzFO?=
 =?utf-8?B?VFRGeDNYTDF2STFjSDN0dEd3WTB6MGZUTkI2NTQ2bEJZTjdvZGZRSTQ3UWdn?=
 =?utf-8?B?K04xd0hwZ0w5NlhpMlQrK3hmN2xtZ2ZQa01CSFd1NW5OR2ZiR0wyY1dpZ1c0?=
 =?utf-8?B?QzAwNWhhUS9RUU5sUUR0eUJnTGNZRTFzTFRNNE92VVpyNWltMlRxekRFSEFq?=
 =?utf-8?B?cTVPRGRiMDdKZ2JRZFYyR0lFRUovQm1LdktLek1BNFFhV1FVYTN4Nmk2RUZa?=
 =?utf-8?B?endYRTZnS3ZSZ1NHblhRRFMrMWhHQSt0VU00dy9tanNZVjBQMzFNUTY0VVZV?=
 =?utf-8?B?OUkvUlV0Y2JHWVpXM1VxNTdGQzlPb2JZSkRpbEFZay93WlNqT25NdnFUK2dX?=
 =?utf-8?B?V3NFb2dnbHZHcU91N2p4enZ4N0dXVEVkYXBqNEYzaFREM0VrNXZOUVBlSGVJ?=
 =?utf-8?B?dWZubmd0OXBvNkZUbjYzSm1TWTYrcDdSM3F0LzZNWkxVVUYzYzk1TkE2YWg1?=
 =?utf-8?B?bHNhaTRtbHNlcnROR2hqR0kyWGwwOHRhQkZ1dzFsVWU5cjBaOUVyYWhjUkxl?=
 =?utf-8?B?eENyVXRLT01JSnBPcWxaT3BCYzIwRWsvVkpNQlczTUJWYW9nbXdxYmFLbjlU?=
 =?utf-8?B?QjZkNVFaK3hLdzRjTlBpaW00UEt2Z1BNMEt1d29LdzV5N3RkdUZiYVUxa3oy?=
 =?utf-8?B?NkVyem5OOGpyN2NhcWlyWUprREUxVUZqNU4zRlNSTTYrNE5uNG8raVhPbytq?=
 =?utf-8?B?ZHF6eG12NTgvRS96UjI4eGNCZG9WclNleXZ2amNTeUc3U0JqaE1hazJ0Q3Iw?=
 =?utf-8?B?S0VwSFVmMGZMT3Y5ZmFJMzVWTUtPdVMxQ0lsbDYzenRsMGlLeTRCaSt4UjBx?=
 =?utf-8?B?ZjIyUW5zSjQyM1UwMlltbjFaNjBpZjcxMmVMTkoyMXFyT1hUdnp1TzJKZ3Iv?=
 =?utf-8?B?cTIwM29kK2I4eU5lK0ZnZUtUR2dlSU9RUnUrVEV5cnphd2V1aXRMR3BHZW54?=
 =?utf-8?B?RjJqcEJvT3pkVHZmSlZGaG5VSkJIMmFrOEUyb2c2SFljWDFTdlhKSTFZdVV5?=
 =?utf-8?B?WkxsZ0FlNTZKSDRpajJwNWxTbTNXUWtVQzFvSXQ5cjFaM3FSaUtleHZ3ZWpp?=
 =?utf-8?B?b1MwNDdlaDlNaU5panpYV0dSRkRQVkh4TGdJQmVMWWVXdXRZZERlN0gzcUFU?=
 =?utf-8?B?eDdrWG9EN1pGNk52ejAxdFBUN2QvdlR2N3I1dHZRaTBqL0p3S3lFMFZJV1Jm?=
 =?utf-8?B?WGlmSXRpTXl1b2JvL1lYRDRlUXdZQU9MblYzMnpGd2ltWWNtZ01yanE0RFBy?=
 =?utf-8?B?UERGTFNZdUdmQkMzUDkxb3p3N1E4cFdWaVh1TUxvVWJ5dk9kUW9icTJFWXlm?=
 =?utf-8?B?N0ZadUNMYmVZT25sQ1FlZ0E4aDIyT1h1TzJhcVhRVFBHZnFvazdsK0tTc3RJ?=
 =?utf-8?B?ZHpqRFhpZkxhYWJBQlQ0SURoOUhQcFQrR0lPRXlOZUpmY2RtNmc1K2FZSzVh?=
 =?utf-8?B?dCs2Z3JTZFpBTm9KNjJUNDcxT1NOTHVTVCtxSGozd2dSbU9OSHZzbjZuWVVt?=
 =?utf-8?B?MlhzV2lMOWtvRHQ2b1o4eHQrM0QzMDdVQWFVb0lGUGt2c29CRFowUVQ5eXEy?=
 =?utf-8?B?TUFNLzZORGFJeGpxMUF5VlJrOVM0M2Riak02SWNmUW9HaTg4VjRPV3E1NXVI?=
 =?utf-8?B?bUVqSzBpWGVzV1ZuVDlQTWZvTDZCL2FONFBWalRUOHdRYkpqOE5qQms2QVQx?=
 =?utf-8?B?WENBUFpDNC8wb2dCVVVmeE1SWTBRZGpwWCtLeTJxREhwYW43SGdJdzg0Qmd3?=
 =?utf-8?B?VHpsR0dhYWMzTVR0RnYvWGpqL05PMjhiSnlBYS9FN3pLRTAvODRHWWZqbHV6?=
 =?utf-8?B?V2F4WWw2Q0pjYVJpclRiSkMwNmdyRGhUOGNhenpuWlJLL1Q1Sk5Ua1JkS0FW?=
 =?utf-8?B?eXdOUmhjUE5GS3hJVDhoYVI0Y0pzRFp1WVVEOHRZSEtqY2pZL0FZTkpxWnFh?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C33A45EAD1DC974685B076F394D3E9BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd256d7b-a824-4186-cb12-08dbbe8fba9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 12:54:32.3264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TwzJIhoKWzGnAvjQ6vQ1ybjplAz1upEwgAEfa3OetWGNEivd6Im3XK6X/5buA+mHhWpxD9asJPsXQ7Z0YgFl1MrFbWgeO+wihqgiw/N9zKpIp+T2O7/j0A8kVS4557K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpBcyBJIGRpZG4ndCByZWNlaXZlIGFueSBtb3JlIGNvbW1lbnRzIGZvciBw
YXN0IGNvdXBsZSBkYXlzLCBzaGFsbCBJIA0Kc3RhcnQgcHJlcGFyaW5nIHYyIHBhdGNoIHNlcmll
cyB3aXRoIGNvbW1lbnRzIGFscmVhZHkgZ2l2ZW4/DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJh
biBWDQoNCi0tLS0tLS0tIEZvcndhcmRlZCBNZXNzYWdlIC0tLS0tLS0tDQpTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCBuZXQtbmV4dCAxLzZdIG5ldDogZXRoZXJuZXQ6IGltcGxlbWVudCBPUEVOIA0K
QWxsaWFuY2UgY29udHJvbCB0cmFuc2FjdGlvbiBpbnRlcmZhY2UNCkRhdGU6IEZyaSwgMjIgU2Vw
IDIwMjMgMTA6MDk6MDkgKzA1MzANCkZyb206IFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8UGFydGhp
YmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQpUbzogQW5kcmV3IEx1bm4gPGFuZHJld0Bs
dW5uLmNoPg0KQ0M6IGRhdmVtQGRhdmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1
YmFAa2VybmVsLm9yZywgDQpwYWJlbmlAcmVkaGF0LmNvbSwgcm9iaCtkdEBrZXJuZWwub3JnLCAN
CmtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywg
Y29yYmV0QGx3bi5uZXQsIA0KU3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbSwgcmR1bmxhcEBp
bmZyYWRlYWQub3JnLCBob3Jtc0BrZXJuZWwub3JnLCANCmNhc3Blci5jYXNhbkBnbWFpbC5jb20s
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcsIA0KZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIA0KbGludXgtZG9jQHZnZXIua2VybmVsLm9yZywg
SG9yYXRpdS5WdWx0dXJAbWljcm9jaGlwLmNvbSwgDQpXb29qdW5nLkh1aEBtaWNyb2NoaXAuY29t
LCBOaWNvbGFzLkZlcnJlQG1pY3JvY2hpcC5jb20sIA0KVU5HTGludXhEcml2ZXJAbWljcm9jaGlw
LmNvbSwgVGhvcnN0ZW4uS3VtbWVybWVockBtaWNyb2NoaXAuY29tDQoNCkhpIEFuZHJldywNCg0K
T24gMjIvMDkvMjMgMTI6NDkgYW0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiBZZXMsIGFzICJzdHJ1Y3Qgb2FfdGM2IiBhbmQg
aXRzIG1lbWJlcnMgYXJlIG5vdCBvciBnb2luZyB0byBiZSBhY2Nlc3NlZA0KPj4gaW4gdGhlIE1B
QyBkcml2ZXIsIEkgd2lsbCBjb25zaWRlciB0aGlzIGFzIGFuIG9wYXF1ZSBzdHJ1Y3R1cmUgYW5k
DQo+PiBkZWNsYXJlIGl0IGFzIHZvaWQgKm9wYXF1ZV9vYV90YzYgaW4gdGhlIE1BQyBkcml2ZXIg
cHJpdmF0ZSBzdHJ1Y3R1cmUNCj4+ICJzdHJ1Y3QgbGFuODY1eF9wcml2IiBhbmQgd2lsbCBwYXNz
IHRvIHRoZSBBUElzIGV4cG9ydGVkIGZyb20gb2FfdGM2LmMgbGliLg0KPj4NCj4+IElzIG15IHVu
ZGVyc3RhbmRpbmcgY29ycmVjdD8NCj4gDQo+IFllcy4NCj4gDQo+IElmIHRoZSBzdHJ1Y3R1cmUg
aXMgZ29pbmcgdG8gYmUgdHJ1bHkgb3BhcXVlLCBpIHN1Z2dlc3QgaGF2aW5nIGl0IGluDQo+IHRo
ZSBDIGZpbGUsIG5vdCB0aGUgSCBmaWxlLg0KDQpZZXMgZm9yIHN1cmUsIEkgd2lsbCBtb3ZlIGl0
IHRvIG9hX3RjNi5jIGZpbGUuDQoNCkFuZHJldywgdGhhbmtzIGEgbG90IGZvciBhbGwgeW91ciBj
b21tZW50cy4gVGhleSBhcmUgYWxsIHJlYWxseSBoZWxwaW5nIA0KbWUgdG8ga25vdy9sZWFybiBt
YW55IHRoaW5ncyB0byBpbXByb3ZlIG15IHBhdGNoZXMgYW5kIGNvZGluZyBzdHlsZS4gDQpQbGVh
c2Uga2VlcCBzdXBwb3J0aW5nLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4g
ICAgICAgICAgQW5kcmV3DQoNCg==
