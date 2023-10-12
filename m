Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080AC7C67FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjJLISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjJLISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:18:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CAB7;
        Thu, 12 Oct 2023 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697098728; x=1728634728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lp/tdJGm6S+Q4O9OtXN+Ca9yfyfzyPqGXdSf1xLgkPg=;
  b=kxKBBuYx7x2L8oPuOhMAtbVwghd65Ek8d7nC6WL24wqvhzq6orcCbn+u
   piAo8AdSJ7/WkBClWCI8Zp0+Koj9SsRsuF7xCDe4puf+hJTgM8zNyJgu7
   uiF7EPP3Nkq9ChUWga0f4uhuo97pOFyCgtqfWll/LYSrahiYU832HPy+f
   EadwZWH3UPkdVJ0La2MCrbVarm+doZFxj5nr6MsHdNdeZ8hybZ+dUxUBM
   Mb9kqZON6pveVH/VDWagQbp91T41064Yt88U5TGPNSov24HCFsAXwpiro
   i9+rZ724Fu6odA4GQ3EHVWOeyj0p4RnAhuEZJkLXmD4bvkpxbt8d8vgSu
   w==;
X-CSE-ConnectionGUID: klHOdHHeT4KK3MrC1PHs1w==
X-CSE-MsgGUID: fvBJwg0yRK6KoqnNFKkRFQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="10077050"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Oct 2023 01:18:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 12 Oct 2023 01:18:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 12 Oct 2023 01:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSqp6KJB6yDpDdO01mQF0aX1MZHWEQSjMJD+dWQKRrLL5H9douMC5ci+DdgerxKsFEuVg68vDSh8XiqXc3b9Asecl3c90sQeET6xCz6uFc7atm6iFmFwOxHlkDR8YGR1DKLpnyNdlrwXd/HFncfem4lCGy/FhGH/FY6GETLNw+55AGmV5lQql9PkI5RiLoJQiwGpK+xKBZj5DxGHcJ1AO132OaSYm1mvOkmsFntE6tVKeqWsIT6JJlEMVGQiRvNssmLX/mC30PTzsR1PQIInjKlZWsRafvN92Y/40kbH2Dyr+istuhcfB807ktFNMe5k+Ez48QLQDlpevGtEfxGnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/tdJGm6S+Q4O9OtXN+Ca9yfyfzyPqGXdSf1xLgkPg=;
 b=OofnH+1E1TXJCfoQz0UTQ18uHRSS7iqAMpXSKMsbX2HnKk7RTfWdYFYtlAsUXeG+pWjKYHkXz+kVgSNworv8RXRwRHFwtq7Yi50sq4q5izNiawejgVKTtMEBpZswOwrFzO/R8VtwLUvX0hP2y43QwTHrQDbS+alfRAWjc5BGRKytJZ8Cg5hUR6gZEys+ugEDHGAMZifrt41qD+xcrItlVnyLRUayaUX3N1+vWehP1jk9u+w5QboFmfH3+qnHngr7s7Kel0dOK6VeX9vfBnKQcLo8hUw4Sf3nTAH82P2UuhSRALR84UGAt6wLOhEOQMhGKWEG8p0zX0z0+lNgUlDQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/tdJGm6S+Q4O9OtXN+Ca9yfyfzyPqGXdSf1xLgkPg=;
 b=kGmJEBuMGv9Pfwfk864zSKkOdG+XVXiV1cncXoWvnfXju/KxtQvvyu3KItADXnQuZS24eC1xNU58LDzCiHK0tk/RE6U8VM92E03Aenzd6cU7ox8uKjRrGeb6wacIy1Y89KQOq8zUPxj2YSIa+FnFEeT/CS10VLQot+uBbooZXHc=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by PH7PR11MB6547.namprd11.prod.outlook.com (2603:10b6:510:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 08:18:23 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::5546:4fdb:1bb6:6e18]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::5546:4fdb:1bb6:6e18%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:18:23 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Thread-Topic: [PATCH v1] iio: adc: MCP3564: fix warn: unsigned '__x' is never
 less than zero.
