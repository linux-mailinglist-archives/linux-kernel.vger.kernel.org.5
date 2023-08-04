Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C87706F3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjHDRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHDRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:20:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD4198B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691169635; x=1722705635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IjHAJ29LzkUr/EPACGQvTn9oVa5bkwKqcPgt8qC/ADA=;
  b=TB6Pqrf+QqAXZ5S+cKSyVHW+QEMRyMiLbriWvF2l2h3i9yBJ25bGC0pW
   /cW7TpD73iatmtvVW4b9KepwLo9Y2Cydi7s3xUItXq+iiOEpNGpouwVst
   orRgbxgWp2xJzqZRI4dM7p1i4GHROjzUokcLUnExGz1ITPK12ZDohvd1l
   tEqkMCYPDgf4UIe8hcSJ321EdEZ7CteTBtzwwlQ1GwE2+iU8CQ+d66+uh
   bszt/0Euql1Mn4r9aXCcXzVWVNJtyIDOxfiivUH72rAHjxlUig3NjYI86
   Y3RNOpkirnUVjLUCFuNkx7jloW1MpjcrlZpkY9X3PF9L1xCkHR57IV18R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372947700"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372947700"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 10:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820205770"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="820205770"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 10:20:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:20:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 10:20:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 10:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1xscz92d4OHjgCheY55C+XBxMIIo7m+4jmsx+0VErHuydYPfmclzKGnZa9xliiWp0nLmdD1HSMRVMdIAWNMcL8z6zrvhTc3oH/wmPMGkXg0hYiqHLGuulX3B37eTNU44m2OE0kfnZYxxrGc8G0iQPDsX8WawqRYdz09BC/BJ6E4GQ2sbJvdJMzLDSN8GzGcvWEyxBIXoLyppwz7EFbgZ6+LPNZ4Dx9CTiCwCTdGAANOOM6V2KGPfeEY/dlojikvnjyODh2YlBxo33a2HJrVi7a1s2mYYvsJSWIyDfVSiceMtLjEpEkijE+VUKpTukdHqfg1XHHNRESfdBqHZtOBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjHAJ29LzkUr/EPACGQvTn9oVa5bkwKqcPgt8qC/ADA=;
 b=YpY9ZFYAcyQok3uxnR5Lf4tUMGmoz/bqiyJC7SHrpohY7Ywh5Yg92ub5Ibhib4wpKIpjVH719btZ6sXsSQl05HKOgrPUevXaVP+NMVn042JiV16ubcqezYjHGelCiuqwFuz2O6ZoSdoLJydrEPBoyoYRf38PWeaRPoXdvIIliTlVXLRQB7Ju4HWyBRjQwwd7Lvt8tQpCR1L5BFKFxmkPqDQEm/ggeRup1LKyZ/EEu32DYytr9obaN/JBI4UfYb71oVAra5HKMbuKwZtCOEBg2OqT2Noi/VHVyUXQ3ParRfs+5c9kKZckYaEedNRHlbohBmDt9oRBanJBKifir9V/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:20:30 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:20:30 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Gross, Jurgen" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>
Subject: RE: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Topic: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Index: AQHZxq1luoPee3LE20qWOZPEmJublq/Z7qYAgAACvoCAAHECsA==
Date:   Fri, 4 Aug 2023 17:20:30 +0000
Message-ID: <SA1PR11MB6734DC6842D4779BCD3FC323A809A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230804075734.8372-1-xin3.li@intel.com>
 <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
 <f3c20dd0-9914-f646-0aaa-400dffd2bb2b@suse.com>
