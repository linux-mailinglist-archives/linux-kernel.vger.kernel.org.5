Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BA680913D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443684AbjLGT0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjLGTZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:25:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02A1986;
        Thu,  7 Dec 2023 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977153; x=1733513153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XMrjLVMjUEvpEELZS4JDD23gBCvSRhZpOlceS4inHJo=;
  b=VKK9aFea3+CR3or/WzRR29I6VWZSURC6bOErKro/8T5Cx1wjvQ4uNiT4
   aSdKZWjkkRDoe5NUeFKRt/MeCmowsqPZPLmoEfOKqMkP24/fBIrDnsN8Q
   isx5fjyK7qr0SXo19lRx0FHy2Jm9bFz6moF+GlReqzoWqY8zqhpbRBlKO
   Nh/XeztJXv1kHzT/R9ODBjp8awBiswpmDJn1n8RpOFFwx/Czi2ab8WmgG
   ihcYhsEkVLO78+sy8OD15LOVo2Z7jpeLsAhdEoB6BH7h045xvGsUWQoVJ
   yuoXetBS9XqX4XtgQb0lCoIa8hMwvhOqtEvAPKC3b9uB5bv/Q/LeuAJgS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425432045"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="425432045"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721590262"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721590262"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 11:25:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 11:25:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 11:25:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 11:25:44 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 11:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN9fySTFO7mKY6EJdiTjQddezQwNcElUMDMFYmt5Mww499tcoZt/IcmSM2iM14LS0RsoSjoqzQykWxbWp865CzFuO6cTyLoVZPiNtQxV7Ed2toQKpylZwl2TXmdwGIviUo8VjwkbVukMIHN0VDLJJH3Y3S5WrxCGYxFdp4cFm2MgWFfStjp83/QtiM+hNIPcpnsXO01YjXVNA+LFEyvYkR0fQxaX6KKbFqixjWi5zTjTHJRiQu+IRyKhSPU+7WtksnCg4hOyl0ervy9Z+ji0xlKubZApqJYfGuYlos8WiLZDQceGyrxmF0cXecyjLE/2B9OstH9hNL6Co1HkXJ+Uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMrjLVMjUEvpEELZS4JDD23gBCvSRhZpOlceS4inHJo=;
 b=FwlhKyoRWVUNV14Domi3jn9fSGT5b11Ukd0y5CqUW15FEoKyvtWZ28o6EPf7KZkzJuXal5dJph/MTMtyPNZfQyhYXfTTCnIUpCW0KgYVIEEJBnHvQ7xCqOVHAnPJw6GMEA/ODFu7ERHMNqKJLx0yyYIADapVG81/RF6OY+UK/SDAJgIG73B009KooWgMyzb1p/4TU6kop18uupx/OMQJ422AeyTiAE7a+LUMNYSKTCeRNfhe0cpbct3WCajR3gwMGd/CKVt2jsIosuMKGLItjAzXnrOVVTNw8G5KUOWREb1u50LJRWN09idyqzqcrvgPNZCTeVvKVI/s0keidE7HhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA0PR11MB8334.namprd11.prod.outlook.com (2603:10b6:208:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:25:39 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Thu, 7 Dec 2023
 19:25:38 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMbu7P34L+weQECt+BHOvhNpUbCdfY8AgAC3MoA=
Date:   Thu, 7 Dec 2023 19:25:38 +0000
Message-ID: <96a55ffddd8f6a00ff00e6a67e50d30129ae2456.camel@intel.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
         <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
         <4b1a415e-6a56-455a-a843-277cc08d05a9@fujitsu.com>
In-Reply-To: <4b1a415e-6a56-455a-a843-277cc08d05a9@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA0PR11MB8334:EE_
x-ms-office365-filtering-correlation-id: 4b9837c1-1693-4bfb-c78d-08dbf75a4b88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64cu8MUeWAAyomhP4NXrA+TaaUY5LhWy03ICWk3tOLXZ1IHu9uRG+fSi3cXi+GTWKbzuROEwVXlsaX4idJ624w1Eai3MTrmhEsxtHB5m+KssGHpD8moqQzDcTUvgSDRV3/Cdx/rMT+uPE0QINpUJ7ttV6w0O+s+5zNjNdT/dDenago2CvelTEka3Df6xupKBKVKp++ZcQ3o4kqtL1t+K4fCsJElQziWuZomIITViqID/wqU9poKXruxXJiNL68JaV2W+sjUyzFSQfl7+g1jupNA+pjMVYMMxuDNFvAEbbNy/6RfoLvTc5hQsKrCVpL7i+TSDXnTOK41jTtaBX8BATavaGlK1ex4PiiQsF8a50tafkk8uYr8YMoBpjZ+0uqwxKkfNrdWA5lmklwZPsdRjjAwNvprNgC207b1WCjWoFzodv7rJ7dgcw2aknPivRxIQQkfkPEohZHVP6n556TfdTTEr5/CLJBqHlxjOo1LHtmInQiKB4mGtggLFFeEro3C4ahdX5FjCVqsWoRzW3PEe/zuYriifTQihGNS+3XyC0s/urJCDF4PHfkt7ghlv3Df63/kKA6xbSOEa2PmSqkvrMe5J61SDoNreilyh3H/RC6gKPBAtLgNhsbCQwEvu3Z2H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(110136005)(316002)(76116006)(66946007)(66556008)(54906003)(66476007)(66446008)(64756008)(6512007)(6506007)(71200400001)(26005)(36756003)(41300700001)(2616005)(478600001)(6486002)(38070700009)(122000001)(38100700002)(86362001)(82960400001)(53546011)(6636002)(2906002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhhNWVzcDUvM2dRSlhaeFpFS2VwU1Fya0ZCTzZDTklnOXBsTjdXNkdBa3FP?=
 =?utf-8?B?bFphcUtrMloyK1RqM3Z5Y1dOQStLVWcrTFB0QXZta2RUTGxkOHVrUTFsY0JK?=
 =?utf-8?B?TWZiU0hOblJyeVJyY21RTmlYZlkwblJFWkRJdDFUVkNlYWFiWGVzOVJIZ3Zl?=
 =?utf-8?B?L09PaUpUOXp1ay9DTCtVSkhrVDIvRTBnRWVNemZvYUV3RFRXQ2tRQkY5Wldp?=
 =?utf-8?B?WFNVMWtBRHBsa2RheEVkcU9JMkk3cWRIWDNFalg3Z3Z4cjJtZ01rMW52ZmFG?=
 =?utf-8?B?aWg2aTZDblhYNnBvMXNtOU5kR0VIbWFaTXhaeHNCbEJSNjhtVFJKUk4yK0J1?=
 =?utf-8?B?aUlDb1RUVXBzSGR0cHYrWTBVb0F4QzBPVTV2K0NmNGEvRU83MDVleXVQVTNy?=
 =?utf-8?B?MlFyZlNHdlFRWjRFNmNvOTd0VXAwUVR4aWE1WTlFYUJZa01NRjQwSUtYYk1W?=
 =?utf-8?B?YXVENHN1U1ZENStxZzVCUXp0Rzl0WHUzY1JVdlRSTDBIYXljWkYxb3lmSkRV?=
 =?utf-8?B?MUllLzFaWThqR0ZyeFMyOFNJaUpibDgxMmhCeEh1V3dqZFFldUxFVzJxVFMr?=
 =?utf-8?B?TUdNb1FjTWJCTTB5YXpOdnNXL1BwSU9zeWRBb3VlN3pFc2U2bCtlc2UxcGJT?=
 =?utf-8?B?cGFHNGw3TitNRlg2cTdoM09yaWR4bHE5bkdxTVppdHI3eEZLSnJuU0dMY1VM?=
 =?utf-8?B?Mm0xT2NmTnJZeHIzaE5rV0d3U1EycndTcG5DRWxOaWZwbVY5VmF4Y1VDUEor?=
 =?utf-8?B?cG9iUlA5SmhOSElsTDNsSTNxZUNYUG5yUlFsT0JKMWFyYVQrOXlzQnM5aTkz?=
 =?utf-8?B?WG1BZnZDc0pCVlVuMDlub1ZrdHJCcEpkcWVYL21OMkxZNHVBVUVycjFtK2V2?=
 =?utf-8?B?VzZrZnhFWndFRW5qOWloY2E4a05lQjBYbVlQTy9weEVlczhBN2ExVWVkYTdK?=
 =?utf-8?B?bmpjUlhWS1VnVVpQc0RDc0dkOWFNRjNUYmMwOEtvcEc5bW5haUxVL0JSdklB?=
 =?utf-8?B?S3hWbXp5LzdTRHRKQUJyYmJxeGQrTjJUdWFOU2FoM2V6eHk0cE56bVhYUnVK?=
 =?utf-8?B?VUFFOGZ2UXNsNTU2aUtZVStFek0xWkV2VEFRSUhxN0w5N0lpdUR0eGVHNlBl?=
 =?utf-8?B?TC9DMytHVEdEZGFWNCtyVG1qTDNaRVNOcEF5YTBqVjd3RDhjendlUXRLalZs?=
 =?utf-8?B?bzRWd2owYTlOL2ZaQzk2SXczNW5UaFVvZzhwa1ZGNmlId2pCV0NQMnZwbGpo?=
 =?utf-8?B?RDB0Z01kSHVqc3R3YjFkcGFVZEtsSm51Yk1id2QwaTRnVXNTclQ2RkFJQVov?=
 =?utf-8?B?SndMVXZpamZUejE5dXNGTVM1RmlWTVdrR3lFOUJhcFQxSy9OYkNSOHhIUWVY?=
 =?utf-8?B?cHhCb1pRNnVSVUxGYTNnTXhNVnA3NERvRGlna2VpVklmY1IwL1AwdFNCVllI?=
 =?utf-8?B?Um1yYVlIU2dOc0YzMCtPVFdvRFd1amVveTdTSkp4bjM0cGJ4bnRvTGlvRUxX?=
 =?utf-8?B?cTdkNVF4ZUU4cHFkTkNCcGhzK2JTbFVsT29GV3hjbHVmWTVTeXFwVkxwNGhh?=
 =?utf-8?B?dHZWQVVUQlFiZk1hZ0NRZzg1VlVRYnhTNXRpYURlNVZvOG5lUE0xc243SUJy?=
 =?utf-8?B?YzN2cGVORWtpalVNSWkwSW5MRTlIQzE2aE1lemx2RFd6VXhoV1FjcnAzbWhm?=
 =?utf-8?B?MXV0ZVdqaXJnWm9KbG93SVNkYW5qV20wejJKOFBwUEd6U1p4Si9tTnhmL3R5?=
 =?utf-8?B?R2VSVWxlRGFTd0NUdTA1S205RGlyY0ZaSEZtUm5VbmM2SVFVYzhhNlhtR1pY?=
 =?utf-8?B?MnE2TnRudE9yOG04aW8vZUR1dzE4d2MvQUhjZXdJd1YyT3JZTnpobzdBL0sz?=
 =?utf-8?B?RTUzWDFISng1Qlg0ZzBwNEN5SlFMZWNkY2hwWUxVK29zNWhhejV4bk9DVHUx?=
 =?utf-8?B?L2ZsUGNjTTJLM3oxYVJqTGo4cTRYbXZrcUJKejJjbXNNMEk1cWZMNmRybno1?=
 =?utf-8?B?WmtYSWVGbi8ycDdYaVhVT2YzTlhVRE4zUEwwcXV0dGFXNUJ0dzkvM0pyU1Jr?=
 =?utf-8?B?Skg4ZXZGb3NyaUdEazBTQVcxcW1JTkoyUUQ2bk1yUzh1RkVYNkYxdGk5TjFi?=
 =?utf-8?B?Y3hTdGNEMWhzSWROdDFNRkFXWlZMZ1N6cDhtOFd2Wm9ETnpxYVBJZFo2bCtZ?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F529E7286719540B8E8798704A0F6B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9837c1-1693-4bfb-c78d-08dbf75a4b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 19:25:38.9347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtUYGHiH76vQZE1Ft8yXBIvrM2cA4RD+nlvqSU1Qxvu/cwI/BLCQm4ODkuL4EQM53WSLMt8jjkhU9fiizIpjrinVuBqC81x+uryWRyktxSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDA4OjI5ICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3
cm90ZToNCj4gSGkgVmlzaGFsLA0KPiANCj4gDQo+IE9uIDA3LzEyLzIwMjMgMTI6MzYsIFZpc2hh
bCBWZXJtYSB3cm90ZToNCj4gPiArDQo+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lz
L2J1cy9kYXgvZGV2aWNlcy9kYXhYLlkvbWVtbWFwX29uX21lbW9yeQ0KPiA+ICtEYXRlOsKgwqDC
oMKgwqDCoMKgwqDCoMKgT2N0b2JlciwgMjAyMw0KPiA+ICtLZXJuZWxWZXJzaW9uOsKgdjYuOA0K
PiA+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgbnZkaW1tQGxpc3RzLmxpbnV4LmRldg0KPiA+ICtE
ZXNjcmlwdGlvbjoNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKFJXKSBDb250
cm9sIHRoZSBtZW1tYXBfb25fbWVtb3J5IHNldHRpbmcgaWYgdGhlIGRheCBkZXZpY2UNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2VyZSB0byBiZSBob3RwbHVnZ2VkIGFzIHN5
c3RlbSBtZW1vcnkuIFRoaXMgZGV0ZXJtaW5lcyB3aGV0aGVyDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHRoZSAnYWx0bWFwJyBmb3IgdGhlIGhvdHBsdWdnZWQgbWVtb3J5IHdp
bGwgYmUgcGxhY2VkIG9uIHRoZQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
ZXZpY2UgYmVpbmcgaG90cGx1Z2dlZCAobWVtbWFwX29uK21lbW9yeT0xKSBvciBpZiBpdCB3aWxs
IGJlDQo+IA0KPiBzL21lbW1hcF9vbittZW1vcnk9MS9tZW1tYXBfb25fbWVtb3J5PTENCg0KVGhh
bmtzLCB3aWxsIGZpeC4NCj4gDQo+IA0KPiBJIGhhdmUgYSBxdWVzdGlvbiBoZXJlDQo+IA0KPiBX
aGF0IHJlbGF0aW9uc2hpcCBhYm91dCBtZW1tYXBfb25fbWVtb3J5IGFuZCAnbmRjdGwtY3JlYXRl
LW5hbWVzcGFjZQ0KPiAtTScgb3B0aW9uIHdoaWNoDQo+IHNwZWNpZmllcyB3aGVyZSBpcyB0aGUg
dm1lbW1hcCBiYWNrZWQgbWVtb3J5Lg0KPiBJJ20gY29uZnVzZWQgdGhhdCBtZW1tYXBfb25fbWVt
b3J5PTEgYW5kICctTSBkZXYnIGFyZSB0aGUgc2FtZSBmb3INCj4gbnZkaW1tIGRldmRheCBtb2Rl
ID8NCj4gDQpUaGUgbWFpbiBkaWZmZXJlbmNlIGlzIHRoYXQgbWVtb3J5IHRoYXQgY29tZXMgZnJv
bSBub24tbnZkaW1tIHNvdXJjZXMsDQpzdWNoIGFzIGhtZW0sIG9yIGN4bCwgZG9lc24ndCBoYXZl
IGEgY2hhbmNlIHRvIHNldCB1cCB0aGUgYWx0bWFwcyBhcw0KcG1lbSBjYW4gd2l0aCAnLU0gZGV2
Jy4gRm9yIHRoZXNlLCBtZW1tYXBfb25fbWVtb3J5IGRvZXMgdGhpcyBhcyBwYXJ0DQpvZiB0aGUg
bWVtb3J5IGhvdHBsdWcuDQo=
