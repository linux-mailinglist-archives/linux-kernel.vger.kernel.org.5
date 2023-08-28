Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D8178B17E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjH1NU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjH1NUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:20:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A82211D;
        Mon, 28 Aug 2023 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693228842; x=1724764842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cay2VWEbHDj6xygUl5HdfFV9jX2nKkUusqrvrpUvKyY=;
  b=mCykWQBnpddzxc/dljDZRV9CfmRsTwEGDr1PZIHBhRTCDh3Il7nRfFbc
   NwCACjZ3eS8lZG+MAnO+GQoGolEFILWvECgotD6x2Rfnlh7QcR96Rh/aa
   XUQ6Nq+pvdrHNgTHGGL3bikn2lh3g+PJvn9M6SwACuIDXHHm8wqiz++ZS
   j3Mbe1oCq5ZBp0kYUTaN1kLeLQVWpJ4IlYxuyxNVn/b1bnPF2YzOE+Rw/
   HdvLvqaOYmDRb47sUIbEuf6lMmKLneOIrXKlWqzOP7jdmXXnb6ayBumYX
   iRHVJjEXQuvIJ1sFs5Hz+sD/ma1AR5R0/vhl8IRTXqynHh7KSPMFj2whv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="373989150"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="373989150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 06:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767681673"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="767681673"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 06:15:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 06:15:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 06:15:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 06:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju9GAVpYQSm1afFOUt6BP9Jom2Z/b5B7bGE5Kzeaq3RrRc0Bblez02+CkdYZA2KqDR1K43rjEFAVRYszpVhsLAdaUtiRgsu6AMEtK6wvpPzCVgHmv6DgXl7rp672g9U8knMufOT9zOswWwyCZVLS0Z+TVOanI/Kqagv/+YrPqvZuVOHQYusaGwVeCYET6H5+HE7fei9adhx7a76u6/TkECGePuG2YSj+4rM/4i7Mfva2k4wjIfWLbYta9Npiafbd+d4q/E2rG5+9EQDdzgcgZmWHgGG8GPJzSDEXWFZsId9KOUVATNTJyNkKg3S54eMbvygbdIhpAM5Fve2RH3aByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cay2VWEbHDj6xygUl5HdfFV9jX2nKkUusqrvrpUvKyY=;
 b=bHmJojwf+/wOo3ngFC2i/EcdPm318mB4Wb4FFYPk0LCQp3IQAs1cR3pXPqot0cZtCZvAyw0JYSsxYd/K9o1C+mUYmgehV1/unuv9Ka7C7xrwPi3T2L8Gn2/+/tlzde3aulxd1vmePbhHyURcxteE3Ioi75xVtuQVk43dk6BXuZ1HyOZRoECZmP4E4rj5mc7+0kORppNFvFVfB6iB2XrsSwl5zC1Oy5Ngg9JWspebXNe54M6/Zg0LyH1mJG+DYo59MAc1/8wPw6GONRsCiOqLLftbkfkwlz4GLHRHxOesSXdARUrARO/RAkI8m6mNidITQM4B3Y9YkXM+5ja6YlsQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:15:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 13:15:47 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 03/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Topic: [PATCH v4 03/13] selftests/sgx: Handle relocations in test
 enclave
Thread-Index: AQHZ11jR/0tuMj/3SU2XfvkGukyLyK//tMwA
Date:   Mon, 28 Aug 2023 13:15:47 +0000
Message-ID: <06f20425546aa13310a9fc25f081b8d70a6f1f44.camel@intel.com>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
         <20230825133252.9056-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-4-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB8133:EE_
