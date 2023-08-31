Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888678F015
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbjHaPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbjHaPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:18:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A5FE4F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693495089; x=1725031089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4i50SD46GD/tztYYX3yZ9hiaK+/ujaH6jMcogCyjhrc=;
  b=PpeQb5YaxDl2F2KO+YDSnJ1xZmfV9XV7j74jE0zEKQ4bjxYTD946aR6y
   ikxPcm1lnnI8bQ83JBifhzTrFPLSQcGp6aQJXFjE95+aSKFTNE1egXLaK
   6fPr2H8f5HsHJGuod9pXU5M7bJUFS6QpH7WZCjuJR5zTK8g24GGEyBGjC
   C8CPT0TWAJacUltdUSXmtDti6ATd3W3RLRI7qpLwdrJUEiLIiLRrosc3q
   yWr41xBLNdIKp2PM6bgojn15RPjM2L54eIQvzQqhHrLGskwZQyLuGR2Da
   BoY2SUl0IBLgamHewXSSycWGyt1dHF36NdiPEveMziw1jlt7fREcChKxf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375915283"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375915283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 08:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913325807"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="913325807"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 08:16:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:16:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:16:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 08:16:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 08:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnh8mqgShLXDfhBVjVYvQMsSy0RNzJI1N8keO/68zELIaOAp1hPVuAG6al0APGlXPB1buZkQHFovWBdqtyuG4vIXbrwpsn/MpftMqAdlKNcOgz6BCtO+NnHzW0JTb4bfnvQ+lKBkvArWwTXIKSe4Fu0C8oxN+Vij1T++CyXcEHMD+TIH/oK2BmK1wBqID8+UXc7eZS+B/xyNHpARxwdHQvY++bAQHwXUsQJNrnzDvQTm6QS4nxxAgf3eJjNKO3ya2qx0Y6cVwhSBuamW/v8OgZvErKMklJh5TDKw42bm2jogxXbmw3QTatZRTlNqDd2ihE+LujZNSCbUUaMQJ8A6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i50SD46GD/tztYYX3yZ9hiaK+/ujaH6jMcogCyjhrc=;
 b=nD0v3ncHBTZm3ETwZgLwTh+FkyufqL7eBJSFR4s12dkdQokirTXWtXr9O9C2QloMx6tXwolxtQ/skgkUGSjZ5+Ra16LPrkpAHp7kEPo9CCvqQb7y8ljPJmIM6Qqo9hMfKysbi1a/x4y5TJq6rCMOoJMsxjE3dmvltrKGS1HUFNS9tn1kkbkWKG1EDP7tYTOPuwek3SQl/aO4YYVCWKRqkVD1ftbzxmVsbJ+j9j6IJ8lywTCUXvCi172SuThkeBIhvWXCGptkYQCdW0tHgH5m1Ar0j0fnqcjH2zS4WxsB7pXDLhhYEFRrSIIh/u27XZP/REUTRL2QS+sGVYNBmFbIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:16:04 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::fb0d:8188:5def:5872]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::fb0d:8188:5def:5872%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 15:16:04 +0000
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
Thread-Index: AQHZyhS1JcLmCVpccUeZXOazygGeDq/gowaAgAAu+ICAGN7dgIABcb4AgAA3HICABjZZgIABBGiAgAITcgA=
Date:   Thu, 31 Aug 2023 15:16:04 +0000
Message-ID: <2B927B1B-A0B6-40F9-B869-46F5B1B3DE28@intel.com>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box> <87bkewcufi.ffs@tglx>
 <20230825135226.ikxvskplvppghwtz@box.shutemov.name> <87pm3baw16.ffs@tglx>
 <505FB766-F79B-4D54-910E-B2EE497515FE@intel.com> <87wmxd56hw.ffs@tglx>
