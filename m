Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A17B5AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbjJBTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbjJBTDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:03:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4913B8;
        Mon,  2 Oct 2023 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696273413; x=1727809413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xY4UZ9z8FRYHPgixMshdAfpdxltjUzQBo5VJtQ/GXU8=;
  b=jmtU1NLMY7Ihl92QoC2CYe814ZwXGBWOIJtOwiUgW7j9jaFI+sus7Xeh
   LNHWEJYPeVeznBkjTkrJKmXeMU+/ycxFahUrJhFYgWDLuYVoERhengsx5
   g92MNxofUy8tCdcwj/97wmBMSSU4Nn+TSkkohFynDZu84WQ3dlOMWZ/e6
   FEnIUpiRTdiMCCMwJxVD6ZQ6XvGQCIMrzksvBlw9l2GwL2uJjgYt0M0xC
   w8vFYQUZcxtxcPMsag3Xn8Q3/0bs3gAlQxv9dzu8EZA0EUIQUHNymA6ss
   8ES++toR/IiftSW/lrR4m2nuO2rR+JOw1ROMsjDwUcl5RdMKJEgLexQ2y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1287189"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1287189"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 10:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874435271"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874435271"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 10:57:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 10:57:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 10:57:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 10:57:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 10:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTM8GEetFY14e0kcrzOU59BqKoK/cyumLeeS9yYXqkh436dCaMws810YJOYARGVgfZyF3ZkyCp/jti1LLMXOk/vqO1IHBZx3yZz7c2kUUyMSmg4el+3NmQ/1NQRaQk8xlTg8JDMK3gJYzs6IGbWN2ialj4fVglf58p/X0LkyzQBiDyiIPsHV63T7chYip6K4CsHO7EslKTbKF/853/CgIY5+Sy9GSGyNqM71aJlWbHUTDTd1lX/zFzFID+RD+SRlzdl6FuZnBO7BSddSdnpMwwel1C4Bm673V0bB/uPcEII0Yo5InMnNI3NfPwGBzmwAcbTxASCDIGDkvHmVRUM53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY4UZ9z8FRYHPgixMshdAfpdxltjUzQBo5VJtQ/GXU8=;
 b=ccKxsuUFq7M/YKvW9eyeyrCkeHsyHMAjmPFPwHXzLPOdos3uP6pZ6El5E7OROGf+zF6dEr+j4fmpPLmaiFoV1nhEsIlo3T/Njvf6+py3Y5NEBYTS8O8jz7K+8EOKEb+mNUncauL3SWcN3+u9yYukAuPm7nPY7UOLjG9sBHeVCLFrZELmQsOm9uJKd54IiCVJ+Ff6JPbm/k/N9Da6rEApt1g9XpaJ/LVpLFxFQIZcj8Cg3J0g/hHwdogjS7oC0TPD6gdoFcSrpeE3vSVj4gjvdVl0y0H91WyMAxyJRq4sZL8VgGmPjQ48ajONvckeqDbsRlmMbsFX5GoGcx5hR/Z1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6512.namprd11.prod.outlook.com (2603:10b6:930:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 17:57:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 17:57:35 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v8 0/3] Handle corrected machine check interrupt storms
Thread-Topic: [PATCH v8 0/3] Handle corrected machine check interrupt storms
Thread-Index: AQHZ8wEYb+mKCqp50kGumaGvWObFUrA2yrPQ
Date:   Mon, 2 Oct 2023 17:57:35 +0000
Message-ID: <SJ1PR11MB6083447BB15B0D0535D77C68FCC5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230718210813.291190-1-tony.luck@intel.com>
 <20230929181626.210782-1-tony.luck@intel.com>
