Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6347E739A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345241AbjKIV1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKIV1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:27:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6776A3C0C;
        Thu,  9 Nov 2023 13:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699565269; x=1731101269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oNATuXTPYRA3JLyDAYQApd82A5zqV+pLXyTw5AUoFVI=;
  b=m6BjHLi09AGxEVaMQST0kKqNOUYNQfFt+KsT9rE+f164ESS2gKuwZwA1
   Kado3a//7wlQ0CjYs8uNbOjt8igbkqDTyRtq8Uhk5yLs2TOAAS6r4fuPF
   Sfsi5lp5Qm6AkSh0PISvkacEsjxUBzKWG3b/8N90+pHcTS7PRuiNTXdQ/
   T7aknK32TWsSxBzyanTiKnTIEVDZH4gw0yRSkkKaZkkxc+r98tkYqdB9V
   fxMeFDy6boDHdHw2NtlFxvzk8KdQl0tQXHGxgjbUNj2FR+1WuIux+vC67
   M4v4BnrEXR2sQBq4gSNWNAWu04ziZ3E9gEykuZzpwdcm2Fj3P/na+zfk/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456570526"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="456570526"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 13:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="854196599"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="854196599"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 13:27:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 13:27:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 13:27:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 13:27:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN6L5jjmvjhlmDycnkm7h4x1EnxTq/Bwgyzcj5RLpZQTp3PlBa+ld6eHovMO1iOa2TTPV4AmLiJzjMh1y/6ZbUsvXcNbLAgRG/s66LxTxd80ssfSOquNSPIWJb4hMFY0/+eJgwkvtDt9RR5pFFNJ3NRqLwG64IbvrbMoOxAkZsXg/QrjKKypDx8zQqNZQAX9J1zbNiYvor24CDv68h5NExrNL6YXN+zmeVRqBIN4bTQUBSzTWdR4QQU82MVTjRsque9ueMJtMitJSyMdlwHFtHbVuKUYO56W1g/CvSlLrR7RFf7JNMMdqfoYYA+6EkJdPC99BRINU80ftPiWNitVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNATuXTPYRA3JLyDAYQApd82A5zqV+pLXyTw5AUoFVI=;
 b=aXcEZfb+XCxJsq2eV2osnDh05btReSF86td68z3GZvPyemHwni69tV189aK4CiDmOP5xhYrhgL94hstBZ517VGCKIhwbvxgjanz62+UE3svF6Ckcv55vERnHmtXXe5xU8LeIWDbA+lIwBt8xtJdc6Zn++0tcUI0+8neSOPe7/YNIrPfmhEzxmsHf7xGC69Su0/+VAiHI3o4mxkQtiOY8LuIfmRss2HP3mYKQNZb7vKtZMNkapwWuaRcDnJsxDJr1c2epKfCl/bxWQxsIadyF2Tzy5Cdh4ZG8V005xF1vB4uys49p4E4QIDvqkYGUgje7VTSvED8CaHEETuCCwhzHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 21:27:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 21:27:45 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Thread-Topic: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if
 local b/w unavailable
Thread-Index: AQHaCEddvpO8kujzW0Wys14hXinuwrBpLPGAgAfdcLKAAX/+IA==
Date:   Thu, 9 Nov 2023 21:27:44 +0000
Message-ID: <SJ1PR11MB6083F3355446B7879177A1FBFCAFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
 <ZUqo+MsEQi2Xc/pO@agluck-desk3>
 <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
