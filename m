Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567BB7C5856
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjJKPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjJKPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:43:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA691
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:42:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d922c039so1820485ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697038959; x=1697643759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLH0umzVzkzMlLL505+WdiJ0FY1Sury7B+CiECVSeNs=;
        b=NgbiRjYmhJ5Bk16WR5oC6CrM/U+56tmh0Pgr+rPI16qxlwBdEivylL2DtQxcnTTPme
         Se0kAfIKLqghW5gceJlHV4FYS9mDyWUwssLDwpEh84Z4GwV8EyqMiaAIC8w89p4EWaZy
         aFZl/g+ZP+ktOy6vNVVfDpiY+uEjvEiWWIEiCLbm4WA/+Bl54svT+chdsRFmiTFPqNPN
         4eUNd0svrqpTLXJPbfktGpjR+lB3aSCDrN8Wy3xoYMJGZU005JBLsPGKcwmI2FzxW8kv
         e0dd+XpueecjdYRsRxvAlu5RA81zaI0BFcUIv/5Dp5iDjHa2QGG3jWGr+hgzCku7/nQV
         2Upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038959; x=1697643759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cLH0umzVzkzMlLL505+WdiJ0FY1Sury7B+CiECVSeNs=;
        b=Dz++NvD9bYaUZw7YbddqwGtpVn0f91j9TGUFma0lFSMiP4PSbA8f+LjnpCYJnUH+Ch
         zHD9fDQHlxreC0kW68D7fnkRN8RvexhLKdW5tnQg0tMwH08iaZwdiukCEVQSDwXNp50P
         XrT98+3XUwObJPEH0P4iViU4msp2b4N1v7fHrNtPNBj5ZGVYp1YuSrHioFvZVI1NiWzM
         xG9irla38E8yf7gobUfEOk5hDu/WohXOcG7SklqOqOyBxptgv/fNwLHEDEGQ1iTZTYTH
         1AzlLbdaFQ6Pdq6rKT5SM4ku9VL9JDCEa9OYjhNnsqwOyDN41n2xf621FAUYhROs3hGj
         yM3A==
X-Gm-Message-State: AOJu0Yw2df4Z3s18hoMe8qXLOvzOFv7fe+jsdHIPvU0WtOratCNdomyQ
        EL5oNyoAzo/L+ZdZZXtJJWmsIQ==
X-Google-Smtp-Source: AGHT+IGPdhqvnqVeFNJs68w/YbZwkSpWls5CnBMwSw9bjKEbdwdMVO/Hv7EShENVpIrvfdotYi32RQ==
X-Received: by 2002:a17:902:7893:b0:1bc:6c8:cded with SMTP id q19-20020a170902789300b001bc06c8cdedmr20157796pll.67.1697038959247;
        Wed, 11 Oct 2023 08:42:39 -0700 (PDT)
Received: from [10.4.181.228] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001c60e7bf5besm14039387plg.281.2023.10.11.08.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:42:38 -0700 (PDT)
Message-ID: <1632d0e6-2d52-43b1-8a01-056231c0819d@bytedance.com>
Date:   Wed, 11 Oct 2023 23:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] maple_tree: Preserve the tree attributes when
 destroying maple tree
To:     Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
 <20231009090320.64565-10-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231009090320.64565-10-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/9 17:03, Peng Zhang 写道:
> When destroying maple tree, preserve its attributes and then turn it
> into an empty tree. This allows it to be reused without needing to be
> reinitialized.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index d5544382ff15..1745242092fb 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6775,7 +6775,7 @@ void __mt_destroy(struct maple_tree *mt)
>   	if (xa_is_node(root))
>   		mte_destroy_walk(root, mt);
>   
> -	mt->ma_flags = 0;
> +	mt->ma_flags = mt_attr(mt)If I put everything into exit_mmap() for handling, this patch would
not be necessary. But I think this patch is reasonable as it simply
deletes all elements without requiring us to reinitialize the tree.
What do you think?
>   }
>   EXPORT_SYMBOL_GPL(__mt_destroy);
>   
