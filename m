Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20FE7655E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjG0OZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjG0OZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:25:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40B2D40;
        Thu, 27 Jul 2023 07:25:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686bea20652so1045121b3a.1;
        Thu, 27 Jul 2023 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690467940; x=1691072740;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFMO1LpHpHTTpjvXoIkQLvxqJltg6buZb3Tzblg91ck=;
        b=r+VDv71c7Nfr8/pVFNsHnVqWMG9Ui5kjeJEEjRHuSgTa5iyOdZ+rsPkla6ehaAlraq
         n2lywEMxethBwJi2lAltm1JyJiLLM5YbfRsVNaGuC4i2FcSe312S8ZPO8uL0vQ987zKF
         i0fN98OmAVhkVHLz8YCDg3tVp0VYPo5p2xGv6n+qbp0GieDG9ZlXdTNcg4S3TEKdArMx
         z/dzyhNFF2tiWWNnG661HpyGRJr6wfS0yb5lA4FeohkSVdA6ZmPbmHebDBJY/QS5c8Tp
         Z4z6tN7LbFo8HjxFQbD44tbJ3CPg+s+gT3uvg1FbGVQTuxMB1ytzBY86lKe2rvB+eThS
         4H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467940; x=1691072740;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFMO1LpHpHTTpjvXoIkQLvxqJltg6buZb3Tzblg91ck=;
        b=IdRKHFCCcjUv9KAsVQafw3W57hBxaHansoWpHbrXTHkFhJrUkV95NeFQ6P6FGO0hGp
         xV/C/aNf75bo7QSkOPf5OT3ecP6Ts7ntR6Pk/fzFiQ3V4U8RddIXSb/StTPyPfDMZyMN
         5EUtJsm7FvfxWw71WDt9wdEYGwx6sceLBprfiM87S8imoDY8zbj6HUnKXy1LzpxtYRPy
         i/DSchM6Aofjadp5s0/NefPTadBNUCSrPp889l8gTRTVwo2ftbyxzis4lQXTkAl5upHO
         oypqXCHBjRQ0XuasZ6PYRJt204ANhsEDqN8rDiRuVwZZkgKZFq3sEdL714/VgP0BATl1
         CEPA==
X-Gm-Message-State: ABy/qLYMJGOJzhfVIiQQynAUXzBIQp1ZzLe0pDFhX3GpjAy0OTqCh+Jx
        AmywJorCdc1EMf2PPx+R2sYLn8GdiYG3mg==
X-Google-Smtp-Source: APBJJlGxStoO7JfUzyQebiraBQzpo6zbBGztVdjJa29qXmyLgC700MfykmnzQyFKsrP1eYgXr2r0yA==
X-Received: by 2002:a05:6a21:3d87:b0:12f:382d:2a37 with SMTP id bj7-20020a056a213d8700b0012f382d2a37mr5925845pzc.15.1690467939679;
        Thu, 27 Jul 2023 07:25:39 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b00682669dc19bsm1535555pfo.201.2023.07.27.07.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:24:41 -0700 (PDT)
Message-ID: <107f05b8-0104-501c-130c-4f89f3f8a628@gmail.com>
Date:   Thu, 27 Jul 2023 21:24:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Goran <goran.brkuljan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: XPS 17 9730 runs significantly warmer on Kernel 6.5-rc3 compared
 to Kernel 6.4.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> On my new XPS 17 9730 laptop, I recently installed the Kernel 6.5-rc3. I noticed, however, that during its operation, the laptop was getting significantly warmer than before. I did some analysis using the 'stress' tool to measure and compare the difference in CPU temperatures between Kernel 6.4.3 and Kernel 6.5-rc3. Here are my results:
> 
> OS: Ubuntu 23.10
> CPU: i7-13700H
> 
> kernel 6.4.3:
>                                                                                                                                                                                         
> Initial CPU temperature:
> coretemp-isa-0000
> Core 0:        +47.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 4:        +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 8:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 12:       +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 16:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 20:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 24:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 25:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 26:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 27:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 28:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 29:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 30:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 31:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Stressing CPU for 30 seconds...
> stress: info: [4858] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
> stress: info: [4858] successful run completed in 30s
> CPU temperature immediately after stress test:
> coretemp-isa-0000
> Core 0:        +67.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 4:        +76.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 8:        +69.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 12:       +77.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 16:       +69.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 20:       +76.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 24:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 25:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 26:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 27:       +68.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 28:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 29:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 30:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 31:       +71.0°C  (high = +100.0°C, crit = +100.0°C)
> Test ended at: Tue Jul 25 01:10:16 PM CEST 2023
> 
> 
> kernel 6.5-rc-3:
> 
> Initial CPU temperature:
> coretemp-isa-0000
> Core 0:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 4:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 8:        +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 12:       +46.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 16:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 20:       +44.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 24:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 25:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 26:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 27:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 28:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 29:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 30:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 31:       +45.0°C  (high = +100.0°C, crit = +100.0°C)
> Stressing CPU for 30 seconds...
> stress: info: [11146] dispatching hogs: 14 cpu, 0 io, 0 vm, 0 hdd
> stress: info: [11146] successful run completed in 30s
> CPU temperature immediately after stress test:
> coretemp-isa-0000
> Core 0:        +84.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 4:        +97.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 8:        +87.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 12:      +100.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 16:       +86.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 20:       +99.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 24:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 25:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 26:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 27:       +83.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 28:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 29:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 30:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
> Core 31:       +89.0°C  (high = +100.0°C, crit = +100.0°C)
> Test ended at: Tue Jul 25 01:05:42 PM CEST 2023
> 
> I tested few times with different setup and CPU temp on 6.5-rc3 is always higher especially when stressing with fewer cores.

See Bugzilla for the full thread.

Goran: On Tuesday, I asked you to perform bisection. Any update on it?

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.4..v6.5-rc3 https://bugzilla.kernel.org/show_bug.cgi?id=217703
#regzbot title: significant temperature increase on XPS 17 9730

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217703

-- 
An old man doll... just what I always wanted! - Clara
