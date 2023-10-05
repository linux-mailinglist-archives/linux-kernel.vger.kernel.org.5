Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66157BA4DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjJEQLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjJEQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:10:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298FE77646
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:52:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40651a72807so11007665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1696521119; x=1697125919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdR507v84ynzbbbrnyTkvWO66sR0xlxPmXVVX+8i0QI=;
        b=Pl3cN9MsVGNPLiFbR6w/iDRe6xEr0TaKdpDoRwtzDM47zYsic+d162dnoyLygfzoBQ
         UuTE7NpONEKK+uZ6F/guLHQh3GnoB8ffErFFyZF2K0JfDP7cLeHicSgAcOnsOXxS7Kw9
         8n/SL1c/tRtwvructt41JQ/A4snjQ3CGPs0BlZ1MMOLNNF9NhAaKHD6UBYUb78NJ/IHu
         zlLOcytmHgcg1XRLVeD+usBbXKVgEmlgFwGZ9nar6SV2uhwNwzhkdDY+yY6yrUBQsEbX
         +xP1MN6w8uW1r4gFQnAA7iTwwArIpi5jhi2ylj8j42H2DHvYwayo53SKd/AGNWyHhePy
         vv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521119; x=1697125919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdR507v84ynzbbbrnyTkvWO66sR0xlxPmXVVX+8i0QI=;
        b=CbDtm1Fy9Y/T3cWT/eKnzqPg8L4iFVLq8vuOyYnYLxm2VPkZduBvgVWa5H1C3WNpC3
         6y9F7aesTh78tdwfdWM4HI+mrV1+FJdVDm3CJEKdK2k/KHedd5bzY1pTiD4HSpJzwzhB
         JZeY6kujghPVuP2EdWXSHl3gXD2Elob9kqbrcQFFLGGVCpnTlOnY3k7q2VKn7hCY9lQP
         LVgCfI4tKGPurgFga3E1N+1YFDkpD8S1yTyAle7Ijw04JFiutXmpnaMwSqd4dWx7Bj8C
         LUVi/z6Bx9l2TnntX2UbtfxAOBCqwszLf3ciOqFNntjqJ5FzeiihjwN39v+Je3WNLCWg
         WYYA==
X-Gm-Message-State: AOJu0Yxq7ALHmRvafyWOQeHS4vHC9sEfvyJUqq6thu8i4IX2aW8afUnv
        4hM1VW8Rf4UD6N6k0RUGsqlFkQ==
X-Google-Smtp-Source: AGHT+IGnEnri9Nw/YTtsWQie4mWourjTILQ6w6qzEQFVo4XB/HXDHw8IvL0i/DCmKK3shoH1ejDHJA==
X-Received: by 2002:a05:600c:214f:b0:405:4002:825a with SMTP id v15-20020a05600c214f00b004054002825amr5211051wml.13.1696521119378;
        Thu, 05 Oct 2023 08:51:59 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5? ([2a02:8011:e80c:0:4a49:8ee5:5e5c:cfd5])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b004013797efb6sm4070767wme.9.2023.10.05.08.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 08:51:59 -0700 (PDT)
Message-ID: <888bde30-a61f-4b19-bb6f-0aec69f23415@isovalent.com>
Date:   Thu, 5 Oct 2023 16:51:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] bpftool: Align output skeleton ELF code
Content-Language: en-GB
To:     Ian Rogers <irogers@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
References: <20231004222323.3503030-1-irogers@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231004222323.3503030-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 23:23, Ian Rogers wrote:
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
> 
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks
