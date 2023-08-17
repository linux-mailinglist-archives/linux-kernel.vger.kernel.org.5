Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4128377FC65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353773AbjHQQze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353816AbjHQQzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:55:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F32D5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26b51d4c985so2840135a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291323; x=1692896123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8llPZ+qxlgNzlRp0B9M5wdmj0W8bnJMDksdaqRhUBE=;
        b=YawcbNyYYnvjNBYD+HILcUHRjqLAr2TlnBBW8usY5K7CtuQa/5DlIqUpZHR+6ol4C9
         5sQL0xeUvPjghp3ozsfduSGSrg8lMmGuLMu1DPJgXrrCnanX+fJx+e/YdbNloohVyT2H
         yk0f6g7nmjDQwGZjFiGm3kJFprlhVfRFzWYn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291323; x=1692896123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8llPZ+qxlgNzlRp0B9M5wdmj0W8bnJMDksdaqRhUBE=;
        b=eKAHZ7Va9d0bWP9puucEiVjqZyU4S8BPZCGXhgOnatPrrRIyzcnXGxOlq4HPixPJTe
         cewK0SERakk1lm0AmzVGP5sfIbik8MhkbUHgf2u87f1n3+4kEtOeut5978yjvKyVvz5n
         hYcPo2cnfN5vrSfy5z2iNUP/qahugNcNDOyTR/LBTw2ZNdP+uED8Snt3FsQaT1VAOBir
         fzAFszt8gKZiloAJu0hDH+fyDs6TCdy3Av0F6YUIotvBd24PaIvjdc5MG8VXUp5BmhHw
         DCH98I2Bl1bso9s+8qufJsoZpmKov1+6AjEkhMHrB27G2Z4I+XQzZ6IxWouTFduBIgW0
         UDjA==
X-Gm-Message-State: AOJu0YwcRBAEuG5rRlPNhUZanq5Q/dygecKn+eggDu3eMj3a6I2VTHZH
        XYcbS+Y5Zt1rcEHhR0RD8NWkSzQQ1ulHSzFMhYM=
X-Google-Smtp-Source: AGHT+IH5wvBkfktFmJO8os+LqrwPdXSoQAnAih4GmxYrMQmYIoIP8A+YdeDd6zDTuXXCkRcTtteVrQ==
X-Received: by 2002:a17:90b:230d:b0:263:3386:9da8 with SMTP id mt13-20020a17090b230d00b0026333869da8mr3965511pjb.49.1692291323346;
        Thu, 17 Aug 2023 09:55:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b00263b9e75aecsm26796pja.41.2023.08.17.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:55:22 -0700 (PDT)
Date:   Thu, 17 Aug 2023 09:55:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
Subject: Re: [PATCH] lkdtm: use the return value of strim()
Message-ID: <202308170954.B18CCA9@keescook>
References: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 10:21:17PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> Make use of the return value of strim() to achieve left-trim as well as
> right-trim, which prevents the following unusual fail case:
> 
>  # echo " EXCEPTION" > /sys/kernel/debug/provoke-crash/DIRECT
>  sh: write error: Invalid argument
> 
> Link: https://github.com/KSPP/linux/issues/337
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  drivers/misc/lkdtm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 0772e4a4757e..812c96461ab2 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -242,7 +242,7 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
>  	}
>  	/* NULL-terminate and remove enter */
>  	buf[count] = '\0';
> -	strim(buf);
> +	buf = strim(buf);
>  
>  	crashtype = find_crashtype(buf);
>  	free_page((unsigned long)buf);

Will free_page() still work in this case, though? The address won't
match the allocation any more...

-Kees

> @@ -318,7 +318,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
>  	}
>  	/* NULL-terminate and remove enter */
>  	buf[count] = '\0';
> -	strim(buf);
> +	buf = strim(buf);
>  
>  	crashtype = find_crashtype(buf);
>  	free_page((unsigned long) buf);
> -- 
> 2.25.1
> 

-- 
Kees Cook
