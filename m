Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711CE7BC085
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJFUlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjJFUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:41:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF69ABF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:41:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-584a761b301so1886248a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696624880; x=1697229680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82USvwp/AVZiI7JMu96kcDBx0uffytd6mmJ2fi2p0ZE=;
        b=HQS92pPO6hykw5hjXESSX0nYGKO8ff74kHEWvT0Yh7Yrzyx/4IpabrJ7+M6or/SgxP
         fD8auFYaGs0IoGTkKGHT+3WVyqCWLDmemT273lod04UXBI9rZUqDUfhrw9iK4OUNVxNi
         wLczvDtGYS++mlmwsBvIGlcuVCoiwJLGq+EkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624880; x=1697229680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82USvwp/AVZiI7JMu96kcDBx0uffytd6mmJ2fi2p0ZE=;
        b=jnx+4jbOruTQRqudd+Bd+ti0YOmXcPYJmJF/fnkqvxdMs6lROr/xLww9V2OJSG7ieO
         ir+/1lr9Yj8PuGQmojx6j6fhDJE50Z64+heScTqCx/ZqSGUwECFCR7xgsDNZgtapB+DN
         CNWC6DMjLaIY7oF2Y89Pq+A5oV2zufbjK+jr2VJAsUqQxVZMHdo2J2rHBf0R0SIQyvKl
         +ORy98P3IzaWm8maDBMZN3vrjA2V9ueVkxVfJE+l2coIfTmSTxqvmgfD2RV/bTPNxOvA
         a4d22CZ2WFQXJ8HcVup0D74x5rIXZWQ/Vfc1h2+7ir9AnWihSbP2NT2Y0radiSn3McfE
         VMVA==
X-Gm-Message-State: AOJu0YxhkvpGmXGAsjhSqhY4pZkwCETZ2fWf9jTS/VUi6SSOV3AutU7P
        1jFFqFJ2fBlGz503saZdPbZ5SQ==
X-Google-Smtp-Source: AGHT+IEagZ/e+OAcVZ1rHnrATwqu55U2it3q4IXBXcOL6xkaUgJK29G54dnQ353w7X7bsAup6nYM0Q==
X-Received: by 2002:a05:6a20:7d94:b0:16b:e2e5:fe5e with SMTP id v20-20020a056a207d9400b0016be2e5fe5emr2794996pzj.31.1696624880249;
        Fri, 06 Oct 2023 13:41:20 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63e444000000b0058958ea2aaesm3753290pgk.83.2023.10.06.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:41:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
Date:   Fri,  6 Oct 2023 13:41:12 -0700
Message-Id: <169662486918.2156024.8903511465543828440.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175351.work.018-kees@kernel.org>
References: <20230922175351.work.018-kees@kernel.org>
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

On Fri, 22 Sep 2023 10:53:51 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct zynqmp_ipi_pdata.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] mailbox: zynqmp: Annotate struct zynqmp_ipi_pdata with __counted_by
      https://git.kernel.org/kees/c/6b607a3a311a

Take care,

-- 
Kees Cook

