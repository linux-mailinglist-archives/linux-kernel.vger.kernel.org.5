Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36977A285
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHLUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjHLUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:36:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DE210E3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:36:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so5094224e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691872599; x=1692477399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mof/hffZLA4KI3hKPptzkGvwOjVO9DAGejVCTyTJPQ=;
        b=TwSNg/pt00lgCC3g3V82CeM8l16mFh4SbmdIz+e2rlF90cPhNAiMFpsLPtJ1Rhh2Wc
         egJfYZdolKKK4nWpElFpeIupolJRA8MHPTDYkuQV5ekCguMDVW0E5YR+YXxPTb1NXUDw
         SHjY0rre/0p0fTi0wjcM4Graed7sV7o0orGgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691872599; x=1692477399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mof/hffZLA4KI3hKPptzkGvwOjVO9DAGejVCTyTJPQ=;
        b=NFnfDiJxgksn9oxDNYXrAEQwEBa90ap8lfrBzKvI7uuJKFj9VHKfuxAY15vcasQNKs
         Nr72gEQS2CY4qZQP2CZTQULEC0RyF1PbWWbVryYW6Lg2vqD1XmKD9IP14GL8K6m2FTHB
         3n6iV4ViTuCaVWqe0fD0QMJnoW4OOMMU06BOxv8rUmHqkIGoY/O7OTg/cy6Y863/lmRA
         XmZTgvN6G3KhsxBdUhvzjQhRGii0eDPF9NaGpitLpFZbyQwGBVscYgBILADVNHTCsXV+
         WVawsPNBqI80G98c0rNqc6ngSo34jYxuhFztwnsRsXWQlpcbM35HXNw8xynXHA43RgRr
         k+Tw==
X-Gm-Message-State: AOJu0YzX1tYL7aZgVKv3Ah1x+h6vMnYJUx8GM+4ujJn4ydajuI0myVj0
        PzyiLrbyMT2o4rZ8PuzJjr2SnPuteEGTzFjNqMEhK9ty
X-Google-Smtp-Source: AGHT+IG3DZNIlfgAmnNuHZA5ai2hKenUlPWUfaqdoBPXPs1O3AZKrXsFLQdgl48WJOqZOZp87h4Vew==
X-Received: by 2002:a19:910c:0:b0:4fe:629:9265 with SMTP id t12-20020a19910c000000b004fe06299265mr3434883lfd.20.1691872599291;
        Sat, 12 Aug 2023 13:36:39 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id m14-20020aa7d34e000000b0052239012c65sm3637745edr.82.2023.08.12.13.36.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 13:36:38 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-317716a4622so2728232f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:36:38 -0700 (PDT)
X-Received: by 2002:adf:f488:0:b0:319:664a:aff5 with SMTP id
 l8-20020adff488000000b00319664aaff5mr2050063wro.37.1691872598235; Sat, 12 Aug
 2023 13:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691865526.git.dsterba@suse.com>
In-Reply-To: <cover.1691865526.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Aug 2023 13:36:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Message-ID: <CAHk-=whBQ2dEE2Dsq6XOxsxnSPEiV8jjx7HxaTHKP59dd+9JHA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.5-rc6
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 at 12:20, David Sterba <dsterba@suse.com> wrote:
>
> - space caching hangs fixes to progress stracking, found by test
>   generic/475

I can not parse that sentence. Part of it seems to be just a typo
"stracking", but even with that fixed it just doesn't parse to me.

I tried to make sense of the commit and edited the message to be at
least a bit more legible. Maybe.

              Linus
