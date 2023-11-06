Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47937E2AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjKFR25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjKFR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:28:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88089D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:28:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507975d34e8so6806541e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699291731; x=1699896531; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=db8Zh4Abu5faoaCdMt9TWV6QmQb/F8WUTy+bQPU3MQc=;
        b=Ps55y83fwOaPXHm11m9CZRxEhd6+NKWdzu9KbM6V5jBahZQYEHBwVJh9hudnpUuRYR
         O8WV5XxKKKyxN9XXLxoqL00J2h8CmaUUOn6BrFAhf1Qa32E9CZmN4c8CBJphqs/GJVbD
         vYeyV3/0JyPUGx5v+2L5kkk3FqgV191KBmq4EUiB7rSOAIJ7YP4JpL3Tv/j/5a/4s7Tx
         KjjMOtts64+YBs/4CE+jNq1kxUFu5Ji3rLXALsZe7Jj2ukQdhfInepIbyApB2GE5FLwH
         RsasOfmV2VBRolUxU6TiojrfLWht9cHcd2yVfA0n1VYf0ze4wlmf7oZ+JYqnu9fJdqGJ
         b1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291731; x=1699896531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db8Zh4Abu5faoaCdMt9TWV6QmQb/F8WUTy+bQPU3MQc=;
        b=c53XsRDqojUkDUmqYDWoC+68NdzKP4UIq+yIuWVbztROuGh6PFi9Ih+USg3ztq++RK
         lqmuzrGyJgwjVhynJiVLrw/SMiX43YtyCNqINU93Ub7pwGr7hu5cFffnhSSPvvM0Hv6S
         G6iByxUZSVn3besHwlHQlkq/d1ujkj40ltDGroKua780hIeVRg/eCByY40HjhncNlsdQ
         tiXxj/pV+Ko9HtW+U2Tg3Qx2ldcJAX4bRHl5BVzoQ/rwIhUoMBtVq8qzu9tve0xxVVr6
         eWgIPLy9nlAIxhAM5YQy8oans2SbwNpMCrzveAEH5M5NqBpF4y2sesfXlor3Pdd/RnG9
         YOAA==
X-Gm-Message-State: AOJu0YzZrENb/TKxogn7ZoI2PWC2W7xiZF9OWYffeeH/TSlQlKLWy2MW
        nYGKUAmFK6l+9KkOidAMY2D4VQ==
X-Google-Smtp-Source: AGHT+IGVc2qIc81RQlGlT4pmSq0ObeFqCZI/Fi3l/PYL3rpY2cuD5M1nPo+vSb475USTZu6cfPbOyA==
X-Received: by 2002:a05:6512:1586:b0:509:1ecb:5a04 with SMTP id bp6-20020a056512158600b005091ecb5a04mr23476416lfb.19.1699291730643;
        Mon, 06 Nov 2023 09:28:50 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d400b000000b0032179c4a46dsm136258wrp.100.2023.11.06.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:28:49 -0800 (PST)
Date:   Mon, 6 Nov 2023 17:28:48 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Yuran Pereira <yuran.pereira@hotmail.com>
Subject: [GIT PULL] kgdb changes for v6.7
Message-ID: <20231106172848.GA27605@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.7-rc1

for you to fetch changes up to 23816724fdbd47c28bc998866fd7bc5ad9f0e535:

  kdb: Corrects comment for kdballocenv (2023-11-06 17:13:55 +0000)

----------------------------------------------------------------
kgdb patches for 6.7

Just two patches for you this time!

 * During a panic, flush the console before entering kgdb. This makes
   things a little easier to comprehend, especially if an NMI backtrace
   was triggered on all CPUs just before we enter the panic routines.
 * Correcting a couple of misleading (a.k.a. plain wrong) comments.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Douglas Anderson (1):
      kgdb: Flush console before entering kgdb on panic

Yuran Pereira (1):
      kdb: Corrects comment for kdballocenv

 kernel/debug/debug_core.c   | 3 +++
 kernel/debug/kdb/kdb_main.c | 7 +++----
 2 files changed, 6 insertions(+), 4 deletions(-)
