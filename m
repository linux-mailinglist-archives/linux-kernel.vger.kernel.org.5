Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D4787400
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbjHXPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbjHXPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:22:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874E019B0;
        Thu, 24 Aug 2023 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692890552; x=1724426552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bkFBZnep0UTd78d+sQjflVI480yvbLYhzysmWqjq0Ao=;
  b=VzRk26Cb93Tqdmg4hHdCb6kzC+CZJLkVLGcEvr63a9+ycsrWuY92dWAG
   UcVuqb4REj3Z/akNTB9p9bgQaiOkJ376BIQvcNdh+bdtsCoE0564vg1UX
   Zuf9nNJ8k7N0LShdxmWsD8NQ7Bvg8X661TRzX8XEqHCUauYnyvztwYL3j
   eV3jxrtZcmf7pigMDko7NujrjrXGkvndiBlhkpbUXY/N/3N6rlFBNdU9X
   n4v+GAmvYucqKOwEm2Sul52m38eXKqAUfBKki3ywAdeb1EaYLbmOc3K5w
   jNYKuxwP5Gthv50vqMYI64TUzxvPptqAMKyzKKCSMQTL0anVla8nD+ZNN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="405470699"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405470699"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 08:22:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="983751853"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983751853"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 08:22:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:22:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 08:22:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 08:22:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5r58KiaKQBJCAlI7EB+2slzFAvDWkAAGAnrc1jHekc7gcHul1m/wM/qzpM8FRmrYBXE3AFwXdgaVALVtS9EcgUfH8TIGuOAS3LDverBaO1+pSPTkC97Vk7Hs54i8G7ZC+dz8x+1kYBa+14lmiG6iITWXyGMal19BypiI+JEfEveweTZaQRnELcaqjvumrNLenk8mUDWAzjdse1g7NgIkay796ImIJt79ycOm3MNBgdeJGYmPIMoDkc0eOjXz+T4i1+TCnamJxBIBeIbB+PnrqQfe7VmR3tyox6K6zLu8J0mbpzjAfUZeZ0pjmNDbSMmTqAoO1ukiec6YnUm0CQRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkFBZnep0UTd78d+sQjflVI480yvbLYhzysmWqjq0Ao=;
 b=c1LMd26WwRx9TTV+YgdqdcDZcSSYGtROoU94uzfKocRLYISbb+WJpbbErsbR3AAHBB0BMUBRcutGvTg9zJnqLqjPI9p3wETzOO/ULdMhRKYkeAj/HVcq10LZ+0PcJi47PU/5UKbX58migAXw0coEekOzqY58dLuqKAFiC5C5MP9HA5EyfGo5FckYLerr/Lx+lL+p+4ZxhrLYPG2QD+arQsMfaN2ZHLVfcaXkNFlJKqP5xtx+AqRiP22UNJRQm1pt7y5Vtz4gBcmCG9DZaIHw4uPrAeuAo1G7t7qLCRNmT3qEiz1VyAhM+3eAPPdegy67NCqUBKXHyGCXI9pq4oOLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:22:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:22:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wang, Lei4" <lei4.wang@intel.com>,
        "Pan, Lijun" <lijun.pan@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/urgent] x86/fpu: Invalidate FPU state correctly on
 exec()
Thread-Topic: [tip: x86/urgent] x86/fpu: Invalidate FPU state correctly on
 exec()
Thread-Index: AQHZ1msY6s2b2oIqDkeG/rIOCMuRSq/5kLuA
Date:   Thu, 24 Aug 2023 15:22:26 +0000
Message-ID: <f2fdba6ecda7a6b1e2ea048a3863fb302cc0f8d1.camel@intel.com>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
         <169286827548.27769.3257744272966160176.tip-bot2@tip-bot2>
