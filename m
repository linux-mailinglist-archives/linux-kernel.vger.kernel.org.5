Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC007BA195
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjJEOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjJEOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501BE4E378;
        Thu,  5 Oct 2023 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514665; x=1728050665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0wlBqfh0ll3MJuN7MJkH3y/Kbi6BnRrZxju1zMLZ+4A=;
  b=dJwdvtAFt8IRj3u95ei2coSxxqjvDfm2rN8tuqSCqeL8Hjxu2WPXmtjN
   UeQAIviU9o1h783T72H7olzLdBJQjzKS06uo66ZUZjr6EfrVrgR3SMypt
   9M/0Oja3cEmKrW5O5x4z7C2rdusvvLhDSYVJ7vo+kQB+qa/zPatxS6cov
   /M5kPDS1N6+1ayAEJBFq3VA7HkSc7mFrk82/TSazWcbkZo2sFlDIllTgv
   Iwu4exrMmB1X/EHMrIhEjLSSe1jQWY2GkNBl2Z3r2CjmQ61gie6yv6ZZS
   BlKbx3mSBTvicYSvSC/ooK62SJyqifRzuO5RSd4wGtPhfafp3Sz+QNCt8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="5002097"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="5002097"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:08:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="728350747"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="728350747"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 01:08:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:08:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 01:08:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 01:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeT4+vrB0K2P0v9aAZbzqnJlERKZdxKb0/JD0ew/Ae55VWIf+iiH5Xdr+L7YpSo8KJZq63akLYOyjJWKA3Zxs4YLS6FhUiqs4Y8omTdOCbupXpjLjWSsJViB68L+pSdyqbiyuJqPjvPCINVgdOgYh2dppkZ6wxN7t0JTxGu5/947Mu444xwo88/SkAZBJ17T13UCo7wJy+Xs7+EAR9DDhNnZcnbzO6bbY4nDP7S82zu4+3A8MnwmNMBH00N1CaFZq2hbQuUxHGMNQBm+QAYiqAEEgavBoAtEhAy8p0TjXqEpPuXb73797YSJ413ZSUA6y08h70CSeQ/YlGKXXlEASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8f+CUbuucyJqij+6ckus1yS857/h8PY+GgwGZ3odSY=;
 b=Gt62e87QsZ9kO2Kh8Gj1E4FV0E8spmfK/iqxV7ZkrQGLef82Ab8JdH2Bipfz3rsEcMotRLoTL56b4mqBBbJyuqxBwVVjhfhm1R++ypXHFAHeIExXzJo2rykgE7ggfZ5A1hUPK9QuREmbOtssPE3dBw7ALdEQSUZYjassJDCSaPZ5DtQtMMz0uU0BUDzS/SZ5J1bHSAlW2jxfGsFXvTP+S73Uan6ta9nl6tuu2HyVhn37KNLQwjMB+lg8ooFU6nAbKNbJunCF8ntSjCcydFmOkEGrvbucqV8c6PLfYBUm6mGOnq0kPmcrXNCPckOfoFFBWhSG9Gj2/nSNFM37p2nkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by DM4PR11MB5245.namprd11.prod.outlook.com (2603:10b6:5:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 08:08:44 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.024; Thu, 5 Oct 2023
 08:08:44 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "edumazet@google.com" <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v2 1/9] i40e: Remove back
 pointer from i40e_hw structure
Thread-Topic: [Intel-wired-lan] [PATCH net-next v2 1/9] i40e: Remove back
 pointer from i40e_hw structure
Thread-Index: AQHZ8R09GzRilhHMvE2Ip7M2zU7ZbbA645VQ
Date:   Thu, 5 Oct 2023 08:08:42 +0000
Message-ID: <BL0PR11MB31221A9137A235D973E0DD53BDCAA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20230927083135.3237206-1-ivecera@redhat.com>
 <20230927083135.3237206-2-ivecera@redhat.com>
