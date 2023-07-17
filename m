Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38673756839
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGQPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjGQPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:43:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D46197
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:43:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b89bc52cd1so24849645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689608637; x=1692200637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6+2hEQHreqpO4j39Bf53XvlGBmQp6lWiVB1HdTdU/g=;
        b=b2oP1jE8bErJ3f9VkjNrG9/w9KHoPA67gGI6CbXR7rH/Jl01y7ChuNnWJL0f6rT1BX
         +adXjpZv8vDzRfAYzQUS+vjNyucQoxx9E4hxwscly+sR5L8a/lclCRHvBcgXZm7xKrwN
         nyaNN+WCLx6anqGojLvaJSicsDxGz+rwlLuLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608637; x=1692200637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6+2hEQHreqpO4j39Bf53XvlGBmQp6lWiVB1HdTdU/g=;
        b=FttDFgByFyP/cjJI5I6CA7T/lXwtHT9rU0P9WLOQsX1j0fJoeI8tbCmmW/fRotDm45
         3bW97cphuydZN8w/Wp6RKaMjqNgepEzz7+jxmmEjfgy/zkWwryEkbY0OWkq7tc46qRBy
         gGoj2IONTyISU5VHCQ0QXDAsj3tf0Ip1ZigKlflBZCuyadHQn6OulAHMOhFivMZynIqK
         b8zTMKuvlpVgMxXlvRZVFYZjta0r0tBWh4HIBNx6FFNBSQo19uoeEqDIn94CGNtv/6K3
         YT0axCsPeRSrb2BHWW2XdIZ1hlTEp/XkpoCoELijwkKKQ3cBphExtC41IVU954KF+zcT
         STcg==
X-Gm-Message-State: ABy/qLab57b8CKdv2Q+hpgIIsJ4tBj4DEDE0LwJ8cqXlk56cNVQdyLpm
        DEHdSnWm+D+REHg/MrYk0l4RcktdaCg4/iu1H/o=
X-Google-Smtp-Source: APBJJlFIrg2fYryDp0NRNFXgwlMK6zwpNMcWcDqU9Ve5BbIyflOLRuDpmVuA/Z/V49O7zwUCtd2Gtw==
X-Received: by 2002:a17:902:ea11:b0:1b9:d34d:bf6d with SMTP id s17-20020a170902ea1100b001b9d34dbf6dmr13052150plg.52.1689608636815;
        Mon, 17 Jul 2023 08:43:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001ac591b0500sm54192plb.134.2023.07.17.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:43:56 -0700 (PDT)
Date:   Mon, 17 Jul 2023 08:43:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Message-ID: <202307170826.397635AD@keescook>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:33:32PM +0300, Andy Shevchenko wrote:
> Privided seq_show_option_n() macro breaks build with -Werror
> and W=1, e.g.:
> 
> In function ‘strncpy’,
>     inlined from ‘ocfs2_show_options’ at fs/ocfs2/super.c:1520:3:
> include/linux/fortify-string.h:68:33: error: ‘__builtin_strncpy’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
>    68 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^

While I totally agree with the removal of strncpy(), I'm confused about
how this warning is being produced:

                seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
                                  OCFS2_STACK_LABEL_LEN);

fs/ocfs2/ocfs2.h:389:   char osb_cluster_stack[OCFS2_STACK_LABEL_LEN + 1];

fs/ocfs2/ocfs2_fs.h:#define OCFS2_STACK_LABEL_LEN               4

#define seq_show_option_n(m, name, value, length) {  \
     char val_buf[length + 1];                       \
     strncpy(val_buf, value, length);                \
...

the source buffer is OCFS2_STACK_LABEL_LEN + 1 long, and the dest buffer
is OCFS2_STACK_LABEL_LEN + 1 long. ??

I think this doesn't need to use seq_show_option_n() at all.

> include/linux/fortify-string.h:151:16: note: in expansion of macro ‘__underlying_strncpy’
>   151 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> While -Werror wasn't enabled by default at the time of the original code
> landed into mainline, strscpy() was already there and preferred over strncpy().
> Due to above mentioned issues, use the latter in seq_show_option_n().
> 
> Fixes: a068acf2ee77 ("fs: create and use seq_show_option for escaping")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/seq_file.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index bd023dd38ae6..e87d635ca24f 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -260,8 +260,7 @@ static inline void seq_show_option(struct seq_file *m, const char *name,
>   */
>  #define seq_show_option_n(m, name, value, length) {	\
>  	char val_buf[length + 1];			\
> -	strncpy(val_buf, value, length);		\
> -	val_buf[length] = '\0';				\
> +	strscpy(val_buf, value, sizeof(val_buf));	\
>  	seq_show_option(m, name, val_buf);		\
>  }

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
