Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF77C46A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjJKA2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbjJKA2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:28:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B2D48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:26:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so5603544b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696983979; x=1697588779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mdeBYmV3Iz7hBYw8oNEhI6gNWC/shNZ9/fkqlI8Fj8=;
        b=bnV0DCKRefmUflgQkyrxnItazRMUPu2M/q4DavlYFLSJpv4A6TY0xfGRZILJL4cEp0
         hW+5uRIMxBve2WrifzvRT1uu7Pcx+B/GrgCK6ZuavfXuUvrHNYViwgJ3TeH0pM/+ZmJL
         DZ8NFVAidbb3qtjdNiviQbwvY8hRBg/5jzeRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696983979; x=1697588779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mdeBYmV3Iz7hBYw8oNEhI6gNWC/shNZ9/fkqlI8Fj8=;
        b=DX5x67So7NHAKbfXEW8lj5LjFyCVU0VmLryjdA76vP7tcZ0VT72T2MAdpSoplKpPok
         R8Ymcg+HSe8Keo4oBrC8RLjdbBa7NvNiThW7spSU3erl21vSCxmOKYpyRfZlYH/vnHU7
         fG1E6IBl3NzwETjvmku4Cu+LB1ZybMcx+Iv/bmIgnEDwEyIWEB7bCvSlwXu+NzOHeqYJ
         cejPxiaOqJ60/He+YaVvKTr2/l9IsIOjYZqxgOci/YieCJvznd3ZLGegCWMsQqPsEzrN
         vHR9kJijcezWFZJrgPvFORvhIQi4Xvfx5lWLmJynmlEoslnN8uKaY0QQt7nZPHW7JqsH
         LFtg==
X-Gm-Message-State: AOJu0YwyLuOPqmFIOEOSsnVNWAcd853lTYIcJnaYpcgbnb257dVFnvSI
        AxDrhR56AupWvhdHCV7dPm6UnQ==
X-Google-Smtp-Source: AGHT+IGbQurWzUeSrvjJAXJayp/LYxys+6GCRaoM5udwyGZn8Yl6aR5Ironz9eErZ12xTuOTAdhVog==
X-Received: by 2002:a05:6a00:b52:b0:690:15c7:60d8 with SMTP id p18-20020a056a000b5200b0069015c760d8mr25141187pfo.22.1696983979003;
        Tue, 10 Oct 2023 17:26:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a63bd09000000b005891f3af36asm10776300pgf.87.2023.10.10.17.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:26:18 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:26:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, luto@amacapital.net,
        wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [PATCH 4/4] selftests/seccomp: Test SECCOMP_LOAD_FILTER and
 SECCOMP_ATTACH_FILTER
Message-ID: <202310101725.0BCB9CBA9@keescook>
References: <20231009124046.74710-1-hengqi.chen@gmail.com>
 <20231009124046.74710-5-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009124046.74710-5-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 12:40:46PM +0000, Hengqi Chen wrote:
> Add a testcase to exercise the newly added SECCOMP_LOAD_FILTER
> and SECCOMP_ATTACH_FILTER operations.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 38f651469968..8f7010482194 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -4735,6 +4735,26 @@ TEST(user_notification_wait_killable_fatal)
>  	EXPECT_EQ(SIGTERM, WTERMSIG(status));
>  }
>  
> +TEST(seccomp_filter_load_and_attach)
> +{
> +	struct sock_filter filter[] = {
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog = {
> +		.len = (unsigned short)ARRAY_SIZE(filter),
> +		.filter = filter,
> +	};
> +	int fd, ret;
> +
> +	fd = seccomp(SECCOMP_LOAD_FILTER, 0, &prog);
> +	ASSERT_GT(fd, -1);
> +
> +	ret = seccomp(SECCOMP_ATTACH_FILTER, 0, &fd);
> +	ASSERT_EQ(ret, 0);
> +
> +	close(fd);
> +}

This is a good start -- please check all the error paths as well.

Thanks for continuing to work on this!

-- 
Kees Cook
