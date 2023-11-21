Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E07F23A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjKUCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:08:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0E3C3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700532522; x=1732068522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mmn7eVYcOlCt4CDAYYNp1OqyVyZ+afC4Hz9b2kcUQHE=;
  b=DtVH1jNwZ1XjHW+GkLX5pn2exhbmHDAyF6Ii1twSNksKBoun4cyJipuU
   XN7vGx8Y291rxUetj4YE0Ay08f9a0hs8wQttsTzJr6W6e+qs2LqAA3aja
   /nFKwL6MJnvTXd5dWGjUVnomL0u4P6FmlQJXA6BMX9R5Kd8gxQ/+E1cHL
   4KahgmKHg1LrFU0pA9+gcmfZMnS+R1oQMkQ3AaHxUa0eF9GLoXND+mgDB
   IP5+86o8FBzCQsVQasgbyp/01qWWrYu7cBylo8iTjtGZ7nZexELGtC5Mf
   yDnmZ+ddM3fBEBD5kJ5h9A6IP943b1nlkWCS1h72jd2wNHynAaX0WSmKt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13294386"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13294386"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="1097903550"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="1097903550"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:08:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:08:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:08:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOyvc5Yvb8A4fSsMTCXIjr5imyNolC6pmPr+IZ4ycI2g+l9snkmgDmo3OLGAf19s8tGzzkUh5teTN5QA1KElV02I3QYujXT+BJwx8v7sWej28y/Yd6uYE58vFYzrtCiunk4dRgY8X+DrkFO6IzsJSnuvqXPEklIrTr628NU+PtubOlgS2OqkFKouXKz8AtvvHo1wt4XfPg9TT+YG9ShYYe2ZgmCC/rAJHwbvpPraxEjWAYozhs9CT52umNqbnkLGFSa/EKB/CoJ7FjKWtnL9uxZ/RsB4Y952AV0wiQr5y2x27RgDbZNABI/MR+uIp/YFe4Y6VevuPPPp56ONB6/kSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmn7eVYcOlCt4CDAYYNp1OqyVyZ+afC4Hz9b2kcUQHE=;
 b=FZ4ZR6zvGUke/S9S67Je0/1Ieocj3N/pqq7zGRpyTlZT7cjJxxGtQv6j0lDhNYcVIgD0xOacszqM08jB8C94Mcf57+pueh8Smhw/1PoFDGH8m3V4Bozs7aYbpvReDe6Ghx4von6z4o0/RAIyqJxKB63bBSlu3z3VaCTY58hsyXU4RxvoipE2skl7ZAXKGqnTPQ/7noYXAVSGMo92VBmK5iw+Hc5DUoGWAFEvRhOfP3LvaR7D3GI8lewahg6wHodbcRONsCBrkfgC22RZqMfvaBksKMUq8ZWj+0X0LYy0/xZZXQG5vzzbkZMNQIJbsbf9+QsTUBopO1J1uR3K0u8cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:08:39 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:08:39 +0000
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
Subject: Re: [PATCHv3 02/14] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Thread-Topic: [PATCHv3 02/14] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Thread-Index: AQHaF7t2IRXWZKiMDUC1ORBuEcgjNLCED82A
Date:   Tue, 21 Nov 2023 02:08:39 +0000
Message-ID: <d2b8e1667c9f79da4b600ad36d1c9bd53353e7ab.camel@intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
         <20231115120044.8034-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231115120044.8034-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5016:EE_
