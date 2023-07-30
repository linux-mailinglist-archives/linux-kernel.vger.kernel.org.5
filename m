Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22476837F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 04:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG3Clu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 22:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3Clt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 22:41:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7E2D47;
        Sat, 29 Jul 2023 19:41:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb893e6365so21204715ad.2;
        Sat, 29 Jul 2023 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690684908; x=1691289708;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAiaID6w1L7IDF4pZp9zfrtsyHgijsW1Y/7VAznx6cY=;
        b=EuS25bqI/gdh/aViCI9NX1VTpgUw8o1S+MN+jO0vY/GVNfOY+Gyj4X48Kn63ZDTeli
         y7mWBYVCuyiUNN09nyTrbr8mQuuwBFu9Cmj7f3jyKpSI7DSVxYTif31xz1Iq7dvtk4g9
         D0MCaGNLPmAH/QLfwNgLfUNqug8XEHVlQIxgUIiNJZP9MgkvfVhy/Rho3+E1NNWvBd0w
         iqj6dkadE/1XAszud6/cDAL+DSwtl5v+YXkXvS/bHeTAQyKSDMJO61mEZjMUqxSulvwY
         kR388w0dLZoRaxQcH8NAmWZgnI2W5uq7LswLHckcvn7XNC3gq5UEBfEQFno/x0ZdvSxX
         V8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690684908; x=1691289708;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAiaID6w1L7IDF4pZp9zfrtsyHgijsW1Y/7VAznx6cY=;
        b=aZTuxu+f81mKvsvPrVbovVsRxOFxUFn2v18IyknpwWTz+Mm56qa6qC1xJO3jJSllDj
         BtejeBgQV6Z/r+U4c/bibzbulauRCFkxQzFXumNvM6VFlyBTZxEb7Ig7dv4M4EAKEU6n
         Zj/wYuAi299ZjtzbgKOkh8MHRMkJ0Q0efRMmVh2LH79wfrb6KJdgxBlOmPLegsc7pQz3
         kZsb9l2Q0qHPrW6drr84ko/EHMgR9jGbMa+H7a1jDKFI8JwVH7wRTKsH5W9L18ei6kWr
         RA3M366DRXsYBJAJ3tqPbLAqRdC08XQxoGxwR3CGsdryIQZfDYFW2XV9LGT+a3hL8uE2
         KNvg==
X-Gm-Message-State: ABy/qLbNC1P/W1hznun05lWeF+/d5+ZoWKPvNJ/mOHyL++vSJmMwziGO
        jajcKoInfN2hSK53u5t9YoE=
X-Google-Smtp-Source: APBJJlFnfFzSE3di4bhKDbvhJVvGN9MhEqLfHgyjFDntNOf917WPORB5Hu9T0YH8iLOVwImfCCPjTA==
X-Received: by 2002:a17:902:7242:b0:1b8:e2a:9ede with SMTP id c2-20020a170902724200b001b80e2a9edemr5433751pll.25.1690684907836;
        Sat, 29 Jul 2023 19:41:47 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id cx3-20020a17090afd8300b002681deec24csm5943281pjb.20.2023.07.29.19.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 19:41:47 -0700 (PDT)
Message-ID: <bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com>
Date:   Sun, 30 Jul 2023 09:41:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Guilhem Lettron <guilhem@lettron.fr>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        ACPI Asus <acpi4asus-user@lists.sourceforge.net>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 6.5 - 6.4.7 Regression : ASUS UM5302TA Keyboard don't work
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

> On a kernel 6.4.5 and less, the keyboard is working fine.
> 
> Beginning with 6.5 rc1 and 6.4.7 any key don't respond.
> 
> [    0.668850] input: ASUE140D:00 04F3:31B9 Keyboard as /devices/platform/AMDI0010:01/i2c-1/i2c-ASUE140D:00/0018:04F3:31B9.0001/input/input5
> ...
> [    1.930328] input: ASUE140D:00 04F3:31B9 Keyboard as /devices/platform/AMDI0010:01/i2c-1/i2c-ASUE140D:00/0018:04F3:31B9.0001/input/input13

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.4..v6.5-rc1 https://bugzilla.kernel.org/show_bug.cgi?id=217726
#regzbot title: ASUE140D:00 04F3:31B9 doesn't respond to input

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217726

-- 
An old man doll... just what I always wanted! - Clara
