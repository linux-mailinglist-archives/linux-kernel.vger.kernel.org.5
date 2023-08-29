Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893E78C948
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjH2QCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbjH2QCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:02:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59A1BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693324941; x=1724860941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZNae7i+QBicAUmdd0TE6pnyO9oH2ExOQab89/rjp4nA=;
  b=IkcOGwZshwoTX08fxcKUWEmysN9+GT/e1jwLRDANZZx0w6meLWmNWl1G
   5mFMSoLj9M2TTu2VxBVgTrm0pMnjNyEj5iKt6nVjlLpEokapoZNUQ31lQ
   5DaYdyuLloRvQJ+eU3iT0r+KM8ngsKIwU48vLvFPp3y5GWQiExKPAglcY
   g8Eq2ylJxCGE6Dp5y49h+7xCGBuiynHM1fLMANARjuyqCBrOULcmgjpQc
   Pz/5XV3Vg+ghUlP/C8+/UErpLN42Oy+B17bKebdxLQANrXrVGUl+Nm5Ek
   wjStgO/aWIL41cjXHCoBijhQh+hACeKwBsIlkVwVio7pd/oicbNENCp25
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365615443"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="365615443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 09:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738760182"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738760182"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 09:01:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 09:01:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 09:01:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 09:01:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 09:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8V2n5aUi5v2yA6Q+z0rO/gfVOovJLOzzPbE10WKSW0WrrVvM8v2HTNn8eiYX9SdWIN8a7vZUigx4JLbTiR3AkAJ+VKRP39jH0uvhcJpZNr2sqtGWXdo9dPDZqJvpqxa3o/zoTpa7/euY7zaif0gQyD9f8UynVPFzb8TnXbm+4WIpAithnL93/s7K+l1GdZB3lDgaDEyeKCDci2BCRakG6uY7NOLpusRCZqOzY71zOSiNFCvVbgl1XBohuFfEzEKgjzCNRSVxBtwVHx8uW1BdeWMXqG/m+AZCnXMzTIMfu35Tkzc9EQ2Vt25ldVT+VR5vVmgIal6ibtA5egSHVHKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNae7i+QBicAUmdd0TE6pnyO9oH2ExOQab89/rjp4nA=;
 b=oRHOye/3LCVLVi7tn7JkJxSRMd5qGqcPCNm5dTSNeiJ+4SJTtpo70xiQaDAm4mZeGVqxBh/DZm/sUW462Zgki5BTPTHJNuBjBaZn/ZG/9AiT1M8Pm+9KLm9t2uiJT3gvczFN7auKq9/5KFdBy8/XO6cqJghw97wVsMyc0Z1De2BT5lC6oEHAAKcJXfxb2Nlqge/lG1OLMSWhoJDkqJnv9fTP1xuKrGcvn+R5AfCa7rQm0KuA5PN8mhJ9hpwprcnk0GvbHNJRZT9XE3VdIjvBPHCMaKmsJ05LtdwE+/1+yUFBV7rp4Xr98bnW7TJEiYugXN1w73MZO3uw9Xcqppf1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by CH3PR11MB8564.namprd11.prod.outlook.com (2603:10b6:610:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:01:48 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::b570:3906:fde5:c9d6]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::b570:3906:fde5:c9d6%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:01:48 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
Thread-Topic: [PATCH] x86/tdx: Mark TSC reliable
Thread-Index: AQHZyhS1JcLmCVpccUeZXOazygGeDq/gowaAgAAu+ICAGN7dgIABcb4AgAA3HICABjZZgA==
Date:   Tue, 29 Aug 2023 16:01:48 +0000
Message-ID: <505FB766-F79B-4D54-910E-B2EE497515FE@intel.com>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box> <87bkewcufi.ffs@tglx>
 <20230825135226.ikxvskplvppghwtz@box.shutemov.name> <87pm3baw16.ffs@tglx>
