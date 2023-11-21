Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2B7F3609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjKUSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjKUSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:34:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381EC1AC;
        Tue, 21 Nov 2023 10:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700591668; x=1732127668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RDmVzRqsZY3VloV2zlXwC04Jf/AAPUUL9CrU1qerfDo=;
  b=hXAZS0Jlz84Fj4DxbcjkfQtQn++qmn2flASrv5j8bqZgX5jynkb5KzIQ
   IOZGkAaKmcMOIBdiiZaVPIqOpW/nC6L973BGwlog56BTGMMI6+TYbqNuE
   WS866qfJUaRo8zrSDDHHHxWqxB+Bqgq6rOthRenwJbGwPXN7j/+yiJSNb
   bZV3sc2gGKSAZ9d4EqUZ4442hqMCzMC44HfvWmgx0+9zielkcaozx/6uM
   Q33idDFpsaLoNQ/FoBVaytD8WuGLPCpnquhQ7hrvP0RKcOWeN+DBykuX5
   dtiiLIUREL4uIffhujLlzkkvTIZPAJqmSqiG+zS+yIMoNISExYXHtY36k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10570029"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="10570029"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890333577"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="890333577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 10:34:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 10:34:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 10:34:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 10:34:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 10:34:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGdNJzJuWKpEmpxv1/DqVNEyYxAEkQRmm3JMbJHGEeWa5LgBw6OH//acDCbVBdFuLZQZ2pyeSgIrGf40W0PYNpFiTzDk0K008WKcWBok2k31dmmiy/uJe/mfZL+u1nVtI5IbT8/dB7yqAKicFAF5SaBBIO3QkHoTcUMFPVqe8ieFK7lVpjqNasN/ZN0VL/p6hSO6CaHzRfHOjxAEt3CR4TgboAmJkuM4ZgQK/kdEt1UlGmE17+vXg1tbxxStB5DhiT21mXyUi3JszoMLMea34E+tiHOf1rT2/A47teY4bbyCYjNlNyMoNJeqO6YzG8zZcHRPRML6+gUMWEUzHmwlDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDmVzRqsZY3VloV2zlXwC04Jf/AAPUUL9CrU1qerfDo=;
 b=ZFzSukpMxRbneDKnYC2Xd+iTo0RSOVcWNytSbxPl7qIV9WMX5a+OUaba47aFOAGbdVk4gXKEyFmwaAzCmV3W/6nH2Ffmvren4H9IKvcAZfsQ5mMReqnBg2zNxG1NqjKUtkWhYLyU7P6TPBudzAHzwAUbo+nyRiWx3DsxcTuBHyfW0smkJbe20OWoi0d2oRBTnJ2ao/d7cTcCsDc11d6mnO0cZWoc2YUP4Qce5L4+QBCVR7/HGWiykMkq4ns1JsHjUixfpaFv7ngR7MtIjxalObWILW6eLSvqYGaKDomgm4OsNgNvQ7X/IueNxrkB0/9DAHjcwiG4IzWs6zvh7kUNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 18:34:21 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 18:34:20 +0000
