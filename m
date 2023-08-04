Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BC770614
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHDQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHDQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:31:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E749EB;
        Fri,  4 Aug 2023 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691166693; x=1722702693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qAbdPWSN5ulfwXaVLgGedzRAv1ZIxzO2AIBSByf8Cbg=;
  b=DIM3ecTpuLGCptRNq8V67lppBBQhBxLSlPytNNW8RBKQwoWGttFXax2+
   SVjRn6ana4gWZHvWMu8tswWivk3u2uVOzVHmT1QnwRE0ZWxI1HQg//BiK
   eZZ+poVLJn70J+N/B0eHYS6PBwf59bXTiRI9pPQeSbR08h0BupuhvjPOk
   X5oRmEGO4cbzJcXy2JS2WcJTr2OEK9B9v+77SKE2zyPMzeFy5IvkwbxDa
   YA6B7NhnOCYGZEr4aifsfuVg+wjddOjdbldHMIDMaj4/tRku9jP7U+AKG
   7EdWTXOFhR78zgWygbJPAjGnLcQFODlnPJPNGZfPe8T5FXxWUPq8ZSFzU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370178138"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="370178138"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820191307"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="820191307"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 09:31:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:31:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 09:31:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 09:31:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxY4fCRPZ/zxYmPE1SOuiqaWG6CJ8ST3ERHZ68VUrXDO7lfH5FP/nStmpfRifcbE2q00uwveID9ez2AR6ugNhXjIX0Pz5byIRkgLVnkoIlx4D3tgE1OLlE8L78qQf/Wzd5qDzXK8p2swEfWgejk4p0s1+s0uG4Y9jdbF9ysyA6KmGszO48BnYxxTYKlJdjKutdeYLj8K8kujLuK72y3yxPhMS8WjZW21Qw1yPayqNrZ7h2+mAerFnuz4TuJDGfz9+fl0iyQ5nMp112vkr0ZbsNl6s6UR9hSDCn9uqGNAdzKNPou1lHK/SyGBRsNZkCSeuf6a/qN0o1F/3NrxDRAkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAbdPWSN5ulfwXaVLgGedzRAv1ZIxzO2AIBSByf8Cbg=;
 b=j3iDC4UuC88NNPswcCzKUbn2/TG138sNxpxKj8J3gN5vMHLW7z2+yqJ813Ru153u9J4MlAKluenyNjFSDRFeOJQArH9oY7PMY8aShk8M8rShHWUedENvBKSQWsPw+VI+O1G4N7eiIljGvTOf/meQ+m5rZ+HKSxhhDiPdxJPzjfTOqoO8+EWiMYqYMYiXWgLXpzqrVBhsPUP1rjjkzbi1bvxItL6+465iDUudcJDFTBU94stP608c3ZegXga1Qbs68J+EfIVfXMRlOoVR1kQYOOs2uebERAYqWf0wwhY2wXyusoct/I67Cb634d+R7yYdrQNvXZAO1kZypkxMFVXErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 16:31:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::52e8:9695:e645:1092%5]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:31:21 +0000
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
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtRE2Xm9n1Bn/XUmXeolR1RgIVK/abfGAgAAJbnA=
Date:   Fri, 4 Aug 2023 16:31:21 +0000
Message-ID: <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5792:EE_
x-ms-office365-filtering-correlation-id: 40649024-d090-470c-ffe0-08db95083cf6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f0ZyFtiCiOQL+ngkeMeMKxHa6tBXBFR7WucaYnTiSeBICiH2O5vohuI3WuQmjrRO9rXeoJKBvooLj7Lj/k5Cyz6PVgwavZv1Wg6415L79WMatZ5IZgwN/2Gi0chW5mUOwoEyL7164uKnwwNImrSol63WbnKnZAmTMkMDA7K7sr7C5Wkz25fTm8IA6SfUea2a314c3kFgwOBlX+3t1c6hSktMyIC9B8YEveQoVPf+CWtPoKwnH1WXnOeOlb7BJT1SntccVgPuT5XbIErCxBrcafUZK2Ijd5d7r94m6DDMSl5f6kIIwbtcl8yGMQD2U5xsbDnShzza1LnxKoxIPXgY0OkYbD44NseqBJY56Ft9hEjgoGs2coPCInoOxGMYFlHqUosHnLD6R0I1HAodMc9BV57eQ63nO15t4erqNpYJ3I1NcYwMAaDsiQRHrxlUcTnjjvGzLCnlZs+K0HN3TYFipukQsVeDwd63Q+Xu20mTHO1D0Qba+PrvBSAUlhQ1fR+m5qAtlg7kzgzxiTjK9ZUbxj7gbksHkx6f+zKwQEGXYiyDpfHzOuw9wEOJpD+zacHwdzeuDeej67IygglwbYMXXSosaimaXB1C4M1q9JPxNJ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(1800799003)(451199021)(186006)(38070700005)(6506007)(122000001)(38100700002)(26005)(8676002)(110136005)(478600001)(8936002)(5660300002)(52536014)(33656002)(7416002)(54906003)(966005)(4326008)(66946007)(64756008)(66446008)(558084003)(66476007)(66556008)(76116006)(41300700001)(71200400001)(86362001)(9686003)(55016003)(316002)(7696005)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T8beLaHdJHMld0V0RyYk4fpvIQl/un92+4t1+0MqpuPXBnxlTSGo+78UbsbY?=
 =?us-ascii?Q?bxhMHOXWdh9FqMBmjGtXurNTt1hpbej8HYv0wpyW+8ACSSzqOE+4I0gVxrT6?=
 =?us-ascii?Q?kAHjTzbH5cw+uN7SrmyaotexY/oW+enhtzf8GO1l7MK6K+aK33zzha2JsOUl?=
 =?us-ascii?Q?PFdUAjeVvjgojBUbhY2VH2bOTK/PgxOrXxS2XTRSDdTBB73kmX64rQl+aQO9?=
 =?us-ascii?Q?y/1esxrUdAsa8KS3JKujNPd078eEXt5qFbgzxPHbKzqbgxGMape4YJ8pW2UL?=
 =?us-ascii?Q?+eFj2o3BKlq8hb589xY6I07bIpSH14aK3Jj+PTzEdcqJXV2+l2osTs0t3HHi?=
 =?us-ascii?Q?3UBZ+ip7tYAX3JxlAx4hfRJ3+U12YWrLMo/VZr8lUAIrLBEcyJW2mrP6PHl5?=
 =?us-ascii?Q?A6MFnGcTGu+08MFWimM6X7Ce7VlsbcYoVHPEimhlpiMrlzJIJgHagqHbM62Z?=
 =?us-ascii?Q?3yaPCbpYN27/3lxhguMPeP4J36YR+4k/ZyalPCUNSB2pp6vzQVb8BXsjqCZZ?=
 =?us-ascii?Q?4nvJdhD4sd7BWjjZImjkcngECAMl7ILa5SGjwsSdqGuWe7xTgxQWsWGaoi/F?=
 =?us-ascii?Q?Ux97Bv7SkhDfsXv01s3wHQTYBtn5Ymh7BAUrum21BP0FQ9xhiWWE+s4rJ9CA?=
 =?us-ascii?Q?NkAjb3mWR2NfNagdtKWRXq7B+eES50VCi6uNMixew7amaQo91pjUFQ08GkYq?=
 =?us-ascii?Q?RWKHexFap2WdO4obQk05oXYByqQ53NDJ6PsiSytc/6pZ91qhnnbppsI5+rdF?=
 =?us-ascii?Q?gTZGmlsxotSxs87PJZxjMe5YmjGeXsHRRCOzcEiwm36m2y6axPkZBwVs5Mkw?=
 =?us-ascii?Q?rctX9il4VP23x2tXj03oU4his1dWuf4wfeP8pk0QT0BAmd/nBBxIo27fggFP?=
 =?us-ascii?Q?b95h2w+uixA5WgT+eM73ktyr2ZyfZbKaC5J7ZTeJKCh4SUV6L3l01zKq9u9Y?=
 =?us-ascii?Q?7yK1a2cdR5vGfvXdgApdcppNl2dbO5qWeLC+j19uRkBT/oRZ6vX1kY7iJtRd?=
 =?us-ascii?Q?CzFqpDRD6R33JkjH6tXCBA0MO4Ve4rjXVd4mczZQOtPgPwPiigr4+IVqabIL?=
 =?us-ascii?Q?KOtK2LbqVCHZpYdMmTnlvFOFLwJmYHFM7+XkM01HxSIGLhxz1+sGnbThqzce?=
 =?us-ascii?Q?HkQkMB/eD5WbdO0i18MzHGBh7KTBSO3QB0luTA+sz0lkUT4YqZTsCsqzLkd4?=
 =?us-ascii?Q?aEO7rX5SaIYzu7eOyWwfdX3fkmZ346Psji9n1xvqajOBrOTonkOGT7o07lhp?=
 =?us-ascii?Q?N7myVYYA6Kr0qGmUkmszI1aSuWu4C2gqPE42c98QVxJ9fRDoczz0LtG8OJHH?=
 =?us-ascii?Q?TVJLjV0pglZ1jRLKC/aW1ik2124ZpERPzOK4JshcFvIHEv21n6vPL30RxrZe?=
 =?us-ascii?Q?stcuIzEBSlp8MQLiTt2rlBdmAyTRHHTCxY195714SbcuT5QgCrUSmFilm01d?=
 =?us-ascii?Q?h3hUeoHPbXK+43oWEPz55hpUxUsdanyf8w6YPfg9n6QxTPySbexA1GnO7aoI?=
 =?us-ascii?Q?hI3j8XxlqYm6ITWeiMwEPbOIvMuPHydAZbC2Kbha4G62S68dVydskHg8WcP1?=
 =?us-ascii?Q?qDAo8NrfQuN8pd2lLHw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40649024-d090-470c-ffe0-08db95083cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 16:31:21.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVxZCHuaJySXWy3NoohTfOwLmtbrl9TplfWXDd4m+bRD6iFsJ2lRBTSnYdfUWeFukhsEuetFO1Hwu3k5nA4ItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
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

> Can the maintainers please respond to my patch?

Can you give a reference to the ACPI spec where this timing information is =
documented? I'm looking at ACPI 6.5
and don't see anything about this.

https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-ser=
ialization

-Tony
