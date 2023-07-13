Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB3751A17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGMHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:42:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468D2102;
        Thu, 13 Jul 2023 00:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChzyfYXI0wq+swkyPGG/74Ngcy7T2l6dRefyc6WJGcu3FKkThQu6DyEzT1Ry8yRDCspzv8okzgmXTAaeOWVPs/va5VKpcKQVaiB8yQHWvC9Vq8OaNqEaZd621v0+zrcS2IoYgDg8q/ISBPoThtZzbuCSpTST1bgiGELxrCpMagwbks4XhcmsHZHAMH+gv/vXbDCG2PeqN0JHM/m42IPrNJEVPhxMiXvkl+hAwuciPQtbr10WVuJS6DENgrMzZ859vc5O7A12NeRG9OVhRn09caD5kL4kICxbsYLzMzqLjzFLUS4rl2FA/EW+kav8GrhdE8D9nLi7mybkSqAgNpi/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIre86xbUq3EWzcrf2B20MPrk9b1MwFQQ0W1GtgcZeE=;
 b=hc3EsGUua38AJnqoXMsZm+zubvfv5AoQCoCyEg858dQzAHJMeHn/wLn3Wmhfhx41GfFY0CcrLs9zllZIROxnTtmgz6OywNg1riXdubuHpPUzjCDPtzkTngHoMH96ByHA6nQoG7oXYXfqc6NUCVnIa9nrdTvAixtnT/alkgjWa2ef3ZW/TGWMTs0liTjlZRYSL90JLu/lCRGFHGmtKcffMw7MukBXE78yK/dLyvFrjoSORSMIyxkw+XBBv8LfkhBVPRLst4eku1A93ztp2VljkBxgQq5ymgeWruMchsremH/8T6KFEQhCGt27Bdx4ONpBkY/7HzLyhuwCdwlYTi9LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIre86xbUq3EWzcrf2B20MPrk9b1MwFQQ0W1GtgcZeE=;
 b=m/YnJS5u+AUQidX32WzOfKwXNPwnWMLGkSc5gkn0KEibe8ZddUI0tM6iMsVw2sUIG8JOGY54xjT81npIken2priIBAi44Vpz+GOKb0ydsGb597ILKY3mgiWLJGIpTb8+4gUDth/UlTFf+1Sf/CEFxxMoBRZUub5lLHO3Pz48NLNLT6vXbG1l8QmsacaToyByBgHW3sBjZFm1zXi4y3zK0HQ2ixvj6rIh6R/Bd5TjxLvhyAzzWkmHHquAaYodkIs0wLwQL+Z6xVfjV77GjZMqg7+cnS8Hv7NArJDa3xRwDhq5CoquZIYBEyPIeqHyS3LTNQ1gl0tPRS5UOEnxDn0y+Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS1PR10MB5190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:41:56 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:41:56 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "Haener, Michael" <michael.haener@siemens.com>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Topic: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Index: AQHZrkUWX/bXYZ1FgkKSbFgnrbI4rK+pMsOAgAEQEACAAg1RgIAK/ZiAgAAQt4A=
Date:   Thu, 13 Jul 2023 07:41:56 +0000
Message-ID: <d154d59edd2883b30de8f80fa9c08ec7700504d6.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
         <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
         <6594cbb5b83312b73127f6bf23bbf988bb40c491.camel@siemens.com>
         <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