In-Reply-To: <20230929181626.210782-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6512:EE_
x-ms-office365-filtering-correlation-id: d7d3eea8-83e4-4f93-8df9-08dbc3710f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsKQhsKNBnuuvXn2clxeLroameDnZCae4L1iVaYuwV3EqGQc2O/U5MDEfFfoQPDAa5iHPUYHljdOO/2wdxrQ97cb8+GoGq8zmxvQzWlddDRgjsV4vDss1C5Mzz2ECfuwbeaj0/xENLvZFzg6X3LUgvR9ObB59gKTlsdsC+VyBBveZT3QiJSgoFR5bBQbUSSLxkDLQjw+JGyqdw8qoPTWn5ImKTHgk0AxPy5lSLqRbI4aPoFdqPOGNSJ6JexiFOdO9bM9/VpQPPNh+8nmvg9P4la3AFs4c1WTxsHeDug1sBGaKSVnA3RnMoiNvLNskNOIukNRbnah/QZo2hLDVW+qN8HOAn0ydaI32hi3jS3q8faOXCE7Bqrzpf+WJHrJPpHzT09L3P/OD+M/x3X1uih2rHdB8KLbeVrfTOYQozmLpF9R2OEbhoeMuDDAFZTjx77bORfnUQE1AWeE7LuQBaFAcLpGwVXRQQYFVciqrDr7JlinxO5RtGu43AKTPr3vl+IvZAEWwcSPI9ZOpcd2mikSnW0POm2pvHm8op1N2tnEdqGlUwmT0zz7WNpgNbb4QvSJhsO2b2KQ+8nvTtlL13cp0ozbdosbOUHAeg4yJdZovOe6qvFUDWtAoZ5JKP/MM/Xz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(7696005)(478600001)(6506007)(33656002)(26005)(9686003)(41300700001)(4744005)(2906002)(5660300002)(66556008)(64756008)(66446008)(66476007)(316002)(66946007)(54906003)(4326008)(76116006)(8676002)(52536014)(8936002)(6916009)(86362001)(38070700005)(38100700002)(122000001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q9YtRUb+jDqof5O6VY4aC6gIuy9jwU7j7cOXcFMQ4pd9FpLZHE5RIRaIWGAb?=
 =?us-ascii?Q?OriinfJkUi72M9FFqjl+yMUnLcR482Hva8o7Jdgy5U/dZdPlAh8K6hCMyBqi?=
 =?us-ascii?Q?WiIbw93P1Y/eVNRZ4lx384aLgH6kjZZc0FQ0E2etGZgwkMm6p/FhpsoXbMx3?=
 =?us-ascii?Q?dcisZcTkR9cQ26o1Y4zZU/nX6WsLzGJWcbJZIFCYjt68v04ZS/p6YM6v1/Nu?=
 =?us-ascii?Q?Tw8caQ/NqWuSbRnFIhuzKgqUDONGlCim6SiG4j+Ixt/Qyjxd0NIy+Ldq1J3b?=
 =?us-ascii?Q?olHqScRmuDFb8r1Dtk2o5Hqik6pI1qe/8ZgdgZ50Sl/P7k4I/UVXmD5uW8U8?=
 =?us-ascii?Q?Y75NNiNdkxavODgtG0oDuRChOp1FGuOyUVoeIdtqKMXzIw8wbLiJELu4l57X?=
 =?us-ascii?Q?0TZ+VR6c5kqeno9tYzoAkq/fLN79LxTJyCd7E6zEhVFzMggqzzdMTqr5ZVQ+?=
 =?us-ascii?Q?15LhxSoV9WLpY0UuO+QEFR0oq3sKupDnBkAkzZyrkDl7BGJcsUmK4/+WRrJP?=
 =?us-ascii?Q?exVzxn+Xx9dwAacgXkUyxxMFdWHfdjAZPuezljgY3WeY+/rBOhVs1UxbQUdM?=
 =?us-ascii?Q?66UNYAJGTcz6axDDX4wo8NBY24BYRa0v/0KbW1f+lLpQolT5Rf1fhoqMwIBA?=
 =?us-ascii?Q?Zs3hm/hsnWM/A6aVZjlFrYjR+ecsba/5g2TC+vqlDKlUNXYx/lBaTGAjJo/h?=
 =?us-ascii?Q?PXvJnQAR3InwopTjxdteO7QTADfaLwg9e7+wKIM1AHoyVrL+6AYtP9RRt4Ub?=
 =?us-ascii?Q?SG/6qKmZPCHE2NmbmalcLXzI0oasJUDtE3jZQflpaX6jMcz7l5k+I91UnD8f?=
 =?us-ascii?Q?ARXR+yNW++Q8lVg5XVfGNiXxyyRAziiH5S2Xl9nxJg1r3GgM/27q/qI6m6PW?=
 =?us-ascii?Q?2geW8O8/4uCbaJeM/ej7KLs/P6Gi9pPsThyIhbaJ5oN9mkGx0c9QzxZOJQ19?=
 =?us-ascii?Q?xEfE0XTmb8u4eP0p3n2BZwu5pFzLwqx34fU3XJtmmYjaE7Lo8HxeFzvmGdEn?=
 =?us-ascii?Q?d6YGVIs5uS2LamOLHLpmc17qHGBTF6BrciNobMNggulgZjlDWO6ntUwTVZ+5?=
 =?us-ascii?Q?Exeb7hDzArCIHHj5g6nnaMTzqpVtB7PHCZG2Cnp2mxx4VfeHHcGInLHp4T9i?=
 =?us-ascii?Q?6DifXQ1C7cQaCu5AjaG8kM8EcXgkDjx+Cir+pZpDk3fDw9jV6enuj1mGZ7ww?=
 =?us-ascii?Q?3z0V3XZ5LyezjngmjDaYGZX3/o5ZIWeXIsdUdktCv24mwu5SiI+ocOfhZGVX?=
 =?us-ascii?Q?rNvfdqkRVFfrice6WpAeE+fArsFtZmV6rCsqGJWUWFZ8ZMxjdKx4iTacou6F?=
 =?us-ascii?Q?i6VD6Q5z1KNIULZftmHbuVgiKJ5Dz/lNGbMGMtUIAvMQffGqJvzLHBvtTzyJ?=
 =?us-ascii?Q?FYdYrlvrcxaSvEJ6snKej1PuJHc3T0XMxPyTzWKx7nFjUAYH4aF4qx+zjTgA?=
 =?us-ascii?Q?u2q6WwW3j1Zpuql5D322r1MXdVrYP9movEnQ2tO73Bj0+cVf5BCFRS0IehZN?=
 =?us-ascii?Q?t11nqCwjI+OY2tp4mV+pZaZTMQMck+PLdhlREf4uhCPCSM4Xe/YwR7pYgijm?=
 =?us-ascii?Q?w5k3NE2DIpcPmWLQJN0CazoyIN7XjvSmjXW4DZtL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3eea8-83e4-4f93-8df9-08dbc3710f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 17:57:35.3642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1Hzxp2I8ZmjJJghQyF+5j1LN7HhiXWGEc+v8egecJI93U3hnbfjxCFiw1GITmqje1VPazXJ6Wu8cZfrn/kIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
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

> Including placing most of the storm tracking code into threshold.c
> instead of bloating core.c.

The lkp test robot complains on a randconfig build with:

# CONFIG_X86_MCE_INTEL is not set
# CONFIG_X86_MCE_AMD is not set

about some undefined symbols.=20

>> core.c:(.text+0x1130): undefined reference to `storm_desc'
>> core.c:(.text+0x1634): undefined reference to `mce_track_storm'

Simple fix would be to move definition of storm_desc into core.c
and provide a stub:

static inline void mce_track_storm(struct mce *mce) { }

for the case where neither INTEL nor AMD is configured.

in internal.h

-Tony



