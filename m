Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA84E782795
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHULKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHULK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:10:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF2E6;
        Mon, 21 Aug 2023 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692616227; x=1724152227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oM3ec2Ik9Mg+l847x7koLnvqOJHrrSc+TsJc8LyvfG0=;
  b=bjrMyt6rbpkrirHY/5YoUKRxFvVSA0I3Pt/9G9tybAWI2d04xLgVNRXC
   dfYWaDBZlsOh38adyWIA7bXdkFyQxVVPqfi0c2d7lQMVU+YkvxUlGBvoV
   TLofXYRY5/UJzFKBGZkadDLUcxVTVlU6cPmiOkken3hPJTE56SBuSi2Ud
   j3MSQg+p5b5rfHfPq0/eCN8OnMhhV2oiF5i94R+yRd82P+P4nt48keONT
   G1XCH0aUcUHGGzKnJOE3vdLwNjOio0yH295DjbPshSipmRbiwWB2wxmii
   qU2Wp+RlKECxCfVKnZV8/1AG4EdQ98qLnJtZyB9xlsM70EKwxIMrt2yZQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="439932799"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="439932799"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 04:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765329496"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="765329496"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 04:10:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 04:10:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 04:10:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 04:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtnlFEuQDSNGxh+VXSoyKmOYN0YT0XXVtF8pgpz55QbgHOY8ACsPhmAC1loZX6YDzvKAPt4Arn/c3JmTyMH1GI22MzfXtqGJ8jT6ta16lg07YH1DNUOWPQcLxdFSdetMQpx23fkILkcsyrs1GLysMN+llBiwaIMJktxFxvHn0Iekz21EP3sJ+dTnhjXz2RCkrU1/+KnYu3QmFxzisbgenSdNDOFrtrFi6HPNxAVZuvAjfVlymMcKE+xWCZ3ClLln0c6YISpGRYvO3zNjjyJz49U5g20hL3LB+LgrisOA/E/oNGxzHdqiqPG6/0BPluxqckmB9yVI8a07NHt0wNGxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM3ec2Ik9Mg+l847x7koLnvqOJHrrSc+TsJc8LyvfG0=;
 b=VyHHswRVhiv1gE+d3J+2j5QVpLlS5yQ+lpQli5MUNC70MKjM4RQrNqjBmPoMXFEKjBFrIt0vhRIGWoIzz+yRNhJy7iV5M2LN2n/6BuNQ+KQIT8dCkHmcGCGijB+pmqbjXnDDXPosKxw8MGP97LSZlNqeTUO4J3doBBvtYJL9FG/nrxssykOeXYCVUDlNW+ooLpOgOBzGlEPzUpttnCH+iea6MotWajK17+0NRnEbjOXJbwMMd0TjSeGg62+9sqtv92gkYTO4hsdJC5ZY0W+TByEy9um93odFmsqfRFFzE8YKMs8BYA5d4SR3ZrYXOyO5Ut7k01BH4O/6njF38ByMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:10:20 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:10:20 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 7/9] selftests/sgx: Ensure expected location of test
 enclave buffer
Thread-Topic: [PATCH v3 7/9] selftests/sgx: Ensure expected location of test
 enclave buffer
