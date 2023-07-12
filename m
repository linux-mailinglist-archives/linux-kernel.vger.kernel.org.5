Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB057751146
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGLTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGLTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:34:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72E1BDC;
        Wed, 12 Jul 2023 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689190486; x=1720726486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qUwmpDDGn3FTVc1ISMSn6BuXQo3ugmGCn9tRCp2CZBI=;
  b=SQyXv1vyPAeFsvYtD7LFsydMUIkZevcfpiYwZ6lPLJQRZcVx9bMCpwcG
   6TVQ5oJOnYgN8uANxoH/cZ+LKkyUMx+kzMfjweaa1Xk2Tx4R1gJskzD36
   dyVplaCn6UgrZenrN1al4felQRrb1GpYtcdTYZP/SGwgepFKwWoAC+/wc
   5rG3bcP7hHGgbxTkb4oqJaPLmIA3sQZy9GNkKLfoAo6jAPpzT3KwPLqDf
   /UP0RtL0ux/JBY/MRJanmB2ne5uUCFmBWdVVHknIWWaSankc+BtjubD4E
   /IjQcWTV4zqrqEp1TaKd6hLCWraQBI1J5/aiPsK0Smv7Do6pSl/qiBQng
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349840029"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="349840029"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="835286158"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="835286158"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2023 12:34:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:34:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:34:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhBhJl6mhLAbDg5kaInh4SFkK6iDLrgO6fGBolTRj5VK/KQ3B7qxBHqLcFojQoezehLYz5J1wUvSFD+WHWViHD3ALOoYE8mgHPyZOTjzseoxA8uC2w9Kt8I4LnNKkCSWY0zm47vqHxOTGwZjxeqsX1fc/X//TLDq/0XGyFvwai2EmmHbFx3Jkwun2LMQqyuG0yAeADjKayVxfKPGexB8jKeiv2dmSQllG5PKobItWusRyemMNytl44AvnoHBl+h5j7UXSC0iSMcJiC4xCcGonWwBZTAE8Yfdsm10P+x07VEef/Cy4FPnyzhUUhtLprXAgS3ll/Un226/PhEQKLaVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUwmpDDGn3FTVc1ISMSn6BuXQo3ugmGCn9tRCp2CZBI=;
 b=lT5ykSHLjTucN4d1WcxesduTLmdWQTjZ2216wf/hL8UyYPppqsKjWN+nzRmfiHqPlV58UjdQPf+gVNhBLmJ+YOIfVxPM+7DXOl+e9kH6wZfoA5whtyhGD0OOq06reR3baNwYJ0E0HNgaS6WIUfa/RJwRE0fPyELSkEpwkxsV+xIynHZKbxPFWUibd1Mg6raPI3B9Fpcg5uztBHZoBRi28UzSyutoJb1ssAJatVi0Q+q7Jji0cFgAY9z9JIpc5LcBuh7WvTj5xRO0V3KiT3+4fF718TVHiEDGi2ZTSWvSjEeGHs6vJda/oZOgUqmF1z5WXl8xy7nutGax6CurVc3QuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 19:34:27 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 19:34:27 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>
