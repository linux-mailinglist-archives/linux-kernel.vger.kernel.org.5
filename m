Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B07CD2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjJRE2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:28:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA49C6;
        Tue, 17 Oct 2023 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697603300; x=1729139300;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=imUUbQh1eVfEbDG6J2Vt7i4mhD2ZH3x+nJWvmvG8Xmw=;
  b=JjRnB20whu95B+ofI1slMXb6b70OYQhGw7EPstuw2BUx3zVLF85ySlac
   BMThyNKANwCE+6EOZ8tF05VqB3LW49iiifLBP3RdYZfniH9MSy+sC7Ly5
   +a7G6LdP0RjrwVOyJPos9lRPIUNV9xRMLRxEu+HTus35pohBmlBurxHe/
   eVyfvsTnqZmf89GZ+x8xKk43gimoyP/J6rXpL3GSD7eS2s3RR2vv6g1Ze
   hwY4LYE3giMiYu2e7ta5SDtNGLphkpkUYzz+NjUm/GSHgDEIv8p7n9Xtl
   PG2Xo2YIyvWfnVMwDuSt0k/THxQBT/Tn6V/NWCIKr6rswOhflxukDoigL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="366192314"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="366192314"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 21:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822272764"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="822272764"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 21:28:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 21:28:19 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 21:28:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 21:28:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 21:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiqxBM0aBoorPtuYZiRKgHsu45wHZ4kH1etv0wdeExXD5Xyk9jVW88eR92shkVOCFxuecC8Bp/byHt548/OVdFD4Kk+18C0krifTNrO1PAyTxFq98FyPSD4i6rOPiYPaxXTaZTy7tDvtH1+pHRHUSL4yzeAz87KV7DcDAyfeNuVPm2p8guk+f1wmHM+NPxEoHBq91HoxwTaMRbgWsWp+xxVB6Xzu7Ttof/pKwoWOst+Nsp7YDuB9dzDUUGOdsm26OlwOHpQ4BQJhpQX3mf0CkRIQ5IStPzRvTfS482CPsQwTxHlV1qSckrFKhKYV8OL2Cedb9cMw/NCr5zYuuURWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjvsheyUHcVH14QxSBuR6VmX9E7IicjSdwQ/f1TBU+w=;
 b=mHD0TBB8PEIT0JEwExfODDAHj31YmWdD9Tf0R9V9ayVLtYoTVAQPHHvcpf7yJOkKHs7HHEdrbBh9HOR8lDnS0kA+Z3wI5pdW2EoxfC4y8WhyFvlmS+vEb25AafzoG1uUp2K0fv5X4oCzmGPyTRepYwkU6mY3S0QxGU0YYS1T0DiXc7ScD1agB5iHbOp6dYrptlfJX782p7Fzo4H3k34p2fTKBERqDHji4fuHIe8eXR6reTP8HJ8REyZTy6koZcYK7f8ZIgPEvkrUBiZWk1AdXFAyqwJcap7r/IlcIpzfwFRhuXla6aA7oOkeVEasQiw45N5QsJFpzEQ4yVTLMPssJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 04:28:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::7978:1ba5:6ed0:717d%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 04:28:16 +0000
