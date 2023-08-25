Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5F787FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjHYGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHYGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:35:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E4C1BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692945337; x=1724481337;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mgO37/tmAbIJIXQe3VbsOsxj0xzfwG2dqTgjmeXSZgk=;
  b=Z7YBDGjOlxuTgpZzIMAW7ZOyydr1TEZd2iCK6x2BjwsSM/AqwFXieXpb
   QSkkoi9l00Uu+5OrUEWsFcB7cxGm6288uBfNWt9FtR8FclThTalZAb+J2
   +LR55VQdMVPh1hcJ3fo/EXSEMxn6Gkkv6j32ZCVwspajp3t34aemF6hRQ
   O2pRqBHiLQiYKZKw/IdB2aWAk1EzePcyEe2/6eEGnW7M0hRlvQG3j+gw2
   SPSCSAT8CSmAxP8sDXvANE7TdcNIjvXv3mHkwwIwDspr39Sxev2Jk7nB+
   +mcJ8ieelCyoeF5lO0KQhucbgmcdyr/1OAEYXqmBK2mzLWyn+/RVVXZQX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440990249"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440990249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="740498166"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740498166"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2023 23:34:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:34:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:34:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:34:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:34:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYsuGtg809fSpHVhgV4L9BnGkbbh+bW1e2wwPjKC3mbbuuZO6oR9Y7xxj46JhH71E2uOwsNEG+deZsJ7H4rU2QWiHQt8jNwX/kooFaobr5OXx0VzHbi21LjTwVvK4VBfgesSWDCXjbOi05DgXwWRu2UHFczm0mWIfV2zYvrrcJW6BAaX9aCYjReReL37LtgbbmtgI4MRs3oeS6+l3HIE9qCU3lIu58pI/R2Z6MKHNd4P8syD17GLd7Jat4PauS+x6X0InNPXM8dIObIxEoWg0shGAyWCKRQ+ksocA8iMdoKj2jIi1jYuTs6xuoEBv2Gn5Kd6iZNmDTfRSkbmcGI+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuxE7/GVQfE/JxFDTHSLmRsgRzC97kjJFNcIVluN/9g=;
 b=HSEdwa8wmBRfjdaB5ujw7rHi1/0ECRqepuOd0qwQ78avHheqlJBN0Wb3bvb6wBPTegyw2N+4q03aGVnn5zZcQT83g+lgT4oEcw5TlbogakYXuq0aSZl6liFqZUk+t6vccjwc0Hf1kl5RtFgXdnL4SpKX7qhdXCPxdeODSoB76a+sn4Hro90tWC/0jGjRa4rxJK1UWAwovFWEZaF9SD/WktiDxz9ny8LELXzKvsKpGf3pvx63lArBJ8IByF1vXyxnSnFK6FXOLlnDCBNGyrzCZgQ+39sW9vrAKxBmCvVRIipIYYgDQF1pNI7V5ZAOWEJntev4LjuKJsb8dtmB3exKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Fri, 25 Aug
 2023 06:34:41 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:34:41 +0000
