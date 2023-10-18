Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF937CD242
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjJRC0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJRC0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:26:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C6F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:26:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a818c1d2c7so80796287b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697595971; x=1698200771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmQBCvJvK5d1WOB4iKyK184pM5sTFuXSh0TpcbnB37c=;
        b=pFXdqFGiMFrvc8dtb3IQRFXXQZD1c8TGs4l3Dt4K0Ll8sM2dHInKA3mIN1xm0lcWb/
         /XDQ0kVnYruySFqckwdFn3KOpTpIk82s2+aW74GtmRfqhlOIbbBaUz5Y90Pnjul5XosD
         SbtgRi7gfVk9/nyN7S5NREc1iimcWzC4ROW7pqBMD60Zyzn7Fp89cArYpdRr+l5euzKp
         u/+dVYMc8jpbbM4HE2hPr+7t+2O/je3A/yLVNy/ZDUaXN4Rkswie4fazUgTTxnb/Z/41
         Di/0txGO03bZNnVSZE9JHxWIeHQQ7M9WXlc/KA6xIV0C7ZF4/SLZluQ+UyrslgR35QKF
         ueVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697595971; x=1698200771;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmQBCvJvK5d1WOB4iKyK184pM5sTFuXSh0TpcbnB37c=;
        b=H75kAVWAD8VR9O6E3+Iw2jj9BFh92mciH09LDTWA+kt3JkuJxo5u2MXvnM4die6ohu
         GrFfNhzCaL3gtDVDIbMOOdKFRmyW9/3cnXpy8ZFnqOgXxzY05zePtijLtEvXLLGAF4Gs
         0C/46yRAXbqklPUdBAcE6XQovO5ih/mrMGyegFh7L5tvrOURSIGgM/bFEmRZDbGvFCw1
         IXk8Zfq+irJXipRZYXiH7SimyPgz61LMhSpGBL32XwZqp1HhA4GhBbwe6rDJK71wxNrp
         EG3YOJ+kbqfcG9wPtbbkr6FrDZkVlttijuQsaWMW8pCvg9j30YnD7m0b5X5IhDEVDSWl
         7CDQ==
X-Gm-Message-State: AOJu0YzuJICfrttF3ehtu2FNoXtALn66fGboOlnFhn2EwZ9MHZQ0i5ys
        WzTI0fYs0UDi2DuTcyiXEa9AkGYcwOs=
X-Google-Smtp-Source: AGHT+IE8Aa991hbMHCUm91l5ewZDXubTwBD48REWwRoatQI5gylfLy4qCSv2bkv8fce1ku7GPvrLIRrAIKc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:987:b0:d9a:c680:893a with SMTP id
 bv7-20020a056902098700b00d9ac680893amr69679ybb.4.1697595971346; Tue, 17 Oct
 2023 19:26:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 17 Oct 2023 19:26:08 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018022608.1807794-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.10.18 - No topic, but still a go
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No official topic for tomorrow, I need to get in touch with Jason about pKVM on
x86 (but we can certainly discuss pKVM if the right people log on).
