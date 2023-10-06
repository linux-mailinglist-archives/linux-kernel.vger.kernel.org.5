Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778067BB58C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjJFKnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJFKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:43:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DFBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696589016; x=1728125016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EwvnsM5wXFgm8tfTVPrpKLGXxFVxDFNz0yWuRZU+1t4=;
  b=SDtyLFD0BQbWoc55gMDJ4zhN6QOyHEuAO4tWOGE8pXgm7BvtQblQeorq
   cDHogLO/u0QfmSEYrFNdtCKzV4OAC/vl9JQkzpy/Xx+25EY7ANozRIkqb
   zW2jNpuWcRQq0yttEbkUQQguFqylmLZyo+6r3yBGlEkpfN9Dd3iObUhky
   Vow0fEeelELW5Ddt3Zjzqq2h5Cf9tVg+dXy9dystVRnjXwpAq00pYRkhA
   Ulo3uPXjaqVhpDCQHA9bHBqq/7GqjA/RDtoq+5GEoP6hAnUqU6YfuKksb
   RKzZo8I7uEeesIWEU1JkHgnMxOdGQ0j7G9ZCQgC1XMhdyOsiGduaC07wr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2329608"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2329608"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755813793"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755813793"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 03:43:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 03:43:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 03:43:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 03:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwpXTRQ86H2Tjym/nuapETp1wyLv9hZ0O4CqNeViGShxD+M0yiXEGsQ8X8Kb7YZlahoQvRWjhbLiXVOLP3gwxzr+hZYyN2EgzMsvoWMW+1fBkDEqXLZqyWZ6uNegro9693tDuHYUNjC5fbMjJNFL5spEsXNJJPRQqJxaxFGHbi/d99wZgnyhivk925VdsQvsILqGZzrS/t4/W724CDNzv5ejF4MQRZ1U/3BYnycC/ojV/pqLuwdSXRbWfJBxGl3bFtPFw1zfnSCGWrSl0feJvU43pvxBr4dfHuByWmSqe9zQZCHD0oovDpzFzZlI1umBhqO/zvnrxsH3QcYCBHbWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwvnsM5wXFgm8tfTVPrpKLGXxFVxDFNz0yWuRZU+1t4=;
 b=bvjyMYsFG3M9SFh5H6fw/lnE2+pAYFIYDjucqUpBJlcbYH7pU/hTDSCUwQmACPy4QsZQumE6hQD5oTAsvZDedKWTFfc6xKucxVOZgj8pIGc2Cf65SwHUmELK/BnKg4LdNr3otzvTzE5wlTaye7y2218hynQUtn+XSnhKyFr0kdNHlN5Ikeo3LX0XWprDs45CoVuD1eQ9//preivvlxDJgNENv8ZTbARx96PoLQeGfkIKRkJyaEBnphchdIoKLQxJhfRb7/R+mvqERaBmBIU0roGiVHHcFZ2vxphE7/eV+iHWRrsSe1uPc6OodXTGqknCwl39+gcbjCaWEaOCphM6rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 10:43:30 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::31a9:b803:fe81:5236%4]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 10:43:30 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Annapurve, Vishal" <vannapurve@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "Shahar, Sagi" <sagis@google.com>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
