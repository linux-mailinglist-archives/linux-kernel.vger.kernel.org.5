Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196187BA337
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjJEPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjJEPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72043523;
        Thu,  5 Oct 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696514533; x=1728050533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PX7Mye+ZCtL1aM4Av4ZIWhWwg7G/yF0LBmG44Ipkujw=;
  b=SL0Rywe1bDlvLPiw/Oedpm5wtuSa31K9lrCgSigPP5GPCDsE0E7mO26t
   vIJFlzUhtPHyk8jyq9Cmtua87yYBXcJDP3FShHNXdidmCCLqhHUg66rut
   e3TXexQ5QZNdqRXq8iR6xA0wnDyEhoRJXoK+ZXiWAHDqipz3QY/JQBZmD
   NyZoMQpMv3OdJJ0PhXlxtCGQ8wuDM6nvOP5hbsKBloulbEUC2G0djHSE7
   HQ+bg5orsMiEhTyreI9FmhupLSQn5P+D5tOI6zfkibZAZ87P0QEqQParP
   oMP7ahao6b+HPcAnno/HkJw51HHQ+H2Vneemuw0JlumrNJbpl4wuIX/hu
   g==;
X-CSE-ConnectionGUID: 0dFRTVxQRu6PlzNxMtvl+g==
X-CSE-MsgGUID: ORMt5jYGSHaWxSvh7CyLNw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="8472411"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2023 22:18:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 4 Oct 2023 22:17:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 4 Oct 2023 22:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtLmQWIt7WKSRyc1TH3zxIRm52Tpg206CTwPI3LnxY7mUkadaHmIXcAe0nVRzMwtlx7mIbILTk/myLfuFu4lpWPUSrr8az/SQURZSXn3YkbFopavw3EhiETxp7r+H9sRrBeJ56HYtM8cVkuY9Qg9GYzbzw4OuLelPN19Wdr2ZlO5prkX0Jr3clB/aJXXJrw04qpiC3GzdhXPzcUiWWjojeG+NZDpLm7284Ay9uEedLDIYRogG+V2GDh/dhAWEKEbEzfS4AyynzzFhdtA2sDVHRv6ns2NPv3138BTURrqjewiDIdW7s10SNWeF+mIp/kdjkqOmWLdcMxWiCPnKMuDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX7Mye+ZCtL1aM4Av4ZIWhWwg7G/yF0LBmG44Ipkujw=;
 b=mIc5F7NjYM9OGQUnXxQwVqo1vuin0Ci7Gx9iJDgAQ7hOBnynUcb38t8WeMecuYJQxHj5naRKu9mX31SCs1siwkvgQPARbXTMKy5/WDFqVQ+9wLdfknyUv+Sm6b09NUdbFX91gzY9EWHHTKsywD31rwhADhCWMOmNuF/e1+mVAs1mcsEZ+zaNcE1NKqkVtP+yLhPXaAcJl0zLc9LuxY3/xXSPAsmeu9GTgFSOGGFliEjpVzGMgCmQUgnwWOFjQ5dDYsQvptOGMQYVHt0nqkYNdrjioVfu71Z5z+bVUHtq+CwAWhgngB09Z3G0fVaPz+eAr4tIwxvPDsXPHWa12t7cgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX7Mye+ZCtL1aM4Av4ZIWhWwg7G/yF0LBmG44Ipkujw=;
 b=Kt6ExtMxgow6Pxpr960JOrfChY7EJM22fMYE4HQdby77TZcxAl31LBQnvtKFWswQSxHTcsmtBZvfE8heLLYpLr8uejy4Ei/6N1bBeYX2IKZFCR6vY1RdB8TbCQoiv4vT7tK+hZESd86Gqb29V35kSmvmxY3NBrGUQaBoShGaTIg=
