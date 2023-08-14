Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A091C77B224
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHNHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjHNHLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:11:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3210C2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691997102; x=1723533102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wEusDAUfQIXeNyNzmxaQVRUi0P7DvDlXHGm3ZfrPfAY=;
  b=lj3/Y9nRR4TUjRI2vXaVtb33Mb3qp5BkviMHNl9BNg4CfiBfJcagWOnp
   oFL3Fg/e972Ep46mVFTXfy0wc1CiSN5LwnVgvg8l3ecYkPsN7HdrzVQeB
   JH2xNzQ0gwMOdOkBFV7S/jrdW71nzOE4atfVbOPWNr87myv49pp3hxnja
   htWItpUGbhny5RMArTXiXA+2cvsN3p/S2p7CUA7G70JTa8lM8crLbQlc9
   uTVrcJVxH8Jn/gDgADl4Ffh2V6Cd9p+cepk2Io9gOwb3czHJIMa2HgPRS
   c1Bws/HIpUUptW8dYzMJj5pXDHtMdGauB0Lhd2h1pFvFw0cMO8eSQnZGQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="362129855"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="362129855"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="726921241"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="726921241"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2023 00:11:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 00:11:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 00:11:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 00:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJzCVLrrZT/1jGhUqfyAQ92tTsYX0UQlkTrR4aARwd9RZN+12AOvDMFpx75R3wNl50xiUrKTNA24o95Sm+deEEv1633V+xVP3MpVYEU96ETp/TEZT5a9TB2ZKmefBwzpRKCRDjv6D7eDIIo/YmTe5vkt1RwUc5zzWZoWrxwkQlCD+xksiqQ860tlJKQsut8ZA/7HBOzL/GrI2Atgfo1H8Tx92cudhv63OScmfsXStqqzSLUUtM7PrOlQ+IbGCLdK7XV4JF+p+3r5Iisea9sTZAvj9mGG6DTHRMdW2vbstKSvSjT03sHNBK2BRwFPBV7yk2+6xNQROoVS01RKxsYFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEusDAUfQIXeNyNzmxaQVRUi0P7DvDlXHGm3ZfrPfAY=;
 b=kYllNAu4+kZ//LiIDaDbyapp+PJ8LYzXziySD851MG6wRj45+hWTg9EG66khIA7/wmzKbkwSgBtVBajKjvJxPPo4khiSp2/Pu3UorOWQ2Fy05CZc4QpKufskfHnjJnZDWeVCaFg0Y0KakD5J7KY0CA4nzI4kul6tfevLligfZMtu+4uIXcmwIQfCdroQnr76M0ScSbmfPW+JI0NRRic9chXpP/O8l8IHQ6Q1RhgtBo+gYExBx//bEf/hQaeUzSqCMAC8xYZFk756b9uF2JllIQKaa+KJK4nv6mZsmbZ07Ku2JpQdBhTdYcSWHrpQr5qnrCXZCRdeUxUiyZOX56kqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 07:11:38 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 07:11:37 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Brown, Len" <len.brown@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZxStsBtGoY60ZQkekYudRfTtGjK/mROWAgAAXBICAAwpnAIAADHkA
Date:   Mon, 14 Aug 2023 07:11:37 +0000
Message-ID: <78c36c2cf29a4dd7dbc90aee8acc929b3620ce35.camel@intel.com>
References: <20230802101635.459108805@linutronix.de>
         <20230802101934.026097251@linutronix.de>
         <e46c345503a6d0827d3198f699258274e22cb9e3.camel@intel.com>
         <0331cd3b00ef6afc5f039f0343f010227ed18fa8.camel@intel.com>
         <87o7jaf8b1.ffs@tglx>