x-ms-office365-filtering-correlation-id: d0373ef3-a5bc-4255-d32e-08dba7c8e48a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OT7jJrdvJa2mPW1v9/UZWo+FEoTgl6IFBYf0Ny7bNXmy7f6zp4wAT0mbIuBAsK/N6hAI1mq7Tqs17+1iMttrH0+klnc1/8vSKiDUYgHM9JUyixIZpiaFFXz+CF94YkJaXd/IpjrrX8RM4xg5t9kU9X6nTQgtWlw5PfZOFBBr4QfTA0tTEKOQCLIknTjMq+6oaqPxNbR+vId9d4duERC3o41Xn6oWbSVCvMPkQELrM6nJ9KJJpvt5GvxXXs01uH5CEIpNCwRHdJCUVviScxq7iD33om3lTARdeRkokwE5oXNYcFXv4AIm9E8iiSOlUZOFr5OUx7T8uudsykFEXviAlOUriiSPq09Ux2M+n2u+FvVe7+K8pIP17BlKttKAY8nPOsmRKT5d3EWwLMde7lKb1BI1hts1fftl1SIsn+VDgPc0j4f/hbFDJPaqBJe0txgpKQt8BWb2jXAnuKHvfcpVm0O9fKFU+iW8bC8a9y8REiWxsZZFWK7u1tgMIhAsaPTPzEQ4/+8pzgAYaeAanxZs+cov9AsJK8QsRe0ptS6OwRozv8937xx+2GJikeMQL30be2xzaNUkRp/j5D/KE8D67HjvnHdVIVLgW8rkDznZG0iUCPW+KHM6JAJFz2KlaH5ZLEdLI414leeTh4oKt8OMsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(66446008)(91956017)(110136005)(66946007)(66556008)(64756008)(66476007)(316002)(76116006)(5660300002)(41300700001)(6486002)(6506007)(2616005)(26005)(6512007)(38070700005)(38100700002)(122000001)(478600001)(83380400001)(82960400001)(71200400001)(86362001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZzcWY4S3JPanB2L2d6R2RPRnN1RjJGb2JtOHMrb1QzR1dGWU9sS3d0U0U3?=
 =?utf-8?B?TjZVcGlEY0IvMGJtOU9GYlZWa2xsUVA5RW5zRkIrVnUxcUwvSTZCMk50SmZU?=
 =?utf-8?B?bWVoVlhmKy9IVTRtSjFzOXl3MXI4SmdVdUN3SGhoUHk0b3NUcTZRaTl1eHNl?=
 =?utf-8?B?Vmk2YzUydEdOZ0NoSlJtY2t5M0UybnZGTmtsYUZCbGU3V0oyTWNLc0hsSHBF?=
 =?utf-8?B?UktCRm51bUJmNkRDNGZERGNjd0VNS1pqNHJIZDFxcGhsZHRENTBkN0ZwRmwv?=
 =?utf-8?B?N2d3c1YzQ2VEb3d3ZzNycUxFem9rRDFjdjhIeGpqVjlsSXRXSXBhUXRDWWd5?=
 =?utf-8?B?b05tN2VNalhnN0hiZm9GbFNQTmlESTlBZ0FXa3IvUkhHcFlNSy9XUlVSMHhY?=
 =?utf-8?B?aTVOaXQwMkpVWUxGeEtTcEZ1eGo1ZmZhWnhzd1pvVXZKdGcwQktmWUpjWitC?=
 =?utf-8?B?WFJ3K1N2RkU3ZUNEVTdrN2N0R0RPZ0F0OUtISWZUSis1K1hHRVQvODFqSTIr?=
 =?utf-8?B?Qkg3bThNNjJRWmFXc29QVFJ5bDdZSENkWDRodEZuOWdOUEcvUFl6Qjd0QVVj?=
 =?utf-8?B?UVA0VElGY2w5WS82Y3N1T2psR1hVMlpKT1AvOUp2ZkpwMEpuSlNCN3ErTGhI?=
 =?utf-8?B?cDBMbW1IQ3UyVlAxdFQ3NUxaeFhlbWoxaG5lWUFwRndwTnllZG4xOEFSWEp4?=
 =?utf-8?B?bHZ0aHRYWGZUT2VaZjZrMGxqRVlDeXlVMkI1REh0ZUxFelY4Qm9kc1Q4WjhI?=
 =?utf-8?B?ZnV4c1R0TGFnSUJyZVhObElvTDZMcTlFT2w0azRxdThTTnFYeGdaNlpBSlRl?=
 =?utf-8?B?QlU2bnRHN2NTRTg0dWtyYWRuOHYxYS9VWDBSS3VNeHFFZGtaMFdpTTNDR3JX?=
 =?utf-8?B?MllRMk9LMUh2bHVEVVlpQ2pLKzBBN2V5YzJ2SlN6STJ5ZFA3dEZrMjlGd1Jp?=
 =?utf-8?B?VjlCdytxMlNlWWFpQUdFNU9mTW0rR2FnRkVPaW9CbkFXR0l0SGxxNS9oZDZG?=
 =?utf-8?B?TmdXZlZnbkdYWk54bGduK2k1S1FhbEppbnZNMGtyMlVBVGRxUGI1eHVVZ1dy?=
 =?utf-8?B?cjVvVTdNMWxGc1JldmNJQ3FMYUoxUDVIbVFrRFRzTjgxdU1JNkpwMGk0aFA2?=
 =?utf-8?B?QVFmQklLZ04yMkxVNm5Pc3FPZ0xBUmQxdFF0SU51MlhMUVNvWDZHWWpiMTY4?=
 =?utf-8?B?L0psQU9PYlU2ZlYzSzRSWlVWeEZqVXI4T3dmYk5tUEh0RkZEU1NBZXFKRGc5?=
 =?utf-8?B?THUzVHY0RTQweUw5RWVXOURsZlUrMXZONUVzVlhwTXg4bWt3VlIzTHFHUFZu?=
 =?utf-8?B?bzRhazQ3MVR0SmxKUklaV1M5cndYVzNNN0ZtaVczOHptZ3lCQWJlVzFLa1VW?=
 =?utf-8?B?YjVLM3o2RFVXTmpzeWhHd3lxRUtzM2xlNUxHZUNieGhXdWdYODdndDJhU24y?=
 =?utf-8?B?V3JYUXBnY3JVczBCSkRhVldLa1d0OXozUXZaTVpvclJEZWpZRDFpSTQ2dG1t?=
 =?utf-8?B?S0VsR3c5cUFlVXNVdUVmODJhWXZDTUh0TFl2ZTFpRXJYYXgvU2c3UGFtL2NN?=
 =?utf-8?B?U1pON0xabWhwek4zV0xqWmlhMW5zR2RLTTlyeWw3SEk5Szh2MmVsc2FjRk82?=
 =?utf-8?B?a2tyMmtyN3ZlMHptRTltbERtY3VndXpGNVo0YTFjUGhRNGhCdmlXdE8yQVBV?=
 =?utf-8?B?cUhJUWthWElzYW9GUkpOdzJlcXlnUjFObkkxN284MnA3dU1WSzl5ZVpScmNC?=
 =?utf-8?B?VG1NSGlmZ3dnNXhNOTFzR0xTUFZlbzg3SS9Pdzl4bE9NcnBrSVlpdmltb3ZJ?=
 =?utf-8?B?NXJuOWJzTWdBZXFsb1YycDdOYWkwWGxyRHJyNURGVGhMdmtpZ2lqMGxlQnp1?=
 =?utf-8?B?WXJTR24yWkd6a1VrQXJHLzdxaDIvN2dJTlJpdWlGeWxmVFlaVzhJaGNDODM3?=
 =?utf-8?B?ck9wejRnVzBMM0RiU1V1TEtIL3R2cHdiZzVqWlRaRFRYV0paZzhWMkpBc3pH?=
 =?utf-8?B?cTBQaGJNSXZ6L2JwMGthQk9yc0hSN09sUTlGQmNOVVM4YzJtcndlQmtuT2Zx?=
 =?utf-8?B?Q1JnRlpEUUVQSHAreW5MV1l1RHExOWl2ZGtLbXVoUTZJYm1vTDZtZHU4dFlN?=
 =?utf-8?Q?03ueeDu6VvhY0Ue9zRxtmwIqf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01B376AF23132546B3283B89D2CB97F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0373ef3-a5bc-4255-d32e-08dba7c8e48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 13:15:47.2065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uml+6HCq01E8x5P8h6sCmFd5WFkJHK36d/u0oRFFTDjsAojVnLRMMZcuTXKnvlEyCsxtuZqlEwLxF9LhHDjwYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTI1IGF0IDE1OjMyICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFN0YXRpYy1waWUgYmluYXJpZXMgbm9ybWFsbHkgaW5jbHVkZSBhIHN0YXJ0dXAgcm91dGluZSB0
byBwZXJmb3JtIGFueSBFTEYNCj4gcmVsb2NhdGlvbnMgZnJvbSAucmVsYS5keW4uIFNpbmNlIHRo
ZSBlbmNsYXZlIGxvYWRpbmcgcHJvY2VzcyBpcyBkaWZmZXJlbnQNCj4gYW5kIGdsaWJjIGlzIG5v
dCBpbmNsdWRlZCwgZG8gdGhlIG5lY2Vzc2FyeSByZWxvY2F0aW9uIGZvciBlbmNsX29wX2FycmF5
DQo+IGVudHJpZXMgbWFudWFsbHkgYXQgcnVudGltZSByZWxhdGl2ZSB0byB0aGUgZW5jbGF2ZSBi
YXNlIHRvIGVuc3VyZSBjb3JyZWN0DQo+IGZ1bmN0aW9uIHBvaW50ZXJzLg0KDQpTb3JyeSBmb3Ig
bGF0ZSByZXBseS4NCg0KSSBhbSB3b25kZXJpbmcgaXMgdGhpcyB0aGUgcmlnaHQganVzdGlmaWNh
dGlvbiBmb3IgX3RoaXNfIHBhcnRpY3VsYXIgcGF0Y2g/DQoNCkV2ZW4gYWJvdmUgcGFyYWdyYXBo
IGlzIHRydWUsIHRoZSBleGlzdGluZyBjb2RlIHcvbyB0aGlzIHBhdGNoIGNhbiB3b3JrIGJlY2F1
c2UNCnRoZSBnZW5lcmF0ZWQgYXNtIGNvZGUgdXNlcyAibGVhICgteHh4KSglcmlwKSwgJTxyZWc+
IiB0byBnZXQgdGhlIHJpZ2h0IGFkZHJlc3MNCmFuZCBzdG9yZSBpdCB0byB0aGUgYXJyYXkgb24g
dGhlIHN0YWNrLg0KDQpJdCBzdG9wcyB0byB3b3JrIGJlY2F1c2UgeW91IHdhbnQgdG8gdXNlIC1P
cywgaW4gd2hpY2ggY2FzZSB0aGUgZ2VuZXJhdGVkIGFzbQ0KY29kZSBpbnN0ZWFkIGluaXRpYWxp
emVzIHRoZSBhcnJheSBieSBjb3B5aW5nIGFuIGFycmF5ICh3aGljaCBoYXMgZnVuY3Rpb24NCmFk
ZHJlc3NlcyBzdGFydGluZyBmcm9tIDApIGdlbmVyYXRlZCBieSB0aGUgY29tcGlsZXIvbGlua2Vy
Lg0KDQpTbyB0byBtZSB0aGUgdHJ1ZSBqdXN0aWZpY2F0aW9uIHNob3VsZCBiZSAidXNpbmcgLU9z
IGJyZWFrcyB0aGUgY29kZSIuICBPciBkbw0KeW91IHRoaW5rICJ0aGUgY29tcGlsZXIgZ2VuZXJh
dGluZyBjb2RlIHRvIGluaXRpYWxpemUgdGhlIGFycmF5IG9uIHRoZSBzdGFjaw0KdXNpbmcgUklQ
LXJlbGF0aXZlIGFkZHJlc3NpbmcgdG8gZ2V0IHRoZSBmdW5jdGlvbiBhZGRyZXNzIiBpcyBjb21w
bGV0ZWx5IGEgbHVja3kNCnRoaW5nPw0KDQpBbnl3YXksIGl0IHdpbGwgYmUgdmVyeSBoZWxwZnVs
IHRvIGluY2x1ZGUgdGhlIGFzc2VtYmx5IGNvZGUgZ2VuZXJhdGVkIGJvdGggdy8NCmFuZCB3L28g
dXNpbmcgLU9zIGhlcmUgdG8gdGhlIGNoYW5nZWxvZyB0byBkZW1vbnN0cmF0ZSB0aGUgcHJvYmxl
bSBhbmQgd2UgbmVlZA0KdGhpcyBwYXRjaCB0byBmaXh1cC4NCg0KV2l0aG91dCB0aG9zZSBpbmZv
cm1hdGlvbiwgaXQncyBiYXNpY2FsbHkgdmVyeSBoYXJkIGZvciBwZW9wbGUgdG8gdW5kZXJzdGFu
ZCB3aHkNCnRoaXMgaXMgbmVlZGVkLiAgVGhpcyB3aWxsIHNhdmUgbWFpbnRhaW5lcidzIHRpbWUs
IGFuZCBtYWtlIGdpdCBibGFtZXIncyBsaWZlDQplYXN5IGluIHRoZSBmdXR1cmUuDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpvIFZhbiBCdWxjayA8am8udmFuYnVsY2tAY3Mua3VsZXV2ZW4uYmU+
DQo+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYyB8IDQ4ICsrKysr
KysrKysrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9l
bmNsLmMNCj4gaW5kZXggYzBkNjM5NzI5NWUzLi43MDZjMWY3MjYwZmYgMTAwNjQ0DQo+IC0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gQEAgLTExOSwyMSArMTE5LDM5IEBA
IHN0YXRpYyB2b2lkIGRvX2VuY2xfb3Bfbm9wKHZvaWQgKl9vcCkNCj4gIA0KPiAgfQ0KPiAgDQo+
ICsvKg0KPiArICogU3ltYm9sIHBsYWNlZCBhdCB0aGUgc3RhcnQgb2YgdGhlIGVuY2xhdmUgaW1h
Z2UgYnkgdGhlIGxpbmtlciBzY3JpcHQuDQo+ICsgKiBEZWNsYXJlIHRoaXMgZXh0ZXJuIHN5bWJv
bCB3aXRoIHZpc2liaWxpdHkgImhpZGRlbiIgdG8gZW5zdXJlIHRoZQ0KPiArICogY29tcGlsZXIg
ZG9lcyBub3QgYWNjZXNzIGl0IHRocm91Z2ggdGhlIEdPVC4NCj4gKyAqLw0KPiArZXh0ZXJuIGNv
bnN0IHVpbnQ4X3QgX19hdHRyaWJ1dGVfXygodmlzaWJpbGl0eSgiaGlkZGVuIikpKSBfX2VuY2xf
YmFzZTsNCj4gKw0KPiArdHlwZWRlZiB2b2lkICgqZW5jbF9vcF90KSh2b2lkICopOw0KPiArc3Rh
dGljIGNvbnN0IGVuY2xfb3BfdCBlbmNsX29wX2FycmF5W0VOQ0xfT1BfTUFYXSA9IHsNCj4gKwlk
b19lbmNsX29wX3B1dF90b19idWYsDQo+ICsJZG9fZW5jbF9vcF9nZXRfZnJvbV9idWYsDQo+ICsJ
ZG9fZW5jbF9vcF9wdXRfdG9fYWRkciwNCj4gKwlkb19lbmNsX29wX2dldF9mcm9tX2FkZHIsDQo+
ICsJZG9fZW5jbF9vcF9ub3AsDQo+ICsJZG9fZW5jbF9lYWNjZXB0LA0KPiArCWRvX2VuY2xfZW1v
ZHBlLA0KPiArCWRvX2VuY2xfaW5pdF90Y3NfcGFnZSwNCj4gK307DQo+ICsNCj4gIHZvaWQgZW5j
bF9ib2R5KHZvaWQgKnJkaSwgIHZvaWQgKnJzaSkNCj4gIHsNCj4gLQljb25zdCB2b2lkICgqZW5j
bF9vcF9hcnJheVtFTkNMX09QX01BWF0pKHZvaWQgKikgPSB7DQo+IC0JCWRvX2VuY2xfb3BfcHV0
X3RvX2J1ZiwNCj4gLQkJZG9fZW5jbF9vcF9nZXRfZnJvbV9idWYsDQo+IC0JCWRvX2VuY2xfb3Bf
cHV0X3RvX2FkZHIsDQo+IC0JCWRvX2VuY2xfb3BfZ2V0X2Zyb21fYWRkciwNCj4gLQkJZG9fZW5j
bF9vcF9ub3AsDQo+IC0JCWRvX2VuY2xfZWFjY2VwdCwNCj4gLQkJZG9fZW5jbF9lbW9kcGUsDQo+
IC0JCWRvX2VuY2xfaW5pdF90Y3NfcGFnZSwNCj4gLQl9Ow0KPiAtDQo+IC0Jc3RydWN0IGVuY2xf
b3BfaGVhZGVyICpvcCA9IChzdHJ1Y3QgZW5jbF9vcF9oZWFkZXIgKilyZGk7DQo+IC0NCj4gLQlp
ZiAob3AtPnR5cGUgPCBFTkNMX09QX01BWCkNCj4gLQkJKCplbmNsX29wX2FycmF5W29wLT50eXBl
XSkob3ApOw0KPiArCXN0cnVjdCBlbmNsX29wX2hlYWRlciAqaGVhZGVyID0gKHN0cnVjdCBlbmNs
X29wX2hlYWRlciAqKXJkaTsNCj4gKwllbmNsX29wX3Qgb3A7DQo+ICsNCj4gKwlpZiAoaGVhZGVy
LT50eXBlID49IEVOQ0xfT1BfTUFYKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwkvKg0KPiArCSAq
IFRoZSBlbmNsYXZlIGJhc2UgYWRkcmVzcyBuZWVkcyB0byBiZSBhZGRlZCwgYXMgdGhpcyBjYWxs
IHNpdGUNCj4gKwkgKiAqY2Fubm90IGJlKiBtYWRlIHJpcC1yZWxhdGl2ZSBieSB0aGUgY29tcGls
ZXIsIG9yIGZpeGVkIHVwIGJ5DQo+ICsJICogYW55IG90aGVyIHBvc3NpYmxlIG1lYW5zLg0KPiAr
CSAqLw0KDQpJcyBpdCBiZXR0ZXIgdG8gZXhwbGljaXRseSBjYWxsIG91dCB0aGUgY29tcGlsZXIg
Z2VuZXJhdGVzIFJJUC1yZWxhdGl2ZQ0KYWRkcmVzc2luZyBjb2RlIHRvIGdldCB0aGUgYWRkcmVz
cyBhc3NvY2lhdGVkIHdpdGggJ19fZW5jbF9iYXNlJyBzeW1ib2wsIHNvIHdlDQpjYW4gZ2V0IHRo
ZSBhY3R1YWwgZW5jbGF2ZSBiYXNlIGR1cmluZyBydW50aW1lPw0KDQpNYXliZSBpdCdzIG9idmlv
dXMsIGJ1dCBJIGFtIG5vdCBzdXJlIDotKQ0KDQo+ICsJb3AgPSAoKHVpbnQ2NF90KSZfX2VuY2xf
YmFzZSkgKyBlbmNsX29wX2FycmF5W2hlYWRlci0+dHlwZV07DQo+ICsNCj4gKwkoKm9wKShoZWFk
ZXIpOw0KPiAgfQ0KDQoNCg==
