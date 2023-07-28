Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5D766229
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjG1DBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjG1DBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:01:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CAB2139
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:01:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-687087d8ddaso681005b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 20:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690513289; x=1691118089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjkE2QJp5YH+tCDyB0wLIw4y8EiW40HSc+cEgR5MCMk=;
        b=VvmisaMdxgMcf35NZKkxzBIEMm+XzGMyWPTURum1qlM6CdtFVFyFOTvgV8PL/UH4j4
         pYW/vUMdOu9tmmkIP9nurlgZFpmnV+Sf8Q+ZXrS9g5r/esBK2irTxDtUbssJ1kxqpSi7
         Z3Db1fyODX9ZfulI2m/gJ93B6U1o2WboemrLKTVm7MlPdhncKvuUdySAzvvX5VQDQ+OO
         lsz7Ak8PIVB0y4ziEEJB1WpjZ7pvN24rcU8Z9DvLL7QjoiFEFzdPP+Qk7NlKhOKSttEM
         OadyR10+iztUXbqtwZMeH654pslG5H9mofHiZUTTfW0BsB34JHkCJLqk3oCFzQC1fVtF
         p53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690513289; x=1691118089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NjkE2QJp5YH+tCDyB0wLIw4y8EiW40HSc+cEgR5MCMk=;
        b=Nf/Js5wyml4e/SwJzQNfs8yxrZrkztuhUWImmUFB7bQlxSNMH2IsgiQocVvf9GgZ/B
         Kig7HM2bRUKpj1yd3I7Dd2w4dtv6B9nXX+CiEWN9La8CiluLPGxAznckGhK2oCF/4x0n
         V1cfHjz/QsU8VX87nWfZ/Wv0+5d/ymV7UWUs/q+6oWFMyka6sbIo9romkXvbTbdfVJju
         BKUPEn0DJZzlj3UFshb3jQ1rUF51Y5tR7smzedyZBilzkk99yp6rEwfPMSxqxs1IabCG
         YYPFYkQqtjOEK3Z5rn4JNqpmi2a7Xnv300WOg5a1ll55KjmzBmcDtunZJOOs0n5zrpi1
         bxEA==
X-Gm-Message-State: ABy/qLbx6ikAotY8yRyjCgYjZHasbIXspAc+MvveP28WvjdAvZc+M6oC
        BvAbDq+lAAPUeGQRqGoXgOpiXg==
X-Google-Smtp-Source: APBJJlE05KfBrHKqDjjmITmxgRbYb1H+7HaT32afOJNe6AQWDwQnF+KrC+py8os6ykbDJb7DHE7RTA==
X-Received: by 2002:a05:6a00:2353:b0:668:79d6:34df with SMTP id j19-20020a056a00235300b0066879d634dfmr698433pfj.23.1690513289499;
        Thu, 27 Jul 2023 20:01:29 -0700 (PDT)
Received: from [10.85.117.81] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b00686a80f431dsm2130125pfo.126.2023.07.27.20.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 20:01:29 -0700 (PDT)
Message-ID: <16326cd3-376b-4d08-409e-e64f43f848af@bytedance.com>
Date:   Fri, 28 Jul 2023 11:01:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
To:     Quentin Monnet <quentin@isovalent.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
 <20230727073632.44983-4-zhouchuyi@bytedance.com>
 <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <b22038a1-d06f-8bca-57f1-cc8da84a8fca@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/7/27 20:26, Quentin Monnet 写道:
> 2023-07-27 15:36 UTC+0800 ~ Chuyi Zhou <zhouchuyi@bytedance.com>
>> Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
>> we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   tools/bpf/bpftool/common.c     |  1 +
>>   tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>>   tools/lib/bpf/libbpf.c         |  3 +++
>>   tools/lib/bpf/libbpf_probes.c  |  2 ++
>>   4 files changed, 20 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
>> index cc6e6aae2447..c5c311299c4a 100644
>> --- a/tools/bpf/bpftool/common.c
>> +++ b/tools/bpf/bpftool/common.c
>> @@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>>   	case BPF_TRACE_FENTRY:			return "fentry";
>>   	case BPF_TRACE_FEXIT:			return "fexit";
>>   	case BPF_MODIFY_RETURN:			return "mod_ret";
>> +	case BPF_OOM_POLICY:			return "oom_policy";
> 
> This case is not necessary. This block is here to keep legacy attach
> type strings supported by bpftool. In your case, the name is the same as
> the one provided by libbpf, so...
> 
>>   	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>>   	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>>   	default:	return libbpf_bpf_attach_type_str(t);
> 
> ... we just want to pick it up from libbpf directly, here.
> 
I see..

Thanks.

--
Chuyi Zhou
> [...]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 214f828ece6b..10496bb9b3bc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
>>   	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
>>   	[BPF_STRUCT_OPS]		= "struct_ops",
>>   	[BPF_NETFILTER]			= "netfilter",
>> +	[BPF_OOM_POLICY]		= "oom_policy",
>>   };
> 
