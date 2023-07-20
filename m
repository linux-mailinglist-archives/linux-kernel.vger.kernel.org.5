Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3440B75AF57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGTNLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGTNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:11:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B82D4F;
        Thu, 20 Jul 2023 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689858649; x=1721394649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zn/8QrUN2kiG4r+BoYYl3HJgKPkvWG3AFc0JuiqDEIE=;
  b=fE8Cjei19P3mE5P55EGCYvZ/gm56toh40YDhCZbK1VyrMfW22Sm1YmSX
   Iv5EGUfG48GUryuk/DCUuwG6kAB/uP6nzf3NoZlmfhj1/suDGC7MFHTuZ
   cZmk6mn2QRxn9gzPNOZ9Udas9t0lFyMS7YjLrA/8T+S0tXRe8LBuwGTCe
   GaN31hYB5rKYLNPvy0nViJLNBLIi3KpVWvSXEg9QvY9oBRcxrRDmd2KW0
   seIOz1p5V1mlpd2tAXtpG6UzPmQiVSlrz0LGEPbO5+QJp7Q6kqcCBv2OL
   vUnBByu4Oby+mK/sMbUPB/g0XXES49/5w4DKUWPTw9iU6dMOysvRaCW21
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366757086"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="366757086"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 06:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898264795"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898264795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 06:09:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 06:09:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 06:09:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 06:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbLcq8A7THc5LQ/RXz5/Xg5qZrOTRTd18yJG25xkRY5v0wlIaW3ufemNOPIFPHH5kJKdoiC86//hrkwyrWpTn75ehyUKytiHSboacmugqDbxcEuDWJ96sBMaT2ZgWPSd2j3TZtqRw51W5AJ2mMBn2MlX18sAy/ywaewapRaBTnlv7yzdwSVZiZUAt7Ov3+9yRra+lecElxJdqGF35Q5mfPo0BTmapMm7tnkVTTmwr7uSzU99dtohiY45PbkCpoKUcmTU9kTVAD0ZHRs/Jo1emd6897kfwbFnKg2xr4xaMYpjMRFmO/mcdj/I5p7dt8vXGD/t1XWrPL4k9sjue+0OrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn/8QrUN2kiG4r+BoYYl3HJgKPkvWG3AFc0JuiqDEIE=;
 b=J1v0CyRHrX3TH6qyGknvdiMxHVnljGuV6dS7dY/LELictCLWy9Rsjg+6wrSsM6cBZgn3Gl8EkN/EaT7xt/05SHXPOWFjrg6ia9UGrR4lEKVyp4a9tEKHdKpsYM+dG736gl7AFrp1ptScxDDYkymWh7KLRlFSDyB+tqaj+GajlwpziCSyNli7sXB+ApVieHtHft2etG3Itxq/OqIBYJ3cz/h45moyKeJXjIrq732NQam3vK68xTlscMb7j6FZ968kL5Q4WHisTRUUpvKcQ05U5ArLgfAli/+bl0KfsovRinwZ8xUdl2wwnsj80IvVeyMBMY/F/mpxchYSDUfNNi5BpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by LV3PR11MB8555.namprd11.prod.outlook.com (2603:10b6:408:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 13:09:06 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 13:09:06 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "Rudolph, Patrick" <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids
 support
Thread-Topic: [PATCH v2 2/3] hwmon: (peci/cputemp) Add Intel Sapphire Rapids
 support
Thread-Index: AQHZtKEPX2F38+0udUevihdZtQL61K/BIluAgAGLGgA=
Date:   Thu, 20 Jul 2023 13:09:06 +0000
Message-ID: <e9c80a369f3f64d0c84e4b7230daed4e7e0f8ff3.camel@intel.com>
References: <20230712091241.3668454-1-Naresh.Solanki@9elements.com>
         <20230712091241.3668454-2-Naresh.Solanki@9elements.com>
         <1322270b-da95-7e7c-0a68-fc883ba09dc9@roeck-us.net>
In-Reply-To: <1322270b-da95-7e7c-0a68-fc883ba09dc9@roeck-us.net>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|LV3PR11MB8555:EE_
x-ms-office365-filtering-correlation-id: ca99f06a-0daf-4bab-6852-08db89227fa2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmKrILkNZPE6SCUYDBvafERDCBChrlGRvGmYKq9GyP7aC3CIlCOYbMC8pPKa0HDw8+vaGu7Y2VK75EcJCbSvV34jZWASnhNPJPAVd4Si+IrQJhpKO4QMeknWXH+juOs4QUJKM9gPbzI33LLBlBNM+iJQpuBkp1if9jg0sRn6Pg2Nus1Jm+xu7D5aXei9zk1LYwTHesS26Bjf8fniHmLiIDMUt84d3KmEDLPqWqnMsj+EmQ7r7ALVe9sn5tzzLSwZNMXpXefzt8KBToz5YoF3kVe6AtEgyc+Zy7Va5kBXpVRgyRJTR58+iIk6dOU4KDUQC7tRKfnX/mhDTfTkIxz0cKmV801VVur9fvkfdKcxaERTaFPmyUswiUg7g0f77HSjKy7P7OU21+6wZoNKCKlP20nAmS09bCPDtsPsHP9JxMyYnPoDksQvB4D2VljyeOOcvYfa8wmLGfCew3YtpurqxiDKqwlj5FvnhVU2fqS4D4qDfyc+OI+2hity3cVZKfmqYXTyjkxCr7S9DOdibQxedO0zfQ3Bvk/tHB1INLKH1N5fKlZKEfAEqXgbglvTdrRkaAtpbc6XYqiedAfbhUITMv1K5dgcG8WUEECX4A5c9NNoTWsQe6i6nymGRarjxjhv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(6486002)(2616005)(82960400001)(478600001)(186003)(71200400001)(26005)(53546011)(6506007)(6512007)(41300700001)(8676002)(66556008)(66476007)(66446008)(8936002)(4326008)(316002)(86362001)(91956017)(36756003)(38100700002)(110136005)(2906002)(76116006)(5660300002)(64756008)(38070700005)(66946007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWdibGsxVXRxTUhrWm0wVndtcnlSb3pIdHRRMFlkYTlBaDBkMHRIbUJiL2Zq?=
 =?utf-8?B?TmNNUEVOd2VBSjNGaWhySXlpeG8vK0tzd2h5TmxqanM1RU1zZWdpMmMwM3R0?=
 =?utf-8?B?U0o4K3BON0JxZ0t4Q3hQYk01NGdNRDZnZ1QrUzJVeEZEWXp6RGVTNlBSbS9Z?=
 =?utf-8?B?N2VOaEVvRVkwMElvNlNYeFZ3TmlEWWlrRlkxb0JKeGNURVMwNTNBa3poYmJh?=
 =?utf-8?B?UVFvTTdMQnNoeE4rVjNDSjVGajVFT0IxSHR5cHdvbkkvVFdraFQ3a2Z6TjVq?=
 =?utf-8?B?aGdaUExuVlhuZXhYbXphTFhCSDh6WXQ5T1ZVWXNQanBoTlA5cTRsNEhRWjly?=
 =?utf-8?B?RmVzTnBxOWg4WVc1TENpYm1yWXdJWHZ1bHdiZGtYRE9xZ0lvSlNyeXVIUWlH?=
 =?utf-8?B?UjdwZHl6SytCTWRpTFR3dWFMMTk3SFhpd0o4anVBZStzYTRPUktPMUFTTEc0?=
 =?utf-8?B?QUl1d2Y4NlZzeER3aGh1NzJ4eUk5eXdMai92TzJvYndhRzlLNEZJSzZya01F?=
 =?utf-8?B?KzBGNFI0R2xmbDAxcTI5V2RQbjhlN0d2akFteTBQODAwUktjK2p0YW52d3Vn?=
 =?utf-8?B?VkVsOUVnR09OMlBZUG5TSVZhSjdDUkRKbmNXN0MyVURDcW5iK08vcHJpdmdY?=
 =?utf-8?B?Wm4yeWhvUUdiYjZ6R2xxNjA2VFpzSXdUQkNvS05QUFFWUVVselNwNy90SThy?=
 =?utf-8?B?Ym5hS3hjT2Z0Qm5EaVduOUIxdXlGMHhENWtyN1VTdHh1dzRLLys2NVpyRkY3?=
 =?utf-8?B?QjlqT1NXQXNMWjJFUDVjNjdxemFWS0ZxNHVpakxWcnFpUWg0RGlvc01VWWx0?=
 =?utf-8?B?Q2Q5YUJucC8rMEhsTGVHTGpLeXpCSnRWalo4THUxdkl2ZGVjdS9jYjFzZmxr?=
 =?utf-8?B?c3NHc2o4REZvWVR0N1JlRnBmMDRuVG9qeThkMFdReDl0Qmd1YVZvTVdZNDRl?=
 =?utf-8?B?cHdiVVVIWG9pNVZFYnZTWGdmWjhTT2cweFAzRkVvVTBRQWZvVURRMzA1enJ5?=
 =?utf-8?B?bnR3ZUc5UUEzMEcvR3ozRHArTXk2YVczZExkRytwSUpYQ3d2OEFta25OQlFj?=
 =?utf-8?B?NjNTQ1hkakpyNG5OUHlOUW1DWk9ZU29pamJxa3hKb2JhdWloaG5LcENoaXk2?=
 =?utf-8?B?dk1MSmRuUER6UUVNcjh4ZnB3SU4zK1lKbjhDenlXYnR4UFBpSjVveG0rR2dE?=
 =?utf-8?B?dEp4d2hUdTBrK1pYdTBOaktQdDR5UkRvSHZNQjRjMDBNNlBVNlFOQnVxRWox?=
 =?utf-8?B?R1cvRURkYUpKcnk0OWpXL2dJZWpjS2dCMmVEU1FsWExJNnBVZnNjOWY1Rmhq?=
 =?utf-8?B?ak1JNmdvWEM0WGtQeFJaNHErZ0pkeWJVWUptOTU5UVl3TkhKQkxzT1dlY1U5?=
 =?utf-8?B?UnVKL1RVUzJUZ21HajRiaUpLUDE0T0tTS05HZnJOOVRoNkVQdzgzQ3FMbUFE?=
 =?utf-8?B?eVF0a0FkWmlzajBYWUFTaGZVY2VwbmFLcDJzbDIwR0I4dnRyMFMwZzlXU09k?=
 =?utf-8?B?dzNKcjY0NUt0a2ZwYzRtSTVkQWM1WmhRalhkOURjaXJ1b1lXUXYxNFdERDlB?=
 =?utf-8?B?YW05YVkzQ2kzcVpuZFdReUlzdEoyM1BNK1Y0M1ROeWRXZ2wvck9DVGh0dUtX?=
 =?utf-8?B?MnpsaEFjRnhHZmtMVjQzYXZ2bHJ5d3NWT2Y3Qkc1MUVnR0hVTVNLKzY0akhZ?=
 =?utf-8?B?dy9HSVcrWVdaRkUxS2FFU0E1Z1FVMFo0ZzJnVlFSSzlkZlNvNy8xejNjRUFp?=
 =?utf-8?B?d2x4UEtYbCthTlpONjhsd2tlQXZvUUdMU0ZTajU5WEtqbzZ5UjBJUHNhd3V0?=
 =?utf-8?B?N0E0NEhGcDBPQ2VScnpPS2ZIdlNmVjJZYUJLc0haRjRjb2taY0g0Nlh3WFAr?=
 =?utf-8?B?akdYVnpQQ042ZUZseEJjcVRDSEpkdUkvYTB1UUsrOW1wbVFIYUQ1REJFcnFh?=
 =?utf-8?B?bU83cC8rcGpKbXZScmhwUVZYcjRzZmNCOUt5MWRtM0Z6T0RPNmJTSVFvZ2NH?=
 =?utf-8?B?dUdyVWVQWjZEbXErNWJMN3paUmpvd09wVVh5VXEySlNiaWFncitRWklVMFhK?=
 =?utf-8?B?V1RzaVRnL2tCaWFWWk9VMW04NXZFY204N3pMazFWZ1orODU2aGRNZlVrK1Fr?=
 =?utf-8?B?cTRTamxFcHBJMmVaQVAxVXZTRTVCRnVIakdPN01JRHdpYWNvV3NFT3NjTHhU?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA1378F1076DF1478B3475EDB1870627@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca99f06a-0daf-4bab-6852-08db89227fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 13:09:06.6063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/qKq7P7MWxuQogxFaDsqpYiql2IbZofl6MTzNajKqHhZ2IgR3PRyVJdz7vYfzQGEh7BWDGrdJdCKPwlsWzuN3T82/Rp5T8Kuo6hkPsHEFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDA2OjM0IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOgo+
IE9uIDcvMTIvMjMgMDI6MTIsIE5hcmVzaCBTb2xhbmtpIHdyb3RlOgo+ID4gRnJvbTogUGF0cmlj
ayBSdWRvbHBoIDxwYXRyaWNrLnJ1ZG9scGhAOWVsZW1lbnRzLmNvbT4KPiA+IAo+ID4gQWRkIHN1
cHBvcnQgdG8gcmVhZCBEVFMgZm9yIHJlYWRpbmcgSW50ZWwgU2FwcGhpcmUgUmFwaWRzIHBsYXRm
b3JtLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNrIFJ1ZG9scGggPHBhdHJpY2sucnVk
b2xwaEA5ZWxlbWVudHMuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogTmFyZXNoIFNvbGFua2kgPE5h
cmVzaC5Tb2xhbmtpQDllbGVtZW50cy5jb20+Cj4gCj4gSSBkb24ndCBrbm93IHdoYXQgdGhlIHBs
YW4gaXMgdG8gYXBwbHkgdGhpcyBhbmQgdGhlIG5leHQgcGF0Y2gsIHNpbmNlCj4gKEkgYXNzdW1l
KSBpdCBkZXBlbmRzIG9uIHRoZSBmaXJzdCBwYXRjaCBvZiB0aGUgc2VyaWVzLiBBc3N1bWluZyBp
dCB3aWxsCj4gYmUgYXBwbGllZCB0aHJvdWdoIHRoZSBwZWNpIHRyZWU6Cj4gCj4gQWNrZWQtYnk6
IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4KClN1cmUgLSBpdCBjYW4gZ28gdGhy
b3VnaCB0aGUgUEVDSSB0cmVlIG9uY2UgbXkgcmV2aWV3IGNvbW1lbnRzIGFyZSBhZGRyZXNzZWQu
CgpUaGFua3MKLUl3b25hCgo+IAo+IEd1ZW50ZXIKPiAKPiA+IC0tLQo+ID4gQ2hhbmdlcyBpbiBW
MjoKPiA+IC0gUmVmYWN0b3JlZCBmcm9tIHByZXZpb3VzIHBhdGNoc2V0IGFzIHNlcGVyYXRlIHBh
dGNoIGJhc2VkIG9uIHN1YnN5c3RlbS4KPiA+IC0tLQo+ID4gwqAgZHJpdmVycy9od21vbi9wZWNp
L2NwdXRlbXAuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ID4gwqAgMSBmaWxlIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vcGVj
aS9jcHV0ZW1wLmMgYi9kcml2ZXJzL2h3bW9uL3BlY2kvY3B1dGVtcC5jCj4gPiBpbmRleCBlNWI2
NWEzODI3NzIuLmE4MTJjMTU5NDhkOSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvaHdtb24vcGVj
aS9jcHV0ZW1wLmMKPiA+ICsrKyBiL2RyaXZlcnMvaHdtb24vcGVjaS9jcHV0ZW1wLmMKPiA+IEBA
IC0zNjMsNiArMzYzLDcgQEAgc3RhdGljIGludCBpbml0X2NvcmVfbWFzayhzdHJ1Y3QgcGVjaV9j
cHV0ZW1wICpwcml2KQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAocGVjaV9kZXYtPmluZm8u
bW9kZWwpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIElOVEVMX0ZBTTZfSUNFTEFLRV9YOgo+
ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgSU5URUxfRkFNNl9JQ0VMQUtFX0Q6Cj4gPiArwqDCoMKg
wqDCoMKgwqBjYXNlIElOVEVMX0ZBTTZfU0FQUEhJUkVSQVBJRFNfWDoKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcGVjaV9lcF9wY2lfbG9jYWxfcmVhZChwZWNpX2Rl
diwgMCwgcmVnLT5idXMsIHJlZy0KPiA+ID5kZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlZy0+ZnVuYywgcmVnLT5vZmZzZXQgKyA0LAo+ID4gJmRhdGEpOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gQEAgLTUzMSw2ICs1MzIs
MTMgQEAgc3RhdGljIHN0cnVjdCByZXNvbHZlZF9jb3Jlc19yZWcgcmVzb2x2ZWRfY29yZXNfcmVn
X2ljeAo+ID4gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLm9mZnNldCA9IDB4ZDAsCj4gPiDCoCB9
Owo+ID4gwqAgCj4gPiArc3RhdGljIHN0cnVjdCByZXNvbHZlZF9jb3Jlc19yZWcgcmVzb2x2ZWRf
Y29yZXNfcmVnX3NwciA9IHsKPiA+ICvCoMKgwqDCoMKgwqDCoC5idXMgPSAzMSwKPiA+ICvCoMKg
wqDCoMKgwqDCoC5kZXYgPSAzMCwKPiA+ICvCoMKgwqDCoMKgwqDCoC5mdW5jID0gNiwKPiA+ICvC
oMKgwqDCoMKgwqDCoC5vZmZzZXQgPSAweDgwLAo+ID4gK307Cj4gPiArCj4gPiDCoCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGNwdV9pbmZvIGNwdV9oc3ggPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLnJl
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gJnJlc29sdmVkX2NvcmVzX3JlZ19oc3gsCj4gPiDC
oMKgwqDCoMKgwqDCoMKgLm1pbl9wZWNpX3JldmlzaW9uID0gMHgzMywKPiA+IEBAIC01NDksNiAr
NTU3LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY3B1X2luZm8gY3B1X2ljeCA9IHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqAudGhlcm1hbF9tYXJnaW5fdG9fbWlsbGlkZWdyZWUgPSAmZHRzX3Rlbl9k
b3Rfc2l4X3RvX21pbGxpZGVncmVlLAo+ID4gwqAgfTsKPiA+IMKgIAo+ID4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgY3B1X2luZm8gY3B1X3NwciA9IHsKPiA+ICvCoMKgwqDCoMKgwqDCoC5yZWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqA9ICZyZXNvbHZlZF9jb3Jlc19yZWdfc3ByLAo+ID4gK8KgwqDC
oMKgwqDCoMKgLm1pbl9wZWNpX3JldmlzaW9uID0gMHg0MCwKPiA+ICvCoMKgwqDCoMKgwqDCoC50
aGVybWFsX21hcmdpbl90b19taWxsaWRlZ3JlZSA9ICZkdHNfdGVuX2RvdF9zaXhfdG9fbWlsbGlk
ZWdyZWUsCj4gPiArfTsKPiA+ICsKPiA+IMKgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXV4aWxpYXJ5
X2RldmljZV9pZCBwZWNpX2NwdXRlbXBfaWRzW10gPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJwZWNpX2NwdS5jcHV0
ZW1wLmhzeCIsCj4gPiBAQCAtNTc0LDYgKzU4OCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF1
eGlsaWFyeV9kZXZpY2VfaWQKPiA+IHBlY2lfY3B1dGVtcF9pZHNbXSA9IHsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAicGVjaV9jcHUuY3B1dGVtcC5pY3hkIiwK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gKGtlcm5l
bF91bG9uZ190KSZjcHVfaWN4LAo+ID4gwqDCoMKgwqDCoMKgwqDCoH0sCj4gPiArwqDCoMKgwqDC
oMKgwqB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAicGVjaV9j
cHUuY3B1dGVtcC5zcHIiLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2
ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkmY3B1X3NwciwKPiA+ICvCoMKgwqDCoMKgwqDCoH0s
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgeyB9Cj4gPiDCoCB9Owo+ID4gwqAgTU9EVUxFX0RFVklDRV9U
QUJMRShhdXhpbGlhcnksIHBlY2lfY3B1dGVtcF9pZHMpOwo+IAoK
