Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559D780B29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376684AbjHRLap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376766AbjHRLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:30:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CED3C3F;
        Fri, 18 Aug 2023 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692358226; x=1723894226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SsCQzr5Qo1aqEf7apZ0q4hLi5x7VFXy8oU2WDSAHR/8=;
  b=ZbRU9Saush9IETjzW5yPy6lyv9zDFtrYp2NcGGehHhWJ5vapaD04dh0d
   pTK8y3PM7/8pJb9f4jjjRmf1DBu+gmnsuobczP7HKTGxnvCL4wi80AFE4
   jInb9SRbIb/RxudvPb/uCFVuUR8ECyDWG0yUu8tL/fwlOsSOQekuxwwGY
   Ptb2SLQVX6jORF3lpDIzQVD7MkZghvNz/lnE1rGbScfEYA8yXcg3hv1iD
   xm+/2y/GgZpfYD+FtB42/jBdEy2jnoClNI0F6mqmECvAVj60jqoKwgep1
   GNxJ6M4+Q0EXDUMz768nbQOMmFUJeNnuHKTRVsBEiXNWe/9IPNy0i+V7H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="373061390"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="373061390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800442541"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="800442541"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 04:30:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 04:30:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 04:30:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 04:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMKQgqhaKLkacJaw7LuqOp684n/eJZLGzE5ZgmjMrhqLPt3+1T6RG8Xp1TbowJM20zJc10b0IyOnLYMg8f1Dht8nClGJgdR/JIyrUVhG8GH2zYjCosED3cRC7AT8Rb9CgL8gi2bppahaL82/UoQHycjsyZXuLmRaQIq7j81BuEnmPx2pK4cfsnkcupDxOJ9POoA9FLgYCF7AWSPSJ4RA/pEGzQ52iVhNXixSFRYbM2p2etxB48gj9eOL/nXAlaF0G+jQ4wyTo7d7IoQNmQoMs6GNbSmszfteZzRhQnbLQ0l3JW8MD+s0N5/lC9JX9rvNT7rmqDNKI+Tc9oyMFiv1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsCQzr5Qo1aqEf7apZ0q4hLi5x7VFXy8oU2WDSAHR/8=;
 b=SR8pvw+knWKvlIxKH3KwBiaD0NED/Om5m7QF1Ik6yWJ/N+BqfWPqjqv2R19h1Su1HjA7B5AgF0tOZDC+HopezxJG1yxG9C5Eo4J1OEDYpb1qd3D0XcN0nILD9cDg4UKQybtKbJmRYe0dg6aRjS+3zPNdLF7jbnn/EbS2XmFBzOni7Z/cD8ASHEtEjMpDBWxlOSAHumUi8tjJplasoiZhY5Mq4/s3uyYqCFlV/n8xkFnmKJYmKIEUuRf/IPVR2nU7ea50vuvTGZAdLgUFPXMGUArYa7zere7sLFM9uO2U65Td1CON+fEQ6LdmFAQirppIUpTWkr1LGSU4wb7Kj8gLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:30:21 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:30:21 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/8] selftests/sgx: Fix uninitialized pointer dereference
 in error path
Thread-Topic: [PATCH 1/8] selftests/sgx: Fix uninitialized pointer dereference
 in error path
Thread-Index: AQHZyi8dkdXcW/mN7UCSqartzsAoha/v+lwA
Date:   Fri, 18 Aug 2023 11:30:21 +0000
Message-ID: <f900b6ffe0e7bc7237be699eefd4db7d971060ab.camel@intel.com>
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
         <20230808193145.8860-2-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230808193145.8860-2-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB6851:EE_
