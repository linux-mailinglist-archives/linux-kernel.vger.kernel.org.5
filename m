Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC5763E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjGZSL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGZSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:11:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BB26A6;
        Wed, 26 Jul 2023 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690395116; x=1721931116;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ei+sGusXeCqkcvEjSlLi4Ark/I5BvzZmQgLeVI7C4VM=;
  b=NfK0tZap/irgFw5TinrhNq4AlABCW9PTBvuV/f+d7FxJxQUu4bm4cmD1
   cZz+mwXmnLReaiSg5DMPwbUSxR4bhX4h49nw/HJVX/PwtRdxHJI769QcU
   nXIv+xK8ujevwjHHc5CTjmIWZ4Y2pkG1Ed9rEuos4ja6MKFPrW3Glo1AQ
   6VTktdCNm2lXQ3gRzMxfQAyJH7UEPFynh4ueS0h7HVV53Vdb7dDpXMH5Q
   FOMh+/X15Itle8Dv+9lK1hlykXifSCDonHPMCqTirPF1/xFXfQUu7JbkZ
   JJh+kzWoiDR2oDH+WC6vwc3l6xSGlmpB3p2dLnD4bUHxf3Wxfu2ilLye9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371706532"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371706532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756334455"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="756334455"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 11:11:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 11:11:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 11:11:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 11:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iryosRggLOlwX7zM5pd4TOJrxxjjcBr5KUmRa0AkYEjC6j4qIvZPfK9cv89jeZyX+/HdbeGs34p7hXdmBkhNv5YRgX9ciA5PqJQlHY8/BaeUwBpQW+4/KqJmUUqb6r+XlyWGEQtj6Fh6hGsIIUJRtYnRbzu/n8ekzGxHGpQZ5BgnUTsv3J6PwK3ThJTrlVKOW1V4NgmRhfrnxr98XLWn1BuMeZzLLKgctATcRr6NgkVmQ+zMGdbgBvi3ELUpCEuhxJLSqsMMccPX75iZ3vXZy50dNyeT+0uEUK7w+d0IycO7oh1D9C0QuK9emOILWiAnQHYyOQD68TO+hSndFz1Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei+sGusXeCqkcvEjSlLi4Ark/I5BvzZmQgLeVI7C4VM=;
 b=GiL3YJhztO/3jzpQywpHd4gyfhMeCW/BRV5Iw3xoPg3d9UBkTmXCCPUP/wqtdVwRvlry6O5x4DQskV4Nhed8aZ9slR4lRgP3fk2WWbaqm8k6QPTcWbKv/xQjJ4cMwqj4ppXu55RZ7EC4UQ9PndE6+6ypBzvGZtJCJmOe+wyLJMYvBKUT4lIOvn0zpboi1zhTABAL23KcQ9s9nAu3WhGh7W1oPAjhb9D3kYDXzwsaaxi8wD08HHo8hTNhTKwj8XycqIF+TJGFARFxfLbHYsrClCA2fQebQXZ3xRGsR5bsZOoRpPQCWg0JENQdtSYwLIpr4BHrWBzdL54DqjOc0KsQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:11:53 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 18:11:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [tip: x86/shstk] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZupMQ0x6IY54ui0a5ce9+OI1ntK/D5xAAgACDgQCAB/mWAA==
Date:   Wed, 26 Jul 2023 18:11:52 +0000
Message-ID: <8b63387a09ca7b007241f328c5688c702b179019.camel@intel.com>
References: <168980685456.28540.8149705038742119504.tip-bot2@tip-bot2>
         <ZLpC/IbswCA0yUHD@gmail.com>
         <1b5d436e1b4f31c37ce1f1e6342c836fd5b2ceec.camel@intel.com>
