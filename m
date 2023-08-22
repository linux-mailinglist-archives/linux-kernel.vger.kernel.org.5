Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971578373B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjHVBME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjHVBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:11:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411413D;
        Mon, 21 Aug 2023 18:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692666701; x=1724202701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Blgbjw/fScMSONu3RbsLqGnZdv9lZFVgr+K6JiT5xn8=;
  b=M5diad0XEzGt6G2GMu84ERoPk/Tz8bLkvIAEODZQc5+p0YIhwB5J8zlw
   GQF9DyFkQkMbbPYP6beg0hTb0WHLoM3Nj6B89PRxQHhHPEpwOc9PPYqhs
   gBTVgj/+cv0dIs+ZF+JXqXQbv5DDuJ6HS6Bi4d5/nIAs6gT8FijqE3rZO
   0uA5q112SM/FKBy1qbekW4/CUzlYwW3R/WYAUmWe5IVhmudAmTDnlzhVl
   B/0l3Kq0G+HbQxbK3LgLMiY6T7aOhpjSklyJKoa5PzMLGIaz90wFSehlr
   vQ73zTjeV2dVwQvh89z18dFtl+mFoUCRYVN5ylI69g2df8msq8vVDuB6A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376480999"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="376480999"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 18:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="909909595"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="909909595"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2023 18:11:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 18:11:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 18:11:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 18:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/uB0SBRr5I/XWHZ3V9AkXa+g5Lfh+xXRGR7ZN7nLiS/11k/T3/yfAPE5p/UZpMjCLC/kMmbAIC/vAvBilKNpM3rjMXd1y+/8ScJmvZ7eYVff9gR6HzuKtxRYSqsvkVN7yaryFsmcixn/7Bw1+8EhrEj3BZjSodYGI/1KM2IyUHRLvrlj9Jn07BihlEe1QnHPTbBc0vpPsHqS0SxXR+/JOxl+wLC2S+Zfzje0/egMxUt49h1O+N9Mzp8d5mluo0lkHB6AhKxoqSw8lMWYJzWWy/dyJ1TrjMDuh+huoBrB80mi4Pn1sLX5OacWyHEA3WC8FFIXSa7DnOSkCUznWSHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blgbjw/fScMSONu3RbsLqGnZdv9lZFVgr+K6JiT5xn8=;
 b=jRTqeuM2Yyb24tq3rkno4nRsWQGxMhI/n6A7TgpBOIDxmQvGpefGC+ONpZPgby4LWnA68vhTczKNHnD/iRE9TfwufODAIb44dbSOzNCq/0ZEyVQK/j+rQtvagC9wWpl8cgbKDkT97yisD5NCJHf4sRyqAGoABaDIpI0WQzvxv69SvIc+chlXXXX/cs8dC9co8HYoNF2CRJx/Cf90rxNQqetJPKdNkjHwoadJcFhy/1POFWlvXZeIVt2K2u148ccjC4DcI1+Aqb2PH+zhPcK7qpayLxSAOgd2wm4pfHCoYMMgnHuxQpHdWBVdz5Lsqk+3h9pUI34GiJ4CiojWf3gsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 01:11:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 01:11:37 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van Bulck, Jo" <jo.vanbulck@cs.kuleuven.be>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 3/9] selftests/sgx: Handle relocations in test enclave
Thread-Topic: [PATCH v3 3/9] selftests/sgx: Handle relocations in test enclave
Thread-Index: AQHZ0oHEWtAbX05d2kCxqa9DQf/2d6/1hiyA
Date:   Tue, 22 Aug 2023 01:11:37 +0000
Message-ID: <90ad8638bc1c26505e33b3f436fdbc22c8d74ba9.camel@intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
         <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY8PR11MB7169:EE_