In-Reply-To: <87wmxd56hw.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4435:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: c1d4ec78-1c4d-4b6c-e497-08dbaa353186
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2OQtdEi9LbKYItVFwWzpOOvsyEEG3SibXwMv44ZllkOgWhwHYVvUfTXrthLgWAlhVhQE/6TxmkzZqlGNh6L4PqGET7ymYlANxA9zj5hVB458aQ8oHmMh5DvPYIkqyegYDpTsTaUCLNZ3jS4Zfcwed/o/geyzJdDaYzKoNrwcQDlNM5lrlIe/8NK49nkDQuHUGowHGjfbk/LMUbwKQEssfxxrqD3g/IK74VBFSqeQ6cWV03iMYSGpx4wcj9u0dkPqE8T+Zw4Q8R//7RiBxF3+XhMerp+PSmONB/nnXwN0w2yTbExXp4dA0ilrffb3O4Dukts+LcrG8yqBKE00U43zZbVyB7FAYmjcoHsEBqugLGvGaSesOQAyfMiSbdTrG64gfrQQkpRlxyvz1D9chXJIl1tRruxZKTEUAjQUSaslJ4AO5ncZW3obqYwewER98G0yzZgHIzpGW1kWYTh1QHL9gEP1gjtbRIBMvIWqg3clMYB9HXMs2sOEfD5Iris0NC0+zuzf5RNZ0iLDktGUKZQ937gf4x5Su463jvNpQJK3/LCI09Q6IYihz9HKylCFh6hEGlNqQ/wgttb5O5E0lUGC3IJNcWK3Lfrql53ERkLKA77w/OaUFfTE+z32G7RC2Jb44PbZAlH28L7VKycgPG2yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199024)(186009)(1800799009)(122000001)(71200400001)(83380400001)(82960400001)(38070700005)(38100700002)(478600001)(6486002)(53546011)(6506007)(6916009)(54906003)(64756008)(66446008)(316002)(41300700001)(66556008)(66476007)(6512007)(66946007)(86362001)(2906002)(76116006)(5660300002)(36756003)(2616005)(33656002)(8676002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azY5RzUwL0V2MHMxa21oUS9rK0VBdUo1aXhOdEljS3p6eXRWeGtibENBa0VH?=
 =?utf-8?B?Q1dYcGRTMnZ1b1N3UDl3S0plZFBXSDBTbnp6QkhBN3NlendFL1pBYnZHVGtu?=
 =?utf-8?B?YmZXRVFPb0x2ME9SdmUwZFVaWDBzWlJ5N0VLQ0RwVHRXZERXRmJrTUllNWlY?=
 =?utf-8?B?eTNpbUJWK2l5c25XUVA4d2E5cTdXMloxNXpya3pOS0M3ODFDN2xiV3N5LzM3?=
 =?utf-8?B?NG5jdlg5UG9SS0xLcHNYenY0cXB4RFhHWFFLMXcyRTBNbjY2NlN1UWVmRjBC?=
 =?utf-8?B?blkveEdKV2d1V24xdzh4MHIrVVlLMUk1VmJtYmkzcmF4bTVhNjNaMTZFT1pN?=
 =?utf-8?B?NkNsaFpwT3NvVTdIdnE1VEp1eTk4ZkhwQXNrby93akM5ZUxuSlVOOEQ4ZXRD?=
 =?utf-8?B?MWZxSS9OcmVWOFR1T2pEOTJTaCtNL3o1MXpwcDUwTE9YWUhCcHljdm04aDFP?=
 =?utf-8?B?a01icTYrMEZoNUdaUXBLTnQ0Z2hHRWlVdktIK1BpcnVvK1l1eElzczlIWEZ0?=
 =?utf-8?B?WStDMzVQUGd2UmM2MVkwT2NZME5JUU80NTVzQnBhQnN1WkR6Sitva0NMT0dr?=
 =?utf-8?B?Mk9GeUZpd2Q3dVR1NDMwd3NmR3BnWk5kQU5VbCtvYXZnVGNnZERxT2w1T2hw?=
 =?utf-8?B?dDhWc2dxazgrZ3lsYXA5ZmtQOC9CN2tZN2FuS3dObWtBQmpHKzlnOXZnM1hN?=
 =?utf-8?B?anRpbEhwVGlhZUthR0VzbGxENFRXU3Q4bU1pMC9FOXRWd0JaNEVjcTdYVFFv?=
 =?utf-8?B?TDJhUmpjVEpWamlEaDVjUjZwcHcycEQvRWVsc1NRR2lvWnFwNldEVzVRdCtT?=
 =?utf-8?B?RzFiT1pMZXhPdTY5VWZUSXBmRk5qUlloaTFUMkdiVjFYSE5lUkhVRnEwVFBv?=
 =?utf-8?B?WXlnc29lVDV2MzZqTDBBU2JWT2NNVnZERkZndytFa0U3UHRSOFNyVWNxS09w?=
 =?utf-8?B?WkRzdE4yS3d5OUJpWGdIWE1kajZMOGNzYlBYaDBHRjJCODZxUmUwU3dOVnFB?=
 =?utf-8?B?ZGlsN0prM0d6U3Z0QmIzSXlJbHdxU2hqRWxFM2lyakJidjZVT2RXUnE4bkFt?=
 =?utf-8?B?Wm5Za2g4WFFaanlRZTR0SHBwbkMrcWN6endxcDYwRnVoT3kwQlpUOS9ZNXhH?=
 =?utf-8?B?NEhrKzl0eERKQ0lpRWFodEpFQkNHS0pCby9LdStTbzAyNzFydHdrYVZ5cW1T?=
 =?utf-8?B?d0tNazlaTzkycUREVTdHcWJmZGxVbTRla3o1WVZDZitUZHFidW5BMnhFN05m?=
 =?utf-8?B?TzRmNlFZWTN2Z3BwODdvOVJyR2s0bHhqSkhtc1lGVHNrS1BUbG51bHBEQzNQ?=
 =?utf-8?B?K3plVFpxVG9kRUhoRHdzQy9jVEJnbXVjZDhvRjQ0VkNFMVFOUTFjZ1Bzckgy?=
 =?utf-8?B?NEVKOTJKWmNBcjdIamowUXRXWFpvZGM4ajhLbXVLVTd0ZWZIUndSWjhKT2xx?=
 =?utf-8?B?Ym9RSk5tc25LWUNtSHhqSlBSMjZETTE4bmY0dlAzWXN4WlBVL0tDOHFiY1Va?=
 =?utf-8?B?TWJCNmc1Q0E1N2lLT3hXT2xraDNrT1J5MXFlSlVjZVJ1MmlIYnpGcTBpVm45?=
 =?utf-8?B?aG40OVBJMmgrQkEwSDR4U216UHFhalNwRDNHTWhxWEpROG5pNldJc3BJcit6?=
 =?utf-8?B?OVVXWjRsWDhFWGIySURFTWlWLzFqV3hKTklleEY0ZTJmYmhmMktNdk5Camcv?=
 =?utf-8?B?clljQVpZTUJwYzZlY3NmTks0cytoczVWdys2bVBsRlpwTzZtejU4OFRhL09D?=
 =?utf-8?B?OStzY1FwaURDcmp3WkNlNXB3em40RjA5bjRhMGt1V28xbVUweDk0T2c3dVhs?=
 =?utf-8?B?ajVCcFFlbnovOVFQTVpTSXhkOWVtTFplZDJPU3BvRklMaVVSMmw5VFFqbVBx?=
 =?utf-8?B?elJHQjY3WS9udEZlOW80Y3o5QW11Z1NKaFZFOXVyK0VSQjJ2WjZmWU5KNkk5?=
 =?utf-8?B?SXRqME1JNE9sdEhBWGorbVNnNlV4Z1VQYmIyNTFtanZIaTlYSjAvQUxlQVNx?=
 =?utf-8?B?L3h0TW1VSjdvdU5uRlB4TkpIOFNYdnBIUjRKMTJkQjZScWw2bC92R1l1dFBy?=
 =?utf-8?B?bGpwNVVCQTYrNjNpVEhjQTNoRlhjOVc1NkEzTStoekF1WU5HOUlsMTdnV1VT?=
 =?utf-8?B?M0Z1K1BtMVBBR1BkMjlIV3RTUE9BcVZRZGNwbFpMVmlvKzZmVnUyTGxSZEV0?=
 =?utf-8?B?SkJtbUozaUdjSlhjandldnF6YktESGhiUHJWejFuZVRSRlVveloxQ0lJMmhK?=
 =?utf-8?B?WHN1RjA2SWFIU2FkbTdHVzVtUjZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6060BD4A82FC7B4494F5D298DA7365D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d4ec78-1c4d-4b6c-e497-08dbaa353186
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 15:16:04.3810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ue1Wjalkw9INko8LBa0sGo3Eg2iYXsThtRglofxx0GQM6tgFDWvWAZ76dWWBXS7bMu2TxB3AgGsY/nlUWyABzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
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

