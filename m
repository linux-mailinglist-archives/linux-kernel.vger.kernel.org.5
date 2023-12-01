Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF7E800033
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbjLAAal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbjLAAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:30:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24703D67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:30:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-286447abfbeso747428a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701390645; x=1701995445; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caGgQN2zt8grZs3U0xbayh8pbJ7WuHPF2boIZk41q/I=;
        b=A1C0I1uKUCVOEs76Ns+Gd/gWQJkllT+bNN/rgiyznsDedGaLDNAlpiPl5+WesK9Joo
         AhLYi1HManUaHmqyRI4eyNGYAjt8cKIvDBqqJSEYH12f5xE6wWnyJ7dhlEhCJRgUCnbm
         RT76l2VQZ5u7jzSsO5xmS+bH8IN4rPPB7WmH7uACHlsTF8XVr4WOw7+CdJ8MGls5/UzQ
         YZoIRDwIlZmKoQbK5dMSt/AaiBrVfc5rneSw1VnlzTbXgMIt5TocU7Wo5CaCPa99MNim
         Q5BJ0Kl2z5QWA+0xY73pfJdrYJGWl8zFPV4Ufb4EY4HgIsNFrTkVp6zhm07aRctRm3Kv
         ZiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701390645; x=1701995445;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=caGgQN2zt8grZs3U0xbayh8pbJ7WuHPF2boIZk41q/I=;
        b=FWPkBRaIhjQhSRsV/JqJqi3ZUh0mga121lmAfVYo5RLJeOX/ZyZCdiVVjhliUQE8ap
         TDykU9viiG45IJXEcrmY0HG1TMqwTmjg/paDsAk/yZVyTo0HLKiVXailL9wWyQY+fZZK
         o7/ry5mtGptAg8l3yUgZuhG/KRyBv/qEZGo8pio0zirj+V9zv66RLyFcUEVmrr7Su36Z
         xKeWtnCxoI74TQOTFgQKAqhsroeIrY3mFn9cwZ7nIbyyHBVfYyG0xMifXWtkHaNDx3yH
         +9TsQg7s1dFJk0oaLWfsA1Tf/EYg31Z/wcmMG0fT+Cfey9rHGdrtHjFX3ZlmEEY8Jh6G
         R8Cw==
X-Gm-Message-State: AOJu0Yyso9HFl5SQ6gkS9UOxo3HgSpWZL0uwG0CaqN5pIZ0GzYaKDDTk
        RFwg3REtcRR1cJgIV9oQEETX/Xk/xtJyxQ==
X-Google-Smtp-Source: AGHT+IGavLSgfLIFqgzeRpJJkSpkkqVUuQDRKrB/Bufnp+gm00i5dOUOGGZIZ3Pf4HupAYvGp4kBGg==
X-Received: by 2002:a17:90a:62cb:b0:286:4827:807d with SMTP id k11-20020a17090a62cb00b002864827807dmr3313646pjs.23.1701390645269;
        Thu, 30 Nov 2023 16:30:45 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090a020c00b0028089fdce19sm2092716pjc.52.2023.11.30.16.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:30:44 -0800 (PST)
Message-ID: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
Date:   Fri, 1 Dec 2023 07:30:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Cc:     Wayne Lin <wayne.lin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Oliver Schmidt <oliver@luced.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up after
 suspend
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since kernel version 6.1.57 I have problems with external monitor wakeup after suspend on Thinkpad X13 AMD Gen2 Notebook.
> 
> Notebook is in docking station with closed lid. Suspend & Resume. The external monitor gets no signal. After randomly typing Ctrl+Alt+Fn for switchung consoles, the monitor at some point gets signal and is usable again.
> 
> It worked with kernel 6.1.56.
> 
> I managed to compile a 6.1.57 kernel and also a 6.1.64 kernel by reverting the changes from commit ec5fa9 "drm/amd/display: Adjust the MST resume flow" (https://github.com/torvalds/linux/commit/ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a?diff=split&w=1?diff=split&w=1) and with this suspend & resume worked like before without any problems.
> 
> I reported this also to the Manjaro's support forum, since I tried this on Manjaro Linux (https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840).

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: ec5fa9fcdeca69 https://bugzilla.kernel.org/show_bug.cgi?id=218211
#regzbot title: MST resume flow adjustment breaks external monitor wakeup after suspend on Thinkpad X13
#regzbot link: https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218211

-- 
An old man doll... just what I always wanted! - Clara
