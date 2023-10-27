Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A807DA3AA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbjJ0Wkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Wku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:40:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDDD62;
        Fri, 27 Oct 2023 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698446447; x=1729982447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q1shBmuUNGUmhUEUpnInNHcqdO8QJGVUI0GTfy6Y97U=;
  b=K0xiG/4j9rz03yU0kgT0JL0qJ3YLvlZeTuxZjZDmBGGdRTfbM2x4mM2o
   ZAL0ZOwgXQ6WwXYKOzPqfkee5kcut5YsVbn2xP7kVKeJxX+8T4cxrm9Te
   yaW+6Up/kRL77CscJ6PO0qki41DmfGn5d3dRKavnVLyt5J4AJ6X2duyAQ
   RC6rHpN6En28vI55iWdCAbl3DQ34I87LMIfS0NtT/oUWDg+dGzjQnxJUg
   KGmYdhiBFtLE9DqnshkJ3lvvnOcmEnokLtQlhFYdBesSRAf4D/hKgTHKg
   30OoGzAfYS/zHiLjEoei9OcvgZaXI9DcMTOOj6mHSX4V3boY0F24+TFLL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391727915"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="391727915"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794725091"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="794725091"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 15:40:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:40:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:40:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 15:40:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 15:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlWE/uE4aZsmuWCkYuaV+XjlLFPMfS+IAiuRi0fV1HVkGONBKL7N2Y0s6qL5ockuIdpEaOXZ/Yybk6aW26O+WNzchfDFE02/NdwCz5RcUQUiuGccfBcaQXKhv8KBf2Ipl2CqTyk9bM4+udq+ODWTamLHydKw3YGIbOoDlb6r+/TbFhwVBjS6baZXHIM7xnptTmZdfhxi0BUy5/BERz3ZN0rRXQ0Od+Dq/QUoRUNU7MHLeGJSAaRZJXw3eYXDfomht08Hh9UlLO7cKbpGTu5oHn/QOZBIMWpBcPjXB8toGsKyzQSf6IW3A2HMoOEUAgGvnNYQcE/xsO9nphGIqXeIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1shBmuUNGUmhUEUpnInNHcqdO8QJGVUI0GTfy6Y97U=;
 b=hOoLSx/eQeOhIkV9CCCMGwaxOeZ9ObqUCdsYDuXnT4bD8w3lLxHxhfqv1uHklc10FT7r4GvqB8DWy5WfyYHqG+aiSX5AklqtqM8J9fF9nx3RulBhuG3y+rsndFfr6MosRYOIBzRhFB8pjcW9LHPpyN0u7yrFbI1AOJlUXnLSm3u1npI2WKVrYj5/ftKugKe0CuVgaaynNTkjAJ2a6yv5A5GqBqS+IR7cPU1ZjbR+8gdeN+8BXLZBR8FhTb5NAB0aL73eescItnMkUcD+RXk5EqVri7aKeX1j5UFdhd+qoZmGu++D7QoGAHZ6camZROu5NejendNqvnrB1SG0aM1zVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5058.namprd11.prod.outlook.com (2603:10b6:303:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 22:40:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3ffb:89e2:2724:4c5%2]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 22:40:43 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jeshua Smith <jeshuas@nvidia.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