Thread-Index: AQHZ0oHTTNQy6SBr+UCryh4SWoYmkq/0mx8A
Date:   Mon, 21 Aug 2023 11:10:20 +0000
Message-ID: <b9e818ceedbe053b3d42b0e1853763ad0d47df50.camel@intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
         <20230819094332.8535-8-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-8-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: a147cdad-0fe0-477c-3a51-08dba2373546
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zyFwQrcSMwQQK0Qc8LHtQOb0Mmrj/3Wpye2NBfB+aDOCBszo1IVh6K1GM+DaO1sYCAfL1eJGJO/0lZ/IY6/MzY1mPSZP9uD2h08WRxqiN9v1OJUnkJ7XuKephyFvJUMAPPtnSzF4l/063duBgaBG1G6uVV6qX2DSo86fe98cJD0Gz3PEcB5dNKX6u3a4WWIsgRu5iKnkeu8UHwk4Z9ckMwUAi4uGRp48hUQjdMPD3rWKWTutdh1bEKewXRlQhASSN+fXGDSgYNoaMMPko1CJBGCsjPzjIJvAl6m7dYNAlTChJwokHD66VMzlmL38ZBh7LRhIawyqoy76mmBzjhqMXCByCPEGwjqrirZW5eT8eJayoloMMGzQh5+3uyBDFKrxQJpEA4iz+Qq8diM1YnKSN2zRYEP7uIy00UxTEp5LyzQxH6Ct+k3DMefH538DCAGCfhoHDzTICgmIzuwBNQya2WqmhQM1Yq47Nr4mV4F33vQUvlJi9RZYbJsFEoK2QtZS/JM8p610DdABHodf0LsRKHKnY2RAUMjnC7lKo+Q2gQBPf1NJ4DtaWAzIbF4QS1mfRSZmJhqckL07n4wxFCreAdQEAVlv2G8vUvHIThVeZQS0M1Sq24KrTWUDBr/uhU6S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(451199024)(186009)(66556008)(41300700001)(66446008)(64756008)(66476007)(76116006)(66946007)(110136005)(91956017)(316002)(6486002)(6506007)(82960400001)(38070700005)(122000001)(38100700002)(26005)(8936002)(8676002)(4326008)(5660300002)(2616005)(83380400001)(6512007)(2906002)(86362001)(36756003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRIYkJXZHg3L0FnRkd6NnJHcDJwMCtoNnFvMHRGL0JpNVJ0NHhDekVYVHJ6?=
 =?utf-8?B?M3o2MFIveWlQSWNzTkhPdXcxM3ZXZ04rY1FCMlJQdDlPYWZucHlUSEQ0Q1dw?=
 =?utf-8?B?RVV0blB5S2luVzk4VUdjTmZoRnAyMW1zWnFNcm01RDhJMjIyRGhmMkhyQ3A0?=
 =?utf-8?B?eHo4ZmZtbVBaeWFQa1hlaFRGL2NtYkJkNDh1T3dEMlJmN09VUUwza3NJdHlV?=
 =?utf-8?B?Um9aUnlrR1ZYcC90dVZ6b1VFSWxzRTZQV2FGdElsQjIvWUxkU0U3YW9wSnpn?=
 =?utf-8?B?dUcxOWxMalR2MTVSMlB4ZVVmT3VqRFlxQ0x3d1g2cFNWRGdDVHdYblFibDd3?=
 =?utf-8?B?cWN3Mkx1c0RhNmxTTG5ZZGZrZkhBRXNxZ3VtNnR0SHhxZ052NGc5WStVRHV6?=
 =?utf-8?B?ZjZ4UElnMjlhc3VLQ1ZGWnc4NnVlSEZBUDIrWGc1Q1B0YkxRWWczWmdidFg4?=
 =?utf-8?B?M3RmWFk1YXpGbkc5blUzRUk3bm1tc2RTdmVoRVFMSzdieEtqMWNmS0NMNWRE?=
 =?utf-8?B?M2sxK0RlSWlKN09YczB3cGxnWlBrNnI2REFDUy91alJtUHF6cHdROXVYd3Y3?=
 =?utf-8?B?ajNaalB6SHlpZzY2SEdxKzBvd1lUcU9xSXlHMDAyOVJ4S1FYZGpwVXg3QVp5?=
 =?utf-8?B?OUltRFdRbjhuZGx2ZlNYT2hsT3NPUS9uaWVqQnd6TlFOczlSMm1OLzYzVmYv?=
 =?utf-8?B?L0RONGhMQ2lNQWpjMHFXWG9jMU9LWDdHcDB6bGRYb2szaEVwZVREYzR6QzRL?=
 =?utf-8?B?UXBqNFJlZVhWeTZ3TEcxd2c5cyt1a0V6Rk9WVFNseW12SlpLZkVCOXI5Q2w0?=
 =?utf-8?B?MDRMYjl3ZzdESGZCUEwzbDV0aTlDWUFSeUtyZnhRdCtiQlJxSkp4cG1TbEdm?=
 =?utf-8?B?cXRZTGRxQUlkbGFqYlBtUFpTTXhNUmZ2RGdTRWppS1ZObk1YclJVQXBwVzRE?=
 =?utf-8?B?MUpvWVhZK1ljbzFkL3czUjhMb25LME5QdzgrKytBSEJ5ZXYrQVhBN3k1NFF2?=
 =?utf-8?B?akIzOTdiNnJ4cXpxSU5HWHNsV1JtU1UyNkcyeVRqVE9mQW5hOVgrL2NXU2lv?=
 =?utf-8?B?SjZBRDNaUmEzUDNmK09uQkhZdys0eHkvbmJBcHRPUWttaklnb084UXREaDgx?=
 =?utf-8?B?VjlpVUxqdnQ4OGlGQnBGRStzL1ZIL0lHT3M2YmpUYjQxeW9tTkRpaGQya041?=
 =?utf-8?B?a1pEWWNKNVpobU0xRHpuTXVJZnNlcWQrZ2lmYlpML1pTWmx5SUc2NTRHZ1BG?=
 =?utf-8?B?UGRWOHVIalk0RWhsSHQ5RDFOcXlKUUNKYmw4WmovTWE3L2VZVmNTNWgzaGdO?=
 =?utf-8?B?dEhmcUhKWVoxcXlVaUVxQzFaNEFWVTl5S04rUDFoQ0NiUzlJZmdWUjVESEdK?=
 =?utf-8?B?RHpXL3FJVkh2MEw1N0RXc002Z3o0Q1BQQ08rNzFubkZnOVZkUTlaa1kzbHBj?=
 =?utf-8?B?ZlEvQTg1Q0diU3FuQ21RQ1M4Ym9kZmllNVJqdllScUh1SkR6TjVGTVZvdVFF?=
 =?utf-8?B?M1JCVjFNUjQzb0kyQWRNQ3lkVGROMWdJU3JzZGhVcGV6TVp1QUc3ZlVaWWtK?=
 =?utf-8?B?clhSRUw2WXFpZFZLTHlrM1VuSFJPSjUwS1BpR2MycGNFSmltNHNlWGNqSjcz?=
 =?utf-8?B?YytxZlFzNUhibVFlbXY5S1NvQ2t4YTFINU9CRU14bzFCaG9oR2tSSjdic2J5?=
 =?utf-8?B?RjYyU2ZzLzQrQWZ3RWhaK0xFWXdsVElabDNGcFJoVGlGb1F0UHRNQnhDRzZq?=
 =?utf-8?B?TnJENDRmemltYk5CSzNqMHY3bGIvNDJMRm84S1FSTkhDejZ2aUM2S01ZNUlP?=
 =?utf-8?B?L1p0aTNUYmxjV29odmcxZzM0MVdOeUtXeDNueWVxb0l3TzRHeEN2c1lQQ2V2?=
 =?utf-8?B?YllZVVdzMWpycVIzL2NLVzl4Y0lxeU1CUnV1d3VMS1UrSi9nOHNaZWVUWE1E?=
 =?utf-8?B?ZHhCaVN0QWF0WGM2QmNWZHVVK05XbGFqQ3FHaHpvVFV6Znl1ck5HUmJGaVlD?=
 =?utf-8?B?ZWE4cU85eGEvNGtuYWhpcU51UlhpTDB0RDRQUkxYdjlKQWppVVk5VSs5OUhy?=
 =?utf-8?B?b0VrRnlQazdGaXZVN3B2R2czS0VWdHdjYjFMVTV1RWYrbkEybElDQm1veGo4?=
 =?utf-8?Q?jHo6yt+6F2+Ypl51aaZRomPrd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC240C551613B4595A4FC746354E232@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a147cdad-0fe0-477c-3a51-08dba2373546
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 11:10:20.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mrWkmpQBEQlqhwPQslxSd/4gAU96tmhznBX067kQb56/q1X2a3aXpR7YRdwmciXlQV4Zrwykbyif7ZTkstaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDExOjQzICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFRoZSBleHRlcm5hbCB0ZXN0cyBtYW5pcHVsYXRpbmcgcGFnZSBwZXJtaXNzaW9ucyBleHBlY3Qg
ZW5jbF9idWZmZXIgdG8gYmUNCj4gcGxhY2VkIGF0IHRoZSBzdGFydCBvZiB0aGUgdGVzdCBlbmNs
YXZlJ3MgLmRhdGEgc2VjdGlvbi4gQXMgdGhpcyBpcyBub3QNCj4gZ3VhcmFudGVlZCBwZXIgdGhl
IEMgc3RhbmRhcmQsIGV4cGxpY2l0bHkgcGxhY2UgZW5jbF9idWZmZXIgaW4gYSBzZXBhcmF0ZQ0K
PiBzZWN0aW9uIHRoYXQgaXMgZXhwbGljaXRseSBwbGFjZWQgYXQgdGhlIHN0YXJ0IG9mIHRoZSAu
ZGF0YSBzZWdtZW50IGluIHRoZQ0KPiBsaW5rZXIgc2NyaXB0IHRvIGF2b2lkIHRoZSBjb21waWxl
ciBwbGFjaW5nIGl0IHNvbWV3aGVyZSBlbHNlIGluIC5kYXRhLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSm8gVmFuIEJ1bGNrIDxqby52YW5idWxja0Bjcy5rdWxldXZlbi5iZT4NCj4gLS0tDQo+ICB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvZGVmaW5lcy5oICAgICB8IDEgKw0KPiAgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5jICAgfCA4ICsrKystLS0tDQo+ICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmxkcyB8IDEgKw0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L2RlZmluZXMuaCBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NneC9kZWZpbmVzLmgNCj4gaW5kZXggYjhmNDgyNjY3Li40MDJmODc4N2EgMTAw
NjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9kZWZpbmVzLmgNCj4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L2RlZmluZXMuaA0KPiBAQCAtMTQsNiArMTQs
NyBAQA0KPiAgI2RlZmluZSBfX2FsaWduZWQoeCkgX19hdHRyaWJ1dGVfXygoX19hbGlnbmVkX18o
eCkpKQ0KPiAgI2RlZmluZSBfX3BhY2tlZCBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKQ0KPiAgI2Rl
ZmluZSBfX3VzZWQgX19hdHRyaWJ1dGVfXygodXNlZCkpDQo+ICsjZGVmaW5lIF9fc2VjdGlvbih4
KV9fYXR0cmlidXRlX18oKF9fc2VjdGlvbl9fKHgpKSkNCj4gIA0KPiAgI2luY2x1ZGUgIi4uLy4u
Ly4uLy4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NneC5oIg0KPiAgI2luY2x1ZGUgIi4uLy4uLy4u
Ly4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2VuY2x1LmgiDQo+IGRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9zZ3gvdGVzdF9lbmNsLmMNCj4gaW5kZXggYzdiY2JjODViLi4xNTE2MDAzNTMgMTAwNjQ0DQo+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wuYw0KPiArKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gQEAgLTYsMTEgKzYsMTEg
QEANCj4gIA0KPiAgLyoNCj4gICAqIERhdGEgYnVmZmVyIHNwYW5uaW5nIHR3byBwYWdlcyB0aGF0
IHdpbGwgYmUgcGxhY2VkIGZpcnN0IGluIHRoZSAuZGF0YQ0KPiAtICogc2VnbWVudC4gRXZlbiBp
ZiBub3QgdXNlZCBpbnRlcm5hbGx5IHRoZSBzZWNvbmQgcGFnZSBpcyBuZWVkZWQgYnkgZXh0ZXJu
YWwNCj4gLSAqIHRlc3QgbWFuaXB1bGF0aW5nIHBhZ2UgcGVybWlzc2lvbnMsIHNvIG1hcmsgZW5j
bF9idWZmZXIgYXMgInVzZWQiIHRvIG1ha2UNCj4gLSAqIHN1cmUgaXQgaXMgZW50aXJlbHkgcHJl
c2VydmVkIGJ5IHRoZSBjb21waWxlci4NCj4gKyAqIHNlZ21lbnQgdmlhIHRoZSBsaW5rZXIgc2Ny
aXB0LiBFdmVuIGlmIG5vdCB1c2VkIGludGVybmFsbHkgdGhlIHNlY29uZCBwYWdlDQo+ICsgKiBp
cyBuZWVkZWQgYnkgZXh0ZXJuYWwgdGVzdCBtYW5pcHVsYXRpbmcgcGFnZSBwZXJtaXNzaW9ucywg
c28gbWFyaw0KPiArICogZW5jbF9idWZmZXIgYXMgInVzZWQiIHRvIG1ha2Ugc3VyZSBpdCBpcyBl
bnRpcmVseSBwcmVzZXJ2ZWQgYnkgdGhlIGNvbXBpbGVyLg0KPiAgICovDQo+IC1zdGF0aWMgdWlu
dDhfdCBfX3VzZWQgZW5jbF9idWZmZXJbODE5Ml0gPSB7IDEgfTsNCj4gK3N0YXRpYyB1aW50OF90
IF9fdXNlZCBfX3NlY3Rpb24oIi5kYXRhLmVuY2xfYnVmZmVyIikgZW5jbF9idWZmZXJbODE5Ml0g
PSB7IDEgfTsNCj4gIA0KPiAgZW51bSBzZ3hfZW5jbHVfZnVuY3Rpb24gew0KPiAgCUVBQ0NFUFQg
PSAweDUsDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9l
bmNsLmxkcyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+IGlu
ZGV4IDEzMTQ0YjA0NS4uZmZlODUxYTFjIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmxkcw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9zZ3gvdGVzdF9lbmNsLmxkcw0KPiBAQCAtMjQsNiArMjQsNyBAQCBTRUNUSU9OUw0KPiAgCX0g
OiB0ZXh0DQo+ICANCj4gIAkuZGF0YSA6IHsNCj4gKwkJKiguZGF0YS5lbmNsX2J1ZmZlcikNCj4g
IAkJKiguZGF0YSopDQo+ICAJfSA6IGRhdGENCj4gIA0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxr
YWkuaHVhbmdAaW50ZWwuY29tPg0KDQo=
