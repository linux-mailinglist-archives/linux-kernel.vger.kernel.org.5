Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13907DBA0B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjJ3MmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjJ3MmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:42:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C22DA;
        Mon, 30 Oct 2023 05:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698669727; x=1730205727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VJKpSDyintcXskKqTLrznqIhUPpCV6d0C1D7EH/0WUE=;
  b=QtbikIsjpRfDaXPFkZz0k2+4OuUmplvzHveedavuoKmPbM5rdsH9b+fn
   mbHEBM75yuwLN2IoE2JSZGUZzbnmONCArEV+jwid/7vbjn5e3nR6S8I/P
   0dVz7YVgBD0+usmkDnjPWL4HARAhlIylqA8Eukz7g1Do201HwRfFZB42x
   p+9DaFgExAaXdcuQjAJrABy16p0UMYwNInJspyBSvcONPyv1MRTQxJU/8
   1e50Ga4yqqb/QJtiytKL7BbD5NBlwkKcoNJfzbZzoHmUWvRK26RSewuyX
   hU81iypSWHFQkPHViYKy5Hs2LLIyj79pVrPnijxAwjHJ4SmAOOUiUtOpf
   w==;
X-CSE-ConnectionGUID: efD6gLaORsO95EMuKUneOA==
X-CSE-MsgGUID: 9i+pjYMJTlGbhQAVDsGRUg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="10902204"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2023 05:42:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 30 Oct 2023 05:41:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 30 Oct 2023 05:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqs8jRX1h/ud2YJRoD/Gytjuo8GgB8iUh8vBm0cc4jbPCaI2wO7ASEoQbGljgS5XEbVf7XzksgA09T20uPGPSBPcLSFG0zC8zXy8vP1sDVJVilKAisNY6FSqv1q64+11KcU7byW1bagdeHRb1JL5Am5vUqu15yvcTaKV6ipznUSwwF1qaVpp2ZlRKqyHkue4LRrk7tUTAlpImdNyXhSxA57wSJQC9+tPHoHdWCW4Jxspg3FvKfW59ni238nyzsI48Z0n9RS4bbI/yvRf7UIHcdlO3g+k6S7L2jwPI3Etyh1l0q2tzw6pl11jx5vb/A5EEd+amSZ00xdd4xNgt3fCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJKpSDyintcXskKqTLrznqIhUPpCV6d0C1D7EH/0WUE=;
 b=NfGGyJX6rJxvxKXL8weO3ICQFeXXE9pCh5Md2VSFVOTwrT0Yy/bZsGcWRjENGYYbvwrFHaoihtEkYEqH1YWhZGtwVALp7+mxB+G12DJDLTqx1f+tUojJlj+d621HjCP5YFvw7lpF2CMKvlyp8HEYBMohcHDJn4ur/tC2fMSyACAIXcrMHVPOBu9fX2Vmw61qPYMnCSal9z4tbLCJgZORPCCqwcNtI1n8jUikt4QP6rYrDU70R7zda/xa4sQ7w8Y0Jv5GYIv4QW4sSE8NB/t0+4DMKezwe21zPqb0drtgDjsOGTGhhgOnPOUPsXJ7GcRX/04khMqEwADmQxnTeqwJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJKpSDyintcXskKqTLrznqIhUPpCV6d0C1D7EH/0WUE=;
 b=DmN2zhZhwsEzFPEf3LQsF5UQzPDvVnMaZJQRZz0gtEgKPp1hJAqcUT1a/MbaoTAcki3bAbhl2oRz3QVDV/bcCqwooMQ1TE2zPDUbnfpvQhhTTvzlKJfW+1Tt7krv/j2mM1OhUPdfC5rBLkv5yJqf0+uzgrpLz4yBJOQJ7KzqFps=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 12:41:49 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.022; Mon, 30 Oct 2023
 12:41:48 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <robh@kernel.org>
CC:     <Thorsten.Kummermehr@microchip.com>, <casper.casan@gmail.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <kuba@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <linux-doc@vger.kernel.org>, <horms@kernel.org>,
        <pabeni@redhat.com>, <andrew@lunn.ch>, <rdunlap@infradead.org>,
        <Horatiu.Vultur@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <Woojung.Huh@microchip.com>,
        <netdev@vger.kernel.org>, <Steen.Hegelund@microchip.com>,
        <corbet@lwn.net>
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
Thread-Topic: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's
 LAN865X 10BASE-T1S MACPHY
Thread-Index: AQHaBciQjBoWnY4j9k2nUOrnZEADaLBXpI2AgAqsyoA=
Date:   Mon, 30 Oct 2023 12:41:48 +0000
Message-ID: <8672933b-0840-47bd-8211-93fa56c03116@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
 <169808266366.861355.6966014557522700866.robh@kernel.org>
