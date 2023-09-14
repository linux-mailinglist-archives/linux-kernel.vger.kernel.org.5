Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205DB7A019D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjINKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjINKYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:24:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051C1BE9;
        Thu, 14 Sep 2023 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687057; x=1726223057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pLHiRf3b8WgOzUq3eNT+iwWbxP3axQIiH4Evfy/V41c=;
  b=bL7WQsHLWXTi0dnpruDQorVLx5i9quZLXq5Qrs0Bql2cTS44k8K/M34p
   ChDvlRUND0zC5TdwxVbW4W/QfCu/d7xq8bDwblbc7fGgp0rvK9AuEiDfg
   aI5bPdNKnLR4WErSvkWDpEq/ttXVqvVNP39mVXZ/H/0dbDetp5MCwY1a5
   wmq1tpH62jxbz3YmG0nA1wG+xEXCw72hfduLUNkZJwVMthwZZK3l1htbk
   STBmBZsYrghtdfxZW3bXlty35I1def3bZiz66SNH87F7q3VC3s2NrHVD2
   ZoxYB8+Bc8sHfQr/RUOAk6Ps1MkLLG0dCCN5WZcH0hpVcajnJ/m/hBAaE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363950048"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="363950048"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="773842141"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="773842141"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:24:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:24:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:24:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBLz2JOY3Mqr7ZZOImgfkAfl4LXaMrBYC/SSGJA2V4FhfIZZAVNRgsnvKPaXvGiyX6gdBiDMJ5TV/u9bvujXT/qJD40d7lWVueUcA31mYYchHHY8IRwn+lAngVxtKtOMQUY/GOpa4fDhO9snBBhVRLLtCY8Gqe+wSjLYrCn41MIG2Rge3TVNO9xg3sJx4R6V9iu0OAN2oQQspkKSkWRgzee+cjfjGMnRph7apmQhIKmDk5V3gejyoap2lLhHrMzkOtF0iO33AfIQ5UlY6olR39+zXaMgo6N1eeHnkmK6AP60QHL6qrzB3TZk9dH7uPVIxIuyeTOBWVSlDu1pZ3lT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFUzjWygi/Nbfw9QnNVuk0PK3yBIL5MmWjHfFBdwtgA=;
 b=bQOfNYf8GWmdKOmn1TpX09X4QEJTm3OWr33NXt6E9aIFkDXbrXIy5i1fJxvH7v55iVJhZOhd6GaHXyfVhk/BuL2a0UMS2WR4Uc5xSmeYiTEc829qEvU55sLFaoXCii37hJ9lut3Xs2x7h59/jzbI5+aIO4jGATHOpu05imWTZ2pc7xGXaUNxTHyKGDnIDI1fUugkv+smVxaFZz/f9GAaL3Kk1Uh50KgPr7A7Ceok95fUhqkBffgixqAhVL2/OrMme/Njg8JkHQzXB8ec3j0adjVEf6UMPz6PSXZ5oTXxNZGR0cuT0dK6DeQPexI4ym+RWS8VDhn0NUs951QpSagmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 10:24:12 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%6]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:24:12 +0000