Date:   Fri, 25 Aug 2023 08:34:35 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest prints
Message-ID: <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com>
 <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::6) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bf6ace-a451-4528-e22d-08dba5355ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lwF/4YZjqG03d3cDHYX1M6htIcRcbbu1P3GDDxWqOZ//KEjcpqRHyIDIJ/4nEIuWXbv9At7dqoID5s8JwFwIYYRZQnb5WHxgs/WlrhpsjzmjV8w0+W9W5uF3g6wialmA0I73eWm3SwFkquy6J9O5ekB11xbUGl6p2VASeqynkj+qMnSH1gMK+C+zamx6yrV760FIMhlFTcNyjacJspHxZ5xh9HMUaOGFmbg4aFbbJtxbk1P45L6STi/JxQpKvHveXSBdC3wjFhqqts5jtW6+vXb9fEy4EWHpl8zyIiGeNbzKNYvjd8zd2+6BUcdFEHGM+VsHAlI/9psWgw18bYpZ4wff4JeDT3QZJ4cHQCO8/93ucVABEpgNiQu2j0RJoPilEWGvh1T/y/sFcImd65YJFxL0wkA0hFgATh4wxeoI5LYajAX7TnBN/occHcLh7UEzqFpYkomUEUU2QPsr0/4xtNP9+MA5ZjfVJHEdL0qRYOdLjD/IFMPFWqoHjp/PgGFE1hE67vTG2GjLUlcjhgLNT8CFnp0HCzBJKx4JTsda+/mMxpA1Kg3RmWDRoLlYmCc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(8936002)(6486002)(6666004)(6506007)(9686003)(6512007)(53546011)(478600001)(2906002)(26005)(66476007)(54906003)(316002)(33716001)(6916009)(5660300002)(66556008)(66946007)(4326008)(8676002)(41300700001)(66574015)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CojnU9UpjZ4UaFOS4L+/ta904QP+AtqpvKEOnLxxE2/9aA7doFnpJcdGrb?=
 =?iso-8859-1?Q?kKTlbQTJyEg9UE0QtNED6p5ykYi7yGIdLe6gRi2oI4ME+OGWkyG6a3Tg9+?=
 =?iso-8859-1?Q?0YsMsKHC8fENF6VzCjJnB+PEen2Bkxu5PdRqiOaviFVH8i93zTey6et7Vw?=
 =?iso-8859-1?Q?QW5gd3hvqeRbPHJ9VUZmD9w36DPFb1s+yYW3LBh9GgRYVdMcQKXJkp7Gp8?=
 =?iso-8859-1?Q?CzHbrRpLvheHn3Q5O9Q7iSSCgcmvq/1oCXOatOJWfmx7YD3Usuw1870Ikq?=
 =?iso-8859-1?Q?DKCN2CvDykWskUZoKu2hoy9I9TO8l6kHfRDMLt3FzCG6ajpzIorcTfN/dP?=
 =?iso-8859-1?Q?/QzEdPIkh2bBwQ5NicerVygQRnCxyWdoyex8gMpTygNFiBq7NTwEiwjuEa?=
 =?iso-8859-1?Q?xaiITtOH2OqChWHUbY6y9Y2ojp6JWqKofCgCHVurT4AilIBKpEIxtJvn8r?=
 =?iso-8859-1?Q?+yv6ro/Q9WmUgLiG8eK1z8PwSLBcl+agEWezXj9tr+LkwW9BIFpxLOTP8r?=
 =?iso-8859-1?Q?dZKJ6TDk+ts40h4yAvbN4Yz45Ady6Ddv9+SZKca24tmbwVhWck/6l8lMnr?=
 =?iso-8859-1?Q?FvWVITxzQU9kqM0EprpcIgxiecVFq+7MbQFdo53Tp7t+mho6NpJFElVlY1?=
 =?iso-8859-1?Q?2pGqGuXRpOhguCiJudP8lQ9TSBA3bAzkQYOy3psKWFMXQiAeYtRV4gSRob?=
 =?iso-8859-1?Q?FNsN8AkCc/Sky3fdsjVzOfjJ3+ORauTJ9QvSm9E+CmpnWPLyE3+iWTUbTL?=
 =?iso-8859-1?Q?q3+FR2t69lx/INhE2RIDNtS4RsFBS4i+vkAS3eHPj1hrTRGjEzVNWqkDA5?=
 =?iso-8859-1?Q?saALVRMz1O/Lqaje1+GUgc/R7aUFwU5/RTdFNUBjZwEzBRRpfqr2SLfgGX?=
 =?iso-8859-1?Q?AxMbRRa8advIbvS5L0B7ridrjQdJR5zNcs/tKLdAx3lvrxVMqoQqm4CEcc?=
 =?iso-8859-1?Q?KYlGYZIAygfndVWTGhWNCymjHuzUt49zX7TLij98at8YverutETuKVgD5U?=
 =?iso-8859-1?Q?+uWLlgNxs/LsEKmoCMlbdJ9XFWaFfzejShPMXrgszgsaihZK6BYs+GPWUi?=
 =?iso-8859-1?Q?BiCuS+YrauSK6cXL2U4HxBfjSPB6RRi4abS2FyeXfKfFOP4bbW553kVJP2?=
 =?iso-8859-1?Q?djGFxsYx+34x1y/nQ1uU+i5fFSGiPX1NZUmeSfiLnHIJnGOr8PC/2P9f9E?=
 =?iso-8859-1?Q?3YGP41soccEJrv/LrxVZxKuZp9+9Z9aMDoNCg20g5Nrt0pv70Lc7nq16We?=
 =?iso-8859-1?Q?BDHmdBn7yfr4PCJdTy4O5l24iwSU8GjkdET+DmFZDOI/m8gF3TaGKLTHXa?=
 =?iso-8859-1?Q?RtjvXkL6QPR9Yu/je8nkkWdhLP+mHAmZ38M+BCdGVMSwF2Cc8YQUvum/CF?=
 =?iso-8859-1?Q?mJB84XOwkSm1NNUrT04vsEaw/hKVQANfs5pgKZ+zEmBjnY2Zk6NUyKnchQ?=
 =?iso-8859-1?Q?7CrM0z0lB2lzxCbSRy5bP9VGbPQogeDVQLOv2CsePxhF43Nwa1X+zx7FC1?=
 =?iso-8859-1?Q?94qrWx8B0upDNy/LKSjiVFL3jNjMKK/4VyL3ewv7iBY7QuqiUsvRzuO77o?=
 =?iso-8859-1?Q?gZ2ZDpG7luMEsTo68GdfjcIzTFpLdsRbL+SwA7k2z3i81dLBiI7YC70MLt?=
 =?iso-8859-1?Q?aL1sQE3DWSsXHgeWNsy12i/tw5xv3HWXr+goR6zIvaFIqrEg6mnjXe2txn?=
 =?iso-8859-1?Q?czvEQk8k0jmasmpAU+Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bf6ace-a451-4528-e22d-08dba5355ca3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:34:41.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dxGA3w4hWn/yHA4pbc/BkwYW36qobv52lob7s5PY4o5vgLkSe6L7dFm535APdVHXPHsXHLICs4GPXi4dK/ObcQ9R2WbMFY7rdBqfhjF3gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
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

Hi,

On 2023-08-24 at 16:10:12 +0300, Ilpo Järvinen wrote:
>On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>
>> Kselftest header defines multiple variadic function that use printf
>> along with other logic
>> 
>> There is no format checking for the variadic functions that use
>> printing inside kselftest.h. Because of this the compiler won't
>> be able to catch instances of mismatched print formats and debugging
>> tests might be more difficult
>> 
>> Add the common __printf attribute macro to kselftest.h
>> 
>> Add __printf attribute to every function using formatted printing with
>> variadic arguments
>
>Please add . to terminate the sentences.

Thanks, I'll fix it in the next version

>The patch looks fine:
>Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>...However, there are formatting errors it found yet to fix.

I believe you mean cache.c#L297.

I think I saw you're preparing some patches that remove the line that
reports the formatting error so I chose to not correct here.

Please let me know if I still should change it or would that be
redundant.

-- 
Kind regards
Maciej Wieczór-Retman
