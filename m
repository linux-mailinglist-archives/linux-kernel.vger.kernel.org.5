Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571DF774FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjHIAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHIAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:42:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231610D1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:42:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc7e65ea44so2989225ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691541770; x=1692146570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i01tCZPNe6L9U5Q4HebDp2m0Pk6TUjD+eZo+m4Fm8ns=;
        b=gtcdoSyHJhxAjQa1WvyqmpaathCr/egiED4WO3SKFud6eIw5LPxYjENlnuN2v/8pP+
         7JomdzFIf0P2WpawQxVK/R6ri5DnSGPw5O9u2GvuVV/9icqfaiRNoA8PW7mEvWUT59pq
         3/wAgET0vY3axeGQ+MZMFdDDUt5UNEVOt19vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541770; x=1692146570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i01tCZPNe6L9U5Q4HebDp2m0Pk6TUjD+eZo+m4Fm8ns=;
        b=I3Rjp2cmO4xFsCSdTYabyKii7s1QEV3Ukcxlt5hT2zsquXQxcVj1eKxTh4oM8z9i5d
         ie2LWpuzgbujZKS+xN4nhCtZo9ZJvzpJY/j05HO13nHvKU5VHplttP+zB7fIc8stfZnO
         xveCuEi+wcXqEk+bSbCXgwStf6LDw2xS/lARv2bpWYYGaur9lCz5ARJiAtZ2ouhms7S1
         nZ6KqLBaWOtoBLZKo9pOSTHbNpa84EpLzKQKlLuThX0jOjrc9qdikw9WiXVQNOm05pie
         hSFPLAA15b9zmvl22pBVAE5TWUbawe6dXnN75Zy1cjJWvWs5lFVUiJZ0YTH4957NLuY8
         NrCg==
X-Gm-Message-State: AOJu0YxXoRj5cC4lPJg5sNbTntiAqzLwLmsLj4dMlSpJ5zOf1iNgIhWO
        WYeWqkkDkxnFprICemxduKxCaA==
X-Google-Smtp-Source: AGHT+IHy3qTOPxKTcKRTqd3zRSKuJlFunxAWjvfw0+BfXbsWDF1K1YF+/1raLGejZ1cQHbGkVrHTUg==
X-Received: by 2002:a17:902:ec8e:b0:1bb:cd5a:ba53 with SMTP id x14-20020a170902ec8e00b001bbcd5aba53mr14009044plg.14.1691541769687;
        Tue, 08 Aug 2023 17:42:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001b890b3bbb1sm9631074plw.211.2023.08.08.17.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:42:49 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:42:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] um: refactor deprecated strncpy to strtomem
Message-ID: <202308081742.47A777CEF@keescook>
References: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:17:35PM +0000, Justin Stitt wrote:
> Favor a more robust and less ambiguous interface over `strncpy`.
> 
> Use `strtomem` here since `console_buf` is not expected to be
> NUL-terminated.
> 
> Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Keep usage of ARRAY_SIZE (thanks Bill)
> - Remove unnecessary import (thanks Kees and Bill)
> - Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
> ---
> Notes:
> I only build tested this patch.
> 
> I am also making an assumption that `console_buf` need not be
> NUL-terminated. Am I right in believing this?
> ---
>  arch/um/drivers/mconsole_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> index 5026e7b9adfe..d5fa9c8dcd18 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -554,7 +554,7 @@ struct mconsole_output {
>  
>  static DEFINE_SPINLOCK(client_lock);
>  static LIST_HEAD(clients);
> -static char console_buf[MCONSOLE_MAX_DATA];
> +static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
>  
>  static void console_write(struct console *console, const char *string,
>  			  unsigned int len)
> @@ -567,7 +567,7 @@ static void console_write(struct console *console, const char *string,
>  
>  	while (len > 0) {
>  		n = min((size_t) len, ARRAY_SIZE(console_buf));
> -		strncpy(console_buf, string, n);
> +		strtomem(console_buf, string);

See my reply to v1: I think this should just be memcpy(console_buf, string, n)

-Kees

>  		string += n;
>  		len -= n;
>  
> 
> ---
> base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> change-id: 20230807-arch-um-3ef24413427e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
