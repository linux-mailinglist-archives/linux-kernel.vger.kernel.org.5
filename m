Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB86975767B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGRIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGRIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:24:50 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682DC10E;
        Tue, 18 Jul 2023 01:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsBxKIf3zv0OvA79CB8pW+dYMD0RcImaDlXzu7RasE3cbcOISa3SBX0bJWjOBQAKoqwi4mmzlIO92uujxFxoYlTfvQYBCtf06XTy3OMFdtqAZOQ1b3OKTcFZ9gpQRdJ4xOw/aQzicbIUMu7E6rvAk+luJ5MeWGBP4kBfqCC1Z9jso0nerO/q67KGRmNRtksTHNeZrPWO80Aq9MDGPdMPnMnknTYn7PHep1U52uW7fttT5IDAhw6pS5M8sQOD5pWXvLxyGnMguFf3nStxdOgu1kG0/W7RJB7CaRG8LeT9kC4ZongyGEmD+9kuUv5sF7rhemSrfUCF8DsfHXq+0qTNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PAjkX/sKV+C3S1m48Fs3508OeIQ9jUxQjSfaAziE0c=;
 b=I8Si+ze0YVOBNftAs/5h3UC33hfTDqQt0Ddgnmjj7ZNb09tXYFI/nMOxQk/IDIx/QSCPElvG7lggfQNcZH7eTBE4B8AezmO2sHQPDocF2Zt4BaEGpbwR0cfrOHfyHVdL6mHBFhZyi4p0MjAboi9CgkJFIIRKtDEvBfYkRDwGnjkS4NGurDx0tMzsQ34JH2PbbeLNgt9tFgxMJO03l+bh5MtNpoTr6SQAoTtSYYXOhzvYxUbSIg8oOmXQVJXWN47/VkkJZHseSBBpddtJtnySgG5Airb8h/MbPU9LmLs31D/j5Spd7npfncOBNFpUmc5n5Ofq88M5q+mQHYftujafeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PAjkX/sKV+C3S1m48Fs3508OeIQ9jUxQjSfaAziE0c=;
 b=HMqyVTqSRS3MmxVsM4nsz1dh21Kx80/XFJk3R9luBvkikCFIx6VethjHS7ugit04ndWBkHXHD2KiNRBVZeo8lLm+lIL+HphAcJFdndJK+nQUf5xR+9DJOYtl5zaY6/vzFMWCgiuJc70CTHV7PyKCuz8W26QCndwn4sbmdRDQOk5HTRusAe6Hb1rDMRw6HKQcurLl9mqGh+JY01RBbFOX9jVU6pJI9LveD8N5h7A9qPbYefL70xs8JMdMtOHlJNNjBAi/WdUxJgU18Rozo6bnF7q+NI3fZ+1PDjpUWL5Q1teAFLxAbQavci8iqiRlAH8a2BLzfwNrkSQv//bqjaPaEQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB7576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:547::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 08:24:47 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 08:24:47 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "Haener, Michael" <michael.haener@siemens.com>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Topic: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Index: AQHZuUWCmDeNL1+DZkuXTQMtQaAi8K+/JaGAgAAAT4CAAAojAA==
Date:   Tue, 18 Jul 2023 08:24:47 +0000
Message-ID: <bd7215b802b114b75de4568cc1642f791b233338.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-4-michael.haener@siemens.com>
         <ZLZDi22lqZfHKFUZ@shell.armlinux.org.uk>
         <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
