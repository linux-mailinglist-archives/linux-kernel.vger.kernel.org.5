Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1772F7B7579
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjJCXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjJCXsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:48:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2CAC;
        Tue,  3 Oct 2023 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696376919; x=1727912919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=No1LP/jo2SJe9VV1zxBK2gc0n240AA88bK3FPaiUPvE=;
  b=LTy82diPkF/Dpu0wXKE5t2W+cHXOP+qt5XG0sxPvDlZnm6ocijjWN5As
   cx2cp9AI/6/xSi2M8UM/l7RITVM/j/sFWP1ZIEd4Xhk76kGfLW6i7WItV
   64wMTXcy2lFLt+0Fx6UruWQXTYXms0mQceK/pgQI7nSeXEGW0rBs4Syv4
   W9wGVdRDw/JQNZOYoVIAYewJ4dFDIUXcxmQsNIH5aBn4D5fdaSvgt9y5Y
   YCzqOf8MBv0y64UcBkptn2VC8dibfwk+L/uddlSFHJ5TTTsleyPr0C7D8
   RgHmR4IXuR+ThtlvtalLDhiVX7qvun80cG9WvhC1gpjkZz3oPAx95PxfX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368059732"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="368059732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 16:48:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816889708"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816889708"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 16:48:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 16:48:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 16:48:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 16:48:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 16:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7C6McdxWAeOocYxfjUFEO7T/Mc3JU0SZFQ+pNRcmdZVe3FdNpxFTDOVsPcICIsXYjhPy7f990ar2npvpnr0k2354vdfaLEcntYEGWDcQWRwx9q/8IXHm2YzyYQ9DbVSrc0oxOL2duF/pbD5YFc93dUwRWXyQ0iOB9QFT5gbPLa6ZwzFDX0Q4Qv2ZM7S7Z6bYqsPVd3JvJyu/z+tzY9TZG55ltxOvdzizs5Q//FTAfQbtZ9f7TCsLUhcVCnvFbs9k3QxRseSyhEjlDRNz3ELoE0FMj6z9Zmb2/BYxo2L3ptjz03UaNZIk0TCJ/fDYNlX+RNEYcTx5h8s2wb7btx/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No1LP/jo2SJe9VV1zxBK2gc0n240AA88bK3FPaiUPvE=;
 b=lgmA4kDzQOdvK5nSNRNoBZvDo0mKq/0eEhtndmiq7pUJkV1oNMMdp8O8eHL1niFMy0ffpWR2Z25Fp4CPFQmV+Bdi2E0+Sz/bBE3z8myoKklQPe+47Gx8y2D+PlqTW6XkdkJ2BSacgKSFIycUHrzgj8FvywQ69a8Wylxj+/eDgPptn7GYb2v4bt7NSBtR155hZIydUrpIE8FZmoM/OSmBkYJQl8elVmDjiZjF7qpT88qnLZgDJjM/QkoVdw5Np3yMriR3yBFLU+Qd4wN+OuLkJRei4hAaVrusvYcD6AcvH4ariTI63rSntqAJtu6ET54S+o/3XpUaGxu+W6tHZhRi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CH3PR11MB8704.namprd11.prod.outlook.com (2603:10b6:610:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 23:48:33 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::3693:a1b6:b431:4827%3]) with mapi id 15.20.6813.035; Tue, 3 Oct 2023
 23:48:33 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Hocko, Michal" <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Topic: [PATCH v4 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Thread-Index: AQHZ8kqtEO0iwKFmMUakr9hUYtseybA3eMGAgAFK44A=
Date:   Tue, 3 Oct 2023 23:48:32 +0000
Message-ID: <e1600e8d3986b1ed371847d4863628b8d7ad2091.camel@intel.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
         <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
         <73bdc58d-edc1-4344-b42a-4b83ca885329@linux.ibm.com>
