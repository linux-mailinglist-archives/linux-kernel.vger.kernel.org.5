Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C381314E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573210AbjLNNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjLNNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:22:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F35F5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:22:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so120871166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702560159; x=1703164959; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kFNgqKRDC3NjWVK8VqrRNN6lgWk3KBU/xIa7c195zw=;
        b=CIIs3j1EMUaTu3+59Lvc1JJ3ndtpgEorTuc3iZ8c7vxXI31zRQKflNCumRi2AlmUyo
         m17z9kWJqAyObBzYFgjuKn0Dulb+Bk1683F6p3uaR7/sQ4bUmmguwjunmxPRrz8UaL9N
         6hBr/xnK3kFQL7AoBfw7dU+yX71wwaIta5b7w6w1COBbfz7nXpw+fKy/b1Rq7H4MBbOh
         VCMIg8G8bKZv0UGGGAm4LnWT/tUWFfRGfFBn+z2GbnxvK8dpVz/DAG6qQ0OrEnI91r42
         OTeC1bQeE+A672gQfbuVlVqCZBeFB0XA6lEFJt+DWvanMQRAymdMM3Dp8xxI2pvxtCap
         2KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560159; x=1703164959;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kFNgqKRDC3NjWVK8VqrRNN6lgWk3KBU/xIa7c195zw=;
        b=uBRj3h+cTuFSnKpQSGmn++lh8KzDW4lujjisHsYKPATxLgmpwUwx2a49XvRFwvWPqu
         jfQdRbVojM5yGC09S+3exAwdFfdchFnCPCOHq6QuXKC2vkIafb/razIpvPIGck/cyF9r
         s/YI8/2EJYdj6H/STg1IlNABAtFbnqNqNi4WUVBLGrfUROH4obEgv6kfm1IK6VehHUge
         9V3S07XWNmETc3j57Uf4iShAHggTeeEhMB0JUNsL0+l1fFgiBy4lConCj+MJvXXtopwi
         3389s+aDyXWvol/zjkFhenIWYTu1wzWEfjyZrMyUWFSDEBThHUk9PLylS5j+suFtHbxe
         8DrA==
X-Gm-Message-State: AOJu0YyGiXl3L/T0zhn8lVmSAxuUE6OuYEaIDTBKGjiyGWMfYh3zFMYO
        4wN+ise/d9qbdyrgIf/WN1f13sdqkWaquhshEYI=
X-Google-Smtp-Source: AGHT+IE+g9e4kcr5bsiUNaytYbmJ3YVNdtcal3YY4PO91GdiuKEU4m0lMHkZrYuFRLn0lXzE+X5jgQ==
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr8265198ejb.26.1702560159620;
        Thu, 14 Dec 2023 05:22:39 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id vo10-20020a170907a80a00b00a1d17c92ef3sm9357935ejc.51.2023.12.14.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:22:39 -0800 (PST)
Date:   Thu, 14 Dec 2023 14:22:37 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE cleanup for v6.8
Message-ID: <20231214132237.GA3092763@rayden>
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

Please pull these two small patches for the OP-TEE driver that remove a
redundant custom workqueue and add a description of an argument of a
optee_handle_rpc().

Note that this pull request is made on top of optee-supplicant-fix-for-v6.7
7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
which was merged into v6.7-rc5, but in turn was based on top of v6.6. I
did it like this because the Tested-bys where provided in this context.

Thanks,
Jens

The following changes since commit 7269cba53d906cf257c139d3b3a53ad272176bca:

  tee: optee: Fix supplicant based device enumeration (2023-11-03 09:27:20 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-cleanup-for-v6.8

for you to fetch changes up to b19773a1c6c02f5efc35e9f506aeddd2c7d2ac29:

  optee: add missing description of RPC argument reference (2023-12-11 15:02:12 +0100)

----------------------------------------------------------------
OP-TEE cleanup

- Remove a redundant custom workqueue in the OP-TEE driver.
- Fix a missing description of an argument to optee_handle_rpc().

----------------------------------------------------------------
Etienne Carriere (1):
      optee: add missing description of RPC argument reference

Sumit Garg (1):
      tee: optee: Remove redundant custom workqueue

 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/optee_private.h |  2 --
 drivers/tee/optee/smc_abi.c       |  1 +
 3 files changed, 3 insertions(+), 13 deletions(-)