x-ms-office365-filtering-correlation-id: b6bd6a9c-599d-4916-9795-08dba2acbbf6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKRrNKZ+jsi0a5+h8rlLQGVmpWjmkpj+UeuwLp9GPh6TUDdXrNOSMDqfFm9H4KRXykPPxnW3hZFuzqp7LbiYlMRSmJ6wGRrARQClpMjQDaY068asbnkabi9fXdG0q1MeK0EeCVbEGWiDlzHq14HslFkp1UjlDJsATyHNTk9btXfWkV1t0z5Dnj4k6m8IKXT2qKqQyIvpUq6pI5z1T9VIiukfd1KOmH5SJde7/1Y8g3sDXU3b2esJuFzNZLNgiHIP5FCafFbkGHpGapqd5ft14lXd0IR4oS49DG2BmjvFUdo2bEoRwTF12fZflUm++J8dkQG1c0YEDMm0Fzh009F69iKaKJNIezh6imoU0FQ7+XkbycA/icCAcojHLkzYoMJ4ee75K4WJ3M0anh+IQdz8VqGTptCICiXoX13H5MHQQ0XvURxpxgiseEGLzvHV4GtY0JnJjnlFJNkz3bC0PzPhQQ4mEG5JFciNt2WPCJ8FZqIv0iOmue3ynVMtityY6hIvZ3umcDLwov6gdykSkihgUvGoJufSq7GQPSyIZKdTY2PqN8i9ux5lunFBnumBHXQu4dvOfxVYQmhLMyqgWsCmcpMmvhbtI2jIj0TjVK5rO9oPEoTOy9llTSBJdBBwkqkl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(6512007)(66946007)(82960400001)(110136005)(91956017)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(122000001)(478600001)(71200400001)(38100700002)(38070700005)(6506007)(6486002)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZHbllIeE11SlNzWWg2V2JCNXIxTDFCNU1wUUxGM2ZRbE9xV2xiV2RmRENr?=
 =?utf-8?B?bWRENEFqa2l2MVJUbTVkVnJlYUN4Y2gxRUUrSWkvdWVRWHZpUmh2MEN2dGdq?=
 =?utf-8?B?YVhHWDFETm1YeFJJSUdTWnFMR1h2UW14QVV1U0FzMjFxSTR5cldETVphZ1Vh?=
 =?utf-8?B?RmVYSUNhaXRuNVg3R3FwZmJ0NnptajVlaTViMXpLeHZaYStqS3RLT0dwY0RO?=
 =?utf-8?B?RkVobTR1ZmFGbXVzKzc3Qm0yTmovTERZY21DVWs3MEFGUDVZZ2hPTnBLQnpB?=
 =?utf-8?B?SjE2alE0azhtcEpjR0NYR3M1NFVwaGJiR2dkeG1CTnZzVzdBRGRSRlRiSitk?=
 =?utf-8?B?SitDcUl1N3RhMmJYSXlDVDVaWXI1Tmp3M2czcFFSQVVOdGlTdFVzanhEYUlC?=
 =?utf-8?B?SXJRT3N1bEtubVpCRXNNcjQ2UGNOOUpNVVY3SFZoTWJhVDcvUXIvSCtVcUlm?=
 =?utf-8?B?WDRvNGlIeWhnaWxjcVFMY01vNjJkb0h0RmlMU3dGekdrU0Uzdi9zQWNZbkJm?=
 =?utf-8?B?VE5sWkphaGZudHpjZS8yU2NsNHo0VHFURTA4YVlIQVJIYkJNRWRwT1lyTE9p?=
 =?utf-8?B?TFpRVHZQeFlReWV2TmtDMEptcERVV1JMelFSSFo5TG1CanhNN3lDMGJGQWZ3?=
 =?utf-8?B?bVFXenRwZDgzdllpUFZ1RlBPOC9uVDlyVmtzUzZJWGdQWlZlYVdjNUhtdDUv?=
 =?utf-8?B?c0lmcHI0R1VVMHVqWlFOODgycmQ4ak9Rc0VwNlEzNjREMXdwQUJJS29VS2tH?=
 =?utf-8?B?QjdwTUI3VTY0ODBsY1djb0pPTGY3MytDanN4T0FCNzRDMEpuYjlHZ3M4bW5X?=
 =?utf-8?B?MXAzc2laSjRoT09obFlUVnhKd3krcnlwWlVGMSs0eGxyNXo4Q0dkRmc3UVR4?=
 =?utf-8?B?RjBSWlc3cmxGbXJlZzcwRHZ1Ty92UTh1cFRtTUhRVFVDeDVOOTAyS0lFNi80?=
 =?utf-8?B?NEJ0am13OHJDbmo3T29qOXZBOFV2ekxQZk8zVDJoTkVUQ2ZzNytpbFk4RGw1?=
 =?utf-8?B?SFR6NSs3MzBRZVkzWVdhWnRJU3hna2FRUHYvRlM0ZjhnektzREpxQ3ZGVTdS?=
 =?utf-8?B?YW1wZ2wvUjRiNm9NMWxyTGtnSlJjZUFvNWtROGcvL0NNSnNqZVgzVUJ4Q0pP?=
 =?utf-8?B?VE53bEpvalluK1g4blA2L0FXTjNpUWR3Z1Nad1gxMnBGbThwbHF5YWt1aExL?=
 =?utf-8?B?a2gwb28vdFJpNkxMeCt2TXQ4Q25hOVhwcmlqYzBLWVcrRnl4dzh5dmVFNWEz?=
 =?utf-8?B?RXdPWEJNVlhDTXRCRllIdVNpR2Zqb1hGM0NOMSt5VTRmMEhoanQyNDZ0Vmoy?=
 =?utf-8?B?NVkzTlV2aUpRZW5VRk42a01PRkxNbzRlMVFIYkpucHdMRWVmZ1R0VDdXQU5l?=
 =?utf-8?B?TGRUQkFrVEhHY040T0h6eGV4VWNPUVZjTUR3K3B6ZjhvT1dLbWphbmpJUDZ1?=
 =?utf-8?B?UXhxZTdCQ3V2NTdDa3U3eEFCRnNReWc4aCswMnZ5RlZJd2xWbUFZcUtmUEl4?=
 =?utf-8?B?d0tJVThoSFpsWFM4UEpBb25LYmx3RWVxOXc2RVZUTSs1VE0vRHF0WU5McDJF?=
 =?utf-8?B?Ly9aZ0Yyc3orSWcxYmx1NnVSMDA2RUtJVHY1MFNmS2JwUTJxMlgwQVRhOUkx?=
 =?utf-8?B?aXNnZFdjTVgzOVYvVFVDNVh4RWgrakJpWTZxYUhUWHM5WjQ1RWlzbmhLcFJu?=
 =?utf-8?B?Vkdoa3BlZVN4YzhxYkpib1kwbURzWC9iZ293NzEzWmNyTUluRDhmNUF5bXlK?=
 =?utf-8?B?NU1uWEw3MTI5bjZCbENvVEdCdlVQUUlaZVRGUURuNXcxY3NjVWpSUmRtdUxV?=
 =?utf-8?B?UllyQ1dtRGpQY0pOd2c3NnBiVWVrZFB3dkFTNmtLVzFweUMxOVd5QnNKUVhX?=
 =?utf-8?B?ZkEzTGk0TEdweC9XSWN0RWprbG9IYjhIdUJrNWhGVy9TOGR1WjZFNUh4MHJE?=
 =?utf-8?B?MUFmcGRPSU9mdzZicC9hemVQcEtzaytDVlJPa1lJZUFTSW5LT0o2WlZZMS9v?=
 =?utf-8?B?N04vZ1E1MW5WNGxPcmswQ0l5NDUwNzBHalNEMWh6MXh2dVo3SFlWRTNuLzZR?=
 =?utf-8?B?RjdrWEtqS0pjOWEyTHdsTzM1ZEVRQmRhK251OUxqRWVqTEhITUxQU3Y2YitN?=
 =?utf-8?Q?yVCFvr/ViH7bkryyoP6+lC918?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA2B4E609FF4A4181763419C4FA7CFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd6a9c-599d-4916-9795-08dba2acbbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 01:11:37.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhNMjr55EFfkHGO2vWMKglMDpCTQ7UwM7ij5YFQd7DxDSIoY1K4DfQPz7GxV2zjmEXP+DRfT1qFlluKlsJnOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDExOjQzICswMjAwLCBKbyBWYW4gQnVsY2sgd3JvdGU6DQo+
