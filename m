Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEA17B722A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjJCUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCUDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:03:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EED9E;
        Tue,  3 Oct 2023 13:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696363416; x=1727899416;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3twkPY19DF3AnMtRSWS8LwvSCx2LZOxEasDW3Jm/MzE=;
  b=I83pIVtGGvRsv3VjXnjA811fzRWmOpN1k50VttQ1Bl432/HAlkTvqrE0
   l41qBnjJ6hX/n5utGyZmr4ITP6XnwaAb3YP+GTLwDsVLVrie7OfVXVxbG
   f+LF4yjjSK/mnDJU/sTgkgQz2g08sKXBck/X9ydh0KZHM7/hMx9WNTS91
   l1kM2Li9twqJ+jkfYlQBfVBAwSW35MQPFzndCy9D+wlrcD+1a1EFhJFM9
   Nyd3GNXRovfEVkprWn1HAA8AUD0/PXVEzQLWDOh79QwT0By4yXO6NL0vI
   8q+OHyQTcqrs41aer1qsuruiuS/zY4w1SF6HF7uotNIpkqFbsmxk15CtN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413882814"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="413882814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082144166"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082144166"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 13:03:35 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 13:03:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 13:03:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 13:03:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkoeHCn/qgjgZnRDRqwOELByc7Xc7J18fRLbj3rEHCzHJXjRbTsHz/Jbq1f6DfGzuhSbWpUSy0cRZDWILwAN7YX4/HQVhjIIqIG77QOROlMEKQ4N8LAfYtvyoEUDsmeqw7+WF61Ex9I2UGQ43hHbOb7chjC1xfu5jDvJOKZ5GpqnCjcqPCq/Z+Q3zBtpXiFLCNSbXOcJLjBvzJul0Kmiz+24bEWP8Rog3s4GcePclPa1hvCoCZhL/2UGXCUXJxCASefoFLA3aQlC/NIw/f8xJHHgLWg+N/wevSozCpfe9fAV/zOOfUwlmTQKgJGBkHDX9CkcLmNL3qurlGILwFdrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3twkPY19DF3AnMtRSWS8LwvSCx2LZOxEasDW3Jm/MzE=;
 b=ZLMULxvgpzgjvj7Nccbq1ruRXtOeGPFRNi+ygYOTNHjsYrgtqDbP5YqM1rhPvY55hC9kLjkVo3q0XfiVUifoWcmEHD+diwHSt9VRIBW+hW4sNHoXSwhyawYmeCqklqBJkxjQFTqBq865JhX/j78AXJfO4Z2sDTPka8ImJ4o+Robh/X9WUTr/ZVlol3xEFUicf7dcIhE6NQneETrmysP4SWVGaRiP4uX5AgZw4PGfA3Y4Z66wPwKxJRzmMwEmuOKumCFJKL4ZU8QV2GJUICq2gHxujENDX75khOaT+hWrr+lxGN6PLdgQBrGM/V4WmsCxxAPC9Vz05uab4y6xxf879g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 20:03:32 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.035; Tue, 3 Oct 2023
 20:03:32 +0000
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
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v4 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v4 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZ8kqsHJx8d/bt+kCtUyxGrpjLf7A2QRcAgAJDrwA=
Date:   Tue, 3 Oct 2023 20:03:31 +0000
Message-ID: <7893b6a37a429e2f06f2b65009f044208f904b32.camel@intel.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
         <20230928-vv-kmem_memmap-v4-1-6ff73fec519a@intel.com>
         <efe2acfd-f22f-f856-cd2a-32374af2053a@redhat.com>
