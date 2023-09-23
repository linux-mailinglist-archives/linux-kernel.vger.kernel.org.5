Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF77ABE60
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjIWHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIWHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:37:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653F136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 00:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695454637; x=1726990637;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HhJBIwRXbOoE18BqxGLyqwuz9V2+4nTHNRB8OPnCtSo=;
  b=LooNUmrb204WY7P3C4W6AWpayUAx10WcPo80+EMucpTV7Wl3HKz929fk
   qoPoQLFo+PX8JnrQl/BgL5yCrnOcLnTAE5F/2PXyFrIOXbED47+9UK+/d
   KBd5SYlcRaV4teReS94AE95xQa+I6IvS2pSF5X1AegMDoCNTZ8jdddXLH
   duSW5WwgVKGeZJt60uSSh/YvMsYKnaXrWhrhsDFgMZbD0ggA4JTTvr8Fx
   YrZMDtS3XG7Rwmi1uz9/U6HkjR8fzHCBYPfPdH0IZgXD5hD0ijER2pjak
   hhvqJb0MJOAMHy2wyrFm+OgOgehsx6b7WuUtkQ4VwgQIbbnjEnfXVQFcd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="445102503"
X-IronPort-AV: E=Sophos;i="6.03,170,1694761200"; 
   d="scan'208";a="445102503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 00:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="818059718"
X-IronPort-AV: E=Sophos;i="6.03,170,1694761200"; 
   d="scan'208";a="818059718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2023 00:37:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 23 Sep 2023 00:37:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 23 Sep 2023 00:37:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 23 Sep 2023 00:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKNoac02Y94+D4Ui7HgQzTTQ39znL5H5GkaCVBiX9FERDfZ0Oa7aEb6Jn88tbbnNXzry+K1lHZEkoE5YtFK2OLL8w/aGaZR1AACjSOLwltnXdMmZbUQwV1XcD5b97oPVi6orWiQtSid3J4UCsWB71llwGQDvJpxdoyjHGQQR8jNYlbQEMyoKMbZH0D9ZXdzJnDshCCDdmdLmVEG3CZv0bQ5XTxVsluQWYc1oxJR/tKwC/MnGmhJWchv4ZVhihG83ii28hGFPsbsC4FzwwhXQvrAZryPqUResfnwMakfGzb9uD5hHY0lM/06g6k2DGpBZMmPq8Qx4GvMSihEEwASKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uw7XhM0HFn/BUXImll/0VLQSiqE8frptRCDuosRIOI=;
 b=HbzibyOJAwkMj1aJwOFILUoDi1ewmMzWhGuu5+XU0zbsu0wClllXkQN2asFZbfJvTsjVVicA8bEgTUQHUL9f383C2D6d7yFTYqgRtQtRzJQcwoB+thASZj+oUC+W5PQFkYVr1dbKkNOj0KdcZPvlE4I+DEGcqWRrnfRGHyaOerFlxZ5mmozKBtrqtwYSXMUfPcKo0uBcs5YN0bXo9zK1xa869TwiF/228G4GHV0Onwz7LU7ah2y6uNqAvfZ6kRjGos8zp/9mnR08EajSiy4ix/wLqmsPHb97S9V2yk50DSgDfOnfbna22SSrmyF6BERm43Cd4chofOA/sRukq0mH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 07:37:13 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::922f:ec7c:601b:7f61]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::922f:ec7c:601b:7f61%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 07:37:12 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Compostella, Jeremy" <jeremy.compostella@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/cpu/intel: Fix MTRR verification for TME enabled
 platforms
Thread-Topic: [PATCH] x86/cpu/intel: Fix MTRR verification for TME enabled
 platforms
