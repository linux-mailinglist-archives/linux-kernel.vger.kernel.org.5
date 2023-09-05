Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BA792CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjIERnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjIERma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:42:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD83EDC3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:21:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso1515166b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693934391; x=1694539191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhofM3bw/D7JmLHAqAOlbfqpJqObIGkow5TCG1+iH+E=;
        b=ySyp72u+Q8Uds/M4sd6BWAAw4gFXAMy7BQtgWnhBprPBMDsDLC30pPdFl2LQ6a6p1Z
         xcRJT6yBt6bO25atJctms6eHxJIdkLbcfyHLiJTZYyqJA/wXBjjhi2jR83cTKJyQ3aOZ
         GozpbjvWvtfrX+14CXx71izY8Y6YMCti+6heVC9hZKJmLKgVbE1rQFkYehSq6y2tZvTQ
         ccz7drKXc1dQvMavRpjvR3691jit1QdL9vi7Qn4cCUQrvqW+AX7oHPmXKXyVQKo7QCGS
         EPzPKXELa5yh/EKxuDJ7ZTlitEc/AEb2ESxHiEppOMTj94ZfAgF+BA/CyDLYdq9fp6Rl
         OWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693934391; x=1694539191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhofM3bw/D7JmLHAqAOlbfqpJqObIGkow5TCG1+iH+E=;
        b=JQ8vIAO7IFLSvuYj5YGJKKiWSSdI9QpvoaxMc0BTDN6vrKUNzL6ri+7bgldiWKDxrL
         kQHv65UXLrv3mD84tz2PsgrdCvHYXvisy4dOLOtJ2DSJM7mr2OGqEdhdzknptSqS5cCG
         BquFfhqpmafXNsCidFiN7+aRWkiVZWuUgGnV0yn1gN+UuR8WvVQzj0IIMDBJZaQwEQ7G
         9OY/tJNVtmsw6qUXLmiH08PjAxGax+ew1SdGKkdhgJLgzk6UOYXehcxuxGp9Q4ooCDFb
         5hzGi4FWoTLTexfjeJzxbkRFsdQOnfWD8Gf1x/UqTjy3xpZJzke+KfvvDtue8UxYhRj1
         fY0Q==
X-Gm-Message-State: AOJu0YxIMp0MAU32COrOVxI3FVx8spueyaazumMCfwOOFyixHJfDkPwD
        g/kazB0uU1Jfx4h51D3Rb/4o8A==
X-Google-Smtp-Source: AGHT+IH2ivAZ9iS1818zKelhz3wBhZbxoKMEE8BbGKoPj91HSOz21S6fFF52/HYoHSuAyRzbHDCxig==
X-Received: by 2002:a05:6a20:9183:b0:14e:3ba7:2933 with SMTP id v3-20020a056a20918300b0014e3ba72933mr13666725pzd.54.1693934390760;
        Tue, 05 Sep 2023 10:19:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902744100b001bb988ac243sm9532247plt.297.2023.09.05.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:19:49 -0700 (PDT)
Date:   Tue, 5 Sep 2023 17:19:45 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binderfs: fix typo in binderfs.c
Message-ID: <ZPdjMXdDBxYRwNA7@google.com>
References: <20230903204250.2697370-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903204250.2697370-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 04:42:50AM +0800, Kuan-Wei Chiu wrote:
> The word "wich"
> was corrected to "which" for spelling accuracy.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/android/binderfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 81effec17b3d..ae2a8413ec12 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -93,7 +93,7 @@ bool is_binderfs_device(const struct inode *inode)
>  /**
>   * binderfs_binder_device_create - allocate inode from super block of a
>   *                                 binderfs mount
> - * @ref_inode: inode from wich the super block will be taken
> + * @ref_inode: inode from which the super block will be taken
>   * @userp:     buffer to copy information about new device for userspace to
>   * @req:       struct binderfs_device as copied from userspace
>   *
> -- 
> 2.25.1
> 

Thanks,

Acked-by: Carlos Llamas <cmllamas@google.com>