In-Reply-To: <f3c20dd0-9914-f646-0aaa-400dffd2bb2b@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA2PR11MB4986:EE_
x-ms-office365-filtering-correlation-id: bfb7b4c9-fc07-48d5-44a3-08db950f1a84
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaSUP1frTjL0uWSE077R5p3DaPC89IZlxLGWh/pjBInWpLFoGIne1OYavYf3Nt9ptYAYqoAcGrKTSppqXYGi15oaBo+8VzPVW8Of9RFzptPVU+byiiXfO0KBePOGeNzweQOTYFe6Rqhq03nfOwFDMPzhA15AtAeHCxuEGGczVcxzuMO2peyh4sbbUEkcgckp2n6g7vux0cil5u2uOQ0CrM5uuy5tlhWUsYsKBGaKonf+9SGTQmicyf8kdKEln8IHkb7EdLcKwFWBoFfjH31vFepopojXrZVWc3GLR+Q22aEwqV8RdGIzRBpYbB4ddDZ3xu2vv9bpj+neOEii862xSFnbPN3C9JTzQGTCNsbc81cGHU/MCZ7x0SOljTjUe89HZ9llJkrhUOerjbfq6fPJM4B64M/9U8T7N9UeaHyHaexjYWSb6TDCgIEqhPrSZ6q7HHKgEQGeVYSJ6HIZRQcG2jbuBTX7V2CIezhzLCjV+8tiezM3YJS/vcbuKU7aV1eQsfDx3K4ClrrFdW9T3CHKV4Jcun0oGOTNsQH9yF3BB9rKPqNZD2y2PkecjTGQWYfAfirjPYnUBLzFDTSckjuQ1i9th3Yvete6BYPXtNRLSQiv65Bj1oXvjFMm3xNiNj1q7j/AHZHj6C9pf+WlyNcHlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(52536014)(66476007)(66946007)(66446008)(66556008)(64756008)(4326008)(76116006)(2906002)(38100700002)(122000001)(53546011)(82960400001)(38070700005)(6506007)(7416002)(83380400001)(54906003)(110136005)(55016003)(86362001)(9686003)(26005)(478600001)(7696005)(71200400001)(33656002)(4744005)(8936002)(8676002)(5660300002)(41300700001)(316002)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEFKaTJTbXlGbGlQQ0pGamN6d0k4c0dzdlVrVHhPSTJvckg1RXVZbEdFaXJx?=
 =?utf-8?B?YWZVc25QSUV1ZWNUa3lFaEJaV2NhNjgwSk5SMThCVUdRV1JTd0lrd2pjcTRr?=
 =?utf-8?B?djg0MXdycklxWUJkL1ZZOXB5WUNsUEI1ejIyVUpWS1dqeHgwTmlMKzlXa2dw?=
 =?utf-8?B?Rk1XUHZkcDVzaklQTm9TSXZlOHpKMmVjR0xueFBkWC9jZGpQUVJzdDBhaUtP?=
 =?utf-8?B?WkNpUXkvT0VjVUJlcUFQZVRwNDQ1VTBRRC9haFEvZXJiVnIzV1FMT3k4bHQz?=
 =?utf-8?B?ZVdhT0djaHZFNkJpV2tuZGFHdUxvTVBVU0ZqTWcwN2pLSFdXcUFLL2dMR0E0?=
 =?utf-8?B?dkdmdVN5QmYxUVdTUlVVeGlOcDVtbmZxRVpxalhscy9IOTZrOWJWSk5zakNi?=
 =?utf-8?B?SXk2dVRrMHRaa09xcm42YjlZWDdIbWxnNG5oV09MY2VwYTZ0ZzM0QjlpRUdw?=
 =?utf-8?B?TTlkV3lMK0c2bkk1VERmODROcUF5cjRHM3Fnczk1T2tOdjdlNVFWME9UWGVR?=
 =?utf-8?B?VWpCUUdSSTRXUEFZbkVwQlNUVldyL01nQ0N4bjNlWTcxZ0pXdHV5ZGFENStH?=
 =?utf-8?B?SzVFUnpxaGsza0hhOTBUYS9BQ2JwRCtoVWMwUHFuNlhXRWEzUmw2eVBNRHZT?=
 =?utf-8?B?a1VOVjJaV3hyUmo4cVlYNU9VTjA3T3lzdDJaWjhOMjlMY1RRaTVzcmwzYmN4?=
 =?utf-8?B?eS94dlU3aXhDY1MzNFJQL3k2dFI1QlFhSDVsN1lWSERvUmhucnM3YUZ0cTNH?=
 =?utf-8?B?U0Jkb0lLUVBKQkxLNXhka1l3M2NheWVsd05LYXVpUXp0RmdXSUE5L3RUYUFI?=
 =?utf-8?B?SDFrbEpFYW93NnRzL3RzclJHdVcwWTZkcjVWS3JUOE81d1BVRUFCUXNCTHdC?=
 =?utf-8?B?SzU4OGVMbnVCNkFqRi80dHZXc2E0SHo4R2JoM0pyN2tTaDBtR05PRk9CL2VN?=
 =?utf-8?B?OGNMbTErd1VoOGh3MEhqNXUrM3NTbnEzUkZuK09TdFhGUDAvSkxtd09MNGtt?=
 =?utf-8?B?ZkZseUk0MXQwQml2ZUM2MStsNzFXVm5xU3l1MDUwR25WNGFsdkhUc0JDMGVE?=
 =?utf-8?B?TEc1MFZ1ZVdhbHNNWnlMRERWc0NpU0xyREdvN0N3RVd1UFNBQVUyd2wySEg5?=
 =?utf-8?B?RWZEK05QK3ovWkdpK2Q2ZThZZWJDeG50UXh3Q1llTjdzSnhzcFl2UFVMMmE4?=
 =?utf-8?B?NUNpVUsyT3p5R0NJZ1IzbEwrWGZndFd5MWNXOGdZSDhDMkx3MGoyMlFPNXhp?=
 =?utf-8?B?aXIwWms4WXFqUTNRMnN3MlZ5RW85bWZNNlZPN0t3bXBRLzMyZGx3ajJwaVA3?=
 =?utf-8?B?Znp4aWdWZkt5c2NCQjNGNXhVbnFBTEtPbnlYdlJUQmNtaGkvN2h6RHZadjVL?=
 =?utf-8?B?anRkV0o5YVNuQmRTQWNzVGoxK2lvTHI4QkV1OS8yY1dFcFJwbmxubnFNRWwv?=
 =?utf-8?B?NGlZaTUwcGFHWTNHa0swMDQ4NlYrTEJ6UUUrQ0dSSVNIc2UyMUhQSnFScmpL?=
 =?utf-8?B?UllPQWF2Mjh0L1ZMcWRVTkhLSDVsai9vRFFOdk4zY2dORFZlZ2RiL1RPRWl2?=
 =?utf-8?B?NUp5RnJoeUl5c0ZLLzRKbkkrMHdvUGxzYkRoRDBONDU5Zyt1bDRnRVJzNXpF?=
 =?utf-8?B?T0orV0wzWWtLWXhucDJlK05xRjRBUXVPTkF1YWx0ZGdlMGVLYnpnYjFVY2V4?=
 =?utf-8?B?ZnJiVkwzbitSc2d2TlJIQUV2L3Z3ZWwxczlXRnRsNXdrMklYUTUzZ3F5cSs3?=
 =?utf-8?B?RmNXd0ZVU0h1aVRzelg1R2VGOXZ3eFBBL29vVVYrUFE3aGwxNExSdDdrQ1dz?=
 =?utf-8?B?OTJadHdDU2xONy92dUxuWFFrK0h4K0M1QXhpYi9zanE4V0lYNS8zbURZWGpm?=
 =?utf-8?B?c29OTHBGd0VQU1pDU2oyU0NDdDF0Q2ltUnNabEk1Tm9LQXkvTCtBOFVuR0FO?=
 =?utf-8?B?NTNLN3dQR1B6USs2ckhLUVlpWUJnVG9YbW9XU1pnNVc2UTBqMU52RVF1WERG?=
 =?utf-8?B?SE1weEFNRTlOK25GbCtNTlZKS25PSHBubXdJNXJzZE5pYytiL2pGTHJJaWhK?=
 =?utf-8?B?Z2huSXNwY3JwU3gzWTI1S2lZMWpYVHB1d0M4SERIZitZYm1OSDNxY2JjNlMz?=
 =?utf-8?Q?zTow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7b4c9-fc07-48d5-44a3-08db950f1a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:20:30.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJZJjGHAS+ppHFPGzfIIwH/3WVJizyUBeUIW6NYRyshuVuZbjfbkFdZTzsRxHCSqBG5iZeuf0bFOrSk0hCwSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IE9uIDA0LzA4LzIwMjMgODo1NyBhbSwgWGluIExpIHdyb3RlOg0KPiA+PiBJIGhhdmVuJ3Qg
