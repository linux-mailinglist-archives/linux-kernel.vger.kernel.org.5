Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB5D7F23BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjKUCQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:16:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E480C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532964; x=1732068964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C1l1zbDYO85gdzIttCScxRhhoUDz41tFNlBrcYIOB7s=;
  b=KpuTe0HTdLBkspNT8OcmkTHKBQPiCsfDsDYyX6P1D7uc2KgqXQvIDuer
   PKjBefC7sgj1hGyg/Bs0DcrDbIEwRQi4GrGfWi0DY68UknH/adWuHDfrA
   dr+yT8opNkuXaUOGTCGhCQdgDADNN058/h59qxrsA3+N/xn6d5LIUoLjJ
   6kUBrFpt/iHRgBYoTyjMFZdXsgoIn0Wbx/kyx4gsTA8VKnW9DjW7pT7CP
   bb1WVdumJS+AZoJxviwtcNIz/xbPaA+p5Afhxm2FzvQdfxhxZKjcf5MZ2
   /E/66klk2X58c6SKRLgNFb8lfpcFUh+D9u9kKkc9tN5YnPXIenS5i/2Af
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="10415177"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="10415177"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716392486"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="716392486"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:16:03 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:16:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:16:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:16:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRLe+BHmORXrkgxPnipzp3qTy0Uqlkgk0wughu8HLhxybKedlovysUgLBZFnQmRPdunSw1AkG4h9EhX5in+T6Bo+dktUk+oo4uYIiI1OmVBzLkV9LE9GtaMdiD8eVwoUhEcgCQU8GOhhiqyxHh6KG21hx2+c7l/zaNMHwceUS2rRWGezACUlVVwKNaQYRmUweijQvOHzN20yDmrIeUgS5If4j8uhrjKegJZVDh5mgf7+4b2nE2UnXAV8ZF6ow0XYmqcaH6kcWgdlw7+qFVANgTUC7pqZ89wxbFVUF4UfVU8KlWGdgGN7/3s5zd7yKCZqXNvQOOWy1KAS227NdSNiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1l1zbDYO85gdzIttCScxRhhoUDz41tFNlBrcYIOB7s=;
 b=MgEiiDX6lyVYjvn7kN773px/adDaZ8RXMR1UQ86RKilwZ0wgVMwRVMSb7YSbUY2CTt2HyJa/3BLZj7P1CprjrFsynFMPm0tmaO/makIs9mOHsT0w3CVLygz6LlvC03tVqqBMV4LPlbcENoVtWoXtLpSEhLtqxTZMTejkvDvagnt4t9azn944ELNaaSUkR3/qMYuKgAiVw7wRawq8UMXqEWinoHY1T9VoHzuX0YqMo4YCb4OjG3KWoK6tkIXeW2FBuIodYT3PEIZ9f/+s5Jse4Oy9g4GVHUZl75zjavcni9b7CxJHR5342H24Oe0eRvkOsma7jCwqGwUyHx++47HR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 02:16:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:16:00 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Thread-Topic: [PATCHv3 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
Thread-Index: AQHaF7t0uC/HCaCpGUa/jrwdAjWU87CEEdgA
Date:   Tue, 21 Nov 2023 02:15:59 +0000
Message-ID: <dbb07c1ba14dc1bd3066aa8b784b884c67638ac1.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: cddd2a2d-d808-4451-cb00-08dbea37cdcb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AiyeAE5bLsjUBAm6z+umDxRZVi83dKHdhUy9JyeXyZwx5U3PYq23/4I2+q7pVFAiMTd8Ik4CvUVoRRNF/TJN6/8Z2nLfUXMEzUSAEceK7YYEWtOoBrV9jA9NEu3vdFVN3BJ9grmPTRkBY6C2M/kxwXVzM9leMlucbh8ga2URNxQYlzbmeOPm0Gf2l+GJ0QOx7hwvkK3iAi0CTVQZLGQN/C4c/ldzaVcG/EYSYJ54vH6PTVOgIwKIsAwBjVl3D2RmTJgxkc10YcCZ4q8w+cRxVu/L/zfx+aGPzXZz81qxKWHp3mYuWUfYaArlYWBgd4cU1y+8sdSy2iIbTW+KQOBWIEshoS/+Pte/7qUGsyxP8W4yy1Gl0QXEJr4VN6RD8tS555Gqr8/RXutXiKqlqjebsw/jIcMuLlsKQqSufv09UNQxvQXnq8Up78fInWLOcs4Un2o3dWzU2aYPA5tvP/LiY7mky4Z+Itck9BT+QsNN+1309t9l3oOT1NykXJs0fZWWkbwMyG03SppUS4nN7T9ovnVhwx6sbLLsXMv7iO8/UBPoiF0p6wdLncwVscWhPLRgI12lSkl2vCTAIpzqF9cRKXS62XCe8lHMoOSyoGMHkVYZZlNwls3uWa45DmJHdhTh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82960400001)(4001150100001)(2906002)(122000001)(38100700002)(8676002)(8936002)(4326008)(86362001)(41300700001)(5660300002)(7416002)(71200400001)(6506007)(64756008)(66476007)(66556008)(54906003)(76116006)(66946007)(91956017)(110136005)(316002)(66446008)(38070700009)(478600001)(83380400001)(6486002)(36756003)(6512007)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlFpT1FwUGwzMVFSQTNKS3NpL1VDaUJtZWRQRnpDQ0NkMjhJOFBZVW0zd2xW?=
 =?utf-8?B?M2kxL01yZVNxdW9kdHduQ0lHTnAxdXBpVjU4L1dQRVA4WkpvVUxGek5rNDJu?=
 =?utf-8?B?ZHVSOHBqSWY5VTJvSHBiWWs0UEFnM0hNRU5rYTlBendsdnYvQUs3Nko5cFpC?=
 =?utf-8?B?WWFPTVUzY3UxWlRFbTE2bnhjckN1eUs0Nkt3dmVCZ1A4OTFERnp6cDhyY0FH?=
 =?utf-8?B?ak0vb1JaTVZJTWExTXlhSnIzVjRBcUVJbWE2R3pkUUdRbXh3SEhEV3hVVlRO?=
 =?utf-8?B?L2pFL3hqUXpQK29QYzN2cEZLN3BhdVJaK2dUREdXRDlMajRDWEg3N20vdms2?=
 =?utf-8?B?UGV2em5EWDFoNFlRbVViRUZpYmtrSkhpMThMMEZSYXU0QTlEUUhYWGZWaXNh?=
 =?utf-8?B?M3BCTEo3WjNGWVhxdDBGMGZhTkxjUDVXZ3hkQlY4cDViREhLVklla2k4cWY0?=
 =?utf-8?B?dzJkMjVsWjJoMWFiaFY0c3dURjJPL2tXa1lsYlhzYk5UcUFsT1JGc2ZhTUFD?=
 =?utf-8?B?MHNxc29nY0pJcFkvOEZZRWFTUEI5Yitvb2pBNGtjZUtVbzAyYVVKMjR5UTlo?=
 =?utf-8?B?M2lRMXVuUDF1T011ZlNxd2Y5aUhVQjZrUklVTkdlVU4vdk02eGYwRFp1c1Jh?=
 =?utf-8?B?aHJjN01jTzl0TjNFV1VjdHFjVmhuTlNzTzR1Ym5DUEhtUUhCd2JvYWcrWW84?=
 =?utf-8?B?N0dQRHcwcmFqU3JhYzNBeEpOT0J2YTBFblN0cmlLQ2NQRytqQ3QyUDE2OEs2?=
 =?utf-8?B?NkIrSS9PRTRzemNLZGwxR3BiV21vMkFpZjZQNCtlQWU3eSt6RTlmTThEdzFM?=
 =?utf-8?B?MkhiSCsrWVJERkE4ZjI1cUtleWFUZGYyS3U3RmV4Q1Z2LytDWitFUkVmRDF6?=
 =?utf-8?B?Rk9wdXUrM2RRa3pPd1dxMTBZS0pEV2pPZ3h6czVPWTBYVE00aGxjdmdITnZl?=
 =?utf-8?B?N0RQVkFoMm5IUzhGU2xMQXFydm1qM1lOQXBxS2hxWFFWQTZHSFRYWmFrWC9y?=
 =?utf-8?B?bmRTcXdlczkraUFLOGJwaHQ2V1hib3dEQVFzUEpmS2pMUlN5QzJHM25ySVRW?=
 =?utf-8?B?U0lXdkFzK3crY3Y4NkRFWnlmUE0wK0tsZVVxakZRWGxxcUlHMlVsaWVZMnp1?=
 =?utf-8?B?d0JyN3prV05uY0R2K0M0cDJFNVFKNDFtUGpPQkhxWTZLMkwrVUgwdUJna2FB?=
 =?utf-8?B?dVlaV1h1VEpqL1NzTG91ZzJrQU93ekNTMkxySUNiNHdtYTg0eWxRYTY0RDd5?=
 =?utf-8?B?VnRnZEYvVlA4NTN4bmg4MzgyMXQ0dUhzOWFrNzR4eHlBY3Y5N3p5NVhPZ0lU?=
 =?utf-8?B?MkVMcFFTL0xqUFIrNUlNRGVaMm1CV0lOU1ZsU0NwTUhzdjI1NkMyK2ZNOXdB?=
 =?utf-8?B?MHIwODRTT3YvVnd2aXQ1a3ZSWWZHaFAvMy9qNU9NWXpZN1JNa25iT3hVdXUr?=
 =?utf-8?B?M3dBbDFNUENZaVZEOHlENGc0cDA4L0RvMUR1VW53MVgwclJsSlIrNStnOFhm?=
 =?utf-8?B?a2hvWE9jMnlMQnNPQ05sZ2tDVWgrU054RmVBd25QeENEbU91c1FxdzV6WmNP?=
 =?utf-8?B?T3NYS2ZCS2h0TVpXOGhHR2lGRlBvdTd5OFJIcFJoL0FGT1BHbHJRQ3ViK0FU?=
 =?utf-8?B?dGtWL0ZCUFBtSWhwWU5vWkpKaU5YSTVscTNrbjBJWWt1VWNqTklWdGhXcU9r?=
 =?utf-8?B?K3hocnlQZlJNSUlTaE8rck9iK01BL0dhZ09VeExjcVU1RXg0N1JnZWdaUzgx?=
 =?utf-8?B?ckY5eENIdFN1R3R2R2FCQ1JMNGhwVDFlQ3dFVGEzblNIWGw0ZHpmZjM1blY3?=
 =?utf-8?B?QnNJNzM2YzB3aWJhSzEvM21CbS95VzdEYUNrU0UxMTFORFBjME5KVUxVN0hT?=
 =?utf-8?B?ZXdXVWN6NU1DZWZ6bXZ0WGZwUlNoS1ZhUkxyWDJYUGZBSXp5dHJMaXpra0Vm?=
 =?utf-8?B?WitIaXhqSEFtWFU1QWdEdGF1a3RjdkdRblNPdG1XMFdJc2VTWkwwMDYranAz?=
 =?utf-8?B?L2JlM2d2R3kzRG90SXNvYnJYUkR3bTZpNTlWR2RQUlZBV29zYzdOTjhGM21C?=
 =?utf-8?B?VjBtQUxDa2F6dmJkQmZNMmw2UTJKV1JHbjdPSHRnam50RHJKV0dlYmp6VHU2?=
 =?utf-8?B?NW1wN2FqcWJpdmZiVFRkcUtGZEkvRWRGUXJJVUI0Qk5PSFlUL3Yrcm84Q1pz?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14CAEC77AF43E743AE9D2350C8022D38@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd2a2d-d808-4451-cb00-08dbea37cdcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:15:59.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoYpq83fSZ+LUcQy0bBbzBfMrtDu4XGRBdCs48gB9BBrw4ZYAfeLs/vM3BmmuRn28mkVhBTNqXOmj+gPMl9yGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTExLTE1IGF0IDE1OjAwICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBBQ1BJIE1BRFQgbWFpbGJveCB3YWtldXAgbWV0aG9kIGRvZXNuJ3QgYWxsb3cg