Thread-Index: AQHZ9UvUaXQDahrOQESwz+X5ChZ6f7BC0jQAgAIGzoCAAPnwAIAAC8mA
Date:   Thu, 12 Oct 2023 08:18:22 +0000
Message-ID: <44d5d48d2d7968d85db0fe4f1dac0a7a6ff98f24.camel@microchip.com>
References: <20231002161618.36373-1-marius.cristea@microchip.com>
         <20231010104444.12e61984@jic23-huawei>
         <bcc76066305e1c191ca02566132527b4c7520588.camel@microchip.com>
         <20231012083610.742cc74c@jic23-huawei>
In-Reply-To: <20231012083610.742cc74c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|PH7PR11MB6547:EE_
x-ms-office365-filtering-correlation-id: 17fae379-d86d-402c-78a8-08dbcafbcd21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55fFOYRj9Kpk+o6FAC40QQiN8uSUyVJ/0sgSS4cutkL8oDKU/TfI2EHlo4YHbY10TKJefRghdRD5gf/wp2Y37mM26P+XzF61Ytlwd34CfUSO91ZufJF6/yQe1SwdraV9aPr7pO2YGO2XtLAvJHy15nGF5bzj7px43V80xuoEUyovZIP064VwchLxrubKFFcyUbTHyPbFVbBWjvETeZAf/I4bZdqq8ZlzQQF6TjAN3qKgkhSgsxjOrEImyuO/GcSVByIV0a2VRcm1VY3y7yKGA9uYpwT4XgRqEtFUhk5k+e+s8h2DzHYzsbsQrBYgAN+EssbKWphzMF3QYpQugYlGD4NakhrprM7XFjoYuRPCqMuaytk4sg6eWQnnCo9YnqgcwrnjSlGIWdMycVxRvD9UEWxpodk4WVejYDi8BP7Dl2P8NGrvtSpOCEeaDWItmmiIfxDmDUb/72no7uyOatUXRBtsKzsI0p+lfFXOCM/Eux/Epo10E+EfSMyu/qHhyC0ynvtcF9q5pIon95OukJ3frgkvbjuiLBCeLCRvJQ+NIKK2XECIXgvZFfV20I4O625ndfW1UqF9tndVfJZ1MA0c0iZVEaPgR/1/VhYRxbxP8QI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39850400004)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(4001150100001)(26005)(316002)(2616005)(83380400001)(2906002)(38070700005)(6506007)(6512007)(86362001)(71200400001)(38100700002)(5660300002)(8936002)(8676002)(4326008)(478600001)(6916009)(966005)(6486002)(36756003)(41300700001)(91956017)(76116006)(64756008)(66946007)(54906003)(66556008)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkQ2S0ZKWVFUQXJTYWtraURDOTMwaFNkdUhHd3poeHIrQkJCQW02bFlNWmtr?=
 =?utf-8?B?M1BHSVNuRHV5SGlJOElCUTRYTkZHbWM5T2NQSzk5bWhyR1RJLzBmakhUL0ZW?=
 =?utf-8?B?ZkZxZ2kwSWsyMFlINW5jTkdVaThreU4yNU9sZ21nY00wRTRZNm01ZndrL1Rk?=
 =?utf-8?B?eVVFQ1k4RUJ0QXJDWElkek1jRzNnM21MNVAvMFpGYmQwWWZOUWg3N1BMTnpE?=
 =?utf-8?B?TG96ckJ1VDZHV2tENXRWUVVpN0ZRdnhjTXhKWUFtWkZ3ZGxDM0VJWGthOUk2?=
 =?utf-8?B?ZUVCL0x6ZVlWQUhXeUtlbk1HVlBWVE9jT1lqUlNSMzlJUnAzNXdleWt2cFBI?=
 =?utf-8?B?UjQvV1p1TzZVOWVWKzQrQ0VRbnNGV1lyNTlpV1NSMjA4R2lObUg1Uk1wMHI3?=
 =?utf-8?B?ZHNHT1J0RlR5TSs1bTh5MXdacDlqWjFPeWN3enNlclVxc1RmQ0djRTVWemF2?=
 =?utf-8?B?WjBoS3RnNDA2cERmd0JZMU1uKzZENkNUUS9SZnRpRWsrTlk5bVJpZjZJVEJp?=
 =?utf-8?B?MFhSSThGRVYrWmxFalBZbFhHUm5RNC8rVkNpK3R0S29Ydm92S0tjMlNrNDR4?=
 =?utf-8?B?anp6VTREOTB1WCtOS0tnYm1MQVNVWXBjTkM2eThYSGJ3dlZMK0pDQmRpR2VI?=
 =?utf-8?B?QmxWRzVIWjhTWFN3bFZjVm1JQ0loWTFlRGVyb1NYNWxHVXpMRGdieStiSjla?=
 =?utf-8?B?bldYQXQ1SEd5UFpWSkZ3NnBIazE1SHFvb052OVovcy9jZFZuREZvRjZlV3dx?=
 =?utf-8?B?Q2dhemdkdit1OUVSaHFFclAza0N5MmdrNHVVRmkxMmowY1lXUGlzaytSYWpG?=
 =?utf-8?B?a1VTNlQ1eFpqaWFDUkh1dndOYllobTNpQSs3VTRoT3c3a3BJUEZDYU1aWFZG?=
 =?utf-8?B?K0ZUV05nZVM2VzF1L21LdklUY2RCYXpWdUl1Z1BIcVhoM3RneEFkc1FDZDZa?=
 =?utf-8?B?SC8vaWxyVkhQWko1emg4NEZWQ1g1QlY0RHhhRHR2dkJUdGFZQjdxTWtsMEMv?=
 =?utf-8?B?T2tDWk1SN1JsdmxjY2Y4R0xkbENsMjFwZ1U4QTZDdmJYRTN3MUZaS0NlTzdl?=
 =?utf-8?B?cng4MzMyNnVid1E5aWpHMlhpZHhRWmFJUHRNYWhVc1FnK3JpaElrMW9jK1li?=
 =?utf-8?B?S0xiRXd6MGdLdVhTenJFUVhFWGh2YTFDdE5Kdm1heEwrQ0w0VmNmL2JsOHB6?=
 =?utf-8?B?NFAwK3R4czRWVHNZUmxsbklSYmYvd0g1Vkt4OVBWamxhem42VUUycmdTUThR?=
 =?utf-8?B?QkVvalA3UzZTOFV5L2J2RnpHU0NqZlRtdm4vNkZtdERZSzFYNmV3ZjdOaFZ1?=
 =?utf-8?B?M0JTWHpKai96ekZ0czFpQkxaV1NjdytvbENERENObWN0ZnZSbTJ3RHozUVcz?=
 =?utf-8?B?U3cwM25MWFd3ZW1YY3kxOVQxTzcveVJPSHd1NjhqeHRQcnF0UGtRR3dFamNz?=
 =?utf-8?B?bFRLV3B5WUxORk0vWmR2K3JIS0Z6aCt6ZElSN0l5Q0NZbXV2UzZnek5Md2gr?=
 =?utf-8?B?ci9yYld0aXNCYTk2UkplS3NjeWdtREtOd0J2VXBjalA3b2s4cS9abzlCYlNj?=
 =?utf-8?B?bXNEWGJndnFIYXFjb1lWTm43VDlTVFNXUkk5SlAzNkVFcGRVSmtsUnQrUlcx?=
 =?utf-8?B?TTh2VHZaUWJPNFd5MXphTTZzbHRza255NlB1cXFmQm92NW10dnJtN3JyYkpo?=
 =?utf-8?B?N0RGMkNwQjlLUGl0b0U5MWdBcXViRC9iMitnTllxZm8vWk14Ly9kdXBrUTlC?=
 =?utf-8?B?SkI2MXpJMVlpY3EySUxzTWRCM2FET3h2RkVXeGRQTkVlSHFsK1Z6b2Qvbm9z?=
 =?utf-8?B?cStkTGlsdEVjdHRYb1lCcTNsOGhWV0R5UGllanM4RWVyL0J0bllBa0ZtM1ds?=
 =?utf-8?B?czhiRFppeXV4Zy8ycitYQmovbjlPQjIrT3RjcHp5QTl4MWJEazhHR0tkTjFU?=
 =?utf-8?B?VElESUpra0VPendNKzBEaHR2clB4UzdIZEpBeTVjclRDV0h6WkkxaHg5Zm9z?=
 =?utf-8?B?dHVVZ0FjVjlkS3o5WFdhNkFFWmFxMjJMNU5OWVBkNVZjNmhOMEpBWEF2MmpU?=
 =?utf-8?B?d0pKRytSQS9yTXAva0tLa2xOUFFkQlk3ckhJQUtaUmxNM0VhYXRlT0todlA2?=
 =?utf-8?B?blRFL1NKVkdCTjg5d1ozbGxRdEEzZ1RvV0ovcnJSUWhYdDJ6NVhqN2dNdU5D?=
 =?utf-8?Q?guIlXEdcNnrON7aznBtT1Oc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <841BBF45D1B211419B00524571ED2F96@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fae379-d86d-402c-78a8-08dbcafbcd21
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 08:18:22.9680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Tzk+Wq5u8I6YHscfUHVfXEIUFAEYwSyPUXy9ROBJNEXGbpJtcl/0wsuanq1FfgZG6tZnMg8HjurasCcIDrkKI2d+mFfOFK7NaYdBJUpZgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6547
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIFRodSwgMjAyMy0xMC0xMiBhdCAwODozNiArMDEwMCwgSm9uYXRo
YW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBPbiBXZWQsIDExIE9jdCAyMDIzIDE2OjQxOjM4ICswMDAwDQo+IDxNYXJpdXMuQ3Jp
c3RlYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+ID4gwqAgSGkgSm9uYXRoYW4sDQo+ID4g
DQo+ID4gwqBTb3JyeSwgSSB0aGluayBJJ3ZlIG1hZGUgYSAibWlzdGFrZSIgcmVsYXRlZCB0byBu
YW1pbmcgdGhlIHBhdGNoZXMNCj4gPiBhbmQNCj4gPiBhbHNvIG5vdCBydW5uaW5nIHRoZSBTbWF0
Y2ggY2hlY2tlciBhdCBhIHBvaW50IGluIHRpbWUuDQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gT24g
VHVlLCAyMDIzLTEwLTEwIGF0IDEwOjQ0ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0K
PiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gDQo+
ID4gPiBPbiBNb24sIDIgT2N0IDIwMjMgMTk6MTY6MTggKzAzMDANCj4gPiA+IDxtYXJpdXMuY3Jp
c3RlYUBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBGcm9tOiBNYXJpdXMg
Q3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBwYXRjaCBlZmVhMTVlM2M2NWQ6ICJpaW86IGFkYzogTUNQMzU2NDogZml4IHRoZSBzdGF0
aWMNCj4gPiA+ID4gY2hlY2tlcg0KPiA+ID4gPiB3YXJuaW5nIg0KPiA+ID4gPiBsZWFkcyB0byB0
aGUgZm9sbG93aW5nIFNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nOg0KPiA+ID4gPiANCj4g
PiA+ID4gwqDCoCBzbWF0Y2ggd2FybmluZ3M6DQo+ID4gPiA+IMKgwqAgZHJpdmVycy9paW8vYWRj
L21jcDM1NjQuYzoxMTA1IG1jcDM1NjRfZmlsbF9zY2FsZV90YmxzKCkNCj4gPiA+ID4gd2FybjoN
Cj4gPiA+ID4gdW5zaWduZWQgJ19feCcgaXMgbmV2ZXIgbGVzcyB0aGFuIHplcm8uDQo+ID4gPiA+
IA0KPiA+ID4gPiB2aW0gKy9fX3ggKzExMDUgZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiA+
ID4gPiANCj4gPiA+ID4gwqDCoCAxMDk0DQo+ID4gPiA+IMKgwqAgMTA5NcKgIHN0YXRpYyB2b2lk
IG1jcDM1NjRfZmlsbF9zY2FsZV90YmxzKHN0cnVjdA0KPiA+ID4gPiBtY3AzNTY0X3N0YXRlDQo+
ID4gPiA+ICphZGMpDQo+ID4gPiA+IMKgwqAgMTA5NsKgIHsNCj4gPiA+ID4gwqDCoCAuLi4uLg0K
PiA+ID4gPiDCoMKgIDExMDPCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IE1DUDM1
NjRfTUFYX1BHQTsgaSsrKSB7DQo+ID4gPiA+IMKgwqAgMTEwNMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVmID0gYWRjLT52cmVmX212Ow0KPiA+ID4gPiDCoD4gMTEwNcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1wMSA9IHNoaWZ0X3JpZ2h0KCh1NjQpcmVm
ICogTkFOTywNCj4gPiA+ID4gcG93KTsNCj4gPiA+ID4gwqDCoCAxMTA2wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkaXZfdTY0X3JlbSh0bXAxLCBOQU5PLCAmdG1wMCk7DQo+ID4g
PiA+IMKgwqAgMTEwNw0KPiA+ID4gPiDCoMKgIC4uLi4uDQo+ID4gPiA+IMKgwqAgMTExM8KgIH0N
Cj4gPiA+ID4gDQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCj4gPiA+ID4gQ2xvc2VzOg0KPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9vZS1rYnVpbGQtYWxsLzIwMjMwOTI4MDczOC5OV2pWZlZ0NC1sa3BAaW50ZWwuY29tLw0KPiA+
ID4gPiBGaXhlczogZWZlYTE1ZTNjNjVkIChpaW86IGFkYzogTUNQMzU2NDogZml4IHRoZSBzdGF0
aWMgY2hlY2tlcg0KPiA+ID4gPiB3YXJuaW5nKQ0KPiA+ID4gDQo+ID4gPiBUaGlzIGZpeCBpcyBm
aW5lIGJ1dCBjYW4geW91IHRhbGsgbWUgdGhyb3VnaCBob3cgdGhlIHN0YXRpYw0KPiA+ID4gY2hl
Y2tlcg0KPiA+ID4gd2FybmluZyBmaXgNCj4gPiA+IGluIHF1ZXN0aW9uIGhhcyBhbnl0aGluZyB0
byBkbyB3aXRoIHRoaXMgb25lPw0KPiA+ID4gDQo+ID4gPiBXYXMgaXQganVzdCBhIGNhc2Ugb2Yg
Zml4aW5nIHRoYXQgaXNzdWUgYWxsb3dpbmcgdGhlIHN0YXRpYw0KPiA+ID4gY2hlY2tlcg0KPiA+
ID4gdG8NCj4gPiA+IGdldCBmdXJ0aGVyIGJlZm9yZSBnaXZpbmcgdXA/wqAgSW4gd2hpY2ggY2Fz
ZSB0aGUgZGVzY3JpcHRpb24NCj4gPiA+IG5lZWRzDQo+ID4gPiBtb2RpZnlpbmcuDQo+ID4gPiAN
Cj4gPiA+IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmcgaW4gdGhlIGZvbGxvd2luZyBmaXg/DQo+
ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jDQo+ID4g
PiBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gPiA+IGluZGV4IDY0MTQ1ZjRhZTU1Yy4u
OWVkZTFhNWQ1ZDdiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL21jcDM1NjQu
Yw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiA+ID4gQEAgLTE0MjIs
MTEgKzE0MjIsOCBAQCBzdGF0aWMgaW50IG1jcDM1NjRfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UN
Cj4gPiA+ICpzcGkpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWNwMzU2NF9zdGF0ZSAq
YWRjOw0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoCBpbmRpb19kZXYgPSBkZXZtX2lpb19k
ZXZpY2VfYWxsb2MoJnNwaS0+ZGV2LA0KPiA+ID4gc2l6ZW9mKCphZGMpKTsNCj4gPiA+IC3CoMKg
wqDCoMKgwqAgaWYgKCFpbmRpb19kZXYpIHsNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldl9lcnJfcHJvYmUoJmluZGlvX2Rldi0+ZGV2LA0KPiA+ID4gUFRSX0VSUihpbmRp
b19kZXYpLA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJDYW4ndCBhbGxvY2F0ZSBpaW8gZGV2aWNlXG4iKTsNCj4gPiA+ICvC
oMKgwqDCoMKgwqAgaWYgKCFpbmRpb19kZXYpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07DQo+ID4gPiAtwqDCoMKgwqDCoMKgIH0NCj4gPiA+IA0K
PiA+ID4gDQo+ID4gDQo+ID4gwqAgSSd2ZSBnb3QgdHdvIGJ1Z3MgcmVwb3J0ZWQ6DQo+ID4gDQo+
ID4gLSBUaGUgZmlyc3Qgb25lIHdhcyByZXBvcnRlZCBieSBEYW4gQ2FycGVudGVyICJSZTogW2J1
ZyByZXBvcnRdDQo+ID4gaWlvOg0KPiA+IGFkYzogYWRkaW5nIHN1cHBvcnQgZm9yIE1DUDM1NjQg
QURDIi4gVGhpcyBidWcgd2FzIGZvdW5kIHVzaW5nIHRoZQ0KPiA+ICJTbWF0Y2ggc3RhdGljIGNo
ZWNrZXIgd2FybmluZyIgYW5kIGl0IHdhcyByZWxhdGVkIHRvOg0KPiA+ID4gLS0+IDE0MjbCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyX3Byb2JlKCZpbmRpb19kZXYtPmRl
diwNCj4gPiBQVFJfRVJSKGluZGlvX2RldiksDQo+ID4gDQo+ID4gVGhpcyBidWcgd2FzIGZpeGVk
IGJ5IHRoZSBhYm92ZSAiW1BBVENIIHYxXSBpaW86IGFkYzogTUNQMzU2NDogZml4DQo+ID4gdGhl
DQo+ID4gc3RhdGljIGNoZWNrZXIgd2FybmluZyIgYW5kIGl0IHdhcyBhcHBsaWVkIG9uICJBcHBs
aWVkIHRvIHRoZQ0KPiA+IHRvZ3JlZw0KPiA+IGJyYW5jaCBvZiBpaW8uZ2l0IGFzIHRoYXQncyB3
aGVyZSB0aGlzIGRyaXZlciBpcyBhdCB0aGUgbW9tZW50LiINCj4gPiANCj4gPiBBbHNvIG15IG1p
c3Rha2UgYXQgdGhpcyBwb2ludCB3YXMgdGhhdCBJIGRpZG4ndCBzZXR1cCBhbmQgcnVuIHRoZQ0K
PiA+ICJTbWF0Y2ggc3RhdGljIGNoZWNrZXIgd2FybmluZyINCj4gPiANCj4gPiANCj4gPiA+IGFz
IHRoYXQncyBhbGwgSSdtIHNlZWluZyBpbiB0aGF0IGNvbW1pdC4NCj4gPiA+IA0KPiA+IFllcywg
dGhhdCBjb21taXQgb25seSBoYW5kbGVkIHBhcnQgb2YgdGhlIGZpeC4NCj4gPiANCj4gPiANCj4g
PiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVh
QG1pY3JvY2hpcC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMvaWlvL2FkYy9t
Y3AzNTY0LmMgfCAyICstDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vYWRjL21jcDM1NjQuYw0KPiA+ID4gPiBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4g
PiA+ID4gaW5kZXggOWVkZTFhNWQ1ZDdiLi5lM2YxZGU1ZmNjNWEgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9paW8v
YWRjL21jcDM1NjQuYw0KPiA+ID4gPiBAQCAtMTEwMiw3ICsxMTAyLDcgQEAgc3RhdGljIHZvaWQN
Cj4gPiA+ID4gbWNwMzU2NF9maWxsX3NjYWxlX3RibHMoc3RydWN0DQo+ID4gPiA+IG1jcDM1NjRf
c3RhdGUgKmFkYykNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8
IE1DUDM1NjRfTUFYX1BHQTsgaSsrKSB7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlZiA9IGFkYy0+dnJlZl9tdjsNCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0bXAxID0gc2hpZnRfcmlnaHQoKHU2NClyZWYgKiBOQU5PLCBwb3cpOw0KPiA+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRtcDEgPSAoKHU2NClyZWYgKiBOQU5PKSA+PiBwb3c7DQo+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRpdl91NjRfcmVtKHRtcDEsIE5BTk8s
ICZ0bXAwKTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRt
cDEgPSB0bXAxICogbWNwMzU2NF9od2dhaW5fZnJhY1soMiAqIGkpICsgMV07DQo+ID4gPiA+IA0K
PiA+ID4gPiBiYXNlLWNvbW1pdDogNWU5OWY2OTJkNGUzMmUzMjUwYWIxOGQ1MTE4OTRjYTc5NzQw
N2FlYw0KPiA+ID4gDQo+ID4gDQo+ID4gLSBUaGUgc2Vjb25kIGJ1ZyB3YXMgcmVwb3J0ZWQgYnkg
Imtlcm5lbCB0ZXN0IHJvYm90DQo+ID4gPGxrcEBpbnRlbC5jb20+Ig0KPiA+IGFsc28gYnkgcnVu
bmluZyBTbWF0Y2ggYW5kIGl0IHdhcyBydW4gb24gdGhlIGluaXRpYWwgZHJpdmVyDQo+ID4gKHdp
dGhvdXQNCj4gPiBoYXZpbmcgdGhlIGZpcnN0IHBhdGNoIGFwcGxpZWQpDQo+ID4gDQo+ID4gc21h
dGNoIHdhcm5pbmdzOg0KPiA+IGRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTEwNSBtY3AzNTY0
X2ZpbGxfc2NhbGVfdGJscygpIHdhcm46DQo+ID4gdW5zaWduZWQNCj4gPiAnX194JyBpcyBuZXZl
ciBsZXNzIHRoYW4gemVyby4NCj4gPiBkcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jOjE0MjYgbWNw
MzU2NF9wcm9iZSgpIHdhcm46IHBhc3NpbmcgemVybw0KPiA+IHRvDQo+ID4gJ1BUUl9FUlInDQo+
ID4gZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYzoxNDI2IG1jcDM1NjRfcHJvYmUoKSB3YXJuOiBh
ZGRyZXNzIG9mDQo+ID4gTlVMTA0KPiA+IHBvaW50ZXIgJ2luZGlvX2RldicNCj4gPiANCj4gPiAN
Cj4gPiBUaGU6ImRyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmM6MTQyNiBtY3AzNTY0X3Byb2JlKCkg
d2FybjogcGFzc2luZw0KPiA+IHplcm8NCj4gPiB0byAnUFRSX0VSUiciIGFuZCAiZHJpdmVycy9p
aW8vYWRjL21jcDM1NjQuYzoxNDI2IG1jcDM1NjRfcHJvYmUoKQ0KPiA+IHdhcm46DQo+ID4gYWRk
cmVzcyBvZiBOVUxMIHBvaW50ZXIgJ2luZGlvX2RldiciIHdlcmUgZml4ZWQgYnkgdGhlIGZpcnN0
IHBhdGNoLg0KPiA+IA0KPiA+IFRoZSAiZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYzoxMTA1IG1j
cDM1NjRfZmlsbF9zY2FsZV90YmxzKCkgd2FybjoNCj4gPiB1bnNpZ25lZCAnX194JyBpcyBuZXZl
ciBsZXNzIHRoYW4gemVyby4iIGlzIGZpeGVkIGJ5IHRoZSBsYXN0IHBhdGNoDQo+ID4gIltQQVRD
SCB2MV0gaWlvOiBhZGM6IE1DUDM1NjQ6IGZpeCB3YXJuOiB1bnNpZ25lZCAnX194JyBpcyBuZXZl
cg0KPiA+IGxlc3MNCj4gPiB0aGFuIHplcm8uIg0KPiA+IMKgYnkgY2hhbmdlaW5nOg0KPiA+IA0K
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1wMSA9IHNoaWZ0X3JpZ2h0KCh1NjQpcmVm
ICogTkFOTywgcG93KTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRtcDEgPSAoKHU2
NClyZWYgKiBOQU5PKSA+PiBwb3c7DQo+ID4gDQo+ID4gc2hpZnRfcmlnaHQgZnVuY3Rpb24gaXMg
IlJlcXVpcmVkIHRvIHNhZmVseSBzaGlmdCBuZWdhdGl2ZSB2YWx1ZXMiDQo+ID4gYnV0DQo+ID4g
bXkgdmFsdWUgaXMgYWx3YXlzIHVuc2lnbmVkIHNvIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byB1
c2VkIGl0Lg0KPiA+IFRoaXMNCj4gPiBlcnJvciB3YXMgcmVwb3J0ZWQgd2hlbiBJIGhhdmUgcnVu
IHRoZSBTbWF0Y2ggb3ZlciB0aGUgZHJpdmVyICsNCj4gPiBmaXJzdA0KPiA+IHBhdGNoICh3aGF0
IHdhcyB0aGUgbGF0ZXN0IGZyb20gdG9ncmVnKS4NCj4gPiANCj4gPiBJIGhhdmUgYXBwbGllZCB0
aGUgcGF0Y2ggb24gdG9wIG9mIHdoYXQgd2FzIHRoZSAibGF0ZXN0IiBmcm9tDQo+ID4gdG9ncmVn
DQo+ID4gYnJhbmNoIGFuZCBub3Qgb24gdGhlIGluaXRpYWwgZHJpdmVyLg0KPiA+IA0KPiA+IA0K
PiA+IEkgY291bGQgY2hhbmdlIHRoZSBkZXNjcmlwdGlvbiBvciBJIGNvdWxkIHByb3ZpZGUgYSBw
YXRjaCB0byBoYW5kbGUNCj4gPiBib3RoIHdhcm5pbmcgcmVwb3J0aW5nIGF0IG9uY2UuDQo+IElm
IHRoZXJlIGFyZSBtdWx0aXBsZSBpc3N1ZXMgdGhlbiBzaG91bGQgYmUgbXVsdGlwbGUgcGF0Y2hl
cy4gU28NCj4gc3RhcnRpbmcNCj4gcG9pbnQgaXMgZGVmaW5pdGVseSBhIHZlcnNpb24gb2YgdGhp
cyBvbmUgd2l0aCB0aGUgY29ycmVjdA0KPiBkZXNjcmlwdGlvbi4NCj4gDQoNCkFjdHVhbGx5IHRo
ZXJlIHdhcyAyIGJ1ZyByZXBvcnRzIGFuZCB0aGUgc2Vjb25kIG9uZSBpbmNsdWRlcyB0aGUgZmly
c3QNCmJ1ZyByZXBvcnQuDQoNCkZvciB0aGUgZmlyc3QgYnVnL3dhcm1pbmcgcmVwb3J0IEkgYWxy
ZWFkeSBzdWJtaXQgYSBwYXRjaCB0aGF0IHdhcw0KYXBwbGllZCB0byB0b2dyZWcgYnJhbmNoDQoo
Y29tbWl0CWVmZWExNWUzYzY1ZDk2YmFjMTdhNGQ4MTA0ZTNmZmY3YzA3Y2M5MTApLg0KDQpGb3Ig
dGhlIHNlY29uZCBidWcvd2FybWluZyByZXBvcnQgSSBoYXZlICJmaXhlZCIgb25seSB0aGUgcGFy
dCB0aGF0DQp3YXNuJ3QgZml4ZWQgYmVmb3JlLg0KDQpJIHdpbGwgcmVzdWJtaXQgdGhpcyBwYXRj
aCB1cGRhdGluZyB0aGUgZGVzY3JpcHRpb24uDQoNCg0KDQo+IFRoYW5rcywNCj4gDQo+IEpvbmF0
aGFuDQo+IA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBNYXJpdXMNCj4gDQoNCg0KVGhhbmtzLA0K
TWFyaXVzDQoNCg==