In-Reply-To: <efe2acfd-f22f-f856-cd2a-32374af2053a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH3PR11MB7866:EE_
x-ms-office365-filtering-correlation-id: 71837772-d2d8-414b-fcfb-08dbc44bd189
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2yVagq3/5abvCPHH1EXj/qojvD80lOYiPNKAY4JJyz6LDZTwXEC3kw2bJU4xQWXHFYd0G7a12yWyWxd2Gh4O6/JVe+tKbKXU6i/dGYvP9AXtR7gUMhqNFtGF75tAThWXqBWu+cRZN1npejhjrJTrp8JnyzlnirNig3jqHvEMTtUoBeqFYYXDexD6v9DG0oGBq5WV7YrwVF3nk/BtpEVggkGSdc8JyXCFWJ7Zrr8d+q2UT58JrGPvXQIgA2ioyrEvI8R99FEqKJWdh2zxvTl6G6ZR+irYMhYgt6lS8UGIhWs3VaC8B0Hs33vZ3Jkie8eu02fhYwTeyUFBBnEI8SzDHy24TSK0+mYGYqlDfY824GtnAodlOhN/zEuVSciNU8WxfLsh34RLvZ/UgwPfL1pJU7ZwUWNpTxTHdQp2F4R6v0mYvwRM55I1Z1PM6GszBNO5t0bMJLnlCgcZjOd38KuWVS/m5/XXzJ5GmRqO3oPShpUCUc6DERu83EfjQ1Dv7l3txtyaHr8oyli6VsGj7obo93jxLEbxVZvxFtZMA7NFWBU2qw9defl8uCtQhm03GRgTVu4sLHpnnrASRwXPI7L/2huSQsMdASh9n0ip4qc0+hug06fYEfq/2OWhpJRQrSWU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(71200400001)(478600001)(2616005)(6512007)(83380400001)(26005)(316002)(7416002)(2906002)(41300700001)(76116006)(110136005)(54906003)(66446008)(64756008)(66476007)(8676002)(5660300002)(66946007)(8936002)(4326008)(66556008)(36756003)(38070700005)(38100700002)(86362001)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBPTXdOMWR5eEJGbEh5ZXBDVzNyMm16TFh5K05hM05zUkg0aGZNSkNidE1Y?=
 =?utf-8?B?NkoyYnFpVkVMbnd6d2VTb2ZvK0premRxcURNa2Q4bTlKbkZIbjZaeW5HRUpO?=
 =?utf-8?B?eXprOXgrRDljeFVxQWdocEVwTVM1bjUvOFVncjNCc0xaQnJXd0kzTXJwWmtH?=
 =?utf-8?B?YlpPOW9wN3BqbXNMQ1FzMC8xYjZndzRhZWpUcDNmQi9lbXZKSjNJVlJGNEdh?=
 =?utf-8?B?ZFE1dmYvcUcybEJ2anJIYUVTWHV1dWVvNzJHT0s3dmh3MHJzeFI2R0xORVRI?=
 =?utf-8?B?RmRXeW1QZkFqa2svSW8vUDlVZ21kc05UU2xxTFRWQ1p1aVRtZ1h4eHlUZ2Fa?=
 =?utf-8?B?d3Bka0VTd3gvOVExL1hIbUIyUnlRa2RnNWlWK0NYSkdQN3owU2dHbmZsRWE1?=
 =?utf-8?B?by9BTWpEc0JGNFQxTlJ0ZUFxZFp6blh4RjZTc1RqaFEzeEgrbHd2OW9YOUV1?=
 =?utf-8?B?ZmdQakRGcmg0UXRaaTRQQU5OaWRrbVZPVUZPcEs0bWh0eUhPN0M3ZmRGOWFX?=
 =?utf-8?B?V0ZvUUJGQ2hlVnF5Nms1ODE1ZDZNbGZMTk1GUXQzT1lyUnE3MlRBTVBvL0Rq?=
 =?utf-8?B?NndOa1FtN2FJY3BMTmRTbEs3RHdUcHNTQTZlaGNVSmtuY2IyYjJSaDk3cFN3?=
 =?utf-8?B?YWZmVU9iaHlyUndzSHBNd0ZOSEY1YS9FTjA2WlAvWkg2T3A1cVU0aGRkckRy?=
 =?utf-8?B?TnJzYVFkR3dxUUhQamhjZlk3UUk5b29yM1pnZ2pXMG1FYld5TzgvcHdGd09I?=
 =?utf-8?B?ZWVpOEJPaFAyVTBVdjBETllpNlJ4cWFUV2JjZEt6M1NLUVlFQ090OHowVUdR?=
 =?utf-8?B?MU1oMzdVUFlaUXArZmhPWkZqY3ZJWThIK3dXZ3hNL0d4MDU4a3EvbXZZVW5C?=
 =?utf-8?B?WUxTcVFNN2l2dTl4NUhTbEVpNlNaOGlaME5rTy91NitqUDdta3JzZjFnQlZv?=
 =?utf-8?B?bFBPNXB5YkFIVzV4SXVmSUo0K1lhTmRxZ3FTZ2JkUU02aFU0bVVISXdBUjlR?=
 =?utf-8?B?ekdyZStJL2xNdXFxbWFLTTh2SHMrakRIVXJXTVptNHhYMGVJMTVoVGVRSGtE?=
 =?utf-8?B?aThCeThVNUpMeVpWTXBWV0VlT0xZMElSUTFjakIyNy9qUFRidUxLTTJRT1B3?=
 =?utf-8?B?bVU1c2RVcXlYT3Q3ZnBla1NkcjNTOU9tQSs1SUJmOFVPN0lKemhEanNreGZZ?=
 =?utf-8?B?cHVrMnB5a25mZW1YUEZHcHljeWR6MW82ekxiMDZqWTFKR0tnSjhKbEJuQkdu?=
 =?utf-8?B?MEJQWUhJUStZREN4QjhqUExJNXRML3RSSHhCZ2paWDRVL3JvaUxpOGZPelJS?=
 =?utf-8?B?RGVMdHhpTGQ0aXV6MTlJNHowZVc0aWVMYWNXeHBweVVtQjh6SUV3dUV4aVhC?=
 =?utf-8?B?cGVtL1YyZjN0K0Y4Vk5iOXg3WFdZZ2ZpbVBUeGNYSVU5ZzdIY0JkT3BmZStF?=
 =?utf-8?B?TEcwQ1FkclJqa0Uxa3R5aXV0NGUvY0ErOXV6WldSN0d5bjJiVjdWcnpwc3ps?=
 =?utf-8?B?OVQrQ1duWUlUYUZwTUVtd1ZQcjFiMkNkcTR6NzhBSHppQkR2VnpBNnZyVXNG?=
 =?utf-8?B?ZVkzaTlPbXNvcEo1NTRjNXdBREs0Sjk2VzNINk1vQ2hNUzduaGZJWW9USmxD?=
 =?utf-8?B?aWVER01mcHh6ZE4vaVZ6Q3FrSk5iUkpiUjJtOVhKVnhHWFZZeGtndXMyWVpF?=
 =?utf-8?B?YzZIeDFydFpsV2Q4cUROWktpZjhIczQyL1dBQnN1bXZUZVdEcVpUQlFkaU03?=
 =?utf-8?B?OTd5SEZzWlkxR09DVW9yM1BKazVWcXM4MUlpZHVTZS9Lend2TFZKdXI3ZWk1?=
 =?utf-8?B?VTRqVkZnQlhFTFFTNFBOa2NsamJMNldKbERmL1VqblJJdTRlRmJEeHBhR3lX?=
 =?utf-8?B?SlJ4NzBEOTI1dmxQaWZickxZZ2ZPdC9iWUhUNnRjbXF3WlM3SThLWjVoTGxp?=
 =?utf-8?B?SWN6Y1BOa1luTjc0Nndody9HWDVOY1pZZjB2UlViaHI1amxsaW5RMGF0Uzhk?=
 =?utf-8?B?bjAwWlc4YkhQYlJyQVYzNG5vV2o1OG9jQlNYR1NCU1o4Z1Y2VGwrWE5XQWx2?=
 =?utf-8?B?VW4wM2gvWXVCWitWM0RuTzNqVDlKcThTWHFOeGc5WTN6Uy9wUXpUOEtQUmY4?=
 =?utf-8?B?OXRYcmFBQzdFbVV4VVU4dEhuOUdaR2pkU0JMUEgyeVd4YXc2Q2YrK1l2TURF?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19A05A07E6734140B599DAEB6A8476B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71837772-d2d8-414b-fcfb-08dbc44bd189
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 20:03:32.0065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cykMBAWrAn+bMKWoECtBC0jXCuZcvabhvESOQ4wUXadIzk4mWZa4GBTBktEqgK1vrEKe+qPESul+W4WnmgDl68Z9oiN6cZyg7a/Q3O28BQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTEwLTAyIGF0IDExOjI4ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9fcmVmIHRyeV9yZW1vdmVfbWVtb3J5KHU2
NCBzdGFydCwgdTY0IHNpemUpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmMsIG5p
ZCA9IE5VTUFfTk9fTk9ERTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgQlVHX09OKGNoZWNr
X2hvdHBsdWdfbWVtb3J5X3JhbmdlKHN0YXJ0LCBzaXplKSk7DQo+ID4gKw0KPiA+ICvCoMKgwqDC
oMKgwqDCoC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogQWxsIG1lbW9yeSBibG9ja3MgbXVzdCBi
ZSBvZmZsaW5lZCBiZWZvcmUgcmVtb3ZpbmcgbWVtb3J5LsKgIENoZWNrDQo+ID4gK8KgwqDCoMKg
wqDCoMKgICogd2hldGhlciBhbGwgbWVtb3J5IGJsb2NrcyBpbiBxdWVzdGlvbiBhcmUgb2ZmbGlu
ZSBhbmQgcmV0dXJuIGVycm9yDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogaWYgdGhpcyBpcyBub3Qg
dGhlIGNhc2UuDQo+ID4gK8KgwqDCoMKgwqDCoMKgICoNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBX
aGlsZSBhdCBpdCwgZGV0ZXJtaW5lIHRoZSBuaWQuIE5vdGUgdGhhdCBpZiB3ZSdkIGhhdmUgbWl4
ZWQgbm9kZXMsDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogd2UnZCBvbmx5IHRyeSB0byBvZmZsaW5l
IHRoZSBsYXN0IGRldGVybWluZWQgb25lIC0tIHdoaWNoIGlzIGdvb2QNCj4gPiArwqDCoMKgwqDC
oMKgwqAgKiBlbm91Z2ggZm9yIHRoZSBjYXNlcyB3ZSBjYXJlIGFib3V0Lg0KPiA+ICvCoMKgwqDC
oMKgwqDCoCAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJjID0gd2Fsa19tZW1vcnlfYmxvY2tzKHN0
YXJ0LCBzaXplLCAmbmlkLCBjaGVja19tZW1ibG9ja19vZmZsaW5lZF9jYik7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKHJjKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmM7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4gK8KgwqDCoMKgwqDCoMKg
ICogRm9yIG1lbW1hcF9vbl9tZW1vcnksIHRoZSBhbHRtYXBzIGNvdWxkIGhhdmUgYmVlbiBhZGRl
ZCBvbg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGEgcGVyLW1lbWJsb2NrIGJhc2lzLiBMb29wIHRo
cm91Z2ggdGhlIGVudGlyZSByYW5nZSBpZiBzbywNCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhbmQg
cmVtb3ZlIGVhY2ggbWVtYmxvY2sgYW5kIGl0cyBhbHRtYXAuDQo+ID4gK8KgwqDCoMKgwqDCoMKg
ICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKG1ocF9tZW1tYXBfb25fbWVtb3J5KCkpIHsNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBtZW1ibG9ja19z
aXplID0gbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMoKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdTY0IGN1cl9zdGFydDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZvciAoY3VyX3N0YXJ0ID0gc3RhcnQ7IGN1cl9zdGFydCA8IHN0YXJ0ICsg
c2l6ZTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3VyX3N0
YXJ0ICs9IG1lbWJsb2NrX3NpemUpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBfX3RyeV9yZW1vdmVfbWVtb3J5KG5pZCwgY3VyX3N0YXJ0LCBtZW1i
bG9ja19zaXplKTsNCj4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugew0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBfX3RyeV9yZW1vdmVfbWVtb3J5KG5pZCwgc3RhcnQsIHNpemUp
Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiArDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAwOw0KPiA+IMKgIH0NCj4gDQo+IFdoeSBpcyB0aGUgZmlybXdhcmUsIG1lbWJsb2NrIGFuZCBu
aWQgaGFuZGxpbmcgbm90IGtlcHQgaW4gdGhpcyBvdXRlcg0KPiBmdW5jdGlvbj8NCj4gDQo+IFdl
IHJlYWxseSBzaG91bGRuJ3QgYmUgZG9pbmcgcGVyIG1lbW9yeSBibG9jayB3aGF0IG5lZWRzIHRv
IGJlIGRvbmUgcGVyIA0KPiBtZW1ibG9jazogcmVtb3ZlX21lbW9yeV9ibG9ja19kZXZpY2VzKCkg
YW5kIGFyY2hfcmVtb3ZlX21lbW9yeSgpLg0KDQoNCkFoIHllcyBtYWtlcyBzZW5zZSBzaW5jZSB3
ZSBvbmx5IGRvIGNyZWF0ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcygpIGFuZA0KYXJjaF9hZGRfbWVt
b3J5KCkgaW4gdGhlIHBlciBtZW1vcnkgYmxvY2sgaW5uZXIgbG9vcCBkdXJpbmcgYWRkaXRpb24u
DQoNCkhvdyBzaG91bGQgdGhlIGxvY2tpbmcgd29yayBpbiB0aGlzIGNhc2UgdGhvdWdoPw0KDQpU
aGUgb3JpZ2luYWwgY29kZSBob2xkcyB0aGUgbWVtX2hvdHBsdWdfYmVnaW4oKSBsb2NrIG92ZXIN
CmFyY2hfcmVtb3ZlX21lbW9yeSgpIGFuZCBhbGwgb2YgdGhlIG5pZCBhbmQgbWVtYmxvY2sgc3R1
ZmYuIFNob3VsZCBJDQpqdXN0IGhvbGQgdGhlIGxvY2sgYW5kIHJlbGVhc2UgaXQgaW4gdGhlIGlu
bmVyIGxvb3AgZm9yIGVhY2ggbWVtb3J5DQpibG9jaywgYW5kIHRoZW4gYWxzbyBhY3F1aXJlIGFu
ZCByZWxlYXNlIGl0IHNlcGFyYXRlbHkgZm9yIHRoZSBtZW1ibG9jaw0KYW5kIG5pZCBzdHVmZiBp
biB0aGUgb3V0ZXIgZnVuY3Rpb24/DQoNCkhlcmUncyB0aGUgaW5jcmVtZW50YWwgZGlmZiBmb3Ig
d2hhdCBJJ20gdGhpbmtpbmc6DQoNCi0tLQ0KDQpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5X2hvdHBs
dWcuYyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCmluZGV4IDQzZGJkNzFhNDkxMC4uMTMzODAxNzgx
NzNkIDEwMDY0NA0KLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0KKysrIGIvbW0vbWVtb3J5X2hv
dHBsdWcuYw0KQEAgLTIxNzEsNyArMjE3MSw3IEBAIHZvaWQgdHJ5X29mZmxpbmVfbm9kZShpbnQg
bmlkKQ0KIH0NCiBFWFBPUlRfU1lNQk9MKHRyeV9vZmZsaW5lX25vZGUpOw0KIA0KLXN0YXRpYyB2
b2lkIF9fcmVmIF9fdHJ5X3JlbW92ZV9tZW1vcnkoaW50IG5pZCwgdTY0IHN0YXJ0LCB1NjQgc2l6
ZSkNCitzdGF0aWMgdm9pZCBfX3JlZiByZW1vdmVfbWVtb3J5X2Jsb2NrX2FuZF9hbHRtYXAoaW50
IG5pZCwgdTY0IHN0YXJ0LCB1NjQgc2l6ZSkNCiB7DQogCWludCByYyA9IDA7DQogCXN0cnVjdCBt
ZW1vcnlfYmxvY2sgKm1lbTsNCkBAIC0yMTg3LDkgKzIxODcsNiBAQCBzdGF0aWMgdm9pZCBfX3Jl
ZiBfX3RyeV9yZW1vdmVfbWVtb3J5KGludCBuaWQsIHU2NCBzdGFydCwgdTY0IHNpemUpDQogCQlt
ZW0tPmFsdG1hcCA9IE5VTEw7DQogCX0NCiANCi0JLyogcmVtb3ZlIG1lbW1hcCBlbnRyeSAqLw0K
LQlmaXJtd2FyZV9tYXBfcmVtb3ZlKHN0YXJ0LCBzdGFydCArIHNpemUsICJTeXN0ZW0gUkFNIik7
DQotDQogCS8qDQogCSAqIE1lbW9yeSBibG9jayBkZXZpY2UgcmVtb3ZhbCB1bmRlciB0aGUgZGV2
aWNlX2hvdHBsdWdfbG9jayBpcw0KIAkgKiBhIGJhcnJpZXIgYWdhaW5zdCByYWNpbmcgb25saW5l
IGF0dGVtcHRzLg0KQEAgLTIyMDYsMTYgKzIyMDMsNiBAQCBzdGF0aWMgdm9pZCBfX3JlZiBfX3Ry
eV9yZW1vdmVfbWVtb3J5KGludCBuaWQsIHU2NCBzdGFydCwgdTY0IHNpemUpDQogCQlrZnJlZShh
bHRtYXApOw0KIAl9DQogDQotCWlmIChJU19FTkFCTEVEKENPTkZJR19BUkNIX0tFRVBfTUVNQkxP
Q0spKSB7DQotCQltZW1ibG9ja19waHlzX2ZyZWUoc3RhcnQsIHNpemUpOw0KLQkJbWVtYmxvY2tf
cmVtb3ZlKHN0YXJ0LCBzaXplKTsNCi0JfQ0KLQ0KLQlyZWxlYXNlX21lbV9yZWdpb25fYWRqdXN0
YWJsZShzdGFydCwgc2l6ZSk7DQotDQotCWlmIChuaWQgIT0gTlVNQV9OT19OT0RFKQ0KLQkJdHJ5
X29mZmxpbmVfbm9kZShuaWQpOw0KLQ0KIAltZW1faG90cGx1Z19kb25lKCk7DQogfQ0KIA0KQEAg
LTIyNDksMTEgKzIyMzYsMjkgQEAgc3RhdGljIGludCBfX3JlZiB0cnlfcmVtb3ZlX21lbW9yeSh1
NjQgc3RhcnQsIHU2NCBzaXplKQ0KIA0KIAkJZm9yIChjdXJfc3RhcnQgPSBzdGFydDsgY3VyX3N0
YXJ0IDwgc3RhcnQgKyBzaXplOw0KIAkJICAgICBjdXJfc3RhcnQgKz0gbWVtYmxvY2tfc2l6ZSkN
Ci0JCQlfX3RyeV9yZW1vdmVfbWVtb3J5KG5pZCwgY3VyX3N0YXJ0LCBtZW1ibG9ja19zaXplKTsN
CisJCQlyZW1vdmVfbWVtb3J5X2Jsb2NrX2FuZF9hbHRtYXAobmlkLCBjdXJfc3RhcnQsDQorCQkJ
CQkJICAgICAgIG1lbWJsb2NrX3NpemUpOw0KIAl9IGVsc2Ugew0KLQkJX190cnlfcmVtb3ZlX21l
bW9yeShuaWQsIHN0YXJ0LCBzaXplKTsNCisJCXJlbW92ZV9tZW1vcnlfYmxvY2tfYW5kX2FsdG1h
cChuaWQsIHN0YXJ0LCBzaXplKTsNCiAJfQ0KIA0KKwkvKiByZW1vdmUgbWVtbWFwIGVudHJ5ICov
DQorCWZpcm13YXJlX21hcF9yZW1vdmUoc3RhcnQsIHN0YXJ0ICsgc2l6ZSwgIlN5c3RlbSBSQU0i
KTsNCisNCisJbWVtX2hvdHBsdWdfYmVnaW4oKTsNCisNCisJaWYgKElTX0VOQUJMRUQoQ09ORklH
X0FSQ0hfS0VFUF9NRU1CTE9DSykpIHsNCisJCW1lbWJsb2NrX3BoeXNfZnJlZShzdGFydCwgc2l6
ZSk7DQorCQltZW1ibG9ja19yZW1vdmUoc3RhcnQsIHNpemUpOw0KKwl9DQorDQorCXJlbGVhc2Vf
bWVtX3JlZ2lvbl9hZGp1c3RhYmxlKHN0YXJ0LCBzaXplKTsNCisNCisJaWYgKG5pZCAhPSBOVU1B
X05PX05PREUpDQorCQl0cnlfb2ZmbGluZV9ub2RlKG5pZCk7DQorDQorCW1lbV9ob3RwbHVnX2Rv
bmUoKTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KDQo=