In-Reply-To: <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB6351:EE_
x-ms-office365-filtering-correlation-id: b1d57771-6149-449e-17ad-08dbe16ab6a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pr9JW9CeXV51dmBAPcrDpaUvNL/QKNyuK/Qt67JpXitrxeJGYtK58G/edBjuhlu7y10/lxv38iqyRgCs3odySaB15npWbu+l4kct8ggmJ0ZKdoiZ3B3MYJ2aaODV7nUOwZUsAED3L0eO5weSnpZZuLegpQVfoCU7WOuOZKJwg8PLtfTTsRWCl5TvCWjb84P191VImrscHJlC1eZ1n/9vtyLmIoC5RHPgocdplnKAfmFFGBWEjn9hSa4gviNCfWl/J8cuH45KGJrOoKjaGxvba5Jdwtiq8wCcUZ+Himd10eZ1m4INRFEia93OGJOmjqHw7N+MU+G7ObYOoo6qhzE1M1Wm+js+2boa5et34+0HsEnKsMQ7tZPxhicUqyMUlhwUx30Ygs+FMZFFOk8HlKlhiEDTVgCyRoJZUcJ+2b3SB9KcsXl6sWodpRkz5Xd7cIeEdeYVK+YQxNWInkkUvN5+ArKtGqxGGdPubM4PtxPAgE85GHrKMIpRRcgIlDSNegbucvSHtqubrfFl/yC2UbVVAsGCXV0h0loPqQBbdwVoxqx7uLOTvn0T+siaVoOgisq5EU4tvoC1AjESxnvDZtMJu441f96hSuGsHSptIHB+6W7Tjp3Q2Is/JswRXVKd203c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(82960400001)(71200400001)(122000001)(41300700001)(7696005)(6506007)(478600001)(2906002)(33656002)(9686003)(7416002)(38100700002)(26005)(86362001)(38070700009)(5660300002)(52536014)(6862004)(76116006)(8936002)(4326008)(8676002)(6636002)(316002)(66556008)(66476007)(55016003)(66446008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJVNFA4enFvNHk5MGxaTkVyL2tFWmxrTFpSSldKRHRwUy9oVXpCLzN3RkEy?=
 =?utf-8?B?NW84b1lseFlQU2xQMkdLRnJYSUc1R2hQSHErYmZlWEROZnlSY0FDMWhCSnFL?=
 =?utf-8?B?NFFEak9pb1gzVE81NE4wclpUaEhKOVFnbmhLbG9yMkh4ZjlGTmRrMWp2UzFL?=
 =?utf-8?B?WkRPd3BmVWJuSHlLbWU1L1lzNWdSa3llTnNuMkw4Vk1nZHpoOW5YelBqLzVR?=
 =?utf-8?B?OE1rcXBua3VyRzNCcUM1MjdWbWxUTFBNbCtqaGpHSlhMRHMwcDZvZEtmUjVW?=
 =?utf-8?B?TDg5ZG8wcWhPdUUzWEgvaC9TdlRwMnlob0VyN2dCZ0Zmb2ZncW5DSTYrZnBn?=
 =?utf-8?B?V1pEWnBtRWF5Sm8zZllvOGdPRXErMzJibllEQ005VWxnMXoyYUl2U0xBSlBG?=
 =?utf-8?B?Tjl3dmNKUGc5Vm9IOVZZaUpaSUEydTJPaVN5dVc0ZjJDYmFUZTIyZkFTY3F2?=
 =?utf-8?B?dTY0azlaTkVOU3FwYzl4b09HS3FIN2RpNEMzVnRSeHIrVUZlbThSR1ZaQ2FU?=
 =?utf-8?B?blc1TXljbW5vN1RNaFl5QmxTVGw2OUREQWNDOE5wNEFWM1RBR0xONEZiK2JN?=
 =?utf-8?B?OFZDUis0VlJlaUp0aGZ3dDB6Q1laUGpGVEUzb3BuU3FhdW0wSUs3bVBWL3Rx?=
 =?utf-8?B?bWxkWkhDRVJyTkZrakJ3c3RxdG1yUlQwTHR1d0p1SmZnQUNJUmM5MFp1cXEv?=
 =?utf-8?B?bkpnaVNHRmd6VGE2S3JQaTFlVWZnZk1xdDF0RjNuWklFU2VqRHlhRlAyb280?=
 =?utf-8?B?WDc1VXFYbjBzUUtYcytKbmkyU09jSm9WM3g0bjFqcjU5ZjN4UmIxOWgwMUoy?=
 =?utf-8?B?Z05zT2lhWnpkL0MzZDRJY0NicE5QdUlnNXpjTHEzOWFNdFhNcFYzV3Y2SXVP?=
 =?utf-8?B?NmJwckVJdVVyTDB4cjFkREtlbWpTK0lwNkhIaHNlQjdhVWQzY0M1T2hvTTBS?=
 =?utf-8?B?Y0NoMTdSZStrUFN3dFQ1dUd6YWE2a1I1eUpVZG5lOHZHSFUrZ3FJR2JPcG1O?=
 =?utf-8?B?RVhUdHA5YnpRVWFQcUZKU1pXQWtQZW9FY0pVZ1Z2ZVdKd1p3bzlIWCtoTFU4?=
 =?utf-8?B?R2NkT2hCeTVhOTFUc1lCaVdjcjNmUS9XcGxjRHdZZ0wvNGFhS3Z0NzQ3TmZB?=
 =?utf-8?B?QkVlUS91bnk2ZU4vWk1KLzVoMUJMV2pTbDJwL0pBa1lkRzI2NWVRVWNNd05B?=
 =?utf-8?B?Wm5mNmRia2FzWU1QUXVuSDVJSzVEZTVGYlJaSEZLNVYycEVWMDh1V0xBUENM?=
 =?utf-8?B?cDMrWDEveHBtRzJNMWZ2VUZodUhxZFZWS2RHV0x6MkltWWF6VjN1M0dFYVMr?=
 =?utf-8?B?aFdxd3pKc21VSGZ5YktxTmZwNVA4dFJjaUNXMFVUZFhHRnIzNldXb2R4OGJ4?=
 =?utf-8?B?WWRUa0o1d2V6Qms5L0NySWFFS2NXZXNMdVhvdTlLMDd0dVNjWjQ0cFRpOXpZ?=
 =?utf-8?B?N0NUM2dRRmlkckF3bHNkYy93OHg3N29JRTJ2dUgwMlQ1bS9meXp4ZG1DTzZQ?=
 =?utf-8?B?aHBOUUJSMVprdUVxeWQzV0VJUnlIVlR2T0pZWUl2WEowZk82aU15c2w0UXNC?=
 =?utf-8?B?My9JeXZGa29SOHpOQ3hMMDVZYTFCME9oZjYzcmczaWNuOUswdDBHYkRWQ3Rr?=
 =?utf-8?B?V3FkaVV6aTJ0ZnFCandEWVRjMUZ1SmV4NGZrU0I3WmdIZnZzRFlmY0JVWmtr?=
 =?utf-8?B?Zk9HbG9Zd0Nmb1JGNlEvQ2RxZFd2Q2F0OUdlSXpQbi8xRTZoYXgvTDE0MTVW?=
 =?utf-8?B?SFdNeWdjRlo0UExBSTZmczZxQWU2dXdwRmlDL1FmTmpsMXZPbzhYNnVmTWhp?=
 =?utf-8?B?SHZwQ1hxZFNKWFpBOFdJc1RSbHEyS093aHpJVUNHNFpiQ05VQm90d0FKR3JY?=
 =?utf-8?B?TlhBNUJ5VmloUXoyandEMU5ab0tMRlB0aWhpclJtandUZGN5dXdJMkYrSmcz?=
 =?utf-8?B?UDhSOXBvb05Ha3lVWG5LWDZpaFI0bXJmQ0duTFAxakxxcERKY1FMR2dZSmtk?=
 =?utf-8?B?TnpoNldzOVl6ZVZyVXZUb0N3YnB3OE1saXJNU3FyZkpuRWh6d1hZVlB0R2hV?=
 =?utf-8?B?d1hNa1hyOHFWSVlmYzhpV3B6VFZlM3JLYys1QWNocUJ5YnpBSStzZTZqbzkz?=
 =?utf-8?Q?+V9b844kBdLhHOTr6R3PmdS/6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d57771-6149-449e-17ad-08dbe16ab6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 21:27:44.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfKjKCZN2mB2vf31SvO7051O1779dBmkgljlIf0sQ44JfMAtu2RoXQTC+1qBuq12Wwd0synuul8aJhZy2ERHow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTWF5YmUgYWRkaXRpb25hbCBhbiBtb3VudCBvcHRpb24gIm1iYV9NQnBzX3RvdGFsIiBzbyB0
aGUgdXNlciBjYW4gcGljaw0KPj4gdG90YWwgaW5zdGVhZCBvZiBsb2NhbD8NCj4NCj4gSXMgdGhp
cyBzb21ldGhpbmcgZm9yIHdoaWNoIGEgcmVtb3VudCBpcyByZXF1aXJlZD8gQ2FuIGl0IG5vdCBw
ZXJoYXBzIGJlDQo+IGNoYW5nZWQgYXQgcnVudGltZT8NCg0KSW4gdGhlb3J5LCB5ZXMuIEJ1dCBJ
J3ZlIGJlZW4gcGxheWluZyB3aXRoIGEgcGF0Y2ggdGhhdCBhZGRzIGEgd3JpdGFibGUgaW5mby8N
CmZpbGUgdG8gYWxsb3cgcnVudGltZSBzd2l0Y2g6DQoNCiMgbHMgLWwgL3N5cy9mcy9yZXNjdHJs
L2luZm8vTUIvbWJhX01CcHNfY29udHJvbA0KLXJ3LXItLXItLS4gMSByb290IHJvb3QgMCBOb3Yg
IDkgMTA6NTcgL3N5cy9mcy9yZXNjdHJsL2luZm8vTUIvbWJhX01CcHNfY29udHJvbA0KXSMgY2F0
IC9zeXMvZnMvcmVzY3RybC9pbmZvL01CL21iYV9NQnBzX2NvbnRyb2wNCnRvdGFsDQoNCmFuZCBm
b3VuZCB0aGF0IGl0J3MgYSBiaXQgdHJpY2t5IHRvIHN3aXRjaCBvdXQgdGhlIE1CTSBldmVudCBm
cm9tIHRoZQ0Kc3RhdGUgbWFjaGluZSBkcml2aW5nIHRoZSBmZWVkYmFjayBsb29wLiBJIHRoaW5r
IHRoZSBwcm9ibGVtIGlzIGluIHRoZQ0KY29kZSB0aGF0IHRyaWVzIHRvIHN0b3AgdGhlIGNvbnRy
b2wgbG9vcCBmcm9tIHN3aXRjaGluZyBiZXR3ZWVuIHR3bw0KdGhyb3R0bGluZyBsZXZlbHMgZXZl
cnkgc2Vjb25kOg0KDQogICAgICAgIGlmIChjdXJfbXNyX3ZhbCA+IHJfbWJhLT5tZW1idy5taW5f
YncgJiYgdXNlcl9idyA8IGN1cl9idykgew0KICAgICAgICAgICAgICAgIG5ld19tc3JfdmFsID0g
Y3VyX21zcl92YWwgLSByX21iYS0+bWVtYncuYndfZ3JhbjsNCiAgICAgICAgfSBlbHNlIGlmIChj
dXJfbXNyX3ZhbCA8IE1BWF9NQkFfQlcgJiYNCiAgICAgICAgICAgICAgICAgICAodXNlcl9idyA+
IChjdXJfYncgKyBkZWx0YV9idykpKSB7DQogICAgICAgICAgICAgICAgbmV3X21zcl92YWwgPSBj
dXJfbXNyX3ZhbCArIHJfbWJhLT5tZW1idy5id19ncmFuOw0KICAgICAgICB9IGVsc2Ugew0KICAg
ICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgfQ0KDQpUaGUgY29kZSBkcm9wcyBkb3duIG9u
ZSBwZXJjZW50YWdlIHN0ZXAgaWYgY3VycmVudCBiYW5kd2lkdGggaXMgYWJvdmUNCnRoZSBkZXNp
cmVkIHRhcmdldC4gQnV0IHN0ZXBwaW5nIGJhY2sgdXAgY2hlY2tzIHRvIHNlZSBpZiAiY3VyX2J3
ICsgZGVsdGFfYnciDQppcyBiZWxvdyB0aGUgdGFyZ2V0Lg0KDQpXaGVyZSBkb2VzICJkZWx0YV9i
dyIgY29tZSBmcm9tPyBDb2RlIHVzZXMgdGhlIEJvb2xlYW4gZmxhZyAicG1ibV9kYXRhLT5kZWx0
YV9jb21wIg0KdG8gcmVxdWVzdCB0aGUgb25jZS1wZXItc2Vjb25kIHBvbGxpbmcgY29tcHV0ZSB0
aGUgY2hhbmdlIGluIGJhbmR3aWR0aCBvbiB0aGUNCm5leHQgcG9sbCBhZnRlciBhZGp1c3Rpbmcg
dGhyb3R0bGluZyBNU1JzLg0KDQpBbGwgb2YgdGhlc2UgdmFsdWVzIGFyZSBpbiB0aGUgInN0cnVj
dCBtYm1fc3RhdGUiIHdoaWNoIGlzIGEgcGVyLWV2ZW50LWlkIHN0cnVjdHVyZS4NCg0KUGlja2lu
ZyBhbiBldmVudCBhdCBib290IHRpbWUgd29ya3MgZmluZS4gTGlrZWx5IGFsc28gZmluZSBhdCBt
b3VudCB0aW1lLiBCdXQNCnN3aXRjaGluZyBhdCBydW4tdGltZSBzZWVtcyB0byBmcmVxdWVudGx5
IGVuZCB1cCB3aXRoIGEgdmVyeSBsYXJnZSB2YWx1ZSBpbg0KImRlbHRhX2J3IiAoYXMgaXQgY29t
cGFyZXMgY3VycmVudCAmIHByZXZpb3VzIGZvciB0aGlzIGV2ZW50IC4uLiBhbmQgaXQgbG9va3MN
Cmxpa2UgdGhpbmdzIGNoYW5nZWQgZnJvbSB6ZXJvKS4gIE5ldCBlZmZlY3QgaXMgdGhhdCB0aHJv
dHRsaW5nIGlzIGluY3JlYXNlZCB3aGVuDQpwcm9jZXNzZXMgZ28gb3ZlciB0aGVpciB0YXJnZXQg
Zm9yIHRoZSByZXNjdHJsIGdyb3VwLCBidXQgdGhyb3R0bGluZyBpcyBuZXZlciBkZWNyZWFzZWQu
DQoNClRoZSB3aG9sZSBoZXVyaXN0aWMgc2VlbXMgYSBiaXQgZnJhZ2lsZS4gSXQgd29ya3Mgd2Vs
bCBmb3IgdGVzdCBwcm9jZXNzZXMgdGhhdCBoYXZlDQpjb25zdGFudCBtZW1vcnkgYmFuZHdpZHRo
LiBCdXQgSSBjb3VsZCBzZWUgaXQgZmFpbGluZyBpbiBzY2VuYXJpb3MgbGlrZSB0aGlzOg0KDQox
KSBQcm9jZXNzIGlzIG92ZXIgTUIgbGltaXQNCjIpIExpbnV4IGluY3JlYXNlcyB0aHJvdHRsaW5n
LCBhbmQgc2V0cyBmbGFnIHRvIGNvbXB1dGUgZGVsdGFfYncgb24gbmV4dCBwb2xsDQozKSBQcm9j
ZXNzIGJsb2NrcyBvbiBzb21lIGV2ZW50IGFuZCB1c2VzIG5vIGJhbmR3aWR0aCBpbiBuZXh0IG9u
ZSBzZWNvbmQNCjQpIE5leHQgcG9sbC4gTGludXggY29tcHV0ZXMgZGVsdGFfYncgYXMgYWJzKGN1
cl9idyAtIG0tPnByZXZfYncpLiBjdXJfYncgaXMgemVybywNCiAgICBzbyBkZWx0YV9idyBpcyBz
ZXQgdG8gZnVsbCB2YWx1ZSBvZiBiYW5kd2lkdGggdGhhdCBwcm9jZXNzIHVzZWQgd2hlbiBvdmVy
IGJ1ZGdldA0KNSkgUHJvY2VzcyByZXN1bWVzIHJ1bm5pbmcNCjYpIExpbnV4IHNlZXMgcHJvY2Vz
cyB1c2luZyBsZXNzIHRoYW4gdGFyZ2V0LCBidXQgY3VyX2J3ICsgZGVsdGFfYncgaXMgYWJvdmUg
dGFyZ2V0LA0KICAgc28gTGludXggZG9lc24ndCBhZGp1c3QgdGhyb3R0bGluZw0KDQpJIHRoaW5r
IHRoZSBnb2FsIHdhcyB0byBhdm9pZCByZWxheGluZyB0aHJvdHRsaW5nIGFuZCBsZXR0aW5nIGEg
cmVzY3RybCBncm91cCBnbyBiYWNrIG92ZXINCnRhcmdldCBiYW5kd2lkdGguIEJ1dCB0aGF0IGRv
ZXNuJ3Qgd29yayBlaXRoZXIgZm9yIGdyb3VwcyB3aXRoIGhpZ2hseSB2YXJpYWJsZSBiYW5kd2lk
dGgNCnJlcXVpcmVtZW50cy4NCg0KMSkgR3JvdXAgaXMgb3ZlciBidWRnZXQNCjIpIExpbnV4IGlu
Y3JlYXNlcyB0aHJvdHRsaW5nLCBhbmQgc2V0cyBmbGFnIHRvIGNvbXB1dGUgZGVsdGFfYncgb24g
bmV4dCBwb2xsDQozKSBHcm91cCBmb3JrcyBhZGRpdGlvbmFsIHByb2Nlc3Nlcy4gTmV3IGJhbmR3
aWR0aCBmcm9tIHRob3NlIG9mZnNldHMgdGhlIHJlZHVjdGlvbiBkdWUgdG8gdGhyb3R0bGluZw0K
NCkgTmV4dCBwb2xsLiBMaW51eCBzZWVzIGJhbmR3aWR0aCBpcyB1bmNoYW5nZWQuIFNldHMgZGVs
dGFfYncgPSAwLg0KNSkgTmV4dCBwb2xsLiBHcm91cHMgYWdncmVnYXRlIGJhbmR3aWR0aCBpcyBm
cmFjdGlvbmFsbHkgYmVsb3cgdGFyZ2V0LiBCZWNhdXNlIGRlbHRhX2J3PTAsIExpbnV4DQogICBy
ZWR1Y2VzIHRocm90dGxpbmcuDQo2KSBHcm91cCBnb2VzIG92ZXIgdGFyZ2V0Lg0KDQotVG9ueQ0K
DQoNCg0K