Date:   Thu, 14 Sep 2023 11:24:05 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Justin Stitt <justinstitt@google.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, <qat-linux@intel.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - refactor deprecated strncpy
Message-ID: <ZQLfRbnGHXts515P@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230913-strncpy-drivers-crypto-intel-qat-qat_common-qat_uclo-c-v1-1-88a6c07fc924@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-crypto-intel-qat-qat_common-qat_uclo-c-v1-1-88a6c07fc924@google.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::26) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH8PR11MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 813a5538-5d51-456c-8afd-08dbb50cbd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYRakxzJuC73Bt/rhOOxX8nv6oREOUs2GvhScjvVaS6qg8OHwHCgMWy0aJaLHpggE1BSjQdWZ0VazDRH6CvlbiGi9HNGbOrZUJaHQ4JMB+liReb+WyH3Hx08UExxR5cbhWbWHvsIoJhX89hk4mFHwPuNgvMFuEz2LK1iLwjhZOB840T4MhVArb/VADY+q62cXeDGQL/M+F/8kVK4QalMTnGuZL+MKb43Q/UWOc9FB3l6Y3RrKvAK8Jt1SCN1Jbgm5I0sh6fQ6r1ZeRfPq/+i8ZTwByIect/oSJTIlYRklHqTVPN9SmYA84UwGK+mldeSKVKUoiyVuPs4CawC1FHu5/imzrNwQKkFO9Qmzccxgn7mETbhaHRPu4Jsy2gDQa2LicLl/+xmHstad/laGv+oNcvCsXcVQw0zfzaGm37CpgqSuk/z7fhfzJ/6rTuYZ5RMGjAg8ap/2MJmadGH9+XcU4/0c9bj0RTuDDR9WbfmTAwYPyuGOdTxaiL48BknB4vJt9ayOaNSTxY+2AGAXdZ+tOpxR9Ey2nWhEG/kqZdxyOeeb51ZwpTp6uNkgk5dO67iMTBUkTrGc4K5vrIPEEfKLvYEA/CF0+mQ6ToY0GR4Gl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(186009)(1800799009)(451199024)(66476007)(6486002)(41300700001)(36916002)(6506007)(6916009)(316002)(966005)(2906002)(4744005)(478600001)(86362001)(66556008)(38100700002)(66946007)(54906003)(6666004)(82960400001)(5660300002)(8936002)(4326008)(8676002)(26005)(44832011)(6512007)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lptgnVtQcj+HDdF3fr5yXWf9cd0o7KqmREUzddCYlNu2/j/respImJiRThD/?=
 =?us-ascii?Q?WMqJdn5hfCw5T6/jsOCllJ2zcDOau40GNcDtdSCBOGuReG3KApjcFiY+BTN3?=
 =?us-ascii?Q?1xCyuBpgbhAn3AopHI21dfH9rMubC/wFOSHZuVPnICVpwpneRn3MPwPgT5Yd?=
 =?us-ascii?Q?K0oKKZoqO7Tu6oYT6biBej16oUUxmVsjzJ/iNtKT/JVF8VIiHNEZc5IzvD6b?=
 =?us-ascii?Q?zo50P70HGKFNlCuIrXumeCyzCPkho2UAsicaX4j8ne85NlE8E8vfOa8j8OYg?=
 =?us-ascii?Q?A49Y+RhXvmwuDfv6ofAuoH0ED679dwHkMb1roGdnSxHxoQSr+nDp2dMk0rFl?=
 =?us-ascii?Q?peDRQFDzWS7+ZdvVVBU/A5GSGE9PrmHctK8FwjoDOeBGjVb4tK5YycWAoglw?=
 =?us-ascii?Q?AeEs2Z18NeTMZUSi9oZM9FMi65p3RFyoO4+9H+ywWxPxgeMbLFXeSsvT/ka/?=
 =?us-ascii?Q?6dknaSR+XKN/VYs/hku8b+VsTJxo8BCuGziYfIxgwlfIuEbviz2HB0TXbhc2?=
 =?us-ascii?Q?f3Z0AtpQ+0Wdb5jpHg/gTqABUhD6sb4aOPBFboIjaNClx3SaH0l+azvqf1tH?=
 =?us-ascii?Q?nnceVWRnPTxbOHep3WLYhyIepzUnJrkVrX7sVQcSgvpNyW3NPY1qqYOSKPdT?=
 =?us-ascii?Q?J+4EfYywLMvTVN2679/aEeuMUqiuTmLBHqk/TRVQn7JVB8GNA3OVvKjPjOBC?=
 =?us-ascii?Q?QNUEtGcHjSu/BaFSTbOivyPnCyHyjuRKBi+49zXHgkaWEggAc21zmYCq5aUJ?=
 =?us-ascii?Q?eJlhF+VaVhy9/npDojit5W7V6Mi1TEFY/370uvaRdHizCwF1fYz4xCOLl/PR?=
 =?us-ascii?Q?mR4wBk4tfUcmix+ts25f6qG4YsCln6WgVDvPQIllZdISRvsIGgw/1cdp0wNK?=
 =?us-ascii?Q?PlJPvdld75mzbCiWlyh4BGDx4j2BHELc864M+ZXF33cblp3/FqfyiB0IjYwG?=
 =?us-ascii?Q?M9FU1YnL2tksqPWh/9ACffduguau5QXgDSZpX/D1tR8yhlAoRVgaWEsEfRxH?=
 =?us-ascii?Q?TrXInDOa4pel7rp5U3xJF3L9KSZiw8TVzSvWZwYo5//inhN9JZj8FJYFl/2t?=
 =?us-ascii?Q?Bke+RTqRPz0ysdzfq+NrWWRo1lUmjO4F1eUEpunozjZmnLCHpgXI4KS2Qim2?=
 =?us-ascii?Q?wSDmL1gjELGUXuJowkchW18Ha1Rtwfo8nEjfWHRCoGRh/VdhrrjlKj9Hgg1C?=
 =?us-ascii?Q?YXqBneLmWZJ9XH6W5Q0CHpJgUmey8b8YYDuCyuuioYRTwSNcWPs9gHzqa34t?=
 =?us-ascii?Q?McvdadP9+SbCN2g3rRJxvujygiriGTY96sQxaPIRiAAJswh7n+QDEQgWSApN?=
 =?us-ascii?Q?38HdBH/FKRFxc6AaGV80Fb401eFEb0KgE0lM6NICxJj//6WSgaB4zeGqwcfD?=
 =?us-ascii?Q?sNdKxyvNx2xZYdAAcgvkrv0jFgyMk+QmkaBYrY+OMWTYP+NnrnlEQ+YMLwcR?=
 =?us-ascii?Q?ylrTik4srfYHdUPcXgpLxx2A03dx2MpzVMZ1j2NP9f18jqIaHWte+w6D9JTO?=
 =?us-ascii?Q?LIOI2cA8yYJ3pB1XmJeGtZWSMs4MV0z6YJOPH3+kuvAvppeVKf4/b5IiJYJp?=
 =?us-ascii?Q?Bq4qIl4yn2IoILJ2mar4vRwS6hmInGpQcpb5+LWckw08f0e2UZFzvCH3e07R?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 813a5538-5d51-456c-8afd-08dbb50cbd7d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:24:12.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLC2km9DulB68olUcbygrkFYiFBFPOe7Nytezxtvk3gH2odfZsgh8WoX+efgx4MWxrDtnX8z8zeMMeaElSNGQHM0srU7M1DrvWNOaKzqJig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:51:05AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `buf` is expected to be NUL-terminated for its eventual use in
> `kstrtoul()` and NUL-padding is not required.
> 
> Due to the above, a suitable replacement is `strscpy` [2] due to the
> fact that it guarantees NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

> ---
> Note: build-tested only.
Reviewed and tested on dh895xcc, the only device impacted by this
change. All good.

Thanks,

-- 
Giovanni
