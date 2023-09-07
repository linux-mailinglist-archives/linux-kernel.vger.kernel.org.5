Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF087977C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjIGQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjIGQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:33:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C0F4697
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:32:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3aa1443858eso803537b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694104308; x=1694709108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT2zLt+lggSVzXUG2wimOweNQHus7+eb32MpOdUPep0=;
        b=j9rzQ6vymJS7lcwmucZ5lbeaZsus7GQagHl+/hdDVolFADp6GeT/ofMBIzQ/H31J6d
         TGI0D8NmwI8UjwXCIWbp9rAFLjNbbZTcdN7MhF9xa215e9earRNradEbZ/+juWcyn1S7
         YnI9hVOvA/vQBovumObmQRO/RmbKCWutLXEHEtdnRX3QeUo90P8f51JuX5dKKAWrvpLm
         MhUrrBAr2j/X7TNN8DpK6N43lO73PucGFZwmRODhbgDnYXGLATBVzwTGCr4KF8neFXIp
         p9t9tz6ei6obvRBjOAsx2w6Z66FrXQQ1cqqMlZ8GXIjqmdhpYEbXM91QHZDVzrpK/lmO
         SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104308; x=1694709108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yT2zLt+lggSVzXUG2wimOweNQHus7+eb32MpOdUPep0=;
        b=Uu7b/p4wQ/g+x0RG4iVtn9N0dDFMqY5ROfwVvTKbiK6RneZAsn7k5OVmfE4vKf5uvo
         p/Q/nqWvz3NjqDVqwauXEOvWijwq0FrO9KwB7SRzWJs76rAktN7rpwLihQnSZ+7y+X6M
         cYNhqBR6sDlmyGaLj5w9PtvntVv6419pgVh01KTmQLZSGk6iv0JqfW5XCKUKH4S4rwQ/
         KPholsuMJiCJxAsAdcNdQYu+YjB5DU4wueqpGfIsX5OJzXMnhDFeNNNhCFdTiKtonxBj
         Q0uCwsoUfkU0UDX12+j4OECL9Ndb0epgzLT/CjW5Wj6EQ/DD+794I8SSSvtAHj637P+i
         oV7w==
X-Gm-Message-State: AOJu0YwgQJafxP7w2Hw1SDj8ww6W8PRqhkIQXY0J3bszAIUWUBWdy6Am
        nOoIv6Aihrt/lLvH7bOw4c+J5JgwfWcnXmL4naEbR3/ifk8KQep0nxw=
X-Google-Smtp-Source: AGHT+IEapBUe/2q4BqP1Fz3k3+uTpDMdMnbX48+PwRjLLwuQW6xXP+Kr1ttyV/Prp2f67wE2FiPm6I0EHEVM+H0MLdM=
X-Received: by 2002:a25:8206:0:b0:d78:21e0:c06d with SMTP id
 q6-20020a258206000000b00d7821e0c06dmr18532493ybk.64.1694072708967; Thu, 07
 Sep 2023 00:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230901113458.13323-1-brgl@bgdev.pl>
In-Reply-To: <20230901113458.13323-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Sep 2023 09:44:57 +0200
Message-ID: <CACRpkdbDkBUhP-ZaWaErr3MqjGgSyei0EUD7PR3URs6h_ZWMUQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: remove unnecessary extern specifiers from the
 driver header
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023 at 1:35=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> 'extern' doesn't do anything for function declarations. Remove it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Right I guess it should never be in headers, the one place
where is makes sense is if you're suddenly exporting something
in a C file, such as to expose it to assembly.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
