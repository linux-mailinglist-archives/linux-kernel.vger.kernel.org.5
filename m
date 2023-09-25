Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68267ADDD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjIYR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:29:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3506BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:29:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5789de5c677so4441476a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662948; x=1696267748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aMa/e/MpMROFsp3gARJijeh7sh0P+MuDKdlmUY9kPc=;
        b=ST8R/iVgZaINxpOo+l0+mfR+9GySAZ1xlnMfPsrwTV5Qy0aadrzrn29jahUwOToN0A
         QYo9vWngz20wX+Q0aFyTnIgHhpc+WIzFXJaNVmk62sxBxqk9bnID6nrz5ivPUlCZuvib
         gzRfmrrwZJD4V/LgLJkdIJvvJMiriwfqozxwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662948; x=1696267748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aMa/e/MpMROFsp3gARJijeh7sh0P+MuDKdlmUY9kPc=;
        b=KQycudAQPFGecu46NQm/31Oq7dK9C2Bx5z7s0R64tH/R9Or4Iy66iFMUej6K2UMwI6
         wDbcMWE9amV9rj4jk6fDjTlD3aQzp3HRTX9Vei7AIKBJtPlS/UDi8EiANEllarj4727l
         t4ToHw9uhIJlAHJkaDcmsebwHBxl4Njq7rTjzKL0ziK6dzQ1sewEUG+CFnuHXUhg13Sy
         1eZw2D8gt0yGN1Xturx1B00PVMqFWMxREK8rBHUk6Rc72Cab/4HIm6KfPKjSLpz+CiAy
         5nppGONgrmVSNkfcy2XrRl0voa/7jemuggeLHz5m4HwOmOHOOugxKeO0WnOrdCg0asvg
         QxsA==
X-Gm-Message-State: AOJu0YwsC8iqrZ9kKVvIDTemzjPqhzDvuUorKMmVnu9Me5srsUHnVT6Q
        z29jC3RxL5IOgG2qSjMK+XnOQQ==
X-Google-Smtp-Source: AGHT+IGOgiwM4+b8S6Xt1BZDhFJWOaJGQxJpivA0wrsHDefHQof1Ld6BLNGIRgIO+U3XOUTHoQ7GrQ==
X-Received: by 2002:a05:6a20:9499:b0:13b:a2c9:922e with SMTP id hs25-20020a056a20949900b0013ba2c9922emr4951421pzb.27.1695662948293;
        Mon, 25 Sep 2023 10:29:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b006829969e3b0sm8345115pfn.85.2023.09.25.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:29:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: Annotate struct ivpu_job with __counted_by
Date:   Mon, 25 Sep 2023 10:21:58 -0700
Message-Id: <169566251617.320041.2089067222600486912.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925110352.GB846747@linux.intel.com>
References: <20230922175416.work.272-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:54:17 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ivpu_job.
> 
> [...]

Thanks Stanislaw! I'll take it through my for-next/hardening tree then:

[1/1] accel/ivpu: Annotate struct ivpu_job with __counted_by
      https://git.kernel.org/kees/c/2eabbbb8275b

Take care,

-- 
Kees Cook

