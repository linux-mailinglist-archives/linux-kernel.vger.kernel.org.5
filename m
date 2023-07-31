Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7076A0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGaS4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGaS4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:56:52 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A510E;
        Mon, 31 Jul 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690829811; x=1722365811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgHdVHc/hO61gi3jtEwr/ThEEHnRD/FgvDGcT1bbm/0=;
  b=WErx9+vYg1HelrcrcFaxLQ2N5NxYMmMMXkCQjICHNviAvSu9m2J8JMtM
   74vyZ/7ItlsxforjVo2epkDBtAtwi18oAKeZYCv+SR8UYG7caMuix81LX
   MJPFs42j0DeaoPAOAAscygG7WSTpoItCc+6MMnvyFaL6YKBqdZOwDyaFE
   o=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="1145993431"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:56:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 53DD2344059;
        Mon, 31 Jul 2023 18:56:43 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:56:40 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:56:37 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <lmb@isovalent.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <kuniyu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
        <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
Date:   Mon, 31 Jul 2023 11:56:27 -0700
Message-ID: <20230731185627.11008-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
References: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.27]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 31 Jul 2023 11:42:53 +0200
> There are already INDIRECT_CALLABLE_DECLARE in the hashtable
> headers, no need to declare them again.
> 
> Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
> Suggested-by: Martin Lau <martin.lau@linux.dev>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
> As pointed out by Martin there are some duplicate macro invocations
> in my recent SO_REUSEPORT support for sk_assign patchset.
> 
> Remove the declarations in the .c files.
> ---
>  net/ipv4/inet_hashtables.c  | 2 --
>  net/ipv6/inet6_hashtables.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 6a872b8fb0d3..7876b7d703cb 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -333,8 +333,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> -
>  /**
>   * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
>   * @net: network namespace.
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 7c9700c7c9c8..b0e8d278e8a9 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -112,8 +112,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
> -
>  /**
>   * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
>   * @net: network namespace.
> 
> ---
> base-commit: fb213ecbb8ac56b2d5569737f59126e91f87829a
> change-id: 20230731-indir-call-f1474e314184
> 
> Best regards,
> -- 
> Lorenz Bauer <lmb@isovalent.com>
