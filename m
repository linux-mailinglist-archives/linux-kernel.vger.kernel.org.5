Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581EE7A5F35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjISKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISKOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:14:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538210EB;
        Tue, 19 Sep 2023 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695118391; x=1726654391;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MwMnbkdw+YpnrP7+Ou8vkPxtQZQ22QbVdmyIC7spa/I=;
  b=UpTI0o4QB9yjKQ+ifDIYH035Gn2YeU5M0LTLMmiUfqClGVxIfbRrFSX/
   8khOQFeGM4BqE/4nr+1TXxqh1Hom369R/CljFJVb/HnXCeBDd3ckgXei0
   CBuBz8F3Tl9Wo5iSsk3v5XRnmoHZjbOiCW9cM53lH+PWFPHcr++PwHxUy
   QqptXjbTNeRUNSC2RN6vUJnp3sAgepeS2T7QihALwe/H5Zed9JE/bgMT0
   0822QWbV1IBNQcuht8/vL9opINpkFV5KrwcIWri0lXrWDcb4ZRs4dU6B3
   DIRQfz7Cr90w6hQlCxc8w/klnASclkQyDEvHxtRyWVd5SNTHjPc9uTdR5
   A==;
X-CSE-ConnectionGUID: 1rHT1gDfT/eevXzGUcMbJw==
X-CSE-MsgGUID: 0nGjeDu9Qg+TO1nkOGyqpg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="235938809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 03:13:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 03:12:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 19 Sep 2023 03:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To39EnKiawmDjKWVHlGHmg9T0H7EyGrpbMg9WqVq3JH2fZh2D6ExDGjVzUOeLVz9S2oH8HcY9JVlCP6aTOf1/1Z0pj9+BXzI2NiSgjzzPWN7LPf04Aqs6gYAfzIYyUona30taBdmBv0Hcf6lE3FJVj5hDDBlzsjbrzEXy/jdRgD/8I9Wgv7yPPDqTrUelOmjeI2I32CZCAp+O/90Vk2qDzvMZjzO8+1UbuwW2UrT0UNwPT1wwSuj1F/8kIyfhFYOrzSrC5SbcHZ8BeIecdxbEV99zJ3UOHz+yByBBijlfl0dqMnkGoJW6pBpwfk0fuctv1G/XVsqsSpguVBjps1ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwMnbkdw+YpnrP7+Ou8vkPxtQZQ22QbVdmyIC7spa/I=;
 b=QqTP/TtOxphFUeC9VkbcrAB9uqbGPHr/x5pE2H+hESaDDgp5JHs4bRo+1l1wu58X4YUPlPzX0LOB49AFo9tVm1RxLUEjDti5ZZFmug+zymZTu3jBi2Z18AuJtQco2NYNAhGXT2vqO939S5jQ2ALnJdBiwDHEzhPshYFYmImS+iFMtskXSDzdWgBNYl5vy91wXF8T8M8/PpCYKRgLHzt9HI+JaJLxw2hixLQjq++cC5oLsTGpEF/LlKzk5PJi2be7kiJR1KkTMNX/4/DpDIbqNtF9UjRxm63oN6bbeO/vDwkriuUGqBzipCcUzI0GgBViZjT2TRio8hcTo6Pdf5Toow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwMnbkdw+YpnrP7+Ou8vkPxtQZQ22QbVdmyIC7spa/I=;
 b=Q8R+G73ZgXZcfqSNJSJmdFmC3Dy197EjGY1Z2IYoTzdjXoJ/WX651VafREA0uSQUwsX2OB42fqNEYf7S+mkG9ufMKn0KW4c9jEyigWdVOXeIXz0/0BFscrU8jJvbvE5DHNv5KK5JejnPeYlH+eLVgrEgfeVXG/8wXltjERrFm88=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Tue, 19 Sep 2023 10:12:55 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 10:12:55 +0000
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
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Thread-Topic: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Thread-Index: AQHZ4mEwIcqRhP4AnUasVDHVhRaf3rAZjgOAgAbbhICAADI2AIABYzaA
Date:   Tue, 19 Sep 2023 10:12:55 +0000
Message-ID: <0601c914-a84d-c525-861e-b14dd8c45fda@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
 <e874dab4-e701-44f8-bbe0-ce66784ecf5c@lunn.ch>
 <3900f818-9ff1-cc19-f545-fbb3e2db4d52@microchip.com>
 <51d1565f-e43e-4906-af65-2ae672309b89@lunn.ch>
