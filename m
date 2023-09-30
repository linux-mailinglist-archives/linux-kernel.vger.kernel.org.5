Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37D67B4238
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjI3QiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjI3QiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:38:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A064D3;
        Sat, 30 Sep 2023 09:38:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so136589625ad.1;
        Sat, 30 Sep 2023 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696091895; x=1696696695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ll5RgjPd4WERjGYzQzNFee7tOPsdSELqkfPGuXCqmQY=;
        b=OozuIZ2doM7hMTUYmcI9K6cyaEgqTbIcJ6WwyV5CKRII+z0zHptUju1v3e2apEo6cg
         1uL86Hcy/iymYPBs2xvhnMhq1uWw5M8rx3Uuh5uXyz9vr4JOO1hXc+okmP9ggC6TLP/K
         nMVYpPSluE0t4NuusF7+epuFHRnDVto1/weMq2TK3EA9N1dNW/1mNUsfkAqPW7cPCq1d
         mVvXPJZpWvHSW7N1bBDPYwucspetYsG0wmCEffIkLQu1sODnucKV+bVMIfguTwAJJBd4
         N3xJzHQhhkthEHkzo754YdAsBFHrH+mfi2CdGxNstMtIC61+aHGvUan5cpTRiYXwZILS
         7xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091895; x=1696696695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll5RgjPd4WERjGYzQzNFee7tOPsdSELqkfPGuXCqmQY=;
        b=MwA8KmTSvRSyzH53/mIbDOCzHzJABrRCUTxWS3ix+7Q2RmMe54f54hnuwTXqTcTukQ
         omvGzEo2mPPvMy8/VN17AcyY2LWtqACJJoty5dUDNGrOIfE4wmN4VDyU/BMNdbLh60MZ
         9xywYrLiTIElePkMUjqPe/hlvx7RLaRoA5wwIwYZkaz23MooUJNxoIBWcZe6PwwUIblH
         xDnJAerf+H6q0MKY21w+Cz/SsVTGEZlaObrdhYOklVBe345afrEnMMgcu07lBVxIOgsP
         tTgz2y01XVLIEPc0FDAzHPNzfjyCi06gmUo2TwByhGu/R+JwOHZFEKhe9VKvkkHtGEiE
         TsDA==
X-Gm-Message-State: AOJu0YzCh6vqa3K616xuMRF9H+jPjd9O94vWIL75YcUgo48HOzdKWNm6
        BmWJDID4MO1uryA3M3xL5WE=
X-Google-Smtp-Source: AGHT+IEokMxdLDwnG72GNo8md4NLX8fZro4ky2KeOokEesCSFdQ1+vI/RtlGtfvbM1IityteBfIaUw==
X-Received: by 2002:a17:902:d34b:b0:1bb:9b29:20d9 with SMTP id l11-20020a170902d34b00b001bb9b2920d9mr8060404plk.20.1696091894718;
        Sat, 30 Sep 2023 09:38:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a90f:2dad:30c1:d923])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm12841649plj.101.2023.09.30.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:38:14 -0700 (PDT)
Date:   Sat, 30 Sep 2023 09:38:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] input: mt: Annotate struct input_mt with __counted_by
Message-ID: <ZRhO828Ml4qpoS60@google.com>
References: <20230922175036.work.762-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175036.work.762-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:50:37AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct input_mt.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

-- 
Dmitry
