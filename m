Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86D17F3632
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjKUSjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjKUSjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:39:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C61A1;
        Tue, 21 Nov 2023 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700591945; x=1732127945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YxhJ3USLrW2jb0HSNDtG0XdPEyiGLqChKTawrPuPgtM=;
  b=Qv4TIeBt+W+nWq1LPww4exHa6B/1Qv6bOk+Xn2/vA7/2P7R5m6lg1y67
   CsliHDGobeLV9SDljWRnRNKokn8i7JzuloBML3de+fj7K8q42Y3ABUqWb
   ix47npK34FLGmcNE1ABY4QkwOAsQGb5+DahpI2Ue7WaPHcywyJJAw4Jx0
   b1AjFYgeh1F1nCHnAp41xNGr8Ym+xwshy4r4J9Xk5ymZQ/MMq5p1HGP8n
   2PQ2OtdKOPZQQAHv7ZgJ+yyOO64yFOfwUx/mh9DhHHvu8LJ/pu6q0G0Tw
   IGe505swsRVWF0boc00H/izeuVt150j2sXnoRQKDS4y/43o+6Z7wqXDl9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478109651"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="478109651"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743136571"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="743136571"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 10:37:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 10:37:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 10:37:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 10:37:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfVTz1mew4G4nax3zcAmyrxVM3w8luRR1pjhY+U/88ecfC+HxSPVbQ3HDJrri1P65eD5XWrALfcDPgWy5Gi/4IFbGaQRG//fjHuJp43gU29QJiokaeyawrZUTOi3toVdpBlLmmZObNgRu4P4gFFt4T+qlx0I6PdR+MrIylYUGZVBFKzST7J1yP6A574mIpAX4YuIkxeIeAmoW6du7k25lpDOmuFRFbunSciMJDw+jI24frui1a29jIz0O4UYNH9CVKCJ9xJ+/09vX/HscNesq1Wv0H3ZSl9qHkvJVeHQTi8dFbvz8M9svxNRW7IMqoKP4Rq/xARZYCcY3IQp6pZZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxhJ3USLrW2jb0HSNDtG0XdPEyiGLqChKTawrPuPgtM=;
 b=HuXqMB3i3s5O9+mBu0zkaHToPYpucP9D/dBipsWsDta9qsU1RkxA+kU/Ngp4nA19D9EchRiGZQv+4IMr66JzVriEKTawGjmAO2m5CI665zVOWhoW54rTqxg1x8A0yUJx1LROA2LOgY6ggYOeRjE2FtlTbNwpee82+O2Nq7+++yvSdQ4rLBahUxHNPJ9UM1c8Exe6FzYdcOVG8sjnuCl9AENVMErVRlCkhpN1sy08BgufK19m9ASM/stYsqn4Lw5635xedv3qRi8XHG9Wwp2Ji1q10dkFDX14Ifh7NVC+btFt1UBT3Xep9B048ukvJhHJIGr0WwKPCfT/E5l3B/3LVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SA0PR11MB4624.namprd11.prod.outlook.com (2603:10b6:806:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 18:37:41 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 18:37:41 +0000
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
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1wgAEi2gCAA4/1oIALktuAgADzAICAABvkkIAABCKw
Date:   Tue, 21 Nov 2023 18:37:41 +0000
Message-ID: <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|SA0PR11MB4624:EE_
x-ms-office365-filtering-correlation-id: 43be3aa0-df01-49d4-f83d-08dbeac0f208
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o0lqYw9JA6cHvrV8dSF+SATDmz1FPrjZ7gARutUIWCswNK2R8O/C+9DqGhtEibPNN3EPKlb6yOSworN+XGCPR46rJ/KfkSNqeS2coLEDfjT+GMJptlTRHRPPIj1xogrNxBCTgcWH9sf6+EVcnX9InLP+b75pORpY1EhwwqkXaESpJyew5kTM956H6VqqTRsE5DfHImB/8hEfsglpkOHFln+0ihcKGPRzN44p1leMs37ckYsbQRIipcLN9WmQOSWvZ869RsXP/qNzC/5fS3EkhZH9l+tmW8ieO97vNYSJjBBnwjj13vvOg8vCpgeiOhCiqdYPyQYtsJjzURNEUsR6tjrCGNB6Z6Bv94BiQr0fSyn07tvcCJ8fd1+JaqF96k7A6m0ceox3P0mR2ziByhp2opnABWT86iIPhr0MvsjpEYL04Z94bfGZ/7nH4Qn+E6ix9vWdmEW4yU3Y8nfGBiBAlJ69GGqM4jCrbA6HHKiHLpifyduwMFlJF4d8MIkvs61/yDUw0qPlgUOyLNJrSWoM2hDx1rl1ZcgoDUQyBtfPDVVzl/2lkKXzpu7yVYX3LH+bdZWRdbGMIhMDSMN9B9HC4tM1YzRPFE41IYVPkq8v+5w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(33656002)(52536014)(8676002)(8936002)(4326008)(5660300002)(38100700002)(86362001)(7416002)(38070700009)(41300700001)(2940100002)(107886003)(9686003)(55016003)(71200400001)(26005)(6506007)(53546011)(7696005)(83380400001)(82960400001)(478600001)(122000001)(66946007)(110136005)(66556008)(66446008)(64756008)(66476007)(54906003)(76116006)(316002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0cwYjZ3RDhJR1dnS25ybGN3N0p0UTB6VjZQMjdUMVNrNmhEU3Rqa3VzT3R6?=
 =?utf-8?B?Y3NQQXdWK2lWalFiT0F2L1IrT2h3UkZKNmlONFY0WVpremFpWWo0ZzQ3OHVK?=
 =?utf-8?B?Ykx4S2cyejFpdlptdkdCRk5IZHhCVUwvQmNDOWErcmQ3M1oyUk9uYjFweEpF?=
 =?utf-8?B?dlRGT3VCNWp2UXdQeGh5SlNtdzNGcjVVMDdIQ1FwaDVGSHpCcVVmTFBJMGps?=
 =?utf-8?B?UWpiYUg4VlI0bEJTZVBlZUVtQUR2U2pZcXprMW40SUc5WHdYVFpwdVZOUXRC?=
 =?utf-8?B?cEtVRW41RWdXTFVCdy9hNDhDRUU0ZlFWQXZuRjBuMDFGREpKNmcxdlZiczJU?=
 =?utf-8?B?TDRHZ2p3WENwb2hic0VjWmNnUHRpTXZnZGUyYm9zeHpTaFViUXBkVStpQ2w1?=
 =?utf-8?B?dFdMZktMazVaS1VaZWtVbENhRU0xOVV6S0VOZHJkSjJYa2paNU9qajVmbERC?=
 =?utf-8?B?UDAyYnBwYU9mcGJVUDBMMGhaaGVsVGZjWWFCaVNOTDUxWitUL1pwUUpLMEZt?=
 =?utf-8?B?S09CTVdLWWpaaGJTbGpSbzBOQ1VUUURaTnZnUm0ySlh6UGdHSWdhZDhCNlkz?=
 =?utf-8?B?Y2RhdVRyRzNmNGdrTnVMVlRqbUEyN0E0Um9GZXBnd09PYU5BTWtTTnB4Tno0?=
 =?utf-8?B?MUtvUEFDMTRGcXVHQXBzelpQQjdIVStFckJEZ0dVZWhUS0kwTFRXYk5WYm00?=
 =?utf-8?B?Y2tFY3NXbjlNR2Zld0hEWGdTc2srMm14bjlQQ1gyRkJwZVBTQUt6ak8yYXlu?=
 =?utf-8?B?Y1crK0tBckp3cE5JRVBCRXUzbUN0VUdTbEVnM2ZURzljN1FSLzlNMXlCVVJ2?=
 =?utf-8?B?U29BVlNGL1E3UEQ4c3JaQWd5S0tERWZpSDU5Mm0zc1kreWlyT01ORXllRC83?=
 =?utf-8?B?ZDZmMnJsc3dLeTk3SURET2srYjFxRUpzSlAxWlRzamNUYm0wc1c1cWwzRzRI?=
 =?utf-8?B?K2d6a1NrdlAwSGFXRDhKT0ZwY3o1blJqWkdmNjZNNWRGaG9nL0t4cGJYRVQ2?=
 =?utf-8?B?UHpPcWFndWpLcHFQTERqY3dvSkRESi94SStPSjR6ekFrK1AxSnowVVF0czEx?=
 =?utf-8?B?Q3hRWGJmRSs0MjFGc1c3TUVzaFJCSGFQODlVQlhuREFWbEZpcUFmZThXRFd3?=
 =?utf-8?B?Y1lFdkc0YzlEQVlvMWRMcnphbExrSVN0RTNRMFVMNVNTc0k1RnN3anhxdnBF?=
 =?utf-8?B?OW02dVZvZzB4V2Y0aDVnR1dtc2dBdEErSDhmcS8zSlRRM1hOcU1KaURhaXhO?=
 =?utf-8?B?VVBZbm9iU2ViN0Vjb21XdmZJazAxeHRYWlRKeDNwRWJGa1RGT1BZRkxGYWFY?=
 =?utf-8?B?NjUzQWZ1L0E2S3UxcjlaK2hObTgxYTB6Y1hkZ3lRWnlUM0g2MlMzeHFIck13?=
 =?utf-8?B?dW5vQnJncE5BZFVoMmxCK3IrK1VBb3gvYXpzYTAxZlVnTTlxUndXaTN1c0dl?=
 =?utf-8?B?a2dhYVVKaEZERTVQbVQrSHY4VjJiY3BodHo5V0NhdzBOVFF1Y2c1bFgzS1Z2?=
 =?utf-8?B?Qi9rYkE4Q3JiK01hQVJodHJIUE45WFN0TjRXVzIrckI1L0ppbXR1T3o5SDdS?=
 =?utf-8?B?YndmS2RmMGdSUTBJeVIraThkVEEyWHhvSU1WT09sZ3JTb25nTDFYWjlkL1RC?=
 =?utf-8?B?QWlJS0lwY29EY2V6bjNqSU5KSzVsdkg2Z2ROYTR1eXE0bXc2QzlqcExSR2pX?=
 =?utf-8?B?K2hIZlVGMXdnc2JTUkRPcFdYb1pFa0RVSFgvcDZLVVlqcThoaVRTSFNjdXZN?=
 =?utf-8?B?TG1WOXZhd0lpclFiYWhHbU0rSHAvbkNOZmhJMTA4amhFVjZkRTdPT1owc1BE?=
 =?utf-8?B?R2dnNlhhUGZUZGswS0ZjSXRmNy9tdy9jbFpYSmVKaDFIQmtpLzVROHZ6d05a?=
 =?utf-8?B?dU9GOHc0Qm1aK2Z6cGw5aW1ONmxHZlVRQmRUekZ1dTQxUDVwTVhrWGtWeTFz?=
 =?utf-8?B?bFpBcDNWQUN0cVJDU2s5S0tPU2NySWhURzkyZmNJUUttdkdiYUN1T3FaV21F?=
 =?utf-8?B?Qnp6SzJ5NHlIZlVIVmJMVXlXSTZGb2hQb0ZvNGpaZXl3Ukx5dVY1SUo2bVBu?=
 =?utf-8?B?eWVhbUhqWWpGKzlFaG5DNGFNVExKZCtnSHVzbEdJRjQ5S2RFSE9oeEhKeHV2?=
 =?utf-8?Q?OuQJk+1QMpW0NSBL5tA4KWJ2R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43be3aa0-df01-49d4-f83d-08dbeac0f208
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 18:37:41.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1OTONkZkDUHPITf/LAdZ48mGQAu+CZPmDkAHfDgzO+Mk3758mTfXRSGa2T1hcd7sO/nPGhc6RHE77DdaZSO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4624
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpJbiBQUiwgVWVmaVBheWxvYWRQa2cvTGlicmFyeS9GZHRQYXJzZXJMaWIvRmR0UGFyc2VyTGli
LmMsIGxpbmUgMjY4IGlzIGZvciByZWxhdGVkIGV4YW1wbGUgY29kZS4NCg0KVGhhbmtzLA0KQ2hh
c2VsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGl1LCBDaGFz
ZWwNCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjEsIDIwMjMgMTA6MzQgQU0NCj4gVG86IEFy
ZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVt
Lm9yZz4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBNYXJrIFJ1dGxhbmQgPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IFRh
biwgTGVhbiBTaGVuZyA8c2hlbmcudGFuQDllbGVtZW50cy5jb20+OyBsa21sDQo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGhhdmFsIFNoYXJtYSA8ZGhhdmFsQHJpdm9zaW5jLmNv
bT47IEJydW5lLA0KPiBNYXhpbWlsaWFuIDxtYXhpbWlsaWFuLmJydW5lQDllbGVtZW50cy5jb20+
OyBZdW5odWkgQ3VpDQo+IDxjdWl5dW5odWlAYnl0ZWRhbmNlLmNvbT47IERvbmcsIEd1byA8Z3Vv
LmRvbmdAaW50ZWwuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IHJvbiBt
aW5uaWNoIDxybWlubmljaEBnbWFpbC5jb20+OyBHdW8sIEd1YQ0KPiA8Z3VhLmd1b0BpbnRlbC5j
b20+OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgVS1Cb290IE1haWxpbmcgTGlzdCA8dS0N
Cj4gYm9vdEBsaXN0cy5kZW54LmRlPjsgQ2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjcgMi8yXSBzY2hlbWFzOiBBZGQgc29tZSBjb21t
b24gcmVzZXJ2ZWQtbWVtb3J5DQo+IHVzYWdlcw0KPiANCj4gDQo+IEhpIEFyZCwNCj4gDQo+IEhl
cmUgaXMgdGhlIFBPQyBQUiBmb3IgeW91ciByZWZlcmVuY2U6DQo+IGh0dHBzOi8vZ2l0aHViLmNv
bS90aWFub2NvcmUvZWRrMi9wdWxsLzQ5NjkvZmlsZXMjZGlmZi0NCj4gY2NlYmFiYWU1Mjc0YjIx
NjM0NzIzYTIxMTFlZTBkZTExYmVkNmNmZThjYjIwNmVmOWUyNjNkOWM1ZjkyNmE5Y1IyNg0KPiA4
DQo+IFBsZWFzZSBub3RlIHRoYXQgdGhpcyBQUiBpcyBzdGlsbCBpbiBlYXJseSBwaGFzZSBhbmQg
ZXhwZWN0ZWQgdG8gaGF2ZSBzaWduaWZpY2FudA0KPiBjaGFuZ2VzLg0KPiANCj4gVGhlIGlkZWEg
aXMgdGhhdCBwYXlsb2FkIGVudHJ5IHdpbGwgY3JlYXRlIGdFZmlNZW1vcnlUeXBlSW5mb3JtYXRp
b25HdWlkIEhPQg0KPiB3aXRoIHBheWxvYWQgZGVmYXVsdCBtZW1vcnkgdHlwZXMgYW5kIGFsbG93
IEZEVCB0byBvdmVycmlkZSBpZiBjb3JyZXNwb25kIG5vZGUNCj4gcHJlc2VudC4NCj4gUGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIHF1ZXN0aW9ucyBvciBzdWdnZXN0aW9ucy4NCj4gDQo+
IFRoYW5rcywNCj4gQ2hhc2VsDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+ID4gU2VudDog
VHVlc2RheSwgTm92ZW1iZXIgMjEsIDIwMjMgODo0MiBBTQ0KPiA+IFRvOiBTaW1vbiBHbGFzcyA8
c2pnQGNocm9taXVtLm9yZz4NCj4gPiBDYzogQ2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRl
bC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiBNYXJrIFJ1dGxhbmQgPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+ID4g
VGFuLCBMZWFuIFNoZW5nIDxzaGVuZy50YW5AOWVsZW1lbnRzLmNvbT47IGxrbWwNCj4gPiA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IERoYXZhbCBTaGFybWEgPGRoYXZhbEByaXZvc2lu
Yy5jb20+Ow0KPiA+IEJydW5lLCBNYXhpbWlsaWFuIDxtYXhpbWlsaWFuLmJydW5lQDllbGVtZW50
cy5jb20+OyBZdW5odWkgQ3VpDQo+ID4gPGN1aXl1bmh1aUBieXRlZGFuY2UuY29tPjsgRG9uZywg
R3VvIDxndW8uZG9uZ0BpbnRlbC5jb20+OyBUb20gUmluaQ0KPiA+IDx0cmluaUBrb25zdWxrby5j
b20+OyByb24gbWlubmljaCA8cm1pbm5pY2hAZ21haWwuY29tPjsgR3VvLCBHdWENCj4gPiA8Z3Vh
Lmd1b0BpbnRlbC5jb20+OyBsaW51eC0gYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IFUtQm9vdCBNYWls
aW5nIExpc3QNCj4gPiA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NyAyLzJdIHNjaGVtYXM6IEFkZCBzb21lIGNvbW1vbiByZXNlcnZlZC1tZW1vcnkNCj4g
PiB1c2FnZXMNCj4gPg0KPiA+IE9uIE1vbiwgMjAgTm92IDIwMjMgYXQgMjE6MTIsIFNpbW9uIEds
YXNzIDxzamdAY2hyb21pdW0ub3JnPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSwNCj4gPiA+DQo+
ID4gPiBPbiBNb24sIDEzIE5vdiAyMDIzIGF0IDExOjA5LCBDaGl1LCBDaGFzZWwgPGNoYXNlbC5j
aGl1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEhpIEFyZCwN
Cj4gPiA+ID4NCj4gPiA+ID4gUGxlYXNlIHNlZSBteSByZXBseSBiZWxvdyBpbmxpbmUuDQo+ID4g
PiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gQ2hhc2VsDQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBBcmQg
Qmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBO
b3ZlbWJlciAxMSwgMjAyMyAzOjA0IEFNDQo+ID4gPiA+ID4gVG86IENoaXUsIENoYXNlbCA8Y2hh
c2VsLmNoaXVAaW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBTaW1vbiBHbGFzcyA8c2pnQGNocm9t
aXVtLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IE1hcmsgUnV0
bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSb2IgSGVycmluZw0KPiA+ID4gPiA+IDxyb2Jo
QGtlcm5lbC5vcmc+OyBUYW4sIExlYW4gU2hlbmcgPHNoZW5nLnRhbkA5ZWxlbWVudHMuY29tPjsN
Cj4gPiA+ID4gPiBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGhhdmFsIFNo
YXJtYQ0KPiA+ID4gPiA+IDxkaGF2YWxAcml2b3NpbmMuY29tPjsgQnJ1bmUsIE1heGltaWxpYW4N
Cj4gPiA+ID4gPiA8bWF4aW1pbGlhbi5icnVuZUA5ZWxlbWVudHMuY29tPjsgWXVuaHVpIEN1aQ0K
PiA+ID4gPiA+IDxjdWl5dW5odWlAYnl0ZWRhbmNlLmNvbT47IERvbmcsIEd1byA8Z3VvLmRvbmdA
aW50ZWwuY29tPjsgVG9tDQo+ID4gPiA+ID4gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgcm9u
IG1pbm5pY2ggPHJtaW5uaWNoQGdtYWlsLmNvbT47DQo+ID4gPiA+ID4gR3VvLCBHdWEgPGd1YS5n
dW9AaW50ZWwuY29tPjsgbGludXgtIGFjcGlAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IFUt
Qm9vdCBNYWlsaW5nIExpc3QgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0KPiA+ID4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBzY2hlbWFzOiBBZGQgc29tZSBjb21tb24NCj4gPiA+ID4g
PiByZXNlcnZlZC1tZW1vcnkgdXNhZ2VzDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBTYXQsIDEx
IE5vdiAyMDIzIGF0IDA0OjIwLCBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4N
Cj4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEp1c3Qgc2hh
cmluZyBzb21lIHVzYWdlIGV4YW1wbGVzIGZyb20gVUVGSS9FREsyIHNjZW5hcmlvLg0KPiA+ID4g
PiA+ID4gVG8gc3VwcG9ydCBBQ1BJIFM0L0hpYmVybmF0aW9uLCBtZW1vcnkgbWFwIG11c3QgYmUg
Y29uc2lzdGVudA0KPiA+ID4gPiA+ID4gYmVmb3JlIGVudGVyaW5nIGFuZCBhZnRlciByZXN1bWlu
ZyBmcm9tIFM0LCBpbiB0aGlzIGNhc2UNCj4gPiA+ID4gPiA+IHBheWxvYWQgbWF5IG5lZWQgdG8g
a25vdyBwcmV2aW91cyBtZW1vcnkgbWFwIGZyb20gYm9vdGxvYWRlcg0KPiA+ID4gPiA+ID4gKGN1
cnJlbnRseSBnZW5lcmljIHBheWxvYWQgY2Fubm90IGFjY2VzcyBwbGF0Zm9ybS9ib290bG9hZGVy
DQo+ID4gPiA+ID4gPiBzcGVjaWZpYyBub24tdm9sYXRpbGUgZGF0YSwgdGh1cyBjb3VsZCBub3Qg
c2F2ZS9yZXN0b3JlIG1lbW9yeQ0KPiA+ID4gPiA+ID4gbWFwDQo+ID4gPiA+ID4gPiBpbmZvcm1h
dGlvbikNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIGhvdyB3b3VsZCBFREsyIHJlY29uc3RydWN0
IHRoZSBlbnRpcmUgRUZJIG1lbW9yeSBtYXAgZnJvbQ0KPiA+ID4gPiA+IGp1c3QgdGhlc2UgdW5h
bm5vdGF0ZWQgL3Jlc2VydmVkLW1lbW9yeSBub2Rlcz8gVGhlIEVGSSBtZW1vcnkNCj4gPiA+ID4g
PiBtYXAgY29udGFpbnMgbXVjaCBtb3JlIGluZm9ybWF0aW9uIHRoYW4gdGhhdCwgYW5kIGFsbCBv
ZiBpdCBoYXMNCj4gPiA+ID4gPiB0byBtYXRjaCB0aGUgcHJlLWhpYmVybmF0ZSBzaXR1YXRpb24s
IHJpZ2h0PyBDYW4geW91IGdpdmVuIGFuIGV4YW1wbGU/DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IEhlcmUgd2UgbGlzdGVkIG9ubHkgdHlwaWNhbGx5IG1lbW9yeSB0eXBlcyB0aGF0IG1heSBj
aGFuZ2UgY3Jvc3MNCj4gPiA+ID4gZGlmZmVyZW50DQo+ID4gcGxhdGZvcm1zLg0KPiA+ID4gPiBS
ZXNlcnZlZCBtZW1vcnkgdHlwZSBhbHJlYWR5IGNhbiBiZSBoYW5kbGVkIGJ5IHJlc2VydmVkLW1l
bW9yeQ0KPiA+ID4gPiBub2RlLA0KPiA+IGFuZCByZXN0IG9mIHRoZSB0eXBlcyB1c3VhbGx5IG5v
IG5lZWQgdG8gY2hhbmdlIGNyb3NzIHBsYXRmb3JtcyB0aHVzDQo+ID4gY3VycmVudGx5IHdlIGNv
dWxkIHJlbHkgb24gZGVmYXVsdCBpbiBnZW5lcmljIHBheWxvYWQuDQo+ID4gPiA+IEluIHRoZSBm
dXR1cmUgaWYgd2Ugc2VlIGEgbmVlZCB0byBhZGQgbmV3IG1lbW9yeSB0eXBlcyB3ZSB3aWxsDQo+
ID4gPiA+IGRpc2N1c3MgYW5kDQo+ID4gYWRkIGl0IHRvIEZEVCBzY2hlbWEuDQo+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFub3RoZXIgdXNhZ2UgaXMg
dG8gc3VwcG9ydCBiaW5hcnkgbW9kZWwgd2hpY2ggZ2VuZXJpYyBwYXlsb2FkDQo+ID4gPiA+ID4g
PiBpcyBhIHByZWJ1aWx0DQo+ID4gPiA+ID4gYmluYXJ5IGNvbXBhdGlibGUgZm9yIGFsbCBwbGF0
Zm9ybXMvY29uZmlndXJhdGlvbnMsIGhvd2V2ZXIgdGhlDQo+ID4gPiA+ID4gcGF5bG9hZCBkZWZh
dWx0IG1lbW9yeSBtYXAgbWlnaHQgbm90IGFsd2F5cyB3b3JrIGZvciBhbGwgdGhlDQo+ID4gPiA+
ID4gY29uZmlndXJhdGlvbnMgYW5kIHdlIHdhbnQgdG8gYWxsb3cgYm9vdGxvYWRlciB0byBvdmVy
cmlkZQ0KPiA+ID4gPiA+IHBheWxvYWQgZGVmYXVsdA0KPiA+IG1lbW9yeSBtYXAgd2l0aG91dCBy
ZWNvbXBpbGluZy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBZ3JlZWQuIEJ1
dCBjYW4geW91IGV4cGxhaW4gaG93IGEgRURLMiBwYXlsb2FkIG1pZ2h0IG1ha2UNCj4gPiA+ID4g
PiBtZWFuaW5nZnVsIHVzZSBvZiAncnVudGltZS1jb2RlJyByZWdpb25zIHByb3ZpZGVkIHZpYSBE
VCAgYnkgdGhlDQo+ID4gPiA+ID4gbm9uLUVESzIgcGxhdGZvcm0gaW5pdD8gQ2FuIHlvdSBnaXZl
IGFuIGV4YW1wbGU/DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFJ1bnRpbWUtY29kZS9kYXRh
IGlzIHVzZWQgYnkgVUVGSSBwYXlsb2FkIGZvciBib290aW5nIFVFRkkgT1MNCj4gPiA+ID4gd2hp
Y2gNCj4gPiByZXF1aXJlZCBVRUZJIHJ1bnRpbWUgc2VydmljZXMuDQo+ID4gPiA+IFBsYXRmb3Jt
IEluaXQgd2lsbCBzZWxlY3Qgc29tZSByZWdpb25zIGZyb20gdGhlIHVzYWJsZSBtZW1vcnkgYW5k
DQo+ID4gPiA+IGFzc2lnbiBpdCB0bw0KPiA+IHJ1bnRpbWUtY29kZS9kYXRhIGZvciBVUEwgdG8g
Y29uc3VtZS4gT3IgYXNzaWduIHNhbWUgcnVudGltZS1jb2RlL2RhdGENCj4gPiBmcm9tIHByZXZp
b3VzIGJvb3QuDQo+ID4gPiA+IElmIFVFRkkgT1MgaXMgbm90IHN1cHBvcnRlZCwgUGxhdGZvcm1J
bml0IG1heSBub3QgbmVlZCB0byBwcm92aWRlDQo+ID4gPiA+IHJ1bnRpbWUtY29kZS9kYXRhIHJl
Z2lvbnMgdG8gcGF5bG9hZC4gKGFsd2F5cyBwcm92aWRpbmcNCj4gPiA+ID4gcnVudGltZS1jb2Rl
L2RhdGEgc2hvdWxkIGJlIHN1cHBvcnRlZCB0b28pDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IFVuZGVyIGJlbG93IGFzc3VtcHRpb246DQo+ID4gPiA+ID4gPiAgICAg
ICAgIEZEVCBPUyBpbXBhY3QgaGFzIGJlZW4gZXZhbHVhdGVkIGFuZCB0YWtlbiBjYXJlIGJ5DQo+
ID4gPiA+ID4gPiByZWxldmFudA0KPiA+ID4gPiA+IGV4cGVydHMvc3Rha2Vob2xkZXJzLg0KPiA+
ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IENoYXNlbCBDaGl1IDxjaGFzZWwuY2hpdUBpbnRlbC5jb20+
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBhbSBzb3JyeSBidXQgSSBkb24n
dCBrbm93IHdoYXQgJ0ZEVCBPUyBpbXBhY3QnIG1lYW5zLiBXZSBhcmUNCj4gPiA+ID4gPiB0YWxr
aW5nIGFib3V0IGEgZmlybXdhcmUtdG8tZmlybXdhcmUgYWJzdHJhY3Rpb24gdGhhdCBoYXMgdGhl
DQo+ID4gPiA+ID4gcG90ZW50aWFsIHRvIGxlYWsgaW50byB0aGUgT1MgdmlzaWJsZSBpbnRlcmZh
Y2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGFtIGEgbWFpbnRhaW5lciBpbiB0aGUgVGlhbm9j
b3JlIHByb2plY3QgbXlzZWxmLCBzbyBpdCB3b3VsZA0KPiA+ID4gPiA+IGhlbHAgaWYgeW91IGNv
dWxkIGV4cGxhaW4gd2hvIHRoZXNlIHJlbGV2YW50IGV4cGVydHMgYW5kDQo+ID4gPiA+ID4gc3Rh
a2Vob2xkZXJzIGFyZS4gV2FzIHRoaXMgZGlzY3Vzc2VkIG9uIHRoZSBlZGsyLWRldmVsIG1haWxp
bmcNCj4gPiA+ID4gPiBsaXN0PyBJZiBzbywgYXBvbG9naWVzIGZvciBtaXNzaW5nIGl0IGJ1dCBJ
IG1heSBub3QgaGF2ZSBiZWVuIGNjJ2VkIHBlcmhhcHM/DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+IEknbSBub3QgZmFtaWxpYXIgd2l0aCBGRFQgT1MsIGFsc28g
SSBkbyBub3Qga25vdyBpZiB3aG8gZnJvbQ0KPiA+ID4gPiBlZGsyLWRldmVsIHdlcmUNCj4gPiBz
dXBwb3J0aW5nIEZEVCBPUywgSSB0aGluayBTaW1vbiBtaWdodCBiZSBhYmxlIHRvIGNvbm5lY3Qg
RkRUIE9TDQo+ID4gZXhwZXJ0cy9zdGFrZWhvbGRlcnMuDQo+ID4gPiA+IFdlIGFyZSBtb3N0bHkg
Zm9jdXNpbmcgb24gcGF5bG9hZCBmaXJtd2FyZSBwaGFzZSBpbXBsZW1lbnRhdGlvbiBpbg0KPiA+
ID4gPiBlZGsyIChhbmQgb3RoZXIgcGF5bG9hZHMgdG9vKSwgaG93ZXZlciwgc2luY2Ugd2UgaGF2
ZSBhbGlnbmVkIHRoZQ0KPiA+ID4gPiBwYXlsb2FkIEZEVCBhbmQgT1MgRkRUIG1vbnRocyBhZ28s
IEknbSBhc3N1bWluZyBGRFQgT1MgaW1wYWN0IG11c3QNCj4gPiA+ID4gYmUgdGhlcmUgYW5kIHdl
IG5lZWQgKG9yIGFscmVhZHkgZG9uZT8pIEZEVCBPUyBleHBlcnRzIHRvIHN1cHBvcnQNCj4gPiA+
ID4gaXQuIChhZ2FpbiwgbWF5YmUgU2ltb24gY291bGQgc2hhcmUgbW9yZSBpbmZvcm1hdGlvbiBh
Ym91dCBGRFQgT1MpDQo+ID4gPiA+DQo+ID4gPiA+IEluIGVkazIgc3VjaCBGRFQgc2NoZW1hIGlz
IFVlZmlQYXlsb2FkUGtnIGludGVybmFsIHVzYWdlIG9ubHkgYW5kDQo+ID4gPiA+IHBheWxvYWQN
Cj4gPiBlbnRyeSB3aWxsIGNvbnZlcnQgRkRUIGludG8gSE9CIHRodXMgd2UgZXhwZWN0ZWQgdGhl
IG1vc3Qgb2YgdGhlIGVkazINCj4gPiBnZW5lcmljIGNvZGUgYXJlIG5vLXRvdWNoL25vIGltcGFj
dCwgdGhhdCdzIHdoeSB3ZSBvbmx5IGhhZCBzbWFsbA0KPiA+IGdyb3VwDQo+ID4gKFVlZmlQYXls
b2FkUGtnKSBkaXNjdXNzaW9uLg0KPiA+ID4gPiBBcmQsIGlmIHlvdSBhcmUgYXdhcmUgb2YgYW55
IGVkazIgY29kZSB0aGF0J3MgZm9yIHN1cHBvcnRpbmcgRkRUDQo+ID4gPiA+IE9TLCBwbGVhc2Ug
bGV0DQo+ID4gdXMga25vdyBhbmQgd2UgY2FuIGRpc2N1c3MgaWYgdGhvc2UgY29kZSB3ZXJlIGlt
cGFjdGVkIG9yIG5vdC4NCj4gPiA+DQo+ID4gPiBXZSBkaXNjdXNzZWQgdGhpcyBhbmQganVzdCB0
byBjbGFyaWZ5LCAnRkRUIE9TJyBpcyBub3QgYSBzcGVjaWFsIE9TLA0KPiA+ID4gaXQgaXMganVz
dCBMaW51eC4NCj4gPiA+DQo+ID4gPiBTbywgd2l0aCB0aGUgYWJvdmUsIGFyZSB3ZSBhbGwgb24g
dGhlIHNhbWUgcGFnZT8gQ2FuIHRoZSBwYXRjaCBiZQ0KPiA+ID4gYXBwbGllZCwgcGVyaGFwcz8g
SWYgbm90LCB3aGF0IG90aGVyIGRpc2N1c3Npb24gaXMgbmVlZGVkPw0KPiA+ID4NCj4gPg0KPiA+
IEFuIGV4YW1wbGUgb2YgaG93IGEgcGxhdGZvcm0taW5pdC9wYXlsb2FkIGNvbWJpbmF0aW9uIHdv
dWxkIG1ha2UNCj4gPiBtZWFuaW5nZnVsIHVzZSBvZiBzdWNoIHJ1bnRpbWUtY29kZS9kYXRhIHJl
Z2lvbnMuDQo=