Thread-Index: AQHZ7aKWFJxmwKqXn0q3WtdFNO2ey7AoAFcQ
Date:   Sat, 23 Sep 2023 07:37:12 +0000
Message-ID: <SA1PR11MB67344EB62BF798C9FA991552A8FEA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <87v8c1ua39.fsf@jcompost-mobl.amr.corp.intel.com>
In-Reply-To: <87v8c1ua39.fsf@jcompost-mobl.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|IA0PR11MB7212:EE_
x-ms-office365-filtering-correlation-id: 172daa18-da8c-42c7-73e3-08dbbc07e6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJX503c6IaE92c7YzdEZ54SqirsHuuGhFXEz4zHH4+44HSuA/8CQmaY6H9EZfkLaQ0BPw8E11mnqFwAGaiEPa6zJWMDHwEk1jleh/Ij22LFUZmOMVpRX6OtTMjqxRGGevTH1r+ZaAnXc60rM7svxtZlJdVSNUnYG6o8LNEKY5xE3l57ChMRqpaKU4MnsXJLgI9Qe2ItxgjrWyKdLNq8KZIE19GlgUWUKfLInY85p3JGhPke3veEHxSy2cgIKuj8DUYFLSIAnHgjhQQWzsnh5oAp58LhTopW+fg7zqeqrfcbQITn/v0lMgjEo5oKVX4E7zLbyBThQz+YpNmEj/y+eGH+DXITgBcmErtSSjXK/ZTip2U8B++Nrl5TDTuU7Wxf243PXufazOhX0y1K/7gNhbqddswKGO/o4oX1PUNmpp2HJKl3VjFQ2AyGC0ZrkYgTdkUmfrHszzLb7dndb+V8zNLM9Cp8YbApMMqv4Iumqeb3ka9qxFu7QGo+jWc6VnlQjaVtjselJadFvkUU7RgSQIKQysJg0WOyVfCwXpPy8e1kLobed8TteWMv30r5iX2Nfvq8HVe0gbY7wQkswEx8CsqKDN4DA/WiW3UeyYp6hIe/Y4hfhrBSbVjtmZg5DbZLA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(55016003)(71200400001)(6506007)(7696005)(9686003)(26005)(41300700001)(82960400001)(76116006)(66946007)(66446008)(110136005)(38070700005)(66556008)(66476007)(38100700002)(122000001)(316002)(64756008)(478600001)(2906002)(83380400001)(5660300002)(52536014)(8676002)(86362001)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8gc0rFOuIaAMXj9NP1ag2eIw4CycYIXR8ixCWEz0i0q8RWfVukvxxUsrFzy?=
 =?us-ascii?Q?AMJNYmXXVx/yE3GasJh2Zrj7MQeai9+vq9LymykuvLM5VL6enUbfywdNxE8W?=
 =?us-ascii?Q?If+twojDl08Jh7nu4Lzyyjcd7Z1SbKTzGYRLLP+EnKPs5hnLXMNSg0gMXf7R?=
 =?us-ascii?Q?KBbZaGrlCpNSESFGkVao6MBRmJxO0YdXLOA2apnXKG4TC9t1uMPe8C1+W9QB?=
 =?us-ascii?Q?wJ4wtoujhvIlisMBhDv2HA9UR/J9sf/8uq8LHBN+ny15Uflq4Oz5A8w7gp6R?=
 =?us-ascii?Q?Gbd6UklEQpA4KbHpJCFjyD9fggS9X5XBT8gOMaiTiim4KC2cIhGm0KaszKAJ?=
 =?us-ascii?Q?4byil3Cwl5X5HZYZgB/wOMOYtxSdENFWJoc8ptAi/d+B/ovzlrUYGTB4/2GE?=
 =?us-ascii?Q?0T52A9c9CkTU0ol4sEhu9JHSXExYLIxup9mUCFNFA2+NA0YBMs1T5gw8CDZt?=
 =?us-ascii?Q?rdA7kLUhiOTII3nUaIdWuZ7LAhf28o36OXgUCE2+cY1DRZXHXOPBDU+8maj6?=
 =?us-ascii?Q?1Xjaq4Zew3mtoIOkPuSLtUFLJO3kUICr16Ea4OK+rU/3MxlYu6yERsswgGqz?=
 =?us-ascii?Q?mDrQ9lL5mUiy6xmcHllUz9YgbaYaNJuSCL1ercJYJx4QtIbJ8XTnEpcrJieT?=
 =?us-ascii?Q?hn0tBJEoJRXcVA+h2Lh67zUnP4/a7oSj9SYOaNJ+UrQTZ5tEVaJlQJpgnoTy?=
 =?us-ascii?Q?Iu098lLoHucu13QTEo5/K6J5bVliqO8RWft3oGweeWyQ32AzWUfYcRr7fWv9?=
 =?us-ascii?Q?tisoGQjEKtvOMCMTuC732m7/SS3KVPyLSVsJJiIn53YSEBVxRKq2AFaGTm7K?=
 =?us-ascii?Q?7TNwPFHtwEwHlX4vMARHnXwUBxazmSWnxrMw3beyj3jmw7DdcoUGj+Yf1DlZ?=
 =?us-ascii?Q?ZFO9vA7qdpyLs5biRoYJs1v8lwGk/zWMPOfQHa0N4GZzOByRxvgAynh45UAH?=
 =?us-ascii?Q?UHloZBPQGZvTDH8U3Ug0V68yRZ0ZipO4f9FTERDmQfRqR2YvG4F9Hcz+VRjP?=
 =?us-ascii?Q?OHrP4tt+wfCWNdriI9I30hD6l9d27e/HZzpRnZXnKh0k5TwWyid57bSz+8kP?=
 =?us-ascii?Q?xj8RY/2OK7xXNyrnu1CkbY9ODw2ZRs68ULEpmaKUSYgQ0g3gKdqavYXAdcSq?=
 =?us-ascii?Q?3t2WROj6VlUS7TMqRKZnY2xAg0Dqc31cd2hVemOJ7cdm0UCPEod4YBG3XsEz?=
 =?us-ascii?Q?cO5y/BrnGGrv8xqXo4ZW1W+ydTaiG2idLj72mYWUMk0TL0kv9FdUt8H3dtax?=
 =?us-ascii?Q?LTEPM9mqYptlkPMQKha2jqyZTN8BXw7Gc1ZzAjy8cTxf2BVeBC008nEOCCd6?=
 =?us-ascii?Q?ZToDQXcFRgJcBD7wP7TtwpyKMN3B/o8iF9hEGGl03LeChiEG99XOS3L3JFvd?=
 =?us-ascii?Q?Gr7VqaGXZ2KgHH/rkIx3f52AhOboS7fZjIgPW5BbrYz1saITSxYajEpwiHhI?=
 =?us-ascii?Q?fFT0VVtTKI6yaA//RZoFNHMOUOMCQ4dDh14KeohJlD2Z5YTAvWxromdlDpAj?=
 =?us-ascii?Q?UqdWT5Iv37V9sKY7v1HX07N2P7yid6wzjvtWn/czjUFzbtO+nW0B74bScu8f?=
 =?us-ascii?Q?5GFrot3pUsibWpBL4k4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172daa18-da8c-42c7-73e3-08dbbc07e6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2023 07:37:12.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg/Zrwkn8ZQY4TWvAv7xsSpuRj8TCmbArmdBPUqr3TCCH67vSEUU0PcaamGyOzg9wCA4dQdl/kwCGPmJ1inHLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
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

