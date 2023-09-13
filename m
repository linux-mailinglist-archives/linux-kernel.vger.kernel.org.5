Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58279F22F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjIMTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjIMTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:36:40 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB591
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:36:36 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34f17290a9cso251425ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694633795; x=1695238595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=600gHmPTU+Trd8NzTTpGSeg9Z9knkVYO4N8Fmwu8qxw=;
        b=GmXeNZItd0tblgxPYbW4mYF7KRlghXHUXTf12uNOu1EDYoeV1HzaHmUIxYqkxC06W4
         givmVINMTqiHvdBacoZK9T4sPbmrW20FmqC6tTKacGdZeExDTlbAc5L/r4H/nNoJNhwx
         UfBQZ6ED9Ufmumm+GdT1rcW4bjrIOMeY+Oq1kOrIXHsltTibFVeTeAEkFrAWgNNUHZeJ
         /obABc2rO4fMP10hMbnqTmISB4YtV8yxQom2qt/JAstogPTi2f0c0u5TRbdUTqjhNOPP
         +6bsxucqGz2FfzM0p2s7Ycsnd+IW6/9TaqMR3UxSoNQQeMonVCGey/B47vydDIiUzydE
         77IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694633795; x=1695238595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=600gHmPTU+Trd8NzTTpGSeg9Z9knkVYO4N8Fmwu8qxw=;
        b=qJzpUvWAyilToJ91GZxxRHSJw9bRU1jCTFEsXMPehmb/jkOmkvXXT7+hiu4RcBoMU1
         tJfC2jtTr7TkHfjgAQiPNWskcjfd0FQ8FIIGdKWv/Tt+dzmL68N7xErMyUWw2Np0h1dP
         aeS9Qea6UDaQ7ntqvMi4FVDA9lGO6XdTIaRd+FlCYvZHcgAtvcA9cyYl6+9egIXQsjRI
         h5IUFJPO7OXIvqqTKvctUkb1qLhZhko7+D12mntZpU6Rn7WClI5AKlZuek+UJyc3CbV6
         INZbM0r1S6vdPOza/Yj/RIEVUVYKWPQogDErdEPDrwiBxwlYTj4L9kEf+/d2+7DcWhEh
         etlA==
X-Gm-Message-State: AOJu0YzGdJbQ6F91E+4BIQV+Tu2tbcr8PxUktUjAlmpTfyR7RfAuJc/C
        SB8pfblFzNT0afimggzSx2f+hA==
X-Google-Smtp-Source: AGHT+IGgRX/b5xTJitTFmH9tPbgOWBI8DW1+WaDRnd9O3BLjGFsQ1GF/JUHKQWRSykFB1nAj1cY/qA==
X-Received: by 2002:a05:6602:488f:b0:792:8a08:1bf9 with SMTP id ee15-20020a056602488f00b007928a081bf9mr3529973iob.0.1694633795603;
        Wed, 13 Sep 2023 12:36:35 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o26-20020a02c6ba000000b00433f32f6e3dsm3659503jan.29.2023.09.13.12.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:36:34 -0700 (PDT)
Message-ID: <d606f285-a31f-4b36-a7a9-bd913e1b0836@kernel.dk>
Date:   Wed, 13 Sep 2023 13:36:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] io_uring/cmd: Introduce SOCKET_URING_OP_GETSOCKOPT
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, sdf@google.com,
        asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, martin.lau@linux.dev,
        krisman@suse.de
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20230913152744.2333228-1-leitao@debian.org>
 <20230913152744.2333228-7-leitao@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230913152744.2333228-7-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/23 9:27 AM, Breno Leitao wrote:
> Add support for getsockopt command (SOCKET_URING_OP_GETSOCKOPT), where
> level is SOL_SOCKET. This is similar to the getsockopt(2) system
> call, and both parameters are pointers to userspace.
> 
> Important to say that userspace needs to keep the pointer alive until
> the CQE is completed.

Since it's holding the data needed, this is true for any request that
is writing data. IOW, this is not unusual and should be taken for
granted. I think this may warrant a bit of rewording if the patch is
respun, if not then just ignore it.

> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 5753c3611b74..a2a6ac0c503b 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -167,6 +167,19 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>  
> +static inline int io_uring_cmd_getsockopt(struct socket *sock,
> +					  struct io_uring_cmd *cmd,
> +					  unsigned int issue_flags)
> +{
> +	void __user *optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
> +	int __user *optlen = u64_to_user_ptr(READ_ONCE(cmd->sqe->optlen));
> +	bool compat = !!(issue_flags & IO_URING_F_COMPAT);
> +	int optname = READ_ONCE(cmd->sqe->optname);
> +	int level = READ_ONCE(cmd->sqe->level);
> +
> +	return do_sock_getsockopt(sock, compat, level, optname, optval, optlen);
> +}

Personal preference, but any other io_uring generally uses the format
of:

	bool compat = !!(issue_flags & IO_URING_F_COMPAT);
	void __user *optval;
	int __user *optlen;
	int optname, level;

	optval = u64_to_user_ptr(READ_ONCE(cmd->sqe->optval));
	optlen = u64_to_user_ptr(READ_ONCE(cmd->sqe->optlen));
	optname = READ_ONCE(cmd->sqe->optname);
	level = READ_ONCE(cmd->sqe->level);

	return do_sock_getsockopt(sock, compat, level, optname, optval, optlen);

which I find a lot easier to read than bundling variable declarations
and reading the values into them.

And I always forget that cmd->sqe is a copy for URING_CMD, which makes
this just look wrong as they should've been read at prep time rather
than issue time. But it's fine!

-- 
Jens Axboe

