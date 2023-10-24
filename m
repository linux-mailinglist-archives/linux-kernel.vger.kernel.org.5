Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907C7D54B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjJXPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjJXPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:08:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DB1B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:08:52 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7e5dc8573so45977687b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698160131; x=1698764931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6YEOKFZgnFFaFZTb2aWNTq5tspoBeefaSbm2PKin5I=;
        b=grWbncdaFAmgIa+rADUOXCvA1kgEps1HSgMbXt9/fZyUZJvlHbvAhYJyQrzkevsM25
         EvujKf1LibhOl7eYRA+2OLk1n8ehyJJyMzsNZa6qOjyKbLQgFxaZmNF/yqbooEKBEbPm
         nBSz0C8R4sSLtkLtAaKs5V/qHBzQ9ufULgk9fMQFgGx933mMzYUKomCwovAIjtK0GTOq
         ub/3vybhVHGoQHoB7103/mKFXztt6WCgCUtvSo0z1oU/H+orDfv/UMvRkAsjiBjZbRHr
         zil/x+6MoX6db9D4QhOJUGvmGkw2IVA+YdCIMyy9ZbkVMCndPWg8bVn45GpAdMebC1+R
         k6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160131; x=1698764931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6YEOKFZgnFFaFZTb2aWNTq5tspoBeefaSbm2PKin5I=;
        b=DyjC43OeNi/OH3SNqqIqolF9yj1jrh0Ymj2C8By35eCNmYv9kHPamBJLKQScsJjyEq
         diLUhWHgKqY8OJAXQgNJrPjBiKnmWCb9v37ZxESl8+ppvoIHecCBI1QV133fLQ+knjdU
         NT353ZZZwA/ia2tzHoXeyvKHyfIfHWyydU2FwwlNY+0WE6b0WQ+q7XrfhkqVWjMy6ZgD
         D/ZYKaQ5mI/8Q43yvDU4pFQYbKnowLSz+puinadgzQYbB2QIYpe7rvnQHO0kEs1RDWYe
         mroLy7yXcaiNynGuqU1oTAGT7kDITVQ76ofDXtHzdRbaZnUXLCJk56mC5YnBeML57ARl
         /QNQ==
X-Gm-Message-State: AOJu0Yx9FEs/mw+nEzeehusOMB5C6ROpcbdrYLZvRhBXFCl5gEn/kbB+
        bOdeDs5jQCqKnMO5A1QWOiwH42cerBhi+VfJbYWyQw==
X-Google-Smtp-Source: AGHT+IFdzxMRbfUafGldLvc0HICTqC1JOkySRW6UQmufXP4xHsBx58j8IAM3qrN6y3CJMnHbyWV5ul2UEmW+AdgnJ3I=
X-Received: by 2002:a81:4814:0:b0:5a8:e303:1db2 with SMTP id
 v20-20020a814814000000b005a8e3031db2mr13315604ywa.23.1698160131018; Tue, 24
 Oct 2023 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com> <f3a4c114-b430-47ce-a746-4a840994dc58@quicinc.com>
In-Reply-To: <f3a4c114-b430-47ce-a746-4a840994dc58@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Oct 2023 18:08:39 +0300
Message-ID: <CAA8EJpr0Nnn5Tr=2CBAADYfNU6cnKuq==x5L5YQoko9C=3q2tg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v7] Misc SCM changes
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        p.zabel@pengutronix.de, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 24 Oct 2023 at 16:31, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 10/4/2023 10:55 PM, Mukesh Ojha wrote:
> > I have given version to this series as v7 as it has already
> > gone through v6 and later got added to minidump patch series
> > However, these 3 patches can go independently and has no
> > relation with minidump hence, separated it from minidump series.
>
>
> Mukesh, Can you rebase this series on top of linux-next, since there is
> a conflict?
>
>
> Bjorn, after rebase is done, will you able to pick it up for v6.7 if
> there is a time? These patches(#1  and #3) are required for the crash
> dump collection on IPQ9574 and IPQ5332 SoCs.

It is not obvious that they are fixes for the crash. You did not add
Fixes tags, you didn't follow
Documentation/process/stable-kernel-rules.rst. Cover letter is
useless. How can we guess that they are urgent / important?

-- 
With best wishes
Dmitry
