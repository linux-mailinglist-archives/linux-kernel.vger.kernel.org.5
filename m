Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2178DBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjH3Sht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244723AbjH3Nte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:49:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA754107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:49:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so7702483a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693403370; x=1694008170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EveZugbAyHXaF9qXTDApTq/+4nKeho781IKcvu6YLao=;
        b=wgXoxtrxRyyYi0xw7z1++f4aZnGb3I40QMLbWi9cWM4YdJB6G3NHp93RgeLUE569jN
         3CtBsBHoSVSmZuxpKLDNwZL/KB+uzkgXKRnKfzGWW33g/S57WrAqAUaEcq+t9YN/3BbJ
         Wuk5y0MujY5yRRZbbEOWBcZhVzKO7beBau4s068p073+Gnn2LHXYFsJ2Lc1ee7hXLO5W
         /PRS6ERbNzuSNEbH3fIz/0a2OEkzKzlMls2RHO5Bl2iUcCjpbBysEIx537TsNzG3o2NF
         Gt3Hb/krYWjqAohKnScWF/NYAIkFxvk3+YZr4NJROClRqrYKTEpLE/0qjIvX1dP1NDtu
         BgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403370; x=1694008170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EveZugbAyHXaF9qXTDApTq/+4nKeho781IKcvu6YLao=;
        b=DVZ35gUX3zgui4O6Cg1uN0nMMZm54sde9+Ut5l47KV74TuSr6XtrPclmLfTXg3MoJL
         2Rgce1wd7s55R6Qskib6eUWUpJwt3lCTU+TMY8kfEoZ0rGQDVEsUcxJDXd8Csi6UWjQM
         p3kAQ4vAgrs/CiEH6JfvxSr8ZpElr6o8ezK/D598bU7IFWmPE6YaX1N5L0P1sFoBghI6
         ou/OkwNIZcEQkWnQzo4e0dXdXoYWTL11GS2FjqtmUr4+SWq7G4XG8oDC1TVxN0dPufIS
         k40lCQqKmbdHlHwCxSfRoMNRXIkERBOd/G49CKgJ1X0WeaNrXTkuXnRQPi3j92x479Tp
         nFUg==
X-Gm-Message-State: AOJu0YwxVSRj0qvqoSFpOFzaSyY3VpPyHZHMO+kVTsSiCbaKIPjbJ7L/
        I5vO2XvwgvRocAvrJ5wh6QeizR/XfUJAogTicaAl9A==
X-Google-Smtp-Source: AGHT+IEcTzOgogfok30Ls9E+P4NNNCftFC6Zfon4QcbNqGg85ozI4svJ8XlOjgT+g0+T5CAwfuyrTf0kWxhSlqmbACM=
X-Received: by 2002:a50:fa87:0:b0:523:5012:63d5 with SMTP id
 w7-20020a50fa87000000b00523501263d5mr1929522edr.16.1693403370357; Wed, 30 Aug
 2023 06:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 30 Aug 2023 15:48:53 +0200
Message-ID: <CAMZdPi_Pni06Y4ZLEQ+5FYyzXxKU+zYFhygEmyc7MmBih4ixMA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     haozhe chang <haozhe.chang@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 15:22, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
>
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
