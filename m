Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976EC7B3A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjI2TRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjI2TRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:17:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2D1BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5ff5f858dso84761795ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696015068; x=1696619868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU71GMe2vZPJu4PeEOldUHOc3AVayj7fL9fLtQI30lc=;
        b=X65Cry6FM+jyayZhPUjVm+tYPEymvvveomsuKsWs/Ky56wIHdLiTzVuV1aPNpCvQep
         f9FgtlrcQT7uLkbIYuflu2me6M48ND0VDgXYDBvEfnMfvadhGoMU5q57U+kW7ULboHVB
         qk8kGsd+gqVqEcqjbysbdUeOWtsjOK873uGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015068; x=1696619868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU71GMe2vZPJu4PeEOldUHOc3AVayj7fL9fLtQI30lc=;
        b=WF3Nq1zZLW8/GvMje7BgdCnCZw0ZDRzBu3LDgacag/SesU1ihOWgvnx2ucSjyAkcAR
         LJzEvJKsQ8X97MoksDG5qoxGiQLBudvcHoVTKLCbdds+FJ3qs5U/8IkYpxSofcDJ1qe6
         quuLddwjjusfec4bc3mEHoTRPGC0J7/NGj6ZiJs6R2ZnU6139aC6SuCp+7gf0L1Pbudq
         lJPVNN8JyvEo9ALjXnPqDhzOknwZXAr/muCHW3CjCaKUVVvV6nAcZcTgXjLzYiWp7JrN
         MkwQoDIWbPFCf4o7/E+m1pu3XctQYAbPa53bUPsfmsc8mI7AODa9Q+AQqpn2LKT4b31n
         /ZlQ==
X-Gm-Message-State: AOJu0Yz+TKOIcJQkxOin0IlHC1aFZplFjG3TrPdkgd6s/sB4rAHGNRd9
        2uXFPZxwx3m1ZrQw+EgjepoGJA==
X-Google-Smtp-Source: AGHT+IG4PO/UY6icxXQtAI1BF64pWJqsBIhFzbwH6stuq3A2hGeiJFIxIvRsmPQ4QUBkfnWiuR6KTA==
X-Received: by 2002:a17:903:48f:b0:1c1:fe97:bf34 with SMTP id jj15-20020a170903048f00b001c1fe97bf34mr4043368plb.24.1696015068184;
        Fri, 29 Sep 2023 12:17:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001bb97e51ab4sm5269684plh.98.2023.09.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:17:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] afs: Annotate struct afs_addr_list with __counted_by
Date:   Fri, 29 Sep 2023 12:17:43 -0700
Message-Id: <169601506496.3012633.16053623568371724578.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201449.never.649-kees@kernel.org>
References: <20230915201449.never.649-kees@kernel.org>
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

On Fri, 15 Sep 2023 13:14:49 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct afs_addr_list.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] afs: Annotate struct afs_addr_list with __counted_by
      https://git.kernel.org/kees/c/7a709daf5d40

Take care,

-- 
Kees Cook