In-Reply-To: <73bdc58d-edc1-4344-b42a-4b83ca885329@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CH3PR11MB8704:EE_
x-ms-office365-filtering-correlation-id: b2e09d21-f59d-464e-a72d-08dbc46b40c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NQJTA3duiEO4Q78S4dUL4WzRI75tQyWDX9M/Vqrz95579bDSWDf38Lwx2vT4h6RqP2fdMIc6t8qrUC57TZi+ebtLcQ2fs7M+8O48li3w6cOD8N9EbS8IiRha5wfUqzgd8LTCYi7+80ErDKDngk8Z3dmzSZrVDybY352r0x/cRS/XaMELNh7PAAuTBRc3YLDpOTeN7jgjJYrbYN8Vm62hRB+q6lQ4rYUyVkpE/4SvICkpZGmQPaS36IAjrJVNT7HbkEKFyQwt2KXS8/SpM7dvMHqo4PAJJSzcC1Ck8R770GrAx1QvICa5BQ+r3QFkspnXhG83+G3eVFfRgB1+ioWW24OKJhDx+w8/tCMgnDDjrTksFUYAxZ3wab1NK3d9QX7yTRbeIcvnaJPnEnsIHbKnA9lfAu2M6Fb0WqaTK77TmtFRh4V+9XXPt49rSuVYAnb7WNf4fxzw6kTQ7xF0Tq1HYRG4YjfdPiZE3xbY2DFZtKBpg8vXM8vJgRfnSivaX5NyX17m6sql6EnE7Lnnork36MAqJuVbh471gt7GZ3dI2WvZikVuk8ipPZRt6j3QJ+K/MEQBIitglHQsQY9AiPQPZl4T9GHk+R5T5Sf9m3uBQx0pflkeyk7yVfZ7roQxKiU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(478600001)(6506007)(53546011)(71200400001)(6486002)(83380400001)(26005)(2616005)(2906002)(110136005)(82960400001)(7416002)(41300700001)(66946007)(66556008)(76116006)(66476007)(54906003)(8676002)(64756008)(4326008)(316002)(66446008)(5660300002)(8936002)(36756003)(86362001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJqMHREL3ZNZzljZnpxa05nRWlnRm1DZVVVMDdqaUNHWDJGUUYwbEFkRngr?=
 =?utf-8?B?SWhTNnJYaDNiR3pIRXVNMllWWE9NYit2dUVOS1lycFZza3FoQ2lvY2FTczRp?=
 =?utf-8?B?aG03aE9FU1djVHhBNzFHYngzNTJiTjlMYm1aVU12SHFBTzU1Mm5KMWVFc0pQ?=
 =?utf-8?B?QkRCK1VoSk5DSThhaEZXMzV4WWFjWXY0WWg5eitMQ1NPS0d3VTIyU3ExMHpS?=
 =?utf-8?B?eTdUaTF0QnlHWVIxbUp4dmR3L3RuM05KVS9XME5HZUdoaWh1cldPR3lsclZK?=
 =?utf-8?B?N1V3dHFEOU9SODVBQk84S1B6cENIVm95WXpUenZYTVdNY3NuSDZ2ajk0M0dp?=
 =?utf-8?B?OWM4emtQVkFWVDhGK1UxTldJYW12dTR0Qy92a1VQYU5SdXlSLzd5b3R4ZFlU?=
 =?utf-8?B?ejZTQmllalNoS3BaUndtWERBWk5WTTJLZHpPam1tenVnQzFwYm10QktCdi81?=
 =?utf-8?B?T3N3R09WZTY5Vm94QjJ3NUdtRVdQLzJ6Q003V3RZQ2ZGa1RBYWF6ZHR2eEFZ?=
 =?utf-8?B?SjdWdys5dzJMU1FvSzh6WGJsdFdRdGlKck8yTUFOSlRoWVlPZnR4UTU3TGd2?=
 =?utf-8?B?SFc3Mmttc2hDeHE2OC9XVEVnK25hWVdqdjl3Nmh0Q3c4UlJRMW1BTS9iWW9W?=
 =?utf-8?B?WmJLTktaaWFobHdIRUVHRzN3TDA5YmVNL2d3ZmtuM3BmV1B1RTA3MGJLMnZR?=
 =?utf-8?B?SWlTUk9SSjFnQVFtMEJVekZLS0xMckJ0eGRoeTVEalFWVGFFVFR2WW9MeWdH?=
 =?utf-8?B?NXFTOXpTMHlFK3VJUk5Va1dBNCtGTnpqSGgxVktaZ204MnN2cTdza3BNRjFh?=
 =?utf-8?B?bW5OK0RVYmw1SjNlenZwRHJsNHdlcnZPcHRRMnVsTE1BK2N1YWtnWHBnUGZx?=
 =?utf-8?B?a29DREF2TVJVOGZaY1VtNi93anAvd1pBbU9JN29Lc3lueSswV0Ewckk1blVR?=
 =?utf-8?B?TyttRVc3SkI0V05SdkozejdwSEhHdnRBSTNyVjVIM1NJdHA2NVkyU0Q4UHds?=
 =?utf-8?B?bFBQTVRwdTNoZHMxYk5aN21QQU5OZXJKVlVwczZ5YXpRL000Qzk4WEFZTzdQ?=
 =?utf-8?B?RUZaY1BocW8zenR4UlA1Wko4MjBwekdHOFkzdnhPMHB6VHRlalAya0lvenBh?=
 =?utf-8?B?QmtYNWtFRzlIRnpTenFyOUhvOTVYTTIwTXR1K2EydXJOZXRuc2VjMGFHeFQ3?=
 =?utf-8?B?elR4NGlzUzRBWEZMZ2NtblBQclNEZjN1TDRaT0pCWHdtd0hlVlJQc1NVVk9y?=
 =?utf-8?B?SUp4YzRVVGNKRC9IZU1LSWpqZFo2U3RDMVM3ZVcrTkZ0dGxQQWhKbTJlWUE0?=
 =?utf-8?B?bHpOdXBGNEJFcU04Q0JkZmxLL1MwYlFRRlQwampMZXFFVmtuWE94NU8rTnAy?=
 =?utf-8?B?S3p0ZWExZEw0cTJtTU9mWENzYjMvV0wyMkdOY1RtOXdIcGYvM2NJT1dYTE0w?=
 =?utf-8?B?VTFqZFg2aGVjK2lSak9Sc0RnZW1IbXA3bXI3ZVZ5NlVCMjZBb1dhTG52cnpI?=
 =?utf-8?B?R3BGSkxMTitadTlVZFozUTNSY1NwdHlscVoxNGVHUG13aGV6NUF1VWY5OWpq?=
 =?utf-8?B?bGd1ODdBWmFZMkhCVDhGWXM3T3RBZnVjY2phOVBveEdyV1FDKzliSGF0dEJO?=
 =?utf-8?B?dk1RMUh0SkpuSHZmOWhyNGV6aDFZamI0OWd4RnltUFRZMVdIRkRheEVHYTdv?=
 =?utf-8?B?ZXRNNXdXcDNUNUVTUWJJRkgyajdlUWRFWWxCcC9KR1ZaM0Z5QWhYQU52bkhK?=
 =?utf-8?B?VEEyTzJBRnFZUTkrMFhpVnhNT2pwNXN0bGZ1dVQ1Z1pPUzltZXBBN1hYK3U2?=
 =?utf-8?B?ZHJ1cXZ0VVprdWJiWEpORFNqaGNNR3p0Q3hkM00wZ1dtMTIxN3orQnowRDhV?=
 =?utf-8?B?VHNHMWRFUitHZjVRME1VVWZnRWZXRzNMK0ZXNyt2U3lDYUc2ODFkMVpXaitD?=
 =?utf-8?B?SW5nclp3QjNESy9uYXpOWlBtTlNwbjFDRzVjNVZraDRjY2FiUEwyQUkzTFla?=
 =?utf-8?B?azJRTXVwbjVlVjZEeHU5Y3JzT3EwaUxMZXY3ek8rUkFzT1hSS2twV2lyTlh5?=
 =?utf-8?B?S284NytBOE55TDNqNzVrYk9xeDRwN1lNdU9vTmRpZCszaGlCaklxZ3UwbFY4?=
 =?utf-8?B?SnJ4MkE4Z0k3UEF2OFhwcnJyb3ZrOVF2ekpRZXBTd3Y3TG5iaGtBVzRJdkdq?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C208168B6F4044A9AE49BEB4A8B34E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e09d21-f59d-464e-a72d-08dbc46b40c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 23:48:32.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riM2WTv3bhKRcEI8nbz7PIjlAg/nmRrFdfFBBmK9hLbsuB6FQFQX+OS9Q+jTbPA2TmiJn5R2WPue5j73tSNmGnPyTtkgZUjSXU+xclDvcKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTAzIGF0IDA5OjM0ICswNTMwLCBBbmVlc2ggS3VtYXIgSyBWIHdyb3Rl
Og0KPiBPbiA5LzI5LzIzIDI6MDAgQU0sIFZpc2hhbCBWZXJtYSB3cm90ZToNCj4gPiBMYXJnZSBh
bW91bnRzIG9mIG1lbW9yeSBtYW5hZ2VkIGJ5IHRoZSBrbWVtIGRyaXZlciBtYXkgY29tZSBpbiB2
aWEgQ1hMLA0KPiA+IGFuZCBpdCBpcyBvZnRlbiBkZXNpcmFibGUgdG8gaGF2ZSB0aGUgbWVtbWFw
IGZvciB0aGlzIG1lbW9yeSBvbiB0aGUgbmV3DQo+ID4gbWVtb3J5IGl0c2VsZi4NCj4gPiANCj4g
PiBFbnJvbGwga21lbS1tYW5hZ2VkIG1lbW9yeSBmb3IgbWVtbWFwX29uX21lbW9yeSBzZW1hbnRp
Y3MgaWYgdGhlIGRheA0KPiA+IHJlZ2lvbiBvcmlnaW5hdGVzIHZpYSBDWEwuIEZvciBub24tQ1hM
IGRheCByZWdpb25zLCByZXRhaW4gdGhlIGV4aXN0aW5nDQo+ID4gZGVmYXVsdCBiZWhhdmlvciBv
ZiBob3QgYWRkaW5nIHdpdGhvdXQgbWVtbWFwX29uX21lbW9yeSBzZW1hbnRpY3MuDQo+ID4gDQo+
IA0KPiBBcmUgd2Ugbm90IGxvb2tpbmcgYXQgZG9pbmcgYWx0bWFwIHNwYWNlIGZvciBDWEwgREFY
IHJlZ2lvbnM/IExhc3QgZGlzY3Vzc2lvbiBhcm91bmQNCj4gdGhpcyB3YXMgc3VnZ2VzdGluZyB3
ZSBsb29rIGF0IGRvaW5nIHRoaXMgdmlhIGFsdG1hcCByZXNlcnZhdGlvbiBzbyB0aGF0DQo+IHdl
IGdldCBjb250aWdvdXMgc3BhY2UgZm9yIGRldmljZSBtZW1vcnkgZW5hYmxpbmcgdXMgdG8gbWFw
IHRoZW0NCj4gdmlhIDFHIGRpcmVjdCBtYXBwaW5nIGVudHJpZXM/IA0KPiANCkhleSBBbmVlc2gg
LSB3YXMgdGhpcyBvbiBhIHByZXZpb3VzIHBvc3Rpbmcgb3Igc29tZXRoaW5nIC0gZG8geW91IGhh
dmUNCmEgbGluayBzbyBJIGNhbiByZWZyZXNoIG15c2VsZiBvbiB3aGF0IHRoZSBkaXNjdXNzaW9u
IHdhcz8NCg0KSWYgaXQgaXMgZW5hYmxpbmcgc29tZXRoaW5nIGluIENYTCBzaW1pbGFyIHRvIHRo
ZSAtLW1hcD1tZW0gbW9kZSBmb3INCnBtZW0gKyBkZXZpY2UgZGF4LCB0aGF0IGNvdWxkIGJlIGlu
Y3JlbWVudGFsIHRvIHRoaXMuDQo=
