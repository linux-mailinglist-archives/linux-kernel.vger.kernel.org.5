Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32156788EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjHYSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHYStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:49:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB781BD2;
        Fri, 25 Aug 2023 11:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692989360; x=1724525360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k2GUyE+Sq1heRCxaJ3psOuF9xtb1ZeYgzV8ugjK2eyk=;
  b=gsli9vXPSHCSaUhumvTeuciddOc/UMA4tp4WV/niaYEtO57g0EjC4U5g
   0l5b4Feq34Nuh9J4sWBRwYgs9ktfZedC8XGALQPMmEjmrJN9NhBgenjaI
   Brv9a3afqL3e4uDPukt85gwfgkpddDqKiE8mXFx4cbqWgrPwHpc3vTU9T
   pX4PqVjTShRp5zImcIcZ5vwaMdProFhWVOLpFysF4JelU9dEoEmHHLAD8
   HMM8iyqFtOE8j4ZIGQ6pPT+pN4ryPiTkRJ08T594lafVNVqYLIKPnBJAT
   XPZ6+cu1wgq2hOb9qv9V3yHVSe/WqhEIHG0fx+q2BoY4lwCNY/62vZY7b
   w==;
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="1325455"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 11:49:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 11:48:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 25 Aug 2023 11:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmkQQzPcI8wvpeqQnF0Z0LWLGB66W6cvW2doRa8DLnH6EHenOml3xxYomv+r0PsBK2WjJLHdWfs3jv2j39mDNUjoODEMbGY81WoMaaPQm2gEe9bsJJLAz4skaFHEeu0rH6owsCJhT4mnxH5zeumFFH4WHik0Ye1V9rYDNV8tFkgBjw2Ix6G/6i/TNeGiWEoveDoZ1gVrIn5JMnNjL8jah9Vj8j8WlGbJrJHKaDAMSlpuR7UBD/HPfxMRQs7B6V5o1SxBswET/Kzt0vFonkUXQC4KDvK1+pCTcEocKPOVUctFhh3uyJpMkJU165wbC/LJZxkDV4RK1wUFkjizmmKbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2GUyE+Sq1heRCxaJ3psOuF9xtb1ZeYgzV8ugjK2eyk=;
 b=np8hw7El9ijrWemCje1n4VzBV29HQvY6U2ujS9OvXnYtB2rvWTZ5JoHeYGCUJpGZ02G+Rwe1I02pJmN9Uyp1UHBRIl4gAXE8UoUlreY0x1QrqaFQqXH7vwgPNk76y9sW6v0A4ChoUbQpEKDaPhTJDa3cOyGxno+jHfn4DX7se67oaebledNtHhuQTMqSgDrdY6Gz6Nw49LrdFu2lFoLEXcvFJjAI9iZlfu5M/PN57wV0B3wvi5+s978PB0YgyMMlRsKUzGJoODkwAQwiTXcFgrrtR9g0yBRph+TFFx4PTFdsXBDygQ5WxMAFF49v4rPwo/18XQ2mizwpiJjE8iKQMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2GUyE+Sq1heRCxaJ3psOuF9xtb1ZeYgzV8ugjK2eyk=;
 b=eU2leESYA8wkgqMPQjsEWm3/sQvPrdFRo9+2ARH6JbJPHLunP2OjM+HQ5A2s3f9z3WxZTQaupppxgxCiyXw27F4AtMtRKPbQ7eoJeTqxR62rdH7gUO7WX6abAPXIfjEVZjS3nOaY5OigCrot/AkcMnVcmxF1nZ6dYJsD0okWi7Q=
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 18:48:41 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::ceda:7787:e08b:7a19%7]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 18:48:41 +0000
From:   <Tristram.Ha@microchip.com>
To:     <f.fainelli@gmail.com>
CC:     <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>,
        <Woojung.Huh@microchip.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <lukma@denx.de>