IFN0YXRpYy1waWUgYmluYXJpZXMgbm9ybWFsbHkgaW5jbHVkZSBhIHN0YXJ0dXAgcm91dGluZSB0
byBwZXJmb3JtIGFueSBFTEYNCj4gcmVsb2NhdGlvbnMgZnJvbSAucmVsYS5keW4uIFNpbmNlIHRo
ZSBlbmNsYXZlIGxvYWRpbmcgcHJvY2VzcyBpcyBkaWZmZXJlbnQNCj4gYW5kIGdsaWJjIGlzIG5v
dCBpbmNsdWRlZCwgZG8gdGhlIG5lY2Vzc2FyeSByZWxvY2F0aW9uIGZvciBlbmNsX29wX2FycmF5
DQo+IGVudHJpZXMgbWFudWFsbHkgYXQgcnVudGltZSByZWxhdGl2ZSB0byB0aGUgZW5jbGF2ZSBi
YXNlIHRvIGVuc3VyZSBjb3JyZWN0DQo+IGZ1bmN0aW9uIHBvaW50ZXJzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm8gVmFuIEJ1bGNrIDxqby52YW5idWxja0Bjcy5rdWxldXZlbi5iZT4NCj4gLS0t
DQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMgICB8IDQ5ICsrKysr
KysrKysrKysrKystLS0tLS0tDQo+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9l
bmNsLmxkcyB8ICAyICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMTUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
c2d4L3Rlc3RfZW5jbC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3Rlc3RfZW5jbC5j
DQo+IGluZGV4IGMwZDYzOTcyOS4uNzYzM2ZiN2NiIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9zZ3gvdGVzdF9lbmNsLmMNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2d4L3Rlc3RfZW5jbC5jDQo+IEBAIC0xMTksMjEgKzExOSw0MCBAQCBzdGF0aWMgdm9p
ZCBkb19lbmNsX29wX25vcCh2b2lkICpfb3ApDQo+ICANCj4gIH0NCj4gIA0KPiArLyoNCj4gKyAq
IFN5bWJvbCBwbGFjZWQgYXQgdGhlIHN0YXJ0IG9mIHRoZSBlbmNsYXZlIGltYWdlIGJ5IHRoZSBs
aW5rZXIgc2NyaXB0Lg0KPiArICogRGVjbGFyZSB0aGlzIGV4dGVybiBzeW1ib2wgd2l0aCB2aXNp
YmlsaXR5ICJoaWRkZW4iIHRvIGVuc3VyZSB0aGUNCj4gKyAqIGNvbXBpbGVyIGRvZXMgbm90IGFj
Y2VzcyBpdCB0aHJvdWdoIHRoZSBHT1QuDQo+ICsgKi8NCj4gK2V4dGVybiBjb25zdCB1aW50OF90
IF9fYXR0cmlidXRlX18oKHZpc2liaWxpdHkoImhpZGRlbiIpKSkgX19lbmNsX2Jhc2U7DQo+ICtz
dGF0aWMgY29uc3QgdWludDY0X3QgZW5jbF9iYXNlID0gKHVpbnQ2NF90KSZfX2VuY2xfYmFzZTsN
Cg0KSSBoYWQgaGFyZCB0aW1lIHRvIHVuZGVyc3RhbmQgdGhpcy4gIFRoZSBfX2VuY2xfYmFzZSBp
cyBhIHN5bWJvbCB3aGljaCBpcyBhDQpmaXhlZCB2YWx1ZSBzZXQgYnkgdGhlIGNvbXBpbGVyL2xp
bmtlci4gIGVuY2xfYmFzZSBoYXMgdGhlIHJlYWwgc3RvcmFnZSBpbiB0aGUNCi5kYXRhIHNlY3Rp
b24sIGJ1dCB0aGUgdmFsdWUgaXMgYWxzbyBidWlsZC10aW1lIGZpeGVkLiAgSUlVQyB3ZSBuZWVk
IHNvbWUgY29kZQ0KdG8gZXhwbGljaXRseSBvdmVycmlkZSBpdCwgYnV0IEkgZG9uJ3Qgc2VlIHdo
ZXJlIGl0J3MgZG9uZS4gIFBlcmhhcHMgSSBtaXNzZWQNCnNvbWV0aGluZz8NCg0KPiArDQo+ICt0
eXBlZGVmIHZvaWQgKCplbmNsX29wX3QpKHZvaWQgKik7DQo+ICtjb25zdCBlbmNsX29wX3QgZW5j
bF9vcF9hcnJheVtFTkNMX09QX01BWF0gPSB7DQo+ICsJZG9fZW5jbF9vcF9wdXRfdG9fYnVmLA0K
PiArCWRvX2VuY2xfb3BfZ2V0X2Zyb21fYnVmLA0KPiArCWRvX2VuY2xfb3BfcHV0X3RvX2FkZHIs
DQo+ICsJZG9fZW5jbF9vcF9nZXRfZnJvbV9hZGRyLA0KPiArCWRvX2VuY2xfb3Bfbm9wLA0KPiAr
CWRvX2VuY2xfZWFjY2VwdCwNCj4gKwlkb19lbmNsX2Vtb2RwZSwNCj4gKwlkb19lbmNsX2luaXRf
dGNzX3BhZ2UsDQo+ICt9Ow0KDQpBbnkgcmVhc29uIGl0IGNhbm5vdCBiZSAnc3RhdGljJz8NCg0K
PiArDQo+ICB2b2lkIGVuY2xfYm9keSh2b2lkICpyZGksICB2b2lkICpyc2kpDQo+ICB7DQo+IC0J
Y29uc3Qgdm9pZCAoKmVuY2xfb3BfYXJyYXlbRU5DTF9PUF9NQVhdKSh2b2lkICopID0gew0KPiAt
CQlkb19lbmNsX29wX3B1dF90b19idWYsDQo+IC0JCWRvX2VuY2xfb3BfZ2V0X2Zyb21fYnVmLA0K
PiAtCQlkb19lbmNsX29wX3B1dF90b19hZGRyLA0KPiAtCQlkb19lbmNsX29wX2dldF9mcm9tX2Fk
ZHIsDQo+IC0JCWRvX2VuY2xfb3Bfbm9wLA0KPiAtCQlkb19lbmNsX2VhY2NlcHQsDQo+IC0JCWRv
X2VuY2xfZW1vZHBlLA0KPiAtCQlkb19lbmNsX2luaXRfdGNzX3BhZ2UsDQo+IC0JfTsNCj4gLQ0K
PiAtCXN0cnVjdCBlbmNsX29wX2hlYWRlciAqb3AgPSAoc3RydWN0IGVuY2xfb3BfaGVhZGVyICop
cmRpOw0KPiAtDQo+IC0JaWYgKG9wLT50eXBlIDwgRU5DTF9PUF9NQVgpDQo+IC0JCSgqZW5jbF9v
cF9hcnJheVtvcC0+dHlwZV0pKG9wKTsNCj4gKwlzdHJ1Y3QgZW5jbF9vcF9oZWFkZXIgKmhlYWRl
ciA9IChzdHJ1Y3QgZW5jbF9vcF9oZWFkZXIgKilyZGk7DQo+ICsJZW5jbF9vcF90IG9wOw0KPiAr
DQo+ICsJaWYgKGhlYWRlci0+dHlwZSA+PSBFTkNMX09QX01BWCkNCj4gKwkJcmV0dXJuOw0KPiAr
DQo+ICsJLyoNCj4gKwkgKiAiZW5jbF9iYXNlIiBuZWVkcyB0byBiZSBhZGRlZCwgYXMgdGhpcyBj
YWxsIHNpdGUgKmNhbm5vdCBiZSoNCj4gKwkgKiBtYWRlIHJpcC1yZWxhdGl2ZSBieSB0aGUgY29t
cGlsZXIsIG9yIGZpeGVkIHVwIGJ5IGFueSBvdGhlcg0KPiArCSAqIHBvc3NpYmxlIG1lYW5zLg0K
PiArCSAqLw0KPiArCW9wID0gZW5jbF9iYXNlICsgZW5jbF9vcF9hcnJheVtoZWFkZXItPnR5cGVd
Ow0KPiArDQo+ICsJKCpvcCkoaGVhZGVyKTsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvc2d4L3Rlc3RfZW5jbC5sZHMNCj4gaW5kZXggNjJkMzcxNjBmLi5iODZjODYwNjAgMTAwNjQ0
DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+ICsr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC90ZXN0X2VuY2wubGRzDQo+IEBAIC0zMiw2
ICszMiw4IEBAIFNFQ1RJT05TDQo+ICAJCSooLm5vdGUqKQ0KPiAgCQkqKC5kZWJ1ZyopDQo+ICAJ
CSooLmVoX2ZyYW1lKikNCj4gKwkJKiguZHluKikNCj4gKwkJKiguZ251Lmhhc2gpDQoNClRoaXMg
bG9va3MgY2FuIGJlIGluIGEgc2VwYXJhdGUgcGF0Y2gsIGJlY2F1c2UgaXQncyBub3QgZGlyZWN0
bHkgcmVsYXRlZCB0byB3aGF0DQp5b3UgYXJlIHRyeWluZyB0byBmaXguIMKgDQoNCkJ1dCBJIGRv
bid0IHdhbnQgdG8gbWFrZSB0aGluZ3MgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZCBmb3Igc2Vs
ZnRlc3RzLCBzbyBmaW5lDQp0byBtZSBpZiB5b3Ugc3RpbGwgd2FudCB0byBrZWVwIGl0LiAgQnV0
IGlmIHlvdSBkbywgcGVyaGFwcyB5b3UgY2FuIGFkZCBzb21lDQpqdXN0aWZpY2F0aW9uIHRvIHRo
ZSBjaGFuZ2Vsb2cgc2F5aW5nIHNvbWV0aGluZyBsaWtlOiBvcHBvcnR1bmlzdGljYWxseSBkaXNj
YXJkDQoiLmR5bioiIGFuZCAiLmdudS5oYXNoIiB3aGljaCB0aGUgZW5jbGF2ZSBsb2FkZXIgY2Fu
bm90IGhhbmRsZS4gIEFueXdheSwgc3RpbGwNCmJldHRlciB0byBtYWtlIGEgc2VwYXJhdGUgcGF0
Y2ggZm9yIHN1Y2ggcHVycG9zZSBJTUhPLg0K
