Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06437E41C9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjKGO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:26:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9EF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699367187; x=1730903187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ikjiM4o4KJm+lkhfe+OsB0+m4mV0Af6ELuIab2BT5m8=;
  b=HbF864nrjPg4xuyrcdcow6gS5skGaDa5F3vT7pHAezC6tyxMpmXdJ6ZJ
   8wz99wZFb3Sy6p5A/0aMNyZMgi5DqLzJhhLw0sZQbUUMo4nO6pvaDEW1O
   +3+pnLXEOISG/rTq5R6Y0OHnY0T4RWlf9uzp8oiuR/i0ttongSLsdGQM7
   E9+hw2KaR04RYTzIH/N/GTvkhDA0lCLKwAoqbdEd8afkLmM1T1DNJT+tG
   GpoS5BUJFLUKvxmSzpJPgHGGb3DC7FuBJQPqVti9iNqbuzpNjNxRdtTlF
   LAOrjgu/BAq5giMQsokt7KG+AkeZkn8eS8OicYaAOSEDcQSc9YSvcCM0l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456001606"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="456001606"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="4008940"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 06:26:23 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 06:26:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 06:26:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 06:26:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELSfmmG+bOlA+hbC6tnjQrH9LfGoMwnfJN3s2wg+dHGpWfeBzSYQhwFawweU6rP3CHFkmFwJQMYKbsB0wQ6zF1jJv8WKDMeA7iRELJR31nOHPbIbnrEZp2GK8HuP8/2PnFmrspZY5H1Wd2n4LPzMm7qV5okDTnPtqlsUYD60WYT63HdXpoaoCfD6Kbpuybf4vcp8J1lf987YfWzCU0JOYNVmovueqau2ZRYBfdL8FMFiplWzeJ0o2+jO7cyXeEz6YCinjnCuDaZ60sWCPsWl9BLLZCZ7NOSytCCJnv7mPmTBZHSdQ/TVsaKubU+YPCOl7qQbtNWlHVAUYQLAOOmYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H01AxbwsoVFVKX6u/Jk8wtaqI3F0O+QjJCEHGkmb0Ao=;
 b=TtsWsZ5vqsybEUdXPjZET4wwq7o9Hc7RRKvuKIQqAGcycFBu/OvP2J/g1TzrHKluYrsEyHAr3cm41umTa0uiVkxnB2+n6CawZQPDj0MzRX7xEu/2JG16hYXwRXVQKlqHWzDs0MS4YVCP2Zj3LY5xZR6D/aCpeA7CBQnwMRNZgeMj5c4X1HXIRf44PdxVHtDnKqYdP2eDXbEI7YLBG5/K6Wqp+Nl/sinolmqVSRa+7r7KKvNCGlOcWgvVadlyHg3sm8fsyAj0axHmge2G4IiuPYYzx6JR49TmPpRuS3vxNpizIxXDLlrQjuFBw1eTAhf+dnULYt9U1ePkdGgG6+Vthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 14:26:17 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8593:7da:ec34:29a3]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::8593:7da:ec34:29a3%5]) with mapi id 15.20.6933.025; Tue, 7 Nov 2023
 14:26:17 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] mei: pxp: add dependency on Xe driver
Thread-Topic: [PATCH 5/5] mei: pxp: add dependency on Xe driver
Thread-Index: AQHaEYGKY7jvNwnfuEGj+fqtCp8IFbBu5YSAgAADqrA=
Date:   Tue, 7 Nov 2023 14:26:17 +0000
Message-ID: <CY5PR11MB6366D1F5EB27DA07628B42DCEDA9A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
 <20231107134606.316651-6-alexander.usyskin@intel.com>
 <2023110700-emptier-retrain-08fd@gregkh>