In-Reply-To: <169286827548.27769.3257744272966160176.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7632:EE_
x-ms-office365-filtering-correlation-id: eed721b4-25bb-43d5-a612-08dba4b5ec8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZsF3dk26MsSJEdUcHdv4IxtttKvwoMiqmjT0JwCSatI1LBhQ+CeiwS1Tfs4SA8lhF4xvA2F3+4IgKWotmgmmhKZCBEDY8qS0fhIqtFiWkS+mKlJVdlsKzCopTUDudJK+vYkGSRvJsy4fxW/OJr0g+yBzG60oc0k9hPB625ow7PNyzPMqXFLHKMyVeKJWgEltyyY53vo1fzLl2znv1KwQNpscCr4ER1+7BSEFnyEamx9GTwk7Mc0z2nmThO336d0cHuS4kqMvls1/J0sWAZwQWkKSYYqPUndkK8wCnpVSuFjdL9CuOuhnYcYQYBHKj4VqUhbW+guFJdHDGjxyE/+Slz1cmdckal2V9ux7UiOO0sP+c8KHspHyhg9jsklVWsIESgeipz+mihCEwdYegNRF2e7H29AwxUU66qP+6fabeRe/iA1OVCLr2dp+U1i4OngWSObbRGrcJSbyxv3XZ3u0E4rgM55xsn9SvrDG2r4kI9dxa2Q5hYGszkdqcbqnxFA2oKzGipAgfemBW0nAoP9uZbZEekt/yjXmK0NjLfEUD+o1NTwwTuQkMmzgkm28ZYE+9rA7TDJs0WT0obrxU1GIw2MvM0BkfHWHS5d0pl/mX7FJsHBl6fguHJ85MsZDmRq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(2616005)(558084003)(5660300002)(8936002)(4326008)(8676002)(36756003)(26005)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(66556008)(66946007)(66476007)(64756008)(54906003)(66446008)(76116006)(316002)(91956017)(110136005)(478600001)(41300700001)(2906002)(6506007)(6512007)(86362001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzZHTzlQcU83RENoZXNGRzZDTlduRkhDdDVrdm1MSXJmWTBob3NTMC9LN3Vn?=
 =?utf-8?B?a0pFN0NFVnJRYXM5TldjVkFkcTBSeUxPTUo3aFdDZ3JabDdnZXpBejZMbGJu?=
 =?utf-8?B?ZUx6N2crSm5wZ1ZKazhYeUswTUN0TlE1RTJvNjNDZ0VldmpaUWU0N0k3Yi9O?=
 =?utf-8?B?WTdETUtWeVNKQVFXams3Y2pmUjcyMXp3eVcwMTlPSWtKc1YyaHlmaHpVaFJh?=
 =?utf-8?B?S0k3MEkzb2p2QWtmMlNtclRWcWI5bnlBSDFBeUF6TnBsbEFnT21ORk12Zmln?=
 =?utf-8?B?a053Qzg2b2dyQk1yekZwaThhQjhiSEZ6UWdzMTNIUkdkZktncU5IbHJIK1Aw?=
 =?utf-8?B?TDl5VDZ0YmRhU1BHeWFUYWkwNkducmQyNCswMXdHQm8zOEVuRmhzY1VXa1hU?=
 =?utf-8?B?S3o2UUJGZStFVFRGM2R4T1RRMFFDMEYzNFo3Z01rN0htVC9zWmUxa1FZajFM?=
 =?utf-8?B?L244anpTVStCS3plRWNIa2dHVjJ1cGJUc3hwSlRNcGVhTEFhZlZ1eGJRb05E?=
 =?utf-8?B?YkFXMXNrUWRrazJpUUVON1M5dmlSWjM3L2pQd1luUzFCT2kvalBGK29Hcm80?=
 =?utf-8?B?ZmdMQjVDbGdrUm04Y2tjQ0R3TUEyajhVZVQ2Q05YNmJTU2pibXJSNlNZWm5U?=
 =?utf-8?B?ek5QN0dJcDZzSDFadlMzRVJocW5VNjlvalk1ajdnUmhVbFF0a3lWdmVKcFdX?=
 =?utf-8?B?MUxBUmpqUFhmVG1seGJtOWIwNmJyaW0rM0VwN1NON29PbGowUjFVSXlTNEV4?=
 =?utf-8?B?VTJ0aDh5aHF1dEpzTjZRZXRrR3hFcUYwakdiWFZ5REhBRHRYK3N4OUU3VVRV?=
 =?utf-8?B?dFAwYitzSlMrZ2pISnE5VCtYV3hQUjdtUGkxTXQ3VkhIZVduQVk3WEE4VlpX?=
 =?utf-8?B?L2Y0RlZieWNIM2xnNFd4WVg4Q2Y5dlQyZ0lra1kzbUlhVTlKVGNBaHZuRTRo?=
 =?utf-8?B?YnlFVkZ4cVZOa3FOakd2dmZEVk9sV1JVelRWeDQydVlJMDVQNVd2cHhZZGQx?=
 =?utf-8?B?dnlLdnpvMEhKZkxESjIxY08xN1o2elkvekE0VzAzSVhKZThlVjRSc2FLelhY?=
 =?utf-8?B?RlppVHJOT2tiQTE5RnIreEsrY0s5ZHZyQngyZHVLT2hQVlBFVjdsYXBXbUxh?=
 =?utf-8?B?TEU3STFNMUxaQndHZ2lRdGZEQ24yRkdNTGxkV3VtazZmdzRaNGFZQkxMWTE0?=
 =?utf-8?B?aTkrdGRONGNnaDEvbmlsN2ZOeWtSYU1OaUl6Q0dTY2ZCZmlYREpiaFlhbXZO?=
 =?utf-8?B?Y0tBS2NJVWFEdkhBNC8vQ1U3QS9xeWpzak8wUlRkRzE3Zk1TSFFXcFNBTmVh?=
 =?utf-8?B?Q3J6UEN2L1ovMGVlUXJ2TlhEQnI1Z1pZOHFnUFhTdlR5MnhPYzBKZm5vRGVI?=
 =?utf-8?B?NkxsZ1NmclBCSWNqR0tObmQ5TFVmdzBUSVhjbUkyTGhmbmRHUXlORjdLUzRT?=
 =?utf-8?B?WU8xaGdwdmhnZnZ4dTUrZUlxVEdZU3FyODNRMEp2YmV6c0RKbXN0dVZCU29I?=
 =?utf-8?B?cXAwczExdHhrVjJTWDcyMVdiNVVXSDRBM1ErOVNYTTQwVlRSTDZueEN1LzIw?=
 =?utf-8?B?d2N1bHN1Rm9TYkNtTU9EVXdnbDRWOFBqOEtRR29sM1FoOHFWQmlhY2xDem10?=
 =?utf-8?B?Qk5hTzcyWUJsb05ydnRoMmFoYzlKVnlKQWRVOGhMM3NudUFHNTlVRHJaZVRy?=
 =?utf-8?B?amt4em9GazI0ZHRTZC9FYzNtT0J1QnJCbFdRdmFBNW5KbGU4TDhLVjdVT0NY?=
 =?utf-8?B?UDZJTmwwZ2xsaG5WOTFDL0Q1bTcvNHVwcEtBamdWN3lpTE16SUQwN0JMbWdk?=
 =?utf-8?B?bmZCRUdFaEM3MEVUbjVYdVp5VHZwUGIyZlhPMVJ5S3pKanAwMGhSRk90MUdY?=
 =?utf-8?B?cFg4cHlaVlB4V243WFZlWWJ1KzJtMGVzMEFBeklnS3JYWExCeDRpZVJwNXhy?=
 =?utf-8?B?Q09hNWVabGhDdENXVzVqVnRsNU91MGJ0aWdPN2dCQUU5RERzS3o0RFJUZUli?=
 =?utf-8?B?SU96R0kyRlJtSmgzRVBQaE5NdVdvZUlXbEwrR0k5cGlNQmd4cjJXaWJoeVFw?=
 =?utf-8?B?bElKTkFwVm0wV3lYRzBEOEdKdExGQ1F3Q0hkUmxCSDIxL3lKSVI1NnNIKzJS?=
 =?utf-8?B?eWpUanVMM2ppY0c0OGVjdm9maU9MTFFMd1c3SEhBWHdTNEYvVEpjalZuTFlm?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B93CDA66FF945145A50E74C2A44713D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed721b4-25bb-43d5-a612-08dba4b5ec8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:22:26.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4GkOOC6qfO9zWY9jaWGDCLz03/E/K6JdX0T8aoPZ71onCXTjXU/RLVGQi1LxpYGVYgoofR4B/lbJrh6NfWlRhSSAR6Gdfs26S/ZI6hKflE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
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

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA5OjExICswMDAwLCB0aXAtYm90MiBmb3IgUmljayBFZGdl
Y29tYmUgd3JvdGU6DQo+IEZpeGVzOiAzMzM0NDM2OGNiMDggKCJ4ODYvZnB1OiBDbGVhbiB1cCB0
aGUgZnB1X19jbGVhcigpIHZhcmlhbnRzIikNCg0KT29wcywgeWVzIHRoaXMgbG9va3MgY29ycmVj
dC4gU29ycnkgZm9yIHRoZSB3cm9uZyBjaGFyYWN0ZXJpemF0aW9uIG9mDQppdCBiZWluZyBvbGRl
ci4NCg==
