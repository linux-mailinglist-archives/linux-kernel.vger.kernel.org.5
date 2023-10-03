Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DC7B6E32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbjJCQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjJCQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:17:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2ABA6;
        Tue,  3 Oct 2023 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696349859; x=1727885859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7xm108nafTkYgXFy9kfXtDXVXBKd6lfRGEmAkA4gKfw=;
  b=dRI2itb3D8+wGA+If3BC2BebNeaUVc2ZW10wq1/GsFYjKKj1HQrRYikB
   RQCWZZHD/HGazFw91Zj2vWwUUi4R1Rd4pUu9n/mvhnTlcvlziu2GwVmtL
   uj79AOGg31gb9+r8VhFD05iI51Bw27435MxTgWzi4DvhoVg56XZjljfVq
   NYYFcCNkfqaEtM4iWzYjEDgWG+z2IhbsUlJ2551shT38RgK4HsHZK81WC
   14K4Ed0bmjk8wIqJ9XdWqPCB4RjRvrEtW2QiLF4i6ZS0QjgWz1AbMghlh
   o4r0VBTZc2gwM6Uzm5YhNf0ODdiGbsde9ucCni0iFuC3trp/zwOW23jdp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="367973292"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="367973292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727664780"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="727664780"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 09:16:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 09:16:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 09:16:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 09:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmYPpDkY7NGIOgnegjWEV2OkyfFfHIZWTwheqvBCRUiy1rX9Ji1sIUVqpYOTqB71nWV/ugcBxAq2onKhS1y2SxWIx0SdkdhSTkCtfm6ZHuzOQWdq2axxaZTS7ZJQEKiGjCuSEADGFrkhm7eqFdTEeo+sLjVFXQzRRDUzJwpdtcvgGLeV16hy0rDI/Y9qtgAw03LPX9oxk6YswDjTn/cNDlCKwev4NGyWoPMgBpkOV59Rmthzlk8hqqnrf0H1qRi225LP42ygORJOL0sKAZZCg8Ff3ynRbm26yruuxOZrPMlSH4fQ9F9Tyh1yrqKsi1OK7Ha70yjobxuZ/lNbRkktIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xm108nafTkYgXFy9kfXtDXVXBKd6lfRGEmAkA4gKfw=;
 b=Xy4X1toaqRhIIBsrDqLxFJZsTsD4Y0gmuZUcLiyRoK0CR7TIYfZGF7nRtx2Crk4jwgRXXtBbZqfd1x18OaELyCUVnrcd0WjyTWjIkwscaKmdNgh9rBKMD9U8wsVY4KdCBVL4LK/de51lwFvDm7aGlI+NrTUecThCiK6gOe05+h15qADIg7mVhoTDIeT2YgCoeKKkB5wabkOiAiHOMDoJth7bLgb2PTNdD2xxGNASfM4Lcp9NJbxGpqfVHNPqGJSO3dcoRH4Z2ZQfCRfqsKe0PANMiQRvCS0jWVmFRRf/szMgfRBLYMXEn//GR8UmgaPb4QBqmJX+csfNA/uVLD+5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 16:16:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 16:16:09 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v7 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v7 0/8] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHZ9hPXprr0NDSkvUi/XWbinWWk4bA4PAyA
