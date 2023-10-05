Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B235C7BA594
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjJEQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbjJEQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF626196
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 05:08:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578b407045bso641967a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696507720; x=1697112520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vz9pxu80Rpy41mTzuOKdrJhHRmps2TFWkdaMXz9JB3g=;
        b=zel7inYazByhnXvdGBB7BiwBsoJltGaFBqToSDbpX8JvrrXcUZQLoVCsfSjj1PfGQU
         Px/LNQe7L4DLelYtlEOSwCbOJ0en/AAO83UL43y9zGAXwZcB0qvrplMdgN7ZS3mA+/QK
         DpwgJ16cNZbEvWe0uq9Sfa6Pw+oRuvuUtBkPavuVz9mIomGkaSSbguTdTIcmN+kaDoVm
         Exz4NaOHZ7gwWkRICeow3K7zpy4AhaJdb+UeCTTgQ2IQ9oWA7ZnS0jfCoDbiE1s910Mp
         r1a2XKeRWeCbGbB6r3aUa8efb9ddTd1NaNysP9PwbllPmiiwIzOyuThTgNI3zTm6ZMAP
         WtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696507720; x=1697112520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz9pxu80Rpy41mTzuOKdrJhHRmps2TFWkdaMXz9JB3g=;
        b=oPc1uyL5dZ3Wh3TdxLOXdXhQsSiYDhtxneavMMW6HUk5qM22EXGZaf08AfmrHr6CBJ
         MWZj7M+YuycZ9cD7P3Ymcuiy6QnwmZ6Q/g7EDIagHalZCPuFWnffLMbsOr8b/+YAunTX
         uPzJaaCniPwQvYCBZdieomBmjkfx1pMXyC8UT+MoQdw2unZxRSYCGzDANT/yTgL6XkSP
         pZhtm2+K3XpEII+1Q6J6Aw8y7jHa11zdPvfpOgvemaAk+1YeP7pwIF1b1iu3OfyZN7WV
         8ynjHHtHsMpJKY3sRDf6ifXYgXZh2QNnSfXNldnhUwi9+c9FjSGrdPxWCfEG558A04BE
         W2mQ==
X-Gm-Message-State: AOJu0YxTny5wrWLFpGm9mftehZnn+Q26gXJRWrqF0+qS0AlaeULrdeU4
        owcKrxIdNwztRUQQGZCDzla6MdwmfNkfbNXVNkveKQ==
X-Google-Smtp-Source: AGHT+IEjmI9AgvKtfzugLMOqDqtSC0UxETht4g23APbeYey7LRGoPEvefaaTs6AFWmBFKFqiBPaBNarHJlu813P4rmU=
X-Received: by 2002:a17:90b:374b:b0:26b:4a9e:3c7e with SMTP id
 ne11-20020a17090b374b00b0026b4a9e3c7emr4844691pjb.4.1696507719751; Thu, 05
 Oct 2023 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231005084001.34741-1-james.clark@arm.com>
In-Reply-To: <20231005084001.34741-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 5 Oct 2023 13:08:28 +0100
Message-ID: <CAJ9a7Vhrup63a8+auvacTTNQgXpsuZW-9fex3r=w+JZQs6aXcg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: coresight: Add filename catchall for Coresight
To:     James Clark <james.clark@arm.com>
Cc:     gregkh@linuxfoundation.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, namhyung@kernel.org,
        atrajeev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Won't this also pick up....

drivers/accel/habanalabs/gaudi/gaudi_coresight.c

?

Which isn't part of anything we maintain

On Thu, 5 Oct 2023 at 09:40, James Clark <james.clark@arm.com> wrote:
>
> There are a few files missing from the list like test_arm_coresight.sh
> and arm-coresight.txt. These could be picked up just with a name match.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..3ee45066b7e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2066,6 +2066,7 @@ F:        tools/perf/arch/arm/util/pmu.c
>  F:     tools/perf/tests/shell/coresight/*
>  F:     tools/perf/util/cs-etm-decoder/*
>  F:     tools/perf/util/cs-etm.*
> +N:     coresight
>
>  ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
>  M:     Hans Ulli Kroll <ulli.kroll@googlemail.com>
> --
> 2.34.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
