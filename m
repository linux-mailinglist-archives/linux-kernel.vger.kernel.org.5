Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC337BF82F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjJJKF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:05:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643B93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696932325; x=1728468325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sXzCu463SfuJ7pOQpjRcPAptfcihhHYQhaU59eUjZwE=;
  b=HtZ9uzIwusgF2uhIUUEEBgAYuqAoDvt7eV0I8THF2OkhqXNpnmuTCPiz
   9HY3v9uTGaf5uFfpJAF2Y4TAvRGtlfpDpZRAMN2cNqp3/W9WezUEjjl7X
   nx42CPxp/wMzzwGeSWHaRurDMIcvVf2CxQ4CZpZRzuomKc4qCHL7QZJuf
   mfYY62i8ROK21Ir3accSyrsjwAy0F/6CJhDyXKGxZaqlf9XdD80UawJKh
   9DHDs/HTZ/A3qfa3tSZDuEH57Mlr4ZBn4SoBA2XfFz6pN43Iskd0pu9KT
   +sVUs9H/uEhec1t4lleBgtPdjJ3HfBkg1Trv8/ra752CHYCwl9pnKlrf1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2943081"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="2943081"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:05:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000628961"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1000628961"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 03:05:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 03:05:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 03:05:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 03:05:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 03:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elw3okZo9Az5O/h4eb0+4HCNydI27CCewYxcW2kq5h5jCEDjjX1vMOu8xt3pP3w+UvNV6VdqiYXySsSVVPtMN9LXME+43ZlY3Mi0K8nd9iavPY8UsbpQkpFLIj7T6/uslD33RfRCkpYNq5ixyGEJ2YQpRUk8DLgYjZrRiyfZK5JS1etJSrQthYw6yBD6zRavEzRxPJbQkaJAqxgVVrclAtr7Z7/lVhTz3xSVkSTAhSrAtGtlos/rj/mtdRBVFxzYlvInZxXeH9qOh+IzNg0i25esjGcHT0lTuP0dPzGA9FdWb6NPiPkaSY4EiG8wJpJ/BilpeFQDn04DFRceI1bw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXzCu463SfuJ7pOQpjRcPAptfcihhHYQhaU59eUjZwE=;
 b=mRMxAH5Kto1uyuojKCzzt1+gA4tPMCQzkWSwn6ndA0zbtnKxxKzo2pl8zBmqGL0rQxXeKRRzo08X57Q4G7hxyDEox6/QoIgN7TaJTfjO7pm/31QuFgK0Y1WNvqWJZCTyK1/d5z1xIto6grvP0G/4hhKB9cvwiHyWmAdqOiRUnNBr8BzB7ej/YbrZkfg/Cj7hzqvso3+qzER6LVJ+w59NaiZWZwpQPP3bu2doVM9SwMQ6QJe6B7GyOR+Ox2Euhk6F+JEfyBcaUCRzDL/ntq2CyruN4XhJDYJzsWX7qgZYETFmOkE6D9WoEQKDWrGG5S3cy+lb9xUBgz9WYdyE4x8a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 10:05:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Tue, 10 Oct 2023
 10:05:21 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 09/13] x86/tdx: Account shared memory
Thread-Topic: [PATCH 09/13] x86/tdx: Account shared memory
Thread-Index: AQHZ94+b3gr2DIicdUGgApJXbkIWRLBC02kA
Date:   Tue, 10 Oct 2023 10:05:21 +0000
Message-ID: <f3776d2b6d45e74b4d0e62eb4e788c578132c21c.camel@intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
         <20231005131402.14611-10-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231005131402.14611-10-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB5089:EE_