In-Reply-To: <ZLZDzXQN3MKfOSwk@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB7576:EE_
x-ms-office365-filtering-correlation-id: 35198f0a-7338-45fb-c0f8-08db8768729e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vtmSWgzdjsSFTEwTcCg5+krOkpp9GqZFx4XDSFq18/Dk3qdW/RpVq+Ms9LHmLxXOOhWDvRH2pmgoX2zFC/uKSgY+vAWqdIwHc+YrkLndsrFj92JBgxngokdyRefnpxuSXakQtpexpeik50dVdIhlRkyjRTKakwxwLRK6Ou0FfXUnBZzlobtN/wGO/VGOPQfQRzi0Qk0+sGLGkT93lggTj8e20eGamktMpvM4CiBvbiNaEi+VXfLSpv0k2IdsrQDG1JfiiRBOGK82LjRccosEixYtLSCbfJ4qnkZPXkbA/gLj0l/wUTkS8x1UoSpOA/6nfVJTNwa2lj7gv663BnpvCKm8yU4qjpTpy7ZdNahAMh9SfWgUW4yz81AiDpy/eVvEkYNz8gJqTRpo8PYq0SZLufEPzyB5ctZWycBw6dXnq/jdmd2u+xURSu5g9eA1rylGqO5KCx7c8NjAdDfixVK3hwzKsUZAMP7JIbqMmMeQO5y9f4Px0Ut3rRUjtFWlNheJk1irnFiNOYa32nZGzhlXG3U+gBXlpGQ5/jo86CTTleEyVjyVPpDysZWdKHtYBSrb4D+R7RQwoexVnJAnzLvmN3Xgu74cZd2srszy5UC82Sm7vjo87rR193aCYZ9ijYf1SorppGS2G0z0UrxPexn7ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(7416002)(8676002)(41300700001)(66476007)(66946007)(66446008)(2906002)(66556008)(8936002)(6512007)(6486002)(54906003)(64756008)(76116006)(86362001)(122000001)(91956017)(6636002)(4326008)(316002)(2616005)(36756003)(5660300002)(38100700002)(83380400001)(6506007)(186003)(26005)(82960400001)(71200400001)(38070700005)(55236004)(15974865002)(110136005)(478600001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEQ5VXpSOC94TGhNSVVwYTVjRnloV3JHczFWQ3pZSlllbnRPT2x1S1g4ZWNv?=
 =?utf-8?B?VGc1SGdjYUNqZjMrL0djUU9ici9lRGY4QnIvcFZhRG8yL1l0UjZOMlFZV2lI?=
 =?utf-8?B?MlNhcG5ZeENPYlZvdW00TU45ZFJESjV5MVlRblFqUkR1Yys3YUdmK3Q3bzlR?=
 =?utf-8?B?ZjM1dEtYUEdhNE5qMjE2RDNNMkw0UnI4d0xRTGxvd3M2MEtJZTVIcmFFdFI5?=
 =?utf-8?B?cTdGbkFNbDl4OFJtcnBtYTY3dEhVa3JCem1TK3o4emdHdjZOYW1WcWorVStM?=
 =?utf-8?B?WlpnOVhzdDRuSFlsSmM4MXNuS0N3UTZhcEtmRWVTdmVyU1djQkFDbnZMQWF1?=
 =?utf-8?B?QXI3dStYOUlOUDdtaXIxdDFMNDdJU0JMYk9tLzhLaFA2RDlxaXRxY2dBVzFP?=
 =?utf-8?B?SzBMUFM4MTA3dUZDTmVhdndlUzlXUmdrbHdjeENWcjFPendxSXZCU2wvM1Nx?=
 =?utf-8?B?VDZReW8ydzNJa1ZPa1ZZUHIzUGVCQzJTSjZ1MnUrbWIxWW5XSmhHNnBUOHNj?=
 =?utf-8?B?RnVCcVl0cDdVN3UydTlSYitncEpWOUVSdDVVMVMrYVRMT094czdMdmd1NGlF?=
 =?utf-8?B?d2RleW83L0wrL2JOZmVoMDJPd293N3dSUGRyWVBaRDVXS3dqek9TK3lNcEwr?=
 =?utf-8?B?Zk9mU0dRVW84SnpPLythblo2d3JiTVUwZ0xhSTIwTDBLUUdiNU4yMDl1UVhS?=
 =?utf-8?B?UlI2aWRFenE0VkdPMG1oNE1iSnJqQ3Iya0o4ZjFYc2l0Z2V1ZUFBMmUrOUda?=
 =?utf-8?B?SzdoRFBKOUg1WW9YL0ptMTVlUFV5T2NvWWRiVkxiSnM0eVk2N0ZjMHhrRTFk?=
 =?utf-8?B?cG1HSWlFNEg1ZS80czBRNVYzTUxWdHNESm5PYU9ISEh5ZFZUS0s0cHYxTUc4?=
 =?utf-8?B?Tm9sa2dvY2F5RkVBclBzenpVVW1Ua0lmZ1BJaGRqM0ZkQzVnS0gzWmZFL2Zr?=
 =?utf-8?B?WVJiK2FKcU5INFd5Z2c2WGd1Mk9zd0FycVlLZzFUVVBmNm0zZkFlcXVzQTVk?=
 =?utf-8?B?bzBBKzJEdnlCOHlreDJna0VjS3ZFVmRzOHRwRk9QYk0waW1BZ2kyMEJrendy?=
 =?utf-8?B?NitVSFZzc3U3a3RkclZJOEZ2ODZLL1c3UXVQVC94KzdydE54WVRWUWkvUHgx?=
 =?utf-8?B?NzVkdWE1b1EwMDFta1FJY2trN3Z2UkFYMnYyZVVDMjNTaWcySytjOXliVUtk?=
 =?utf-8?B?dC9WMUs2bzdyU0lvOFRiZVVxMU9XSlZCMm9pY3k5N1c2aXpqWjdxTFhIMXNq?=
 =?utf-8?B?ZWFoWjlYWWgrUlZEdFNma0R0eHlHVGVOSElhcGRYNWlRVkt3QkFJc1VtNVZr?=
 =?utf-8?B?SHRtYWdoMUhDdjhzRDcyMStVdnZPeWI4WktGUGYwdTJsNlhENTNaMjhxTlpy?=
 =?utf-8?B?MnQwK2JERnJ1ckpnUHE0dWVYWElzczVHS3VqSjJkOTFxYkZ0WDlieHl4UjZq?=
 =?utf-8?B?QnBCNnMrSEJlSFh0cGI3dHZUV00wMDNBamF0WHQwc2dJV3VwbFZkVW94WjdK?=
 =?utf-8?B?bVFNSDQ1eTNWY1REZUorbDFwTldPUVFUVVZJL3VRcTdRTGQ0ZG9BYlpBWXhy?=
 =?utf-8?B?K0R5ZEF6UHh6WjRWZDMzM1k5cmpaUmoza0l5VVMvNU9UaXZ1Z3J3RjF3bGRp?=
 =?utf-8?B?UnV6b2h0QlBHbmtTZHNFajF3c1FxZkV3MWl3S3pJNGhxdXAvSm9BdDdMblJy?=
 =?utf-8?B?WFBkL0ZoczMrUW90MUlhUVZhSzUxSXhVV3BFMHdVS0d3bCthdUw1d0xiTVdx?=
 =?utf-8?B?akY4VFB3TUNpK0ZmdU1GTnRSb3BWSnpiSkRuKzV1Zmhlb1hVTTJ1VlFxUWJh?=
 =?utf-8?B?bXorcTBWQXc2bzBibGx1S2NqWjk1emw1cmp3SzRKeWw0cStFTzJocWtibGR4?=
 =?utf-8?B?aU00MUJVd2hMOVgvUmFnQk5PWFB3cDl2bDN3V0VtQjhKSks1Z1k4T0E5dmty?=
 =?utf-8?B?Q29IY0sweHJlN2NvM3BqREJpcG9laXdXVXhHMjNFSWdEWjRZQ2MrMFVDelBj?=
 =?utf-8?B?RjluMmdQeU5wL0N3eG9HSkpxUEZXSUNnN0NsTGd2UDR1WVpkVXFxUVZtSEJx?=
 =?utf-8?B?cjE3OU1PZ3lkVS9SSVpYazhqN3loeGJ6dXdyQlhCbmt1U01tcXhvaHlpeE1J?=
 =?utf-8?B?V0hlVUdJOUZZbUxOcXh3cGJhaGtkUktFWGttMnl1dGdnTTFUcFYyS3FIWFlR?=
 =?utf-8?Q?Ov9hyB1RFon8biXAJ3hPaY4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04ECA9219716BD459CEBA2AD69AEC059@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35198f0a-7338-45fb-c0f8-08db8768729e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 08:24:47.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFyyFRSsv3mAHs36hgMVZJwzHcOPRFMsHKKfWss/MVL/suKtuWGq7Cejn/fHnfsYaGFVEo/yFGs+Wfro2Kn1CMVBYM4VR89/0i9ya7KiaDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7576
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUnVzc2VsbCwNCg0KT24gVHVlLCAyMDIzLTA3LTE4IGF0IDA4OjQ4ICswMTAwLCBSdXNz
ZWxsIEtpbmcgKE9yYWNsZSkgd3JvdGU6DQo+IE9uIFR1ZSwgSnVsIDE4LCAyMDIzIGF0IDA4OjQ3
OjIzQU0gKzAxMDAsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4gPiBPbiBUdWUsIEp1
bCAxOCwgMjAyMyBhdCAwODo1OTozMUFNICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+ID4gPiBG
cm9tOiBNaWNoYWVsIEhhZW5lciA8bWljaGFlbC5oYWVuZXJAc2llbWVucy5jb20+DQo+ID4gPiAN
Cj4gPiA+IFRoZSA4OGU2MzJ4IGZhbWlseSBoYXMgc2V2ZXJhbCBTRVJERVMgMTAwLzEwMDAgYmxv
Y2tzLiBCeSBhZGRpbmcgdGhlc2UNCj4gPiA+IG9wZXJhdGlvbnMsIHRoZXNlIGZ1bmN0aW9uYWxp
dGllcyBjYW4gYmUgdXNlZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBI
YWVuZXIgPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFu
Z2Vsb2c6DQo+ID4gPiB2MzogcmViYXNlZCBvbnRvIG1haW4gYnJhbmNoDQo+ID4gPiB2MjogcmVi
YXNlZCBvbnRvIFJ1c3NlbGwgS2luZ3Mgc2VyaWVzIGRzYS84OGU2eHh4L3BoeWxpbmsNCj4gPiAN
Cj4gPiBJIHRoaW5rIHlvdSdyZSBtaXNzaW5nIHNvbWV0aGluZyAtIHlvdSBzZWVtIHRvIGJlIGFk
ZGluZyBzdXBwb3J0IHRvIHJlYWQNCj4gPiB0aGUgc3RhdGlzdGljcyBmcm9tIHRoZXNlIGJsb2Nr
cywgYnV0IHlvdSdyZSBub3QgYWN0dWFsbHkgZHJpdmluZyB0aGVtDQo+ID4gYXQgYWxsIGluIHRl
cm1zIG9mIHJlYWRpbmcgdGhlaXIgc3RhdHVzIG9yIGNvbmZpZ3VyaW5nIHRoZW0uDQo+ID4gDQo+
ID4gWW91IG5lZWQgdG8gbW9kaWZ5IGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvcGNzLTYzNTIu
YyBmb3IgdGhhdC4NCj4gDQo+IC4uLiBhbmQgdGhpcyBpcyB3aHkgeW91IG5lZWQgdG8gYmUgYWJs
ZSB0byB0ZXN0IG9uIHJlY2VudCBrZXJuZWxzIQ0KDQphcmUgeW91IGFic29sdXRlbHkgc3VyZSBh
Ym91dCBpdD8NCg0KbXY4OGU2MzUyX3NlcmRlc19nZXRfc3RhdHMoKSByZW1haW5lZCBpbiBzZXJk
ZXMuYyBhZnRlciB5b3VyIHJld29yayBhbmQNCmFzIEkgc2VlIGl0LCB5b3VyIHJld29yayBpcyBh
Ym91dCBsaW5rIHN0YXR1cywgYnV0IHlvdSBkaWRuJ3QgdG91Y2gNCnJlZ2lzdGVycyBhbmQgc3Rh
dGlzdGljcy4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K
