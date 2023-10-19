Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4567D0541
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbjJSXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjJSXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:06:49 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E1136
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b68556d6dso133123eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697756806; x=1698361606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=DwCEvpeVXUfGsrXy6P4VMnQCCoM292F1h7bdgP+n7MoI+9Ue8H61cfhk1B55UBGPHo
         DvpAImZ7KWlgAecQHVASQ3q3ow+k5QBeOk90BwbGJJfr8QA0mD86ww7w0jqG0OC++nzM
         s/yQEVEi9sYbgJQ53lvOwMT7tpvA2QvCIe5FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756806; x=1698361606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n3bce8Qxuu7Ba2jFaCFgRD9TCUV2s+7y/RFVwamEpU=;
        b=vWoWKBJPIEmRgTDb/sHIrXIJbwn1dntChge6D+GYVi8wm1Y0d/vlrPQknsgPPjFSU2
         9zusVlC7NjkaDI4ok3fzT3xgCm2r81qtwmgBB8bi2eDkn8uOxCFKYBLxMkSHvxs8S9dB
         w10RbP5zyTJ4SSKU6bF48HzN8JvFDkb4UXujZV7cWjxajDt/ICWVhMBCaUVEvsvRLH6f
         SO9rAWBKVs0sYpZgL/6GvFSH+J8aCB/h94xLab9aXjJkeeMDilNmaziUH3q3KrIPb7Iw
         jAMNdRp63XVcgTk0iUoaZnd/K/WDygoXvINUFCVjHIpjBdhFlQbK+iIDW/kLowVcJOKr
         cR4A==
X-Gm-Message-State: AOJu0YwWYo438WFmKkin4oqpTfoanrP66xM5qRHdDNCliiMlT9jkXLs9
        XaMWbdWQWqe2DjrHbXEP0iqnMA==
X-Google-Smtp-Source: AGHT+IEhvEBOypzhBvUEC/LxnmQewUkvilNgMww7+1gCzs5lO9zQ2TaPhZ4dkppEJNjjFdom5AnCAg==
X-Received: by 2002:a05:6358:e4a0:b0:166:f18e:e60 with SMTP id by32-20020a056358e4a000b00166f18e0e60mr98593rwb.7.1697756805783;
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7950d000000b0068ffd4eb66dsm301234pfp.35.2023.10.19.16.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:06:45 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:06:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPI: replace deprecated strncpy with strscpy
Message-ID: <202310191606.93920741B@keescook>
References: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:47:58PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We know dev->name should be NUL-terminated based on the presence of a
> manual NUL-byte assignment.
> 
> NUL-padding is not required as dev is already zero-allocated which
> renders any further NUL-byte assignments redundant:
> dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
>   dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding. This simplifies the code and makes
> the intent/behavior more obvious.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks clean to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
