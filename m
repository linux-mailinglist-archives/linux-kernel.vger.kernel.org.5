Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B37CA745
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjJPL53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjJPL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:57:26 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E1101
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:57:23 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57de6e502fcso2640197eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697457442; x=1698062242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dXhQiW3CeLcA8j0HpKT5tW5ghtUshlNGr8srK7/YcI=;
        b=Uqxhkj0PiVlsQfe0MNmXz89pM3r5zOsGgOSqamMLP4d9QehQsruA8An/QNx9ERDMPT
         46QcwYs0+os/MoSEj+9Tc2jepT1okz02GljozN28YV9pwN3Q11HxZiugwX16/zWoegoX
         3O9fyXAnG1HkG00FAm6/6CIaXYSB8IAXJrlkVBWF4kDaYnFb8ohPUWRUsQgYqf/8h/uL
         18yUzJtqLHxUxc2Tk2EGmGIb4sRcYFTN2y6JPJqghdTdMzMFE0XbvHPOGXZF0qdrKryi
         iIWIXFdqejzAsjsATo92U4eGAlARNVw7PBer0uFMVqkwl55HDrmA8KVlVvjcaYypslGi
         Priw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457442; x=1698062242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dXhQiW3CeLcA8j0HpKT5tW5ghtUshlNGr8srK7/YcI=;
        b=GJUg5Mb5P6IPZMYB5Azh40uH9VLTK5CiD+noJc+1Ld51TLcKGOcLUlkqfE3E5q5Czd
         Ge/KQykc1RLOQtV9nloJ8M40beKTktx7d3rZP6FzjisGXklbLgr77DOEEJVsLrrrazhE
         MF2HNDPktm0sOxE2jsF2HGl/ODG8rI4W/1ZTLCQUBx7UBS3dw/qV63lXSTr0K8ED6w2C
         6ojALaX9OYu3Z92pKUtPd4Plpe5qFK4hH53qzxnCLRGsa0qA/F5Q5SMWcU9KECSMW75T
         EejieoSDRTFoBmuaVMWTLodfaLFmAzLFamQAETmUw3bmciFrkLTYnHjGVC+ospFbhwnq
         +v1A==
X-Gm-Message-State: AOJu0Yw2jwoBTDDuBEwl7JHfTdJigKRKwzACeb4Pa8Qh76GBkN9Vb2aE
        axO1ue+SjxW+A4/aTtYBOdWWamcX8unPs/IhkRES4Q==
X-Google-Smtp-Source: AGHT+IE/2U4L2nHv4HRjfKmaGiJe500WFnQxdJcQ546ojINbjt2vjRSSjqWYcdaSEk+sSfNF8wu8Kw==
X-Received: by 2002:a05:6358:4327:b0:14f:6a41:5d14 with SMTP id r39-20020a056358432700b0014f6a415d14mr42820220rwc.27.1697457442436;
        Mon, 16 Oct 2023 04:57:22 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id x23-20020aa79ad7000000b006bdfb718e17sm2424805pfp.124.2023.10.16.04.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 04:57:22 -0700 (PDT)
Message-ID: <60ab339a-3029-42db-97cf-d8574d05e789@daynix.com>
Date:   Mon, 16 Oct 2023 20:57:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Use pkg-config to determine ld
 flags
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Nick Terrell <terrelln@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231015133916.257197-1-akihiko.odaki@daynix.com>
 <062d9a75-caa0-d05d-14db-cd59dafab8b9@iogearbox.net>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <062d9a75-caa0-d05d-14db-cd59dafab8b9@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 20:39, Daniel Borkmann wrote:
> On 10/15/23 3:39 PM, Akihiko Odaki wrote:
>> When linking statically, libraries may require other dependencies to be
>> included to ld flags. In particular, libelf may require libzstd. Use
>> pkg-config to determine such dependencies.
> 
> Is this not covered via -lz or is it that the name differs?

libelf may not only be linked with zlib but also with zstandard.

> 
> Anyway, this change breaks selftest build for BPF CI (see below), could 
> this
> either be made optional or detected differently?
> 
> https://github.com/kernel-patches/bpf/actions/runs/6524480596/job/17716170021

I sent v2 (I forgot to add bpf-next to the subject for this).
This version implements a fallback just in the same way done for 
HOSTPKG_CONFIG.
