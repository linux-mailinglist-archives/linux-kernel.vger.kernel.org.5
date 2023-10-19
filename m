Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363507CECF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjJSAxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjJSAxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:53:23 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFF118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:53:20 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581e5a9413bso1175553eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697676800; x=1698281600; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNnJoK0eQyjUdDaLupVbntvnEWs5ARntFhwhPi5TPR0=;
        b=QhElK4COH1Ve8fseZtK9uNj7xyJv2XpLDQ3ybbBNYDgRkfEFyUw+2kCyU/E9MQcexA
         9QMP6k+EnG4C+4njaWifsn96tiDnf6iI2UOi4CgYwP7jyI2fmZcYhpV4k+3ewgOm1c3F
         qg5l18B2SqGrdzCyaSPn4i9kDl7R7J7W4N4tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697676800; x=1698281600;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNnJoK0eQyjUdDaLupVbntvnEWs5ARntFhwhPi5TPR0=;
        b=bDIW56RY/qvHn9MF1NpvkCOf0acTQcdtdHt/9goPImMl5xgqBxhLVLmu9hr8DVh8Xr
         ROKc/w50NFkmcd+EKtClmA0GYeu5AXstyX0LAz+ZKvqnvkKS2J+hUXGmD7G5LvfSLmQd
         phn2ZJnFUCX96vewoQJM4nuxGbHzoAC8SpCAHwvMMSqZfueY2UsPrDqSoNQBw6BjpG+e
         RyjWapI/ERJIqrdPQMqeFTjWGg+33qoyYEBgR7NAFjF9Ohjf2H2ZGMLUiRFxll8bOGvY
         nSdsoc5C9FT/nQ3vkjgFwA9BbSKNwGRaINVgjLZ3StsXn303RwR+Tzmp/y4q1AzYlfJW
         muAg==
X-Gm-Message-State: AOJu0YxjMm3qcS2WKA/6v7NM7dRmdquXDWuC2VbkXn2dwhKzbOLoelSi
        Pm5Nrz77o9I6v5cupQ/xax9+6w==
X-Google-Smtp-Source: AGHT+IE3bjvCfc5RshmvqgC4/ONnK5amoSkr7UHQ+q2PmWUT3I0ld8xVZMkJlFGDHwdxyTj+gqyNRA==
X-Received: by 2002:a05:6359:1a8e:b0:166:d494:3de4 with SMTP id rv14-20020a0563591a8e00b00166d4943de4mr668097rwb.3.1697676799943;
        Wed, 18 Oct 2023 17:53:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0068fb8080939sm3956951pfj.65.2023.10.18.17.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:53:19 -0700 (PDT)
Date:   Wed, 18 Oct 2023 17:53:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [GIT PULL] seccomp fix for v6.6-rc7
Message-ID: <202310181752.D9A0B87E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this seccomp fix for v6.6-rc7.

Thanks!

-Kees

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc7

for you to fetch changes up to 31c65705a8cfa5f80d3824c686ab74b0409ee76d:

  perf/benchmark: fix seccomp_unotify benchmark for 32-bit (2023-10-18 17:47:18 -0700)

----------------------------------------------------------------
seccomp fix for v6.6-rc7

- Fix seccomp_unotify perf benchmark for 32-bit (Jiri Slaby)

----------------------------------------------------------------
Jiri Slaby (SUSE) (1):
      perf/benchmark: fix seccomp_unotify benchmark for 32-bit

 tools/arch/x86/include/uapi/asm/unistd_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Kees Cook
