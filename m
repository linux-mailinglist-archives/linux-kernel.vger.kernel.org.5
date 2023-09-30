Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622FE7B4233
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjI3QgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:36:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E5D3;
        Sat, 30 Sep 2023 09:36:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ae2f8bf865so7648484b6e.2;
        Sat, 30 Sep 2023 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091775; x=1696696575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyt0KGC1OcelyqP8s+Yq2xN5/wo1kjcQggShUtRbwZo=;
        b=kHaSRXaiM/GpBnDMrUCWYfX8f/uDQOE1+MQ8qRriMs77q0EGd2EaRlE2uPiJqaHLk4
         mrfc7q860nPDbnu5h8p+3avjVebkJZGoR6s/dgixxKuPcHGNawkm3BKxK87J7jTx3fN7
         pcEu+nq5/hX+IxfSyKF7YQgKYqAPEUJWc+W1vJeC9Pw+eVf+oeTM2fq6tarIuzRHPPkY
         Hyrvul8hEdPgQGed927d4YEbrAIvLA8Sdftpzaw3rGc8WrcLq8jDIcbfdUtik2D2Qymt
         lJ3F/t0t9HBu12gC4tvQTT24mMrJ3d2msTiC2fOpKizSnNouohAdyGpyta51edodO9nW
         Nlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091775; x=1696696575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyt0KGC1OcelyqP8s+Yq2xN5/wo1kjcQggShUtRbwZo=;
        b=nA/pYr5IEHIOhI7Q1lFIyr2F73W4inPZMSkjQOzANe+ik9Q2lw5mOgMLKGeV4jZjij
         1Tt/D+fyC2pJUxxnHaQogO5wolGg/bjDilQcYvj6wjRHAsFmquQSqKM8uK2t0WlPj8OQ
         /z0zY+4dUHfxESln/S4LQ6zKKgJSbsIdzbrg1NIbKr82T/C0C11EAyVtTV2mTSgnUvXr
         +1t1mczQ7WGYjKo03hZh7LNotYhX802zrOUUL292B7go/vc9Mfaa3DrUUOcj0M8hEioV
         eKpfeApQ4VZs+wbccj3m61+afECLUnS9vXeummwEFJgHmjfy6aS787W4vQcYVn6qTWyp
         fDGg==
X-Gm-Message-State: AOJu0YyJ95BmSzwVd/Lt3AoAdypSqCSWPMQw7N4on6fFc+te09kU61au
        jNZpHeW03bEj8GJc2N2P86o=
X-Google-Smtp-Source: AGHT+IGrp36U8oVS9oihnUJtqY2rD9L79m36iKwc0SNUFVgHabnFPmI2BXNhQulf77W7U4MEhKzTUA==
X-Received: by 2002:a05:6808:f01:b0:3a9:cfb5:4637 with SMTP id m1-20020a0568080f0100b003a9cfb54637mr8914851oiw.38.1696091775406;
        Sat, 30 Sep 2023 09:36:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id f18-20020a637552000000b005777a50c14csm16343594pgn.0.2023.09.30.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:36:15 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:36:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] input: Annotate struct evdev_client with __counted_by
Message-ID: <ZRhOfEiwNbiGHzft@google.com>
References: <20230922175027.work.563-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175027.work.563-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:50:28AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct evdev_client.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

-- 
Dmitry