Thread-Topic: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
Thread-Index: AQHZ9/JQtxyRQPfuJUC3YhBsskddMrA8k/mA
Date:   Fri, 6 Oct 2023 10:43:29 +0000
Message-ID: <0f97dc87e18fccbca6663225f11f47bc1a927ad4.camel@intel.com>
References: <20231006011255.4163884-1-vannapurve@google.com>
In-Reply-To: <20231006011255.4163884-1-vannapurve@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: b772bb88-5a65-4204-ab1a-08dbc6591434
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0L17RRRuxinrMtFu2M393C9UF/g3uA+CfyY6v+fNZRLkXXr93e5w9JLFEnI0wVWGj2SjcCJ6mBNSpfiPehiAvuy1nXpUuvU/gvA4qlgBcudycSXzIqEwWP2xbORQ/roYJCgGsQgpZCUldl/c5iFkRE6od4+IrCwb80/fwjIekMyJMlXL8J8v23LKz+mT82+j7/b3OpHYyBAQtkHlxPfprBxVcXJzbWF38MUxC1jcC4kU04vV3scfh/VVMwpnNYzg8Ag7ZN9TVGTXTT9DkOQmgGmnNFWeQFaJYLOS6zlZwofZDi0UmgR4k+NoE6wXutKQmsxNiNrKXtUghKUQw1tzlBsZgXw0Yao+4p4hBmRSyaMgOpT9kP81dmtjAR9iHvfU/rXNgv1YdSfUyZko0bPOpg47deUO6WSlsm7KnSQ90SaGdx67d8Hlt+heFMF0koKG+mG/HmallbnP33VxOCgJVYUWsLLLEl7Zu8QT+xWXQDkF32XzkuZUaQiD18rV4WQtXOmECkgxlxEMccTDGDWxKxEiPwabZD48NFCbrFatmdz7/x/auU0JwAG85IM2qVrPMkifW4SEr1zLCnaGPsUqGdcK5azayMx9rgtGuk8FGOpfk4YX5cdHB+QcLELehZdkWTBt8bgZSUlbaW7nrspSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(71200400001)(6506007)(478600001)(6486002)(6512007)(2616005)(26005)(7416002)(2906002)(4744005)(316002)(41300700001)(76116006)(110136005)(91956017)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(36756003)(38100700002)(38070700005)(86362001)(122000001)(82960400001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDFPNFVoNmhmRWdLWlJnMHp6NGZXZTJpcGFlSlg1YkxEOExzRmQvc3NvelR6?=
 =?utf-8?B?d0FjZGFKamVKUkwxdFA0RHJ6aXBSQmhVakhvOEZWc0pKQjkvQVQzbkl0cnF3?=
 =?utf-8?B?VmF0dzFSdjk0cko0dVc0VjRwNFpwNm1zSHlCdzNTV1dIeE04d1VjbllIMFBl?=
 =?utf-8?B?clpLVkhJTktmV1c2ZFQ2NjdKNUs2ckNKL1pVZHlCVzIvenF6Q0RvRTJjM2No?=
 =?utf-8?B?ZXJIUzY4NjlwNVd6QTVwbjZTL2JzMXdTTEJyMDF5R2pTb3ZDY1p1YmtVV1o4?=
 =?utf-8?B?TzhEYVNOTGVGK05ZdzBXTE1EQ3JzWFZPMERpMEh1a3pCZ2dmTjJyS1RzRjJM?=
 =?utf-8?B?MndGQ2tqenUwZWFTSjRITmhPalAvYS8yKzBTQTNHYk92cllRUDNjSWlpR1Qw?=
 =?utf-8?B?dUloamxCaHdjdSt5UEdwNTVNWU1aNllmN1p6M2hLbzEyaEdVM3lxUjV3U0pw?=
 =?utf-8?B?OVFRMWgrMS83Mkx5MXJKY0FjVlhYOTJTVWh1YnJtM0hqZHNRcWRuRzZ6cUwx?=
 =?utf-8?B?WnB3MXRFSHZ0Ykc2WldhK2lKQUxkZ2RPczY5cDQ1T0doYUFJeTFXQ2tWcHB6?=
 =?utf-8?B?OUVRd2MyUFV4Ym1xcjgrcmNYRHpRMDVrR0tuVkN4bDMzVWJFWGdHNnNJMzhW?=
 =?utf-8?B?UjNYYU9XU2g3ckxzMXJPK2EzU3pnT1d1S0RJQUFIZlI5TE5WdEZOQkw5NXNw?=
 =?utf-8?B?blowdXZIamdVVXdnSVNqcEJJZ0FpTzYrY2hmd2hHWVNINzRWMGl0bkZteklm?=
 =?utf-8?B?czgzTWU1MTdWUzNkaWJTVnI0TGhRWXFlWXlJdGpuVitqQ25DdVpEN2tkbGsy?=
 =?utf-8?B?RjB1VGtFaFhGYWgzUUo5cDd6SDBucHBvbWVsK1FpRE1VblNjK2JpVkFiUlNK?=
 =?utf-8?B?QklhWWh1MGpJaXZzVXdjWEpTZnpGcHoyQ0JBdHJaZ2hBK2drL1hlVnowOXRJ?=
 =?utf-8?B?Tjd0cy94R3I1cWgxb2tnMTZnUmIzSFFJUXJxZ0VpYVF5N0JrSm5XczNCQ0Jl?=
 =?utf-8?B?cE9TZVRvMkl6TGViV2tzalI3QVU2MC9kc3dWRjFWOCtNY05JNGY1VFdzdlV6?=
 =?utf-8?B?TWhhdElrUzJoSnlUdXM5dDNyMkRoMW9tWXE0cmtDcUt6RHJheUtiQWRFSkg1?=
 =?utf-8?B?dmtBTEtXVlRIbEMxNUdDVW9IRGtLMmdybWRmV0hzME1zbWplRXM5Uk1NNUVk?=
 =?utf-8?B?Qys1cE1sbnMwUjlYRzFoSG9uWm9ydmphZVFwZnhza1d6WEVFWXU0S29sZm84?=
 =?utf-8?B?Qzdad0tWNmQ0R3NMQzA4N0tjSFRlaXBVSFFFMlJianQvdWE2R0h5WkgrRkhs?=
 =?utf-8?B?R3doL3QxeDc0WjZYU3FuWDJjVHdkUnR1RkRyY2xGWHVLV0RmRE5BWjhHdGdt?=
 =?utf-8?B?aTIvR3V2MXBTSkI0RWtGSnBQeW14VkxXd3VoMkRNUU1sMWx2ZllHS2VoTlk5?=
 =?utf-8?B?cVNwUW0zNlY5VS8vNCt6R0hjeUVYRjJYRFpkRWRRQ2kyelNQREdCMG1qZ0pk?=
 =?utf-8?B?aGh6THBiTUpoZHozdmIrbnlMTFlXM1JIQTdIS3FEUTJySWlkNDV0YllMNk5q?=
 =?utf-8?B?TmFzR3J1TzlXQkxPMk5CQ0hDREtpMTRacktWTmZ3TlpvNUdVQjkrcFZsN2Jo?=
 =?utf-8?B?UFRsSXVpMDUvSHh4Wkx3c3ZYNnYvTkdRdVpxZWxIaHBOQ1RYTVNSK2J1enE4?=
 =?utf-8?B?bW5EcFY4WkdkVWZRa1I4S2FZbHVsRU9rWHBPZDJ2dXdhLzJlUkRnWllCeFJz?=
 =?utf-8?B?RXY3K0x0cDRKenlYOENGeWpGTGlIS0NaUWdvUjM0ejNhSHVERzJOdWUrcCt6?=
 =?utf-8?B?SElCMlRCMU1BOWNFRUtPRzlSRitGcnNadFZOaXMyYUJaMkpnMVF4RzlUS1dM?=
 =?utf-8?B?UnhNVEJFMEVWbFp6dEVEWTBOZXlTbDZsR0VZQS9XS1FhbC8ybGpJUUZmSFVt?=
 =?utf-8?B?dmluV1VQc1hOSFBXdXRtOU5XRDlSZXRXSW5VSnFLZzBQVnFNL1pNU0VyY2xw?=
 =?utf-8?B?THNTV0VNMW55ay9UWFd2ampNSVlZRXVPQ1gxcDM0VVVZdWJoSVJMTk5GVVk5?=
 =?utf-8?B?eUhmenozSVcrMmdVNU1CY1VEQzlNeHkvbDdaTFZqdXNCZWg5WUttQ0twZ2ZM?=
 =?utf-8?B?MjFOd1NueFVuck1NWW9waDVTVXN6bEtPMlpjNXNpOUozaFN4cFNoYktycmo5?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1770B503E85953499F711A21B0731D5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b772bb88-5a65-4204-ab1a-08dbc6591434
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 10:43:29.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGmoZwcOUB7jLXfiN1zlpp/OoGrMFMRJ4ynS0EP+zX7tFMBOjCpUqSxymR6sIknsvAS/WhR8r+CDSMnbr6BfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICANCj4gKy8qKg0KPiArICogRGV0ZXJtaW5lIFRTQyBmcmVxdWVuY3kgdmlhIENQVUlELCBl
bHNlIHJldHVybiAwLg0KPiArICovDQoNCk5pdDogbG9va3MgeW91IGRvbid0IG5lZWQgdGhlIGst
ZG9jIHN0eWxlIGNvbW1lbnQgaGVyZT8NCg0KPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgdGR4X2Nh
bGlicmF0ZV90c2Modm9pZCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBpbnQgZWF4X2Rlbm9taW5hdG9y
ID0gMCwgZWJ4X251bWVyYXRvciA9IDAsIGVjeF9oeiA9IDAsIGVkeCA9IDA7DQo+ICsJdW5zaWdu
ZWQgaW50IGNyeXN0YWxfa2h6Ow0KPiArDQo+ICsJLyogQ1BVSUQgMTVIIFRTQy9DcnlzdGFsIHJh
dGlvLCBwbHVzIG9wdGlvbmFsbHkgQ3J5c3RhbCBIeiAqLw0KPiArCWNwdWlkKDB4MTUsICZlYXhf
ZGVub21pbmF0b3IsICZlYnhfbnVtZXJhdG9yLCAmZWN4X2h6LCAmZWR4KTsNCj4gKw0KPiArCWlm
IChlYnhfbnVtZXJhdG9yID09IDAgfHwgZWF4X2Rlbm9taW5hdG9yID09IDApDQo+ICsJCXJldHVy
biAwOw0KPiArDQo+ICsJY3J5c3RhbF9raHogPSBlY3hfaHogLyAxMDAwOw0KPiArDQo+ICsJLyoN
Cj4gKwkgKiBUU0MgZnJlcXVlbmN5IHJlcG9ydGVkIGRpcmVjdGx5IGJ5IENQVUlEIGlzIGEgImhh
cmR3YXJlIHJlcG9ydGVkIg0KPiArCSAqIGZyZXF1ZW5jeSBhbmQgaXMgdGhlIG1vc3QgYWNjdXJh
dGUgb25lIHNvIGZhciB3ZSBoYXZlLiBUaGlzDQo+ICsJICogaXMgY29uc2lkZXJlZCBhIGtub3du
IGZyZXF1ZW5jeS4NCj4gKwkgKi8NCj4gKwlpZiAoY3J5c3RhbF9raHogIT0gMCkNCj4gKwkJc2V0
dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVSRV9UU0NfS05PV05fRlJFUSk7DQo+ICsNCj4gKwly
ZXR1cm4gY3J5c3RhbF9raHogKiBlYnhfbnVtZXJhdG9yIC8gZWF4X2Rlbm9taW5hdG9yOw0KPiAr
fQ0KPiArDQoNCg==
