Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6D77E12D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbjHPMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbjHPMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:10:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D526A9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692187804; x=1723723804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TBgTerMAkyrJ5gW8Y5pPSWs7Jk6zorN8kjCt7tUH9wA=;
  b=MFuSqVpRbZe2BRNd4H9Eb+w3cuBTnhpfmgQEi4HKQGtL2Uw9+uDVeGSf
   c1m/IoALemrpnEnLOVP9Il3e5wdm7UqLGGtLi0Cx/4Qws5UGnfOeeGZQh
   56cM6Mo3dfvN2ZhtKU4H9VxYBvmbFWFS1Gz2qs7syFRjXi8e6fSPZSLEY
   NPc+r2NqRIQaXt1PA/JoyC2AS0wGzo5uDelmj4O1uCRcTjaR5DWe6xU68
   VXR872X+jvCVqcJDmG5uhgdbCvmkcJY3uuU9Halh9B2mFTebkoenZcT3h
   E9NLN01/qwwp9rP4365LVMf2RZH/zDegHFbUrIvkKgcOqoDSCuGh2W3fQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458866560"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="458866560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824218008"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="824218008"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2023 05:10:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:10:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:10:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:10:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUmrrjZQc668NjH/YqB3Kpx+eqLfDkRYsJ61+GHSaEWxmWhdvhCMoAjMYtMJiJna8LLD/sJClFUSXf0kV+nwlhXePxvELQt2YDOKjpr8VvjY5w2FL7wFuMOW21aA5uaR1o3d2/xGPIs4P44S57WuEGVIvX6/mH0BkFpwLUEUN9qqVnCp7CrWo5zp1F0Tbxmjb0PgxfQk3Y0KrAbFDHfMAXkXV2kS+kQZFc8iWKavzFJuFdxOZ9hi+XSdAZ3xzxcN65LSbqEXn3lmdIsKjwbLgsa/GpNerBL2z4akQEovrDm3PjBx/qaS+FUE5WXqt4pXtIItPSMD0XXx559OAZdIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBgTerMAkyrJ5gW8Y5pPSWs7Jk6zorN8kjCt7tUH9wA=;
 b=AZe5LBCI4DuCMMaNxQWWNZVZ3ufh4Ffw8+VQoggJpfWF/iQpD5xxd42nBlsSeBGaRhCNKMXlzpATKJx3qNJCmSl1mZSFRZNSXATvD3xYE9Y3Irqx++tP6xTAsfkejiZdlwV30WFkeYZLzAofnp+8Pz2CQe1L60DTT3SEgp7+dJXLl37rrptJTCtGmAk6/3QpFqBOWMN5kJdU3EVXRujHc0eqmPdVWN3CYKWrhViq136e4eoFFCfMuaI54FdnkAiw3F3tHUAKh+UJArux4EMzcMnIlPHIpOr+FQhrP6MtXFgwuQyhM2Pe4/IXAJSX6YIqzyPoBMvbELtPKsZv1emKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:09:58 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e971:f9e7:17a5:1a85%6]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 12:09:58 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ray.huang@amd.com" <ray.huang@amd.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "puwen@hygon.cn" <puwen@hygon.cn>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [patch V4 28/41] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Topic: [patch V4 28/41] x86/cpu: Provide a sane leaf 0xb/0x1f parser
Thread-Index: AQHZzo0/ez0ssHaDHkqlwEN7Ja8Eeq/s2AiA
Date:   Wed, 16 Aug 2023 12:09:58 +0000
Message-ID: <9cc313b7fdad7c26d561fe390c7e797b81e0323c.camel@intel.com>
References: <20230814085006.593997112@linutronix.de>
         <20230814085113.705691574@linutronix.de>
