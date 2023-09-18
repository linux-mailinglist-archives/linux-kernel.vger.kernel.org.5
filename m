Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F257A4EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIRQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjIRQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0244930EB;
        Mon, 18 Sep 2023 09:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695054537; x=1726590537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3/lLxYwoAicSBbLD/2nG33rTRBl3WGI936BWwQz0ck=;
  b=VwVnbsAruPd4hZzWA4ztasZD951dmLp0eR5JtkVc4ipfE552ZX93GcJO
   CXXdK62WEn0HFQqu6l6f6Nj7lDEBQ0//bsAFz6TAk4g7BUrDQhWHbu5Bm
   jH+fKviyPYREX9iIp6HDz+wfjIztmtLxtXw/VeY9b3WHoRj3hT3F9Q5+/
   f+yodmFlEezrX9/ZotRgLEimoquZuHDy9I2npoMhARLZg4/f3SSMH3lut
   Z3FgIBV5Uj4Jde19HfGm7o4BMz+HR/FeA1/CPZoRBF9KKTbISbB8oJ9OV
   Wl6zYQuGH6uEAjaMuD3R12nTHlzuV1iZa4Gv05E/2Yy3eyNXUMHT/fje8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="466049800"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="466049800"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992786671"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="992786671"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:09:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:09:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:09:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:09:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZxT/WgnFSKrW4lcyKIwliiuiDr6sCsfdPzg5mtKu/x8MEAp+taq42KuJAiVbqj7ddmwpWK+Wk8I/hNgy2Ex+r8szqKvca6feavvauTb7CJvWBPH0ihqy3nbxxSO76s6NOVfuahWKg1NxOQHMnK6P0xEgnN55M4iVnPIu81iWqm/teyxw4yAHU2MuBiLe4GnfR03ZXf2PPbFFjE70v9Fn9ltMeOWxsKBP6JxmHxPJ1BbYoP78feJHTBUHrcvtbEIixhF1NbLDsVQJwMXGUsWze8qjI/j5rgGbU+o9cSF2sxWv3Ggn8/TlXtpKqdHz/sfiJHvdkeAbp4LVAIJXRwTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3/lLxYwoAicSBbLD/2nG33rTRBl3WGI936BWwQz0ck=;
 b=ekAR5P/BzcNzNZiPzX1Y3EF5602YNs0V3/fIk1gVu/uZ9ZsM5jt/RSpf/f01qqOciBsENHlfNE19bcQz2DN6wgjmaME2SiiSuippIlQjE5l6HH93yUA1w6bXPaQZkYGW0I4iKtSWwJTCo+R+6rkARt2oSef25ENtpLd6PToMcTTWXTgR6F0u74ErLTDJXHQllidQBwUYt7gkppoPy4qNlwrCkLjGgQpKnX0MzCVOoGSqTlU2tVwSe9GACg/aP6oBcsMOAbkVOiGHYuPCB/ejJW6HclUXVzvPwAAI+nIQvpuMszZjyx60ZAz3Irs7qb4ONFam3lMOiQwD73UE/s3lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 16:09:06 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 16:09:06 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
Subject: RE: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Thread-Topic: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Thread-Index: AQHZ5nFu/bHCYcc4VU+8hY4jAeuNNLAcG4EAgAAJkACABCgaAIAAbJrQgAAH0ACAAASWAA==
Date:   Mon, 18 Sep 2023 16:09:06 +0000
Message-ID: <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
 <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
 <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
 <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com>
