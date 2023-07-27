Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE067653D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjG0M20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjG0M1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:27:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE5E359C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:26:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1505951f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1690460815; x=1691065615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krUsWJrSbT94Y2njRnvGsx0mZ0IDUPa+ST4QCqg21Lk=;
        b=SirOA77z3IYYVzo6MktRkF6SXigTC2gNOaK9LgeVqhnF4poO7cjaVWGOowctJLdZm4
         p4np4nG0P5aWhe0Qxr6zY1IDJIKSpli9n+ZvXQd49z08XLStoFaronpi2dokRWTzxDY/
         AoBytA6eEDOmIDoUr2Fry49cmkURQXxjE6zYW0mqjIaFjYD3Mxq1/Gz/yr8S121D6Au5
         M7HqFRoQD8xpI+PmWqJOjHp9dctOqdrxw+za7TJ2P1PPs4moeci+258f2dn7Acr4DE76
         78vs8AiXcxCFuFC8ZC345YAXJI9YbMdhDSKn1iAST8RQR8pC+8QecnGDNxdwsrq9qXG0
         mRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460815; x=1691065615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krUsWJrSbT94Y2njRnvGsx0mZ0IDUPa+ST4QCqg21Lk=;
        b=CnITwCnlPKEEh084VrVmqhDebZrcabcXypRIGPG9piur/bN6WVCAcMQQ3ozi8bCaXt
         F9tGeztTk5iuE2kfOmONkxiPzoRuY/jVzVwahw/bq3WrZK+CmaMx+2NoGUoDuDf2ZMDT
         MVXLB2zuwOdC2eBVM3sf1TUZrwG+L6XswkaaeJxDVv7MziNXeO0lhUf7OVz7NkwlPutk
         k9yCEsVIq7GZ0t9xVAyVh3Ce41y22V7+/cxkoW05Lc4hZApOSgyqzxs+ORvwyMm6xUI3
         5GaAy/MaNjnx2p01/PQ9HenWWog1zg+VRh0MzoTru9RmWgOQndNdY6kEva08gc+iC2hw
         Vg+Q==
X-Gm-Message-State: ABy/qLbiaJq26LbhN+Acg6vkW4hxUrri4FCudKWNMno/w6BQTmbYZg5O
        RvK9ZqVr3zPnMW5o82IanxhbIZ1ZBBeJJ3KaLuoUwQ==
X-Google-Smtp-Source: APBJJlHZESWh+iPWchiyU4VlWw4pInX9ZuRnhfnhpPmvQe48Qu8W8h1SapWmUqg5A8Lk7cb0f7hH5A==
X-Received: by 2002:adf:e252:0:b0:314:1e15:f30b with SMTP id bl18-20020adfe252000000b003141e15f30bmr1223531wrb.35.1690460814905;
        Thu, 27 Jul 2023 05:26:54 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:3cc3:939b:a917:f0a3? ([2a02:8011:e80c:0:3cc3:939b:a917:f0a3])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030647449730sm1931066wru.74.2023.07.27.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:26:54 -0700 (PDT)
Message-ID: <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
Date:   Thu, 27 Jul 2023 13:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
Content-Language: en-GB
To:     Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <20230727073632.44983-4-zhouchuyi@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230727073632.44983-4-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-07-27 15:36 UTC+0800 ~ Chuyi Zhou <zhouchuyi@bytedance.com>
> Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
> we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  tools/bpf/bpftool/common.c     |  1 +
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  tools/lib/bpf/libbpf.c         |  3 +++
>  tools/lib/bpf/libbpf_probes.c  |  2 ++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..c5c311299c4a 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>  	case BPF_TRACE_FENTRY:			return "fentry";
>  	case BPF_TRACE_FEXIT:			return "fexit";
>  	case BPF_MODIFY_RETURN:			return "mod_ret";
> +	case BPF_OOM_POLICY:			return "oom_policy";

This case is not necessary. This block is here to keep legacy attach
type strings supported by bpftool. In your case, the name is the same as
the one provided by libbpf, so...

>  	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>  	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>  	default:	return libbpf_bpf_attach_type_str(t);

... we just want to pick it up from libbpf directly, here.

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 214f828ece6b..10496bb9b3bc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
>  	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
>  	[BPF_STRUCT_OPS]		= "struct_ops",
>  	[BPF_NETFILTER]			= "netfilter",
> +	[BPF_OOM_POLICY]		= "oom_policy",
>  };

