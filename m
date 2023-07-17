Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50B755970
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjGQCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:16:28 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83838EC;
        Sun, 16 Jul 2023 19:16:27 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b078b34df5so3139766fac.2;
        Sun, 16 Jul 2023 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689560186; x=1692152186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpGf5HYw9iKxlGO7qMoHuSA9bt9rfkxLjUFs6ASrldQ=;
        b=LR929nXo4qtXXlI7WwYmVDMgChuMI6exRIEj0PesNYcMn1NFfDD6iCWwXT6w2D28YD
         en23QUKKtzl62AU5cJumUxAqV6D3H99rtsspTXsRjxTUqbb+eiaYkVBkufR0gC+kBwOJ
         ABC9EFze5Npd9BzQHXVSKZEygKQ8Ffk+NKlRcwNjTuDTx/IgkJ98PJYyXrQSEcGcILjq
         5rN75sk6owTcwmGyppIm0g4rQpTXEsCbMGlSsz3bf1Wle7a3ulKfa2ImbypoygWSGhR/
         lseN12o02oaHbF1kcpTy8X78F/D/HOjwM59DXIB/kJdlK0kgEMMzmpZx6PjSORIEI+M+
         9jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689560186; x=1692152186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpGf5HYw9iKxlGO7qMoHuSA9bt9rfkxLjUFs6ASrldQ=;
        b=Mm2BzOjZvA9j2UpJIFQ/k4fFlgDXUFUbfLwY44VBQ2SiKYfRiD6Rlj/+XOd95jO/LS
         gihv1kkY4FrOwqSFUvLrjccKNU48axJC+6jWIQml1+RqFSmKXMyXK1UunBXNXKzFyNen
         FrXRd6jT2MNkwLXMcjlpgKfIe9Z/+M7/uX3doPSo550aU19+WSuChuwXu6o56BxqRDOx
         diCGGrTv9X3kv25Bc7X3GILkbE9AYmuNwpNCNxqbFBWwXy01PUeeN1udJJWv9Ps1ruJt
         yC/l1MAOTSvs5Pvo5dG3Hz4GGzrIy7Aw6rWMwVLKETa+59JdX5DlT5/RJCGmhKDZj9cG
         NPBQ==
X-Gm-Message-State: ABy/qLZHFbLoRX7a5fWkWBnya7fDgezzMew4GNn/VfPzuDkgPWN59kuK
        MQ4hHcnxSN4eQObV117ggybNTolxMBE=
X-Google-Smtp-Source: APBJJlHa75/Z4Ab3wZ55y3ctWJqOisimCDZMZgJ76Ts3Z73cK4whcM9dva6ocPnKgq/ntXb5bWN4dw==
X-Received: by 2002:a05:6870:569e:b0:1b7:2edd:df6d with SMTP id p30-20020a056870569e00b001b72edddf6dmr11123599oao.10.1689560186431;
        Sun, 16 Jul 2023 19:16:26 -0700 (PDT)
Received: from [30.221.131.241] ([47.246.101.49])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902aa8200b001ac40488620sm11513510plr.92.2023.07.16.19.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 19:16:25 -0700 (PDT)
Message-ID: <00b0a06a-b220-9176-5046-cd6068bf22fd@gmail.com>
Date:   Mon, 17 Jul 2023 10:16:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ocfs2: Use struct_size()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@lists.linux.dev,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
 <9d99ea2090739f816d0dc0c4ebaa42b26fc48a9e.1689533270.git.christophe.jaillet@wanadoo.fr>
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <9d99ea2090739f816d0dc0c4ebaa42b26fc48a9e.1689533270.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 2:48 AM, Christophe JAILLET wrote:
> Use struct_size() instead of hand-writing it, when allocating a structure
> with a flex array.
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> It will also be helpful if the __counted_by() annotation is added with a
> Coccinelle script such as:
>    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b
> ---
>  fs/ocfs2/journal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 2f7e70109020..4e779efe2a4e 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -114,9 +114,9 @@ int ocfs2_compute_replay_slots(struct ocfs2_super *osb)
>  	if (osb->replay_map)
>  		return 0;
>  
> -	replay_map = kzalloc(sizeof(struct ocfs2_replay_map) +
> -			     (osb->max_slots * sizeof(char)), GFP_KERNEL);
> -
> +	replay_map = kzalloc(struct_size(replay_map, rm_replay_slots,
> +					 osb->max_slots),
> +			     GFP_KERNEL);
>  	if (!replay_map) {
>  		mlog_errno(-ENOMEM);
>  		return -ENOMEM;