x-ms-office365-filtering-correlation-id: b446a0d9-085a-4829-95b2-08dbea36c6fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EyoO2RALZUT5xvrGLX8g3RvY72TtU03jw7tWdPDpmm0OrjOIo+h1m92zWD+KnNZoRdWPEB5dL5scI9tvKBLOGqNy1EfUXazGiLkt8f2XsUtn0VTTr6A/CJj4z3jLMLrgcf86ABAgJfSwsdSaApt6ZMM2l0ebc0rf2G9bMyMLv/f/xlgFJukXAHbTsBL7IcWJjnWb6351xNumZwzNQVAQrEl+u3xBVw31r9vNZUZF0oUG89S59SSoiQuccSz/TdTzBIt3LU38wkC5w25DpqTj+uisoIrUIKbLzmEjI6nqq0IDdwvPROpNt6hQy5Q0ltkOnwViuZ7lew7u9FQqjQljMmmuKwza138fvUpGGjsy0KnSspY79DjW3075uO2R+onNFGSu7NAHq0eNAhSeDKfKsjnpYjatOYGAVJpYONluYUqfHNyXg9Z7XDl/MZ/o2v2heIHyb8sAOQy/w/pYPkJbkbkCPBMCbSkzhLEmUGwIdqda0WwKZQr7FHUSfUgrsQ30dIOHE4vqeQK1NYePXG4mAjSk2Qec7zLTSMNqpHh1Qln7jOfiE6o4N+LE4TzJ5GG55Ly1DUanZnFR6S2NRvh1tZ51Pp7Gn1j19RvSYRjuy77/Muq4guTybKY1tWT8SLm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(86362001)(5660300002)(7416002)(4001150100001)(2906002)(38070700009)(6512007)(26005)(82960400001)(2616005)(478600001)(71200400001)(83380400001)(122000001)(6486002)(6506007)(38100700002)(76116006)(91956017)(316002)(4326008)(110136005)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdNNUo2V1FnSmZHV2NGS21tT2hUUFBpcUN5Y084aFJWb3IrMjVYVnVNMXo4?=
 =?utf-8?B?cUttR3BUdjJKbjJIS1hOZmtrb3c2eVRDaG94OGU5N2tudnF3eWJxWlNMeU5X?=
 =?utf-8?B?OVpuWjJINDFJbDhST2crN1prdHlhU1UrMnd6MTNqMW1MSjlrZ3hpVDBBSEtl?=
 =?utf-8?B?MmJHWUVuUTFwV3VWOG43di9qYlh6azMzSm10UXZvN0k1T3lJbWRzTk1zVHJ6?=
 =?utf-8?B?TVpXWDJ6YVZYaVBZbThQLzVPMnUvb3g5aFBXUWdXMEhiRmNTTTcwUmtMYzFy?=
 =?utf-8?B?MXdsa0JLZVZrODJCTEhtYzBkU1RiVitOOXpnMTNUSG4yWUU2dFdnMjhpWWs5?=
 =?utf-8?B?NGJSK1duWlRrM2tjZG5WZUpKWEtPZno3cWFlSURQSktVcjBjN1ZQTDVhbG5k?=
 =?utf-8?B?cmViL04rNzJCMGVlNmtqbnJ0VHZxb2NOWVYzV1B0WU9Rc0h6Nlo1WkthRU9X?=
 =?utf-8?B?N0tLaXlPSExraklFTWE1czF1bmZwSlJQK1NaR0pNcWdvQVhxWDZGVVF1U285?=
 =?utf-8?B?VXRsT2M4RVAzUzNUMk1QSDR1T2xXL3VDUERwLzlMN29qSS9BVzVhcXhkVFZu?=
 =?utf-8?B?ODBPQm5xa0krd0tMNjhjMk1nL0lFdWN2OTY5ckZ3Y1BRRHdxNi81bzA1bGht?=
 =?utf-8?B?NXgwekxEY1VEUUVhWUhKRVJEakF1WmZ5OHNxWVlBd1FFdzNNREJGU1V0RUNh?=
 =?utf-8?B?MUNLQWI5bmgxdXU0UzVIdU9LcGp3RVYwT3ZCRUwyYzlkSlJHaGphV1JRTUE0?=
 =?utf-8?B?bkdST2tGZEN6Uzl0dXhuckRmOWVzUTl1eXA1R0w4SjUvaklyall1bitqUXJ3?=
 =?utf-8?B?OVZpU0dtaWU4V0x6ZmRwNXg0KzlqR3JqVG9zRnp0U2JFSzhCbytDSWtkdnI3?=
 =?utf-8?B?RHE0WjVJcEd2dXNmUjJRYmVXeGFzZkhvc0tjY0doN1JqMWgrOXZESGQxT3Ns?=
 =?utf-8?B?bnpZekVabFdnZDYzWXE5VldJTmZIcTNTU2pjT2hRV1B6VHd0SXJhM3VXeUto?=
 =?utf-8?B?QWpBS3MwYW9IL2ZjbFZsUjJTVFp2Z21qVEhyZ3NpaFlXLzRtNGlPMzQ4Lytw?=
 =?utf-8?B?ZG5QOWxDcGJJb3JaTHllRkFDYmF1NWRnYURsZGp0a215bmNXYUZMYUlWSlds?=
 =?utf-8?B?QndNTVFnOEdDVDdUazhmYzNDNU0wWHhQZnZYRXNuTEJ3YjBjemdqd3dJYlhQ?=
 =?utf-8?B?bS92RG1ZZDZNaVVub0dLbDdTYkI1bjZBdGZBQ3VGQ0FMZFJGeDQ5U0V1Vm1s?=
 =?utf-8?B?SXdRWjlWc1JQNTFnWmRIcXNPRG9jRFhDa0RHNHNqUkRCZG5HdWRmZEJheXA5?=
 =?utf-8?B?L2MycStoWVRWVm1ETGkyc21CZXd6RVBQOGhVcGF0akEyK3pxNTBSTURtN0NQ?=
 =?utf-8?B?MEk5QzRsV1dmanlKbFFXMGhzcUNDdWpERUhUamtjTWNpYUtBUCsxVlp1K3VZ?=
 =?utf-8?B?cFliYVdYQ0J4bnZFMVNUVlhaQjdmTjM0aVh0TDVXZXBSNlBQRm5zRmwwZlZL?=
 =?utf-8?B?R1dwb1B2RS9xVzI4K25UbFB6QkFkS01ZNkF5OS9xNFZ4R2dMSWVIdll0azVC?=
 =?utf-8?B?UmlzOEtkc3JoQjc1UjRtZ0NhVWtlWU8zaUU5ZlJLY1l6dkx4c2pCV1I1U0V1?=
 =?utf-8?B?QjZtVVhrdnd2SWUrc2JxbHExbGtWMHB4VVpIdDk2OTJkSzQzT1VvbExiSzlC?=
 =?utf-8?B?YlUrSS9VRHMzNXNJSzJmTXovSlJXNUxLc2ZncGFvVWMxRmh4TjVlNzlMcU9I?=
 =?utf-8?B?NmpRdTJzTGhTaVpZV1RSRlhGcnI5Tm8vd3hYcEY3UEV4dnpid2NVd3Ivakxu?=
 =?utf-8?B?RWNKdEtreUlFK1ZvcisrczJ0VndINHk2UEVpMEJDbzhFTmFrS0tYTklwR3Bs?=
 =?utf-8?B?Rk9qMWFrWERxTFR6aVd3VkVER01VT0VvcFZrL1h5dUVvQ2dIeG1DSDZHbTZp?=
 =?utf-8?B?M1h4emwrZWsvWG1ZcThBKzR2TWZkZVlWbnNrZTJNT1YvU3dQNjBNbTRTMVAw?=
 =?utf-8?B?V3lPTlJ6ZmVBOERPalZJRUR2MnlvNFZTR2hTVUlNcldENHJXQmdYR0NsdHFI?=
 =?utf-8?B?U1B1OXd1dS8xdmN4MnpZYVMwQWFFMXlodHJmdEpFWGljWkZmdStDTjZTcXZB?=
 =?utf-8?B?cE9WNXlMckUxemEwblNjYi9zNjFJWll6TlVxRjk2RGh1c2NScXp4N0lTTkhw?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2E81EA753FBD4DAAFC4395DC4CFF34@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b446a0d9-085a-4829-95b2-08dbea36c6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:08:39.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2ilQB9YP/NurGVD33ZJxXeLxzvMQ99oyVCZf2YSUbs9OF4pqkxC3jPyBDDliae6VvbgR4ILK7PZ0UEaXmDDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
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
dGU6DQo+IGFjcGlfbXBfd2FrZV9tYWlsYm94X3BhZGRyIGFuZCBhY3BpX21wX3dha2VfbWFpbGJv
eCBpbml0aWFsaXplZCBvbmNlDQo+IGR1cmluZyBBQ1BJIE1BRFQgaW5pdCBhbmQgbmV2ZXIgY2hh
bmdlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNo
dXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYWNwaS9t
YWR0X3dha2V1cC5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hY3Bp
L21hZHRfd2FrZXVwLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9tYWR0X3dha2V1cC5jDQo+IGlu
ZGV4IGY0YmU0OTJiN2U0Yy4uMzhmZmQ0NTI0ZTQ0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvYWNwaS9tYWR0X3dha2V1cC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL21h
ZHRfd2FrZXVwLmMNCj4gQEAgLTUsMTAgKzUsMTAgQEANCj4gICNpbmNsdWRlIDxhc20vcHJvY2Vz
c29yLmg+DQo+ICANCj4gIC8qIFBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlIE11bHRpcHJvY2Vzc29y
IFdha2V1cCBTdHJ1Y3R1cmUgbWFpbGJveCAqLw0KPiAtc3RhdGljIHU2NCBhY3BpX21wX3dha2Vf
bWFpbGJveF9wYWRkcjsNCj4gK3N0YXRpYyB1NjQgYWNwaV9tcF93YWtlX21haWxib3hfcGFkZHIg
X19yb19hZnRlcl9pbml0Ow0KPiAgDQo+ICAvKiBWaXJ0dWFsIGFkZHJlc3Mgb2YgdGhlIE11bHRp
cHJvY2Vzc29yIFdha2V1cCBTdHJ1Y3R1cmUgbWFpbGJveCAqLw0KPiAtc3RhdGljIHN0cnVjdCBh
Y3BpX21hZHRfbXVsdGlwcm9jX3dha2V1cF9tYWlsYm94ICphY3BpX21wX3dha2VfbWFpbGJveDsN
Cj4gK3N0YXRpYyBzdHJ1Y3QgYWNwaV9tYWR0X211bHRpcHJvY193YWtldXBfbWFpbGJveCAqYWNw
aV9tcF93YWtlX21haWxib3ggX19yb19hZnRlcl9pbml0Ow0KPiAgDQo+ICBzdGF0aWMgaW50IGFj
cGlfd2FrZXVwX2NwdSh1MzIgYXBpY2lkLCB1bnNpZ25lZCBsb25nIHN0YXJ0X2lwKQ0KPiAgew0K
DQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo=
