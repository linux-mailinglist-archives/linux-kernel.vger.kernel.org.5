Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670507BC089
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjJFUlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjJFUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:41:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D576D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:41:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so2194824b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624881; x=1697229681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtVwJz3VmrSTmUGmidLH6zVmajGrZnWdZ9J4CH5SXmA=;
        b=Dpj0eQxXcfywc4+TM4p5SvmgEPNJqjKLk9gCraFCx+Hx/U//Q3PvFF7eaLigNL8Gpi
         lMR1LdLGafh28bLCI+TOPG4R9JYJDLNcBCnqcEiXVqzqvSqsb6Bps5iy089Q+5agtsKV
         gYcyvEp1asaxDTobeEYrGesnzBE9HioUEaItE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624881; x=1697229681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtVwJz3VmrSTmUGmidLH6zVmajGrZnWdZ9J4CH5SXmA=;
        b=ENUGC2zT31Z4eLcGRh8FMM88L9em7VB/LayZnfcJG8ZalrKePd8/PolW/LDNpY5M7U
         BL1cJqxOBlJ+5BpAmRTKO2n3cWFuWrI83VZjIXYLf+hsa0fTPIMlWR0/fGrFil/bSM/5
         72heXGh31H9wQmV0OFRGzYAA9wr338WHXwt4kZyNRLVpLR/eRhlvUnaXKQuYaa4eOT2F
         6maXP7lYzbGgW7INsV2Ram8p6xnJWboPFCWMVY8VdjXMBPiLyE4gOjRHAXx0OxIddgjI
         WrehEJm3zR59dOlgert5UT5z4oMEzh2iu1IpWjrYXu+N9L1/eHS/SsqWFcWfYVpFszYe
         F3RA==
X-Gm-Message-State: AOJu0YwfO7Al5SH0RXs2CCHE6/2C8wOutoB0k3MAyhDH13Ii8etBKVlo
        zqbJ6byQy+R3pp2G6nITZuU5Qg==
X-Google-Smtp-Source: AGHT+IG2dW/zusfUQ2rC4ErBYYeHN5DHDo9LKlcGpi35mNLb8jz1YPoleHgLhOqVUS1wHJDIJupwlQ==
X-Received: by 2002:a05:6a21:3397:b0:15d:c86d:27a6 with SMTP id yy23-20020a056a21339700b0015dc86d27a6mr10172087pzb.55.1696624881579;
        Fri, 06 Oct 2023 13:41:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0068a0b5df6b2sm1920327pfu.196.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Fei Li <fei1.li@intel.com>, Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
Date:   Fri,  6 Oct 2023 13:41:13 -0700
Message-Id: <169662486907.2156024.1367197877614723586.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175102.work.020-kees@kernel.org>
References: <20230922175102.work.020-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:51:02 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct vm_memory_region_batch.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virt: acrn: Annotate struct vm_memory_region_batch with __counted_by
      https://git.kernel.org/kees/c/1a38cf8d8ae7

Take care,

-- 
Kees Cook