Received: from CY8PR11MB7688.namprd11.prod.outlook.com (2603:10b6:930:75::20)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 05:17:29 +0000
Received: from CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::77ff:74d2:4d5a:875]) by CY8PR11MB7688.namprd11.prod.outlook.com
 ([fe80::77ff:74d2:4d5a:875%6]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 05:17:29 +0000
From:   <VishvambarPanth.S@microchip.com>
To:     <jacob.e.keller@intel.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrew@lunn.ch>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <Bryan.Whitehead@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Topic: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Thread-Index: AQHZ8QY1ceTQbXJwb0+3Qg4gMnoFrbAyFI2AgAigewA=
Date:   Thu, 5 Oct 2023 05:17:29 +0000
Message-ID: <dde54385fcb38c1a66b7d09d6975d449dc5bdfde.camel@microchip.com>
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
         <e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com>
In-Reply-To: <e5ffec56-5512-1acc-b85c-ac0771634c22@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7688:EE_|DM4PR11MB5230:EE_
x-ms-office365-filtering-correlation-id: edfeb5f7-8309-436d-9900-08dbc5625eea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xsU5+IiOzW7jwHw3tYRERCoX/Nw4W2JBNW3ZXY3671X5R5RD5cpw8Muji/iYdcDGy/xsY5k5aKhrH14rPwEzvUzkAiszcKu3qa4HptiXEBIQROnfGNme/HgSQS2rvelLyDau59UtrgTJe7a7A9sN7O1nDTGjudTiYiR6HSgjOnXVqgTipOXkiqdLjmm3SI1okGqa2cvBHkj3u0bjHbCDG1CSaBrTySg/PNYYyRnJM/U5HbVtWfSHRotZy445aF1UYRzNWCkcly00dJ370iIqj39iSjBy68lUa+kpz/n4TP4/I9jixwuqZOGDHUowuSC3hpkDECw/MhVxUjkzJtQGEVRlOEIatyWAwu/1ZNUheOK/K7hYgAb0RTWNPX2OEDdqCXp/uD+8Qd4OjaWei3KmaeMJN0UtuGS+5topXHNKD6cZaF+cteArm3Q7YmZK0W1ieWXtvrQsBn2PIiGi/7QZkDiyRXF8cBb69VBRDxAGTUjhTs7u9CzhOGDifZ34O5PUHxAcLTMaEN8dq1lOrPSjVAEOqOQgvKpgMKY9HzMQoAXXL0uM5n1h2Vyvfn4qy8pYEjucbubXIyFgeEQUhuuBw4eCQvPs/H+WDcV8FmNeD9xtHUkKCmTs5lR2bK8vJRDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6486002)(71200400001)(478600001)(6506007)(53546011)(91956017)(110136005)(6512007)(2616005)(64756008)(83380400001)(36756003)(41300700001)(2906002)(54906003)(66446008)(86362001)(26005)(66476007)(76116006)(66946007)(66556008)(316002)(5660300002)(4326008)(38100700002)(38070700005)(8676002)(122000001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzJCYTQrUkViTWNKSy9vYjY5b0w5a25zQ0ZKYkVnS0k5UW1IUUtRb2FGQVZu?=
 =?utf-8?B?TUY4THdLbUYxVlQzUzU1MllRcGhBUk4yOFV2VWw2K0lWOGRZdEN6YmhQNXd0?=
 =?utf-8?B?ODBRa3gyM0FVUVB3Z05OVnNxOXNoU1RUNmtOeG8vUlNLdFlWZTE3a0pkblpI?=
 =?utf-8?B?dGhzYWdJQ2dCMjZXd1JObWRHaEs4aS83V3MxUnVFTFVuUG5XRnhuS3p4TXV1?=
 =?utf-8?B?TU84VDg3dlhGTnJkNW5YUmwwalQ5UUovbkUyb0hDb3hER1V6U00xcCtVbjF6?=
 =?utf-8?B?M1c5MVNuVkxHdHMvd1ppL0I4UHhidWFTR0ZFSW1ocndIbW9jVDlWK01PT2pa?=
 =?utf-8?B?YW01eDJwajNWUVRsUWJEYWtDcFhZc3B6TFhiRzE1b2ZxbjFrRFY5Vnh3czht?=
 =?utf-8?B?ZWphWEZQN25ldkltR0I5QUVTQ2NVMDFDUG56dTBmYitJOWZtTW14eE8xRzdq?=
 =?utf-8?B?dnpqSHh1cCsvRy9OQlEyWGtnRHBTdk15RE5vL3VlOEx5ZVZ1QUVqTmtJZUwy?=
 =?utf-8?B?Y1V3WEhRWXYvaXQ5VWJqRVRHSGdXdzBHV2NNeWF1cXJMZXVxdG9sQ3dDaFRm?=
 =?utf-8?B?aXp1dzBMNjl2VjRXUU9xTktROU5GUFdiL0s3ZVVkNzhyVUc0TFRVNWE3N2Y3?=
 =?utf-8?B?U3NZRUZZRloydW9TeEV3b2lwKy9pdFVhNXJWbHY4WElnL1czZzJ6TmRYU2sx?=
 =?utf-8?B?cWJSS2FvaExkb2ZIY1VmUENXNXlxMjBLbTFJa2xCcWpEVVN6Y1dReEZZNlJZ?=
 =?utf-8?B?a0UrSlZQaExYbXoxL3l6VjB1dGxHNXNMQnE4VFp1R0xSVWFSVC9NSU1MeCtH?=
 =?utf-8?B?VXRNdThPQ0RWU2JNblh5czBPQmpiWUVnVkNzNHNVS0dJbVI0OWJodjRKOHpY?=
 =?utf-8?B?dHh4eHpTem5XT24vYmhQQnVWb1BrNVJKZkpQTm1pVXl3WUhmQ2VTMnd2c2V5?=
 =?utf-8?B?TFFqai9VTFEvL2pWdGxvYjB5d2NMQ2NCNFc1TTh2UkdRMDVIL0ptRzNCS1M1?=
 =?utf-8?B?aVpEZlZGNGlLOGd5ZndFTXRKeEdlN29FY0o4Qkh5WTRVT3EvMGxmMTNmSndV?=
 =?utf-8?B?eTdhdTRtWVJQdEp3clFRdXlVZ1VXeFE0UFBnRmxkdnRyc1JtUStJUDYyRXYr?=
 =?utf-8?B?dUwvSFluYklIWStwaE1wd3ROTVlJSmZRV1BxZFhRaW1UOEVuSUxTc0MyOUl5?=
 =?utf-8?B?OUNwU1JqcURyenh3bDlpem5kRm5xUngzMUFqaUNPVTZyODdKRVlQcXJydnJo?=
 =?utf-8?B?Ri9CNXpvTlB2R2NwUEUyL0JPRVg0Z25ZdTdYSGVkRnE0VTFhU1U3aldWYUcy?=
 =?utf-8?B?SWhTUjlkaUtpMXJWbTBUMjZIM0tqQjBQWkpBa0Y5SnluNXdSNHMrS2JQelRa?=
 =?utf-8?B?K3lJTU04eG43Y0lRRjZkVlcwTGh3MHJYdTFQczJiRnBSVUVRZDFuTWlUMnVD?=
 =?utf-8?B?Y09kcUcwdUpSUkN3NmM5ZTE2ZFNqbExjOUN4ZHpHVWk4eDBUc3JwazZBYmgw?=
 =?utf-8?B?bjFRRy9rZnpMekE0T1ZGd1VLMFFGSmI0TWV6RllYbGJvVVpCTEVDUkczWmRv?=
 =?utf-8?B?d3JQQ1QwaXpUQ0FMUDB0VFFlM3kzQlp2bDJ2cXlNMkVremxmZmRQQWhTTnRa?=
 =?utf-8?B?dXFubHF1WHlqQnNHNGNhc3o5NHFUbkw4dWVENFFkOUp4aU40N3JkZjNVR2FI?=
 =?utf-8?B?REZHTGVLbERaaHREckZnRWJRaWpoZEVBOU5JUXdRV0NVS3ZKeGFWZ0o2OTRN?=
 =?utf-8?B?UHlaK3loenBCcDhobzlndzJqVzQ1SklIeE04MytsbURQNEtMM28rMHhoNVlE?=
 =?utf-8?B?SDhzQzFZVGJhVFJPV1hYS0c4NjgyU0ZMUEs0eE1LbUZTaHRQTlBaN2VsNmk0?=
 =?utf-8?B?d2Z3NEZKaXdJMmtUNndIeW1XS1dPSFZqWVVjNzhZeUg2TGJ0dVl6MCtER1JJ?=
 =?utf-8?B?YTRZK1FwdFFCbzZQSWpkdTVaTkw5YXhXaWRwaG4rWU54aWt2TWVIcUlwRjZN?=
 =?utf-8?B?dWovUU9BcGdvU0lvQjRJZjJFUFNxSVRSOEI2UVVMejlMSGhPTEtSTDV3YkxT?=
 =?utf-8?B?VGl5L2Qrc1BkRXdNRnh5UkoyWGJabDNZbTZmQy9FYnp4YzVTN09SM0ZHOVhn?=
 =?utf-8?B?eERjdlF0ZFZxSEp4WU1QL2dzRFVsQ3R5QjM3K3REdnFWQjU0bVNEWGJRblpu?=
 =?utf-8?Q?PqHdVxBfc6MYGtvAA831Jgw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA130D2F8E6B804B82D74AA3FF7EF807@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7688.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfeb5f7-8309-436d-9900-08dbc5625eea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 05:17:29.2411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmdpahC9Jkj8ALaeLM4zPTSxph+OteE4IfEPYoPNYXky5xECpnN6M127BQkZO54SZK3xzvaFh75sHCdUKy6/I3gu8XMwbK1AJa2HbEmHxAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTI5IGF0IDEwOjM1IC0wNzAwLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gOS8yNy8yMDIz
IDQ6MTYgQU0sIFZpc2h2YW1iYXIgUGFudGggUyB3cm90ZToNCj4gPiBUaGUgTEFONzQzeC9QQ0kx
MXh4eCBETUEgZGVzY3JpcHRvcnMgYXJlIGFsd2F5cyA0IGR3b3JkcyBsb25nLCBidXQNCj4gPiB0
aGUNCj4gPiBkZXZpY2Ugc3VwcG9ydHMgcGxhY2luZyB0aGUgZGVzY3JpcHRvcnMgaW4gbWVtb3J5
IGJhY2sgdG8gYmFjayBvcg0KPiA+IHJlc2VydmluZyBzcGFjZSBpbiBiZXR3ZWVuIHRoZW0gdXNp
bmcgaXRzIERNQV9ERVNDUklQVE9SX1NQQUNFDQo+ID4gKERTUEFDRSkNCj4gPiBjb25maWd1cmFi
bGUgaGFyZHdhcmUgc2V0dGluZy4gQ3VycmVudGx5IERTUEFDRSBpcyB1bm5lY2Vzc2FyaWx5DQo+
ID4gc2V0IHRvDQo+ID4gbWF0Y2ggdGhlIGhvc3QncyBMMSBjYWNoZSBsaW5lIHNpemUsIHJlc3Vs
dGluZyBpbiBzcGFjZSByZXNlcnZlZCBpbg0KPiA+IGJldHdlZW4gZGVzY3JpcHRvcnMgaW4gbW9z
dCBwbGF0Zm9ybXMgYW5kIGNhdXNpbmcgYSBzdWJvcHRpbWFsDQo+ID4gYmVoYXZpb3INCj4gPiAo
c2luZ2xlIFBDSWUgTWVtIHRyYW5zYWN0aW9uIHBlciBkZXNjcmlwdG9yKS4gQnkgY2hhbmdpbmcg
dGhlDQo+ID4gc2V0dGluZw0KPiA+IHRvIERTUEFDRT0xNiBtYW55IGRlc2NyaXB0b3JzIGNhbiBi
ZSBwYWNrZWQgaW4gYSBzaW5nbGUgUENJZSBNZW0NCj4gPiB0cmFuc2FjdGlvbiByZXN1bHRpbmcg
aW4gYSBtYXNzaXZlIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IGluDQo+ID4gYmlkaXJlY3Rpb25h
bCB0ZXN0cyB3aXRob3V0IGFueSBuZWdhdGl2ZSBlZmZlY3RzLg0KPiA+IFRlc3RlZCBhbmQgdmVy
aWZpZWQgaW1wcm92ZW1lbnRzIG9uIHg2NCBQQyBhbmQgc2V2ZXJhbCBBUk0NCj4gPiBwbGF0Zm9y
bXMNCj4gPiAodHlwaWNhbCBkYXRhIGJlbG93KQ0KPiA+IA0KPiANCj4gSSBhc3N1bWUgaGVyZSB0
aGUgY2hvaWNlIG9mIDE2IGlzIHRvIGdldCB0aGUgMTYgYnl0ZXMgZnJvbSA0IGR3b3Jkcz8NCg0K
VGhhbmtzIGZvciB0aGUgY29tbWVudHMuIFllcywgaXQgaXMgc2V0IHRvIDE2IGJ5dGVzIHRvIG1h
dGNoIHRoZSBzaXplDQpvZiB0aGUgZGVzY3JpcHRvcnMgd2hpY2ggYXJlIDQgZHdvcmRzIGxvbmcu
DQo+IA0KPiA+IFRlc3Qgc2V0dXAgMTogeDY0IFBDIHdpdGggTEFONzQzMCAtLS0+IHg2NCBQQw0K
PiA+IA0KPiA+IGlwZXJmMyBVRFAgYmlkaXJlY3Rpb25hbCB3aXRoIERTUEFDRSBzZXQgdG8gTDEg
Q0FDSEUgU2l6ZToNCj4gPiAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtDQo+ID4gWyBJRF1bUm9sZV0gSW50ZXJ2YWzCoMKgwqDCoMKgwqDCoMKgwqDCoCBU
cmFuc2ZlcsKgwqDCoMKgIEJpdHJhdGUNCj4gPiBbwqAgNV1bVFgtQ13CoMKgIDAuMDAtMTAuMDDC
oCBzZWPCoMKgIDE3MCBNQnl0ZXPCoMKgIDE0MyBNYml0cy9zZWPCoCBzZW5kZXINCj4gPiBbwqAg
NV1bVFgtQ13CoMKgIDAuMDAtMTAuMDTCoCBzZWPCoMKgIDE2OSBNQnl0ZXPCoMKgIDE0MSBNYml0
cy9zZWPCoA0KPiA+IHJlY2VpdmVyDQo+ID4gW8KgIDddW1JYLUNdwqDCoCAwLjAwLTEwLjAwwqAg
c2VjwqAgMS4wMiBHQnl0ZXPCoMKgIDg3NiBNYml0cy9zZWPCoCBzZW5kZXINCj4gPiBbwqAgN11b
UlgtQ13CoMKgIDAuMDAtMTAuMDTCoCBzZWPCoCAxLjAyIEdCeXRlc8KgwqAgODcwIE1iaXRzL3Nl
Y8KgDQo+ID4gcmVjZWl2ZXINCj4gPiANCj4gPiBpcGVyZjMgVURQIGJpZGlyZWN0aW9uYWwgd2l0
aCBEU1BBQ0Ugc2V0IHRvIDE2IEJ5dGVzDQo+ID4gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLQ0KPiA+IFsgSURdW1JvbGVdIEludGVydmFswqDCoMKgwqDC
oMKgwqDCoMKgwqAgVHJhbnNmZXLCoMKgwqDCoCBCaXRyYXRlDQo+ID4gW8KgIDVdW1RYLUNdwqDC
oCAwLjAwLTEwLjAwwqAgc2VjwqAgMS4xMSBHQnl0ZXPCoMKgIDk1NiBNYml0cy9zZWPCoCBzZW5k
ZXINCj4gPiBbwqAgNV1bVFgtQ13CoMKgIDAuMDAtMTAuMDTCoCBzZWPCoCAxLjExIEdCeXRlc8Kg
wqAgOTUxIE1iaXRzL3NlY8KgDQo+ID4gcmVjZWl2ZXINCj4gPiBbwqAgN11bUlgtQ13CoMKgIDAu
MDAtMTAuMDDCoCBzZWPCoCAxLjEwIEdCeXRlc8KgwqAgOTQ4IE1iaXRzL3NlY8KgIHNlbmRlcg0K
PiA+IFvCoCA3XVtSWC1DXcKgwqAgMC4wMC0xMC4wNMKgIHNlY8KgIDEuMTAgR0J5dGVzwqDCoCA5
NDIgTWJpdHMvc2VjwqANCj4gPiByZWNlaXZlcg0KPiA+IA0KPiANCj4gR29pbmcgZnJvbSBiYXJl
bHkgdHJhbnNtaXR0aW5nIHRvIGhpdHRpbmcgdGhlIGxpbmUgcmF0ZSAqYW5kKg0KPiBpbXByb3Zp
bmcNCj4gYm90aCBUeCBhbmQgUnggc2xpZ2h0bHkgaXMgZmFudGFzdGljLiBIdWdlIHdpbiBqdXN0
IGF2b2lkaW5nIGFsbCB0aGF0DQo+IHVubmVjZXNzYXJ5IHdhc3RlZCBQQ0llIGJhbmR3aWR0aC4N
Cj4gDQo+ID4gVGVzdCBzZXR1cCAyIDogUkszMzk5IHdpdGggTEFONzQzMCAtLS0+IHg2NCBQQw0K
PiA+IA0KPiA+IFJLMzM5OSBTcGVjOg0KPiA+IFRoZSBTT00tUkszMzk5IGlzIEFSTSBtb2R1bGUg
ZGVzaWduZWQgYW5kIGRldmVsb3BlZCBieQ0KPiA+IEZyaWVuZGx5RWxlYy4NCj4gPiBDb3Jlczog
NjQtYml0IER1YWwgQ29yZSBDb3J0ZXgtQTcyICsgUXVhZCBDb3JlIENvcnRleC1BNTMNCj4gPiBG
cmVxdWVuY3k6IENvcnRleC1BNzIodXAgdG8gMi4wR0h6KSwgQ29ydGV4LUE1Myh1cCB0byAxLjVH
SHopDQo+ID4gUENJZTogUENJZSB4NCwgY29tcGF0aWJsZSB3aXRoIFBDSWUgMi4xLCBEdWFsIG9w
ZXJhdGlvbiBtb2RlDQo+ID4gDQo+ID4gaXBlcmYzIFVEUCBiaWRpcmVjdGlvbmFsIHdpdGggRFNQ
QUNFIHNldCB0byBMMSBDQUNIRSBTaXplOg0KPiA+IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0g
LSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0NCj4gPiBbIElEXVtSb2xlXSBJbnRlcnZhbMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFRyYW5zZmVywqDCoMKgwqAgQml0cmF0ZQ0KPiA+IFvCoCA1XVtUWC1DXcKg
wqAgMC4wMC0xMC4wMMKgIHNlY8KgwqAgNTM0IE1CeXRlc8KgwqAgNDQ4IE1iaXRzL3NlY8KgIHNl
bmRlcg0KPiA+IFvCoCA1XVtUWC1DXcKgwqAgMC4wMC0xMC4wNcKgIHNlY8KgwqAgNTM0IE1CeXRl
c8KgwqAgNDQ2IE1iaXRzL3NlY8KgDQo+ID4gcmVjZWl2ZXINCj4gPiBbwqAgN11bUlgtQ13CoMKg
IDAuMDAtMTAuMDDCoCBzZWPCoCAxLjEyIEdCeXRlc8KgwqAgOTYxIE1iaXRzL3NlY8KgIHNlbmRl
cg0KPiA+IFvCoCA3XVtSWC1DXcKgwqAgMC4wMC0xMC4wNcKgIHNlY8KgIDEuMTEgR0J5dGVzwqDC
oCA5NDYgTWJpdHMvc2VjwqANCj4gPiByZWNlaXZlcg0KPiA+IA0KPiA+IGlwZXJmMyBVRFAgYmlk
aXJlY3Rpb25hbCB3aXRoIERTUEFDRSBzZXQgdG8gMTYgQnl0ZXMNCj4gPiAtIC0gLSAtIC0gLSAt
IC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtDQo+ID4gWyBJRF1bUm9sZV0gSW50
ZXJ2YWzCoMKgwqDCoMKgwqDCoMKgwqDCoCBUcmFuc2ZlcsKgwqDCoMKgIEJpdHJhdGUNCj4gPiBb
wqAgNV1bVFgtQ13CoMKgIDAuMDAtMTAuMDDCoCBzZWPCoMKgIDk2NiBNQnl0ZXPCoMKgIDgxMCBN
Yml0cy9zZWPCoMKgIHNlbmRlcg0KPiA+IFvCoCA1XVtUWC1DXcKgwqAgMC4wMC0xMC4wNMKgIHNl
Y8KgwqAgOTY1IE1CeXRlc8KgwqAgODA2IE1iaXRzL3NlY8KgwqANCj4gPiByZWNlaXZlcg0KPiA+
IFvCoCA3XVtSWC1DXcKgwqAgMC4wMC0xMC4wMMKgIHNlY8KgIDEuMTEgR0J5dGVzwqDCoCA5NTYg
TWJpdHMvc2VjwqDCoCBzZW5kZXINCj4gPiBbwqAgN11bUlgtQ13CoMKgIDAuMDAtMTAuMDTCoCBz
ZWPCoCAxLjA3IEdCeXRlc8KgwqAgOTE5IE1iaXRzL3NlY8KgwqANCj4gPiByZWNlaXZlcg0KPiA+
IA0KPiA+IEZpeGVzOiAyM2YwNzAzYzEyNWIgKCJsYW43NDN4OiBBZGQgbWFpbiBzb3VyY2UgZmls
ZXMgZm9yIG5ldw0KPiA+IGxhbjc0M3ggZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNo
dmFtYmFyIFBhbnRoIFMgPHZpc2h2YW1iYXJwYW50aC5zQG1pY3JvY2hpcC5jb20+DQo+ID4gLS0t
DQo+IA0KPiBBbHdheXMgZnVuIHRvIHNlZSBhIG1hc3NpdmUgd2luIGxpa2UgdGhpcyEgRXZlbiBq
dXN0IHRoZSAyeA0KPiBpbXByb3ZlbWVudA0KPiBvbiB0aGUgUkszMzk5IGlzIGh1Z2UsIGxldCBh
bG9uZSA2eCBpbXByb3ZlbWVudCBvbiB0aGUgeDg2IHBsYXRmb3JtLg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiANCj4gPiDCoGRy
aXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uaCB8IDIgKy0NCj4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuNzQzeF9tYWlu
LmgNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uaA0K
PiA+IGluZGV4IDUyNjA5ZmMxM2FkOS4uNmRhYzZmZWY3ZDI0IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uaA0KPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4X21haW4uaA0KPiA+IEBAIC0xMDY3
LDcgKzEwNjcsNyBAQCBzdHJ1Y3QgbGFuNzQzeF9hZGFwdGVyIHsNCj4gPiDCoCNkZWZpbmUgRE1B
X0RFU0NSSVBUT1JfU1BBQ0lOR18zMsKgwqDCoMKgwqDCoCAoMzIpDQo+ID4gwqAjZGVmaW5lIERN
QV9ERVNDUklQVE9SX1NQQUNJTkdfNjTCoMKgwqDCoMKgwqAgKDY0KQ0KPiA+IMKgI2RlZmluZSBE
TUFfREVTQ1JJUFRPUl9TUEFDSU5HXzEyOMKgwqDCoMKgwqAgKDEyOCkNCj4gPiAtI2RlZmluZSBE
RUZBVUxUX0RNQV9ERVNDUklQVE9SX1NQQUNJTkfCoCAoTDFfQ0FDSEVfQllURVMpDQo+ID4gKyNk
ZWZpbmUgREVGQVVMVF9ETUFfREVTQ1JJUFRPUl9TUEFDSU5HwqANCj4gPiAoRE1BX0RFU0NSSVBU
T1JfU1BBQ0lOR18xNikNCj4gPiANCj4gPiDCoCNkZWZpbmUgRE1BQ19DSEFOTkVMX1NUQVRFX1NF
VChzdGFydF9iaXQsIHN0b3BfYml0KSBcDQo+ID4gwqDCoMKgwqDCoCAoKChzdGFydF9iaXQpID8g
MiA6IDApIHwgKChzdG9wX2JpdCkgPyAxIDogMCkpDQoNCg==
