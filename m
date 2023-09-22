Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452A7ABC70
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjIVX4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIVX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:56:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E661A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:56:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-503f39d3236so4894781e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695426964; x=1696031764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VgsTwjAhcmGfF4w2bLuCjQsCnbO+ua2mlKup05QwknA=;
        b=c3VAnxiJi7m1qxRF9YunaTwNTLzBEnGWuAXFK96YylDEUT/6xY0Gh1jockPCnNncKo
         RHQkJT5uiGNz3LjqKKRU2QFKcYb+zHilSVSppFcHZS4ankEcz6qDpM4stjvFS6ONqsa6
         VvsX4jBWj/iVTt3geX+6D/k8A0ueVV7aZETm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695426964; x=1696031764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgsTwjAhcmGfF4w2bLuCjQsCnbO+ua2mlKup05QwknA=;
        b=D9SHXxF7FqZ15L+l2j3axu/n7wR99+1AXDrrrRM9r5zGA0qQMb8IECz4fyN8+anmKj
         M+exCs/K4jvJCwdiF05iCS1lz/ozMZI3S3veDjb5TFt7kToh9f8z8QbCG1ktLYY6AmBV
         LVYrwdmxe4OIpthlnr1He9ibljDAmwBzZvH9hi4xVQLdnOi0EFToxEQtG/N0DMmwhggp
         kQfhDaf7TipMr+svHbpx3/aO8QZpEmwxGvcoMjL6E0rObuFmgEckEqpVpzk1bC+3zZH6
         iEV8gGCQSJ7WkXvCwSLujmPOEuJu7TS4bT+eUfYAjN5ZQovTzXxeRHkD57MJEfrd8gwT
         WXCQ==
X-Gm-Message-State: AOJu0YxgZ65mw2obWlVwrB1yWZXL382H6GNSXJ4y6yO8MMSosNETbDwM
        kL0iTZ7kA7DRuqccWUHjDGYlyUC+/v0M8gXAGdYPMQDM
X-Google-Smtp-Source: AGHT+IE1NptA8hHkgIqUa7XHbuBsip/+wu8IsCVrYw001sStAW9b7pSGxUeWYPBTshzC+xjBApM8Gw==
X-Received: by 2002:a05:6512:210b:b0:502:d639:22ed with SMTP id q11-20020a056512210b00b00502d63922edmr625887lfr.48.1695426964199;
        Fri, 22 Sep 2023 16:56:04 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24848000000b00500a467914esm882188lfy.38.2023.09.22.16.56.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 16:56:03 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-503f39d3236so4894753e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:56:03 -0700 (PDT)
X-Received: by 2002:a05:6512:250d:b0:4fb:90c6:c31a with SMTP id
 be13-20020a056512250d00b004fb90c6c31amr896714lfb.14.1695426963156; Fri, 22
 Sep 2023 16:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook>
In-Reply-To: <202309220957.927ADC0586@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 16:55:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
Message-ID: <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 09:59, Kees Cook <keescook@chromium.org> wrote:
>
> - Fix UAPI stddef.h to avoid C++-ism (Alexey Dobriyan)

Ugh. Did we really have to make two different versions of that define?

Ok, so C++ did something stupid wrt an empty struct. Fine.

But I think we could have still shared the same definition by just
using the same 'zero-sized array' trick, regardless of any 'empty
struct has a size in C++'.

IOW, wouldn't this just work universally, without any "two completely
different versions" hack?

#define __DECLARE_FLEX_ARRAY(TYPE, NAME)        \
        struct { \
                char __empty_ ## NAME[0]; \
                TYPE NAME[]; \
        }

I didn't test. I'm just hating on that '#ifdef __cplusplus'.

                   Linus
