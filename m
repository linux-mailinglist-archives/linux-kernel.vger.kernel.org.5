Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71CB7E2E58
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjKFUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjKFUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:42:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E7D47;
        Mon,  6 Nov 2023 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699303355; x=1730839355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A/pnak+0fseSwcecMCudZ2lInNVvcE9UCCvhGeA5pw4=;
  b=VA4s5EGwsgRLazPDZdsxCuNsdIfuBM1RLtNd7bVxTrgkGQtAvWjlsP97
   MJ3+WBX1yEi7SPPF73bx4XjY60pI2DWd/J8QPoPMNnQKuOS4IXml26EGi
   tMQuhtd+eoBvPxacH7yD/IuUWqT/AHE6qixcbwuDUb7JBGvlGOSoTR2c+
   4RibufLAW6iJbX/iuFstHhVxLDL6fHSgMKizJuMJp8mKR/9gIedKZFrXP
   6UhWZENdCD+jWlMszsVqWC61D56PxCw11w9CH4f7vUOeP1//rpNueYM8D
   UGpx0/s7wPgujb7U4lMqZkRuxI4HQ9ykBm4ttKzLGCjsGl5pepxwXOv1I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393256884"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393256884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 12:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="853129223"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="853129223"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 12:42:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 12:42:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 12:42:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 12:42:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 12:42:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idb1suLSJD6RrwoSqNChhDKVAH0pC/Bhe+q1emQ8rUTxXE40rW8dbxa4SJAAQZ2uHjQTf8B27mI2aca8J4eObihIbS1ZdvKTIuKsqji8Ji94ND93+MNvgEoO9eC2NXcMWF23aRfJ694wa7wMzu+wTDjWShOgYANBcXqBzeJntPou2s/dkNp/2u52QATTVIXzNHtrbRyrJ0KuuiE5ihGkyq6ztKhsuUB81+LpxaqPiba5mRmqV10XZBR+CwD69qms/Zm1VwK5fh+fq0HkKFHa8+O+VHUxBxnlJj/rzBj/UT165V9seYF3AHss1A5Qfhwrs0sjVodqGFUQEvFz5k3//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/pnak+0fseSwcecMCudZ2lInNVvcE9UCCvhGeA5pw4=;
 b=end154gchUmPWygy5fhK+hugYODLqGVvEVUBlFL3id3yrmst7rB0QqTCqKGw0wrV3eaCqUspJQSnNJ0a9M08rtGSsUPdUzR3HNqzAyjoYhrg4IRGcbj4yeRBZGzp88A42OSWQE+jh8Wc8zR1rgGgbSNZ6LTxPOeZ3idajtkHLMkX+uJbseLlzsLqJ5cLKNIdwoEoH7/7NfWpV8L6ESKqZTHoO9PdKeQDXwVArNWDqFsmOm2BAHiKlyV7YuUcFkSpG19+9vgo5HuTshT+baX/sGcU7a7AuUKEe2yf3dBHpKGCuAnfqF/t0lXAdRIpxZJIwntIc4DimC1Dy7VrqZuooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 20:42:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 20:42:29 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Avadhut Naik <avadhut.naik@amd.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Thread-Topic: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Thread-Index: AQHaEO3NFJz87tXJiECUva1Bzfb8M7BtwNPA
