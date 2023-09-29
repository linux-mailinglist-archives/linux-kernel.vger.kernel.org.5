Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED31D7B3A52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjI2TAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2TAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:00:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD4193;
        Fri, 29 Sep 2023 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696014000; x=1727550000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2WtDhCBadBqwFoq4j9aqohW+Y++3WRTyEbJwXuDuDnQ=;
  b=LWKh4OBhgqJn4U0AiPum5mCB1CnJid17qkDNHbscEA6SgmIf6OWSpl/I
   Bc8u8JOKzhsvP3Yqiq9MGn5ivNiyLr1sZP+UTjaeL7fQtqQe+FKIH1YqA
   Vz9h5r/h89JqUw2a+oCp3sVOFf5a1zfoHlp1eTVWWw070oqQQAom1NCn1
   sfxVBVjlV5U/vZigfrbhbHAmJFBznEjbxEn5MLwMF9dvKL3/d+NqsdbAL
   RS+pasYW43TvkEf1MGQfWqNfiMiqMJi5du+wqkY7/wlY2PD3T1BJJQtkC
   YdUQYSHX1LbEPBZhIJ2jthcI2Jo7CqtwJ4lVv0EoY12i54xFdNdhYK6Qh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385170846"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="385170846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893488501"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893488501"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:37:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:38:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:38:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:38:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjWONi6CNEPOkQPZO2knNFoNy8/wpsAGP2ooKpLZnY8BQO/xPxIyCIZsDrE0DN6p86qxjPY9oLJvMOwvBCnRGqN+QUCkJ4TY9ieLKyLr5OtdseGKHrBOTMKOv/x6WIo6VZ/lELUa8pHzCQkw4CXLFgKGvlHuvZ+lHgtjhCWwsXO7zE2hNZUWLx8b8FZbjA32ji5v2qKJ0rxmZSnx+CQLGlfutmFUFHuyYwnUSLTC2z7WlhrG24WTC4Q1wmsK/Q9rssJbLQhGVAdWvynz+E0vV4JzL9nGV/KePOEoJfbd9QKV2vWlFbgbmliu7TabFds5/BumSWWNQsj4PulWNpPP7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFKDlCJPlNGVxwKvLrLqsuW7wDnMDMbQ4pElzHmEn04=;
 b=WIzdK+/VXWUtZrPMmUdJ1Yw4sVuLiqXGib8WGDEeRMpmx72T3cWapbC4L3nk73shp6HWIxWrqim8u0ZmzKh8/jyr8xM/x6SROeQOjfrcilX57uWg+DgOjeSZTN33Em7LhpzQvq5wAcxT18q348KNV0VFwGcfOt2hiKDW+7y6kHNb+8QshaeUI8IkhuH3WULoyIHkwDpuIqg6Coftt+4Yji4r3mkvFx5F2NdVSgGc9/2y7K+8HXfKSWSfRZDe6DFpkGhepBlrWrsvxBbmc1S1Q5bxgRwxWI4kR7yPfWfQEDxfVdkSVNBEpT6zz4djEFjRBf+14vo81Ols3CjZDHcs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA1PR11MB7824.namprd11.prod.outlook.com (2603:10b6:208:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Fri, 29 Sep
 2023 17:38:11 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::4c02:d735:4942:ad0c%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 17:38:11 +0000
Date:   Fri, 29 Sep 2023 18:38:05 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Kees Cook <keescook@chromium.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Adam Guerin" <adam.guerin@intel.com>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat: Annotate struct adf_fw_counters with
 __counted_by
Message-ID: <ZRcLfYW0prCLXlJ4@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230922175432.work.709-kees@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230922175432.work.709-kees@kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB8PR06CA0020.eurprd06.prod.outlook.com
 (2603:10a6:10:100::33) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|IA1PR11MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: aa665a1c-4a0e-43fd-a841-08dbc112da17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSo//h/gjowzRGLleeOwsf3PK05vWEmKdMif+LdZZzlLUs8KQokK+7H57bAQOKzIK7rrhfLWAgkvbhcriD181UHmLjr5zlemiUBVgtUnLvWzAfw8TB3h7xgJz1R/1QWBA12CkXN/H9rujBNCNhYxAPNbndNnIArdJXy2OnNnpdZyFnItoAOtNxaih/T80aO+Aqdkj0niulFdHCWc2f2IBOP+uhZVxLbgHH3dIss2gr9gpNzxUhtZC1Wbb81z7p8WC3TdL0EMbwuClF2pWm1pX/Dv7xKtVOYygdvw302xf13lEqymfCszaDcjkcqPBeMBXip/NKFzEwRmknspUZOtJmSAM5pqftD4ajM2qzs1RqUiApOWAz8uukh8M6L55ea6UGUGq/7+Wd11Rwgk/oa9yz1yO+xGqsTMWw/up2ZAI4Tx895Bd3tT5azA2spHn+I2/W6dhi+dgK2QnB5bLhSXKIWqUoR8kjfG+5CuSC/TaYj6vILRTK8tgi8LPBzQe0FhXcR9UN1DFgh0R4uezkAhyzS9gJY6VBxqO5cptI+i860=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(86362001)(6916009)(66476007)(66556008)(66946007)(54906003)(2906002)(38100700002)(6666004)(966005)(478600001)(5660300002)(44832011)(316002)(41300700001)(4326008)(8676002)(8936002)(7416002)(26005)(83380400001)(36916002)(6506007)(6486002)(6512007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tEjEKMN3fQSuH04PGRxEjTdnC2liT109wPAnqqxJXKYRKJf3IDl2br6kBgIW?=
 =?us-ascii?Q?RxUNIvDGorA89ibzHDusutby65Dc4oWlBEHS02cosz2vHJBnCelawOXBprLD?=
 =?us-ascii?Q?HKUKANa3AbrgqpLdhpX73IXeZiJRW5HteLPZM58z65x+8QjsurnwzBoMbxrt?=
 =?us-ascii?Q?+eR1JDjur6Ou101twpHd6AR0Ve0/r5cNdr2UMrOhzEsgFNqEgC5wYis2bXz7?=
 =?us-ascii?Q?l+GRnww2IW9g5lxdLNSILcLSoZUJoHxuAbwLp0BPQjul6Dsvu11f1MPjER9Q?=
 =?us-ascii?Q?vOHjfaAjSuGFQ1YLJsBvoVo47lcT7pFlemo50IjkVE3diU/ghXBMxDH7BRL/?=
 =?us-ascii?Q?nLSOw/zelP3jV6fMkS0AQl1qPHNfkrRwq4qJuH+EfW8Hxnad25+Z75jpxxLq?=
 =?us-ascii?Q?ike5eIwpRA1x6j8WzVRFS6fWsbEowk/EGIugajyAKLwCtnDu+YdOiAUTIGij?=
 =?us-ascii?Q?8GF08aZ7SmpcXF2b34kSEnzrcfo4rMyXLvUBWXcwzYnlKYNV9xdveu4ITptS?=
 =?us-ascii?Q?8Fr17r6Vo5AvrgNXEOFPNsLamaiBBuUXfL2JohrNt4nK6QNI6PaFemBbpXo8?=
 =?us-ascii?Q?Al8H1d27DZ7/sQ4Zn2BLKn1xTu3tb5i4pg+PsKaHot2UU7Q7WAvz5g1eAn4M?=
 =?us-ascii?Q?kMxGPQ9ihK8M6T2q6mBRmLG8INgd0XVOcy+rfAA3wU7lZwlcgHNMrR4jCtFS?=
 =?us-ascii?Q?5/doPevLbvqzPgVkQUzI1Fn6TC4nlI355/T4d+xRPeA3oiv9cOHKLfQbUwAL?=
 =?us-ascii?Q?KYrXTj9m/T5WAUtTnEOvN1iLJFq6VmFeZDU/4uYVhpXf6Mo07tK/hBs40g70?=
 =?us-ascii?Q?71AJ/51vag+9D8QG+jEmqu6pyB1wSDkxfS6pi2wYtvro+y3CNeh6JkjluoDT?=
 =?us-ascii?Q?MBKnwHUmzHR9/hPDWJXpEUPRfoKB8LK3E/uAxwQO4ZXjuKkUoJ+p/pMDI2Ge?=
 =?us-ascii?Q?Tqfw+eqe0HN607aFyUmAJkmE0mKWUcy/z5ihsczHtdKlEV9YZoSnI1+9lkrn?=
 =?us-ascii?Q?SohsgDHZcQ6rG9R3vh2ww2wf855uIb6V4I2JwujGNfsOSB47MUkAkZ99HguS?=
 =?us-ascii?Q?lquyXztDWwyti+1pwv+udQT8XA2wV8x5doipVdzmH131VucYXp3TAIEctZhP?=
 =?us-ascii?Q?psgKDdM2TUTHmueW2Fy6u7Q9/k9IX859B5sC4GqxFKThRxTE9R39AhxQrGDn?=
 =?us-ascii?Q?899m8YWTMQc3qjAW9lYvP+M/WZB2vx3VacAxYvk++LNc0dcLmJdYdJqtFZMX?=
 =?us-ascii?Q?vrHO4dGIZEidh3GPCMQwOwvM3M8OU2lmyO/N/N9w+1J/bnJ1qg8648cV/ICl?=
 =?us-ascii?Q?eZfGJdW6qQwyYiAHbaHo8dvVwisLxodyhtKsZyNDC5RZT6LviyRosNgCApQg?=
 =?us-ascii?Q?5z0vBG9q//etOKslJFrTv8PGMvkSBwrW0y2IA+vjqRn/ABpUJ6EO2O9vgCUW?=
 =?us-ascii?Q?fqn3QTeShftV5J3CmyaDhz+9jBQHP4iIXC4CL9Z2k880FHFpiKSYc4Y6PTU/?=
 =?us-ascii?Q?8s8hBjdCOtBFBl86FYQjQpnIDa6S4VlT0zZoIFVn1oWIqfi2Rm93zQgPG2hs?=
 =?us-ascii?Q?P3sVSo9ps7sLDxaA6mmA1DcFvp8u1WjS/kyI64n79xqsZtCQQqrmxdzbpfcm?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa665a1c-4a0e-43fd-a841-08dbc112da17
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:38:11.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us9aKAuBbJRzXZdJJoaF1ufap40MZx8LU1HpkvKyyyzOKn6e+2MnU/pRRojsnkxilxJgLEAWuQCpt8lk/n9hhy7L/eXqkZ2ACZCmPampQwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7824
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

On Fri, Sep 22, 2023 at 10:54:33AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct adf_fw_counters.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: qat-linux@intel.com
> Cc: linux-crypto@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
