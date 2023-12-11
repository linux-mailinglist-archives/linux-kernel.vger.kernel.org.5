Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B184B80C749
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjLKKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjLKKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:52:51 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C79F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:52:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so2149397a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291977; x=1702896777; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dy0Zb8GZwtRwUsfyN7YDaLjZK7xM4pji8PYYJ7g0zJs=;
        b=DOEktdAFFTbgeH7ZOC4q8gvH/Gfa/YU7Dr+QKq3PRcXOY/q+4JZH3w0Liaa3re1MUF
         bM+8Ii0J8QqiXHdIzalQw9Tg+L0/rU0P93LFCKgd+w0BrrtspqTJTEn+up2INvvZe4ed
         NAxwXQ+UpmN8REasM1AQ0va63P9IWxNaiSPPlhNcXyrBpkxMk2olGkV3k9+ogsteQmDR
         KK+dYmfBMWh4DbG/8cVr3zM55KIIOUJGHXBFc8nXDwCgNVf8oe7EYl0wxTaO8M7C6Vh6
         GeWvCBrQChBdAVBfELyWA399Aw3pJNVYy3bMJpfD7+4YQp1r0UfJKUO4td0LySH9OduT
         d09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291977; x=1702896777;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dy0Zb8GZwtRwUsfyN7YDaLjZK7xM4pji8PYYJ7g0zJs=;
        b=PR8XARtlz4T3wTVPgroghTlNKZWqwclTkz1D4Kdo2E/Oksoie71GB2H8UzOXidsbOm
         26b5Zu3JRRHFOwYeZRmtFW+tZRDLlykN+Ae3rxuvTKZXE+BwJksuk4atIDG9HQsrybpN
         BC2O+xm5TYhATm52u32GD7lXin2XZ8GzU7kOGDeLn6L/NLD222iCta97QyjYgCHmMGXj
         S0QODqgaxFkqiIJW8SJhQmYGW5cuy4CEWHTWY6Ltx0yKIF/xBdVKTkRqPn9zc7kVI8o7
         rSSFyDnfa4QC5AleF5UvZojvRxC9q3j1I7GYyeEtdPDbyAOxzBN1oXfgxTL8T/Us4fGa
         5eEA==
X-Gm-Message-State: AOJu0YxrGyOjfzsFg0q/yKrw/BpssClxri0l/jqlN3dxXTxZvUbZRrAZ
        DAb7XETka0hk2Tj0DkZAtVGjew==
X-Google-Smtp-Source: AGHT+IGlfs9NOB4Bdlr8Do475taU6StZskH8gQC08vA1+lCvO27M00ERC6HaYrxRCQlP8keYAbBjFA==
X-Received: by 2002:a05:6a20:394a:b0:18c:ab4:f6c9 with SMTP id r10-20020a056a20394a00b0018c0ab4f6c9mr2003960pzg.56.1702291977599;
        Mon, 11 Dec 2023 02:52:57 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a5300b002802a080d1dsm7302776pjl.16.2023.12.11.02.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:57 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:52:49 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE FF-A asynchronous notifications for 6.8
Message-ID: <20231211105249.GA587253@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches that enables asynchronous notifications in
OP-TEE FF-A driver. This pull request is on top of the
"system_thread_for_v6.8" pull request to avoid a merge conflict.

Thanks,
Jens

The following changes since commit 4b391c9c37646f25118355f414b9e6d9fefe782f:

  firmware: arm_scmi: optee: use optee system invocation (2023-11-17 15:48:03 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/ffa-notif-for-v6.8

for you to fetch changes up to d0476a59de064205f4aaa8f7c6d6f32bc28a44d4:

  optee: ffa_abi: add asynchronous notifications (2023-11-17 15:55:41 +0100)

----------------------------------------------------------------
OP-TEE: asynchronous notifications with FF-A

Add support for asynchronous notifications in the OP-TEE FF-A driver. This
is the FF-A counterpart to the asynchronous notifications already
available in the OP-TEE SMC ABI.

----------------------------------------------------------------
Jens Wiklander (2):
      optee: provide optee_do_bottom_half() as a common function
      optee: ffa_abi: add asynchronous notifications

 drivers/tee/optee/call.c          | 31 ++++++++++++-
 drivers/tee/optee/ffa_abi.c       | 93 +++++++++++++++++++++++++++++++++++++--
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++++--
 drivers/tee/optee/optee_private.h |  9 +++-
 drivers/tee/optee/smc_abi.c       | 36 ++-------------
 5 files changed, 155 insertions(+), 42 deletions(-)
