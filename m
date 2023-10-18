Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C07CE40A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjJRRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjJRRKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:10:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22BD56;
        Wed, 18 Oct 2023 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697648997; x=1729184997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hZqFbibjJNzgg/ygL7YvkplfKntRClsptwntedt6YSE=;
  b=AvRr7pdMX9afJ1CsyAAmzf4wMDTKMt35bsilqd9idl9abm14ddT4ndug
   24u8ytHAtLxbP6S3F03uRY35S2jr39HfOd58izYUyGje0pGNdyHICoQTz
   hdtVlqxGzUvtu5kE54fHM51DZJTZX2wBjE3R8wkeSN+/b2okTSMmnZsS7
   Kdz16O4yv8wcsvAMjSMVwVj1umuIj9wLmrbitGfeUv5KtM5txr18rNUlC
   uQ6nVx+GWGeuD6wtWrytWu8VvrHMWRUhP0zcqVJstlCUaZeLKGi2jj6Ld
   jobBijT2RJfqd7gz6MGzWuSf+AfyGmyq8sQA6cbX3VCWePbdhqCmuy+h7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4653206"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4653206"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733245226"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="733245226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 10:09:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 10:09:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 10:09:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 10:09:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 10:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP3Sd5WSBSINi/ZtDnhsRKTPuKvqSnfluZegShQVOhD41MJeJbA5ZSgKm1VHdwtOLNu9kBDiXPyyI3eCYRcNrpZRHpHjT/p3wOJ01lIeR4LjBKsm1mwBT5iB2IlDnLLUTce8ggOlfhe0pWidQ/U1JEhi1VzhzMgsW7aHrVJGRfVRBaI6Xt+qzO0jQHW+hhk1UaZNWgd9OjQZTqOGiBcSMJtGAJrhtmY8aIglCa4sLeakFdMfo65XHIg6RhUKif3dKpEPCUcrjM8AEb4mrbRWOGEmL7XZ79b+hImFzsBl0fueaAzYks+iJ9wPCabI3zXo5BGvxn5YobFRgD+ZAaMnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZqFbibjJNzgg/ygL7YvkplfKntRClsptwntedt6YSE=;
 b=gg3Vpbv8v8szAl+GVn8aB3UljpXAP6mYESe4bXok//J+1aozLiYix9ETJxHxCyv0Cfa0JCagR4qBA67m1uTYxLXCvGpQVZ/RtETEjZeUnNfAcdg681XvnudGHlUfsAQL0C8xoDnbagtdbCdNF1758e6bQOv3pJHEYoGUy+O/rZgMlvEmhg4hMOq7gqEe1jXh+fbrJtF2CZawk4hEVSasZg8KWXceGy/sZZX7ftuXpx3xiv08DQi4j8ptH9Y5oJpqUFKNiX+NIoSFrzG8jwTwVn/ARzB+VcSQ/buxcdpQyqYVGjy43oRVcQiP8JhQFV7HsmeE2NwYmeh/rxp9HfYUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:09:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::809:68a0:d52b:3e4%6]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:09:46 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "Lutomirski, Andy" <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Topic: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Index: AQHaATgYbrh2vf9YMEisxdRJ1o7j3rBPFRuAgAC0PYA=
Date:   Wed, 18 Oct 2023 17:09:46 +0000
Message-ID: <f163769ed8edbf778315f8221da4c97ddbab93b5.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-7-rick.p.edgecombe@intel.com>
         <20231018062439.GA18260@lst.de>
