Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40AD7B3A95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjI2TV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2TVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB401B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso11547444b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015276; x=1696620076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dtIBcP4y5aTwl3+nqmFPHxKsnqtE7UwX9ZEYMXGnyg=;
        b=iCnj6Vw7WL71EUzMEItrpm/Hyk7iWtcjY1skHdG8cuNAIFsfRNO/jzmOn1DPokRn/s
         GZPELQnLkJOXwEgA+o+m6d7aVDkxULEs0L2SsThLnndtIsECz3yeD+AcIlzh8M5mQLdw
         MAaKOze8xVMIvBJzyVzHKKfMTO/m36bo+0W/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015276; x=1696620076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dtIBcP4y5aTwl3+nqmFPHxKsnqtE7UwX9ZEYMXGnyg=;
        b=HcC4nML6D3gygudHwqdrZb5CJVZsIFJal4N+ePYrD17kH83wYKPRpN9eM+QSFIMO3C
         KuNAt+0Qv33Bvmjz/vwuhZ8s/I12ymbtfsvJ8OnKYKi7F9SjqsRvQm543veC4n/+x0YG
         vGZIfwZMLBW29lNtFHhyE80x0oKk46w1JCDbrQyVMHdc9FD9uXhvp1MEya2vNT8ZNWXH
         OHAO6cSsUc65NJSGxdIevc+Bn3AfBfhJ2X9hex3rspcXyvfMsHrkiDqIOKPYYiQ/7HZ4
         RJALlpTRMj1MDhInik7QbFoLk0H5y/Nn+QcnZuLkjyoSZC/wTVCrHWIwr4y2mj7qcvhL
         zV7A==
X-Gm-Message-State: AOJu0YxXxVhxXvBGkdcsK4xjXQLmMcxK6Kj3dpDPxT2v+H02xyOkt7wW
        C3NFJrZ9hWpXV1YXdQGjyPXiSQ==
X-Google-Smtp-Source: AGHT+IGUGV/4POMYK1/va54VqFpcD4baV6lyhqjawMMWWCnzsphh24Cw/Lf7ot61TO/bBKwMRN8+vg==
X-Received: by 2002:a05:6a20:3247:b0:154:c959:f157 with SMTP id hm7-20020a056a20324700b00154c959f157mr4646963pzc.30.1696015276309;
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b006862b2a6b0dsm15959308pfo.15.2023.09.29.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>, Kees Cook <keescook@chromium.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dm crypt: Annotate struct crypt_config with __counted_by
Date:   Fri, 29 Sep 2023 12:21:06 -0700
Message-Id: <169601526974.3013632.10898812764774808611.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915200344.never.272-kees@kernel.org>
References: <20230915200344.never.272-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:03:45 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct crypt_config.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm crypt: Annotate struct crypt_config with __counted_by
      https://git.kernel.org/kees/c/6797f1750c3c

Take care,

-- 
Kees Cook

