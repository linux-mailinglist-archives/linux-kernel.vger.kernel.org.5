Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A647DB312
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJ3GDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJ3GDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:03:02 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C12B7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:02:59 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7b652e785dbso1740684241.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698645778; x=1699250578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkvQvRoKugnm9tC1bRof4BrUBBGpF31eP4mmFwkt2H0=;
        b=hjyawQBMn67tMyrUJ4MoX70VEEY+6RqFBMBDaeQFzzIdmrIioG46pAiOle7KPN74oq
         TFegrEGvnrOXd8h7za8KV8bNoLFf/BfZxMhSCcTq13kCFyNHQ60qgsz/6uZqueoWrNVe
         /ej0pkyIwKzXD1L+B1+wANQotEOqNloHzd1V8HELsxiAHAo2sDrEEmwWQW7AjAEe6jz3
         1L9wAOa3IIujm6pa2NDOrRv/kUB7h9JSu5LPtHiFDcOfD+dhkBUdBLT3yNQc61U9SJf7
         +e8oZ2AvZ72O73ZwAMsCUJOhA/CLWAIXBivgSpClS2JPDpjq6mHvoXWIXqn6wsQwUouo
         mwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698645778; x=1699250578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkvQvRoKugnm9tC1bRof4BrUBBGpF31eP4mmFwkt2H0=;
        b=Txp03F0U8wjJTVbOS1R6PzIW4sT669bqn5506NLbYJq3WcpyqfBv/ROXovrKlf5UMh
         k0sL7gIZArBkeV12nuH//QaQRB4r8uhLu1ixJ3Y3JJNY+vZYK6UWEk949Lh0ZRV8JNx3
         RelqIn3DTZC+wD29tDqCcYN4X9RMQbuyeCdNMctbu46aR31m309e7RRxkCGj9TaVhF5a
         9S7qphfeXH4YA8Po5neVa5uRAY0C84hgFjBloTU33K0I9/lDgazVgwYNGcw3+wvHp3qT
         nU2E+DGNNxlp23FdbY6opJfNJMJGiZiyoWvV28h15DFSoQlIwuUgldpNIK6JxQ6VzesC
         MMpg==
X-Gm-Message-State: AOJu0YzxjA2YK2I1s4emCR10sehZbroQgmNMYzLspmRlUu+CLI32cI4i
        CZXkwoHlnRv2bWkFKsRG8rdAmC+94gzsYGE2ttQwuWa/k1VPOVCV
X-Google-Smtp-Source: AGHT+IEwTQjEhqiLi3R6UDbV8zwvUBiOOT/2PPo25ATVNVYSIlbViCz7tPCii/YIPnSK0a5QeC7Me3qiEvU3i1uuKKo=
X-Received: by 2002:a05:6102:4a4:b0:457:b9da:db12 with SMTP id
 r4-20020a05610204a400b00457b9dadb12mr7419748vsa.12.1698645778379; Sun, 29 Oct
 2023 23:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231026080409.4149616-1-jens.wiklander@linaro.org>
In-Reply-To: <20231026080409.4149616-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 30 Oct 2023 11:32:47 +0530
Message-ID: <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This patchset adds support for using FF-A notifications as a delivery
> mechanism of asynchronous notifications from OP-TEE running in the secure
> world. Support for asynchronous notifications via the SMC ABI was added in
> [1], here we add the counterpart needed when using the the FF-A ABI.
>
> Support for FF-A notifications is added with [2] and this patch set is based
> on Sudeeps tree at [3].

It's good to see FF-A notifications support coming through. The good
aspect here is that FF-A uses a common secure world SGI for
notifications and doesn't have to deal with platform specific reserved
SPI for notifications.

From OP-TEE point of view I think most of the secure SGI donation base
would be common, so can we switch the SMC ABI to use this donated
secure world SGI for notifications too?

-Sumit

>
> [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@linaro.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=ffa-updates-6.7
>     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to v1.1")
>
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: provide optee_do_bottom_half() as a common function
>   optee: ffa_abi: add asynchronous notifications
>
>  drivers/tee/optee/call.c          | 31 ++++++++++-
>  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
>  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
>  drivers/tee/optee/optee_private.h |  9 ++-
>  drivers/tee/optee/smc_abi.c       | 36 ++----------
>  5 files changed, 153 insertions(+), 42 deletions(-)
>
>
> base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> --
> 2.34.1
>
