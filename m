Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0940E7A5933
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjISFNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISFNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:13:52 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D1EFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2s9CniC2ruB4XnWoLvlmw6E3sgTjdmuk8RnEwaLR2InEuqp8TNBP/DdsbVcLvUaZaUW8vQEcoz0jXJNF5467fc+fZBb9rFJ2alxPke/j4st0o0CwNHWgL5M+Aju+ynlz+mfUSbwlXIREoxqZ4P1RC1RQVUsrQR85Z5e225oUxV926+YHVZJx5uLO3JmcJLtKidODxmpN/rp07Gr6zFgzXTKXQyX9ltCq2XCbt3V59RjEl+P8tlgIhYtUBRbp7cIBrRsOM8/sf0YzkcmUFyFIFlrOzztUiVzd6IMoctqHlsJcK0ADv9j2+8eDV87D+ds5owFtKJAXXX0xcryAEaJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRKIE9RrY02s9dwgFwY/UVA848yuhjfPqZ85Jk4TasQ=;
 b=MbpEMlRPKGPaLcpPzioqGKLcPDkOAg1mn77nvfdOCexwkzSi/54riw8H0613UAm76JdeWZWudoBv66PvXpeyXLgqIqCjjUZYzl8Nwc4gK1w71xvmYlF7w1b13qqgC9JWGV7kyPlvegRqpnV6rTNp1hEk6WstGaWDLWO5Tf+lgKVoOPYitYMlZtsTu393rYNnRyWlGWScP62lZR1o0hBsPR5h48xpkndch4Z0WhUMjaWhTTXypxKlq6FhSzSibPP2HpOAwtz6ofaJa7/IwbMOm+YZ/sZCW4kcCqKPhxGt84vGR/gYaed2mUt9ZYg8fufNomjgcy36bBEsI1V8Xj2mSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRKIE9RrY02s9dwgFwY/UVA848yuhjfPqZ85Jk4TasQ=;
 b=ewPmEyA//u+KTkSJFKf55x2PFMXZJ4BD7C2Fh5rrtGumzMPPwZIQZOytG1Cfm8l9IAitf2fFPyt9NRwmcm0xhggcycLZgEuAhlHU1PvjEm9P/aDWqh7fxEMrtK3TPEzdD9XAH0ixknEVhFzCgMeKNhpEzBxJdgOJR4mLpQplFRWM4HjsZon7igLzZHXxZba3So78yNqRQQG3NVZAz1HpTF8iYmcIwbXPc6+VQ9a9f1PMJTJVhr7OGYlcLpRC9mFIPm7JmxlCVn8wEtCxDS4I7hstmVQq5wmnKjStD7lTOrL8VAKcrmnhNXRqGihtAdZFDUhrtD3/y7ON+pgcr1UVJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 05:13:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 05:13:40 +0000
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-2-ying.huang@intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -V3 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Tue, 19 Sep 2023 15:13:18 +1000
In-reply-to: <20230912082101.342002-2-ying.huang@intel.com>
Message-ID: <877com68zm.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 5524c969-2405-4760-4475-08dbb8cf2f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHC1v/W87ecbYr//1Ank1ESQVEZSMYildI0k25fCKS5SnSd5sUwZ3qrID2SYbLpCUZQOnSo3R/MdCvAyl0XYM6zmuCk3ZDXLSRi/d8aEVOfiuGHqiSNw4Hy56juIRGDL+kzIY4Jzrdx0I+OkedmkZ9PWvAo9Y4mxFASRC3qlhZsEp4YKr3Jln89JDl6ODPHCrkW+u0eP+zDcRWMaRayj99t2WKPeLNv9UcMkW2E9/HiZ2jwKn46f+xg/d8/4uF4s0s/3cx9ziPvEhW+FVy3Nue3mmrGh7OMV8CcN8PIUghF8bNaCBemfvcKu6gJY0fMUAIZ3CMrLU7F71E0B9brU+1rdmfDhZNKpX2l6tb5gsS5fLESKrNGtRclf3wXhn1yESwiqfN5tpEjz4Ar8OcjnEelOvHuG5tuuqELhNbv4Zk4SNukGzp0f282MovQvohxlln/Q/tBoFlqItIVI8M3ZuWiX3ghN5hjgjl/YLLhrHRPugKHK65Ebvs8Ty8PhuAu0b/uKtaVfiL0/PISCgaOJcsdEyg/8AWg6aeyHrQAufBDCXOm+ePN34EeUJm6+8kJ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(478600001)(7416002)(41300700001)(83380400001)(5660300002)(6666004)(2906002)(54906003)(6916009)(316002)(4326008)(66556008)(66476007)(8676002)(8936002)(66946007)(6486002)(6506007)(6512007)(9686003)(26005)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qk368C/b4Xt76Y5EClmCmE8da0M9IjqXUtfsPKvY3NqwH0eRYsGKAIzMD++?=
 =?us-ascii?Q?0h++fONk0fcEJpoe39CrRnOTKLYDA7Anq8Wc0+vmAALRtr34RCTX8i3OqMea?=
 =?us-ascii?Q?qDdNrnR4lpM/23F4CqJTb1ZlDg+v2ik8eRRpkLbbFQs/M6ffDKRMpuhanvlv?=
 =?us-ascii?Q?wjXPMKFl+gpgSE4fFsm1F0fTvQiTPenYATpNbD9D4MJA4S/B+DAuZpaw963n?=
 =?us-ascii?Q?6AaAKOvAHnTVc5QKHgBk8i9455/jwItZO3W7IZaHYrXkOa/UxBmIl5AAi9XH?=
 =?us-ascii?Q?AniXNSOLJhi9lkUQUcVVDxeXQM0EEc3y2gvxOM0E4UZF3SzJy5FZDkk/+21v?=
 =?us-ascii?Q?aOtlr691dMxC+hk5RWyQlxcb4kN2OYwvwViAa1lfRqDJq8AdwI1EzHFN/VW9?=
 =?us-ascii?Q?8bIRD95wvJ81ebv8twUJf67xRPnLvvFQy8h1Vh8V3tdr0nLgQ4eKwOOmJpX6?=
 =?us-ascii?Q?Gl14SF4WLXcw6x/qciLanRjZhdahD0zBzbORwUAOjwyanZbsEvixPgF50+UI?=
 =?us-ascii?Q?juhmsc2Czxy7284IJJMr3cSxX8wtyRxxxF+EcoTWSGd8oeTzqpVx7U7A6a+5?=
 =?us-ascii?Q?FqYUlokTgRseKyEJXaaX+Sw27kgcRSTB9Ve3vYQRVabNC3oPRnK2kICpSPU4?=
 =?us-ascii?Q?ku6MklPm9qnPPYlUFWQr9Av2pT4fv/T0QUKAh6PwLGNQA1y2DBsh8Je8DpMK?=
 =?us-ascii?Q?yK9HSN0gOLPaPSUNJnAroTKXZ1NGaCKLUwwvqZXfOFX3eH8CqHTOCpdYWJe9?=
 =?us-ascii?Q?2hVS9oupL1U7x8j7F8jrJYdai49UYuhrej65/T4kdGBitRRqOCVRzgcr4YRS?=
 =?us-ascii?Q?xLKSj1Sr2N1Y9dRVSs2nLHIC4XpHPbHXzwuVqwR0F0m9GD4UhWYyI7KpB2cf?=
 =?us-ascii?Q?uLwJIsR10Lq+jJUXWgN+bIHCHAsSdtzk18ScKVQo55CW0crnpX2Z3QpOVMVg?=
 =?us-ascii?Q?6C9a5tM5YhwMwKS/1mMpNUxdJ6x90KUDwkBw1DcQvFhnYgD855bYZh+bzlPm?=
 =?us-ascii?Q?zZ0MfjvK4jxzxnGoLaX7ahp6w6AV/79Njw1FfjfKUSX3SNkwrauLiHb48LgQ?=
 =?us-ascii?Q?tb8ILEGR/d8y5NzuSpys3yhrylLgh4KxJLcnEujSrYZxRKTDge/yDOWrWHWf?=
 =?us-ascii?Q?Xy+GQUV2GDZZmoKbK1BxKtmiNtBwCqjvu44+YIH59Jb4nS/YfPYBilhS9uZD?=
 =?us-ascii?Q?LI6HMami+noA3yrCyNDeMd20k/aBZiBc7DTOmeJrK6ZbKAOug5QD9xSOrJCZ?=
 =?us-ascii?Q?+e1dvFhInxaGP+JMZCIDlU9fcnIxdIFa1paEQYXO9O/xBSmVJDVe0KdYNs5W?=
 =?us-ascii?Q?GdODc9w1DtR/CqsmI7Ug1e3rpjEYr5JagmGH/lMoSBWoAnvgMdXcX/NIfcav?=
 =?us-ascii?Q?8T2o7eVrSjoACIHaooSYutenp/ZIF2OsOjvkmNbfzNErUN3cbghpkrNEFfi8?=
 =?us-ascii?Q?noSIdoexou6KWGJ0evFdCCfZvBrubFJSWbDt/t9npIr/5e3DcJ6Lnq0BN6IW?=
 =?us-ascii?Q?gyy8VYGefRl9pIJMzh+5gg5KvLHNt56No6lBx4PfJpjrV1iatndxc6XnzUjf?=
 =?us-ascii?Q?T8KKAKC5XyzXetpJWg2DegOCMyty1p6EYpGH+/z5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5524c969-2405-4760-4475-08dbb8cf2f98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:13:40.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vf/Bq51+9TMrD2zO5zPVRQXQr2EIJx38bcLGpQNKO5zkIpr1ykwKzlEiBXEGH8B04YZ8EMlBkfpl2vNWexs71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Alistair Popple <apopple@nvidia.com>

