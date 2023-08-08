Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A512774D09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjHHV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHHV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:27:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BFE90
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:27:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565331f0736so30846a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691530036; x=1692134836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WblHbZVi4y1TIh0is8Z580iO5wWlNJUK6HXQ9JjhgNs=;
        b=F+HSs+30LbbD7LWLs51xR5SiEqJ2oiCvmPzqlD3Ecv9DEOHs/wkXgZzJH4ClAnNBzX
         zenuP2vXfauJP3r5oF6gRTD3Q1p5qIerdcrr7AeT8hG18l1QB/MSo+zaYoMIyS6xhuHQ
         2fMzPOsY+5Qj2bv9jfiCk13I61StyikOrIRJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691530036; x=1692134836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WblHbZVi4y1TIh0is8Z580iO5wWlNJUK6HXQ9JjhgNs=;
        b=FB2iiFm9nWjvzzRJ5/EKnAhYLiBCj1Kqf4Vwrm3bvvz4aLTiDTUd5RbrQtPUF5Srni
         voDFkRT39786M/mui+tVnD2QIkFebWqghGSM7owWcR/YOvO3h9k6YRAP3qBBIoLV4zCQ
         k49cFQPK2KxIGYg1nPHMUKW+b9v/7ywHwa0uDjuon8ilhxoGmWHm+gUc/IbcpV5PzjS9
         sPhTQ1WrhF6yusrfdDdYyESY5jnGiC9oXUuHSvNY/Teec0+PBxKOtsofP/sQS0M9XwV2
         iDtwIhQwsGo4j2F+suoDvz7zmEIUc2T9sO1OQMnTWy40xdq2mj0Z0VB+ZTiovk1LhxVj
         YQuA==
X-Gm-Message-State: AOJu0YwuhHi3tyKDi9ZxULqZqtJ2XzlOLQePw0b4+GoCQ9od5WGlSKRc
        V7HAQ+KolUt+6aMC3lLevyF9JQ==
X-Google-Smtp-Source: AGHT+IEpwJM6Jc4WcMb3mJvAt6p7/C2NHQNV/HRelcc6S222LnIkMpF4YqE3P9H/uvT6fxfUl39uZQ==
X-Received: by 2002:a17:90b:358b:b0:25b:c8b7:9e5b with SMTP id mm11-20020a17090b358b00b0025bc8b79e5bmr680387pjb.31.1691530036117;
        Tue, 08 Aug 2023 14:27:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090b010400b00267f1455d60sm1328pjz.20.2023.08.08.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:27:15 -0700 (PDT)
Date:   Tue, 8 Aug 2023 14:27:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v3 3/3] list_debug: Introduce CONFIG_DEBUG_LIST_MINIMAL
Message-ID: <202308081424.1DC7AA4AE3@keescook>
References: <20230808102049.465864-1-elver@google.com>
 <20230808102049.465864-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808102049.465864-3-elver@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:17:27PM +0200, Marco Elver wrote:
> Numerous production kernel configs (see [1, 2]) are choosing to enable
> CONFIG_DEBUG_LIST, which is also being recommended by KSPP for hardened
> configs [3]. The feature has never been designed with performance in
> mind, yet common list manipulation is happening across hot paths all
> over the kernel.
> 
> Introduce CONFIG_DEBUG_LIST_MINIMAL, which performs list pointer
> checking inline, and only upon list corruption delegates to the
> reporting slow path.

I'd really like to get away from calling this "DEBUG", since it's used
more for hardening (CONFIG_LIST_HARDENED?). Will Deacon spent some time
making this better a while back, but the series never landed. Do you
have a bit of time to look through it?

https://github.com/KSPP/linux/issues/10
https://lore.kernel.org/lkml/20200324153643.15527-1-will@kernel.org/

-Kees

-- 
Kees Cook