In-Reply-To: <51d1565f-e43e-4906-af65-2ae672309b89@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DS7PR11MB7859:EE_
x-ms-office365-filtering-correlation-id: 812ffeb2-1e18-4118-f858-08dbb8f8fe0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yonFrZ/MRnxSBWF7k3ffkZ22jtXsuguVvTy7ycyZ1VRmrR/neF1HZLArVSjaFUQfxtY6+H4Z96LYbTo7xt1alZ7oJK4OCAj1fQFnHEdf9BxjbWaLwPcXn8ZLZrYTwbuyIbgZL676qN1xmzs2yfDYy0RHBpdL6nx01aevmH28lJbjN1b1/11BNi11IISIH8TdvoXF/iDPqE153fLSfWlRUdRFOHAPsrXDt3O5tkA9X0SzL2BXfL57yXW4m55bBmKDP5KXkABWSVVB0PTdgx5SfcGynAXl4fVWFKgQDG4Dy9rwkGHYeJkjkRu/AE8n76h8NEu8E8a1lFY7aeSy4JBGgJ0NzPREKjgfvbZiQB1C3fPvcIKeU/2ZfH3J++GtPCi/D5EA7/EaQ8YC/PWe8tkxvA82Zoe17VcqNcPGJiz1KcglqaVOY1Ov3LZ5GpSMyTAEUxblkFtqffGQFpZ3xulskIcWAaJtz+s+MzgJwVu5y8MOK52ocgE7R8EeaTG82XQcGARwTLER9NrUCnNwN25hGdozHhU+i2t8jtXzpyFAcKLnaEeh6IILQ+4oU5Qt6TfsSXAhInyCIjbKCvMpuJbzarxDJg9mNlN/uIaBhOEKoh70zQcdq8pOOckYS+A5drh9qSavPtsoGzXBM0ys2OmOXVy1ewPV1HuvshFgrO4a/Dl7uV6YaT+Qe3fk9Gvr1353
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(1800799009)(451199024)(186009)(26005)(107886003)(4326008)(8676002)(8936002)(2616005)(2906002)(4744005)(7416002)(5660300002)(36756003)(86362001)(31686004)(6512007)(71200400001)(6506007)(6486002)(53546011)(122000001)(31696002)(38070700005)(38100700002)(41300700001)(76116006)(66946007)(91956017)(66556008)(316002)(478600001)(64756008)(6916009)(54906003)(66446008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZxSU9wQ2oxTkJveGswQjRpcytkU3BzdGc2VWNvNDFYeFZ2bjViY0k4UHp2?=
 =?utf-8?B?SVpuWnUwNHZFNzNiaitKVHFhMXlwWjUvUWpadkd4MERQei9PVFFNMGRnY0JS?=
 =?utf-8?B?bzhsU0EyeDNWVWlTcmNoMVNrbWVuSkl3cWN1VytVQTI2UlhQcEhUQmUwZ0Ur?=
 =?utf-8?B?aEJSZG5Kb1lPczdmSmJSbElYZzBRQUI2UHk2eTVPdjlYUENLVDZHamtVSktR?=
 =?utf-8?B?bG5tTVpldFg4S1Juc1lPdDFiZkw3M3dzSzJJL2Q1ZXQvZldTOUtCTFVYT0JQ?=
 =?utf-8?B?ekErcWdLZ3dZZ204b3h3aDU0ZCs5OE1zak9TeEtmUXEveDFMbFZpOUMyNXVs?=
 =?utf-8?B?dnl0UkxNMXlqWkNVN2ZnS3d6aWhuMURGb3NTVkdmTnNOTTA4ZGN3WnY5L0dJ?=
 =?utf-8?B?ZGhYUVg3b25TU1Fjd0tYajIraFBVMWMzZWxPUTZWS01uTkt4UWVBZFlzT2Fi?=
 =?utf-8?B?TWZWRThXaER2ZkZtVWVGTlhzUllxNk5OZjlMWWxsZGxCK2lyTTZyQjdBM3Mr?=
 =?utf-8?B?YXpyU1lzUkZucndEL01PZ25IL0JRckxhSUpFaXU3U0RwOGJLSDBGZUtMMXRq?=
 =?utf-8?B?SlR4QmZBT3JoTUg4RCtEbGJRYng0RkVHQXJDMUZ1dUt5bkxOb2k0cTc2cGlD?=
 =?utf-8?B?Skx6NjRaai9QNlU0VzRGRmR5ZU91ZG1QVFZYa2xBcE0xN0JoN1NVK0d1TjRO?=
 =?utf-8?B?VmxLQStTUnJla0VKZU1PRmhkOG84QVVOcnZKWnluaDdjeDdBdWZPZG1veSt3?=
 =?utf-8?B?dWlsL3lZZHR4WnRnVUI0Q1E1RGFDNlhsS1ptRTRDTGNtQXNOcm03T2pLNmdR?=
 =?utf-8?B?bkFSWkNFQmlIRVQySVFoMTZ0czRTUDBhdVpnTS9reVd2NnpodEpZZzNlaHFR?=
 =?utf-8?B?TlRtM2hCR1RJNndjTm5lWjJ0T3h6cE9rMWM2S3ZxSEFSK3MxMlVoNEJEekk0?=
 =?utf-8?B?T3dWY203Q00rQjZMalJva3hzYUZYWXcyaWE5RWhrWUM0NG1EcE1aU2FLSTlq?=
 =?utf-8?B?N0xnS0NVSy95ZFlxWksrU3B6d3dpcjlOSS9nSFUyaWlmaVFGMlpCd0ZlNTgw?=
 =?utf-8?B?eDAxWjdpcFBBSXN0d29OSk9lcUEyVFJXYjhzQ0NmOVpYUHl0SExTcnRhTEUx?=
 =?utf-8?B?MmFOVUp1MHN1b3RBRTlEUVRyZ2ZmU2VQMytnNGF4cGFWcmJrbFRVNXR6cVhV?=
 =?utf-8?B?RnNVd3dlSHIvVllVMjg4cWZud1pmdkdGaWo5TzlvTmxvMVJKMlJRMkdEWVUx?=
 =?utf-8?B?dDlCdnFZTDFsczhFek9IVWpJSjVvTW9RbmxxeEd5ZVdxYlNTbWI4Q0xyR0Ft?=
 =?utf-8?B?VUdadU1YTnBIYUtLWnAxZEZ3MXM3ZUNuS3BUa0V3ODRvUjBER3lGL2grc29G?=
 =?utf-8?B?ek9ITG5uMzhkUmIzNzVKeUxJK1FZcmNlcXJYYjhXTEVaSnF6TVBpWmdyZGk4?=
 =?utf-8?B?UFJHaUM2Yk5OVTI4bWt0d0FUVHprQXVUZ0YvRG4xK2dsOTJLOXlQOCtxTDVC?=
 =?utf-8?B?RTZvdWVHb1N2NnB2T0h4UERWQzhibEFuYU5QWkdYOHBkUlovRllNMGJCOFd4?=
 =?utf-8?B?b1g1VWMya3ZkRU1OL2cwMkxFVjIrSDlEaVdPWnlEMzNnZW1zZ3Vuay9MUE4w?=
 =?utf-8?B?aUlLZkZySXlXa0VXUTJ1ZW1SajZJZ3ZwWkRvWk9YRTk5b3pUa0MyemdqSStV?=
 =?utf-8?B?aTdHLzV1bnBoWkNZVG9KSmZ1dVc0ZytCLy9wdFR2dU0yWUhjR29PSmlmZVVj?=
 =?utf-8?B?TWNUQ1JxY29JbFQ5c0UvWjZnZ3B2MnBsVkdid0tiL2V6Wk9yNnNWMUtOR1Ay?=
 =?utf-8?B?Qlo1Y2VYZHhLRk41KzROd3pjVlJQcVE4OW1UZk80WXpSNThQRWdrU3NEa0I5?=
 =?utf-8?B?SEFMdlE4TTFUYlZNMldnaFpYN2tvWXlZZ0p4ZVNLVnpQZlBaZS9FU3I2bXRr?=
 =?utf-8?B?YkZwcHVpd21YL3VKSHAwMytiaVo0MnFLczY4RjdaS2h1dnpNZklURkpXVmtX?=
 =?utf-8?B?cCtJb290U2ZsbnBvVHhLb2VaMmhaUm1LOXhvelFVQVlpdUlUNDFjZzVXTzVC?=
 =?utf-8?B?dlZTNDVKd0d5UEI5aWtaRHpFai94ZDJKd2t0dHE4Vys2NVg0czFGcnZ4VGxp?=
 =?utf-8?B?cWJmSnJzMjA0NlZDNy90TzMwcUIveU95cUtDaDN1UTZCYkQ2MzJndW4vcEZB?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0EBE985B25144F8A40B1BFE450C497@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ffeb2-1e18-4118-f858-08dbb8f8fe0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 10:12:55.6341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScnsQdT7AWPZfsBv6My2cvuxBnoVLeZIsSsCazlSU+zi46u7cYuZ9+3NG8Q95mQg2hjajzW6PIX7uj2fIkFk/L3qDiLFg29Xl8SiKnRRWwvx0Zr8K0xkICroFB+HWpDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxOC8wOS8yMyA2OjMxIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+PiArI2RlZmluZSBNQVhf
RVRIX0xFTiAgMTUzNg0KPj4+DQo+Pj4gV2hlcmUgZG8gMTUzNiBjb21lIGZyb20/IE1heWJlIHRo
aXMgbmVlZHMgYW4gT0FfVEM2IHByZWZpeCB0byBtYWtlIGl0DQo+Pj4gY2xlYXIgdGhpcyBpcyBz
cGVjaWZpYyB0byB0aGlzIHByb3RvY29sPw0KPj4gQWggaXQgaXMgYSBtaXN0YWtlLiBJdCBpcyBz
dXBwb3NlZCB0byBiZSBhbiBldGhlcm5ldCBwYWNrZXQgc2l6ZSB3aGljaA0KPj4gaXMgMTUxOCAo
MTUwMCBieXRlcyBNVFUgc2l6ZSArIDE4IGJ5dGVzIG92ZXJoZWFkKSBhbmQgaXQgaXMgbm90IGZy
b20gT0EuDQo+PiBJdCBpcyBhIG1pc3Rha2UgYW5kIHdpbGwgY29ycmVjdCBpdCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KPiANCj4gUGxlYXNlIHRyeSB0byBleHByZXNzIHRoaXMgdXNpbmcgRVRIX0RB
VEFfTEVOICsgc2l6ZW9mKHN0cnVjdA0KPiBvYV90YzZfb3ZlcmhlYWQpLiBEb2luZyBpdCBsaWtl
IHRoaXMgd2lsbCBhdm9pZCBlcnJvcnMgbGlrZSB0aGlzIHNpbmNlDQo+IGl0IGlzIGFsc28gcGFy
dCBkb2N1bWVudGF0aW9uLg0KT2ssIGluIG15IGNhc2UgdGhlIGRlZmluZSB3b3VsZCBiZSwNCg0K
I2RlZmluZSBNQVhfRVRIX0xFTiAgICAgIChFVEhfREFUQV9MRU4gKyBFVEhfSExFTiArIEVUSF9G
Q1NfTEVOKQ0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KDQo+IA0KPiAgICAgQW5kcmV3
DQoNCg==
