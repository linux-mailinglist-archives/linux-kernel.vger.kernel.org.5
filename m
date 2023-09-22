Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B7A7AB924
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjIVSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjIVSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:25:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D3AC;
        Fri, 22 Sep 2023 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695407110; x=1726943110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VmpgElkTcIBJSqbcZdGWBHOhm/E9EgdD9DrqGIcXnBQ=;
  b=aXfuyVITBWUNdq2XYR6VtKcv+AxQ3t2peTR/jRastYTPMwb4H0CKT10T
   IUX+TQE0C+vKwgP164VtjJqaT7eg3tXG0KboQUvOCzD9d1c7RTB+Ajx1M
   LC49MU3JKfRLsk1c4BzRzfypO0jfd0Q3Hf26x0bDTA9NN5ktiovDA7i4I
   Jf5s9UjdFMtDXPADRLPbFqzXBukNN4OgvSOcj84ItyrN3mJSGoE+RdCeE
   WNMwYnVO17RKcpcXMUO4QpJvJzSW7H/diYTek1XOPPYbnJnheUMySVtFI
   Rje+kTaIRt/oEvjXOFFENTmBzrNbsR/F7minYLq9hdFMjD2qcpPbAO1Ch
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="361157277"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="361157277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 11:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="782744979"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="782744979"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 11:25:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 11:25:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 11:25:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 11:25:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 11:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub1Ib0u4Ii+1cZnW/cSizYpZgoTJDIHKoPXvBEmL1K60EJuxOvRwutldI+TDuJ0G3igx5CbSYCqhZVLC4OHtcsBlG6o51mRGJnhThsGD23FVsoUmAHToN3bis9QqcUbgpD8KnPnmw1KLCjn8+b9Khv0Q6k4INbmhIQkDXLCuV6pkOnQ/HapTsg6vR1JU1z/4zl1ytXpDWxusfNlk0LMuk704rcaaO0GCKeR894A6DPZ25jux06ln5eubPtJ5BByPmbnwuXZEtDv9IGTc7e30jQMkibGVyYesbkJh3Xv+jTMcup+I+Hf+wBqbo3bWhICOLEGqGhY4rH/zerivrgCCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmpgElkTcIBJSqbcZdGWBHOhm/E9EgdD9DrqGIcXnBQ=;
 b=a5W6BKK7fc1diKHsrF2a9r3bIdVkudIws14YnFiynS2eG4hRvrvvmsXYBNioDTXz3wLqfH133kpfWKmtMdsOqXpwwpVXLrr30QkSR3zVbJoK0g82cOHZJjGAE1aSMzhoBLN4ZDs0YzJZBuorg7OIxoGaPPxxaIvYPsDCqfpQYySyZ+kDQ6khEt3HGTnJ6W5zAVCQPyeiQsZE7mErhttSknkfqDUytVjG/HZcsrDxtl9FGFN7ff0kc+QZdJGCb2SdUKcI4d8CUQkHINP+BKZWqoHSyNcDmlAk6zn9gptBdtplfW7t4aKdeiok9Sv/xXHwFhRkvOOkWDwo4uNaiKTTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by DM4PR11MB6044.namprd11.prod.outlook.com (2603:10b6:8:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Fri, 22 Sep 2023 18:25:05 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 18:25:05 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>, "Rix, Tom" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with
 __counted_by
Thread-Topic: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with
 __counted_by
Thread-Index: AQHZ7X2zwDzG1ky+J0OeZqc2T6anZ7AnKToA
Date:   Fri, 22 Sep 2023 18:25:05 +0000
Message-ID: <b13e5fa83f13de819f6247b837d71654dfc652af.camel@intel.com>
References: <20230922175319.work.096-kees@kernel.org>
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|DM4PR11MB6044:EE_
x-ms-office365-filtering-correlation-id: c5732659-567f-43f0-6c21-08dbbb993e5d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXsfXq/uOZZLl9CuI1P0h8r7BxiHVweFUbeDhPlwxz8rLll43HuErNJW50UNZSW/IXqlNncON9mzDRcbqr9CgvapvAWzRYMflLJfBGM2ROmnmdeGUI+R2Kja82fBpB0y0yywpsvRT9ovHsS5yr+D+aixst0DfXymCYyoasviJk+U/BH6PTajOx4m92eqYws65PiLuV/rXGfEtzDSvlCAM9KYT+zytNTI8qjprvN24ce+FKFFENcSMU4DHNr1D2oK5998mVxNEW7zM7jZCLqkOV8A6JCv//agzCeRQ8boWHvkjTxa/o7RqefNhbXOClrQJXoaO5RhOLetY2agLjXbYX3pMw7x3dkUYjhGb+ney8lgu3EWMMonyQMdv5p69woujaEnSVr7vIyrkLpoMqzIDA/1HF2xNqRi+pNLM3f417ujxYIyORwenybJKprHxO3BftNNqRRSCdwFuSRus7s3Xb78fA+LHAV8IwU7J57pEDoJ4PtfjWo/SP4qF2K7EodiJWqLXlcrUIZmfmwRT4daEEUTgwH5uJIfL9aJNxVfDX1UC3aEaAfyww4fmuM1LTkRMD/RTVDpk5t0AjNQo6+gRIsP3/xc+iaIg6uSvu5PGS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(186009)(451199024)(1800799009)(478600001)(966005)(38070700005)(38100700002)(26005)(2616005)(71200400001)(6506007)(6486002)(82960400001)(6512007)(8936002)(316002)(54906003)(41300700001)(36756003)(8676002)(64756008)(86362001)(66446008)(66476007)(110136005)(66556008)(76116006)(4326008)(66946007)(2906002)(7416002)(5660300002)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmZmWVE4VG9ackg5OHFHYVlSV3NySU51SlhwZ3ZnTUQyWTB5UWE3L3h1bHpz?=
 =?utf-8?B?RnIzZFpHNzhXbFN1d3dBc0RQN3p4WHRQa2tvUkEvclF4VGJTbVdjKzUyQ05p?=
 =?utf-8?B?MzY2WGxOOGNDcTlIVmlvQVhZRUFJN2g0Rkx6SkxjeWc1QlRNMnJ0YUNPN3hn?=
 =?utf-8?B?TXdnM3pXVWxaQ3FiVXpxTzNOMktqTWZ4UkxoTlNuMTdhcGp0bnBjK3ZROUJy?=
 =?utf-8?B?aTJ0RWM0a2F2QUpwYkRtL0FUVmFGZWd2NDBhTlBmTFlWUUpJMzVsa0RmL3Mr?=
 =?utf-8?B?bWNCdjJjc2diRjFNaTlqOFZGaDVhRHVmaFVVSlMzRWRkSDFvRTErK20rZi9I?=
 =?utf-8?B?bXR6SzBDb3Y3azQyeDh6aFZMaGJ0UnAvYU0rQnR5anNIbkI4NjlwVFJHSjFV?=
 =?utf-8?B?RFZvRCtXV1JBSGxaeWtqUEhNb0pycWNHNElTWVVQcnZwTlBVTUM0VkZYYXJK?=
 =?utf-8?B?UW1rL1ZoTXN2Y0tGZEVob2REMnVNSmt0RHhPT1hJZFVHb3JDWVBqQXZXUlBL?=
 =?utf-8?B?M2EyUXhhWFh3MFhOeEJmTDUxZXR5QUYrNm5IZjd3bWFlSTBlcVFEQ3pSaThH?=
 =?utf-8?B?d2ttdHBJWC9MSzRGeFRwMHVFdGRPVzlzVHpRS3paMTdHcURIVTZLYUxiVDVQ?=
 =?utf-8?B?d3VxQTRXU3BFMmNERXZWc1M0MDdQd2VVcUhVbnJXem1kY2FaNVJkVklZemoz?=
 =?utf-8?B?RjM2Q0R6M2lJM0Rjd3FIZks1NWdSQVZsc1lUUFZlT2lvWThreWNVQ3hsR1Yr?=
 =?utf-8?B?M0UvdXhnQkFOQ3czcm1oN1lhWC9OOWNKbjVDRmRaU1diNVBSUDA3M0RHdGlF?=
 =?utf-8?B?eEIzc2hzdVBPRVE1THhyMmZEMmVZVTZHdDdVdnlKUVdOTCsrNUhScXpLS1JL?=
 =?utf-8?B?WFlyalVlbEVCd1FQZFR5VnYvS1p1OU5GcTRTdFY3Yi8zNmc1L3lldklUN0NW?=
 =?utf-8?B?RjhGVmlXYUdQREs1Yy9mZ3QrbkxDcTc2N0pFY3VpVE5Vd2J1aGo4NGpQWDdJ?=
 =?utf-8?B?Qzl5YUpBcG15elpFS1hOWHV6Z0s4eWQrNmpQeFYyalZZNDhEMGZ2c1FoT3Fr?=
 =?utf-8?B?ODJsY1dCT1JPeGRVU25wK1plWE9GQ1NQdmkzU3BPMCtpOUNzdUFFRXJwUE1N?=
 =?utf-8?B?OTBXZkRjV3lzUjB5WTJKRmFmcDN2MWM4ci83c2wwNm1teERsSmlwN2toRjRV?=
 =?utf-8?B?cWl4YnV2Rjc4NzFQMTM0Qy9KcTQwNDhLZVp4cVhNWGNGZzc0VVlGYlJkSzM1?=
 =?utf-8?B?d0ZoR0JoYTRjUFJML1NBajA2bERsSUZ4R0xNOElMQ0VYWnhQcndJYmZybVEx?=
 =?utf-8?B?WmZzZmVGRmM4aUpPRjkwWno3eWU0bFg5aS9JcVhVU3ZPekFSaTg4KzFmSGVX?=
 =?utf-8?B?TzVBcTAwSDR5UGJzRGd5c3VPcVpOVHRKOHBYeHBPNXZ4R0NLWnhzNVFEWTRL?=
 =?utf-8?B?SXBpRG02UEl6YzllcFhqZ0VkdkdBMUtJeXhxQUl5TkxWaGlrMEI1RWRBT0Zq?=
 =?utf-8?B?ampFY2FUOG1pNE4yYXdKTHpUR05JREJsVjgzUlU3and4SGRTVnI4bGdNN05y?=
 =?utf-8?B?U1R1QVpxNnpuZ2szYXUxOTkzYncwZm1YQ1VHcldFZVVHdWtZMHEzblpSSkFh?=
 =?utf-8?B?V050QTZDekhPR0d1c1FEOWQwN3FWdnZtb3FwQmljN1ZJWFNMbjUvTlpPKzl4?=
 =?utf-8?B?RWpCOTV2SWdtZ1lKRUNIWldlWnJCbnhYMXJlOUU4WHVsMkhIcVBPVDZxeXIv?=
 =?utf-8?B?ZFJSbnZFSGswT3NNb3pzbTNkR3ZmZE05dVVEZXNnRzdNUEFiek5zWWE5WFAr?=
 =?utf-8?B?aDJNNTlCaUZVVWlhMzV5VXZxaVMyM0l2SUpZRGF6UGVYSk5vcldpWDBtM3hV?=
 =?utf-8?B?TkVpYkRSc2d5OEtnblI1TStuMDJtQUhOMUp3Wk5UWEFmdHUxVnk3a2tiK0ZB?=
 =?utf-8?B?YkxoQUJRU3IwYmxqYmN3cnhCdGYvMjl6dnZjMDdvQUJseDFObUxtWFdRMCtH?=
 =?utf-8?B?dE5RSjZ3ZFFRNUdqTTNYV3dKL0J0TFBEQ2Z4b01DZjcvNFFMc0dhamZSQ0ZL?=
 =?utf-8?B?c28rYTlwS3NXMXI3UU1PeStIZk5SNXlZTHgxQmNOWUVvNGhQSVhIQ2ZYbGtw?=
 =?utf-8?B?OGdobFRLWUVBMHlXU1NPb2FZYzV5bzBYZVJJYnhEdXJySlE4R3FFM3FkZW1L?=
 =?utf-8?B?ZGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58DE6D0C611C714DA8CBB9F6707371CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5732659-567f-43f0-6c21-08dbbb993e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 18:25:05.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzIhDYKlj57PbzRo9NtkSs1cTWA2er7Y+9n1ZUtNRuLAHBU+texG88RKaFFBD1Ywl60PQX9SxTZVEKeBVtqsyAj/bujVKkhaebYvcaCAb4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6044
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

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDEwOjUzIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IFBy
ZXBhcmUgZm9yIHRoZSBjb21pbmcgaW1wbGVtZW50YXRpb24gYnkgR0NDIGFuZCBDbGFuZyBvZiB0
aGUgX19jb3VudGVkX2J5DQo+IGF0dHJpYnV0ZS4gRmxleGlibGUgYXJyYXkgbWVtYmVycyBhbm5v
dGF0ZWQgd2l0aCBfX2NvdW50ZWRfYnkgY2FuIGhhdmUNCj4gdGhlaXIgYWNjZXNzZXMgYm91bmRz
LWNoZWNrZWQgYXQgcnVuLXRpbWUgY2hlY2tpbmcgdmlhIENPTkZJR19VQlNBTl9CT1VORFMNCj4g
KGZvciBhcnJheSBpbmRleGluZykgYW5kIENPTkZJR19GT1JUSUZZX1NPVVJDRSAoZm9yIHN0cmNw
eS9tZW1jcHktZmFtaWx5DQo+IGZ1bmN0aW9ucykuDQo+IA0KPiBBcyBmb3VuZCB3aXRoIENvY2Np
bmVsbGVbMV0sIGFkZCBfX2NvdW50ZWRfYnkgZm9yIHN0cnVjdCBjeGxfY3hpbXNfZGF0YS4NCj4g
QWRkaXRpb25hbGx5LCBzaW5jZSB0aGUgZWxlbWVudCBjb3VudCBtZW1iZXIgbXVzdCBiZSBzZXQg
YmVmb3JlIGFjY2Vzc2luZw0KPiB0aGUgYW5ub3RhdGVkIGZsZXhpYmxlIGFycmF5IG1lbWJlciwg
bW92ZSBpdHMgaW5pdGlhbGl6YXRpb24gZWFybGllci4NCj4gDQo+IFsxXSBodHRwczovL2dpdGh1
Yi5jb20va2Vlcy9rZXJuZWwtdG9vbHMvYmxvYi90cnVuay9jb2NjaW5lbGxlL2V4YW1wbGVzL2Nv
dW50ZWRfYnkuY29jY2kNCj4gDQo+IENjOiBEYXZpZGxvaHIgQnVlc28gPGRhdmVAc3Rnb2xhYnMu
bmV0Pg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
Pg0KPiBDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IENjOiBBbGlzb24g
U2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gQ2M6IFZpc2hhbCBWZXJt
YSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlA
aW50ZWwuY29tPg0KPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEtlZXMg
Q29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2N4bC9hY3Bp
LmMgfCA0ICsrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRl
bC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2N4bC9hY3BpLmMgYi9kcml2ZXJz
L2N4bC9hY3BpLmMNCj4gaW5kZXggZDFjNTU5ODc5ZGNjLi40MGQwNTU1NjBlNTIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvY3hsL2FjcGkuYw0KPiArKysgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4g
QEAgLTE0LDcgKzE0LDcgQEANCj4gwqANCj4gwqBzdHJ1Y3QgY3hsX2N4aW1zX2RhdGEgew0KPiDC
oMKgwqDCoMKgwqDCoMKgaW50IG5yX21hcHM7DQo+IC3CoMKgwqDCoMKgwqDCoHU2NCB4b3JtYXBz
W107DQo+ICvCoMKgwqDCoMKgwqDCoHU2NCB4b3JtYXBzW10gX19jb3VudGVkX2J5KG5yX21hcHMp
Ow0KPiDCoH07DQo+IMKgDQo+IMKgLyoNCj4gQEAgLTExMiw5ICsxMTIsOSBAQCBzdGF0aWMgaW50
IGN4bF9wYXJzZV9jeGltcyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhlYWRlciwgdm9p
ZCAqYXJnLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEdGUF9LRVJORUwpOw0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFjeGltc2Qp
DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07DQo+ICvC
oMKgwqDCoMKgwqDCoGN4aW1zZC0+bnJfbWFwcyA9IG5yX21hcHM7DQo+IMKgwqDCoMKgwqDCoMKg
wqBtZW1jcHkoY3hpbXNkLT54b3JtYXBzLCBjeGltcy0+eG9ybWFwX2xpc3QsDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbnJfbWFwcyAqIHNpemVvZigqY3hpbXNkLT54b3JtYXBzKSk7
DQo+IC3CoMKgwqDCoMKgwqDCoGN4aW1zZC0+bnJfbWFwcyA9IG5yX21hcHM7DQo+IMKgwqDCoMKg
wqDCoMKgwqBjeGxyZC0+cGxhdGZvcm1fZGF0YSA9IGN4aW1zZDsNCj4gwqANCj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOw0KDQo=