In-Reply-To: <20230814085113.705691574@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7288:EE_
x-ms-office365-filtering-correlation-id: ccd7277d-49f8-47e2-5021-08db9e51b5b3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwRtMImN+3tGegBEN32T9Aglipbhb7/iOMMfW0EnmP1TwQ8bpCR6COK3Y8mZFhDTqMc4unA0mn7Tk4WIuD0x04EWJryC7ZE1LW+CFPY13KE/BeinaU+ZClhdsyXDmb2gifm/xSuP25lTwzsI9qZG48ZsqRMtEBx8IxfNeuvFaXSDATCX13zvZiAC+RGZ+3b9pW75VipccC6z3+TM7tAKuske9i9Q2Z/tu1K30D8R16J9pSzmoMtrL3k/Z2P000iDw++Z+p+MQOa9X1Xul/0ycYYL5mFXuNxW23PpW1QADqig0TJjuvluqF/Imo5pS1xXtqdkT2Fs/KDhTeSZYOLQWMoWqar8sa82EKhMlg1oRyyiHs6VOVW7hAsjr9Aej1hpq1gzOHhSABrGeNkSD+f9chQX17t1DdbY7k+Y0QMXhX19Av6kBA5faSUEen724K9bQtRe+SB2IYPmI2ypBp9C5+67FtaHvxKKJg/3dOOmUmnI/5E+OsZclycywiV0z7zXxDUB6uEZXLp+HiBhOW/EdHNa7voK8hi2JUPCcmfWGkMznU/uOuPq29zTJu69sZ6NcDBUbZXZBlZBVUCw27zDybRhU32oA6aSON9JNaFuA/h0kEGx7TM1R6ibgZcgcg69
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(91956017)(110136005)(64756008)(66446008)(66476007)(66556008)(122000001)(41300700001)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(478600001)(7416002)(86362001)(6512007)(6506007)(36756003)(71200400001)(2616005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDVvUnFrSGE0YlB6N1FVWFFNdHVDR1NrL1UzUklBMWx3SXRreDdnaXN0R25o?=
 =?utf-8?B?azg1Q1lLNnhTSmdNMkZGUXc1d1hRM1ptdTNvOTQ3SWNPUk5tM0hMS1JIYlJW?=
 =?utf-8?B?WXJmT2ZiRkQ2cklNbW42RmhtRngyRGNFS2ppeVg4ZUN2R1JVcWhSOEFneWxz?=
 =?utf-8?B?Y0h4cTQvazJDd2ZXb2NVaUwrdVRxYStxTWRoZUpDVS9oN3JyNVpXWE0vemdY?=
 =?utf-8?B?QWNrTmdUaW4vNjN0VkllYWRWeVBYQXVLWUV6MVlMUEpBL3psY0twRFJwbFRw?=
 =?utf-8?B?TStkOXRoK1FkekVDNXBCQ3UwVndXRGVvcG9SZGxGK3doM2l3YStSdVNCaTVZ?=
 =?utf-8?B?Q3RCSUI1b0V3K2RCNEJ5V0RxaVpzVFI3RE1Yb2phT1V4bGxWeE1QbWxHNzRZ?=
 =?utf-8?B?MEM0ckpLbmM2UnlIZktSM1ByMVZMSTRjSDdCMHU1L1RrQk9HME9GMGVQTWs2?=
 =?utf-8?B?T2t1TXc0SHNETzM3YXZFOWhXZ0VBbVRheXFHZzcxUDlXRWZWQklRcW8rczdR?=
 =?utf-8?B?RnNzR1E3aE5BWmtDKzJyTkpDcGxiL3QzTW1sVExZemRqSE9xSzZ2VHJ3cFU0?=
 =?utf-8?B?amlaVzdiZWNmVkFqaVNmelozUE9HWDFzcEZwOVV6c0RHRWM4S1NaWlp2cnEw?=
 =?utf-8?B?WjVlVDVWNGdQZ05mbkwrY0MrQm1rMVlRYjZPVDViMXkyUkVYRkJEMm1Wam9V?=
 =?utf-8?B?VVU0VnNmUElMOXF5S2NQM1RzVHZWd0l1SEErZTNWTStRa3NITHNKRElyOEps?=
 =?utf-8?B?cFoxTDNUbEYzU0ZnVm9xZ2FIOXFJbGJqOFZob2x4d2VSUzBrOEtBZU03VEtN?=
 =?utf-8?B?NHFueUJCZkt3WnhLVy9tUTc4dENuSzdHTEdMRHo5VGtZMzdOc0ZkcUxCaUZG?=
 =?utf-8?B?N2RrT0JsdXE1RDNMR3dlNkxUNXp1TGJuQ1REcnZvenhtUkVKTTVXc0JScHJE?=
 =?utf-8?B?eFFPV2FvVkZCRTJFWStMa1EwVEdRaEpUZHI2LzlPMDIrd3VwSjEwWm1SbHdQ?=
 =?utf-8?B?Z3F2OU5QMGM1d3RSY21wSFUyZzJmN1NjaFk2aDkzbzdTN09FekJzb2tMYTUx?=
 =?utf-8?B?QTJhc2pKRDF2ZnhaUDJiOXJ0MUZCSjE2cXhjRnpPdVptVjBHc1JrZDZISk4z?=
 =?utf-8?B?TE1kOTdtWlFQcEcyZVBTV2xoU0VJZHl1eUorUmdMZ2NUVXNDajAwYXVBc0xG?=
 =?utf-8?B?MjZmd1piMm8xcEdkdzRkS0poVGRMbmpvL2xvWWlFa1Y5dm1RTWdHQU1RMjVH?=
 =?utf-8?B?dWxVSHFQZFNJZEoxellYeWhRVmIzcmFZK2xtaXdVV3E5QXNSNStpRDZZUHgv?=
 =?utf-8?B?UHkzTzQ5RWRIcXB4bmN1NFh3UEd3MHRzejB4eUxQdFl4K0dQbS9tUCtrZWY3?=
 =?utf-8?B?T1F2UEcvV0ZZNE1jcVV5NnlRLy9LRjNhbENNS0R4UExMeFMwNFZLTUQ3Y1B1?=
 =?utf-8?B?enJpY2lHSnFUbzlrR01JMUgreUlMWTRPU2s1dFRQcDBnNVdjT1lmeDhQMnJ5?=
 =?utf-8?B?dk5UcG1naDRTMEVkWEVIMXkwajhHQlhsc3hNamVqNmVUQ0w0cHRKU0tjOFlt?=
 =?utf-8?B?aEY5WXVZUHhDVGhlTXFqMzl4NWd0dzZGYnVDWklxSVBlS2p2OEEzbHBtTjRh?=
 =?utf-8?B?djZ6am1jd1VVRko2eGRiOGlJWFN0ejcxYmJWM3NSMkNUaXJPSkR0WFU5bXpj?=
 =?utf-8?B?eEtaVW1KTzhjak5xMU1hbVRXWTExK0llRTFDVHNGL0syY2NUZ0FidlR5QVdC?=
 =?utf-8?B?WW1OSkNnako0R0gzVUxCYjVzaWFDajdDQ2Y1N2h5OEtkUnBoTlA4bkNJRGVy?=
 =?utf-8?B?eEFJSXA3L2M0YlBONnBCSXdWOUtBUEsxSEF4NUxFVWZETXBNKzFKcis4OVhI?=
 =?utf-8?B?blFVcWYxSjBVYlNySThGWU9XZXpTQnF2eHFYYlJlVGxMaUpBdmdsZGJGcnk4?=
 =?utf-8?B?L2VjUXhHS2VHMzl4SXdyZW5zc0xQZzFra3pXVEJQSWszZitSWVNtUG4xTmZS?=
 =?utf-8?B?ekVSQTZ5dnQ3eWYrMjRIaEcxQm5GMTNpTlgwL0ZkNm1ueW92VmFJVkZHTEJm?=
 =?utf-8?B?eU1VY3d4R2g3TitPZVhZeXR3N1VDU3Q3NUUvVlZIY2thVU82VUJzODRLOU91?=
 =?utf-8?Q?mGnfx2AgLqzV+6lJ9CkewksH9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <320C6CE42223AD49B8EC5C1925FAB127@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd7277d-49f8-47e2-5021-08db9e51b5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:09:58.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puFbpVSio5Fj+XwMOj1pd2PKyDJIFu/jXKg8Kqf5CyKQV3FzsSFpwYUPRmeD59JdTngmKrpwC0y4LRUTLNLhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
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

PiArCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0b3BvX3N1YmxlYWYoc3RydWN0IHRvcG9fc2NhbiAq
dHNjYW4sIHUzMiBsZWFmLAo+IHUzMiBzdWJsZWFmLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGludCAqbGFz
dF9kb20pCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgZG9tLCBtYXh0eXBlID0g
bGVhZiA9PSAweGIgPyBDT1JFX1RZUEUgKyAxIDoKPiBNQVhfVFlQRTsKPiArwqDCoMKgwqDCoMKg
wqBzdHJ1Y3Qgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvLyBlYXgKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTMywqDCoMKgwqDCoHgyYXBpY19zaGlmdMKgwqDC
oMKgOsKgIDUsIC8vIE51bWJlciBvZiBiaXRzIHRvCj4gc2hpZnQgQVBJQyBJRCByaWdodAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIGZvciB0aGUgdG9wb2xvZ3kgSUQKPiBh
dCB0aGUgbmV4dCBsZXZlbAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgX19yc3ZkMMKgwqDCoMKgwqDCoMKgwqDCoDogMjc7IC8vIFJlc2VydmVkCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8vIGVieAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB1MzLCoMKgwqDCoMKgbnVtX3Byb2Nlc3NvcnPCoMKgOiAxNiwgLy8gTnVtYmVy
IG9mIHByb2Nlc3NvcnMKPiBhdCBjdXJyZW50IGxldmVsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX3JzdmQxwqDCoMKgwqDCoMKgwqDCoMKgOiAxNjsg
Ly8gUmVzZXJ2ZWQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8gZWN4Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMsKgwqDCoMKgwqBsZXZlbMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqA6wqAgOCwgLy8gQ3VycmVudCB0b3BvbG9neQo+IGxldmVsLiBTYW1lIGFzIHN1
YiBsZWFmIG51bWJlcgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgdHlwZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDrCoCA4LCAvLyBMZXZlbCB0eXBlLiBJ
ZiAwLAo+IGludmFsaWQKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoF9fcnN2ZDLCoMKgwqDCoMKgwqDCoMKgwqA6IDE2OyAvLyBSZXNlcnZlZAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvLyBlZHgKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdTMywqDCoMKgwqDCoHgyYXBpY19pZMKgwqDCoMKgwqDCoMKgOiAzMjsgLy8gWDJB
UElDIElEIG9mIHRoZQo+IGN1cnJlbnQgbG9naWNhbCBwcm9jZXNzb3IKPiArwqDCoMKgwqDCoMKg
wqB9IHNsOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBjcHVpZF9zdWJsZWFmKGxlYWYsIHN1YmxlYWYs
ICZzbCk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmICghc2wubnVtX3Byb2Nlc3NvcnMgfHwgc2wu
dHlwZSA9PSBJTlZBTElEX1RZUEUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiBmYWxzZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHNsLnR5cGUgPj0gbWF4dHlwZSkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnJfb25jZSgiVG9wb2xvZ3k6
IGxlYWYgMHgleDolZCBVbmtub3duIGRvbWFpbgo+IHR5cGUgJXVcbiIsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVhZiwgc3VibGVhZiwg
c2wudHlwZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBzdWJsZWFmcyBhcmUgb3JkZXJlZCBpbiBkb21h
aW4gbGV2ZWwgb3JkZXIgc28KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogcHJv
cGFnYXRlIGl0IGludG8gdGhlIG5leHQgZG9tYWluIGxldmVsIGNhcmVmdWxseToKPiBpZgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgbGFzdCBkb21haW4gbGV2ZWwgd2Fz
IFBLRywgdGhlbiBvdmVyd3JpdGUgUEtHCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIGFzIG90aGVyd2lzZSB0aGlzIHdvdWxkIGVuZCB1cCBpbiB0aGUgcm9vdCBkb21haW4uCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIEl0IHJlYWxseSB3b3VsZCBoYXZlIGJlZW4gdG9vIG9idmlvdXMgdG8gbWFr
ZSB0aGUKPiBkb21haW4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdHlwZSBz
cGFjZSBzcGFyc2UgYW5kIGxlYXZlIGEgZmV3IHJlc2VydmVkIHR5cGVzCj4gYmV0d2Vlbgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0aGUgcG9pbnRzIHdoaWNoIG1pZ2h0IGNo
YW5nZSBpbnN0ZWFkIG9mIGZvbGxvd2luZwo+IHRoZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiB1c3VhbCAidGhpcyBjYW4gYmUgZml4ZWQgaW4gc29mdHdhcmUiIHByaW5jaXBs
ZS4KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRvbSA9ICpsYXN0X2RvbSA9PSBUT1BPX1BLR19ET01BSU4gPyBUT1BP
X1BLR19ET01BSU4KPiA6ICpsYXN0X2RvbSArIDE7Cj4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZG9tID0gdG9wb19kb21haW5fbWFwW3Ns
LnR5cGVdOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAqbGFzdF9kb20gPSBkb207
Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIWRvbSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0c2Nhbi0+Yy0+dG9wby5pbml0aWFsX2FwaWNp
ZCA9IHNsLngyYXBpY19pZDsKPiArwqDCoMKgwqDCoMKgwqB9IGVsc2UgaWYgKHRzY2FuLT5jLT50
b3BvLmluaXRpYWxfYXBpY2lkICE9IHNsLngyYXBpY19pZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBwcl93YXJuX29uY2UoRldfQlVHICJDUFVJRCBsZWFmIDB4JXggc3VibGVh
ZiAlZCBBUElDCj4gSUQgbWlzbWF0Y2ggJXggIT0gJXhcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZWFmLCBzdWJsZWFmLCB0c2Nh
bi0+Yy0KPiA+dG9wby5pbml0aWFsX2FwaWNpZCwgc2wueDJhcGljX2lkKTsKPiArwqDCoMKgwqDC
oMKgwqB9Cj4gKwoKTWF5YmUgd29ydGggYSB3YXJuaW5nIHNvbWV3aGVyZSBpZiBzbC54MmFwaWNf
c2hpZnQgIT0KeDg2X3RvcG9fc3lzdGVtLmRvbV9zaGlmdHNbZG9tXSwgYmVjYXVzZSBpbnZhcmlh
bnQgeDJhcGljX3NoaWZ0IChmb3IKdGhlIHNhbWUgbGV2ZWwpIGFtb25nIGRpZmZlcmVudCBDUFVz
IGlzIGNyaXRpY2FsIGZvciB0aGlzIHBhdGNoIHNlcmllcy4KQW5kIEkgZG8gc2VlIHZhcmlhbnQg
eDJhcGljX3NoaWZ0IG9uIGFuIEludGVsIEFsZGVyTGFrZSBOVUMsIHdoaWNoIGhhcwpiZWVuIGlk
ZW50aWZpZWQgdG8gYmUgYSBtaWNyb2NvZGUgYnVnIGxhdGVyLgoKdGhhbmtzLApydWkKCg==
