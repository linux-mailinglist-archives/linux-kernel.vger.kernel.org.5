Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA07A4D24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjIRPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjIRPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:46:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BDBA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:44:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6905cccb9ceso1035710b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695051569; x=1695656369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=Gso7MGEfZt+anJYrcAkzORDvbEBIoAe07pGQeCUkKvAKakwROma5WKM6o+B6UhYJXm
         SZ6NipDGfGKj2Cdqfy/sD2cplgKOAEUCEdPYqIYCXHxY1xEqy7Zdf+9LWVOOMSe2FfCy
         JpnKOOqdKAXs2XefDhyw1FTbz+5qf15XtD/m+BrKC+7yeRoWRI2K+a7ApgvSD5ms4Vz0
         MlYffex27ZpWIvMGNOdGjh/2dQ+QWhEBTz0XmH3wCveSfL4hbBRQySijbGaEnMJ0OhsT
         MzXC3+k6fFMUKsflfN+B6h45t2OwrZ14k9JFP4Ko6NuBbmWeQbdxhyhCS9wOqI/yjGeV
         jeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051569; x=1695656369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vk4FgIcW1TSMW2JsWYrGwWF6KGqyDjo8gszSBQuYas=;
        b=fcAWjA6Z3bM3bMBcrD2FsXNs7iYW/eit6LD/CZmWXMOfYj9m6vVTpE9wMeC7ihFmQg
         sKjUE8KWkY23UTYB6CuSXQkdr19eMAaHqDC6baVbbqipaBP+WqNnoX0+quWcY/yPVpO3
         BkIGUOdwQg9iZeWTrEfaRMG9Lnx+JKC41eia+sypj5345B2Jc0ZxymB2X511jKlNTDI8
         ZG88HZXNeEKPSIp+NypA9uOupNHX9l2gLOc3+fat4g/Ez79xISfDZ0UteM7gJe9AJhS/
         9dIXNrSE5ANrJii/erkmp6BWSCjUlgZO7ETyGqVahKQg9TzjmhSBNpzHYiAj9DbqRVlx
         /HzQ==
X-Gm-Message-State: AOJu0YxQBRBCFj8OAwe9g3kVuhDEU2AziI8X2SGxMV1d+4EYIpdQG2cc
        IeaONHPuKBLxhxpx6ZIDQ7LrpQzvtB2kijxjZsmbPw==
X-Google-Smtp-Source: AGHT+IF0ETGJxFGCPdWLjhdcq5kYB6tsNKFHCvPsF+dF0bkZx+4sJ6IG49WpbNpJND4QZJhorYYf7Q==
X-Received: by 2002:a05:6602:88c:b0:792:8011:22f with SMTP id f12-20020a056602088c00b007928011022fmr8546560ioz.0.1695045568156;
        Mon, 18 Sep 2023 06:59:28 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id em8-20020a0566384da800b0042b068d921esm2836235jab.16.2023.09.18.06.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:59:27 -0700 (PDT)
Message-ID: <a6dc1618-249c-48db-a7d5-fe0415ae2afb@kernel.dk>
Date:   Mon, 18 Sep 2023 07:59:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] null_blk: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230918-strncpy-drivers-block-null_blk-main-c-v2-1-cd9b109edfdf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 1:25 AM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].

Commit title again...

-- 
Jens Axboe

