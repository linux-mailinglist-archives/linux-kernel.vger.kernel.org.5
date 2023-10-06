Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB677BC1F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjJFWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjJFWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:02:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E9FDE;
        Fri,  6 Oct 2023 15:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696629722; x=1728165722;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oyIsRa1Gnj8PG5kSKPvD6l39v4UEo4zy64Sg9vyCUfk=;
  b=kcxB4zxcKs+A59Cw07rBIyNwj6UR0TNXPoxYUFHT8oFFvMf41fJPPghM
   A4LlqZpZx02sdSdTmcR2v8ErXLwq5IEx+h1Ppoa8nwWEuTYv34DMKYMkG
   sJKmApu4Qvkeuh3sn2DBXGEn3OpuLpGF1uL5JEpYR+lB1tj0E/OaT97i6
   H07DTzET4gfcr9goFtjJGnbOstX5ifHz6itXmZZhzJ4LrdkskQeDts2HD
   RJXBCR/lEsQKTk+ZUJGwbttVHVJqXEHbq1m37Dx4hpvWwSkuLPyTrH0wH
   r+MrN7iuCiBt/K0CHJihuzDqt0HIu2Xrq1bolGXJ/PyLWdOx9WQ3O9QeI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470110250"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470110250"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 15:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="876092551"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="876092551"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 15:01:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 15:01:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 15:01:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 15:01:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eky5gKOAfVH+MR0sYLJ3lr1rzTsO9+fTiKlNILo3zb7de17e31JWipDesqBAdnlh4bPWTbA++/i5Ak6LGfrVqfqgW98l/S5/ln2tG7HWN/6riO7YP6p9FCLLgmOymRdZ1sFmp/IGUJl/7MiWYfpAZcW/tyKz6dS1GvhGDRRi8swhGiNrTpj24Uz8AaNi2jcUs055tX9vM4F8pb5bCsU6+u5UXo2Zi4CSaTS9cZhBP6oLiGpgApfIiJX4vkuHGX1AxFypKIFqiZzb+0ZHhXXqqI91sjvYbPjebnJBZDWXaNJE6ATlOH0hzT1zQEZAq/lr6Kxbe4f3XNt+1DFu/9LrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyIsRa1Gnj8PG5kSKPvD6l39v4UEo4zy64Sg9vyCUfk=;
 b=mEnKPkBtOJXoCSZLH/CZupeI3x8BXKTn/LejcqBtJAauCKbhgzwAOWnL1GLO1tcpEHz4kW7bKDCFDTbyop8T1ONnd3bgVn9idmjbK+e7BnSN9jFBgkH8Y6zI4ued2UVdQ2bEBTlhXiV9Jus9oPvvsPKi55HdZxNMXVUugsc25fWGH4lHvB3Umz7O/NndBdTH8W2B8mKuHGFn9To1Is3y2XuXTQBjLGgqB3Ww8INmrH7NbJkvOnD7QtE+aSiEycr0sP6DSqIENKy0umPqLO23AxwUBnWIHmYKbgl7y2y7uNKiTg7ka837yMJBZbQcwANyk6gwDwtUC1VlV2IUL/QA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 22:01:19 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.041; Fri, 6 Oct 2023
 22:01:19 +0000
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
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZ97pKI6hvp9K6YUusBrDLSLOwW7A8uGcAgACZZ4A=
Date:   Fri, 6 Oct 2023 22:01:19 +0000
Message-ID: <45cfd268da63eeddb741e9c9c3026b0e15eade4b.camel@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
         <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
         <4ad40b9b-086b-e31f-34bd-c96550bb73e9@redhat.com>
