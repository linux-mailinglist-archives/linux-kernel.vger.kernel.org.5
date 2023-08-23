Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C99785EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjHWReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbjHWReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:34:44 -0400
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E46E7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:34:41 -0700 (PDT)
Message-ID: <d2687e08-8c67-8eb9-9764-8fcc014d8de4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692812076; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6y2PSpf0KklCK/x1vlL2IxP2CNYUVfAedkT44SDp2U=;
        b=OI7gMP12Vgp+jaCERsVFW05Bk8n4xKzIocqn+mVIZV43JGFqZ1uZjEZ6auM1z1sEz8jbgs
        uE08blO7QM4iRX6l9ye2D9APeH0hLjBtqd08DQLabTrBwse8Ory3qgCm+aqDOCue+YjNKn
        POW9OcUCmO+eHOtBNYey9ogRU+R758g=
Date:   Wed, 23 Aug 2023 10:34:28 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Enable cpu v4 tests for RV64
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Pu Lehui <pulehui@huawei.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-8-pulehui@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230823231059.3363698-8-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/23 4:10 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Enable cpu v4 tests for RV64, and the relevant tests have passed.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Thanks for working on this!

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
>   tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
>   6 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> index 916d9435f12c..67c14ba1e87b 100644
> --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> @@ -5,7 +5,8 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
>   
> -#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86)) && __clang_major__ >= 18
> +#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && __clang_major__ >= 18
>   const volatile int skip = 0;
>   #else
>   const volatile int skip = 1;
[...]
