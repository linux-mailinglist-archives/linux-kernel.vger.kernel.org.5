Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448EB771837
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHGCRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHGCRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:17:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2D1703
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691374618; x=1722910618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mlXqN/ecLzLJxVm7YZhZEcsZ8jxsF64sfBAhzLoxbPA=;
  b=ab5+kqY4/EEyFFp6rmTI5dgWxc0ibLgqr2BVO4vNS/spnXUnLYJsq1rW
   ITwxG6hDeTBBSkqlad9tsbwqVTrXlNDR8F6ysMt9lc/FVH7qjg0qiMPh+
   ocJh8Yx6K6vhSYBD4iMxHkVRb9B47JYc+2KOvhqZzqYpzSqcN6pF0tGtP
   ZdISWaqVzqm0dkc3ayqeVvSC8B4F6pcrpj0VQ2IJR07tgLYrkrpu/YOvD
   nWIWcz+umuePyj9Tmo1UONlfz/uNkH0a+qjNRbTEM4h5fn9OHOrpg6uJI
   2V5Se/cD7MLBM6cmQCBAyEqkXTwFVbaQQOdknETTUZCN4KBegUVfjzNAA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="373189596"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="373189596"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 19:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="796115928"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="796115928"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2023 19:16:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 6 Aug 2023 19:16:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 6 Aug 2023 19:16:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 6 Aug 2023 19:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEnKFyi51XsquQZ9lhVGx1TBuvAHAyTUMf+5dwFVZO8EByrYEt7jwlzT4kF2fVArLk8MB6vfBsHBZX9FYa1gOahO4Lw+ulDTP0MHbuxIKLssG8eQ9pa8VUxuIgujkrWgTW3MfgOZh7JqTi2S1m0GbOrivZgBpJMIH3yku0sG1y3cmTCLzV4Jw5WTITO+uNxEM4l88w+fZzv1Efbm+cSqUwDSMzB6aqvsD5hCsm7H07FEugaxDMHv2yjHpiN78MCMUsQtigfxlC2e+f7r+CQZH654t7/+lNoEGEAjhGfekltQWBiklmLg/N3wMavRfaDev/jCKpLIC7lJbLrV4zZHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlXqN/ecLzLJxVm7YZhZEcsZ8jxsF64sfBAhzLoxbPA=;
 b=EEvG+Hs9WB8W4nOdQ1txEWN5jhyPxhs3Z9CY+WunS13OVkxtrx+P9XLw1k9Bkz0btoi7hoKAm89j0tdiQ8Fe02RYurchWNhdXWXUw4XUpXqwdMfr359MZGCv/eQnu3QWxzyf3saN5OkXC261KKCHig9GuPBnZ1/FHQr4p9Ls6b7R8uicCX1CMwFgGZkzWxMUTgfxB+k7ZsD4lyjfpnCD1Z4Vbvy1ODIRk7AelAMPmSu5pNR5T9tyyKdpPN5YPrWr5fNOmyMcZ8xllntgsejIRsG4XGAU+IQ2kDu8WGwRsklwSvb+ADXGp2Pe0AZWJmjn6Bo/FwRVYhUkytQDMR/zgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 02:16:50 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 02:16:50 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args' to
 use x86 "register index" layout
Thread-Topic: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Thread-Index: AQHZv7EuDeTmYmtxiU2quJkSiZ2kg6/dOPwAgADyEQA=
Date:   Mon, 7 Aug 2023 02:16:50 +0000
Message-ID: <b62961e38598c771ab83a5b8b158d8fcdf6df963.camel@intel.com>
References: <cover.1690369495.git.kai.huang@intel.com>
         <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
         <20230806115024.k3oc6u3yu42q7h5l@box.shutemov.name>
In-Reply-To: <20230806115024.k3oc6u3yu42q7h5l@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB8179:EE_
x-ms-office365-filtering-correlation-id: d2a71d38-17b0-4fd4-7a26-08db96ec5c1c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEwhzs7EuurM65H2YyuPfSi6NfyPmHj44+xpYZ3Tsr0pU0wiWVK3PFqWAb2ziE43tB43/INdOXnm2YUDcnx2HdoV/PYaL0218HXA5S30G/4mQNLV1F59TwCmJgYUohEfP5PzfVls8ERmL6cl9Zg5+1mA/mXWhpl+HBOuSO96Ufaei+ZBXo/C5gPJChYaCbH66zaxKWwA6ZZYe+aYziR442XOlfxk1DD3dURhv5k8mIclvTC7FkdeKILFfDVnYkrlsjAPAgJGyzLOQho7V1d1bXPJfFmFJvJpzes1mxCRd/Z4C73QID8bYvSWfXR3tEQpNCCVNrDchpSSXrc3AeZFj0mfdJE+7vJBPVJS93Q6UZfJMdDMtssCl/yuNqYboMNj7lXST85pz6BTQC/qu8OSMYEZ8KIgGb/tZFcJGvTW8VI9oComEHJqIAgStxq/kABf4XBr4rzXwz1jmFTypGh/PDMbpxs9suZ2BluVpd8TP+OjgJAuGtgZPXQgkUVqwFY4N8utu34skLBUCuW4jp9jtg6dOKDhhMRjfrIFyMDrrYatHmQE1qQpPp8NQalH6oAc4coXSAJ6vySmiiNePW/zLKuIJMZxwaKM4yey1o+e91s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(186006)(1800799003)(2616005)(36756003)(966005)(4326008)(6512007)(316002)(6916009)(86362001)(122000001)(478600001)(82960400001)(54906003)(38100700002)(76116006)(91956017)(71200400001)(66946007)(6486002)(66556008)(66476007)(66446008)(64756008)(6506007)(41300700001)(26005)(38070700005)(8676002)(8936002)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckJjc3JaN2lNTURERng1MWdLNFMxWi9ZMTZLREF6ZnpybDh1TXB5TzhvZXlB?=
 =?utf-8?B?cTlNZTFTc1VkbmFJSDZkR01WbU13WkY4Mjl5ejI2NjJEWVMxRlJ1bXBCeVVn?=
 =?utf-8?B?d1MyMEpiUTNadE1KQmFiVVlHZVI3QmRUME4wWmp1YnhUTXdSY2dXYzZONnBr?=
 =?utf-8?B?VFpiUXBkbk96c253V3JGVXpiTWlLbVlnYnp1TXo4djRSeDN6aXdnWE5DOEJM?=
 =?utf-8?B?a1dIU3c1b3NTWitSdStpNU94djlaSjAwQjVoejFsZnRiaTJacTZaT1crc2tz?=
 =?utf-8?B?Y0RaNnN6Wk4yVVY0TWR4VFhId3UzVWNNRUxDOGF4bmdkcG10eUVRNzV2eDdm?=
 =?utf-8?B?Y0lEOENkTE42STgwVzBuUE5uRXV4V0ZDM01vNjFSd3Z1VU12dWxWMDdtZVh4?=
 =?utf-8?B?OUcvREI5RlBRWTM5TDFta3djZERvQUg2cWIwSFVTVXhYRVBYQVllKzFqOHVE?=
 =?utf-8?B?dS9LcjdncWtsanFsWHVncVNlT0tQYTExek41ZlFZQ3JjTHR5M2VuUDFLYnA0?=
 =?utf-8?B?cUlYd1RFaVBGKzlZR3p1U0xMVklrVTVZOUlKWTZtMW9rTUdGUnQ4a3dJdENW?=
 =?utf-8?B?QjgrTy93cFR4eTZubjVyWm5wQ1RpNlBUNXVyMTFvWnhhd2haQmh4UkVqOWNw?=
 =?utf-8?B?MkIwSXlXUFFZNHBBSU1lVGlRdkhWU0NxMkI1c3dVWTJZakJ5TFFKNlFNb2RU?=
 =?utf-8?B?TEVNUzBmbGYra0tHVUNoZHJGS1lhcVFxa013ZlF1VVh5Y1MrRHd2dGxNWkRL?=
 =?utf-8?B?MVV2Q1B0ejIwME9jZGRBS0RYY0gwQjRONkhnN0R3Sm1SOUd4Vm9OUlNMOG1W?=
 =?utf-8?B?blQvV0xmT0ZXcmtIeEZHbVA4TkJtMTI3Z3BadHBpWUhORkprTEFLQUhGZStE?=
 =?utf-8?B?Umo5elpDOWo1TFBjdHpUY0wxVGQzTGxiandkSEpRNDkrVmtBSTBsY2JmUThq?=
 =?utf-8?B?YTUzdlF3aWEwN3dZZFkwb0NoOXlOOFMra0pXM3ZEbTY4VGxzVTNNK2huYWpS?=
 =?utf-8?B?ME9jQ1hQZDNuVDliRWpZYmR5MGdhVVdHR1dJa2VRa0REWldqRm1NT0lXQ1pR?=
 =?utf-8?B?c2FsTmIwdXRJZ2srRmNZM2RVb1ptbkRJdm1FNmxEcTc5dys3cDR3dHBxdFd0?=
 =?utf-8?B?WGtMQ2JJSmtMV01NbkZOU21OOEVjTEVnRWdWdnM3OUtMdlo5aUx1WXdxSjdW?=
 =?utf-8?B?UTNieTA2MFBHRCtSN3IxSGRUWkhZdlB2MXl0WStjQkxmcWg1eWt3NkIzcFkw?=
 =?utf-8?B?MGRHNkhza05SUFQycTJqcnNVZkFMd0JINWRoNSsyQUc0VVJ2Y1MrY0xqZTVF?=
 =?utf-8?B?WjN5VzBNMi9ORVcxWldiazdQM3kzbGlsdndxN3lVbVdQNHhZb1k1VjRuZ2VO?=
 =?utf-8?B?Q09FRElTSGZNejh1Nml5M2t5ZFdiZldpSndhaFZuRDg5U1pmRk1sa1A5Qm1J?=
 =?utf-8?B?NXdvQmpIQzZQbzNvcHF5RmphSzFCek1UWEhOV0JMRlBCWDlaZWNTWGZFOFpP?=
 =?utf-8?B?cFppYTZreEJUSDEzRlN3c2phMGlidkx6MmhyTHNSRlUrNExKTmhUR0VySHFR?=
 =?utf-8?B?bDAxYmNNdDRuV2JtZmpWNTZNb0wvYXNUTFg5cFF3Zm5JcW5wRFRXbmxKVE02?=
 =?utf-8?B?U0hnYzhWY3Ezd3VtRFc3U29PVGd5WUZCR2xpblhPcnBNblZBbnFsNThIVUpU?=
 =?utf-8?B?QVp3YlYySU4yRXlUS21tQ2d3N1IxcFg3Y3pKSVFKMWx1b0w5MU1zUGpoS2FU?=
 =?utf-8?B?eFZhOXJlcnFzbmZUNU4xem5pditvaXc1Q250OGJ6MUZPNDE5SW13VHE4MWQv?=
 =?utf-8?B?MWxlc2xnWGE2QTg3bm5rTjR5VUNkWEFXL0xxR2szbFFUcDl5dDgwQ3ZSL0lB?=
 =?utf-8?B?VUlKakZ0QUlVcUFya3FCU0xHSjBBVDhBWUZBb0trRW1Cc2VMd0pZd0dNa1Bx?=
 =?utf-8?B?SU5VSmVETGhIbHVCaFR6UXZpdnlRSW9UTXFhbEY4aVlhSUtNbEwxcmxGVlpj?=
 =?utf-8?B?dFFMaXFhWHVLL3JpNXVzakpHZTg1NWFxNmFwTjExNnRPOU1kcldUV21kU3VH?=
 =?utf-8?B?dFptcjMxQ2ZQMUV4eDNiMHRaZzJRRUFtVmx3VTdCbE1MVVRQNzN5T1JzWDhR?=
 =?utf-8?Q?obUQP9XGkUAYxj1CJ9Xzb6vps?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C174C6AAFD7B7F4BADD7A773E3B5E92E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a71d38-17b0-4fd4-7a26-08db96ec5c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 02:16:50.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9TXNcCMYkxk/kuvfo2Wh0UxjsYtGLh1hCYEuH8zzt2Hwim55RSAsqsFssdoeEjl+buOPqaB25pK87s0NIdcYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA4LTA2IGF0IDE0OjUwICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBXZWQsIEp1bCAyNiwgMjAyMyBhdCAxMToyNToxNFBNICsx
MjAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gRm9yIFREWCBndWVzdCwgS1ZNIG5lZWRzIHRvIGNh
bGwgX19zZWFtY2FsbF9zYXZlZF9yZXQoKSB0byBtYWtlIHRoZQ0KPiA+IFRESC5WUC5FTlRFUiBT
RUFNQ0FMTCB0byBlbnRlciB0aGUgZ3Vlc3QsIHBvc3NpYmx5IHRha2luZyBhbGwgcmVnaXN0ZXJz
DQo+ID4gaW4gJ3N0cnVjdCB0ZHhfbW9kdWxlX2FyZ3MnIGFzIGlucHV0L291dHB1dC4NCj4gPiAN
Cj4gPiBLVk0gY2FjaGVzIGd1ZXN0J3MgR1BScyBpbiAna3ZtX3ZjcHVfYXJjaDo6cmVnc1tdJywg
d2hpY2ggZm9sbG93cyB0aGUNCj4gPiAicmVnaXN0ZXIgaW5kZXgiIGhhcmR3YXJlIGxheW91dCBv
ZiB4ODYgR1BScy4gIE9uIHRoZSBvdGhlciBoYW5kLCB0aGUNCj4gPiBfX3NlYW1jYWxsX3NhdmVk
X3JldCgpIHRha2VzIHRoZSBwb2ludGVyIG9mICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzJyBhcw0K
PiA+IGFyZ3VtZW50LCB0aHVzIHRoZXJlJ3MgYSBtaXNtYXRjaC4NCj4gPiANCj4gPiBLVk0gY291
bGQgY2hvb3NlIHRvIGNvcHkgaW5wdXQgcmVnaXN0ZXJzIGZyb20gJ3ZjcHU6OnJlZ3NbXScgdG8g
YQ0KPiA+ICdzdHJ1Y3QgdGR4X21vZHVsZV9hcmdzJyBhbmQgdXNlIHRoYXQgYXMgYXJndW1lbnQg
dG8gbWFrZSB0aGUgU0VBTUNBTEwsDQo+ID4gYnV0IHN1Y2ggbWVtb3J5IGNvcHkgaXNuJ3QgZGVz
aXJlZCBhbmQgc2hvdWxkIGJlIGF2b2lkZWQgaWYgcG9zc2libGUuDQo+IA0KPiBJIGRvdWJ0IHRo
ZSBjb3B5IHdpbGwgYmUgdmlzaWJsZSBvbiBhbnkgcHJvZmlsZS4NCj4gDQo+IEkgcGVyc29uYWxs
eSBkb24ndCBsaWtlIHRoYXQga3ZtIGltcGxlbWVudGF0aW9uIGRldGFpbCBsZWFrcyBoZXJlLiBJ
dA0KPiBzdXBwb3NlIHRvIGJlIGdlbmVyaWMgVERYIGNvZGUuDQo+IA0KPiANCg0KV2VsbCBJIGtp
bmRhIGFncmVlIHdpdGggeW91LiAgQnV0IGl0IHNlZW1zIFBldGVyIHdhbnRlZCB0aGlzIHRvIGJl
IGRvbmU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYTIzY2U4ZmQyODkxNDFjZWEz
YTFiNGYzZGFjZTIyMWRjYTg0NzIzOC5jYW1lbEBpbnRlbC5jb20vVC8jbTM3ZjM5NDkzZTlmMmJm
MGE0YzljY2M3MmFhZjQ5Mzg5MjczNzVkYzENCg==
