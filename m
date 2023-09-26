Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438E67AF447
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjIZTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIZTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:43:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E710A;
        Tue, 26 Sep 2023 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695757386; x=1727293386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1JFNjsVlBVLMmUw1nAjHyIJz0/ntovM53X4tVAV1ChU=;
  b=Vm7J3iFQ9JDOy2IwHUI54kYTEt+v6klR8k2KEZqsOY6O+3dpJvKzSK15
   5ssaanM7Xo19RpIPyoMnpHzpsV1LeojLdSHutEqPIDcpDeoGyBBfsNbCd
   TXLUQgdbeTIl/R0UtV/tr7sROu7Trg5wZEQfoOl53b00FshySB9gf+S6U
   a0VkBjGPHvM+CDUJlyG+ZEr15BHrwuFbEhYla96M5fqPZO0MPQhGOB8En
   CIxLzs2tqZfjTNsmrmwKjGqJAmFrJPRQp+i3SoDe40Zmewja2KN54EIPt
   HBQF5Vf6Jm7ExDx5LRngyitfTFbzv+iXF0n6XtLtS64QkYR/6GQ+DOWfl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412570393"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="412570393"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819149119"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819149119"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 12:43:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 12:43:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 12:43:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 12:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKDsxuu4mwPTFZ+UrcKdkNcJWImxHD3ZJF7F0a6hSeTaPs3unux+jsdNvEbTbIOGp2FD0xCchhcaWVIPLaPew1WXzhwOVhDP/s5DG5D/f118vnM9CJTJhQ7k1Gd1cPHWDTncF0LUKMCyr8G3ffWDXQm7rrIEAzIGp5DP/ZyMVxHAcrGJ5g4M14znf8wrOgvP3zaxQdq2JSga0OgQ62RJ6EbJdIJbOeGDKmWMvH5mRsZ71JN/iRA693opYv68Hq2gDSlj5OTeuKl8RGG5uODcMc13mveyQ2R8k7FhH6CX5hZVuFFEsyyzIBM8ifCrVT4QAo0Ln4LfxbPviYcWjrz2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JFNjsVlBVLMmUw1nAjHyIJz0/ntovM53X4tVAV1ChU=;
 b=fSAF5ntABNoiO25taiZIAxLIhesoGvk6sCvbtLKqi879WQnQHNuBVP/3g7Vw1RH/Z+dYAJW9s9QzWbIzxJV8uctOSrU8rGR8Z09F/nqP3tg0mHQzlO1fDoPSMyvLpimoecmJlbYPkW98BkfOYQysUghUr2gcPqLc1GjfJHttwLvMJwCtfcKZhjXgtVCR8rCOrrK4TIYf6JJxOHNjZbP7/zr4yfVFS+3YiIKCPLBk5pKTVc5WcaAqsv64/py3GBeC2wiEoabzmH+PmsFRjInPNTLh/ncEfkBhsDfSL0HqxnsVdLYBeB1KhjE2abfh5e8oNo/hjycNIBLeZeO4hTq6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 19:43:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 19:43:00 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Topic: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Thread-Index: AQHZ2tLPm03/QLAOkkSe+DrgrX62prAtodMAgAABZ+CAAAW9gIAABEwA
Date:   Tue, 26 Sep 2023 19:43:00 +0000
Message-ID: <SJ1PR11MB608334D3FBD41B8635E1CBFAFCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
 <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
 <SJ1PR11MB60831009ACAC814C4F2A6072FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e2949d93-946f-51c5-dd08-64de4a272f3e@amd.com>