From:   "Chiu, Chasel" <chasel.chiu@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Simon Glass <sjg@chromium.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Tan, Lean Sheng" <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        "Brune, Maximilian" <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        "Dong, Guo" <guo.dong@intel.com>, "Tom Rini" <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>,
        "Guo, Gua" <gua.guo@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        "Chiu, Chasel" <chasel.chiu@intel.com>
Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Topic: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1wgAEi2gCAA4/1oIALktuAgADzAICAABvkkA==
Date:   Tue, 21 Nov 2023 18:34:20 +0000
Message-ID: <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|MW3PR11MB4683:EE_
x-ms-office365-filtering-correlation-id: 11da1951-4fd1-4899-c3c6-08dbeac079fa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDq+FFx22x9fxl1ESN6SwrxJ9+FLybnMI7DGopsZnXmEDf3dw7fTfq9bnYYEZ2wS3ITJV02903G4dATdaoE6v4T202cqggFt3B+eFnnBcXgUOjhvBnGeL2JE71iiCsIsTK+xdTFF8A/1JB/sYdskFKZIwqzsNNPV+Dgr/jgq3p2PY0BtS+Ua4wwPxO5aRz1TrZY6trJwpP6lBS1MQyhIuVCiKMtduHMwfc/8rsaeHCsrnaYSRsnW+H7tvquxR6m+hnHnOKxn+5d0wXB6S5GljoIk+6PfBUBA3rEWIDR9xVMwVOsZckHHb2RzPbIRn3lxTG/b6WbmNNFZ0IZnYciuOLTs/b321S8JFAEKoUUJ3MrzkD8uCoNFnu9bILXiSkABB89ARgwiiZVInHaA514/LzPDO4jlF4y64yO22OO5pxq+lNnv7UyEONRih392/R9zQWq5vxfptmHnV/0WIPe1L6Wnow+92A1c0K/HQr9KJTA5yjX9anof79WHIYKaNApUaN+YZaep1o9tPwCST7h0VI8e+6WXcw1Y+EWexaivMGDmsGvSsPdprhPSzDdgBUyqzgtCFF4LsJBhEcl+joZShlMX62WMIPoJv1Ce1qdP5Ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(110136005)(76116006)(316002)(66446008)(54906003)(64756008)(53546011)(7696005)(9686003)(6506007)(26005)(107886003)(966005)(478600001)(71200400001)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(38070700009)(55016003)(5660300002)(7416002)(2906002)(8676002)(4326008)(41300700001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnkxdFYxVFQ3bTJnajJUbU1BZVVHVTBFcUwwSlpMQlNzS1NneWprd0JSSnVX?=
 =?utf-8?B?VDB4eFRnMng3RFdRMVMxSkdJUGtjbkZPNFozYlhVdzRaR1AzaFduRlFycTVF?=
 =?utf-8?B?elVpS1M1NWV4MFN2MEhnT1IvK3NTZGltUCtNa3Z1USttK1ZZdkNISDRiNGIw?=
 =?utf-8?B?VlloaWZqSVA1N0ZrSWJqZUxPekNYakNnVHhlRWtaZzNDUnRmdFhwTWdVamVN?=
 =?utf-8?B?N1NuQ05RckcxRHdGdHRoUXVubEk1N2hlQlJpTFUyWUcxaUVKbGVwZmxPcVVh?=
 =?utf-8?B?SzlBQzYyN0hxdHBOZE02dm0vT3NVckFNV3FCd0w1YXpUa0d5WFIzYzlDYTQz?=
 =?utf-8?B?bzlKa3NDei9EVHJMeEtTS3liaHc1YkYyWW0yTVlKRSt5ejBPcWZBaTVBbklx?=
 =?utf-8?B?elVDcy9CcFRBUElRcXFzSWdxcmNTRCtDMlVGSVBoUTNoTCs4dnZ3cTRQVE5h?=
 =?utf-8?B?N2dIZUtWbDgyMTlYV3I4UGh3VlMrbzN4emFZQmhVRDR4QmFIdmJsRTBxb1oz?=
 =?utf-8?B?NUFNK1B0YnlrVGo0bHY5NzI4V3lqcEI1RGI5M1RzdVdNUEhRVU9iN25WSHdC?=
 =?utf-8?B?UTBrWE9HZ3BrbytRRm1SbzViNktIYzZ6RGpZY3Z1YWtQcnFZWUZ1Q3RNaGUx?=
 =?utf-8?B?VjlIV2tpR2puWWZSbzRkc2FDVnpCWCt1Yy8yQkhjN3RQa09yNXNvWCt0RStz?=
 =?utf-8?B?WXpNUWtpZm16bVFrY2xrR0ovT1J2ZHhRUEE4NWthRDdNRDJaUjVjVjZidWNT?=
 =?utf-8?B?T1dCamdsVVVkZU9wNXVVM1FJMkV0bFNMcHE3Z01DRjVkSk12NjNpdjN4Unhs?=
 =?utf-8?B?OFlVZE5hR1dLNFROL0JYaE1xWkhhSnZsc0N0bUlCS3BnV0haTUNhTHlvWWRI?=
 =?utf-8?B?NHV2VUNEeHo0Uy80ckxmTVJSeFV4ZERkbzlueWRwR3Q1UzhDL1NWdkUxZEFM?=
 =?utf-8?B?UG5WUzF5VC9qMG1lYlFxWVJaK2pDSFprVVloeUZacHR6WU1zSXNUL1RHK2Yx?=
 =?utf-8?B?SUdxbjBIbGxKRzRDNE9QQ3QzSVA1VnovYzRUOVFQNkdFMkJrRDduNm9ZN2VK?=
 =?utf-8?B?QWFDVjVaZzl1WFpIR2k1TmdrK1NkMHV4c0twSlVBdDhmZVNDNWpzam9iS1lY?=
 =?utf-8?B?V1IwbEpwdEZsTWhGTDhpOVY3aVE5M25IemVPeWVBNk03cHE1N1RaOVNkVTZL?=
 =?utf-8?B?cXJjNmx3bUw1VkVPSWUrR0Jkc0VLSXVaOWk4cm1GdldTSk9WM3hMS1dnaVhT?=
 =?utf-8?B?VUJGYk12Slo5MDFjS2xvRGU4QnRkVjlLSkpOcjJGZngrTnppRGxzS0V2cmQw?=
 =?utf-8?B?VTlDTVZPUUxJY09jR0VxbEJBcDc2blVGQmxQcEgva0w2OE1zZ1E0bXZvQU9M?=
 =?utf-8?B?S2hjRWlHb3dVSHlrTkN6MFFkRVpCZ1BTSXlIb3Y1NWR3ZDZjMXNnVS9tanNJ?=
 =?utf-8?B?ek90cVZqOElGNExQK1VnQytCaHdiSjZuTVJMUHBWbitBVzMxSW1HWlQ5RUd1?=
 =?utf-8?B?dW1YcW9aaGROWVJVTlVoR3VMMGcwTSs3dEJXRkplWGlZNm1GdUJ2OEZYWHZU?=
 =?utf-8?B?ZGhTZmtLSFpqN0k0U0phV3FLQWtlWnVJUld2T1lEVnJGYlFYbUJtampkSnVs?=
 =?utf-8?B?NTBGcmsrQUdJQXFBV1dKUjBuekVBZ2pMR21xamVkcDdlT2RQWlptbHEvOGNR?=
 =?utf-8?B?WVY3Mi9UamNJbFdUV1JBS2hsTTVmSkFVSit2aW5COFV6eFd5dC90NFZsWjZZ?=
 =?utf-8?B?K1ArUmdzUzRwalQzUkpiMVBJUDNXY3RZaU80U1JhelZDaTVNOXJnWDdWazJ0?=
 =?utf-8?B?clM0bDBLclVuajNlT0NqVWtVQjNRTUZOUCtKWXBXaU04Nlo4KzlRaVE1Snc5?=
 =?utf-8?B?ZWZBOGJSdk80VFJ3NWlHZGRrRmFqOTRhdWU1S1JUSitqMGpMT0h3M3VFNm5T?=
 =?utf-8?B?VmtWMGhNdUVuMVFjajVqNEpNMWJSbVBGOCtBNUkxcDFWV0VCNkVOemZaS2Np?=
 =?utf-8?B?MXRkb2lIMEgzME5XeExNTHFoVjZ4UDFDdjgwNCt6U3QweEpwY3UrbXBJbjU3?=
 =?utf-8?B?Y1NrVFZ2cnZTMENXd3ZyWVdsdGh3RitZazFIQ2F1Nzk5K04zUWpqcUhJdTZY?=
 =?utf-8?Q?k5mriU/1prdQDrTG4WxoiU1Yx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11da1951-4fd1-4899-c3c6-08dbeac079fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 18:34:20.4141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6w0NSceTsy0E0xig6C87+kuriuBkCmfGz2XrFuEyIgbRk+ihNxZIvtGHTLL5SfOBDTPwDe+JkeL9pb8fbreUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
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

DQpIaSBBcmQsDQoNCkhlcmUgaXMgdGhlIFBPQyBQUiBmb3IgeW91ciByZWZlcmVuY2U6IGh0dHBz
Oi8vZ2l0aHViLmNvbS90aWFub2NvcmUvZWRrMi9wdWxsLzQ5NjkvZmlsZXMjZGlmZi1jY2ViYWJh
ZTUyNzRiMjE2MzQ3MjNhMjExMWVlMGRlMTFiZWQ2Y2ZlOGNiMjA2ZWY5ZTI2M2Q5YzVmOTI2YTlj
UjI2OA0KUGxlYXNlIG5vdGUgdGhhdCB0aGlzIFBSIGlzIHN0aWxsIGluIGVhcmx5IHBoYXNlIGFu
ZCBleHBlY3RlZCB0byBoYXZlIHNpZ25pZmljYW50IGNoYW5nZXMuDQoNClRoZSBpZGVhIGlzIHRo
YXQgcGF5bG9hZCBlbnRyeSB3aWxsIGNyZWF0ZSBnRWZpTWVtb3J5VHlwZUluZm9ybWF0aW9uR3Vp
ZCBIT0Igd2l0aCBwYXlsb2FkIGRlZmF1bHQgbWVtb3J5IHR5cGVzIGFuZCBhbGxvdyBGRFQgdG8g
b3ZlcnJpZGUgaWYgY29ycmVzcG9uZCBub2RlIHByZXNlbnQuDQpQbGVhc2UgbGV0IG1lIGtub3cg
aWYgeW91IGhhdmUgcXVlc3Rpb25zIG9yIHN1Z2dlc3Rpb25zLg0KDQpUaGFua3MsDQpDaGFzZWwN
Cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFyZCBCaWVzaGV1dmVs
IDxhcmRiQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDIxLCAyMDIzIDg6
NDIgQU0NCj4gVG86IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiBDYzogQ2hpdSwg
Q2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRlbC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+OyBUYW4sIExlYW4NCj4gU2hlbmcgPHNoZW5nLnRhbkA5ZWxlbWVudHMu
Y29tPjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IERoYXZhbCBTaGFy
bWEgPGRoYXZhbEByaXZvc2luYy5jb20+OyBCcnVuZSwgTWF4aW1pbGlhbg0KPiA8bWF4aW1pbGlh
bi5icnVuZUA5ZWxlbWVudHMuY29tPjsgWXVuaHVpIEN1aSA8Y3VpeXVuaHVpQGJ5dGVkYW5jZS5j
b20+Ow0KPiBEb25nLCBHdW8gPGd1by5kb25nQGludGVsLmNvbT47IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+OyByb24gbWlubmljaA0KPiA8cm1pbm5pY2hAZ21haWwuY29tPjsgR3VvLCBH
dWEgPGd1YS5ndW9AaW50ZWwuY29tPjsgbGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnOyBV
LUJvb3QgTWFpbGluZyBMaXN0IDx1LWJvb3RAbGlzdHMuZGVueC5kZT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyAyLzJdIHNjaGVtYXM6IEFkZCBzb21lIGNvbW1vbiByZXNlcnZlZC1tZW1vcnkN
Cj4gdXNhZ2VzDQo+IA0KPiBPbiBNb24sIDIwIE5vdiAyMDIzIGF0IDIxOjEyLCBTaW1vbiBHbGFz
cyA8c2pnQGNocm9taXVtLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IE9uIE1v
biwgMTMgTm92IDIwMjMgYXQgMTE6MDksIENoaXUsIENoYXNlbCA8Y2hhc2VsLmNoaXVAaW50ZWwu
Y29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gSGkgQXJkLA0KPiA+ID4NCj4gPiA+IFBs
ZWFzZSBzZWUgbXkgcmVwbHkgYmVsb3cgaW5saW5lLg0KPiA+ID4NCj4gPiA+IFRoYW5rcywNCj4g
PiA+IENoYXNlbA0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4g
PiA+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciAxMSwgMjAyMyAzOjA0IEFNDQo+ID4gPiA+IFRv
OiBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4NCj4gPiA+ID4gQ2M6IFNpbW9u
IEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gPiA+IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSb2IgSGVycmluZw0K
PiA+ID4gPiA8cm9iaEBrZXJuZWwub3JnPjsgVGFuLCBMZWFuIFNoZW5nIDxzaGVuZy50YW5AOWVs
ZW1lbnRzLmNvbT47IGxrbWwNCj4gPiA+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBEaGF2YWwgU2hhcm1hDQo+ID4gPiA+IDxkaGF2YWxAcml2b3NpbmMuY29tPjsgQnJ1bmUsIE1h
eGltaWxpYW4NCj4gPiA+ID4gPG1heGltaWxpYW4uYnJ1bmVAOWVsZW1lbnRzLmNvbT47IFl1bmh1
aSBDdWkNCj4gPiA+ID4gPGN1aXl1bmh1aUBieXRlZGFuY2UuY29tPjsgRG9uZywgR3VvIDxndW8u
ZG9uZ0BpbnRlbC5jb20+OyBUb20NCj4gPiA+ID4gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsg
cm9uIG1pbm5pY2ggPHJtaW5uaWNoQGdtYWlsLmNvbT47IEd1bywNCj4gPiA+ID4gR3VhIDxndWEu
Z3VvQGludGVsLmNvbT47IGxpbnV4LSBhY3BpQHZnZXIua2VybmVsLm9yZzsgVS1Cb290DQo+ID4g
PiA+IE1haWxpbmcgTGlzdCA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+ID4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjcgMi8yXSBzY2hlbWFzOiBBZGQgc29tZSBjb21tb24NCj4gPiA+ID4gcmVz
ZXJ2ZWQtbWVtb3J5IHVzYWdlcw0KPiA+ID4gPg0KPiA+ID4gPiBPbiBTYXQsIDExIE5vdiAyMDIz
IGF0IDA0OjIwLCBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEp1c3Qgc2hhcmluZyBzb21lIHVzYWdlIGV4
YW1wbGVzIGZyb20gVUVGSS9FREsyIHNjZW5hcmlvLg0KPiA+ID4gPiA+IFRvIHN1cHBvcnQgQUNQ
SSBTNC9IaWJlcm5hdGlvbiwgbWVtb3J5IG1hcCBtdXN0IGJlIGNvbnNpc3RlbnQNCj4gPiA+ID4g
PiBiZWZvcmUgZW50ZXJpbmcgYW5kIGFmdGVyIHJlc3VtaW5nIGZyb20gUzQsIGluIHRoaXMgY2Fz
ZSBwYXlsb2FkDQo+ID4gPiA+ID4gbWF5IG5lZWQgdG8ga25vdyBwcmV2aW91cyBtZW1vcnkgbWFw
IGZyb20gYm9vdGxvYWRlciAoY3VycmVudGx5DQo+ID4gPiA+ID4gZ2VuZXJpYyBwYXlsb2FkIGNh
bm5vdCBhY2Nlc3MgcGxhdGZvcm0vYm9vdGxvYWRlciBzcGVjaWZpYw0KPiA+ID4gPiA+IG5vbi12
b2xhdGlsZSBkYXRhLCB0aHVzIGNvdWxkIG5vdCBzYXZlL3Jlc3RvcmUgbWVtb3J5IG1hcA0KPiA+
ID4gPiA+IGluZm9ybWF0aW9uKQ0KPiA+ID4gPg0KPiA+ID4gPiBTbyBob3cgd291bGQgRURLMiBy
ZWNvbnN0cnVjdCB0aGUgZW50aXJlIEVGSSBtZW1vcnkgbWFwIGZyb20ganVzdA0KPiA+ID4gPiB0
aGVzZSB1bmFubm90YXRlZCAvcmVzZXJ2ZWQtbWVtb3J5IG5vZGVzPyBUaGUgRUZJIG1lbW9yeSBt
YXANCj4gPiA+ID4gY29udGFpbnMgbXVjaCBtb3JlIGluZm9ybWF0aW9uIHRoYW4gdGhhdCwgYW5k
IGFsbCBvZiBpdCBoYXMgdG8NCj4gPiA+ID4gbWF0Y2ggdGhlIHByZS1oaWJlcm5hdGUgc2l0dWF0
aW9uLCByaWdodD8gQ2FuIHlvdSBnaXZlbiBhbiBleGFtcGxlPw0KPiA+ID4NCj4gPiA+DQo+ID4g
PiBIZXJlIHdlIGxpc3RlZCBvbmx5IHR5cGljYWxseSBtZW1vcnkgdHlwZXMgdGhhdCBtYXkgY2hh
bmdlIGNyb3NzIGRpZmZlcmVudA0KPiBwbGF0Zm9ybXMuDQo+ID4gPiBSZXNlcnZlZCBtZW1vcnkg
dHlwZSBhbHJlYWR5IGNhbiBiZSBoYW5kbGVkIGJ5IHJlc2VydmVkLW1lbW9yeSBub2RlLA0KPiBh
bmQgcmVzdCBvZiB0aGUgdHlwZXMgdXN1YWxseSBubyBuZWVkIHRvIGNoYW5nZSBjcm9zcyBwbGF0
Zm9ybXMgdGh1cyBjdXJyZW50bHkgd2UNCj4gY291bGQgcmVseSBvbiBkZWZhdWx0IGluIGdlbmVy
aWMgcGF5bG9hZC4NCj4gPiA+IEluIHRoZSBmdXR1cmUgaWYgd2Ugc2VlIGEgbmVlZCB0byBhZGQg
bmV3IG1lbW9yeSB0eXBlcyB3ZSB3aWxsIGRpc2N1c3MgYW5kDQo+IGFkZCBpdCB0byBGRFQgc2No
ZW1hLg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IEFub3RoZXIgdXNh
Z2UgaXMgdG8gc3VwcG9ydCBiaW5hcnkgbW9kZWwgd2hpY2ggZ2VuZXJpYyBwYXlsb2FkDQo+ID4g
PiA+ID4gaXMgYSBwcmVidWlsdA0KPiA+ID4gPiBiaW5hcnkgY29tcGF0aWJsZSBmb3IgYWxsIHBs
YXRmb3Jtcy9jb25maWd1cmF0aW9ucywgaG93ZXZlciB0aGUNCj4gPiA+ID4gcGF5bG9hZCBkZWZh
dWx0IG1lbW9yeSBtYXAgbWlnaHQgbm90IGFsd2F5cyB3b3JrIGZvciBhbGwgdGhlDQo+ID4gPiA+
IGNvbmZpZ3VyYXRpb25zIGFuZCB3ZSB3YW50IHRvIGFsbG93IGJvb3Rsb2FkZXIgdG8gb3ZlcnJp
ZGUgcGF5bG9hZCBkZWZhdWx0DQo+IG1lbW9yeSBtYXAgd2l0aG91dCByZWNvbXBpbGluZy4NCj4g
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBBZ3JlZWQuIEJ1dCBjYW4geW91IGV4cGxhaW4gaG93
IGEgRURLMiBwYXlsb2FkIG1pZ2h0IG1ha2UNCj4gPiA+ID4gbWVhbmluZ2Z1bCB1c2Ugb2YgJ3J1
bnRpbWUtY29kZScgcmVnaW9ucyBwcm92aWRlZCB2aWEgRFQgIGJ5IHRoZQ0KPiA+ID4gPiBub24t
RURLMiBwbGF0Zm9ybSBpbml0PyBDYW4geW91IGdpdmUgYW4gZXhhbXBsZT8NCj4gPiA+DQo+ID4g
Pg0KPiA+ID4gUnVudGltZS1jb2RlL2RhdGEgaXMgdXNlZCBieSBVRUZJIHBheWxvYWQgZm9yIGJv
b3RpbmcgVUVGSSBPUyB3aGljaA0KPiByZXF1aXJlZCBVRUZJIHJ1bnRpbWUgc2VydmljZXMuDQo+
ID4gPiBQbGF0Zm9ybSBJbml0IHdpbGwgc2VsZWN0IHNvbWUgcmVnaW9ucyBmcm9tIHRoZSB1c2Fi
bGUgbWVtb3J5IGFuZCBhc3NpZ24gaXQgdG8NCj4gcnVudGltZS1jb2RlL2RhdGEgZm9yIFVQTCB0
byBjb25zdW1lLiBPciBhc3NpZ24gc2FtZSBydW50aW1lLWNvZGUvZGF0YSBmcm9tDQo+IHByZXZp
b3VzIGJvb3QuDQo+ID4gPiBJZiBVRUZJIE9TIGlzIG5vdCBzdXBwb3J0ZWQsIFBsYXRmb3JtSW5p
dCBtYXkgbm90IG5lZWQgdG8gcHJvdmlkZQ0KPiA+ID4gcnVudGltZS1jb2RlL2RhdGEgcmVnaW9u
cyB0byBwYXlsb2FkLiAoYWx3YXlzIHByb3ZpZGluZw0KPiA+ID4gcnVudGltZS1jb2RlL2RhdGEg
c2hvdWxkIGJlIHN1cHBvcnRlZCB0b28pDQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4g
PiBVbmRlciBiZWxvdyBhc3N1bXB0aW9uOg0KPiA+ID4gPiA+ICAgICAgICAgRkRUIE9TIGltcGFj
dCBoYXMgYmVlbiBldmFsdWF0ZWQgYW5kIHRha2VuIGNhcmUgYnkNCj4gPiA+ID4gPiByZWxldmFu
dA0KPiA+ID4gPiBleHBlcnRzL3N0YWtlaG9sZGVycy4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTog
Q2hhc2VsIENoaXUgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPg0K
PiA+ID4gPiBJIGFtIHNvcnJ5IGJ1dCBJIGRvbid0IGtub3cgd2hhdCAnRkRUIE9TIGltcGFjdCcg
bWVhbnMuIFdlIGFyZQ0KPiA+ID4gPiB0YWxraW5nIGFib3V0IGEgZmlybXdhcmUtdG8tZmlybXdh
cmUgYWJzdHJhY3Rpb24gdGhhdCBoYXMgdGhlDQo+ID4gPiA+IHBvdGVudGlhbCB0byBsZWFrIGlu
dG8gdGhlIE9TIHZpc2libGUgaW50ZXJmYWNlLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGFtIGEgbWFp
bnRhaW5lciBpbiB0aGUgVGlhbm9jb3JlIHByb2plY3QgbXlzZWxmLCBzbyBpdCB3b3VsZA0KPiA+
ID4gPiBoZWxwIGlmIHlvdSBjb3VsZCBleHBsYWluIHdobyB0aGVzZSByZWxldmFudCBleHBlcnRz
IGFuZA0KPiA+ID4gPiBzdGFrZWhvbGRlcnMgYXJlLiBXYXMgdGhpcyBkaXNjdXNzZWQgb24gdGhl
IGVkazItZGV2ZWwgbWFpbGluZw0KPiA+ID4gPiBsaXN0PyBJZiBzbywgYXBvbG9naWVzIGZvciBt
aXNzaW5nIGl0IGJ1dCBJIG1heSBub3QgaGF2ZSBiZWVuIGNjJ2VkIHBlcmhhcHM/DQo+ID4gPg0K
PiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIEZEVCBPUywg
YWxzbyBJIGRvIG5vdCBrbm93IGlmIHdobyBmcm9tIGVkazItZGV2ZWwgd2VyZQ0KPiBzdXBwb3J0
aW5nIEZEVCBPUywgSSB0aGluayBTaW1vbiBtaWdodCBiZSBhYmxlIHRvIGNvbm5lY3QgRkRUIE9T
DQo+IGV4cGVydHMvc3Rha2Vob2xkZXJzLg0KPiA+ID4gV2UgYXJlIG1vc3RseSBmb2N1c2luZyBv
biBwYXlsb2FkIGZpcm13YXJlIHBoYXNlIGltcGxlbWVudGF0aW9uIGluDQo+ID4gPiBlZGsyIChh
bmQgb3RoZXIgcGF5bG9hZHMgdG9vKSwgaG93ZXZlciwgc2luY2Ugd2UgaGF2ZSBhbGlnbmVkIHRo
ZQ0KPiA+ID4gcGF5bG9hZCBGRFQgYW5kIE9TIEZEVCBtb250aHMgYWdvLCBJJ20gYXNzdW1pbmcg
RkRUIE9TIGltcGFjdCBtdXN0DQo+ID4gPiBiZSB0aGVyZSBhbmQgd2UgbmVlZCAob3IgYWxyZWFk
eSBkb25lPykgRkRUIE9TIGV4cGVydHMgdG8gc3VwcG9ydA0KPiA+ID4gaXQuIChhZ2FpbiwgbWF5
YmUgU2ltb24gY291bGQgc2hhcmUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBGRFQgT1MpDQo+ID4g
Pg0KPiA+ID4gSW4gZWRrMiBzdWNoIEZEVCBzY2hlbWEgaXMgVWVmaVBheWxvYWRQa2cgaW50ZXJu
YWwgdXNhZ2Ugb25seSBhbmQgcGF5bG9hZA0KPiBlbnRyeSB3aWxsIGNvbnZlcnQgRkRUIGludG8g
SE9CIHRodXMgd2UgZXhwZWN0ZWQgdGhlIG1vc3Qgb2YgdGhlIGVkazIgZ2VuZXJpYw0KPiBjb2Rl
IGFyZSBuby10b3VjaC9ubyBpbXBhY3QsIHRoYXQncyB3aHkgd2Ugb25seSBoYWQgc21hbGwgZ3Jv
dXANCj4gKFVlZmlQYXlsb2FkUGtnKSBkaXNjdXNzaW9uLg0KPiA+ID4gQXJkLCBpZiB5b3UgYXJl
IGF3YXJlIG9mIGFueSBlZGsyIGNvZGUgdGhhdCdzIGZvciBzdXBwb3J0aW5nIEZEVCBPUywgcGxl
YXNlIGxldA0KPiB1cyBrbm93IGFuZCB3ZSBjYW4gZGlzY3VzcyBpZiB0aG9zZSBjb2RlIHdlcmUg
aW1wYWN0ZWQgb3Igbm90Lg0KPiA+DQo+ID4gV2UgZGlzY3Vzc2VkIHRoaXMgYW5kIGp1c3QgdG8g
Y2xhcmlmeSwgJ0ZEVCBPUycgaXMgbm90IGEgc3BlY2lhbCBPUywNCj4gPiBpdCBpcyBqdXN0IExp
bnV4Lg0KPiA+DQo+ID4gU28sIHdpdGggdGhlIGFib3ZlLCBhcmUgd2UgYWxsIG9uIHRoZSBzYW1l
IHBhZ2U/IENhbiB0aGUgcGF0Y2ggYmUNCj4gPiBhcHBsaWVkLCBwZXJoYXBzPyBJZiBub3QsIHdo
YXQgb3RoZXIgZGlzY3Vzc2lvbiBpcyBuZWVkZWQ/DQo+ID4NCj4gDQo+IEFuIGV4YW1wbGUgb2Yg
aG93IGEgcGxhdGZvcm0taW5pdC9wYXlsb2FkIGNvbWJpbmF0aW9uIHdvdWxkIG1ha2UgbWVhbmlu
Z2Z1bA0KPiB1c2Ugb2Ygc3VjaCBydW50aW1lLWNvZGUvZGF0YSByZWdpb25zLg0K
