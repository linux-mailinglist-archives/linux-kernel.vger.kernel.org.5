Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A07D02FA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjJSUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjJSUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:04:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4F12D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so24767a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697745886; x=1698350686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHSM7lgOK3HTJKxso8W1sPPHXik4YHTdjZ5i3zqRGx4=;
        b=hVJSsOgikFx2v0hDLza9QGjIV8a6tJluJcV/pZEW9BAreZr3dBUcXEAy3rnQt/sGQi
         0db2gX+WccmzYGJP+aj0NWsgRvZgSHh3hSjVXaxZ4z3j0vyCV6pKpauW4vI1WDQGPNjQ
         lipLElDOc/SIyqkGCcFk/oO/tH/RRPL8/o7wGzlbdWg4wwH4m6yDS0ou6RP/wSULDDcw
         XDMn+1NvPWDlI5XfEQQfNccI/IjYR0cqhSrw3m97oQcbeUcUDNIfkHrz8KQtFMnrG/7z
         KYudnlhakY/Ikm8706uLWES7qUFJpX5tkeYrfj528xnocTyIrwTyb2tcOTTs9LuRMV45
         H7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697745886; x=1698350686;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHSM7lgOK3HTJKxso8W1sPPHXik4YHTdjZ5i3zqRGx4=;
        b=QJVV+M10UZsP4RsCqbZUCvJ3OQQM/MAcy5dQF7VQrMQbVM2s4ILKxgIzZPGD1lRQCI
         InucxXuYO4XRRyTzxo3Eu+0AxTsgeSPja73LmJyAWi7MVSLEUKS01DIHpNRhuWs5Ya1t
         E9NbqCSENm4OuhONZR3xqrjmRBYoHD4beCoAmIPHgNatfTJZXGm3/jvoubSdZE7Y/V0X
         9aN8iaytnPQyKgaPr5U6DZNUwYhUWUmGcm1sDw+jnJhZpA/+55cmJCQVx+y9RIESV7Eh
         r+OGqJ9Lmn0WiDQbMFo5SFZMJbM8cwjZU+VAy1w9VPX+LaDGXUSznB8ikjaoeAAV0aNH
         jhwA==
X-Gm-Message-State: AOJu0Yxo3yeA1A60SzkYuVvZl5bamvrf5z01bZMw21QxuPLXxwTRNm89
        GxV8npJocV907XZ3M6zr9myrKA==
X-Google-Smtp-Source: AGHT+IGbCrBvmsRbosyDyHhFgwB9uD9EKZDkSeQTftL9H2qEaLZcX5FXO2SKmc7h7coRIOruRtobPQ==
X-Received: by 2002:a17:90b:1d0e:b0:274:99ed:a80c with SMTP id on14-20020a17090b1d0e00b0027499eda80cmr3295469pjb.3.1697745886045;
        Thu, 19 Oct 2023 13:04:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jb14-20020a17090b408e00b002774d7e2fefsm157717pjb.36.2023.10.19.13.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 13:04:45 -0700 (PDT)
Message-ID: <e1920ac4-18ad-4b97-a3a3-9604724937d6@kernel.dk>
Date:   Thu, 19 Oct 2023 14:04:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/11] net/socket: Break down __sys_getsockopt
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Breno Leitao <leitao@debian.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>, sdf@google.com,
        asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, krisman@suse.de,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
References: <20231016134750.1381153-1-leitao@debian.org>
 <20231016134750.1381153-5-leitao@debian.org>
 <1074c1f1-e676-fbe6-04bc-783821d746a1@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1074c1f1-e676-fbe6-04bc-783821d746a1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 1:12 PM, Martin KaFai Lau wrote:
> On 10/16/23 6:47?AM, Breno Leitao wrote:
>> diff --git a/net/socket.c b/net/socket.c
>> index 0087f8c071e7..f4c156a1987e 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -2350,6 +2350,42 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
>>   INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>>                                int optname));
>>   +int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>> +               int optname, sockptr_t optval, sockptr_t optlen)
>> +{
>> +    int max_optlen __maybe_unused;
>> +    const struct proto_ops *ops;
>> +    int err;
>> +
>> +    err = security_socket_getsockopt(sock, level, optname);
>> +    if (err)
>> +        return err;
>> +
>> +    ops = READ_ONCE(sock->ops);
>> +    if (level == SOL_SOCKET) {
>> +        err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
>> +    } else if (unlikely(!ops->getsockopt)) {
>> +        err = -EOPNOTSUPP;
>> +    } else {
>> +        if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
>> +                  "Invalid argument type"))
>> +            return -EOPNOTSUPP;
>> +
>> +        err = ops->getsockopt(sock, level, optname, optval.user,
>> +                      optlen.user);
>> +    }
>> +
>> +    if (!compat) {
>> +        max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> 
> The max_optlen was done before the above sk_getsockopt. The bpf CI cannot catch it because it cannot apply patch 5 cleanly. I ran the following out of the linux-block tree:
> 
> $> ./test_progs -t sockopt_sk
> test_sockopt_sk:PASS:join_cgroup /sockopt_sk 0 nsec
> run_test:PASS:skel_load 0 nsec
> run_test:PASS:setsockopt_link 0 nsec
> run_test:PASS:getsockopt_link 0 nsec
> (/data/users/kafai/fb-kernel/linux/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c:111: errno: Operation not permitted) Failed to call getsockopt, ret=-1
> run_test:FAIL:getsetsockopt unexpected error: -1 (errno 1)
> #217     sockopt_sk:FAIL

Does it work with this incremental? I can fold that in, will rebase
anyway to collect acks.


diff --git a/net/socket.c b/net/socket.c
index bccd257e13fe..eb6960958026 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2344,6 +2344,9 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	if (err)
 		return err;
 
+	if (!compat)
+		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
 		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
@@ -2358,12 +2361,10 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 				      optlen.user);
 	}
 
-	if (!compat) {
-		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
+	if (!compat)
 		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
 						     optval, optlen, max_optlen,
 						     err);
-	}
 
 	return err;
 }

-- 
Jens Axboe

