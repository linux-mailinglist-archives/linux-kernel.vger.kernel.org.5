Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19BC75BB06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGTXTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:19:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8901724
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:19:03 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668730696a4so923081b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689895143; x=1690499943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibwR2n2ofWT45eqyn7NdkOyxsAPd/bEJkQ0/gWWZPag=;
        b=lXzYCfCVbZ0XFYr4h1U2cA+eanuunlakdjkGeq0zjbSuUw92kuJhjFPvqvehuVM/MR
         d6dOtACrgZmq8zypv+uqPq27NBSop8KuKAXQi67hPm6KDQofw6Yw0FXh6k9v2DvsE86X
         +nczzNvFdpB+JoZriycHeOUDYK3ot62KqY8Vl2sKo6vyYx+5c7vKJ3uH2W5qhIrVkqbC
         FZTbUZVOgEAoGKoluTWSJ2gVKi4phOzNoClt0OAILWaUHGMYWP4KBtxtGvbNjSQ9RwnI
         LkM4RtiLcmFhEMj+9v5MKT+ezh7OeqI+otg//ZyvMXzGEBxQ4MIUm67RjBehPHBgORLM
         avow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689895143; x=1690499943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibwR2n2ofWT45eqyn7NdkOyxsAPd/bEJkQ0/gWWZPag=;
        b=WEl+nLk5Ue9q0T6WUdQH0ebsbpzSXMiGMOs/GOkrwf6AhdqMz7GWrGAe3u1J+seOxv
         XKV+2bdIDgevO/FxCX0H5xUSQmHw6FpDOjK1/xPrUuSWH447rcCJaaUFxClQutskz1dm
         GcFLL80RFHFM9c+Jn+EZ3bD0Uitoa0DUgsZNcNanWGfz0y2NKli+fgNT5DA8xYyM7a8I
         n3P0APmb8cwXIvJjED+D6q1qsVEhX7nfyEU/5ri2jGuT1u7nhSYt6VRQVEEU9G+4Oz7C
         UUPFtywRVZskgvnuPXK6FdE+uvbcJ548raBuUjtw/bVhYNMkioUMuDfibxfAX5a4BQdV
         iIbw==
X-Gm-Message-State: ABy/qLaUatg6xyRBZw1OE/76EV4Tjr33YzhsneUNvM+3m48jYGz4/aZP
        UHd1SQAleplWnHSlAoMhS6E=
X-Google-Smtp-Source: APBJJlFUvtKV9g3xN8yZiX1eceYAxHrBp30rIaSA9fDoBvJ552sVhZUdbrWXiZ8RM+whGFBzTee4pQ==
X-Received: by 2002:a05:6a00:814:b0:668:7292:b2c2 with SMTP id m20-20020a056a00081400b006687292b2c2mr321769pfk.2.1689895143276;
        Thu, 20 Jul 2023 16:19:03 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-98-231.dynamic-ip.hinet.net. [36.228.98.231])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b00682562bf477sm1708783pfi.82.2023.07.20.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:19:02 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     sven@svenpeter.dev
Cc:     alyssa@rosenzweig.io, asahi@lists.linux.dev, iommu@lists.linux.dev,
        joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marcan@marcan.st,
        minhuadotchen@gmail.com, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH] iommu/apple-dart: mark apple_dart_pm_ops static
Date:   Fri, 21 Jul 2023 07:18:59 +0800
Message-Id: <20230720231859.3699-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f176c331-f8cf-4a44-8ada-7d9c958b17ca@app.fastmail.com>
References: <f176c331-f8cf-4a44-8ada-7d9c958b17ca@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

>On Thu, Jul 20, 2023, at 00:20, Min-Hua Chen wrote:
>> This patch fixes the following sprse warning:
>
>typo: sparse

thanks for catching this.

>>
>> drivers/iommu/apple-dart.c:1279:1: sparse: warning: symbol 
>> 'apple_dart_pm_ops' was not declared. Should it be static?
>>
>> No functional change intended.
>>
>> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>> ---
>
>Acked-by: Sven Peter <sven@svenpeter.dev>

I'll submit v2 with your Acked-by tag.

thanks,
Min-Hua

>Thanks,
>
>
>Sven

