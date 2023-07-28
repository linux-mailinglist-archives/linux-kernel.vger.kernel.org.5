Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA1767142
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjG1P5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbjG1P5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:57:34 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBC110
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559851; x=1722095851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vG8hMfgzbINeXNwEk7ME0pKVIs3YuPbGWwaaLj+ynjc=;
  b=BHZwJ5Emp15klAqlieA3Hxy9azFvggVpM0xB2AoYrlDFkmGW/xoE//ki
   4e7/2Qa+2eWr/NujuY7157c+IXoA4aa1Dh4FLuRDd4eLKF3SXeEooY1zO
   abvNdCAmzb5TqRI56ydrawNlPX0BGU1If3ijtOIpJmDOi0U+qafjoDBae
   MjAfYYM7uOHx7X6womMQFFfn31ib6lVZiwWNrXEoTzfWR7juT8Nb5pALZ
   AMUd5iviboi6DwctC2H8jkG1kAuUau5gSo3ekhQD4tay2DmYxzIkZ9QNv
   tIvZY6LMRbQMs5EzpEglS4sGPTg4jKG4ovFr5OJ3U97czQFHRAELVJEh5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353533610"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="353533610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:57:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792980708"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="792980708"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 08:57:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 08:57:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 08:57:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 08:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnDdofQl+S2/EzVIYFvz3AByLcbdqwHHhnlSf/FVh8vkmAa+cJUH/QhJ7sH7y8evoshiONc2zGFggOzkWRy8WZK4R7uZmuCAdTpkdsjh8sMeLGTqIzO5THscSwGDgjE18Lm6JWXgYouDe7Rzr+k5k1lxTnjSESgenDzOtQQeOgsEPr/U4jPMXsLslS8AgxEge8A7MnHPzm7YyHKPmKZjldmnlm2hLA33EkKL1UVsjQxLIXOvnGdTC0lsiD5dvzTzHlP5IOM/PMCvBRmH6hn1Ec9RnLRhtP9NDx/X3Zr8bKLJycgBFXOLW8JAuXp27b9yhWlH2jP/0WUPg6YMVxZFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG8hMfgzbINeXNwEk7ME0pKVIs3YuPbGWwaaLj+ynjc=;
 b=KfWQ+bxKi6D9erkqvoTMS1MIpP7LN2FTaagB0dWEhDfQTNLx54DQntm6H5y2OaVQw1Sc4O8d3/MibP+F+w3GMWy840y4do6fyHZcyAxdKEablPvO0uNexEFLOXIjShwKSUj4p0XB9giE1saWkBiKqwLfPH2QsBHc0DoneHG1AV7Hs0Z5ufogevlwaGJCW9rwWusiA/McH6h5L9+UPSxOqwkENZezGLNF0coXkid6Xj5x4q1g9EqsPFoB/4whdatuzVivPfsNoi15qqmF5N0a+4Nn6jwLGKPD6VpwJf4ljSpqBGwHgXNqKdhuFn3lB1WXG1PP1udLRkGz8ZDdZeuw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:57:22 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::75c5:4a90:a6c3:9d8d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 15:57:22 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH] cpu/SMT: Fix cpu_smt_possible() comment
