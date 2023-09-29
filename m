Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC77B3A83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjI2TSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjI2TSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:18:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFE1AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c364fb8a4cso130962865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015070; x=1696619870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdzIkpOORPZHV5wenIN0SGnXWAeNAW/YV8thKJqiWYA=;
        b=DAAre/P0IxxuGdDCy/+xl4p/5Q75Gcr7bioNOEZW84OlE5cz/xmVqD1K9h5mq1kgKX
         fXUXANqF4xJjbWnG6gXnF2bOzR0yoeoG0T0UrTbHqFFEhDh0GJixyxmxQ3jAJWkETrGN
         FpcMI/b7rDsBOP8YB9lvy6ZaPrJubu6ocJTdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015070; x=1696619870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdzIkpOORPZHV5wenIN0SGnXWAeNAW/YV8thKJqiWYA=;
        b=PlV+Ftsj+3wHaK1SZlgEYuFLJcZpI7KCwNJk7heyl7+RGYZEQXEfOyrbIoR2R65JU1
         Sj/08iuw/VQYBk6q2LJ7pVt1vMyB8a7w4xV5u/OXE082o1Fi3j35cHpIeLZ0FZfGp1lp
         GcLDf4LYyOIE1F0Du2DluLk/evmL9YwwSMyeLnpP2eM0wkiNXO1rRGhWlB+ev/x3sDo2
         q8zag4sQuPM5jgx9rbSQxObC10khwDpTH1nhfMBOvBUvS1AZxBjLdAar5H3OlGQMHpWr
         gi6J/yJMnCLn3pRhh0dPBxNKCNBwXlR5UhywNwyFfOnBUSSsUHwuLDOW8WewqeygaJ4Y
         F5nQ==
X-Gm-Message-State: AOJu0Yy6Xgz7RP8lHrhpSq6A9SZT6vRBiISBb/KDLUZthGcyJxVBrr/Z
        IFd3F1yhyZYsU0ojAx+GmJ+8Wg==
X-Google-Smtp-Source: AGHT+IHrw1fOyPjJ3jkkEg8ObgcF8Wa58J+gcFGUj5kMKDI7VBoc/1OzIbj48UaSw/kDEy3t3ivkGQ==
X-Received: by 2002:a17:902:c38d:b0:1bf:8779:e03f with SMTP id g13-20020a170902c38d00b001bf8779e03fmr4898508plg.68.1696015069936;
        Fri, 29 Sep 2023 12:17:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902b60800b001c1f016015esm13499323pls.84.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] afs: Annotate struct afs_permits with __counted_by
Date:   Fri, 29 Sep 2023 12:17:44 -0700
Message-Id: <169601506495.3012633.13895603881576903782.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201456.never.529-kees@kernel.org>
References: <20230915201456.never.529-kees@kernel.org>
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

On Fri, 15 Sep 2023 13:14:56 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct afs_permits.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] afs: Annotate struct afs_permits with __counted_by
      https://git.kernel.org/kees/c/45faff97751a

Take care,

-- 
Kees Cook

