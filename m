Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B775755E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjGRHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjGRHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:30:28 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C37170B;
        Tue, 18 Jul 2023 00:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyEq6HvW1lhlyC86rDAe29geE37J2NFaJmIUEiGHzN8eOWtk99iok8rkSrZwf1d/FaOQuO5pByRXFw4grM4A4IeHMh8TOPZ25R8HctbIoERwZY8s9Lkkxu0Ffwwc4drsU+KrhSM7/uro6Kj0BDEq6sNkJT9m0j0XtQSFV40/7cV5553yMddKIuIoL/zgQNNsalEF2AaqkhNO3ygXBkYZI2UzIm3XJKJtSQXL0jcR3BZgcQj6IdEcWHRTOYCI4A42AO1f24g0E4iqgh19mkONHFLtXSbYRS7YKPA+4dVdb3kr1t1Lo7pvNvsjjw2e46myjwj3RbDIPHaSo8VSjOGioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFOv8hLd8ACtD7LEsUUBcEtwvnQMgDFDF18hF38tSiI=;
 b=eXRyp8bXxfytGyoSwjOrf6Uxl/skw4+Y9ES73ZLWE4oixskg36I90eUNUGbJC90yVqE1rLNsiozgv6eaowcytqCunmfVQ2rkNT1RrgxQNEmg8AIeJ38SLhurYhKV1kObn2mxiia+sb6RpSgu5oxs3H21yw6oIsTDNn3bPjTQqPFBttbDNZxkAOdldAcdJm0OzwtrPmwWnriTY7/T2z3/Dex72P0hc79mvDx2ewYYZEo5RF1y7q4WsBX12fo0chpiF5Wii+ziQ2V4XulU+QlJEkxd7rS54CYKnetK/FA66oY79pCI4MvLMSQj5ok847+FPfNDsaZ2E+j2ye57ZtarXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFOv8hLd8ACtD7LEsUUBcEtwvnQMgDFDF18hF38tSiI=;
 b=m0MxXpMDa+Hn8drrrCkzCsPpJDowd8qxeOI2RQmjnpcr3QcdyWNcQwMtf3RFyzkRz1zjgGd2zi+3ht0hbHx9kKjXaLkQbsA7aGqTmOmpEx8BFCoXypC1JqRXFahCMarLWRzmoq+QGQhkzKIR4btdtHhVA4vbV5TS5dEKZF1eulNXgyYmGWkfaS5yGnSQLR5KkRZujLVnIoVkNluATv7IwGRNk4Uu3sQKp3OYT6943dXhncF5SErDe50oKLH7rsUQaUvge2IHqheFN8c3eAqdnzP4h4vXQ+GXcrkEw6Tl2CRn1ZI0A1TejjO489L+DU3Vb1HGrtOlAVP8ea4ZWZk7Hw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 07:30:23 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:30:23 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "Haener, Michael" <michael.haener@siemens.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Topic: [PATCH v3 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Index: AQHZuUWCmDeNL1+DZkuXTQMtQaAi8K+/IN+A
Date:   Tue, 18 Jul 2023 07:30:22 +0000
Message-ID: <19feca87b4af24f971acc2997a24f60079d77839.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-4-michael.haener@siemens.com>
In-Reply-To: <20230718065937.10713-4-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7236:EE_
x-ms-office365-filtering-correlation-id: 41177654-50fe-4fd9-ced0-08db8760d8f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40H8C3lMw8cwBH/IKeAPIFjwvh5rxoEhdrqOn2uFt8hq5+dg8rDxg9bb/0gRzephw1bFpZ9P19DGabcJ4iTsxcPOyxqgR9vRGzYVIwucOTcRvf+t4F0R3bOjAaHiZVU/5vPGc1RIQTk9d7yOxcOlu2wcHPa79lwl3C+b2l8eoCVio6QwhidjpoKQId6rqgZu0/1gKylr6BNLJJeXn1/U808iDjj27LaSeduofoAsShn/tzKWs5OZwYMlxwMq+aQbpnZd1e6ht4d7DvACUqKv0Ezxq/skLVoZp287IOKROxMbAZAKPywoXH/LWew+eXNW8zzyJL8WE9J2P4S58p1mx+Px+KXFOjfz/u6CstSfSm0vJ4SFSQpQJti8rRxJkcRpHPiZbWCg090AkkhKySauA/FXU1xqEV8pKl5mhmzJUi+XDj+TID1GOTlulqc+B5hVnhcXEmUTjM2s71ZfSidkCkGtN5we139BsoZY47IYMOnj1m1YKW5Zj0K+eyF4eddOrE7mv9tvYwwvsgU+8nUNUmRt3Ot0q0vW45oAVR/+l8kgdMuo35BjkEd4cJruuE118flYQA/CFg+xPfD3TjhIuVwZV21UoHFShujz84nkdsBzREbn3pA74wINuOuTiOqFHLYwkucWzV9U4Rl8kioLng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(8936002)(478600001)(110136005)(71200400001)(36756003)(7416002)(4744005)(54906003)(66446008)(91956017)(316002)(41300700001)(64756008)(76116006)(4326008)(6486002)(66556008)(66476007)(66946007)(82960400001)(83380400001)(38100700002)(122000001)(6512007)(5660300002)(55236004)(15974865002)(38070700005)(2616005)(26005)(6506007)(186003)(8676002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2VST1JYa2dMd3JNK1JkL2JJcmFwaE91VUd1ckZuRG5Ha0g1WmxRU0JsNnR3?=
 =?utf-8?B?WnJQVGxZdythb0FSS2V3SmVHbUp6SFlSOE83Z1VVVnpqUW8zcE5MeFpQejVB?=
 =?utf-8?B?THdkRm9Lb1k1bWM5VDhLUktTUHZKQWo1cURQMW5QNUVhTTRGNExDc284ano2?=
 =?utf-8?B?ZkJWd3pncHVvWjFvQWpqN1Z1Z3N4dElPcG54b2xUZDZBYVpuNHdrdVJqQlFt?=
 =?utf-8?B?MCtSS1VEd2ZpZ0RBNGNDU1NJRW1NVE8vQkxIeHNsbk04SzdLa1RNS3AxZlRG?=
 =?utf-8?B?OVJGMGU1QnMyRGtoTlJJSlhONndvN0JVVnVYS3Jpb0RzWEhxVTlIMlMvc00z?=
 =?utf-8?B?WDkzZFdPcHpYL0d1cGNCam1CaHduVStOMzZDVy9ZbzFkUGd4OExzRHE0b1kr?=
 =?utf-8?B?QXA3SXVUbllNelV3ZnhtZEp4dWVqbHdWeStqdk44Vi9INTZFa3BxYnR6Ymk3?=
 =?utf-8?B?QXBidTd0T3RFc0RjSlhObEJ2UEd1VXZGSlN1cDFOU0djd1VnODdGMkJUenJY?=
 =?utf-8?B?VWlIREg1MHRWbU5wRGJYdGxsNEd0R1Btajk1c2ZHSndEZEpZNVdPdTJPajZl?=
 =?utf-8?B?SkJlS3VVT2prY1ZyUzkwT3NYSTRkc3czYVkrQjhmZnhtMUl1ZWZnNFQ1ZXhn?=
 =?utf-8?B?WGxxN29vNU1LV1JHckFma3hVTmZGUHVJbzNUSGVST2htVnRMK1h0ZjZnaUdL?=
 =?utf-8?B?U3dXSnM2Vms4NnIzMnZpMVpySmNPREF1RTVZYzZlRWtPK2I2QmJkZ3lIdDJW?=
 =?utf-8?B?amI3bjI0b2VsNzh4cFdEWXlJRkJqWUo0Q2w4TkM0T0ZXS05CLzZGRWt4WFBx?=
 =?utf-8?B?SW54SWxubXA1NXNtU2o5ZWxzZDVzbzdMTkhicFF2aFNId1RPUUl2WURXNHAx?=
 =?utf-8?B?R1AwTSthT3FESDlhbzQ0MEdEQ3ZON3NjS0NuTVRoMkhQWDlhVTByTUlWa2VF?=
 =?utf-8?B?YnZ3d3FTL01BbFhpRjdiQzFXVkpJNU1PbmhsNlUxTEt0VXBMWndtcHFESStl?=
 =?utf-8?B?QVZPT2dha2Y4Y01WVXpIVW5ydEhzWnVrVEtPakFSSlg4OFg5cUpINFRpSWIr?=
 =?utf-8?B?VVBGQll3MWtTMm5yS0Vsb0xWMVhiZ0RoRy80bWY0UTJ5T0tqdFBNUWxWT2Yv?=
 =?utf-8?B?SzBiMnMyK3R6SFRiM3lHdGlWeVRMRnU5MkppaW5Sb0JrMmtPK3k3b0dDaVFS?=
 =?utf-8?B?UTNxSE1kRytnSFVDYUYzdytwUlVpK0M0MVY1a2JEK3lhYUpmUy9MTk95SFlS?=
 =?utf-8?B?dXhGYUNwUXpxb2R6MWlkZEJ3eWJoTEMyYi9jNUhLZ3locGIxOHVQOG41Rnov?=
 =?utf-8?B?emNlaWZQYllwM3pHRVFqY2dHSWxvUGVCOUJyc1BnU0pvL3QyK2dYU2hXVmR0?=
 =?utf-8?B?Nis4cUhwRkdEbTBwMUFLNE94MnIxNHNOUWNtOG5wRzFzdGN6YkJyc0pYZlZm?=
 =?utf-8?B?NnZrRkh1RjR3Z3dEWUU3bm42TWlOdWs5Nm5jWEhoRDdhUHpJbG5ZbU5veisv?=
 =?utf-8?B?Sk9hQTlyN3JqTm96Y2R1RTRBeU9DcnllY2M4UEpBTzFnaU5tZ29jajIxV3hn?=
 =?utf-8?B?amhnQzZ2Y0pRT3dkWkpqb0RqVjBBWW1ZVmFBTUNQbHdvUXBqQVlZZG9jMEhu?=
 =?utf-8?B?TzZ6bENnNlVsK29aVklENE1sWVp3YlhSb0N2TUh6TklqbzRTRVo3M0NtZitE?=
 =?utf-8?B?L1diTEt0bExiSlZpYkJldGhId2JRNWJ3NDY5bHRKcjhLQk9RMU5obk1TQ1VW?=
 =?utf-8?B?MTFEcWpsbFROMTViRS8vazhKbVBpbkhpOXk2T0N1ZTZOdlJyUlZUOFNBV2Z2?=
 =?utf-8?B?QTVzSllrKzVnT2phVTVYOTBjZFdQaVBWSkl3cnVkcUczc3lVNHJ6RVRyVzdW?=
 =?utf-8?B?Nm12YlJsK2tDZnpNRVExd0tTOWVWYXplMFJpdHcxNmRPcUViUE1oUHNyWDFT?=
 =?utf-8?B?WFF4cGNKY1o2WEZkeHdyS0FLQnJzWktzOU5ZNzhDUStvUitNR3hjMmRXYzRj?=
 =?utf-8?B?YkttY3l1R3dLdUhHSU1mSmhLTVk3MExOQ0N1b1EvV0tBWm1UK3Vpa2dhSGlZ?=
 =?utf-8?B?UmRhMTdOMWdqTitweVR1U0UwWU5FdGI5OHdLRGZMZE9HL2tkMTNVVERDWkkv?=
 =?utf-8?B?ZjFrM05VY1B5cFVBcTlPdkRKQnRMUGp3aHlMSTJnOVBTTC9HK2ZKaWt5UlNJ?=
 =?utf-8?Q?75yX8ZxQB6XM4TiBQUsFOtM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC085FB34F6134479828764D973D95AC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 41177654-50fe-4fd9-ced0-08db8760d8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:30:22.9492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vix7METY2UsbRGNKt0Ba0NafrCtzQaTd+cw+AgZqUcJ6+QsjK9bhVCeQUCCqWfgV0zx/f+xFSCIjB+8dzpm387hdbFbX1IQ3QtdxzObW9Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7236
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

T24gVHVlLCAyMDIzLTA3LTE4IGF0IDA4OjU5ICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+IEZy
b206IE1pY2hhZWwgSGFlbmVyIDxtaWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRo
ZSA4OGU2MzJ4IGZhbWlseSBoYXMgc2V2ZXJhbCBTRVJERVMgMTAwLzEwMDAgYmxvY2tzLiBCeSBh
ZGRpbmcgdGhlc2UNCj4gb3BlcmF0aW9ucywgdGhlc2UgZnVuY3Rpb25hbGl0aWVzIGNhbiBiZSB1
c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFlbmVy
QHNpZW1lbnMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IENoYW5nZWxvZzoNCj4gdjM6IHJl
YmFzZWQgb250byBtYWluIGJyYW5jaA0KPiB2MjogcmViYXNlZCBvbnRvIFJ1c3NlbGwgS2luZ3Mg
c2VyaWVzIGRzYS84OGU2eHh4L3BoeWxpbmsNCj4gDQo+IMKgZHJpdmVycy9uZXQvZHNhL212ODhl
Nnh4eC9jaGlwLmPCoMKgIHwgMTggKysrKysrKysrKysrKysNCj4gwqBkcml2ZXJzL25ldC9kc2Ev
bXY4OGU2eHh4L3NlcmRlcy5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IMKgZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9zZXJkZXMuaCB8wqAgOSArKysrKysrDQo+IMKg
MyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJk
bGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