Subject: RE: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Topic: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Thread-Index: AQHZ1qKWLyunbFo9dUGlg3dtAL+k26/6NENwgAB9tYCAAHHrgIAANckA
Date:   Fri, 25 Aug 2023 18:48:41 +0000
Message-ID: <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
In-Reply-To: <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|IA1PR11MB6099:EE_
x-ms-office365-filtering-correlation-id: 814bd1fd-4a0c-42ce-69ae-08dba59be6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0BbpOLzUebFRz9YYekWxWwSrysD9QmuFvTu8P0uvXWCTiQZyaG5KeTzhTpwQHyljX8y6BWhPHxqf8EWq1cMkn2E/DLRu5BOj/Ot5VAVC/ggtMwgZLwrrZNZ7CB8Dgee+/KP1DXeXjy9UMffD6HRMHvx/ID+ZngZ7nqC5gYKgbFUsthU0URXQpV5VEYjEsLt/MdaIkxDdhaaDIe9EmPKP+TbjQtc9WAGnIpaGJofsvXGc01eXaHGBMeE6zyYuQudgoTEtiJCKMRKEnA5rHPJVsUrU0m8N7UaXWryaM5ztszdohSiIGUjLyiPT3AnpyVcEJKo6+DKQIM7JbsWimgYDpPScCb+VDSXsFslHHsJO+xzL3hQ6PlUzlcMzhhRXvISQVS5dffUfKDtz5XeiYMyvFNRimv4d+KDfYdX69z/Om8p2dDaxwKOeC3Ze9WE8uEHaqATNtm4BCmr2FEY4gAEpIT87vxGcX5p68/Ot+2azY7xOyrpfB3u/jkfE90xYnMLsoXvh5hWkeG8VbjCCZhvsZwx/fvQjh9GQ5eOP/vfdsIOIr/A73zpDCwZiATbOHmnejVKPyNUHtF0IgLtOb4n9GpiotYcWPjHeM/A0JgAKPMyp7Uie9kZ5M+XWhlBFdW2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199024)(186009)(1800799009)(54906003)(66446008)(6506007)(64756008)(76116006)(66946007)(66476007)(316002)(6916009)(66556008)(122000001)(478600001)(26005)(55016003)(71200400001)(38100700002)(38070700005)(41300700001)(86362001)(7696005)(9686003)(2906002)(8936002)(8676002)(4326008)(66899024)(52536014)(5660300002)(7416002)(83380400001)(33656002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXdQU1FITmtNTWZYRElIRkRKVEJ4ZlJRWEZRejc1OFVIV2xWNzhtYkRaT0V0?=
 =?utf-8?B?bkdZUXFNUGYrb2VhOTRxdVFGU3Jqb2R0UmR3bEovTGhCSHREY3JvS1oxeTlP?=
 =?utf-8?B?R215RE9PeExLYmg1NURYNzZPTHBCREtlNjA2Ym01UXMzbm9USXQzQTZWdkRU?=
 =?utf-8?B?VUlhVThNNUp0ZTIxNW5rcVN0SzBZRlBpNXc5T1R5cVNVU0hYVHhscngvbUZQ?=
 =?utf-8?B?WlRPR2ZWSzBnNHVpMHNHRmFHbTNPVldFSENXRFhHU2JWZENhZUdTbXpCaUJ2?=
 =?utf-8?B?bmVFZzRZYmE2bTJEQlE2QjZNdktXRDI0SGJjK1htRUczUTVJUEc4MXNVKy9D?=
 =?utf-8?B?dVl5c0xxNVNaTEg1Nkg5bDhCV2NJQ2ZiKzVBSlBUYWFRSUZUOXErWHdEOHYx?=
 =?utf-8?B?UXZBN1NkcG1kYjV1Z015Ly8raGRubnBhZUtKWkJnbVBDZUsrWTJEQjF6MWx1?=
 =?utf-8?B?akRjTytnYXFVaHRDSzhsMDlDQTU3Rk1CVWdUWnlYNmVySnc4SEhucElJem9H?=
 =?utf-8?B?T3hXNnNvKzY2WldOdGYzMlducjM1YVJ6QkVhLzkySkNkcTVFSUVuRDErMFZX?=
 =?utf-8?B?bzhxR0VsQlR0cjVvV0cwVWtjK05UaE9oRW5Lb0xKNXErdEJ3N1NURWRGNmd0?=
 =?utf-8?B?QUFXRGZFMG42dzlGNXRLNU1xTDZuQmppY0RqdExPdjI4U3BQcjBRYWgyMk1q?=
 =?utf-8?B?alFvK01IdVI0QVVFUzZzV2ZQR3QyZGJkcDlVMHE5RkhBRHp1VHp6NUdNNlhK?=
 =?utf-8?B?aTYxRlRuYmprZ2hzQ010QTh2MTJ2MlhxZXFjOXdPajgvZ3NSbTA5Wnhpb2VU?=
 =?utf-8?B?bWUwMFZRZDRiaWM5ZmE1dkNCbC9KUFhaa21yRVlDZUNReVRqU3YzTTdzYnBN?=
 =?utf-8?B?VFp5cG1mczlTZkY1d28rUmllQjlVSG5mVGh2a0JiUG1SN0JOcU5BUTdrUGc3?=
 =?utf-8?B?OXNYa0szRUUyMzF2akh3d3N5S1RGNlRTRm10R1pWZ2RvRDZOcUI3cGtFUFAy?=
 =?utf-8?B?TWh3MTJxZmxrVloySlcyZkZlRmQvTXhSM0FzYVprbkVZbEQzVFdpRUx0SmlK?=
 =?utf-8?B?N1VVS21TQWpXVWJkNE0vYU1vU2RSdlNFQkx1cE9NNUJYWnlNTENEQlJSWXAz?=
 =?utf-8?B?d2pzZUNBenR6dmVJdy95SFNKeTc3bnZNWkZGY1VoTzJTZC9ERmUwdTlJL3F2?=
 =?utf-8?B?WlRDL0Z5VEs4VVAycG9sR1h4ck5RN0hjazNqWXRna3cxNlVyNXpVOHpVN2pN?=
 =?utf-8?B?aFZpdzNWcFZHeU5Eb3J3TzVsN2RiZDVxTDFHejBYZWJITW9yUnNZQzJJck5X?=
 =?utf-8?B?c1dmYTlDOEJ3NlZIT2NaanE0N3U2YUUzaGxBOC9pNlR3dWN2YzFOT0NacDAy?=
 =?utf-8?B?UFZUTEVnZW0veXpPVWNTY2FGNnRkaFdJRjZwQ01vaktYTktyY09oM2pQWkhn?=
 =?utf-8?B?QVRGL2N6WHhtNHkrcVlBZUNjeXBZRWRJWHhZUDFWRnBQRERTcTF1cVFUc2kz?=
 =?utf-8?B?VGZOdVlod2gxTzdMdmFqeFJSOHhaVjlCSzV0VS9SZWxFY1c2eUtoZC9Zbnp3?=
 =?utf-8?B?YVJvVWN3OFByZDJ3R0xvdWQ4Tk5ObHY0UFI0R3dqNFIycHc0Wk4wOXlvSkRZ?=
 =?utf-8?B?Z2lPanNBUms2aTNaN3V0MCt4MXo2MUxqUUpWakdtdUpmRVZiVDhEMUxrRU9q?=
 =?utf-8?B?YXhJanpUVkFDL0dPTmpkZXNnVWkzQVBiRkk4SmQ4Z1R2aU5CMzVxZWZnK253?=
 =?utf-8?B?TjBuMUlSdUdRWWhqbW9CWnVIaUVuQWJYRVlXdC80ejFla0drNXBtSmMzL0Zh?=
 =?utf-8?B?ZkV6TUh2N0tGK2RXaXJkelNXdGdFVUw3eUk2dDJ6OWVtbEFycXlQcm1VYUJv?=
 =?utf-8?B?SitFR2pTcnp4TTJQM3ZPMVZWQVV4bGVUUHVhY09XQlVnUUp3bjFDOFRUaUVN?=
 =?utf-8?B?MzVjekFOc2dxN3NsRnB2dXpqTGlldjF4b3NSM04yc3NvbUs4b3oyVEVQazM5?=
 =?utf-8?B?K0R4OWlVMzFtcElNTnNTY1VOdFg4WWN6WlhtaEZXcGdML2ZCWmlNbjM5Qm9y?=
 =?utf-8?B?a0hNM1R3Sm9vY2VLREozb3dKZWJ4bSsvWE1OR0tqd253THg4bEdRUTFMeEVW?=
 =?utf-8?Q?z+qYWG35KNv0VQdy0fe120dL+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814bd1fd-4a0c-42ce-69ae-08dba59be6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 18:48:41.2717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W49DjupnhlELvaOpGwwxOUS7DTQFFGpN9qAcnHu7/7k6SWYOduWYMtA7++rs6A1Tvskd00PBLDmBauBZJ8UyuYveGKts18VRhJ31ghqR8MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IElNSE8gYWRkaW5nIGZ1bmN0aW9ucyB0byBNTUQgbW9kaWZpY2F0aW9uIHdvdWxkIGZhY2ls
aXRhdGUgZnVydGhlcg0KPiA+IGRldmVsb3BtZW50IChmb3IgZXhhbXBsZSBMRUQgc2V0dXApLg0K
PiANCj4gV2UgYWxyZWFkeSBoYXZlIHNvbWUgS1NaOTQ3NyBzcGVjaWZpYyBpbml0aWFsaXphdGlv
biBkb25lIGluIHRoZSBNaWNyZWwNCj4gUEhZIGRyaXZlciB1bmRlciBkcml2ZXJzL25ldC9waHkv
bWljcmVsLmMsIGNhbiB3ZSBjb252ZXJnZSBvbiB0aGUgUEhZDQo+IGRyaXZlciB3aGljaCBoYXMg
YSByZWFzb25hYmxlIGFtb3VudCBvZiBpbmZyYXN0cnVjdHVyZSBmb3IgZGVhbGluZyB3aXRoDQo+
IHdvcmthcm91bmRzLCBpbmRpcmVjdCBvciBkaXJlY3QgTU1EIGFjY2Vzc2VzIGV0Yy4/DQoNCkFj
dHVhbGx5IHRoZSBpbnRlcm5hbCBQSFkgdXNlZCBpbiB0aGUgS1NaOTg5Ny9LU1o5NDc3L0tTWjk4
OTMgc3dpdGNoZXMNCmFyZSBzcGVjaWFsIGFuZCBvbmx5IHVzZWQgaW5zaWRlIHRob3NlIHN3aXRj
aGVzLiAgUHV0dGluZyBhbGwgdGhlIHN3aXRjaA0KcmVsYXRlZCBjb2RlIGluIE1pY3JlbCBQSFkg
ZHJpdmVyIGRvZXMgbm90IHJlYWxseSBoZWxwLiAgV2hlbiB0aGUgc3dpdGNoDQppcyByZXNldCBh
bGwgdGhvc2UgUEhZIHJlZ2lzdGVycyBuZWVkIHRvIGJlIHNldCBhZ2FpbiwgYnV0IHRoZSBQSFkg
ZHJpdmVyDQpvbmx5IGV4ZWN1dGVzIHRob3NlIGNvZGUgZHVyaW5nIFBIWSBpbml0aWFsaXphdGlv
bi4gIEkgZG8gbm90IGtub3cgaWYNCnRoZXJlIGlzIGEgZ29vZCB3YXkgdG8gdGVsbCB0aGUgUEhZ
IHRvIHJlLWluaXRpYWxpemUgYWdhaW4uDQpUaGVyZSBpcyBhbHNvIGEgdHlwbyBpbiBvbmUgb2Yg
dGhvc2UgcmVnaXN0ZXJzIHdoZW4gdGhlIGNvZGUgd2FzIG1vdmVkDQp0byB0aGUgTWljcmVsIFBI
WSBkcml2ZXIuICBBIGZpeCB3aWxsIGJlIG5lZWRlZC4NCg0K
