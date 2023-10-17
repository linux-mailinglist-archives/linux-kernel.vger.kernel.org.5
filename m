Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B199C7CB76C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJQAba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:31:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0892;
        Mon, 16 Oct 2023 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697502688; x=1729038688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/dMWkc+Q7DFgBgzTlLddlyLKrhfvNtgHnl/BNEAQQcs=;
  b=exV9FF0+72tkDIu3G9d5SZ0b3q4ywtNLMZ5dQrk24ww5zZXNHVdZLE2e
   ILNjhbxZjj83Bb8R4dL/oKSR+FKtJopoz8NDgQwcAdYR9ZRw2XkrMNzoJ
   KCd+X0BnHE+w3EZYAcFYMDm34whBLj6WkvJ94AzPZmJQQu69SYwpHUYOc
   vMKA7GDC/TDDTOHmLAX3PhmRwCdvIZPiX5Rr62XEvR7L+cJBHSG6n2x4W
   k7Alf9o8+H6srYsOsMQ/zJE0aglAcZazY4hl5D0NYH5uElpySuuOAXvzP
   OliKxHmiyxknGkMkccI88tDvFxlAfJOcOoJ/6thWesjEne5v957W/5LoO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416743177"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="416743177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785287060"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="785287060"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 17:31:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 17:31:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 17:31:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 17:31:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 17:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjEdZPcfxa1o6MmeO2hYHztn5Xuhnlu7h1iTGTtkvU/6BqV6wdeKq2b0vwfK+xfRTakyN0cVYKGW9Gxqm4hdPIX5Q09Mwdouk9dqoaYZzYpfHGzvx85mWIjJqUmL+d/CyTprPZC0bNRzEkl6FM9fhT0dz6RrrMgAPvfTHGWnqNHXZN2/ndSTp2Qa5NRaj9rCTv04nm2C7Ais7ae03J+ebQvHGoIdZzzrDakw4Uc2wzQRtqXdFA3PHVyZxD6RuHzwzpJm5w4gkvgx5apXP1PYP/CUOGFT3oSJ0D4kmRcehsA/fc9BWxPpOYeq7xCndzDxMqrOIeg10WaJ2f9I8rGlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dMWkc+Q7DFgBgzTlLddlyLKrhfvNtgHnl/BNEAQQcs=;
 b=TJJvsB5p1ZdcfK/LYVfIhk+kRLOEuivLDwpohBHOWevccQhDWFRrUtCGpDv/dT8QBlypCCGHwP+PGpiFiKVogfPEXl1gmm6CD2NlYtIXoeYV/j7oktDCWi1iSNEdL3xWGR6/Vvdfeg5CIWKyu85ShhDhHqBD66iwqY7KLHdQ5vypJLpRPahq99kYpSa8ZqQgGwWSfD3XSJozTxz+1S+TjCELYAnv/ITCLXh2N9cEo+ZF7h7GPk4sZqJFTadnam7OeizqR3J3eHe0cKenbSYb1kayXetnrqgP4izktPvDdFiHk5697Z09CgBM1GaG6kLjZkkm8Usr82JPWMarEuegEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 00:31:04 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 00:31:04 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Topic: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Index: AQHZ97pFlzDFXvvBck2PX4DBerIrvrA7swCAgBF/9QA=
Date:   Tue, 17 Oct 2023 00:31:04 +0000
Message-ID: <923d65270ad08d47adae0d82ab4b508d01e9cc00.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
         <651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|MN2PR11MB4615:EE_