Hi Jeremy,

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index be4045628fd3..34c54432bf00 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -184,6 +184,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86=
 *c)
>  	return false;
>  }
>=20
> +#define MSR_IA32_TME_ACTIVATE		0x982

I know you're just moving the definitions, however we usually define MSRs
and their bits in arch/x86/include/asm/msr-index.h.

> +
> +/* Helpers to access TME_ACTIVATE MSR */
> +#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
> +#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)

What about:

#define TME_ACTIVATE_LOCKED(x)		(x & BIT(0))
#define TME_ACTIVATE_ENABLED(x)		(x & BIT(1))

> +
> +#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */

And:

/* Bits 7:4 are TME activate policy bits */
#define TME_ACTIVATE_POLICY_OFFSET		4
#define TME_ACTIVATE_POLICY_MASK		0xf
#define TME_ACTIVATE_POLICY(x)						\
	((x >> TME_ACTIVATE_POLICY_OFFSET) & TME_ACTIVATE_POLICY_MASK)

> +#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
> +
> +#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits
> 63:48 */

ditto

> @@ -335,6 +419,9 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>  	 */
>  	if (detect_extended_topology_early(c) < 0)
>  		detect_ht_early(c);
> +

Please add a comment here explaining why detect_tme() needs to be called
in early_init_intel().

> +	if (cpu_has(c, X86_FEATURE_TME))
> +		detect_tme(c);
>  }
>=20
>  static void bsp_init_intel(struct cpuinfo_x86 *c)

Thanks!
    Xin