In-Reply-To: <e2949d93-946f-51c5-dd08-64de4a272f3e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5440:EE_
x-ms-office365-filtering-correlation-id: a6f3ad66-1050-4c08-eb4c-08dbbec8caab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+ufgUJfVX6w52OIuZ8dj/WIX8iPi10K69zrx5m4i2iAI/XM9rusQAsHvMHkPxJ/1KZkFLEgPFhA6XF50CHlugtD5GYSVcAAD8sMOSxvLFLPYIhMpBqBWCpNO4UJc+A0Z0QJbC5QRcnvPKVZjvg/w3yGiMJkMj0I5DqpzpprAmrKwW9vgh3FsTPBGweGiepxnDbcbstMshNZFbhDytgtfBPAujSJAGpCvWR2bj9/8UdRH4BgenYspm4/sFq4rCjVyGsXF4KQaTlW/Q+5RphkGPQ1kBvoV9CHM6pSQn8ZpGsT336boO9N67S4rpWBeKP6WXQDg2YAbhcW/Op867g3DIcWCmO9+iT88zj4gosENjb/Orq0cslDuETGKC4nGLbHwx3IpAawCZG2jm8kKDHvZW4rdDJjiqvxvjD9s27epezq0t6RAH+9uMQBP93zGWXqH44EdEjxwtGgONT4+GGAOj962hXEQBgwqMQjX+CFu7tDDY4dVQGZEtuYP7U659po65Hyn46vZ5uXIpskeE5a7LYQ6KlgZQtFmRnnxFB9wpSFm6zA4+RrzmncVO2AQtCYnaxJj7UCrFKsWvCfE/M9lBWkwDm9LQapntw5xcbomx47d0Sq83GWE0eDjnM/NJq+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(4744005)(2906002)(7416002)(5660300002)(8936002)(8676002)(4326008)(110136005)(52536014)(41300700001)(66946007)(76116006)(478600001)(71200400001)(9686003)(6506007)(7696005)(26005)(66476007)(66446008)(316002)(64756008)(54906003)(66556008)(122000001)(86362001)(82960400001)(38100700002)(38070700005)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdlLy9Yd0tsOThDVXREbDRpTitLbkczOEhvbmF5TklnMkh3aUlReERUTXpZ?=
 =?utf-8?B?UG5RWDBvYzdRR0JhNFp3bzFOOHJZL3lvOHJyTmUyOWpHSFlFU0hucWV1VCtC?=
 =?utf-8?B?Q2dNSVp4VWo0UCtpUG9HMWZrVVdqTDhoNkhHNk55RVVsUzQzSjA0UndjK3dh?=
 =?utf-8?B?anQzbVZlNXFsRDI4dnVrQk9QYzdPYlRZdmpBQTU3bWNmOXd5cWFGNHkwb1RD?=
 =?utf-8?B?OFlYUXNOME9UYWY3YmphQWt6SW9GZ3ZRU0ViM2swenRXMitUSGtDcFVvUC95?=
 =?utf-8?B?NzQ0aEMyZno1Q1owQzZ4bEVTMDY0azZTUk0wdVp0eXJKN1FFMFhpMHJiNGFk?=
 =?utf-8?B?Mk9TTGhPTEJVUTMrRkJUM3haNTZveGl6OXhxV2RUQnhDaHNmZDQwa1pTZnBF?=
 =?utf-8?B?RnQ0Um00L3BaMC8zRFEzb3prbDJ6blNyOHZ1YXF6MFlPekpHWkl1ZnBOVExz?=
 =?utf-8?B?QzdKZTI4RHQ4YXdSMmdBb0pPL1hiNU1sa2xMZXlnaDk1dXJIcGNnelVJUFNL?=
 =?utf-8?B?b1RiT1BwamYyMUdRcWkzNThSRndrYkc4WW9LaTl6NG5odHA0Qytid2dtN0U5?=
 =?utf-8?B?dUhuK1p3ODNCNXBySGRpb3haRzZFa2wrR1JILzViQVNtUWFobzZzVHpzUzVD?=
 =?utf-8?B?Nk1pZTI0RHNjRFRKMFRVSCtkVXRPTElJWkVxNGZVNjBOMEs1b2NrYmJCZWJo?=
 =?utf-8?B?U2owOGJjWkZ5YTJmNk9IdEJJY0VmODI3Y0FBeFVTNDVKZW11U1ZHam5PY01L?=
 =?utf-8?B?dDNuZ1BNUjVEVEtKQUNYSVJqbTVLTnJtdVUyTko3eWNad3ByamIyaUVsaDdi?=
 =?utf-8?B?TFRUUGFWRFNIVUI1WXR4S2MxemE0YkpnWjYwNWxJbktqQm8xVkl5Zm5FV2F2?=
 =?utf-8?B?NUZ3bzZxaVFNTE95SGtuVWRsdW1hdW14RWk1NGNLMlY5R2xiS2NjTU96Z2du?=
 =?utf-8?B?ZTQ4SkZ2Yi9wY3R4NUFLVnA1WW1wMVp5M0FoeXJWOUlSd1lGQlB1Z3dXTThL?=
 =?utf-8?B?L3ZUVkFXeDNhVUVBNE9HcmpaSHZyMHluMW0wbTMvcWhOcjN3c0xvc3I2MjdB?=
 =?utf-8?B?UnBzQ3VhVkc5RWd3c3p6OTN2NUVYZUNoNW1JU2grb1FoNDV0NEVXVkZ5Qndk?=
 =?utf-8?B?cDhpcExqVU9QWjVNNUtOQ05MNmE1SkkzSWdXcFk1L3dnYWZmTmI0YXlRVTk5?=
 =?utf-8?B?dUl6TFhZcFVxdEorTWNmTDhjdk9FSWtJK2cxTUZoTUsvenIxZlV2dnV2Q3lS?=
 =?utf-8?B?MFh6d3hMRGY3Q1hvRHQzOCtDb2JLSW55d3YyRHIvN0JaMnlNMUhMWnFYejda?=
 =?utf-8?B?S2NTd0QrS29GaGFleWFmQmEvcEZOUTFpTzI3Y3RUMHpIbW83b3puUmdhNFFH?=
 =?utf-8?B?akxRN0pGcVJ5R290emxNaXdOeEdGQkZWUDF6K3VnVVhzWjhyY2ZhMDFrMmp3?=
 =?utf-8?B?UWdiMkdleS91SkQ1MkVmVHBreC9IdC81WmowczZxd0FJWW1WeSt4RVRBTGpv?=
 =?utf-8?B?bnhoMERMcTdPL3NOZUhSaXdaMlZqRkNJaWRaTXh0NGJRb2xkSHFMTllmay96?=
 =?utf-8?B?eEpWa2YwQ3JMbFR6SlBuVG1qcHd5VldCRVA0RHh2RkUxRXBWUGRBUXR4WFJh?=
 =?utf-8?B?TzRFU2cxaGFIMzNPRmowNmNxUGlleE1vajA5WkZuZ3NURzhCUHJ4ckJJYkdB?=
 =?utf-8?B?eDRKcEdGaEo3T2tjMHNZSithUDNIM200eU1qVS9ScTVmNVp6clQrWmMrMlpv?=
 =?utf-8?B?QUZkZDh6RnB6bVl6bFV4RjM5WWpadXlKYU9pWDg0WTczbU5xOXR3VzdEcEgv?=
 =?utf-8?B?Z3orSm4zQm15V2hqVnFsS0x1QnNnZlFnaE9NWTNJbTluRTZKdVBlSGZabWhX?=
 =?utf-8?B?NnhKU0xaNHJ4dXZkeVMrU0JURm5mc2JZLy9nK0RQcmk0cUlVRGdoYW9KVkps?=
 =?utf-8?B?ZjVkWGhhY2pMbUdRY0ZqYkIwRGZJTFVnNjh6dk92YzAyS2s0YXBtUitMamk5?=
 =?utf-8?B?RE5NN21oNkkvcFRVb0M5V3hXWE9mYXBCVjRBd3EwMDNCeUpVL0FvMkdGSURI?=
 =?utf-8?B?TlV5eTl5d3JvWFdockxuT0R1WTExZzRVRW9yOHBZT2srcWhleDBwSTFESVFP?=
 =?utf-8?Q?6Wxutuf0U9CbylHHIS0tbqaaQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f3ad66-1050-4c08-eb4c-08dbbec8caab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 19:43:00.5924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goPF/hQcQwiKGbk9oJHnzTcnAQd7TSqi/j7FpaolYPeaj2AtYoS889dpr8GwCgfxXbVZEx2skbCByGFsSqs9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
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

Pj4gTXkgb3JpZ2luYWwgcGF0Y2ggc2VyaWVzIGFkZGVkIGFuICJzbmNfd2F5cyIgZmlsZSB0byB0
aGUgaW5mby8gZGlyZWN0b3J5DQo+PiB0byBtYWtlIHRoaXMgdmlzaWJsZS4gQnV0IEkgd2FzIHRh
bGtlZCBvdXQgb2YgaXQgYmVjYXVzZSBvZiBhIGxhY2sgb2YgY2xlYXINCj4+IHVzZXIgbW9kZSB1
c2UgY2FzZSB0aGF0IG5lZWRzIGl0Lg0KPg0KPiBvay4gTGV0cyBnbyB3aXRoIGl0Lg0KDQpCYWJ1
LA0KDQpJJ20gbm90IHN1cmUgd2hldGhlciB5b3UgYXJlIHZvdGluZyB0byBicmluZyB0aGUgc25j
X3dheXMgcGF0Y2ggYmFjayBpbnRvDQp0aGUgc2VyaWVzLiBPciB0byBzdGljayB3aXRoIHRoZSBk
ZWNpc2lvbiB0byBkcm9wIHRoYXQgcGF0Y2guDQoNCi1Ub255DQo=
