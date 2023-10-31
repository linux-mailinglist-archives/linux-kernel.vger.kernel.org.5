Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF04F7DCAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbjJaK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjJaK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:26:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AF83;
        Tue, 31 Oct 2023 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698747985; x=1730283985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gt/wFy01CxJP9ANMC2BramLnzSOkrON6pITg0tlGXiA=;
  b=iHGr+WisJGSDvFmXwezmRZxCMVUfy8dWeVCGyTjHcmVMLB+pO284Z8HT
   zUYhrboftQwT6yiYhrLoZ3Y2BmAnDfpmDCjKRvriY5IAGNp7NRMIAO4uT
   3wK/kJtPpnHiF/zHhW6eWHM8KMZwCoIKypfCjVJ9FZmYvI9Jcr6VFnwv5
   TPqTj/eSvI/JD4G4UpOQnuQsBOOL3esURinvnTJpU6E7zNL6zye+2xGf9
   wNsFO7doovo5nZkiqAqKjLJB93KRuTyELV47cO0hP1h4rVON+5ZZ136T5
   2npMtMunWV30jiQ1WNjz9kChk2PryYlVXhRYtmyxV+0mLPigH5WX44F29
   A==;
X-CSE-ConnectionGUID: ldT3ywleTZmi6kSb46n4lw==
X-CSE-MsgGUID: kPMlXRmxStmkL80X+okDkg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="11495874"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2023 03:26:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 31 Oct 2023 03:26:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 31 Oct 2023 03:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdM2c2tTBh2O0+NHxcxTJ03BI6SMBAZRg12kqSnNEs+jcSAYoO4VKFAq3cfb7TGIwMLPCRc7ro6IiiNHceyWvmFc1vqrsUEz98MPFeVB6opgW9LqHOToWu8Xo1cK5fozVfhv6o55aUE6twwzc71PQW+kQTQ+1UgqRn7gbLBaKByhR7KFYT/AX6ca2cCs5CX0q1TThMRzzT67wQ7nbSdJ81/26zI8f2LOcQbznkh4XFyP+tYQofu5AlUb/7/PyiTATBAtjbkuFUe4cH798IEAqsTfPWR7Qi9gJ4n5ZBgf0Vl/IZJvrLDIO/C17XxKhVD4dJE65YA8/AUdINgquSRhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt/wFy01CxJP9ANMC2BramLnzSOkrON6pITg0tlGXiA=;
 b=Qk0evjw1cuC6FpyY9FjE8dKHuaL1x/Tdcn0MT5nJ0GnzzsCz90gR7UQWhuHDCepzqilXn83gtz72JJ3Ag9v3/YlhDuzbLCj/L1l62muAX1KdmFpi8QU53+nbNKMKUr4tWmC8nR6ElJLU6A1qCkNwCTny8HVdJFmC79geMC8DmNZi1LWRx1GVmIePx9hxmpcxiqquPxksTHt3sAnJUbXf60mzE8L1wgLlU6QCXK9X9ds3FeXEqRG6eQNO4QqhbfL4t4/hS2aX4vctYZ6oh32fQsY+m6hy/t9VaxU/ilg4r+2Sf5uq+Fs3CaLQD8k0yKV07mzp5Qr3fu8NgJmJpQHALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt/wFy01CxJP9ANMC2BramLnzSOkrON6pITg0tlGXiA=;
 b=aPrA1jATY8g6oVPUBYovz5bsXkbVIJgbyq4GmsDOkqtQkJgCKVGlVrjkfnQZYSbF6ZclNdjucTABYH8RmjkkPYR8tt5G1XfzVifNBOBbHZ+FzEReKVBpJ/WrLT2lT3BM0+QvubJGTUhD6SpOsFjxBaw5PoEmIQagw7xo1UirHHs=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Tue, 31 Oct 2023 10:25:57 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 10:25:57 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <krzk@kernel.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <Horatiu.Vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>,
        <Steen.Hegelund@microchip.com>, <rdunlap@infradead.org>,
        <horms@kernel.org>, <casper.casan@gmail.com>, <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHaBciCW59pjIMQmUKn/gKExYJHR7BY1ueAgArm0oA=
