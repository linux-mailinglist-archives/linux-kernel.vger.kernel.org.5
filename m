Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9647799F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHKVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjHKVyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:54:23 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288AC2712;
        Fri, 11 Aug 2023 14:54:23 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d67869054bfso720199276.3;
        Fri, 11 Aug 2023 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691790862; x=1692395662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWFzHDJZSe7IcdQmnpxG0U9/1ZYD5Blo4+gtS89Sf8Y=;
        b=qWxWmvSvomy+GlYkpiNxVPXlHfDHpdizpeoDeIBvHdTMa4G3YSZrPLA56qzMGICfhb
         qb80OLnktOhh3ICpQ7aEkc/9H33KWKtBZGQ5oSUWk3lqMBQrCOC1dCIpOcwiVBFwnoy4
         +BXqrP6N8VPlBpusK7owLY+8WZbP5Kzw6UlXyDHQ4g+U1qH5P84RScL0V3m8LVcxUKgh
         zQ1JsE1LN2L6nMgfD2najav9qn/R/1XaN/HOWzcfzu1bABgaQlwxFaA9TBaklMm+yKTe
         mVgyunsTYyS2FSCLxnzreVN5Lu01RIZaK9vu9avM9W+/bKWS63R6+ejkCduziZoW5RSO
         OdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790862; x=1692395662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWFzHDJZSe7IcdQmnpxG0U9/1ZYD5Blo4+gtS89Sf8Y=;
        b=hyvYArugGP5GxQzlM+tpJzp9AOTThLr0FfurpBeK1k4wje5QF56UUjTLtkeZ4T3aKV
         KI/SLvZe/Y2B+t1nfWc5O+wXQLd/DfJoEn/hs1Ac5UwY6UhE/doIyyoPY5you3ExPo3d
         eJ5IUrQpdRZi/EFMsXG9mSXKynrL4TdiggaMTpPebysBULBnfKRFMOMg1HdsNw1jFdzL
         zEJJaXBOU44AfWDb6TEvCystmi5qF8qzLuNuWi0IIuNx4DibPphdJnQXWBZlnNqv89+j
         GUY47UQhKjWz1Vf1kA6XYI6DumuM/HN3F7/zn4KgLn+L+sKWTlVDNtCkN1ZqHtAu9UwT
         yzzw==
X-Gm-Message-State: AOJu0Yxr2vW5l0zdzdpiByqzQQ+CvPXxk4fVrdjbhxw/CO42FfkhtGQH
        toIQXiabIfoxEWRduEuNnA8=
X-Google-Smtp-Source: AGHT+IEmEgyb8XHh6sDOFJXQYmxPlm9ssZFigSXSfosEn5xL9Y59cxJk/KKoOa4p2KMkpKkE3wNSsw==
X-Received: by 2002:a25:2fd1:0:b0:cef:e2c4:d366 with SMTP id v200-20020a252fd1000000b00cefe2c4d366mr2805538ybv.48.1691790862200;
        Fri, 11 Aug 2023 14:54:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id s3-20020a25b943000000b00cad44e2417esm1091611ybm.64.2023.08.11.14.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:54:21 -0700 (PDT)
Message-ID: <0f5ea3de-c6e7-490f-b5ec-b5c7cd288687@gmail.com>
Date:   Fri, 11 Aug 2023 14:54:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2] bpf: Support default .validate() and
 .update() behavior for struct_ops links
Content-Language: en-US
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, clm@meta.com,
        thinker.li@gmail.com
References: <20230811172541.618284-1-void@manifault.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20230811172541.618284-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM!

Acked-by: Kui-Feng Lee <thinker.li@gmail.com>


On 8/11/23 10:25, David Vernet wrote:
> Currently, if a struct_ops map is loaded with BPF_F_LINK, it must also
> define the .validate() and .update() callbacks in its corresponding
> struct bpf_struct_ops in the kernel. Enabling struct_ops link is useful
> in its own right to ensure that the map is unloaded if an application
> crashes. For example, with sched_ext, we want to automatically unload
> the host-wide scheduler if the application crashes. We would likely
> never support updating elements of a sched_ext struct_ops map, so we'd
> have to implement these callbacks showing that they _can't_ support
> element updates just to benefit from the basic lifetime management of
> struct_ops links.
> 
> Let's enable struct_ops maps to work with BPF_F_LINK even if they
> haven't defined these callbacks, by assuming that a struct_ops map
> element cannot be updated by default.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index eaff04eefb31..fdc3e8705a3c 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -509,9 +509,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	}
>   
>   	if (st_map->map.map_flags & BPF_F_LINK) {
> -		err = st_ops->validate(kdata);
> -		if (err)
> -			goto reset_unlock;
> +		err = 0;
> +		if (st_ops->validate) {
> +			err = st_ops->validate(kdata);
> +			if (err)
> +				goto reset_unlock;
> +		}
>   		set_memory_rox((long)st_map->image, 1);
>   		/* Let bpf_link handle registration & unregistration.
>   		 *
> @@ -663,9 +666,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>   	if (attr->value_size != vt->size)
>   		return ERR_PTR(-EINVAL);
>   
> -	if (attr->map_flags & BPF_F_LINK && (!st_ops->validate || !st_ops->update))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
>   	t = st_ops->type;
>   
>   	st_map_size = sizeof(*st_map) +
> @@ -823,6 +823,9 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   	if (!bpf_struct_ops_valid_to_reg(new_map))
>   		return -EINVAL;
>   
> +	if (!st_map->st_ops->update)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&update_mutex);
>   
>   	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