In-Reply-To: <ZK+cvZJmYRkKKZ0d@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS1PR10MB5190:EE_
x-ms-office365-filtering-correlation-id: 8121a697-4f34-4fbd-6bdd-08db8374a26b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4U+3ARh9WVZpdEPixeNoVgXgDSeril02YSQjXHHHV9tJ/i43zRUlTBv4cvPqqekhQiaF0BzA43/NTpfQ94M/XjGqJAN6H7ItX95K3REGSvrKuU61g2BDcjt2Xgasib4AlVjgAhDQh17oa0zAc+mT2N3FsjoaLxHufLN+tLpuO5b6aQa6GTPHxEl3eWxtQPg0oe2bKY7SoxTK4MIN3k4j0SE9pE4/+dYhiLkGGAopKGPaOhXOasxdYdxbiyKFD2jMW021Wi2/4PNlixQxTeW+L8ZN0X25lTfIRjjLvvwx/Jn/0Js1JaaZJaspN2TxOnuz37VvpWrrpUJCEliWnNTxopScY6gfBgj9GGTy0H6ZEIXqskRTyL3ko+8lbaIdZk1gTN6emrS/1QHPWCIyxOCV0sUNa3hlLeDR7kttF8nUAE3uC+dPy9vks+wQVXJM9qJjU8yJPnDQDa/NO796BDdoGIO0be8CI/qF8lgvMDpV6etSJbfvqfrvdGrtFSwI3jYITzYoAbtGoGYWaxOC7CnxqTxGooVkQl++tw+DSfydWcy9BbbJ2/e1OdjCWRGfAot8l4Zm5JUKHYNLUmFWWDMD/m3SnFn5yWs5QJWY+sPU3ydr0KjhK57eGv92ATvzCiVMonjAVNJkugx/REQsTlNraaidNkbC0P4insO4ZfWhA0ji2WvoePKmkF7Wowyuj5x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(82960400001)(478600001)(26005)(6512007)(6506007)(6486002)(71200400001)(8676002)(8936002)(15974865002)(83380400001)(38070700005)(7416002)(5660300002)(316002)(2616005)(41300700001)(86362001)(2906002)(122000001)(186003)(38100700002)(36756003)(66556008)(64756008)(66446008)(66476007)(76116006)(66946007)(4326008)(6636002)(91956017)(110136005)(54906003)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHRBUVMzekVBNXJzc09TdzdjcHdCcTRzZGFycWNYM0JnOFZVVkdaZUkzQ0tn?=
 =?utf-8?B?WGFMdkhhOEJ5d0I5c1NwTTYxOTVoSEF6a0pRYmxvV0xFODY0bUU3bU9ZcHpa?=
 =?utf-8?B?TXdoV2p6U0ZmMkN0eVZoOUZPTTZENG54USs2R3hJRnlEamtReWRicldhS01Q?=
 =?utf-8?B?cEJISGRIZTZwaVhmUHpsRnF6V3ljRXU4WlNubjBhbTB0Q25PV1ZRMThtNXJH?=
 =?utf-8?B?ckQrcUNUN0ZMN25Vc0pFNFhUTFFkWlVlcW12SUg2SWFKb3RPdEhxZXIxbEV5?=
 =?utf-8?B?dnl6QnNyTnNYZ0hhSlFiL3g5bDZxQXBGRXNjSVFWR0xMdzRUY3RYK2NQek0v?=
 =?utf-8?B?ejBzY3BrV3FRQ21yWldCUnhoN1dxbHNDa2I2Z2hSNlB2T1NPQms2TVpZSVFB?=
 =?utf-8?B?R1VTdjdGUDJKUXlQV1RiVDFIamJ1a0Z2VUxBVkRmbWp3bU9JUVoxNXd4YjY3?=
 =?utf-8?B?TjB6MDZ1MktyNzdpcm5sa20rRjJKTk9GTHBjenIrU1NTaFlRQWV6bEtzbzdw?=
 =?utf-8?B?Ykd1TjVtRWY0WFlPYVU4OXZCTFN5cVRVejZtU1d4SWhlYWxLQWxwMGhLemVh?=
 =?utf-8?B?STJtWWpFWXhrWlhRTzRMMUh6Y2doWjFhaG9pOTU5amRuSmdXdlZYZ3ZyM1hX?=
 =?utf-8?B?d2xGdEoxbmFkMnJLeUxuT2JnaGg0eXBzRzJETERlY1g4Z3hrSzBzVkpFWElJ?=
 =?utf-8?B?NVRueHdpTHc5Y1NHVVYzWDJrMExKYUZCaGM2dFA5TUVJdmhCUGVScWVVNmZO?=
 =?utf-8?B?bjhHRDdhUFg5T0IrTEY1OVhrblpLNTlyT1BtVEVrT3dkckdhRDVwSXFYNi9N?=
 =?utf-8?B?bzJ5K2FKMGpEMloxM2lRRW1Fdmtjc1RrMGEwVC9YSEJJK3F4dVpVVW1kM25X?=
 =?utf-8?B?NHR5bzd0cnltYktCdFI4ZDdsR0JrNktUcTh3aUZMVU1hVHcrVDhROVBVL1lw?=
 =?utf-8?B?ODN2TkVnTUFQL00xRElJc3Q2QzhwV1p4Z2ZQSDdDTURjM3RJVnk5dkRvV0x2?=
 =?utf-8?B?a1RITEVnU1ZXS3NuSU50VmUwdFRad1N1RlhFTHp4UkRwVTZRcHBNWmxML1A3?=
 =?utf-8?B?UThZMXMyRlB2N3VRK2huMU5KMGhkTHZsREp5YWM2Y0trb3FHaEFDL1RvdDFI?=
 =?utf-8?B?REpTL1BvR1JjMFNBNWlkWSt6bTIrVjB6WWkzQkZnU0pxOHJGWWJBTUc0VHB6?=
 =?utf-8?B?VjdYY2lERWYwVnJjZmxsNGtJZHI0T2hFcWlBQVByOTd0M2dyY2QyL2tmMERG?=
 =?utf-8?B?RjBCMGJ2eWF5U1RDNVZGQk1RMHd2ZlVnS0RZVDJ6N0ZDWE5GU0l4VUdZTjQ2?=
 =?utf-8?B?QU1lMHBVZ0RMbGJZcDBZbmJQNnJ5MmVrQ0NDUGtiNVFCT25rUytOcWQzUU9k?=
 =?utf-8?B?OXM0T2lpdjA3SG4wVEF4Q2Y3ZWRJMkwvd3JZZjRhSEs4Ni9lM2tvekR5WWZs?=
 =?utf-8?B?UVpHVFpDR0F3R21qRUN4Wk1qQXhDK3dOYkk3ZnhVV3dDM0I1QXJHdDVFQ1JJ?=
 =?utf-8?B?K1FNM1dMWkt5SUZFc2gwWFpMSWNrYkFYTitJRzQwUlREckZWV0lxWnhWdzJt?=
 =?utf-8?B?cXI2TUpZK1hMTnh2Z0EvM3NOVTVTdld3eEdDcWVYKzZYVG9WdXcrYktUb21N?=
 =?utf-8?B?M1JyVHlpdUJYakNGa213K0VyamhwVUptNW9wMWMvcFBIZGljaEJxaGJTQXdV?=
 =?utf-8?B?WVNLWkdCWEcyNUNxeWU4QUZ2cFU4SzM1eitHelVHWE1wS2tYYnJkeGk4RkMy?=
 =?utf-8?B?M0g4K2F6c091WURYSXcvWlhydHQraGorendkNWZ1RVdianl1OW9pR0EzZGlp?=
 =?utf-8?B?ZkhNRk16L1FoVURWME1ucE1kVGw2RmIvQTZlUWJLYnVQZEVFQXBzaXNnOTht?=
 =?utf-8?B?dTVCckhoSWcxTEpQNDJXY0ltSmdWaUkzdGZ1NWFxNDhYd3pSc1J0VHZISHJ4?=
 =?utf-8?B?UGtUZUtUQ1gwc3pCUllIUWJnQ21uSGpFUWFZeUQ5aUJzU2Z6a3p4bFAxWGJG?=
 =?utf-8?B?RnVTTlFseWd5K2VxMEs2ZS9JaVpYMHZwMjVVYnA1T24vdjRXekNaZkhZSThQ?=
 =?utf-8?B?aTRPT3NZTlZaNGpHb0MvelZQKzl6UTNlZWVPMmlsUHJTa3o3clpJaUJ0OEQ2?=
 =?utf-8?B?MlJGcmRocU5mQjBudnV6WS8xZnVaUlFzZG5acmwvbDNFS0w1NlNRSnFad3Nl?=
 =?utf-8?Q?vQ2/ZAXr/LFTxDAtfl+9gvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CA90198B20104478E7399D43668EF92@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8121a697-4f34-4fbd-6bdd-08db8374a26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:41:56.7201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHMY2g9eRfNHKHVT+M6tc+1XAOdABsMFfYq9+DQTr41+g7zonkJjBhtQI+nK2XJxYPxmD7gpPkrTTEmTJfiaqAl4Da1hTz5GXLWYP/CG+Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KT24gVGh1LCAyMDIzLTA3LTEzIGF0IDA3OjQyICswMTAwLCBSdXNzZWxs
IEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+ID4gPiA+IENoYW5nZWxvZzoNCj4gPiA+ID4gdjI6IHJl
YmFzZWQgb250byBSdXNzZWxsIEtpbmdzIHNlcmllcyBkc2EvODhlNnh4eC9waHlsaW5rDQo+ID4g
PiANCj4gPiA+IFJ1c3NlbGwgS2luZyB3aWxsIGJlIGludGVyZXN0ZWQgaW4gYSBUZXN0ZWQtYnk6
IGZvciBoaXMgcGF0Y2hzZXQuDQo+ID4gPiBUaGF0IHdpbGwgYWxzbyBoZWxwIGdldCB0aGF0IHBh
dGNoc2V0IG1lcmdlZCBzbyB5b3VycyBjYW4gdGhlbg0KPiA+ID4gZm9sbG93LiBTbyBwbGVhc2Ug
a2VlcCBhbiBleWUgb24gdGhlIG5ldGRldiBsaXN0LCBhbmQgcmVwb3N0IHlvdXINCj4gPiA+IHBh
dGNoZXMgb25jZSBSdXNzZWxscyBoYXZlIGJlZW4gbWVyZ2VkLg0KPiA+ID4gDQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgQW5kcmV3DQo+ID4gDQo+ID4gT25jZSB0aGUgb3RoZXIgcGF0Y2ggaXMgbWVy
Z2VkLCBJIHdpbGwgcmViYXNlIHRoaXMgcGF0Y2ggYW5kIHJlc3VibWl0Lg0KPiANCj4gRnJvbSB5
b3VyIHJlc3BvbnNlLCBJIGNhbiBvbmx5IGFzc3VtZSB5b3UgaGF2ZSBub3QgdW5kZXJzdG9vZCBB
bmRyZXcncw0KPiBjb21tZW50Lg0KDQp3ZSBkaWQgdW5kZXJzdGFuZCBBbmRyZXcncyByZXF1ZXN0
IGluZGVlZCwgaG93ZXZlciB3ZSB3ZXJlIG5vdCBhYmxlIHRvDQpiYWNrcG9ydCB5b3VyIHNlcmll
cyBxdWlja2x5IHRvIHRoZSB2ZXJzaW9uIHdlIGFyZSBhYmxlIHRvIHRlc3Qgb24gdGhlDQpIVy4g
TWljaGFlbCdzIHBhdGNoIGlzIGxlc3MgaW52YXNpdmUgYW5kIHdlIHdlcmUgYWJsZSB0byBwb3J0
IGl0IGVhc2llci4NCg0KVGhhbmtzIGZvciB5b3VyIHVuZGVyc3RhbmRpbmchIA0KDQo+IEFuZHJl
dyBpcyBhc2tpbmcgeW91IHRvIF90ZXN0XyBteSBwYXRjaCBzZXQsIGFuZCBfdGhlbl8gZ2l2ZSBh
DQo+IFRlc3RlZC1ieS4gSXQncyB1c2VsZXNzIHRvIGRvIHRoYXQgYWZ0ZXIgbXkgcGF0Y2ggc2V0
IGhhcyBiZWVuIG1lcmdlZC4NCj4gVGhpcyB3aWxsIGdpdmUgbW9yZSBjb25maWRlbmNlIHRvIG15
IHBhdGNoIHNldCB3aGVuIEkgc3VibWl0IGl0LiBTaW5jZQ0KPiBJJ2xsIGJlIGRvaW5nIHNvIG1h
eWJlIGxhdGVyIHRvZGF5LCB5b3UnbGwgcHJvYmFibHkgaGF2ZSB0byByZXBseSB0bw0KPiB0aGUg
c2VyaWVzIG9uY2UgaXQncyBiZWVuIHBvc3RlZC4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