Date:   Tue, 17 Oct 2023 21:28:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] ACPI: NFIT: Use cleanup.h helpers instead of devm_*()
Message-ID: <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231017082905.1673316-1-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017082905.1673316-1-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:303:16d::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e7395-d6ac-4eb2-b32d-08dbcf92a62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtCn7OL4gkhn0ZO/p45blFLHXveVfTl3qCMUTkIPJsfe5Veny/zyjdYhcg61G/e+0TIX9lxZA40yFRWHdeTIlGUMbGehApbj0CjLEzh3EggXkkVxRWkxp2eaWq6GazFBHmYScqjg+DCxmlVO4w+AJg+EfEEo+FSzcWwvSzorXOsVLz5kp4nuHGk4vGUoT3HxCL9zP0HDE+D9UXF8W3D7jmSQXlg2E+lvyZ+mVcmPUa+i8FuEvjKqitaTiyka8+v5rYo6En0kpTizOf+kaUi17xi/+uiqLu5KpzJtPCReGDtKgjE0/iArwZDx4Y8+5KQtj9fXKP2hB31P1g2nP8ptno8pckhsdkizUGa+bk5cUWmcTnGcCvR/E5oXgLAlNUX6jqsP5y+BoJ4ea6jT5puMQGL2FfEgjjV30aQuo0z/dNMITbX98CgbUOd6s3AJq3VwXcQMoVCBxBPvkzhYekRA/ld4HdyIVhETfjwpxCwS7CPYeXSlEXVAFzloQ1z0iiO8EOLIHAsdLp7DIR8i7bqtkpPoXMfAMZQc08k9Jch+xsZ4R5iZ5OhWDFgAA18TT4V2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6506007)(2906002)(4744005)(5660300002)(4326008)(8676002)(8936002)(6666004)(41300700001)(66476007)(66946007)(54906003)(66556008)(316002)(6486002)(478600001)(9686003)(26005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/X935VZsIRSnz9GtsB1pHKm528WAxyBGGThTVZ94W4a4eXfn2oQaJA1hOaDQ?=
 =?us-ascii?Q?OUIpNIdNNd42tthSr0ZgZzlXEr0RSjHPcnmhrixb2erxaIZps/Gq6dqW65Il?=
 =?us-ascii?Q?JLyuAmL2nSInr8GSA9tpby3FFUUuuBWFYysjyA68hYliF0YPYElarCv3Q4zo?=
 =?us-ascii?Q?IgdyHyBBcTZd0hlcd9ZYXmfH9KSQwiOhd/2uf1pnHGtYO+At8AJB76qWEtVV?=
 =?us-ascii?Q?o7+NNwcWHGhwhlBJaf1aXjAn+B29i/3zlOp0dAGQSE4ovpB0Zm4Tv8HHw7HV?=
 =?us-ascii?Q?omQzR7aKG7tmETfDzw/l1uspj7GvuFv3Q+tpd64/VCrp0zZrZss+cgIv1UAU?=
 =?us-ascii?Q?TxFrn9C35jjDJKHT4fH9840nie55I1/xZKTF3oEc28Y7wbnUQIck7aGAEYyu?=
 =?us-ascii?Q?/tnrWrODEI6GCurSaQZjPpUyMA1M+HOBd/7GczYQ0WeVmdXBNesoKbWgb6+t?=
 =?us-ascii?Q?GbpBfSrhMEUkzQ6IT435pDs7y6n7CnDqdhxSMq76nsN7653n534WJULaHOh7?=
 =?us-ascii?Q?zeKmxmOzhGEWIzXAIlQXswmi/pbyHaUmlATwrW9KSKF+ekmuWV3gLenLy7OW?=
 =?us-ascii?Q?OoxsGcWO+P6qTXGtaCKpEktMRZv+5+QiEqPUSJ8IoH8YRhDt+JTFZgrZKuba?=
 =?us-ascii?Q?5zlEzIP6QMHKY/UwjhRDP5JO9FAs1vIbhzcDWdrm7kG5LASr7EcJNgS+qsoZ?=
 =?us-ascii?Q?3yrDPltMig6+W7qW56lqkVSI+cRaK/RcrOQdoQcNy440S/23bqaVkiRU30V2?=
 =?us-ascii?Q?lZnFDlw0ndw0V/z/K9/Ejl/fmm3f2/mP2E8vW94ISVAju6q0BzQYtbZQOMN7?=
 =?us-ascii?Q?Mn6jBt15Gj3ZsK5j9CzwpHfsZV/9sc9xMWu/5yg2F4y1irfovjsZJFH+soLp?=
 =?us-ascii?Q?G8INtkaDYc3viXX5MHFtOshflvj53q4wc02m9KNChqmLDGsgWbcjANe94zir?=
 =?us-ascii?Q?1vCl6CDD4wgH7e3i3YcqCtWVW52laK+1yG5ERyp0YvtWtDeFeSVBEfzVRtlC?=
 =?us-ascii?Q?RNa5K2yA0EOaA+jYYq1VVVWuV8WRBKdI7pVQuyVEYe7PIspVFTBr9YGNfmBu?=
 =?us-ascii?Q?k3W/q7+5Y+yjuPGQvqbZNjm3Wc/PK/pKCjM+BSI/oJvW0e+cd6lYApDibeDS?=
 =?us-ascii?Q?xR/gI/BiEUJng+K0ZJQsKCk1TIQU/+UJRDrUKg7a7GMCrsAKn9MkiQ4xMeEC?=
 =?us-ascii?Q?eRfpKlkxDlpEGX3Tv6cXkZ5BSr0VM737e6yGcKXHOrrTFHxDdgxSP+2N6UMV?=
 =?us-ascii?Q?Cj08BLUFTkR2bneNcLe6ZqisR6a//cJy0e2OqS4DlXC/FkMO2UuPtnHvgnXY?=
 =?us-ascii?Q?uDLwfr2m8RDtt3nG1+xaRGbRvVisrhbXUnoRVxM2/UphRz1NPQ+5IpEgyoSs?=
 =?us-ascii?Q?Qli81y8hQueFpqvRsXMoukUVZjVNOkQs+PdvDs7rCh8FyAZMseFoX1wzoSfo?=
 =?us-ascii?Q?EeXAlm9BuDhzznezq7WV73UySCaoFBj/VD9XfApG7+ozBlmTJ4DebBuYwCFa?=
 =?us-ascii?Q?l7D7mbnd3AZecuJpQ6s7EmqRLNE7BII5zY2CqNyCnEVwNMkxBH+E778neDeJ?=
 =?us-ascii?Q?AGPbWPHA6BSkC7WEKElkNKx8Apu82yK979sMWdJDFgQpxbAhS4g+rpTX6nJq?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e7395-d6ac-4eb2-b32d-08dbcf92a62a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 04:28:16.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PwPIFAk2AKCyGKJfhYVL7n+QMj8VFzag+nNz7zWmvraJcUMyN6g4Ch9wIOP5nA9e53ypXqudsNL7mXUYt4MZSIfi7UqI7Nry7PJF+rzosQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Wilczynski wrote:
> The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
> the usage of devm semantics in acpi_nfit_init_interleave_set(). That
> routine appears to only be using devm to avoid goto statements. The
> new __free() annotation at variable declaration time can achieve the same
> effect more efficiently.
> 
> There is no end user visible side effects of this patch, I was
> motivated to send this cleanup to practice using the new helpers.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
> 
> Dan, would you like me to give you credit for the changelog changes
> with Co-developed-by tag ?

Nope, this looks good to me, thanks for fixing it up.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