In-Reply-To: <87o7jaf8b1.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4762:EE_
x-ms-office365-filtering-correlation-id: 5980812c-af38-40a6-d847-08db9c95b334
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C79TabfIEuhV3Dm6MaYZ+iYM5TlZB9E49TuKNesnGkWvsBYX/SxPS206KHf8xMmcNdLbdb6o6mJaxpOK/iqxU2JbSpUMOuAB58aiCbhpkaj6Rf5jwMMowlFsdq68WGbR4LEas0yDrNL+y0ahhTY+EMgTWRif/lzn/fNb6jaLE9hb4cr3Q6yBbcRNMZHpAURhm1S/BhGatH6VeDKD+OPV4j3uYiZw0j3zIIyjnq4MeRflN3snDojBLuDbBhEcIkKIvjG7ziPg1OHN+SG07j+dtxCIc82MeE9JcfcaGiu2mzmokUO8yg1GhFLRfuGPDk5eASVPWkHHyTR44YnPvpRKZVH9WiJhIi+EqiRr3zCOCuiHC8O922PI2pK45tuI4CaQZeP5uhz5tPWnb0ry7fupMeggtJGG9Y4t0VOvLctf08D8x1rMOMq7bTuzjyl/67BoENxDR2Om3nGaQ4pObXFN/fzpylr8/GzVo5glGWlUzlg6VYwnkksj/H0gbfXGDuHZfbCUSd0+YbUM73KqBosvKICFeeny3mSbMqxTWAwS1WBWkGvuMkVxOmPJSkAMnPOoYGy8jptxc18IGtte/fAdwo+4RfQCGGQbEqkN+9q/GnASfzuwN3zlIZDzE9xCemKF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(1800799006)(186006)(451199021)(6512007)(71200400001)(6486002)(6506007)(478600001)(26005)(4744005)(2906002)(83380400001)(2616005)(7416002)(54906003)(41300700001)(66556008)(316002)(64756008)(66446008)(91956017)(66946007)(76116006)(110136005)(66476007)(5660300002)(4326008)(8676002)(8936002)(86362001)(38070700005)(38100700002)(36756003)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUZ6L0JvbGl1NlpYZ2xZeHhLdTk3MDFLTnNITGFlSk1kTUJXOHVxZkdtOGF1?=
 =?utf-8?B?SVE0M0UzbC9Za3MyV2ZDelhGakVYRXZMM2FPVXozTDl6WXJkZTNIL1M2WXBP?=
 =?utf-8?B?VzFDT2Z4T1BZN1hMampPOXpUR3RJSG1tdS9hb25tUFFadjV2RkRta3JsZmY2?=
 =?utf-8?B?N2phUEl4d1JuTlVuZmtrMnpwa2tzMkRPZnlTM2pFKys5T0FqTG5VZHcyQldF?=
 =?utf-8?B?L25OM0xTZTJXdEtZTTg5K0ZpNklsZHRGbldiWXJGUjRLcTRWVDhMcG5oRUN4?=
 =?utf-8?B?Tm5lTDV4cGFyN0lldWU4dFJBWUVGb1BHTDloL0tkOUt3YTdHU2hxa1ZCVnRq?=
 =?utf-8?B?bFoyM3BVeFN5SVppSHdNZ1RXeDUvbmM5YXg0d0laaTJqVHB4ZmhTUWdseDho?=
 =?utf-8?B?SExxcVFjcnhkNU5ncWRZcU1jMTh3NllreW5SRzhxQkk1K2dQUDg1cURHSnAx?=
 =?utf-8?B?Wmw2Z0JUS2VQWG4xQVNKRXk1dmFyeVZNNFJWQlRyaHV3cWFyNlUwTC9JUmpi?=
 =?utf-8?B?TzN1S3RIbXlTR21KanNXL05kSldNd2ZwTXIzWWhveGpzS2wyOUt4Um96YWsx?=
 =?utf-8?B?OWxBOFZSVEgybDd3UWtVMTNzVlRrV0NIWVcyN1RRK0dFS3ZHUGRockJqczZ5?=
 =?utf-8?B?UFZZYzdVUTZqMXM2ckRKZktvOWw3TDN0OEFBaXJVZEdJK2xYdmtSckhPek9U?=
 =?utf-8?B?Z29PdTFnbnVOL0FwUjdxZWVnWXFuZmlSMWlpeGVqeUw1WDFaOVhkOHhWUTNC?=
 =?utf-8?B?NXBmVHM2UWcxaXdrYUlSRTVJeFBUdHFrbGhYRTZzMFZralVqVU5WaFFEbUxN?=
 =?utf-8?B?aWMvVUVBVmJqN2REOEdaK0VvZllVWFVCc0lNVHhTeThmTHFJbCt3ZGFWYXJ4?=
 =?utf-8?B?d3pNZ09FcE5zOFJFNmNmWG1NSmx2M1NLZURVaGNrWEdiamxHMkFXb1FWbTg5?=
 =?utf-8?B?Z0RUMndEdksydVFXdTJxb3pFSng1dGZLaFBRZmdlaUVybGNEZ0ZxaHBCOWF6?=
 =?utf-8?B?VGpCand4bXFEYlJKdXcvd1pXUXowZTk2cE9WK2VzUzJwM2dsZXZhdEdONXRT?=
 =?utf-8?B?cTFsMEZ5aG52YkxrRngyaGVYOGg2YkFHZEtYeGpBdVBMQWZiemhCU2phV3ZG?=
 =?utf-8?B?SmZObG4vS3ljVkJXSGZ3bE9hZUYvSUlQQXI3MldkeHZkWDd4Q05EaXdJSGRX?=
 =?utf-8?B?SkhBOXg3cHBiK1djMlB3MWFkbnVvSzJLekRMZTRwN1FLWXZRYWZOOGVMN2pX?=
 =?utf-8?B?OUk5ZlVxajdPWm1kR2ZsWmhtRFV6a2gwTzdvYVo2ckZna0doRlVyY05sMTZM?=
 =?utf-8?B?N1JjU0FXb2RLcytuV2VPR0oyMlIzbmltSzRqUUl2QjhQaVVOV05nMXlkZlRT?=
 =?utf-8?B?cnpFMkNybVNJbDBLMytiM3R6RGhpQnk1QXVNS2M4OTR1WHIwUWNTcWx3WG5J?=
 =?utf-8?B?ZFA0dUJrZG9DR3ZIdGs3RFIrSkRKR0J6Ym5RWklIcmYrYXc4Z2pYaVJzeXlL?=
 =?utf-8?B?ZmVadll3MUZIUVhZL0d6a3pNTmh4QVVVZmRrd2dGMzh6S2sxbnQ4MXM0Q0Q1?=
 =?utf-8?B?TFVnYWJUejBBclRHcTRlRVN3eDEwR1JjN0JxYlZMRTZDa2FReFp2ZVdaZThi?=
 =?utf-8?B?L0FNYzUwanQ2Qk9sVG1jWHpNb3EyRGFkZjNqbWZXWTZwS2ZLRk5HS2hub0px?=
 =?utf-8?B?c0svTnNjRGpESlNjSkZRblBEeHZkTjBLME5WNDl4TndpcC9JVUFyTDFNSGk5?=
 =?utf-8?B?TGZ0cU5qL3pURVYxL0t5Q1RqejlLcUhWZHc1a20vbkN2ME50Ym53YnNhZlha?=
 =?utf-8?B?THpsSlZNZjVZenVYVVo5T0N1QmEybGdQRWtnY29SY1IrMEcrVmZPTnNibGZE?=
 =?utf-8?B?dG5jSFZ2Ti9zK0JQMDNReVV4M0VZZy9NTGJ1RmNSNHdjQjFkQlc0dlJ6blJR?=
 =?utf-8?B?bFpFbHNaSGw1NmlMekNoQnN6enFTVEdXQkcyV2dUcnJBTVhHYThZMHlqQUN4?=
 =?utf-8?B?YWhnRGpTL1hnRExsU0VBeDJSSm1UbDNnQWpDSXVlK3hkZ0E3S3FmZ1V6enZo?=
 =?utf-8?B?NE1vU3lLN2xBNXgrZXVrVDRham9nUUVRTHljYTlSUkhmREE0S01uQ1duaFpL?=
 =?utf-8?Q?dOoH0E78gE0UCGwAtsuEDt0fB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F544E95062C8B34683E0785805FBD531@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5980812c-af38-40a6-d847-08db9c95b334
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 07:11:37.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ILJG65Y4UOes3MHvGwcwEIsRax68vBLUW7yeD7Jct35zc4L8AfNkM15pjwPLaaqeQXpshmjieqXDEEw5AbGMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDA4OjI2ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFNhdCwgQXVnIDEyIDIwMjMgYXQgMDg6MDAsIFJ1aSBaaGFuZyB3cm90ZToNCj4gPiBP
biBTYXQsIDIwMjMtMDgtMTIgYXQgMTQ6MzggKzA4MDAsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiBC
VFcsIGNhbiB3ZSBjb25zaWRlciB1c2luZyBzeXN0ZW0gd2lkZSB1bmlxdWUgY29yZV9pZCBpbnN0
ZWFkPw0KPiA+IA0KPiA+IFRoZXJlIGFyZSBhIGNvdXBsZSBvZiBhZHZhbnRhZ2VzIGJ5IHVzaW5n
IHRoaXMuDQo+ID4gQ0MgTGVuLCB3aG8gY2FuIHByb3ZpZGUgZGV0YWlsZWQganVzdGlmaWNhdGlv
bnMgZm9yIHRoaXMuDQo+IA0KPiBJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoYXQuIEJ1dCBhcyBJ
IHNhaWQgYmVmb3JlIHdlIG5lZWQgYQ0KPiBkaXNjdXNzaW9uDQo+IGFib3V0IHRoZSBJRCByZXBy
ZXNlbnRhdGlvbiBpbiBnZW5lcmFsIHNvIGl0IGJlY29tZXMgYSBjb25zaXN0ZW50DQo+IHZpZXcN
Cj4gYXQgYWxsIGxldmVscy4NCg0KQWdyZWVkLg0KQW5kIEkgdGhpbmsgTGVuIHdpbGwgYmUgYmFj
ayBvbmxpbmUgYW5kIHByb3Bvc2Ugc29tZXRoaW5nIHNvb24gYW5kIHdlDQpjYW4gc3RhcnQgd2l0
aCB0aGF0LiA6KQ0KDQo+IA0KPiBUaGUgb3RoZXIgdGhpbmcgdG8gdGhpbmsgYWJvdXQgaXMgd2hl
dGhlciB3ZSByZWFsbHkgbmVlZCBhbGwgdGhlc2UNCj4gSURzDQo+IGV4cGxpY2l0bHkgc3RvcmVk
IGluIGNwdV9pbmZvOjp0b3BvLi4uIFRoZSB2YXN0IG1ham9yaXR5IG9mIHVzYWdlDQo+IHNpdGVz
DQo+IGlzIGluIHNvbWUgc2xvdyBwYXRoIChzZXR1cCwgY3B1IGhvdHBsdWcsIHByb2MsIHN5c2Zz
IC4uLikuDQo+IA0KDQpJIGRvbid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZSBoZXJlLiBXaXRo
IHRoZSBuZXcgZnJhbWV3b3JrLCB0aGlzDQppbmZvIGlzIHJlYWxseSBoYW5keSBldmVuIGlmIHdl
IGRvbid0IGNhY2hlIGl0IHNvbWV3aGVyZS4NCg0KdGhhbmtzLA0KcnVpDQo=
