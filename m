Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062867D3D94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjJWR2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjJWR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:28:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD52E9;
        Mon, 23 Oct 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698082079; x=1729618079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g1VLlSRW2qLQJdWmee0yDR6OiFUbOX9owrXLY4gMmDY=;
  b=XuG/iUymZlop7Gd0TE8cmXfIawnYyDh0PG1tAjvwq27ShI5e+58O9xt/
   Hv9af+Xn3TmQ4y3EqQDaytK14eqYpjyvcPtUDt5xWZuDuH/EeFVupezoo
   8VU7wsitOZFUzV8tyWeOqzaO83osZvhb3Q7tILiraTxXHyWXE66/DP+Yw
   KPZ1o0gzTK0Krhb8NucC/4XOijvQUja9O5AnWvEAECB99vqgGljU2mWxM
   lrmOS9D24ypuSOOjsCYW/IaOSB+Bn8zqmIvk4PgEdtiUfDte1Abd4Yfqp
   kDCDyk/GecWDfVHtmq8M2Zee+ELzkeqmYsFNOtckAF6xKel+upj6NMmFj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384090008"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="384090008"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 10:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="881840055"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="881840055"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 10:27:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 10:27:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 10:27:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 10:27:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn/zLn/YtT+BMCOJ3LFaikzkikypytR5abcclhqFv1h+g/qJxiCTWBRHWTn2tguqAVKcAnZaXEGVD47adAfibGEPOr80s74q94YiJCz6chOiy04dc7L96dsMNSrTeh1eq1EQpkp0BAeBAh+h39fQ2Jb4CwkpSr6oti2zkN6gVfpXosIrjGiyP9EzONLLIjka4wRwLDXIcUUJI2KujnoGR+wCrvrsNB0J2ByVD3CE9s2B3ANhtO6gcGpvOEtrcxMGO6R3/Jyg3RXgLx+INziBk6XsVfkK1I7xmHzcDv4DzfucD4Pyrqf0XO1qKGBE/oMDEVkm9gi2eAra2Akj9Mk04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1VLlSRW2qLQJdWmee0yDR6OiFUbOX9owrXLY4gMmDY=;
 b=YfKlW1aYq8NMpdSYOK6wjyUltyj47rMNOD/cyCNcKzS+PtkcmTu+3nz5wldBT5/t6efNbVY5VKpe7qeozxZchPBx24FU7dpSJMIB+Zc1VKiwKD0/c6HSReb2XSiGvz9tlOXRhvNyKYnJPF/KEffRYY4fXOI4JZbVPVwkEfiUK2hFhV6NW+Zz8DypECoYV0kuQcDcAYhkanYmps4As6cET0wUwh4weYFu65bUJ7aIzi24IUE1OGvFZwMif3Ma20oz7kqktGySAnun9AFPKTvugdG9QDG4haYvKYZZvpg89U7p2zzbpmQhdp3s8G2pVnCEBkWNWqLUQLUp6vGPaQaBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 17:27:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 17:27:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Topic: [PATCH 06/10] dma: Use free_decrypted_pages()
Thread-Index: AQHaATgYbrh2vf9YMEisxdRJ1o7j3rBP0mkAgAfMBoCAAApBgIAAAUKA
Date:   Mon, 23 Oct 2023 17:27:28 +0000
Message-ID: <de63fadcd09dd9a24102a49a4c316fcbf0eddd6d.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
         <20231017202505.340906-7-rick.p.edgecombe@intel.com>
         <b4dc423b-a658-449f-9c6d-1502685a2f1b@arm.com>
         <ea8ad4e75303178ee907682797dea7de36441c95.camel@intel.com>
         <289f5f83-adc7-4077-b4c0-c951484dd092@arm.com>
