Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6357BC062
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjJFUbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjJFUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:31:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA767F1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:31:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso2255738b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624306; x=1697229106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX47GVueSgt+x88lXgjrOuEvVhXaBMxhauYyZI06tqQ=;
        b=mKyhi+TDoCaD4LcnhoWxxHl1Jiw7/0pvkXAJ2TOSxuev9IUPxKVkBm7ShuaSFXj9+q
         1TV95Hp26kG/i5Cz2WkSz4K4G+xpKva61PAWh2gSZZZnGG7HqBWL4qc1nXBV88eTrr+2
         H4YJZI8tPsFGC9um9hJBvj6CjMaJs3bhvvpzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624306; x=1697229106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX47GVueSgt+x88lXgjrOuEvVhXaBMxhauYyZI06tqQ=;
        b=H0G/KuPrK8R7CWgnvmIoRP4ewpEgAXwMBNt8UZc6gR/JRUOnf+kCKOP+bZ+ysUt90S
         5P0EcGS03xiKax9GSTgOhevSXwwM5wJ6xRRz7CNyN8Boiu07NpRVUKQAQrd0siGvj8A8
         H2phuF1/PRNF2cLfZnYk0yVEe9MKOYLDF3dbyd/tFggAS6XX1RVJCj/tcdAKWJnIac56
         DNAFI5+Qq+VS8V6nALluuJS+zsY8n/3kLdxaU1ocuWLDx35nC+BJR2xlLdJ0ekgtcF+j
         LOUR91Vl12YnqKth5ar0QeREi+kzhrWDt1ucdav0WgUYqLFA/cYN0FbDy4S32x3dqfG/
         MkTQ==
X-Gm-Message-State: AOJu0YwsDD3iem9PNSM6PhRCPmTR7hgzlmL8uG7GpS8Ex82h6Gr9xhVP
        oek6+lib5lH66O11z6/88SSzgw==
X-Google-Smtp-Source: AGHT+IEDB4JiE6QwcjTIlFZlq6WWddYaDMaPi1FSwSZbG+KVJWywvAicRGeUH+/1a8vmGHDJmVIHMA==
X-Received: by 2002:a05:6a20:394d:b0:153:5366:dec1 with SMTP id r13-20020a056a20394d00b001535366dec1mr10718663pzg.15.1696624306130;
        Fri, 06 Oct 2023 13:31:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78112000000b006933e71956dsm1903839pfi.9.2023.10.06.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:31:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tim Harvey <tharvey@gateworks.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
Date:   Fri,  6 Oct 2023 13:31:32 -0700
Message-Id: <169662429066.2155323.3293633131737633450.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175053.work.564-kees@kernel.org>
References: <20230922175053.work.564-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:50:53 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct gsc_hwmon_platform_data.
> 
> [...]

Since this is a trivial change and it's been 2 week without further
discussion, I'll snag this patch.

Applied to for-next/hardening, thanks!

[1/1] hwmon: Annotate struct gsc_hwmon_platform_data with __counted_by
      https://git.kernel.org/kees/c/e909028ba701

Take care,

-- 
Kees Cook