Date:   Tue, 31 Oct 2023 10:25:57 +0000
Message-ID: <60fabe51-b682-479a-a528-74cf8af20309@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <59767fb8-8b9a-472a-884c-009cb00ed0b9@kernel.org>
In-Reply-To: <59767fb8-8b9a-472a-884c-009cb00ed0b9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DM4PR11MB5424:EE_
x-ms-office365-filtering-correlation-id: 30db3a7a-3a08-455a-5ebf-08dbd9fbc580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWwl3K7LzdRCOimLvau9vFOynpcsQt6qJJKi6x6ghi6ayawfuVcJvNNjkt+7ZnMoF9vbdcJv2tCLLKvLz7voLuJk0uXU8akmuDPBUsw//GvOJVnIV+X1DIcbqHpeuwMlfkk68FoTPWAbbJ5IOMVyGILmTdmYhM8q1jSs2TwLLFAhxJhrbPS+n2efIfl35I/TlkVgqE+TMsOiKAerfPiSIcIZ6QKJ2VaRDeoJf9PPy3duCv55UaDMySTVa5lSpFPJgM/nkVFrPbBfMmdg1zbC1UqIeIAylbzMgPYOvl94LRwPSDow00dhxHNDfRotMq0343nNNV58vYzMmrYDIV6VpT0cYOJ6OpZaxG9BUNF0KZmrzwwv9113plrf0sfnse6hkaIEqzca/y0w43nNmlXJ0O02UWQpRIKcV+wrJ4DqT6v2b6WoBZGDQ3B0148egQjM3aB5Juxoar9JI8nBnrIe/rn+fJOcVSaLb2Qiv+6xl1us8MhzGkEPU8fWK+l+8UqUnUyf35Q964adDHKpaNgpEdM7z2tdRhsLUzbssa9sy4VD4O0+Mvpy8SdpZUw5bDpyap/GsaU8YPMiOrNe+NzZr62s9cVkkqxTrlm/3BNHT6CsNpXVKjRCwk4Rw3CYAzMgBH2kIoZ1e+pyVWOYDAvVPD5P5L/8l1SQOCrmkZ4xfa6PlbZpm4JA4XE7V7/QmrDcYV4DPOg47uAkEFM8TmQDDoxG/EHeFPbPV57vaM4O0Us=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(2616005)(6512007)(26005)(4326008)(6506007)(478600001)(83380400001)(6486002)(7416002)(2906002)(53546011)(66446008)(66946007)(41300700001)(66476007)(91956017)(66556008)(71200400001)(76116006)(8936002)(64756008)(8676002)(6916009)(5660300002)(316002)(54906003)(38070700009)(36756003)(38100700002)(31696002)(86362001)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFRYMGpBMnl5VlZtVUhSQTFYOFR4enBIdHFTU3hhNjVZNzh1Z0FyRmwzRTZo?=
 =?utf-8?B?dDdMWEFSZm9IMUdIVHB3VDdmWUMyQXpZTHVpS2ZBaVg2Vk5zUDlCa1pVRVNV?=
 =?utf-8?B?SndoNXZ3NGw5NysxZWtieWR0bkYyYk5uWHliTkNJMC9qK1c4MGJqWTVSd2Vt?=
 =?utf-8?B?bURlL0JraWtKOUhGRE14VjkyWkxzT0xyN3YwRmpDYWIxc2VJSTRmYVJPV3VT?=
 =?utf-8?B?aytyK2QrejhkS0NXTC9HRmVRQU15MFZXQmFEMmo3ZTZSUjNVZ3liU1pReVds?=
 =?utf-8?B?Ri8zKzBSTFAzR2FXVEk4T3JRa1lEK0s5bmM5OW40Z2hWeFNGNEdiNzlXOHdL?=
 =?utf-8?B?TUpqZkdzRWlldnQvay8wZkxSaVA4RmlUZjhQbGw4ZElPZUwxWDU0WjhGZVAy?=
 =?utf-8?B?Y3AzaG5vaUVuNE5ZbGpPZWUwK1VhTFcyL3ZyNXd4UjZlVkc2RVVMbGFaOGtS?=
 =?utf-8?B?V2NwU0ZpVFRCYUN2bm5PcW1oa3JIV2laMVdtdXNuVkNweXB3NTYySmwrT01J?=
 =?utf-8?B?V05iWjBrb243WWtQeE9lSzJabFlEM1ZoZmFMTlR2YXRZZ1dKMXZnUmhWMmEz?=
 =?utf-8?B?TnI0TWRTeGtoV3UyUzhhdTJvNnE5QzJjOEhIZ0pjcWd6N3JwQU9TUjcxenVZ?=
 =?utf-8?B?d3RHc0tJTnhuMkxuWE9TQ0xhei9UMGQvNkxabWhWWlU0R0hEK2RqQXQ0cHlF?=
 =?utf-8?B?M3Y4RE9aNGRIYUlCQlNNUWRSUVZCSTRyRnAvYk5aV0JmN0liNTRIOHUveXBt?=
 =?utf-8?B?aWZvc2xsbERCSnp4VDU5VjB3NENxUUhYT08xaEx2bU1SZUhndWc0dUhidHp2?=
 =?utf-8?B?WGhlL1g5NnVwK0g3WnRoOGZ3a2xka0V2UVBzSEJZSEZtYmE0RWpsWno2TGNo?=
 =?utf-8?B?SUpaUmdkbGVVUWJranRqblAvOWNBd2dYSWJSamgwTXdZeHI2Rmp4MU9QRzAy?=
 =?utf-8?B?UnlUQmJoVG5LeTBOK01tcGFVeHk5ODFITS9SOHVRQ3I4UHRuS0ZLb3FJcjZu?=
 =?utf-8?B?Y1Z4TXRTcnlVRVB1NGgwNGJjWW1qSUgrbUk5dlJEOEEvRkhIek0rdkV1K1c1?=
 =?utf-8?B?MXo4NXEzVWxqRjZMR25RZ0hoKzJCWlpyZVZxSy9WRThFTmNxdktRaURMUVBx?=
 =?utf-8?B?VWcrRzJkUjhwR3gvMXVyanUySUVjZHNOR2N1NndpUlhBK2libm9tYUZHNHlW?=
 =?utf-8?B?dURjUUZRdVdjaHFBa0gxZFlqdC82S2tRTGNyaGxGbW9FYjBlaFgzRWtXQzZ6?=
 =?utf-8?B?Q2c3eVNFL1dYeitGdkk3MlE1emRnWmh1NnFXdWhHOHdCdFZQTzNZM1Z6bEFS?=
 =?utf-8?B?Zm5EOVhLWVVWbWFuU3BDejUzN0lPN2EyL29Cc0FNNDRlZmZZeVZrdmNCa1RZ?=
 =?utf-8?B?QWN3Tk9IbU8zaEFXQ0NxUE1lb0tjY3YzYXhNNnA5a1pvOFdPMmN4ZjQ5Ymk5?=
 =?utf-8?B?MjZqTnRaeDYwQ0JhRmF4NlAyN2NrU24yRjJiREN0Tk8rdXh6M0JTaDNiNWRv?=
 =?utf-8?B?RVNqVFRyS3FaeU9oMmJrWnFSc3VYd0lmdzNZL09DQU9YUGd0ZzBRK2pXV3VY?=
 =?utf-8?B?OW1jdHZNdXVpZFUxdXBjZFhRYlF0ckxwSCtDakE4aGNkWVY3VXZJc0JSNTlD?=
 =?utf-8?B?RndrOFBTa1U1V0gydWd0VU50MTJQVVFVRWpmY1Z0WkN3endHdFE0K3JzY00w?=
 =?utf-8?B?eGg1YkE3SlBNem5DMnNWc2VPK0gvYTlFTGw2emlIWlNqKyt6S3BENlpUUDJS?=
 =?utf-8?B?T1Z2S1BDSlU0S0c4YXJLTE4wTmQ3M1VtZzdlMDZNWldITXdXTmtTdURBNWlO?=
 =?utf-8?B?UmRsL1VOc1AwNjBXUXRQOUZjWVdmRjRFZlNydGxudTczZ1BFV3h3NCtVbGlv?=
 =?utf-8?B?Yk9xSkc4YWsrcytCM2dyYUJNOVhqcjRINnB2Z2lxcmdOWE4wMlh0RFdGQ3po?=
 =?utf-8?B?b3FXUWtNSzMyYWFCbElKTlZCTU4xWTFsdWtPQ3VFbWV3VHJqcjBUdlJlaDE1?=
 =?utf-8?B?QTY5TUFMcmQxdFhsT0twdXlvc2ROSU1EdGx3NVg3S3pKRW5aUHNkR05tcUto?=
 =?utf-8?B?dGprUWVQTWJCK2ZWdEJFWlFRNmlHUVVYcXJESVNSSlJDN0FidXhDZmVaYkFF?=
 =?utf-8?B?T3lzM1JRUk14d3d2RENjNHBXbWJIUXFvUy8ya05VendDeXk3OE94cXVYUW1v?=
 =?utf-8?Q?MJ/e1uZ4pkxzBuUZ0UfQQ3I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9995823499B26645BB94BB7078F57A37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30db3a7a-3a08-455a-5ebf-08dbd9fbc580
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 10:25:57.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8MSbBvKx6apCYf5zt4Z3R1YVATk0rRTdZZU8v6W0FQ4u691H2TwnN9se2kJZWYTccki9+NsfFy7NBWvWi/1qTh8/lP2uzbHLwR7RyIsUNSd0pdD+bJL0lh8cQ40Z0s3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5424
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiAyNC8xMC8yMyA1OjI3IHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIz
LzEwLzIwMjMgMTc6NDYsIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiB3cm90ZToNCj4+IFRoZSBMQU44
NjUwLzEgaXMgZGVzaWduZWQgdG8gY29uZm9ybSB0byB0aGUgT1BFTiBBbGxpYW5jZSAxMEJBU0Xi
gJFUMXgNCj4+IE1BQ+KAkVBIWSBTZXJpYWwgSW50ZXJmYWNlIHNwZWNpZmljYXRpb24sIFZlcnNp
b24gMS4xLiBUaGUgSUVFRSBDbGF1c2UgNA0KPj4gTUFDIGludGVncmF0aW9uIHByb3ZpZGVzIHRo
ZSBsb3cgcGluIGNvdW50IHN0YW5kYXJkIFNQSSBpbnRlcmZhY2UgdG8gYW55DQo+PiBtaWNyb2Nv
bnRyb2xsZXIgdGhlcmVmb3JlIHByb3ZpZGluZyBFdGhlcm5ldCBmdW5jdGlvbmFsaXR5IHdpdGhv
dXQNCj4+IHJlcXVpcmluZyBNQUMgaW50ZWdyYXRpb24gd2l0aGluIHRoZSBtaWNyb2NvbnRyb2xs
ZXIuIFRoZSBMQU44NjUwLzENCj4+IG9wZXJhdGVzIGFzIGFuIFNQSSBjbGllbnQgc3VwcG9ydGlu
ZyBTQ0xLIGNsb2NrIHJhdGVzIHVwIHRvIGEgbWF4aW11bSBvZg0KPj4gMjUgTUh6LiBUaGlzIFNQ
SSBpbnRlcmZhY2Ugc3VwcG9ydHMgdGhlIHRyYW5zZmVyIG9mIGJvdGggZGF0YSAoRXRoZXJuZXQN
Cj4+IGZyYW1lcykgYW5kIGNvbnRyb2wgKHJlZ2lzdGVyIGFjY2VzcykuDQo+Pg0KPj4gQnkgZGVm
YXVsdCwgdGhlIGNodW5rIGRhdGEgcGF5bG9hZCBpcyA2NCBieXRlcyBpbiBzaXplLiBBIHNtYWxs
ZXIgcGF5bG9hZA0KPj4gZGF0YSBzaXplIG9mIDMyIGJ5dGVzIGlzIGFsc28gc3VwcG9ydGVkIGFu
ZCBtYXkgYmUgY29uZmlndXJlZCBpbiB0aGUNCj4+IENodW5rIFBheWxvYWQgU2l6ZSAoQ1BTKSBm
aWVsZCBvZiB0aGUgQ29uZmlndXJhdGlvbiAwIChPQV9DT05GSUcwKQ0KPj4gcmVnaXN0ZXIuIENo
YW5naW5nIHRoZSBjaHVuayBwYXlsb2FkIHNpemUgcmVxdWlyZXMgdGhlIExBTjg2NTAvMSBiZSBy
ZXNldA0KPj4gYW5kIHNoYWxsIG5vdCBiZSBkb25lIGR1cmluZyBub3JtYWwgb3BlcmF0aW9uLg0K
Pj4NCj4+IFRoZSBFdGhlcm5ldCBNZWRpYSBBY2Nlc3MgQ29udHJvbGxlciAoTUFDKSBtb2R1bGUg
aW1wbGVtZW50cyBhIDEwIE1icHMNCj4+IGhhbGYgZHVwbGV4IEV0aGVybmV0IE1BQywgY29tcGF0
aWJsZSB3aXRoIHRoZSBJRUVFIDgwMi4zIHN0YW5kYXJkLg0KPj4gMTBCQVNFLVQxUyBwaHlzaWNh
bCBsYXllciB0cmFuc2NlaXZlciBpbnRlZ3JhdGVkIGludG8gdGhlIExBTjg2NTAvMS4gVGhlDQo+
PiBQSFkgYW5kIE1BQyBhcmUgY29ubmVjdGVkIHZpYSBhbiBpbnRlcm5hbCBNZWRpYSBJbmRlcGVu
ZGVudCBJbnRlcmZhY2UNCj4+IChNSUkpLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJh
biBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+PiAt
LS0NCj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNiAr
DQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9LY29uZmlnICAgfCAgMTEgKw0K
Pj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvTWFrZWZpbGUgIHwgICAyICsNCj4+
ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXguYyB8IDQxNSArKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDQzNCBpbnNlcnRpb25zKCsp
DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAv
bGFuODY1eC5jDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
Cj4+IGluZGV4IDk1ODBiZTkxZjVlOS4uMWIxYmQzMjE4YTJkIDEwMDY0NA0KPj4gLS0tIGEvTUFJ
TlRBSU5FUlMNCj4+ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMTQwMDEsNiArMTQwMDEsMTIg
QEAgTDogICBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+PiAgIFM6ICAgTWFpbnRhaW5lZA0KPj4g
ICBGOiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW43NDN4XyoNCj4+DQo+PiAr
TUlDUk9DSElQIExBTjg2NTAvMSAxMEJBU0UtVDFTIE1BQ1BIWSBFVEhFUk5FVCBEUklWRVINCj4+
ICtNOiAgIFBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3Jv
Y2hpcC5jb20+DQo+PiArTDogICBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+PiArUzogICBNYWlu
dGFpbmVkDQo+PiArRjogICBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC5j
DQo+PiArDQo+PiAgIE1JQ1JPQ0hJUCBMQU44N3h4L0xBTjkzN3ggVDEgUEhZIERSSVZFUg0KPj4g
ICBNOiAgIEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCj4+ICAg
UjogICBVTkdMaW51eERyaXZlckBtaWNyb2NoaXAuY29tDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL0tjb25maWcgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
aWNyb2NoaXAvS2NvbmZpZw0KPj4gaW5kZXggMzI5ZTM3NGI5NTM5Li41OTZjYWY1OWRlYTYgMTAw
NjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvS2NvbmZpZw0KPj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL0tjb25maWcNCj4+IEBAIC01OSw0
ICs1OSwxNSBAQCBzb3VyY2UgImRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW45NjZ4
L0tjb25maWciDQo+PiAgIHNvdXJjZSAiZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL3Nw
YXJ4NS9LY29uZmlnIg0KPj4gICBzb3VyY2UgImRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hp
cC92Y2FwL0tjb25maWciDQo+Pg0KPj4gK2NvbmZpZyBMQU44NjVYDQo+PiArICAgICB0cmlzdGF0
ZSAiTEFOODY1eCBzdXBwb3J0Ig0KPj4gKyAgICAgZGVwZW5kcyBvbiBTUEkNCj4+ICsgICAgIGRl
cGVuZHMgb24gT0FfVEM2DQo+PiArICAgICBoZWxwDQo+PiArICAgICAgICAgICAgICAgU3VwcG9y
dCBmb3IgdGhlIE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2LkIwIE1BQ1BIWSBFdGhlcm5ldCBjaGlw
LiBJdA0KPj4gKyAgICAgICB1c2VzIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBTZXJpYWwgSW50
ZXJmYWNlIHNwZWNpZmljYXRpb24uDQo+PiArDQo+PiArICAgICAgICAgICAgICAgVG8gY29tcGls
ZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZS4gVGhlIG1vZHVsZSB3aWxs
IGJlDQo+PiArICAgICAgICAgIGNhbGxlZCBsYW44NjV4Lg0KPiANCj4gVGhhdCdzIG9kZCBpbmRl
bnRhdGlvbi4gS2NvbmZpZyBoZWxwIGdvZXMgd2l0aCB0YWIgYW5kIHR3byBzcGFjZXMuDQpBaCB5
ZXMsIHdpbGwgY29ycmVjdCBpdC4NCj4gDQo+PiArDQo+PiAgIGVuZGlmICMgTkVUX1ZFTkRPUl9N
SUNST0NISVANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAv
TWFrZWZpbGUgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb2NoaXAvTWFrZWZpbGUNCj4+IGlu
ZGV4IGJiZDM0OTI2NGU2Zi4uMWZhNGUxNWEwNjdkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWljcm9jaGlwL01ha2VmaWxlDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9taWNyb2NoaXAvTWFrZWZpbGUNCj4+IEBAIC0xMiwzICsxMiw1IEBAIGxhbjc0M3gtb2Jq
cyA6PSBsYW43NDN4X21haW4ubyBsYW43NDN4X2V0aHRvb2wubyBsYW43NDN4X3B0cC5vDQo+PiAg
IG9iai0kKENPTkZJR19MQU45NjZYX1NXSVRDSCkgKz0gbGFuOTY2eC8NCj4+ICAgb2JqLSQoQ09O
RklHX1NQQVJYNV9TV0lUQ0gpICs9IHNwYXJ4NS8NCj4+ICAgb2JqLSQoQ09ORklHX1ZDQVApICs9
IHZjYXAvDQo+IA0KPiAuLi4NCj4gDQo+PiArc3RhdGljIHZvaWQgbGFuODY1eF9yZW1vdmUoc3Ry
dWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbGFuODY1eF9wcml2
ICpwcml2ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7DQo+PiArDQo+PiArICAgICBvYV90YzZfZXhp
dChwcml2LT50YzYpOw0KPj4gKyAgICAgdW5yZWdpc3Rlcl9uZXRkZXYocHJpdi0+bmV0ZGV2KTsN
Cj4+ICsgICAgIGZyZWVfbmV0ZGV2KHByaXYtPm5ldGRldik7DQo+PiArfQ0KPj4gKw0KPj4gKyNp
ZmRlZiBDT05GSUdfT0YNCj4gDQo+IERyb3AgaWZkZWYNClllcyBvay4NCj4gDQo+PiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbGFuODY1eF9kdF9pZHNbXSA9IHsNCj4+ICsgICAg
IHsgLmNvbXBhdGlibGUgPSAibWljcm9jaGlwLGxhbjg2NXgiIH0sDQo+PiArICAgICB7IC8qIFNl
bnRpbmVsICovIH0NCj4+ICt9Ow0KPj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGxhbjg2NXhf
ZHRfaWRzKTsNCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICsjaWZkZWYgQ09ORklHX0FDUEkNCkkgdGhp
bmsgSSBuZWVkIHRvIHJlbW92ZSB0aGlzIGlmZGVmIGFzIHdlbGw/DQo+PiArc3RhdGljIGNvbnN0
IHN0cnVjdCBhY3BpX2RldmljZV9pZCBsYW44NjV4X2FjcGlfaWRzW10gPSB7DQo+PiArICAgICB7
IC5pZCA9ICJMQU44NjVYIiwNCj4+ICsgICAgIH0sDQo+PiArICAgICB7fSwNCj4+ICt9Ow0KPj4g
K01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgbGFuODY1eF9hY3BpX2lkcyk7DQo+PiArI2VuZGlm
DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCBzcGlfZHJpdmVyIGxhbjg2NXhfZHJpdmVyID0gew0K
Pj4gKyAgICAgLmRyaXZlciA9IHsNCj4+ICsgICAgICAgICAgICAgLm5hbWUgPSBEUlZfTkFNRSwN
Cj4+ICsjaWZkZWYgQ09ORklHX09GDQo+IA0KPiBEcm9wIGlmZGVmDQpZZXMgb2suDQo+IA0KPj4g
KyAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBsYW44NjV4X2R0X2lkcywNCj4+ICsjZW5k
aWYNCj4+ICsjaWZkZWYgQ09ORklHX0FDUEkNCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCB0aGlzIGlm
ZGVmPw0KWWEgaXQgaXMgbm90IG5lZWRlZC4gV2lsbCByZW1vdmUgaXQuDQo+IA0KPj4gKyAgICAg
ICAgICAgICAgICAuYWNwaV9tYXRjaF90YWJsZSA9IEFDUElfUFRSKGxhbjg2NXhfYWNwaV9pZHMp
LA0KPj4gKyNlbmRpZg0KPj4gKyAgICAgIH0sDQo+PiArICAgICAucHJvYmUgPSBsYW44NjV4X3By
b2JlLA0KPj4gKyAgICAgLnJlbW92ZSA9IGxhbjg2NXhfcmVtb3ZlLA0KPj4gK307DQo+PiArbW9k
dWxlX3NwaV9kcml2ZXIobGFuODY1eF9kcml2ZXIpOw0KPj4gKw0KPj4gK01PRFVMRV9ERVNDUklQ
VElPTihEUlZfTkFNRSAiIDEwQmFzZS1UMVMgTUFDUEhZIEV0aGVybmV0IERyaXZlciIpOw0KPj4g
K01PRFVMRV9BVVRIT1IoIlBhcnRoaWJhbiBWZWVyYXNvb3JhbiA8cGFydGhpYmFuLnZlZXJhc29v
cmFuQG1pY3JvY2hpcC5jb20+Iik7DQo+PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPj4gK01P
RFVMRV9BTElBUygic3BpOiIgRFJWX05BTUUpOw0KPiANCj4gWW91IHNob3VsZCBub3QgbmVlZCBN
T0RVTEVfQUxJQVMoKSBpbiBub3JtYWwgY2FzZXMuIElmIHlvdSBuZWVkIGl0LA0KPiB1c3VhbGx5
IGl0IG1lYW5zIHlvdXIgZGV2aWNlIElEIHRhYmxlIGlzIHdyb25nLg0KT2ssIHdpbGwgcmVtb3Zl
IGl0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