x-ms-office365-filtering-correlation-id: 0de8afa8-ac35-48f9-0f91-08dbcea858cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niS6Vt7ysAIVStxYEqqEt23x+FKQmtq4XPCJHzbBmqO2JUWi1oFkhEQt3j+2gJyNrIoaHh8q4WSwD/wfbU4vx4mNxnMzjjMUfDofKkztInqweCBjsVGxGoGGHn5cAarKpBZ6VRZ9Lvi6eB/R9Wr9D1tWMAgp8Cr+pRzT5a7rveuoIi3P1ET/EE83aea0j/81Y/0YQ2xt1M/qu1eyfrC0tEZP4iA233G2KH+E3sN8TbpIXyv0/LcEjtg8rh8Vxg+ZvAoKwk99l2l9h22Fq79EIjXuTljLLCLptdHy4gt5IXLgfa0ZMxYjsPqaKR0U5tDB8GbjqRPN55qlxbtWPtE6Oput0rmI6Gophvz4I2EAaXCmZrSEjvN+La31iJnqLxCAUFwmkzRlToNulQR+Dd3CisnOPh1kpP30qLKJ5fd4tHrWg2zyKWADDy8VlVO1wcMtfxk6+sHv3GeLWgvJL4Ayy91paq2OZGPgel5/z3e9O8y0dtmMDUgJ7RqUrV/X7ORjNxLgdqEWjWm9+pIALfgIHvLZqFX5SYPML3iNNSzr/xhXDBUTHmeWuG7ZtfLa2CtI/BZVJRLM9/0GMg5ykU3REaiGPz6K2hOc8AOoPTMdfphRQTaQcVLSWJ1IFT2gFAVM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(478600001)(6486002)(66476007)(110136005)(76116006)(66556008)(66946007)(66446008)(64756008)(54906003)(71200400001)(83380400001)(38100700002)(82960400001)(316002)(6512007)(86362001)(26005)(6506007)(2616005)(36756003)(41300700001)(5660300002)(38070700005)(122000001)(8936002)(8676002)(7416002)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU1JaXROM1BwYmVLYW40KzFVSVp5S2JqUk8vK29sSDVnL0ZVTTcxWEoyQ3Ji?=
 =?utf-8?B?Y1FYU0hzOEdvb0JFcTdYOVdkek9leFgra1JBMzdJb0pUZnFMaC9IMlBSSzEw?=
 =?utf-8?B?WG9rV2lRSzRwN1JqSTNQTGdMWDRFZmZEbGx1SUVqMkxlcEVtUFNjaC9nUk9N?=
 =?utf-8?B?cWE0bW14MFlPYTlpNlppL3pJWDFsci9YRUp3dlBnTndWeDdmbmxrMEt5dGhm?=
 =?utf-8?B?T2hqWDQ2Y1I4aEVYK0ltL1FFcmpNUFQ4akVseU1EMHkzd0Zpb3g2d2N2R2J6?=
 =?utf-8?B?Wm4xazdRUkErQkpNb2duYTRZZlF2R1Z1QkNvMjU5V3BGZTJCT3V5U0ZpKzFJ?=
 =?utf-8?B?OVJXYW9EaTJLNkpGQjdqemRSSjlnelVVUUg4UGptWWUwK01tbjcrU0cyOXBL?=
 =?utf-8?B?eWNsVFJXRTdJWUZtcXc2TUZVOXVtUU0xdENBVXV2OTFkOUpDbUNBUFVaN0dB?=
 =?utf-8?B?QWJjeWRXSXZMSEMvaGVRSWtFK2pjbWVUZXJrY3QweHpXV05ucWo5VGVlc2F3?=
 =?utf-8?B?L1FjZTB5V2lMYlc0Qjl2NElyRmhPUHN4VmhZUk5pZDdjb21kdlU5bk51NUpN?=
 =?utf-8?B?OHk4VGg4WllCMVNUMnlaRHhRL3Z3MXRMWUtDeWkyeVd3S2c2U3MzRjhKOS90?=
 =?utf-8?B?cFduMVZIYkZKKzlDd0xDSTNEVFo5NWpiY0xPaGRVeTE1djRSOFJWZ2oyQm43?=
 =?utf-8?B?bWZIbHZOUkVhcU9xUEttcFJXWVJxUHB0QmMyREYwampxWXV6ZFVQVy8rdndB?=
 =?utf-8?B?S0kxdERHb015RkZvVm5VVVl1MzlvZnlmdmVMSnZyelVlaUFHa1BteW5ra0RR?=
 =?utf-8?B?MHN2WjlYWEM5VU85clU4R1QzNkRaYkFJelFtYVBZcFlJNkJlTE9HVjRkdFpR?=
 =?utf-8?B?T3BWZVBZV0RMdThtWVFZalJZeERjOVBLMTBUbkVZWVZoTk10ZHJ3VlNqVWY0?=
 =?utf-8?B?Zm1ZTXJpVm0xQVZtL1g5ZkVQK1R1dGZnSGoxMDdqSjNHYW91VGdlQ096QTEz?=
 =?utf-8?B?QVllaGlhYXJBc1BXU3FzQkw4UytId1Rad3VmVUNYZDlieXhSNFBFZVJMQTQr?=
 =?utf-8?B?emROWGwyTkZwZkJWdlJvcE1CQ095czFEd2RSd1BkUkh3TVdQbHlhVnMwYXY5?=
 =?utf-8?B?WktzNWNYTWxqZkhFYkh3WFVXN0Vtdi9zNTlCTGtCNTVPV0Rtdy94cmFDWXo1?=
 =?utf-8?B?bDhvREhpR2dYZ3RpdzloZEw5K0RqVVdWWS8wVEdOZ1J5ei8wN3lObkpOV1N6?=
 =?utf-8?B?OXBVaFVuZHhLOVBGQkFSYjhiUmFEYzRkMktzUExReVRaRXQ4L0dFQktCU0Mz?=
 =?utf-8?B?aXYyYk1LVE95NmVtYnpaN3EzZU1sR1d5c29kazUwWFBPaXIzeFZNc21pNFVJ?=
 =?utf-8?B?RURUcmlFWlVDL0dJMkViTVFYZEduMDBpTmRXNkRvb2U3MHZBWldOWnh3MmNz?=
 =?utf-8?B?VDRGVktqM2xyU2pxL1JkdlNvZk1vTlJBQTlnRVo4dkkvT0FHYkJoSlRabWhz?=
 =?utf-8?B?ckw4ZVcwdGZnY0NZRUIyK3d6dk9jRDc4YmM3b3VqUSs0N2dobGViMTkwZVQw?=
 =?utf-8?B?QnZVUHh4MkhxRFRaYkNlNkFIM0RVV25CemlmdkNFV3RYSXB0dWN0RlpMMHlN?=
 =?utf-8?B?ZGMvZjZ0K01yYmNxOUhHeU04OTNwWE12RmUvQ3NzL0ZXVGgyaGFybTZQMW9V?=
 =?utf-8?B?bENkSng0NnNFSTlNVkt4UkVVaEJXbmtncWN3NUR0T0dUYlJkZ0NJaXh2K2pN?=
 =?utf-8?B?Y1Z0dzhrTzZzRjJGejByd3hzRWRRbnVMVVhEbUdvS3E1VlRkeUx1VDdxbW5T?=
 =?utf-8?B?WmpwejlYVjFsWFBaV0xMczE1dGVad1pHdjNldEVPLzk4Z2R5Nmk1MjdMVWh1?=
 =?utf-8?B?RkI4bzkzUlNyYUs4RHpSZEpTOEV6ZVl3RENzOXVmY1pGbkJ3QVA0Zm9nd0VR?=
 =?utf-8?B?ZFJZTzZRVktzREV5TnNYa2xkTEZ5L21SbExDZWtzUHRVLzJNalBVTEVBMzM0?=
 =?utf-8?B?bkVZMEp0UWFvdmFvVG9yMUplNjhVUVVPd2F6MmE3NDNSS0c2N2lkYUZ0ZXFD?=
 =?utf-8?B?elprYVFrNjIrREpmeERxbnpkbkJCelBTN3E3RW9PM1prdFBKMmFqVzBJdHZv?=
 =?utf-8?B?aytrbjNod1c2eGNYbnFsTldCT3Z4eHpndVNqTk1qWVRrUmNhOElYNngwRWFP?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABFF524657019B4EB088AE7B140A48EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de8afa8-ac35-48f9-0f91-08dbcea858cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 00:31:04.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHgmBY9G1gvTa5ZEia0RNCgR19uKR+SqmWwwFyXW4dEPcSHmtxonoThUEPRyFt4EMzS+Y3Czxe7JdVQfvAzTuXtvkJvNBg7azwL5G5zsAX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDE0OjE2IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiANCjwuLj4NCg0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqByYyA9IGtzdHJ0b2Jvb2woYnVmLCAmdmFsKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
cmMpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsNCj4gDQo+
IFBlcmhhcHM6DQo+IA0KPiBpZiAoZGV2X2RheC0+bWVtbWFwX29uX21lbW9yeSA9PSB2YWwpDQo+
IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbGVuOw0KPiANCj4gLi4uYW5kIHNraXAgdGhlIGNoZWNr
IGJlbG93IHdoZW4gaXQgaXMgZ29pbmcgdG8gYmUgYSBub3ANCj4gDQo+ID4gKw0KPiA+ICvCoMKg
wqDCoMKgwqDCoGRldmljZV9sb2NrKGRheF9yZWdpb24tPmRldik7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgaWYgKCFkYXhfcmVnaW9uLT5kZXYtPmRyaXZlcikgew0KPiANCj4gSXMgdGhlIHBvbGFyaXR5
IGJhY2t3YXJkcyBoZXJlPyBJLmUuIGlmIHRoZSBkZXZpY2UgaXMgYWxyZWFkeSBhdHRhY2hlZCB0
bw0KPiB0aGUga21lbSBkcml2ZXIgaXQgaXMgdG9vIGxhdGUgdG8gbW9kaWZ5IG1lbW1hcF9vbl9t
ZW1vcnkgcG9saWN5Lg0KDQpIbSB0aGlzIHNvdW5kZWQgbG9naWNhbCB1bnRpbCBJIHRyaWVkIGl0
LiBBZnRlciBhIHJlY29uZmlndXJlLWRldmljZSB0bw0KZGV2ZGF4IChpLmUuIGRldGFjaCBrbWVt
KSwgSSBnZXQgdGhlIC1FQlVTWSBpZiBJIGludmVydCB0aGlzIGNoZWNrLg0KDQo+IA0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZpY2VfdW5sb2NrKGRheF9yZWdpb24tPmRl
dik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5YSU87DQo+
IA0KPiBJIHdvdWxkIGV4cGVjdCAtRUJVU1kgc2luY2UgZGlzYWJsaW5nIHRoZSBkZXZpY2UgYWxs
b3dzIHRoZSBwcm9wZXJ0eSB0byBiZQ0KPiBzZXQgYW5kIC1FTlhJTyBpbXBsaWVzIGEgbW9yZSBw
ZXJtYW5lbnQgZXJyb3IuDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiArDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgZGV2X2RheC0+bWVtbWFwX29uX21lbW9yeSA9IHZhbDsNCj4gPiArDQo+ID4g
K8KgwqDCoMKgwqDCoMKgZGV2aWNlX3VubG9jayhkYXhfcmVnaW9uLT5kZXYpOw0KPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiBsZW47DQo+ID4gK30NCj4gPiArc3RhdGljIERFVklDRV9BVFRSX1JX
KG1lbW1hcF9vbl9tZW1vcnkpOw0KPiANCj4gVGhpcyBuZXcgYXR0cmlidXRlIG5lZWRzIGEgbmV3
IERvY3VtZW50YXRpb24vQUJJLyBlbnRyeS4uLiBpbiBmYWN0IGFsbCBvZg0KPiB0aGVzZSBhdHRy
aWJ1dGVzIG5lZWQgRG9jdW1lbnRhdGlvbi8gZW50cmllcy4gSSBjYW4gaGVscCB3aXRoIHRoYXQg
YmFzZQ0KPiBkb2N1bWVudCB0byBnZXQgdGhpbmdzIHN0YXJ0ZWQuDQo+IA0KPiBQZXJoYXBzIHNw
bGl0IHRoaXMgc3lzZnMgQUJJIGludG8gaXRzIG93biBwYXRjaCBhbmQsIGRlcGVuZGluZyBvbiBo
b3cgZmFzdA0KPiB3ZSBjYW4gcHVsbCB0aGUgRG9jdW1lbnRhdGlvbiB0b2dldGhlciwgc3RhcnQg
d2l0aCB0aGUNCj4gcmVnaW9uLWRyaXZlci1jb252ZXllZCBhcHByb2FjaCBpbiB0aGUgbWVhbnRp
bWUuDQoNClllcCBJJ2xsIHNwbGl0IHRoaXMgb3V0IGFuZCBJIGNhbiBkbyBhIHNlcGFyYXRlIHNl
cmllcyB0byBhZGQgdGhlIEFCSQ0KZG9jcyBmb3IgL3N5cy9idXMvZGF4LCBhbmQgaW5jbHVkZSB0
aGlzIG5ldyBBQkkgaW4gdGhhdCBhcyB3ZWxsLg0KDQpBZ3JlZWQgd2l0aCBhbGwgb3RoZXIgY29t
bWVudHMuDQo=