In-Reply-To: <169808266366.861355.6966014557522700866.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA1PR11MB5923:EE_
x-ms-office365-filtering-correlation-id: 23fc15f2-fc1a-42d1-3e8d-08dbd9459596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0QOkAc/NHA4hzIcVDdLjvGYyt3lMLKWykoZ9zRjutbzr/PNokoUpakYIenRCcoJuy6HMySvT5YFHedIpzncTIx7kIJOQOHbtjXcuJpjLh3SDQlMYCbC5/v37UJ4mDGlFjCr9KZl48Dt3Ibj8+3/LTabFm/tWxejtzh0XhVu3J6RKzC78gxGFKxDFTvMAVMx3U9qiNzSu5JrLsD6NoJyctcJdSPPeIf5h0Rk4ODHXVL2aQK195U/NHABTz0Wk9/V4xApbEtQS8ov8KQgTo32uzkHjrQI4WEc3ve0/zqToNxUxMAWax+uQtwIJpTh/UL8ccjf31jlguIgZPVfCDdQGkfZoTlN6T7q079KA9hy3mTh6w2NQPSzuz3KV4lbsCmXlkpvgmDp2ITLn3W5OqcXUf1RF+zWXjYid/O1ddEWLa4gPbCYaSbN1jL54fPTUwptjXN0XBUYYQpzic1tNE2S6SudTJJcEHW1y4+z7rfVPuXcv50a6gXZPedGkeIzq4Hq5OCI23fto+lprv3eKqUwpjadChk/gl1i+O70J8d30PdUcaC5uHR4xBC+ZU6WoKGUB/fwrxlGIHI6ZXoN+tuDXI9vRbuWj+k7hCFPvB6rrS0MtR+bvQAJZVQgDsbcMK6l7b2w8vmF6Es9HLzE7W2OA0Q+5gABucSThZH8J5Qa5kL45NZo2/Vemv1wFJSWjOPquOVgOxk3Vw+4JvW/q9Dj74g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799009)(6512007)(26005)(2616005)(53546011)(478600001)(71200400001)(6506007)(83380400001)(6486002)(7416002)(2906002)(91956017)(966005)(66946007)(76116006)(5660300002)(41300700001)(66556008)(4326008)(66446008)(8936002)(66476007)(8676002)(6916009)(54906003)(64756008)(316002)(38070700009)(38100700002)(122000001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFHbWdKbzdNN3dNVUtxUW1wOGlHWVg3THhyODhZc0ZWaWRja3pxeno5M09F?=
 =?utf-8?B?NUJDbmsxamFGSS80ZFdWSFJHUnhZM09kOFE2dExuRjJKbUlCZ0ZGQUtyVTAz?=
 =?utf-8?B?ai9USGNQTENsS3RIM0FPbGg5SVV4L2lRaDB1Sis2Tm10U2d4cENWbWhmQmIz?=
 =?utf-8?B?V3loMzVYWnIxL2ZRYUQybENacUUxb29KamJCREpxeCszN0R5SEVXTGh6RFRn?=
 =?utf-8?B?b2l6ZDJocW4zVUlFaiswUFFva29KK2N3WVFkZzlveU9vRC85Um11eUkwVlg2?=
 =?utf-8?B?MHRUbHZyY2lCVEhDdGFpcTFmU3k1Ylp3UW9vRDFCdmlCTTdFL2JZV2szTldk?=
 =?utf-8?B?R0pKdEI0QXN4VHR2alhocmdyeDZkeGVoNXhNYklMOVc2OENhVUp6eGVHZEdz?=
 =?utf-8?B?MnRCbGVQcjZQWGZRV3hJNFV0c1B3KzdEUVRzNUNtSWgzalNSNkFxc3MyVnlZ?=
 =?utf-8?B?Q0pmaGpST2NkZHVUUFg3S3ZTMFVJQnFUMU1rZ0dZdmVGTXBycVZQY3crR1oy?=
 =?utf-8?B?K2FrZDJwUWtocXZ0V1l2bnNLcitOaHVDdVFyK3V5RmVxank0ZVdkVlVXVGZV?=
 =?utf-8?B?SENIck5sTEx5bEJwbDArMGF6dnN4Qk5yakZjdk5rWkVlYnJGeElNWjQ2SlNB?=
 =?utf-8?B?NVNKRzkyZ215MmlySEpCM3Nyd21jTnV6WlhiSjNjZ29hM0JpbjZNWWFaa05z?=
 =?utf-8?B?WWVNTVpmcEdqOWFDWXBNdlV4cU9pcCswaEM0akRvNjhKK05iZEIycTlLKzZr?=
 =?utf-8?B?MzdTd2RRZWpCd1ZFaU84K3psTm5xd2hoZW5WQy9tU1pWMEVxdUhvWDdiaCsx?=
 =?utf-8?B?MHVrSFJlREo1VmtUUVBZMlI4VDljRER3bnc0UDI1SWdCQlFSZ1IvSHZNcmpV?=
 =?utf-8?B?TDdpeTN3TWhPMXA3SjIzZkVxOWdaWkZWalJ2ZkVHKyswZFhCQ0tpd1NaVkQv?=
 =?utf-8?B?Y2JZV3JqM1ZBcDd1a3BKeFFCOFFkSWFockhIUjVpZkhNUjEyU0tpbU51OHVO?=
 =?utf-8?B?elQ5TXdRYUNNMHpld1NwVHZaU0cycmVOZHp6d25JUHRJUTJDS2NUWThvTHFR?=
 =?utf-8?B?ZSsyRnlYMk1wMXp0VHd3KzV1Z09VR3pQWVZ1eUR2MnoxNjRmZEcvM1BOL0Vu?=
 =?utf-8?B?RkowejJJQzNZQTVwZkNTQWlCUERDUDVLYjBUczVTMUxFeVVSOEY1MDVDUkFR?=
 =?utf-8?B?Z0trc2dSVnRQbzJUb0VoQnBvM2J3bFkycDVxK2p5Lzg5ZmlYa09maDdRODNZ?=
 =?utf-8?B?K2pla1gvQXlHZUV3cEo5OUFIK3hFYzRYbkZlc251NnlDZi9nVE1kK1FlSllk?=
 =?utf-8?B?N2tJQkZxMDRTYkdQaWlrb3o5Z2kydnZBM3ZsbGwzbEFVVEx1OW5pcFBVWEZi?=
 =?utf-8?B?LzNlMzFNSzVBUlpPaFZHWjNkQUtabkIycUFNcVBoVk5HZjRSYXUwY2xQUVBD?=
 =?utf-8?B?M1FpbFhoZjJYMnUwNTMwT1pNc0k0eFdmSTRNVHlYREtIUzNSbU5oTGgyRVZa?=
 =?utf-8?B?VDVQUVlCbVgzREdHc1NLOGxrelJtbU1mc3d1ZzNkeGVzK2hycnV2bUpFM1Vt?=
 =?utf-8?B?clNFTVgwRG96YlI2cUhiOGYya2sxbUdsY0FMbFRoYnBhT204VXIwL0xlZGFm?=
 =?utf-8?B?SURZeXMrdE5iQ0hJd0VaeGc0YnRFQWpsVVc0VU5PU0dHcjYyZ3J6L1h0VXJ6?=
 =?utf-8?B?WmVtaXplYWo1djJvT0RlOTJCQXJQWTRMWWh1RmZ1cEQxcm9pUEdzNXRsMkt4?=
 =?utf-8?B?UzhsRDVRdUlBaXFuYzVxTVNURzhzYzhBQm56WENtWGpjWjVDMXJFMHllYTdY?=
 =?utf-8?B?SVNITEVwSWd2T09mSDBVOExJbnRXakpqMnFrUXN2MGQyYmJSY2ZJQjRyMlZ2?=
 =?utf-8?B?WGM1dnlBNVM4SkFXUWhLbFFwZ1RnbWRWOXYxazlERWpqcXhFcEdHNmR0b0JV?=
 =?utf-8?B?QjRVcWFyQk9vbmNOK0h2ZHZZdS9uUm1pVVpvQVQ1RGU4UTJPNGNMcWJjQ1Bk?=
 =?utf-8?B?cUF5bzNWeG1Pc3lNbUp3ZU9ZNEdCWE9RN25tdGg5dHN3QURSaGE0UDZPMmh5?=
 =?utf-8?B?MFQyU3djbjQrZ2FGcVR6eUdPZHUvVnc2VDh1Ti9lRk1sd1hzdzNNdy96Mmdr?=
 =?utf-8?B?UHBUTW9uWi9maG03V3Y3eUo3azVxenBhNFV2YlVOQW5teUltQjJCZFF3NER4?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <937EB3D9141CC143B77B0A4DDF9FFCEC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fc15f2-fc1a-42d1-3e8d-08dbd9459596
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 12:41:48.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDTlYNd5NcNpwb0tuMTOpCNlIeLA5k4h+0hYMxjJhrsQ7bAZUnATf1fIxs2kO+W0ZFtpWhWo9pwqd+DRDNXfY8dFQ7/4XdChL4prHJMNa5KSSRgnJgEYBc5Pl6bGz6sR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIzLzEwLzIzIDExOjEwIHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIDIzIE9jdCAyMDIzIDIx
OjE2OjQ5ICswNTMwLCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBBZGQgRFQgYmlu
ZGluZ3MgZm9yIE1pY3JvY2hpcCdzIExBTjg2NVggMTBCQVNFLVQxUyBNQUNQSFkuIFRoZSBMQU44
NjUwLzENCj4+IGNvbWJpbmVzIGEgTWVkaWEgQWNjZXNzIENvbnRyb2xsZXIgKE1BQykgYW5kIGFu
IEV0aGVybmV0IFBIWSB0byBlbmFibGUNCj4+IDEwQkFTReKAkVQxUyBuZXR3b3Jrcy4gVGhlIEV0
aGVybmV0IE1lZGlhIEFjY2VzcyBDb250cm9sbGVyIChNQUMpIG1vZHVsZQ0KPj4gaW1wbGVtZW50
cyBhIDEwIE1icHMgaGFsZiBkdXBsZXggRXRoZXJuZXQgTUFDLCBjb21wYXRpYmxlIHdpdGggdGhl
IElFRUUNCj4+IDgwMi4zIHN0YW5kYXJkIGFuZCBhIDEwQkFTRS1UMVMgcGh5c2ljYWwgbGF5ZXIg
dHJhbnNjZWl2ZXIgaW50ZWdyYXRlZA0KPj4gaW50byB0aGUgTEFOODY1MC8xLiBUaGUgY29tbXVu
aWNhdGlvbiBiZXR3ZWVuIHRoZSBIb3N0IGFuZCB0aGUgTUFDLVBIWSBpcw0KPj4gc3BlY2lmaWVk
IGluIHRoZSBPUEVOIEFsbGlhbmNlIDEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRlcmZhY2Ug
KFRDNikuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFydGhpYmFuIFZlZXJhc29vcmFuIDxQYXJ0
aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGlu
Z3MvbmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwgICAgICAgfCAxMDEgKysrKysrKysrKysrKysr
KysrDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWlj
cm9jaGlwLGxhbjg2NXgueWFtbA0KPj4NCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmlu
ZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2snDQo+IG9uIHlvdXIg
cGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToNCj4gDQo+IHlhbWxsaW50
IHdhcm5pbmdzL2Vycm9yczoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWw6MjE6NTM6IFtlcnJvcl0gc3ludGF4IGVycm9yOiBt
YXBwaW5nIHZhbHVlcyBhcmUgbm90IGFsbG93ZWQgaGVyZSAoc3ludGF4KQ0KPiANCj4gZHRzY2hl
bWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gbWFrZVsyXTogKioqIERlbGV0aW5nIGZpbGUgJ0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXguZXhh
bXBsZS5kdHMnDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9j
aGlwLGxhbjg2NXgueWFtbDoyMTo1MzogbWFwcGluZyB2YWx1ZXMgYXJlIG5vdCBhbGxvd2VkIGlu
IHRoaXMgY29udGV4dA0KPiBtYWtlWzJdOiAqKiogW0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9NYWtlZmlsZToyNjogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25l
dC9taWNyb2NoaXAsbGFuODY1eC5leGFtcGxlLmR0c10gRXJyb3IgMQ0KPiAuL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbDoyMTo1Mzog
bWFwcGluZyB2YWx1ZXMgYXJlIG5vdCBhbGxvd2VkIGluIHRoaXMgY29udGV4dA0KPiAvYnVpbGRz
L3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbDogaWdub3JpbmcsIGVycm9yIHBhcnNp
bmcgZmlsZQ0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToN
Cj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvZGV2aWNldHJl
ZS1iaW5kaW5ncy9wYXRjaC8yMDIzMTAyMzE1NDY0OS40NTkzMS0xMC1QYXJ0aGliYW4uVmVlcmFz
b29yYW5AbWljcm9jaGlwLmNvbQ0KPiANCj4gVGhlIGJhc2UgZm9yIHRoZSBzZXJpZXMgaXMgZ2Vu
ZXJhbGx5IHRoZSBsYXRlc3QgcmMxLiBBIGRpZmZlcmVudCBkZXBlbmRlbmN5DQo+IHNob3VsZCBi
ZSBub3RlZCBpbiAqdGhpcyogcGF0Y2guDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2Ug
ZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0
aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVw
IHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0K
PiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBjb21t
YW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQgdG8g
eW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4gSG93
ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIgc2No
ZW1hLg0KU29ycnksIHNvbWVob3cgSSBtaXNzZWQgZG9pbmcgdGhpcyBjaGVjay4gV2lsbCBmaXgg
dGhpcyBpbiB0aGUgbmV4dCANCnJldmlzaW9uLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4g
Vg0KPiANCj4gDQoNCg==