x-ms-office365-filtering-correlation-id: 5f14a97c-112b-494e-69a9-08db9fde81ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KsllbilgKxBCjwCs7beJ9BlzIuovYGf1qPjVUPP58fxrZWF5awpCgUnKAhZST8bzeYdbHVPUSuDA3G3fZgC5y9JDpZkb0auw5TxStaU9B2RyPlZoVaM51iOF0uWLHjXHJ0de7isYyOa9cXF/uab7vd+9sj/85ZYRSHYKipha4xgt/1noHZjUKTKxO068ClcFb6dHeXDtm4NFMRfxv9oOI3vZHUGWfOuwD9OEpbzRcsGG/CgjRsKcHb4TFJqOey0iyZBZ7ofldOZaXReq/f+TomSMH2zcsl5DtJMoxoR1bqoRsB/Vk8vr4y7HJ8nRDQhxhR1gazsD4e0LDNhQ+XuFrvA7ojge+bnwm7Lw/6EqHrLnnLYm67/OTJEq/r/95vdETGLmsARu1jGutJmVTdHrmW/d5g0qaDNfdiWJgimZ2Cw3iYc3sh81G8nBova35oJ0+XvWQrzKbPOB8tc0bIoXLvjDtojw+TRjYkR2koZXhKdVJwPMnj7uL+JANdOSrsKwkoo3MIlMjQAuimqChXlRtta+jWgn7wixlPCURQwzQ5X0VmQZiO7zgGTdLiT4KaindivU4qW+mCOnA6HXPjfm2X9RdlXdNL4vDfnuoRcs6Cjgju3P8XfQ46y3RYi8a58l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(36756003)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6506007)(71200400001)(6512007)(6486002)(2616005)(122000001)(478600001)(76116006)(82960400001)(66476007)(316002)(110136005)(64756008)(38100700002)(91956017)(66946007)(38070700005)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mnp6eWQyTVUxalZOMVJOQ1cweEErMUVQN1dDR3Z1dFA4bWUxNWtYT1IwVW5y?=
 =?utf-8?B?MmdUQ2JLdUZySkJvZGY4OG1udmhjdHBnenp3NU9ZbzZrTUNwT3VXdFpDZXdu?=
 =?utf-8?B?cHA0M1FyN0NyK0prQnA3VTU2Wk5ES1MySERXUmtlU2JBV0s5eXZ0Z095UjhG?=
 =?utf-8?B?SlNsRCtXZ3FMN1c0eGcxbGl4cllsdkI2dHE2WDVZUTJEbGFVUi9sMmxXajhN?=
 =?utf-8?B?YjRPNnlPMlJNblVhWUZhVEpUVXF2N3ZTT2d2OUhkZkJ2bTArUE9KdVhSYnBi?=
 =?utf-8?B?TjZIS2MwcHUrR3d3d3N1Sm80ZXo0dmw4c1FkVi9kT1paaEF1N3p6UlpQM1pL?=
 =?utf-8?B?ZE12a0dyT2UwT0hTU1Q5K1UxMlRNeWtFY0lsTXFqTGErWkZMVmZMN3dKZ3cr?=
 =?utf-8?B?LzhpVjYwQ3hwcmx1b3FsWmVJRVhOcnRqOE1IZVZkZGQ0Yk95cnpQbXBPK1NW?=
 =?utf-8?B?emlVTkpCQ3NqU1R0b2YzT2laWVNjaWFJanZnTXhjekd0d1hYTWdBUWJadDN1?=
 =?utf-8?B?VEtEQWMyd0daWGFkWk9YVFVQTG4zNzhDb3dXNUUyanBpbnhxNEkyMzQ2bkNM?=
 =?utf-8?B?dFQwVVFubmJhWmlmTkx4V0tSY2RWZEduUnNXUlM4N0VpVkhteVFMTFo4UDdl?=
 =?utf-8?B?TDNDUVlKdk1wM24rdllCUzNJSUhCajJyenQ3NTlkTEVMUThJdVZwclZFT2xF?=
 =?utf-8?B?ZzNyY1lleEFvQVRhaURyNlJKZXgvblh2TGlkRS9WTDhCTWRQVzBuQ3p4TjFO?=
 =?utf-8?B?ZW45VU14cnNVQzNielJJRW9OaEU1RTVjc2owK2Z3SjdwRHJ1clcxWVJBbFh2?=
 =?utf-8?B?aXBQU1pUWGZKUk5LeXlMQTJLdXQ5N21mV0hDQ2U3YUwwRGZ6L1lPNmFRT1Na?=
 =?utf-8?B?VmxNTEV4SHVHN3haS0RVSEcrZGhvV09IRHpiaWhGZG5CTWVXTm00YzBsVm43?=
 =?utf-8?B?aGlLdi95MG5FVHZlRjFJdEhvMWE2WnZtUEVLRytFVS9tTXpML3pTRGsxMjV1?=
 =?utf-8?B?Z1F6cFBORG1QL3cwTzVQTW5LRlJhdWFzbnAzVjNoTHJFUlF5ZXhZcmYyUmtl?=
 =?utf-8?B?R0ZZTlJpWmd5UVZHM1JkTFFvYVpKYmZuUElTMWZXTS80RmJBaVNyV0gwL0py?=
 =?utf-8?B?V2hiTXBVTDA0Z2JWd3ZKeFhhbWk3TE5CaGJOQlFuL1VqNGdNaDFXd0hEenNQ?=
 =?utf-8?B?OWgrVjJYaXZ4ODVJbVd3dzNsTTIweFhlcVJhd0lQTDRUYVlDbzhzWUJMMUNG?=
 =?utf-8?B?aEI0YVNLQnB0eHBkQlo4Z3NwdU5GRm9KZDdnWjZTQUxJblpQekprZDhpd3dX?=
 =?utf-8?B?QitXc3FSUi81SEwyTWg2dEdaZlFQUXJLdzZZejhMRlFoVENscElFZ1c2K1Z4?=
 =?utf-8?B?WlNLUTJ4QVVNbDdVK0Z2NmRDRkpYUllOSldaNGZoSUF2QjZreGlnaW5wbzRF?=
 =?utf-8?B?VmtGaEhaRHB0NFFsRTMwQnp3bzVDK3NBdWVUd21ZcFNVQW9jOGhvQkpWWmRC?=
 =?utf-8?B?cFpjcklvT3k0MjBEZ3pqdC9FbmY5Z2F0azZPME9lY3dhTlB2V0VtS0tQRmt1?=
 =?utf-8?B?dXAxNFc0eG5rUFgvWUN1amxvRkJpWGlMOUVPa3Q4TWNkZ2x6S2dkeGNGTkVB?=
 =?utf-8?B?WjVndGVHL0xJOC9hb1c0bVpYMm5KOVpwMFBGRjRrZzlaQWRlRlROVTU1SUQx?=
 =?utf-8?B?U3N2WE5lM0Z2RFd2VTcybW9ibFlmQkJNaGxBNjhGdHlJN1RSdDBIV1ZwZ2VO?=
 =?utf-8?B?U1o4VkZmbVV2OGJMN1Z5Z0hxTTJYYk03NHNMVU8xZXNEUFRyZXhkVXNRY3BM?=
 =?utf-8?B?NExOZEhwWTZaUWY3bXJ5THpMZGJoTWh4eThNYlA3QmVvQzdlQ21IdHRQS1JN?=
 =?utf-8?B?dTlqNThBMDV5TzRxRzFEcWtkTjRIcFdoazlIdnlkdE84Ui9mV0t5YWRleERo?=
 =?utf-8?B?TGloRndaM3NLVjR1N09mdktnc1JsaHFNaGM2TnJWcStxWkFSRHhzbmdkUWtF?=
 =?utf-8?B?d0lNcmNGS3gzeUhYbWJDMytlalZ4L3FML2s5MWx2UDYrRlRLVVVlcmp3N2hF?=
 =?utf-8?B?WFhFMG9zWTJlWjZPbmVyTUJsQmRlT1BHMlFYV0E4Q0hyNDdVSDlmVzNla1VB?=
 =?utf-8?Q?CoVMeL8SbrGyG8PFbDzBWqY9f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <165234DF45D9044C984CF5A881DF26B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f14a97c-112b-494e-69a9-08db9fde81ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:30:21.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6cusI3/0yv1AAcCZ1GrR8YmAZe+GzHl2DBl64nCBIDivgk9K7PaKNB9NekgMxPm3lOGOusFdMTlU2saozcBew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDEyOjMxIC0wNzAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IEVuc3VyZSBjdHggaXMgemVyby1pbml0aWFsaXplZCwgc3VjaCB0aGF0IHRoZSBlbmNsX21lYXN1