Subject: Re: [PATCH] cxl/mem: Fix a double shift bug
Thread-Topic: [PATCH] cxl/mem: Fix a double shift bug
Thread-Index: AQHZrbktwAtlDbgSGUK+79s1fr4Kd6+2lEkA
Date:   Wed, 12 Jul 2023 19:34:27 +0000
Message-ID: <4c5b0534bc57045f4a5e63c2a3e4db8eda4f42ff.camel@intel.com>
References: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
In-Reply-To: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CY8PR11MB7825:EE_
x-ms-office365-filtering-correlation-id: 3413b260-eea7-42d1-99e4-08db830f0165
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcyBFaGKhAKhAkeHPqXMdqwehBuvqpJj+vg2getgdVXKp5t80Jqc8rIMH3kW9ceNS99TIUY9ebii98HMB5Zs6U1cLk5Et1aYRFqsMxOBF5IS0ITei7K6+0/7ARLWnkEB8Y5PQ6g5FCOGPRvaAK1N4fuExbIu8QLPiJTPhnnXdflBM46oEk87rQcI80NyvySzT+o2Opibj5MBDQTmoS/+v1WAqVie9etqvs6vd/kZBb5CzknfeOiViHjleSOxqPoSIRU2tUxl8fgkbnzD/A2ddKaB64U40kSDggFCIMHd+O66opawr4Cqs3h7KHEkX1IR8lJRKh3xLHl6RrFUymWrnEdFrGl9i94GE2I2kF1qgUqoeKKXvNRqaC+CaaqHsXGnKY/ZFhY2VMtKfY9vCkV0yrwLwfg86TJvbdyG5eId6qaaRqQkvww2Xx67UZEmO+3eotAWTvd8tYIHbh+GtUS1EX4Fq1SKhS3aWZcdOjF01rlFXPZD83iZVkZp57tfhtrFQAd0fBq1dnq5sZm3bHboZAY3OsqSnQY0oBZeb0bAX6cSn0eEL7YypNiG1F6ZVGVxUqo4mCKiAONzAJBP1La08gjU03cab7FwWR3KFmX/N/Q25hn8J0twSRLVOhcGYvLy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199021)(8936002)(8676002)(186003)(5660300002)(2616005)(83380400001)(26005)(6506007)(86362001)(41300700001)(6486002)(71200400001)(316002)(6512007)(66556008)(66476007)(66446008)(64756008)(36756003)(2906002)(6916009)(66946007)(82960400001)(4326008)(54906003)(4744005)(122000001)(478600001)(76116006)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnFHUytwZHpuWktqK1VsOXhlMkNMQ0EyZFFlVUFaQjdYbllic2VTZktQcmg1?=
 =?utf-8?B?dFBBV21WancyR2ZVOXZ4YWgybU4rZmJ2anBVM0dqNFgwOTQrMVpLaU9BZGNP?=
 =?utf-8?B?UjBTUm9JUjRHTDZSdDNhYytxckswNXRWK2J2akJOT2NQdGlkaDVGTlR5YWg1?=
 =?utf-8?B?Nm1rcjEvKzN0QVRBZVBjeFpnNjlOZDBNMnBQV3hpQWVReDVvWUJYaW15aEFy?=
 =?utf-8?B?S0l4WGMvREkrczVBY0lZc2FVU3k5Qmk0dUxFMkFFT3lOUllaVFh0dUpITVVW?=
 =?utf-8?B?M1dhM2hXOGMxUmZ0U1ZHUFFlTCtlUTFPZmFDZHMwN3J4NlJHdVZUSm53bSto?=
 =?utf-8?B?b3haSHVDR251TjlGTXBZUTErSEozYU4ydzhjRHRTUHR0eDFCODdMaC80SFc3?=
 =?utf-8?B?aFJNSGI4NkVlUDhxTWtYaTNWMjEwckdYZHovWWVUb3RMZlN1OFJWNmxJaEJ4?=
 =?utf-8?B?SzdvbFdQaG9rSXZpVytqR1ZXbGNUUzNoWXFnZStaaHU3ZFJxSnZyOWVRVVZj?=
 =?utf-8?B?eThacWNUYW9IN0hSSEVVZlNoOXFjNnNpOVFKQmNncHBWRWx5RWRCbmI4bGxT?=
 =?utf-8?B?RUFNanpFZWZQazAyQ1FPbVdQWnVyaFQzNmtqVDhUV3FNYXBLNWdwakpQeUt3?=
 =?utf-8?B?M3Q0aCtMMng4UHBBQ2hxd3pSSFFHN0RlSFl0RytkYzJtOEhmL0MrcklUaGRF?=
 =?utf-8?B?dnBNajNmMGRVdFZjNzEyZi9ydnA1RzZEMW9wbTc3L0wybEI4SjUzWk92N3h1?=
 =?utf-8?B?bTZqYzBzSmdHT1M1OG5FcHY4RldJWFA4U0tHZjd5VEhPRThja0xsUjJ3R2Fm?=
 =?utf-8?B?QmxZN1BoRWNoN3pETUtOVHA4ZTg3STNjMTc2M2xaRW1pQXJ3dkxMZmYzTFVh?=
 =?utf-8?B?WXhHZ1pWUEV4alFVL1pqdm44UU9kTnZqMmZMSGtFVGpTSi9DZ1R4L2VFcUxy?=
 =?utf-8?B?b0xDa29McndHMjJKc2syM1AweXBXRTh5Y0plL29yYmZvSkRNZkYwN2dJcExM?=
 =?utf-8?B?dVp5TXFQdVQ4VncvRk1ZNUJnN1NUYW1PeEpXeXN4ajdscTZNa3R1MmI0VlVY?=
 =?utf-8?B?WklKK0lsblZuM2dCaEVxQ0JWcDdTY3NoVEtyRk5weWgxbVZOWGxscjkzekg0?=
 =?utf-8?B?Y2FmWVh2ckEzbHdwK3I0dGVITnBka0RpcXhaZzlhOG1XTmJlVE5IYk9aTysy?=
 =?utf-8?B?d3hINWIrSDFORVJRdlFNN3lSK1VQZGpjTzRaVk0xQ0I0b2lnemFDRnpZcFNz?=
 =?utf-8?B?Wk04MkQ2SWdKaVV6bGtOb2FhQWdOZTJJS1VjaHZwOWY5Tm1WSzV0endwVnY1?=
 =?utf-8?B?WTRYNUx6cWw3UzZoOGxLTjB5TkxBcmFvSUwwbXJUUE8rMEVJTmV5TWxMR0pv?=
 =?utf-8?B?RVlvTGR5RUFrMVZJbUoydmp1VUZ0S0I3K1ltQ1ROWDltMElQWFdmc0NzN0Ev?=
 =?utf-8?B?QVlXTGpPdFg4NkZDSitIb0J0MHRvMVJBNnlDUGNKZVlLNldicEhLRlFIbmJN?=
 =?utf-8?B?NVdSR0M5bnlCUU01bE05Y05VQW82V0loOXV1alVZSEZpSmlCSmt6aDM2YUVo?=
 =?utf-8?B?b3hTUkdvemJjSkNhM2poWWhXQVhMY3EzUlBJak5mV3R6WUZXTFlmdStoUGhX?=
 =?utf-8?B?dTFKUUNxRU9GZi9lOTl3dE92dm1zZmp4dXFqVU5WeFJ3QWNzT0JocjdFOWRJ?=
 =?utf-8?B?cjZ5dFhPZHBiY1hxY1I5Ylg4UU5lTW1vRHpPYVhmVk1TQ3JQMGJNNU9VeFZv?=
 =?utf-8?B?WXNkMllLanNoVnFGL2hLSXM1aU1vZWZWSWxHVk5LL0xkL1FJRzVIT3o1V3ZD?=
 =?utf-8?B?bzVBVzBTWXkxdEpUQ3hNTi9lU3YyK1JGRGF5WTJYbDBPQ2dzZVAyM0F3REN0?=
 =?utf-8?B?WVJmVmM3ZXZBYVVxTlVSYnhvdW0vRG5pUGtwRzRBby9FVDFnUndxRHdkcDFy?=
 =?utf-8?B?cDRuTUFDSkFRWHo2YkVoS0RLY00vYjhhT08zWDljVm4rNHNRR1ZkZFgxSnFp?=
 =?utf-8?B?Z2k5Q2R6ajZLbUluV1hNYUtVU0hCY0NsWlZ0NitZOVJFVWN3cklNd3dyUU1F?=
 =?utf-8?B?ckQ1YU0yVENQV0xwYTdoampDUUQ5ZW55dWw2aHA5cFllenFCMnN3ZHpFOHBl?=
 =?utf-8?B?dUIyeUx3eVFTcnhsNlNZejRqZm1KL1Z0NnlqaHFBcCt5ZitKdGlRSmNJU2VU?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A1424A4160331428F4BF17E9B4CD3B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3413b260-eea7-42d1-99e4-08db830f0165
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 19:34:27.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOyEu5lZdDTA3d4kCuQEFU+gxgVtvbVqipMuZ4xAgCaHjADXQpvL4ndLgULVOmASj+6DzItkKvabGHRk/FXKwlmgNEgIvnKqkTZdgrIl8qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTAzIGF0IDE3OjE3ICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBUaGUgQ1hMX0ZXX0NBTkNFTCBtYWNybyBpcyB1c2VkIHdpdGggc2V0L3Rlc3RfYml0KCkgc28g
aXQgc2hvdWxkIGJlIGENCj4gYml0IG51bWJlciBhbmQgbm90IHRoZSBzaGlmdGVkIHZhbHVlLsKg
IFRoZSBvcmlnaW5hbCBjb2RlIGlzIHRoZQ0KPiBlcXVpdmFsZW50IG9mIHVzaW5nIEJJVChCSVQo
MCkpIHNvIGl0J3MgMHgyIGluc3RlYWQgb2YgMHgxLsKgIFRoaXMgaGFzDQo+IG5vIGVmZmVjdCBv
biBydW50aW1lIGJlY2F1c2UgaXQncyBkb25lIGNvbnNpc3RlbnRseSBhbmQgbm90aGluZyBlbHNl
DQo+IHdhcyB1c2luZyB0aGUgMHgyIGJpdC4NCj4gDQo+IEZpeGVzOiA5NTIxODc1YmJlMDAgKCJj
eGw6IGFkZCBhIGZpcm13YXJlIHVwZGF0ZSBtZWNoYW5pc20gdXNpbmcgdGhlIHN5c2ZzIGZpcm13
YXJlIGxvYWRlciIpDQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50
ZXJAbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVy
bWFAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvY3hsL2N4bG1lbS5oIHwgMiArLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oIGIvZHJpdmVycy9jeGwvY3hsbWVtLmgN
Cj4gaW5kZXggNzllOTljODczY2EyLi40OTkxMTMzMjg1ODYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvY3hsL2N4bG1lbS5oDQo+ICsrKyBiL2RyaXZlcnMvY3hsL2N4bG1lbS5oDQo+IEBAIC0zMjMs
NyArMzIzLDcgQEAgc3RydWN0IGN4bF9tYm94X2FjdGl2YXRlX2Z3IHsNCj4gwqANCj4gwqAvKiBG
VyBzdGF0ZSBiaXRzICovDQo+IMKgI2RlZmluZSBDWExfRldfU1RBVEVfQklUU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAzMg0KPiAtI2RlZmluZSBDWExfRldfQ0FOQ0VMwqDCoMKgwqDCoMKg
wqDCoMKgwqBCSVQoMCkNCj4gKyNkZWZpbmUgQ1hMX0ZXX0NBTkNFTMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoDANCj4gwqANCj4gwqAvKioNCj4gwqAgKiBzdHJ1Y3QgY3hsX2Z3
X3N0YXRlIC0gRmlybXdhcmUgdXBsb2FkIC8gYWN0aXZhdGlvbiBzdGF0ZQ0K