In-Reply-To: <4ad40b9b-086b-e31f-34bd-c96550bb73e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CO1PR11MB5060:EE_
x-ms-office365-filtering-correlation-id: 9de06923-57d1-4a55-e0ea-08dbc6b7c526
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HtW4vz7cGF6wtolynCNDds/ayiYpyN+WuEyDe38Pfl39aKySbgWmeg1qO0FJ2MaTDLMTAFi+/T/HIzyjHyHv/qCOZGEL7xuq89dvpF0P5vVR/iRJNV/raFOlNp8e1Mx5fV6rjyRNHGoEoQum/2Ke1N2+O8/qsq7DBC2dumn0cAKNwEP+bJ6+disQwep9kUGz19xqxQr+p7SwyEu4Fgv8cQlX1h2n4XPT3QjaKOWTNt1pOB90ghCS/VWwevDh82zodlGEyXWS2/54hlrHgLj58yI46pE9nxdLvEB+6WdqB55xVPWjhijowwxoKuKIYKc8irSkhZPVbM1joIAn48+11QoDgnltkKriGXNDtkvyvZW45uhgLn/s/XqaaZ7C2xxIJ9GHdT1/2F3W3mV9LldChcJ+kKc19kTWvGmo4SHRylgdpQpfjAkMqM4dC3CEs9IqgwAZqytibLU2aAvjx8hOa7LyeafXPKXJ0EkeJ8G0UdFAdgxPpzsS5jeCmfkzsRYKq+d+bxx9JVlJm3PLBxFrlcLlugF9MGOI6qFKl1PzrH7LBd/bq76M3yeu/PouuuBg61MoyU+DKubk1/h0GLBVDXXfXCpRNc3WNXKbamIGMSH3t1Lwc3F8hl8f8UTNmaAS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66446008)(64756008)(41300700001)(66556008)(66476007)(53546011)(66946007)(316002)(54906003)(76116006)(122000001)(71200400001)(6506007)(36756003)(6512007)(478600001)(38100700002)(38070700005)(6486002)(86362001)(82960400001)(83380400001)(110136005)(26005)(7416002)(2906002)(2616005)(5660300002)(8936002)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHBTUTU0bWZCY3J6TWFqaEFSYTN0TzY1WWlmNFhMNVc4L29nWGIrYUs3YW10?=
 =?utf-8?B?U3BUQTlOcFhJdDlVSC8rVHlMRXJLMGZ1NHhWV1h6UzBpaXdQc05VS0pyVERv?=
 =?utf-8?B?bDErdkgyQi84NUhUZGdqcEQvMWhucVY5YWdGbXJqQnhNa1crMm5iN2FsNnd6?=
 =?utf-8?B?TkYxcm00V2NKTWFZbWx2L1lBd0NIZzh6aDJ3MkMxS0FCT1I2enVIdzBVR3N4?=
 =?utf-8?B?N01ja3lSUnBkN3R5ZWpRbFRlM3YxVHRYa3hUWU1jYVZFQkJqR0o1VG8zZUxr?=
 =?utf-8?B?cHdzOXlXZUVTcExBS1Y2SWhzL0EwR3UxWUdYTnhiKzIzNFlaZFFJUWMxclBr?=
 =?utf-8?B?bGM1ekdQWG5RU2kzb3MrWWpmMFpiMVVWQ0I3V2FUUjhTYURiSXpOZXo3QWJL?=
 =?utf-8?B?dkpEMldQT3A0WXphTlVIRHRzS3NGWmNBNTdWcHFGZHFDTDdiQUN1MW9OOXZk?=
 =?utf-8?B?YzZyL2p0VjZRczZybytObEZFbzh4UWp4YVhKVm1FRC9sam1PamE5R2pQSDhi?=
 =?utf-8?B?RENEQ1g5VlJ6aDhvWDdYR3JDOFZjZHU5MTk5dlF3U29OczdSSUlPMUtOd1Fx?=
 =?utf-8?B?bnBTS1lSajhjamV4Z3o4dm5ONlhDQ2dXSXE4S2dqRDBZN0pkenpUSi9zSGlp?=
 =?utf-8?B?Ykp4NzJrYUpjR2RGWmpJR1FnT0F0TVB6Q2plc2xaKzU2OUFzMUljMVBJWDhz?=
 =?utf-8?B?M29MdUx2c0xNZjllN1AxSHYrczZVSHB4QmFrOHh2MndodjVucnlOWUJ0dTlP?=
 =?utf-8?B?UjZUWWowaUROcUk0K2N3WCtuekcxVWJOR0puNzROU3gyb1NhUGhjQVAwWWRh?=
 =?utf-8?B?Ulk1ejRVRzlEczc3K2F6WmdWRkdlbEduZ3NTZ1dFbjhLZU1pMHNZMS8rSGE5?=
 =?utf-8?B?MHhKaEhUbG5XMHFzdXN2dnpIWlRmdXc1dXZTWVFSbW1pckNuWTduVTFVdzJz?=
 =?utf-8?B?T2JiaU5hZUJ1cmxUMkF1NkpZMGFWa2pIVDA4RkFqN3NKOFA4VFpocjNLYU1M?=
 =?utf-8?B?MnVJVHc1aFBwVUZxcUdjWnM2cy9oeXNsVXNrQ0JRZnpMdWVaOFBZcDhwdVhu?=
 =?utf-8?B?SWRsbVArUlNBVWJyVDlHZThpZ1drNm9WenhiVXJpUVZVT0xlcHJsMW5lWmVJ?=
 =?utf-8?B?aDF3cGFzU2J0U3NoaTNnVTN1ai9FTkRhUGIranFCTmZQdW1neHRhTTdFOEZW?=
 =?utf-8?B?YzUxMEhtVERCY1RlTzBvbDhCRFZYdFpNaklOemtPRWErbGZCb3VmL0pVUzBv?=
 =?utf-8?B?VlpqR2Yzb00vdDlYNHZ3UFZRdmJDaFVkZWs2OTRrTmFweERrUFJodDZWT3gw?=
 =?utf-8?B?RkRrc1ZSOTNmNWFnTThjbzA0TTFpZmhZQ1NQbWk0Qnd6ZHRGQy9VRGFNbzVL?=
 =?utf-8?B?REJiS1VYakhHQmhQanZRZkVsOFYvMG5mYVRnY2xEdklxZDF6ZG1oRWtjaXg4?=
 =?utf-8?B?THFVKzRtVFZFckZhQWh5QjZtMjdKNTEzdUhVTTN0aE9PcXg2UzF5VUxqaHky?=
 =?utf-8?B?MDF2bWtVNmM5MjBNMlltajVnYmJDS0NkMWE1R21IbDM3Y3NOUkx3eHNMRjJS?=
 =?utf-8?B?eDc1MGxaKzh0dVQ1V3dVYnU3WnhLTGZPK1dyWVdWQUtEZjRORFRjZWJTakV5?=
 =?utf-8?B?aXhmVDZXc0UyalFlWHhNV0JNbDNld1lZNlphRGp0STJRazBuNmdaL1lhamNG?=
 =?utf-8?B?cG44c2padUI5NHRKQ0dXMG5ieUNLU21nQkQ2NmMzNHpkdDk1eEdoZHcyQy9K?=
 =?utf-8?B?aGtFOFdpNmxCY2huM3ZVQWRITzllWWhlbTFrTlBvZks1MGxENlM5REtYWUJO?=
 =?utf-8?B?VDFiYTlLTXY5T0pBTEYrWkhHYXQ4eE1WSUlOR1RxbnlWQllRWUxnMm9FUys0?=
 =?utf-8?B?ZGI1bzI4dFd2QTB3aEFIaklFUytyZDQ5VmpZMmloSUJ0MVRKa0xucUloMCtM?=
 =?utf-8?B?bGpHbUNXRmVTSmw1VlpKVDA1V2xuaGM3N3dDY0ZubStMRTBaKzA0VGRQaktK?=
 =?utf-8?B?MHV6L2hwRTFzaGJmN002V00xZjU0bmlBR0tLU0VhbkJHYmErWGwvdktLd0RC?=
 =?utf-8?B?VDJKK2tibzY5S2FEQ21qYzhnQkZjdXdSd09ZQW1nVlpBYTNqN2lQVlpSS0lj?=
 =?utf-8?B?ajNOcTNVd1dNUjc0TXpoYnZ5T0JBSEpmcWlSeTB2N2t0bHRkcUlEcmNoZHFL?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <918A316112C5DD4CA425BEB9F72EF4EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de06923-57d1-4a55-e0ea-08dbc6b7c526
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 22:01:19.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRlEQzEqlpp+iyVXyVzgyF7t6+yPeGwJ5Rrtji1tki7QdYNSsI2z4FnO5yoxO4uH66Maenj2PqFyzqkOKIn6NCtu/iFNQEhXenGQQObEzbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE0OjUyICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAwNS4xMC4yMyAyMDozMSwgVmlzaGFsIFZlcm1hIHdyb3RlOgo+ID4gCjwuLj4KPiA+
IEBAIC0yMTY3LDQ3ICsyMjIxLDI4IEBAIHN0YXRpYyBpbnQgX19yZWYgdHJ5X3JlbW92ZV9tZW1v
cnkodTY0IHN0YXJ0LCB1NjQgc2l6ZSkKPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKPiA+IMKgIAo+ID4gK8Kg
wqDCoMKgwqDCoMKgbWVtX2hvdHBsdWdfYmVnaW4oKTsKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKg
wqAvKgo+ID4gLcKgwqDCoMKgwqDCoMKgICogV2Ugb25seSBzdXBwb3J0IHJlbW92aW5nIG1lbW9y
eSBhZGRlZCB3aXRoIE1IUF9NRU1NQVBfT05fTUVNT1JZIGluCj4gPiAtwqDCoMKgwqDCoMKgwqAg
KiB0aGUgc2FtZSBncmFudWxhcml0eSBpdCB3YXMgYWRkZWQgLSBhIHNpbmdsZSBtZW1vcnkgYmxv
Y2suCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBGb3IgbWVtbWFwX29uX21lbW9yeSwgdGhlIGFsdG1h
cHMgY291bGQgaGF2ZSBiZWVuIGFkZGVkIG9uCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhIHBlci1t
ZW1ibG9jayBiYXNpcy4gTG9vcCB0aHJvdWdoIHRoZSBlbnRpcmUgcmFuZ2UgaWYgc28sCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKiBhbmQgcmVtb3ZlIGVhY2ggbWVtYmxvY2sgYW5kIGl0cyBhbHRtYXAu
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1ocF9tZW1t
YXBfb25fbWVtb3J5KCkpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9
IHdhbGtfbWVtb3J5X2Jsb2NrcyhzdGFydCwgc2l6ZSwgJm1lbSwgdGVzdF9oYXNfYWx0bWFwX2Ni
KTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmMpIHsKPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHNpemUgIT0gbWVt
b3J5X2Jsb2NrX3NpemVfYnl0ZXMoKSkgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfd2FybigiUmVmdXNlIHRvIHJl
bW92ZSAlI2xseCAtICUjbGx4LCIKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAid3JvbmcgZ3Jh
bnVsYXJpdHlcbiIsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhcnQsIHN0YXJ0ICsgc2l6
ZSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhbHRtYXAgPSBtZW0tPmFsdG1hcDsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogTWFyayBhbHRtYXAgTlVMTCBzbyB0
aGF0IHdlIGNhbiBhZGQgYSBkZWJ1Zwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBjaGVjayBvbiBtZW1ibG9jayBmcmVlLgo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbWVtLT5hbHRtYXAgPSBOVUxMOwo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIG1lbWJsb2NrX3NpemUgPSBtZW1vcnlfYmxvY2tf
c2l6ZV9ieXRlcygpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU2NCBjdXJf
c3RhcnQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yIChjdXJf
c3RhcnQgPSBzdGFydDsgY3VyX3N0YXJ0IDwgc3RhcnQgKyBzaXplOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9zdGFydCArPSBtZW1ibG9ja19zaXplKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZW1vdmVf
bWVtb3J5X2Jsb2NrX2FuZF9hbHRtYXAobmlkLCBjdXJfc3RhcnQsCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1ibG9ja19zaXplKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmVtb3ZlX21lbW9yeV9ibG9ja19hbmRfYWx0bWFwKG5pZCwgc3RhcnQsIHNpemUpOwo+IAo+
IEJldHRlciBjYWxsIHJlbW92ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcygpIGFuZCBhcmNoX3JlbW92
ZV9tZW1vcnkoc3RhcnQsIAo+IHNpemUsIGFsdG1hcCkgaGVyZSBleHBsaWNpdGx5IGluc3RlYWQg
b2YgdXNpbmcgCj4gcmVtb3ZlX21lbW9yeV9ibG9ja19hbmRfYWx0bWFwKCkgdGhhdCByZWFsbHkg
Y2FuIG9ubHkgaGFuZGxlIGEgc2luZ2xlCj4gbWVtb3J5IGJsb2NrIHdpdGggYW55IGlucHV0cy4K
PiAKSSdtIG5vdCBzdXJlIEkgZm9sbG93LiBFdmVuIGluIHRoZSBub24gbWVtbWFwX29uX21lbW9y
eSBjYXNlLCB3ZSdkIGhhdmUKdG8gd2Fsa19tZW1vcnlfYmxvY2tzKCkgdG8gZ2V0IHRvIHRoZSBt
ZW1vcnlfYmxvY2stPmFsdG1hcCwgcmlnaHQ/CgpPciBpcyB0aGVyZSBhIG1vcmUgZGlyZWN0IHdh
eT8gSWYgd2UgaGF2ZSB0byB3YWxrX21lbW9yeV9ibG9ja3MsIHdoYXQncwp0aGUgYWR2YW50YWdl
IG9mIGNhbGxpbmcgdGhvc2UgZGlyZWN0bHkgaW5zdGVhZCBvZiBjYWxsaW5nIHRoZSBoZWxwZXIK
Y3JlYXRlZCBhYm92ZT8KCkFncmVlZCB3aXRoIGFuZCBmaXhlZCB1cCBhbGwgdGhlIG90aGVyIGNv
bW1lbnRzLgo=
