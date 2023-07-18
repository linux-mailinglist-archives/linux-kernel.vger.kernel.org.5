Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870097583F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjGRR6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGRR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:58:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC441BCB;
        Tue, 18 Jul 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689703099; x=1721239099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2q7vzJwu+FSwjMLMbJghacyoeuTR2EXGxTkbUyIsrxw=;
  b=J6vOq5cwbrrngRnA9Hfq+d6V40OOI89+ZKOv/wIFi680radxfgOaLhsy
   zqAS/Y+QIbUa4oy6DBkzfTTVSZM7n2xjYqxSC11p4mHzG02IM5pWqUPUd
   WrWcBYvkE4gWPO748YROF5XrpP4N+mDf9jj6azY9X3XCqDvXWM0bxg+lv
   HlZeNmCpoovrYxsxWK1LtFrY6QkScAVecWGcXCBZTY6uUrBi5AV0/qZGD
   MXSvZUF9pSK1UppX000/+kGenteeJcoU9EJPvRTt1WiN/ttG5L0rNTRuN
   dVIeBsMnhEQr81uNXfOm6aywN6tNX1uXLG3w+GLhxsST9XOGsDQ/1rSoa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="366316841"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="366316841"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 10:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054395518"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="1054395518"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2023 10:58:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:58:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 10:58:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 10:58:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 10:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLIRBhbcOFt+yfaKSe+ce0NIVnXTtpk9aTY5QtZ/iwawjVF55juJ8JqJA2MiR/vx2aS56YVIwc9J0Mqybq6IhBlk33Y+XWXIkGeQyj9UzZVqX84fJuoGcbcJ2tUWbyOIgOvXSYKH0FPHcaWnPq0MrbCwCpVDF5EKml7cJcRXpOJES5DDBAa4BLe6qDkkFJHp6qeXEUe6orCl7k2wkwpvFNMgqBA85VxtLaocS0TAdCwQOhXnh8XQYbl9zFhLL2Ng7F8ChBAniQtFTroOGUMM5rh/8d979AGyssO4fAEQaRvanhQIGxN6pv2lGGTsnhkEGARfyPJR6WvAhg1VAHYR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q7vzJwu+FSwjMLMbJghacyoeuTR2EXGxTkbUyIsrxw=;
 b=RPghPH3Awrf9b9ab/x0/dL9SShrOtNcYLc1W4KUCeTswuRprWCZKLUhge/it9I80Go/hIAUWMSSnVEtu/RjPgNZ1kTALy85/sC79y/IfORrxe/k+Vxzqq2lLSyW6SKiU7yf4P/I1aeBHr5RMqAFHDMd/yIHMXAfxRFN3UZcLk5Wq+ZDAZOMGmUOH8r1076d0Oaf4QSYrCRDb4t1oTV1w6eCR9l+T7HPabTYIVCzY51C56kx0+fffJLTwNfJLUycEFB67Mjp3blcIOUcuYmiKoQ2IWNMptDkmlJIdW/Oq7WKvFoolAIcWfglRYra1Fgrosx0tFkSBuCU2q7a1ZBMcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH3PR11MB8140.namprd11.prod.outlook.com (2603:10b6:610:15b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 17:58:13 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:58:13 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "leitao@debian.org" <leitao@debian.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
CC:     "Leitao, Breno" <leit@meta.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: Re: [PATCH] cxl/acpi: Use printk specifier for resource
Thread-Topic: [PATCH] cxl/acpi: Use printk specifier for resource
Thread-Index: AQHZuJlsmJCm01u8kkWFP1cdRItZT6+/0aMA
Date:   Tue, 18 Jul 2023 17:58:13 +0000
Message-ID: <1c9eac5518438e99f7e152e4ea1a3fe1c5b29dd8.camel@intel.com>
References: <20230717102625.4083462-1-leitao@debian.org>
In-Reply-To: <20230717102625.4083462-1-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH3PR11MB8140:EE_
x-ms-office365-filtering-correlation-id: adf44718-70d3-4faa-72bc-08db87b88e6d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izUAnEtapzxcQPhr2bZrScykBY0hTbKfXLZ5Sn8t7t1uJgyji/hH5O0/dhMAAUrXtG0D/74gO+uuGi+LoaJzzmmzvnVU9GpBkqXBMNP115EZ9kmjrfw+fo9Zr+gMTYfxATw96U1azkj202M0r0QgJR7SrPuaR4em5bZF1tSndH2NTZKbwpYqpHsMP5XqVBxHWlGnuCllG8Vd6XZvZRUtzS2snd580bhZSGbIRePkhX33pcoDjis7hIlFC643EQtr1T6tVxB8NMeAD2Ol17UZIfenm2vwLIyYzNEGSPChOxPpRoRU4ix0y0rMSR8WOTOKJes1tna4yMG/Qjvrj6Y3P8dZTokgoK2OV4SIGcMJgB+aIXL8x7EJ3l8S7LFRJqwtE6Z9XV+etFKLAOmnqRupmQTEiZESUNjHZWbcWi4+eL5ArbrxdmJH8Opgo2h9tG00LpDKAcj4uuE5Ni2mts7oHE7i46PSi7dYSq5MUIGGbhDO7F3u+Mj7B/Huajt06yWIzlBIfoSKj0iR7AXvbNJpkBpElRl/2Ck7obLzqf2GII5qzDGQVZBQNLPAT2njTpWU/0IJqD6uZ1UoANe2R265VOPC1xSnHqSJs+X7yKO7zcWWOWVMXkDbqeNZtiIkb1oB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(41300700001)(8676002)(5660300002)(8936002)(66476007)(4326008)(66556008)(66946007)(76116006)(6636002)(66446008)(64756008)(107886003)(110136005)(54906003)(478600001)(2906002)(316002)(71200400001)(966005)(6486002)(6512007)(921005)(82960400001)(122000001)(6506007)(26005)(186003)(36756003)(83380400001)(2616005)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjJlSUFvY09iTUZwSllOcHo2aTBwOWtwd0ZmS21KNTM4c0JuZlBMV1had1Q1?=
 =?utf-8?B?YjFPOVgwOFlUcEd1M1VLTXJTRkJjaExRZ05RdDFQanlVZ0cwbEtydWQydWcw?=
 =?utf-8?B?N2lLSTdSalJ4MmF5VnRzYVRyZVdGM2tROFlGRjZ1ODFocnczMWcxSGcrSHJT?=
 =?utf-8?B?eWgxWVdVcmZPaWJQQ0UxM2oxMnErY2x5YTVVR3VZNm5JQzI3dXdLdytKN21t?=
 =?utf-8?B?MWx0OWt0KzdGRGdsZEZXMkJKOGRMOTNYVGp2NFFyN2wra1crVHF2UEE1d2Vo?=
 =?utf-8?B?RitUd1lpU0tHaE5CTlQzcmFpR2Rvb1EzcjhZVUtoZEVWVFJaWGM3bDVQRGZr?=
 =?utf-8?B?cVlXT2x3eVJUV3BwbTZrY1p5SlIvZyt2c0pmcndsNTVqZWtHazF4ZllGazdI?=
 =?utf-8?B?OGMvZ3VmWStHUUJPZitLTUNESmg5aVp6dFprcTNmNXlwUFdWaHJWYWdWdjRq?=
 =?utf-8?B?SFNyb09yK2JjQUZkRys0b0d4V2pnNVVQN0lvaE9Ha0FPb3QxZG0rZDFGbFVi?=
 =?utf-8?B?bFloMzZTS2VNSllENTY0NGNzV0tPRGtNci9zSTdFUmViRm5hbUJGS3F5Ukxp?=
 =?utf-8?B?dzRNUUFzWkZrSEE4azl5UGZjaGZUZ2cvREptdWxxR25kVjQrRkdSZG9rL0VF?=
 =?utf-8?B?MWhiRnE0Y2J0bXVYNHBaMzNvcXBMR0lYVmV4QURlZGFVMUtkeVM0NGxSd1hQ?=
 =?utf-8?B?TnhaWTdyd3NwakNlSkJCMlNiRXQ2ZG9CTXlLVmt5T2tsZHhMbldNNEZuZzV4?=
 =?utf-8?B?ZElvZnM4NDg4clp0TXdHMldqTXhuellXZHF0NXc3RyttM0g1UExYdHcwZi92?=
 =?utf-8?B?K3FSL3FpVHJ5Wkdrb25jZU9aL2VMbFhqTyttY09WSjJzL1RMSk5oS1ArbXVG?=
 =?utf-8?B?TU9lSVpuRzNGSG9razY4QmtPOFZ2dzMwdFpKdWRubktZNjRBTFNJMklKcm9Z?=
 =?utf-8?B?SE1Wb3pQdVIwcnc0ZjgzcFBENERJcDNPRGZMRGZqc3ZPeU9BQnFJSSt2ZndN?=
 =?utf-8?B?eHdUTzNydmpkSWpwUzkzZEN5bWVUWUNycDRwdjBlTEtuZWdqTU9scjgyUkNQ?=
 =?utf-8?B?S1ladFVIWnJZYVN2OTZjK0ljVlpLU29PSVlXaXRsbmxybUMvRnRLbkZPT2tv?=
 =?utf-8?B?KzNLMk9iVm5ZSGtFQUdSaG5aQUxsWHFSa3RidFNkMHhIbkV3SUpvRkxlNi91?=
 =?utf-8?B?M1BjK2ZhUzJRTitLV0J0aFdHdmhMTGNkbVhwVGJ5Rm1OV09kMnRQWmV5d2sw?=
 =?utf-8?B?UTdMY0hQV1owNS9hZGdRK1l4VG1BMFFVaDNFSkRIQlczT3RjVUV4WHYrTExs?=
 =?utf-8?B?bFdUL0haZ3JkaGFqWTZyZE5sTzB3bStnMElPRGJXeENySGFNOVhsVFZIWDRj?=
 =?utf-8?B?TlQ2QkZic0JMUWkzMTR0REdDQXFIZDQ5eUdsQXM1ckp6ZkNvRHRBS1BuQUdi?=
 =?utf-8?B?QkNzMHh5M0pjd3VzMy9FSk91aUZUanppbSs4WG5qWUZORlhpbno0VDN6eW51?=
 =?utf-8?B?QkY0Y0xTRnFoN2ZtWXRLdE1saGdSeDFYd1hwTkpvcmtXVFFibGVuSGNZT3ps?=
 =?utf-8?B?VGpQaHE3bXRNTHl5eHF3Vk1tWTZoVEJBbGVKOENnbFQzMWpQZkdUbDAxNnU4?=
 =?utf-8?B?QXlCdWtWTk1HbXdlWFNlNnk4bTZvck5aS2psUFBWZWl1V0F2bUpXZC9SaWdt?=
 =?utf-8?B?WmoyWUlCYWJzS1B1QmxvckR1TUFqVjJSWkRCWGc3VWNtRXl5UHJmcGNQVHlv?=
 =?utf-8?B?VldhdG1NVFd1Y0M1T0tXSEFVRksycjFnTi9vTml1ek4xdFl4K1ZDTy9JV0Y2?=
 =?utf-8?B?dGtReUxIa2U5ZC9lVG1pcUtrVHhkaXRJbCtLVmNDMlQ1ZTBKSEh3Ujl1NklN?=
 =?utf-8?B?RmhrekErYUk5eXJrWXdlaUZoa2hsWU94L2huZlNnRDNoTXNReitwZjQ5NjZU?=
 =?utf-8?B?ZHJFekFjMmRnQ3l5ZFU3NFprQlJ3amxHcGtYakc2cVJYL00wK0VHTFI1YUQr?=
 =?utf-8?B?VmUyd05OcUREdzk3Wlh4SFJjdHpZeGFTbTA1NDBrMy9uWStsdU1sRUpvSWha?=
 =?utf-8?B?a3NHY2VsRWJCUUtiTlpNMjE5TEtualRwMG1ucXUxaWZhS1BzcjI3Skk4dlpy?=
 =?utf-8?B?Vkc1eFI0aUU4aE16YXFEVjR1dGEwNEdLYUl6cHhVT0dLL0NrYjBwUTBubTN0?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1130A47EF0CD1544A470CFCD6413EBD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf44718-70d3-4faa-72bc-08db87b88e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:58:13.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NsRc6emI9iwYXCIf0I9pwgiIRLD9h1srZKL3FW1iTo7YtEFqXUPLVwiZOPa14DCUnKp3ckJ308Q8o+KS0J/tBX5n19uaZkVC60ZuNaPnb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8140
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

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDAzOjI2IC0wNzAwLCBCcmVubyBMZWl0YW8gd3JvdGU6DQo+
IENvbW1pdCAzODQwZTEwZThkY2EgKCJjeGwvYWNwaTogRml4IGEgdXNlLWFmdGVyLWZyZWUgaW4g
Y3hsX3BhcnNlX2NmbXdzKCkiKQ0KPiBpcyB1c2luZyAlbGx4IHRvIHByaW50IHJlc291cmNlcyBw
b2ludGVycywgYnV0IGl0IGlzIGluY29ycmVjdCBvbiAzMi1iaXRzDQo+IHN5c3RlbSwgY2F1c2lu
ZyB0aGUgZm9sbG93aW5nIGNvbXBpbGF0aW9uIHdhcm5pbmcgb24gaTM4NjoNCj4gDQo+IMKgwqDC
oMKgwqDCoMKgwqAgZHJpdmVycy9jeGwvYWNwaS5jOjMwMDo0OiB3YXJuaW5nOiBmb3JtYXQgc3Bl
Y2lmaWVzIHR5cGUgJ3Vuc2lnbmVkIGxvbmcgbG9uZycgYnV0IHRoZSBhcmd1bWVudCBoYXMgdHlw
ZSAncmVzb3VyY2Vfc2l6ZV90JyAoYWthICd1bnNpZ25lZCBpbnQnKSBbLVdmb3JtYXRdDQo+IA0K
PiBJbnN0ZWFkIG9mIHVzaW5nIHBvaW50ZXJzIHRvIHRoZSByZXNvdXJjZSwgdXNlcyB0aGUgcHJv
cGVyIHByaW50aw0KPiBzcGVjaWZpZXIgdGhhdCBrbm93cyBob3cgdG8gaGFuZGxlIHRoZSBzdHJ1
Y3QgInJlc291cmNlcyIuDQo+IA0KPiBUaGlzIGlzIHRoZSBuZXcgZm9ybWF0LCBiZWluZyBwcmlu
dGVkIG5vdzoNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqBGYWlsZWQgdG8gYWRkIGRlY29kZSByYW5n
ZTogW21lbSAweDQwODAwMDAwMDAtMHgyYmFmZmZmZmZmZiBmbGFncyAweDIwMF0NCj4gDQo+IFJl
cG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxsLzIwMjMwNzE1MTA1OS4ydnZCdDU1
SC1sa3BAaW50ZWwuY29tLw0KPiBGaXhlczogMzg0MGUxMGU4ZGNhICgiY3hsL2FjcGk6IEZpeCBh
IHVzZS1hZnRlci1mcmVlIGluIGN4bF9wYXJzZV9jZm13cygpIikNCj4gU3VnZ2VzdGVkLWJ5OiBE
YW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
QnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4NCj4gLS0tDQo+IMKgZHJpdmVycy9jeGwv
YWNwaS5jIHwgMyArLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVs
ZXRpb25zKC0pDQoNCkkgc3F1YXNoZWQgdGhpcyBpbiB3aXRoIHRoZSBvcmlnaW5hbCB1c2UtYWZ0
ZXItZnJlZSBwYXRjaC4gU2luY2UgdGhpcw0KZml4ZXMgYSBjb21waWxlIHdhcm5pbmcgd2l0aCB0
aGUgb3JpZ2luYWwgcGF0Y2gsIHNxdWFzaGluZyBpcw0KYXBwcm9wcmlhdGUgZXZlbiBpZiBpdCBy
ZXN1bHRzIGluIHJlYmFzaW5nIHRoZSBmaXhlcyBicmFuY2guDQoNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2N4bC9hY3BpLmMgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gaW5kZXggODE1YjQz
ODU5YzE2Li5kMWM1NTk4NzlkY2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2FjcGkuYw0K
PiArKysgYi9kcml2ZXJzL2N4bC9hY3BpLmMNCj4gQEAgLTI5Niw4ICsyOTYsNyBAQCBzdGF0aWMg
aW50IGN4bF9wYXJzZV9jZm13cyh1bmlvbiBhY3BpX3N1YnRhYmxlX2hlYWRlcnMgKmhlYWRlciwg
dm9pZCAqYXJnLA0KPiDCoMKgwqDCoMKgwqDCoMKgZWxzZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJjID0gY3hsX2RlY29kZXJfYXV0b3JlbW92ZShkZXYsIGN4bGQpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJjKSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBhZGQgZGVjb2RlIHJhbmdlIFslI2xseCAtICUjbGx4
XVxuIiwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXMtPnN0YXJ0LCByZXMtPmVuZCk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
ZXZfZXJyKGRldiwgIkZhaWxlZCB0byBhZGQgZGVjb2RlIHJhbmdlOiAlcHIiLCByZXMpOw0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsNCj4gwqDCoMKgwqDCoMKg
wqDCoH0NCj4gwqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoZGV2LCAiYWRkOiAlcyBub2RlOiAlZCBy
YW5nZSBbJSNsbHggLSAlI2xseF1cbiIsDQoNCg==
