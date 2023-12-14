Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE828131DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444230AbjLNNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573015AbjLNNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:41:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66183D49
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1f8510883aso732778466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702561302; x=1703166102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGt/k/il8qEiARJPttZV9RuEkTEaCs+qP+NKhCHxIf4=;
        b=igrNVLvw5BViaVe0Ne4hJfMV0c8O2xiHxlljg+qwR37NugtR/vsywh2W0qiTojvZj6
         AMi1s0dK6GPFVCi/Hl2URPK5cBnSpIEzF/cuT5d8mMWvYXgUNjcqe0pcLx1BlA8nDRdn
         5sJESFyVrCluvuuFI4FTLHekuekdTmcESbPJqmGB8Or6OCocoaO+cT5C6nVLjXHu8B8O
         WCLp0DIIPuTHg49jQfs1HQp9eDPtr48CkpW3z2XEQtW5yRWaGwrWZzHdhgLie40ltlvF
         hkWwvza07fwAau7W/skj16XbHEbFQ1vtoIu5GLOzXn8lTwB5WCsOEJi/lQwi8Ch6jgV3
         nFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561302; x=1703166102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGt/k/il8qEiARJPttZV9RuEkTEaCs+qP+NKhCHxIf4=;
        b=D1F+VQmacNY+8zEl2qRl1CMkKfH/q7s90IXCm2mNmJZwSjIlGCq/XohhyFExJSdFM6
         k45zTWmiFnfayojpkJTxYWNz0/CdAjwi2NXNWcRM46DHdBkmKMLrS2WNMntMfwbILVIt
         nqI4Y499IdnUMXbtEae17v2YEdPAgx68Gv/2MPx/0RCE6MXk4uQC1IQGS/BKazAb98sD
         I051aEm1X8CyALBeRE5mGYCruWe2gLjIQNmNuqkOxFzMHPuQbfsS9tzVioOC3mVXmyMH
         wZ9zrfzNlU12bx+i32tt8CfJ2UBH0zdBrAPRriqL89yreNkSrw9kt1/cD0cs0E2S4zzs
         8rDQ==
X-Gm-Message-State: AOJu0YzFUeA/B/qS9raRNgnUXfGaFdMtYwsB1XDD9g78T3yU8OnttC37
        yyJ1Lp7UH060wLS2IBkMAklXTg==
X-Google-Smtp-Source: AGHT+IF2cofLvud+LdRS9oONwHq3UkUQF4ckTTVenXO2ry2r2b7XfhqOyw+8A47d6qMRt/XOANCWaQ==
X-Received: by 2002:a17:907:3ac2:b0:a19:d40a:d21f with SMTP id fi2-20020a1709073ac200b00a19d40ad21fmr2105212ejc.235.1702561301850;
        Thu, 14 Dec 2023 05:41:41 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm9276638ejc.182.2023.12.14.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:41:41 -0800 (PST)
Date:   Thu, 14 Dec 2023 14:41:39 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Improved TEE shared buffer support for v6.8
Message-ID: <20231214134139.GA3098718@rayden>
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

Please pull this patch to add vmalloc support for shared buffer
registration with the secure world.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-iov-iter-for-v6.8

for you to fetch changes up to 7bdee41575919773818e525ea19e54eb817770af:

  tee: Use iov_iter to better support shared buffer registration (2023-12-13 07:23:22 +0100)

----------------------------------------------------------------
TEE: improve shared buffer registration compatibility

----------------------------------------------------------------
Arnaud Pouliquen (1):
      tee: Use iov_iter to better support shared buffer registration

 drivers/tee/tee_shm.c | 78 +++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 36 deletions(-)