Subject: RE: [PATCH V3] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V3] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHaCSXCfPnl8CyMXkanh9+ZGHddYLBeOodA
Date:   Fri, 27 Oct 2023 22:40:43 +0000
Message-ID: <SJ1PR11MB6083B110A8F462644F7D1AE1FCDCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231027223309.22883-1-jeshuas@nvidia.com>
In-Reply-To: <20231027223309.22883-1-jeshuas@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5058:EE_
x-ms-office365-filtering-correlation-id: 0870c4e6-edb2-4c94-e21f-08dbd73dc12a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYMJKznCTB0Ig8l5oAeLx03YnzleVde8lgu01uzCti6ZloTueiI6nJI7gZkmrE+Bn9iUMRKy/DaFbgxAeHYdh8e5bnJtSLJ998P+W+agyo8Qq3a6wGdbmidRqc/iU8tLYmJ9A28FRfzMmbp9uoPrwnbtzEOumCfWgxogavtLb11nyvzsfdqqRlAprxrh9tVgwdkeSLe0jUOxFZFx++biySDWrWsFixZQIErC16WI4BAkNCl89Hn2SeqLheeDnGB1+DkplUB5aPYWttnY7bBqBA7A1NjCAIAKYdD6sw6FuLiRMjTb3D7D8RjseNp7aXsecsIuFEd7i4bqjiBEJfqQ1PpY2Wp1FT2bkaynvKsbrbDRUltszJ/kXdhfMZwLePK4fODs7yV6bFEi0/83XCQlhbt9OKffgwncnAEHqoTfR+in9ewqWYSPTHtwKjXiqego1ZyC4Ld02PFRBWJrh3mKtkAGhSQKzXLVaCJmEbpZ41eM2fp13mCG3pq0WgXdlFlH7ULXk9MmO3NY4K6hXpP6vdxjFTlEf2pcyEk9D6bI3veb/IQbXZ9a51tiZJqHnlKaD2ZZLtM7PrELMi+7TldA+TYxYjoW8PjVpDvAQfIdEnabVFVPIMuS+gCIaMOqqTsz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7416002)(2906002)(71200400001)(66556008)(478600001)(64756008)(66446008)(66946007)(66476007)(316002)(5660300002)(4326008)(110136005)(54906003)(76116006)(33656002)(8676002)(8936002)(86362001)(82960400001)(6506007)(52536014)(38100700002)(41300700001)(83380400001)(7696005)(4744005)(9686003)(26005)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJBJ+ThUMe724AvlQ5cCi4aAlxOMUxyhuhwqKxplos/m/ca+CuXHBfUX5o/L?=
 =?us-ascii?Q?IGA0N35Ya9mNDjMA/kKhMAENTU0+kUKFENkJqlh/nwTcbv0xP1sIcgC60sny?=
 =?us-ascii?Q?fyknW/QaUiRuwlsC01EcRVGtv1HIxKqrn1FSy92KIyjrNJCWIjlTTtRj0IX3?=
 =?us-ascii?Q?NGLKPxOFTjWCdEeiNPSXnsYjRbaiHbm/Vva2aUIZ6awleSdAORsKfChJqlBw?=
 =?us-ascii?Q?PzqXHVqSUcLPNFEXcg5Kve2geigFaJQVn+LGYmyB8/eL6EHn+XEHsc31X8nO?=
 =?us-ascii?Q?f0GzqFGTopjvJ/GgLmoDLBWfdsS3HoWSRpFB4R8qQf1XkxTWxxfgeKZvZM2O?=
 =?us-ascii?Q?ZfI06iwW8kwycfkXxv9Vmu26MjBX0TIGgD7yNjKoI9ntI+YYrInq6TKkct01?=
 =?us-ascii?Q?km5yiss+JpSjKMdNtkKjhSlot2vb1RwPGdAAnrkjwpLo6sfOVFmoSPSiIRsQ?=
 =?us-ascii?Q?KGKGz4Xi2d7qLDu1teWc1agQoDzx8ckIX5WTq5oi3kwb1YwoE2Cv6DoPOXzF?=
 =?us-ascii?Q?ASkNqo5eYz2/ihu2zFw9vC2aW84QyuisigJkMLpKRzyno49nVFTF6+8rn5Tc?=
 =?us-ascii?Q?2vy8CfbyrJ75dCiluyiOQ6DAm7Qqeaq5S/OC5cCpcq4VwkT2vu3TkfcgQYR9?=
 =?us-ascii?Q?VLLDPqOFy9ZuoBUIAW089g3QKwO/Dtefa/FhLiPjhipbxpseQFda+UOfimuV?=
 =?us-ascii?Q?uemr6U3fk970ZMemklcjkBG+/9KdDnAFFTC6liypELLE45J+CjTB88Uwxt+2?=
 =?us-ascii?Q?RZshUEM2fT2EblUdYTI4zrRh777JuaX+MkztyyvWpUXrgAixAlQzY6DkbBVG?=
 =?us-ascii?Q?euceIS4Somor2YiBpfMzJG1lnV0NfrryC9uCp7+uKNKV+kmCaRnTCUts8xI2?=
 =?us-ascii?Q?h0wPjKJ3WqT3h6XXvdT41BuMysDzNQ5MYjUexEnaOqV0bsVUegf+NpEcQ5Ut?=
 =?us-ascii?Q?46LCY+YOJCfTuDVKI1Wl5UO+00+8pCPsYNPJ1cxmD3251qlpXmoAWYMTUT0w?=
 =?us-ascii?Q?ajjrMAPq2EyphsC5zbYM+FgMTSCkToqUE9rgvIAI8NwfvLOCVwb7/ACoMn4x?=
 =?us-ascii?Q?p0MA+qyUpP/j2J7ue92CMTm7sVyjcQo7fDeh1gvG3JWPOIS189PSgZOVhOeE?=
 =?us-ascii?Q?OOVhbPsOQtN3ZMkw0FHqqhFFzRNTfQWARv+bIKdU9xjxwzmeeW4jlmPViYuw?=
 =?us-ascii?Q?OyMAgvcsPRHqPJLaxVAcbuT0zkvNQckL2fJgDz94JPz966MN4GMc84+MU8of?=
 =?us-ascii?Q?XkUL0ray4f9LwM3fLcOJsc7ekoi6kLBQA4hc2v+JDxjAg0XlObb38bXAYV8O?=
 =?us-ascii?Q?NS7HB9Bk9ix2r4kDb+QXRiClWUHJzJcTfrNUWS0mSCwzR5NhpPi8fTG9OlSS?=
 =?us-ascii?Q?RmFqNfsjgX7pj/g21AZ6e1w8M5TF2PP/+Q6LI5KM7Zx+RfCev4bkHDqB7I3n?=
 =?us-ascii?Q?8Fx+WrXw3NHRMmoZkCPtZG3GRxtdr39e/8XKZDfiAZxiHgRCPOaAfWV31oPD?=
 =?us-ascii?Q?RSHglddbGJSfrqtAKnMeski7EP3GwZrEHevVz/nyBIpD6Z5XHRjKF5IaBzKl?=
 =?us-ascii?Q?9mAphmP1lvp7RWF1BjmsoYoxh7rdziqzJG+uoHOm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0870c4e6-edb2-4c94-e21f-08dbd73dc12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 22:40:43.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7fXdpUeMCDg2/a1+O8BxEvpjzMOTOiLZHGEidB8MWAJOmk7iLiS+FE5BM9SZPlTP2c3NUHMqCG2aGsJcdKjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Slow devices such as flash may not meet the default 1ms timeout value,
> so use the ERST max execution time value as the timeout if it is larger
> and if the ERST has the "slow" attribute set.
>
> Example:
> A NOR flash spec lists "Page program time (256 bytes)" as 120us typical,
> and 1800us max. A 32KB error log would be (32K/256) =3D 128 nor-flash
> pages. Writing those 128 nor-flash pages would then take
> 120us * 128 =3D 15ms typical, or 1800us * 128 =3D 230.4ms max.
>
> Without this change, when pstore calls APEI's ERST code to write a 32KB
> error log to the NOR flash in the example, the code will flag a timeout
> after 1ms and return an error to pstore. With this change, unless the
> max time value from the ERST table is exceeded, the code will not flag a
> timeout and will return success to pstore after the operation completes.
>
> Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>