dG8gb2ZmbGluZSBDUFUgYWZ0ZXINCj4gaXQgZ290IHdva2UgdXAuDQo+IA0KPiBDdXJyZW50bHkg
b2ZmbGluaW5nIGhvdHBsdWcgaXMgcHJldmVudGVkIGJhc2VkIG9uIHRoZSBjb25maWRlbnRpYWwN
Cj4gY29tcHV0aW5nIGF0dHJpYnV0ZSB3aGljaCBpcyBzZXQgZm9yIEludGVsIFREWC4gQnV0IFRE
WCBpcyBub3QNCj4gdGhlIG9ubHkgcG9zc2libGUgdXNlciBvZiB0aGUgd2FrZSB1cCBtZXRob2Qu
IFRoZSBNQURUIHdha2V1cCBjYW4gYmUNCj4gaW1wbGVtZW50ZWQgb3V0c2lkZSBvZiBhIGNvbmZp
ZGVudGlhbCBjb21wdXRpbmcgZW52aXJvbm1lbnQuIE9mZmxpbmUNCj4gc3VwcG9ydCBpcyBhIHBy
b3BlcnR5IG9mIHRoZSB3YWtldXAgbWV0aG9kLCBub3QgdGhlIENvQ28gaW1wbGVtZW50YXRpb24u
DQo+IA0KPiBJbnRyb2R1Y2UgY3B1X2hvdHBsdWdfbm90X3N1cHBvcnRlZCgpIHRoYXQgY2FuIGJl
IGNhbGxlZCB0byBpbmRpY2F0ZQ0KPiB0aGF0IENQVSBvZmZsaW5pbmcgc2hvdWxkIGJlIGRpc2Fi
bGVkLg0KDQpjcHVfaG90cGx1Z19ub3Rfc3VwcG9ydGVkKCkgLT4gY3B1X2hvdHBsdWdfZGlzYWJs
ZV9vZmZsaW5pbmcoKS4NCg0KPiANCj4gVGhpcyBmdW5jdGlvbiBpcyBnb2luZyB0byByZXBsYWNl
IENDX0FUVFJfSE9UUExVR19ESVNBQkxFRCBmb3IgQUNQSQ0KPiBNQURULg0KDQpJcyBNQURUIHRv
byBnZW5lcmljPyBNQURUIHdha2V1cD8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGlu
Y2x1ZGUvbGludXgvY3B1LmggfCAgMiArKw0KPiAga2VybmVsL2NwdS5jICAgICAgICB8IDEzICsr
KysrKysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3B1LmggYi9pbmNsdWRl
L2xpbnV4L2NwdS5oDQo+IGluZGV4IGZjODA5NDQxOTA4NC4uNDZmMmUzNGEwYzVlIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NwdS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvY3B1LmgN
Cj4gQEAgLTEzNCw2ICsxMzQsNyBAQCBleHRlcm4gdm9pZCBjcHVzX3JlYWRfbG9jayh2b2lkKTsN
Cj4gIGV4dGVybiB2b2lkIGNwdXNfcmVhZF91bmxvY2sodm9pZCk7DQo+ICBleHRlcm4gaW50ICBj
cHVzX3JlYWRfdHJ5bG9jayh2b2lkKTsNCj4gIGV4dGVybiB2b2lkIGxvY2tkZXBfYXNzZXJ0X2Nw
dXNfaGVsZCh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIGNwdV9ob3RwbHVnX2Rpc2FibGVfb2ZmbGlu
aW5nKHZvaWQpOw0KPiAgZXh0ZXJuIHZvaWQgY3B1X2hvdHBsdWdfZGlzYWJsZSh2b2lkKTsNCj4g
IGV4dGVybiB2b2lkIGNwdV9ob3RwbHVnX2VuYWJsZSh2b2lkKTsNCj4gIHZvaWQgY2xlYXJfdGFz
a3NfbW1fY3B1bWFzayhpbnQgY3B1KTsNCj4gQEAgLTE0OSw2ICsxNTAsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgY3B1c19yZWFkX2xvY2sodm9pZCkgeyB9DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQg
Y3B1c19yZWFkX3VubG9jayh2b2lkKSB7IH0NCj4gIHN0YXRpYyBpbmxpbmUgaW50ICBjcHVzX3Jl
YWRfdHJ5bG9jayh2b2lkKSB7IHJldHVybiB0cnVlOyB9DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQg
bG9ja2RlcF9hc3NlcnRfY3B1c19oZWxkKHZvaWQpIHsgfQ0KPiArc3RhdGljIGlubGluZSB2b2lk
IGNwdV9ob3RwbHVnX2Rpc2FibGVfb2ZmbGluaW5nKHZvaWQpIHsgfQ0KPiAgc3RhdGljIGlubGlu
ZSB2b2lkIGNwdV9ob3RwbHVnX2Rpc2FibGUodm9pZCkgeyB9DQo+ICBzdGF0aWMgaW5saW5lIHZv
aWQgY3B1X2hvdHBsdWdfZW5hYmxlKHZvaWQpIHsgfQ0KPiAgc3RhdGljIGlubGluZSBpbnQgcmVt
b3ZlX2NwdSh1bnNpZ25lZCBpbnQgY3B1KSB7IHJldHVybiAtRVBFUk07IH0NCj4gZGlmZiAtLWdp
dCBhL2tlcm5lbC9jcHUuYyBiL2tlcm5lbC9jcHUuYw0KPiBpbmRleCBhODY5NzJhOTE5OTEuLmFm
ODAzNGNjZGE4ZSAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2NwdS5jDQo+ICsrKyBiL2tlcm5lbC9j
cHUuYw0KPiBAQCAtNDg0LDYgKzQ4NCw4IEBAIHN0YXRpYyBpbnQgY3B1X2hvdHBsdWdfZGlzYWJs
ZWQ7DQo+ICANCj4gIERFRklORV9TVEFUSUNfUEVSQ1BVX1JXU0VNKGNwdV9ob3RwbHVnX2xvY2sp
Ow0KPiAgDQo+ICtzdGF0aWMgYm9vbCBjcHVfaG90cGx1Z19vZmZsaW5lX2Rpc2FibGVkOw0KPiAr
DQo+ICB2b2lkIGNwdXNfcmVhZF9sb2NrKHZvaWQpDQo+ICB7DQo+ICAJcGVyY3B1X2Rvd25fcmVh
ZCgmY3B1X2hvdHBsdWdfbG9jayk7DQo+IEBAIC01NDMsNiArNTQ1LDE0IEBAIHN0YXRpYyB2b2lk
IGxvY2tkZXBfcmVsZWFzZV9jcHVzX2xvY2sodm9pZCkNCj4gIAlyd3NlbV9yZWxlYXNlKCZjcHVf
aG90cGx1Z19sb2NrLmRlcF9tYXAsIF9USElTX0lQXyk7DQo+ICB9DQo+ICANCj4gKy8qIERlY2xh
cmUgQ1BVIG9mZmxpbmluZyBub3Qgc3VwcG9ydGVkICovDQo+ICt2b2lkIGNwdV9ob3RwbHVnX2Rp
c2FibGVfb2ZmbGluaW5nKHZvaWQpDQo+ICt7DQo+ICsJY3B1X21hcHNfdXBkYXRlX2JlZ2luKCk7
DQo+ICsJY3B1X2hvdHBsdWdfb2ZmbGluZV9kaXNhYmxlZCA9IHRydWU7DQo+ICsJY3B1X21hcHNf
dXBkYXRlX2RvbmUoKTsNCj4gK30NCj4gKw0KPiAgLyoNCj4gICAqIFdhaXQgZm9yIGN1cnJlbnRs
eSBydW5uaW5nIENQVSBob3RwbHVnIG9wZXJhdGlvbnMgdG8gY29tcGxldGUgKGlmIGFueSkgYW5k
DQo+ICAgKiBkaXNhYmxlIGZ1dHVyZSBDUFUgaG90cGx1ZyAoZnJvbSBzeXNmcykuIFRoZSAnY3B1
X2FkZF9yZW1vdmVfbG9jaycgcHJvdGVjdHMNCj4gQEAgLTE1MjIsNyArMTUzMiw4IEBAIHN0YXRp
YyBpbnQgY3B1X2Rvd25fbWFwc19sb2NrZWQodW5zaWduZWQgaW50IGNwdSwgZW51bSBjcHVocF9z
dGF0ZSB0YXJnZXQpDQo+ICAJICogSWYgdGhlIHBsYXRmb3JtIGRvZXMgbm90IHN1cHBvcnQgaG90
cGx1ZywgcmVwb3J0IGl0IGV4cGxpY2l0bHkgdG8NCj4gIAkgKiBkaWZmZXJlbnRpYXRlIGl0IGZy
b20gYSB0cmFuc2llbnQgb2ZmbGluaW5nIGZhaWx1cmUuDQo+ICAJICovDQo+IC0JaWYgKGNjX3Bs
YXRmb3JtX2hhcyhDQ19BVFRSX0hPVFBMVUdfRElTQUJMRUQpKQ0KPiArCWlmIChjY19wbGF0Zm9y
bV9oYXMoQ0NfQVRUUl9IT1RQTFVHX0RJU0FCTEVEKSB8fA0KPiArCSAgICBjcHVfaG90cGx1Z19v
ZmZsaW5lX2Rpc2FibGVkKQ0KPiAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICAJaWYgKGNwdV9o
b3RwbHVnX2Rpc2FibGVkKQ0KPiAgCQlyZXR1cm4gLUVCVVNZOw0KDQo=
