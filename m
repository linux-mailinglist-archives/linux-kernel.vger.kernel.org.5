Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0880C671
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjLKK0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjLKKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:25:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673E591
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:26:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so7793492a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702290363; x=1702895163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2aeQLk9tLoU8aAvYRhP9s0o8YVupdtuxQZShU2pq18=;
        b=L1I1gYtcRj1TYz8DAJFnW0WLaQngd6FE6R5w23Mjj+utws8+hdZgrbfSWJeVHnUIya
         NbPOCAw4GNzdgRwcxFf0aVwLfzUGsGtUw6nmxC3GfT6x4MVzfrqtac9dME2aS6zIhWZM
         GFIr0nfdBbidi82aoiaogpXX+hzimgDScWp6KacwgK2Zh1pfguzStyyhavqAvsNgB/ak
         cMlhuc+GGJR1hIFyqTirWgQvDs2YYiRCAhPO4rkMJHZ64Fs77DAbZTAia4Z3FciM1tCV
         Y27hnKODEUUiI6ec6epwf0L04deC1qJbmXe/BY02g2YaegkMfzgPBEqQKfosOJcOjsko
         xHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702290363; x=1702895163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2aeQLk9tLoU8aAvYRhP9s0o8YVupdtuxQZShU2pq18=;
        b=kOH9OB7GWEb9FqD56Q/qmEMa6x+TCz63EshrfhVHB3uQj7Epzw1QoD975WXgZlkPp1
         vmr+p3chvC2DUKTUqvV2HUdLODsiOtMfc5IJov68++u/pih23JUmqEFwM28nNXvjg+m+
         WSfcRSqGXmPF7mjq7/zxRIvTBmKkF6YF5a3Vbd6i3Pzod/JazLJOPL5wQB9UFwqhrs2B
         HbUfJIl4bltk9q8ki051dG+osZ0maq1viWJuQjzqJ9MHd3zvNx+MPUF5e7xEDmt5EIEZ
         fGlrz1gdXBYzliXEeBvNPP6o5P3jA5q/6VMlQkgnmRVBINlR5C8icSVHWvJQQJ6pHynO
         FRxA==
X-Gm-Message-State: AOJu0YxGifueMAbTbjNTXbNcZ5TDu+acBiatwwrU7Ky+L9OpNsNwd6B6
        H5KPkYbN6vBllBcjbxJErVJHRnWBZK3AAkJdYEc=
X-Google-Smtp-Source: AGHT+IHnKIDENGCReOWeULMrsPkwpXYOp0bNojasZmK0ptnP+q/0vscN2VYywudbNNMmv4QFdJ40fg==
X-Received: by 2002:a17:907:20aa:b0:a1c:6e3e:4873 with SMTP id pw10-20020a17090720aa00b00a1c6e3e4873mr3407157ejb.43.1702290362869;
        Mon, 11 Dec 2023 02:26:02 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id tf7-20020a1709078d8700b00a1f7852c876sm3647282ejc.185.2023.12.11.02.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:26:02 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:26:00 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE reserved system thread for 6.8
Message-ID: <20231211102600.GA571787@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches that enables SCMI with OP-TEE transport to to
reserve a thread in the secure world to guarentee that requests will not
have to wait for a thread to become available.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/system-thread-for-v6.8

for you to fetch changes up to 4b391c9c37646f25118355f414b9e6d9fefe782f:

  firmware: arm_scmi: optee: use optee system invocation (2023-11-17 15:48:03 +0100)

----------------------------------------------------------------
OP-TEE add reserved system thread

Add support for a reserved system thread in the SMC-ABI of the OP-TEE driver.
SCMI with OP-TEE transport uses this to guarantee that it will always have
a thread available in the secure world.

----------------------------------------------------------------
Etienne Carriere (4):
      tee: optee: system thread call property
      tee: system session
      tee: optee: support tracking system threads
      firmware: arm_scmi: optee: use optee system invocation

 drivers/firmware/arm_scmi/optee.c |   4 ++
 drivers/tee/optee/call.c          | 130 ++++++++++++++++++++++++++++++++++++--
 drivers/tee/optee/core.c          |   5 +-
 drivers/tee/optee/ffa_abi.c       |  14 ++--
 drivers/tee/optee/optee_private.h |  29 ++++++++-
 drivers/tee/optee/smc_abi.c       |  32 +++++++---
 drivers/tee/tee_core.c            |   8 +++
 include/linux/tee_drv.h           |  16 +++++
 8 files changed, 211 insertions(+), 27 deletions(-)