In-Reply-To: <20230927083135.3237206-2-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|DM4PR11MB5245:EE_
x-ms-office365-filtering-correlation-id: 783428b4-7c47-468b-b5e8-08dbc57a4a51
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /G9pZNHJKnemg9Byge1s2cv32gix9IwO7gC1p3DH/DXiQA2pRbtlER3wNeB3rjYxyTr5bJN8V+rNE8HE0nzlXM70QOJZAPpzcvG8xytkNbzgWXXEJ7gnb1HWxTGwj5w2/4qXy5PU1KQ/5VnPg9E9b7y9ZAHxeonO9alflg14QaSYbB1os7aG1o2LBEQwakBt+cVriC+/jv7u1hIo/8P+d9m9zAn73j+seJoXPA8FouHXtWXwY+61vKgu9sP6jondAt0YlojhuXhE5OjZUfcRgN06qgp2Cdk0lW+xilSIwPO8m0aBYmfZaUHUOgcUndItik8cfd7Ti8xzKzeRupYDfMZqWlO+/paO1Z0yhI44b1l+6rXDNOjEuoJ5W4bMDgnfPEiiC6nQ4M78GG3ipPyO2XobbbXOZY0Q1VmRyzi34ZNdXyyamJ7bFN8iU5szNakGawTb6+G90MBhoD1ckerQFAIH/FDOUfmWy9+bIrv0zKNYCryYosr3yJfMMaf9rV+7crJS7o3xbyFWsm1HmRNiL2YmTZFOpf+8h/zu3ccIeYfU5HA9IN0hUIVeaCt045LgDyQyKqD3K+eWcrObr1Yd2oJrJZPzJAwCxqGPJCXMasKyTg+T+SGi7KX/oOGLPbW9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(53546011)(66446008)(64756008)(54906003)(66556008)(66476007)(66946007)(316002)(41300700001)(76116006)(9686003)(33656002)(26005)(71200400001)(7696005)(6506007)(478600001)(38100700002)(38070700005)(122000001)(82960400001)(86362001)(83380400001)(110136005)(55016003)(2906002)(8936002)(4326008)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IXbQbN8b223eSzgbSn2jaiM7PRBMxlTCjQJbyTU4N39+6lPMuMu2gPgAxdlS?=
 =?us-ascii?Q?WywSTahPw7nOnTu0gpesE2fZ/xYDtU8vFRGOGk9C5bVn2NPbanqpwYf5eC2O?=
 =?us-ascii?Q?U5CRlnmfiC8VCmK1z2vEugxF+htjymGbmb69RWU9nEnAFdKmCnkDN+/jJj8Y?=
 =?us-ascii?Q?aZvCfo1G11uo8cZIhppGoGObwRsaVt3zZDzJBz82T8lO9rTDZMSfImmSD2/6?=
 =?us-ascii?Q?5u/BrMkE2f7alUPceKcqZHKGK/lJIfLBvnJPFX8ZkcKdRlNu+YoSMCY9yNKM?=
 =?us-ascii?Q?KEUeb1sLX4SNLpZorx7GlaiirtysMfwKrV7U2DZ1bQiPIVwp6NRxvgfStHAL?=
 =?us-ascii?Q?GPiZ/g+iMDtl8M7TbG4vt7nwfOPup8MYVdTny42Ibve9NgNXtKNcplM45NfO?=
 =?us-ascii?Q?kr3VWFh0i4KE3m+c2AT7L45ffKHcKAgrB6Ca6XnxAdVNFxZYcloekFhywPa1?=
 =?us-ascii?Q?kVpIyI8WHrNvehEkz9jLesi93itkum9CbHp3QfKZDE6wGlwXW9HhFMOnRgVV?=
 =?us-ascii?Q?fMoutCpSZjQiCqdmYm8GmOySmQNv12xcn+u9lQc1xBKRqLGpD0bB7C7Slf1M?=
 =?us-ascii?Q?KJBawslRKURAS4dPbfd/L2O3VpbMieXSf7grmCkrngLfMqQsH9YW8zPAlk2P?=
 =?us-ascii?Q?YY2O5GDNy7rqq4jPVbnFkDIF59dm2Wsa2EGca4Q5EsB45o3X6Ip7utICdMLf?=
 =?us-ascii?Q?mnMzpZB768Mvw95yMec4xpzFtESjoy61scI92avDSBWdMblJrKLhwopNMVfy?=
 =?us-ascii?Q?Grya/MzckmUjnl8/o7fbP7s4fTwZyrkN90rz4SYbCEBbwCxKRs1AjP+tkiyL?=
 =?us-ascii?Q?wq1f4PC9dFjtGHid316Zj+rhTL3LaBWon74OsNBFtSzYrIgFODG48KFOwD6d?=
 =?us-ascii?Q?RWu3tizZKsgNNizZZwOzYGp/Uaj4deiEstQ1d5cn/T2kq4JNw/dgEvV5BVpX?=
 =?us-ascii?Q?WYPgkJh4whkt/1K51rB0KaaH9pil6JpgLRgZ1OdYap0vG+n97yKrrvsXzfge?=
 =?us-ascii?Q?l9hfQi5suUmMgjG7p4wTtKy6suHdlqsgQOXVHE9kHLVQMMYNJvVM6Xi2fHtt?=
 =?us-ascii?Q?rRdjHzYUVxwebm2UAI3sKpGwnvhiDO09lgfCbLtBsLkGvnas9UpN07b2ps18?=
 =?us-ascii?Q?DGHstt3BPut5LPZJaT6WR0nAPEU0c8T4I6+d0r83nbbvNAx97GeouEz09pam?=
 =?us-ascii?Q?39NAA8PGvqyu3zexaNdlFK/ZTJDIwxqp+GxzjlCnKV6kDvxKPVyxEgHbCUA1?=
 =?us-ascii?Q?IVfoKj72caSKTnoXQ0oSKjLfypen58VbEFXOcB5/FtiKpXhWKDXPf/LTqfPW?=
 =?us-ascii?Q?r7jcXk7qCgsrsdTWH4Bn1jpW2qF+SW0DbzKgc3086zGTh2eDQVJuQaNBrvpS?=
 =?us-ascii?Q?aDdF6MFc21qEw/IzlCj1eWqfG5cn+0SKRsyMJteaw+1vXOch41JrmLoNqaAv?=
 =?us-ascii?Q?ravZpUykpDyvHS6ObWwfgI4Di1nEfZYNFDIyxqQCciEM+bxpkelUDzwc/YFz?=
 =?us-ascii?Q?QTRBtmuGAD2dt1z/b5uw1mJljI5EJYl24tRLgF3YQjLM+uTa7F+aS7klK9NC?=
 =?us-ascii?Q?+mW2Wf0L/XxdJIekH4YN4QgNpFsy6WAfqgJSkJChlJ43sDFWMdzuvBGZzbDZ?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783428b4-7c47-468b-b5e8-08dbc57a4a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:08:42.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHzeorDDpYWBahUpBqQMWwCCwW9fD/3TTnbAs97AnxA/+icbThdrNyVdWql5bDOwcpyIv8K9014pRCs7cWljfb+LVN+m2z/adTk0hEC6cmSKxRRico/Xu6XKemwbgCVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5245
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, September 27, 2023 2:01 PM
> To: netdev@vger.kernel.org
> Cc: edumazet@google.com; intel-wired-lan@lists.osuosl.org; Brandeburg, Je=
sse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitsze=
l@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/9] i40e: Remove back poin=
ter from i40e_hw structure
>
> The .back field placed in i40e_hw is used to get pointer to i40e_pf
> instance but it is not necessary as the i40e_hw is a part of i40e_pf
> and containerof macro can be used to obtain the pointer to i40e_pf.
> Remove .back field from i40e_hw structure, introduce i40e_hw_to_pf()
> and i40e_hw_to_dev() helpers and use them.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h       | 11 ++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c  | 22 ++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h |  8 +++----
>  drivers/net/ethernet/intel/i40e/i40e_type.h  |  1 -
>  4 files changed, 31 insertions(+), 11 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