Huang Ying <ying.huang@intel.com> writes:

> The abstract distance may be calculated by various drivers, such as
> ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
> hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
> users and the providers, the abstract distance calculation algorithms
> management mechanism is implemented in this patch.  It provides
> interface for the providers to register the implementation, and
> interface for the users.
>
> Multiple algorithm implementations can cooperate via calculating
> abstract distance for different memory nodes.  The preference of
> algorithm implementations can be specified via
> priority (notifier_block.priority).
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Bharata B Rao <bharata@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/memory-tiers.h | 19 ++++++++++++
>  mm/memory-tiers.c            | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 437441cdf78f..c8382220cced 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -6,6 +6,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/kref.h>
>  #include <linux/mmzone.h>
> +#include <linux/notifier.h>
>  /*
>   * Each tier cover a abstrace distance chunk size of 128
>   */
> @@ -36,6 +37,9 @@ struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
> +int register_mt_adistance_algorithm(struct notifier_block *nb);
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb);
> +int mt_calc_adistance(int node, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -97,5 +101,20 @@ static inline bool node_is_toptier(int node)
>  {
>  	return true;
>  }
> +
> +static inline int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int mt_calc_adistance(int node, int *adist)
> +{
> +	return NOTIFY_DONE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 37a4f59d9585..76c0ad47a5ad 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/kobject.h>
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/notifier.h>
>  
>  #include "internal.h"
>  
> @@ -105,6 +106,8 @@ static int top_tier_adistance;
>  static struct demotion_nodes *node_demotion __read_mostly;
>  #endif /* CONFIG_MIGRATION */
>  
> +static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> +
>  static inline struct memory_tier *to_memory_tier(struct device *device)
>  {
>  	return container_of(device, struct memory_tier, dev);
> @@ -592,6 +595,62 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +/**
> + * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
> + * @nb: The notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + *
> + * Every memory tiering abstract distance algorithm provider needs to
> + * register the algorithm with register_mt_adistance_algorithm().  To
> + * calculate the abstract distance for a specified memory node, the
> + * notifier function will be called unless some high priority
> + * algorithm has provided result.  The prototype of the notifier
> + * function is as follows,
> + *
> + *   int (*algorithm_notifier)(struct notifier_block *nb,
> + *                             unsigned long nid, void *data);
> + *
> + * Where "nid" specifies the memory node, "data" is the pointer to the
> + * returned abstract distance (that is, "int *adist").  If the
> + * algorithm provides the result, NOTIFY_STOP should be returned.
> + * Otherwise, return_value & %NOTIFY_STOP_MASK == 0 to allow the next
> + * algorithm in the chain to provide the result.
> + */
> +int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_mt_adistance_algorithm);
> +
> +/**
> + * unregister_mt_adistance_algorithm() - Unregister memory tiering abstract distance algorithm
> + * @nb: the notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + */
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_mt_adistance_algorithm);
> +
> +/**
> + * mt_calc_adistance() - Calculate abstract distance with registered algorithms
> + * @node: the node to calculate abstract distance for
> + * @adist: the returned abstract distance
> + *
> + * Return: if return_value & %NOTIFY_STOP_MASK != 0, then some
> + * abstract distance algorithm provides the result, and return it via
> + * @adist.  Otherwise, no algorithm can provide the result and @adist
> + * will be kept as it is.
> + */
> +int mt_calc_adistance(int node, int *adist)
> +{
> +	return blocking_notifier_call_chain(&mt_adistance_algorithms, node, adist);
> +}
> +EXPORT_SYMBOL_GPL(mt_calc_adistance);
> +
>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  					      unsigned long action, void *_arg)
>  {

