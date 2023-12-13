Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC8812185
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjLMWcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLMWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:32:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A055E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702506731; x=1734042731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Kc2cja786n7wC/lga9oARH14N5Ep/LZ/ljy7cF2Bic=;
  b=HLN/Z8/dS7KPsoUC+NNi4Jxot4P3KscN83ysW9YCifhRg5FHBe7wIkA6
   32A5tWCe0jlNIu3o9lHvIaoF7Yuma/OvbAzK01k6qqH6fozfih8hC05PB
   IAK4A/yPD5iBhuFgbDA1VtZ4iJpsWq9nwEpfuVhAUSnQ7GbJUeRAQW4j4
   SCD5TsUcfTkBLhMX1uGPRg4YKx1tMUiH2/uYGQ7PS8uYGx7F1QW8hhjB4
   rJFhHmGe8OhWVysznnRjJWrIJQ1f3WgyM5z65VM2EiCSYc/aZQt+S34Z4
   ALnEo5N6jmh30rHiVNet6CnDGmBoXSllMnx65uLLDG/fzEj97GX0ggdXd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392212426"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="392212426"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021287051"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1021287051"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 14:32:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 14:32:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 14:32:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 14:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4GGVgz/LM1eobeL0A2Ya9LqGlGLwAYIe5SDJGjofvt/ts/bdckbzVgP3EDXE7U59MEEJY4WdO6hwvmThBLENVi+XfGD2b3dKoOa0i1Hv1EN3sJooXMFU82LeBU5XnKtCAbLteSfMQ3l/wPlGUi5bCCc1cddU35yR0rctYegzK//o25FfcGHVpipVwNsifWHR0W0pg7jCc1G10pkfTX6aGEBeLhqXM0sZECX1paJxCcGKDEnIIyaY44MS3YgVKSDRsvPPZLyhUdfKN4LsTgrRLFyPKT6i5cQWHJuKYklhU7XId3Ct/BFu/V3WVHcS8CXwnjrtB22JhTKvejSpB3Dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kc2cja786n7wC/lga9oARH14N5Ep/LZ/ljy7cF2Bic=;
 b=coJf14Nn3Fl8fWu5WryrWpycicALtwaDlou5u+ksb87W4wi/nfUxaJ8s/+3nYbA1nUoUVIMXcIW2fEG9alnOcyNGHIk3mJfKkSCCXnNiNUQ8klJUBbKwFodR1a+cTlgfCgIPQprLBImNFVuV8ibGFTDDWDjRbdRXDKVXVrisMcnNUkAfILuRjKIpZD5ITm83D91+TeuKGdRJOqRpSdHQDIHM5RcOl/2+/wh7ggVQDEW4E9NZL6HGYzklkaNjg2uQ+EkT69n+7q8SuGLLGBL6AYLG/aUQnL34y7nLFCT6Cas/HgVAh+5h9XP0d9mMIQK8UtZU/HW1ufI7PB4zyeA1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 22:32:08 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 22:32:08 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "arnd@kernel.org" <arnd@kernel.org>,
        "Yao, Yuan" <yuan.yao@intel.com>, "bp@alien8.de" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Topic: [PATCH] x86: tdx: hide unused tdx_dump_mce_info()
Thread-Index: AQHaLUNkbx3M70MeHUWOqNlrwdFerLCmLZaAgADwT4CAAIicgIAAAJUAgAAH5ICAAB7jAA==
Date:   Wed, 13 Dec 2023 22:32:08 +0000
Message-ID: <a3373c1bb8a1012efbbadd64dc91d81362200e1f.camel@intel.com>
References: <20231212213701.4174806-1-arnd@kernel.org>
         <39cf0ad5-bbef-4fb9-81a3-9d2891cc7450@intel.com>
         <20231213120215.64wcryk5k75cymop@box>
         <044e2990b5ca28d04c7305de3d2d412071975ec1.camel@intel.com>
         <de67b856-369c-41a2-8835-d25641eaeab6@intel.com>
         <0ee20c6422a9e1d53c2a1f9112d5dd8308eea1ba.camel@intel.com>