In-Reply-To: <1b5d436e1b4f31c37ce1f1e6342c836fd5b2ceec.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV8PR11MB8606:EE_
x-ms-office365-filtering-correlation-id: 49b7f0e1-94bd-45f3-0448-08db8e03ca19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKvZ/+nqNWASlAVIvAkrX4d5UpO4RLpubCTrPIrIH6dfjFWnYPFBfm4R0IbBmtZRqemc4yXDTDbtji5HyQRU1IwgovKGD1/A75GUseHBAuO3IaybTmtUkil8gLVHcm5Pi9kW0KGaSVmkSx3+Uezn1Yf2+l19Dtkp5BljduaeMuHqtIjdv0v7wlUtUHguhd1A4ojWOjbPgY4k5uRETH/e1NzWTnJp5z87ZldFo7+JBRGLsq+Lh2mWIfZErPs6isyRBsxH8ITxVuvpKEP5vNjAdXOGzLCc2Tn5d1G9xOBu9aUn+wpLTFumUaT1MMATo77KhwRCtnOV+CxA+CvfM10FPjq4xpJVxRRhRkWf/wL9gWNcagjwBuZCGRkOPpwli1Ks6hJp/dqUgSrAl1xY2EfzhbcvNrB8Tw0+KV4OC3HJHqnv8D4jpAOpHpKmQlLJODaRiFF0bvIDeYPolVbI4pBXP2C3cf2OuGcu/69B+nw4idJOA789e6ap212Cdv1qIWWlBGDydBMjHZdbrtFCQloyhVuylkbYuBPrD/1IZYT0+r1tyuWgwSaU4qvS/Wb3AzdsfOrtPh9FqTH9nvY7uBlhgc9UYr/oswNXxPDgpcJVQhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(4744005)(38070700005)(7416002)(83380400001)(186003)(26005)(6506007)(122000001)(6512007)(6486002)(38100700002)(478600001)(54906003)(110136005)(316002)(91956017)(4326008)(8676002)(66946007)(76116006)(66556008)(66446008)(64756008)(66476007)(2616005)(8936002)(71200400001)(41300700001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1p4d01KN0tPQzkxNnc5MzRjczBiYS8xTTFvQjlreTFGcWZnOS9SZTdsMFpG?=
 =?utf-8?B?RnkwVnUzYVNUdHZlY3U4a0tERGNYb0xSVVNNeDZleWU2enZCdkZzZHk4SmIx?=
 =?utf-8?B?MFBJdGkrSVhUelZ5ZUpyQjEwVHB4SGtudzRJdW1LTTg3U2hPUXk0dlMrOHhH?=
 =?utf-8?B?NFZpbFE4anlXMmtmcW9SR1NrcS8wOEo1TUNURUQ0YnBQNnJWR05ZUzVFcVl6?=
 =?utf-8?B?TUFrUVJ4RnowVFVkdmxoWEd0NmVhaWJSUk1WVWZnSXY3SVh3eHlNUlY4ZHN6?=
 =?utf-8?B?eUFjeGo3SkoxY1pyMzJ3eVNVOFoyblhmQ0d3NUhHNStVSFdLMWlOVWN0djNH?=
 =?utf-8?B?NEZ2cjIvMXpjOXd3VXZodXZNMXBTSndNbFZsOVUrTVlzOVd3MWI0Q2xsbnE3?=
 =?utf-8?B?ZnBkekhabElDdVV3US9oK1dxeTFxZmJZUFBETVZQTE5NeGI5VzdGVURkbk9o?=
 =?utf-8?B?UmZxNGtRamVydXRrMjN0QkcvOE13clBnOWdBMUpBWWM3dGMxblBYUCs4STRy?=
 =?utf-8?B?NGdZekoyeUVDVFp6VFFBeXpzNUdEWXRwZFhpbmtIMmk2UFdsWGVFM25BbGdK?=
 =?utf-8?B?N0tFeDNiV1pkanJEZTYwK1VxS3pLMVpla3VUYjZTd3lrdVFnVDhlKzZaNHIv?=
 =?utf-8?B?aW85SkF2aW43aUhOYnU0R0R3dmhoWi9nZlhQa3JrMVZOamNOclJmR1R2MzFZ?=
 =?utf-8?B?WGRENlNXNktBcWZEUVUyR3pWd3Y2NEkyUXNtNjRPR0cxRGVDYzBNVkJWQmYv?=
 =?utf-8?B?TDBxeVZoejltcmo1bFJPZmVoM005b0tYQkxQL0NROWtSdkFYR1l5NmFNNWMr?=
 =?utf-8?B?d2xaUFUwRk9tcHFjWW9lRGRPOEs4dGpBSFZLZHFQOXBxZy9DRjBNRXVtTEJo?=
 =?utf-8?B?NGh1THUvNVl4dFUxbm5Hd1lSanlkNHZyOXNUZFFQaVRabDQwdVgrM2FrNnVT?=
 =?utf-8?B?N3I3Y1BBQ2tmWVZta1JTRTh3YldiL1RhVXRLNXEyd21uSGlZeGlxUWloNElQ?=
 =?utf-8?B?MnVMK3FlbXAxL3hzbUhPUHZTVUZ5ZVhycnQ4cUtET1RmOXNYL0laUXh1eVhC?=
 =?utf-8?B?OXJaSWE4Z1hCTy9IbVVMSU9HT1VNUXJvNStncnNGU0NEemFkbWg5amd0VWZU?=
 =?utf-8?B?YWZqMU1BWEoxdTRHZ3ZmdnpQTjlVTGV2bTgycHNrKzZPbFVUMDV3bmdBcTFS?=
 =?utf-8?B?cy9yRUM0T0x3S01Odmg1d2d5Tm9OMEhIQ21DRkdHaG5YS3FnblFBTkR5cVNX?=
 =?utf-8?B?aE4wcDRhZEdtZ3NMVW5HZGdDbG5TSnBpMElLMG1SOEFDa0R3TlhuQll4eDha?=
 =?utf-8?B?YzhyQ2F1bGI5R2x6NllKVjgzSnRHT1lmSmFVSUhtUW9xcTVLZUdOSmVwZ25U?=
 =?utf-8?B?MkxxNFY3YlIwWlFDMXFCTUtsNnRZbWhvaXM3bS9TL3JONjVRbnM0OUZoN3cx?=
 =?utf-8?B?ME5CZDBFWXBUV3RCTjRvTEUwVlBmYlVwei9SUXh6emxXYnhYTjBaUDE3bjdG?=
 =?utf-8?B?UlVUNkcxL3NKS3ZoNzlqN05vMFp6NmN1ZDF2TW9jVitQTk9pTk4wNlBGRVRY?=
 =?utf-8?B?UmRlSk4yMzFBcUJ5cVBxT2kvUWJQdzVobVJrejVIYnVzSWdxdFo1UEd5Mkhx?=
 =?utf-8?B?WW1WWjlrZ2hnQjRRWi84QktTelp3Ym14a0J3Mm93Z1pPTnNJNWEwZEhqZHFl?=
 =?utf-8?B?bnltTExRTG00SkwrbzdPUHZGVi9jNFgyc2FzV1c0eEc5ZzIrWDFGT25JUllW?=
 =?utf-8?B?clZiVElrVTRRTWNxN0lURGpoUmozSVNCZVJSVXUyZjQyNzN1OUV1UXpWMlpL?=
 =?utf-8?B?WHNmdDBSNHVqOFBjWitDNXpYT2VVUGFRT3JNWDhJK1o2MGtIVTdWY0t2Vnhr?=
 =?utf-8?B?U3p1V3IyejJOK3kwM003dEF4V1FtdWNLNWVQYW1yWU1jSDl3SG5WZ01yTDBm?=
 =?utf-8?B?R05zR0FsZ2xyWXZ3d05MSlFFNjZkRVNNc2NwakRDelZTS2FNQ2dyWFNqaUlv?=
 =?utf-8?B?RVZFK2tGMXJGSHpHZWdndFhhNlZKVzNFSmZKNGVSVGN6RE5WSXB2V3R1Z2lF?=
 =?utf-8?B?cVpiZGFPOWhveDZwR1JDQVZqYTBXSisyZVpmcXNOYUI5Q3lGd1o2TUlTenk2?=
 =?utf-8?B?clptL1J4Y1pFZFlkMEhLNXpjZnFvMVNoS05ENnlpeU1mNFdMNVBucGQ5Q0Fx?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF8B604A641B54AA0E251CB89CE5D0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b7f0e1-94bd-45f3-0448-08db8e03ca19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 18:11:52.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j94/kf5X/bFJvoXs8hfET2JS3bWdO/l+5BqTTOEieReNmZLuCb7On0trIdJ8ll+OCmhIPj0fKv1nvhQWzGo5E+Jfma2mPtVRaj6+ujxUxcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDA5OjI0IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gQXMgZm9yIHRoZSBidWlsZCBicmVha2FnZSwgSSdtIG5vdCBzdXJlIGhvdyB0aGlzIHNsaXBw
ZWQgdGhyb3VnaC4gTXkNCj4gcnVudGltZSB0ZXN0IGVudmlyb25tZW50IHdhcyBtaXNzaW5nIENP
TkZJR19XRVJST1IsIGJ1dCBJIGdvdCAwZGF5DQo+IGJ1aWxkIHN1Y2Nlc3NlcyBmb3IgdGhlIHg4
Nl82NCBhbmQgaTM4NiBkZWZjb25maWdzIHNwZWNpZmljYWxseS4gSSdsbA0KPiBoYXZlIHRvIGZv
bGxvdyB1cCB3aXRoIHRoZSAwZGF5IHBlb3BsZS4NCg0KWWVhLCB0aGVyZSB3YXMgYSAwLWRheSBi
dWcgdGhhdCBjYXVzZWQgaXQgdG8gaWdub3JlIFd1bnVzZWQtZnVuY3Rpb24NCndhcm5pbmdzLiBB
cHBhcmVudGx5IDAtZGF5IGFsc28gZm9yY2VzIENPTkZJR19XRVJST1I9biwgc28gdGhlIGJ1aWxk
DQplcnJvbmVvdXNseSBzdWNjZWVkZWQuDQoNClRoZSBXdW51c2VkLWZ1bmN0aW9uIGJ1ZyBpcyBm
aXhlZCBub3cgb24gMC1kYXksIGFuZCB0aGUgZml4ZWQgc2hhZG93DQpzdGFjayBicmFuY2ggcmUt
dGVzdGVkIGJ5IGl0LiBEYXZlIGhhZCBwdXNoZWQgdGhlIHNoYWRvdyBzdGFjayBmaXggdG8NCmhp
cyByZXBvIGFzIHdlbGwsIHNvIEknbSBhc3N1bWluZyBoZSB3aWxsIGhhbmRsZSBnZXR0aW5nIHRo
ZSBmaXggaW50bw0KdGlwLiBCdXQgcGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueXRo
aW5nIGZyb20gbWUsIGFuZCBzb3JyeSBmb3INCnRoZSBoYXNzbGUuDQo=