In-Reply-To: <20231018062439.GA18260@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB8328:EE_
x-ms-office365-filtering-correlation-id: eae033d4-b38e-4a22-116c-08dbcffd07a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox1q+VcLyGY3yDRLT0R6MuPkYqUhn3JvzdgU7H3y4EH+f6FhH72dEWMOZvkpueFbvEqyvl8cMJifZ29bv2pllcVwwhtLwzeb+cRGgyjif8+dKgH2gt4jf8HEfuPI2kJ7QJlrEfzk/0gs9vK50pqV/jZUCsDEj5ySlXDHvstD0MMPVAWFWxKkQCdYVfmd9YsOvPdw6hrdJEIX38eQY9+EBPpcrdwuDZfOA3WzesB7bIJUyzzN3nNYVlQOfb5PKc20qhJstodk/4gVKr1ylLuMmc63N1l06vbNOzqo9qn/QDGcGhz/R3Pe98nZ/qK29H2+3v6Vh8irTeekYgSvCXCkBsTMd5XUrsSOu/dceJsNntIYCdHO0LKMmjMYqAmdU/kxWU+h2Fok1HoUPqCPKereDYhdzF4sN8GxAcH8eqOzo/mQ2fVSO4f4fRZEBTJZobVrRcGPvw8MqB9+HTE3S1gvjPcZ5U559CPIjf+Z2q6qjV+8Hr6GguVKcm02jpOai+2J7eRjcihoDDyWgXy2+0GhCC7DUVjTq0SMsPf/QeFI4FIlqCE5XyvUORmsOSmbP8jr0bSIUQLgcZFnwjy0wqu7gOVD6YhjXl4gLc85i3iGjXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(316002)(71200400001)(6512007)(6506007)(2616005)(26005)(8676002)(8936002)(4326008)(83380400001)(2906002)(478600001)(7416002)(76116006)(4001150100001)(91956017)(66946007)(54906003)(66556008)(66446008)(64756008)(5660300002)(41300700001)(66476007)(6916009)(966005)(122000001)(6486002)(38100700002)(36756003)(86362001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05IYzlNcWhVdWFpa0xXV0ZQbHNoS3BLK3lhVWplQ1ZJUjVQRllRRTB5M3lK?=
 =?utf-8?B?RlR5V3lHTlFxL1M4ejlvQjI5WUFuMTEwdkltVXRydXV2RHFMbnprT3M4SlYw?=
 =?utf-8?B?V0dKbmhxMGtzTy90K2x4bmx5L3l0czVRYTgxK01vY043WkRzWnNDUU1JV2lq?=
 =?utf-8?B?ZVE0Q3pqVUQ0WkZvc0d5U2dmdGJwNVd1WHpXVE1sWTdZMUVUL3dkNjZ0Wm5s?=
 =?utf-8?B?cXRmMXNSSks2cVNpd01kK2dEM0hzUWQ3aXlqWGdCNEx4QzRlVnhKa1hBU00v?=
 =?utf-8?B?eExPcXVUd3VTWHBOckxtV21TcFNteEFOd0hHRXJnKzN1NDRiVjBtbTFOemR4?=
 =?utf-8?B?MHNJUnZhcW9KcW8xbzErV1pRdmZsSXNBOHRvUDBtb2cxeEFXcEVPaHU3Vkh0?=
 =?utf-8?B?cVdXeGszenh6R3MrdS9sY3lDTUNJbVJRL3YyS0dGR2NPM2dZK3h1OU1zaWgr?=
 =?utf-8?B?VTJBZWd1bDJocGVXRldFbXp2RGtabDR3dGJXeGt1NUNzbXcyQmIzTUV6UDl1?=
 =?utf-8?B?N3dFOGhpKzVqWE1ZeHJkVVZhY09KQlRCM0lDVkJjZEYveDNWUnA0U1dDc2VZ?=
 =?utf-8?B?aVQwdVkxTUUrTUtETHJhRHNid0dzNUQ4R1c0bWxSNk93bUlYdHJsRHQ1Mkhv?=
 =?utf-8?B?Ykl3eTVFekQxYzF5NEoyTy9pQzVVallQZ1dFYVBlNTdKQldxem1WdlhpOVc1?=
 =?utf-8?B?WnZmSTd4d2Y1NDJxcVdnY2R2RE1uV2hwY0lCRkJmUzJlZGRLMFFjcW5rZUZa?=
 =?utf-8?B?UlUwYmJndEw4dUJqM250dmZXZ2pkUVd2RGRzWjlnem9wQTk3MklzRy9SaHAr?=
 =?utf-8?B?QUo0QW9Xa01uSTcrKzlPdUlRZExCWG9kVEdZdElpU2dEMDhldEFhYXZNaVFH?=
 =?utf-8?B?bXpHeWIzNTVPUmxpUGpPUWdlSGRhZVhjaGFaeVcxTXVNTzFncTlFY3JmdHVT?=
 =?utf-8?B?SS9BUG8xc2N0Zk8wRUcxNkhKL2xFeXNURVhvME4xbnJBQ0t0eTZseVpzK08v?=
 =?utf-8?B?TlpTVlRqRVZId2x4VXBTanBxcWxOendvUmJKTVdIZHo5MGFNdkJRclI2c3VF?=
 =?utf-8?B?ZVAxeTJueXo0MlpXVEIzTXNnS0VqT3Jjd3VuaWVxWjRjR29DSm8vZTNYTzJ1?=
 =?utf-8?B?VUNBaCtJMjlMR204ZmF6QkswMTZyZmFaNUZ6c3ZDbUI3ZUZYZ2htaE91SzBq?=
 =?utf-8?B?MlZhZFpTR21TczdpWE1zYm50Q1JPSm9FdXdaWHRXcVZVbFZZR2E5RFlBamdE?=
 =?utf-8?B?Q1JhNUpmd0ZOdlBwVUplV1VIT0Fsd3czYnZWcXhPcjBkNzBSZnp6aXVESUt4?=
 =?utf-8?B?NTYxbllVT1hGd1JKbHlhY04xK3NzVGQxeTNoMmZ4LzdOMHNTZldZT05GNzgx?=
 =?utf-8?B?WkR2SWp6cDNIOEpCNkxqVW1TbjhpNkpmVUlMY0QrUmhFOWpPbHNEb2ZRbmJG?=
 =?utf-8?B?OE4zRVFldEF2bFRFSUZodkV4dVZCN1RRek9Uc29pc2F1ckNSaXlGSU5kU2RM?=
 =?utf-8?B?ME5hZTNxamxjMm5uZlBFRjRHdzJodU56MHJRQU5wL2hURU5ZRWhPaWhwMnhQ?=
 =?utf-8?B?VHF1cTdsREpGNGxWb25hc1VwUGpCWUE4UVg2Wm5xQVhGMzZKTzJEK0pXNmdi?=
 =?utf-8?B?SmRvMWs4VTJuQjhmZThEemkvcWVPc1YvVy9DU3F6USt6OE9tNytBdUFFVWZu?=
 =?utf-8?B?Tm9XbDVkd0lnQmw4UkJEeTJkaFB1NU5nN1ZrQU5aTFdneGpRdHNuMlRTWG56?=
 =?utf-8?B?T3dFaENxWjFqSStDd2M5YzhFWHBySFhxUUJ0c3JlNWpnN2pkb3IvSlRkd3V2?=
 =?utf-8?B?Qm5VSThjM0pLSU9hRVZ3QlV1UE9VSHFPKysxTm1wbldzMTUwYzlXaStLWmQ2?=
 =?utf-8?B?RXhuYkNlZ0J5Vjh4MWd2eVo0bGl6RFdNOTF2Q3FzWXh0MDFKandmN1FHRUto?=
 =?utf-8?B?OXg2OVJKU2FwY3VIN3pZUk55U1N2QUcwYmd4alFJTWUzeVlhVHdzVDF6YTVw?=
 =?utf-8?B?aHFab0RXSnRuL01wbnF2WTl2VUhvMVQxZ29sNUUrS2FJRHhud3RmaHVSenox?=
 =?utf-8?B?Nmpzd2E5WXlUQWlHZW9HK05OSkJxQURFRU1yQkkrVjcxZ0lyS2pZVTdwSjg1?=
 =?utf-8?B?cHZRWmtZVjZYLzJnWkk2SngycTFSQUpUZlUxQWRrc0hMM01Ga1ZYT3QycGt0?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7E6DEE0B31F4B41B127F29C551517BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae033d4-b38e-4a22-116c-08dbcffd07a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 17:09:46.4413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKW+4xlgr/L27oVZmjua9sbt4Nx7rNqjb+Xq6q5NYolrcd+NvHri9yvTiZXARy6z862iObQ6v2h/XLZfJ4ZWOnYujnZ6jxhkwXfO2Y1jUY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGluayB0byB3aG9sZSBzZXJpZXM6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMx
MDE3MjAyNTA1LjM0MDkwNi0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tLw0KDQpPbiBXZWQs
IDIwMjMtMTAtMTggYXQgMDg6MjQgKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBP
biBUdWUsIE9jdCAxNywgMjAyMyBhdCAwMToyNTowMVBNIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3
cm90ZToNCj4gPiDCoCBzdHJ1Y3QgY21hOw0KPiA+IMKgIA0KPiA+IEBAIC0xNjUsNyArMTY2LDcg
QEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgcGFnZQ0KPiA+ICpkbWFfYWxsb2NfY29udGlndW91cyhz
dHJ1Y3QgZGV2aWNlICpkZXYsIHNpemVfdCBzaXplLA0KPiA+IMKgIHN0YXRpYyBpbmxpbmUgdm9p
ZCBkbWFfZnJlZV9jb250aWd1b3VzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gcGFn
ZSAqcGFnZSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemVfdCBzaXpl
KQ0KPiA+IMKgIHsNCj4gPiAtwqDCoMKgwqDCoMKgwqBfX2ZyZWVfcGFnZXMocGFnZSwgZ2V0X29y
ZGVyKHNpemUpKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBmcmVlX2RlY3J5cHRlZF9wYWdlcygodW5z
aWduZWQgbG9uZylwYWdlX2FkZHJlc3MocGFnZSksDQo+ID4gZ2V0X29yZGVyKHNpemUpKTsNCj4g
DQo+IENNQSBjYW4gYmUgaGlnaG1lbSwgc28gdGhpcyB3b24ndCB3b3JrIHRvdGFsbHkgaW5kZXBl
bmRlbnQgb2Ygd2hhdA0KPiBmcmVlX2RlY3J5cHRlZF9wYWdlcyBhY3R1YWxseSBkb2VzLsKgIEFs
c28gcGxlYXNlIGF2b2lkIHRoZSBvdmVybHkNCj4gbG9uZyBsaW5lLg0KDQpBcmdoLCB5ZXMgdGhp
cyBpcyBicm9rZW4gZm9yIGhpZ2htZW0uIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0Lg0KDQpG
b3IgeDg2LCB3ZSBkb24ndCBuZWVkIHRvIHdvcnJ5IGFib3V0IGRvaW5nIHNldF9tZW1vcnlfWFhj
cnlwdGVkKCkgd2l0aA0KaGlnaG1lbS4gQ2hlY2tpbmcgdGhlIEtjb25maWcgbG9naWMgYXJvdW5k
IHRoZSBvdGhlcg0Kc2V0X21lbW9yeV9YWGNyeXB0ZWQoKSBpbXBsZW1lbnRhdGlvbnM6DQpzMzkw
IC0gRG9lc24ndCBzdXBwb3J0IEhJR0hNRU0NCnBvd2VycGMgLSBEb2Vzbid0IHN1cHBvcnQgc2V0
X21lbW9yeV9YWGNyeXB0ZWQoKSBhbmQgSElHSE1FTSB0b2dldGhlcg0KDQpTbyB0aGF0IHdvdWxk
IG1lYW4gc2V0X21lbW9yeV9lbmNyeXB0ZWQoKSBpcyBub3QgbmVlZGVkIG9uIHRoZSBISUdITUVN
DQpjb25maWdzIChpLmUuIGl0J3Mgb2sgaWYgdGhlcmUgaXMgbm8gdmlydHVhbCBtYXBwaW5nIGF0
IGZyZWUtdGltZSwNCmJlY2F1c2UgaXQgY2FuIHNraXAgdGhlIGNvbnZlcnNpb24gd29yaykuDQoN
ClNvIGZyZWVfZGVjcnlwdGVkX3BhZ2VzKCkgY291bGQgYmUgY2hhbmdlZCB0byBub3QgZGlzdHVy
YiB0aGUgSElHSE1FTQ0KY29uZmlncywgbGlrZSB0aGlzOg0Kc3RhdGljIGlubGluZSB2b2lkIGZy
ZWVfZGVjcnlwdGVkX3BhZ2VzKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgb3JkZXIpDQp7DQoJdm9p
ZCAqYWRkciA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsNCglpbnQgcmV0ID0gMDsNCg0KCWlmIChhZGRy
KQ0KCQlyZXQgPSBzZXRfbWVtb3J5X2VuY3J5cHRlZChhZGRyLCAxIDw8IG9yZGVyKTsNCg0KCWlm
IChyZXQpIHsNCgkJV0FSTl9PTkNFKDEsICJGYWlsZWQuLi5cbiIpOw0KCQlyZXR1cm47DQoJfQ0K
CV9fZnJlZV9wYWdlcyhwYWdlLCBnZXRfb3JkZXIoc2l6ZSkpOw0KfQ0KDQpPciB3ZSBjb3VsZCBq
dXN0IGZpeCBhbGwgdGhlIGNhbGxlcnMgdG8gb3BlbiBjb2RlIHRoZSByaWdodCBsb2dpYy4gVGhl
DQpmcmVlX2RlY3J5cHRlZF9wYWdlcygpIGhlbHBlciBpcyBub3QgcmVhbGx5IHNhdmluZyBjb2Rl
IGFjcm9zcyB0aGUNCnNlcmllcywgYW5kIG9ubHkgc2VydmluZyB0byBoZWxwIGNhbGxlcnMgYXZv
aWQgcmUtaW50cm9kdWNpbmcgdGhlDQppc3N1ZS4gQnV0IEknbSBzb3J0IG9mIHdvcnJpZWQgaXQg
d2lsbCBiZSBlYXN5IHRvIGRvIGp1c3QgdGhhdC4gSG1tLi4uDQo=