DQo+IE9uIEF1ZyAzMCwgMjAyMywgYXQgMTI6MzMgQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXVnIDI5IDIwMjMgYXQgMTY6MDEs
IEp1biBOYWthamltYSB3cm90ZToNCj4+PiBPbiBBdWcgMjUsIDIwMjMsIGF0IDEwOjA5IEFNLCBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+Pj4+IFRoZSBuZXdl
ciBzcGVjIHNheXMgIlZpcnR1YWwgVFNDIHZhbHVlcyBhcmUgY29uc2lzdGVudCBhbW9uZyBhbGwg
dGhlIFRE4oCZcw0KPj4+PiBWQ1BVcyBhdCB0aGUgbGV2ZWwgc3VwcG9ydGVkIGJ5IHRoZSBDUFUi
Lg0KPj4+IA0KPj4+IFRoYXQgbWVhbnMgd2hhdD8gSXQncyBub3QgYSBndWFyYW50ZWUgZm9yIGNv
bnNpc3RlbmN5IGVpdGhlci4gOigNCj4+IA0KPj4gQWN0dWFsbHkgKGluIFREWCBNb2R1bGUgMS41
IHNwZWMpLCB0aGUgc2VudGVuY2UgaXMgIlZpcnR1YWwgVFNDIHZhbHVlcw0KPj4gYXJlIGNvbnNp
c3RlbnQgYW1vbmcgYWxsIHRoZSBUROKAmXMgVkNQVXMgYXQgdGhlIGxldmVsIHN1cHBvcnRlZCBi
eSB0aGUNCj4+IENQVSwgc2VlIGJlbG934oCdLg0KPj4gDQo+PiBBbmQgdGhlIGJlbG93Og0KPj4g
LS0tDQo+PiBUaGUgaG9zdCBWTU0gaXMgcmVxdWlyZWQgdG8gZG8gdGhlIGZvbGxvd2luZzoNCj4+
IOKAoiBTZXQgdXAgdGhlIHNhbWUgSUEzMl9UU0NfQURKVVNUIHZhbHVlcyBvbiBhbGwgTFBzIGJl
Zm9yZSBpbml0aWFsaXppbmcgdGhlIEludGVsIFREWCBtb2R1bGUuDQo+PiDigKIgTWFrZSBzdXJl
IElBMzJfVFNDX0FESlVTVCBpcyBub3QgbW9kaWZpZWQgZnJvbSBpdHMgaW5pdGlhbCB2YWx1ZSBi
ZWZvcmUgY2FsbGluZyBTRUFNQ0FMTC4NCj4+IA0KPj4gVGhlIEludGVsIFREWCBtb2R1bGUgY2hl
Y2tzIHRoZSBhYm92ZSBhcyBwYXJ0IG9mIFRESC5WUC5FTlRFUiBhbmQgYW55DQo+PiBvdGhlciBT
RUFNQ0FMTCBsZWFmIGZ1bmN0aW9uIHRoYXQgcmVhZHMgVFNDLg0KPiANCj4gV2hhdCBoYXBwZW5z
IHdoZW4gdGhlIGNoZWNrIGRldGVjdHMgdGhhdCB0aGUgaG9zdCBtb2RpZmllZCBUU0MgQURKVVNU
Pw0KDQpTdWNoIGEgU0VBTUNBTEwsIGUuZy4sIFRESC5WUC5FTlRFUiB3aWxsIGZhaWwgd2l0aCBh
biBlcnJvciBjb2RlIChURFhfSU5DT05TSVNURU5UX01TUiBhbmQgTVNSIGluZGV4IG9mIFRTQyBB
REpVU1QpLg0KDQo+IA0KPiBXaGF0IHZhbGlkYXRlcyB0aGUgVk1DUyBUU0Mgb2Zmc2V0IGZpZWxk
Pw0KDQpURFggbW9kdWxlLiBUaGUgVk1DU3Mgb2YgVERzIGFyZSBpbiBwcml2YXRlIChwcm90ZWN0
ZWQpIG1lbW9yeSBhbmQgYWNjZXNzZWQgYnkgdGhlIFREWCBtb2R1bGUgb25seS4gDQpUaGUgaG9z
dCBoYXMgbm8gZGlyZWN0IGFjY2VzcyB0byB0aGVtLg0KDQo+IA0KPj4gVGhlIHZpcnR1YWxpemVk
IFRTQyBpcyBkZXNpZ25lZCB0byBoYXZlIHRoZSBmb2xsb3dpbmcgY2hhcmFjdGVyaXN0aWNzOg0K
Pj4g4oCiIFRoZSB2aXJ0dWFsIFRTQyBmcmVxdWVuY3kgaXMgc3BlY2lmaWVkIGJ5IHRoZSBob3N0
IFZNTSBhcyBhbiBpbnB1dA0KPj4gdG8gVERILk1ORy5JTklUIGluIHVuaXRzIG9mIDI1TUh6IOKA
kyBpdCBjYW4gYmUgYmV0d2VlbiA0IGFuZCA0MDANCj4+IChjb3JyZXNwb25kaW5nIHRvIGEgcmFu
Z2Ugb2YgMTAwTUh6IHRvIDEwR0h6KS4NCj4gDQo+IFdoYXQgdmFsaWRhdGVzIHRoYXQgdGhlIGZy
ZXF1ZW5jeSBpcyBjb3JyZWN0Pw0KDQpWYWxpZGF0aW9uIG9mIHRoZSByZWFsL2hhcmR3YXJlIFRT
QyBmcmVxdWVuY3kgaXMgcGFydCBvZiBoYXJkd2FyZSB2YWxpZGF0aW9uLg0KDQo+IA0KPiBIb3cg
aXMgZW5zdXJlZCB0aGF0IHRoZSBob3N0IGRvZXMgbm90IGNoYW5nZSBUU0Mgc2NhbGluZz8NCg0K
SSBndWVzcyB5b3UgbWVhbiB2aXJ0dWFsIFRTQyBzY2FsaW5nLCB3aGljaCBpcyB1c2VkIGZvciBj
YWxjdWxhdGlvbiBvZiB0aGUgVFNDIG9ic2VydmVkIGJ5IHRoZSBndWVzdC4NClRoaXMgaXMgYSBW
TUNTIGZpZWxkIHNldCBieSB0aGUgVERYIG1vZHVsZSwgYmFzZWQgb24gdGhlIGNvbmZpZ3VyZWQg
dmlydHVhbCBUU0MgZnJlcXVlbmN5IGFuZCB0aGUgcmVhbCBUU0MgZnJlcXVlbmN5LiBTbywgdGhl
IGhvc3QgY2Fubm90IGNoYW5nZSBpdCAoYXMgaXQgaGFzIG5vIGRpcmVjdCBhY2Nlc3MgdG8gdGhl
IFZNQ1MpLg0KDQoNCi0tLQ0KSnVu