x-ms-office365-filtering-correlation-id: 961f4906-5e51-4745-88b6-08dbc97869f0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBaupfxGO9uPwWZz3EKxthJoiszuUWCTKbzwepozjJIkjfXnLCX7x3ILK69y49gJn5UzaEXZbgpUy32GWUBiV8UHzSqPLSu8PAanHOZ0b8zdNW1i1W6+1U9jAjlW0eUG6I9Rjjbn/TiyVVDSSY49wCKOfTWSxLtHY7vXVTtz6ogIjwVp9bd4lu5zgbbI/GONrIvwxToMDKV2nhTeHgkLiOG8Y7FG9sunUCpQaWkN+kB9WyLPawO4FzguGmLKeFu/DJCcrsadI23ofpLz+uc224ViQxsDwRyPvUDFGtfkiezTWiAf8TparPsYtL83sMZyc8sNqGyphi4VH+3kEeEzSLwhoxsP2uk7WC84p8HKBZuGvo8OZe1yBQf67Ro2OF0nsDz+WL44vn9GmV2VnZPDOQMUlDF9jLyiNBFGHdbD1vty8EQHhi/zJnS+joCizJDWq+6gBROXBcfey02KueQ5mvXKU48g4GoEXl7uZY06t21aqVg8F/1dOA4G0KUQ+ZUwwNzGQJJOli4Ow/Nlk1t8ej8xSwNrF6HvH1cR3ao+PMhq4KXlzErB6IOjM6BnTZujoOyszgBzKKrkL6z+q6ksVTD0e3kxZ9jzPiJz7F00yl2oWd2ogsCD+8cWjbCuim5Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(36756003)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(26005)(4744005)(2906002)(15650500001)(83380400001)(7416002)(6486002)(71200400001)(2616005)(6506007)(478600001)(4326008)(8936002)(8676002)(41300700001)(5660300002)(76116006)(110136005)(91956017)(66476007)(66556008)(66446008)(66946007)(64756008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVd4NFdaU1JDNHphOGM1NlFkcGRNQW1iN05abGhEUWFobFVvQ3l2NjhyUHB2?=
 =?utf-8?B?MlJhMmV3aDNRb1VSQTE2YmtMN2RiRGFCdGlla3NER2Q4THNzaHp0S3E3U1hW?=
 =?utf-8?B?ZGZLZno5V2twNGN3L3VSM28vT2xEcW54Lzc0dWtjQzk5R2dHVEl2VFU3OFNs?=
 =?utf-8?B?SUtLdEJweUlpZXg1Zit0NUszMkxwQWE4R2YxZ3RSSnBlVTNwK252MG1IMkJq?=
 =?utf-8?B?QnNZbmhKaDFhbXh6WUo4Z2JMMmNieHlCSG1paGhxSlhVSUV6aFNDKzMvbEZj?=
 =?utf-8?B?SFdSSmdYc0tnSVhKL0R0d2xwTTVpU3lIRGtqV2xhZ2MrR1BFMEFhc014Q213?=
 =?utf-8?B?QmREK3FKZ3pmMXhKTlZ1QmJDdENYZUFOK083VFNtd3UzYXpBYTVzcys0ZFpo?=
 =?utf-8?B?anlkT0FObkRnb3prdEFrYmhSelBuK0I1VXBXV0FTUmZnZHdVc3g0Z2pxMGIz?=
 =?utf-8?B?aXNyaWw0M25id0kycmhEME81L1hpK1JrL0dmZEVXR09xWmVETmludG81M0RW?=
 =?utf-8?B?OU9LYkdWdHExZUpjYktFWGhBdmtnVWtlVmNpTmZTVkJ5dmpjYmVWTnp3c3Zx?=
 =?utf-8?B?MFAvbFRWeXBaSHJrTkh0MStNSHppNzZqTUNZNDRIL1g4LzgzR3FVWGFZMEww?=
 =?utf-8?B?VUhVZUxPSVZYU3BZaS9PWkZIaWE3Q2FpUlRQa0VoVDlzTmxMZDBGTUszR1B0?=
 =?utf-8?B?L05tS1lUcEFMeVNpQ0phSEFEQzlVV2xBNWFqYlBNREV6QU55N1A4aDArRDZU?=
 =?utf-8?B?SnhyVS9LbldXak5VNTdYTHFqeDRDLzZya1dUTFZUYmk1YlhXdXl3bzVhYnlZ?=
 =?utf-8?B?TXBrb2VuOHZoQWpkSTJDM21oVGI2VGJ2bnlFY0R2ZTd2d1hxZnNRc01iVG1k?=
 =?utf-8?B?Ump2d3U2TERQcDRFTzM1aXpJZ3R5ZUVXcGtGaWJpQmQzVGhrQ0JvQlArd0Mx?=
 =?utf-8?B?M3BxcUdyeUw5RGR2Ym5rWkpHeXJxcnVVM0MwUzd1YUtLRGhqWWdIWjVqZjdS?=
 =?utf-8?B?V1d5MnlvVlhzOW9qK0xpNXVuVE9RQ1JHek03UzJRZVJEN21zSWJ1QWtsbHZv?=
 =?utf-8?B?N2RtT0dIcW9IMFpjS2k5VCt6QlBJS2hoVmYvU3FlODU5TmFNQjRYREtsTzhV?=
 =?utf-8?B?dXBjWk1IMFl4eTd1UHBEcWJTamI5QlZnRTFzejFOUUEyR0hpa3JWdFRxQzMx?=
 =?utf-8?B?ZzV2OUNQRjU1NmdkMWxBQmg3em50akFHYk9lS0lYTlhtbVpZUllVOG9XQThT?=
 =?utf-8?B?MGhNcTg4NnZheXp4QXNINlRhUzNYc1BGdDNuR0kyNFJLSWFJYW9pRC94Z2Ju?=
 =?utf-8?B?ZzdhWk5OYVkyUWROcFdsRU9ma3BpakYrOWk4TkJqVGMxN3dsRmR6Z2RwdC9p?=
 =?utf-8?B?WVlMRG9yKzQydzdWNFcwcHRjWjBoUkxTNS9pUWlJcWJFWGltMEFidExEY1Fj?=
 =?utf-8?B?eUNqeGlXalVveDFoQi9Pb2RPZU1tWGJEZkJZUEs4SUVXRzY5cTlNMFpyRmRm?=
 =?utf-8?B?Ni9oNmIzMitERlloVXpIT3BBMkpnM0x0ZE5LSFl2RFI0OHh6N01jVU1PL1Rq?=
 =?utf-8?B?bzFKczluNWpqUFZ5WW1xbGswL2JIRys4cTFlME5NVjFoKytlVWJuK3pCSVND?=
 =?utf-8?B?cVVNclBUaXhZRU9mU2VSNUFXNHA5eEszbzN3R05qYkZ1R0RMOWlPK2xTTWFE?=
 =?utf-8?B?OGZRQzlNOEo5RGMya1QvakROVWx2Uk9NaVp5Zld5ckNUSTVZVkhBS2pFYXRy?=
 =?utf-8?B?aGpCMTdWcGM5VmlQdkd3UlZmaXZsRHhEWUlkTXN0dkN0di9BU2x1Q04zZWN0?=
 =?utf-8?B?SEJmVWVCckhwRWZwYk1PNFNpNk1BV0NFVGxlY0d5VjVYYUVnM2FwMkR6MFhN?=
 =?utf-8?B?UlZkSVJ5b0ZZTXkvYUxkM0VKNzhZbis3c0llcW82RXZzVm44bHVpdWtUZkpT?=
 =?utf-8?B?VVdRWTNPZEU3MCswdlAxbk9obzBEajMwV2hYTVFqWGdyaG1YeWUydFVBRXhs?=
 =?utf-8?B?Ty93Tjc3cDVGNU0rQlBsNXFaTmllRUhFTmRIbSs1b1IyRlhNWGVrc1B6WjZ0?=
 =?utf-8?B?NHZYaTJlTWhjZ2pGVEs0Zm14c1M3UXBTaVFKeS84SkRNMVlweStDTEZUeVE1?=
 =?utf-8?B?eWtSZHZ6UFgrd2VDWm9GOWVoRUoySW00bE9JMHUxYkZrcXdaSnhsUDFHNE5W?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61C5C39587D5E645A32C02B66783A93D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961f4906-5e51-4745-88b6-08dbc97869f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 10:05:21.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeYv0eEmu18+J8TpgrEkZ3pU/fYPPr3UcPprAhmzj6imgkuqjws+JtUqkvV3HN1nfyOw7e6qY2bhKc2B4/xm+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ICtzdGF0aWMgaW50IHRkeF9zaGFyZWRfbWVt
b3J5X3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICpwKQ0KPiArew0KPiArCXVuc2lnbmVk
IGxvbmcgYWRkciwgZW5kOw0KPiArCXVuc2lnbmVkIGxvbmcgZm91bmQgPSAwOw0KPiArDQo+ICsJ
YWRkciA9IFBBR0VfT0ZGU0VUOw0KPiArCWVuZCAgPSBQQUdFX09GRlNFVCArIGdldF9tYXhfbWFw
cGVkKCk7DQo+ICsNCj4gKwl3aGlsZSAoYWRkciA8IGVuZCkgew0KPiArCQl1bnNpZ25lZCBsb25n
IHNpemU7DQo+ICsJCXVuc2lnbmVkIGludCBsZXZlbDsNCj4gKwkJcHRlX3QgKnB0ZTsNCj4gKw0K
PiArCQlwdGUgPSBsb29rdXBfYWRkcmVzcyhhZGRyLCAmbGV2ZWwpOw0KPiArCQlzaXplID0gcGFn
ZV9sZXZlbF9zaXplKGxldmVsKTsNCj4gKw0KPiArCQlpZiAocHRlICYmIHB0ZV9kZWNyeXB0ZWQo
KnB0ZSkpDQo+ICsJCQlmb3VuZCArPSBzaXplIC8gUEFHRV9TSVpFOw0KPiArDQo+ICsJCWFkZHIg
Kz0gc2l6ZTsNCg0KVGhpcyBjb3VsZCBiZSBhIGxvbmcgbG9vcCwgcGVyaGFwcyBhZGQgY29uZF9y
ZXNjaGVkKCkgaGVyZT8NCg0KPiArCX0NCj4gKw0KPiArCXNlcV9wcmludGYobSwgIk51bWJlciBv
ZiB1bnNoYXJlZCBwYWdlcyBpbiBrZXJuZWwgcGFnZSB0YWJsZXM6ICAlMTZsdVxuIiwNCj4gKwkJ
ICAgZm91bmQpOw0KPiArCXNlcV9wcmludGYobSwgIk51bWJlciBvZiBwYWdlcyBhY2NvdW50ZWQg
YXMgdW5zaGFyZWQ6ICAgICAgICAgICAlMTZsZFxuIiwNCj4gKwkJICAgYXRvbWljX2xvbmdfcmVh
ZCgmbnJfc2hhcmVkKSk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCg0K
