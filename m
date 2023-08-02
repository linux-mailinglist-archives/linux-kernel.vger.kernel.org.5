Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CD76C526
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjHBGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjHBGI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:08:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA1139;
        Tue,  1 Aug 2023 23:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690956505; x=1722492505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8qSPcXQjkQTUlGgdZ+R6MIFHcRL9h9R5vOxBUntV528=;
  b=JuLYOoNKAlqPnjm2+K/6R5cknBLkuB0VFPFvRIqZEG2pRUsJZgBD6Ow4
   qFDNsXnPRuOgqzaofyOiFautdRmG7bUg8PuM06dKp6O5VfYzug/+3PGhS
   EW43xUTKCdseI+pmTF0/cjm1vdKKNoDOnD02xRiVZS63kpo3Gq/TWVjHa
   HJavVCYsbZLEOcWu+G6XRah+Rmh5yYKM69E3Q5Snf1X20HC99K+u8I9Ma
   nGYhifAJoEdNasGgcM6U8FFu62O33SeBuHZx8kXgsyYch2eJ2LA+W1ZL+
   LYKAsFaZbJcFJRP6Eyffb4F5JCUlzGYnbKfU8Ls5scyhRju+M/D9qvQcB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="366952911"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="366952911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="706046761"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="706046761"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 23:08:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:08:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 23:08:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 23:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIY8mAn4rEG4gOd29ahfom/XtJLHyJxoq0nKR/1Y2AyvUTzK2VCgFsoadh29wLRh1xjgqoGTJQU68X1i2+lw2csMznmICPTywSo7wMQCotHtY4yxtEzd625L2U+cYbWcWN1OBjYHCaR1JMPzrOWX/hdW7qf74yYImNoKrR15P2Q93mkAfNpKkNzjKcVIK3VpP5x4vOd2kYEmQgwL4V5yh2o72gPez0hQ1FWFk6GjM9CA0TfkmTbWaVvDgCR2sQ999bbc4T411Uc4+G+oI4iUC93C1124vUuF5fCfIVq6vHOgOO5iJyB66UNwuS0/lPKiP9PE+ql4cLx0SOW+u30XRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qSPcXQjkQTUlGgdZ+R6MIFHcRL9h9R5vOxBUntV528=;
 b=BsKrar8wg0jB46ztUDGf9oV1SOlVx9PNJy9kDp5eka5JazeBKOPRuJZiHkFBmig32760LZ5dEG0q2//Pc9mkKTKAV9OVeMW7aQMRZJjXrzisKxrVMhrr6YMNVoF180S5JhM2QN3AdZd9+YKuHJXyKCPmFGcm5ZLe4mXu0IA9cBohWuaihlUKjdhNVSfAmnqdKKfkRfU8rv2FCQ0kmy/ts20/R23kgxJUy0fJzF4vTcfUgdXX02RCx3OZy75V84tCyVA11fEThY6DphIgmKplY5xLHvxl9tlpFAlr55fNwSmJc6tmpBRT/VS9Ly0qorBEMwK2doTLuYOtz88j1fPtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:08:21 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:08:20 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZutnYLMGgFuTJ3EWyF7wdkiGiPq/IcWPtgA4oXwA=
