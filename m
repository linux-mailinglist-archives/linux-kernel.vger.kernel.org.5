Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1733C786D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjHXLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbjHXLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:04:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE819BD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:04:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5694ee2d0edso3144454a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692875055; x=1693479855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2LQitixiSHLS8leL/ER3WMvjPmS+yTL+Z+t8nOTqARA=;
        b=S/HDB2raylJxU2inVX6uxI8dgukZTrpxjwB8nXRZT7Do0N572T4GskOVmXKN4UyG4v
         I1s4TV0GTmgW2LBEth5eVliQmUNXCQ+9E1pSIFMp4wEZHWT8dOFUsYrmv8vVO//lEx/i
         1tjUzN2Re/Ki4+BWdm9dHlIF4mOlitTCBxr/rMJHL4rsCI69ueY4m47uaPSdDoxeHNkw
         w8shI/68QcnnFe7o5xSVSEQ6U7/d+nWTi8HU0rOV49rhmlDyumAtvhrLwIwOsys1V1E8
         a1HItWbNXG+LxqHp8ETNNPCZT9LSTVQ9K1pWbqese9ImABgzH+Ol8TKc05MD8awvGZ+o
         MyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875055; x=1693479855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LQitixiSHLS8leL/ER3WMvjPmS+yTL+Z+t8nOTqARA=;
        b=F8AwgJaaFWVYH25+uyGrC2LPhZ6eMdyo3ixomcc8WnuoMhagOIsiK8V6qhLqSO9/k5
         sB6sMCPeulfYzsQdFX6nykeXGcoxqtRPzXNmh9s3enkSm0kx1gp/tm4VuoJTNgviFjq8
         11XVSuY+hdEkUlWKOtqWc78x/MJcJomrCn1VD83XFTKYqhlYxmp5bym21UTolbL4ewXr
         loLiRZdmJ+0XznYKJnaUrFyXfXtpE9tGbAQamL7ZllVbTJuDWK2MyzQzGBiVoKVoK0Hw
         Tiu3wvDRPCgXV+4uTNNcWtkytE80n0rxPO9l9Up6nOCeyzG1rlh/YQzlq+nhs1EubD4O
         8BXw==
X-Gm-Message-State: AOJu0Yxmx0UvxUezcCqCj4POFSQIwdvkOOVhsw6vRf2+hIc3Q8zVcRsu
        tvH4uutuakOW5Q3/9CDLfwWR9WY239x/LdVJgt3g28t2pi5AChvs2lG5Vg==
X-Google-Smtp-Source: AGHT+IFOHTG8m8omW/GD8i8ll6VsxJdUWIUkUxRDdKS12bOwD9wJEh7hNQIzBa7nT5wKK4lqBhqA8Wl/NpzAPZP+Ao0=
X-Received: by 2002:a17:90b:3149:b0:268:8e93:644f with SMTP id
 ip9-20020a17090b314900b002688e93644fmr11794870pjb.45.1692875054820; Thu, 24
 Aug 2023 04:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230823141558.957526-1-Naresh.Solanki@9elements.com> <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
In-Reply-To: <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 24 Aug 2023 16:34:05 +0530
Message-ID: <CABqG17gQEa70kEDVVhNkOeM2SYdZ6-gkYfYJUNV+=NzyogK_PA@mail.gmail.com>
Subject: Re: [PATCH] regulator: userspace-consumer: Use atomic operation
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, zev@bewilderbeest.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, 23 Aug 2023 at 20:41, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 23, 2023 at 04:15:57PM +0200, Naresh Solanki wrote:
> > Replace mutexes with atomic operations.
>
> Why?  Generally atomics are more complicated and hard to understand and
> get right.
Since the operations involved here are simple & short & can be managed by
atomic operation.

Regards,
Naresh