Thread-Topic: [PATCH] cpu/SMT: Fix cpu_smt_possible() comment
Thread-Index: AQHZst3FGOuOoJwZUEy6D+s7S10cWq/O5hkAgACMjAA=
Date:   Fri, 28 Jul 2023 15:57:22 +0000
Message-ID: <5fd67ff4c295ae01be79b5a0101c17bc5f5ef5bd.camel@intel.com>
References: <20230710032121.8341-1-rui.zhang@intel.com>  <87zg3gqykl.ffs@tglx>
In-Reply-To: <87zg3gqykl.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW5PR11MB5930:EE_
x-ms-office365-filtering-correlation-id: 3fac7fe6-986d-46f6-0ea0-08db8f835455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtWKhvzUjLLgFF3qBOE5D3RL8zKlofKgWlikHE2oiL53trms/twZTtZIyZ5mz8BttdFObv5nPIYt15dhkDQg1xrjmaLQO36aoKwiAqk6KxbwKrwtZmbUmlKHV/fFFrCnZpYZxHJgafFsMQp/5uS595CTFIqQhoUtudNAi6sSDiGjCYuIvC2OX8d98H0PNYKSlsUXuKroJCE/I5ydWEYRhMz778JyGkGbPJeNm4JDysa9QFgVKyIpLXVAJfJ6EMu3DBJ9DbZlkg2LwcDIEKhc/xdqlW95alMVfZb4FjMkxHW2aJeMZLmwroa+YYk4J+cQiPrJmord/pOzAyk7FNpTCC7KGxiQA91ZZmw+O9YmjZKX45eA/eHo4HXYvkCRrDo3bFi6xc+uhzGxWqnj2TeeRlJIv5B7qjnbRM7rPxU+WFCZYT1DF8BFs/qDQurqu9Zd3Y2yOB1D3O6qVnCvvirwix3OiaZJlJ6zhWFlnoOM5YPvhOdmGNs0wxrM+ook9i1feoD+VR7oDd7lT99m58PetfvFwe1GvjQdnSZr17oVrMbtMYlDLkiCtBmx0kk1VBAFpK5c/1WjnvJF/zkcxfINds2k+PMyDJr/G+yz9AtZnPTkLfHFUBHTo7WjVRYdwgTK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(316002)(2906002)(8936002)(8676002)(5660300002)(4744005)(38070700005)(41300700001)(86362001)(36756003)(6486002)(71200400001)(122000001)(478600001)(82960400001)(6506007)(26005)(186003)(54906003)(110136005)(2616005)(66556008)(76116006)(66946007)(91956017)(6512007)(38100700002)(64756008)(66476007)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk9zTndXeU93SmVsYVV5MTIyR2NjWXpMQi90RERCMUVLZzBXSkVveEI3QkVt?=
 =?utf-8?B?RHpHc2JSa0piUVNiTitab1lPdnVEakkxL2YxVjJaSERmSWhyZWplU0Zvdm5h?=
 =?utf-8?B?K1FYWUlTWitRd1Zhc3g2ekRPaEZ4Z2Q4TFdSOWRDODhia1VGb3VqOVRRNkRu?=
 =?utf-8?B?ckttVVNST0FUd2tnQVVKTW5mdnJJdTNJTkhBUllsK29lZ1B6VlovODRzbEdj?=
 =?utf-8?B?YkpwVXdIclB3RFBuZDVpcmxuZ0cvdTIrYnhRTHlid25XK1RVcXJiME01MUFF?=
 =?utf-8?B?MTJtN2E4TmtFRE1ZbXZHUFp5NVNoZG5Wa0FIVkwzcjFnaEJ1ODRINHFIMXIz?=
 =?utf-8?B?V3lCenlySVJPb0ZSNFMzcHRNQ1BaNVdKZnk2Q0xQUFpBckxQUENPY3FJVVZX?=
 =?utf-8?B?WW5zdG1KMFE0bytmTktSREVPOUxIbXlnay9HbWFqV01ieWNKNlo3QlBSQUh6?=
 =?utf-8?B?c1h3K2l5V0habUJMSmJ2cStNZ2NwUWJJNDFDcUVEd2F3ak1TM3ZxcktYamJl?=
 =?utf-8?B?TTU0Yjk5NDVtMzhLUHhtTVp0QXFvYkY5b0ZVcUZvMlhCREFQTDhwSzBESENQ?=
 =?utf-8?B?SmlLWUowb0lPcTY3S2NESDRrZHllYWl3RldWSFF2VnhaUUZVcE5lRWhkdUpE?=
 =?utf-8?B?RnFjZ3ltYk5Ydk5UMzJ2bnhLTlllaU1aYjk5WnV2QlNNaWpGOWFjTzY3QXU4?=
 =?utf-8?B?TnFGRDhUNHh5SVI4eTNmbXFJMEdCMWFUMXNORys3dkV1YXhoYkJORWMvY3FF?=
 =?utf-8?B?dlltYitqNjJkOTI0U1NsYnpGOU53RGM4R3M3bHRGZWc2TFpQakg3bFl1dFpO?=
 =?utf-8?B?V0pIamE0eXNSMUNXTDBHcUkzTEp5QUh1WkNibmFtdkZ4emtuM1BLWVo5RmZv?=
 =?utf-8?B?TjZNVmlKc2NScE0rZUZwWDNic3MwM0RyM1pmYTJScUEzc1Brcngwb3JiMStE?=
 =?utf-8?B?c2JONXZLWUd2U0dpVzBZWm9wQ29SWWNTTGx6VjFZMnpnWXZpQjQzaFIvY3ox?=
 =?utf-8?B?RjFKb0p3UnE5VFhOaFJLMFBsK0gyNVlWOU8rdlByd1pwL1lYTzkzNUI1ZTFs?=
 =?utf-8?B?akJLa2Y0YUdkUkR2cm9aTG1seU1ibnRmUVd0RHI4K2pHcGMvcVVyV2gyZEY2?=
 =?utf-8?B?aTBYcFN6Tno0N2swZlJLMTRxdU5TTFE4alpqRXpuc2s5Tng0dldMVGx1Sk03?=
 =?utf-8?B?VURLUG5hcDlaWlViZmxSRHA2M2l5aXAyaUh6V1pzTXBML3k0WjVVT1VTSnRi?=
 =?utf-8?B?cUk3RnVnNGZ5ZmhUVzBRbVk3ZU5FTmdBc3B4TUN0RnBkdE1xUHhRejlHQnla?=
 =?utf-8?B?RGExU3lZVTBzT2IyMUpxVjQ3ckxIaDZyei9JL1QxVzNORXcxSi9kZUpsSG9U?=
 =?utf-8?B?VFlDSXZpZU8yRmpMb2NPZFFBdldvVERIZ29vVFpxSXVVL1JjYitYQlAxRnA1?=
 =?utf-8?B?bWE0SnV3U1FUN2FtTkRCT1g0NmV3b1RFUUxUK04yQ3ppMlRjVVljTy9FT1NL?=
 =?utf-8?B?Rm9UNUR4ZEE4Ukd2UzI1VkdoZm1xNGpydUZ3NnhyWk9UaC9ScUhXME1KcFBM?=
 =?utf-8?B?Z2hZR21ueVBpQzRFRmsrYnRLd0tSRVY1d0hVVVd2bkI1c0crNkJZS1BOeDdF?=
 =?utf-8?B?a0RTYjFUcGs5K3VpTlRpUXJOdlZLQXpkOUxlNExhOUM4S2kvVjdiOXp3TlBj?=
 =?utf-8?B?YmhPU1VZRDlDeGhUN3A0RFE3clhiSDVudDNsZWNZeW5qc0RCZnlNK2tQQ1RL?=
 =?utf-8?B?U0VjclpMT3pOL0RaVytGR29jczJxNEo5emhiMTUwOU4xb1h0QVpWejdxZWJr?=
 =?utf-8?B?ZGI0MkNCV0lPdGd5NzJkVktvTVFlWVRQdmQrd1p2aXlnellUbVh0cnE3bFRk?=
 =?utf-8?B?R1pZZHA2Y2c3ZTdQSUJEOFdLM2xNelFES0QxdzMvdmtrSDB3TTYyZUxnYTJP?=
 =?utf-8?B?MWwzZmc0TEthUVliYnBBREViMUQ5ME9KL21OWWo0TTczZ2JGOTVxT3gzYnRj?=
 =?utf-8?B?UVZwRkVZRTdnc3lhOEQ2ZzgwaWk0YTVxSHNUc1ZRc3pjZDNZSXV2ZHF4bG9E?=
 =?utf-8?B?NkhtSWJqWUJMYUxuWUJpVm5iYzl6V1ZGQ1F1OE5ScWtiRFV4NFNpSTBhWkNF?=
 =?utf-8?B?WkZnbER3b0dBemtOQXlpOTI5UWFiUlE5bCt3VEFhVnc3QkRRM05MRkJOVDRx?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <421CEF0433D12840851441B05FC8C311@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fac7fe6-986d-46f6-0ea0-08db8f835455
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 15:57:22.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qi77EKD++cl3LUirZ23au/V5vRIryAKTtKufLbYKocl9Qb0aWTxndcl5wIETd0qDz+poRKZo7iblyBTlFYhJuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcywNCg0KT24gRnJpLCAyMDIzLTA3LTI4IGF0IDA5OjM0ICswMjAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDEwIDIwMjMgYXQgMTE6MjEsIFpoYW5nIFJ1
aSB3cm90ZToNCj4gPiBUaGUgY29tbWVudCBvZiBjcHVfc210X3Bvc3NpYmxlKCkgaXMgbm90IGFs
aWduZWQgd2l0aCB0aGUgY2hhbmdlbG9nDQo+ID4gb2YNCj4gPiBjb21taXQgZTE1NzJmMWQwOGJl
ICgiY3B1L1NNVDogY3JlYXRlIGFuZCBleHBvcnQNCj4gPiBjcHVfc210X3Bvc3NpYmxlKCkiKSwN
Cj4gPiBhbmQgaXQgaXMgd3JvbmcuDQo+IA0KPiBXaHk/IERvIEkgbmVlZCB0byBnbyBhbmQgcmVh
ZCB0aGF0IGNvbW1pdCBsb2cgYW5kIGZpZ3VyZSBvdXQgd2hhdCdzDQo+IHdyb25nPw0KPiANCj4g
PiBGaXggY3B1X3NtdF9wb3NzaWJsZSgpIGNvbW1lbnQuDQo+IA0KPiBaZXJvIGluZm9ybWF0aW9u
Lg0KPiANClRoYW5rcyBmb3IgcmV2aWV3aW5nLiBTZW50IHBhdGNoIFYyIHdpdGggY2hhbmdlbG9n
IHJlcGhyYXNlZC4NCg0KdGhhbmtzLA0KcnVpDQo=