Date:   Wed, 2 Aug 2023 06:08:20 +0000
Message-ID: <abe41c22f72ad600541c6f2b199180b1cbcbb780.camel@intel.com>
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
         <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
         <87wmyp26sw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmyp26sw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: 2bb4dd73-5509-453c-028f-08db931edee1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pe/Xyz7+KNLE74WJdjDNhyt0FdKSzb7dW9iS9gftVzgbfBKOLa2T9k2q1zZNOAPWTkwXBq70vqcabfmyQi+01D/uclQQihD2LUZDllWVF7EyeETr1tQpFDTqBlxVINOJtdx5nUaV1xwRfmgHWqo4QF5c6WH0ntP4Z4hZ6PST1vLpVMvBoi5sQ6GxV1LXS4TxxeS6KAOotFh9R4QMZrWJVRgNL4mjS9HmB3KBFsc9yz8U8bnAJ8UpbqMNNfvu2dJDBYK0o4FhRxWpFhCCc9PxqNTiKKDZ9sq94CZEFCesStO3unZfIDE+z4jBSIzR9dEiq89g6b9m/G9YoIpxuDDp5NXoZwmKUTxJVFrrGqnuQKiwYqdMIIFAZJibpeRUHNvzpovG4j68RNuyRxv1CyMKjgEfH21THTgY7WpKejV4b5pwHH+F4VVtpYbuGySalBsW+/1Xn4qCWcq+WXDc/SpwBybDSeLy2w5dqqmo6YqroOGtRdB8MvlG0emE9pWruWcfDXcQs8zXM+MXL7mdBIKEj6TKOz4j9py9jI+Rb6MVNYRdM3Qw+2Mjh2lf41DZvSGtN0R7YHwR5EKau//K/3trIFQgIYR9zl0rou4n17HWGsTL1hxaxQBsxgE9MpcKounw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(36756003)(6512007)(316002)(86362001)(478600001)(122000001)(37006003)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66476007)(66556008)(66446008)(6486002)(64756008)(4326008)(6636002)(82960400001)(6506007)(41300700001)(26005)(186003)(83380400001)(6862004)(8676002)(8936002)(38070700005)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkhhd3g3REhacGhmVUlmUjdsWS82ckh3ZHdnMFBlRU9KWWVqYkdPT2U4TWJi?=
 =?utf-8?B?dWFHTzlhYzZSVjhsaysxSW1OcmNJbTZ1SzNVN3AydTJTeEtzSlNtck1ULzVx?=
 =?utf-8?B?aDRlRE8xYW1OeUtLU3AyaDJuNEh3N3RZbnpnbEhRK2F0Uzg2VlplcmVvQlBQ?=
 =?utf-8?B?UHBNTUxQMUpUWW01Y2FQc1lVbEh5N3E4d2p6Nm13bEIxejhBcG5BNlYzY05n?=
 =?utf-8?B?aWZkbkRFY2JUWUNPRDRWR1Bsa3p6UWRnR3pucFFNSTljajJzT0RrT1dZTjZo?=
 =?utf-8?B?ejhKZ3NVTVNVcGllelpRWW9MWDZNUTAzZVdOcHZ6R2lRcG1IbnUrV0s3N2Vx?=
 =?utf-8?B?RWdsWnBONGQ2U0RlT0FaVktMNFIvSnArcDIvZ2k4dEFaUHVMV1p4RXFNWmNr?=
 =?utf-8?B?ZjN5QjhZQ3RuS0t1aXF3K1ZvWmplcnh1SGh5NXFTSmtYZlYrUkFteGh0aHRy?=
 =?utf-8?B?dzdWUCtrOEFza1grZGxvYTBob29MQ0h0YlM2V1NTTmkyZnl2M25qejY4WUtM?=
 =?utf-8?B?OE9sVDhvS1E4aU8vRDN2VUV1aHA5Q0RmSmp1YzdqZkNkeTFhRUxaRzN1bVF2?=
 =?utf-8?B?V1FWVHRuZmRiMHNjUzhpNXZrRlljV1gybW40Q05EbHBGdXRsdHBnc2l6VGxu?=
 =?utf-8?B?Z016VHprT05FdHhkS2Q3VU4zZUtSU0FZYXVNTXNPM0ViVVFtbDcwb1ZDdllw?=
 =?utf-8?B?ZSt4bFJYSVpDVUtGSlBGdVpjV0hoblp6cU5zdWIrR3VacldsODl3dlVDS3FS?=
 =?utf-8?B?cDVyY3VwZFByM0lRbk11OE9zYis0RUFrMmUvVUtFWCtiTlE0U1ErRjNaWXly?=
 =?utf-8?B?RFBycHJPVWMyRXp4L2g2bXp2Qnd4eThjOHVmaldxZ05JM1FERTZRTnZGZFVq?=
 =?utf-8?B?TWF4QXpuWFRIc1JXZW5zem9jNFdaa2xxK21Ka09MZUxqUUhoaldsYVNRcDdV?=
 =?utf-8?B?RjJiUnhYb2dLMWw2Q2pua3JoV3ZCNmUrVWxNalg1MG8vQUphUHNDOGhtdUR5?=
 =?utf-8?B?ZDhvZmV3NUJWTnNxTFloSlUwVGUrelZITUJPanlSUjNWcUhYbWhEMGRoTmpj?=
 =?utf-8?B?RUdhZ0ZpcVV3cEZDbzNpR25JRm04WGZ6OGE5cU5DUkVqSVhtK2xaQjJRNGdz?=
 =?utf-8?B?RFVYUU1wUW9lRk04VmNrOHJDR0NWVzZzd2s0S0RhZjkxV0lwUjlSK2pRdnVG?=
 =?utf-8?B?aXh4dDBHVGJqcURacldZRGk0TmsyZEdEOUVVTXUraDZiT2JySisreUtPQ0Y4?=
 =?utf-8?B?Q29iRWZJTWFYeTNhem1Td216Wk5YTEFMa3dPekx6dW1BdlZ2aTJFc0FiNS9H?=
 =?utf-8?B?amlZVVpiYmVtNHpxbjVsTnhhQ1cvOWFtVTZIbHpLaGF5aDdaNGVCeks4OUVu?=
 =?utf-8?B?ZHBIamNPUkF4MERZVXRkbWlZR2xBTWR2Ykp1RGIvZ3U4eTI5SFZPdXI3cnpR?=
 =?utf-8?B?OEtLMC83TXpwRnF5bHArcXplakdtR253OXphbEVWa2x6WXdUR1I4NDJGbUVR?=
 =?utf-8?B?UmVZTWJGQkxoSzQvTlpnSUJSam5sMmoxcVlpeHcvL3VTMGhYL2Y0am05K2k4?=
 =?utf-8?B?R2dUd1p2bHRFT1poZ3h5NG5JR1lRQVVDSTNQZ0RPcVplOUw2VWdrYUdTaVV1?=
 =?utf-8?B?bWRwVDZjNGx0dWVoenVjczdQbWRMbzBWcHFRSzRPTTN1dVBsZDZYV2hGWk9P?=
 =?utf-8?B?LzU5UTJEWVBnRUx6cmJUNGVVQWVRZElnV0t2cmRkM3pBU3lFcG9aSlNDbTZx?=
 =?utf-8?B?OGZFd200ODRmM2lCWHhLSWhBdTJLcXpDeFBRMFdHK0FTNW8vbU5lclFINUt1?=
 =?utf-8?B?YXcyeFdPcjJROTNrNGhBbWk2YXB1TWVaV01RN1RyVVVPc0dqV0dFQ1FseEEy?=
 =?utf-8?B?ZVBtbmtmZ2tGOXMrYUZUSnpQNDNVYlFBUlBGaEZ6V0F0U3RIRys4UCtJeDVB?=
 =?utf-8?B?N0RjOTVSMkt1UlV2SGRBc0FsU1k4UlNMaGxyNDMrcWE1U0llTHJrNHVhUUUw?=
 =?utf-8?B?ZUZZRWNUQmhXdWNTWkZNdVNqUUlCS3k2b0t2cjQrb2FNQzNTVk93VlNOZXd0?=
 =?utf-8?B?c21GcVg4bWo4bkhUM3ZtMXA5UTZTMTFzT0JRTWd6Q1JXenNETXRtTnY5aUhs?=
 =?utf-8?B?TEw1T3dwM3JCcVl3L2lPTWtoQTdORWRJT3JydkY1d3lEOVhOMU84am1ySzNC?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26624409CC2B1744969920C9786F327D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4dd73-5509-453c-028f-08db931edee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:08:20.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DF7pA2H4MhecjSXufXGLtmBM1GiEPThx8GFwrdn3PX/mv2Al+LRJgRFbgbjkAqpaMahB1+lc3bLrVzQtgOJjIXJVTK6sefF1NOXAtsVSmy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDEzOjU0ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToNCj4g
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+ID4g
DQo+ID4gQEAgLTIwMzUsMTIgKzIwNTYsMzggQEAgdm9pZCB0cnlfb2ZmbGluZV9ub2RlKGludCBu
aWQpDQo+ID4gwqB9DQo+ID4gwqBFWFBPUlRfU1lNQk9MKHRyeV9vZmZsaW5lX25vZGUpOw0KPiA+
IMKgDQo+ID4gLXN0YXRpYyBpbnQgX19yZWYgdHJ5X3JlbW92ZV9tZW1vcnkodTY0IHN0YXJ0LCB1
NjQgc2l6ZSkNCj4gPiArc3RhdGljIHZvaWQgX19yZWYgX190cnlfcmVtb3ZlX21lbW9yeShpbnQg
bmlkLCB1NjQgc3RhcnQsIHU2NCBzaXplLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2bWVt
X2FsdG1hcCAqYWx0bWFwKQ0KPiA+IMKgew0KPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCB2bWVt
X2FsdG1hcCBtaHBfYWx0bWFwID0ge307DQo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IHZtZW1f
YWx0bWFwICphbHRtYXAgPSBOVUxMOw0KPiA+IC3CoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcg
bnJfdm1lbW1hcF9wYWdlczsNCj4gPiAtwqDCoMKgwqDCoMKgwqBpbnQgcmMgPSAwLCBuaWQgPSBO
VU1BX05PX05PREU7DQo+ID4gK8KgwqDCoMKgwqDCoMKgLyogcmVtb3ZlIG1lbW1hcCBlbnRyeSAq
Lw0KPiA+ICvCoMKgwqDCoMKgwqDCoGZpcm13YXJlX21hcF9yZW1vdmUoc3RhcnQsIHN0YXJ0ICsg
c2l6ZSwgIlN5c3RlbSBSQU0iKTsNCj4gDQo+IElmIG1ocF9zdXBwb3J0c19tZW1tYXBfb25fbWVt
b3J5KCksIHdlIHdpbGwgY2FsbA0KPiBmaXJtd2FyZV9tYXBfYWRkX2hvdHBsdWcoKSBmb3Igd2hv
bGUgcmFuZ2UuwqAgQnV0IGhlcmUgd2UgbWF5IGNhbGwNCj4gZmlybXdhcmVfbWFwX3JlbW92ZSgp
IGZvciBwYXJ0IG9mIHJhbmdlLsKgIElzIGl0IE9LPw0KPiANCg0KR29vZCBwb2ludCwgdGhpcyBp
cyBhIGRpc2NyZXBhbmN5IGluIHRoZSBhZGQgdnMgcmVtb3ZlIHBhdGguIENhbiB0aGUNCmZpcm13
YXJlIG1lbW1hcCBlbnRyaWVzIGJlIG1vdmVkIHVwIGEgYml0IGluIHRoZSBhZGQgcGF0aCwgYW5k
IGlzIGl0DQpva2F5IHRvIGNyZWF0ZSB0aGVzZSBmb3IgZWFjaCBtZW1ibG9jaz8gT3Igc2hvdWxk
IHRoZXNlIGJlIGZvciB0aGUNCndob2xlIHJhbmdlPyBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhl
IGltcGxpY2F0aW9ucy4gKEkndmUgbGVmdCBpdCBhcw0KaXMgZm9yIHYzIGZvciBub3csIGJ1dCBk
ZXBlbmRpbmcgb24gdGhlIGRpcmVjdGlvbiBJIGNhbiB1cGRhdGUgaW4gYQ0KZnV0dXJlIHJldiku
DQo=