In-Reply-To: <289f5f83-adc7-4077-b4c0-c951484dd092@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: e241e8e2-4e0b-4024-1516-08dbd3ed54bd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7b4G7ae8Lbrzw2rV1hhQ8Owei1cqPHtmfugl2kKPym9nfXReU3q0sJC5YjYILdxUBaDriy1EKvG1p6EnqZ0/Q8cDUV/BoWE75z1K6w913UE+49JUQJ1eU4to2K1Oy5y8M8t6OApYKrwwlH1yPzvZ9DSlvr/AQUbE6d348IOWEb0YxKyigtuTkKURPKVbB0/TBokv+2XI6WGhmGVG37uLetA6A7syavh8DJuonzXXbjztslnHpHUhnf1UEAkh4cUNXFAFyK4ZU6Wbc9Q52ICouaDHpCcWjKuxYsPG/tuQ35UW2bjQGKkkPATGfvx0geuUwVkPxRgTMe67w5YKJueLuS+/5WbdoHQlXwKcquDpuBgyF5vmyzct7w4Ef3jiZXOR+k7RM3c0T+RQsoKDrPFOH1QrgCEUTfb9Mk0+1cn9bmpFmhZAbBugr+odITIHZxtH2C11enWkXIvhYOsK9gRgAmTZUdZ/oYM/v6VbyAEAei7TskXF5KvN8PPIJWyR4SzkZY3RaSdMYJug6tN/nwfKrP6AHcK9yaj2CKv69Nr4ejEK37T/EXwS2j1y4j2Ihe6dec/UezueUuaYtdYwHX/q8NY7ts4z+QiEnf6Ti0iCY/5pZgHv7+tKPWJEuWb+LFDz1A1h4QxEn36my+poaCMZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(921008)(66899024)(4001150100001)(2906002)(5660300002)(8936002)(36756003)(4326008)(7416002)(8676002)(66476007)(66446008)(54906003)(41300700001)(66556008)(66946007)(86362001)(110136005)(91956017)(76116006)(6506007)(6486002)(478600001)(71200400001)(6512007)(316002)(2616005)(26005)(82960400001)(64756008)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhwN2hRSE5wZ25XMVpRVUtqY1Y2dFRaanhLVXJYdUxxUHZVNDVSWWIxZk5J?=
 =?utf-8?B?N29TeVJyYXV0b2lXQzFHaWlrajFQazM5b0VwQ0VJdmZGRTJISkJrN2ttZDA2?=
 =?utf-8?B?UkhTQXp4MVVPeUlCTDFjenB3K1l2czRBcldqeDVKTENURmFFTFF2ZHJGZ2NQ?=
 =?utf-8?B?WjJPMmdyTXlPZzMrcHlLei9zdXE2dnkzMjRNNkNUcDZnUEhVbG4vcUNPU1Bh?=
 =?utf-8?B?M01MWDduSHdQL0tHUEM4Z1ByVTZRUi9VN0txd1NMdnMzOUdwWlcyNFBURjhD?=
 =?utf-8?B?T29SNXlCQUtLbVYxVno1M3NFajRySVdlQ1VWZEFXTG1FV2srU202WXhZUE9T?=
 =?utf-8?B?RXg3YWtqMTg1Q1EwOGJhdHQ4cnhBUHNzUDcxamNaN0UwYmlWR3kwUUhtQkJh?=
 =?utf-8?B?YkV2Y1ZaUDAxY21Ec001MkEyL2Y0OGo4NTVYWDJuS1ByVEpCbFM1bzQ5eTcw?=
 =?utf-8?B?VjU3TnRYdW5ZWEpzckpmQ0pSUlpyeFRiTG15aEdPNndRckE3WXBTOHB4bkRs?=
 =?utf-8?B?bENlRE9ZamlMRFFPRlowSVlrdjUwOStlUWRkL1h2MHJ2UUdlZnd6cUp1ZTEv?=
 =?utf-8?B?NDRZcDBmS09FOTJtWEtUWTBGUHM3MmNPVnpiczFNRE13aVVPdXhjOU40SC9o?=
 =?utf-8?B?OEFJeXMrVitReXpMT0NNVng5MW51SjNvY1hVcFZyaTlwb1Z6UUM3K1NCUDZH?=
 =?utf-8?B?bW8vQkZPYWtMa3FESmZLSGdOMGQ4M0hpa2VmN3Q0VU1Ma1VoeUVqV0ZSRGNV?=
 =?utf-8?B?b2lvYmdacnZ0aE1zNTBkY0NVTkxqTWJVS1hYd09HNU5PZ2RnTUxyQmZJdXZu?=
 =?utf-8?B?dm1wWnBYUWh4bWFxQ1ZUTVhsT1BaYWZwYjlXVDRkNWZudUo4M2ZNWFZKQWc0?=
 =?utf-8?B?WGJ3TExlT3cwVUtYVnJ1UlBLR0d5RmZHTHhyNTBGL0dHYmZINjVxSG5NVk1p?=
 =?utf-8?B?aFY2V1JTSGxsbTYycHhKUTFTbU5hZ1pjeEw3c20xaHIwTlhFTWtQUVlWRVdD?=
 =?utf-8?B?d2c3R3ZRYTlaTWU0WHMyYTU1VTMzSzg2d2tKbXk5ZnNYZUFSQ3dNUXRNRVM4?=
 =?utf-8?B?ejdET05qNjNNK241cXI4WXhsNFBnWWlLZGdlTW55dHJtaEhleVFWWW1LN2pQ?=
 =?utf-8?B?ZDNvWlhVeERmcDZoTDRMZEhOeFdoNTFkd0VpdFVSQzhaT2Q1V3k1bTZlNUVp?=
 =?utf-8?B?cmk5VjlmNnd2UW9LMkJjTWUyYUhwVmNRaEViT291MHdzaHI5MVVvb2Y4UTRo?=
 =?utf-8?B?aVBOUHFxaE1keUpnUUNBaXZiYkFWbFRTNW8rSFhrK3RPRVEycFdxUit5LzZ4?=
 =?utf-8?B?RmUzdEM4aGs3SHRTUVZ2ZGdDcmVEL3FxaTZlVXRXbEM5Y25XZ0pZdEwxRUlQ?=
 =?utf-8?B?S3BpZllUNHZnZWdFdHlQb1RpenZlVW1mWTBEaU1pRUUyc0RoeVM1eGlFMmZG?=
 =?utf-8?B?MWV1ZWpNMUdSMHkrVTZzRW9abGNRN3ZXQkx4TWVZdHNCVFR0ejRtSHFFRnR4?=
 =?utf-8?B?Yk85WFBzTVhEUFRqL2UyYkRUK0hVSkpXb1owWHl3Qkl3eUx0bzJGeVVjRWxC?=
 =?utf-8?B?WXhJZlhXYjc3S3R6UHYrRC82bEFQQlh2aXlpc0NUOXpoMURTWEdpUjVhNUVY?=
 =?utf-8?B?c2hZR3pRUTZIbUtnK1U4UGx5WGNKUit6NG56QlBoSU9HeXd0NWZrcFpsZUpV?=
 =?utf-8?B?UHRwRE1rSHhraW9aSmk2T0dvcjM1bWhHa1FzY1N1cjI0b0JTbUdieXhwdTVV?=
 =?utf-8?B?WGdwUjVoaU5iWVlaeSsxalJRZWRrTWdLc3gxWTZPamltWFpqOXZ2dXRwSVpP?=
 =?utf-8?B?bGxhMG9NemxMaGRqejcrL09BcmFwU0NjSXI2VysveCtNSE85WFFrenRKcXl5?=
 =?utf-8?B?bGwxMTBjczZrTnVJRHNTM2xFZ3Q5Y21SL3l3Yk1NY3lydFJVTTYyZUgxbDFM?=
 =?utf-8?B?eDliYi9kSnRQR3R0azJ2M2JCbkNHNXlzNnpUNG5KY2I5S0RkVDlvcFVzdDhk?=
 =?utf-8?B?RWl4NE5rcFdyc3A4dDhPZG1LSTY4VU4zUERKM3dlTWxhUFZtZ2xhSUxhRUNx?=
 =?utf-8?B?QWtQRERmVlcydFZ2Vll5VnRmMDBZcE5rcGF2Rko5bEUyMjJRMFdDZWdZdHJh?=
 =?utf-8?B?UDV0bFd1R3hNZnNibHF0TVk2NTJxQ0tmM2FYWEZmK2lKNnJ2bVlQVXljbHRl?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44DF46867617146838D2F5157943395@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e241e8e2-4e0b-4024-1516-08dbd3ed54bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 17:27:28.5252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRzitWndB5bykyX/Es+tNEHJDEd4My4MVJEfCwWoYH+ZFpBQqni+NIu8Yh8tbXze9fjhvJpU+b6JKz8TUH/9Yd6PsrcGOBf1B5pJwhFLlYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
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

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDE4OjIyICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
ID4gPiANCj4gPiA+IElmIHNvbWV0aGluZydzIG5lZWRlZCBpbiB0aGUgZmFsbGJhY2sgcGF0aCBo
ZXJlLCB3aGF0IGFib3V0IHRoZQ0KPiA+ID4gY21hX3JlbGVhc2UoKSBwYXRocz8NCj4gPiANCj4g
PiBZb3UgbWVhbiBpbnNpZGUgY21hX3JlbGVhc2UoKS4gSWYgc28sIHVuZm9ydHVuYXRlbHkgSSB0
aGluayBpdA0KPiA+IHdvbid0DQo+ID4gZml0IGdyZWF0IGJlY2F1c2UgdGhlcmUgYXJlIGNhbGxl
cnMgdGhhdCBhcmUgbmV2ZXIgZGVhbGluZyB3aXRoDQo+ID4gc2hhcmVkDQo+ID4gbWVtb3J5ICho
dWdlIHRsYikuIFRoZSByZXNldC10by1wcml2YXRlIG9wZXJhdGlvbiBkb2VzIGV4dHJhIHdvcmsN
Cj4gPiB0aGF0DQo+ID4gd291bGQgYmUgbmljZSB0byBhdm9pZCB3aGVuIHBvc3NpYmxlLg0KPiA+
IA0KPiA+IFRoZSBjYXNlcyBJIHRob3VnaHQgZXhoaWJpdGVkIHRoZSBpc3N1ZSB3ZXJlIHRoZSB0
d28gY2FsbHMgc2l0ZXMgb2YNCj4gPiBkbWFfc2V0X2RlY3J5cHRlZCgpLiBQbGF5aW5nIGFyb3Vu
ZCB3aXRoIGl0LCBJIHdhcyB0aGlua2luZyBpdA0KPiA+IG1pZ2h0IGJlDQo+ID4gZWFzaWVyIHRv
IGp1c3QgZml4IHRob3NlIHRvIG9wZW4gY29kZSBsZWFraW5nIHRoZSBwYWdlcyBvbg0KPiA+IGRt
YV9zZXRfZGVjcnlwdGVkKCkgZXJyb3IuIEluIHdoaWNoIGNhc2UgaXQgd29uJ3QgaGF2ZSB0aGUg
cmUtDQo+ID4gZW5jcnlwdA0KPiA+IHByb2JsZW0uDQo+ID4gDQo+ID4gSXQgbWFrZSdzIGl0IGxl
c3MgZm9vbCBwcm9vZiwgYnV0IG1vcmUgZWZmaWNpZW50LiBBbmQNCj4gPiBmcmVlX2RlY3J5cHRl
ZF9wYWdlcygpIGRvZXNuJ3QgZml0IGdyZWF0IGFueXdheSwgYXMgcG9pbnRlZCBvdXQgYnkNCj4g
PiBDaHJpc3RvcGguDQo+IA0KPiBNeSBwb2ludCBpcyB0aGF0IGluIGRtYV9kaXJlY3RfYWxsb2Mo
KSwgd2UgZ2V0IHNvbWUgbWVtb3J5IGVpdGhlciANCj4gc3RyYWlnaHQgZnJvbSB0aGUgcGFnZSBh
bGxvY2F0b3IgKm9yKiBmcm9tIGEgQ01BIGFyZWEsIHRoZW4gY2FsbCANCj4gc2V0X21lbW9yeV9k
ZWNyeXB0ZWQoKSBvbiBpdC4gSWYgdGhlIHByb2JsZW0gaXMgdGhhdCANCj4gc2V0X21lbW9yeV9k
ZWNyeXB0ZWQoKSBjYW4gZmFpbCBhbmQgcmVxdWlyZSBjbGVhbnVwLCB0aGVuIGxvZ2ljYWxseQ0K
PiBpZiANCj4gdGhhdCBjbGVhbnVwIGlzIG5lY2Vzc2FyeSBmb3IgdGhlIGRtYV9mcmVlX2NvbnRp
Z3VvdXMoKS0NCj4gPl9fZnJlZV9wYWdlcygpIA0KPiBjYWxsLCB0aGVuIHN1cmVseSBpdCBtdXN0
IGFsc28gYmUgbmVjZXNzYXJ5IGZvciB0aGUgDQo+IGRtYV9mcmVlX2NvbnRpZ3VvdXMoKS0+Y21h
X3JlbGVhc2UoKS0+ZnJlZV9jb250aWdfcmFuZ2UoKS0NCj4gPl9fZnJlZV9wYWdlKCkgDQo+IGNh
bGxzLg0KDQpPaCwgSSBzZWUgeW91IGFyZSBzYXlpbmcgdGhlIHBhdGNoIG1pc3NlcyB0aGF0IGNh
c2UuIFllcywgbWFrZXMgc2Vuc2UuDQoNClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLiBJbiB0cnlp
bmcgdG8gZml4IHRoZSBjYWxsZXJzLCBJIHdhZGVkIHRocm91Z2gNCmEgbG90IG9mIGFyZWEncyB0
aGF0IEkgZGlkbid0IGhhdmUgbXVjaCBleHBlcnRpc2UgaW4gYW5kIHByb2JhYmx5DQpzaG91bGQg
aGF2ZSBtYXJrZWQgdGhlIHdob2xlIHRoaW5nIFJGQy4NCg==
