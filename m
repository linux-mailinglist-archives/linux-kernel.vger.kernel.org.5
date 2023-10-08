Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6118B7BCF59
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbjJHRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbjJHRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:12:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB67B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 10:12:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69101022969so3396581b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696785124; x=1697389924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdDGhksNk+95G2Rk4jqSpCJbRS1WE04e+7m7Uoe1Ug8=;
        b=dBZytdHto7KRrS97jg4yn4uuKIm8AXHZ90ml0A9czb7D4Q1uM5+9OS7yqh1btoOXSQ
         QQp4VRrwNVKaRQl09RE/cn7Tl/P2DIAaUe8Tz/4v2LsmfvZZHnJ2Ibvw8kARoJfA8j2w
         v0xZnzdobwun9wI3rt551hG6Iv83Hv/MZzdB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696785124; x=1697389924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdDGhksNk+95G2Rk4jqSpCJbRS1WE04e+7m7Uoe1Ug8=;
        b=Nh3rG+9OolIuuTnNEqNkZpsnPFP+lOBgOgGK3jq2ceyA03avAbba+wpvYJE6+0vq97
         VU+xrarMzo5UomKrwa0I0jMAPCzCVO18B7hUNEO+rgqaPoTzEAQS5sPo68tkBhyTGHqb
         GycUy1I1tHFr3AspwveqLwDObgrPT9z/D1f3sWKXR2AvJ6b8mL4khlmh99J0wyBRFytx
         GPH0r3CPLbSAp5p2Hr8ZmeBNORlrwcs3PjzDqvI9y2EFg/fkcJHpQw7XXu4ei69poncW
         ixQScIslF4UQ3e2yXkacgGl0pIS7aXCDTL2QhFFH+dkdivYsiGVazHMphsYMZZafSa5J
         tdzg==
X-Gm-Message-State: AOJu0Yy3ZWRgkfNj0A+VeY+nWJF0rtJA9aOK4QBeeFTtuJCj7a+FcW7n
        l4oHDbaNQt/36N5ORtxTVKvmNQ==
X-Google-Smtp-Source: AGHT+IHHu6wejYufFLWQOKaw9Sok91yvolc0x+XXaNMoZPSzMAJuU/9qzMAG/BoOfXai94GB8wgegA==
X-Received: by 2002:a05:6a00:39a6:b0:690:fa09:61d3 with SMTP id fi38-20020a056a0039a600b00690fa0961d3mr17059096pfb.15.1696785124399;
        Sun, 08 Oct 2023 10:12:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k22-20020aa78216000000b0069337938be8sm4748906pfi.110.2023.10.08.10.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:12:03 -0700 (PDT)
Date:   Sun, 8 Oct 2023 10:12:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] VMCI: Annotate struct vmci_handle_arr with __counted_by
Message-ID: <202310081009.045F3E99@keescook>
References: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56bef519d982218176b59bbba64a3a308d8733d5.1696689091.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 04:32:34PM +0200, Christophe JAILLET wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a work done in parallel of what is currently worked
> on by Kees Cook.
> 
> My patches are only related to corner cases that do NOT match the
> semantic of his Coccinelle script[1].
> 
> In this case, something similar to struct_size() is implemented in
> handle_arr_calc_size().

I think this should likely lose VMCI_HANDLE_ARRAY_HEADER_SIZE entirely
and the helper to use sizeof() and struct_size() directly, but probably
as a separate patch.

> 
> Note that I'm slightly unsure on how things will behave in regards to the
> krealloc() in vmci_handle_arr_append_entry().

It looks correct to me:

                new_array = krealloc(array, new_size, GFP_ATOMIC);
		...
                new_array->capacity += capacity_bump;

i.e. "capacity" is adjusted up before accessing any "entries".

> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> ---
>  drivers/misc/vmw_vmci/vmci_handle_array.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.h b/drivers/misc/vmw_vmci/vmci_handle_array.h
> index 96193f85be5b..b0e6b1956014 100644
> --- a/drivers/misc/vmw_vmci/vmci_handle_array.h
> +++ b/drivers/misc/vmw_vmci/vmci_handle_array.h
> @@ -17,7 +17,7 @@ struct vmci_handle_arr {
>  	u32 max_capacity;
>  	u32 size;
>  	u32 pad;
> -	struct vmci_handle entries[];
> +	struct vmci_handle entries[] __counted_by(capacity);
>  };
>  
>  #define VMCI_HANDLE_ARRAY_HEADER_SIZE				\
> -- 
> 2.34.1
> 

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