Date:   Tue, 3 Oct 2023 16:16:09 +0000
Message-ID: <SJ1PR11MB6083136387418886E2399B28FCC4A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003160800.8601-1-tony.luck@intel.com>
In-Reply-To: <20231003160800.8601-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 27a60a5d-baac-4766-c494-08dbc42c0e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvitFMvoohNWzQjXvlACbencBvC/L3Kqx8I43gylqGZWOrxFStT/JE3ow/YuiNfVyFD7FLNxXCqi+WFQDnfZssS9Iq4PYmBsGhpvxvyNZxjTlMG8lXYDOGFWLc/UZb07I9tLkjgIYeV4NOhXZHoShEGuBFpOvqIdYKGA5HK1XQ2kN3AZQsrRt7BSD0oDJaJ7oxCgvf2+PB5EN91Up9N4K9bE8Ol1YpmLuFWwgF0c6u0G5LwLaYShsHHWrg+OJ/dftGpcuzfwk4O+mo8hIqRgkwUHUm8v9DotpnRC/7QCn4KqO6UEcTJDLIAotSzHfbP1IBWowJegUOAjk6pzt5HsntmTYd/bqFsd8WFiCmb30/ACkOjCLj5ov2ZfpUbSGWd2Lhd/U9/vx0NoaCZxL6xqIgdbKbyOyUlHr8ENk7PzZY6jCD5hN9kf646o7yD3wpjDFkscukk68SvDAOY18r0McRJYQYveBIcHJVVZtgkVOCyBIARMsB2KmjzJ1/m+IK4X5rvNhlMuOXJ+cZ+d7t0tDRMFK+huQo+DxS5oHUldTyOYEd/lsw6INIpxK6mRVjWzfJ5PrzP2htSmjJReS0WR0gIci3JXfvbEzwrnEImH4rH4ryPtarCiSsflz7Gd70tt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(7696005)(6506007)(9686003)(33656002)(55016003)(122000001)(86362001)(38100700002)(38070700005)(82960400001)(26005)(7416002)(2906002)(71200400001)(478600001)(83380400001)(316002)(8676002)(8936002)(64756008)(66946007)(41300700001)(52536014)(4326008)(66556008)(66446008)(76116006)(5660300002)(66476007)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?smPB/gTpPMUYHkG14240DLkOdZGZCkSXfk5ieXvB8octWryoAIOuUAKOovqG?=
 =?us-ascii?Q?iBD5omuGsWxgUlRs0tK6OgBrjL16i8sSPHIZR/+1Sgsypw9mV6liPg/mcFn4?=
 =?us-ascii?Q?uEJ9Bm3Ge8GF8+N7n/H8xg4h2munmI0M5l4zh4qZFy2nLbjtDlIYms1eUDTG?=
 =?us-ascii?Q?sIlB3Sp1HGl3VUcdxWOm3Lj4x6w8CD1HyKaDpjDhXPl3Q40aEop9ZxfRtASK?=
 =?us-ascii?Q?9fQVzr+opysrFr4c8rzG+02YS4UEXQbfbmspuBg1mUujMjGkA+PhY7RmQXM+?=
 =?us-ascii?Q?Vd6c+eQABgkCyI1VGFILTJU+Vd8aCe6K38ZNp5QrY44IQmDvi4dTWoPVn52I?=
 =?us-ascii?Q?fuZ7biY8HTswIVqr920OQEVsZIsKnnBta8dpbce/V9v/iTwa/2v7bPxciHeY?=
 =?us-ascii?Q?rRa73zkjC6zThPAPMHqJkQt59jErDAEFmM4yBluqbprq8o/a/CzliJHiEVJU?=
 =?us-ascii?Q?Evmp5fljjL6cSisvkukp/ZcxnnUeP7Dx5EU7lK6OvykTmm13n0r3W09zMhgF?=
 =?us-ascii?Q?nnEOTYqx0yIiiikxxsyojQcTWVHTLSn1FsfWvV5MvflYnJZvfkG0F/6YNWUM?=
 =?us-ascii?Q?cZQpNj4EB9/GjDuoldy1wT0TD/Tit6AzWdRKcvIbl4c3OhhTtvkxEV8ICl4/?=
 =?us-ascii?Q?2SmTvU5+lpMg6iQjCafLfwKIuU+wKZUUbfvtaG8CTapG52A+l/rp9JYELFjn?=
 =?us-ascii?Q?3bAFlTgGZCDEU7oHxN9FCDrLLVWyGfn6xm6jflZonYKGIDq0xShoIwqw6CJV?=
 =?us-ascii?Q?DbUvym229dX1+1JzpS0i90VgsrEmML1vpuwBaxAIr3hAuJ6ZXe5oEPMR+o+l?=
 =?us-ascii?Q?6qi62n8G9HzqHwTf78yPNwz9s2ug5nj/YkIJz/aId+9U4SPGyc2j3mUciTGe?=
 =?us-ascii?Q?UwbpDHvymCgc8C2Z9UWYEU8pPbY7YAQp2AhYiohm0vDsDzTtjs2bgFuBhJUB?=
 =?us-ascii?Q?7T+OQLf+AZtupnOA6OsU7jOMDxFXt2jstuxlOoAczSQW1YPin6oY6rrL5pLP?=
 =?us-ascii?Q?1YWESSuWcRzhlrlfeCuu44JSa5rN4QA1wBw7YjYJ6VFGi7RgPRoJXHneWXGv?=
 =?us-ascii?Q?KqPrBawb5sJ06rPwQLMHFrNdPJC7qRTWC/28eZI6TOD/eCYnL5zK016jTv3w?=
 =?us-ascii?Q?w+BuXo3oupPJoSmetVADnxyOCiPQhKBp3fFoZM4ZL3ISUWAAuNdBwm82wbtP?=
 =?us-ascii?Q?+EF6E84bKKhD0gUuOeq9g6DErLL2qCH2tjSWbgwP8UZq8WsbciqG87jzO9jS?=
 =?us-ascii?Q?QKDeXzgPqj7weEJnVJhYa2ar0j9Sx34BPaj4EuUXm1S+T7WDxO0tP67bpn5T?=
 =?us-ascii?Q?TXUgjoFJWWGN5/0vieTT5lMRxt33eJCUH98gT5BZxo7shl2GAjWrX/5Rs/Bw?=
 =?us-ascii?Q?0LcuylGN1KQww+oiv5Qpq7/+s9r0iUaif1z8XPl5n1rurYCWQ9H2/F+wsowx?=
 =?us-ascii?Q?DuJF3iv/R/oldE3MLMdYjO+2uenpd94WmvTt9rk1iUSQ2mJ4oZRnX1P4sw4L?=
 =?us-ascii?Q?YFMJjD7WajukK6BxCV2S9JGr1nkU83iZynHcFqZobZeXQQ6H2TZ6hCmd7KXE?=
 =?us-ascii?Q?qjO6RmTaHSntyxiAzR95/kc9yht7f6zxcfZ2JRX5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a60a5d-baac-4766-c494-08dbc42c0e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 16:16:09.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqXKsJ8zbQtlC5xZfVksPr5O4cmYuUalvTYhGZ5qzSqKf+Y6g4s0pehb7bgEqUtz7GqwRfZV6uDID9k0le/LOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The Sub-NUMA cluster feature on some Intel processors partitions
> the CPUs that share an L3 cache into two or more sets. This plays
> havoc with the Resource Director Technology (RDT) monitoring features.
> Prior to this patch Intel has advised that SNC and RDT are incompatible.
>
> Some of these CPU support an MSR that can partition the RMID
> counters in the same way. This allows for monitoring features
> to be used (with the caveat that memory accesses between different
> SNC NUMA nodes may still not be counted accuratlely.
>
> Note that this patch series improves resctrl reporting considerably
> on systems with SNC enabled, but there will still be some anomalies
> for processes accessing memory from other sub-NUMA nodes.

Bother .. forgot to add the changes since last version summary
to the cover letter. I fixed all the issues called out by Peter Newman
in his review of v6 series. Specific details are included in each patch
(except for patch 0005 which is unchanged).

I added Peter's "Reviewed-by" to patches where he offered it AND
where I didn't make substantive changes (parts 4, 5, 6, 7)

-Tony