Date:   Mon, 6 Nov 2023 20:42:29 +0000
Message-ID: <SJ1PR11MB6083962F7F6C4C535EE1CB94FCAAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
In-Reply-To: <20231106201340.434878-1-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6905:EE_
x-ms-office365-filtering-correlation-id: d1fba9a7-95e9-44a7-8cf0-08dbdf08e4e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6E9Wj+Wm9YHqbJYe7tDtg9cqjTquhK+it8AJYzNgFzSA6pde5WnVC8Rh+fC7jEFbiUerVxWSXI+IJKH/D9M1CM9Eav60wuqfSXk9Iewwf4lb4iTuL1yb0jHbn90NrIzvfUt7nxN+QYChhqb7bTy88/yb4JHTEuW1awUUq/kIpAbSQYulAHXv2epPZ6+GoEeaOJx8uoMx0Yn8ijYRhtbID5PebBRPCfyWz9qnWYrjYOc9ZgZ5CSMtn1+oW53lFKUMLAy3v/8xKtIAPHTEl7P64XuR2GIo5z5B4m4qmtJZB2FB7KV4pSfJhVdZNTqr11KP2836sAxDuh0m5vGxa49qzLKtiBZZ4ZN6o0grHMQB0Mtqm8DT0T9lgGGTczf+oGRO/GJIEPQ4axld8y1HQsL1lX05EXt9icnKU9hYxndXtiuRBLgFEieCb7iQtaRtMusfPWQZDZY5cJvFqDH5DYeG12JqRpI7d11uvcpZhSxt3iWmcRmW/RifQ4eC0H5yXtI38/k6Prp76sD0rJg9igW5Lk7H5zpADp9Ssm+d/Vkm3pwKb7AaALySx1bjxhtbb57SXALOo3wgHk5yJkMd4gZfDN1AfjSnzxQ6Rnfg943ddpkINnmpg35IxfLQMOb/a2I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(122000001)(83380400001)(55016003)(6506007)(7696005)(9686003)(82960400001)(26005)(478600001)(38100700002)(8936002)(76116006)(66476007)(8676002)(64756008)(66446008)(66946007)(316002)(54906003)(66556008)(110136005)(4326008)(5660300002)(86362001)(4744005)(2906002)(41300700001)(52536014)(38070700009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wunUYPoYKHq0P6KwLAO9mD5V2pm7ju2CGdAg7W4MfBaSky0Jtn/oj/mHI0u6?=
 =?us-ascii?Q?PWoPrpFvwfwCjG497gmXnkHzIUVQbQ2swnkVhVfUx4gwhFTY5zNBQej2Ku1/?=
 =?us-ascii?Q?6sakydYgeqZB28GKP/qqrt18fsCVB4Oy/hFj6J/vdacwoHew+q24K8zIdZHK?=
 =?us-ascii?Q?xlCesekdhPqJ/irii0TJ12UwbsbHnTnZT5To3ACrNK+jxbCaT1IrKfnHehI3?=
 =?us-ascii?Q?DtG5iRDGXkGv85Zi9ITgSTYYtbhUa/L8Ebs43usK9GIpESLJKJn1stCEssfw?=
 =?us-ascii?Q?3FRrRrjxqBf/kwu3IF4+mSiD+XSAC9PgENossWGq5e9CwALmZaB6wzamUoYB?=
 =?us-ascii?Q?aBizSNrR8MW4WkN0dYvkhtiR0msm5KwMDmv4eIoRrR9mcNqKw/JyLAvdVe38?=
 =?us-ascii?Q?N6YMxN/03wA2buWy5ZCbQW8RDHkTolyNVqEBohMk7chvjP5JxFiNeMrO7Un/?=
 =?us-ascii?Q?Uif/a1YqlqxDb9yS9Ph66S8rn7OY8WO+QIqUHbPRwgjo3tl3EhteP3iPSKQK?=
 =?us-ascii?Q?EMDQ0nbiP71VQGu2xGpQKJQK3DFycaML+QcGd5T4LliM59EfEKbudRkZlssD?=
 =?us-ascii?Q?jjNu9EUAjcdjnT31tzAVB/D6xfY1GwtNhhuhrWPkeCUG2HDUUqBkJ7G4lC63?=
 =?us-ascii?Q?6zz3m7K3KduJNRMZOnW20/3ALCImuslKT6SbEmwJ9TjfMEWVeII9XxtsrlCJ?=
 =?us-ascii?Q?4ptPh9tGgANEsirPzuIlyT5OoHbioF1MI18zgcqq0kiAMXoCG8BEHFJnXBD8?=
 =?us-ascii?Q?CpGV8+iV8AG3hnsRj3NadhObiP4Jwdo18y14ptDRdU+R2r8ZH71JO+YpaojW?=
 =?us-ascii?Q?1mdY4qLwv32u1FikEC3MMyZl5bgNs1iqdK+Cg415LDszFYAGwnIIAZKURkR9?=
 =?us-ascii?Q?qK7zj9wOLFn+kNS33s6aKwet5WRvSeH1/nqwgLG/5a0IrvgTnNGjE45V6O/v?=
 =?us-ascii?Q?u1LlEsziwpzFTWbWi3M1KkJB2l3pNyfrPC63JEaZ8pF6T8A5Zc7yZazbQoQA?=
 =?us-ascii?Q?luIQA8J7Nvk7HWeuZbezcw+ICLyWqGHWHozwf8GyH3Y1QOauTib267c3qTgA?=
 =?us-ascii?Q?WK/orIppK6u3yn7i/EpuQeSN8+7KPKz+fvg+gjI63HSxSiFaRUt96LzpWSu/?=
 =?us-ascii?Q?lpoaH+A3MY3qVQrf7CSsiJ+IUL8zCNUXD9sMl6vzp4439AFG+pJc26h3r0Bk?=
 =?us-ascii?Q?Fe7P+dNW5SvAmT8F0wXCXBcIiif9jO8u4OX4t03YAuvS/7AssLknWBdFI2HA?=
 =?us-ascii?Q?7bTRu313u/e0OUEzUvaJb71aZQe5Rd11U0fa6hdxAYCg6N00T8Jb4InC9OXH?=
 =?us-ascii?Q?oWmy4QMQOJT27jCgMluWttFM5YBwD8BfRzpOu3j2vz9lW9FISl1pbeNosQDQ?=
 =?us-ascii?Q?MzZ9o5YuOH2ldJ2jJbyUiGPMqfitWB8SaRU5go5oa6KfQCIDwI3pNsf38rXw?=
 =?us-ascii?Q?dljazryD/ar5J7cWRd0Kyg1QymMca58fl+fWbKJE4ZqqeVYliv9tC98FoND2?=
 =?us-ascii?Q?fD/1Xp0ZsS5+6l8qWkqH6EZNiucRoHjs9EYpQUoPsUtCHJULhsbUxpIpThbM?=
 =?us-ascii?Q?nWf+dktgKHkrdIRVQO3I3M4pXcT2AB2i84mfl/kH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fba9a7-95e9-44a7-8cf0-08dbdf08e4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2023 20:42:29.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuOz54kl71kPpBbSglTrsApvErZ5wC4AtS+pOBk7IeNoxm7Ady6lo9LN3qOGcW0W+o9UBcD4smZjm2YmeLZRjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
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

> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MC=
A
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".

What combination of CONFIG options and BIOS table support results in this?

I don't see much under "/sys/bus/platform/drivers/GHES" on my lab machine
(Dual socket * 36 cores * HT =3D 144 logical CPUs).

-Tony