In-Reply-To: <2023110700-emptier-retrain-08fd@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|CH3PR11MB8093:EE_
x-ms-office365-filtering-correlation-id: a0f19d82-d236-40eb-8eaa-08dbdf9d814a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khsjE1te0bWjv3SJiKPjH4CWy2YUHiSY3NAgvJ7gX6nzoNlw57Rsa3YTwlyb/dTRRw+jdBhPwkmJO/D+i856AzoMVEVClD+zwTP+okVBv1E+3M/o/HU8F8590GCjqSMrBfkfB8LgUZFhB7wg4bl+WRix98OlI8VqXoCPzUAqHkE3lK6pr306wPkjR6KZnI28QLcerfhm0yWY1VPnpJOIcxQvQ8U1E1YFxFPxuKWTpONnlTMtYK0JcWoA6y6F6b1hEIExIpyfibGqey2MGctPlV4CQIQ9aImW4eNd5MlKz9R2MZ2Aq0tOA5v8IH75qOfirwW29Jf2ifrLB1nTi+ivUwO7i3GEklM3clKJLJxlAlqVr/oAulU581MytOLCVyIvPQsBa3vc+BY8R4ATf6DEANJBrsFClkWdud3gxTx9u08TI6CYpkVsuLMyvOLqiSNEjVf2ne7Spl6Zrg6pdZZGfc46v44xS7HODXenvt0j/YkyP1dHjIpU6sfWJ0iyH+XffYuUfKv9fQfq85S53P9iXhkYgtPEA2IuwH69aUm7ORvtxV6rePDOKgJg5Ewiv8FakuWh9wVW9ZO0PY1AHhuYMSCCJuot0ypKTttghZbuoJ2eiK6Pxl8wJt8Ar0BI9PVq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(55016003)(38100700002)(7696005)(71200400001)(6506007)(83380400001)(9686003)(82960400001)(122000001)(2906002)(66556008)(86362001)(41300700001)(4744005)(33656002)(8936002)(52536014)(5660300002)(8676002)(4326008)(54906003)(64756008)(6916009)(66476007)(66446008)(66946007)(316002)(76116006)(26005)(478600001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z31qHITUsFWFZAhlmoKtg+e34FKhSRfpNcoch4r+V8sym8uyLpHu1UEeYsRQ?=
 =?us-ascii?Q?AoJeQrsjM6cczQSvwd2ycD276GGn0eAFWRKlvYdHW+Jk8IlnMpANGGCYX9oW?=
 =?us-ascii?Q?QlBiXzIlFGrACVTSyMDwOoJbpFBGZFz0xh5ozihAP6AuMtjHLBUE9KGNxmmE?=
 =?us-ascii?Q?nQj+j8wVETnEOCHsjOCkcU0vS9xlM68wqpLdDHuURIUfgy/wxg4z6AULc/G7?=
 =?us-ascii?Q?PYi1JaAPb4qSuNXSsGpdrV44iynxjDtZ1oWHTUt4649jd6LWC9jbUcXXlnNi?=
 =?us-ascii?Q?urFgVtnjK8/OHDW5EpN3F199/TN+3wfTJTmOJbFZ6HiapTX/Qa5fo4Teyz1R?=
 =?us-ascii?Q?uYwIKCqWmcTPizIYFZx1pja2VsPjo6c5XqsBPjYeI65J0iwifeBuklWOmiE3?=
 =?us-ascii?Q?GX/isz8kPSuKx0gT/VwOuwYOejP3xCZHFp2/CnAzIIFB+/F3YvzOjXP1RBrl?=
 =?us-ascii?Q?ohCVxf0gKc83EMqzaXcVjcbfTKtJrlKyx9gdnufejz4YNRwj7qbPqxQyE6wX?=
 =?us-ascii?Q?x65fUclEBs9habSytdkVjZtrKhmeuMkd5he3kGfowSVZigulbiW6g2LQdwIz?=
 =?us-ascii?Q?2ZYOlZK+tK0FTs3MI7oZJxsHglJafbMTUvpkZLPy1/Z0pD1g+8kaAd6UXF6S?=
 =?us-ascii?Q?5BPw9ZYayIXw/5l+kDtudU7WpSYFkoaDIBS0DMBzrTqQt5A1iDA+7NELwlDm?=
 =?us-ascii?Q?xql5Fw8sYhTzZ4Cs0+erGhkYJ4OuXjpxUXsZF41ZkJN3HTNIBOYWURtDMZu6?=
 =?us-ascii?Q?9jKiHqVM5lfoWO9mYD7yMtpKRV0/i/xmMzmSwFtAUxKmQlBs+QvxVxApmiP5?=
 =?us-ascii?Q?rBZZSomTsmBYfzAs6QU5n7gtvaxpjd1V4mnr20djkzmnkt+feHYrCxxi1nkH?=
 =?us-ascii?Q?WfjvXBMu9myV1qBuB4lvqGEYp+pHgg5c2uDJ5PfxqMdzjS3Bfsq7GN/brRWo?=
 =?us-ascii?Q?gD6vHtu9ixhOSgRYxSmGSW7kwosXvNqZZlDPZmcQFpvvFoOgGZsriMrpDYAr?=
 =?us-ascii?Q?4Uak/kRmMf0vYHAGAvp1HZEgZxuqIJvrg4o6W/mshJGiniSRaVTEcC+ISjel?=
 =?us-ascii?Q?2gkU640fi+dYFM/Y+iPkxNgXL1V2BfTg2KJBTlmjh9TrNc75QfHC31W9KbK6?=
 =?us-ascii?Q?w5Jq0btK3J3nIF1jonRD81WqnZ0LdXNPN0o+Ps6h56gZub8Y3ubgeashhfqt?=
 =?us-ascii?Q?WL66RBYY2gWhTmn/EQkX9eMb6Y/SX3l+k7BAt2wrVNPyKKAAo8em5u46+e9w?=
 =?us-ascii?Q?s2cfIJw3mRiqNt+0YDWfU6QFFTPxzgjYfhJu7seAKDnB2sziP3iFkERKwKhx?=
 =?us-ascii?Q?7Jn79KtPwyape6EdTJMapwPS3asIGlB77W/SsXuh3cOfbyc0uh95W5+rI3A8?=
 =?us-ascii?Q?4JQjy/85MGQLH895r/wx/M+ZwOw+pYSeV2LVdTzGFzY/FUW13JKl+u4VK5lg?=
 =?us-ascii?Q?iM3zU8jzICjTjv3ygg/QN/uHWw4JWgXalpOtU0h3fXKoSBB4sFaxT7ry5G4l?=
 =?us-ascii?Q?tVNUMDMYWXAjXk/ecWcby7T5EFtJ+KsqW96agPi1ABmSlZR7eS036SCVTnrt?=
 =?us-ascii?Q?t2bBwq3vwB0ePbEFerGhn49ZFVJ3k07mshlr2hDbai89GTUNbFLQNleBmp9/?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f19d82-d236-40eb-8eaa-08dbdf9d814a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 14:26:17.4726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaW/jrm7rcFbrwk+jgegRaLD/N/nM6BcoDkqrtfW4x2db2enHzepdZ5Lle5pzFUbyDCGbvUbTTywlna0Bt8c66z61Hewt71HSbWN3HNXgkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
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

>=20
> On Tue, Nov 07, 2023 at 03:46:06PM +0200, Alexander Usyskin wrote:
> > Optionally depend on either i915 or Xe drivers.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > ---
> >  drivers/misc/mei/pxp/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfi=
g
> > index 4029b96afc04..d9ae5483567f 100644
> > --- a/drivers/misc/mei/pxp/Kconfig
> > +++ b/drivers/misc/mei/pxp/Kconfig
> > @@ -1,11 +1,10 @@
> > -
>=20
> Why this change here?

I've been told that SPDX should be the first line in the file,
but here fist line is an empty line.
I can drop this change if it is inappropriate to put it in this patch.

--=20
Thanks,
Sasha


>=20
> thanks,
>=20
> greg k-h