cmUgZnVuY3Rpb24gd2lsbA0KPiBub3QgY2FsbCBFVlBfTURfQ1RYX2Rlc3Ryb3kgd2l0aCBhbiB1
bmluaXRpYWxpemVkIGN0eCBwb2ludGVyIGluIGNhc2Ugb2YgYW4NCj4gZWFybHkgZXJyb3IgZHVy
aW5nIGtleSBnZW5lcmF0aW9uLg0KPiANCj4gRml4ZXM6IDJhZGNiYTc5ZTY5ZCAoInNlbGZ0ZXN0
cy94ODY6IEFkZCBhIHNlbGZ0ZXN0IGZvciBTR1giKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKbyBWYW4g
QnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPiAtLS0NCj4gIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3NpZ3N0cnVjdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2d4L3NpZ3N0cnVjdC5jDQo+IGluZGV4IGEwNzg5NmE0NjM2NC4uZDczYjI5YmVjZjVi
IDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvc2lnc3RydWN0LmMN
Cj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3NpZ3N0cnVjdC5jDQo+IEBAIC0z
MTgsOSArMzE4LDkgQEAgYm9vbCBlbmNsX21lYXN1cmUoc3RydWN0IGVuY2wgKmVuY2wpDQo+ICAJ
c3RydWN0IHNneF9zaWdzdHJ1Y3QgKnNpZ3N0cnVjdCA9ICZlbmNsLT5zaWdzdHJ1Y3Q7DQo+ICAJ
c3RydWN0IHNneF9zaWdzdHJ1Y3RfcGF5bG9hZCBwYXlsb2FkOw0KPiAgCXVpbnQ4X3QgZGlnZXN0
W1NIQTI1Nl9ESUdFU1RfTEVOR1RIXTsNCj4gKwlFVlBfTURfQ1RYICpjdHggPSBOVUxMOw0KPiAg
CXVuc2lnbmVkIGludCBzaWdsZW47DQo+ICAJUlNBICprZXkgPSBOVUxMOw0KPiAtCUVWUF9NRF9D
VFggKmN0eDsNCj4gIAlpbnQgaTsNCj4gIA0KPiAgCW1lbXNldChzaWdzdHJ1Y3QsIDAsIHNpemVv
Zigqc2lnc3RydWN0KSk7DQo+IEBAIC0zODQsNyArMzg0LDggQEAgYm9vbCBlbmNsX21lYXN1cmUo
c3RydWN0IGVuY2wgKmVuY2wpDQo+ICAJcmV0dXJuIHRydWU7DQo+ICANCj4gIGVycjoNCj4gLQlF
VlBfTURfQ1RYX2Rlc3Ryb3koY3R4KTsNCj4gKwlpZiAoY3R4KQ0KPiArCQlFVlBfTURfQ1RYX2Rl
c3Ryb3koY3R4KTsNCj4gIAlSU0FfZnJlZShrZXkpOw0KPiAgCXJldHVybiBmYWxzZTsNCj4gIH0N
Cg0KQWNrZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg==
