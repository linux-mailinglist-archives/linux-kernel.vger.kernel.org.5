Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5078A7B6EDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJCQqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJCQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:46:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C0F9E;
        Tue,  3 Oct 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696351566; x=1727887566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKGPI9NF4w/mctp7VW/uOMjUWUX3FBreCCvVYnS3hzQ=;
  b=XaVQij+HemBLExa1UhHf6benn6WIQZ7Rz1c9e5j4mgvNDDDQ+4wLV+8l
   F55Ni2vk2HaEwFgRjYgX4RFR0Nk5WwRIzg7YcTdK8y6u+refV53+cVZq2
   vxI0YsqcLILdCoGw8nIKRFfbK4Gpw/xg5urkNu9SSnM7XwlzfG2vp8aPv
   CXM+jhNjaeyWZoFRjIy/cwrm3KPFFdbh+LdF60c/YA5XvK423sK8e0KTq
   vT6UOi9L45zrP4NPNiuIzMW+q9ht1qXdOqcdUvLcx8yHf5gsqfZVhuT3R
   uXhyBLiub4ZxgVow1HqUWpzi49Bd8fM/hz9KkgMADKAIgyZfm8I5DoT6v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413834304"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="413834304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:46:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816754196"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="816754196"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 09:46:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 09:46:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 09:46:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 09:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8bZKtuzDSZNUiHev49BMlnN+PWcDHlhE51A80p4XlwGL/Z0Z59NbGr6ajGxcL/57WvRJR5kMxPVnZYmeo03LFsHfdKLdZF+rZOqfQBFccYVc7WoZmBiTINh4l+LCRJXvDW7kEvB6pIfW5ET7W3nm7sXSJsgbGsnNB+RWvvzfRr3meLPyWAD905PD8L1etCDyd/7kHdIIritMIH2k+wNmsZzVBDWh7jnrRaQu7upt7OIXv2ho2OlJ4zL27HXwiEFE24IjX0Aj7MmbxCL12h4Miqi0QDarudO4skXPa1npUO0fPbFnQrSojhPeITWWxTsc1NqesPe6uJNOb8moC/IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKGPI9NF4w/mctp7VW/uOMjUWUX3FBreCCvVYnS3hzQ=;
 b=DjQPHSz+bV2XgyMAt9x50r8zO+aIX7TyOA5mhuBaQCfYXsDa2PbZk4C7xpfO52oDbSdwD4WKd+sllrxfF+umCxXLUUzMKIq8h9nR6VWilqeWEmlZmWaxf6nSUwvVV3WB5nmsKDG6GMUkthW5D4s7eK29lE/fWM7iM7qRMFAbppa09/uv+DXIUEUxPSIeTEMZAvHG1Qr28wMqBpCNLOwboUsb8zEiAsBriVyonva2XiTMhEojqJZLVp5WmwkQwW+h5fqXRmLdVUjqEipqaVF+c6LP2ZBIE5I9YEfYbXlvidJHCJPSjEHAICzUnH4OtJ7H68fGycQ6Tz7zBqvsb9KmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Tue, 3 Oct
 2023 16:46:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 16:46:02 +0000
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
Subject: RE: [PATCH v7 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Thread-Topic: [PATCH v7 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Thread-Index: AQHZ9hPdcIVxIV7EeUqcVYW5WBeTj7A4RLrg
Date:   Tue, 3 Oct 2023 16:46:02 +0000
Message-ID: <SJ1PR11MB608321AB42C91914BDAA6EB6FCC4A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003160800.8601-1-tony.luck@intel.com>
 <20231003160800.8601-5-tony.luck@intel.com>
In-Reply-To: <20231003160800.8601-5-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW5PR11MB5932:EE_
x-ms-office365-filtering-correlation-id: b0ec66e5-3fd9-4abf-360a-08dbc4303ab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6BeHFS0ifO6rcM3xVWsYW0v5oHoX9Ndq1It0iXpG/YatxzK3PxGeVapcU500P5bvVgG4KfKgytDgnfADvy0qzheZ9wlrOxGZXaxbo/OEPwbDg4CuEg+4jLnWp5sPGP+UnxiGLPcc6fZukM+hsTbFUrVLf1FAPMCJc9NiiMsS6ilU56eSEJu57DkKVBX2bmxh+ergJdr3a+Q9KvtSm53XJ43kVPk36Xrb66w46UEFplFv9RlDjKhQR3tjfuttCXt/HHeF65Pqw3hZ0QJkDd8PJupj7R0y7j7Rm8ZcCRS88FRo9x33I1ioGHqAhOTAUoiKLdrTM2iOCqckhXutwiXjRd/UlWXyj36rMPvw7qZmhBCJBaku0+cPWVaJQakrKXffeUXlVvwVHZt72BIAQRSRElS4EkbbLUzr4kYex82jFYWKxvs6xpq/DI4V32z0cxAexsOlr/KqpLkXex4RK0X6t9nvQRqXC4BbljAD4AqO1MLxWA+QbN64HfXrYcLg+shpxIxL2GHnhMhSr8bTCrJ5/m2JYOANiS/I2To70dZBnFnhEFyDqYxCr3nbFaYJF+tk3GtNPk3OOTManBg1Z784+1pTcu0y5wQ11KY6fgOVs7yZaGEFi2i20R12/kGk8ct
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(7696005)(2906002)(9686003)(110136005)(52536014)(8676002)(4744005)(55016003)(4326008)(41300700001)(316002)(5660300002)(7416002)(8936002)(86362001)(71200400001)(33656002)(6506007)(66446008)(76116006)(38070700005)(38100700002)(64756008)(26005)(66476007)(66556008)(66946007)(122000001)(54906003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QH/wF0I290hiD7FSlWNHYm4KFpN6JaErAtHWhekUcO6C4TB7OtU2en7Jg4pb?=
 =?us-ascii?Q?FfSN4lGLgP1JV/K7NwJXomh77YEgRjxU9vIPlVNwrS8ZBI8wC0q9Pzx90aMK?=
 =?us-ascii?Q?njOHtkRXs4+Yw7kVRtmFK5Q6UJzTzwpNQGbMN+CalQTSnMAJXSbmTruycuYY?=
 =?us-ascii?Q?Z8QS/yNotUpmtURJm+FPo67/YzrgxP+9607gv1EG4APp9PvyHFxPGjJ5jYu9?=
 =?us-ascii?Q?F9B1ayP+LvlkQzvll6LWX1G7ID4qZOYPgwFtEzflRtKqfPkhBm1M9zkFP4qK?=
 =?us-ascii?Q?g0OC2RFmj283gtbss76s8B53IgjkbVsByYRa6rJ+liG87AUJfVWRY5yox5cl?=
 =?us-ascii?Q?2T7cFLWNg7K+LvZWVbibK+ng1ZA3KTd3b0B7ZvI4IOl7c7OiG/mhSRpaoSSQ?=
 =?us-ascii?Q?K90U2GdO7mFacdnLCoxAWI/6iZCwwU+0D/8F0z2GLxrGIlcDF6rjw1zk8Y9B?=
 =?us-ascii?Q?5wvsJvIlEyoIEjpq0UvngM1+4SGxtqejVh2h6tMI1ThbauD3VoF6YJ0B9ozc?=
 =?us-ascii?Q?SSv9qfkqh/W+FBzfba9x7IDGciW+aKKlQSxpjUI0Iw4ztaRssNoCVmg66FTE?=
 =?us-ascii?Q?0yAxBMF976S+ggOsqOGXtxAh8NUn50+REVp54rooAtnavgDhyQ6ac2UQZU49?=
 =?us-ascii?Q?Hk4tkn2XM9owzGov9vrnzT94ju1xU8zz929rlLmyVlKzSD45/S2Kfgvd7IBY?=
 =?us-ascii?Q?oeDNH90XpaGw33dc5qPW0jVTkNmExiJCh1GhZmAVqIEeqwuFHIojrB26NCyF?=
 =?us-ascii?Q?g7dZ5/A3lgaSrw79rrirsywKrRltY58V0gUygT00tYIJHMBedfXuRk95d2Zg?=
 =?us-ascii?Q?omWQGmGJx6prmkHpaBpOw2iICJgjyi/NzJ1Mim7pAc7Q5X6pRNHnOak6YYI/?=
 =?us-ascii?Q?cPeTiYz5rqHOCwaThZcHFDmC0ZwuloRNTY99PTCfhK9PlNg1C8+tkCXcPHl0?=
 =?us-ascii?Q?0PbDgxT60yqGc74/plzwfaqZm5NNZ3DkPD1cwaBTUEJHIZCFCfBy5ESd3aHT?=
 =?us-ascii?Q?cxP/Vkd15Cj4d6XuN1YcTbDPQgsRoF7sVxutX/7QOmONwyk4Tu76xajkqtHs?=
 =?us-ascii?Q?IFOPH3y19q044xnZ1sL7KJc//CU5yPo0fLWqzCHb/3keHO18k8eeO+LzLYRZ?=
 =?us-ascii?Q?PiP0ev2XD9U3rdciX3Gz41Gf7E8G+S5TESoIj5vgg6y6jTbdT6l7/gzfGOsy?=
 =?us-ascii?Q?F71XnJ4RqIhgJi/XXf+BHhxP8b0ZXvm36WDergZpCECAREnMvsfMLXxvbNJD?=
 =?us-ascii?Q?ButiRJYnq1l5+2eXvcrDz9K7UgbcmikCLrkwfwCq1Lyu7Pf9ze0FtQ68Tuse?=
 =?us-ascii?Q?s2C8KofSpi5IEZYQsys/jvoIcry3NY3+BaP7h4oXjHlOfQKumVQMWHESQW+w?=
 =?us-ascii?Q?1fXUEV3Jqv8FkWGzPPAhR5P/Uk22sVbaCt0ib07cNQD9X7u2rdfgxiUAYf7j?=
 =?us-ascii?Q?dU80ORAfr5EoG7JLtHOTvWuLFhrVpysuRP7jJg16jHvpe5FzguxnJ4x5OxgD?=
 =?us-ascii?Q?vqtltolftkWsuSZLI5C7wLKOqOoorkHQQ3ww2nRNp8HpNY+BhYXB8ZEoDDHn?=
 =?us-ascii?Q?ET6GzzH73DBPjYLgotIpX3v5FC1HREnL3rdRe/14?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ec66e5-3fd9-4abf-360a-08dbc4303ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 16:46:02.4947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbHXQhNttoiPxxzAmOmXVTlsHIIgjty3kw24tuxwhZFBaLPKTf/IPoHfXCIDZOzd11GumZHiF2O1OQEdrNDEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The same rdt_domain structure is used for both control and monitor
> functions. But this results in wasted memory as some of the fields are
> only used by control functions, while most are only used for monitor
> functions.
>
> Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
> just the fields required for control and monitoring respectively.
>
> Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
> and rdt_hw_mon_domain.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>

Bother^2 ... lkp complained it can't apply this series to any of the
usual upstream targets (linus, tip, linx-next). Digging into that it
seems that "git format-patch" may have generated something that
can't be applied using "git am".

Not sure if I've got something bad in my config, or my git tree.

Will keep digging.

-Tony