In-Reply-To: <0ee20c6422a9e1d53c2a1f9112d5dd8308eea1ba.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB8211:EE_
x-ms-office365-filtering-correlation-id: 9a7ffbd9-9e3a-4481-556d-08dbfc2b5772
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlwIz5PVklu46FKDGQ7Y/sqDNkxIZDLZ3aWtYTxzTLnJntQmzwT9pf5BdHe0p4umHLdZRleYM+VC3evBSkYsNrz9yMdxwFiGZ+NOE705uCdWggpe/+mngJGm78ib+FxtYa4U71n4pW2o/gPPL/Wa8GGIwD+uPT2XzqMZMzPuOKA4V5sKzsfA5Gqd/Dd7wZ80ugBEtvu9SdKxi8CXyMmnbiwpHcsjXD/eS3ztPEdpp8g8Bg+gtogENEjoBtHWkD9X6GviNmMP2FBeKFDecqmz2gspG87WYmLFDnSAOjeoXIcCsjL7TDwlzdU7Fgry7Af3kMdVVonfq3V378KHPtlXfKjg1OBJwquP5I3QmQnEY1PHWXFYCiUTAXHorf31iw/ZD+NlmHKq37p/3CIxMqSHT9hriWX8cVXTrwdD/vrD8h0+vGcmYlrVOOqZdGtSX/Zi2KlL7ywXhWuPs9gUUVJ4fn2XbtNO+al1WbtSsgR2v6uWoi5V2Uw+2wLJQnlJpse6/CnpoDsdJoL0jmvA5dtytQ6ooiQXekhX2RB65uuvegeoHQ+N49R12/nYdA4v5fNX754ySFJDGuz6fW8ingLzOmLCl/E2vYb7OMSN0k4rJXUOgmepKFqq/a+ohklSUalu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4001150100001)(4744005)(7416002)(2906002)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(38070700009)(41300700001)(36756003)(6486002)(478600001)(6512007)(2616005)(26005)(71200400001)(82960400001)(6506007)(83380400001)(53546011)(110136005)(38100700002)(6636002)(122000001)(66946007)(66556008)(66476007)(66446008)(54906003)(64756008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnVFaDV1OUpUWXYxcUNOU2lHWVZBQy9OTTAxVEFnQ0J0TytWWDQxNEpWWWdZ?=
 =?utf-8?B?VS9sbEF2YkdJem01REVmK0FkaDlTc0tHajFWZlVsWThQQlArb0hrQTRPUGdU?=
 =?utf-8?B?N3JNcjRnNGxNZXlpMnI1MWRONitxNDJLbDJFMUpXMnBIWDlLdEtVMTYwZkVB?=
 =?utf-8?B?UWVZaWIxZWxCOHBBSFo2RUUraGZIMXE4NHNGWldyclFoVDFFakJ4VFZZWWVk?=
 =?utf-8?B?cENHTE5hUGpOb0dCc09od01RdXdGWTBUdDgzd085Y1N6eHBzaDFUbFNZSEpZ?=
 =?utf-8?B?MFZLTUl1N1pycTVxNTZmVXl2Ulc5VjhZcFBPWU9SblBLRmdDZ1M3amI3Skpt?=
 =?utf-8?B?NjNaeStvWUV1OURucENIWnlFT1o3WnNKL2U3ek9SemE1aFRHR2d2czFyMXh6?=
 =?utf-8?B?djBZbjQ4T0tkWmVsZGhTQXFUWW5iSkhpZFgwSEpFOUZJeGE4Kzdtak5iUmll?=
 =?utf-8?B?eE1rVllzVVJqaFJZQ1VOdlZNMHFlUHl3anFhRGE0ZnBDRjVSVVAyUThVeXVl?=
 =?utf-8?B?cU9uRnYxS2ZqeDlNanBienZ2aTRwNTUrdXNzb21xdGkzdUFCYlFRUHhmcjRF?=
 =?utf-8?B?ZDhKc2dFVHZxc2dsZ2w2YnZzNXVhLzBWTG9ZMGFrUzR1Wm50djdoTVZ5aFZw?=
 =?utf-8?B?MWJHWlF5TzcwRDBDOHExVnZ4NmgzL3docWVXRVNTQytKQnlMSnYyUXpYbmk2?=
 =?utf-8?B?amlseE9pT3BGc2U1YlVxZkh0QjNJSXIzMlkxRmcvd2NVL1RkbDgrU2djdi95?=
 =?utf-8?B?cDUySzVMdVJjTVZBdTM0K0FlQUpiVlZCUGxGcW9BNkhxL0xpSTZINGZOQnJr?=
 =?utf-8?B?N1FwK1JtcWd5M1pURE1aRW52TlVDK2cxRjVBQ2ozWGU3Wno0THQvY05LTTJQ?=
 =?utf-8?B?c2ZkME96VC9OSWY0YnlocnEvVTdMNjFkbGgvODRYZ05JRm5jaXE0MFVCRVlH?=
 =?utf-8?B?U0J1SThCRXVyUDFLeE5sRjdoMjRoTzYwMEJQR3NuUm4xejNGL2NKOElRdkU0?=
 =?utf-8?B?d01Lc0JnK2N3ekhGL2FxaDBFWHFUWlRXK1ZpUkdOQTNxanV6NkgzM3dTN09z?=
 =?utf-8?B?djN1bUhpcXkrUzdmQTdpRzd2MDVRZzI0OWZQT1hUTjI3NldFMTlHeDZsYnNp?=
 =?utf-8?B?ak5Rc1QwY2hETXJ4bzdYV3p5VkRXQkFIRTlSRlpRTW1Ga1NTbXdWSFFyeVY0?=
 =?utf-8?B?RGt2QlBaVncrc291SkJsY2R1UTJxdnVHVWFQYk1mZ2NJU01laXZTSTQ2M0JE?=
 =?utf-8?B?TDFKUDFIZnIrZi83UzZsSVcvb0dpdk5mQ1FkdmlUNStUVG84bGRCREtrbFRN?=
 =?utf-8?B?WWYvdDduZEZBcjBodEdmRVYyb2xwa1l2UzRDNTVpSnJlVll5MG1qQTA2d0pu?=
 =?utf-8?B?UTd3cnE2YnlzY3Y5a044THU4ZCtrVUhrTXFMZ1NTSUpZTXN3c0FjQThBelVs?=
 =?utf-8?B?VkxBMitEd2lWU3dCdE9YcVF5SGc2Y1B2WVlGd01LdERKUlNjd25xTHZWZnZr?=
 =?utf-8?B?UFdrRmUyeUFOZ2dRdTV0b0d0NWszZVJzaXlQU0JnY1FOeWdaeXkwQi9ZWiti?=
 =?utf-8?B?dG9pTHREQWVDODVLTjdROUFZU3dUQ1VVNG1nVHR1b0Fya3l1Wk1kaWdQN2g3?=
 =?utf-8?B?WU9DNWRMRWw1UWErUFRLOEFrVVhtRXJYWEcxMTE0SzJyckVmRzlmc0grOEV3?=
 =?utf-8?B?NkVsVjdkWC9vK0JLL0tUZUVwYUZ3c3JYeXBKZytyWG1CdktGNHBUTDdCRDl3?=
 =?utf-8?B?aDZqVnpBYTQ3b1lUOVhMNG9uV0RRbE5vR1JHTSt1Q3NJUWpTYmJweVpRSW12?=
 =?utf-8?B?L0pFVmluMzJ4VG9pLy9IWWJSM0VHUmY1cW4zL0c1L0hmaWltWUNvL0NqK2dZ?=
 =?utf-8?B?dFpqR25CQjZlZzUzaGRkK0o1SHZ4QkMvVGlSZkRhVXExTXQxRHRhZjU1TTVn?=
 =?utf-8?B?Q0FlY0hLVjRDUmZmRTFFT2REc2ZyemM1MVZoNDJqcHF4SXpDK04wa1FNdCtQ?=
 =?utf-8?B?K3Nld1c1S1Uxdk1yREUyZTdNcGVPVW4xdjNjMWhpeVdxa1g3ekZZQzVhSFZt?=
 =?utf-8?B?U1RKNjZXQTYzVUVPV2pGdm9VdGZCOXhmRERYQkxWZzVDcTFJSkRjWk1HcHlx?=
 =?utf-8?B?OW9ZOVdnYk1DTGthVTQ2aUVoaWZEb0JFcVVFNHY0cW1HN0ZaTFFzUWU1WlYz?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <104B61E13AEA464F8796A423200FBC4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7ffbd9-9e3a-4481-556d-08dbfc2b5772
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 22:32:08.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dAyj5lHfIrYf+WzXzHcMgu9VR6w547UjWawgiES8SCtHTreHZ99Tfp/D7dyvJ7CEMF5AhWOWfEsLoX5nBqWhYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDIwOjQxICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjMtMTItMTMgYXQgMTI6MTMgLTA4MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0KPiA+
IE9uIDEyLzEzLzIzIDEyOjExLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+ID4gPiAiVGhlIG1hY2hp
bmUtY2hlY2sgZXhjZXB0aW9uIGhhbmRsZXIgaXMgZXhwZWN0ZWQgdG8gYmUgaW1wbGVtZW50ZWQg
aW4gdGhlDQo+ID4gPiA+IFZNTS4iDQo+ID4gPiBJIGFsc28gYWdyZWUuICBUaGFua3MuDQo+ID4g
DQo+ID4gS2FpLCBjb3VsZCB5b3UgcGxlYXNlIHNlbmQgYSBwYXRjaCB0byBmaXggdGhpcyBidWls
ZCBwcm9ibGVtIHRoYXQgQXJuZA0KPiA+IHJlcG9ydGVkPw0KPiANCj4gVHVybnMgb3V0IElOVEVM
X1REWF9HVUVTVCBzZWxlY3RzIFg4Nl9NQ0UsIEkgdGhpbmsgd2UgY2FuIGFsc28ganVzdCBzZWxl
Y3QNCj4gWDg2X01DRSBmb3IgVERYIGhvc3Q/DQo+IA0KPiBjb25maWcgSU5URUxfVERYX0dVRVNU
DQo+ICAgICAgICAgYm9vbCAiSW50ZWwgVERYIChUcnVzdCBEb21haW4gRXh0ZW5zaW9ucykgLSBH
dWVzdCBTdXBwb3J0Ig0KPiAgICAgICAgIGRlcGVuZHMgb24gWDg2XzY0ICYmIENQVV9TVVBfSU5U
RUwNCj4gCS4uLg0KPiAgICAgICAgIHNlbGVjdCBYODZfTUNFDQo+IAkNCg0KVHVybnMgb3V0IHdl
IGhhdmUgdG8gdXNlICdkZXBlbmQgb24nIGJ1dCBub3QgJ3NlbGVjdCcgYmVjYXVzZSB3aXRoIHRo
ZSBsYXR0ZXIgSQ0KZ290ICJtbS9LY29uZmlnOjc3MjplcnJvcjogcmVjdXJzaXZlIGRlcGVuZGVu
Y3kgZGV0ZWN0ZWQhIi4NCg0KSSBqdXN0IHNlbnQgb3V0IHRoZSBmaXhpbmcgcGF0Y2guICBJIGRp
ZCBrZXJuZWwgYnVpbHQgb2YgbXVsdGlwbGUgY29tYmluYXRpb25zDQpvZiBURFhfR1VFU1QvVERY
X0hPU1QvWDg2X01DRSBpbiB0aGUgS2NvbmZpZywgYW5kIHRoZXkgYWxsIHBhc3NlZC4NCg==