In-Reply-To: <87pm3baw16.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4435:EE_|CH3PR11MB8564:EE_
x-ms-office365-filtering-correlation-id: 2fa59369-12b6-48e1-d321-08dba8a9402c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAH0OzOgUHMoQG0kG0ukd4UItHoI3CO9smD1y9CXSB7CWPEl/+DP55q4o7iHpuwQas/cHKPuHJ06+z4E8fUrhNSGGYUw7FHoWdGxCMFlxUSj3zk4nvtIdftOsGS7iT1/shmDJnFFwqPoXMVLrLW4FvTImhGz2sMojzhM7Rz578ws1ODZ4zUt66Im4f+zWj/KbYOxoEGhNP3q5TZu4Ei09pdkQ2VFqlaX9xfwT5w8m901G6wTFzk2gnxQJTrWFKJXNoJi3f/LazK47pTjSifqIyIpxkDYqyOUrr3Uu3zRCjsNTqX6QsFECHdioAFvUVtNSFhSv7VHQKR6prPUj7Dm6mlOqY1+hlbnwul31/tG7dpJivLSjRzcS1kOjtXRmlIJu/Tikl3V6GwGRmD91aO179ixyZu2ohrICBcNcvf5NvbN5UrESWHGjkUD9RfYf9LLBzAb8ZlranyZs7Cs+nOrwIf1Sg2ZaFnrL8ZL1ub0YwMnk5W77DXbiq/8zIvML1Mc81EIBvd0iHkBsjpmjgN/ZK6CbPfCRNVVJaF4oBAsX5MCLhWZX+wDv40Pq/NDKYDqmXcHq1uq+V4NKLcvspt8qqCZoPXlEto8jzp1k/vYa4HF4GV/O7VneWIsz0NEMgN5pEo7BLfo2EjSr967Icz8dA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(66946007)(122000001)(53546011)(76116006)(478600001)(6506007)(71200400001)(64756008)(66446008)(66476007)(66556008)(54906003)(6486002)(6916009)(38070700005)(38100700002)(316002)(41300700001)(82960400001)(6512007)(36756003)(8676002)(5660300002)(2906002)(86362001)(2616005)(33656002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S09rZjdiaE1ZL25majVoam9XRDBEdi9qdVhlSlpOb3dwVVE4eUtrODFkZzlz?=
 =?utf-8?B?MGlUb2NxVmR5bHh1Wk9SYm1ESmpVRDROakVlMWJnU0lVcllJZ242d0RnVFcw?=
 =?utf-8?B?L1lYSUlyT1R3NGJsUjBZV05uRHBNWnY1bTdwYlh0Y2JEMVVkWCszTUFPSmtP?=
 =?utf-8?B?WHhVSjBsMGlwRDl5cVJEek52VStDSmZaVzlrSTZNeUpXTnVoVVhyS2xBN1NW?=
 =?utf-8?B?QXpVZ0RLamhvWDlua3kwMDNBaGtGVmRSNUpPSC9jY1g1QXFzSlAzZVZob0Jt?=
 =?utf-8?B?akx2aDdxais0MkRPT1BzYzNTMGdEa2hRbWFhWXFJVWhTckNXVWRPaWFMQUlz?=
 =?utf-8?B?Zy9HUjN2TzJyZStkMU4yMlRHZkEwUTYzL1gyYzlYSHY3N1N2OEZmTVd6cEVh?=
 =?utf-8?B?SmN0c1RFTUgwM0t0U1lmTkUrYWVYdGJCa3RSVjVCY2E4cXpIMjN4UmRxNDI5?=
 =?utf-8?B?bWtvTk9QTUFaMVRLWXRlSjRtUkp5M1IwdGVDdnJaZmJMWVZqVnVIMWU2ZGN6?=
 =?utf-8?B?Q0FlbXJnNjQxQWJwcU5OK0dvaHhGYW1DVWlIVzhSdXd5cE5wdmJQendpeDNX?=
 =?utf-8?B?UHhJK1ZhbVJvb1gyYitjNUJWaGIxcE9NdmIrYzd5ampHZVJ6d29sSlNzd2Er?=
 =?utf-8?B?cVZFb0tZbE1ZZit5Rkp2V0VFVk5GK2gxN0hMTFZsNEFDbHV4b3NpWWJyYllX?=
 =?utf-8?B?TmY3V2k3Ri9YUGNBbzY1UTNpaXVTeXY2TDVGWk83dXAwUmRrOUJuN0JkMUk3?=
 =?utf-8?B?dHh4d2QwK21Gd0JPS3ZaMEg4UDcwSWNuMi8yY2pVS2J1c0hMYTZoUExqcXkx?=
 =?utf-8?B?WE4wN053eHFRSEljSzhFY3hyWml6KzhSUkJrM0JHeVJFMW1xbzFUdStyTS8z?=
 =?utf-8?B?bERCNmcyR3dzOVh6czl0MzRQck9CSGlFb1E3TXV5OGJicHVuN21JdlJHb3Bp?=
 =?utf-8?B?VXB3cGdrcFQ1STQ2ZEFLTyt3OXlxclArMXhCWS9TV05zZ09PSHBOLzR6cTRm?=
 =?utf-8?B?TnJ5Zmw4NjhOM29iQVlYcExxeFlqQmlUNFNCamhwSWVBcnVtdnN4ZGpLVEFR?=
 =?utf-8?B?ZW5UYmZyZzlyS3E2b0sxNnN2UGlHUmJRMWwxODBScXRuNndGQitidVNkWXJm?=
 =?utf-8?B?KzF5Tjc2Y1A5QjhKQnRWNW1zVzhQT0hvTXEyMVdrZ1EzWk5WeFhmQTJGUjJ6?=
 =?utf-8?B?SVVNdWRZTEFGV25oMXg3dVVXOVF6TjViQyt4bUhkRnBDMjU4djNkSWlBY3Bw?=
 =?utf-8?B?dHZiZjR5S21oNGhHQWc1MkpYK2wyaTk3OEg2Mzd1RENIZ3Y4TmZLbjFqL3Zz?=
 =?utf-8?B?THQ2K0pjYis0VFQ5cVk1RTRMeDJFOGpwaWxJazExMkRWcmhERk1HaU9XeXZT?=
 =?utf-8?B?ckZCUUdRWTlhNnN5cXZMa2YwZGljRy9RelkyekJyZFJGRFRwblQ2bHNGTjlo?=
 =?utf-8?B?QWtMQTJEVjdVcWRNUXMwV3FrUURSamhlYklNWWZGTklLelpJQkhsNmhseDV6?=
 =?utf-8?B?enBUWmFJL2R2eFBnTFlWQUxiem14NDJ0NzRHL3J6NE1DS2xGUXBwQXJZa21M?=
 =?utf-8?B?cWEyTWxSWE5zK2p5T25DL2dDakhOVWUyM2laSytpdng0YU9BRmVyTG5IT2lp?=
 =?utf-8?B?ZUdnOXVZQlNKTTlxMTJ1YU1IZFVSeXFoQVk1M2YyQThOOXgyRTNCOE9FR2lh?=
 =?utf-8?B?MGZEVkNOcEs1bHZyRmhxSHNGZmhQeUdPMmdIL3RWNzVFaUtvOFEySHZoRFQ3?=
 =?utf-8?B?M3AxMjhRRDJxT2liOW1FR1BRMEQvM0N0anBpck5kT295ZGo4YjdZL24vTy8y?=
 =?utf-8?B?MHFVL2xLdmZvN1BiaElrYmdZdUJ6MnIvbWdSTDE1YmRsYm9ENjlkbWE3eWUv?=
 =?utf-8?B?MVpzVWNzcitKcWRXMCtPNWF0OHFVMWgxcG5mbmlHc2loSWVDb1Zsa1JJTGlU?=
 =?utf-8?B?THJ6WjhQQmFvdDc2eExPdVFLejg0SW95Sm5XMC9oU1BJc2hmWXI1T09GUG8v?=
 =?utf-8?B?alNNNDVsUklWbkFGTXFIRERhN3hSRFZCWVdZdGpkVTVaYThFSkNuMEdtQzlU?=
 =?utf-8?B?UmE2Q1Z4Q3Q2QUY4NHo2NlZMVGVjbnBuY2xYZWd6UmNwOXRudThiTmsxMnkw?=
 =?utf-8?B?aDRhY1VUK09GSHVWdEErVVlJR3lKMDJNWURNTXVGRTFlNWorTXJoamxPK1Z0?=
 =?utf-8?B?NDlWQmU1UDhuVElCWkt2ZjJweEpZTER0ZWdxaGxYRFhVTTF3bkt4bFdid3FI?=
 =?utf-8?B?TVlSQU1obHRDMURQbHhUb1FURkl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A3AD95373D0B4D91B130F82623322D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa59369-12b6-48e1-d321-08dba8a9402c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 16:01:48.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkrs07QXh0mhdabboH1saxfJJMLnbA9nybHKQAEzbDftfqALuEKsRAXRfXr9fqnRSE5pN7DliD2kMxO+FkxZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
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

PiBPbiBBdWcgMjUsIDIwMjMsIGF0IDEwOjA5IEFNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEF1ZyAyNSAyMDIzIGF0IDE2OjUyLCBL
aXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+PiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCAwNTo0
OTowNVBNICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gT24gVHVlLCBBdWcgMDgg
MjAyMyBhdCAyMzowMSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPj4+PiBPbiBUdWUsIEF1
ZyAwOCwgMjAyMyBhdCAxMDoxMzowNUFNIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+Pj4+
IEkgdGFrZSBpdCB0aGlzIGlzIGNhcnZlZCBpbiBzdG9uZSBpbiB0aGUgVERYIHNwZWNzIHNvbWV3
aGVyZS4gIEENCj4+Pj4+IHJlZmVyZW5jZSB3b3VsZCBiZSBuaWNlLg0KPj4+PiANCj4+Pj4gVERY
IE1vZHVsZSAxLjAgc3BlYzoNCj4+Pj4gDQo+Pj4+IDUuMy41LiBUaW1lIFN0YW1wIENvdW50ZXIg
KFRTQykNCj4+Pj4gDQo+Pj4+IFREWCBwcm92aWRlcyBhIHRydXN0ZWQgdmlydHVhbCBUU0MgdG8g
dGhlIGd1ZXN0IFREcy4gVFNDIHZhbHVlIGlzDQo+Pj4+IG1vbm90b25vdXNseSBpbmNyZW1lbnRp
bmcsIHN0YXJ0aW5nIGZyb20gMCBvbiBURCBpbml0aWFsaXphdGlvbiBieSB0aGUNCj4+Pj4gaG9z
dCBWTU0uIFRoZSBkZXZpYXRpb24gYmV0d2VlbiB2aXJ0dWFsIFRTQyB2YWx1ZXMgcmVhZCBieSBl
YWNoIFZDUFUgaXMNCj4+Pj4gc21hbGwuDQo+Pj4gDQo+Pj4gTmljZSB3ZWFzZWwgd29yZGluZy4g
V2hhdCdzIHRoZSBkZWZpbml0aW9uIG9mICJzbWFsbCI/DQo+PiANCj4+IFRoZSBuZXdlciBzcGVj
IHNheXMgIlZpcnR1YWwgVFNDIHZhbHVlcyBhcmUgY29uc2lzdGVudCBhbW9uZyBhbGwgdGhlIFRE
4oCZcw0KPj4gVkNQVXMgYXQgdGhlIGxldmVsIHN1cHBvcnRlZCBieSB0aGUgQ1BVIi4NCj4gDQo+
IFRoYXQgbWVhbnMgd2hhdD8gSXQncyBub3QgYSBndWFyYW50ZWUgZm9yIGNvbnNpc3RlbmN5IGVp
dGhlci4gOigNCg0KQWN0dWFsbHkgKGluIFREWCBNb2R1bGUgMS41IHNwZWMpLCB0aGUgc2VudGVu
Y2UgaXMgIlZpcnR1YWwgVFNDIHZhbHVlcyBhcmUgY29uc2lzdGVudCBhbW9uZyBhbGwgdGhlIFRE
4oCZcyBWQ1BVcyBhdCB0aGUgbGV2ZWwgc3VwcG9ydGVkIGJ5IHRoZSBDUFUsIHNlZSBiZWxvd+KA
nS4gDQoNCkFuZCB0aGUgYmVsb3c6DQotLS0NClRoZSBob3N0IFZNTSBpcyByZXF1aXJlZCB0byBk
byB0aGUgZm9sbG93aW5nOg0K4oCiIFNldCB1cCB0aGUgc2FtZSBJQTMyX1RTQ19BREpVU1QgdmFs
dWVzIG9uIGFsbCBMUHMgYmVmb3JlIGluaXRpYWxpemluZyB0aGUgSW50ZWwgVERYIG1vZHVsZS4N
CuKAoiBNYWtlIHN1cmUgSUEzMl9UU0NfQURKVVNUIGlzIG5vdCBtb2RpZmllZCBmcm9tIGl0cyBp
bml0aWFsIHZhbHVlIGJlZm9yZSBjYWxsaW5nIFNFQU1DQUxMLg0KDQpUaGUgSW50ZWwgVERYIG1v
ZHVsZSBjaGVja3MgdGhlIGFib3ZlIGFzIHBhcnQgb2YgVERILlZQLkVOVEVSIGFuZCBhbnkgb3Ro
ZXIgU0VBTUNBTEwgbGVhZiBmdW5jdGlvbiB0aGF0IHJlYWRzIFRTQy4NCg0KVGhlIHZpcnR1YWxp
emVkIFRTQyBpcyBkZXNpZ25lZCB0byBoYXZlIHRoZSBmb2xsb3dpbmcgY2hhcmFjdGVyaXN0aWNz
Og0K4oCiIFRoZSB2aXJ0dWFsIFRTQyBmcmVxdWVuY3kgaXMgc3BlY2lmaWVkIGJ5IHRoZSBob3N0
IFZNTSBhcyBhbiBpbnB1dCB0byBUREguTU5HLklOSVQgaW4gdW5pdHMgb2YgMjVNSHog4oCTIGl0
IGNhbiBiZSBiZXR3ZWVuIDQgYW5kIDQwMCAoY29ycmVzcG9uZGluZyB0byBhIHJhbmdlIG9mIDEw
ME1IeiB0byAxMEdIeikuDQrigKIgVGhlIHZpcnR1YWwgVFNDIHN0YXJ0cyBjb3VudGluZyBmcm9t
IDAgYXQgVERILk1ORy5JTklUIHRpbWUuDQouLi4NCg0K
