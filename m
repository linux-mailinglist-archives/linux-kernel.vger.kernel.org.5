Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47733793D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjIFNC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjIFNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:02:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C66110E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:02:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so2986173b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694005359; x=1694610159; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQsTGl3+Eqh8ofFG3E7a6oVL6W+DJ0mz15j0T493ubg=;
        b=iirTonzEJ/RiPegIN/Bnv/m+mU0IIph+0lvRBPbUnImWM8NloQvRpZDcoDRkHnWf/i
         RprVz+hpTrch5bE37HhmiXJjyC92UuEjcgzQCpD0h7b1xjZehHVqae0Rns391QVGZz1I
         EvBn1k2rCOeWw932crXwAai2jjaxJqAOrUQCYY4OrbWS36oPGR6N0NRknby+VOZNlagO
         s0SarWEfYxbE/hliM35HYTflcIFvJVUNxbcVdIANTEBujAsOKI+DOZtOT1hhtm/FeXvN
         3DP756BnOWjChYQD9t47lZSLNXzlZtsP7C8ExjU7QAosgOrrUzcBKuaU5VOFLYuD/vvL
         g3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694005359; x=1694610159;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQsTGl3+Eqh8ofFG3E7a6oVL6W+DJ0mz15j0T493ubg=;
        b=ANn9V8siedtbMpdu5uajjGqOMI8JDAS/G2VPtcpmw6XNZJQ074+PTRqHKF4UbWzuk8
         TAbauVz5BPkkHaCaFl/GqMClNUle1QGYrbUNDRlaUcRhlL8/S/2B2BO+Gvj2qjdxEWYQ
         srR4kWgfX0xlUMG9HWZh8OVzk04B+1hcAtqxboFnF3jLCFd0TEuLI8jtImvBSj5u2ogj
         QtP1iI4mib96KAPfEHWU3j+6T3PUdHl4N1WHXZ1/P9gugypttd/+tCN5GWw/euwlUKxI
         A+8rrsmMyvqt+a+ohHiQ5t74y1RxYMmTFMY6n0nwYsvyJ4RpvvlM6MxYqfm2LSzXY84F
         A0CA==
X-Gm-Message-State: AOJu0Yz5c07T6vmLXhjiWFQ8chOqTjNzBg6Nt9SgD4qlT1t6leNrNmyx
        Ye/V7cQuEAKOU0ndO8kMhNqR/Q==
X-Google-Smtp-Source: AGHT+IEcMCeoZQMFYj68Y9qGshts5Ugye780JxuFDp52HtImzvXKsQ1OEjGhmMlAwwLcyTIvb+vG/Q==
X-Received: by 2002:a05:6a00:3983:b0:68c:3f2:5ff9 with SMTP id fi3-20020a056a00398300b0068c03f25ff9mr17119847pfb.7.1694005358807;
        Wed, 06 Sep 2023 06:02:38 -0700 (PDT)
Received: from [172.20.5.224] (076-053-041-226.inf.spectrum.com. [76.53.41.226])
        by smtp.googlemail.com with ESMTPSA id e4-20020aa78c44000000b0068be216b091sm10806039pfd.24.2023.09.06.06.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 06:02:38 -0700 (PDT)
Message-ID: <7d49d791-bea2-e163-d8db-71866cf7713b@linaro.org>
Date:   Wed, 6 Sep 2023 06:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-firmware@kernel.org
Cc:     "dmitry.baryshkov@linaro.org >> Dmitry Baryshkov" 
        <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [GIT PULL, v2] Add soft link for Audio topology firmware for SC8280XP
 X13s platform
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 20d250e3e9093486a5b70daa942ffbaa3bade901:

   Merge branch 'mlimonci/make-dist' into 'main' (2023-09-06 11:15:24 +0000)

are available in the Git repository at:

 
https://git.kernel.org/pub/scm/linux/kernel/git/srini/linux-firmware.git 
sc8280xp-audio-fw-fixes

for you to fetch changes up to 7d94e0fa84701f0c01877c21cf4857f94fd367ab:

   linux-firmware: add link to sc8280xp audioreach firmware (2023-09-06 
05:55:50 -0700)

----------------------------------------------------------------
Srinivas Kandagatla (1):
       linux-firmware: add link to sc8280xp audioreach firmware

  WHENCE | 1 +
  1 file changed, 1 insertion(+)

