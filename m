Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53A75CF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjGUQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGUQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:28:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CD3586;
        Fri, 21 Jul 2023 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689956764; x=1721492764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gvYnZSboChZX7Z9YmkSXVS9CWIVWw70DEeCqGnHvgtc=;
  b=EmSZ7r0HqXUsbTDY+uIxiS/ZxGGQeBQoG9e1i/sNpahih7+d97qkJzRh
   czb/dBbcdiPdoXf33mevT2zp00aobXgKoOhZywuHcU85gkBZAv0O3JmPp
   H/diwEI4fSMVUlNrD4MsxGVTVz4/SLWcRgAR50W+LeAkgcPGVcjPURiG+
   s6O4zNTwDNEPk82nwrfUyyNP6KdxWrU5bvPRKYb1XHmZpvbC3Ig4JBh8N
   991MsLFDWTnMQf7GNAsNJ3MIpKgzzqsisbSNw1gCGkPA5/3aeL6zD/yiN
   PfW7HLCHkLkWlwJnpSIiCFJ9/qpmwAs4d//BwtSp0pTC0EjPIMXMlv+QC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433294476"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="433294476"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="724919198"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="724919198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2023 09:24:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:24:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:24:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmOFshgRaMospH6OZMMd8rqzz/JiYY2eeymhmCuGzNyORVZ8zMUeX8dp+jnawEfGe3yvYF6OTnvsc9tL5i4twRu5o8ZLrZi3uz1bhATcQv9YdaitX0c9jazTnVbOpy4/P7QBmaw8ZGbF9xIvdQpb36BJJTv+l81F7j9cVDamQya4ps1W4OI28H/6BNGpChnF/5a+OwMXdhzH1gTudwoBovVwZk7USZh50IdRN5LmTdBTMQC4a6ejUg2gxOMMBY6hQI0YxOdk0YSZfktWlOSZLH9v5nmIhwWa9qqXk7vTWkp4CE45189CNh/Opuy30ZGXrkKIfGbrU3lO+QMPDXoQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvYnZSboChZX7Z9YmkSXVS9CWIVWw70DEeCqGnHvgtc=;
 b=FxKzXd9zxS3bWjZqYtPNeeDnDzSMXKzTDI/HQcv/6kIcbY8feS13R09h775fyCzNMZb/c3jdtnxaczU0tT9r4YPlEFsgS6kxaCOEFSlWUE1rI6rQ2PdeEPFmmqsQ8P/6RBLy+ytnQFceIR244JdPIcIla1/xo9lMvG2iQAZnl8BuYjVVnb9dlhxYkDEVP5HrF5c4zExV0gNFA0paMmwk5bQQx/7oJZj3aDX79SzaIyF4Mv6+UU+rEWciHKV7jtA3xBPK+v1v85W/n3zBC2iDWA7SoCuWAc1xfjFgsw369cXyUN4ekfFZQWPDoYMH93L7t68SSFTYWLiR5nHc+a3CEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB5869.namprd11.prod.outlook.com (2603:10b6:303:168::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 16:24:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 16:24:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZupMQ0x6IY54ui0a5ce9+OI1ntK/D5xAAgACDgQA=
Date:   Fri, 21 Jul 2023 16:24:45 +0000
Message-ID: <1b5d436e1b4f31c37ce1f1e6342c836fd5b2ceec.camel@intel.com>
References: <168980685456.28540.8149705038742119504.tip-bot2@tip-bot2>
         <ZLpC/IbswCA0yUHD@gmail.com>
In-Reply-To: <ZLpC/IbswCA0yUHD@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB5869:EE_
x-ms-office365-filtering-correlation-id: 9dc26cf7-89e4-4db9-1717-08db8a06fed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A1WwGWXPfeMKQD5YwpPx5EvszOp24u1tzgvb8xjP1kaFVAuc/rITwdvcykWXtYpNNOD5jYyKXY7WIaOKVR7guxFDLwqF2wIYCrHNgvvf1KO+PSts50Zn6Jg5h8Isb3VIf9SYO9Pqrwux4JtGiO3Q0/nkkdU+z2CnTdSXnE2A9Kobyv70eCdGKtbebam4WX73qSIjGG53wfkdvBgh36mqJ3X1osm8mJ7371J1b5gJpZxElBwYBVe08/+N1IAOF89j/O90bTtboB+t6klDx72yBYVWI/gHNwxd+RLpf1sW41kAYAEfxzUc5jcYyy1pXOaielIOG7NJOe5uVK4FRgNnY2S9K5fSPWjxP8gP7eaXF/9ram4MWe48Dm7hd7f8nYJSMuCo9a4WzbM2hT6LltdWYVfbj3s2hj9ffJSPdGBwsRM7FExdLxIma4NACyjCOm0huDmbGYR1KL5A6I1e6rRsK+EZS4ezD4c7/GFXPrab0RSQuBXEgiz0IsTTeNA1LDrF+QzzfGXOjPzjwHjmoY4JdA8/RRKYe08exq2Zr3WqtUQLPJXIf4hZWXRZ8PI8BONGgkVgHQRjZANQJDDzkkMzwV+d3Iatssls8PocBR49QlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(478600001)(71200400001)(110136005)(91956017)(6486002)(26005)(54906003)(186003)(6506007)(966005)(6512007)(2906002)(7416002)(66446008)(5660300002)(64756008)(41300700001)(316002)(8936002)(4326008)(122000001)(66556008)(8676002)(66946007)(66476007)(76116006)(38100700002)(82960400001)(86362001)(36756003)(2616005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZQem8wRFlzcnhmNUVoeTVqZHlCcmIzazQ5NUM0MkRibXJ4cE9jaXh6ZFcx?=
 =?utf-8?B?SU5wSVdVaDF0aDBWQ3MvQ2EwSm1kczJybDdVSnM1K3c3NTB4ZWgwWGl0aS8w?=
 =?utf-8?B?R3ZPS3hYTHhqUE1Ed2ZCT2RZUFdtUWJpOVdjS3FJclFVMnNHclhBMVQ0bUxG?=
 =?utf-8?B?ZlNoTkh4Y05qSG54bUY3UnlrL3RVZjMvbnl1K0JpRlMxeEZnbnVEY2cxN3p3?=
 =?utf-8?B?STRMdnNlM3ZkV0pLU1RVeDdTM05xRFV1K0tlcUl0N2NBTVBJQmZyUzYrdEk5?=
 =?utf-8?B?Z1paNjlRL3pWN0lFV3hpWGlZM0hiTGk2RW9aR3l2aUNhaHhhQjlucWVVbDVL?=
 =?utf-8?B?SFExOVppK2ZvWnVrRXVlWEwvcmM1bnVPeGxCRXl1YXNnQXVNVHJSUEwvRU5n?=
 =?utf-8?B?RGliZnRvNzVqVnlyWis5TU82QmpXanFBcC9JTjRSL204SVhjUFpvZzB1czh4?=
 =?utf-8?B?SVB1NDZuRXg0dW1qZ1ZmaWMvM2hwdmVIcC8rc1RoRE02Wm83TkxjM3dBdGgw?=
 =?utf-8?B?ZXZPY3JzM2ZReFRRcnY1YXZrYWxKS3ZESXBxU3IzNXd4L1JLM1NZd0w1Ym1u?=
 =?utf-8?B?SXR5eHZCcGlkSkc1bzl1eS9UNENiOEpKZlJzRDh0L1FGZWp2dFRqaEdCYVlD?=
 =?utf-8?B?eURiak9FcHFjc285OXloRnNTY1l3eW1OQzFQcDBOK2t5am9aQjhmNGV0RlI2?=
 =?utf-8?B?bVdQeEtXYStXaEh4ekhkY2UyYmxEQ2ZXem9uK1MvZFU0VEJaOHdPWXpocmVj?=
 =?utf-8?B?M05BWXVyVENZZGRmMFdxRWtFeG1XL3Zvb25UNlYvaExPTmFNcVdHUTQxYkF5?=
 =?utf-8?B?eFVsUDR4VTczNEdVdWtReEpjd3ZIZVdRTktmcUZiZWVtbnp6VnMyTTZMOXd0?=
 =?utf-8?B?WkZ3RHhCL3FPMUg4cm90djAvYW5FdGRnRVAwZGxXMGwzZkZrQjZGWFdjTy9w?=
 =?utf-8?B?ZVUyYXhLTVV5N0ZMTVJiVHhhVnNzbEkvaUtnVXUyaitWUnpqdXFIWmVDRWVk?=
 =?utf-8?B?U0FvYkwrOFU3Wkt2Vzl2Y3Z5TXp3RTJEZG5VR09JWW9yMlhqeHc5d0NISXBo?=
 =?utf-8?B?eDU5R1JYOGZJQ0tYU2tjL3ZIZW5rR0Q3d1VzUXUzbEZkRDd1RzFtci9haFZn?=
 =?utf-8?B?NWRPUW9Qc0VSTmhoUnlGcG5wT1pUYkxyd0ZBbEdKdnFFR3ltYjhiVUw2Nlo0?=
 =?utf-8?B?QTNqVWFpU3ZHeGI2Rmx2R0R1ZFEvRG9oTmEzbFJmQTh2MDVhUUJrWGE4RVd4?=
 =?utf-8?B?UTlyaFFhSFZtZmJ5aFVRT1hvU1hGOHorMzRpaVJYYXVvZ2FTd3ZHRFFYTXBV?=
 =?utf-8?B?L3JaemdKbnIxejlETlNQMWVnZzg2aTdPZlY1VVRvZEdhclNsM2VMWU5iZDIx?=
 =?utf-8?B?ODNYRU5sL1Rzb1pHMFBiaFNZemVzWVFzVWluREd5WmtxREVtSFZXQnY1QUFD?=
 =?utf-8?B?MktZVGJUMjNPUzRWWHpiUWhPcElXQmNOYU1PMTVFL3FYVmNkTkN1WTJMdGwx?=
 =?utf-8?B?alZOZzRTQ0twUkVRV1dZODZYRnRRNWVPeVF6d044NFdUNDEwVysycUxubmda?=
 =?utf-8?B?ZVlQUlJ5TTMxS3hoeTkyMkFmNVhCRTZTM0ljbGZiVWxoMXRYRWlwdGdFYTZu?=
 =?utf-8?B?RGpMcWMwdGZ3NDJyVWhBbW9pS25CRW5IaFVZQ2tGWW5Hckh1QXFhdG0wcTNa?=
 =?utf-8?B?M0M5SXAxcFhHL1RtajJKQzlHdjd0ZWRKVzNSZ1NqN2Nac2JZRmJleGtmcWJ1?=
 =?utf-8?B?UXI4Z1BpMEs0YWFuRHNkR2QxbDFNSW5tNkJqaEFDUjlnZkFSazQyYVdIUjY3?=
 =?utf-8?B?Z1c2ZW1EblhDMVlBclZ4eEUrK285ODZnV0hGR2RJRVVVdWd5aVMwSFkzNFMw?=
 =?utf-8?B?WU4zaXBiZkFlQTlYU3RjbWVmY2s1RjJZZUpiOEVnVWpVM0VLbDYzaXpyVFdn?=
 =?utf-8?B?TUE2elJJdjl4RU8rQUZTeklNQlgwT1dtZXY1SGN1Q01RWkVwck5xald0a3JO?=
 =?utf-8?B?T25paXhBdzZHS0dEWStNVWJadkZTMm9qOGtmcEFtTGQxSXVZb094STgyd2RP?=
 =?utf-8?B?bzZ4VVNBMzFUSFFidjMxcWRZcWZETFZTaHhLR0Jsd3Vzb0dCdGt2MTVhU290?=
 =?utf-8?B?dGdBL1BYSVJZMHFlL28va0w5RDdhSjRQbXZrTDVkdGNLNStHMVcvUHZSNHBY?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B81AB171A91B7F47A8C5BD6410E12777@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc26cf7-89e4-4db9-1717-08db8a06fed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 16:24:45.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nz6GyVSasJ0mXX4txEahdYb7Gev1q9OUYpu7ncqI5EZc9KckP0PZrsgrQoa7eni89BdoTYmma5GVfoLYyeh+a5EwnTtP5UXC75qUbgE+P2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5869
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDEwOjM0ICswMjAwLCBJbmdvIE1vbG5hciB3cm90ZToNCj4g
DQo+ICogdGlwLWJvdDIgZm9yIFJpY2sgRWRnZWNvbWJlIDx0aXAtYm90MkBsaW51dHJvbml4LmRl
PiB3cm90ZToNCj4gDQo+ID4gVGhlIGZvbGxvd2luZyBjb21taXQgaGFzIGJlZW4gbWVyZ2VkIGlu
dG8gdGhlIHg4Ni9zaHN0ayBicmFuY2ggb2YNCj4gPiB0aXA6DQo+ID4gDQo+ID4gQ29tbWl0LUlE
OsKgwqDCoMKgIDdjOGY4MmRiOGFjYjlmMDkzNTcwM2MwZDk2Y2RhNTUyYmJmOTFmZjINCj4gPiBH
aXR3ZWI6wqDCoMKgwqDCoMKgwqANCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC83Yzhm
ODJkYjhhY2I5ZjA5MzU3MDNjMGQ5NmNkYTU1MmJiZjkxZmYyDQo+ID4gQXV0aG9yOsKgwqDCoMKg
wqDCoMKgIFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiBB
dXRob3JEYXRlOsKgwqDCoCBNb24sIDEyIEp1biAyMDIzIDE3OjEwOjQ4IC0wNzowMA0KPiA+IENv
bW1pdHRlcjrCoMKgwqDCoCBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQo+ID4gQ29tbWl0dGVyRGF0ZTogVHVlLCAxMSBKdWwgMjAyMyAxNDoxMjo0NyAtMDc6MDAN
Cj4gPiANCj4gPiBtbTogRG9uJ3QgYWxsb3cgd3JpdGUgR1VQcyB0byBzaGFkb3cgc3RhY2sgbWVt
b3J5DQo+IA0KPiBKRllJLCB0aGlzIGNvbW1pdCB3YXMgdGhlIGxhc3QgdXNlciBvZg0KPiB3cml0
YWJsZV9maWxlX21hcHBpbmdfYWxsb3dlZCgpLCANCj4gd2hpY2ggYnJlYWtzIHRoZSB4ODYtZGVm
Y29uZmlnIGJ1aWxkOg0KPiANCj4gwqAgbW0vZ3VwLmM6MTAxNToxMzogZXJyb3I6IOKAmHdyaXRh
YmxlX2ZpbGVfbWFwcGluZ19hbGxvd2Vk4oCZIGRlZmluZWQNCj4gYnV0IG5vdCB1c2VkIFstV2Vy
cm9yPXVudXNlZC1mdW5jdGlvbl0NCj4gDQo+IFRoZXJlJ3MgYWxzbyBhIG5vdyBvcnBoYW4gcmVm
ZXJlbmNlIHRvDQo+IHdyaXRhYmxlX2ZpbGVfbWFwcGluZ19hbGxvd2VkKCkgaW4gDQo+IHRoZSBj
b21tZW50IG9mIGZvbGlvX2Zhc3RfcGluX2FsbG93ZWQoKS4NCg0KT2gsIHRoYW5rcyBmb3IgbGV0
dGluZyBtZSBrbm93LiBJdCBsb29rcyBsaWtlIGEgcmViYXNlIGVycm9yIG9uIG15DQpwYXJ0LiBU
aGlzIGh1bmsgc2hvdWxkIG5vdCBoYXZlIGJlZW4gZHJvcHBlZCBpbiB0aGF0IGNvbW1pdDoNCi0J
CWlmICghdm1hX2Fub24gJiYNCi0JCSAgICAhd3JpdGFibGVfZmlsZV9tYXBwaW5nX2FsbG93ZWQo
dm1hLCBndXBfZmxhZ3MpKQ0KLQkJCXJldHVybiAtRUZBVUxUOw0KVGhlbiB3cml0YWJsZV9maWxl
X21hcHBpbmdfYWxsb3dlZCgpIHdvdWxkIHN0aWxsIGhhdmUgYSByZWZlcmVuY2UuDQoNCkFzIGZv
ciB0aGUgYnVpbGQgYnJlYWthZ2UsIEknbSBub3Qgc3VyZSBob3cgdGhpcyBzbGlwcGVkIHRocm91
Z2guIE15DQpydW50aW1lIHRlc3QgZW52aXJvbm1lbnQgd2FzIG1pc3NpbmcgQ09ORklHX1dFUlJP
UiwgYnV0IEkgZ290IDBkYXkNCmJ1aWxkIHN1Y2Nlc3NlcyBmb3IgdGhlIHg4Nl82NCBhbmQgaTM4
NiBkZWZjb25maWdzIHNwZWNpZmljYWxseS4gSSdsbA0KaGF2ZSB0byBmb2xsb3cgdXAgd2l0aCB0
aGUgMGRheSBwZW9wbGUuDQoNClJpY2sNCg==
