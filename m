Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86EC75F4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGXL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGXL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:28:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20720.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::720])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF5106
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 04:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1Ag/0oEAB5XC1lACShgeoGQ9wJQIz4mJhklWG3rLGWYCbEs7axxk+f6zIYn1Q/lecGLMRqS5kDfKn7yolyzxysQnB06YQU1qlCOjmV+eiWERkARB4+eG7FROC9bRPCjCg38JgF2JtQ6nn1RO3Y4ocIKNP10AVml2jQ8ikMcxvEom9pXc6wKFevLpLoGFKLJBXJNsHR8GerHtiNL0hAHzpmMW3H6QxH0/Y30OESMfiiXh+jg+OVIL9ZnrVqA8KZfJ4yYLzpR0Di1BvNspGv11KapSXk2MoEYE55zKEVuPyvgZI4sX+6F6j3QlVho59bow0q8bxB3nDeTm/gllEtscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptsSwCqJd9JYv7NrnIdtQ8gWav6THhjSiMueDJDooo8=;
 b=ZucXsEG3uZTFOumSIE9hwq6O/Wr35YrUtqHUBdsShdmaoaywxbEg/oZssuaSoQOeEl0aDmPhu8iXqbC3f8onTW9uQ5DEmHpgAwx98XBk5Xnlw0O4SszJOmBG6ulCgG+DINRg9VEfeSiV4ZxfLhk2/eyHT6NUvDcF1il1uPy5axpvdJyv+Qc/tobKpbF5gb9B1klD6SZs9DOCw2wGn2mTd4HwnBQNgkXRPhePh6n9mImgClzYoulW2whqLgwYT6/My6FLeO+FlPm4scgsKo70BpX5d+k4hEkAvJbzNyKN4LNH7pUnj5+YmbdBlLX7WvXwvmr696KUqKM5DMemGY/RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptsSwCqJd9JYv7NrnIdtQ8gWav6THhjSiMueDJDooo8=;
 b=ljEihUcMXUlb0A4nhnR6m3w6iT11BBywXfYM3t/y4ZMk87DTPiyO4zfNjipNnSWa/ZDTXhrV/szsklojnJ8MCutp2ZxEkxrsepaDbnbOIQlXdETOW9bxjqx2qqE9M8n3btwqKbOche3wXlcwRREmk5Ldg+pCZeCNrjLqMiKramo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB6044.namprd13.prod.outlook.com (2603:10b6:510:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:28:02 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 11:28:02 +0000
Date:   Mon, 24 Jul 2023 13:27:55 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Richard Gobert <richardbgobert@gmail.com>
Subject: Re: [PATCH v1] skbuff: remove unused HAVE_HW_TIME_STAMP feature
 define
Message-ID: <ZL5gO1PZyrYS0ft0@corigine.com>
References: <20230721191805.20411-1-ps.report@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721191805.20411-1-ps.report@gmx.net>
X-ClientProxiedBy: AM0PR02CA0121.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1c1c9a-fb15-4a4b-2eb0-08db8c390a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmkjhBfvmU8MmCk7mHl73iGZBJy1jFRD5YdTH50OQh3uoOnDvWL/ZLxucCj2oHvjUcrZHbeYZ837e6HwbxvgLQDKmdrHqtXRsmPMEn6vTuPSH4HrWPkqR/3hcTvWc1eL7BAbC5JSlrsh2yreMoT/mQfQ4XhSmLSj7T5zszsAkAnADOeHHogpBxQilaMrq8KFheuGrlL0Ltm/3msCmIapPSmskjbrw0pA6gbfhyDBpkq+h6O1b7Dm/R9uWHuPxmqUFieLQh2vPQ8VKC6ewcIopJO2164AmQVdTFSczmXGpLJ6LKqWd2zurk3kTNx2l+qBFxyUE9SXB4Dm9rIpx5n5COvwSGUvDTJnuvdqjwSXc3GTtwCZqp/eqa9hvcgl/ezBJyFwLCKtN1s4+sKiApCWuaPJxWUOjbcTgVQtDdFIleww9pqQvioPLKaquao5jG9nSe5xVSH2ZalIdvOWdpLdQz2lYW631jPrf8fEFhEvwwPn+MMoz8tfctGZvakJz1TX0USuixEy45xmgt4UlE38gccC5w1kHSyaBc/h88hnapX84VgvTlnDPxf9zYAneI95Cvro9/5eVSLiD3nKeSsuUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39830400003)(376002)(136003)(396003)(366004)(451199021)(6486002)(6512007)(966005)(478600001)(6666004)(54906003)(83380400001)(86362001)(44832011)(2906002)(186003)(2616005)(6506007)(66556008)(36756003)(38100700002)(66476007)(6916009)(4326008)(66946007)(41300700001)(8676002)(8936002)(316002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wofHGgFJpkSL7afOwEDsvDrtixxBfFYP3sLBvCOpmXB9UxUlDOPQ6zHD3qxg?=
 =?us-ascii?Q?QU/yz1Oj9jAZcOi0Z9xJyLZ/BEFlmirFfCOZ5LwjVgkUIvhcR+nt9QhXVp5+?=
 =?us-ascii?Q?WVrxyNiZTeu9ysm2M//e2i7zLWyaBtuQ0dR4WAeNqMHMW69O04vSpOtNZjcQ?=
 =?us-ascii?Q?n5E2C3ea8HWGanjVPzDYVI4GH5eYfQno1/J3jx0PyVhlfxa32oUNF+KwBGrs?=
 =?us-ascii?Q?8nbp7GwCjbopi60aYhqWL+83mDIJMHhstKrpySoEiipicLdyyLmU/2PLSFBN?=
 =?us-ascii?Q?2kWCC1JsNq0QzefhROE7n6BZpkJYK57XCUrxuu4Iu49v8ncaUrVzdE54+uPs?=
 =?us-ascii?Q?G3jzmvFvsUDRO68/yX0muwBYjPeAKfp8fMZYmqCbUly7MZe6rS81s7FzIcji?=
 =?us-ascii?Q?gjzUlAiKaUKi42NdnnYBAkhR4TWgMHMrc9xIuYA71IPxlzuPL9qUkD433pZT?=
 =?us-ascii?Q?O+94sL+eNVGcRV77MU9aF6lk2RyKi67nxDSLdOZpuqp9/bu9kZA8giZhC4Dw?=
 =?us-ascii?Q?c6Mm5GzGh9V14yEj3vQ9UAJtIGGjTzryKKE7k1Pe1jsOjE9XH+HmcRdkLF6E?=
 =?us-ascii?Q?CPgOnrbq6aB7LI2VPW944QF/SI+MBbS79+NDZalPFlASFQLhkFcJV9uAYnOs?=
 =?us-ascii?Q?kelNJ4hHhACROphNTAVyyTut+waHXYBdYwsKXxwTbHeQE7gUsbk/TB6znKBl?=
 =?us-ascii?Q?n111FqY/SyCDUw8T7UNOG9Qi4L14FlslRVuVyQFYU4l+UvUkZ+rzgZUJJohx?=
 =?us-ascii?Q?Svt51zR/4TKHTYHjHZBkbpk8hQi5SGSGZmpqoW8eOshnq5U8tTPxEZxbMl2o?=
 =?us-ascii?Q?ewxT34diMFfJmh2PTO7tYLRCkO+2zLiaEiKU27bcLDbGu7i+QAR+TLmtn3rH?=
 =?us-ascii?Q?z9RQIvX/UhOdkMZfwMjQH+tkvJUHtu0uTj70Lx5mSrznTl199u3+rzQMiE/C?=
 =?us-ascii?Q?1frINI/kNXAQAGmj1jhnozAdDv6CB4HZvWFBY4BYHmFKivoeQFc91uL5eOKi?=
 =?us-ascii?Q?Q7vwHfQgJXLnvGPOYlL3alIWFtOTw8yCoassvpUnV4eGf7e7PbYcNMMKHVZf?=
 =?us-ascii?Q?NPav3ZTz3JawJoKY/eh1OWrElzXxzk6cQX291CD1VF9jHlj8GPhcEO+vBBUn?=
 =?us-ascii?Q?ST45azSrlCQwVFNGT5rd/tFE1UqJglSu0QY0ySz4jNnCG1Untst2XYOCM41e?=
 =?us-ascii?Q?m4AYc2mAcxZIaxZnmDJf3OxG4/EFyTUJdurVs3dLF8wxjHAq6WuiPHJrAB8x?=
 =?us-ascii?Q?AH7YzjljYCxF+qNrWxgFyE9SCio1LFl9V4KxCuHYxxkb4mX5y3rN77xreB0b?=
 =?us-ascii?Q?M8ZhibbuaPsvjjmntXNJF6zRnDCkGx9r6CPKFCX38IDZgIxSOu82Ty964c0F?=
 =?us-ascii?Q?51gbiLP9whawK9y8vmdUt6eXFkFMpXGdqSUAvCghmlz6Ak5bkjBIkjyHYWGc?=
 =?us-ascii?Q?QIYb4tP+2tnMXE4+LenzFGZTvK6PB1yVvoxrKxUXQrSkI2M2WjDKxO/oK44j?=
 =?us-ascii?Q?hDB+zuXW0oz2pgRZOz2yudnMuWd+jahjsesPdVsXhbLn6+fzsEMOs6o6g89r?=
 =?us-ascii?Q?G2yhuGo/TeW3TrneVB4PaoCxqQVZjKlkfcx1aCe4h6cbqLUAR9HYWR/DBQO2?=
 =?us-ascii?Q?il+qDmbR7KX980I0Pi1FY3+NbDujyiU61hT3jHUysOK2kHMM2Xa2UmjV0FEl?=
 =?us-ascii?Q?lM4E1g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c1c9a-fb15-4a4b-2eb0-08db8c390a8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 11:28:02.3063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jKSMrL943wfYEhoBIV5nRaO8n5d+QpDmwcHWx+G/gtOa2btVdD0UlPh+b9bLg/k80evzJJCU9Te+ufXH5FGrZR5o3j6hm2t6+is0tpKK/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6044
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 09:18:05PM +0200, Peter Seiderer wrote:
> Remove unused HAVE_HW_TIME_STAMP feature define (introduced by
> commit ac45f602ee3d ("net: infrastructure for hardware time stamping").
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Hi Peter,

this patch looks good to me, however a few tweaks are needed to the
submission in order for it to enter the review pipeline, and thus
path to being accepted.

1. For networking patches, please specify the target tree.
   Fixes go to 'net'. Other patches go to 'net-next'
   This appears to be in the latter category. So:

   Subject: [PATCH net-next] ...

2. Looking at the git history of include/linux/skbuff.h,
   it seems that 'net: skbuff: is the preferred prefix.
   So:

   Subject: [PATCH net-next] net: skubff: ...

3. Please CC netdev@vger.kernel.org

   This is the most important part, else our automated systems don't see
   the patch, and it doesn't exist in the pipeline.

   As an aside, in general, and in this case, there is no need to copy
   linux-kernel@vger.kernel.org on Networking patches.

4. Please do CC parties to any patches mentioned, in this case
   ac45f602ee3d. Which I think means:

   Patrick Ohly <patrick.ohly@intel.com>

Ref: https://docs.kernel.org/process/maintainer-netdev.html

> ---
>  include/linux/skbuff.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index faaba050f843..16a49ba534e4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -441,8 +441,6 @@ static inline bool skb_frag_must_loop(struct page *p)
>  	     copied += p_len, p++, p_off = 0,				\
>  	     p_len = min_t(u32, f_len - copied, PAGE_SIZE))		\
>  
> -#define HAVE_HW_TIME_STAMP
> -
>  /**
>   * struct skb_shared_hwtstamps - hardware time stamps
>   * @hwtstamp:		hardware time stamp transformed into duration
> -- 
> 2.41.0
> 