In-Reply-To: <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6779:EE_
x-ms-office365-filtering-correlation-id: 4e840e0d-aa7e-4715-1be1-08dbb861958f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZdQDnVR4k5b0hIbbqU2GjfK2c2cQZt9jjyblkuXY6u8dc3cEVmUjJhQadcsDwZSCOcbg47CQuSpA//tuSEYw9nrOVGeV87xcXWYNhNdvs/50+FZliFhHw5IBMXFv8zguY9+RLrr2pfG2xjATcg2HTT6VBtSpjWQC8dwNS/c8GbrUvQbENUmoE3+T9i6eN1P4uS4z4grO1ioqcDbGsjD/UAs2Xphn1bdokkD0z9Y2tJpemP1giM/DtUjMAcAEhcwyj9QACPZnTeF/tacJjRibP6LW57Vqd1bubwuXDzZlsnEVKYWYu+KBvtCY2G/GilXssNBukdM1h6FxvRqnctMzTJI6Pv5IpZtn1GMubt1ZAxa1cOGZsnaqUJ8i1rDVIp8+1Wt5gRoz6OgrgFVW2UW4qjDIfxhjjF4FLNPQ/A1LdwyV2KhfqKfZvOEqx+c9Zh2EBfIOnWxmc1y4I39h09gH0cs5hiOt2EKy9g+0zxWIWuNOiY4vUZ36GnVTCMC3VYpO/Dtf1ODMNUzhpWvHZQO+Kze4GlhOPtKXE+LASUX0+FEKgsjspPzqwwfQNj+l3LhvxjiIJsv7gmdHoeTCBcIVA5dmi/XHc65Tfgw7wQdOcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(26005)(52536014)(82960400001)(8936002)(8676002)(4326008)(122000001)(7416002)(33656002)(2906002)(4744005)(55016003)(5660300002)(86362001)(7696005)(6506007)(966005)(478600001)(71200400001)(6916009)(316002)(54906003)(9686003)(76116006)(66946007)(66446008)(64756008)(38100700002)(38070700005)(66476007)(41300700001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mrEqAHUZrOuxCb2dADTV2JR5z5GhHuqm7RK5eaA5d5/l5ypalWlSXpNGRw?=
 =?iso-8859-1?Q?X6sJkDgtqnlucAZm1GuNH4Yi/dB0J7fSLkSZyTsM6ffVp5pDHdkYfB/IeC?=
 =?iso-8859-1?Q?w1+TNPD0vQxwPIKYek6O8VFwtZEWeY71iaiL3GPrX/9Fryw90hgPpaulEx?=
 =?iso-8859-1?Q?2pi9ccuCD1lqk3qHkEMezJoDKNZ4nKl5FqBpxdi3s+ujbjK1+CqpFFRnES?=
 =?iso-8859-1?Q?jm3zpCwrRuLNLBDWjrTRc6LKiP1oP6Kk08/odp+DpluIpwQmuWh+OsI4UK?=
 =?iso-8859-1?Q?0J5Bnnlxz1PX8aDozQTWv5uNTTBB05YJKQSwLWPFV5sc5lzZSTx0B87Rq8?=
 =?iso-8859-1?Q?VwjRTOrhP0lfrjmoXkhhQB0klwEetad6LpmjHzS1tDbuy2QAFs5yPUIQUB?=
 =?iso-8859-1?Q?kLfuUbyB9erFg3voy4QiZ857at37ugdf80SFCZvQqgWBsCG9MAmKyLBnFL?=
 =?iso-8859-1?Q?XmnlEX1GazqN4ebraNPzVHa7GEN78wy4uumx6xzyhVkWcqVp+rV84HUTqA?=
 =?iso-8859-1?Q?0mmXHAIgQjz2a8ydkJ8rwgN0TtsO8ASht888jy8pC2K+BnarThef9dXe3K?=
 =?iso-8859-1?Q?XU0L0hq1XVw3jQsr3c3N5tJj3pWJYe4c0OjXvczgpqHAeafSIuopXGIGw4?=
 =?iso-8859-1?Q?Owh4DwWlwTS85DY1i4tGADmCUgekomvZZlYnn2xsNgEL/gV+Hgnvr3Yvvn?=
 =?iso-8859-1?Q?6+XxH1bzto2Dh74pK9akE0g02JVypw0xgsH6Y5H0JfU6/Ms7c7tJ9FINWP?=
 =?iso-8859-1?Q?soBjTVl7Klp50G9A+RHzbz0Bx4UCDuZ+iiX0Cp0Z1vmE66F2Q4P5TLgiXF?=
 =?iso-8859-1?Q?DG0p8ATqqpSylsT+ETvcbX1X15nDGeig5nqd5n8DeFNbFUM+4xvJPRXe9e?=
 =?iso-8859-1?Q?+QvUXp1V15yhafSySCtT88sVa+fwk7K0Hap78weef57gdTfzdbWrDhX/9F?=
 =?iso-8859-1?Q?sJTTy4g/e4g/NJW6GYwTqYkjgZc/nk1izju43sKEEzj7rwpo1DaQnMCMUZ?=
 =?iso-8859-1?Q?wkgc/rwmFcc0M3S4FbqNeudgtYrHkjet5ALbGdTF+ilRPu/cTd1qmp6Ta6?=
 =?iso-8859-1?Q?X3Mv+g1uOevetLUFvB+kbo19MtEQ3g54ZHeJyLwyKVNUEeVR1NhzfhP91G?=
 =?iso-8859-1?Q?sL9bLS2WGnWDTbDsJ3u/Z1b6ymXRlaIAJlur9wFZzWiDgn52wjDij4PeKg?=
 =?iso-8859-1?Q?owFtYEir0vaBXgGPbRwL8uI3nwsEFPgWtxYPB0wn585YTQQaweZf5sHCdt?=
 =?iso-8859-1?Q?U+l7yZlmMAxK+4fRH4FOmLkKJQQI2BFqMvwGV5b056wAW6x1HZgxmb0H0J?=
 =?iso-8859-1?Q?d/CZZkizNZLJoDMM91yrUA9vcmilGQ2vthyyO1W24udDOc8Td1q+NRdh0M?=
 =?iso-8859-1?Q?WtCtSyNyfEGiwCiWgZJXfLD9LM0sJtnfBAE2S+9Ko4i1ruO/dyAxEPbBgz?=
 =?iso-8859-1?Q?8OOKn0n+2D6TEBKzDszYRPmI5IFG/un/0BF5VYmoigb07azHOQaVI6fDMr?=
 =?iso-8859-1?Q?Sc9MStk6irWztjLV3/qIzRWg/eugsK/rX8CtU1Blkheq81wxt0f4YsyP9V?=
 =?iso-8859-1?Q?YDBFGfaLR/w6wgsFjZFpzEPTfwh3D5MrcEnKtARsiky8B0w0lFRMNBcrwW?=
 =?iso-8859-1?Q?PIqvVrqlqRsd3aVLrJT1FUuWJBZUy65018?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e840e0d-aa7e-4715-1be1-08dbb861958f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 16:09:06.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcSottwczjoxN2u+VKo7g56a9OUe6GYTRcDYdOcBO89gjGtTYrUEtRpwfCY5CyjGskH74/UXN0s2OsvENU1tdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
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

> Since you replied, would you happen to have a pointer something that tell=
s=20
> (in writing) how the bitfields in C are allocated in case of x86_64? I=20
> spent a bit of time trying to find something but came up nothing.

Search engines don't seem to be as good as they used to be (or I'm not as
good at finding the right query).=20

There's a bit on page 14 of:

https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf

that says bit fields are allocated right to left (which is a good
start). But I thought there was a doc somewhere that gave
more detail about alignment of bitfields.

-Tony