Y2hlY2tlZCBYZW4gaW1wbGljYXRpb25zIHdpdGggdGhpcyBjaGFuZ2UsIGkuZS4sIGRvZXMgWGVu
DQo+ID4+IGh5cGVydmlzb3IgbmVlZCB0byBhZGp1c3QgaG93IGl0IHBhc3NlcyBhcmd1bWVudHMg
dG8gUFYgZ3Vlc3RzPw0KPiA+DQo+ID4gVGhpcyBpcyBhbiBpbnRlcm5hbCBkZXRhaWwgb2YgaG93
IExpbnV4IGhhbmRsZXMgZGF0YSBvbiBpdCdzIHN0YWNrcywNCj4gPiBpc24ndCBpdD8NCj4gPg0K
PiA+IFRoZSBYZW4gY29kZSBpbiBMaW51eCB3aWxsIG5lZWQgYWRqdXN0bWVudCB0byBtYXRjaCwg
YnV0IHRoaXMgaXMgbm90IGENCj4gPiBoeXBlcnZpc29yIEFCSSAod2hpY2ggb2J2aW91c2x5IGNh
bid0IGFuZCB3b24ndCBjaGFuZ2UpLg0KPiANCj4gVGhlIG9ubHkgYWRhcHRpb24gb2YgWGVuIGNv
ZGUgd2lsbCBuZWVkIHRvIGhhcHBlbiBmb3IgdGhlIG9ubHkgdXNlIG9mDQo+IERFRklORV9JRFRF
TlRSWV9SQVdfRVJST1JDT0RFKCkgdGhlcmUsIGFuZCB0aGlzIHlvdSBoYXZlIGNvdmVyZWQgaW4g
eW91cg0KPiBwYXRjaCBhbHJlYWR5Lg0KDQpUaGFua3MgZm9yIGNoZWNraW5nIGl0IGZvciBtZS4N
Cg==
