Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4327B3A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjI2TVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjI2TVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:21:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54221BC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso11114485a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015279; x=1696620079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCv+kMrx/0UVGQCBQ46tqfp9gvNT/0LM2qgPxtgaA9o=;
        b=VX4hN++I+aUc1RYQv6yPxwRdma7EuTF2+LNbnhnxHUwwju+e1crZgJgNTyuPIwvvdd
         i2ZkwRKYiUHJVbJpEKaLXNEQeTEho1lzI/nc9C0A0s7LDNWs/FB03nMQnsrkAN4JvCdc
         2lkpELBtihCNmQMAAgMZIpmM7ELu2Cl/4J3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015279; x=1696620079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCv+kMrx/0UVGQCBQ46tqfp9gvNT/0LM2qgPxtgaA9o=;
        b=qRx3t5HwObe0YlFCDRz84/JE4HMx4M1GsEmGTVdJTARMvhnNQx9Eiy+BOh2b8I4wrz
         nNUM8/zRQOCIgDaPy/5vhPFqoGLDw8OET3D/2HFYhMHX9+BzVcr4Qszv7AauQyW5PXPE
         q4dyMOHqYhof+gC+uEGz24Lg/K6eqFWV70jqfI5acFZOSDPMsqeaZbGHj5B5hjslJGST
         5GrqmhbonRBYVMTer+3eo5a1MtGT7PMKbC3rfFJlo0ZuE6MQ2UarsDAF8NTDDHKlxR/6
         frHTTKdvBI4pfqd6uuxDh7IaWXRX/63ZMBZPFyuVtYIR9nGX2xAv+OJp6dYDvdGMDZej
         6T2Q==
X-Gm-Message-State: AOJu0YxdyKt2fYzjkcWunv8QfYtMWGtQH3zkQ/Df3tvMnHqkCxkVVvHJ
        h6902Fgh2OhrQIyB1/24WCySvQ==
X-Google-Smtp-Source: AGHT+IGiBwStaHPR44R6ANK1/tkrYWC/2DFh5Z+5BULeXdWKDr6O8WVqqWNlE6Fy+1azpzu06/HF2A==
X-Received: by 2002:a05:6a20:3d22:b0:160:a752:59e with SMTP id y34-20020a056a203d2200b00160a752059emr5701827pzi.40.1696015279415;
        Fri, 29 Sep 2023 12:21:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y7-20020a637d07000000b0054fa8539681sm14767022pgc.34.2023.09.29.12.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:21:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     John Keeping <john@keeping.me.uk>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
        Yuta Hayama <hayama@lineo.co.jp>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_fs: Annotate struct ffs_buffer with __counted_by
Date:   Fri, 29 Sep 2023 12:21:11 -0700
Message-Id: <169601526969.3013632.10440475414357366621.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915195849.never.275-kees@kernel.org>
References: <20230915195849.never.275-kees@kernel.org>
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

On Fri, 15 Sep 2023 12:58:49 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ffs_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] usb: gadget: f_fs: Annotate struct ffs_buffer with __counted_by
      https://git.kernel.org/kees/c/84657a30a0c9

Take care,

-- 
Kees Cook

