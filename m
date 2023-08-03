Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A3176EC7F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjHCO2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbjHCO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:28:02 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D641FF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:28:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63d0f62705dso6491986d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691072879; x=1691677679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CXtNf2juTpnNbc2iwpH+iIlLPgtlL44HuZlVb5tpAE=;
        b=we6Fk7q9zEhw+CJrONTMaJeY7V/kFX0HXrXBKxV2JUSNlNTJWCPnPehRlsHF+z0blk
         sCi0pOw0r/N0CWun/xl5QKYU5EqnUJgwj5FZ8JNAqoJy1DQT2hCMZCnpOuWyGc48sE3D
         sTyG5UxVGS4xRHYoxx1I/z/P48lOZIsUcjeK5qGjLLilXjY5rsapUi4EEYINt6r3pbBr
         gPVHJC6fpUvkYchQcfc6WKZCHsLYaReFuKXCga7sr7uJ92TuEhl1w+DkcZxa64DNoiBq
         hx0rO7pxXlDuzIVFdnJkvgOiXqqxD81njci1PpeY8re9g1MiTPuvkpD2EJIKFDJIHVOh
         ol4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072879; x=1691677679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CXtNf2juTpnNbc2iwpH+iIlLPgtlL44HuZlVb5tpAE=;
        b=ahLUWaI9MLs/huoADtpku1kFFt1SpaugvDJqtZyJHR5wL2Zg27aOSLLOwTtRDFt7K8
         G/CS6VEa5gBnpXrDHSfobVUr7BVWl8Wpwbal/J6x2Hx2EsFx83D2LEQOm5x63rKqUdHv
         EJvCmcosGcTbwqnPqqx+lKcWWX9YuPLFkXLal7VnmxH/dN6P25r20El4ZGeEBI0m30oq
         tgW80EAMm3bDaUXCqENQJJfyN+Hsee9O16bBO2RebZjTaw1rZZE2xjK6qmyi6B9ADEdZ
         qzTbgcqymPqPaj5p7nR62BVXDqRH+OtPh4kb9xJ4z4lxYguKzaaY3IjPUoqS9a5AwXRN
         a3pA==
X-Gm-Message-State: ABy/qLZW8qoYRj0BYKxrtBP0SR8AX0wCbH45ut02oMmTNPzx/kZNNiGW
        JYKv531/jZnGi6IOIkIoaVRP5sFzeIPxNOrEpeedgA==
X-Google-Smtp-Source: APBJJlGojymVhYXzLWJgFKipyPQ/BnXaUfG9SeeEXt8ZHQ9ePL7qELRqkM608B7MH/EeqxqFYIRldw==
X-Received: by 2002:ad4:4d87:0:b0:631:f9ad:1d46 with SMTP id cv7-20020ad44d87000000b00631f9ad1d46mr18311921qvb.47.1691072879487;
        Thu, 03 Aug 2023 07:27:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id r10-20020a0ccc0a000000b0063d588c4111sm4748687qvk.82.2023.08.03.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:27:59 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:27:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Message-ID: <20230803142758.GC219857@cmpxchg.org>
References: <20230803113123.577023-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803113123.577023-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 07:31:23PM +0800, Miaohe Lin wrote:
> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
> called when CONFIG_CGROUP_SCHED. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -3686,8 +3686,9 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
>  	return ret;
>  }
>  
> -static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
> -						 struct cgroup *cgrp, int ssid)
> +#ifdef CONFIG_CGROUP_SCHED
> +static int cgroup_local_stat_show(struct seq_file *seq,
> +				  struct cgroup *cgrp, int ssid)

Andrew, this is based on "sched: add throttled time stat for throttled
children" in -next (coming in from -tip). Hence the routing through
you rather than the cgroup tree.
