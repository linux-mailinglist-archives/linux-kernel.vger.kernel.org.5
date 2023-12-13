Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8F811FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjLMULS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:11:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E62EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702498284; x=1734034284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hyukxoHroz95Vm1AbOqabpgC9LpKyU306uEQyf8ZA2k=;
  b=LYUNjHbrrKp83exJqua8mkJMZbEzHqoyjNsmm6XBQ6K2LWJhuPcG3kXO
   Q7+pg+kPCUOgLSAHFFIVmkugJKN7+9m4ufYMY3C8RpcChnPEm425RdNaT
   SyhfjjbXPPH1acGn8kjawkOtPTdaYBbBUVsLKEn2X3bqyN7tkVQC1icgj
   YHiO9awFejmV+Gi6M1jiRuW/H0dIeRQ3XiK+0V40G8pr7f3gJnQ7oE7wA
   0g6A5/3dKbY2PbvEx1v43DPyN1LUDFQPfgNmgavTbwLUXg64XBgRnYxzv
   GHxpzPAwG2B6jPfstlKvLcX5HdgZLVqgqzCcGRW1S5xkASKiB6xxjSnXV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8383862"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8383862"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 12:11:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="15563343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 12:11:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 12:11:21 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 12:11:21 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 12:11:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWm2LcBoGuPMEYZnn3AsYCbzd0/ec2ZmOf5+O1yH7azCkpFD/8/oJ/ACehCMie/wnvMp+Jxbh5WUPTWBCftyhFY956sUZ5I2EZra4G9nIzCIbS528LQKglDBibdO+dJdf8iF6909rhpdjYqFCR0NrgzOEgkARKH9ZJ0JxB0VazzOzDBFPA2r3PXTqeL7XNdwUqVrv9CVO0jmb4qhbqCySUKxPrqArYasZa2gu6a7p2ZusL1PYJ0gWwrObdgDIY5kBGIO2I2oqXvuxqir340nPJDg2NfW3ST/UMZJF+7y4hOHt3OAr0O7gNjgb7orZysJ/tr8PRpyRd3tn1QS33aeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyukxoHroz95Vm1AbOqabpgC9LpKyU306uEQyf8ZA2k=;
 b=HdsQTNo80aac7DKATKtY4YHIlONIxFnxSo4N73wdOfS+NStc+iAzWmGY/UyMVRCfVPuVOue+rttrL+c/bYDRBJJZGyNDlZk3srLPgDwPUB0/dy+0nyaCZf96WFH/90bFgqLzgX/Qb4JCpgi7yiY+akHt6Ddhz90kGomFjZT4BZMHTOIPxOE+ITjcg0Yl5H0GR514hPRgian6oqIH5VJ4NJgyyG8MfGBUWljq6yxBTLKLCes/54x0IqJMSPkKXlnzs5oNNKmJOzbDmTUSWq5EMFFFWt4Je29DO1xWK5rHNbo1pLSXGC+jzFY7eP4F3Urkg8gOB2OALtj/gej1cImK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6524.namprd11.prod.outlook.com (2603:10b6:510:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 20:11:18 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 20:11:17 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "arnd@kernel.org" <arnd@kernel.org>,
        "Yao, Yuan" <yuan.yao@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Topic: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Index: AQHaLUNkbx3M70MeHUWOqNlrwdFerLCmLZaAgADwT4CAAIicgA==
Date:   Wed, 13 Dec 2023 20:11:17 +0000
Message-ID: <044e2990b5ca28d04c7305de3d2d412071975ec1.camel@intel.com>
References: <20231212213701.4174806-1-arnd@kernel.org>
         <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
         <20231213120215.64wcryk5k75cymop@box>
In-Reply-To: <20231213120215.64wcryk5k75cymop@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB6524:EE_
x-ms-office365-filtering-correlation-id: 29eac6f5-08e1-4f52-cce9-08dbfc17aa14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IObwQW5/k16UTKkg4FyZnYahkC0DdwZGA2mz1fF58YOBS+CCoJP/MaNFJ9mHC9+7uLuyhliwd2TCFm/birauxVWOCmEWqHbbcWLznEwaUiea+9IYAssVxAtnpWh739YBsxFgORNLNfHems1SJGRWrJNaRpaZzfSRQ1R97jNUWsYBc3rBMVlVF5QyoBoNXgIBMZ7M9PQ1PzyRvwRjrJ+5IDVZnSJXKi5LZXuv/X0Cp6Idvtm1J9FMgv5H4qYvO4jTQDVL9DZKHwLSF3mDXAcULzalA2xn9RgcqG5lVReur6QBnrm/qtRh3B+CASqsp785PUiUQpsHkpO+QVGj/fVuDYoyRPVyuKZpgYegBAS+AdFcoHetB+BQnPn19TlcIoU8g05PomrB04S9LVuNJA74/Ml3+EZ7AxZrC7/icXHy59TLVsUvRViokl7w6HggqAa3J380KVjuF2f1B4sxD5j58H6X3pqewUcpluh3aX00SmQ+J5ihweoJtWGb+T6+UhHH2G3+CqeuL3cNRrNQYG6ZsPy9sTtwbrfmV6OUcs5Bfi8+pZKIkRTeBeFYKZpbjcXDpCxz7RtuegxMfI4jaRKNR8mnUGDbNTtqDzeCJ6nBaBxb/ttcta+oBSSfRG7sXqXjnseHcvwK+U2d4uNNoEOG40uoOzBE2YYfD01ywQzpuzQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(6512007)(6506007)(71200400001)(82960400001)(86362001)(38070700009)(38100700002)(36756003)(5660300002)(64756008)(8676002)(8936002)(7416002)(4326008)(122000001)(66476007)(66446008)(54906003)(6636002)(110136005)(91956017)(66946007)(66556008)(76116006)(4001150100001)(41300700001)(4744005)(2906002)(6486002)(316002)(53546011)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1lNMFpHcXB3UmJGMTFjSSs2c21yaTdrdjdwckJGbmpPekozWEFaeEtQSUpH?=
 =?utf-8?B?SGdHb0Q0cEpmb2IydUU0eTJ5MjR2WWlzbUk5RXNBakVrTHdtMnljc2ZoNERa?=
 =?utf-8?B?MGhpTE5PdFZMMUs1M0hQUkVpdVc1Tm0wQlAyZXExL3l5ang4VmRCbzYzT1Za?=
 =?utf-8?B?a1FKOGUzOFhLRDZaRUdheHcxSVNqUmpYQmFQUVNGRHJreDk0VGg1S3VxNE9Z?=
 =?utf-8?B?VG5SbitadDZoUVd6NE02alhTa3lVMTBPZENjNndwS1ZXYWtBWDg0UzN3OE9Z?=
 =?utf-8?B?V0tvSFp6a0tydjN2dWIvK21iTERoclVXV2pRajNtanRReGhFaC9YNmhybTgv?=
 =?utf-8?B?SjB1MXIwQ0dwd2J3bVRIcHlGcyt0eXpnRTlJSDVHZ29CTHlrMmxsaElzcGdM?=
 =?utf-8?B?WDFCNkhIUXhLOVpRYkJ4VU5hVjU2M0FQcHNlTmNLS3VHMmUraFNRUGVHVDhN?=
 =?utf-8?B?Y3FOR2ltQm9nVnR5dTNDSFhPd1ZwSEsrR1p4a0RQVTJkMFc1MHJyTTFDZFNW?=
 =?utf-8?B?bExOL0lLM3JGODJUV2FDdWlHSDF4RzgxbTdKRnMwVHFiUnNTT1dCTjNvODlt?=
 =?utf-8?B?SVRadnFtRTJOcmVLN3pNYXRCckhVU2hnTUpXVW1DTnBpZDhlanpkU0hEQVlV?=
 =?utf-8?B?b3VGcHhuQnl1V25sQ242SDR4Z28rMFR4bWtnQ2dBaHN1anovdVJuMHc5Vy9i?=
 =?utf-8?B?ZDkvZDNNQTdOK2dNNzdER3ZXOVZJQTFET1RRMHJKdkoyZkRTeUFRcTNXcXBW?=
 =?utf-8?B?RW5RQ1FjSkIxVXVhclZMcmJHamtNTE9ieWdERFJrSlJuVkJCSi9DVUJ3MlpZ?=
 =?utf-8?B?Q2ZzM1JGRmF5N1FsMkF4Z0toQUkyVlFRdkE1WXU2NmI5Yyt6NHM4RGF3bUY5?=
 =?utf-8?B?c0IyWXZYalRLd0NhMDFGdG9RMEVoSHNLUVN2V2pDbUhQQTNhRUZqcXM1Uncx?=
 =?utf-8?B?TzFJbFhKVnVvWUtQRHVISU5GTXJKQWpMVFhtMDBNY2JkOWZkSjhDKzUyS2l2?=
 =?utf-8?B?NGVLM1NSYjBwVFlRSmx4QTEzcVNJZ1VqNTZMejJSL2k4WTBsY3Z0TVh2Z09M?=
 =?utf-8?B?aDNVUW02MVhRNXRRbjYxS3lFZ25iRTY3bWdid3FyV3phQ095VUNKQUNrVkFL?=
 =?utf-8?B?Qmp2YkhFcnBSWUR2TmZjeEhEUTN6dXByUHpwNVN1cjBQSDRRMWxtcXFYSXg5?=
 =?utf-8?B?WGlQSWVIVEFDS3lXZzhWZHU3TWdRTzdPVWlIV1V6by9uWkV1YWlLQlhJbzJN?=
 =?utf-8?B?c1dwZTVReUE3a05aYlpQZVYzOHF4VXVnNE1laitxYUdHcERJbkFOeFNTV0dT?=
 =?utf-8?B?dmZCMEZlbUptczZDV2dPTGo3bTY3bWhUdGpsTVFsODdDdS9kMkFmcUZUcWdS?=
 =?utf-8?B?QUtSL2ZBWDAyZVVnd1NSTE1ETHRwOVZXK3oyU3ZSckIyQm9ubGFVZU5QMm9E?=
 =?utf-8?B?NjBtajhIL1RCNCt4MHoyeXVzZXVFNU9rS0tEK05aZHd5eUxjTkUxRTlPQmpt?=
 =?utf-8?B?WFdNNHZFKzRQNXUrNUFXekl1V1QxUjFzdGJaNVl4eStnaGNncFlaZk5UOG9B?=
 =?utf-8?B?a3MxV3VDU0tZd3BTVEUyU040b2FRUkE3K2c3K0JjRkxBU3RVTE5FRHF0eFc2?=
 =?utf-8?B?YzI5bDhJbzRxRU14QUxSZForT1RxQ0k5MDJOUFNrUUNLMnhJWHl2TDMxYVNS?=
 =?utf-8?B?L3NvWjUxVGtjNmxydmk3L2kwOFhOMVFoNXBRTkNnb3RzRWJUTFR6VTMwSGN6?=
 =?utf-8?B?azd2L1h5WkhZeC9CWmVWUFNSdHF5bEhnY3ZITFMyNmxGc1NwNml6V0tpSEhu?=
 =?utf-8?B?a1F5eEdsem80dDIxemlXQXVFdy95U2lnTEdWcFp3VnJxcktESHRPUGhJS1Nl?=
 =?utf-8?B?d1cxZVFoN3ZENzZjdHRLSGhGT0RTdUlBcXFQaXpWRWE2b3BaZlF2MlNXTVhY?=
 =?utf-8?B?K0RiYTdnOVZaWUdyNm9EUmNLamFYaVJYakwrU1UrM2V4U0lVTWFMbnFucVR3?=
 =?utf-8?B?cDM3dW02SDNUWXhVNndLVWp5Z1ZEb1RwdXFnZTFxNE5rb1JpdEtDV3J0Nmhp?=
 =?utf-8?B?dDBUWkgvRUJ4UVNqUU5BZTU1b05QUWpjMWErc2NVOTV2b3FtNm9jUHM4K0JR?=
 =?utf-8?B?dm9lbENTWnRoYSthRjF5MytaMnRCUHRwZUZSWTUwKzJmeFZEajZkWEN2RkR6?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D4B7A8F2536654CBAFB8FF0F74E121B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eac6f5-08e1-4f52-cce9-08dbfc17aa14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 20:11:17.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLahhs7NNNBMI4Xpr4iPTRufsbkU1vYNvh/U4jpAWbKuSaDmai6g2eo1QMcWXXM6DeGaPm6zLkNXaghcItOkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6524
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDE1OjAyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDAxOjQyOjA5UE0gLTA4MDAsIERhdmUgSGFu
c2VuIHdyb3RlOg0KPiA+IE9uIDEyLzEyLzIzIDEzOjM2LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiA+ID4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gPiA+IA0KPiA+ID4g
V2hlbiBURFggaXMgZW5hYmxlZCBidXQgTUNFIGlzIG5vdCwgdGhlIHRkeF9kdW1wX21jZV9pbmZv
KCkgZnVuY3Rpb24NCj4gPiA+IGZhaWxzIHRvIGxpbms6DQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0
aGUgcmVwb3J0LCBBcm5kLg0KPiA+IA0KPiA+IFRoZSBvbmx5IHdheSB0aGF0IFREWCBoYXMgdG8g
cmVwb3J0IGludGVncml0eSBlcnJvcnMgaXMgYW4gTUNFLiAgSSdtIG5vdA0KPiA+IHN1cmUgaXQg
ZXZlbiBtYWtlcyBzZW5zZSB0byBoYXZlIFREWCBzdXBwb3J0IGJ1dCBub3QgTUNFIHN1cHBvcnQu
ICBNYXliZQ0KPiA+IHdlIHNob3VsZCBqdXN0IG1ha2UgVERYIGhvc3Qgc3VwcG9ydCBkZXBlbmQg
b24gTUNFLg0KPiANCj4gSSBhZ3JlZS4gU2lsZW50bHkgaWdub3JlIGludGVncml0eSBlcnJvcnMg
aXMgbm90IGdvb2QgaWRlYS4NCj4gDQo+IFREWCBtb2R1bGUgc3BlYyBhbHNvIHN1cHBvcnRzIGl0
Og0KPiANCj4gIlRoZSBtYWNoaW5lLWNoZWNrIGV4Y2VwdGlvbiBoYW5kbGVyIGlzIGV4cGVjdGVk
IHRvIGJlIGltcGxlbWVudGVkIGluIHRoZQ0KPiBWTU0uIg0KDQpJIGFsc28gYWdyZWUuICBUaGFu
a3MuDQo=
